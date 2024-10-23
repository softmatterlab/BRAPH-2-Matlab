function B = standardize(A, varargin)
%STANDARDIZE normalizes a matrix
%
% B = STANDARDIZE(A) normalizes the matrix A in order to have its values
%  scaled between 0 and 1 by using the default RULE 'threshold'.
%
% B = STANDARDIZE(A, 'StandardizeRule', RULE) 
%  normalizes the matrix A using the specified RULE.
%  Admissible RULE options are:
%  RULE = 'threshold' (default) normalizes the matrix A following one-rule: 
%                               by converting negative values to zero and
%                               values larger than 1 to 1.
%         'range'               normalizes the matrix A in order to have
%                               values scaled between 0 and 1 by using a
%                               linear function.
%
% See also BINARIZE, DEDIAGONALIZE, DIAGONALIZE, SEMIPOSITIVIZE, SYMMETRIZE.

standardize_rule = get_from_varargin('threshold', 'StandardizeRule', varargin);

switch lower(standardize_rule)
    case 'range'  % scaled interval
        if min(A(:)) ~= max(A(:))
            B = (A - min(A(:))) / (max(A(:)) - min(A(:)));
        else
            B = binarize(A);
        end
    otherwise  % 'threshold'  % one-rule
        B = A;
        B(B < 0) = 0;
        B(B > 1) = 1;
end

end
