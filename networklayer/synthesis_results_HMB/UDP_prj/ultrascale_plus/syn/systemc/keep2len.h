// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

#ifndef _keep2len_HH_
#define _keep2len_HH_

#include "systemc.h"
#include "AESL_pkg.h"


namespace ap_rtl {

struct keep2len : public sc_module {
    // Port declarations 3
    sc_out< sc_logic > ap_ready;
    sc_in< sc_lv<64> > keepValue_V;
    sc_out< sc_lv<7> > ap_return;


    // Module declarations
    keep2len(sc_module_name name);
    SC_HAS_PROCESS(keep2len);

    ~keep2len();

    sc_trace_file* mVcdFile;

    sc_signal< sc_lv<7> > zext_ln171_fu_968_p1;
    sc_signal< sc_lv<7> > ap_phi_mux_agg_result_V_0_phi_fu_267_p128;
    sc_signal< sc_lv<1> > p_Result_s_fu_460_p3;
    sc_signal< sc_lv<1> > tmp_fu_468_p3;
    sc_signal< sc_lv<1> > tmp_15_fu_476_p3;
    sc_signal< sc_lv<1> > tmp_16_fu_484_p3;
    sc_signal< sc_lv<1> > tmp_17_fu_492_p3;
    sc_signal< sc_lv<1> > tmp_18_fu_500_p3;
    sc_signal< sc_lv<1> > tmp_19_fu_508_p3;
    sc_signal< sc_lv<1> > tmp_20_fu_516_p3;
    sc_signal< sc_lv<1> > tmp_21_fu_524_p3;
    sc_signal< sc_lv<1> > tmp_22_fu_532_p3;
    sc_signal< sc_lv<1> > tmp_23_fu_540_p3;
    sc_signal< sc_lv<1> > tmp_24_fu_548_p3;
    sc_signal< sc_lv<1> > tmp_25_fu_556_p3;
    sc_signal< sc_lv<1> > tmp_26_fu_564_p3;
    sc_signal< sc_lv<1> > tmp_27_fu_572_p3;
    sc_signal< sc_lv<1> > tmp_28_fu_580_p3;
    sc_signal< sc_lv<1> > tmp_29_fu_588_p3;
    sc_signal< sc_lv<1> > tmp_30_fu_596_p3;
    sc_signal< sc_lv<1> > tmp_31_fu_604_p3;
    sc_signal< sc_lv<1> > tmp_32_fu_612_p3;
    sc_signal< sc_lv<1> > tmp_33_fu_620_p3;
    sc_signal< sc_lv<1> > tmp_34_fu_628_p3;
    sc_signal< sc_lv<1> > tmp_35_fu_636_p3;
    sc_signal< sc_lv<1> > tmp_36_fu_644_p3;
    sc_signal< sc_lv<1> > tmp_37_fu_652_p3;
    sc_signal< sc_lv<1> > tmp_38_fu_660_p3;
    sc_signal< sc_lv<1> > tmp_39_fu_668_p3;
    sc_signal< sc_lv<1> > tmp_40_fu_676_p3;
    sc_signal< sc_lv<1> > tmp_41_fu_684_p3;
    sc_signal< sc_lv<1> > tmp_42_fu_692_p3;
    sc_signal< sc_lv<1> > tmp_43_fu_700_p3;
    sc_signal< sc_lv<1> > tmp_44_fu_708_p3;
    sc_signal< sc_lv<1> > tmp_45_fu_716_p3;
    sc_signal< sc_lv<1> > tmp_46_fu_724_p3;
    sc_signal< sc_lv<1> > tmp_47_fu_732_p3;
    sc_signal< sc_lv<1> > tmp_48_fu_740_p3;
    sc_signal< sc_lv<1> > tmp_49_fu_748_p3;
    sc_signal< sc_lv<1> > tmp_50_fu_756_p3;
    sc_signal< sc_lv<1> > tmp_51_fu_764_p3;
    sc_signal< sc_lv<1> > tmp_52_fu_772_p3;
    sc_signal< sc_lv<1> > tmp_53_fu_780_p3;
    sc_signal< sc_lv<1> > tmp_54_fu_788_p3;
    sc_signal< sc_lv<1> > tmp_55_fu_796_p3;
    sc_signal< sc_lv<1> > tmp_56_fu_804_p3;
    sc_signal< sc_lv<1> > tmp_57_fu_812_p3;
    sc_signal< sc_lv<1> > tmp_58_fu_820_p3;
    sc_signal< sc_lv<1> > tmp_59_fu_828_p3;
    sc_signal< sc_lv<1> > tmp_60_fu_836_p3;
    sc_signal< sc_lv<1> > tmp_61_fu_844_p3;
    sc_signal< sc_lv<1> > tmp_62_fu_852_p3;
    sc_signal< sc_lv<1> > tmp_63_fu_860_p3;
    sc_signal< sc_lv<1> > tmp_64_fu_868_p3;
    sc_signal< sc_lv<1> > tmp_65_fu_876_p3;
    sc_signal< sc_lv<1> > tmp_66_fu_884_p3;
    sc_signal< sc_lv<1> > tmp_67_fu_892_p3;
    sc_signal< sc_lv<1> > tmp_68_fu_900_p3;
    sc_signal< sc_lv<1> > tmp_69_fu_908_p3;
    sc_signal< sc_lv<1> > tmp_70_fu_916_p3;
    sc_signal< sc_lv<1> > tmp_71_fu_924_p3;
    sc_signal< sc_lv<1> > tmp_72_fu_932_p3;
    sc_signal< sc_lv<1> > tmp_73_fu_940_p3;
    sc_signal< sc_lv<1> > tmp_74_fu_948_p3;
    sc_signal< sc_lv<1> > tmp_75_fu_956_p3;
    sc_signal< sc_lv<1> > trunc_ln791_fu_964_p1;
    static const sc_logic ap_const_logic_1;
    static const bool ap_const_boolean_1;
    static const sc_lv<1> ap_const_lv1_0;
    static const sc_lv<7> ap_const_lv7_40;
    static const sc_lv<1> ap_const_lv1_1;
    static const sc_lv<7> ap_const_lv7_3F;
    static const sc_lv<7> ap_const_lv7_3E;
    static const sc_lv<7> ap_const_lv7_3D;
    static const sc_lv<7> ap_const_lv7_3C;
    static const sc_lv<7> ap_const_lv7_3B;
    static const sc_lv<7> ap_const_lv7_3A;
    static const sc_lv<7> ap_const_lv7_39;
    static const sc_lv<7> ap_const_lv7_38;
    static const sc_lv<7> ap_const_lv7_37;
    static const sc_lv<7> ap_const_lv7_36;
    static const sc_lv<7> ap_const_lv7_35;
    static const sc_lv<7> ap_const_lv7_34;
    static const sc_lv<7> ap_const_lv7_33;
    static const sc_lv<7> ap_const_lv7_32;
    static const sc_lv<7> ap_const_lv7_31;
    static const sc_lv<7> ap_const_lv7_30;
    static const sc_lv<7> ap_const_lv7_2F;
    static const sc_lv<7> ap_const_lv7_2E;
    static const sc_lv<7> ap_const_lv7_2D;
    static const sc_lv<7> ap_const_lv7_2C;
    static const sc_lv<7> ap_const_lv7_2B;
    static const sc_lv<7> ap_const_lv7_2A;
    static const sc_lv<7> ap_const_lv7_29;
    static const sc_lv<7> ap_const_lv7_28;
    static const sc_lv<7> ap_const_lv7_27;
    static const sc_lv<7> ap_const_lv7_26;
    static const sc_lv<7> ap_const_lv7_25;
    static const sc_lv<7> ap_const_lv7_24;
    static const sc_lv<7> ap_const_lv7_23;
    static const sc_lv<7> ap_const_lv7_22;
    static const sc_lv<7> ap_const_lv7_21;
    static const sc_lv<7> ap_const_lv7_20;
    static const sc_lv<7> ap_const_lv7_1F;
    static const sc_lv<7> ap_const_lv7_1E;
    static const sc_lv<7> ap_const_lv7_1D;
    static const sc_lv<7> ap_const_lv7_1C;
    static const sc_lv<7> ap_const_lv7_1B;
    static const sc_lv<7> ap_const_lv7_1A;
    static const sc_lv<7> ap_const_lv7_19;
    static const sc_lv<7> ap_const_lv7_18;
    static const sc_lv<7> ap_const_lv7_17;
    static const sc_lv<7> ap_const_lv7_16;
    static const sc_lv<7> ap_const_lv7_15;
    static const sc_lv<7> ap_const_lv7_14;
    static const sc_lv<7> ap_const_lv7_13;
    static const sc_lv<7> ap_const_lv7_12;
    static const sc_lv<7> ap_const_lv7_11;
    static const sc_lv<7> ap_const_lv7_10;
    static const sc_lv<7> ap_const_lv7_F;
    static const sc_lv<7> ap_const_lv7_E;
    static const sc_lv<7> ap_const_lv7_D;
    static const sc_lv<7> ap_const_lv7_C;
    static const sc_lv<7> ap_const_lv7_B;
    static const sc_lv<7> ap_const_lv7_A;
    static const sc_lv<7> ap_const_lv7_9;
    static const sc_lv<7> ap_const_lv7_8;
    static const sc_lv<7> ap_const_lv7_7;
    static const sc_lv<7> ap_const_lv7_6;
    static const sc_lv<7> ap_const_lv7_5;
    static const sc_lv<7> ap_const_lv7_4;
    static const sc_lv<7> ap_const_lv7_3;
    static const sc_lv<7> ap_const_lv7_2;
    static const sc_lv<32> ap_const_lv32_3F;
    static const sc_lv<32> ap_const_lv32_3E;
    static const sc_lv<32> ap_const_lv32_3D;
    static const sc_lv<32> ap_const_lv32_3C;
    static const sc_lv<32> ap_const_lv32_3B;
    static const sc_lv<32> ap_const_lv32_3A;
    static const sc_lv<32> ap_const_lv32_39;
    static const sc_lv<32> ap_const_lv32_38;
    static const sc_lv<32> ap_const_lv32_37;
    static const sc_lv<32> ap_const_lv32_36;
    static const sc_lv<32> ap_const_lv32_35;
    static const sc_lv<32> ap_const_lv32_34;
    static const sc_lv<32> ap_const_lv32_33;
    static const sc_lv<32> ap_const_lv32_32;
    static const sc_lv<32> ap_const_lv32_31;
    static const sc_lv<32> ap_const_lv32_30;
    static const sc_lv<32> ap_const_lv32_2F;
    static const sc_lv<32> ap_const_lv32_2E;
    static const sc_lv<32> ap_const_lv32_2D;
    static const sc_lv<32> ap_const_lv32_2C;
    static const sc_lv<32> ap_const_lv32_2B;
    static const sc_lv<32> ap_const_lv32_2A;
    static const sc_lv<32> ap_const_lv32_29;
    static const sc_lv<32> ap_const_lv32_28;
    static const sc_lv<32> ap_const_lv32_27;
    static const sc_lv<32> ap_const_lv32_26;
    static const sc_lv<32> ap_const_lv32_25;
    static const sc_lv<32> ap_const_lv32_24;
    static const sc_lv<32> ap_const_lv32_23;
    static const sc_lv<32> ap_const_lv32_22;
    static const sc_lv<32> ap_const_lv32_21;
    static const sc_lv<32> ap_const_lv32_20;
    static const sc_lv<32> ap_const_lv32_1F;
    static const sc_lv<32> ap_const_lv32_1E;
    static const sc_lv<32> ap_const_lv32_1D;
    static const sc_lv<32> ap_const_lv32_1C;
    static const sc_lv<32> ap_const_lv32_1B;
    static const sc_lv<32> ap_const_lv32_1A;
    static const sc_lv<32> ap_const_lv32_19;
    static const sc_lv<32> ap_const_lv32_18;
    static const sc_lv<32> ap_const_lv32_17;
    static const sc_lv<32> ap_const_lv32_16;
    static const sc_lv<32> ap_const_lv32_15;
    static const sc_lv<32> ap_const_lv32_14;
    static const sc_lv<32> ap_const_lv32_13;
    static const sc_lv<32> ap_const_lv32_12;
    static const sc_lv<32> ap_const_lv32_11;
    static const sc_lv<32> ap_const_lv32_10;
    static const sc_lv<32> ap_const_lv32_F;
    static const sc_lv<32> ap_const_lv32_E;
    static const sc_lv<32> ap_const_lv32_D;
    static const sc_lv<32> ap_const_lv32_C;
    static const sc_lv<32> ap_const_lv32_B;
    static const sc_lv<32> ap_const_lv32_A;
    static const sc_lv<32> ap_const_lv32_9;
    static const sc_lv<32> ap_const_lv32_8;
    static const sc_lv<32> ap_const_lv32_7;
    static const sc_lv<32> ap_const_lv32_6;
    static const sc_lv<32> ap_const_lv32_5;
    static const sc_lv<32> ap_const_lv32_4;
    static const sc_lv<32> ap_const_lv32_3;
    static const sc_lv<32> ap_const_lv32_2;
    static const sc_lv<32> ap_const_lv32_1;
    static const sc_logic ap_const_logic_0;
    // Thread declarations
    void thread_ap_phi_mux_agg_result_V_0_phi_fu_267_p128();
    void thread_ap_ready();
    void thread_ap_return();
    void thread_p_Result_s_fu_460_p3();
    void thread_tmp_15_fu_476_p3();
    void thread_tmp_16_fu_484_p3();
    void thread_tmp_17_fu_492_p3();
    void thread_tmp_18_fu_500_p3();
    void thread_tmp_19_fu_508_p3();
    void thread_tmp_20_fu_516_p3();
    void thread_tmp_21_fu_524_p3();
    void thread_tmp_22_fu_532_p3();
    void thread_tmp_23_fu_540_p3();
    void thread_tmp_24_fu_548_p3();
    void thread_tmp_25_fu_556_p3();
    void thread_tmp_26_fu_564_p3();
    void thread_tmp_27_fu_572_p3();
    void thread_tmp_28_fu_580_p3();
    void thread_tmp_29_fu_588_p3();
    void thread_tmp_30_fu_596_p3();
    void thread_tmp_31_fu_604_p3();
    void thread_tmp_32_fu_612_p3();
    void thread_tmp_33_fu_620_p3();
    void thread_tmp_34_fu_628_p3();
    void thread_tmp_35_fu_636_p3();
    void thread_tmp_36_fu_644_p3();
    void thread_tmp_37_fu_652_p3();
    void thread_tmp_38_fu_660_p3();
    void thread_tmp_39_fu_668_p3();
    void thread_tmp_40_fu_676_p3();
    void thread_tmp_41_fu_684_p3();
    void thread_tmp_42_fu_692_p3();
    void thread_tmp_43_fu_700_p3();
    void thread_tmp_44_fu_708_p3();
    void thread_tmp_45_fu_716_p3();
    void thread_tmp_46_fu_724_p3();
    void thread_tmp_47_fu_732_p3();
    void thread_tmp_48_fu_740_p3();
    void thread_tmp_49_fu_748_p3();
    void thread_tmp_50_fu_756_p3();
    void thread_tmp_51_fu_764_p3();
    void thread_tmp_52_fu_772_p3();
    void thread_tmp_53_fu_780_p3();
    void thread_tmp_54_fu_788_p3();
    void thread_tmp_55_fu_796_p3();
    void thread_tmp_56_fu_804_p3();
    void thread_tmp_57_fu_812_p3();
    void thread_tmp_58_fu_820_p3();
    void thread_tmp_59_fu_828_p3();
    void thread_tmp_60_fu_836_p3();
    void thread_tmp_61_fu_844_p3();
    void thread_tmp_62_fu_852_p3();
    void thread_tmp_63_fu_860_p3();
    void thread_tmp_64_fu_868_p3();
    void thread_tmp_65_fu_876_p3();
    void thread_tmp_66_fu_884_p3();
    void thread_tmp_67_fu_892_p3();
    void thread_tmp_68_fu_900_p3();
    void thread_tmp_69_fu_908_p3();
    void thread_tmp_70_fu_916_p3();
    void thread_tmp_71_fu_924_p3();
    void thread_tmp_72_fu_932_p3();
    void thread_tmp_73_fu_940_p3();
    void thread_tmp_74_fu_948_p3();
    void thread_tmp_75_fu_956_p3();
    void thread_tmp_fu_468_p3();
    void thread_trunc_ln791_fu_964_p1();
    void thread_zext_ln171_fu_968_p1();
};

}

using namespace ap_rtl;

#endif