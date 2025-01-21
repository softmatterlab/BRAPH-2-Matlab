%% ¡header!
PanelPropLogical < PanelProp (pr, logical prop panel) plots the panel of a property logical.

%%% ¡description!
A Logical Prop Panel (PanelPropLogical) plots the panel for a LOGICAL property with a checkbox.
It works for all categories.

%%% ¡seealso!
uicheckbox, GUI, PanelElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the logical property panel.
%%%% ¡default!
'PanelPropLogical'

%%% ¡prop!
NAME (constant, string) is the name of the logical property panel.
%%%% ¡default!
'Logical Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the logical property panel.
%%%% ¡default!
'A Logical Prop Panel (PanelPropLogical) plots the panel for a LOGICAL property with a checkbox. It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the logical property panel.
%%%% ¡settings!
'PanelPropLogical'

%%% ¡prop!
ID (data, string) is a few-letter code for the logical property panel.
%%%% ¡default!
'PanelPropLogical ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the logical property panel.
%%%% ¡default!
'PanelPropLogical label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the logical property panel.
%%%% ¡default!
'PanelPropLogical notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
PanelProp()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
PanelProp.DRAW

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the property panel.
%%%% ¡default!
s(4)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('CHECKBOX')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the checkbox.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    switch el.getPropCategory(prop)
        case Category.CONSTANT
            set(pr.get('CHECKBOX'), ...
                'Value', el.get(prop), ...
                'Enable', 'off' ...
                )

        case Category.METADATA
            set(pr.get('CHECKBOX'), 'Value', el.get(prop))

            if el.isLocked(prop)
                set(pr.get('CHECKBOX'), 'Enable', 'off')
            end
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('CHECKBOX'), 'Value', el.get(prop))

            prop_value = el.getr(prop);
            if el.isLocked(prop) || isa(prop_value, 'Callback')
                set(pr.get('CHECKBOX'), 'Enable', 'off')
            end
            
        case {Category.RESULT Category.QUERY Category.EVANESCENT}
            prop_value = el.getr(prop);

            if isa(prop_value, 'NoValue')
                set(pr.get('CHECKBOX'), 'Value', el.getPropDefault(prop))
            else
                set(pr.get('CHECKBOX'), 'Value', el.get(prop))
            end
            
            set(pr.get('CHECKBOX'), 'Enable', 'off')
    end
end

%%% ¡prop!
REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    set(pr.get('CHECKBOX'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
end    

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('CHECKBOX', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
CHECKBOX (evanescent, handle) is the logical value checkbox.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

checkbox = uicheckbox( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'CHECKBOX', ...
    'Text', '', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_checkbox} ...
    );

value = checkbox;
%%%% ¡calculate_callbacks!
function cb_checkbox(~, ~)
    pr.get('EL').set(pr.get('PROP'), logical(get(pr.get('CHECKBOX'), 'Value')))
end

%% ¡tests!

%%% ¡excluded_props!
[PanelPropLogical.PARENT PanelPropLogical.H PanelPropLogical.LISTENER_CB PanelPropLogical.CHECKBOX]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropLogical'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropLogical'])