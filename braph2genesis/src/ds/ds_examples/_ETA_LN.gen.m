%% ¡header!
ETA_LN < ETA_MR (et, test A prop line) tests prop line.

%%% ¡description!
ETA_LN tests the prop line.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop line.
%%%% ¡default!
'ETA_LN'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop line.
%%%% ¡default!
'ETA_LN tests the prop line.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop line.
%%%% ¡settings!
'ETA_LN'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop line.
%%%% ¡default!
'ETA_LN ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop line.
%%%% ¡default!
'ETA_LN label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop line.
%%%% ¡default!
'ETA_LN notes'

%% ¡props!

%%% ¡prop!
LN_C (constant, line) is a prop constant line.

%%% ¡prop!
LN_M (metadata, line) is a prop metadata line.

%%% ¡prop!
LN_P (parameter, line) is a prop parameter line.

%%% ¡prop!
LN_D (data, line) is a prop data line.

%%% ¡prop!
LN_R (result, line) is a prop result line.

%%% ¡prop!
LN_Q (query, line) is a prop query line.

%%% ¡prop!
LN_E (evanescent, line) is a prop evanescent line.

%%% ¡prop!
LN_F (figure, line) is a prop figure line.

%%% ¡prop!
LN_G (gui, line) is a prop gui line.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D ETA_DI.DI_P ETA_DI.DI_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_LN();
assert(isequal(et.get('NAME'), 'ETA_LN'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_LN tests the prop line.'))
assert(isequal(et.get('ID'), 'ETA_LN ID'))
assert(isequal(et.get('LABEL'), 'ETA_LN label'))
assert(isequal(et.get('NOTES'), 'ETA_LN notes'))