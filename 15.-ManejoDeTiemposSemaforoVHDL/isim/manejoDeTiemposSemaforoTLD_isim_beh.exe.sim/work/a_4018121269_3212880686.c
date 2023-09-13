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
static const char *ng0 = "/home/ise/Aprendiendo/VHDL_Verilog/15.-ManejoDeTiemposSemaforoVHDL/contadorTiempo.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3620187407;

unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );
unsigned char ieee_p_3620187407_sub_1306455576397931277_3965413181(char *, char *, char *, char *, char *);
char *ieee_p_3620187407_sub_1496620905533649268_3965413181(char *, char *, char *, char *, char *, char *);


static void work_a_4018121269_3212880686_p_0(char *t0)
{
    char t7[16];
    char t19[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    char *t9;
    int t10;
    unsigned int t11;
    unsigned char t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    unsigned int t20;

LAB0:    xsi_set_current_line(26, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 3232);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(28, ng0);
    t3 = (t0 + 1512U);
    t4 = *((char **)t3);
    t3 = (t0 + 5440U);
    t5 = (t0 + 5471);
    t8 = (t7 + 0U);
    t9 = (t8 + 0U);
    *((int *)t9) = 0;
    t9 = (t8 + 4U);
    *((int *)t9) = 4;
    t9 = (t8 + 8U);
    *((int *)t9) = 1;
    t10 = (4 - 0);
    t11 = (t10 * 1);
    t11 = (t11 + 1);
    t9 = (t8 + 12U);
    *((unsigned int *)t9) = t11;
    t12 = ieee_p_3620187407_sub_1306455576397931277_3965413181(IEEE_P_3620187407, t4, t3, t5, t7);
    if (t12 != 0)
        goto LAB5;

LAB7:    t1 = (t0 + 1352U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t12 = (t2 == (unsigned char)3);
    if (t12 != 0)
        goto LAB8;

LAB9:    xsi_set_current_line(36, ng0);
    t1 = (t0 + 1512U);
    t3 = *((char **)t1);
    t1 = (t0 + 5440U);
    t4 = (t0 + 5486);
    t6 = (t19 + 0U);
    t8 = (t6 + 0U);
    *((int *)t8) = 0;
    t8 = (t6 + 4U);
    *((int *)t8) = 4;
    t8 = (t6 + 8U);
    *((int *)t8) = 1;
    t10 = (4 - 0);
    t11 = (t10 * 1);
    t11 = (t11 + 1);
    t8 = (t6 + 12U);
    *((unsigned int *)t8) = t11;
    t8 = ieee_p_3620187407_sub_1496620905533649268_3965413181(IEEE_P_3620187407, t7, t3, t1, t4, t19);
    t9 = (t7 + 12U);
    t11 = *((unsigned int *)t9);
    t20 = (1U * t11);
    t2 = (5U != t20);
    if (t2 == 1)
        goto LAB10;

LAB11:    t13 = (t0 + 3328);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t8, 5U);
    xsi_driver_first_trans_fast(t13);

LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(29, ng0);
    t9 = (t0 + 5476);
    t14 = (t0 + 3328);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t9, 5U);
    xsi_driver_first_trans_fast(t14);
    goto LAB6;

LAB8:    xsi_set_current_line(32, ng0);
    t1 = (t0 + 5481);
    t5 = (t0 + 3328);
    t6 = (t5 + 56U);
    t8 = *((char **)t6);
    t9 = (t8 + 56U);
    t13 = *((char **)t9);
    memcpy(t13, t1, 5U);
    xsi_driver_first_trans_fast(t5);
    goto LAB6;

LAB10:    xsi_size_not_matching(5U, t20, 0);
    goto LAB11;

}

static void work_a_4018121269_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(41, ng0);

LAB3:    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t1 = (t0 + 3392);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 5U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 3248);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_4018121269_3212880686_init()
{
	static char *pe[] = {(void *)work_a_4018121269_3212880686_p_0,(void *)work_a_4018121269_3212880686_p_1};
	xsi_register_didat("work_a_4018121269_3212880686", "isim/manejoDeTiemposSemaforoTLD_isim_beh.exe.sim/work/a_4018121269_3212880686.didat");
	xsi_register_executes(pe);
}
