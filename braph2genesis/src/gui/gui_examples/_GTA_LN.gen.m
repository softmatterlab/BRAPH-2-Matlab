%% ¡header!
GTA_LN < ConcreteElement (gt, test A PanelPropLine) tests PanelPropLine.

%%% ¡description!
GTA_LN tests PanelPropLine.

%%% ¡seealso!
PanelPropLine

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
LN_C (constant, line) is a prop constant line.

%%% ¡prop!
LN_M (metadata, line) is a prop metadata line.

%%% ¡prop!
LN_P (parameter, line) is a prop parameter line.

%%% ¡prop!
LN_D (data, line) is a prop data line.

%%% ¡prop!
LN_R (result, line) is a prop result line.

%%% ¡prop!
LN_Q (query, line) is a prop query line.

%%% ¡prop!
LN_E (evanescent, line) is a prop evanescent line.

%%% ¡prop!
LN_F (figure, line) is a prop figure line.

%%% ¡prop!
LN_G (gui, line) is a prop gui line.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_LN();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_LN.LN_C, 'PARENT', gui);
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_LN.LN_M, 'PARENT', gui);
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_LN.LN_P, 'PARENT', gui);
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_LN.LN_D, 'PARENT', gui);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_LN.LN_R, 'PARENT', gui);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_LN.LN_Q, 'PARENT', gui);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_LN.LN_E, 'PARENT', gui);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_LN.LN_F, 'PARENT', gui);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_LN.LN_G, 'PARENT', gui);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(isequal(pr_C.get('DROPDOWN').get('Value'), gt.get('LN_C')))
assert(isequal(pr_C.get('LN').get('LineStyle'), gt.get('LN_C')))

assert(isequal(pr_M.get('DROPDOWN').get('Value'), gt.get('LN_M')))
assert(isequal(pr_M.get('LN').get('LineStyle'), gt.get('LN_M')))
gt.set('LN_M', '--')
assert(isequal(pr_M.get('DROPDOWN').get('Value'), gt.get('LN_M')))
assert(isequal(pr_M.get('LN').get('LineStyle'), gt.get('LN_M')))

assert(isequal(pr_P.get('DROPDOWN').get('Value'), gt.get('LN_P')))
assert(isequal(pr_P.get('LN').get('LineStyle'), gt.get('LN_P')))
gt.set('LN_P', '-.')
assert(isequal(pr_P.get('DROPDOWN').get('Value'), gt.get('LN_P')))
assert(isequal(pr_P.get('LN').get('LineStyle'), gt.get('LN_P')))

assert(isequal(pr_D.get('DROPDOWN').get('Value'), gt.get('LN_D')))
assert(isequal(pr_D.get('LN').get('LineStyle'), gt.get('LN_D')))
gt.set('LN_D', ':')
assert(isequal(pr_D.get('DROPDOWN').get('Value'), gt.get('LN_D')))
assert(isequal(pr_D.get('LN').get('LineStyle'), gt.get('LN_D')))

assert(isequal(pr_F.get('DROPDOWN').get('Value'), gt.get('LN_F')))
assert(isequal(pr_F.get('LN').get('LineStyle'), gt.get('LN_F')))
gt.set('LN_F', '-')
assert(isequal(pr_F.get('DROPDOWN').get('Value'), gt.get('LN_F')))
assert(isequal(pr_F.get('LN').get('LineStyle'), gt.get('LN_F')))

assert(isequal(pr_G.get('DROPDOWN').get('Value'), gt.get('LN_G')))
assert(isequal(pr_G.get('LN').get('LineStyle'), gt.get('LN_G')))
gt.set('LN_G', 'none')
assert(isequal(pr_G.get('DROPDOWN').get('Value'), gt.get('LN_G')))
assert(isequal(pr_G.get('LN').get('LineStyle'), gt.get('LN_G')))

assert(isequal(pr_R.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('LN_R')))
assert(isequal(pr_R.get('LN').get('LineStyle'), gt.getPropDefaultConditioned('LN_R')))
gt.get('LN_R')
assert(isequal(pr_R.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('LN_R')))
assert(isequal(pr_R.get('LN').get('LineStyle'), gt.getPropDefaultConditioned('LN_R')))
gt.memorize('LN_R')
assert(isequal(pr_R.get('DROPDOWN').get('Value'), gt.get('LN_R')))
assert(isequal(pr_R.get('LN').get('LineStyle'), gt.get('LN_R')))

assert(isequal(pr_Q.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('LN_Q')))
assert(isequal(pr_Q.get('LN').get('LineStyle'), gt.getPropDefaultConditioned('LN_Q')))
gt.get('LN_Q')
assert(isequal(pr_Q.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('LN_Q')))
assert(isequal(pr_Q.get('LN').get('LineStyle'), gt.getPropDefaultConditioned('LN_Q')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('LN_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_Q.get('DROPDOWN').get('Value'), gt.get('LN_Q')))
assert(isequal(pr_Q.get('LN').get('LineStyle'), gt.get('LN_Q')))

assert(isequal(pr_E.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('LN_E')))
assert(isequal(pr_E.get('LN').get('LineStyle'), gt.getPropDefaultConditioned('LN_E')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('LN_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_E.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('LN_E')))
assert(isequal(pr_E.get('LN').get('LineStyle'), gt.getPropDefaultConditioned('LN_E')))
gt.memorize('LN_E')
assert(isequal(pr_E.get('DROPDOWN').get('Value'), gt.get('LN_E')))
assert(isequal(pr_E.get('LN').get('LineStyle'), gt.get('LN_E')))

pr_F.get('CLOSE') % closes all