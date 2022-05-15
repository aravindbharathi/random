import numpy as np
from matplotlib import pyplot as plt

data = np.loadtxt('output.dat')

# %matplotlib qt
fig = plt.figure(figsize=(8, 8))
ax = fig.add_subplot(projection='3d')

x = data[:, 0]
y = data[:, 1]

pk = data[:, 3] - data[:, 2]
index = np.where(pk < min(3*pk.min(), 1e-1))

print("Dirac points:")
print("x: ", x[index])
print("y: ", y[index])

print("Analytical solution")
print("x = 2*pi/3 = ", 2*np.pi/3, "y = 2*pi/3sqrt(3)", 2*np.pi/3/np.sqrt(3))

ax.scatter(x, y, data[:, 2], c=data[:, 2], cmap='viridis')  # Blues
ax.scatter(x, y, data[:, 3], c=data[:, 3], cmap='magma')  # Reds
ax.scatter(x[index], y[index], data[[index], 2], c='black', s=300)
ax.set_xlabel("$k_x$")
ax.set_ylabel("$k_y$")
ax.set_zlabel("$E$")
ax.set_title("Graphene Tight Binding Dispersion")
plt.show()
