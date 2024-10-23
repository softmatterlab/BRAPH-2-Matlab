function [r, mask] = bonferroni(pvalues, p)
% BONFERRONI Bonferroni correction
%
% R = BONFERRONI(PVALUES, P) calculates the Bonferroni correction for PVALUES.
% P is the starting p-value.
%
% [R, MASK] = BONFERRONI(PVALUES, P) returns also the logical array MASK, 
% which is true for the p-values that pass the test, and false for the
% p-values that do not pass the test.
%
% See also fdr, pvalue1, pvalue2, quantiles.

r = p / length(pvalues);

mask = pvalues <= r;