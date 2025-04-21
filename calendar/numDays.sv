`default_nettype none
module numDays(
    input logic [3:0] month,
    input logic leap_year,
    output logic [5:0] days);
    always_comb begin
        case (month)
            4'd1:  days = 6'd31; // January
            4'd2:  days = leap_year ? 6'd29 : 6'd28; // February
            4'd3:  days = 6'd31; // March
            4'd4:  days = 6'd30; // April
            4'd5:  days = 6'd31; // May
            4'd6:  days = 6'd30; // June
            4'd7:  days = 6'd31; // July
            4'd8:  days = 6'd31; // August
            4'd9:  days = 6'd30; // September
            4'd10: days = 6'd31; // October
            4'd11: days = 6'd30; // November
            4'd12: days = 6'd31; // December
            default: days = 6'd0; // Invalid month
        endcase
    end
endmodule