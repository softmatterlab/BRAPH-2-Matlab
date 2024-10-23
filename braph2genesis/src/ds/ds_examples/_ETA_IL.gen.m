%% ¡header!
ETA_IL < ETA_IT (et, test A prop itemlist) tests prop itemlist.

%%% ¡description!
ETA_IL tests the prop itemlist.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the test A prop itemlist.
%%%% ¡default!
'ETA_IL'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the test A prop itemlist.
%%%% ¡default!
'ETA_IL tests the prop itemlist.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the test A prop itemlist.
%%%% ¡settings!
'ETA_IL'

%%% ¡prop!
ID (data, string) is a few-letter code for the test A prop itemlist.
%%%% ¡default!
'ETA_IL ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the test A prop itemlist.
%%%% ¡default!
'ETA_IL label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the test A prop itemlist.
%%%% ¡default!
'ETA_IL notes'

%% ¡props!

%%% ¡prop!
IL_C (constant, itemlist) is a prop constant itemlist.

%%% ¡prop!
IL_M (metadata, itemlist) is a prop metadata itemlist.

%%% ¡prop!
IL_P (parameter, itemlist) is a prop parameter itemlist.

%%% ¡prop!
IL_D (data, itemlist) is a prop data itemlist.

%%% ¡prop!
IL_R (result, itemlist) is a prop result itemlist.

%%% ¡prop!
IL_Q (query, itemlist) is a prop query itemlist.

%%% ¡prop!
IL_E (evanescent, itemlist) is a prop evanescent itemlist.

%%% ¡prop!
IL_F (figure, itemlist) is a prop figure itemlist.

%%% ¡prop!
IL_G (gui, itemlist) is a prop gui itemlist.

%% ¡tests!

%%% ¡excluded_props!
[ETA_IT.IT_P ETA_IT.IT_D]

%%% ¡test!
%%%% ¡name!
Update Defaults
%%%% ¡probability!
.01
%%%% ¡code!
et = ETA_IL();
assert(isequal(et.get('NAME'), 'ETA_IL'))
assert(isequal(et.get('DESCRIPTION'), 'ETA_IL tests the prop itemlist.'))
assert(isequal(et.get('ID'), 'ETA_IL ID'))
assert(isequal(et.get('LABEL'), 'ETA_IL label'))
assert(isequal(et.get('NOTES'), 'ETA_IL notes'))