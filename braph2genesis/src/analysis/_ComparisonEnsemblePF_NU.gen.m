%% ¡header!
ComparisonEnsemblePF_NU < ComparisonEnsemblePF (pf, panel nodal unilayer group comparison figure) is the base element to plot a nodal unilayer group comparison figure.

%%% ¡description!
ComparisonEnsemblePF_NU manages the basic functionalities to plot of a nodal unilayer group comparison figure.

%%% ¡seealso!
ComparisonEnsemble

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NU.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NU.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NU.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NU.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NU.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NU.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NU.NODE
%%%% ¡title!
NODE SELECTION

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NU.LAYER
%%%% ¡title!
LAYER SELECTION

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NU.ST_LINE_DIFF
%%%% ¡title!
DIFFERENCE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NU.ST_AREA
%%%% ¡title!
CONFIDENCE AREA (95%)

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NU.ST_LINE_CIL
%%%% ¡title!
LOWER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NU.ST_LINE_CIU
%%%% ¡title!
UPPER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NU.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NU.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NU.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the ComparisonEnsemblePF_NU.
%%%% ¡default!
'ComparisonEnsemblePF_NU'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure nodal unilayer group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_NU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure nodal unilayer group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_NU manages the basic functionalities to plot of a nodal unilayer group comparison figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure nodal unilayer group comparison figure.
%%%% ¡settings!
'ComparisonEnsemblePF_NU'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure nodal unilayer group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_NU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure nodal unilayer group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_NU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure nodal unilayer group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_NU notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
cp = pf.get('CP');
if cp.get('C').get('A1').get('G_DICT').get('LENGTH')
    g = cp.get('C').get('A1').get('G_DICT').get('IT', 1);
else
    g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
end

x = g.get('APARTITIONTICKS');

node = pf.get('NODE');
diff = cellfun(@(x) x(node), cp.get('DIFF'))';
cil = cellfun(@(x) x(node), cp.get('CIL'))';
ciu = cellfun(@(x) x(node), cp.get('CIU'))';

layer = pf.get('LAYER');
layers_num = length(g.get('ALAYERTICKS'));
diff2 = zeros(1, length(x));
cil2 = zeros(1, length(x));
ciu2 = zeros(1, length(x));
count=1;
for i=layer:layers_num:g.get('LAYERNUMBER')
    diff2(count) = diff(i);
    cil2(count) = cil(i);
    ciu2(count) = ciu(i);
    count = count + 1;
end                  
pf.memorize('ST_LINE_DIFF').set('X', x, 'Y', diff2)
pf.memorize('ST_LINE_CIL').set('X', x, 'Y', cil2)
pf.memorize('ST_LINE_CIU').set('X', x, 'Y', ciu2)

if ~isempty(cil2) && ~isempty(ciu2)
    if isempty(x) 
        pf.memorize('ST_AREA').set('X', [1:1:length(diff2) length(diff2):-1:1], 'Y', [cil2 ciu2(end:-1:1)])
    else
        pf.memorize('ST_AREA').set('X', [x x(end:-1:1)], 'Y', [cil2 ciu2(end:-1:1)])
    end
end

xlim = pf.get('H_AXES').get('XLim');
ylim = pf.get('H_AXES').get('YLim');
anodelabels = g.get('ANODELABELS');
if isequal(anodelabels, {'numbered'})
    title = [cp.get('LABEL') ' ' int2str(node)];
else
    title = [cp.get('LABEL') ' ' anodelabels{node}];
end
pf.get('ST_TITLE').set( ...
    'TXT', title, ...
    'X', .5 * (xlim(2) + xlim(1)), ...
    'Y', ylim(2) + .07 * (ylim(2) - ylim(1)), ...
    'Z', 0 ...
    )
pf.get('ST_XLABEL').set( ...
    'TXT', 'Partition', ...
    'X', .5 * (xlim(2) + xlim(1)), ...
    'Y', ylim(1) - .07 * (ylim(2) - ylim(1)), ...
    'Z', 0 ...
    )
pf.get('ST_YLABEL').set( ...
	'TXT', 'Measure Value', ...
    'X', xlim(1) - .14 * (xlim(2) - xlim(1)), ...
    'Y', .5 * (ylim(2) + ylim(1)), ...
    'Z', 0 ...
    )

value = [];

%% ¡props!

%%% ¡prop!
NODE (figure, scalar) is the node number of the nodal group comparison figure.
%%%% ¡default!
1
%%%% ¡postset!
pf.get('SETUP')
%%%% ¡gui!
pr = ComparisonEnsemblePF_NxPP_Node('EL', pf, 'PROP', ComparisonEnsemblePF_NU.NODE);

%%% ¡prop!
LAYER (figure, scalar) is the layer number of the nodal group comparison figure.
%%%% ¡default!
1
%%%% ¡postset!
pf.get('SETUP');
%%%% ¡gui!
pr = ComparisonEnsemblePF_xUPP_Layer('EL', pf, 'PROP', ComparisonEnsemblePF_NU.LAYER);

%% ¡tests!

%%% ¡excluded_props!
[ComparisonEnsemblePF_NU.PARENT ComparisonEnsemblePF_NU.H ComparisonEnsemblePF_NU.ST_POSITION ComparisonEnsemblePF_NU.ST_AXIS ComparisonEnsemblePF_NU.CP ComparisonEnsemblePF_NU.ST_AREA ComparisonEnsemblePF_NU.ST_LINE_DIFF ComparisonEnsemblePF_NU.ST_LINE_CIL ComparisonEnsemblePF_NU.ST_LINE_CIU ComparisonEnsemblePF_NU.ST_TITLE ComparisonEnsemblePF_NU.ST_XLABEL ComparisonEnsemblePF_NU.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonEnsemblePF_NU'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonEnsemblePF_NU'])
