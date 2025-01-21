%% ¡header!
GraphHistPF < PanelFig (pf, panel figure for graph histogram) is a plot of a graph histogram.

%%% ¡description!
A Panel Figure for Graph Histogram (GraphHistPF) manages the plot of the histogram of an adjaciency matrix.

%%% ¡seealso!
Graph, GraphAdjPF

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
GraphHistPF.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
GraphHistPF.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
GraphHistPF.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
GraphHistPF.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
GraphHistPF.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
GraphHistPF.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
GraphHistPF.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
GraphHistPF.LAYERS
%%%% ¡title!
LAYERS

%%% ¡prop!
%%%% ¡id!
GraphHistPF.BINS
%%%% ¡title!
BINS

%%% ¡prop!
%%%% ¡id!
GraphHistPF.DIAGONAL
%%%% ¡title!
DIAGONAL IN/OUT

%%% ¡prop!
%%%% ¡id!
GraphHistPF.ST_HIST_AREA
%%%% ¡title!
HISTOGRAM AREA PROPERTIES

%%% ¡prop!
%%%% ¡id!
GraphHistPF.ST_DENSITY_LINE
%%%% ¡title!
DENSITY LINE PROPERTIES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel figure for graph histogram (GraphHistPF).
%%%% ¡default!
'GraphHistPF'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for graph histogram.
%%%% ¡default!
'Panel Figure for Graph Histogram'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for graph histogram.
%%%% ¡default!
'A Panel Figure for Graph Histogram (GraphHistPF) manages the plot of the histogram of an adjaciency matrix.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for graph histogram.
%%%% ¡settings!
'GraphHistPF'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for graph histogram.
%%%% ¡default!
'GraphHistPF ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for graph histogram.
%%%% ¡default!
'GraphHistPF label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for graph histogram.
%%%% ¡default!
'GraphHistPF notes'

%%% ¡prop!
DRAW (query, logical) draws the figure graph histogram.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
if value
    pf.memorize('H_AXES')
    
    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', GraphHistPF.H_AXES).get('SETUP')
    pf.memorize('LISTENER_ST_AXIS');
    
    pf.memorize('H_HIST_AREA')
    pf.memorize('ST_HIST_AREA').set('PANEL', pf, 'PROP', GraphHistPF.H_HIST_AREA).get('SETUP')
    pf.memorize('LISTENER_ST_HIST_AREA');

    pf.memorize('H_DENSITY_LINE')
    pf.memorize('ST_DENSITY_LINE').set('PANEL', pf, 'PROP', GraphHistPF.H_DENSITY_LINE).get('SETUP')
    pf.memorize('LISTENER_ST_DENSITY_LINE');
    
    pf.get('SETUP')
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel figure graph is deleted.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
if value
    pf.set('H_AXES', Element.getNoValue())

    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
    
    pf.set('H_HIST_AREA', Element.getNoValue())
    pf.set('LISTENER_ST_HIST_AREA', Element.getNoValue())
 
    pf.set('H_DENSITY_LINE', Element.getNoValue())
    pf.set('LISTENER_ST_DENSITY_LINE', Element.getNoValue())
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

    % Histogram Area
    tool_hist_area = uitoggletool(toolbar, ...
        'Tag', 'TOOL.HistArea', ...
        'State', pf.get('ST_HIST_AREA').get('VISIBLE'), ...
        'Tooltip', 'Show histogram area', ...
        'CData', imread('icon_area.png'), ...
        'OnCallback', {@cb_hist_area, true}, ...
        'OffCallback', {@cb_hist_area, false});
    
    % Histogram Line
    tool_density_line = uitoggletool(toolbar, ...
        'Tag', 'TOOL.DensityLine', ...
        'State', pf.get('ST_DENSITY_LINE').get('VISIBLE'), ...
        'Tooltip', 'Show density line', ...
        'CData', imread('icon_line.png'), ...
        'OnCallback', {@cb_density_line, true}, ...
        'OffCallback', {@cb_density_line, false});

    value = {value{:}, ...
        tool_separator_1, ...
        tool_axis, tool_grid, ...
        tool_separator_2, ...
        tool_hist_area, tool_density_line ...
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
function cb_hist_area(~, ~, visible) % (src, event)
    pf.get('ST_HIST_AREA').set('VISIBLE', visible)

    % triggers the update of ST_HIST_AREA
    pf.set('ST_HIST_AREA', pf.get('ST_HIST_AREA'))
end
function cb_density_line(~, ~, visible) % (src, event)
	pf.get('ST_DENSITY_LINE').set('VISIBLE', visible)

    % triggers the update of ST_DENSITY_LINE
    pf.set('ST_DENSITY_LINE', pf.get('ST_DENSITY_LINE'))
end

%% ¡props!

%%% ¡prop!
H_AXES (evanescent, handle) is the handle for the axes.
%%%% ¡calculate!
h_axes = uiaxes( ...
    'Parent', pf.memorize('H'), ...
    'Tag', 'H_AXES', ...
    'Units', 'normalized', ...
    'OuterPosition', [0 0 1 1] ...
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
pr = SettingsAxisPP('EL', pf, 'PROP', GraphHistPF.ST_AXIS, varargin{:});

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
pr = LayersPP('EL', pf, 'PROP', GraphHistPF.LAYERS, ...
    'G_PROP', GraphHistPF.G, ...
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

%%% ¡prop!
BINS (figure, rvector) is the vector of bins.
%%%% ¡default!
[-1:.1:1]
%%%% ¡postset!
pf.get('SETUP')
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', pf, 'PROP', GraphHistPF.BINS, 'MAX', 1, 'MIN', -1, varargin{:});

%%% ¡prop!
DIAGONAL (figure, option) excludes or includes the diagonal in the density calculation.
%%%% ¡settings!
{'exclude' 'include'}
%%%% ¡postset!
pf.get('SETUP')

%%% ¡prop!
SETUP (query, empty) calculates the histogram and density and stores them.
%%%% ¡calculate!
A = pf.get('G').get('A');
if numel(A) <= 1
    A = cell2mat(A);
else
    layers = pf.get('LAYERS');
    A = A{layers(1), layers(2)};
end

[count, bins, density] = histogram(A, 'Bins', pf.get('BINS'), 'Diagonal', pf.get('DIAGONAL'));

bins = [bins(1) bins bins(end)];
count = [0 count 0];
count = count / max(count) * 100;
density = [100 density 0];

pf.memorize('ST_HIST_AREA').set('X', bins, 'Y', count)

pf.memorize('ST_DENSITY_LINE').set('X', bins, 'Y', density)

if pf.get('ST_HIST_AREA').get('VISIBLE') && pf.get('ST_DENSITY_LINE').get('VISIBLE')
    xlabel(pf.get('H_AXES'), 'coefficient value / threshold')
    ylabel(pf.get('H_AXES'), 'coefficient percentage / density')
elseif pf.get('ST_HIST_AREA').get('VISIBLE') && ~pf.get('ST_DENSITY_LINE').get('VISIBLE')
    xlabel(pf.get('H_AXES'), 'coefficient value')
    ylabel(pf.get('H_AXES'), 'coefficient percentage')
elseif ~pf.get('ST_HIST_AREA').get('VISIBLE') && pf.get('ST_DENSITY_LINE').get('VISIBLE')
    xlabel(pf.get('H_AXES'), 'threshold')
    ylabel(pf.get('H_AXES'), 'density')
else % ~pf.get('ST_HIST_AREA').get('VISIBLE') && ~pf.get('ST_DENSITY_LINE').get('VISIBLE')
    xlabel(pf.get('H_AXES'), '')
    ylabel(pf.get('H_AXES'), '')
end

value = [];

%%% ¡prop!
H_HIST_AREA (evanescent, handle) is the handle for the histogram area.
%%%% ¡calculate!
value = fill(pf.get('H_AXES'), [0], [0], 'k');

%%% ¡prop!
ST_HIST_AREA (figure, item) determines the area settings.
%%%% ¡settings!
'SettingsArea'
%%%% ¡gui!
pr = SettingsAreaPP('EL', pf, 'PROP', GraphHistPF.ST_HIST_AREA, varargin{:});

%%% ¡prop!
LISTENER_ST_HIST_AREA (evanescent, handle) contains the listener to the histogram area settings to update the pushbutton.
%%%% ¡calculate!
value = listener(pf.get('ST_HIST_AREA'), 'PropSet', @cb_listener_st_hist_area); 
%%%% ¡calculate_callbacks!
function cb_listener_st_hist_area(~, ~)
    if pf.get('DRAWN')
        toolbar = pf.get('H_TOOLBAR');
        if check_graphics(toolbar, 'uitoolbar')
            set(findobj(toolbar, 'Tag', 'TOOL.HistArea'), 'State', pf.get('ST_HIST_AREA').get('VISIBLE'))
        end
    end
end

%%% ¡prop!
H_DENSITY_LINE (evanescent, handle) is the handle for the density line.
%%%% ¡calculate!
value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2, 'MarkerSize', 1);

%%% ¡prop!
ST_DENSITY_LINE (figure, item) determines the line settings.
%%%% ¡settings!
'SettingsLine'
%%%% ¡gui!
pr = SettingsLinePP('EL', pf, 'PROP', GraphHistPF.ST_DENSITY_LINE, varargin{:});

%%% ¡prop!
LISTENER_ST_DENSITY_LINE (evanescent, handle) contains the listener to the density line settings to update the pushbutton.
%%%% ¡calculate!
value = listener(pf.get('ST_DENSITY_LINE'), 'PropSet', @cb_listener_st_density_line); 
%%%% ¡calculate_callbacks!
function cb_listener_st_density_line(~, ~)
    if pf.get('DRAWN')
        toolbar = pf.get('H_TOOLBAR');
        if check_graphics(toolbar, 'uitoolbar')
            set(findobj(toolbar, 'Tag', 'TOOL.DensityLine'), 'State', pf.get('ST_DENSITY_LINE').get('VISIBLE'))
        end
    end
end

%% ¡tests!

%%% ¡excluded_props!
[GraphHistPF.PARENT GraphHistPF.H GraphHistPF.ST_POSITION GraphHistPF.ST_AXIS GraphHistPF.LISTENER_ST_AXIS GraphHistPF.G GraphHistPF.H_HIST_AREA GraphHistPF.ST_HIST_AREA GraphHistPF.LISTENER_ST_HIST_AREA GraphHistPF.H_DENSITY_LINE GraphHistPF.ST_DENSITY_LINE GraphHistPF.LISTENER_ST_DENSITY_LINE]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':GraphHistPF'])
assert(length(findall(0, 'type', 'figure')) == 6)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':GraphHistPF'])
