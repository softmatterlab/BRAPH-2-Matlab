%% ¡header!
PanelPropMatrix < PanelProp (pr, matrix-like prop panel) plots the panel of a property matrix-like.

%%% ¡description!
A Matrix Prop Panel (PanelPropMatrix) plots the panel for a RVECTOR, CVECTOR, MATRIX or SMATRIX property with a table.
It works for all categories.

It can be personalized with the following props:
 TABLE_HEIGHT - Panel height in pixels when the table is shown.
 ROWNAME - String list with row names (no names if empty; numbered if {'numbered'}). Dynamically updatable.
 COLUMNAME - String list with column names (no names if empty; numbered if {'numbered'}). Dynamically updatable.
 MENU_EXPORT - Whether to show the export menu. To be defined before drawing.

%%% ¡seealso!
uitable, GUI, PanelElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the matrix-like property panel.
%%%% ¡default!
'PanelPropMatrix'

%%% ¡prop!
NAME (constant, string) is the name of the matrix-like property panel.
%%%% ¡default!
'Matrix Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the matrix-like property panel.
%%%% ¡default!
'A Matrix Prop Panel (PanelPropMatrix) plots the panel for a RVECTOR, CVECTOR, MATRIX or SMATRIX property with a table. It works for all categories. It can be personalized with the following props: TABLE_HEIGHT, ROWNAME, COLUMNAME, MENU_EXPORT.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the matrix-like property panel.
%%%% ¡settings!
'PanelPropMatrix'

%%% ¡prop!
ID (data, string) is a few-letter code for the matrix-like property panel.
%%%% ¡default!
'PanelPropMatrix ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the matrix-like property panel.
%%%% ¡default!
'PanelPropMatrix label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the matrix-like property panel.
%%%% ¡default!
'PanelPropMatrix notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
IndexedDictionary()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
IndexedDictionary.REMOVE_ALL

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('TABLE')
    pr.memorize('CONTEXTMENU')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the table.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if any(el.getPropCategory(prop) == [Category.RESULT Category.QUERY Category.EVANESCENT]) && isa(el.getr(prop), 'NoValue')
        pr.set('HEIGHT', s(2))
    else
        if ispc()
            pr.set('HEIGHT', min(s(6.5) + s(2) * size(el.get(prop), 1), pr.get('TABLE_HEIGHT')))
        else
            pr.set('HEIGHT', min(s(4.5) + s(2) * size(el.get(prop), 1), pr.get('TABLE_HEIGHT')))
        end
    end

    rowname = pr.get('ROWNAME');
    if isequal(rowname, {'numbered'})
        rowname = 'numbered';
    end
    columnname = pr.get('COLUMNNAME');
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
                'Data', el.get(prop), ...
                'ColumnEditable', false ...
                )
            
        case Category.METADATA
            set(pr.get('TABLE'), ...
                'Data', el.get(prop), ...
                'ColumnEditable', ~el.isLocked(prop) ...
                )
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('TABLE'), ...
                'Data', el.get(prop), ...
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
                    'Data', el.get(prop), ...
                    'Enable', pr.get('ENABLE'), ...
                    'ColumnEditable', false, ...
                    'Visible', 'on' ...
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
    
    set(pr.get('TABLE'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('TABLE', Element.getNoValue())
    pr.set('CONTEXTMENU', Element.getNoValue())
end

%% ¡props!

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
MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.
%%%% ¡default!
true

%%% ¡prop!
TABLE_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.
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
    i = event.Indices(1);
    j = event.Indices(2); 
    newdata = event.NewData;

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    value = el.get(prop);
    value(i, j) = newdata;
    el.set(prop, value)
end

%%% ¡prop!
CONTEXTMENU (evanescent, handle) is the context menu.
%%%% ¡calculate!
contextmenu = uicontextmenu(...
    'Parent', ancestor(pr.get('H'), 'figure'), ...
    'Tag', 'CONTEXTMENU' ...
    );
menu_export_to_xls = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_EXPORT_TO_XLS', ...
    'Text', 'Export to XLS', ...
    'MenuSelectedFcn', {@cb_export_to_xls} ...
    );
if pr.get('MENU_EXPORT')
    set(pr.get('TABLE'), 'ContextMenu', contextmenu)
end
value = contextmenu;
%%%% ¡calculate_callbacks!
function cb_export_to_xls(~, ~)
    table = pr.get('TABLE');
    data = table.Data;
    
    columns = table.ColumnName;
    if isempty(columns)
        columns = cellfun(@(x) ['Column ' num2str(x)], num2cell([1:1:size(data, 2)]), 'UniformOutput', false);
    elseif isequal(columns, 'numbered')
        columns = cellfun(@(x) num2str(x), num2cell([1:1:size(data, 2)]), 'UniformOutput', false);
    end
    
    rows = table.RowName;
    if isempty(rows)
        rows = cellfun(@(x) ['Row ' num2str(x)], num2cell([1:1:size(data, 1)]), 'UniformOutput', false);
    elseif isequal(rows, 'numbered')
        rows = cellfun(@(x) num2str(x), num2cell([1:1:size(data, 1)]), 'UniformOutput', false);
    end

    t = array2table(data, ...
        'VariableNames', columns, ...
        'RowNames', rows ...
        );

    % save file
    [filename, filepath, filterindex] = uiputfile({'*.xlsx';'*.xls'}, 'Select Excel file');
    if filterindex
        file = [filepath filename];
        writetable(t, file, 'WriteRowNames', true);
    end
end

%% ¡tests!

%%% ¡excluded_props!
[PanelPropMatrix.PARENT PanelPropMatrix.H PanelPropMatrix.LISTENER_CB PanelPropMatrix.HEIGHT PanelPropMatrix.TABLE PanelPropMatrix.CONTEXTMENU]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropMatrix'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropMatrix'])