%% ¡header!
PanelElement < Panel (pe, element panel) plots the panel of an element.

%%% ¡description!
An Element Panel (PanelElement) plots all properties of an element in a panel, 
 which contains a series of stacked property panels,
 one for each property of the element EL being plotted.

CONSTRUCTOR - To construct a PanelElement use, e.g.:

    pe = PanelElement('<strong>PARENT</strong>', <parent element>, '<strong>EL</strong>', <element>)
  
 where the <parent element> can be a GUI or a Panel, 
  but most often a GUIElement.
  
DRAW - To draw the panel, call:

    pe.get('<strong>DRAW</strong>'[, 'Name', <value>, ...])
    p = pe.get('<strong>H</strong>'); % p is the handle of the generated panel
 
 The query pn.get('<strong>DRAWN</strong>') returns whether the Panel has 
  been drawn and therefore can be shown.
  
CALLBACKS - These are the public callback (to be further implemented by the derived panels):

    pe.get('<strong>SHOW</strong>') - shows the figure containing the panel.
    pe.get('<strong>HIDE</strong>') - hides the figure containing the panel.
    pe.get('<strong>DELETE</strong>') - resets the handles when the panel is deleted.
    pe.get('<strong>CLOSE</strong>') - closes the figure containing the panel.
    pe.get('<strong>RESIZEX</strong>') - resizes the x-extension of the element panel and its prop panels.
    pe.get('<strong>RESIZEY</strong>') - resizes the y-extension of the element panel and its prop panels.

%%% ¡seealso!
uigridlayout, GUI, GUIElement, PanelProp

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the element panel.
%%%% ¡default!
'PanelElement'

%%% ¡prop!
NAME (constant, string) is the name of the element panel.
%%%% ¡default!
'Element Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the element panel.
%%%% ¡default!
'An Element Panel (PanelElement) plots all properties of an element in a panel, which contains a series of stacked property panels, one for each property of the element being plotted.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the element panel.
%%%% ¡settings!
'PanelElement'

%%% ¡prop!
ID (data, string) is a few-letter code for the element panel.
%%%% ¡default!
'PanelElement ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the element panel.
%%%% ¡default!
'PanelElement label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the element panel.
%%%% ¡default!
'PanelElement notes'

%%% ¡prop!
PARENT (gui, item) is the panel parent.
%%%% ¡default!
GUI()
%%%% ¡check_prop!
check = isa(value, 'GUI') || isa(value, 'Panel');
%%%% ¡postset!
if check_graphics(pe.getr('H'), 'uigridlayout') % H = gl for grid layout
    set(pe.get('H'), 'Parent', pe.get('PARENT').get('H')) % H = f for GUI and H = p for Panel
end

%%% ¡prop!
H (evanescent, handle) is the grid layout handle.
%%%% ¡calculate!
gl = uigridlayout([pe.memorize('PR_DICT').get('LENGTH') 1], ... % set grid layout
    'Parent', pe.memorize('PARENT').memorize('H'), ... % H = f for GUI and H = p for Panel
    'Tag', 'H', ...
    'UserData', pe, ... % handle to retrieve the panel
    'Scrollable', 'on', ...
    'RowSpacing', 5, ...
    'Padding', [5 s(1.5) 15 5], ...    
    'BackgroundColor', pe.get('BKGCOLOR'), ...
    'DeleteFcn', {@cb_get, 'DELETE'} ...
    );
value = gl;

%%% ¡prop!
H_WAITBAR (evanescent, handle) is the waitbar handle.
%%%% ¡calculate!
if pe.get('WAITBAR')
    value = braph2waitbar(pe.get('WAITBAR'), 0, 'Drawing the element panel ...'); % wb
else
    value = gobjects(1);
end

%%% ¡prop!
DRAW (query, logical) draws the element panel.
%%%% ¡calculate!
if check_graphics(pe.memorize('H'), 'uigridlayout') % H = gl for grid layout
    gl = pe.get('H');
    
    if ~isempty(varargin)
        set(g, varargin{:})
    end

	wb = pe.memorize('H_WAITBAR');
    
    pr_dict = pe.memorize('PR_DICT');
    
    for pri = 1:1:pr_dict.get('LENGTH')
        braph2waitbar(wb, .5 + .5 * (pri - 1) / pr_dict.get('LENGTH'), ['Drawing prop panel ' int2str(pri) ' of ' int2str(pr_dict.get('LENGTH'))])
        
        pr = pr_dict.get('IT', pri);
        pr.get('DRAW')
    end
    
    pe.memorize('LISTENER_PPHEIGHT')
    
    braph2waitbar(wb, 'close')
    pe.set('H_WAITBAR', Element.getNoValue())
    
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pe)], ...
        [BRAPH2.STR ':' class(pe) '\\n' ...
        'The call pe.get(''DRAW'') did not work.\\n' ...
        'This shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
DRAWN (query, logical) returns whether the panel has been drawn.
%%%% ¡calculate!
value = check_graphics(pe.getr('H'), 'uigridlayout'); % H = gl for grid layout

%%% ¡prop!
SHOW (query, logical) brings to the front the figures dependent on the element panel.
%%%% ¡calculate!
if pe.get('DRAWN')
    
    pr_dict = pe.get('PR_DICT');
    for pri = 1:1:pr_dict.get('LENGTH')
        pr = pr_dict.get('IT', pri);
        pr.get('SHOW', 'ShowParentFigure', false)
    end

    calculateValue@Panel(pe, Panel.SHOW, varargin{:});
    
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pe)], ...
        [BRAPH2.STR ':' class(pe) '\\n' ...
        'The call pe.get(''SHOW'') has NOT been executed.\\n' ...
        'First, the panel ' pe.get('ID') ' should be drawn calling pe.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
HIDE (query, logical) hides the figures dependent on the element panel.
%%%% ¡calculate!
if pe.get('DRAWN')
    
    pr_dict = pe.get('PR_DICT');
    for pri = 1:1:pr_dict.get('LENGTH')
        pr = pr_dict.get('IT', pri);
        pr.get('HIDE', 'HideParentFigure', false)
    end

    calculateValue@Panel(pe, Panel.HIDE, varargin{:});

    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pe)], ...
        [BRAPH2.STR ':' class(pe) '\\n' ...
        'The call pe.get(''HIDE'') has NOT been executed.\\n' ...
        'First, the panel ' pe.get('ID') ' should be drawn calling pe.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the element panel is deleted.
%%%% ¡calculate!
value = calculateValue@Panel(pe, Panel.DELETE, varargin{:}); % also warning
if value
    pe.set('LISTENER_PPHEIGHT', Element.getNoValue())
end

%%% ¡prop!
CLOSE (query, logical) closes the figures dependent on the element panel.
%%%% ¡calculate!
if pe.get('DRAWN')
    
    pr_dict = pe.get('PR_DICT');
    for pri = 1:1:pr_dict.get('LENGTH')
        pr = pr_dict.get('IT', pri);
        pr.get('CLOSE', 'CloseParentFigure', false)
    end
    
    calculateValue@Panel(pe, Panel.CLOSE, varargin{:});
    
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pe)], ...
        [BRAPH2.STR ':' class(pe) '\\n' ...
        'The call pe.get(''CLOSE'') has NOT been executed.\\n' ...
        'First, the panel ' pe.get('ID') ' should be drawn calling pe.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%% ¡props!

%%% ¡prop!
EL (data, item) is the element to be plotted.
%%%% ¡postset!
pe.lock('EL', 'Iterative', false)

[order, title, visible] = load_layout(pe.get('EL'));
pe.set( ...
    'PR_ORDER', order, ...
    'PR_TITLE', title, ...
    'PR_VISIBLE', visible ...
    )

%%% ¡prop!
PR_ORDER (gui, rvector) is the order of the property plots.
%%%% ¡preset!
if isempty(value) && ~isa(pe.getr('EL'), 'NoValue')
    [value, ~, ~] = load_layout(pe.get('EL'));
end

%%% ¡prop!
PR_TITLE (gui, stringlist) is the list of property plot titles.
%%%% ¡preset!
if isempty(value) && ~isa(pe.getr('EL'), 'NoValue')
    [~, value, ~] = load_layout(pe.get('EL'));
end

%%% ¡prop!
PR_VISIBLE (gui, rvector) is the list of visible property plots.
%%%% ¡preset!
if isempty(value) && ~isa(pe.getr('EL'), 'NoValue')
    [~, ~, value] = load_layout(pe.get('EL'));
end

%%% ¡prop!
PR_DICT (result, idict) is a dictionary of the property plots.
%%%% ¡settings!
'PanelProp'
%%%% ¡calculate!
el = pe.get('EL');

wb = pe.memorize('H_WAITBAR');

order = pe.get('PR_ORDER');
title = pe.get('PR_TITLE');
visible = pe.get('PR_VISIBLE');

pr_list = cell(1, sum(visible)); % sum(visible) = sum of visible prop
for prop = 1:1:el.getPropNumber()
    
    braph2waitbar(wb, 0 + .5 * (prop - 1) / el.getPropNumber(), ['Analyzing prop ' int2str(prop) ' of ' int2str(el.getPropNumber())])

    if visible(prop)
        pr = el.getPanelProp(prop);
        
        if isa(pr.getr('PARENT'), 'NoValue')
            pr.set('PARENT', pe)
        end
        
        if strcmp(pr.get('TITLE'), pr.get('ID'))
            pr.set('TITLE', title{prop})
        end
        
        if isa(pr.getr('WAITBAR'), 'NoValue')
            pr.set('WAITBAR', pe.getCallback(PanelElement.WAITBAR))
        end
        
        pr_list{order(prop)} = pr;
    end
end

value = IndexedDictionary( ...
    'ID', el.get('TOSTRING'), ...
    'IT_CLASS', 'PanelProp', ...
    'IT_LIST', pr_list ...
    );

%%% ¡prop!
MIN_WIDTH (gui, size) is the minimal panel width in pixels.
%%%% ¡default!
300

%%% ¡prop!
RESIZEX (query, logical) resizes the x-extension of the element panel and its prop panels.
%%%% ¡calculate!
if pe.get('DRAWN')
    pr_dict = pe.get('PR_DICT');
    
    column_width = max(pe.get('MIN_WIDTH'), w(pe.get('PARENT').get('H'), 'pixels') - 20);
    set(pe.get('H'), 'ColumnWidth', {column_width})

    for pri = 1:1:pr_dict.get('LENGTH')
        pr_dict.get('IT', pri).get('REDRAW', 'Width', column_width)
    end
   
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pe)], ...
        [BRAPH2.STR ':' class(pe) '\\n' ...
        'The call pe.get(''RESIZEX'') has NOT been executed.\\n' ...
        'First, the panel ' pe.get('ID') ' should be drawn calling pe.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
RESIZEY (query, logical) resizes the y-extension of the element panel and its prop panels.
%%%% ¡calculate!
if pe.get('DRAWN')
    set(pe.get('H'), 'RowHeight', cellfun(@(pr) {pr.get('HEIGHT')}, pe.get('PR_DICT').get('IT_LIST')))

    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pe)], ...
        [BRAPH2.STR ':' class(pe) '\\n' ...
        'The call pe.get(''RESIZEY'') has NOT been executed.\\n' ...
        'First, the panel ' pe.get('ID') ' should be drawn calling pe.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
LISTENER_PPHEIGHT (evanescent, handlelist) contains the listeners to the PropSet events.
%%%% ¡calculate!
value = cellfun(@(pr) listener(pr, 'PropSet', @cb_listener_ppheight), pe.get('PR_DICT').get('IT_LIST'), 'UniformOutput', false); 
%%%% ¡calculate_callbacks!
function cb_listener_ppheight(~, event)
    if ismember(PanelProp.HEIGHT, cell2mat(event.props)) && pe.get('DRAWN')
        pe.get('RESIZEY')
    end
end

%% ¡tests!

%%% ¡excluded_props!
[PanelElement.H_WAITBAR PanelElement.PARENT PanelElement.H PanelElement.PR_ORDER PanelElement.PR_TITLE PanelElement.PR_VISIBLE PanelElement.PR_DICT]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelElement'])
assert(length(findall(0, 'type', 'figure')) == 2)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelElement'])

%%% ¡test!
%%%% ¡name!
Example 1
%%%% ¡probability!
.01
%%%% ¡code!
gui = GUI('MENUBAR', true, 'MENU_ABOUT', true, 'TOOLBAR', true, 'TOOL_ABOUT', true, 'CLOSEREQ', false);
pe = PanelElement('PARENT', gui);
el = pe.memorize('EL');
pe.get('DRAW')
pe.get('SHOW')
assert(isequal(pe.get('H').get('ColumnWidth'), {'1x'}))

pe.get('RESIZEX')
if ~isunix % the assert is not performed in linux OS because the window size from the linux container is not fixed.
    assert(isequal(pe.get('H').get('ColumnWidth'), {300})) 
end 

pe.get('RESIZEY')
% cellfun(@(pr) assert(h(pr.get('H')) == pr.get('HEIGHT')), pe.get('PR_DICT').get('IT_LIST'), 'UniformOutput', false)

gui.set('POSITION', [0 .8 1 .2])
pe.get('RESIZEX')
assert(~isequal(pe.get('H').get('ColumnWidth'), {300}))

gui.set('POSITION', [0 0 .1 1])
pe.get('RESIZEX')
assert(isequal(pe.get('H').get('ColumnWidth'), {300}))

% set(gui.memorize('H'), 'SizeChangedFcn', 'pe.get(''RESIZEX'')')

pe.get('CLOSE')

%%% ¡test!
%%%% ¡name!
Example 2
%%%% ¡probability!
.01
%%%% ¡code!
if exist('ETA_LN', 'class') == 8
    
    et = ETA_LN();
% % % et = ETA( ...
% % %     'PROP_STRING_M', 'mmm', ...
% % %     'PROP_STRING_P', 'ppp', ...
% % %     'PROP_STRING_D', 'ddd', ...
% % %     'PROP_LOGICAL_M', true, ...
% % %     'PROP_LOGICAL_P', false, ...
% % %     'PROP_LOGICAL_D', false, ...
% % %     'PROP_OPTION_M', 'two', ... 
% % %     'PROP_OPTION_P', 'three', ...
% % %     'PROP_OPTION_D', '', ...
% % %     'PROP_CLASS_M', 'ETA', ...
% % %     'PROP_CLASS_P', 'ETA', ...
% % %     'PROP_CLASS_D', 'PanelElement', ...
% % %     'PROP_CLASSLIST_M', {'ETA'}, ...
% % %     'PROP_CLASSLIST_P', {'Element', 'ETA', 'PanelElement'}, ...
% % %     'PROP_CLASSLIST_D', {}, ...
% % %     'PROP_ITEM_M', ETA('PROP_STRING_M', 'ETA trial'), ...
% % %     'PROP_ITEM_P', ETB('ID', 'BR trial 2'), ...
% % %     'PROP_ITEM_D', ETB('ID', 'BR trial 3'), ...
% % %     'PROP_ITEMLIST_M', {ETA('PROP_STRING_M', 'ETA trial 1'), ETA('PROP_STRING_M', 'ETA trial 2'), ETA('PROP_STRING_M', 'ETA trial 3')}, ...
% % %     'PROP_ITEMLIST_P', {ETB('ID', 'BR trial 1'), ETB('ID', 'BR trial 2'), ETB('ID', 'BR trial 3')}, ...
% % %     'PROP_ITEMLIST_D', {}, ...
% % %     'PROP_IDICT_M', IndexedDictionary('IT_CLASS', 'ETA', 'IT_KEY', ETA.getPropProp('PROP_STRING_D')), ...
% % %     'PROP_IDICT_P', IndexedDictionary('IT_CLASS', 'ETB', 'IT_LIST', {ETB('ID', 'BR trial A'), ETB('ID', 'BR trial B'), ETB('ID', 'BR trial C')}), ...
% % %     'PROP_IDICT_D', IndexedDictionary(), ...
% % %     'PROP_SCALAR_M', 1, ...
% % %     'PROP_SCALAR_P', 3, ...
% % %     'PROP_SCALAR_D', 10, ...
% % %     'PROP_RVECTOR_M', ones(1, 10), ...
% % %     'PROP_RVECTOR_P', zeros(1, 10), ...
% % %     'PROP_RVECTOR_D', rand(1, 10), ...
% % %     'PROP_CVECTOR_M', ones(10, 1), ...
% % %     'PROP_CVECTOR_P', zeros(10, 1), ...
% % %     'PROP_CVECTOR_D', rand(10, 1), ...
% % %     'PROP_MATRIX_M', zeros(8,10), ...
% % %     'PROP_MATRIX_P', randn(10), ...
% % %     'PROP_MATRIX_D', rand(12), ...
% % %     'PROP_SMATRIX_M', eye(4), ...
% % %     'PROP_SMATRIX_P', randn(3), ...
% % %     'PROP_SMATRIX_D', rand(5), ...
% % %     'PROP_CELL_M', {randn(4), randn(4), randn(4); randn(4), randn(4), randn(4); randn(4), randn(4), randn(4)}, ...
% % %     'PROP_CELL_P', {eye(10)}, ...
% % %     'PROP_CELL_D', {randn(2), randn(2); randn(2), randn(2)} ...
% % %     );

    gui = GUI('MENUBAR', true, 'MENU_ABOUT', true, 'TOOLBAR', true, 'TOOL_ABOUT', true, 'CLOSEREQ', false);
    % set(gui.memorize('H'), 'SizeChangedFcn', 'pe.get(''RESIZEX'')')
    pe = PanelElement('PARENT', gui, 'EL', et);
    pe.get('DRAW')
    pe.get('SHOW')
    pe.get('RESIZEY')
    
    pe.get('PR_DICT').get('IT', 'ID').set('HEIGHT', 200)
    % cellfun(@(pr) assert(h(pr.get('H')) == pr.get('HEIGHT')), pe.get('PR_DICT').get('IT_LIST'), 'UniformOutput', false)
    
    pe.get('CLOSE')
end