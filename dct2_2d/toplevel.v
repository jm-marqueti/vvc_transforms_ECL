module toplevel (input signed [0:287]X,
input [1:0]N,
input clk,
input start,
input reset,
output read,
output write,
output signed [511:0]Y);

wire signed [15:0] in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7, in_8, in_9, in_10, in_11, in_12, in_13, in_14, in_15, in_16, in_17, in_18, in_19, in_20, in_21, in_22, in_23, in_24, in_25, in_26, in_27, in_28, in_29, in_30, in_31, out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7, out_8, out_9, out_10, out_11, out_12, out_13, out_14, out_15, out_16, out_17, out_18, out_19, out_20, out_21, out_22, out_23, out_24, out_25, out_26, out_27, out_28, out_29, out_30, out_31;
wire [1:0] N1, N2;
wire direction, enable;
wire [511:0] in_buffer, out_buffer;

assign in_buffer = (direction) ? {in_31, in_30, in_29, in_28, in_27, in_26, in_25, in_24, in_23, in_22, in_21, in_20, in_19, in_18, in_17, in_16, in_15, in_14, in_13, in_12, in_11, in_10, in_9, in_8, in_7, in_6, in_5, in_4, in_3, in_2, in_1, in_0} :
{in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7, in_8, in_9, in_10, in_11, in_12, in_13, in_14, in_15, in_16, in_17, in_18, in_19, in_20, in_21, in_22, in_23, in_24, in_25, in_26, in_27, in_28, in_29, in_30, in_31};

assign out_buffer = (direction) ? {out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7, out_8, out_9, out_10, out_11, out_12, out_13, out_14, out_15, out_16, out_17, out_18, out_19, out_20, out_21, out_22, out_23, out_24, out_25, out_26, out_27, out_28, out_29, out_30, out_31} :
{out_31, out_30, out_29, out_28, out_27, out_26, out_25, out_24, out_23, out_22, out_21, out_20, out_19, out_18, out_17, out_16, out_15, out_14, out_13, out_12, out_11, out_10, out_9, out_8, out_7, out_6, out_5, out_4, out_3, out_2, out_1, out_0};

dct2_1d_1 dct_1d_1st(X,N1,{in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7, in_8, in_9, in_10, in_11, in_12, in_13, in_14, in_15, in_16, in_17, in_18, in_19, in_20, in_21, in_22, in_23, in_24, in_25, in_26, in_27, in_28, in_29, in_30, in_31});

dct2_1d_2 dct_1d_2nd(out_buffer,N2,Y);

transpose_buffer_32x32 transpose_buffer(clk, reset, enable, direction, in_buffer, out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7, out_8, out_9, out_10, out_11, out_12, out_13, out_14, out_15, out_16, out_17, out_18, out_19, out_20, out_21, out_22, out_23, out_24, out_25, out_26, out_27, out_28, out_29, out_30, out_31); 

control control(start,clk,reset,N,enable,read,write,direction,N1,N2);

endmodule