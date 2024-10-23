%% ¡header!
ComparisonGroup < ConcreteElement (cp, group-based comparison result) contains the result of a group-based comparison.

%%% ¡description!
ComparisonGroup contains the results of a group-based comparison for a given measure.
Specifically, it contains the one-tailed and two-tailed p-values and the 95%% confidence interval.

%%% ¡seealso!
AnalyzeGroup, CompareGroup

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonGroup.ID
%%%% ¡title!
Measure Comparison ID

%%% ¡prop!
%%%% ¡id!
ComparisonGroup.LABEL
%%%% ¡title!
Measure Comparison NAME

%%% ¡prop!
%%%% ¡id!
ComparisonGroup.MEASURE
%%%% ¡title!
Measure

%%% ¡prop!
%%%% ¡id!
ComparisonGroup.DIFF
%%%% ¡title!
DIFFERENCE

%%% ¡prop!
%%%% ¡id!
ComparisonGroup.P1
%%%% ¡title!
P1

%%% ¡prop!
%%%% ¡id!
ComparisonGroup.P2
%%%% ¡title!
P2

%%% ¡prop!
%%%% ¡id!
ComparisonGroup.CIL
%%%% ¡title!
Lower value of 95% confidence interval

%%% ¡prop!
%%%% ¡id!
ComparisonGroup.CIU
%%%% ¡title!
Upper value of 95% confidence interval

%%% ¡prop!
%%%% ¡id!
ComparisonGroup.PFC
%%%% ¡title!
Measure Comparison Plot

%%% ¡prop!
%%%% ¡id!
ComparisonGroup.PFBG
%%%% ¡title!
Measure Comparison Brain Graph

%%% ¡prop!
%%%% ¡id!
ComparisonGroup.NOTES
%%%% ¡title!
Comparison NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonGroup'

%%% ¡prop!
NAME (constant, string) is the name of the group-based comparison result.
%%%% ¡default!
'ComparisonGroup'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the group-based comparison result.
%%%% ¡default!
'ComparisonGroup contains the results of a group-based comparison for a given measure. Specifically, it contains the one-tailed and two-tailed p-values and the 95%% confidence interval.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the group-based comparison result.
%%%% ¡settings!
'ComparisonGroup'

%%% ¡prop!
ID (data, string) is a few-letter code for the group-based comparison result.
%%%% ¡default!
'ComparisonGroup ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group-based comparison result.
%%%% ¡default!
'ComparisonGroup label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group-based comparison result.
%%%% ¡default!
'ComparisonGroup notes'

%% ¡props!

%%% ¡prop!
MEASURE (parameter, class) is the measure class.
%%%% ¡settings!
'Measure'

%%% ¡prop!
C (data, item) is the group-based comparison.
%%%% ¡settings!
'CompareGroup'

%%% ¡prop!
DIFF (result, cell) is the group comparison value.
%%%% ¡calculate!
results = cp.memorize('CALCULATE_RESULTS');
value = results{1}; % diff
%%%% ¡gui!
g = cp.get('C').get('A1').get('G');
measure = cp.get('MEASURE');

% PanelPropCell('EL', cp, 'PROP', ComparisonGroup.DIFF, varargin{:});
pr = PanelPropCellFDR('EL', cp, 'PROP', ComparisonGroup.DIFF,  ...
    'TABLEQVALUE', cp.get('QVALUE'), 'TABLEFDR', true, varargin{:}); 

if Element.getPropDefault(measure, 'SHAPE') == Measure.GLOBAL % __Measure.GLOBAL__
    pr.set( ...
        'TABLE_HEIGHT', s(4), ...
        'ROWNAME', {}, ...
        'COLUMNNAME', {} ...
        )
elseif Element.getPropDefault(measure, 'SHAPE') == Measure.NODAL % __Measure.NODAL__
    pr.set( ...
        'TABLE_HEIGHT', s(40), ...
        'ROWNAME', g.getCallback('ANODELABELS'), ...
        'COLUMNNAME', {} ...
        )
elseif Element.getPropDefault(measure, 'SHAPE') == Measure.BINODAL % __Measure.BINODAL__
    pr.set( ...
        'TABLE_HEIGHT', s(40), ...
        'ROWNAME', g.getCallback('ANODELABELS'), ...
        'COLUMNNAME', g.getCallback('ANODELABELS') ...
        )
end

if g.get('LAYERNUMBER') == 1
    pr.set( ...
        'XSLIDERSHOW', false, ...
        'YSLIDERSHOW', false ...
        )
else % multigraph, multiplex, multilayer
    if  Element.getPropDefault(measure, 'SCOPE') == Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
        if isempty(g.get('APARTITIONLABELS'))
            pr.set( ...
                'XSLIDERSHOW', false, ...
                'YSLIDERSHOW', false ...
                )
        else
            pr.set( ...
                'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * length(g.get('APARTITIONLABELS'))), ...
                'XSLIDERSHOW', false, ...
                'YSLIDERSHOW', true, ...
                'YSLIDERLABELS', g.getCallback('APARTITIONLABELS'), ...
                'YSLIDERWIDTH', s(5) ...
                )
        end
    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.UNILAYER % __Measure.UNILAYER__
        pr.set( ...
            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
            'XSLIDERSHOW', false, ...
            'YSLIDERSHOW', true, ...
            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'YSLIDERWIDTH', s(5) ...
            )
    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.BILAYER % __Measure.BILAYER__
        pr.set( ...
            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), s(3) + s(1) * g.get('LAYERNUMBER')), ...
            'XSLIDERSHOW', true, ...
            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'XSLIDERHEIGHT', s(3), ...
            'YSLIDERSHOW', true, ...
            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'YSLIDERWIDTH', s(5) ...
            )
    end
end

%%% ¡prop!
P1 (result, cell) is the one-tailed p-value.
%%%% ¡calculate!
results = cp.memorize('CALCULATE_RESULTS');
value = results{2}; % p1
%%%% ¡gui!
g = cp.get('C').get('A1').get('G');
measure = cp.get('MEASURE');

pr = PanelPropCell('EL', cp, 'PROP', ComparisonGroup.P1, varargin{:});

if Element.getPropDefault(measure, 'SHAPE') == Measure.GLOBAL % __Measure.GLOBAL__
    pr.set( ...
        'TABLE_HEIGHT', s(4), ...
        'ROWNAME', {}, ...
        'COLUMNNAME', {} ...
        )
elseif Element.getPropDefault(measure, 'SHAPE') == Measure.NODAL % __Measure.NODAL__
    pr.set( ...
        'TABLE_HEIGHT', s(40), ...
        'ROWNAME', g.getCallback('ANODELABELS'), ...
        'COLUMNNAME', {} ...
        )
elseif Element.getPropDefault(measure, 'SHAPE') == Measure.BINODAL % __Measure.BINODAL__
    pr.set( ...
        'TABLE_HEIGHT', s(40), ...
        'ROWNAME', g.getCallback('ANODELABELS'), ...
        'COLUMNNAME', g.getCallback('ANODELABELS') ...
        )
end

if g.get('LAYERNUMBER') == 1
    pr.set( ...
        'XSLIDERSHOW', false, ...
        'YSLIDERSHOW', false ...
        )
else % multigraph, multiplex, multilayer
    if  Element.getPropDefault(measure, 'SCOPE') == Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
        if isempty(g.get('APARTITIONLABELS'))
            pr.set( ...
                'XSLIDERSHOW', false, ...
                'YSLIDERSHOW', false ...
                )
        else
            pr.set( ...
                'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * length(g.get('APARTITIONLABELS'))), ...
                'XSLIDERSHOW', false, ...
                'YSLIDERSHOW', true, ...
                'YSLIDERLABELS', g.getCallback('APARTITIONLABELS'), ...
                'YSLIDERWIDTH', s(5) ...
                )
        end
    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.UNILAYER % __Measure.UNILAYER__
        pr.set( ...
            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
            'XSLIDERSHOW', false, ...
            'YSLIDERSHOW', true, ...
            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'YSLIDERWIDTH', s(5) ...
            )
    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.BILAYER % __Measure.BILAYER__
        pr.set( ...
            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), s(3) + s(1) * g.get('LAYERNUMBER')), ...
            'XSLIDERSHOW', true, ...
            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'XSLIDERHEIGHT', s(3), ...
            'YSLIDERSHOW', true, ...
            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'YSLIDERWIDTH', s(5) ...
            )
    end
end

%%% ¡prop!
P2 (result, cell) is the two-tailed p-value.
%%%% ¡calculate!
results = cp.memorize('CALCULATE_RESULTS');
value = results{3}; % p2
%%%% ¡gui!
g = cp.get('C').get('A1').get('G');
measure = cp.get('MEASURE');

pr = PanelPropCell('EL', cp, 'PROP', ComparisonGroup.P2, varargin{:});

if Element.getPropDefault(measure, 'SHAPE') == Measure.GLOBAL % __Measure.GLOBAL__
    pr.set( ...
        'TABLE_HEIGHT', s(4), ...
        'ROWNAME', {}, ...
        'COLUMNNAME', {} ...
        )
elseif Element.getPropDefault(measure, 'SHAPE') == Measure.NODAL % __Measure.NODAL__
    pr.set( ...
        'TABLE_HEIGHT', s(40), ...
        'ROWNAME', g.getCallback('ANODELABELS'), ...
        'COLUMNNAME', {} ...
        )
elseif Element.getPropDefault(measure, 'SHAPE') == Measure.BINODAL % __Measure.BINODAL__
    pr.set( ...
        'TABLE_HEIGHT', s(40), ...
        'ROWNAME', g.getCallback('ANODELABELS'), ...
        'COLUMNNAME', g.getCallback('ANODELABELS') ...
        )
end

if g.get('LAYERNUMBER') == 1
    pr.set( ...
        'XSLIDERSHOW', false, ...
        'YSLIDERSHOW', false ...
        )
else % multigraph, multiplex, multilayer
    if  Element.getPropDefault(measure, 'SCOPE') == Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
        if isempty(g.get('APARTITIONLABELS'))
            pr.set( ...
                'XSLIDERSHOW', false, ...
                'YSLIDERSHOW', false ...
                )
        else
            pr.set( ...
                'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * length(g.get('APARTITIONLABELS'))), ...
                'XSLIDERSHOW', false, ...
                'YSLIDERSHOW', true, ...
                'YSLIDERLABELS', g.getCallback('APARTITIONLABELS'), ...
                'YSLIDERWIDTH', s(5) ...
                )
        end
    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.UNILAYER % __Measure.UNILAYER__
        pr.set( ...
            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
            'XSLIDERSHOW', false, ...
            'YSLIDERSHOW', true, ...
            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'YSLIDERWIDTH', s(5) ...
            )
    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.BILAYER % __Measure.BILAYER__
        pr.set( ...
            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), s(3) + s(1) * g.get('LAYERNUMBER')), ...
            'XSLIDERSHOW', true, ...
            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'XSLIDERHEIGHT', s(3), ...
            'YSLIDERSHOW', true, ...
            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'YSLIDERWIDTH', s(5) ...
            )
    end
end

%%% ¡prop!
CIL (result, cell) is the lower value of the 95%% confidence interval.
%%%% ¡calculate!
results = cp.memorize('CALCULATE_RESULTS');
value = results{4}; % ci_lower
%%%% ¡gui!
g = cp.get('C').get('A1').get('G');
measure = cp.get('MEASURE');

pr = PanelPropCell('EL', cp, 'PROP', ComparisonGroup.CIL, varargin{:});

if Element.getPropDefault(measure, 'SHAPE') == Measure.GLOBAL % __Measure.GLOBAL__
    pr.set( ...
        'TABLE_HEIGHT', s(4), ...
        'ROWNAME', {}, ...
        'COLUMNNAME', {} ...
        )
elseif Element.getPropDefault(measure, 'SHAPE') == Measure.NODAL % __Measure.NODAL__
    pr.set( ...
        'TABLE_HEIGHT', s(40), ...
        'ROWNAME', g.getCallback('ANODELABELS'), ...
        'COLUMNNAME', {} ...
        )
elseif Element.getPropDefault(measure, 'SHAPE') == Measure.BINODAL % __Measure.BINODAL__
    pr.set( ...
        'TABLE_HEIGHT', s(40), ...
        'ROWNAME', g.getCallback('ANODELABELS'), ...
        'COLUMNNAME', g.getCallback('ANODELABELS') ...
        )
end

if g.get('LAYERNUMBER') == 1
    pr.set( ...
        'XSLIDERSHOW', false, ...
        'YSLIDERSHOW', false ...
        )
else % multigraph, multiplex, multilayer
    if  Element.getPropDefault(measure, 'SCOPE') == Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
        if isempty(g.get('APARTITIONLABELS'))
            pr.set( ...
                'XSLIDERSHOW', false, ...
                'YSLIDERSHOW', false ...
                )
        else
            pr.set( ...
                'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * length(g.get('APARTITIONLABELS'))), ...
                'XSLIDERSHOW', false, ...
                'YSLIDERSHOW', true, ...
                'YSLIDERLABELS', g.getCallback('APARTITIONLABELS'), ...
                'YSLIDERWIDTH', s(5) ...
                )
        end
    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.UNILAYER % __Measure.UNILAYER__
        pr.set( ...
            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
            'XSLIDERSHOW', false, ...
            'YSLIDERSHOW', true, ...
            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'YSLIDERWIDTH', s(5) ...
            )
    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.BILAYER % __Measure.BILAYER__
        pr.set( ...
            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), s(3) + s(1) * g.get('LAYERNUMBER')), ...
            'XSLIDERSHOW', true, ...
            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'XSLIDERHEIGHT', s(3), ...
            'YSLIDERSHOW', true, ...
            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'YSLIDERWIDTH', s(5) ...
            )
    end
end

%%% ¡prop!
CIU (result, cell) is the upper value of the 95%% confidence interval.
%%%% ¡calculate!
results = cp.memorize('CALCULATE_RESULTS');
value = results{5}; % ci_upper
%%%% ¡gui!
g = cp.get('C').get('A1').get('G');
measure = cp.get('MEASURE');

pr = PanelPropCell('EL', cp, 'PROP', ComparisonGroup.CIU, varargin{:});

if Element.getPropDefault(measure, 'SHAPE') == Measure.GLOBAL % __Measure.GLOBAL__
    pr.set( ...
        'TABLE_HEIGHT', s(4), ...
        'ROWNAME', {}, ...
        'COLUMNNAME', {} ...
        )
elseif Element.getPropDefault(measure, 'SHAPE') == Measure.NODAL % __Measure.NODAL__
    pr.set( ...
        'TABLE_HEIGHT', s(40), ...
        'ROWNAME', g.getCallback('ANODELABELS'), ...
        'COLUMNNAME', {} ...
        )
elseif Element.getPropDefault(measure, 'SHAPE') == Measure.BINODAL % __Measure.BINODAL__
    pr.set( ...
        'TABLE_HEIGHT', s(40), ...
        'ROWNAME', g.getCallback('ANODELABELS'), ...
        'COLUMNNAME', g.getCallback('ANODELABELS') ...
        )
end

if g.get('LAYERNUMBER') == 1
    pr.set( ...
        'XSLIDERSHOW', false, ...
        'YSLIDERSHOW', false ...
        )
else % multigraph, multiplex, multilayer
    if  Element.getPropDefault(measure, 'SCOPE') == Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
        if isempty(g.get('APARTITIONLABELS'))
            pr.set( ...
                'XSLIDERSHOW', false, ...
                'YSLIDERSHOW', false ...
                )
        else
            pr.set( ...
                'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * length(g.get('APARTITIONLABELS'))), ...
                'XSLIDERSHOW', false, ...
                'YSLIDERSHOW', true, ...
                'YSLIDERLABELS', g.getCallback('APARTITIONLABELS'), ...
                'YSLIDERWIDTH', s(5) ...
                )
        end
    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.UNILAYER % __Measure.UNILAYER__
        pr.set( ...
            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
            'XSLIDERSHOW', false, ...
            'YSLIDERSHOW', true, ...
            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'YSLIDERWIDTH', s(5) ...
            )
    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.BILAYER % __Measure.BILAYER__
        pr.set( ...
            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), s(3) + s(1) * g.get('LAYERNUMBER')), ...
            'XSLIDERSHOW', true, ...
            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'XSLIDERHEIGHT', s(3), ...
            'YSLIDERSHOW', true, ...
            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'YSLIDERWIDTH', s(5) ...
            )
    end
end

%%% ¡prop!
QVALUE (metadata, scalar) is the selected qvalue threshold.
%%%% ¡default!
0.05
%%%% ¡_gui!
% % % pr = PPQValue('EL', cp, 'PROP', ComparisonGroup.QVALUE, varargin{:});

%%% ¡prop!
PFC (gui, item) contains the panel figure of the comparison.
%%%% ¡settings!
'ComparisonGroupPF'
%%%% ¡postprocessing!
if isa(cp.getr('PFC'), 'NoValue')
    
    measure = cp.get('MEASURE');

    switch Element.getPropDefault(measure, 'SHAPE')
        case Measure.GLOBAL % __Measure.GLOBAL__
            switch Element.getPropDefault(measure, 'SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    cp.set('PFC', ComparisonGroupPF_GS('CP', cp))
                case Measure.UNILAYER % __Measure.UNILAYER__
                    cp.set('PFC', ComparisonGroupPF_GU('CP', cp))
                case Measure.BILAYER % __Measure.BILAYER__
                    cp.set('PFC', ComparisonGroupPF_GB('CP', cp))
            end
        case Measure.NODAL % __Measure.NODAL__
            switch Element.getPropDefault(measure, 'SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    cp.set('PFC', ComparisonGroupPF_NS('CP', cp))
                case Measure.UNILAYER % __Measure.UNILAYER__
                    cp.set('PFC', ComparisonGroupPF_NU('CP', cp))
                case Measure.BILAYER % __Measure.BILAYER__
                    cp.set('PFC', ComparisonGroupPF_NB('CP', cp))
            end
        case Measure.BINODAL % __Measure.BINODAL__
            switch Element.getPropDefault(measure, 'SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    cp.set('PFC', ComparisonGroupPF_BS('CP', cp))
                case Measure.UNILAYER % __Measure.UNILAYER__
                    cp.set('PFC', ComparisonGroupPF_BU('CP', cp))
                case Measure.BILAYER % __Measure.BILAYER__
                    cp.set('PFC', ComparisonGroupPF_BB('CP', cp))
            end
    end
end
%%%% ¡gui!
pr = PanelPropItem('EL', cp, 'PROP', ComparisonGroup.PFC, ...
    'GUICLASS', 'GUIFig', ...
	'BUTTON_TEXT', ['Plot ' cp.get('MEASURE') ' Comparison'], ...
    varargin{:});

%%% ¡prop!
PFBG (gui, item) contains the panel figure of the brain graph.
%%%% ¡settings!
'ComparisonGroupBrainPF'
%%%% ¡postprocessing!
if isa(cp.getr('PFBG'), 'NoValue')
    measure = cp.get('MEASURE');
    if cp.get('C').get('A1').get('GR').get('SUB_DICT').get('LENGTH')
        brain_atlas = cp.get('C').get('A1').get('GR').get('SUB_DICT').get('IT', 1).get('BA');
    else
        brain_atlas = BrainAtlas();
    end
    switch Element.getPropDefault(measure, 'SHAPE')
        case Measure.GLOBAL % __Measure.GLOBAL__
            switch Element.getPropDefault(measure, 'SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    cp.set('PFBG', ComparisonGroupBrainPF_GS('CP', cp, 'BA', brain_atlas));
                case Measure.UNILAYER % __Measure.UNILAYER__
                    cp.set('PFBG', ComparisonGroupBrainPF_GU('CP', cp, 'BA', brain_atlas));
                case Measure.BILAYER % __Measure.BILAYER__
                    cp.set('PFBG', ComparisonGroupBrainPF_GB('CP', cp, 'BA', brain_atlas));
            end
        case Measure.NODAL % __Measure.NODAL__
            switch Element.getPropDefault(measure, 'SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    cp.set('PFBG', ComparisonGroupBrainPF_NS('CP', cp, 'BA', brain_atlas));
                case Measure.UNILAYER % __Measure.UNILAYER__
                    cp.set('PFBG', ComparisonGroupBrainPF_NU('CP', cp, 'BA', brain_atlas));
                case Measure.BILAYER % __Measure.BILAYER__
                    cp.set('PFBG', ComparisonGroupBrainPF_NB('CP', cp, 'BA', brain_atlas));
            end
        case Measure.BINODAL % __Measure.BINODAL__
            switch Element.getPropDefault(measure, 'SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    cp.set('PFBG', ComparisonGroupBrainPF_BS('CP', cp, 'BA', brain_atlas));
                case Measure.UNILAYER % __Measure.UNILAYER__
                    cp.set('PFBG', ComparisonGroupBrainPF_BU('CP', cp, 'BA', brain_atlas));
                case Measure.BILAYER % __Measure.BILAYER__
                    cp.set('PFBG', ComparisonGroupBrainPF_BB('CP', cp, 'BA', brain_atlas));
            end
    end
end

%%%% ¡gui!
pr = PanelPropItem('EL', cp, 'PROP', ComparisonGroup.PFBG, ...
    'GUICLASS', 'GUIFig', ...
	'BUTTON_TEXT', ['Brain Graph ' cp.get('MEASURE') ' Comparison'], ...
    varargin{:});

%%% ¡prop!
CALCULATE_RESULTS (evanescent, cell) calculates the comparison results {diff, p1, p2, ci_lower, ci_upper}.
%%%% ¡calculate!
% {DIFF, P1, P2, CIL, CIU} = cp.get('CALCULATE_RESULTS') calcultes the
%  difference, the one-tailed p-value P1, the two-tailed p-value P2,
%  the lower bound of the confidence interval CIL, and the the upper
%  bound of the confidence interval. 
%  Typically, this method is only called internally.

measure_class = cp.get('MEASURE');
if strcmpi(cp.get('MEASURE'), 'Measure')
    diff = {};
    p1 = {};
    p2 = {};
    ci_lower = {};
    ci_upper = {};
    value = {diff, p1, p2, ci_lower, ci_upper};
    return
end
    
c = cp.get('C');

wb = braph2waitbar(c.get('WAITBAR'), 0, ['Comparing group ' cp.get('MEASURE') '...']);

% Measure for groups 1 and 2, and their difference
m1 = c.get('A1').get('G').get('MEASURE', measure_class).memorize('M');
m2 = c.get('A2').get('G').get('MEASURE', measure_class).memorize('M');
diff = cellfun(@(x, y) y - x, m1, m2, 'UniformOutput', false);

% Permutations
P = c.get('P'); %#ok<*PROPLC>

m1_perms = cell(1, P);
m2_perms = cell(1, P);
diff_perms = cell(1, P);

start = tic;
for j = 1:20:P
    parfor i = j:min(j+20, P)
        a1_a2_perms = c.get('PERM', i, c.get('MEMORIZE'));
        a1_perm = a1_a2_perms{1};
        a2_perm = a1_a2_perms{2};

        m1_perms{1, i} = a1_perm.memorize('G').get('MEASURE', measure_class).memorize('M'); %#ok<PFOUS>
        m2_perms{1, i} = a2_perm.memorize('G').get('MEASURE', measure_class).memorize('M'); %#ok<PFOUS>
        diff_perms{1, i} = cellfun(@(x, y) y - x, m1_perms{1, i}, m2_perms{1, i}, 'UniformOutput', false);
    end

    braph2waitbar(wb, j / P, ['Comparing group ' cp.get('MEASURE') '. Permutation ' num2str(j) ' of ' num2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...'])
    if c.get('VERBOSE')
        disp(['** PERMUTATION TEST - sampling #' int2str(j) '/' int2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
    end
    if c.get('INTERRUPTIBLE')
        pause(c.get('INTERRUPTIBLE'))
    end        
end

braph2waitbar(wb, 'close')

% Statistical analysis
p1 = cell(size(diff));
p2 = cell(size(diff));
ci_lower = cell(size(diff));
ci_upper = cell(size(diff));
for i = 1:1:size(diff, 1)
    for j = 1:1:size(diff, 2)
        p1(i, j) = pvalue1(diff(i, j), cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false));
        p2(i, j) = pvalue2(diff(i, j), cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false));
        qtl = quantiles(cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false), 40);
        ci_lower(i, j) = {cellfun(@(x) x(2), qtl)};
        ci_upper(i, j) = {cellfun(@(x) x(40), qtl)};
    end
end

value = {diff, p1, p2, ci_lower, ci_upper};

%% ¡tests!

%%% ¡excluded_props!
[ComparisonGroup.PFC ComparisonGroup.PFBG ComparisonGroup.CALCULATE_RESULTS]
