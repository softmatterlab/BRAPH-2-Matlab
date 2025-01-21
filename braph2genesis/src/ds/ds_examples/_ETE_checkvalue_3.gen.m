%% ¡header!
ETE_checkvalue_3 < ETE_checkvalue_2 (et, test E check_prop) tests check_value.

%%% ¡description!
ETE_checkvalue_3 tests the update of check_value skipping one generation.

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
SL_M (metadata, stringlist) is a prop metadata stringlist.
%%%% ¡default!
{'M by CA'}
%%%% ¡check_value!
check = strcmp(value{1}, 'M by CA');
msg = 'SL_M incorrect';

%%% ¡prop!
SL_P (parameter, stringlist) is a prop parameter stringlist.
%%%% ¡default!
{'P by CA'}
%%%% ¡check_value!
check = strcmp(value{1}, 'P by CA');
msg = 'SL_P incorrect';

%%% ¡prop!
SL_D (data, stringlist) is a prop data stringlist.
%%%% ¡default!
{'D by CA'}
%%%% ¡check_value!
check = strcmp(value{1}, 'D by CA');
msg = 'SL_D incorrect';

%%% ¡prop!
SL_R (result, stringlist) is a prop result stringlist.
%%%% ¡calculate!
value = et.get('SL_P');
%%%% ¡check_value!
l = length(value);
check = l == 1;
msg = 'SL_R incorrect';

%%% ¡prop!
SL_Q (query, stringlist) is a prop query stringlist.
%%%% ¡calculate!
value = et.get('SL_D');
%%%% ¡check_value!
l = length(value);
check = l == 1;
msg = 'SL_Q incorrect';

%%% ¡prop!
SL_E (evanescent, stringlist) is a prop evanescent stringlist.
%%%% ¡calculate!
value = et.get('SL_F');
%%%% ¡check_value!
l = length(value);
check = l == 1;
msg = 'SL_E incorrect';

%%% ¡prop!
SL_F (figure, stringlist) is a prop figure stringlist.
%%%% ¡default!
{'F by CA'}
%%%% ¡check_value!
check = strcmp(value{1}, 'F by CA');
msg = 'SL_F incorrect';

%%% ¡prop!
SL_G (gui, stringlist) is a prop gui stringlist.
%%%% ¡default!
{'G by CA'}
%%%% ¡check_value!
check = strcmp(value{1}, 'G by CA');
msg = 'SL_G incorrect';

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Check_value
%%%% ¡probability!
.01
%%%% ¡code!
et = ETE_checkvalue_3();

et.set('SL_M', {'M by CA' 'this is ok'})
assert_with_error('varargin{1}.set(''SL_M'', {''M'' ''this'' ''is'' ''NOT'' ''ok''})', [BRAPH2.STR ':ETE_checkvalue_3:' BRAPH2.WRONG_INPUT], et)
assert(isequal(et.get('SL_M'), {'M by CA' 'this is ok'}))

et.set('SL_P', {'P by CA' 'this is ok'}) % warning ¡A
assert_with_error('varargin{1}.set(''SL_P'', {''P'' ''this'' ''is'' ''NOT'' ''ok''})', [BRAPH2.STR ':ETE_checkvalue_3:' BRAPH2.WRONG_INPUT], et)
assert(isequal(et.get('SL_P'), {'P by CA' 'this is ok'}))

et.set('SL_D', {'D by CA' 'this is ok'}) % warning ¡B
assert_with_error('varargin{1}.set(''SL_D'', {''D'' ''this'' ''is'' ''NOT'' ''ok''})', [BRAPH2.STR ':ETE_checkvalue_3:' BRAPH2.WRONG_INPUT], et)
assert(isequal(et.get('SL_D'), {'D by CA' 'this is ok'}))

et.set('SL_F', {'F by CA' 'this is ok'}) % warning ¡C
assert_with_error('varargin{1}.set(''SL_F'', {''F'' ''this'' ''is'' ''NOT'' ''ok''})', [BRAPH2.STR ':ETE_checkvalue_3:' BRAPH2.WRONG_INPUT], et)
assert(isequal(et.get('SL_F'), {'F by CA' 'this is ok'}))

et.set('SL_G', {'G by CA' 'this is ok'})
assert_with_error('varargin{1}.set(''SL_G'', {''G'' ''this'' ''is'' ''NOT'' ''ok''})', [BRAPH2.STR ':ETE_checkvalue_3:' BRAPH2.WRONG_INPUT], et)
assert(isequal(et.get('SL_G'), {'G by CA' 'this is ok'}))

warning('off', [BRAPH2.STR ':ETE_checkvalue_3'])
assert(isa(et.get('SL_R'), 'NoValue')) % warning !A
assert(isa(et.get('SL_Q'), 'NoValue')) % warning !B
assert(isa(et.get('SL_E'), 'NoValue')) % warning !C
warning('on', [BRAPH2.STR ':ETE_checkvalue_3'])
et.set('SL_P', {'P by CA'}) % this is ok now for real
et.set('SL_D', {'D by CA'}) %  this is ok now for real
et.set('SL_F', {'F by CA'}) %  this is ok now for real
assert(isequal(et.get('SL_R'), et.get('SL_P'))) 
assert(isequal(et.get('SL_Q'), et.get('SL_D')))
warning('off', [BRAPH2.STR ':ETE_checkvalue_3'])
assert(isequal(et.get('SL_E'), et.get('SL_F')))
warning('on', [BRAPH2.STR ':ETE_checkvalue_3'])