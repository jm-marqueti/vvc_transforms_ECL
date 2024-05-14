module decomp_1_2 (input signed [16:0]a,b,
output signed [17:0] even, odd);

assign even = a + b;

assign odd = b - a;

endmodule