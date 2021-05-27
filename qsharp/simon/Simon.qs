namespace simon {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation Oracle_CountBits_Reference (x : Qubit[], y : Qubit) : Unit is Adj {
        for q in x {
            CNOT(q, y);
        }
    }
    
    // Task 1.2. Bitwise right shift
    operation Oracle_BitwiseRightShift_Reference (x : Qubit[], y : Qubit[]) : Unit is Adj {
        
        let N = Length(x);

        for i in 1 .. N - 1 {
            CNOT(x[i - 1], y[i]);
        }
    }
    

    // Task 1.3. Linear operator
    operation Oracle_OperatorOutput_Reference (x : Qubit[], y : Qubit, A : Int[]) : Unit is Adj {
        
        let N = Length(x);
            
        for i in 0 .. N - 1 {
            if (A[i] == 1) {
                CNOT(x[i], y);
            }
        }
    }

    //////////////////////////////////////////////////////////////////
    // Part II. Simon's Algorithm
    //////////////////////////////////////////////////////////////////
    
    // Task 2.1. State preparation for Simon's algorithm
    operation SA_StatePrep_Reference (query : Qubit[]) : Unit is Adj {        
        ApplyToEachA(H, query);
    }
    
    // Task 2.2. Quantum part of Simon's algorithm
    operation Simon_Algorithm_Reference (nQubits : Int) : Int[] {
                
        // allocate input and answer registers with N qubits each
        use (x, y) = (Qubit[nQubits], Qubit[nQubits]);
        // prepare qubits in the right state
        SA_StatePrep_Reference(x);
            
        // apply oracle
        Oracle_BitwiseRightShift_Reference(x, y);
            
        // apply Hadamard to each qubit of the input register
        ApplyToEach(H, x);
            
        // measure all qubits of the input register;
        // the result of each measurement is converted to an Int
        mutable j = new Int[nQubits];
        for i in 0 .. nQubits - 1 {
            if (M(x[i]) == One) {
                set j w/= i <- 1;
            }
        }
            
        // since y has not been measured, we reset y qubits
        ResetAll(y);
        return j;
    }
}
