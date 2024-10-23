%% ¡header!
ETA_NN < ETA_DI (et, test A prop scalar) tests prop scalar.

%%% ¡description!
ETA_NN tests the prop scalar.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop scalar.
%%%% ¡default!
'ETA_NN'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop scalar.
%%%% ¡default!
'ETA_NN tests the prop scalar.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop scalar.
%%%% ¡settings!
'ETA_NN'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop scalar.
%%%% ¡default!
'ETA_NN ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop scalar.
%%%% ¡default!
'ETA_NN label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop scalar.
%%%% ¡default!
'ETA_NN notes'

%% ¡props!

%%% ¡prop!
NN_C (constant, scalar) is a prop constant scalar.

%%% ¡prop!
NN_M (metadata, scalar) is a prop metadata scalar.

%%% ¡prop!
NN_P (parameter, scalar) is a prop parameter scalar.

%%% ¡prop!
NN_D (data, scalar) is a prop data scalar.

%%% ¡prop!
NN_R (result, scalar) is a prop result scalar.

%%% ¡prop!
NN_Q (query, scalar) is a prop query scalar.

%%% ¡prop!
NN_E (evanescent, scalar) is a prop evanescent scalar.

%%% ¡prop!
NN_F (figure, scalar) is a prop figure scalar.

%%% ¡prop!
NN_G (gui, scalar) is a prop gui scalar.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D ETA_DI.DI_P ETA_DI.DI_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_NN();
assert(isequal(et.get('NAME'), 'ETA_NN'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_NN tests the prop scalar.'))
assert(isequal(et.get('ID'), 'ETA_NN ID'))
assert(isequal(et.get('LABEL'), 'ETA_NN label'))
assert(isequal(et.get('NOTES'), 'ETA_NN notes'))