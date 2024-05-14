module decomp_3_2 (input signed [18:0]a,b,
output signed [19:0] even, odd);

assign even = a + b;

assign odd = b - a;

endmodule