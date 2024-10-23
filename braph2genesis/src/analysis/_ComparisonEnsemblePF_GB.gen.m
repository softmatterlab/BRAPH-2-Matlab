%% ¡header!
ComparisonEnsemblePF_GB < ComparisonEnsemblePF (pf, panel global bilayer group comparison figure) is the base element to plot a global bilayer group comparison figure.

%%% ¡description!
ComparisonEnsemblePF_GB manages the basic functionalities to plot of a global bilayer group comparison figure.

%%% ¡seealso!
ComparisonEnsemble

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GB.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GB.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GB.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GB.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GB.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GB.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GB.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GB.ST_LINE_DIFF
%%%% ¡title!
DIFFERENCE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GB.ST_AREA
%%%% ¡title!
CONFIDENCE AREA (95%)

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GB.ST_LINE_CIL
%%%% ¡title!
LOWER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GB.ST_LINE_CIU
%%%% ¡title!
UPPER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GB.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GB.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_GB.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonEnsemblePF_GB'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure global bilayer group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_GB'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure global bilayer group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_GB manages the basic functionalities to plot of a global bilayer group comparison figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure global bilayer group comparison figure.
%%%% ¡settings!
'ComparisonEnsemblePF_GB'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure global bilayer group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_GB ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure global bilayer group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_GB label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure global bilayer group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_GB notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡tests!

%%% ¡excluded_props!
[ComparisonEnsemblePF_GB.PARENT ComparisonEnsemblePF_GB.H ComparisonEnsemblePF_GB.ST_POSITION ComparisonEnsemblePF_GB.ST_AXIS ComparisonEnsemblePF_GB.ST_AREA ComparisonEnsemblePF_GB.ST_LINE_DIFF ComparisonEnsemblePF_GB.ST_LINE_CIL ComparisonEnsemblePF_GB.ST_LINE_CIU ComparisonEnsemblePF_GB.ST_TITLE ComparisonEnsemblePF_GB.ST_XLABEL ComparisonEnsemblePF_GB.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonEnsemblePF_GB'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonEnsemblePF_GB'])
