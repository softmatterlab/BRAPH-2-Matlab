%% ¡header!
MeasureEnsemblePF_BU < MeasureEnsemblePF (pf, panel binodal unilayer group comparison figure) is the base element to plot a binodal unilayer group comparison figure.

%%% ¡description!
MeasureEnsemblePF_BU manages the basic functionalities to plot of a binodal unilayer group comparison figure.

%%% ¡seealso!
MeasureEnsemble

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BU.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BU.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BU.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BU.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BU.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BU.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BU.NODES
%%%% ¡title!
NODES SELECTION

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BU.LAYER
%%%% ¡title!
LAYER SELECTION

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BB.ST_LINE_M
%%%% ¡title!
MEASURE

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BU.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BU.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_BU.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the MeasureEnsemblePF_BU.
%%%% ¡default!
'MeasureEnsemblePF_BU'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure binodal unilayer group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_BU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure binodal unilayer group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_BU manages the basic functionalities to plot of a binodal unilayer group comparison figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure binodal unilayer group comparison figure.
%%%% ¡settings!
'MeasureEnsemblePF_BU'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure binodal unilayer group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_BU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure binodal unilayer group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_BU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure binodal unilayer group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_BU notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
me = pf.get('ME');
if me.get('A').get('G_DICT').get('LENGTH')
    g = me.get('A').get('G_DICT').get('IT', 1);
else
    g = me.get('A').get('GRAPH_TEMPLATE');
end

x = g.get('APARTITIONTICKS');

nodes = pf.get('NODES');
layer = pf.get('LAYER');
m = cellfun(@(x) x(nodes(1), nodes(2)), me.get('M'))';
layers_num = length(g.get('ALAYERTICKS'));
m2 = zeros(1, length(x));
count=1;
for i=layer:layers_num:g.get('LAYERNUMBER')
    m2(count) = m(i);
    count = count + 1;
end
pf.memorize('ST_LINE_M').set('X', x, 'Y', m2)

xlim = pf.get('H_AXES').get('XLim');
ylim = pf.get('H_AXES').get('YLim');
anodelabels = g.get('ANODELABELS');
if isequal(anodelabels, {'numbered'})
    title = [me.get('LABEL') ' ' int2str(nodes(1)) ' ' int2str(nodes(2))];
else
    title = [me.get('LABEL') ' ' anodelabels{nodes(1)} ' ' anodelabels{nodes(2)}];
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
NODES (figure, rvector) are the node numbers of the binodal group comparison figure.
%%%% ¡default!
[1 1]
%%%% ¡postset!
pf.get('SETUP')
%%%% ¡gui!
pr = MeasureEnsemblePF_BxPP_Nodes('EL', pf, 'PROP', MeasureEnsemblePF_BU.NODES);

%%% ¡prop!
LAYER (figure, scalar) is the layer number of the binodal measure.
%%%% ¡default!
1
%%%% ¡postset!
pf.get('SETUP');
%%%% ¡gui!
pr = MeasureEnsemblePF_xUPP_Layer('EL', pf, 'PROP', MeasureEnsemblePF_BU.LAYER);

%% ¡tests!

%%% ¡excluded_props!
[MeasureEnsemblePF_BU.PARENT MeasureEnsemblePF_BU.H MeasureEnsemblePF_BU.ST_POSITION MeasureEnsemblePF_BU.ST_AXIS MeasureEnsemblePF_BU.ME MeasureEnsemblePF_BU.ST_AREA MeasureEnsemblePF_BU.ST_LINE_M MeasureEnsemblePF_BU.ST_TITLE MeasureEnsemblePF_BU.ST_XLABEL MeasureEnsemblePF_BU.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasureEnsemblePF_BU'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasureEnsemblePF_BU'])
