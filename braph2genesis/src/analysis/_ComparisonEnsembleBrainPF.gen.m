%% ¡header!
ComparisonEnsembleBrainPF < BrainAtlasPF (pf, panel ensemble-based comparison figure on brain surface figure) is the base element to plot an ensemble-based comparison on brain surface figure.

%%% ¡description!
ComparisonEnsembleBrainPF manages the basic functionalities to plot of an ensemble-based comparison on brain surface figure.

%%% ¡seealso!
ComparisonEnsemble

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.VIEW
%%%% ¡title!
3D VIEW

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.BRAIN
%%%% ¡title!
BRAIN ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.SURFFILE
%%%% ¡title!
BRAIN SURFACE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.ST_SURFACE
%%%% ¡title!
BRAIN COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.ST_AMBIENT
%%%% ¡title!
MATERIAL & LIGHTNING

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.SPHS
%%%% ¡title!
Brain Region SPHERES ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.SPH_DICT
%%%% ¡title!
Brain Region SPHERES PROPERTIES

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.SYMS
%%%% ¡title!
Brain Region SYMBOLS ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.SYM_DICT
%%%% ¡title!
Brain Region SYMBOLS PROPERTIES

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.IDS
%%%% ¡title!
Brain Region IDs ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.ID_DICT
%%%% ¡title!
Brain Region IDs PROPERTIES

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.LABS
%%%% ¡title!
Brain Region LABELS ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.LAB_DICT
%%%% ¡title!
Brain Region LABELS PROPERTIES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of % % % .
%%%% ¡default!
'ComparisonEnsembleBrainPF'

%%% ¡prop!
NAME (constant, string) is the name of the panel ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF manages the basic functionalities to plot of an ensemble-based comparison on brain surface.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel ensemble-based comparison figure on brain surface.
%%%% ¡settings!
'ComparisonEnsembleBrainPF'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF notes'

%%% ¡prop!
DRAW (query, logical) draws the figure brain atlas.
%%%% ¡calculate!
value = calculateValue@BrainAtlasPF(pf, ComparisonEnsembleBrainPF.DRAW, varargin{:}); % also warning
if value
    pf.get('SETUP')
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel figure brain surface is deleted.
%%%% ¡calculate!
value = calculateValue@BrainAtlasPF(pf, ComparisonEnsembleBrainPF.DELETE, varargin{:}); % also warning
if value
    pf.set('H_SPHS', Element.getNoValue())
    pf.set('H_SYMS', Element.getNoValue())
    pf.set('H_IDS', Element.getNoValue())
    pf.set('H_LABS', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
CP (metadata, item) is the measure.
%%%% ¡settings!
'ComparisonEnsemble'

%%% ¡prop!
SETUP (query, empty) calculates the diff value and stores it to be implemented in the subelements.
%%%% ¡calculate!
value = [];

%% ¡tests!

%%% ¡excluded_props!
[ComparisonEnsembleBrainPF.PARENT ComparisonEnsembleBrainPF.H ComparisonEnsembleBrainPF.ST_POSITION ComparisonEnsembleBrainPF.ST_AXIS ComparisonEnsembleBrainPF.ST_SURFACE ComparisonEnsembleBrainPF.ST_AMBIENT ComparisonEnsembleBrainPF.CP]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonEnsembleBrainPF'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonEnsembleBrainPF'])
