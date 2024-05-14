module decomp_2_2 (input signed [17:0]a,b,
output signed [18:0] even, odd);

assign even = a + b;

assign odd = b - a;

endmodule