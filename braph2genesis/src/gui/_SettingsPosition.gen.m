%% ¡header!
SettingsPosition < Settings (st, position settings) contains the figure panel position settings.

%%% ¡description!
A Position Settings (SettingsPosition) provides the settings 
 for a posistion settings panel, including autopositioning, x0, y0, height 
 and width.
The handle can be an uipanel.

%%% ¡seealso!
uipanel, SettingsPositionPP, PanelFig, GUIFig, check_graphics

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the position settings.
%%%% ¡default!
'SettingsPosition'

%%% ¡prop!
NAME (constant, string) is the name of the position settings.
%%%% ¡default!
'Posiiton Settings'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the position settings.
%%%% ¡default!
'A Position Settings (SettingsPosition) provides the settings for a posistion settings panel, including autopositioning, x0, y0, height and width. The handle can be an uipanel.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the position settings.
%%%% ¡settings!
'SettingsPosition'

%%% ¡prop!
ID (data, string) is a few-letter code for the position settings.
%%%% ¡default!
'SettingsPosition ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the position settings.
%%%% ¡default!
'SettingsPosition label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the position settings.
%%%% ¡default!
'SettingsPosition notes'

%% ¡props!

%%% ¡prop!
AUTOPOS (figure, logical) determines whether the position is adjusted automatically.
%%%% ¡default!
true
%%%% ¡postset!
p = st.get('H');
if check_graphics(p, 'uipanel')
    if st.get('AUTOPOS')
        set(p, ...
            'Units', 'normalized', ...
            'Position', [0 0 1 1] ...
            )
        set(get(p, 'Parent'), 'Scrollable', 'off')
    else
        set(p, ...
            'Units', 'pixels', ...
            'Position', [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')] ...
            )
        set(get(p, 'Parent'), 'Scrollable', 'on')
    end
end

%%% ¡prop!
X0 (figure, scalar) is the lower left x-coordinate of the panel in pixels.
%%%% ¡default!
1
%%%% ¡postset!
p = st.get('H');
if check_graphics(p, 'uipanel')
    if ~st.get('AUTOPOS')
        set(p, 'Position', [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')])
    end
end

%%% ¡prop!
Y0 (figure, scalar) is the lower-left y-coordinate of the panel in pixels.
%%%% ¡default!
1
%%%% ¡postset!
p = st.get('H');
if check_graphics(p, 'uipanel')
    if ~st.get('AUTOPOS')
        set(p, 'Position', [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')])
    end
end

%%% ¡prop!
WIDTH (figure, size) is the width of the panel in pixels.
%%%% ¡default!
800
%%%% ¡postset!
p = st.get('H');
if check_graphics(p, 'uipanel')
    if ~st.get('AUTOPOS')
        set(p, 'Position', [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')])
    end
end

%%% ¡prop!
HEIGHT (figure, size) is the height of the panel in pixels.
%%%% ¡default!
600
%%%% ¡postset!
p = st.get('H');
if check_graphics(p, 'uipanel')
    if ~st.get('AUTOPOS')
        set(p, 'Position', [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')])
    end
end