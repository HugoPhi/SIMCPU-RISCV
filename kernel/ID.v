module ID (
    input  wire [31:0]  IFID_d_pc;
    input  wire [31:0]  IFID_d_inst;
    input  wire [31:0]  MEMWB_d_inst;
    input  wire [31:0]  WB_d_rd;
    
    input  wire         MEMWB_c_SelWSrc;
    input  wire         MEMWB_c_EnWReg;
    
    output wire [31:0]  IDEX_d_inst;
    output wire [31:0]  IDEX_d_pc;
    output wire [31:0]  IDEX_d_rs1;
    output wire [31:0]  IDEX_d_rs2;
    output wire [31:0]  IDEX_d_imm;
);


reg  [4:0] ix1    = IFID_d_inst[19:15];
reg  [4:0] ix2    = IFID_d_inst[24:20];
reg  [4:0] ixrd   = MEMWB_d_inst[11:7];

wire [4:0] SelImm;


control u_control(
    .inst(IFID_d_inst),
    
    .RegWEn(),
    .SelRegSrc(),
    .EnRDMem(),
    .EnWDMem(),
    .SelBranch(),
    .SelALUop(),
    .SelALUsrc(),
    .SelImm(SelImm)
);


reg_file u_reg_file(
    .ix1(ix1),
    .ix2(ix2),
    
    .rs1(IDEX_d_rs1),
    .rs2(IDEX_d_rs2)
);  // output IDEX_d_rs1, IDEX_d_rs2 (END)


imm_gen(
    .instimm(IFID_d_inst[31:7]),
    .SelImm(SelImm),
    
    .imm(IDEX_d_imm)
);  // output IDEX_d_imm



endmodule
