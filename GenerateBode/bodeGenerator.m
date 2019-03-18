
clear all;
close all;

%%Filtering Code
blackBox
temp = get(0,'showHiddenHandles');
set(0,'showHiddenHandles','on');
hfig = gcf;
handles = guidata(hfig);

newOutput = [ ];

indexOmega = -3;
stopOmega = 0.01
omega = 10^indexOmega;


while(omega<stopOmega)

    indexOmega = indexOmega + 0.25;
    omega = 10^indexOmega;
logOmega = floor(log10(omega));
stepSize = 10^(-logOmega-2);

refineOutput = 4;
    
set(handles.axisEnd, 'String', 1/omega * 15 );
set(handles.stepSize, 'String', stepSize);
s = num2str(omega);
sin = strcat('sin(',s,'*t)')
set(handles.input, 'String', sin);
set(handles.refineOutput, 'String', refineOutput);
blackBox('input_Callback',handles.input,[],handles);
blackBox('run_Callback',handles.run,[],handles);
set(handles.saveFile, 'String', 'output');
blackBox('save_Callback',handles.save,[],handles);

% begin = floor(length(output.output.time)/10);
% stop = begin*10;
% begin = 1;
% first = output.output.time(begin:stop);
% second = output.output.signal(begin:stop);
  yy1 = smooth(output.output.time,output.output.signal,0.1,'loess');
% figure(1)
% hold on
% plot(output.output.time,output.output.signal)
 
 
 
% plot(output.output.time,yy1)
% title('Filtered vs Original')
% xlabel('Time (s)')
% ylabel('Output')
% hold off
% b = 0;
% for i= 10:length(output.output.signal)-1
%     if output.output.signal(i+1) < 0
%         a = output.output.signal(i);
%         b = i;
%         break
%     end
% end

start = floor(length(yy1)/10);
while yy1(start+1) >= yy1(start)
    start = start + 1;
end

for i= start:length(yy1)-1
    if yy1(i+1) < 0
        a = yy1(i);
        b = i;
        break
    end
end

a;
b;
time = output.output.time(i)


max = 0;
min = 0;
start = floor(length(yy1)/10*5);

while yy1(start+1) < yy1(start)
    start = start + 1;
end

index = start;
    for i= start:(length(yy1)-1)
        
        if yy1(i+1) < yy1(i)
            max = yy1(i);
            index = index + 1;
            
            for i= index:length(yy1)-1
                if yy1(i+1) > yy1(i)
                    min = yy1(i);
                    break;
                end
            end
            
            break;
        end
        index = index + 1;
    end





max 
min
% amplitude = (max-min)/2;
amplitude = max;

inputZero = pi / omega;
timeDifference = inputZero - time;
degrees = timeDifference * omega * 180 / pi;
decibels = 20*log10(amplitude);
time

if (max*min)>1
    success = -1
else
    success = 1
end


if time <= 0
    successTime = -1
else
    successTime = 1
end
    
    
outputArray = [omega, decibels, degrees, time, success, successTime]
newOutput = vertcat(newOutput,outputArray);
end

% A = newOutput(:,1);
% B = 20* log10(newOutput(:,2));
% C= newOutput(:,3);
% 
% fontSize = 18
% set(0, 'defaultTextFontSize',20);
% figure(1)
% semilogx(A,B)
% xlabel("Frequency \omega",'fontsize',fontSize)
% ylabel("dB",'fontsize',fontSize)
% title("Magnitude Plot",'fontsize',fontSize)
% grid on
% 
% figure(2)
% semilogx(A,C)
% xlabel("Frequency \omega",'fontsize',fontSize)
% ylabel("deg",'fontsize',fontSize)
% title("Phase Plot",'fontsize',fontSize)
% grid on


