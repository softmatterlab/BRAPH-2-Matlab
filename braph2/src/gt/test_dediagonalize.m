%TEST_DEDIAGONALIZE

A = [
    1 1 1; 
    1 1 1; 
    1 1 1
    ];

%% Test 1: Diagonal to 0
B = dediagonalize(A);

assert(isequal(dediagonalize(A), dediagonalize(A, 'DediagonalizeRule', 0)), ...
    [BRAPH2.STR ':dediagonalize:' BRAPH2.FAIL_TEST], ...
    'Dediagonalize with rule setting value to 0 must be the default.')

assert(isequal(B, ...
    [
    0 1 1; 
    1 0 1; 
    1 1 0
    ]), ...
    [BRAPH2.STR ':dediagonalize:' BRAPH2.FAIL_TEST], ...
    'Diagonal not correctly set to 0.')

%% Test 2: Diagonal to value
value = randn();
B = dediagonalize(A, 'DediagonalizeRule', value);

assert(isequal(B, ...
    [
    value 1 1; 
    1 value 1; 
    1 1 value
    ]), ...
    [BRAPH2.STR ':dediagonalize:' BRAPH2.FAIL_TEST], ...
    ['Diagonal not correctly set to value ' num2str(value)])