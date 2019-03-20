%makes a Bode plot

close all;
A = phase(:,1)
B = phase(:,2)
C = amplitude(:,1)
D = amplitude(:,2);


fontSize = 18
set(0, 'defaultTextFontSize',20);
figure()
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