%% ¡header!
MeasurePF_NS < MeasurePF (pf, panel figure for nodal superglobal measure) is the base element to plot the panel figure of the nodal superglobal measure.

%%% ¡description!
A Panel Figure for Nodal Superglobal Measure (MeasurePF_NS) manages the basic functionalities to plot the panel figure of the nodal superglobal measure.

%%% ¡seealso!
Measure

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasurePF_NS.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
MeasurePF_NS.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
MeasurePF_NS.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasurePF_NS.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
MeasurePF_NS.NODE
%%%% ¡title!
NODE SELECTION

%%% ¡prop!
%%%% ¡id!
MeasurePF_NS.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
MeasurePF_NS.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
MeasurePF_NS.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
MeasurePF_NS.ST_AREA
%%%% ¡title!
FILLED AREA

%%% ¡prop!
%%%% ¡id!
MeasurePF_NS.ST_LINE
%%%% ¡title!
MEASURE LINE

%%% ¡prop!
%%%% ¡id!
MeasurePF_NS.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
MeasurePF_NS.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
MeasurePF_NS.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel figure for nodal superglobal measure (MeasurePF_NS).
%%%% ¡default!
'MeasurePF_NS'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for nodal superglobal measure.
%%%% ¡default!
'Panel Figure for Nodal Superglobal Measure'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for nodal superglobal measure.
%%%% ¡default!
'A Panel Figure for Nodal Superglobal Measure (MeasurePF_NS) manages the basic functionalities to plot of a nodal superglobal measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for nodal superglobal measure.
%%%% ¡settings!
'MeasurePF_NS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for nodal superglobal measure.
%%%% ¡default!
'MeasurePF_NS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for nodal superglobal measure.
%%%% ¡default!
'MeasurePF_NS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for nodal superglobal measure.
%%%% ¡default!
'MeasurePF_NS notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it.
%%%% ¡calculate!
x = pf.get('M').get('G').get('APARTITIONTICKS');

node = pf.get('NODE');
y = cellfun(@(x) x(node), pf.get('M').get('M'))';

pf.memorize('ST_LINE').set('X', x, 'Y', y)

if ~isempty(y)
    if isempty(x) 
        pf.memorize('ST_AREA').set('X', [1 1:1:length(y) length(y)], 'Y', [0 y 0])
    else
        pf.memorize('ST_AREA').set('X', [x(1) x x(end)], 'Y', [0 y 0])
    end
end

xlim = pf.get('H_AXES').get('XLim');
ylim = pf.get('H_AXES').get('YLim');
anodelabels = pf.get('M').get('G').get('ANODELABELS');
pf.get('ST_TITLE').set( ...
    'TXT', [pf.get('M').get('LABEL') ' ' anodelabels{node}], ...
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
NODE (figure, scalar) is the node number of the nodal measure.
%%%% ¡default!
1
%%%% ¡postset!
pf.get('SETUP');
%%%% ¡gui!
pr = MeasurePF_NxPP_Node('EL', pf, 'PROP', MeasurePF_NS.NODE);

%% ¡tests!

%%% ¡excluded_props!
[MeasurePF_NS.PARENT MeasurePF_NS.PARENT MeasurePF_NS.H MeasurePF_NS.ST_POSITION MeasurePF_NS.ST_AXIS MeasurePF_NS.ST_AREA MeasurePF_NS.M MeasurePF_NS.ST_LINE MeasurePF_NS.ST_TITLE MeasurePF_NS.ST_XLABEL MeasurePF_NS.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasurePF_NS'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasurePF_NS'])
