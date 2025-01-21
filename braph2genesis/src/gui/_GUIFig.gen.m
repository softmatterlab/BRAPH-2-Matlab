%% ¡header!
GUIFig < GUI (gui, figure GUI) is a GUI for a figure.

%%% ¡description!
A Figure GUI (GUIFIG) renders a figure.

CONSTRUCTOR - To construct a GUI use, e.g.:

    gui = GUIElement(''PF'', <element>)
    
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
uifigure, PanelFig

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the figure GUI.
%%%% ¡default!
'GUIFig'

%%% ¡prop!
NAME (constant, string) is the name of the figure GUI.
%%%% ¡default!
'Figure GUI'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the figure GUI.
%%%% ¡default!
'A Figure GUI (GUIFIG) renders a figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the figure GUI.
%%%% ¡settings!
'GUIFig'

%%% ¡prop!
ID (data, string) is a few-letter code for the figure GUI.
%%%% ¡default!
'GUIFIG ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the figure GUI.
%%%% ¡default!
'GUIFIG label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the figure GUI.
%%%% ¡default!
'GUIFIG notes'

%%% ¡prop!
POSITION (gui, rvector) is the normalized position of the GUI on the screen.
%%%% ¡default!
[.30 .40 .39 .47]

%%% ¡prop!
BKGCOLOR (gui, color) is the GUI background color.
%%%% ¡default!
BRAPH2.COL_F

%%% ¡prop!
H_MENUBAR (evanescent, handlelist) is the list of handles for the menus.
%%%% ¡calculate!
value = {};
if gui.get('MENU_FILE')
    value = [value, gui.memorize('H_MENU_FILE')];
end
if gui.get('MENU_PRINT')
    value = [value, gui.memorize('H_MENU_PRINT')];
end
if gui.get('MENU_GUI_SETTINGS')
    value = [value, gui.memorize('H_MENU_GUI_SETTINGS')];
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

pf = gui.memorize('PF');

value = {};

if gui.get('TOOL_FILE')
    % OPEN
    tool_file_open = uipushtool(toolbar, ...
        'Tag', 'TOOL.Open', ...                
        'Tooltip', ['Open ' pf.get('NAME')], ...
        'CData', imread('icon_open_ml.png'), ...
        'ClickedCallback', {@cb_open});
    % Save
    tool_file_save = uipushtool(toolbar, ...
        'Tag', 'TOOL.Save', ...                
        'Tooltip', ['Save ' pf.get('NAME')], ...
        'CData', imread('icon_save_ml.png'), ...
        'ClickedCallback', {@cb_save});
    
    value = {value{:}, tool_file_open, tool_file_save};
end
if gui.get('TOOL_PRINT')
    % Print
    tool_print = uipushtool(toolbar, ...
        'Tag', 'TOOL.Print', ...                
        'Tooltip', ['Print/Export to image file ' pf.get('NAME')], ...
        'CData', imread('icon_print_ml.png'), ...
        'ClickedCallback', {@cb_print, 'auto', 300});

    value = {value{:}, tool_print};
end
if gui.get('TOOL_GUI_SETTINGS')
    % Settings
    tool_settings = uipushtool(toolbar, ...
        'Tag', 'TOOL.Settings', ...       
        'Separator', 'on', ...
        'Tooltip', ['Settings ' pf.get('NAME')], ... 
        'CData', imread('icon_settings_ml.png'), ...
        'ClickedCallback', {@cb_settings});
  
    value = {value{:}, tool_settings};
end

panel_tools = pf.memorize('H_TOOLS');
value = {value{:}, panel_tools{:}};

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
    
    pf = gui.memorize('PF');
    pf.get('DRAW')

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
H (evanescent, handle) is the figure handle.
%%%% ¡calculate!
f = calculateValue@GUI(gui, GUI.H);
pf = gui.memorize('PF');
value = f;

%%% ¡prop!
SHOW (query, logical) shows the figure and its dependent figures.
%%%% ¡calculate!
value = calculateValue@GUI(gui, GUI.SHOW, varargin{:}); % also warning
if value
    % figure layout editor
    if isa(gui.getr('GUI_LAYOUT'), 'GUILayout') && gui.get('GUI_LAYOUT').get('DRAWN')
        gui.get('GUI_LAYOUT').get('SHOW')
    end
    
    % figure settings
    if isa(gui.getr('GUI_SETTINGS'), 'GUIElement') && gui.get('GUI_SETTINGS').get('DRAWN')
        gui.get('GUI_SETTINGS').get('SHOW')
    end
end

%%% ¡prop!
HIDE (query, logical) hides the figure and its dependent figures.
%%%% ¡calculate!
value = calculateValue@GUI(gui, GUI.HIDE, varargin{:}); % also warning
if value
    % figure layout editor
    if isa(gui.getr('GUI_LAYOUT'), 'GUILayout') && gui.get('GUI_LAYOUT').get('DRAWN')
        gui.get('GUI_LAYOUT').get('HIDE')
    end

    % figure settings
    if isa(gui.getr('GUI_SETTINGS'), 'GUIElement') && gui.get('GUI_SETTINGS').get('DRAWN')
        gui.get('GUI_SETTINGS').get('HIDE')
    end
end

%%% ¡prop!
DELETE (query, logical) resets the handles and closes the dependent figures when the figure is deleted.
%%%% ¡calculate!
value = calculateValue@GUI(gui, GUI.DELETE, varargin{:}); % also warning
if value
	gui.set('TEXT_FILE', Element.getNoValue())

 	gui.set('H_MENU_FILE', Element.getNoValue())
	gui.set('H_MENU_PRINT', Element.getNoValue())
 	gui.set('H_MENU_GUI_SETTINGS', Element.getNoValue())
 	gui.set('H_MENU_PERSONALIZE', Element.getNoValue())
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
        % figure layout editor
        if isa(gui.getr('GUI_LAYOUT'), 'GUILayout') && gui.get('GUI_LAYOUT').get('DRAWN')
            gui.get('GUI_LAYOUT').get('CLOSE')
        end

        % figure settings
        if isa(gui.getr('GUI_SETTINGS'), 'GUIElement') && gui.get('GUI_SETTINGS').get('DRAWN')
            gui.get('GUI_SETTINGS').get('CLOSE')
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
PF (data, item) is the panel figure.
%%%% ¡settings!
'PanelFig'
%%%% ¡postset!
pf = gui.get('PF');
pf.set('PARENT', gui)
if isa(gui.getr('TITLE'), 'NoValue')
    gui.set('TITLE', [pf.getClass() ' - ' pf.get('ID') ' - ' BRAPH2.STR])
end
gui.lock('PF', 'Iterative', false)

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
GUI_LAYOUT (data, item) is the handle to the figure to manage the layout.
%%%% ¡settings!
'GUILayout'
%%%% ¡preset!
if isa(value.getr('EL_CLASS'), 'NoValue')
    f = gui.get('H');
    value.set( ...
        'EL_CLASS', gui.get('PF'), ...
        'POSITION', [x0(f)+w(f) y0(f)+h(f)*2/3 w(f) h(f)/3], ...
        'CLOSEREQ', false ...
        )
end

%%% ¡prop!
GUI_SETTINGS (data, item) is the handle to the figure to manage the figure settings.
%%%% ¡settings!
'GUIElement'
%%%% ¡preset!
if isa(value.getr('PE'), 'NoValue') % i.e., default initialization
    pf = gui.memorize('PF');
    f = gui.get('H');
    
    pe = PanelElement('EL', pf);
    
    pr_visible = int8(pe.get('PR_VISIBLE') & ismember(1:1:pf.getPropNumber(), pf.getProps(Category.FIGURE))); % __Category.FIGURE__

    pr_order = pe.get('PR_ORDER');
    pr_order(pr_visible == 0) = NaN;
    for i = sum(pr_visible):-1:1
        pr_order(pr_order == max(pr_order)) = -i;
    end
    pr_order = -pr_order;
    
    pe.set( ...
        'PR_VISIBLE', pr_visible, ...
        'PR_ORDER', pr_order ...
        )
    
	value.set( ...
        'PE', pe, ...
        'TITLE', ['Settings - ' gui.get('TITLE')], ...
        'POSITION', [ ...
            min(x0(f, 'normalized') + w(f, 'normalized'), 1 - (pe.get('MIN_WIDTH') + 20) / w(0, 'pixels')) ... % min to ensure that figure within screen
            y0(f, 'normalized') ...
            (pe.get('MIN_WIDTH') + 20) / w(0, 'pixels') ...
            h(f, 'normalized') ...
            ], ...
        'MENUBAR', false, ...
        'TOOLBAR', false, ...
        'WAITBAR', gui.getCallback('WAITBAR'), ...
        'CLOSEREQ', false ...
        );
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
    pf = gui.get('PF');
    % select file
    [file, path, filterindex] = uigetfile(BRAPH2.EXT_ELEMENT, ['Select the ' pf.get('NAME') ' file.']);
    if filterindex
        filename = fullfile(path, file);
        tmp_el = Element.load(filename, gui.get('WAITBAR'));
        % % % %TODO: add checks for BRAPH2 version
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
        pf = gui.get('PF');
        Element.save(pf, filename, gui.get('WAITBAR'))
    else
        cb_saveas();
    end
end
function cb_saveas(~, ~)
    pf = gui.get('PF');
    % select file
    [file, path, filterindex] = uiputfile(BRAPH2.EXT_ELEMENT, ['Select the ' pf.get('NAME') ' file.']);
    % save file
    if filterindex
        filename = fullfile(path, file);
        Element.save(pf, filename, gui.get('WAITBAR'))
        gui.set('FILE', filename)
    end
end

%%% ¡prop!
MENU_FILE (gui, logical) determines whether to show the menu file.
%%%% ¡default!
true

%%% ¡prop!
H_MENU_PRINT (evanescent, handle) is the handle of the menu to print to image file.
%%%% ¡calculate!
menu_print = uimenu(gui.memorize('H'), ... % f for figure
    'Tag', 'MENU.Print', ...
    'Label', 'Print' ...
    );

uimenu(menu_print, ...
    'Tag', 'MENU.Print.Print', ...
    'Label', 'Print ...', ...
    'Accelerator', 'P', ...
    'Callback', {@cb_print})
uimenu(menu_print, ...
    'Tag', 'MENU.Print.Vectorial', ...
    'Label', 'Vectorial ...', ...
    'Callback', {@cb_print, 'vector'})
uimenu(menu_print, ...
    'Separator', 'on', ...
    'Tag', 'MENU.Print.HR300', ...
    'Label', 'Hi-res (300 dpi) ...', ...
    'Callback', {@cb_print, 'image', 300})
uimenu(menu_print, ...
    'Tag', 'MENU.Print.HR600', ...
    'Label', 'Hi-res (600 dpi) ...', ...
    'Callback', {@cb_print, 'image', 600})
uimenu(menu_print, ...
    'Tag', 'MENU.Print.HR1200', ...
    'Label', 'Hi-res (1200 dpi) ...', ...
    'Callback', {@cb_print, 'image', 1200})
uimenu(menu_print, ...
    'Separator', 'on', ...
    'Tag', 'MENU.Print.Grayscale', ...
    'Label', 'Grayscale ...', ...
    'Callback', {@cb_print, [], [], 'gray'})
uimenu(menu_print, ...
    'Tag', 'MENU.Print.VectorialGrayscale', ...
    'Label', 'Vectorial grayscale ...', ...
    'Callback', {@cb_print, 'vector', [], 'gray'})
uimenu(menu_print, ...
    'Separator', 'on', ...
    'Tag', 'MENU.Print.CMYK', ...
    'Label', 'CMYK ...', ...
    'Callback', {@cb_print, [], [], 'cmyk'})
uimenu(menu_print, ...
    'Tag', 'MENU.Print.VEctorialCMYK', ...
    'Label', 'Vectorial CMYK ...', ...
    'Callback', {@cb_print, 'vector', [], 'cmyk'})

value = menu_print;
%%%% ¡calculate_callbacks!
function cb_print(~, ~, contenttype, resolution, colorspace)
    if nargin < 5 || isempty(colorspace)
        colorspace = 'rgb';
    end
    if nargin < 4 || isempty(resolution)
        resolution = 150;
    end
    if nargin < 3 || isempty(contenttype)
        contenttype = 'auto';
    end        
    braph2print(gui.get('PF').get('H'), [], 'ContentType', contenttype, 'Resolution', resolution, 'Colorspace', colorspace)
end

%%% ¡prop!
MENU_PRINT (gui, logical) determines whether to show the menu to print to image file.
%%%% ¡default!
true

%%% ¡prop!
H_MENU_GUI_SETTINGS (evanescent, handle) is the handle of the menu settings.
%%%% ¡calculate!
menu_settings = uimenu(gui.memorize('H'), ... % f for figure
    'Tag', 'MENU.Settings', ...
    'Label', 'Settings' ...
    );

uimenu(menu_settings, ...
    'Tag', 'MENU.Settings.Settings', ...
    'Label', 'Settings ...', ...
    'Callback', {@cb_settings})

value = menu_settings;
%%%% ¡calculate_callbacks!
function cb_settings(~, ~)
	gui_settings = gui.memorize('GUI_SETTINGS');

    if ~gui_settings.get('DRAWN')
        gui_settings.get('DRAW')
        gui_settings.get('SHOW')
    else
        if get(gui_settings.get('H'), 'Visible')
            gui_settings.get('HIDE')
        else
            gui_settings.get('SHOW')
        end
    end
end

%%% ¡prop!
MENU_GUI_SETTINGS (gui, logical) determines whether to show the menu settings.
%%%% ¡default!
true

%%% ¡prop!
H_MENU_PERSONALIZE (evanescent, handle) is the handle of the menu personalize.
%%%% ¡calculate!
menu_personalize = uimenu(gui.memorize('H'), ... % f for figure
    'Tag', 'MENU.Personalize', ...
    'Label', 'Personalize' ...
    );

uimenu(menu_personalize, ...
    'Tag', 'MENU.Personalize.Layout', ...
    'Label', 'Layout ...', ...
    'Callback', {@cb_layout})

value = menu_personalize;
%%%% ¡calculate_callbacks!
function cb_layout(~, ~)
    gui_layout = gui.memorize('GUI_LAYOUT');

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

%%% ¡prop!
TOOL_PRINT (gui, logical) determines whether to show the toolbar print button.
%%%% ¡default!
true

%%% ¡prop!
TOOL_GUI_SETTINGS (gui, logical) determines whether to show the toolbar settings buttons.
%%%% ¡default!
true

%% ¡tests!

%%% ¡excluded_props!
[GUIFig.H GUIFig.PF GUIFig.GUI_LAYOUT GUIFig.GUI_SETTINGS GUIFig.H_MENUBAR GUIFig.H_MENU_ABOUT GUIFig.H_TOOLBAR GUIFig.H_TOOLS]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':GUIFig'])
assert(length(findall(0, 'type', 'figure')) == 17)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':GUIFig'])

%%% ¡test!
%%%% ¡name!
Basics
%%%% ¡probability!
.01
%%%% ¡code!
pf = PanelFig();
gui = GUIFig('PF', pf, 'POSITION', [0 .5 .1 .5], 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')
f = gui.get('H');
assert(check_graphics(f, 'figure'))

gui_layout = gui.memorize('GUI_LAYOUT');
gui_layout.get('DRAW')
gui_layout.get('SHOW')
f_layout = gui_layout.get('H');
assert(check_graphics(f_layout, 'figure'))

gui_settings = gui.memorize('GUI_SETTINGS');
gui_settings.get('DRAW')
gui_settings.get('SHOW')
f_settings = gui_settings.get('H');
assert(check_graphics(f_settings, 'figure'))

% All these tests only work using PanelPropItem instead of SettingsPositionPP
%
% gui_item_1 = gui_settings.get('PE').get('PR_DICT').get('IT', 2).memorize('GUI_ITEM');
% gui_item_1.get('DRAW')
% gui_item_1.get('SHOW')
% 
% gui_item_2 = gui_item_1.get('PE').get('PR_DICT').get('IT', 3).memorize('GUI_ITEM');
% gui_item_2.get('DRAW')
% gui_item_2.get('SHOW')
% 
% gui_item_3 = gui_item_2.get('PE').get('PR_DICT').get('IT', 3).memorize('GUI_ITEM');
% gui_item_3.get('DRAW')
% gui_item_3.get('SHOW')
% 
% gui_item_4 = gui_item_3.get('PE').get('PR_DICT').get('IT', 3).memorize('GUI_ITEM');
% gui_item_4.get('DRAW')
% gui_item_4.get('SHOW')
% 
% gui_item_5 = gui_item_4.get('PE').get('PR_DICT').get('IT', 3).memorize('GUI_ITEM');
% gui_item_5.get('DRAW')
% gui_item_5.get('SHOW')

gui.get('CLOSE')

gui.get('HIDE')
gui.get('CLOSE')
assert(isa(gui.getr('H'), 'NoValue'))
assert(~check_graphics(f, 'figure'))
assert(isa(gui_layout.getr('H'), 'NoValue'))
assert(~check_graphics(f_layout, 'figure'))
assert(isa(gui_settings.getr('H'), 'NoValue'))
assert(~check_graphics(f_settings, 'figure'))
