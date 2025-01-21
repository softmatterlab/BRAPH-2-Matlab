%% ¡header!
GTA_ST < ConcreteElement (gt, test A PanelPropSring) tests PanelPropString.

%%% ¡description!
GTA_ST tests PanelPropString.

%%% ¡seealso!
PanelPropSring

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
ST_C (constant, string) is a prop constant string.

%%% ¡prop!
ST_M (metadata, string) is a prop metadata string.

%%% ¡prop!
ST_P (parameter, string) is a prop parameter string.

%%% ¡prop!
ST_D (data, string) is a prop data string.

%%% ¡prop!
ST_R (result, string) is a prop result string.

%%% ¡prop!
ST_Q (query, string) is a prop query string.

%%% ¡prop!
ST_E (evanescent, string) is a prop evanescent string.

%%% ¡prop!
ST_F (figure, string) is a prop figure string.

%%% ¡prop!
ST_G (gui, string) is a prop gui string.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
PanelPropSring
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_ST();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_ST.ST_C, 'PARENT', gui);
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_ST.ST_M, 'PARENT', gui);
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_ST.ST_P, 'PARENT', gui);
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_ST.ST_D, 'PARENT', gui);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_ST.ST_R, 'PARENT', gui);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_ST.ST_Q, 'PARENT', gui);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_ST.ST_E, 'PARENT', gui);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_ST.ST_F, 'PARENT', gui);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_ST.ST_G, 'PARENT', gui);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(isequal(pr_C.get('EDITFIELD').get('Value'), gt.get('ST_C')))

assert(isequal(pr_M.get('EDITFIELD').get('Value'), gt.get('ST_M')))
gt.set('ST_M', '123456')
assert(isequal(pr_M.get('EDITFIELD').get('Value'), gt.get('ST_M')))

assert(isequal(pr_P.get('EDITFIELD').get('Value'), gt.get('ST_P')))
gt.set('ST_P', '1234')
assert(isequal(pr_P.get('EDITFIELD').get('Value'), gt.get('ST_P')))

assert(isequal(pr_D.get('EDITFIELD').get('Value'), gt.get('ST_D')))
gt.set('ST_D', '666666')
assert(isequal(pr_D.get('EDITFIELD').get('Value'), gt.get('ST_D')))

assert(isequal(pr_F.get('EDITFIELD').get('Value'), gt.get('ST_F')))
gt.set('ST_F', '4321')
assert(isequal(pr_F.get('EDITFIELD').get('Value'), gt.get('ST_F')))

assert(isequal(pr_G.get('EDITFIELD').get('Value'), gt.get('ST_G')))
gt.set('ST_G', '1221')
assert(isequal(pr_G.get('EDITFIELD').get('Value'), gt.get('ST_G')))

assert(isequal(pr_R.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('ST_R')))
gt.get('ST_R')
assert(isequal(pr_R.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('ST_R')))
gt.memorize('ST_R')
assert(isequal(pr_R.get('EDITFIELD').get('Value'), gt.get('ST_R')))

assert(isequal(pr_Q.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('ST_Q')))
gt.get('ST_Q')
assert(isequal(pr_Q.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('ST_Q')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('ST_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_Q.get('EDITFIELD').get('Value'), gt.get('ST_Q')))

assert(isequal(pr_E.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('ST_E')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('ST_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_E.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('ST_E')))
gt.memorize('ST_E')
assert(isequal(pr_E.get('EDITFIELD').get('Value'), gt.get('ST_E')))

pr_F.get('CLOSE') % closes all