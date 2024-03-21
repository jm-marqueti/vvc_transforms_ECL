module SAUo(
input signed [8:0] x,
output signed [15:0] x18,x50,x75,x89

);

	assign x18 = (x << 4) + (x << 1);
	assign x50 = (x << 5) + (x << 4) + (x << 1);
	assign x75 = (x << 6) + (x << 3) + (x << 1) + x;
	assign x89 = (x << 6) + (x << 4) +(x << 3) + x;
		
endmodule
