%% ¡header!
GraphPP_MDict < PanelProp (pr, measure dictionary plot) plots the measure dictionary property of a graph.

%%% ¡description!
A Measure Dictionary Plot (GraphPP_MDict) plots the panel of the M_DICT property of Graph.
It is intended to be used only with the property M_DICT of Graph.

%%% ¡seealso!
uitable, Graph

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the measure dictionary plot (GraphPP_MDict).
%%%% ¡default!
'GraphPP_MDict'

%%% ¡prop!
NAME (constant, string) is the name of the measure dictionary plot.
%%%% ¡default!
'Measure Dictionary Plot'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the measure dictionary plot.
%%%% ¡default!
'A Measure Dictionary Plot (GraphPP_MDict) plots the panel of the M_DICT property of Graph. It is intended to be used only with the property M_DICT of Graph.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the measure dictionary plot.
%%%% ¡settings!
'GraphPP_MDict'

%%% ¡prop!
ID (data, string) is a few-letter code for the measure dictionary plot.
%%%% ¡default!
'GraphPP_MDict'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the measure dictionary plot.
%%%% ¡default!
'GraphPP_MDict label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the measure dictionary plot.
%%%% ¡default!
'GraphPP_MDict'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
Graph()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
Graph.M_DICT

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
        
	if isa(el.getr(prop), 'NoValue')
        % don't plot anything for a result not yet calculated
        pr.set('HEIGHT', pr.getPropDefault('HEIGHT'))
        set(pr.get('TABLE'), 'Visible', 'off')
    else
        set_table()
        pr.set('HEIGHT', pr.getPropDefault('HEIGHT') + pr.get('TABLE_HEIGHT'))
        set(pr.get('TABLE'), 'Visible', 'on')
    end
end
%%%% ¡calculate_callbacks!
function set_table()
    g = pr.get('EL');

    m_list = g.get('COMPATIBLE_MEASURES');
    mlist_already_calculated = cellfun(@(x) x.get('ID'), g.get('M_DICT').get('IT_LIST'), 'UniformOutput', false);

    rowname = cell(length(m_list), 1);
    data = cell(length(m_list), 5);
    for mi = 1:1:length(m_list)
        if any(cellfun(@(y) isequal(m_list{mi}, y), mlist_already_calculated)) && ~isa(g.get('MEASURE', m_list{mi}).getr('M'), 'NoValue')
            rowname{mi} = 'C';
        else
            rowname{mi} = '';
        end                

        if any(pr.get('SELECTED') == mi)
            data{mi, 1} = true;
        else
            data{mi, 1} = false;
        end

        data{mi, 2} = eval([m_list{mi} '.getPropDefault(''NAME'')']);

        if Element.getPropDefault(m_list{mi}, 'SHAPE') == Measure.NODAL
            data{mi, 3} = 'NODAL';
        elseif Element.getPropDefault(m_list{mi}, 'SHAPE') == Measure.GLOBAL
            data{mi, 3} = 'GLOBAL';
        elseif Element.getPropDefault(m_list{mi}, 'SHAPE') == Measure.BINODAL
            data{mi, 3} = 'BINODAL';
        end

        if Element.getPropDefault(m_list{mi}, 'SCOPE') == Measure.SUPERGLOBAL
            data{mi, 4} = 'SUPERGLOBAL';
        elseif Element.getPropDefault(m_list{mi}, 'SCOPE') == Measure.UNILAYER
            data{mi, 4} = 'UNILAYER';
        elseif Element.getPropDefault(m_list{mi}, 'SCOPE') == Measure.BILAYER
            data{mi, 4} = 'BILAYER';
        end
        
        data{mi, 5} = eval([m_list{mi} '.getPropDefault(''DESCRIPTION'')']);
    end

    set(pr.get('TABLE'), ...
        'RowName', rowname, ...
        'Data', data ...
        )

    % style SELECTED
    styles_row = find(pr.get('TABLE').StyleConfigurations.Target == 'row');
    if ~isempty(styles_row)
        removeStyle(pr.get('TABLE'), styles_row)
    end
    if ~isempty(pr.get('SELECTED'))
        addStyle(pr.get('TABLE'), uistyle('FontWeight', 'bold'), 'row', pr.get('SELECTED'))
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
    % figures for measure figures
    gui_f_dict = pr.get('GUI_F_DICT');
    for i = 1:1:gui_f_dict.get('LENGTH')
        gui = gui_f_dict.get('IT', i);
        if gui.get('DRAWN')
            gui.get('SHOW')
        end
    end
    
    % figures for measure data
    gui_m_dict = pr.get('GUI_M_DICT');
    for i = 1:1:gui_m_dict.get('LENGTH')
        gui = gui_m_dict.get('IT', i);
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
    % figures for measure figures
    gui_f_dict = pr.get('GUI_F_DICT');
    for i = 1:1:gui_f_dict.get('LENGTH')
        gui = gui_f_dict.get('IT', i);
        if gui.get('DRAWN')
            gui.get('HIDE')
        end
    end
    
    % figures for measure data
    gui_m_dict = pr.get('GUI_M_DICT');
    for i = 1:1:gui_m_dict.get('LENGTH')
        gui = gui_m_dict.get('IT', i);
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
    % figures for measure figures
    gui_f_dict = pr.get('GUI_F_DICT');
    for i = 1:1:gui_f_dict.get('LENGTH')
        gui = gui_f_dict.get('IT', i);
        if gui.get('DRAWN')
            gui.get('CLOSE')
        end
    end
    
    % figures for measure data
    gui_m_dict = pr.get('GUI_M_DICT');
    for i = 1:1:gui_m_dict.get('LENGTH')
        gui = gui_m_dict.get('IT', i);
        if gui.get('DRAWN')
            gui.get('CLOSE')
        end
    end
end

%% ¡props!

%%% ¡prop!
TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.
%%%% ¡default!
s(30)

%%% ¡prop!
SELECTED (gui, cvector) is the list of selected items.
%%%% ¡conditioning!
if isrow(value)
    value = value';
end

%%% ¡prop!
TABLE (evanescent, handle) is the table.
%%%% ¡calculate!
table = uitable( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'table', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'ColumnSortable', true, ...
    'ColumnName', {'', 'Measure', 'Shape', 'Scope', 'Notes'}, ...
    'ColumnFormat', {'logical',  'char', 'char', 'char', 'char'}, ...
    'ColumnWidth', {30, 'auto', 'auto', 'auto', 'auto'}, ...
    'ColumnEditable', [true false false false false], ...
    'CellEditCallback', {@cb_table} ...
    );
value = table;
%%%% ¡calculate_callbacks!
function cb_table(~, event) % (src, event)
    % only needs to update the selector

        i = event.Indices(1);
        
        selected = pr.get('SELECTED');
        if event.NewData == 1
            pr.set('SELECTED', sort(unique([selected; i])));
        else
            pr.set('SELECTED', selected(selected ~= i));
        end
        
        pr.get('UPDATE')    
end

%%% ¡prop!
CONTEXTMENU (evanescent, handle) is the context menu.
%%%% ¡calculate!
contextmenu = uicontextmenu( ...
    'Parent', ancestor(pr.get('H'), 'figure'), ...
    'Tag', 'CONTEXTMENU' ...
    );
menu_select_all = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_SELECT_ALL', ...
    'Text', 'Select All Measures', ...
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
menu_calculate = uimenu( ...
	'Separator', 'on', ...
	'Parent', contextmenu, ...
	'Tag', 'MENU_CALCULATE', ...
    'Text', 'Calculate Selected Measures', ...
	'MenuSelectedFcn', {@cb_calculate} ...
    );
menu_open_plots = uimenu( ...
	'Separator', 'on', ...
	'Parent', contextmenu, ...
	'Tag', 'MENU_OPEN_PLOTS', ...
	'Text', 'Plot Selected Measures ...', ...
	'MenuSelectedFcn', {@cb_open_plots} ...
	);
menu_hide_plots = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_HIDE_PLOTS', ...
    'Text', 'Hide Selected Plots', ...
    'MenuSelectedFcn', {@cb_hide_plots} ...
	);
menu_open_elements = uimenu( ...
	'Separator', 'on', ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_OPEN_ELEMENTS', ...
    'Text', 'Data Selected Measures ...', ...
    'MenuSelectedFcn', {@cb_open_elements} ...
    );
menu_hide_elements = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_HIDE_ELEMENTS', ...
    'Text', 'Hide Selected Data', ...
	'MenuSelectedFcn', {@cb_hide_elements} ...
    );

set(pr.get('TABLE'), 'ContextMenu', contextmenu)

value = contextmenu;
%%%% ¡calculate_callbacks!
function cb_select_all(~, ~) 
    g = pr.get('EL');
    m_list = g.get('COMPATIBLE_MEASURES');

    pr.set('SELECTED', [1:1:length(m_list)])

    pr.get('UPDATE')
end
function cb_clear_selection(~, ~) 
    pr.set('SELECTED', [])

    pr.get('UPDATE')
end
function cb_invert_selection(~, ~) 
    g = pr.get('EL');
    m_list = g.get('COMPATIBLE_MEASURES');

    selected_tmp = [1:1:length(m_list)];
    selected_tmp(pr.get('SELECTED')) = [];
    pr.set('SELECTED', selected_tmp);

    pr.get('UPDATE')
end
function cb_calculate(~, ~) 
    g = pr.get('EL');
    m_list = g.get('COMPATIBLE_MEASURES');
    selected = pr.get('SELECTED');
    
    wb = braph2waitbar(pr.get('WAITBAR'), 0, ['Calculating ' num2str(length(selected))  ' measures ...']);

    for i = 1:1:length(m_list)
        if ismember(i, selected)
            measure = m_list{i};

            braph2waitbar(wb, .1 + .9 * i / length(selected), ['Calculating measure ' int2str(i) ' (' measure ') of ' int2str(length(selected)) ' ...'])

            if isa(g.get('MEASURE', measure).getr('M'), 'NoValue')
                g.get('MEASURE', measure).memorize('M');
            end
        end
    end
    
	braph2waitbar(wb, 'close')

	pr.get('UPDATE');
end
function cb_open_plots(~, ~)
    g = pr.get('EL');
    m_list = g.get('COMPATIBLE_MEASURES');
    
    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
    N = ceil(sqrt(length(m_list))); % number of row and columns of figures

    gui_f_dict = pr.memorize('GUI_F_DICT');
    
    selected = pr.get('SELECTED');
	for s = 1:1:length(selected)
        i = selected(s);
        
        measure = m_list{i}; % also key

        m = g.get('MEASURE', measure);
        
        if ~gui_f_dict.get('CONTAINS_KEY', measure)
            gui = GUIFig( ...
                'ID', measure, ... % this is the dictionary key
                'PF', m.get('PFM'), ...
                'POSITION', [ ...
                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ...
                    y0(f, 'normalized') ...
                    w(f, 'normalized') * 3 ...
                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ...
                    ], ...
                'WAITBAR', pr.getCallback('WAITBAR'), ...
                'CLOSEREQ', false ...
                );
            gui_f_dict.get('ADD', gui)
        end
        
        gui = gui_f_dict.get('IT', measure);
        if ~gui.get('DRAWN')
            gui.get('DRAW')
        end
        gui.get('SHOW')
    end
end
function cb_hide_plots(~, ~)
    g = pr.get('EL');
    m_list = g.get('COMPATIBLE_MEASURES');
    
    gui_f_dict = pr.memorize('GUI_F_DICT');

    selected = pr.get('SELECTED');
    for s = 1:1:length(selected)
        i = selected(s);
        
        measure = m_list{i}; % also key
        
        if gui_f_dict.get('CONTAINS_KEY', measure)
            gui = gui_f_dict.get('IT', measure);
            if gui.get('DRAWN')
                gui.get('HIDE')
            end
        end
    end
end
function cb_open_elements(~, ~)
    g = pr.get('EL');
    m_list = g.get('COMPATIBLE_MEASURES');
    
    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
    N = ceil(sqrt(length(m_list))); % number of row and columns of figures

    gui_m_dict = pr.memorize('GUI_M_DICT');
    
    selected = pr.get('SELECTED');
	for s = 1:1:length(selected)
        i = selected(s);
        
        measure = m_list{i}; % also key

        m = g.get('MEASURE', measure);
        
        if ~gui_m_dict.get('CONTAINS_KEY', measure)
            gui = GUIElement( ...
                'ID', measure, ... % this is the dictionary key
                'PE', m, ... 
                'POSITION', [ ...
                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
                    y0(f, 'normalized') ... % y = f_gr_y / screen_h;
                    w(f, 'normalized') ... % w = f_gr_w / screen_w;
                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
                    ], ...
                'WAITBAR', pr.getCallback('WAITBAR'), ...
                'CLOSEREQ', false ...
                );
            gui_m_dict.get('ADD', gui)
        end
        
        gui = gui_m_dict.get('IT', measure);
        if ~gui.get('DRAWN')
            gui.get('DRAW')
        end
        gui.get('SHOW')
	end
end
function cb_hide_elements(~, ~)
    g = pr.get('EL');
    m_list = g.get('COMPATIBLE_MEASURES');
    
    gui_m_dict = pr.memorize('GUI_M_DICT');

    selected = pr.get('SELECTED');
    for s = 1:1:length(selected)
        i = selected(s);
        
        measure = m_list{i}; % also key
        
        if gui_m_dict.get('CONTAINS_KEY', measure)
            gui = gui_m_dict.get('IT', measure);
            if gui.get('DRAWN')
                gui.get('HIDE')
            end
        end
    end
end

%%% ¡prop!
GUI_F_DICT (gui, idict) contains the GUIs for the measure figures.
%%%% ¡settings!
'GUIFig'

%%% ¡prop!
GUI_M_DICT (gui, idict) contains the GUIs for the measures.
%%%% ¡settings!
'GUIElement'
 
%% ¡tests!

%%% ¡excluded_props!
[GraphPP_MDict.PARENT GraphPP_MDict.H GraphPP_MDict.EL GraphPP_MDict.LISTENER_CB GraphPP_MDict.HEIGHT GraphPP_MDict.TABLE GraphPP_MDict.CONTEXTMENU]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':GraphPP_MDict'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':GraphPP_MDict'])
