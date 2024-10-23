function r = s(x)
%S returns the pixel size corresponding to a fontsize multiple.
%
% SIZE = S(X) is the the size in pixels corresponding to X fontsize,
%  calculated as 
%   SIZE = ceil(X * BRAPH2.FONTSIZE * BRAPH2.S)
%
% See also BRAPH2, ceil.

r = ceil(x * BRAPH2.FONTSIZE * BRAPH2.S);

end
