%% ¡header!
ETH_postprocessing_1 < ETH_postprocessing_0 (et, test H postprocessing) tests postprocessing.

%%% ¡description!
ETH_postprocessing_1 tests the update of postprocessing.

%% ¡props_update!

%%% ¡prop!
CA_C (constant, class) is a prop constant class.
%%%% ¡postprocessing!
if strcmp(et.get('CA_M'), 'ETH_postprocessing_1')
    et.set('CA_M', 'ETH_postprocessing_3')
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Postprocessing
%%%% ¡probability!
.01
%%%% ¡code!
et = ETH_postprocessing_1();

assert(strcmp(et.get('CA_M'), 'ETH_postprocessing_0'))
et.set('CA_M', 'ETH_postprocessing_1')
assert(strcmp(et.get('CA_M'), 'ETH_postprocessing_3'))
et.set('CA_M', 'ETH_postprocessing_2')
assert(strcmp(et.get('CA_M'), 'ETH_postprocessing_2'))
et.set('CA_M', 'ETH_postprocessing_3')
assert(strcmp(et.get('CA_M'), 'ETH_postprocessing_3'))