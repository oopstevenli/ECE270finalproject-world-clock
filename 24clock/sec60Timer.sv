`default_nettype none
module sec60Timer(
    input logic clk, reset,
    output logic cycle,
    output logic [6:0] seconds
);
logic [6:0] Q, nextQ;
always_ff @(posedge clk or posedge reset) begin
    if(reset) 
        Q <= 7'd0;
    else
        Q <= nextQ;
end
always_comb begin
    if(Q == 7'd59) begin
        cycle = 1'b1;
        nextQ = 7'd0;
    end
    else begin
        nextQ = Q + 1;
        cycle = 1'd0;
    end
end
assign seconds = Q;
endmodule
