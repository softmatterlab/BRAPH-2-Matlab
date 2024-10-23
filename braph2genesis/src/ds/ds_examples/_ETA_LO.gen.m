%% ¡header!
ETA_LO < ETA_SL (et, test A prop logical) tests prop logical.

%%% ¡description!
ETA_LO tests the prop logical.
 
%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop logical.
%%%% ¡default!
'ETA_LO'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop logical.
%%%% ¡default!
'ETA_LO tests the prop logical.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop logical.
%%%% ¡settings!
'ETA_LO'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop logical.
%%%% ¡default!
'ETA_LO ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop logical.
%%%% ¡default!
'ETA_LO label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop logical.
%%%% ¡default!
'ETA_LO notes'

%% ¡props!

%%% ¡prop!
LO_C (constant, logical) is a prop constant logical.

%%% ¡prop!
LO_M (metadata, logical) is a prop metadata logical.

%%% ¡prop!
LO_P (parameter, logical) is a prop parameter logical.

%%% ¡prop!
LO_D (data, logical) is a prop data logical.

%%% ¡prop!
LO_R (result, logical) is a prop result logical.

%%% ¡prop!
LO_Q (query, logical) is a prop query logical.

%%% ¡prop!
LO_E (evanescent, logical) is a prop evanescent logical.

%%% ¡prop!
LO_F (figure, logical) is a prop figure logical.

%%% ¡prop!
LO_G (gui, logical) is a prop gui logical.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_LO();
assert(isequal(et.get('NAME'), 'ETA_LO'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_LO tests the prop logical.'))
assert(isequal(et.get('ID'), 'ETA_LO ID'))
assert(isequal(et.get('LABEL'), 'ETA_LO label'))
assert(isequal(et.get('NOTES'), 'ETA_LO notes'))