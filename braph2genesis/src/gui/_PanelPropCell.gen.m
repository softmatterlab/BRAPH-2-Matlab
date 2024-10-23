%% ¡header!
PanelPropCell < PanelProp (pr, cell prop panel) plots the panel of a property cell.

%%% ¡description!
A Cell Prop Panel (PanelPropCell) plots the panel for a CELL property with a table and two sliders.
It works for all categories.

It can be personalized with the following props:
 TABLE_HEIGHT - Panel height in pixels when the table is shown.
 XSLIDERSHOW - Whether to show the x-slider.
 XSLIDERLABELS - Labels for the x-slider.
 XSLIDERHEIGHT - Height of x-slider in pixels.
 YSLIDERSHOW - Whether to show the y-slider.
 YSLIDERLABELS - Labels for the y-slider.
 YSLIDERWIDTH - Width of y-slider in pixels.
 XYSLIDERLOCK - Whether the sliders are locked so that only the diagonal is shown.
 ROWNAME - String list with row names (no names if empty; numbered if {'numbered'}). Dynamically updatable.
 COLUMNAME - String list with column names (no names if empty; numbered if {'numbered'}). Dynamically updatable.
 MENU_EXPORT - Whether to show the export menu. To be defined before drawing.

%%% ¡seealso!
uitable, uislider, GUI, PanelElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the cell property panel.
%%%% ¡default!
'PanelPropCell'

%%% ¡prop!
NAME (constant, string) is the name of the cell property panel.
%%%% ¡default!
'Cell Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the cell property panel.
%%%% ¡default!
'A Cell Prop Panel (PanelPropCell) plots the panel for a CELL property with a table and two sliders. It works for all categories. It can be personalized with the following props: TABLE_HEIGHT, XSLIDERSHOW, XSLIDERLABELS, XSLIDERHEIGHT, YSLIDERSHOW, YSLIDERLABELS, YSLIDERHEIGHT, XYSLIDERLOCK, ROWNAME, COLUMNAME, MENU_EXPORT.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the cell property panel.
%%%% ¡settings!
'PanelPropCell'

%%% ¡prop!
ID (data, string) is a few-letter code for the cell property panel.
%%%% ¡default!
'PanelPropCell ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the cell property panel.
%%%% ¡default!
'PanelPropCell label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the cell property panel.
%%%% ¡default!
'PanelPropCell notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
Graph()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
Graph.A

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('TABLE')
    pr.memorize('CONTEXTMENU')
    pr.memorize('XSLIDER')
    pr.memorize('YSLIDER')
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
        pr.set('HEIGHT', pr.get('TABLE_HEIGHT'))
    end
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    % % % %TODO Add the management of the cases where the names are different for each cell
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
                'Data', set_sliders_and_get_value(), ...
                'ColumnEditable', false ...
                )
            
        case Category.METADATA
            set(pr.get('TABLE'), ...
                'Data', set_sliders_and_get_value(), ...
                'ColumnEditable', ~el.isLocked(prop) ...
                )
            
        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('TABLE'), ...
                'Data', set_sliders_and_get_value(), ...
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
                set(pr.get('XSLIDER'), 'Visible', 'off')
                set(pr.get('YSLIDER'), 'Visible', 'off')
            else
                set(pr.get('TABLE'), ...
                    'Data', set_sliders_and_get_value(), ...
                    'Enable', pr.get('ENABLE'), ...
                    'ColumnEditable', false, ...
                    'Visible', 'on' ...
                    )
            end
            
% % %                 if (isa(el, 'ComparisonGroup') | isa(el, 'ComparisonEnsemble')) && el.existsTag('QVALUE')
% % %                     
% % %                     tmp_data = get_p_value();
% % %                     
% % %                     if size(tmp_data, 1) > size(tmp_data, 2)
% % %                         tmp_data = tmp_data';
% % %                     end
% % %                     
% % %                     [~, mask] = fdr(tmp_data, el.get('QVALUE'));
% % %                     [cols, rows] = find(mask);
% % %                     
% % %                     if ~isempty(rows) && ~isempty(cols)
% % %                         s = uistyle('BackgroundColor',[146/255 179/255 175/255]);
% % %                         addStyle(pr.table, s, 'cell', [rows', cols']);
% % %                     else
% % %                         non_sign = ones(size(mask));
% % %                         [cols, rows] = find(non_sign - mask);
% % %                         s = uistyle('BackgroundColor', [1 1 1]); % default color, no significance
% % %                         addStyle(pr.table, s, 'cell', [rows', cols']);
% % %                     end
% % %                 end
% % %             end
    end
end
%%%% ¡calculate_callbacks!
function value = set_sliders_and_get_value()
    value = el.get(prop);
    if isempty(value)
        set(pr.get('XSLIDER'), ...
            'Limits', [.6 1.4], ...
            'MajorTicks', [1], ...
            'MajorTickLabels', {}, ...
            'Value', 1, ...
            'Visible', pr.get('XSLIDERSHOW') ...
            )
        set(pr.get('YSLIDER'), ...
            'Limits', [.6 1.4], ...
            'MajorTicks', [1], ...
            'MajorTickLabels', {}, ...
            'Value', 1, ...
            'Visible', pr.get('YSLIDERSHOW') ...
            )
    else
        [R, C] = size(value);
        set(pr.get('XSLIDER'), ...
            'Limits', [.6 C+.4], ...
            'MajorTicks', [1:1:C], ...
            'MajorTickLabels', pr.get('XSLIDERLABELS'), ...
            'Value', max(1, min(round(get(pr.get('XSLIDER'), 'Value'), C))), ...
            'Visible', pr.get('XSLIDERSHOW') ...
            )
        set(pr.get('YSLIDER'), ...
            'Limits', [.6 R+.4], ...
            'MajorTicks', [1:1:R], ...
            'MajorTickLabels', flip(pr.get('YSLIDERLABELS')), ...
            'Value', max(1, min(round(get(pr.get('YSLIDER'), 'Value'), R))), ...
            'Visible', pr.get('YSLIDERSHOW') ...
            )

        if pr.get('XYSLIDERLOCK')
            set(pr.get('YSLIDER'), 'Value', R + 1 - get(pr.get('XSLIDER'), 'Value'))
        end

        value = value{R + 1 - get(pr.get('YSLIDER'), 'Value'), get(pr.get('XSLIDER'), 'Value')};
    end
end
% % %     function pval = get_p_value()
% % %         value = el.get('P2');
% % %         [R, ~] = size(value);
% % %         pval = value{R + 1 - get(pr.get('YSLIDER'), 'Value'), get(pr.get('XSLIDER'), 'Value')};
% % %     end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    if ~pr.get('XSLIDERSHOW') && ~pr.get('YSLIDERSHOW')
        set(pr.get('TABLE'), 'Position', [s(.3) s(.3) max(1, w_p-s(.6)) max(1, pr.get('HEIGHT')-s(2.2))])
    elseif pr.get('XSLIDERSHOW') && ~pr.get('YSLIDERSHOW')
        set(pr.get('TABLE'), 'Position', [s(.3) s(.3) max(1, w_p-s(.6)) max(1, pr.get('HEIGHT')-s(2.2)-pr.get('XSLIDERHEIGHT'))])
        set(pr.get('XSLIDER'), 'Position', [s(.3) max(1, pr.get('HEIGHT')-s(2.0)-s(.3)) max(1, w_p-s(.6)) 3])
    elseif ~pr.get('XSLIDERSHOW') && pr.get('YSLIDERSHOW')
        set(pr.get('TABLE'), 'Position', [s(.3)+pr.get('YSLIDERWIDTH') s(.3) max(1, w_p-s(.6)-pr.get('YSLIDERWIDTH')) max(1, pr.get('HEIGHT')-s(2.2))])
        set(pr.get('YSLIDER'), 'Position', [s(.3) s(.3) 3 max(1, pr.get('HEIGHT')-s(2.2))])
    else % pr.get('XSLIDERSHOW') && pr.get('YSLIDERSHOW')
        set(pr.get('TABLE'), 'Position', [s(.3)+pr.get('YSLIDERWIDTH') s(.3) max(1, w_p-s(.6)-pr.get('YSLIDERWIDTH')) max(1, pr.get('HEIGHT')-s(2.2)-pr.get('XSLIDERHEIGHT'))])
        set(pr.get('XSLIDER'), 'Position', [s(.3)+pr.get('YSLIDERWIDTH') max(1, pr.get('HEIGHT')-s(2.0)-s(.3)) max(1, w_p-s(.6)-pr.get('YSLIDERWIDTH')) 3])
        set(pr.get('YSLIDER'), 'Position', [s(.3) s(.3) 3 max(1, pr.get('HEIGHT')-s(2.2)-s(.6)-pr.get('XSLIDERHEIGHT'))])
    end
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('TABLE', Element.getNoValue())
    pr.set('CONTEXTMENU', Element.getNoValue())
    pr.set('XSLIDER', Element.getNoValue())
    pr.set('YSLIDER', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
XSLIDERSHOW (gui, logical) determines whether to show the xslider.
%%%% ¡default!
true

%%% ¡prop!
XSLIDERLABELS (gui, stringlist) determines the xslider labels.

%%% ¡prop!
XSLIDERHEIGHT (gui, size) is the height below the xslider in font size units.
%%%% ¡default!
s(3)

%%% ¡prop!
XSLIDER (evanescent, handle) is the x-slider.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

xslider = uislider( ...
    'Parent', pr.get('H'), ...
    'Tag', 'XSLIDER', ...
    'MajorTicksMode', 'manual', ...
    'MajorTickLabelsMode', 'manual', ...
    'MinorTicksMode', 'manual', ...
    'MinorTicks', [], ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_xslider} ...
    );

value = xslider;
%%%% ¡calculate_callbacks!
function cb_xslider(~, ~)
    set(pr.get('XSLIDER'), 'Value', round(get(pr.get('XSLIDER'), 'Value')))
    
    % if pr.get('XYSLIDERLOCK')
    %     el = pr.get('EL');
    %     prop = pr.get('PROP');
    %     value = el.get(prop);
    %     [R, C] = size(value);
    % 
    %     R = max(R, 1); % to manage the case in which C = R = 0 (empty cell)
    % 
    %     set(pr.get('YSLIDER'), 'Value', R + 1 - get(pr.get('XSLIDER'), 'Value'))
    % end
    
    pr.get('UPDATE')
end

%%% ¡prop!
YSLIDERSHOW (gui, logical) determines whether to show the yslider.
%%%% ¡default!
true

%%% ¡prop!
YSLIDERLABELS (gui, stringlist) determines the yslider labels.

%%% ¡prop!
YSLIDERWIDTH (gui, size) is the width to the right of the yslider in font size units.
%%%% ¡default!
s(3)

%%% ¡prop!
YSLIDER (evanescent, handle) is the y-slider.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

yslider = uislider( ...
    'Parent', pr.get('H'), ...
    'Tag', 'YSLIDER', ...
    'Orientation', 'vertical', ...
    'MajorTicksMode', 'manual', ...
    'MajorTickLabelsMode', 'manual', ...
    'MinorTicksMode', 'manual', ...
    'MinorTicks', [], ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_yslider} ...
    );

value = yslider;
%%%% ¡calculate_callbacks!
function cb_yslider(~, ~)
    set(pr.get('YSLIDER'), 'Value', round(get(pr.get('YSLIDER'), 'Value')))
    
    if pr.get('XYSLIDERLOCK')
        el = pr.get('EL');
        prop = pr.get('PROP');
        value = el.get(prop);
        [R, C] = size(value);
        
        C = max(C, 1); % to manage the case in which C = R = 0 (empty cell)

        set(pr.get('XSLIDER'), 'Value', C + 1 - get(pr.get('YSLIDER'), 'Value'))
    end

    pr.get('UPDATE')
end

%%% ¡prop!
XYSLIDERLOCK (gui, logical) determines whether the sliders are locked so that only the diagonal is shown.
%%%% ¡default!
false

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
TABLE (evanescent, handle) is the alpha value edit field.
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
    [R, C] = size(value);
    
    r = R + 1 - get(pr.get('YSLIDER'), 'Value');
    c = get(pr.get('XSLIDER'), 'Value');
    
    value_rc = value{r, c};
    value_rc(i, j) = newdata;
    value{r, c} = value_rc;
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
        rows = cellfun(@(x) ['Column ' num2str(x)], num2cell([1:1:size(data, 1)]), 'UniformOutput', false);
    elseif isequal(rows, 'numbered')
        rows = cellfun(@(x) num2str(x), num2cell([1:1:size(data, 1)]), 'UniformOutput', false);
    end
    
    t = cell2table([rows, num2cell(data)], ...
        'VariableNames', [' '; columns] ...
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
[PanelPropCell.PARENT PanelPropCell.H PanelPropCell.LISTENER_CB PanelPropCell.HEIGHT PanelPropCell.XSLIDER PanelPropCell.YSLIDER PanelPropCell.TABLE PanelPropCell.CONTEXTMENU]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropCell'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropCell'])