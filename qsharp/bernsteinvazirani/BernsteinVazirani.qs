namespace BernsteinVaziraniNamespace {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Convert;
    
    operation LearnParityViaFourierSampling(Uf : ((Qubit[], Qubit) => Unit), n : Int) : Bool[] {
        // Now, we allocate n + 1 clean qubits. Note that the function Uf is defined
        // on inputs of the form (x, y), where x has n bits and y has 1 bit.
        use queryRegister = Qubit[n];
        use target = Qubit();

        // The last qubit needs to be flipped so that the function will
        // actually be computed into the phase when Uf is applied.
        X(target);

        within {
            // Now, a Hadamard transform is applied to each of the qubits.
            // As the last step before the measurement, a Hadamard transform is
            // applied to all qubits except last one. We could apply the transform to
            // the last qubit also, but this would not affect the final outcome.
            // We use a within-apply block to ensure that the Hadmard transform is
            // correctly inverted.
            ApplyToEachA(H, queryRegister);
        } apply {
            H(target);
            // We now apply Uf to the n+1 qubits, computing |x, y〉 ↦ |x, y ⊕ f(x)〉.
            Uf(queryRegister, target);
        }

        // The following for-loop measures all qubits and resets them to
        // zero so that they can be safely returned at the end of the
        // using-block.
        let resultArray = ForEach(MResetZ, queryRegister);

        // The result is already contained in resultArray so no further
        // post-processing is necessary.
        Message($"measured: {resultArray}");

        // Finally, the last qubit, which held the y-register, is reset.
        Reset(target);
        return ResultArrayAsBoolArray(resultArray);
    }


    // To demonstrate the Bernstein–Vazirani algorithm, we define
    // a function which returns black-box operations (Qubit[] => ()) of
    // the form

    //    U_f |𝑥〉|𝑦〉 = |𝑥〉|𝑦 ⊕ 𝑓(𝑥)〉,

    // as described above.

    // In particular, we define 𝑓 by providing the pattern 𝑟⃗. Thus, we can
    // easily assert that the pattern measured by the Bernstein–Vazirani
    // algorithm matches the pattern we used to define 𝑓.

    // As is idiomatic in Q#, we define an operation that we will typically
    // only call by partially applying it from within a matching function.
    // To indicate that we are using this idiom, we name the operation
    // with an initial underscore to mark it as private, and provide
    // documentation comments for the function itself.
    internal operation ParityOperationImpl(pattern : Bool[], queryRegister : Qubit[], target : Qubit) : Unit {
        if (Length(queryRegister) != Length(pattern)) {
            fail "Length of input register must be equal to the pattern length.";
        }

        for (patternBit, controlQubit) in Zipped(pattern, queryRegister) {
            if (patternBit) {
                Controlled X([controlQubit], target);
            }
        }
    }


    /// # Summary
    /// Given a bitstring 𝑟⃗ = (r₀, …, rₙ₋₁), returns an operation implementing
    /// a unitary 𝑈 that acts on 𝑛 + 1 qubits as
    ///
    ///       𝑈 |𝑥〉|𝑦〉 = |𝑥〉|𝑦 ⊕ 𝑓(𝑥)〉,
    /// where 𝑓(𝑥) = Σᵢ 𝑥ᵢ 𝑟ᵢ mod 2.
    ///
    /// # Input
    /// ## pattern
    /// The bitstring 𝑟⃗ used to define the function 𝑓.
    ///
    /// # Output
    /// An operation implementing 𝑈.
    function ParityOperation(pattern : Bool[]) : ((Qubit[], Qubit) => Unit) {
        return ParityOperationImpl(pattern, _, _);
    }


    // For convenience, we provide an additional operation with a signature
    // that's easy to call from C#. In particular, we define our new operation
    // to take an Int as input and to return an Int as output, where each
    // Int represents a bitstring using the little endian convention.
    operation RunBernsteinVazirani (nQubits : Int, patternInt : Int) : Int {
        let pattern = IntAsBoolArray(patternInt, nQubits);
        Message($"pattern: {pattern}");

        let result = LearnParityViaFourierSampling(ParityOperation(pattern), nQubits);
        return BoolArrayAsInt(result);
    }
}
