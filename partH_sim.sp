* SPICE file for modeling an SRAM cell
* Final Project - Design of SRAM Cell and Read/Write Circuitry
* Analysis and Design of Digital Integrated Circuits in Deep Submicron Technology
* Page 397 - Design Problem 2
*
* Measuring the capacitance of a bitline with varrying array sizes.

************************************** Specification of parameters ******************************
* The book use lambda = 0.1um 
* However, the BSIM3 model defines lmin (2 lambda) to be 0.18um
* Therefore, I shall use lambda = 0.09um
**************************************************************************************************

** Import necessary library files
.include 180nm_bulk.mod

** Definition of important parameters
.param lambda = 0.09u
.param Lch = '2*lambda'

*** Define input voltage source (output of preceeding gate) 
V_power Vdd gnd 1.8

*** Main Circuit
* We model the RC circuit derived from the pull-up transistor used in the
* precharge phase of a read. To model the bitline capactiance we use 
* capacitors to model the wire and contact resistance. Actual MOSFETs in 
* the cells model the junction capacitances. Instead of a resistor we use 
* the real pull-up transistor to charge the bitline.

Mn0 Vdd Vdd     1 gnd NMOS l=Lch W='78*lambda' $pull-up transistor
XSRAM_32block_1 1 Vdd gnd 5 SRAM_32block
XSRAM_32block_2 1 Vdd gnd 5 SRAM_32block
XSRAM_32block_3 1 Vdd gnd 5 SRAM_32block
XSRAM_32block_4 1 Vdd gnd 5 SRAM_32block
XSRAM_32block_5 1 Vdd gnd 5 SRAM_32block
XSRAM_32block_6 1 Vdd gnd 5 SRAM_32block
XSRAM_32block_7 1 Vdd gnd 5 SRAM_32block
XSRAM_32block_8 1 Vdd gnd 5 SRAM_32block

*** Define subcircuit of 32 SRAM cells made up of 4 blocks of 8 cells
.SUBCKT SRAM_32block 1 power ground 5
XSRAM_8block_1 1 power ground 5 SRAM_8block
XSRAM_8block_2 1 power ground 5 SRAM_8block
XSRAM_8block_3 1 power ground 5 SRAM_8block
XSRAM_8block_4 1 power ground 5 SRAM_8block
.ends SRAM_32block

*** Define subcircuit of 8 SRAM cells
.SUBCKT SRAM_8block 1 power ground 5
XSRAM_cell_1 1 21 31 power ground 41 5 SRAM_cell
XSRAM_cell_2 1 22 32 power ground 42 5 SRAM_cell
XSRAM_cell_3 1 23 33 power ground 43 5 SRAM_cell
XSRAM_cell_4 1 24 34 power ground 44 5 SRAM_cell
XSRAM_cell_5 1 25 35 power ground 45 5 SRAM_cell
XSRAM_cell_6 1 26 36 power ground 46 5 SRAM_cell
XSRAM_cell_7 1 27 37 power ground 47 5 SRAM_cell
XSRAM_cell_8 1 28 38 power ground 48 5 SRAM_cell
.ends SRAM_8block

*** Define subcircuit of SRAM cell
.SUBCKT SRAM_cell 1 2 3 power ground 4 5 
C1 1 gnd 0.72f $wire capacitance
C2 1 gnd 0.5f  $contact capacitance
Mn_3 1 2 3   gnd NMOS l=Lch W='4*lambda'
Mn_1 3 4 gnd gnd NMOS l=Lch W='2*lambda' ** actual value is 0.4605*4*lambda but value is rounded up
Mp_5 3 4 Vdd Vdd PMOS l=Lch W='8*lambda' ** actual value is 2.368*4*lambda 
Mn_2 4 3 gnd gnd NMOS l=Lch W='2*lambda'
Mp_6 4 3 Vdd Vdd PMOS l=Lch W='8*lambda'
Mn_4 5 2 4   gnd NMOS l=Lch W='4*lambda'
C3 5 gnd 0.72f $wire capacitance
C4 5 gnd 0.5f  $contact capacitance
.ends SRAM_cell

*** Analysis
.ic V(1)=0.36 $ Vdd / 5
.tran 0.01ps 3ns uic
.probe V(1) $ measuring bitline voltage
.options post probe
.end
