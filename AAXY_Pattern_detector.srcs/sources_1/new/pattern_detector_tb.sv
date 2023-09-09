class Randgen;
    rand bit [7:0] num ;
    constraint c {num dist{8'h41:=1,  8'h58:=1, 8'h59:=1};}
    function new();
        
    endfunction //new()
endclass //Randgen

module pattern_detector_tb ();
    
    `timescale 1ps/1ps
//port declaation
logic [7:0]data_in;
logic clk,reset,data_valid,data_out,state_data;
pattern_detector dut(.*);
assign clk = 1;
assign reset = 0;
assign data_valid = 1;
initial forever begin
    #5;
    clk <= ~clk;
end

Randgen R_data=new();
initial begin
    #30;
    repeat(25)@(posedge clk) begin
        #2;
        data_in=R_data.num;
        R_data.randomize();
    end
    $finish();
end


endmodule