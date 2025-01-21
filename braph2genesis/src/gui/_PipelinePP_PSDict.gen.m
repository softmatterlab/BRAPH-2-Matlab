%% ¡header!
PipelinePP_PSDict < PanelProp (pr, pipeline plot) manages the dictionary of pipeline panel plots.

%%% ¡description!
A Pipeline Plot (PipelinePP_PSDict) plots a pipeline allowing the user to execute it in the correct order.
It opens PanelFig elements using GUIFig, and all other elements using GUIElement.
It should be used only with the prop PS_DICT of the element Pipeline.

%%% ¡seealso!
Pipeline

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the pipeline panel plot dictionary.
%%%% ¡default!
'PipelinePP_PSDict'

%%% ¡prop!
NAME (constant, string) is the name of the pipeline panel plot dictionary.
%%%% ¡default!
'Pipeline Plot'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the pipeline panel plot dictionary.
%%%% ¡default!
'A Pipeline Plot (PipelinePP_PSDict) plots a pipeline allowing the user to execute it in the correct order. It opens PanelFig elements using GUIFig, and all other elements using GUIElement. It should be used only with the prop PS_DICT of the element Pipeline.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the pipeline panel plot dictionary.
%%%% ¡settings!
'PipelinePP_PSDict'

%%% ¡prop!
ID (data, string) is a few-letter code for the pipeline panel plot dictionary.
%%%% ¡default!
'PipelinePP_PSDict ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the pipeline panel plot dictionary.
%%%% ¡default!
'PipelinePP_PSDict label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the pipeline plot.
%%%% ¡default!
'PipelinePP_PSDict notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡settings!
'Pipeline'

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
Pipeline.PS_DICT

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('HANDLES')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the table.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
    pip = pr.get('EL');

    ps_dict = pip.get('PS_DICT');
    ps_number = ps_dict.get('LENGTH');
    pc_numbers = cellfun(@(ps) ps.get('PC_DICT').get('LENGTH'), ps_dict.get('IT_LIST'));
    pr.set('HEIGHT', pr.get('HEIGHT_MIN') + (pr.get('HEIGHT_PS_MARGIN') + pr.get('HEIGHT_PS_HEADER') + pr.get('HEIGHT_PS_FOOTER')) * ps_number + pr.get('HEIGHT_PC') * sum(pc_numbers));
    
    s_selected = get_from_varargin(0, 'Section', varargin); % selected section
    c_selected = get_from_varargin(0, 'Code', varargin); % selected code

    to_be_executed = {};
    
    s_to_be_calculated = 1;
    s_dict = pip.get('PS_DICT');
    for sec = 1:1:s_dict.get('LENGTH')
        section = s_dict.get('IT', sec);
        
        code_dict = section.get('PC_DICT');
        for cl = 1:1:code_dict.get('LENGTH')
            code = code_dict.get('IT', cl);
            moniker = code.get('MONIKER');
            if strcmpi(moniker, 'varargin')
                error( ...
                    [BRAPH2.STR ':' pr.getClass() ':' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':' pr.getClass() ':' BRAPH2.WRONG_INPUT '\\n' ...
                    'The moniker should not be ''varagin''.'] ...
                    )
            end
            
            % callback code -- CALCULATE
            if sec == s_selected && cl == c_selected && isa(code.getr('EL'), 'NoValue') % the code has not been calculated yet -- CALCULATE
                try
                    set(pr.get('PC_BTN', sec, cl), 'Enable', 'off')
                    x_pip_update(to_be_executed{:}, ...
                        {moniker, code, [moniker ' = ' code.get('CODE') ';']}, ... % varargin{1}{2} = code
                        {moniker, code, ['varargin{1}{2}.set(''EL'', ' moniker ');']}) % varargin{1}{2} = code
                catch e
                    set(pr.get('PC_BTN', sec, cl), 'Enable', 'on')

                    if isempty(regexp(e.message, ['^' BRAPH2.STR ':.*:' BRAPH2.CANCEL_IO '$'], 'once'))
                        %TODO make this with braph2message
                        warndlg(['An error occurred while trying to execute the code:' newline() ...
                            newline() ...
                            moniker ' = ' code.get('CODE') ';' newline() ...
                            newline() ...
                            'Error message:' newline() ...
                            newline() ...
                            e.message newline()], 'Warning');
                    end
                end
            end

            % If a code has already been executed and the relative element exists, 
            % 1. loads the calculated element to the workspace
            % 2. updates the ID in the btn
            % 3. calculates whether to move to the next section
            if ~isa(code.getr('EL'), 'NoValue')
                to_be_executed = {to_be_executed{:}, {moniker, code, [moniker ' = varargin{1}{2}.get(''EL'');']}}; % varargin{1}{2} = code

                set(pr.get('PC_BTN', sec, cl), ...
                    'Enable', 'on', ...
                    'Text', [code.get('TEXT_AFTER_EXEC') ' / ' code.get('EL').get('ID')], ...
                    'FontAngle', 'normal', ...
                    'FontWeight', 'normal' ...
                    )
                set(pr.get('PC_CLEAR_BTN', sec, cl), 'Enable', 'on')

                % if all section codes calculated, updates the section to be calculated
                if all(cellfun(@(pc) ~isa(pc.getr('EL'), 'NoValue'), code_dict.get('IT_LIST')))
                    s_to_be_calculated = sec + 1;
                end
                
                % disables clear buttons of previous section
                if sec > 1
                    for cl_tmp = 1:1:s_dict.get('IT', sec - 1).get('PC_DICT').get('LENGTH')
                        set(pr.get('PC_CLEAR_BTN', sec - 1, cl_tmp), 'Enable', 'off')
                    end
                end
            end
            
            % activates the next section that can be calculated
            % (only the codes that have not been calculated yet)
            if sec == s_to_be_calculated && isa(code.getr('EL'), 'NoValue')
                set(pr.get('PC_BTN', sec, cl), ...
                    'Enable', 'on', ...
                    'Text', code.get('TEXT_BEFORE_EXEC'), ...
                    'FontAngle', 'normal', ...
                    'FontWeight', 'bold' ...
                    )
                set(pr.get('PC_CLEAR_BTN', sec, cl), 'Enable', 'off')
            end
            
            % deactivates the subsequent sections
            if sec > s_to_be_calculated 
                set(pr.get('PC_BTN', sec, cl), ...
                    'Enable', 'off', ...
                    'Text', code.get('TEXT_BEFORE_EXEC'), ...
                    'FontAngle', 'italic', ...
                    'FontWeight', 'normal' ...
                    )
                set(pr.get('PC_CLEAR_BTN', sec, cl), 'Enable', 'off')
            end
            
            % callback code -- GUI
            if sec == s_selected && cl == c_selected && ~isa(code.getr('EL'), 'NoValue') % the code has already been calculated -- GUI
                key = [int2str(sec) '.' int2str(cl)];
                gui_pc_dict = pr.memorize('GUI_PC_DICT');
                if ~gui_pc_dict.get('CONTAINS_KEY', key)
                    f_pip = ancestor(pr.get('H'), 'Figure'); % Pipeline GUI

                    if isa(code.get('EL'), 'PanelFig')
                        gui = GUIFig( ...
                            'ID', key, ... % this is the dictionary key
                            'PF', code.get('EL'), ...
                            'POSITION', [ ...
                                x0(f_pip, 'normalized')+w(f_pip, 'normalized') ...
                                y0(f_pip, 'normalized') ...
                                w(0,'normalized')-x0(f_pip, 'normalized')-w(f_pip, 'normalized') ...
                                h(f_pip, 'normalized') ...
                                ], ...
                            'WAITBAR', pr.getCallback('WAITBAR'), ...
                            'CLOSEREQ', false ...
                            );
                    else
                        gui = GUIElement( ...
                            'ID', key, ... % this is the dictionary key
                            'PE', code.get('EL'), ...
                            'POSITION', [ ...
                                x0(f_pip, 'normalized') + w(f_pip) ...
                                y0(f_pip, 'normalized') ...
                                w(f_pip) ...
                                h(f_pip, 'normalized') ...
                                ], ...
                            'WAITBAR', pr.getCallback('WAITBAR'), ...
                            'CLOSEREQ', false ...
                            );
                    end
                    gui_pc_dict.get('ADD', gui)
                end

                gui = gui_pc_dict.get('IT', key);
                if ~gui.get('DRAWN')
                    gui.get('DRAW')
                end
                if get(gui.get('H'), 'Visible')
                    gui.get('HIDE')
                else
                    gui.get('SHOW')
                end
            end
        end
    end
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    pip = pr.get('EL');
    ps_dict = pip.get('PS_DICT');
        
    ps_number = ps_dict.get('LENGTH');
    pc_numbers = cellfun(@(ps) ps.get('PC_DICT').get('LENGTH'), ps_dict.get('IT_LIST'));
    
    for sec = 1:1:ps_number
        ps_y = pr.get('HEIGHT_PS_HEADER') * (ps_number - sec) ...
            + pr.get('HEIGHT_PC') * sum(pc_numbers(sec+1:end)) ...
            + pr.get('HEIGHT_PS_FOOTER') * (ps_number - sec) ...
            + pr.get('HEIGHT_PS_MARGIN') * (ps_number - sec + 1);
        ps_h = pr.get('HEIGHT_PS_HEADER') + pr.get('HEIGHT_PC') * pc_numbers(sec) + pr.get('HEIGHT_PS_FOOTER');
        
        set(pr.get('PS_PANEL', sec), ...
            'Units', 'pixels', ...
            'Position', [s(.3) ps_y w_p-s(.6) ps_h] ...
            )
        
        for cl = 1:1:pc_numbers(sec)
            set(pr.get('PC_BTN', sec, cl), 'Position', [s(.3) (pr.get('HEIGHT_PS_FOOTER')+(pc_numbers(sec)-cl)*pr.get('HEIGHT_PC')) w(pr.get('PS_PANEL', sec), 'pixels')-pr.get('HEIGHT_PC')-s(.9) pr.get('HEIGHT_PC')])
            set(pr.get('PC_CLEAR_BTN', sec, cl), 'Position', [w(pr.get('PS_PANEL', sec), 'pixels')-pr.get('HEIGHT_PC')-s(.3) (pr.get('HEIGHT_PS_FOOTER')+(pc_numbers(sec)-cl)*pr.get('HEIGHT_PC')) pr.get('HEIGHT_PC') pr.get('HEIGHT_PC')])
        end
    end
end

%%% ¡prop!
SHOW (query, logical) shows the figures of the elements/buttons.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.SHOW, varargin{:}); % also warning
if value
    % % figures for elements/buttons, currently not in use
    % gui_pc_dict = pr.get('GUI_PC_DICT');
    % for i = 1:1:gui_pc_dict.get('LENGTH')
    %     gui = gui_pc_dict.get('IT', i);
    %     if gui.get('DRAWN')
    %         gui.get('SHOW')
    %     end
    % end
end

%%% ¡prop!
HIDE (query, logical) hides the figures of the elements/buttons.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.HIDE, varargin{:}); % also warning
if value
    % figures for items
    gui_pc_dict = pr.get('GUI_PC_DICT');
    for i = 1:1:gui_pc_dict.get('LENGTH')
        gui = gui_pc_dict.get('IT', i);
        if gui.get('DRAWN')
            gui.get('HIDE')
        end
    end
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('HANDLES', Element.getNoValue())
end

%%% ¡prop!
CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.CLOSE, varargin{:}); % also warning
if value
    % figures for items
    gui_pc_dict = pr.get('GUI_PC_DICT');
    for i = 1:1:gui_pc_dict.get('LENGTH')
        gui = gui_pc_dict.get('IT', i);
        if gui.get('DRAWN')
            gui.get('CLOSE')
        end
    end
end

%% ¡props!

%%% ¡prop!
HEIGHT_MIN (gui, scalar) is the default (minumum) height.
%%%% ¡default!
s(2)

%%% ¡prop!
HEIGHT_PS_HEADER (gui, scalar) is the height section header.
%%%% ¡default!
s(2)

%%% ¡prop!
HEIGHT_PC (gui, scalar) is the height code button.
%%%% ¡default!
s(2.5)

%%% ¡prop!
HEIGHT_PS_FOOTER (gui, scalar) is the height section footer.
%%%% ¡default!
s(.5)

%%% ¡prop!
HEIGHT_PS_MARGIN (gui, scalar) is the height section margin.
%%%% ¡default!
s(.5)

%%% ¡prop!
HANDLES (evanescent, handlelist) is the list of section panels and buttons.
%%%% ¡calculate!
pip = pr.get('EL');

ps_dict = pip.get('PS_DICT');
ps_panels = cell(1, ps_dict.get('LENGTH'));
pc_btns = cell(1, ps_dict.get('LENGTH'));
for sec = 1:1:ps_dict.get('LENGTH')
    ps = ps_dict.get('IT', sec);

    ps_panels{sec} = uipanel( ...
        'Parent', pr.get('H'), ...
        'Tag', int2str(sec), ... % Tag used by PS_PANEL
        'Title', [ps.get('ID') '. ' ps.get('LABEL')], ... 
        'Tooltip', ps.get('DESCRIPTION'), ...
        'FontSize', BRAPH2.FONTSIZE, ...
        'BorderType', 'none' ...
        );

        pc_dict = ps.get('PC_DICT');
        pc_btns{sec} = cell(1, pc_dict.get('LENGTH'));
        for cl = 1:1:pc_dict.get('LENGTH')
            pc = pc_dict.get('IT', cl);

            pc_btns{sec}{cl} = uibutton( ...
                'Parent', ps_panels{sec}, ... 
                'Tag', [int2str(sec) '.' int2str(cl)], ... % Tag used by PC_CLEAR_BTN 
                'Tooltip', pc.get('DESCRIPTION'), ...
                'Enable', 'off', ...
                'Text', pc.get('TEXT_BEFORE_EXEC'), ...
                'FontAngle', 'italic', ...
                'FontSize', BRAPH2.FONTSIZE, ...
                'UserData', [sec cl], ...
                'ButtonPushedFcn', {@cb_pc_btn}, ...
                'Interruptible', 'off', ...
                'BusyAction', 'cancel' ...
                );

            pc_delete_btns{sec}{cl} = uibutton( ...
                'Parent', ps_panels{sec}, ... 
                'Tag', ['delete ' int2str(sec) '.' int2str(cl)], ... % Tag used by PC_CLEAR_BTN
                'Tooltip', ['Delete ' pc.get('MONIKER')], ...
                'Enable', 'off', ...
                'Text', 'D', ...
                'FontSize', BRAPH2.FONTSIZE, ...
                'FontWeight', 'bold', ...
                'UserData', [sec cl], ...
                'ButtonPushedFcn', {@cb_pc_clear_btn}, ...
                'Interruptible', 'off', ...
                'BusyAction', 'cancel' ...
                );
        end
end

% output value
handles = {};
for sec = 1:1:length(ps_panels)
    handles = [handles ps_panels(sec) pc_btns{sec}(:)' pc_delete_btns{sec}(:)'];
end
value = handles;
%%%% ¡calculate_callbacks!
function cb_pc_btn(src, ~)
    userdata = get(src, 'UserData');
    sec = userdata(1);
    cl = userdata(2);

    pr.get('UPDATE', 'Section', sec, 'Code', cl)
end
function cb_pc_clear_btn(src, ~)

    userdata = get(src, 'UserData');
    sec = userdata(1);
    cl = userdata(2);
    
    % resets the code eliminating element
    pc_dict = pip.get('PS_DICT').get('IT', sec).get('PC_DICT');
    code = pc_dict.get('IT', cl);
    code_new = PipelineCode( ...
        'TEMPLATE', code.get('TEMPLATE'), ...
        'ID', code.get('ID'), ...
        'LABEL', code.get('LABEL'), ...
        'NOTES', code.get('NOTES'), ...
        'TEMPLATE', code.get('TEMPLATE'), ...
        'TEXT_BEFORE_EXEC', code.get('TEXT_BEFORE_EXEC'), ...
        'TEXT_AFTER_EXEC', code.get('TEXT_AFTER_EXEC'), ...
        'MONIKER', code.get('MONIKER'), ...
        'CODE', code.get('CODE') ...
        );
    pc_dict.get('REPLACE_IT', code, code_new)
    
    % closes and removes the GUI
    key = [int2str(sec) '.' int2str(cl)];
    gui_pc_dict = pr.get('GUI_PC_DICT');
    if gui_pc_dict.get('CONTAINS_KEY', key)
        gui_pc = gui_pc_dict.get('IT', key);
        if gui_pc.get('DRAWN')
            gui_pc.get('CLOSE')
        end
        gui_pc_dict.get('REMOVE', key)
    end
    
    pr.get('UPDATE')
end

%%% ¡prop!
PS_PANEL (query, handle) returns graphics handle of a section panel.
%%%% ¡calculate!
% H = pr.get('PS_PANEL', SEC) returns the hande H of the section SEC panel.
value = gobjects(); % default output
if isempty(varargin)
    return
end    
sec = varargin{1};

handles = pr.memorize('HANDLES');

for i = 1:1:length(handles)
    if check_graphics(handles{i}, 'uipanel') && strcmpi(handles{i}.get('Tag'), int2str(sec)) % for Tag see HANDLES
        value = handles{i}; % output value
        break
    end
end

%%% ¡prop!
PC_BTN (query, handle) returns graphics handle of a button.
%%%% ¡calculate!
% H = pr.get('PC_BTN', SEC, CL) returns the hande H of the button of code 
% line CL of section SEC panel.
value = gobjects(); % default output
if isempty(varargin)
    return
end    
sec = varargin{1};
cl = varargin{2};

handles = pr.memorize('HANDLES');

for i = 1:1:length(handles)
    if check_graphics(handles{i}, 'uibutton') && strcmpi(handles{i}.get('Tag'), [int2str(sec) '.' int2str(cl)]) % for Tag see HANDLES
        value = handles{i}; % output value
        break
    end
end

%%% ¡prop!
PC_CLEAR_BTN (query, handle) returns graphics handle of a clear button.
%%%% ¡calculate!
% H = pr.get('PC_BTN', SEC, CL) returns the hande H of the button of code 
% line CL of section SEC panel.
value = gobjects(); % default output
if isempty(varargin)
    return
end    
sec = varargin{1};
cl = varargin{2};

handles = pr.memorize('HANDLES');

for i = 1:1:length(handles)
    if check_graphics(handles{i}, 'uibutton') && strcmpi(handles{i}.get('Tag'), ['delete ' int2str(sec) '.' int2str(cl)]) % for Tag see HANDLES
        value = handles{i}; % output value
        break
    end
end

%%% ¡prop!
GUI_PC_DICT (gui, idict) contains the GUIs for the element/buttons.
%%%% ¡settings!
'GUI'

%% ¡tests!

%%% ¡excluded_props!
[PipelinePP_PSDict.PARENT PipelinePP_PSDict.H PipelinePP_PSDict.HANDLES]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PipelinePP_PSDict'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PipelinePP_PSDict'])
