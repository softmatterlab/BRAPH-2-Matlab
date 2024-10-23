%% ¡header!
GraphAdjPF < PanelFig (pf, panel figure for graph adjacency matrix) is a plot of the panel figure for the graph adjacency matrix.

%%% ¡description!
A Panel Figure for Graph Adjacency Matrix (GraphAdjPF) manages the plot of the panel figure for the adjacency matrix.

%%% ¡seealso!
Graph, GraphAdjPF

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
GraphAdjPF.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
GraphAdjPF.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
GraphAdjPF.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
GraphAdjPF.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
GraphAdjPF.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
GraphAdjPF.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
GraphAdjPF.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
GraphAdjPF.LAYERS
%%%% ¡title!
LAYERS


%%% ¡prop!
%%%% ¡id!
GraphAdjPF.COLORBAR
%%%% ¡title!
COLORBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
GraphAdjPF.ST_AMBIENT
%%%% ¡title!
MATERIAL & LIGHTNING

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel figure for graph adjacency matrix (GraphAdjPF).
%%%% ¡default!
'GraphAdjPF'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for graph adjacency matrix.
%%%% ¡default!
'Panel Figure for Graph Adjacency Matrix'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for graph adjacency matrix.
%%%% ¡default!
'A Panel Figure for Graph Adjacency Matrix (GraphAdjPF) manages the plot of an adjacency matrix.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for graph adjacency matrix.
%%%% ¡settings!
'GraphAdjPF'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for graph adjacency matrix.
%%%% ¡default!
'GraphAdjPF ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for graph adjacency matrix.
%%%% ¡default!
'GraphAdjPF label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for graph adjacency matrix.
%%%% ¡default!
'GraphAdjPF notes'

%%% ¡prop!
DRAW (query, logical) draws the figure graph adjacency matrix.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
if value
    pf.memorize('H_AXES')
    
    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', GraphAdjPF.H_AXES).get('SETUP')
    pf.memorize('LISTENER_ST_AXIS');
    
    pf.memorize('ST_AMBIENT').set('PANEL', pf, 'PROP', GraphAdjPF.H_AXES).get('SETUP')
    
    pf.memorize('H_ADJ')

    pf.get('SETUP')
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel figure graph is deleted.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
if value
    pf.set('H_AXES', Element.getNoValue())

    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
    
    pf.set('H_ADJ', Element.getNoValue())
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
    
% % %     % % Weighted
% % %     % tool_weighted = uitoggletool(toolbar, ...
% % %     %     'Tag', 'TOOL.Weighted', ...
% % %     %     'Separator', 'on', ...
% % %     %     'State', pf.get('WEIGHTED'), ...
% % %     %     'Tooltip', 'Show weighted adjacency matrix', ...
% % %     %     'CData', imread('icon_weighted.png'), ...
% % %     %     'OnCallback', {@cb_weighted, true}, ...
% % %     %     'OffCallback', {@cb_weighted, false});
% % %     % 
% % %     % % Binary
% % %     % tool_binary = uitoggletool(toolbar, ...
% % %     %     'Tag', 'TOOL.Binary', ...
% % %     %     'State', ~pf.get('WEIGHTED'), ...
% % %     %     'Tooltip', 'Show binary adjacency matrix', ...
% % %     %     'CData', imread('icon_binary.png'), ...
% % %     %     'OnCallback', {@cb_weighted, false}, ...
% % %     %     'OffCallback', {@cb_weighted, true});

    % Colormap
    tool_colorbar = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Colormap', ...
        'State', pf.get('COLORBAR'), ...
        'Tooltip', 'Show colorbar', ... 
        'CData', imread('icon_colorbar.png'), ...
        'OnCallback', {@cb_colorbar, true}, ...
        'OffCallback', {@cb_colorbar, false});
    
    value = {value{:}, ...
        tool_separator_1, ...
        tool_axis, tool_grid, ...
        tool_separator_2, tool_colorbar ...
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
function cb_weighted(~, ~, weighted) % (src, event)
    pf.set('WEIGHTED', weighted)
end
function cb_colorbar(~, ~, colorbar) % (src, event)
    pf.set('COLORBAR', colorbar)
end

%% ¡props!

%%% ¡prop!
H_AXES (evanescent, handle) is the handle for the axes.
%%%% ¡calculate!
h_axes = uiaxes( ...
    'Parent', pf.memorize('H'), ...
    'Tag', 'H_AXES', ...
    'Units', 'normalized', ...
    'OuterPosition', [0 0 1 1], ...
    'XAxisLocation', 'top', ...
	'YAxisLocation', 'left', ...
    'YDir', 'Reverse' ...
    );
h_axes.Toolbar.Visible = 'off';
h_axes.Interactions = [];
value = h_axes;

%%% ¡prop!
ST_AXIS (figure, item) determines the axis settings.
%%%% ¡settings!
'SettingsAxis'
%%%% ¡default!
SettingsAxis('GRID', false, 'AXIS', false, 'BOX', true)
%%%% ¡postset!
if pf.get('DRAWN')
    toolbar = pf.get('H_TOOLBAR');
    if check_graphics(toolbar, 'uitoolbar')
        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
    end
end
%%%% ¡gui!
pr = SettingsAxisPP('EL', pf, 'PROP', GraphAdjPF.ST_AXIS, varargin{:});

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
G (metadata, item) is the graph.
%%%% ¡settings!
'Graph'

%%% ¡prop!
LAYERS (figure, rvector) determines the indices of the layers.
%%%% ¡default!
[1 1]
%%%% ¡preset!
if pf.get('LAYERLOCK')
    value = [value(1) value(1)];
end
%%%% ¡postset!
pf.get('SETUP')
%%%% ¡gui!
pr = LayersPP('EL', pf, 'PROP', GraphAdjPF.LAYERS, ...
    'G_PROP', GraphAdjPF.G, ...
    varargin{:});

%%% ¡prop!
LAYERLOCK (metadata, logical) is whether the two layers are locked so that only the diagonal is shown.
%%%% ¡default!
false
%%%% ¡postset!
if pf.get('LAYERLOCK')
    layers = pf.get('LAYERS');
    if layers(1) ~= layers(2)
        pf.set('LAYERS', [layers(1) layers(1)])
    end
end

%%% ¡_prop!
% % % WEIGHTED (figure, logical) determines whether to show the weighted or binary adjacency matrix.
% % % %%%% ¡default!
% % % true
% % % %%%% ¡postset!
% % % if pf.get('DRAWN')
% % %     pf.get('SETUP')
% % %     
% % %     toolbar = pf.get('H_TOOLBAR');
% % %     if check_graphics(toolbar, 'uitoolbar')
% % %         set(findobj(toolbar, 'Tag', 'TOOL.Weighted'), 'State', pf.get('WEIGHTED'))
% % %         set(findobj(toolbar, 'Tag', 'TOOL.Binary'), 'State', ~pf.get('WEIGHTED'))
% % %     end
% % % end

%%% ¡prop!
COLORBAR (figure, logical) detemines whether to show the colorbar.
%%%% ¡default!
true
%%%% ¡postset!
if pf.get('DRAWN')
    if pf.get('COLORBAR')
        colorbar(pf.get('H_AXES'))
    else
        colorbar(pf.get('H_AXES'), 'off')
    end

    toolbar = pf.get('H_TOOLBAR');
    if check_graphics(toolbar, 'uitoolbar')
        set(findobj(toolbar, 'Tag', 'TOOL.Colormap'), 'State', pf.get('COLORBAR'))
    end
end

%%% ¡prop!
ST_AMBIENT (figure, item) determines the ambient settings.
%%%% ¡settings!
'SettingsAmbient'
%%%% ¡default!
SettingsAmbient('LIGHTING', 'none', 'MATERIAL', 'dull', 'CAMLIGHT', 'none', 'SHADING', 'flat', 'COLORMAP', 'jet')
%%%% ¡gui!
pr = SettingsAmbientPP('EL', pf, 'PROP', GraphAdjPF.ST_AMBIENT, varargin{:});

%%% ¡prop!
SETUP (query, empty) calculates the adjacency matrix ans stores it.
%%%% ¡calculate!
A = pf.get('G').get('A');
if numel(A) <= 1
    A = cell2mat(A);
else
    layers = pf.get('LAYERS');
    A = A{layers(1), layers(2)};
end

row_number = size(A, 1);
column_number = size(A, 2);

pf.get('H_ADJ').set( ...
    'XData', (0:1:column_number), ...
    'YData', (0:1:row_number), ...
    'ZData', [A, zeros(row_number, 1); zeros(1, column_number + 1)] ...
    );

pf.set('COLORBAR', pf.get('COLORBAR'))
pf.get('ST_AMBIENT').get('SETUP')

nodelabels = pf.get('G').get('ANODELABELS');
if isequal(nodelabels, {'numbered'})
    nodelabels = 'numbered';
end

set(pf.get('H_AXES'), ...
    'XTickLabelRotation', 90, ...
    'XTick', (1:1:column_number) - .5, ...
    'XTickLabel', nodelabels, ...
    'YTick', (1:1:row_number) - .5, ...    
    'YTickLabels', nodelabels ...
    )

value = [];

%%% ¡prop!
H_ADJ (evanescent, handle) is the handle for weighted adjacency matrix.
%%%% ¡calculate!
value = surf(pf.get('H_AXES'), [], [], []);

%% ¡tests!

%%% ¡excluded_props!
[GraphAdjPF.PARENT GraphAdjPF.H GraphAdjPF.ST_POSITION GraphAdjPF.ST_AXIS GraphAdjPF.LISTENER_ST_AXIS GraphAdjPF.G GraphAdjPF.ST_AMBIENT GraphAdjPF.H_ADJ]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':GraphAdjPF'])
assert(length(findall(0, 'type', 'figure')) == 6)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':GraphAdjPF'])
