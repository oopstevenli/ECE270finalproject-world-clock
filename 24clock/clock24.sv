`default_nettype none
module clock24 (
	input  logic clk,
	input  logic reset,
	input  logic [4:0] offset_hours,
	input  logic [5:0] offset_mins,
	output logic cycle,
	output logic [6:0] hours,
	output logic [6:0] minutes,
	output logic [6:0] seconds
	);
	logic fullMin;
	logic fullHour;
	sec60Timer inst0(
		.clk(clk),
		.reset(reset),
		.cycle(fullMin),
		.seconds(seconds)
	);
	min60Timer inst1(
		.clk(clk),
		.en(fullMin),
		.reset(reset),
		.offset(offset_mins),
		.cycle(fullHour),
		.mins(minutes)
	);
	day24Timer inst2(
		.clk(clk),
		.en(fullHour),
		.reset(reset),
		.offset(offset_hours),
		.cycle(cycle),
		.hours(hours)
	);
endmodule
