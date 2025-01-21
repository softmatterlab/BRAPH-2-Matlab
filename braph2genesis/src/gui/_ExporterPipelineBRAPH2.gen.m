%% ¡header!
ExporterPipelineBRAPH2 < Exporter (ex, pipeline exporter in BRAPH2) exports a pipeline in a BRAPH2 file.

%%% ¡description!
A Pipeline Exporter in BRAPH2 File (ExporterPipelineBRAPH2) exports a pipeline to a BRAPH2 file.

%%% ¡seealso!
Exporter, Pipeline, ImporterPipelineBRAPH2

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the exporter of a pipeline to a BRAPH2 file.
%%%% ¡default!
'ExporterPipelineBRAPH2'

%%% ¡prop!
NAME (constant, string) is the name of the exporter of a pipeline to a BRAPH2 file.
%%%% ¡default!
'Pipeline Exporter in BRAPH2 File'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the exporter of a pipeline to a BRAPH2 file.
%%%% ¡default!
'A Pipeline Exporter in BRAPH2 File (ExporterPipelineBRAPH2) exports a pipeline to a BRAPH2 file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the exporter of a pipeline to a BRAPH2 file.
%%%% ¡settings!
'ExporterPipelineBRAPH2'

%%% ¡prop!
ID (data, string) is a few-letter code for the exporter of a pipeline v a BRAPH2 file.
%%%% ¡default!
'ExporterPipelineBRAPH2 ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the exporter of a pipeline to a BRAPH2 file.
%%%% ¡default!
'ExporterPipelineBRAPH2 label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the exporter of a pipeline to a BRAPH2 file.
%%%% ¡default!
'ExporterPipelineBRAPH2 notes'

%% ¡props!

%%% ¡prop!
PIP (data, item) is a pipeline.
%%%% ¡settings!
'Pipeline'

%%% ¡prop!
FILE (data, string) is the BRAPH2 file where to save the pipeline.
%%%% ¡default!
[fileparts(which('test_braph2')) filesep 'default_braph2_file_to_save_pipeline_most_likely_to_be_erased.braph2']

%%% ¡prop!
PUT_FILE (query, empty) opens a dialog box to set the BRAPH2 file where to save the brain atlas.
%%%% ¡settings!
'ExporterPipelineBRAPH2'
%%%% ¡calculate!
[filename, filepath, filterindex] = uiputfile(BRAPH2.EXT_PIPELINE, 'Select BRAPH2 Pipeline file');
if filterindex
    file = [filepath filename];
    ex.set('FILE', file);
end
value = ex;

%%% ¡prop!
SAVE (result, empty) saves the pipeline in the selected BRAPH2 file.
%%%% ¡calculate!
file = ex.get('FILE');

if isfolder(fileparts(file))
	wb = braph2waitbar(ex.get('WAITBAR'), 0, 'Retrieving path ...');
    
    pip = ex.get('PIP');
   
    txt = [ ...
        '%% ' pip.get('LABEL') newline()  ...
        newline() ...
        ];

    notes = cellfun(@(x) ['% ' strtrim(x) newline()], str2cell(pip.get('NOTES')), 'UniformOutput', false);
    for i = 1:1:length(notes)
        txt = [txt notes{i}];
    end

    txt = [ txt ...
        newline() ...
        '% PDF: ' pip.get('PDF') newline() ...
        '% README: ' pip.get('README') newline() ...
        ];

    ps_dict = pip.get('PS_DICT');
    for s = 1:1:ps_dict.get('LENGTH')
        ps = ps_dict.get('IT', s);
        
        txt = [ txt ...
            newline() ...
            '%% ' ps.get('LABEL') newline() ...
            ];
        
        pc_dict = ps.get('PC_DICT');
        for c = 1:1:pc_dict.get('LENGTH')
            braph2waitbar(wb, 0 + 1.00 * (s - 1 + c / pc_dict.get('LENGTH')) / ps_dict.get('LENGTH'), ...
                ['Saving pipeline section ' num2str(s) ' of ' num2str(ps_dict.get('LENGTH')) ...
                ', code line ' num2str(c) ' of ' num2str(pc_dict.get('LENGTH')) ' ...'])
                
            pc = pc_dict.get('IT', c);
            
            txt = [ txt ...
                pc.get('MONIKER') ' = ' pc.get('CODE') ' % ' pc.get('TEXT_BEFORE_EXEC') ' % ' pc.get('TEXT_AFTER_EXEC') newline() ...
                ];
        end
    end
    
    txt = regexprep(txt, '%', '%%');
    
    object_file = fopen(ex.get('FILE'), 'w');
    fprintf(object_file, txt);
    fclose(object_file);
    
    braph2waitbar(wb, 'close')
end

% sets value to empty
value = [];

%% ¡tests!

%%% ¡excluded_props!
[ExporterPipelineBRAPH2.PUT_FILE]

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
im = ImporterPipelineBRAPH2(...
    'FILE', [fileparts(which('Pipeline')) filesep 'gui_examples' filesep 'pipeline_atlas.braph2'], ...
    'WAITBAR', true ...
    ); 
pip = im.get('PIP');
% pip.tree(4)

ex= ExporterPipelineBRAPH2( ...
    'PIP', pip, ...
    'WAITBAR', true ...
    );
ex.get('SAVE');

%%% ¡test!
%%%% ¡name!
Delete file TBE
%%%% ¡probability!
1
%%%% ¡code!
warning('off', 'MATLAB:DELETE:FileNotFound')
delete([fileparts(which('test_braph2')) filesep 'default_braph2_file_to_save_pipeline_most_likely_to_be_erased.braph2'])
warning('on', 'MATLAB:DELETE:FileNotFound')
