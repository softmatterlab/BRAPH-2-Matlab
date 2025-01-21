%% ¡header!
ETA_NS < ETA_NM (et, test A prop smatrix) tests prop smatrix.

%%% ¡description!
ETA_NS tests the prop smatrix.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop smatrix.
%%%% ¡default!
'ETA_NS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop smatrix.
%%%% ¡default!
'ETA_NS tests the prop smatrix.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop smatrix.
%%%% ¡settings!
'ETA_NS'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop smatrix.
%%%% ¡default!
'ETA_NS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop smatrix.
%%%% ¡default!
'ETA_NS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop smatrix.
%%%% ¡default!
'ETA_NS notes'

%% ¡props!

%%% ¡prop!
NS_C (constant, smatrix) is a prop constant smatrix.

%%% ¡prop!
NS_M (metadata, smatrix) is a prop metadata smatrix.

%%% ¡prop!
NS_P (parameter, smatrix) is a prop parameter smatrix.

%%% ¡prop!
NS_D (data, smatrix) is a prop data smatrix.

%%% ¡prop!
NS_R (result, smatrix) is a prop result smatrix.

%%% ¡prop!
NS_Q (query, smatrix) is a prop query smatrix.

%%% ¡prop!
NS_E (evanescent, smatrix) is a prop evanescent smatrix.

%%% ¡prop!
NS_F (figure, smatrix) is a prop figure smatrix.

%%% ¡prop!
NS_G (gui, smatrix) is a prop gui smatrix.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D ETA_DI.DI_P ETA_DI.DI_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_NS();
assert(isequal(et.get('NAME'), 'ETA_NS'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_NS tests the prop smatrix.'))
assert(isequal(et.get('ID'), 'ETA_NS ID'))
assert(isequal(et.get('LABEL'), 'ETA_NS label'))
assert(isequal(et.get('NOTES'), 'ETA_NS notes'))