%% ¡header!
ComparisonGroupBrainPF_NS < ComparisonGroupBrainPF (pf, panel nodal superglobal group comparison on brain surface figure) is the base element to plot a nodal superglobal group comparison on brain surface figure.

%%% ¡description!
ComparisonGroupBrainPF_NS manages the basic functionalities to plot of a nodal superglobal group comparison on brain surface figure.

%%% ¡seealso!
ComparisonGroup

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.FDR
%%%% ¡title!
FDR CORRECTION

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.QVALUE
%%%% ¡title!
QVALUE 

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.LAYER
%%%% ¡title!
Graph LAYER

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.SPHS
%%%% ¡title!
Brain Region SPHERES ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.SPH_DICT
%%%% ¡title!
Brain Region SPHERES PROPERTIES

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.SIZE_DIFF
%%%% ¡title!
Show Difference with SPHERES SIZE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.SIZE_SCALE
%%%% ¡title!
Size SCALE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.COLOR_DIFF
%%%% ¡title!
Show Difference with SPHERES COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.VIEW
%%%% ¡title!
3D VIEW

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.BRAIN
%%%% ¡title!
BRAIN ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.SURFFILE
%%%% ¡title!
BRAIN SURFACE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.ST_SURFACE
%%%% ¡title!
BRAIN COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.ST_AMBIENT
%%%% ¡title!
MATERIAL & LIGHTNING

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.SYMS
%%%% ¡title!
Brain Region SYMBOLS ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.SYM_DICT
%%%% ¡title!
Brain Region SYMBOLS PROPERTIES

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.IDS
%%%% ¡title!
Brain Region IDs ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.ID_DICT
%%%% ¡title!
Brain Region IDs PROPERTIES

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.LABS
%%%% ¡title!
Brain Region LABELS ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_NS.LAB_DICT
%%%% ¡title!
Brain Region LABELS PROPERTIES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonGroupBrainPF_NS'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure nodal superglobal group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_NS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure nodal superglobal group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_NS manages the basic functionalities to plot of a nodal superglobal group comparison on brain surface figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure nodal superglobal group comparison on brain surface figure.
%%%% ¡settings!
'ComparisonGroupBrainPF_NS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure nodal superglobal group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_NS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure nodal superglobal group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_NS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure nodal superglobal group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_NS notes'

%%% ¡prop!
DRAW (query, logical) draws the figure brain atlas.
%%%% ¡calculate!
value = calculateValue@ComparisonGroupBrainPF(pf, ComparisonGroupBrainPF.DRAW, varargin{:}); % also warning
if value
    % reset the ambient lighting
    pf.get('ST_AMBIENT').get('SETUP')

    % call setup
    pf.get('SETUP');
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel figure brain surface is deleted.
%%%% ¡calculate!
value = calculateValue@ComparisonGroupBrainPF(pf, ComparisonGroupBrainPF.DELETE, varargin{:}); % also warning
if value

end

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
cp = pf.get('CP');
g = cp.get('C').get('A1').get('G');

% get brain region related list
sph_list = pf.get('SPH_DICT').get('IT_LIST');
sym_list = pf.get('SYM_DICT').get('IT_LIST');
id_list = pf.get('ID_DICT').get('IT_LIST');
lab_list = pf.get('LAB_DICT').get('IT_LIST');

% get the value to show on the surface
layer = pf.get('LAYER');
diffs = cp.get('DIFF');
if isempty(diffs)
    value = {};
    return
end
diff = diffs{layer};
if isempty(diff)
    value = {};
    return
end
p2s = cp.get('P2');
p2 = p2s{layer};

% apply FDR to spheres, symbols, ids, and labels
fdr_diff = pf.get('FDR');
switch fdr_diff
    case 'on'
        [~, mask] = fdr(p2', pf.get('QVALUE'));
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
    case 'off'
        if pf.get('SPHS')
            for i = 1:1:length(sph_list)
                set(sph_list{i}, 'VISIBLE', true);
            end
        end
        if pf.get('SYMS')
            for i = 1:1:length(sym_list)
                set(sym_list{i}, 'VISIBLE', true);
            end
        end
        if pf.get('IDS')
            for i = 1:1:length(id_list)
                set(id_list{i}, 'VISIBLE', true);
            end
        end
        if pf.get('LABS')
            for i = 1:1:length(lab_list)
                set(lab_list{i}, 'VISIBLE', true);
            end
        end
    case 'disable'
end

size_diff = pf.get('SIZE_DIFF');
switch size_diff
    case 'on'
        % transfrom diff value to appropriate size
        % value ranching from 0.01 to 1
        diff(isnan(diff)) = 0.1;
        diff(isinf(diff)) = 0.1;
        size_value = abs(diff);
        min_bound = 0.01;
        max_bound = 1.0;
        min_size_value = min(size_value);
        max_size_value = max(size_value);
        if isequal(max_size_value, min_size_value)
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
        % transfrom diff value to appropriate color
        % code
        color_code_list = cell(size(diff));

        for i = 1:numel(color_code_list)
            if diff(i) > 0
                color_code_list{i} = [1 0 0]; % Red
            elseif diff(i) < 0
                color_code_list{i} = [0 0 1]; % Blue
            else
                color_code_list{i} = [0 0 0]; % Black (or any other color for zero)
            end
        end

        % set color to sphs
        cellfun(@(sph, color_code) set(sph, 'FACECOLOR', color_code), sph_list, color_code_list', 'UniformOutput', false);
    case 'off'
        if pf.get('SPHS')
            for i = 1:1:length(sph_list)
                set(sph_list{i}, 'FACECOLOR', SettingsSphere.getPropDefault('FACECOLOR'));
            end
        end
    case 'disable'
end

value = [];

%% ¡props!

%%% ¡prop!
LAYER (figure, scalar) is the layer number of the nodal measure.
%%%% ¡default!
1
%%%% ¡postset!
pf.get('SETUP');
%%%% ¡gui!
pr = ComparisonGroupBrainPF_xSPP_Layer('EL', pf, 'PROP', ComparisonGroupBrainPF_NS.LAYER);

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
5
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

%%% ¡prop!
FDR (figure, option) determines whether the difference is shown with FDR correction.
%%%% ¡settings!
{'on' 'off' 'disable'}
%%%% ¡default!
'off'
%%%% ¡postset!
pf.get('SETUP');

%%% ¡prop!
QVALUE (figure, scalar) determines the QVALUE for FDR correction.
%%%% ¡default!
0.05
%%%% ¡postprocessing!
if isempty(pf.get('QVALUE'))
    pf.set('QVALUE', pf.get('CP').get('QVALUE'));
end
%%%% ¡postset!
pf.get('CP').set('QVALUE', pf.get('QVALUE'));
pf.get('SETUP');


%% ¡tests!

%%% ¡excluded_props!
[ComparisonGroupBrainPF_NS.PARENT ComparisonGroupBrainPF_NS.H ComparisonGroupBrainPF_NS.ST_POSITION ComparisonGroupBrainPF_NS.ST_AXIS ComparisonGroupBrainPF_NS.CP ComparisonGroupBrainPF_NS.ST_SURFACE ComparisonGroupBrainPF_NS.ST_AMBIENT ComparisonGroupBrainPF_NS.CP] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonGroupBrainPF_NS'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonGroupBrainPF_NS'])
