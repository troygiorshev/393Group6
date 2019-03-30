%% Get the transfer function

close all;
clc;

% Zeros [essentially where there is an "increase in slope"]

z1 = 10^(-0.75);
z2 = 10^(1.1);
% z3 = 10^(-.6);
% z4 = 10^(1.3);
% z5 = 10^();

zs = [z1 -z2];

% Poles [essentially where there is a "decrease in slope"]

 p1 = 10^(2.155);
 p2 = 10^(-1.87);
 p3 = 10^(2.38);
 p4 = 10^(2.78);
 %p5 = 10^(-1.9);
% p6 = 10^();

ps = [-p1 -p2 -p3 -p4];

sys = zpk(zs,ps,1);

K=1/-evalfr(sys,0);

sys = zpk(zs,ps,K);
L = tf(sys);


%% Get the transfer function v2

close all;
clc;

% Zeros [essentially where there is an "increase in slope"]

z1 = 10^(0.25);
z2 = 10^(1);
% z3 = 10^(-.6);
% z4 = 10^(1.3);
% z5 = 10^();

zs = [z1 -z2];

% Poles [essentially where there is a "decrease in slope"]

 p1 = 10^(3.155);
 p2 = 10^(-2.358);
 p3 = 10^(3.38);
 p4 = 10^(3.78);
 %p5 = 10^(-1.9);
% p6 = 10^();

ps = [-p1 -p2 -p3 -p4];

sys3 = zpk(zs,ps,1);

K=1/-evalfr(sys3,0);

sys2 = zpk(zs,ps,K);
L = tf(sys2);

%% Set up the lsim

endtime = 1;
endtimetext = '1'

t = 0:0.01:endtime;
u = 1; % Make the next line the same as this
ustr = '1'

%% Get data from blackbox

blackBox
temp = get(0,'showHiddenHandles');
set(0,'showHiddenHandles','on');
hfig = gcf;
handles = guidata(hfig);
stepbb = '0.01';
set(handles.axisEnd, 'String', endtimetext);
set(handles.stepSize, 'String', stepbb);

set(handles.input, 'String', ustr);
blackBox('input_Callback',handles.input,[],handles);
blackBox('run_Callback',handles.run,[],handles);
set(handles.saveFile, 'String', 'output');
blackBox('save_Callback',handles.save,[],handles);

yy1 = smooth(output.output.time,output.output.signal,0.1,'loess');
time=0:0.01:endtime;
out1 = interp1(output.output.time,yy1,time);

%% Run lsim and plot both

figure ()
hold on

lsim(sys,u,t)
lsim(sys2,u,t)
plot(time,out1,'r')
legend("Model1", "Model2","BlackBox")
