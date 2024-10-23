%% ¡header!
MeasurePF_GB < MeasurePF (pf, panel figure for global bilayer measure) is the base element to plot the panel figure of a global bilayer measure.

%%% ¡description!
A Panel Figure for Global Bilayer Measure (MeasurePF_GB) manages the basic functionalities to plot the panel figure of a global bilayer measure.

%%% ¡seealso!
Measure

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasurePF_GB.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
MeasurePF_GB.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
MeasurePF_GB.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasurePF_GB.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
MeasurePF_GB.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
MeasurePF_GB.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
MeasurePF_GB.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
MeasurePF_GB.ST_AREA
%%%% ¡title!
FILLED AREA

%%% ¡prop!
%%%% ¡id!
MeasurePF_GB.ST_LINE
%%%% ¡title!
MEASURE LINE

%%% ¡prop!
%%%% ¡id!
MeasurePF_GB.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
MeasurePF_GB.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
MeasurePF_GB.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel figure for global bilayer measure (MeasurePF_GB).
%%%% ¡default!
'MeasurePF_GB'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for global bilayer measure.
%%%% ¡default!
'Panel Figure for Global Bilayer Measure'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for global bilayer measure.
%%%% ¡default!
'A Panel Figure for Global Bilayer Measure (MeasurePF_GB) manages the basic functionalities to plot the panel figure of a global bilayer measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for global bilayer measure.
%%%% ¡settings!
'MeasurePF_GB'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for global bilayer measure.
%%%% ¡default!
'MeasurePF_GB ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for global bilayer measure.
%%%% ¡default!
'MeasurePF_GB label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for global bilayer measure.
%%%% ¡default!
'MeasurePF_GB notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡tests!

%%% ¡excluded_props!
[MeasurePF_GB.PARENT MeasurePF_GB.H MeasurePF_GB.ST_POSITION MeasurePF_GB.ST_AXIS MeasurePF_GB.ST_AREA MeasurePF_GB.ST_LINE MeasurePF_GB.ST_TITLE MeasurePF_GB.ST_XLABEL MeasurePF_GB.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasurePF_GB'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasurePF_GB'])
