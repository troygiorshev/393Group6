# Ziegler-Nichols Method

## Step 1: Find K_u, where the output has stable and consistent oscillations

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

Which is clearly unstable, seen in Figure 1-4.

## Section 2 - Me Figuring it out

BS about how this was done, harping on the nyquist criterion a ton.

P = -5.9;  
I = -0.04;  
D = 5;

Figure 2-1 Step response of system

Steady State Error: -0.069
Rise Time: N/A
Overshoot: N/A
Settling Time: 23.4

2-2 Nyquist Plot.  Note 2 encirclements of -1, corresponding to the 2 poles in the RHP, so the system is stable.

## Section 3 - Blackbox

Figure 3-1 Matlab model implementing the tuned PID controller, with a second order filter.

Figure 3-2 Comparison of the modeled behaviour vs the blackbox behaviour.