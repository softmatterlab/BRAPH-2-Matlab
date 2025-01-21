%% ¡header!
SettingsLinePP < SettingsPP (pr, prop panel for line settings) is the panel with line settings.

%%% ¡description!
A Prop Panel for Line Settings (SettingsLinePP) plots the panel for 
 line settings, including visibility, line style, size and color, 
 and symbol style, size, edge color, and face color.
It works for all categories.

%%% ¡seealso!
SettingsLine, uicheckbox, uidropdown, uieditfield, uipushbutton

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the property panel for line settings.
%%%% ¡default!
'SettingsLinePP'

%%% ¡prop!
NAME (constant, string) is the name of the property panel for line settings.
%%%% ¡default!
'Prop Panel for Line Settings'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the property panel for line settings.
%%%% ¡default!
'A Prop Panel for Line Settings (SettingsLinePP) plots the panel for line settings, including visibility, line style, size and color, and symbol style, size, edge color, and face color. It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the property panel for line settings.
%%%% ¡settings!
'SettingsLinePP'

%%% ¡prop!
ID (data, string) is a few-letter code for the property panel for line settings.
%%%% ¡default!
'SettingsLinePP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the property panel for line settings.
%%%% ¡default!
'SettingsLinePP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the property panel for line settings.
%%%% ¡default!
'SettingsLinePP notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
GraphHistPF()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
GraphHistPF.ST_DENSITY_LINE

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

    pr.memorize('DROPDOWN_LINESTYLE')
    pr.memorize('EDITFIELD_LINEWIDTH')
    pr.memorize('BUTTON_LINECOLOR')
    
    pr.memorize('DROPDOWN_SYMBOL')
    pr.memorize('EDITFIELD_SYMBOLSIZE')
    pr.memorize('BUTTON_FACECOLOR')
    pr.memorize('BUTTON_EDGECOLOR')
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
        
        set(pr.get('DROPDOWN_LINESTYLE'), 'Enable', 'off')
        set(pr.get('EDITFIELD_LINEWIDTH'), ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.get('BUTTON_LINECOLOR'), 'Enable', pr.get('ENABLE'))        

        set(pr.get('DROPDOWN_SYMBOL'), 'Enable', 'off')
        set(pr.get('EDITFIELD_SYMBOLSIZE'), ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.get('BUTTON_FACECOLOR'), 'Enable', pr.get('ENABLE'))        
        set(pr.get('BUTTON_EDGECOLOR'), 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.get('CHECKBOX_VISIBLE'), 'Value', el.get(prop).get('VISIBLE'))
            
            set(pr.get('DROPDOWN_LINESTYLE'), 'Value', el.get(prop).get('LINESTYLE'))
            set(pr.get('EDITFIELD_LINEWIDTH'), 'Value', el.get(prop).get('LINEWIDTH'))
            set(pr.get('BUTTON_LINECOLOR'), 'BackgroundColor', el.get(prop).get('LINECOLOR'))

            set(pr.get('DROPDOWN_SYMBOL'), 'Value', el.get(prop).get('SYMBOL'))
            set(pr.get('EDITFIELD_SYMBOLSIZE'), 'Value', el.get(prop).get('SYMBOLSIZE'))
            set(pr.get('BUTTON_FACECOLOR'), 'BackgroundColor', el.get(prop).get('FACECOLOR'))
            set(pr.get('BUTTON_EDGECOLOR'), 'BackgroundColor', el.get(prop).get('EDGECOLOR'))
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('CHECKBOX_VISIBLE'), 'Value', el.get(prop).get('VISIBLE'))

            set(pr.get('DROPDOWN_LINESTYLE'), 'Value', el.get(prop).get('LINESTYLE'))
            set(pr.get('EDITFIELD_LINEWIDTH'), 'Value', el.get(prop).get('LINEWIDTH'))
            set(pr.get('BUTTON_LINECOLOR'), 'BackgroundColor', el.get(prop).get('LINECOLOR'))

            set(pr.get('DROPDOWN_SYMBOL'), 'Value', el.get(prop).get('SYMBOL'))
            set(pr.get('EDITFIELD_SYMBOLSIZE'), 'Value', el.get(prop).get('SYMBOLSIZE'))
            set(pr.get('BUTTON_FACECOLOR'), 'BackgroundColor', el.get(prop).get('FACECOLOR'))
            set(pr.get('BUTTON_EDGECOLOR'), 'BackgroundColor', el.get(prop).get('EDGECOLOR'))
            
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('VISIBLE'), 'Callback')
                set(pr.get('CHECKBOX_VISIBLE'), 'Enable', pr.get('ENABLE'))
            end
            
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('LINESTYLE'), 'Callback')
                set(pr.get('DROPDOWN_LINESTYLE'), 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('LINEWIDTH'), 'Callback')
                set(pr.get('EDITFIELD_LINEWIDTH'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('LINECOLOR'), 'Callback')
                set(pr.get('BUTTON_LINECOLOR'), 'Enable', pr.get('ENABLE'))
            end
            
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('SYMBOL'), 'Callback')
                set(pr.get('DROPDOWN_SYMBOL'), 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('SYMBOLSIZE'), 'Callback')
                set(pr.get('EDITFIELD_SYMBOLSIZE'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end            
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FACECOLOR'), 'Callback')
                set(pr.get('BUTTON_FACECOLOR'), 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('EDGECOLOR'), 'Callback')
                set(pr.get('BUTTON_EDGECOLOR'), 'Enable', pr.get('ENABLE'))
            end
            
        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.get('CHECKBOX_VISIBLE'), ...
                    'Value', el.get(prop).getPropDefault('VISIBLE'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                
                set(pr.get('DROPDOWN_LINESTYLE'), ...
                    'Value', el.get(prop).getPropDefault('LINESTYLE'), ...
                    'Enable', 'off' ...
                    )
                set(pr.get('EDITFIELD_LINEWIDTH'), ...
                    'Value', el.get(prop).getPropDefault('LINEWIDTH'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('BUTTON_LINECOLOR'), ...
                    'BackgroundColor', el.get(prop).getPropDefault('LINECOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                
                set(pr.get('DROPDOWN_SYMBOL'), ...
                    'Value', el.get(prop).getPropDefault('SYMBOL'), ...
                    'Enable', 'off' ...
                    )
                set(pr.get('EDITFIELD_SYMBOLSIZE'), ...
                    'Value', el.get(prop).getPropDefault('SYMBOLSIZE'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('BUTTON_FACECOLOR'), ...
                    'BackgroundColor', el.get(prop).getPropDefault('FACECOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('BUTTON_EDGECOLOR'), ...
                    'BackgroundColor', el.get(prop).getPropDefault('EDGECOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                set(pr.get('CHECKBOX_VISIBLE'), ...
                    'Value', el.get(prop).get('VISIBLE'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                
                set(pr.get('DROPDOWN_LINESTYLE'), ...
                    'Value', el.get(prop).get('LINESTYLE'), ...
                    'Enable', 'off' ...
                    )
                set(pr.get('EDITFIELD_LINEWIDTH'), ...
                    'Value', el.get(prop).get('LINEWIDTH'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('BUTTON_LINECOLOR'), ...
                    'BackgroundColor', el.get(prop).get('LINECOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )

                set(pr.get('DROPDOWN_SYMBOL'), ...
                    'Value', el.get(prop).get('SYMBOL'), ...
                    'Enable', 'off' ...
                    )
                set(pr.get('EDITFIELD_SYMBOLSIZE'), ...
                    'Value', el.get(prop).get('SYMBOLSIZE'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('BUTTON_FACECOLOR'), ...
                    'BackgroundColor', el.get(prop).get('FACECOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('BUTTON_EDGECOLOR'), ...
                    'BackgroundColor', el.get(prop).get('EDGECOLOR'), ...
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

    set(pr.get('DROPDOWN_LINESTYLE'),   'Position', [s(.3)          s(3.2) .15*w_p s(1.75)])
    set(pr.get('EDITFIELD_LINEWIDTH'),  'Position', [s(.3)+.20*w_p  s(3.2) .15*w_p s(1.75)])
    set(pr.get('BUTTON_LINECOLOR'),     'Position', [s(.3)+.40*w_p  s(3.2) .20*w_p s(1.7)])
    
    set(pr.get('DROPDOWN_SYMBOL'),      'Position', [s(.3)          s(.7) .15*w_p s(1.75)])
    set(pr.get('EDITFIELD_SYMBOLSIZE'), 'Position', [s(.3)+.20*w_p  s(.7) .15*w_p s(1.75)])
    set(pr.get('BUTTON_FACECOLOR'),     'Position', [s(.3)+.40*w_p  s(.7) .20*w_p s(1.7)])
    set(pr.get('BUTTON_EDGECOLOR'),     'Position', [s(.3)+.65*w_p  s(.7) .20*w_p s(1.7)])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
	pr.set('CHECKBOX_VISIBLE', Element.getNoValue())
    
    pr.set('DROPDOWN_LINESTYLE', Element.getNoValue())
    pr.set('EDITFIELD_LINEWIDTH', Element.getNoValue())
    pr.set('BUTTON_LINECOLOR', Element.getNoValue())
    
    pr.set('DROPDOWN_SYMBOL', Element.getNoValue())
    pr.set('EDITFIELD_SYMBOLSIZE', Element.getNoValue())
    pr.set('BUTTON_FACECOLOR', Element.getNoValue())
    pr.set('BUTTON_EDGECOLOR', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.
%%%% ¡default!
true

%%% ¡prop!
CHECKBOX_VISIBLE (evanescent, handle) determines whether the line is visible.
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
DROPDOWN_LINESTYLE (evanescent, handle) is the line style dropdown.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
dropdown_linestyle = uidropdown( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'DROPDOWN_LINESTYLE', ...
    'Items', el.get(prop).getPropSettings('LINESTYLE'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LINESTYLE')) ' ' el.get(prop).getPropDescription('LINESTYLE')], ...
    'ValueChangedFcn', {@cb_dropdown_linestyle} ...
    );

value = dropdown_linestyle;
%%%% ¡calculate_callbacks!
function cb_dropdown_linestyle(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set('LINESTYLE', get(pr.get('DROPDOWN_LINESTYLE'), 'Value'))
end

%%% ¡prop!
EDITFIELD_LINEWIDTH (evanescent, handle) is the line width edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
editfield_linewidth = uieditfield('numeric', ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'EDITFIELD_LINEWIDTH', ...
    'Limits', [0 +Inf], ...
    'LowerLimitInclusive', false, ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LINEWIDTH')) ' ' el.get(prop).getPropDescription('LINEWIDTH')], ...
    'ValueChangedFcn', {@cb_editfield_linewidth} ...
    );

value = editfield_linewidth;
%%%% ¡calculate_callbacks!
function cb_editfield_linewidth(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set('LINEWIDTH', get(pr.get('EDITFIELD_LINEWIDTH'), 'Value'))
end

%%% ¡prop!
BUTTON_LINECOLOR (evanescent, handle) is the line color button.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
button_linecolor = uibutton( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'BUTTON_LINECOLOR', ...
    'Text', 'line', ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LINECOLOR')) ' ' el.get(prop).getPropDescription('LINECOLOR')], ...
    'ButtonPushedFcn', {@cb_button_linecolor}, ...
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    );
value = button_linecolor;
%%%% ¡calculate_callbacks!
function cb_button_linecolor(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');

    new_color = uisetcolor(el.get(prop).get('LINECOLOR'));
    if ~isequal(new_color, el.get(prop).get('LINECOLOR'))
        el.get(prop).set('LINECOLOR', new_color)

        pr.get('UPDATE')
    end
end

%%% ¡prop!
DROPDOWN_SYMBOL (evanescent, handle) is the marker value dropdown.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
dropdown_symbol = uidropdown( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'DROPDOWN_SYMBOL', ...
    'Items', el.get(prop).getPropSettings('SYMBOL'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('SYMBOL')) ' ' el.get(prop).getPropDescription('SYMBOL')], ...
    'ValueChangedFcn', {@cb_dropdown_symbol} ...
    );

value = dropdown_symbol;
%%%% ¡calculate_callbacks!
function cb_dropdown_symbol(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set('SYMBOL', get(pr.get('DROPDOWN_SYMBOL'), 'Value'))
end

%%% ¡prop!
EDITFIELD_SYMBOLSIZE (evanescent, handle) is the symbol size edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

editfield_symbolsize = uieditfield('numeric', ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'EDITFIELD_SYMBOLSIZE', ...
    'Limits', [0 +Inf], ...
    'LowerLimitInclusive', false, ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('SYMBOLSIZE')) ' ' el.get(prop).getPropDescription('SYMBOLSIZE')], ...
    'ValueChangedFcn', {@cb_editfield_symbolsize} ...
    );

value = editfield_symbolsize;
%%%% ¡calculate_callbacks!
function cb_editfield_symbolsize(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');

    el.get(prop).set('SYMBOLSIZE', get(pr.get('EDITFIELD_SYMBOLSIZE'), 'Value'))
end

%%% ¡prop!
BUTTON_FACECOLOR (evanescent, handle) is the marker face color button.
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
BUTTON_EDGECOLOR (evanescent, handle) is the marker edge color button.
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

%% ¡tests!

%%% ¡excluded_props!
[SettingsLinePP.PARENT SettingsLinePP.H SettingsLinePP.LISTENER_CB SettingsLinePP.CHECKBOX_VISIBLE SettingsLinePP.DROPDOWN_LINESTYLE SettingsLinePP.EDITFIELD_LINEWIDTH SettingsLinePP.BUTTON_LINECOLOR SettingsLinePP.DROPDOWN_SYMBOL SettingsLinePP.EDITFIELD_SYMBOLSIZE SettingsLinePP.BUTTON_FACECOLOR SettingsLinePP.BUTTON_EDGECOLOR]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':SettingsLinePP'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':SettingsLinePP'])
