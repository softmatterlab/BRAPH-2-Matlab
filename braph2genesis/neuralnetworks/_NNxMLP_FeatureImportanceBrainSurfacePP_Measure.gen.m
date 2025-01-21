%% ¡header!
NNxMLP_FeatureImportanceBrainSurfacePP_Measure < PanelProp (pr, panel property feature importance) plots the panel to manage the feature importance of a neural network analysis with graph measures.

%%% ¡description!
A panel for neural networks feature importance analysis with the graph measures of the subjects (NNxMLP_FeatureImportanceBrainSurfacePP_Measure) 
 plots the panel to show the feature importance values, matching the layer number and node number of the graph measures.

%%% ¡seealso!
NNxMLP_FeatureImportanceBrainSurface, NNxMLP_FeatureImportanceBrainSurfacePP_Graph, NNxMLP_FeatureImportanceBrainSurfacePP_Data

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel for feature importance.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurfacePP_Measure'

%%% ¡prop!
NAME (constant, string) is the name of the panel for feature importance.
%%%% ¡default!
'A Panel for Neural Networks Feature Importance'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel for feature importance.
%%%% ¡default!
'A panel for neural networks feature importance analysis with the graph measures of the subjects (NNxMLP_FeatureImportanceBrainSurfacePP_Measure) plots the panel to show the feature importance values, matching the layer number and node number of the graph measures.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel for feature importance.
%%%% ¡settings!
'NNxMLP_FeatureImportanceBrainSurfacePP_Measure'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel for feature importance.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurfacePP_Measure ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel for feature importance.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurfacePP_Measure label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel for feature importance.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurfacePP_Measure notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
NNxMLP_FeatureImportanceBrainSurface()

%%% ¡prop!
PROP (data, scalar) is the prop number.
%%%% ¡default!
NNxMLP_FeatureImportanceBrainSurface.FEATURE_IMPORTANCE

%%% ¡prop!
X_DRAW (query, logical) draws the prop panel.
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

    input_dataset = pr.get('D');
    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
    
    rowname = cell(length(m_list), 1);
    data = cell(length(m_list), 5);
    for mi = 1:1:length(m_list)

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
REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.
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
    % figures for brain figure
    gui_b_dict = pr.get('GUI_B_DICT');
    for i = 1:1:gui_b_dict.get('LENGTH')
        gui = gui_b_dict.get('IT', i);
        if gui.get('DRAWN')
            gui.get('SHOW')
        end
    end
    % element for feature importance
    gui_fi_dict = pr.get('GUI_FI_DICT');
    for i = 1:1:gui_fi_dict.get('LENGTH')
        gui = gui_fi_dict.get('IT', i);
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
    % figures for brain figures
    gui_b_dict = pr.get('GUI_B_DICT');
    for i = 1:1:gui_b_dict.get('LENGTH')
        gui = gui_b_dict.get('IT', i);
        if gui.get('DRAWN')
            gui.get('HIDE')
        end
    end
    % element for feature importance
    gui_fi_dict = pr.get('GUI_FI_DICT');
    for i = 1:1:gui_fi_dict.get('LENGTH')
        gui = gui_fi_dict.get('IT', i);
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
    % figures for brain figures
    gui_b_dict = pr.get('GUI_B_DICT');
    for i = 1:1:gui_b_dict.get('LENGTH')
        gui = gui_b_dict.get('IT', i);
        if gui.get('DRAWN')
            gui.get('CLOSE')
        end
    end
    % element for feature importance
    gui_fi_dict = pr.get('GUI_FI_DICT');
    for i = 1:1:gui_fi_dict.get('LENGTH')
        gui = gui_fi_dict.get('IT', i);
        if gui.get('DRAWN')
            gui.get('CLOSE')
        end
    end
end

%% ¡props!

%%% ¡prop!
D (metadata, item) is the input dataset.
%%%% ¡default!
NNDataset()

%%% ¡prop!
RESHAPED_PROP (data, scalar) is the prop number for the reshaped prop.
%%%% ¡default!
NNxMLP_FeatureImportanceBrainSurface.RESHAPED_FEATURE_IMPORTANCE

%%% ¡prop!
BA (parameter, item) is the brain atlas.
%%%% ¡settings!
'BrainAtlas'

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
menu_open_mbrain = uimenu( ...
	'Separator', 'on', ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_OPEN_MBRAIN', ...
    'Text', 'Plot Selected Measures on Brain ...', ...
    'MenuSelectedFcn', {@cb_open_mbrain} ...
    );
menu_hide_mbrain = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_HIDE_MBRAIN', ...
    'Text', 'Hide Selected Brain-Plots', ...
	'MenuSelectedFcn', {@cb_hide_mbrain} ...
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
    input_dataset = pr.get('D');
    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');

    pr.set('SELECTED', [1:1:length(m_list)])

    pr.get('UPDATE')
end
function cb_clear_selection(~, ~) 
    pr.set('SELECTED', [])

    pr.get('UPDATE')
end
function cb_invert_selection(~, ~) 
    input_dataset = pr.get('D');
    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');

    selected_tmp = [1:1:length(m_list)];
    selected_tmp(pr.get('SELECTED')) = [];
    pr.set('SELECTED', selected_tmp);

    pr.get('UPDATE')
end
function cb_open_mbrain(~, ~)
    input_dataset = pr.get('D');
    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');

    f = ancestor(pr.get('H'), 'figure'); % parent GUI
    N = ceil(sqrt(length(m_list))); % number of row and columns of figures

    gui_b_dict = pr.memorize('GUI_B_DICT');
    selected = pr.get('SELECTED');
    for s = 1:1:length(selected)
        i = selected(s);

        measure = m_list{i}; % also key
        el = pr.get('EL');
        reshaped_prop = pr.get('RESHAPED_PROP');
        values = el.get(reshaped_prop);
        value = values{i};

        if ~gui_b_dict.get('CONTAINS_KEY', measure)

            brain_atlas = el.get('BA'); 
            switch Element.getPropDefault(measure, 'SHAPE')
                case Measure.GLOBAL % __Measure.GLOBAL__
                    switch Element.getPropDefault(measure, 'SCOPE')
                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_GS('FI', value, 'BA', brain_atlas, 'D', input_dataset);
                        case Measure.UNILAYER % __Measure.UNILAYER__
                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_GU('FI', value, 'BA', brain_atlas, 'D', input_dataset);
                        case Measure.BILAYER % __Measure.BILAYER__
                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_GB('FI', value, 'BA', brain_atlas, 'D', input_dataset);
                    end
                case Measure.NODAL % __Measure.NODAL__
                    switch Element.getPropDefault(measure, 'SCOPE')
                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_NS('FI', value, 'BA', brain_atlas, 'D', input_dataset);
                        case Measure.UNILAYER % __Measure.UNILAYER__
                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_NU('FI', value, 'BA', brain_atlas, 'D', input_dataset);
                        case Measure.BILAYER % __Measure.BILAYER__
                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_NB('FI', value, 'BA', brain_atlas, 'D', input_dataset);
                    end
                case Measure.BINODAL % __Measure.BINODAL__
                    switch Element.getPropDefault(measure, 'SCOPE')
                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_BS('FI', value, 'BA', brain_atlas, 'D', input_dataset);
                        case Measure.UNILAYER % __Measure.UNILAYER__
                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_BU('FI', value, 'BA', brain_atlas, 'D', input_dataset);
                        case Measure.BILAYER % __Measure.BILAYER__
                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_BB('FI', value, 'BA', brain_atlas, 'D', input_dataset);
                    end
            end

            gui = GUIFig( ...
                'ID', measure, ... % this is the dictionary key
                'PF', mbfipf, ...
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
    input_dataset = pr.get('D');
    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');

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
function cb_open_elements(~, ~)
    input_dataset = pr.get('D');
    g = input_dataset.get('DP_DICT').get('IT', 1).get('G');
    g.memorize('A'); % memorizing A to get correct ALAYERLABELS

    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
    
    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
    N = ceil(sqrt(length(m_list))); % number of row and columns of figures

    gui_fi_dict = pr.memorize('GUI_FI_DICT');
    
    selected = pr.get('SELECTED');
	for s = 1:1:length(selected)
        i = selected(s);
        
        measure = m_list{i}; % also key
        m_template = g.get('M_DICT').get('IT', measure).get('TEMPLATE');
        
        el = pr.get('EL');
        reshaped_prop = pr.get('RESHAPED_PROP');
        values = el.get(reshaped_prop);
        value = values{i};
        
        fim = NNFeatureImportanceMeasure('G', g, 'M', m_template, 'FI', value);
        
        if ~gui_fi_dict.get('CONTAINS_KEY', measure)
            gui = GUIElement( ...
                'ID', measure, ... % this is the dictionary key
                'PE', fim, ... 
                'POSITION', [ ...
                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
                    y0(f, 'normalized') ... % y = f_gr_y / screen_h;
                    w(f, 'normalized') ... % w = f_gr_w / screen_w;
                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
                    ], ...
                'WAITBAR', pr.getCallback('WAITBAR'), ...
                'CLOSEREQ', false ...
                );
            gui_fi_dict.get('ADD', gui)
        end
        
        gui = gui_fi_dict.get('IT', measure);
        if ~gui.get('DRAWN')
            gui.get('DRAW')
        end
        gui.get('SHOW')
	end
end
function cb_hide_elements(~, ~)
    input_dataset = pr.get('D');
    g = input_dataset.get('DP_DICT').get('IT', 1).get('G');
    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');

    gui_fi_dict = pr.memorize('GUI_FI_DICT');

    selected = pr.get('SELECTED');
    for s = 1:1:length(selected)
        i = selected(s);
        
        measure = m_list{i}; % also key
        
        if gui_fi_dict.get('CONTAINS_KEY', measure)
            gui = gui_fi_dict.get('IT', measure);
            if gui.get('DRAWN')
                gui.get('HIDE')
            end
        end
    end
end

%%% ¡prop!
GUI_B_DICT (gui, idict) contains the GUIs for the brain measures.
%%%% ¡settings!
'GUIFig'

%%% ¡prop!
GUI_FI_DICT (gui, idict) contains the GUIs for the feature measures.
%%%% ¡settings!
'GUIElement'

%% ¡tests!

%%% ¡excluded_props!
[NNxMLP_FeatureImportanceBrainSurfacePP_Measure.PARENT NNxMLP_FeatureImportanceBrainSurfacePP_Measure.H NNxMLP_FeatureImportanceBrainSurfacePP_Measure.LISTENER_CB NNxMLP_FeatureImportanceBrainSurfacePP_Measure.HEIGHT NNxMLP_FeatureImportanceBrainSurfacePP_Measure.TABLE NNxMLP_FeatureImportanceBrainSurfacePP_Measure.CONTEXTMENU]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePP_Measure'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePP_Measure'])