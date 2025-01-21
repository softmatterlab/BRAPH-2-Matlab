%% ¡header!
GTA_NM < ConcreteElement (gt, test A PanelPropMatrix) tests PanelPropMatrix.

%%% ¡description!
GTA_NM tests PanelPropMatrix.

%%% ¡seealso!
PanelPropMatrix

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
NM_C (constant, matrix) is a prop constant matrix.
%%%% ¡default!
eye(10)

%%% ¡prop!
NM_M (metadata, matrix) is a prop metadata matrix.
%%%% ¡default!
eye(10)

%%% ¡prop!
NM_P (parameter, matrix) is a prop parameter matrix.
%%%% ¡default!
eye(10)

%%% ¡prop!
NM_D (data, matrix) is a prop data matrix.
%%%% ¡default!
eye(10)

%%% ¡prop!
NM_R (result, matrix) is a prop result matrix.
%%%% ¡calculate!
value = randi(10, 10);

%%% ¡prop!
NM_Q (query, matrix) is a prop query matrix.
%%%% ¡calculate!
value = randi(10, 10);

%%% ¡prop!
NM_E (evanescent, matrix) is a prop evanescent matrix.
%%%% ¡calculate!
value = randi(10, 10);

%%% ¡prop!
NM_F (figure, matrix) is a prop figure matrix.
%%%% ¡default!
eye(10)

%%% ¡prop!
NM_G (gui, matrix) is a prop gui matrix.
%%%% ¡default!
eye(10)

%% ¡tests!

%%% ¡test!
%%%% ¡name!
PanelPropMatrix
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_NM();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_NM.NM_C, 'PARENT', gui, 'HEIGHT', 200, 'ROWNAME', {'numbered'}, 'COLUMNNAME', {'numbered'});
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_NM.NM_M, 'PARENT', gui, 'HEIGHT', 200, 'ROWNAME', {}, 'COLUMNNAME', {});
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_NM.NM_P, 'PARENT', gui, 'HEIGHT', 200, 'ROWNAME', {'1' '2' '3'}, 'COLUMNNAME', {'a' 'b' 'c'});
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_NM.NM_D, 'PARENT', gui, 'HEIGHT', 200);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_NM.NM_R, 'PARENT', gui, 'HEIGHT', 200);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_NM.NM_Q, 'PARENT', gui, 'HEIGHT', 200);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_NM.NM_E, 'PARENT', gui, 'HEIGHT', 200);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_NM.NM_F, 'PARENT', gui, 'HEIGHT', 200);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_NM.NM_G, 'PARENT', gui, 'HEIGHT', 200);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(isequal(pr_C.get('TABLE').get('Data'), gt.get('NM_C')))

assert(isequal(pr_M.get('TABLE').get('Data'), gt.get('NM_M')))
gt.set('NM_M', randn(3, 4))
assert(isequal(pr_M.get('TABLE').get('Data'), gt.get('NM_M')))

assert(isequal(pr_P.get('TABLE').get('Data'), gt.get('NM_P')))
gt.set('NM_P', randn(3, 4))
assert(isequal(pr_P.get('TABLE').get('Data'), gt.get('NM_P')))

assert(isequal(pr_D.get('TABLE').get('Data'), gt.get('NM_D')))
gt.set('NM_D', randn(3, 4))
assert(isequal(pr_D.get('TABLE').get('Data'), gt.get('NM_D')))

assert(isequal(pr_F.get('TABLE').get('Data'), gt.get('NM_F')))
gt.set('NM_F', randn(3, 4))
assert(isequal(pr_F.get('TABLE').get('Data'), gt.get('NM_F')))

assert(isequal(pr_G.get('TABLE').get('Data'), gt.get('NM_G')))
gt.set('NM_G', randn(3, 4))
assert(isequal(pr_G.get('TABLE').get('Data'), gt.get('NM_G')))

assert(isequal(pr_R.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NM_R')))
gt.get('NM_R')
assert(isequal(pr_R.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NM_R')))
gt.memorize('NM_R')
assert(isequal(pr_R.get('TABLE').get('Data'), gt.get('NM_R')))

assert(isequal(pr_Q.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NM_Q')))
gt.get('NM_Q')
assert(isequal(pr_Q.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NM_Q')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('NM_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_Q.get('TABLE').get('Data'), gt.get('NM_Q')))

assert(isequal(pr_E.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NM_E')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('NM_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_E.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NM_E')))
gt.memorize('NM_E')
assert(isequal(pr_E.get('TABLE').get('Data'), gt.get('NM_E')))

pr_F.get('CLOSE') % closes all