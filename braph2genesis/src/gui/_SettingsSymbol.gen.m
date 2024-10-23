%% ¡header!
SettingsSymbol < Settings (st, symbol settings) contains the symbol settings.

%%% ¡description!
A Symbol Settings (SettingsSymbol) provides the settings for a symbol, 
including visibility, x, y, z, symbol marker, symbol size, face color, and edge color.
The handle can be a line.

%%% ¡seealso!
line, PanelFig, GUIFig, check_graphics

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the symbol settings.
%%%% ¡default!
'SettingsSymbol'

%%% ¡prop!
NAME (constant, string) is the name of the symbol settings.
%%%% ¡default!
'Symbol Settings'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the symbol settings.
%%%% ¡default!
'A Symbol Settings (SettingsSymbol) provides the settings for a symbol, including visibility, x, y, z, symbol marker, symbol size, face color, and edge color.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the symbol settings.
%%%% ¡settings!
'SettingsSymbol'

%%% ¡prop!
ID (data, string) is a few-letter code for the symbol settings.
%%%% ¡default!
'SettingsSymbol ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the symbol settings.
%%%% ¡default!
'SettingsSymbol label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the symbol settings.
%%%% ¡default!
'SettingsSymbol notes'

%% ¡props!

%%% ¡prop!
VISIBLE (figure, logical) determines whether the symbol is visible.
%%%% ¡default!
false
%%%% ¡postprocessing!
h = st.get('H');
if check_graphics(h, 'line') && ( ...
        get(h, 'Visible') ~= st.get('VISIBLE') || ...
        get(h, 'XData') ~= st.get('X') || ...
        get(h, 'YData') ~= st.get('Y') || ...
        get(h, 'ZData') ~= st.get('Z') || ...
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
X (figure, scalar) is the x-coordinate.

%%% ¡prop!
Y (figure, scalar) is the y-coordinate.

%%% ¡prop!
Z (figure, scalar) is the z-coordinate.

%%% ¡prop!
SYMBOL (figure, marker) is the symbol.

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