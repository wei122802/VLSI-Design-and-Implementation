// Adjugate Matrix with Error Detection (AMED) module
module AMED(
    input wire clk,
    input wire rst_n,
    input wire in_valid,
    input wire [71:0] in_data,
    output reg out_valid,
    output wire [215:0] out_data
);

    reg [3:0] cnt; 

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt       <= 4'd0;
            out_valid <= 1'b0;
        end else begin
            if (cnt == 4'd0) begin
                if (in_valid) cnt <= 4'd1;
                out_valid <= 1'b0;
            end else if (cnt == 4'd9) begin
                cnt <= 4'd0;
                out_valid <= 1'b1;
            end else begin
                cnt <= cnt + 1'b1;
                out_valid <= 1'b0;
            end
        end
    end

    reg signed [7:0] matrix [0:8];

    always @(posedge clk) begin
        if (cnt == 4'd0 && in_valid) begin
            matrix[0] <= in_data[71:64];
            matrix[1] <= in_data[63:56];
            matrix[2] <= in_data[55:48];
            matrix[3] <= in_data[47:40];
            matrix[4] <= in_data[39:32];
            matrix[5] <= in_data[31:24];
            matrix[6] <= in_data[23:16];
            matrix[7] <= in_data[15:8];
            matrix[8] <= in_data[7:0];
        end
    end

    reg signed [15:0] mult1_a, mult1_b;
    reg signed [15:0] mult2_a, mult2_b;
    wire signed [31:0] mult1_out, mult2_out;
    
    always @(*) begin
        if (cnt >= 4'd1 && cnt <= 4'd9) begin
            case (cnt)
                4'd1: begin mult1_a = matrix[4]; mult1_b = matrix[8]; mult2_a = matrix[5]; mult2_b = matrix[7]; end // Adj11
                4'd2: begin mult1_a = matrix[2]; mult1_b = matrix[7]; mult2_a = matrix[1]; mult2_b = matrix[8]; end // Adj12
                4'd3: begin mult1_a = matrix[1]; mult1_b = matrix[5]; mult2_a = matrix[2]; mult2_b = matrix[4]; end // Adj13
                4'd4: begin mult1_a = matrix[5]; mult1_b = matrix[6]; mult2_a = matrix[3]; mult2_b = matrix[8]; end // Adj21
                4'd5: begin mult1_a = matrix[0]; mult1_b = matrix[8]; mult2_a = matrix[2]; mult2_b = matrix[6]; end // Adj22
                4'd6: begin mult1_a = matrix[2]; mult1_b = matrix[3]; mult2_a = matrix[0]; mult2_b = matrix[5]; end // Adj23
                4'd7: begin mult1_a = matrix[3]; mult1_b = matrix[7]; mult2_a = matrix[4]; mult2_b = matrix[6]; end // Adj31
                4'd8: begin mult1_a = matrix[1]; mult1_b = matrix[6]; mult2_a = matrix[0]; mult2_b = matrix[7]; end // Adj32
                4'd9: begin mult1_a = matrix[0]; mult1_b = matrix[4]; mult2_a = matrix[1]; mult2_b = matrix[3]; end // Adj33
                default: begin mult1_a = 16'd0; mult1_b = 16'd0; mult2_a = 16'd0; mult2_b = 16'd0; end
            endcase
        end else begin
            mult1_a = 16'd0; mult1_b = 16'd0;
            mult2_a = 16'd0; mult2_b = 16'd0;
        end
    end

    MULT_err u_mult1 (.clk(clk), .rst_n(rst_n), .a(mult1_a), .b(mult1_b), .out(mult1_out));
    MULT_err u_mult2 (.clk(clk), .rst_n(rst_n), .a(mult2_a), .b(mult2_b), .out(mult2_out));

    reg signed [15:0] main1, main2;
    always @(posedge clk) begin 
        // if (cnt >= 4'd1 && cnt <= 4'd9) begin
            main1 <= mult1_out[15:0]; 
            main2 <= mult2_out[15:0];
        // end
    end

    reg signed [15:0] shadow1, shadow2;
    always @(negedge clk) begin
        // if (cnt >= 4'd1 && cnt <= 4'd9) begin
            shadow1 <= mult1_out[15:0];
            shadow2 <= mult2_out[15:0];
        // end
    end

    reg signed [15:0] shadow1_sync, shadow2_sync;
    always @(posedge clk) begin
        shadow1_sync <= shadow1;
        shadow2_sync <= shadow2;
    end

    wire mult1_err = (main1 != shadow1_sync);
    wire mult2_err = (main2 != shadow2_sync);
    
    wire signed [15:0] val1 = mult1_err ? shadow1_sync : main1;
    wire signed [15:0] val2 = mult2_err ? shadow2_sync : main2;
    
    wire signed [23:0] sub_result = val1 - val2;

    reg [191:0] shift_buffer;

    always @(posedge clk) begin 
        if (cnt >= 4'd2 && cnt <= 4'd9) begin
            shift_buffer <= {shift_buffer[167:0], sub_result};
        end 
    end

    assign out_data = out_valid ? {shift_buffer, sub_result} : 216'd0;

endmodule

// version 3 
// C = 10 
// Latency: 1000
// Area: 34640.538819
// Total Power: 1022.9461u
// Performance Score: 354354.04

//remove matrix rst
// Latency: 1000
// Area: 34290.874465
// Total Power: 990.4159u
// Performance Score: 339622.27

//remove shadow1_sync and shadow2_sync pipe rst
// Latency: 1000
// Area: 34122.831890
// Total Power: 978.8017u
// Performance Score: 333994.86

//remove shadow1 and shadow2 pipe rst
// Latency: 1000
// Area: 33927.630886
// Total Power: 961.5735u
// Performance Score: 326239.11

// best version : C = 15.9 *****
// Area: 30634.674977
// Total Power: 581.7654u
// Performance Score: 283372.88

// remove shift buffer rst_n
// Latency: 1000
// Area: 29726.566102
// Total Power: 540.3723u
// Performance Score: 255408.27

// remove state 
// Latency: 900
// Area: 29490.627551
// Total Power: 547.4724u
// Performance Score: 231039.31

//best version C = 17.2
// Latency: 900
// Area: 29388.783555
// Total Power: 507.7721u
// Performance Score: 231005.01

//update optimize 
// CT : 9.8
// Latency: 900
// Area: 33384.463458
// Performance : 294,450,967.69956

//remove shadow if state
// CT : 9.8
// Latency: 900
// Area: 32651.186436
//Performance : 287,983,464.36552