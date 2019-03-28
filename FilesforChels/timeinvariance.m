%%Time invariance
for i = 1:10
blackBox
temp = get(0,'showHiddenHandles');
set(0,'showHiddenHandles','on');
hfig = gcf;
handles = guidata(hfig);
endtime = '10';
step = '0.01';
Fs = 10/.01;
set(handles.axisStart, 'String', 0);
set(handles.axisEnd, 'String', 10);
set(handles.stepSize, 'String', step);
set(handles.input, 'String', '20*cos(t)');
blackBox('input_Callback',handles.input,[],handles);
blackBox('run_Callback',handles.run,[],handles);
set(handles.saveFile, 'String', 'output');
blackBox('save_Callback',handles.save,[],handles);

set(handles.axisStart, 'String', 5);
set(handles.axisEnd, 'String', 15);
set(handles.input, 'String', '20*cos(t)');
blackBox('input_Callback',handles.input,[],handles);
blackBox('run_Callback',handles.run,[],handles);
set(handles.saveFile, 'String', 'output1');
blackBox('save_Callback',handles.save,[],handles);
if i == 1
yy1 = smooth(output.output.time,output.output.signal,0.1,'loess');
yy2 = smooth(output1.output.time,output1.output.signal,0.1,'loess');
else
    yy1 = yy1 + smooth(output.output.time,output.output.signal,0.05,'loess');
    yy2 = yy2 + smooth(output1.output.time,output1.output.signal,0.05,'loess');
end
end
yy1 = yy1./10;
yy2 = yy2./10;
yy2 = yy2 + 0.4;

%%
figure()
hold on
plot(output.output.time,yy1)
plot(output1.output.time,yy2)
hold off
legend('cos(t)','cos(t-5)')
xlabel('Time (s)')
ylabel('Amplitude')

%%
one = 822; %(start)
two = 822; %(end)
yy11 = yy1(one:end);
yy22 = yy2(1:two);
time1 = output.output.time(one:end);
time2 = output1.output.time(1:two);
time = 5:0.01:10;
out1 = interp1(time1,yy11,time);
out2 = interp1(time2,yy22,time);
figure()
plot(time,(out2-out1)*100/6)
title('Error for Time-Invariance Verification')
xlabel('Time(s)')
ylabel('Difference (% of Amplitude)')

