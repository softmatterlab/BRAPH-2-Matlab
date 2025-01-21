%% ¡header!
GTA_IT < ConcreteElement (gt, test A PanelPropItem) tests PanelPropItem.

%%% ¡description!
GTA_IT tests PanelPropItem.

%%% ¡seealso!
PanelPropItem

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
IT_C (constant, item) is a prop constant item.

%%% ¡prop!
IT_M (metadata, item) is a prop metadata item.

%%% ¡prop!
IT_P (parameter, item) is a prop parameter item.

%%% ¡prop!
IT_D (data, item) is a prop data item.

%%% ¡prop!
IT_R (result, item) is a prop result item.

%%% ¡prop!
IT_Q (query, item) is a prop query item.

%%% ¡prop!
IT_E (evanescent, item) is a prop evanescent item.

%%% ¡prop!
IT_F (figure, item) is a prop figure item.

%%% ¡prop!
IT_G (gui, item) is a prop gui item.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
PanelPropItem
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_IT();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_IT.IT_C, 'PARENT', gui, 'HEIGHT', 200);
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_IT.IT_M, 'PARENT', gui, 'HEIGHT', 200);
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_IT.IT_P, 'PARENT', gui, 'HEIGHT', 200);
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_IT.IT_D, 'PARENT', gui, 'HEIGHT', 200);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_IT.IT_R, 'PARENT', gui, 'HEIGHT', 200);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_IT.IT_Q, 'PARENT', gui, 'HEIGHT', 200);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_IT.IT_E, 'PARENT', gui, 'HEIGHT', 200);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_IT.IT_F, 'PARENT', gui, 'HEIGHT', 200);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_IT.IT_G, 'PARENT', gui, 'HEIGHT', 200);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(pr_C.memorize('GUI_ITEM').get('PE').get('EL') == gt.get('IT_C'))

assert(pr_M.memorize('GUI_ITEM').get('PE').get('EL') == gt.get('IT_M'))
gt.set('IT_M', ConcreteElement())
assert(pr_M.memorize('GUI_ITEM').get('PE').get('EL') ~= gt.get('IT_M'))

assert(pr_P.memorize('GUI_ITEM').get('PE').get('EL') == gt.get('IT_P'))
gt.set('IT_P', ConcreteElement())
assert(pr_P.memorize('GUI_ITEM').get('PE').get('EL') ~= gt.get('IT_P'))

assert(pr_D.memorize('GUI_ITEM').get('PE').get('EL') == gt.get('IT_D'))
gt.set('IT_D', ConcreteElement())
assert(pr_D.memorize('GUI_ITEM').get('PE').get('EL') ~= gt.get('IT_D'))

assert(pr_F.memorize('GUI_ITEM').get('PE').get('EL') == gt.get('IT_F'))
gt.set('IT_F', ConcreteElement())
assert(pr_F.memorize('GUI_ITEM').get('PE').get('EL') ~= gt.get('IT_F'))

assert(pr_G.memorize('GUI_ITEM').get('PE').get('EL') == gt.get('IT_G'))
gt.set('IT_G', ConcreteElement())
assert(pr_G.memorize('GUI_ITEM').get('PE').get('EL') ~= gt.get('IT_G'))

assert(isequal(pr_R.memorize('GUI_ITEM').get('PE').get('EL'), gt.getPropDefaultConditioned('IT_R')))
gt.get('IT_R')
assert(isequal(pr_R.memorize('GUI_ITEM').get('PE').get('EL'), gt.getPropDefaultConditioned('IT_R')))
gt.memorize('IT_R')
assert(isequal(pr_R.memorize('GUI_ITEM').get('PE').get('EL'), gt.getPropDefaultConditioned('IT_R')))

warning('off', [BRAPH2.STR ':' class(gt)]) % IT_Q will be memorized in preset
assert(isequal(pr_Q.memorize('GUI_ITEM').get('PE').get('EL'), gt.getPropDefaultConditioned('IT_Q')))
warning('on', [BRAPH2.STR ':' class(gt)])
gt.get('IT_Q')
assert(isequal(pr_Q.memorize('GUI_ITEM').get('PE').get('EL'), gt.getPropDefaultConditioned('IT_Q')))
gt.memorize('IT_Q')
assert(isequal(pr_Q.memorize('GUI_ITEM').get('PE').get('EL'), gt.getPropDefaultConditioned('IT_Q')))

assert(isequal(pr_E.memorize('GUI_ITEM').get('PE').get('EL'), gt.getPropDefaultConditioned('IT_E')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('IT_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_E.memorize('GUI_ITEM').get('PE').get('EL'), gt.getPropDefaultConditioned('IT_E')))
gt.memorize('IT_E')
assert(isequal(pr_E.memorize('GUI_ITEM').get('PE').get('EL'), gt.getPropDefaultConditioned('IT_E')))

pr_F.get('CLOSE') % closes all