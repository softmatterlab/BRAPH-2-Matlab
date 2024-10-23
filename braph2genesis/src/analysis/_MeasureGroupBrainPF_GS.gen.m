%% ¡header!
MeasureGroupBrainPF_GS < MeasureGroupBrainPF (pf, panel figure for global superglobal measure group brain) is a plot of a global superglobal measure group brain.

%%% ¡description!
A Panel Figure for a Brain Measure of Analyze Group (MeasureGroupBrainPF_GS) manages the plot of the global superglobal measure
 ploted over the brain.  
MeasureGroupBrainPF_GS utilizes the surface created from BrainAtlasPF to integrate 
 the global superglobal meaure into the brain regions.

%%% ¡seealso!
BrainAtlas, BrainSurface, BrainAtlasPF

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % %.
%%%% ¡default!
'MeasureGroupBrainPF_GS'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for measure group brain.
%%%% ¡default!
'Panel Figure for Measure Group Brain'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.
%%%% ¡default!
'A Panel Figure for a Brain Measure of Analyze Group (MeasureGroupBrainPF_GS) manages the plot of the global superglobal measure ploted over the brain. MeasureGroupBrainPF_GS  utilizes the surface created from BrainAtlasPF to integrate the global superglobal meaure into the brain regions.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.
%%%% ¡settings!
'MeasureGroupBrainPF_GS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for measure group brain.
%%%% ¡default!
'MeasureGroupBrainPF_GS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for measure group brain.
%%%% ¡default!
'MeasureGroupBrainPF_GS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.
%%%% ¡default!
'MeasureGroupBrainPF_GS notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it to be ploted on a brain surface.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡tests!

%%% ¡excluded_props!
[MeasureGroupBrainPF_GS.PARENT MeasureGroupBrainPF_GS.H MeasureGroupBrainPF_GS.ST_POSITION MeasureGroupBrainPF_GS.ST_AXIS MeasureGroupBrainPF_GS.ST_SURFACE MeasureGroupBrainPF_GS.ST_AMBIENT MeasureGroupBrainPF_GS.M]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasureGroupBrainPF_GS'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasureGroupBrainPF_GS'])