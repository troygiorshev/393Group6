blackBox
temp = get(0,'showHiddenHandles');
set(0,'showHiddenHandles','on');
hfig = gcf;
handles = guidata(hfig);
endtime = '20';
step = '0.001';
Fs = 10/.01;
set(handles.axisEnd, 'String', endtime);
set(handles.stepSize, 'String', step);

for i =1:10
    
set(handles.input, 'String', 'sin(t)');
blackBox('input_Callback',handles.input,[],handles);
blackBox('run_Callback',handles.run,[],handles);
set(handles.saveFile, 'String', 'output');
blackBox('save_Callback',handles.save,[],handles);

yy1 = smooth(output.output.time,output.output.signal,0.10,'loess');

if i ==1
    noise = output.output.signal(1:1500) - yy1(1:1500);
else
    noise = noise + output.output.signal(1:1500) - yy1(1:1500);
end
i = i
end

%%
[histFreq, histXout] = hist(noise,500);
binWidth = histXout(2)-histXout(1);
figure;

bar(histXout, 10*histFreq/binWidth/sum(histFreq)); 
%
xlabel('Error Value');
ylabel('Probability Density');
%xlim([-2 1.5])

hold on
% fit a normal dist to check the pdf
PD = fitdist(noise, 'normal');
plot(histXout, pdf(PD, histXout)/35, 'r');
legend('Averaged Noise','Fitted Gaussian Distribution')
title('Histogram of Noise, 1000 Trials')
%%
figure() 
hold on
plot(output.output.time(1:1500),noise)

hold off

