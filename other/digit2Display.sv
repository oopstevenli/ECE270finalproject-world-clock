`default_nettype none
module digit2Display (
    input  logic [6:0] value,
    output logic [7:0] left,
    output logic [7:0] right
);
    logic [3:0] tens, ones;
    always_comb begin
        tens = value / 10;
        ones = value % 10;
    end
    function automatic [7:0] seg_decode(input logic [3:0] digit);
        case (digit)
            4'd0: seg_decode = 8'b00111111;
            4'd1: seg_decode = 8'b00000110;
            4'd2: seg_decode = 8'b01011011;
            4'd3: seg_decode = 8'b01001111;
            4'd4: seg_decode = 8'b01100110;
            4'd5: seg_decode = 8'b01101101;
            4'd6: seg_decode = 8'b01111101;
            4'd7: seg_decode = 8'b00000111;
            4'd8: seg_decode = 8'b01111111;
            4'd9: seg_decode = 8'b01101111;
            default: seg_decode = 8'b00000000;
        endcase
    endfunction
    always_comb begin
        left  = seg_decode(tens);
        right = seg_decode(ones);
    end
endmodule
