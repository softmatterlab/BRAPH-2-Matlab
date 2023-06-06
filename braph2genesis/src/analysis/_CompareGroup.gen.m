%% ¡header!
CompareGroup < ConcreteElement (c, group-based comparison) is a comparison between two group-based analyses.

%%% ¡description!
CompareGroup compares two group-based analyses, which need to be of the same class.

%%% ¡seealso!
AnalyzeGroup, ComparisonGroup

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the group-based comparison.
%%%% ¡default!
'CompareGroup'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the group-based comparison.
%%%% ¡default!
'CompareGroup compares two group-based analyses, which need to be of the same class.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the group-based comparison.

%%% ¡prop!
ID (data, string) is a few-letter code for the group-based comparison.
%%%% ¡default!
'CompareGroup ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group-based comparison.
%%%% ¡default!
'CompareGroup label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group-based comparison.
%%%% ¡default!
'CompareGroup notes'

%% ¡props!

%%% ¡prop!
WAITBAR (gui, logical) detemines whether to show the waitbar.
%%%% ¡default!
true

%%% ¡prop!
VERBOSE (gui, logical) sets whether to write the progress of the comparisons.
%%%% ¡default!
false

%%% ¡prop!
INTERRUPTIBLE (gui, scalar) sets whether the comparison computation is interruptible for multitasking.
%%%% ¡default!
.001

%%% ¡prop!
MEMORIZE (metadata, logical) sets whether to memorize the permuted analysis.

%%% ¡prop!
P (parameter, scalar) is the permutation number.
%%%% ¡default!
1e+4
%%%% ¡check_prop!
check = value > 0 && value == round(value);

%%% ¡prop!
LONGITUDINAL (parameter, logical) determines whether the comparison is longitudinal.

%%% ¡prop!
A1 (data, item) is the first analysis to compare.
%%%% ¡settings!
'AnalyzeGroup'
%%%% ¡check_value!
check = isa(value, c.get('A2').getClass());

%%% ¡prop!
A2 (data, item) is the second analysis to compare.
%%%% ¡settings!
'AnalyzeGroup'
%%%% ¡check_value!
check = isa(value, c.get('A1').getClass());

%%% ¡prop!
PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
%%%% ¡calculate!
value = randi(intmax('uint32'), 1, c.get('P'));

%%% ¡prop!
A1_PERM_DICT (result, idict) is the list of permuted analyses for the first analysis.
%%%% ¡settings!
'AnalyzeGroup'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'AnalyzeGroup');

%%% ¡prop!
A2_PERM_DICT (result, idict) is the list of permuted analyses for the second analysis.
%%%% ¡settings!
'AnalyzeGroup'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'AnalyzeGroup');

%%% ¡prop!
CP_DICT (result, idict) contains the results of the comparison.
%%%% ¡settings!
'ComparisonGroup'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'ComparisonGroup', 'IT_KEY', ComparisonGroup.MEASURE);
%%%% ¡_gui!
% % % pr = PPCompareGroup_CpDict('EL', c, 'PROP', CompareGroup.CP_DICT, 'WAITBAR', Callback('EL', c, 'TAG', 'WAITBAR'), varargin{:});

%%% ¡prop!
COMPARISON (query, item) returns a comparison.
%%%% ¡settings!
'ComparisonGroup'
%%%% ¡calculate!
% CP = g.get(''COMPARISON'', MEASURE_CLASS) checks if the comparison exists in the
%  comparison dictionary CP_DICT. If not, it creates a new comparison
%  CP of class MEASURE_CLASS. The user must call getValue() for the new
%  comparison CP to retrieve the value of the comparison. 
if isempty(varargin)
    value = ComparisonGroup();
    
    % % Warning commented because it most likely will lead to an error anyways
    % warning( ...
    %     [BRAPH2.STR ':' class(g)], ...
    %     [BRAPH2.STR ':' class(g) '\\n' ...
    %     'Missing argument MEASURE_CLASS when using CompareGroup.get(''COMPARISON'', MEASURE_CLASS).'] ...
    %     )
    
    return
end
measure_class = varargin{1};

g = c.get('A1').get('G');
m_list = g.get('COMPATIBLE_MEASURES');
assert( ...
    contains(measure_class, m_list), ...
    [BRAPH2.STR ':AnalyzeGroup:' BRAPH2.WRONG_INPUT], ...
    [BRAPH2.STR ':AnalyzeGroup:' BRAPH2.WRONG_INPUT ' \\n' ...
	 c.get('A1').getClass() ' utilizes Graphs of type ' g.getClass() '. \\n' ...
     measure_class ' is not a compatible Measure with ' g.getClass() '. \\n' ...
    'Use ' g.getClass() '.get(''COMPATIBLE_MEASURES'') for a list of compatible measures.']);

cp_dict = c.memorize('CP_DICT');
if cp_dict.get('CONTAINS_KEY', measure_class)
    cp = cp_dict.get('IT', measure_class);
else
    cp = ComparisonGroup( ...
        'ID', [measure_class ' comparison ' c.get('A1').get('ID') ' vs. ' c.get('A2').get('ID')], ...
        'MEASURE', measure_class, ...
        'MEASURE_TEMPLATE', c.memorize('A1').memorize('G').get('MEASURE', measure_class), ... % % % Check whether to improve how to deal with template for measure
        'C', c ...
        );
    
    cp_dict.get('ADD', cp);
end

%%% ¡prop!
PERM (query, itemlist) returns the permuted analyses.
%%%% ¡_calculate!
% [A1P, A2P] = g.get('PERM', I) retunrs the I-th permutations for the analysis
%  A1P and A2P. The number of perutations must be smaller than the
%  permutation number P, which is one of the properties of the comparison.
%
% [A1P, A2P] = g.get('PERM', I, true) memorizes the resulting permutations.
i = 1;
if length(varargin) >= 1
    i = varargin{1};
end 
memorize = false;
if length(varargin) >= 2
    memorize = varargin{2};
end

a1_perm_dict = c.memorize('A1_PERM_DICT');
a2_perm_dict = c.memorize('A2_PERM_DICT');
if a1_perm_dict.get('CONTAINS_INDEX', i) && a2_perm_dict.get('CONTAINS_INDEX', i)
    % retrieves if already memorized
    a1_perm = a1_perm_dict.get('IT', i);
    a2_perm = a2_perm_dict.get('IT', i);
else    
    % permutation
    seeds = c.get('PERM_SEEDS');
    rng(seeds(i), 'twister')

    subs1 = c.get('A1').get('GR').get('SUB_DICT').get('IT_LIST');
    subs2 = c.get('A2').get('GR').get('SUB_DICT').get('IT_LIST');

    [subs1_perm, subs2_perm] = permutation(subs1, subs2, c.get('LONGITUDINAL'));

    a1_perm = c.get('A1').clone();
    a1_perm.set( ...
        'ID', [c.get('A1').get('ID') ' permutation ' int2str(i)], ...
        'GR', c.get('A1').get('GR').clone() ...
        )
    a1_perm.get('GR').set('SUB_DICT', c.get('A1').get('GR').get('SUB_DICT').clone())
    a1_perm.get('GR').get('SUB_DICT').set('IT_LIST', subs1_perm)

    a2_perm = c.get('A1').clone(); % % % a2_perm = c.get('A2').clone();
    a2_perm.set( ...
        'ID', [c.get('A2').get('ID') ' permutation ' int2str(i)], ...
        'GR', c.get('A2').get('GR').clone() ...
        )
    a2_perm.get('GR').set('SUB_DICT', c.get('A2').get('GR').get('SUB_DICT').clone())
    a2_perm.get('GR').get('SUB_DICT').set('IT_LIST', subs2_perm)

    % memorize permutations if required
    if memorize
        a1_perm_dict.get('ADD', a1_perm)
        a2_perm_dict.get('ADD', a2_perm)
    end
end

value = {a1_perm, a2_perm};