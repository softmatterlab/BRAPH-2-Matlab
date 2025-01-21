%% ¡header!
ETA_NR < ETA_NN (et, test A prop rvector) tests prop rvector.

%%% ¡description!
ETA_NR tests the prop rvector.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop rvector.
%%%% ¡default!
'ETA_NR'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop rvector.
%%%% ¡default!
'ETA_NR tests the prop rvector.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop rvector.
%%%% ¡settings!
'ETA_NR'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop rvector.
%%%% ¡default!
'ETA_NR ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop rvector.
%%%% ¡default!
'ETA_NR label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop rvector.
%%%% ¡default!
'ETA_NR notes'

%% ¡props!

%%% ¡prop!
NR_C (constant, rvector) is a prop constant rvector.

%%% ¡prop!
NR_M (metadata, rvector) is a prop metadata rvector.

%%% ¡prop!
NR_P (parameter, rvector) is a prop parameter rvector.

%%% ¡prop!
NR_D (data, rvector) is a prop data rvector.

%%% ¡prop!
NR_R (result, rvector) is a prop result rvector.

%%% ¡prop!
NR_Q (query, rvector) is a prop query rvector.

%%% ¡prop!
NR_E (evanescent, rvector) is a prop evanescent rvector.

%%% ¡prop!
NR_F (figure, rvector) is a prop figure rvector.

%%% ¡prop!
NR_G (gui, rvector) is a prop gui rvector.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D ETA_DI.DI_P ETA_DI.DI_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_NR();
assert(isequal(et.get('NAME'), 'ETA_NR'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_NR tests the prop rvector.'))
assert(isequal(et.get('ID'), 'ETA_NR ID'))
assert(isequal(et.get('LABEL'), 'ETA_NR label'))
assert(isequal(et.get('NOTES'), 'ETA_NR notes'))