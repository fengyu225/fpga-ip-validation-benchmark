module design_wrapper (
    input wire clk,
    input wire rst,
    output wire [7:0] led
);

reg [23:0] counter1;
reg [31:0] counter2;
reg [31:0] counter3;
reg [7:0] fsm_state1;
reg [7:0] fsm_state2;
reg [15:0] shift_reg1;
reg [15:0] shift_reg2;
reg [15:0] memory [255:0];
wire fsm1_done;
wire fsm2_done;

// Parameters for FSM states
localparam STATE_IDLE  = 8'd0,
           STATE_COUNT = 8'd1,
           STATE_SHIFT = 8'd2,
           STATE_MEM   = 8'd3,
           STATE_DONE  = 8'd4;

// Counter 1 logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        counter1 <= 0;
    end else begin
        counter1 <= counter1 + 1;
    end
end

// Counter 2 logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        counter2 <= 0;
    end else begin
        counter2 <= counter2 + 2;
    end
end

// Counter 3 logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        counter3 <= 0;
    end else begin
        counter3 <= counter3 + 3;
    end
end

// FSM 1 logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        fsm_state1 <= STATE_IDLE;
    end else begin
        case (fsm_state1)
            STATE_IDLE: begin
                if (counter1[23]) begin
                    fsm_state1 <= STATE_COUNT;
                end
            end
            STATE_COUNT: begin
                if (counter2[31]) begin
                    fsm_state1 <= STATE_SHIFT;
                end
            end
            STATE_SHIFT: begin
                if (shift_reg1[15]) begin
                    fsm_state1 <= STATE_MEM;
                end else begin
                    shift_reg1 <= shift_reg1 << 1;
                end
            end
            STATE_MEM: begin
                if (memory[shift_reg1[7:0]] == 16'hFFFF) begin
                    fsm_state1 <= STATE_DONE;
                end else begin
                    memory[shift_reg1[7:0]] <= memory[shift_reg1[7:0]] + 1;
                end
            end
            STATE_DONE: begin
                fsm_state1 <= STATE_IDLE; // Loop back for demonstration purposes
            end
            default: fsm_state1 <= STATE_IDLE;
        endcase
    end
end

assign fsm1_done = (fsm_state1 == STATE_DONE);

// FSM 2 logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        fsm_state2 <= STATE_IDLE;
    end else begin
        case (fsm_state2)
            STATE_IDLE: begin
                if (counter3[31]) begin
                    fsm_state2 <= STATE_COUNT;
                end
            end
            STATE_COUNT: begin
                if (counter1[23]) begin
                    fsm_state2 <= STATE_SHIFT;
                end
            end
            STATE_SHIFT: begin
                if (shift_reg2[15]) begin
                    fsm_state2 <= STATE_DONE;
                end else begin
                    shift_reg2 <= shift_reg2 >> 1;
                end
            end
            STATE_DONE: begin
                fsm_state2 <= STATE_IDLE; // Loop back for demonstration purposes
            end
            default: fsm_state2 <= STATE_IDLE;
        endcase
    end
end

assign fsm2_done = (fsm_state2 == STATE_DONE);

// Shift register 1 logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        shift_reg1 <= 16'h1;
    end else if (fsm_state1 == STATE_SHIFT) begin
        shift_reg1 <= shift_reg1 << 1;
    end
end

// Shift register 2 logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        shift_reg2 <= 16'h8000;
    end else if (fsm_state2 == STATE_SHIFT) begin
        shift_reg2 <= shift_reg2 >> 1;
    end
end

// Initialize memory
integer i;
initial begin
    for (i = 0; i < 256; i = i + 1) begin
        memory[i] = 16'h0000;
    end
end

// LED output logic
assign led[0] = counter1[23];
assign led[1] = counter2[31];
assign led[2] = counter3[31];
assign led[3] = fsm1_done;
assign led[4] = fsm2_done;
assign led[5] = shift_reg1[15];
assign led[6] = shift_reg2[0];
assign led[7] = memory[0][0];

endmodule

