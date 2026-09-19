module tb;

    reg [3:0] a, b;
    reg op;
    wire [3:0] result;
    reg [3:0] result_ideal;

    integer errors;

    alu dut (.a(a), .b(b), .op(op), .result(result));

    initial begin
        integer i, j, k;
        errors = 0;

        for (k = 0; k < 2; k = k + 1) begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    a = i[3:0]; 
                    b = j[3:0];
                    op = k[0];

                    #1; // allow combinational logic time to evaluate

                    result_ideal = op ? (a - b) : (a + b);

                    if (result !== result_ideal) begin
                        $display("Error in ALU output | a = %d, b = %d, op = %b | Ideal output: %b, Real output: %b", a, b, op, result_ideal, result);
                        errors = errors + 1;
                    end
                end
            end
        end

        $display("Error detection done, number of errors = %d", errors);
        $finish;
    end

endmodule