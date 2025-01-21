%% ¡header!
ETA_CA < ETA_OP (et, test A prop class) tests prop class.

%%% ¡description!
ETA_CA tests the prop class.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop class.
%%%% ¡default!
'ETA_CA'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop class.
%%%% ¡default!
'ETA_CA tests the prop class.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop class.
%%%% ¡settings!
'ETA_CA'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop class.
%%%% ¡default!
'ETA_CA ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop class.
%%%% ¡default!
'ETA_CA label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop class.
%%%% ¡default!
'ETA_CA notes'

%% ¡props!

%%% ¡prop!
CA_C (constant, class) is a prop constant class.

%%% ¡prop!
CA_M (metadata, class) is a prop metadata class.

%%% ¡prop!
CA_P (parameter, class) is a prop parameter class.

%%% ¡prop!
CA_D (data, class) is a prop data class.

%%% ¡prop!
CA_R (result, class) is a prop result class.

%%% ¡prop!
CA_Q (query, class) is a prop query class.

%%% ¡prop!
CA_E (evanescent, class) is a prop evanescent class.

%%% ¡prop!
CA_F (figure, class) is a prop figure class.

%%% ¡prop!
CA_G (gui, class) is a prop gui class.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_CA();
assert(isequal(et.get('NAME'), 'ETA_CA'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_CA tests the prop class.'))
assert(isequal(et.get('ID'), 'ETA_CA ID'))
assert(isequal(et.get('LABEL'), 'ETA_CA label'))
assert(isequal(et.get('NOTES'), 'ETA_CA notes'))