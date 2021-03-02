namespace DeutschJoszaNamespace {
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation RunDeutschJosza(numQubits : Int) : Unit {
        
        let isBalanced = DeutschJosza(numQubits, OracleNQubit);
        Message($"Algorithm is balanced: {isBalanced} ");

        let isBalanced2 = DeutschJosza(numQubits, OracleAllZero);
        Message($"Algorithm is balanced: {isBalanced2} ");

        let isBalanced3 = DeutschJosza(numQubits, OracleAllOne);
        Message($"Algorithm is balanced: {isBalanced2} ");
    }
}