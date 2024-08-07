module sau_8 (
    X,
    Y1,
    Y2,
    Y3,
    Y4,
    Y5,
    Y6,
    Y7,
    Y8
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
    Y8;

  wire [31:0] Y [0:7];

  assign Y1 = Y[0];
  assign Y2 = Y[1];
  assign Y3 = Y[2];
  assign Y4 = Y[3];
  assign Y5 = Y[4];
  assign Y6 = Y[5];
  assign Y7 = Y[6];
  assign Y8 = Y[7];

  //Multipliers:

  wire signed [31:0]
    w1,
    w8,
    w7,
    w16,
    w15,
    w32,
    w31,
    w33,
    w4,
    w11,
    w28,
    w21,
    w25,
    w22,
    w42,
    w50,
    w56,
    w60,
    w62;

  assign w1 = X;
  assign w8 = w1 << 3;
  assign w7 = w8 - w1;
  assign w16 = w1 << 4;
  assign w15 = w16 - w1;
  assign w32 = w1 << 5;
  assign w31 = w32 - w1;
  assign w33 = w1 + w32;
  assign w4 = w1 << 2;
  assign w11 = w7 + w4;
  assign w28 = w7 << 2;
  assign w21 = w28 - w7;
  assign w25 = w32 - w7;
  assign w22 = w11 << 1;
  assign w42 = w21 << 1;
  assign w50 = w25 << 1;
  assign w56 = w7 << 3;
  assign w60 = w15 << 2;
  assign w62 = w31 << 1;

  assign Y[0] = w11;
  assign Y[1] = w22;
  assign Y[2] = w33;
  assign Y[3] = w42;
  assign Y[4] = w50;
  assign Y[5] = w56;
  assign Y[6] = w60;
  assign Y[7] = w62;

endmodule 
