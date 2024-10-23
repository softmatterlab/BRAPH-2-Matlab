%% ¡header!
MeasureEnsembleBrainPF_GU < MeasureEnsembleBrainPF (pf, panel figure for global unilayer measure group brain) is a plot of a global unilayer measure group brain.

%%% ¡description!
A Panel Figure for a Brain Measure of Analyze Group (MeasureEnsembleBrainPF_GU) manages the plot of the global unilayer measure
 ploted over the brain.  
MeasureEnsembleBrainPF_GU utilizes the surface created from BrainAtlasPF to integrate 
 the global unilayer meaure into the brain regions.

%%% ¡seealso!
BrainAtlas, BrainSurface, BrainAtlasPF

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % %.
%%%% ¡default!
'MeasureEnsembleBrainPF_GU'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for measure group brain.
%%%% ¡default!
'Panel Figure for Measure Group Brain'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.
%%%% ¡default!
'A Panel Figure for a Brain Measure of Analyze Group (MeasureEnsembleBrainPF_GU) manages the plot of the global unilayer measure ploted over the brain. MeasureEnsembleBrainPF_GU  utilizes the surface created from BrainAtlasPF to integrate the global unilayer meaure into the brain regions.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.
%%%% ¡settings!
'MeasureEnsembleBrainPF_GU'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for measure group brain.
%%%% ¡default!
'MeasureEnsembleBrainPF_GU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for measure group brain.
%%%% ¡default!
'MeasureEnsembleBrainPF_GU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.
%%%% ¡default!
'MeasureEnsembleBrainPF_GU notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it to be ploted on a brain surface.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡tests!

%%% ¡excluded_props!
[MeasureEnsembleBrainPF_GU.PARENT MeasureEnsembleBrainPF_GU.H MeasureEnsembleBrainPF_GU.ST_POSITION MeasureEnsembleBrainPF_GU.ST_AXIS MeasureEnsembleBrainPF_GU.ST_SURFACE MeasureEnsembleBrainPF_GU.ST_AMBIENT MeasureEnsembleBrainPF_GU.ME]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasureEnsembleBrainPF_GU'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasureEnsembleBrainPF_GU'])