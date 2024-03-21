module sau_4o (input signed [18:0]X, 
output signed [26:0] x18, x50, x75, x89);

  wire signed [26:0]
    w1,
    w8,
    w9,
    w16,
    w25,
    w100,
    w75,
    w64,
    w89,
    w18,
    w50;

  assign w1 = X;
  assign w8 = w1 << 3;
  assign w9 = w1 + w8;
  assign w16 = w1 << 4;
  assign w25 = w9 + w16;
  assign w100 = w25 << 2;
  assign w75 = w100 - w25;
  assign w64 = w1 << 6;
  assign w89 = w25 + w64;
  assign w18 = w9 << 1;
  assign w50 = w25 << 1;

  assign x18 = w18;
  assign x50 = w50;
  assign x75 = w75;
  assign x89 = w89;

endmodule