%% ¡header!
ETC_calc_0 < ConcreteElement (et, test C calculate) tests calculate.

%%% ¡description!
ETC_calc_0 tests the use of calculate and the fact that it ignores the default.

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
ST_R (result, string) is a prop result string.
%%%% ¡default!
'result default'
%%%% ¡calculate!
value = 'result calculated';

%%% ¡prop!
ST_Q (query, string) is a prop query string.
%%%% ¡default!
'query default'
%%%% ¡calculate!
value = 'query calculated';

%%% ¡prop!
ST_E (evanescent, string) is a prop evanescent string.
%%%% ¡default!
'evanescent default'
%%%% ¡calculate!
value = 'evanescent calculated';

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Calculate
%%%% ¡probability!
.01
%%%% ¡code!
et = ETC_calc_0();

assert(isequal(et.get('ST_R'), 'result calculated'))
assert(isa(et.getr('ST_R'), 'NoValue'))
assert(isequal(et.memorize('ST_R'), 'result calculated'))
assert(~isa(et.getr('ST_R'), 'NoValue'))

assert(isequal(et.get('ST_Q'), 'query calculated'))
assert(isa(et.getr('ST_Q'), 'NoValue'))
warning('off', [BRAPH2.STR ':ETC_calc_0'])
assert(isequal(et.memorize('ST_Q'), 'query calculated'))
warning('on', [BRAPH2.STR ':ETC_calc_0'])
assert(~isa(et.getr('ST_Q'), 'NoValue'))

warning('off', [BRAPH2.STR ':ETC_calc_0'])
assert(isequal(et.get('ST_E'), 'evanescent calculated'))
warning('on', [BRAPH2.STR ':ETC_calc_0'])
assert(isa(et.getr('ST_E'), 'NoValue'))
assert(isequal(et.memorize('ST_E'), 'evanescent calculated'))
assert(~isa(et.getr('ST_E'), 'NoValue'))
