%% ¡header!
ComparisonEnsemblePF_NB < ComparisonEnsemblePF (pf, panel nodal bilayer group comparison figure) is the base element to plot a nodal bilayer group comparison figure.

%%% ¡description!
ComparisonEnsemblePF_NB manages the basic functionalities to plot of a nodal bilayer group comparison figure.

%%% ¡seealso!
ComparisonEnsemble

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NB.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NB.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NB.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NB.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NB.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NB.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NB.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NB.NODE
%%%% ¡title!
NODE SELECTION

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NB.ST_LINE_DIFF
%%%% ¡title!
DIFFERENCE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NB.ST_AREA
%%%% ¡title!
CONFIDENCE AREA (95%)

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NB.ST_LINE_CIL
%%%% ¡title!
LOWER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NB.ST_LINE_CIU
%%%% ¡title!
UPPER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NB.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NB.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemblePF_NB.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonEnsemblePF_NB'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure nodal bilayer group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_NB'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure nodal bilayer group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_NB manages the basic functionalities to plot of a nodal bilayer group comparison figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure nodal bilayer group comparison figure.
%%%% ¡settings!
'ComparisonEnsemblePF_NB'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure nodal bilayer group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_NB ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure nodal bilayer group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_NB label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure nodal bilayer group comparison figure.
%%%% ¡default!
'ComparisonEnsemblePF_NB notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡props!

%%% ¡prop!
NODE (figure, scalar) is the node number of the nodal group comparison figure.
%%%% ¡_gui!
% % % bas = pf.get('M').get('G').get('BAS');
% % % ba = bas{1};
% % % 
% % % pr = PP_BrainRegion('EL', pf, 'PROP', PFMeasureNU.BR1_ID, ...
% % %     'BA', ba, ...
% % %     varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[ComparisonEnsemblePF_NB.PARENT ComparisonEnsemblePF_NB.H ComparisonEnsemblePF_NB.ST_POSITION ComparisonEnsemblePF_NB.ST_AXIS ComparisonEnsemblePF_NB.ST_AREA ComparisonEnsemblePF_NB.ST_LINE_DIFF ComparisonEnsemblePF_NB.ST_LINE_CIL ComparisonEnsemblePF_NB.ST_LINE_CIU ComparisonEnsemblePF_NB.ST_TITLE ComparisonEnsemblePF_NB.ST_XLABEL ComparisonEnsemblePF_NB.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonEnsemblePF_NB'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonEnsemblePF_NB'])
