%TEST_DIAGONALIZE

A = [
    1 1 1; 
    2 2 2; 
    3 3 3
    ];

%% Test 1: Off-diagonal to 0
B = diagonalize(A);

assert(isequal(diagonalize(A), diagonalize(A, 'DiagonalizeRule', 0)), ...
    [BRAPH2.STR ':diagonalize:' BRAPH2.FAIL_TEST], ...
    'Diagonalize with rule setting value to 0 must be the default.')

assert(isequal(B, ...
    [
    1 0 0; 
    0 2 0; 
    0 0 3
    ]), ...
    [BRAPH2.STR ':diagonalize:' BRAPH2.FAIL_TEST], ...
    'Off-diagonal not correctly set to 0.')

%% Test 2: Off-diagonal to value
value = randn();
B = diagonalize(A, 'DiagonalizeRule', value);

assert(isequal(B, ...
    [
    1 value value; 
    value 2 value; 
    value value 3
    ]), ...
    [BRAPH2.STR ':diagonalize:' BRAPH2.FAIL_TEST], ...
    ['Off-diagonal not correctly set to value ' num2str(value)])