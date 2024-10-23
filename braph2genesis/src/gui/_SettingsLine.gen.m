%% ¡header!
SettingsLine < Settings (st, line settings) contains the line settings.

%%% ¡description!
A Line Settings (SettingsSymbol) provides the settings for a line, 
 including visibility, x, y, z, line color, line width, line style, 
 symbol marker, symbol size, symbol face color, and symbol edge color.
The handle must be a line.

%%% ¡seealso!
line, PanelFig, GUIFig, check_graphics

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the line settings.
%%%% ¡default!
'SettingsLine'

%%% ¡prop!
NAME (constant, string) is the name of the line settings.
%%%% ¡default!
'Line Settings'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the line settings.
%%%% ¡default!
'A Line Settings (SettingsSymbol) provides the settings for a line, including visibility, x, y, z, line color, line width, line style, symbol marker, symbol size, symbol face color, and symbol edge color. The handle must be a line.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the line settings.
%%%% ¡settings!
'SettingsLine'

%%% ¡prop!
ID (data, string) is a few-letter code for the line settings.
%%%% ¡default!
'SettingsLine ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the line settings.
%%%% ¡default!
'SettingsLine label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the line settings.
%%%% ¡default!
'SettingsLine notes'

%% ¡props!

%%% ¡prop!
VISIBLE (figure, logical) determines whether the symbol is visible.
%%%% ¡default!
true
%%%% ¡postprocessing!
h = st.get('H');
if check_graphics(h, 'line') && ( ...
        get(h, 'Visible') ~= st.get('VISIBLE') || ...
        ~isequal(get(h, 'XData'), st.get('X')) || ...
        ~isequal(get(h, 'YData'), st.get('Y')) || ...
        ~isequal(get(h, 'ZData'), st.get('Z')) || ...
        ~isequal(get(h, 'Color'), st.get('LINECOLOR')) || ...
        ~isequal(get(h, 'LineStyle'), st.get('LINESTYLE')) || ...
        get(h, 'LineWidth') ~= st.get('LINEWIDTH') || ...
        ~isequal(get(h, 'Marker'), regexprep(st.get('SYMBOL'), 'none', '')) || ...
        get(h, 'MarkerSize') ~= st.get('SYMBOLSIZE') || ...
        ~isequal(get(h, 'MarkerEdgeColor'), st.get('EDGECOLOR')) || ...
        ~isequal(get(h, 'MarkerFaceColor'), st.get('FACECOLOR')) ...
        )
    if st.get('VISIBLE')
        set(h, ...
            'XData', st.get('X'), ...
            'YData', st.get('Y'), ...
            'ZData', st.get('Z'), ...
            'Color', st.get('LINECOLOR'), ...
            'LineStyle', st.get('LINESTYLE'), ...
            'LineWidth', st.get('LINEWIDTH'), ...
            'Marker', st.get('SYMBOL'), ...
            'MarkerSize', st.get('SYMBOLSIZE'), ...
            'MarkerEdgeColor', st.get('EDGECOLOR'), ...
            'MarkerFaceColor', st.get('FACECOLOR'), ...
            'Visible', true ...
            )
    else
        set(h, 'VISIBLE', false)
    end
end

%%% ¡prop!
X (figure, rvector) is the vector of the x-coordinates.
%%%% ¡conditioning!
value = value(:)';

%%% ¡prop!
Y (figure, rvector) is the vector of the y-coordinates.
%%%% ¡conditioning!
value = value(:)';

%%% ¡prop!
Z (figure, rvector) is the vector of the z-coordinates.
%%%% ¡conditioning!
value = value(:)';

%%% ¡prop!
LINESTYLE (figure, line) is the line style.

%%% ¡prop!
LINEWIDTH (figure, size) is the line width.

%%% ¡prop!
LINECOLOR (figure, color) is the line RGB color.
%%%% ¡default!
[0 0 0]

%%% ¡prop!
SYMBOL (figure, marker) is the symbol style.

%%% ¡prop!
SYMBOLSIZE (figure, size) is the symbol size.
%%%% ¡default!
10

%%% ¡prop!
EDGECOLOR (figure, color) is the symbol RGB edge color.
%%%% ¡default!
[0 0 0]

%%% ¡prop!
FACECOLOR (figure, color) is the symbol RGB face color.
%%%% ¡default!
BRAPH2.COL