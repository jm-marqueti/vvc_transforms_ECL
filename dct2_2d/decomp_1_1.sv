module decomp_1_1 (input signed [9:0]a,b,
output signed [10:0] even, odd);

assign even = a + b;

assign odd = a - b;

endmodule