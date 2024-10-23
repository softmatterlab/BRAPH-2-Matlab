%% ¡header!
ETA_LL < ETA_NS (et, test A prop cell) tests prop cell.

%%% ¡description!
ETA_LL tests the prop cell.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop cell.
%%%% ¡default!
'ETA_LL'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop cell.
%%%% ¡default!
'ETA_LL tests the prop cell.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop cell.
%%%% ¡settings!
'ETA_LL'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop cell.
%%%% ¡default!
'ETA_LL ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop cell.
%%%% ¡default!
'ETA_LL label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop cell.
%%%% ¡default!
'ETA_LL notes'

%% ¡props!

%%% ¡prop!
LL_C (constant, cell) is a prop constant cell.

%%% ¡prop!
LL_M (metadata, cell) is a prop metadata cell.

%%% ¡prop!
LL_P (parameter, cell) is a prop parameter cell.

%%% ¡prop!
LL_D (data, cell) is a prop data cell.

%%% ¡prop!
LL_R (result, cell) is a prop result cell.

%%% ¡prop!
LL_Q (query, cell) is a prop query cell.

%%% ¡prop!
LL_E (evanescent, cell) is a prop evanescent cell.

%%% ¡prop!
LL_F (figure, cell) is a prop figure cell.

%%% ¡prop!
LL_G (gui, cell) is a prop gui cell.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D ETA_DI.DI_P ETA_DI.DI_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_LL();
assert(isequal(et.get('NAME'), 'ETA_LL'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_LL tests the prop cell.'))
assert(isequal(et.get('ID'), 'ETA_LL ID'))
assert(isequal(et.get('LABEL'), 'ETA_LL label'))
assert(isequal(et.get('NOTES'), 'ETA_LL notes'))