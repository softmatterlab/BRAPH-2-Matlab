%% ¡header!
NNxMLP_FeatureImportanceBrainSurfacePF < BrainAtlasPF (pf, panel figure for feature importance brain) is a plot of a feature importance brain.

%%% ¡description!
A panel figure for the neural networks feature importance on brain surface (NNxMLP_FeatureImportanceBrainSurfacePF) manages the plot
 of the feature importance ploted over the brain.  
NNxMLP_FeatureImportanceBrainSurfacePF utilizes the surface created from BrainAtlasPF to integrate 
 the feature importance values into the brain regions.

%%% ¡seealso!
NNxMLP_FeatureImportanceBrainSurface

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel figure for the neural networks feature importance on brain surface.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurfacePF'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for the neural networks feature importance on brain surface.
%%%% ¡default!
'Panel Figure for Neural Networks Feature Impoortance on Brain Surface'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for neural networks feature importance on brain surface.
%%%% ¡default!
'A panel figure for neural networks feature importance on brain surface (NNxMLP_FeatureImportanceBrainSurfacePF) manages the plot of the feature importance ploted over the brain. NNxMLP_FeatureImportanceBrainSurfacePF utilizes the surface created from BrainAtlasPF to integrate the feature importance values into the brain regions.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for neural networks feature importance on brain surface.
%%%% ¡settings!
'NNxMLP_FeatureImportanceBrainSurfacePF'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for neural networks feature importance on brain surface.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurfacePF ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for neural networks feature importance on brain surface.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurfacePF label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for neural networks feature importance on brain surface.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurfacePF notes'

%%% ¡prop!
DRAW (query, logical) draws the figure brain atlas.
%%%% ¡calculate!
value = calculateValue@BrainAtlasPF(pf, NNxMLP_FeatureImportanceBrainSurfacePF.DRAW, varargin{:}); % also warning
if value    
    % trigger setup
    pf.get('SETUP');
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel figure brain surface is deleted.
%%%% ¡calculate!
value = calculateValue@BrainAtlasPF(pf, NNxMLP_FeatureImportanceBrainSurfacePF.DELETE, varargin{:}); % also warning
if value
    % do nothing
end

%% ¡props!

%%% ¡prop!
FI (metadata, cell) is the feature importance value.

%%% ¡prop!
D (metadata, item) is the NN dataset.
%%%% ¡settings!
'NNDataset'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it to be implemented in the subelements.
%%%% ¡calculate!
value = [];

%% ¡tests!

%%% ¡excluded_props!
[NNxMLP_FeatureImportanceBrainSurfacePF.PARENT NNxMLP_FeatureImportanceBrainSurfacePF.H NNxMLP_FeatureImportanceBrainSurfacePF.ST_POSITION NNxMLP_FeatureImportanceBrainSurfacePF.ST_AXIS NNxMLP_FeatureImportanceBrainSurfacePF.ST_SURFACE NNxMLP_FeatureImportanceBrainSurfacePF.ST_AMBIENT NNxMLP_FeatureImportanceBrainSurfacePF.FI NNxMLP_FeatureImportanceBrainSurfacePF.D]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePF'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePF'])
