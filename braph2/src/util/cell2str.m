function str = cell2str(cel)
%CELL2STR transforms a cell array of strings into a string
%
% STR = CELL2STR(CEL) transforms the cell array of strings CEL into a
%  string with each element of CEL on a different line (separator \n).
%  Cel cna be either a row or colum cell array.
%
% See also STR2CELL.

str = sprintf('%s\n', cel{:});
str = str(1:end-1);

end