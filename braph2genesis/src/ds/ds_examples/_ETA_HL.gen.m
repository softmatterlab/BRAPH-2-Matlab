%% ¡header!
ETA_HL < ETA_HA (et, test A prop handlelist) tests prop handlelist.

%%% ¡description!
ETA_HL tests the prop handlelist.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop handlelist.
%%%% ¡default!
'ETA_HL'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop handlelist.
%%%% ¡default!
'ETA_HL tests the prop handlelist.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop handlelist.
%%%% ¡settings!
'ETA_HL'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop handlelist.
%%%% ¡default!
'ETA_HL ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop handlelist.
%%%% ¡default!
'ETA_HL label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop handlelist.
%%%% ¡default!
'ETA_HL notes'

%% ¡props!

%%% ¡prop!
HL_C (constant, handle) is a prop constant handlelist.

%%% ¡prop!
HL_M (metadata, handle) is a prop metadata handlelist.

%%% ¡prop!
HL_P (parameter, handle) is a prop parameter handlelist.

%%% ¡prop!
HL_D (data, handle) is a prop data handlelist.

%%% ¡prop!
HL_R (result, handle) is a prop result handlelist.

%%% ¡prop!
HL_Q (query, handle) is a prop query handlelist.

%%% ¡prop!
HL_E (evanescent, handle) is a prop evanescent handlelist.

%%% ¡prop!
HL_F (figure, handle) is a prop figure handlelist.

%%% ¡prop!
HL_G (gui, handle) is a prop gui handlelist.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D ETA_DI.DI_P ETA_DI.DI_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_HL();
assert(isequal(et.get('NAME'), 'ETA_HL'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_HL tests the prop handlelist.'))
assert(isequal(et.get('ID'), 'ETA_HL ID'))
assert(isequal(et.get('LABEL'), 'ETA_HL label'))
assert(isequal(et.get('NOTES'), 'ETA_HL notes'))