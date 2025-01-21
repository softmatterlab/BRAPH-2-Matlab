%% ¡header!
PanelPropIDict < PanelProp (pr, idict prop panel) plots the panel of a property idict.

%%% ¡description!
An Indexed-Dictionary Prop Panel (PanelPropIDict) plots the panel for a IDICT property with a button.
 It works for all categories.

%%% ¡seealso!
uibutton, GUI, PanelElement, GUIElement

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the idict property panel.
%%%% ¡default!
'PanelPropIDict'

%%% ¡prop!
NAME (constant, string) is the name of the idict property panel.
%%%% ¡default!
'Indexed-Dictionary Prop Panel'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the idict property panel.
%%%% ¡default!
'An Indexed-Dictionary Prop Panel (PanelPropIDict) plots the panel for a IDICT property with a button. It works for all categories.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the idict property panel.
%%%% ¡settings!
'PanelPropIDict'

%%% ¡prop!
ID (data, string) is a few-letter code for the idict property panel.
%%%% ¡default!
'PanelPropIDict ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the idict property panel.
%%%% ¡default!
'PanelPropIDict label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the idict property panel.
%%%% ¡default!
'PanelPropIDict notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
Pipeline()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
Pipeline.PS_DICT

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the property panel.
%%%% ¡default!
s(4)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('BUTTON')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the button.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if ~isa(pr.getr('BUTTON_TEXT'), 'NoValue')
        button_text = pr.get('BUTTON_TEXT');
    else % isa(pr.getr('BUTTON_TEXT'), 'NoValue')
        if isa(el.getr(prop), 'NoValue')
            button_text = el.getPropDefault(prop).get('TOSTRING');
        else
            button_text = el.get(prop).get('TOSTRING');
        end
    end
    
    switch el.getPropCategory(prop)
        case {Category.CONSTANT, Category.METADATA, Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.get('BUTTON'), ...
                'Text', button_text, ...
                'Tooltip', regexprep(el.get(prop).tree(), {'<strong>', '</strong>'}, {'' ''}) ...
                )
        
        case {Category.RESULT Category.QUERY Category.EVANESCENT}
            if isa(el.getr(prop), 'NoValue')
                set(pr.get('BUTTON'), ...
                    'Text', button_text, ...
                    'Tooltip', regexprep(el.getPropDefault(prop).tree(), {'<strong>', '</strong>'}, {'' ''}), ...
                    'Enable', 'off' ...
                    )
            else
                set(pr.get('BUTTON'), ...
                    'Text', button_text, ...
                    'Tooltip', regexprep(el.get(prop).tree(), {'<strong>', '</strong>'}, {'' ''}), ...
                    'Enable', 'on' ...
                    )
            end
    end
    
    value = true;
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    set(pr.get('BUTTON'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
end

%%% ¡prop!
SHOW (query, logical) shows the figure containing the panel and, possibly, the item figure.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.SHOW, varargin{:}); % also warning
if value
    % figure item
    if isa(pr.getr('GUI_ITEM'), 'GUI') && pr.get('GUI_ITEM').get('DRAWN')
        pr.get('GUI_ITEM').get('SHOW')
    end
end

%%% ¡prop!
HIDE (query, logical) hides the figure containing the panel and, possibly, the item figure.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.HIDE, varargin{:}); % also warning
if value
    % figure item
    if isa(pr.getr('GUI_ITEM'), 'GUI') && pr.get('GUI_ITEM').get('DRAWN')
        pr.get('GUI_ITEM').get('HIDE')
    end
end

%%% ¡prop!
DELETE (query, logical) resets the handles and closes the dependent figures when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value    
    pr.set('BUTTON', Element.getNoValue())
end

%%% ¡prop!
CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figure.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.CLOSE, varargin{:}); % also warning
if value
    % figure item
    if isa(pr.getr('GUI_ITEM'), 'GUI') && pr.get('GUI_ITEM').get('DRAWN')
        pr.get('GUI_ITEM').get('CLOSE')
    end
end

%% ¡props!

%%% ¡prop!
BUTTON_TEXT (gui, string) is the button text.

%%% ¡prop!
BUTTON (evanescent, handle) is the logical value dropdown.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

button = uibutton( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'BUTTON', ...
    'Text', '', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ButtonPushedFcn', {@cb_button}, ...
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    );

value = button;
%%%% ¡calculate_callbacks!
function cb_button(~, ~)
    gui_item = pr.memorize('GUI_ITEM');

    if ~gui_item.get('DRAWN')
        gui_item.get('DRAW')
        gui_item.get('SHOW')
    else
        if get(gui_item.get('H'), 'Visible')
            gui_item.get('HIDE')
        else
            gui_item.get('SHOW')
        end
    end
end

%%% ¡prop!
GUICLASS (gui, option) is the GUI kind.
%%%% ¡settings!
{'GUIElement', 'GUIFig'}

%%% ¡prop!
GUI_ITEM (data, item) is the handle to the item figure.
%%%% ¡settings!
'GUIElement'
%%%% ¡preset!
if isa(value.getr('PE'), 'NoValue') % i.e., default initialization
    f = ancestor(pr.get('H'), 'figure');

    el = pr.get('EL');
    prop = pr.get('PROP');

    value = GUIElement( ...
        'PE', el.memorize(prop), ... % ensure that the prop is stored
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

%% ¡tests!

%%% ¡excluded_props!
[PanelPropIDict.PARENT PanelPropIDict.H PanelPropIDict.LISTENER_CB PanelPropIDict.EL PanelPropIDict.BUTTON_TEXT PanelPropIDict.BUTTON PanelPropIDict.GUI_ITEM]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropIDict'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropIDict'])
