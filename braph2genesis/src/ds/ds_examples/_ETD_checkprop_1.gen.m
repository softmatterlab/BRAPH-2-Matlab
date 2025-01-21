%% ¡header!
ETD_checkprop_1 < ETD_checkprop_0 (et, test D check_prop) tests check_prop.

%%% ¡description!
ETD_checkprop_1 tests the update of check_prop.

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ST_M (metadata, string) is a prop metadata string.
%%%% ¡default!
'M<4'
%%%% ¡check_prop!
check = ...
    length(value) < 4;

%%% ¡prop!
ST_P (parameter, string) is a prop parameter string.
%%%% ¡default!
'P > 4'
%%%% ¡check_prop!
check = ...
    length(value) > 4;

%%% ¡prop!
ST_D (data, string) is a prop data string.
%%%% ¡default!
'D~=6'
%%%% ¡check_prop!
check = ...
    length(value) ~= 6;

%%% ¡prop!
ST_F (figure, string) is a prop figure string.
%%%% ¡default!
'F<4'
%%%% ¡check_prop!
check = length(value) < 4;

%%% ¡prop!
ST_G (gui, string) is a prop gui string.
%%%% ¡default!
'G > 4'
%%%% ¡check_prop!
check = length(value) > 4;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Update Check_prop
%%%% ¡probability!
.01
%%%% ¡code!
et = ETD_checkprop_1();

et.set('ST_M', '123')
et.set('ST_M', '')
assert_with_error('varargin{1}.set(''ST_M'', ''1234'')', [BRAPH2.STR ':ETD_checkprop_1:' BRAPH2.WRONG_INPUT], et)

et.set('ST_P', '12345')
et.set('ST_P', '123456')
assert_with_error('varargin{1}.set(''ST_P'', ''1234'')', [BRAPH2.STR ':ETD_checkprop_1:' BRAPH2.WRONG_INPUT], et)

et.set('ST_D', '12345')
et.set('ST_D', '1234567')
assert_with_error('varargin{1}.set(''ST_D'', ''123456'')', [BRAPH2.STR ':ETD_checkprop_1:' BRAPH2.WRONG_INPUT], et)

et.set('ST_F', '123')
et.set('ST_F', '')
assert_with_error('varargin{1}.set(''ST_F'', ''1234'')', [BRAPH2.STR ':ETD_checkprop_1:' BRAPH2.WRONG_INPUT], et)

et.set('ST_G', '12345')
et.set('ST_G', '123456')
assert_with_error('varargin{1}.set(''ST_G'', ''1234'')', [BRAPH2.STR ':ETD_checkprop_1:' BRAPH2.WRONG_INPUT], et)
