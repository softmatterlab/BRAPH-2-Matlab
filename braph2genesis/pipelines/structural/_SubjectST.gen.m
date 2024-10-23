%% ¡header!
SubjectST < Subject (sub, subject with structural data) is a subject with structural data (e.g. sMRI).

%%% ¡description!
Subject with structural data (e.g. cortical thickness obtaibed from strcutural MRI) for each brain region.

%%% ¡seealso!
ImporterGroupSubjectST_TXT, ExporterGroupSubjectST_TXT, ImporterGroupSubjectST_XLS, ExporterGroupSubjectST_XLS

%%% ¡build!
1

%% ¡gui!

%%% ¡menu_import!
if isa(el, 'Group')
    uimenu(menu_import, ...
        'Tag', 'MENU.Import.TXT', ...
        'Label', 'Import TXT ...', ...
        'Callback', {@cb_importer_TXT});
end
function cb_importer_TXT(~, ~)
    try
        im = ImporterGroupSubjectST_TXT( ...
            'ID', 'Import Group of SubjectSts from TXT', ...
            'WAITBAR', true ...
            ).get('GET_FILE');
        if ~isa(im.getr('FILE'), 'NoValue')
            gr = im.get('GR');
            gui = GUIElement('PE', gr);
            gui.get('DRAW')
            gui.get('SHOW')
        end
    catch e
        %TODO implement and use braph2msgbox instead of warndlg
        warndlg(['Please, select a valid input Group of SubjectSts in TXT format. ' newline() ...
            newline() ...
            'Error message:' newline() ...
            newline() ...
            e.message newline()], 'Warning');
    end
end

if isa(el, 'Group')
    uimenu(menu_import, ...
        'Tag', 'MENU.Import.XLS', ...
        'Label', 'Import XLS ...', ...
        'Callback', {@cb_importer_XLS});
end
function cb_importer_XLS(~, ~)
    try
        im = ImporterGroupSubjectST_XLS( ...
            'ID', 'Import Group of SubjectSts from XLS', ...
            'WAITBAR', true ...
            ).get('GET_FILE');
        if ~isa(im.getr('FILE'), 'NoValue')
            gr = im.get('GR');
            gui = GUIElement('PE', gr);
            gui.get('DRAW')
            gui.get('SHOW')
        end
    catch e
        %TODO implement and use braph2msgbox instead of warndlg
        warndlg(['Please, select a valid input Group of SubjectSTs in XLS format. ' newline() ...
            newline() ...
            'Error message:' newline() ...
            newline() ...
            e.message newline()], 'Warning');
    end
end

%%% ¡menu_export!
if isa(el, 'Group')
    uimenu(menu_export, ...
        'Tag', 'MENU.Export.TXT', ...
        'Label', 'Export TXT ...', ...
        'Callback', {@cb_exporter_TXT});
end
function cb_exporter_TXT(~, ~)
    ex = ExporterGroupSubjectST_TXT( ...
        'ID', 'Export Brain Group of SubjectSTs to TXT', ...
        'GR', el, ...
        'WAITBAR', true ...
        ).get('PUT_FILE');
    if ~isa(ex.getr('FILE'), 'NoValue')
        ex.get('SAVE');
    end
end

if isa(el, 'Group')
    uimenu(menu_export, ...
        'Tag', 'MENU.Export.XLS', ...
        'Label', 'Export XLS ...', ...
        'Callback', {@cb_exporter_XLS});
end
function cb_exporter_XLS(~, ~)
    ex = ExporterGroupSubjectST_XLS( ...
        'ID', 'Export Brain Group of SubjectSTs to XLS', ...
        'GR', el, ...
        'WAITBAR', true ...
        ).get('PUT_FILE');
    if ~isa(ex.getr('FILE'), 'NoValue')
        ex.get('SAVE');
    end
end

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
SubjectST.ID
%%%% ¡title!
Subject ID

%%% ¡prop!
%%%% ¡id!
SubjectST.LABEL
%%%% ¡title!
Subject LABEL

%%% ¡prop!
%%%% ¡id!
SubjectST.BA
%%%% ¡title!
Brain Atlas

%%% ¡prop!
%%%% ¡id!
SubjectST.VOI_DICT
%%%% ¡title!
Variables of Interest

%%% ¡prop!
%%%% ¡id!
SubjectST.ST
%%%% ¡title!
Structural DATA

%%% ¡prop!
%%%% ¡id!
SubjectST.NOTES
%%%% ¡title!
Subject NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the subject.
%%%% ¡default!
'SubjectST'

%%% ¡prop!
NAME (constant, string) is the name of the subject.
%%%% ¡default!
'Structural Subject'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject.
%%%% ¡default!
'SubjectST with structural data (e.g. cortical thickness obtaibed from strcutural MRI) for each brain region.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject.
%%% ¡settings!
'SubjectST'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.
%%%% ¡default!
'SubjectST ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.
%%%% ¡default!
'SubjectST label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.
%%%% ¡default!
'SubjectST notes'

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
ST (data, cvector) is a column vector with data for each brain region.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
check = (iscolumn(value) && isequal(size(value), [br_number, 1])) || (isempty(value) && br_number == 0); % Format.checkFormat(Format.CVECTOR, value) already checked
if check
    msg = 'All ok!';
else   
    msg = ['ST must be a column vector with the same number of element as the brain regions (' int2str(br_number) ').'];
end
%%%% ¡gui!
pr = PanelPropMatrix('EL', sub, 'PROP', SubjectST.ST, ...
    'ROWNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
    'COLUMNNAME', {}, ...
    varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'destrieux_atlas.xlsx');
ba = im_ba.get('BA');

gr = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
for i = 1:1:50
    sub = SubjectST( ...
        'ID', ['SUB ST ' int2str(i)], ...
        'LABEL', ['Subejct ST ' int2str(i)], ...
        'NOTES', ['Notes on subject ST ' int2str(i)], ...
        'BA', ba, ...
        'ST', rand(ba.get('BR_DICT').get('LENGTH'), 1) ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr.get('SUB_DICT').get('ADD', sub)
end

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')