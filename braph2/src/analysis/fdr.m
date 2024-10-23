function [r, mask] = fdr(pvalues, q)
% FDR False discovery rate
%
% R = FDR(PVALUES, Q) calculates the false discovery rate (FDR) for PVALUES.
% Q is a threshold parameter, typically equal to 0.01, 0.05 or 0.10. 
% All PVALUES < R are considered significant. 
% The value of R is set as the maximum p-value that satifies P <= (i/m)Q,
% where i is the rank of the test, m is the number of tests, and Q is the
% threshold parameter.
%
% R = FDR(PVALUES) calculates the false discovery rate for PVALUES with
% defult q parameter set to 0.05.
%
% [R, MASK] = FDR(PVALUES, Q) returns also the logical array MASK, 
% which is true for the p-values that pass the test, and false for the
% p-values that do not pass the test.
%
% See also bonferroni, pvalue1, pvalue2, quantiles.

% q value [default = .05]
if nargin < 2
    q = .05;
else
    assert(q > 0 && q <= 1, ...
        [BRAPH2.STR ':fdr:' BRAPH2.WRONG_INPUT], ...
        'Q must be a real number in (0, 1]')
end

x = [1:1:length(pvalues)] / length(pvalues); %#ok<NBRAK>
tmp_pvalues = pvalues;
tmp_pvalues = sort(tmp_pvalues);
index = max(find(tmp_pvalues <= (x * q))); %#ok<MXFND>

if index
    r = tmp_pvalues(index);
else
    r = 0;
end

mask  = pvalues <= r;