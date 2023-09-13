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

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/ise/Aprendiendo/VHDL_Verilog/17.-PWMServomotorCodigoVHDL/PWMServomotor.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3620187407;

unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );
char *ieee_p_3620187407_sub_2255506239096166994_3965413181(char *, char *, char *, char *, int );


static void work_a_1207689344_2878010372_p_0(char *t0)
{
    char t12[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    int t11;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    char *t16;
    int t17;

LAB0:    xsi_set_current_line(57, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t11 = *((int *)t2);
    t3 = (t11 > 1000000);
    if (t3 != 0)
        goto LAB5;

LAB6:    t1 = (t0 + 992U);
    t3 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB7;

LAB8:
LAB3:    t1 = (t0 + 3960);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(58, ng0);
    t1 = (t0 + 7000);
    t6 = (t0 + 4072);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 26U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(62, ng0);
    t1 = (t0 + 4136);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

LAB7:    xsi_set_current_line(66, ng0);
    t2 = (t0 + 1512U);
    t5 = *((char **)t2);
    t2 = (t0 + 6904U);
    t6 = ieee_p_3620187407_sub_2255506239096166994_3965413181(IEEE_P_3620187407, t12, t5, t2, 1);
    t7 = (t12 + 12U);
    t13 = *((unsigned int *)t7);
    t14 = (1U * t13);
    t4 = (26U != t14);
    if (t4 == 1)
        goto LAB9;

LAB10:    t8 = (t0 + 4072);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t15 = (t10 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t6, 26U);
    xsi_driver_first_trans_fast(t8);
    xsi_set_current_line(67, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t11 = *((int *)t2);
    t17 = (t11 + 1);
    t1 = (t0 + 4136);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = t17;
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

LAB9:    xsi_size_not_matching(26U, t14, 0);
    goto LAB10;

}

static void work_a_1207689344_2878010372_p_1(char *t0)
{
    char *t1;
    int t2;
    unsigned int t3;
    unsigned int t4;
    unsigned int t5;
    unsigned char t6;
    char *t7;
    char *t8;
    int t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;

LAB0:    xsi_set_current_line(79, ng0);
    t1 = (t0 + 1472U);
    t2 = (25 - 25);
    t3 = (t2 * -1);
    t4 = (1U * t3);
    t5 = (0 + t4);
    t6 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, t5);
    if (t6 != 0)
        goto LAB2;

LAB4:
LAB3:    xsi_set_current_line(110, ng0);
    t1 = (t0 + 1832U);
    t7 = *((char **)t1);
    t2 = *((int *)t7);
    t9 = (46054 * t2);
    t1 = (t0 + 4264);
    t8 = (t1 + 56U);
    t11 = *((char **)t8);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    *((int *)t13) = t9;
    xsi_driver_first_trans_fast(t1);
    t1 = (t0 + 3976);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(82, ng0);
    t7 = (t0 + 1832U);
    t8 = *((char **)t7);
    t9 = *((int *)t8);
    t10 = (t9 == 2);
    if (t10 != 0)
        goto LAB5;

LAB7:    xsi_set_current_line(91, ng0);
    t1 = (t0 + 1832U);
    t7 = *((char **)t1);
    t2 = *((int *)t7);
    t9 = (t2 + 1);
    t1 = (t0 + 4200);
    t8 = (t1 + 56U);
    t11 = *((char **)t8);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    *((int *)t13) = t9;
    xsi_driver_first_trans_fast(t1);

LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(86, ng0);
    t7 = (t0 + 4200);
    t11 = (t7 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    *((int *)t14) = 0;
    xsi_driver_first_trans_fast(t7);
    goto LAB6;

}

static void work_a_1207689344_2878010372_p_2(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    char *t4;
    int t5;
    int t6;
    unsigned char t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;

LAB0:    xsi_set_current_line(132, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t3 = *((int *)t2);
    t1 = (t0 + 1992U);
    t4 = *((char **)t1);
    t5 = *((int *)t4);
    t6 = (26000 + t5);
    t7 = (t3 <= t6);
    if (t7 != 0)
        goto LAB2;

LAB4:    xsi_set_current_line(135, ng0);
    t1 = (t0 + 4328);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t8 = (t4 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);

LAB3:    t1 = (t0 + 3992);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(133, ng0);
    t1 = (t0 + 4328);
    t8 = (t1 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB3;

}


extern void work_a_1207689344_2878010372_init()
{
	static char *pe[] = {(void *)work_a_1207689344_2878010372_p_0,(void *)work_a_1207689344_2878010372_p_1,(void *)work_a_1207689344_2878010372_p_2};
	xsi_register_didat("work_a_1207689344_2878010372", "isim/divisorDeRelojPWM_isim_beh.exe.sim/work/a_1207689344_2878010372.didat");
	xsi_register_executes(pe);
}
