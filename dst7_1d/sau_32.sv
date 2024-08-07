module multiplier_block (
    X,
    Y1,
    Y2,
    Y3,
    Y4,
    Y5,
    Y6,
    Y7,
    Y8,
    Y9,
    Y10,
    Y11,
    Y12,
    Y13,
    Y14,
    Y15,
    Y16,
    Y17,
    Y18,
    Y19,
    Y20
);
  // Port mode declarations:
  input  signed  [31:0] X;
  output signed  [31:0]
    Y1,
    Y2,
    Y3,
    Y4,
    Y5,
    Y6,
    Y7,
    Y8,
    Y9,
    Y10,
    Y11,
    Y12,
    Y13,
    Y14,
    Y15,
    Y16,
    Y17,
    Y18,
    Y19,
    Y20;

  wire [31:0] Y [0:19];

  assign Y1 = Y[0];
  assign Y2 = Y[1];
  assign Y3 = Y[2];
  assign Y4 = Y[3];
  assign Y5 = Y[4];
  assign Y6 = Y[5];
  assign Y7 = Y[6];
  assign Y8 = Y[7];
  assign Y9 = Y[8];
  assign Y10 = Y[9];
  assign Y11 = Y[10];
  assign Y12 = Y[11];
  assign Y13 = Y[12];
  assign Y14 = Y[13];
  assign Y15 = Y[14];
  assign Y16 = Y[15];
  assign Y17 = Y[16];
  assign Y18 = Y[17];
  assign Y19 = Y[18];
  assign Y20 = Y[19];

  //Multipliers:

  wire signed [31:0]
    w1,
    w4,
    w3,
    w5,
    w8,
    w7,
    w9,
    w16,
    w15,
    w17,
    w32,
    w31,
    w11,
    w13,
    w19,
    w21,
    w24,
    w23,
    w25,
    w27,
    w29,
    w6,
    w12,
    w20,
    w22,
    w26,
    w28,
    w30;

  assign w1 = X;
  assign w4 = w1 << 2;
  assign w3 = w4 - w1;
  assign w5 = w1 + w4;
  assign w8 = w1 << 3;
  assign w7 = w8 - w1;
  assign w9 = w1 + w8;
  assign w16 = w1 << 4;
  assign w15 = w16 - w1;
  assign w17 = w1 + w16;
  assign w32 = w1 << 5;
  assign w31 = w32 - w1;
  assign w11 = w3 + w8;
  assign w13 = w16 - w3;
  assign w19 = w3 + w16;
  assign w21 = w5 + w16;
  assign w24 = w3 << 3;
  assign w23 = w24 - w1;
  assign w25 = w1 + w24;
  assign w27 = w32 - w5;
  assign w29 = w32 - w3;
  assign w6 = w3 << 1;
  assign w12 = w3 << 2;
  assign w20 = w5 << 2;
  assign w22 = w11 << 1;
  assign w26 = w13 << 1;
  assign w28 = w7 << 2;
  assign w30 = w15 << 1;

  assign Y[0] = w6;
  assign Y[1] = w9;
  assign Y[2] = w11;
  assign Y[3] = w12;
  assign Y[4] = w13;
  assign Y[5] = w15;
  assign Y[6] = w17;
  assign Y[7] = w19;
  assign Y[8] = w20;
  assign Y[9] = w21;
  assign Y[10] = w22;
  assign Y[11] = w23;
  assign Y[12] = w24;
  assign Y[13] = w25;
  assign Y[14] = w26;
  assign Y[15] = w27;
  assign Y[16] = w28;
  assign Y[17] = w29;
  assign Y[18] = w30;
  assign Y[19] = w31;

endmodule //multiplier_block
