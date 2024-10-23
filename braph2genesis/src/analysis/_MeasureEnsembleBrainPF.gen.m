%% ¡header!
MeasureEnsembleBrainPF < BrainAtlasPF (pf, panel figure for measure group brain) is a plot of a measure group brain.

%%% ¡description!
A Panel Figure for a Brain Measure of Analyze Group (MeasureEnsembleBrainPF) manages the plot of the measure
 ploted over the brain.  
MeasureEnsembleBrainPF utilizes the surface created from BrainAtlasPF to integrate 
 the meaure into the brain regions.

%%% ¡seealso!
BrainAtlas, BrainSurface, BrainAtlasPF

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % %.
%%%% ¡default!
'MeasureEnsembleBrainPF'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for measure group brain.
%%%% ¡default!
'Panel Figure for Measure Group Brain'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.
%%%% ¡default!
'A Panel Figure for a Brain Measure of Analyze Group (MeasureEnsembleBrainPF) manages the plot of the measure ploted over the brain. MeasureEnsembleBrainPF utilizes the surface created from BrainAtlasPF to integrate the meaure into the brain regions.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.
%%%% ¡settings!
'MeasureEnsembleBrainPF'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for measure group brain.
%%%% ¡default!
'MeasureEnsembleBrainPF ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for measure group brain.
%%%% ¡default!
'MeasureEnsembleBrainPF label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.
%%%% ¡default!
'MeasureEnsembleBrainPF notes'

%%% ¡prop!
DRAW (query, logical) draws the figure brain atlas.
%%%% ¡calculate!
value = calculateValue@BrainAtlasPF(pf, MeasureEnsembleBrainPF.DRAW, varargin{:}); % also warning
if value    
    % trigger setup
    pf.get('SETUP');
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel figure brain surface is deleted.
%%%% ¡calculate!
value = calculateValue@BrainAtlasPF(pf, MeasureEnsembleBrainPF.DELETE, varargin{:}); % also warning
if value
    % do nothing
end

%% ¡props!

%%% ¡prop!
ME (metadata, item) is the measure ensemble.
%%%% ¡settings!
'MeasureEnsemble'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it to be implemented in the subelements.
%%%% ¡calculate!
value = [];

%% ¡tests!

%%% ¡excluded_props!
[MeasureEnsembleBrainPF.PARENT MeasureEnsembleBrainPF.H MeasureEnsembleBrainPF.ST_POSITION MeasureEnsembleBrainPF.ST_AXIS MeasureEnsembleBrainPF.ST_SURFACE MeasureEnsembleBrainPF.ST_AMBIENT MeasureEnsembleBrainPF.ME]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasureEnsembleBrainPF'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasureEnsembleBrainPF'])
