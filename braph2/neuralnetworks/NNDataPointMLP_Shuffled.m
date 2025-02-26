classdef NNDataPointMLP_Shuffled < NNDataPoint
	%NNDataPointMLP_Shuffled is a data point with shuffled features for multi-layer perceptron neural network.
	% It is a subclass of <a href="matlab:help NNDataPoint">NNDataPoint</a>.
	%
	% A shuffled neural network data point for multi-layer perceptron (NNDataPointMLP_Shuffled) contains a data point with its shuffled inputs and original targets for multi-layer perceptron neural network analysis.
	% The shuffled inputs are used to evaluate the impact of specific feature (or composite features) on the performance of the multi-layer perceptron neural network.
	%
	% The list of NNDataPointMLP_Shuffled properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the shuffled data point for neural network analysis .
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the shuffled data point for neural network analysis.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the shuffled data point for neural network analysis.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the shuffled data point for neural network analysis.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the shuffled data point for neural network analysis.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the shuffled data point for neural network analysis.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the shuffled data point for neural network analysis.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>INPUT</strong> 	INPUT (result, cell) is the input value for this data point for neural network analysis.
	%  <strong>10</strong> <strong>TARGET</strong> 	TARGET (result, cell) is the target value for this data point.
	%  <strong>11</strong> <strong>SHUFFLED_INPUT</strong> 	SHUFFLED_INPUT (data, cell) is the shuffled input value for this data point.
	%
	% NNDataPointMLP_Shuffled methods (constructor):
	%  NNDataPointMLP_Shuffled - constructor
	%
	% NNDataPointMLP_Shuffled methods:
	%  set - sets values of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns the value of a property and memorizes it
	%             (for RESULT, QUERY, and EVANESCENT properties)
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% NNDataPointMLP_Shuffled methods (display):
	%  tostring - string with information about the shuffled neural network data point for multi-layer perceptron
	%  disp - displays information about the shuffled neural network data point for multi-layer perceptron
	%  tree - displays the tree of the shuffled neural network data point for multi-layer perceptron
	%
	% NNDataPointMLP_Shuffled methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two shuffled neural network data point for multi-layer perceptron are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the shuffled neural network data point for multi-layer perceptron
	%
	% NNDataPointMLP_Shuffled methods (save/load, Static):
	%  save - saves BRAPH2 shuffled neural network data point for multi-layer perceptron as b2 file
	%  load - loads a BRAPH2 shuffled neural network data point for multi-layer perceptron from a b2 file
	%
	% NNDataPointMLP_Shuffled method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the shuffled neural network data point for multi-layer perceptron
	%
	% NNDataPointMLP_Shuffled method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the shuffled neural network data point for multi-layer perceptron
	%
	% NNDataPointMLP_Shuffled methods (inspection, Static):
	%  getClass - returns the class of the shuffled neural network data point for multi-layer perceptron
	%  getSubclasses - returns all subclasses of NNDataPointMLP_Shuffled
	%  getProps - returns the property list of the shuffled neural network data point for multi-layer perceptron
	%  getPropNumber - returns the property number of the shuffled neural network data point for multi-layer perceptron
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditioned default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% NNDataPointMLP_Shuffled methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNDataPointMLP_Shuffled methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNDataPointMLP_Shuffled methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNDataPointMLP_Shuffled methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNDataPointMLP_Shuffled; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNDataPointMLP_Shuffled constants</a>.
	%
	%
	% See also NNDataPoint, NNDataset.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		SHUFFLED_INPUT = 11; %CET: Computational Efficiency Trick
		SHUFFLED_INPUT_TAG = 'SHUFFLED_INPUT';
		SHUFFLED_INPUT_CATEGORY = 4;
		SHUFFLED_INPUT_FORMAT = 16;
	end
	methods % constructor
		function dp = NNDataPointMLP_Shuffled(varargin)
			%NNDataPointMLP_Shuffled() creates a shuffled neural network data point for multi-layer perceptron.
			%
			% NNDataPointMLP_Shuffled(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNDataPointMLP_Shuffled(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNDataPointMLP_Shuffled properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the shuffled data point for neural network analysis .
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the shuffled data point for neural network analysis.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the shuffled data point for neural network analysis.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the shuffled data point for neural network analysis.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the shuffled data point for neural network analysis.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the shuffled data point for neural network analysis.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the shuffled data point for neural network analysis.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>INPUT</strong> 	INPUT (result, cell) is the input value for this data point for neural network analysis.
			%  <strong>10</strong> <strong>TARGET</strong> 	TARGET (result, cell) is the target value for this data point.
			%  <strong>11</strong> <strong>SHUFFLED_INPUT</strong> 	SHUFFLED_INPUT (data, cell) is the shuffled input value for this data point.
			%
			% See also Category, Format.
			
			dp = dp@NNDataPoint(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the shuffled neural network data point for multi-layer perceptron.
			%
			% BUILD = NNDataPointMLP_Shuffled.GETBUILD() returns the build of 'NNDataPointMLP_Shuffled'.
			%
			% Alternative forms to call this method are:
			%  BUILD = DP.GETBUILD() returns the build of the shuffled neural network data point for multi-layer perceptron DP.
			%  BUILD = Element.GETBUILD(DP) returns the build of 'DP'.
			%  BUILD = Element.GETBUILD('NNDataPointMLP_Shuffled') returns the build of 'NNDataPointMLP_Shuffled'.
			%
			% Note that the Element.GETBUILD(DP) and Element.GETBUILD('NNDataPointMLP_Shuffled')
			%  are less computationally efficient.
			
			build = 1;
		end
		function dp_class = getClass()
			%GETCLASS returns the class of the shuffled neural network data point for multi-layer perceptron.
			%
			% CLASS = NNDataPointMLP_Shuffled.GETCLASS() returns the class 'NNDataPointMLP_Shuffled'.
			%
			% Alternative forms to call this method are:
			%  CLASS = DP.GETCLASS() returns the class of the shuffled neural network data point for multi-layer perceptron DP.
			%  CLASS = Element.GETCLASS(DP) returns the class of 'DP'.
			%  CLASS = Element.GETCLASS('NNDataPointMLP_Shuffled') returns 'NNDataPointMLP_Shuffled'.
			%
			% Note that the Element.GETCLASS(DP) and Element.GETCLASS('NNDataPointMLP_Shuffled')
			%  are less computationally efficient.
			
			dp_class = 'NNDataPointMLP_Shuffled';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the shuffled neural network data point for multi-layer perceptron.
			%
			% LIST = NNDataPointMLP_Shuffled.GETSUBCLASSES() returns all subclasses of 'NNDataPointMLP_Shuffled'.
			%
			% Alternative forms to call this method are:
			%  LIST = DP.GETSUBCLASSES() returns all subclasses of the shuffled neural network data point for multi-layer perceptron DP.
			%  LIST = Element.GETSUBCLASSES(DP) returns all subclasses of 'DP'.
			%  LIST = Element.GETSUBCLASSES('NNDataPointMLP_Shuffled') returns all subclasses of 'NNDataPointMLP_Shuffled'.
			%
			% Note that the Element.GETSUBCLASSES(DP) and Element.GETSUBCLASSES('NNDataPointMLP_Shuffled')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNDataPointMLP_Shuffled' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of shuffled neural network data point for multi-layer perceptron.
			%
			% PROPS = NNDataPointMLP_Shuffled.GETPROPS() returns the property list of shuffled neural network data point for multi-layer perceptron
			%  as a row vector.
			%
			% PROPS = NNDataPointMLP_Shuffled.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = DP.GETPROPS([CATEGORY]) returns the property list of the shuffled neural network data point for multi-layer perceptron DP.
			%  PROPS = Element.GETPROPS(DP[, CATEGORY]) returns the property list of 'DP'.
			%  PROPS = Element.GETPROPS('NNDataPointMLP_Shuffled'[, CATEGORY]) returns the property list of 'NNDataPointMLP_Shuffled'.
			%
			% Note that the Element.GETPROPS(DP) and Element.GETPROPS('NNDataPointMLP_Shuffled')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 11];
				case 5 % Category.RESULT
					prop_list = [9 10];
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of shuffled neural network data point for multi-layer perceptron.
			%
			% N = NNDataPointMLP_Shuffled.GETPROPNUMBER() returns the property number of shuffled neural network data point for multi-layer perceptron.
			%
			% N = NNDataPointMLP_Shuffled.GETPROPNUMBER(CATEGORY) returns the property number of shuffled neural network data point for multi-layer perceptron
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = DP.GETPROPNUMBER([CATEGORY]) returns the property number of the shuffled neural network data point for multi-layer perceptron DP.
			%  N = Element.GETPROPNUMBER(DP) returns the property number of 'DP'.
			%  N = Element.GETPROPNUMBER('NNDataPointMLP_Shuffled') returns the property number of 'NNDataPointMLP_Shuffled'.
			%
			% Note that the Element.GETPROPNUMBER(DP) and Element.GETPROPNUMBER('NNDataPointMLP_Shuffled')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 11;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in shuffled neural network data point for multi-layer perceptron/error.
			%
			% CHECK = NNDataPointMLP_Shuffled.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DP.EXISTSPROP(PROP) checks whether PROP exists for DP.
			%  CHECK = Element.EXISTSPROP(DP, PROP) checks whether PROP exists for DP.
			%  CHECK = Element.EXISTSPROP(NNDataPointMLP_Shuffled, PROP) checks whether PROP exists for NNDataPointMLP_Shuffled.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNDataPointMLP_Shuffled:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DP.EXISTSPROP(PROP) throws error if PROP does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPointMLP_Shuffled:WrongInput]
			%  Element.EXISTSPROP(DP, PROP) throws error if PROP does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPointMLP_Shuffled:WrongInput]
			%  Element.EXISTSPROP(NNDataPointMLP_Shuffled, PROP) throws error if PROP does NOT exist for NNDataPointMLP_Shuffled.
			%   Error id: [BRAPH2:NNDataPointMLP_Shuffled:WrongInput]
			%
			% Note that the Element.EXISTSPROP(DP) and Element.EXISTSPROP('NNDataPointMLP_Shuffled')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 11 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDataPointMLP_Shuffled:' 'WrongInput'], ...
					['BRAPH2' ':NNDataPointMLP_Shuffled:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNDataPointMLP_Shuffled.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in shuffled neural network data point for multi-layer perceptron/error.
			%
			% CHECK = NNDataPointMLP_Shuffled.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DP.EXISTSTAG(TAG) checks whether TAG exists for DP.
			%  CHECK = Element.EXISTSTAG(DP, TAG) checks whether TAG exists for DP.
			%  CHECK = Element.EXISTSTAG(NNDataPointMLP_Shuffled, TAG) checks whether TAG exists for NNDataPointMLP_Shuffled.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNDataPointMLP_Shuffled:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DP.EXISTSTAG(TAG) throws error if TAG does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPointMLP_Shuffled:WrongInput]
			%  Element.EXISTSTAG(DP, TAG) throws error if TAG does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPointMLP_Shuffled:WrongInput]
			%  Element.EXISTSTAG(NNDataPointMLP_Shuffled, TAG) throws error if TAG does NOT exist for NNDataPointMLP_Shuffled.
			%   Error id: [BRAPH2:NNDataPointMLP_Shuffled:WrongInput]
			%
			% Note that the Element.EXISTSTAG(DP) and Element.EXISTSTAG('NNDataPointMLP_Shuffled')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'INPUT'  'TARGET'  'SHUFFLED_INPUT' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDataPointMLP_Shuffled:' 'WrongInput'], ...
					['BRAPH2' ':NNDataPointMLP_Shuffled:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNDataPointMLP_Shuffled.'] ...
					)
			end
		end
		function prop = getPropProp(pointer)
			%GETPROPPROP returns the property number of a property.
			%
			% PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the 
			%  property number of the property PROP.
			%
			% PROP = Element.GETPROPPROP(TAG) returns the property number 
			%  of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PROPERTY = DP.GETPROPPROP(POINTER) returns property number of POINTER of DP.
			%  PROPERTY = Element.GETPROPPROP(NNDataPointMLP_Shuffled, POINTER) returns property number of POINTER of NNDataPointMLP_Shuffled.
			%  PROPERTY = DP.GETPROPPROP(NNDataPointMLP_Shuffled, POINTER) returns property number of POINTER of NNDataPointMLP_Shuffled.
			%
			% Note that the Element.GETPROPPROP(DP) and Element.GETPROPPROP('NNDataPointMLP_Shuffled')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'INPUT'  'TARGET'  'SHUFFLED_INPUT' })); % tag = pointer %CET: Computational Efficiency Trick
			else % numeric
				prop = pointer;
			end
		end
		function tag = getPropTag(pointer)
			%GETPROPTAG returns the tag of a property.
			%
			% TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the 
			%  property PROP.
			%
			% TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of 
			%  the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  TAG = DP.GETPROPTAG(POINTER) returns tag of POINTER of DP.
			%  TAG = Element.GETPROPTAG(NNDataPointMLP_Shuffled, POINTER) returns tag of POINTER of NNDataPointMLP_Shuffled.
			%  TAG = DP.GETPROPTAG(NNDataPointMLP_Shuffled, POINTER) returns tag of POINTER of NNDataPointMLP_Shuffled.
			%
			% Note that the Element.GETPROPTAG(DP) and Element.GETPROPTAG('NNDataPointMLP_Shuffled')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nndatapointmlp_shuffled_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'INPUT'  'TARGET'  'SHUFFLED_INPUT' };
				tag = nndatapointmlp_shuffled_tag_list{pointer}; % prop = pointer
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the category of the
			%  property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the category of the
			%  property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = DP.GETPROPCATEGORY(POINTER) returns category of POINTER of DP.
			%  CATEGORY = Element.GETPROPCATEGORY(NNDataPointMLP_Shuffled, POINTER) returns category of POINTER of NNDataPointMLP_Shuffled.
			%  CATEGORY = DP.GETPROPCATEGORY(NNDataPointMLP_Shuffled, POINTER) returns category of POINTER of NNDataPointMLP_Shuffled.
			%
			% Note that the Element.GETPROPCATEGORY(DP) and Element.GETPROPCATEGORY('NNDataPointMLP_Shuffled')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNDataPointMLP_Shuffled.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatapointmlp_shuffled_category_list = { 1  1  1  3  4  2  2  6  5  5  4 };
			prop_category = nndatapointmlp_shuffled_category_list{prop};
		end
		function prop_format = getPropFormat(pointer)
			%GETPROPFORMAT returns the format of a property.
			%
			% FORMAT = Element.GETPROPFORMAT(PROP) returns the
			%  format of the property PROP.
			%
			% FORMAT = Element.GETPROPFORMAT(TAG) returns the
			%  format of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  FORMAT = DP.GETPROPFORMAT(POINTER) returns format of POINTER of DP.
			%  FORMAT = Element.GETPROPFORMAT(NNDataPointMLP_Shuffled, POINTER) returns format of POINTER of NNDataPointMLP_Shuffled.
			%  FORMAT = DP.GETPROPFORMAT(NNDataPointMLP_Shuffled, POINTER) returns format of POINTER of NNDataPointMLP_Shuffled.
			%
			% Note that the Element.GETPROPFORMAT(DP) and Element.GETPROPFORMAT('NNDataPointMLP_Shuffled')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDataPointMLP_Shuffled.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatapointmlp_shuffled_format_list = { 2  2  2  8  2  2  2  2  16  16  16 };
			prop_format = nndatapointmlp_shuffled_format_list{prop};
		end
		function prop_description = getPropDescription(pointer)
			%GETPROPDESCRIPTION returns the description of a property.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the
			%  description of the property PROP.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the
			%  description of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DESCRIPTION = DP.GETPROPDESCRIPTION(POINTER) returns description of POINTER of DP.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNDataPointMLP_Shuffled, POINTER) returns description of POINTER of NNDataPointMLP_Shuffled.
			%  DESCRIPTION = DP.GETPROPDESCRIPTION(NNDataPointMLP_Shuffled, POINTER) returns description of POINTER of NNDataPointMLP_Shuffled.
			%
			% Note that the Element.GETPROPDESCRIPTION(DP) and Element.GETPROPDESCRIPTION('NNDataPointMLP_Shuffled')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDataPointMLP_Shuffled.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatapointmlp_shuffled_description_list = { 'ELCLASS (constant, string) is the class of the shuffled data point for neural network analysis .'  'NAME (constant, string) is the name of the shuffled data point for neural network analysis.'  'DESCRIPTION (constant, string) is the description of the shuffled data point for neural network analysis.'  'TEMPLATE (parameter, item) is the template of the shuffled data point for neural network analysis.'  'ID (data, string) is a few-letter code for the shuffled data point for neural network analysis.'  'LABEL (metadata, string) is an extended label of the shuffled data point for neural network analysis.'  'NOTES (metadata, string) are some specific notes about the shuffled data point for neural network analysis.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'INPUT (result, cell) is the input value for this data point for neural network analysis.'  'TARGET (result, cell) is the target value for this data point.'  'SHUFFLED_INPUT (data, cell) is the shuffled input value for this data point.' };
			prop_description = nndatapointmlp_shuffled_description_list{prop};
		end
		function prop_settings = getPropSettings(pointer)
			%GETPROPSETTINGS returns the settings of a property.
			%
			% SETTINGS = Element.GETPROPSETTINGS(PROP) returns the
			%  settings of the property PROP.
			%
			% SETTINGS = Element.GETPROPSETTINGS(TAG) returns the
			%  settings of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SETTINGS = DP.GETPROPSETTINGS(POINTER) returns settings of POINTER of DP.
			%  SETTINGS = Element.GETPROPSETTINGS(NNDataPointMLP_Shuffled, POINTER) returns settings of POINTER of NNDataPointMLP_Shuffled.
			%  SETTINGS = DP.GETPROPSETTINGS(NNDataPointMLP_Shuffled, POINTER) returns settings of POINTER of NNDataPointMLP_Shuffled.
			%
			% Note that the Element.GETPROPSETTINGS(DP) and Element.GETPROPSETTINGS('NNDataPointMLP_Shuffled')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNDataPointMLP_Shuffled.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 11 % NNDataPointMLP_Shuffled.SHUFFLED_INPUT
					prop_settings = Format.getFormatSettings(16);
				case 4 % NNDataPointMLP_Shuffled.TEMPLATE
					prop_settings = 'NNDataPointMLP_Shuffled';
				otherwise
					prop_settings = getPropSettings@NNDataPoint(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNDataPointMLP_Shuffled.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataPointMLP_Shuffled.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of DP.
			%  DEFAULT = Element.GETPROPDEFAULT(NNDataPointMLP_Shuffled, POINTER) returns the default value of POINTER of NNDataPointMLP_Shuffled.
			%  DEFAULT = DP.GETPROPDEFAULT(NNDataPointMLP_Shuffled, POINTER) returns the default value of POINTER of NNDataPointMLP_Shuffled.
			%
			% Note that the Element.GETPROPDEFAULT(DP) and Element.GETPROPDEFAULT('NNDataPointMLP_Shuffled')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDataPointMLP_Shuffled.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 11 % NNDataPointMLP_Shuffled.SHUFFLED_INPUT
					prop_default = Format.getFormatDefault(16, NNDataPointMLP_Shuffled.getPropSettings(prop));
				case 1 % NNDataPointMLP_Shuffled.ELCLASS
					prop_default = 'NNDataPointMLP_Shuffled';
				case 2 % NNDataPointMLP_Shuffled.NAME
					prop_default = 'Shuffled Neural Network Data Point';
				case 3 % NNDataPointMLP_Shuffled.DESCRIPTION
					prop_default = 'A shuffled neural network data point for multi-layer perceptron (NNDataPointMLP_Shuffled) contains a data point with its shuffled inputs and original targets for multi-layer perceptron neural network analysis. The shuffled inputs are used to evaluate the impact of specific feature (or composite features) on the performance of the multi-layer perceptron neural network.';
				case 4 % NNDataPointMLP_Shuffled.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNDataPointMLP_Shuffled.getPropSettings(prop));
				case 5 % NNDataPointMLP_Shuffled.ID
					prop_default = 'NNDataPointMLP_Shuffled ID';
				case 6 % NNDataPointMLP_Shuffled.LABEL
					prop_default = 'NNDataPointMLP_Shuffled label';
				case 7 % NNDataPointMLP_Shuffled.NOTES
					prop_default = 'NNDataPoint_Permuted notes';
				otherwise
					prop_default = getPropDefault@NNDataPoint(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNDataPointMLP_Shuffled.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataPointMLP_Shuffled.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of DP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNDataPointMLP_Shuffled, POINTER) returns the conditioned default value of POINTER of NNDataPointMLP_Shuffled.
			%  DEFAULT = DP.GETPROPDEFAULTCONDITIONED(NNDataPointMLP_Shuffled, POINTER) returns the conditioned default value of POINTER of NNDataPointMLP_Shuffled.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(DP) and Element.GETPROPDEFAULTCONDITIONED('NNDataPointMLP_Shuffled')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNDataPointMLP_Shuffled.getPropProp(pointer);
			
			prop_default = NNDataPointMLP_Shuffled.conditioning(prop, NNDataPointMLP_Shuffled.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = DP.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = DP.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of DP.
			%  CHECK = Element.CHECKPROP(NNDataPointMLP_Shuffled, PROP, VALUE) checks VALUE format for PROP of NNDataPointMLP_Shuffled.
			%  CHECK = DP.CHECKPROP(NNDataPointMLP_Shuffled, PROP, VALUE) checks VALUE format for PROP of NNDataPointMLP_Shuffled.
			% 
			% DP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNDataPointMLP_Shuffled:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of DP.
			%   Error id: BRAPH2:NNDataPointMLP_Shuffled:WrongInput
			%  Element.CHECKPROP(NNDataPointMLP_Shuffled, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataPointMLP_Shuffled.
			%   Error id: BRAPH2:NNDataPointMLP_Shuffled:WrongInput
			%  DP.CHECKPROP(NNDataPointMLP_Shuffled, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataPointMLP_Shuffled.
			%   Error id: BRAPH2:NNDataPointMLP_Shuffled:WrongInput]
			% 
			% Note that the Element.CHECKPROP(DP) and Element.CHECKPROP('NNDataPointMLP_Shuffled')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNDataPointMLP_Shuffled.getPropProp(pointer);
			
			switch prop
				case 11 % NNDataPointMLP_Shuffled.SHUFFLED_INPUT
					check = Format.checkFormat(16, value, NNDataPointMLP_Shuffled.getPropSettings(prop));
				case 4 % NNDataPointMLP_Shuffled.TEMPLATE
					check = Format.checkFormat(8, value, NNDataPointMLP_Shuffled.getPropSettings(prop));
				otherwise
					if prop <= 10
						check = checkProp@NNDataPoint(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDataPointMLP_Shuffled:' 'WrongInput'], ...
					['BRAPH2' ':NNDataPointMLP_Shuffled:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNDataPointMLP_Shuffled.getPropTag(prop) ' (' NNDataPointMLP_Shuffled.getFormatTag(NNDataPointMLP_Shuffled.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(dp, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with 5,
			%  6, and 7. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  6.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case 9 % NNDataPointMLP_Shuffled.INPUT
					rng_settings_ = rng(); rng(dp.getPropSeed(9), 'twister')
					
					value = dp.get('SHUFFLED_INPUT');
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 10
						value = calculateValue@NNDataPoint(dp, prop, varargin{:});
					else
						value = calculateValue@Element(dp, prop, varargin{:});
					end
			end
			
		end
	end
end
