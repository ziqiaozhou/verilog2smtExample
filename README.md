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

* The array is unrolled due to the command "memory". (e.g., tag_array_0 are definded as \|DCache_n tag_array_0[i]\|, i=0,1,2, ..., 63)
* The initialization is defined by a function called DCache_i (state)
* The state transition is defined by a function called DCache_t (state, next_state)
* The variable used in submodule is defined in format of \|DCache_n submodule.variable\| (e.g.  \|DCache_n data.data_arrays_0_3[223]\|)

## Convert IBuf Module to smt2 formula (a shorter smt2 file)
`yosys ibuf.ys`

## Others
If your target module is others, you can replace DCache with RocketTile in *dcache.ys*

## generate logical formula for multi-cycle execution
`yosys-smtbmc -t $2  --dump-smt2 $1-$2.smt2 $1.smt2`
dcache-20.smt2 is the formula corresponding to 20 cycles. s0 -> initial state, s1, s2, ..., s19

