%% ¡header!
Subject < ConcreteElement (sub, subject) is a subject.

%%% ¡description!
A Subject provides the methods necessary for all subjects. 
 Instances of this element should not be created. 
 Use one of its subelements instead.

%%% ¡seealso!
Group

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the subject.
%%%% ¡default!
'Subject'

%%% ¡prop!
NAME (constant, string) is the name of the subject.
%%%% ¡default!
'Subject'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject.
%%%% ¡default!
'A Subject provides the methods necessary for all subjects. Instances of this element should not be created. Use one of its subelements instead.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject.
%%% ¡settings!
'Subject'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.
%%%% ¡default!
'Subject ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.
%%%% ¡default!
'Subject label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.
%%%% ¡default!
'Subject notes'

%% ¡props!

%%% ¡prop!
VOI_DICT (data, idict) contains the variables of interest of the subject.
%%%% ¡settings!
'VOI'
%%%% ¡gui!
pr = SubjectPP_VOIDict('EL', sub, 'PROP', Subject.VOI_DICT, varargin{:});