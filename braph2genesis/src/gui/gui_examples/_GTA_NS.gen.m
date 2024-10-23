%% ¡header!
GTA_NS < ConcreteElement (gt, test A PanelPropSMatrix) tests PanelPropSMatrix.

%%% ¡description!
GTA_NS tests PanelPropSMatrix.

%%% ¡seealso!
PanelPropSMatrix

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
NS_C (constant, smatrix) is a prop constant smatrix.
%%%% ¡default!
ones(3)

%%% ¡prop!
NS_M (metadata, smatrix) is a prop metadata smatrix.
%%%% ¡default!
ones(3)

%%% ¡prop!
NS_P (parameter, smatrix) is a prop parameter smatrix.
%%%% ¡default!
ones(3)

%%% ¡prop!
NS_D (data, smatrix) is a prop data smatrix.
%%%% ¡default!
ones(3)

%%% ¡prop!
NS_R (result, smatrix) is a prop result smatrix.
%%%% ¡calculate!
value = rand(3);

%%% ¡prop!
NS_Q (query, smatrix) is a prop query smatrix.
%%%% ¡calculate!
value = rand(3);

%%% ¡prop!
NS_E (evanescent, smatrix) is a prop evanescent smatrix.
%%%% ¡calculate!
value = rand(3);

%%% ¡prop!
NS_F (figure, smatrix) is a prop figure smatrix.
%%%% ¡default!
ones(3)

%%% ¡prop!
NS_G (gui, smatrix) is a prop gui smatrix.
%%%% ¡default!
ones(3)

%% ¡tests!

%%% ¡test!
%%%% ¡name!
PanelPropMatrix
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_NS();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_NS.NS_C, 'PARENT', gui, 'HEIGHT', 200, 'ROWNAME', {'numbered'}, 'COLUMNNAME', {'numbered'});
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_NS.NS_M, 'PARENT', gui, 'HEIGHT', 200, 'ROWNAME', {}, 'COLUMNNAME', {});
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_NS.NS_P, 'PARENT', gui, 'HEIGHT', 200, 'ROWNAME', {'1' '2' '3'}, 'COLUMNNAME', {'a' 'b' 'c'});
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_NS.NS_D, 'PARENT', gui, 'HEIGHT', 200);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_NS.NS_R, 'PARENT', gui, 'HEIGHT', 200);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_NS.NS_Q, 'PARENT', gui, 'HEIGHT', 200);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_NS.NS_E, 'PARENT', gui, 'HEIGHT', 200);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_NS.NS_F, 'PARENT', gui, 'HEIGHT', 200);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_NS.NS_G, 'PARENT', gui, 'HEIGHT', 200);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(isequal(pr_C.get('TABLE').get('Data'), gt.get('NS_C')))

assert(isequal(pr_M.get('TABLE').get('Data'), gt.get('NS_M')))
gt.set('NS_M', randn(4))
assert(isequal(pr_M.get('TABLE').get('Data'), gt.get('NS_M')))

assert(isequal(pr_P.get('TABLE').get('Data'), gt.get('NS_P')))
gt.set('NS_P', randn(4))
assert(isequal(pr_P.get('TABLE').get('Data'), gt.get('NS_P')))

assert(isequal(pr_D.get('TABLE').get('Data'), gt.get('NS_D')))
gt.set('NS_D', randn(4))
assert(isequal(pr_D.get('TABLE').get('Data'), gt.get('NS_D')))

assert(isequal(pr_F.get('TABLE').get('Data'), gt.get('NS_F')))
gt.set('NS_F', randn(4))
assert(isequal(pr_F.get('TABLE').get('Data'), gt.get('NS_F')))

assert(isequal(pr_G.get('TABLE').get('Data'), gt.get('NS_G')))
gt.set('NS_G', randn(4))
assert(isequal(pr_G.get('TABLE').get('Data'), gt.get('NS_G')))

assert(isequal(pr_R.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NS_R')))
gt.get('NS_R')
assert(isequal(pr_R.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NS_R')))
gt.memorize('NS_R')
assert(isequal(pr_R.get('TABLE').get('Data'), gt.get('NS_R')))

assert(isequal(pr_Q.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NS_Q')))
gt.get('NS_Q')
assert(isequal(pr_Q.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NS_Q')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('NS_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_Q.get('TABLE').get('Data'), gt.get('NS_Q')))

assert(isequal(pr_E.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NS_E')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('NS_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_E.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NS_E')))
gt.memorize('NS_E')
assert(isequal(pr_E.get('TABLE').get('Data'), gt.get('NS_E')))

pr_F.get('CLOSE') % closes all