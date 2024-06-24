module alu_gold(clk,reset,opcode_g,gA,gB,gC);

input clk,reset;
input [1:0] opcode_g;
input signed [3:0] gA,gB;
output reg [4:0] gC;
reg signed [4:0]galu_out; 
localparam 		    Add	           = 2'b00; // A + B
localparam 		    Sub	           = 2'b01; // A - B
localparam 		    Not_A	         = 2'b10; // ~A
localparam 		    ReductionOR_B  = 2'b11; // |B

always @(*)begin
    case(opcode_g)
        Add: galu_out=gA+gB;
        Sub: galu_out=gA-gB;
        Not_A: galu_out=~gA;
        ReductionOR_B: galu_out= |gB;
        default: galu_out=0;
    endcase
end

always @(posedge clk) begin
    if (reset) gC <= 0;
    else gC <= galu_out;
end
endmodule