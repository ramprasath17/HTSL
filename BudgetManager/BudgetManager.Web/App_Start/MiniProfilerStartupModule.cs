using StackExchange.Profiling;
using System.Web;
public class MiniProfilerStartupModule : IHttpModule
{
    public void Init(HttpApplication context)
    {
        context.BeginRequest += (sender, e) =>
        {
            var request = ((HttpApplication)sender).Request;
            if (request.IsLocal) { MiniProfiler.Start(); }
        };

        context.EndRequest += (sender, e) =>
        {
            MiniProfiler.Stop();
        };
    }

    public void Dispose() { }
}
