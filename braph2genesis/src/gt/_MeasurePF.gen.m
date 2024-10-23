%% ¡header!
MeasurePF < PanelFig (pf, panel figure for measure) is the base element to plot the panel figure of the measure.

%%% ¡description!
A Panel Figure for Measure (MeasurePF) manages the basic functionalities to plot the panel figure of a measure.

%%% ¡seealso!
Measure

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasurePF.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
MeasurePF.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
MeasurePF.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasurePF.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
MeasurePF.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
MeasurePF.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
MeasurePF.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
MeasurePF.ST_AREA
%%%% ¡title!
FILLED AREA

%%% ¡prop!
%%%% ¡id!
MeasurePF.ST_LINE
%%%% ¡title!
MEASURE LINE

%%% ¡prop!
%%%% ¡id!
MeasurePF.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
MeasurePF.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
MeasurePF.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel figure for measure (MeasurePF).
%%%% ¡default!
'MeasurePF'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for measure.
%%%% ¡default!
'Panel Figure for Measure'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for measure.
%%%% ¡default!
'A Panel Figure for Measure (MeasurePF) manages the basic functionalities to plot of a measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for measure.
%%%% ¡settings!
'MeasurePF'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for measure.
%%%% ¡default!
'MeasurePF ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for measure.
%%%% ¡default!
'MeasurePF label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for measure.
%%%% ¡default!
'MeasurePF notes'

%%% ¡prop!
DRAW (query, logical) draws the figure measure.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
if value
    pf.memorize('H_AXES')

    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', MeasurePF.H_AXES).get('SETUP')
    pf.memorize('LISTENER_ST_AXIS');

    pf.memorize('H_AREA')
    pf.memorize('ST_AREA').set('PANEL', pf, 'PROP', MeasurePF.H_AREA).get('SETUP')
    pf.memorize('LISTENER_ST_AREA');

    pf.memorize('H_LINE')
    pf.memorize('ST_LINE').set('PANEL', pf, 'PROP', MeasurePF.H_LINE).get('SETUP')
    pf.memorize('LISTENER_ST_LINE');

    pf.memorize('H_TITLE')
    pf.memorize('ST_TITLE').set('PANEL', pf, 'PROP', MeasurePF.H_TITLE).get('SETUP')

    pf.memorize('H_XLABEL')
    pf.memorize('ST_XLABEL').set('PANEL', pf, 'PROP', MeasurePF.H_XLABEL).get('SETUP')

    pf.memorize('H_YLABEL')
    pf.memorize('ST_YLABEL').set('PANEL', pf, 'PROP', MeasurePF.H_YLABEL).get('SETUP')

    pf.get('SETUP')
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel figure graph is deleted.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
if value
    pf.set('H_AXES', Element.getNoValue())

    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
    
    pf.set('H_AREA', Element.getNoValue())
    pf.set('LISTENER_ST_AREA', Element.getNoValue())
 
    pf.set('H_LINE', Element.getNoValue())
    pf.set('LISTENER_ST_LINE', Element.getNoValue())

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

    % Measure Area
    tool_area = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Area', ...
        'State', pf.get('ST_AREA').get('VISIBLE'), ...
        'Tooltip', 'Show measure area', ...
        'CData', imread('icon_area.png'), ...
        'OnCallback', {@cb_area, true}, ...
        'OffCallback', {@cb_area, false});
    
    % Measure Line
    tool_line = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Line', ...
        'State', pf.get('ST_LINE').get('VISIBLE'), ...
        'Tooltip', 'Show measure line', ...
        'CData', imread('icon_line.png'), ...
        'OnCallback', {@cb_line, true}, ...
        'OffCallback', {@cb_line, false});

    value = {value{:}, ...
        tool_separator_1, ...
        tool_axis, tool_grid, ...
        tool_separator_2, ...
        tool_area, tool_line ...
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
function cb_area(~, ~, visible) % (src, event)
    pf.get('ST_AREA').set('VISIBLE', visible)

    % triggers the update of ST_AREA
    pf.set('ST_AREA', pf.get('ST_AREA'))
end
function cb_line(~, ~, visible) % (src, event)
	pf.get('ST_LINE').set('VISIBLE', visible)

    % triggers the update of ST_LINE
    pf.set('ST_LINE', pf.get('ST_LINE'))
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
pr = SettingsAxisPP('EL', pf, 'PROP', MeasurePF.ST_AXIS, varargin{:});

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
M (metadata, item) is the measure.
%%%% ¡settings!
'Measure'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it to be implemented in the subelements.
%%%% ¡calculate!
value = [];

%%% ¡prop!
H_AREA (evanescent, handle) is the handle for the measure area.
%%%% ¡calculate!
value = fill(pf.get('H_AXES'), [0], [0], 'k');

%%% ¡prop!
ST_AREA (figure, item) determines the area settings.
%%%% ¡settings!
'SettingsArea'
%%%% ¡gui!
pr = SettingsAreaPP('EL', pf, 'PROP', MeasurePF.ST_AREA, varargin{:});

%%% ¡prop!
LISTENER_ST_AREA (evanescent, handle) contains the listener to the measure area settings to update the pushbutton.
%%%% ¡calculate!
value = listener(pf.get('ST_AREA'), 'PropSet', @cb_listener_st_area); 
%%%% ¡calculate_callbacks!
function cb_listener_st_area(~, ~)
    if pf.get('DRAWN')
        toolbar = pf.get('H_TOOLBAR');
        if check_graphics(toolbar, 'uitoolbar')
            set(findobj(toolbar, 'Tag', 'TOOL.Area'), 'State', pf.get('ST_AREA').get('VISIBLE'))
        end
    end
end

%%% ¡prop!
H_LINE (evanescent, handle) is the handle for the measure line.
%%%% ¡calculate!
value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);

%%% ¡prop!
ST_LINE (figure, item) determines the line settings.
%%%% ¡settings!
'SettingsLine'
%%%% ¡gui!
pr = SettingsLinePP('EL', pf, 'PROP', MeasurePF.ST_LINE, varargin{:});

%%% ¡prop!
LISTENER_ST_LINE (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.
%%%% ¡calculate!
value = listener(pf.get('ST_LINE'), 'PropSet', @cb_listener_st_line); 
%%%% ¡calculate_callbacks!
function cb_listener_st_line(~, ~)
    if pf.get('DRAWN')
        toolbar = pf.get('H_TOOLBAR');
        if check_graphics(toolbar, 'uitoolbar')
            set(findobj(toolbar, 'Tag', 'TOOL.Line'), 'State', pf.get('ST_LINE').get('VISIBLE'))
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
        'TXT', pf.get('M').get('LABEL'), ...
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
pr = SettingsTextPP('EL', pf, 'PROP', MeasurePF.ST_TITLE, varargin{:});

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
pr = SettingsTextPP('EL', pf, 'PROP', MeasurePF.ST_XLABEL, varargin{:});

%%% ¡prop!
H_YLABEL (evanescent, handle) is the axis y-label.
%%%% ¡calculate!
value = ylabel(pf.get('H_AXES'), '');

if isa(pf.getr('ST_YLABEL'), 'NoValue')
    st = pf.memorize('ST_YLABEL');
    
    position = get(value, 'Position');
    st.set( ...
        'TXT', 'Measure Value', ...
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
pr = SettingsTextPP('EL', pf, 'PROP', MeasurePF.ST_YLABEL, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[MeasurePF.PARENT MeasurePF.H MeasurePF.ST_POSITION MeasurePF.ST_AXIS MeasurePF.ST_AREA MeasurePF.ST_LINE MeasurePF.ST_TITLE MeasurePF.ST_XLABEL MeasurePF.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasurePF'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasurePF'])