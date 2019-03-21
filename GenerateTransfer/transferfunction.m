%makes a Bode plot

close all;
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
figure(4)
bode(sys)
title("Bode for Unscaled System, Theoretical")
grid on

% % Making this bigger makes the graph go up
% desired=16000000;
% magwanted=-94;
% delta = 20*log10(desired)-20*log10(magwanted);
% %delta = 20*log10(68)-20*log10(.002);

%K = 10^(delta/20); %
K=10^5.25;

sys2 = zpk(zs,ps,[K]);

figure(3);
bode(sys2);
title("Bode for Scaled system, Theoretical")

figure(1);
hold on
[magraw, aphaseraw, wout]=bode(sys2);
mag=permute(magraw, [3,1,2]);
semilogx(wout, 20*log10(mag))
grid on;

figure(2);
hold on
phasebode = permute(aphaseraw,[3,1,2]);
semilogx(wout, phasebode)
grid on;

% how many zeros are in rhp adds 180 to the phase plot at low frequencies
