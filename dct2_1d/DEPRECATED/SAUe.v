module SAUe(
input signed [8:0] x,
output signed [15:0] x36,x64,x83

);

	assign x36 = (x << 5) + (x << 2);
	assign x64 = (x << 6);
	assign x83 = (x << 6) + (x << 4) + (x << 1) + x;
	
endmodule