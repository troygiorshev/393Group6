%%Controls Lab 7
A = [0 1; 0 -(1/0.04)];
b = [0;172];
c = [1 0];
D = 0;
sys=ss(A,b,c,D);
h = tf(sys)
figure()
hold on
impulse(sys)
xlim([0 30])

