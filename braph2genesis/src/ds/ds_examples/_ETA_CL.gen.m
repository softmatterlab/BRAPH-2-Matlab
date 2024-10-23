%% ¡header!
ETA_CL < ETA_CA (et, test A prop classlist) tests prop classlist.

%%% ¡description!
ETA_CL tests the prop classlist.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop classlist.
%%%% ¡default!
'ETA_CL'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop classlist.
%%%% ¡default!
'ETA_CL tests the prop classlist.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop classlist.
%%%% ¡settings!
'ETA_CL'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop classlist.
%%%% ¡default!
'ETA_CL ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop classlist.
%%%% ¡default!
'ETA_CL label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop classlist.
%%%% ¡default!
'ETA_CL notes'

%% ¡props!

%%% ¡prop!
CL_C (constant, classlist) is a prop constant classlist.

%%% ¡prop!
CL_M (metadata, classlist) is a prop metadata classlist.

%%% ¡prop!
CL_P (parameter, classlist) is a prop parameter classlist.

%%% ¡prop!
CL_D (data, classlist) is a prop data classlist.

%%% ¡prop!
CL_R (result, classlist) is a prop result classlist.

%%% ¡prop!
CL_Q (query, classlist) is a prop query classlist.

%%% ¡prop!
CL_E (evanescent, classlist) is a prop evanescent classlist.

%%% ¡prop!
CL_F (figure, classlist) is a prop figure classlist.

%%% ¡prop!
CL_G (gui, classlist) is a prop gui classlist.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_CL();
assert(isequal(et.get('NAME'), 'ETA_CL'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_CL tests the prop classlist.'))
assert(isequal(et.get('ID'), 'ETA_CL ID'))
assert(isequal(et.get('LABEL'), 'ETA_CL label'))
assert(isequal(et.get('NOTES'), 'ETA_CL notes'))