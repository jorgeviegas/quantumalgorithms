namespace Grover {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Preparation;
    open Microsoft.Quantum.Diagnostics;

   operation GroverAlgorithm(markIndex : Int, numberOfQubits : Int, iterations : Int) : Int {
        use qubits = Qubit[numberOfQubits];
        let register = LittleEndian(qubits);

        // superposition
        ApplyToEachA(H, qubits);
        //DumpMachine();

        for x in 1..iterations {
            // mark the required number
            ReflectAboutInteger(markIndex, register);

            // amplitude amplification
            AmplifyAmplitude(qubits);
        }

        let number = MeasureInteger(register);
        ResetAll(qubits);

        return number;
    } 

    operation AmplifyAmplitude(qubits : Qubit[]) : Unit is Adj {
        within {
            ApplyToEachA(H, qubits);
            ApplyToEachA(X, qubits);
        } apply {
            Controlled Z(Most(qubits), Tail(qubits));
        }
    }    
}