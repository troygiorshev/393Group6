%makes a Bode plot

close all;
A = phase(:,1);
B = phase(:,2);
C = amplitude(:,1);
D = amplitude(:,2);


fontSize = 18;
set(0, 'defaultTextFontSize',20);
figure(1)
semilogx(C,D)
xlabel("Frequency \omega",'fontsize',fontSize)
ylabel("dB",'fontsize',fontSize)
title("Magnitude Plot",'fontsize',fontSize)
grid on

figure(2)
semilogx(A,B)
xlabel("Frequency \omega",'fontsize',fontSize)
ylabel("deg",'fontsize',fontSize)
title("Phase Plot",'fontsize',fontSize)
grid on
hold on

% Zeros [essentially where there is an "increase in slope"]

z1 = 10^(-0.9);
z2 = 10^(1);
 z3 = 10^(-.6);
% z4 = 10^(1.3);
% z5 = 10^();

% Poles [essentially where there is a "decrease in slope"]

 p1 = 10^(2.3);
 p2 = 10^(-2);
 p3 = 10^(2);
 p4 = 10^(2.5);
 p5 = 10^(-1.9);
% p6 = 10^();

gain=1;
sys = zpk([-z1 -z2 -z3],[-p1 -p2 -p3 -p4 -p5],[gain]);
figure(1)
[mag, phase, wout]=bode(sys);
plot(mag(1,1,:), wout)
grid on

desired=0.002;
mag=68;
delta = 20*log10(mag)-20*log10(desired);
%delta = 20*log10(68)-20*log10(.002);

K = 10^(delta/20); %

sys2 = zpk([-z1 -z2 -z3],[-p1 -p2 -p3 -p4 -p5],[K]);

figure(3);
bode(sys2);
grid on;

% how many zeros are in rhp adds 180 to the phase plot at low frequencies
