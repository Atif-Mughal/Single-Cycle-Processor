module testbench();
 logic clk;
 logic reset;
 logic [31:0] WriteData, DataAdr;
 logic MemWrite;
 // instantiate device to be tested
 top dut(clk, reset, WriteData, DataAdr, MemWrite);
 // initialize test
 // generate clock 
 always #5 clk = !clk;
 initial
 begin
 clk = 0;
 reset = 1; # 10; reset = 0;
 #250;
 $finish;
 end

endmodule
