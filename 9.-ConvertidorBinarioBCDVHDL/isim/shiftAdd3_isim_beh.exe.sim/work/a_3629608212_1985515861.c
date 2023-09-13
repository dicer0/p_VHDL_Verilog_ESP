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
static const char *ng0 = "C:/electDigit/ConvertidorBinarioBCDVHDL/shiftAdd3.vhd";
extern char *IEEE_P_3620187407;

char *ieee_p_3620187407_sub_767668596_3965413181(char *, char *, char *, char *, char *, char *);


static void work_a_3629608212_1985515861_p_0(char *t0)
{
    char t13[16];
    char t17[16];
    char t21[16];
    char t25[16];
    char t31[16];
    char *t1;
    char *t2;
    int t3;
    int t4;
    char *t5;
    char *t6;
    int t7;
    int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t14;
    unsigned int t15;
    char *t16;
    char *t18;
    char *t19;
    unsigned char t20;
    char *t22;
    unsigned int t23;
    unsigned int t24;
    char *t26;
    char *t27;
    int t28;
    unsigned int t29;
    char *t30;
    char *t32;
    char *t33;
    int t34;
    char *t35;
    char *t36;
    unsigned int t37;
    unsigned int t38;
    char *t39;
    unsigned int t40;
    unsigned int t41;

LAB0:    xsi_set_current_line(50, ng0);
    t1 = (t0 + 4662);
    *((int *)t1) = 0;
    t2 = (t0 + 4666);
    *((int *)t2) = 17;
    t3 = 0;
    t4 = 17;

LAB2:    if (t3 <= t4)
        goto LAB3;

LAB5:    xsi_set_current_line(57, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 1488U);
    t5 = *((char **)t1);
    t9 = (17 - 10);
    t10 = (t9 * 1U);
    t11 = (0 + t10);
    t1 = (t5 + t11);
    memcpy(t1, t2, 8U);
    xsi_set_current_line(63, ng0);
    t1 = (t0 + 4670);
    *((int *)t1) = 0;
    t2 = (t0 + 4674);
    *((int *)t2) = 4;
    t3 = 0;
    t4 = 4;

LAB7:    if (t3 <= t4)
        goto LAB8;

LAB10:    xsi_set_current_line(93, ng0);
    t1 = (t0 + 1488U);
    t2 = *((char **)t1);
    t9 = (17 - 17);
    t10 = (t9 * 1U);
    t11 = (0 + t10);
    t1 = (t2 + t11);
    t5 = (t0 + 2872);
    t6 = (t5 + 56U);
    t12 = *((char **)t6);
    t14 = (t12 + 56U);
    t16 = *((char **)t14);
    memcpy(t16, t1, 10U);
    xsi_driver_first_trans_fast_port(t5);
    t1 = (t0 + 2792);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(52, ng0);
    t5 = (t0 + 1488U);
    t6 = *((char **)t5);
    t5 = (t0 + 4662);
    t7 = *((int *)t5);
    t8 = (t7 - 17);
    t9 = (t8 * -1);
    xsi_vhdl_check_range_of_index(17, 0, -1, *((int *)t5));
    t10 = (1U * t9);
    t11 = (0 + t10);
    t12 = (t6 + t11);
    *((unsigned char *)t12) = (unsigned char)2;

LAB4:    t1 = (t0 + 4662);
    t3 = *((int *)t1);
    t2 = (t0 + 4666);
    t4 = *((int *)t2);
    if (t3 == t4)
        goto LAB5;

LAB6:    t7 = (t3 + 1);
    t3 = t7;
    t5 = (t0 + 4662);
    *((int *)t5) = t3;
    goto LAB2;

LAB8:    xsi_set_current_line(69, ng0);
    t5 = (t0 + 1488U);
    t6 = *((char **)t5);
    t9 = (17 - 11);
    t10 = (t9 * 1U);
    t11 = (0 + t10);
    t5 = (t6 + t11);
    t12 = (t13 + 0U);
    t14 = (t12 + 0U);
    *((int *)t14) = 11;
    t14 = (t12 + 4U);
    *((int *)t14) = 8;
    t14 = (t12 + 8U);
    *((int *)t14) = -1;
    t7 = (8 - 11);
    t15 = (t7 * -1);
    t15 = (t15 + 1);
    t14 = (t12 + 12U);
    *((unsigned int *)t14) = t15;
    t14 = (t0 + 4678);
    t18 = (t17 + 0U);
    t19 = (t18 + 0U);
    *((int *)t19) = 0;
    t19 = (t18 + 4U);
    *((int *)t19) = 2;
    t19 = (t18 + 8U);
    *((int *)t19) = 1;
    t8 = (2 - 0);
    t15 = (t8 * 1);
    t15 = (t15 + 1);
    t19 = (t18 + 12U);
    *((unsigned int *)t19) = t15;
    t20 = ieee_std_logic_unsigned_greater_stdv_stdv(IEEE_P_3620187407, t5, t13, t14, t17);
    if (t20 != 0)
        goto LAB11;

LAB13:
LAB12:    xsi_set_current_line(77, ng0);
    t1 = (t0 + 1488U);
    t2 = *((char **)t1);
    t9 = (17 - 15);
    t10 = (t9 * 1U);
    t11 = (0 + t10);
    t1 = (t2 + t11);
    t5 = (t13 + 0U);
    t6 = (t5 + 0U);
    *((int *)t6) = 15;
    t6 = (t5 + 4U);
    *((int *)t6) = 12;
    t6 = (t5 + 8U);
    *((int *)t6) = -1;
    t7 = (12 - 15);
    t15 = (t7 * -1);
    t15 = (t15 + 1);
    t6 = (t5 + 12U);
    *((unsigned int *)t6) = t15;
    t6 = (t0 + 4683);
    t14 = (t17 + 0U);
    t16 = (t14 + 0U);
    *((int *)t16) = 0;
    t16 = (t14 + 4U);
    *((int *)t16) = 2;
    t16 = (t14 + 8U);
    *((int *)t16) = 1;
    t8 = (2 - 0);
    t15 = (t8 * 1);
    t15 = (t15 + 1);
    t16 = (t14 + 12U);
    *((unsigned int *)t16) = t15;
    t20 = ieee_std_logic_unsigned_greater_stdv_stdv(IEEE_P_3620187407, t1, t13, t6, t17);
    if (t20 != 0)
        goto LAB14;

LAB16:
LAB15:    xsi_set_current_line(88, ng0);
    t1 = (t0 + 1488U);
    t2 = *((char **)t1);
    t9 = (17 - 16);
    t10 = (t9 * 1U);
    t11 = (0 + t10);
    t1 = (t2 + t11);
    t5 = xsi_get_transient_memory(17U);
    memcpy(t5, t1, 17U);
    t6 = (t0 + 1488U);
    t12 = *((char **)t6);
    t15 = (17 - 17);
    t23 = (t15 * 1U);
    t24 = (0 + t23);
    t6 = (t12 + t24);
    memcpy(t6, t5, 17U);

LAB9:    t1 = (t0 + 4670);
    t3 = *((int *)t1);
    t2 = (t0 + 4674);
    t4 = *((int *)t2);
    if (t3 == t4)
        goto LAB10;

LAB17:    t7 = (t3 + 1);
    t3 = t7;
    t5 = (t0 + 4670);
    *((int *)t5) = t3;
    goto LAB7;

LAB11:    xsi_set_current_line(72, ng0);
    t19 = (t0 + 1488U);
    t22 = *((char **)t19);
    t15 = (17 - 11);
    t23 = (t15 * 1U);
    t24 = (0 + t23);
    t19 = (t22 + t24);
    t26 = (t25 + 0U);
    t27 = (t26 + 0U);
    *((int *)t27) = 11;
    t27 = (t26 + 4U);
    *((int *)t27) = 8;
    t27 = (t26 + 8U);
    *((int *)t27) = -1;
    t28 = (8 - 11);
    t29 = (t28 * -1);
    t29 = (t29 + 1);
    t27 = (t26 + 12U);
    *((unsigned int *)t27) = t29;
    t27 = (t0 + 4681);
    t32 = (t31 + 0U);
    t33 = (t32 + 0U);
    *((int *)t33) = 0;
    t33 = (t32 + 4U);
    *((int *)t33) = 1;
    t33 = (t32 + 8U);
    *((int *)t33) = 1;
    t34 = (1 - 0);
    t29 = (t34 * 1);
    t29 = (t29 + 1);
    t33 = (t32 + 12U);
    *((unsigned int *)t33) = t29;
    t33 = ieee_p_3620187407_sub_767668596_3965413181(IEEE_P_3620187407, t21, t19, t25, t27, t31);
    t35 = (t0 + 1488U);
    t36 = *((char **)t35);
    t29 = (17 - 11);
    t37 = (t29 * 1U);
    t38 = (0 + t37);
    t35 = (t36 + t38);
    t39 = (t21 + 12U);
    t40 = *((unsigned int *)t39);
    t41 = (1U * t40);
    memcpy(t35, t33, t41);
    goto LAB12;

LAB14:    xsi_set_current_line(79, ng0);
    t16 = (t0 + 1488U);
    t18 = *((char **)t16);
    t15 = (17 - 15);
    t23 = (t15 * 1U);
    t24 = (0 + t23);
    t16 = (t18 + t24);
    t19 = (t25 + 0U);
    t22 = (t19 + 0U);
    *((int *)t22) = 15;
    t22 = (t19 + 4U);
    *((int *)t22) = 12;
    t22 = (t19 + 8U);
    *((int *)t22) = -1;
    t28 = (12 - 15);
    t29 = (t28 * -1);
    t29 = (t29 + 1);
    t22 = (t19 + 12U);
    *((unsigned int *)t22) = t29;
    t22 = (t0 + 4686);
    t27 = (t31 + 0U);
    t30 = (t27 + 0U);
    *((int *)t30) = 0;
    t30 = (t27 + 4U);
    *((int *)t30) = 1;
    t30 = (t27 + 8U);
    *((int *)t30) = 1;
    t34 = (1 - 0);
    t29 = (t34 * 1);
    t29 = (t29 + 1);
    t30 = (t27 + 12U);
    *((unsigned int *)t30) = t29;
    t30 = ieee_p_3620187407_sub_767668596_3965413181(IEEE_P_3620187407, t21, t16, t25, t22, t31);
    t32 = (t0 + 1488U);
    t33 = *((char **)t32);
    t29 = (17 - 15);
    t37 = (t29 * 1U);
    t38 = (0 + t37);
    t32 = (t33 + t38);
    t35 = (t21 + 12U);
    t40 = *((unsigned int *)t35);
    t41 = (1U * t40);
    memcpy(t32, t30, t41);
    goto LAB15;

}


extern void work_a_3629608212_1985515861_init()
{
	static char *pe[] = {(void *)work_a_3629608212_1985515861_p_0};
	xsi_register_didat("work_a_3629608212_1985515861", "isim/shiftAdd3_isim_beh.exe.sim/work/a_3629608212_1985515861.didat");
	xsi_register_executes(pe);
}
