blackBox
temp = get(0,'showHiddenHandles');
set(0,'showHiddenHandles','on');
hfig = gcf;
handles = guidata(hfig);
endtime = '10';
step = '0.01';
Fs = 10/.01;
set(handles.axisEnd, 'String', endtime);
set(handles.stepSize, 'String', step);

set(handles.input, 'String', '-t^2 + 10');
blackBox('input_Callback',handles.input,[],handles);
blackBox('run_Callback',handles.run,[],handles);
set(handles.saveFile, 'String', 'output');
blackBox('save_Callback',handles.save,[],handles);

%%
a = 1;
b = ones(1,100)/99;
filtered1 = filter(b,a,filename1.output.signal);
filtered1a = filtfilt(b,a,filename1.output.signal);
yy1 = smooth(filename1.output.time,filename1.output.signal,0.10,'loess');
yy2 = smooth(filename1.output.time,filename1.output.signal,0.1,'lowess');

RMSE1 = sqrt(mean((filtered1-filename1.output.signal).^2));
RMSE1a = sqrt(mean((filtered1a-filename1.output.signal).^2));
RMSEyy1 = sqrt(mean((yy1-filename1.output.signal).^2));
RMSEyy2 = sqrt(mean((yy2-filename1.output.signal).^2));

%%
figure() 
hold on
plot(filename1.output.time,filename1.output.signal)
plot(filename1.output.time,filtered1)
plot(filename1.output.time,filtered1a)
plot(filename1.output.time,yy1)
plot(filename1.output.time,yy2)
legend('Original', ['Filter, RMSE = ' num2str(RMSE1)],['filtfilt, RMSE = ' num2str(RMSE1a)], ['LOESS, RMSE = ' num2str(RMSEyy1)], ['LOWESS, RMSE = ' num2str(RMSEyy2)])
title('Data Filters on y(t) = sin(t/5) + cos(t*5)')
xlabel('Time (s)')
ylabel('Output')
hold off

