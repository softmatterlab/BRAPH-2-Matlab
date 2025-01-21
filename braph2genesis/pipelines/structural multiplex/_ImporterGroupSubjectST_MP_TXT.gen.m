%% ¡header!
ImporterGroupSubjectST_MP_TXT < Importer (im, importer of ST MP subject group from TXT) imports a group of subjects with structural multiplex data from an TXT file.

%%% ¡description!
ImporterGroupSubjectST_MP_TXT imports a group of subjects with structural 
 multiplex data from a series of TXT files contained in a folder named 
 "GROUP_ID". All these files must be in the same folder; also, no other 
 files should be in the folder. Each file corresponds to a layer of the 
 multiplex and should be labeled with the layer number indicated as, e.g., 
 "GROUP_ID.1.txt" and "GROUP_ID.2.txt". 
 Each file contains the following columns: Subject ID (column 1), Subject 
 LABEL (column 2), Subject NOTES (column 3) and BrainRegions 
 (columns 4-end; one brain region value per column). The first row contains 
 the headers and each subsequent row the values for each subject.
The variables of interest are from another TXT file named "GROUP_ID.vois.txt" 
 (if exisitng) consisting of the following columns: 
 Subject ID (column 1), covariates (subsequent columns). 
 The 1st row contains the headers, the 2nd row a string with the categorical
 variables of interest, and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SubjectST_MP, ExporterGroupSubjectST_MP_TXT

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the ST MP subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_MP_TXT'

%%% ¡prop!
NAME (constant, string) is the name of the ST MP subject group importer from TXT.
%%%% ¡default!
'Multiplex Structural Subject Group TXT Importer'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ST MP subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_MP_TXT imports a group of subjects with structural multiplex data from an TXT file and their covariates from another TXT file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ST MP subject group importer from TXT.
%%%% ¡settings!
'ImporterGroupSubjectST_MP_TXT'

%%% ¡prop!
ID (data, string) is a few-letter code for the ST MP subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_MP_TXT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ST MP subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_MP_TXT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ST MP subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_MP_TXT notes'

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the ST MP subject group files from which to load the L layers of the subject group.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where to load the TXT files of the ST MP subject group with L layers.
%%%% ¡settings!
'ImporterGroupSubjectST_MP_TXT'
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
GR (result, item) is a group of subjects with structural multiplex data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectST_MP', [], [], true))); 
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST_MP'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectST_MP', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST_MP') ...
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
        
        % analyzes files
        files = dir(fullfile(directory, '*.txt'));

        if ~isempty(files)
            % brain atlas
            braph2waitbar(wb, .25, 'Loading brain atlas ...')
            ba = im.get('BA');
            raw = readtable(fullfile(directory, files(1).name), 'Delimiter', '	');
            br_number = size(raw, 2) - 3;
            if ba.get('BR_DICT').get('LENGTH') == 0
                ba = BrainAtlas();
                br_dict = ba.memorize('BR_DICT');
                for j = 1:1:br_number
                    br_id = raw.Properties.VariableNames{j};
                    br = BrainRegion('ID', br_id);
                    br_dict.get('ADD', br)
                end
            end
            if br_number ~= ba.get('BR_DICT').get('LENGTH')
                error( ...
                    [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO], ...
                    [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO '\\n' ...
                    'The file ' files(1).name ' should contain a matrix with ' int2str(ba.get('BR_DICT').get('LENGTH')) ' columns corresponding to the brain regions, ' ...
                    'while it contains ' int2str(br_number) ' columns.'] ...
                    )
            end
            
            % determines the number of layers
            L = 0;
            for i = 1:1:length(files)
                [~, gr_id_layer_no] = fileparts(files(i).name);
                splits = regexp(gr_id_layer_no, '(.+)\\.(\\d+)', 'tokens');
                gr_id = splits{1}{1};
                L = max(L, str2double(splits{1}{2}));
            end
            
            % adds subjects
            sub_dict = gr.memorize('SUB_DICT');
            for i = 1:1:size(raw, 1)
                braph2waitbar(wb, .25 + .75 * (i - 1) / size(raw, 1), ['Loading subject ' num2str(i - 1) ' of ' num2str(size(raw, 1) - 1) ' ...'])
                
                % read files
                ST_MP = {};
                for l = 1:1:L
                    raw = readtable(fullfile(directory, [gr_id '.' int2str(l) '.txt']), 'Delimiter', '\t');
                    ST = zeros(br_number, 1);
                    for j = 1:1:length(ST)
                        ST(j) = raw{i, 3 + j};
                    end
                    ST_MP = [ST_MP, ST];
                end
                
                sub = SubjectST_MP( ...
                    'ID', char(raw{i, 1}), ...
                    'LABEL', char(raw{i, 2}), ...
                    'NOTES', char(raw{i, 3}), ...
                    'BA', ba, ...
                    'L', L, ...
                    'ST_MP', ST_MP ...
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
    error([BRAPH2.STR ':ImporterGroupSubjectST_MP_TXT:' BRAPH2.ERR_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectST_MP_TXT:' BRAPH2.ERR_IO '\\n' ...
        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectST_MP_TXT.GET_DIR]

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
create_data_ST_MP_TXT()  % only creates files if the example folder doesn't already exist

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasTXT('FILE', [fileparts(which('SubjectST_MP')) filesep 'Example data ST_MP TXT' filesep 'atlas.txt']);
ba = im_ba.get('BA');

im_gr = ImporterGroupSubjectST_MP_TXT( ...
    'DIRECTORY', [fileparts(which('SubjectST_MP')) filesep 'Example data ST_MP TXT' filesep 'ST_MP_Group_1_TXT'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr = im_gr.get('GR');

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')