%% ¡header!
ComparisonEnsemble < ConcreteElement (cp, ensemble-based comparison results) contains the results of an ensemble-based comparison.

%%% ¡description!
ComparisonEnsemble contains the results of an ensemble-based comparison for a given measure.
Specifically, it contains the one-tailed and two-tailed p-values 
and the 95%% confidence interval.

%%% ¡seealso!
CompareEnsemble, AnalyzeEnsemble

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemble.ID
%%%% ¡title!
Measure Comparison ID

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemble.LABEL
%%%% ¡title!
Measure Comparison NAME

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemble.MEASURE
%%%% ¡title!
Measure

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemble.DIFF
%%%% ¡title!
DIFFERENCE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemble.P1
%%%% ¡title!
P1

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemble.P2
%%%% ¡title!
P2

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemble.CIL
%%%% ¡title!
Lower value of 95% confidence interval

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemble.CIU
%%%% ¡title!
Upper value of 95% confidence interval

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemble.QVALUE
%%%% ¡title!
QVALUE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemble.PFC
%%%% ¡title!
Measure Comparison Plot

%%% ¡prop!
%%%% ¡id!
ComparisonEnsemble.PFB
%%%% ¡title!
Measure Comparison Brain

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonEnsemble'

%%% ¡prop!
NAME (constant, string) is the name of the results of an ensemble-based comparison.
%%%% ¡default!
'ComparisonEnsemble'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the results of an ensemble-based comparison.
%%%% ¡default!
'ComparisonEnsemble contains the results of an ensemble-based comparison for a given measure. Specifically, it contains the one-tailed and two-tailed p-values and the 95%% confidence interval.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the results of an ensemble-based comparison.
%%%% ¡settings!
'ComparisonEnsemble'

%%% ¡prop!
ID (data, string) is a few-letter code for the results of an ensemble-based comparison.
%%%% ¡default!
'ComparisonEnsemble ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the results of an ensemble-based comparison.
%%%% ¡default!
'ComparisonEnsemble label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the results of an ensemble-based comparison.
%%%% ¡default!
'ComparisonEnsemble notes'

%% ¡props!

%%% ¡prop!
MEASURE (parameter, class) is the measure class.
%%%% ¡settings!
'Measure'

%%% ¡_prop!
% % % MEASURE_TEMPLATE (data, item) provides the measure parameters.
% % % %%%% ¡_settings!
% % % 'Measure'

%%% ¡prop!
C (data, item) is the ensemble-based comparison.
%%%% ¡settings!
'CompareEnsemble'

%%% ¡prop!
DIFF (result, cell) is the ensemble comparison value.
%%%% ¡calculate!
results = cp.memorize('CALCULATE_RESULTS');
value = results{1}; % diff
%%%% ¡gui!
if cp.get('C').get('A1').get('G_DICT').get('LENGTH')
    g = cp.get('C').get('A1').get('G_DICT').get('IT', 1);
else
    g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
end
g.memorize('A');
measure = cp.get('MEASURE');

pr = PanelPropCellFDR('EL', cp, 'PROP', ComparisonEnsemble.DIFF,  ...
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
if cp.get('C').get('A1').get('G_DICT').get('LENGTH')
    g = cp.get('C').get('A1').get('G_DICT').get('IT', 1);
else
    g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
end
g.memorize('A');
measure = cp.get('MEASURE');

pr = PanelPropCell('EL', cp, 'PROP', ComparisonEnsemble.P1, varargin{:});

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
if cp.get('C').get('A1').get('G_DICT').get('LENGTH')
    g = cp.get('C').get('A1').get('G_DICT').get('IT', 1);
else
    g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
end
g.memorize('A');
measure = cp.get('MEASURE');

pr = PanelPropCell('EL', cp, 'PROP', ComparisonEnsemble.P2, varargin{:});

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
if cp.get('C').get('A1').get('G_DICT').get('LENGTH')
    g = cp.get('C').get('A1').get('G_DICT').get('IT', 1);
else
    g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
end
g.memorize('A');
measure = cp.get('MEASURE');

pr = PanelPropCell('EL', cp, 'PROP', ComparisonEnsemble.CIL, varargin{:});

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
if cp.get('C').get('A1').get('G_DICT').get('LENGTH')
    g = cp.get('C').get('A1').get('G_DICT').get('IT', 1);
else
    g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
end
g.memorize('A');
measure = cp.get('MEASURE');

pr = PanelPropCell('EL', cp, 'PROP', ComparisonEnsemble.CIU, varargin{:});

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
% % % pr = PPQValue('EL', cp, 'PROP', ComparisonEnsemble.QVALUE, varargin{:});

%%% ¡prop!
PFC (gui, item) contains the panel figure of the comparison.
%%%% ¡settings!
'ComparisonEnsemblePF'
%%%% ¡postprocessing!
if isa(cp.getr('PFC'), 'NoValue')

    measure = cp.get('MEASURE');

    switch Element.getPropDefault(measure, 'SHAPE')
        case Measure.GLOBAL % __Measure.GLOBAL__
            switch Element.getPropDefault(measure, 'SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    cp.set('PFC', ComparisonEnsemblePF_GS('CP', cp))
                case Measure.UNILAYER % __Measure.UNILAYER__
                    cp.set('PFC', ComparisonEnsemblePF_GU('CP', cp))
                case Measure.BILAYER % __Measure.BILAYER__
                    cp.set('PFC', ComparisonEnsemblePF_GB('CP', cp))
            end
        case Measure.NODAL % __Measure.NODAL__
            switch Element.getPropDefault(measure, 'SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    cp.set('PFC', ComparisonEnsemblePF_NS('CP', cp))
                case Measure.UNILAYER % __Measure.UNILAYER__
                    cp.set('PFC', ComparisonEnsemblePF_NU('CP', cp))
                case Measure.BILAYER % __Measure.BILAYER__
                    cp.set('PFC', ComparisonEnsemblePF_NB('CP', cp))
            end
        case Measure.BINODAL % __Measure.BINODAL__
            switch Element.getPropDefault(measure, 'SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    cp.set('PFC', ComparisonEnsemblePF_BS('CP', cp))
                case Measure.UNILAYER % __Measure.UNILAYER__
                    cp.set('PFC', ComparisonEnsemblePF_BU('CP', cp))
                case Measure.BILAYER % __Measure.BILAYER__
                    cp.set('PFC', ComparisonEnsemblePF_BB('CP', cp))
            end
    end
end

%%%% ¡gui!
pr = PanelPropItem('EL', cp, 'PROP', ComparisonEnsemble.PFC, ...
    'GUICLASS', 'GUIFig', ...
	'BUTTON_TEXT', ['Plot ' cp.get('MEASURE') ' Comparison'], ...
    varargin{:});

%%% ¡prop!
PFB (gui, item) contains the panel figure of the comparison.
%%%% ¡settings!
'ComparisonEnsembleBrainPF'
%%%% ¡postprocessing!
if isa(cp.getr('PFB'), 'NoValue')

    measure = cp.get('MEASURE');
    if isempty(cp.get('C').get('A1').get('GR').get('SUB_DICT').get('IT_LIST'))
        brain_atlas = BrainAtlas();
    else
        brain_atlas = cp.get('C').get('A1').get('GR').get('SUB_DICT').get('IT', 1).get('BA');
    end
    switch Element.getPropDefault(measure, 'SHAPE')
        case Measure.GLOBAL % __Measure.GLOBAL__
            switch Element.getPropDefault(measure, 'SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    cp.set('PFB', ComparisonEnsembleBrainPF_GS('CP', cp, 'BA', brain_atlas))
                case Measure.UNILAYER % __Measure.UNILAYER__
                    cp.set('PFB', ComparisonEnsembleBrainPF_GU('CP', cp, 'BA', brain_atlas))
                case Measure.BILAYER % __Measure.BILAYER__
                    cp.set('PFB', ComparisonEnsembleBrainPF_GB('CP', cp, 'BA', brain_atlas))
            end
        case Measure.NODAL % __Measure.NODAL__
            switch Element.getPropDefault(measure, 'SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    cp.set('PFB', ComparisonEnsembleBrainPF_NS('CP', cp, 'BA', brain_atlas))
                case Measure.UNILAYER % __Measure.UNILAYER__
                    cp.set('PFB', ComparisonEnsembleBrainPF_NU('CP', cp, 'BA', brain_atlas))
                case Measure.BILAYER % __Measure.BILAYER__
                    cp.set('PFB', ComparisonEnsembleBrainPF_NB('CP', cp, 'BA', brain_atlas))
            end
        case Measure.BINODAL % __Measure.BINODAL__
            switch Element.getPropDefault(measure, 'SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    cp.set('PFB', ComparisonEnsembleBrainPF_BS('CP', cp, 'BA', brain_atlas))
                case Measure.UNILAYER % __Measure.UNILAYER__
                    cp.set('PFB', ComparisonEnsembleBrainPF_BU('CP', cp, 'BA', brain_atlas))
                case Measure.BILAYER % __Measure.BILAYER__
                    cp.set('PFB',ComparisonEnsembleBrainPF_BB('CP', cp, 'BA', brain_atlas))
            end
    end
end

%%%% ¡gui!
pr = PanelPropItem('EL', cp, 'PROP', ComparisonEnsemble.PFB, ...
    'GUICLASS', 'GUIFig', ...
	'BUTTON_TEXT', ['Plot ' cp.get('MEASURE') ' Comparison'], ...
    varargin{:});

%%% ¡prop!
CALCULATE_RESULTS (evanescent, cell) calculates the comparison results {diff, p1, p2, ci_lower, ci_upper}.
%%%% ¡calculate!
% {DIFF, P1, P2, CIL, CIU} = cp.get('CALCULATE_RESULTS') calcultes the 
%  one-talied p-value P1, the two-tailed p-value P2, the lower bound of the 
%  confidence interval CIL, and the the upper bound of the confidence interval.
%  Typically, this methos is only called internally.

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

wb = braph2waitbar(c.get('WAITBAR'), 0, ['Comparing ensemble ' cp.get('MEASURE') '...']);

% Pre-calculate and save measures of all subjects
ms1 = cellfun(@(x) x.get('MEASURE', measure_class, varargin{:}).memorize('M'), c.get('A1').memorize('G_DICT').get('IT_LIST'), 'UniformOutput', false);
ms2 = cellfun(@(x) x.get('MEASURE', measure_class, varargin{:}).memorize('M'), c.get('A2').memorize('G_DICT').get('IT_LIST'), 'UniformOutput', false);

% Measure for groups 1 and 2, and their difference
m1 = c.get('A1').get('MEASUREENSEMBLE', measure_class).memorize('M');
m2 = c.get('A2').get('MEASUREENSEMBLE', measure_class).memorize('M');
diff = cellfun(@(x, y) y - x, m1, m2, 'UniformOutput', false);

% Permutations
P = c.get('P'); %#ok<*PROPLC>

m1_perms = cell(1, P);
m2_perms = cell(1, P);
diff_perms = cell(1, P);

start = tic;
seeds = c.memorize('PERM_SEEDS');
for p = 1:20:P
    parfor q = p:min(p+20, P)
        % [a1_perm, a2_perm] = c.getPerm(i, memorize);
        % 
        % m1_perms{1, i} = a1_perm.getMeasureEnsemble(measure_class).memorize('M');
        % m2_perms{1, i} = a2_perm.getMeasureEnsemble(measure_class).memorize('M');
        % diff_perms{1, i} = cellfun(@(x, y) y - x, m1_perms{1, i}, m2_perms{1, i}, 'UniformOutput', false);

        rng(seeds(q), 'twister')

        [ms1_perm, ms2_perm] = permutation(ms1, ms2, c.get('LONGITUDINAL'));

        ms1_av = cell(size(ms1_perm{1}));
        ms2_av = cell(size(ms1_perm{1}));
        for i = 1:1:size(ms1_perm{1}, 1)
            for j = 1:1:size(ms1_perm{1}, 2)

                ms1_perm_ij = cellfun(@(x) x{i, j}, ms1_perm, 'UniformOutput', false);
                ms1_av{i, j} = mean(cat(ndims(ms1_perm_ij{1}) + 1, ms1_perm_ij{:}), ndims(ms1_perm_ij{1}) + 1);

                ms2_perm_ij = cellfun(@(x) x{i, j}, ms2_perm, 'UniformOutput', false);
                ms2_av{i, j} = mean(cat(ndims(ms2_perm_ij{1}) + 1, ms2_perm_ij{:}), ndims(ms2_perm_ij{1}) + 1);
            end
        end
        m1_perms{1, q} = ms1_av;
        m2_perms{1, q} = ms2_av;
        diff_perms{1, q} = cellfun(@(x, y) y - x, m1_perms{1, q}, m2_perms{1, q}, 'UniformOutput', false);
    end

    braph2waitbar(wb, p / P, ['Comparing group ' cp.get('MEASURE') '. Permutation ' num2str(p) ' of ' num2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...'])
    if c.get('VERBOSE')
        disp(['** PERMUTATION TEST - sampling #' int2str(p) '/' int2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
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
[ComparisonEnsemble.PFC ComparisonEnsemble.PFB ComparisonEnsemble.CALCULATE_RESULTS]
