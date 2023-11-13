`timescale 1 ns/10 ps
module dct2_1d_tb();

reg clk;
reg signed [63:0] X; // valores de teste
reg signed [143:0] yexpected;
wire signed [143:0] Y; // saída do circuito (duv)
reg [31:0] vectornum, errors; // variáveis para controle
reg [207:0] testvectors[10000:0]; // memória com vetores de teste
toplevel DUV(.X(X), .Y(Y) );

always begin
	clk = 1; #5; clk = 0; #5; // clock com período de 10ns
end

initial begin // carrega os vetores de teste no início da simulação
	$dumpfile("./wave/dct2_1d_tb.vcd");
	$dumpvars(0,clk,X,yexpected,Y);
	$readmemb("goldenmodel.dat", testvectors); // lê vetores na memória
	vectornum = 0; errors = 0; // inicializa controle
	#27;
end 

// aplica cada vetor de teste em uma borda de subida do relógio
always @(posedge clk) begin
	#1; {X, yexpected} = testvectors[vectornum];
end

// verifica o resultado na borda de descida
always @(negedge clk) begin

	if (Y != yexpected) begin
		$display("Error: inputs = %b", {X});
		$display(" outputs = %b (%b exp)",Y,yexpected);
		errors = errors + 1;
	end

	vectornum = vectornum + 1;

	if (vectornum == 1000) begin
		$display("%d tests completed with %d errors", vectornum, errors);
		$finish; // termina a simulação após passar por todos os testes
	end

end
endmodule