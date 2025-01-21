%% ¡header!
PanelPropItemList < PanelProp (pr, item-list prop panel) plots the panel of a property item-list.

%%% ¡description!
An Item-List Prop Panel (PanelPropItemList) plots the panel for a ITEMLIST property with a table.
 It works for all categories. 
 
It can be personalized with the following props:
  COLS - Numerical array with the columns to be visualized. It can include 
         PanelPropIDictTable.SELECTOR and/or prop numbers of the item class.
  ROWNAME - String list with the row names as per uitable format.
         It can be a string list or 'numbered' or {} (to reset it).
  COLUMNAME - String list with the column names as per uitable format.
         It can be a string list or 'numbered'.
  COLUMNWIDTH - String list with the cloumn width as per uitable format.
         It can be a string list (e.g. {'1x' '2x'}) or 'auto'.
  COLUMNEDITABLE - Row vector to determine the cloumn editability as per uitable format.
         It can be a row vector of booleans.
  COLUMNFORMAT - Code to determine the column format as per uitable format.
         The format should be, e.g., {'char' 'logical' 'numeric' {'op1' 'op2'}}.
  CB_TAB_EDIT - Code in a cell array for the edit callback to be evaluated 
         by the table edit callback. It can refer to the variables:
          el, prop, dict, it_class, pr, i, col, newdata
         and use the standard callback function:
          cb_table_edit_default()
 
%%% ¡seealso!
uitable, GUI, PanelElement, GUIElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the item-list property panel.
%%%% ¡default!
'PanelPropItemList'

%%% ¡prop!
NAME (constant, string) is the name of the item-list property panel.
%%%% ¡default!
'Item-List Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the item-list property panel.
%%%% ¡default!
'An Item-List Prop Panel (PanelPropItemList) plots the panel for a ITEMLIST property with a table. It works for all categories. It can be personalized with the following props: COLS, ROWNAME, COLUMNAME, COLUMNWIDTH, COLUMNEDITABLE, COLUMNFORMAT, CB_TAB_EDIT.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the item-list property panel.
%%%% ¡settings!
'PanelPropItemList'

%%% ¡prop!
ID (data, string) is a few-letter code for the item-list property panel.
%%%% ¡default!
'PanelPropItemList ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the item-list property panel.
%%%% ¡default!
'PanelPropItemList label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the item-list property panel.
%%%% ¡default!
'PanelPropItemList notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
IndexedDictionary()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
IndexedDictionary.IT_LIST

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
        it_list = el.get(prop);
        pr.set('HEIGHT', min(s(4.5) + s(2) * length(it_list), pr.get('TABLE_HEIGHT')))
    end

    switch el.getPropCategory(prop)
        case Category.CONSTANT % __Category.CONSTANT__
            set_table()
            set(pr.get('TABLE'), 'ColumnEditable', false)
            
        case Category.METADATA % __Category.METADATA__
            set_table()

            if el.isLocked(prop)
                set(pr.get('TABLE'), 'ColumnEditable', false)
            end
        case {Category.PARAMETER Category.DATA Category.FIGURE Category.GUI} % {__Category.PARAMETER__ __Category.DATA__ __Category.FIGURE__ __Category.GUI__}
            set_table()
            
            if el.isLocked(prop)
                set(pr.get('TABLE'), 'ColumnEditable', false)
            end
            
            prop_value = el.getr(prop);
            if isa(prop_value, 'Callback')
                set(pr.get('TABLE'), 'ColumnEditable', false)
            end

        case {Category.RESULT Category.QUERY Category.EVANESCENT} % {__Category.RESULT__ __Category.QUERY__ __Category.EVANESCENT__}
            prop_value = el.getr(prop);

            if isa(prop_value, 'NoValue')
                % don't plot anything for a result not yet calculated
                set(pr.get('TABLE'), 'Visible', 'off')
            else
                set_table()
                set(pr.get('TABLE'), 'Visible', 'on')
            end
    end
end
%%%% ¡calculate_callbacks!
function set_table()
    el = pr.get('EL');
    prop = pr.get('PROP');

    it_list = el.get(prop);
    it_class = el.getPropSettings(prop);

    % columns to be to be shown in the table
    % col = pr.SELECTOR for the selector column
    % col = prop for the prop columns
    if isempty(pr.get('COLS')) % empty pr.get('COLS')
        pr.set('COLS', pr.get('COLS'))
    end
	cols = pr.memorize('COLS');

    % data
	data = cell(length(it_list), length(cols));
    for i = 1:1:length(it_list)
        for c = 1:1:length(cols)
            col = cols(c);
            if col == pr.SELECTOR
                if any(pr.get('SELECTED') == i)
                    data{i, c} = true;
                else
                    data{i, c} = false;
                end
            elseif Element.existsProp(it_class, col) % prop = col;
                switch Element.getPropFormat(it_class, col)
                    case Format.EMPTY % __Format.EMPTY__
                        %%%__WARN_TBI__
                    
                    case Format.STRING % __Format.STRING__
                        data{i, c} = it_list{i}.get(col);
                        
                    case Format.STRINGLIST % __Format.STRINGLIST__
                        %%%__WARN_TBI__
                    
                    case Format.LOGICAL % __Format.LOGICAL__
                        data{i, c} = it_list{i}.get(col);
                        
                    case Format.OPTION % __Format.OPTION__
                        data{i, c} = it_list{i}.get(col);
                        
                    case Format.CLASS % __Format.CLASS__
                        %%%__WARN_TBI__

                    case Format.CLASSLIST % __Format.CLASSLIST__
                        %%%__WARN_TBI__
                        
                    case Format.ITEM % __Format.ITEM__
                        data{i, c} = it_list{i}.get(col).get('TOSTRING');
                        
                    case Format.ITEMLIST % __Format.ITEMLIST__
                        %%%__WARN_TBI__

                    case Format.IDICT % __Format.IDICT__
                        data{i, c} = it_list{i}.get(col).get('TOSTRING');
                        
                    case Format.SCALAR % __Format.SCALAR__
                        data{i, c} = it_list{i}.get(col);
                        
                    case {Format.RVECTOR Format.CVECTOR Format.MATRIX Format.SMATRIX} % {__Format.RVECTOR__ __Format.CVECTOR__ __Format.MATRIX__ __Format.SMATRIX__}
                        prop_value = it_list{i}.get(col);
                        data{i, c} = [int2str(size(prop_value, 1)) ' x ' int2str(size(prop_value, 2))];
                        
                    case Format.CELL % __Format.CELL__
                        %%%__WARN_TBI__

                    case Format.NET % __Format.NET__
                        %%%__WARN_TBI__
                        
                    case Format.HANDLE % __Format.HANDLE__
                        %%%__WARN_TBI__

                    case Format.HANDLELIST % __Format.HANDLELIST__
                        %%%__WARN_TBI__

                    case Format.COLOR % __Format.COLOR__
                        rgb = it_list{i}.get(col);
                        data{i, c} = [dec2hex(round(rgb(1) * 255), 2) dec2hex(round(rgb(2) * 255), 2) dec2hex(round(rgb(3) * 255), 2)];
                        
                    case Format.ALPHA % __Format.ALPHA__
                        data{i, c} = it_list{i}.get(col);
                        
                    case Format.SIZE % __Format.SIZE__
                        data{i, c} = it_list{i}.get(col);
                        
                    case Format.MARKER % __Format.MARKER__
                        data{i, c} = it_list{i}.get(col);
                        
                    case Format.LINE % __Format.LINE__
                        data{i, c} = it_list{i}.get(col);
                end
            end
        end
    end
    
    % rowname: string list or {'numbered'}
    rowname = pr.memorize('ROWNAME');
    if isempty(rowname)
        pr.set('ROWNAME', rowname)
        rowname = pr.memorize('ROWNAME'); % triggers preset
    elseif isequal(rowname, {'numbered'})
        rowname = 'numbered';
    end
    
    % columnname: string list or {'numbered'}
    columnname = pr.memorize('COLUMNNAME');
    if isequal(columnname, {'numbered'})
        columnname = 'numbered';
    end

    % columnwidth
    columnwidth = pr.memorize('COLUMNWIDTH');
    if isequal(columnwidth, {'auto'})
        columnwidth = 'auto';
    end

    % columneditable
    columneditable = logical(pr.memorize('COLUMNEDITABLE'));

    % columnformat
	columnformat = pr.memorize('COLUMNFORMAT');
    for i = 1:1:length(columnformat)
        columnformat_i_as_cell = str2cell(columnformat{i});
        if length(columnformat_i_as_cell) ~= 1
            columnformat{i} = columnformat_i_as_cell'; % ColumnFormat popupmenu definitions must be row vectors
        end
    end

    set(pr.get('TABLE'), ...
        'Data', data, ...
        'RowName', rowname, ...
        'ColumnName', columnname, ... 
        'ColumnWidth', columnwidth, ...
        'ColumnEditable', columneditable, ...
        'ColumnFormat', columnformat ...
        )

    % style SELECTED
    styles_row = find(pr.get('TABLE').StyleConfigurations.Target == 'row');
    if ~isempty(styles_row)
        removeStyle(pr.get('TABLE'), styles_row)
    end
    if ~isempty(pr.get('SELECTED'))
        addStyle(pr.get('TABLE'), uistyle('FontWeight', 'bold'), 'row', pr.get('SELECTED'))
    end
        
    % style COLOR
    menu_colorize_table = findobj(pr.get('CONTEXTMENU'), 'Tag', 'MENU_COLORIZE_TABLE');
    
    styles_cell = find(pr.get('TABLE').StyleConfigurations.Target == 'cell');
    if check_graphics(menu_colorize_table, 'uimenu') && get(menu_colorize_table, 'Checked')
        if isempty(styles_cell)
            for c = 1:1:length(cols)
                col = cols(c);
                if col > 0 && isequal(Element.getPropFormat(it_class, col), Format.COLOR)                            
                    for i = 1:1:dict.get('LENGTH')
                        addStyle(pr.get('TABLE'), ...
                            uistyle('FontColor', dict.get('IT', i).get(col)), ...
                            'cell', [i, c] ...
                            )
                    end
                end
            end
        else
            for c = 1:1:length(cols)
                col = cols(c);
                if col > 0 && isequal(Element.getPropFormat(it_class, col), Format.COLOR)
                    for i = 1:1:dict.get('LENGTH')
                        cell_to_be_removed = find(cellfun(@(x) isequal(x, [i, c]), pr.get('TABLE').StyleConfigurations.TargetIndex));
                        if ~isempty(cell_to_be_removed)
                            current_rgb = pr.get('TABLE').StyleConfigurations.Style(cell_to_be_removed).FontColor;
                            new_rgb = dict.get('IT', i).get(col);
                            if ~isequal(current_rgb, new_rgb)
                                removeStyle(pr.get('TABLE'), cell_to_be_removed)
                                addStyle(pr.get('TABLE'), ...
                                    uistyle('FontColor', new_rgb), ...
                                    'cell', [i, c] ...
                                    )
                            end
                        end
                    end
                end
            end
        end
    else
        if ~isempty(styles_cell)
            removeStyle(pr.get('TABLE'), styles_cell)
        end
    end
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
SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.SHOW, varargin{:}); % also warning
if value
    % figures for items
    gui_its_dict = pr.get('GUI_ITS_DICT');
    for i = 1:1:gui_its_dict.get('LENGTH')
        gui = gui_its_dict.get('IT', i);
        if gui.get('DRAWN')
            gui.get('SHOW')
        end
    end
end

%%% ¡prop!
HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.HIDE, varargin{:}); % also warning
if value    
    % figures for items
    gui_its_dict = pr.get('GUI_ITS_DICT');
    for i = 1:1:gui_its_dict.get('LENGTH')
        gui = gui_its_dict.get('IT', i);
        if gui.get('DRAWN')
            gui.get('HIDE')
        end
    end
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('TABLE', Element.getNoValue())
    pr.set('CONTEXTMENU', Element.getNoValue())
end

%%% ¡prop!
CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.CLOSE, varargin{:}); % also warning
if value
    % figures for items
    gui_its_dict = pr.get('GUI_ITS_DICT');
    for i = 1:1:gui_its_dict.get('LENGTH')
        gui = gui_its_dict.get('IT', i);
        if gui.get('DRAWN')
            gui.get('CLOSE')
        end
    end
end

%% ¡constants!
SELECTOR = -1 % code for the selector column.

%% ¡props!

%%% ¡prop!
TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.
%%%% ¡default!
s(20)

%%% ¡prop!
SELECTED (gui, cvector) is the list of selected items.
%%%% ¡conditioning!
if isrow(value)
    value = value';
end

%%% ¡prop!
COLS (gui, rvector) is the ordered list of columns.
%%%% ¡preset!
if isempty(value)
    el = pr.get('EL');
    prop = pr.get('PROP');

    it_class = el.getPropSettings(prop);

    % columns to be to be shown in the table
    % col = pr.SELECTOR for the selector column
    % col = prop for the prop columns
    cols = [pr.SELECTOR Element.getProps(it_class)];
    
    value = cols;
end

%%% ¡prop!
ROWNAME (gui, stringlist) determines the table row names.
%%%% ¡preset!
if isempty(value)
    el = pr.get('EL');
    prop = pr.get('PROP');

    it_list = el.get(prop);
    
    rowname = cellfun(@(it) it.get('ID'), it_list, 'UniformOutput', false);
    
    value = rowname;
    
elseif isequal(value, 'numbered')
    value = {'numbered'};
end

%%% ¡prop!
COLUMNNAME (gui, stringlist) determines the table column names.
%%%% ¡preset!
if isempty(value)
    el = pr.get('EL');
    prop = pr.get('PROP');

    it_class = el.getPropSettings(prop);

    cols = pr.memorize('COLS');
    
    columnname = repmat({''}, 1, length(cols));
    for c = 1:1:length(cols)
        col = cols(c);
        if col == pr.SELECTOR
            columnname{c} = '';
        elseif Element.existsProp(it_class, col) % prop = col;
            columnname{c} = Element.getPropTag(it_class, col);
        end
    end
    
    value = columnname;
    
elseif isequal(value, 'numbered')
    value = {'numbered'};
end

%%% ¡prop!
COLUMNWIDTH (gui, stringlist) determines the column widths.
%%%% ¡preset!
if isempty(value) || isequal(value, 'auto')
    columnwidth = {'auto'};
    
    value = columnwidth;
end

%%% ¡prop!
COLUMNEDITABLE (gui, rvector) determines whether the columns are editable.
%%%% ¡preset!
if isempty(value)
    el = pr.get('EL');
    prop = pr.get('PROP');

    it_class = el.getPropSettings(prop);
    
    cols = pr.memorize('COLS');
    
    columneditable = false(1, length(cols));
    for c = 1:1:length(cols)
        col = cols(c);
        if col == pr.SELECTOR
            columneditable(c) = true; % always true
        else
            if ~el.isLocked(prop)
                switch Element.getPropFormat(it_class, col)
                    case Format.EMPTY % __Format.EMPTY__
                        %%%__WARN_TBI__
                    
                    case Format.STRING % __Format.STRING__
                        columneditable(c) = true;
                        
                    case Format.STRINGLIST % __Format.STRINGLIST__
                        %%%__WARN_TBI__

                    case Format.LOGICAL % __Format.LOGICAL__
                        columneditable(c) = true;
                        
                    case Format.OPTION % __Format.OPTION__
                        columneditable(c) = true;
                        
                    case Format.CLASS % __Format.CLASS__
                        %%%__WARN_TBI__

                    case Format.CLASSLIST % __Format.CLASSLIST__
                        %%%__WARN_TBI__
                        
                    case Format.ITEM % __Format.ITEM__
                        columneditable(c) = false;
                        
                    case Format.ITEMLIST % __Format.ITEMLIST__
                        %%%__WARN_TBI__

                    case Format.IDICT % __Format.IDICT__
                        columneditable(c) = false;
                        
                    case Format.SCALAR % __Format.SCALAR__
                        columneditable(c) = true;
                        
                    case {Format.RVECTOR Format.CVECTOR Format.MATRIX Format.SMATRIX} % {__Format.RVECTOR__ __Format.CVECTOR__ __Format.MATRIX__ __Format.SMATRIX__}
                        columneditable(c) = false;
                        
                    case Format.CELL % __Format.CELL__
                        %%%__WARN_TBI__

                    case Format.NET % __Format.NET__
                        %%%__WARN_TBI__
                        
                    case Format.HANDLE % __Format.HANDLE__
                        %%%__WARN_TBI__

                    case Format.HANDLELIST % __Format.HANDLELIST__
                        %%%__WARN_TBI__

                    case Format.COLOR % __Format.COLOR__
                        columneditable(c) = true;
                        
                    case Format.ALPHA % __Format.ALPHA__
                        columneditable(c) = true;
                        
                    case Format.SIZE % __Format.SIZE__
                        columneditable(c) = true;
                        
                    case Format.MARKER % __Format.MARKER__
                        columneditable(c) = true;
                        
                    case Format.LINE % __Format.LINE__
                        columneditable(c) = true;
                end
            end
        end
    end
    
    value = columneditable;
end

% ensures that the value is numeric (not logical)
value = int8(columneditable);

%%% ¡prop!
COLUMNFORMAT (gui, stringlist) determines the columns formats.
%%%% ¡preset!
if isempty(value)
    el = pr.get('EL');
    prop = pr.get('PROP');

    it_class = el.getPropSettings(prop);
    
    cols = pr.memorize('COLS');

    columnformat = repmat({''}, 1, length(cols));
    for c = 1:1:length(cols)
        col = cols(c);
        if col == pr.SELECTOR
            columnformat{c} = 'logical';
        elseif Element.existsProp(it_class, col) % prop = col;
            switch Element.getPropFormat(it_class, col)
                case Format.EMPTY % __Format.EMPTY__
                    %%%__WARN_TBI__

                case Format.STRING % __Format.STRING__
                    columnformat{c} = 'char';

                case Format.STRINGLIST % __Format.STRINGLIST__
                    %%%__WARN_TBI__

                case Format.LOGICAL % __Format.LOGICAL__
                    columnformat{c} = 'logical';

                case Format.OPTION % __Format.OPTION__
                    columnformat{c} = Element.getPropSettings(it_class, col);

                case Format.CLASS % __Format.CLASS__
                    %%%__WARN_TBI__

                case Format.CLASSLIST % __Format.CLASSLIST__
                    %%%__WARN_TBI__

                case Format.ITEM % __Format.ITEM__
                    columnformat{c} = 'char';

                case Format.ITEMLIST % __Format.ITEMLIST__
                    %%%__WARN_TBI__

                case Format.IDICT % __Format.IDICT__
                    columnformat{c} = 'char';

                case Format.SCALAR % __Format.SCALAR__
                    columnformat{c} = 'numeric';

                case {Format.RVECTOR Format.CVECTOR Format.MATRIX Format.SMATRIX} % {__Format.RVECTOR__ __Format.CVECTOR__ __Format.MATRIX__ __Format.SMATRIX__}
                    columnformat{c} = 'char';

                case Format.CELL % __Format.CELL__
                    %%%__WARN_TBI__

                case Format.NET % __Format.NET__
                    %%%__WARN_TBI__

                case Format.HANDLE % __Format.HANDLE__
                    %%%__WARN_TBI__

                case Format.HANDLELIST % __Format.HANDLELIST__
                    %%%__WARN_TBI__

                case Format.COLOR % __Format.COLOR__
                    columnformat{c} = 'char';

                case Format.ALPHA % __Format.ALPHA__
                    columnformat{c} = 'numeric';

                case Format.SIZE % __Format.SIZE__
                    columnformat{c} = 'numeric';

                case Format.MARKER % __Format.MARKER__
                    columnformat{c} = Element.getPropSettings(it_class, col);

                case Format.LINE % __Format.LINE__
                    columnformat{c} = Element.getPropSettings(it_class, col);
            end            
        end
    end
    
    value = columnformat;
end

for i = 1:1:length(value)
    if iscell(value{i})
        value{i} = cell2str(value{i});
    end
end

%%% ¡prop!
CB_TAB_EDIT (gui, string) is executed when a cell is updated (to be evaluated).
%%%% ¡conditioning!
if iscell(value)
    value = sprintf('%s;', value{:});
end

%%% ¡prop!
TABLE (evanescent, handle) is the table.
%%%% ¡calculate!
table = uitable( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'table', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'ColumnSortable', true, ...
    'CellEditCallback', {@cb_table} ...
    );
value = table;
%%%% ¡calculate_callbacks!
function cb_table(~, event) % (src, event)
    menu_apply_to_selection = findobj(pr.get('CONTEXTMENU'), 'Tag', 'MENU_APPLY_TO_SELECTION');
	if ~get(menu_apply_to_selection, 'Checked')
        cols = pr.get('COLS');
        cb_table_edit(event.Indices(1), cols(event.Indices(2)), event.NewData)
    else
        cols = pr.get('COLS');

        % adds current item to selected
        if cols(event.Indices(2)) == pr.SELECTOR
            cb_table_edit(event.Indices(1), pr.SELECTOR, event.NewData)
        else
            cb_table_edit(event.Indices(1), pr.SELECTOR, true)
        end

        % updates all selected
        selected = pr.get('SELECTED');
        for s = 1:1:length(selected)
            cb_table_edit(selected(s), cols(event.Indices(2)), event.NewData)
        end
	end

    pr.get('UPDATE') % placed here for numerical efficiency

    function cb_table_edit(i, col, newdata)

        el = pr.get('EL');
        prop = pr.get('PROP');
        
        it_class = el.getPropSettings(prop);
        
        if ~isempty(pr.get('CB_TAB_EDIT'))
            eval(pr.get('CB_TAB_EDIT'))
        else
            cb_table_edit_default()
        end
        function cb_table_edit_default()
            if col == pr.SELECTOR
                selected = pr.get('SELECTED');
                if newdata == 1
                    pr.set('SELECTED', sort(unique([selected; i])));
                else
                    pr.set('SELECTED', selected(selected ~= i));
                end
            elseif Element.existsProp(it_class, col) % prop = col;
                switch Element.getPropFormat(it_class, col)
                    case Format.EMPTY % __Format.EMPTY__
                        %%%__WARN_TBI__
    
                    case Format.STRING % __Format.STRING__
                        dict.get('IT', i).set(col, newdata)
                        
                    case Format.STRINGLIST % __Format.STRINGLIST__
                        %%%__WARN_TBI__

                    case Format.LOGICAL % __Format.LOGICAL__
                        dict.get('IT', i).set(col, newdata)
    
                    case Format.OPTION % __Format.OPTION__
                        dict.get('IT', i).set(col, newdata)
    
                    case Format.CLASS % __Format.CLASS__
                        %%%__WARN_TBI__
    
                    case Format.CLASSLIST % __Format.CLASSLIST__
                        %%%__WARN_TBI__
    
                    case Format.ITEM % __Format.ITEM__
                        %
    
                    case Format.ITEMLIST % __Format.ITEMLIST__
                        %%%__WARN_TBI__
    
                    case Format.IDICT % __Format.IDICT__
                        %
    
                    case Format.SCALAR % __Format.SCALAR__ % __Format.SCALAR__
                        dict.get('IT', i).set(col, newdata)
    
                    case {Format.RVECTOR Format.CVECTOR Format.MATRIX Format.SMATRIX} % {__Format.RVECTOR__ __Format.CVECTOR__ __Format.MATRIX__ __Format.SMATRIX__}
                        %
    
                    case Format.CELL % __Format.CELL__
                        %%%__WARN_TBI__
    
                    case Format.NET % __Format.NET__
                        %%%__WARN_TBI__
    
                    case Format.HANDLE % __Format.HANDLE__
                        %%%__WARN_TBI__

                    case Format.HANDLELIST % __Format.HANDLELIST__
                        %%%__WARN_TBI__

                    case Format.COLOR % __Format.COLOR__
                        try
                            rgb = [hex2dec(newdata(1:2))/255 hex2dec(newdata(3:4))/255 hex2dec(newdata(5:6))/255];
                            dict.get('IT', i).set(col, rgb)
                        catch
                            %
                        end
    
                    case Format.ALPHA % __Format.ALPHA__
                        dict.get('IT', i).set(col, min(abs(newdata), 1))
    
                    case Format.SIZE % __Format.SIZE__
                        if newdata ~= 0
                            dict.get('IT', i).set(col, abs(newdata))
                        end
    
                    case Format.MARKER % __Format.MARKER__
                        dict.get('IT', i).set(col, newdata)
    
                    case Format.LINE % __Format.LINE__
                        dict.get('IT', i).set(col, newdata)
                end
            end        
        end
        
    % pr.get('UPDATE') % placed above for numerical efficiency
    end

end

%%% ¡prop!
MENU_OPEN_ITEMS (gui, logical) determines whether to show the context menu to open the items.
%%%% ¡default!
true

%%% ¡prop!
MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.
%%%% ¡default!
false

%%% ¡prop!
CONTEXTMENU (evanescent, handle) is the context menu.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

it_class = el.getPropSettings(prop);
    
contextmenu = uicontextmenu( ...
    'Parent', ancestor(pr.get('H'), 'figure'), ...
    'Tag', 'CONTEXTMENU' ...
    );
menu_select_all = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_SELECT_ALL', ...
    'Text', 'Select All', ...
    'MenuSelectedFcn', {@cb_select_all} ...
    );
menu_clear_selection = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_CLEAR_SELECTION', ...
    'Text', 'Clear Selection', ...
    'MenuSelectedFcn', {@cb_clear_selection} ...
    );
menu_invert_selection = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_INVERT_SELECTION', ...
    'Text', 'Invert Selection', ...
    'MenuSelectedFcn', {@cb_invert_selection} ...
    );
menu_apply_to_selection = uimenu( ...
    'Separator', 'on', ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_APPLY_TO_SELECTION', ...
    'Text', 'Apply to Selection', ...
    'Checked', false ...
    );
set(menu_apply_to_selection, ...
    'MenuSelectedFcn', {@cb_apply_to_selection, menu_apply_to_selection} ...
    );
if pr.get('MENU_OPEN_ITEMS')
    menu_open_selection = uimenu( ...
        'Separator', 'on', ...
        'Parent', contextmenu, ...
        'Tag', 'MENU_OPEN_SELECTION', ...
        'Text', 'Open Selection', ...
        'MenuSelectedFcn', {@cb_open_selection} ...
        );
    menu_hide_selection = uimenu( ...
        'Parent', contextmenu, ...
        'Tag', 'MENU_HIDE_SELECTION', ...
        'Text', 'Hide Selection', ...
        'MenuSelectedFcn', {@cb_hide_selection} ...
        );
    menu_hide_all = uimenu( ...
        'Parent', contextmenu, ...
        'Tag', 'MENU_HIDE_ALL', ...
        'Text', 'Hide All', ...
        'MenuSelectedFcn', {@cb_hide_all} ...
        );
end
if (isempty(pr.get('COLS')) && any(cellfun(@(prop) isequal(Element.getPropFormat(it_class, prop), Format.COLOR), num2cell(Element.getProps(it_class))))) ...
        || any(cellfun(@(prop) prop > 0 && isequal(Element.getPropFormat(it_class, prop), Format.COLOR), num2cell(pr.get('COLS'))))
    menu_colorize_table = uimenu( ...
        'Separator', 'on', ...
        'Parent', contextmenu, ...
        'Tag', 'MENU_COLORIZE_TABLE', ...
        'Text', 'Colorize Table', ...
        'Checked', false ...
        );
	set(menu_colorize_table, ...
        'MenuSelectedFcn', {@cb_colorize_table, menu_colorize_table} ...
        );
end
if pr.get('MENU_EXPORT')
    menu_export_to_xls = uimenu( ...
        'Separator', 'on', ...
        'Parent', contextmenu, ...
        'Tag', 'MENU_EXPORT_TO_XLS', ...
        'Text', 'Export to XLS', ...
        'MenuSelectedFcn', {@cb_export_to_xls});
end
if isempty(pr.get('COLS')) || ismember(pr.SELECTOR, pr.get('COLS'))
    set(pr.get('TABLE'), 'ContextMenu', contextmenu)
end

value = contextmenu;
%%%% ¡calculate_callbacks!
function cb_select_all(~, ~) 
    el = pr.get('EL');
    prop = pr.get('PROP');
    it_list = el.get(prop);

    pr.set('SELECTED', [1:1:length(it_list)])

    pr.get('UPDATE')
end
function cb_clear_selection(~, ~) 
    pr.set('SELECTED', [])

    pr.get('UPDATE')
end
function cb_invert_selection(~, ~) 
    el = pr.get('EL');
    prop = pr.get('PROP');
    it_list = el.get(prop);

    selected_tmp = [1:1:length(it_list)];
    selected_tmp(pr.get('SELECTED')) = [];
    pr.set('SELECTED', selected_tmp)

    pr.get('UPDATE')
end
function cb_apply_to_selection(~, ~, menu_apply_to_selection) 
    if get(menu_apply_to_selection, 'Checked')
        set(menu_apply_to_selection, 'Checked', false)
    else
        set(menu_apply_to_selection, 'Checked', true)
	end
end
function cb_open_selection(~, ~) 
    el = pr.get('EL');
    prop = pr.get('PROP');
    it_list = el.get(prop);

    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
    N = ceil(sqrt(length(it_list))); % number of row and columns of figures
    selected = pr.get('SELECTED');

    gui_its_dict = pr.memorize('GUI_ITS_DICT');
    
    for s = 1:1:length(selected)
        i = selected(s);

        it = it_list{i};
        key = int2str(i);
        
        if ~gui_its_dict.get('CONTAINS_KEY', key)
            gui = GUIElement( ...
                'ID', key, ... % the key is the position number of the item in the list
                'PE', it, ... 
                'POSITION', [ ...
                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
                    y0(f, 'normalized') ... % y = f_gr_y / screen_h;
                    w(f, 'normalized') ... % w = f_gr_w / screen_w;
                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
                    ], ...
                'WAITBAR', pr.getCallback('WAITBAR'), ...
                'CLOSEREQ', false ...
                );
            gui_its_dict.get('ADD', gui)
        end
        
        gui = gui_its_dict.get('IT', key);
        if ~gui.get('DRAWN')
            gui.get('DRAW')
        end
        gui.get('SHOW')
    end
end
function cb_hide_selection(~, ~) 
    el = pr.get('EL');
    prop = pr.get('PROP');

    selected = pr.get('SELECTED');
    
    gui_its_dict = pr.memorize('GUI_ITS_DICT');

    for s = 1:1:length(selected)
        key = int2str(selected(s));
        
        if gui_its_dict.get('CONTAINS_KEY', key)
            gui = gui_its_dict.get('IT', key);
            gui.get('HIDE')
        end
    end
end
function cb_hide_all(~, ~) 
    el = pr.get('EL');
    prop = pr.get('PROP');
    it_list = el.get(prop);

    gui_its_dict = pr.memorize('GUI_ITS_DICT');

    for i = 1:1:length(it_list)
        
        key = int2str(i);
        
        if gui_its_dict.get('CONTAINS_KEY', key)
            gui = gui_its_dict.get('IT', key);
            gui.get('HIDE')
        end
    end
end
function cb_colorize_table(~, ~, menu_colorize_table)
    if get(menu_colorize_table, 'Checked')
        set(menu_colorize_table, 'Checked', false)
    else
        set(menu_colorize_table, 'Checked', true)
    end
    pr.get('UPDATE')
end
function cb_export_to_xls(~, ~)
    if isempty(pr.get('SELECTED'))
        el = pr.get('EL');
        prop = pr.get('PROP');
        dict = el.get(prop);

        selected = [1:1:dict.get('LENGTH')];
    else
        selected = pr.get('SELECTED');
    end
    
    % create data table
    data = pr.get('TABLE').Data(selected, :);
    columns = pr.get('TABLE').ColumnName;
    rows = pr.get('TABLE').RowName;
    % special rules: selection column, numbered rownames.
    if isempty(columns{1})
        columns{1} = 'sel';
    end
    if isequal(rows, 'numbered')
        rows = cellfun(@(x) num2str(x), num2cell(selected), 'UniformOutput', false)';
    elseif length(selected) ~= length(rows)
        rows = rows(reshape(selected, [1 length(selected)]));
    end
    
    t = cell2table(data, ...
        'VariableNames', columns, ...
        'RowNames', rows);

    % save file
    [filename, filepath, filterindex] = uiputfile({'*.xlsx';'*.xls'}, 'Select Excel file');
    if filterindex
        file = [filepath filename];
        writetable(t, file, 'WriteRowNames', true);
    end
end

%%% ¡prop!
GUI_ITS_DICT (gui, idict) contains the GUIs for the items.
%%%% ¡settings!
'GUI'

%% ¡tests!

%%% ¡excluded_props!
[PanelPropItemList.PARENT PanelPropItemList.H PanelPropItemList.LISTENER_CB PanelPropItemList.HEIGHT PanelPropItemList.TABLE PanelPropItemList.COLS PanelPropItemList.ROWNAME PanelPropItemList.COLUMNNAME PanelPropItemList.COLUMNWIDTH PanelPropItemList.COLUMNEDITABLE PanelPropItemList.COLUMNFORMAT PanelPropItemList.CONTEXTMENU]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropItemList'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropItemList'])


%TODO Add GTA_IL with relative tests