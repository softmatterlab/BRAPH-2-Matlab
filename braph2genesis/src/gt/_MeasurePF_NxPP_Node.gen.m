%% ¡header!
MeasurePF_NxPP_Node < PanelProp (pr, node prop panel) plots the panel to select a node of a nodal measure.

%%% ¡description!
A Node Prop Panel (MeasurePF_NxPP_Node) plots the panel to select a node from a drop-down list.
It is supposed to be used with the property NODE of MeasurePF_NU, MeasurePF_NS, or MeasurePF_NB.

%%% ¡seealso!
uidropdown, GUI, MeasurePF_NU, MeasurePF_NS, MeasurePF_NB

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the node prop panel (MeasurePF_NxPP_Node).
%%%% ¡default!
'MeasurePF_NxPP_Node'

%%% ¡prop!
NAME (constant, string) is the name of the node prop panel.
%%%% ¡default!
'Node Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the node prop panel.
%%%% ¡default!
'A Node Prop Panel (MeasurePF_NxPP_Node) plots the panel to select a node from a drop-down list. It is supposed to be used with the property NODE of MeasurePF_NU, MeasurePF_NS, or MeasurePF_NB.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the node prop panel.
%%%% ¡settings!
'MeasurePF_NxPP_Node'

%%% ¡prop!
ID (data, string) is a few-letter code for the node prop panel.
%%%% ¡default!
'MeasurePF_NxPP_Node ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the node prop panel.
%%%% ¡default!
'MeasurePF_NxPP_Node label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the node prop panel.
%%%% ¡default!
'MeasurePF_NxPP_Node notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
MeasurePF_NU()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
MeasurePF_NU.NODE

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the property panel.
%%%% ¡default!
s(4)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('DROPDOWN')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the editfield.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
    pf = pr.get('EL');
    NODE = pr.get('PROP');
    
    keys = pf.get('M').get('G').get('ANODELABELS');
    
    set(pr.get('DROPDOWN'), ...
        'Items', keys, ...
        'ItemsData', [1:1:length(keys)], ...
        'Value', pf.get(NODE) ...
        )

    prop_value = pf.getr(NODE);
    if pf.isLocked(NODE) || isa(prop_value, 'Callback')
        set(pr.get('DROPDOWN'), 'Enable', 'off')
    end
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    set(pr.get('DROPDOWN'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('DROPDOWN', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
DROPDOWN (evanescent, handle) is the dropdown of the node.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

dropdown = uidropdown( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'DROPDOWN', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_dropdown} ...
    );

value = dropdown;
%%%% ¡calculate_callbacks!
function cb_dropdown(~, ~)
    pr.get('EL').set(pr.get('PROP'), get(pr.get('DROPDOWN'), 'Value'))
end

%% ¡tests!

%%% ¡excluded_props!
[MeasurePF_NxPP_Node.DRAW MeasurePF_NxPP_Node.PARENT MeasurePF_NxPP_Node.H MeasurePF_NxPP_Node.UPDATE MeasurePF_NxPP_Node.LISTENER_CB MeasurePF_NxPP_Node.DROPDOWN]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasurePF_NxPP_Node'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasurePF_NxPP_Node'])