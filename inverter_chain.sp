* SPICE file for modeling an SRAM cell
* Final Project - Design of SRAM Cell and Read/Write Circuitry
* Analysis and Design of Digital Integrated Circuits in Deep Submicron Technology
* Page 397 - Design Problem 2
* 
* Inverter chains to model classic rising and falling edges on logical signals.
* It was found that 4 inverters chained together is enough to get the characteristic rise and falls.

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
V_power Vdd   gnd 1.8
V_input input gnd 1.8 pulse(0v 1.8v, 1n, 100p, 100p, 6n, 7n)

*** Main Circuit
XInvBlock0  input out0 Vdd gnd InverterBlock
XInvBlock1  out0  out1 Vdd gnd InverterBlock
XInvBlock2  out1  out2 Vdd gnd InverterBlock
XInvBlock3  out2  out3 Vdd gnd InverterBlock
XInvBlock4  out3  out4 Vdd gnd InverterBlock
XInvBlock5  out4  out5 Vdd gnd InverterBlock
XInvBlock6  out5  out6 Vdd gnd InverterBlock
XInvBlock7  out6  out7 Vdd gnd InverterBlock
XInvBlock8  out7  out8 Vdd gnd InverterBlock

*** Inverter Block subcircuit
.SUBCKT InverterBlock in out power ground
XInv1  in     out1   power ground Inverter
XInv2  out1   out2   power ground Inverter
XInv3  out2   out3   power ground Inverter
XInv4  out3   out    power ground Inverter
*XInv5  out4   out5   power ground Inverter
*XInv6  out5   out6   power ground Inverter
*XInv7  out6   out7   power ground Inverter
*XInv8  out7   out    power ground Inverter
.ends InverterBlock

*** Inverter subcircuit
.SUBCKT Inverter in out power ground
Mp_load out in power  PMOS l=Lch W='4*lambda'
Mn_inv  out in ground NMOS l=Lch W='2*lambda'
.ends Inverter

*** Analysis
.ic V(input)=0
.tran 1fs 15ns uic
.probe V(input) V(out0) V(out1) V(out2) V(out3) V(out7) V(out8)
.options post probe
.end
