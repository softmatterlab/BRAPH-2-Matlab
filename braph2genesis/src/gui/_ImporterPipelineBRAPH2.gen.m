%% ¡header!
ImporterPipelineBRAPH2 < Importer (im, importer of pipeline from BRAPH2) imports a brain atlas from a braph2 file.

%%% ¡description!
A Pipeline Importer from BRAPH2 File (ImporterPipelineBRAPH2) imports a pipeline from a BRAPH2 file.
The format of the BRAPH2 file should include the label, description and at least one code section.

%%% ¡seealso!
Importer, Pipeline, ExporterPipelineBRAPH2

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the importer of a pipeline from a BRAPH2 file.
%%%% ¡default!
'ImporterPipelineBRAPH2'

%%% ¡prop!
NAME (constant, string) is the name of the importer of a pipeline from a BRAPH2 file.
%%%% ¡default!
'Pipeline Importer from BRAPH2 File'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the importer of a pipeline from a BRAPH2 file.
%%%% ¡default!
'A Pipeline Importer from BRAPH2 File (ImporterPipelineBRAPH2) imports a pipeline from a BRAPH2 file. The format of the BRAPH2 file should include the label, description and at least one code section.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the importer of a pipeline from a BRAPH2 file.
%%%% ¡settings!
'ImporterPipelineBRAPH2'

%%% ¡prop!
ID (data, string) is a few-letter code for the importer of a pipeline from a BRAPH2 file.
%%%% ¡default!
'ImporterPipelineBRAPH2 ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the importer of a pipeline from a BRAPH2 file.
%%%% ¡default!
'ImporterPipelineBRAPH2 label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the importer of a pipeline from a BRAPH2 file.
%%%% ¡default!
'ImporterPipelineBRAPH2 notes'

%% ¡props!

%%% ¡prop!
FILE (data, string) is the BRAPH2 file from where to load the pipeline.
%%%% ¡default!
'pipeline_atlas.braph2'

%%% ¡prop!
GET_FILE (query, item) opens a dialog box to get the BRAPH2 file from where to load the pipeline.
%%%% ¡settings!
'ImporterPipelineBRAPH2'
%%%% ¡calculate!
[filename, filepath, filterindex] = uigetfile(BRAPH2.EXT_PIPELINE, 'Select BRAPH2 file');
if filterindex
    file = [filepath filename];
    im.set('FILE', file);
end
value = im;

%%% ¡prop!
PIP (result, item) is a pipeline.
%%%% ¡settings!
'Pipeline'
%%%% ¡default!
Pipeline()
%%%% ¡calculate!
% creates empty Pipeline
pip = Pipeline();

% analyzes file
file = im.get('FILE');
if ~isfile(file)
    file = [fileparts(which('braph2')) filesep 'src' filesep 'gui' filesep 'gui_examples' filesep file];
end

if isfile(file)
    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading pipeline file ...');

    try
        txt = fileread(file);

        % Pipeline
        header_marks = regexp(txt, '%%', 'all');
        header_txt = txt(header_marks(1):header_marks(2));
        header_newlines = regexp(header_txt, newline(), 'all');

        [~, id] = fileparts(file);
        pip.set('ID', id)

        label = strtrim(header_txt(3:header_newlines(1))); % eliminates %%
        pip.set('LABEL', label)
        
        notes = strtrim(header_txt(header_newlines(1) + 4:end - 1));
        notes_newlines = regexp(notes, newline(), 'all');
        for i = length(notes_newlines):-1:1
            notes = [notes(1:notes_newlines(i)) strtrim(notes(notes_newlines(i) + 2:end))]; % eliminates % but not newline
        end

        md = regexp(notes, '/tutorials/pipelines/\\w+/readme\\.md', 'match', 'once'); % note \\ for compilation
        notes = regexprep(notes, ['README:.*?(' newline() '|$)'], '');

        pdf = regexp(notes, '/tutorials/pipelines/\\w+/\\w+\\.pdf', 'match', 'once'); % note \\ for compilation
        notes = regexprep(notes, ['PDF:.*?(' newline() '|$)'], '');
        
        pip.set( ...
            'NOTES', strtrim(notes), ...
            'README', md, ...
            'PDF', pdf ...
            )

        % PipelineSection Dictionary
        pip.set('PS_DICT', Pipeline.getPropDefault('PS_DICT'))
        
        txt = txt(header_marks(2):end);
        section_marks = [regexp(txt, '%%', 'all') length(txt) + 1];
        for s = 1:1:length(section_marks) - 1
            section_txt = strtrim(txt(section_marks(s) + 2:section_marks(s + 1) - 1));
            section_newlines = regexp(section_txt, newline(), 'all');

            ps = PipelineSection( ...
                'ID', int2str(s), ...
                'LABEL', strtrim(section_txt(1:section_newlines(1))) ...
                );
            pip.get('PS_DICT').get('ADD', ps)
            
            % PipelineCode Dictionary
            ps.set('PC_DICT', PipelineSection.getPropDefault('PC_DICT'))
            
            section_txt = section_txt(section_newlines(1):end);
            code_marks = [regexp(section_txt, newline(), 'all') length(section_txt) + 1];
            for c = 1:1:length(code_marks) - 1
                braph2waitbar(wb, 0 + 1.00 * (s - 1 + c / (length(code_marks) - 1)) / (length(section_marks) - 1), ...
                    ['Loading pipeline section ' num2str(s) ' of ' num2str(length(section_marks) - 1) ...
                    ', code line ' num2str(c) ' of ' num2str(length(code_marks) - 1) ' ...'])
                
                code_txt = strtrim(section_txt(code_marks(c):code_marks(c + 1) - 1));

                text = strtrim(code_txt(regexp(code_txt, ';', 'once') + 1:end));
                text = text(2:end); % removes initial %
                text_before_exec = strtrim(text(1:regexp(text, '%', 'once') - 1));
                text_after_exec = strtrim(text(regexp(text, '%', 'once') + 1:end));
                
                pc = PipelineCode( ...
                    'ID', int2str(c), ...
                    'MONIKER', strtrim(code_txt(1:regexp(code_txt, '=', 'once') - 1)), ...
                    'TEXT_BEFORE_EXEC', text_before_exec, ...
                    'TEXT_AFTER_EXEC', text_after_exec, ...
                    'CODE', strtrim(code_txt(regexp(code_txt, '=', 'once') + 1:regexp(code_txt, ';', 'once'))) ...
                    );
                ps.get('PC_DICT').get('ADD', pc)
            end
        end
    catch e
        braph2waitbar(wb, 'close')
        
        rethrow(e)
    end
    
    braph2waitbar(wb, 'close')
else
    error([BRAPH2.STR ':ImporterPipelineBRAPH2:' BRAPH2.CANCEL_IO], ...
        [BRAPH2.STR ':ImporterPipelineBRAPH2:' BRAPH2.CANCEL_IO '\\n' ...
        'The prop FILE must be an existing file, but it is ''' file '''.'] ...
        );
end

value = pip;

%% ¡tests!

%%% ¡excluded_props!
[ImporterPipelineBRAPH2.GET_FILE]