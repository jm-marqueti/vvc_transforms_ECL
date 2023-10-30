module toplevel(input signed [0:63]X, 
output signed[0:143]Y);

reg signed [0:7]v[0:7]; // v contém os elementos de X separados em um array
integer i;
always @* begin
  for (i = 0; i < 8; i = i + 1) begin
	v[i] = X[8*i +: 8];
  end
end

//even-odd decomp (depth0)
wire signed [0:8] E[0:3], O[0:3];

generate
genvar j;
	for (j = 0; j < 4; j = j + 1) begin: dcmploop
		decomp0 decomposicao(v[j], v[7-j], E[j], O[j]);
	end
endgenerate


//multiplicacao das matrizes respectivas
wire signed [15:0] x36[0:3],x64[0:3],x83[0:3];
wire signed [15:0] x18[0:3],x50[0:3],x75[0:3],x89[0:3];
wire signed [0:17] Ye[0:3],  Yo[0:3];

	//EVEN
	
generate // SAU Setup
	for (j = 0; j < 4; j = j + 1) begin: evenSAUloop
		SAUe evenSAU(E[j],x36[j],x64[j],x83[j]);
	end
endgenerate

			//Adder Trees
assign Ye[0] = x64[0] +x64[1] +x64[2] +x64[3]; 
assign Ye[1] = x83[0] +x36[1] -x36[2] -x83[3];
assign Ye[2] = x64[0] -x64[1] -x64[2] +x64[3];
assign Ye[3] = x36[0] -x83[1] +x83[2] -x36[3];

	//ODD
	
generate // SAU Setup
	for (j = 0; j < 4; j = j + 1) begin: oddSAUloop
		SAUo oddSAU(O[j],x18[j],x50[j],x75[j],x89[j]);
	end
endgenerate

			//Adder Trees
assign Yo[0] = x89[0] +x75[1] +x50[2] +x18[3];
assign Yo[1] = x75[0] -x18[1] -x89[2] -x50[3];
assign Yo[2] = x50[0] -x89[1] +x18[2] +x75[3];
assign Yo[3] = x18[0] -x50[1] +x75[2] -x89[3];


//rearranjo para o resultado final
reg signed [0:17] Mix [0:7];

always @* begin
  for (i = 0; i < 4; i = i + 1) begin
	Mix[2*i] = Ye[i];
	Mix[2*i + 1] = Yo[i];
  end
end

assign Y = {Mix[0],Mix[1],Mix[2],Mix[3],Mix[4],Mix[5],Mix[6],Mix[7]};

endmodule