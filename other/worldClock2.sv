module worldClock2 (
	input  logic hz100,
	input  logic [7:0] pb,
	output logic [7:0] ss0,
	output logic [7:0] ss1,
	output logic [7:0] ss2,
	output logic [7:0] ss3,
	output logic [7:0] ss4,
	output logic [7:0] ss5,
	output logic [7:0] ss6,
	output logic [7:0] ss7
	);
	logic calendar_en;
	or(calendar_en, pb[8], SYNTHESIZED_WIRE_18);
	logic [6:0] SYNTHESIZED_WIRE_0;
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
	logic SYNTHESIZED_WIRE_21;
	logic [4:0] SYNTHESIZED_WIRE_13;
	logic [5:0] SYNTHESIZED_WIRE_14;
	logic [4:0] SYNTHESIZED_WIRE_16;
	logic [5:0] SYNTHESIZED_WIRE_17;
	logic SYNTHESIZED_WIRE_18;
	muxModule b2v_inst0(
		.select(pb[1]),
		.day(SYNTHESIZED_WIRE_0),
		.hour_1(SYNTHESIZED_WIRE_1),
		.hour_2(SYNTHESIZED_WIRE_2),
		.min_1(SYNTHESIZED_WIRE_3),
		.min_2(SYNTHESIZED_WIRE_4),
		.month(SYNTHESIZED_WIRE_5),
		.year_1(SYNTHESIZED_WIRE_6),
		.year_2(SYNTHESIZED_WIRE_7),
		.out_1(SYNTHESIZED_WIRE_8),
		.out_2(SYNTHESIZED_WIRE_9),
		.out_3(SYNTHESIZED_WIRE_10),
		.out_4(SYNTHESIZED_WIRE_11)
	);
	digit2Display b2v_inst1(
		.value(SYNTHESIZED_WIRE_8),
		.left(ss7),
		.right(ss6)
	);
	digit2Display b2v_inst2(
		.value(SYNTHESIZED_WIRE_9),
		.left(ss5),
		.right(ss4)
	);
	digit2Display b2v_inst3(
		.value(SYNTHESIZED_WIRE_10),
		.left(ss3),
		.right(ss2)
	);
	digit2Display b2v_inst4(
		.value(SYNTHESIZED_WIRE_11),
		.left(ss1),
		.right(ss0)
	);
	clock24 b2v_inst5(
		.clk(SYNTHESIZED_WIRE_21),
		.reset(pb[0]),
		.offset_hours(SYNTHESIZED_WIRE_13),
		.offset_mins(SYNTHESIZED_WIRE_14),
		.cycle(SYNTHESIZED_WIRE_18),
		.hours(SYNTHESIZED_WIRE_1),
		.minutes(SYNTHESIZED_WIRE_3)
	);
	clock24 b2v_inst6(
		.clk(SYNTHESIZED_WIRE_21),
		.reset(pb[0]),
		.offset_hours(SYNTHESIZED_WIRE_16),
		.offset_mins(SYNTHESIZED_WIRE_17),
		.hours(SYNTHESIZED_WIRE_2),
		.minutes(SYNTHESIZED_WIRE_4)
	);
	calendar b2v_inst7(
		.hour_enable(calendar_en),
		.clock(SYNTHESIZED_WIRE_21),
		.reset(pb[0]),
		.day_increment(pb[2]),
		.year_increment(pb[3]),
		.month_increment(pb[4]),
		.day_binary(SYNTHESIZED_WIRE_0),
		.LeftYear(SYNTHESIZED_WIRE_6),
		.month_binary(SYNTHESIZED_WIRE_5),
		.RightYear(SYNTHESIZED_WIRE_7)
	);
	changeClock b2v_inst8(
		.clock(SYNTHESIZED_WIRE_21),
		.reset(pb[0]),
		.hour_increment(pb[5]),
		.min_increment(pb[6]),
		.london_hours(SYNTHESIZED_WIRE_16),
		.london_mins(SYNTHESIZED_WIRE_17),
		.offset_hours(SYNTHESIZED_WIRE_13),
		.offset_mins(SYNTHESIZED_WIRE_14)
	);
	clk100HzTo1Hz b2v_inst9(
		.clk100hz(hz100),
		.reset(pb[0]),
		.clk1hz(SYNTHESIZED_WIRE_21)
	);

endmodule

