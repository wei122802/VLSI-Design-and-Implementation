`ifdef RTL
    `define CYCLE_TIME 20.0
`endif
`ifdef GATE
    `define CYCLE_TIME 20.0
`endif

module PATTERN #(
    parameter DATA_WIDTH = 16,
    parameter FIFO_DEPTH = 32
)(
    output reg                  clk,
    output reg                  rst_n,
    output reg                  w_en,
    output reg [DATA_WIDTH-1:0] w_data,
    output reg                  r_en,
    input  reg [DATA_WIDTH-1:0] r_data,
    input  wire                 full,
    input  wire                 empty
);

//===========================================
// Clock Generation
//===========================================
real CYCLE = `CYCLE_TIME;
always	#(CYCLE/2.0) clk = ~clk;

//===========================================
// integer & reg declaration
//===========================================
integer i, j;
integer PATNUM = 1000;
integer total_latency = 0;

// Golden Model
reg [DATA_WIDTH-1:0] golden_queue [0:20000];
integer head = 0;
integer tail = 0;
integer fifo_count = 0;

integer seed = 415;

// Debug Flag
integer mode = 0; // 0: normal (all tasks), 1: full & empty task, 2: only random task
// integer debug = 0; // 0: no debug, 1: print detailed info for each operation

//===========================================
// Initial Block for Test Pattern Generation
//===========================================
initial begin
    $srandom(seed);

    reset_task();

    // full_task();
    // empty_task();
    // random_task();

    if (mode == 0) begin
        full_task();
        empty_task();
        random_task();
    end 
    else if (mode == 1) begin
        full_task();
        empty_task();
    end 
    else if (mode == 2) begin
        random_task();
    end

    pass_task();
end


//================================================================
//  TASK
//================================================================
task reset_task; begin
	rst_n  = 1'b1;
    w_en   = 1'b0;
    r_en   = 1'b0;
    w_data = 'bx;
    force clk = 1'b0;
    #(0.5);
    rst_n = 1'b0;
    
    #(100); 
    // CHECK
    if (full !== 1'b0 || empty !== 1'b1) begin
        $display("\033[31m[ERROR] RESET FAIL: full and empty flags are incorrect \033[0m");
        $display(" Expected: full = 0, empty = 1");
        $display(" Got     : full = %b, empty = %b", full, empty);
        #(100);
        $finish;
    end
    
    rst_n = 1'b1;
    #(30);
    release clk;
end endtask

task full_task; begin
    $display("=> Start Full Task...");
    
    // write until FIFO is full
    for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
        @(negedge clk);
        #2;
        w_en   = 1'b1;
        r_en   = 1'b0;
        w_data = $urandom % (1 << DATA_WIDTH);
        
        // save info to golden model
        golden_queue[tail] = w_data;
        tail = tail + 1;
        fifo_count = fifo_count + 1;
    end
    
    // check full flag in the next cycle
    @(negedge clk);
    #2;
    w_en = 1'b0;
    if (full !== 1'b1) begin
        $display("\033[31m[ERROR] FULL FLAG FAIL \033[0m");
        $display(" FIFO should be full after writing %d items.", FIFO_DEPTH);
        #(100);
        $finish;
    end

    // Overflow test
    @(negedge clk);
    #2;
    w_en   = 1'b1;
    w_data = 16'hDEAD; // unused data, should not be written
    @(negedge clk);
    #2;
    w_en   = 1'b0;
    w_data = 'b0;

    // Pass full task, prepare for empty task
    $display(" \033[32m[INFO] FULL TASK PASSED \033[0m");
    
end endtask

task empty_task; begin
    $display("=> Start Empty Task...");
    
    // read until FIFO is empty
    for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
        @(negedge clk);
        #2;
        // FWFT check
        if (r_data !== golden_queue[head]) begin
            $display("\033[31m[ERROR] DATA MISMATCH AT READ %d \033[0m", i);
            $display(" Expected: %h, Got: %h", golden_queue[head], r_data);
            #(100);
            $finish;
        end
        
        w_en = 1'b0;
        r_en = 1'b1;
        head = head + 1;
        fifo_count = fifo_count - 1;
    end
    
    // check empty flag in the next cycle
    @(negedge clk);
    #2;
    r_en = 1'b0;
    if (empty !== 1'b1) begin
        $display("\033[31m[ERROR] EMPTY FLAG FAIL \033[0m");
        $display(" FIFO should be empty after reading all items.");
        #(100);
        $finish;
    end

    // Underflow test
    @(negedge clk);
    #2;
    r_en = 1'b1;
    @(negedge clk);
    #2;
    r_en = 1'b0;

    // Pass empty task, prepare for random task
    $display(" \033[32m[INFO] EMPTY TASK PASSED \033[0m");
end endtask

reg valid_write;
reg valid_read;
task random_task; begin
    $display("=> Start Random R/W Task...");
    
    for (i = 0; i < PATNUM; i = i + 1) begin
        @(negedge clk);
        #2;
        
        // randomly generate read/write enable and write data
        w_en = $urandom_range(0, 1);
        r_en = $urandom_range(0, 1);
        w_data = $urandom % (1 << DATA_WIDTH);

        // 1. 先用當下的狀態，判斷這回合的讀寫是否合法
        
        valid_write = (w_en && fifo_count < FIFO_DEPTH);
        valid_read  = (r_en && fifo_count > 0);

        // 2. 根據合法的訊號，更新指標與 Queue
        if (valid_write) begin
            golden_queue[tail] = w_data;
            tail = tail + 1;
        end
        
        if (valid_read) begin
            head = head + 1;
        end
        
        // 3. 最後結算 fifo_count 的增減
        if (valid_write && !valid_read) begin
            fifo_count = fifo_count + 1;
        end else if (!valid_write && valid_read) begin
            fifo_count = fifo_count - 1;
        end
        
        // 等待一點時間讓組合邏輯(full/empty/r_data)穩定，再進行檢查
        @(posedge clk);
        #(CYCLE * 0.3);
        
        // check full and empty flags
        if (full !== (fifo_count == FIFO_DEPTH)) begin
            $display("\033[31m[ERROR] Random Task: FULL flag mismatch \033[0m");
            // debug info
            $display(" Expected: full = %b, Got: %b", (fifo_count == FIFO_DEPTH), full);
            #(100);
            $finish;
        end
        if (empty !== (fifo_count == 0)) begin
            $display("\033[31m[ERROR] Random Task: EMPTY flag mismatch \033[0m");
            // debug info
            $display(" Expected: empty = %b, Got: %b", (fifo_count == 0), empty);
            #(100);
            $finish;
        end
        
        // check read data (only when FIFO is not empty)
        if (fifo_count > 0 && r_data !== golden_queue[head]) begin
            $display("\033[31m[ERROR] Random Task: r_data MISMATCH \033[0m");
            $display(" Expected: %h, Got: %h", golden_queue[head], r_data);
            #(100);
            $finish;
        end
    end
    
    // Make sure to disable R/W at the end of random task
    @(negedge clk);
    #2;
    w_en = 1'b0;
    r_en = 1'b0;

    // Pass random task
    $display(" \033[32m[INFO] RANDOM TASK PASSED \033[0m");
end endtask

task pass_task; begin
    $display("*************************************************************************");
    $display("*                Congratulations!                                       *");
    // $display("*                Your execution cycles = %5d cycles                   *", total_latency);
    $display("*                Your clock period = %.1f ns                            *", CYCLE);
    $display("*************************************************************************");
	$display("==========================================================================================");
    $finish;
end endtask

// always @(negedge clk) begin
// 	if(out_valid === 1'b0 && rst_n === 1'b1) begin
// 		if(out_data !== 0) begin
// 			$display("\033[31m \033[5m out_valid == 1'b0         out_data !==0 \033[0m");
// 			$display("==========================================================================================");
// 			$finish;
// 		end
// 	end
// end

// always @(*) begin
// 	if(out_valid === 1'b1) begin
// 		if(in_valid === 1'b1) begin
// 			$display("\033[31m \033[5m  out_valid == 1'b1      in_valid == 1'b1  \033[0m");
// 			$display("==========================================================================================");
// 			$finish;
// 		end
// 	end
// end


endmodule