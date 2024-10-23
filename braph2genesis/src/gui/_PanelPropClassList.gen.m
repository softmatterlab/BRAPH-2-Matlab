%% ¡header!
PanelPropClassList < PanelProp (pr, class-list prop panel) plots the panel of a property class list.

%%% ¡description!
A Class-List Prop Panel (PanelPropClassList) plots the panel for a CLASSLIST property with a listbox.
It works for all categories.

%%% ¡seealso!
uilistbox, GUI, PanelElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the class-list property panel.
%%%% ¡default!
'PanelPropClassList'

%%% ¡prop!
NAME (constant, string) is the name of the class-list property panel.
%%%% ¡default!
'Class-List Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the class-list property panel.
%%%% ¡default!
'A Class-List Prop Panel (PanelPropClassList) plots the panel for a CLASSLIST property with a listbox. It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the class-list property panel.
%%%% ¡settings!
'PanelPropClassList'

%%% ¡prop!
ID (data, string) is a few-letter code for the class-list property panel.
%%%% ¡default!
'PanelPropClassList ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the class-list property panel.
%%%% ¡default!
'PanelPropClassList label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the class-list property panel.
%%%% ¡default!
'PanelPropClassList notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
Measure()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
Measure.COMPATIBLE_GRAPHS

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the property panel.
%%%% ¡default!
s(10)
 
%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('LISTBOX')
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
            set(pr.get('LISTBOX'), ...
                'Value', el.get(prop), ...
                'Enable', 'off' ...
                )
            
        case Category.METADATA % __Category.METADATA__
            set(pr.get('LISTBOX'), 'Value', el.get(prop))

            if el.isLocked(prop)
                set(pr.get('LISTBOX'), 'Enable', 'off')
            end
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI} % {__Category.PARAMETER__ __Category.DATA__ __Category.FIGURE__ __Category.GUI__}
            set(pr.get('LISTBOX'), 'Value', el.get(prop))

            prop_value = el.getr(prop);
            if el.isLocked(prop) || isa(prop_value, 'Callback')
                set(pr.get('LISTBOX'), 'Enable', 'off')
            end

        case {Category.RESULT Category.QUERY Category.EVANESCENT} % {__Category.RESULT__ __Category.QUERY__ __Category.EVANESCENT__}
            prop_value = el.getr(prop);

            if isa(prop_value, 'NoValue')
                set(pr.get('v'), 'Value', el.getPropDefault(prop))
            else
                set(pr.get('LISTBOX'), 'Value', el.get(prop))
            end
            
            set(pr.get('LISTBOX'), 'Enable', 'off')
    end
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
	w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);

    set(pr.get('LISTBOX'), 'Position', [s(.3) s(.3) .70*w_p s(8)])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('LISTBOX', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
LISTBOX (evanescent, handle) is the logical value listbox.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

listbox = uilistbox( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'LISTBOX', ...
    'Items', Element.getSubclasses(el.getPropSettings(prop)), ...
    'MultiSelect', 'on', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_listbox} ...
    );

value = listbox;
%%%% ¡calculate_callbacks!
function cb_listbox(~, ~)
    pr.get('EL').set(pr.get('PROP'), get(pr.get('LISTBOX'), 'Value'))
end

%% ¡tests!

%%% ¡excluded_props!
[PanelPropClassList.PARENT PanelPropClassList.H PanelPropClassList.LISTENER_CB PanelPropClassList.LISTBOX]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropClassList'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropClassList'])