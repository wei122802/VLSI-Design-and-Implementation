module FIFO #(
    parameter DATA_WIDTH = 16,
    parameter FIFO_DEPTH = 32
)(
    input                     clk,
    input                     rst_n,
    input                     w_en,
    input  [DATA_WIDTH-1:0]   w_data,
    input                     r_en,
    output [DATA_WIDTH-1:0]   r_data,
    output                    full,
    output                    empty
);

    localparam ADDR_WIDTH = $clog2(FIFO_DEPTH);

    reg [ADDR_WIDTH:0] w_ptr, r_ptr;
    
    reg [ADDR_WIDTH-1:0] safe_w_addr;

    // ---------------------------------------------------------
    // 1. Pointer Updates (Posedge DFFs)
    // ---------------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            r_ptr <= 0;
        end else begin
            if (r_en && !empty) r_ptr <= r_ptr + 1;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            w_ptr <= 0;
        end else begin
            if (w_en && !full) w_ptr <= w_ptr + 1;
        end
    end

    // ---------------------------------------------------------
    // 2. Safe Write Address (Negedge DFF)
    // ---------------------------------------------------------
    always @(negedge clk) begin
        safe_w_addr <= w_ptr[ADDR_WIDTH-1:0];
    end
    // ---------------------------------------------------------
    // 3. Core Memory Array (High-Level Sensitive Latches)
    // ---------------------------------------------------------
   
    wire [DATA_WIDTH-1:0] mem_array [0:FIFO_DEPTH-1];

    genvar i;
    generate
      
        for (i = 0; i < FIFO_DEPTH; i = i + 1) begin : sram_row
            reg [DATA_WIDTH-1:0] cell_q;
            
            always @(*) begin
                if (clk && w_en && !full && (safe_w_addr == i)) begin
                    cell_q = w_data;
                end
            end

            assign mem_array[i] = cell_q;
        end
    endgenerate

    // ---------------------------------------------------------
    // 4. Status Flags & FWFT Data Output
    // ---------------------------------------------------------
    assign empty = (w_ptr == r_ptr);

    assign full  = (w_ptr[ADDR_WIDTH] != r_ptr[ADDR_WIDTH]) && 
                   (w_ptr[ADDR_WIDTH-1:0] == r_ptr[ADDR_WIDTH-1:0]);

    assign r_data = mem_array[r_ptr[ADDR_WIDTH-1:0]];

endmodule

// Area: 13687.833960
// Gate count: 1372
// Dynamic: Total Dynamic Power    =  40.8874 uW  (100%)
// Leakage: Cell Leakage Power     =  12.5939 uW
