%makes a Bode plot

%% Get the transfer function

close all;
clc;

% Zeros [essentially where there is an "increase in slope"]

z1 = 10^(-0.834);
z2 = 10^(1.063);
% z3 = 10^(-.6);
% z4 = 10^(1.3);
% z5 = 10^();

zs = [z1 -z2];

% Poles [essentially where there is a "decrease in slope"]

 p1 = 10^(-1.876);
 p2 = 10^(1.972);
 p3 = 10^(2.516);
 p4 = 10^(2.878);
 %p5 = 10^(-1.9);
% p6 = 10^();

ps = [-p1 -p2 -p3 -p4];

sys = zpk(zs,ps,1);

K=1/-evalfr(sys,0);

sys2 = zpk(zs,ps,K);
L = tf(sys2);

%% PID

%close all;
clc;

P = -5.2;  
I = -0.06;  
D = 15;

contr = pid(P, I, D, 1);

C = tf(contr);

TF = feedback(C*L,1) % This is the only correct way to do this
pole(TF)

figure(1)
endtime = 200;
t = 0:0.001:endtime;
u = 0*t + 1;
lsim(TF,u,t)

%step(TF)
title("Step Response, P = " + num2str(P,10) + " I = " +num2str(I) + " D = " + num2str(D))
xlim([0,endtime])
 
figure(2)
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
