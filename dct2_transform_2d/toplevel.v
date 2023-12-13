module toplevel(input signed [511:0]X,
input start,clk,reset,
output ready,
output signed[511:0]Y); 

wire signed [63:0]line[0:7]; // line contém as linhas de X em um array
wire signed [127:0]in_1d; // entrada 
wire signed [127:0]out_1d;
wire enable_write, enable_read, direction, mux;
wire [2:0] counter;
wire [7:0] in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7,out_0,out_1,out_2,out_3,out_4,out_5,out_6,out_7;
genvar i;

generate
  for (i = 0; i < 8; i = i + 1) begin: unpack_2d
	assign line[i] = X[64*i +: 64];
  end
endgenerate

assign in_1d = (mux) ? line[counter] : {out_0,out_1,out_2,out_3,out_4,out_5,out_6,out_7};

assign out_1d = {in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7};


control ctrl(start, clk, reset, enable_write, enable_read, direction, mux, ready, counter);

transpose_buffer_8x8 transpose_buffer(clk,reset,enable_read,enable_write,direction,in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7,out_0,out_1,out_2,out_3,out_4,out_5,out_6,out_7);

dct_1d transform_block(in_1d,out_1d);


endmodule
