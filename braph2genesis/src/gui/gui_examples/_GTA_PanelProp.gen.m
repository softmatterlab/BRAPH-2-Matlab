%% ¡header!
GTA_PanelProp < ConcreteElement (gt, test A PanelProp) tests PanelProp.

%%% ¡description!
GTA_PanelProp tests PanelProp.

%%% ¡seealso!
PanelProp

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
ST_C (constant, string) is a prop constant string.

%%% ¡prop!
ST_M (metadata, string) is a prop metadata string.

%%% ¡prop!
ST_P (parameter, string) is a prop parameter string.

%%% ¡prop!
ST_D (data, string) is a prop data string.

%%% ¡prop!
ST_R (result, string) is a prop result string.

%%% ¡prop!
ST_Q (query, string) is a prop query string.

%%% ¡prop!
ST_E (evanescent, string) is a prop evanescent string.

%%% ¡prop!
ST_F (figure, string) is a prop figure string.

%%% ¡prop!
ST_G (gui, string) is a prop gui string.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Buttons & Listener Graphics
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_PanelProp();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_C, 'BKGCOLOR', BRAPH2.COL_C);
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])
assert(check_graphics(pr_C.getr('H'), 'uipanel'))
assert(check_graphics(pr_C.getr('PARENT').getr('H'), 'figure'))
assert(check_graphics(pr_C.getr('LABEL_TITLE'), 'uilabel'))
assert(~check_graphics(pr_C.getr('BUTTON_CB'), 'uibutton'))
assert(~check_graphics(pr_C.getr('BUTTON_CALC'), 'uibutton'))
assert(~check_graphics(pr_C.getr('BUTTON_DEL'), 'uibutton'))    
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_C.getr('LISTENER_SET'))))
assert(isa(pr_C.getr('LISTENER_MEMORIZED'), 'NoValue'))    
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_C.getr('LISTENER_LOCKED'))))

pr_M = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_M, 'BKGCOLOR', BRAPH2.COL_M);
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])
assert(check_graphics(pr_M.getr('H'), 'uipanel'))
assert(check_graphics(pr_M.getr('PARENT').getr('H'), 'figure'))
assert(check_graphics(pr_M.getr('LABEL_TITLE'), 'uilabel'))
assert(~check_graphics(pr_M.getr('BUTTON_CB'), 'uibutton'))
assert(~check_graphics(pr_M.getr('BUTTON_CALC'), 'uibutton'))
assert(~check_graphics(pr_M.getr('BUTTON_DEL'), 'uibutton'))
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_M.getr('LISTENER_SET'))))
assert(isa(pr_M.getr('LISTENER_MEMORIZED'), 'NoValue'))    
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_M.getr('LISTENER_LOCKED'))))

pr_P = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_P, 'BKGCOLOR', BRAPH2.COL_P);
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])
assert(check_graphics(pr_P.getr('H'), 'uipanel'))
assert(check_graphics(pr_P.getr('PARENT').getr('H'), 'figure'))
assert(check_graphics(pr_P.getr('LABEL_TITLE'), 'uilabel'))
assert(check_graphics(pr_P.getr('BUTTON_CB'), 'uibutton'))
assert(~check_graphics(pr_P.getr('BUTTON_CALC'), 'uibutton'))
assert(~check_graphics(pr_P.getr('BUTTON_DEL'), 'uibutton'))    
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_P.getr('LISTENER_SET'))))
assert(isa(pr_P.getr('LISTENER_MEMORIZED'), 'NoValue'))    
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_P.getr('LISTENER_LOCKED'))))

pr_D = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_D, 'BKGCOLOR', BRAPH2.COL_D);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])
assert(check_graphics(pr_D.getr('H'), 'uipanel'))
assert(check_graphics(pr_D.getr('PARENT').getr('H'), 'figure'))
assert(check_graphics(pr_D.getr('LABEL_TITLE'), 'uilabel'))
assert(check_graphics(pr_D.getr('BUTTON_CB'), 'uibutton'))
assert(~check_graphics(pr_D.getr('BUTTON_CALC'), 'uibutton'))
assert(~check_graphics(pr_D.getr('BUTTON_DEL'), 'uibutton'))
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_D.getr('LISTENER_SET'))))
assert(isa(pr_D.getr('LISTENER_MEMORIZED'), 'NoValue'))
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_D.getr('LISTENER_LOCKED'))))

pr_R = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_R, 'BKGCOLOR', BRAPH2.COL_R);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])
assert(check_graphics(pr_R.getr('H'), 'uipanel'))
assert(check_graphics(pr_R.getr('PARENT').getr('H'), 'figure'))    
assert(check_graphics(pr_R.getr('LABEL_TITLE'), 'uilabel'))
assert(~check_graphics(pr_R.getr('BUTTON_CB'), 'uibutton'))
assert(check_graphics(pr_R.getr('BUTTON_CALC'), 'uibutton'))
assert(check_graphics(pr_R.getr('BUTTON_DEL'), 'uibutton'))    
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_R.getr('LISTENER_SET'))))
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_R.getr('LISTENER_MEMORIZED'))))
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_R.getr('LISTENER_LOCKED'))))

pr_Q = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_Q, 'BKGCOLOR', BRAPH2.COL_Q);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])
assert(check_graphics(pr_Q.getr('H'), 'uipanel'))
assert(check_graphics(pr_Q.getr('PARENT').getr('H'), 'figure'))
assert(check_graphics(pr_Q.getr('LABEL_TITLE'), 'uilabel'))
assert(~check_graphics(pr_Q.getr('BUTTON_CB'), 'uibutton'))
assert(check_graphics(pr_Q.getr('BUTTON_CALC'), 'uibutton'))
assert(check_graphics(pr_Q.getr('BUTTON_DEL'), 'uibutton'))    
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_Q.getr('LISTENER_SET'))))
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_Q.getr('LISTENER_MEMORIZED'))))
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_Q.getr('LISTENER_LOCKED'))))

pr_E = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_E, 'BKGCOLOR', BRAPH2.COL_E);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])
assert(check_graphics(pr_E.getr('H'), 'uipanel'))
assert(check_graphics(pr_E.getr('PARENT').getr('H'), 'figure'))
assert(check_graphics(pr_E.getr('LABEL_TITLE'), 'uilabel'))
assert(~check_graphics(pr_E.getr('BUTTON_CB'), 'uibutton'))
assert(check_graphics(pr_E.getr('BUTTON_CALC'), 'uibutton'))
assert(check_graphics(pr_E.getr('BUTTON_DEL'), 'uibutton'))
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_E.getr('LISTENER_SET'))))
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_E.getr('LISTENER_MEMORIZED'))))
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_E.getr('LISTENER_LOCKED'))))

pr_F = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_F, 'BKGCOLOR', BRAPH2.COL_F);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])
assert(check_graphics(pr_F.getr('H'), 'uipanel'))
assert(check_graphics(pr_F.getr('PARENT').getr('H'), 'figure'))
assert(check_graphics(pr_F.getr('LABEL_TITLE'), 'uilabel'))
assert(check_graphics(pr_F.getr('BUTTON_CB'), 'uibutton'))
assert(~check_graphics(pr_F.getr('BUTTON_CALC'), 'uibutton'))
assert(~check_graphics(pr_F.getr('BUTTON_DEL'), 'uibutton'))    
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_F.getr('LISTENER_SET'))))
assert(isa(pr_F.getr('LISTENER_MEMORIZED'), 'NoValue'))
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_F.getr('LISTENER_LOCKED'))))

pr_G = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_G, 'BKGCOLOR', BRAPH2.COL_G);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])
assert(check_graphics(pr_G.getr('H'), 'uipanel'))
assert(check_graphics(pr_G.getr('PARENT').getr('H'), 'figure'))
assert(check_graphics(pr_G.getr('LABEL_TITLE'), 'uilabel'))
assert(check_graphics(pr_G.getr('BUTTON_CB'), 'uibutton'))
assert(~check_graphics(pr_G.getr('BUTTON_CALC'), 'uibutton'))
assert(~check_graphics(pr_G.getr('BUTTON_DEL'), 'uibutton'))    
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_G.getr('LISTENER_SET'))))
assert(isa(pr_G.getr('LISTENER_MEMORIZED'), 'NoValue'))    
assert(all(cellfun(@(x) isa(x, 'event.listener'), pr_G.getr('LISTENER_LOCKED'))))

pr_C.get('SHOW') % shows all

pr_P.get('HIDE') % hides all

pr_R.get('SHOW') % shows all

pr_F.get('CLOSE') % closes all

assert(~check_graphics(pr_C.getr('H'), 'uipanel'))
assert(~check_graphics(pr_C.getr('PARENT').getr('H'), 'figure'))
assert(~check_graphics(pr_C.getr('LABEL_TITLE'), 'uilabel'))
assert(~check_graphics(pr_C.getr('BUTTON_CB'), 'uibutton'))
assert(~check_graphics(pr_C.getr('BUTTON_CALC'), 'uibutton'))
assert(~check_graphics(pr_C.getr('BUTTON_DEL'), 'uibutton'))    
assert(isa(pr_C.getr('LISTENER_SET'), 'NoValue'))
assert(isa(pr_C.getr('LISTENER_MEMORIZED'), 'NoValue'))    
assert(isa(pr_C.getr('LISTENER_LOCKED'), 'NoValue'))

assert(~check_graphics(pr_M.getr('H'), 'uipanel'))
assert(~check_graphics(pr_M.getr('PARENT').getr('H'), 'figure'))
assert(~check_graphics(pr_M.getr('LABEL_TITLE'), 'uilabel'))
assert(~check_graphics(pr_M.getr('BUTTON_CB'), 'uibutton'))
assert(~check_graphics(pr_M.getr('BUTTON_CALC'), 'uibutton'))
assert(~check_graphics(pr_M.getr('BUTTON_DEL'), 'uibutton'))
assert(isa(pr_M.getr('LISTENER_SET'), 'NoValue'))    
assert(isa(pr_M.getr('LISTENER_MEMORIZED'), 'NoValue'))    
assert(isa(pr_M.getr('LISTENER_LOCKED'), 'NoValue'))

assert(~check_graphics(pr_P.getr('H'), 'uipanel'))
assert(~check_graphics(pr_P.getr('PARENT').getr('H'), 'figure'))
assert(~check_graphics(pr_P.getr('LABEL_TITLE'), 'uilabel'))
assert(~check_graphics(pr_P.getr('BUTTON_CB'), 'uibutton'))
assert(~check_graphics(pr_P.getr('BUTTON_CALC'), 'uibutton'))
assert(~check_graphics(pr_P.getr('BUTTON_DEL'), 'uibutton'))    
assert(isa(pr_P.getr('LISTENER_SET'), 'NoValue'))    
assert(isa(pr_P.getr('LISTENER_MEMORIZED'), 'NoValue'))    
assert(isa(pr_P.getr('LISTENER_LOCKED'), 'NoValue'))

assert(~check_graphics(pr_D.getr('H'), 'uipanel'))
assert(~check_graphics(pr_D.getr('PARENT').getr('H'), 'figure'))
assert(~check_graphics(pr_D.getr('LABEL_TITLE'), 'uilabel'))
assert(~check_graphics(pr_D.getr('BUTTON_CB'), 'uibutton'))
assert(~check_graphics(pr_D.getr('BUTTON_CALC'), 'uibutton'))
assert(~check_graphics(pr_D.getr('BUTTON_DEL'), 'uibutton'))
assert(isa(pr_D.getr('LISTENER_SET'), 'NoValue'))    
assert(isa(pr_D.getr('LISTENER_MEMORIZED'), 'NoValue'))
assert(isa(pr_D.getr('LISTENER_LOCKED'), 'NoValue'))

assert(~check_graphics(pr_R.getr('H'), 'uipanel'))
assert(~check_graphics(pr_R.getr('PARENT').getr('H'), 'figure'))    
assert(~check_graphics(pr_R.getr('LABEL_TITLE'), 'uilabel'))
assert(~check_graphics(pr_R.getr('BUTTON_CB'), 'uibutton'))
assert(~check_graphics(pr_R.getr('BUTTON_CALC'), 'uibutton'))
assert(~check_graphics(pr_R.getr('BUTTON_DEL'), 'uibutton'))    
assert(isa(pr_R.getr('LISTENER_SET'), 'NoValue'))    
assert(isa(pr_R.getr('LISTENER_MEMORIZED'), 'NoValue'))    
assert(isa(pr_R.getr('LISTENER_LOCKED'), 'NoValue'))

assert(~check_graphics(pr_Q.getr('H'), 'uipanel'))
assert(~check_graphics(pr_Q.getr('PARENT').getr('H'), 'figure'))
assert(~check_graphics(pr_Q.getr('LABEL_TITLE'), 'uilabel'))
assert(~check_graphics(pr_Q.getr('BUTTON_CB'), 'uibutton'))
assert(~check_graphics(pr_Q.getr('BUTTON_CALC'), 'uibutton'))
assert(~check_graphics(pr_Q.getr('BUTTON_DEL'), 'uibutton'))    
assert(isa(pr_Q.getr('LISTENER_SET'), 'NoValue'))    
assert(isa(pr_Q.getr('LISTENER_MEMORIZED'), 'NoValue'))    
assert(isa(pr_Q.getr('LISTENER_LOCKED'), 'NoValue'))

assert(~check_graphics(pr_E.getr('H'), 'uipanel'))
assert(~check_graphics(pr_E.getr('PARENT').getr('H'), 'figure'))
assert(~check_graphics(pr_E.getr('LABEL_TITLE'), 'uilabel'))
assert(~check_graphics(pr_E.getr('BUTTON_CB'), 'uibutton'))
assert(~check_graphics(pr_E.getr('BUTTON_CALC'), 'uibutton'))
assert(~check_graphics(pr_E.getr('BUTTON_DEL'), 'uibutton'))
assert(isa(pr_E.getr('LISTENER_SET'), 'NoValue'))    
assert(isa(pr_E.getr('LISTENER_MEMORIZED'), 'NoValue'))    
assert(isa(pr_E.getr('LISTENER_LOCKED'), 'NoValue'))

assert(~check_graphics(pr_F.getr('H'), 'uipanel'))
assert(~check_graphics(pr_F.getr('PARENT').getr('H'), 'figure'))
assert(~check_graphics(pr_F.getr('LABEL_TITLE'), 'uilabel'))
assert(~check_graphics(pr_F.getr('BUTTON_CB'), 'uibutton'))
assert(~check_graphics(pr_F.getr('BUTTON_CALC'), 'uibutton'))
assert(~check_graphics(pr_F.getr('BUTTON_DEL'), 'uibutton'))    
assert(isa(pr_F.getr('LISTENER_SET'), 'NoValue'))    
assert(isa(pr_F.getr('LISTENER_MEMORIZED'), 'NoValue'))    
assert(isa(pr_F.getr('LISTENER_LOCKED'), 'NoValue'))

assert(~check_graphics(pr_G.getr('H'), 'uipanel'))
assert(~check_graphics(pr_G.getr('PARENT').getr('H'), 'figure'))
assert(~check_graphics(pr_G.getr('LABEL_TITLE'), 'uilabel'))
assert(~check_graphics(pr_G.getr('BUTTON_CB'), 'uibutton'))
assert(~check_graphics(pr_G.getr('BUTTON_CALC'), 'uibutton'))
assert(~check_graphics(pr_G.getr('BUTTON_DEL'), 'uibutton'))    
assert(isa(pr_G.getr('LISTENER_SET'), 'NoValue'))    
assert(isa(pr_G.getr('LISTENER_MEMORIZED'), 'NoValue'))    
assert(isa(pr_G.getr('LISTENER_LOCKED'), 'NoValue'))

%%% ¡test!
%%%% ¡name!
Button & Listener Dynamics
%%%% ¡probability!
.01
%%%% ¡code!
gt = GTA_PanelProp();
gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);

pr_C = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_C, 'BKGCOLOR', BRAPH2.COL_C);
pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])

pr_M = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_M, 'BKGCOLOR', BRAPH2.COL_M);
pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])

pr_P = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_P, 'BKGCOLOR', BRAPH2.COL_P);
pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])

pr_D = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_D, 'BKGCOLOR', BRAPH2.COL_D);
pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])

pr_R = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_R, 'BKGCOLOR', BRAPH2.COL_R);
pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])

pr_Q = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_Q, 'BKGCOLOR', BRAPH2.COL_Q);
pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])

pr_E = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_E, 'BKGCOLOR', BRAPH2.COL_E);
pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])

pr_F = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_F, 'BKGCOLOR', BRAPH2.COL_F);
pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])

pr_G = PanelProp('PARENT', gui, 'EL', gt, 'PROP', gt.ST_G, 'BKGCOLOR', BRAPH2.COL_G);
pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])

pr_C.get('SHOW') % shows all

% set
label_title_C = pr_C.get('LABEL_TITLE');
assert(~isequal(get(label_title_C, 'Position'), [0 0 0 0]))
set(label_title_C, 'Position', [0 0 0 0])
assert(isequal(get(label_title_C, 'Position'), [0 0 0 0]))

label_title_M = pr_M.get('LABEL_TITLE');
assert(~isequal(get(label_title_M, 'Position'), [0 0 0 0]))
set(label_title_M, 'Position', [0 0 0 0])
assert(isequal(get(label_title_M, 'Position'), [0 0 0 0]))

label_title_P = pr_P.get('LABEL_TITLE');
assert(~isequal(get(label_title_P, 'Position'), [0 0 0 0]))
set(label_title_P, 'Position', [0 0 0 0])
assert(isequal(get(label_title_P, 'Position'), [0 0 0 0]))

label_title_D = pr_D.get('LABEL_TITLE');
assert(~isequal(get(label_title_D, 'Position'), [0 0 0 0]))
set(label_title_D, 'Position', [0 0 0 0])
assert(isequal(get(label_title_D, 'Position'), [0 0 0 0]))

label_title_R = pr_R.get('LABEL_TITLE');
assert(~isequal(get(label_title_R, 'Position'), [0 0 0 0]))
set(label_title_R, 'Position', [0 0 0 0])
assert(isequal(get(label_title_R, 'Position'), [0 0 0 0]))

label_title_Q = pr_Q.get('LABEL_TITLE');
assert(~isequal(get(label_title_Q, 'Position'), [0 0 0 0]))
set(label_title_Q, 'Position', [0 0 0 0])
assert(isequal(get(label_title_Q, 'Position'), [0 0 0 0]))

label_title_E = pr_E.get('LABEL_TITLE');
assert(~isequal(get(label_title_E, 'Position'), [0 0 0 0]))
set(label_title_E, 'Position', [0 0 0 0])
assert(isequal(get(label_title_E, 'Position'), [0 0 0 0]))

label_title_F = pr_F.get('LABEL_TITLE');
assert(~isequal(get(label_title_F, 'Position'), [0 0 0 0]))
set(label_title_F, 'Position', [0 0 0 0])
assert(isequal(get(label_title_F, 'Position'), [0 0 0 0]))

label_title_G = pr_G.get('LABEL_TITLE');
assert(~isequal(get(label_title_G, 'Position'), [0 0 0 0]))
set(label_title_G, 'Position', [0 0 0 0])
assert(isequal(get(label_title_G, 'Position'), [0 0 0 0]))

gt.set('ST_C', Element.getNoValue())
assert(~isequal(get(label_title_C, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_M, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_P, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_D, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_R, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_Q, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_E, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_F, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_G, 'Position'), [0 0 0 0]))

gt.set('ST_M', '12345')
assert(~isequal(get(label_title_C, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_M, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_P, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_D, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_R, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_Q, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_E, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_F, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_G, 'Position'), [0 0 0 0]))

gt.set('ST_P', '1234')
assert(~isequal(get(label_title_C, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_M, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_P, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_D, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_R, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_Q, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_E, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_F, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_G, 'Position'), [0 0 0 0]))

gt.set('ST_D', '123456')
assert(~isequal(get(label_title_C, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_M, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_P, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_D, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_R, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_Q, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_E, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_F, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_G, 'Position'), [0 0 0 0]))

gt.set('ST_R', Element.getNoValue())
assert(~isequal(get(label_title_R, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_M, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_P, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_D, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_R, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_Q, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_E, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_F, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_G, 'Position'), [0 0 0 0]))

gt.set('ST_Q', Element.getNoValue())
assert(~isequal(get(label_title_C, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_M, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_P, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_D, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_R, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_Q, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_E, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_F, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_G, 'Position'), [0 0 0 0]))

gt.set('ST_E', Element.getNoValue())
assert(~isequal(get(label_title_C, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_M, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_P, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_D, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_R, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_Q, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_E, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_F, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_G, 'Position'), [0 0 0 0]))

gt.set('ST_F', '1234')
assert(~isequal(get(label_title_C, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_M, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_P, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_D, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_R, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_Q, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_E, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_F, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_G, 'Position'), [0 0 0 0]))

gt.set('ST_G', '1234')
assert(~isequal(get(label_title_C, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_M, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_P, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_D, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_R, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_Q, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_E, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_F, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_G, 'Position'), [0 0 0 0]))

% memorize & locked
label_title_C = pr_C.get('LABEL_TITLE');
assert(~isequal(get(label_title_C, 'Position'), [0 0 0 0]))
set(label_title_C, 'Position', [0 0 0 0])
assert(isequal(get(label_title_C, 'Position'), [0 0 0 0]))

label_title_M = pr_M.get('LABEL_TITLE');
assert(~isequal(get(label_title_M, 'Position'), [0 0 0 0]))
set(label_title_M, 'Position', [0 0 0 0])
assert(isequal(get(label_title_M, 'Position'), [0 0 0 0]))

label_title_P = pr_P.get('LABEL_TITLE');
assert(~isequal(get(label_title_P, 'Position'), [0 0 0 0]))
set(label_title_P, 'Position', [0 0 0 0])
assert(isequal(get(label_title_P, 'Position'), [0 0 0 0]))

label_title_D = pr_D.get('LABEL_TITLE');
assert(~isequal(get(label_title_D, 'Position'), [0 0 0 0]))
set(label_title_D, 'Position', [0 0 0 0])
assert(isequal(get(label_title_D, 'Position'), [0 0 0 0]))

label_title_R = pr_R.get('LABEL_TITLE');
assert(~isequal(get(label_title_R, 'Position'), [0 0 0 0]))
set(label_title_R, 'Position', [0 0 0 0])
assert(isequal(get(label_title_R, 'Position'), [0 0 0 0]))

label_title_Q = pr_Q.get('LABEL_TITLE');
assert(~isequal(get(label_title_Q, 'Position'), [0 0 0 0]))
set(label_title_Q, 'Position', [0 0 0 0])
assert(isequal(get(label_title_Q, 'Position'), [0 0 0 0]))

label_title_E = pr_E.get('LABEL_TITLE');
assert(~isequal(get(label_title_E, 'Position'), [0 0 0 0]))
set(label_title_E, 'Position', [0 0 0 0])
assert(isequal(get(label_title_E, 'Position'), [0 0 0 0]))

label_title_F = pr_F.get('LABEL_TITLE');
assert(~isequal(get(label_title_F, 'Position'), [0 0 0 0]))
set(label_title_F, 'Position', [0 0 0 0])
assert(isequal(get(label_title_F, 'Position'), [0 0 0 0]))

label_title_G = pr_G.get('LABEL_TITLE');
assert(~isequal(get(label_title_G, 'Position'), [0 0 0 0]))
set(label_title_G, 'Position', [0 0 0 0])
assert(isequal(get(label_title_G, 'Position'), [0 0 0 0]))

button_calc_R = pr_R.get('BUTTON_CALC');
assert(~isequal(get(button_calc_R, 'Position'), [0 0 0 0]))
set(button_calc_R, 'Position', [0 0 0 0])
assert(isequal(get(button_calc_R, 'Position'), [0 0 0 0]))
button_del_R = pr_R.get('BUTTON_DEL');
assert(~isequal(get(button_del_R, 'Position'), [0 0 0 0]))
set(button_del_R, 'Position', [0 0 0 0])
assert(isequal(get(button_del_R, 'Position'), [0 0 0 0])) 

button_calc_Q = pr_Q.get('BUTTON_CALC');
assert(~isequal(get(button_calc_Q, 'Position'), [0 0 0 0]))
set(button_calc_Q, 'Position', [0 0 0 0])
assert(isequal(get(button_calc_Q, 'Position'), [0 0 0 0]))
button_del_Q = pr_Q.get('BUTTON_DEL');
assert(~isequal(get(button_del_Q, 'Position'), [0 0 0 0]))
set(button_del_Q, 'Position', [0 0 0 0])
assert(isequal(get(button_del_Q, 'Position'), [0 0 0 0]))

button_calc_E = pr_E.get('BUTTON_CALC');
assert(~isequal(get(button_calc_E, 'Position'), [0 0 0 0]))
set(button_calc_E, 'Position', [0 0 0 0])
assert(isequal(get(button_calc_E, 'Position'), [0 0 0 0]))
button_del_E = pr_E.get('BUTTON_DEL');
assert(~isequal(get(button_del_E, 'Position'), [0 0 0 0]))
set(button_del_E, 'Position', [0 0 0 0])
assert(isequal(get(button_del_E, 'Position'), [0 0 0 0]))

gt.memorize('ST_R') % also locks P and D
assert(~isequal(get(button_calc_R, 'Position'), [0 0 0 0]))
assert(~isequal(get(button_del_R, 'Position'), [0 0 0 0]))
assert(isequal(get(button_calc_Q, 'Position'), [0 0 0 0]))
assert(isequal(get(button_del_Q, 'Position'), [0 0 0 0]))
assert(isequal(get(button_calc_E, 'Position'), [0 0 0 0]))
assert(isequal(get(button_del_E, 'Position'), [0 0 0 0]))

assert(isequal(get(label_title_C, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_M, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_P, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_D, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_R, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_Q, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_E, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_F, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_G, 'Position'), [0 0 0 0]))

warning('off', [BRAPH2.STR ':' class(gt)])
gt.memorize('ST_Q')
warning('on', [BRAPH2.STR ':' class(gt)])
assert(~isequal(get(button_calc_R, 'Position'), [0 0 0 0]))
assert(~isequal(get(button_del_R, 'Position'), [0 0 0 0]))
assert(~isequal(get(button_calc_Q, 'Position'), [0 0 0 0]))
assert(~isequal(get(button_del_Q, 'Position'), [0 0 0 0]))
assert(isequal(get(button_calc_E, 'Position'), [0 0 0 0]))
assert(isequal(get(button_del_E, 'Position'), [0 0 0 0]))

assert(isequal(get(label_title_C, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_M, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_P, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_D, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_R, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_Q, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_E, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_F, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_G, 'Position'), [0 0 0 0]))

gt.memorize('ST_E')
assert(~isequal(get(button_calc_R, 'Position'), [0 0 0 0]))
assert(~isequal(get(button_del_R, 'Position'), [0 0 0 0]))
assert(~isequal(get(button_calc_Q, 'Position'), [0 0 0 0]))
assert(~isequal(get(button_del_Q, 'Position'), [0 0 0 0]))
assert(~isequal(get(button_calc_E, 'Position'), [0 0 0 0]))
assert(~isequal(get(button_del_E, 'Position'), [0 0 0 0]))

assert(isequal(get(label_title_C, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_M, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_P, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_D, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_R, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_Q, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_E, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_F, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_G, 'Position'), [0 0 0 0]))

gt.lock('ST_F')
assert(isequal(get(label_title_C, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_M, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_P, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_D, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_R, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_Q, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_E, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_F, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_G, 'Position'), [0 0 0 0]))

gt.lock('ST_G')
assert(isequal(get(label_title_C, 'Position'), [0 0 0 0]))
assert(isequal(get(label_title_M, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_P, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_D, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_R, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_Q, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_E, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_F, 'Position'), [0 0 0 0]))
assert(~isequal(get(label_title_G, 'Position'), [0 0 0 0]))

pr_F.get('CLOSE') % closes all