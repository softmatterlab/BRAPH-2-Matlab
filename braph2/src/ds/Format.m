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
    %  EMPTY_TAG = 'em'
    %  EMPTY_NAME = 'empty'
    %  EMPTY_DESCRIPTION
    % 
    %  STRING = 2
    %  STRING_TAG = 'st'
    %  STRING_NAME = 'string'
    %  STRING_DESCRIPTION
    % 
    %  STRINGLIST = 3
    %  STRINGLIST_TAG = 'sl'
    %  STRINGLIST_NAME = 'stringlist'
    %  STRINGLIST_DESCRIPTION
    % 
    %  LOGICAL = 4
    %  LOGICAL_TAG = 'lo'
    %  LOGICAL_NAME = 'logical'
    %  LOGICAL_DESCRIPTION
    % 
    %  OPTION = 5
    %  OPTION_TAG = 'op'
    %  OPTION_NAME = 'option'
    %  OPTION_DESCRIPTION
    % 
    %  CLASS = '6
    %  CLASS_TAG = 'ca'
    %  CLASS_NAME = 'class'
    %  CLASS_DESCRIPTION
    % 
    %  CLASSLIST = 7
    %  CLASSLIST_TAG = 'cl'
    %  CLASSLIST_NAME = 'classlist'
    %  CLASSLIST_DESCRIPTION
    % 
    %  ITEM = 8
    %  ITEM_TAG = 'it'
    %  ITEM_NAME = 'item'
    %  ITEM_DESCRIPTION
    % 
    %  ITEMLIST = 9
    %  ITEMLIST_TAG = 'il'
    %  ITEMLIST_NAME = 'itemlist'
    %  ITEMLIST_DESCRIPTION
    % 
    %  IDICT = 10
    %  IDICT_TAG = 'di'
    %  IDICT_NAME = 'idict'
    %  IDICT_DESCRIPTION
    % 
    %  SCALAR = 11
    %  SCALAR_TAG = 'nn'
    %  SCALAR_NAME = 'scalar'
    %  SCALAR_DESCRIPTION
    % 
    %  RVECTOR = 12
    %  RVECTOR_TAG = 'nr'
    %  RVECTOR_NAME = 'rvector'
    %  RVECTOR_DESCRIPTION
    % 
    %  CVECTOR = 13
    %  CVECTOR_TAG = 'nc'
    %  CVECTOR_NAME = 'cvector'
    %  CVECTOR_DESCRIPTION
    % 
    %  MATRIX = 14
    %  MATRIX_TAG = 'nm'
    %  MATRIX_NAME = 'matrix'
    %  MATRIX_DESCRIPTION
    % 
    %  SMATRIX = 15
    %  SMATRIX_TAG = 'ns'
    %  SMATRIX_NAME = 'smatrix'
    %  SMATRIX_DESCRIPTION
    % 
    %  CELL = 16
    %  CELL_TAG = 'll'
    %  CELL_NAME = 'cell'
    %  CELL_DESCRIPTION
    %
    %  NET = 17
    %  NET_TAG = 'ml'
    %  NET_NAME = 'net'
    %  NET_DESCRIPTION
    %
    %  HANDLE = 18
    %  HANDLE_TAG = 'ha'
    %  HANDLE_NAME = 'handle'
    %  HANDLE_DESCRIPTION
    %
    %  HANDLELIST = 19
    %  HANDLELIST_TAG = 'hl'
    %  HANDLELIST_NAME = 'handlelist'
    %  HANDLELIST_DESCRIPTION
    %
    %  COLOR = 20
    %  COLOR_TAG = 'co'
    %  COLOR_NAME = 'color'
    %  COLOR_DESCRIPTION
    %
    %  ALPHA = 21
    %  ALPHA_TAG = 'al'
    %  ALPHA_NAME = 'alpha'
    %  ALPHA_DESCRIPTION
    %
    %  SIZE = 22
    %  SIZE_TAG = 'sz'
    %  SIZE_NAME = 'size'
    %  SIZE_DESCRIPTION
    %
    %  MARKER = 23
    %  MARKER_TAG = 'mr'
    %  MARKER_NAME = 'marker'
    %  MARKER_DESCRIPTION
    %
    %  LINE = 24
    %  LINE_TAG = 'ln'
    %  LINE_NAME = 'line'
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
                1 ...
                2 ...
                3 ...
                4 ...
                5 ...
                6 ...
                7 ...
                8 ...
                9 ...
                10 ...
                11 ...
                12 ...
                13 ...
                14 ...
                15 ...
                16 ...
                17 ...
                18 ...
                19 ...
                20 ...
                21 ...
                22 ...
                23 ...
                24 ...
                ];
        end
        function format_number = getFormatNumber()
            %GETFORMATNUMBER returns the number of formats.
            %
            % N = GETFORMATNUMBER() returns the number of formats (24).
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
            %  Error id: BRAPH2:Format:WrongInput
            %
            % See also getFormats, getFormatNumber.

            check = format >= 1 && format <= 24 && round(format) == format; 
            
            if nargout == 1
                check_out = check;
            elseif ~check
                error( ...
                    ['BRAPH2' ':Format:' 'WrongInput'], ...
                    ['BRAPH2' ':Format:' 'WrongInput' '\n' ...
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
                case 1 % Format.EMPTY
                    format_tag = 'em';
                case 2 % Format.STRING
                    format_tag = 'st';
                case 3 % Format.STRINGLIST
                    format_tag = 'sl';
                case 4 % Format.LOGICAL
                    format_tag = 'lo';
                case 5 % Format.OPTION
                    format_tag = 'op';
                case 6 % Format.CLASS
                    format_tag = 'ca';
                case 7 % Format.CLASSLIST
                    format_tag = 'cl';
                case 8 % Format.ITEM
                    format_tag = 'it';
                case 9 % Format.ITEMLIST
                    format_tag = 'il';
                case 10 % Format.IDICT
                    format_tag = 'di';
                case 11 % Format.SCALAR
                    format_tag = 'nn';
                case 12 % Format.RVECTOR
                    format_tag = 'nr';
                case 13 % Format.CVECTOR
                    format_tag = 'nc';
                case 14 % Format.MATRIX
                    format_tag = 'nm';
                case 15 % Format.SMATRIX
                    format_tag = 'ns';
                case 16 % Format.CELL
                    format_tag = 'll';
                case 17 % Format.NET
                    format_tag = 'ml';
                case 18 % Format.HANDLE
                    format_tag = 'ha';
                case 19 % Format.HANDLELIST
                    format_tag = 'hl';
                case 20 % Format.COLOR
                    format_tag = 'co';
                case 21 % Format.ALPHA
                    format_tag = 'al';
                case 22 % Format.SIZE
                    format_tag = 'sz';
                case 23 % Format.MARKER
                    format_tag = 'mr';
                case 24 % Format.LINE
                    format_tag = 'ln';
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
                case 1 % Format.EMPTY
                    format_name = 'empty';
                case 2 % Format.STRING
                    format_name = 'string';
                case 3 % Format.STRINGLIST
                    format_name = 'stringlist';
                case 4 % Format.LOGICAL
                    format_name = 'logical';
                case 5 % Format.OPTION
                    format_name = 'option';
                case 6 % Format.CLASS
                    format_name = 'class';
                case 7 % Format.CLASSLIST
                    format_name = 'classlist';
                case 8 % Format.ITEM
                    format_name = 'item';
                case 9 % Format.ITEMLIST
                    format_name = 'itemlist';
                case 10 % Format.IDICT
                    format_name = 'idict';
                case 11 % Format.SCALAR
                    format_name = 'scalar';
                case 12 % Format.RVECTOR
                    format_name = 'rvector';
                case 13 % Format.CVECTOR
                    format_name = 'cvector';
                case 14 % Format.MATRIX
                    format_name = 'matrix';
                case 15 % Format.SMATRIX
                    format_name = 'smatrix';
                case 16 % Format.CELL
                    format_name = 'cell';
                case 17 % Format.NET
                    format_name = 'net';
                case 18 % Format.HANDLE
                    format_name = 'handle';
                case 19 % Format.HANDLELIST
                    format_name = 'handlelist';
                case 20 % Format.COLOR
                    format_name = 'color';
                case 21 % Format.ALPHA
                    format_name = 'alpha';
                case 22 % Format.SIZE
                    format_name = 'size';
                case 23 % Format.MARKER
                    format_name = 'marker';
                case 24 % Format.LINE
                    format_name = 'line';
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
                case 1 % Format.EMPTY
                    format_description = 'Empty has an empty value and is typically used as a result or query to execute some code.';
                case 2 % Format.STRING
                    format_description = 'String is a char array.';
                case 3 % Format.STRINGLIST
                    format_description = 'StringList is a cell array with char arrays.';
                case 4 % Format.LOGICAL
                    format_description = 'Logical is a boolean value.';
                case 5 % Format.OPTION
                    format_description = 'Option is a char array representing an option within a set defined in the element (case sensitive).';
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'Admissible options are ' ...
                            char(join(cellfun(@(x) ['''' x ''''], format_settings, 'UniformOutput', false))) ...
                            '.' ...
                            ];                        
                    end
                case 6 % Format.CLASS
                    format_description = 'Class is a char array corresponding to an element class.';
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'The element class must be ' format_settings ' or one of its subclasses.' ...
                            ];
                    end
                case 7 % Format.CLASSLIST
                    format_description = 'ClassList is a cell array with char arrays corresponding to element classes.';
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'All element classes must be ' format_settings ' or one of its subclasses.' ...
                            ];
                    end
                case 8 % Format.ITEM
                    format_description = 'Item is a pointer to an element of a class defined in the element.';
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'The item must be of class ' format_settings ' or one of its subclasses.' ...
                            ];                        
                    end
                case 9 % Format.ITEMLIST
                    format_description = 'ItemList is a cell array with pointers to elements of a class defined in the element.';
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'All items must be of class ' format_settings ' or one of its subclasses.' ...
                            ];                        
                    end
                case 10 % Format.IDICT
                    format_description = 'Idict is an indexed dictionary of elements of a class defined in the element.';
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'The dictionary items must be of class ' format_settings ' or one of its subclasses.' ...
                            ];                        
                    end
                case 11 % Format.SCALAR
                    format_description = 'Scalar is a scalar numerical value.';
                case 12 % Format.RVECTOR
                    format_description = 'Rvector is a numerical row vector.';
                case 13 % Format.CVECTOR
                    format_description = 'Cvector is a numerical column vector.';
                case 14 % Format.MATRIX
                    format_description = 'Matrix is a numerical matrix.';
                case 15 % Format.SMATRIX
                    format_description = 'Smatrix is a numerical square matrix.';
                case 16 % Format.CELL
                    format_description = 'Cell is a 2D cell array of numeric data, typically used for adjacency matrices and measures.';
                case 17 % Format.NET
                    format_description = 'Net is a MatLab neural network object (network, SeriesNetwork, DAGNetwork, dlnetwork).';
                case 18 % Format.HANDLE
                    format_description = 'Handle is a handle for a graphical or listener component. It should only be used as an evanescent property.';
                case 19 % Format.HANDLELIST
                    format_description = 'HandleList is a cell array with handles for graphical or listener components. It should only be used as an evanescent property.';
                case 20 % Format.COLOR
                    format_description = 'Color is an RGB color.';
                case 21 % Format.ALPHA
                    format_description = 'Alpha is a transparency level between 0 and 1.';
                case 22 % Format.SIZE
                    format_description = 'Size represents the size of a graphical component. It is a positive number (default = 1).';
                case 23 % Format.MARKER
                    format_description = 'Marker represents the marker style. It can be ''o'' (circle), ''+'' (plus), ''*'' (asterisk), ''.'' (point), ''x'' (cross), ''_'' (horizontal line), ''|'' (vertical line), ''s'' (square), ''d'' (diamond), ''^'' (upward triangle), ''v'' (downward triangle), ''>'' (right triangle), ''<'' (left triangle), ''p'' (pentagram), ''h'' (hexagram), '''' (no marker).';
                case 24 % Format.LINE
                    format_description = 'Line represents the line style. It can be ''-'' (solid), '':'' (dotted), ''-.'' (dashdot), ''--'' (dashed), '''' (no line).';
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
                case 1 % Format.EMPTY
                    format_settings = [];
                case 2 % Format.STRING
                    format_settings = [];
                case 3 % Format.STRINGLIST
                    format_settings = [];
                case 4 % Format.LOGICAL
                    format_settings = [];
                case 5 % Format.OPTION
                    % setting must be a cell array of options
                    if nargin < 2 || isempty(format_settings)
                        format_settings = {''};
                    end
                case 6 % Format.CLASS
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    if nargin < 2 || isempty(format_settings)
                        format_settings = 'ConcreteElement';
                    end
                case 7 % Format.CLASSLIST
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    if nargin < 2 || isempty(format_settings)
                        format_settings = 'ConcreteElement';
                    end
                case 8 % Format.ITEM
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    if nargin < 2 || isempty(format_settings)
                        format_settings = 'ConcreteElement';
                    end
                case 9 % Format.ITEMLIST
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    if nargin < 2 || isempty(format_settings)
                        format_settings = 'ConcreteElement';
                    end
                case 10 % Format.IDICT
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    if nargin < 2 || isempty(format_settings)
                        format_settings = 'ConcreteElement';
                    end
                case 11 % Format.SCALAR
                    format_settings = '';
                case 12 % Format.RVECTOR
                    format_settings = '';
                case 13 % Format.CVECTOR
                    format_settings = '';
                case 14 % Format.MATRIX
                    format_settings = '';
                case 15 % Format.SMATRIX
                    format_settings = '';
                case 16 % Format.CELL
                    format_settings = '';
                case 17 % Format.NET
                    format_settings = '';
                case 18 % Format.HANDLE
                    format_settings = '';
                case 19 % Format.HANDLELIST
                    format_settings = '';
                case 20 % Format.COLOR
                    format_settings = '';
                case 21 % Format.ALPHA
                    format_settings = '';
                case 22 % Format.SIZE
                    format_settings = '';
                case 23 % Format.MARKER
                    format_settings = {'o', '+', '*', '.', 'x', '_', '|', 's', 'd', '^', 'v', '>', '<', 'p', 'h', 'none'};
                case 24 % Format.LINE
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
                case 1 % Format.EMPTY
                    format_default = [];
                case 2 % Format.STRING
                    format_default = '';
                case 3 % Format.STRINGLIST
                    format_default = {};
                case 4 % Format.LOGICAL
                    format_default = false;
                case 5 % Format.OPTION
                    % setting must be a cell array of options
                    if nargin < 2 || isempty(format_settings)
                        format_default = '';
                    else
                        format_default = format_settings{1};
                    end
                case 6 % Format.CLASS
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    if nargin < 2 || isempty(format_settings)
                        format_default = 'ConcreteElement';
                    else
                        format_default = format_settings;                        
                    end
                case 7 % Format.CLASSLIST
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    format_default = {};
                case 8 % Format.ITEM
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    if nargin < 2 || isempty(format_settings)
                        format_default = ConcreteElement();
                    else
                        format_default = eval([format_settings '()']);
                    end
                case 9 % Format.ITEMLIST
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    format_default = {};
                case 10 % Format.IDICT
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    if nargin < 2 || isempty(format_settings)
                        format_default = IndexedDictionary();
                    else
                        format_default = IndexedDictionary('IT_CLASS', format_settings);
                    end
                case 11 % Format.SCALAR
                    format_default = 0;
                case 12 % Format.RVECTOR
                    format_default = [];
                case 13 % Format.CVECTOR
                    format_default = [];
                case 14 % Format.MATRIX
                    format_default = [];
                case 15 % Format.SMATRIX
                    format_default = [];
                case 16 % Format.CELL
                    format_default = {};
                case 17 % Format.NET
                    if BRAPH2.installed('NN', 'warning')
                        format_default = network();
                    else
                        format_default = Element.getNoValue();
                    end
                case 18 % Format.HANDLE
                    format_default = gobjects(1);
                case 19 % Format.HANDLELIST
                    format_default = {};
                case 20 % Format.COLOR
                    format_default = [0.9 0.4 0.1];
                case 21 % Format.ALPHA
                    format_default = 1;
                case 22 % Format.SIZE
                    format_default = 1;
                case 23 % Format.MARKER
                    format_default = 'o';
                case 24 % Format.LINE
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
            %  Error id: BRAPH2:Format:WrongInput
            %
            % See also getFormats, getFormatTag, getFormatName, getFormatDescription,
            %  getFormatSettings, getFormatDefault.

            if nargin < 3 || isempty(format_settings)
                format_settings = [];
            end
            
            switch format
                case 1 % Format.EMPTY
                    check = isempty(value);
                case 2 % Format.STRING
                    check = ischar(value);
                case 3 % Format.STRINGLIST
                    check = iscell(value) && all(cellfun(@(x) ischar(x), value));
                case 4 % Format.LOGICAL
                    check = islogical(value) && numel(value) == 1;
                case 5 % Format.OPTION
                    % setting must be a cell array of options
                    options = Format.getFormatSettings(5, format_settings);
                    check = ischar(value) && any(strcmp(value, options));
                case 6 % Format.CLASS
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    class = Format.getFormatSettings(6, format_settings);
                    check = ischar(value) ...
                        && any(strcmp(class, ConcreteElement.getSubclasses())) ...
                        && any(strcmp(value, Element.getSubclasses(class)));
                case 7 % Format.CLASSLIST
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    class = Format.getFormatSettings(7, format_settings);
                    check = iscell(value) ...
                        && any(strcmp(class, ConcreteElement.getSubclasses())) ...
                        && all(cellfun(@(x) any(strcmp(x, Element.getSubclasses(class))), value));
                case 8 % Format.ITEM
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    class = Format.getFormatSettings(8, format_settings);
                    check = any(strcmp(class, ConcreteElement.getSubclasses())) && isa(value, class);
                case 9 % Format.ITEMLIST
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    class = Format.getFormatSettings(9, format_settings);
                    check = iscell(value) && ...
                        any(strcmp(class, ConcreteElement.getSubclasses())) && ...
                        all(cellfun(@(x) isa(x, class), value));
                case 10 % Format.IDICT
                    % settings must be a class name of a subclass of ConcreteElement (or ConcreteElement itself)
                    class = Format.getFormatSettings(10, format_settings);
                    check = isa(value, 'IndexedDictionary') && ...
                        any(strcmp(class, subclasses('ConcreteElement', [], [], true))) && ...
                        any(strcmp(value.get('IT_CLASS'), subclasses(class, [], [], true)));
                case 11 % Format.SCALAR
                    check = isnumeric(value) && isscalar(value);
                case 12 % Format.RVECTOR
                    check = isnumeric(value) && (isrow(value) || isempty(value));
                case 13 % Format.CVECTOR
                    check = isnumeric(value) && (iscolumn(value) || isempty(value));
                case 14 % Format.MATRIX
                    check = isnumeric(value) && ismatrix(value);
                case 15 % Format.SMATRIX
                    check = isnumeric(value) && ismatrix(value) && size(value, 1) == size(value, 2);
                case 16 % Format.CELL
                    check = iscell(value) && all(cellfun(@(x) isnumeric(x), value(:)));
                case 17 % Format.NET
                    if BRAPH2.installed('NN', 'warning')
                        check = isa(value, 'network') || isa(value, 'SeriesNetwork') || isa(value, 'DAGNetwork') || isa(value, 'dlnetwork');
                    else
                        check = isa(value, 'NoValue');
                    end
                case 18 % Format.HANDLE
                    check = isa(value, 'matlab.graphics.Graphics') || isa(value, 'event.listener');
                case 19 % Format.HANDLELIST
                    check = iscell(value) && all(cellfun(@(x) isa(x, 'matlab.graphics.Graphics') || isa(x, 'event.listener'), value));
                case 20 % Format.COLOR
                    check = isnumeric(value) && (length(value) == 3) && all(value >= 0 & value <= 1);
                case 21 % Format.ALPHA
                    check = isnumeric(value) && isscalar(value) && value >= 0 && value <= 1;
                case 22 % Format.SIZE
                    check = isnumeric(value) && isscalar(value) && value > 0;
                case 23 % Format.MARKER
                    check = ischar(value) && any(strcmp(value, Format.getFormatSettings(23)));
                case 24 % Format.LINE
                    check = ischar(value) && any(strcmp(value, Format.getFormatSettings(24)));
                otherwise
                    Format.existsFormat(format) % error because format does not exist
            end
            
            if nargout == 1
                format_check = check;
            elseif ~check
                error( ...
                    ['BRAPH2' ':Format:' 'WrongInput'], ...
                    ['BRAPH2' ':Format:' 'WrongInput' '\n' ...
                    'The value ' tostring(value) ' is not a valid Format.' ...
                    upper(Format.getFormatName(format)) '. ' ...
                    Format.getFormatDescription(format)] ...
                    )
            end
        end
    end
end
