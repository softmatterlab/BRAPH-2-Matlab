%% ¡header!
SettingsAxis < Settings (st, axis settings) contains the axis settings.

%%% ¡description!
An Axis Settings (SettingsAxis) provides the settings for an axis, 
 including axis color, hold on/off, axis on/off, grid on/off, equal on/off, 
 box on/off, and tight on/off.
The handle can be an axes (uiaxes).

%%% ¡seealso!
uiaxes, SettingsAxisPP, PanelFig, GUIFig, check_graphics

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the axis settings.
%%%% ¡default!
'SettingsAxis'

%%% ¡prop!
NAME (constant, string) is the name of the axis settings.
%%%% ¡default!
'Axis Settings'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the axis settings.
%%%% ¡default!
'An Axis Settings (SettingsAxis) provides the settings for an axis, including axis color, hold on/off, axis on/off, grid on/off, equal on/off, box on/off, and tight on/off. The handle can be an axes (uiaxes).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the axis settings.
%%%% ¡settings!
'SettingsAxis'

%%% ¡prop!
ID (data, string) is a few-letter code for the axis settings.
%%%% ¡default!
'SettingsAxis ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the axis settings.
%%%% ¡default!
'SettingsAxis label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the axis settings.
%%%% ¡default!
'SettingsAxis notes'

%% ¡props!

%%% ¡prop!
AXISCOLOR (figure, color) is the axis background color.
%%%% ¡default!
[1 1 1]
%%%% ¡postset!
a = st.get('H');
if check_graphics(a, 'axes')
    if ~isequal(get(a, 'Color'), st.get('AXISCOLOR'))
        set(a, 'Color', st.get('AXISCOLOR'))
    end
end

%%% ¡prop!
HOLD (figure, logical) determines whether hold is on or off.
%%%% ¡default!
true
%%%% ¡postset!
a = st.get('H');
if check_graphics(a, 'axes')
    if st.get('HOLD')
        hold(a, 'on')
    else
        hold(a, 'off')
    end
end

%%% ¡prop!
GRID (figure, logical) determines whether the grid is shown.
%%%% ¡default!
false
%%%% ¡postset!
a = st.get('H');
if check_graphics(a, 'axes')
    if st.get('GRID')
        grid(a, 'on')
    else
        grid(a, 'off')
    end
end

%%% ¡prop!
AXIS (figure, logical) determines whether the axis is shown.
%%%% ¡default!
true
%%%% ¡postset!
a = st.get('H');
if check_graphics(a, 'axes')
    if st.get('AXIS')
        axis(a, 'on')
    else
        axis(a, 'off')
    end
end

%%% ¡prop!
EQUAL (figure, logical) determines whether the axis are equal.
%%%% ¡default!
true
%%%% ¡postset!
a = st.get('H');
if check_graphics(a, 'axes')
    if st.get('EQUAL')
        daspect(a, [1 1 1])
    else
        daspect(a, 'auto')
    end
end

%%% ¡prop!
TIGHT (figure, logical) determines whether the axis are tight.
%%%% ¡default!
false
%%%% ¡postset!
a = st.get('H');
if check_graphics(a, 'axes')
    if st.get('TIGHT')
        axis(a, 'tight')
    end
end

%%% ¡prop!
BOX (figure, logical) determines whether the axis are boxed.
%%%% ¡default!
false
%%%% ¡postset!
a = st.get('H');
if check_graphics(a, 'axes')
    if st.get('BOX')
        box(a, 'on')
    else
        box(a, 'off')
    end
end