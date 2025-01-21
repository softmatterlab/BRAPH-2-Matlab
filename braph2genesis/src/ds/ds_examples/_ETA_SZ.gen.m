%% ¡header!
ETA_SZ < ETA_AL (et, test A prop size) tests prop size.

%%% ¡description!
ETA_SZ tests the prop size.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop size.
%%%% ¡default!
'ETA_SZ'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop size.
%%%% ¡default!
'ETA_SZ tests the prop size.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop size.
%%%% ¡settings!
'ETA_SZ'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop size.
%%%% ¡default!
'ETA_SZ ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop size.
%%%% ¡default!
'ETA_SZ label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop size.
%%%% ¡default!
'ETA_SZ notes'

%% ¡props!

%%% ¡prop!
SZ_C (constant, size) is a prop constant size.

%%% ¡prop!
SZ_M (metadata, size) is a prop metadata size.

%%% ¡prop!
SZ_P (parameter, size) is a prop parameter size.

%%% ¡prop!
SZ_D (data, size) is a prop data size.

%%% ¡prop!
SZ_R (result, size) is a prop result size.

%%% ¡prop!
SZ_Q (query, size) is a prop query size.

%%% ¡prop!
SZ_E (evanescent, size) is a prop evanescent size.

%%% ¡prop!
SZ_F (figure, size) is a prop figure size.

%%% ¡prop!
SZ_G (gui, size) is a prop gui size.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D ETA_DI.DI_P ETA_DI.DI_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_SZ();
assert(isequal(et.get('NAME'), 'ETA_SZ'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_SZ tests the prop size.'))
assert(isequal(et.get('ID'), 'ETA_SZ ID'))
assert(isequal(et.get('LABEL'), 'ETA_SZ label'))
assert(isequal(et.get('NOTES'), 'ETA_SZ notes'))