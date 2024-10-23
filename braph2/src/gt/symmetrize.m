function B = symmetrize(A, varargin)
%SYMMETRIZE symmetrizes a matrix
%
% B = SYMMETRIZE(A) symmetrizes the matrix A with default RULE 'max'.
%
% B = SYMMETRIZE(A, 'SymmetrizeRule', RULE) symmetrizes the matrix A by the
%  symmetrize rule specified by RULE.
%  Admissible RULE options are:
%  RULE = 'max' (default)   maximum between inconnection and outconnection.
%         'sum'             sum of inconnection and outconnection.
%         'average'         average of inconnection and outconnection.
%         'min'             minimum between inconnection and outconnection.
% 
% See also BINARIZE, DEDIAGONALIZE, DIAGONALIZE, SEMIPOSITIVIZE, STANDARDIZE.

symmetrize_rule = get_from_varargin('max', 'SymmetrizeRule', varargin);

switch lower(symmetrize_rule)
    case 'sum'  % sum rule
        B = A + transpose(A);
    case 'average'  % average rule
        B = (A + transpose(A)) / 2;
    case 'min'  % minimum rule
        B = min(A, transpose(A));
    otherwise  % 'max'  % maximum rule
        B = max(A, transpose(A));
end

end
