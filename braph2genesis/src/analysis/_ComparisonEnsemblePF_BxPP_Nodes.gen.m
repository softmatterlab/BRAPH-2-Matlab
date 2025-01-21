%% ¡header!
ComparisonEnsemblePF_BxPP_Nodes < PanelProp (pr, panel property node) plots the panel to select a couple of nodes.

%%% ¡description!
ComparisonEnsemblePF_BxPP_Nodes plots the panel to select the nodes from two drop-down lists.
It is supposed to be used with the property NODES of ComparisonEnsemblePF_BU, ComparisonEnsemblePF_BS, or ComparisonEnsemblePF_BB.

%%% ¡seealso!
uidropdown, GUI, ComparisonEnsemblePF_BU, ComparisonEnsemblePF_BS, ComparisonEnsemblePF_BB

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonEnsemblePF_BxPP_Nodes'

%%% ¡prop!
NAME (constant, string) is the name of the panel property node.
%%%% ¡default!
'ComparisonEnsemblePF_BxPP_Nodes'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel property node.
%%%% ¡default!
'ComparisonEnsemblePF_BxPP_Nodes plots the panel to select the nodes from two drop-down lists. It is supposed to be used with the property NODES of ComparisonGroupPF_BU, ComparisonGroupPF_BS, or ComparisonGroupPF_BB.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel property node.
%%%% ¡settings!
'ComparisonEnsemblePF_BxPP_Nodes'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel property node.
%%%% ¡default!
'ComparisonEnsemblePF_BxPP_Nodes ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel property node.
%%%% ¡default!
'ComparisonEnsemblePF_BxPP_Nodes label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel property node.
%%%% ¡default!
'ComparisonEnsemblePF_BxPP_Nodes notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
ComparisonEnsemblePF_BU()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
ComparisonEnsemblePF_BU.NODES

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the property panel.
%%%% ¡default!
s(4)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('DROPDOWN_NODE1')
    pr.memorize('DROPDOWN_NODE2')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the editfield.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
    pf = pr.get('EL');
    NODES = pr.get('PROP');
    
    if pf.get('CP').get('C').get('A1').get('G_DICT').get('LENGTH')
        g = pf.get('CP').get('C').get('A1').get('G_DICT').get('IT', 1);
    else
        g = pf.get('CP').get('C').get('A1').get('GRAPH_TEMPLATE');
    end
    keys = g.get('ANODELABELS');
    
    nodes = pf.get(NODES);
    set(pr.get('DROPDOWN_NODE1'), ...
        'Items', keys, ...
        'ItemsData', [1:1:length(keys)], ...
        'Value', nodes(1) ...
        )
    set(pr.get('DROPDOWN_NODE2'), ...
        'Items', keys, ...
        'ItemsData', [1:1:length(keys)], ...
        'Value', nodes(2) ...
        )

    prop_value = pf.getr(NODES);
    if pf.isLocked(NODES) || isa(prop_value, 'Callback')
        set(pr.get('DROPDOWN_NODE1'), 'Enable', 'off')
        set(pr.get('DROPDOWN_NODE2'), 'Enable', 'off')
    end
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    set(pr.get('DROPDOWN_NODE1'), 'Position', [s(.3)            s(.3) .40*w_p s(1.75)])
    set(pr.get('DROPDOWN_NODE2'), 'Position', [s(.3)+.50*w_p    s(.3) .40*w_p s(1.75)])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('DROPDOWN_NODE1', Element.getNoValue())
    pr.set('DROPDOWN_NODE2', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
DROPDOWN_NODE1 (evanescent, handle) is the dropdown for the first node.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

dropdown = uidropdown( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'DROPDOWN_NODE1', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_dropdown_node} ...
    );

value = dropdown;
%%%% ¡calculate_callbacks!
function cb_dropdown_node(~, ~)
    pr.get('EL').set(pr.get('PROP'), [get(pr.get('DROPDOWN_NODE1'), 'Value') get(pr.get('DROPDOWN_NODE2'), 'Value')])
end

%%% ¡prop!
DROPDOWN_NODE2 (evanescent, handle) is the dropdown for the second node.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

dropdown = uidropdown( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'DROPDOWN_NODE2', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_dropdown_node} ...
    );

value = dropdown;
%%%% ¡calculate_callbacks!
function cb_dropdown_node2(~, ~)
    pr.get('EL').set(pr.get('PROP'), [get(pr.get('DROPDOWN_NODE1'), 'Value') get(pr.get('DROPDOWN_NODE2'), 'Value')])
end

%% ¡tests!

%%% ¡excluded_props!
[ComparisonEnsemblePF_BxPP_Nodes.DRAW ComparisonEnsemblePF_BxPP_Nodes.PARENT ComparisonEnsemblePF_BxPP_Nodes.H ComparisonEnsemblePF_BxPP_Nodes.UPDATE ComparisonEnsemblePF_BxPP_Nodes.LISTENER_CB ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1 ComparisonEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonEnsemblePF_BxPP_Nodes'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonEnsemblePF_BxPP_Nodes'])