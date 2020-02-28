classdef OutPathLength < Measure
    methods
        function m = OutPathLength(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_path_length =  calculate(m)
            g = m.getGraph();
            
            settings = g.getSettings();
            if g.is_measure_calculated('Distance')
                distance = g.getMeasureValue('Distance');
            else
                distance = Distance(g, settings{:}).getValue();
            end
            
            N = g.nodenumber();
            out_path_length = zeros(N, 1);
            
            settings = m.getSettings();
            pathLength_rule = get_from_varargin(0, 'OutPathLengthAvRule', settings{:});
            switch lower(pathLength_rule)
                case {'subgraphs'}
                    for u = 1:1:N
                        Du = distance(u, :);
                        out_path_length(u) = mean(Du(Du~=0 & Du~=Inf));
                    end
                    out_path_length(isnan(out_path_length)) = 0;
                case {'harmonic'}
                    for u = 1:1:N
                        Du = distance(u, :);
                        out_path_length(u) = harmmean(Du(Du~=0));
                    end
                otherwise
                    for u = 1:1:N
                        Du = distance(u, :);
                        out_path_length(u) = mean(Du(Du~=0));
                    end
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'OutPathLength';
        end
        function name = getName()
            name = 'Out Path Length';
        end
        function description = getDescription()
            description = [ ...
                'The out path length is the average shortest ' ...
                'out path lengths of one node to all other nodes.' ...
                ];
        end
        function bool = is_global()
            bool = false;
        end
        function bool = is_nodal()
            bool = true;
        end
        function bool = is_binodal()
            bool = false;
        end
        function list = getCompatibleGraphList()
            list = { ...
                'GraphBD', ...
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('OutPathLength');
        end
    end
end