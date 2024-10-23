function P1 = pvalue1(observed_difference, random_differences)
% PVALUE1 Calculates the one-tailed p-value
%
% P1 = PVALUE1(OBSERVED_DIFFERENCE, RANDOM_DIFFERENCES) calculates the
% one-tailed P-value of OBSERVED_DIFFERENCE with respect to the
% distribution given by RANDOM_DIFFERENCES.
% 
% This function admits various kinds of inputs:
%
% 1) OBSERVED_DIFFERENCE is a scalar, a vector or a matrix with the difference.
% RANDOM_DIFFERENCES must be a cell array of samples, where each cell contains a
% scalar, a vector or a matrix with random variables.
% P1 is a scalar, a vector or a matrix with the one-sided p-values.
%
% 2) OBSERVED_DIFFERENCE is a cell containing a scalar, a vector or a
% matrix with the difference.
% RANDOM_DIFFERENCES must be a cell array of samples, where each cell contains a
% scalar, a vector or a matrix with random variables.
% P1 is a cell containing a scalar, a vector or a matrix with the one-sided
% p-values. 
% 
% 3) OBSERVED_DIFFERENCE is a cell containing multiple scalar, vectors or
% matrices with the difference.
% RANDOM_DIFFERENCES must be a cell array of with the same format as
% OBSERVED_DIFFERENCE.
% P1 is a cell array of with the same format as OBSERVED_DIFFERENCE with
% the one-sided p-values.
%
% See also pvalue2, quantiles, fdr, bonferroni.

if ~iscell(observed_difference)
    P1 = for_pvalue1(observed_difference, random_differences);
elseif iscell(observed_difference) && numel(observed_difference) == 1
    P1 = {for_pvalue1(observed_difference{1}, random_differences)};
else  % cell with more than one element
    P1 = cell(size(observed_difference));
    for r = 1:1:size(observed_difference, 1)
        for c = 1:1:size(observed_difference, 2)
            P1(r, c) = {for_pvalue1(observed_difference{r, c}, ...
                cellfun(@(x) x{r, c}, random_differences, 'UniformOutput', false))};
        end
    end
end

    function P1 = for_pvalue1(observed_difference, random_differences)
        
        M = numel(random_differences); %#ok<NASGU>  % number of samples (per variable)
        
        row_number = size(random_differences{1}, 1);
        column_number = size(random_differences{1}, 2);
        d_number = size(random_differences{1}, 3);  % add the 3rd dimension 
        
        Q = cell(row_number, column_number, d_number); %#ok<NASGU>
        P1 = zeros(row_number, column_number, d_number);
        for i = 1:1:row_number
            for j = 1:1:column_number
                for k = 1:1:d_number
                    current_observed_difference = observed_difference(i, j, k);
                    current_random_differences = cellfun(@(x) x(i, j, k), random_differences);

                    if current_observed_difference > 0
                        P1(i, j, k) =  ...
                            length(find(current_random_differences > current_observed_difference)) ...
                            / ...
                            length(current_random_differences);
                    else  % current_observed_difference <= 0
                        P1(i, j, k) =  ...
                            length(find(current_random_differences < current_observed_difference)) ...
                            / ...
                            length(current_random_differences);
                    end
                    
                    if P1(i, j, k) == 0
                        P1(i, j, k) = .5 * length(current_random_differences)^-1;
                    end
                    
                    % deals with case without differences
                    if current_observed_difference == mean(current_random_differences)
                        P1(i, j, k) = 1;
                    end
                end
            end
        end
    end
end