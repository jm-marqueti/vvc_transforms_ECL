module dst7_4(
input [8:0]X[3:0],
output signed [16:0]Y[3:0]);


// SAU
wire signed [16:0] x29[0:3],x55[0:3],x74[0:3],x84[0:3];

generate 
genvar j;
	for (j = 0; j < 4; j = j + 1) begin: oddSAUloop
		sau_4 sau_4(X[j],x29[j],x55[j],x74[j],x84[j]);
	end
endgenerate

// Adder Trees
assign Y[0] = x29[0] + x55[1] + x74[2] + x84[3];
assign Y[1] = x74[0] + x74[1] - x74[3];
assign Y[2] = x84[0] - x29[1] - x74[2] + x55[3];
assign Y[3] = x55[0] - x84[1] + x74[2] - x29[3];

endmodule