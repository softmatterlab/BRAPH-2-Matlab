function B = dediagonalize(A, varargin)
%DEDIAGONALIZE removes the diagonal values of a matrix
%
% B = DEDIAGONALIZE(A) removes the diagonal values of the matrix A 
%  and sets them to 0.
%
% B = DEDIAGONALIZE(A, 'DediagonalizeRule', VALUE) removes the diagonal
%  values of the matrix A and sets them to VALUE.
%
% See also BINARIZE, DIAGONALIZE, SEMIPOSITIVIZE, STANDARDIZE, SYMMETRIZE.

value = get_from_varargin(0, 'DediagonalizeRule', varargin{:});

B = A;
B(1:length(A)+1:numel(A)) = value;

end
