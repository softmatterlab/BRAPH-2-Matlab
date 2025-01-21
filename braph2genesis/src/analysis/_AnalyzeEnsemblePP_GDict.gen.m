%% ¡header!
AnalyzeEnsemblePP_GDict < PanelProp (pr, graph and measure plot) plots the panel to manage the graph of an ensemble analysis.

%%% ¡description!
AnalyzeEnsemblePP_GDict plots the panel to manage the graph and measures of an ensemble analysis.
It is intended to be used only with the property ME_DICT of AnalyzeEnsemble.

%%% ¡seealso!
uitable, AnalyzeEnsemble, Graph, Measure

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'AnalyzeEnsemblePP_GDict'

%%% ¡prop!
NAME (constant, string) is the name of the graph and measure panel.
%%%% ¡default!
'AnalyzeEnsemblePP_GDict'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the graph and measure panel.
%%%% ¡default!
'AnalyzeEnsemblePP_GDict plots the panel to manage the graph and measures of an ensemble analysis.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the graph and measure panel.
%%%% ¡settings!
'AnalyzeEnsemblePP_GDict'

%%% ¡prop!
ID (data, string) is a few-letter code for the graph and measure panel.
%%%% ¡default!
'AnalyzeEnsemblePP_GDict'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph and measure panel.
%%%% ¡default!
'AnalyzeEnsemblePP_GDict label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph and measure panel.
%%%% ¡default!
'AnalyzeEnsemblePP_GDict'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
AnalyzeEnsemble()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
AnalyzeEnsemble.G_DICT

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
    a = pr.get('EL');
    prop = pr.get('PROP');
    if isa(a.getr('GRAPH_TEMPLATE'), 'NoValue')
        g = a.getPropDefaultConditioned('GRAPH_TEMPLATE'); % default graph
    else
        g = a.get('GRAPH_TEMPLATE'); % actual graph
    end
    
    g_dict = a.get(prop);
    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false);
    
    rowname = cell(length(g_key_list), 1);
    data = cell(length(g_key_list), 3);
    for gi = 1:1:length(g_key_list)
        if any(pr.get('SELECTED') == gi)
            data{gi, 1} = true;
        else
            data{gi, 1} = false;
        end
    
        data{gi, 2} = g_key_list{gi};
        data{gi, 3} = g_dict.get('IT', gi).get('NOTES');
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
    % Graph
    gui_g_dict = pr.get('GUI_G_DICT');
    for i = 1:1:gui_g_dict.get('LENGTH')
        gui = gui_g_dict.get('IT', i);
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
    % Graph
    gui_g_dict = pr.get('GUI_G_DICT');
    for i = 1:1:gui_g_dict.get('LENGTH')
        gui = gui_g_dict.get('IT', i);
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
    % Graph
    gui_g_dict = pr.get('GUI_G_DICT');
    for i = 1:1:gui_g_dict.get('LENGTH')
        gui = gui_g_dict.get('IT', i);
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
    'ColumnName', {'', 'Subject', 'Notes'}, ...
    'ColumnFormat', {'logical',  'char', 'char'}, ...
    'ColumnWidth', {30, 'auto', 'auto'}, ...
    'ColumnEditable', [true false false], ...
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
	'Separator', 'on', ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_SELECT_ALL', ...
    'Text', 'Select All Graphs', ...
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
menu_open_g_pl = uimenu( ...
	'Parent', contextmenu, ...
	'Tag', 'MENU_OPEN_G_PL', ...
	'Text', 'Plot Selected Adjacency Matrices', ...
	'MenuSelectedFcn', {@cb_open_g_pl} ...
	);
menu_hide_g_pl = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_HIDE_G_PL', ...
    'Text', 'Hide Selected Adjacency Matrices', ...
    'MenuSelectedFcn', {@cb_hide_g_pl} ...
	);
menu_open_g_h = uimenu( ...
	'Parent', contextmenu, ...
	'Tag', 'MENU_OPEN_G_H', ...
	'Text', 'Plot Selected Histograms', ...
	'MenuSelectedFcn', {@cb_open_g_h} ...
	);
menu_hide_g_pl = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_HIDE_G_H', ...
    'Text', 'Hide Selected Histograms', ...
    'MenuSelectedFcn', {@cb_hide_g_h} ...
	);
menu_open_g_el = uimenu( ...
	'Separator', 'on', ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_OPEN_G_EL', ...
    'Text', 'Data Selected Graph ...', ...
    'MenuSelectedFcn', {@cb_open_g_el} ...
    );
menu_hide_g_el = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_HIDE_G_EL', ...
    'Text', 'Hide Selected Graph Data', ...
	'MenuSelectedFcn', {@cb_hide_g_el} ...
    );

set(pr.get('TABLE'), 'ContextMenu', contextmenu)

value = contextmenu;
%%%% ¡calculate_callbacks!
function cb_open_g_pl(~, ~)
    a = pr.get('EL');
    g_dict = a.get(pr.get('PROP')); 
    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key

    f = ancestor(pr.get('H'), 'figure'); % parent GUI
    N = ceil(sqrt(length(g_key_list))); % number of row and columns of figures

    selected = pr.get('SELECTED');
    gui_g_dict = pr.memorize('GUI_G_DICT');
    
    for s = 1:1:length(selected)
        i = selected(s);
        g_key = g_key_list{i}; % key for graph
        if ~gui_g_dict.get('CONTAINS_KEY', g_key)
            g = g_dict.get('IT', g_key); % actual graph
            gui = GUIElement( ...
                'ID', g_key, ... % this is the dictionary key for graph
                'PE', g, ...
                'POSITION', [ ...
                x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
                y0(f, 'normalized') ... % y = f_gr_y / screen_h;
                w(f, 'normalized') ... % w = f_gr_w / screen_w;
                .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
                ], ...
                'WAITBAR', pr.getCallback('WAITBAR'), ...
                'CLOSEREQ', false ...
                );
            gui_g_dict.get('ADD', gui)
        end

        gui = gui_g_dict.get('IT', g_key);
        if ~gui.get('DRAWN')
            gui.get('DRAW')
        end

        gui_pfga = gui.get('PE').get('PR_DICT').get('IT', 'PFGA').memorize('GUI_ITEM');
        set(gui_pfga, 'TITLE', ['Adjacency matrices plot - ' g_key]);
        if ~gui_pfga.get('DRAWN')
            gui_pfga.get('DRAW')
        end

        gui_pfga.get('SHOW')
    end
end
function cb_hide_g_pl(~, ~)
    g_dict = pr.get('EL').get(pr.get('PROP'));
    g_key_list =  cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key
    
    gui_g_dict = pr.memorize('GUI_G_DICT');

    selected = pr.get('SELECTED');
    for s = 1:1:length(selected)
        i = selected(s);
        
        g_key = g_key_list{i}; % key for graph
        
        if gui_g_dict.get('CONTAINS_KEY', g_key)
            gui = gui_g_dict.get('IT', g_key);
            gui_pfga = gui.get('PE').get('PR_DICT').get('IT', 'PFGA').memorize('GUI_ITEM');
            if gui.get('DRAWN')
                gui_pfga.get('HIDE')
            end
        end
    end
end
function cb_open_g_h(~, ~)
    a = pr.get('EL');
    g_dict = a.get(pr.get('PROP')); 
    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key

    f = ancestor(pr.get('H'), 'figure'); % parent GUI
    N = ceil(sqrt(length(g_key_list))); % number of row and columns of figures

    selected = pr.get('SELECTED');
    gui_g_dict = pr.memorize('GUI_G_DICT');
    
    for s = 1:1:length(selected)
        i = selected(s);
        g_key = g_key_list{i}; % key for graph
        if ~gui_g_dict.get('CONTAINS_KEY', g_key)
            g = g_dict.get('IT', g_key); % actual graph
            gui = GUIElement( ...
                'ID', g_key, ... % this is the dictionary key for graph
                'PE', g, ...
                'POSITION', [ ...
                x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
                y0(f, 'normalized') ... % y = f_gr_y / screen_h;
                w(f, 'normalized') ... % w = f_gr_w / screen_w;
                .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
                ], ...
                'WAITBAR', pr.getCallback('WAITBAR'), ...
                'CLOSEREQ', false ...
                );
            gui_g_dict.get('ADD', gui)
        end

        gui = gui_g_dict.get('IT', g_key);
        if ~gui.get('DRAWN')
            gui.get('DRAW')
        end

        gui_pfgh = gui.get('PE').get('PR_DICT').get('IT', 'PFGH').memorize('GUI_ITEM');
        set(gui_pfgh, 'TITLE', ['Histograms plot - ' g_key]);
        if ~gui_pfgh.get('DRAWN')
            gui_pfgh.get('DRAW')
        end
        
        gui_pfgh.get('SHOW')
    end
end
function cb_hide_g_h(~, ~)
    g_dict = pr.get('EL').get(pr.get('PROP'));
    g_key_list =  cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key
    
    gui_g_dict = pr.memorize('GUI_G_DICT');

    selected = pr.get('SELECTED');
    for s = 1:1:length(selected)
        i = selected(s);
        
        g_key = g_key_list{i}; % key for graph
        
        if gui_g_dict.get('CONTAINS_KEY', g_key)
            gui = gui_g_dict.get('IT', g_key);
            gui_pfgh = gui.get('PE').get('PR_DICT').get('IT', 'PFGH').memorize('GUI_ITEM');
            if gui.get('DRAWN')
                gui_pfgh.get('HIDE')
            end
        end
    end
end
function cb_open_g_el(~, ~)
    a = pr.get('EL');
    g_dict = a.get(pr.get('PROP'));
    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key
    
    f = ancestor(pr.get('H'), 'figure'); % parent GUI
    N = ceil(sqrt(length(g_key_list))); % number of row and columns of figures
    
    gui_g_dict = pr.memorize('GUI_G_DICT');
    
    selected = pr.get('SELECTED');
    for s = 1:1:length(selected)
        i = selected(s);
    
        g_key = g_key_list{i}; % key for graph
    
        if ~gui_g_dict.get('CONTAINS_KEY', g_key)
            g = g_dict.get('IT', g_key); % actural graph
            gui = GUIElement( ...
                'ID', g_key, ... % this is the dictionary key for graph
                'PE', g, ... 
                'POSITION', [ ...
                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
                    y0(f, 'normalized') ... % y = f_gr_y / screen_h;
                    w(f, 'normalized') ... % w = f_gr_w / screen_w;
                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
                    ], ...
                'WAITBAR', pr.getCallback('WAITBAR'), ...
                'CLOSEREQ', false ...
                );
            gui_g_dict.get('ADD', gui)
        end
        gui = gui_g_dict.get('IT', g_key);
        if ~gui.get('DRAWN')
            gui.get('DRAW')
        end
        gui.get('SHOW')
    end
end
function cb_hide_g_el(~, ~)
    g_dict = pr.get('EL').get(pr.get('PROP'));
    g_key_list =  cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key
    
    gui_g_dict = pr.memorize('GUI_G_DICT');

    selected = pr.get('SELECTED');
    for s = 1:1:length(selected)
        i = selected(s);
        
        g_key = g_key_list{i}; % key for graph
        
        if gui_g_dict.get('CONTAINS_KEY', g_key)
            gui = gui_g_dict.get('IT', g_key);
            if gui.get('DRAWN')
                gui.get('HIDE')
            end
        end
    end
end
function cb_select_all(~, ~) 
    g_dict = pr.get('EL').get(pr.get('PROP'));
    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false);

    pr.set('SELECTED', [1:1:length(g_key_list)])

    pr.get('UPDATE')
end
function cb_clear_selection(~, ~) 
    pr.set('SELECTED', [])

    pr.get('UPDATE')
end
function cb_invert_selection(~, ~) 
    g_dict = pr.get('EL').get(pr.get('PROP'));
    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false);

    selected_tmp = [1:1:length(g_key_list)];
    selected_tmp(pr.get('SELECTED')) = [];
    pr.set('SELECTED', selected_tmp);

    pr.get('UPDATE')
end

%%% ¡prop!
GUI_G_DICT (gui, idict) contains the GUIs for the graph.
%%%% ¡settings!
'GUIElement'
 
%% ¡tests!

%%% ¡excluded_props!
[AnalyzeEnsemblePP_GDict.PARENT AnalyzeEnsemblePP_GDict.H AnalyzeEnsemblePP_GDict.EL AnalyzeEnsemblePP_GDict.LISTENER_CB AnalyzeEnsemblePP_GDict.HEIGHT AnalyzeEnsemblePP_GDict.TABLE AnalyzeEnsemblePP_GDict.CONTEXTMENU]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':AnalyzeEnsemblePP_GDict'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':AnalyzeEnsemblePP_GDict'])