function list = getCompatibleMeasures(g)
%GETCOMPATIBLEMEASURELIST returns the list of measures.
%
% CELL ARRAY = GETCOMPATIBLEMEASURES(G) returns a cell array of
%  measures compatible with the concrete graph G.
%
% CELL ARRAY = GETCOMPATIBLEMEASURES(GRAPH_CLASS) returns a cell array
%  of compatible measures to a graph whose class is GRAPH_CLASS.
%
% See also Graph, Measure.

graph_class = Element.getClass(g);

measure_code_list = Measure.getSubclasses();

list = cell(1, length(measure_code_list));
for i = 1:1:length(measure_code_list)
    measure_code = measure_code_list{i};
    compatible_graph_list = Element.getPropDefault(measure_code, 'COMPATIBLE_GRAPHS');

    if any(strcmp(compatible_graph_list, graph_class))
        list{i} = measure_code;
    end
end
list(cellfun('isempty', list)) = [];

end