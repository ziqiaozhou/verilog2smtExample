module Op2(clk,rst,a,b,c,mode);
  input clk,rst,mode;
  input [31:0]a;
  input [31:0]b;
  output reg [31:0]c;
  reg[31:0] cc;
  reg [31:0]d;
  always @(posedge clk)
    if(mode==1'b1) cc<= a|b;
    else begin
   	 d <= cc;
	  cc[31:2]<= {a[10:0],b[31:13]};
    end
    assign c = cc;
endmodule
module Op(clk,rst);
input clk,rst;
reg [31:0] a;
reg[31:0] b;
reg[31:0] c;
reg mode;
Op2 o(clk,rst,a,b,c,mode);
endmodule
