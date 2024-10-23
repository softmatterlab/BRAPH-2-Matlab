function check = check_graphics(h, type)
%CHECK_GRAPHICS returns whether a handle is a graphic obejct/error.
%
% CHECK = CHECK_GRAPHICS(H) returns whether the H is a graphic object.
%
% CHECK = CHECK_GRAPHICS(H, TYPE) returns whether the H is a graphic object 
%  of the kind TYPE:
%  'figure', 'uimenu', 'uitoolbar', 'uipushtool', 'uitoggletool',
%  'uipanel', 'uigridlayout', 'axes', 'uitable', 'uicontextmenu',
%  'uibutton', 'uilabel', 'uieditfield', 'uitextarea', 'uicheckbox',
%  'uidropdown', 'uislider', 'uilistbox'.
%  'text', 'line', 'surface', 'patch', 'light'.
%
% CHECK_GRAPHICS(H[, TYPE]) throws an error if H is not a correct graphic object.
%  Error id: BRAPH2:Format:WrongInput
%
% See also isgraphics.

if nargin < 2
    type = [];
end

if nargout == 1
    if isempty(type)
        check = isgraphics(h);
    else
        switch type
            case 'figure'
                check = ~isempty(h) && isgraphics(h) && isgraphics(h, 'figure');
            case 'uimenu'
                check = ~isempty(h) && isgraphics(h, 'uimenu');
            case 'uitoolbar'
                check = ~isempty(h) && isgraphics(h, 'uitoolbar');
            case 'uipushtool'
                check = ~isempty(h) && isgraphics(h, 'uipushtool');
            case 'uitoggletool'
                check = ~isempty(h) && isgraphics(h, 'uitoggletool');
            case 'uipanel'
                check = ~isempty(h) && isgraphics(h, 'uipanel');
            case 'uigridlayout'
                check = ~isempty(h) && isgraphics(h, 'uigridlayout');
            case 'axes'
                check = ~isempty(h) && isgraphics(h, 'axes');
            case 'uitable'
                check = ~isempty(h) && isgraphics(h, 'uitable');
            case 'uicontextmenu'
                check = ~isempty(h) && isgraphics(h, 'uicontextmenu');
            case 'uibutton'
                check = ~isempty(h) && isgraphics(h, 'uibutton');
            case 'uilabel'
                check = ~isempty(h) && isgraphics(h, 'uilabel');
            case 'uieditfield'
                check = ~isempty(h) && isgraphics(h, 'uieditfield');
            case 'uitextarea'
                check = ~isempty(h) && isgraphics(h, 'uitextarea');
            case 'uicheckbox'
                check = ~isempty(h) && isgraphics(h, 'uicheckbox');
            case 'uidropdown'
                check = ~isempty(h) && isgraphics(h, 'uidropdown');
            case 'uislider'
                check = ~isempty(h) && isgraphics(h, 'uislider');
            case 'uilistbox'
                check = ~isempty(h) && isgraphics(h, 'uilistbox');
            case 'text'
                check = ~isempty(h) && isgraphics(h, 'text');
            case 'line'
                check = ~isempty(h) && isgraphics(h, 'line');
            case 'surface'
                check = ~isempty(h) && isgraphics(h, 'surface');
            case 'patch'
                check = ~isempty(h) && isgraphics(h, 'patch');
            case 'light'
                check = ~isempty(h) && isgraphics(h, 'light');
            otherwise
                error( ...
                    [BRAPH2.STR ':check_graphics:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':check_graphics:' BRAPH2.WRONG_INPUT '\n' ...
                    '''' type ''' is not an allowed graphic object type.'] ...
                    )
        end
    end
else
    assert( ...
        check_graphics(h, type), ...
        [BRAPH2.STR ':check_graphics:' BRAPH2.WRONG_INPUT], ...
        [BRAPH2.STR ':check_graphics:' BRAPH2.WRONG_INPUT '\n' ...
        'The handle ' tostring(h) ' is not a valid graphic object. '] ...
        )
end

end