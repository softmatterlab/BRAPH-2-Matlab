%% ¡header!
PanelPropStringTextArea < PanelProp (pr, string prop panel with text-area ) plots the panel of a property string with a text-area.

%%% ¡description!
A String Prop Panel with Text-Area (PanelPropStringTextArea) plots the panel for a STRING property with a text-area.
It works for all categories.

%%% ¡seealso!
uitextarea, GUI, PanelElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the string property panel with a text-area.
%%%% ¡default!
'PanelPropStringTextArea'

%%% ¡prop!
NAME (constant, string) is the name of the string property panel with a text-area.
%%%% ¡default!
'String Prop Panel with Text-Area'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the string property panel with a text-area.
%%%% ¡default!
'A String Prop Panel with Text-Area (PanelPropStringTextArea) plots the panel for a STRING property with a text-area. It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the string property panel with a text-area.
%%%% ¡settings!
'PanelPropStringTextArea'

%%% ¡prop!
ID (data, string) is a few-letter code for the string property panel with a text-area.
%%%% ¡default!
'PanelPropStringTextArea ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the string property panel with a text-area.
%%%% ¡default!
'PanelPropStringTextArea label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the string property panel with a text-area.
%%%% ¡default!
'PanelPropStringTextArea notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
ConcreteElement()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
ConcreteElement.NOTES

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the property panel.
%%%% ¡default!
s(7)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('TEXTAREA')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the text-area.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    switch el.getPropCategory(prop)
        case Category.CONSTANT
            set(pr.get('TEXTAREA'), ...
                'Value', el.get(prop), ...
                'Editable', 'off', ...
                'Enable', pr.get('ENABLE') ...
                )
            
        case Category.METADATA
            set(pr.get('TEXTAREA'), 'Value', strrep(el.get(prop), '\\n', char(10)))

            if el.isLocked(prop)
                set(pr.get('TEXTAREA'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('TEXTAREA'), 'Value', strrep(el.get(prop), '\\n', char(10)))

            prop_value = el.getr(prop);
            if el.isLocked(prop) || isa(prop_value, 'Callback')
                set(pr.get('TEXTAREA'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end

        case {Category.RESULT Category.QUERY Category.EVANESCENT}
            prop_value = el.getr(prop);

            if isa(prop_value, 'NoValue')
                set(pr.get('TEXTAREA'), 'Value', strrep(el.getPropDefault(prop), '\\n', char(10)))
            else
                set(pr.get('TEXTAREA'), 'Value', strrep(el.get(prop), '\\n', char(10)))
            end
            
            set(pr.get('TEXTAREA'), ...
                'Editable', 'off', ...
                'Enable', pr.get('ENABLE') ...
                )
    end
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    set(pr.get('TEXTAREA'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('TEXTAREA', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
ENABLE (gui, logical) switches the text-area between active and inactive appearance when not editable.
%%%% ¡default!
true

%%% ¡prop!
TEXTAREA (evanescent, handle) is the string value text-area.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

textarea = uitextarea( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'TEXTAREA', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_textarea} ...
    );

value = textarea;
%%%% ¡calculate_callbacks!
function cb_textarea(~, ~)
    value = get(pr.get('TEXTAREA'), 'Value');
    pr.get('EL').set(pr.get('PROP'), sprintf('%s\\\\n', value{:})) % double \\ to be converted to single \\ in compilation
end

%% ¡tests!

%%% ¡excluded_props!
[PanelPropStringTextArea.PARENT PanelPropStringTextArea.H PanelPropStringTextArea.LISTENER_CB PanelPropStringTextArea.TEXTAREA]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropStringTextArea'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropStringTextArea'])