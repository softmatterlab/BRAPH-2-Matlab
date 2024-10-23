%% ¡header!
MeasurePF_GU < MeasurePF (pf, panel figure for global unilayer measure) is the base element to plot the panel figure of the global unilayer measure.

%%% ¡description!
A Panel Figure for Global Unilayer Measure (MeasurePF_GU) manages the basic functionalities to plot the panel figure of a global unilayer measure.

%%% ¡seealso!
Measure

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasurePF_GU.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
MeasurePF_GU.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
MeasurePF_GU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasurePF_GU.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
MeasurePF_GU.LAYER
%%%% ¡title!
LAYER SELECTION

%%% ¡prop!
%%%% ¡id!
MeasurePF_GU.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
MeasurePF_GU.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
MeasurePF_GU.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
MeasurePF_GU.ST_AREA
%%%% ¡title!
FILLED AREA

%%% ¡prop!
%%%% ¡id!
MeasurePF_GU.ST_LINE
%%%% ¡title!
MEASURE LINE

%%% ¡prop!
%%%% ¡id!
MeasurePF_GU.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
MeasurePF_GU.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
MeasurePF_GU.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel figure for global unilayer measure (MeasurePF_GU).
%%%% ¡default!
'MeasurePF_GU'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for global unilayer measure.
%%%% ¡default!
'Panel Figure for Global Unilayer Measure'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for global unilayer measure.
%%%% ¡default!
'A Panel Figure for Global Unilayer Measure (MeasurePF_GU) manages the basic functionalities to plot of a global unilayer measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for global unilayer measure.
%%%% ¡settings!
'MeasurePF_GU'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for global unilayer measure.
%%%% ¡default!
'MeasurePF_GU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for global unilayer measure.
%%%% ¡default!
'MeasurePF_GU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for global unilayer measure.
%%%% ¡default!
'MeasurePF_GU notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it.
%%%% ¡calculate!
x = pf.get('M').get('G').get('APARTITIONTICKS');
g = pf.get('M').get('G');
layer = pf.get('LAYER');
m = cell2mat(pf.get('M').get('M'))';
layers_num = length(g.get('ALAYERTICKS'));
m2 = zeros(1, length(x));
count=1;
for i=layer:layers_num:g.get('LAYERNUMBER')
    m2(count) = m(i);
    count = count + 1;
end
pf.memorize('ST_LINE').set('X', x, 'Y', m2)

if ~isempty(m2)
    if isempty(x) 
        pf.memorize('ST_AREA').set('X', [1 1:1:length(m2) length(m2)], 'Y', [0 m2 0])
    else
        pf.memorize('ST_AREA').set('X', [x(1) x x(end)], 'Y', [0 m2 0])
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

%% ¡props!

%%% ¡prop!
LAYER (figure, scalar) is the layer number of the global measure.
%%%% ¡default!
1
%%%% ¡postset!
pf.get('SETUP');
%%%% ¡gui!
pr = MeasurePF_xUPP_Layer('EL', pf, 'PROP', MeasurePF_GU.LAYER);

%% ¡tests!

%%% ¡excluded_props!
[MeasurePF_GU.PARENT MeasurePF_GU.H MeasurePF_GU.ST_POSITION MeasurePF_GU.ST_AXIS MeasurePF_GU.M MeasurePF_GU.ST_AREA MeasurePF_GU.ST_LINE MeasurePF_GU.ST_TITLE MeasurePF_GU.ST_XLABEL MeasurePF_GU.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasurePF_GU'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasurePF_GU'])
