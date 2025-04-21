`default_nettype none
module splitYear(
    input logic [15:0] year_binary,
    output logic [6:0] leftNum, rightNum);
    always_comb begin
        leftNum = (year_binary / 100);
        rightNum = (year_binary % 100); //0-9
    end
endmodule