/*
 * Copyright (c) 2018 NXP USA, Inc.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include <stdio.h>
#include <string.h>

#include "xaf_utils_test.h"
#include "xaf_fio_test.h"

#define XAF_HW

#ifdef XAF_HW
#include "fsl_i2s.h"
#include "fsl_i2s_dma.h"
#endif

/*******************************************************************************
 * Definitions
 ******************************************************************************/
#define TICK_CYCLES       (10000)
#define CLK_FREQ      (100000000)

#ifdef XAF_HW_LPCNEXT0
/* MP3 DEC test input stream */
//#include "hihat.mp3.h"
/* AAC DEC test input stream */
//#include "perf_aacplusv1_stereo_56Kbps_48kHz.adts.h"
/* PCM GAIN test input stream */
//#include "sine.pcm.h"
/* global IO attributes for shared memory R/W, to be revised*/
unsigned char *readBuffer = 0;
unsigned int readBufferPtr = 0;
unsigned int readBufferSize = 0;
unsigned char *readBuffer2 = 0;
unsigned int readBufferPtr2 = 0;
unsigned int readBufferSize2 = 0;
unsigned char *writeBuffer =0;
unsigned int writeBufferSize = 0;
unsigned int writeBufferPtr = 0;
void srtm_reset_io_attr(void){readBuffer = 0;readBufferPtr = 0;readBufferSize = 0;readBuffer2 = 0;readBufferPtr2 = 0;writeBuffer =0;writeBufferSize = 0;writeBufferPtr = 0;};
#endif

#ifdef XAF_HW
extern bool b_rec_run;
extern i2s_transfer_t s_TxTransfer;
extern i2s_dma_handle_t g_i2sDmaHandle;
#endif

int audio_frmwk_buf_size;
int audio_comp_buf_size;
/* For ISS simulations below indicators need to be declared as extern*/
unsigned int num_bytes_read, num_bytes_write;
double strm_duration;


#ifdef XAF_PROFILE
    long long tot_cycles, frmwk_cycles, fread_cycles, fwrite_cycles;
    long long dsp_comps_cycles, enc_cycles, dec_cycles, mix_cycles, pcm_gain_cycles, src_cycles,capturer_cycles, renderer_cycles,aac_dec_cycles;
    double dsp_mcps;
#endif

// Set cache attribute to Write Back No Allocate when the last argument is -wbna
void set_wbna(int *argc, const char **argv)
{
    if ( *argc > 1 && !strcmp(argv[*argc-1], "-wbna") ) {
#ifdef __XCC__
        extern char _memmap_cacheattr_wbna_trapnull;

        xthal_set_cacheattr((unsigned)&_memmap_cacheattr_wbna_trapnull);
#endif
        (*argc)--;
    }
}

int print_verinfo(pUWORD8 ver_info[],pUWORD8 app_name)
{
    TST_CHK_PTR(ver_info[0], "print_verinfo");
    TST_CHK_PTR(ver_info[1], "print_verinfo");
    TST_CHK_PTR(ver_info[2], "print_verinfo");

	FIO_PRINTF(stdout, "Audio Framework : %s \n",app_name);
    FIO_PRINTF(stdout, "Build: %s, On: %s %s\n", BUILD_STRING, __DATE__, __TIME__);
    FIO_PRINTF(stdout, "Lib Name        : %s\n", ver_info[0]);
    FIO_PRINTF(stdout, "Lib Version     : %s\n", ver_info[1]);
    FIO_PRINTF(stdout, "API Version     : %s\n", ver_info[2]);

    return 0;
}

static int consume_output(void *p_buf, int buf_length, void *p_output, xaf_comp_type comp_type)
{
#ifdef XAF_HW
    static unsigned char i2sTxbuffer[8192];
#endif
    TST_CHK_PTR(p_buf, "consume_output");

    /*Only write limited buffer till its full, and always return without error */
#ifdef XAF_HW
    if(b_rec_run)
    {
        memcpy(&i2sTxbuffer[0], p_buf, buf_length);
        s_TxTransfer.data = &i2sTxbuffer[0];
        s_TxTransfer.dataSize = buf_length;
        I2S_TxTransferSendDMA(I2S1, &g_i2sDmaHandle, s_TxTransfer);
    }
    else
    {
#ifdef XAF_HW_LPCNEXT0
    if ((writeBufferPtr + buf_length) > writeBufferSize)
        buf_length = writeBufferSize - writeBufferPtr;

    memcpy(&(((unsigned char*)p_output)[writeBufferPtr]), p_buf, buf_length);
    writeBufferPtr += buf_length;
#endif
    }
#else
#ifdef XAF_HW_LPCNEXT0
    if ((writeBufferPtr + buf_length) > writeBufferSize)
    	buf_length = writeBufferSize - writeBufferPtr;

    memcpy(&(((unsigned char*)p_output)[writeBufferPtr]), p_buf, buf_length);
    writeBufferPtr += buf_length;
#else
    TST_CHK_PTR(p_output, "consume_output");

    FILE *fp = p_output;
    fio_fwrite(p_buf, 1, buf_length, fp);
#endif
#endif

    if(comp_type != XAF_ENCODER)
        num_bytes_write += buf_length;

    return 0;
}

int read_input(void *p_buf, int buf_length, int *read_length, void *p_input, xaf_comp_type comp_type)
{
    TST_CHK_PTR(p_buf, "read_input");
    TST_CHK_PTR(read_length, "read_input");

//    FIO_PRINTF(stdout, "read_input from 0x%x buf_length %d to 0x%x, current ptr1 %d ptr2 %d\n", p_input, buf_length, p_buf, readBufferPtr, readBufferPtr2);
#ifdef XAF_HW_LPCNEXT0
    if(!b_rec_run)
    {
        if (p_input == readBuffer2)
        {
            if ((readBufferPtr2 + buf_length) > readBufferSize2)
                buf_length = readBufferSize2 - readBufferPtr2;

            memcpy(p_buf, &(((unsigned char*)p_input)[readBufferPtr2]), buf_length);
            readBufferPtr2 += buf_length;
            *read_length = buf_length;
        }
        else
        {
            if ((readBufferPtr + buf_length) > readBufferSize)
                buf_length = readBufferSize - readBufferPtr;

            memcpy(p_buf, &(((unsigned char*)p_input)[readBufferPtr]), buf_length);
            readBufferPtr += buf_length;
            *read_length = buf_length;
        }
    }
#else
    TST_CHK_PTR(p_input, "read_input");

    FILE *fp = p_input;
    *read_length = fio_fread(p_buf, 1, buf_length, fp);
#endif

    if(comp_type == XAF_ENCODER)
        num_bytes_read += *read_length;

    return 0;
}

static int get_per_comp_size(int size, int num)
{
    int comp_size;

    comp_size = size/num;

    if((comp_size*num) < size)
        comp_size += 1;

    return(comp_size);
}

unsigned short start_xos()
{
	volatile unsigned short  board_id = 0; // no hardware
#ifdef XAF_HW
	//xthal_set_region_attribute((void *)0x18020000, 1024, XCHAL_CA_BYPASS, 0);
    //board_id = *((volatile unsigned short*) (DEVICE_ID + 0x0) );
#endif
    xos_set_clock_freq(CLK_FREQ);

#ifdef __TOOLS_RF2__
    xos_start("main", 7, 0);
#else   // #ifdef __TOOLS_RF2__
    xos_start_main("main", 7, 0);
#endif  // #ifdef __TOOLS_RF2__

#if XCHAL_NUM_TIMERS > 0
    xos_start_system_timer(0, TICK_CYCLES);
#endif

    return board_id;
}

int comp_process_entry(void *arg, int wake_value)
{
    void *p_adev, *p_comp;
    void *p_input, *p_output;
    xaf_comp_status comp_status;
    int comp_info[4];
    int input_over, output_over, read_length;
    void * (*arg_arr)[5];
    xaf_comp_type comp_type;
#ifdef XAF_PROFILE
    clk_t fread_start, fread_stop, fwrite_start, fwrite_stop;
#endif
    TST_CHK_PTR(arg, "comp_process_entry");


    arg_arr  = arg;
    p_adev   = (*arg_arr)[0];
    p_comp   = (*arg_arr)[1];
    p_input  = (*arg_arr)[2];
    p_output = (*arg_arr)[3];
    comp_type = *(xaf_comp_type *)(*arg_arr)[4];

    TST_CHK_PTR(p_adev, "comp_process_entry");
    TST_CHK_PTR(p_comp, "comp_process_entry");

    input_over = output_over = 0;

    TST_CHK_API(xaf_comp_process(NULL, p_comp, NULL, 0, XAF_EXEC_FLAG), "xaf_comp_process");

    while (1)
    {
        if((p_input == NULL)&&(output_over)) break;

        TST_CHK_API(xaf_comp_get_status(NULL, p_comp, &comp_status, &comp_info[0]), "xaf_comp_get_status");

        if (comp_status == XAF_EXEC_DONE) break;

        if (comp_status == XAF_NEED_INPUT && !input_over)
        {
            void *p_buf = (void *) comp_info[0];
            int size    = comp_info[1];
            static int frame_count = 0;

#ifdef XAF_PROFILE
            fread_start = clk_read_start(CLK_SELN_THREAD);
#endif

            TST_CHK_API(read_input(p_buf, size, &read_length, p_input, comp_type), "read_input");
            FIO_PRINTF(stdout, " frame_count:%d\n",++frame_count);

#ifdef XAF_PROFILE
            fread_stop = clk_read_stop(CLK_SELN_THREAD);
            fread_cycles += clk_diff(fread_stop, fread_start);
#endif

            if (read_length)
                TST_CHK_API(xaf_comp_process(NULL, p_comp, (void *)comp_info[0], read_length, XAF_INPUT_READY_FLAG), "xaf_comp_process");
            else
            {
                TST_CHK_API(xaf_comp_process(NULL, p_comp, NULL, 0, XAF_INPUT_OVER_FLAG), "xaf_comp_process");
                input_over = 1;
            }
        }

        if (comp_status == XAF_OUTPUT_READY)
        {
            void *p_buf = (void *) comp_info[0];
            int size    = comp_info[1];

            if (size == 0)
                output_over = 1;
            else
            {
#ifdef XAF_PROFILE
                fwrite_start = clk_read_start(CLK_SELN_THREAD);
#endif

            TST_CHK_API(consume_output(p_buf, size, p_output, comp_type), "consume_output");

#ifdef XAF_PROFILE
                fwrite_stop = clk_read_stop(CLK_SELN_THREAD);
                fwrite_cycles += clk_diff(fwrite_stop, fwrite_start);
#endif

            TST_CHK_API(xaf_comp_process(NULL, p_comp, (void *)comp_info[0], comp_info[1], XAF_NEED_OUTPUT_FLAG), "xaf_comp_process");
            }
        }
    }

    return 0;
}

double compute_comp_mcps(unsigned int num_bytes, int comp_cycles, xaf_format_t comp_format, double *strm_duration)
{
    double mcps;
    unsigned int num_samples;
    int pcm_width_in_bytes;

    *strm_duration = 0.0;

    switch(comp_format.pcm_width)
    {
        case 8:
        case 16:
        case 24:
        case 32:
            break;

        default:
            FIO_PRINTF(stdout,"Insufficient data to compute MCPS...\n");
            return 0;
    }

    switch(comp_format.sample_rate)
    {
        case 4000:
        case 8000:
        case 11025:
        case 12000:
        case 16000:
        case 22050:
        case 24000:
        case 32000:
        case 44100:
        case 48000:
        case 64000:
        case 88200:
        case 96000:
        case 128000:
        case 176400:
        case 192000:
            break;

        default:
            FIO_PRINTF(stdout,"Insufficient data to compute MCPS...\n");
            return 0;
    }

    if(comp_format.channels > 32)
    {
        FIO_PRINTF(stdout,"Insufficient data to compute MCPS...\n");
        return 0;
    }

    if( comp_cycles < 0 )
    {
        FIO_PRINTF(stdout,"Insufficient data to compute MCPS...\n");
        return 0;
    }

    pcm_width_in_bytes = (comp_format.pcm_width)/8;
    num_samples = num_bytes/pcm_width_in_bytes;
    *strm_duration = (double)num_samples/((comp_format.sample_rate)*(comp_format.channels));

    mcps = ((double)comp_cycles/((*strm_duration)*1000000.0));

    FIO_PRINTF(stdout, "PCM Width                                    :  %8d\n", comp_format.pcm_width);
    FIO_PRINTF(stdout, "Sample Rate                                  :  %8d\n", comp_format.sample_rate);
    FIO_PRINTF(stdout, "No of channels                               :  %8d\n", comp_format.channels);
    FIO_PRINTF(stdout, "Stream duration (seconds)                    :  %8f\n\n", *strm_duration);

    return mcps;
}


int print_mem_mcps_info(mem_obj_t* mem_handle, int num_comp)
{
    int tot_dev_mem_size, tot_comp_mem_size, mem_for_comp, tot_size;
    double mcps,read_write_mcps;

    /* ...printing memory info*/

    tot_dev_mem_size = mem_get_alloc_size(mem_handle, XAF_MEM_ID_DEV);
    tot_comp_mem_size = mem_get_alloc_size(mem_handle, XAF_MEM_ID_COMP);
    tot_size = tot_dev_mem_size + tot_comp_mem_size;
    mem_for_comp = (audio_frmwk_buf_size + audio_comp_buf_size - XAF_SHMEM_STRUCT_SIZE);
    /* XAF_SHMEM_STRUCT_SIZE is used internally by the framework. Computed as sizeof(xf_shmem_data_t)-XF_CFG_REMOTE_IPC_POOL_SIZE*/



    FIO_PRINTF(stdout,"Memory used by XAF, bytes                                  : %8d \n", tot_size - mem_for_comp);
    FIO_PRINTF(stdout,"Memory allocated by XAF for use by Audio Components, bytes : %8d \n", mem_for_comp);
    FIO_PRINTF(stdout,"Total memory allocated, bytes                              : %8d \n\n", tot_size);

    /* ...printing mcps info*/

#ifdef XAF_PROFILE
    if(strm_duration)
    {
		frmwk_cycles =  frmwk_cycles - (dsp_comps_cycles) - (fread_cycles + fwrite_cycles);
		read_write_mcps = ((double)(fread_cycles + fwrite_cycles)/(strm_duration*1000000.0));
        mcps = ((double)tot_cycles/(strm_duration*1000000.0));
        FIO_PRINTF(stdout,"Total MCPS                                   :  %f\n",mcps);

        FIO_PRINTF(stdout,"DSP component MCPS                           :  %f\n",dsp_mcps);

	    FIO_PRINTF(stdout,"File Read/Write MCPS                         :  %f\n",read_write_mcps);
        mcps = ((double)frmwk_cycles/(strm_duration*1000000.0));
        //mcps = mcps - dsp_mcps;
        FIO_PRINTF(stdout,"Framework MCPS                               :  %f\n\n",mcps);
    }
#endif

    return 0;
}
