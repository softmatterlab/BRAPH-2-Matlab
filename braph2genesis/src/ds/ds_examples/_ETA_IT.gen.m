%% ¡header!
ETA_IT < ETA_CL (et, test A prop item) tests prop item.

%%% ¡description!
ETA_IT tests the prop item.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop item.
%%%% ¡default!
'ETA_IT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop item.
%%%% ¡default!
'ETA_IT tests the prop item.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop item.
%%%% ¡settings!
'ETA_IT'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop item.
%%%% ¡default!
'ETA_IT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop item.
%%%% ¡default!
'ETA_IT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop item.
%%%% ¡default!
'ETA_IT notes'

%% ¡props!

%%% ¡prop!
IT_C (constant, item) is a prop constant item.

%%% ¡prop!
IT_M (metadata, item) is a prop metadata item.

%%% ¡prop!
IT_P (parameter, item) is a prop parameter item.

%%% ¡prop!
IT_D (data, item) is a prop data item.

%%% ¡prop!
IT_R (result, item) is a prop result item.

%%% ¡prop!
IT_Q (query, item) is a prop query item.

%%% ¡prop!
IT_E (evanescent, item) is a prop evanescent item.

%%% ¡prop!
IT_F (figure, item) is a prop figure item.

%%% ¡prop!
IT_G (gui, item) is a prop gui item.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_IT();
assert(isequal(et.get('NAME'), 'ETA_IT'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_IT tests the prop item.'))
assert(isequal(et.get('ID'), 'ETA_IT ID'))
assert(isequal(et.get('LABEL'), 'ETA_IT label'))
assert(isequal(et.get('NOTES'), 'ETA_IT notes'))