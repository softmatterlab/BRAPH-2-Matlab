%% ¡header!
PanelPropClass < PanelProp (pr, class prop panel) plots the panel of a property class.

%%% ¡description!
A Class Prop Panel (PanelPropClass) plots the panel for a CLASS property with a drop-down list.
It works for all categories.

%%% ¡seealso!
uidropdown, GUI, PanelElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the class property panel.
%%%% ¡default!
'PanelPropClass'

%%% ¡prop!
NAME (constant, string) is the name of the class property panel.
%%%% ¡default!
'Class Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the class property panel.
%%%% ¡default!
'A Class Prop Panel (PanelPropClass) plots the panel for a CLASS property with a drop-down list. It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the class property panel.
%%%% ¡settings!
'PanelPropClass'

%%% ¡prop!
ID (data, string) is a few-letter code for the class property panel.
%%%% ¡default!
'PanelPropClass ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the class property panel.
%%%% ¡default!
'PanelPropClass label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the class property panel.
%%%% ¡default!
'PanelPropClass notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
IndexedDictionary()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
IndexedDictionary.IT_CLASS

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
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    switch el.getPropCategory(prop)
        case Category.CONSTANT % __Category.CONSTANT__
            set(pr.get('DROPDOWN'), ...
                'Value', el.get(prop), ...
                'Enable', 'off' ...
                )
            
        case Category.METADATA % __Category.METADATA__
            set(pr.get('DROPDOWN'), 'Value', el.get(prop))

            if el.isLocked(prop)
                set(pr.get('DROPDOWN'), 'Enable', 'off')
            end
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI} % {__Category.PARAMETER__ __Category.DATA__ __Category.FIGURE__ __Category.GUI__}
            set(pr.get('DROPDOWN'), 'Value', el.get(prop))

            prop_value = el.getr(prop);
            if el.isLocked(prop) || isa(prop_value, 'Callback')
                set(pr.get('DROPDOWN'), 'Enable', 'off')
            end

        case {Category.RESULT Category.QUERY Category.EVANESCENT} % {__Category.RESULT__ __Category.QUERY__ __Category.EVANESCENT__}
            prop_value = el.getr(prop);

            if isa(prop_value, 'NoValue')
                set(pr.get('DROPDOWN'), 'Value', el.getPropDefault(prop))
            else
                set(pr.get('DROPDOWN'), 'Value', el.get(prop))
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
DROPDOWN (evanescent, handle) is the logical value dropdown.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

dropdown = uidropdown( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'DROPDOWN', ...
    'Items', Element.getSubclasses(el.getPropSettings(prop)), ...
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
[PanelPropClass.PARENT PanelPropClass.H PanelPropClass.LISTENER_CB PanelPropClass.DROPDOWN]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropClass'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropClass'])