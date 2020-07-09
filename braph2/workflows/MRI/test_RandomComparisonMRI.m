% test RandomComparisonMRI

br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});

subject_class = RandomComparison.getSubjectClass('RandomComparisonMRI');

sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlas);
sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlas);
sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlas);
sub4 = Subject.getSubject(subject_class, 'id4', 'label 4', 'notes 4', atlas);
sub5 = Subject.getSubject(subject_class, 'id5', 'label 5', 'notes 5', atlas);

group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3, sub4, sub5});

graph_type = AnalysisMRI.getGraphType();
measures = Graph.getCompatibleMeasureList(graph_type);

%% Test 1: Instantiation
for i = 1:1:numel(measures)
    randomcomparison = RandomComparisonMRI('rc1', 'label', 'notes', atlas, measures{i}, group);
end

%% Test 2: Correct Size defaults
for i = 1:1:numel(measures)
    number_of_randomizations = 10;
    
    randomcomparison = RandomComparisonMRI('rc1', 'label', 'notes', atlas, measures{i}, group, 'RandomComparisonMRI.RandomizationNumber', number_of_randomizations);
    
    value_group = randomcomparison.getGroupValue();    
    value_random = randomcomparison.getRandomValue();
    difference = randomcomparison.getDifference();  % difference
    all_differences = randomcomparison.getAllDifferences(); % all differences obtained through the permutation test
    p1 = randomcomparison.getP1(); % p value single tailed
    p2 = randomcomparison.getP2();  % p value double tailed
    confidence_interval_min = randomcomparison.getConfidenceIntervalMin();  % min value of the 95% confidence interval
    confidence_interval_max = randomcomparison.getConfidenceIntervalMax(); % max value of the 95% confidence interval

    if Measure.is_global(measures{i})
        assert(iscell(value_group) && ...
            isequal(numel(value_group), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), value_group)),  ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with global measures')
        
        assert(iscell(value_random) && ...
            isequal(numel(value_random), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), value_random)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with global measures')
        
        assert(iscell(difference) && ...
            isequal(numel(difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), difference)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with global measures')

        assert(iscell(all_differences) && ...
            isequal(numel(all_differences), number_of_randomizations) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), all_differences)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with global measures')

        assert(iscell(p1) && ...
            isequal(numel(p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), p1)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with global measures')
        
        assert(iscell(p2) && ...
            isequal(numel(p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), p2)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with global measures')
        
        assert(iscell(confidence_interval_min) && ...
            isequal(numel(confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), confidence_interval_min)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with global measures')

        assert(iscell(confidence_interval_max) && ...
            isequal(numel(confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), confidence_interval_max)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with global measures')
        
    elseif Measure.is_nodal(measures{i})
        
        assert(iscell(value_group) && ...
            isequal(numel(value_group), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), value_group)) , ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with nodal measures')
        
        assert(iscell(value_random) && ...
            isequal(numel(value_random), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), value_random)) , ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with nodal measures')
        
        assert(iscell(difference) && ...
            isequal(numel(difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), difference)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with nodal measures')

        assert(iscell(all_differences) && ...
            isequal(numel(all_differences), number_of_randomizations) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), all_differences)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with nodal measures')

        assert(iscell(p1) && ...
            isequal(numel(p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), p1)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with nodal measures')
        
        assert(iscell(p2) && ...
            isequal(numel(p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), p2)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with nodal measures')
        
        assert(iscell(confidence_interval_min) && ...
            isequal(numel(confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), confidence_interval_min)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with nodal measures')

        assert(iscell(confidence_interval_max) && ...
            isequal(numel(confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), confidence_interval_max)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with nodal measures')
        
    elseif Measure.is_binodal(measures{i})
        
        assert(iscell(value_group) && ...
            isequal(numel(value_group), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), value_group)) , ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')
        
        assert(iscell(value_random) && ...
            isequal(numel(value_random), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), value_random)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')
        
        assert(iscell(difference) && ...
            isequal(numel(difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), difference)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')

        assert(iscell(all_differences) && ...
            isequal(numel(all_differences), number_of_randomizations) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), all_differences)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')

        assert(iscell(p1) && ...
            isequal(numel(p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), p1)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')
        
        assert(iscell(p2) && ...
            isequal(numel(p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), p2)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')
        
        assert(iscell(confidence_interval_min) && ...
            isequal(numel(confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), confidence_interval_min)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')

        assert(iscell(confidence_interval_max) && ...
            isequal(numel(confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), confidence_interval_max)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')

    end
end

%% Test 3: Initialize with values
for i = 1:1:numel(measures)
    % setup
    number_of_randomizations = 10;

    A = rand(atlas.getBrainRegions().length());
    g = Graph.getGraph('GraphWU', A);
    m  = Measure.getMeasure(measures{i}, g);
    value = m.getValue();
    
    % the values are not realistic, just the right format
    value_group = value;
    value_random = value;
    difference = value;
    all_differences = repmat(value, 1, number_of_permutations);
    p1 = difference;
    p2 = difference;
    confidence_interval_min = difference;
    confidence_interval_max = difference;

    % act
    randomcomparison = RandomComparisonMRI('rc1', ...
        'random comparison label', ...
        'random comparison notes', ...
        atlas, ...
        measures{i}, ...
        group, ...
        'RandomComparisonMRI.RandomizationNumber', number_of_randomizations, ...
        'RandomComparisonMRI.value_group', value_group, ...
        'RandomComparisonMRI.value_random', value_random, ...
        'RandomComparisonMRI.difference', difference, ...
        'RandomComparisonMRI.all_differences', all_differences, ...
        'RandomComparisonMRI.p1', p1, ...
        'RandomComparisonMRI.p2', p2, ....
        'RandomComparisonMRI.confidence_min', confidence_interval_min, ...
        'RandomComparisonMRI.confidence_max', confidence_interval_max ...
        );
    
    comparison_value_group = randomcomparison.getGroupValue();
    comparison_value_random = randomcomparison.getRandomValue();
    comparison_difference = randomcomparison.getDifference();
    comparison_all_differences = randomcomparison.getAllDifferences();
    comparison_p1 = randomcomparison.getP1();
    comparison_p2 = randomcomparison.getP2();
    comparison_confidence_interval_min = randomcomparison.getConfidenceIntervalMin();
    comparison_confidence_interval_max = randomcomparison.getConfidenceIntervalMax();
    
    % assert
    if Measure.is_global(measures{i})
        
        assert(iscell(comparison_value_group) && ...
            isequal(numel(comparison_value_group), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_value_group)) , ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with global measures')
        
        assert(iscell(comparison_value_random) && ...
            isequal(numel(comparison_value_random), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_value_random)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with global measures')
        
        assert(iscell(comparison_difference) && ...
            isequal(numel(comparison_difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_difference)), ...        
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with global measures')
        
        assert(iscell(comparison_all_differences) && ...
            isequal(numel(comparison_all_differences), number_of_permutations) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_all_differences)), ...        
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with global measures')
        
        assert(iscell(comparison_p1) && ...
            isequal(numel(comparison_p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_p1)), ...        
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with global measures')

        assert(iscell(comparison_p2) && ...
            isequal(numel(comparison_p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_p2)), ...
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with global measures')
        
        assert(iscell(comparison_confidence_interval_min) && ...
            isequal(numel(comparison_confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_confidence_interval_min)), ...
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with global measures')

        assert(iscell(comparison_confidence_interval_max) && ...
            isequal(numel(comparison_confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), comparison_confidence_interval_max)), ...
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with global measures')
        
    elseif Measure.is_nodal(measures{i})
        
        assert(iscell(comparison_value_group) && ...
            isequal(numel(comparison_value_group), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_value_group)) , ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')
        
        assert(iscell(comparison_value_random) && ...
            isequal(numel(comparison_value_random), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_value_random)) , ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with nodal measures')
        
        assert(iscell(comparison_difference) && ...
            isequal(numel(comparison_difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_difference)), ...        
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with nodal measures')
        
        assert(iscell(comparison_all_differences) && ...
            isequal(numel(comparison_all_differences), number_of_permutations) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_all_differences)), ...        
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with nodal measures')
        
        assert(iscell(comparison_p1) && ...
            isequal(numel(comparison_p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_p1)), ...        
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with nodal measures')

        assert(iscell(comparison_p2) && ...
            isequal(numel(comparison_p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_p2)), ...
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with nodal measures')
        
        assert(iscell(comparison_confidence_interval_min) && ...
            isequal(numel(comparison_confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_confidence_interval_min)), ...
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with nodal measures')

        assert(iscell(comparison_confidence_interval_max) && ...
            isequal(numel(comparison_confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), comparison_confidence_interval_max)), ...
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with nodal measures')
        
    elseif Measure.is_binodal(measures{i})
        
        assert(iscell(comparison_value_group) && ...
            isequal(numel(comparison_value_group), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_value_group)) , ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')
        
        assert(iscell(comparison_value_random) && ...
            isequal(numel(comparison_value_random), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_value_random)), ...
            [BRAPH2.STR ':RandomComparisonMRI:' BRAPH2.BUG_FUNC], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')
        
        assert(iscell(comparison_difference) && ...
            isequal(numel(comparison_difference), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_difference)), ...        
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')
        
        assert(iscell(comparison_all_differences) && ...
            isequal(numel(comparison_all_differences), number_of_permutations) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_all_differences)), ...        
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')
        
        assert(iscell(comparison_p1) && ...
            isequal(numel(comparison_p1), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_p1)), ...        
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')

        assert(iscell(comparison_p2) && ...
            isequal(numel(comparison_p2), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_p2)), ...
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')
        
        assert(iscell(comparison_confidence_interval_min) && ...
            isequal(numel(comparison_confidence_interval_min), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_confidence_interval_min)), ...
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')

        assert(iscell(comparison_confidence_interval_max) && ...
            isequal(numel(comparison_confidence_interval_max), 1) && ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), comparison_confidence_interval_max)), ...
            [BRAPH2.STR ':AnalysisMRI:' BRAPH2.WRONG_OUTPUT], ...
            'RandomComparisonMRI does not initialize correctly with binodal measures')

    end  
end