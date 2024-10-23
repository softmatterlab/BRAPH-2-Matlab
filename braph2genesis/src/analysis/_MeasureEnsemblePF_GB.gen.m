%% ¡header!
MeasureEnsemblePF_GB < MeasureEnsemblePF (pf, panel global bilayer group comparison figure) is the base element to plot a global bilayer group comparison figure.

%%% ¡description!
MeasureEnsemblePF_GB manages the basic functionalities to plot of a global bilayer group comparison figure.

%%% ¡seealso!
MeasureEnsemble

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GB.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GB.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GB.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GB.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GB.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GB.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GB.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GB.ST_LINE_M
%%%% ¡title!
MEASURE

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GB.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GB.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
MeasureEnsemblePF_GB.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'MeasureEnsemblePF_GB'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure global bilayer group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_GB'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure global bilayer group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_GB manages the basic functionalities to plot of a global bilayer group comparison figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure global bilayer group comparison figure.
%%%% ¡settings!
'MeasureEnsemblePF_GB'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure global bilayer group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_GB ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure global bilayer group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_GB label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure global bilayer group comparison figure.
%%%% ¡default!
'MeasureEnsemblePF_GB notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡tests!

%%% ¡excluded_props!
[MeasureEnsemblePF_GB.PARENT MeasureEnsemblePF_GB.H MeasureEnsemblePF_GB.ST_POSITION MeasureEnsemblePF_GB.ST_AXIS MeasureEnsemblePF_GB.ST_AREA MeasureEnsemblePF_GB.ST_LINE_M MeasureEnsemblePF_GB.ST_TITLE MeasureEnsemblePF_GB.ST_XLABEL MeasureEnsemblePF_GB.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasureEnsemblePF_GB'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasureEnsemblePF_GB'])
