%% ¡header!
MeasureEnsemblePF_NS < MeasureEnsemblePF (pf, panel nodal superglobal group comparison figure) is the base element to plot a nodal superglobal group comparison figure.

%%% ¡description!
MeasureEnsemblePF_NS manages the basic functionalities to plot of a nodal superglobal group comparison figure.

%%% ¡seealso!
MeasureEnsemble

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.NODE
%%%% ¡title!
NODE SELECTION

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.ST_LINE_M
%%%% ¡title!
MEASURE

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_NS.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the MeasureEnsemblePF_NS.
%%%% ¡default!
'MeasureEnsemblePF_NS'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure nodal superglobal group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_NS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure nodal superglobal group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_NS manages the basic functionalities to plot of a nodal superglobal group comparison figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure nodal superglobal group comparison figure.
%%%% ¡settings!
'MeasureEnsemblePF_NS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure nodal superglobal group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_NS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure nodal superglobal group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_NS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure nodal superglobal group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_NS notes'

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

node = pf.get('NODE');
m = cellfun(@(x) x(node), me.get('M'))';

pf.memorize('ST_LINE_M').set('X', x, 'Y', m)

xlim = pf.get('H_AXES').get('XLim');
ylim = pf.get('H_AXES').get('YLim');
anodelabels = g.get('ANODELABELS');
if isequal(anodelabels, {'numbered'})
    title = [me.get('LABEL') ' ' int2str(node)];
else
    title = [me.get('LABEL') ' ' anodelabels{node}];
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
%%%% ¡_gui!
pr = MeasureEnsemblePF_NxPP_Node('EL', pf, 'PROP', MeasureEnsemblePF_NS.NODE);

%% ¡tests!

%%% ¡excluded_props!
[MeasureEnsemblePF_NS.PARENT MeasureEnsemblePF_NS.H MeasureEnsemblePF_NS.ST_POSITION MeasureEnsemblePF_NS.ST_AXIS MeasureEnsemblePF_NS.ME MeasureEnsemblePF_NS.ST_AREA MeasureEnsemblePF_NS.ST_LINE_M MeasureEnsemblePF_NS.ST_TITLE MeasureEnsemblePF_NS.ST_XLABEL MeasureEnsemblePF_NS.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasureEnsemblePF_NS'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasureEnsemblePF_NS'])
