%% ¡header!
SettingsSurface < Settings (st, surface settings) contains the surface settings.

%%% ¡description!
A Surface Settings (SettingsSurface) provides the settings for a surface, 
 including face color, face alpha, edge color, and edge alpha.
The handle can be either a patch or a surface.

%%% ¡seealso!
patch, surface, SettingsSurfacePP, PanelFig, GUIFig, check_graphics

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the surface settings.
%%%% ¡default!
'SettingsSurface'

%%% ¡prop!
NAME (constant, string) is the name of the surface settings.
%%%% ¡default!
'Surface Settings'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the surface settings.
%%%% ¡default!
'A Surface Settings (SettingsSurface) provides the settings for a surface, including face color, face alpha, edge color, and edge alpha.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the surface settings.
%%%% ¡settings!
'SettingsSurface'

%%% ¡prop!
ID (data, string) is a few-letter code for the surface settings.
%%%% ¡default!
'SettingsSurface ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the surface settings.
%%%% ¡default!
'SettingsSurface label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the surface settings.
%%%% ¡default!
'SettingsSurface notes'

%% ¡props!

%%% ¡prop!
EDGECOLOR (figure, color) is the RGB edge color.
%%%% ¡default!
[0 0 0]
%%%% ¡postset!
h = st.get('H');
if check_graphics(h, 'patch') || check_graphics(h, 'surface')
    set(h, 'EdgeColor', st.get('EDGECOLOR'))
end

%%% ¡prop!
EDGEALPHA (figure, alpha) is the edge transparency.
%%%% ¡default!
0
%%%% ¡postset!
h = st.get('H');
if check_graphics(h, 'patch') || check_graphics(h, 'surface')
    set(h, 'EdgeAlpha', st.get('EDGEALPHA'))
end

%%% ¡prop!
FACECOLOR (figure, color) is the RGB face color.
%%%% ¡default!
[.5 .5 .5]
%%%% ¡postset!
h = st.get('H');
if check_graphics(h, 'patch') || check_graphics(h, 'surface')
    set(h, 'FaceColor', st.get('FACECOLOR'))
end

%%% ¡prop!
FACEALPHA (figure, alpha) is the face transparency.
%%%% ¡default!
.5
%%%% ¡postset!
h = st.get('H');
if check_graphics(h, 'patch') || check_graphics(h, 'surface')
    set(h, 'FaceAlpha', st.get('FACEALPHA'))
end