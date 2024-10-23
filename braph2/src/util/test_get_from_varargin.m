%TEST_GET_FROM_VARARGIN

%% Test 1: Empty
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    default_value = 0;
    handle = 'h1';
    varargin = {};
    assert(isequal(get_from_varargin(default_value, handle, varargin), default_value), ...
        [BRAPH2.STR ':get_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with empty varargin.')
    assert(isequal(get_from_varargin(default_value, handle, varargin{:}), default_value), ...
        [BRAPH2.STR ':get_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with empty varargin.')
end

%% Test 2: Full with value
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    default_value = 0;
    handle = 'h2';
    varargin = {'h1', 'none', 'h2', 1, 'h3', 'none'};
    assert(isequal(get_from_varargin(default_value, handle, varargin), 1), ...
        [BRAPH2.STR ':get_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with full varargin.')
    assert(isequal(get_from_varargin(default_value, handle, varargin{:}), 1), ...
        [BRAPH2.STR ':get_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with full varargin.')
end

%% Test 3: Full without value
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    default_value = 0;
    handle = 'NoHandle';
    varargin = {'h1', 'none', 'h2', 1, 'h3', 'none'};
    assert(isequal(get_from_varargin(default_value, handle, varargin), 0), ...
        [BRAPH2.STR ':get_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with full varargin.')
    assert(isequal(get_from_varargin(default_value, handle, varargin{:}), 0), ...
        [BRAPH2.STR ':get_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with full varargin.')
end