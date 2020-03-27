function y = HighPassFilter(data, order, cutoff, fs)
% High-pass filter 

% Input
% data: data to be filtered
% order: order of filter
% cutoff: cutoff frequency
% fs: sampling frequency

% Output
% y: filtered signal

% create filter
[B,A] = butter(order,cutoff /(fs/2),'high');
% use 0 phase filtering to get filtered data
y = filtfilt(B, A,data);
end

