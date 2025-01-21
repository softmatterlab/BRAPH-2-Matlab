%% ¡header!
GTA_MR < ConcreteElement (gt, test A PanelPropMarker) tests PanelPropMarker.

%%% ¡description!
GTA_MR tests PanelPropMarker.

%%% ¡seealso!
PanelPropMarker

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
MR_C (constant, marker) is a prop constant marker.

%%% ¡prop!
MR_M (metadata, marker) is a prop metadata marker.

%%% ¡prop!
MR_P (parameter, marker) is a prop parameter marker.

%%% ¡prop!
MR_D (data, marker) is a prop data marker.

%%% ¡prop!
MR_R (result, marker) is a prop result marker.

%%% ¡prop!
MR_Q (query, marker) is a prop query marker.

%%% ¡prop!
MR_E (evanescent, marker) is a prop evanescent marker.

%%% ¡prop!
MR_F (figure, marker) is a prop figure marker.

%%% ¡prop!
MR_G (gui, marker) is a prop gui marker.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_MR();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_MR.MR_C, 'PARENT', gui);
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_MR.MR_M, 'PARENT', gui);
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_MR.MR_P, 'PARENT', gui);
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_MR.MR_D, 'PARENT', gui);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_MR.MR_R, 'PARENT', gui);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_MR.MR_Q, 'PARENT', gui);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_MR.MR_E, 'PARENT', gui);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_MR.MR_F, 'PARENT', gui);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_MR.MR_G, 'PARENT', gui);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(isequal(pr_C.get('DROPDOWN').get('Value'), gt.get('MR_C')))
assert(isequal(pr_C.get('LN').get('Marker'), gt.get('MR_C')))

assert(isequal(pr_M.get('DROPDOWN').get('Value'), gt.get('MR_M')))
assert(isequal(pr_M.get('LN').get('Marker'), gt.get('MR_M')))
gt.set('MR_M', '+')
assert(isequal(pr_M.get('DROPDOWN').get('Value'), gt.get('MR_M')))
assert(isequal(pr_M.get('LN').get('Marker'), gt.get('MR_M')))

assert(isequal(pr_P.get('DROPDOWN').get('Value'), gt.get('MR_P')))
assert(isequal(pr_P.get('LN').get('Marker'), gt.get('MR_P')))
gt.set('MR_P', '*')
assert(isequal(pr_P.get('DROPDOWN').get('Value'), gt.get('MR_P')))
assert(isequal(pr_P.get('LN').get('Marker'), gt.get('MR_P')))

assert(isequal(pr_D.get('DROPDOWN').get('Value'), gt.get('MR_D')))
assert(isequal(pr_D.get('LN').get('Marker'), gt.get('MR_D')))
gt.set('MR_D', '.')
assert(isequal(pr_D.get('DROPDOWN').get('Value'), gt.get('MR_D')))
assert(isequal(pr_D.get('LN').get('Marker'), gt.get('MR_D')))

assert(isequal(pr_F.get('DROPDOWN').get('Value'), gt.get('MR_F')))
assert(isequal(pr_F.get('LN').get('Marker'), gt.get('MR_F')))
gt.set('MR_F', 'v')
assert(isequal(pr_F.get('DROPDOWN').get('Value'), gt.get('MR_F')))
assert(isequal(pr_F.get('LN').get('Marker'), gt.get('MR_F')))

assert(isequal(pr_G.get('DROPDOWN').get('Value'), gt.get('MR_G')))
assert(isequal(pr_G.get('LN').get('Marker'), gt.get('MR_G')))
gt.set('MR_G', '_')
assert(isequal(pr_G.get('DROPDOWN').get('Value'), gt.get('MR_G')))
assert(isequal(pr_G.get('LN').get('Marker'), gt.get('MR_G')))

assert(isequal(pr_R.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('MR_R')))
assert(isequal(pr_R.get('LN').get('Marker'), gt.getPropDefaultConditioned('MR_R')))
gt.get('MR_R')
assert(isequal(pr_R.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('MR_R')))
assert(isequal(pr_R.get('LN').get('Marker'), gt.getPropDefaultConditioned('MR_R')))
gt.memorize('MR_R')
assert(isequal(pr_R.get('DROPDOWN').get('Value'), gt.get('MR_R')))
assert(isequal(pr_R.get('LN').get('Marker'), gt.get('MR_R')))

assert(isequal(pr_Q.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('MR_Q')))
assert(isequal(pr_Q.get('LN').get('Marker'), gt.getPropDefaultConditioned('MR_Q')))
gt.get('MR_Q')
assert(isequal(pr_Q.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('MR_Q')))
assert(isequal(pr_Q.get('LN').get('Marker'), gt.getPropDefaultConditioned('MR_Q')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('MR_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_Q.get('DROPDOWN').get('Value'), gt.get('MR_Q')))
assert(isequal(pr_Q.get('LN').get('Marker'), gt.get('MR_Q')))

assert(isequal(pr_E.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('MR_E')))
assert(isequal(pr_E.get('LN').get('Marker'), gt.getPropDefaultConditioned('MR_E')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('MR_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_E.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('MR_E')))
assert(isequal(pr_E.get('LN').get('Marker'), gt.getPropDefaultConditioned('MR_E')))
gt.memorize('MR_E')
assert(isequal(pr_E.get('DROPDOWN').get('Value'), gt.get('MR_E')))
assert(isequal(pr_E.get('LN').get('Marker'), gt.get('MR_E')))

pr_F.get('CLOSE') % closes all