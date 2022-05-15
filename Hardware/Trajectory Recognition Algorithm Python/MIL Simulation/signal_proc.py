# Libraries
# Standard library
import math

# Third-party libraries
import numpy as np

class Signal_Processing:

    def __init__(self, input_name, input_n = 4):  #Here input name is input.csv
        self.g_mag = 9.8
        self.n = input_n
        self.filename = input_name + ".csv"

    def processing(self):

        sensor_input = np.genfromtxt(self.filename, delimiter=',')
        
        # Assuming input is a N x 3 matrix where N is the number of readings
        N = np.size(sensor_input, 0)
        
        # Calculating the magnitude of readings(indirectly gravity) when the accelerometer is held idle for a few ms
        g_mag = ((sensor_input[0, 0] + sensor_input[1, 0] + sensor_input[2, 0])/3)**2 + ((sensor_input[0, 1] + sensor_input[1, 1] + sensor_input[2, 1])/3)**2 +((sensor_input[0, 2] + sensor_input[1, 2] + sensor_input[2, 2])/3)**2
        g_mag = np.sqrt(g_mag)
        
        # Assuming a variable n which is the number of recent readings we take an average over
        n = 4
        
        # Calling functions
        trans_mat(sensor_input, g_mag, N)
        f_out = ma_filter(sensor_input, g_mag, N, self.n)
        
        return f_out

# Define transformation matrix
def trans_mat(sensor_input, g_mag, N):

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

# Define moving average filter
def ma_filter(sensor_input, g_mag, N, n):

    filtered_output = np.zeros((N - n + 1, 2))

    for i in range(0, N - n + 1):

        for j in range(i, i + n):
            filtered_output[i, 1] = filtered_output[i, 1] + sensor_input[j, 1]
            filtered_output[i, 0] = filtered_output[i, 0] + sensor_input[j, 0]

        filtered_output[i, 1] = filtered_output[i, 1] / n
        filtered_output[i, 0] = filtered_output[i, 0] / n

    final_output = high_pass(filtered_output, g_mag, N, n)
    return final_output

# Define high pass filter
def high_pass(filtered_output, g_mag, N, n):

    final_output = np.zeros((N - n + 1, 2))
        
    # Subtracting g from y-coordinates
    for i in range(0, N - n + 1):
            filtered_output[i, 1] = filtered_output[i, 1] - g_mag;
    return filtered_output
