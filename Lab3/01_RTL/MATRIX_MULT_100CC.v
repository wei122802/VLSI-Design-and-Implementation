module MATRIX_MULT (
    input             clk,
    input             rst_n,
    input             in_valid,
    input      [63:0] in_data,
    output reg        out_valid,
    output reg [19:0] out_data
);


reg [7:0] matrix_A [0:7][0:7];
reg [7:0] matrix_B [0:7][0:7];

reg [15:0] p1_prod [0:7][0:7][0:7]; 

reg [19:0] mat_c [0:7][0:7];

reg [5:0]  out_cnt;

reg [3:0] input_cnt;
reg       in_done;

integer i, j, k;

// -------------------------------------------------------------------------
// Input capture
// -------------------------------------------------------------------------
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        input_cnt <= 4'd0;
        in_done   <= 1'b0;
        for (i = 0; i < 8; i = i+1)
            for (j = 0; j < 8; j = j+1) begin
                matrix_A[i][j] <= 8'd0;
                matrix_B[i][j] <= 8'd0;
            end
    end else begin
        in_done <= 1'b0;
        if (in_valid) begin
            if (!input_cnt[3]) begin
                matrix_A[input_cnt[2:0]][0] <= in_data[63:56];
                matrix_A[input_cnt[2:0]][1] <= in_data[55:48];
                matrix_A[input_cnt[2:0]][2] <= in_data[47:40];
                matrix_A[input_cnt[2:0]][3] <= in_data[39:32];
                matrix_A[input_cnt[2:0]][4] <= in_data[31:24];
                matrix_A[input_cnt[2:0]][5] <= in_data[23:16];
                matrix_A[input_cnt[2:0]][6] <= in_data[15: 8];
                matrix_A[input_cnt[2:0]][7] <= in_data[ 7: 0];
            end else begin
                matrix_B[input_cnt[2:0]][0] <= in_data[63:56];
                matrix_B[input_cnt[2:0]][1] <= in_data[55:48];
                matrix_B[input_cnt[2:0]][2] <= in_data[47:40];
                matrix_B[input_cnt[2:0]][3] <= in_data[39:32];
                matrix_B[input_cnt[2:0]][4] <= in_data[31:24];
                matrix_B[input_cnt[2:0]][5] <= in_data[23:16];
                matrix_B[input_cnt[2:0]][6] <= in_data[15: 8];
                matrix_B[input_cnt[2:0]][7] <= in_data[ 7: 0];
            end
            if (input_cnt == 4'd15) begin
                input_cnt <= 4'd0;
                in_done   <= 1'b1;
            end else begin
                input_cnt <= input_cnt + 1'b1;
            end
        end
    end
end

always @(*) begin
    if (in_done || out_valid) begin
        for (i = 0; i < 8; i = i+1)
            for (j = 0; j < 8; j = j+1)
                for (k = 0; k < 8; k = k+1)
                    p1_prod[i][j][k] =
                        ({8'd0, matrix_A[i][k]} * {8'd0, matrix_B[k][j]});
    end
    else begin
        for (i = 0; i < 8; i = i+1)
            for (j = 0; j < 8; j = j+1)
                for (k = 0; k < 8; k = k+1)
                    p1_prod[i][j][k] = 0;
    end
end

always @(*) begin
    for (i = 0; i < 8; i = i+1) begin
        for (j = 0; j < 8; j = j+1)
            mat_c[i][j] =
                (( ({1'b0, p1_prod[i][j][0]} + {1'b0, p1_prod[i][j][1]})+ ({1'b0, p1_prod[i][j][2]} + {1'b0, p1_prod[i][j][3]}))+
                (( {1'b0, p1_prod[i][j][4]} + {1'b0, p1_prod[i][j][5]})  + ({1'b0, p1_prod[i][j][6]} + {1'b0, p1_prod[i][j][7]}) ));
    end
end

wire [19:0] c_wire;
assign c_wire = (({1'b0,p1_prod[0][0][0]}+{1'b0,p1_prod[0][0][1]})
                +({1'b0,p1_prod[0][0][2]}+{1'b0,p1_prod[0][0][3]}))
               +(({1'b0,p1_prod[0][0][4]}+{1'b0,p1_prod[0][0][5]})
                +({1'b0,p1_prod[0][0][6]}+{1'b0,p1_prod[0][0][7]}));

reg [5:0] out_cnt_pipe;
reg done;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) out_cnt_pipe<=0;
    else out_cnt_pipe <=out_cnt ;
end

always @(*) begin
    done = out_cnt_pipe==6'd63;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out_valid <= 1'b0;
        out_cnt   <= 6'd0;
    end else begin
        if (in_done) begin
            out_valid <= 1'b1;
            out_cnt   <= 6'd1;
        end else if (out_valid) begin
            out_cnt  <= out_cnt + 1'b1;
            if (&out_cnt_pipe)
                out_valid <= 1'b0;
        end else begin
            out_cnt  <= 6'd0;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out_data  <= 20'd0;
    end else if (in_done) begin
        out_data <= c_wire;   
    end else if (out_valid && !done) begin
        out_data <= mat_c[out_cnt[5:3]][out_cnt[2:0]];
    end else begin
        out_data <= 20'd0;
    end
end

endmodule

// 100 * 5.5 =550