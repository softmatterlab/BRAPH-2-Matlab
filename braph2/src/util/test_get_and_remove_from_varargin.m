%TEST_GET_AND_REMOVE_FROM_VARARGIN

%% Test 1: Empty
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    default_value = 0;
    handle = 'h';

    varargin = {};
    expected_varargin = {};
    [value, new_varargin] = get_and_remove_from_varargin(default_value, handle, varargin);
    assert(isequal(value, default_value) && isequal(new_varargin, expected_varargin), ...
        [BRAPH2.STR ':get_and_remove_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with empty varargin.')
    [value, new_varargin] = get_and_remove_from_varargin(default_value, handle, varargin{:});
    assert(isequal(value, default_value) && isequal(new_varargin, expected_varargin), ...
        [BRAPH2.STR ':get_and_remove_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with empty varargin.')
end

%% Test 2: Full with value
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    default_value = 0;
    handle = 'h';

    varargin = {'h', 1};
    expected_varargin = cell(1, 0);
    [value, new_varargin] = get_and_remove_from_varargin(default_value, handle, varargin);
    assert(isequal(value, 1) && isequal(new_varargin, expected_varargin), ...
        [BRAPH2.STR ':get_and_remove_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with empty varargin.')
    [value, new_varargin] = get_and_remove_from_varargin(default_value, handle, varargin{:});
    assert(isequal(value, 1) && isequal(new_varargin, expected_varargin), ...
        [BRAPH2.STR ':get_and_remove_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with empty varargin.')

    varargin = {'h', 1.1, 'h', 1.2};
    expected_varargin = {'h', 1.2};
    [value, new_varargin] = get_and_remove_from_varargin(default_value, handle, varargin);
    assert(isequal(value, 1.1) && isequal(new_varargin, expected_varargin), ...
        [BRAPH2.STR ':get_and_remove_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with empty varargin.')
    [value, new_varargin] = get_and_remove_from_varargin(default_value, handle, varargin{:});
    assert(isequal(value, 1.1) && isequal(new_varargin, expected_varargin), ...
        [BRAPH2.STR ':get_and_remove_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with empty varargin.')

    varargin = {'h', 1, 'h1', 'none', 'h', 2, 'h2', 'none', 'h', 3};
    expected_varargin = {'h1', 'none', 'h', 2, 'h2', 'none', 'h', 3};
    [value, new_varargin] = get_and_remove_from_varargin(default_value, handle, varargin);
    assert(isequal(value, 1) && isequal(new_varargin, expected_varargin), ...
        [BRAPH2.STR ':get_and_remove_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with empty varargin.')
    [value, new_varargin] = get_and_remove_from_varargin(default_value, handle, varargin{:});
    assert(isequal(value, 1) && isequal(new_varargin, expected_varargin), ...
        [BRAPH2.STR ':get_and_remove_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with empty varargin.')

    varargin = {'h1', 'none', 'h', 2, 'h2', 'none', 'h', 3};
    expected_varargin = {'h1', 'none', 'h2', 'none', 'h', 3};
    [value, new_varargin] = get_and_remove_from_varargin(default_value, handle, varargin);
    assert(isequal(value, 2) && isequal(new_varargin, expected_varargin), ...
        [BRAPH2.STR ':get_and_remove_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with empty varargin.')
    [value, new_varargin] = get_and_remove_from_varargin(default_value, handle, varargin{:});
    assert(isequal(value, 2) && isequal(new_varargin, expected_varargin), ...
        [BRAPH2.STR ':get_and_remove_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with empty varargin.')

    varargin = {'h1', 'none', 'h2', 'none', 'h', 3};
    expected_varargin = {'h1', 'none', 'h2', 'none'};
    [value, new_varargin] = get_and_remove_from_varargin(default_value, handle, varargin);
    assert(isequal(value, 3) && isequal(new_varargin, expected_varargin), ...
        [BRAPH2.STR ':get_and_remove_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with empty varargin.')
    [value, new_varargin] = get_and_remove_from_varargin(default_value, handle, varargin{:});
    assert(isequal(value, 3) && isequal(new_varargin, expected_varargin), ...
        [BRAPH2.STR ':get_and_remove_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with empty varargin.')
end

%% Test 3: Full without value
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    default_value = 0;
    handle = 'h';

    varargin = {'h1', 'none', 'h2', 'none'};
    expected_varargin = {'h1', 'none', 'h2', 'none'};
    [value, new_varargin] = get_and_remove_from_varargin(default_value, handle, varargin);
    assert(isequal(value, default_value) && isequal(new_varargin, expected_varargin), ...
        [BRAPH2.STR ':get_and_remove_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with empty varargin.')
    [value, new_varargin] = get_and_remove_from_varargin(default_value, handle, varargin{:});
    assert(isequal(value, default_value) && isequal(new_varargin, expected_varargin), ...
        [BRAPH2.STR ':get_and_remove_from_varargin:' BRAPH2.FAIL_TEST], ...
        'Error with empty varargin.')
end