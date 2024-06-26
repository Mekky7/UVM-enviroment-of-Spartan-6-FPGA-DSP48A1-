
package dsp_test_pkg;
import uvm_pkg::*;
import squence_pkg::*;
import dsp_config_pkg::*;
import shared_pkg::*;
`include "uvm_macros.svh"
import dsp_env_pkg::*;
class dsp_test extends uvm_test;
  `uvm_component_utils(dsp_test);
dsp_env env;
dsp_main_sequence dsp_seq;
dsp_comb_sequence dsp_comb_seq;
reset_seq rst_seq; 
dsp_config dsp_cfg;
virtual dsp_if dspif;
  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dsp_env::type_id::create("env", this);
    dsp_cfg=dsp_config::type_id::create("dsp_cfg",this);
    dsp_seq=dsp_main_sequence::type_id::create("dsp_seq",this);
    dsp_comb_seq=dsp_comb_sequence::type_id::create("dsp_comb_seq",this);
    rst_seq=reset_seq::type_id::create("rst_seq",this);
    if(!uvm_config_db #(virtual dsp_if)::get(this,"","dsp_IF",dsp_cfg.dspif))
    `uvm_fatal("build_phase","test -unable to get the virtual interface of dsp from uvm_config_db");
    uvm_config_db#(dsp_config)::set(this,"*","CFG",dsp_cfg);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    `uvm_info("run_phase","reset_asserted", UVM_LOW);
    rst_seq.start(env.agt.sqr);
   `uvm_info("run_phase", "reset_deasserted", UVM_LOW);
  `uvm_info("run_phase", "stimulus_generation_started (for pipelined configeration) ", UVM_LOW);
  dsp_seq.start(env.agt.sqr);
  `uvm_info("run_phase","stimulus generation finished (for pipelined configeration) ", UVM_LOW);
  shared_pkg::parameter_comb=1;
  `uvm_info("run_phase", "stimulus_generation_started (for combinational configeration) ", UVM_LOW);
  dsp_comb_seq.start(env.agt.sqr);
  `uvm_info("run_phase","stimulus generation finished (for combinational configeration) ", UVM_LOW);
    phase.drop_objection(this);

  endtask
endclass
endpackage
