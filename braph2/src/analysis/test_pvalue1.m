% test pvalue1

%% Test 1: Test scalar input
M = 1e+3;
random_differences = cell(1, M);
for i = 1:1:size(random_differences, 2)
    random_differences{i} = 10 * (i - 1) / (M - 1) - 5;
end

observed_difference = 4 * (2 * (randn()>0) - 1);
P1 = pvalue1(observed_difference, random_differences);
assert(isequal(round(100 * P1), 10), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')
observed_difference = 4 * (2 * (randn()>0) - 1);
P1 = pvalue1({observed_difference}, random_differences);
assert(isequal(round(100 * P1{1}), 10), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')

observed_difference = 6  * (2 * (randn()>0) - 1);
P1 = pvalue1(observed_difference, random_differences);
assert(isequal(round(100 * P1), 0), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')
observed_difference = 6  * (2 * (randn()>0) - 1);
P1 = pvalue1({observed_difference}, random_differences);
assert(isequal(round(100 * P1{1}), 0), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')

%% Test 2: Test vector input
M = 1e+3;
random_differences = cell(1, M);
for i = 1:1:size(random_differences, 2)
    random_differences{i} = 10 * ones(3, 1) * (i - 1) / (M - 1) - 5;
end

observed_difference = 4 * ones(3, 1) .* (2 * (randn(3, 1)>0) - 1);
P1 = pvalue1(observed_difference, random_differences);
assert(all(round(100 * P1) == 10), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')
observed_difference = 4 * ones(3, 1) .* (2 * (randn(3, 1)>0) - 1);
P1 = pvalue1({observed_difference}, random_differences);
assert(all(round(100 * P1{1}) == 10), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')

observed_difference = 6 * ones(3, 1) .* (2 * (randn(3, 1)>0) - 1);
P1 = pvalue1(observed_difference, random_differences);
assert(all(round(100 * P1) == 0), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')
observed_difference = 6 * ones(3, 1) .* (2 * (randn(3, 1)>0) - 1);
P1 = pvalue1({observed_difference}, random_differences);
assert(all(round(100 * P1{1}) == 0), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')

%% Test 3: Test matrix input
M = 1e+3;
random_differences = cell(1, M);
for i = 1:1:size(random_differences, 2)
    random_differences{i} = 10 * ones(3) * (i - 1) / (M - 1) - 5;
end

observed_difference = 4 * ones(3) .* (2 * (randn(3)>0) - 1);
P1 = pvalue1(observed_difference, random_differences);
assert(all(all(round(100 * P1) == 10)), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')
observed_difference = 4 * ones(3) .* (2 * (randn(3)>0) - 1);
P1 = pvalue1({observed_difference}, random_differences);
assert(all(all(round(100 * P1{1}) == 10)), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')

observed_difference = 6 * ones(3) .* (2 * (randn(3)>0) - 1);
P1 = pvalue1(observed_difference, random_differences);
assert(all(all(round(100 * P1) == 0)), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')
observed_difference = 6 * ones(3) .* (2 * (randn(3)>0) - 1);
P1 = pvalue1({observed_difference}, random_differences);
assert(all(all(round(100 * P1{1}) == 0)), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')

%% Test 4: Cell array input
M = 1e+3;
random_differences = cell(1, M);
for i = 1:1:size(random_differences, 2)
    random_differences{i} = {
        10 * ones(3) * (i - 1) / (M - 1) - 5; 
        10 * ones(3) * (i - 1) / (M - 1) - 5;
        };
end

observed_difference = {
    4 * ones(3) .* (2 * (randn(3)>0) - 1);
    4 * ones(3) .* (2 * (randn(3)>0) - 1);
    };
P1 = pvalue1(observed_difference, random_differences);
assert(all(all(cellfun(@(x) all(all(round(100 * x) == 10)), P1))), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')

observed_difference = {
    6 * ones(3) .* (2 * (randn(3)>0) - 1);
    6 * ones(3) .* (2 * (randn(3)>0) - 1);
    };
P1 = pvalue1(observed_difference, random_differences);
assert(all(all(cellfun(@(x) all(all(round(100 * x) == 0)), P1))), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')

%% Test 5: Test vector with 3rd dimension input
M = 1e+3;
random_differences = cell(1, M);
for i = 1:1:size(random_differences, 2)
    random_differences{i} = 10 * ones(3, 1, 2) * (i - 1) / (M - 1) - 5;
end

observed_difference = 4 * ones(3, 1, 2) .* (2 * (randn(3, 1)>0) - 1);
P1 = pvalue1(observed_difference, random_differences);
assert(all(all(round(100 * P1) == 10)), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')

observed_difference = 4 * ones(3, 1, 2) .* (2 * (randn(3, 1)>0) - 1);
P1 = pvalue1({observed_difference}, random_differences);
assert(all(all(round(100 * P1{1}) == 10)), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')

observed_difference = 6 * ones(3, 1, 2) .* (2 * (randn(3, 1)>0) - 1);
P1 = pvalue1(observed_difference, random_differences);
assert(all(all(round(100 * P1) == 0)), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')

observed_difference = 6 * ones(3, 1, 2) .* (2 * (randn(3, 1)>0) - 1);
P1 = pvalue1({observed_difference}, random_differences);
assert(all(all(round(100 * P1{1}) == 0)), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')

%% Test 6: Test scalar zero-input
M = 1e+3;
random_differences = cell(1, M);
for i = 1:1:size(random_differences, 2)
    random_differences{i} = 0;
end

observed_difference = 0;
P1 = pvalue1(observed_difference, random_differences);
assert(isequal(P1, 1), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')
P1 = pvalue1({observed_difference}, random_differences);
assert(isequal(P1{1}, 1), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')

observed_difference = 4;
P1 = pvalue1(observed_difference, random_differences);
assert(isequal(P1, 1/(2*M)), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')
P1 = pvalue1({observed_difference}, random_differences);
assert(isequal(P1{1}, 1/(2*M)), ...
    [BRAPH2.STR ':pvalue1:' BRAPH2.FAIL_TEST], ...
    'Error in pvalue1 calculation')
