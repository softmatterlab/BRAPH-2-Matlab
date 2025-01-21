%% ¡header!
ETA_NM < ETA_NC (et, test A prop matrix) tests prop matrix.

%%% ¡description!
ETA_NM tests the prop matrix.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop matrix.
%%%% ¡default!
'ETA_NM'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop matrix.
%%%% ¡default!
'ETA_NM tests the prop matrix.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop matrix.
%%%% ¡settings!
'ETA_NM'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop matrix.
%%%% ¡default!
'ETA_NM ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop matrix.
%%%% ¡default!
'ETA_NM label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop matrix.
%%%% ¡default!
'ETA_NM notes'

%% ¡props!

%%% ¡prop!
NM_C (constant, matrix) is a prop constant matrix.

%%% ¡prop!
NM_M (metadata, matrix) is a prop metadata matrix.

%%% ¡prop!
NM_P (parameter, matrix) is a prop parameter matrix.

%%% ¡prop!
NM_D (data, matrix) is a prop data matrix.

%%% ¡prop!
NM_R (result, matrix) is a prop result matrix.

%%% ¡prop!
NM_Q (query, matrix) is a prop query matrix.

%%% ¡prop!
NM_E (evanescent, matrix) is a prop evanescent matrix.

%%% ¡prop!
NM_F (figure, matrix) is a prop figure matrix.

%%% ¡prop!
NM_G (gui, matrix) is a prop gui matrix.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D ETA_DI.DI_P ETA_DI.DI_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_NM();
assert(isequal(et.get('NAME'), 'ETA_NM'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_NM tests the prop matrix.'))
assert(isequal(et.get('ID'), 'ETA_NM ID'))
assert(isequal(et.get('LABEL'), 'ETA_NM label'))
assert(isequal(et.get('NOTES'), 'ETA_NM notes'))