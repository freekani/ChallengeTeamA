# -*- coding: utf-8 -*-
#!/usr/bin/python

# http://www.neko.ne.jp/~freewing/raspberry_pi/
# Copyright (c)2016 FREE WING, Y.Sakamoto

import RPi.GPIO as GPIO
import os
import smbus
import time

# MPU6050 Class
class MPU6050():
	DevAdr = 0x68
	myBus = ""
	if GPIO.RPI_INFO['P1_REVISION'] == 1:
		myBus = 0
	else:
		myBus = 1
	b = smbus.SMBus(myBus)

	def setUp(self):
		self.b.write_byte_data(self.DevAdr, 0x6B, 0x80) # RESET
		time.sleep(0.25)
		self.b.write_byte_data(self.DevAdr, 0x6B, 0x00) # RESET
		time.sleep(0.25)
		self.b.write_byte_data(self.DevAdr, 0x6A, 0x07) # RESET
		time.sleep(0.25)
		self.b.write_byte_data(self.DevAdr, 0x6A, 0x00) # RESET
		time.sleep(0.25)
		self.b.write_byte_data(self.DevAdr, 0x1A, 0x00) # CONFIG
		self.b.write_byte_data(self.DevAdr, 0x1B, 0x18) # +-2000/s
		self.b.write_byte_data(self.DevAdr, 0x1C, 0x10) # +-8g

	def getValueGX(self):
		#self.b.write_byte(self.DevAdr, 0x43) #
		return self.getValue(0x43)

	def getValueGY(self):
		return self.getValue(0x45)

	def getValueGZ(self):
		return self.getValue(0x47)

	def getValueAX(self):
		#self.b.write_byte(self.DevAdr, 0x3B) #
		return self.getValue(0x3B)

	def getValueAY(self):
		return self.getValue(0x3D)

	def getValueAZ(self):
		return self.getValue(0x3F)

	def getValueTemp(self):
		val = self.getValue(0x41)
		return (val/340.00+36.53)

	def getValue(self, adr):
		tmp = self.b.read_byte_data(self.DevAdr, adr)
		sign = tmp & 0x80
		tmp = tmp & 0x7F
		tmp = tmp<<8
		tmp = tmp | self.b.read_byte_data(self.DevAdr, adr+1)
		print '%4x' % tmp # debug

		if sign > 0:
			tmp = tmp - 32768

		return tmp

#	tmp = self.b.read_word_data(self.DevAdr, adr)

# MAIN
myMPU6050 = MPU6050()
myMPU6050.setUp()

# LOOP
for a in range(1000):
	os.system("clear")
	gx = myMPU6050.getValueGX()
	gy = myMPU6050.getValueGY()
	gz = myMPU6050.getValueGZ()
	ax = myMPU6050.getValueAX()
	ay = myMPU6050.getValueAY()
	az = myMPU6050.getValueAZ()
	t = myMPU6050.getValueTemp()
	print 'Gyro X= %6d' % gx
	print 'Gyro Y= %6d' % gy
	print 'Gyro Z= %6d' % gz
	print 'Acc. X= %6d' % ax
	print 'Acc. Y= %6d' % ay
	print 'Acc. Z= %6d' % az
	print 'Temp. = %6.2f' % t
	time.sleep(0.5)

