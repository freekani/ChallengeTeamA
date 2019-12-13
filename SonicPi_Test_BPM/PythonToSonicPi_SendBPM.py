# -*- coding: utf-8 -*-
import random
import time
from pythonosc import udp_client
from pythonosc.osc_message_builder import OscMessageBuilder

IP = '127.0.0.1'
PORT = 4559

# UDPのクライアントを作る
client = udp_client.UDPClient(IP, PORT)


while 1:
	print ("Please enter the BPM:")
	BPM=input()
	if BPM.isdecimal():
		BPM=int(BPM)
		if 0<BPM<=300:
			msg = OscMessageBuilder(address='/BPM')
			msg.add_arg(int(BPM))
			m = msg.build()
			print(m.address, m.params)
			client.send(m)
		else:
			print("error: 0<BPM<=300");
	else:
		print ("error:Please enter the correct value")
