/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/electDigit/demuxMuxComparadorVHDL/demuxCase.vhd";
extern char *IEEE_P_2592010699;



static void work_a_0340235373_3563914479_p_0(char *t0)
{
    char t9[16];
    char t11[16];
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned char t8;
    char *t10;
    char *t12;
    char *t13;
    int t14;
    unsigned int t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    static char *nl0[] = {&&LAB4, &&LAB4, &&LAB3, &&LAB4, &&LAB4, &&LAB4, &&LAB4, &&LAB4, &&LAB4};

LAB0:    xsi_set_current_line(42, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (char *)((nl0) + t3);
    goto **((char **)t1);

LAB2:    t1 = (t0 + 2832);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(48, ng0);
    t4 = (t0 + 4542);
    t6 = (t0 + 1192U);
    t7 = *((char **)t6);
    t8 = *((unsigned char *)t7);
    t10 = ((IEEE_P_2592010699) + 4024);
    t12 = (t11 + 0U);
    t13 = (t12 + 0U);
    *((int *)t13) = 0;
    t13 = (t12 + 4U);
    *((int *)t13) = 2;
    t13 = (t12 + 8U);
    *((int *)t13) = 1;
    t14 = (2 - 0);
    t15 = (t14 * 1);
    t15 = (t15 + 1);
    t13 = (t12 + 12U);
    *((unsigned int *)t13) = t15;
    t6 = xsi_base_array_concat(t6, t9, t10, (char)97, t4, t11, (char)99, t8, (char)101);
    t15 = (3U + 1U);
    t16 = (4U != t15);
    if (t16 == 1)
        goto LAB5;

LAB6:    t13 = (t0 + 2912);
    t17 = (t13 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t6, 4U);
    xsi_driver_first_trans_fast_port(t13);
    goto LAB2;

LAB4:    xsi_set_current_line(50, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 4545);
    t6 = ((IEEE_P_2592010699) + 4024);
    t7 = (t11 + 0U);
    t10 = (t7 + 0U);
    *((int *)t10) = 0;
    t10 = (t7 + 4U);
    *((int *)t10) = 2;
    t10 = (t7 + 8U);
    *((int *)t10) = 1;
    t14 = (2 - 0);
    t15 = (t14 * 1);
    t15 = (t15 + 1);
    t10 = (t7 + 12U);
    *((unsigned int *)t10) = t15;
    t5 = xsi_base_array_concat(t5, t9, t6, (char)99, t3, (char)97, t1, t11, (char)101);
    t15 = (1U + 3U);
    t8 = (4U != t15);
    if (t8 == 1)
        goto LAB7;

LAB8:    t10 = (t0 + 2912);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    t17 = (t13 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t5, 4U);
    xsi_driver_first_trans_fast_port(t10);
    goto LAB2;

LAB5:    xsi_size_not_matching(4U, t15, 0);
    goto LAB6;

LAB7:    xsi_size_not_matching(4U, t15, 0);
    goto LAB8;

}


extern void work_a_0340235373_3563914479_init()
{
	static char *pe[] = {(void *)work_a_0340235373_3563914479_p_0};
	xsi_register_didat("work_a_0340235373_3563914479", "isim/demuxCase_isim_beh.exe.sim/work/a_0340235373_3563914479.didat");
	xsi_register_executes(pe);
}
