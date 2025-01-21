%% ¡header!
GUILayout < GUI (gui, GUI layout) is a layout editor.

%%% ¡description!
A GUI Layout (GUILayout) renders a layout editor.

CONSTRUCTOR - To construct a GUILayout use, e.g.:

    gui = GUILayout('<strong>EL_CLASS</strong>', EL_CLASS, '<strong>POSITION</strong>', [x0 y0 w h], '<strong>BKGCOLOR</strong>', [r g b]);
    gui = GUILayout('<strong>EL_CLASS</strong>', EL, '<strong>POSITION</strong>', [x0 y0 w h], '<strong>BKGCOLOR</strong>', [r g b]);

 The argument of EL_CLASS can be an element class or an element.
   
DRAW - To create and show the figure, use:

    gui.get('<strong>DRAW</strong>')
    gui.get('<strong>SHOW</strong>')
    f = gui.get('<strong>H</strong>'); % f is the figure handle.

 The query gui.get('<strong>DRAWN</strong>') returns whether the GUI has 
  been drawn and therefore can be shown.
 
CALLBACK - These are the public callbacks:

    gui.get('<strong>RESIZE</strong>') - updates POSITION when figure size is changed
    gui.get('<strong>SHOW</strong>') - brings to the front the figure and its dependent figures
    gui.get('<strong>HIDE</strong>') - hides the figure and its dependent figures
    gui.get('<strong>DELETE</strong>') - resets the handles (automatically called when the figure is deleted)
    gui.get('<strong>CLOSE</strong>') - closes the figure and its dependent figures

%%% ¡seealso!
uifigure, GUI, Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the GUI layout.
%%%% ¡default!
'GUILayout'

%%% ¡prop!
NAME (constant, string) is the name of the GUI layout.
%%%% ¡default!
'GUI Layout'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the GUI layout.
%%%% ¡default!
'A GUI Layout (GUILayout) renders a layout editor.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the GUI layout.
%%%% ¡settings!
'GUILayout'

%%% ¡prop!
ID (data, string) is a few-letter code for the GUI layout.
%%%% ¡default!
'GUILayout ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the GUI layout.
%%%% ¡default!
'GUILayout label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the GUI layout.
%%%% ¡default!
'GUILayout notes'

%%% ¡prop!
TITLE (gui, string) is the name of the GUI layout.
%%%% ¡default!
['Layout Editor - ' BRAPH2.STR]

%%% ¡prop!
DRAW (query, logical) draws the contents of a GUI before showing it.
%%%% ¡calculate!
if check_graphics(gui.memorize('H'), 'figure')
	el_class = gui.memorize('EL_CLASS');

    gui.memorize('P')
    gui.memorize('TABLE')
    gui.memorize('SAVE_BTN')
    gui.memorize('CANCEL_BTN')
    
    gui.get('RESIZE')
    
    drawnow()
    
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(gui)], ...
        [BRAPH2.STR ':' class(gui) '\\n' ...
        'The call gui.get(''DRAW'') did not work.\\n' ...
        'This shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
CLOSEREQ (gui, logical) determines whether to confirm close.
%%%% ¡default!
false

%%% ¡prop!
RESIZE (query, logical) updates prop POSITION and panel PanelElement when figure size is changed.
%%%% ¡calculate!
value = calculateValue@GUI(gui, GUI.RESIZE, varargin{:}); % also warning
if value    
    p = gui.get('P');
    
    set(gui.get('TABLE'), 'Position', [s(1) s(4) w(p, 'pixels')-s(2) h(p, 'pixels')-s(5)])
    set(gui.get('SAVE_BTN'), 'Position', [s(1) s(1) s(10) s(2)])
    set(gui.get('CANCEL_BTN'), 'Position', [s(12) s(1) s(10) s(2)])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the figure is deleted.
%%%% ¡calculate!
value = calculateValue@GUI(gui, GUI.DELETE, varargin{:}); % also warning
if value
    gui.set('P', Element.getNoValue())
    gui.set('TABLE', Element.getNoValue())
    gui.set('SAVE_BTN', Element.getNoValue())
    gui.set('CANCEL_BTN', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
EL_CLASS (data, class) is the element class.
%%%% ¡conditioning!
value = Element.getClass(value);
%%%% ¡postset!
if isa(gui.getr('TITLE'), 'NoValue')
    gui.set('TITLE', ['Layout Editor - ' gui.get('EL_CLASS') ' - ' BRAPH2.STR])
end
gui.lock('EL_CLASS', 'Iterative', false)

%%% ¡prop!
P (evanescent, handle) is the panel.
%%%% ¡calculate!
p = uipanel( ...
    'Parent', gui.memorize('H'), ...
    'Tag', 'p', ...
    'Units', 'normalized', ...
    'Position', [0 0 1 1], ...
    'BackgroundColor', gui.get('BKGCOLOR'), ...
    'AutoResizeChildren', 'off' ...
    );
value = p;

%%% ¡prop!
TABLE (evanescent, handle) is the table.
%%%% ¡calculate!
table = uitable( ...
    'Parent', gui.memorize('P'), ...
    'Tag', 'table', ...
    'Units', 'pixels', ...
    'ColumnName', {'Show', 'Order', 'Title', 'Property', 'Category', 'Format'}, ...
    'ColumnFormat', {'logical', 'char', 'char', 'char', 'char', 'char'}, ...
    'ColumnEditable', [true true true false false false], ...
    'CellEditCallback', {@cb_table} ...
    );

el_class = gui.get('EL_CLASS');
[order, title, visible] = load_layout(el_class);

data = cell(Element.getPropNumber(el_class), 6);
for prop = 1:1:Element.getPropNumber(el_class)
    data{prop, 1} = visible(prop); % VISIBLE = 1;
    data{prop, 2} = order(prop); % ORDER = 2;
    data{prop, 3} = title{prop}; % TITLE = 3;
    data{prop, 4} = upper(Element.getPropTag(el_class, prop)); % TAG = 4;
    
    category = Element.getPropCategory(el_class, prop);
    data{prop, 5} = [int2str(category) ' ' Category.getCategoryTag(category) ' ' Category.getCategoryName(category)]; % CATEGORY = 5;
    
    format = Element.getPropFormat(el_class, prop);
    data{prop, 6} = [int2str(format) ' ' Format.getFormatTag(format) ' ' Format.getFormatName(format)]; % FORMAT = 6;
end        
set(table, 'Data', data);

value = table;
%%%% ¡calculate_callbacks!
function cb_table(~, event)
    prop = event.Indices(1);
    col = event.Indices(2);
    newdata = event.NewData;

    table = gui.get('TABLE');
    VISIBLE = 1;
    ORDER = 2;
    
    data = get(table, 'Data');

    if col == VISIBLE
        if newdata == true
            if any(~isnan(cell2mat(data(:, ORDER))))
                data{prop, ORDER} = max(cell2mat(data(:, ORDER))) + 1;
            else % all NaN (edge case)
                data{prop, ORDER} = 1;
            end
        else % newdata == false
            for i = data{prop, ORDER} + 1:1:max(cell2mat(data(:, ORDER)))
                data{cell2mat(data(:, ORDER)) == i, ORDER} = i - 1;
            end
            data{prop, ORDER} = NaN;
        end
    end

    if col == ORDER
        if isnan(newdata)
            data{prop, VISIBLE} = false;
        else
            data{prop, VISIBLE} = true;
        end

        order = cell2mat(data(:, ORDER)) + .00301040106;
        order(prop) = newdata;
        for i = 1:1:numel(order) - sum(isnan(order))
            min_order_index = find(order == min(order));
            data{min_order_index, ORDER} = i;
            order(min_order_index) = NaN;
        end
    end

    set(table, 'Data', data);
    
    set(gui.get('SAVE_BTN'), 'Enable', 'on')    
end

%%% ¡prop!
SAVE_BTN (evanescent, handle) is the save button.
%%%% ¡calculate!
save_btn = uibutton( ...
    'Parent', gui.memorize('P'), ...
    'Tag', 'save_btn', ...
    'Enable', 'off', ...
    'Text', 'Save', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'ButtonPushedFcn', {@cb_save_btn}, ...
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    );
value = save_btn;
%%%% ¡calculate_callbacks!
function cb_save_btn(~, ~)
    el_class = gui.get('EL_CLASS');
    table = gui.get('TABLE');
    data = get(table, 'Data');
    order = cell2mat(data(:, 2))';
    title = data(:, 3); title = title';
    save_layout(el_class, order, title)
    
    set(gui.get('SAVE_BTN'), 'Enable', 'off')
end

%%% ¡prop!
CANCEL_BTN (evanescent, handle) is the edit button.
%%%% ¡calculate!
cancel_btn = uibutton( ...
    'Parent', gui.memorize('P'), ...
    'Tag', 'save_btn', ...
    'Text', 'Cancel', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'ButtonPushedFcn', {@cb_cancel_btn}, ...
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    );
value = cancel_btn;
%%%% ¡calculate_callbacks!
function cb_cancel_btn(~, ~)
    gui.get('CLOSE')
end

%% ¡tests!

%%% ¡excluded_props!
[GUILayout.POSITION GUILayout.H]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':GUILayout'])
assert(length(findall(0, 'type', 'figure')) == 3)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':GUILayout'])

%%% ¡test!
%%%% ¡name!
Basics
%%%% ¡probability!
.01
%%%% ¡code!
gui = GUILayout( ...
    'EL_CLASS', IndexedDictionary(), ...
    'POSITION', [.3 .3 .4 .4], ...
    'BKGCOLOR', [1 0 0] ...
    );
assert(strcmp(gui.get('EL_CLASS'), 'IndexedDictionary'))
gui.get('DRAW')
gui.get('SHOW')
gui.get('CLOSE')
