* sramCell.sp
* ECE 529 - Final project.
* Single SRAM cell. - 26/04/2015

* include the 180 nm model
.include 180nm_bulk.mod

* constants *
.param Vdd = 1.8
 
* simulation input *
.op

* internal node to cell *
.ic q = Vdd

*.tran 0.001n 2n
Vsupply Vd gnd Vdd
Vs_to_groung Vs 0 0
*VbitLinecharge in gnd PULSE (0 Vdd 0.1n 0.01n 10n 20n)
*Vflip

* simulation output *
.probe v(in) v(n2) v(out)
.options acct post probe

* circuit *
* a single cell *
X_cell wordLine bLine bBarLine Vdd gnd




******************** subcircuits *************************

***  sram cell  ***
.subckt wordLine bLine bBarLine nVdd nVss
X_M3 b wordLine q X_M34_NMOS 
XInvLeft  qBar q    nVdd nVss X_inv_cell
XInvRight q    qBar nVdd nVss X_inv_cell
X_M4 bBar wordLine qBar X_M34_NMOS
.ends sramCell

* inverter for SRAM cell*
.subckt X_inv_cell nIn nOut nVdd nVss
XM56 nOut nIn nVdd X_M56_PMOS
XM12 nOut nIn nVss X_M12_NMOS
.ends

* M3 and M4 of SRAM cell
.subckt X_M34_NMOS VD VG VS
Mn1 VQD VQG VQS NMOS W=0.4u L=0.2u
*** Note you need to specify L here.

* dummy voltages
VID VD VQD 0V
VIG VG VQG 0V
VIS VQS VS 0V
.ends

* M1 and M2 of SRAM cell
.subckt X_M12_NMOS VD VG VS 
Mn1 VQD VQG VQS NMOS W=0.4u L=0.2u
*** Note you need to specify L here.

* dummy voltages
VID VD VQD 0V
VIG VG VQG 0V
VIS VQS VS 0V
.ends

* M5 and M6 of SRAM cell
.subckt X_M56_PMOS VD VG VS 
Mn1 VQD VQG VQS PMOS W=0.8u L=0.2u
*** Note you need to specify L here.

** dummy voltagies
VID VD VQD 0V
VIG VG VQG 0V
VIS VQS VS 0V
.ends





* inverter *
.subckt X_Inv nIn nOut nVdd nVss
Xpmos nOut nIn nVdd X_LPMOS
Xnmos nOut nIn nVss X_INMOS
.ends XInv

* transfer gate *
.subckt X_tg nIn nOut nOn nOff
Xnmos nOut nOn  nIn X_TG_NMOS
Xpmos nOut nOff nIn X_TG_PMOS
.ends Xtg

.subckt X_INMOS VD VG VS 
Mn1 VQD VQG VQS NMOS W=0.4u L=0.2u
*** Note you need to specify L here.

** dummy voltages
VID VD VQD 0V
VIG VG VQG 0V
VIS VQS VS 0V
.ends XNMOS

.subckt X_LPMOS VD VG VS 
Mn1 VQD VQG VQS PMOS W=0.8u L=0.2u
*** Note you need to specify L here.

** dummy voltagies
VID VD VQD 0V
VIG VG VQG 0V
VIS VQS VS 0V
.ends XPMOS

.subckt X_TG_PMOS VD VG VS 
Mn1 VQD VQG VQS PMOS W=0.4u L=0.2u
*** Note you need to specify L here.

** dummy voltagies
VID VD VQD 0V
VIG VG VQG 0V
VIS VQS VS 0V
.ends XPMOS

.subckt X_TG_NMOS VD VG VS 
Mn1 VQD VQG VQS NMOS W=0.4u L=0.2u
*** Note you need to specify L here.

** dummy voltagies
VID VD VQD 0V
VIG VG VQG 0V
VIS VQS VS 0V
.ends XPMOS

.end
