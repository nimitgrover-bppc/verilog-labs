module tb;

    reg [1:0] A, B;
    wire GT, LT, EQ;
    reg GT_ideal, LT_ideal, EQ_ideal;

    comp2 dut (.A(A), .B(B), .GT(GT), .LT(LT), .EQ(EQ));

    initial begin
        integer i, j;
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                A = i[1:0]; B = j[1:0];
                
                #1; // apparently needed so the combinational logic gets time to evalute

                GT_ideal = A > B;
                LT_ideal = A < B;
                EQ_ideal = A == B;

                if (GT !== GT_ideal) begin
                    $display("Error in Greater Than (GT) comparison | A = %d, B = %d | Ideal output: %b, Real output: %b", A, B, GT_ideal, GT);
                end
                if (LT !== LT_ideal) begin
                    $display("Error in Lesser Than (LT) comparison | A = %d, B = %d | Ideal output: %b, Real output: %b", A, B, LT_ideal, LT);
                end
                if (EQ !== EQ_ideal) begin
                    $display("Error in Equal To (EQ) comparison | A = %d, B = %d | Ideal output: %b, Real output: %b", A, B, EQ_ideal, EQ);
                end
            end
        end

        $display("Error detection done");
        $finish;
    end

endmodule