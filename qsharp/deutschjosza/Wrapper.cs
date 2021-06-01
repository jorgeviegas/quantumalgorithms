using System;
using System.Threading.Tasks;
using Microsoft.Quantum.Simulation.Simulators;
using DeutschJoszaNamespace;
using System.Diagnostics;

namespace wrapper
{
    static class Program
    {
        static async Task Main(string[] args)
        {

            using var sim = new QuantumSimulator();

            for (int numQubits = 29; numQubits < 31; numQubits++)
            {
                Stopwatch stopWatch = new Stopwatch();
                stopWatch.Restart(); 
                var deutschJoszaResult = await RunDeutschJosza.Run(sim, numQubits, 1);
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