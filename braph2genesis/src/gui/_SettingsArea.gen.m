%% ¡header!
SettingsArea < Settings (st, area settings) contains the area settings.

%%% ¡description!
An Area Settings (SettingsArea) provides the settings for a filled area plot,
 including visibility, x, y, z, face color, and face alpha.
The handle must be a patch.

%%% ¡seealso!
patch, PanelFig, GUIFig

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the concrete element.
%%%% ¡default!
'SettingsArea'

%%% ¡prop!
NAME (constant, string) is the name of the area settings.
%%%% ¡default!
'Area Settings'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the area settings.
%%%% ¡default!
'An Area Settings (SettingsArea) provides the settings for a filled area plot, including visibility, x, y, z, face color, and face alpha. The handle must be a patch.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the area settings.
%%%% ¡settings!
'SettingsArea'

%%% ¡prop!
ID (data, string) is a few-letter code for the area settings.
%%%% ¡default!
'SettingsArea ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the area settings.
%%%% ¡default!
'SettingsArea label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the area settings.
%%%% ¡default!
'SettingsArea notes'

%% ¡props!

%%% ¡prop!
VISIBLE (figure, logical) determines whether the symbol is visible.
%%%% ¡default!
true
%%%% ¡postprocessing!
h = st.get('H');
if check_graphics(h, 'patch') && ( ...
        get(h, 'Visible') ~= st.get('VISIBLE') || ...
        ~isequal(get(h, 'XData'), st.get('X')) || ...
        ~isequal(get(h, 'YData'), st.get('Y')) || ...
        ~isequal(get(h, 'ZData'), st.get('Z')) || ...
        ~isequal(get(h, 'FaceColor'), st.get('FACEALPHA')) || ...
        get(h, 'FaceAlpha') ~= st.get('FACEALPHA') || ...
        ~isequal(get(h, 'EdgeColor'), st.get('EDGEALPHA')) || ...
        get(h, 'EdgeAlpha') ~= st.get('EDGEALPHA') ...
        )
    if st.get('VISIBLE')
        set(h, ...
            'XData', st.get('X'), ...
            'YData', st.get('Y'), ...
            'ZData', st.get('Z'), ...
            'FaceColor', st.get('FACECOLOR'), ...
            'FaceAlpha', st.get('FACEALPHA'), ...
            'EdgeColor', st.get('EDGECOLOR'), ...
            'EdgeAlpha', st.get('EDGEALPHA'), ...
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
Y (figure, rvector) is the vector of y-coordinates.
%%%% ¡conditioning!
value = value(:)';

%%% ¡prop!
Z (figure, rvector) is the vector of the z-coordinates.
%%%% ¡conditioning!
value = value(:)';

%%% ¡prop!
FACECOLOR (figure, color) is the symbol RGB face color.
%%%% ¡default!
BRAPH2.COL

%%% ¡prop!
FACEALPHA (figure, scalar) is the symbol RGB face color.
%%%% ¡default!
0.5

%%% ¡prop!
EDGECOLOR (figure, color) is the symbol RGB edge color.
%%%% ¡default!
[0 0 0]

%%% ¡prop!
EDGEALPHA (figure, scalar) is the symbol RGB edge color.
%%%% ¡default!
0