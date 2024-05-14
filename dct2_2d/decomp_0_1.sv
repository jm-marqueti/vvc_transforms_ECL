module decomp_0_1 (input signed [8:0]a,b,
output signed [9:0] even, odd);

assign even = a + b;

assign odd = a - b;

endmodule