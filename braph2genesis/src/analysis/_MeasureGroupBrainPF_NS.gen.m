%% ¡header!
MeasureGroupBrainPF_NS < MeasureGroupBrainPF (pf, panel figure for nodal superglobal measure group brain) is a plot of a nodal superglobal measure group brain.

%%% ¡description!
A Panel Figure for a Brain Measure of Analyze Group (MeasureGroupBrainPF_NS) manages the plot of the nodal superglobal measure
 ploted over the brain.  
MeasureGroupBrainPF_NS utilizes the surface created from BrainAtlasPF to integrate 
 the nodal superglobal meaure into the brain regions.

%%% ¡seealso!
BrainAtlas, BrainSurface, BrainAtlasPF

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.LAYER
%%%% ¡title!
Graph LAYER

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.SPHS
%%%% ¡title!
Brain Region SPHERES ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.SPH_DICT
%%%% ¡title!
Brain Region SPHERES PROPERTIES

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.SIZE_DIFF
%%%% ¡title!
Show Measure Value with SPHERES SIZE

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.SIZE_SCALE
%%%% ¡title!
Size SCALE

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.COLOR_DIFF
%%%% ¡title!
Show Measure Value with SPHERES COLOR

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.VIEW
%%%% ¡title!
3D VIEW

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.BRAIN
%%%% ¡title!
BRAIN ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.SURFFILE
%%%% ¡title!
BRAIN SURFACE

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.ST_SURFACE
%%%% ¡title!
BRAIN COLOR

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.ST_AMBIENT
%%%% ¡title!
MATERIAL & LIGHTNING

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.SYMS
%%%% ¡title!
Brain Region SYMBOLS ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.SYM_DICT
%%%% ¡title!
Brain Region SYMBOLS PROPERTIES

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.IDS
%%%% ¡title!
Brain Region IDs ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.ID_DICT
%%%% ¡title!
Brain Region IDs PROPERTIES

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.LABS
%%%% ¡title!
Brain Region LABELS ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureGroupBrainPF_NS.LAB_DICT
%%%% ¡title!
Brain Region LABELS PROPERTIES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % %.
%%%% ¡default!
'MeasureGroupBrainPF_NS'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for measure group brain.
%%%% ¡default!
'Panel Figure for Measure Group Brain'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.
%%%% ¡default!
'A Panel Figure for a Brain Measure of Analyze Group (MeasureGroupBrainPF_NS ) manages the plot of the nodal superglobal measure ploted over the brain. MeasureGroupBrainPF_NS  utilizes the surface created from BrainAtlasPF to integrate the nodal superglobal meaure into the brain regions.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.
%%%% ¡settings!
'MeasureGroupBrainPF_NS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for measure group brain.
%%%% ¡default!
'MeasureGroupBrainPF_NS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for measure group brain.
%%%% ¡default!
'MeasureGroupBrainPF_NS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.
%%%% ¡default!
'MeasureGroupBrainPF_NS notes'

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

value = {};

%% ¡props!

%%% ¡prop!
LAYER (figure, scalar) is the layer number of the nodal measure.
%%%% ¡default!
1
%%%% ¡postset!
pf.get('SETUP');
%%%% ¡gui!
pr = MeasureGroupBrainPF_xSPP_Layer('EL', pf, 'PROP', MeasureGroupBrainPF_NS.LAYER);

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
[MeasureGroupBrainPF_NS.PARENT MeasureGroupBrainPF_NS.H MeasureGroupBrainPF_NS.ST_POSITION MeasureGroupBrainPF_NS.ST_AXIS MeasureGroupBrainPF_NS.ST_SURFACE MeasureGroupBrainPF_NS.ST_AMBIENT MeasureGroupBrainPF_NS.M]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasureGroupBrainPF_NS'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasureGroupBrainPF_NS'])
