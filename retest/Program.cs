using System;

namespace retest
{
    class Program
    {
        static void Main(string[] args)
        {
            int port = 53131;
            new ReceiveTest(port);
        }
    }
}
