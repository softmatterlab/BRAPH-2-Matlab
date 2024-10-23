%% ¡header!
ComparisonGroupPF_NS < ComparisonGroupPF (pf, panel nodal superglobal group comparison figure) is the base element to plot a nodal superglobal group comparison figure.

%%% ¡description!
ComparisonGroupPF_NS manages the basic functionalities to plot of a nodal superglobal group comparison figure.

%%% ¡seealso!
ComparisonGroup

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.NODE
%%%% ¡title!
NODE SELECTION

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ST_LINE_DIFF
%%%% ¡title!
DIFFERENCE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ST_AREA
%%%% ¡title!
CONFIDENCE AREA (95%)

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ST_LINE_CIL
%%%% ¡title!
LOWER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ST_LINE_CIU
%%%% ¡title!
UPPER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
ComparisonGroupPF_NS.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the ComparisonGroupPF_NS.
%%%% ¡default!
'ComparisonGroupPF_NS'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure nodal superglobal group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_NS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure nodal superglobal group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_NS manages the basic functionalities to plot of a nodal superglobal group comparison figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure nodal superglobal group comparison figure.
%%%% ¡settings!
'ComparisonGroupPF_NS'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure nodal superglobal group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_NS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure nodal superglobal group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_NS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure nodal superglobal group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_NS notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
cp = pf.get('CP');
g = cp.get('C').get('A1').get('G');

x = g.get('APARTITIONTICKS');

node = pf.get('NODE');
diff = cellfun(@(x) x(node), cp.get('DIFF'))';
cil = cellfun(@(x) x(node), cp.get('CIL'))';
ciu = cellfun(@(x) x(node), cp.get('CIU'))';

pf.memorize('ST_LINE_DIFF').set('X', x, 'Y', diff)
pf.memorize('ST_LINE_CIL').set('X', x, 'Y', cil)
pf.memorize('ST_LINE_CIU').set('X', x, 'Y', ciu)

if ~isempty(cil) && ~isempty(ciu)
    if isempty(x) 
        pf.memorize('ST_AREA').set('X', [1:1:length(diff) length(diff):-1:1], 'Y', [cil ciu(end:-1:1)])
    else
        pf.memorize('ST_AREA').set('X', [x x(end:-1:1)], 'Y', [cil ciu(end:-1:1)])
    end
end

xlim = pf.get('H_AXES').get('XLim');
ylim = pf.get('H_AXES').get('YLim');
anodelabels = g.get('ANODELABELS');
if isequal(anodelabels, {'numbered'})
    title = [cp.get('LABEL') ' ' int2str(node)];
else
    title = [cp.get('LABEL') ' ' anodelabels{node}];
end
pf.get('ST_TITLE').set( ...
    'TXT', title, ...
    'X', .5 * (xlim(2) + xlim(1)), ...
    'Y', ylim(2) + .07 * (ylim(2) - ylim(1)), ...
    'Z', 0 ...
    )
pf.get('ST_XLABEL').set( ...
    'TXT', 'Partition', ...
    'X', .5 * (xlim(2) + xlim(1)), ...
    'Y', ylim(1) - .07 * (ylim(2) - ylim(1)), ...
    'Z', 0 ...
    )
pf.get('ST_YLABEL').set( ...
	'TXT', 'Measure Value', ...
    'X', xlim(1) - .14 * (xlim(2) - xlim(1)), ...
    'Y', .5 * (ylim(2) + ylim(1)), ...
    'Z', 0 ...
    )

value = [];

%% ¡props!

%%% ¡prop!
NODE (figure, scalar) is the node number of the nodal group comparison figure.
%%%% ¡gui!
pr = ComparisonGroupPF_NxPP_Node('EL', pf, 'PROP', ComparisonGroupPF_NS.NODE);

%% ¡tests!

%%% ¡excluded_props!
[ComparisonGroupPF_NS.PARENT ComparisonGroupPF_NS.H ComparisonGroupPF_NS.ST_POSITION ComparisonGroupPF_NS.ST_AXIS ComparisonGroupPF_NS.CP ComparisonGroupPF_NS.ST_AREA ComparisonGroupPF_NS.ST_LINE_DIFF ComparisonGroupPF_NS.ST_LINE_CIL ComparisonGroupPF_NS.ST_LINE_CIU ComparisonGroupPF_NS.ST_TITLE ComparisonGroupPF_NS.ST_XLABEL ComparisonGroupPF_NS.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonGroupPF_NS'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonGroupPF_NS'])
