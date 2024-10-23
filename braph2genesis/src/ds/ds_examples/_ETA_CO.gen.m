%% ¡header!
ETA_CO < ETA_HL (et, test A prop color) tests prop color.

%%% ¡description!
ETA_CO tests the prop color.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop color.
%%%% ¡default!
'ETA_CO'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop color.
%%%% ¡default!
'ETA_CO tests the prop color.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop color.
%%%% ¡settings!
'ETA_CO'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop color.
%%%% ¡default!
'ETA_CO ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop color.
%%%% ¡default!
'ETA_CO label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop color.
%%%% ¡default!
'ETA_CO notes'

%% ¡props!

%%% ¡prop!
CO_C (constant, color) is a prop constant color.

%%% ¡prop!
CO_M (metadata, color) is a prop metadata color.

%%% ¡prop!
CO_P (parameter, color) is a prop parameter color.

%%% ¡prop!
CO_D (data, color) is a prop data color.

%%% ¡prop!
CO_R (result, color) is a prop result color.

%%% ¡prop!
CO_Q (query, color) is a prop query color.

%%% ¡prop!
CO_E (evanescent, color) is a prop evanescent color.

%%% ¡prop!
CO_F (figure, color) is a prop figure color.

%%% ¡prop!
CO_G (gui, color) is a prop gui color.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D ETA_DI.DI_P ETA_DI.DI_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_CO();
assert(isequal(et.get('NAME'), 'ETA_CO'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_CO tests the prop color.'))
assert(isequal(et.get('ID'), 'ETA_CO ID'))
assert(isequal(et.get('LABEL'), 'ETA_CO label'))
assert(isequal(et.get('NOTES'), 'ETA_CO notes'))