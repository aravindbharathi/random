# Project- Part A

Submission Deadline:  December 4, 2020 (Friday) 11:29 pm

Group size: Maximum four

Description of design:

Design a signed 16-bit  Arithmetic and Logical Unit (ALU) which computes the following functions.  Use Structural VHDL for the design. You are also required to write testbench to verify your design. 

Signed Addition (control input S1S0 = 00)
Subtraction (Control input S1S0 = 01)
NAND operation (Control input S1S0 = 10)
XOR operation (control input S1S0 = 11)
The output should be the 16 bit result of the computation and carry (in case of arithmetic operation) and zero bit. If the result of computation is zero then it should set the zero output (i.e, z = 1). Assume that the inputs are in 2’s complement form.

Design a fast adder (Brent Kung/ Kogge Stone) to compute addition operation. 

##

Submission output:

VHDL Code

Testbench

Output waveform

##

Resources used:
1. Circuit Diagram: https://shareok.org/bitstream/handle/11244/25747/Gundi_okstate_0664M_13905.pdf;sequence=1 pages 20,22 and 27
2.  Sample code for a 1 bit ALU https://technobyte.org/vhdl-code-for-alu-structural/ (fucking destroyed me when I saw it for the first time 5 hours ago)
3.  YouTube https://www.youtube.com/watch?v=eq1ixy37ZmM
4. Structural Adder Full Code https://gist.github.com/tpmckenzie/6999083
