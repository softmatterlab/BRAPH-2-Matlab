%% ¡header!
GTA_LO < ConcreteElement (gt, test A PanelPropLogical) tests PanelPropLogical.

%%% ¡description!
GTA_LO tests PanelPropLogical.
 
%%% ¡seealso!
PanelPropLogical

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
LO_C (constant, logical) is a prop constant logical.

%%% ¡prop!
LO_M (metadata, logical) is a prop metadata logical.

%%% ¡prop!
LO_P (parameter, logical) is a prop parameter logical.

%%% ¡prop!
LO_D (data, logical) is a prop data logical.

%%% ¡prop!
LO_R (result, logical) is a prop result logical.

%%% ¡prop!
LO_Q (query, logical) is a prop query logical.

%%% ¡prop!
LO_E (evanescent, logical) is a prop evanescent logical.

%%% ¡prop!
LO_F (figure, logical) is a prop figure logical.

%%% ¡prop!
LO_G (gui, logical) is a prop gui logical.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_LO();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_LO.LO_C, 'PARENT', gui);
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_LO.LO_M, 'PARENT', gui);
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_LO.LO_P, 'PARENT', gui);
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_LO.LO_D, 'PARENT', gui);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_LO.LO_R, 'PARENT', gui);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_LO.LO_Q, 'PARENT', gui);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_LO.LO_E, 'PARENT', gui);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_LO.LO_F, 'PARENT', gui);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_LO.LO_G, 'PARENT', gui);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(isequal(pr_C.get('CHECKBOX').get('Value'), gt.get('LO_C')))

assert(isequal(pr_M.get('CHECKBOX').get('Value'), gt.get('LO_M')))
gt.set('LO_M', false)
assert(isequal(pr_M.get('CHECKBOX').get('Value'), gt.get('LO_M')))

assert(isequal(pr_P.get('CHECKBOX').get('Value'), gt.get('LO_P')))
gt.set('LO_P', false)
assert(isequal(pr_P.get('CHECKBOX').get('Value'), gt.get('LO_P')))

assert(isequal(pr_D.get('CHECKBOX').get('Value'), gt.get('LO_D')))
gt.set('LO_D', false)
assert(isequal(pr_D.get('CHECKBOX').get('Value'), gt.get('LO_D')))

assert(isequal(pr_F.get('CHECKBOX').get('Value'), gt.get('LO_F')))
gt.set('LO_F', false)
assert(isequal(pr_F.get('CHECKBOX').get('Value'), gt.get('LO_F')))

assert(isequal(pr_G.get('CHECKBOX').get('Value'), gt.get('LO_G')))
gt.set('LO_G', false)
assert(isequal(pr_G.get('CHECKBOX').get('Value'), gt.get('LO_G')))

assert(isequal(pr_R.get('CHECKBOX').get('Value'), gt.getPropDefaultConditioned('LO_R')))
gt.get('LO_R')
assert(isequal(pr_R.get('CHECKBOX').get('Value'), gt.getPropDefaultConditioned('LO_R')))
gt.memorize('LO_R')
assert(isequal(pr_R.get('CHECKBOX').get('Value'), gt.get('LO_R')))

assert(isequal(pr_Q.get('CHECKBOX').get('Value'), gt.getPropDefaultConditioned('LO_Q')))
gt.get('LO_Q')
assert(isequal(pr_Q.get('CHECKBOX').get('Value'), gt.getPropDefaultConditioned('LO_Q')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('LO_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_Q.get('CHECKBOX').get('Value'), gt.get('LO_Q')))

assert(isequal(pr_E.get('CHECKBOX').get('Value'), gt.getPropDefaultConditioned('LO_E')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('LO_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_E.get('CHECKBOX').get('Value'), gt.getPropDefaultConditioned('LO_E')))
gt.memorize('LO_E')
assert(isequal(pr_E.get('CHECKBOX').get('Value'), gt.get('LO_E')))

pr_F.get('CLOSE') % closes all