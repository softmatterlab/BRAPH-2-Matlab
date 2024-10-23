%% ¡header!
SubjectCON_MP < Subject (sub, subject with connectivity multiplex data) is a subject with connectivity multiplex data.

%%% ¡description!
Subject with L connectivity matrices (e.g. obtained from DTI).

%%% ¡seealso!
ImporterGroupSubjectCON_MP_TXT, ExporterGroupSubjectCON_MP_TXT, ImporterGroupSubjectCON_MP_XLS, ExporterGroupSubjectCON_MP_XLS

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
        im = ImporterGroupSubjectCON_MP_TXT( ...
            'ID', 'Import Group of SubjectCON_MPs from TXT', ...
            'WAITBAR', true ...
            ).get('GET_DIR');
        if ~isa(im.getr('DIRECTORY'), 'NoValue')
            gr = im.get('GR');
            gui = GUIElement('PE', gr);
            gui.get('DRAW')
            gui.get('SHOW')
        end
    catch e
        %TODO implement and use braph2msgbox instead of warndlg
        warndlg(['Please, select a valid input Group of SubjectCON_MPs in TXT format. ' newline() ...
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
        im = ImporterGroupSubjectCON_MP_XLS( ...
            'ID', 'Import Group of SubjectCON_MPs from XLS', ...
            'WAITBAR', true ...
            ).get('GET_DIR');
        if ~isa(im.getr('DIRECTORY'), 'NoValue')
            gr = im.get('GR');
            gui = GUIElement('PE', gr);
            gui.get('DRAW')
            gui.get('SHOW')
        end
    catch e
        %TODO implement and use braph2msgbox instead of warndlg
        warndlg(['Please, select a valid input Group of SubjectCON_MPs in XLS format. ' newline() ...
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
    ex = ExporterGroupSubjectCON_MP_TXT( ...
        'ID', 'Export Brain Group of SubjectCON_MPs to TXT', ...
        'GR', el, ...
        'WAITBAR', true ...
        ).get('PUT_DIR');
    if ~isa(ex.get('DIRECTORY'), 'NoValue')
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
    ex = ExporterGroupSubjectCON_MP_XLS( ...
        'ID', 'Export Brain Group of SubjectCON_MPs to XLS', ...
        'GR', el, ...
        'WAITBAR', true ...
        ).get('PUT_DIR');
    if ~isa(ex.get('DIRECTORY'), 'NoValue')
        ex.get('SAVE');
    end
end

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
SubjectCON_MP.ID
%%%% ¡title!
Subject ID

%%% ¡prop!
%%%% ¡id!
SubjectCON_MP.LABEL
%%%% ¡title!
Subject LABEL

%%% ¡prop!
%%%% ¡id!
SubjectCON_MP.BA
%%%% ¡title!
Brain Atlas

%%% ¡prop!
%%%% ¡id!
SubjectCON_MP.VOI_DICT
%%%% ¡title!
Variables of Interest

%%% ¡prop!
%%%% ¡id!
SubjectCON_MP.L
%%%% ¡title!
Layer Number

%%% ¡prop!
%%%% ¡id!
SubjectCON_MP.LAYERLABELS
%%%% ¡title!
Layer Labels

%%% ¡prop!
%%%% ¡id!
SubjectCON_MP.CON_MP
%%%% ¡title!
Connectivity DATA LAYERS

%%% ¡prop!
%%%% ¡id!
SubjectCON_MP.NOTES
%%%% ¡title!
Subject NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the subject.
%%%% ¡default!
'SubjectCON_MP'

%%% ¡prop!
NAME (constant, string) is the name of the subject.
%%%% ¡default!
'Multiplex Connectivity Subject'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject.
%%%% ¡default!
'Subject with L connectivity matrices (e.g. obtained from DTI).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject.
%%% ¡settings!
'SubjectCON_MP'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.
%%%% ¡default!
'SubjectCON_MP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.
%%%% ¡default!
'SubjectCON_MP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.
%%%% ¡default!
'SubjectCON_MP notes'

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
L (data, scalar) is the number of layers of subject data.
%%%% ¡preset!
value = abs(round(value));
%%%% ¡postset!
if ~isa(sub.getr('CON_MP'), 'NoValue') && sub.get('L') ~= length(sub.get('CON_MP'))
    sub.set('L', length(sub.get('CON_MP')))
end

%%% ¡prop!
LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.
%%%% ¡postset!
if ~isa(sub.getr('L'), 'NoValue') && length(sub.get('LAYERLABELS')) ~= sub.get('L')
    title = ['About Layer Labels'];
    message = {''
        ['{\\bf\\color{orange}' BRAPH2.STR '}'] % note to use doubl slashes to avoid genesis problem
        ['{\\color{gray}version ' BRAPH2.VERSION '}']
        ['{\\color{gray}build ' int2str(BRAPH2.BUILD) '}']
        ''
        'Please, select a valid number of Layer Labels.'
        ''
        ''};
    braph2msgbox(title, message)
    
    sub.set('LAYERLABELS', cat(1, strsplit(num2str(1:1:length(sub.get('CON_MP'))))))
end

%%% ¡prop!
ALAYERLABELS (query, stringlist) returns the processed layer labels.
%%%% ¡calculate!
value = sub.get('LAYERLABELS');

%%% ¡prop!
CON_MP (data, cell) is a cell containing L matrices corresponding connectivity matrices of each layer.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
num_layers = sub.get('L');
check = (iscell(value) && isequal(length(value), num_layers)  && isequal( cellfun(@(v) size(v, 1), value), ones(1, num_layers) * br_number)  && isequal( cellfun(@(v) size(v, 2), value), ones(1, num_layers) * br_number)) || (isempty(value) && br_number == 0);
if check
    msg = 'All ok!';
else   
    msg = ['CON_MP must be a cell with L square matrices with the dimensiton equal to the number of brain regions (' int2str(br_number) ').'];
end
%%%% ¡postset!
if length(sub.get('LAYERLABELS')) ~= sub.get('L')
    sub.set('LAYERLABELS', cat(1, strsplit(num2str(1:1:length(sub.get('CON_MP'))))))
end
%%%% ¡gui!
pr = PanelPropCell('EL', sub, 'PROP', SubjectCON_MP.CON_MP, ...
    'TABLE_HEIGHT', s(40), ...
    'XSLIDERSHOW', true, ...
    'XSLIDERLABELS', sub.getCallback('ALAYERLABELS'), ...
    'YSLIDERSHOW', false, ...
    'ROWNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
    'COLUMNNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
    varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'aal90_atlas.xlsx');
ba = im_ba.get('BA');

gr = Group('SUB_CLASS', 'SubjectCON_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_MP'));
for i = 1:1:10
    sub = SubjectCON_MP( ...
        'ID', ['SUB CON_MP ' int2str(i)], ...
        'LABEL', ['Subejct CON_MP ' int2str(i)], ...
        'NOTES', ['Notes on subject CON_MP ' int2str(i)], ...
        'BA', ba, ...
        'L', 3, ...
        'LAYERLABELS', {'L1' 'L2' 'L3'}, ...
        'CON_MP', {rand(ba.get('BR_DICT').get('LENGTH')), rand(ba.get('BR_DICT').get('LENGTH')), rand(ba.get('BR_DICT').get('LENGTH'))} ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr.get('SUB_DICT').get('ADD', sub)
end

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')
