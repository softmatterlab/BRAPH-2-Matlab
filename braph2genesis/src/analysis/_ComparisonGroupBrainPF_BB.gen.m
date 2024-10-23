%% ¡header!
ComparisonGroupBrainPF_BB < ComparisonGroupBrainPF (pf, panel binodal bilayer group comparison on brain surface figure) is the base element to plot a binodal bilayer group comparison on brain surface figure.

%%% ¡description!
ComparisonGroupBrainPF_BB manages the basic functionalities to plot of a binodal bilayer group comparison on brain surface figure.

%%% ¡seealso!
ComparisonGroup

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_BB.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_BB.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_BB.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_BB.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_BB.NODES
%%%% ¡title!
NODES SELECTION

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_BB.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_BB.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_BB.ST_AXIS
%%%% ¡title!
AXIS


%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the  % % % .
%%%% ¡default!
'ComparisonGroupBrainPF_BB'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure binodal bilayer group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_BB'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure binodal bilayer group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_BB manages the basic functionalities to plot of a binodal bilayer group comparison on brain surface figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure binodal bilayer group comparison on brain surface figure.
%%%% ¡settings!
'ComparisonGroupBrainPF_BB'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure binodal bilayer group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_BB ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure binodal bilayer group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_BB label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure binodal bilayer group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_BB notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison on brain surface figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡props!

%%% ¡prop!
NODES (figure, rvector) are the node numbers of the binodal group comparison on brain surface figure.
%%%% ¡gui!
pr = ComparisonGroupPF_BxPP_Node('EL', pf, 'PROP', ComparisonGroupBrainPF_BB.NODES);

%% ¡tests!

%%% ¡excluded_props!
[ComparisonGroupBrainPF_BB.PARENT ComparisonGroupBrainPF_BB.H ComparisonGroupBrainPF_BB.ST_POSITION ComparisonGroupBrainPF_BB.ST_AXIS ComparisonGroupBrainPF_BB.ST_SURFACE ComparisonGroupBrainPF_BB.ST_AMBIENT ComparisonGroupBrainPF_BB.CP] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonGroupBrainPF_BB'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonGroupBrainPF_BB'])
