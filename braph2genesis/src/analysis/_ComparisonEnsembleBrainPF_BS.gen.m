%% ¡header!
ComparisonEnsembleBrainPF_BS < ComparisonEnsembleBrainPF (pf, panel binodal superglobal ensemble-based comparison figure on brain surface figure) is the base element to plot a binodal superglobal ensemble-based comparison figure on brain surface figure.

%%% ¡description!
ComparisonEnsembleBrainPF_BS manages the basic functionalities to plot of a binodal superglobal ensemble-based comparison figure on brain surface figure.

%%% ¡seealso!
ComparisonEnsemble

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonEnsembleBrainPF_BS'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure binodal superglobal ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_BS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure binodal superglobal ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_BS manages the basic functionalities to plot of a binodal superglobal ensemble-based comparison figure on brain surface.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure binodal superglobal ensemble-based comparison figure on brain surface.
%%%% ¡settings!
'ComparisonEnsembleBrainPF_BS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure binodal superglobal ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_BS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure binodal superglobal ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_BS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure binodal superglobal ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF_BS notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡props!

%%% ¡prop!
NODES (figure, rvector) are the node numbers of the binodal group comparison figure on brain surface.
%%%% ¡_gui!
% % % bas = pf.get('M').get('G').get('BAS');
% % % ba = bas{1};
% % % 
% % % pr = PP_BrainRegion('EL', pf, 'PROP', PFMeasureNU.BR1_ID, ...
% % %     'BA', ba, ...
% % %     varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[ComparisonEnsembleBrainPF_BS.PARENT ComparisonEnsembleBrainPF_BS.H ComparisonEnsembleBrainPF_BS.ST_POSITION ComparisonEnsembleBrainPF_BS.ST_AXIS ComparisonEnsembleBrainPF_BS.ST_SURFACE ComparisonEnsembleBrainPF_BS.ST_AMBIENT] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonEnsembleBrainPF_BS'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonEnsembleBrainPF_BS'])
