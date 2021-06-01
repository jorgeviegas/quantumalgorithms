namespace DeutschJoszaNamespace {
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation RunDeutschJosza(numQubits : Int, oracleId : Int) : Unit {

        if(oracleId == 1){
            let isBalanced = DeutschJosza(numQubits, OracleNQubit);
        } elif (oracleId == 2) {
            let isBalanced2 = DeutschJosza(numQubits, OracleAllZero);
        } elif (oracleId == 3) {
            let isBalanced3 = DeutschJosza(numQubits, OracleAllOne);
        }
    }
}