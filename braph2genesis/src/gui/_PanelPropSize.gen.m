%% ¡header!
PanelPropSize < PanelProp (pr, size prop panel) plots the panel of a property size.

%%% ¡description!
A Size Prop Panel (PanelPropSize) plots the panel for a SIZE property with a numeric edit field.
It works for all categories.

%%% ¡seealso!
uieditfield, uiaxes, line, GUI, PanelElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the size property panel.
%%%% ¡default!
'PanelPropSize'

%%% ¡prop!
NAME (constant, string) is the name of the size property panel.
%%%% ¡default!
'Size Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the size property panel.
%%%% ¡default!
'A Size Prop Panel (PanelPropSize) plots the panel for a SIZE property with a numeric edit field. It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the size property panel.
%%%% ¡settings!
'PanelPropSize'

%%% ¡prop!
ID (data, string) is a few-letter code for the size property panel.
%%%% ¡default!
'PanelPropSize ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the size property panel.
%%%% ¡default!
'PanelPropSize label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the size property panel.
%%%% ¡default!
'PanelPropSize notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
PanelProp()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
PanelProp.HEIGHT

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the property panel.
%%%% ¡default!
s(4)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('EDITFIELD')
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
            set(pr.get('EDITFIELD'), ...
                'Value', el.get(prop), ...
                'Editable', 'off', ...
                'Enable', pr.get('ENABLE') ...
                )
            set(pr.get('LN'), ...
                'LineWidth', el.get(prop), ...
                'MarkerSize', el.get(prop) ...
                )
            
        case Category.METADATA
            set(pr.get('EDITFIELD'), 'Value', el.get(prop))
            set(pr.get('LN'), ...
                'LineWidth', el.get(prop), ...
                'MarkerSize', el.get(prop) ...
                )

            if el.isLocked(prop)
                set(pr.get('EDITFIELD'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('EDITFIELD'), 'Value', el.get(prop))
            set(pr.get('LN'), ...
                'LineWidth', el.get(prop), ...
                'MarkerSize', el.get(prop) ...
                )

            prop_value = el.getr(prop);
            if el.isLocked(prop) || isa(prop_value, 'Callback')
                set(pr.get('EDITFIELD'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end

        case {Category.RESULT Category.QUERY Category.EVANESCENT}
            prop_value = el.getr(prop);

            if isa(prop_value, 'NoValue')
                set(pr.get('EDITFIELD'), 'Value', el.getPropDefault(prop))
                set(pr.get('LN'), ...
                    'LineWidth', el.getPropDefault(prop), ...
                    'MarkerSize', el.getPropDefault(prop) ...
                    )
            else
                set(pr.get('EDITFIELD'), 'Value', el.get(prop))
                set(pr.get('LN'), ...
                    'LineWidth', el.get(prop), ...
                    'MarkerSize', el.get(prop) ...
                    )
            end
            
            set(pr.get('EDITFIELD'), ...
                'Editable', 'off', ...
                'Enable', pr.get('ENABLE') ...
                )
    end
end

%%% ¡prop!
REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    set(pr.get('EDITFIELD'), 'Position', [s(.3) s(.3) .15*w_p s(1.75)])
    set(pr.get('AXES'), 'InnerPosition', [s(.3)+.15*w_p+s(.6) s(.3) .70*w_p s(1.75)])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('EDITFIELD', Element.getNoValue())
    pr.set('AXES', Element.getNoValue())
    pr.set('LN', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.
%%%% ¡default!
true

%%% ¡prop!
EDITFIELD (evanescent, handle) is the size value edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

editfield = uieditfield('numeric', ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'EDITFIELD', ...
    'Limits', [0 +Inf], ...
    'LowerLimitInclusive', false, ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_editfield} ...
    );

value = editfield;
%%%% ¡calculate_callbacks!
function cb_editfield(~, ~)
    pr.get('EL').set(pr.get('PROP'), get(pr.get('EDITFIELD'), 'Value'))
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
    [-100 0 100], ...
    [0 0 0], ...
    'Marker', 's', ...
    'Color', 'k');
xlim(axes, [-1 1])        
ylim(axes, [-1 1])

value = ln;

%% ¡tests!

%%% ¡excluded_props!
[PanelPropSize.PARENT PanelPropSize.H PanelPropSize.LISTENER_CB PanelPropSize.EDITFIELD PanelPropSize.AXES PanelPropSize.LN]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropSize'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropSize'])