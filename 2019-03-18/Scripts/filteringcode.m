%%Filtering Code
blackBox
temp = get(0,'showHiddenHandles');
set(0,'showHiddenHandles','on');
hfig = gcf;
handles = guidata(hfig);
set(handles.axisEnd, 'String', 18);
set(handles.stepSize, 'String', 0.01);

set(handles.axisStart, 'String', '0');
set(handles.axisEnd, 'String', '10');
set(handles.input, 'String', 'cos(t)');
blackBox('input_Callback',handles.input,[],handles);
blackBox('run_Callback',handles.run,[],handles);
set(handles.saveFile, 'String', 'output');
blackBox('save_Callback',handles.save,[],handles);

set(handles.axisStart, 'String', '5');
set(handles.axisEnd, 'String', '15');
set(handles.input, 'String', 'cos(t)');
blackBox('input_Callback',handles.input,[],handles);
blackBox('run_Callback',handles.run,[],handles);
set(handles.saveFile, 'String', 'output1');
blackBox('save_Callback',handles.save,[],handles);



yy1 = smooth(output.output.time,output.output.signal,.1,'loess');
yy1a = smooth(output1.output.time,output1.output.signal,.1,'loess');

figure()
hold on
title('Time Invariance Validation')
ylabel('Amplitude')
xlabel('Time (s)')
plot(output.output.time,yy1)
plot(output1.output.time,yy1a)
legend('cos(t)','cos(t-5)')
hold off






