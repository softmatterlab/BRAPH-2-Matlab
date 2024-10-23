%% ¡header!
SettingsSphere < SettingsSurface (st, sphere settings) contains the sphere settings.

%%% ¡description!
A Sphere Settings (SettingsSphere) provides the settings for a sphere, 
 including visibility, x, y, z, radius, face color and alpha, edge color and alpha.
The handle can be either a patch or a surface.

%%% ¡seealso!
patch, surface, PanelFig, GUIFig, check_graphics

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the sphere settings.
%%%% ¡default!
'SettingsSphere'

%%% ¡prop!
NAME (constant, string) is the name of the sphere settings.
%%%% ¡default!
'Sphere Settings'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the sphere settings.
%%%% ¡default!
'A Sphere Settings (SettingsSphere) provides the settings for a sphere, including visibility, x, y, z, radius, face color and alpha, edge color and alpha.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the sphere settings.
%%%% ¡settings!
'SettingsSphere'

%%% ¡prop!
ID (data, string) is a few-letter code for the sphere settings.
%%%% ¡default!
'SettingsSphere ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the sphere settings.
%%%% ¡default!
'SettingsSphere label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the sphere settings.
%%%% ¡default!
'SettingsSphere notes'

%% ¡props!

%%% ¡prop!
VISIBLE (figure, logical) determines whether the sphere is visible.
%%%% ¡defaul!
false
%%%% ¡postprocessing!
h = st.get('H');
if (check_graphics(h, 'patch') || check_graphics(h, 'surface')) && ( ...
        get(h, 'Visible') ~= st.get('VISIBLE') || ...
        ~isequal(get(h, 'UserData'), [st.get('X') st.get('Y') st.get('Z') st.get('SPHERESIZE')]) ...
        )
    if st.get('VISIBLE')
        [sx, sy, sz] = sphere();
        set(h, ...
            'XData', st.get('X') + st.get('SPHERESIZE') * sx, ...
            'YData', st.get('Y') + st.get('SPHERESIZE') * sy, ...
            'ZData', st.get('Z') + st.get('SPHERESIZE') * sz, ...
            'UserData', [st.get('X') st.get('Y') st.get('Z') st.get('SPHERESIZE')], ...
            'Visible', true ...
            )
    else
        set(h, 'Visible', false)
    end
end

%%% ¡prop!
X (figure, scalar) is the x-coordinate.

%%% ¡prop!
Y (figure, scalar) is the y-coordinate.

%%% ¡prop!
Z (figure, scalar) is the z-coordinate.

%%% ¡prop!
SPHERESIZE (figure, size) is the sphere size.
%%%% ¡default!
5