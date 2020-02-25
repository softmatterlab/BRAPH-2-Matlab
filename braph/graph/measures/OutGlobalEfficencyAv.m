classdef OutGlobalEfficencyAv < OutGlobalEfficency
    methods
        function m = OutGlobalEfficencyAv(g, varargin)
            m = m@OutGlobalEfficency(g, varargin{:});
        end
    end
    methods (Access = protected)
        function gbav = calculate(m)
            g = m.getGraph();            
            if g.is_measure_calculated('OutGlobalEfficency')
                ge = g.getMeasureValue('OutGlobalEfficency');
            else
                ge = calculate@OutGlobalEfficency(m);
            end
            
            gbav = mean(ge);
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'OutGlobalEfficencyAv';
        end
        function name = getName()
            name = 'Average Out Global Efficency';
        end
        function description = getDescription()
            description = [ ...
                'The average out global efficiency is the average of the' ...
                'out global efficency ' ...
                ];
        end
        function bool = is_global()
            bool = true;
        end
        function bool = is_nodal()
            bool = false;
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
            n = Measure.getCompatibleGraphNumber('OutGlobalEfficencyAv');
        end
    end
end