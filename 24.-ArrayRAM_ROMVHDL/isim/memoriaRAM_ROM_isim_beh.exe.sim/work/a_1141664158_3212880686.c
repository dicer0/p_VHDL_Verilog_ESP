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
static const char *ng0 = "/home/ise/Aprendiendo/VHDL_Verilog/23.-ArrayRAM_ROMVHDL/memoriaRAM_ROM.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3620187407;

unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );
int ieee_p_3620187407_sub_5109402382352621412_3965413181(char *, char *, char *);


static void work_a_1141664158_3212880686_p_0(char *t0)
{
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    char *t5;
    int t6;
    int t7;
    int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;

LAB0:    xsi_set_current_line(69, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 4400);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(73, ng0);
    t3 = (t0 + 2608U);
    t4 = *((char **)t3);
    t3 = (t0 + 1192U);
    t5 = *((char **)t3);
    t3 = (t0 + 7536U);
    t6 = ieee_p_3620187407_sub_5109402382352621412_3965413181(IEEE_P_3620187407, t5, t3);
    t7 = (t6 + 1);
    t8 = (t7 - 1);
    t9 = (t8 * 1);
    xsi_vhdl_check_range_of_index(1, 8, 1, t7);
    t10 = (8U * t9);
    t11 = (0 + t10);
    t12 = (t4 + t11);
    t13 = (t0 + 4512);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t12, 8U);
    xsi_driver_first_trans_fast(t13);
    goto LAB3;

}

static void work_a_1141664158_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    int t7;
    int t8;
    int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(80, ng0);
    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    xsi_set_current_line(83, ng0);
    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t1 = (t0 + 1192U);
    t5 = *((char **)t1);
    t1 = (t0 + 7536U);
    t7 = ieee_p_3620187407_sub_5109402382352621412_3965413181(IEEE_P_3620187407, t5, t1);
    t8 = (t7 + 1);
    t9 = (t8 - 1);
    t10 = (t9 * 1);
    t11 = (8U * t10);
    t12 = (0U + t11);
    t6 = (t0 + 4640);
    t13 = (t6 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t2, 8U);
    xsi_driver_first_trans_delta(t6, t12, 8U, 0LL);
    xsi_set_current_line(84, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t1 = (t0 + 1192U);
    t5 = *((char **)t1);
    t1 = (t0 + 7536U);
    t7 = ieee_p_3620187407_sub_5109402382352621412_3965413181(IEEE_P_3620187407, t5, t1);
    t8 = (t7 + 1);
    t9 = (t8 - 1);
    t10 = (t9 * 1);
    xsi_vhdl_check_range_of_index(1, 8, 1, t8);
    t11 = (8U * t10);
    t12 = (0 + t11);
    t6 = (t2 + t12);
    t13 = (t0 + 4576);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t6, 8U);
    xsi_driver_first_trans_fast(t13);

LAB3:    t1 = (t0 + 4416);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(81, ng0);
    t1 = (t0 + 1992U);
    t5 = *((char **)t1);
    t1 = (t0 + 1192U);
    t6 = *((char **)t1);
    t1 = (t0 + 7536U);
    t7 = ieee_p_3620187407_sub_5109402382352621412_3965413181(IEEE_P_3620187407, t6, t1);
    t8 = (t7 + 1);
    t9 = (t8 - 1);
    t10 = (t9 * 1);
    xsi_vhdl_check_range_of_index(1, 8, 1, t8);
    t11 = (8U * t10);
    t12 = (0 + t11);
    t13 = (t5 + t12);
    t14 = (t0 + 4576);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t13, 8U);
    xsi_driver_first_trans_fast(t14);
    goto LAB3;

}

static void work_a_1141664158_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;

LAB0:    xsi_set_current_line(91, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    xsi_set_current_line(94, ng0);
    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t1 = (t0 + 4704);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 8U);
    xsi_driver_first_trans_fast_port(t1);

LAB3:    t1 = (t0 + 4432);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(92, ng0);
    t1 = (t0 + 2152U);
    t5 = *((char **)t1);
    t1 = (t0 + 4704);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t5, 8U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB3;

}


extern void work_a_1141664158_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1141664158_3212880686_p_0,(void *)work_a_1141664158_3212880686_p_1,(void *)work_a_1141664158_3212880686_p_2};
	xsi_register_didat("work_a_1141664158_3212880686", "isim/memoriaRAM_ROM_isim_beh.exe.sim/work/a_1141664158_3212880686.didat");
	xsi_register_executes(pe);
}
