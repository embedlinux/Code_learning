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

#define XAF_SHMEM_STRUCT_SIZE                12288
#define XAF_SIZEOFPROXY                     2272
#define XAF_SIZEOFHANDLE                    44

typedef const char             *xf_id_t;

/* ...check the API call succeeds */
#define TST_CHK_API(cond, func_name)                                              \
({                                                                                \
    int __ret;                                                                    \
                                                                                  \
    if ((__ret = (int)(cond)) < 0)                                                \
    {                                                                             \
        FIO_PRINTF(stderr,"%s failed, Error code : %d\n\n", func_name, __ret);       \
        xaf_adev_close(p_adev, XAF_ADEV_FORCE_CLOSE);                             \
        return __ret;                                                             \
    }                                                                             \
    __ret;                                                                        \
})

/* ...check null pointer */ 
#define TST_CHK_PTR(ptr, func_name)                                                    \
({                                                                                     \
    int __ret;                                                                         \
                                                                                       \
    if ((__ret = (int)(ptr)) == 0)                                                     \
    {                                                                                  \
        FIO_PRINTF(stderr,"%s failed, Null pointer error : %d\n\n", func_name, __ret);    \
        return XAF_PTR_ERROR;                                                          \
    }                                                                                  \
    __ret;                                                                             \
})
