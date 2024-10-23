function r = x0(h, units, position)
%X0 returns the position of the left edge of a graphical element.
%
% R = X0(H) is the distance from the inner left edge of the parent
%  container to the outer left edge of the graphical element H in the units
%  of H. 
%
% R = X0(H, UNITS) is in UNITS. All valid units for H can be used
%  (e.g., 'pixels', 'normalized', 'characters').
%
% R = X0(H, [], POSITION) returns POSITION = 'Position' (default),
%  'InnerPosition' or 'OuterPosition' in the units of H.
%
% R = X0(H, UNITS, POSITION) returns the selected POSITION in UNITS.
%
% R = X0(0, UNITS) applies to the screen (0 is the root graphical
%  element) in UNITS. POSITION is automatically set to 'ScreenSize'.
% 
% See also y0, w, h.

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
r = r(1);

end
