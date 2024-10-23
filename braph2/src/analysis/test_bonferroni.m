% Test bonferroni

%% Test 1: Basics
significant_p_value = .05;
n = 25;  % number of samples or number of tests
pvalues = rand(1, n);
% Bonferroni Correction is defined as a the level of significance / number
% of tests, i.e., in this example is 0.05 / 25
bonferroni_expected = significant_p_value / n;
bonferroni_calculated = bonferroni(pvalues, significant_p_value);

assert(isequal(bonferroni_expected, bonferroni_calculated), ...
    [BRAPH2.STR ':Bonferroni:' BRAPH2.FAIL_TEST], ...
    'Error in bonferroni calculation')