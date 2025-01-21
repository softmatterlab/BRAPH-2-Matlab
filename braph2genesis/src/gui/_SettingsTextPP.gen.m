%% ¡header!
SettingsTextPP < SettingsPP (pr, prop panel for text settings) is the panel with text settings.

%%% ¡description!
A Prop Panel for Text Settings (SettingsTextPP) plots the panel 
 for text settings, including text, x, y, and z position, 
 font color, size, rotation and weight, 
 interpreter, horizontal and vertical alignment.
It works for all categories.

%%% ¡seealso!
SettingsText, uieditfield, uipushbutton, uislider

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the prop panel for text settings.
%%%% ¡default!
'SettingsTextPP'

%%% ¡prop!
NAME (constant, string) is the name of the prop panel for text settings.
%%%% ¡default!
'Prop Panel for Text Settings'
 
%%% ¡prop!
DESCRIPTION (constant, string) is the description of the prop panel for text settings.
%%%% ¡default!
'A Prop Panel for Text Settings (SettingsTextPP) plots the panel for text settings, including text, x, y, and z position, font color, size, rotation and weight, interpreter, horizontal and vertical alignment. It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the prop panel for text settings.
%%%% ¡settings!
'SettingsTextPP'

%%% ¡prop!
ID (data, string) is a few-letter code for the prop panel for text settings.
%%%% ¡default!
'SettingsTextPP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the prop panel for text settings.
%%%% ¡default!
'SettingsTextPP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the prop panel for text settings.
%%%% ¡default!
'SettingsTextPP notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
MeasurePF()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
MeasurePF.ST_TITLE

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the prop panel for text settings.
%%%% ¡default!
s(9.2)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('EDITFIELD_X')
    pr.memorize('EDITFIELD_Y')
    pr.memorize('EDITFIELD_Z')
    pr.memorize('EDITFIELD_TXT')
    
    pr.memorize('BUTTON_FONTCOLOR')
    pr.memorize('EDITFIELD_FONTSIZE')
    pr.memorize('SLIDER_FONTSIZE')
    pr.memorize('EDITFIELD_ROTATION')
    pr.memorize('SLIDER_ROTATION')
        
    pr.memorize('EDITFIELD_FONTNAME')
    pr.memorize('DROPDOWN_FONTWEIGHT')
    pr.memorize('DROPDOWN_INTERPRETER')
    pr.memorize('DROPDOWN_HALIGN')
    pr.memorize('DROPDOWN_VALIGN')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.get('EDITFIELD_X'), ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.get('EDITFIELD_Y'), ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.get('EDITFIELD_Z'), ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.get('EDITFIELD_TXT'), ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )        
        
        set(pr.get('BUTTON_FONTCOLOR'), 'Enable', pr.get('ENABLE'))
        set(pr.get('EDITFIELD_FONTSIZE'), ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.get('SLIDER_FONTSIZE'), 'Enable', pr.get('ENABLE'))
        set(pr.get('EDITFIELD_ROTATION'), ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.get('SLIDER_ROTATION'), 'Enable', pr.get('ENABLE'))
        
        set(pr.get('EDITFIELD_FONTNAME'), ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.get('DROPDOWN_FONTWEIGHT'), 'Enable', 'off')
        set(pr.get('DROPDOWN_INTERPRETER'), 'Enable', 'off')
        set(pr.get('DROPDOWN_HALIGN'), 'Enable', 'off')
        set(pr.get('DROPDOWN_VALIGN'), 'Enable', 'off')
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.get('EDITFIELD_X'), 'Value', el.get(prop).get('X'))
            set(pr.get('EDITFIELD_Y'), 'Value', el.get(prop).get('Y'))
            set(pr.get('EDITFIELD_Z'), 'Value', el.get(prop).get('Z'))
            set(pr.get('EDITFIELD_TXT'), 'Value', el.get(prop).get('TXT'))
            
            set(pr.get('BUTTON_FONTCOLOR'), 'BackgroundColor', el.get(prop).get('COLOR'))
            set(pr.get('EDITFIELD_FONTSIZE'), 'Value', el.get(prop).get('FONTSIZE'))
            set(pr.get('SLIDER_FONTSIZE'), 'Value', el.get(prop).get('FONTSIZE'))
            set(pr.get('EDITFIELD_ROTATION'), 'Value', el.get(prop).get('ROTATION'))
            set(pr.get('SLIDER_ROTATION'), 'Value', el.get(prop).get('ROTATION'))

            set(pr.get('EDITFIELD_FONTNAME'), 'Value', el.get(prop).get('FONTNAME'))
            set(pr.get('DROPDOWN_FONTWEIGHT'), 'Value', el.get(prop).get('FONTWEIGHT'))
            set(pr.get('DROPDOWN_INTERPRETER'), 'Value', el.get(prop).get('INTERPRETER'))
            set(pr.get('DROPDOWN_HALIGN'), 'Value', el.get(prop).get('HALIGN'))
            set(pr.get('DROPDOWN_VALIGN'), 'Value', el.get(prop).get('VALIGN'))
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('EDITFIELD_X'), 'Value', el.get(prop).get('X'))
            set(pr.get('EDITFIELD_Y'), 'Value', el.get(prop).get('Y'))
            set(pr.get('EDITFIELD_Z'), 'Value', el.get(prop).get('Z'))
            set(pr.get('EDITFIELD_TXT'), 'Value', el.get(prop).get('TXT'))
            
            set(pr.get('BUTTON_FONTCOLOR'), 'BackgroundColor', el.get(prop).get('FONTCOLOR'))
            set(pr.get('EDITFIELD_FONTSIZE'), 'Value', el.get(prop).get('FONTSIZE'))
            set(pr.get('SLIDER_FONTSIZE'), 'Value', el.get(prop).get('FONTSIZE'))
            set(pr.get('EDITFIELD_ROTATION'), 'Value', el.get(prop).get('ROTATION'))
            set(pr.get('SLIDER_ROTATION'), 'Value', el.get(prop).get('ROTATION'))

            set(pr.get('EDITFIELD_FONTNAME'), 'Value', el.get(prop).get('FONTNAME'))
            set(pr.get('DROPDOWN_FONTWEIGHT'), 'Value', el.get(prop).get('FONTWEIGHT'))
            set(pr.get('DROPDOWN_INTERPRETER'), 'Value', el.get(prop).get('INTERPRETER'))
            set(pr.get('DROPDOWN_HALIGN'), 'Value', el.get(prop).get('HALIGN'))
            set(pr.get('DROPDOWN_VALIGN'), 'Value', el.get(prop).get('VALIGN'))

            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('X'), 'Callback')
                set(pr.get('EDITFIELD_X'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('Y'), 'Callback')
                set(pr.get('EDITFIELD_Y'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('Z'), 'Callback')
                set(pr.get('EDITFIELD_Z'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('TXT'), 'Callback')
                set(pr.get('EDITFIELD_TXT'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end

            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FONTSIZE'), 'Callback')
                set(pr.get('BUTTON_FONTCOLOR'), 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FONTSIZE'), 'Callback')
                set(pr.get('EDITFIELD_FONTSIZE'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_FONTSIZE'), 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('ROTATION'), 'Callback')
                set(pr.get('EDITFIELD_ROTATION'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_ROTATION'), 'Enable', pr.get('ENABLE'))
            end
            
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FONTNAME'), 'Callback')
                set(pr.get('EDITFIELD_FONTNAME'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FONTWEIGHT'), 'Callback')
                set(pr.get('DROPDOWN_FONTWEIGHT'), 'Enable', 'off')
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('INTERPRETER'), 'Callback')
                set(pr.get('DROPDOWN_INTERPRETER'), 'Enable', 'off')
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('HALIGN'), 'Callback')
                set(pr.get('DROPDOWN_HALIGN'), 'Enable', 'off')
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('VALIGN'), 'Callback')
                set(pr.get('DROPDOWN_VALIGN'), 'Enable', 'off')
            end
            
        case Category.RESULT
            value = el.getr(prop);
            
            if isa(value, 'NoValue')
                set(pr.get('EDITFIELD_X'), ...
                    'Value', el.get(prop).getPropDefault('X'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_Y'), ...
                    'Value', el.get(prop).getPropDefault('Y'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_Z'), ...
                    'Value', el.get(prop).getPropDefault('Z'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_TXT'), ...
                    'Value', el.get(prop).getPropDefault('TXT'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )

                set(pr.get('BUTTON_FONTCOLOR'), ...
                    'BackgroundColor', el.get(prop).getPropDefault('FONTCOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_FONTSIZE'), ...
                    'Value', el.get(prop).getPropDefault('FONTSIZE'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_FONTSIZE'), ...
                    'Value', el.get(prop).getPropDefault('FONTSIZE'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_ROTATION'), ...
                    'Value', el.get(prop).getPropDefault('ROTATION'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_ROTATION'), ...
                    'Value', el.get(prop).getPropDefault('ROTATION'), ...
                    'Enable', pr.get('ENABLE') ...
                    )

                set(pr.get('EDITFIELD_FONTNAME'), ...
                    'Value', el.get(prop).getPropDefault('FONTNAME'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('DROPDOWN_FONTWEIGHT'), ...
                    'Value', el.get(prop).getPropDefault('FONTWEIGHT'), ...
                    'Editable', 'off' ...
                    )
                set(pr.get('DROPDOWN_INTERPRETER'), ...
                    'Value', el.get(prop).getPropDefault('INTERPRETER'), ...
                    'Editable', 'off' ...
                    )
                set(pr.get('DROPDOWN_HALIGN'), ...
                    'Value', el.get(prop).getPropDefault('HALIGN'), ...
                    'Editable', 'off' ...
                    )
                set(pr.get('DROPDOWN_VALIGN'), ...
                    'Value', el.get(prop).getPropDefault('VALIGN'), ...
                    'Editable', 'off' ...
                    )
            else
                set(pr.get('EDITFIELD_X'), ...
                    'Value', el.get(prop).get('X'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_Y'), ...
                    'Value', el.get(prop).get('Y'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_Z'), ...
                    'Value', el.get(prop).get('Z'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_TXT'), ...
                    'Value', el.get(prop).get('TXT'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )

                set(pr.get('BUTTON_FONTCOLOR'), ...
                    'BackgroundColor', el.get(prop).get('FONTCOLOR'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_FONTSIZE'), ...
                    'Value', el.get(prop).get('FONTSIZE'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_FONTSIZE'), ...
                    'Value', el.get(prop).get('FONTSIZE'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_ROTATION'), ...
                    'Value', el.get(prop).get('ROTATION'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_ROTATION'), ...
                    'Value', el.get(prop).get('ROTATION'), ...
                    'Enable', pr.get('ENABLE') ...
                    )

                set(pr.get('EDITFIELD_FONTNAME'), ...
                    'Value', el.get(prop).get('FONTNAME'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('DROPDOWN_FONTWEIGHT'), ...
                    'Value', el.get(prop).get('FONTWEIGHT'), ...
                    'Editable', 'off' ...
                    )
                set(pr.get('DROPDOWN_INTERPRETER'), ...
                    'Value', el.get(prop).get('INTERPRETER'), ...
                    'Editable', 'off' ...
                    )
                set(pr.get('DROPDOWN_HALIGN'), ...
                    'Value', el.get(prop).get('HALIGN'), ...
                    'Editable', 'off' ...
                    )
                set(pr.get('DROPDOWN_VALIGN'), ...
                    'Value', el.get(prop).get('VALIGN'), ...
                    'Editable', 'off' ...
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

    set(pr.get('EDITFIELD_X'),   'Position', [s(.3)           s(6.1)   .10*w_p     s(1.75)])
    set(pr.get('EDITFIELD_Y'),   'Position', [s(.6)+.10*w_p   s(6.1)   .10*w_p     s(1.75)])
    set(pr.get('EDITFIELD_Z'),   'Position', [s(.9)+.20*w_p   s(6.1)   .10*w_p     s(1.75)])
    set(pr.get('EDITFIELD_TXT'), 'Position', [s(1.2)+.30*w_p  s(6.1)  .60*w_p     s(1.75)])
    
    set(pr.get('BUTTON_FONTCOLOR'),   'Position', [s(.3)            s(3.2)  .20*w_p   s(1.7)])
    set(pr.get('EDITFIELD_FONTSIZE'), 'Position', [s(.6)+.20*w_p	s(3.2)  .15*w_p   s(1.7)])
    set(pr.get('SLIDER_FONTSIZE'),    'Position', [s(.9)+.35*w_p	s(4.75) .20*w_p   3]) % the height of a slider cannot be changed
    set(pr.get('EDITFIELD_ROTATION'), 'Position', [s(1.5)+.55*w_p	s(3.2)  .15*w_p   s(1.7)])
    set(pr.get('SLIDER_ROTATION'),    'Position', [s(1.8)+.70*w_p	s(4.75) .20*w_p   3]) % the height of a slider cannot be changed
    
    set(pr.get('EDITFIELD_FONTNAME'),   'Position', [s(.3)          s(.3)   .20*w_p     s(1.75)])    
    set(pr.get('DROPDOWN_FONTWEIGHT'),  'Position', [s(.6)+.20*w_p  s(.3)   .18*w_p     s(1.75)])    
    set(pr.get('DROPDOWN_INTERPRETER'), 'Position', [s(.9)+.38*w_p  s(.3)   .18*w_p     s(1.75)])    
    set(pr.get('DROPDOWN_HALIGN'),      'Position', [s(1.2)+.56*w_p	s(.3)   .18*w_p     s(1.75)])    
    set(pr.get('DROPDOWN_VALIGN'),      'Position', [s(1.5)+.74*w_p	s(.3)   .18*w_p     s(1.75)])    
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('EDITFIELD_X', Element.getNoValue())
    pr.set('EDITFIELD_Y', Element.getNoValue())
    pr.set('EDITFIELD_Z', Element.getNoValue())
    pr.set('EDITFIELD_TXT', Element.getNoValue())
    
    pr.set('BUTTON_FONTCOLOR', Element.getNoValue())
    pr.set('EDITFIELD_FONTSIZE', Element.getNoValue())
    pr.set('SLIDER_FONTSIZE', Element.getNoValue())
    pr.set('EDITFIELD_ROTATION', Element.getNoValue())
    pr.set('SLIDER_ROTATION', Element.getNoValue())

    pr.set('EDITFIELD_FONTNAME', Element.getNoValue())
    pr.set('DROPDOWN_FONTWEIGHT', Element.getNoValue())
    pr.set('DROPDOWN_INTERPRETER', Element.getNoValue())
    pr.set('DROPDOWN_HALIGN', Element.getNoValue())
    pr.set('DROPDOWN_VALIGN', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.
%%%% ¡default!
true

%%% ¡prop!
EDITFIELD_X (evanescent, handle) is the text value edit field for the X property.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

editfield = uieditfield('numeric', ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'EDITFIELD_X', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('X')) ' ' el.get(prop).getPropDescription('X')], ...
    'ValueChangedFcn', {@cb_editfield_x} ...
    );

value = editfield;
%%%% ¡calculate_callbacks!
function cb_editfield_x(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');

    el.get(prop).set('X', get(pr.get('EDITFIELD_X'), 'Value'))
end

%%% ¡prop!
EDITFIELD_Y (evanescent, handle) is the text value edit field for the Y property.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

editfield = uieditfield('numeric', ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'EDITFIELD_Y', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('Y')) ' ' el.get(prop).getPropDescription('Y')], ...
    'ValueChangedFcn', {@cb_editfield_y} ...
    );

value = editfield;
%%%% ¡calculate_callbacks!
function cb_editfield_y(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');

    el.get(prop).set('Y', get(pr.get('EDITFIELD_Y'), 'Value'))
end

%%% ¡prop!
EDITFIELD_Z (evanescent, handle) is the text value edit field for the Z property.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

editfield = uieditfield('numeric', ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'EDITFIELD_Z', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('Z')) ' ' el.get(prop).getPropDescription('Z')], ...
    'ValueChangedFcn', {@cb_editfield_Z} ...
    );

value = editfield;
%%%% ¡calculate_callbacks!
function cb_editfield_z(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');

    el.get(prop).set('Z', get(pr.get('EDITFIELD_Z'), 'Value'))
end

%%% ¡prop!
EDITFIELD_TXT (evanescent, handle) is the text value edit field for the TXT property.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

editfield = uieditfield( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'EDITFIELD_TXT', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('TXT')) ' ' el.get(prop).getPropDescription('TXT')], ...
    'ValueChangedFcn', {@cb_editfield_txt} ...
    );

value = editfield;
%%%% ¡calculate_callbacks!
function cb_editfield_txt(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');

    el.get(prop).set('TXT', get(pr.get('EDITFIELD_TXT'), 'Value'))
end

%%% ¡prop!
BUTTON_FONTCOLOR (evanescent, handle) is the text color button.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
button_fontcolor = uibutton( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'BUTTON_FONTCOLOR', ...
    'Text', 'face', ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FONTCOLOR')) ' ' el.get(prop).getPropDescription('FONTCOLOR')], ...
    'ButtonPushedFcn', {@cb_button_fontcolor}, ...
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    );
value = button_fontcolor;
%%%% ¡calculate_callbacks!
function cb_button_fontcolor(~, ~)

    el = pr.get('EL');
    prop = pr.get('PROP');

    new_color = uisetcolor(el.get(prop).get('FONTCOLOR'));
    if ~isequal(new_color, el.get(prop).get('FONTCOLOR'))
        el.get(prop).set('FONTCOLOR', new_color)

        pr.get('UPDATE')
    end
end

%%% ¡prop!
EDITFIELD_FONTSIZE (evanescent, handle) is the font size edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
editfield_fontsize = uieditfield('numeric', ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'EDITFIELD_FONTSIZE', ...
    'Limits', [0 100], ...
    'LowerLimitInclusive', 'off', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FONTSIZE')) ' ' el.get(prop).getPropDescription('FONTSIZE')], ...
    'ValueChangedFcn', {@cb_editfield_fontsize} ...
    );
value = editfield_fontsize;
%%%% ¡calculate_callbacks!
function cb_editfield_fontsize(~, ~)

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set('FONTSIZE', get(pr.get('EDITFIELD_FONTSIZE'), 'Value'))

	pr.get('UPDATE')
end

%%% ¡prop!
SLIDER_FONTSIZE (evanescent, handle) is the font size slider.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
slider_fontsize = uislider( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'SLIDER_FONTSIZE', ...
    'Limits', [0 100], ...
    'FontSize', BRAPH2.FONTSIZE / 2, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FONTSIZE')) ' ' el.get(prop).getPropDescription('FONTSIZE')], ...
    'ValueChangedFcn', {@cb_slider_fontsize} ...
    );
value = slider_fontsize;
%%%% ¡calculate_callbacks!
function cb_slider_fontsize(~, ~)

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set('FONTSIZE', max(0.01, get(pr.get('SLIDER_FONTSIZE'), 'Value')))

	pr.get('UPDATE')
end

%%% ¡prop!
EDITFIELD_ROTATION (evanescent, handle) is the rotation edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
editfield_rotation = uieditfield('numeric', ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'EDITFIELD_ROTATION', ...
    'Limits', [-180 180], ...
    'LowerLimitInclusive', 'on', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('ROTATION')) ' ' el.get(prop).getPropDescription('ROTATION')], ...
    'ValueChangedFcn', {@cb_editfield_rotation} ...
    );
value = editfield_rotation;
%%%% ¡calculate_callbacks!
function cb_editfield_rotation(~, ~)

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set('ROTATION', get(pr.get('EDITFIELD_ROTATION'), 'Value'))

	pr.get('UPDATE')
end

%%% ¡prop!
SLIDER_ROTATION (evanescent, handle) is the rotation slider.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
slider_rotation = uislider( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'SLIDER_ROTATION', ...
    'Limits', [-180 180], ...
    'FontSize', BRAPH2.FONTSIZE / 2, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('ROTATION')) ' ' el.get(prop).getPropDescription('ROTATION')], ...
    'ValueChangedFcn', {@cb_slider_rotation} ...
    );
value = slider_rotation;
%%%% ¡calculate_callbacks!
function cb_slider_rotation(~, ~)

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set('ROTATION', get(pr.get('SLIDER_ROTATION'), 'Value'))

	pr.get('UPDATE')
end

%%% ¡prop!
EDITFIELD_FONTNAME (evanescent, handle) is the text value edit field for the FONTNAME property.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

editfield_fontname = uieditfield( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'EDITFIELD_FONTNAME', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FONTNAME')) ' ' el.get(prop).getPropDescription('FONTNAME')], ...
    'ValueChangedFcn', {@cb_editfield_fontname} ...
    );

value = editfield_fontname;
%%%% ¡calculate_callbacks!
function cb_editfield_fontname(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');

    el.get(prop).set('FONTNAME', get(pr.get('EDITFIELD_FONTNAME'), 'Value'))
end

%%% ¡prop!
DROPDOWN_FONTWEIGHT (evanescent, handle) is the font weight dropdown.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

dropdown_fontweight = uidropdown( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'DROPDOWN_FONTWEIGHT', ...
    'Items', el.get(prop).getPropSettings('FONTWEIGHT'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FONTWEIGHT')) ' ' el.get(prop).getPropDescription('FONTWEIGHT')], ...
    'ValueChangedFcn', {@cb_dropdown_fontweight} ...
    );

value = dropdown_fontweight;
%%%% ¡calculate_callbacks!
function cb_dropdown_fontweight(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');

    el.get(prop).set('FONTWEIGHT', get(pr.get('DROPDOWN_FONTWEIGHT'), 'Value'))
end

%%% ¡prop!
DROPDOWN_INTERPRETER (evanescent, handle) is the interpreter dropdown.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

dropdown_interpreter = uidropdown( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'DROPDOWN_INTERPRETER', ...
    'Items', el.get(prop).getPropSettings('INTERPRETER'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('INTERPRETER')) ' ' el.get(prop).getPropDescription('INTERPRETER')], ...
    'ValueChangedFcn', {@cb_dropdown_interpreter} ...
    );

value = dropdown_interpreter;
%%%% ¡calculate_callbacks!
function cb_dropdown_interpreter(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');

    el.get(prop).set('INTERPRETER', get(pr.get('DROPDOWN_INTERPRETER'), 'Value'))
end

%%% ¡prop!
DROPDOWN_HALIGN (evanescent, handle) is the horizontal alignment dropdown.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

dropdown_halign = uidropdown( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'DROPDOWN_HALIGN', ...
    'Items', el.get(prop).getPropSettings('HALIGN'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('HALIGN')) ' ' el.get(prop).getPropDescription('HALIGN')], ...
    'ValueChangedFcn', {@cb_dropdown_halign} ...
    );

value = dropdown_halign;
%%%% ¡calculate_callbacks!
function cb_dropdown_halign(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');

    el.get(prop).set('HALIGN', get(pr.get('DROPDOWN_HALIGN'), 'Value'))
end

%%% ¡prop!
DROPDOWN_VALIGN (evanescent, handle) is the vertical alignment dropdown.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

dropdown_valign = uidropdown( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'DROPDOWN_VALIGN', ...
    'Items', el.get(prop).getPropSettings('VALIGN'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('VALIGN')) ' ' el.get(prop).getPropDescription('VALIGN')], ...
    'ValueChangedFcn', {@cb_dropdown_valign} ...
    );

value = dropdown_valign;
%%%% ¡calculate_callbacks!
function cb_dropdown_valign(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');

    el.get(prop).set('VALIGN', get(pr.get('DROPDOWN_VALIGN'), 'Value'))
end

%% ¡tests!

%%% ¡excluded_props!
[SettingsTextPP.PARENT SettingsTextPP.H SettingsTextPP.LISTENER_CB SettingsTextPP.EDITFIELD_X SettingsTextPP.EDITFIELD_Y SettingsTextPP.EDITFIELD_Z SettingsTextPP.EDITFIELD_TXT SettingsTextPP.BUTTON_FONTCOLOR SettingsTextPP.EDITFIELD_FONTSIZE SettingsTextPP.SLIDER_FONTSIZE SettingsTextPP.EDITFIELD_ROTATION SettingsTextPP.SLIDER_ROTATION SettingsTextPP.EDITFIELD_FONTNAME SettingsTextPP.DROPDOWN_FONTWEIGHT SettingsTextPP.DROPDOWN_INTERPRETER SettingsTextPP.DROPDOWN_HALIGN SettingsTextPP.DROPDOWN_VALIGN]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':SettingsTextPP'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':SettingsTextPP'])
