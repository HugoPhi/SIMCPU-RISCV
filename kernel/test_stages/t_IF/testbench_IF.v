`timescale 1ns/1ns

module t_IF();

reg         clk = 0;
reg         rst = 0;
reg [31:0]  EXMEM_d_ALUout = 25;

reg         EXMEM_c_SelPC = 0; // 0: not jump, 1: jump

wire [31:0] IFID_d_inst_update;
wire [31:0] IFID_d_pc_update;

reg  [31:0] IFID_d_inst;
reg  [31:0] IFID_d_pc;

always #5 clk = ~clk;

IF uIF(
    .clk(clk),
    .rst(rst),
    .EXMEM_d_ALUout(EXMEM_d_ALUout),
    
    .EXMEM_c_SelPC(EXMEM_c_SelPC),
    
    .IFID_d_inst(IFID_d_inst_update),
    .IFID_d_pc(IFID_d_pc_update)
);

initial begin
    $dumpfile("t_IF");
    $dumpvars();
    #20;
    rst <= 1; // begin
    
    #40;
    EXMEM_c_SelPC <= 1;
    
    
    #125;
    $finish;
end 


always @(*) begin  // excute ended
    IFID_d_inst    <= IFID_d_inst_update;
    IFID_d_pc      <= IFID_d_pc_update;
    EXMEM_c_SelPC  <= 0;
    EXMEM_d_ALUout <= 3*4;
end


assign Updata = (IFID_d_inst == IFID_d_inst_update) & (IFID_d_pc_update == IFID_d_pc);

always @(posedge clk) begin  // print info
    $display("time: %t, clk: %b, rst: %b, IFID_d_inst: %h, IFID_d_pc: %d, EXMEM_c_SelPC: %d, EXMEM_d_ALUout: %d, Update: %b", $time, clk, rst, IFID_d_inst, IFID_d_pc, EXMEM_c_SelPC, EXMEM_d_ALUout, Updata);
end


endmodule
