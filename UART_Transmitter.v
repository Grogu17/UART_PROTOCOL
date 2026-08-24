// UART TRANSMITTER
module uart_transmitter #( parameter CLKS_PER_BIT = 8  )(
    input clk,
    input rst,
    input tx_start,
    input [7:0] data_bits,
    output reg tx,
    output reg tx_done
);
parameter IDLE=0, 
          START=1,
          DATA=2,
          STOP=3,
          CLEANUP=4;

reg [2:0] state;
reg [15:0] clk_count;
reg [2:0] bit_cnt;

always @(posedge clk or posedge rst)
begin

  if(rst) begin
    state<=IDLE;
    tx<=1'b1;
    tx_done<=1'b0;
    clk_count<=0;
    bit_cnt<=0;
  end

  else

  begin
    case(state)

    IDLE: begin
      tx<=1'b1;
      tx_done<=1'b0;
      clk_count<=0;
      bit_cnt<=0;

      if(tx_start)
        state<=START;

    end

    START: begin
      tx<=1'b0;
      if(clk_count<CLKS_PER_BIT-1)begin
        clk_count<=clk_count+1;
      end
      else begin
        clk_count<=0;
        state<=DATA;
      end
    end

    DATA: begin
      tx<=data_bits[bit_cnt];
      if(clk_count<CLKS_PER_BIT-1)begin
        clk_count<=clk_count+1;
      end
      else begin
        clk_count<=0;
        if(bit_cnt<7)
          bit_cnt<=bit_cnt+1;
        else begin
          bit_cnt<=0;
          state<=STOP;
        end
      end
    end

    STOP: begin
      tx<=1'b1;
      if(clk_count<CLKS_PER_BIT-1)begin
        clk_count<=clk_count+1;
      end
      else begin
        clk_count<=0;
        tx_done<=1'b1;
        state<=CLEANUP;
      end
    end

    CLEANUP: begin
      tx_done<=1'b0;
      state<=IDLE;
    end
    endcase
  end
end
endmodule
