%% ¡header!
SubjectFUN_MP < Subject (sub, subject with functional multiplex data) is a subject with functional multiplex data (e.g. multiplex fMRI).

%%% ¡description!
Subject with data for each brain region corresponding to L functional layers (e.g. activation timeseries obtaiend from fMRI or EEG).

%%% ¡seealso!
ImporterGroupSubjectFUN_MP_TXT, ExporterGroupSubjectFUN_MP_TXT, ImporterGroupSubjectFUN_MP_XLS, ExporterGroupSubjectFUN_MP_XLS

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
        im = ImporterGroupSubjectFUN_MP_TXT( ...
            'ID', 'Import Group of SubjectFUN_MPs from TXT', ...
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
        warndlg(['Please, select a valid input Group of SubjectFUN_MPs in TXT format. ' newline() ...
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
        im = ImporterGroupSubjectFUN_MP_XLS( ...
            'ID', 'Import Group of SubjectFUN_MPs from XLS', ...
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
        warndlg(['Please, select a valid input Group of SubjectFUN_MPs in XLS format. ' newline() ...
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
    ex = ExporterGroupSubjectFUN_MP_TXT( ...
        'ID', 'Export Brain Group of SubjectFUNMps to TXT', ...
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
    ex = ExporterGroupSubjectFUN_MP_XLS( ...
        'ID', 'Export Brain Group of SubjectFUNMps to XLS', ...
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
SubjectFUN_MP.ID
%%%% ¡title!
Subject ID

%%% ¡prop!
%%%% ¡id!
SubjectFUN_MP.LABEL
%%%% ¡title!
Subject LABEL

%%% ¡prop!
%%%% ¡id!
SubjectFUN_MP.BA
%%%% ¡title!
Brain Atlas

%%% ¡prop!
%%%% ¡id!
SubjectFUN_MP.VOI_DICT
%%%% ¡title!
Variables of Interest

%%% ¡prop!
%%%% ¡id!
SubjectFUN_MP.L
%%%% ¡title!
Layer Number

%%% ¡prop!
%%%% ¡id!
SubjectFUN_MP.LAYERLABELS
%%%% ¡title!
Layer Labels

%%% ¡prop!
%%%% ¡id!
SubjectFUN_MP.FUN_MP
%%%% ¡title!
Functional DATA LAYERS

%%% ¡prop!
%%%% ¡id!
SubjectFUN_MP.NOTES
%%%% ¡title!
Subject NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the subject.
%%%% ¡default!
'SubjectFUN_MP'

%%% ¡prop!
NAME (constant, string) is the name of the subject.
%%%% ¡default!
'Multiplex Functional Subject'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject.
%%%% ¡default!
'Subject with data for each brain region corresponding to L functional layers (e.g. activation timeseries obtaiend from fMRI or EEG).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject.
%%% ¡settings!
'SubjectFUN_MP'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.
%%%% ¡default!
'SubjectFUN_MP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.
%%%% ¡default!
'SubjectFUN_MP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.
%%%% ¡default!
'SubjectFUN_MP notes'

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
if ~isa(sub.getr('FUN_MP'), 'NoValue') && sub.get('L') ~= length(sub.get('FUN_MP'))
    sub.set('L', length(sub.get('FUN_MP')))
end

%%% ¡prop!
LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.
%%%% ¡postset!
if ~isa(sub.getr('L'), 'NoValue') && length(sub.get('LAYERLABELS')) ~= sub.get('L')
    title = ['About Layer Labels'];
    message = {''
        ['{\\bf\\color{orange}' BRAPH2.STR '}'] % note to use double slashes to avoid genesis problem
        ['{\\color{gray}version ' BRAPH2.VERSION '}']
        ['{\\color{gray}build ' int2str(BRAPH2.BUILD) '}']
        ''
        'Please, select a valid number of Layer Labels.'
        ''
        ''};
    braph2msgbox(title, message)
    
    sub.set('LAYERLABELS', cat(1, strsplit(num2str(1:1:length(sub.get('FUN_MP'))))))
end

%%% ¡prop!
ALAYERLABELS (query, stringlist) returns the processed layer labels.
%%%% ¡calculate!
value = sub.get('LAYERLABELS');

%%% ¡prop!
FUN_MP (data, cell) is a cell containing L matrices with each column corresponding to the time series of a brain region.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
num_layers = sub.get('L');
check = (iscell(value) && isequal(length(value), num_layers)  && isequal( cellfun(@(v) size(v, 2), value), ones(1, num_layers) * br_number)) || (isempty(value) && br_number == 0); 
if check
    msg = 'All ok!';
else   
    msg = ['FUN_MP must be a cell with L matrices with the same number of columns as the number of brain regions (' int2str(br_number) ').'];
end
%%%% ¡postset!
if length(sub.get('LAYERLABELS')) ~= sub.get('L')
    sub.set('LAYERLABELS', cat(1, strsplit(num2str(1:1:length(sub.get('FUN_MP'))))))
end
%%%% ¡gui!
pr = PanelPropCell('EL', sub, 'PROP', SubjectFUN_MP.FUN_MP, ...
    'TABLE_HEIGHT', s(40), ...
    'XSLIDERSHOW', true, ...
    'XSLIDERLABELS', sub.getCallback('ALAYERLABELS'), ...
    'YSLIDERSHOW', false, ...
    'ROWNAME', {'numbered'}, ...
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

gr = Group('SUB_CLASS', 'SubjectFUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN_MP'));
for i = 1:1:10
    sub = SubjectFUN_MP( ...
        'ID', ['SUB FUN_MP ' int2str(i)], ...
        'LABEL', ['Subejct FUN_MP ' int2str(i)], ...
        'NOTES', ['Notes on subject FUN_MP ' int2str(i)], ...
        'BA', ba, ...
        'L', 3, ...
        'LAYERLABELS', {'L1' 'L2' 'L3'}, ...
        'FUN_MP', {rand(10, ba.get('BR_DICT').get('LENGTH')), rand(10, ba.get('BR_DICT').get('LENGTH')), rand(10, ba.get('BR_DICT').get('LENGTH'))} ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr.get('SUB_DICT').get('ADD', sub)
end

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')
