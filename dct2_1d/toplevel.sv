module toplevel(input signed [0:511]X_test,
input [1:0]N,
output signed [0:511]Y);

wire signed [16:0] X_16[0:15], DCT_16_input[0:15], Y16E[0:15]; 
wire signed [17:0] X_8[0:7], DCT_8_input [0:7], Y8E [0:7];
wire signed [18:0] X_4[0:3], DCT_4_input[0:3], Y4E[0:3];
wire signed [26:0] Y2E[0:1], Y2O[0:1], Y4O[0:3], Y8O[0:7], Y16O[0:15];
wire signed [15:0] Y2E_shifted[0:1], Y2O_shifted[0:1], Y4O_shifted[0:3], Y8O_shifted[0:7], Y16O_shifted[0:15];
wire signed [15:0] X[0:31];

assign X[0] = X_test[0:15];
assign X[1] = X_test[16:31];
assign X[2] = X_test[32:47];
assign X[3] = X_test[48:63];
assign X[4] = X_test[64:79];
assign X[5] = X_test[80:95];
assign X[6] = X_test[96:111];
assign X[7] = X_test[112:127];
assign X[8] = X_test[128:143];
assign X[9] = X_test[144:159];
assign X[10]= X_test[160:175];
assign X[11]= X_test[176:191];
assign X[12]= X_test[192:207];
assign X[13]= X_test[208:223];
assign X[14]= X_test[224:239];
assign X[15]= X_test[240:255];
assign X[16]= X_test[256:271];
assign X[17]= X_test[272:287];
assign X[18]= X_test[288:303];
assign X[19]= X_test[304:319];
assign X[20]= X_test[320:335];
assign X[21]= X_test[336:351];
assign X[22]= X_test[352:367];
assign X[23]= X_test[368:383];
assign X[24]= X_test[384:399];
assign X[25]= X_test[400:415];
assign X[26]= X_test[416:431];
assign X[27]= X_test[432:447];
assign X[28]= X_test[448:463];
assign X[29]= X_test[464:479];
assign X[30]= X_test[480:495];
assign X[31]= X_test[496:511];


// signed bit extension on each element
assign  X_16[0] = {X[0][15] , X[0]};
assign  X_16[1] = {X[1][15] , X[1]};
assign  X_16[2] = {X[2][15] , X[2]};
assign  X_16[3] = {X[3][15] , X[3]};
assign  X_16[4] = {X[4][15] , X[4]};
assign  X_16[5] = {X[5][15] , X[5]};
assign  X_16[6] = {X[6][15] , X[6]};
assign  X_16[7] = {X[7][15] , X[7]};
assign  X_16[8] = {X[8][15] , X[8]};
assign  X_16[9] = {X[9][15] , X[9]};
assign X_16[10] = {X[10][15], X[10]};
assign X_16[11] = {X[11][15], X[11]};
assign X_16[12] = {X[12][15], X[12]};
assign X_16[13] = {X[13][15], X[13]};
assign X_16[14] = {X[14][15], X[14]};
assign X_16[15] = {X[15][15], X[15]};
assign   X_8[0] = {X[0][15] , X[0][15], X[0]};
assign   X_8[1] = {X[1][15] , X[1][15], X[1]};
assign   X_8[2] = {X[2][15] , X[2][15], X[2]};
assign   X_8[3] = {X[3][15] , X[3][15], X[3]};
assign   X_8[4] = {X[4][15] , X[4][15], X[4]};
assign   X_8[5] = {X[5][15] , X[5][15], X[5]};
assign   X_8[6] = {X[6][15] , X[6][15], X[6]};
assign   X_8[7] = {X[7][15] , X[7][15], X[7]};
assign   X_4[0] = {X[0][15] , X[0][15], X[0][15], X[0]};
assign   X_4[1] = {X[1][15] , X[1][15], X[1][15], X[1]};
assign   X_4[2] = {X[2][15] , X[2][15], X[2][15], X[2]};
assign   X_4[3] = {X[3][15] , X[3][15], X[3][15], X[3]};

 
// muxes on block inputs 
assign DCT_16_input[0:15] = (N == 2'b10) ? X_16[0:15] : Y16E[0:15];
assign DCT_8_input[0:7]  = (N == 2'b01) ? X_8[0:7]  : Y8E[0:7];
assign DCT_4_input[0:3]  = (N == 2'b00) ? X_4[0:3]  : Y4E[0:3];

// block declarations
dct2_32 DCT32(X           , Y16E, Y16O);
dct2_16 DCT16(DCT_16_input, Y8E,  Y8O );
dct2_8  DCT8 (DCT_8_input , Y4E,  Y4O );
dct2_4  DCT4 (DCT_4_input , Y2E,  Y2O );

// shift individual outputs before permutation
assign Y2E_shifted[0]  = Y2E[0][26:11];
assign Y2E_shifted[1]  = Y2E[1][26:11];
assign Y2O_shifted[0]  = Y2O[0][26:11];
assign Y2O_shifted[1]  = Y2O[1][26:11];
assign Y4O_shifted[0]  = Y4O[0][26:11];
assign Y4O_shifted[1]  = Y4O[1][26:11];
assign Y4O_shifted[2]  = Y4O[2][26:11];
assign Y4O_shifted[3]  = Y4O[3][26:11];

assign Y8O_shifted[0]  = Y8O[0][26:11];
assign Y8O_shifted[1]  = Y8O[1][26:11];
assign Y8O_shifted[2]  = Y8O[2][26:11];
assign Y8O_shifted[3]  = Y8O[3][26:11];
assign Y8O_shifted[4]  = Y8O[4][26:11];
assign Y8O_shifted[5]  = Y8O[5][26:11];
assign Y8O_shifted[6]  = Y8O[6][26:11];
assign Y8O_shifted[7]  = Y8O[7][26:11];

assign Y16O_shifted[0] = Y16O[0][26:11];
assign Y16O_shifted[1] = Y16O[1][26:11];
assign Y16O_shifted[2] = Y16O[2][26:11];
assign Y16O_shifted[3] = Y16O[3][26:11];
assign Y16O_shifted[4] = Y16O[4][26:11];
assign Y16O_shifted[5] = Y16O[5][26:11];
assign Y16O_shifted[6] = Y16O[6][26:11];
assign Y16O_shifted[7] = Y16O[7][26:11];
assign Y16O_shifted[8] = Y16O[8][26:11];
assign Y16O_shifted[9] = Y16O[9][26:11];
assign Y16O_shifted[10]= Y16O[10][26:11];
assign Y16O_shifted[11]= Y16O[11][26:11];
assign Y16O_shifted[12]= Y16O[12][26:11];
assign Y16O_shifted[13]= Y16O[13][26:11];
assign Y16O_shifted[14]= Y16O[14][26:11];
assign Y16O_shifted[15]= Y16O[15][26:11];

permutate PERMUTATE(Y2E_shifted, Y2O_shifted, Y4O_shifted, Y8O_shifted, Y16O_shifted, N, Y); 


endmodule
