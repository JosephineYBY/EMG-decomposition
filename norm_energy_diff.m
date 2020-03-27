function e_diff = norm_energy_diff(x,y)
% function to calculate normalized energy difference between motor units

%% normalized energy difference
num = sum((x-y).^2);
den = sum(x.^2) + sum(y.^2);
e_diff = num/den;
end

