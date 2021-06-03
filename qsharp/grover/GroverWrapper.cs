using System;
using System.Threading.Tasks;
using Microsoft.Quantum.Simulation.Simulators;
using Grover;
using System.Diagnostics;

namespace wrapper
{
    static class Program
    {
        static async Task Main(string[] args)
        {

            using var sim = new QuantumSimulator();

            for (int numQubits = 1; numQubits < 44; numQubits++)
            {
                Stopwatch stopWatch = new Stopwatch();
                stopWatch.Restart(); 
                var deutschJoszaResult = await GroverAlgorithm.Run(sim, 3, 12, 3);
                stopWatch.Stop();   
                TimeSpan ts = stopWatch.Elapsed;


                long ms = stopWatch.ElapsedMilliseconds;
                float seconds = Convert.ToSingle(ms);
                seconds = seconds / 1000;
                
                Console.WriteLine(seconds.ToString().Replace(".", ","));
            }
        }
    }
}