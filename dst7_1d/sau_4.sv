module sau_4 (
    X,
   x29,
   x55,
   x74,
   x84
);

  // Port mode declarations:
  input  signed  [8:0] X;
  output signed  [16:0]
   x29,
   x55,
   x74,
   x84;

  //Multipliers:

  wire signed [16:0]
    w1,
    w8,
    w7,
    w28,
    w21,
    w29,
    w56,
    w55,
    w16,
    w37,
    w74,
    w84;

  assign w1 = X;
  assign w8 = w1 << 3;
  assign w7 = w8 - w1;
  assign w28 = w7 << 2;
  assign w21 = w28 - w7;
  assign w29 = w1 + w28;
  assign w56 = w7 << 3;
  assign w55 = w56 - w1;
  assign w16 = w1 << 4;
  assign w37 = w21 + w16;
  assign w74 = w37 << 1;
  assign w84 = w21 << 2;

  assign x29 = w29;
  assign x55 = w55;
  assign x74 = w74;
  assign x84 = w84;

endmodule
