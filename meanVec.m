function [mean] = meanVec(spike_amp,g)
%calculates mean vector for group g in matrix spike_amp
ind=find(spike_amp(end,:)==g);
vectorSum=sum(spike_amp(1:end-1,ind),2);
counts=size(ind,2);
mean=vectorSum./counts;
end

