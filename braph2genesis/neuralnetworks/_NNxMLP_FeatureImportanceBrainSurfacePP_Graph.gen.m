%% ¡header!
NNxMLP_FeatureImportanceBrainSurfacePP_Graph < PanelProp (pr, panel property feature importance) plots the panel to manage the feature importance of a neural network analysis with the graph.

%%% ¡description!
A panel for neural networks feature importance analysis with the graph of the subjects (NNxMLP_FeatureImportanceBrainSurfacePP_Graph) 
 plots the panel to show the feature importance values, matching the layer number and node number of the subject graph.

%%% ¡seealso!
NNxMLP_FeatureImportanceBrainSurfacePP, NNxMLP_FeatureImportanceBrainSurfacePP_Measure, NNxMLP_FeatureImportanceBrainSurfacePP_Data

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel for feature importance.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurfacePP_Graph'

%%% ¡prop!
NAME (constant, string) is the name of the panel for feature importance.
%%%% ¡default!
'A Panel for Neural Networks Feature Importance'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel for feature importance.
%%%% ¡default!
'A panel for neural networks feature importance analysis with the graph of the subjects (NNxMLP_FeatureImportanceBrainSurfacePP_Graph) plots the panel to show the feature importance values, matching the layer number and node number of the subject graph.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel for feature importance.
%%%% ¡settings!
'NNxMLP_FeatureImportanceBrainSurfacePP_Graph'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel for feature importance.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurfacePP_Graph ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel for feature importance.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurfacePP_Graph label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel for feature importance.
%%%% ¡default!
'NNxMLP_FeatureImportanceBrainSurfacePP_Graph notes'

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
    
    input_dataset = pr.get('D'); 
    
    if input_dataset.get('DP_DICT').get('LENGTH') == 0
        g = Graph();
    else
        g = input_dataset.get('DP_DICT').get('IT', 1).get('G');
    end
    if g.get('LAYERNUMBER') == 1
        pr.set('TABLE_HEIGHT', s(40), ...
            'XSLIDERSHOW', false, ...
            'YSLIDERSHOW', false, ...
            'ROWNAME', g.getCallback('ANODELABELS'), ...
            'COLUMNNAME', g.getCallback('ANODELABELS'), ...
            varargin{:} ...
            );
    else % multilayer
        pr.set('TABLE_HEIGHT', s(40), ...
            'XYSLIDERLOCK', true, ...
            'XSLIDERSHOW', false, ...
            'YSLIDERSHOW', true, ...
            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'YSLIDERWIDTH', s(5), ...
            'ROWNAME', g.getCallback('ANODELABELS'), ...
            'COLUMNNAME', g.getCallback('ANODELABELS'), ...
            varargin{:});
    end

    rowname = pr.get('ROWNAME');
    if isempty(rowname)
        rowname = 'numbered';
    end
    columnname = pr.get('COLUMNNAME');
    if isempty(rowname)
        columnname = 'numbered';
    end
    set(pr.get('TABLE'), ...
        'RowName', rowname, ...
        'ColumnName', columnname ...
        );

    if el.isLocked(prop)
        set(pr.get('TABLE'), 'Enable', pr.get('ENABLE'))
    end
    
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
end
%%%% ¡calculate_callbacks!
function value = set_sliders_and_get_value()
    reshaped_prop = pr.get('RESHAPED_PROP');
    value = el.get(reshaped_prop);
    
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

%%% ¡prop!
REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.
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
D (metadata, item) is the neural networks dataset.
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
XSLIDERSHOW (gui, logical) determines whether to show the xslider.
%%%% ¡default!
false

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
false

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
        value  = el.get(prop);

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
[NNxMLP_FeatureImportanceBrainSurfacePP_Graph.PARENT NNxMLP_FeatureImportanceBrainSurfacePP_Graph.H NNxMLP_FeatureImportanceBrainSurfacePP_Graph.LISTENER_CB NNxMLP_FeatureImportanceBrainSurfacePP_Graph.HEIGHT NNxMLP_FeatureImportanceBrainSurfacePP_Graph.XSLIDER NNxMLP_FeatureImportanceBrainSurfacePP_Graph.YSLIDER NNxMLP_FeatureImportanceBrainSurfacePP_Graph.TABLE NNxMLP_FeatureImportanceBrainSurfacePP_Graph.CONTEXTMENU NNxMLP_FeatureImportanceBrainSurfacePP_Graph.ROWNAME NNxMLP_FeatureImportanceBrainSurfacePP_Graph.COLUMNNAME NNxMLP_FeatureImportanceBrainSurfacePP_Graph.XSLIDERSHOW NNxMLP_FeatureImportanceBrainSurfacePP_Graph.YSLIDERSHOW NNxMLP_FeatureImportanceBrainSurfacePP_Graph.XSLIDERLABELS NNxMLP_FeatureImportanceBrainSurfacePP_Graph.YSLIDERLABELS NNxMLP_FeatureImportanceBrainSurfacePP_Graph.XSLIDERHEIGHT NNxMLP_FeatureImportanceBrainSurfacePP_Graph.YSLIDERWIDTH NNxMLP_FeatureImportanceBrainSurfacePP_Graph.XYSLIDERLOCK NNxMLP_FeatureImportanceBrainSurfacePP_Graph.TABLE_HEIGHT]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePP_Graph'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':NNxMLP_FeatureImportanceBrainSurfacePP_Graph'])