%% ¡header!
ComparisonGroupPF_GB < ComparisonGroupPF (pf, panel global bilayer group comparison figure) is the base element to plot a global bilayer group comparison figure.

%%% ¡description!
ComparisonGroupPF_GB manages the basic functionalities to plot of a global bilayer group comparison figure.

%%% ¡seealso!
ComparisonGroup

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GB.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GB.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GB.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GB.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GB.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GB.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GB.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GB.ST_LINE_DIFF
%%%% ¡title!
DIFFERENCE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GB.ST_AREA
%%%% ¡title!
CONFIDENCE AREA (95%)

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GB.ST_LINE_CIL
%%%% ¡title!
LOWER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GB.ST_LINE_CIU
%%%% ¡title!
UPPER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GB.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GB.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_GB.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonGroupPF_GB'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure global bilayer group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_GB'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure global bilayer group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_GB manages the basic functionalities to plot of a global bilayer group comparison figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure global bilayer group comparison figure.
%%%% ¡settings!
'ComparisonGroupPF_GB'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure global bilayer group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_GB ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure global bilayer group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_GB label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure global bilayer group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_GB notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡tests!

%%% ¡excluded_props!
[ComparisonGroupPF_GB.PARENT ComparisonGroupPF_GB.H ComparisonGroupPF_GB.ST_POSITION ComparisonGroupPF_GB.ST_AXIS ComparisonGroupPF_GB.CP ComparisonGroupPF_GB.ST_AREA ComparisonGroupPF_GB.ST_LINE_DIFF ComparisonGroupPF_GB.ST_LINE_CIL ComparisonGroupPF_GB.ST_LINE_CIU ComparisonGroupPF_GB.ST_TITLE ComparisonGroupPF_GB.ST_XLABEL ComparisonGroupPF_GB.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonGroupPF_GB'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonGroupPF_GB'])
