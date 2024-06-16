module dct2_8 (input signed [17:0]X[0:7], 
output signed [18:0]Ye[0:3],
output signed [26:0]Yo[0:3]); 


//even-odd decomp
wire signed [18:0]E[0:3], O[0:3];

generate
genvar i;
	for (i = 0; i < 4; i = i + 1) begin: dcmploop
		decomp_2 decomposicao(X[i], X[7-i], E[i], O[i]);
	end
endgenerate


	//EVEN

assign Ye = E;

	//ODD (T4O)
	
wire signed [26:0] x18[0:3],x50[0:3],x75[0:3],x89[0:3];

generate // SAU Setup
genvar j;
	for (j = 0; j < 4; j = j + 1) begin: oddSAUloop
		sau_4o sau_odd(O[j],x18[j],x50[j],x75[j],x89[j]);
	end
endgenerate

			//Adder Trees
assign Yo[0] = x89[0] +x75[1] +x50[2] +x18[3];
assign Yo[1] = x75[0] -x18[1] -x89[2] -x50[3];
assign Yo[2] = x50[0] -x89[1] +x18[2] +x75[3];
assign Yo[3] = x18[0] -x50[1] +x75[2] -x89[3];



endmodule
