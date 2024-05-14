module permutate_1(input signed [15:0] Y2E[0:1], Y2O[0:1], Y4O[0:3], Y8O[0:7], Y16O[0:15],
input [1:0]N,
output signed [511:0]Y
);

wire signed [511:0] Y_32, Y_16, Y_8, Y_4;

assign Y_4  = {Y2E[0],Y2O[0],Y2E[1],Y2O[1],448'd0};
assign Y_8  = {Y2E[0], Y4O[0], Y2O[0], Y4O[1], Y2E[1], Y4O[2], Y2O[1], Y4O[3], 384'd0};
assign Y_16 = {Y2E[0], Y8O[0], Y4O[0], Y8O[1], Y2O[0], Y8O[2], Y4O[1], Y8O[3], Y2E[1], Y8O[4], Y4O[2], Y8O[5], Y2O[1], Y8O[6], Y4O[3], Y8O[7], 256'd0};
assign Y_32 = {Y2E[0], Y16O[0], Y8O[0], Y16O[1], Y4O[0], Y16O[2], Y8O[1], Y16O[3], Y2O[0], Y16O[4], Y8O[2], Y16O[5], Y4O[1], Y16O[6], Y8O[3], Y16O[7], Y2E[1], Y16O[8], Y8O[4], Y16O[9], Y4O[2], Y16O[10], Y8O[5], Y16O[11], Y2O[1], Y16O[12], Y8O[6], Y16O[13], Y4O[3], Y16O[14], Y8O[7], Y16O[15]};

assign Y = (N == 0) ? Y_4 : 
(N == 1) ? Y_8 :
(N == 2) ? Y_16:
(N == 3) ? Y_32 : Y_32;


endmodule