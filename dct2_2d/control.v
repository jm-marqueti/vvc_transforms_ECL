module control(input start, clk, reset,
input [1:0] N,
output reg enable, read, write,
output direction,
//output reg [5:0] counter,
//output reg [2:0] current_state,
output reg [1:0] N1, N2);

//state registers
reg [2:0] current_state, next_state;
//reg [2:0] next_state;

//state codification
localparam IDLE = 3'b000, INIT = 3'b001,  VDW = 3'b010,  VDR = 3'b011, V = 3'b100, HDW = 3'b101, HDR = 3'b110, H = 3'b111;

//variables
wire signed [6:0] dif;
wire signed [5:0] T1, T2;
wire signed [5:0] TN;
reg [5:0] counter;

//decode transform size
decode_size size1(N1, T1);
decode_size size2(N2, T2);
decode_size sizeN(N, TN);

assign dif = T2 - T1;


// update N logic
always @ (counter or current_state) begin

	if (counter == 2) begin
		N2 <= N1;
		N1 <= N;
	end
	else if (current_state == INIT)
		N1 <= N;

end

// next state logic
always @ (current_state or counter) begin

	if (current_state == INIT && counter == 2)
		next_state <= V;
		
	else if ((current_state == V || current_state == VDW || current_state == VDR) && dif <  0)
		next_state <= HDW;

	else if ((current_state == V || current_state == VDW || current_state == VDR) && dif == 0)
		next_state <= H;

	else if ((current_state == V || current_state == VDW || current_state == VDR) && dif >  0)
		next_state <= HDR;
		
	else if ((current_state == H || current_state == HDW || current_state == HDR) && dif <  0)
		next_state <= VDW;

	else if ((current_state == H || current_state == HDW || current_state == HDR) && dif == 0)
		next_state <= V;

	else if ((current_state == H || current_state == HDW || current_state == HDR) && dif >  0)
		next_state <= VDR;
	
end


//direction logic
assign direction = (current_state == IDLE) ? 1'b0 :
(current_state == INIT) ?  1'b0:
(current_state == V) ? 1'b1 :
(current_state == H) ? 1'b0 : 1'b0;

/*
	if (current_state == V || current_state == VDW || current_state == VDR)
			direction <= 1;
	else
			direction <= 0;
*/

// counter logic
always @ (posedge clk) begin

	if (reset)
		current_state <= IDLE;
	else if (current_state == IDLE && (start))
		current_state <= INIT;
	else if (counter == 1)
		current_state <= next_state;

	case(current_state)
		IDLE:
			counter <= TN;

		INIT:
		if (counter == 1)
			counter <= T1;
		else
			counter <= counter - 6'd1;
		
		V:
		if (counter == 1)
			counter <= T1;
		else
			counter <= counter - 6'd1;
		
		H:
		if (counter == 1)
			counter <= T1;
		else
			counter <= counter - 6'd1;

	endcase
end


// in-state logic
always @ (current_state) begin

	case(current_state)
		IDLE: begin
		enable = 0;
		write = 0;
		read = 0;
		end
		
		INIT: begin
		enable = 1;
		write = 0;
		read = 1;
		end
		
		V: begin
		enable = 1;
		write = 1;
		read = 1;
		end

		H: begin
		enable = 1;
		write = 1;
		read = 1;
		end

	endcase
	
end


endmodule