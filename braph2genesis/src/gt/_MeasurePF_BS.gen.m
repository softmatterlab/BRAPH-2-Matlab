%% ¡header!
MeasurePF_BS < MeasurePF (pf, panel figure for binodal superglobal measure) is the base element to plot the panel figure of a binodal superglobal measure.

%%% ¡description!
A Panel Figure for Binodal Superglobal Measure (MeasurePF_BS) manages the basic functionalities to plot the panel figure of a binodal superglobal measure.

%%% ¡seealso!
Measure

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasurePF_BS.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
MeasurePF_BS.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
MeasurePF_BS.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasurePF_BS.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
MeasurePF_BS.NODES
%%%% ¡title!
NODES SELECTION

%%% ¡prop!
%%%% ¡id!
MeasurePF_BS.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
MeasurePF_BS.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
MeasurePF_BS.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
MeasurePF_BS.ST_AREA
%%%% ¡title!
FILLED AREA

%%% ¡prop!
%%%% ¡id!
MeasurePF_BS.ST_LINE
%%%% ¡title!
MEASURE LINE

%%% ¡prop!
%%%% ¡id!
MeasurePF_BS.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
MeasurePF_BS.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
MeasurePF_BS.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel figure for binodal superglobal measure (MeasurePF_BS).
%%%% ¡default!
'MeasurePF_BS'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for binodal superglobal measure.
%%%% ¡default!
'Panel Figure for Binodal Superglobal Measure'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for binodal superglobal measure.
%%%% ¡default!
'A Panel Figure for Binodal Superglobal Measure (MeasurePF_BS) manages the basic functionalities to plot of a binodal superglobal measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for binodal superglobal measure.
%%%% ¡settings!
'MeasurePF_BS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for binodal superglobal measure.
%%%% ¡default!
'MeasurePF_BS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for binodal superglobal measure.
%%%% ¡default!
'MeasurePF_BS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for binodal superglobal measure.
%%%% ¡default!
'MeasurePF_BS notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it.
%%%% ¡calculate!
x = pf.get('M').get('G').get('APARTITIONTICKS');

nodes = pf.get('NODES');

y = cellfun(@(x) x(nodes(1), nodes(2)), pf.get('M').get('M'))';

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
    'TXT', [pf.get('M').get('LABEL') ' ' anodelabels{nodes(1)} ' ' anodelabels{nodes(2)}], ...
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
NODES (figure, rvector) are the node numbers of the binodal measure.
%%%% ¡default!
[1 1]
%%%% ¡postset!
pf.get('SETUP')
%%%% ¡gui!
pr = MeasurePF_BxPP_Nodes('EL', pf, 'PROP', MeasurePF_BS.NODES);

%% ¡tests!

%%% ¡excluded_props!
[MeasurePF_BS.SETUP MeasurePF_BS.PARENT MeasurePF_BS.H MeasurePF_BS.ST_POSITION MeasurePF_BS.ST_AXIS MeasurePF_BS.M MeasurePF_BS.ST_AREA MeasurePF_BS.ST_LINE MeasurePF_BS.ST_TITLE MeasurePF_BS.ST_XLABEL MeasurePF_BS.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasurePF_BS'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasurePF_BS'])
