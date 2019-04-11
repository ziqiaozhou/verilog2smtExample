module Op(clk,rst,a,b,c,mode);
  input clk,rst,mode;
  input [31:0]a;
  input [31:0]b;
  output reg [31:0]c;
  always @(posedge clk)
    if(mode==1'b0) c <= a&b;
    else if(mode==1'b1) c <= a| b;

endmodule

module Counter (clk, rst, en, count);
   input clk, rst, en;
   output reg [2:0] count;
   always @(posedge clk)
      if (rst)
         count <= 3'd0;
      else if (en)
         count <= count + 3'd1;
endmodule

module Mem(clk,rst,addr,in_data,out_data,wmode);
  input clk,rst,wmode;
  input [2:0]addr;
  input [31:0]in_data;
  output [31:0]out_data;
  reg [31:0] ram[7:0];
  integer i;
  initial begin
    for(i=0;i<8;i=i+1)
      ram[i] = {32'h0};
  end
  always @(posedge clk)
     if(wmode==1'b1) ram[addr][31:0] <= in_data[31:0];
  assign out_data = ram[addr];
endmodule

module Test(clk,rst,or_mode,a_addr,b_addr,c_addr,c);
 input clk, rst, or_mode;
 input [2:0] a_addr;
 input [2:0] b_addr;
 input [2:0] c_addr;
 output [31:0] c;
 reg [2:0] my_count;
 reg [31:0] a;
 reg [31:0] b;
 reg [31:0] d;
 wire [2:0] addr;
 reg [31:0] out_data;

 always @(posedge clk) begin
   if(my_count==3'h0)begin
     addr = a_addr;
     a[31:0] <= out_data[31:0];
   end
   else if(my_count==3'h1)begin
     addr = b_addr;
     b[31:0] <= out_data[31:0];
   end
   else if(my_count>3'h3)begin
     addr = c_addr;
     in_data[31:0] <=c[31:0];
    end
  end

 assign enable = ~rst;
 Counter counter(.clk(clk),
   .rst(rst),
   .en(enable),
   .count(my_count)
 );

 Mem mem(.clk(clk),
   .rst(rst),
   .addr(addr),
   .out_data(out_data),
   .in_data(in_data),
   .wmode(wmode)
 );

 Op op(.clk(clk),
   .rst(rst),
   .a(a),
   .b(b),
   .c(c),
   .mode(mode)
  );

 endmodule
