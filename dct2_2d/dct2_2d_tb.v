`timescale 1 ns/10 ps
module dct2_2d_tb();
parameter SIZE = 2'b11; // size code of transform (00 = 4;01 = 8;10 = 16;11 = 32)
parameter SIZE_DECODED = 32;

// inputs 
reg clk, start, reset; 
reg signed [0:287] X_test; 
reg [1:0]N;

// outputs
wire signed [511:0] Y; 
wire write, read;

// control and memory variables
reg [31:0] inputnum, outputnum, errors; 
reg signed [511:0] yexpected;
reg signed [289:0] inputvectors[0:(SIZE_DECODED*1000)-1]; 
reg signed [511:0] outputvectors[0:(SIZE_DECODED*1000)-1]; 
wire signed [8:0]X[0:31];
wire signed [15:0]Y_unrolled[0:31];
wire signed [15:0]Y_unrolled_expected[0:31];

toplevel DUV(.X(X_test), .N(N), .clk(clk), .start(start), .reset(reset), .read(read), .write(write), .Y(Y) );

always begin
	clk = 1; #5; clk = 0; #5;
end

// initialize inputs and load into memory
initial begin 
	$readmemb("goldenmodel_input.dat" , inputvectors); 
	$readmemb("goldenmodel_output.dat", outputvectors);
	inputnum = 0; outputnum = 0; errors = 0;
	reset = 1;
	start = 0;
	X_test = 0;
	N = SIZE;
	#11;
	reset = 0;
	start = 1;
end

//apply test vectors
always @(posedge clk) begin
	#1
	if (read) begin
		{N, X_test} = inputvectors[inputnum]; 
		yexpected = outputvectors[outputnum];
		inputnum = inputnum + 1;
	end
end

//check results
always @(negedge clk) begin

if (write) begin
	if (Y != yexpected) begin
		//$display(" outputs = %b (%b exp)",Y,yexpected);
		errors = errors + 1;
	end
	outputnum = outputnum + 1;
end
	
	if (outputnum == SIZE_DECODED*1000 - 1) begin
		$display("%d tests completed with %d errors", inputnum, errors);
		$finish;
	end

end

//unroll values for debugging
genvar i;
generate
    for (i = 0; i < 32; i = i + 1) begin : unpack_loop
        assign X[i] = X_test[(i*9) +: 9];
		  assign Y_unrolled[i] = Y[511 - i*16 -: 16];
		  assign Y_unrolled_expected[i] = yexpected[511 - i*16 -: 16];
    end
endgenerate



endmodule