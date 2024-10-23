%% ¡header!
NNClassifierMLP_EvaluatorPF_ROC < PanelFig (pf, panel receiver operating characteristic figure) plots a panel of receiver operating characteristic curves.

%%% ¡description!
The receiver operating characteristic panel for an evaluator of MLP classifier 
 (NNClassifierMLP_EvaluatorPF_ROC) manages the functionalities to plot 
 a panel of the receiver operating characteristic curves.

%%% ¡seealso!
NNClassifierMLP_Evaluator

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_EvaluatorPF_ROC.ROC
%%%% ¡title!
Receiver Operating Characteristic

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_EvaluatorPF_ROC.ROC_DICT
%%%% ¡title!
Receiver Operating Characteristic Curves

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_EvaluatorPF_ROC.ID
%%%% ¡title!
Scatter Plot ID

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_EvaluatorPF_ROC.LABEL
%%%% ¡title!
Scatter Plot NAME

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_EvaluatorPF_ROC.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_EvaluatorPF_ROC.NOTES
%%%% ¡title!
Scatter Plot NOTES

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_EvaluatorPF_ROC.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_EvaluatorPF_ROC.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_EvaluatorPF_ROC.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_EvaluatorPF_ROC.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_EvaluatorPF_ROC.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_EvaluatorPF_ROC.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel of the ensemble-based comparison.
%%%% ¡default!
'NNClassifierMLP_EvaluatorPF_ROC'

%%% ¡prop!
NAME (constant, string) is the name of the panel ensemble-based comparison figure.
%%%% ¡default!
'ROC Panel for an Evaluator of MLP Classifier'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel ensemble-based comparison figure.
%%%% ¡default!
'The receiver operating characteristic panel for an evaluator of MLP classifier (NNClassifierMLP_EvaluatorPF_ROC) manages the functionalities to plot a panel of the receiver operating characteristic curves.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel ensemble-based comparison figure.
%%%% ¡settings!
'NNClassifierMLP_EvaluatorPF_ROC'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel ensemble-based comparison figure.
%%%% ¡default!
'NNClassifierMLP_EvaluatorPF_ROC ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel ensemble-based comparison figure.
%%%% ¡default!
'NNClassifierMLP_EvaluatorPF_ROC label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel ensemble-based comparison figure.
%%%% ¡default!
'NNClassifierMLP_EvaluatorPF_ROC notes'

%%% ¡prop!
DRAW (query, logical) draws the receiver operating characteristic figure.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
if value
    pf.memorize('H_AXES')
    
    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', NNClassifierMLP_EvaluatorPF_ROC.H_AXES).get('SETUP')
    pf.memorize('LISTENER_ST_AXIS');
    
    pf.memorize('H_ROC')
    
    pf.memorize('H_TITLE')
    pf.memorize('ST_TITLE').set('PANEL', pf, 'PROP', NNClassifierMLP_EvaluatorPF_ROC.H_TITLE).get('SETUP')

    pf.memorize('H_XLABEL')
    pf.memorize('ST_XLABEL').set('PANEL', pf, 'PROP', NNClassifierMLP_EvaluatorPF_ROC.H_XLABEL).get('SETUP')
    
    pf.memorize('H_YLABEL')
    pf.memorize('ST_YLABEL').set('PANEL', pf, 'PROP', NNClassifierMLP_EvaluatorPF_ROC.H_YLABEL).get('SETUP')

    pf.get('SETUP')
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel figure graph is deleted.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
if value
    pf.set('H_AXES', Element.getNoValue())

    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
 
    pf.set('H_ROC', Element.getNoValue())

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
    tool_roc = uitoggletool(toolbar, ...
        'Tag', 'TOOL.ROC', ...
        'State', pf.get('ROC'), ...
        'Tooltip', 'Show ROC Curves', ...
        'CData', imresize(imread('icon_line.png'), [24 24]), ... % % % make icon 16x16
        'OnCallback', {@cb_roc, true}, ...
        'OffCallback', {@cb_roc, false});

    value = {value{:}, ...
        tool_separator_1, ...
        tool_axis, tool_grid, ... 
        tool_separator_2, ... 
        tool_roc ...
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
function cb_roc(~, ~, visible) % (src, event)
	pf.set('ROC', visible)
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
pr = SettingsAxisPP('EL', pf, 'PROP', NNClassifierMLP_EvaluatorPF_ROC.ST_AXIS, varargin{:});

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
'NNClassifierMLP_Evaluator'

%%% ¡prop!
CLASSNAMES (metadata, stringlist) is the class names.
%%%% ¡postprocessing!
if isa(pf.getr('CLASSNAMES'), 'NoValue') && ~isa(pf.get('NNE').get('NN').getr('MODEL'), 'NoValue')
    pf.set('CLASSNAMES', cellstr(pf.memorize('NNE').get('NN').get('MODEL').Layers(end).Classes));
end

%%% ¡prop!
X_VALUES (metadata, matrix) gets the x values for receiver operating characteristic curves.
%%%% ¡postprocessing!
if isa(pf.getr('X_VALUES'), 'NoValue') && ~isa(pf.get('NNE').get('NN').getr('MODEL'), 'NoValue')
    class_names = pf.get('CLASSNAMES');
    predictions = cell2mat(pf.get('NNE').get('NN').get('PREDICT', pf.get('NNE').get('D')));
    ground_truth = categorical(pf.get('NNE').get('GROUND_TRUTH'));
    rocNet = rocmetrics(ground_truth, predictions, class_names);
    for i = 1:1:length(class_names)
        idx_class = strcmp(rocNet.Metrics.ClassName, class_names{i});
        values(i, :) = rocNet.Metrics(idx_class,:).FalsePositiveRate;
    end
    pf.set('X_VALUES', values);
end
                        
%%% ¡prop!
Y_VALUES (metadata, matrix) gets the y values for receiver operating characteristic curves.
%%%% ¡postprocessing!
if isa(pf.getr('Y_VALUES'), 'NoValue') && ~isa(pf.get('NNE').get('NN').getr('MODEL'), 'NoValue')
    class_names = pf.get('CLASSNAMES');
    predictions = cell2mat(pf.get('NNE').get('NN').get('PREDICT', pf.get('NNE').get('D')));
    ground_truth = categorical(pf.get('NNE').get('GROUND_TRUTH'));
    rocNet = rocmetrics(ground_truth, predictions, class_names);
    for i = 1:1:length(class_names)
        idx_class = strcmp(rocNet.Metrics.ClassName, class_names{i});
        values(i, :) = rocNet.Metrics(idx_class,:).TruePositiveRate;
    end
    pf.set('Y_VALUES', values);
end

%%% ¡prop!
SETUP (query, empty) calculates the the receiver operating characteristic values and initializes the receiver operating characteristic figure.
%%%% ¡calculate!
pf.memorize('H_ROC');

nne = pf.get('NNE');

x_values = pf.get('X_VALUES');
y_values = pf.get('Y_VALUES');

pf.memorize('ROC_DICT');

xlim = pf.get('H_AXES').get('XLim');
ylim = pf.get('H_AXES').get('YLim');
plot_title = 'ROC curves';
pf.get('ST_TITLE').set( ...
    'TXT', plot_title, ...
    'X', .5 * (xlim(2) + xlim(1)), ...
    'Y', ylim(2) + .07 * (ylim(2) - ylim(1)), ...
    'Z', 0 ...
    )
pf.get('ST_XLABEL').set( ...
    'TXT', 'False Positive Rate', ...
    'X', .5 * (xlim(2) + xlim(1)), ...
    'Y', ylim(1) - .07 * (ylim(2) - ylim(1)), ...
    'Z', 0 ...
    )
pf.get('ST_YLABEL').set( ...
	'TXT', 'True Positive Rate', ...
    'X', xlim(1) - .14 * (xlim(2) - xlim(1)), ...
    'Y', .5 * (ylim(2) + ylim(1)), ...
    'Z', 0 ...
    )

value = [];

%%% ¡prop!
H_ROC (evanescent, handlelist) is the set of handles for the ROC plots.
%%%% ¡calculate!
classNames = pf.get('CLASSNAMES');
L = length(classNames);
H_ROC = cell(1, L);
for i = 1:1:L
    H_ROC{i} = plot(pf.get('H_AXES'), [0], [0], 'x');
end
value = H_ROC;

%%% ¡prop!
ROC (figure, logical) determines whether the ROC plots are shown.
%%%% ¡default!
true
%%%% ¡postset!
if ~pf.get('ROC') % false
    h_roc = pf.get('H_ROC');
    for i = 1:1:length(H_ROC)
        set(h_roc{i}, 'Visible', false)
    end
else % true
    % triggers the update of SPH_DICT
    pf.set('ROC_DICT', pf.get('ROC_DICT'))
end

% update state of toggle tool
toolbar = pf.get('H_TOOLBAR');
if check_graphics(toolbar, 'uitoolbar')
    set(findobj(toolbar, 'Tag', 'TOOL.ROC'), 'State', pf.get('ROC'))
end

pf.get('SETUP');

%%% ¡prop!
ROC_DICT (figure, idict) contains the ROC plot for each class.
%%%% ¡settings!
'SettingsLine'
%%%% ¡postset!
if pf.get('ROC') && ~isa(pf.getr('NNE'), 'NoValue')
    x_values = pf.memorize('X_VALUES');
    y_values = pf.memorize('Y_VALUES');
    classNames = pf.get('CLASSNAMES');
    
    if pf.get('ROC_DICT').get('LENGTH') == 0 && ~isempty(classNames)
        for i = 1:1:length(classNames)
            className = classNames{i};
            roc_st_lines{i} = SettingsLine( ...
                'ID', className, ...
                'X', x_values(i, :), ...
                'Y', y_values(i, :), ...
                'I', i, ...
                'PANEL', pf, ...
                'PROP', NNClassifierMLP_EvaluatorPF_ROC.H_ROC, ...
                'LINESTYLE', '--', ...
                'VISIBLE', false ...
                );
        end
        roc_st_lines{1}.set('VISIBLE', true);
        pf.get('ROC_DICT').set('IT_LIST', roc_st_lines)
    end
    for i = 1:1:length(classNames)
        pf.get('ROC_DICT').get('IT', i).get('SETUP')
    end
end
%%%% ¡gui!
SETUP = pf.getPropProp('SETUP');
EL = PanelPropIDictTable.getPropProp('EL');
pr = PanelPropIDictTable('EL', pf, 'PROP', NNClassifierMLP_EvaluatorPF_ROC.ROC_DICT, ...
    'CB_TAB_EDIT', ['cb_table_edit_default(); pr.get(' num2str(EL) ').get(' num2str(SETUP) ')'], ...
    'COLS', [PanelPropIDictTable.SELECTOR SettingsLine.VISIBLE SettingsLine.LINESTYLE SettingsLine.LINECOLOR SettingsLine.LINEWIDTH SettingsLine.SYMBOL SettingsLine.SYMBOLSIZE SettingsLine.EDGECOLOR SettingsLine.FACECOLOR], ...
    varargin{:});

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
pr = SettingsTextPP('EL', pf, 'PROP', NNClassifierMLP_EvaluatorPF_ROC.ST_TITLE, varargin{:});

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
pr = SettingsTextPP('EL', pf, 'PROP', NNClassifierMLP_EvaluatorPF_ROC.ST_XLABEL, varargin{:});

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
pr = SettingsTextPP('EL', pf, 'PROP', NNClassifierMLP_EvaluatorPF_ROC.ST_YLABEL, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[NNClassifierMLP_EvaluatorPF_ROC.PARENT NNClassifierMLP_EvaluatorPF_ROC.H NNClassifierMLP_EvaluatorPF_ROC.ST_POSITION NNClassifierMLP_EvaluatorPF_ROC.ST_AXIS NNClassifierMLP_EvaluatorPF_ROC.H_ROC NNClassifierMLP_EvaluatorPF_ROC.ROC_DICT NNClassifierMLP_EvaluatorPF_ROC.ST_TITLE NNClassifierMLP_EvaluatorPF_ROC.ST_XLABEL NNClassifierMLP_EvaluatorPF_ROC.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':NNClassifierMLP_EvaluatorPF_ROC'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':NNClassifierMLP_EvaluatorPF_ROC'])