%% ¡header!
GTA_NN < ConcreteElement (gt, test A PanelPropScalar) tests PanelPropScalar.

%%% ¡description!
GTA_NN tests PanelPropScalar.

%%% ¡seealso!
PanelPropScalar

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
NN_C (constant, scalar) is a prop constant scalar.

%%% ¡prop!
NN_M (metadata, scalar) is a prop metadata scalar.

%%% ¡prop!
NN_P (parameter, scalar) is a prop parameter scalar.

%%% ¡prop!
NN_D (data, scalar) is a prop data scalar.

%%% ¡prop!
NN_R (result, scalar) is a prop result scalar.

%%% ¡prop!
NN_Q (query, scalar) is a prop query scalar.

%%% ¡prop!
NN_E (evanescent, scalar) is a prop evanescent scalar.

%%% ¡prop!
NN_F (figure, scalar) is a prop figure scalar.

%%% ¡prop!
NN_G (gui, scalar) is a prop gui scalar.

%%% ¡test!
%%%% ¡name!
PanelPropScalar
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_NN();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_NN.NN_C, 'PARENT', gui);
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_NN.NN_M, 'PARENT', gui);
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_NN.NN_P, 'PARENT', gui);
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_NN.NN_D, 'PARENT', gui);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_NN.NN_R, 'PARENT', gui);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_NN.NN_Q, 'PARENT', gui);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_NN.NN_E, 'PARENT', gui);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_NN.NN_F, 'PARENT', gui);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_NN.NN_G, 'PARENT', gui);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(isequal(pr_C.get('EDITFIELD').get('Value'), gt.get('NN_C')))

assert(isequal(pr_M.get('EDITFIELD').get('Value'), gt.get('NN_M')))
gt.set('NN_M', 1)
assert(isequal(pr_M.get('EDITFIELD').get('Value'), gt.get('NN_M')))

assert(isequal(pr_P.get('EDITFIELD').get('Value'), gt.get('NN_P')))
gt.set('NN_P', 2)
assert(isequal(pr_P.get('EDITFIELD').get('Value'), gt.get('NN_P')))

assert(isequal(pr_D.get('EDITFIELD').get('Value'), gt.get('NN_D')))
gt.set('NN_D', 3)
assert(isequal(pr_D.get('EDITFIELD').get('Value'), gt.get('NN_D')))

assert(isequal(pr_F.get('EDITFIELD').get('Value'), gt.get('NN_F')))
gt.set('NN_F', 4)
assert(isequal(pr_F.get('EDITFIELD').get('Value'), gt.get('NN_F')))

assert(isequal(pr_G.get('EDITFIELD').get('Value'), gt.get('NN_G')))
gt.set('NN_G', 5)
assert(isequal(pr_G.get('EDITFIELD').get('Value'), gt.get('NN_G')))

assert(isequal(pr_R.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('NN_R')))
gt.get('NN_R')
assert(isequal(pr_R.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('NN_R')))
gt.memorize('NN_R')
assert(isequal(pr_R.get('EDITFIELD').get('Value'), gt.get('NN_R')))

assert(isequal(pr_Q.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('NN_Q')))
gt.get('NN_Q')
assert(isequal(pr_Q.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('NN_Q')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('NN_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_Q.get('EDITFIELD').get('Value'), gt.get('NN_Q')))

assert(isequal(pr_E.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('NN_E')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('NN_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_E.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('NN_E')))
gt.memorize('NN_E')
assert(isequal(pr_E.get('EDITFIELD').get('Value'), gt.get('NN_E')))

pr_F.get('CLOSE') % closes all