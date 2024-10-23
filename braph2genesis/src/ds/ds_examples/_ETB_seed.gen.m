%% ¡header!
ETB_seed < ConcreteElement (et, test B seeded randomness) tests seeded randomness.

%%% ¡description!
ETB_seed tests the use of seeded randomness.

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
OP_R (result, option) is a prop result option.
%%%% ¡settings!
{'R_A', 'R_B', 'R_C', 'R_D', 'R_E', 'R_F', 'R_G', 'R_H', 'R_J', 'R_K'}
%%%% ¡calculate!
settings = ETB_seed.getPropSettings('OP_R');
index = randi(length(settings));
value = settings{index};

%%% ¡prop!
OP_Q (query, option) is a prop query option.
%%%% ¡settings!
{'Q_A', 'Q_B', 'Q_C', 'Q_D', 'Q_E', 'Q_F', 'Q_G', 'Q_H', 'Q_J', 'Q_K'}
%%%% ¡calculate!
settings = ETB_seed.getPropSettings('OP_Q');
index = randi(length(settings));
value = settings{index};

%%% ¡prop!
OP_E (evanescent, option) is a prop evanescent option.
%%%% ¡settings!
{'E_A', 'E_B', 'E_C', 'E_D', 'E_E', 'E_F', 'E_G', 'E_H', 'E_J', 'E_K'}
%%%% ¡calculate!
settings = ETB_seed.getPropSettings('OP_E');
index = randi(length(settings));
value = settings{index};

%%% ¡prop!
NN_R (result, scalar) is a prop result scalar.
%%%% ¡calculate!
value = rand();

%%% ¡prop!
NN_Q (query, scalar) is a prop query scalar.
%%%% ¡calculate!
value = rand();

%%% ¡prop!
NN_E (evanescent, scalar) is a prop evanescent scalar.
%%%% ¡calculate!
value = rand();

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Seeded Randomness
%%%% ¡probability!
.01
%%%% ¡code!
et = ETB_seed();

assert(isequal(et.get('OP_R'), et.get('OP_R')))
assert(isequal(et.get('OP_Q'), et.get('OP_Q')))
warning('off', [BRAPH2.STR ':ETB_seed'])
assert(isequal(et.get('OP_E'), et.get('OP_E')))
warning('on', [BRAPH2.STR ':ETB_seed'])

assert(et.get('NN_R') == et.get('NN_R'))
assert(et.get('NN_Q') == et.get('NN_Q'))
warning('off', [BRAPH2.STR ':ETB_seed'])
assert(et.get('NN_E') == et.get('NN_E'))
warning('on', [BRAPH2.STR ':ETB_seed'])