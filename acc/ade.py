import numpy as np
import matplotlib.pyplot as plt

src ='data.txt'
xa=np.array([], dtype=float)
ya=np.array([], dtype=float)
za=np.array([], dtype=float)
ax = plt.subplot2grid((2,2), (0,0))
ay = plt.subplot2grid((2,2), (0,1))
az = plt.subplot2grid((2,2), (1,0), colspan=2)


with open(src) as f:
    for data in f:
        data = data.split(',')
        xa = np.append(xa, float(data[0]))
        ya = np.append(ya, float(data[1]))
        za = np.append(za, float(data[2]))

x=range(xa.size)

ax.plot(x,xa, linewidth=2)
ay.plot(x,ya, linewidth=2)
az.plot(x,za, linewidth=2)

plt.show()
