function [permutation_1, permutation_2] = permutation(values_1, values_2, is_longitudinal)
% PERMUTATION Permutes elements between arrays
%
% [PERMUTATION_1, PERMUTATION_2] = PERMUTATION(VALUES_1, VALUES_2) It
% permutes the elements in numerical arrays or cell arrays VALUES_1 and VALUES_2.
%
% [PERMUTATION_1, PERMUTATION_2] = PERMUTATION(VALUES_1, VALUES_2, IS_LONGITUDINAL) 
% It longitudinally permutes the elements between VALUES_1 and VALUES_2.
% The dimension of VALUES_1 and VALUES_2 must be the same. 

if nargin < 3
    is_longitudinal = false;
end

if is_longitudinal
    assert(isequal(numel(values_1), numel(values_2)), ...
        [BRAPH2.STR ':Permutation:' BRAPH2.WRONG_INPUT], ...
        'Value_1 must be the same size as Value_2')
    
    permutation = sign(randn(1, numel(values_1)));
    permutation_1 = values_1;
    permutation_2 = values_2;
    permutation_1(permutation == 1) = values_2(permutation == 1);
    permutation_2(permutation == 1) = values_1(permutation == 1);
else
    N_1 = numel(values_1);
    N_2 = numel(values_2);
    N = N_1 + N_2;

    index_permutation_1 = sort(randperm(N, N_1));

    index_permutation_2 = [1:1:N]; %#ok<NBRAK>
    index_permutation_2(index_permutation_1) = 0;
    index_permutation_2 = index_permutation_2(index_permutation_2 > 0);

    values = [values_1 values_2];
    permutation_1 = reshape(values(index_permutation_1), size(values_1));
    permutation_2 = reshape(values(index_permutation_2), size(values_2));
end

end