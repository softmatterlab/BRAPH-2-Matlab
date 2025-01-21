%% ¡header!
ETC_calc_2 < ETC_calc_1 (et, test C calculate) tests calculate.

%%% ¡description!
ETC_calc_2 tests that calculate still uses the previous generation.

%%% ¡build!
1

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Update Calculate
%%%% ¡probability!
.01
%%%% ¡code!
et = ETC_calc_2();

assert(isequal(et.get('ST_R'), 'result calculated by ETC_calc_1'))
assert(isa(et.getr('ST_R'), 'NoValue'))
assert(isequal(et.memorize('ST_R'), 'result calculated by ETC_calc_1'))
assert(~isa(et.getr('ST_R'), 'NoValue'))

assert(isequal(et.get('ST_Q'), 'query calculated by ETC_calc_1'))
assert(isa(et.getr('ST_Q'), 'NoValue'))
warning('off', [BRAPH2.STR ':ETC_calc_2'])
assert(isequal(et.memorize('ST_Q'), 'query calculated by ETC_calc_1'))
warning('on', [BRAPH2.STR ':ETC_calc_2'])
assert(~isa(et.getr('ST_Q'), 'NoValue'))

warning('off', [BRAPH2.STR ':ETC_calc_2'])
assert(isequal(et.get('ST_E'), 'evanescent calculated by ETC_calc_1'))
warning('on', [BRAPH2.STR ':ETC_calc_2'])
assert(isa(et.getr('ST_E'), 'NoValue'))
assert(isequal(et.memorize('ST_E'), 'evanescent calculated by ETC_calc_1'))
assert(~isa(et.getr('ST_E'), 'NoValue'))
