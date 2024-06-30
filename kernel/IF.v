module IF(
    input  wire         clk,
    input  wire         rst,
    input  wire [31:0]  EXMEM_d_ALUout,
    
    input  wire         EXMEM_c_SelPC,
    
    output wire [31:0]  IFID_d_inst,
    output wire [31:0]  IFID_d_pc
);


reg [31:0] pc;  // now pc

// PC candidate: EXMEM_c_SelPC
parameter NEXTPC = 1'b0;
parameter JUMPPC = 1'b1;

// i-memrey, addressing by Byte.
i_mem u_i_mem(
    .pc(pc),
    .inst(IFID_d_inst)  // output IFID_d_inst (END)
);

always @(posedge clk or negedge rst) begin
    if (~rst) begin  // rst = 0, reset 
        pc <= 0;
    end else begin 
        case(EXMEM_c_SelPC)  // update pc
            NEXTPC: 
                pc <= pc + 4;
            JUMPPC:
                pc <= EXMEM_d_ALUout;
            default:
                pc <= pc + 4;
        endcase
    end
end

assign IFID_d_pc = pc;  // output IFID_d_pc (END)

endmodule 
