%% ¡header!
PanelProp < Panel (pr, panel property) is a panel of a property.

%%% ¡description!
% % % PanelProp panels a property of an element in a panel. 
% % %  It contains a text with the prop tag and a tooltip with the prop description.
% % %  For parameter and data callback, it also features a callback button.
% % %  For results, it features calculate and delete buttons.
% % %  It typically is employed in one of its derived forms, 
% % %  where also the contents of the element property are shown.
% % % 
% % % Important notes:
% % % 1. PanelProp is intimately connected with GUI (cb_button_cb) and 
% % %  PanelElement (update, redraw).
% % % 2. The method redraw() isused internally by PanelElement
% % %  and typically does not need to be explicitly called in children of PanelProp, 
% % %  while update() is typically called in callbacks to update the contents.
% % % 3. Children of PanelProp should implement the methods:
% % %   - draw() to initially create the panel and its graphical objects
% % %   - update() to update the information content of the panel and of the element
% % %   - redraw() to resize the panel and reposition its graphical objcts
% % % 
% % % CONSTRUCTOR - To construct a PanelProp use the constructor:
% % % 
% % %     pr = Panel(''EL'', <element>, ''PROP'', prop);
% % %     pr = Panel(''EL'', <element>, ''PROP'', prop, ''ID'', ''id string'', ''TITLE'', ''title string'');
% % %     
% % % DRAW - To create the initial graphical objects in the property panel 
% % %  (title text and buttons), call pr.draw():
% % % 
% % %     p = pr.<strong>draw</strong>();
% % %     p = pr.<strong>draw</strong>(''Parent'', pp);
% % % 
% % %  It is also possible to use pr.draw() to get the property panel handle
% % %   and to set its properties (as in the case of Panel).
% % % 
% % % UPDATE - Updates the information content of the panel and of the element.
% % %   Typically, it does not need to be called explicitly.
% % %   It is internally called by PanelElement when needed.
% % % 
% % % REDRAW - Resizes the panel and repositions its graphical objcts.
% % %   Typically, it does not need to be called explicitly.
% % %   It is internally called by PanelElement when needed.
% % % 
% % % % % % REFRESH - Updates and resizes the panel and also its parent and siblings.
% % % % % %   Typically, it does not need to be called explicitly.
% % % % % %   It is internally called by PanelElement when needed.

%%% ¡seealso!
GUI, PanelElement

%% ¡props!

%%% ¡prop!
EL (metadata, item) is the element.

%%% ¡prop!
PROP (data, scalar) is the property number.

%%% ¡prop!
TITLE (gui, string) is the property title.

%%% ¡prop!
ENABLE (gui, option) switches between off and inactive fields.
%%%% ¡settings!
{'inactive' 'off'}

%%% ¡prop!
WAITBAR (gui, logical) determines whether to show the waitbar when executing calculations.

%% ¡properties!
p % panel
label_tag
button_cb % only for PARAMETER, DATA, FIGURE and GUI
button_calc % only for RESULT
button_del % only for RESULT

%% ¡methods!
function p_out = draw(pr, varargin)
% % %     %DRAW draws the property panel.
% % %     %
% % %     % DRAW(PL) draws the property panel with its title and
% % %     %  action buttons (callback for PARAMETER and DATA; calculate and
% % %     %  delete for RESULT).
% % %     %
% % %     % H = DRAW(PL) returns a handle to the property panel.
% % %     %
% % %     % DRAW(PL, 'Property', VALUE, ...) sets the properties of the panel 
% % %     %  with custom Name-Value pairs.
% % %     %  All standard panel properties of uipanel can be used.
% % %     %
% % %     % It is possible to access the properties of the various graphical
% % %     %  objects from the handle H of the panel.
% % %     %
% % %     % See also update, redraw, settings, uipanel.

    pr.p = draw@Panel(pr, varargin{:});

    el = pr.get('EL');
    prop = pr.get('PROP');

    if ~check_graphics(pr.label_tag, 'uilabel')
        if ~isempty(pr.get('TITLE'))
            pr_string_title = pr.get('TITLE');
        else
            pr_string_title = upper(el.getPropTag(prop));
        end
        
        pr.label_tag =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_tag', ...
            'Text', pr_string_title, ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'left', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end

% % %     switch el.getPropCategory(prop)
% % %         case Category.METADATA
% % %             %
% % %             
% % %         case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
% % %             if ~check_graphics(pr.button_cb, 'pushbutton')
% % %                 pr.button_cb = uicontrol( ...
% % %                     'Style', 'pushbutton', ...
% % %                     'Tag', 'button_cb', ...
% % %                     'Parent', pr.p, ...
% % %                     'Units', 'characters', ...
% % %                     'String', '@', ...
% % %                     'HorizontalAlignment', 'left', ...
% % %                     'FontWeight', 'bold', ...
% % %                     'Callback', {@cb_button_cb} ...
% % %                     );
% % %             end
% % %             
% % %         case Category.RESULT
% % %             if ~check_graphics(pr.button_calc, 'pushbutton')
% % %                 pr.button_calc = uicontrol( ...
% % %                     'Style', 'pushbutton', ...
% % %                     'Tag', 'button_calc', ...
% % %                     'Parent', pr.p, ...
% % %                     'Units', 'characters', ...
% % %                     'String', 'C', ...
% % %                     'HorizontalAlignment', 'left', ...
% % %                     'FontWeight', 'bold', ...
% % %                     'Tooltip', 'Calculate', ...
% % %                     'Callback', {@cb_button_calc} ...
% % %                     );
% % %             end
% % %             if ~check_graphics(pr.button_del, 'pushbutton')
% % %                 pr.button_del = uicontrol( ...
% % %                     'Style', 'pushbutton', ...
% % %                     'Tag', 'button_del', ...
% % %                     'Parent', pr.p, ...
% % %                     'Units', 'characters', ...
% % %                     'String', 'D', ...
% % %                     'HorizontalAlignment', 'left', ...
% % %                     'FontWeight', 'bold', ...
% % %                     'Tooltip', 'Delete', ...
% % %                     'Callback', {@cb_button_del} ...
% % %                     );
% % %             end
% % %     end
% % %     
% % %     function cb_button_cb(~, ~) % (src, event)
% % %         pr.cb_button_cb()
% % %     end
% % %     function cb_button_calc(~, ~) % (src, event)
% % %         pr.cb_button_calc()
% % %     end
% % %     function cb_button_del(~, ~) % (src, event)
% % %         pr.cb_button_del()
% % %     end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
% % %     %UPDATE updates the content of the property panel and its graphical objects.
% % %     %
% % %     % UPDATE(PL) updates the content of the property panel and its graphical objects.
% % %     %
% % %     % Important note:
% % %     % 1. UPDATE() is typically called internally by PanelElement and does not need 
% % %     %  to be explicitly called in children of PanelProp.
% % %     %
% % %     % See also draw, redraw, PanelElement.
% % % 
% % %     el = pr.get('EL');
% % %     prop = pr.get('PROP');
% % % 
% % %     switch el.getPropCategory(prop)
% % %         case Category.METADATA
% % %             %
% % % 
% % %         case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
% % %             value = el.getr(prop);
% % %             if isa(value, 'Callback')
% % %                 set(pr.button_cb, ...
% % %                     'Tooltip', value.tostring(), ...
% % %                     'Visible', 'on' ...
% % %                     )
% % %             else
% % %                 set(pr.button_cb, ...
% % %                     'Visible', 'off' ...
% % %                     )
% % %             end
% % % 
% % %         case Category.RESULT
% % %             value = el.getr(prop);
% % %             if isa(value, 'NoValue')
% % %                 set(pr.button_calc, 'Enable', 'on')
% % %                 set(pr.button_del, 'Enable', 'off')
% % %             else
% % %                 set(pr.button_calc, 'Enable', 'off')
% % %                 set(pr.button_del, 'Enable', 'on')
% % %             end
% % %     end
end
function redraw(pr, varargin)
% % %     %REDRAW resizes the property panel and repositions its graphical objects.
% % %     %
% % %     % REDRAW(PL) resizes the property panel and repositions its
% % %     %   graphical objects. 
% % %     % 
% % %     % Important notes:
% % %     % 1. REDRAW() sets the units 'characters' for panel and all its graphical objects. 
% % %     % 2. REDRAW() is typically called internally by PanelElement and does not need 
% % %     %  to be explicitly called in children of PanelProp.
% % %     %
% % %     % REDRAW(PL, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
% % %     %  repositions the property panel. It is possible to use a
% % %     %  subset of the Name-Value pairs.
% % %     %  By default:
% % %     %  - X0 does not change
% % %     %  - Y0 does not change
% % %     %  - WIDTH does not change
% % %     %  - HEIGHT=1.4 characters.
% % %     %
% % %     % See also draw, update, PanelElement.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    p = pr.p;

    % resizes the width (w) and height (h) of the panel
    % keeps its initial position (x0, y0) unchanged.
    x0_p = get_from_varargin(x0(p, 'pixels'), 'X0', varargin);
    y0_p = get_from_varargin(y0(p, 'pixels'), 'Y0', varargin);
    w_p = get_from_varargin(w(p, 'pixels'), 'Width', varargin);
    h_p = get_from_varargin(1.4 * BRAPH2.FONTSIZE, 'Height', varargin);
    set(p, ...
        'Units', 'pixels', ...
        'Position', [x0_p y0_p w_p h_p] ...
        )

    % places label_tag to the top
    set(pr.label_tag, 'Position', [0 h_p-BRAPH2.FONTSIZE w_p BRAPH2.FONTSIZE])

% % %     % places the relevant buttons (depening on category)
% % %     switch el.getPropCategory(prop)
% % %         case Category.METADATA
% % %             %
% % % 
% % %         case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
% % %             set(pr.button_cb, ...
% % %                 'Units', 'characters', ...
% % %                 'Position', [w_p-4 h_p-1.2 3 1] ...
% % %                 )
% % % 
% % %         case Category.RESULT
% % %             set(pr.button_calc, ...
% % %                 'Units', 'characters', ...
% % %                 'Position', [w_p-7.5 h_p-1.2 3 1] ...
% % %                 )
% % %             set(pr.button_del, ...
% % %                 'Units', 'characters', ...
% % %                 'Position', [w_p-4 h_p-1.2 3 1] ...
% % %                 )
% % %     end
end
% % % function cb_button_cb(pr)
% % %     %CB_BUTTON_CB executes callback for button callback.
% % %     %
% % %     % CB_BUTTON_CB(PL) executes callback for button callback.
% % %     % 
% % %     % See also GUI.
% % % 
% % %     el = pr.get('EL');
% % %     prop = pr.get('PROP');
% % %     
% % %     GUI('EL', el.getr(prop).get('EL')) 
% % % % % %TODO: check that this is working once GUI is complete
% % % end
% % % function cb_button_calc(pr)
% % %     %CB_BUTTON_CALC executes callback for button calculate.
% % %     %
% % %     % CB_BUTTON_CALC(PL) executes callback for button calculate.
% % %     %
% % %     % See also cb_button_del.
% % % 
% % %     el = pr.get('EL');
% % %     prop = pr.get('PROP');
% % % 
% % %     el.memorize(prop);
% % % 
% % %     % updates and redraws the parent PanelElement as well as all siblings PanelProp's
% % %     pe = get(get(get(pr.p, 'Parent'), 'Parent'), 'UserData');
% % %     pe.update()
% % %     pe.redraw()
% % % end
% % % function cb_button_del(pr)
% % %     %CB_BUTTON_DEL executes callback for button delete.
% % %     %
% % %     % CB_BUTTON_DEL(PL) executes callback for button delete.
% % %     %
% % %     % See also cb_button_calc.
% % % 
% % %     el = pr.get('EL');
% % %     prop = pr.get('PROP');
% % %     
% % %     el.set(prop, NoValue.getNoValue())
% % % 
% % %     % updates and redraws the parent PanelElement as well as all siblings PanelProp's
% % %     pe = get(get(get(pr.p, 'Parent'), 'Parent'), 'UserData');
% % %     pe.update()
% % %     pe.redraw()
% % % end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%% ¡code!
% % % draws PanelProp's at once
% % figure('Color', 'w', 'Units', 'normalized', 'Position', [0 0 1 1])
% % et1 = ETA();
% % for category = 1:1:Element.getCategoryNumber() + 1
% %     for format = 1:1:Element.getFormatNumber()
% %         prop = (category - 1) * Element.getFormatNumber() + format;
% %         prs{category, format} = PanelProp('EL', et1, 'PROP', prop);
% %         prs{category, format}.draw( ...
% %             'Units', 'normalized', ...
% %             'Position', [ ...
% %                 (category-1)/(Element.getCategoryNumber()+1) ...
% %                 1-format/Element.getFormatNumber() ...
% %                 .9/(Element.getCategoryNumber()+1) ...
% %                 .9/Element.getFormatNumber() ...
% %                 ], ...
% %             'BackgroundColor', [format/Element.getFormatNumber() category/(Element.getCategoryNumber()+1)] * [1 .5 0; 0 .5 1] ...
% %             )
% %         drawnow()
% %     end
% % end
% % close(gcf)
% % 
% % % draws PanelProp's with multiple calls to draw()
% % figure('Color', 'w', 'Units', 'normalized', 'Position', [0 0 1 1])
% % et2 = ETA();
% % for category = 1:1:Element.getCategoryNumber() + 1
% %     for format = 1:1:Element.getFormatNumber()
% %         prop = (category - 1) * Element.getFormatNumber() + format;
% %         prs{category, format} = PanelProp('EL', et2, 'PROP', prop);
% %         prs{category, format}.draw()
% %         prs{category, format}.draw('Units', 'normalized')
% %         prs{category, format}.draw('Position', [ ...
% %                 (category-1)/(Element.getCategoryNumber()+1) ...
% %                 1-format/Element.getFormatNumber() ...
% %                 .9/(Element.getCategoryNumber()+1) ...
% %                 .9/Element.getFormatNumber() ...
% %                 ])
% %         prs{category, format}.draw('BackgroundColor', [format/Element.getFormatNumber() category/(Element.getCategoryNumber()+1)] * [1 .5 0; 0 .5 1])
% %         drawnow()
% %     end
% % end
% % close(gcf)
% % 
% % % calls redraw() to resize the property panel and reposition its text
% % figure('Color', 'w', 'Units', 'normalized', 'Position', [0 0 1 1])
% % drawnow() % to solve ensure the figure is stable under drawnow()
% % et3 = ETA();
% % for category = 1:1:Element.getCategoryNumber() + 1
% %     for format = 1:1:Element.getFormatNumber()
% %         prop = (category - 1) * Element.getFormatNumber() + format;
% %         prs{category, format} = PanelProp('EL', et3, 'PROP', prop);
% %         prs{category, format}.draw()
% %         prs{category, format}.draw('Units', 'normalized')
% %         prs{category, format}.draw('BackgroundColor', [format/Element.getFormatNumber() category/(Element.getCategoryNumber()+1)] * [1 .5 0; 0 .5 1])
% % 
% %         prs{category, format}.redraw( ...
% %             'X0', (category - 1) / (Element.getCategoryNumber() + 1) * w(gcf, 'characters'), ...
% %             'Y0', (1 - format / Element.getFormatNumber()) * h(gcf, 'characters'), ...
% %             'Width', .9 / (Element.getCategoryNumber() + 1) * w(gcf, 'characters'), ...
% %             'Height', .9 / Element.getFormatNumber() * h(gcf, 'characters') ...
% %             )
% %         drawnow()
% %     end
% % end
% % close(gcf)
% % 
% % % calls update() and redraw()
% % % note that it doesn't work because it needs to be used with PanelElement() and GUI()
% % figure('Color', 'w', 'Units', 'normalized', 'Position', [0 0 1 1])
% % drawnow() % to solve ensure the figure is stable under drawnow()
% % et3 = ETA();
% % for category = 1:1:Element.getCategoryNumber() + 1
% %     for format = 1:1:Element.getFormatNumber()
% %         prop = (category - 1) * Element.getFormatNumber() + format;
% %         prs{category, format} = PanelProp('EL', et3, 'PROP', prop);
% %         prs{category, format}.draw()
% %         prs{category, format}.draw('Units', 'normalized')
% %         prs{category, format}.draw('BackgroundColor', [format/Element.getFormatNumber() category/(Element.getCategoryNumber()+1)] * [1 .5 0; 0 .5 1])
% % 
% %         prs{category, format}.update()
% %         
% %         prs{category, format}.redraw( ...
% %             'X0', (category - 1) / (Element.getCategoryNumber() + 1) * Panel.w(gcf, 'characters'), ...
% %             'Y0', (1 - format / Element.getFormatNumber()) * Panel.h(gcf, 'characters'), ...
% %             'Width', .9 / (Element.getCategoryNumber() + 1) * Panel.w(gcf, 'characters'), ...
% %             'Height', .9 / Element.getFormatNumber() * Panel.h(gcf, 'characters') ...
% %             )
% %         drawnow()
% %     end
% % end
% % close(gcf)