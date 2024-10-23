%% ¡header!
MeasureGroupBrainPF_NB < MeasureGroupBrainPF (pf, panel figure for nodal bilayer measure group brain) is a plot of a nodal bilayer measure group brain.

%%% ¡description!
A Panel Figure for a Brain Measure of Analyze Group (MeasureGroupBrainPF_NB) manages the plot of the nodal bilayer measure
 ploted over the brain.  
MeasureGroupBrainPF_NB  utilizes the surface created from BrainAtlasPF to integrate 
 the nodal bilayer meaure into the brain regions.

%%% ¡seealso!
BrainAtlas, BrainSurface, BrainAtlasPF

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % %.
%%%% ¡default!
'MeasureGroupBrainPF_NB'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for measure group brain.
%%%% ¡default!
'Panel Figure for Measure Group Brain'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.
%%%% ¡default!
'A Panel Figure for a Brain Measure of Analyze Group (MeasureGroupBrainPF_NB) manages the plot of the nodal bilayer measure ploted over the brain. MeasureGroupBrainPF_NB  utilizes the surface created from BrainAtlasPF to integrate the nodal bilayer meaure into the brain regions.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.
%%%% ¡settings!
'MeasureGroupBrainPF_NB'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for measure group brain.
%%%% ¡default!
'MeasureGroupBrainPF_NB ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for measure group brain.
%%%% ¡default!
'MeasureGroupBrainPF_NB label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.
%%%% ¡default!
'MeasureGroupBrainPF_NB notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it to be ploted on a brain surface.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡tests!

%%% ¡excluded_props!
[MeasureGroupBrainPF_NB.PARENT MeasureGroupBrainPF_NB.H MeasureGroupBrainPF_NB.ST_POSITION MeasureGroupBrainPF_NB.ST_AXIS MeasureGroupBrainPF_NB.ST_SURFACE MeasureGroupBrainPF_NB.ST_AMBIENT MeasureGroupBrainPF_NB.M]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasureGroupBrainPF_NB'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasureGroupBrainPF_NB'])
