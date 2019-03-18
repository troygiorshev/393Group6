%% FFT

blackBox
temp = get(0,'showHiddenHandles');
set(0,'showHiddenHandles','on');
hfig = gcf;
handles = guidata(hfig);
Ts = 10;
T = 0.015;
Fs = 1/T;
set(handles.axisEnd, 'String', '10');
set(handles.stepSize, 'String', '0.015');
set(handles.input, 'String', '10*cos(4*pi*t)');
blackBox('input_Callback',handles.input,[],handles);
blackBox('run_Callback',handles.run,[],handles);
set(handles.saveFile, 'String', 'output');
blackBox('save_Callback',handles.save,[],handles);

filterd = smooth(output.output.time,output.output.signal,.05,'loess');

figure()
hold on
plot(output.output.time,filterd)
plot(output.output.time,output.output.signal)
hold off

Foutput = fft(filterd);
L = Fs * Ts; %%length of signal
t = (0:L-1)*T; %%time vector
f = Fs*(0:(L/2))/L; %%frequency vector

P2 = abs(Foutput/L); %%some fourrier shit
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

UnfOutput = fft(output.output.signal); %%more fourrier shit for unfiltered output
Pp2 = abs(UnfOutput/L);
Pp1 = Pp2(1:L/2+1);
Pp1(2:end-1) = 2*Pp1(2:end-1);

figure()
plot(f,P1);
figure()
plot(f,Pp1);
legend('Filtered FFT', 'Unfiltered FFT')
title('Noise Reduction of Filter on 10cos(2*2\pit)')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
hold off

figure()
hold on
plot(f,P1);
plot(f,Pp1);
legend('Filtered FFT', 'Unfiltered FFT')
title('Noise Reduction of Filter on 10cos(2*2\pit)')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
xlim([4 30])
hold off