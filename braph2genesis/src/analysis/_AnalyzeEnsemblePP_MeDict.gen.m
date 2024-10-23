%% ¡header!
AnalyzeEnsemblePP_MeDict < PanelProp (pr, graph and measure plot) plots the panel to manage the graph and measures of an ensemble analysis.

%%% ¡description!
AnalyzeEnsemblePP_MeDict plots the panel to manage the graph and measures of an ensemble analysis.
It is intended to be used only with the property ME_DICT of AnalyzeEnsemble.

%%% ¡seealso!
uitable, AnalyzeEnsemble, Graph, Measure

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'AnalyzeEnsemblePP_MeDict'

%%% ¡prop!
NAME (constant, string) is the name of the graph and measure panel.
%%%% ¡default!
'AnalyzeEnsemblePP_MeDict'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the graph and measure panel.
%%%% ¡default!
'AnalyzeEnsemblePP_MeDict plots the panel to manage the graph and measures of an ensemble analysis.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the graph and measure panel.
%%%% ¡settings!
'AnalyzeEnsemblePP_MeDict'

%%% ¡prop!
ID (data, string) is a few-letter code for the graph and measure panel.
%%%% ¡default!
'AnalyzeEnsemblePP_MeDict'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph and measure panel.
%%%% ¡default!
'AnalyzeEnsemblePP_MeDict label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph and measure panel.
%%%% ¡default!
'AnalyzeEnsemblePP_MeDict'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
AnalyzeEnsemble()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
AnalyzeEnsemble.ME_DICT

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
    
    m_list = g.get('COMPATIBLE_MEASURES');
    
    if isempty(a.getr(prop).get('IT_LIST'))
        m_list_already_calculated = {};
    else
        m_list_already_calculated = cellfun(@(x) x.get('ID'), a.get('ME_DICT').get('IT_LIST'), 'UniformOutput', false);
    end
    
    rowname = cell(length(m_list), 1);
    data = cell(length(m_list), 5);
    for mi = 1:1:length(m_list)
        if any(cellfun(@(y) isequal(m_list{mi}, y), m_list_already_calculated)) && ~isa(a.get('ME_DICT').get('IT', m_list{mi}).getr('M'), 'NoValue')
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
    % figure for graph data
    if isa(pr.getr('GUI_G_EL'), 'GUIElement') && pr.get('GUI_G_EL').get('DRAWN')
        pr.get('GUI_G_EL').get('SHOW')
    end
    
    % figures for measure data
    gui_m_dict = pr.get('GUI_M_DICT');
    for i = 1:1:gui_m_dict.get('LENGTH')
        gui = gui_m_dict.get('IT', i);
        if gui.get('DRAWN')
            gui.get('SHOW')
        end
    end

    % figures for measure data
    gui_b_dict = pr.get('GUI_B_DICT');
    for i = 1:1:gui_b_dict.get('LENGTH')
        gui = gui_b_dict.get('IT', i);
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
    % figure for graph data
    if isa(pr.getr('GUI_G_EL'), 'GUI') && pr.get('GUI_G_EL').get('DRAWN')
        pr.get('GUI_G_EL').get('HIDE')
    end

    % figures for measure data
    gui_m_dict = pr.get('GUI_M_DICT');
    for i = 1:1:gui_m_dict.get('LENGTH')
        gui = gui_m_dict.get('IT', i);
        if gui.get('DRAWN')
            gui.get('HIDE')
        end
    end

    % figures for measure data
    gui_b_dict = pr.get('GUI_B_DICT');
    for i = 1:1:gui_b_dict.get('LENGTH')
        gui = gui_b_dict.get('IT', i);
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
    % figure for graph data
    if isa(pr.getr('GUI_G_EL'), 'GUIElement') && pr.get('GUI_G_EL').get('DRAWN')
        pr.get('GUI_G_EL').get('CLOSE')
    end
    
    % figures for measure data
    gui_m_dict = pr.get('GUI_M_DICT');
    for i = 1:1:gui_m_dict.get('LENGTH')
        gui = gui_m_dict.get('IT', i);
        if gui.get('DRAWN')
            gui.get('CLOSE')
        end
    end

    % figures for measure data
    gui_b_dict = pr.get('GUI_B_DICT');
    for i = 1:1:gui_b_dict.get('LENGTH')
        gui = gui_b_dict.get('IT', i);
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
	'Separator', 'on', ...
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
menu_open_elements = uimenu( ...
	'Separator', 'on', ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_OPEN_ELEMENTS', ...
    'Text', 'Plot Selected Measures on Brain ...', ...
    'MenuSelectedFcn', {@cb_open_mbrain} ...
    );
menu_hide_elements = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_HIDE_ELEMENTS', ...
    'Text', 'Hide Selected Brain-Plots', ...
	'MenuSelectedFcn', {@cb_hide_mbrain} ...
    );

set(pr.get('TABLE'), 'ContextMenu', contextmenu)

value = contextmenu;
%%%% ¡calculate_callbacks!
function cb_select_all(~, ~) 
    g = pr.get('EL').getPropDefaultConditioned(pr.get('PROP'));
    m_list = g.get('COMPATIBLE_MEASURES');

    pr.set('SELECTED', [1:1:length(m_list)])

    pr.get('UPDATE')
end
function cb_clear_selection(~, ~) 
    pr.set('SELECTED', [])

    pr.get('UPDATE')
end
function cb_invert_selection(~, ~) 
    g = pr.get('EL').get('GRAPH_TEMPLATE'); % default graph
    m_list = g.get('COMPATIBLE_MEASURES');

    selected_tmp = [1:1:length(m_list)];
    selected_tmp(pr.get('SELECTED')) = [];
    pr.set('SELECTED', selected_tmp);

    pr.get('UPDATE')
end
function cb_calculate(~, ~) 
    a = pr.get('EL');
    g = a.get('GRAPH_TEMPLATE'); 
    m_list = g.get('COMPATIBLE_MEASURES');
    selected = pr.get('SELECTED');
    
    wb = braph2waitbar(pr.get('WAITBAR'), 0, ['Calculating ' num2str(length(selected))  ' measures ...']);

    for s = 1:1:length(selected)
        measure = m_list{selected(s)};
        me = a.get('MEASUREENSEMBLE', measure);

        braph2waitbar(wb, .1 + s / length(selected), ['Calculating measure ' int2str(s) ' (' measure ') of ' int2str(length(selected)) ' ...'])

        if isa(me.getr('M'), 'NoValue')
            a.get('MEASUREENSEMBLE', measure).memorize('M');
        end
    end
    
	braph2waitbar(wb, 'close')

	pr.get('UPDATE');
end
function cb_open_plots(~, ~)
    a = pr.get('EL');   
    g = a.get('GRAPH_TEMPLATE'); 
    m_list = g.get('COMPATIBLE_MEASURES');
    
    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
    N = ceil(sqrt(length(m_list))); % number of row and columns of figures

    gui_m_dict = pr.memorize('GUI_M_DICT');
    
    selected = pr.get('SELECTED');
	for s = 1:1:length(selected)
        i = selected(s);
        
        measure = m_list{i}; % also key

        me = a.get('MEASUREENSEMBLE', measure);
        
        if ~gui_m_dict.get('CONTAINS_KEY', measure)
            gui = GUIElement( ...
                'ID', measure, ... % this is the dictionary key
                'PE', me, ... %.get('PFME'), ...
                'POSITION', [ ...
                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ...
                    y0(f, 'normalized') ...
                    w(f, 'normalized') ...
                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ...
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
        gui_pfm = gui.get('PE').get('PR_DICT').get('IT', 'PFME').memorize('GUI_ITEM');
        set(gui_pfm, 'TITLE', ['Measure plot - ' g.get('MEASURE', measure).get('NAME')]);
        if ~gui_pfm.get('DRAW')
            gui_pfm.get('DRAW')
        end
        gui_pfm.get('SHOW')
    end
end
function cb_hide_plots(~, ~)
    g = pr.get('EL').get('GRAPH_TEMPLATE'); % default graph
    m_list = g.get('COMPATIBLE_MEASURES');
    
    gui_m_dict = pr.memorize('GUI_M_DICT');

    selected = pr.get('SELECTED');
    for s = 1:1:length(selected)
        i = selected(s);
        
        measure = m_list{i}; % also key
        
        if gui_m_dict.get('CONTAINS_KEY', measure)
            gui = gui_m_dict.get('IT', measure);
            gui_pfm = gui.get('PE').get('PR_DICT').get('IT', 'PFME').memorize('GUI_ITEM');
            if gui.get('DRAWN')
                gui_pfm.get('HIDE')
            end
        end
    end
end
function cb_open_elements(~, ~)
    a = pr.get('EL');    
    g = a.get('GRAPH_TEMPLATE'); % actual graph
    g.memorize('A'); % memorizing A to get correct ALAYERLABELS
    
    m_list = g.get('COMPATIBLE_MEASURES');
    
    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
    N = ceil(sqrt(length(m_list))); % number of row and columns of figures

    gui_m_dict = pr.memorize('GUI_M_DICT');
    
    selected = pr.get('SELECTED');
	for s = 1:1:length(selected)
        i = selected(s);
        
        measure = m_list{i}; % also key

        me = a.get('MEASUREENSEMBLE', measure);
        
        if ~gui_m_dict.get('CONTAINS_KEY', measure)
            gui = GUIElement( ...
                'ID', measure, ... % this is the dictionary key
                'PE', me, ... 
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
    g = pr.get('EL').get('GRAPH_TEMPLATE'); % default graph
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
function cb_open_mbrain(~, ~)
    a = pr.get('EL'); 
    g = a.get('GRAPH_TEMPLATE'); % actual graph
    g.memorize('A'); % memorizing A to get correct ALAYERLABELS
    
    m_list = g.get('COMPATIBLE_MEASURES');

    f = ancestor(pr.get('H'), 'figure'); % parent GUI
    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
    
    gui_b_dict = pr.memorize('GUI_B_DICT');
    selected = pr.get('SELECTED');
    for s = 1:1:length(selected)
        i = selected(s);
    
        measure = m_list{i}; % also key
    
        me = a.get('MEASUREENSEMBLE', measure);
    
        if ~gui_b_dict.get('CONTAINS_KEY', measure)
            gr = a.get('GR');
            if gr.get('SUB_DICT').get('LENGTH')
                sub = gr.get('SUB_DICT').get('IT', 1);
                brain_atlas = sub.get('BA');
            else
                brain_atlas = BrainAtlas();
            end

            switch Element.getPropDefault(measure, 'SHAPE')
                case Measure.GLOBAL % __Measure.GLOBAL__
                    switch Element.getPropDefault(measure, 'SCOPE')
                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                            mebpf = MeasureEnsembleBrainPF_GS('ME', me, 'BA', brain_atlas);
                        case Measure.UNILAYER % __Measure.UNILAYER__
                            mebpf = MeasureEnsembleBrainPF_GU('ME', me, 'BA', brain_atlas);
                        case Measure.BILAYER % __Measure.BILAYER__
                            mebpf = MeasureEnsembleBrainPF_GB('ME', me, 'BA', brain_atlas);
                    end
                case Measure.NODAL % __Measure.NODAL__
                    switch Element.getPropDefault(measure, 'SCOPE')
                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                            mebpf = MeasureEnsembleBrainPF_NS('ME', me, 'BA', brain_atlas);
                        case Measure.UNILAYER % __Measure.UNILAYER__
                            mebpf = MeasureEnsembleBrainPF_NU('ME', me, 'BA', brain_atlas);
                        case Measure.BILAYER % __Measure.BILAYER__
                            mebpf = MeasureEnsembleBrainPF_NB('ME', me, 'BA', brain_atlas);
                    end
                case Measure.BINODAL % __Measure.BINODAL__
                    switch Element.getPropDefault(measure, 'SCOPE')
                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                            mebpf = MeasureEnsembleBrainPF_BS('ME', me, 'BA', brain_atlas);
                        case Measure.UNILAYER % __Measure.UNILAYER__
                            mebpf = MeasureEnsembleBrainPF_BU('ME', me, 'BA', brain_atlas);
                        case Measure.BILAYER % __Measure.BILAYER__
                            mebpf = MeasureEnsembleBrainPF_BB('ME', me, 'BA', brain_atlas);
                    end
            end

            gui = GUIFig( ...
                'TITLE', ['Brain plot - ' g.get('MEASURE', measure).get('NAME')], ...
                'ID', measure, ... % this is the dictionary key
                'PF', mebpf, ... 
                'POSITION', [ ...
                x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ...
                y0(f, 'normalized') ...
                w(f, 'normalized') * 3 ...
                .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ...
                ], ...
                'WAITBAR', pr.getCallback('WAITBAR'), ...
                'CLOSEREQ', false ...
                );
            gui_b_dict.get('ADD', gui)
        end
    
        gui = gui_b_dict.get('IT', measure);
        if ~gui.get('DRAWN')
            gui.get('DRAW')
        end
        gui.get('SHOW')
    end
end
function cb_hide_mbrain(~, ~)
    a = pr.get('EL'); 
    g = a.get('GRAPH_TEMPLATE'); % actual graph
    m_list = g.get('COMPATIBLE_MEASURES');
    
    gui_b_dict = pr.memorize('GUI_B_DICT');
    
    selected = pr.get('SELECTED');
    for s = 1:1:length(selected)
        i = selected(s);
    
        measure = m_list{i}; % also key
    
        if gui_b_dict.get('CONTAINS_KEY', measure)
            gui = gui_b_dict.get('IT', measure);
            if gui.get('DRAWN')
                gui.get('HIDE')
            end
        end
    end
end

%%% ¡prop!
GUI_G_EL (gui, item) contains the GUI for the graph.
%%%% ¡settings!
'GUIElement'

%%% ¡prop!
GUI_M_DICT (gui, idict) contains the GUIs for the measures.
%%%% ¡settings!
'GUIElement'

%%% ¡prop!
GUI_B_DICT (gui, idict) contains the GUIs for the brain surface.
%%%% ¡settings!
'GUIFig'
 
%% ¡tests!

%%% ¡excluded_props!
[AnalyzeEnsemblePP_MeDict.PARENT AnalyzeEnsemblePP_MeDict.H AnalyzeEnsemblePP_MeDict.EL AnalyzeEnsemblePP_MeDict.LISTENER_CB AnalyzeEnsemblePP_MeDict.HEIGHT AnalyzeEnsemblePP_MeDict.TABLE AnalyzeEnsemblePP_MeDict.CONTEXTMENU]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':AnalyzeEnsemblePP_MeDict'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':AnalyzeEnsemblePP_MeDict'])
