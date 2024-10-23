function Q = quantiles(values, P)
% QUANTILES Calculates the quantiles of a distribution
%
% Q = QUANTILES(VALUES, P) calculates the P-quantiles of VALUES.
% VALUES must be a cell array of samples, where each cell contains a
% scalar, a vector or a matrix with random variables, or a combination thereof.
% Q is a cell array with the quantiles from 0 to Q, whose format is the
% same as the cells of VALUES.
%
% Q = QUANTILES(VALUES) calculates the percentiles of VALUES. It is
% equivalent to QUANTILES(VALUES, 100).
%
% See also pvalue1, pvalue2, fdr, bonferroni.

% number of bins [default = 100]
if nargin < 2
    P = 100;
else
    P = ceil(abs(P));  % enforces that P is a positive integer
end

if ~iscell(values{1})
    Q = for_quantiles(values, P);
else
    Q = cell(size(values{1}));
    for r = 1:1:size(values{1}, 1)
        for c = 1:1:size(values{1}, 2)
            Q(r, c) = {for_quantiles(cellfun(@(x) x{r, c}, values, 'UniformOutput', false), P)};
        end
    end
end

    function Q = for_quantiles(values, P)
        
        M = numel(values);  %#ok<NASGU> % number of samples (per variable)
        
        row_number = size(values{1}, 1);
        column_number = size(values{1}, 2);
        d_number = size(values{1}, 3);  % add the 3rd dimension 
           
        Q = cell(row_number, column_number);
        for i = 1:1:row_number
            for j = 1:1:column_number
                for t = 1:1:d_number
                    current_values = cellfun(@(x) x(i, j, t), values);
                    Q{i, j, t} = [min(current_values), quantile(current_values, P - 1), max(current_values)];
                end
            end
        end
    end
end
