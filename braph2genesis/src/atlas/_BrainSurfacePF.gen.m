%% ¡header!
BrainSurfacePF < PanelFig (pf, panel figure for brain surface) is a panel figure that manages the plot of a brain surfce.

%%% ¡description!
A Panel Figure for Brain Surface (BrainSurfacePF) manages the plot of the 
 brain surface choosen by the user. 
BrainSurfacePF provides the common methods needed to manage the plot of 
 the surface. In particular, the user can change lighting, material, 
 camlight, shadning, colormap, facecolor, brain color, face color, 
 edge color, and background color. 
A collection of brain surfaces in NV format can be found in the folder 
 ./braph2/brainsurfs/.

%%% ¡seealso!
BrainSurface

%%% ¡build!
1

%% ¡constants!

% fixed 3d view
VIEW_3D	= 1 % 3D view numeric code
VIEW_3D_CMD = '3D' % 3D view name
VIEW_3D_AZEL = [-37.5 30] % 3D view azimutal and polar angles

% sagittal left view
VIEW_SL	= 2 % sagittal left view numeric code
VIEW_SL_CMD = 'Sagittal left' % sagittal left view name
VIEW_SL_AZEL = [-90 0] % sagittal left view azimutal and polar angles

% sagittal right view
VIEW_SR	= 3 % sagittal right view numeric code
VIEW_SR_CMD = 'Sagittal right' % sagittal right view name
VIEW_SR_AZEL = [90 0] % sagittal right view azimutal and polar angles 

% axial dorsal view
VIEW_AD = 4 % axial dorsal view numeric code
VIEW_AD_CMD = 'Axial dorsal' % axial dorsal view name
VIEW_AD_AZEL = [0 90] % axial dorsal view azimutal and polar angles

% axial ventral view
VIEW_AV = 5 % axial ventral view numeric code
VIEW_AV_CMD = 'Axial ventral' % axial ventral view name
VIEW_AV_AZEL = [0 -90] % axial ventral view azimutal and polar angles

% coronal anterior view
VIEW_CA = 6 % coronal anterior view numeric code
VIEW_CA_CMD = 'Coronal anterior' % coronal anterior view name
VIEW_CA_AZEL = [180 0] % coronal anterior view azimutal and polar angles

% coronal posterior view
VIEW_CP = 7 % coronal posterior view numeric code
VIEW_CP_CMD = 'Coronal posterior' % coronal posterior view name
VIEW_CP_AZEL = [0 0] % coronal posterior view azimutal and polar angles

VIEW_CMD = { ... % vector of view names
    BrainSurfacePF.VIEW_3D_CMD ...
    BrainSurfacePF.VIEW_SL_CMD ...
    BrainSurfacePF.VIEW_SR_CMD ...
    BrainSurfacePF.VIEW_AD_CMD ...
    BrainSurfacePF.VIEW_AV_CMD ...
    BrainSurfacePF.VIEW_CA_CMD ...
    BrainSurfacePF.VIEW_CP_CMD ...
    }

VIEW_AZEL = { ... % vector of view azimutal and polar angle
    BrainSurfacePF.VIEW_3D_AZEL ...
    BrainSurfacePF.VIEW_SL_AZEL ...
    BrainSurfacePF.VIEW_SR_AZEL ...
    BrainSurfacePF.VIEW_AD_AZEL ...
    BrainSurfacePF.VIEW_AV_AZEL ...
    BrainSurfacePF.VIEW_CA_AZEL ...
    BrainSurfacePF.VIEW_CP_AZEL ...
    }

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
BrainSurfacePF.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
BrainSurfacePF.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
BrainSurfacePF.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
BrainSurfacePF.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
BrainSurfacePF.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
BrainSurfacePF.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
BrainSurfacePF.VIEW
%%%% ¡title!
3D VIEW

%%% ¡prop!
%%%% ¡id!
BrainSurfacePF.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
BrainSurfacePF.BRAIN
%%%% ¡title!
BRAIN ON/OFF

%%% ¡prop!
%%%% ¡id!
BrainSurfacePF.SURFFILE
%%%% ¡title!
BRAIN SURFACE

%%% ¡prop!
%%%% ¡id!
BrainSurfacePF.ST_SURFACE
%%%% ¡title!
BRAIN COLOR

%%% ¡prop!
%%%% ¡id!
BrainSurfacePF.ST_AMBIENT
%%%% ¡title!
MATERIAL & LIGHTNING

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel figure for brain surface.
%%%% ¡default!
'BrainSurfacePF'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for brain surface.
%%%% ¡default!
'Panel Figure for Brain Surface'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for brain surface.
%%%% ¡default!
'A Panel Figure for Brain Surface (BrainSurfacePF) manages the plot of the brain surface choosen by the user. BrainSurfacePF provides the common methods needed to manage the plot of the surface. In particular, the user can change lighting, material, camlight, shadning, colormap, facecolor, brain color, face color, edge color, and background color. A collection of brain surfaces in NV format can be found in the folder ./braph2/brainsurfs/.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for brain surface.
%%%% ¡settings!
'BrainSurfacePF'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for brain surface.
%%%% ¡default!
'BrainSurfacePF ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for brain surface.
%%%% ¡default!
'BrainSurfacePF label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for brain surface.
%%%% ¡default!
'BrainSurfacePF notes'

%%% ¡prop!
DRAW (query, logical) draws the figure brain surface.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
if value
    pf.memorize('H_AXES')
    
    pf.set('VIEW', pf.get('VIEW'))

    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', BrainSurfacePF.H_AXES).get('SETUP')
    pf.memorize('LISTENER_ST_AXIS');
    
    pf.memorize('H_BRAIN')

    pf.set('BRAIN', pf.get('BRAIN'))

    pf.memorize('ST_SURFACE').set('PANEL', pf, 'PROP', BrainSurfacePF.H_BRAIN).get('SETUP')
    
    pf.memorize('ST_AMBIENT').set('PANEL', pf, 'PROP', BrainSurfacePF.H_AXES).get('SETUP')
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel figure for brain surface is deleted.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
if value
    pf.set('H_AXES', Element.getNoValue())
    pf.set('H_BRAIN', Element.getNoValue())
    
    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
end

%%% ¡prop!
H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the panel figure for brain surface.
%%%% ¡calculate!
toolbar = pf.memorize('H_TOOLBAR');
if check_graphics(toolbar, 'uitoolbar')
    value = calculateValue@PanelFig(pf, PanelFig.H_TOOLS);
    
    tool_separator_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');

    % Brain
    tool_brain = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Brain', ...
        'Separator', 'on', ...
        'State', pf.get('BRAIN'), ...
        'Tooltip', 'Show Brain', ...
        'CData', imread('icon_brain.png'), ...
        'OnCallback', {@cb_brain, true}, ...
        'OffCallback', {@cb_brain, false});

    % Axis
    tool_axis = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Axis', ...
        'State', pf.get('ST_AXIS').get('AXIS'), ...
        'Tooltip', 'Show axis', ...
        'CData', imread('icon_axis.png'), ...
        'OnCallback', {@cb_axis, true}, ...
        'OffCallback', {@cb_axis, false});

    % Grid
    tool_grid = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Grid', ...
        'State', pf.get('ST_AXIS').get('GRID'), ...
        'Tooltip', 'Show grid', ...
        'CData', imread('icon_grid.png'), ...
        'OnCallback', {@cb_grid, true}, ...
        'OffCallback', {@cb_grid, false});
        
    tool_separator_2 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');

    % View 3D
    tool_view3D = uitoggletool(toolbar, ...
        'Tag', 'TOOL.View3D', ...
        'Separator', 'on', ... 
        'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_3D_AZEL), ...
        'Tooltip', BrainSurfacePF.VIEW_3D_CMD, ...
        'CData', imread('icon_view_3d.png'), ...
        'ClickedCallback', {@cb_view, BrainSurfacePF.VIEW_3D_AZEL});

    % View SL
    tool_viewSL = uitoggletool(toolbar, ...
        'Tag', 'TOOL.ViewSL', ...
        'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_SL_AZEL), ...
        'Tooltip', BrainSurfacePF.VIEW_SL_CMD, ...
        'CData', imread('icon_view_sl.png'), ...
        'ClickedCallback', {@cb_view, BrainSurfacePF.VIEW_SL_AZEL});

    % View SR
    tool_viewSR = uitoggletool(toolbar, ...
        'Tag', 'TOOL.ViewSR', ...
        'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_SR_AZEL), ...
        'Tooltip', BrainSurfacePF.VIEW_SR_CMD, ...
        'CData', imread('icon_view_sr.png'), ...
        'ClickedCallback', {@cb_view, BrainSurfacePF.VIEW_SR_AZEL});

    % View AD
    tool_viewAD = uitoggletool(toolbar, ...
        'Tag', 'TOOL.ViewAD', ...
        'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_AD_AZEL), ...
        'Tooltip', BrainSurfacePF.VIEW_AD_CMD, ...
        'CData', imread('icon_view_ad.png'), ...
        'ClickedCallback', {@cb_view, BrainSurfacePF.VIEW_AD_AZEL});

    % View AV
    tool_viewAV = uitoggletool(toolbar, ...
        'Tag', 'TOOL.ViewAV', ...
        'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_AV_AZEL), ...
        'Tooltip', BrainSurfacePF.VIEW_AV_CMD, ...
        'CData', imread('icon_view_av.png'), ...
        'ClickedCallback', {@cb_view, BrainSurfacePF.VIEW_AV_AZEL});

    % View CA
    tool_viewCA = uitoggletool(toolbar, ...
        'Tag', 'TOOL.ViewCA', ...
        'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_CA_AZEL), ...
        'Tooltip', BrainSurfacePF.VIEW_CA_CMD, ...
        'CData', imread('icon_view_ca.png'), ...
        'ClickedCallback', {@cb_view, BrainSurfacePF.VIEW_CA_AZEL});

    % View CP
    tool_viewCP = uitoggletool(toolbar, ...
        'Tag', 'TOOL.ViewCP', ...
        'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_CP_AZEL), ...
        'Tooltip', BrainSurfacePF.VIEW_CP_CMD, ...
        'CData', imread('icon_view_cp.png'), ...
        'ClickedCallback', {@cb_view, BrainSurfacePF.VIEW_CP_AZEL});
    
    value = {value{:}, ...
        tool_separator_1, ...
        tool_brain, tool_axis, tool_grid, ...
        tool_separator_2, ...
        tool_view3D, tool_viewSL, tool_viewSL, tool_viewSR, tool_viewAD, tool_viewAV, tool_viewCA, tool_viewCP ...
        };
else
    value = {};
end
%%%% ¡calculate_callbacks!
function cb_brain(~, ~, brain) % (src, event)
    pf.set('BRAIN', brain)
end
function cb_axis(~, ~, axis) % (src, event)
    pf.get('ST_AXIS').set('AXIS', axis);
    
    % triggers the update of ST_AXIS
    pf.set('ST_AXIS', pf.get('ST_AXIS'))
end
function cb_grid(~, ~, grid) % (src, event)
    pf.get('ST_AXIS').set('GRID', grid);

    % triggers the update of ST_AXIS
    pf.set('ST_AXIS', pf.get('ST_AXIS'))
end
function cb_view(~, ~, azel) % (src, event)
    pf.set('VIEW', azel)
end

%% ¡props!

%%% ¡prop!
H_AXES (evanescent, handle) is the handle for the axes.
%%%% ¡calculate!
h_axes = uiaxes( ...
    'Parent', pf.memorize('H'), ...
    'Tag', 'H_AXES', ...
    'Units', 'normalized', ...
    'OuterPosition', [0 0 1 1] ...
    );
h_axes.Toolbar.Visible = 'off';
h_axes.Interactions = [];
value = h_axes;

%%% ¡prop!
VIEW (figure, rvector) sets the desired view as the line-of-sight azimuth and elevation angles.
%%%% ¡check_prop!
check = length(value) == 2;
%%%% ¡default!
BrainSurfacePF.VIEW_SL_AZEL
%%%% ¡postset!
if pf.get('DRAWN')
    view(pf.get('H_AXES'), pf.get('VIEW'))
    
    % reset the ambient lighting
    pf.memorize('ST_AMBIENT').set('PANEL', pf, 'PROP', pf.H_AXES).get('SETUP')
    
    % update state of toggle tools
    toolbar = pf.get('H_TOOLBAR');
    if check_graphics(toolbar, 'uitoolbar')
        set(findobj(toolbar, 'Tag', 'TOOL.View3D'), 'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_3D_AZEL))
        set(findobj(toolbar, 'Tag', 'TOOL.ViewSL'), 'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_SL_AZEL))
        set(findobj(toolbar, 'Tag', 'TOOL.ViewSR'), 'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_SR_AZEL))
        set(findobj(toolbar, 'Tag', 'TOOL.ViewAD'), 'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_AD_AZEL))
        set(findobj(toolbar, 'Tag', 'TOOL.ViewAV'), 'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_AV_AZEL))
        set(findobj(toolbar, 'Tag', 'TOOL.ViewCA'), 'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_CA_AZEL))
        set(findobj(toolbar, 'Tag', 'TOOL.ViewCP'), 'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_CP_AZEL))
    end
end
%%%% ¡gui!
pr = PanelPropRVectorView('EL', pf, 'PROP', BrainSurfacePF.VIEW, varargin{:});

%%% ¡prop!
ST_AXIS (figure, item) determines the axis settings.
%%%% ¡settings!
'SettingsAxis'
%%%% ¡default!
SettingsAxis('GRID', false, 'AXIS', false)
%%%% ¡postset!
if pf.get('DRAWN')
    toolbar = pf.get('H_TOOLBAR');
    if check_graphics(toolbar, 'uitoolbar')
        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
    end
end
%%%% ¡gui!
pr = SettingsAxisPP('EL', pf, 'PROP', BrainSurfacePF.ST_AXIS, varargin{:});

%%% ¡prop!
LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.
%%%% ¡calculate!
value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis); 
%%%% ¡calculate_callbacks!
function cb_listener_st_axis(~, ~)
    if pf.get('DRAWN')
        toolbar = pf.get('H_TOOLBAR');
        if check_graphics(toolbar, 'uitoolbar')
            set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
            set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
        end
    end
end

%%% ¡prop!
SURFFILE (figure, option) is the name of the file of the brain surface to be plotted.
%%%% ¡settings!
{dir([fileparts(which('braph2')) filesep() 'brainsurfs' filesep() '*.nv']).name}
%%%% ¡default!
'human_ICBM152.nv'
%%%% ¡postset!
bs = ImporterBrainSurfaceNV('FILE', pf.get('SURFFILE')).get('SURF');
pf.set('SURF', bs)

if pf.get('DRAWN')
    delete(pf.get('H_BRAIN'))
    pf.set('H_BRAIN', Element.getNoValue())

    pf.memorize('H_BRAIN')

    pf.set('BRAIN', pf.get('BRAIN'))

    pf.memorize('ST_SURFACE').set('PANEL', pf, 'PROP', pf.H_BRAIN).get('SETUP')

    pf.memorize('ST_AMBIENT').set('PANEL', pf, 'PROP', pf.H_AXES).get('SETUP')
end

%%% ¡prop!
SURF (metadata, item) is the brain surface to be plotted.
%%%% ¡settings!
'BrainSurface'
%%%% ¡default!
ImporterBrainSurfaceNV('FILE', BrainSurfacePF.getPropDefault('SURFFILE')).get('SURF')

%%% ¡prop!
H_BRAIN (evanescent, handle) is the handle for brain surface.
%%%% ¡calculate!
triangles = pf.get('SURF').get('TRIANGLES');
coordinates = pf.get('SURF').get('COORDINATES');
h_brain = trisurf( ...
    triangles, ...
    coordinates(:, 1), ...
    coordinates(:, 2), ...
    coordinates(:, 3), ...
    'Parent', pf.memorize('H_AXES'), ...
    'Tag', 'H_BRAIN' ...
    );
xlabel(pf.get('H_AXES'), 'Sagittal')
ylabel(pf.get('H_AXES'), 'Axial')
zlabel(pf.get('H_AXES'), 'Coronal')
value = h_brain;

%%% ¡prop!
BRAIN (figure, logical) determines whether the brain surface is shown.
%%%% ¡default!
true
%%%% ¡postset!
if pf.get('DRAWN')
    if pf.get('BRAIN')
        set(pf.get('H_BRAIN'), 'Visible', 'on')
    else % ~pf.get('BRAIN') 
        set(pf.get('H_BRAIN'), 'Visible', 'off')
    end

    toolbar = pf.get('H_TOOLBAR');
    if check_graphics(toolbar, 'uitoolbar')
        set(findobj(toolbar, 'Tag', 'TOOL.Brain'), 'State', pf.get('BRAIN'))
    end
end

%%% ¡prop!
ST_SURFACE (figure, item) determines the surface settings.
%%%% ¡settings!
'SettingsSurface'
%%%% ¡gui!
pr = SettingsSurfacePP('EL', pf, 'PROP', BrainSurfacePF.ST_SURFACE, varargin{:});

%%% ¡prop!
ST_AMBIENT (figure, item) determines the ambient settings.
%%%% ¡settings!
'SettingsAmbient'
%%%% ¡default!
SettingsAmbient('LIGHTING', 'gouraud', 'MATERIAL', 'dull', 'CAMLIGHT', 'headlight (x2)', 'SHADING', 'none', 'COLORMAP', 'none')
%%%% ¡gui!
pr = SettingsAmbientPP('EL', pf, 'PROP', BrainSurfacePF.ST_AMBIENT, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[BrainSurfacePF.PARENT BrainSurfacePF.H BrainSurfacePF.ST_POSITION BrainSurfacePF.ST_AXIS BrainSurfacePF.ST_SURFACE BrainSurfacePF.ST_AMBIENT BrainSurfacePF.LISTENER_ST_AXIS]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':BrainSurfacePF'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':BrainSurfacePF'])

%%% ¡test!
%%%% ¡name!
Basics 1
%%%% ¡probability!
.01
%%%% ¡code!
pf = BrainSurfacePF('SURF', ImporterBrainSurfaceNV('FILE', 'other_macaque.nv').get('SURF'));
gui = GUIFig('PF', pf, 'POSITION', [0 .5 .5 .5], 'FILE', 'xxx sss', 'WAITBAR', true, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')
f = gui.get('H');
assert(check_graphics(f, 'figure'))
gui.get('CLOSE')

%%% ¡test!
%%%% ¡name!
Basics 2
%%%% ¡probability!
.01
%%%% ¡code!
pf = BrainSurfacePF('SURFFILE', 'other_macaque.nv');
gui = GUIFig('PF', pf, 'POSITION', [0 .5 .5 .5], 'FILE', 'xxx sss', 'WAITBAR', false, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')
f = gui.get('H');
assert(check_graphics(f, 'figure'))

gui_settings = gui.memorize('GUI_SETTINGS');
gui_settings.set('POSITION', [0 0 .3 .5])
gui_settings.get('DRAW')
gui_settings.get('SHOW')
f_settings = gui_settings.get('H');
assert(check_graphics(f_settings, 'figure'))

pf.get('ST_SURFACE').set('FACECOLOR', [1 0 0 ])

pf.set('BRAIN', false)

pf.set('BRAIN', true)

pf.get('ST_AXIS').set('GRID', false)

pf.get('ST_AXIS').set('GRID', true)

pf.get('ST_AXIS').set('AXIS', false)

pf.get('ST_AXIS').set('EQUAL', true)

pf.get('ST_AXIS').set('TIGHT', true)

pf.set('VIEW', [45 45])

pf.get('ST_AMBIENT').set(...
    'LIGHTING', 'phong', ...
    'MATERIAL', 'shiny', ...
    'CAMLIGHT', 'left', ...
    'SHADING', 'interp', ...
    'COLORMAP', 'autumn')

gui.get('CLOSE')