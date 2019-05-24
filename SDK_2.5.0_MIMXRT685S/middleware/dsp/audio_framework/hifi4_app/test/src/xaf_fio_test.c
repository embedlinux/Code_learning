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
#include "xaf_fio_test.h"

void *fio_fopen(const char *path, const char *mode)
{
    void * fptr = NULL;
    /* ==== Your code here ===== */

#if defined(FIO_LOCAL_FS)
    fptr = fopen(path,mode);
#elif defined(FIO_REMOTE_FS)
    xaf_fio_args_tx args_tx;
    xaf_fio_args_rx args_rx;
    void *p_rqst, *p_resp;

    p_rqst       = (void *) fio_rqst;
    p_resp       = (void *) fio_resp;
    args_tx.path = path;
    args_tx.mode = mode;

    transmit_pkt(p_rqst,&args_tx,p_resp,&args_rx,FIO_FOPEN);

    return args_rx.fptr;

#else // FIO_BUFFER
    if(strcmp(mode,"rb") == 0){

    	fptr =  inbuff_sine_16_500hz;
    }
    else if(strcmp(mode,"wb") == 0){

        if(gfio_buf_wr.pbase != 0){
            FIO_PRINTF(stdout,"\n Output already open %s \n",path);
        }
        gfio_buf_wr.pbase  = gfio_buf_wr.ptr = (void *)gfio_wr_arr;
        gfio_buf_wr.remlen = WR_BUF_SIZE;
        gfio_buf_wr.flag   = 0;
        fptr = (void *)&gfio_buf_wr;
    }
    else{
        fptr = NULL;
        FIO_PRINTF(stdout,"\n Error opening file %s \n",path);
    }
#endif
    /* ==== Your code here ===== */

    return (void *) fptr;
}

int fio_fclose(void *fp)
{   
    int status;
    /* ==== Your code here ===== */
#if defined(FIO_LOCAL_FS)
    FILE * fptr;
    fptr = (FILE *)fp;
    status = fclose(fptr);    
#elif defined(FIO_REMOTE_FS)
    xaf_fio_args_tx args_tx;
    xaf_fio_args_rx args_rx;
    void *p_rqst, *p_resp;

    p_rqst       = (void *) fio_rqst;
    p_resp       = (void *) fio_resp;
    args_tx.fptr = fp;

    transmit_pkt(p_rqst,&args_tx,p_resp,&args_rx,FIO_FCLOSE);

    return args_rx.retval_fclose;

#else // FIO_BUFFER
    
    status=0;
#endif
    /* ==== Your code here ===== */
    return status;
}

size_t fio_fread(void *ptr, size_t size, size_t nmemb, void *stream)
{
    size_t items;
    size_t size_bytes = size * nmemb; 
    /* ==== Your code here ===== */
#if defined(FIO_LOCAL_FS)
    FILE * fptr;
    fptr = (FILE *)stream;
    items = fread(ptr, size, nmemb, fptr);
#elif defined(FIO_REMOTE_FS)
    xaf_fio_args_tx args_tx;
    xaf_fio_args_rx args_rx;
    void *p_rqst, *p_resp;

    p_rqst       = (void *) fio_rqst;
    p_resp       = (void *) fio_resp;

    args_tx.ptr    = ptr;
    args_tx.size   = size;
    args_tx.nmemb  = nmemb;
    args_tx.stream = stream;

    transmit_pkt(p_rqst,&args_tx,p_resp,&args_rx,FIO_FREAD);

    return args_rx.items_fread;
#else // FIO_BUFFER
#if defined(REND_CAPT_HW_TEST)
    char* inpt_buff_ptr = NULL;
    short* inpt_buff_ptr_500 = NULL;
    short* inpt_buff_ptr_1500 = NULL;
    short* dst_ptr = NULL;
    unsigned int buff_size = sizeof(inbuff_sine_16_500hz)/2;
    unsigned int rem_len = 0;
    unsigned int i =0;
    unsigned int rem_len_tmp =0;

    dst_ptr = (short*)ptr;
    inpt_buff_ptr_500 = (short*)inbuff_sine_16_500hz;
    inpt_buff_ptr_1500 = (short*)inbuff_sine_16_1500hz;
    items = size_bytes/size;
    rem_len = buff_size - offset_hw_buff;/*samples*/
    while(size_bytes > 0)
    {
        *dst_ptr = inpt_buff_ptr_500[offset_hw_buff];
        dst_ptr++;
        *dst_ptr = inpt_buff_ptr_1500[offset_hw_buff];
        dst_ptr++;
        size_bytes = size_bytes - 4;
        offset_hw_buff++;
        if(offset_hw_buff == buff_size)
            offset_hw_buff = 0;
    }

#else

    if((gfio_buf_rd.flag == 1) || (gfio_buf_rd.remlen == 0)){
        FIO_PRINTF(stdout,"\n Input over \n");
        items = 0;
        return items;
    }

    if(size_bytes > gfio_buf_rd.remlen){
        size_bytes    = gfio_buf_rd.remlen;
        gfio_buf_rd.flag   = 1;
    }
    memcpy(ptr,gfio_buf_rd.ptr, size_bytes);

    gfio_buf_rd.ptr += size_bytes;
    gfio_buf_rd.remlen -= size_bytes;

    items = size_bytes/size;

#endif
#endif
    return items;
}

size_t fio_fwrite(const void *ptr, size_t size, size_t nmemb, void *stream)
{
    FILE * fptr;
    size_t items; 
    size_t size_bytes = size * nmemb; 

    fptr = (FILE *)stream;

#if defined(FIO_LOCAL_FS)
    fptr = (FILE *)stream;
    items = fwrite(ptr, size, nmemb, fptr);
#elif defined(FIO_REMOTE_FS)
    {
        xaf_fio_args_tx args_tx;
        xaf_fio_args_rx args_rx;
        void *p_rqst, *p_resp;

        p_rqst       = (void *) fio_rqst;
        p_resp       = (void *) fio_resp;

        args_tx.ptr    = (void *)ptr;
        args_tx.size   = size;
        args_tx.nmemb  = nmemb;
        args_tx.stream = stream;

        transmit_pkt(p_rqst,&args_tx,p_resp,&args_rx,FIO_FWRITE);

        return args_rx.items_fwrite;
    }
#else // FIO_BUFFER
    if((gfio_buf_wr.flag == 1) || (gfio_buf_wr.remlen == 0)){
        FIO_PRINTF(stdout,"\n Input over \n");
        items = 0;
        return items;
    }
    if(size_bytes > gfio_buf_wr.remlen){
        size_bytes    = gfio_buf_wr.remlen;
        gfio_buf_wr.flag   = 1;
    }

    memcpy(gfio_buf_wr.ptr,ptr, size_bytes);

    gfio_buf_wr.ptr += size_bytes;
    gfio_buf_wr.remlen -= size_bytes;

    items = size_bytes/size;
#endif

    return items;
}

#if defined(FIO_REMOTE_FS)
size_t fio_printf(xaf_fio_args_tx *p_args_tx,xaf_fio_args_rx *p_args_rx)
{
	void *p_rqst, *p_resp;
    p_rqst       = (void *) fio_rqst;
    p_resp       = (void *) fio_resp;

	transmit_pkt(p_rqst,p_args_tx,p_resp,p_args_rx,FIO_LOGSTR);
    return p_args_rx->items_printed;
}
#endif

