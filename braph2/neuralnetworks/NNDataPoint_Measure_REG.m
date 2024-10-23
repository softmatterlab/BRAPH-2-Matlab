classdef NNDataPoint_Measure_REG < NNDataPoint
	%NNDataPoint_Measure_REG is a data point for regression with graph measures.
	% It is a subclass of <a href="matlab:help NNDataPoint">NNDataPoint</a>.
	%
	% A data point for regression with graph measures (NNDataPoint_Measure_REG) 
	%  contains both input and target for neural network analysis.
	% The input is the value of the graph measures (e.g. Degree, DegreeAv, and Distance), 
	%  calculated from the derived graph of the subject.
	% The target is obtained from the variables of interest of the subject.
	%
	% The list of NNDataPoint_Measure_REG properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the data point for regression with graph measures.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the data point for regression with graph measures.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the data point for regression with graph measures.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the data point for regression with graph measures.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the data point for regression with graph measures.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the data point for regression with graph measures.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the data point for regression with graph measures.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>INPUT</strong> 	INPUT (result, cell) is the input value for this data point.
	%  <strong>10</strong> <strong>TARGET</strong> 	TARGET (result, cell) is the target value for this data point.
	%  <strong>11</strong> <strong>G</strong> 	G (data, item) is a graph containing the added graph measures (M_DICT).
	%  <strong>12</strong> <strong>M_LIST</strong> 	M_LIST (parameter, classlist) is a list of graph measure to be used as the input
	%  <strong>13</strong> <strong>SUB</strong> 	SUB (data, item) is a subject.
	%  <strong>14</strong> <strong>TARGET_IDS</strong> 	TARGET_IDS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.
	%
	% NNDataPoint_Measure_REG methods (constructor):
	%  NNDataPoint_Measure_REG - constructor
	%
	% NNDataPoint_Measure_REG methods:
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
	% NNDataPoint_Measure_REG methods (display):
	%  tostring - string with information about the measure regression data point
	%  disp - displays information about the measure regression data point
	%  tree - displays the tree of the measure regression data point
	%
	% NNDataPoint_Measure_REG methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two measure regression data point are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the measure regression data point
	%
	% NNDataPoint_Measure_REG methods (save/load, Static):
	%  save - saves BRAPH2 measure regression data point as b2 file
	%  load - loads a BRAPH2 measure regression data point from a b2 file
	%
	% NNDataPoint_Measure_REG method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the measure regression data point
	%
	% NNDataPoint_Measure_REG method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the measure regression data point
	%
	% NNDataPoint_Measure_REG methods (inspection, Static):
	%  getClass - returns the class of the measure regression data point
	%  getSubclasses - returns all subclasses of NNDataPoint_Measure_REG
	%  getProps - returns the property list of the measure regression data point
	%  getPropNumber - returns the property number of the measure regression data point
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
	% NNDataPoint_Measure_REG methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNDataPoint_Measure_REG methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNDataPoint_Measure_REG methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNDataPoint_Measure_REG methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNDataPoint_Measure_REG; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNDataPoint_Measure_REG constants</a>.
	%
	%
	% See also NNDataPoint_Graph_REG, NNDataPoint_Graph_REG, NNDataPoint_Measure_CLA.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		G = 11; %CET: Computational Efficiency Trick
		G_TAG = 'G';
		G_CATEGORY = 4;
		G_FORMAT = 8;
		
		M_LIST = 12; %CET: Computational Efficiency Trick
		M_LIST_TAG = 'M_LIST';
		M_LIST_CATEGORY = 3;
		M_LIST_FORMAT = 7;
		
		SUB = 13; %CET: Computational Efficiency Trick
		SUB_TAG = 'SUB';
		SUB_CATEGORY = 4;
		SUB_FORMAT = 8;
		
		TARGET_IDS = 14; %CET: Computational Efficiency Trick
		TARGET_IDS_TAG = 'TARGET_IDS';
		TARGET_IDS_CATEGORY = 3;
		TARGET_IDS_FORMAT = 3;
	end
	methods % constructor
		function dp = NNDataPoint_Measure_REG(varargin)
			%NNDataPoint_Measure_REG() creates a measure regression data point.
			%
			% NNDataPoint_Measure_REG(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNDataPoint_Measure_REG(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNDataPoint_Measure_REG properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the data point for regression with graph measures.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the data point for regression with graph measures.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the data point for regression with graph measures.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the data point for regression with graph measures.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the data point for regression with graph measures.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the data point for regression with graph measures.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the data point for regression with graph measures.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>INPUT</strong> 	INPUT (result, cell) is the input value for this data point.
			%  <strong>10</strong> <strong>TARGET</strong> 	TARGET (result, cell) is the target value for this data point.
			%  <strong>11</strong> <strong>G</strong> 	G (data, item) is a graph containing the added graph measures (M_DICT).
			%  <strong>12</strong> <strong>M_LIST</strong> 	M_LIST (parameter, classlist) is a list of graph measure to be used as the input
			%  <strong>13</strong> <strong>SUB</strong> 	SUB (data, item) is a subject.
			%  <strong>14</strong> <strong>TARGET_IDS</strong> 	TARGET_IDS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.
			%
			% See also Category, Format.
			
			dp = dp@NNDataPoint(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the measure regression data point.
			%
			% BUILD = NNDataPoint_Measure_REG.GETBUILD() returns the build of 'NNDataPoint_Measure_REG'.
			%
			% Alternative forms to call this method are:
			%  BUILD = DP.GETBUILD() returns the build of the measure regression data point DP.
			%  BUILD = Element.GETBUILD(DP) returns the build of 'DP'.
			%  BUILD = Element.GETBUILD('NNDataPoint_Measure_REG') returns the build of 'NNDataPoint_Measure_REG'.
			%
			% Note that the Element.GETBUILD(DP) and Element.GETBUILD('NNDataPoint_Measure_REG')
			%  are less computationally efficient.
			
			build = 1;
		end
		function dp_class = getClass()
			%GETCLASS returns the class of the measure regression data point.
			%
			% CLASS = NNDataPoint_Measure_REG.GETCLASS() returns the class 'NNDataPoint_Measure_REG'.
			%
			% Alternative forms to call this method are:
			%  CLASS = DP.GETCLASS() returns the class of the measure regression data point DP.
			%  CLASS = Element.GETCLASS(DP) returns the class of 'DP'.
			%  CLASS = Element.GETCLASS('NNDataPoint_Measure_REG') returns 'NNDataPoint_Measure_REG'.
			%
			% Note that the Element.GETCLASS(DP) and Element.GETCLASS('NNDataPoint_Measure_REG')
			%  are less computationally efficient.
			
			dp_class = 'NNDataPoint_Measure_REG';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the measure regression data point.
			%
			% LIST = NNDataPoint_Measure_REG.GETSUBCLASSES() returns all subclasses of 'NNDataPoint_Measure_REG'.
			%
			% Alternative forms to call this method are:
			%  LIST = DP.GETSUBCLASSES() returns all subclasses of the measure regression data point DP.
			%  LIST = Element.GETSUBCLASSES(DP) returns all subclasses of 'DP'.
			%  LIST = Element.GETSUBCLASSES('NNDataPoint_Measure_REG') returns all subclasses of 'NNDataPoint_Measure_REG'.
			%
			% Note that the Element.GETSUBCLASSES(DP) and Element.GETSUBCLASSES('NNDataPoint_Measure_REG')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNDataPoint_Measure_REG' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of measure regression data point.
			%
			% PROPS = NNDataPoint_Measure_REG.GETPROPS() returns the property list of measure regression data point
			%  as a row vector.
			%
			% PROPS = NNDataPoint_Measure_REG.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = DP.GETPROPS([CATEGORY]) returns the property list of the measure regression data point DP.
			%  PROPS = Element.GETPROPS(DP[, CATEGORY]) returns the property list of 'DP'.
			%  PROPS = Element.GETPROPS('NNDataPoint_Measure_REG'[, CATEGORY]) returns the property list of 'NNDataPoint_Measure_REG'.
			%
			% Note that the Element.GETPROPS(DP) and Element.GETPROPS('NNDataPoint_Measure_REG')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 12 14];
				case 4 % Category.DATA
					prop_list = [5 11 13];
				case 5 % Category.RESULT
					prop_list = [9 10];
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of measure regression data point.
			%
			% N = NNDataPoint_Measure_REG.GETPROPNUMBER() returns the property number of measure regression data point.
			%
			% N = NNDataPoint_Measure_REG.GETPROPNUMBER(CATEGORY) returns the property number of measure regression data point
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = DP.GETPROPNUMBER([CATEGORY]) returns the property number of the measure regression data point DP.
			%  N = Element.GETPROPNUMBER(DP) returns the property number of 'DP'.
			%  N = Element.GETPROPNUMBER('NNDataPoint_Measure_REG') returns the property number of 'NNDataPoint_Measure_REG'.
			%
			% Note that the Element.GETPROPNUMBER(DP) and Element.GETPROPNUMBER('NNDataPoint_Measure_REG')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 14;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 3;
				case 4 % Category.DATA
					prop_number = 3;
				case 5 % Category.RESULT
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in measure regression data point/error.
			%
			% CHECK = NNDataPoint_Measure_REG.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DP.EXISTSPROP(PROP) checks whether PROP exists for DP.
			%  CHECK = Element.EXISTSPROP(DP, PROP) checks whether PROP exists for DP.
			%  CHECK = Element.EXISTSPROP(NNDataPoint_Measure_REG, PROP) checks whether PROP exists for NNDataPoint_Measure_REG.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNDataPoint_Measure_REG:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DP.EXISTSPROP(PROP) throws error if PROP does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_Measure_REG:WrongInput]
			%  Element.EXISTSPROP(DP, PROP) throws error if PROP does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_Measure_REG:WrongInput]
			%  Element.EXISTSPROP(NNDataPoint_Measure_REG, PROP) throws error if PROP does NOT exist for NNDataPoint_Measure_REG.
			%   Error id: [BRAPH2:NNDataPoint_Measure_REG:WrongInput]
			%
			% Note that the Element.EXISTSPROP(DP) and Element.EXISTSPROP('NNDataPoint_Measure_REG')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 14 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDataPoint_Measure_REG:' 'WrongInput'], ...
					['BRAPH2' ':NNDataPoint_Measure_REG:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNDataPoint_Measure_REG.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in measure regression data point/error.
			%
			% CHECK = NNDataPoint_Measure_REG.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DP.EXISTSTAG(TAG) checks whether TAG exists for DP.
			%  CHECK = Element.EXISTSTAG(DP, TAG) checks whether TAG exists for DP.
			%  CHECK = Element.EXISTSTAG(NNDataPoint_Measure_REG, TAG) checks whether TAG exists for NNDataPoint_Measure_REG.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNDataPoint_Measure_REG:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DP.EXISTSTAG(TAG) throws error if TAG does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_Measure_REG:WrongInput]
			%  Element.EXISTSTAG(DP, TAG) throws error if TAG does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_Measure_REG:WrongInput]
			%  Element.EXISTSTAG(NNDataPoint_Measure_REG, TAG) throws error if TAG does NOT exist for NNDataPoint_Measure_REG.
			%   Error id: [BRAPH2:NNDataPoint_Measure_REG:WrongInput]
			%
			% Note that the Element.EXISTSTAG(DP) and Element.EXISTSTAG('NNDataPoint_Measure_REG')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'INPUT'  'TARGET'  'G'  'M_LIST'  'SUB'  'TARGET_IDS' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDataPoint_Measure_REG:' 'WrongInput'], ...
					['BRAPH2' ':NNDataPoint_Measure_REG:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNDataPoint_Measure_REG.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNDataPoint_Measure_REG, POINTER) returns property number of POINTER of NNDataPoint_Measure_REG.
			%  PROPERTY = DP.GETPROPPROP(NNDataPoint_Measure_REG, POINTER) returns property number of POINTER of NNDataPoint_Measure_REG.
			%
			% Note that the Element.GETPROPPROP(DP) and Element.GETPROPPROP('NNDataPoint_Measure_REG')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'INPUT'  'TARGET'  'G'  'M_LIST'  'SUB'  'TARGET_IDS' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(NNDataPoint_Measure_REG, POINTER) returns tag of POINTER of NNDataPoint_Measure_REG.
			%  TAG = DP.GETPROPTAG(NNDataPoint_Measure_REG, POINTER) returns tag of POINTER of NNDataPoint_Measure_REG.
			%
			% Note that the Element.GETPROPTAG(DP) and Element.GETPROPTAG('NNDataPoint_Measure_REG')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nndatapoint_measure_reg_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'INPUT'  'TARGET'  'G'  'M_LIST'  'SUB'  'TARGET_IDS' };
				tag = nndatapoint_measure_reg_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNDataPoint_Measure_REG, POINTER) returns category of POINTER of NNDataPoint_Measure_REG.
			%  CATEGORY = DP.GETPROPCATEGORY(NNDataPoint_Measure_REG, POINTER) returns category of POINTER of NNDataPoint_Measure_REG.
			%
			% Note that the Element.GETPROPCATEGORY(DP) and Element.GETPROPCATEGORY('NNDataPoint_Measure_REG')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNDataPoint_Measure_REG.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatapoint_measure_reg_category_list = { 1  1  1  3  4  2  2  6  5  5  4  3  4  3 };
			prop_category = nndatapoint_measure_reg_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(NNDataPoint_Measure_REG, POINTER) returns format of POINTER of NNDataPoint_Measure_REG.
			%  FORMAT = DP.GETPROPFORMAT(NNDataPoint_Measure_REG, POINTER) returns format of POINTER of NNDataPoint_Measure_REG.
			%
			% Note that the Element.GETPROPFORMAT(DP) and Element.GETPROPFORMAT('NNDataPoint_Measure_REG')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDataPoint_Measure_REG.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatapoint_measure_reg_format_list = { 2  2  2  8  2  2  2  2  16  16  8  7  8  3 };
			prop_format = nndatapoint_measure_reg_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNDataPoint_Measure_REG, POINTER) returns description of POINTER of NNDataPoint_Measure_REG.
			%  DESCRIPTION = DP.GETPROPDESCRIPTION(NNDataPoint_Measure_REG, POINTER) returns description of POINTER of NNDataPoint_Measure_REG.
			%
			% Note that the Element.GETPROPDESCRIPTION(DP) and Element.GETPROPDESCRIPTION('NNDataPoint_Measure_REG')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDataPoint_Measure_REG.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatapoint_measure_reg_description_list = { 'ELCLASS (constant, string) is the class of the data point for regression with graph measures.'  'NAME (constant, string) is the name of the data point for regression with graph measures.'  'DESCRIPTION (constant, string) is the description of the data point for regression with graph measures.'  'TEMPLATE (parameter, item) is the template of the data point for regression with graph measures.'  'ID (data, string) is a few-letter code for the data point for regression with graph measures.'  'LABEL (metadata, string) is an extended label of the data point for regression with graph measures.'  'NOTES (metadata, string) are some specific notes about the data point for regression with graph measures.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'INPUT (result, cell) is the input value for this data point.'  'TARGET (result, cell) is the target value for this data point.'  'G (data, item) is a graph containing the added graph measures (M_DICT).'  'M_LIST (parameter, classlist) is a list of graph measure to be used as the input'  'SUB (data, item) is a subject.'  'TARGET_IDS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.' };
			prop_description = nndatapoint_measure_reg_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNDataPoint_Measure_REG, POINTER) returns settings of POINTER of NNDataPoint_Measure_REG.
			%  SETTINGS = DP.GETPROPSETTINGS(NNDataPoint_Measure_REG, POINTER) returns settings of POINTER of NNDataPoint_Measure_REG.
			%
			% Note that the Element.GETPROPSETTINGS(DP) and Element.GETPROPSETTINGS('NNDataPoint_Measure_REG')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNDataPoint_Measure_REG.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 11 % NNDataPoint_Measure_REG.G
					prop_settings = 'Graph';
				case 12 % NNDataPoint_Measure_REG.M_LIST
					prop_settings = Format.getFormatSettings(7);
				case 13 % NNDataPoint_Measure_REG.SUB
					prop_settings = 'Subject';
				case 14 % NNDataPoint_Measure_REG.TARGET_IDS
					prop_settings = Format.getFormatSettings(3);
				case 4 % NNDataPoint_Measure_REG.TEMPLATE
					prop_settings = 'NNDataPoint_Measure_REG';
				otherwise
					prop_settings = getPropSettings@NNDataPoint(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNDataPoint_Measure_REG.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataPoint_Measure_REG.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of DP.
			%  DEFAULT = Element.GETPROPDEFAULT(NNDataPoint_Measure_REG, POINTER) returns the default value of POINTER of NNDataPoint_Measure_REG.
			%  DEFAULT = DP.GETPROPDEFAULT(NNDataPoint_Measure_REG, POINTER) returns the default value of POINTER of NNDataPoint_Measure_REG.
			%
			% Note that the Element.GETPROPDEFAULT(DP) and Element.GETPROPDEFAULT('NNDataPoint_Measure_REG')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDataPoint_Measure_REG.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 11 % NNDataPoint_Measure_REG.G
					prop_default = Format.getFormatDefault(8, NNDataPoint_Measure_REG.getPropSettings(prop));
				case 12 % NNDataPoint_Measure_REG.M_LIST
					prop_default = Format.getFormatDefault(7, NNDataPoint_Measure_REG.getPropSettings(prop));
				case 13 % NNDataPoint_Measure_REG.SUB
					prop_default = Format.getFormatDefault(8, NNDataPoint_Measure_REG.getPropSettings(prop));
				case 14 % NNDataPoint_Measure_REG.TARGET_IDS
					prop_default = Format.getFormatDefault(3, NNDataPoint_Measure_REG.getPropSettings(prop));
				case 1 % NNDataPoint_Measure_REG.ELCLASS
					prop_default = 'NNDataPoint_Measure_REG';
				case 2 % NNDataPoint_Measure_REG.NAME
					prop_default = 'Neural Network Data Point for Regression with Graph Measures';
				case 3 % NNDataPoint_Measure_REG.DESCRIPTION
					prop_default = 'A data point for regression with graph measures (NNDataPoint_Measure_REG) contains both input and target for neural network analysis. The input is the value of the graph measures (e.g. Degree, DegreeAv, and Distance), calculated from the derived graph of the subject. The target is obtained from the variables of interest of the subject.';
				case 4 % NNDataPoint_Measure_REG.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNDataPoint_Measure_REG.getPropSettings(prop));
				case 5 % NNDataPoint_Measure_REG.ID
					prop_default = 'NNDataPoint_Measure_REG ID';
				case 6 % NNDataPoint_Measure_REG.LABEL
					prop_default = 'NNDataPoint_Measure_REG label';
				case 7 % NNDataPoint_Measure_REG.NOTES
					prop_default = 'NNDataPoint_Measure_REG notes';
				otherwise
					prop_default = getPropDefault@NNDataPoint(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNDataPoint_Measure_REG.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataPoint_Measure_REG.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of DP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNDataPoint_Measure_REG, POINTER) returns the conditioned default value of POINTER of NNDataPoint_Measure_REG.
			%  DEFAULT = DP.GETPROPDEFAULTCONDITIONED(NNDataPoint_Measure_REG, POINTER) returns the conditioned default value of POINTER of NNDataPoint_Measure_REG.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(DP) and Element.GETPROPDEFAULTCONDITIONED('NNDataPoint_Measure_REG')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNDataPoint_Measure_REG.getPropProp(pointer);
			
			prop_default = NNDataPoint_Measure_REG.conditioning(prop, NNDataPoint_Measure_REG.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNDataPoint_Measure_REG, PROP, VALUE) checks VALUE format for PROP of NNDataPoint_Measure_REG.
			%  CHECK = DP.CHECKPROP(NNDataPoint_Measure_REG, PROP, VALUE) checks VALUE format for PROP of NNDataPoint_Measure_REG.
			% 
			% DP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNDataPoint_Measure_REG:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of DP.
			%   Error id: BRAPH2:NNDataPoint_Measure_REG:WrongInput
			%  Element.CHECKPROP(NNDataPoint_Measure_REG, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataPoint_Measure_REG.
			%   Error id: BRAPH2:NNDataPoint_Measure_REG:WrongInput
			%  DP.CHECKPROP(NNDataPoint_Measure_REG, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataPoint_Measure_REG.
			%   Error id: BRAPH2:NNDataPoint_Measure_REG:WrongInput]
			% 
			% Note that the Element.CHECKPROP(DP) and Element.CHECKPROP('NNDataPoint_Measure_REG')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNDataPoint_Measure_REG.getPropProp(pointer);
			
			switch prop
				case 11 % NNDataPoint_Measure_REG.G
					check = Format.checkFormat(8, value, NNDataPoint_Measure_REG.getPropSettings(prop));
				case 12 % NNDataPoint_Measure_REG.M_LIST
					check = Format.checkFormat(7, value, NNDataPoint_Measure_REG.getPropSettings(prop));
				case 13 % NNDataPoint_Measure_REG.SUB
					check = Format.checkFormat(8, value, NNDataPoint_Measure_REG.getPropSettings(prop));
				case 14 % NNDataPoint_Measure_REG.TARGET_IDS
					check = Format.checkFormat(3, value, NNDataPoint_Measure_REG.getPropSettings(prop));
				case 4 % NNDataPoint_Measure_REG.TEMPLATE
					check = Format.checkFormat(8, value, NNDataPoint_Measure_REG.getPropSettings(prop));
				otherwise
					if prop <= 10
						check = checkProp@NNDataPoint(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDataPoint_Measure_REG:' 'WrongInput'], ...
					['BRAPH2' ':NNDataPoint_Measure_REG:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNDataPoint_Measure_REG.getPropTag(prop) ' (' NNDataPoint_Measure_REG.getFormatTag(NNDataPoint_Measure_REG.getPropFormat(prop)) ').'] ...
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
				case 9 % NNDataPoint_Measure_REG.INPUT
					rng_settings_ = rng(); rng(dp.getPropSeed(9), 'twister')
					
					value = cellfun(@(m_class) dp.get('G').get('MEASURE', m_class).get('M'), dp.get('M_LIST'), 'UniformOutput', false);
					
					rng(rng_settings_)
					
				case 10 % NNDataPoint_Measure_REG.TARGET
					rng_settings_ = rng(); rng(dp.getPropSeed(10), 'twister')
					
					value = cellfun(@(x) dp.get('SUB').get('VOI_DICT').get('IT', x).get('V'), dp.get('TARGET_IDS'), 'UniformOutput', false);
					
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
