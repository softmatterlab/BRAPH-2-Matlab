%% ¡header!
BrainAtlas < ConcreteElement (ba, brain atlas) is a brain atlas.

%%% ¡description!
A Brain Atlas (BrainAtlas) represents a brain atlas, constituted 
 by a collection of brain regions.
BrainAtlas contains and manages brain regions inside an IndexedDictionary; 
 thus, it has access to all IndexedDictionary methods.
BrainAtlas can be imported/exported to .txt, .xls and .json files.

%%% ¡seealso!
BrainRegion, BrainSurface, ImporterBrainAtlasXLS, ImporterBrainAtlasTXT, ExporterBrainAtlasXLS, ExporterBrainAtlasTXT

%%% ¡build!
1

%% ¡gui!

%%% ¡menu_import!
uimenu(menu_import, ...
    'Tag', 'MENU.Import.TXT', ...
    'Label', 'Import TXT ...', ...
    'Callback', {@cb_importer_TXT});
function cb_importer_TXT(~, ~)
    try
        im = ImporterBrainAtlasTXT( ...
            'ID', 'Import Brain Atlas from TXT', ...
            'WAITBAR', true ...
            ).get('GET_FILE');
        if ~isa(im.getr('FILE'), 'NoValue')
            ba = im.get('BA');
            gui = GUIElement('PE', ba);
            gui.get('DRAW')
            gui.get('SHOW')
        end
    catch e
        %TODO implement and use braph2msgbox instead of warndlg
        warndlg(['Please, select a valid input BrainAtlas in TXT format. ' newline() ...
            newline() ...
            'Error message:' newline() ...
            newline() ...
            e.message newline()], 'Warning');
    end
end

uimenu(menu_import, ...
    'Tag', 'MENU.Import.XLS', ...
    'Label', 'Import XLS ...', ...
    'Callback', {@cb_importer_XLS});
function cb_importer_XLS(~, ~)
    try
        im = ImporterBrainAtlasXLS( ...
            'ID', 'Import Brain Atlas from XLS', ...
            'WAITBAR', true ...
            ).get('GET_FILE');
        if ~isa(im.getr('FILE'), 'NoValue')
            ba = im.get('BA');
            gui = GUIElement('PE', ba);
            gui.get('DRAW')
            gui.get('SHOW')
        end
    catch e
        %TODO implement and use braph2msgbox instead of warndlg
        warndlg(['Please, select a valid input BrainAtlas in XLS format. ' newline() ...
            newline() ...
            'Error message:' newline() ...
            newline() ...
            e.message newline()], 'Warning');
    end
end

%%% ¡menu_export!
uimenu(menu_export, ...
    'Tag', 'MENU.Export.TXT', ...
    'Label', 'Export TXT ...', ...
    'Callback', {@cb_exporter_TXT});
function cb_exporter_TXT(~, ~)
    ex = ExporterBrainAtlasTXT( ...
        'ID', 'Export Brain Atlas to TXT', ...
        'BA', el, ...
        'WAITBAR', true ...
        ).get('PUT_FILE');
    if ~isa(ex.getr('FILE'), 'NoValue')
        ex.get('SAVE');
    end
end

uimenu(menu_export, ...
    'Tag', 'MENU.Export.XLS', ...
    'Label', 'Export XLS ...', ...
    'Callback', {@cb_exporter_XLS});
function cb_exporter_XLS(~, ~)
    ex = ExporterBrainAtlasXLS( ...
        'ID', 'Export Brain Atlas to XLS', ...
        'BA', el, ...
        'WAITBAR', true ...
        ).get('PUT_FILE');
    if ~isa(ex.getr('FILE'), 'NoValue')
        ex.get('SAVE');
    end
end

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
BrainAtlas.ID
%%%% ¡title!
Brain Atlas ID

%%% ¡prop!
%%%% ¡id!
BrainAtlas.LABEL
%%%% ¡title!
Brain Atlas NAME

%%% ¡prop!
%%%% ¡id!
BrainAtlas.BR_DICT
%%%% ¡title!
Brain Regions

%%% ¡prop!
%%%% ¡id!
BrainAtlas.PFBA
%%%% ¡title!
Brain Plot

%%% ¡prop!
%%%% ¡id!
BrainAtlas.NOTES
%%%% ¡title!
Brain Atlas NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the brain atlas (BrainAtlas).
%%%% ¡default!
'BrainAtlas'

%%% ¡prop!
NAME (constant, string) is the name of the brain atlas.
%%%% ¡default!
'Brain Atlas'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the brain atlas.
%%%% ¡default!
'A Brain Atlas (BrainAtlas) represents a brain atlas, constituted by a collection of brain regions. BrainAtlas contains and manages brain regions inside an IndexedDictionary; thus, it has access to all IndexedDictionary methods. BrainAtlas can be imported/exported to .txt, .xls and .json files.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
ID (data, string) is a few-letter code for the brain atlas.
%%%% ¡default!
'BrainAtlas ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the brain atlas.
%%%% ¡default!
'BrainAtlas label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the brain atlas.
%%%% ¡default!
'BrainAtlas notes'

%% ¡props!

%%% ¡prop!
BR_DICT (data, idict) contains the brain regions of the brain atlas.
%%%% ¡settings!
'BrainRegion'
%%%% ¡gui!
% % example code to use CB_TAB_EDIT
% cb_tab_edit_code = {
%     'switch col'
%         'case BrainRegion.ID'
%             'if ~dict.get('CONTAINS_KEY', newdata)'
%                 '' % change brain region id
%                 'dict.get('IT', i).set(''ID'', newdata)'
%                 '' % change brain region key in idict
%                 'dict.get('REPLACE_KEY', dict.get('KEY', i), newdata);' % oldkey = dict.get('KEY', i)
%             'end'
%     'otherwise'
%         'cb_table_edit_default()'
%     'end'
%     };
pr = PanelPropIDictTable('EL', ba, 'PROP', BrainAtlas.BR_DICT, ... 
	'COLS', [PanelPropIDictTable.SELECTOR BrainRegion.ID BrainRegion.LABEL BrainRegion.X BrainRegion.Y BrainRegion.Z BrainRegion.NOTES], ...
	'ROWNAME', 'numbered', ... % 'CB_TAB_EDIT', cb_tab_edit_code, ... % example code to use CB_TAB_EDIT
    'APPLY_TO_SELECTION', false, ...
	varargin{:});

%%% ¡prop!
PFBA (gui, item) contains the panel figure of the brain atlas.
%%%% ¡settings!
'BrainAtlasPF'
%%%% ¡postprocessing!
if isa(ba.getr('PFBA'), 'NoValue')
    ba.memorize('PFBA').set('BA', ba)
end
%%%% ¡gui!
pr = PanelPropItem('EL', ba, 'PROP', BrainAtlas.PFBA, ...
    'GUICLASS', 'GUIFig', ...
    'BUTTON_TEXT', 'Plot Brain Atlas', ...
    varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[BrainAtlas.TEMPLATE BrainAtlas.PFBA]

%%% ¡test!
%%%% ¡name!
Basic functions
%%%% ¡probability!
.01
%%%% ¡code!
br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
br6 = BrainRegion('ID', 'id6', 'LABEL', 'label6', 'NOTES', 'notes6', 'X', 6, 'Y', 6, 'Z', 6);

items = {br1, br2, br3, br4, br5, br6};

idict_1 = IndexedDictionary( ...
    'ID', 'idict', ...
    'IT_CLASS', 'BrainRegion', ...
    'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'IT_LIST', items ...
    );
ba = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'NOTES', 'Notes on brain atlas.', 'BR_DICT', idict_1);
assert(ischar(ba.tostring()), ...
    [BRAPH2.STR ':BrainAtlas:' BRAPH2.FAIL_TEST], ...
    'BrainAtlas.tostring() must return a string.')

%%% ¡test!
%%%% ¡name!
Get methods
%%%% ¡probability!
.01
%%%% ¡code!
br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
br6 = BrainRegion('ID', 'id6', 'LABEL', 'label6', 'NOTES', 'notes6', 'X', 6, 'Y', 6, 'Z', 6);

items = {br1, br2, br3, br4, br5, br6};

idict_1 = IndexedDictionary( ...
    'ID', 'idict', ...
    'IT_CLASS', 'BrainRegion', ...
    'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'IT_LIST', items ...
    );
ba = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'NOTES', 'Notes on brain atlas.', 'BR_DICT', idict_1);

assert(isequal(ba.get('ID'), 'BA1'), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.FAIL_TEST], ...
    'BrainAtlas.get() does not work.')
assert(isequal(ba.get('LABEL'), 'brain atlas'), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.FAIL_TEST], ...
    'BrainAtlas.get() does not work.')
assert(isequal(ba.get('NOTES'), 'Notes on brain atlas.'), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.FAIL_TEST], ...
    'BrainAtlas.get() does not work.')
assert(isequal(ba.get('BR_DICT'), idict_1), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.FAIL_TEST], ...
    'BrainAtlas.get() does not work.')

%%% ¡test!
%%%% ¡name!
Set methods
%%%% ¡probability!
.01
%%%% ¡code!
br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
br6 = BrainRegion('ID', 'id6', 'LABEL', 'label6', 'NOTES', 'notes6', 'X', 6, 'Y', 6, 'Z', 6);

items = {br1, br2, br3, br4, br5, br6};

idict_1 = IndexedDictionary( ...
    'ID', 'idict', ...
    'IT_CLASS', 'BrainRegion', ...
    'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'IT_LIST', items ...
    );
ba = BrainAtlas();
ba.set('ID', 'BA1');
ba.set('LABEL', 'brain atlas');
ba.set('NOTES', 'Notes on brain atlas.');
ba.set('BR_DICT', idict_1);

assert(isequal(ba.get('ID'), 'BA1'), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.FAIL_TEST], ...
    'BrainAtlas.set() does not work.')
assert(isequal(ba.get('LABEL'), 'brain atlas'), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.FAIL_TEST], ...
    'BrainAtlas.set() does not work.')
assert(isequal(ba.get('NOTES'), 'Notes on brain atlas.'), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.FAIL_TEST], ...
    'BrainAtlas.set() does not work.')
assert(isequal(ba.get('BR_DICT'), idict_1), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.FAIL_TEST], ...
    'BrainAtlas.set() does not work.')

%%% ¡test!
%%%% ¡name!
Plot Brain Atlas GUI
%%%% ¡probability!
.01
%%%% ¡code!
br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
br6 = BrainRegion('ID', 'id6', 'LABEL', 'label6', 'NOTES', 'notes6', 'X', 6, 'Y', 6, 'Z', 6);

items = {br1, br2, br3, br4, br5, br6};

idict_1 = IndexedDictionary( ...
    'ID', 'idict', ...
    'IT_CLASS', 'BrainRegion', ...
    'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'IT_LIST', items ...
    );
ba = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'NOTES', 'Notes on brain atlas.', 'BR_DICT', idict_1);
gui = GUIElement('PE', ba, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')
gui.get('CLOSE')
