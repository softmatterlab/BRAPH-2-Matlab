%% ¡header!
SettingsAxisPP < SettingsPP (pr, prop panel for axis settings) is the panel with axis settings.

%%% ¡description!
A Prop Panel for Axis Settings (SettingsAxisPP) plots the panel 
 for axis settings, including a button for the axis color and 
 checkboxes for axis on/off, grid on/off, equal on/off, and tight on/off.
It works for all categories.

%%% ¡seealso!
SettingsPosition, uicheckbox, uipushbutton

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the property panel for axis settings.
%%%% ¡default!
'SettingsAxisPP'

%%% ¡prop!
NAME (constant, string) is the name of the property panel for axis settings.
%%%% ¡default!
'Prop Panel for Axis Settings'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the property panel for axis settings.
%%%% ¡default!
'A Prop Panel for Axis Settings (SettingsAxisPP) plots the panel for axis settings, including a button for the axis color and checkboxes for axis on/off, grid on/off, equal on/off, and tight on/off. It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the property panel for axis settings.
%%%% ¡settings!
'SettingsAxisPP'

%%% ¡prop!
ID (data, string) is a few-letter code for the property panel for axis settings.
%%%% ¡default!
'SettingsAxisPP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the property panel for axis settings.
%%%% ¡default!
'SettingsAxisPP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the property panel for axis settings.
%%%% ¡default!
'SettingsAxisPP notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
BrainSurfacePF()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
BrainSurfacePF.ST_AXIS

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the settings position panel.
%%%% ¡default!
s(5.5)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('BUTTON_AXISCOLOR')
    pr.memorize('CHECKBOX_AXIS')
    pr.memorize('CHECKBOX_GRID')
    pr.memorize('CHECKBOX_EQUAL')
    pr.memorize('CHECKBOX_TIGHT')
    pr.memorize('CHECKBOX_BOX')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.get('BUTTON_AXISCOLOR'), 'Enable', pr.get('ENABLE'))
        set(pr.get('CHECKBOX_AXIS'), 'Enable', pr.get('ENABLE'))
        set(pr.get('CHECKBOX_GRID'), 'Enable', pr.get('ENABLE'))
        set(pr.get('CHECKBOX_EQUAL'), 'Enable', pr.get('ENABLE'))
        set(pr.get('CHECKBOX_TIGHT'), 'Enable', pr.get('ENABLE'))
        set(pr.get('CHECKBOX_BOX'), 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.get('BUTTON_AXISCOLOR'), 'BackgroundColor', el.get(prop).get('AXISCOLOR'))
            set(pr.get('CHECKBOX_AXIS'), 'Value', el.get(prop).get('AXIS'))
            set(pr.get('CHECKBOX_GRID'), 'Value', el.get(prop).get('GRID'))
            set(pr.get('CHECKBOX_EQUAL'), 'Value', el.get(prop).get('EQUAL'))
            set(pr.get('CHECKBOX_TIGHT'), 'Value', el.get(prop).get('TIGHT'))
            set(pr.get('CHECKBOX_BOX'), 'Value', el.get(prop).get('BOX'))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('BUTTON_AXISCOLOR'), 'BackgroundColor', el.get(prop).get('AXISCOLOR'))
            set(pr.get('CHECKBOX_AXIS'), 'Value', el.get(prop).get('AXIS'))
            set(pr.get('CHECKBOX_GRID'), 'Value', el.get(prop).get('GRID'))
            set(pr.get('CHECKBOX_EQUAL'), 'Value', el.get(prop).get('EQUAL'))
            set(pr.get('CHECKBOX_TIGHT'), 'Value', el.get(prop).get('TIGHT'))
            set(pr.get('CHECKBOX_BOX'), 'Value', el.get(prop).get('BOX'))

            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('AXISCOLOR'), 'Callback')
                set(pr.get('BUTTON_AXISCOLOR'), 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('AXIS'), 'Callback')
                set(pr.get('CHECKBOX_AXIS'), 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('GRID'), 'Callback')
                set(pr.get('CHECKBOX_GRID'), 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('EQUAL'), 'Callback')
                set(pr.get('CHECKBOX_EQUAL'), 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('TIGHT'), 'Callback')
                set(pr.get('CHECKBOX_TIGHT'), 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('BOX'), 'Callback')
                set(pr.get('CHECKBOX_BOX'), 'Enable', pr.get('ENABLE'))
            end
            
        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.get('BUTTON_AXISCOLOR'), ...
                    'BackgroundColor', el.get(prop).getPropDefault('AXISCOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('CHECKBOX_AXIS'), ...
                    'Value', el.get(prop).getPropDefault('AXIS'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('CHECKBOX_GRID'), ...
                    'Value', el.get(prop).getPropDefault('GRID'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('CHECKBOX_EQUAL'), ...
                    'Value', el.get(prop).getPropDefault('EQUAL'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('CHECKBOX_TIGHT'), ...
                    'Value', el.get(prop).getPropDefault('TIGHT'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('CHECKBOX_BOX'), ...
                    'Value', el.get(prop).getPropDefault('BOX'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                set(pr.get('BUTTON_AXISCOLOR'), ...
                    'BackgroundColor', el.get(prop).get('AXISCOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('CHECKBOX_AXIS'), ...
                    'Value', el.get(prop).get('AXIS'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('CHECKBOX_GRID'), ...
                    'Value', el.get(prop).get('GRID'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('CHECKBOX_EQUAL'), ...
                    'Value', el.get(prop).get('EQUAL'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('CHECKBOX_TIGHT'), ...
                    'Value', el.get(prop).get('TIGHT'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('CHECKBOX_BOX'), ...
                    'Value', el.get(prop).get('BOX'), ...
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
    
    set(pr.get('BUTTON_AXISCOLOR'), 'Position', [s(.9)+.60*w_p s(2.3) .30*w_p s(1.7)])
    set(pr.get('CHECKBOX_AXIS'), 'Position', [s(.3) s(2.3) .30*w_p s(1.7)])
    set(pr.get('CHECKBOX_GRID'), 'Position', [s(.6)+.30*w_p s(2.3) .30*w_p s(1.7)])
    set(pr.get('CHECKBOX_EQUAL'), 'Position', [s(.3) s(.3) .30*w_p s(1.7)])
    set(pr.get('CHECKBOX_TIGHT'), 'Position', [s(.6)+.30*w_p s(.3) .30*w_p s(1.7)])
    set(pr.get('CHECKBOX_BOX'), 'Position', [s(.6)+.60*w_p s(.3) .30*w_p s(1.7)])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('BUTTON_AXISCOLOR', Element.getNoValue())
    pr.set('CHECKBOX_AXIS', Element.getNoValue())
    pr.set('CHECKBOX_GRID', Element.getNoValue())
    pr.set('CHECKBOX_EQUAL', Element.getNoValue())
    pr.set('CHECKBOX_TIGHT', Element.getNoValue())
    pr.set('CHECKBOX_BOX', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.
%%%% ¡default!
true

%%% ¡prop!
BUTTON_AXISCOLOR (evanescent, handle) is the axis color button.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
button_axiscolor = uibutton( ...
    'Parent', pr.memorize('H'), ...
	'Tag', 'BUTTON_AXISCOLOR', ...
	'Text', '', ...
	'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('AXISCOLOR')) ' ' el.get(prop).getPropDescription('AXISCOLOR')], ...
	'ButtonPushedFcn', {@cb_button_axiscolor}, ...
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
	);
value = button_axiscolor;
%%%% ¡calculate_callbacks!
function cb_button_axiscolor(~, ~)

    el = pr.get('EL');
    prop = pr.get('PROP');

    new_color = uisetcolor(el.get(prop).get('AXISCOLOR'));
    if ~isequal(new_color, el.get(prop).get('AXISCOLOR'))
        el.get(prop).set('AXISCOLOR', new_color)

        pr.get('UPDATE')
    end
end

%%% ¡prop!
CHECKBOX_AXIS (evanescent, handle) is the axis checkbox.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
checkbox_axis = uicheckbox( ...
    'Parent', pr.memorize('H'), ...
	'Tag', 'CHECKBOX_AXIS', ...
    'Text', 'axis', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('AXIS')) ' ' el.get(prop).getPropDescription('AXIS')], ...
    'ValueChangedFcn', {@cb_axis} ...
    );
value = checkbox_axis;
%%%% ¡calculate_callbacks!
function cb_axis(~, ~)

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set( ...
        'AXIS', get(pr.get('CHECKBOX_AXIS'), 'Value'), ...
        'GRID', get(pr.get('CHECKBOX_GRID'), 'Value'), ...
        'EQUAL', get(pr.get('CHECKBOX_EQUAL'), 'Value'), ...
        'TIGHT', get(pr.get('CHECKBOX_TIGHT'), 'Value'), ...
        'BOX', get(pr.get('CHECKBOX_BOX'), 'Value') ...
        )

end

%%% ¡prop!
CHECKBOX_GRID (evanescent, handle) is the grid checkbox.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
checkbox_grid = uicheckbox( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'CHECKBOX_GRID', ...
    'Text', 'grid', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('GRID')) ' ' el.get(prop).getPropDescription('GRID')], ...
    'ValueChangedFcn', {@cb_axis} ... % callback in CHECKBOX_AXIS
    );
value = checkbox_grid;

%%% ¡prop!
CHECKBOX_EQUAL (evanescent, handle) is the equal checkbox.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
checkbox_equal = uicheckbox( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'CHECKBOX_EQUAL', ...
    'Text', 'equal', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('EQUAL')) ' ' el.get(prop).getPropDescription('EQUAL')], ...
    'ValueChangedFcn', {@cb_axis} ... % callback in CHECKBOX_AXIS
    );
value = checkbox_equal;

%%% ¡prop!
CHECKBOX_TIGHT (evanescent, handle) is the tight checkbox.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
checkbox_tight = uicheckbox( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'CHECKBOX_TIGHT', ...
    'Text', 'tight', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('TIGHT')) ' ' el.get(prop).getPropDescription('TIGHT')], ...
    'ValueChangedFcn', {@cb_axis} ... % callback in CHECKBOX_AXIS
    );
value = checkbox_tight;

%%% ¡prop!
CHECKBOX_BOX (evanescent, handle) is the box checkbox.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
checkbox_box = uicheckbox( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'CHECKBOX_BOX', ...
    'Text', 'box', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('BOX')) ' ' el.get(prop).getPropDescription('BOX')], ...
    'ValueChangedFcn', {@cb_axis} ... % callback in CHECKBOX_AXIS
    );
value = checkbox_box;

%% ¡tests!

%%% ¡excluded_props!
[SettingsAxisPP.PARENT SettingsAxisPP.H SettingsAxisPP.LISTENER_CB SettingsAxisPP.BUTTON_AXISCOLOR SettingsAxisPP.CHECKBOX_AXIS SettingsAxisPP.CHECKBOX_GRID SettingsAxisPP.CHECKBOX_EQUAL SettingsAxisPP.CHECKBOX_TIGHT SettingsAxisPP.CHECKBOX_BOX]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':SettingsAxisPP'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':SettingsAxisPP'])
