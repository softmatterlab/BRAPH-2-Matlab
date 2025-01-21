%% ¡header!
ETG_postset_2 < ETG_postset_1 (et, test G postset) tests postset.

%%% ¡description!
ETG_postset_2 tests that postset still uses the previous generation.

%%% ¡build!
1

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Postset
%%%% ¡probability!
.01
%%%% ¡code!
et = ETG_postset_2();
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

et = ETG_postset_2();
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

et = ETG_postset_2();
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

et = ETG_postset_2();
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

et = ETG_postset_2();
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