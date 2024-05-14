 module sau_16o_2 (input signed [16:0]X, 
output signed [26:0] x4, x13, x22, x31,x38,x46,x54,x61,x67,x73,x78,x82,x85,x88,x90);

 //Multipliers:

 wire signed [26:0]
    w1,
    w32,
    w31,
    w8,
    w23,
    w4,
    w27,
    w39,
    w62,
    w61,
    w22,
    w11,
    w26,
    w13,
    w19,
    w64,
    w41,
    w46,
    w45,
    w128,
    w67,
    w73,
    w108,
    w85,
    w38,
    w54,
    w78,
    w82,
    w88,
    w90;

  assign w1 = X;
  assign w32 = w1 << 5;
  assign w31 = w32 - w1;
  assign w8 = w1 << 3;
  assign w23 = w31 - w8;
  assign w4 = w1 << 2;
  assign w27 = w31 - w4;
  assign w39 = w31 + w8;
  assign w62 = w31 << 1;
  assign w61 = w62 - w1;
  assign w22 = w23 - w1;
  assign w11 = w22 >>> 1;
  assign w26 = w27 - w1;
  assign w13 = w26 >>> 1;
  assign w19 = w23 - w4;
  assign w64 = w1 << 6;
  assign w41 = w64 - w23;
  assign w46 = w23 << 1;
  assign w45 = w46 - w1;
  assign w128 = w1 << 7;
  assign w67 = w128 - w61;
  assign w73 = w27 + w46;
  assign w108 = w27 << 2;
  assign w85 = w108 - w23;
  assign w38 = w19 << 1;
  assign w54 = w27 << 1;
  assign w78 = w39 << 1;
  assign w82 = w41 << 1;
  assign w88 = w11 << 3;
  assign w90 = w45 << 1;

  assign x4 = w4;
  assign x13 = w13;
  assign x22 = w22;
  assign x31 = w31;
  assign x38 = w38;
  assign x46 = w46;
  assign x54 = w54;
  assign x61 = w61;
  assign x67 = w67;
  assign x73 = w73;
  assign x78 = w78;
  assign x82 = w82;
  assign x85 = w85;
  assign x88 = w88;
  assign x90 = w90;
  
 endmodule