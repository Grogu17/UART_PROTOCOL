// UART RECEIVER
module uart_receiver #(parameter CLKS_PER_BIT = 8)(
    input clk,
    input rst,
    input rx,
    output reg[7:0] rx_data,
    output reg rx_done
);
parameter IDLE=0, 
          START=1,
          DATA=2,
          STOP=3,
          CLEANUP=4;

reg [2:0] state;
reg [15:0] clk_count;
reg [2:0] bit_cnt;
reg[7:0] data_reg;

always @(posedge clk or posedge rst) begin
  if(rst) begin
    state<=IDLE;
    rx_data<=0;
    rx_done<=0;
    bit_cnt<=0;
    clk_count<=0;
    data_reg<=0;
  end
  else begin
    case(state)
    
    IDLE: begin
      rx_done<=0;
      bit_cnt<=0; 

      if(rx==0)
        state<=START;  
    end

    START: begin
       if (clk_count < (CLKS_PER_BIT-1)/2)
        clk_count <= clk_count + 1;
       else begin
        clk_count <= 0;

        if (rx == 1'b0)
            state <= DATA;
        else
            state <= IDLE;   
        end
    end

    DATA: begin
      if(clk_count<CLKS_PER_BIT-1)
        clk_count<=clk_count+1;
      else begin
        clk_count<=0;
        data_reg[bit_cnt]<=rx;
        if(bit_cnt<7) 
          bit_cnt<=bit_cnt+1;
        else begin
          bit_cnt<=0;
          state<=STOP;
        end
      end
    end
    STOP: begin
      if(clk_count<CLKS_PER_BIT-1)
        clk_count<=clk_count+1;
      else begin
        clk_count<=0;
        rx_data<=data_reg;
        rx_done<=1'b1;
        state<=CLEANUP;
      end
    end

    CLEANUP: begin
      rx_done<= 1'b0;
      state<=IDLE;
    end
    endcase
  end
end
endmodule
