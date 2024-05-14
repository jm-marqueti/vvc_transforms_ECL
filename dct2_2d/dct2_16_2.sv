module dct2_16_2 (input signed [16:0]X[0:15], 
output signed [17:0]Ye[0:7],
output signed [26:0]Yo[0:7]); 


//even-odd decomp
wire signed [17:0] E[0:7], O[0:7];

generate
genvar i;
	for (i = 0; i < 8; i = i + 1) begin: dcmploop
		decomp_1_2 decomposicao(X[i], X[15-i], E[i], O[i]);
	end
endgenerate


	//EVEN

assign Ye = E;

	//ODD (T2O)
	
wire signed [26:0] x9[0:7], x25[0:7], x43[0:7], x57[0:7], x70[0:7], x80[0:7], x87[0:7], x90[0:7];

generate // SAU Setup
genvar j;
	for (j = 0; j < 8; j = j + 1) begin: oddSAUloop
		sau_8o_2 sau_odd(O[j],x9[j], x25[j], x43[j], x57[j], x70[j], x80[j], x87[j], x90[j]);
	end
endgenerate

			//Adder Trees
			
assign Yo[0] = x90[0] + x87[1] + x80[2] + x70[3] + x57[4] + x43[5] + x25[6] +  x9[7];
assign Yo[1] = x87[0] + x57[1] +  x9[2] - x43[3] - x80[4] - x90[5] - x70[6] - x25[7];
assign Yo[2] = x80[0] +  x9[1] - x70[2] - x87[3] - x25[4] + x57[5] + x90[6] + x43[7];
assign Yo[3] = x70[0] - x43[1] - x87[2] +  x9[3] + x90[4] + x25[5] - x80[6] - x57[7];
assign Yo[4] = x57[0] - x80[1] - x25[2] + x90[3] -  x9[4] - x87[5] + x43[6] + x70[7];
assign Yo[5] = x43[0] - x90[1] + x57[2] + x25[3] - x87[4] + x70[5] +  x9[6] - x80[7];
assign Yo[6] = x25[0] - x70[1] + x90[2] - x80[3] + x43[4] +  x9[5] - x57[6] + x87[7];
assign Yo[7] =  x9[0] - x25[1] + x43[2] - x57[3] + x70[4] - x80[5] + x87[6] - x90[7];


endmodule