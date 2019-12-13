# -*- coding: utf-8 -*-
import random
import time
from pythonosc import udp_client
from pythonosc.osc_message_builder import OscMessageBuilder

IP = '127.0.0.1'
PORT = 4559

def SendBPM(BPM):
	if BPM.isdecimal():
		BPM=int(BPM)
		if 0<BPM<=960:
			msg = OscMessageBuilder(address='/BPM')
			msg.add_arg(int(BPM))
			m = msg.build()
			print(m.address, m.params)
			client.send(m)
		else:
			print("error: 0<BPM<=960");
	else:
		print ("error:Please enter the correct value")
	
def SendTEMPO():
	msg = OscMessageBuilder(address='/TEMPO')
	msg.add_arg(command)
	m = msg.build()
	print(m.address, m.params)
	client.send(m)


# UDPのクライアントを作る
client = udp_client.UDPClient(IP, PORT)


while 1:
	print ("Please enter:")
	command=input().split()
	#SendBPM
	if len(command)!=0:
		if command[0]=="BPM" or command[0]=="bpm":
			SendBPM(command[1])
	#SendTEMPO
	else:
		SendTEMPO()

