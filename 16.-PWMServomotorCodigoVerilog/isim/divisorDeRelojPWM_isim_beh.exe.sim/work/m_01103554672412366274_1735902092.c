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
static const char *ng0 = "/home/ise/Aprendiendo/VHDL_Verilog/17.-PWMServomotorCodigoVerilog/divisorDeRelojPWM.v";
static unsigned int ng1[] = {0U, 0U};
static int ng2[] = {1000000, 0};
static int ng3[] = {1, 0};
static int ng4[] = {2, 0};
static int ng5[] = {0, 0};
static int ng6[] = {46054, 0};
static int ng7[] = {26000, 0};
static unsigned int ng8[] = {1U, 0U};



static void Always_52_0(char *t0)
{
    char t15[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;

LAB0:    t1 = (t0 + 4048U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(52, ng0);
    t2 = (t0 + 4864);
    *((int *)t2) = 1;
    t3 = (t0 + 4080);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(53, ng0);

LAB5:    t4 = (t0 + 280);
    xsi_vlog_namedbase_setdisablestate(t4, &&LAB6);
    t5 = (t0 + 3856);
    xsi_vlog_namedbase_pushprocess(t4, t5);

LAB7:    xsi_set_current_line(54, ng0);
    t6 = (t0 + 2096U);
    t7 = *((char **)t6);
    t6 = (t7 + 4);
    t8 = *((unsigned int *)t6);
    t9 = (~(t8));
    t10 = *((unsigned int *)t7);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB8;

LAB9:    xsi_set_current_line(59, ng0);
    t2 = (t0 + 2816);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng2)));
    memset(t15, 0, 8);
    xsi_vlog_signed_greater(t15, 32, t4, 32, t5, 32);
    t6 = (t15 + 4);
    t8 = *((unsigned int *)t6);
    t9 = (~(t8));
    t10 = *((unsigned int *)t15);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB12;

LAB13:    xsi_set_current_line(61, ng0);

LAB16:    xsi_set_current_line(62, ng0);
    t2 = (t0 + 2656);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng3)));
    memset(t15, 0, 8);
    xsi_vlog_unsigned_add(t15, 32, t4, 26, t5, 32);
    t6 = (t0 + 2656);
    xsi_vlogvar_assign_value(t6, t15, 0, 0, 26);
    xsi_set_current_line(63, ng0);
    t2 = (t0 + 2816);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng3)));
    memset(t15, 0, 8);
    xsi_vlog_signed_add(t15, 32, t4, 32, t5, 32);
    t6 = (t0 + 2816);
    xsi_vlogvar_assign_value(t6, t15, 0, 0, 32);

LAB14:
LAB10:    t2 = (t0 + 280);
    xsi_vlog_namedbase_popprocess(t2);

LAB6:    t3 = (t0 + 3856);
    xsi_vlog_dispose_process_subprogram_invocation(t3);
    goto LAB2;

LAB8:    xsi_set_current_line(54, ng0);

LAB11:    xsi_set_current_line(58, ng0);
    t13 = ((char*)((ng1)));
    t14 = (t0 + 2656);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 26);
    goto LAB10;

LAB12:    xsi_set_current_line(59, ng0);

LAB15:    xsi_set_current_line(60, ng0);
    t7 = ((char*)((ng3)));
    t13 = (t0 + 2816);
    xsi_vlogvar_assign_value(t13, t7, 0, 0, 32);
    goto LAB14;

}

static void Always_74_1(char *t0)
{
    char t10[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    char *t17;
    char *t18;

LAB0:    t1 = (t0 + 4296U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(74, ng0);
    t2 = (t0 + 4880);
    *((int *)t2) = 1;
    t3 = (t0 + 4328);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(75, ng0);

LAB5:    t4 = (t0 + 576);
    xsi_vlog_namedbase_setdisablestate(t4, &&LAB6);
    t5 = (t0 + 4104);
    xsi_vlog_namedbase_pushprocess(t4, t5);

LAB7:    xsi_set_current_line(78, ng0);
    t6 = (t0 + 2976);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng4)));
    memset(t10, 0, 8);
    xsi_vlog_signed_equal(t10, 32, t8, 32, t9, 32);
    t11 = (t10 + 4);
    t12 = *((unsigned int *)t11);
    t13 = (~(t12));
    t14 = *((unsigned int *)t10);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB8;

LAB9:    xsi_set_current_line(83, ng0);

LAB12:    xsi_set_current_line(87, ng0);
    t2 = (t0 + 2976);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng3)));
    memset(t10, 0, 8);
    xsi_vlog_signed_add(t10, 32, t4, 32, t5, 32);
    t6 = (t0 + 2976);
    xsi_vlogvar_assign_value(t6, t10, 0, 0, 32);

LAB10:    xsi_set_current_line(105, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 2976);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    memset(t10, 0, 8);
    xsi_vlog_signed_multiply(t10, 32, t2, 32, t5, 32);
    t6 = (t0 + 3136);
    xsi_vlogvar_assign_value(t6, t10, 0, 0, 32);
    t2 = (t0 + 576);
    xsi_vlog_namedbase_popprocess(t2);

LAB6:    t3 = (t0 + 4104);
    xsi_vlog_dispose_process_subprogram_invocation(t3);
    goto LAB2;

LAB8:    xsi_set_current_line(78, ng0);

LAB11:    xsi_set_current_line(82, ng0);
    t17 = ((char*)((ng5)));
    t18 = (t0 + 2976);
    xsi_vlogvar_assign_value(t18, t17, 0, 0, 32);
    goto LAB10;

}

static void Always_125_2(char *t0)
{
    char t13[8];
    char t14[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;

LAB0:    t1 = (t0 + 4544U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(125, ng0);
    t2 = (t0 + 4896);
    *((int *)t2) = 1;
    t3 = (t0 + 4576);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(126, ng0);

LAB5:    t4 = (t0 + 872);
    xsi_vlog_namedbase_setdisablestate(t4, &&LAB6);
    t5 = (t0 + 4352);
    xsi_vlog_namedbase_pushprocess(t4, t5);

LAB7:    xsi_set_current_line(127, ng0);
    t6 = (t0 + 2816);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng7)));
    t10 = (t0 + 3136);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    memset(t13, 0, 8);
    xsi_vlog_signed_add(t13, 32, t9, 32, t12, 32);
    memset(t14, 0, 8);
    xsi_vlog_signed_leq(t14, 32, t8, 32, t13, 32);
    t15 = (t14 + 4);
    t16 = *((unsigned int *)t15);
    t17 = (~(t16));
    t18 = *((unsigned int *)t14);
    t19 = (t18 & t17);
    t20 = (t19 != 0);
    if (t20 > 0)
        goto LAB8;

LAB9:    xsi_set_current_line(129, ng0);

LAB12:    xsi_set_current_line(130, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2496);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);

LAB10:    t2 = (t0 + 872);
    xsi_vlog_namedbase_popprocess(t2);

LAB6:    t3 = (t0 + 4352);
    xsi_vlog_dispose_process_subprogram_invocation(t3);
    goto LAB2;

LAB8:    xsi_set_current_line(127, ng0);

LAB11:    xsi_set_current_line(128, ng0);
    t21 = ((char*)((ng8)));
    t22 = (t0 + 2496);
    xsi_vlogvar_assign_value(t22, t21, 0, 0, 1);
    goto LAB10;

}


extern void work_m_01103554672412366274_1735902092_init()
{
	static char *pe[] = {(void *)Always_52_0,(void *)Always_74_1,(void *)Always_125_2};
	xsi_register_didat("work_m_01103554672412366274_1735902092", "isim/divisorDeRelojPWM_isim_beh.exe.sim/work/m_01103554672412366274_1735902092.didat");
	xsi_register_executes(pe);
}
