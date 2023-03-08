module filter(
	input logic reset,
	input logic released,
	input logic passThrough,
	input logic [1:0] selector,
	input logic [3:0] key,
	output logic [5:0] filtered
	);

always @(posedge released or negedge reset)
	if (!reset)
		filtered = 5'b 001111;
	//normal conditions or equal key pressed
	else if (passThrough | (selector == 2'b 11 && key == 4'b 1101))
		filtered = {selector,key};

endmodule