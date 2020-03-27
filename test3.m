%load 'performance_35_win';
%load 'performance_35_shift';
%plot(performance_35_win(:,1),performance_35_win(:,2));
%hold on
%plot(performance_35_shift(:,1),performance_35_shift(:,2));
%% Initialization
clc;clear all;
data = tread_wfdb('R00108_6.dat');
    
truth = load_eaf('R00108_6truth.eaf');
peaks = truth.time;

%% Upsample from 10KHz to 50 KHz
fs = 10000;

t = 0:1/fs:length(data)/fs;t = t(1:end-1);

up_data = interp(data,5);
t3 = interp(t,5);
t2 = 0:1/(fs*5):length(up_data)/(fs*5);t2 = t2(1:end-1);

%% High pass filter

y = HighPassFilter(up_data, 1, 1000, fs*5);
%plot(t2,y)

%% create ensemble of motor units

peaks = round(peaks,4);
t2 = round(t2,5)';

window = 45;
ensemble = zeros(length(peaks),window*2+1);

for i = 1:length(peaks)
    x = find(t2 == peaks(i));
   %ensemble(i,:) = y(x-window:x+window)';
   [~,x2]=max(y(x-window:x+window));
   x2=x2-window;
   ensemble(i,:)=y(x+x2-window:x+x2+window);
end




%% HAcluster
AnnTruth=truth;
n=size(ensemble',2);
X=[ensemble';1:n];

means=X(1:end-1,:);
numGroups=n;
compare=[];
distA=Inf(n,n);
k=1;
performance=[];
while numGroups > k
    for i=1:n
        for j=i+1:n
           distA(i,j)=norm_energy_diff(means(:,i),means(:,j));
        end
    end
 %find smallest element from distA
 [~,ind]=min(distA(:));
 [newG,oldG]=ind2sub(size(distA),ind);
 %updata group information
 X=updateGroups(X,newG,oldG);
 %calculate new spike_amp:
 for i=1:n
     if i~=oldG
         means(:,i)=meanVec(X,i);
     else
         means(:,i)=inf(size(X,1)-1,1);
     end
 end
 numGroups=numGroups-1;
 AnnTest.time=truth.time;
 AnnTest.unit=X(end,:)';
 sp=eaf_compare(AnnTruth,AnnTest);
 acc=ha10acc(sp);
 performance=[performance; numGroups acc];
end