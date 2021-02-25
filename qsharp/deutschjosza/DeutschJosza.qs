namespace deutschjosza {
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation DeutschJosza(numberOfQubits : Int, oracleOperation : ((Qubit[], Qubit) => Unit)) : Bool {

        mutable isBalanced = false;
        use yQubit = Qubit();
        use register = Qubit[numberOfQubits];

        ApplyToEach(H, register);

        X(yQubit);
        H(yQubit);

        oracleOperation(register, yQubit);

        ApplyToEach(H, register);   

        mutable qubitIndex = 0;

        for qubit in register {
            Message($"Qubit number {qubitIndex}");
            let result = MResetZ(qubit);
            if IsResultOne(result){
                set isBalanced = true;
            }
            set qubitIndex = qubitIndex + 1;
            Message($"Qubit result {isBalanced}");
        } 

        ResetAll(register);
        Reset(yQubit);
              
        return isBalanced;

    }

}