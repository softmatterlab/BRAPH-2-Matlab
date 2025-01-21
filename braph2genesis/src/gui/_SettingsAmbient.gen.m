%% ¡header!
SettingsAmbient < Settings (st, ambient settings) contains the ambient settings.

%%% ¡description!
An Ambient Settings (SettingsAmbient) provides the settings 
 for the ambient lightning and material, including lighting, material, 
 camlight, shading, and colormap.
The handle can be an axes (uiaxes).

%%% ¡seealso!
uiaxes, SettingsAmbientPP, PanelFig, GUIFig, check_graphics

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the ambient settings.
%%%% ¡default!
'SettingsAmbient'

%%% ¡prop!
NAME (constant, string) is the name of the ambient settings.
%%%% ¡default!
'Ambient Settings'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ambient settings.
%%%% ¡default!
'An Ambient Settings (SettingsAmbient) provides the settings for the ambient lightning and material, including lighting, material, camlight, shading, and colormap. The handle can be an axes (uiaxes).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ambient settings.
%%%% ¡settings!
'SettingsAmbient'

%%% ¡prop!
ID (data, string) is a few-letter code for the ambient settings.
%%%% ¡default!
'SettingsAmbient ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ambient settings.
%%%% ¡default!
'SettingsAmbient label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ambient settings.
%%%% ¡default!
'SettingsAmbient notes'

%% ¡props!

%%% ¡prop!
LIGHTING (figure, option) is the lighting value.
%%%% ¡settings!
{'none' 'phong' 'flat' 'gouraud'}
%%%% ¡default!
'gouraud'
%%%% ¡postset!
a = st.get('H');
if check_graphics(a, 'axes')
    lighting(a, st.get('LIGHTING'))
end

%%% ¡prop!
MATERIAL (figure, option) is the material value.
%%%% ¡settings!
{'shiny' 'dull' 'metal'}
%%%% ¡default!
'shiny'
%%%% ¡postset!
a = st.get('H');
if check_graphics(a, 'axes')
    material(a, st.get('MATERIAL'))
end

%%% ¡prop!
CAMLIGHT (figure, option) is the camlight value.
%%%% ¡settings!
{'none' 'headlight' 'headlight (x2)' 'headlight (x3)' 'right' 'right (x2)' 'right (x3)' 'left' 'left (x2)' 'left (x3)'}
%%%% ¡default!
'headlight (x2)'
%%%% ¡postset!
a = st.get('H');
if check_graphics(a, 'axes')
    delete(findall(a, 'Type', 'light'))    
    switch st.get('CAMLIGHT')
        case 'headlight' 
            camlight(a, 'headlight');
        case 'headlight (x2)'
            camlight(a, 'headlight');
            camlight(a, 'headlight');
        case 'headlight (x3)'
            camlight(a, 'headlight');
            camlight(a, 'headlight');
            camlight(a, 'headlight');
        case 'right'
            camlight(a, 'right');
        case 'right (x2)'
            camlight(a, 'right');
            camlight(a, 'right');
        case 'right (x3)'
            camlight(a, 'right');
            camlight(a, 'right');
            camlight(a, 'right');
        case 'left'
            camlight(a, 'left');
        case 'left (x2)'
            camlight(a, 'left');
            camlight(a, 'left');
        case 'left (x3)'
            camlight(a, 'left');
            camlight(a, 'left');
            camlight(a, 'left');
    end
end

%%% ¡prop!
SHADING (figure, option) is the shading value.
%%%% ¡settings!
{'none' 'interp' 'flat' 'faceted'}
%%%% ¡default!
'none'
%%%% ¡postset!
a = st.get('H');
if check_graphics(a, 'axes')
    if ~strcmpi(st.get('SHADING'), 'none') && ~strcmpi(st.get('COLORMAP'), 'none')
        colormap(a, st.get('COLORMAP'))
        shading(a, st.get('SHADING'))
    end
end

%%% ¡prop!
COLORMAP (figure, option) is the colormap.
%%%% ¡settings!
{'none', 'white', 'parula', 'jet', 'hsv', 'hot', 'cool', 'spring', 'summer', 'autumn', 'winter', 'gray', 'bone', 'copper', 'pink', 'lines', 'colorcube', 'prism', 'flag'}
%%%% ¡default!
'none'
%%%% ¡postset!
a = st.get('H');
if check_graphics(a, 'axes')
    if ~strcmpi(st.get('SHADING'), 'none') && ~strcmpi(st.get('COLORMAP'), 'none')
        colormap(a, st.get('COLORMAP'))
        shading(a, st.get('SHADING'))
    end
end