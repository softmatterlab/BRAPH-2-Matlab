%% ¡header!
SettingsPositionPP < SettingsPP (pr, prop panel for position settings) is the panel with position settings.

%%% ¡description!
A Prop Panel for Position Settings (SettingsPositionPP) plots the panel 
 for position settings, including a checkbox for autopositioning 
 and numeric edit fields for x0, y0, height and width.
It works for all categories.

%%% ¡seealso!
SettingsPosition, uicheckbox, uieditfield

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the property panel for position settings.
%%%% ¡default!
'SettingsPositionPP'

%%% ¡prop!
NAME (constant, string) is the name of the property panel for position settings.
%%%% ¡default!
'Prop Panel for Position Settings'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the property panel for position settings.
%%%% ¡default!
'A Prop Panel for Position Settings (SettingsPositionPP) plots the panel for position settings, including a checkbox for autopositioning and numeric edit fields for x0, y0, height and width. It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the property panel for position settings.
%%%% ¡settings!
'SettingsPositionPP'

%%% ¡prop!
ID (data, string) is a few-letter code for the property panel for position settings.
%%%% ¡default!
'SettingsPositionPP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the property panel for position settings.
%%%% ¡default!
'SettingsPositionPP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the property panel for position settings.
%%%% ¡default!
'SettingsPositionPP notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
PanelFig()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
PanelFig.ST_POSITION

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the property panel for position settings.
%%%% ¡default!
s(4)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('CHECKBOX_AUTOPOS')
    
    pr.memorize('LABEL_X0')
    pr.memorize('EDITFIELD_X0')
    
    pr.memorize('LABEL_Y0')
    pr.memorize('EDITFIELD_Y0')
    
    pr.memorize('LABEL_W')
    pr.memorize('EDITFIELD_W')
    
    pr.memorize('LABEL_H')
    pr.memorize('EDITFIELD_H')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop) || el.getPropCategory(prop) == Category.CONSTANT
        set(pr.checkbox_autopos, 'Enable', pr.get('ENABLE'))
        set(pr.editfield_x0, ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.editfield_y0, ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.editfield_w, ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.editfield_h, ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )        
    end
    
    switch el.getPropCategory(prop)
        case Category.CONSTANT
            set(pr.get('CHECKBOX_AUTOPOS'), 'Value', el.get(prop).get('AUTOPOS'))
            set(pr.get('EDITFIELD_X0'), 'Value', el.get(prop).get('X0'))
            set(pr.get('EDITFIELD_Y0'), 'Value', el.get(prop).get('Y0'))
            set(pr.get('EDITFIELD_W'), 'Value', el.get(prop).get('WIDTH'))
            set(pr.get('EDITFIELD_H'), 'Value', el.get(prop).get('HEIGHT'))
            
        case Category.METADATA
            set(pr.get('CHECKBOX_AUTOPOS'), 'Value', el.get(prop).get('AUTOPOS'))
            set(pr.get('EDITFIELD_X0'), 'Value', el.get(prop).get('X0'))
            set(pr.get('EDITFIELD_Y0'), 'Value', el.get(prop).get('Y0'))
            set(pr.get('EDITFIELD_W'), 'Value', el.get(prop).get('WIDTH'))
            set(pr.get('EDITFIELD_H'), 'Value', el.get(prop).get('HEIGHT'))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('CHECKBOX_AUTOPOS'), 'Value', el.get(prop).get('AUTOPOS'))
            set(pr.get('EDITFIELD_X0'), 'Value', el.get(prop).get('X0'))
            set(pr.get('EDITFIELD_Y0'), 'Value', el.get(prop).get('Y0'))
            set(pr.get('EDITFIELD_W'), 'Value', el.get(prop).get('WIDTH'))
            set(pr.get('EDITFIELD_H'), 'Value', el.get(prop).get('HEIGHT'))
            
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('AUTOPOS'), 'Callback')
                set(pr.get('CHECKBOX_AUTOPOS'), 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('X0'), 'Callback')
                set(pr.get('EDITFIELD_X0'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('Y0'), 'Callback')
                set(pr.get('EDITFIELD_Y0'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('WIDTH'), 'Callback')
                set(pr.get('EDITFIELD_W'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('HEIGHT'), 'Callback')
                set(pr.get('EDITFIELD_H'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end

        case {Category.RESULT Category.QUERY Category.EVANESCENT}
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.get('CHECKBOX_AUTOPOS'), ...
                    el.getPropDefault(prop).getPropDefault('AUTOPOS'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_X0'), ...
                    'Value', el.getPropDefault(prop).getPropDefault('X0'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_Y0'), ...
                    'Value', el.getPropDefault(prop).getPropDefault('Y0'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_W'), ...
                    'Value', el.getPropDefault(prop).getPropDefault('WIDTH'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_H'), ...
                    'Value', el.getPropDefault(prop).getPropDefault('HEIGHT'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                set(pr.get('CHECKBOX_AUTOPOS'), ...
                    el.get(prop).get('AUTOPOS'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_X0'), ...
                    'Value', el.get(prop).get('X0'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_Y0'), ...
                    'Value', el.get(prop).get('Y0'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_W'), ...
                    'Value', el.get(prop).get('WIDTH'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_H'), ...
                    'Value', el.get(prop).get('HEIGHT'), ...
                    'Editable', 'off', ...
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
    
    set(pr.get('CHECKBOX_AUTOPOS'), 'Position', [s(.3) s(.3) .15*w_p s(1.7)])

    set(pr.get('LABEL_X0'), 'Position', [.20*w_p s(.3) .04*w_p s(1.7)])
    set(pr.get('EDITFIELD_X0'), 'Position', [.25*w_p s(.3) .12*w_p s(1.7)])
    
    set(pr.get('LABEL_Y0'), 'Position', [.40*w_p s(.3) .04*w_p s(1.7)])
    set(pr.get('EDITFIELD_Y0'), 'Position', [.45*w_p s(.3) .12*w_p s(1.7)])

    set(pr.get('LABEL_W'), 'Position', [.60*w_p s(.3) .04*w_p s(1.7)])
    set(pr.get('EDITFIELD_W'), 'Position', [.65*w_p s(.3) .12*w_p s(1.7)])

    set(pr.get('LABEL_H'), 'Position', [.80*w_p s(.3) .04*w_p s(1.7)])
    set(pr.get('EDITFIELD_H'), 'Position', [.85*w_p s(.3) .12*w_p s(1.7)])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('CHECKBOX_AUTOPOS', Element.getNoValue())
    
    pr.set('LABEL_X0', Element.getNoValue())
    pr.set('EDITFIELD_X0', Element.getNoValue())
    
    pr.set('LABEL_Y0', Element.getNoValue())
    pr.set('EDITFIELD_Y0', Element.getNoValue())
    
    pr.set('LABEL_W', Element.getNoValue())
    pr.set('EDITFIELD_W', Element.getNoValue())
    
    pr.set('LABEL_H', Element.getNoValue())
    pr.set('EDITFIELD_H', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.
%%%% ¡default!
true

%%% ¡prop!
CHECKBOX_AUTOPOS (evanescent, handle) is the autopositioning checkbox.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
checkbox_autopos = uicheckbox( ...
	'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'CHECKBOX_AUTOPOS', ...
    'Text', 'auto', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('AUTOPOS')) ' ' el.get(prop).getPropDescription('AUTOPOS')], ...
    'ValueChangedFcn', {@cb_position} ...
    );
value = checkbox_autopos;
%%%% ¡calculate_callbacks!
function cb_position(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set( ...
        'AUTOPOS', get(pr.get('CHECKBOX_AUTOPOS'), 'Value'), ...
        'X0', get(pr.get('EDITFIELD_X0'), 'Value'), ...
        'Y0', get(pr.get('EDITFIELD_Y0'), 'Value'), ...
        'WIDTH', get(pr.get('EDITFIELD_W'), 'Value'), ...
        'HEIGHT', get(pr.get('EDITFIELD_H'), 'Value') ...
        )
end

%%% ¡prop!
LABEL_X0 (evanescent, handle) is the label of the x0 edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
label_x0 =  uilabel( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'LABEL_X0', ...
    'Text', 'x<sub>0</sub>', ...
    'Interpreter', 'html', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'HorizontalAlignment', 'right', ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('X0')) ' ' el.get(prop).getPropDescription('X0')], ...
    'BackgroundColor', pr.get('BKGCOLOR') ...
    );
value = label_x0;

%%% ¡prop!
EDITFIELD_X0 (evanescent, handle) is the x0 edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
editfield_x0 = uieditfield('numeric', ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'EDITFIELD_X0', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('X0')) ' ' el.get(prop).getPropDescription('X0')], ...
    'ValueChangedFcn', {@cb_position} ... % callback in CHECKBOX_AUTOPOS
    );
value = editfield_x0;

%%% ¡prop!
LABEL_Y0 (evanescent, handle) is the label of the y0 edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
label_y0 =  uilabel( ...
	'Parent', pr.memorize('H'), ... % H = p for Panel
	'Tag', 'LABEL_Y0', ...
	'Text', 'y<sub>0</sub>', ...
	'Interpreter', 'html', ...
	'FontSize', BRAPH2.FONTSIZE, ...
	'HorizontalAlignment', 'right', ...
	'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('Y0')) ' ' el.get(prop).getPropDescription('Y0')], ...
	'BackgroundColor', pr.get('BKGCOLOR') ...
	);
value = label_y0;

%%% ¡prop!
EDITFIELD_Y0 (evanescent, handle) is the y0 edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
editfield_y0 = uieditfield('numeric', ...
	'Parent', pr.memorize('H'), ... % H = p for Panel
	'Tag', 'EDITFIELD_Y0', ...
	'FontSize', BRAPH2.FONTSIZE, ...
	'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('Y0')) ' ' el.get(prop).getPropDescription('Y0')], ...
	'ValueChangedFcn', {@cb_position} ... % callback in CHECKBOX_AUTOPOS
	);
value = editfield_y0;

%%% ¡prop!
LABEL_W (evanescent, handle) is the label of the witdth edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
label_w =  uilabel( ...
	'Parent', pr.memorize('H'), ... % H = p for Panel
	'Tag', 'LABEL_W', ...
	'Text', 'w', ...
	'Interpreter', 'html', ...
	'FontSize', BRAPH2.FONTSIZE, ...
	'HorizontalAlignment', 'right', ...
	'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('WIDTH')) ' ' el.get(prop).getPropDescription('WIDTH')], ...
	'BackgroundColor', pr.get('BKGCOLOR') ...
	);
value = label_w;

%%% ¡prop!
EDITFIELD_W (evanescent, handle) is the width edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
editfield_w = uieditfield('numeric', ...
	'Parent', pr.memorize('H'), ... % H = p for Panel
	'Tag', 'EDITFIELD_W', ...
	'Limits', [0 +Inf], ...
	'FontSize', BRAPH2.FONTSIZE, ...
	'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('WIDTH')) ' ' el.get(prop).getPropDescription('WIDTH')], ...
	'ValueChangedFcn', {@cb_position} ... % callback in CHECKBOX_AUTOPOS
	);
value = editfield_w;

%%% ¡prop!
LABEL_H (evanescent, handle) is the label of the height edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
label_h =  uilabel( ...
	'Parent', pr.memorize('H'), ... % H = p for Panel
	'Tag', 'LABEL_H', ...
	'Text', 'h', ...
	'Interpreter', 'html', ...
	'FontSize', BRAPH2.FONTSIZE, ...
	'HorizontalAlignment', 'right', ...
	'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('HEIGHT')) ' ' el.get(prop).getPropDescription('HEIGHT')], ...
	'BackgroundColor', pr.get('BKGCOLOR') ...
	);
value = label_h;

%%% ¡prop!
EDITFIELD_H (evanescent, handle) is the height edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
editfield_h = uieditfield('numeric', ...
	'Parent', pr.memorize('H'), ... % H = p for Panel
	'Tag', 'EDITFIELD_H', ...
	'Limits', [0 +Inf], ...
	'FontSize', BRAPH2.FONTSIZE, ...
	'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('HEIGHT')) ' ' el.get(prop).getPropDescription('HEIGHT')], ...
	'ValueChangedFcn', {@cb_position} ... % callback in CHECKBOX_AUTOPOS
    );
value = editfield_h;

%% ¡tests!

%%% ¡excluded_props!
[SettingsPositionPP.PARENT SettingsPositionPP.H SettingsPositionPP.LISTENER_CB SettingsPositionPP.CHECKBOX_AUTOPOS SettingsPositionPP.LABEL_X0 SettingsPositionPP.EDITFIELD_X0 SettingsPositionPP.LABEL_Y0 SettingsPositionPP.EDITFIELD_Y0 SettingsPositionPP.LABEL_W SettingsPositionPP.EDITFIELD_W SettingsPositionPP.LABEL_H SettingsPositionPP.EDITFIELD_H]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':SettingsPositionPP'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':SettingsPositionPP'])
