# -*- coding: utf-8 -*-
"""
max de deux actifs, un qui est constant, r=0

Regle de gestion: lorsque l'actif > niveau S0 : on detient l'actif sinon cash.

Donc delta= 1_{actif > S0}
"""

import numpy as np
import matplotlib.pyplot as plt


T = 1  # Maturity time in years
N = 255 #Number of time steps
dt = T / N
M = 1000  # Number of simulations

S0 = 100
mu = 0.15
sigma = 0.2
r = 0.0

"""### Stock Price Simulation
Using Geometric Brownian Motion (GBM), simulate the stock price paths.
"""

dW = np.sqrt(dt) * np.random.randn(N, M)
W = np.zeros((N + 1, M))
W[1:, :] = np.cumsum(dW, axis=0)

t = np.linspace(0, T, N + 1)
S = S0 * np.exp((mu - 0.5 * sigma**2) * t[:, None] + sigma * W)

plt.plot(S[:, :10])
plt.title("Sample Simulated Stock Prices")
plt.xlabel("Time Steps")
plt.ylabel("Stock Price")
plt.show()

m=7
P0=90
Pt=np.zeros_like(t) ; Pt[0]=P0

Vt=S*0     ; Vt[0,:]=S0
Ct=S*0     ; Ct[0,:]=Vt[0,:]-Pt[0]
Xt=S*0     ; Xt[0,:]=m*Ct[0,:]
Mt=S*0     ; Mt[0,:]=Vt[0,:]-Xt[0,:]

"""### Management Loop
Iteratively adjust the portfolio to be coherent with management rule
"""

for jj in range(N):  
    Vt[jj + 1, :] = Mt[jj,:]*np.exp(r*dt) + Xt[jj,:]*S[jj+1,:]/S[jj,:]  # Update cash with risk-free rate
    Pt[jj+1]=Pt[jj]*np.exp(r*dt)
    Ct[jj+1,:]=Vt[jj+1,:]-Pt[jj+1] # Compute new delta based on current stock price
    Xt[jj+1,:]=m*Ct[jj+1,:]  # Adjust cash for delta change cost
    Mt[jj+1,:]=Vt[jj+1,:]-Xt[jj+1,:]

for jj in range(N):
    # Ulenbeck's formula for delta adjustment
    delta = np.where(S[jj, :] > S0, 1, 0)
    Xt[jj + 1, :] = delta * Vt[jj + 1, :]
    

"""### Final Portfolio Value Distribution
Plot the histogram of the final portfolio values.
"""

#plt.hist(Vt[-1, :]- Pt[-1], bins=50)
plt.figure('hist comp',figsize=(6,3))
plt.subplot(1,2,1)
plt.hist( S[-1, :], bins=50)
plt.title("Hist S_T")
plt.subplot(1,2,2)
plt.hist( np.clip(Vt[-1, :],0,220), bins=50)
plt.title("Hist V_T")
plt.xlabel("Portfolio Value")
plt.ylabel("Frequency")
plt.show()

plt.hist(np.log(Ct[1:,:]/Ct[:-1,:]).flatten(), bins=50)
plt.show()

print(S[-1, :].mean())
print(Vt[-1, :].mean())
