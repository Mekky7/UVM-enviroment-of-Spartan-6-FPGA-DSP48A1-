package agent_pkg;
`include "uvm_macros.svh"
import uvm_pkg::*;
import squencer_pkg::*;
import dsp_config_pkg::*;
import monitor_pkg::*;
import sequence_item_pkg:: * ;
import dsp_driver_pkg::*;
class dsp_agent extends uvm_agent;
`uvm_component_utils(dsp_agent)
dsp_driver driver;
dsp_monitor mon;
 dsp_squencer sqr;
dsp_config dsp_cfg;
uvm_analysis_port #(dsp_seq_item) agt_ap;
function  new(string name ="dsp_agent",uvm_component parent =null);
    super.new(name,parent);
    agt_ap=new("agt_ap",this);
endfunction
function void build_phase(uvm_phase phase);
super.build_phase(phase);
    if(!uvm_config_db#(dsp_config)::get(this,"","CFG",dsp_cfg))
    `uvm_fatal("build_phase","unable to get gonfigration object")
    driver=dsp_driver::type_id::create("driver",this);
    sqr=dsp_squencer::type_id::create("sqr",this);
    mon=dsp_monitor::type_id::create("mon",this);
endfunction


function void connect_phase(uvm_phase phase);
    driver.dspif=dsp_cfg.dspif;
    mon.dspif=dsp_cfg.dspif;
    driver.seq_item_port.connect(sqr.seq_item_export); 
    mon.mon_ap.connect(agt_ap) ;
endfunction
endclass
endpackage