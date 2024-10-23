%% ¡header!
ComparisonEnsembleBrainPF_NB < ComparisonEnsembleBrainPF (pf, panel nodal bilayer ensemble-based comparison figure on brain surface figure) is the base element to plot a nodal bilayer ensemble-based comparison figure on brain surface figure.

%%% ¡description!
ComparisonEnsembleBrainPF_NB manages the basic functionalities to plot of a nodal bilayer ensemble-based comparison figure on brain surface figure.

%%% ¡seealso!
ComparisonEnsemble

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonEnsembleBrainPF_NB'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure nodal bilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_NB'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure nodal bilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_NB manages the basic functionalities to plot of a nodal bilayer ensemble-based comparison figure on brain surface.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure nodal bilayer ensemble-based comparison figure on brain surface.
%%%% ¡settings!
'ComparisonEnsembleBrainPF_NB'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure nodal bilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_NB ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure nodal bilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_NB label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure nodal bilayer ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_NB notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡props!

%%% ¡prop!
NODES (figure, rvector) are the node numbers of the nodal group comparison figure on brain surface.
%%%% ¡_gui!
% % % bas = pf.get('M').get('G').get('BAS');
% % % ba = bas{1};
% % % 
% % % pr = PP_BrainRegion('EL', pf, 'PROP', PFMeasureNU.BR1_ID, ...
% % %     'BA', ba, ...
% % %     varargin{:});

%% ¡tests!superglobal

%%% ¡excluded_props!
[ComparisonEnsembleBrainPF_NB.PARENT ComparisonEnsembleBrainPF_NB.H ComparisonEnsembleBrainPF_NB.ST_POSITION ComparisonEnsembleBrainPF_NB.ST_AXIS ComparisonEnsembleBrainPF_NB.ST_SURFACE ComparisonEnsembleBrainPF_NB.ST_AMBIENT] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonEnsembleBrainPF_NB'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonEnsembleBrainPF_NB'])
