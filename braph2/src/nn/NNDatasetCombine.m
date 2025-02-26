classdef NNDatasetCombine < ConcreteElement
	%NNDatasetCombine combines neural network datasets.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A dataset combiner (NNDatasetCombine) takes a list of neural network datasets and combines them into a single dataset. 
	% The resulting combined dataset contains all the unique datapoints from the input datasets, 
	% and any overlapping datapoints are excluded to ensure data consistency.
	%
	% The list of NNDatasetCombine properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the combiner of neural networks datasets.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the combiner of neural networks datasets.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the combiner of neural networks datasets.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the combiner of neural networks datasets.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the combiner of neural networks datasets.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the combiner of neural networks datasets.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes of the combiner of neural networks datasets.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>D_LIST</strong> 	D_LIST (data, itemlist) is a items of datasets to be combined.
	%  <strong>10</strong> <strong>D</strong> 	D (result, item) is the combined neural network dataset.
	%
	% NNDatasetCombine methods (constructor):
	%  NNDatasetCombine - constructor
	%
	% NNDatasetCombine methods:
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
	% NNDatasetCombine methods (display):
	%  tostring - string with information about the combiner of a neural network data
	%  disp - displays information about the combiner of a neural network data
	%  tree - displays the tree of the combiner of a neural network data
	%
	% NNDatasetCombine methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two combiner of a neural network data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the combiner of a neural network data
	%
	% NNDatasetCombine methods (save/load, Static):
	%  save - saves BRAPH2 combiner of a neural network data as b2 file
	%  load - loads a BRAPH2 combiner of a neural network data from a b2 file
	%
	% NNDatasetCombine method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the combiner of a neural network data
	%
	% NNDatasetCombine method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the combiner of a neural network data
	%
	% NNDatasetCombine methods (inspection, Static):
	%  getClass - returns the class of the combiner of a neural network data
	%  getSubclasses - returns all subclasses of NNDatasetCombine
	%  getProps - returns the property list of the combiner of a neural network data
	%  getPropNumber - returns the property number of the combiner of a neural network data
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
	% NNDatasetCombine methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNDatasetCombine methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNDatasetCombine methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNDatasetCombine methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNDatasetCombine; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNDatasetCombine constants</a>.
	%
	%
	% See also NNDataset, NNDatasetSplit.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		D_LIST = 9; %CET: Computational Efficiency Trick
		D_LIST_TAG = 'D_LIST';
		D_LIST_CATEGORY = 4;
		D_LIST_FORMAT = 9;
		
		D = 10; %CET: Computational Efficiency Trick
		D_TAG = 'D';
		D_CATEGORY = 5;
		D_FORMAT = 8;
	end
	methods % constructor
		function dco = NNDatasetCombine(varargin)
			%NNDatasetCombine() creates a combiner of a neural network data.
			%
			% NNDatasetCombine(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNDatasetCombine(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNDatasetCombine properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the combiner of neural networks datasets.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the combiner of neural networks datasets.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the combiner of neural networks datasets.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the combiner of neural networks datasets.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the combiner of neural networks datasets.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the combiner of neural networks datasets.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes of the combiner of neural networks datasets.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>D_LIST</strong> 	D_LIST (data, itemlist) is a items of datasets to be combined.
			%  <strong>10</strong> <strong>D</strong> 	D (result, item) is the combined neural network dataset.
			%
			% See also Category, Format.
			
			dco = dco@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the combiner of a neural network data.
			%
			% BUILD = NNDatasetCombine.GETBUILD() returns the build of 'NNDatasetCombine'.
			%
			% Alternative forms to call this method are:
			%  BUILD = DCO.GETBUILD() returns the build of the combiner of a neural network data DCO.
			%  BUILD = Element.GETBUILD(DCO) returns the build of 'DCO'.
			%  BUILD = Element.GETBUILD('NNDatasetCombine') returns the build of 'NNDatasetCombine'.
			%
			% Note that the Element.GETBUILD(DCO) and Element.GETBUILD('NNDatasetCombine')
			%  are less computationally efficient.
			
			build = 1;
		end
		function dco_class = getClass()
			%GETCLASS returns the class of the combiner of a neural network data.
			%
			% CLASS = NNDatasetCombine.GETCLASS() returns the class 'NNDatasetCombine'.
			%
			% Alternative forms to call this method are:
			%  CLASS = DCO.GETCLASS() returns the class of the combiner of a neural network data DCO.
			%  CLASS = Element.GETCLASS(DCO) returns the class of 'DCO'.
			%  CLASS = Element.GETCLASS('NNDatasetCombine') returns 'NNDatasetCombine'.
			%
			% Note that the Element.GETCLASS(DCO) and Element.GETCLASS('NNDatasetCombine')
			%  are less computationally efficient.
			
			dco_class = 'NNDatasetCombine';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the combiner of a neural network data.
			%
			% LIST = NNDatasetCombine.GETSUBCLASSES() returns all subclasses of 'NNDatasetCombine'.
			%
			% Alternative forms to call this method are:
			%  LIST = DCO.GETSUBCLASSES() returns all subclasses of the combiner of a neural network data DCO.
			%  LIST = Element.GETSUBCLASSES(DCO) returns all subclasses of 'DCO'.
			%  LIST = Element.GETSUBCLASSES('NNDatasetCombine') returns all subclasses of 'NNDatasetCombine'.
			%
			% Note that the Element.GETSUBCLASSES(DCO) and Element.GETSUBCLASSES('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNDatasetCombine' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of combiner of a neural network data.
			%
			% PROPS = NNDatasetCombine.GETPROPS() returns the property list of combiner of a neural network data
			%  as a row vector.
			%
			% PROPS = NNDatasetCombine.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = DCO.GETPROPS([CATEGORY]) returns the property list of the combiner of a neural network data DCO.
			%  PROPS = Element.GETPROPS(DCO[, CATEGORY]) returns the property list of 'DCO'.
			%  PROPS = Element.GETPROPS('NNDatasetCombine'[, CATEGORY]) returns the property list of 'NNDatasetCombine'.
			%
			% Note that the Element.GETPROPS(DCO) and Element.GETPROPS('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10];
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
					prop_list = [5 9];
				case 5 % Category.RESULT
					prop_list = 10;
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of combiner of a neural network data.
			%
			% N = NNDatasetCombine.GETPROPNUMBER() returns the property number of combiner of a neural network data.
			%
			% N = NNDatasetCombine.GETPROPNUMBER(CATEGORY) returns the property number of combiner of a neural network data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = DCO.GETPROPNUMBER([CATEGORY]) returns the property number of the combiner of a neural network data DCO.
			%  N = Element.GETPROPNUMBER(DCO) returns the property number of 'DCO'.
			%  N = Element.GETPROPNUMBER('NNDatasetCombine') returns the property number of 'NNDatasetCombine'.
			%
			% Note that the Element.GETPROPNUMBER(DCO) and Element.GETPROPNUMBER('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 10;
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
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in combiner of a neural network data/error.
			%
			% CHECK = NNDatasetCombine.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DCO.EXISTSPROP(PROP) checks whether PROP exists for DCO.
			%  CHECK = Element.EXISTSPROP(DCO, PROP) checks whether PROP exists for DCO.
			%  CHECK = Element.EXISTSPROP(NNDatasetCombine, PROP) checks whether PROP exists for NNDatasetCombine.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNDatasetCombine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DCO.EXISTSPROP(PROP) throws error if PROP does NOT exist for DCO.
			%   Error id: [BRAPH2:NNDatasetCombine:WrongInput]
			%  Element.EXISTSPROP(DCO, PROP) throws error if PROP does NOT exist for DCO.
			%   Error id: [BRAPH2:NNDatasetCombine:WrongInput]
			%  Element.EXISTSPROP(NNDatasetCombine, PROP) throws error if PROP does NOT exist for NNDatasetCombine.
			%   Error id: [BRAPH2:NNDatasetCombine:WrongInput]
			%
			% Note that the Element.EXISTSPROP(DCO) and Element.EXISTSPROP('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 10 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDatasetCombine:' 'WrongInput'], ...
					['BRAPH2' ':NNDatasetCombine:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNDatasetCombine.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in combiner of a neural network data/error.
			%
			% CHECK = NNDatasetCombine.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DCO.EXISTSTAG(TAG) checks whether TAG exists for DCO.
			%  CHECK = Element.EXISTSTAG(DCO, TAG) checks whether TAG exists for DCO.
			%  CHECK = Element.EXISTSTAG(NNDatasetCombine, TAG) checks whether TAG exists for NNDatasetCombine.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNDatasetCombine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DCO.EXISTSTAG(TAG) throws error if TAG does NOT exist for DCO.
			%   Error id: [BRAPH2:NNDatasetCombine:WrongInput]
			%  Element.EXISTSTAG(DCO, TAG) throws error if TAG does NOT exist for DCO.
			%   Error id: [BRAPH2:NNDatasetCombine:WrongInput]
			%  Element.EXISTSTAG(NNDatasetCombine, TAG) throws error if TAG does NOT exist for NNDatasetCombine.
			%   Error id: [BRAPH2:NNDatasetCombine:WrongInput]
			%
			% Note that the Element.EXISTSTAG(DCO) and Element.EXISTSTAG('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D_LIST'  'D' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDatasetCombine:' 'WrongInput'], ...
					['BRAPH2' ':NNDatasetCombine:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNDatasetCombine.'] ...
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
			%  PROPERTY = DCO.GETPROPPROP(POINTER) returns property number of POINTER of DCO.
			%  PROPERTY = Element.GETPROPPROP(NNDatasetCombine, POINTER) returns property number of POINTER of NNDatasetCombine.
			%  PROPERTY = DCO.GETPROPPROP(NNDatasetCombine, POINTER) returns property number of POINTER of NNDatasetCombine.
			%
			% Note that the Element.GETPROPPROP(DCO) and Element.GETPROPPROP('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D_LIST'  'D' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = DCO.GETPROPTAG(POINTER) returns tag of POINTER of DCO.
			%  TAG = Element.GETPROPTAG(NNDatasetCombine, POINTER) returns tag of POINTER of NNDatasetCombine.
			%  TAG = DCO.GETPROPTAG(NNDatasetCombine, POINTER) returns tag of POINTER of NNDatasetCombine.
			%
			% Note that the Element.GETPROPTAG(DCO) and Element.GETPROPTAG('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nndatasetcombine_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D_LIST'  'D' };
				tag = nndatasetcombine_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = DCO.GETPROPCATEGORY(POINTER) returns category of POINTER of DCO.
			%  CATEGORY = Element.GETPROPCATEGORY(NNDatasetCombine, POINTER) returns category of POINTER of NNDatasetCombine.
			%  CATEGORY = DCO.GETPROPCATEGORY(NNDatasetCombine, POINTER) returns category of POINTER of NNDatasetCombine.
			%
			% Note that the Element.GETPROPCATEGORY(DCO) and Element.GETPROPCATEGORY('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNDatasetCombine.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatasetcombine_category_list = { 1  1  1  3  4  2  2  6  4  5 };
			prop_category = nndatasetcombine_category_list{prop};
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
			%  FORMAT = DCO.GETPROPFORMAT(POINTER) returns format of POINTER of DCO.
			%  FORMAT = Element.GETPROPFORMAT(NNDatasetCombine, POINTER) returns format of POINTER of NNDatasetCombine.
			%  FORMAT = DCO.GETPROPFORMAT(NNDatasetCombine, POINTER) returns format of POINTER of NNDatasetCombine.
			%
			% Note that the Element.GETPROPFORMAT(DCO) and Element.GETPROPFORMAT('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDatasetCombine.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatasetcombine_format_list = { 2  2  2  8  2  2  2  2  9  8 };
			prop_format = nndatasetcombine_format_list{prop};
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
			%  DESCRIPTION = DCO.GETPROPDESCRIPTION(POINTER) returns description of POINTER of DCO.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNDatasetCombine, POINTER) returns description of POINTER of NNDatasetCombine.
			%  DESCRIPTION = DCO.GETPROPDESCRIPTION(NNDatasetCombine, POINTER) returns description of POINTER of NNDatasetCombine.
			%
			% Note that the Element.GETPROPDESCRIPTION(DCO) and Element.GETPROPDESCRIPTION('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDatasetCombine.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatasetcombine_description_list = { 'ELCLASS (constant, string) is the class of the combiner of neural networks datasets.'  'NAME (constant, string) is the name of the combiner of neural networks datasets.'  'DESCRIPTION (constant, string) is the description of the combiner of neural networks datasets.'  'TEMPLATE (parameter, item) is the template of the combiner of neural networks datasets.'  'ID (data, string) is a few-letter code of the combiner of neural networks datasets.'  'LABEL (metadata, string) is an extended label of the combiner of neural networks datasets.'  'NOTES (metadata, string) are some specific notes of the combiner of neural networks datasets.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'D_LIST (data, itemlist) is a items of datasets to be combined.'  'D (result, item) is the combined neural network dataset.' };
			prop_description = nndatasetcombine_description_list{prop};
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
			%  SETTINGS = DCO.GETPROPSETTINGS(POINTER) returns settings of POINTER of DCO.
			%  SETTINGS = Element.GETPROPSETTINGS(NNDatasetCombine, POINTER) returns settings of POINTER of NNDatasetCombine.
			%  SETTINGS = DCO.GETPROPSETTINGS(NNDatasetCombine, POINTER) returns settings of POINTER of NNDatasetCombine.
			%
			% Note that the Element.GETPROPSETTINGS(DCO) and Element.GETPROPSETTINGS('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNDatasetCombine.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNDatasetCombine.D_LIST
					prop_settings = 'NNDataset';
				case 10 % NNDatasetCombine.D
					prop_settings = 'NNDataset';
				case 4 % NNDatasetCombine.TEMPLATE
					prop_settings = 'NNDatasetCombine';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNDatasetCombine.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDatasetCombine.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DCO.GETPROPDEFAULT(POINTER) returns the default value of POINTER of DCO.
			%  DEFAULT = Element.GETPROPDEFAULT(NNDatasetCombine, POINTER) returns the default value of POINTER of NNDatasetCombine.
			%  DEFAULT = DCO.GETPROPDEFAULT(NNDatasetCombine, POINTER) returns the default value of POINTER of NNDatasetCombine.
			%
			% Note that the Element.GETPROPDEFAULT(DCO) and Element.GETPROPDEFAULT('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDatasetCombine.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNDatasetCombine.D_LIST
					prop_default = Format.getFormatDefault(9, NNDatasetCombine.getPropSettings(prop));
				case 10 % NNDatasetCombine.D
					prop_default = Format.getFormatDefault(8, NNDatasetCombine.getPropSettings(prop));
				case 1 % NNDatasetCombine.ELCLASS
					prop_default = 'NNDatasetCombine';
				case 2 % NNDatasetCombine.NAME
					prop_default = 'Neural Network Dataset Combiner';
				case 3 % NNDatasetCombine.DESCRIPTION
					prop_default = 'A dataset combiner (NNDatasetCombine) takes a list of neural network datasets and combines them into a single dataset. The resulting combined dataset contains all the unique datapoints from the input datasets, and any overlapping datapoints are excluded to ensure data consistency.';
				case 4 % NNDatasetCombine.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNDatasetCombine.getPropSettings(prop));
				case 5 % NNDatasetCombine.ID
					prop_default = 'NNDatasetCombine ID';
				case 6 % NNDatasetCombine.LABEL
					prop_default = 'NNDatasetCombine label';
				case 7 % NNDatasetCombine.NOTES
					prop_default = 'NNDatasetCombine notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNDatasetCombine.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDatasetCombine.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DCO.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of DCO.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNDatasetCombine, POINTER) returns the conditioned default value of POINTER of NNDatasetCombine.
			%  DEFAULT = DCO.GETPROPDEFAULTCONDITIONED(NNDatasetCombine, POINTER) returns the conditioned default value of POINTER of NNDatasetCombine.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(DCO) and Element.GETPROPDEFAULTCONDITIONED('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNDatasetCombine.getPropProp(pointer);
			
			prop_default = NNDatasetCombine.conditioning(prop, NNDatasetCombine.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = DCO.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = DCO.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of DCO.
			%  CHECK = Element.CHECKPROP(NNDatasetCombine, PROP, VALUE) checks VALUE format for PROP of NNDatasetCombine.
			%  CHECK = DCO.CHECKPROP(NNDatasetCombine, PROP, VALUE) checks VALUE format for PROP of NNDatasetCombine.
			% 
			% DCO.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNDatasetCombine:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DCO.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of DCO.
			%   Error id: BRAPH2:NNDatasetCombine:WrongInput
			%  Element.CHECKPROP(NNDatasetCombine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDatasetCombine.
			%   Error id: BRAPH2:NNDatasetCombine:WrongInput
			%  DCO.CHECKPROP(NNDatasetCombine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDatasetCombine.
			%   Error id: BRAPH2:NNDatasetCombine:WrongInput]
			% 
			% Note that the Element.CHECKPROP(DCO) and Element.CHECKPROP('NNDatasetCombine')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNDatasetCombine.getPropProp(pointer);
			
			switch prop
				case 9 % NNDatasetCombine.D_LIST
					check = Format.checkFormat(9, value, NNDatasetCombine.getPropSettings(prop));
					if check
						if ~isempty(value)
						    dp_classes = cellfun(@(x) x.get('DP_CLASS'), value, 'uniformoutput', false);
						    if length(unique(dp_classes)) == 1
						        check = true;
						    else
						        check = all(isequal(dp_classes{:}));
						    end
						end
					end
				case 10 % NNDatasetCombine.D
					check = Format.checkFormat(8, value, NNDatasetCombine.getPropSettings(prop));
				case 4 % NNDatasetCombine.TEMPLATE
					check = Format.checkFormat(8, value, NNDatasetCombine.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDatasetCombine:' 'WrongInput'], ...
					['BRAPH2' ':NNDatasetCombine:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNDatasetCombine.getPropTag(prop) ' (' NNDatasetCombine.getFormatTag(NNDatasetCombine.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(dco, prop, varargin)
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
				case 10 % NNDatasetCombine.D
					rng_settings_ = rng(); rng(dco.getPropSeed(10), 'twister')
					
					dp_list = cellfun(@(x) x.get('DP_DICT').get('IT_LIST'), dco.get('D_LIST'), 'UniformOutput', false);
					dp_classes = cellfun(@(x) x.get('DP_CLASS'), dco.get('D_LIST'), 'UniformOutput', false);
					
					% concatenate all subjectID
					dp_list = horzcat(dp_list{:});
					
					% inspect whether there are overlapping datapoints
					if isempty(dp_list)
					    unique_dp_list = {};
					    dp_class = 'NNDataPoint';
					else
					    dp_ids = cellfun(@(x) x.get('ID'), dp_list, 'UniformOutput', false);
					    [C, i_dp_ids] = unique(dp_ids);
					    unique_dp_list = dp_list(sort(i_dp_ids));
					    dp_class = dp_classes{1};
					end
					
					% create the combined NNDataset
					combined_dp_dict = IndexedDictionary(...
					    'IT_CLASS', dp_class, ...
					    'IT_LIST',  unique_dp_list ...
					    );
					
					value = NNDataset( ...
					    'DP_CLASS', dp_class, ...
					    'DP_DICT', combined_dp_dict ...
					    );
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(dco, prop, varargin{:});
					else
						value = calculateValue@Element(dco, prop, varargin{:});
					end
			end
			
		end
	end
end
