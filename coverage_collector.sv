package coverage_collector;
import uvm_pkg::*;
import sequence_item_pkg::*;
`include "uvm_macros.svh"

class dsp_coverage extends uvm_component;
    `uvm_component_utils(dsp_coverage)
    uvm_analysis_export #(dsp_seq_item) cov_export;
    uvm_tlm_analysis_fifo #(dsp_seq_item) cov_fifo;
    dsp_seq_item seq_item_cov;

    covergroup dsp_coverage;
    A_cp:coverpoint seq_item_cov.A;
    B_cp:coverpoint seq_item_cov.B;
    C_cp:coverpoint seq_item_cov.C;
    D_cp:coverpoint seq_item_cov.D;
    OPMODE_cp: coverpoint seq_item_cov.OPMODE;
    CARRYIN_cp:coverpoint seq_item_cov.CARRYIN;
    BCIN_cp: coverpoint seq_item_cov.BCIN;
    RSTA_cp: coverpoint seq_item_cov.RSTA;
    RSTB_cp: coverpoint seq_item_cov.RSTB;
    RSTM_cp: coverpoint seq_item_cov.RSTM;
    RSTP_cp: coverpoint seq_item_cov.RSTP;
    RSTC_cp: coverpoint seq_item_cov.RSTC;
    RSTD_cp: coverpoint seq_item_cov.RSTD;
    RSTCARRYIN_cp: coverpoint seq_item_cov.RSTCARRYIN;
    RSTOPMODE_cp: coverpoint seq_item_cov.RSTOPMODE;
    CEA_cp: coverpoint seq_item_cov.CEA;
    CEB_cp: coverpoint seq_item_cov.CEB;
    CEM_cp: coverpoint seq_item_cov.CEM;
    CEP_cp: coverpoint seq_item_cov.CEP;
    CED_cp: coverpoint seq_item_cov.CED;
    CEC_cp: coverpoint seq_item_cov.CEC;
    CECARRYIN_cp: coverpoint seq_item_cov.CECARRYIN;
    CEOPMODE_cp: coverpoint seq_item_cov.CEOPMODE;
    PCIN_cp: coverpoint seq_item_cov.PCIN;
    cross CEA_cp,RSTA_cp;
    cross CEB_cp, RSTB_cp;
    cross CEC_cp, RSTC_cp;
    cross CECARRYIN_cp, RSTCARRYIN_cp;
    cross CED_cp, RSTD_cp;
    cross CEM_cp, RSTM_cp;
    cross CEOPMODE_cp, RSTOPMODE_cp;
    cross CEP_cp, RSTP_cp;
    endgroup

    function  new(string name ="dsp_coverage",uvm_component parent =null);
        super.new(name,parent);
        dsp_coverage=new;
    endfunction
    
    function void build_phase( uvm_phase phase);
        super.build_phase(phase);
        cov_export=new("cov_export",this);
        cov_fifo=new("cov_fifo",this); 
    endfunction
function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
cov_export.connect(cov_fifo.analysis_export);    
endfunction
task run_phase(uvm_phase phase);
super.run_phase(phase);
forever
begin
    cov_fifo.get(seq_item_cov);
    dsp_coverage.sample();
end   
endtask
endclass
endpackage