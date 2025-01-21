%% ¡header!
ETD_checkprop_2 < ETD_checkprop_1 (et, test D check_prop) tests check_prop.

%%% ¡description!
ETD_checkprop_2 tests that check_prop still uses the previous generation.

%%% ¡build!
1

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Update Check_prop
%%%% ¡probability!
.01
%%%% ¡code!
et = ETD_checkprop_2();

et.set('ST_M', '123')
et.set('ST_M', '')
assert_with_error('varargin{1}.set(''ST_M'', ''1234'')', [BRAPH2.STR ':ETD_checkprop_2:' BRAPH2.WRONG_INPUT], et)

et.set('ST_P', '12345')
et.set('ST_P', '123456')
assert_with_error('varargin{1}.set(''ST_P'', ''1234'')', [BRAPH2.STR ':ETD_checkprop_2:' BRAPH2.WRONG_INPUT], et)

et.set('ST_D', '12345')
et.set('ST_D', '1234567')
assert_with_error('varargin{1}.set(''ST_D'', ''123456'')', [BRAPH2.STR ':ETD_checkprop_2:' BRAPH2.WRONG_INPUT], et)

et.set('ST_F', '123')
et.set('ST_F', '')
assert_with_error('varargin{1}.set(''ST_F'', ''1234'')', [BRAPH2.STR ':ETD_checkprop_2:' BRAPH2.WRONG_INPUT], et)

et.set('ST_G', '12345')
et.set('ST_G', '123456')
assert_with_error('varargin{1}.set(''ST_G'', ''1234'')', [BRAPH2.STR ':ETD_checkprop_2:' BRAPH2.WRONG_INPUT], et)
