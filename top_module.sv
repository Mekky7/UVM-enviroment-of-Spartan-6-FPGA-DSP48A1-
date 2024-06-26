import dsp_test_pkg::*;
import uvm_pkg::*;
import dsp_config_pkg::*;
import shared_pkg::*;
`include "uvm_macros.svh"

module top();
    bit clk;
    
    // Clock generation
    initial begin
        clk = 0;
        forever #1 clk = !clk;
    end   

    // Declare the interface
    dsp_if dspif(clk);

    // Instantiate the DSP module
    dsp  dut (
 .CARRYOUTREG(!shared_pkg::parameter_comb),
        .CARRYINREG(!shared_pkg::parameter_comb),
        .OPMODEREG(!shared_pkg::parameter_comb),
        .A0REG(!shared_pkg::parameter_comb),
        .A1REG(!shared_pkg::parameter_comb),
        .B0REG(!shared_pkg::parameter_comb),
        .B1REG(!shared_pkg::parameter_comb),
        .CREG(!shared_pkg::parameter_comb),
        .DREG(!shared_pkg::parameter_comb),
        .MREG(!shared_pkg::parameter_comb),
        .PREG(1),     
        .CEP(dspif.CEP), .RSTP(dspif.RSTP), .CARRYOUT(dspif.CARRYOUT), .CARRYOUTF(dspif.CARRYOUTF),
        .M(dspif.M), .P(dspif.P), .RSTCARRYIN(dspif.RSTCARRYIN), .BCOUT(dspif.BCOUT), .CECARRYIN(dspif.CECARRYIN),
        .PCIN(dspif.PCIN), .PCOUT(dspif.PCOUT), .CARRYIN(dspif.CARRYIN), .RSTM(dspif.RSTM), .CEM(dspif.CEM),
        .OPMODE(dspif.OPMODE), .CEOPMODE(dspif.CEOPMODE), .RSTOPMODE(dspif.RSTOPMODE), .A(dspif.A), .B(dspif.B),
        .C(dspif.C), .D(dspif.D), .BCIN(dspif.BCIN), .CLK(dspif.clk), .RSTA(dspif.RSTA), .RSTB(dspif.RSTB),
        .RSTC(dspif.RSTC), .RSTD(dspif.RSTD), .CEA(dspif.CEA), .CEB(dspif.CEB), .CEC(dspif.CEC), .CED(dspif.CED)
    );

    initial begin
        // Set the virtual interface
        uvm_config_db#(virtual dsp_if)::set(null, "uvm_test_top", "dsp_IF", dspif);
        // Run the test
        run_test("dsp_test");
    end
endmodule
