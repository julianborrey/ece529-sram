* SPICE file for modeling an SRAM cell
* Final Project - Design of SRAM Cell and Read/Write Circuitry
* Analysis and Design of Digital Integrated Circuits in Deep Submicron Technology
* Page 397 - Design Problem 2


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
V_wordline 5 gnd pulse(0v 1.3v, 10n, 7n, 7n, 500n, 1u)
V1 1 gnd 1.3
V2 2 gnd 1.0
*** Define subcircuits
*.SUBCKT SRAM_cell 1 2 3 power ground 4 5 
*Mn_3 1 2 3 gnd NMOS l=Lch W='4*lambda'
*Mn_1 3 4 gnd gnd NMOS l=Lch W='2*lambda' ** actual value is 0.4605*4*lambda but value is rounded up
*Mp_5 3 4 Vdd Vdd PMOS l=Lch W='8*lambda' ** actual value is 2.368*4*lambda 
*Mn_2 4 3 gnd gnd NMOS l=Lch W='2*lambda'
*Mp_6 4 3 Vdd Vdd PMOS l=Lch W='8*lambda'
*Mn_4 5 2 4 gnd NMOS l=Lch W='4*lambda'
*.ends SRAM_cell



*** Construct test circuit for SRAM cell
*Cbit 1 gnd 92.405e-12
*Cbit_bar 5 gnd 92.405e-12
*Mn_3 1 2 3 gnd NMOS l=Lch W='4*lambda'
*Mn_1 3 4 gnd gnd NMOS l=Lch W='2*lambda' ** actual value is 0.4605*4*lambda but value is rounded up
*Mp_5 3 4 Vdd Vdd PMOS l=Lch W='10*lambda' ** actual value is 2.368*4*lambda 
*Mn_2 4 3 gnd gnd NMOS l=Lch W='2*lambda'
*Mp_6 4 3 Vdd Vdd PMOS l=Lch W='10*lambda'
*Mn_4 5 2 4 gnd NMOS l=Lch W='4*lambda'

*** Construct test circuit for sense amplifier circuit
Cout 6 gnd 50e-15
Mp_3 4 4 Vdd Vdd PMOS l=Lch W='10*lambda'
Mp_4 6 4 Vdd Vdd PMOS l=Lch W='10*lambda'
Mn_1 4 1 3 gnd NMOS l=Lch W='2*lambda'
Mn_2 6 5 3 gnd NMOS l=Lch W='2*lambda'
Mn_5 3 2 gnd gnd NMOS l=Lch W='2*lambda'

*** Analysis
*.ic V(2)=1.8
.tran 1ns 1us uic
.probe V(1) V(2) V(3) V(4) V(5) V(6)
.options post probe
.end
