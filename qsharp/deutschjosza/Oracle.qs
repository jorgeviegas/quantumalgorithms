namespace DeutschJoszaNamespace {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;


    operation OracleAllZero (inputQubits : Qubit[], yQubit : Qubit) : Unit {

    }

    operation OracleAllOne (inputQubits : Qubit[], yQubit : Qubit) : Unit {
        ApplyToEach(X, inputQubits);
    }

    operation OracleNQubit (inputQubits : Qubit[], yQubit : Qubit) : Unit {
       CNOT(inputQubits[2], yQubit);
    }
}
