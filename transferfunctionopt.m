%% Initial Transfer Function

close all;
clc;

% Zeros [essentially where there is an "increase in slope"]

z1 = -0.75;
z2 = 1.1;

zs = [10^(z1) -10^(z2)];

% Poles [essentially where there is a "decrease in slope"]

 p1 = 2.38;
 p2 = -1.87;
 p3 = 2.15;
 p4 = 2.78;

ps = [-10^(p1) -10^(p2) -10^(p3) -10^(p4)];

k=5.1;
K=10^(k);

sys = zpk(zs,ps,[K]);
L = tf(sys);
%% Blackbox Generated Step Response
    blackBox
    temp = get(0,'showHiddenHandles');
    set(0,'showHiddenHandles','on');
    hfig = gcf;
    handles = guidata(hfig);
    endtime = '10';
    stepbb = '0.01';
    set(handles.axisEnd, 'String', endtime);
    set(handles.stepSize, 'String', stepbb);

    set(handles.input, 'String', 't==0');
    blackBox('input_Callback',handles.input,[],handles);
    blackBox('run_Callback',handles.run,[],handles);
    set(handles.saveFile, 'String', 'output');
    blackBox('save_Callback',handles.save,[],handles);

    yy1 = smooth(output.output.time,output.output.signal,0.1,'loess');
    time=0:0.01:10;
    out1 = interp1(output.output.time,yy1,time);

%% Optimization
    
zp=[-.75   1.1    2.155   -1.87    2.38    2.78];
error = 100000;
zpfinal=[0 0 0 0 0 0];

kfinal=0;

for i = 1:6
    start=zp(i)-.5;
    endval=zp(i)+.5;
    for j=start:.01:endval
        zp(i)=j;
        zs = [10^(zp(1)) -10^(zp(2))];
        ps = [-10^(zp(3)) -10^(zp(4)) -10^(zp(5)) -10^(zp(6))];
        

        %for k=0:.05:50

            sys1 = zpk(zs,ps,[1]);
            M1 = -6.0311;
            M = evalfr(sys1,10^(2));
            delta = 20*log10(M1)-20*log10(M);
            K = 10^(delta/20); 
            sys = zpk(zs,ps,[K]);
            L=tf(sys);
            out2 = step(L, (time));
            output= (real(out2)).';
            %mean1= mean((out1-output).^2);
            RMSE = sqrt(mean((out1-output).^2));
            if RMSE<error
                error = RMSE;
                zpfinal(i)=j;
                kfinal=k;
            end
        %end
    end
    zp(i)=zpfinal(i);
end
%% 

zpfinal
kfinal

