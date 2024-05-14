module dct2_1d_1(input signed [0:287]X_test,
input [1:0]N,
output signed [511:0]Y);

wire signed [9:0] X_16[0:15], DCT_16_input[0:15], Y16E[0:15]; 
wire signed [10:0] X_8[0:7], DCT_8_input [0:7], Y8E [0:7];
wire signed [11:0] X_4[0:3], DCT_4_input[0:3], Y4E[0:3];
wire signed [19:0] Y2E[0:1], Y2O[0:1], Y4O[0:3], Y8O[0:7], Y16O[0:15];
wire signed [15:0] Y2E_shifted[0:1], Y2O_shifted[0:1], Y4O_shifted[0:3], Y8O_shifted[0:7], Y16O_shifted[0:15];
genvar i;

wire signed [8:0]X[0:31];
generate //						 <---- Temporary
    for (i = 0; i < 32; i = i + 1) begin : unpack_loop
        assign X[i] = X_test[(i*9) +: 9];
    end
endgenerate

// signed bit extension on each element
 generate // change for synthesis!
  
    for (i = 0; i < 16; i = i + 1) begin: concat_x_16
      assign X_16[i] = {X[i][8], X[i]};  
    end
	 for (i = 0; i < 8; i = i + 1) begin: concat_x_8
      assign X_8[i] = {X[i][8], X[i][8], X[i]};  
    end
	 for (i = 0; i < 4; i = i + 1) begin: concat_x_4
      assign X_4[i] = {X[i][8], X[i][8], X[i][8], X[i]}; 
    end
  endgenerate
 
// muxes on block inputs 
assign DCT_16_input = (N == 2'b10) ? X_16 : Y16E;
assign DCT_8_input  = (N == 2'b01) ? X_8  : Y8E;
assign DCT_4_input  = (N == 2'b00) ? X_4  : Y4E;

// block declarations
dct2_32_1 DCT32(X,           Y16E, Y16O);
dct2_16_1 DCT16(DCT_16_input, Y8E,  Y8O);
dct2_8_1  DCT8 (DCT_8_input,  Y4E,  Y4O);
dct2_4_1  DCT4 (DCT_4_input,  Y2E,  Y2O);

// shift individual outputs before permutation
generate // change for synthesis!
			
  for (i = 0; i < 16; i = i + 1) begin: shift_Y16
      assign Y16O_shifted[i] = (Y16O[i][19:4]);  
    end
	for (i = 0; i < 8; i = i + 1) begin: shift_Y8
      assign Y8O_shifted[i] = (Y8O[i][19:4]);  
    end
	 for (i = 0; i < 4; i = i + 1) begin: shift_Y4
      assign Y4O_shifted[i] = (Y4O[i][19:4]);  
    end
	 for (i = 0; i < 2; i = i + 1) begin: shift_Y2
      assign Y2O_shifted[i] = (Y2O[i][19:4]);  
		assign Y2E_shifted[i] = (Y2E[i][19:4]);
    end
	 
endgenerate

permutate_1 PERMUTATE(Y2E_shifted, Y2O_shifted, Y4O_shifted, Y8O_shifted, Y16O_shifted, N, Y); 


endmodule