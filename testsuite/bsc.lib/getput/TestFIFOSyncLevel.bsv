
import GetPut:: *;
import FIFOLevel :: *;
import Connectable :: * ;

(* synthesize *)
module sysTestFIFOSyncLevel ();

   let clk <- exposeCurrentClock ;
   let rst <- exposeCurrentReset ;

   SyncFIFOLevelIfc#(int, 4)  inf <- mkSyncFIFOLevel( clk, rst, clk ) ;
   FIFOLevelIfc#(int, 12)  outf <- mkFIFOLevel ;

   Reg#(Bit#(10)) c <- mkReg(0);
   Reg#(int) d <- mkReg(0);

   rule cnt ;
      c <= c + 1;
      if (c > 50) $finish(0);
   endrule

   rule inr (c[0:0] == 0 && inf.sIsLessThan(3)) ;
      inf.enq(d);
      d <= d + 1 ;
   endrule

   rule outr (c[2:0] <= 3);
      outf.deq;
      $display( "%d: got data: %d", c, outf.first);
   endrule

   let gf = toGet (inf);
   let pf = toPut (outf);
   mkConnection( gf, pf);

endmodule
