classdef PathLength < Measure  
    methods
        function m = PathLength(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function P =  calculate(m)
            g = m.getGraph();                          
            D = g.getMeasure('Distance').getValue();
            N = g.nodenumber();
            P = zeros(1, N);
            
            settings = m.getSettings();
            pathLength_rule = get_from_varargin(0,'PathLengthAvRule', settings{:});
            switch lower(pathLength_rule)
                case {'subgraphs'}                    
                    for u = 1:1:N
                        Du = D(:, u);
                        B(u) = sum(Du(Du~=Inf))/length(Du(Du~=Inf & Du~=0));
                    end
                case {'harmonic'}
                    for u = 1:1:N
                        Du = D(:,u);
                        B(u) = harmmean(Du(Du~=Inf & Du~=0));
                    end
                otherwise
                    for u = 1:1:N
                        Du = D(:,u);
                        B(u) = mean(Du(Du~=Inf & Du~=0));
                    end
            end
            B(isnan(B))=Inf;
            P = B';
        end
    end
     methods (Static)
        function measure_class = getClass()
            measure_class = 'PathLength';
        end
        function name = getName()
            name = 'PathLength';
        end
        function description = getDescription()
            description = [ ...                
              'The path length is the average shortest path lengths of one node to all ' ...
              'other nodes.' ...
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
                'GraphBU', ...                
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('PathLength');
        end
    end
end