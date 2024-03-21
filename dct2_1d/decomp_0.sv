module decomp_0 (input signed [15:0]a,b,
output signed [16:0] even, odd);

assign even = a + b;

assign odd = a - b;

endmodule