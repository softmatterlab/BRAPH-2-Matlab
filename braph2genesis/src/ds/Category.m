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
    %  CONSTANT = Category.CONSTANT
    %  CONSTANT_TAG = Category.CONSTANT_TAG
    %  CONSTANT_NAME = Category.CONSTANT_NAME
    %  CONSTANT_DESCRIPTION
    %
    %  METADATA = Category.METADATA
    %  METADATA_TAG = Category.CONSTANT_TAG
    %  METADATA_NAME = Category.CONSTANT_NAME
    %  METADATA_DESCRIPTION
    %
    %  PARAMETER = Category.PARAMETER
    %  PARAMETER_TAG = Category.CONSTANT_TAG
    %  PARAMETER_NAME = Category.CONSTANT_NAME
    %  PARAMETER_DESCRIPTION
    % 
    %  DATA = Category.DATA
    %  DATA_TAG = Category.CONSTANT_TAG
    %  DATA_NAME = Category.CONSTANT
    %  DATA_DESCRIPTION
    % 
    %  RESULT = Category.RESULT
    %  RESULT_TAG = Category.RESULT_TAG
    %  RESULT_NAME = Category.RESULT_NAME
    %  RESULT_DESCRIPTION
    %
    %  QUERY = Category.QUERY
    %  QUERY_TAG = Category.QUERY_TAG
    %  QUERY_NAME = Category.QUERY_NAME
    %  QUERY_DESCRIPTION
    %
    %  EVANESCENT = Category.EVANESCENT
    %  EVANESCENT_TAG = Category.EVANESCENT_TAG
    %  EVANESCENT_NAME = Category.EVANESCENT_NAME
    %  EVANESCENT_DESCRIPTION
    %
    %  FIGURE = Category.FIGURE
    %  FIGURE_TAG = Category.FIGURE_TAG
    %  FIGURE_NAME = Category.FIGURE_NAME
    %  FIGURE_DESCRIPTION
    %
    %  GUI = Category.GUI
    %  GUI_TAG = Category.GUI_TAG
    %  GUI_NAME = Category.GUI_NAME
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
                Category.CONSTANT ...
                Category.METADATA ...
                Category.PARAMETER ...
                Category.DATA ...
                Category.RESULT ...
                Category.QUERY ...
                Category.EVANESCENT ...
                Category.FIGURE ...
                Category.GUI ...
                ];
        end
        function category_number = getCategoryNumber()
            %GETCATEGORYNUMBER returns the number of categories.
            %
            % N = GETCATEGORYNUMBER() returns the number of categories (Category.getCategoryNumber()).
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
            %  Error id: €BRAPH2.STR€:Category:€BRAPH2.WRONG_INPUT€
            %
            % See also getCategories, getCategoryNumber.
            
            check = category >= 1 && category <= Category.getCategoryNumber() && round(category) == category; 

            if nargout == 1
                check_out = check;
            elseif ~check
                error( ...
                    [BRAPH2.STR ':Category:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Category:' BRAPH2.WRONG_INPUT '\n' ...
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
                case Category.CONSTANT % __Category.CONSTANT__
                    category_tag = Category.CONSTANT_TAG;
                case Category.METADATA % __Category.METADATA__
                    category_tag = Category.METADATA_TAG;
                case Category.PARAMETER % __Category.PARAMETER__
                    category_tag = Category.PARAMETER_TAG;
                case Category.DATA % __Category.DATA__
                    category_tag = Category.DATA_TAG;
                case Category.RESULT % __Category.RESULT__
                    category_tag = Category.RESULT_TAG;
                case Category.QUERY % __Category.QUERY__
                    category_tag = Category.QUERY_TAG;
                case Category.EVANESCENT % __Category.EVANESCENT__
                    category_tag = Category.EVANESCENT_TAG;
                case Category.FIGURE % __Category.FIGURE__
                    category_tag = Category.FIGURE_TAG;
                case Category.GUI % __Category.GUI__
                    category_tag = Category.GUI_TAG;
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
                case Category.CONSTANT % __Category.CONSTANT__
                    category_name = Category.CONSTANT_NAME;
                case Category.METADATA % __Category.METADATA__
                    category_name = Category.METADATA_NAME;
                case Category.PARAMETER % __Category.PARAMETER__
                    category_name = Category.PARAMETER_NAME;
                case Category.DATA % __Category.DATA__
                    category_name = Category.DATA_NAME;
                case Category.RESULT % __Category.RESULT__
                    category_name = Category.RESULT_NAME;
                case Category.QUERY % __Category.QUERY__
                    category_name = Category.QUERY_NAME;
                case Category.EVANESCENT % __Category.EVANESCENT__
                    category_name = Category.EVANESCENT_NAME;
                case Category.FIGURE % __Category.FIGURE__
                    category_name = Category.FIGURE_NAME;
                case Category.GUI % __Category.GUI__
                    category_name = Category.GUI_NAME;
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
                case Category.CONSTANT % __Category.CONSTANT__
                    category_description = Category.CONSTANT_DESCRIPTION;
                case Category.METADATA % __Category.METADATA__
                    category_description = Category.METADATA_DESCRIPTION;
                case Category.PARAMETER % __Category.PARAMETER__
                    category_description = Category.PARAMETER_DESCRIPTION;
                case Category.DATA % __Category.DATA__
                    category_description = Category.DATA_DESCRIPTION;
                case Category.RESULT % __Category.RESULT__
                    category_description = Category.RESULT_DESCRIPTION;
                case Category.QUERY % __Category.QUERY__
                    category_description = Category.QUERY_DESCRIPTION;
                case Category.EVANESCENT % __Category.EVANESCENT__
                    category_description = Category.EVANESCENT_DESCRIPTION;
                case Category.FIGURE % __Category.FIGURE__
                    category_description = Category.FIGURE_DESCRIPTION;
                case Category.GUI % __Category.GUI__
                    category_description = Category.GUI_DESCRIPTION;
                otherwise
                    Category.existsCategory(category) % error because category does not exist
            end
        end
    end
end