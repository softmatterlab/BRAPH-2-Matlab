%% ¡header!
PanelProp < Panel (pr, prop panel) is a property panel.

%%% ¡description!
A Prop Panel (PanelProp) renders a property of an element in a panel. 
 It contains a text with the prop tag and a tooltip with the prop description.
 For parameter, data, figure and gui callbacks, it also features a callback button.
 For results, it features calculate and delete buttons.
 It is typically employed in one of its derived forms, 
 where also the contents of the element property are shown.

 Children of PanelProp should update the props:
  <strong>X_DRAW</strong> - to initially create the panel and its graphical objects
  <strong>UPDATE</strong> - to update the information content of the panel and of the element
  <strong>REDRAW</strong> - to resize the panel and reposition its graphical objcts
  <strong>HEIGHT</strong> - to determine the height of the panel

CONSTRUCTOR - To construct a PanelProp use, e.g.:

	pr = PanelProp('<strong>PARENT</strong>', <parent element>, '<strong>EL</strong>', <element>)
    
 where the <parent element> is most often a PanelElement.
   
DRAW - To create the initial prop panel (title text and buttons), call:

    pr.get('<strong>DRAW</strong>'[, 'Name', <value>, ...])
    p = pr.get('<strong>H</strong>'); % p is the handle of the generated panel

 The query pn.get('<strong>DRAWN</strong>') returns whether the Panel has 
  been drawn and therefore can be shown.

UPDATE - Updates the information content of the panel and of the element.
  Typically, it does not need to be called explicitly.
  It is internally called by PanelElement when needed.

REDRAW - Resizes the panel and repositions its graphical objcts.
  Typically, it does not need to be called explicitly.
  It is internally called by PanelElement when needed.

CALLBACKS - These are the public callback (to be further implemented by the derived panels):

    pn.get('<strong>SHOW</strong>') - shows the figure containing the panel.
    pn.get('<strong>HIDE</strong>') - hides the figure containing the panel.
    pn.get('<strong>DELETE</strong>') - resets the handles when the panel is deleted.
    pn.get('<strong>CLOSE</strong>') - closes the figure containing the panel.

%%% ¡seealso!
uipanel, uilabel, uibutton, GUI, GUIElement, PanelElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the property panel.
%%%% ¡default!
'PanelProp'

%%% ¡prop!
NAME (constant, string) is the name of the property panel.
%%%% ¡default!
'Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the property panel.
%%%% ¡default!
'A Prop Panel (PanelProp) renders a property of an element in a panel.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the property panel.
%%%% ¡settings!
'PanelProp'

%%% ¡prop!
ID (data, string) is a few-letter code for the property panel.
%%%% ¡default!
'PanelProp ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the property panel.
%%%% ¡default!
'PanelProp label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the property panel.
%%%% ¡default!
'PanelProp notes'

%%% ¡prop!
DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@Panel(pr, Panel.DRAW, varargin{:}); % also warning
if value
    switch pr.get('EL').getPropCategory(pr.get('PROP'))
        case {Category.CONSTANT Category.METADATA} % {__Category.CONSTANT__ __Category.METADATA__}
            pr.memorize('LABEL_TITLE')

            pr.memorize('LISTENER_SET')
            pr.memorize('LISTENER_LOCKED')

        case {Category.PARAMETER Category.DATA Category.FIGURE Category.GUI} % {__Category.PARAMETER__ __Category.DATA__ __Category.FIGURE__ __Category.GUI__}
            pr.memorize('LABEL_TITLE')

            pr.memorize('BUTTON_CB')

            pr.memorize('LISTENER_SET')
            pr.memorize('LISTENER_LOCKED')

        case {Category.RESULT Category.QUERY Category.EVANESCENT} % {__Category.RESULT__ __Category.QUERY__ __Category.EVANESCENT__}
            pr.memorize('LABEL_TITLE')

            pr.memorize('BUTTON_CALC')
            pr.memorize('BUTTON_DEL')

            pr.memorize('LISTENER_SET')
            pr.memorize('LISTENER_MEMORIZED')
            pr.memorize('LISTENER_LOCKED')
    end

    pr.get('X_DRAW')    
    pr.get('UPDATE')
    pr.get('REDRAW')
end

%%% ¡prop!
SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.
%%%% ¡calculate!
if pr.get('DRAWN')

    calculateValue@Panel(pr, Panel.SHOW, varargin{:}); % Panel.SHOW = __Panel.SHOW__

    % figure cb
    if isa(pr.getr('GUI_CB'), 'GUI') && pr.get('GUI_CB').get('DRAWN')
        pr.get('GUI_CB').get('SHOW')
    end
    
	value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pr)], ...
        [BRAPH2.STR ':' class(pr) '\\n' ...
        'The call pr.get(''SHOW'') has NOT been executed.\\n' ...
        'First, the panel ' pr.get('ID') ' should be drawn calling pr.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.
%%%% ¡calculate!
if pr.get('DRAWN')

    calculateValue@Panel(pr, Panel.HIDE, varargin{:}); % Panel.HIDE = __Panel.HIDE__
    
    % figure cb
    if isa(pr.getr('GUI_CB'), 'GUI') && pr.get('GUI_CB').get('DRAWN')
        pr.get('GUI_CB').get('HIDE')
    end
    
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pr)], ...
        [BRAPH2.STR ':' class(pr) '\\n' ...
        'The call pr.get(''HIDE'') has NOT been executed.\\n' ...
        'First, the panel ' pr.get('ID') ' should be drawn calling pr.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@Panel(pr, Panel.DELETE, varargin{:}); % Panel.DELETE = __Panel.DELETE__ % also warning
if value
    pr.set('LABEL_TITLE', Element.getNoValue())
    
    pr.set('BUTTON_CB', Element.getNoValue())
    pr.set('LISTENER_CB', Element.getNoValue())

    pr.set('BUTTON_CALC', Element.getNoValue())
    pr.set('BUTTON_DEL', Element.getNoValue())
    
    pr.set('LISTENER_SET', Element.getNoValue())
    pr.set('LISTENER_MEMORIZED', Element.getNoValue())
    pr.set('LISTENER_LOCKED', Element.getNoValue())   
end

%%% ¡prop!
CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.
%%%% ¡calculate!
if pr.get('DRAWN')

    calculateValue@Panel(pr, Panel.CLOSE, varargin{:}); % Panel.CLOSE = __Panel.CLOSE__
    
    % figure cb
    if isa(pr.getr('GUI_CB'), 'GUI') && pr.get('GUI_CB').get('DRAWN')
        pr.get('GUI_CB').get('CLOSE')
    end
    
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pr)], ...
        [BRAPH2.STR ':' class(pr) '\\n' ...
        'The call pr.get(''CLOSE'') has NOT been executed.\\n' ...
        'First, the panel ' pr.get('ID') ' should be drawn calling pr.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%% ¡props!

%%% ¡prop!
X_DRAW (query, logical) draws the graphical objects of the prop panel [to be implemented in subelements].
%%%% ¡calculate!
value = true;

%%% ¡prop!
UPDATE (query, logical) updates the content of the prop panel and its graphical objects.
%%%% ¡calculate!
if pr.get('DRAWN')
    switch pr.get('EL').getPropCategory(pr.get('PROP'))
        case {Category.CONSTANT Category.METADATA} % {__Category.CONSTANT__ __Category.METADATA__}
            %

        case {Category.PARAMETER Category.DATA Category.FIGURE Category.GUI} % {__Category.PARAMETER__ __Category.DATA__ __Category.FIGURE__ __Category.GUI__}
            prop_value = pr.get('EL').getr(pr.get('PROP'));
            if isa(prop_value, 'Callback')
                set(pr.get('BUTTON_CB'), ...
                    'Tooltip', prop_value.get('TOSTRING'), ...
                    'Visible', 'on' ...
                    )
            else
                set(pr.get('BUTTON_CB'), ...
                    'Visible', 'off' ...
                    )
            end

        case {Category.RESULT Category.EVANESCENT} % {__Category.RESULT__ __Category.EVANESCENT__}
            prop_value = pr.get('EL').getr(pr.get('PROP'));
            if isa(prop_value, 'NoValue')
                set(pr.get('BUTTON_CALC'), 'Enable', 'on')
                set(pr.get('BUTTON_DEL'), 'Enable', 'off')
            else
                set(pr.get('BUTTON_CALC'), 'Enable', 'off')
                set(pr.get('BUTTON_DEL'), 'Enable', 'on')
            end
            
        case Category.QUERY % __Category.QUERY__
            prop_value = get_from_varargin(pr.get('EL').getr(pr.get('PROP')), 'Value', varargin); % see BUTTON_CALC
            if isa(prop_value, 'NoValue')
                set(pr.get('BUTTON_CALC'), 'Enable', 'on')
                set(pr.get('BUTTON_DEL'), 'Enable', 'off')
            else
                set(pr.get('BUTTON_CALC'), 'Enable', 'on')
                set(pr.get('BUTTON_DEL'), 'Enable', 'on')
            end
            
    end
    
    % resets the LISTENER_CB
    pr.set('LISTENER_CB', Element.getNoValue())
    pr.memorize('LISTENER_CB');
    
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pr)], ...
        [BRAPH2.STR ':' class(pr) '\\n' ...
        'The call pr.get(''UPDATE'') has NOT been executed.\\n' ...
        'First, the prop panel ' pr.get('ID') ' should be drawn calling pr.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
REDRAW (query, logical) resizes the prop panel and repositions its graphical objects [accept Width-value pair].
%%%% ¡calculate!
if pr.get('DRAWN')
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    h_p = pr.get('HEIGHT'); % should be identical to h(pr.get('H'), 'pixels') 
                            % the panel height should be set to this value 
                            % by some external code controlling the PanelProp
    
    % places label_title to the top
    set(pr.get('LABEL_TITLE'), 'Position', [s(.3) h_p-s(1.3)+1 w_p s(1.3)])

    % places the relevant buttons (depending on category)
    switch pr.get('EL').getPropCategory(pr.get('PROP'))
        case {Category.CONSTANT Category.METADATA} % {__Category.CONSTANT__ __Category.METADATA__}
            %

        case {Category.PARAMETER Category.DATA Category.FIGURE Category.GUI} % {__Category.PARAMETER__ __Category.DATA__ __Category.FIGURE__ __Category.GUI__}
            set(pr.get('BUTTON_CB'), 'Position', [w_p-s(2.1) h_p-s(1.9) s(1.7) s(1.7)])

        case {Category.RESULT Category.QUERY Category.EVANESCENT} % {__Category.RESULT__ __Category.QUERY__ __Category.EVANESCENT__}
            set(pr.get('BUTTON_CALC'), 'Position', [w_p-s(4.2) h_p-s(1.9) s(1.7) s(1.7)])
            set(pr.get('BUTTON_DEL'), 'Position', [w_p-s(2.1) h_p-s(1.9) s(1.7) s(1.7)])
    end
     
    value = true;
else
    warning( ...
        [BRAPH2.STR ':' class(pr)], ...
        [BRAPH2.STR ':' class(pr) '\\n' ...
        'The call pr.get(''REDRAW'') has NOT been executed.\\n' ...
        'First, the prop panel ' pr.get('ID') ' should be drawn calling pr.get(''DRAW'').\\n' ...
        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
        )
    value = false;
end

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡postset!
pr.lock('EL', 'Iterative', false)
if ~isa(pr.getr('PROP'), 'NoValue')
    el = pr.get('EL');
    prop = pr.get('PROP');

    settings = {};
    if isa(pr.getr('ID'), 'NoValue')
        settings = [settings 'ID' el.getPropTag(prop)];
    end
    if isa(pr.getr('TITLE'), 'NoValue')
        settings = [settings 'TITLE' el.getPropTag(prop)];
    end
    if isa(pr.getr('BKGCOLOR'), 'NoValue')
        switch el.getPropCategory(prop)
            case Category.CONSTANT
                color = BRAPH2.COL_C;
            case Category.METADATA
                color = BRAPH2.COL_M;
            case Category.PARAMETER
                color = BRAPH2.COL_P;
            case Category.DATA
                color = BRAPH2.COL_D;
            case Category.RESULT
                color = BRAPH2.COL_R;
            case Category.QUERY
                color = BRAPH2.COL_Q;
            case Category.EVANESCENT
                color = BRAPH2.COL_E;
            case Category.FIGURE
                color = BRAPH2.COL_F;
            case Category.GUI
                color = BRAPH2.COL_G;
        end
        settings = [settings 'BKGCOLOR' color];
    end
    if ~isempty(settings)
        pr.set(settings{:})
    end
end

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
1
%%%% ¡postset!
pr.lock('PROP', 'Iterative', false)
if ~isa(pr.getr('EL'), 'NoValue')
    el = pr.get('EL');
    prop = pr.get('PROP');

    settings = {};
    if isa(pr.getr('ID'), 'NoValue')
        settings = [settings 'ID' el.getPropTag(prop)];
    end
    if isa(pr.getr('TITLE'), 'NoValue')
        settings = [settings 'TITLE' el.getPropTag(prop)];
    end
    if isa(pr.getr('BKGCOLOR'), 'NoValue')
        switch el.getPropCategory(prop)
            case Category.CONSTANT
                color = BRAPH2.COL_C;
            case Category.METADATA
                color = BRAPH2.COL_M;
            case Category.PARAMETER
                color = BRAPH2.COL_P;
            case Category.DATA
                color = BRAPH2.COL_D;
            case Category.RESULT
                color = BRAPH2.COL_R;
            case Category.QUERY
                color = BRAPH2.COL_Q;
            case Category.EVANESCENT
                color = BRAPH2.COL_E;
            case Category.FIGURE
                color = BRAPH2.COL_F;
            case Category.GUI
                color = BRAPH2.COL_G;
        end
        settings = [settings 'BKGCOLOR' color];
    end
    if ~isempty(settings)
        pr.set(settings{:})
    end
end

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the prop panel.
%%%% ¡default!
s(2)
%%%% ¡postset!
if pr.get('DRAWN')
    pr.get('REDRAW')
end

%%% ¡prop!
TITLE (gui, string) is the property title.

%%% ¡prop!
LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

pr_string_title = pr.get('TITLE');
if isempty(pr_string_title)
    pr_string_title = upper(el.getPropTag(prop));
end

label_title =  uilabel( ...
    'Parent', pr.get('H'), ... % H = p for Panel
    'Tag', 'LABEL_TAG', ...
    'Text', pr_string_title, ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'HorizontalAlignment', 'left', ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'BackgroundColor', pr.get('BKGCOLOR') ...
    );

value = label_title;

%%% ¡prop!
BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].
%%%% ¡calculate!
button_cb = uibutton( ...
    'Parent', pr.get('H'), ... % H = p for Panel
    'Tag', 'BUTTON_CB', ...
    'Text', '@', ...
    'FontWeight', 'bold', ...
    'ButtonPushedFcn', {@cb_button_cb}, ...
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    );
value = button_cb;
%%%% ¡calculate_callbacks!
function cb_button_cb(~, ~)
    gui_cb = pr.memorize('GUI_CB');

    % find repeating figures
    all_figs = findall(0, 'type', 'figure');
    for i = 1:1:length(all_figs)
        user_data = all_figs(i).get('UserData');
        if isa(user_data, 'GUIElement') && user_data.get('PE').get('EL') == gui_cb.get('PE').get('EL')
            user_data.get('PE').get('SHOW')
            return
        end
    end

    if ~gui_cb.get('DRAWN')
        gui_cb.get('DRAW')
        gui_cb.get('SHOW')
    else
        if get(gui_cb.get('H'), 'Visible')
            gui_cb.get('HIDE')
        else
            gui_cb.get('SHOW')
        end
    end
end

%%% ¡prop!
GUI_CB (data, item) is the handle to the item figure.
%%%% ¡settings!
'GUI'
%%%% ¡preset!
if isequal(value.getClass(), 'GUI') % i.e., default initialization
    el = pr.get('EL');
    prop = pr.get('PROP');

    if isa(el.getr(prop), 'Callback')
        f = ancestor(pr.get('H'), 'figure');

        value = GUIElement( ...
            'PE', el.getr(prop).get('EL'), ... % ensure that the element is stored
            'POSITION', [ ...
                x0(f, 'normalized')+w(f, 'normalized') ...
                y0(f, 'normalized') ...
                w(f, 'normalized') ...
                h(f, 'normalized') ...
                ], ...
            'WAITBAR', pr.getCallback('WAITBAR'), ...
            'CLOSEREQ', false ...
            );
    end
end

%%% ¡prop!
LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');
if isa(el.getr(prop), 'Callback')
    while isa(el.getr(prop), 'Callback')
        cb = el.getr(prop);
        el = cb.get('EL');
        prop = cb.get('PROP');
    end
    value = listener(el, 'PropSet', @cb_listener_cb); 
else
	value = gobjects(1);
end
%%%% ¡calculate_callbacks!
function cb_listener_cb(~, event)
    if any(cellfun(@(prop) prop, event.props), pr.get('PROP'))
        pr.get('UPDATE')
    end
end

%%% ¡prop!
BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].
%%%% ¡calculate!
button_calc = uibutton( ...
    'Parent', pr.get('H'), ... % H = p for Panel
    'Tag', 'BUTTON_CALC', ...
    'Text', 'C', ...
    'FontWeight', 'bold', ...
    'Tooltip', 'Calculate', ...
    'ButtonPushedFcn', {@cb_button_calc}, ...
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    );
value = button_calc;
%%%% ¡calculate_callbacks!
function cb_button_calc(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');

    switch el.getPropCategory(prop)
        case {Category.RESULT Category.EVANESCENT}

            el.memorize(prop);
            
            pr.get('UPDATE')
            pr.get('REDRAW')
            
        case Category.QUERY
            
            value = el.get(prop);
            
            pr.get('UPDATE', 'Value', value)
            pr.get('REDRAW')
            
    end
end

%%% ¡prop!
BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].
%%%% ¡calculate!
button_del = uibutton( ...
    'Parent', pr.get('H'), ... % H = p for Panel
    'Tag', 'BUTTON_DEL', ...
    'Text', 'D', ...
    'FontWeight', 'bold', ...
    'Tooltip', 'Delete', ...
    'ButtonPushedFcn', {@cb_button_del}, ...
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    );
value = button_del;
%%%% ¡calculate_callbacks!
function cb_button_del(~, ~)
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.set(prop, NoValue.getNoValue())
    
    pr.get('UPDATE')
    pr.get('REDRAW')    
end

%%% ¡prop!
LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.
%%%% ¡calculate!
value = {listener(pr.get('EL'), 'PropSet', @cb_listener_set)}; 
%%%% ¡calculate_callbacks!
function cb_listener_set(~, event)
    if ismember(pr.get('PROP'), cell2mat(event.props)) && pr.get('DRAWN')
        pr.get('UPDATE')
        pr.get('REDRAW')        
    end
end

%%% ¡prop!
LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.
%%%% ¡calculate!
value = {listener(pr.get('EL'), 'PropMemorized', @cb_listener_memorized)};
%%%% ¡calculate_callbacks!
function cb_listener_memorized(~, event)
    if pr.get('PROP') == event.prop && pr.get('DRAWN')
        pr.get('UPDATE')
        pr.get('REDRAW')        
    end
end

%%% ¡prop!
LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.
%%%% ¡calculate!
value = {listener(pr.get('EL'), 'PropLocked', @cb_listener_locked)};
%%%% ¡calculate_callbacks!
function cb_listener_locked(~, event)
    if pr.get('PROP') == event.prop && pr.get('DRAWN')
        pr.get('UPDATE')
        pr.get('REDRAW')
    end
end

%% ¡tests!

%%% ¡excluded_props!
[PanelProp.PARENT PanelProp.H PanelProp.GUI_CB PanelProp.LISTENER_CB]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelProp'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelProp'])

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
gui = GUI('CLOSEREQ', false);
pr = PanelProp(...
    'PARENT', gui, ...
    'BKGCOLOR', [1 0 0] ...
    );
assert(~pr.get('DRAWN'))

for i = 1:2
    pr.get('DRAW', 'Units', 'normalized', 'Position', [.25 .25 .50 .50])
    assert(pr.get('DRAWN'))
    p_c = pr.get('H');
    assert(check_graphics(p_c, 'uipanel'))
    f_M = pr.get('PARENT').get('H');
    assert(check_graphics(f_M, 'figure'))
    label_title_c = pr.get('LABEL_TITLE');
    assert(check_graphics(label_title_c, 'uilabel'))

    pr.get('SHOW')
    assert(pr.get('DRAWN'))

    pr.get('HIDE')
    assert(pr.get('DRAWN'))

    pr.get('SHOW')
    assert(pr.get('DRAWN'))

    pr.get('CLOSE')
    assert(~pr.get('DRAWN'))
    assert(~check_graphics(pr, 'uipanel'))
    assert(isa(pr.getr('H'), 'NoValue'))
    assert(~check_graphics(f_M, 'figure'))
    assert(isa(pr.get('PARENT').getr('H'), 'NoValue'))
    assert(~check_graphics(label_title_c, 'uilabel'))
    assert(isa(pr.getr('LABEL_TITLE'), 'NoValue'))
    % assert(~check_graphics(button_cb, 'uibutton'))
    % assert(isa(pr.getr('BUTTON_CB'), 'NoValue'))
    % assert(~check_graphics(button_calc, 'uibutton'))
    % assert(isa(pr.getr('BUTTON_CALC'), 'NoValue'))
    % assert(~check_graphics(button_del, 'uibutton'))    
    % assert(isa(pr.getr('BUTTON_DEL'), 'NoValue'))
end