%% ¡header!
PipelineCode < ConcreteElement (pc, pipeline code line) is an executable code line of a pipeline.

%%% ¡description!
A Pipeline Code Line (PipelineCode) represents a line of executable code in a pipeline.

%%% ¡seealso!
PipelinePP_PSDict, Pipeline, PipelineSection

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the pipeline code line.
%%%% ¡default!
'PipelineCode'

%%% ¡prop!
NAME (constant, string) is the name of the pipeline code line.
%%%% ¡default!
'Pipeline Code Line'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the pipeline code line.
%%%% ¡default!
'A Pipeline Code Line (PipelineCode) represents a line of executable code in a pipeline.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the pipeline code line.
%%%% ¡settings!
'PipelineCode'

%%% ¡prop!
ID (data, string) is a few-letter code for the pipeline code line.
%%%% ¡default!
'PipelineCode ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the pipeline code line.
%%%% ¡default!
'PipelineCode label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the pipeline code line.
%%%% ¡default!
'PipelineCode notes'

%% ¡props!

%%% ¡prop!
TEXT_BEFORE_EXEC (metadata, string) is the text before the code line execution.

%%% ¡prop!
TEXT_AFTER_EXEC (metadata, string) is the text after the code line execution.

%%% ¡prop!
MONIKER (data, string) is the moniker of the calculated element.
%%%% ¡check_value!
check = ~iskeyword(value) && ~strcmp(value, 'varargin');
if check 
    msg = 'All ok!';
else
    msg = ['The MONIKER (' value ') cannot be a MatLab keyword ' ...
        '(' char(join(cellfun(@(x) ['''' x ''''], iskeyword, 'UniformOutput', false))) ') ' ...
        'or ''varargin''.'];
end

%%% ¡prop!
CODE (data, string) is the code line to calculate the element.

%%% ¡prop!
EL (data, item) is the calculated element.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Error with keyword moniker
%%%% ¡test!
keywords = iskeyword();
keywords{end + 1} = 'varargin';
for i = 1:1:length(keywords)
    assert_with_error( ...
        'PipelineCode(''MONIKER'', varargin{1})', ...
        [BRAPH2.STR ':PipelineCode:' BRAPH2.FAILED_TEST], ...
        keywords{i})
end

assert(isa(PipelineCode('MONIKER', 'a'), 'PipelineCode'))