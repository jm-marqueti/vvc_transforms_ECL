module sau_16 (
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
    Y16
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
    Y16;

  wire [31:0] Y [0:15];

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
    w17,
    w32,
    w31,
    w11,
    w13,
    w21,
    w40,
    w39,
    w41,
    w48,
    w43,
    w45,
    w20,
    w24,
    w28,
    w34,
    w36,
    w42,
    w44;

  assign w1 = X;
  assign w4 = w1 << 2;
  assign w3 = w4 - w1;
  assign w5 = w1 + w4;
  assign w8 = w1 << 3;
  assign w7 = w8 - w1;
  assign w9 = w1 + w8;
  assign w16 = w1 << 4;
  assign w17 = w1 + w16;
  assign w32 = w1 << 5;
  assign w31 = w32 - w1;
  assign w11 = w3 + w8;
  assign w13 = w16 - w3;
  assign w21 = w5 + w16;
  assign w40 = w5 << 3;
  assign w39 = w40 - w1;
  assign w41 = w1 + w40;
  assign w48 = w3 << 4;
  assign w43 = w48 - w5;
  assign w45 = w48 - w3;
  assign w20 = w5 << 2;
  assign w24 = w3 << 3;
  assign w28 = w7 << 2;
  assign w34 = w17 << 1;
  assign w36 = w9 << 2;
  assign w42 = w21 << 1;
  assign w44 = w11 << 2;

  assign Y[0] = w4;
  assign Y[1] = w8;
  assign Y[2] = w13;
  assign Y[3] = w17;
  assign Y[4] = w20;
  assign Y[5] = w24;
  assign Y[6] = w28;
  assign Y[7] = w31;
  assign Y[8] = w34;
  assign Y[9] = w36;
  assign Y[10] = w39;
  assign Y[11] = w41;
  assign Y[12] = w42;
  assign Y[13] = w43;
  assign Y[14] = w44;
  assign Y[15] = w45;

endmodule
