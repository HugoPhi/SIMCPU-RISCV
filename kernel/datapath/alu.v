module alu (
    input  wire [31:0]  rs1,  // reg1
    input  wire [31:0]  rs2,  // reg2 or imm
    input  wire [3 :0]  ALUop,
    
    output wire [31:0]  ALUout,
    output wire         Zero
);


parameter ADD = 4'b0000;
parameter SUB = 4'b0001;
parameter OR  = 4'b0010;
parameter AND = 4'b0011;
parameter XOR = 4'b0100;
parameter SRA = 4'b0101;
parameter SRL = 4'b0110;
parameter SLL = 4'b0111;
parameter LT  = 4'b1000;
parameter LTU = 4'b1001;
parameter EQ  = 4'b1010;


reg [31:0] rd;
integer irs1;
integer irs2;


assign [31:0] sra = rs1[31] ? ~((~rs1) >> rs2) : rs1 >> rs2;


always@(*) begin
    irs1 <= rs1;
    irs2 <= rs2;
end


always @(*) begin
    case ALUop
        ADD:
            rd   <= rs1 + rs2;
        SUB:
            rd   <= rs1 - rs2;
        OR:
            rd   <= rs1 | rs2;
        AND:
            rd   <= rs1 & rs2;
        XOR:
            rd   <= rs1 ^ rs2;
        SRA:
            rd   <= sra;
        SRL:
            rd   <= rs1 >> rs2;
        SLL:
            rd   <= rs1 << rs2;
        LT:
            rd   <= irs1 < irs2;
            Zero <= rs1 == rs2;
        LTU:
            rd   <= rs1 < rs2;
            Zero <= rs1 == rs2;
        EQ:
            rd   <= rs1 == rs2;
            Zero <= rs1 == rs2;
        default:
    endcase
end


assign ALUout = rd;

endmodule 
