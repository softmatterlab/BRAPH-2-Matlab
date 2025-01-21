%% ¡header!
ETF_preset_1 < ETF_preset_0 (et, test F preset) tests preset.

%%% ¡description!
ETF_preset_1 tests the update of preset.

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
LO_M (metadata, logical) is a prop metadata logical.
%%%% ¡default!
false
%%%% ¡preset!
value = false;

%%% ¡prop!
LO_P (parameter, logical) is a prop parameter logical.
%%%% ¡default!
false
%%%% ¡preset!
value = false;

%%% ¡prop!
LO_D (data, logical) is a prop data logical.
%%%% ¡default!
false
%%%% ¡preset!
value = false;

%%% ¡prop!
LO_F (figure, logical) is a prop figure logical.
%%%% ¡default!
false
%%%% ¡preset!
value = false;

%%% ¡prop!
LO_G (gui, logical) is a prop gui logical.
%%%% ¡default!
false
%%%% ¡preset!
value = false;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Preset
%%%% ¡probability!
.01
%%%% ¡code!
et = ETF_preset_1();

et.set('LO_M', true)
assert(~et.get('LO_M'))
et.set('LO_M', 'anything really')
assert(~et.get('LO_M'))

et.set('LO_P', true)
assert(~et.get('LO_P'))
et.set('LO_P', 'anything really')
assert(~et.get('LO_P'))

et.set('LO_D', true)
assert(~et.get('LO_D'))
et.set('LO_D', 'anything really')
assert(~et.get('LO_D'))

et.set('LO_F', true)
assert(~et.get('LO_F'))
et.set('LO_F', 'anything really')
assert(~et.get('LO_F'))

et.set('LO_G', true)
assert(~et.get('LO_G'))
et.set('LO_G', 'anything really')
assert(~et.get('LO_G'))