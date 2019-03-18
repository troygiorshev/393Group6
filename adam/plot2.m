close all;
A = newOutput(:,1)
B = newOutput(:,2)
C= newOutput(:,3);



fontSize = 18
set(0, 'defaultTextFontSize',20);
figure()
semilogx(A,B)
xlabel("Frequency \omega",'fontsize',fontSize)
ylabel("dB",'fontsize',fontSize)
title("Magnitude Plot",'fontsize',fontSize)
grid on

figure(2)
semilogx(A,C)
xlabel("Frequency \omega",'fontsize',fontSize)
ylabel("deg",'fontsize',fontSize)
title("Phase Plot",'fontsize',fontSize)
grid on