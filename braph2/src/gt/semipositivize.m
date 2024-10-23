function B = semipositivize(A, varargin)
%SEMIPOSITIVIZE removes the negative values of a matrix
%
% B = SEMIPOSITIVIZE(A) removes the negative weights of the matrix A 
%  using default RULE 'zero'.
%
% B = SEMIPOSITIVIZE(A, 'SemipositivizeRule', RULE) 
%  removes the negative weights of a matrix A using the specified RULE.
%  Admissible RULE options are:
%  RULE = 'zero' (default)  convert negative values to zeros.
%         'absolute'        convert negative values to absolute value.
%
% See also BINARIZE, DEDIAGONALIZE, DIAGONALIZE, STANDARDIZE, SYMMETRIZE.

semipositivize_rule = get_from_varargin('zero', 'SemipositivizeRule', varargin);

switch lower(semipositivize_rule)
    case 'absolute'  % take-absolute-value rule
        B = abs(A);
    otherwise  % 'zero'  % set-to-zero rule
        B = max(A, 0);
end

end
