%% ¡header!
ETE_checkvalue_2 < ETE_checkvalue_1 (et, test E check_value) tests check_value.

%%% ¡description!
ETE_checkvalue_2 tests that check_value still uses the previous generation.

%%% ¡build!
1

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Check_value
%%%% ¡probability!
.01
%%%% ¡code!
et = ETE_checkvalue_2();

et.set('SL_M', {'M by LO' 'this is ok'})
assert_with_error('varargin{1}.set(''SL_M'', {''M'' ''this'' ''is'' ''NOT'' ''ok''})', [BRAPH2.STR ':ETE_checkvalue_2:' BRAPH2.WRONG_INPUT], et)
assert(isequal(et.get('SL_M'), {'M by LO' 'this is ok'}))

et.set('SL_P', {'P by LO' 'this is ok'}) % warning ¡A
assert_with_error('varargin{1}.set(''SL_P'', {''P'' ''this'' ''is'' ''NOT'' ''ok''})', [BRAPH2.STR ':ETE_checkvalue_2:' BRAPH2.WRONG_INPUT], et)
assert(isequal(et.get('SL_P'), {'P by LO' 'this is ok'}))

et.set('SL_D', {'D by LO' 'this is ok'}) % warning ¡B
assert_with_error('varargin{1}.set(''SL_D'', {''D'' ''this'' ''is'' ''NOT'' ''ok''})', [BRAPH2.STR ':ETE_checkvalue_2:' BRAPH2.WRONG_INPUT], et)
assert(isequal(et.get('SL_D'), {'D by LO' 'this is ok'}))

et.set('SL_F', {'F by LO' 'this is ok'}) % warning ¡C
assert_with_error('varargin{1}.set(''SL_F'', {''F'' ''this'' ''is'' ''NOT'' ''ok''})', [BRAPH2.STR ':ETE_checkvalue_2:' BRAPH2.WRONG_INPUT], et)
assert(isequal(et.get('SL_F'), {'F by LO' 'this is ok'}))

et.set('SL_G', {'G by LO' 'this is ok'})
assert_with_error('varargin{1}.set(''SL_G'', {''G'' ''this'' ''is'' ''NOT'' ''ok''})', [BRAPH2.STR ':ETE_checkvalue_2:' BRAPH2.WRONG_INPUT], et)
assert(isequal(et.get('SL_G'), {'G by LO' 'this is ok'}))

warning('off', [BRAPH2.STR ':ETE_checkvalue_2'])
assert(isa(et.get('SL_R'), 'NoValue')) % warning !A
assert(isa(et.get('SL_Q'), 'NoValue')) % warning !B
assert(isa(et.get('SL_E'), 'NoValue')) % warning !C
warning('on', [BRAPH2.STR ':ETE_checkvalue_2'])
et.set('SL_P', {'P by LO' 'this' 'is' 'ok' 'now' 'for' 'real'})
et.set('SL_D', {'D by LO' 'this' 'is' 'ok' 'now' 'for' 'real'})
et.set('SL_F', {'F by LO' 'this' 'is' 'ok' 'now' 'for' 'real'})
assert(isequal(et.get('SL_R'), et.get('SL_P'))) 
assert(isequal(et.get('SL_Q'), et.get('SL_D')))
warning('off', [BRAPH2.STR ':ETE_checkvalue_2'])
assert(isequal(et.get('SL_E'), et.get('SL_F')))
warning('on', [BRAPH2.STR ':ETE_checkvalue_2'])