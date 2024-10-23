%% ¡header!
GTA_NR < ConcreteElement (gt, test A PanelPropRVector) tests PanelPropRVector.

%%% ¡description!
GTA_NR tests PanelPropRVector.

%%% ¡seealso!
PanelPropRVector

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
NR_C (constant, rvector) is a prop constant rvector.
%%%% ¡default!
[1 2 3 4 5]

%%% ¡prop!
NR_M (metadata, rvector) is a prop metadata rvector.
%%%% ¡default!
[1 2 3 4 5]

%%% ¡prop!
NR_P (parameter, rvector) is a prop parameter rvector.
%%%% ¡default!
[1 2 3 4 5]

%%% ¡prop!
NR_D (data, rvector) is a prop data rvector.
%%%% ¡default!
[1 2 3 4 5]

%%% ¡prop!
NR_R (result, rvector) is a prop result rvector.
%%%% ¡calculate!
value = rand(1, 10);

%%% ¡prop!
NR_Q (query, rvector) is a prop query rvector.
%%%% ¡calculate!
value = rand(1, 10);

%%% ¡prop!
NR_E (evanescent, rvector) is a prop evanescent rvector.
%%%% ¡calculate!
value = rand(1, 10);

%%% ¡prop!
NR_F (figure, rvector) is a prop figure rvector.
%%%% ¡default!
[1 2 3 4 5]

%%% ¡prop!
NR_G (gui, rvector) is a prop gui rvector.
%%%% ¡default!
[1 2 3 4 5]

%% ¡tests!

%%% ¡test!
%%%% ¡name!
PanelPropMatrix
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_NR();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_NR.NR_C, 'PARENT', gui, 'HEIGHT', 200, 'ROWNAME', {'numbered'}, 'COLUMNNAME', {'numbered'});
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_NR.NR_M, 'PARENT', gui, 'HEIGHT', 200, 'ROWNAME', {}, 'COLUMNNAME', {});
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_NR.NR_P, 'PARENT', gui, 'HEIGHT', 200, 'ROWNAME', {'1' '2' '3'}, 'COLUMNNAME', {'a' 'b' 'c'});
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_NR.NR_D, 'PARENT', gui, 'HEIGHT', 200);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_NR.NR_R, 'PARENT', gui, 'HEIGHT', 200);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_NR.NR_Q, 'PARENT', gui, 'HEIGHT', 200);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_NR.NR_E, 'PARENT', gui, 'HEIGHT', 200);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_NR.NR_F, 'PARENT', gui, 'HEIGHT', 200);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_NR.NR_G, 'PARENT', gui, 'HEIGHT', 200);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(isequal(pr_C.get('TABLE').get('Data'), gt.get('NR_C')))

assert(isequal(pr_M.get('TABLE').get('Data'), gt.get('NR_M')))
gt.set('NR_M', [1 2 3])
assert(isequal(pr_M.get('TABLE').get('Data'), gt.get('NR_M')))

assert(isequal(pr_P.get('TABLE').get('Data'), gt.get('NR_P')))
gt.set('NR_P', [1 2 3])
assert(isequal(pr_P.get('TABLE').get('Data'), gt.get('NR_P')))

assert(isequal(pr_D.get('TABLE').get('Data'), gt.get('NR_D')))
gt.set('NR_D', [1 2 3])
assert(isequal(pr_D.get('TABLE').get('Data'), gt.get('NR_D')))

assert(isequal(pr_F.get('TABLE').get('Data'), gt.get('NR_F')))
gt.set('NR_F', [1 2 3])
assert(isequal(pr_F.get('TABLE').get('Data'), gt.get('NR_F')))

assert(isequal(pr_G.get('TABLE').get('Data'), gt.get('NR_G')))
gt.set('NR_G', [1 2 3])
assert(isequal(pr_G.get('TABLE').get('Data'), gt.get('NR_G')))

assert(isequal(pr_R.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NR_R')))
gt.get('NR_R')
assert(isequal(pr_R.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NR_R')))
gt.memorize('NR_R')
assert(isequal(pr_R.get('TABLE').get('Data'), gt.get('NR_R')))

assert(isequal(pr_Q.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NR_Q')))
gt.get('NR_Q')
assert(isequal(pr_Q.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NR_Q')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('NR_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_Q.get('TABLE').get('Data'), gt.get('NR_Q')))

assert(isequal(pr_E.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NR_E')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('NR_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_E.get('TABLE').get('Data'), gt.getPropDefaultConditioned('NR_E')))
gt.memorize('NR_E')
assert(isequal(pr_E.get('TABLE').get('Data'), gt.get('NR_E')))

pr_F.get('CLOSE') % closes all
