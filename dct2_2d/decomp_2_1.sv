module decomp_2_1 (input signed [10:0]a,b,
output signed [11:0] even, odd);

assign even = a + b;

assign odd = a - b;

endmodule