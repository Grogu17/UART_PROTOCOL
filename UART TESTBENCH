`timescale 1ns / 1ps
module uart_testbench;

parameter CLKS_PER_BIT = 8;
reg clk;
reg rst;
reg tx_start;
reg [7:0] data_bits;
wire tx_done;
wire tx_line;

wire [7:0] rx_data;
wire rx_done;

uart_transmitter #(.CLKS_PER_BIT(CLKS_PER_BIT)) TX(.clk(clk),.rst(rst),.tx(tx_line),.tx_start(tx_start),.data_bits(data_bits),.tx_done(tx_done));
uart_receiver #(.CLKS_PER_BIT(CLKS_PER_BIT)) RX(.clk(clk),.rst(rst),.rx(tx_line),.rx_data(rx_data),.rx_done(rx_done));

initial begin
    clk=0;
    forever #5 clk=~clk;
end

initial begin
    rst=1;
    tx_start=0;
    data_bits=8'h00;

    #20
    rst=0;

    @(posedge clk)
    data_bits=8'h37;
    tx_start=1;

    @(posedge clk)
    tx_start=0;

    wait(rx_done);

    if(rx_data==data_bits)
        $display("--------------------TEST PASSED: TX=%h , RX=%h------------------------",data_bits,rx_data);
    else
        $display("--------------------TEST FAILED: TX=%h , RX=%h------------------------",data_bits,rx_data);

    #50;
    $finish;

end 
endmodule
