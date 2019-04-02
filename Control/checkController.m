%% Get the transfer function

close all;
clear all;
clc;

% Zeros [essentially where there is an "increase in slope"]

z1 = 10^(-0.834);
z2 = 10^(1.063);
% z3 = 10^(-.6);
% z4 = 10^(1.3);
% z5 = 10^();

zs = [z1 -z2];

% Poles [essentially where there is a "decrease in slope"]

 p1 = 10^(-1.876);
 p2 = 10^(1.972);
 p3 = 10^(2.516);
 p4 = 10^(2.878);
 %p5 = 10^(-1.9);
% p6 = 10^();

ps = [-p1 -p2 -p3 -p4];

sys = zpk(zs,ps,1);

K=1/-evalfr(sys,0);

sys = zpk(zs,ps,K);
L = tf(sys);

P = -5.9;  
I = -0.04;  
D = 5;

contr = pid(P, I, D, 1);

C = tf(contr);

TF = feedback(C*L,1)

%% Set up the lsim

endtime = 100;
endtimetext = '100'

t = 0:0.01:endtime;
u = 0*t + 1; % Make the next line the same as this
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
blackBox('s4ave_Callback',handles.save,[],handles);

% yy1 = smooth(output.output.time,output.output.signal,0.1,'loess');
% time=0:0.01:endtime;
% out1 = interp1(output.output.time,yy1,time);

%% Run lsim and plot both

figure ()
hold on

lsim(TF,u,t)
plot(output.output.time,output.output.signal,'r')
legend("Model","BlackBox")
