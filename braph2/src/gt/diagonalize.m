function B = diagonalize(A, varargin)
%DIAGONALIZE removes the off-diagonal values of a matrix
%
% B = DIAGONALIZE(A) removes the off-diagonal values of the matrix A 
%  and sets them to 0.
%
% B = DIAGONALIZE(A, 'DiagonalizeRule', VALUE) removes the off-diagonal
%  values of the matrix A and sets them to VALUE.
%
% See also BINARIZE, DEDIAGONALIZE, SEMIPOSITIVIZE, STANDARDIZE, SYMMETRIZE.

value = get_from_varargin(0, 'DiagonalizeRule', varargin{:});

B = value * ones(size(A));
B(1:length(B)+1:end) = A(1:length(A)+1:end);

end