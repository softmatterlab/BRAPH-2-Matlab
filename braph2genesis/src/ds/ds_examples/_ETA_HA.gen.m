%% ¡header!
ETA_HA < ETA_ML (et, test A prop handle) tests prop handle.

%%% ¡description!
ETA_HA tests the prop handle.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop handle.
%%%% ¡default!
'ETA_HA'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop handle.
%%%% ¡default!
'ETA_HA tests the prop handle.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop handle.
%%%% ¡settings!
'ETA_HA'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop handle.
%%%% ¡default!
'ETA_HA ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop handle.
%%%% ¡default!
'ETA_HA label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop handle.
%%%% ¡default!
'ETA_HA notes'

%% ¡props!

%%% ¡prop!
HA_C (constant, handle) is a prop constant handle.

%%% ¡prop!
HA_M (metadata, handle) is a prop metadata handle.

%%% ¡prop!
HA_P (parameter, handle) is a prop parameter handle.

%%% ¡prop!
HA_D (data, handle) is a prop data handle.

%%% ¡prop!
HA_R (result, handle) is a prop result handle.

%%% ¡prop!
HA_Q (query, handle) is a prop query handle.

%%% ¡prop!
HA_E (evanescent, handle) is a prop evanescent handle.

%%% ¡prop!
HA_F (figure, handle) is a prop figure handle.

%%% ¡prop!
HA_G (gui, handle) is a prop gui handle.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D ETA_DI.DI_P ETA_DI.DI_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_HA();
assert(isequal(et.get('NAME'), 'ETA_HA'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_HA tests the prop handle.'))
assert(isequal(et.get('ID'), 'ETA_HA ID'))
assert(isequal(et.get('LABEL'), 'ETA_HA label'))
assert(isequal(et.get('NOTES'), 'ETA_HA notes'))