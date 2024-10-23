%% ¡header!
GTA_AL < ConcreteElement (gt, test A PanelPropAlpha) tests PanelPropAlpha.

%%% ¡description!
GTA_AL tests PanelPropAlpha.

%%% ¡seealso!
PanelPropAlpha

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
AL_C (constant, alpha) is a prop constant alpha.

%%% ¡prop!
AL_M (metadata, alpha) is a prop metadata alpha.

%%% ¡prop!
AL_P (parameter, alpha) is a prop parameter alpha.

%%% ¡prop!
AL_D (data, alpha) is a prop data alpha.

%%% ¡prop!
AL_R (result, alpha) is a prop result alpha.

%%% ¡prop!
AL_Q (query, alpha) is a prop query alpha.

%%% ¡prop!
AL_E (evanescent, alpha) is a prop evanescent alpha.

%%% ¡prop!
AL_F (figure, alpha) is a prop figure alpha.

%%% ¡prop!
AL_G (gui, alpha) is a prop gui alpha.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_AL();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_AL.AL_C, 'PARENT', gui);
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_AL.AL_M, 'PARENT', gui);
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_AL.AL_P, 'PARENT', gui);
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_AL.AL_D, 'PARENT', gui);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_AL.AL_R, 'PARENT', gui);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_AL.AL_Q, 'PARENT', gui);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_AL.AL_E, 'PARENT', gui);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_AL.AL_F, 'PARENT', gui);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_AL.AL_G, 'PARENT', gui);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(isequal(pr_C.get('EDITFIELD').get('Value'), gt.get('AL_C')))
assert(isequal(pr_C.get('SLIDER').get('Value'), gt.get('AL_C')))

assert(isequal(pr_M.get('EDITFIELD').get('Value'), gt.get('AL_M')))
assert(isequal(pr_M.get('SLIDER').get('Value'), gt.get('AL_M')))
gt.set('AL_M', .1)
assert(isequal(pr_M.get('EDITFIELD').get('Value'), gt.get('AL_M')))
assert(isequal(pr_M.get('SLIDER').get('Value'), gt.get('AL_M')))

assert(isequal(pr_P.get('EDITFIELD').get('Value'), gt.get('AL_P')))
assert(isequal(pr_P.get('SLIDER').get('Value'), gt.get('AL_P')))
gt.set('AL_P', .2)
assert(isequal(pr_P.get('EDITFIELD').get('Value'), gt.get('AL_P')))
assert(isequal(pr_P.get('SLIDER').get('Value'), gt.get('AL_P')))

assert(isequal(pr_D.get('EDITFIELD').get('Value'), gt.get('AL_D')))
assert(isequal(pr_D.get('SLIDER').get('Value'), gt.get('AL_D')))
gt.set('AL_D', .3)
assert(isequal(pr_D.get('EDITFIELD').get('Value'), gt.get('AL_D')))
assert(isequal(pr_D.get('SLIDER').get('Value'), gt.get('AL_D')))

assert(isequal(pr_F.get('EDITFIELD').get('Value'), gt.get('AL_F')))
assert(isequal(pr_F.get('SLIDER').get('Value'), gt.get('AL_F')))
gt.set('AL_F', .4)
assert(isequal(pr_F.get('EDITFIELD').get('Value'), gt.get('AL_F')))
assert(isequal(pr_F.get('SLIDER').get('Value'), gt.get('AL_F')))

assert(isequal(pr_G.get('EDITFIELD').get('Value'), gt.get('AL_G')))
assert(isequal(pr_G.get('SLIDER').get('Value'), gt.get('AL_G')))
gt.set('AL_G', .5)
assert(isequal(pr_G.get('EDITFIELD').get('Value'), gt.get('AL_G')))
assert(isequal(pr_G.get('SLIDER').get('Value'), gt.get('AL_G')))

assert(isequal(pr_R.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('AL_R')))
assert(isequal(pr_R.get('SLIDER').get('Value'), gt.getPropDefaultConditioned('AL_R')))
gt.get('AL_R')
assert(isequal(pr_R.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('AL_R')))
assert(isequal(pr_R.get('SLIDER').get('Value'), gt.getPropDefaultConditioned('AL_R')))
gt.memorize('AL_R')
assert(isequal(pr_R.get('EDITFIELD').get('Value'), gt.get('AL_R')))
assert(isequal(pr_R.get('SLIDER').get('Value'), gt.get('AL_R')))

assert(isequal(pr_Q.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('AL_Q')))
assert(isequal(pr_Q.get('SLIDER').get('Value'), gt.getPropDefaultConditioned('AL_Q')))
gt.get('AL_Q')
assert(isequal(pr_Q.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('AL_Q')))
assert(isequal(pr_Q.get('SLIDER').get('Value'), gt.getPropDefaultConditioned('AL_Q')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('AL_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_Q.get('EDITFIELD').get('Value'), gt.get('AL_Q')))
assert(isequal(pr_Q.get('SLIDER').get('Value'), gt.get('AL_Q')))

assert(isequal(pr_E.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('AL_E')))
assert(isequal(pr_E.get('SLIDER').get('Value'), gt.getPropDefaultConditioned('AL_E')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('AL_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_E.get('EDITFIELD').get('Value'), gt.getPropDefaultConditioned('AL_E')))
assert(isequal(pr_E.get('SLIDER').get('Value'), gt.getPropDefaultConditioned('AL_E')))
gt.memorize('AL_E')
assert(isequal(pr_E.get('EDITFIELD').get('Value'), gt.get('AL_E')))
assert(isequal(pr_E.get('SLIDER').get('Value'), gt.get('AL_E')))

pr_F.get('CLOSE') % closes all