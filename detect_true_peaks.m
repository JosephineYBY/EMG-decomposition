function [peak_amp_time] = detect_true_peaks(data)
unsample_data=interp(data,5);
[b,a]=butter(2,1000/(500000/2),'high');
filtered_data=filtfilt(b,a,unsample_data);
true=load_eaf('R00108_6truth.eaf');
peak_amp_time=[];
count=[];

for i=1:length(true.time)
n=round(true.time(i)*10000);
amp_int=filtered_data(n);
count=[count; amp_int  n];
end

ind=find(count(:,1)>0);
amp=count(ind,1);
amp_thre=(max(amp)+min(amp))/5;

for i=2:length(filtered_data)-1
if (filtered_data(i)>amp_thre)&&(filtered_data(i+1)<filtered_data(i))&&(filtered_data(i-1)<filtered_data(i))
    true_amp=filtered_data(i);
    peak_amp_time=[peak_amp_time; i true_amp];   
end
end

end

