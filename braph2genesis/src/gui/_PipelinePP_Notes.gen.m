%% ¡header!
PipelinePP_Notes < PanelPropStringTextArea (pr, prop panel for pipeline notes) plots the panel for a pipeline notes.

%%% ¡description!
A Prop Panel for Pipeline Notes (PipelinePP_Notes) plots a text area with 
 the pipeline notes enhnaced with a popup context menu to open the web 
 tutorial and the pdf tuorial, as well as to edit or clone the pipeline.
It should be used only with the prop NOTES of the element Pipeline.

%%% ¡seealso!
uitextarea, uicontextmenu, Pipeline

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the prop panel for pipeline notes.
%%%% ¡default!
'PipelinePP_Notes'

%%% ¡prop!
NAME (constant, string) is the name of the prop panel for pipeline notes.
%%%% ¡default!
'Prop Panel for Pipeline Notes'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the prop panel for pipeline notes.
%%%% ¡default!
'A Prop Panel for Pipeline Notes (PipelinePP_Notes) plots a text area with the pipeline notes enhnaced with a popup context menu to open the web tutorial and the pdf tuorial, as well as to edit or clone the pipeline. It should be used only with the prop NOTES of the element Pipeline.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the prop panel for pipeline notes.
%%%% ¡settings!
'PipelinePP_Notes'

%%% ¡prop!
ID (data, string) is a few-letter code for the prop panel for pipeline notes.
%%%% ¡default!
'PipelinePP_Notes ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the prop panel for pipeline notes.
%%%% ¡default!
'PipelinePP_Notes label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the prop panel for pipeline notes.
%%%% ¡default!
'PipelinePP_Notes notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡settings!
'Pipeline'

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
Pipeline.NOTES

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the prop panel.
%%%% ¡default!
s(10)

%%% ¡prop!
X_DRAW (query, logical) draws the prop panel.
%%%% ¡calculate!
value = calculateValue@PanelPropStringTextArea(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('CONTEXTMENU')
    pr.memorize('MENUS')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the text-area and popup context menu.
%%%% ¡calculate!
value = calculateValue@PanelPropStringTextArea(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value

    pip = pr.get('EL');
    NOTES = pr.get('PROP');
    
    notes = pip.get(NOTES);

    pdf = regexp(notes, '/tutorials/pipelines/\\w+/\\w+\\.pdf', 'match', 'once'); % note \\ for compilation
    notes = regexprep(notes, ['PDF:.*?(' newline() '|$)'], '');

    md = regexp(notes, '/tutorials/pipelines/\\w+/readme\\.md', 'match', 'once'); % note \\ for compilation
    notes = regexprep(notes, ['README:.*?(' newline() '|$)'], '');

    notes = strtrim(notes);

    set(pr.get('TEXTAREA'), 'Value', strrep(notes, '\\n', char(10))) % note \\ for compilation
    if pip.isLocked(NOTES)
        set(pr.get('TEXTAREA'), ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
    end

    menus = pr.get('MENUS');
    set(menus(1), 'Enable', ~isempty(pip.get('README'))) % menus(1) = menu_tut_web
    set(menus(2), 'Enable', ~isempty(pip.get('PDF'))) % menus(2) = menu_tut_pdf
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelPropStringTextArea(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('CONTEXTMENU', Element.getNoValue())
    pr.set('MENUS', Element.getNoValue())
end

%%% ¡prop!
TEXTAREA (evanescent, handle) is the string value text-area.
%%%% ¡calculate!
pip = pr.get('EL');
NOTES = pr.get('PROP');

textarea = uitextarea( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'TEXTAREA', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(pip.getPropProp(NOTES)) ' ' pip.getPropDescription(NOTES)], ...
    'ValueChangedFcn', {@cb_textarea} ...
    );

value = textarea;
%%%% ¡calculate_callbacks!
function cb_textarea(~, ~)
    notes = get(pr.get('TEXTAREA'), 'Value');

    

    pr.get('EL').set(pr.get('PROP'), sprintf('%s\\\\n', value{:})) % double \\ to be converted to single \\ in compilation
end

%% ¡props!

%%% ¡prop!
CONTEXTMENU (evanescent, handle) is the popup context menu.
%%%% ¡calculate!
pip = pr.get('EL');
NOTES = pr.get('PROP');

contextmenu = uicontextmenu( ...
    'Parent', ancestor(pr.get('H'), 'figure'), ...
    'TAG', 'CONTEXTMENU' ...
    );

set(pr.get('TEXTAREA'), 'ContextMenu', contextmenu)

value = contextmenu;

%%% ¡prop!
MENUS (evanescent, handlelist) is the list of context menus.
%%%% ¡calculate!
contextmenu = pr.get('CONTEXTMENU');

menu_tut_web = uimenu( ...
    'Separator', 'on', ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_TUT_WEB', ...
    'Text', 'Web Tutorial ...', ...
    'Enable', 'off', ...
    'MenuSelectedFcn', {@cb_tut_web} ...
    );
menu_tut_pdf = uimenu( ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_TUT_PDF', ...
    'Text', 'PDF Tutorial ...', ...
    'Enable', 'off', ...
    'MenuSelectedFcn', {@cb_tut_pdf} ...
    );
menu_pip_edit = uimenu( ...
    'Separator', 'on', ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_PIP_EDIT', ...
    'Text', 'Edit Pipeline ...', ...
    'MenuSelectedFcn', {@cb_pip_edit} ...
    );
menu_pip_clone = uimenu( ...
    'Separator', 'on', ...
    'Parent', contextmenu, ...
    'Tag', 'MENU_PIP_CLONE', ...
    'Text', 'Clone Pipeline ...', ...
    'MenuSelectedFcn', {@cb_pip_clone} ...
    );

value = [menu_tut_web, menu_tut_pdf, menu_pip_edit, menu_pip_clone];
%%%% ¡calculate_callbacks!
function cb_tut_web(~, ~)
    pip = pr.get('EL');

    web([BRAPH2.GITHUB '/tree/develop' pip.get('README')]);
end
function cb_tut_pdf(~, ~)
    pip = pr.get('EL');

    if ismac()
        system(['open -a Preview ' fileparts(fileparts(which('braph2'))) pip.get('PDF')]);
    elseif isunix()
        system(['xdg-open "' fileparts(fileparts(which('braph2'))) regexprep(pip.get('PDF'), '/', '\\') '"']);
    elseif ispc()
        system(['start "" "' fileparts(fileparts(which('braph2'))) pip.get('PDF') '"']);
    end
end
function cb_pip_edit(~, ~)
    pip = pr.get('EL');

    edit([pip.get('ID') '.braph2'])
end
function cb_pip_clone(~, ~)
    pip = pr.get('EL');

    pip_file_name = which([pip.get('ID') '.braph2']);
    
    cloned_pip = ImporterPipelineBRAPH2( ...
        'FILE', pip_file_name, ...
        'WAITBAR', true ...
        ).get('PIP');

    [path, name, ext] = fileparts(pip_file_name);
    cloned_name = ['cloned_' name];

    pip.set( ...
        'ID', cloned_name, ...
        'LABEL', ['Clone of ' cloned_pip.get('LABEL')], ...
        'NOTES', ['This is a clone of another pipeline!' newline() ' ' newline() cloned_pip.get('NOTES')] ...
        )
    
    cloned_file_name = [path filesep() cloned_name ext];
    ExporterPipelineBRAPH2( ...
        'PIP', cloned_pip, ...
        'FILE', cloned_file_name, ...
        'WAITBAR', true ...
        ).get('SAVE')

    edit(cloned_file_name)
end

%% ¡tests!

%%% ¡excluded_props!
[PipelinePP_Notes.PARENT PipelinePP_Notes.H PipelinePP_Notes.LISTENER_CB PipelinePP_Notes.TEXTAREA PipelinePP_Notes.CONTEXTMENU PipelinePP_Notes.MENUS]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PipelinePP_Notes'])
assert(length(findall(0, 'type', 'figure')) == 2)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PipelinePP_Notes'])