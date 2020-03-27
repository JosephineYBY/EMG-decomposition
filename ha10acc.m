function Acc = ha10acc(Sp)
%
%  Acc = ha10acc(Sp)
%
% Given the Sp structure created by eaf_compare, this function computes
% the "overall" accuracy (Acc).  Overall accuracy is defined as the number
% of CORRECTLY identified motor units from MATCHED motor units, divided
% by the total number of spikes listed in Sp.Confuse.  Test spikes that are
% paired with truth spikes in motor units that are not considered
% matched are considered errors.  Unmatched test spikes (false positives)
% are errors as well as unmatched truth spikes (false negatives).

% Sp.MUmap contains a vector in which the m-th  element in MUmap lists the
%   truth MU index (row index) of the MU match within Sp.Confuse.
%   Unmapped test MUs are assigned NaN.

Hit = 0;  % Null initialize sum of hits.

for m = 1:length(Sp.MUmap)  % Check each test MU to see if it is matched.
  if ~isnan(Sp.MUmap(m))    % If matched, sum the "hits".
    Hit = Hit + Sp.Confuse(Sp.MUmap(m), m);
  end
end
                                 % Divide total hits by total Sp.Confuse
Acc = Hit / sum(Sp.Confuse(:));  %   entries.

return
