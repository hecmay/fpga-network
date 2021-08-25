// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="icmp_server,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xcu280-fsvh2892-2L-e,HLS_INPUT_CLOCK=3.100000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=2.588813,HLS_SYN_LAT=2,HLS_SYN_TPT=1,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=1284,HLS_SYN_LUT=554,HLS_VERSION=2020_1}" *)

module icmp_server (
        ap_clk,
        ap_rst_n,
        s_axis_icmp_TDATA,
        s_axis_icmp_TVALID,
        s_axis_icmp_TREADY,
        s_axis_icmp_TKEEP,
        s_axis_icmp_TLAST,
        myIpAddress_V,
        m_axis_icmp_TDATA,
        m_axis_icmp_TVALID,
        m_axis_icmp_TREADY,
        m_axis_icmp_TKEEP,
        m_axis_icmp_TLAST
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst_n;
input  [511:0] s_axis_icmp_TDATA;
input   s_axis_icmp_TVALID;
output   s_axis_icmp_TREADY;
input  [63:0] s_axis_icmp_TKEEP;
input  [0:0] s_axis_icmp_TLAST;
input  [31:0] myIpAddress_V;
output  [511:0] m_axis_icmp_TDATA;
output   m_axis_icmp_TVALID;
input   m_axis_icmp_TREADY;
output  [63:0] m_axis_icmp_TKEEP;
output  [0:0] m_axis_icmp_TLAST;

reg s_axis_icmp_TREADY;

 reg    ap_rst_n_inv;
reg   [1:0] aiFSMState;
reg   [31:0] ipDestination_V;
reg   [7:0] icmpType_V;
reg   [7:0] icmpCode_V;
reg   [15:0] auxInchecksum_r_V;
reg   [0:0] prevWord_last_V;
reg   [16:0] icmpChecksum_V;
reg   [511:0] prevWord_data_V;
reg   [63:0] prevWord_keep_V;
reg    s_axis_icmp_TDATA_blk_n;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_block_pp0_stage0;
wire   [1:0] aiFSMState_load_load_fu_263_p1;
wire   [0:0] grp_nbreadreq_fu_210_p5;
reg    m_axis_icmp_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter1;
reg   [1:0] aiFSMState_load_reg_1129;
reg    ap_enable_reg_pp0_iter2;
reg   [1:0] aiFSMState_load_reg_1129_pp0_iter1_reg;
reg   [0:0] tmp_1_reg_1138;
reg   [0:0] tmp_1_reg_1138_pp0_iter1_reg;
reg    ap_predicate_op12_read_state1;
reg    ap_predicate_op31_read_state1;
reg    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
reg    ap_predicate_op106_write_state2;
reg    ap_block_state2_io;
wire    regslice_both_m_axis_icmp_V_data_V_U_apdone_blk;
reg    ap_block_state3_pp0_stage0_iter2;
reg    ap_predicate_op160_write_state3;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
reg   [0:0] currWord_last_V_reg_1133;
reg   [511:0] tmp_data_V_3_reg_1142;
reg   [63:0] tmp_keep_V_3_reg_1147;
wire   [0:0] grp_fu_259_p1;
reg   [0:0] tmp_last_V_3_reg_1152;
reg   [0:0] tmp_reg_1157;
wire   [16:0] add_ln1353_4_fu_799_p2;
reg   [16:0] add_ln1353_4_reg_1161;
wire   [18:0] ret_V_3_fu_841_p2;
reg   [18:0] ret_V_3_reg_1166;
wire   [511:0] p_Result_17_fu_1024_p5;
reg    ap_block_pp0_stage0_subdone;
wire   [1:0] select_ln201_fu_299_p3;
wire   [1:0] select_ln170_fu_355_p3;
wire   [15:0] xor_ln306_fu_1117_p2;
reg   [15:0] ap_sig_allocacmp_auxInchecksum_r_V_lo;
wire   [16:0] add_ln306_fu_715_p2;
reg    ap_block_pp0_stage0_01001;
wire   [0:0] xor_ln201_fu_293_p2;
wire   [0:0] icmp_ln879_fu_313_p2;
wire   [0:0] icmp_ln879_1_fu_319_p2;
wire   [0:0] icmp_ln879_2_fu_325_p2;
wire   [0:0] icmp_ln879_3_fu_331_p2;
wire   [0:0] and_ln170_1_fu_343_p2;
wire   [0:0] and_ln170_fu_337_p2;
wire   [0:0] and_ln170_2_fu_349_p2;
wire   [7:0] trunc_ln647_2_fu_369_p1;
wire   [7:0] p_Result_16_1_fu_373_p4;
wire   [7:0] p_Result_16_2_fu_391_p4;
wire   [7:0] p_Result_16_3_fu_401_p4;
wire   [7:0] p_Result_16_4_fu_419_p4;
wire   [7:0] p_Result_16_5_fu_429_p4;
wire   [7:0] p_Result_16_6_fu_447_p4;
wire   [7:0] p_Result_16_7_fu_457_p4;
wire   [7:0] p_Result_16_8_fu_475_p4;
wire   [7:0] p_Result_16_9_fu_485_p4;
wire   [7:0] p_Result_16_s_fu_503_p4;
wire   [7:0] p_Result_16_10_fu_513_p4;
wire   [7:0] p_Result_16_11_fu_531_p4;
wire   [7:0] p_Result_16_12_fu_541_p4;
wire   [7:0] p_Result_16_13_fu_559_p4;
wire   [7:0] p_Result_16_14_fu_569_p4;
wire   [7:0] p_Result_16_15_fu_587_p4;
wire   [7:0] p_Result_16_16_fu_597_p4;
wire   [7:0] p_Result_13_fu_693_p4;
wire   [7:0] p_Result_12_fu_683_p4;
wire   [15:0] tmp_11_fu_703_p3;
wire   [16:0] zext_ln306_fu_711_p1;
wire   [7:0] p_Result_16_17_fu_615_p4;
wire   [7:0] p_Result_16_18_fu_625_p4;
wire   [15:0] p_Result_14_fu_727_p3;
wire   [15:0] tmp_10_fu_607_p3;
wire   [16:0] zext_ln215_1_fu_739_p1;
wire   [16:0] zext_ln215_fu_735_p1;
wire   [15:0] tmp_2_fu_579_p3;
wire   [15:0] tmp_s_fu_551_p3;
wire   [16:0] zext_ln215_3_fu_753_p1;
wire   [16:0] zext_ln215_2_fu_749_p1;
wire   [15:0] tmp_9_fu_523_p3;
wire   [15:0] tmp_8_fu_495_p3;
wire   [16:0] zext_ln215_5_fu_767_p1;
wire   [16:0] zext_ln215_4_fu_763_p1;
wire   [15:0] tmp_7_fu_467_p3;
wire   [15:0] tmp_6_fu_439_p3;
wire   [16:0] zext_ln215_7_fu_781_p1;
wire   [16:0] zext_ln215_6_fu_777_p1;
wire   [15:0] tmp_5_fu_411_p3;
wire   [15:0] tmp_4_fu_383_p3;
wire   [16:0] zext_ln215_9_fu_795_p1;
wire   [16:0] zext_ln215_8_fu_791_p1;
wire   [16:0] add_ln1353_fu_743_p2;
wire   [16:0] add_ln1353_1_fu_757_p2;
wire   [17:0] lhs_V_fu_805_p1;
wire   [17:0] rhs_V_fu_809_p1;
wire   [16:0] add_ln1353_2_fu_771_p2;
wire   [16:0] add_ln1353_3_fu_785_p2;
wire   [17:0] lhs_V_1_fu_819_p1;
wire   [17:0] rhs_V_1_fu_823_p1;
wire   [17:0] ret_V_1_fu_813_p2;
wire   [17:0] ret_V_2_fu_827_p2;
wire   [18:0] lhs_V_2_fu_833_p1;
wire   [18:0] rhs_V_2_fu_837_p1;
wire   [511:0] p_Result_1_fu_880_p5;
wire   [511:0] p_Result_3_fu_892_p5;
wire   [511:0] p_Result_4_fu_904_p5;
wire   [31:0] p_Result_s_20_fu_916_p4;
wire   [511:0] p_Result_5_fu_926_p5;
wire   [31:0] p_Result_2_fu_938_p4;
wire   [15:0] trunc_ln647_fu_964_p1;
wire   [0:0] tmp_12_fu_972_p3;
wire   [16:0] zext_ln215_10_fu_980_p1;
wire   [16:0] p_Result_8_fu_968_p1;
wire   [511:0] p_Result_7_fu_948_p5;
wire   [16:0] icmpChecksumTmp_V_fu_984_p2;
wire   [7:0] trunc_ln647_1_fu_1012_p1;
wire   [7:0] p_Result_6_fu_1002_p4;
wire   [511:0] p_Result_16_fu_990_p5;
wire   [15:0] tmp_3_fu_1016_p3;
wire   [19:0] rhs_V_3_fu_1040_p1;
wire   [19:0] lhs_V_3_fu_1037_p1;
wire   [19:0] ret_V_5_fu_1043_p2;
wire   [15:0] trunc_ln357_fu_1049_p1;
wire   [3:0] p_Result_15_fu_1053_p4;
wire   [16:0] zext_ln209_1_fu_1067_p1;
wire   [16:0] zext_ln209_fu_1063_p1;
wire   [4:0] zext_ln209_2_fu_1071_p1;
wire   [4:0] add_ln214_fu_1081_p2;
wire   [15:0] zext_ln681_fu_1087_p1;
wire   [16:0] checksumL4_r_V_fu_1075_p2;
wire   [0:0] p_Result_s_fu_1097_p3;
wire   [15:0] add_ln681_fu_1091_p2;
wire   [15:0] trunc_ln681_fu_1105_p1;
wire   [15:0] select_ln791_fu_1109_p3;
reg   [0:0] ap_NS_fsm;
wire    ap_reset_idle_pp0;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
reg   [511:0] m_axis_icmp_TDATA_int;
reg    m_axis_icmp_TVALID_int;
wire    m_axis_icmp_TREADY_int;
wire    regslice_both_m_axis_icmp_V_data_V_U_vld_out;
wire    regslice_both_m_axis_icmp_V_keep_V_U_apdone_blk;
reg   [63:0] m_axis_icmp_TKEEP_int;
wire    regslice_both_m_axis_icmp_V_keep_V_U_ack_in_dummy;
wire    regslice_both_m_axis_icmp_V_keep_V_U_vld_out;
wire    regslice_both_m_axis_icmp_V_last_V_U_apdone_blk;
reg   [0:0] m_axis_icmp_TLAST_int;
wire    regslice_both_m_axis_icmp_V_last_V_U_ack_in_dummy;
wire    regslice_both_m_axis_icmp_V_last_V_U_vld_out;
reg    ap_condition_170;
reg    ap_condition_136;
reg    ap_condition_220;

// power-on initialization
initial begin
#0 aiFSMState = 2'd0;
#0 ipDestination_V = 32'd0;
#0 icmpType_V = 8'd0;
#0 icmpCode_V = 8'd0;
#0 auxInchecksum_r_V = 16'd0;
#0 prevWord_last_V = 1'd0;
#0 icmpChecksum_V = 17'd0;
#0 prevWord_data_V = 512'd0;
#0 prevWord_keep_V = 64'd0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
end

regslice_both #(
    .DataWidth( 512 ))
regslice_both_m_axis_icmp_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(m_axis_icmp_TDATA_int),
    .vld_in(m_axis_icmp_TVALID_int),
    .ack_in(m_axis_icmp_TREADY_int),
    .data_out(m_axis_icmp_TDATA),
    .vld_out(regslice_both_m_axis_icmp_V_data_V_U_vld_out),
    .ack_out(m_axis_icmp_TREADY),
    .apdone_blk(regslice_both_m_axis_icmp_V_data_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 64 ))
regslice_both_m_axis_icmp_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(m_axis_icmp_TKEEP_int),
    .vld_in(m_axis_icmp_TVALID_int),
    .ack_in(regslice_both_m_axis_icmp_V_keep_V_U_ack_in_dummy),
    .data_out(m_axis_icmp_TKEEP),
    .vld_out(regslice_both_m_axis_icmp_V_keep_V_U_vld_out),
    .ack_out(m_axis_icmp_TREADY),
    .apdone_blk(regslice_both_m_axis_icmp_V_keep_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 1 ))
regslice_both_m_axis_icmp_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(m_axis_icmp_TLAST_int),
    .vld_in(m_axis_icmp_TVALID_int),
    .ack_in(regslice_both_m_axis_icmp_V_last_V_U_ack_in_dummy),
    .data_out(m_axis_icmp_TLAST),
    .vld_out(regslice_both_m_axis_icmp_V_last_V_U_vld_out),
    .ack_out(m_axis_icmp_TREADY),
    .apdone_blk(regslice_both_m_axis_icmp_V_last_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_136)) begin
        if (((grp_nbreadreq_fu_210_p5 == 1'd1) & (2'd0 == aiFSMState))) begin
            aiFSMState <= 2'd1;
        end else if ((2'd1 == aiFSMState_load_load_fu_263_p1)) begin
            aiFSMState <= select_ln170_fu_355_p3;
        end else if ((2'd2 == aiFSMState_load_load_fu_263_p1)) begin
            aiFSMState <= select_ln201_fu_299_p3;
        end else if ((1'b1 == ap_condition_170)) begin
            aiFSMState <= 2'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((grp_nbreadreq_fu_210_p5 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (2'd0 == aiFSMState) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        add_ln1353_4_reg_1161 <= add_ln1353_4_fu_799_p2;
        ret_V_3_reg_1166 <= ret_V_3_fu_841_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        aiFSMState_load_reg_1129 <= aiFSMState;
        aiFSMState_load_reg_1129_pp0_iter1_reg <= aiFSMState_load_reg_1129;
        currWord_last_V_reg_1133 <= prevWord_last_V;
        tmp_1_reg_1138_pp0_iter1_reg <= tmp_1_reg_1138;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_reg_1157 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (2'd0 == aiFSMState_load_reg_1129) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        auxInchecksum_r_V <= xor_ln306_fu_1117_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((grp_nbreadreq_fu_210_p5 == 1'd1) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (2'd0 == aiFSMState) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmpChecksum_V <= add_ln306_fu_715_p2;
        icmpCode_V <= {{s_axis_icmp_TDATA[175:168]}};
        icmpType_V <= {{s_axis_icmp_TDATA[167:160]}};
        ipDestination_V <= {{s_axis_icmp_TDATA[159:128]}};
        prevWord_data_V <= s_axis_icmp_TDATA;
        prevWord_keep_V <= s_axis_icmp_TKEEP;
        prevWord_last_V <= s_axis_icmp_TLAST;
    end
end

always @ (posedge ap_clk) begin
    if (((2'd3 == aiFSMState) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_1_reg_1138 <= grp_nbreadreq_fu_210_p5;
    end
end

always @ (posedge ap_clk) begin
    if (((grp_nbreadreq_fu_210_p5 == 1'd1) & (2'd3 == aiFSMState) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_data_V_3_reg_1142 <= s_axis_icmp_TDATA;
        tmp_keep_V_3_reg_1147 <= s_axis_icmp_TKEEP;
        tmp_last_V_3_reg_1152 <= s_axis_icmp_TLAST;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (2'd0 == aiFSMState) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_reg_1157 <= grp_nbreadreq_fu_210_p5;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (1'b1 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

assign ap_reset_idle_pp0 = 1'b0;

always @ (*) begin
    if (((tmp_reg_1157 == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (2'd0 == aiFSMState_load_reg_1129))) begin
        ap_sig_allocacmp_auxInchecksum_r_V_lo = xor_ln306_fu_1117_p2;
    end else begin
        ap_sig_allocacmp_auxInchecksum_r_V_lo = auxInchecksum_r_V;
    end
end

always @ (*) begin
    if ((((2'd3 == aiFSMState_load_reg_1129_pp0_iter1_reg) & (tmp_1_reg_1138_pp0_iter1_reg == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((2'd2 == aiFSMState_load_reg_1129_pp0_iter1_reg) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((2'd3 == aiFSMState_load_reg_1129) & (tmp_1_reg_1138 == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((2'd2 == aiFSMState_load_reg_1129) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        m_axis_icmp_TDATA_blk_n = m_axis_icmp_TREADY_int;
    end else begin
        m_axis_icmp_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_220)) begin
        if ((2'd2 == aiFSMState_load_reg_1129)) begin
            m_axis_icmp_TDATA_int = p_Result_17_fu_1024_p5;
        end else if ((ap_predicate_op106_write_state2 == 1'b1)) begin
            m_axis_icmp_TDATA_int = tmp_data_V_3_reg_1142;
        end else begin
            m_axis_icmp_TDATA_int = 'bx;
        end
    end else begin
        m_axis_icmp_TDATA_int = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_220)) begin
        if ((2'd2 == aiFSMState_load_reg_1129)) begin
            m_axis_icmp_TKEEP_int = prevWord_keep_V;
        end else if ((ap_predicate_op106_write_state2 == 1'b1)) begin
            m_axis_icmp_TKEEP_int = tmp_keep_V_3_reg_1147;
        end else begin
            m_axis_icmp_TKEEP_int = 'bx;
        end
    end else begin
        m_axis_icmp_TKEEP_int = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_220)) begin
        if ((2'd2 == aiFSMState_load_reg_1129)) begin
            m_axis_icmp_TLAST_int = currWord_last_V_reg_1133;
        end else if ((ap_predicate_op106_write_state2 == 1'b1)) begin
            m_axis_icmp_TLAST_int = tmp_last_V_3_reg_1152;
        end else begin
            m_axis_icmp_TLAST_int = 'bx;
        end
    end else begin
        m_axis_icmp_TLAST_int = 'bx;
    end
end

always @ (*) begin
    if ((((2'd2 == aiFSMState_load_reg_1129) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((ap_predicate_op106_write_state2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        m_axis_icmp_TVALID_int = 1'b1;
    end else begin
        m_axis_icmp_TVALID_int = 1'b0;
    end
end

always @ (*) begin
    if ((((grp_nbreadreq_fu_210_p5 == 1'd1) & (2'd3 == aiFSMState) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((grp_nbreadreq_fu_210_p5 == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (2'd0 == aiFSMState)))) begin
        s_axis_icmp_TDATA_blk_n = s_axis_icmp_TVALID;
    end else begin
        s_axis_icmp_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((((ap_predicate_op31_read_state1 == 1'b1) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((ap_predicate_op12_read_state1 == 1'b1) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        s_axis_icmp_TREADY = 1'b1;
    end else begin
        s_axis_icmp_TREADY = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln1353_1_fu_757_p2 = (zext_ln215_3_fu_753_p1 + zext_ln215_2_fu_749_p1);

assign add_ln1353_2_fu_771_p2 = (zext_ln215_5_fu_767_p1 + zext_ln215_4_fu_763_p1);

assign add_ln1353_3_fu_785_p2 = (zext_ln215_7_fu_781_p1 + zext_ln215_6_fu_777_p1);

assign add_ln1353_4_fu_799_p2 = (zext_ln215_9_fu_795_p1 + zext_ln215_8_fu_791_p1);

assign add_ln1353_fu_743_p2 = (zext_ln215_1_fu_739_p1 + zext_ln215_fu_735_p1);

assign add_ln214_fu_1081_p2 = (5'd1 + zext_ln209_2_fu_1071_p1);

assign add_ln306_fu_715_p2 = (17'd2048 + zext_ln306_fu_711_p1);

assign add_ln681_fu_1091_p2 = (trunc_ln357_fu_1049_p1 + zext_ln681_fu_1087_p1);

assign aiFSMState_load_load_fu_263_p1 = aiFSMState;

assign and_ln170_1_fu_343_p2 = (icmp_ln879_3_fu_331_p2 & icmp_ln879_2_fu_325_p2);

assign and_ln170_2_fu_349_p2 = (and_ln170_fu_337_p2 & and_ln170_1_fu_343_p2);

assign and_ln170_fu_337_p2 = (icmp_ln879_fu_313_p2 & icmp_ln879_1_fu_319_p2);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = (((ap_enable_reg_pp0_iter2 == 1'b1) & (regslice_both_m_axis_icmp_V_data_V_U_apdone_blk == 1'b1)) | ((1'b1 == 1'b1) & (((ap_predicate_op31_read_state1 == 1'b1) & (s_axis_icmp_TVALID == 1'b0)) | ((ap_predicate_op12_read_state1 == 1'b1) & (s_axis_icmp_TVALID == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter2 == 1'b1) & ((1'b1 == ap_block_state3_io) | (regslice_both_m_axis_icmp_V_data_V_U_apdone_blk == 1'b1))) | ((1'b1 == ap_block_state2_io) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((1'b1 == 1'b1) & (((ap_predicate_op31_read_state1 == 1'b1) & (s_axis_icmp_TVALID == 1'b0)) | ((ap_predicate_op12_read_state1 == 1'b1) & (s_axis_icmp_TVALID == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter2 == 1'b1) & ((1'b1 == ap_block_state3_io) | (regslice_both_m_axis_icmp_V_data_V_U_apdone_blk == 1'b1))) | ((1'b1 == ap_block_state2_io) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((1'b1 == 1'b1) & (((ap_predicate_op31_read_state1 == 1'b1) & (s_axis_icmp_TVALID == 1'b0)) | ((ap_predicate_op12_read_state1 == 1'b1) & (s_axis_icmp_TVALID == 1'b0)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = (((ap_predicate_op31_read_state1 == 1'b1) & (s_axis_icmp_TVALID == 1'b0)) | ((ap_predicate_op12_read_state1 == 1'b1) & (s_axis_icmp_TVALID == 1'b0)));
end

always @ (*) begin
    ap_block_state2_io = (((2'd2 == aiFSMState_load_reg_1129) & (m_axis_icmp_TREADY_int == 1'b0)) | ((ap_predicate_op106_write_state2 == 1'b1) & (m_axis_icmp_TREADY_int == 1'b0)));
end

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state3_io = (((2'd2 == aiFSMState_load_reg_1129_pp0_iter1_reg) & (m_axis_icmp_TREADY_int == 1'b0)) | ((ap_predicate_op160_write_state3 == 1'b1) & (m_axis_icmp_TREADY_int == 1'b0)));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = (regslice_both_m_axis_icmp_V_data_V_U_apdone_blk == 1'b1);
end

always @ (*) begin
    ap_condition_136 = ((1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001));
end

always @ (*) begin
    ap_condition_170 = ((grp_fu_259_p1 == 1'd1) & (grp_nbreadreq_fu_210_p5 == 1'd1) & (2'd3 == aiFSMState));
end

always @ (*) begin
    ap_condition_220 = ((1'b0 == ap_block_pp0_stage0_01001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

always @ (*) begin
    ap_predicate_op106_write_state2 = ((2'd3 == aiFSMState_load_reg_1129) & (tmp_1_reg_1138 == 1'd1));
end

always @ (*) begin
    ap_predicate_op12_read_state1 = ((grp_nbreadreq_fu_210_p5 == 1'd1) & (2'd3 == aiFSMState));
end

always @ (*) begin
    ap_predicate_op160_write_state3 = ((2'd3 == aiFSMState_load_reg_1129_pp0_iter1_reg) & (tmp_1_reg_1138_pp0_iter1_reg == 1'd1));
end

always @ (*) begin
    ap_predicate_op31_read_state1 = ((grp_nbreadreq_fu_210_p5 == 1'd1) & (2'd0 == aiFSMState));
end

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign checksumL4_r_V_fu_1075_p2 = (zext_ln209_1_fu_1067_p1 + zext_ln209_fu_1063_p1);

assign grp_fu_259_p1 = s_axis_icmp_TLAST;

assign grp_nbreadreq_fu_210_p5 = s_axis_icmp_TVALID;

assign icmpChecksumTmp_V_fu_984_p2 = (zext_ln215_10_fu_980_p1 + p_Result_8_fu_968_p1);

assign icmp_ln879_1_fu_319_p2 = ((icmpType_V == 8'd8) ? 1'b1 : 1'b0);

assign icmp_ln879_2_fu_325_p2 = ((icmpCode_V == 8'd0) ? 1'b1 : 1'b0);

assign icmp_ln879_3_fu_331_p2 = ((ap_sig_allocacmp_auxInchecksum_r_V_lo == 16'd0) ? 1'b1 : 1'b0);

assign icmp_ln879_fu_313_p2 = ((ipDestination_V == myIpAddress_V) ? 1'b1 : 1'b0);

assign lhs_V_1_fu_819_p1 = add_ln1353_2_fu_771_p2;

assign lhs_V_2_fu_833_p1 = ret_V_1_fu_813_p2;

assign lhs_V_3_fu_1037_p1 = ret_V_3_reg_1166;

assign lhs_V_fu_805_p1 = add_ln1353_fu_743_p2;

assign m_axis_icmp_TVALID = regslice_both_m_axis_icmp_V_data_V_U_vld_out;

assign p_Result_12_fu_683_p4 = {{s_axis_icmp_TDATA[191:184]}};

assign p_Result_13_fu_693_p4 = {{s_axis_icmp_TDATA[183:176]}};

assign p_Result_14_fu_727_p3 = {{p_Result_16_17_fu_615_p4}, {p_Result_16_18_fu_625_p4}};

assign p_Result_15_fu_1053_p4 = {{ret_V_5_fu_1043_p2[19:16]}};

assign p_Result_16_10_fu_513_p4 = {{s_axis_icmp_TDATA[95:88]}};

assign p_Result_16_11_fu_531_p4 = {{s_axis_icmp_TDATA[103:96]}};

assign p_Result_16_12_fu_541_p4 = {{s_axis_icmp_TDATA[111:104]}};

assign p_Result_16_13_fu_559_p4 = {{s_axis_icmp_TDATA[119:112]}};

assign p_Result_16_14_fu_569_p4 = {{s_axis_icmp_TDATA[127:120]}};

assign p_Result_16_15_fu_587_p4 = {{s_axis_icmp_TDATA[135:128]}};

assign p_Result_16_16_fu_597_p4 = {{s_axis_icmp_TDATA[143:136]}};

assign p_Result_16_17_fu_615_p4 = {{s_axis_icmp_TDATA[151:144]}};

assign p_Result_16_18_fu_625_p4 = {{s_axis_icmp_TDATA[159:152]}};

assign p_Result_16_1_fu_373_p4 = {{s_axis_icmp_TDATA[15:8]}};

assign p_Result_16_2_fu_391_p4 = {{s_axis_icmp_TDATA[23:16]}};

assign p_Result_16_3_fu_401_p4 = {{s_axis_icmp_TDATA[31:24]}};

assign p_Result_16_4_fu_419_p4 = {{s_axis_icmp_TDATA[39:32]}};

assign p_Result_16_5_fu_429_p4 = {{s_axis_icmp_TDATA[47:40]}};

assign p_Result_16_6_fu_447_p4 = {{s_axis_icmp_TDATA[55:48]}};

assign p_Result_16_7_fu_457_p4 = {{s_axis_icmp_TDATA[63:56]}};

assign p_Result_16_8_fu_475_p4 = {{s_axis_icmp_TDATA[71:64]}};

assign p_Result_16_9_fu_485_p4 = {{s_axis_icmp_TDATA[79:72]}};

assign p_Result_16_fu_990_p5 = {{p_Result_7_fu_948_p5[511:168]}, {8'd0}, {p_Result_7_fu_948_p5[159:0]}};

assign p_Result_16_s_fu_503_p4 = {{s_axis_icmp_TDATA[87:80]}};

assign p_Result_17_fu_1024_p5 = {{p_Result_16_fu_990_p5[511:192]}, {tmp_3_fu_1016_p3}, {p_Result_16_fu_990_p5[175:0]}};

assign p_Result_1_fu_880_p5 = {{prevWord_data_V[511:72]}, {8'd128}, {prevWord_data_V[63:0]}};

assign p_Result_2_fu_938_p4 = {{prevWord_data_V[127:96]}};

assign p_Result_3_fu_892_p5 = {{p_Result_1_fu_880_p5[511:96]}, {24'd1}, {p_Result_1_fu_880_p5[71:0]}};

assign p_Result_4_fu_904_p5 = {{p_Result_3_fu_892_p5[511:96]}, {16'd0}, {p_Result_3_fu_892_p5[79:0]}};

assign p_Result_5_fu_926_p5 = {{p_Result_4_fu_904_p5[511:128]}, {p_Result_s_20_fu_916_p4}, {p_Result_4_fu_904_p5[95:0]}};

assign p_Result_6_fu_1002_p4 = {{icmpChecksumTmp_V_fu_984_p2[15:8]}};

assign p_Result_7_fu_948_p5 = {{p_Result_5_fu_926_p5[511:160]}, {p_Result_2_fu_938_p4}, {p_Result_5_fu_926_p5[127:0]}};

assign p_Result_8_fu_968_p1 = trunc_ln647_fu_964_p1;

assign p_Result_s_20_fu_916_p4 = {{prevWord_data_V[159:128]}};

assign p_Result_s_fu_1097_p3 = checksumL4_r_V_fu_1075_p2[32'd16];

assign ret_V_1_fu_813_p2 = (lhs_V_fu_805_p1 + rhs_V_fu_809_p1);

assign ret_V_2_fu_827_p2 = (lhs_V_1_fu_819_p1 + rhs_V_1_fu_823_p1);

assign ret_V_3_fu_841_p2 = (lhs_V_2_fu_833_p1 + rhs_V_2_fu_837_p1);

assign ret_V_5_fu_1043_p2 = (rhs_V_3_fu_1040_p1 + lhs_V_3_fu_1037_p1);

assign rhs_V_1_fu_823_p1 = add_ln1353_3_fu_785_p2;

assign rhs_V_2_fu_837_p1 = ret_V_2_fu_827_p2;

assign rhs_V_3_fu_1040_p1 = add_ln1353_4_reg_1161;

assign rhs_V_fu_809_p1 = add_ln1353_1_fu_757_p2;

assign select_ln170_fu_355_p3 = ((and_ln170_2_fu_349_p2[0:0] === 1'b1) ? 2'd2 : 2'd0);

assign select_ln201_fu_299_p3 = ((xor_ln201_fu_293_p2[0:0] === 1'b1) ? 2'd3 : 2'd0);

assign select_ln791_fu_1109_p3 = ((p_Result_s_fu_1097_p3[0:0] === 1'b1) ? add_ln681_fu_1091_p2 : trunc_ln681_fu_1105_p1);

assign tmp_10_fu_607_p3 = {{p_Result_16_15_fu_587_p4}, {p_Result_16_16_fu_597_p4}};

assign tmp_11_fu_703_p3 = {{p_Result_13_fu_693_p4}, {p_Result_12_fu_683_p4}};

assign tmp_12_fu_972_p3 = icmpChecksum_V[32'd16];

assign tmp_2_fu_579_p3 = {{p_Result_16_13_fu_559_p4}, {p_Result_16_14_fu_569_p4}};

assign tmp_3_fu_1016_p3 = {{trunc_ln647_1_fu_1012_p1}, {p_Result_6_fu_1002_p4}};

assign tmp_4_fu_383_p3 = {{trunc_ln647_2_fu_369_p1}, {p_Result_16_1_fu_373_p4}};

assign tmp_5_fu_411_p3 = {{p_Result_16_2_fu_391_p4}, {p_Result_16_3_fu_401_p4}};

assign tmp_6_fu_439_p3 = {{p_Result_16_4_fu_419_p4}, {p_Result_16_5_fu_429_p4}};

assign tmp_7_fu_467_p3 = {{p_Result_16_6_fu_447_p4}, {p_Result_16_7_fu_457_p4}};

assign tmp_8_fu_495_p3 = {{p_Result_16_8_fu_475_p4}, {p_Result_16_9_fu_485_p4}};

assign tmp_9_fu_523_p3 = {{p_Result_16_s_fu_503_p4}, {p_Result_16_10_fu_513_p4}};

assign tmp_s_fu_551_p3 = {{p_Result_16_11_fu_531_p4}, {p_Result_16_12_fu_541_p4}};

assign trunc_ln357_fu_1049_p1 = ret_V_5_fu_1043_p2[15:0];

assign trunc_ln647_1_fu_1012_p1 = icmpChecksumTmp_V_fu_984_p2[7:0];

assign trunc_ln647_2_fu_369_p1 = s_axis_icmp_TDATA[7:0];

assign trunc_ln647_fu_964_p1 = icmpChecksum_V[15:0];

assign trunc_ln681_fu_1105_p1 = checksumL4_r_V_fu_1075_p2[15:0];

assign xor_ln201_fu_293_p2 = (prevWord_last_V ^ 1'd1);

assign xor_ln306_fu_1117_p2 = (select_ln791_fu_1109_p3 ^ 16'd65535);

assign zext_ln209_1_fu_1067_p1 = p_Result_15_fu_1053_p4;

assign zext_ln209_2_fu_1071_p1 = p_Result_15_fu_1053_p4;

assign zext_ln209_fu_1063_p1 = trunc_ln357_fu_1049_p1;

assign zext_ln215_10_fu_980_p1 = tmp_12_fu_972_p3;

assign zext_ln215_1_fu_739_p1 = tmp_10_fu_607_p3;

assign zext_ln215_2_fu_749_p1 = tmp_2_fu_579_p3;

assign zext_ln215_3_fu_753_p1 = tmp_s_fu_551_p3;

assign zext_ln215_4_fu_763_p1 = tmp_9_fu_523_p3;

assign zext_ln215_5_fu_767_p1 = tmp_8_fu_495_p3;

assign zext_ln215_6_fu_777_p1 = tmp_7_fu_467_p3;

assign zext_ln215_7_fu_781_p1 = tmp_6_fu_439_p3;

assign zext_ln215_8_fu_791_p1 = tmp_5_fu_411_p3;

assign zext_ln215_9_fu_795_p1 = tmp_4_fu_383_p3;

assign zext_ln215_fu_735_p1 = p_Result_14_fu_727_p3;

assign zext_ln306_fu_711_p1 = tmp_11_fu_703_p3;

assign zext_ln681_fu_1087_p1 = add_ln214_fu_1081_p2;

endmodule //icmp_server