%% ¡header!
PanelPropRVectorSmart < PanelPropString (pr, smart row-vector prop panel) plots the panel of a smart row vector.

%%% ¡description!
A Smart Row-Vector Prop Panel (PanelPropRVEctorSmart) plots the panel 
 for a row vector with an edit field. Smart means that (almost) any MatLab 
 expression leading to a correct row vector can be introduced in the edit field.
 Also, the value of the vector can be limited between some MIN and MAX.
It works for all categories, exept for __Category.RESULT__, __Category.QUERY__, or __Category.EVANESCENT__.

%%% ¡seealso!
uieditfield, GUI, PanelElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the smart row-vector property panel.
%%%% ¡default!
'PanelPropRVectorSmart'

%%% ¡prop!
NAME (constant, string) is the name of the smart row-vector property panel.
%%%% ¡default!
'Smart Row-Vector Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the smart row-vector property panel.
%%%% ¡default!
'A Smart Row-Vector Prop Panel (PanelPropRVEctorSmart) plots the panel for a row vector with an edit field. Smart means that (almost) any MatLab expression leading to a correct row vector can be introduced in the edit field. Also, the value of the vector can be limited between some MIN and MAX. It works for all categories, exept for __Category.RESULT__, __Category.QUERY__, or __Category.EVANESCENT__.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the smart row-vector property panel.
%%%% ¡settings!
'PanelPropRVectorSmart'

%%% ¡prop!
ID (data, string) is a few-letter code for the smart row-vector property panel.
%%%% ¡default!
'PanelPropRVectorSmart ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the smart row-vector property panel.
%%%% ¡default!
'PanelPropRVectorSmart label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the smart row-vector property panel.
%%%% ¡default!
'PanelPropRVectorSmart notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
Graph()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
Graph.LAYERTICKS

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the editfield.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % skips __PanelPropString.UPDATE__ % also warning
if value
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    switch el.getPropCategory(prop)
        case Category.CONSTANT
            set(pr.get('EDITFIELD'), ...
                'Value', mat2str(el.get(prop)), ...
                'Editable', 'off', ...
                'Enable', pr.get('ENABLE') ...
                )
            
        case Category.METADATA
            set(pr.get('EDITFIELD'), 'Value', mat2str(el.get(prop)))

            if el.isLocked(prop)
                set(pr.get('EDITFIELD'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('EDITFIELD'), 'Value', mat2str(el.get(prop)))

            prop_value = el.getr(prop);
            if el.isLocked(prop) || isa(prop_value, 'Callback')
                set(pr.get('EDITFIELD'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end

        case {Category.RESULT Category.QUERY Category.EVANESCENT}
            error([BRAPH2.STR ':PanelPropRVectorSmart:' BRAPH2.ERR_FUNC], ...
                'PanelPropRVectorSmart should not be used with __Category.RESULT__, __Category.QUERY__, or __Category.EVANESCENT__.')
    end
end

%%% ¡prop!
EDITFIELD (evanescent, handle) is the string value edit field with a smart row vector.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

editfield = uieditfield( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'EDITFIELD', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_editfield} ...
    );

value = editfield;
%%%% ¡calculate_callbacks!
function cb_editfield(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');

    try 
        value = eval(['[' get(pr.get('EDITFIELD'), 'Value') ']']);
        if pr.get('UNIQUE_VALUE')
            value = unique(value(:)'); % sort done by unique
        end
        value(value < pr.get('MIN')) = pr.get('MIN');
        value(value > pr.get('MAX')) = pr.get('MAX');
        
        if isempty(value)
            value = pr.get('DEFAULT');
        end
    catch
        value = el.get(prop);
    end
    
    el.set(prop, value)
end

%% ¡props!

%%% ¡prop!
MAX (parameter, scalar) is the max value acceptable as input.
%%%% ¡default!
+Inf

%%% ¡prop!
MIN (parameter, scalar) is the min value acceptable as input.
%%%% ¡default!
-Inf

%%% ¡prop!
UNIQUE_VALUE (parameter, logical) determines if sorting the data with no repetitions.
%%%% ¡default!
true

%%% ¡prop!
DEFAULT (parameter, rvector) is the default value.

%% ¡tests!

%%% ¡excluded_props!
[PanelPropRVectorSmart.PARENT PanelPropRVectorSmart.H PanelPropRVectorSmart.LISTENER_CB PanelPropRVectorSmart.EDITFIELD]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropRVectorSmart'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropRVectorSmart'])