`timescale 1ns / 1ps
`default_nettype none
module tb;
    // Inputs
    reg clk_in;
    reg sys_rstn;
    reg [7:0] dip_switch0;
    reg [7:0] dip_switch1;
    reg [7:0] dip_switch2;
    reg [7:0] dip_switch3;
    reg [7:0] dip_switch4;
    reg [7:0] dip_switch5;
    reg [7:0] dip_switch6;
    reg [7:0] dip_switch7;
    reg [7:0] user_key;
    reg uart_rxd;

    // Outputs
    wire [31:0] led_light;
    wire [7:0] digital_tube2;
    wire digital_tube_sel2;
    wire [7:0] digital_tube1;
    wire [3:0] digital_tube_sel1;
    wire [7:0] digital_tube0;
    wire [3:0] digital_tube_sel0;
    wire uart_txd;

    // Instantiate the Unit Under Test (UUT)
    fpga_top uut (
        .clk_in(clk_in), 
        .sys_rstn(sys_rstn), 
        .dip_switch0(dip_switch0), 
        .dip_switch1(dip_switch1), 
        .dip_switch2(dip_switch2), 
        .dip_switch3(dip_switch3), 
        .dip_switch4(dip_switch4), 
        .dip_switch5(dip_switch5), 
        .dip_switch6(dip_switch6), 
        .dip_switch7(dip_switch7), 
        .user_key(user_key), 
        .led_light(led_light), 
        .digital_tube2(digital_tube2), 
        .digital_tube_sel2(digital_tube_sel2), 
        .digital_tube1(digital_tube1), 
        .digital_tube_sel1(digital_tube_sel1), 
        .digital_tube0(digital_tube0), 
        .digital_tube_sel0(digital_tube_sel0), 
        .uart_rxd(uart_rxd), 
        .uart_txd(uart_txd)
    );

    initial begin
        // $fsdbDumpvars();
        // Initialize Inputs
        clk_in = 0;
        sys_rstn = 0;
        dip_switch0 = 0;
        dip_switch1 = 0;
        dip_switch2 = 0;
        dip_switch3 = 0;
        dip_switch4 = 0;
        dip_switch5 = 0;
        dip_switch6 = 0;
        dip_switch7 = 0;
        user_key = 0;
        uart_rxd = 1;

        // Wait for reset to finish
        #4
        sys_rstn = 1;
        
        // Add stimulus here
        // ӷ - 
        user_key = 8'b1111_1001;
        {dip_switch3, dip_switch2, dip_switch1, dip_switch0} = ~32'h3210_0000;
        {dip_switch7, dip_switch6, dip_switch5, dip_switch4} = ~32'h4444_3210;
        #2400
		  {dip_switch3, dip_switch2, dip_switch1, dip_switch0} = ~32'h1111_0110;
        {dip_switch7, dip_switch6, dip_switch5, dip_switch4} = ~32'h0234_1110;
		  #2400
        $finish;
    end

    always #2 clk_in = ~clk_in;
endmodule