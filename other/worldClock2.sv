module worldClock2 (
	input  logic CLK12M,
	input  logic [6:0] PB,
	output logic [7:0] SS0,
	output logic [7:0] SS1,
	output logic [7:0] SS2,
	output logic [7:0] SS3,
	output logic [7:0] SS4,
	output logic [7:0] SS5,
	output logic [7:0] SS6,
	output logic [7:0] SS7
	);

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
		.select(PB[1]),
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
		.left(SS7),
		.right(SS6)
	);
	digit2Display b2v_inst2(
		.value(SYNTHESIZED_WIRE_9),
		.left(SS5),
		.right(SS4)
	);
	digit2Display b2v_inst3(
		.value(SYNTHESIZED_WIRE_10),
		.left(SS3),
		.right(SS2)
	);
	digit2Display b2v_inst4(
		.value(SYNTHESIZED_WIRE_11),
		.left(SS1),
		.right(SS0)
	);
	clock24 b2v_inst5(
		.clk(SYNTHESIZED_WIRE_21),
		.reset(PB[0]),
		.offset_hours(SYNTHESIZED_WIRE_13),
		.offset_mins(SYNTHESIZED_WIRE_14),
		.cycle(SYNTHESIZED_WIRE_18),
		.hours(SYNTHESIZED_WIRE_1),
		.minutes(SYNTHESIZED_WIRE_3)
	);
	clock24 b2v_inst6(
		.clk(SYNTHESIZED_WIRE_21),
		.reset(PB[0]),
		.offset_hours(SYNTHESIZED_WIRE_16),
		.offset_mins(SYNTHESIZED_WIRE_17),
		.hours(SYNTHESIZED_WIRE_2),
		.minutes(SYNTHESIZED_WIRE_4)
	);
	calendar b2v_inst7(
		.hour_enable(SYNTHESIZED_WIRE_18),
		.clock(SYNTHESIZED_WIRE_21),
		.reset(PB[0]),
		.day_increment(PB[2]),
		.year_increment(PB[3]),
		.month_increment(PB[4]),
		.day_binary(SYNTHESIZED_WIRE_0),
		.LeftYear(SYNTHESIZED_WIRE_6),
		.month_binary(SYNTHESIZED_WIRE_5),
		.RightYear(SYNTHESIZED_WIRE_7)
	);
	changeClock b2v_inst8(
		.clock(SYNTHESIZED_WIRE_21),
		.reset(PB[0]),
		.hour_increment(PB[5]),
		.min_increment(PB[6]),
		.london_hours(SYNTHESIZED_WIRE_16),
		.london_mins(SYNTHESIZED_WIRE_17),
		.offset_hours(SYNTHESIZED_WIRE_13),
		.offset_mins(SYNTHESIZED_WIRE_14)
	);
	clk_div_1hz b2v_inst9(
		.clk12m(CLK12M),
		.reset(PB[0]),
		.clk1hz(SYNTHESIZED_WIRE_21)
	);
	defparam b2v_inst9.DIVISOR = 12000000;
endmodule

