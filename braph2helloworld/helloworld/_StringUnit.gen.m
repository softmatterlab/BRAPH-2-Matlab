%% ¡header!
StringUnit < ConcreteElement (s, string) contains a user-defined string.

%%% ¡description!
A String Unit (StringUnit) contains a user-defined string. 
This element is created for distribution demonstration purpose.

%%% ¡seealso!
StringCombine, PanelPropString

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
StringUnit.S
%%%% ¡title!
Specified String

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the string unit.
%%%% ¡default!
'StringUnit'

%%% ¡prop!
NAME (constant, string) is the name of the string unit.
%%%% ¡default!
'String Unit'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the string unit.
%%%% ¡default!
'A String Unit (StringUnit) contains a user-defined string. This element is created for distribution demonstration purpose.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the string unit.
%%%% ¡settings!
'StringUnit'

%%% ¡prop!
ID (data, string) is a few-letter code for the string unit.
%%%% ¡default!
'StringUnit ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the string unit.
%%%% ¡default!
'StringUnit label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the string unit.
%%%% ¡default!
'StringUnit notes'
    
%% ¡props!

%%% ¡prop!
S (data, string) is the user-defined string.
%%%% ¡default!
'Hello'

%% ¡tests!

%%% ¡test!
%%%% ¡name!
test
%%%% ¡code!
defined_string = 'test';
su = StringUnit('S', defined_string);

assert(isequal(su.get('S'), defined_string), ...
    [BRAPH2.STR ':StringUnit:' BRAPH2.FAIL_TEST], ...
    'StringUnit does not store the defined string properly.' ...
    )