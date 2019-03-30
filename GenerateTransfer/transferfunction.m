%makes a Bode plot

%% Get the transfer function

close all;
clc;

syms s P I D

% Zeros [essentially where there is an "increase in slope"]

z1 = 10^(-0.9);
z2 = 10^(1.1);
% z3 = 10^(-.6);
% z4 = 10^(1.3);
% z5 = 10^();

zs = [z1 -z2];

% Poles [essentially where there is a "decrease in slope"]

 p1 = 10^(2.45);
 p2 = 10^(-1.9);
 p3 = 10^(2.15);
 p4 = 10^(2.75);
 %p5 = 10^(-1.9);
% p6 = 10^();

ps = [-p1 -p2 -p3 -p4];

gain=1;
sys = zpk(zs,ps,[gain]);

K=10^5.25;

sys2 = zpk(zs,ps,[K]);
L = tf(sys2);

%% PID

close all;
clc;

Kp = -1;
Ki = 0;
Kd = 0;

contr = pid(Kp, Ki, Kd, 100);

C = tf(contr);

TF = feedback(C*L,1) % This is the only correct way to do this
pole(TF)

step(TF)
 
figure()

nyqlog(TF)
%% Graphing

A = phase(:,1);
B = phase(:,2)*-1;
C = amplitude(:,1);
D = amplitude(:,2);

fontSize = 18;
set(0, 'defaultTextFontSize',20);

figure(1)
semilogx(C,D)
xlabel("Frequency \omega",'fontsize',fontSize)
ylabel("dB",'fontsize',fontSize)
title("Magnitude Plot",'fontsize',fontSize)
xlim([10^(-4) 10^4])
grid on
hold on

figure(2)
semilogx(A,B)
xlabel("Frequency \omega",'fontsize',fontSize)
ylabel("deg",'fontsize',fontSize)
title("Phase Plot",'fontsize',fontSize)
xlim([10^(-4) 10^4])
grid on
hold on


figure(1);
hold on
[magraw, aphaseraw, wout]=bode(sys2);
mag=permute(magraw, [3,1,2]);
semilogx(wout, 20*log10(mag))
legend('Experimental','Heuristic')
grid on;

figure(2);
hold on
phasebode = permute(aphaseraw,[3,1,2]);
semilogx(wout, phasebode)
legend('Experimental','Heuristic')
grid on;

% how many zeros are in rhp adds 180 to the phase plot at low frequencies
