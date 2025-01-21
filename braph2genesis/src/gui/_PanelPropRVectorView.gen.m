%% ¡header!
PanelPropRVectorView < PanelProp (pr, view prop panel) plots the panel of a view with azimuth and elevation angles.

%%% ¡description!
A View Prop Panel (PanelPropRVectorView) plots the panel for the azimuth and elevation angles of the camera''s line of sight.
 Azimuth — The angle of rotation around the z-axis, as measured from the negative y-axis. 
  Increasing this angle corresponds to counterclockwise rotation about the z-axis 
  when viewing the xy plane from above.
 Elevation — The minimum angle between the line of sight and the xy plane. Increasing the elevation 
  from -90 to 90 degrees corresponds to a rotation from the negative z-axis to the positive z-axis.
It works for all categories.

%%% ¡seealso!
GUI, PanelElement, view, uieditfield, uislider

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel of a view with azimuth and elevation angles.
%%%% ¡default!
'PanelPropRVectorView'

%%% ¡prop!
NAME (constant, string) is the name of the panel of a view with azimuth and elevation angles.
%%%% ¡default!
'View Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel of a view with azimuth and elevation angles.
%%%% ¡default!
'A View Prop Panel (PanelPropRVectorView) plots the panel for the azimuth and elevation angles of the camera''s line of sight. Azimuth — The angle of rotation around the z-axis, as measured from the negative y-axis. Increasing this angle corresponds to counterclockwise rotation about the z-axis when viewing the xy plane from above. Elevation — The minimum angle between the line of sight and the xy plane. Increasing the elevation from -90 to 90 degrees corresponds to a rotation from the negative z-axis to the positive z-axis.It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel of a view with azimuth and elevation angles.
%%%% ¡settings!
'PanelPropRVectorView'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel of a view with azimuth and elevation angles.
%%%% ¡default!
'PanelPropRVectorView ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel of a view with azimuth and elevation angles.
%%%% ¡default!
'PanelPropRVectorView label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel of a view with azimuth and elevation angles.
%%%% ¡default!
'PanelPropRVectorView notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
BrainSurfacePF()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
BrainSurfacePF.VIEW

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the settings position panel.
%%%% ¡default!
s(6.4)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('LABEL_AZ')
    pr.memorize('EDITFIELD_AZ')
    pr.memorize('SLIDER_AZ')

    pr.memorize('LABEL_EL')
    pr.memorize('EDITFIELD_EL')
    pr.memorize('SLIDER_EL')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.get('EDITFIELD_AZ'), ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.get('SLIDER_AZ'), 'Enable', pr.get('ENABLE'))
        set(pr.get('EDITFIELD_EL'), ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.get('SLIDER_EL'), 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            v = el.get(prop);
            set(pr.get('EDITFIELD_AZ'), 'Value', v(1))
            set(pr.get('SLIDER_AZ'), 'Value', v(1))
            set(pr.get('EDITFIELD_EL'), 'Value', v(2))
            set(pr.get('SLIDER_EL'), 'Value', v(2))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            v = el.get(prop);
            set(pr.get('EDITFIELD_AZ'), 'Value', v(1))
            set(pr.get('SLIDER_AZ'), 'Value', v(1))
            set(pr.get('EDITFIELD_EL'), 'Value', v(2))
            set(pr.get('SLIDER_EL'), 'Value', v(2))

            prop_value = el.getr(prop);
            if isa(prop_value, 'Callback')
                set(pr.get('EDITFIELD_AZ'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_AZ'), 'Enable', pr.get('ENABLE'))
                set(pr.get('EDITFIELD_EL'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_EL'), 'Enable', pr.get('ENABLE'))
            end

        case Category.RESULT
            prop_value = el.getr(prop);

            if isa(prop_value, 'NoValue')
                v = el.getPropDefault(prop);
                set(pr.get('EDITFIELD_AZ'), ...
                    'Value', v(1), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_AZ'), ...
                    'Value', v(1), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_EL'), ...
                    'Value', v(2), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_EL'), ...
                    'Value', v(2), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                v = el.get(prop);
                set(pr.get('EDITFIELD_AZ'), ...
                    'Value', v(1), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_AZ'), ...
                    'Value', v(1), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('EDITFIELD_EL'), ...
                    'Value', v(2), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.get('SLIDER_EL'), ...
                    'Value', v(2), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
    end
end

%%% ¡prop!
REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    set(pr.get('LABEL_AZ'),     'Position', [s(.3)                 s(3.2)  .20*w_p   s(1.7)])
    set(pr.get('EDITFIELD_AZ'), 'Position', [s(.6)+.20*w_p         s(3.2)  .15*w_p   s(1.7)])
    set(pr.get('SLIDER_AZ'),    'Position', [s(.6)+.35*w_p+s(1.7)  s(4.75) .50*w_p   3]) % the height of a slider cannot be changed
    set(pr.get('LABEL_EL'),     'Position', [s(.3)                 s(.7)   .20*w_p   s(1.7)])
    set(pr.get('EDITFIELD_EL'), 'Position', [s(.6)+.20*w_p         s(.7)   .15*w_p   s(1.7)])
    set(pr.get('SLIDER_EL'),    'Position', [s(.6)+.35*w_p+s(1.7)  s(2.25) .50*w_p   3]) % the height of a slider cannot be changed
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('LABEL_AZ', Element.getNoValue())
    pr.set('EDITFIELD_AZ', Element.getNoValue())
    pr.set('SLIDER_AZ', Element.getNoValue())

    pr.set('LABEL_EL', Element.getNoValue())
    pr.set('EDITFIELD_EL', Element.getNoValue())
    pr.set('SLIDER_EL', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.
%%%% ¡default!
true

%%% ¡prop!
LABEL_AZ (evanescent, handle) is the azimuthal angle label.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
label_az =  uilabel( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'LABEL_AZ', ...
    'Text', 'azimuth', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'HorizontalAlignment', 'right', ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'BackgroundColor', pr.get('BKGCOLOR') ...
    );
value = label_az;
    
%%% ¡prop!
EDITFIELD_AZ (evanescent, handle) is the azimuthal angle edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
editfield_az = uieditfield('numeric', ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'EDITFIELD_AZ', ...
    'Limits', [-180 180], ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_editfield_az} ...
    );
value = editfield_az;
%%%% ¡calculate_callbacks!
function cb_editfield_az(~, ~)

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    azimuth = get(pr.get('EDITFIELD_AZ'), 'Value');
    
    old_v = el.get(prop);
    elevation = old_v(2);
    
    el.set(prop, [azimuth, elevation])
end

%%% ¡prop!
SLIDER_AZ (evanescent, handle) is the azimuthal angle slider.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
slider_az = uislider( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'SLIDER_AZ', ...
    'Limits', [-180 180], ...
    'FontSize', BRAPH2.FONTSIZE / 2, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_slider_az} ...
    );
value = slider_az;
%%%% ¡calculate_callbacks!
function cb_slider_az(~, ~)

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    azimuth = get(pr.get('SLIDER_AZ'), 'Value');
    
    old_v = el.get(prop);
    elevation = old_v(2);
    
    el.set(prop, [azimuth, elevation])
end

%%% ¡prop!
LABEL_EL (evanescent, handle) is the elevation angle label.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
label_el =  uilabel( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'LABEL_EL', ...
    'Text', 'elevation', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'HorizontalAlignment', 'right', ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'BackgroundColor', pr.get('BKGCOLOR') ...
    );
value = label_el;
    
%%% ¡prop!
EDITFIELD_EL (evanescent, handle) is the elevation angle edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
editfield_el = uieditfield('numeric', ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'EDITFIELD_EL', ...
    'Limits', [-90 90], ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_editfield_el} ...
    );
value = editfield_el;
%%%% ¡calculate_callbacks!
function cb_editfield_el(~, ~) % (src, event)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    old_v = el.get(prop);
    azimuth = old_v(1);

    elevation = get(pr.get('EDITFIELD_EL'), 'Value');
    
    el.set(prop, [azimuth, elevation])
end

%%% ¡prop!
SLIDER_EL (evanescent, handle) is the elevation angle slider.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
slider_el = uislider( ...
    'Parent', pr.memorize('H'), ...
    'Tag', 'SLIDER_EL', ...
    'Limits', [-90 90], ...
    'FontSize', BRAPH2.FONTSIZE / 2, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_slider_el} ...
    );
value = slider_el;
%%%% ¡calculate_callbacks!
function cb_slider_el(~, ~)

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    old_v = el.get(prop);
    azimuth = old_v(1);
    
    elevation = get(pr.get('SLIDER_EL'), 'Value');
    
    el.set(prop, [azimuth, elevation])
end

%% ¡tests!

%%% ¡excluded_props!
[PanelPropRVectorView.PARENT PanelPropRVectorView.H PanelPropRVectorView.LISTENER_CB PanelPropRVectorView.LABEL_AZ PanelPropRVectorView.EDITFIELD_AZ PanelPropRVectorView.SLIDER_AZ PanelPropRVectorView.LABEL_EL PanelPropRVectorView.EDITFIELD_EL PanelPropRVectorView.SLIDER_EL]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropRVectorView'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropRVectorView'])
