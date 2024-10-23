%% ¡header!
GTA_SZ < ConcreteElement (gt, test A PanelPropSize) tests PanelPropSize.

%%% ¡description!
GTA_SZ tests PanelPropSize.

%%% ¡seealso!
PanelPropSize

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
SZ_C (constant, size) is a prop constant size.

%%% ¡prop!
SZ_M (metadata, size) is a prop metadata size.

%%% ¡prop!
SZ_P (parameter, size) is a prop parameter size.

%%% ¡prop!
SZ_D (data, size) is a prop data size.

%%% ¡prop!
SZ_R (result, size) is a prop result size.

%%% ¡prop!
SZ_Q (query, size) is a prop query size.

%%% ¡prop!
SZ_E (evanescent, size) is a prop evanescent size.

%%% ¡prop!
SZ_F (figure, size) is a prop figure size.

%%% ¡prop!
SZ_G (gui, size) is a prop gui size.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_SZ();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_SZ.SZ_C, 'PARENT', gui);
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_SZ.SZ_M, 'PARENT', gui);
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_SZ.SZ_P, 'PARENT', gui);
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_SZ.SZ_D, 'PARENT', gui);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_SZ.SZ_R, 'PARENT', gui);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_SZ.SZ_Q, 'PARENT', gui);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_SZ.SZ_E, 'PARENT', gui);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_SZ.SZ_F, 'PARENT', gui);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_SZ.SZ_G, 'PARENT', gui);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(isequal(pr_C.get('EDITFIELD').get('Value'), gt.get('SZ_C')))
assert(isequal(pr_C.get('LN').get('LineWidth'), gt.get('SZ_C')))
assert(isequal(pr_C.get('LN').get('MarkerSize'), gt.get('SZ_C')))

assert(isequal(pr_M.get('EDITFIELD').get('Value'), gt.get('SZ_M')))
assert(isequal(pr_M.get('LN').get('LineWidth'), gt.get('SZ_M')))
assert(isequal(pr_M.get('LN').get('MarkerSize'), gt.get('SZ_M')))
gt.set('SZ_M', 2)
assert(isequal(pr_M.get('EDITFIELD').get('Value'), gt.get('SZ_M')))
assert(isequal(pr_M.get('LN').get('LineWidth'), gt.get('SZ_M')))
assert(isequal(pr_M.get('LN').get('MarkerSize'), gt.get('SZ_M')))

assert(isequal(pr_P.get('EDITFIELD').get('Value'), gt.get('SZ_P')))
assert(isequal(pr_P.get('LN').get('LineWidth'), gt.get('SZ_P')))
assert(isequal(pr_P.get('LN').get('MarkerSize'), gt.get('SZ_P')))
gt.set('SZ_P', 3)
assert(isequal(pr_P.get('EDITFIELD').get('Value'), gt.get('SZ_P')))
assert(isequal(pr_P.get('LN').get('LineWidth'), gt.get('SZ_P')))
assert(isequal(pr_P.get('LN').get('MarkerSize'), gt.get('SZ_P')))

assert(isequal(pr_D.get('EDITFIELD').get('Value'), gt.get('SZ_D')))
assert(isequal(pr_D.get('LN').get('LineWidth'), gt.get('SZ_D')))
assert(isequal(pr_D.get('LN').get('MarkerSize'), gt.get('SZ_D')))
gt.set('SZ_D', 4)
assert(isequal(pr_D.get('EDITFIELD').get('Value'), gt.get('SZ_D')))
assert(isequal(pr_D.get('LN').get('LineWidth'), gt.get('SZ_D')))
assert(isequal(pr_D.get('LN').get('MarkerSize'), gt.get('SZ_D')))

assert(isequal(pr_F.get('EDITFIELD').get('Value'), gt.get('SZ_F')))
assert(isequal(pr_F.get('LN').get('LineWidth'), gt.get('SZ_F')))
assert(isequal(pr_F.get('LN').get('MarkerSize'), gt.get('SZ_F')))
gt.set('SZ_F', 5)
assert(isequal(pr_F.get('EDITFIELD').get('Value'), gt.get('SZ_F')))
assert(isequal(pr_F.get('LN').get('LineWidth'), gt.get('SZ_F')))
assert(isequal(pr_F.get('LN').get('MarkerSize'), gt.get('SZ_F')))

assert(isequal(pr_G.get('EDITFIELD').get('Value'), gt.get('SZ_G')))
assert(isequal(pr_G.get('LN').get('LineWidth'), gt.get('SZ_G')))
assert(isequal(pr_G.get('LN').get('MarkerSize'), gt.get('SZ_G')))
gt.set('SZ_G', 6)
assert(isequal(pr_G.get('EDITFIELD').get('Value'), gt.get('SZ_G')))
assert(isequal(pr_G.get('LN').get('LineWidth'), gt.get('SZ_G')))
assert(isequal(pr_G.get('LN').get('MarkerSize'), gt.get('SZ_G')))

assert(isequal(pr_R.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('SZ_R')))
assert(isequal(pr_R.get('LN').get('LineWidth'), gt.getPropDefaultConditioned('SZ_R')))
assert(isequal(pr_R.get('LN').get('MarkerSize'), gt.getPropDefaultConditioned('SZ_R')))
gt.get('SZ_R')
assert(isequal(pr_R.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('SZ_R')))
assert(isequal(pr_R.get('LN').get('LineWidth'), gt.getPropDefaultConditioned('SZ_R')))
assert(isequal(pr_R.get('LN').get('MarkerSize'), gt.getPropDefaultConditioned('SZ_R')))
gt.memorize('SZ_R')
assert(isequal(pr_R.get('EDITFIELD').get('Value'), gt.get('SZ_R')))
assert(isequal(pr_R.get('LN').get('LineWidth'), gt.get('SZ_R')))
assert(isequal(pr_R.get('LN').get('MarkerSize'), gt.get('SZ_R')))

assert(isequal(pr_Q.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('SZ_Q')))
assert(isequal(pr_Q.get('LN').get('LineWidth'), gt.getPropDefaultConditioned('SZ_Q')))
assert(isequal(pr_Q.get('LN').get('MarkerSize'), gt.getPropDefaultConditioned('SZ_Q')))
gt.get('SZ_Q')
assert(isequal(pr_Q.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('SZ_Q')))
assert(isequal(pr_Q.get('LN').get('LineWidth'), gt.getPropDefaultConditioned('SZ_Q')))
assert(isequal(pr_Q.get('LN').get('MarkerSize'), gt.getPropDefaultConditioned('SZ_Q')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('SZ_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_Q.get('EDITFIELD').get('Value'), gt.get('SZ_Q')))
assert(isequal(pr_Q.get('LN').get('LineWidth'), gt.get('SZ_Q')))
assert(isequal(pr_Q.get('LN').get('MarkerSize'), gt.get('SZ_Q')))

assert(isequal(pr_E.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('SZ_E')))
assert(isequal(pr_E.get('LN').get('LineWidth'), gt.getPropDefaultConditioned('SZ_E')))
assert(isequal(pr_E.get('LN').get('MarkerSize'), gt.getPropDefaultConditioned('SZ_E')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('SZ_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_E.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('SZ_E')))
assert(isequal(pr_E.get('LN').get('LineWidth'), gt.getPropDefaultConditioned('SZ_E')))
assert(isequal(pr_E.get('LN').get('MarkerSize'), gt.getPropDefaultConditioned('SZ_E')))
gt.memorize('SZ_E')
assert(isequal(pr_E.get('EDITFIELD').get('Value'), gt.get('SZ_E')))
assert(isequal(pr_E.get('LN').get('LineWidth'), gt.get('SZ_E')))
assert(isequal(pr_E.get('LN').get('MarkerSize'), gt.get('SZ_E')))

pr_F.get('CLOSE') % closes all