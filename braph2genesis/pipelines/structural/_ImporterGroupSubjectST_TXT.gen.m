%% ¡header!
ImporterGroupSubjectST_TXT < Importer (im, importer of ST subject group from TXT) imports a group of subjects with structural data from an TXT file.

%%% ¡description!
ImporterGroupSubjectST_XLS imports a group of subjects with structural data 
 from a TXT file named "GROUP_ID.txt". This file contains the 
 following columns: Subject ID (column 1), Subject LABEL (column 2), 
 Subject NOTES (column 3) and BrainRegions (columns 4-end; one brainregion 
 value per column). The first row contains the headers and each subsequent 
 row the values for each subject.
The variables of interest are from another TXT file named "GROUP_ID.vois.txt" 
 (if existing) consisting of the following columns: 
 Subject ID (column 1), covariates (subsequent columns). 
 The 1st row contains the headers, the 2nd row a string with the categorical
 variables of interest, and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SubjectST, ExporterGroupSubjectST_TXT

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the ST subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_TXT'

%%% ¡prop!
NAME (constant, string) is the name of the ST subject group importer from TXT.
%%%% ¡default!
'Structural Subject Group TXT Importer'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ST subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_TXT imports a group of subjects with structural data from an TXT file and their covariates from another TXT file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ST subject group importer from TXT.
%%%% ¡settings!
'ImporterGroupSubjectST_TXT'

%%% ¡prop!
ID (data, string) is a few-letter code for the ST subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_TXT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ST subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_TXT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ST subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_TXT notes'

%% ¡props!

%%% ¡prop!
FILE (data, string) is the TXT file from where to load the ST subject group.
%%%% ¡default!
''

%%% ¡prop!
GET_FILE (query, item) opens a dialog box to set the TXT file from where to load the ST subject group.
%%%% ¡settings!
'ImporterGroupSubjectST_TXT'
%%%% ¡calculate!
[filename, filepath, filterindex] = uigetfile('*.txt', 'Select TXT file');
if filterindex
    file = [filepath filename];
	im.set('FILE', file);
end
value = im;

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
GR (result, item) is a group of subjects with structural data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectST', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectST', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST') ...
    );

gr.lock('SUB_CLASS');

% analyzes file
file = im.get('FILE');
if isfile(file)
    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading File ...');
    
    [~, name, ext] = fileparts(file);
    gr.set( ...
        'ID', name, ...
        'LABEL', [name ext], ...
        'NOTES', ['Group loaded from ' file] ...
        );
    
    try
        braph2waitbar(wb, .15, 'Loading subject group ...')

        raw = readtable(file, 'Delimiter', '\t');
        
        % brain atlas
        braph2waitbar(wb, .25, 'Loading brain atlas ...')
        ba = im.get('BA');
        br_number = size(raw, 2) - 3;
        if ba.get('BR_DICT').get('LENGTH') == 0
            ba = BrainAtlas();
            br_dict = ba.memorize('BR_DICT');
            for j = 4:1:size(raw, 2)
                br_id = raw.Properties.VariableNames{j};
                br = BrainRegion('ID', br_id);
                br_dict.get('ADD', br)
            end
        end
        if br_number ~= ba.get('BR_DICT').get('LENGTH')
            error( ...
                [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO], ...
                [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO '\\n' ...
                'The file ' name '.' ext ' should contain a matrix with ' int2str(ba.get('BR_DICT').get('LENGTH')) ' columns corresponding to the brain regions, ' ...
                'while it contains ' int2str(br_number) ' columns.'] ...
                )
        end
                
        % adds subjects
        sub_dict = gr.memorize('SUB_DICT');
        for i = 1:1:size(raw, 1)
            braph2waitbar(wb, .25 + .75 * i / size(raw, 1), ['Loading subject ' num2str(i) ' of ' num2str(size(raw, 1)) ' ...'])
            
            ST = zeros(br_number, 1);
            for j = 1:1:length(ST)
                ST(j) = raw{i, 3 + j};
            end
            sub = SubjectST( ...
                'ID', char(raw{i, 1}), ...
                'LABEL', char(raw{i, 2}), ...
                'NOTES', char(raw{i, 3}), ...
                'BA', ba, ...
                'ST', ST ...
                );
            sub_dict.get('ADD', sub);
        end
        
        % variables of interest
        if isfile([fileparts(file) filesep() name  '.vois.txt'])
            vois = textread([fileparts(file) filesep() name  '.vois.txt'], '%s', 'delimiter', '\t', 'whitespace', '');
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
    catch e
        braph2waitbar(wb, 'close')
        
        rethrow(e)
    end
    
    braph2waitbar(wb, 'close')
elseif ~isempty(file)
    error([BRAPH2.STR ':ImporterGroupSubjectST_TXT:' BRAPH2.CANCEL_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectST_TXT:' BRAPH2.CANCEL_IO '\\n' ...
        'The prop FILE must be an existing file, but it is ''' file '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectST_TXT.GET_FILE]

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
create_data_ST_TXT() % only creates files if the example folder doesn't already exist

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasTXT('FILE', [fileparts(which('SubjectST')) filesep 'Example data ST TXT' filesep 'atlas.txt']);
ba = im_ba.get('BA');

im_gr = ImporterGroupSubjectST_TXT( ...
    'FILE', [fileparts(which('SubjectST')) filesep 'Example data ST TXT' filesep 'ST_Group_1.txt'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr = im_gr.get('GR');

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')