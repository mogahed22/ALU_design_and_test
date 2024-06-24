module test ;

logic  clk,reset;
logic [1:0] opcode;
logic [3:0] ta,tb;
logic [4:0] tc1,tc2;
integer correct_count , error_count;

ALU_4_bit t1(
    .A(ta),.B(tb),.C(tc1),.Opcode(opcode),.clk(clk),.reset(reset)
);
alu_gold t2(
    .gA(ta),.gB(tb),.gC(tc2),.opcode_g(opcode),.clk(clk),.reset(reset)
);

initial begin
clk=0;
forever
    #1 clk=~clk;
end

initial begin
    correct_count = 0;
    error_count = 0;
    ta=0;
    tb=0;
    assert_reset;
    repeat (1000) begin
        ta = $random;
        tb = $random;
        opcode = $random;
        check_result;
    end
    $stop;
end

task check_result;
    @(negedge clk);
    if(tc1 !== tc2) begin
        $display("\t error",$time);
        error_count = error_count+1;
    end
    else correct_count = correct_count+1; 
endtask


task assert_reset;
reset = 1;
check_result();
reset = 0;
endtask
endmodule