%% ¡header!
SubjectPP_VOIDict < PanelProp (pr, VOI prop panel) plots the panel for a VOI dictionary.

%%% ¡description!
A VOI Prop Panel (SubjectPP_VOIDict) plots a VOI (variables of interest) dictionary using 
 numeric editfields and drop-down lists.
It is intended to be used with the property VOI_DICT of Subject.

%%% ¡seealso!
Subject, uieditfield, uidropdown

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the VOI prop panel.
%%%% ¡default!
'SubjectPP_VOIDict'

%%% ¡prop!
NAME (constant, string) is the name of the VOI prop panel.
%%%% ¡default!
'VOI Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the VOI prop panel.
%%%% ¡default!
'A VOI Prop Panel (SubjectPP_VOIDict) plots a VOI (variables of interest) dictionary using numeric editfields and drop-down lists. It is intended to be used with the property VOI_DICT of Subject.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the VOI prop panel.
%%%% ¡settings!
'SubjectPP_VOIDict'

%%% ¡prop!
ID (data, string) is a few-letter code for the VOI prop panel.
%%%% ¡default!
'SubjectPP_VOIDict ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the VOI prop panel.
%%%% ¡default!
'SubjectPP_VOIDict label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the VOI prop panel.
%%%% ¡default!
'SubjectPP_VOIDict notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡settings!
'Subject'

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
Subject.VOI_DICT

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('HANDLES_VOI')
    pr.memorize('LABELS_VOI')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the table.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
    sub = pr.get('EL');

    height = pr.get('HEIGHT_MIN');

    voi_dict = sub.get('VOI_DICT');
	labels_voi = pr.get('LABELS_VOI');
    handles_voi = pr.get('HANDLES_VOI');
    for i = 1:1:voi_dict.get('LENGTH')
        voi = voi_dict.get('IT', i);
        
        label = labels_voi{i};
        set(label, 'Text', voi.get('ID'))
        
        if isa(voi, 'VOICategoric')
            height = height + pr.get('HEIGHT_VOI_DROPDOWN');

            dropdown = handles_voi{i};
            
            voi_categories = voi.get('CATEGORIES');
            set(dropdown, 'Value', voi_categories{voi.get('V')})

            prop_value = voi.getr('V');
            if voi.isLocked('V') || isa(prop_value, 'Callback')
                set(dropdown, 'Enable', 'off')
            end
        else % isa(voi, 'VOINumeric')
            height = height + pr.get('HEIGHT_VOI_EDITFIELD');
            
            editfield = handles_voi{i};
            
            set(editfield, 'Value', voi.get('V'))

            prop_value = voi.getr('V');
            if voi.isLocked('V') || isa(prop_value, 'Callback')
                set(editfield, ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
        end
    end
    
    pr.set('HEIGHT', height)
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
	w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    sub = pr.get('EL');

    h = 0;
    
    voi_dict = sub.get('VOI_DICT');
    labels_voi = pr.get('LABELS_VOI');
    handles_voi = pr.get('HANDLES_VOI');
    for i = voi_dict.get('LENGTH'):-1:1
        voi = voi_dict.get('IT', i);
        
        label = labels_voi{i};
        set(label, 'Position', [s(.3) h+s(.3) .30*w_p-s(.6) s(1.75)])
        
        if isa(voi, 'VOICategoric')
            dropdown = handles_voi{i};
            
            set(dropdown, 'Position', [.30*w_p h+s(.3) .65*w_p s(1.75)])

            h = h + pr.get('HEIGHT_VOI_DROPDOWN');
        else % isa(voi, 'VOINumeric')
            editfield = handles_voi{i};
            
            set(editfield, 'Position', [.30*w_p h+s(.3) .45*w_p s(1.75)])
            
            h = h + pr.get('HEIGHT_VOI_EDITFIELD');
        end
    end
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('HANDLES_VOI', Element.getNoValue())
    pr.set('LABELS_VOI', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
HEIGHT_MIN (gui, scalar) is the default (minumum) height.
%%%% ¡default!
s(2)
 
%%% ¡prop!
HEIGHT_VOI_EDITFIELD (gui, scalar) is the height of each VOI editfield.
%%%% ¡default!
s(2)

%%% ¡prop!
HEIGHT_VOI_DROPDOWN (gui, scalar) is the height of each VOI drop-down list.
%%%% ¡default!
s(2)

%%% ¡prop!
ENABLE (gui, logical) switches the editfields between active and inactive appearance when not editable.
%%%% ¡default!
true

%%% ¡prop!
HANDLES_VOI (evanescent, handlelist) is the list of VOI numeric editfields and drop-down lists.
%%%% ¡calculate!
sub = pr.get('EL');
prop = pr.get('PROP');

voi_dict = sub.get('VOI_DICT');
handles_voi = cell(1, voi_dict.get('LENGTH'));
for i = 1:1:voi_dict.get('LENGTH')
    voi = voi_dict.get('IT', i);
    
    if isa(voi, 'VOICategoric')
        dropdown = uidropdown( ...
            'Parent', pr.memorize('H'), ... % H = p for Panel
            'Tag', ['DROPDOWN ' int2str(i)], ... 
            'Items', voi.get('CATEGORIES'), ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(sub.getPropProp(prop)) ' ' sub.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_voi_dropdown}, ...
            'UserData', i ...
            );

        handles_voi{i} = dropdown;
    else % isa(voi, 'VOINumeric')
        editfield = uieditfield('numeric', ...
            'Parent', pr.memorize('H'), ... % H = p for Panel
            'Tag', ['EDITFIELD ' int2str(i)], ...
            'FontSize', BRAPH2.FONTSIZE, ... 
            'Tooltip', [num2str(sub.getPropProp(prop)) ' ' sub.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_voi_editfield}, ...
            'UserData', i ...
            );

        handles_voi{i} = editfield;
    end
end

value = handles_voi;
%%%% ¡calculate_callbacks!
function cb_voi_editfield(src, ~)
    i = get(src, 'UserData');

    handles_voi = pr.get('HANDLES_VOI');
    editfield = handles_voi{i};
    
    voi_dict = pr.get('EL').get(pr.get('PROP'));
    voi = voi_dict.get('IT', i);
    
    voi.set('V', get(editfield, 'Value'))
end
function cb_voi_dropdown(src, ~)
    i = get(src, 'UserData');

    handles_voi = pr.get('HANDLES_VOI');
    dropdown = handles_voi{i};
    
    voi_dict = pr.get('EL').get(pr.get('PROP'));
    voi = voi_dict.get('IT', i);
    
    voi.set('V', find(strcmp(get(dropdown, 'Value'), voi.get('CATEGORIES'))))
end

%%% ¡prop!
LABELS_VOI (evanescent, handlelist) is the list of VOI labels.
%%%% ¡calculate!
sub = pr.get('EL');
prop = pr.get('PROP');

voi_dict = sub.get('VOI_DICT');
labels_voi = cell(1, voi_dict.get('LENGTH'));
for i = 1:1:voi_dict.get('LENGTH')
    voi = voi_dict.get('IT', i);
    
    labels_voi{i} = uilabel( ...
        'Parent', pr.memorize('H'), ...
        'Tag', ['LABEL ' int2str(i)], ...
        'Interpreter', 'html', ...
        'FontSize', BRAPH2.FONTSIZE, ...
        'HorizontalAlignment', 'right', ... 
        'Tooltip', [num2str(sub.getPropProp(prop)) ' ' sub.getPropDescription(prop)], ...
        'BackgroundColor', pr.get('BKGCOLOR') ...
        );
end

value = labels_voi;

%% ¡tests!

%%% ¡excluded_props!
[SubjectPP_VOIDict.PARENT SubjectPP_VOIDict.H SubjectPP_VOIDict.HANDLES_VOI SubjectPP_VOIDict.LABELS_VOI]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':SubjectPP_VOIDict'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':SubjectPP_VOIDict'])
