%% ¡header!
GTA_OP < ConcreteElement (gt, test A PanelPropOption) tests PanelPropOption.

%%% ¡description!
GTA_OP tests PanelPropOption.

%%% ¡seealso!
PanelPropOption

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
OP_C (constant, option) is a prop constant option.

%%% ¡prop!
OP_M (metadata, option) is a prop metadata option.
%%%% ¡settings!
{'M_A', 'M_B', 'M_C', 'M_D', 'M_E', 'M_F', 'M_G', 'M_H', 'M_J', 'M_K'}
%%%% ¡postset!
if strcmp(gt.get('OP_M'), 'M_B')
    gt.set( ...
        'OP_P', 'P_B', ...
        'OP_D', 'D_B', ...
        'OP_F', 'F_B', ...
        'OP_G', 'G_B' ...
        )
end    

%%% ¡prop!
OP_P (parameter, option) is a prop parameter option.
%%%% ¡settings!
{'P_A', 'P_B', 'P_C', 'P_D', 'P_E', 'P_F', 'P_G', 'P_H', 'P_J', 'P_K'}
%%%% ¡postset!
if strcmp(gt.get('OP_P'), 'P_C')
    gt.set( ...
        'OP_M', 'M_C', ...
        'OP_D', 'D_C', ...
        'OP_F', 'F_C', ...
        'OP_G', 'G_C' ...
        )
end    

%%% ¡prop!
OP_D (data, option) is a prop data option.
%%%% ¡settings!
{'D_A', 'D_B', 'D_C', 'D_D', 'D_E', 'D_F', 'D_G', 'D_H', 'D_J', 'D_K'}
%%%% ¡postset!
if strcmp(gt.get('OP_D'), 'D_D')
    gt.set( ...
        'OP_M', 'M_D', ...
        'OP_P', 'P_D', ...
        'OP_F', 'F_D', ...
        'OP_G', 'G_D' ...
        )
end

%%% ¡prop!
OP_R (result, option) is a prop result option.
%%%% ¡settings!
{'R_A', 'R_B', 'R_C', 'R_D', 'R_E', 'R_F', 'R_G', 'R_H', 'R_J', 'R_K'}
%%%% ¡calculate!
settings = GTA_OP.getPropSettings('OP_R');
index = randi(length(settings));
value = settings{index};

%%% ¡prop!
OP_Q (query, option) is a prop query option.
%%%% ¡settings!
{'Q_A', 'Q_B', 'Q_C', 'Q_D', 'Q_E', 'Q_F', 'Q_G', 'Q_H', 'Q_J', 'Q_K'}
%%%% ¡calculate!
settings = GTA_OP.getPropSettings('OP_Q');
index = randi(length(settings));
value = settings{index};

%%% ¡prop!
OP_E (evanescent, option) is a prop evanescent option.
%%%% ¡settings!
{'E_A', 'E_B', 'E_C', 'E_D', 'E_E', 'E_F', 'E_G', 'E_H', 'E_J', 'E_K'}
%%%% ¡calculate!
settings = GTA_OP.getPropSettings('OP_E');
index = randi(length(settings));
value = settings{index};

%%% ¡prop!
OP_F (figure, option) is a prop figure option.
%%%% ¡settings!
{'F_A', 'F_B', 'F_C', 'F_D', 'F_E', 'F_F', 'F_G', 'F_H', 'F_J', 'F_K'}
%%%% ¡postset!
if strcmp(gt.get('OP_F'), 'F_E')
    gt.set( ...
        'OP_M', 'M_E', ...
        'OP_P', 'P_E', ...
        'OP_D', 'D_E', ...
        'OP_G', 'G_E' ...
        )
end    

%%% ¡prop!
OP_G (gui, option) is a prop gui option.
%%%% ¡settings!
{'G_A', 'G_B', 'G_C', 'G_D', 'G_E', 'G_F', 'G_G', 'G_H', 'G_J', 'G_K'}
%%%% ¡postset!
if strcmp(gt.get('OP_G'), 'G_F')
    gt.set( ...
        'OP_M', 'M_F', ...
        'OP_P', 'P_F', ...
        'OP_D', 'D_F', ...
        'OP_F', 'F_F' ...
        )
end    

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_OP();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = gt.getPanelProp(GTA_OP.OP_C, 'PARENT', gui);
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = gt.getPanelProp(GTA_OP.OP_M, 'PARENT', gui);
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = gt.getPanelProp(GTA_OP.OP_P, 'PARENT', gui);
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = gt.getPanelProp(GTA_OP.OP_D, 'PARENT', gui);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = gt.getPanelProp(GTA_OP.OP_R, 'PARENT', gui);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = gt.getPanelProp(GTA_OP.OP_Q, 'PARENT', gui);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = gt.getPanelProp(GTA_OP.OP_E, 'PARENT', gui);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = gt.getPanelProp(GTA_OP.OP_F, 'PARENT', gui);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = gt.getPanelProp(GTA_OP.OP_G, 'PARENT', gui);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

assert(isequal(pr_C.get('DROPDOWN').get('Value'), gt.get('OP_C')))

assert(isequal(pr_M.get('DROPDOWN').get('Value'), gt.get('OP_M')))
gt.set('OP_M', 'M_C')
assert(isequal(pr_M.get('DROPDOWN').get('Value'), gt.get('OP_M')))

assert(isequal(pr_P.get('DROPDOWN').get('Value'), gt.get('OP_P')))
gt.set('OP_P', 'P_D')
assert(isequal(pr_P.get('DROPDOWN').get('Value'), gt.get('OP_P')))

assert(isequal(pr_D.get('DROPDOWN').get('Value'), gt.get('OP_D')))
gt.set('OP_D', 'D_E')
assert(isequal(pr_D.get('DROPDOWN').get('Value'), gt.get('OP_D')))

assert(isequal(pr_F.get('DROPDOWN').get('Value'), gt.get('OP_F')))
gt.set('OP_F', 'F_G')
assert(isequal(pr_F.get('DROPDOWN').get('Value'), gt.get('OP_F')))

assert(isequal(pr_G.get('DROPDOWN').get('Value'), gt.get('OP_G')))
gt.set('OP_G', 'G_H')
assert(isequal(pr_G.get('DROPDOWN').get('Value'), gt.get('OP_G')))

assert(isequal(pr_R.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('OP_R')))
gt.get('OP_R')
assert(isequal(pr_R.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('OP_R')))
gt.memorize('OP_R')
assert(isequal(pr_R.get('DROPDOWN').get('Value'), gt.get('OP_R')))

assert(isequal(pr_Q.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('OP_Q')))
gt.get('OP_Q')
assert(isequal(pr_Q.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('OP_Q')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('OP_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_Q.get('DROPDOWN').get('Value'), gt.get('OP_Q')))

assert(isequal(pr_E.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('OP_E')))
warning('off', [BRAPH2.STR ':' class(gt)])
gt.get('OP_E')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(isequal(pr_E.get('DROPDOWN').get('Value'), gt.getPropDefaultConditioned('OP_E')))
gt.memorize('OP_E')
assert(isequal(pr_E.get('DROPDOWN').get('Value'), gt.get('OP_E')))

pr_F.get('CLOSE') % closes all