%% ¡header!
PFGraph < PanelFig (pf, panel figure graph) is a plot of a graph.

%%% ¡description!
% % % PFGraph manages the plot of the single layer graph. 
% % % This class provides the common methods needed to manage the plot of 
% % % the graph. 

%%% ¡seealso!
PanelFig, Graph

%% ¡properties!
p  % handle for panel
h_axes % handle for the axes

%% ¡props!

%%% ¡prop!
G (metadata, item) is the graph.
%%%% ¡settings!
'Graph'

%%% ¡prop!
ST_AXIS (figure, item) determines the axis settings.
%%%% ¡settings!
'SettingsAxis'
%%%% ¡default!
SettingsAxis('GRID', false, 'EQUAL', false)
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('ST_AXIS', varargin)) && check_graphics(pf.h_axes, 'axes')
    % update state of toggle tool
    set(pf.tool_grid, 'State', pf.get('ST_AXIS').get('GRID'))

    % update state of toggle tool
    set(pf.tool_axis, 'State', pf.get('ST_AXIS').get('AXIS'))
end
%%%% ¡gui!
pr = SettingsAxisPP('EL', pf, 'PROP', PFGraph.ST_AXIS, varargin{:});

%%% ¡prop!
ST_COLORMAP (figure, item) determines the colormap settings.
%%%% ¡settings!
'SettingsColormap'
%%%% ¡default!
SettingsColormap('STYLE', 'JET', 'BAR', true)
%%%% ¡gui!
pr = SettingsColormapPP('EL', pf, 'PROP', PFGraph.ST_COLORMAP, varargin{:});

%% ¡methods!
function p_out = draw(pf, varargin)

    pf.p = draw@PanelFig(pf, varargin{:});
    
    % axes
    if ~check_graphics(pf.h_axes, 'axes')
        pf.h_axes = uiaxes( ...
            'Parent', pf.p, ...
            'Tag', 'h_axes', ...
            'Units', 'normalized', ...
            'OuterPosition', [0 0 1 1] ...
            );
        pf.h_axes.Toolbar.Visible = 'off';
        pf.h_axes.Interactions = [];
    end
    
    pf.memorize('ST_AXIS').h(pf.h_axes).set('PANEL', pf, 'UITAG', 'h_axes')
    listener(pf.get('ST_AXIS'), 'PropSet', @cb_st_axis);
    function cb_st_axis(~, ~) % (src, event)
        set(pf.tool_axis, 'State', pf.get('ST_AXIS').get('AXIS'))
        set(pf.tool_grid, 'State', pf.get('ST_AXIS').get('GRID'))
    end
    
    % Toolbar
    if ~check_graphics(pf.toolbar, 'uitoolbar')
        pf.toolbar = findobj(ancestor(pf.p, 'Figure'), 'Tag', 'ToolBar');
    end
    
    if check_graphics(pf.toolbar, 'uitoolbar') && ~check_graphics(pf.tool_axis, 'uitoggletool') % implies that also the other tools are not defined
        
        uipushtool(pf.toolbar, 'Separator', 'on', 'Visible', 'off')

        % Axis
        pf.tool_axis = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_axis', ...
            'State', pf.get('ST_AXIS').get('AXIS'), ...
            'Tooltip', 'Show axis', ...
            'CData', imread('icon_axis.png'), ...
            'OnCallback', {@cb_axis, true}, ...
            'OffCallback', {@cb_axis, false});
        
        % Grid
        pf.tool_grid = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_grid', ...
            'State', pf.get('ST_AXIS').get('GRID'), ...
            'Tooltip', 'Show grid', ...
            'CData', imread('icon_grid.png'), ...
            'OnCallback', {@cb_grid, true}, ...
            'OffCallback', {@cb_grid, false});
    end
    function cb_axis(~, ~, axis) % (src, event)
        pf.get('ST_AXIS').set('AXIS', axis);
    end
    function cb_grid(~, ~, grid) % (src, event)
        pf.get('ST_AXIS').set('GRID', grid);
    end


    % colormap listener
    listener(pf.get('ST_COLORMAP'), 'PropSet', @cb_st_colormap);
    function cb_st_colormap(~, ~) % (src, event)
        set(pf.tool_axis, 'State', pf.get('ST_AXIS').get('AXIS'))        
    end

    % output
    if nargout > 0
        p_out = pf.p;
    end
end
function str = tostring(pf, varargin)
    %TOSTRING string with information about the graph.
    %
    % STR = TOSTRING(PF) returns a string with information about the graph.
    %
    % STR = TOSTRING(PF, N) trims the string to the first N characters.
    %
    % STR = TOSTRING(PF, N, ENDING) ends the string with ENDING if it has
    %  been trimmed.
    %
    % See also disp, tree.

    str = ['Plot ' pf.get('G').get('ID')];
    str = tostring(str, varargin{:});
    str = str(2:1:end-1);
end
function h = plotw(pr, A, varargin)
    % PLOTW plots a weighted matrix
    %
    % H = PLOTW(A) plots the weighted matrix A and returns the handle to
    %   the plot H.
    %
    % H = PLOTW(A,'PropertyName',PropertyValue) sets the property of the
    %   matrix plot PropertyName to PropertyValue.
    %   All standard plot properties of surf can be used.
    %   Additional admissive properties are:
    %       xlabels   -   1:1:number of matrix elements (default)
    %       ylabels   -   1:1:number of matrix elements (default)
    %
    % See also Graph, plotb, surf.

    N = length(A);

    % x labels
    xlabels = (1:1:N);
    for n = 1:2:length(varargin)
        if strcmpi(varargin{n}, 'xlabels')
            xlabels = varargin{n + 1};
        end
    end
    if ~iscell(xlabels)
        xlabels = {xlabels};
    end

    % y labels
    ylabels = (1:1:N);
    for n = 1:2:length(varargin)
        if strcmpi(varargin{n}, 'ylabels')
            ylabels = varargin{n + 1};
        end
    end
    if ~iscell(ylabels)
        ylabels = {ylabels};
    end

    ht = surf('Parent', pr.h_axes, ...
        (0:1:N), ...
        (0:1:N), ...
        [A, zeros(size(A, 1), 1); zeros(1, size(A, 1) + 1)]);
    view(pr.h_axes, 2)
    colorbar(pr.h_axes)
    shading(pr.h_axes, 'flat')
    axis(pr.h_axes, 'equal', 'square', 'tight')
    grid(pr.h_axes, 'off')
    box(pr.h_axes, 'on')
    set(pr.h_axes, ...
        'XAxisLocation', 'top', ...
        'XTick', (1:1:N) - .5, ...
        'XTickLabel', {}, ...
        'YAxisLocation', 'left', ...
        'YDir', 'Reverse', ...
        'YTick', (1:1:N) - .5, ...
        'YTickLabel', ylabels)

    if ~verLessThan('matlab', '8.4.0')
        set(pr.h_axes, ...
            'XTickLabelRotation', 90, ...
            'XTickLabel', xlabels)
    else
        t = text('Parent', pr.h_axes, (1:1:N) - .5, zeros(1, N), xlabels);
        set(t, ...
            'HorizontalAlignment', 'left', ...
            'VerticalAlignment', 'middle', ...
            'Rotation', 90);
    end

    colormap(pr.h_axes, 'jet')

    % output if needed
    if nargout > 0
        h = ht;
    end
end
function h = plotb(pr, A, varargin)
    % PLOTB plots a binary matrix
    %
    % H = PLOTB(A) plots the binarized version of weighted matrix A and
    %   returns the handle to the plot H.
    %   The matrix A can be binarized by fixing the threshold
    %   (default, threshold = 0.5).
    %
    % H = PLOTB(A, 'PropertyName', PropertyValue) sets the property of the
    %   matrix plot PropertyName to PropertyValue.
    %   All standard plot properties of surf can be used.
    %   Additional admissive properties are:
    %       threshold   -   0.5 (default)
    %       xlabels     -   1:1:number of matrix elements (default)
    %       ylabels     -   1:1:number of matrix elements (default)
    %
    % See also Graph, binarize, plotw, surf.

    N = length(A);

    % threshold
    threshold = get_from_varargin(0, 'threshold', varargin{:});

    % density
    density = get_from_varargin([], 'density', varargin{:});

    % x labels
    xlabels = (1:1:N);
    for n = 1:2:length(varargin)
        if strcmpi(varargin{n}, 'xlabels')
            xlabels = varargin{n + 1};
        end
    end
    if ~iscell(xlabels)
        xlabels = {xlabels};
    end

    % y labels
    ylabels = (1:1:N);
    for n = 1:2:length(varargin)
        if strcmpi(varargin{n}, 'ylabels')
            ylabels = varargin{n + 1};
        end
    end
    if ~iscell(ylabels)
        ylabels = {ylabels};
    end

    B = binarize(A, 'threshold', threshold, 'density', density);

    ht = surf('Parent', pr.h_axes, ...
        (0:1:N), ...
        (0:1:N), ...
        [B, zeros(size(B, 1), 1); zeros(1, size(B, 1) + 1)]);
    view(pr.h_axes, 2)
    shading(pr.h_axes, 'flat')
    axis(pr.h_axes, 'equal', 'square', 'tight')
    grid(pr.h_axes, 'off')
    colorbar(pr.h_axes)
    box(pr.h_axes, 'on')
    set(pr.h_axes, ...
        'XAxisLocation', 'top',  ...
        'XTick', (1:1:N) - .5, ...
        'XTickLabel', {},  ...
        'YAxisLocation', 'left',  ...
        'YDir', 'Reverse',  ...
        'YTick', (1:1:N) - .5, ...
        'YTickLabel', ylabels)

    if ~verLessThan('matlab',  '8.4.0')
        set(pr.h_axes, ...
            'XTickLabelRotation',90, ...
            'XTickLabel', xlabels)
    else
        t = text('Parent', pr.h_axes, (1:1:N) - .5, zeros(1,N), xlabels);
        set(t, ...
            'HorizontalAlignment', 'left',  ...
            'VerticalAlignment', 'middle',  ...
            'Rotation',90);
    end

    colormap(pr.h_axes, 'bone')

    % output if needed
    if nargout > 0
        h = ht;
    end
end
function h = hist(pr, A, varargin)
    % HIST plots the histogram and density of a matrix
    %
    % H = HIST(A) plots the histogram of a matrix A and the associated density and
    %   returns the handle to the plot H.
    %
    % H = HIST(A,'PropertyName',PropertyValue) sets the property of the histogram
    %   plot PropertyName to PropertyValue.
    %   All standard plot properties of surf can be used.
    %   Additional admissive properties are:
    %       bins       -   -1:.001:1 (default)
    %       diagonal   -   'exclude' (default) | 'include'
    %
    % See also Graph, histogram.

    [count, bins, density] = histogram(A, varargin{:});

    bins = [bins(1) bins bins(end)];
    count = [0 count 0];
    density = [100 density 0];

    hold(pr.h_axes, 'on')
    cla(pr.h_axes)
    ht1 = fill(pr.h_axes, bins, count, 'k');
    ht2 = plot(bins, density, 'b', 'linewidth', 2, 'Parent', pr.h_axes);
    hold(pr.h_axes, 'off')
    xlabel(pr.h_axes, 'coefficient values / threshold')
    ylabel(pr.h_axes, 'coefficient counts / density')

    grid(pr.h_axes, 'off')
    box(pr.h_axes, 'on')
    colorbar(pr.h_axes, 'off')
    axis(pr.h_axes, 'square', 'tight')
    set(pr.h_axes, ...
        'XAxisLocation', 'bottom',  ...
        'XTickLabelMode', 'auto',  ...
        'XTickMode', 'auto',  ...
        'YTickLabelMode', 'auto',  ...
        'YAxisLocation', 'left',  ...
        'YDir', 'Normal',  ...
        'YTickMode', 'auto',  ...
        'YTickLabelMode', 'auto')

    % output if needed
    if nargout > 0
        h = [ht1 ht2];
    end
end
