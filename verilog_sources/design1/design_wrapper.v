module design_wrapper (
    input wire clk,
    input wire rst,
    output wire led
);

reg [23:0] counter;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        counter <= 0;
    end else begin
        counter <= counter + 1;
    end
end

assign led = counter[23];

endmodule

