%% ¡header!
ETA_MR < ETA_SZ (et, test A prop marker) tests prop marker.

%%% ¡description!
ETA_MR tests the prop marker.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop marker.
%%%% ¡default!
'ETA_MR'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop marker.
%%%% ¡default!
'ETA_MR tests the prop marker.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop marker.
%%%% ¡settings!
'ETA_MR'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop marker.
%%%% ¡default!
'ETA_MR ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop marker.
%%%% ¡default!
'ETA_MR label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop marker.
%%%% ¡default!
'ETA_MR notes'

%% ¡props!

%%% ¡prop!
MR_C (constant, marker) is a prop constant marker.

%%% ¡prop!
MR_M (metadata, marker) is a prop metadata marker.

%%% ¡prop!
MR_P (parameter, marker) is a prop parameter marker.

%%% ¡prop!
MR_D (data, marker) is a prop data marker.

%%% ¡prop!
MR_R (result, marker) is a prop result marker.

%%% ¡prop!
MR_Q (query, marker) is a prop query marker.

%%% ¡prop!
MR_E (evanescent, marker) is a prop evanescent marker.

%%% ¡prop!
MR_F (figure, marker) is a prop figure marker.

%%% ¡prop!
MR_G (gui, marker) is a prop gui marker.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D ETA_DI.DI_P ETA_DI.DI_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_MR();
assert(isequal(et.get('NAME'), 'ETA_MR'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_MR tests the prop marker.'))
assert(isequal(et.get('ID'), 'ETA_MR ID'))
assert(isequal(et.get('LABEL'), 'ETA_MR label'))
assert(isequal(et.get('NOTES'), 'ETA_MR notes'))