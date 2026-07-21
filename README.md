# UART Protocol Implementation in Verilog
RTL implementation of the UART protocol in Verilog including UART transmitter, receiver, and simulation testbench.

## About the Project
This project is my implementation of the UART (Universal Asynchronous Receiver-Transmitter) protocol using Verilog HDL. The project consists of separate UART Transmitter and UART Receiver modules along with a testbench to verify the design through simulation.

The main objective of this project was to understand serial communication, finite state machines (FSMs), and RTL design.


## Features

- UART Transmitter
- UART Receiver
- Parameterized baud rate using `CLKS_PER_BIT`
- 8-bit data transmission
- FSM-based implementation
- Verilog testbench for verification
  
## UART Frame Format

- 1 Start Bit
- 8 Data Bits
- No Parity Bit
- 1 Stop Bit
  
## Project Files

- `uart_transmitter.v` – UART transmitter module
- `uart_receiver.v` – UART receiver module
- `uart_tb.v` – Testbench for simulation


## Tools Used

- Verilog HDL
- Xilinx Vivado



## Simulation

The design was verified using a Verilog testbench. The transmitter sends 8-bit data serially, and the receiver correctly receives and reconstructs the transmitted data.



## Author

**Sanjana Adhikari**

B.Tech – Electronics and Communication Engineering
