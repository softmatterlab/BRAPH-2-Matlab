%% ¡header!
CompareEnsemble < ConcreteElement (c, ensemble-based comparison) is a comparison between two ensemble-based analyses.

%%% ¡description!
CompareEnsemble compares two ensemble-based analyses, 
which need to be of the same class.

%%% ¡seealso!
AnalyzeEnsemble, ComparisonEnsemble

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
CompareEnsemble.ID
%%%% ¡title!
Comparison ID

%%% ¡prop!
%%%% ¡id!
CompareEnsemble.LABEL
%%%% ¡title!
Comparison NAME

%%% ¡prop!
%%%% ¡id!
CompareEnsemble.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
CompareEnsemble.VERBOSE
%%%% ¡title!
VERBOSE ON/OFF

%%% ¡prop!
%%%% ¡id!
CompareEnsemble.P
%%%% ¡title!
PERMUTATION NUMBER

%%% ¡prop!
%%%% ¡id!
CompareEnsemble.LONGITUDINAL
%%%% ¡title!
LONGITUDINAL COMPARISON

%%% ¡prop!
%%%% ¡id!
CompareEnsemble.CP_DICT
%%%% ¡title!
COMPARISONS

%%% ¡prop!
%%%% ¡id!
CompareEnsemble.NOTES
%%%% ¡title!
Comparison NOTES

%%% ¡prop!
%%%% ¡id!
CompareEnsemble.MEMORIZE
%%%% ¡title!
Memorize Intermediate Results

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'CompareEnsemble'

%%% ¡prop!
NAME (constant, string) is the name of the comparison between two ensemble-based analyses.
%%%% ¡default!
'CompareEnsemble'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the comparison between two ensemble-based analyses.
%%%% ¡default!
'CompareEnsemble compares two ensemble-based analyses, which need to be of the same class.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the comparison between two ensemble-based analyses.
%%%% ¡settings!
'CompareEnsemble'

%%% ¡prop!
ID (data, string) is a few-letter code for the comparison between two ensemble-based analyses.
%%%% ¡default!
'CompareEnsemble ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the comparison between two ensemble-based analyses.
%%%% ¡default!
'CompareEnsemble label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the comparison between two ensemble-based analyses.
%%%% ¡default!
'CompareEnsemble notes'

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
MEMORIZE (metadata, logical) sets whether to memorize the permuted analyses.

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
'AnalyzeEnsemble'
%%%% ¡check_value!
check = isa(value, c.get('A2').getClass());

%%% ¡prop!
A2 (data, item) is the second analysis to compare.
%%%% ¡settings!
'AnalyzeEnsemble'
%%%% ¡check_value!
check = isa(value, c.get('A1').getClass());

%%% ¡prop!
PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
%%%% ¡calculate!
value = randi(intmax('uint32'), 1, c.get('P'));

%%% ¡prop!
A1_PERM_DICT (result, idict) is the list of permuted analyses for the first analysis.
%%%% ¡settings!
'AnalyzeEnsemble'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'AnalyzeEnsemble', 'IT_KEY', 1);

%%% ¡prop!
A2_PERM_DICT (result, idict) is the list of permuted analyses for the second analysis.
%%%% ¡settings!
'AnalyzeEnsemble'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'AnalyzeEnsemble', 'IT_KEY', 1);

%%% ¡prop!
CP_DICT (result, idict) contains the results of the comparison.
%%%% ¡settings!
'ComparisonEnsemble'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'ComparisonEnsemble', 'IT_KEY', ComparisonEnsemble.MEASURE);
%%%% ¡gui!
pr = CompareEnsemblePP_CpDict('EL', c, 'PROP', CompareEnsemble.CP_DICT, ...
    'WAITBAR', c.getCallback('WAITBAR'), ...
    varargin{:});

%%% ¡prop!
COMPARISON (query, item) returns a comparison.
%%%% ¡settings!
'ComparisonEnsemble'
%%%% ¡calculate!
% CP = c.get('COMPARISON', MEASURE_CLASS) checks if the comparison exists 
%  in the comparison dictionary CP_DICT. If not, it creates a new comparison
%  CP of class MEASURE_CLASS. The user must call getValue() for the new
%  comparison CP to retrieve the value of the comparison. 
if isempty(varargin)
    value = ComparisonEnsemble();
    
    % % Warning commented because it most likely will lead to an error anyways
    % warning( ...
    %     [BRAPH2.STR ':' class(g)], ...
    %     [BRAPH2.STR ':' class(g) '\\n' ...
    %     'Missing argument MEASURE_CLASS when using CompareGroup.get(''COMPARISON'', MEASURE_CLASS).'] ...
    %     )
    
    return
end
measure_class = varargin{1};

g = c.get('A1').get('GRAPH_TEMPLATE');
m_list = g.get('COMPATIBLE_MEASURES');
assert( ...
    contains(measure_class, m_list), ...
    [BRAPH2.STR ':CompareEnsemble:' BRAPH2.WRONG_INPUT], ...
    [BRAPH2.STR ':CompareEnsemble:' BRAPH2.WRONG_INPUT ' \\n' ...
	 c.get('A1').getClass() ' utilizes graphs of type ' g.getClass() '. \\n' ...
     measure_class ' is not a compatible Measure with ' g.getClass() '. \\n' ...
    'Use ' g.getClass() '().get(''COMPATIBLE_MEASURES'') for a list of compatible measures.']);


cp_dict = c.memorize('CP_DICT');
if cp_dict.get('CONTAINS_KEY', measure_class)
	cp = cp_dict.get('IT', measure_class);
else
    cp = ComparisonEnsemble( ...
        'ID', [measure_class ' comparison ' c.get('A1').get('ID') ' vs. ' c.get('A2').get('ID')], ...
        'MEASURE', measure_class, ...
        'C', c ...
        );
	cp_dict.get('ADD', cp);
end

value = cp;


%%% ¡prop!
PERM (query, itemlist) returns the permuted analyses.
%%%% ¡calculate!
% {A1P, A2P} = c.get('PERM', I) retunrs the I-th permutations for the analysis
%  A1P and A2P. The number of perutations must be smaller than the
%  permutation number P, which is one of the properties of the comparison.
%
% {A1P, A2P} = c.get(C, I, true) memorizes the resulting permutations.
i = 1;
if length(varargin) >= 1
    i = varargin{1};
end 
memorize = false;
if length(varargin) >= 2
    memorize = varargin{2};
end

a1 = c.get('A1');
key1 = [a1.get('ID') ' permutation ' int2str(i)];

a2 = c.get('A2');
key2 = [a2.get('ID') ' permutation ' int2str(i)];

a1_perm_dict = c.memorize('A1_PERM_DICT');
a2_perm_dict = c.memorize('A2_PERM_DICT');
if a1_perm_dict.get('CONTAINS_KEY', key1) && a2_perm_dict.get('CONTAINS_KEY', key2)
	% retrieves if already memorized
    a1_perm = a1_perm_dict.get('IT', key1);
    a2_perm = a2_perm_dict.get('IT', key2);
else    
    % permutation
    seeds = c.get('PERM_SEEDS');
    rng(seeds(i), 'twister')

    subs1 = a1.get('GR').get('SUB_DICT').get('IT_LIST');
    subs2 = a2.get('GR').get('SUB_DICT').get('IT_LIST');

    gdict1 = a1.get('G_DICT').get('IT_LIST');
    gdict2 = a2.get('G_DICT').get('IT_LIST');

    subs1_gdict1 = cellfun(@(x, y) {x, y}, subs1, gdict1, 'UniformOutput', false);
    subs2_gdict2 = cellfun(@(x, y) {x, y}, subs2, gdict2, 'UniformOutput', false);

    [subs1_gdict1_perm, subs2_gdict2_perm] = permutation(subs1_gdict1, subs2_gdict2, c.get('LONGITUDINAL'));

    gr1 = a1.get('GR');
    a1_perm = eval([a1.getClass() '(''TEMPLATE'', a1)']); % % % a1_perm = c.get('A1').clone();
    a1_perm.set( ...
        'ID', key1, ...
        'GR', Group('TEMPLATE', gr1) ... % % % c.get('A1').get('GR').clone() ...
        )
    a1_perm.get('GR').set('SUB_DICT', IndexedDictionary('TEMPLATE', gr1.get('SUB_DICT'))) % % % a1_perm.get('GR').set('SUB_DICT', c.get('A1').get('GR').get('SUB_DICT').clone())
	a1_perm.get('GR').get('SUB_DICT').set('IT_LIST', cellfun(@(x) x(1), subs1_gdict1_perm))
    a1_perm.memorize('G_DICT').set('IT_LIST', cellfun(@(x) x(2), subs1_gdict1_perm))

    gr2 = a2.get('GR');
    a2_perm = eval([a2.getClass() '(''TEMPLATE'', a2)']); % % % a2_perm = c.get('A1').clone(); % a2_perm = c.get('A2').clone();
    a2_perm.set( ...
        'ID', key2, ...
        'GR', Group('TEMPLATE', gr2) ... % % % c.get('A2').get('GR').clone() ...
        )
    a2_perm.get('GR').set('SUB_DICT', IndexedDictionary('TEMPLATE', gr2.get('SUB_DICT'))) % % % a2_perm.get('GR').set('SUB_DICT', c.get('A2').get('GR').get('SUB_DICT').clone())
	a2_perm.get('GR').get('SUB_DICT').set('IT_LIST', cellfun(@(x) x(1), subs2_gdict2_perm))
	a2_perm.memorize('G_DICT').set('IT_LIST', cellfun(@(x) x(2), subs2_gdict2_perm))
         
    % memorize permutations if required
    if memorize
        a1_perm_dict.get('ADD', a1_perm)
        a2_perm_dict.get('ADD', a2_perm)
    end
end

value = {a1_perm, a2_perm};

%% ¡tests!

%%% ¡excluded_props!
[CompareEnsemble.PERM]