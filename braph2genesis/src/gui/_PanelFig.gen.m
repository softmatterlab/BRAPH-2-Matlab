%% ¡header!
PanelFig < Panel (pf, figure panel) plots the panel of a figure.

%%% ¡description!
A Figure Panel (PanelFig) plots a figure.

CONSTRUCTOR - To construct a PanelFig use, e.g.:

    pf = PanelFig('<strong>PARENT</strong>', <parent element>)
  
 where the <parent element> can be a GUI or a Panel, 
  but most often a GUIFig.
  
DRAW - To draw the panel, call:

    pf.get('<strong>DRAW</strong>'[, 'Name', <value>, ...])
    p = pf.get('<strong>H</strong>'); % p is the handle of the generated panel
 
 The query pf.get('<strong>DRAWN</strong>') returns whether the Panel has 
  been drawn and therefore can be shown.
  
CALLBACKS - These are the public callback (to be further implemented by the derived panels):

    pf.get('<strong>SHOW</strong>') - shows the figure containing the panel.
    pf.get('<strong>HIDE</strong>') - hides the figure containing the panel.
    pf.get('<strong>DELETE</strong>') - resets the handles when the panel is deleted.
    pf.get('<strong>CLOSE</strong>') - closes the figure containing the panel.
    pf.get('<strong>RESIZEX</strong>') - resizes the x-extension of the element panel and its prop panels.
    pf.get('<strong>RESIZEY</strong>') - resizes the y-extension of the element panel and its prop panels.

%%% ¡seealso!
uipanel, GUIFig, Settings

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the figure panel.
%%%% ¡default!
'PanelFig'

%%% ¡prop!
NAME (constant, string) is the name of the figure panel.
%%%% ¡default!
'Figure Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the figure panel.
%%%% ¡default!
'A Figure Panel (PanelFig) plots a figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the figure panel.
%%%% ¡settings!
'PanelFig'

%%% ¡prop!
ID (data, string) is a few-letter code for the figure panel.
%%%% ¡default!
'PanelFig ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the figure panel.
%%%% ¡default!
'PanelFig label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the figure panel.
%%%% ¡default!
'PanelFig notes'

%%% ¡prop!
BKGCOLOR (figure, color) is the panel background color.
%%%% ¡default!
[1 1 1]

%%% ¡prop!
DRAW (query, logical) draws the figure panel.
%%%% ¡calculate!
if check_graphics(pf.memorize('H'), 'uipanel') % H = p for panel
    
    pf.memorize('ST_POSITION').set('PANEL', pf, 'PROP', pf.H).get('SETUP')
    
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pf)], ...
        [BRAPH2.STR ':' class(pf) '\\n' ...
        'The call pf.get(''DRAW'') did not work.\\n' ...
        'This shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the figure panel is deleted.
%%%% ¡calculate!
value = calculateValue@Panel(pf, Panel.DELETE, varargin{:}); % also warning
if value
    pf.set('H_TOOLBAR', Element.getNoValue())
    pf.set('H_TOOLS', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
ST_POSITION (figure, item) determines the panel position.
%%%% ¡settings!
'SettingsPosition'
%%%% ¡gui!
pr = SettingsPositionPP('EL', pf, 'PROP', PanelFig.ST_POSITION, varargin{:});

%%% ¡prop!
H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.
%%%% ¡calculate!
value = findobj(ancestor(pf.memorize('PARENT').memorize('H'), 'Figure'), 'Tag', 'TOOLBAR');

%%% ¡prop!
H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
%%%% ¡calculate!
value = {};

%% ¡tests!

%%% ¡excluded_props!
[PanelFig.PARENT PanelFig.H PanelFig.ST_POSITION]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelFig'])
assert(length(findall(0, 'type', 'figure')) == 3)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelFig'])

%%% ¡test!
%%%% ¡name!
Example 1
%%%% ¡probability!
.01
%%%% ¡code!
gui = GUI('MENUBAR', true, 'MENU_ABOUT', true, 'TOOLBAR', true, 'TOOL_ABOUT', true, 'CLOSEREQ', false);
pf = PanelFig('PARENT', gui);
pf.get('DRAW')
pf.get('SHOW')

pf.set('BKGCOLOR', [1 0 0])

pf.get('ST_POSITION').set('AUTOPOS', false, 'X0', 10, 'Y0', 20, 'WIDTH', 100, 'HEIGHT', 200)

pf.get('ST_POSITION').set('AUTOPOS', true)

pf.get('ST_POSITION').set('AUTOPOS', false)

pf.get('CLOSE')
