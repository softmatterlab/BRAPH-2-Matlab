%% ¡header!
NNClassifierMLP_CrossValidationPF_ROC < PanelFig (pf, panel receiver operating characteristic figure) plots a panel of receiver operating characteristic curves.

%%% ¡description!
The receiver operating characteristic panel for cross-validation MLP classifier 
 (NNClassifierMLP_CrossValidationPF_ROC) manages the functionalities to plot 
 a panel of the receiver operating characteristic curves.

%%% ¡seealso!
NNClassifierMLP_CrossValidation

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidationPF_ROC.ROC
%%%% ¡title!
Receiver Operating Characteristic

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT
%%%% ¡title!
Receiver Operating Characteristic Curves

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidationPF_ROC.ID
%%%% ¡title!
Scatter Plot ID

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidationPF_ROC.LABEL
%%%% ¡title!
Scatter Plot NAME

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidationPF_ROC.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidationPF_ROC.NOTES
%%%% ¡title!
Scatter Plot NOTES

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidationPF_ROC.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidationPF_ROC.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel for receiver operating characteristic figure.
%%%% ¡default!
'NNClassifierMLP_CrossValidationPF_ROC'

%%% ¡prop!
NAME (constant, string) is the name of the panel for receiver operating characteristic figure.
%%%% ¡default!
'ROC Panel for Cross-Validation MLP Classifier'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel for receiver operating characteristic figure.
%%%% ¡default!
'The receiver operating characteristic panel for cross-validation MLP classifier (NNClassifierMLP_CrossValidationPF_ROC) manages the functionalities to plot a panel of the receiver operating characteristic curves.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel for receiver operating characteristic figure.
%%%% ¡settings!
'NNClassifierMLP_CrossValidationPF_ROC'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel for receiver operating characteristic figure.
%%%% ¡default!
'NNClassifierMLP_CrossValidationPF_ROC ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel for receiver operating characteristic figure.
%%%% ¡default!
'NNClassifierMLP_CrossValidationPF_ROC label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel for receiver operating characteristic figure.
%%%% ¡default!
'NNClassifierMLP_CrossValidationPF_ROC notes'

%%% ¡prop!
DRAW (query, logical) draws the receiver operating characteristic figure.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
if value
    if isa(pf.get('NNCV').getr('NN_LIST'), 'NoValue') & ~isa(pf.get('NNCV').getr('D'), 'NoValue')
        pf.get('NNCV').memorize('D_LIST'); % trigger calculation in order to plot
        pf.get('NNCV').memorize('NN_LIST'); % trigger calculation in order to plot
    end
    if isa(pf.get('NNCV').getr('EVALUATOR_LIST'), 'NoValue') & ~isa(pf.get('NNCV').getr('D'), 'NoValue')
        pf.get('NNCV').memorize('EVALUATOR_LIST'); % trigger calculation in order to plot
    end

    pf.memorize('CLASSNAMES');
    pf.memorize('X_VALUES');
    pf.memorize('Y_VALUES');

    pf.memorize('H_AXES')
    pf.memorize('H_ROC');

    pf.memorize('ROC_DICT');
    pf.set('ROC', pf.get('ROC')); 
    
    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.H_AXES).get('SETUP')
    pf.memorize('LISTENER_ST_AXIS');
    
    pf.memorize('H_TITLE')
    pf.memorize('ST_TITLE').set('PANEL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.H_TITLE).get('SETUP')

    pf.memorize('H_XLABEL')
    pf.memorize('ST_XLABEL').set('PANEL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL).get('SETUP')
    
    pf.memorize('H_YLABEL')
    pf.memorize('ST_YLABEL').set('PANEL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL).get('SETUP')

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
pr = SettingsAxisPP('EL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS, varargin{:});

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
NNCV (metadata, item) is the cross-validation.
%%%% ¡settings!
'NNClassifierMLP_CrossValidation'

%%% ¡prop!
CLASSNAMES (metadata, stringlist) is the class names.
%%%% ¡postset!
if isempty(pf.getr('CLASSNAMES')) && ~isa(pf.get('NNCV').getr('NN_LIST'), 'NoValue')
    pf.set('CLASSNAMES', cellstr(pf.memorize('NNCV').get('NN_LIST_IT', 1).get('MODEL').Layers(end).Classes));
end

%%% ¡prop!
X_VALUES (metadata, matrix) gets the x values for receiver operating characteristic curves.
%%%% ¡postset!
if isequal(pf.getr('X_VALUES'), []) && ~isa(pf.get('NNCV').getr('NN_LIST'), 'NoValue')
    class_names = pf.get('CLASSNAMES');
    kfolds = pf.get('NNCV').get('KFOLDS');
    predictions_folds = cellfun(@(nn, nne) cell2mat(nn.get('PREDICT', nne.get('D'))), pf.get('NNCV').get('NN_LIST'), pf.get('NNCV').get('EVALUATOR_LIST'), 'UniformOutput', false);
    ground_truth_folds = cellfun(@(nne) nne.get('GROUND_TRUTH'), pf.get('NNCV').get('EVALUATOR_LIST'), 'UniformOutput', false);
    counter = 0;
    for i = 1:1:kfolds
        predictions_fold = predictions_folds{i};
        ground_truth_fold = ground_truth_folds{i};
        ground_truth_fold = categorical(ground_truth_fold);
        rocNet = rocmetrics(ground_truth_fold, predictions_fold, class_names);
        for j = 1:1:length(class_names)
            counter = counter + 1;
            idx_class = strcmp(rocNet.Metrics.ClassName, class_names{j});
            x_val = rocNet.Metrics(idx_class,:).FalsePositiveRate;
            if counter == 1
                values(counter, :) = x_val;
            else
                x_val_fixed_length = size(values, 2);
                if length(x_val) == x_val_fixed_length
                    values(counter, :) = x_val;
                else % make sure all the x_value have the same length
                    x_val_ind = linspace(1, length(x_val), length(x_val));
                    x_val_new_ind = linspace(1, length(x_val), x_val_fixed_length);
                    x_val_resampled = interp1(x_val_ind, x_val, x_val_new_ind, 'linear');
                    values(counter, :) = x_val_resampled;
                end
            end
        end
    end
    pf.set('X_VALUES', values);
end
                        
%%% ¡prop!
Y_VALUES (metadata, matrix) gets the y values for receiver operating characteristic curves.
%%%% ¡postset!
if isequal(pf.getr('Y_VALUES'), []) && ~isa(pf.get('NNCV').getr('NN_LIST'), 'NoValue')
    class_names = pf.get('CLASSNAMES');
    kfolds = pf.get('NNCV').get('KFOLDS');
    predictions_folds = cellfun(@(nn, nne) cell2mat(nn.get('PREDICT', nne.get('D'))), pf.get('NNCV').get('NN_LIST'), pf.get('NNCV').get('EVALUATOR_LIST'), 'UniformOutput', false);
    ground_truth_folds = cellfun(@(nne) nne.get('GROUND_TRUTH'), pf.get('NNCV').get('EVALUATOR_LIST'), 'UniformOutput', false);
    counter = 0;
    for i = 1:1:kfolds
        predictions_fold = predictions_folds{i};
        ground_truth_fold = ground_truth_folds{i};
        ground_truth_fold = categorical(ground_truth_fold);
        rocNet = rocmetrics(ground_truth_fold, predictions_fold, class_names);
        for j = 1:1:length(class_names)
            counter = counter + 1;
            idx_class = strcmp(rocNet.Metrics.ClassName, class_names{j});
            %values(counter, :) = rocNet.Metrics(idx_class,:).TruePositiveRate;
            y_val = rocNet.Metrics(idx_class,:).TruePositiveRate;
            if counter == 1
                values(counter, :) = y_val;
            else
                y_val_fixed_length = size(values, 2);
                if length(y_val) == y_val_fixed_length
                    values(counter, :) = y_val;
                else % make sure all the y_value have the same length
                    y_val_ind = linspace(1, length(y_val), length(y_val));
                    y_val_new_ind = linspace(1, length(y_val), y_val_fixed_length);
                    y_val_resampled = interp1(y_val_ind, y_val, y_val_new_ind, 'linear');
                    values(counter, :) = y_val_resampled;
                end
            end

        end
    end
    pf.set('Y_VALUES', values);
end

%%% ¡prop!
SETUP (query, empty) initializes the receiver operating characteristic figure.
%%%% ¡calculate!
xlim = pf.get('H_AXES').get('XLim');
ylim = pf.get('H_AXES').get('YLim');

nncv = pf.get('NNCV');
plot_title = 'Mean ROC curve with variability';
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
if ~isempty(pf.get('CLASSNAMES')) && ~isa(pf.getr('NNCV'), 'NoValue')
    class_names = pf.get('CLASSNAMES');
    kfolds = pf.get('NNCV').get('KFOLDS');
    L = length(class_names) * kfolds + 1; % accounting for mean roc curve
    H_ROC = cell(1, L);
    for i = 1:1:L
        H_ROC{i} = plot(pf.get('H_AXES'), [0], [0], 'x');
    end
    value = H_ROC;
else
    value = {};
end

%%% ¡prop!
ROC (figure, logical) determines whether the ROC plots are shown.
%%%% ¡default!
true
%%%% ¡postset!
if ~pf.get('ROC') % false
    h_roc = pf.get('H_ROC');
    for i = 1:1:length(h_roc)
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
ROC_DICT (figure, idict) contains the ROC plots for each class.
%%%% ¡settings!
'SettingsLine'
%%%% ¡postset!
if pf.get('ROC') && ~isa(pf.getr('NNCV'), 'NoValue')
    classNames = pf.memorize('CLASSNAMES');
    kfolds = pf.get('NNCV').get('KFOLDS');
    x_values = pf.memorize('X_VALUES');
    y_values = pf.memorize('Y_VALUES');

    if pf.get('ROC_DICT').get('LENGTH') == 0 && ~isempty(classNames)
        % Add mean ROC first
        roc_st_lines{1} = SettingsLine( ...
            'ID', 'Mean ROC Curve', ...
            'X', mean(x_values, 1), ...
            'Y', mean(y_values, 1), ...
            'I', 1, ...
            'PANEL', pf, ...
            'PROP', NNClassifierMLP_CrossValidationPF_ROC.H_ROC, ...
            'LINESTYLE', '-', ...
            'LINEWIDTH', 3, ...
            'SYMBOL', 'none', ...
            'VISIBLE', false ...
            );
        counter = 1;
        for f = 1:1:kfolds
            for c = 1:1:length(classNames)
                counter = counter + 1;
                className = classNames{c};
                roc_st_lines{counter} = SettingsLine( ...
                    'ID', [className ' Fold ' num2str(f)], ...
                    'X', x_values(counter-1, :), ...
                    'Y', y_values(counter-1, :), ...
                    'I', counter, ...
                    'PANEL', pf, ...
                    'PROP', NNClassifierMLP_CrossValidationPF_ROC.H_ROC, ...
                    'LINESTYLE', '--', ...
                    'LINEWIDTH', 1, ...
                    'LINECOLOR', [0.8 0.8 0.8], ...
                    'SYMBOL', 'none', ...
                    'VISIBLE', false ...
                    );
            end
        end
        roc_st_lines{1}.set('VISIBLE', true);
        pf.get('ROC_DICT').set('IT_LIST', roc_st_lines)
    end
    if ~isempty(classNames)
        for i = 1:1:length(classNames)*kfolds + 1
            pf.get('ROC_DICT').get('IT', i).get('SETUP')
        end
    end
end
%%%% ¡gui!
pr = PanelPropIDictTable('EL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT, ...
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
        'TXT', pf.get('NNCV').get('LABEL'), ...
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
pr = SettingsTextPP('EL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE, varargin{:});

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
pr = SettingsTextPP('EL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL, varargin{:});

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
pr = SettingsTextPP('EL', pf, 'PROP', NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[NNClassifierMLP_CrossValidationPF_ROC.PARENT NNClassifierMLP_CrossValidationPF_ROC.H NNClassifierMLP_CrossValidationPF_ROC.H_ROC NNClassifierMLP_CrossValidationPF_ROC.H_XLABEL  NNClassifierMLP_CrossValidationPF_ROC.H_YLABEL NNClassifierMLP_CrossValidationPF_ROC.ST_POSITION NNClassifierMLP_CrossValidationPF_ROC.ST_AXIS NNClassifierMLP_CrossValidationPF_ROC.H_ROC NNClassifierMLP_CrossValidationPF_ROC.ROC_DICT NNClassifierMLP_CrossValidationPF_ROC.ST_TITLE NNClassifierMLP_CrossValidationPF_ROC.ST_XLABEL NNClassifierMLP_CrossValidationPF_ROC.ST_YLABEL NNClassifierMLP_CrossValidationPF_ROC.H_TITLE NNClassifierMLP_CrossValidationPF_ROC.LISTENER_ST_AXIS NNClassifierMLP_CrossValidationPF_ROC.H_AXES] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':NNClassifierMLP_CrossValidationPF_ROC'])
assert(length(findall(0, 'type', 'figure')) == 6)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':NNClassifierMLP_CrossValidationPF_ROC'])