# %load signal_processing.py

"""
signal_processing.py
~~~~~~~~~~
IT WORKS

A module to implement the signal preprocessing of which consists of: Calibration( to remove drift errors and offsets from the raw signals )
A moving average filter( to remove high frequency noise from raw data ), a high-pass filter( to remove gravitational acceleration from raw data ) and normalization*. It is not optimized, and omits many desirable features.
"""

# Libraries
# Standard library
import math

# Third-party libraries
import numpy as np

filename = 'Untitled 1.csv'

sensor_input = np.genfromtxt(filename, delimiter=',')
# Assuming input is a N x 3 matrix where N is the number of readings
N = np.size(sensor_input, 0)
# Calculating the magnitude of readings(indirectly gravity) when the accelerometer is held idle for a few ms
g_mag = ((sensor_input[0, 0] + sensor_input[1, 0] + sensor_input[2, 0])/3)**2 + ((sensor_input[0, 1] + sensor_input[1, 1] + sensor_input[2, 1])/3)**2 +((sensor_input[0, 2] + sensor_input[1, 2] + sensor_input[2, 2])/3)**2
g_mag = np.sqrt(g_mag)
# Assuming a variable n which is the number of recent readings we take an average over
n = 4

# Define transformation matrix
def rot(sensor_input, g_mag, N):
    
    cos_theta = sensor_input[0, 1]/g_mag
    sin_theta = sensor_input[0, 0]/g_mag
    
    # aligining x and y axes to inertial frame where x-z plane is on the ground and y axis is into Earth
    for i in range(0, N):
        x_0 = sensor_input[i, 0]
        y_0 = sensor_input[i, 1]
        x_1 = x_0*cos_theta - y_0*sin_theta
        y_1 = x_0*sin_theta + y_0*cos_theta
        sensor_input[i, 0] = x_1
        sensor_input[i, 1] = y_1
        
    norm = ((sensor_input[0, 0] + sensor_input[1, 0] + sensor_input[2, 0])/3)**2 +((sensor_input[0, 2] + sensor_input[1, 2] + sensor_input[2, 2])/3)**2
    norm = np.sqrt(g_mag)
    cos_phi = sensor_input[0, 0]/norm
    sin_phi = sensor_input[0, 2]/norm
        
    # rotating x-z plane about y axis to eliminate z coordinates
    for i in range(0, N):
        x_1 = sensor_input[i, 0]
        z_1 = sensor_input[i, 2]
        x_2 = x_1*cos_phi - z_1*sin_phi
        z_2 = x_1*sin_phi + z_1*cos_phi
        sensor_input[i, 0] = x_2
        sensor_input[i, 2] = z_2
        
    return sensor_input

# Define moving average filter
def ma_filter(sensor_input, N):

    filtered_output = np.zeros((N - n + 1, 3))
    
    for i in range(0, N - n + 1):
        
        for j in range(i, i + n):
            filtered_output[i, 1] = filtered_output[i, 1] + sensor_input[j, 1]
            filtered_output[i, 0] = filtered_output[i, 0] + sensor_input[j, 0]

        filtered_output[i, 1] = filtered_output[i, 1] / n
        filtered_output[i, 0] = filtered_output[i, 0] / n

    return filtered_output

# Define high pass filter
def high_pass(sensor_input, g_mag, N):
    
    # Subtracting g from y-coordinates
    for i in range(0, N - n + 1):
        sensor_input[i, 1] = sensor_input[i, 1] - g_mag;
    return sensor_input

# Calling transformation matrix, output will be shrunk to N x 2 matrix
sensor_input = rot(sensor_input, g_mag, N)

# Calling moving average filter
sensor_input = ma_filter(sensor_input, N)

# Calling high pass filter
sensor_input = high_pass(sensor_input, g_mag, N)
    
print(sensor_input)
np.savetxt("output.csv", sensor_output, delimiter=",")
