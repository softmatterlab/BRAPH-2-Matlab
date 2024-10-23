%% ¡header!
ETA_SL < ETA_ST (et, test A prop stringlist) tests prop stringlist.

%%% ¡description!
ETA_SL tests the prop stringlist.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop stringlist.
%%%% ¡default!
'ETA_SL'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop stringlist.
%%%% ¡default!
'ETA_SL tests the prop stringlist.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop stringlist.
%%%% ¡settings!
'ETA_SL'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop stringlist.
%%%% ¡default!
'ETA_SL ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop stringlist.
%%%% ¡default!
'ETA_SL label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop stringlist.
%%%% ¡default!
'ETA_SL notes'

%% ¡props!

%%% ¡prop!
SL_C (constant, stringlist) is a prop constant stringlist.

%%% ¡prop!
SL_M (metadata, stringlist) is a prop metadata stringlist.

%%% ¡prop!
SL_P (parameter, stringlist) is a prop parameter stringlist.

%%% ¡prop!
SL_D (data, stringlist) is a prop data stringlist.

%%% ¡prop!
SL_R (result, stringlist) is a prop result stringlist.

%%% ¡prop!
SL_Q (query, stringlist) is a prop query stringlist.

%%% ¡prop!
SL_E (evanescent, stringlist) is a prop evanescent stringlist.

%%% ¡prop!
SL_F (figure, stringlist) is a prop figure stringlist.

%%% ¡prop!
SL_G (gui, stringlist) is a prop gui stringlist.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_SL();
assert(isequal(et.get('NAME'), 'ETA_SL'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_SL tests the prop stringlist.'))
assert(isequal(et.get('ID'), 'ETA_SL ID'))
assert(isequal(et.get('LABEL'), 'ETA_SL label'))
assert(isequal(et.get('NOTES'), 'ETA_SL notes'))