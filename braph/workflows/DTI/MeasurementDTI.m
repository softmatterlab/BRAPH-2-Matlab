classdef MeasurementDTI < Measurement
    % single group of dti subjects
    properties
        measure_code  % measure class
        values  % array with the values of the measure for each subject
        average_value  % average value of the group
    end
    methods
        function m =  MeasurementDTI(id, atlas, group, varargin)
            
            m = m@Measurement(id, atlas, group, varargin{:});
        end
        function measure_code = getMeasureCode(m)
            measure_code = m.measure_code;
        end
        function value = getMeasureValues(m)
            value = m.values;
        end
        function average_value = getGroupAverageValue(m)
            average_value = m.average_value;
        end
    end
    methods (Access=protected)
        function initialize_data(m, varargin)
            atlases = m.getBrainAtlases();
            atlas = atlases{1};
            
            m.measure_code = get_from_varargin( ...
                'Degree', ...  % needs to have a default measure code
                'MeasurementDTI.measure_code', ...
                varargin{:});
            
            if Measure.is_global(m.getMeasureCode())  % global measure
                m.values = get_from_varargin( ...
                    repmat({0}, 1, m.getGroup().subjectnumber()), ...
                    'MeasurementDTI.values', ...
                    varargin{:});
                assert(iscell(m.getMeasureValues()) & ...
                    isequal(numel(m.getMeasureValues()), m.getGroup().subjectnumber) & ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), m.getMeasureValues())), ...
                    ['BRAPH:MeasurementDTI:WrongData'], ...
                    ['Data not compatible with MeasurementDTI.']) %#ok<*NBRAK>
                
                m.average_value = get_from_varargin( ...
                    0, ...
                    'MeasurementDTI.average_value', ...
                    varargin{:});
                assert(isequal(numel(m.getGroupAverageValue()), 1), ...
                    ['BRAPH:MeasurementDTI:WrongData'], ...
                    ['Data not compatible with MeasurementDTI.']) %#ok<*NBRAK>                
            elseif Measure.is_nodal(m.getMeasureCode())  % nodal measure
                m.values = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length(), 1)}, 1, m.getGroup().subjectnumber()), ...
                    'MeasurementDTI.values', ...
                    varargin{:});
% add assert

                m.average_value = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length(), 1), ...
                    'MeasurementDTI.average_value', ...
                    varargin{:});
% add assert                
            elseif Measure.is_binodal(m.getMeasureCode())  % binodal measure
                m.values = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length())}, 1, m.getGroup().subjectnumber()), ...
                    'MeasurementDTI.values', ...
                    varargin{:});
% add assert                
                m.average_value = get_from_varargin( ...
                    zeros(atlas.getBrainRegions().length()), ...
                    'MeasurementDTI.average_value', ...
                    varargin{:});
% add assert                
            end
        end
    end
    methods (Static)
        function class = getClass(m) %#ok<*INUSD>
            class = 'MeasurementDTI';
        end
        function name = getName(m)
            name = 'Measurement DTI';
        end
        function description = getDescription(m)
            % measurement description missing
            description = '';
        end
        function atlas_number = getBrainAtlasNumber(m)
            atlas_number =  1;
        end
        function analysis_class = getAnalysisClass(m)
            % measurement analysis class
            analysis_class = 'AnalysisDTI';
        end
        function subject_class = getSubjectClass(m)
            % measurement subject class
            subject_class = 'SubjectDTI';
        end        
        function m = getMeasurement(measurement_class, id, atlas, group, varargin)
            m = eval([measurement_class '(id, atlas, group, varargin{:})']);
        end
    end
end