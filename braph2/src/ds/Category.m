classdef Category < handle
    %Category defines the category of a property.
    % Static class that defines the possible categories of the properties of
    % the elements. It is a subclass of handle.
    %
    % The possible categories are:
    %
    %  CONSTANT     Static constant equal for all instances of the element.
    %                It allows incoming callbacks.
    %
    %  METADATA     Metadata NOT used in the calculation of the results.
    %                It does not allow callbacks.
    %                It is not locked when a result is calculated.
    %
    %  PARAMETER    Parameter used to calculate the results of the element.
    %                It allows incoming and outgoing callbacks.
    %                It is connected with a callback when using a template.
    %                It is locked when a result is calculated.
    %
    %  DATA         Data used to calculate the results of the element 
    %                It is NoValue when not set.
    %                It allows incoming and outgoing callbacks.
    %                It is locked when a result is calculated.
    %
    %  RESULT       Result calculated by the element using parameters and data.
    %                The calculation of a result locks the element.
    %                It is NoValue when not calculated. 
    %                It allows incoming callbacks.
    %
    %  QUERY        Query result calculated by the element.
    %                The calculation of a query does NOT lock the element.
    %                It is NoValue when not calculated. 
    %                It does not allow callbacks.
    %
    %  EVANESCENT   Evanescent variable calculated at runtime (typically
    %                employed for handles of GUI components). 
    %                It is NoValue when not calculated. 
    %                It does not allow callbacks.
    %
    %  FIGURE       Parameter used to plot the results in a figure.
    %                It allows incoming and outgoing callbacks.
    %                It is not locked when a result is calculated.
    %               
    %  GUI          Parameter used by the graphical user interface (GUI).
    %                It allows incoming and outgoing callbacks.
    %                It is not locked when a result is calculated.
    %
    % Category properties (Constant):
    %
    %  CONSTANT = 1
    %  CONSTANT_TAG = 'c'
    %  CONSTANT_NAME = 'constant'
    %  CONSTANT_DESCRIPTION
    %
    %  METADATA = 2
    %  METADATA_TAG = 'c'
    %  METADATA_NAME = 'constant'
    %  METADATA_DESCRIPTION
    %
    %  PARAMETER = 3
    %  PARAMETER_TAG = 'c'
    %  PARAMETER_NAME = 'constant'
    %  PARAMETER_DESCRIPTION
    % 
    %  DATA = 4
    %  DATA_TAG = 'c'
    %  DATA_NAME = 1
    %  DATA_DESCRIPTION
    % 
    %  RESULT = 5
    %  RESULT_TAG = 'r'
    %  RESULT_NAME = 'result'
    %  RESULT_DESCRIPTION
    %
    %  QUERY = 6
    %  QUERY_TAG = 'q'
    %  QUERY_NAME = 'query'
    %  QUERY_DESCRIPTION
    %
    %  EVANESCENT = 7
    %  EVANESCENT_TAG = 'e'
    %  EVANESCENT_NAME = 'evanescent'
    %  EVANESCENT_DESCRIPTION
    %
    %  FIGURE = 8
    %  FIGURE_TAG = 'f'
    %  FIGURE_NAME = 'figure'
    %  FIGURE_DESCRIPTION
    %
    %  GUI = 9
    %  GUI_TAG = 'g'
    %  GUI_NAME = 'gui'
    %  GUI_DESCRIPTION
    %
    % Category methods (Static):
    %  getCategories - returns the list of categories
    %  getCategoryNumber - returns the number of categories
    %  existsCategory - returns whether a category exists/error
    %  getCategoryTag - returns the tag of a category
    %  getCategoryName - returns the name of a category
    %  getCategoryDescription - returns the description of a category
    %
    % See also Element, Format, NoValue.

    properties (Constant)
        CONSTANT = 1
        CONSTANT_TAG = 'c'
        CONSTANT_NAME = 'constant'
        CONSTANT_DESCRIPTION = 'Static constant equal for all instances of the element (allows incoming and outgoing callbacks).'

        METADATA = 2
        METADATA_TAG = 'm'
        METADATA_NAME = 'metadata'
        METADATA_DESCRIPTION = 'Metadata NOT used in the calculation of the results (does not allow callbacks).'
        
        PARAMETER = 3
        PARAMETER_TAG = 'p'
        PARAMETER_NAME = 'parameter'
        PARAMETER_DESCRIPTION = 'Parameter used to calculate the results of the element (allows incoming and outgoing callbacks, templated, locked when a result is calculated).'
        
        DATA = 4
        DATA_TAG = 'd'
        DATA_NAME = 'data'
        DATA_DESCRIPTION = 'Data used to calculate the results of the element (can be NoResult when not set, allows incoming and outgoing callbacks, locked when a result is calculated).'

        RESULT = 5
        RESULT_TAG = 'r'
        RESULT_NAME = 'result'
        RESULT_DESCRIPTION = 'Result calculated by the element using parameters and data; its calculation locks the element (can be NoResult when not calculated, does not allow callbacks).'

        QUERY = 6
        QUERY_TAG = 'q'
        QUERY_NAME = 'query'
        QUERY_DESCRIPTION = 'Query result calculated by the element; its calculation does NOT lock the element.'

        EVANESCENT = 7
        EVANESCENT_TAG = 'e'
        EVANESCENT_NAME = 'evanescent'
        EVANESCENT_DESCRIPTION = 'Evanescent variable calculated at runtime, typically employed for handles to GUI components (can be NoValue when not calculated, does not allow callbacks).'
    
        FIGURE = 8
        FIGURE_TAG = 'f'
        FIGURE_NAME = 'figure'
        FIGURE_DESCRIPTION = 'Parameter used to plot the results in a figure (allows incoming and outgoing callbacks, not lockable).'

        GUI = 9
        GUI_TAG = 'g'
        GUI_NAME = 'gui'
        GUI_DESCRIPTION = 'Parameter used by the graphical user interface (allows incoming and outgoing callbacks, not lockable).'
    end
    methods (Static)
        function categories = getCategories()
            %GETCATEGORIES returns the list of categories.
            %
            % CATEGORIES = GETCATEGORIES() returns the list of categories.
            %
            % See also getCategoryNumber, existsCategory.
            
            categories = [ ...
                1 ...
                2 ...
                3 ...
                4 ...
                5 ...
                6 ...
                7 ...
                8 ...
                9 ...
                ];
        end
        function category_number = getCategoryNumber()
            %GETCATEGORYNUMBER returns the number of categories.
            %
            % N = GETCATEGORYNUMBER() returns the number of categories (9).
            %
            % See also getCategories, existsCategory.
            
            category_number = 9; %CET % numel(Category.getCategories());
        end
        function check_out = existsCategory(category)
            %EXISTSCATEGORY returns whether a category exists/error.
            %
            % CHECK = EXISTSCATEGORY(CATEGORY) returns whether CATEGORY exists.
            %
            % EXISTSCATEGORY(CATEGORY) throws an error if CATEGORY does not exist.
            %  Error id: BRAPH2:Category:WrongInput
            %
            % See also getCategories, getCategoryNumber.
            
            check = category >= 1 && category <= 9 && round(category) == category; 

            if nargout == 1
                check_out = check;
            elseif ~check
                error( ...
                    ['BRAPH2' ':Category:' 'WrongInput'], ...
                    ['BRAPH2' ':Category:' 'WrongInput' '\n' ...
                    'The value ' tostring(category) ' is not a valid category.\n' ...
                    'Admissible values are ' char(join(cellfun(@(x) int2str(x), ...
                    num2cell(Category.getCategories()), 'UniformOutput', false))) '.'] ...
                    )
            end
        end
        function category_tag = getCategoryTag(category)
            %GETCATEGORYTAG returns the tag of a category.
            %
            % TAG = GETCATEGORYTAG(CATEGORY) returns the tag of CATEGORY.
            %
            % A list of all category tags can be obtained using
            %  <a href="matlab:cellfun(@(x) Category.getCategoryTag(x), num2cell(Category.getCategories()), 'UniformOutput', false)">cellfun(@(x) Category.getCategoryTag(x), num2cell(Category.getCategories()), 'UniformOutput', false)</a>
            %
            % See also getCategories, getCategoryName, getCategoryDescription.

            switch category
                case 1 % Category.CONSTANT
                    category_tag = 'c';
                case 2 % Category.METADATA
                    category_tag = 'm';
                case 3 % Category.PARAMETER
                    category_tag = 'p';
                case 4 % Category.DATA
                    category_tag = 'd';
                case 5 % Category.RESULT
                    category_tag = 'r';
                case 6 % Category.QUERY
                    category_tag = 'q';
                case 7 % Category.EVANESCENT
                    category_tag = 'e';
                case 8 % Category.FIGURE
                    category_tag = 'f';
                case 9 % Category.GUI
                    category_tag = 'g';
                otherwise
                    Category.existsCategory(category) % error because category does not exist
            end
        end
        function category_name = getCategoryName(category)
            %GETCATEGORYNAME returns the name of a category.
            %
            % NAME = GETCATEGORYNAME(CATEGORY) returns the name of CATEGORY.
            %
            % A list of all category names can be obtained using
            %  <a href="matlab:cellfun(@(x) Category.getCategoryName(x), num2cell(Category.getCategories()), 'UniformOutput', false)">cellfun(@(x) Category.getCategoryName(x), num2cell(Category.getCategories()), 'UniformOutput', false)</a>
            %
            % See also getCategories, getCategoryTag, getCategoryDescription.

            switch category
                case 1 % Category.CONSTANT
                    category_name = 'constant';
                case 2 % Category.METADATA
                    category_name = 'metadata';
                case 3 % Category.PARAMETER
                    category_name = 'parameter';
                case 4 % Category.DATA
                    category_name = 'data';
                case 5 % Category.RESULT
                    category_name = 'result';
                case 6 % Category.QUERY
                    category_name = 'query';
                case 7 % Category.EVANESCENT
                    category_name = 'evanescent';
                case 8 % Category.FIGURE
                    category_name = 'figure';
                case 9 % Category.GUI
                    category_name = 'gui';
                otherwise
                    Category.existsCategory(category) % error because category does not exist
            end
        end
        function category_description = getCategoryDescription(category)
            %GETCATEGORYDESCRIPTION returns the description of a category.
            %
            % STR = GETCATEGORYDESCRIPTION(CATEGORY) returns the description of CATEGORY.
            %
            % A list of all category descriptions can be obtained using
            %  <a href="matlab:cellfun(@(x) Category.getCategoryDescription(x), num2cell(Category.getCategories()), 'UniformOutput', false)">cellfun(@(x) Category.getCategoryDescription(x), num2cell(Category.getCategories()), 'UniformOutput', false)</a>
            %
            % See also getCategories, getCategoryTag, getCategoryName.

            switch category
                case 1 % Category.CONSTANT
                    category_description = 'Static constant equal for all instances of the element (allows incoming and outgoing callbacks).';
                case 2 % Category.METADATA
                    category_description = 'Metadata NOT used in the calculation of the results (does not allow callbacks).';
                case 3 % Category.PARAMETER
                    category_description = 'Parameter used to calculate the results of the element (allows incoming and outgoing callbacks, templated, locked when a result is calculated).';
                case 4 % Category.DATA
                    category_description = 'Data used to calculate the results of the element (can be NoResult when not set, allows incoming and outgoing callbacks, locked when a result is calculated).';
                case 5 % Category.RESULT
                    category_description = 'Result calculated by the element using parameters and data; its calculation locks the element (can be NoResult when not calculated, does not allow callbacks).';
                case 6 % Category.QUERY
                    category_description = 'Query result calculated by the element; its calculation does NOT lock the element.';
                case 7 % Category.EVANESCENT
                    category_description = 'Evanescent variable calculated at runtime, typically employed for handles to GUI components (can be NoValue when not calculated, does not allow callbacks).';
                case 8 % Category.FIGURE
                    category_description = 'Parameter used to plot the results in a figure (allows incoming and outgoing callbacks, not lockable).';
                case 9 % Category.GUI
                    category_description = 'Parameter used by the graphical user interface (allows incoming and outgoing callbacks, not lockable).';
                otherwise
                    Category.existsCategory(category) % error because category does not exist
            end
        end
    end
end