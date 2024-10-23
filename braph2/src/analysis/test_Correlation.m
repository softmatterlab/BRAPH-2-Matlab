% test Correlation
data = rand(10);
covariates = rand(10, 1);
correlation_rule = Correlation.CORRELATION_RULE_LIST;
negative_weight_rule = Correlation.NEGATIVE_WEIGHT_RULE_LIST;

%% Test 1 Static getAdjacencyMatrix method
for i=1:1:numel(correlation_rule)
    for j = 1:1:numel(negative_weight_rule)
        A = Correlation.getAdjacencyMatrix(data, correlation_rule{i}, negative_weight_rule{j}, covariates);
        
        assert(~isempty(A), ...
            ['BRAPH:Correlation:getAdjacencyMatrix()'], ...
            ['getAdjacencyMatrix should return.']) %#ok<*NBRAK>
    end
end