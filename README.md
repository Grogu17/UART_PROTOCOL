# UART Protocol Implementation in Verilog

RTL implementation of the UART (Universal Asynchronous Receiver-Transmitter) protocol in Verilog HDL, including transmitter, receiver, and a simulation testbench.

## About the Project
This project implements standard UART serial communication in Verilog HDL. The primary objective is to demonstrate finite state machine (FSM) architecture, clock division techniques, and RTL verification in digital design.

## Features
* **Parameterized Baud Rate**: Configurable using `CLKS_PER_BIT` ($\frac{f_{\text{clk}}}{\text{Baud Rate}}$).
* **Frame Format (8-N-1)**:
  * 1 Start Bit (`0`)
  * 8 Data Bits (LSB First)
  * No Parity
  * 1 Stop Bit (`1`)
* **Mid-Bit Sampling**: Receiver samples at the midpoint of each bit period to maximize timing margin.
* **FSM-Based Design**: Explicit state transitions for `IDLE`, `START`, `DATA`, `STOP`, and `CLEANUP`.
* **Automated Testbench**: Self-checking testbench to verify transmitted data against received data.

## Project Structure
* `uart_transmitter.v` – UART transmitter RTL module.
* `uart_receiver.v` – UART receiver RTL module with center-aligned sampling.
* `uart_testbench.v` – Verilog testbench validating end-to-end transmission.
* `waveform.png` – Simulation waveform output from Vivado.

## Tools Used
* **HDL**: Verilog
* **Simulation & Synthesis**: AMD Xilinx Vivado

## Simulation Results
The testbench transmits the test byte `8'h37` (`8'b0011_0111`). The receiver samples the incoming serial line and reconstructs the data byte with `rx_done` asserted upon completion.

![UART Simulation Waveform](waveform.png)

## Author
* **Sanjana Adhikari**  
* B.Tech – Electronics and Communication Engineering
