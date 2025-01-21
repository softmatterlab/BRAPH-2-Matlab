%% ¡header!
ETA_NC < ETA_NR (et, test A prop cvector) tests prop cvector.

%%% ¡description!
ETA_NC tests the prop cvector.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop cvector.
%%%% ¡default!
'ETA_NC'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop cvector.
%%%% ¡default!
'ETA_NC tests the prop cvector.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop cvector.
%%%% ¡settings!
'ETA_NC'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop cvector.
%%%% ¡default!
'ETA_NC ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop cvector.
%%%% ¡default!
'ETA_NC label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop cvector.
%%%% ¡default!
'ETA_NC notes'

%% ¡props!

%%% ¡prop!
NC_C (constant, cvector) is a prop constant cvector.

%%% ¡prop!
NC_M (metadata, cvector) is a prop metadata cvector.

%%% ¡prop!
NC_P (parameter, cvector) is a prop parameter cvector.

%%% ¡prop!
NC_D (data, cvector) is a prop data cvector.

%%% ¡prop!
NC_R (result, cvector) is a prop result cvector.

%%% ¡prop!
NC_Q (query, cvector) is a prop query cvector.

%%% ¡prop!
NC_E (evanescent, cvector) is a prop evanescent cvector.

%%% ¡prop!
NC_F (figure, cvector) is a prop figure cvector.

%%% ¡prop!
NC_G (gui, cvector) is a prop gui cvector.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D ETA_DI.DI_P ETA_DI.DI_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_NC();
assert(isequal(et.get('NAME'), 'ETA_NC'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_NC tests the prop cvector.'))
assert(isequal(et.get('ID'), 'ETA_NC ID'))
assert(isequal(et.get('LABEL'), 'ETA_NC label'))
assert(isequal(et.get('NOTES'), 'ETA_NC notes'))