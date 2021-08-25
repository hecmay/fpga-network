// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module arp_pkg_sender (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        arpRequestFifo_V_V_dout,
        arpRequestFifo_V_V_empty_n,
        arpRequestFifo_V_V_read,
        arpReplyFifo_V_dout,
        arpReplyFifo_V_empty_n,
        arpReplyFifo_V_read,
        myIpAddress_V_dout,
        myIpAddress_V_empty_n,
        myIpAddress_V_read,
        gatewayIP_V_dout,
        gatewayIP_V_empty_n,
        gatewayIP_V_read,
        networkMask_V_dout,
        networkMask_V_empty_n,
        networkMask_V_read,
        myIpAddress_V_out_din,
        myIpAddress_V_out_full_n,
        myIpAddress_V_out_write,
        gatewayIP_V_out_din,
        gatewayIP_V_out_full_n,
        gatewayIP_V_out_write,
        networkMask_V_out_din,
        networkMask_V_out_full_n,
        networkMask_V_out_write,
        myMacAddress_V_dout,
        myMacAddress_V_empty_n,
        myMacAddress_V_read,
        arpDataOut_TREADY,
        arpDataOut_TDATA,
        arpDataOut_TVALID,
        arpDataOut_TKEEP,
        arpDataOut_TLAST
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [31:0] arpRequestFifo_V_V_dout;
input   arpRequestFifo_V_V_empty_n;
output   arpRequestFifo_V_V_read;
input  [191:0] arpReplyFifo_V_dout;
input   arpReplyFifo_V_empty_n;
output   arpReplyFifo_V_read;
input  [31:0] myIpAddress_V_dout;
input   myIpAddress_V_empty_n;
output   myIpAddress_V_read;
input  [31:0] gatewayIP_V_dout;
input   gatewayIP_V_empty_n;
output   gatewayIP_V_read;
input  [31:0] networkMask_V_dout;
input   networkMask_V_empty_n;
output   networkMask_V_read;
output  [31:0] myIpAddress_V_out_din;
input   myIpAddress_V_out_full_n;
output   myIpAddress_V_out_write;
output  [31:0] gatewayIP_V_out_din;
input   gatewayIP_V_out_full_n;
output   gatewayIP_V_out_write;
output  [31:0] networkMask_V_out_din;
input   networkMask_V_out_full_n;
output   networkMask_V_out_write;
input  [47:0] myMacAddress_V_dout;
input   myMacAddress_V_empty_n;
output   myMacAddress_V_read;
input   arpDataOut_TREADY;
output  [511:0] arpDataOut_TDATA;
output   arpDataOut_TVALID;
output  [63:0] arpDataOut_TKEEP;
output  [0:0] arpDataOut_TLAST;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg arpRequestFifo_V_V_read;
reg arpReplyFifo_V_read;
reg myIpAddress_V_read;
reg gatewayIP_V_read;
reg networkMask_V_read;
reg myIpAddress_V_out_write;
reg gatewayIP_V_out_write;
reg networkMask_V_out_write;
reg myMacAddress_V_read;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire   [1:0] aps_fsmState_load_load_fu_239_p1;
wire   [0:0] tmp_nbreadreq_fu_142_p3;
wire   [0:0] tmp_4_nbreadreq_fu_150_p3;
reg    ap_predicate_op12_read_state1;
reg    ap_predicate_op14_read_state1;
reg    ap_block_state1_pp0_stage0_iter0;
reg    ap_block_state2_pp0_stage0_iter1;
reg   [1:0] aps_fsmState_load_reg_496;
reg    ap_block_state2_io;
wire    regslice_both_arpDataOut_V_data_V_U_apdone_blk;
reg    ap_block_state3_pp0_stage0_iter2;
reg   [1:0] aps_fsmState_load_reg_496_pp0_iter1_reg;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
reg   [1:0] aps_fsmState;
reg   [31:0] inputIP_V;
reg   [47:0] replyMeta_srcMac_V;
reg   [15:0] replyMeta_ethType_V;
reg   [15:0] replyMeta_hwType_V;
reg   [15:0] replyMeta_protoType_s;
reg   [7:0] replyMeta_hwLen_V;
reg   [7:0] replyMeta_protoLen_V;
reg   [47:0] replyMeta_hwAddrSrc_s;
reg   [31:0] replyMeta_protoAddrS;
reg    arpDataOut_TDATA_blk_n;
wire    ap_block_pp0_stage0;
reg    myMacAddress_V_blk_n;
reg    myIpAddress_V_blk_n;
reg    gatewayIP_V_blk_n;
reg    networkMask_V_blk_n;
reg    myIpAddress_V_out_blk_n;
reg    gatewayIP_V_out_blk_n;
reg    networkMask_V_out_blk_n;
reg    arpReplyFifo_V_blk_n;
reg    arpRequestFifo_V_V_blk_n;
reg   [0:0] tmp_reg_500;
reg   [0:0] tmp_4_reg_504;
reg   [31:0] tmp_V_reg_508;
wire   [511:0] p_Result_1_fu_413_p14;
wire   [511:0] p_Result_s_fu_470_p9;
reg    ap_block_pp0_stage0_subdone;
wire   [47:0] trunc_ln321_fu_249_p1;
reg    ap_block_pp0_stage0_01001;
wire   [31:0] xor_ln879_fu_444_p2;
wire   [31:0] and_ln879_fu_450_p2;
wire   [0:0] icmp_ln879_fu_456_p2;
wire   [31:0] select_ln136_fu_462_p3;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to1;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
reg   [511:0] arpDataOut_TDATA_int;
reg    arpDataOut_TVALID_int;
wire    arpDataOut_TREADY_int;
wire    regslice_both_arpDataOut_V_data_V_U_vld_out;
wire    regslice_both_arpDataOut_V_keep_V_U_apdone_blk;
wire    regslice_both_arpDataOut_V_keep_V_U_ack_in_dummy;
wire    regslice_both_arpDataOut_V_keep_V_U_vld_out;
wire    regslice_both_arpDataOut_V_last_V_U_apdone_blk;
wire    regslice_both_arpDataOut_V_last_V_U_ack_in_dummy;
wire    regslice_both_arpDataOut_V_last_V_U_vld_out;
reg    ap_condition_276;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 aps_fsmState = 2'd0;
#0 inputIP_V = 32'd0;
#0 replyMeta_srcMac_V = 48'd0;
#0 replyMeta_ethType_V = 16'd0;
#0 replyMeta_hwType_V = 16'd0;
#0 replyMeta_protoType_s = 16'd0;
#0 replyMeta_hwLen_V = 8'd0;
#0 replyMeta_protoLen_V = 8'd0;
#0 replyMeta_hwAddrSrc_s = 48'd0;
#0 replyMeta_protoAddrS = 32'd0;
end

regslice_both #(
    .DataWidth( 512 ))
regslice_both_arpDataOut_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(arpDataOut_TDATA_int),
    .vld_in(arpDataOut_TVALID_int),
    .ack_in(arpDataOut_TREADY_int),
    .data_out(arpDataOut_TDATA),
    .vld_out(regslice_both_arpDataOut_V_data_V_U_vld_out),
    .ack_out(arpDataOut_TREADY),
    .apdone_blk(regslice_both_arpDataOut_V_data_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 64 ))
regslice_both_arpDataOut_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(64'd1152921504606846975),
    .vld_in(arpDataOut_TVALID_int),
    .ack_in(regslice_both_arpDataOut_V_keep_V_U_ack_in_dummy),
    .data_out(arpDataOut_TKEEP),
    .vld_out(regslice_both_arpDataOut_V_keep_V_U_vld_out),
    .ack_out(arpDataOut_TREADY),
    .apdone_blk(regslice_both_arpDataOut_V_keep_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 1 ))
regslice_both_arpDataOut_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(1'd1),
    .vld_in(arpDataOut_TVALID_int),
    .ack_in(regslice_both_arpDataOut_V_last_V_U_ack_in_dummy),
    .data_out(arpDataOut_TLAST),
    .vld_out(regslice_both_arpDataOut_V_last_V_U_vld_out),
    .ack_out(arpDataOut_TREADY),
    .apdone_blk(regslice_both_arpDataOut_V_last_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_nbreadreq_fu_142_p3 == 1'd1) & (aps_fsmState == 2'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        aps_fsmState <= 2'd1;
    end else if (((tmp_4_nbreadreq_fu_150_p3 == 1'd1) & (tmp_nbreadreq_fu_142_p3 == 1'd0) & (aps_fsmState == 2'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        aps_fsmState <= 2'd2;
    end else if ((((aps_fsmState_load_load_fu_239_p1 == 2'd2) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((aps_fsmState_load_load_fu_239_p1 == 2'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        aps_fsmState <= 2'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        aps_fsmState_load_reg_496 <= aps_fsmState;
        aps_fsmState_load_reg_496_pp0_iter1_reg <= aps_fsmState_load_reg_496;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_4_reg_504 == 1'd1) & (tmp_reg_500 == 1'd0) & (aps_fsmState_load_reg_496 == 2'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputIP_V <= tmp_V_reg_508;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_nbreadreq_fu_142_p3 == 1'd1) & (aps_fsmState == 2'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        replyMeta_ethType_V <= {{arpReplyFifo_V_dout[63:48]}};
        replyMeta_hwAddrSrc_s <= {{arpReplyFifo_V_dout[159:112]}};
        replyMeta_hwLen_V <= {{arpReplyFifo_V_dout[103:96]}};
        replyMeta_hwType_V <= {{arpReplyFifo_V_dout[79:64]}};
        replyMeta_protoAddrS <= {{arpReplyFifo_V_dout[191:160]}};
        replyMeta_protoLen_V <= {{arpReplyFifo_V_dout[111:104]}};
        replyMeta_protoType_s <= {{arpReplyFifo_V_dout[95:80]}};
        replyMeta_srcMac_V <= trunc_ln321_fu_249_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_nbreadreq_fu_142_p3 == 1'd0) & (aps_fsmState == 2'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_4_reg_504 <= tmp_4_nbreadreq_fu_150_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op12_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_reg_508 <= arpRequestFifo_V_V_dout;
    end
end

always @ (posedge ap_clk) begin
    if (((aps_fsmState == 2'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_reg_500 <= tmp_nbreadreq_fu_142_p3;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0_0to1 = 1'b1;
    end else begin
        ap_idle_pp0_0to1 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (ap_idle_pp0_0to1 == 1'b1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0) & (aps_fsmState_load_reg_496 == 2'd2)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0) & (aps_fsmState_load_reg_496 == 2'd1)) | ((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (aps_fsmState_load_reg_496_pp0_iter1_reg == 2'd2)) | ((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (aps_fsmState_load_reg_496_pp0_iter1_reg == 2'd1)))) begin
        arpDataOut_TDATA_blk_n = arpDataOut_TREADY_int;
    end else begin
        arpDataOut_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_276)) begin
        if ((aps_fsmState_load_reg_496 == 2'd2)) begin
            arpDataOut_TDATA_int = p_Result_s_fu_470_p9;
        end else if ((aps_fsmState_load_reg_496 == 2'd1)) begin
            arpDataOut_TDATA_int = p_Result_1_fu_413_p14;
        end else begin
            arpDataOut_TDATA_int = 'bx;
        end
    end else begin
        arpDataOut_TDATA_int = 'bx;
    end
end

always @ (*) begin
    if ((((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001) & (aps_fsmState_load_reg_496 == 2'd2)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001) & (aps_fsmState_load_reg_496 == 2'd1)))) begin
        arpDataOut_TVALID_int = 1'b1;
    end else begin
        arpDataOut_TVALID_int = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op14_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        arpReplyFifo_V_blk_n = arpReplyFifo_V_empty_n;
    end else begin
        arpReplyFifo_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op14_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        arpReplyFifo_V_read = 1'b1;
    end else begin
        arpReplyFifo_V_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op12_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        arpRequestFifo_V_V_blk_n = arpRequestFifo_V_V_empty_n;
    end else begin
        arpRequestFifo_V_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op12_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        arpRequestFifo_V_V_read = 1'b1;
    end else begin
        arpRequestFifo_V_V_read = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        gatewayIP_V_blk_n = gatewayIP_V_empty_n;
    end else begin
        gatewayIP_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        gatewayIP_V_out_blk_n = gatewayIP_V_out_full_n;
    end else begin
        gatewayIP_V_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        gatewayIP_V_out_write = 1'b1;
    end else begin
        gatewayIP_V_out_write = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        gatewayIP_V_read = 1'b1;
    end else begin
        gatewayIP_V_read = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        myIpAddress_V_blk_n = myIpAddress_V_empty_n;
    end else begin
        myIpAddress_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        myIpAddress_V_out_blk_n = myIpAddress_V_out_full_n;
    end else begin
        myIpAddress_V_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        myIpAddress_V_out_write = 1'b1;
    end else begin
        myIpAddress_V_out_write = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        myIpAddress_V_read = 1'b1;
    end else begin
        myIpAddress_V_read = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        myMacAddress_V_blk_n = myMacAddress_V_empty_n;
    end else begin
        myMacAddress_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        myMacAddress_V_read = 1'b1;
    end else begin
        myMacAddress_V_read = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        networkMask_V_blk_n = networkMask_V_empty_n;
    end else begin
        networkMask_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        networkMask_V_out_blk_n = networkMask_V_out_full_n;
    end else begin
        networkMask_V_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        networkMask_V_out_write = 1'b1;
    end else begin
        networkMask_V_out_write = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        networkMask_V_read = 1'b1;
    end else begin
        networkMask_V_read = 1'b0;
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

assign and_ln879_fu_450_p2 = (xor_ln879_fu_444_p2 & networkMask_V_dout);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((arpReplyFifo_V_empty_n == 1'b0) & (ap_predicate_op14_read_state1 == 1'b1)) | ((arpRequestFifo_V_V_empty_n == 1'b0) & (ap_predicate_op12_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & (regslice_both_arpDataOut_V_data_V_U_apdone_blk == 1'b1)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & ((gatewayIP_V_out_full_n == 1'b0) | (myIpAddress_V_out_full_n == 1'b0) | (networkMask_V_empty_n == 1'b0) | (gatewayIP_V_empty_n == 1'b0) | (myIpAddress_V_empty_n == 1'b0) | (myMacAddress_V_empty_n == 1'b0) | (networkMask_V_out_full_n == 1'b0))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((arpReplyFifo_V_empty_n == 1'b0) & (ap_predicate_op14_read_state1 == 1'b1)) | ((arpRequestFifo_V_V_empty_n == 1'b0) & (ap_predicate_op12_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((regslice_both_arpDataOut_V_data_V_U_apdone_blk == 1'b1) | (1'b1 == ap_block_state3_io))) | ((ap_enable_reg_pp0_iter1 == 1'b1) & ((gatewayIP_V_out_full_n == 1'b0) | (myIpAddress_V_out_full_n == 1'b0) | (networkMask_V_empty_n == 1'b0) | (gatewayIP_V_empty_n == 1'b0) | (myIpAddress_V_empty_n == 1'b0) | (myMacAddress_V_empty_n == 1'b0) | (networkMask_V_out_full_n == 1'b0) | (1'b1 == ap_block_state2_io))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((arpReplyFifo_V_empty_n == 1'b0) & (ap_predicate_op14_read_state1 == 1'b1)) | ((arpRequestFifo_V_V_empty_n == 1'b0) & (ap_predicate_op12_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((regslice_both_arpDataOut_V_data_V_U_apdone_blk == 1'b1) | (1'b1 == ap_block_state3_io))) | ((ap_enable_reg_pp0_iter1 == 1'b1) & ((gatewayIP_V_out_full_n == 1'b0) | (myIpAddress_V_out_full_n == 1'b0) | (networkMask_V_empty_n == 1'b0) | (gatewayIP_V_empty_n == 1'b0) | (myIpAddress_V_empty_n == 1'b0) | (myMacAddress_V_empty_n == 1'b0) | (networkMask_V_out_full_n == 1'b0) | (1'b1 == ap_block_state2_io))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((arpReplyFifo_V_empty_n == 1'b0) & (ap_predicate_op14_read_state1 == 1'b1)) | ((arpRequestFifo_V_V_empty_n == 1'b0) & (ap_predicate_op12_read_state1 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_io = (((arpDataOut_TREADY_int == 1'b0) & (aps_fsmState_load_reg_496 == 2'd2)) | ((arpDataOut_TREADY_int == 1'b0) & (aps_fsmState_load_reg_496 == 2'd1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = ((gatewayIP_V_out_full_n == 1'b0) | (myIpAddress_V_out_full_n == 1'b0) | (networkMask_V_empty_n == 1'b0) | (gatewayIP_V_empty_n == 1'b0) | (myIpAddress_V_empty_n == 1'b0) | (myMacAddress_V_empty_n == 1'b0) | (networkMask_V_out_full_n == 1'b0));
end

always @ (*) begin
    ap_block_state3_io = (((arpDataOut_TREADY_int == 1'b0) & (aps_fsmState_load_reg_496_pp0_iter1_reg == 2'd2)) | ((arpDataOut_TREADY_int == 1'b0) & (aps_fsmState_load_reg_496_pp0_iter1_reg == 2'd1)));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = (regslice_both_arpDataOut_V_data_V_U_apdone_blk == 1'b1);
end

always @ (*) begin
    ap_condition_276 = ((1'b0 == ap_block_pp0_stage0_01001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

always @ (*) begin
    ap_predicate_op12_read_state1 = ((tmp_4_nbreadreq_fu_150_p3 == 1'd1) & (tmp_nbreadreq_fu_142_p3 == 1'd0) & (aps_fsmState == 2'd0));
end

always @ (*) begin
    ap_predicate_op14_read_state1 = ((tmp_nbreadreq_fu_142_p3 == 1'd1) & (aps_fsmState == 2'd0));
end

assign aps_fsmState_load_load_fu_239_p1 = aps_fsmState;

assign arpDataOut_TVALID = regslice_both_arpDataOut_V_data_V_U_vld_out;

assign gatewayIP_V_out_din = gatewayIP_V_dout;

assign icmp_ln879_fu_456_p2 = ((and_ln879_fu_450_p2 == 32'd0) ? 1'b1 : 1'b0);

assign myIpAddress_V_out_din = myIpAddress_V_dout;

assign networkMask_V_out_din = networkMask_V_dout;

assign p_Result_1_fu_413_p14 = {{{{{{{{{{{{{{{{{{{{{{{{176'd21438213421863513942334111744}, {replyMeta_protoAddrS}}}, {replyMeta_hwAddrSrc_s}}}, {myIpAddress_V_dout}}}, {myMacAddress_V_dout}}}, {16'd512}}}, {replyMeta_protoLen_V}}}, {replyMeta_hwLen_V}}}, {replyMeta_protoType_s}}}, {replyMeta_hwType_V}}}, {replyMeta_ethType_V}}}, {myMacAddress_V_dout}}}, {replyMeta_srcMac_V}};

assign p_Result_s_fu_470_p9 = {{{{{{{{{{{{{{176'd21438213421863513942334111744}, {select_ln136_fu_462_p3}}}, {48'd0}}}, {myIpAddress_V_dout}}}, {myMacAddress_V_dout}}}, {80'd4722656402130033706504}}}, {myMacAddress_V_dout}}}, {48'd281474976710655}};

assign select_ln136_fu_462_p3 = ((icmp_ln879_fu_456_p2[0:0] === 1'b1) ? inputIP_V : gatewayIP_V_dout);

assign tmp_4_nbreadreq_fu_150_p3 = arpRequestFifo_V_V_empty_n;

assign tmp_nbreadreq_fu_142_p3 = arpReplyFifo_V_empty_n;

assign trunc_ln321_fu_249_p1 = arpReplyFifo_V_dout[47:0];

assign xor_ln879_fu_444_p2 = (myIpAddress_V_dout ^ inputIP_V);

endmodule //arp_pkg_sender