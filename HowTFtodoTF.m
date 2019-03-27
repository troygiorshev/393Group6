K = 2;
G = tf([1 2],[1 .5 3]);

TF1 = K*G/(1+K*G) % Yes, but it's not simplified so it fucks up
TF2 = tf(K*G/(1+K*G)) % Same shit
TF3 = tf(G,(G*G*G*G*G*K)) % Absolutely not
feedback(G,K) % No
TF = feedback(K*G,1) % YES, verified with paper