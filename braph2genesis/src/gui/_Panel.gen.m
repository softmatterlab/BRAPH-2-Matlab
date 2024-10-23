%% ¡header!
Panel < ConcreteElement (pn, panel) is a panel.

%%% ¡description!
A Panel is the basic element to manage graphical representations of elements.
 It is an empty graphical panel. It is filled with the graphical content 
 representing an element (PanelElement) or figure (PanelFig) or property 
 (typically, PanelProp and derived classes). It must be placed within 
 another container; for example, a figure (e.g., PanelElement into 
 GUIElement, or PanelFig into GUIFig) or another panel (e.g., PanelProp 
 into PanelElement).

CONSTRUCTOR - To construct a Panel use, e.g.:

    pn = Panel('<strong>PARENT</strong>', <parent element>);

 where the <parent element> can be a GUI or a Panel.

DRAW - To draw the panel, call:
    
    pn.get('<strong>DRAW</strong>'[, 'Name', <value>, ...])
    p = pn.get('<strong>H</strong>'); % p is the handle of the generated panel
 
 The query pn.get('<strong>DRAWN</strong>') returns whether the Panel has 
  been drawn and therefore can be shown.

CALLBACKS - These are the public callback (to be further implemented by the derived panels):

    pn.get('<strong>SHOW</strong>') - shows the figure containing the panel.
    pn.get('<strong>HIDE</strong>') - hides the figure containing the panel.
    pn.get('<strong>DELETE</strong>') - resets the handles when the panel is deleted.
    pn.get('<strong>CLOSE</strong>') - closes the figure containing the panel.

%%% ¡seealso!
uipanel, PanelElement, PanelProp, PanelFig, GUI, GUIElement, GUIFig

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel.
%%%% ¡default!
'Panel'

%%% ¡prop!
NAME (constant, string) is the name of the panel.
%%%% ¡default!
'Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel.
%%%% ¡default!
'A Panel is the basic element to manage graphical representations of elements. It is an empty graphical panel. It is filled with the graphical content representing an element (PanelElement) or figure (PanelFig) or property (typically, PanelProp and derived classes). It must be placed within another container; for example, a figure (e.g., PanelElement into GUIElement, or PanelFig into GUIFig) or another panel (e.g., PanelProp into PanelElement).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel.
%%%% ¡settings!
'Panel'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel.
%%%% ¡default!
'Panel ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel.
%%%% ¡default!
'Panel label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel.
%%%% ¡default!
'Panel notes'

%% ¡props!

%%% ¡prop!
WAITBAR (gui, logical) detemines whether to show the waitbar.

%%% ¡prop!
H_WAITBAR (evanescent, handle) is the waitbar handle.

%%% ¡prop!
DRAW (query, logical) draws the panel [accepts uipanel Name-Value pairs].
%%%% ¡calculate!
if check_graphics(pn.memorize('H'), 'uipanel') % H = p for panel
    p = pn.get('H');
    
    if ~isempty(varargin)
        set(p, varargin{:})
    end
    
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pn)], ...
        [BRAPH2.STR ':' class(pn) '\\n' ...
        'The call pn.get(''DRAW'') did not work.\\n' ...
        'This shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
DRAWN (query, logical) returns whether the panel has been drawn.
%%%% ¡calculate!
value = check_graphics(pn.getr('H'), 'uipanel'); % H = p for panel

%%% ¡prop!
PARENT (gui, item) is the panel parent.
%%%% ¡default!
GUI()
%%%% ¡check_prop!
check = isa(value, 'GUI') || isa(value, 'Panel');
%%%% ¡postset!
if check_graphics(pn.getr('H'), 'uipanel') % H = p for panel
    set(pn.get('H'), 'Parent', pn.get('PARENT').get('H')) % H = f for GUI and H = p for Panel
end

%%% ¡prop!
BKGCOLOR (figure, color) is the panel background color.
%%%% ¡default!
BRAPH2.COL_BKG
%%%% ¡postset!
if pn.get('DRAWN') && ~isequal(get(pn.get('H'), 'BackgroundColor'), pn.get('BKGCOLOR'))
    set(pn.get('H'), 'BackgroundColor', pn.get('BKGCOLOR'))
end

%%% ¡prop!
H (evanescent, handle) is the panel handle.
%%%% ¡calculate!
p = uipanel( ...
    'Parent', pn.memorize('PARENT').memorize('H'), ... % H = f for GUI and H = p for Panel
    'Tag', 'H', ...
    'UserData', pn, ... % handle to retrieve the panel
    'BackgroundColor', pn.get('BKGCOLOR'), ...
    'BorderType', 'none', ...
    'DeleteFcn', {@cb_get, 'DELETE'} ...
    );
value = p;

%%% ¡prop!
SHOW (query, logical) shows the figure containing the panel.
%%%% ¡calculate!
if pn.get('DRAWN')
    if get_from_varargin(true, 'ShowParentFigure', varargin)
        pn.get('PARENT').get('SHOW')
    end
    
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pn)], ...
        [BRAPH2.STR ':' class(pn) '\\n' ...
        'The call pn.get(''SHOW'') has NOT been executed.\\n' ...
        'First, the panel ' pn.get('ID') ' should be drawn calling pn.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
HIDE (query, logical) hides the figure containing the panel.
%%%% ¡calculate!
if pn.get('DRAWN')
    if get_from_varargin(true, 'HideParentFigure', varargin)
        pn.get('PARENT').get('HIDE')
    end
    
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pn)], ...
        [BRAPH2.STR ':' class(pn) '\\n' ...
        'The call pn.get(''HIDE'') has NOT been executed.\\n' ...
        'First, the panel ' pn.get('ID') ' should be drawn calling pn.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
if pn.get('DRAWN')
    pn.set('H', Element.getNoValue())

    pn.set('H_WAITBAR', Element.getNoValue())
    
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pn)], ...
        [BRAPH2.STR ':' class(pn) '\\n' ...
        'The call pn.get(''DELETE'') has NOT been executed.\\n' ...
        'First, the panel ' pn.get('ID') ' should be drawn calling pn.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
CLOSE (query, logical) closes the figure containing the panel.
%%%% ¡calculate!
if pn.get('DRAWN')
    if get_from_varargin(true, 'CloseParentFigure', varargin)
        pn.get('PARENT').get('CLOSE')
    end
    
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pn)], ...
        [BRAPH2.STR ':' class(pn) '\\n' ...
        'The call pn.get(''CLOSE'') has NOT been executed.\\n' ...
        'First, the panel ' pn.get('ID') ' should be drawn calling pn.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%% ¡tests!

%%% ¡excluded_props!
[Panel.PARENT Panel.H]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':Panel'])
assert(length(findall(0, 'type', 'figure')) == 2)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':Panel'])

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
gui = GUI('CLOSEREQ', false);

pn = Panel( ...
    'PARENT', gui, ...
    'BKGCOLOR', [1 0 0] ...
    );
assert(~pn.get('DRAWN'))

for i = 1:2
    pn.get('DRAW', 'Units', 'normalized', 'Position', [.25 .25 .50 .50])
    assert(pn.get('DRAWN'))
    p = pn.get('H');
    assert(check_graphics(p, 'uipanel'))
    f = pn.get('PARENT').get('H');
    assert(check_graphics(f, 'figure'))

    pn.get('SHOW')
    assert(pn.get('DRAWN'))

    pn.get('HIDE')
    assert(pn.get('DRAWN'))

    pn.get('SHOW')
    assert(pn.get('DRAWN'))

    pn.get('CLOSE')
    assert(~pn.get('DRAWN'))
    assert(~check_graphics(pn, 'uipanel'))
    assert(isa(pn.getr('H'), 'NoValue'))
    assert(~check_graphics(f, 'figure'))
    assert(isa(pn.get('PARENT').getr('H'), 'NoValue'))
end