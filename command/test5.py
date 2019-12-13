# -*- coding: utf-8 -*-

import smbus
import math
from time import sleep

DEV_ADDR = 0x68

PWR_MGMT_1  = 0x6B
SMPLRT_DIV  = 0x19
CONFIG      = 0x1A
GYRO_CONFIG = 0x1B
INT_ENABLE  = 0x38
ACCEL_XOUT = 0x3B
ACCEL_YOUT = 0x3D
ACCEL_ZOUT = 0x3F
TEMP_OUT = 0x41
GYRO_XOUT = 0x43
GYRO_YOUT = 0x45
GYRO_ZOUT = 0x47

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
    #print (val)
    return val

# Sensor data read
def read_word_sensor(adr):
    val = read_word(adr)
    if (val > 32768):         # minus
        val = val - 65536     # plus
    #print (val)
    return val


def get_temp():
    temp = read_word_sensor(TEMP_OUT)
    x = temp / 340 + 36.53      # data sheet(register map)記載の計算式.
    return x


def getGyro():
    x = read_word_sensor(GYRO_XOUT)/ 131.0
    y = read_word_sensor(GYRO_YOUT)/ 131.0
    z = read_word_sensor(GYRO_ZOUT)/ 131.0
    return [x, y, z]


def getAccel():
    x = read_word_sensor(ACCEL_XOUT)/ 16384.0
    y = read_word_sensor(ACCEL_YOUT)/ 16384.0
    z = read_word_sensor(ACCEL_ZOUT)/ 16384.0
    #print ({}{}{})
    return [x, y, z]


#MPU_Init()
while 1:
    ax, ay, az = getAccel()
    gx, gy, gz = getGyro()

    print ('x={0:4.3f},   y={1:4.3f},   z={2:4.3f},' .format(ax, ay, az))
    #roll = math.atan(ay/az) * 57.324
    #pitch = math.atan(-ax / math.sqrt( ay* ay+ az*az ) ) * 57.324

    #pitch = math.atan(-ax / (ay*math.sin(roll) + az*math.cos(roll)))

    #print('{0:4.3f},   {0:4.3f},' .format(pitch, roll))
    sleep(0.2)
