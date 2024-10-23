%% ¡header!
GTA_CA < ConcreteElement (gt, test A PanelPropClass) tests PanelPropClass.

%%% ¡description!
GTA_CA tests PanelPropClass.

%%% ¡seealso!
PanelPropClass

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
CA_C (constant, class) is a prop constant class.

%%% ¡prop!
CA_M (metadata, class) is a prop metadata class.

%%% ¡prop!
CA_P (parameter, class) is a prop parameter class.

%%% ¡prop!
CA_D (data, class) is a prop data class.

%%% ¡prop!
CA_R (result, class) is a prop result class.

%%% ¡prop!
CA_Q (query, class) is a prop query class.

%%% ¡prop!
CA_E (evanescent, class) is a prop evanescent class.

%%% ¡prop!
CA_F (figure, class) is a prop figure class.

%%% ¡prop!
CA_G (gui, class) is a prop gui class.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_CA();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_CA.CA_C, 'PARENT', gui);
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_CA.CA_M, 'PARENT', gui);
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_CA.CA_P, 'PARENT', gui);
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_CA.CA_D, 'PARENT', gui);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_CA.CA_R, 'PARENT', gui);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_CA.CA_Q, 'PARENT', gui);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_CA.CA_E, 'PARENT', gui);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_CA.CA_F, 'PARENT', gui);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_CA.CA_G, 'PARENT', gui);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(isequal(pr_C.get('DROPDOWN').get('Value'), gt.get('CA_C')))

assert(isequal(pr_M.get('DROPDOWN').get('Value'), gt.get('CA_M')))
gt.set('CA_M', 'GTA_CA')
assert(isequal(pr_M.get('DROPDOWN').get('Value'), gt.get('CA_M')))

assert(isequal(pr_P.get('DROPDOWN').get('Value'), gt.get('CA_P')))
gt.set('CA_P', 'GTA_OP')
assert(isequal(pr_P.get('DROPDOWN').get('Value'), gt.get('CA_P')))

assert(isequal(pr_D.get('DROPDOWN').get('Value'), gt.get('CA_D')))
gt.set('CA_D', 'GTA_EM')
assert(isequal(pr_D.get('DROPDOWN').get('Value'), gt.get('CA_D')))

assert(isequal(pr_F.get('DROPDOWN').get('Value'), gt.get('CA_F')))
gt.set('CA_F', 'GTA_ST')
assert(isequal(pr_F.get('DROPDOWN').get('Value'), gt.get('CA_F')))

assert(isequal(pr_G.get('DROPDOWN').get('Value'), gt.get('CA_G')))
gt.set('CA_G', 'GTA_AL')
assert(isequal(pr_G.get('DROPDOWN').get('Value'), gt.get('CA_G')))

assert(isequal(pr_R.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('CA_R')))
gt.get('CA_R')
assert(isequal(pr_R.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('CA_R')))
gt.memorize('CA_R')
assert(isequal(pr_R.get('DROPDOWN').get('Value'), gt.get('CA_R')))

assert(isequal(pr_Q.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('CA_Q')))
gt.get('CA_Q')
assert(isequal(pr_Q.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('CA_Q')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('CA_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_Q.get('DROPDOWN').get('Value'), gt.get('CA_Q')))

assert(isequal(pr_E.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('CA_E')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('CA_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_E.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('CA_E')))
gt.memorize('CA_E')
assert(isequal(pr_E.get('DROPDOWN').get('Value'), gt.get('CA_E')))

pr_F.get('CLOSE') % closes all