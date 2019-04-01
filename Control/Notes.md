# Ziegler-Nichols Method

## Step 1: Find K_u, where the output has stable and consistent oscillations.

The system is exceedingly sensitive.

P = -1.82438401 gives figure 1-1, converging.

P = -1.82438404 gives figure 1-2, with steady and consistent oscillations.

P = -1.82438406 gives figure 1-3, diverging.

Zooming in on 1-2 gives 1-2b.  Analyzing that plot gives the following values.

K_u = 2.17  
T_u = 0.049

So, with classic PID

K_P = 0.6 * K_u = 1.302  
K_I = 1.2 * K_u / T_u = 53.143  
K_D = 3 * K_u * T_u / 40 = 0.007975

Which give specifications of:

Steady State Error: -0.04  
Rise Time: 1.34  
Overshoot: 0  
Settling Time: 1.34

With the Pessen Integral Rule

K_P = 7 * K_u / 10 = 1.519  
K_I = 1.75 * K_u / T_u = 77.5  
K_D = 14 * K_u * T_u / 3 = 0.496

Which give specifications of:

Steady State Error: -0.027  
Rise Time: 1.11  
Overshoot: 0  
Settling Time: 1.11

In Conclusion:

P = -1.519;  
I = 77.5;  
D = 0.496;