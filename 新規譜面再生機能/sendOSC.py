import time

from pip._vendor.distlib.compat import raw_input
from pythonosc import osc_message_builder
from pythonosc import udp_client

sender = udp_client.SimpleUDPClient('192.168.0.9', 4559)
# sender = udp_client.SimpleUDPClient('255.255.255.255')
# sender = udp_client.SimpleUDPClient('192.168.56.1', 4559)
# sender = udp_client.SimpleUDPClient('127.0.0.1', 4559)

data = 0
while True:
    input_test_word = raw_input('')
    # time.sleep(0.5)

    sender.send_message('/command', [data, 0])
    data+=1
    print(data)

# print(str(nnn['pitch']))
# print('a')
