# Memory-design-using-Verilog

## Project Overview

This project implements a **parameterized memory module** in Verilog along with a **testbench** for simulation and verification. The design supports **read/write operations** using a simple **valid–ready handshake** mechanism.

## Objective

The goal of this project is to design and verify a memory system that:

* Supports parameterized data width and memory depth.
* Allows controlled read/write access.
* Demonstrates valid–ready handshaking for data transfers.

## Features

* Parameterized **WIDTH** (data size) and **DEPTH** (memory size).
* Addressable memory locations using `addr` input.
* Separate signals for **read** and **write** operations.
* **Valid–Ready handshake** for proper data transfer.
* Testbench included for functional verification.

## Project Structure

```
├── memory.v        # Memory design module
├── tb_memory.v     # Testbench for memory
└── README.md       # Project documentation
```

## How to Run

You can run the project using **ModelSim/QuestaSim** or any Verilog simulator:

1. Compile the design and testbench:

   ```bash
   vlog memory.v tb_memory.v
   ```

2. Run simulation:

   ```bash
   vsim tb_memory
   ```

3. View waveforms:

   ```bash
   add wave *
   run -all
   ```

## Results

* Verified **write** operations store data at given addresses.
* Verified **read** operations fetch correct data.
* Valid–Ready handshake ensures proper synchronization.

* Ex: Consecutive write_read operation(waveform):
  <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/06912c33-a89c-473f-83ed-91219fb5e4b4" />


## Key Learnings

* Designed parameterized memory in Verilog.
* Implemented **valid–ready handshaking protocol**.
* Gained experience with testbench development and simulation.

## Future Improvements

* Extend design to support burst read/write operations.
* Add error-checking for invalid addresses.
* Implement cache-like features for performance optimization.

---

