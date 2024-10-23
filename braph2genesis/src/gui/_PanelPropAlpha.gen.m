%% ¡header!
PanelPropAlpha < PanelProp (pr, alpha prop panel) plots the panel of a property alpha.

%%% ¡description!
An Alpha Property Panel (PanelPropAlpha) plots the panel for an ALPHA property 
 with a numeric edit field and a slider.
It works for all categories.

%%% ¡seealso!
uieditfield, uislider, GUI, PanelElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the alpha property panel.
%%%% ¡default!
'PanelPropAlpha'

%%% ¡prop!
NAME (constant, string) is the name of the alpha property panel.
%%%% ¡default!
'Alpha Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the alpha property panel.
%%%% ¡default!
'An Alpha Prop Panel (PanelPropAlpha) plots the panel for a ALPHA property with a numeric edit field and a slider. It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the alpha property panel.
%%%% ¡settings!
'PanelPropAlpha'

%%% ¡prop!
ID (data, string) is a few-letter code for the alpha property panel.
%%%% ¡default!
'PanelPropAlpha ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the alpha property panel.
%%%% ¡default!
'PanelPropAlpha label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the alpha property panel.
%%%% ¡default!
'PanelPropAlpha notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
SettingsSurface()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
SettingsSurface.FACEALPHA

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the property panel.
%%%% ¡default!
s(5)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('EDITFIELD')
    pr.memorize('SLIDER')
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
            set(pr.get('SLIDER'), ...
                'Value', el.get(prop), ...
                'Enable', 'off' ...
                )
            
        case Category.METADATA
            set(pr.get('EDITFIELD'), 'Value', el.get(prop))
            set(pr.get('SLIDER'), 'Value', el.get(prop))

            if el.isLocked(prop)
                set(pr.get('EDITFIELD'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER'), 'Enable', 'off')
            end
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('EDITFIELD'), 'Value', el.get(prop))
            set(pr.get('SLIDER'), 'Value', el.get(prop))

            prop_value = el.getr(prop);
            if el.isLocked(prop) || isa(prop_value, 'Callback')
                set(pr.get('EDITFIELD'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER'), 'Enable', 'off')
            end

        case {Category.RESULT Category.QUERY Category.EVANESCENT}
            prop_value = el.getr(prop);

            if isa(prop_value, 'NoValue')
                set(pr.get('EDITFIELD'), 'Value', el.getPropDefault(prop))
                set(pr.get('SLIDER'), 'Value', el.getPropDefault(prop))
            else
                set(pr.get('EDITFIELD'), 'Value', el.get(prop))
                set(pr.get('SLIDER'), 'Value', el.get(prop))
            end
            
            set(pr.get('EDITFIELD'), ...
                'Editable', 'off', ...
                'Enable', pr.get('ENABLE') ...
                )
            set(pr.get('SLIDER'), 'Enable', 'off')
    end
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    set(pr.get('EDITFIELD'), 'Position', [s(.3) s(.3) .15*w_p s(1.75)])
    set(pr.get('SLIDER'), 'Position', [s(.3)+.15*w_p+s(1.7) s(2.25) .70*w_p 3]) % the height of a slider cannot be changed
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('EDITFIELD', Element.getNoValue())
    pr.set('SLIDER', Element.getNoValue())
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
    'Limits', [0 1], ...
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
SLIDER (evanescent, handle) is the alpha value slider.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

slider = uislider( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'SLIDER', ...
    'Limits', [0 1], ...
    'FontSize', BRAPH2.FONTSIZE / 2, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_slider} ...
    );

% output
value = slider;
%%%% ¡calculate_callbacks!
function cb_slider(~, ~)
    pr.get('EL').set(pr.get('PROP'), get(pr.get('SLIDER'), 'Value'))
end

%% ¡tests!

%%% ¡excluded_props!
[PanelPropAlpha.PARENT PanelPropAlpha.H PanelPropAlpha.LISTENER_CB PanelPropAlpha.EDITFIELD PanelPropAlpha.SLIDER]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropAlpha'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropAlpha'])