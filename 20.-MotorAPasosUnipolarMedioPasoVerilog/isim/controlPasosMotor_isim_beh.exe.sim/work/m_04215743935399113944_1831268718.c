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
static const char *ng0 = "/home/ise/Aprendiendo/VHDL_Verilog/17.-motorAPasosUnipolarMedioPasoVerilog/controlPasosMotor.v";
static unsigned int ng1[] = {1U, 0U};
static unsigned int ng2[] = {0U, 0U};
static unsigned int ng3[] = {8U, 0U};
static unsigned int ng4[] = {12U, 0U};
static unsigned int ng5[] = {2U, 0U};
static unsigned int ng6[] = {4U, 0U};
static unsigned int ng7[] = {3U, 0U};
static unsigned int ng8[] = {6U, 0U};
static unsigned int ng9[] = {5U, 0U};
static unsigned int ng10[] = {7U, 0U};
static unsigned int ng11[] = {9U, 0U};



static void Always_43_0(char *t0)
{
    char t6[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    char *t28;
    char *t29;
    int t30;

LAB0:    t1 = (t0 + 2840U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(43, ng0);
    t2 = (t0 + 3160);
    *((int *)t2) = 1;
    t3 = (t0 + 2872);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(48, ng0);

LAB5:    xsi_set_current_line(49, ng0);
    t4 = (t0 + 1208U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t6, 0, 8);
    t7 = (t5 + 4);
    t8 = (t4 + 4);
    t9 = *((unsigned int *)t5);
    t10 = *((unsigned int *)t4);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t7);
    t17 = *((unsigned int *)t8);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB9;

LAB6:    if (t18 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t6) = 1;

LAB9:    t22 = (t6 + 4);
    t23 = *((unsigned int *)t22);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB10;

LAB11:    xsi_set_current_line(68, ng0);

LAB34:    xsi_set_current_line(69, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1768);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(72, ng0);
    t2 = (t0 + 1928);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);

LAB35:    t7 = ((char*)((ng2)));
    t30 = xsi_vlog_unsigned_case_compare(t5, 3, t7, 3);
    if (t30 == 1)
        goto LAB36;

LAB37:    t2 = ((char*)((ng1)));
    t30 = xsi_vlog_unsigned_case_compare(t5, 3, t2, 3);
    if (t30 == 1)
        goto LAB38;

LAB39:    t2 = ((char*)((ng5)));
    t30 = xsi_vlog_unsigned_case_compare(t5, 3, t2, 3);
    if (t30 == 1)
        goto LAB40;

LAB41:    t2 = ((char*)((ng7)));
    t30 = xsi_vlog_unsigned_case_compare(t5, 3, t2, 3);
    if (t30 == 1)
        goto LAB42;

LAB43:    t2 = ((char*)((ng6)));
    t30 = xsi_vlog_unsigned_case_compare(t5, 3, t2, 3);
    if (t30 == 1)
        goto LAB44;

LAB45:    t2 = ((char*)((ng9)));
    t30 = xsi_vlog_unsigned_case_compare(t5, 3, t2, 3);
    if (t30 == 1)
        goto LAB46;

LAB47:    t2 = ((char*)((ng8)));
    t30 = xsi_vlog_unsigned_case_compare(t5, 3, t2, 3);
    if (t30 == 1)
        goto LAB48;

LAB49:    t2 = ((char*)((ng10)));
    t30 = xsi_vlog_unsigned_case_compare(t5, 3, t2, 3);
    if (t30 == 1)
        goto LAB50;

LAB51:
LAB53:
LAB52:    xsi_set_current_line(85, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1608);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 4);

LAB54:
LAB12:    xsi_set_current_line(88, ng0);
    t2 = (t0 + 1928);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = ((char*)((ng1)));
    memset(t6, 0, 8);
    xsi_vlog_unsigned_add(t6, 3, t7, 3, t8, 3);
    t21 = (t0 + 1928);
    xsi_vlogvar_assign_value(t21, t6, 0, 0, 3);
    goto LAB2;

LAB8:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(49, ng0);

LAB13:    xsi_set_current_line(50, ng0);
    t28 = ((char*)((ng1)));
    t29 = (t0 + 1768);
    xsi_vlogvar_assign_value(t29, t28, 0, 0, 1);
    xsi_set_current_line(53, ng0);
    t2 = (t0 + 1928);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);

LAB14:    t5 = ((char*)((ng2)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t5, 3);
    if (t30 == 1)
        goto LAB15;

LAB16:    t2 = ((char*)((ng1)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t30 == 1)
        goto LAB17;

LAB18:    t2 = ((char*)((ng5)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t30 == 1)
        goto LAB19;

LAB20:    t2 = ((char*)((ng7)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t30 == 1)
        goto LAB21;

LAB22:    t2 = ((char*)((ng6)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t30 == 1)
        goto LAB23;

LAB24:    t2 = ((char*)((ng9)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t30 == 1)
        goto LAB25;

LAB26:    t2 = ((char*)((ng8)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t30 == 1)
        goto LAB27;

LAB28:    t2 = ((char*)((ng10)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t30 == 1)
        goto LAB29;

LAB30:
LAB32:
LAB31:    xsi_set_current_line(66, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1608);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 4);

LAB33:    goto LAB12;

LAB15:    xsi_set_current_line(56, ng0);
    t7 = ((char*)((ng3)));
    t8 = (t0 + 1608);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 4);
    goto LAB33;

LAB17:    xsi_set_current_line(57, ng0);
    t3 = ((char*)((ng4)));
    t5 = (t0 + 1608);
    xsi_vlogvar_assign_value(t5, t3, 0, 0, 4);
    goto LAB33;

LAB19:    xsi_set_current_line(58, ng0);
    t3 = ((char*)((ng6)));
    t5 = (t0 + 1608);
    xsi_vlogvar_assign_value(t5, t3, 0, 0, 4);
    goto LAB33;

LAB21:    xsi_set_current_line(59, ng0);
    t3 = ((char*)((ng8)));
    t5 = (t0 + 1608);
    xsi_vlogvar_assign_value(t5, t3, 0, 0, 4);
    goto LAB33;

LAB23:    xsi_set_current_line(60, ng0);
    t3 = ((char*)((ng5)));
    t5 = (t0 + 1608);
    xsi_vlogvar_assign_value(t5, t3, 0, 0, 4);
    goto LAB33;

LAB25:    xsi_set_current_line(61, ng0);
    t3 = ((char*)((ng7)));
    t5 = (t0 + 1608);
    xsi_vlogvar_assign_value(t5, t3, 0, 0, 4);
    goto LAB33;

LAB27:    xsi_set_current_line(62, ng0);
    t3 = ((char*)((ng1)));
    t5 = (t0 + 1608);
    xsi_vlogvar_assign_value(t5, t3, 0, 0, 4);
    goto LAB33;

LAB29:    xsi_set_current_line(63, ng0);
    t3 = ((char*)((ng11)));
    t5 = (t0 + 1608);
    xsi_vlogvar_assign_value(t5, t3, 0, 0, 4);
    goto LAB33;

LAB36:    xsi_set_current_line(75, ng0);
    t8 = ((char*)((ng1)));
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t8, 0, 0, 4);
    goto LAB54;

LAB38:    xsi_set_current_line(76, ng0);
    t3 = ((char*)((ng7)));
    t7 = (t0 + 1608);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 4);
    goto LAB54;

LAB40:    xsi_set_current_line(77, ng0);
    t3 = ((char*)((ng5)));
    t7 = (t0 + 1608);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 4);
    goto LAB54;

LAB42:    xsi_set_current_line(78, ng0);
    t3 = ((char*)((ng8)));
    t7 = (t0 + 1608);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 4);
    goto LAB54;

LAB44:    xsi_set_current_line(79, ng0);
    t3 = ((char*)((ng6)));
    t7 = (t0 + 1608);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 4);
    goto LAB54;

LAB46:    xsi_set_current_line(80, ng0);
    t3 = ((char*)((ng4)));
    t7 = (t0 + 1608);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 4);
    goto LAB54;

LAB48:    xsi_set_current_line(81, ng0);
    t3 = ((char*)((ng3)));
    t7 = (t0 + 1608);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 4);
    goto LAB54;

LAB50:    xsi_set_current_line(82, ng0);
    t3 = ((char*)((ng11)));
    t7 = (t0 + 1608);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 4);
    goto LAB54;

}


extern void work_m_04215743935399113944_1831268718_init()
{
	static char *pe[] = {(void *)Always_43_0};
	xsi_register_didat("work_m_04215743935399113944_1831268718", "isim/controlPasosMotor_isim_beh.exe.sim/work/m_04215743935399113944_1831268718.didat");
	xsi_register_executes(pe);
}
