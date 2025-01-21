%% ¡header!
ETA_ST < ETA_EM (et, test A prop string) tests prop string.

%%% ¡description!
ETA_ST tests the prop string.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop string.
%%%% ¡default!
'ETA_ST'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop string.
%%%% ¡default!
'ETA_ST tests the prop string.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop string.
%%%% ¡settings!
'ETA_ST'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop string.
%%%% ¡default!
'ETA_ST ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop string.
%%%% ¡default!
'ETA_ST label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop string.
%%%% ¡default!
'ETA_ST notes'

%% ¡props!

%%% ¡prop!
ST_C (constant, string) is a prop constant string.

%%% ¡prop!
ST_M (metadata, string) is a prop metadata string.

%%% ¡prop!
ST_P (parameter, string) is a prop parameter string.

%%% ¡prop!
ST_D (data, string) is a prop data string.

%%% ¡prop!
ST_R (result, string) is a prop result string.

%%% ¡prop!
ST_Q (query, string) is a prop query string.

%%% ¡prop!
ST_E (evanescent, string) is a prop evanescent string.

%%% ¡prop!
ST_F (figure, string) is a prop figure string.

%%% ¡prop!
ST_G (gui, string) is a prop gui string.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Update Deafults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_ST();
assert(isequal(et.get('NAME'), 'ETA_ST'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_ST tests the prop string.'))
assert(isequal(et.get('ID'), 'ETA_ST ID'))
assert(isequal(et.get('LABEL'), 'ETA_ST label'))
assert(isequal(et.get('NOTES'), 'ETA_ST notes'))