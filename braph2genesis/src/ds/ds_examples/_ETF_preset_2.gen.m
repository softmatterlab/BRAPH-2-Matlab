%% ¡header!
ETF_preset_2 < ETF_preset_1 (et, test F preset) tests preset.

%%% ¡description!
ETF_preset_2 tests that preset still uses the previous generation.

%%% ¡build!
1

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Preset
%%%% ¡probability!
.01
%%%% ¡code!
et = ETF_preset_2();

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