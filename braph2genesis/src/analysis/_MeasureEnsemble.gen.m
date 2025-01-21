%% ¡header!
MeasureEnsemble < ConcreteElement (me, graph ensemble measure) is a graph ensemble measure.

%%% ¡description!
MeasureEnsemble provides the methods necessary for a graph ensemble measure.

%%% ¡seealso!
AnalyzeEnsemble, CompareEnsemble

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasureEnsemble.ID
%%%% ¡title!
Measure Ensemble ID

%%% ¡prop!
%%%% ¡id!
MeasureEnsemble.LABEL
%%%% ¡title!
Measure Ensemble NAME

%%% ¡_prop! % % % %TBE
%%%% ¡id!
MeasureEnsemble.MEASURE_TEMPLATE
%%%% ¡title!
Measure TEMPLATE

%%% ¡prop!
%%%% ¡id!
MeasureEnsemble.MEASURE
%%%% ¡title!
Measure Ensemble

%%% ¡prop!
%%%% ¡id!
MeasureEnsemble.M
%%%% ¡title!
Measure Ensemble VALUE

%%% ¡prop!
%%%% ¡id!
MeasureEnsemble.PFME
%%%% ¡title!
Measure Ensemble Plot

%%% ¡prop!
%%%% ¡id!
MeasureEnsemble.PFBG
%%%% ¡title!
Measure Ensemble Brain Graph

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'MeasureEnsemble'

%%% ¡prop!
NAME (constant, string) is the name of the graph ensemble measure.
%%%% ¡default!
'MeasureEnsemble'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the graph ensemble measure.
%%%% ¡default!
'MeasureEnsemble provides the methods necessary for a graph ensemble measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the graph ensemble measure.
%%%% ¡settings!
'MeasureEnsemble'

%%% ¡prop!
ID (data, string) is a few-letter code for the graph ensemble measure.
%%%% ¡default!
'MeasureEnsemble ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph ensemble measure.
%%%% ¡default!
'MeasureEnsemble label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph ensemble measure.
%%%% ¡default!
'MeasureEnsemble notes'

%% ¡props!

%%% ¡prop!
MEASURE (data, class) is the measure class.
%%%% ¡settings!
'Measure'

%%% ¡_prop! % % % %TBE
MEASURE_TEMPLATE (parameter, item) provides the measure parameters. 
%%%% ¡settings!
'Measure'

%%% ¡prop!
A (data, item) is the ensemble-based graph analysis.
%%%% ¡settings!
'AnalyzeEnsemble'

%%% ¡prop!
M (result, cell) is the measure group-average result.
%%%% ¡calculate!
m_list = cellfun(@(x) x.get('MEASURE', me.get('MEASURE')).get('M'), me.get('A').get('G_DICT').get('IT_LIST'), 'UniformOutput', false);

if isempty(m_list)
    m_av = {};
else
    m_av = cell(size(m_list{1}));
    for i = 1:1:size(m_list{1}, 1)
        for j = 1:1:size(m_list{1}, 2)
            m_ij_list = cellfun(@(x) x{i, j}, m_list, 'UniformOutput', false);
            m_av{i, j} = mean(cat(ndims(m_ij_list{1}) + 1, m_ij_list{:}), ndims(m_ij_list{1}) + 1);
        end
    end
end

value = m_av;
%%%% ¡gui!
if me.get('A').get('G_DICT').get('LENGTH')
    g = me.get('A').get('G_DICT').get('IT', 1);
else
    g = me.get('A').get('GRAPH_TEMPLATE');
end
g.memorize('A');

measure = me.get('MEASURE');

pr = PanelPropCell('EL', me, 'PROP', MeasureEnsemble.M, varargin{:});

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
PFME (gui, item) contains the panel figure of the measure.
%%%% ¡_settings!
'MeasureEnsemblePF'
%%%% ¡postprocessing!
if isa(me.getr('PFME'), 'NoValue')

    measure = me.get('MEASURE');

    switch Element.getPropDefault(measure, 'SHAPE')
        case Measure.GLOBAL % __Measure.GLOBAL__
            switch Element.getPropDefault(measure, 'SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    me.set('PFME', MeasureEnsemblePF_GS('ME', me))
                case Measure.UNILAYER % __Measure.UNILAYER__
                    me.set('PFME', MeasureEnsemblePF_GU('ME', me))
                case Measure.BILAYER % __Measure.BILAYER__
                    me.set('PFME', MeasureEnsemblePF_GB('ME', me))
            end
        case Measure.NODAL % __Measure.NODAL__
            switch Element.getPropDefault(measure, 'SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    me.set('PFME', MeasureEnsemblePF_NS('ME', me))
                case Measure.UNILAYER % __Measure.UNILAYER__
                    me.set('PFME', MeasureEnsemblePF_NU('ME', me))
                case Measure.BILAYER % __Measure.BILAYER__
                    me.set('PFME', MeasureEnsemblePF_NB('ME', me))
            end
        case Measure.BINODAL % __Measure.BINODAL__
            switch Element.getPropDefault(measure, 'SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    me.set('PFME', MeasureEnsemblePF_BS('ME', me))
                case Measure.UNILAYER % __Measure.UNILAYER__
                    me.set('PFME', MeasureEnsemblePF_BU('ME', me))
                case Measure.BILAYER % __Measure.BILAYER__
                    me.set('PFME', MeasureEnsemblePF_BB('ME', me))
            end
    end
end
%%%% ¡gui!
pr = PanelPropItem('EL', me, 'PROP', MeasureEnsemble.PFME, ...
    'GUICLASS', 'GUIFig', ...
	'BUTTON_TEXT', ['Plot ' me.get('MEASURE') ' Ensemble'], ...
    varargin{:});

%%% ¡prop!
PFBG (gui, item) contains the panel figure of the brain graph.
%%%% ¡_settings!
% % % 'PFBrainGraph'
%%%% ¡_postprocessing!
% % % if ~braph2_testing % to avoid problems with isqual when the element is recursive
% % %     if isa(me.getr('PFBG'), 'NoValue')
% % %         g_dict = me.memorize('a').memorize('g_dict');
% % %         if ~isempty(g_dict) && ~isa(g_dict, 'NoValue') && g_dict.length >= 1
% % %             
% % %             g = g_dict.getItem(1);
% % %             if Graph.is_graph(g) % graph
% % %                 ba_list = g.memorize('BAS');
% % %                 if ~isempty(ba_list)
% % %                     me.memorize('PFBG').set('ME', me, 'BA', ba_list{1})
% % %                 else
% % %                     me.memorize('PFBG').set('ME', me);
% % %                 end
% % %                 
% % %             elseif Graph.is_multigraph(g) % multigraph BUD BUT
% % %                 ba_list = g.memorize('BAS');
% % %                 if ~isempty(ba_list)
% % %                     me.set('PFBG', PFBrainMultiGraph('ME', me, 'BA', ba_list{1}));
% % %                 else
% % %                     me.set('PFBG', PFBrainMultiGraph('ME', me));
% % %                 end
% % %             elseif (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Graph.is_weighted(g) % multiplexWU
% % %                 ba_list = g.memorize('BAS');
% % %                 if ~isempty(ba_list)
% % %                     me.set('PFBG', PFBrainMultiplexGraph('ME', me, 'BA', ba_list{1}));
% % %                 else
% % %                     me.set('PFBG', PFBrainMultiplexGraph('ME', me));
% % %                 end
% % %             elseif (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Graph.is_binary(g)
% % %                 ba_list = g.memorize('BAS');
% % %                 if ~isempty(ba_list)
% % %                     me.set('PFBG', PFBrainMultiplexBinaryGraph('ME', me, 'BA', ba_list{1}));
% % %                 else
% % %                     me.set('PFBG', PFBrainMultiplexBinaryGraph('ME', me));
% % %                 end
% % %             end
% % %                 
% % %         else
% % %             me.memorize('PFBG').set('ME', me)
% % %         end
% % %     end
% % % end
%%%% ¡_gui!
% % % pr = PanelPropItem('EL', me, 'PROP', MeasureEnsemble.PFBG, ...
% % %     'GUICLASS', 'GUIFig', ...
% % %     varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[MeasureEnsemble.PFME MeasureEnsemble.PFBG]
