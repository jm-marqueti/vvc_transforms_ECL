module decomp_3_1 (input signed [11:0]a,b,
output signed [12:0] even, odd);

assign even = a + b;

assign odd = a - b;

endmodule