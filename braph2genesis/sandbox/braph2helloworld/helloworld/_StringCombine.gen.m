%% ¡header!
StringCombine < ConcreteElement (sc, string combine) combines the string from two string units.

%%% ¡description!
A String Combine (StringCombine) combines the strings from two string units.
This element is created for distribution demonstration purpose.

%%% ¡seealso!
StringUnit, PanelPropString

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
StringCombine.SU1
%%%% ¡title!
The First String

%%% ¡prop!
%%%% ¡id!
StringCombine.SU2
%%%% ¡title!
The Second String

%%% ¡prop!
%%%% ¡id!
StringCombine.S_COMBINED
%%%% ¡title!
Combined Strings

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the string combine.
%%%% ¡default!
'StringCombine'

%%% ¡prop!
NAME (constant, string) is the name of the string combine.
%%%% ¡default!
'String Combine'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the string combine.
%%%% ¡default!
'A String Combine (StringCombine) combines the strings from two string units. This element is created for distribution demonstration purpose.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the string combine.
%%%% ¡settings!
'StringCombine'

%%% ¡prop!
ID (data, string) is a few-letter code for the string combine.
%%%% ¡default!
'StringCombine ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the string combine.
%%%% ¡default!
'StringCombine label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the string combine.
%%%% ¡default!
'StringCombine notes'
    
%% ¡props!

%%% ¡prop!
SU1 (data, item) is the first string unit.
%%%% ¡settings!
'StringUnit'

%%% ¡prop!
SU2 (data, item) is the second string unit.
%%%% ¡settings!
'StringUnit'

%%% ¡prop!
S_COMBINED (result, string) is the combined strings.
%%%% ¡calculate!
value = [sc.get('SU1').get('S') ' ' sc.get('SU2').get('S')];

%% ¡tests!

%%% ¡test!
%%%% ¡name!
test
%%%% ¡code!
defined_string1 = 'test1';
su1 = StringUnit('S', defined_string1);

defined_string2 = 'test2';
su2 = StringUnit('S', defined_string2);

sc = StringCombine('SU1', su1, 'SU2', su2);

assert(isequal(sc.get('S_COMBINED'), [defined_string1 ' ' defined_string2]), ...
    [BRAPH2.STR ':StringCombine:' BRAPH2.FAIL_TEST], ...
    'StringCombine does not combine the defined strings properly.' ...
    )