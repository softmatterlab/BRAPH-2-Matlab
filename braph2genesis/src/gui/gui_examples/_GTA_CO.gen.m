%% ¡header!
GTA_CO < ConcreteElement (gt, test A PanelPropColor) tests PanelPropColor.

%%% ¡description!
GTA_CO tests PanelPropColor.

%%% ¡seealso!
PanelPropColor

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
CO_C (constant, color) is a prop constant color.

%%% ¡prop!
CO_M (metadata, color) is a prop metadata color.

%%% ¡prop!
CO_P (parameter, color) is a prop parameter color.

%%% ¡prop!
CO_D (data, color) is a prop data color.

%%% ¡prop!
CO_R (result, color) is a prop result color.

%%% ¡prop!
CO_Q (query, color) is a prop query color.

%%% ¡prop!
CO_E (evanescent, color) is a prop evanescent color.

%%% ¡prop!
CO_F (figure, color) is a prop figure color.

%%% ¡prop!
CO_G (gui, color) is a prop gui color.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_CO();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_CO.CO_C, 'PARENT', gui);
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_CO.CO_M, 'PARENT', gui);
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_CO.CO_P, 'PARENT', gui);
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_CO.CO_D, 'PARENT', gui);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_CO.CO_R, 'PARENT', gui);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_CO.CO_Q, 'PARENT', gui);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_CO.CO_E, 'PARENT', gui);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_CO.CO_F, 'PARENT', gui);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_CO.CO_G, 'PARENT', gui);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(isequal(pr_C.get('BUTTON').get('BackgroundColor'), gt.get('CO_C')))

assert(isequal(pr_M.get('BUTTON').get('BackgroundColor'), gt.get('CO_M')))
gt.set('CO_M', [1 0 0])
assert(isequal(pr_M.get('BUTTON').get('BackgroundColor'), gt.get('CO_M')))

assert(isequal(pr_P.get('BUTTON').get('BackgroundColor'), gt.get('CO_P')))
gt.set('CO_P', [0 1 0])
assert(isequal(pr_P.get('BUTTON').get('BackgroundColor'), gt.get('CO_P')))

assert(isequal(pr_D.get('BUTTON').get('BackgroundColor'), gt.get('CO_D')))
gt.set('CO_D', [0 0 1])
assert(isequal(pr_D.get('BUTTON').get('BackgroundColor'), gt.get('CO_D')))

assert(isequal(pr_F.get('BUTTON').get('BackgroundColor'), gt.get('CO_F')))
gt.set('CO_F', [1 0 1])
assert(isequal(pr_F.get('BUTTON').get('BackgroundColor'), gt.get('CO_F')))

assert(isequal(pr_G.get('BUTTON').get('BackgroundColor'), gt.get('CO_G')))
gt.set('CO_G', [1 1 0])
assert(isequal(pr_G.get('BUTTON').get('BackgroundColor'), gt.get('CO_G')))

assert(isequal(pr_R.get('BUTTON').get('BackgroundColor'), gt.getPropDefaultConditioned('CO_R')))
gt.get('CO_R')
assert(isequal(pr_R.get('BUTTON').get('BackgroundColor'), gt.getPropDefaultConditioned('CO_R')))
gt.memorize('CO_R')
assert(isequal(pr_R.get('BUTTON').get('BackgroundColor'), gt.get('CO_R')))

assert(isequal(pr_Q.get('BUTTON').get('BackgroundColor'), gt.getPropDefaultConditioned('CO_Q')))
gt.get('CO_Q')
assert(isequal(pr_Q.get('BUTTON').get('BackgroundColor'), gt.getPropDefaultConditioned('CO_Q')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('CO_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_Q.get('BUTTON').get('BackgroundColor'), gt.get('CO_Q')))

assert(isequal(pr_E.get('BUTTON').get('BackgroundColor'), gt.getPropDefaultConditioned('CO_E')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('CO_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_E.get('BUTTON').get('BackgroundColor'), gt.getPropDefaultConditioned('CO_E')))
gt.memorize('CO_E')
assert(isequal(pr_E.get('BUTTON').get('BackgroundColor'), gt.get('CO_E')))

pr_F.get('CLOSE') % closes all
