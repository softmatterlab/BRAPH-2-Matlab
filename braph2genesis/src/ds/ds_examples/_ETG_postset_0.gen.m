%% ¡header!
ETG_postset_0 < ConcreteElement (et, test G postset) tests postset.

%%% ¡description!
ETG_postset_0 tests the use of postset.

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
OP_M (metadata, option) is a prop metadata option.
%%%% ¡settings!
{'M_A', 'M_B', 'M_C', 'M_D', 'M_E', 'M_F', 'M_G', 'M_H', 'M_J', 'M_K'}
%%%% ¡postset!
if strcmp(et.get('OP_M'), 'M_B')
    et.set( ...
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
if strcmp(et.get('OP_P'), 'P_C')
    et.set( ...
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
if strcmp(et.get('OP_D'), 'D_D')
    et.set( ...
        'OP_M', 'M_D', ...
        'OP_P', 'P_D', ...
        'OP_F', 'F_D', ...
        'OP_G', 'G_D' ...
        )
end

%%% ¡prop!
OP_F (figure, option) is a prop figure option.
%%%% ¡settings!
{'F_A', 'F_B', 'F_C', 'F_D', 'F_E', 'F_F', 'F_G', 'F_H', 'F_J', 'F_K'}
%%%% ¡postset!
if strcmp(et.get('OP_F'), 'F_E')
    et.set( ...
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
if strcmp(et.get('OP_G'), 'G_F')
    et.set( ...
        'OP_M', 'M_F', ...
        'OP_P', 'P_F', ...
        'OP_D', 'D_F', ...
        'OP_F', 'F_F' ...
        )
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Postset
%%%% ¡probability!
.01
%%%% ¡code!
et = ETG_postset_0();
et.set('OP_M', 'M_A')
assert(strcmp(et.get('OP_M'), 'M_A'))
assert(strcmp(et.get('OP_P'), 'P_A'))
assert(strcmp(et.get('OP_D'), 'D_A'))
assert(strcmp(et.get('OP_F'), 'F_A'))
assert(strcmp(et.get('OP_G'), 'G_A'))
et.set('OP_M', 'M_B')
assert(strcmp(et.get('OP_M'), 'M_B'))
assert(strcmp(et.get('OP_P'), 'P_B'))
assert(strcmp(et.get('OP_D'), 'D_B'))
assert(strcmp(et.get('OP_F'), 'F_B'))
assert(strcmp(et.get('OP_G'), 'G_B'))
et.set('OP_M', 'M_C')
assert(strcmp(et.get('OP_M'), 'M_C'))
assert(strcmp(et.get('OP_P'), 'P_B'))
assert(strcmp(et.get('OP_D'), 'D_B'))
assert(strcmp(et.get('OP_F'), 'F_B'))
assert(strcmp(et.get('OP_G'), 'G_B'))

et = ETG_postset_0();
et.set('OP_P', 'P_B')
assert(strcmp(et.get('OP_M'), 'M_A'))
assert(strcmp(et.get('OP_P'), 'P_B'))
assert(strcmp(et.get('OP_D'), 'D_A'))
assert(strcmp(et.get('OP_F'), 'F_A'))
assert(strcmp(et.get('OP_G'), 'G_A'))
et.set('OP_P', 'P_C')
assert(strcmp(et.get('OP_M'), 'M_C'))
assert(strcmp(et.get('OP_P'), 'P_C'))
assert(strcmp(et.get('OP_D'), 'D_C'))
assert(strcmp(et.get('OP_F'), 'F_C'))
assert(strcmp(et.get('OP_G'), 'G_C'))
et.set('OP_P', 'P_D')
assert(strcmp(et.get('OP_M'), 'M_C'))
assert(strcmp(et.get('OP_P'), 'P_D'))
assert(strcmp(et.get('OP_D'), 'D_C'))
assert(strcmp(et.get('OP_F'), 'F_C'))
assert(strcmp(et.get('OP_G'), 'G_C'))

et = ETG_postset_0();
et.set('OP_D', 'D_C')
assert(strcmp(et.get('OP_M'), 'M_A'))
assert(strcmp(et.get('OP_P'), 'P_A'))
assert(strcmp(et.get('OP_D'), 'D_C'))
assert(strcmp(et.get('OP_F'), 'F_A'))
assert(strcmp(et.get('OP_G'), 'G_A'))
et.set('OP_D', 'D_D')
assert(strcmp(et.get('OP_M'), 'M_D'))
assert(strcmp(et.get('OP_P'), 'P_D'))
assert(strcmp(et.get('OP_D'), 'D_D'))
assert(strcmp(et.get('OP_F'), 'F_D'))
assert(strcmp(et.get('OP_G'), 'G_D'))
et.set('OP_D', 'D_E')
assert(strcmp(et.get('OP_M'), 'M_D'))
assert(strcmp(et.get('OP_P'), 'P_D'))
assert(strcmp(et.get('OP_D'), 'D_E'))
assert(strcmp(et.get('OP_F'), 'F_D'))
assert(strcmp(et.get('OP_G'), 'G_D'))

et = ETG_postset_0();
et.set('OP_F', 'F_D')
assert(strcmp(et.get('OP_M'), 'M_A'))
assert(strcmp(et.get('OP_P'), 'P_A'))
assert(strcmp(et.get('OP_D'), 'D_A'))
assert(strcmp(et.get('OP_F'), 'F_D'))
assert(strcmp(et.get('OP_G'), 'G_A'))
et.set('OP_F', 'F_E')
assert(strcmp(et.get('OP_M'), 'M_E'))
assert(strcmp(et.get('OP_P'), 'P_E'))
assert(strcmp(et.get('OP_D'), 'D_E'))
assert(strcmp(et.get('OP_F'), 'F_E'))
assert(strcmp(et.get('OP_G'), 'G_E'))
et.set('OP_F', 'F_F')
assert(strcmp(et.get('OP_M'), 'M_E'))
assert(strcmp(et.get('OP_P'), 'P_E'))
assert(strcmp(et.get('OP_D'), 'D_E'))
assert(strcmp(et.get('OP_F'), 'F_F'))
assert(strcmp(et.get('OP_G'), 'G_E'))

et = ETG_postset_0();
et.set('OP_G', 'G_E')
assert(strcmp(et.get('OP_M'), 'M_A'))
assert(strcmp(et.get('OP_P'), 'P_A'))
assert(strcmp(et.get('OP_D'), 'D_A'))
assert(strcmp(et.get('OP_F'), 'F_A'))
assert(strcmp(et.get('OP_G'), 'G_E'))
et.set('OP_G', 'G_F')
assert(strcmp(et.get('OP_M'), 'M_F'))
assert(strcmp(et.get('OP_P'), 'P_F'))
assert(strcmp(et.get('OP_D'), 'D_F'))
assert(strcmp(et.get('OP_F'), 'F_F'))
assert(strcmp(et.get('OP_G'), 'G_F'))
et.set('OP_G', 'G_G')
assert(strcmp(et.get('OP_M'), 'M_F'))
assert(strcmp(et.get('OP_P'), 'P_F'))
assert(strcmp(et.get('OP_D'), 'D_F'))
assert(strcmp(et.get('OP_F'), 'F_F'))
assert(strcmp(et.get('OP_G'), 'G_G'))