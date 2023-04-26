import matplotlib.pyplot as plt
import numpy as np
from scipy.stats import gaussian_kde

data = np.random.lognormal(0, 1, size=10000)
density = gaussian_kde(data)
xs = np.linspace(0,100,10000)
density.covariance_factor = lambda : .25
density._compute_covariance()
plt.plot(xs,density(xs))
plt.show()