%% ¡header!
NNRegressorMLP_EvaluatorPF_Scatter < PanelFig (pf, panel scatter plot figure) is the panel for scatter plots in a regression task.

%%% ¡description!
The scatter plot panel for an evaluator with a MLP regressor
 (NNRegressorMLP_EvaluatorPF_Scatter) manages the functionalities to plot 
 a panel of the scatter plot in a regression task.

%%% ¡seealso!
NNRegressorMLP_Evaluator

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_EvaluatorPF_Scatter.PREDICTIONS
%%%% ¡title!
PREDICTIONS

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_EvaluatorPF_Scatter.PREDICTION_DICT
%%%% ¡title!
PREDICTION PLOTS

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_EvaluatorPF_Scatter.ID
%%%% ¡title!
Scatter Plot ID

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_EvaluatorPF_Scatter.LABEL
%%%% ¡title!
Scatter Plot NAME

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_EvaluatorPF_Scatter.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_EvaluatorPF_Scatter.NOTES
%%%% ¡title!
Scatter Plot NOTES

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_EvaluatorPF_Scatter.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_EvaluatorPF_Scatter.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_EvaluatorPF_Scatter.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_EvaluatorPF_Scatter.ST_LINE_BASE
%%%% ¡title!
BASE LINE

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_EvaluatorPF_Scatter.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_EvaluatorPF_Scatter.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
NNRegressorMLP_EvaluatorPF_Scatter.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel scatter plot for an evaluator with MLP regressor.
%%%% ¡default!
'NNRegressorMLP_EvaluatorPF_Scatter'

%%% ¡prop!
NAME (constant, string) is the name of the panel scatter plot for an evaluator with a MLP regressor.
%%%% ¡default!
'Scatter Plot Panel for an Evaluator with MLP Regressor'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel scatter plot for an evaluator with a MLP regressor.
%%%% ¡default!
'The scatter plot panel for an evaluator with a MLP regressor (NNRegressorMLP_EvaluatorPF_Scatter) manages the functionalities to plot a panel of the scatter plots in a regression task.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel scatter plot for an evaluator with a MLP regressor.
%%%% ¡settings!
'NNRegressorMLP_EvaluatorPF_Scatter'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel scatter plot for an evaluator with a MLP regressor.
%%%% ¡default!
'NNRegressorMLP_EvaluatorPF_Scatter ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel scatter plot for an evaluator with a MLP regressor.
%%%% ¡default!
'NNRegressorMLP_EvaluatorPF_Scatter label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel scatter plot for an evaluator with a MLP regressor.
%%%% ¡default!
'NNRegressorMLP_EvaluatorPF_Scatter notes'

%%% ¡prop!
DRAW (query, logical) draws the scatter plot figure.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
if value
    pf.memorize('H_AXES')
    
    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', NNRegressorMLP_EvaluatorPF_Scatter.H_AXES).get('SETUP')
    pf.memorize('LISTENER_ST_AXIS');
    
    pf.memorize('H_PREDICTIONS')
    
    pf.memorize('H_LINE_BASE')
    pf.memorize('ST_LINE_BASE').set('PANEL', pf, 'PROP', NNRegressorMLP_EvaluatorPF_Scatter.H_LINE_BASE).get('SETUP')
	pf.memorize('LISTENER_ST_LINE_BASE');

    pf.memorize('H_TITLE')
    pf.memorize('ST_TITLE').set('PANEL', pf, 'PROP', NNRegressorMLP_EvaluatorPF_Scatter.H_TITLE).get('SETUP')

    pf.memorize('H_XLABEL')
    pf.memorize('ST_XLABEL').set('PANEL', pf, 'PROP', NNRegressorMLP_EvaluatorPF_Scatter.H_XLABEL).get('SETUP')
    
    pf.memorize('H_YLABEL')
    pf.memorize('ST_YLABEL').set('PANEL', pf, 'PROP', NNRegressorMLP_EvaluatorPF_Scatter.H_YLABEL).get('SETUP')

    pf.get('SETUP')
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel figure graph is deleted.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
if value
    pf.set('H_AXES', Element.getNoValue())

    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
 
    pf.set('H_PREDICTIONS', Element.getNoValue())

    pf.set('H_LINE_BASE', Element.getNoValue())
    pf.set('LISTENER_ST_LINE_BASE', Element.getNoValue())

    pf.set('H_TITLE', Element.getNoValue())

    pf.set('H_XLABEL', Element.getNoValue())
    
    pf.set('H_YLABEL', Element.getNoValue())
end

%%% ¡prop!
H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
%%%% ¡calculate!
toolbar = pf.memorize('H_TOOLBAR');
if check_graphics(toolbar, 'uitoolbar')
    value = calculateValue@PanelFig(pf, PanelFig.H_TOOLS);
    
    tool_separator_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');

    % Axis
    tool_axis = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Axis', ...
        'Separator', 'on', ...
        'State', pf.get('ST_AXIS').get('AXIS'), ...
        'Tooltip', 'Show axis', ...
        'CData', imread('icon_axis.png'), ...
        'OnCallback', {@cb_axis, true}, ...
        'OffCallback', {@cb_axis, false});

    % Grid
    tool_grid = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Grid', ...
        'State', pf.get('ST_AXIS').get('GRID'), ...
        'Tooltip', 'Show grid', ...
        'CData', imread('icon_grid.png'), ...
        'OnCallback', {@cb_grid, true}, ...
        'OffCallback', {@cb_grid, false});

    tool_separator_2 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
    
    % Prediction Line
    tool_predictions = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Predictions', ...
        'State', pf.get('PREDICTIONS'), ...
        'Tooltip', 'Show Prediction plots', ...
        'CData', imresize(imread('icon_line.png'), [24 24]), ... % % % make icon 16x16
        'OnCallback', {@cb_predictions, true}, ...
        'OffCallback', {@cb_predictions, false});

    % Base Line
    tool_line_base = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Line_CI', ...
        'State', pf.get('ST_LINE_BASE').get('VISIBLE'), ...
        'Tooltip', 'Show base line (slope = 1)', ...
        'CData', imresize(imread('icon_line.png'), [24 24]), ... % % % imread('icon_lines_two.png'), ...
        'OnCallback', {@cb_line_base, true}, ...
        'OffCallback', {@cb_line_base, false});

    value = {value{:}, ...
        tool_separator_1, ...
        tool_axis, tool_grid, ... 
        tool_separator_2, ... 
        tool_predictions, tool_line_base ...
        };
else
    value = {};
end
%%%% ¡calculate_callbacks!
function cb_axis(~, ~, axis) % (src, event)
    pf.get('ST_AXIS').set('AXIS', axis);
    
    % triggers the update of ST_AXIS
    pf.set('ST_AXIS', pf.get('ST_AXIS'))
end
function cb_grid(~, ~, grid) % (src, event)
    pf.get('ST_AXIS').set('GRID', grid);

    % triggers the update of ST_AXIS
    pf.set('ST_AXIS', pf.get('ST_AXIS'))
end
function cb_predictions(~, ~, visible) % (src, event)
	pf.set('PREDICTIONS', visible)
end
function cb_line_base(~, ~, visible) % (src, event)
	pf.get('ST_LINE_BASE').set('VISIBLE', visible)

    % triggers the update of ST_LINE_DIFF
    pf.set('ST_LINE_BASE', pf.get('ST_LINE_BASE'))
end

%% ¡props!

%%% ¡prop!
H_AXES (evanescent, handle) is the handle for the axes.
%%%% ¡calculate!
h_axes = uiaxes( ...
    'Parent', pf.memorize('H'), ...
    'Tag', 'H_AXES', ...
    'Units', 'normalized', ...
    'OuterPosition', [.2 .2 .6 .6] ... % % % %TODO transform this into a prop?
    );
h_axes.Toolbar.Visible = 'off';
h_axes.Interactions = [];
box(h_axes, 'on')
hold(h_axes, 'on')
value = h_axes;

%%% ¡prop!
ST_AXIS (figure, item) determines the axis settings.
%%%% ¡settings!
'SettingsAxis'
%%%% ¡default!
SettingsAxis('AXIS', true, 'GRID', false, 'EQUAL', false)
%%%% ¡postset!
if pf.get('DRAWN')
    toolbar = pf.get('H_TOOLBAR');
    if check_graphics(toolbar, 'uitoolbar')
        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
    end
end
%%%% ¡gui!
pr = SettingsAxisPP('EL', pf, 'PROP', NNRegressorMLP_EvaluatorPF_Scatter.ST_AXIS, varargin{:});

%%% ¡prop!
LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.
%%%% ¡calculate!
value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis); 
%%%% ¡calculate_callbacks!
function cb_listener_st_axis(~, ~)
    if pf.get('DRAWN')
        toolbar = pf.get('H_TOOLBAR');
        if check_graphics(toolbar, 'uitoolbar')
            set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
            set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
        end
    end
end

%%% ¡prop!
NNE (metadata, item) is the neural network evaluator.
%%%% ¡settings!
'NNRegressorMLP_Evaluator'

%%% ¡prop!
PREDICTIONS_VALUE (metadata, matrix) is the predictions value.

%%% ¡prop!
GROUNDTRUTH_VALUE (metadata, matrix) is the ground truth value.

%%% ¡prop!
SETUP (query, empty) calculates the prediction value and ground truth value, and then initializes the panel figure.
%%%% ¡calculate!
pf.memorize('H_PREDICTIONS');

nne = pf.get('NNE');
if isa(pf.getr('PREDICTIONS_VALUE'), 'NoValue') && ~isa(pf.getr('NNE'), 'NoValue')
    predictions = cell2mat(nne.get('NN').get('PREDICT', nne.get('D')));
    pf.set('PREDICTIONS_VALUE', predictions);
end

if isa(pf.getr('GROUNDTRUTH_VALUE'), 'NoValue') && ~isa(pf.getr('NNE'), 'NoValue')
    ground_truth = nne.get('GROUND_TRUTH');
    pf.set('GROUNDTRUTH_VALUE', ground_truth);
end

predictions = pf.get('PREDICTIONS_VALUE');
ground_truth = pf.get('GROUNDTRUTH_VALUE');

pf.memorize('PREDICTION_DICT');

if pf.get('PREDICTIONS')
    pred_st_list = pf.get('PREDICTION_DICT').get('IT_LIST');
    visible_status = find(cell2mat(cellfun(@(pred_st_line) pred_st_line.get('VISIBLE') , pred_st_list,'UniformOutput', false)) == 1);
    if any(visible_status)
        baseline_X = pred_st_list{visible_status(1)}.get('X');
        baseline_Y = pred_st_list{visible_status(1)}.get('X');
    else
        baseline_X = [0];
        baseline_Y = [0];
    end
    pf.memorize('ST_LINE_BASE').set('X', [min(baseline_X) max(baseline_X)], ...
        'Y', [min(baseline_Y) max(baseline_Y)], ...
        'SYMBOL', 'none', ...
        'LINECOLOR', [0.8 0.8 0.8])
end

xlim = pf.get('H_AXES').get('XLim');
ylim = pf.get('H_AXES').get('YLim');
plot_title = nne.get('LABEL');
pf.get('ST_TITLE').set( ...
    'TXT', plot_title, ...
    'X', .5 * (xlim(2) + xlim(1)), ...
    'Y', ylim(2) + .07 * (ylim(2) - ylim(1)), ...
    'Z', 0 ...
    )
pf.get('ST_XLABEL').set( ...
    'TXT', 'Ground Truth', ...
    'X', .5 * (xlim(2) + xlim(1)), ...
    'Y', ylim(1) - .07 * (ylim(2) - ylim(1)), ...
    'Z', 0 ...
    )
pf.get('ST_YLABEL').set( ...
	'TXT', 'Prediction', ...
    'X', xlim(1) - .14 * (xlim(2) - xlim(1)), ...
    'Y', .5 * (ylim(2) + ylim(1)), ...
    'Z', 0 ...
    )

value = [];

%%% ¡prop!
H_PREDICTIONS (evanescent, handlelist) is the set of handles for the prediction plots.
%%%% ¡calculate!
if ~isa(pf.memorize('NNE').getr('D'), 'NoValue')
    targets = pf.memorize('NNE').get('D').get('DP_DICT').get('IT', 1).get('TARGET_IDS');
else
    targets = {};
end
L = length(targets);
h_predictions = cell(1, L);
for i = 1:1:L
    h_predictions{i} = plot(pf.get('H_AXES'), [0], [0], 'x');
end
value = h_predictions;

%%% ¡prop!
PREDICTIONS (figure, logical) determines whether the prediction plot are shown.
%%%% ¡default!
true
%%%% ¡postset!
if ~pf.get('PREDICTIONS') % false
    h_predictions = pf.get('H_PREDICTIONS');
    for i = 1:1:length(h_predictions)
        set(h_predictions{i}, 'Visible', false)
    end
else % true
    % triggers the update of SPH_DICT
    pf.set('PREDICTION_DICT', pf.get('PREDICTION_DICT'))
end

% update state of toggle tool
toolbar = pf.get('H_TOOLBAR');
if check_graphics(toolbar, 'uitoolbar')
    set(findobj(toolbar, 'Tag', 'TOOL.Predictions'), 'State', pf.get('PREDICTIONS'))
end

pf.get('SETUP');

%%% ¡prop!
PREDICTION_DICT (figure, idict) contains the prediction plot for each target.
%%%% ¡settings!
'SettingsLine'
%%%% ¡postset!
if pf.get('PREDICTIONS') && ~isa(pf.getr('NNE'), 'NoValue')
    predictions = pf.memorize('PREDICTIONS_VALUE');
    ground_truth = pf.memorize('GROUNDTRUTH_VALUE');
    if ~isa(pf.memorize('NNE').getr('D'), 'NoValue')
        targets = pf.memorize('NNE').get('D').get('DP_DICT').get('IT', 1).get('TARGET_IDS');
    else
        targets = {};
    end
    if pf.get('PREDICTION_DICT').get('LENGTH') == 0 && ~isempty(ground_truth)
        for i = 1:1:length(targets)
            target = targets{i};
            prediction_st_lines{i} = SettingsLine( ...
                'ID', target, ...
                'X', ground_truth(:, i), ...
                'Y', predictions(:, i), ...
                'I', i, ...
                'PANEL', pf, ...
                'PROP', NNRegressorMLP_EvaluatorPF_Scatter.H_PREDICTIONS, ...
                'LINESTYLE', 'none', ...
                'VISIBLE', false ...
                );
        end
        prediction_st_lines{1}.set('VISIBLE', true);
        pf.get('PREDICTION_DICT').set('IT_LIST', prediction_st_lines)
    end
    for i = 1:1:length(targets)
        pf.get('PREDICTION_DICT').get('IT', i).get('SETUP')
    end
end
%%%% ¡gui!
SETUP = pf.getPropProp('SETUP');
EL = PanelPropIDictTable.getPropProp('EL');
pr = PanelPropIDictTable('EL', pf, 'PROP', NNRegressorMLP_EvaluatorPF_Scatter.PREDICTION_DICT, ...
    'CB_TAB_EDIT', ['cb_table_edit_default(); pr.get(' num2str(EL) ').get(' num2str(SETUP) ')'], ...
    'COLS', [PanelPropIDictTable.SELECTOR SettingsLine.VISIBLE SettingsLine.SYMBOL SettingsLine.SYMBOLSIZE SettingsLine.EDGECOLOR SettingsLine.FACECOLOR], ...
    varargin{:});

%%% ¡prop!
H_LINE_BASE (evanescent, handle) is the handle for the base line.
%%%% ¡calculate!
value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);

%%% ¡prop!
ST_LINE_BASE (figure, item) determines the base line settings.
%%%% ¡settings!
'SettingsLine'
%%%% ¡gui!
pr = SettingsLinePP('EL', pf, 'PROP', NNRegressorMLP_EvaluatorPF_Scatter.ST_LINE_BASE, varargin{:});

%%% ¡prop!
LISTENER_ST_LINE_BASE (evanescent, handle) contains the listener to the base line settings to update the pushbutton.
%%%% ¡calculate!
value = listener(pf.get('ST_LINE_BASE'), 'PropSet', @cb_listener_st_line_base); 
%%%% ¡calculate_callbacks!
function cb_listener_st_line_base(~, ~)
    if pf.get('DRAWN')
        toolbar = pf.get('H_TOOLBAR');
        if check_graphics(toolbar, 'uitoolbar')
            set(findobj(toolbar, 'Tag', 'TOOL.Line_Base'), 'State', pf.get('ST_LINE_BASE').get('VISIBLE'))
        end
    end
end

%%% ¡prop!
H_TITLE (evanescent, handle) is the axis title.
%%%% ¡calculate!
value = title(pf.get('H_AXES'), '');

if isa(pf.getr('ST_TITLE'), 'NoValue')
    st = pf.memorize('ST_TITLE');
    
    position = get(value, 'Position');
    st.set( ...
        'TXT', pf.get('NNE').get('LABEL'), ...
        'X', position(1), ...
        'Y', position(2), ...
        'Z', position(3) ...
        )
end

%%% ¡prop!
ST_TITLE (figure, item) determines the title settings.
%%%% ¡settings!
'SettingsText'
%%%% ¡default!
SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle')
%%%% ¡gui!
pr = SettingsTextPP('EL', pf, 'PROP', NNRegressorMLP_EvaluatorPF_Scatter.ST_TITLE, varargin{:});
%%%% ¡postset!
pf.get('SETUP');

%%% ¡prop!
H_XLABEL (evanescent, handle) is the axis x-label.
%%%% ¡calculate!
value = xlabel(pf.get('H_AXES'), '');

if isa(pf.getr('ST_XLABEL'), 'NoValue')
    st = pf.memorize('ST_XLABEL');
    
    position = get(value, 'Position');
    st.set( ...
        'TXT', 'Layer', ...
        'X', position(1), ...
        'Y', position(2), ...
        'Z', position(3) ...
        )
end

%%% ¡prop!
ST_XLABEL (figure, item) determines the x-label settings.
%%%% ¡settings!
'SettingsText'
%%%% ¡default!
SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle')
%%%% ¡gui!
pr = SettingsTextPP('EL', pf, 'PROP', NNRegressorMLP_EvaluatorPF_Scatter.ST_XLABEL, varargin{:});

%%% ¡prop!
H_YLABEL (evanescent, handle) is the axis y-label.
%%%% ¡calculate!
value = ylabel(pf.get('H_AXES'), '');

if isa(pf.getr('ST_YLABEL'), 'NoValue')
    st = pf.memorize('ST_YLABEL');
    
    position = get(value, 'Position');
    st.set( ...
        'TXT', 'Difference', ...
        'X', position(1), ...
        'Y', position(2), ...
        'Z', position(3) ...
        )
end

%%% ¡prop!
ST_YLABEL (figure, item) determines the y-label settings.
%%%% ¡settings!
'SettingsText'
%%%% ¡default!
SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle', 'ROTATION', 90)
%%%% ¡gui!
pr = SettingsTextPP('EL', pf, 'PROP', NNRegressorMLP_EvaluatorPF_Scatter.ST_YLABEL, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[NNRegressorMLP_EvaluatorPF_Scatter.PARENT NNRegressorMLP_EvaluatorPF_Scatter.H NNRegressorMLP_EvaluatorPF_Scatter.ST_POSITION NNRegressorMLP_EvaluatorPF_Scatter.ST_AXIS NNRegressorMLP_EvaluatorPF_Scatter.H_PREDICTIONS NNRegressorMLP_EvaluatorPF_Scatter.PREDICTIONS_VALUE NNRegressorMLP_EvaluatorPF_Scatter.GROUNDTRUTH_VALUE NNRegressorMLP_EvaluatorPF_Scatter.PREDICTION_DICT NNRegressorMLP_EvaluatorPF_Scatter.LISTENER_ST_LINE_BASE NNRegressorMLP_EvaluatorPF_Scatter.ST_LINE_BASE NNRegressorMLP_EvaluatorPF_Scatter.H_LINE_BASE NNRegressorMLP_EvaluatorPF_Scatter.ST_TITLE NNRegressorMLP_EvaluatorPF_Scatter.ST_XLABEL NNRegressorMLP_EvaluatorPF_Scatter.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':NNRegressorMLP_EvaluatorPF_Scatter'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':NNRegressorMLP_EvaluatorPF_Scatter'])