# verilog2smtExample

## setup 
### Generate the verilog code 
* I used the code at [https://github.com/sifive/freedom]. 
You can git clone https://github.com/sifive/freedom under this directory and compile the verilog code using Makefile.vcu118-u500devkit

### Install yosys [http://www.clifford.at/yosys/download.html]

## Files in the repository
* sifive.freedom.unleashed.DevKitU500FPGADesign_WithDevKit50MHz.v: the verilog code including the DCache and IBuf modules
* *.smt2: smt2 formula generated from yosys-0.8 using the verilog code 
* *.ys: the yosys script used to generate smt2 formula

## Convert DCache Module to smt2 formula
`yosys dcache.ys`

* The data_array and tag_array are definded as |DCache_n tag_array_0[i]|, i=0,1,2, ...
* The initialization is defined by a function called DCache_i (state)
* The state transition is defined by a function called DCache_t (state, next_state)
* The variable used in submodule is defined in format of |DCache_n submodule.variable|
* Not all variables are defined in the formula.

## Convert IBuf Module to smt2 formula (a shorter smt2 file)
`yosys ibuf.ys`

## generate logical formula for multi-cycle execution
`yosys-smtbmc -t $2  --dump-smt2 $1-$2.smt2 $1.smt2`

If you use original yosys code, this command will call a solver to solve the formula. I modified its code to skip the solving and avoid the unnecessary assertions. 
