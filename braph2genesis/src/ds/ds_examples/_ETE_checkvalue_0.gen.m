%% ¡header!
ETE_checkvalue_0 < ConcreteElement (et, test E check_value) tests check_value.

%%% ¡description!
ETE_checkvalue_0 tests the use of check_value.

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
SL_M (metadata, stringlist) is a prop metadata stringlist.
%%%% ¡default!
{'M'}
%%%% ¡check_value!
check = strcmp(value{1}, 'M');
msg = 'SL_M incorrect';

%%% ¡prop!
SL_P (parameter, stringlist) is a prop parameter stringlist.
%%%% ¡default!
{'P' 'P2' 'P3'}
%%%% ¡check_value!
check = strcmp(value{1}, 'P');
msg = 'SL_P incorrect';

%%% ¡prop!
SL_D (data, stringlist) is a prop data stringlist.
%%%% ¡default!
{'D' 'D2' 'D3'}
%%%% ¡check_value!
check = strcmp(value{1}, 'D');
msg = 'SL_D incorrect';

%%% ¡prop!
SL_R (result, stringlist) is a prop result stringlist.
%%%% ¡calculate!
value = et.get('SL_P');
%%%% ¡check_value!
l = length(value);
check = l > 2;
msg = 'SL_R incorrect';

%%% ¡prop!
SL_Q (query, stringlist) is a prop query stringlist.
%%%% ¡calculate!
value = et.get('SL_D');
%%%% ¡check_value!
l = length(value);
check = l > 2;
msg = 'SL_Q incorrect';

%%% ¡prop!
SL_E (evanescent, stringlist) is a prop evanescent stringlist.
%%%% ¡calculate!
value = et.get('SL_F');
%%%% ¡check_value!
l = length(value);
check = l > 2;
msg = 'SL_E incorrect';

%%% ¡prop!
SL_F (figure, stringlist) is a prop figure stringlist.
%%%% ¡default!
{'F' 'F2'  'F3' 'F4'}
%%%% ¡check_value!
check = strcmp(value{1}, 'F');
msg = 'SL_F incorrect';

%%% ¡prop!
SL_G (gui, stringlist) is a prop gui stringlist.
%%%% ¡default!
{'G' 'G2' 'G3' 'G4' 'G5'}
%%%% ¡check_value!
check = strcmp(value{1}, 'G');
msg = 'SL_G incorrect';

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Check_value
%%%% ¡probability!
.01
%%%% ¡code!
et = ETE_checkvalue_0();

et.set('SL_M', {'M' 'this is ok'})
assert_with_error('varargin{1}.set(''SL_M'', {''this'' ''is'' ''NOT'' ''ok''})', [BRAPH2.STR ':ETE_checkvalue_0:' BRAPH2.WRONG_INPUT], et)
assert(isequal(et.get('SL_M'), {'M' 'this is ok'}))

et.set('SL_P', {'P' 'this is ok'}) % warning ¡A
assert_with_error('varargin{1}.set(''SL_P'', {''this'' ''is'' ''NOT'' ''ok''})', [BRAPH2.STR ':ETE_checkvalue_0:' BRAPH2.WRONG_INPUT], et)
assert(isequal(et.get('SL_P'), {'P' 'this is ok'}))

et.set('SL_D', {'D' 'this is ok'}) % warning ¡B
assert_with_error('varargin{1}.set(''SL_D'', {''this'' ''is'' ''NOT'' ''ok''})', [BRAPH2.STR ':ETE_checkvalue_0:' BRAPH2.WRONG_INPUT], et)
assert(isequal(et.get('SL_D'), {'D' 'this is ok'}))

et.set('SL_F', {'F' 'this is ok'}) % warning ¡C
assert_with_error('varargin{1}.set(''SL_F'', {''this'' ''is'' ''NOT'' ''ok''})', [BRAPH2.STR ':ETE_checkvalue_0:' BRAPH2.WRONG_INPUT], et)
assert(isequal(et.get('SL_F'), {'F' 'this is ok'}))

et.set('SL_G', {'G' 'this is ok'})
assert_with_error('varargin{1}.set(''SL_G'', {''this'' ''is'' ''NOT'' ''ok''})', [BRAPH2.STR ':ETE_checkvalue_0:' BRAPH2.WRONG_INPUT], et)
assert(isequal(et.get('SL_G'), {'G' 'this is ok'}))

warning('off', [BRAPH2.STR ':ETE_checkvalue_0'])
assert(isa(et.get('SL_R'), 'NoValue')) % warning !A
assert(isa(et.get('SL_Q'), 'NoValue')) % warning !B
assert(isa(et.get('SL_E'), 'NoValue')) % warning !C
warning('on', [BRAPH2.STR ':ETE_checkvalue_0'])
et.set('SL_P', {'P' 'this is ok' 'now for real'})
et.set('SL_D', {'D' 'this is ok' 'now' 'for real'})
et.set('SL_F', {'F' 'this is ok' 'now' 'for' 'real'})
assert(isequal(et.get('SL_R'), et.get('SL_P'))) 
assert(isequal(et.get('SL_Q'), et.get('SL_D')))
warning('off', [BRAPH2.STR ':ETE_checkvalue_0'])
assert(isequal(et.get('SL_E'), et.get('SL_F')))
warning('on', [BRAPH2.STR ':ETE_checkvalue_0'])