%% ¡header!
SettingsAreaPP < SettingsPP (pr, prop panel for area settings) is the panel with area settings.

%%% ¡description!
A Prop Panel for Area Settings (SettingsAreaPP) plots the panel for area settings,
 including visibility, face color, face alpha, edge color, and edge alpha.
It works for all categories.

%%% ¡seealso!
SettingsArea, uicheckbox, , uipushbutton, uieditfield, uislider

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the property panel for area settings.
%%%% ¡default!
'SettingsAreaPP'

%%% ¡prop!
NAME (constant, string) is the name of the property panel for area settings.
%%%% ¡default!
'Prop Panel for Area Settings'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the property panel for area settings.
%%%% ¡default!
'A Prop Panel for Area Settings (SettingsAreaPP) plots the panel for area settings, including visibility, face color, face alpha, edge color, and edge alpha. It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the property panel for area settings.
%%%% ¡settings!
'SettingsAreaPP'

%%% ¡prop!
ID (data, string) is a few-letter code for the property panel for area settings.
%%%% ¡default!
'SettingsAreaPP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the property panel for area settings.
%%%% ¡default!
'SettingsAreaPP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the property panel for area settings.
%%%% ¡default!
'SettingsAreaPP notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
GraphHistPF()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
GraphHistPF.ST_HIST_AREA

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the settings position panel.
%%%% ¡default!
s(9.2)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('CHECKBOX_VISIBLE')

    pr.memorize('BUTTON_FACECOLOR')
    pr.memorize('EDITFIELD_FACEALPHA')
    pr.memorize('SLIDER_FACEALPHA')
    
    pr.memorize('BUTTON_EDGECOLOR')
    pr.memorize('EDITFIELD_EDGEALPHA')
    pr.memorize('SLIDER_EDGEALPHA')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.get('CHECKBOX_VISIBLE'), 'Enable', pr.get('ENABLE'))

        set(pr.get('BUTTON_FACECOLOR'), 'Enable', pr.get('ENABLE'))
        set(pr.get('EDITFIELD_FACEALPHA'), ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.get('SLIDER_FACEALPHA'), 'Enable', pr.get('ENABLE'))
        
        set(pr.get('BUTTON_EDGECOLOR'), 'Enable', pr.get('ENABLE'))
        set(pr.get('EDITFIELD_EDGEALPHA'), ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.get('SLIDER_EDGEALPHA'), 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.get('CHECKBOX_VISIBLE'), 'Value', el.get(prop).get('VISIBLE'))

            set(pr.get('BUTTON_FACECOLOR'), 'BackgroundColor', el.get(prop).get('FACECOLOR'))
            set(pr.get('EDITFIELD_FACEALPHA'), 'Value', el.get(prop).get('FACEALPHA'))
            set(pr.get('SLIDER_FACEALPHA'), 'Value', el.get(prop).get('FACEALPHA'))
            
            set(pr.get('BUTTON_EDGECOLOR'), 'BackgroundColor', el.get(prop).get('EDGECOLOR'))
            set(pr.get('EDITFIELD_EDGEALPHA'), 'Value', el.get(prop).get('EDGEALPHA'))
            set(pr.get('SLIDER_EDGEALPHA'), 'Value', el.get(prop).get('EDGEALPHA'))
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('CHECKBOX_VISIBLE'), 'Value', el.get(prop).get('VISIBLE'))

            set(pr.get('BUTTON_FACECOLOR'), 'BackgroundColor', el.get(prop).get('FACECOLOR'))
            set(pr.get('EDITFIELD_FACEALPHA'), 'Value', el.get(prop).get('FACEALPHA'))
            set(pr.get('SLIDER_FACEALPHA'), 'Value', el.get(prop).get('FACEALPHA'))
            
            set(pr.get('BUTTON_EDGECOLOR'), 'BackgroundColor', el.get(prop).get('EDGECOLOR'))
            set(pr.get('EDITFIELD_EDGEALPHA'), 'Value', el.get(prop).get('EDGEALPHA'))
            set(pr.get('SLIDER_EDGEALPHA'), 'Value', el.get(prop).get('EDGEALPHA'))

            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('VISIBLE'), 'Callback')
                set(pr.get('CHECKBOX_VISIBLE'), 'Enable', pr.get('ENABLE'))
            end

            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FACECOLOR'), 'Callback')
                set(pr.get('BUTTON_FACECOLOR'), 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FACEALPHA'), 'Callback')
                set(pr.get('EDITFIELD_FACEALPHA'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_FACEALPHA'), 'Enable', pr.get('ENABLE'))
            end
            
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('EDGECOLOR'), 'Callback')
                set(pr.get('BUTTON_EDGECOLOR'), 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('EDGEALPHA'), 'Callback')
                set(pr.get('EDITFIELD_EDGEALPHA'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_EDGEALPHA'), 'Enable', pr.get('ENABLE'))
            end
            
        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.get('CHECKBOX_VISIBLE'), ...
                    'Value', el.get(prop).getPropDefault('VISIBLE'), ...
                    'Enable', pr.get('ENABLE') ...
                    )

                set(pr.get('BUTTON_FACECOLOR'), ...
                    'BackgroundColor', el.get(prop).getPropDefault('FACECOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_FACEALPHA'), ...
                    'Value', el.get(prop).getPropDefault('FACEALPHA'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_FACEALPHA'), ...
                    'Value', el.get(prop).getPropDefault('FACEALPHA'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                
                set(pr.get('BUTTON_EDGECOLOR'), ...
                    'BackgroundColor', el.get(prop).getPropDefault('EDGECOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_EDGEALPHA'), ...
                    'Value', el.get(prop).getPropDefault('EDGEALPHA'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_EDGEALPHA'), ...
                    'Value', el.get(prop).getPropDefault('EDGEALPHA'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                set(pr.get('CHECKBOX_VISIBLE'), ...
                    'Value', el.get(prop).get('VISIBLE'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                
                set(pr.get('BUTTON_FACECOLOR'), ...
                    'BackgroundColor', el.get(prop).get('FACECOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_FACEALPHA'), ...
                    'Value', el.get(prop).get('FACEALPHA'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_FACEALPHA'), ...
                    'Value', el.get(prop).get('FACEALPHA'), ...
                    'Enable', pr.get('ENABLE') ...
                    )

                set(pr.get('BUTTON_EDGECOLOR'), ...
                    'BackgroundColor', el.get(prop).get('EDGECOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_EDGEALPHA'), ...
                    'Value', el.get(prop).get('EDGEALPHA'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_EDGEALPHA'), ...
                    'Value', el.get(prop).get('EDGEALPHA'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
    end
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    set(pr.get('CHECKBOX_VISIBLE'), 'Position', [s(.3) s(5.7) .30*w_p s(1.7)])

    set(pr.get('BUTTON_FACECOLOR'),    'Position', [s(.3)                  s(3.2)  .20*w_p   s(1.7)])
    set(pr.get('EDITFIELD_FACEALPHA'), 'Position', [s(.6)+.20*w_p          s(3.2)  .15*w_p   s(1.7)])
    set(pr.get('SLIDER_FACEALPHA'),    'Position', [s(.6)+.35*w_p+s(1.7)   s(4.75) .50*w_p   3]) % the height of a slider cannot be changed

    set(pr.get('BUTTON_EDGECOLOR'),    'Position', [s(.3)                  s(.7)   .20*w_p   s(1.7)])
    set(pr.get('EDITFIELD_EDGEALPHA'), 'Position', [s(.6)+.20*w_p          s(.7)   .15*w_p   s(1.7)])
    set(pr.get('SLIDER_EDGEALPHA'),    'Position', [s(.6)+.35*w_p+s(1.7)   s(2.25) .50*w_p   3]) % the height of a slider cannot be changed
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('CHECKBOX_VISIBLE', Element.getNoValue())

    pr.set('BUTTON_FACECOLOR', Element.getNoValue())
    pr.set('EDITFIELD_FACEALPHA', Element.getNoValue())
    pr.set('SLIDER_FACEALPHA', Element.getNoValue())

    pr.set('BUTTON_EDGECOLOR', Element.getNoValue())
    pr.set('EDITFIELD_EDGEALPHA', Element.getNoValue())
    pr.set('SLIDER_EDGEALPHA', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.
%%%% ¡default!
true

%%% ¡prop!
CHECKBOX_VISIBLE (evanescent, handle) determines whether the area is visible.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
checkbox_visible = uicheckbox( ...
    'Parent', pr.memorize('H'), ...
	'Tag', 'CHECKBOX_VISIBLE', ...
    'Text', 'visible', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('VISIBLE')) ' ' el.get(prop).getPropDescription('VISIBLE')], ...
    'ValueChangedFcn', {@cb_visible} ...
    );
value = checkbox_visible;
%%%% ¡calculate_callbacks!
function cb_visible(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set('VISIBLE', get(pr.get('CHECKBOX_VISIBLE'), 'Value'))
end

%%% ¡prop!
BUTTON_FACECOLOR (evanescent, handle) is the face color button.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
button_facecolor = uibutton( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'BUTTON_FACECOLOR', ...
    'Text', 'face', ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FACECOLOR')) ' ' el.get(prop).getPropDescription('FACECOLOR')], ...
    'ButtonPushedFcn', {@cb_button_facecolor}, ...
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    );
value = button_facecolor;
%%%% ¡calculate_callbacks!
function cb_button_facecolor(~, ~)

    el = pr.get('EL');
    prop = pr.get('PROP');

    new_color = uisetcolor(el.get(prop).get('FACECOLOR'));
    if ~isequal(new_color, el.get(prop).get('FACECOLOR'))
        el.get(prop).set('FACECOLOR', new_color)

        pr.get('UPDATE')
    end
end

%%% ¡prop!
EDITFIELD_FACEALPHA (evanescent, handle) is the face alpha edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
editfield_facealpha = uieditfield('numeric', ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'EDITFIELD_FACEALPHA', ...
    'Limits', [0 1], ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FACEALPHA')) ' ' el.get(prop).getPropDescription('FACEALPHA')], ...
    'ValueChangedFcn', {@cb_editfield_facealpha} ...
    );
value = editfield_facealpha;
%%%% ¡calculate_callbacks!
function cb_editfield_facealpha(~, ~)

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set('FACEALPHA', get(pr.get('EDITFIELD_FACEALPHA'), 'Value'))

	pr.get('UPDATE')
end

%%% ¡prop!
SLIDER_FACEALPHA (evanescent, handle) is the face alpha slider.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
slider_facealpha = uislider( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'SLIDER_FACEALPHA', ...
    'Limits', [0 1], ...
    'FontSize', BRAPH2.FONTSIZE / 2, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FACEALPHA')) ' ' el.get(prop).getPropDescription('FACEALPHA')], ...
    'ValueChangedFcn', {@cb_slider_facealpha} ...
    );
value = slider_facealpha;
%%%% ¡calculate_callbacks!
function cb_slider_facealpha(~, ~)

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set('FACEALPHA', get(pr.get('SLIDER_FACEALPHA'), 'Value'))

	pr.get('UPDATE')
end

%%% ¡prop!
BUTTON_EDGECOLOR (evanescent, handle) is the edge color button.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
button_edgecolor = uibutton( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'BUTTON_EDGECOLOR', ...
    'Text', 'edge', ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('EDGECOLOR')) ' ' el.get(prop).getPropDescription('EDGECOLOR')], ...
    'ButtonPushedFcn', {@cb_button_edgecolor}, ...
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    );
value = button_edgecolor;
%%%% ¡calculate_callbacks!
function cb_button_edgecolor(~, ~)

    el = pr.get('EL');
    prop = pr.get('PROP');

    new_color = uisetcolor(el.get(prop).get('EDGECOLOR'));
    if ~isequal(new_color, el.get(prop).get('EDGECOLOR'))
        el.get(prop).set('EDGECOLOR', new_color)

        pr.get('UPDATE')
    end
end

%%% ¡prop!
EDITFIELD_EDGEALPHA (evanescent, handle) is the edge alpha edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
editfield_edgealpha = uieditfield('numeric', ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'EDITFIELD_EDGEALPHA', ...
    'Limits', [0 1], ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('EDGEALPHA')) ' ' el.get(prop).getPropDescription('EDGEALPHA')], ...
    'ValueChangedFcn', {@cb_editfield_edgealpha} ...
    );
value = editfield_edgealpha;
%%%% ¡calculate_callbacks!
function cb_editfield_edgealpha(~, ~)

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set('EDGEALPHA', get(pr.get('EDITFIELD_EDGEALPHA'), 'Value'))

	pr.get('UPDATE')
end

%%% ¡prop!
SLIDER_EDGEALPHA (evanescent, handle) is the edge alpha slider.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
slider_edgealpha = uislider( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'SLIDER_EDGEALPHA', ...
    'Limits', [0 1], ...
    'FontSize', BRAPH2.FONTSIZE / 2, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('EDGEALPHA')) ' ' el.get(prop).getPropDescription('EDGEALPHA')], ...
    'ValueChangedFcn', {@cb_slider_edgealpha} ...
    );
value = slider_edgealpha;
%%%% ¡calculate_callbacks!
function cb_slider_edgealpha(~, ~)

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set('EDGEALPHA', get(pr.get('SLIDER_EDGEALPHA'), 'Value'))
    
	pr.get('UPDATE')
end

%% ¡tests!

%%% ¡excluded_props!
[SettingsAreaPP.PARENT SettingsAreaPP.H SettingsAreaPP.LISTENER_CB SettingsAreaPP.CHECKBOX_VISIBLE SettingsAreaPP.BUTTON_FACECOLOR SettingsAreaPP.EDITFIELD_FACEALPHA SettingsAreaPP.SLIDER_FACEALPHA SettingsAreaPP.BUTTON_EDGECOLOR SettingsAreaPP.EDITFIELD_EDGEALPHA SettingsAreaPP.SLIDER_EDGEALPHA]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':SettingsAreaPP'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':SettingsAreaPP'])