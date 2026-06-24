#======================================================
#
# Synopsys Synthesis Scripts (Design Vision dctcl mode)
#
#======================================================

#======================================================
# (A) Global Parameters
#======================================================
set DESIGN "AMED"
set CYCLE 9.8
# set CYCLE $::env(CYCLE_TIME)

# if {[info exists ::env(CYCLE_TIME)]} {
#     set cycle $::env(CYCLE_TIME)
#     puts "INFO: Received CYCLE_TIME = $cycle from Bash script."
# } else {
#     # 如果抓不到變數，給定一個安全的預設值，避免 DC 直接崩潰
#     set cycle 20.0
#     puts "WARNING: CYCLE_TIME not found in environment, using default 20.0"
# }

set INPUT_DLY [expr 0.5*$CYCLE]
set OUTPUT_DLY [expr 0.5*$CYCLE]

#======================================================
# (B) Read RTL Code
#======================================================
# # (B-1) analyze + elaborate
# set hdlin_auto_save_templates TRUE
# analyze -f sverilog -define SYNTHESIS MULT_err.v
# analyze -f sverilog -define SYNTHESIS $DESIGN\.v 
# # analyze -f sverilog -define SYNTHESIS "$DESIGN\.v MULT_err.sv"
# elaborate $DESIGN

# # (B-2) read_sverilog
# #read_sverilog $DESIGN\.v

# # (B-3) set current design
# current_design $DESIGN
# link

set hdlin_auto_save_templates TRUE

# -----------------------------------------------------
#  Phase 1: Read and Lock the "MULT_err Module" (MULT_err)
# -----------------------------------------------------
analyze -f sverilog "MULT_err_SYN.v"
elaborate MULT_err
current_design MULT_err

set_max_delay [expr 0.3*$CYCLE] -from [all_inputs] -to [all_outputs]
set_max_transition 2.0 [all_inputs]
set_max_capacitance 0.1 [all_inputs]
set_load 0.05 [all_outputs]
compile_ultra 
# Lock the "MULT_err Module" to prevent any modifications during optimization
set_dont_touch [get_designs MULT_err]

# -----------------------------------------------------
# Phase 2: Read, Elaborate, and Link the Main Design (AMED)
# -----------------------------------------------------
analyze -f sverilog "$DESIGN\.v"
elaborate $DESIGN  
current_design $DESIGN
link

#======================================================
#  (C) Global Setting
#======================================================

#set_wire_load_mode top
#set_operating_conditions -max WCCOM -min BCCOM
#set_wire_load_model -name umc18_wl10 -library slow

#======================================================
#  (D) Set Design Constraints
#======================================================

# (D-1) Setting Clock Constraints

create_clock -name clk -period $CYCLE [get_ports clk] 
set_dont_touch_network             [get_clocks clk]
set_fix_hold                       [get_clocks clk]
set_clock_uncertainty       0.1    [get_clocks clk]
# set_clock_latency   -source 0      [get_clocks clk]
# set_clock_latency           1      [get_clocks clk] 
set_input_transition        0.5    [all_inputs] 
set_clock_transition        0.1    [all_clocks] 

# (D-2) Setting in/out Constraints
set_input_delay   -max  $INPUT_DLY  -clock clk   [all_inputs] ;  # set_up time check 
set_input_delay   -min  0           -clock clk   [all_inputs] ;  # hold   time check 
set_output_delay  -max  $OUTPUT_DLY -clock clk   [all_outputs] ; # set_up time check 
set_output_delay  -min  0           -clock clk   [all_outputs] ; # hold   time check 
set_input_delay 0 -clock clk clk
set_input_delay 0 -clock clk rst_n
#set_max_delay $CYCLE -from [all_inputs] -to [all_outputs]

# (D-3) Setting Design Environment
# set_driving_cell -library umc18io3v5v_slow -lib_cell P2C    -pin {Y}  [get_ports clk]
# set_driving_cell -library umc18io3v5v_slow -lib_cell P2C    -pin {Y}  [remove_from_collection [all_inputs] [get_ports clk]]
# set_load  [load_of "umc18io3v5v_slow/P8C/A"]       [all_outputs] ; # ~= 0.038
set_load 0.05 [all_outputs]

# (D-4) Setting DRC Constraint
#set_max_delay           0     ; # Optimize delay max effort                 
#set_max_area            0      ; # Optimize area max effort           
set_max_transition      3       [all_inputs]   ; # U18 LUT Max Transition Value  
set_max_capacitance     0.15    [all_inputs]   ; # U18 LUT Max Capacitance Value
set_max_fanout          10      [all_inputs]
# set_dont_use slow/JKFF*
#set_dont_touch [get_cells core_reg_macro]
#set hdlin_ff_always_sync_set_reset true

# (D-5) Report Clock skew
report_clock -skew clk
check_timing

#======================================================
#  (E) Optimization
#======================================================
check_design > Report/$DESIGN\.check
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]
set_fix_hold [all_clocks]
# set_dont_touch [get_cells -hierarchical -filter "ref_name =~ *MULT_err*"]
# set_ungroup [get_designs MULT_err*] false
compile_ultra -no_autoungroup
#uniquify
#compile

#======================================================
#  (F) Output Reports 
#======================================================
report_design  >  Report/$DESIGN\.design
report_resource >  Report/$DESIGN\.resource
report_timing -max_paths 3 >  Report/$DESIGN\.timing
report_area >  Report/$DESIGN\.area
report_power > Report/$DESIGN\.power
report_clock > Report/$DESIGN\.clock
report_port >  Report/$DESIGN\.port
report_power >  Report/$DESIGN\.power
report_reference > Report/$DESIGN\.reference

#======================================================
#  (G) Change Naming Rule
#======================================================
set bus_inference_style "%s\[%d\]"
set bus_naming_style "%s\[%d\]"
set hdlout_internal_busses true
change_names -hierarchy -rule verilog
define_name_rules name_rule -allowed "a-z A-Z 0-9 _" -max_length 255 -type cell
define_name_rules name_rule -allowed "a-z A-Z 0-9 _[]" -max_length 255 -type net
define_name_rules name_rule -map {{"\\*cell\\*" "cell"}}
define_name_rules name_rule -case_insensitive
change_names -hierarchy -rules name_rule

# Remove the correct Multiplier (MULT) from the design
# remove_design *MULT_err*

#======================================================
#  (H) Output Results
#======================================================
set verilogout_higher_designs_first true
write -format verilog -output Netlist/$DESIGN\_SYN.v -hierarchy
write -format ddc     -hierarchy -output $DESIGN\_SYN.ddc
write_sdf -version 3.0 -context verilog -load_delay cell Netlist/$DESIGN\_SYN.sdf -significant_digits 6
write_sdc Netlist/$DESIGN\_SYN.sdc

#======================================================
#  (I) Finish and Quit
#======================================================

report_power
report_area
report_timing 
exit
