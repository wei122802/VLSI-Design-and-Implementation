`ifdef RTL
    `define CYCLE_TIME 4.3
`endif
`ifdef GATE
    `define CYCLE_TIME 5.0
`endif

module PATTERN(
    output reg clk,
    output reg rst_n,
    output reg in_valid,
    output reg [63:0] in_data,
    input wire out_valid,
    input wire [19:0] out_data
);

// ---------------------------- DO NOT MODIFY THE CODE ABOVE ----------------------------

// =========================================
// Parameter and integer declaration
// =========================================
real CYCLE = `CYCLE_TIME;
integer seed = 634;
real JITTER_LIMIT = CYCLE * 0.20; 

// TODO
//===========================================
// Clock Generation
// Uncomment the desired clock generation method and comment out the others.
//===========================================
real jitter_val;
integer max_steps;
integer rand_val;
integer f_log;
real current_cycle;
initial begin
    f_log = $fopen("jitter_log.txt", "w");
    // 預設 clk 初始值，避免產生 X 狀態
    clk = 1'b0;
    // 將 JITTER_LIMIT (如 4.0 ns) 乘 1000，得到 0.001 精確度下的最大整數步數 (4000)
    max_steps = JITTER_LIMIT * 1000; 
end

// ------ Without Jitter ------
// always #(CYCLE/2.0) clk = ~clk;


// ------ With Uniform Jitter ------

// always begin
//     rand_val = ({$random(seed)} % (2 * max_steps + 1)) - max_steps;
    
//     jitter_val = rand_val / 1000.0;
//     current_cycle = CYCLE + jitter_val;
//     $fdisplay(f_log, "%f", current_cycle);

//     #( (CYCLE + jitter_val) / 2.0 ) clk = 1'b1;
//     #( (CYCLE + jitter_val) / 2.0 ) clk = 1'b0;
// end

// ------ With Gaussian Jitter ------

always begin
    // $dist_normal(seed, mean, standard_deviation)
    rand_val = $dist_normal(seed, 0, max_steps / 3);
    
    if (rand_val > max_steps)  rand_val = max_steps;
    if (rand_val < -max_steps) rand_val = -max_steps;
    
    jitter_val = rand_val / 1000.0;
    current_cycle = CYCLE + jitter_val;
    $fdisplay(f_log, "%f", current_cycle);

    #( (CYCLE + jitter_val) / 2.0 ) clk = 1'b1;
    #( (CYCLE + jitter_val) / 2.0 ) clk = 1'b0;
end

// ---------------------------- DO NOT MODIFY THE CODE BELOW ----------------------------

//===========================================
// integer & reg declaration
//===========================================
integer i, j, k;
integer PATNUM = 100;
integer pat_cnt;
integer local_latency;
integer total_latency = 0;
integer input_file, output_file;

reg [19:0] golden_ans;

//===========================================
// Initial Block for Test Pattern Generation
//===========================================
initial begin
    // Open input and output files
    input_file = $fopen("../00_TESTBED/input.txt", "r");
    output_file = $fopen("../00_TESTBED/output.txt", "r");
    
    if (input_file == 0) begin
        $display("\033[31mFailed to open input.txt\033[0m");
        $finish;
    end
    if (output_file == 0) begin
        $display("\033[31mFailed to open output.txt\033[0m");
        $finish;
    end

    // Reset the DUT
    reset_task();

    // Run through all patterns
    for (pat_cnt = 1; pat_cnt <= PATNUM; pat_cnt = pat_cnt + 1) begin
        local_latency = 0;
        input_data_task();
        wait_out_task();
        check_ans_task();
        total_latency = total_latency + local_latency;
        $display("\033[32m        PATTERN %d Passed!         \033[0m", pat_cnt);
        repeat($urandom_range(2, 5)) @(negedge clk);
    end

    // $fclose(f_log);    // 關閉 log 檔
    // $display("Simulation completed. Log file saved.");
    pass_task();
end


//================================================================
//  TASK
//================================================================
task reset_task; begin
	rst_n = 1'b1;
	in_valid = 1'b0;
    in_data = 'bx;
	force clk = 1'b0;
	#(0.5);
	rst_n = 1'b0;
	#(100); // CHECK: All output signals should be reset after the reset signal is asserted. 
	if (out_valid !== 1'b0 || out_data !== 'b0) begin
		$display("\033[31mRESET FAIL \033[0m");
        $display(" out_valid = %b, out_data = %h", out_valid, out_data);
		$display("==========================================================================================");
        #(100);
		$finish;
	end
	rst_n = 1'b1;
	#(30);
	release clk;
end endtask

task input_data_task; begin
    @(negedge clk);
    in_valid = 1'b1;
    for (i = 0; i < 16; i = i + 1) begin
        k = $fscanf(input_file, "%d %d %d %d %d %d %d %d", in_data[63:56], in_data[55:48], in_data[47:40], in_data[39:32], in_data[31:24], in_data[23:16], in_data[15:8], in_data[7:0]);
        @(negedge clk);
    end
    in_valid = 1'b0;
    in_data = 'bx;
end endtask


task wait_out_task; begin
    while (out_valid !== 1'b1) begin
        if (local_latency > 1000) begin
            $display("\033[31m        PATTERN %d Failed > 1000 cycles latency!         \033[0m", pat_cnt);
            $display("==========================================================================================");
            #(100);
            $finish;
        end
        local_latency = local_latency + 1;
        @(negedge clk);
    end
end endtask

task check_ans_task; begin
    for(i = 0; i < 64; i = i + 1) begin
        k = $fscanf(output_file, "%d", golden_ans);
        if (out_data !== golden_ans) begin
            $display("\033[31m        PATTERN %d Failed!         \033[0m", pat_cnt);
            $display("out_data = %d, golden_ans = %d", out_data, golden_ans);
            $display("==========================================================================================");
            #(100);
            $finish;
        end
        @(negedge clk);
    end
end endtask

task pass_task; begin
    $display("*************************************************************************");
    $display("*                Congratulations!                                       *");
    $display("*                Your execution cycles = %5d cycles                   *", total_latency);
    $display("*                Your clock period = %.1f ns                            *", CYCLE);
    $display("*************************************************************************");
	$display("==========================================================================================");
    $finish;
end endtask

always @(negedge clk) begin
	if(out_valid === 1'b0 && rst_n === 1'b1) begin
		if(out_data !== 0) begin
			$display("\033[31m \033[5m out_valid == 1'b0         out_data !==0 \033[0m");
			$display("==========================================================================================");
			$finish;
		end
	end
end

always @(*) begin
	if(out_valid === 1'b1) begin
		if(in_valid === 1'b1) begin
			$display("\033[31m \033[5m  out_valid == 1'b1      in_valid == 1'b1  \033[0m");
			$display("==========================================================================================");
			$finish;
		end
	end
end


endmodule