`default_nettype none
module calendar (
	input  logic reset,
	input  logic day_increment,
	input  logic year_increment,
	input  logic month_increment,
	input  logic clock,
	input  logic hour_enable,
	output logic [6:0] day_binary,
	output logic [6:0] LeftYear,
	output logic [6:0] maxDay_binary,
	output logic [6:0] month_binary,
	output logic [6:0] RightYear
	);
	logic [15:0] a;
	logic [3:0] b;
	logic [5:0] c;
	logic end_of_month;
	logic end_of_year;
	logic [5:0] l;
	logic SYNTHESIZED_WIRE_0;
	Day b2v_inst0(
		.clk(clock),
		.enable(hour_enable),
		.offset(day_increment),
		.leap_year(SYNTHESIZED_WIRE_0),
		.reset(reset),
		.month(b),
		.end_of_month(end_of_month),
		.day(c),
		.max_days(l)
	);
	Month b2v_inst1(
		.clk(clock),
		.reset(reset),
		.end_of_month(end_of_month),
		.offset(month_increment),
		.end_of_year(end_of_year),
		.month(b)
	);
	Year b2v_inst2(
		.clk(clock),
		.reset(reset),
		.end_of_year(end_of_year),
		.offset(year_increment),
		.leap_year(SYNTHESIZED_WIRE_0),
		.year(a)
	);
	splitYear b2v_inst3(
		.year_binary(a),
		.leftNum(LeftYear),
		.rightNum(RightYear)
	);
	assign day_binary = c;
	assign maxDay_binary = l;
	assign month_binary = b;
endmodule