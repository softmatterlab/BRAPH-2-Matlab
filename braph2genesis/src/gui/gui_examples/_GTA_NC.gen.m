%% ¡header!
GTA_NC < ConcreteElement (gt, test A PanelPropCVector) tests PanelPropCVector.

%%% ¡description!
GTA_NC tests PanelPropCVector.

%%% ¡seealso!
PanelPropCVector

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
NC_C (constant, cvector) is a prop constant cvector.
%%%% ¡default!
[1 2 3 4 5]'

%%% ¡prop!
NC_M (metadata, cvector) is a prop metadata cvector.
%%%% ¡default!
[1 2 3 4 5]'

%%% ¡prop!
NC_P (parameter, cvector) is a prop parameter cvector.
%%%% ¡default!
[1 2 3 4 5]'

%%% ¡prop!
NC_D (data, cvector) is a prop data cvector.
%%%% ¡default!
[1 2 3 4 5]'

%%% ¡prop!
NC_R (result, cvector) is a prop result cvector.
%%%% ¡calculate!
value = rand(10, 1);

%%% ¡prop!
NC_Q (query, cvector) is a prop query cvector.
%%%% ¡calculate!
value = rand(10, 1);

%%% ¡prop!
NC_E (evanescent, cvector) is a prop evanescent cvector.
%%%% ¡calculate!
value = rand(10, 1);

%%% ¡prop!
NC_F (figure, cvector) is a prop figure cvector.
%%%% ¡default!
[1 2 3 4 5]'

%%% ¡prop!
NC_G (gui, cvector) is a prop gui cvector.
%%%% ¡default!
[1 2 3 4 5]'

%% ¡tests!

%%% ¡test!
%%%% ¡name!
PanelPropMatrix
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_NC();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_NC.NC_C, 'PARENT', gui, 'HEIGHT', 200, 'ROWNAME', {'numbered'}, 'COLUMNNAME', {'numbered'});
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_NC.NC_M, 'PARENT', gui, 'HEIGHT', 200, 'ROWNAME', {}, 'COLUMNNAME', {});
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_NC.NC_P, 'PARENT', gui, 'HEIGHT', 200, 'ROWNAME', {'1' '2' '3'}, 'COLUMNNAME', {'a' 'b' 'c'});
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_NC.NC_D, 'PARENT', gui, 'HEIGHT', 200);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_NC.NC_R, 'PARENT', gui, 'HEIGHT', 200);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_NC.NC_Q, 'PARENT', gui, 'HEIGHT', 200);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_NC.NC_E, 'PARENT', gui, 'HEIGHT', 200);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_NC.NC_F, 'PARENT', gui, 'HEIGHT', 200);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_NC.NC_G, 'PARENT', gui, 'HEIGHT', 200);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(isequal(pr_C.get('TABLE').get('Data'), gt.get('NC_C')))

assert(isequal(pr_M.get('TABLE').get('Data'), gt.get('NC_M')))
gt.set('NC_M', [1 2 3]')
assert(isequal(pr_M.get('TABLE').get('Data'), gt.get('NC_M')))

assert(isequal(pr_P.get('TABLE').get('Data'), gt.get('NC_P')))
gt.set('NC_P', [1 2 3]')
assert(isequal(pr_P.get('TABLE').get('Data'), gt.get('NC_P')))

assert(isequal(pr_D.get('TABLE').get('Data'), gt.get('NC_D')))
gt.set('NC_D', [1 2 3]')
assert(isequal(pr_D.get('TABLE').get('Data'), gt.get('NC_D')))

assert(isequal(pr_F.get('TABLE').get('Data'), gt.get('NC_F')))
gt.set('NC_F', [1 2 3]')
assert(isequal(pr_F.get('TABLE').get('Data'), gt.get('NC_F')))

assert(isequal(pr_G.get('TABLE').get('Data'), gt.get('NC_G')))
gt.set('NC_G', [1 2 3]')
assert(isequal(pr_G.get('TABLE').get('Data'), gt.get('NC_G')))

assert(isequal(pr_R.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NC_R')))
gt.get('NC_R')
assert(isequal(pr_R.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NC_R')))
gt.memorize('NC_R')
assert(isequal(pr_R.get('TABLE').get('Data'), gt.get('NC_R')))

assert(isequal(pr_Q.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NC_Q')))
gt.get('NC_Q')
assert(isequal(pr_Q.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NC_Q')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('NC_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_Q.get('TABLE').get('Data'), gt.get('NC_Q')))

assert(isequal(pr_E.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NC_E')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('NC_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_E.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NC_E')))
gt.memorize('NC_E')
assert(isequal(pr_E.get('TABLE').get('Data'), gt.get('NC_E')))

pr_F.get('CLOSE') % closes all
