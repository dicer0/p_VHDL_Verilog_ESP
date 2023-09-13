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
static const char *ng0 = "/home/ise/Aprendiendo/VHDL_Verilog/17.-PWMServomotorControlSwitchesVHDL/PWMControlSwitches.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3620187407;

unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );
unsigned char ieee_p_3620187407_sub_1306455576380142462_3965413181(char *, char *, char *, char *, char *);
char *ieee_p_3620187407_sub_2255506239096166994_3965413181(char *, char *, char *, char *, int );


static void work_a_3552997273_2878010372_p_0(char *t0)
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

LAB0:    xsi_set_current_line(56, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1992U);
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
LAB3:    t1 = (t0 + 4280);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(57, ng0);
    t1 = (t0 + 7776);
    t6 = (t0 + 4392);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 26U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(61, ng0);
    t1 = (t0 + 4456);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

LAB7:    xsi_set_current_line(65, ng0);
    t2 = (t0 + 1832U);
    t5 = *((char **)t2);
    t2 = (t0 + 7672U);
    t6 = ieee_p_3620187407_sub_2255506239096166994_3965413181(IEEE_P_3620187407, t12, t5, t2, 1);
    t7 = (t12 + 12U);
    t13 = *((unsigned int *)t7);
    t14 = (1U * t13);
    t4 = (26U != t14);
    if (t4 == 1)
        goto LAB9;

LAB10:    t8 = (t0 + 4392);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t15 = (t10 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t6, 26U);
    xsi_driver_first_trans_fast(t8);
    xsi_set_current_line(66, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t11 = *((int *)t2);
    t17 = (t11 + 1);
    t1 = (t0 + 4456);
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

static void work_a_3552997273_2878010372_p_1(char *t0)
{
    char t11[16];
    char *t1;
    int t2;
    unsigned int t3;
    unsigned int t4;
    unsigned int t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t12;
    char *t13;
    int t14;
    unsigned int t15;
    unsigned char t16;
    char *t17;
    int t19;
    char *t20;
    int t22;
    char *t23;
    int t25;
    char *t26;
    int t28;
    char *t29;
    int t31;
    char *t32;
    int t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;

LAB0:    xsi_set_current_line(74, ng0);
    t1 = (t0 + 1792U);
    t2 = (12 - 25);
    t3 = (t2 * -1);
    t4 = (1U * t3);
    t5 = (0 + t4);
    t6 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 13U, t5);
    if (t6 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 4296);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(77, ng0);
    t7 = (t0 + 1352U);
    t8 = *((char **)t7);
    t7 = (t0 + 7640U);
    t9 = (t0 + 7802);
    t12 = (t11 + 0U);
    t13 = (t12 + 0U);
    *((int *)t13) = 0;
    t13 = (t12 + 4U);
    *((int *)t13) = 5;
    t13 = (t12 + 8U);
    *((int *)t13) = 1;
    t14 = (5 - 0);
    t15 = (t14 * 1);
    t15 = (t15 + 1);
    t13 = (t12 + 12U);
    *((unsigned int *)t13) = t15;
    t16 = ieee_p_3620187407_sub_1306455576380142462_3965413181(IEEE_P_3620187407, t8, t7, t9, t11);
    if (t16 != 0)
        goto LAB5;

LAB7:
LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(78, ng0);
    t13 = (t0 + 1352U);
    t17 = *((char **)t13);
    t13 = (t0 + 7808);
    t19 = xsi_mem_cmp(t13, t17, 6U);
    if (t19 == 1)
        goto LAB9;

LAB16:    t20 = (t0 + 7814);
    t22 = xsi_mem_cmp(t20, t17, 6U);
    if (t22 == 1)
        goto LAB10;

LAB17:    t23 = (t0 + 7820);
    t25 = xsi_mem_cmp(t23, t17, 6U);
    if (t25 == 1)
        goto LAB11;

LAB18:    t26 = (t0 + 7826);
    t28 = xsi_mem_cmp(t26, t17, 6U);
    if (t28 == 1)
        goto LAB12;

LAB19:    t29 = (t0 + 7832);
    t31 = xsi_mem_cmp(t29, t17, 6U);
    if (t31 == 1)
        goto LAB13;

LAB20:    t32 = (t0 + 7838);
    t34 = xsi_mem_cmp(t32, t17, 6U);
    if (t34 == 1)
        goto LAB14;

LAB21:
LAB15:    xsi_set_current_line(102, ng0);
    t1 = (t0 + 4520);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((int *)t10) = 0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(103, ng0);
    t1 = (t0 + 7880);
    t8 = (t0 + 4584);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t1, 6U);
    xsi_driver_first_trans_fast_port(t8);

LAB8:    goto LAB6;

LAB9:    xsi_set_current_line(82, ng0);
    t35 = (t0 + 4520);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    *((int *)t39) = 12329;
    xsi_driver_first_trans_fast(t35);
    xsi_set_current_line(83, ng0);
    t1 = (t0 + 7844);
    t8 = (t0 + 4584);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t1, 6U);
    xsi_driver_first_trans_fast_port(t8);
    goto LAB8;

LAB10:    xsi_set_current_line(85, ng0);
    t1 = (t0 + 4520);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((int *)t10) = 26419;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(86, ng0);
    t1 = (t0 + 7850);
    t8 = (t0 + 4584);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t1, 6U);
    xsi_driver_first_trans_fast_port(t8);
    goto LAB8;

LAB11:    xsi_set_current_line(88, ng0);
    t1 = (t0 + 4520);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((int *)t10) = 41868;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(89, ng0);
    t1 = (t0 + 7856);
    t8 = (t0 + 4584);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t1, 6U);
    xsi_driver_first_trans_fast_port(t8);
    goto LAB8;

LAB12:    xsi_set_current_line(91, ng0);
    t1 = (t0 + 4520);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((int *)t10) = 57774;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(92, ng0);
    t1 = (t0 + 7862);
    t8 = (t0 + 4584);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t1, 6U);
    xsi_driver_first_trans_fast_port(t8);
    goto LAB8;

LAB13:    xsi_set_current_line(94, ng0);
    t1 = (t0 + 4520);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((int *)t10) = 75633;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(95, ng0);
    t1 = (t0 + 7868);
    t8 = (t0 + 4584);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t1, 6U);
    xsi_driver_first_trans_fast_port(t8);
    goto LAB8;

LAB14:    xsi_set_current_line(97, ng0);
    t1 = (t0 + 4520);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((int *)t10) = 92109;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(98, ng0);
    t1 = (t0 + 7874);
    t8 = (t0 + 4584);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t1, 6U);
    xsi_driver_first_trans_fast_port(t8);
    goto LAB8;

LAB22:;
}

static void work_a_3552997273_2878010372_p_2(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    char *t4;
    int t5;
    char *t6;
    int t7;
    int t8;
    unsigned char t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    xsi_set_current_line(124, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t3 = *((int *)t2);
    t1 = (t0 + 2152U);
    t4 = *((char **)t1);
    t5 = *((int *)t4);
    t1 = (t0 + 2312U);
    t6 = *((char **)t1);
    t7 = *((int *)t6);
    t8 = (t5 + t7);
    t9 = (t3 <= t8);
    if (t9 != 0)
        goto LAB2;

LAB4:    xsi_set_current_line(127, ng0);
    t1 = (t0 + 4648);
    t2 = (t1 + 56U);
    t4 = *((char **)t2);
    t6 = (t4 + 56U);
    t10 = *((char **)t6);
    *((unsigned char *)t10) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);

LAB3:    t1 = (t0 + 4312);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(125, ng0);
    t1 = (t0 + 4648);
    t10 = (t1 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB3;

}


extern void work_a_3552997273_2878010372_init()
{
	static char *pe[] = {(void *)work_a_3552997273_2878010372_p_0,(void *)work_a_3552997273_2878010372_p_1,(void *)work_a_3552997273_2878010372_p_2};
	xsi_register_didat("work_a_3552997273_2878010372", "isim/controlSwitchesPWM_isim_beh.exe.sim/work/a_3552997273_2878010372.didat");
	xsi_register_executes(pe);
}
