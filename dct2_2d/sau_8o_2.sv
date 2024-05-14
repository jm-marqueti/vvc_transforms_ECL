module sau_8o_2 (input signed [17:0]X, 
output signed [26:0] x9, x25, x43, x57, x70, x80, x87, x90);

//Multipliers:

  wire signed [26:0]
    w1,
    w4,
    w5,
    w8,
    w9,
    w16,
    w25,
    w36,
    w35,
    w40,
    w45,
    w43,
    w32,
    w57,
    w86,
    w87,
    w70,
    w80,
    w90;

  assign w1 = X;
  assign w4 = w1 << 2;
  assign w5 = w1 + w4;
  assign w8 = w1 << 3;
  assign w9 = w1 + w8;
  assign w16 = w1 << 4;
  assign w25 = w9 + w16;
  assign w36 = w9 << 2;
  assign w35 = w36 - w1;
  assign w40 = w5 << 3;
  assign w45 = w5 + w40;
  assign w43 = w35 + w8;
  assign w32 = w1 << 5;
  assign w57 = w25 + w32;
  assign w86 = w43 << 1;
  assign w87 = w1 + w86;
  assign w70 = w35 << 1;
  assign w80 = w5 << 4;
  assign w90 = w45 << 1;

  assign x9 = w9;
  assign x25 = w25;
  assign x43 = w43;
  assign x57 = w57;
  assign x70 = w70;
  assign x80 = w80;
  assign x87 = w87;
  assign x90 = w90;
  
endmodule