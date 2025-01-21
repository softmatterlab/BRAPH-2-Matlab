%% ¡header!
PipelineSection < ConcreteElement (ps, pipeline section) is a pipeline code section.

%%% ¡description!
A Pipeline Section (PipelineSection) represents a section of executable code in a pipeline.

%%% ¡seealso!
PipelinePP_PSDict, Pipeline, PipelineSection

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the pipeline section.
%%%% ¡default!
'PipelineSection'

%%% ¡prop!
NAME (constant, string) is the name of the pipeline section.
%%%% ¡default!
'Pipeline Section'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the pipeline section.
%%%% ¡default!
'A Pipeline Section (PipelineSection) represents a section of executable code in a pipeline.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the pipeline section.
%%%% ¡settings!
'PipelineSection'

%%% ¡prop!
ID (data, string) is a few-letter code for the pipeline section.
%%%% ¡default!
'PipelineSection ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the pipeline section.
%%%% ¡default!
'PipelineSection label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the pipeline section.
%%%% ¡default!
'PipelineSection notes'

%% ¡props!

%%% ¡prop!
PC_DICT (data, idict) is an indexed dictionary with the executable code lines.
%%%% ¡settings!
'PipelineCode'
