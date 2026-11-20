# code for test_randomize.sv
  ...
     module test_random;


        // In class alu_trans_c
        class alu_trans_c;

                // Declare a typedef variable OPERATION of type enum with LOGIC, ARITH and SHIFT as the values
                typedef enum {LOGIC,ARITH,SHIFT}OPERATION;

                // Add the following rand fields
                // alu_sel_in ( logic type, size 4)
                // rand_oper ( OPERATION type)
                rand logic[3:0] alu_sel_in;
                rand OPERATION rand_oper;

                // Apply following constraints
                // If rand_oper = LOGIC then alu_sel_in should be inside [0:5]
                // If rand_oper = ARITH, then alu_sel_in should be inside [6:9]
                // If rand_oper = SHIFT, then alu_sel_in should be inside [10:15]
                // Give weightage of 2 to ARITH operation

                /*constraint P1{rand_oper==LOGIC -> alu_sel_in inside{[0:5]};
                              rand_oper==ARITH -> alu_sel_in inside{[6:9]};
                              rand_oper==SHIFT -> alu_sel_in inside{[10:15]};}*/
                constraint P1{if(rand_oper==LOGIC) alu_sel_in inside{[0:5]};
                                else if(rand_oper==ARITH) alu_sel_in inside{[6:9]};
                                else alu_sel_in inside{[10:15]};}

                constraint P2{rand_oper dist{LOGIC:=1,ARITH:=2,SHIFT:=1};}

                // In post_randomize method ,display all the randomized values
                function void post_randomize();
                        $display("Randomized value is %0d for %s",alu_sel_in,rand_oper.name);
                endfunction: post_randomize
        endclass:alu_trans_c
        // Within initial
                // Create an instance of alu_trans_c
                // Generate 10 set of random values for the instance alu_trans_c
        initial
        begin
                alu_trans_c alu=new();
                repeat(10)
                begin
                        assert(alu.randomize());
                end
        end


endmodule
...
