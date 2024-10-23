%% ¡header!
ComparisonGroupBrainPF_BU < ComparisonGroupBrainPF (pf, panel binodal unilayer group comparison on brain surface figure) is the base element to plot a binodal unilayer group comparison on brain surface figure.

%%% ¡description!
ComparisonGroupBrainPF_BU manages the basic functionalities to plot of a binodal unilayer group comparison on brain surface figure.

%%% ¡seealso!
ComparisonGroup

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_BU.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_BU.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_BU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_BU.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_BU.NODES
%%%% ¡title!
NODES SELECTION

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_BU.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_BU.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_BU.ST_AXIS
%%%% ¡title!
AXIS

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonGroupBrainPF_BU'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure binodal unilayer group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_BU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure binodal unilayer group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_BU manages the basic functionalities to plot of a binodal unilayer group comparison on brain surface figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure binodal unilayer group comparison on brain surface figure.
%%%% ¡settings!
'ComparisonGroupBrainPF_BU'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure binodal unilayer group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_BU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure binodal unilayer group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_BU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure binodal unilayer group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_BU notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison on brain surface figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡props!

%%% ¡prop!
NODES (figure, rvector) are the node numbers of the binodal group comparison on brain surface figure.
%%%% ¡default!
[1 1]
%%%% ¡postset!
pf.get('SETUP')
%%%% ¡gui!
pr = ComparisonGroupPF_BxPP_Node('EL', pf, 'PROP', ComparisonGroupBrainPF_BU.NODES);

%% ¡tests!

%%% ¡excluded_props!
[ComparisonGroupBrainPF_BU.PARENT ComparisonGroupBrainPF_BU.H ComparisonGroupBrainPF_BU.ST_POSITION ComparisonGroupBrainPF_BU.ST_AXIS ComparisonGroupBrainPF_BU.ST_SURFACE ComparisonGroupBrainPF_BU.ST_AMBIENT ComparisonGroupBrainPF_BU.CP] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonGroupBrainPF_BU'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonGroupBrainPF_BU'])
