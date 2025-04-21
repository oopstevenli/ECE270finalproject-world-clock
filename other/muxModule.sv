`default_nettype none
module muxModule(
    input logic select,
    input logic [6:0] hour_1,
    input logic [6:0] min_1,
    input logic [6:0] hour_2,
    input logic [6:0] min_2,
    input logic [6:0] day,
    input logic [6:0] month,
    input logic [6:0] year_1,
    input logic [6:0] year_2,
    output logic [6:0] out_1,
    output logic [6:0] out_2,
    output logic [6:0] out_3,
    output logic [6:0] out_4
);
assign out_1 = select ? hour_1 : day;
assign out_2 = select ? min_1 : month;
assign out_3 = select ? hour_2 : year_1;
assign out_4 = select ? min_2 : year_2;
endmodule