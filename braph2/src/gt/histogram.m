function [count, bins, density] = histogram(A, varargin)
%HISTOGRAM histogram of a matrix
%
% [COUNT,BINS,DENSITY] = HISTOGRAM(A) calculates the histogram of matrix A
%  and finds the frequency of data COUNT in the intervals BINS at which histogram
%  is plotted, and associated DENSITY.
%
% [COUNT,BINS,DENSITY] = HISTOGRAM(A, PROPERTY, VALUE, ...) calculates
%  the histogram of A by using the property PropertyName specified by the
%  PropertyValue. Admissible properties are:
%       bins       -   -1 : .001:1 (default)
%       diagonal   -   'exclude' (default) | 'include'
%
% See also Graph, hist, threshold.

% Bins
bins = get_from_varargin(-1:.001:1, 'bins', varargin{:});

% Diagonal
diagonal = get_from_varargin('exclude', 'diagonal', varargin{:});

% Analysis
if strcmp(diagonal, 'include')
    count = hist(reshape(A, 1, numel(A)), bins); %#ok<HIST>
    density = 1 - cumsum(count) / numel(A);
else
    B = A(~eye(size(A)));
    count = hist(B, bins); %#ok<HIST>
    density = 1 - cumsum(count) / numel(B);
end

density = density * 100;
end