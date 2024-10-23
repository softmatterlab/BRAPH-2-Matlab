%% ¡header!
ETA_OP < ETA_LO (et, test A prop option) tests prop option.

%%% ¡description!
ETA_OP tests the prop option.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop option.
%%%% ¡default!
'ETA_OP'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop option.
%%%% ¡default!
'ETA_OP tests the prop option.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop option.
%%%% ¡settings!
'ETA_OP'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop option.
%%%% ¡default!
'ETA_OP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop option.
%%%% ¡default!
'ETA_OP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop option.
%%%% ¡default!
'ETA_OP notes'

%% ¡props!

%%% ¡prop!
OP_C (constant, option) is a prop constant option.

%%% ¡prop!
OP_M (metadata, option) is a prop metadata option.

%%% ¡prop!
OP_P (parameter, option) is a prop parameter option.

%%% ¡prop!
OP_D (data, option) is a prop data option.

%%% ¡prop!
OP_R (result, option) is a prop result option.

%%% ¡prop!
OP_Q (query, option) is a prop query option.

%%% ¡prop!
OP_E (evanescent, option) is a prop evanescent option.

%%% ¡prop!
OP_F (figure, option) is a prop figure option.

%%% ¡prop!
OP_G (gui, option) is a prop gui option.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_OP();
assert(isequal(et.get('NAME'), 'ETA_OP'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_OP tests the prop option.'))
assert(isequal(et.get('ID'), 'ETA_OP ID'))
assert(isequal(et.get('LABEL'), 'ETA_OP label'))
assert(isequal(et.get('NOTES'), 'ETA_OP notes'))