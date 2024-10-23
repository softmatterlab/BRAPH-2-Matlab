%% ¡header!
GTA_DI < ConcreteElement (gt, test A PanelPropIDict) tests PanelPropIDict.

%%% ¡description!
GTA_DI tests PanelPropIDict.

%%% ¡seealso!
PanelPropIDict

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
DI_C (constant, idict) is a prop constant idict.

%%% ¡prop!
DI_M (metadata, idict) is a prop metadata idict.

%%% ¡prop!
DI_P (parameter, idict) is a prop parameter idict.

%%% ¡prop!
DI_D (data, idict) is a prop data idict.

%%% ¡prop!
DI_R (result, idict) is a prop result idict.

%%% ¡prop!
DI_Q (query, idict) is a prop query idict.

%%% ¡prop!
DI_E (evanescent, idict) is a prop evanescent idict.

%%% ¡prop!
DI_F (figure, idict) is a prop figure idict.

%%% ¡prop!
DI_G (gui, idict) is a prop gui idict.

%% ¡tests!
gt = GTA_DI();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_DI.DI_C, 'PARENT', gui, 'HEIGHT', 200);
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_DI.DI_M, 'PARENT', gui, 'HEIGHT', 200);
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_DI.DI_P, 'PARENT', gui, 'HEIGHT', 200);
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_DI.DI_D, 'PARENT', gui, 'HEIGHT', 200);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_DI.DI_R, 'PARENT', gui, 'HEIGHT', 200);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_DI.DI_Q, 'PARENT', gui, 'HEIGHT', 200);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_DI.DI_E, 'PARENT', gui, 'HEIGHT', 200);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_DI.DI_F, 'PARENT', gui, 'HEIGHT', 200);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_DI.DI_G, 'PARENT', gui, 'HEIGHT', 200);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(pr_C.memorize('GUI_ITEM').get('PE').get('EL') == gt.get('DI_C'))

assert(pr_M.memorize('GUI_ITEM').get('PE').get('EL') == gt.get('DI_M'))
gt.set('DI_M', IndexedDictionary())
assert(pr_M.memorize('GUI_ITEM').get('PE').get('EL') ~= gt.get('DI_M'))

assert(pr_P.memorize('GUI_ITEM').get('PE').get('EL') == gt.get('DI_P'))
gt.set('DI_P', IndexedDictionary())
assert(pr_M.memorize('GUI_ITEM').get('PE').get('EL') ~= gt.get('DI_M'))

assert(pr_D.memorize('GUI_ITEM').get('PE').get('EL') == gt.get('DI_D'))
gt.set('DI_D', IndexedDictionary())
assert(pr_M.memorize('GUI_ITEM').get('PE').get('EL') ~= gt.get('DI_M'))

assert(pr_F.memorize('GUI_ITEM').get('PE').get('EL') == gt.get('DI_F'))
gt.set('DI_F', IndexedDictionary())
assert(pr_M.memorize('GUI_ITEM').get('PE').get('EL') ~= gt.get('DI_M'))

assert(pr_G.memorize('GUI_ITEM').get('PE').get('EL') == gt.get('DI_G'))
gt.set('DI_G', IndexedDictionary())
assert(pr_M.memorize('GUI_ITEM').get('PE').get('EL') ~= gt.get('DI_M'))

assert(isequal(pr_R.memorize('GUI_ITEM').get('PE').get('EL'), gt.getPropDefaultConditioned('DI_R')))
gt.get('DI_R')
assert(isequal(pr_R.memorize('GUI_ITEM').get('PE').get('EL'), gt.getPropDefaultConditioned('DI_R')))
gt.memorize('DI_R')
assert(isequal(pr_R.memorize('GUI_ITEM').get('PE').get('EL'), gt.get('DI_R')))

warning('off', [BRAPH2.STR ':' class(gt)]) % DI_Q will be memorized in preset
assert(isequal(pr_Q.memorize('GUI_ITEM').get('PE').get('EL'), gt.getPropDefaultConditioned('DI_Q')))
warning('on', [BRAPH2.STR ':' class(gt)])
gt.get('DI_Q')
assert(isequal(pr_Q.memorize('GUI_ITEM').get('PE').get('EL'), gt.getPropDefaultConditioned('DI_Q')))
gt.memorize('DI_Q')
assert(isequal(pr_Q.memorize('GUI_ITEM').get('PE').get('EL'), gt.get('DI_Q')))

assert(isequal(pr_E.memorize('GUI_ITEM').get('PE').get('EL'), gt.getPropDefaultConditioned('DI_E')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('DI_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_E.memorize('GUI_ITEM').get('PE').get('EL'), gt.getPropDefaultConditioned('DI_E')))
gt.memorize('DI_E')
assert(isequal(pr_E.memorize('GUI_ITEM').get('PE').get('EL'), gt.get('DI_E')))

pr_F.get('CLOSE') % closes all