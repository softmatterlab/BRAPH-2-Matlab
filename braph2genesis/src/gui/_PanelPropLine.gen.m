%% ¡header!
PanelPropLine < PanelProp (pr, line prop panel) plots the panel of a property line.

%%% ¡description!
A Line Prop Panel (PanelPropLine) plots the panel for an LINE property with a drop-down list.
It works for all categories.

%%% ¡seealso!
uidropdown, uiaxes, line, GUI, PanelElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the line property panel.
%%%% ¡default!
'PanelPropLine'

%%% ¡prop!
NAME (constant, string) is the name of the line property panel.
%%%% ¡default!
'Line Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the line property panel.
%%%% ¡default!
'A Line Prop Panel (PanelPropLine) plots the panel for an LINE property with a drop-down list. It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the line property panel.
%%%% ¡settings!
'PanelPropLine'

%%% ¡prop!
ID (data, string) is a few-letter code for the line property panel.
%%%% ¡default!
'PanelPropLine ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the line property panel.
%%%% ¡default!
'PanelPropLine label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the line property panel.
%%%% ¡default!
'PanelPropLine notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
SettingsLine()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
SettingsLine.LINESTYLE

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
    pr.memorize('AXES')
    pr.memorize('LN')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the editfield.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    switch el.getPropCategory(prop)
        case Category.CONSTANT
            set(pr.get('DROPDOWN'), ...
                'Value', el.get(prop), ...
                'Enable', 'off' ...
                )
            set(pr.get('LN'), 'LineStyle', el.get(prop))
            
        case Category.METADATA
            set(pr.get('DROPDOWN'), 'Value', el.get(prop))
            set(pr.get('LN'), 'LineStyle', el.get(prop))

            if el.isLocked(prop)
                set(pr.get('DROPDOWN'), 'Enable', 'off')
            end
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('DROPDOWN'), 'Value', el.get(prop))
            set(pr.get('LN'), 'LineStyle', el.get(prop))

            prop_value = el.getr(prop);
            if el.isLocked(prop) || isa(prop_value, 'Callback')
                set(pr.get('DROPDOWN'), 'Enable', 'off')
            end

        case {Category.RESULT Category.QUERY Category.EVANESCENT}
            prop_value = el.getr(prop);

            if isa(prop_value, 'NoValue')
                set(pr.get('DROPDOWN'), 'Value', el.getPropDefault(prop))
                set(pr.get('LN'), 'LineStyle', el.getPropDefault(prop))
            else
                set(pr.get('DROPDOWN'), 'Value', el.get(prop))
                set(pr.get('LN'), 'LineStyle', el.get(prop))
            end
            
            set(pr.get('DROPDOWN'), 'Enable', 'off')
    end
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value 
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    set(pr.get('DROPDOWN'), 'Position', [s(.3) s(.3) .15*w_p s(1.75)])
    set(pr.get('AXES'), 'InnerPosition', [s(.3)+.15*w_p+s(1.7) s(.3) .70*w_p s(1.7)])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('DROPDOWN', Element.getNoValue())
    pr.set('AXES', Element.getNoValue())
    pr.set('LN', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
DROPDOWN (evanescent, handle) is the marker value dropdown.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

dropdown = uidropdown( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'DROPDOWN', ...
    'Items', el.getPropSettings(prop), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_dropdown} ...
    );

value = dropdown;
%%%% ¡calculate_callbacks!
function cb_dropdown(~, ~)
    pr.get('EL').set(pr.get('PROP'), get(pr.get('DROPDOWN'), 'Value'))
end

%%% ¡prop!
AXES (evanescent, handle) is the marker value axes.
%%%% ¡calculate!
axes = uiaxes( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'AXES' ...
    );
axis(axes, 'off')
axes.Toolbar.Visible = 'off';
axes.Interactions = [];

value = axes;

%%% ¡prop!
LN (evanescent, handle) is the marker value line.
%%%% ¡calculate!
axes = pr.memorize('AXES');

ln = plot(axes, ...
    [0], ...
    [0], ...
    'MarkerSize', 10, ...
    'MarkerFaceColor', 'k', ...
    'MarkerEdgeColor', 'k');
xlim(axes, [-1 1])        
ylim(axes, [-1 1])

value = ln;

%% ¡tests!

%%% ¡excluded_props!
[PanelPropLine.PARENT PanelPropLine.H PanelPropLine.LISTENER_CB PanelPropLine.DROPDOWN PanelPropLine.AXES PanelPropLine.LN]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropLine'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropLine'])