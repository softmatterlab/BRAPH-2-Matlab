%% ¡header!
GTA_EM < ConcreteElement (gt, test A PanelProp) tests PanelProp.

%%% ¡description!
GTA_EM tests the PanelProp.

%%% ¡seealso!
PanelPropEmpty

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
EM_C (constant, empty) is a prop constant empty.

%%% ¡prop!
EM_M (metadata, empty) is a prop metadata empty.

%%% ¡prop!
EM_P (parameter, empty) is a prop parameter empty.

%%% ¡prop!
EM_D (data, empty) is a prop data empty.

%%% ¡prop!
EM_R (result, empty) is a prop result empty.

%%% ¡prop!
EM_Q (query, empty) is a prop query empty.

%%% ¡prop!
EM_E (evanescent, empty) is a prop evanescent empty.

%%% ¡prop!
EM_F (figure, empty) is a prop figure empty.

%%% ¡prop!
EM_G (gui, empty) is a prop gui empty.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_EM();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_EM.EM_C, 'PARENT', gui);
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_EM.EM_M, 'PARENT', gui);
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_EM.EM_P, 'PARENT', gui);
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_EM.EM_D, 'PARENT', gui);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_EM.EM_R, 'PARENT', gui);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_EM.EM_Q, 'PARENT', gui);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_EM.EM_E, 'PARENT', gui);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_EM.EM_F, 'PARENT', gui);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_EM.EM_G, 'PARENT', gui);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

pr_F.get('CLOSE') % closes all