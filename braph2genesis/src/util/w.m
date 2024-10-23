function r = w(h, units, position)
%W returns the width of a graphical element.
%
% R = W(H) is the distance between the right and left outer edges of the
%  graphical element H in the units of H.
%
% R = W(H, UNITS) is in UNITS. All valid units for H can be used
%  (e.g., 'pixels', 'normalized', 'characters').
%
% R = W(H, [], POSITION) returns POSITION = 'Position' (default),
%  'InnerPosition' or 'OuterPosition' in the units of H.
%
% R = W(H, UNITS, POSITION) returns the selected POSITION in UNITS.
%
% R = W(0, UNITS) applies to the screen (0 is the root graphical
%  element) in UNITS. POSITION is automatically set to 'ScreenSize'.
%
% See also x0, y0, h.

if nargin < 3
    position = 'Position';
end
if nargin < 2
    units = [];
end

if h == 0 % screen (root graphical element)
    position = 'ScreenSize';
end

if isempty(units)
    r = get(h, position);
else
    backup_units = get(h, 'Units');
    set(h, 'Units', units)
    r = get(h, position);
    set(h, 'Units', backup_units);
end
r = r(3);

end
