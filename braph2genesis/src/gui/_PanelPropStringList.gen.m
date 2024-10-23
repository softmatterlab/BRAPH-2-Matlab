%% ¡header!
PanelPropStringList < PanelProp (pr, string-list prop panel) plots the panel of a property string-list.

%%% ¡description!
PanelPropStringList plots the panel for a STRINGLIST property with a text area.
It works for all categories.

It can be personalized with the following property:
 TA_HEIGHT - Text area height in pixels when the table is shown.

%%% ¡seealso!
uitextarea, GUI, PanelElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the string-list property panel.
%%%% ¡default!
'PanelPropStringList'

%%% ¡prop!
NAME (constant, string) is the name of the string-list property panel.
%%%% ¡default!
'String-List Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the string-list property panel.
%%%% ¡default!
'PanelPropStringList plots the panel for a STRINGLIST property with a text area. It works for all categories. It can be personalized with the following props: TA_HEIGHT.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the string-list property panel.
%%%% ¡settings!
'PanelPropStringList'

%%% ¡prop!
ID (data, string) is a few-letter code for the string-list property panel.
%%%% ¡default!
'PanelPropStringList ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the string-list property panel.
%%%% ¡default!
'PanelPropStringList label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the string-list property panel.
%%%% ¡default!
'PanelPropStringList notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
Graph()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
Graph.LAYERLABELS

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('TEXTAREA')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the editfield.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value

    el = pr.get('EL');
    prop = pr.get('PROP');

    if any(el.getPropCategory(prop) == [Category.RESULT Category.QUERY Category.EVANESCENT]) && isa(el.getr(prop), 'NoValue')
        pr.set('HEIGHT', s(2))
    else
        pr.set('HEIGHT', min(s(2) + s(2) * (length(el.get(prop)) + 1), pr.get('TA_HEIGHT')))
    end
    
    switch el.getPropCategory(prop)
        case Category.CONSTANT
            set(pr.get('TEXTAREA'), ...
                'Value', cell2str(el.get(prop)), ...
                'Editable', 'off', ...
                'Enable', pr.get('ENABLE') ...
                )
            
        case Category.METADATA
            set(pr.get('TEXTAREA'), 'Value', cell2str(el.get(prop)))

            if el.isLocked(prop)
                set(pr.get('TEXTAREA'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('TEXTAREA'), 'Value', cell2str(el.get(prop)))

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
                if isempty(el.getPropDefault(prop))
                    set(pr.get('TEXTAREA'), 'Visible', false)
                else
                    set(pr.get('TEXTAREA'), ...
                        'Value', cell2str(el.getPropDefault(prop)), ...
                        'Visible', true ...
                        )
                end
            else
                set(pr.get('TEXTAREA'), ...
                    'Value', cell2str(el.get(prop)), ...
                    'Visible', true ...
                    )
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
ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.
%%%% ¡default!
true

%%% ¡prop!
TA_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.
%%%% ¡default!
s(20)

%%% ¡prop!
TEXTAREA (evanescent, handle) is the string value text area.
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
    pr.get('EL').set(pr.get('PROP'), str2cell(value))
end

%% ¡tests!

%%% ¡excluded_props!
[PanelPropStringList.PARENT PanelPropStringList.H PanelPropStringList.HEIGHT PanelPropStringList.LISTENER_CB PanelPropStringList.TEXTAREA]

%%% ¡warning_off!
true

%%% ¡test!PanelPropList.LISTENER_CB
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropStringList'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropStringList'])