%% ¡header!
ETA_AL < ETA_CO (et, test A prop alpha) tests prop alpha.

%%% ¡description!
ETA_AL tests the prop alpha.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop alpha.
%%%% ¡default!
'ETA_AL'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop alpha.
%%%% ¡default!
'ETA_AL tests the prop alpha.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop alpha.
%%%% ¡settings!
'ETA_AL'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop alpha.
%%%% ¡default!
'ETA_AL ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop alpha.
%%%% ¡default!
'ETA_AL label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop alpha.
%%%% ¡default!
'ETA_AL notes'

%% ¡props!

%%% ¡prop!
AL_C (constant, alpha) is a prop constant alpha.

%%% ¡prop!
AL_M (metadata, alpha) is a prop metadata alpha.

%%% ¡prop!
AL_P (parameter, alpha) is a prop parameter alpha.

%%% ¡prop!
AL_D (data, alpha) is a prop data alpha.

%%% ¡prop!
AL_R (result, alpha) is a prop result alpha.

%%% ¡prop!
AL_Q (query, alpha) is a prop query alpha.

%%% ¡prop!
AL_E (evanescent, alpha) is a prop evanescent alpha.

%%% ¡prop!
AL_F (figure, alpha) is a prop figure alpha.

%%% ¡prop!
AL_G (gui, alpha) is a prop gui alpha.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D ETA_DI.DI_P ETA_DI.DI_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_AL();
assert(isequal(et.get('NAME'), 'ETA_AL'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_AL tests the prop alpha.'))
assert(isequal(et.get('ID'), 'ETA_AL ID'))
assert(isequal(et.get('LABEL'), 'ETA_AL label'))
assert(isequal(et.get('NOTES'), 'ETA_AL notes'))