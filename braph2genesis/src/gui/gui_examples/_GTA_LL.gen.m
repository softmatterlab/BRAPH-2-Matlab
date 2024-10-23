%% ¡header!
GTA_LL < ConcreteElement (gt, test A PanelPropCell) tests PanelPropCell.

%%% ¡description!
GTA_LL tests PanelPropCell.

%%% ¡seealso!
PanelPropCell

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
LL_C (constant, cell) is a prop constant cell.
%%%% ¡default!
{ones(3, 5)}

%%% ¡prop!
LL_M (metadata, cell) is a prop metadata cell.
%%%% ¡default!
{ones(2, 3) 2*ones(3, 2) 3*ones(4, 1)}

%%% ¡prop!
LL_P (parameter, cell) is a prop parameter cell.
%%%% ¡default!
{ones(2, 3); 2*ones(3, 2); 3*ones(4, 1)}

%%% ¡prop!
LL_D (data, cell) is a prop data cell.
%%%% ¡default!
{1.1*ones(1, 1) 1.2*ones(1, 2); 2.1*ones(2, 1) 2.2*ones(2, 2); 3.1*ones(3, 1) 3.2*ones(3, 2)}

%%% ¡prop!
LL_R (result, cell) is a prop result cell.

%%% ¡prop!
LL_Q (query, cell) is a prop query cell.

%%% ¡prop!
LL_E (evanescent, cell) is a prop evanescent cell.

%%% ¡prop!
LL_F (figure, cell) is a prop figure cell.
%%%% ¡default!
{1.1*ones(1, 1) 1.2*ones(1, 2); 2.1*ones(2, 1) 2.2*ones(2, 2)}

%%% ¡prop!
LL_G (gui, cell) is a prop gui cell.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
PanelPropCell
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_LL();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_LL.LL_C, 'PARENT', gui, 'TABLE_HEIGHT', 200, ...
    'XSLIDERSHOW', false, 'YSLIDERSHOW', false, ...
    'ROWNAME', {'numbered'}, 'COLUMNNAME', {'numbered'});
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_LL.LL_M, 'PARENT', gui, 'TABLE_HEIGHT', 200, ...
    'XSLIDERSHOW', true, 'YSLIDERSHOW', false, ...
    'XSLIDERLABELS', {'a' 'b' 'c'}, ...
    'ROWNAME', {}, 'COLUMNNAME', {});
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_LL.LL_P, 'PARENT', gui, 'TABLE_HEIGHT', 200, ...
    'XSLIDERSHOW', false, 'YSLIDERSHOW', true, 'YSLIDERLABELS', {'1' '2' '3'}, ...
    'ROWNAME', {'_1_' '_2_' '_3_'}, 'COLUMNNAME', {'a' 'b' 'c'});
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_LL.LL_D, 'PARENT', gui, 'TABLE_HEIGHT', 200, ...
    'XSLIDERSHOW', true, 'YSLIDERSHOW', true, 'XSLIDERLABELS', {'a' 'b' 'c'}, ...
    'YSLIDERLABELS', {'1' '2' '3'});
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_LL.LL_R, 'PARENT', gui, 'TABLE_HEIGHT', 200);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_LL.LL_Q, 'PARENT', gui, 'TABLE_HEIGHT', 200);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_LL.LL_E, 'PARENT', gui, 'TABLE_HEIGHT', 200);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_LL.LL_F, 'PARENT', gui, 'TABLE_HEIGHT', 200, ...
    'XYSLIDERLOCK', true, ...
    'XSLIDERLABELS', {'a' 'b' 'c'}, 'YSLIDERLABELS', {'1' '2' '3'});
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_LL.LL_G, 'PARENT', gui, 'TABLE_HEIGHT', 200);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

v = gt.get('LL_C'); assert(isequal(pr_C.get('TABLE').get('Data'), v{1}))

v = gt.get('LL_M'); assert(isequal(pr_M.get('TABLE').get('Data'), v{1}))
gt.set('LL_M', {randn(3, 4) randn(5, 2)})
v = gt.get('LL_M'); assert(isequal(pr_M.get('TABLE').get('Data'), v{1}))

v = gt.get('LL_P'); assert(isequal(pr_P.get('TABLE').get('Data'), v{3}))
gt.set('LL_P', {randn(3, 4) randn(5, 2)})
v = gt.get('LL_P'); assert(isequal(pr_P.get('TABLE').get('Data'), v{1}))
 
v = gt.get('LL_D'); assert(isequal(pr_D.get('TABLE').get('Data'), v{3}))
gt.set('LL_D', {randn(3, 4) randn(5, 2)})
v = gt.get('LL_D'); assert(isequal(pr_D.get('TABLE').get('Data'), v{1}))
 
v = gt.get('LL_F'); assert(isequal(pr_F.get('TABLE').get('Data'), v{1}))
gt.set('LL_F', {randn(3, 4) randn(5, 2); randn(3, 4) randn(5, 2)})
v = gt.get('LL_F'); assert(isequal(pr_F.get('TABLE').get('Data'), v{1}))
 
v = gt.get('LL_G'); assert(isequal(pr_G.get('TABLE').get('Data'), v))
gt.set('LL_G', {randn(3, 4) randn(5, 2)})
v = gt.get('LL_G'); assert(isequal(pr_G.get('TABLE').get('Data'), v{1}))

assert(isempty(pr_R.get('TABLE').get('Data')))
gt.get('LL_R')
assert(isempty(pr_R.get('TABLE').get('Data')))
gt.memorize('LL_R')
assert(isempty(pr_R.get('TABLE').get('Data')))
 
assert(isempty(pr_Q.get('TABLE').get('Data')))
gt.get('LL_Q')
assert(isempty(pr_Q.get('TABLE').get('Data')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('LL_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isempty(pr_Q.get('TABLE').get('Data')))

assert(isempty(pr_E.get('TABLE').get('Data')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('LL_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isempty(pr_E.get('TABLE').get('Data')))
gt.memorize('LL_E')
assert(isempty(pr_E.get('TABLE').get('Data')))

pr_F.get('CLOSE') % closes all