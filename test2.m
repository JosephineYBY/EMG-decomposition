clc;clear all;
data=tread_wfdb('R00108_6.dat');
unsample_data=interp(data,5);
[b,a]=butter(2,1000/(500000/2),'high');
filtered_data=filtfilt(b,a,unsample_data);
[peak_amp_time] = detect_true_peaks(data);
dt=6/500000;
true=load_eaf('R00108_6truth.eaf');
act_time=[];
count=[];

for i=1:length(true.time)
n=round(true.time(i)*10000);
amp_int=filtered_data(n);
count=[count; n amp_int];
end

amp=count(:,2);

j=1;index=[];
%%%%%%%%%calculate different power of each pass %%%%%%%%%%%%%%%%%%%%%%%%%
for x=1:length(amp)
L=length(amp);
Er=zeros(L-1,length(amp(1,j)));
sum=zeros(1,L-1);
P=zeros(length(count),(length(amp(1,:))).^2);
for n=1:L-1
    sum=zeros(1,length(L-1));
    for k=n:L-1
        s=0;
        for i=1:length(amp(1,:))
            Er(k,i)=(amp(n,i)-amp(k+1,i)).^2;
            s=s+Er(k,i);
        end
         sum(k+1)=s;
    end
    value=min(sum(sum>0));
    indx=find(sum==value);
        if length(indx)>1
            indx=indx(1);
        end
        
    
    
    for j=1:2*i
       
        if(j<i)||(j==i)
            P(n,j)=amp(n,j);
        else
            if (j>i)||(j==2*i)
                P(n,j)=amp(indx,j-i);
            end
        end
    end 
    
    
end

amp=P;
end



