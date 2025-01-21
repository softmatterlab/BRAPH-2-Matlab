%% ¡header!
PanelPropColor < PanelProp (pr, color prop panel) plots the panel of a property color.

%%% ¡description!
A Color Prop Panel (PanelPropColor) plots the panel for a COLOR property with a button.
It works for all categories.

%%% ¡seealso!
uibutton, GUI, PanelElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the color property panel.
%%%% ¡default!
'PanelPropColor'

%%% ¡prop!
NAME (constant, string) is the name of the color property panel.
%%%% ¡default!
'Color Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the color property panel.
%%%% ¡default!
'A Color Prop Panel (PanelPropColor) plots the panel for a COLOR property with a button. It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the color property panel.
%%%% ¡settings!
'PanelPropColor'

%%% ¡prop!
ID (data, string) is a few-letter code for the color property panel.
%%%% ¡default!
'PanelPropColor ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the color property panel.
%%%% ¡default!
'PanelPropColor label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the color property panel.
%%%% ¡default!
'PanelPropColor notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
PanelProp()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
PanelProp.BKGCOLOR

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the property panel.
%%%% ¡default!
s(4)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('BUTTON')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the button.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    switch el.getPropCategory(prop)
        case Category.CONSTANT
            set(pr.get('BUTTON'), ...
                'BackgroundColor', el.get(prop), ...
                'Enable', 'off' ...
                )
            
        case Category.METADATA
            set(pr.get('BUTTON'), 'BackgroundColor', el.get(prop))

            if el.isLocked(prop)
                set(pr.get('BUTTON'), 'Enable', 'off')
            end
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('BUTTON'), 'BackgroundColor', el.get(prop))

            prop_value = el.getr(prop);
            if el.isLocked(prop) || isa(prop_value, 'Callback')
                set(pr.get('BUTTON'), 'Enable', 'off')
            end

        case {Category.RESULT Category.QUERY Category.EVANESCENT}
            prop_value = el.getr(prop);

            if isa(prop_value, 'NoValue')
                set(pr.get('BUTTON'), 'BackgroundColor', el.getPropDefault(prop))
            else
                set(pr.get('BUTTON'), 'BackgroundColor', el.get(prop))
            end
            
            set(pr.get('BUTTON'), 'Enable', 'off')
    end
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    set(pr.get('BUTTON'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('BUTTON', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
BUTTON (evanescent, handle) is the color value button.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

button = uibutton( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'BUTTON', ...
    'Text', '', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ButtonPushedFcn', {@cb_button}, ...
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    );

value = button;
%%%% ¡calculate_callbacks!
function cb_button(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');

    new_color = uisetcolor(el.get(prop));
    if ~isequal(new_color, el.get(prop))
        el.set(prop, new_color)
    end
end

%% ¡tests!

%%% ¡excluded_props!
[PanelPropColor.PARENT PanelPropColor.H PanelPropColor.LISTENER_CB PanelPropColor.BUTTON]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropColor'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropColor'])