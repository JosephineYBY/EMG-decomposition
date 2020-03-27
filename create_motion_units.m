function [ensemble] = create_motion_units(window,case_condition,data,truth)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%input: window-window size
%case_condition-the energy difference function choices
%data-the raw EMG signal
%truth-truth file
%ouput: ensemble-ensemble-motion units in the length of window(matrix size=508templates*the length of window)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initialization
peaks = truth.time;
%% Upsample from 10KHz to 50 KHz
fs = 10000;

t = 0:1/fs:length(data)/fs;
t = t(1:end-1);

up_data = interp(data,5);

t2 = 0:1/(fs*5):length(up_data)/(fs*5);t2 = t2(1:end-1);

%% High pass filter

y = HighPassFilter(up_data, 1, 1000, fs*5);

%% create ensemble of motor units
peaks = round(peaks,4);
t2 = round(t2,5)';

%% switch calculate condition
switch (case_condition)
      
    case 1 %ensemble motion units unshifted
        for i = 1:length(peaks)
         x = find(t2 == peaks(i));
         ensemble(i,:) = y(x-window:x+window)';
         end
    
    case 2 %ensemble motion units shifted
     for i = 1:length(peaks)
        x = find(t2 == peaks(i));
        [~,x2]=max(y(x-window:x+window));
        x2=x2-window;
        ensemble(i,:)=y(x+x2-window:x+x2+window);
    end
end

end

