import socket
from psonic import *

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

s.bind(('', 53131))
while True:
     data, addr = s.recvfrom(1024)
     print("data: {}, addr: {}".format(data, addr))
     play(70)

s.close()
