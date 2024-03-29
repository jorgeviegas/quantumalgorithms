using System;
using System.Threading.Tasks;
using Microsoft.Quantum.Simulation.Simulators;
using BernsteinVaziraniNamespace;
using System.Diagnostics;

namespace wrapper
{
    static class Program
    {
        static async Task Main(string[] args)
        {

            using var sim = new QuantumSimulator();

            for (int numQubits = 28; numQubits < 30; numQubits++)
            {
                Stopwatch stopWatch = new Stopwatch();
                stopWatch.Restart(); 
                var deutschJoszaResult = await RunBernsteinVazirani.Run(sim, numQubits, numQubits);
                stopWatch.Stop();   

                long ms = stopWatch.ElapsedMilliseconds;
                float seconds = Convert.ToSingle(ms);
                seconds = seconds / 1000;
                
                Console.WriteLine(seconds.ToString().Replace(".", ","));

            }
        }
    }
}