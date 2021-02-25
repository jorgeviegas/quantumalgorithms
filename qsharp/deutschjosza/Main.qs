namespace deutschjosza {
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    @EntryPoint()
    operation Main() : Unit {
        let isBalanced = DeutschJosza(16, OracleNQubit);
        Message($"Algorithm is balanced: {isBalanced} ");

        let isBalanced2 = DeutschJosza(16, OracleAllZero);
        Message($"Algorithm is balanced: {isBalanced2} ");

        let isBalanced3 = DeutschJosza(16, OracleAllOne);
        Message($"Algorithm is balanced: {isBalanced2} ");
    }
}