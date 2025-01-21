%% ¡header!
AnalyzeGroupPP_G < PanelProp (pr, graph and measure plot) plots the panel to manage the graph and measures of a group analysis.

%%% ¡description!
AnalyzeGroupPP_G plots the panel to manage the graph and measures of a group analysis.
It is intended to be used only with the property G of AnalyzeGroup.

%%% ¡seealso!
uitable, AnalyzeGroup, Graph, Measure

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'AnalyzeGroupPP_G'

%%% ¡prop!
NAME (constant, string) is the name of the graph and measure panel.
%%%% ¡default!
'AnalyzeGroupPP_G'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the graph and measure panel.
%%%% ¡default!
'AnalyzeGroupPP_G plots the panel to manage the graph and measures of a group analysis.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the graph and measure panel.
%%%% ¡settings!
'AnalyzeGroupPP_G'

%%% ¡prop!
ID (data, string) is a few-letter code for the graph and measure panel.
%%%% ¡default!
'AnalyzeGroupPP_G'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph and measure panel.
%%%% ¡default!
'AnalyzeGroupPP_G label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph and measure panel.
%%%% ¡default!
'AnalyzeGroupPP_G'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
AnalyzeGroup()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
AnalyzeGroup.G

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
    if isa(a.getr(prop), 'NoValue')
        g = a.getPropDefaultConditioned(prop); % default graph
    else
        g = a.get(prop); % actual graph
    end

    m_list = g.get('COMPATIBLE_MEASURES');

    if isa(g.getr('M_DICT'), 'NoValue')
        mlist_already_calculated = {};
    else
        mlist_already_calculated = cellfun(@(x) x.get('ELCLASS'), g.get('M_DICT').get('IT_LIST'), 'UniformOutput', false);
    end
    
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

    % figures for brain figure
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

    % figures for brain figures
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

    % figures for brain figures
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
menu_open_g_pl = uimenu( ...
	'Parent', contextmenu, ...
	'Tag', 'MENU_OPEN_G_PL', ...
	'Text', 'Plot Graph Plot ...', ...
	'MenuSelectedFcn', {@cb_open_g_pl} ...
	);

menu_hide_g_pl = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_HIDE_G_PL', ...
    'Text', 'Hide Graph Plot', ...
    'MenuSelectedFcn', {@cb_hide_g_pl} ...
	);
menu_open_g_el = uimenu( ...
	'Separator', 'on', ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_OPEN_G_EL', ...
    'Text', 'Data Graph ...', ...
    'MenuSelectedFcn', {@cb_open_g_el} ...
    );
menu_hide_g_el = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_HIDE_G_EL', ...
    'Text', 'Hide Graph Data', ...
	'MenuSelectedFcn', {@cb_hide_g_el} ...
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
menu_open_mbrain = uimenu( ...
	'Separator', 'on', ...
	'Parent', contextmenu, ...
	'Tag', 'MENU_OPEN_MBRAIN', ...
	'Text', 'Plot Selected Measures on Brain ...', ...
	'MenuSelectedFcn', {@cb_open_mbrain} ... % % %
	);
menu_hide_mbrain = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_HIDE_MBRAIN', ...
    'Text', 'Hide Selected Brain-Plots', ...
    'MenuSelectedFcn', {@cb_hide_mbrain} ... % % %
	);
menu_open_plots = uimenu( ...
	'Parent', contextmenu, ...
	'Tag', 'MENU_OPEN_PLOTS', ...
	'Text', 'Line-Plot Selected Measures ...', ...
	'MenuSelectedFcn', {@cb_open_plots} ...
	);
menu_hide_plots = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_HIDE_PLOTS', ...
    'Text', 'Hide Selected Line-Plots', ...
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
function cb_open_g_pl(~, ~)
    if isa(pr.getr('GUI_G_EL'), 'NoValue')
        f = ancestor(pr.get('H'), 'figure');

        el = pr.get('EL'); % AnalyzeGroup
        prop = pr.get('PROP'); % G

        gui = GUIElement( ...
            'PE', el.memorize(prop), ... % ensure that the property is stored -- this is the graph G
            'POSITION', [ ...
                x0(f, 'normalized')+w(f, 'normalized') ...
                y0(f, 'normalized') ...
                w(f, 'normalized') ...
                h(f, 'normalized') ...
                ], ...
            'WAITBAR', pr.getCallback('WAITBAR'), ...
            'CLOSEREQ', false ...
            );
        
        pr.set('GUI_G_EL', gui)
    else
        gui = pr.get('GUI_G_EL');
    end

    if ~gui.get('DRAWN')
        gui.get('DRAW')
    end

    gui_pfga = gui.get('PE').get('PR_DICT').get('IT', 'PFGA').memorize('GUI_ITEM');
    
    if ~gui_pfga.get('DRAWN')
        gui_pfga.get('DRAW')
    end

    gui_pfga.get('SHOW')
end
function cb_hide_g_pl(~, ~)
    gui = pr.getr('GUI_G_EL');
    gui_pfga = gui.get('PE').get('PR_DICT').get('IT', 'PFGA').memorize('GUI_ITEM');
    
    if gui.get('DRAWN')
        gui_pfga.get('HIDE')
    end
end
function cb_open_g_el(~, ~)
    if isa(pr.getr('GUI_G_EL'), 'NoValue')
        f = ancestor(pr.get('H'), 'figure');

        el = pr.get('EL'); % AnalyzeGroup
        prop = pr.get('PROP'); % G

        gui = GUIElement( ...
            'PE', el.memorize(prop), ... % ensure that the property is stored -- this is the graph G
            'POSITION', [ ...
                x0(f, 'normalized')+w(f, 'normalized') ...
                y0(f, 'normalized') ...
                w(f, 'normalized') ...
                h(f, 'normalized') ...
                ], ...
            'WAITBAR', pr.getCallback('WAITBAR'), ...
            'CLOSEREQ', false ...
            );
        
        pr.set('GUI_G_EL', gui)
    else
        gui = pr.get('GUI_G_EL');
    end

    if ~gui.get('DRAWN')
        gui.get('DRAW')
    end
    gui.get('SHOW')
end
function cb_hide_g_el(~, ~)
    gui = pr.getr('GUI_G_EL');
    if isa(gui, 'GUIElement') && gui.get('DRAWN')
        gui.get('HIDE')
    end
end
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
    g = pr.get('EL').getPropDefaultConditioned(pr.get('PROP')); % default graph
    m_list = g.get('COMPATIBLE_MEASURES');

    selected_tmp = [1:1:length(m_list)];
    selected_tmp(pr.get('SELECTED')) = [];
    pr.set('SELECTED', selected_tmp);

    pr.get('UPDATE')
end
function cb_calculate(~, ~) 
    g = pr.get('EL').get(pr.get('PROP')); % actual graph
    m_list = g.get('COMPATIBLE_MEASURES');
    selected = pr.get('SELECTED');
    
    wb = braph2waitbar(pr.get('WAITBAR'), 0, ['Calculating ' num2str(length(selected))  ' measures ...']);

    for s = 1:1:length(selected)
        measure = m_list{selected(s)};

        braph2waitbar(wb, .1 + s / length(selected), ['Calculating measure ' int2str(s) ' (' measure ') of ' int2str(length(selected)) ' ...'])

        if isa(g.get('MEASURE', measure).getr('M'), 'NoValue')
            g.get('MEASURE', measure).memorize('M');
        end
    end
    
	braph2waitbar(wb, 'close')

	pr.get('UPDATE');
end
function cb_open_mbrain(~, ~)
    g = pr.get('EL').get(pr.get('PROP'));
    m_list = g.get('COMPATIBLE_MEASURES');
    
    f = ancestor(pr.get('H'), 'figure'); % parent GUI
    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
    
    gui_b_dict = pr.memorize('GUI_B_DICT');
    selected = pr.get('SELECTED');
    for s = 1:1:length(selected)
        i = selected(s);
    
        measure = m_list{i}; % also key
    
        m = g.get('MEASURE', measure);
    
        if ~gui_b_dict.get('CONTAINS_KEY', measure)
            gr = pr.get('EL').get('GR');
            if gr.get('SUB_DICT').get('LENGTH')
                sub = gr.get('SUB_DICT').get('IT', 1);
                brain_atlas = sub.get('BA');
            else
                brain_atlas = BrainAtlas();
            end
            brain_atlas = sub.get('BA');
            switch Element.getPropDefault(measure, 'SHAPE')
                case Measure.GLOBAL % __Measure.GLOBAL__
                    switch Element.getPropDefault(measure, 'SCOPE')
                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                            mgbpf = MeasureGroupBrainPF_GS('M', m, 'BA', brain_atlas);
                        case Measure.UNILAYER % __Measure.UNILAYER__
                            mgbpf = MeasureGroupBrainPF_GU('M', m, 'BA', brain_atlas);
                        case Measure.BILAYER % __Measure.BILAYER__
                            mgbpf = MeasureGroupBrainPF_GB('M', m, 'BA', brain_atlas);
                    end
                case Measure.NODAL % __Measure.NODAL__
                    switch Element.getPropDefault(measure, 'SCOPE')
                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                            mgbpf = MeasureGroupBrainPF_NS('M', m, 'BA', brain_atlas);
                        case Measure.UNILAYER % __Measure.UNILAYER__
                            mgbpf = MeasureGroupBrainPF_NU('M', m, 'BA', brain_atlas);
                        case Measure.BILAYER % __Measure.BILAYER__
                            mgbpf = MeasureGroupBrainPF_NB('M', m, 'BA', brain_atlas);
                    end
                case Measure.BINODAL % __Measure.BINODAL__
                    switch Element.getPropDefault(measure, 'SCOPE')
                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                            mgbpf = MeasureGroupBrainPF_BS('M', m, 'BA', brain_atlas);
                        case Measure.UNILAYER % __Measure.UNILAYER__
                            mgbpf = MeasureGroupBrainPF_BU('M', m, 'BA', brain_atlas);
                        case Measure.BILAYER % __Measure.BILAYER__
                            mgbpf = MeasureGroupBrainPF_BB('M', m, 'BA', brain_atlas);
                    end
            end
    
            gui = GUIFig( ...
                'TITLE', ['Brain plot - ' m.get('NAME')], ...
                'ID', measure, ... % this is the dictionary key
                'PF', mgbpf, ...
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
    g = pr.get('EL').getPropDefaultConditioned(pr.get('PROP')); % default graph
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
function cb_open_plots(~, ~)
    g = pr.get('EL').get(pr.get('PROP')); % actual graph
    g.memorize('A'); % memorizing A to get correct ALAYERLABELS
    
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

        gui_pfm = gui.get('PE').get('PR_DICT').get('IT', 'PFM').memorize('GUI_ITEM');
        set(gui_pfm, 'TITLE', ['Line plot - ' m.get('NAME')]);
        if ~gui_pfm.get('DRAWN')
            gui_pfm.get('DRAW')
        end

        gui_pfm.get('SHOW')
	end
end
function cb_hide_plots(~, ~)
    g = pr.get('EL').getPropDefaultConditioned(pr.get('PROP')); % default graph
    m_list = g.get('COMPATIBLE_MEASURES');
    
    gui_m_dict = pr.memorize('GUI_M_DICT');

    selected = pr.get('SELECTED');
    for s = 1:1:length(selected)
        i = selected(s);
        
        measure = m_list{i}; % also key
        
        if gui_m_dict.get('CONTAINS_KEY', measure)
            gui = gui_m_dict.get('IT', measure);
            gui_pfm = gui.get('PE').get('PR_DICT').get('IT', 'PFM').memorize('GUI_ITEM');
            if gui.get('DRAWN')
                gui_pfm.get('HIDE')
            end
        end
    end
end
function cb_open_elements(~, ~)
    g = pr.get('EL').get(pr.get('PROP')); % actual graph
    g.memorize('A'); % memorizing A to get correct ALAYERLABELS
    
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
    g = pr.get('EL').getPropDefaultConditioned(pr.get('PROP')); % default graph
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
GUI_G_EL (gui, item) contains the GUI for the graph.
%%%% ¡settings!
'GUIElement'

%%% ¡prop!
GUI_M_DICT (gui, idict) contains the GUIs for the measures.
%%%% ¡settings!
'GUIElement'

%%% ¡prop!
GUI_B_DICT (gui, idict) contains the GUIs for the brain measures.
%%%% ¡settings!
'GUIFig'

%% ¡tests!

%%% ¡excluded_props!
[AnalyzeGroupPP_G.PARENT AnalyzeGroupPP_G.H AnalyzeGroupPP_G.EL AnalyzeGroupPP_G.LISTENER_CB AnalyzeGroupPP_G.HEIGHT AnalyzeGroupPP_G.TABLE AnalyzeGroupPP_G.CONTEXTMENU]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':AnalyzeGroupPP_G'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':AnalyzeGroupPP_G'])
