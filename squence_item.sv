package sequence_item_pkg;//we will wait for the constraints
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  class dsp_seq_item extends uvm_sequence_item;
    `uvm_object_utils(dsp_seq_item);

    localparam Max_18 = 18'b1111_1111_1111_11;
    localparam Max_48 = 48'b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111;
    bit valid_test;
    rand bit [17:0] A;
    rand bit [17:0] B;
    rand bit [47:0] C;
    rand bit [17:0] D;
    rand bit CARRYIN;
    rand bit [7:0] OPMODE;
    rand bit [17:0] BCIN;
    rand bit RSTA;
    rand bit RSTB;
    rand bit RSTM;
    rand bit RSTP;
    rand bit RSTC;
    rand bit RSTD;
    rand bit RSTCARRYIN;
    rand bit RSTOPMODE;
    rand bit CEA;
    rand bit CEB;
    rand bit CEM;
    rand bit CEP;
    rand bit CEC;
    rand bit CED;
    rand bit CECARRYIN;
    rand bit CEOPMODE;
    rand bit [47:0] PCIN;
    rand bit x;
    bit [17:0] BCOUT;
    bit [47:0] PCOUT;
    bit [47:0] P;
    bit [35:0] M;
    bit CARRYOUT;
    bit CARRYOUTF;
    constraint reset {
      RSTA dist {1:=1, 0:=99};
      RSTB dist {1:=1, 0:=99};
      RSTC dist {1:=1, 0:=99};
      RSTCARRYIN dist {1:=1, 0:=99};
      RSTD dist {1:=1, 0:=99};
      RSTM dist {1:=1, 0:=99};
      RSTOPMODE dist {1:=1, 0:=99};
      RSTP dist {1:=1, 0:=99};
    }
constraint enables{

      CEA dist {1:=99,0:=1};
      CEB dist {1:=99,0:=1};
      CEM dist {1:=99,0:=1};
      CEP dist {1:=99,0:=1};
      CEC  dist {1:=99,0:=1};
      CED dist {1:=99,0:=1};
      CECARRYIN dist {1:=99,0:=1};
      CEOPMODE dist {1:=99,0:=1};
}
   constraint combinational {

OPMODE[1:0] inside {0,1,3};
OPMODE[3:2] inside {0,1,3};
    }
    function string convert2string();
    return $sformatf("%s M=%0h Pcout=%0h BCOUT=%0h p=%0h carryout=%0h carryoutf=%0h ",super.convert2string(),M,PCOUT,BCOUT,P,CARRYOUT,CARRYOUTF);  
    endfunction
   /* function string convert_to_string();
return $sformat("%s A=%0h B=%0h C=%0h D=%0h carryin=%0h opmode=%0b ",super.convert2string(),A,B,C,D,CARRYIN,OPMODE)
    endfunction*/
  endclass
endpackage
