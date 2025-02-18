classdef NNDatasetSplit < ConcreteElement
	%NNDatasetSplit splits a dataset into several partitioned datasets based on specified indices or proportions.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A dataset splitter (NNDatasetSplit) allows users to split a given dataset into multiple smaller datasets, each forming a partition. 
	% The splitting can be achieved by providing either specific indices or proportions for the datapoints in each partitioned dataset.
	% For example usage, to split the dataset into two partitions, one containing datapoints 1 and 2, and the other containing datapoints 3, 4, and 5, the SPLIT property should be set as {[1 2], [3 4 5]}.
	% Alternatively, using the SPLIT property as {0.2, 0.8}, NNDatasetSplit will randomly assign datapoints to two datasets, with the first dataset containing approximately 20 percent of the total datapoints (datapoints 1 and 3, for instance), and the second dataset containing the remaining 80 percent of the datapoints (datapoints 2, 4, and 5).
	%
	% The list of NNDatasetSplit properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the splitter of a neural network dataset.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the splitter of a neural network dataset.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the splitter of a neural network dataset.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the splitter of a neural network dataset.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the splitter of a neural network dataset.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the splitter of a neural network dataset.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the splitter of a neural network dataset.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>D</strong> 	D (data, item) is a dataset for neural network analysis.
	%  <strong>10</strong> <strong>SPLIT</strong> 	SPLIT (data, cell) is a cell containing the ratio numbers or the vectors stating which datapoints belong to the splitted neural network datasets.
	%  <strong>11</strong> <strong>D_LIST</strong> 	D_LIST (result, itemlist) is the itemlist of splitted neural network datasets.
	%  <strong>12</strong> <strong>D_LIST_IT</strong> 	D_LIST_IT (query, item) returns a dataset at a specified index in the itemlist of splitted neural network datasets.
	%
	% NNDatasetSplit methods (constructor):
	%  NNDatasetSplit - constructor
	%
	% NNDatasetSplit methods:
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
	% NNDatasetSplit methods (display):
	%  tostring - string with information about the splitter of a neural network dataset
	%  disp - displays information about the splitter of a neural network dataset
	%  tree - displays the tree of the splitter of a neural network dataset
	%
	% NNDatasetSplit methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two splitter of a neural network dataset are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the splitter of a neural network dataset
	%
	% NNDatasetSplit methods (save/load, Static):
	%  save - saves BRAPH2 splitter of a neural network dataset as b2 file
	%  load - loads a BRAPH2 splitter of a neural network dataset from a b2 file
	%
	% NNDatasetSplit method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the splitter of a neural network dataset
	%
	% NNDatasetSplit method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the splitter of a neural network dataset
	%
	% NNDatasetSplit methods (inspection, Static):
	%  getClass - returns the class of the splitter of a neural network dataset
	%  getSubclasses - returns all subclasses of NNDatasetSplit
	%  getProps - returns the property list of the splitter of a neural network dataset
	%  getPropNumber - returns the property number of the splitter of a neural network dataset
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
	% NNDatasetSplit methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNDatasetSplit methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNDatasetSplit methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNDatasetSplit methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNDatasetSplit; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNDatasetSplit constants</a>.
	%
	%
	% See also NNDataset, NNDatasetCombine.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		D = 9; %CET: Computational Efficiency Trick
		D_TAG = 'D';
		D_CATEGORY = 4;
		D_FORMAT = 8;
		
		SPLIT = 10; %CET: Computational Efficiency Trick
		SPLIT_TAG = 'SPLIT';
		SPLIT_CATEGORY = 4;
		SPLIT_FORMAT = 16;
		
		D_LIST = 11; %CET: Computational Efficiency Trick
		D_LIST_TAG = 'D_LIST';
		D_LIST_CATEGORY = 5;
		D_LIST_FORMAT = 9;
		
		D_LIST_IT = 12; %CET: Computational Efficiency Trick
		D_LIST_IT_TAG = 'D_LIST_IT';
		D_LIST_IT_CATEGORY = 6;
		D_LIST_IT_FORMAT = 8;
	end
	methods % constructor
		function dsp = NNDatasetSplit(varargin)
			%NNDatasetSplit() creates a splitter of a neural network dataset.
			%
			% NNDatasetSplit(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNDatasetSplit(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNDatasetSplit properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the splitter of a neural network dataset.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the splitter of a neural network dataset.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the splitter of a neural network dataset.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the splitter of a neural network dataset.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the splitter of a neural network dataset.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the splitter of a neural network dataset.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the splitter of a neural network dataset.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>D</strong> 	D (data, item) is a dataset for neural network analysis.
			%  <strong>10</strong> <strong>SPLIT</strong> 	SPLIT (data, cell) is a cell containing the ratio numbers or the vectors stating which datapoints belong to the splitted neural network datasets.
			%  <strong>11</strong> <strong>D_LIST</strong> 	D_LIST (result, itemlist) is the itemlist of splitted neural network datasets.
			%  <strong>12</strong> <strong>D_LIST_IT</strong> 	D_LIST_IT (query, item) returns a dataset at a specified index in the itemlist of splitted neural network datasets.
			%
			% See also Category, Format.
			
			dsp = dsp@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the splitter of a neural network dataset.
			%
			% BUILD = NNDatasetSplit.GETBUILD() returns the build of 'NNDatasetSplit'.
			%
			% Alternative forms to call this method are:
			%  BUILD = DSP.GETBUILD() returns the build of the splitter of a neural network dataset DSP.
			%  BUILD = Element.GETBUILD(DSP) returns the build of 'DSP'.
			%  BUILD = Element.GETBUILD('NNDatasetSplit') returns the build of 'NNDatasetSplit'.
			%
			% Note that the Element.GETBUILD(DSP) and Element.GETBUILD('NNDatasetSplit')
			%  are less computationally efficient.
			
			build = 1;
		end
		function dsp_class = getClass()
			%GETCLASS returns the class of the splitter of a neural network dataset.
			%
			% CLASS = NNDatasetSplit.GETCLASS() returns the class 'NNDatasetSplit'.
			%
			% Alternative forms to call this method are:
			%  CLASS = DSP.GETCLASS() returns the class of the splitter of a neural network dataset DSP.
			%  CLASS = Element.GETCLASS(DSP) returns the class of 'DSP'.
			%  CLASS = Element.GETCLASS('NNDatasetSplit') returns 'NNDatasetSplit'.
			%
			% Note that the Element.GETCLASS(DSP) and Element.GETCLASS('NNDatasetSplit')
			%  are less computationally efficient.
			
			dsp_class = 'NNDatasetSplit';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the splitter of a neural network dataset.
			%
			% LIST = NNDatasetSplit.GETSUBCLASSES() returns all subclasses of 'NNDatasetSplit'.
			%
			% Alternative forms to call this method are:
			%  LIST = DSP.GETSUBCLASSES() returns all subclasses of the splitter of a neural network dataset DSP.
			%  LIST = Element.GETSUBCLASSES(DSP) returns all subclasses of 'DSP'.
			%  LIST = Element.GETSUBCLASSES('NNDatasetSplit') returns all subclasses of 'NNDatasetSplit'.
			%
			% Note that the Element.GETSUBCLASSES(DSP) and Element.GETSUBCLASSES('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNDatasetSplit' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of splitter of a neural network dataset.
			%
			% PROPS = NNDatasetSplit.GETPROPS() returns the property list of splitter of a neural network dataset
			%  as a row vector.
			%
			% PROPS = NNDatasetSplit.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = DSP.GETPROPS([CATEGORY]) returns the property list of the splitter of a neural network dataset DSP.
			%  PROPS = Element.GETPROPS(DSP[, CATEGORY]) returns the property list of 'DSP'.
			%  PROPS = Element.GETPROPS('NNDatasetSplit'[, CATEGORY]) returns the property list of 'NNDatasetSplit'.
			%
			% Note that the Element.GETPROPS(DSP) and Element.GETPROPS('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12];
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
					prop_list = [5 9 10];
				case 5 % Category.RESULT
					prop_list = 11;
				case 6 % Category.QUERY
					prop_list = [8 12];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of splitter of a neural network dataset.
			%
			% N = NNDatasetSplit.GETPROPNUMBER() returns the property number of splitter of a neural network dataset.
			%
			% N = NNDatasetSplit.GETPROPNUMBER(CATEGORY) returns the property number of splitter of a neural network dataset
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = DSP.GETPROPNUMBER([CATEGORY]) returns the property number of the splitter of a neural network dataset DSP.
			%  N = Element.GETPROPNUMBER(DSP) returns the property number of 'DSP'.
			%  N = Element.GETPROPNUMBER('NNDatasetSplit') returns the property number of 'NNDatasetSplit'.
			%
			% Note that the Element.GETPROPNUMBER(DSP) and Element.GETPROPNUMBER('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 12;
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
					prop_number = 3;
				case 5 % Category.RESULT
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in splitter of a neural network dataset/error.
			%
			% CHECK = NNDatasetSplit.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DSP.EXISTSPROP(PROP) checks whether PROP exists for DSP.
			%  CHECK = Element.EXISTSPROP(DSP, PROP) checks whether PROP exists for DSP.
			%  CHECK = Element.EXISTSPROP(NNDatasetSplit, PROP) checks whether PROP exists for NNDatasetSplit.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNDatasetSplit:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DSP.EXISTSPROP(PROP) throws error if PROP does NOT exist for DSP.
			%   Error id: [BRAPH2:NNDatasetSplit:WrongInput]
			%  Element.EXISTSPROP(DSP, PROP) throws error if PROP does NOT exist for DSP.
			%   Error id: [BRAPH2:NNDatasetSplit:WrongInput]
			%  Element.EXISTSPROP(NNDatasetSplit, PROP) throws error if PROP does NOT exist for NNDatasetSplit.
			%   Error id: [BRAPH2:NNDatasetSplit:WrongInput]
			%
			% Note that the Element.EXISTSPROP(DSP) and Element.EXISTSPROP('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 12 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDatasetSplit:' 'WrongInput'], ...
					['BRAPH2' ':NNDatasetSplit:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNDatasetSplit.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in splitter of a neural network dataset/error.
			%
			% CHECK = NNDatasetSplit.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DSP.EXISTSTAG(TAG) checks whether TAG exists for DSP.
			%  CHECK = Element.EXISTSTAG(DSP, TAG) checks whether TAG exists for DSP.
			%  CHECK = Element.EXISTSTAG(NNDatasetSplit, TAG) checks whether TAG exists for NNDatasetSplit.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNDatasetSplit:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DSP.EXISTSTAG(TAG) throws error if TAG does NOT exist for DSP.
			%   Error id: [BRAPH2:NNDatasetSplit:WrongInput]
			%  Element.EXISTSTAG(DSP, TAG) throws error if TAG does NOT exist for DSP.
			%   Error id: [BRAPH2:NNDatasetSplit:WrongInput]
			%  Element.EXISTSTAG(NNDatasetSplit, TAG) throws error if TAG does NOT exist for NNDatasetSplit.
			%   Error id: [BRAPH2:NNDatasetSplit:WrongInput]
			%
			% Note that the Element.EXISTSTAG(DSP) and Element.EXISTSTAG('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'SPLIT'  'D_LIST'  'D_LIST_IT' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDatasetSplit:' 'WrongInput'], ...
					['BRAPH2' ':NNDatasetSplit:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNDatasetSplit.'] ...
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
			%  PROPERTY = DSP.GETPROPPROP(POINTER) returns property number of POINTER of DSP.
			%  PROPERTY = Element.GETPROPPROP(NNDatasetSplit, POINTER) returns property number of POINTER of NNDatasetSplit.
			%  PROPERTY = DSP.GETPROPPROP(NNDatasetSplit, POINTER) returns property number of POINTER of NNDatasetSplit.
			%
			% Note that the Element.GETPROPPROP(DSP) and Element.GETPROPPROP('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'SPLIT'  'D_LIST'  'D_LIST_IT' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = DSP.GETPROPTAG(POINTER) returns tag of POINTER of DSP.
			%  TAG = Element.GETPROPTAG(NNDatasetSplit, POINTER) returns tag of POINTER of NNDatasetSplit.
			%  TAG = DSP.GETPROPTAG(NNDatasetSplit, POINTER) returns tag of POINTER of NNDatasetSplit.
			%
			% Note that the Element.GETPROPTAG(DSP) and Element.GETPROPTAG('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nndatasetsplit_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'SPLIT'  'D_LIST'  'D_LIST_IT' };
				tag = nndatasetsplit_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = DSP.GETPROPCATEGORY(POINTER) returns category of POINTER of DSP.
			%  CATEGORY = Element.GETPROPCATEGORY(NNDatasetSplit, POINTER) returns category of POINTER of NNDatasetSplit.
			%  CATEGORY = DSP.GETPROPCATEGORY(NNDatasetSplit, POINTER) returns category of POINTER of NNDatasetSplit.
			%
			% Note that the Element.GETPROPCATEGORY(DSP) and Element.GETPROPCATEGORY('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNDatasetSplit.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatasetsplit_category_list = { 1  1  1  3  4  2  2  6  4  4  5  6 };
			prop_category = nndatasetsplit_category_list{prop};
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
			%  FORMAT = DSP.GETPROPFORMAT(POINTER) returns format of POINTER of DSP.
			%  FORMAT = Element.GETPROPFORMAT(NNDatasetSplit, POINTER) returns format of POINTER of NNDatasetSplit.
			%  FORMAT = DSP.GETPROPFORMAT(NNDatasetSplit, POINTER) returns format of POINTER of NNDatasetSplit.
			%
			% Note that the Element.GETPROPFORMAT(DSP) and Element.GETPROPFORMAT('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDatasetSplit.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatasetsplit_format_list = { 2  2  2  8  2  2  2  2  8  16  9  8 };
			prop_format = nndatasetsplit_format_list{prop};
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
			%  DESCRIPTION = DSP.GETPROPDESCRIPTION(POINTER) returns description of POINTER of DSP.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNDatasetSplit, POINTER) returns description of POINTER of NNDatasetSplit.
			%  DESCRIPTION = DSP.GETPROPDESCRIPTION(NNDatasetSplit, POINTER) returns description of POINTER of NNDatasetSplit.
			%
			% Note that the Element.GETPROPDESCRIPTION(DSP) and Element.GETPROPDESCRIPTION('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDatasetSplit.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatasetsplit_description_list = { 'ELCLASS (constant, string) is the class of the splitter of a neural network dataset.'  'NAME (constant, string) is the name of the splitter of a neural network dataset.'  'DESCRIPTION (constant, string) is the description of the splitter of a neural network dataset.'  'TEMPLATE (parameter, item) is the template of the splitter of a neural network dataset.'  'ID (data, string) is a few-letter code for the splitter of a neural network dataset.'  'LABEL (metadata, string) is an extended label of the splitter of a neural network dataset.'  'NOTES (metadata, string) are some specific notes about the splitter of a neural network dataset.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'D (data, item) is a dataset for neural network analysis.'  'SPLIT (data, cell) is a cell containing the ratio numbers or the vectors stating which datapoints belong to the splitted neural network datasets.'  'D_LIST (result, itemlist) is the itemlist of splitted neural network datasets.'  'D_LIST_IT (query, item) returns a dataset at a specified index in the itemlist of splitted neural network datasets.' };
			prop_description = nndatasetsplit_description_list{prop};
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
			%  SETTINGS = DSP.GETPROPSETTINGS(POINTER) returns settings of POINTER of DSP.
			%  SETTINGS = Element.GETPROPSETTINGS(NNDatasetSplit, POINTER) returns settings of POINTER of NNDatasetSplit.
			%  SETTINGS = DSP.GETPROPSETTINGS(NNDatasetSplit, POINTER) returns settings of POINTER of NNDatasetSplit.
			%
			% Note that the Element.GETPROPSETTINGS(DSP) and Element.GETPROPSETTINGS('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNDatasetSplit.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNDatasetSplit.D
					prop_settings = 'NNDataset';
				case 10 % NNDatasetSplit.SPLIT
					prop_settings = Format.getFormatSettings(16);
				case 11 % NNDatasetSplit.D_LIST
					prop_settings = Format.getFormatSettings(9);
				case 12 % NNDatasetSplit.D_LIST_IT
					prop_settings = Format.getFormatSettings(8);
				case 4 % NNDatasetSplit.TEMPLATE
					prop_settings = 'NNDatasetSplit';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNDatasetSplit.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDatasetSplit.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DSP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of DSP.
			%  DEFAULT = Element.GETPROPDEFAULT(NNDatasetSplit, POINTER) returns the default value of POINTER of NNDatasetSplit.
			%  DEFAULT = DSP.GETPROPDEFAULT(NNDatasetSplit, POINTER) returns the default value of POINTER of NNDatasetSplit.
			%
			% Note that the Element.GETPROPDEFAULT(DSP) and Element.GETPROPDEFAULT('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDatasetSplit.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNDatasetSplit.D
					prop_default = NNDataset('DP_CLASS', 'NNDataPoint', 'DP_DICT', IndexedDictionary('IT_CLASS', 'NNDataPoint'));
				case 10 % NNDatasetSplit.SPLIT
					prop_default = Format.getFormatDefault(16, NNDatasetSplit.getPropSettings(prop));
				case 11 % NNDatasetSplit.D_LIST
					prop_default = Format.getFormatDefault(9, NNDatasetSplit.getPropSettings(prop));
				case 12 % NNDatasetSplit.D_LIST_IT
					prop_default = Format.getFormatDefault(8, NNDatasetSplit.getPropSettings(prop));
				case 1 % NNDatasetSplit.ELCLASS
					prop_default = 'NNDatasetSplit';
				case 2 % NNDatasetSplit.NAME
					prop_default = 'Neural Network Dataset Splitter';
				case 3 % NNDatasetSplit.DESCRIPTION
					prop_default = 'A dataset splitter (NNDatasetSplit) allows users to split a given dataset into multiple smaller datasets, each forming a partition. The splitting can be achieved by providing either specific indices or proportions for the datapoints in each partitioned dataset. For example usage, to split the dataset into two partitions, one containing datapoints 1 and 2, and the other containing datapoints 3, 4, and 5, the SPLIT property should be set as {[1 2], [3 4 5]}. Alternatively, using the SPLIT property as {0.2, 0.8}, NNDatasetSplit will randomly assign datapoints to two datasets, with the first dataset containing approximately 20 percent of the total datapoints (datapoints 1 and 3, for instance), and the second dataset containing the remaining 80 percent of the datapoints (datapoints 2, 4, and 5).';
				case 4 % NNDatasetSplit.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNDatasetSplit.getPropSettings(prop));
				case 5 % NNDatasetSplit.ID
					prop_default = 'NNDatasetSplit ID';
				case 6 % NNDatasetSplit.LABEL
					prop_default = 'NNDatasetSplit label';
				case 7 % NNDatasetSplit.NOTES
					prop_default = 'NNDatasetSplit notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNDatasetSplit.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDatasetSplit.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DSP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of DSP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNDatasetSplit, POINTER) returns the conditioned default value of POINTER of NNDatasetSplit.
			%  DEFAULT = DSP.GETPROPDEFAULTCONDITIONED(NNDatasetSplit, POINTER) returns the conditioned default value of POINTER of NNDatasetSplit.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(DSP) and Element.GETPROPDEFAULTCONDITIONED('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNDatasetSplit.getPropProp(pointer);
			
			prop_default = NNDatasetSplit.conditioning(prop, NNDatasetSplit.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = DSP.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = DSP.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of DSP.
			%  CHECK = Element.CHECKPROP(NNDatasetSplit, PROP, VALUE) checks VALUE format for PROP of NNDatasetSplit.
			%  CHECK = DSP.CHECKPROP(NNDatasetSplit, PROP, VALUE) checks VALUE format for PROP of NNDatasetSplit.
			% 
			% DSP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNDatasetSplit:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DSP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of DSP.
			%   Error id: BRAPH2:NNDatasetSplit:WrongInput
			%  Element.CHECKPROP(NNDatasetSplit, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDatasetSplit.
			%   Error id: BRAPH2:NNDatasetSplit:WrongInput
			%  DSP.CHECKPROP(NNDatasetSplit, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDatasetSplit.
			%   Error id: BRAPH2:NNDatasetSplit:WrongInput]
			% 
			% Note that the Element.CHECKPROP(DSP) and Element.CHECKPROP('NNDatasetSplit')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNDatasetSplit.getPropProp(pointer);
			
			switch prop
				case 9 % NNDatasetSplit.D
					check = Format.checkFormat(8, value, NNDatasetSplit.getPropSettings(prop));
				case 10 % NNDatasetSplit.SPLIT
					check = Format.checkFormat(16, value, NNDatasetSplit.getPropSettings(prop));
				case 11 % NNDatasetSplit.D_LIST
					check = Format.checkFormat(9, value, NNDatasetSplit.getPropSettings(prop));
				case 12 % NNDatasetSplit.D_LIST_IT
					check = Format.checkFormat(8, value, NNDatasetSplit.getPropSettings(prop));
				case 4 % NNDatasetSplit.TEMPLATE
					check = Format.checkFormat(8, value, NNDatasetSplit.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDatasetSplit:' 'WrongInput'], ...
					['BRAPH2' ':NNDatasetSplit:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNDatasetSplit.getPropTag(prop) ' (' NNDatasetSplit.getFormatTag(NNDatasetSplit.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(dsp, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case 10 % NNDatasetSplit.SPLIT
					value = dsp.get('SPLIT');
					if all(cellfun(@isscalar, value)) & sum(cell2mat(value)) <= 1 & sum(cell2mat(value)) > 0 
					    num_sub = dsp.get('D').get('DP_DICT').get('LENGTH');
					    
					    lengths = floor(cell2mat(value) * num_sub);
					    for i = 1:1:num_sub - sum(lengths)
					        lengths(i) = lengths(i) + 1;
					    end
					    
					    indices = randperm(num_sub);
					    
					    startIndex = 1;
					    value = cell(numel(lengths), 1);
					    for i = 1:numel(lengths)
					        endIndex = startIndex + lengths(i) - 1;
					        value{i} = sort(indices(startIndex:endIndex));
					        startIndex = endIndex + 1;
					    end
					    
					    dsp.set('SPLIT', value);
					end
					
				otherwise
					if prop <= 8
						postset@ConcreteElement(dsp, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(dsp, prop, varargin)
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
				case 11 % NNDatasetSplit.D_LIST
					rng_settings_ = rng(); rng(dsp.getPropSeed(11), 'twister')
					
					d = dsp.get('D');
					dp_list = d.get('DP_DICT').get('IT_LIST');
					split = dsp.get('SPLIT');
					value = cellfun(@(x) NNDataset( ...
					    'DP_CLASS', d.get('DP_CLASS'), ...
					    'DP_DICT', IndexedDictionary(...
					    'IT_CLASS', 'NNDataPoint', ...
					    'IT_LIST',  dp_list(x) ...
					    )), split, 'UniformOutput', false);
					
					rng(rng_settings_)
					
				case 12 % NNDatasetSplit.D_LIST_IT
					% d = dsp.get('D_LIST_IT', index) returns the NNDataset at the specified 
					%  index from the D_LIST property.
					if isempty(varargin)
					    value = NNDataset();
					    return
					end
					index = varargin{1};
					
					d_list = dsp.get('D_LIST');
					
					value = d_list{index};
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(dsp, prop, varargin{:});
					else
						value = calculateValue@Element(dsp, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(dsp, prop, value)
			%CHECKVALUE checks the value of a property after it is set/calculated.
			%
			% [CHECK, MSG] = CHECKVALUE(EL, PROP, VALUE) checks the value
			%  of the property PROP after it is set/calculated. This function by
			%  default returns a CHECK = true and MSG = '. It should be implemented in
			%  the subclasses of Element when needed.
			%
			% See also conditioning, preset, checkProp, postset, postprocessing,
			%  calculateValue.
			
			check = true;
			msg = ['Error while checking ' tostring(dsp) ' ' dsp.getPropTag(prop) '.'];
			
			switch prop
				case 10 % NNDatasetSplit.SPLIT
					check = all(cellfun(@(x) all(round(x) == x & all(x <= dsp.get('D').get('DP_DICT').get('LENGTH'))), dsp.get('SPLIT')));
					
				otherwise
					if prop <= 8
						[check, msg] = checkValue@ConcreteElement(dsp, prop, value);
					end
			end
		end
	end
end
