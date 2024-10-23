%% ¡header!
GTA_ST_TA < ConcreteElement (gt, test A PanelPropStringTextArea) tests PanelPropStringTextArea.

%%% ¡description!
GTA_ST_TA tests PanelPropStringTextArea.

%%% ¡seealso!
PanelPropStringTextArea

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
ST_C (constant, string) is a prop constant string.
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_C, varargin{:});

%%% ¡prop!
ST_M (metadata, string) is a prop metadata string.
%%%% ¡default!
'M\\nM\\nM\\n'
%%%% ¡check_prop!
check = true;
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_M, varargin{:});

%%% ¡prop!
ST_P (parameter, string) is a prop parameter string.
%%%% ¡default!
'P\\nP\\nP\\n'
%%%% ¡check_prop!
check = true;
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_P, varargin{:});

%%% ¡prop!
ST_D (data, string) is a prop data string.
%%%% ¡default!
'D\\nD\\nD\\n'
%%%% ¡check_prop!
check = true;
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_D, varargin{:});

%%% ¡prop!
ST_R (result, string) is a prop result string.
%%%% ¡default!
'result\\ndefault\\n'
%%%% ¡calculate!
value = 'result\\ncalculated\\n';
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_R, varargin{:});

%%% ¡prop!
ST_Q (query, string) is a prop query string.
%%%% ¡default!
'query\\ndefault\\n'
%%%% ¡calculate!
value = 'query\\ncalculated\\n';
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_Q, varargin{:});

%%% ¡prop!
ST_E (evanescent, string) is a prop evanescent string.
%%%% ¡default!
'evanescent\\ndefault\\n'
%%%% ¡calculate!
value = 'evanescent\\ncalculated\\n';
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_E, varargin{:});

%%% ¡prop!
ST_F (figure, string) is a prop figure string.
%%%% ¡default!
'F\\nF\\nF\\n'
%%%% ¡check_prop!
check = true;
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_F, varargin{:});

%%% ¡prop!
ST_G (gui, string) is a prop gui string.
%%%% ¡default!
'G\\nG\\nG\\n'
%%%% ¡check_prop!
check = true;
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', gt, 'PROP', GTA_ST_TA.ST_G, varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
PanelPropStringTextArea
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_ST_TA();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_ST_TA.ST_C, 'PARENT', gui);
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_ST_TA.ST_M, 'PARENT', gui);
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_ST_TA.ST_P, 'PARENT', gui);
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_ST_TA.ST_D, 'PARENT', gui);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_ST_TA.ST_R, 'PARENT', gui);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_ST_TA.ST_Q, 'PARENT', gui);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_ST_TA.ST_E, 'PARENT', gui);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_ST_TA.ST_F, 'PARENT', gui);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_ST_TA.ST_G, 'PARENT', gui);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(isequal(pr_C.get('TEXTAREA').get('Value'), {gt.get('ST_C')}))

value = pr_M.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.get('ST_M'))) % double \\ to be converted to single \\ in compilation
gt.set('ST_M', '123\\n456\\n')
value = pr_M.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.get('ST_M'))) % double \\ to be converted to single \\ in compilation

value = pr_P.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.get('ST_P'))) % double \\ to be converted to single \\ in compilation
gt.set('ST_P', '12\\n34\\n')
value = pr_P.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.get('ST_P'))) % double \\ to be converted to single \\ in compilation

value = pr_D.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.get('ST_D'))) % double \\ to be converted to single \\ in compilation
gt.set('ST_D', '666\\n666\\n')
value = pr_D.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.get('ST_D'))) % double \\ to be converted to single \\ in compilation

value = pr_F.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.get('ST_F'))) % double \\ to be converted to single \\ in compilation
gt.set('ST_F', '43\\n21\\n')
value = pr_F.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.get('ST_F'))) % double \\ to be converted to single \\ in compilation

value = pr_G.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.get('ST_G'))) % double \\ to be converted to single \\ in compilation
gt.set('ST_G', '12\\n21\\n')
value = pr_G.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.get('ST_G'))) % double \\ to be converted to single \\ in compilation

value = pr_R.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.getPropDefaultConditioned('ST_R'))) % double \\ to be converted to single \\ in compilation
gt.get('ST_R')
value = pr_R.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.getPropDefaultConditioned('ST_R'))) % double \\ to be converted to single \\ in compilation
gt.memorize('ST_R')
value = pr_R.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.get('ST_R'))) % double \\ to be converted to single \\ in compilation

value = pr_Q.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.getPropDefaultConditioned('ST_Q'))) % double \\ to be converted to single \\ in compilation
gt.get('ST_Q')
value = pr_Q.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.getPropDefaultConditioned('ST_Q'))) % double \\ to be converted to single \\ in compilation
warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('ST_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
value = pr_Q.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.get('ST_Q'))) % double \\ to be converted to single \\ in compilation

value = pr_E.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.getPropDefaultConditioned('ST_E'))) % double \\ to be converted to single \\ in compilation
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('ST_E')
warning('on', [BRAPH2.STR ':' class(gt)])
value = pr_E.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.getPropDefaultConditioned('ST_E'))) % double \\ to be converted to single \\ in compilation
gt.memorize('ST_E')
value = pr_E.get('TEXTAREA').get('Value');
assert(isequal(sprintf('%s\\\\n', value{:}), gt.get('ST_E'))) % double \\ to be converted to single \\ in compilation

pr_F.get('CLOSE') % closes all