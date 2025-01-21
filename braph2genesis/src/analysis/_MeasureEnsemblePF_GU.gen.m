%% ¡header!
MeasureEnsemblePF_GU < MeasureEnsemblePF (pf, panel global unilayer group comparison figure) is the base element to plot a global unilayer group comparison figure.

%%% ¡description!
MeasureEnsemblePF_GU manages the basic functionalities to plot of a global unilayer group comparison figure.

%%% ¡seealso!
MeasureEnsemble

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GU.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GU.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GU.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GU.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GU.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GU.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GU.LAYER
%%%% ¡title!
LAYER SELECTION

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GU.ST_LINE_M
%%%% ¡title!
MEASURE

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GU.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GU.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GU.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the MeasureEnsemblePF_GU.
%%%% ¡default!
'MeasureEnsemblePF_GU'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure global unilayer group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_GU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure global unilayer group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_GU manages the basic functionalities to plot of a global unilayer group comparison figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure global unilayer group comparison figure.
%%%% ¡settings!
'MeasureEnsemblePF_GU'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure global unilayer group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_GU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure global unilayer group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_GU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure global unilayer group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_GU notes'

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

layer = pf.get('LAYER');
m = cell2mat(me.get('M'))';
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
pf.get('ST_TITLE').set( ...
    'TXT', me.get('LABEL'), ...
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
LAYER (figure, scalar) is the layer number of the global measure.
%%%% ¡default!
1
%%%% ¡postset!
pf.get('SETUP');
%%%% ¡gui!
pr = MeasureEnsemblePF_xUPP_Layer('EL', pf, 'PROP', MeasureEnsemblePF_GU.LAYER);

%% ¡tests!

%%% ¡excluded_props!
[MeasureEnsemblePF_GU.PARENT MeasureEnsemblePF_GU.H MeasureEnsemblePF_GU.ST_POSITION MeasureEnsemblePF_GU.ST_AXIS MeasureEnsemblePF_GU.ME MeasureEnsemblePF_GU.ST_AREA MeasureEnsemblePF_GU.ST_LINE_M MeasureEnsemblePF_GU.ST_TITLE MeasureEnsemblePF_GU.ST_XLABEL MeasureEnsemblePF_GU.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasureEnsemblePF_GU'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasureEnsemblePF_GU'])
