module Op(clk, rst, a, b, c, mode);
input clk, rst, mode;
input [31:0] a;
input [31:0] b;
output reg [31:0] c;
always @(posedge clk) if (mode == 1'b0) c <= (a << b);
else if (mode == 1'b1) c <= a | b;

endmodule

    module Mem(clk, rst, addr, in_data, out_data, wmode);
input clk, rst, wmode;
input [2:0] addr;
input [31:0] in_data;
output [31:0] out_data;
reg [31:0] ram [7:0];
integer i;
initial begin $readmemh("test.hex", ram);
end

        always @(posedge clk) if (wmode == 1'b1) ram[addr] [31:0] <= in_data
    [31:0];
assign out_data = ram[addr];
endmodule

    module Test(clk, rst, or_mode, a_addr, b_addr, c_addr, c);
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
wire [31:0] cc;
reg [31:0] out_data;
initial begin my_count = 3'h0;
end always @(posedge clk) begin my_count <= my_count + 1;
if (my_count == 3'h0)
  begin addr = a_addr;
a <= out_data;
end else if (my_count == 3'h1) begin addr = b_addr;
b <= out_data;
end else if (my_count > 3'h3) begin addr = c_addr;
in_data <= cc;
end end

    Mem mem(.clk(clk), .rst(rst), .addr(addr), .out_data(out_data),
            .in_data(in_data), .wmode(wmode));

Op op(.clk(clk), .rst(rst), .a(a), .b(b), .c(cc), .mode(mode));
assign c = cc;
endmodule
