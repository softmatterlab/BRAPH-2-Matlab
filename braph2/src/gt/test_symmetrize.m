%TEST_SYMMETRIZE

A = [
    1 2 3; 
    2 3 1; 
    3 2 1
    ];

%% Test 1: Rule Max
B = symmetrize(A);

assert(isequal(symmetrize(A), symmetrize(A, 'SymmetrizeRule', 'Max')), ...
    [BRAPH2.STR ':symmetrize:' BRAPH2.FAIL_TEST], ...
    'Symmetrize with rule ''Max'' must be the default.')

assert(isequal(B, ...
    [
    1 2 3;
    2 3 2;
    3 2 1;
    ]),...
    [BRAPH2.STR ':symmetrize:' BRAPH2.FAIL_TEST], ...
    'Symmetrize with rule ''Max'' not working correctly.')

%% Test 2: Rule Sum
B = symmetrize(A, 'SymmetrizeRule', 'Sum');

assert(isequal(B, ...
    [
    2 4 6;
    4 6 3;
    6 3 2;
    ]), ...
    [BRAPH2.STR ':symmetrize:' BRAPH2.FAIL_TEST], ...
    'Symmetrize with rule ''Sum'' not working correctly.')

%% Test 3: Rule Average
B = symmetrize(A, 'SymmetrizeRule', 'Average');

assert(isequal(B, ...
    [
    1 2 3;
    2 3 1.5;
    3 1.5 1;
    ]), ...
    [BRAPH2.STR ':symmetrize:' BRAPH2.FAIL_TEST], ...
    'Symmetrize with rule ''Average'' not working correctly.')

%% Test 4: Rule Min
B = symmetrize(A, 'SymmetrizeRule', 'Min');

assert(isequal(B, ...
    [
    1 2 3;
    2 3 1;
    3 1 1;
    ]), ...
    [BRAPH2.STR ':symmetrize:' BRAPH2.FAIL_TEST], ...
    'Symmetrize with rule ''Min'' not working correctly.')