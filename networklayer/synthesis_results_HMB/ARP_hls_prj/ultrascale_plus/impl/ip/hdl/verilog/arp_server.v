// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="arp_server,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xcu280-fsvh2892-2L-e,HLS_INPUT_CLOCK=3.100000,HLS_INPUT_ARCH=dataflow,HLS_SYN_CLOCK=3.337000,HLS_SYN_LAT=7,HLS_SYN_TPT=1,HLS_SYN_MEM=18,HLS_SYN_DSP=0,HLS_SYN_FF=1324,HLS_SYN_LUT=2070,HLS_VERSION=2020_1}" *)

module arp_server (
        s_axi_s_axilite_AWVALID,
        s_axi_s_axilite_AWREADY,
        s_axi_s_axilite_AWADDR,
        s_axi_s_axilite_WVALID,
        s_axi_s_axilite_WREADY,
        s_axi_s_axilite_WDATA,
        s_axi_s_axilite_WSTRB,
        s_axi_s_axilite_ARVALID,
        s_axi_s_axilite_ARREADY,
        s_axi_s_axilite_ARADDR,
        s_axi_s_axilite_RVALID,
        s_axi_s_axilite_RREADY,
        s_axi_s_axilite_RDATA,
        s_axi_s_axilite_RRESP,
        s_axi_s_axilite_BVALID,
        s_axi_s_axilite_BREADY,
        s_axi_s_axilite_BRESP,
        ap_clk,
        ap_rst_n,
        arpDataIn_TDATA,
        arpDataIn_TKEEP,
        arpDataIn_TLAST,
        macIpEncode_req_V_V_TDATA,
        arpDataOut_TDATA,
        arpDataOut_TKEEP,
        arpDataOut_TLAST,
        macIpEncode_rsp_V_TDATA,
        myMacAddress_V,
        myIpAddress_V,
        gatewayIP_V,
        networkMask_V,
        macIpEncode_req_V_V_TVALID,
        macIpEncode_req_V_V_TREADY,
        macIpEncode_rsp_V_TVALID,
        macIpEncode_rsp_V_TREADY,
        arpDataIn_TVALID,
        arpDataIn_TREADY,
        arpDataOut_TVALID,
        arpDataOut_TREADY
);

parameter    C_S_AXI_S_AXILITE_DATA_WIDTH = 32;
parameter    C_S_AXI_S_AXILITE_ADDR_WIDTH = 13;
parameter    C_S_AXI_DATA_WIDTH = 32;
parameter    C_S_AXI_ADDR_WIDTH = 32;

parameter C_S_AXI_S_AXILITE_WSTRB_WIDTH = (32 / 8);
parameter C_S_AXI_WSTRB_WIDTH = (32 / 8);

input   s_axi_s_axilite_AWVALID;
output   s_axi_s_axilite_AWREADY;
input  [C_S_AXI_S_AXILITE_ADDR_WIDTH - 1:0] s_axi_s_axilite_AWADDR;
input   s_axi_s_axilite_WVALID;
output   s_axi_s_axilite_WREADY;
input  [C_S_AXI_S_AXILITE_DATA_WIDTH - 1:0] s_axi_s_axilite_WDATA;
input  [C_S_AXI_S_AXILITE_WSTRB_WIDTH - 1:0] s_axi_s_axilite_WSTRB;
input   s_axi_s_axilite_ARVALID;
output   s_axi_s_axilite_ARREADY;
input  [C_S_AXI_S_AXILITE_ADDR_WIDTH - 1:0] s_axi_s_axilite_ARADDR;
output   s_axi_s_axilite_RVALID;
input   s_axi_s_axilite_RREADY;
output  [C_S_AXI_S_AXILITE_DATA_WIDTH - 1:0] s_axi_s_axilite_RDATA;
output  [1:0] s_axi_s_axilite_RRESP;
output   s_axi_s_axilite_BVALID;
input   s_axi_s_axilite_BREADY;
output  [1:0] s_axi_s_axilite_BRESP;
input   ap_clk;
input   ap_rst_n;
input  [511:0] arpDataIn_TDATA;
input  [63:0] arpDataIn_TKEEP;
input  [0:0] arpDataIn_TLAST;
input  [31:0] macIpEncode_req_V_V_TDATA;
output  [511:0] arpDataOut_TDATA;
output  [63:0] arpDataOut_TKEEP;
output  [0:0] arpDataOut_TLAST;
output  [55:0] macIpEncode_rsp_V_TDATA;
input  [47:0] myMacAddress_V;
input  [31:0] myIpAddress_V;
input  [31:0] gatewayIP_V;
input  [31:0] networkMask_V;
input   macIpEncode_req_V_V_TVALID;
output   macIpEncode_req_V_V_TREADY;
output   macIpEncode_rsp_V_TVALID;
input   macIpEncode_rsp_V_TREADY;
input   arpDataIn_TVALID;
output   arpDataIn_TREADY;
output   arpDataOut_TVALID;
input   arpDataOut_TREADY;

 reg    ap_rst_n_inv;
wire   [47:0] arpTable_macAddress_V_q0;
wire   [0:0] arpTable_valid_V_q0;
wire   [0:0] arp_scan_V_i;
wire    arp_server_entry174_U0_ap_start;
wire    arp_server_entry174_U0_ap_done;
wire    arp_server_entry174_U0_ap_continue;
wire    arp_server_entry174_U0_ap_idle;
wire    arp_server_entry174_U0_ap_ready;
wire   [47:0] arp_server_entry174_U0_myMacAddress_V_out_din;
wire    arp_server_entry174_U0_myMacAddress_V_out_write;
wire   [31:0] arp_server_entry174_U0_myIpAddress_V_out_din;
wire    arp_server_entry174_U0_myIpAddress_V_out_write;
wire   [31:0] arp_server_entry174_U0_myIpAddress_V_out1_din;
wire    arp_server_entry174_U0_myIpAddress_V_out1_write;
wire   [31:0] arp_server_entry174_U0_gatewayIP_V_out_din;
wire    arp_server_entry174_U0_gatewayIP_V_out_write;
wire   [31:0] arp_server_entry174_U0_networkMask_V_out_din;
wire    arp_server_entry174_U0_networkMask_V_out_write;
wire    genARPDiscovery_U0_ap_start;
wire    genARPDiscovery_U0_ap_done;
wire    genARPDiscovery_U0_ap_continue;
wire    genARPDiscovery_U0_ap_idle;
wire    genARPDiscovery_U0_ap_ready;
wire    genARPDiscovery_U0_macIpEncode_rsp_i_V_read;
wire    genARPDiscovery_U0_myIpAddress_V_read;
wire   [31:0] genARPDiscovery_U0_macIpEncode_i_V_V_din;
wire    genARPDiscovery_U0_macIpEncode_i_V_V_write;
wire    genARPDiscovery_U0_macIpEncodeIn_V_V_TREADY;
wire   [55:0] genARPDiscovery_U0_macIpEncode_rsp_o_V_TDATA;
wire    genARPDiscovery_U0_macIpEncode_rsp_o_V_TVALID;
wire   [0:0] genARPDiscovery_U0_arp_scan_V_o;
wire    genARPDiscovery_U0_arp_scan_V_o_ap_vld;
wire    ap_sync_continue;
wire    arp_pkg_receiver_U0_ap_start;
wire    arp_pkg_receiver_U0_ap_done;
wire    arp_pkg_receiver_U0_ap_continue;
wire    arp_pkg_receiver_U0_ap_idle;
wire    arp_pkg_receiver_U0_ap_ready;
wire    arp_pkg_receiver_U0_myIpAddress_V_read;
wire   [31:0] arp_pkg_receiver_U0_myIpAddress_V_out_din;
wire    arp_pkg_receiver_U0_myIpAddress_V_out_write;
wire   [80:0] arp_pkg_receiver_U0_arpTableInsertFifo_V_din;
wire    arp_pkg_receiver_U0_arpTableInsertFifo_V_write;
wire   [191:0] arp_pkg_receiver_U0_arpReplyFifo_V_din;
wire    arp_pkg_receiver_U0_arpReplyFifo_V_write;
wire    arp_pkg_receiver_U0_arpDataIn_TREADY;
wire    arp_pkg_sender_U0_ap_start;
wire    arp_pkg_sender_U0_ap_done;
wire    arp_pkg_sender_U0_ap_continue;
wire    arp_pkg_sender_U0_ap_idle;
wire    arp_pkg_sender_U0_ap_ready;
wire    arp_pkg_sender_U0_arpRequestFifo_V_V_read;
wire    arp_pkg_sender_U0_arpReplyFifo_V_read;
wire    arp_pkg_sender_U0_myIpAddress_V_read;
wire    arp_pkg_sender_U0_gatewayIP_V_read;
wire    arp_pkg_sender_U0_networkMask_V_read;
wire   [31:0] arp_pkg_sender_U0_myIpAddress_V_out_din;
wire    arp_pkg_sender_U0_myIpAddress_V_out_write;
wire   [31:0] arp_pkg_sender_U0_gatewayIP_V_out_din;
wire    arp_pkg_sender_U0_gatewayIP_V_out_write;
wire   [31:0] arp_pkg_sender_U0_networkMask_V_out_din;
wire    arp_pkg_sender_U0_networkMask_V_out_write;
wire    arp_pkg_sender_U0_myMacAddress_V_read;
wire   [511:0] arp_pkg_sender_U0_arpDataOut_TDATA;
wire    arp_pkg_sender_U0_arpDataOut_TVALID;
wire   [63:0] arp_pkg_sender_U0_arpDataOut_TKEEP;
wire   [0:0] arp_pkg_sender_U0_arpDataOut_TLAST;
wire    arp_table_U0_ap_start;
wire    arp_table_U0_ap_done;
wire    arp_table_U0_ap_continue;
wire    arp_table_U0_ap_idle;
wire    arp_table_U0_ap_ready;
wire    arp_table_U0_myIpAddress_V_read;
wire    arp_table_U0_gatewayIP_V_read;
wire    arp_table_U0_networkMask_V_read;
wire    arp_table_U0_macIpEncode_i_V_V_read;
wire    arp_table_U0_arpTableInsertFifo_V_read;
wire   [48:0] arp_table_U0_macIpEncode_rsp_i_V_din;
wire    arp_table_U0_macIpEncode_rsp_i_V_write;
wire   [31:0] arp_table_U0_arpRequestFifo_V_V_din;
wire    arp_table_U0_arpRequestFifo_V_V_write;
wire   [7:0] arp_table_U0_arpTable_macAddress_V_address0;
wire    arp_table_U0_arpTable_macAddress_V_ce0;
wire    arp_table_U0_arpTable_macAddress_V_we0;
wire   [47:0] arp_table_U0_arpTable_macAddress_V_d0;
wire   [7:0] arp_table_U0_arpTable_ipAddress_V_address0;
wire    arp_table_U0_arpTable_ipAddress_V_ce0;
wire    arp_table_U0_arpTable_ipAddress_V_we0;
wire   [31:0] arp_table_U0_arpTable_ipAddress_V_d0;
wire   [7:0] arp_table_U0_arpTable_valid_V_address0;
wire    arp_table_U0_arpTable_valid_V_ce0;
wire    arp_table_U0_arpTable_valid_V_we0;
wire   [0:0] arp_table_U0_arpTable_valid_V_d0;
wire    myMacAddress_V_c_full_n;
wire   [47:0] myMacAddress_V_c_dout;
wire    myMacAddress_V_c_empty_n;
wire    myIpAddress_V_c_full_n;
wire   [31:0] myIpAddress_V_c_dout;
wire    myIpAddress_V_c_empty_n;
wire    myIpAddress_V_c40_full_n;
wire   [31:0] myIpAddress_V_c40_dout;
wire    myIpAddress_V_c40_empty_n;
wire    gatewayIP_V_c_full_n;
wire   [31:0] gatewayIP_V_c_dout;
wire    gatewayIP_V_c_empty_n;
wire    networkMask_V_c_full_n;
wire   [31:0] networkMask_V_c_dout;
wire    networkMask_V_c_empty_n;
wire    macIpEncode_i_V_V_full_n;
wire   [31:0] macIpEncode_i_V_V_dout;
wire    macIpEncode_i_V_V_empty_n;
wire    macIpEncode_rsp_i_V_full_n;
wire   [48:0] macIpEncode_rsp_i_V_dout;
wire    macIpEncode_rsp_i_V_empty_n;
wire    myIpAddress_V_c41_full_n;
wire   [31:0] myIpAddress_V_c41_dout;
wire    myIpAddress_V_c41_empty_n;
wire    arpReplyFifo_V_full_n;
wire   [191:0] arpReplyFifo_V_dout;
wire    arpReplyFifo_V_empty_n;
wire    arpTableInsertFifo_V_full_n;
wire   [80:0] arpTableInsertFifo_V_dout;
wire    arpTableInsertFifo_V_empty_n;
wire    myIpAddress_V_c42_full_n;
wire   [31:0] myIpAddress_V_c42_dout;
wire    myIpAddress_V_c42_empty_n;
wire    gatewayIP_V_c43_full_n;
wire   [31:0] gatewayIP_V_c43_dout;
wire    gatewayIP_V_c43_empty_n;
wire    networkMask_V_c44_full_n;
wire   [31:0] networkMask_V_c44_dout;
wire    networkMask_V_c44_empty_n;
wire    arpRequestFifo_V_V_full_n;
wire   [31:0] arpRequestFifo_V_V_dout;
wire    arpRequestFifo_V_V_empty_n;

arp_server_s_axilite_s_axi #(
    .C_S_AXI_ADDR_WIDTH( C_S_AXI_S_AXILITE_ADDR_WIDTH ),
    .C_S_AXI_DATA_WIDTH( C_S_AXI_S_AXILITE_DATA_WIDTH ))
arp_server_s_axilite_s_axi_U(
    .AWVALID(s_axi_s_axilite_AWVALID),
    .AWREADY(s_axi_s_axilite_AWREADY),
    .AWADDR(s_axi_s_axilite_AWADDR),
    .WVALID(s_axi_s_axilite_WVALID),
    .WREADY(s_axi_s_axilite_WREADY),
    .WDATA(s_axi_s_axilite_WDATA),
    .WSTRB(s_axi_s_axilite_WSTRB),
    .ARVALID(s_axi_s_axilite_ARVALID),
    .ARREADY(s_axi_s_axilite_ARREADY),
    .ARADDR(s_axi_s_axilite_ARADDR),
    .RVALID(s_axi_s_axilite_RVALID),
    .RREADY(s_axi_s_axilite_RREADY),
    .RDATA(s_axi_s_axilite_RDATA),
    .RRESP(s_axi_s_axilite_RRESP),
    .BVALID(s_axi_s_axilite_BVALID),
    .BREADY(s_axi_s_axilite_BREADY),
    .BRESP(s_axi_s_axilite_BRESP),
    .ACLK(ap_clk),
    .ARESET(ap_rst_n_inv),
    .ACLK_EN(1'b1),
    .arpTable_macAddress_V_address0(arp_table_U0_arpTable_macAddress_V_address0),
    .arpTable_macAddress_V_ce0(arp_table_U0_arpTable_macAddress_V_ce0),
    .arpTable_macAddress_V_we0(arp_table_U0_arpTable_macAddress_V_we0),
    .arpTable_macAddress_V_d0(arp_table_U0_arpTable_macAddress_V_d0),
    .arpTable_macAddress_V_q0(arpTable_macAddress_V_q0),
    .arpTable_ipAddress_V_address0(arp_table_U0_arpTable_ipAddress_V_address0),
    .arpTable_ipAddress_V_ce0(arp_table_U0_arpTable_ipAddress_V_ce0),
    .arpTable_ipAddress_V_we0(arp_table_U0_arpTable_ipAddress_V_we0),
    .arpTable_ipAddress_V_d0(arp_table_U0_arpTable_ipAddress_V_d0),
    .arpTable_valid_V_address0(arp_table_U0_arpTable_valid_V_address0),
    .arpTable_valid_V_ce0(arp_table_U0_arpTable_valid_V_ce0),
    .arpTable_valid_V_we0(arp_table_U0_arpTable_valid_V_we0),
    .arpTable_valid_V_d0(arp_table_U0_arpTable_valid_V_d0),
    .arpTable_valid_V_q0(arpTable_valid_V_q0),
    .arp_scan_V_o(genARPDiscovery_U0_arp_scan_V_o),
    .arp_scan_V_o_ap_vld(genARPDiscovery_U0_arp_scan_V_o_ap_vld),
    .arp_scan_V_i(arp_scan_V_i)
);

arp_server_entry174 arp_server_entry174_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(arp_server_entry174_U0_ap_start),
    .ap_done(arp_server_entry174_U0_ap_done),
    .ap_continue(arp_server_entry174_U0_ap_continue),
    .ap_idle(arp_server_entry174_U0_ap_idle),
    .ap_ready(arp_server_entry174_U0_ap_ready),
    .myMacAddress_V(myMacAddress_V),
    .myIpAddress_V(myIpAddress_V),
    .gatewayIP_V(gatewayIP_V),
    .networkMask_V(networkMask_V),
    .myMacAddress_V_out_din(arp_server_entry174_U0_myMacAddress_V_out_din),
    .myMacAddress_V_out_full_n(myMacAddress_V_c_full_n),
    .myMacAddress_V_out_write(arp_server_entry174_U0_myMacAddress_V_out_write),
    .myIpAddress_V_out_din(arp_server_entry174_U0_myIpAddress_V_out_din),
    .myIpAddress_V_out_full_n(myIpAddress_V_c_full_n),
    .myIpAddress_V_out_write(arp_server_entry174_U0_myIpAddress_V_out_write),
    .myIpAddress_V_out1_din(arp_server_entry174_U0_myIpAddress_V_out1_din),
    .myIpAddress_V_out1_full_n(myIpAddress_V_c40_full_n),
    .myIpAddress_V_out1_write(arp_server_entry174_U0_myIpAddress_V_out1_write),
    .gatewayIP_V_out_din(arp_server_entry174_U0_gatewayIP_V_out_din),
    .gatewayIP_V_out_full_n(gatewayIP_V_c_full_n),
    .gatewayIP_V_out_write(arp_server_entry174_U0_gatewayIP_V_out_write),
    .networkMask_V_out_din(arp_server_entry174_U0_networkMask_V_out_din),
    .networkMask_V_out_full_n(networkMask_V_c_full_n),
    .networkMask_V_out_write(arp_server_entry174_U0_networkMask_V_out_write)
);

genARPDiscovery genARPDiscovery_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(genARPDiscovery_U0_ap_start),
    .ap_done(genARPDiscovery_U0_ap_done),
    .ap_continue(genARPDiscovery_U0_ap_continue),
    .ap_idle(genARPDiscovery_U0_ap_idle),
    .ap_ready(genARPDiscovery_U0_ap_ready),
    .macIpEncodeIn_V_V_TVALID(macIpEncode_req_V_V_TVALID),
    .macIpEncode_rsp_i_V_dout(macIpEncode_rsp_i_V_dout),
    .macIpEncode_rsp_i_V_empty_n(macIpEncode_rsp_i_V_empty_n),
    .macIpEncode_rsp_i_V_read(genARPDiscovery_U0_macIpEncode_rsp_i_V_read),
    .myIpAddress_V_dout(myIpAddress_V_c_dout),
    .myIpAddress_V_empty_n(myIpAddress_V_c_empty_n),
    .myIpAddress_V_read(genARPDiscovery_U0_myIpAddress_V_read),
    .macIpEncode_i_V_V_din(genARPDiscovery_U0_macIpEncode_i_V_V_din),
    .macIpEncode_i_V_V_full_n(macIpEncode_i_V_V_full_n),
    .macIpEncode_i_V_V_write(genARPDiscovery_U0_macIpEncode_i_V_V_write),
    .macIpEncode_rsp_o_V_TREADY(macIpEncode_rsp_V_TREADY),
    .macIpEncodeIn_V_V_TDATA(macIpEncode_req_V_V_TDATA),
    .macIpEncodeIn_V_V_TREADY(genARPDiscovery_U0_macIpEncodeIn_V_V_TREADY),
    .macIpEncode_rsp_o_V_TDATA(genARPDiscovery_U0_macIpEncode_rsp_o_V_TDATA),
    .macIpEncode_rsp_o_V_TVALID(genARPDiscovery_U0_macIpEncode_rsp_o_V_TVALID),
    .arp_scan_V_i(arp_scan_V_i),
    .arp_scan_V_o(genARPDiscovery_U0_arp_scan_V_o),
    .arp_scan_V_o_ap_vld(genARPDiscovery_U0_arp_scan_V_o_ap_vld)
);

arp_pkg_receiver arp_pkg_receiver_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(arp_pkg_receiver_U0_ap_start),
    .ap_done(arp_pkg_receiver_U0_ap_done),
    .ap_continue(arp_pkg_receiver_U0_ap_continue),
    .ap_idle(arp_pkg_receiver_U0_ap_idle),
    .ap_ready(arp_pkg_receiver_U0_ap_ready),
    .myIpAddress_V_dout(myIpAddress_V_c40_dout),
    .myIpAddress_V_empty_n(myIpAddress_V_c40_empty_n),
    .myIpAddress_V_read(arp_pkg_receiver_U0_myIpAddress_V_read),
    .myIpAddress_V_out_din(arp_pkg_receiver_U0_myIpAddress_V_out_din),
    .myIpAddress_V_out_full_n(myIpAddress_V_c41_full_n),
    .myIpAddress_V_out_write(arp_pkg_receiver_U0_myIpAddress_V_out_write),
    .arpDataIn_TVALID(arpDataIn_TVALID),
    .arpTableInsertFifo_V_din(arp_pkg_receiver_U0_arpTableInsertFifo_V_din),
    .arpTableInsertFifo_V_full_n(arpTableInsertFifo_V_full_n),
    .arpTableInsertFifo_V_write(arp_pkg_receiver_U0_arpTableInsertFifo_V_write),
    .arpReplyFifo_V_din(arp_pkg_receiver_U0_arpReplyFifo_V_din),
    .arpReplyFifo_V_full_n(arpReplyFifo_V_full_n),
    .arpReplyFifo_V_write(arp_pkg_receiver_U0_arpReplyFifo_V_write),
    .arpDataIn_TDATA(arpDataIn_TDATA),
    .arpDataIn_TREADY(arp_pkg_receiver_U0_arpDataIn_TREADY),
    .arpDataIn_TKEEP(arpDataIn_TKEEP),
    .arpDataIn_TLAST(arpDataIn_TLAST)
);

arp_pkg_sender arp_pkg_sender_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(arp_pkg_sender_U0_ap_start),
    .ap_done(arp_pkg_sender_U0_ap_done),
    .ap_continue(arp_pkg_sender_U0_ap_continue),
    .ap_idle(arp_pkg_sender_U0_ap_idle),
    .ap_ready(arp_pkg_sender_U0_ap_ready),
    .arpRequestFifo_V_V_dout(arpRequestFifo_V_V_dout),
    .arpRequestFifo_V_V_empty_n(arpRequestFifo_V_V_empty_n),
    .arpRequestFifo_V_V_read(arp_pkg_sender_U0_arpRequestFifo_V_V_read),
    .arpReplyFifo_V_dout(arpReplyFifo_V_dout),
    .arpReplyFifo_V_empty_n(arpReplyFifo_V_empty_n),
    .arpReplyFifo_V_read(arp_pkg_sender_U0_arpReplyFifo_V_read),
    .myIpAddress_V_dout(myIpAddress_V_c41_dout),
    .myIpAddress_V_empty_n(myIpAddress_V_c41_empty_n),
    .myIpAddress_V_read(arp_pkg_sender_U0_myIpAddress_V_read),
    .gatewayIP_V_dout(gatewayIP_V_c_dout),
    .gatewayIP_V_empty_n(gatewayIP_V_c_empty_n),
    .gatewayIP_V_read(arp_pkg_sender_U0_gatewayIP_V_read),
    .networkMask_V_dout(networkMask_V_c_dout),
    .networkMask_V_empty_n(networkMask_V_c_empty_n),
    .networkMask_V_read(arp_pkg_sender_U0_networkMask_V_read),
    .myIpAddress_V_out_din(arp_pkg_sender_U0_myIpAddress_V_out_din),
    .myIpAddress_V_out_full_n(myIpAddress_V_c42_full_n),
    .myIpAddress_V_out_write(arp_pkg_sender_U0_myIpAddress_V_out_write),
    .gatewayIP_V_out_din(arp_pkg_sender_U0_gatewayIP_V_out_din),
    .gatewayIP_V_out_full_n(gatewayIP_V_c43_full_n),
    .gatewayIP_V_out_write(arp_pkg_sender_U0_gatewayIP_V_out_write),
    .networkMask_V_out_din(arp_pkg_sender_U0_networkMask_V_out_din),
    .networkMask_V_out_full_n(networkMask_V_c44_full_n),
    .networkMask_V_out_write(arp_pkg_sender_U0_networkMask_V_out_write),
    .myMacAddress_V_dout(myMacAddress_V_c_dout),
    .myMacAddress_V_empty_n(myMacAddress_V_c_empty_n),
    .myMacAddress_V_read(arp_pkg_sender_U0_myMacAddress_V_read),
    .arpDataOut_TREADY(arpDataOut_TREADY),
    .arpDataOut_TDATA(arp_pkg_sender_U0_arpDataOut_TDATA),
    .arpDataOut_TVALID(arp_pkg_sender_U0_arpDataOut_TVALID),
    .arpDataOut_TKEEP(arp_pkg_sender_U0_arpDataOut_TKEEP),
    .arpDataOut_TLAST(arp_pkg_sender_U0_arpDataOut_TLAST)
);

arp_table arp_table_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(arp_table_U0_ap_start),
    .ap_done(arp_table_U0_ap_done),
    .ap_continue(arp_table_U0_ap_continue),
    .ap_idle(arp_table_U0_ap_idle),
    .ap_ready(arp_table_U0_ap_ready),
    .myIpAddress_V_dout(myIpAddress_V_c42_dout),
    .myIpAddress_V_empty_n(myIpAddress_V_c42_empty_n),
    .myIpAddress_V_read(arp_table_U0_myIpAddress_V_read),
    .gatewayIP_V_dout(gatewayIP_V_c43_dout),
    .gatewayIP_V_empty_n(gatewayIP_V_c43_empty_n),
    .gatewayIP_V_read(arp_table_U0_gatewayIP_V_read),
    .networkMask_V_dout(networkMask_V_c44_dout),
    .networkMask_V_empty_n(networkMask_V_c44_empty_n),
    .networkMask_V_read(arp_table_U0_networkMask_V_read),
    .macIpEncode_i_V_V_dout(macIpEncode_i_V_V_dout),
    .macIpEncode_i_V_V_empty_n(macIpEncode_i_V_V_empty_n),
    .macIpEncode_i_V_V_read(arp_table_U0_macIpEncode_i_V_V_read),
    .arpTableInsertFifo_V_dout(arpTableInsertFifo_V_dout),
    .arpTableInsertFifo_V_empty_n(arpTableInsertFifo_V_empty_n),
    .arpTableInsertFifo_V_read(arp_table_U0_arpTableInsertFifo_V_read),
    .macIpEncode_rsp_i_V_din(arp_table_U0_macIpEncode_rsp_i_V_din),
    .macIpEncode_rsp_i_V_full_n(macIpEncode_rsp_i_V_full_n),
    .macIpEncode_rsp_i_V_write(arp_table_U0_macIpEncode_rsp_i_V_write),
    .arpRequestFifo_V_V_din(arp_table_U0_arpRequestFifo_V_V_din),
    .arpRequestFifo_V_V_full_n(arpRequestFifo_V_V_full_n),
    .arpRequestFifo_V_V_write(arp_table_U0_arpRequestFifo_V_V_write),
    .arpTable_macAddress_V_address0(arp_table_U0_arpTable_macAddress_V_address0),
    .arpTable_macAddress_V_ce0(arp_table_U0_arpTable_macAddress_V_ce0),
    .arpTable_macAddress_V_we0(arp_table_U0_arpTable_macAddress_V_we0),
    .arpTable_macAddress_V_d0(arp_table_U0_arpTable_macAddress_V_d0),
    .arpTable_macAddress_V_q0(arpTable_macAddress_V_q0),
    .arpTable_ipAddress_V_address0(arp_table_U0_arpTable_ipAddress_V_address0),
    .arpTable_ipAddress_V_ce0(arp_table_U0_arpTable_ipAddress_V_ce0),
    .arpTable_ipAddress_V_we0(arp_table_U0_arpTable_ipAddress_V_we0),
    .arpTable_ipAddress_V_d0(arp_table_U0_arpTable_ipAddress_V_d0),
    .arpTable_valid_V_address0(arp_table_U0_arpTable_valid_V_address0),
    .arpTable_valid_V_ce0(arp_table_U0_arpTable_valid_V_ce0),
    .arpTable_valid_V_we0(arp_table_U0_arpTable_valid_V_we0),
    .arpTable_valid_V_d0(arp_table_U0_arpTable_valid_V_d0),
    .arpTable_valid_V_q0(arpTable_valid_V_q0)
);

fifo_w48_d3_A myMacAddress_V_c_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(arp_server_entry174_U0_myMacAddress_V_out_din),
    .if_full_n(myMacAddress_V_c_full_n),
    .if_write(arp_server_entry174_U0_myMacAddress_V_out_write),
    .if_dout(myMacAddress_V_c_dout),
    .if_empty_n(myMacAddress_V_c_empty_n),
    .if_read(arp_pkg_sender_U0_myMacAddress_V_read)
);

fifo_w32_d2_A myIpAddress_V_c_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(arp_server_entry174_U0_myIpAddress_V_out_din),
    .if_full_n(myIpAddress_V_c_full_n),
    .if_write(arp_server_entry174_U0_myIpAddress_V_out_write),
    .if_dout(myIpAddress_V_c_dout),
    .if_empty_n(myIpAddress_V_c_empty_n),
    .if_read(genARPDiscovery_U0_myIpAddress_V_read)
);

fifo_w32_d2_A myIpAddress_V_c40_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(arp_server_entry174_U0_myIpAddress_V_out1_din),
    .if_full_n(myIpAddress_V_c40_full_n),
    .if_write(arp_server_entry174_U0_myIpAddress_V_out1_write),
    .if_dout(myIpAddress_V_c40_dout),
    .if_empty_n(myIpAddress_V_c40_empty_n),
    .if_read(arp_pkg_receiver_U0_myIpAddress_V_read)
);

fifo_w32_d3_A gatewayIP_V_c_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(arp_server_entry174_U0_gatewayIP_V_out_din),
    .if_full_n(gatewayIP_V_c_full_n),
    .if_write(arp_server_entry174_U0_gatewayIP_V_out_write),
    .if_dout(gatewayIP_V_c_dout),
    .if_empty_n(gatewayIP_V_c_empty_n),
    .if_read(arp_pkg_sender_U0_gatewayIP_V_read)
);

fifo_w32_d3_A networkMask_V_c_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(arp_server_entry174_U0_networkMask_V_out_din),
    .if_full_n(networkMask_V_c_full_n),
    .if_write(arp_server_entry174_U0_networkMask_V_out_write),
    .if_dout(networkMask_V_c_dout),
    .if_empty_n(networkMask_V_c_empty_n),
    .if_read(arp_pkg_sender_U0_networkMask_V_read)
);

fifo_w32_d4_A macIpEncode_i_V_V_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(genARPDiscovery_U0_macIpEncode_i_V_V_din),
    .if_full_n(macIpEncode_i_V_V_full_n),
    .if_write(genARPDiscovery_U0_macIpEncode_i_V_V_write),
    .if_dout(macIpEncode_i_V_V_dout),
    .if_empty_n(macIpEncode_i_V_V_empty_n),
    .if_read(arp_table_U0_macIpEncode_i_V_V_read)
);

fifo_w49_d4_A macIpEncode_rsp_i_V_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(arp_table_U0_macIpEncode_rsp_i_V_din),
    .if_full_n(macIpEncode_rsp_i_V_full_n),
    .if_write(arp_table_U0_macIpEncode_rsp_i_V_write),
    .if_dout(macIpEncode_rsp_i_V_dout),
    .if_empty_n(macIpEncode_rsp_i_V_empty_n),
    .if_read(genARPDiscovery_U0_macIpEncode_rsp_i_V_read)
);

fifo_w32_d2_A myIpAddress_V_c41_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(arp_pkg_receiver_U0_myIpAddress_V_out_din),
    .if_full_n(myIpAddress_V_c41_full_n),
    .if_write(arp_pkg_receiver_U0_myIpAddress_V_out_write),
    .if_dout(myIpAddress_V_c41_dout),
    .if_empty_n(myIpAddress_V_c41_empty_n),
    .if_read(arp_pkg_sender_U0_myIpAddress_V_read)
);

fifo_w192_d4_A arpReplyFifo_V_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(arp_pkg_receiver_U0_arpReplyFifo_V_din),
    .if_full_n(arpReplyFifo_V_full_n),
    .if_write(arp_pkg_receiver_U0_arpReplyFifo_V_write),
    .if_dout(arpReplyFifo_V_dout),
    .if_empty_n(arpReplyFifo_V_empty_n),
    .if_read(arp_pkg_sender_U0_arpReplyFifo_V_read)
);

fifo_w81_d4_A arpTableInsertFifo_V_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(arp_pkg_receiver_U0_arpTableInsertFifo_V_din),
    .if_full_n(arpTableInsertFifo_V_full_n),
    .if_write(arp_pkg_receiver_U0_arpTableInsertFifo_V_write),
    .if_dout(arpTableInsertFifo_V_dout),
    .if_empty_n(arpTableInsertFifo_V_empty_n),
    .if_read(arp_table_U0_arpTableInsertFifo_V_read)
);

fifo_w32_d2_A myIpAddress_V_c42_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(arp_pkg_sender_U0_myIpAddress_V_out_din),
    .if_full_n(myIpAddress_V_c42_full_n),
    .if_write(arp_pkg_sender_U0_myIpAddress_V_out_write),
    .if_dout(myIpAddress_V_c42_dout),
    .if_empty_n(myIpAddress_V_c42_empty_n),
    .if_read(arp_table_U0_myIpAddress_V_read)
);

fifo_w32_d2_A gatewayIP_V_c43_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(arp_pkg_sender_U0_gatewayIP_V_out_din),
    .if_full_n(gatewayIP_V_c43_full_n),
    .if_write(arp_pkg_sender_U0_gatewayIP_V_out_write),
    .if_dout(gatewayIP_V_c43_dout),
    .if_empty_n(gatewayIP_V_c43_empty_n),
    .if_read(arp_table_U0_gatewayIP_V_read)
);

fifo_w32_d2_A networkMask_V_c44_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(arp_pkg_sender_U0_networkMask_V_out_din),
    .if_full_n(networkMask_V_c44_full_n),
    .if_write(arp_pkg_sender_U0_networkMask_V_out_write),
    .if_dout(networkMask_V_c44_dout),
    .if_empty_n(networkMask_V_c44_empty_n),
    .if_read(arp_table_U0_networkMask_V_read)
);

fifo_w32_d4_A arpRequestFifo_V_V_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(arp_table_U0_arpRequestFifo_V_V_din),
    .if_full_n(arpRequestFifo_V_V_full_n),
    .if_write(arp_table_U0_arpRequestFifo_V_V_write),
    .if_dout(arpRequestFifo_V_V_dout),
    .if_empty_n(arpRequestFifo_V_V_empty_n),
    .if_read(arp_pkg_sender_U0_arpRequestFifo_V_V_read)
);

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign ap_sync_continue = 1'b0;

assign arpDataIn_TREADY = arp_pkg_receiver_U0_arpDataIn_TREADY;

assign arpDataOut_TDATA = arp_pkg_sender_U0_arpDataOut_TDATA;

assign arpDataOut_TKEEP = arp_pkg_sender_U0_arpDataOut_TKEEP;

assign arpDataOut_TLAST = arp_pkg_sender_U0_arpDataOut_TLAST;

assign arpDataOut_TVALID = arp_pkg_sender_U0_arpDataOut_TVALID;

assign arp_pkg_receiver_U0_ap_continue = 1'b1;

assign arp_pkg_receiver_U0_ap_start = 1'b1;

assign arp_pkg_sender_U0_ap_continue = 1'b1;

assign arp_pkg_sender_U0_ap_start = 1'b1;

assign arp_server_entry174_U0_ap_continue = 1'b1;

assign arp_server_entry174_U0_ap_start = 1'b1;

assign arp_table_U0_ap_continue = 1'b1;

assign arp_table_U0_ap_start = 1'b1;

assign genARPDiscovery_U0_ap_continue = 1'b1;

assign genARPDiscovery_U0_ap_start = 1'b1;

assign macIpEncode_req_V_V_TREADY = genARPDiscovery_U0_macIpEncodeIn_V_V_TREADY;

assign macIpEncode_rsp_V_TDATA = genARPDiscovery_U0_macIpEncode_rsp_o_V_TDATA;

assign macIpEncode_rsp_V_TVALID = genARPDiscovery_U0_macIpEncode_rsp_o_V_TVALID;

endmodule //arp_server