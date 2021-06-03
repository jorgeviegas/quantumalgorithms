using System;
using System.Threading.Tasks;
using Microsoft.Quantum.Simulation.Simulators;
using shor;
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
                var deutschJoszaResult = await QuantumPeriodFinding.Run(sim, 15, 8);
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