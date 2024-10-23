%% ¡header!
ImporterGroupSubjectCON_MP_XLS < Importer (im, importer of CON MP subject group from XLS/XLSX) imports a group of subjects with connectivity multiplex data from a series of XLS/XLSX file.

%%% ¡description!
ImporterGroupSubjectCON_MP_XLS imports a group of subjects with connectivity 
 multiplex data from a series of XLS/XLSX files contained in a folder named 
 "GROUP_ID". All these files must be in the same folder; also, no other 
 files should be in the folder. Each file contains a table of values 
 corresponding to the adjacency matrix of a layer. Files should be labeled 
 with the layer number indicated as, e.g., "SUBJECT_ID.1.xlsx" and 
 "SUBJECT_ID.2.xlsx".
The variables of interest are from another XLS/XLSX file named "GROUP_ID.vois.xlsx" 
 (if exisitng) consisting of the following columns: 
 Subject ID (column 1), covariates (subsequent columns). 
 The 1st row contains the headers, the 2nd row a string with the categorical
 variables of interest, and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SubjectCON_MP, ExporterGroupSubjectCON_MP_XLS

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the CON MP subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectCON_MP_XLS'

%%% ¡prop!
NAME (constant, string) is the name of the CON MP subject group importer from XLS/XLSX.
%%%% ¡default!
'Multiplex Connectivity Subject Group XLS Importer'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the CON MP subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectCON_MP_XLS imports a group of subjects with connectivity multiplex data from a series of XLS/XLSX files and their covariates (optional) from another XLS/XLSX file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the CON MP subject group importer from XLS/XLSX.
%%%% ¡settings!
'ImporterGroupSubjectCON_MP_XLS'

%%% ¡prop!
ID (data, string) is a few-letter code for the CON MP subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectCON_MP_XLS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the CON MP subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectCON_MP_XLS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the CON MP subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectCON_MP_XLS notes'

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the CON MP subject folders from which to load the L layers of the group.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where to load the XLS/XLSX files of the FUN MP subject group with L layers.
%%%% ¡settings!
'ImporterGroupSubjectCON_MP_XLS'
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
GR (result, item) is a group of subjects with connectivity multiplex data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectCON_MP', [], [], true))); 
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_MP'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectCON_MP', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_MP') ...
    );

gr.lock('SUB_CLASS');

directory = im.get('DIRECTORY');
if isfolder(directory)
    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading directory ...');

    [~, name] = fileparts(directory);
    gr.set( ...
        'ID', name, ...
        'LABEL', name, ...
        'NOTES', ['Group loaded from ' directory] ...
        );

    try
        braph2waitbar(wb, .15, 'Loading subject group ...')

        files = [dir(fullfile(directory, '*.xlsx')); dir(fullfile(directory, '*.xls'))];
        
        if ~isempty(files)
            % brain atlas
            ba = im.get('BA');
            if ba.get('BR_DICT').get('LENGTH') == 0
                % adds the number of regions of the first file to the brain atlas
                br_number = size(xlsread(fullfile(directory, files(1).name)), 1);
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
                CON_MP = {};
                for l = 1:1:L
                    filename = fullfile(directory, [sub_id '.' int2str(l) '.xls']);
                    if isfile(filename)
                        CON = xlsread(filename);
                    else
                        CON = xlsread([filename 'x']);
                    end
                    if size(CON, 1) ~= ba.get('BR_DICT').get('LENGTH') || size(CON, 2) ~= ba.get('BR_DICT').get('LENGTH')
                        error( ...
                            [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO], ...
                            [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO '\\n' ...
                            'The file ' sub_id ' should contain a matrix ' int2str(ba.get('BR_DICT').get('LENGTH')) 'x' int2str(ba.get('BR_DICT').get('LENGTH')) ', ' ...
                            'while it is ' int2str(size(CON, 1)) 'x' int2str(size(CON, 2)) '.'] ...
                            )
                    end
                    CON_MP = [CON_MP, CON];
                end
                
                sub = SubjectCON_MP( ...
                    'ID', sub_id, ...
                    'BA', ba, ...
                    'L', L, ...
                    'CON_MP', CON_MP ...
                );
                sub_dict.get('ADD', sub);
            end
            
            % variables of interest
            vois = [];
            if isfile([directory '.vois.xls'])
                [~, ~, vois] = xlsread([directory '.vois.xls']);
            elseif isfile([directory '.vois.xlsx'])
                [~, ~, vois] = xlsread([directory '.vois.xlsx']);
            end
            if ~isempty(vois)
                for i = 3:1:size(vois, 1)
                    sub_id = vois{i, 1};
                    sub = sub_dict.get('IT', sub_id);
                    for v = 2:1:size(vois, 2)
                        voi_id = vois{1, v};
                        if isnumeric(vois{2, v}) % VOINumeric
                            sub.memorize('VOI_DICT').get('ADD', ...
                                VOINumeric( ...
                                    'ID', voi_id, ...
                                    'V', vois{i, v} ...
                                    ) ...
                                );
                        elseif ischar(vois{2, v}) % VOICategoric
                            sub.memorize('VOI_DICT').get('ADD', ...
                                VOICategoric( ...
                                    'ID', voi_id, ...
                                    'CATEGORIES', str2cell(vois{2, v}), ...
                                    'V', find(strcmp(vois{i, v}, str2cell(vois{2, v}))) ...
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
    error([BRAPH2.STR ':ImporterGroupSubjectCON_MP_XLS:' BRAPH2.ERR_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectCON_MP_XLS:' BRAPH2.ERR_IO '\\n' ...
        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectCON_MP_XLS.GET_DIR]

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
create_data_CON_MP_XLS() % only creates files if the example folder doesn't already exist

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectCON_MP')) filesep 'Example data CON_MP XLS' filesep 'atlas.xlsx']);
ba = im_ba.get('BA');

im_gr = ImporterGroupSubjectCON_MP_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectCON_MP')) filesep 'Example data CON_MP XLS' filesep 'CON_MP_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr = im_gr.get('GR');

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')