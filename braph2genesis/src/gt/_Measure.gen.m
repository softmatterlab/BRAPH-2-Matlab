%% ¡header!
Measure < ConcreteElement (m, graph measure) is a measure.

%%% ¡description!
A Measure provides the methods necessary for all graph measures. 
 Instances of this class should not be created. 
 Use one of its subclasses instead.

The measures are characterized by their:

 SHAPE:
  Measure.GLOBAL. <strong>€Measure.GLOBAL_NAME€</strong>: €Measure.GLOBAL_DESCRIPTION€
  Measure.NODAL. <strong>€Measure.NODAL_NAME€</strong>: €Measure.NODAL_DESCRIPTION€
  Measure.BINODAL. <strong>€Measure.BINODAL_NAME€</strong>: €Measure.BINODAL_DESCRIPTION€

 SCOPE:
  Measure.SUPERGLOBAL. <strong>€Measure.SUPERGLOBAL_NAME€</strong>: €Measure.SUPERGLOBAL_DESCRIPTION€
  Measure.UNILAYER. <strong>€Measure.UNILAYER_NAME€</strong>: €Measure.UNILAYER_DESCRIPTION€
  Measure.BILAYER. <strong>€Measure.BILAYER_NAME€</strong>: €Measure.BILAYER_DESCRIPTION€
 
 PARAMETRICIY:
  Measure.PARAMETRIC. <strong>€Measure.PARAMETRIC_NAME€</strong>: €Measure.PARAMETRIC_DESCRIPTION€
  Measure.NONPARAMETRIC. <strong>€Measure.NONPARAMETRIC_NAME€</strong>: €Measure.NONPARAMETRIC_DESCRIPTION€

%%% ¡seealso!
Graph

%%% ¡build!
1

%% ¡constants!
% Measure shape
GLOBAL = 1  
GLOBAL_NAME = 'Global'
GLOBAL_DESCRIPTION = ['Global measure refers to global properties of ' ... 
'a single layer graph and, therefore, consists of a single number for each graph.']

NODAL = 2
NODAL_NAME = 'Nodal'
NODAL_DESCRIPTION = ['Nodal measure refers to properties of the nodes of' ... 
'a single layer graph and, therefore, consists of a vector of numbers, ' ...
'one for each node of the graph.']

BINODAL = 3
BINODAL_NAME = 'Binodal'
BINODAL_DESCRIPTION = ['Binodal measure refers to properties between nodes of' ... 
'a single layer graph and, therefore, consists of a matrix of numbers, ' ...
'one for each node of the graph.']

SHAPE_NUMBER = 3

SHAPE_NAME = {
    Measure.GLOBAL_NAME
    Measure.NODAL_NAME
    Measure.BINODAL_NAME
    }

SHAPE_DESCRIPTION = {
    Measure.GLOBAL_DESCRIPTION
    Measure.NODAL_DESCRIPTION
    Measure.BINODAL_DESCRIPTION
    }

% Measure scope
SUPERGLOBAL = 1
SUPERGLOBAL_NAME = 'Superglobal'
SUPERGLOBAL_DESCRIPTION = ['Superglobal measure consists of a single ' ...
    'number for each non single layer graphs.']

UNILAYER = 2
UNILAYER_NAME = 'Unilayer'
UNILAYER_DESCRIPTION = ['Unilayer measure consists of a vector with ' ... 
'nodal/binodal/global measures for every layer.']

BILAYER = 3
BILAYER_NAME = 'Bilayer'
BILAYER_DESCRIPTION = ['Bilayer measure consists of a matrix with '... 
    'nodal/binodal/global measures between layers.']

SCOPE_NUMBER = 3

SCOPE_NAME = {
    Measure.SUPERGLOBAL_NAME
    Measure.UNILAYER_NAME
    Measure.BILAYER_NAME
    }

SCOPE_DESCRIPTION = {
    Measure.SUPERGLOBAL_DESCRIPTION
    Measure.UNILAYER_DESCRIPTION
    Measure.BILAYER_DESCRIPTION
    }

% Parametricity
PARAMETRIC = 1
PARAMETRIC_NAME = 'Parametric'
PARAMETRIC_DESCRIPTION = ['Parametric measure consists of a measure ' ...
    'that outputs the results based on a parameter.']

NONPARAMETRIC = 2
NONPARAMETRIC_NAME = 'Non-parametric'
NONPARAMETRIC_DESCRIPTION = ['Non-parametric measure consists of a measure ' ...
    'where the results are not based on a parameter.']

PARAMETRICITY_NUMBER = 2

PARAMETRICITY_NAME = {
    Measure.PARAMETRIC_NAME
    Measure.NONPARAMETRIC_NAME
    }

PARAMETRICITY_DESCRIPTION = {
    Measure.PARAMETRIC_DESCRIPTION
    Measure.NONPARAMETRIC_DESCRIPTION
    }

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the graph measure (Measure).
%%%% ¡default!
'Measure'

%%% ¡prop!
NAME (constant, string) is the name of the graph measure.
%%%% ¡default!
'Measure'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the graph measure.
%%%% ¡default!
'A Measure provides the methods necessary for all graph measures. Instances of this class should not be created. Use one of its subclasses instead.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the graph measure.
%%%% ¡settings!
'Measure'

%%% ¡prop!
ID (data, string) is a few-letter code for the graph measure.
%%%% ¡default!
'Measure ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph measure.
%%%% ¡default!
'Measure label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph measure.
%%%% ¡default!
'Measure notes'

%% ¡props!

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape.
%%%% ¡default!
Measure.NODAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope.
%%%% ¡default!
Measure.UNILAYER

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure.
%%%% ¡default!
Measure.NONPARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%%% ¡settings!
'Graph'

%%% ¡prop!
G (data, item) is the measure graph.
%%%% ¡settings!
'Graph'

%%% ¡prop!
M (result, cell) is the measure result.
%%%% ¡calculate!
value = {};
%%%% ¡gui!
g = m.get('G');

pr = PanelPropCell('EL', m, 'PROP', Measure.M, varargin{:});

if m.get('SHAPE') == Measure.GLOBAL % __Measure.GLOBAL__
    pr.set( ...
        'TABLE_HEIGHT', s(4), ...
        'ROWNAME', {}, ...
        'COLUMNNAME', {} ...
        )
elseif m.get('SHAPE') == Measure.NODAL % __Measure.NODAL__
    pr.set( ...
        'TABLE_HEIGHT', s(40), ...
        'ROWNAME', g.getCallback('ANODELABELS'), ...
        'COLUMNNAME', {} ...
        )
elseif m.get('SHAPE') == Measure.BINODAL % __Measure.BINODAL__
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
    if m.get('SCOPE') == Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
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
    elseif m.get('SCOPE') == Measure.UNILAYER % __Measure.UNILAYER__
        pr.set( ...
            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
            'XSLIDERSHOW', false, ...
            'YSLIDERSHOW', true, ...
            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'YSLIDERWIDTH', s(5) ...
            )
    elseif m.get('SCOPE') == Measure.BILAYER % __Measure.BILAYER__
        pr.set( ...
            'TABLE_HEIGHT', max(s(3) + pr.get('TABLE_HEIGHT'), s(3) + s(1) * g.get('LAYERNUMBER')), ...
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
PFM (gui, item) contains the panel figure of the measure.
%%%% ¡settings!
'MeasurePF'
%%%% ¡postprocessing!
if isa(m.getr('PFM'), 'NoValue')
    switch m.get('SHAPE')
        case Measure.GLOBAL % __Measure.GLOBAL__
            switch m.get('SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    m.set('PFM', MeasurePF_GS('M', m))
                case Measure.UNILAYER % __Measure.UNILAYER__
                    m.set('PFM', MeasurePF_GU('M', m))
                case Measure.BILAYER % __Measure.BILAYER__
                    m.set('PFM', MeasurePF_GB('M', m))
            end
        case Measure.NODAL % __Measure.NODAL__
            switch m.get('SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    m.set('PFM', MeasurePF_NS('M', m))
                case Measure.UNILAYER % __Measure.UNILAYER__
                    m.set('PFM', MeasurePF_NU('M', m))
                case Measure.BILAYER % __Measure.BILAYER__
                    m.set('PFM', MeasurePF_NB('M', m))
            end
        case Measure.BINODAL % __Measure.BINODAL__
            switch m.get('SCOPE')
                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
                    m.set('PFM', MeasurePF_BS('M', m))
                case Measure.UNILAYER % __Measure.UNILAYER__
                    m.set('PFM', MeasurePF_BU('M', m))
                case Measure.BILAYER % __Measure.BILAYER__
                    m.set('PFM', MeasurePF_BB('M', m))
            end
    end
end
%%%% ¡gui!
pr = PanelPropItem('EL', m, 'PROP', Measure.PFM, ...
    'GUICLASS', 'GUIFig', ...
	'BUTTON_TEXT', ['Plot ' m.get('LABEL')], ...
    varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[Measure.TEMPLATE Measure.PFM]
