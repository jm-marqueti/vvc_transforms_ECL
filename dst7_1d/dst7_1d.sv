module dst7_1d(input signed [287:0]X_test,
input [1:0]N,
output signed [511:0]Y);

wire signed [8:0] DST_32_input[0:31], DST_16_input[0:15], DST_8_input[0:7], DST_4_input[0:3]; 

//wire signed [XX:0]Y_32[0:31];
//wire signed [XX:0]Y_16[0:15];
//wire signed [XX:0]Y_8[0:7];
wire signed [16:0]Y_4[0:3];

genvar i;
generate
  for (i = 0; i < 32; i++) begin:packloop1
    assign DST_32_input[i] = X_test[(i*9) +: 9];
  end
  for (i = 0; i < 16; i++) begin:packloop2
    assign DST_16_input[i] = X_test[(i*9) +: 9];
  end
  for (i = 0; i < 8; i++) begin:packloop3
    assign DST_8_input[i] = X_test[(i*9) +: 9];
  end
  for (i = 0; i < 4; i++) begin:packloop4
    assign DST_4_input[i] = X_test[(i*9) +: 9];
  end
endgenerate
 
 
// block declarations
//dst7_32 DST32(DST_32_input,Y_32);
//dst7_16 DST16(DST_16_input,Y_16);
//dst7_8  DST8 (DST_8_input ,Y_8);
dst7_4  DST4 (DST_4_input ,Y_4);

wire signed [15:0]Y_4_shifted[0:3]; 

genvar j;
generate
  for (j = 0; j < 4; j++) begin:shiftloop
    assign Y_4_shifted[j] = Y_4[j][16:1];
  end
endgenerate

// mux for output

/*
assign Y = (N == 2'b00) ? {Y_4_shifted[0],Y_4_shifted[1],Y_4_shifted[2],Y_4_shifted[3],448'b0} : 
(N == 2'b01) ? Y_8 : 
(N == 2'b01) ? Y_16 : 
Y_32;
*/
assign Y = {Y_4_shifted[0],Y_4_shifted[1],Y_4_shifted[2],Y_4_shifted[3],448'b0};

endmodule