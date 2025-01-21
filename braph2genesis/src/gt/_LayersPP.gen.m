%% ¡header!
LayersPP < PanelProp (pr, layers prop panel) plots the panel to select the layers of an adjacency matrix.

%%% ¡description!
A Layers Prop Panel (LayersPP) plots the panel to select the layers of an adjacency matrix.
It works for all categories.

%%% ¡seealso!
uitable, GraphHistPF, GraphAdjPF

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel to select the layers of an adjacency matrix (LayersPP).
%%%% ¡default!
'LayersPP'

%%% ¡prop!
NAME (constant, string) is the name of the panel to select the layers of an adjacency matrix.
%%%% ¡default!
'Layers Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel to select the layers of an adjacency matrix.
%%%% ¡default!
'A Layers Prop Panel (LayersPP) plots the panel to select the layers of an adjacency matrix.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel to select the layers of an adjacency matrix.
%%%% ¡settings!
'LayersPP'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel to select the layers of an adjacency matrix.
%%%% ¡default!
'LayersPP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel to select the layers of an adjacency matrix.
%%%% ¡default!
'LayersPP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel to select the layers of an adjacency matrix.
%%%% ¡default!
'LayersPP notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
GraphHistPF()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
GraphHistPF.LAYERS

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('TABLE')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
    el = pr.get('EL');
    prop = pr.get('PROP');

    g = el.get(pr.get('G_PROP'));
    
    if any(el.getPropCategory(prop) == [Category.RESULT Category.QUERY Category.EVANESCENT]) && isa(el.getr(prop), 'NoValue')
        pr.set('HEIGHT', s(2))
    else
        pr.set('HEIGHT', min(s(4.5) + s(2) * g.get('LAYERNUMBER'), pr.get('TABLE_HEIGHT')))
    end

    if isa(pr.getr('ROWNAME'), 'NoValue')
        rowname = g.get('ALAYERLABELS');
    else
        rowname = pr.get('ROWNAME');
    end
    if isequal(rowname, {'numbered'})
        rowname = 'numbered';
    end
    if isa(pr.getr('COLUMNNAME'), 'NoValue')
        columnname = g.get('ALAYERLABELS');
    else
        columnname = pr.get('COLUMNNAME');
    end
    if isequal(columnname, {'numbered'})
        columnname = 'numbered';
    end
    set(pr.get('TABLE'), ...
        'RowName', rowname, ...
        'ColumnName', columnname ...
        );

    if el.isLocked(prop)
        set(pr.get('TABLE'), 'Enable', pr.get('ENABLE'))
    end
    
    switch el.getPropCategory(prop)
        case Category.CONSTANT
            set(pr.get('TABLE'), ...
                'Data', cb_table_data(el.get(prop)), ...
                'ColumnEditable', false ...
                )
            
        case Category.METADATA
            set(pr.get('TABLE'), ...
                'Data', cb_table_data(el.get(prop)), ...
                'ColumnEditable', ~el.isLocked(prop) ...
                )
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('TABLE'), ...
                'Data', cb_table_data(el.get(prop)), ...
                'ColumnEditable', ~el.isLocked(prop) ...
                )
            
            prop_value = el.getr(prop);
            if isa(prop_value, 'Callback')
                set(pr.get('TABLE'), ...
                    'Enable', pr.get('ENABLE'), ...
                    'ColumnEditable', false ...
                    )
            end

        case {Category.RESULT Category.QUERY Category.EVANESCENT}
            prop_value = el.getr(prop);

            if isa(prop_value, 'NoValue')
                % don't plot anything for a result not yet calculated
                set(pr.get('TABLE'), 'Visible', 'off')
            else
                set(pr.get('TABLE'), ...
                    'Data', cb_table_data(el.get(prop)), ...
                    'Enable', pr.get('ENABLE'), ...
                    'ColumnEditable', false, ...
                    'Visible', 'on' ...
                    )
            end
    end
end
%%%% ¡calculate_callbacks!
function data = cb_table_data(indices)
    g = pr.get('EL').get(pr.get('G_PROP'));
    data = false(g.get('LAYERNUMBER'));
    
    data(indices(1), indices(2)) = true;
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    set(pr.get('TABLE'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('TABLE', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
G_PROP (data, scalar) is the graph property number.
%%%% ¡default!
GraphHistPF.G
%%%% ¡postset!
pr.lock('G_PROP', 'Iterative', false)

%%% ¡prop!
ENABLE (gui, option) switches table between on and off.
%%%% ¡settings!
{'on', 'off'}
%%%% ¡default!
'on'

%%% ¡prop!
ROWNAME (gui, stringlist) determines the table row names.
%%%% ¡default!
{'numbered'}
%%%% ¡postset!
if pr.get('DRAWN')
    pr.get('UPDATE')
end

%%% ¡prop!
COLUMNNAME (gui, stringlist) determines the table column names.
%%%% ¡default!
{'numbered'}
%%%% ¡postset!
if pr.get('DRAWN')
    pr.get('UPDATE')
end

%%% ¡prop!
TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.
%%%% ¡default!
s(20)

%%% ¡prop!
TABLE (evanescent, handle) is the table.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

table = uitable( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'TABLE', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'CellEditCallback', {@cb_table} ...
    );

value = table;
%%%% ¡calculate_callbacks!
function cb_table(~, event)
    el = pr.get('EL');
    prop = pr.get('PROP');
    el.set(prop, event.Indices)
end

%% ¡tests!

%%% ¡excluded_props!
[LayersPP.PARENT LayersPP.H LayersPP.LISTENER_CB LayersPP.HEIGHT LayersPP.TABLE]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':LayersPP'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':LayersPP'])