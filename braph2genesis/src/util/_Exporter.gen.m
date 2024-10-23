%% ¡header!
Exporter < ConcreteElement (ex, exporter to a file) exports a concrete element to a file.

%%% ¡description!
An Exporter is the base class for the exporter of an element (ConcreteElement) to a file.

%%% ¡seealso!
ConcreteElement, Importer

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the exporter.
%%%% ¡default!
'Exporter'

%%% ¡prop!
NAME (constant, string) is the name of the exporter.
%%%% ¡default!
'Exporter'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the exporter.
%%%% ¡default!
'An Exporter is the base class for the exporter of an element (ConcreteElement) to a file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the exporter.
%%%% ¡settings!
'Exporter'

%%% ¡prop!
ID (data, string) is a few-letter code for the exporter.
%%%% ¡default!
'Exporter ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the exporter.
%%%% ¡default!
'Exporter label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the exporter.
%%%% ¡default!
'Exporter notes'

%% ¡props!

%%% ¡prop!
WAITBAR (gui, logical) detemines whether to show the waitbar.