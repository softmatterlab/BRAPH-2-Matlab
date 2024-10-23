%% ¡header!
MeasureEnsembleBrainPF_BB < MeasureEnsembleBrainPF (pf, panel figure for binodal bilayer measure group brain) is a plot of a binodal bilayer measure group brain.

%%% ¡description!
A Panel Figure for a Brain Measure of Analyze Group (MeasureEnsembleBrainPF_BB) manages the plot of the binodal bilayer measure
 ploted over the brain.  
MeasureEnsembleBrainPF_BB  utilizes the surface created from BrainAtlasPF to integrate 
 the binodal bilayer meaure into the brain regions.

%%% ¡seealso!
BrainAtlas, BrainSurface, BrainAtlasPF

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % %.
%%%% ¡default!
'MeasureEnsembleBrainPF_BB'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for measure group brain.
%%%% ¡default!
'Panel Figure for Measure Group Brain'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.
%%%% ¡default!
'A Panel Figure for a Brain Measure of Analyze Group (MeasureEnsembleBrainPF_BB) manages the plot of the binodal bilayer measure ploted over the brain. MeasureEnsembleBrainPF_BB  utilizes the surface created from BrainAtlasPF to integrate the binodal bilayer meaure into the brain regions.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.
%%%% ¡settings!
'MeasureEnsembleBrainPF_BB'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for measure group brain.
%%%% ¡default!
'MeasureEnsembleBrainPF_BB ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for measure group brain.
%%%% ¡default!
'MeasureEnsembleBrainPF_BB label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.
%%%% ¡default!
'MeasureEnsembleBrainPF_BB notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it to be ploted on a brain surface.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡tests!

%%% ¡excluded_props!
[MeasureEnsembleBrainPF_BB.PARENT MeasureEnsembleBrainPF_BB.H MeasureEnsembleBrainPF_BB.ST_POSITION MeasureEnsembleBrainPF_BB.ST_AXIS MeasureEnsembleBrainPF_BB.ST_SURFACE MeasureEnsembleBrainPF_BB.ST_AMBIENT MeasureEnsembleBrainPF_BB.ME]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasureEnsembleBrainPF_BB'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasureEnsembleBrainPF_BB'])