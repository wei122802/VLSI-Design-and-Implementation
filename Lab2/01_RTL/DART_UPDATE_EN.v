module DART_UPDATE_EN (
    input  wire        in_valid,
    input  wire        player,
    output wire        update_en_p0,
    output wire        update_en_p1
);
 
assign update_en_p0 = in_valid & (~player);
assign update_en_p1 = in_valid & player;
 
endmodule
