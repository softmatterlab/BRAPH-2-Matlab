%% ¡header!
SettingsAmbientPP < SettingsPP (pr, prop panel for ambient settings) is the panel with ambient settings.

%%% ¡description!
A Prop Panel for Ambient Settings (SettingsAmbientPP) plots the panel 
 for ambient settings, including drop-down lists for lighting, material, 
 camlight, shading, and colormap.
It works for all categories.

%%% ¡seealso!
SettingsAmbient, uidropdown

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the concrete element.
%%%% ¡default!
'SettingsAmbientPP'

%%% ¡prop!
NAME (constant, string) is the name of the prop panel for ambient settings.
%%%% ¡default!
'Prop Panel for Ambient Settings'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the prop panel for ambient settings.
%%%% ¡default!
'A Prop Panel for Ambient Settings (SettingsAmbientPP) plots the panel for ambient settings, including drop-down lists for lighting, material, camlight, shading, and colormap. It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the prop panel for ambient settings.
%%%% ¡settings!
'SettingsAmbientPP'

%%% ¡prop!
ID (data, string) is a few-letter code for the prop panel for ambient settings.
%%%% ¡default!
'SettingsAmbientPP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the prop panel for ambient settings.
%%%% ¡default!
'SettingsAmbientPP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the prop panel for ambient settings.
%%%% ¡default!
'SettingsAmbientPP notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
BrainSurfacePF()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
BrainSurfacePF.ST_AMBIENT

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the settings position panel.
%%%% ¡default!
s(12.5)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('LABEL_LIGHTING')
    pr.memorize('DROPDOWN_LIGHTING')

    pr.memorize('LABEL_MATERIAL')
    pr.memorize('DROPDOWN_MATERIAL')

    pr.memorize('LABEL_CAMLIGHT')
    pr.memorize('DROPDOWN_CAMLIGHT')

    pr.memorize('LABEL_SHADING')
    pr.memorize('DROPDOWN_SHADING')

    pr.memorize('LABEL_COLORMAP')
    pr.memorize('DROPDOWN_COLORMAP')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value

	el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.get('DROPDOWN_LIGHTING'), 'Enable', pr.get('ENABLE'))
        set(pr.get('DROPDOWN_MATERIAL'), 'Enable', pr.get('ENABLE'))
        set(pr.get('DROPDOWN_CAMLIGHT'), 'Enable', pr.get('ENABLE'))
        set(pr.get('DROPDOWN_SHADING'), 'Enable', pr.get('ENABLE'))
        set(pr.get('DROPDOWN_COLORMAP'), 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.get('DROPDOWN_LIGHTING'), 'Value', el.get(prop).get('LIGHTING'))
            set(pr.get('DROPDOWN_MATERIAL'), 'Value', el.get(prop).get('MATERIAL'))
            set(pr.get('DROPDOWN_CAMLIGHT'), 'Value', el.get(prop).get('CAMLIGHT'))
            set(pr.get('DROPDOWN_SHADING'), 'Value', el.get(prop).get('SHADING'))
            set(pr.get('DROPDOWN_COLORMAP'), 'Value', el.get(prop).get('COLORMAP'))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('DROPDOWN_LIGHTING'), 'Value', el.get(prop).get('LIGHTING'))
            set(pr.get('DROPDOWN_MATERIAL'), 'Value', el.get(prop).get('MATERIAL'))
            set(pr.get('DROPDOWN_CAMLIGHT'), 'Value', el.get(prop).get('CAMLIGHT'))
            set(pr.get('DROPDOWN_SHADING'), 'Value', el.get(prop).get('SHADING'))
            set(pr.get('DROPDOWN_COLORMAP'), 'Value', el.get(prop).get('COLORMAP'))

            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('LIGHTING'), 'Callback')
                set(pr.get('DROPDOWN_LIGHTING'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('MATERIAL'), 'Callback')
                set(pr.get('DROPDOWN_MATERIAL'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('CAMLIGHT'), 'Callback')
                set(pr.get('DROPDOWN_CAMLIGHT'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('SHADING'), 'Callback')
                set(pr.get('DROPDOWN_SHADING'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('COLORMAP'), 'Callback')
                set(pr.get('DROPDOWN_COLORMAP'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            
        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.get('DROPDOWN_LIGHTING'), ...
                    'Value', el.get(prop).getPropDefault('LIGHTING'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('DROPDOWN_MATERIAL'), ...
                    'Value', el.get(prop).getPropDefault('MATERIAL'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('DROPDOWN_CAMLIGHT'), ...
                    'Value', el.get(prop).getPropDefault('CAMLIGHT'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('DROPDOWN_SHADING'), ...
                    'Value', el.get(prop).getPropDefault('SHADING'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('DROPDOWN_COLORMAP'), ...
                    'Value', el.get(prop).getPropDefault('COLORMAP'), ...
                    'Enable', pr.get('ENABLE') ...
                    )                
            else
                set(pr.get('DROPDOWN_LIGHTING'), ...
                    'Value', el.get(prop).get('LIGHTING'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('DROPDOWN_MATERIAL'), ...
                    'Value', el.get(prop).get('MATERIAL'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('DROPDOWN_CAMLIGHT'), ...
                    'Value', el.get(prop).get('CAMLIGHT'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('DROPDOWN_SHADING'), ...
                    'Value', el.get(prop).get('SHADING'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('DROPDOWN_COLORMAP'), ...
                    'Value', el.get(prop).get('COLORMAP'), ...
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
    
    set(pr.get('LABEL_LIGHTING'), 'Position', [s(.3) s(8.3) s(8) s(1.7)])
    set(pr.get('DROPDOWN_LIGHTING'), 'Position', [s(8.6) s(8.3) w_p-s(10) s(1.7)])

    set(pr.get('LABEL_MATERIAL'), 'Position', [s(.3) s(6.3) s(8) s(1.7)])
    set(pr.get('DROPDOWN_MATERIAL'), 'Position', [s(8.6) s(6.3) w_p-s(10) s(1.7)])

    set(pr.get('LABEL_CAMLIGHT'), 'Position', [s(.3) s(4.3) s(8) s(1.7)])
    set(pr.get('DROPDOWN_CAMLIGHT'), 'Position', [s(8.6) s(4.3) w_p-s(10) s(1.7)])

    set(pr.get('LABEL_SHADING'), 'Position', [s(.3) s(2.3) s(8) s(1.7)])
    set(pr.get('DROPDOWN_SHADING'), 'Position', [s(8.6) s(2.3) w_p-s(10) s(1.7)])

    set(pr.get('LABEL_COLORMAP'), 'Position', [s(.3) s(.3) s(8) s(1.7)])
    set(pr.get('DROPDOWN_COLORMAP'), 'Position', [s(8.6) s(.3) w_p-s(10) s(1.7)])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('LABEL_LIGHTING', Element.getNoValue())
    pr.set('DROPDOWN_LIGHTING', Element.getNoValue())

    pr.set('LABEL_MATERIAL', Element.getNoValue())
    pr.set('DROPDOWN_MATERIAL', Element.getNoValue())

    pr.set('LABEL_CAMLIGHT', Element.getNoValue())
    pr.set('DROPDOWN_CAMLIGHT', Element.getNoValue())

    pr.set('LABEL_SHADING', Element.getNoValue())
    pr.set('DROPDOWN_SHADING', Element.getNoValue())

    pr.set('LABEL_COLORMAP', Element.getNoValue())
    pr.set('DROPDOWN_COLORMAP', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.
%%%% ¡default!
true

%%% ¡prop!
LABEL_LIGHTING (evanescent, handle) is the label of the lighting dropdown menu.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
label_lighting =  uilabel( ...
    'Parent', pr.memorize('H'), ...
	'Tag', 'LABEL_LIGHTING', ...
	'Text', 'lighting', ...
	'Interpreter', 'html', ...
	'FontSize', BRAPH2.FONTSIZE, ...
	'HorizontalAlignment', 'right', ...
	'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LIGHTING')) ' ' el.get(prop).getPropDescription('LIGHTING')], ...
	'BackgroundColor', pr.get('BKGCOLOR') ...
	);
value = label_lighting;

%%% ¡prop!
DROPDOWN_LIGHTING (evanescent, handle) is the lighting dropdown menu.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
dropdown_lighting = uidropdown( ...
    'Parent', pr.memorize('H'), ...
	'Tag', 'DROPDOWN_LIGHTING', ...
	'Items', el.get(prop).getPropSettings('LIGHTING'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LIGHTING')) ' ' el.get(prop).getPropDescription('LIGHTING')], ...
    'ValueChangedFcn', {@cb_ambient} ...
    );
value = dropdown_lighting;
%%%% ¡calculate_callbacks!
function cb_ambient(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');
    el.get(prop).set( ...
        'LIGHTING', get(pr.get('DROPDOWN_LIGHTING'), 'Value'), ...
        'MATERIAL', get(pr.get('DROPDOWN_MATERIAL'), 'Value'), ...
        'CAMLIGHT', get(pr.get('DROPDOWN_CAMLIGHT'), 'Value'), ...
        'SHADING', get(pr.get('DROPDOWN_SHADING'), 'Value'), ...
        'COLORMAP', get(pr.get('DROPDOWN_COLORMAP'), 'Value') ...
        )
end

%%% ¡prop!
LABEL_MATERIAL (evanescent, handle) is the label of the of the material dropdown menu.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
label_material =  uilabel( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'LABEL_MATERIAL', ...
    'Text', 'material', ...
    'Interpreter', 'html', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'HorizontalAlignment', 'right', ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('MATERIAL')) ' ' el.get(prop).getPropDescription('MATERIAL')], ...
    'BackgroundColor', pr.get('BKGCOLOR') ...
    );
value = label_material;

%%% ¡prop!
DROPDOWN_MATERIAL (evanescent, handle) is the material dropdown menu.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
dropdown_material = uidropdown( ...
    'Parent', pr.memorize('H'), ...
        'Tag', 'DROPDOWN_MATERIAL', ...
        'Items', el.get(prop).getPropSettings('MATERIAL'), ...
        'FontSize', BRAPH2.FONTSIZE, ...
        'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('MATERIAL')) ' ' el.get(prop).getPropDescription('MATERIAL')], ...
        'ValueChangedFcn', {@cb_ambient} ... % callback in DROPBOX_LIGHTING
        );
value = dropdown_material;

%%% ¡prop!
LABEL_CAMLIGHT (evanescent, handle) is the label of the camlight dropdown menu.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
label_camlight =  uilabel( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'LABEL_CAMLIGHT', ...
    'Text', 'camera light', ...
    'Interpreter', 'html', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'HorizontalAlignment', 'right', ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('CAMLIGHT')) ' ' el.get(prop).getPropDescription('CAMLIGHT')], ...
    'BackgroundColor', pr.get('BKGCOLOR') ...
    );
value = label_camlight;

%%% ¡prop!
DROPDOWN_CAMLIGHT (evanescent, handle) is the camlight dropdown menu.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
dropdown_camlight = uidropdown( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'DROPDOWN_CAMLIGHT', ...
    'Items', el.get(prop).getPropSettings('CAMLIGHT'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('CAMLIGHT')) ' ' el.get(prop).getPropDescription('CAMLIGHT')], ...
    'ValueChangedFcn', {@cb_ambient} ... % callback in DROPBOX_LIGHTING
    );
value = dropdown_camlight;

%%% ¡prop!
LABEL_SHADING (evanescent, handle) is the label of the shading dropdown menu.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
label_shading =  uilabel( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'LABEL_SHADING', ...
    'Text', 'shading', ...
    'Interpreter', 'html', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'HorizontalAlignment', 'right', ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('SHADING')) ' ' el.get(prop).getPropDescription('SHADING')], ...
    'BackgroundColor', pr.get('BKGCOLOR') ...
    );
value = label_shading;

%%% ¡prop!
DROPDOWN_SHADING (evanescent, handle) is the shading dropdown menu.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
dropdown_shading = uidropdown( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'DROPDOWN_SHADING', ...
    'Items', el.get(prop).getPropSettings('SHADING'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('SHADING')) ' ' el.get(prop).getPropDescription('SHADING')], ...
    'ValueChangedFcn', {@cb_ambient} ... % callback in DROPBOX_LIGHTING
    );
value = dropdown_shading;

%%% ¡prop!
LABEL_COLORMAP (evanescent, handle) is the label of the colormap dropdown menu.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
label_colormap =  uilabel( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'LABEL_COLORMAP', ...
    'Text', 'colormap', ...
    'Interpreter', 'html', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'HorizontalAlignment', 'right', ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('COLORMAP')) ' ' el.get(prop).getPropDescription('COLORMAP')], ...
    'BackgroundColor', pr.get('BKGCOLOR') ...
    );
value = label_colormap;

%%% ¡prop!
DROPDOWN_COLORMAP (evanescent, handle) is the colormap dropdown menu.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
dropdown_colormap = uidropdown( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'DROPDOWN_COLORMAP', ...
    'Items', el.get(prop).getPropSettings('COLORMAP'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('COLORMAP')) ' ' el.get(prop).getPropDescription('COLORMAP')], ...
    'ValueChangedFcn', {@cb_ambient} ... % callback in DROPBOX_LIGHTING
    );
value = dropdown_colormap;

%% ¡tests!

%%% ¡excluded_props!
[SettingsAmbientPP.PARENT SettingsAmbientPP.H SettingsAmbientPP.LISTENER_CB SettingsAmbientPP.LABEL_LIGHTING SettingsAmbientPP.DROPDOWN_LIGHTING SettingsAmbientPP.LABEL_MATERIAL SettingsAmbientPP.DROPDOWN_MATERIAL SettingsAmbientPP.LABEL_CAMLIGHT SettingsAmbientPP.DROPDOWN_CAMLIGHT SettingsAmbientPP.LABEL_SHADING SettingsAmbientPP.DROPDOWN_SHADING SettingsAmbientPP.LABEL_COLORMAP SettingsAmbientPP.DROPDOWN_COLORMAP]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':SettingsAmbientPP'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':SettingsAmbientPP'])
