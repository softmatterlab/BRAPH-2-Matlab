%% ¡header!
ETF_preset_0 < ConcreteElement (et, test F preset) tests preset.

%%% ¡description!
ETF_preset_0 tests the use of preset.

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
LO_M (metadata, logical) is a prop metadata logical.
%%%% ¡default!
true
%%%% ¡preset!
value = true;

%%% ¡prop!
LO_P (parameter, logical) is a prop parameter logical.
%%%% ¡default!
true
%%%% ¡preset!
value = true;

%%% ¡prop!
LO_D (data, logical) is a prop data logical.
%%%% ¡default!
true
%%%% ¡preset!
value = true;

%%% ¡prop!
LO_F (figure, logical) is a prop figure logical.
%%%% ¡default!
true
%%%% ¡preset!
value = true;

%%% ¡prop!
LO_G (gui, logical) is a prop gui logical.
%%%% ¡default!
true
%%%% ¡preset!
value = true;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Preset
%%%% ¡probability!
.01
%%%% ¡code!
et = ETF_preset_0();

et.set('LO_M', false)
assert(et.get('LO_M'))
et.set('LO_M', 'anything really')
assert(et.get('LO_M'))

et.set('LO_P', false)
assert(et.get('LO_P'))
et.set('LO_P', 'anything really')
assert(et.get('LO_P'))

et.set('LO_D', false)
assert(et.get('LO_D'))
et.set('LO_D', 'anything really')
assert(et.get('LO_D'))

et.set('LO_F', false)
assert(et.get('LO_F'))
et.set('LO_F', 'anything really')
assert(et.get('LO_F'))

et.set('LO_G', false)
assert(et.get('LO_G'))
et.set('LO_G', 'anything really')
assert(et.get('LO_G'))