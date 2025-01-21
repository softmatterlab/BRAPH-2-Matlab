%% ¡header!
MeasurePF_GS < MeasurePF (pf, panel figure for global superglobal measure) is the base element to plot the panel figure of the global superglobal measure.

%%% ¡description!
A Panel Figure for Global Superglobal Measure (MeasurePF_GS) manages the basic functionalities to plot the panel figure of a global superglobal measure.

%%% ¡seealso!
Measure

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasurePF_GS.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
MeasurePF_GS.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
MeasurePF_GS.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasurePF_GS.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
MeasurePF_GS.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
MeasurePF_GS.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
MeasurePF_GS.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
MeasurePF_GS.ST_AREA
%%%% ¡title!
FILLED AREA

%%% ¡prop!
%%%% ¡id!
MeasurePF_GS.ST_LINE
%%%% ¡title!
MEASURE LINE

%%% ¡prop!
%%%% ¡id!
MeasurePF_GS.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
MeasurePF_GS.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
MeasurePF_GS.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel figure for global superglobal measure (MeasurePF_GS).
%%%% ¡default!
'MeasurePF_GS'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for global superglobal measure.
%%%% ¡default!
'Panel Figure for Global Superglobal Measure'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for global superglobal measure.
%%%% ¡default!
'A Panel Figure for Global Superglobal Measure (MeasurePF_GS) manages the basic functionalities to plot the panel figure of a global superglobal measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for global superglobal measure.
%%%% ¡settings!
'MeasurePF_GS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for global superglobal measure.
%%%% ¡default!
'MeasurePF_GS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for global superglobal measure.
%%%% ¡default!
'MeasurePF_GS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for global superglobal measure.
%%%% ¡default!
'MeasurePF_GS notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it.
%%%% ¡calculate!
x = pf.get('M').get('G').get('APARTITIONTICKS');

y = cell2mat(pf.get('M').get('M'))';

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
pf.get('ST_TITLE').set( ...
    'TXT', pf.get('M').get('LABEL'), ...
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

%% ¡tests!

%%% ¡excluded_props!
[MeasurePF_GS.PARENT MeasurePF_GS.H MeasurePF_GS.ST_POSITION MeasurePF_GS.ST_AXIS MeasurePF_GS.M MeasurePF_GS.ST_AREA MeasurePF_GS.ST_LINE MeasurePF_GS.ST_TITLE MeasurePF_GS.ST_XLABEL MeasurePF_GS.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasurePF_GS'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasurePF_GS'])
