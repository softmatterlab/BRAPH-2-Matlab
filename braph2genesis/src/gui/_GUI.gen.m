%% ¡header!
GUI < ConcreteElement (gui, graphical user interface) renders a GUI figure.

%%% ¡description!
A GUI renders a figure with its basic functionalities.

CONSTRUCTOR - To construct a GUI use, e.g.:

    gui = GUI('<strong>TITLE</strong>', 'Figure Title', '<strong>POSITION</strong>', [x0 y0 w h], '<strong>BKGCOLOR</strong>', [r g b]);
    
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
uifigure, GUIElement, GUIFig

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the graphical user interface.
%%%% ¡default!
'GUI'

%%% ¡prop!
NAME (constant, string) is the name of the graphical user interface.
%%%% ¡default!
'GUI'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the graphical user interface.
%%%% ¡default!
'A GUI renders a figure with its basic functionalities.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the graphical user interface.
%%%% ¡settings!
'GUI'

%%% ¡prop!
ID (data, string) is a few-letter code for the graphical user interface.
%%%% ¡default!
'GUI ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graphical user interface.
%%%% ¡default!
'GUI label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graphical user interface.
%%%% ¡default!
'GUI notes'

%% ¡props!

%%% ¡prop!
WAITBAR (gui, logical) detemines whether to show the waitbar.

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
DRAWN (query, logical) returns whether the GUI has been drawn.
%%%% ¡calculate!
value = check_graphics(gui.getr('H'), 'figure');

%%% ¡prop!
TITLE (gui, string) is the name of the GUI.
%%%% ¡default!
BRAPH2.STR
%%%% ¡postset!
if gui.get('DRAWN')
    set(gui.get('H'), 'Name', gui.get('TITLE'))
end

%%% ¡prop!
POSITION (gui, rvector) is the normalized position of the GUI on the screen.
%%%% ¡default!
[.00 .00 (PanelElement.getPropDefault('MIN_WIDTH')+20)/w(0, 'pixels') 1.00]
%%%% ¡check_prop!
check = (length(value) == 4) && all(value(3:4) >= 0);
%%%% ¡postset!
if gui.get('DRAWN')
    set(gui.get('H'), 'Position', gui.get('POSITION'))
end

%%% ¡prop!
BKGCOLOR (gui, color) is the GUI background color.
%%%% ¡default!
BRAPH2.COL_BKG
%%%% ¡postset!
if gui.get('DRAWN')
    set(gui.get('H'), 'Color', gui.get('BKGCOLOR'))
end

%%% ¡prop!
H_MENUBAR (evanescent, handlelist) is the list of handles for the menus.
%%%% ¡calculate!
value = {};
if gui.get('MENU_ABOUT')
    value = [value, gui.memorize('H_MENU_ABOUT')];
end

%%% ¡prop!
MENUBAR (gui, logical) determines whether to show the menubar [set before DRAW].
%%%% ¡default!
false

%%% ¡prop!
H_MENU_ABOUT (evanescent, handle) is the handle of the menu about.
%%%% ¡calculate!
menu_about = uimenu(gui.get('H'), ... % f for figure
    'Tag', 'MENU.About', ...
    'Label', 'About' ...
    );

uimenu(menu_about, ...
    'Tag', 'MENU.About.Web', ...
    'Label', 'BRAPH.org ...', ...
    'Callback', 'BRAPH2.web()')
uimenu(menu_about, ...
    'Tag', 'MENU.About.Forum', ...
    'Label', 'Forums ...', ...
    'Callback', 'BRAPH2.forum()')
uimenu(menu_about, ...
    'Tag', 'MENU.About.Bluesky', ...
    'Label', 'Bluesky ...', ...
    'Callback', 'BRAPH2.bluesky()')
uimenu(menu_about, ...
    'Tag', 'MENU.About.License', ...
    'Label', 'License ...', ...
    'Callback', 'BRAPH2.license()')
uimenu(menu_about, ...
    'Tag', 'MENU.About.Credits', ...
    'Label', 'Credits ...', ...
    'Callback', 'BRAPH2.credits()')

value = menu_about;

%%% ¡prop!
MENU_ABOUT (gui, logical) determines whether to show the menu about [set before DRAW].
%%%% ¡default!
false

%%% ¡prop!
H_TOOLBAR (evanescent, handle) is the handle list of the toolbar.
%%%% ¡calculate!
value = uitoolbar(gui.memorize('H'), 'Tag', 'TOOLBAR');

%%% ¡prop!
H_TOOLS (evanescent, handlelist) is the handle list of the tools from the first.
%%%% ¡calculate!
toolbar = gui.memorize('H_TOOLBAR');

value = {};

if gui.get('TOOL_ABOUT')
    tool_spacer_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');

    % Website
    tool_about_web = uipushtool(toolbar, ...
        'Tag', 'BRAPH2.Web', ...                
        'Separator', 'on', ...
        'Tooltip', 'Link to braph.org', ...
        'CData', imread('icon_web.png'), ...
        'ClickedCallback', 'BRAPH2.web()');

    % Forum
    tool_about_forum = uipushtool(toolbar, ...
        'Tag', 'BRAPH2.Forum', ...                
        'Separator', 'off', ...
        'Tooltip', 'Link to the BRAPH 2.0 forums', ...
        'CData', imread('icon_forum.png'), ...
        'ClickedCallback', 'BRAPH2.forum()');

    % Bluesky
    tool_about_bluesky = uipushtool(toolbar, ...
        'Tag', 'BRAPH2.Bluesky', ...                
        'Separator', 'off', ...
        'Tooltip', 'Link to the BRAPH 2.0 Bluesky', ...
        'CData', imread('icon_twitter.png'), ...
        'ClickedCallback', 'BRAPH2.bluesky()');

    tool_spacer_2 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');

    % License
    tool_about_license = uipushtool(toolbar, ...
        'Tag', 'BRAPH2.License', ...                
        'Separator', 'on', ...
        'Tooltip', 'BRAPH 2.0 License', ...
        'CData', imread('icon_license.png'), ...
        'ClickedCallback', 'BRAPH2.license()');

    % Credits
    tool_about_credits = uipushtool(toolbar, ...
        'Tag', 'BRAPH2.Credits', ...                
        'Separator', 'off', ...
        'Tooltip', 'Informtion about BRAPH 2.0 and credits', ...
        'CData', imread('icon_about.png'), ...
        'ClickedCallback', 'BRAPH2.credits()');
    
    value = {value{:}, tool_spacer_1, tool_about_web, tool_about_forum, tool_about_bluesky, tool_spacer_2, tool_about_license, tool_about_credits};
end

%%% ¡prop!
TOOLBAR (gui, logical) determines whether to show the toolbar [set before DRAW].
%%%% ¡default!
false

%%% ¡prop!
TOOL_ABOUT (gui, logical) determines whether to show the toolbar about buttons [set before DRAW].
%%%% ¡default!
false

%%% ¡prop!
CLOSEREQ (gui, logical) determines whether to confirm close.
%%%% ¡default!
true

%%% ¡prop!
H (evanescent, handle) is the figure handle.
%%%% ¡calculate!
f = uifigure( ...
    'Visible', 'off', ...
    'Tag', 'H', ...
    'UserData', gui, ... % handle to retrieve gui
    'Name', gui.get('TITLE'), ...
    'Units', 'normalized', ...
    'Position', gui.get('POSITION'), ...
    'Color', gui.get('BKGCOLOR'), ...
    'Icon', 'braph2icon.png', ...
    'AutoResizeChildren', false, ...
    'SizeChangedFcn', {@cb_get, 'RESIZE'}, ...
    'DeleteFcn', {@cb_get, 'DELETE'}, ...
    'CloseRequestFcn', {@cb_get, 'CLOSE'} ...
    );
value = f;

%%% ¡prop!
RESIZE (query, logical) updates POSITION when figure size is changed.
%%%% ¡calculate!
if gui.get('DRAWN')
    gui.set('POSITION', gui.get('H').get('Position'))
    
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(gui)], ...
        [BRAPH2.STR ':' class(gui) '\\n' ...
        'The call gui.get(''RESIZE'') has NOT been executed.\\n' ...
        'First, the gui ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
SHOW (query, logical) shows the figure and its dependent figures.
%%%% ¡calculate!
if gui.get('DRAWN')
    figure(gui.get('H')) 
    set(gui.get('H'), ...
        'Visible', 'on', ...
        'WindowState', 'normal' ...
        )

    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(gui)], ...
        [BRAPH2.STR ':' class(gui) '\\n' ...
        'The call gui.get(''SHOW'') has NOT been executed.\\n' ...
        'First, the gui ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
HIDE (query, logical) hides the figure and its dependent figures.
%%%% ¡calculate!
if gui.get('DRAWN')
    set(gui.get('H'), 'Visible', 'off')

    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(gui)], ...
        [BRAPH2.STR ':' class(gui) '\\n' ...
        'The call gui.get(''HIDE'') has NOT been executed.\\n' ...
        'First, the gui ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the figure is deleted.
%%%% ¡calculate!
if gui.get('DRAWN')
    gui.set('POSITION', gui.get('H').get('Position'))

    gui.set('H', Element.getNoValue())

    gui.set('H_MENUBAR', Element.getNoValue())
    gui.set('H_MENU_ABOUT', Element.getNoValue())

    gui.set('H_TOOLBAR', Element.getNoValue())
    gui.set('H_TOOLS', Element.getNoValue())
    
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(gui)], ...
        [BRAPH2.STR ':' class(gui) '\\n' ...
        'The call gui.get(''DELETE'') has NOT been executed.\\n' ...
        'First, the gui ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\\n' ...
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

%% ¡tests!

%%% ¡excluded_props!
[GUI.H]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':GUI'])
assert(length(findall(0, 'type', 'figure')) == 2)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':GUI'])

%%% ¡test!
%%%% ¡name!
Basics
%%%% ¡probability!
.01
%%%% ¡code!
gui = GUI( ...
    'POSITION', [w(0, 'normalized')/4 h(0, 'normalized')/4 w(0, 'normalized')/2 h(0, 'normalized')/2], ...
    'MENUBAR', true, ...
    'MENU_ABOUT', true, ...
    'TOOLBAR', true, ...
    'TOOL_ABOUT', true, ...
    'CLOSEREQ', false ...
    );
assert(~gui.get('DRAWN'))

for i = 1:2
    gui.get('DRAW')
    assert(gui.get('DRAWN'))
    f = gui.get('H');
    assert(check_graphics(f, 'figure'))

    gui.get('SHOW')
    assert(gui.get('DRAWN'))

    gui.get('HIDE')
    assert(gui.get('DRAWN'))

    gui.get('SHOW')
    assert(gui.get('DRAWN'))

    gui.get('CLOSE')
    assert(~gui.get('DRAWN'))
    assert(~check_graphics(f, 'figure'))
    assert(isa(gui.getr('H'), 'NoValue'))
end