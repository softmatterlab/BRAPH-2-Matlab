%% ¡header!
SettingsText < Settings (st, text settings) contains the text settings.

%%% ¡description!
A Text Settings (SettingsText) provides the settings for a text, 
including visibility, x, y, z, font color, font size, and interpreter.
The handle can be a text.

%%% ¡seealso!
text, PanelFig, GUIFig, check_graphics

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the text settings.
%%%% ¡default!
'SettingsText'

%%% ¡prop!
NAME (constant, string) is the name of the text settings.
%%%% ¡default!
'Text Settings'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the text settings.
%%%% ¡default!
'A Text Settings (SettingsText) provides the settings for a text, including visibility, x, y, z, font color, font size, and interpreter.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the text settings.
%%%% ¡settings!
'SettingsText'

%%% ¡prop!
ID (data, string) is a few-letter code for the text settings.
%%%% ¡default!
'SettingsText ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the text settings.
%%%% ¡default!
'SettingsText label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the text settings.
%%%% ¡default!
'SettingsText notes'

%% ¡props!

%%% ¡prop!
VISIBLE (figure, logical) determines whether the text is visible.
%%%% ¡defaul!
false
%%%% ¡postprocessing!
h = st.get('H');
if check_graphics(h, 'text') && ( ...
        get(h, 'Visible') ~= st.get('VISIBLE') || ...
        ~isequal(get(h, 'Position'), [st.get('X') st.get('Y') st.get('Z')]) || ...
        ~isequal(get(h, 'String'), st.get('TXT')) || ...
        get(h, 'FontSize') ~= st.get('FONTSIZE') || ...
        ~isequal(get(h, 'FontName'), st.get('FONTNAME')) || ...
        ~isequal(get(h, 'Color'), st.get('FONTCOLOR')) || ...
        ~isequal(get(h, 'FontWeight'), st.get('FONTWEIGHT')) || ...        
        ~isequal(get(h, 'Interpreter'), st.get('INTERPRETER')) || ...
        ~isequal(get(h, 'HorizontalAlignment'), st.get('HALIGN')) || ...
        ~isequal(get(h, 'VerticalAlignment'), st.get('VALIGN')) || ...
        get(h, 'Rotation') ~= st.get('ROTATION') ...
        )
    if st.get('VISIBLE')
        set(h, ...
            'Position', [st.get('X') st.get('Y') st.get('Z')], ...
            'String', st.get('TXT'), ...
            'FontSize', st.get('FONTSIZE'), ...
            'FontName', st.get('FONTNAME'), ...
            'Color', st.get('FONTCOLOR'), ...
            'FontWeight', st.get('FONTWEIGHT'), ...
            'Interpreter', st.get('INTERPRETER'), ...
            'HorizontalAlignment', st.get('HALIGN'), ...
            'VerticalAlignment', st.get('VALIGN'), ...
            'Rotation', st.get('ROTATION'), ...
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
TXT (figure, string) is the text.

%%% ¡prop!
FONTSIZE (figure, size) is the font size.
%%%% ¡default!
BRAPH2.FONTSIZE

%%% ¡prop!
FONTNAME (figure, string) is the font name.
%%%% ¡default!
'Helvetica'

%%% ¡prop!
FONTCOLOR (figure, color) is the text color.
%%%% ¡default!
[0 0 0]

%%% ¡prop!
FONTWEIGHT (figure, option) is the font weight.
%%%% ¡settings!
{'normal' 'bold'}
%%%% ¡default!
'normal'

%%% ¡prop!
INTERPRETER (figure, option) is the text interpreter.
%%%% ¡settings!
{'none', 'TeX', 'LaTeX'}
%%%% ¡default!
'none'

%%% ¡prop!
HALIGN (figure, option) is the text horizonthal alignment.
%%%% ¡settings!
{'left', 'center', 'right'}

%%% ¡prop!
VALIGN (figure, option) is the text vertical alignment.
%%%% ¡settings!
{'middle', 'top', 'bottom', 'baseline', 'cap'}

%%% ¡prop!
ROTATION (figure, scalar) is the text rotation.
