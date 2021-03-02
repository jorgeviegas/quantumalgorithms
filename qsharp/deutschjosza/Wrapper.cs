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

            Stopwatch stopWatch = new Stopwatch();
            stopWatch.Start();
            using var sim = new QuantumSimulator();

            var deutschJoszaResult = await RunDeutschJosza.Run(sim, 32);
            stopWatch.Stop();   
            TimeSpan ts = stopWatch.Elapsed;

            string elapsedTime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}",ts.Hours, ts.Minutes, ts.Seconds, ts.Milliseconds / 10);
            Console.WriteLine("RunTime " + elapsedTime);
        }
    }
}