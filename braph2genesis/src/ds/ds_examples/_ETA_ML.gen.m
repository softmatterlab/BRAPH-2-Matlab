%% ¡header!
ETA_ML < ETA_LL (et, test A prop net) tests prop net.

%%% ¡description!
ETA_ML tests the prop net.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop net.
%%%% ¡default!
'ETA_ML'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop net.
%%%% ¡default!
'ETA_ML tests the prop net.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop net.
%%%% ¡settings!
'ETA_ML'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop net.
%%%% ¡default!
'ETA_ML ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop net.
%%%% ¡default!
'ETA_ML label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop net.
%%%% ¡default!
'ETA_ML notes'

%% ¡props!

%%% ¡prop!
ML_C (constant, net) is a prop constant net.

%%% ¡prop!
ML_M (metadata, net) is a prop metadata net.

%%% ¡prop!
ML_P (parameter, net) is a prop parameter net.

%%% ¡prop!
ML_D (data, net) is a prop data net.

%%% ¡prop!
ML_R (result, net) is a prop result net.

%%% ¡prop!
ML_Q (query, net) is a prop query net.

%%% ¡prop!
ML_E (evanescent, net) is a prop evanescent net.

%%% ¡prop!
ML_F (figure, net) is a prop figure net.

%%% ¡prop!
ML_G (gui, net) is a prop gui net.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D ETA_DI.DI_P ETA_DI.DI_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_ML();
assert(isequal(et.get('NAME'), 'ETA_ML'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_ML tests the prop net.'))
assert(isequal(et.get('ID'), 'ETA_ML ID'))
assert(isequal(et.get('LABEL'), 'ETA_ML label'))
assert(isequal(et.get('NOTES'), 'ETA_ML notes'))