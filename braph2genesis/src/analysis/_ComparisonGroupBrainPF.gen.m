%% ¡header!
ComparisonGroupBrainPF < BrainAtlasPF (pf, brain panel group comparison on brain surface figure) is the base element to plot a group comparison on brain surface.

%%% ¡description!
ComparisonGroupBrainPF manages the basic functionalities to plot of a group comparison on brain surface.

%%% ¡seealso!
ComparisonGroup, BrainAtlasPF

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonGroupBrainPF.ST_AXIS
%%%% ¡title!
AXIS

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the  % % % .
%%%% ¡default!
'ComparisonGroupBrainPF'

%%% ¡prop!
NAME (constant, string) is the name of the brain panel group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the brain panel group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF manages the basic functionalities to plot of a group comparison on brain surface.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the brain panel group comparison on brain surface figure.
%%%% ¡settings!
'ComparisonGroupBrainPF'

%%% ¡prop!
ID (data, string) is a few-letter code for the brain panel group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the brain panel group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the brain panel group comparison on brain surface figure.
%%%% ¡default!
'ComparisonGroupBrainPF notes'

%%% ¡prop!
DRAW (query, logical) draws the figure comparison figure.
%%%% ¡calculate!
value = calculateValue@BrainAtlasPF(pf, BrainAtlasPF.DRAW, varargin{:}); % also warning
if value
    pf.get('SETUP')
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the brain panel figure graph is deleted.
%%%% ¡calculate!
value = calculateValue@BrainAtlasPF(pf, BrainAtlasPF.DELETE, varargin{:}); % also warning
if value
    % do nothing

end

%%% ¡prop!
H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
%%%% ¡calculate!
toolbar = pf.memorize('H_TOOLBAR');
if check_graphics(toolbar, 'uitoolbar')
    value = calculateValue@BrainAtlasPF(pf, BrainAtlasPF.H_TOOLS, varargin{:});
    
    % tool_separator_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
    % 
    % value = {value{:}, ...
    %     tool_separator_1,  ...
    %     };
else
    value = {};
end

%% ¡props!

%%% ¡prop!
CP (metadata, item) is the group comparison on brain surface.
%%%% ¡settings!
'ComparisonGroup'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison on brain surface value and stores it to be implemented in the subelements.
%%%% ¡calculate!
value = [];

%% ¡tests!

%%% ¡excluded_props!
[ComparisonGroupBrainPF.PARENT ComparisonGroupBrainPF.H ComparisonGroupBrainPF.ST_POSITION ComparisonGroupBrainPF.ST_AXIS ComparisonGroupBrainPF.ST_SURFACE ComparisonGroupBrainPF.ST_AMBIENT ComparisonGroupBrainPF.CP]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonGroupBrainPF'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonGroupBrainPF'])