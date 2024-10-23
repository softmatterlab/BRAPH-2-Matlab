%% ¡header!
PanelPropScalar < PanelProp (pr, scalar prop panel) plots the panel of a property scalar.

%%% ¡description!
A Scalar Prop Panel (PanelPropScalar) plots the panel for a SCALAR property with a numeric edit field.
It works for all categories.

%%% ¡seealso!
uieditfield, GUI, PanelElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the scalar property panel.
%%%% ¡default!
'PanelPropScalar'

%%% ¡prop!
NAME (constant, string) is the name of the scalar property panel.
%%%% ¡default!
'Scalar Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the scalar property panel.
%%%% ¡default!
'A Scalar Prop Panel (PanelPropScalar) plots the panel for a SCALAR property with a numeric edit field. It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the scalar property panel.
%%%% ¡settings!
'PanelPropScalar'

%%% ¡prop!
ID (data, string) is a few-letter code for the scalar property panel.
%%%% ¡default!
'PanelPropScalar ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the scalar property panel.
%%%% ¡default!
'PanelPropScalar label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the scalar property panel.
%%%% ¡default!
'PanelPropScalar notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
PanelProp()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
PanelProp.PROP

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
            
        case Category.METADATA
            set(pr.get('EDITFIELD'), 'Value', el.get(prop))

            if el.isLocked(prop)
                set(pr.get('EDITFIELD'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('EDITFIELD'), 'Value', el.get(prop))

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
            else
                set(pr.get('EDITFIELD'), 'Value', el.get(prop))
            end
            
            set(pr.get('EDITFIELD'), ...
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
    
    set(pr.get('EDITFIELD'), 'Position', [s(.3) s(.3) .25*w_p s(1.75)])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('EDITFIELD', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.
%%%% ¡default!
true

%%% ¡prop!
EDITFIELD (evanescent, handle) is the alpha value edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

editfield = uieditfield('numeric', ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'EDITFIELD', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_editfield} ...
    );

value = editfield;
%%%% ¡calculate_callbacks!
function cb_editfield(~, ~)
    pr.get('EL').set(pr.get('PROP'), get(pr.get('EDITFIELD'), 'Value'))
end

%% ¡tests!

%%% ¡excluded_props!
[PanelPropScalar.PARENT PanelPropScalar.H PanelPropScalar.LISTENER_CB PanelPropScalar.EDITFIELD]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropScalar'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropScalar'])