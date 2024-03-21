module decomp0 (input signed [0:7]a,b,
output signed [0:8] even,odd);

assign even = a + b;
assign odd = a - b;

endmodule