%% ¡header!
MeasureEnsembleBrainPF_xUPP_Layer < PanelProp (pr, panel property layer) plots the panel to select a layer.

%%% ¡description!
MeasureEnsembleBrainPF_xUPP_Layer plots the panel to select a layer from a drop-down list.
It is supposed to be used with the property LAYER of MeasureEnsembleBrainPF_NU, MeasureEnsembleBrainPF_BU, or MeasureEnsembleBrainPF_GU.

%%% ¡seealso!
uidropdown, GUI, MeasureEnsembleBrainPF_NU, MeasureEnsembleBrainPF_BU, MeasureEnsembleBrainPF_GU

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'MeasureEnsembleBrainPF_xUPP_Layer'

%%% ¡prop!
NAME (constant, string) is the name of the panel property layer.
%%%% ¡default!
'MeasureEnsembleBrainPF_xUPP_Layer'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel property layer.
%%%% ¡default!
'MeasureEnsembleBrainPF_xUPP_Layer plots the panel to select a layer from a drop-down list. It is supposed to be used with the property LAYER of ComparisonGroupPF_NU, ComparisonGroupPF_NS, or ComparisonGroupPF_NB.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel property layer.
%%%% ¡settings!
'MeasureEnsembleBrainPF_xUPP_Layer'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel property layer.
%%%% ¡default!
'MeasureEnsembleBrainPF_xUPP_Layer ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel property layer.
%%%% ¡default!
'MeasureEnsembleBrainPF_xUPP_Layer label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel property layer.
%%%% ¡default!
'MeasureEnsembleBrainPF_xUPP_Layer notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
MeasureEnsembleBrainPF_NU()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
MeasureEnsembleBrainPF_NU.LAYER

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
    LAYER = pr.get('PROP');
    
    g_dict = pf.get('ME').get('A').get('G_DICT');
    if g_dict.get('LENGTH')
        g = g_dict.get('IT', 1);
    else
        g = pf.get('ME').get('A').get('GRAPH_TEMPLATE');
    end
    keys = g.get('ALAYERLABELS');

    if isempty(keys)
        set(pr.get('DROPDOWN'), 'Enable', 'off')
    else
        set(pr.get('DROPDOWN'), ...
            'Items', keys, ...
            'ItemsData', [1:1:length(keys)], ...
            'Value', pf.get(LAYER) ...
            )
    end

    prop_value = pf.getr(LAYER);
    if pf.isLocked(LAYER) || isa(prop_value, 'Callback')
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
DROPDOWN (evanescent, handle) is the dropdown for the layer.
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
[MeasureEnsembleBrainPF_xUPP_Layer.DRAW MeasureEnsembleBrainPF_xUPP_Layer.PARENT MeasureEnsembleBrainPF_xUPP_Layer.H MeasureEnsembleBrainPF_xUPP_Layer.UPDATE MeasureEnsembleBrainPF_xUPP_Layer.LISTENER_CB MeasureEnsembleBrainPF_xUPP_Layer.DROPDOWN]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasureEnsembleBrainPF_xUPP_Layer'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasureEnsembleBrainPF_xUPP_Layer'])