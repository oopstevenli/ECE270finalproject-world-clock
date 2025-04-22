`default_nettype none
module top(
	input  logic hz100,
	input  logic [6:0] pb,
	output logic [7:0] ss0,
	output logic [7:0] ss1,
	output logic [7:0] ss2,
	output logic [7:0] ss3,
	output logic [7:0] ss4,
	output logic [7:0] ss5,
	output logic [7:0] ss6,
	output logic [7:0] ss7
	);

	logic SYNTHESIZED_WIRE_0;
	logic [6:0] SYNTHESIZED_WIRE_1;
	logic [6:0] SYNTHESIZED_WIRE_2;
	logic [6:0] SYNTHESIZED_WIRE_3;
	logic [6:0] SYNTHESIZED_WIRE_4;
	logic [6:0] SYNTHESIZED_WIRE_5;
	logic [6:0] SYNTHESIZED_WIRE_6;
	logic [6:0] SYNTHESIZED_WIRE_7;
	logic [6:0] SYNTHESIZED_WIRE_8;
	logic [6:0] SYNTHESIZED_WIRE_9;
	logic [6:0] SYNTHESIZED_WIRE_10;
	logic [6:0] SYNTHESIZED_WIRE_11;
	logic [6:0] SYNTHESIZED_WIRE_12;
	logic SYNTHESIZED_WIRE_22;
	logic [4:0] SYNTHESIZED_WIRE_14;
	logic [5:0] SYNTHESIZED_WIRE_15;
	logic [4:0] SYNTHESIZED_WIRE_17;
	logic [5:0] SYNTHESIZED_WIRE_18;
	logic SYNTHESIZED_WIRE_19;
	muxModule b2v_inst0(
		.select(SYNTHESIZED_WIRE_0),
		.day(SYNTHESIZED_WIRE_1),
		.hour_1(SYNTHESIZED_WIRE_2),
		.hour_2(SYNTHESIZED_WIRE_3),
		.min_1(SYNTHESIZED_WIRE_4),
		.min_2(SYNTHESIZED_WIRE_5),
		.month(SYNTHESIZED_WIRE_6),
		.year_1(SYNTHESIZED_WIRE_7),
		.year_2(SYNTHESIZED_WIRE_8),
		.out_1(SYNTHESIZED_WIRE_9),
		.out_2(SYNTHESIZED_WIRE_10),
		.out_3(SYNTHESIZED_WIRE_11),
		.out_4(SYNTHESIZED_WIRE_12)
	);
	digit2Display b2v_inst1(
		.value(SYNTHESIZED_WIRE_9),
		.left(ss7),
		.right(ss6)
	);
	assign SYNTHESIZED_WIRE_0 = ~pb[1];
	digit2Display b2v_inst2(
		.value(SYNTHESIZED_WIRE_10),
		.left(ss5),
		.right(ss4)
	);
	digit2Display b2v_inst3(
		.value(SYNTHESIZED_WIRE_11),
		.left(ss3),
		.right(ss2)
	);
	digit2Display b2v_inst4(
		.value(SYNTHESIZED_WIRE_12),
		.left(ss1),
		.right(ss0)
	);
	clock24 b2v_inst5(
		.clk(SYNTHESIZED_WIRE_22),
		.reset(pb[0]),
		.offset_hours(SYNTHESIZED_WIRE_14),
		.offset_mins(SYNTHESIZED_WIRE_15),
		.cycle(SYNTHESIZED_WIRE_19),
		.hours(SYNTHESIZED_WIRE_2),
		.minutes(SYNTHESIZED_WIRE_4)
	);
	clock24 b2v_inst6(
		.clk(SYNTHESIZED_WIRE_22),
		.reset(pb[0]),
		.offset_hours(SYNTHESIZED_WIRE_17),
		.offset_mins(SYNTHESIZED_WIRE_18),
		.hours(SYNTHESIZED_WIRE_3),
		.minutes(SYNTHESIZED_WIRE_5)
	);
	calendar b2v_inst7(
		.hour_enable(SYNTHESIZED_WIRE_19),
		.clock(SYNTHESIZED_WIRE_22),
		.reset(pb[0]),
		.day_increment(pb[2]),
		.year_increment(pb[3]),
		.month_increment(pb[4]),
		.day_binary(SYNTHESIZED_WIRE_1),
		.LeftYear(SYNTHESIZED_WIRE_7),
		.month_binary(SYNTHESIZED_WIRE_6),
		.RightYear(SYNTHESIZED_WIRE_8)
	);
	changeClock b2v_inst8(
		.clock(SYNTHESIZED_WIRE_22),
		.reset(pb[0]),
		.hour_increment(pb[5]),
		.min_increment(pb[6]),
		.london_hours(SYNTHESIZED_WIRE_17),
		.london_mins(SYNTHESIZED_WIRE_18),
		.offset_hours(SYNTHESIZED_WIRE_14),
		.offset_mins(SYNTHESIZED_WIRE_15)
	);
	clk100HzTo1Hz b2v_inst9(
		.clk_100Hz(hz100),
		.reset(pb[0]),
		.clk_1Hz(SYNTHESIZED_WIRE_22)
	);
endmodule

