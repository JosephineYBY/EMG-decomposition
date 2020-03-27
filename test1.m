clear all; clc;
data=tread_wfdb('R00108_6.dat');
unsample_data=interp(data,5);
[b,a]=butter(2,1000/(500000/2),'high');
filtered_data=filtfilt(b,a,unsample_data);

true=load_eaf('R00108_6truth.eaf');

act_time=[];
count=[];

for i=1:length(true.time)
n=round(true.time(i)*10000);
amp_int=filtered_data(n);
count=[count; amp_int  n];
end
ind=find(count(:,1)>0);
amp=count(ind,1);
amp_thre=(max(amp)+min(amp))/(max(amp)-min(amp));



for n=1:length(true.time)
for i=-40:40 
    k=i+count(n,2);
    if (filtered_data(k+1)<filtered_data(k))&&(filtered_data(k-1)<filtered_data(k))&&(filtered_data(k)>amp_thre)
    true_amp=filtered_data(k);
    act_time=[act_time; k true_amp];   
    end
end
end



















