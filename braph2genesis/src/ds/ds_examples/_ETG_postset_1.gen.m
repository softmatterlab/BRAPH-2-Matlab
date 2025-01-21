%% ¡header!
ETG_postset_1 < ETG_postset_0 (et, test G postset) tests postset.

%%% ¡description!
ETG_postset_1 tests the update of postset.

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
OP_M (metadata, option) is a prop metadata option.
%%%% ¡settings!
{'M_a', 'M_b', 'M_c', 'M_d', 'M_e', 'M_f', 'M_g'}
%%%% ¡postset!
if strcmp(et.get('OP_M'), 'M_b')
    et.set( ...
        'OP_P', 'P_b', ...
        'OP_D', 'D_b', ...
        'OP_F', 'F_b', ...
        'OP_G', 'G_b' ...
        )
end    

%%% ¡prop!
OP_P (parameter, option) is a prop parameter option.
%%%% ¡settings!
{'P_a', 'P_b', 'P_c', 'P_d', 'P_e', 'P_f', 'P_g'}
%%%% ¡postset!
if strcmp(et.get('OP_P'), 'P_c')
    et.set( ...
        'OP_M', 'M_c', ...
        'OP_D', 'D_c', ...
        'OP_F', 'F_c', ...
        'OP_G', 'G_c' ...
        )
end    

%%% ¡prop!
OP_D (data, option) is a prop data option.
%%%% ¡settings!
{'D_a', 'D_b', 'D_c', 'D_d', 'D_e', 'D_f', 'D_g'}
%%%% ¡postset!
if strcmp(et.get('OP_D'), 'D_d')
    et.set( ...
        'OP_M', 'M_d', ...
        'OP_P', 'P_d', ...
        'OP_F', 'F_d', ...
        'OP_G', 'G_d' ...
        )
end

%%% ¡prop!
OP_F (figure, option) is a prop figure option.
%%%% ¡settings!
{'F_a', 'F_b', 'F_c', 'F_d', 'F_e', 'F_f', 'F_g'}
%%%% ¡postset!
if strcmp(et.get('OP_F'), 'F_e')
    et.set( ...
        'OP_M', 'M_e', ...
        'OP_P', 'P_e', ...
        'OP_D', 'D_e', ...
        'OP_G', 'G_e' ...
        )
end    

%%% ¡prop!
OP_G (gui, option) is a prop gui option.
%%%% ¡settings!
{'G_a', 'G_b', 'G_c', 'G_d', 'G_e', 'G_f', 'G_g'}
%%%% ¡postset!
if strcmp(et.get('OP_G'), 'G_f')
    et.set( ...
        'OP_M', 'M_f', ...
        'OP_P', 'P_f', ...
        'OP_D', 'D_f', ...
        'OP_F', 'F_f' ...
        )
end 

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Postset
%%%% ¡probability!
.01
%%%% ¡code!
et = ETG_postset_1();
et.set('OP_M', 'M_a')
assert(strcmp(et.get('OP_M'), 'M_a'))
assert(strcmp(et.get('OP_P'), 'P_a'))
assert(strcmp(et.get('OP_D'), 'D_a'))
assert(strcmp(et.get('OP_F'), 'F_a'))
assert(strcmp(et.get('OP_G'), 'G_a'))
et.set('OP_M', 'M_b')
assert(strcmp(et.get('OP_M'), 'M_b'))
assert(strcmp(et.get('OP_P'), 'P_b'))
assert(strcmp(et.get('OP_D'), 'D_b'))
assert(strcmp(et.get('OP_F'), 'F_b'))
assert(strcmp(et.get('OP_G'), 'G_b'))
et.set('OP_M', 'M_c')
assert(strcmp(et.get('OP_M'), 'M_c'))
assert(strcmp(et.get('OP_P'), 'P_b'))
assert(strcmp(et.get('OP_D'), 'D_b'))
assert(strcmp(et.get('OP_F'), 'F_b'))
assert(strcmp(et.get('OP_G'), 'G_b'))

et = ETG_postset_1();
et.set('OP_P', 'P_b')
assert(strcmp(et.get('OP_M'), 'M_a'))
assert(strcmp(et.get('OP_P'), 'P_b'))
assert(strcmp(et.get('OP_D'), 'D_a'))
assert(strcmp(et.get('OP_F'), 'F_a'))
assert(strcmp(et.get('OP_G'), 'G_a'))
et.set('OP_P', 'P_c')
assert(strcmp(et.get('OP_M'), 'M_c'))
assert(strcmp(et.get('OP_P'), 'P_c'))
assert(strcmp(et.get('OP_D'), 'D_c'))
assert(strcmp(et.get('OP_F'), 'F_c'))
assert(strcmp(et.get('OP_G'), 'G_c'))
et.set('OP_P', 'P_d')
assert(strcmp(et.get('OP_M'), 'M_c'))
assert(strcmp(et.get('OP_P'), 'P_d'))
assert(strcmp(et.get('OP_D'), 'D_c'))
assert(strcmp(et.get('OP_F'), 'F_c'))
assert(strcmp(et.get('OP_G'), 'G_c'))

et = ETG_postset_1();
et.set('OP_D', 'D_c')
assert(strcmp(et.get('OP_M'), 'M_a'))
assert(strcmp(et.get('OP_P'), 'P_a'))
assert(strcmp(et.get('OP_D'), 'D_c'))
assert(strcmp(et.get('OP_F'), 'F_a'))
assert(strcmp(et.get('OP_G'), 'G_a'))
et.set('OP_D', 'D_d')
assert(strcmp(et.get('OP_M'), 'M_d'))
assert(strcmp(et.get('OP_P'), 'P_d'))
assert(strcmp(et.get('OP_D'), 'D_d'))
assert(strcmp(et.get('OP_F'), 'F_d'))
assert(strcmp(et.get('OP_G'), 'G_d'))
et.set('OP_D', 'D_e')
assert(strcmp(et.get('OP_M'), 'M_d'))
assert(strcmp(et.get('OP_P'), 'P_d'))
assert(strcmp(et.get('OP_D'), 'D_e'))
assert(strcmp(et.get('OP_F'), 'F_d'))
assert(strcmp(et.get('OP_G'), 'G_d'))

et = ETG_postset_1();
et.set('OP_F', 'F_d')
assert(strcmp(et.get('OP_M'), 'M_a'))
assert(strcmp(et.get('OP_P'), 'P_a'))
assert(strcmp(et.get('OP_D'), 'D_a'))
assert(strcmp(et.get('OP_F'), 'F_d'))
assert(strcmp(et.get('OP_G'), 'G_a'))
et.set('OP_F', 'F_e')
assert(strcmp(et.get('OP_M'), 'M_e'))
assert(strcmp(et.get('OP_P'), 'P_e'))
assert(strcmp(et.get('OP_D'), 'D_e'))
assert(strcmp(et.get('OP_F'), 'F_e'))
assert(strcmp(et.get('OP_G'), 'G_e'))
et.set('OP_F', 'F_f')
assert(strcmp(et.get('OP_M'), 'M_e'))
assert(strcmp(et.get('OP_P'), 'P_e'))
assert(strcmp(et.get('OP_D'), 'D_e'))
assert(strcmp(et.get('OP_F'), 'F_f'))
assert(strcmp(et.get('OP_G'), 'G_e'))

et = ETG_postset_1();
et.set('OP_G', 'G_e')
assert(strcmp(et.get('OP_M'), 'M_a'))
assert(strcmp(et.get('OP_P'), 'P_a'))
assert(strcmp(et.get('OP_D'), 'D_a'))
assert(strcmp(et.get('OP_F'), 'F_a'))
assert(strcmp(et.get('OP_G'), 'G_e'))
et.set('OP_G', 'G_f')
assert(strcmp(et.get('OP_M'), 'M_f'))
assert(strcmp(et.get('OP_P'), 'P_f'))
assert(strcmp(et.get('OP_D'), 'D_f'))
assert(strcmp(et.get('OP_F'), 'F_f'))
assert(strcmp(et.get('OP_G'), 'G_f'))
et.set('OP_G', 'G_g')
assert(strcmp(et.get('OP_M'), 'M_f'))
assert(strcmp(et.get('OP_P'), 'P_f'))
assert(strcmp(et.get('OP_D'), 'D_f'))
assert(strcmp(et.get('OP_F'), 'F_f'))
assert(strcmp(et.get('OP_G'), 'G_g'))