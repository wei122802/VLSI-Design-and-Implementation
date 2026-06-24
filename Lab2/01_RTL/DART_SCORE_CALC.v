
module DART_SCORE_CALC (
    input         is_double,
    input         is_triple,
    input  [4:0]  points,
    output reg [5:0]  score
);

// wire [1:0] mul_sel;
// assign mul_sel = is_triple ? 2'd2 :
//                  is_double ? 2'd1 : 2'd0;

// wire [5:0] score_x1, score_x2, score_x3;
// assign score_x1 = {1'b0, points};
// assign score_x2 = {points, 1'b0}; 
// assign score_x3 = {points, 1'b0} + {1'b0, points}; 

// assign score = (mul_sel == 2'd2) ? score_x3 :
//                (mul_sel == 2'd1) ? score_x2 : score_x1;

always @(*) begin
    case ({is_triple, is_double})
        2'b10:   score = {points, 1'b0} + {1'b0, points}; 
        2'b01:   score = {points, 1'b0};                  
        default: score = {1'b0, points};            
    endcase
end

endmodule