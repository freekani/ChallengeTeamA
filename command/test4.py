# -*- coding: utf-8 -*-

import smbus
import math
from time import sleep

path ='/home/pi/team_a/ChallengeTeamA/command/'

DEV_ADDR = 0x68

R_THRESHOLD = 1.500
L_THRESHOLD = -1.000
U_THRESHOLD = 1.900
D_THRESHOLD = 0.200

PWR_MGMT_1  = 0x6B
SMPLRT_DIV  = 0x19
CONFIG      = 0x1A
GYRO_CONFIG = 0x1B
INT_ENABLE  = 0x38
ACCEL_XOUT = 0x3B
ACCEL_YOUT = 0x3D
ACCEL_ZOUT = 0x3F

PWR_MGMT_1 = 0x6b
PWR_MGMT_2 = 0x6c

bus = smbus.SMBus(1)
bus.write_byte_data(DEV_ADDR, PWR_MGMT_1, 0)


def MPU_Init():
    #write to sample rate register
    bus.write_byte_data(DEV_ADDR, SMPLRT_DIV, 7)

    #Write to power management register
    bus.write_byte_data(DEV_ADDR, PWR_MGMT_1, 1)

    #Write to Configuration register
    bus.write_byte_data(DEV_ADDR, CONFIG, 0)

    #Write to Gyro configuration register
    bus.write_byte_data(DEV_ADDR, GYRO_CONFIG, 24)

    #Write to interrupt enable register
    bus.write_byte_data(DEV_ADDR, INT_ENABLE, 1)

def read_word(adr):
    high = bus.read_byte_data(DEV_ADDR, adr)
    low = bus.read_byte_data(DEV_ADDR, adr+1)
    val = ((high << 8) | low)
    return val

# Sensor data read
def read_word_sensor(adr):
    val = read_word(adr)
    if (val > 32768):         # minus
        val = val - 65536     # plus
    return val

def getAccel():
    x = read_word_sensor(ACCEL_XOUT)/ 16384.0
    y = read_word_sensor(ACCEL_YOUT)/ 16384.0
    z = read_word_sensor(ACCEL_ZOUT)/ 16384.0
    return [x, y, z]


#MPU_Init()
# harahetta
i=0
while 1:
    ax, ay, az = getAccel()
    if(ax >= R_THRESHOLD and i!=1):
        i=1
	print('Right')
	print('ax = {0:4.3f}'.format(ax))
#    	sleep(0.25)
    elif(ax <= L_THRESHOLD and i !=2):
        i=2
	print('Left')
	print('ax = {0:4.3f}'.format(ax))
#   	sleep(0.25)
    elif(az >= U_THRESHOLD and i !=3):
        i=3
	print('UP')
	print('az = {0:4.3f}'.format(az))
#   	sleep(0.25)
    elif(az <= D_THRESHOLD and i !=4):
        i=4
	print('DOWN')
	print('az = {0:4.3f}'.format(az))
#   	sleep(0.25)
    sleep(0.1)
