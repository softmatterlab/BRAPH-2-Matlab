%% ¡header!
ComparisonGroupPF_BB < ComparisonGroupPF (pf, panel figure binodal bilayer measure) is the base element to plot a binodal bilayer measure.

%%% ¡description!
ComparisonGroupPF_BB manages the basic functionalities to plot of a binodal bilayer measure.

%%% ¡seealso!
Measure

%% ¡_layout!

% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BB.ID
% % % %%%% ¡title!
% % % Brain Atlas Figure ID
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BB.LABEL
% % % %%%% ¡title!
% % % Brain Atlas Figure NAME
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BB.WAITBAR
% % % %%%% ¡title!
% % % WAITBAR ON/OFF
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BB.NOTES
% % % %%%% ¡title!
% % % Brain Atlas NOTES
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BB.BKGCOLOR
% % % %%%% ¡title!
% % % BACKGROUND COLOR
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BB.ST_POSITION
% % % %%%% ¡title!
% % % PANEL POSITION
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BB.ST_AXIS
% % % %%%% ¡title!
% % % AXIS
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BB.ST_AREA
% % % %%%% ¡title!
% % % FILLED AREA
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BB.ST_LINE
% % % %%%% ¡title!
% % % MEASURE LINE
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BB.ST_TITLE
% % % %%%% ¡title!
% % % TITLE
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BB.ST_XLABEL
% % % %%%% ¡title!
% % % X-LABEL
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BB.ST_YLABEL
% % % %%%% ¡title!
% % % Y-LABEL
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BB.NODES
% % % %%%% ¡title!
% % % NODES SELECTION

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the panel figure binodal bilayer measure.
%%%% ¡default!
'ComparisonGroupPF_BB'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure binodal bilayer measure.
%%%% ¡default!
'ComparisonGroupPF_BB manages the basic functionalities to plot of a binodal bilayer measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure binodal bilayer measure.
%%%% ¡settings!
'ComparisonGroupPF_BB'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure binodal bilayer measure.
%%%% ¡default!
'ComparisonGroupPF_BB ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure binodal bilayer measure.
%%%% ¡default!
'ComparisonGroupPF_BB label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure binodal bilayer measure.
%%%% ¡default!
'ComparisonGroupPF_BB notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡props!

%%% ¡prop!
NODES (figure, rvector) are the node numbers of the binodal measure.
%%%% ¡_gui!
% % % bas = pf.get('M').get('G').get('BAS');
% % % ba = bas{1};
% % % 
% % % pr = PP_BrainRegion('EL', pf, 'PROP', PFMeasureNU.BR1_ID, ...
% % %     'BA', ba, ...
% % %     varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[ComparisonGroupPF_BB.PARENT ComparisonGroupPF_BB.H ComparisonGroupPF_BB.ST_POSITION ComparisonGroupPF_BB.ST_AXIS ComparisonGroupPF_BB.ST_AREA ComparisonGroupPF_BB.ST_LINE ComparisonGroupPF_BB.ST_TITLE ComparisonGroupPF_BB.ST_XLABEL ComparisonGroupPF_BB.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡parallel!
false
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonGroupPF_BB'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonGroupPF_BB'])
