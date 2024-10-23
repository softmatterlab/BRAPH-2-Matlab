classdef Format < handle
    %Format defines the format of a property.
    % Static class that defines the possible formats of the properties of
    % the elements. It is a subclass of handle.
    %
    % The possible formats are:
    %
    %  EMPTY        Empty has an empty value and is typically used as a
    %               result or query to execute some code. 
    %
    %  STRING       String is a char array.
    %
    %  STRINGLIST   StringList is a cell array with char arrays.
    %
    %  LOGICAL      Logical is a boolean value.
    %
    %  OPTION       Option is a char array representing an option within a
    %               set defined in the element (case sensitive). 
    %               Settings: cell array of chars representing the options,
    %               e.g., {'plus', 'minus', 'zero'}.
    %
    %  CLASS        Class is a char array corresponding to an element class.
    %               Settings: class name of a subclass of Element (or
    %               Element itself).
    %
    %  CLASSLIST    ClassList is a cell array with char arrays
    %               corresponding to element classes. 
    %               Settings: class name of a subclass of Element (or
    %               Element itself), which represents the base element.
    %
    %  ITEM         Item is a pointer to an element of a class defined in
    %               the element. 
    %               Settings: class name of a subclass of Element (or
    %               Element itself).
    %
    %  ITEMLIST     ItemList is a cell array with pointers to elements of a
    %               class defined in the element. 
    %               Settings: class name of a subclass of Element (or
    %               Element itself), which represents the base element.
    %
    %  IDICT        Idict is an indexed dictionary of elements of a class
    %               defined in the element. 
    %               Settings: class name of a subclass of Element (or
    %               Element itself), which represents the dictionary element.
    %
    %  SCALAR       Scalar is a scalar numerical value.
    %
    %  RVECTOR      RVector is a numerical row vector.
    %
    %  CVECTOR      CVector is a numerical column vector.
    %
    %  MATRIX       Matrix is a numerical matrix.
    %
    %  SMATRIX      SMatrix is a numerical square matrix.
    %
    %  CELL         Cell is a 2D cell array of numeric data, typically used
    %               for adjaciency matrices and measures.
    %
    %  NET          Net is a MatLab neural network object 
    %               (network, SeriesNetwork, DAGNetwork, dlnetwork).
    %
    %  HANDLE       Handle is a handle for a graphical or listener component.
    %               It should only be used as an evanescent property.
    %
    %  HANDLELIST   HandleList is a cell array with handles for graphical 
    %               or listener components.
    %               It should only be used as an evanescent property.
    %
    %  COLOR        Color is an RGB color, e.g., '[1 0 0' for red.
    %
    %  ALPHA        Alpha is a transparency level between 0 and 1.
    %
    %  SIZE         Size represents the size of a graphical component.
    %               It is a positive number (default = 1).
    %
    %  MARKER       Marker represents the marker style.
    %               It can be 'o' (circle), '+' (plus), '*' (asterisk), 
    %               '.' (point), 'x' (cross), '_' (horizontal line), 
    %               '|' (vertical line), 's' (square), 'd' (diamond), 
    %               '^' (upward triangle), 'v' (downward triangle),
    %               '>' (right triangle), '<' (left triangle), 
    %               'p' (pentagram), 'h' (hexagram), '' (no marker).
    %
    %  LINE         Line represents the line style.
    %               It can be '-' (solid), ':' (dotted), '-.' (dashdot),
    %               '--' (dashed), '' (no line).
    %
    % Format properties (Constant):
    %
    %  EMPTY = 1
    %  EMPTY_TAG = Format.EMPTY_TAG
    %  EMPTY_NAME = Format.EMPTY_NAME
    %  EMPTY_DESCRIPTION
    % 
    %  STRING = 2
    %  STRING_TAG = Format.STRING_TAG
    %  STRING_NAME = Format.STRING_NAME
    %  STRING_DESCRIPTION
    % 
    %  STRINGLIST = 3
    %  STRINGLIST_TAG = Format.STRINGLIST_TAG
    %  STRINGLIST_NAME = Format.STRINGLIST_NAME
    %  STRINGLIST_DESCRIPTION
    % 
    %  LOGICAL = 4
    %  LOGICAL_TAG = Format.LOGICAL_TAG
    %  LOGICAL_NAME = Format.LOGICAL_NAME
    %  LOGICAL_DESCRIPTION
    % 
    %  OPTION = 5
    %  OPTION_TAG = Format.OPTION_TAG
    %  OPTION_NAME = Format.OPTION_NAME
    %  OPTION_DESCRIPTION
    % 
    %  CLASS = '6
    %  CLASS_TAG = Format.CLASS_TAG
    %  CLASS_NAME = Format.CLASS_NAME
    %  CLASS_DESCRIPTION
    % 
    %  CLASSLIST = 7
    %  CLASSLIST_TAG = Format.CLASSLIST_TAG
    %  CLASSLIST_NAME = Format.CLASSLIST_NAME
    %  CLASSLIST_DESCRIPTION
    % 
    %  ITEM = 8
    %  ITEM_TAG = Format.ITEM_TAG
    %  ITEM_NAME = Format.ITEM_NAME
    %  ITEM_DESCRIPTION
    % 
    %  ITEMLIST = 9
    %  ITEMLIST_TAG = Format.ITEMLIST_TAG
    %  ITEMLIST_NAME = Format.ITEMLIST_NAME
    %  ITEMLIST_DESCRIPTION
    % 
    %  IDICT = 10
    %  IDICT_TAG = Format.IDICT_TAG
    %  IDICT_NAME = Format.IDICT_NAME
    %  IDICT_DESCRIPTION
    % 
    %  SCALAR = 11
    %  SCALAR_TAG = Format.SCALAR_TAG
    %  SCALAR_NAME = Format.SCALAR_NAME
    %  SCALAR_DESCRIPTION
    % 
    %  RVECTOR = 12
    %  RVECTOR_TAG = Format.RVECTOR_TAG
    %  RVECTOR_NAME = Format.RVECTOR_NAME
    %  RVECTOR_DESCRIPTION
    % 
    %  CVECTOR = 13
    %  CVECTOR_TAG = Format.CVECTOR_TAG
    %  CVECTOR_NAME = Format.CVECTOR_NAME
    %  CVECTOR_DESCRIPTION
    % 
    %  MATRIX = 14
    %  MATRIX_TAG = Format.MATRIX_TAG
    %  MATRIX_NAME = Format.MATRIX_NAME
    %  MATRIX_DESCRIPTION
    % 
    %  SMATRIX = 15
    %  SMATRIX_TAG = Format.SMATRIX_TAG
    %  SMATRIX_NAME = Format.SMATRIX_NAME
    %  SMATRIX_DESCRIPTION
    % 
    %  CELL = 16
    %  CELL_TAG = Format.CELL_TAG
    %  CELL_NAME = Format.CELL_NAME
    %  CELL_DESCRIPTION
    %
    %  NET = 17
    %  NET_TAG = Format.NET_TAG
    %  NET_NAME = Format.NET_NAME
    %  NET_DESCRIPTION
    %
    %  HANDLE = 18
    %  HANDLE_TAG = Format.HANDLE_TAG
    %  HANDLE_NAME = Format.HANDLE_NAME
    %  HANDLE_DESCRIPTION
    %
    %  HANDLELIST = 19
    %  HANDLELIST_TAG = Format.HANDLELIST_TAG
    %  HANDLELIST_NAME = Format.HANDLELIST_NAME
    %  HANDLELIST_DESCRIPTION
    %
    %  COLOR = 20
    %  COLOR_TAG = Format.COLOR_TAG
    %  COLOR_NAME = Format.COLOR_NAME
    %  COLOR_DESCRIPTION
    %
    %  ALPHA = 21
    %  ALPHA_TAG = Format.ALPHA_TAG
    %  ALPHA_NAME = Format.ALPHA_NAME
    %  ALPHA_DESCRIPTION
    %
    %  SIZE = 22
    %  SIZE_TAG = Format.SIZE_TAG
    %  SIZE_NAME = Format.SIZE_NAME
    %  SIZE_DESCRIPTION
    %
    %  MARKER = 23
    %  MARKER_TAG = Format.MARKER_TAG
    %  MARKER_NAME = Format.MARKER_NAME
    %  MARKER_DESCRIPTION
    %
    %  LINE = 24
    %  LINE_TAG = Format.LINE_TAG
    %  LINE_NAME = Format.LINE_NAME
    %  LINE_DESCRIPTION
    %
    % Format methods (Static):
    %  getFormats - returns the list of formats
    %  getFormatNumber - returns the number of formats
    %  existsFormat - returns whether a format exists/error
    %  getFormatTag - returns the tag of a format
    %  getFormatName - returns the name of a format
    %  getFormatDescription - returns the description of a format
    %  getFormatSettings - returns the settings for a format
    %  getFormatDefault - returns the default value for a format
    %  checkFormat - returns whether a value format is correct/error
    %
    % See also Element, Category, NoValue, IndexedDictionary.
    
    properties (Constant)
        EMPTY = 1
        EMPTY_TAG = 'em'
        EMPTY_NAME = 'empty' 
        EMPTY_DESCRIPTION = 'Empty has an empty value and is typically used as a result or query to execute some code.'

        STRING = 2 
        STRING_TAG = 'st'
        STRING_NAME = 'string' 
        STRING_DESCRIPTION = 'String is a char array.'
        
        STRINGLIST = 3
        STRINGLIST_TAG = 'sl'
        STRINGLIST_NAME = 'stringlist' 
        STRINGLIST_DESCRIPTION = 'StringList is a cell array with char arrays.'
        
        LOGICAL = 4
        LOGICAL_TAG = 'lo'
        LOGICAL_NAME = 'logical'
        LOGICAL_DESCRIPTION = 'Logical is a boolean value.'

        OPTION = 5
        OPTION_TAG = 'op'
        OPTION_NAME = 'option' 
        OPTION_DESCRIPTION = 'Option is a char array representing an option within a set defined in the element (case sensitive).'
        
        CLASS = 6
        CLASS_TAG = 'ca'
        CLASS_NAME = 'class'
        CLASS_DESCRIPTION = 'Class is a char array corresponding to an element class.'

        CLASSLIST = 7
        CLASSLIST_TAG = 'cl'
        CLASSLIST_NAME = 'classlist'
        CLASSLIST_DESCRIPTION = 'ClassList is a cell array with char arrays corresponding to element classes.'
        
        ITEM = 8
        ITEM_TAG = 'it'
        ITEM_NAME = 'item'
        ITEM_DESCRIPTION = 'Item is a pointer to an element of a class defined in the element.'

        ITEMLIST = 9
        ITEMLIST_TAG = 'il'
        ITEMLIST_NAME = 'itemlist'
        ITEMLIST_DESCRIPTION = 'ItemList is a cell array with pointers to elements of a class defined in the element.'
        
        IDICT = 10
        IDICT_TAG = 'di'
        IDICT_NAME = 'idict' 
        IDICT_DESCRIPTION = 'Idict is an indexed dictionary of elements of a class defined in the element.'
        
        SCALAR = 11
        SCALAR_TAG = 'nn'
        SCALAR_NAME = 'scalar' 
        SCALAR_DESCRIPTION = 'Scalar is a scalar numerical value.'
        
        RVECTOR = 12
        RVECTOR_TAG = 'nr'
        RVECTOR_NAME = 'rvector' 
        RVECTOR_DESCRIPTION = 'Rvector is a numerical row vector.'
        
        CVECTOR = 13
        CVECTOR_TAG = 'nc'
        CVECTOR_NAME = 'cvector' 
        CVECTOR_DESCRIPTION = 'Cvector is a numerical column vector.'
        
        MATRIX = 14
        MATRIX_TAG = 'nm'
        MATRIX_NAME = 'matrix'
        MATRIX_DESCRIPTION = 'Matrix is a numerical matrix.'

        SMATRIX = 15
        SMATRIX_TAG = 'ns'
        SMATRIX_NAME = 'smatrix'
        SMATRIX_DESCRIPTION = 'Smatrix is a numerical square matrix.'
        
        CELL = 16
        CELL_TAG = 'll'
        CELL_NAME = 'cell'
        CELL_DESCRIPTION = 'Cell is a 2D cell array of numeric data, typically used for adjacency matrices and measures.'
        
        NET = 17
        NET_TAG = 'ml'
        NET_NAME = 'net'
        NET_DESCRIPTION = 'Net is a MatLab neural network object (network, SeriesNetwork, DAGNetwork, dlnetwork).'
        
        HANDLE = 18
        HANDLE_TAG = 'ha'
        HANDLE_NAME = 'handle'
        HANDLE_DESCRIPTION = 'Handle is a handle for a graphical or listener component. It should only be used as an evanescent property.'

        HANDLELIST = 19
        HANDLELIST_TAG = 'hl'
        HANDLELIST_NAME = 'handlelist'
        HANDLELIST_DESCRIPTION = 'HandleList is a cell array with handles for graphical or listener components. It should only be used as an evanescent property.'

        COLOR = 20
        COLOR_TAG = 'co'
        COLOR_NAME = 'color'
        COLOR_DESCRIPTION = 'Color is an RGB color.'

        ALPHA = 21
        ALPHA_TAG = 'al'
        ALPHA_NAME = 'alpha'
        ALPHA_DESCRIPTION = 'Alpha is a transparency level between 0 and 1.'

        SIZE = 22
        SIZE_TAG = 'sz'
        SIZE_NAME = 'size'
        SIZE_DESCRIPTION = 'Size represents the size of a graphical component. It is a positive number (default = 1).'

        MARKER = 23
        MARKER_TAG = 'mr'
        MARKER_NAME = 'marker'
        MARKER_DESCRIPTION = 'Marker represents the marker style. It can be ''o'' (circle), ''+'' (plus), ''*'' (asterisk), ''.'' (point), ''x'' (cross), ''_'' (horizontal line), ''|'' (vertical line), ''s'' (square), ''d'' (diamond), ''^'' (upward triangle), ''v'' (downward triangle), ''>'' (right triangle), ''<'' (left triangle), ''p'' (pentagram), ''h'' (hexagram), '''' (no marker).'

        LINE = 24
        LINE_TAG = 'ln'
        LINE_NAME = 'line'
        LINE_DESCRIPTION = 'Line represents the line style. It can be ''-'' (solid), '':'' (dotted), ''-.'' (dashdot), ''--'' (dashed), '''' (no line).'
    end
    methods (Static)
        function formats = getFormats()
            %GETFORMATS returns the list of formats.
            %
            % FORMATS = GETFORMATS() returns the list of formats.
            %
            % See also getFormatNumber, existsFormat.
            
            formats = [ ...
                Format.EMPTY ...
                Format.STRING ...
                Format.STRINGLIST ...
                Format.LOGICAL ...
                Format.OPTION ...
                Format.CLASS ...
                Format.CLASSLIST ...
                Format.ITEM ...
                Format.ITEMLIST ...
                Format.IDICT ...
                Format.SCALAR ...
                Format.RVECTOR ...
                Format.CVECTOR ...
                Format.MATRIX ...
                Format.SMATRIX ...
                Format.CELL ...
                Format.NET ...
                Format.HANDLE ...
                Format.HANDLELIST ...
                Format.COLOR ...
                Format.ALPHA ...
                Format.SIZE ...
                Format.MARKER ...
                Format.LINE ...
                ];
        end
        function format_number = getFormatNumber()
            %GETFORMATNUMBER returns the number of formats.
            %
            % N = GETFORMATNUMBER() returns the number of formats (Format.getFormatNumber()).
            %
            % See also getFormats, existsFormat.

            format_number = 24; %CET % numel(Format.getFormats());
        end
        function check_out = existsFormat(format)
            %EXISTSFORMAT returns whether a format exists/error.
            %
            % CHECK = EXISTSFORMAT(FORMAT) returns whether FORMAT exists.
            %
            % EXISTSFORMAT(FORMAT) throws an error if FORMAT does not exist.
            %  Error id: €BRAPH2.STR€:Format:€BRAPH2.WRONG_INPUT€
            %
            % See also getFormats, getFormatNumber.

            check = format >= 1 && format <= Format.getFormatNumber() && round(format) == format; 
            
            if nargout == 1
                check_out = check;
            elseif ~check
                error( ...
                    [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT '\n' ...
                    'The value ' tostring(format) ' is not a valid format.\n' ...
                    'Admissible values are ' char(join(cellfun(@(x) int2str(x), ...
                    num2cell(Format.getFormats()), 'UniformOutput', false))) '.'] ...
                    )
            end
        end
        function format_tag = getFormatTag(format)
            %GETFORMATTAG returns the tag of a format.
            %
            % TAG = GETFORMATTAG(FORMAT) returns the tag of FORMAT.
            %
            % A list of all format tags can be obtained using
            %  <a href="matlab:cellfun(@(x) Format.getFormatTag(x), num2cell(Format.getFormats()), 'UniformOutput', false)">cellfun(@(x) Format.getFormatTag(x), num2cell(Format.getFormats()), 'UniformOutput', false)</a>
            %
            % See also getFormats, getFormatName, getFormatDescription,
            %  getFormatSettings, getFormatDefault, checkFormat. 

            switch format
                case Format.EMPTY % __Format.EMPTY__
                    format_tag = Format.EMPTY_TAG;
                case Format.STRING % __Format.STRING__
                    format_tag = Format.STRING_TAG;
                case Format.STRINGLIST % __Format.STRINGLIST__
                    format_tag = Format.STRINGLIST_TAG;
                case Format.LOGICAL % __Format.LOGICAL__
                    format_tag = Format.LOGICAL_TAG;
                case Format.OPTION % __Format.OPTION__
                    format_tag = Format.OPTION_TAG;
                case Format.CLASS % __Format.CLASS__
                    format_tag = Format.CLASS_TAG;
                case Format.CLASSLIST % __Format.CLASSLIST__
                    format_tag = Format.CLASSLIST_TAG;
                case Format.ITEM % __Format.ITEM__
                    format_tag = Format.ITEM_TAG;
                case Format.ITEMLIST % __Format.ITEMLIST__
                    format_tag = Format.ITEMLIST_TAG;
                case Format.IDICT % __Format.IDICT__
                    format_tag = Format.IDICT_TAG;
                case Format.SCALAR % __Format.SCALAR__
                    format_tag = Format.SCALAR_TAG;
                case Format.RVECTOR % __Format.RVECTOR__
                    format_tag = Format.RVECTOR_TAG;
                case Format.CVECTOR % __Format.CVECTOR__
                    format_tag = Format.CVECTOR_TAG;
                case Format.MATRIX % __Format.MATRIX__
                    format_tag = Format.MATRIX_TAG;
                case Format.SMATRIX % __Format.SMATRIX__
                    format_tag = Format.SMATRIX_TAG;
                case Format.CELL % __Format.CELL__
                    format_tag = Format.CELL_TAG;
                case Format.NET % __Format.NET__
                    format_tag = Format.NET_TAG;
                case Format.HANDLE % __Format.HANDLE__
                    format_tag = Format.HANDLE_TAG;
                case Format.HANDLELIST % __Format.HANDLELIST__
                    format_tag = Format.HANDLELIST_TAG;
                case Format.COLOR % __Format.COLOR__
                    format_tag = Format.COLOR_TAG;
                case Format.ALPHA % __Format.ALPHA__
                    format_tag = Format.ALPHA_TAG;
                case Format.SIZE % __Format.SIZE__
                    format_tag = Format.SIZE_TAG;
                case Format.MARKER % __Format.MARKER__
                    format_tag = Format.MARKER_TAG;
                case Format.LINE % __Format.LINE__
                    format_tag = Format.LINE_TAG;
                otherwise
                    Format.existsFormat(format) % error because format does not exist
            end
        end
        function format_name = getFormatName(format)
            %GETFORMATNAME returns the name of a format.
            %
            % NAME = GETFORMATNAME(FORMAT) returns the name of FORMAT.
            %
            % A list of all format names can be obtained using
            %  <a href="matlab:cellfun(@(x) Format.getFormatName(x), num2cell(Format.getFormats()), 'UniformOutput', false)">cellfun(@(x) Format.getFormatName(x), num2cell(Format.getFormats()), 'UniformOutput', false)</a>
            %
            % See also getFormats, getFormatTag, getFormatDescription,
            %  getFormatSettings, getFormatDefault, checkFormat. 

            switch format
                case Format.EMPTY % __Format.EMPTY__
                    format_name = Format.EMPTY_NAME;
                case Format.STRING % __Format.STRING__
                    format_name = Format.STRING_NAME;
                case Format.STRINGLIST % __Format.STRINGLIST__
                    format_name = Format.STRINGLIST_NAME;
                case Format.LOGICAL % __Format.LOGICAL__
                    format_name = Format.LOGICAL_NAME;
                case Format.OPTION % __Format.OPTION__
                    format_name = Format.OPTION_NAME;
                case Format.CLASS % __Format.CLASS__
                    format_name = Format.CLASS_NAME;
                case Format.CLASSLIST % __Format.CLASSLIST__
                    format_name = Format.CLASSLIST_NAME;
                case Format.ITEM % __Format.ITEM__
                    format_name = Format.ITEM_NAME;
                case Format.ITEMLIST % __Format.ITEMLIST__
                    format_name = Format.ITEMLIST_NAME;
                case Format.IDICT % __Format.IDICT__
                    format_name = Format.IDICT_NAME;
                case Format.SCALAR % __Format.SCALAR__
                    format_name = Format.SCALAR_NAME;
                case Format.RVECTOR % __Format.RVECTOR__
                    format_name = Format.RVECTOR_NAME;
                case Format.CVECTOR % __Format.CVECTOR__
                    format_name = Format.CVECTOR_NAME;
                case Format.MATRIX % __Format.MATRIX__
                    format_name = Format.MATRIX_NAME;
                case Format.SMATRIX % __Format.SMATRIX__
                    format_name = Format.SMATRIX_NAME;
                case Format.CELL % __Format.CELL__
                    format_name = Format.CELL_NAME;
                case Format.NET % __Format.NET__
                    format_name = Format.NET_NAME;
                case Format.HANDLE % __Format.HANDLE__
                    format_name = Format.HANDLE_NAME;
                case Format.HANDLELIST % __Format.HANDLELIST__
                    format_name = Format.HANDLELIST_NAME;
                case Format.COLOR % __Format.COLOR__
                    format_name = Format.COLOR_NAME;
                case Format.ALPHA % __Format.ALPHA__
                    format_name = Format.ALPHA_NAME;
                case Format.SIZE % __Format.SIZE__
                    format_name = Format.SIZE_NAME;
                case Format.MARKER % __Format.MARKER__
                    format_name = Format.MARKER_NAME;
                case Format.LINE % __Format.LINE__
                    format_name = Format.LINE_NAME;
                otherwise
                    Format.existsFormat(format) % error because format does not exist
            end
        end
        function format_description = getFormatDescription(format, format_settings)
            %GETFORMATDESCRIPTION returns the description of a format.
            %
            % STR = GETFORMATDESCRIPTION(FORMAT) returns the description of FORMAT with
            %  default settings. 
            %
            % STR = GETFORMATDESCRIPTION(FORMAT, SETTINGS) returns the description
            %  adapted for SETTINGS.
            %
            % A list of all format descriptions with default settings can be obtained using
            %  <a href="matlab:cellfun(@(x) Format.getFormatDescription(x), num2cell(Format.getFormats()), 'UniformOutput', false)">cellfun(@(x) Format.getFormatDescription(x), num2cell(Format.getFormats()), 'UniformOutput', false)</a>
            %
            % See also getFormats, getFormatTag, getFormatName, getFormatSettings,
            %  getFormatDefault, checkFormat. 
            
            switch format
                case Format.EMPTY % __Format.EMPTY__
                    format_description = Format.EMPTY_DESCRIPTION;
                case Format.STRING % __Format.STRING__
                    format_description = Format.STRING_DESCRIPTION;
                case Format.STRINGLIST % __Format.STRINGLIST__
                    format_description = Format.STRINGLIST_DESCRIPTION;
                case Format.LOGICAL % __Format.LOGICAL__
                    format_description = Format.LOGICAL_DESCRIPTION;
                case Format.OPTION % __Format.OPTION__
                    format_description = Format.OPTION_DESCRIPTION;
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'Admissible options are ' ...
                            char(join(cellfun(@(x) ['''' x ''''], format_settings, 'UniformOutput', false))) ...
                            '.' ...
                            ];                        
                    end
                case Format.CLASS % __Format.CLASS__
                    format_description = Format.CLASS_DESCRIPTION;
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'The element class must be ' format_settings ' or one of its subclasses.' ...
                            ];
                    end
                case Format.CLASSLIST % __Format.CLASSLIST__
                    format_description = Format.CLASSLIST_DESCRIPTION;
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'All element classes must be ' format_settings ' or one of its subclasses.' ...
                            ];
                    end
                case Format.ITEM % __Format.ITEM__
                    format_description = Format.ITEM_DESCRIPTION;
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'The item must be of class ' format_settings ' or one of its subclasses.' ...
                            ];                        
                    end
                case Format.ITEMLIST % __Format.ITEMLIST__
                    format_description = Format.ITEMLIST_DESCRIPTION;
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'All items must be of class ' format_settings ' or one of its subclasses.' ...
                            ];                        
                    end
                case Format.IDICT % __Format.IDICT__
                    format_description = Format.IDICT_DESCRIPTION;
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'The dictionary items must be of class ' format_settings ' or one of its subclasses.' ...
                            ];                        
                    end
                case Format.SCALAR % __Format.SCALAR__
                    format_description = Format.SCALAR_DESCRIPTION;
                case Format.RVECTOR % __Format.RVECTOR__
                    format_description = Format.RVECTOR_DESCRIPTION;
                case Format.CVECTOR % __Format.CVECTOR__
                    format_description = Format.CVECTOR_DESCRIPTION;
                case Format.MATRIX % __Format.MATRIX__
                    format_description = Format.MATRIX_DESCRIPTION;
                case Format.SMATRIX % __Format.SMATRIX__
                    format_description = Format.SMATRIX_DESCRIPTION;
                case Format.CELL % __Format.CELL__
                    format_description = Format.CELL_DESCRIPTION;
                case Format.NET % __Format.NET__
                    format_description = Format.NET_DESCRIPTION;
                case Format.HANDLE % __Format.HANDLE__
                    format_description = Format.HANDLE_DESCRIPTION;
                case Format.HANDLELIST % __Format.HANDLELIST__
                    format_description = Format.HANDLELIST_DESCRIPTION;
                case Format.COLOR % __Format.COLOR__
                    format_description = Format.COLOR_DESCRIPTION;
                case Format.ALPHA % __Format.ALPHA__
                    format_description = Format.ALPHA_DESCRIPTION;
                case Format.SIZE % __Format.SIZE__
                    format_description = Format.SIZE_DESCRIPTION;
                case Format.MARKER % __Format.MARKER__
                    format_description = Format.MARKER_DESCRIPTION;
                case Format.LINE % __Format.LINE__
                    format_description = Format.LINE_DESCRIPTION;
                otherwise
                    Format.existsFormat(format) % error because format does not exist
            end
        end
        function format_settings = getFormatSettings(format, format_settings)
            %GETFORMATSETTINGS returns the settings of a format.
            %
            % SETTINGS = GETFORMATSETTINGS(FORMAT) returns the default FORMAT settings. 
            %
            % SETTINGS = GETFORMATSETTINGS(FORMAT, SETTINGS) verifies and returns the
            %  default SETTINGS.
            %
            % A list of all format descriptions with default settings can be obtained using
            %  <a href="matlab:cellfun(@(x) Format.getFormatSettings(x), num2cell(Format.getFormats()), 'UniformOutput', false)">cellfun(@(x) Format.getFormatSettings(x), num2cell(Format.getFormats()), 'UniformOutput', false)</a>
            %
            % See also getFormats, getFormatTag, getFormatName, getFormatDescription,
            %  getFormatDefault, checkFormat.

            switch format
                case Format.EMPTY % __Format.EMPTY__
                    format_settings = [];
                case Format.STRING % __Format.STRING__
                    format_settings = [];
                case Format.STRINGLIST % __Format.STRINGLIST__
                    format_settings = [];
                case Format.LOGICAL % __Format.LOGICAL__
                    format_settings = [];
                case Format.OPTION % __Format.OPTION__
                    % setting must be a cell array of options
                    if nargin < 2 || isempty(format_settings)
                        format_settings = {''};
                    end
                case Format.CLASS % __Format.CLASS__
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    if nargin < 2 || isempty(format_settings)
                        format_settings = 'ConcreteElement';
                    end
                case Format.CLASSLIST % __Format.CLASSLIST__
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    if nargin < 2 || isempty(format_settings)
                        format_settings = 'ConcreteElement';
                    end
                case Format.ITEM % __Format.ITEM__
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    if nargin < 2 || isempty(format_settings)
                        format_settings = 'ConcreteElement';
                    end
                case Format.ITEMLIST % __Format.ITEMLIST__
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    if nargin < 2 || isempty(format_settings)
                        format_settings = 'ConcreteElement';
                    end
                case Format.IDICT % __Format.IDICT__
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    if nargin < 2 || isempty(format_settings)
                        format_settings = 'ConcreteElement';
                    end
                case Format.SCALAR % __Format.SCALAR__
                    format_settings = '';
                case Format.RVECTOR % __Format.RVECTOR__
                    format_settings = '';
                case Format.CVECTOR % __Format.CVECTOR__
                    format_settings = '';
                case Format.MATRIX % __Format.MATRIX__
                    format_settings = '';
                case Format.SMATRIX % __Format.SMATRIX__
                    format_settings = '';
                case Format.CELL % __Format.CELL__
                    format_settings = '';
                case Format.NET % __Format.NET__
                    format_settings = '';
                case Format.HANDLE % __Format.HANDLE__
                    format_settings = '';
                case Format.HANDLELIST % __Format.HANDLELIST__
                    format_settings = '';
                case Format.COLOR % __Format.COLOR__
                    format_settings = '';
                case Format.ALPHA % __Format.ALPHA__
                    format_settings = '';
                case Format.SIZE % __Format.SIZE__
                    format_settings = '';
                case Format.MARKER % __Format.MARKER__
                    format_settings = {'o', '+', '*', '.', 'x', '_', '|', 's', 'd', '^', 'v', '>', '<', 'p', 'h', 'none'};
                case Format.LINE % __Format.LINE__
                    format_settings = {'-', ':', '-.', '--', 'none'};
                otherwise
                    Format.existsFormat(format) % error because format does not exist
            end
        end
        function format_default = getFormatDefault(format, format_settings)
            %GETFORMATDEFAULT returns the default value for a format.
            %
            % DEFAULT = GETFORMATDEFAULT(FORMAT) returns the default value for FORMAT.
            %
            % DEFAULT = GETFORMATDEFAULT(FORMAT, SETTINGS) returns the default value
            %  adapted for SETTINGS.
            % 
            % A list of all format defaults with default settings can be obtained using
            %  <a href="matlab:cellfun(@(x) Format.getFormatDefault(x), num2cell(Format.getFormats()), 'UniformOutput', false)">cellfun(@(x) Format.getFormatDefault(x), num2cell(Format.getFormats()), 'UniformOutput', false)</a>
            %
            % See also getFormats, getFormatTag, getFormatName, getFormatDescription,
            %  getFormatSettings, checkFormat.
            
            switch format
                case Format.EMPTY % __Format.EMPTY__
                    format_default = [];
                case Format.STRING % __Format.STRING__
                    format_default = '';
                case Format.STRINGLIST % __Format.STRINGLIST__
                    format_default = {};
                case Format.LOGICAL % __Format.LOGICAL__
                    format_default = false;
                case Format.OPTION % __Format.OPTION__
                    % setting must be a cell array of options
                    if nargin < 2 || isempty(format_settings)
                        format_default = '';
                    else
                        format_default = format_settings{1};
                    end
                case Format.CLASS % __Format.CLASS__
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    if nargin < 2 || isempty(format_settings)
                        format_default = 'ConcreteElement';
                    else
                        format_default = format_settings;                        
                    end
                case Format.CLASSLIST % __Format.CLASSLIST__
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    format_default = {};
                case Format.ITEM % __Format.ITEM__
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    if nargin < 2 || isempty(format_settings)
                        format_default = ConcreteElement();
                    else
                        format_default = eval([format_settings '()']);
                    end
                case Format.ITEMLIST % __Format.ITEMLIST__
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    format_default = {};
                case Format.IDICT % __Format.IDICT__
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    if nargin < 2 || isempty(format_settings)
                        format_default = IndexedDictionary();
                    else
                        format_default = IndexedDictionary('IT_CLASS', format_settings);
                    end
                case Format.SCALAR % __Format.SCALAR__
                    format_default = 0;
                case Format.RVECTOR % __Format.RVECTOR__
                    format_default = [];
                case Format.CVECTOR % __Format.CVECTOR__
                    format_default = [];
                case Format.MATRIX % __Format.MATRIX__
                    format_default = [];
                case Format.SMATRIX % __Format.SMATRIX__
                    format_default = [];
                case Format.CELL % __Format.CELL__
                    format_default = {};
                case Format.NET % __Format.NET__
                    if BRAPH2.installed('NN', 'warning')
                        format_default = network();
                    else
                        format_default = Element.getNoValue();
                    end
                case Format.HANDLE % __Format.HANDLE__
                    format_default = gobjects(1);
                case Format.HANDLELIST % __Format.HANDLELIST__
                    format_default = {};
                case Format.COLOR % __Format.COLOR__
                    format_default = BRAPH2.COL;
                case Format.ALPHA % __Format.ALPHA__
                    format_default = 1;
                case Format.SIZE % __Format.SIZE__
                    format_default = 1;
                case Format.MARKER % __Format.MARKER__
                    format_default = 'o';
                case Format.LINE % __Format.LINE__
                    format_default = '-';
                otherwise
                    Format.existsFormat(format) % error because format does not exist
            end
        end
        function format_check = checkFormat(format, value, format_settings)
            %CHECKFORMAT returns whether a value format is correct/error.
            %
            % CHECK = CHECKFORMAT(FORMAT, VAlUE) returns whether the VALUE is of the
            %  correct FORMAT.
            %
            % CHECK = CHECKFORMAT(FORMAT, VAlUE, SETTINGS) takes into account the
            %  format SETTINGS. 
            %
            % CHECKFORMAT(FORMAT, VAlUE[, SETTINGS]) throws an error if the VALUE does
            %  not have FORMAT.
            %  Error id: €BRAPH2.STR€:Format:€BRAPH2.WRONG_INPUT€
            %
            % See also getFormats, getFormatTag, getFormatName, getFormatDescription,
            %  getFormatSettings, getFormatDefault.

            if nargin < 3 || isempty(format_settings)
                format_settings = [];
            end
            
            switch format
                case Format.EMPTY % __Format.EMPTY__
                    check = isempty(value);
                case Format.STRING % __Format.STRING__
                    check = ischar(value);
                case Format.STRINGLIST % __Format.STRINGLIST__
                    check = iscell(value) && all(cellfun(@(x) ischar(x), value));
                case Format.LOGICAL % __Format.LOGICAL__
                    check = islogical(value) && numel(value) == 1;
                case Format.OPTION % __Format.OPTION__
                    % setting must be a cell array of options
                    options = Format.getFormatSettings(Format.OPTION, format_settings);
                    check = ischar(value) && any(strcmp(value, options));
                case Format.CLASS % __Format.CLASS__
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    class = Format.getFormatSettings(Format.CLASS, format_settings);
                    check = ischar(value) ...
                        && any(strcmp(class, ConcreteElement.getSubclasses())) ...
                        && any(strcmp(value, Element.getSubclasses(class)));
                case Format.CLASSLIST % __Format.CLASSLIST__
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    class = Format.getFormatSettings(Format.CLASSLIST, format_settings);
                    check = iscell(value) ...
                        && any(strcmp(class, ConcreteElement.getSubclasses())) ...
                        && all(cellfun(@(x) any(strcmp(x, Element.getSubclasses(class))), value));
                case Format.ITEM % __Format.ITEM__
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    class = Format.getFormatSettings(Format.ITEM, format_settings);
                    check = any(strcmp(class, ConcreteElement.getSubclasses())) && isa(value, class);
                case Format.ITEMLIST % __Format.ITEMLIST__
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    class = Format.getFormatSettings(Format.ITEMLIST, format_settings);
                    check = iscell(value) && ...
                        any(strcmp(class, ConcreteElement.getSubclasses())) && ...
                        all(cellfun(@(x) isa(x, class), value));
                case Format.IDICT % __Format.IDICT__
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    class = Format.getFormatSettings(Format.IDICT, format_settings);
                    check = isa(value, 'IndexedDictionary') && ...
                        any(strcmp(class, subclasses('ConcreteElement', [], [], true))) && ...
                        any(strcmp(value.get('IT_CLASS'), subclasses(class, [], [], true)));
                case Format.SCALAR % __Format.SCALAR__
                    check = isnumeric(value) && isscalar(value);
                case Format.RVECTOR % __Format.RVECTOR__
                    check = isnumeric(value) && (isrow(value) || isempty(value));
                case Format.CVECTOR % __Format.CVECTOR__
                    check = isnumeric(value) && (iscolumn(value) || isempty(value));
                case Format.MATRIX % __Format.MATRIX__
                    check = isnumeric(value) && ismatrix(value);
                case Format.SMATRIX % __Format.SMATRIX__
                    check = isnumeric(value) && ismatrix(value) && size(value, 1) == size(value, 2);
                case Format.CELL % __Format.CELL__
                    check = iscell(value) && all(cellfun(@(x) isnumeric(x), value(:)));
                case Format.NET % __Format.NET__
                    if BRAPH2.installed('NN', 'warning')
                        check = isa(value, 'network') || isa(value, 'SeriesNetwork') || isa(value, 'DAGNetwork') || isa(value, 'dlnetwork');
                    else
                        check = isa(value, 'NoValue');
                    end
                case Format.HANDLE % __Format.HANDLE__
                    check = isa(value, 'matlab.graphics.Graphics') || isa(value, 'event.listener');
                case Format.HANDLELIST % __Format.HANDLELIST__
                    check = iscell(value) && all(cellfun(@(x) isa(x, 'matlab.graphics.Graphics') || isa(x, 'event.listener'), value));
                case Format.COLOR % __Format.COLOR__
                    check = isnumeric(value) && (length(value) == 3) && all(value >= 0 & value <= 1);
                case Format.ALPHA % __Format.ALPHA__
                    check = isnumeric(value) && isscalar(value) && value >= 0 && value <= 1;
                case Format.SIZE % __Format.SIZE__
                    check = isnumeric(value) && isscalar(value) && value > 0;
                case Format.MARKER % __Format.MARKER__
                    check = ischar(value) && any(strcmp(value, Format.getFormatSettings(Format.MARKER)));
                case Format.LINE % __Format.LINE__
                    check = ischar(value) && any(strcmp(value, Format.getFormatSettings(Format.LINE)));
                otherwise
                    Format.existsFormat(format) % error because format does not exist
            end
            
            if nargout == 1
                format_check = check;
            elseif ~check
                error( ...
                    [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT '\n' ...
                    'The value ' tostring(value) ' is not a valid Format.' ...
                    upper(Format.getFormatName(format)) '. ' ...
                    Format.getFormatDescription(format)] ...
                    )
            end
        end
    end
end
