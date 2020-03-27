function [X,performance] = HAcluster(ensemble,truth,k)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%input: ensemble-motion units in the length of window(matrix size=508templates*the length of window)
%truth-truth file contains truth.time and truth.unit
%k-the number of iterations
%output:X-508 templates after clustering
%peformance-the accuracy compared with the truth.unit
%%%%%Hierarchical clustering for data matrix,spike power
n=size(ensemble',2);
X=[ensemble'; 1:n];

amp=X(1:end-1,:);
numGroups=n;

distA=Inf(n,n);
performance=[];
while numGroups > k
    for i=1:n
        for j=i+1:n
           distA(i,j)=norm_energy_diff(amp(:,i),amp(:,j));
           %distA(i,j)=distance(amp(:,i),amp(:,j));
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
         amp(:,i)=meanVec(X,i);
     else
         amp(:,i)=inf(size(X,1)-1,1);
     end
 end
 numGroups=numGroups-1;
 AnnTest.time=truth.time;
 AnnTest.unit=X(end,:)';
 AnnTrue=truth;
sp=eaf_compare(AnnTrue,AnnTest);
acc=ha10acc(sp);
performance=[performance; numGroups acc];
end

end

