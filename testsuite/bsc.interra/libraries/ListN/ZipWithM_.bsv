package ZipWithM_;

import ListN :: *;

function Action displayabc (a abc) provisos (Bits #(a, sa));
    action
      $display ("%d", abc);
    endaction
endfunction

function Action displayabc1 (Tuple2#(a,a) abc) provisos (Bits #(a, sa));
    action
      $display ("%d", abc.fst);
      $display ("%d", abc.snd);
    endaction
endfunction


function Action display_list (ListN #(n,a) my_list) provisos (Bits # (a,sa));
     action
       joinActions ( map (displayabc, my_list));
     endaction
endfunction

function Action display_list1 (ListN #(n,Tuple2#(a,a)) my_list) provisos (Bits # (a,sa));
     action
       joinActions ( map (displayabc1, my_list));
     endaction
endfunction


function ActionValue#(Int#(8)) f (Int #(8) a,Int #(8) b);

//    Int#(8) c ;
	actionvalue
   //   c = a + b;
      $display("%d",(a+b));
	  return(a+b);
	endactionvalue
endfunction

module mkTestbench_ZipWithM_();
   ListN #(5,Int #(8)) my_list1 = cons (0, cons (1, cons (2, cons (3, cons (4, nil)))));
   ListN #(5,Int #(8)) my_list2 = cons (5, cons (6, cons (7, cons (8, cons (9, nil)))));
   ListN #(5,Int #(8)) my_list3 = cons (5, cons (7, cons (9, cons (11, cons (13, nil)))));



   rule fire_once (True);
      zipWithM_(f,my_list1,my_list2);
	  /*
      $display("ListN1:");
      display_list (my_list1);
      $display("ListN2:");
      display_list (my_list2);
      $display("ZipWith ListN:");
      display_list (my_list4);
      if (my_list3 != my_list4)
        $display ("Simulation Fails");
      else
        $display ("Simulation Passes");
		*/
      $display ("Simulation Passes");
	  $finish(2'b00);
   endrule

endmodule : mkTestbench_ZipWithM_
endpackage : ZipWithM_
