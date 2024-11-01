%% ¡header!
MeasureGroupBrainPF_NU < MeasureGroupBrainPF (pf, panel figure for nodal unilayer measure group brain) is a plot of a nodal unilayer measure group brain.

%%% ¡description!
A Panel Figure for a Brain Measure of Analyze Group (MeasureGroupBrainPF_NU ) manages the plot of the nodal unilayer measure
 ploted over the brain.  
MeasureGroupBrainPF_NU utilizes the surface created from BrainAtlasPF to integrate 
 the nodal unilayer meaure into the brain regions.

%%% ¡seealso!
BrainAtlas, BrainSurface, BrainAtlasPF

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.LAYER
%%%% ¡title!
Graph LAYER

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.MODULE
%%%% ¡title!
Communisty Structure MODULE

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.SIZE_DIFF
%%%% ¡title!
Show Measure Value with SPHERES SIZE

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.SIZE_SCALE
%%%% ¡title!
Size SCALE

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.COLOR_DIFF
%%%% ¡title!
Show Measure Value with SPHERES COLOR

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.VIEW
%%%% ¡title!
3D VIEW

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.BRAIN
%%%% ¡title!
BRAIN ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.SURFFILE
%%%% ¡title!
BRAIN SURFACE

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.ST_SURFACE
%%%% ¡title!
BRAIN COLOR

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.ST_AMBIENT
%%%% ¡title!
MATERIAL & LIGHTNING

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.SPHS
%%%% ¡title!
Brain Region SPHERES ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.SPH_DICT
%%%% ¡title!
Brain Region SPHERES PROPERTIES

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.SYMS
%%%% ¡title!
Brain Region SYMBOLS ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.SYM_DICT
%%%% ¡title!
Brain Region SYMBOLS PROPERTIES

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.IDS
%%%% ¡title!
Brain Region IDs ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.ID_DICT
%%%% ¡title!
Brain Region IDs PROPERTIES

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.LABS
%%%% ¡title!
Brain Region LABELS ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NU.LAB_DICT
%%%% ¡title!
Brain Region LABELS PROPERTIES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % %.
%%%% ¡default!
'MeasureGroupBrainPF_NU'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for measure group brain.
%%%% ¡default!
'Panel Figure for Measure Group Brain'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.
%%%% ¡default!
'A Panel Figure for a Brain Measure of Analyze Group (MeasureGroupBrainPF_NU) manages the plot of the nodal unilayer measure ploted over the brain. MeasureGroupBrainPF_NU  utilizes the surface created from BrainAtlasPF to integrate the nodal unilayer meaure into the brain regions.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.
%%%% ¡settings!
'MeasureGroupBrainPF_NU'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for measure group brain.
%%%% ¡default!
'MeasureGroupBrainPF_NU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for measure group brain.
%%%% ¡default!
'MeasureGroupBrainPF_NU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.
%%%% ¡default!
'MeasureGroupBrainPF_NU notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it to be implemented in the subelements.
%%%% ¡calculate!
m = pf.get('M');
g =  m.get('G');

% get brain region related list
sph_list = pf.get('SPH_DICT').get('IT_LIST');
sym_list = pf.get('SYM_DICT').get('IT_LIST');
id_list = pf.get('ID_DICT').get('IT_LIST');
lab_list = pf.get('LAB_DICT').get('IT_LIST');

% get the value to show on the surface
layer = pf.get('LAYER');
m_values = m.get('M');
if isempty(m_values)
    value = {};
    return
end
m_value = m_values{layer};
if isempty(m_value)
    value = {};
    return
end

size_diff = pf.get('SIZE_DIFF');
switch size_diff
    case 'on'
        % transfrom m value to appropriate size
        % value ranching from 0.01 to 1
        m_value(isnan(m_value)) = 0.1;
        size_value = abs(m_value);
        min_bound = 0.01;
        max_bound = 1.0;
        min_size_value = min(size_value);
        max_size_value = max(size_value);
        if max_size_value == min_size_value
            normalized_size_value = ones(size(size_value)) * max_bound;
        else
            normalized_size_value = min_bound + (max_bound - min_bound) * (size_value - min_size_value) / (max_size_value - min_size_value);
        end
        size_scale = pf.get('SIZE_SCALE');
        scaled_size_value = normalized_size_value * size_scale;

        % set size to sphs
        for i = 1:1:length(sph_list)
            set(sph_list{i}, 'SPHERESIZE', scaled_size_value(i));
        end
    case 'off'
        if pf.get('SPHS')
            for i = 1:1:length(sph_list)
                set(sph_list{i}, 'SPHERESIZE', SettingsSphere.getPropDefault('SPHERESIZE'));
            end
        end
    case 'disable'
end

color_diff = pf.get('COLOR_DIFF');
switch color_diff
    case 'on'
        % transfrom m value to appropriate color
        % RGB code ranching from 0 to 1
        m_value(isnan(m_value)) = 0;
        size_value = abs(m_value);
        min_bound = 0.0;
        max_bound = 1.0;
        min_size_value = min(size_value);
        max_size_value = max(size_value);
        if max_size_value == min_size_value
            normalized_size_value = ones(size(size_value)) * max_bound;
        else
            normalized_size_value = min_bound + (max_bound - min_bound) * (size_value - min_size_value) / (max_size_value - min_size_value);
        end

        % Map the normalized values to colors in the Jet colormap
        cmap = jet(256);
        color_indices = ceil(normalized_size_value * (size(cmap, 1) - 1)) + 1;

        % Clip color_indices to valid range
        color_indices = max(1, min(color_indices, size(cmap, 1)));

        % Get the RGB colors for the indices
        rgb_colors = cmap(color_indices, :);

        % set color to sphs
        for i = 1:1:length(sph_list)
            set(sph_list{i}, 'FACECOLOR', rgb_colors(i, :));
        end
        
    case 'off'
        if pf.get('SPHS')
            for i = 1:1:length(sph_list)
                set(sph_list{i}, 'FACECOLOR', SettingsSphere.getPropDefault('FACECOLOR'));
            end
        end
    case 'disable'
end

m_id = m.get('ID');
if isequal(m_id, 'CommunityStructure') || isequal(m_id, 'MultilayerCommunity')
    [modules, ia, ic] = unique(m_value, 'sorted');
    selected_module = pf.get('MODULE');
    if any(ismember(m_value, selected_module))
        mask = m_value == selected_module;
    else
        mask = true(size(m_value));
    end
    for i = 1:1:length(sph_list)
        set(sph_list{i}, 'VISIBLE', mask(i));
    end
    for i = 1:1:length(sym_list)
        set(sym_list{i}, 'VISIBLE', mask(i));
    end
    for i = 1:1:length(id_list)
        set(id_list{i}, 'VISIBLE', mask(i));
    end
    for i = 1:1:length(lab_list)
        set(lab_list{i}, 'VISIBLE', mask(i));
    end
end

value = {};

%% ¡props!

%%% ¡prop!
MODULE (figure, scalar) is the module selection for community structure.
%%%% ¡default!
1
%%%% ¡postset!
pf.get('SETUP');
%%%% ¡gui!
pr = MeasureGroupBrainPF_xUPP_Module('EL', pf, 'PROP', MeasureGroupBrainPF_NU.MODULE);

%%% ¡prop!
LAYER (figure, scalar) is the layer number of the nodal measure.
%%%% ¡default!
1
%%%% ¡postset!
pf.get('SETUP');
%%%% ¡gui!
pr = MeasureGroupBrainPF_xUPP_Layer('EL', pf, 'PROP', MeasureGroupBrainPF_NU.LAYER);

%%% ¡prop!
SIZE_DIFF (figure, option) determines whether the difference is shown with size effect.
%%%% ¡settings!
{'on' 'off' 'disable'}
%%%% ¡default!
'on'
%%%% ¡postset!
pf.get('SETUP');

%%% ¡prop!
SIZE_SCALE (figure, scalar) determines the scale of size effect.
%%%% ¡default!
10
%%%% ¡postset!
pf.get('SETUP');

%%% ¡prop!
COLOR_DIFF (figure, option) determines whether the difference is shown with color effect.
%%%% ¡settings!
{'on' 'off' 'disable'}
%%%% ¡default!
'on'
%%%% ¡postset!
pf.get('SETUP');

%% ¡tests!

%%% ¡excluded_props!
[MeasureGroupBrainPF_NU.PARENT MeasureGroupBrainPF_NU.H MeasureGroupBrainPF_NU.ST_POSITION MeasureGroupBrainPF_NU.ST_AXIS MeasureGroupBrainPF_NU.ST_SURFACE MeasureGroupBrainPF_NU.ST_AMBIENT MeasureGroupBrainPF_NU.M]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasureGroupBrainPF_NU'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasureGroupBrainPF_NU'])
