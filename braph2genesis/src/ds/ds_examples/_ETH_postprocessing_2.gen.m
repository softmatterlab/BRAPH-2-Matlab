%% ¡header!
ETH_postprocessing_2 < ETH_postprocessing_1 (et, test H postprocessing) tests postprocessing.

%%% ¡description!
ETH_postprocessing_2 tests that postprocessing still uses the previous generation.

%%% ¡build!
1

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Postprocessing
%%%% ¡probability!
.01
%%%% ¡code!
et = ETH_postprocessing_2();

assert(strcmp(et.get('CA_M'), 'ETH_postprocessing_0'))
et.set('CA_M', 'ETH_postprocessing_1')
assert(strcmp(et.get('CA_M'), 'ETH_postprocessing_3'))
et.set('CA_M', 'ETH_postprocessing_2')
assert(strcmp(et.get('CA_M'), 'ETH_postprocessing_2'))
et.set('CA_M', 'ETH_postprocessing_3')
assert(strcmp(et.get('CA_M'), 'ETH_postprocessing_3'))