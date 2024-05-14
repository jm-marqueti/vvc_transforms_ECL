module sau_2o_1 (input signed [12:0]X, 
output signed [19:0] x36, x83);

  wire signed [19:0]
    w1,
    w8,
    w9,
    w2,
    w11,
    w72,
    w83,
    w36;

  assign w1 = X;
  assign w8 = w1 << 3;
  assign w9 = w1 + w8;
  assign w2 = w1 << 1;
  assign w11 = w9 + w2;
  assign w72 = w9 << 3;
  assign w83 = w11 + w72;
  assign w36 = w9 << 2;

  assign x36 = w36;
  assign x83 = w83;

endmodule