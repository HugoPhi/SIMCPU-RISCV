module imm_gen(
    input  wire [31:7]  instimm,
    input  wire [2 :0]  SelImm,
    
    output wire [31:0]  imm
);

// I-types: SelImm
parameter I_  = 3'b000;
parameter IU_ = 3'b001;
parameter S_  = 3'b010;
parameter B_  = 3'b011;
parameter U_  = 3'b100;
parameter J_  = 3'b101;





endmodule

