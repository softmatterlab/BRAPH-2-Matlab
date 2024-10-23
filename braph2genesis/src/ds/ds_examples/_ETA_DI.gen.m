%% ¡header!
ETA_DI < ETA_IL (et, test A prop idict) tests prop idict.

%%% ¡description!
ETA_DI tests the prop idict.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop idict.
%%%% ¡default!
'ETA_DI'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop idict.
%%%% ¡default!
'ETA_DI tests the prop idict.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop idict.
%%%% ¡settings!
'ETA_DI'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop idict.
%%%% ¡default!
'ETA_DI ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop idict.
%%%% ¡default!
'ETA_DI label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop idict.
%%%% ¡default!
'ETA_DI notes'

%% ¡props!

%%% ¡prop!
DI_C (constant, idict) is a prop constant idict.

%%% ¡prop!
DI_M (metadata, idict) is a prop metadata idict.

%%% ¡prop!
DI_P (parameter, idict) is a prop parameter idict.

%%% ¡prop!
DI_D (data, idict) is a prop data idict.

%%% ¡prop!
DI_R (result, idict) is a prop result idict.

%%% ¡prop!
DI_Q (query, idict) is a prop query idict.

%%% ¡prop!
DI_E (evanescent, idict) is a prop evanescent idict.

%%% ¡prop!
DI_F (figure, idict) is a prop figure idict.

%%% ¡prop!
DI_G (gui, idict) is a prop gui idict.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D ETA_DI.DI_P ETA_DI.DI_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_DI();
assert(isequal(et.get('NAME'), 'ETA_DI'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_DI tests the prop idict.'))
assert(isequal(et.get('ID'), 'ETA_DI ID'))
assert(isequal(et.get('LABEL'), 'ETA_DI label'))
assert(isequal(et.get('NOTES'), 'ETA_DI notes'))