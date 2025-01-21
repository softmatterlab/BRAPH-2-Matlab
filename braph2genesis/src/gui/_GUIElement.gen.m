%% ¡header!
GUIElement < GUI (gui, element GUI) is a GUI for an element.

%%% ¡description!
An Element GUI (GUIElement) renders an element in a figure.

CONSTRUCTOR - To construct a GUI use, e.g.:

    gui = GUIElement(''PE'', <element>)
    
DRAW - To create the element figure, use:

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
uifigure, ConcreteElement, PanelElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the element GUI.
%%%% ¡default!
'GUIElement'

%%% ¡prop!
NAME (constant, string) is the name of the element GUI.
%%%% ¡default!
'Element GUI'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the element GUI.
%%%% ¡default!
'An Element GUI (GUIElement) renders an element in a figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the element GUI.
%%%% ¡settings!
'GUIElement'

%%% ¡prop!
ID (data, string) is a few-letter code for the element GUI.
%%%% ¡default!
'GUIElement ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the element GUI.
%%%% ¡default!
'GUIElement label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the element GUI.
%%%% ¡default!
'GUIElement notes'

%%% ¡prop!
H_MENUBAR (evanescent, handlelist) is the list of handles for the menus.
%%%% ¡calculate!
value = {};
if gui.get('MENU_FILE')
    value = [value, gui.memorize('H_MENU_FILE')];
end
if gui.get('MENU_IMPORT')
    value = [value, gui.memorize('H_MENU_IMPORT')];
end
if gui.get('MENU_EXPORT')
    value = [value, gui.memorize('H_MENU_EXPORT')];
end
if gui.get('MENU_PERSONALIZE')
    value = [value, gui.memorize('H_MENU_PERSONALIZE')];
end
if gui.get('MENU_ABOUT')
    value = [value, gui.memorize('H_MENU_ABOUT')];
end

%%% ¡prop!
MENUBAR (gui, logical) determines whether to show the menubar.
%%%% ¡default!
true

%%% ¡prop!
MENU_ABOUT (gui, logical) determines whether to show the menu about.
%%%% ¡default!
true

%%% ¡prop!
H_TOOLS (evanescent, handlelist) is the handle list of the toolbar followed by the tools from the first.
%%%% ¡calculate!
toolbar = gui.memorize('H_TOOLBAR');

children = calculateValue@GUI(gui, GUI.H_TOOLS);

value = {};
if gui.get('TOOL_FILE')
    
    el = gui.get('PE').get('EL');
    
    % OPEN
    tool_file_open = uipushtool(toolbar, ...
        'Tag', 'TOOL.Open', ...                
        'Tooltip', ['Open ' el.get('NAME')], ...
        'CData', imread('icon_open_ml.png'), ...
        'ClickedCallback', {@cb_open});

    % Save
    tool_file_save = uipushtool(toolbar, ...
        'Tag', 'TOOL.Save', ...                
        'Tooltip', ['Save ' el.get('NAME')], ...
        'CData', imread('icon_save_ml.png'), ...
        'ClickedCallback', {@cb_save});
    
    value = {value{:}, tool_file_open, tool_file_save};
end

value = {value{:}, children{:}};

% reorder tools
toolbar.Children = [value{end:-1:1}];

%%% ¡prop!
TOOLBAR (gui, logical) determines whether to show the toolbar.
%%%% ¡default!
true

%%% ¡prop!
TOOL_ABOUT (gui, logical) determines whether to show the toolbar about buttons.
%%%% ¡default!
true

%%% ¡prop!
DRAW (query, logical) draws the contents of a GUI before showing it.
%%%% ¡calculate!
if check_graphics(gui.memorize('H'), 'figure')

    if gui.get('MENUBAR')
        gui.memorize('H_MENUBAR')
    end
    
    if gui.get('TOOLBAR')
        % gui.memorize('H_TOOLBAR') % performed automatically by gui.memorize('H_TOOLS')
        gui.memorize('H_TOOLS')
    end
    
    pe = gui.memorize('PE');
    pe.get('DRAW')
    pe.get('RESIZEY')
    
    gui.memorize('TEXT_FILE')
    
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
RESIZE (query, logical) updates prop POSITION and panel PanelElement when figure size is changed.
%%%% ¡calculate!
value = calculateValue@GUI(gui, GUI.RESIZE, varargin{:}); % also warning
if value
    gui.get('PE').get('RESIZEX')

    set(gui.get('TEXT_FILE'), 'Position', [5 0 w(gui.get('H'), 'pixels')-10 s(2)])
end

%%% ¡prop!
H (evanescent, handle) is the figure handle.
%%%% ¡calculate!
f = calculateValue@GUI(gui, GUI.H);
el = gui.memorize('PE').memorize('EL');
value = f;

%%% ¡prop!
SHOW (query, logical) shows the figure and its dependent figures.
%%%% ¡calculate!
if gui.get('DRAWN')

    % panel element
    gui.get('PE').get('SHOW', 'ShowParentFigure', false)

    % figure layout editor
    if isa(gui.getr('LAYOUT'), 'GUILayout') && gui.get('LAYOUT').get('DRAWN')
        gui.get('LAYOUT').get('SHOW')
    end
    
    value = calculateValue@GUI(gui, GUI.SHOW, varargin{:});
else
    warning( ...
        [BRAPH2.STR ':' class(gui)], ...
        [BRAPH2.STR ':' class(gui) '\\n' ...
        'The call gui.get(''SHOW'') has NOT been executed.\\n' ...
        'First, the figure ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
HIDE (query, logical) hides the figure and its dependent figures.
%%%% ¡calculate!
if gui.get('DRAWN')
    
    % panel element
    gui.get('PE').get('HIDE', 'HideParentFigure', false)
    
    % figure layout editor
    if isa(gui.getr('LAYOUT'), 'GUILayout') && gui.get('LAYOUT').get('DRAWN')
        gui.get('LAYOUT').get('HIDE')
    end
    
    value = calculateValue@GUI(gui, GUI.HIDE, varargin{:});
else
    warning( ...
        [BRAPH2.STR ':' class(gui)], ...
        [BRAPH2.STR ':' class(gui) '\\n' ...
        'The call gui.get(''HIDE'') has NOT been executed.\\n' ...
        'First, the figure ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the figure is deleted.
%%%% ¡calculate!
if gui.get('DRAWN')
    
    gui.set('TEXT_FILE', Element.getNoValue())

    gui.set('H_MENU_FILE', Element.getNoValue())
    gui.set('H_MENU_IMPORT', Element.getNoValue())
    gui.set('H_MENU_EXPORT', Element.getNoValue())
    gui.set('H_MENU_PERSONALIZE', Element.getNoValue())
    
    value = calculateValue@GUI(gui, GUI.DELETE, varargin{:});
else
    warning( ...
        [BRAPH2.STR ':' class(gui)], ...
        [BRAPH2.STR ':' class(gui) '\\n' ...
        'The call gui.get(''DELETE'') has NOT been executed.\\n' ...
        'First, the panel ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
CLOSE (query, logical) closes the figure and its dependent figures.
%%%% ¡calculate!
if gui.get('DRAWN')

    title = gui.get('TITLE');

    if gui.get('CLOSEREQ')
        %TODO implement and use braph2msgbox instead of uiconfirm
        selection = uiconfirm(gui.get('H'), ...
            ['Do you want to close ' title '?'], ...
            ['Close ' title], ...
            'Options', {'Yes', 'No'}, ...
            'DefaultOption', 2 ...
            );
    else
        selection = 'Yes';
    end

    if strcmp(selection, 'Yes')
        % panel element
        gui.get('PE').get('CLOSE', 'CloseParentFigure', false)

        % figure layout editor
        if isa(gui.getr('LAYOUT'), 'GUILayout') && gui.get('LAYOUT').get('DRAWN')
            gui.get('LAYOUT').get('CLOSE')
        end
        
        % main figure
        delete(gui.get('H'))
    end

    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(gui)], ...
        [BRAPH2.STR ':' class(gui) '\\n' ...
        'The call gui.get(''CLOSE'') has NOT been executed.\\n' ...
        'First, the gui ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%% ¡props!

%%% ¡prop!
PE (data, item) is the panel element.
%%%% ¡settings!
'PanelElement'
%%%% ¡conditioning!
if ~isa(value, 'PanelElement')
    value = PanelElement( ...
        'EL', value, ...
        'ID', ['Panel of ' value.get('TOSTRING')] ...
        );
end
%%%% ¡postset!
pe = gui.get('PE');
pe.set('PARENT', gui)
if isa(gui.getr('TITLE'), 'NoValue')
    el = pe.get('EL');
    gui.set('TITLE', [el.getClass() ' - ' el.get('ID') ' - ' BRAPH2.STR])
end
gui.lock('PE', 'Iterative', false)

if isa(pe.getr('WAITBAR'), 'NoValue')
	pe.set('WAITBAR', gui.getCallback('WAITBAR'))
end

%%% ¡prop!
FILE (metadata, string) is the B2 file where the element is saved.
%%%% ¡postset!
if gui.get('DRAWN')
    set(gui.get('TEXT_FILE'), ...
        'Text', gui.get('FILE'), ...
        'Tooltip', gui.get('FILE') ...
        )
end

%%% ¡prop!
TEXT_FILE (evanescent, handle) is the label where the file name is shown.
%%%% ¡calculate!
text_file = uilabel( ...
    'Parent', gui.memorize('H'), ... % H = p for Panel
    'Tag', 'TEXT_FILE', ...    
    'Text', gui.get('FILE'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', gui.get('FILE'), ...
    'HorizontalAlignment', 'left', ...
    'Position', [5 0 w(gui.get('H'), 'pixels')-10 s(2)] ...
    );
value = text_file;

%%% ¡prop!
LAYOUT (data, item) is the handle to the figure to manage layout.
%%%% ¡settings!
'GUILayout'
%%%% ¡preset!
if isa(value.getr('EL_CLASS'), 'NoValue')
    f = gui.get('H');
    value.set( ...
        'EL_CLASS', gui.get('PE').get('EL'), ...
        'POSITION', [x0(f)+w(f) y0(f)+h(f)*2/3 w(f) h(f)/3], ...
        'CLOSEREQ', false ...
        )
end

%%% ¡prop!
H_MENU_FILE (evanescent, handle) is the handle of the menu file.
%%%% ¡calculate!
menu_file = uimenu(gui.memorize('H'), ... % f for figure
    'Tag', 'MENU.File', ...
    'Label', 'File' ...
    );

uimenu(menu_file, ...
    'Tag', 'MENU.File.Open', ...
    'Label', 'Open ...', ...
    'Accelerator', 'O', ...
    'Callback', {@cb_open})
uimenu(menu_file, ...
    'Tag', 'MENU.File.Save', ...
    'Label', 'Save', ...
    'Accelerator', 'S', ...
    'Callback', {@cb_save})
uimenu(menu_file, ...
    'Tag', 'MENU.File.Saveas', ...
    'Label', 'Save as ...', ...
    'Accelerator', 'A', ...
    'Callback', {@cb_saveas})
uimenu(menu_file, ...
    'Separator', 'on', ...
    'Tag', 'MENU.File.Close', ...
    'Label', 'Quit', ...
    'Accelerator', 'Q', ...
    'Callback', {@cb_get, 'CLOSE'})

value = menu_file;
%%%% ¡calculate_callbacks!
function cb_open(~, ~)
    el = gui.get('PE').get('EL');
    % select file
    [file, path, filterindex] = uigetfile(BRAPH2.EXT_ELEMENT, ['Select the ' el.get('NAME') ' file.']);
    if filterindex
        filename = fullfile(path, file);
        tmp_el = Element.load(filename, gui.get('WAITBAR'));
        %TODO: add checks for BRAPH2 version
        if isa(tmp_el, 'PanelFig')
            tmp_gui = GUIFig('PF', tmp_el, 'FILE', filename, 'WAITBAR', gui.get('WAITBAR'));
        else
            tmp_gui = GUIElement('PE', tmp_el, 'FILE', filename, 'WAITBAR', gui.get('WAITBAR'));
        end
        tmp_gui.get('DRAW')
        tmp_gui.get('SHOW')
    end
end
function cb_save(~, ~)
    filename = gui.get('FILE');
    if isfile(filename)
        el = gui.get('PE').get('EL');
        Element.save(el, filename, gui.get('WAITBAR'))
    else
        cb_saveas();
    end
end
function cb_saveas(~, ~)
    el = gui.get('PE').get('EL');
    % select file
    [file, path, filterindex] = uiputfile(BRAPH2.EXT_ELEMENT, ['Select the ' el.get('NAME') ' file.']);
    % save file
    if filterindex
        filename = fullfile(path, file);
        Element.save(el, filename, gui.get('WAITBAR'))
        gui.set('FILE', filename)
    end
end

%%% ¡prop!
MENU_FILE (gui, logical) determines whether to show the menu file.
%%%% ¡default!
true

%%% ¡prop!
H_MENU_IMPORT (evanescent, handle) is the handle of the menu import.
%%%% ¡calculate!
menu_import = uimenu(gui.memorize('H'), ... % f for figure
    'Tag', 'MENU.Import', ...
    'Label', 'Import', ...
    'Callback', {@cb_refresh_import_menu});
value = menu_import;
%%%% ¡calculate_callbacks!
function cb_refresh_import_menu(~, ~)
    menu_import = gui.get('H_MENU_IMPORT');
    
    im_menus = get(menu_import, 'Children');
    for i = 1:1:length(im_menus)
        delete(im_menus(i));
    end
    
    pe = gui.get('PE');
    el = pe.get('EL');
    eval([el.getClass() '.getGUIMenuImport(el, menu_import, pe)']);
end    

%%% ¡prop!
MENU_IMPORT (gui, logical) determines whether to show the menu import.
%%%% ¡default!
true

%%% ¡prop!
H_MENU_EXPORT (evanescent, handle) is the handle of the menu export.
%%%% ¡calculate!
menu_export = uimenu(gui.memorize('H'), ... % f for figure
    'Tag', 'MENU.Export', ...
	'Label', 'Export', ...
	'Callback', {@cb_refresh_export_menu});
value = menu_export;
%%%% ¡calculate_callbacks!
function cb_refresh_export_menu(~, ~)
    menu_export = gui.get('H_MENU_EXPORT');
    
    ex_menus = get(menu_export, 'Children');
    for i = 1:1:length(ex_menus)
        delete(ex_menus(i));
    end
    
    pe = gui.get('PE');
    el = pe.get('EL');
    eval([el.getClass() '.getGUIMenuExport(el, menu_export, pe)']);
end    

%%% ¡prop!
MENU_EXPORT (gui, logical) determines whether to show the menu export.
%%%% ¡default!
true

%%% ¡prop!
H_MENU_PERSONALIZE (evanescent, handle) is the handle of the menu personalize.
%%%% ¡calculate!
menu_file = uimenu(gui.memorize('H'), ... % f for figure
    'Tag', 'MENU.Personalize', ...
    'Label', 'Personalize' ...
    );

uimenu(menu_file, ...
    'Tag', 'MENU.Personalize.Layout', ...
    'Label', 'Layout ...', ...
    'Callback', {@cb_layout})

value = menu_file;
%%%% ¡calculate_callbacks!
function cb_layout(~, ~)
    gui_layout = gui.memorize('LAYOUT');

    gui_layout.get('DRAW')
    gui_layout.get('SHOW')
end

%%% ¡prop!
MENU_PERSONALIZE (gui, logical) determines whether to show the menu personalize.
%%%% ¡default!
true

%%% ¡prop!
TOOL_FILE (gui, logical) determines whether to show the toolbar file buttons.
%%%% ¡default!
true

%% ¡tests!

%%% ¡excluded_props!
[GUIElement.H GUIElement.PE GUIElement.LAYOUT GUIElement.H_MENUBAR GUIElement.H_MENU_ABOUT GUIElement.H_TOOLBAR GUIElement.H_TOOLS]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':GUIElement'])
assert(length(findall(0, 'type', 'figure')) == 10)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':GUIElement'])

%%% ¡test!
%%%% ¡name!
Basics
%%%% ¡probability!
.01
%%%% ¡code!
el = ConcreteElement();
gui = GUIElement('PE', el, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')
f = gui.get('H');
assert(check_graphics(f, 'figure'))

gui_layout = gui.memorize('LAYOUT');
gui_layout.get('DRAW')
gui_layout.get('SHOW')
f_layout = gui_layout.get('H');
assert(check_graphics(f_layout, 'figure'))

gui.get('HIDE')
gui.get('CLOSE')
assert(isa(gui.getr('H'), 'NoValue'))
assert(~check_graphics(f, 'figure'))
assert(isa(gui_layout.getr('H'), 'NoValue'))
assert(~check_graphics(f_layout, 'figure'))

%%% ¡test! 
%%%% ¡name!
Callbacks
%%%% ¡probability!
.01
%%%% ¡code!
% % % % % % % complete with CELL and NET
% % % % et1 = ETA( ...
% % % %     'PROP_STRING_P', 'prova', ...
% % % %     'PROP_LOGICAL_P', true, ...
% % % %     'PROP_OPTION_P', 'three', ...
% % % %     'PROP_CLASS_P', 'ETA', ...
% % % %     'PROP_CLASSLIST_P', {'ETA', 'Panel', 'GUI'}, ...
% % % %     'PROP_ITEM_P', BRAPH2Constants(), ...
% % % %     'PROP_ITEMLIST_P', {BRAPH2Constants(), ETA()}, ...
% % % %     'PROP_IDICT_P', IndexedDictionary(), ...
% % % %     'PROP_SCALAR_P', pi, ...
% % % %     'PROP_RVECTOR_P', [1 2 3], ...
% % % %     'PROP_CVECTOR_P', [1 2 3]', ...
% % % %     'PROP_MATRIX_P', [1 2 3; 4 5 6], ...
% % % %     'PROP_SMATRIX_P', eye(3), ...
% % % %     'PROP_COLOR_P', [.1 .6 1], ...
% % % %     'PROP_ALPHA_P', .5, ...
% % % %     'PROP_SIZE_P', 10, ...
% % % %     'PROP_MARKER_P', 's', ...
% % % %     'PROP_LINE_P', '--' ...
% % % %     );
% % % % et2 = ETA( ...
% % % %     'PROP_STRING_P', Callback('EL', et1, 'TAG', 'PROP_STRING_P'), ...
% % % %     'PROP_LOGICAL_P', Callback('EL', et1, 'TAG', 'PROP_LOGICAL_P'), ...
% % % %     'PROP_OPTION_P', Callback('EL', et1, 'TAG', 'PROP_OPTION_P'), ...
% % % %     'PROP_CLASS_P', Callback('EL', et1, 'TAG', 'PROP_CLASS_P'), ...
% % % %     'PROP_CLASSLIST_P', Callback('EL', et1, 'TAG', 'PROP_CLASSLIST_P'), ...
% % % %     'PROP_ITEM_P', Callback('EL', et1, 'TAG', 'PROP_ITEM_P'), ...
% % % %     'PROP_ITEMLIST_P', Callback('EL', et1, 'TAG', 'PROP_ITEMLIST_P'), ...
% % % %     'PROP_IDICT_P', Callback('EL', et1, 'TAG', 'PROP_IDICT_P'), ...
% % % %     'PROP_SCALAR_P', Callback('EL', et1, 'TAG', 'PROP_SCALAR_P'), ...
% % % %     'PROP_RVECTOR_P', Callback('EL', et1, 'TAG', 'PROP_RVECTOR_P'), ...
% % % %     'PROP_CVECTOR_P', Callback('EL', et1, 'TAG', 'PROP_CVECTOR_P'), ...
% % % %     'PROP_MATRIX_P', Callback('EL', et1, 'TAG', 'PROP_MATRIX_P'), ...
% % % %     'PROP_SMATRIX_P', Callback('EL', et1, 'TAG', 'PROP_SMATRIX_P'), ...
% % % %     'PROP_COLOR_P', Callback('EL', et1, 'TAG', 'PROP_COLOR_P'), ...
% % % %     'PROP_ALPHA_P', Callback('EL', et1, 'TAG', 'PROP_ALPHA_P'), ...
% % % %     'PROP_SIZE_P', Callback('EL', et1, 'TAG', 'PROP_SIZE_P'), ...
% % % %     'PROP_MARKER_P', Callback('EL', et1, 'TAG', 'PROP_MARKER_P'), ...
% % % %     'PROP_LINE_P', Callback('EL', et1, 'TAG', 'PROP_LINE_P') ...
% % % %     );
% % % % gui = GUIElement('PE', et2, 'FILE', 'xxx sss', 'MENUBAR', true, 'TOOLBAR', true, 'CLOSEREQ', false);
% % % % fig = gui.draw();
% % % % close(fig)