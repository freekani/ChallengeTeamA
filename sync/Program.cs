using System;
using System.Net.Sockets;
using System.Text;

namespace sync
{
    class Program
    {
        static void Main(string[] args)
        {
            //データを送信するリモートホストとポート番号
            string remoteHost = "127.0.0.1";
            int remotePort = 2222;

            //UdpClientオブジェクトを作成する
            UdpClient udp = new UdpClient();

            for (; ; )
            {
                //送信するデータを作成する
                Console.WriteLine("データ送信");
                string sendMsg = Console.ReadLine();
                byte[] sendBytes = Encoding.UTF8.GetBytes(sendMsg);

                //リモートホストを指定してデータを送信する
                udp.Send(sendBytes, sendBytes.Length, remoteHost, remotePort);

                //"exit"と入力されたら終了
                if (sendMsg.Equals("exit"))
                {
                    break;
                }
            }

            //UdpClientを閉じる
            udp.Close();

            Console.WriteLine("終了しました。");
        }
    }
}
