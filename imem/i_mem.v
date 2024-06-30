module i_mem(
    input  wire [31:0]  pc,
    output wire [31:0]  inst
);


parameter DATA_WIDTH = 32;
parameter ARRAY_SIZE = 100;
parameter FILENAME = "/home/hugo/code/verilog/riscv/imem/inst/inst.hex";  // program machine code

reg [DATA_WIDTH-1:0] imem [0:ARRAY_SIZE-1];

integer file, r, i;
reg [DATA_WIDTH*2:0] line;  // Registers large enough to store one line of data (hexadecimal string)
reg [DATA_WIDTH-1:0] value;

initial begin
    for (i = 0; i < ARRAY_SIZE; i = i + 1) begin
        imem[i] = 0;
    end
    
    // open file
    file = $fopen(FILENAME, "r");
    if (file == 0) begin
        $display("Error: Could not open file %s", FILENAME);
        $finish;
    end
    
    // read in file line by line
    i = 0;
    while (!$feof(file) && i < ARRAY_SIZE) begin
        r = $fgets(line, file);
        if (r != 0) begin
            r = $sscanf(line, "%h", value);
            if (r == 1) begin
                imem[i] = value;
                i = i + 1;
            end
        end
    end
    
    // close file
    $fclose(file);
    $display("Finish Reading!");
    
    // print
    // for (i = 0; i < ARRAY_SIZE; i = i + 1) begin
    //     $display("imem[%0d] = %h", i, imem[i]);
    // end
    // $finish;
end

assign inst = imem[pc/4];

endmodule

