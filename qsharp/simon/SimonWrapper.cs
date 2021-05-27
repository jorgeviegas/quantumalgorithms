using System;
using System.Threading.Tasks;
using Microsoft.Quantum.Simulation.Simulators;
using simon;
using System.Diagnostics;

namespace wrapper
{
    static class Program
    {
        static async Task Main(string[] args)
        {

            using var sim = new QuantumSimulator();

            for (int numQubits = 3; numQubits < 32; numQubits++)
            {
                Stopwatch stopWatch = new Stopwatch();
                stopWatch.Restart(); 
                var simonResult = await Simon_Algorithm_Reference.Run(sim, numQubits);
                stopWatch.Stop();   
                TimeSpan ts = stopWatch.Elapsed;

                string elapsedTime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}",ts.Hours, ts.Minutes, ts.Seconds, ts.Milliseconds / 10);
                Console.WriteLine("Qubits: " + numQubits);
                Console.WriteLine("RunTime: " + elapsedTime);
            }
        }
    }
}