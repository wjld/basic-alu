module system(
	input logic CLOCK_50,
	input logic [1:0] KEY,
	inout logic [35:0] GPIO_1,
	output logic [7:0] LEDG,
	output logic [17:0] LEDR,
	output logic [6:0] HEX0,
	output logic [6:0] HEX1,
	output logic [6:0] HEX2,
	output logic [6:0] HEX3,
	output logic [6:0] HEX4,
	output logic [6:0] HEX5,
	output logic [6:0] HEX6,
	output logic [6:0] HEX7
	);

wire ready;
wire [3:0] key;

assign {HEX3,HEX7} = '1; //unused

controller c0 (
	.clk(CLOCK_50),
	.rowN({GPIO_1[19],GPIO_1[21],GPIO_1[23],GPIO_1[25]}),
	.columnN({GPIO_1[11],GPIO_1[13],GPIO_1[15],GPIO_1[17]}),
	.key(key),
	.ready(ready)
	);

alu a0(
	.clk(CLOCK_50),
	.reset(~&key | ~KEY[0]),
	.released(~ready),
	.key(key),
	.HEX0(HEX0),
	.HEX1(HEX1),
	.HEX2(HEX2),
	.HEX4(HEX4),
	.HEX5(HEX5),
	.HEX6(HEX6),
	.LEDR({LEDR[17:14],LEDR[12:9]}),
	.LEDG(LEDG[7:0]),
	);

endmodule