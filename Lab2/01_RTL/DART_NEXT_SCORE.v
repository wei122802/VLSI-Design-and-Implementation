module DART_NEXT_SCORE (
    input  [8:0]  score,  
    input  [5:0]  throw_score, 
    output [9:0]  next_score   
);

assign next_score = {1'b0, score} - {4'b0, throw_score};

endmodule
