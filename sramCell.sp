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
.ic X_cell.q = 0 X_cell.qBar = Vdd wordLine = 0 bBarLine = 0

.tran 0.001n 10n
Vsupply Vd gnd Vdd
*Vs_to_groung Vs 0 0
*VwordLine wordLine gnd PULSE (0 Vdd 1n 0.01n 0.01n 8n 20n)
*Vwrite    bBarLine gnd PULSE (Vdd 0 2n 0.01n 0.01n 4n 20n)


* simulation output *
.probe v(X_cell.q) v(X_cell.qBar) v(bLine) v(bBarLine) v(wordLine)
.options acct post probe

* circuit *
* a single cell *

* test inverter
*X_cell wordLine bLine bBarLine Vd Vs X_SRAM_cell
X_cell Vs Vs Vs Vd Vs X_SRAM_cell $ attempt to make null cell


******************** subcircuits *************************

***  sram cell  ***
.subckt X_SRAM_cell wordLine bLine bBarLine nVdd nVss
X_M3 b    wordLine q    X_M34_NMOS 
XInvLeft  qBar q    nVdd nVss X_inv_cell
XInvRight q    qBar nVdd nVss X_inv_cell
X_M4 bBar wordLine qBar X_M34_NMOS
.ends

* inverter for SRAM cell*
.subckt X_inv_cell nIn nOut nVdd nVss
XM56 nOut nIn nVdd X_M56_PMOS
XM12 nOut nIn nVss X_M12_NMOS
.ends

* M3 and M4 of SRAM cell
.subckt X_M34_NMOS VD VG VS
Mn1 VQD VQG VQS NMOS W=0.2u L=0.18u
*** Note you need to specify L here.

* dummy voltages
VID VD VQD 0V
VIG VG VQG 0V
VIS VQS VS 0V
.ends

* M1 and M2 of SRAM cell
.subckt X_M12_NMOS VD VG VS 
Mn1 VQD VQG VQS NMOS W=0.2u L=0.18u
*** Note you need to specify L here.

* dummy voltages
VID VD VQD 0V
VIG VG VQG 0V
VIS VQS VS 0V
.ends

* M5 and M6 of SRAM cell
.subckt X_M56_PMOS VD VG VS 
Mn1 VQD VQG VQS PMOS W=0.4u L=0.18u
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
.ends

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
.ends XNMOS

.end
