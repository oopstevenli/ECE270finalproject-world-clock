`default_nettype none
module splitYear(
    input logic [15:0] year_binary,
    output logic [6:0] leftNum, rightNum);
    logic [15:0] temp_leftNum, temp_rightNum;
    always_comb begin
        temp_leftNum = (year_binary / 100);
        temp_rightNum = (year_binary % 100); //0-9
        leftNum = temp_leftNum[6:0];
        rightNum = temp_rightNum[6:0];
    end
endmodule
