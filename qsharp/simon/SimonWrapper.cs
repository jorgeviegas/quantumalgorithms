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

            for (int numQubits = 15; numQubits < 18; numQubits++)
            {
                Stopwatch stopWatch = new Stopwatch();
                stopWatch.Restart(); 
                var simonResult = await Simon_Algorithm_Reference.Run(sim, numQubits);
                stopWatch.Stop();   

                long ms = stopWatch.ElapsedMilliseconds;
                float seconds = Convert.ToSingle(ms);
                seconds = seconds / 1000;
                
                Console.WriteLine(seconds.ToString().Replace(".", ","));
            }
        }
    }
}