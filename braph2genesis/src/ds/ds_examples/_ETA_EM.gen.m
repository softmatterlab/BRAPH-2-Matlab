%% ¡header!
ETA_EM < ConcreteElement (et, test A prop empty) tests prop empty.

%%% ¡description!
ETA_EM tests the prop empty.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop empty.
%%%% ¡default!
'ETA_EM'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop empty.
%%%% ¡default!
'ETA_EM tests the prop empty.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop empty.
%%%% ¡settings!
'ETA_EM'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop empty.
%%%% ¡default!
'ETA_EM ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop empty.
%%%% ¡default!
'ETA_EM label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop empty.
%%%% ¡default!
'ETA_EM notes'

%% ¡props!

%%% ¡prop!
EM_C (constant, empty) is a prop constant empty.

%%% ¡prop!
EM_M (metadata, empty) is a prop metadata empty.

%%% ¡prop!
EM_P (parameter, empty) is a prop parameter empty.

%%% ¡prop!
EM_D (data, empty) is a prop data empty.

%%% ¡prop!
EM_R (result, empty) is a prop result empty.

%%% ¡prop!
EM_Q (query, empty) is a prop query empty.

%%% ¡prop!
EM_E (evanescent, empty) is a prop evanescent empty.

%%% ¡prop!
EM_F (figure, empty) is a prop figure empty.

%%% ¡prop!
EM_G (gui, empty) is a prop gui empty.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_EM();
assert(isequal(et.get('NAME'), 'ETA_EM'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_EM tests the prop empty.'))
assert(isequal(et.get('ID'), 'ETA_EM ID'))
assert(isequal(et.get('LABEL'), 'ETA_EM label'))
assert(isequal(et.get('NOTES'), 'ETA_EM notes'))
