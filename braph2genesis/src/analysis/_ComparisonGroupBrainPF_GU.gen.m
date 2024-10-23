%% ¡header!
ComparisonGroupBrainPF_GU < ComparisonGroupBrainPF (pf, panel global unilayer group comparison on brain surface figure) is the base element to plot a global unilayer group comparison on brain surface figure.

%%% ¡description!
ComparisonGroupBrainPF_GU manages the basic functionalities to plot of a global unilayer group comparison on brain surface figure.

%%% ¡seealso!
ComparisonGroup

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_GU.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_GU.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_GU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_GU.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_GU.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_GU.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF_GU.ST_AXIS
%%%% ¡title!
AXIS

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonGroupBrainPF_GU'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure global unilayer group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_GU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure global unilayer group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_GU manages the basic functionalities to plot of a global unilayer group comparison on brain surface figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure global unilayer group comparison on brain surface figure.
%%%% ¡settings!
'ComparisonGroupBrainPF_GU'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure global unilayer group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_GU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure global unilayer group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_GU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure global unilayer group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF_GU notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison on brain surface figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡props!

%%% ¡prop!
NODES (figure, rvector) are the node numbers of the global group comparison figure on brain surface.
%%%% ¡_gui!
% % % bas = pf.get('M').get('G').get('BAS');
% % % ba = bas{1};
% % % 
% % % pr = PP_BrainRegion('EL', pf, 'PROP', PFMeasureNU.BR1_ID, ...
% % %     'BA', ba, ...
% % %     varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[ComparisonGroupBrainPF_GU.PARENT ComparisonGroupBrainPF_GU.H ComparisonGroupBrainPF_GU.ST_POSITION ComparisonGroupBrainPF_GU.ST_AXIS ComparisonGroupBrainPF_GU.ST_SURFACE ComparisonGroupBrainPF_GU.ST_AMBIENT ComparisonGroupBrainPF_GU.CP] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonGroupBrainPF_GU'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonGroupBrainPF_GU'])
