%% ¡header!
ImporterGroupSubjectFUN_MP_TXT < Importer (im, importer of FUN MP subject group from TXT) imports a group of subjects with functional multiplex data from an TXT file.

%%% ¡description!
ImporterGroupSubjectFUN_MP_TXT imports a group of subjects with functional 
 multiplex data from a series of TXT files contained in a folder named 
 "GROUP_ID". All these files must be in the same folder; also, no other 
 files should be in the folder. Each file contains a table with each row 
 corresponding to a time serie and each column to a brain region. Files 
 should be labeled with the layer number indicated as, e.g., 
 "SUBJECT_ID.1.txt" and "SUBJECT_ID.2.txt".
The variables of interest are from another TXT file named "GROUP_ID.vois.txt" 
 (if exisitng) consisting of the following columns: 
 Subject ID (column 1), covariates (subsequent columns). 
 The 1st row contains the headers, the 2nd row a string with the categorical
 variables of interest, and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SubjectFUN_MP, ExporterGroupSubjectFUN_MP_TXT

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the FUN MP subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectFUN_MP_TXT'

%%% ¡prop!
NAME (constant, string) is the name of the FUN MP subject group importer from TXT.
%%%% ¡default!
'Multiplex Functional Subject Group TXT Importer'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the FUN MP subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectFUN_MP_TXT imports a group of subjects with functional multiplex data from an TXT file and their covariates (optional) from another TXT file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the FUN MP subject group importer from TXT.
%%%% ¡settings!
'ImporterGroupSubjectFUN_MP_TXT'

%%% ¡prop!
ID (data, string) is a few-letter code for the FUN MP subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectFUN_MP_TXT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the FUN MP subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectFUN_MP_TXT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the FUN MP subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectFUN_MP_TXT notes'

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the FUN MP subject group files from which to load the L layers of the subject group.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where to load the TXT files of the FUN MP subject group with L layers.
%%%% ¡settings!
'ImporterGroupSubjectFUN_MP_TXT'
%%%% ¡calculate!
directory = uigetdir('Select directory');
if ischar(directory) && isfolder(directory)
    im.set('DIRECTORY', directory);
end
value = im;

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
GR (result, item) is a group of subjects with functional multiplex data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectFUN_MP', [], [], true))); 
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN_MP'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectFUN_MP', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN_MP') ...
    );

gr.lock('SUB_CLASS');

directory = im.get('DIRECTORY');
if isfolder(directory)
    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading directory ...');

    % sets group props
    [~, name] = fileparts(directory);
    gr.set( ...
        'ID', name, ...
        'LABEL', name, ...
        'NOTES', ['Group loaded from ' directory] ...
        );

    try
        braph2waitbar(wb, .15, 'Loading subject group ...')
        % analyzes file

        files = dir(fullfile(directory, '*.txt'));
        
        if ~isempty(files)
            % brain atlas
            ba = im.get('BA');
            if ba.get('BR_DICT').get('LENGTH') == 0
                % adds the number of regions of the first file to the brain atlas
                br_number = size(readtable(fullfile(directory, files(1).name), 'Delimiter', '\t'), 2);
                br_dict = ba.memorize('BR_DICT');
                for j = 1:1:br_number
                    br_dict.get('ADD', BrainRegion('ID', ['br' int2str(j)]))
                end
            end
            
            % determines the number of layers and the subjects
            L = 0;
            sub_ids = {};
            for i = 1:1:length(files)
                [~, sub_id_layer_no] = fileparts(files(i).name);
                splits = regexp(sub_id_layer_no, '(.+)\\.(\\d+)', 'tokens');
                sub_ids = [sub_ids, splits{1}{1}];
                L = max(L, str2double(splits{1}{2}));
            end
            sub_ids = unique(sub_ids);
            
            % adds subjects
            sub_dict = gr.memorize('SUB_DICT');
            for i = 1:1:length(sub_ids)
                braph2waitbar(wb, .15 + .85 * i / length(sub_ids), ['Loading subject ' num2str(i) ' of ' num2str(length(sub_ids)) ' ...'])

                % read files
                sub_id = sub_ids{i};
                FUN_MP = {};
                for l = 1:1:L
                    FUN = table2array(readtable(fullfile(directory, [sub_id '.' int2str(l) '.txt'])));
                    if size(FUN, 2) ~= ba.get('BR_DICT').get('LENGTH')
                        error( ...
                            [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO], ...
                            [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO '\\n' ...
                            'The file ' sub_id '.' int2str(l) '.xls should contain a matrix with ' int2str(ba.get('BR_DICT').get('LENGTH')) ' columns corresponding to the brain regions, ' ...
                            'while it contains ' int2str(size(FUN, 2)) ' columns.'] ...
                            )
                    end
                    FUN_MP = [FUN_MP, FUN];
                end
                
                sub = SubjectFUN_MP( ...
                    'ID', sub_id, ...
                    'BA', ba, ...
                    'L', L, ...
                    'FUN_MP', FUN_MP ...
                );
                sub_dict.get('ADD', sub);
            end

            % variables of interest
            if isfile([directory '.vois.txt'])
                vois = textread([directory '.vois.txt'], '%s', 'delimiter', '\t', 'whitespace', '');
                vois = reshape(vois, find(strcmp('', vois), 1) - 1, [])';
                for i = 3:1:size(vois, 1)
                    sub_id = vois{i, 1};
                    sub = sub_dict.get('IT', sub_id);
                    for v = 2:1:size(vois, 2)
                        voi_id = vois{1, v};
                        if isempty(vois{2, v}) % VOINumeric
                            sub.memorize('VOI_DICT').get('ADD', ...
                                VOINumeric( ...
                                    'ID', voi_id, ...
                                    'V', str2num(vois{i, v}) ...
                                    ) ...
                                );
                        elseif ~isempty(vois{2, v}) % VOICategoric
                            categories = eval(vois{2, v});
                            sub.memorize('VOI_DICT').get('ADD', ...
                                VOICategoric( ...
                                    'ID', voi_id, ...
                                    'CATEGORIES', str2cell(categories), ...
                                    'V', find(strcmp(vois{i, v}, categories)) ...
                                    ) ...
                                );
                        end                        
                    end
                end
            end
        end
    catch e
        braph2waitbar(wb, 'close')
        
        rethrow(e)
    end
    
    braph2waitbar(wb, 'close')
else
    error([BRAPH2.STR ':ImporterGroupSubjectFUN_MP_TXT:' BRAPH2.ERR_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectFUN_MP_TXT:' BRAPH2.ERR_IO '\\n' ...
        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectFUN_MP_TXT.GET_DIR]

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
create_data_FUN_MP_TXT() % only creates files if the example folder doesn't already exist

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasTXT('FILE', [fileparts(which('SubjectFUN_MP')) filesep 'Example data FUN_MP TXT' filesep 'atlas.txt']);
ba = im_ba.get('BA');

im_gr = ImporterGroupSubjectFUN_MP_TXT( ...
    'DIRECTORY', [fileparts(which('SubjectFUN_MP')) filesep 'Example data FUN_MP TXT' filesep 'FUN_MP_Group_1_TXT'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr = im_gr.get('GR');

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')