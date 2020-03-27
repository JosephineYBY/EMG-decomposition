function [X] = updateGroups(X,newG,oldG)
%updata all vectors from oldG to newG
for i=1:size(X,2)
    if X(end,i)==oldG
        X(end,i)=newG;
    end
end
end

