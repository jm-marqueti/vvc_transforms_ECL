module decode_size(input [1:0]N, 
output signed [5:0]T);

assign T =  (N == 0) ? 6'd4:
				(N == 1) ? 6'd8:
				(N == 2) ? 6'd16:
				6'd32;

endmodule