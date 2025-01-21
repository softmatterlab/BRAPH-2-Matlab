classdef CombineGroups_CON_FUN_MP < ConcreteElement
	%CombineGroups_CON_FUN_MP combines a group of subjects with connectivity data with a group of subjects with functional data.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% CombineGroups_CON_FUN_MP combines a group of subjects with connectivity 
	%  data (SubjectCON) with a group of subjects with functional data (SubjectFUN)
	%  into a group of subjects with connectivity and functional data 
	%  (SubjectCON_FUN_MP). The subject ids of the two groups must match.
	% The brain atlas and variables of interest are copied from the SubjectCON group.
	%
	% The list of CombineGroups_CON_FUN_MP properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the combiner of CON and FUN subject groups.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the combiner of CON and FUN subject groups.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the combiner of CON and FUN subject groups.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the combiner of CON and FUN subject groups.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the combiner of CON and FUN subject groups.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the combiner of CON and FUN subject groups.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the combiner of CON and FUN subject groups.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>GR_CON</strong> 	GR_CON (data, item) is a group of subjects with connectivity data.
	%  <strong>11</strong> <strong>GR_FUN</strong> 	GR_FUN (data, item) is a group of subjects with functional data.
	%  <strong>12</strong> <strong>GR_CON_FUN_MP</strong> 	GR_CON_FUN_MP (result, item) is a group of subjects with connectivity and functional data.
	%
	% CombineGroups_CON_FUN_MP methods (constructor):
	%  CombineGroups_CON_FUN_MP - constructor
	%
	% CombineGroups_CON_FUN_MP methods:
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
	% CombineGroups_CON_FUN_MP methods (display):
	%  tostring - string with information about the combiner of CON and FUN subject groups
	%  disp - displays information about the combiner of CON and FUN subject groups
	%  tree - displays the tree of the combiner of CON and FUN subject groups
	%
	% CombineGroups_CON_FUN_MP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two combiner of CON and FUN subject groups are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the combiner of CON and FUN subject groups
	%
	% CombineGroups_CON_FUN_MP methods (save/load, Static):
	%  save - saves BRAPH2 combiner of CON and FUN subject groups as b2 file
	%  load - loads a BRAPH2 combiner of CON and FUN subject groups from a b2 file
	%
	% CombineGroups_CON_FUN_MP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the combiner of CON and FUN subject groups
	%
	% CombineGroups_CON_FUN_MP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the combiner of CON and FUN subject groups
	%
	% CombineGroups_CON_FUN_MP methods (inspection, Static):
	%  getClass - returns the class of the combiner of CON and FUN subject groups
	%  getSubclasses - returns all subclasses of CombineGroups_CON_FUN_MP
	%  getProps - returns the property list of the combiner of CON and FUN subject groups
	%  getPropNumber - returns the property number of the combiner of CON and FUN subject groups
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
	% CombineGroups_CON_FUN_MP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% CombineGroups_CON_FUN_MP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% CombineGroups_CON_FUN_MP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% CombineGroups_CON_FUN_MP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?CombineGroups_CON_FUN_MP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">CombineGroups_CON_FUN_MP constants</a>.
	%
	%
	% See also SubjectCON_FUN_MP, SubjectCON, SubjectFUN, SeparateGroups_CON_FUN.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		WAITBAR = 9; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 2;
		WAITBAR_FORMAT = 4;
		
		GR_CON = 10; %CET: Computational Efficiency Trick
		GR_CON_TAG = 'GR_CON';
		GR_CON_CATEGORY = 4;
		GR_CON_FORMAT = 8;
		
		GR_FUN = 11; %CET: Computational Efficiency Trick
		GR_FUN_TAG = 'GR_FUN';
		GR_FUN_CATEGORY = 4;
		GR_FUN_FORMAT = 8;
		
		GR_CON_FUN_MP = 12; %CET: Computational Efficiency Trick
		GR_CON_FUN_MP_TAG = 'GR_CON_FUN_MP';
		GR_CON_FUN_MP_CATEGORY = 5;
		GR_CON_FUN_MP_FORMAT = 8;
	end
	methods % constructor
		function co = CombineGroups_CON_FUN_MP(varargin)
			%CombineGroups_CON_FUN_MP() creates a combiner of CON and FUN subject groups.
			%
			% CombineGroups_CON_FUN_MP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% CombineGroups_CON_FUN_MP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of CombineGroups_CON_FUN_MP properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the combiner of CON and FUN subject groups.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the combiner of CON and FUN subject groups.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the combiner of CON and FUN subject groups.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the combiner of CON and FUN subject groups.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the combiner of CON and FUN subject groups.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the combiner of CON and FUN subject groups.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the combiner of CON and FUN subject groups.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (metadata, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>GR_CON</strong> 	GR_CON (data, item) is a group of subjects with connectivity data.
			%  <strong>11</strong> <strong>GR_FUN</strong> 	GR_FUN (data, item) is a group of subjects with functional data.
			%  <strong>12</strong> <strong>GR_CON_FUN_MP</strong> 	GR_CON_FUN_MP (result, item) is a group of subjects with connectivity and functional data.
			%
			% See also Category, Format.
			
			co = co@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the combiner of CON and FUN subject groups.
			%
			% BUILD = CombineGroups_CON_FUN_MP.GETBUILD() returns the build of 'CombineGroups_CON_FUN_MP'.
			%
			% Alternative forms to call this method are:
			%  BUILD = CO.GETBUILD() returns the build of the combiner of CON and FUN subject groups CO.
			%  BUILD = Element.GETBUILD(CO) returns the build of 'CO'.
			%  BUILD = Element.GETBUILD('CombineGroups_CON_FUN_MP') returns the build of 'CombineGroups_CON_FUN_MP'.
			%
			% Note that the Element.GETBUILD(CO) and Element.GETBUILD('CombineGroups_CON_FUN_MP')
			%  are less computationally efficient.
			
			build = 1;
		end
		function co_class = getClass()
			%GETCLASS returns the class of the combiner of CON and FUN subject groups.
			%
			% CLASS = CombineGroups_CON_FUN_MP.GETCLASS() returns the class 'CombineGroups_CON_FUN_MP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = CO.GETCLASS() returns the class of the combiner of CON and FUN subject groups CO.
			%  CLASS = Element.GETCLASS(CO) returns the class of 'CO'.
			%  CLASS = Element.GETCLASS('CombineGroups_CON_FUN_MP') returns 'CombineGroups_CON_FUN_MP'.
			%
			% Note that the Element.GETCLASS(CO) and Element.GETCLASS('CombineGroups_CON_FUN_MP')
			%  are less computationally efficient.
			
			co_class = 'CombineGroups_CON_FUN_MP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the combiner of CON and FUN subject groups.
			%
			% LIST = CombineGroups_CON_FUN_MP.GETSUBCLASSES() returns all subclasses of 'CombineGroups_CON_FUN_MP'.
			%
			% Alternative forms to call this method are:
			%  LIST = CO.GETSUBCLASSES() returns all subclasses of the combiner of CON and FUN subject groups CO.
			%  LIST = Element.GETSUBCLASSES(CO) returns all subclasses of 'CO'.
			%  LIST = Element.GETSUBCLASSES('CombineGroups_CON_FUN_MP') returns all subclasses of 'CombineGroups_CON_FUN_MP'.
			%
			% Note that the Element.GETSUBCLASSES(CO) and Element.GETSUBCLASSES('CombineGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'CombineGroups_CON_FUN_MP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of combiner of CON and FUN subject groups.
			%
			% PROPS = CombineGroups_CON_FUN_MP.GETPROPS() returns the property list of combiner of CON and FUN subject groups
			%  as a row vector.
			%
			% PROPS = CombineGroups_CON_FUN_MP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = CO.GETPROPS([CATEGORY]) returns the property list of the combiner of CON and FUN subject groups CO.
			%  PROPS = Element.GETPROPS(CO[, CATEGORY]) returns the property list of 'CO'.
			%  PROPS = Element.GETPROPS('CombineGroups_CON_FUN_MP'[, CATEGORY]) returns the property list of 'CombineGroups_CON_FUN_MP'.
			%
			% Note that the Element.GETPROPS(CO) and Element.GETPROPS('CombineGroups_CON_FUN_MP')
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
					prop_list = [6 7 9];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 10 11];
				case 5 % Category.RESULT
					prop_list = 12;
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of combiner of CON and FUN subject groups.
			%
			% N = CombineGroups_CON_FUN_MP.GETPROPNUMBER() returns the property number of combiner of CON and FUN subject groups.
			%
			% N = CombineGroups_CON_FUN_MP.GETPROPNUMBER(CATEGORY) returns the property number of combiner of CON and FUN subject groups
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = CO.GETPROPNUMBER([CATEGORY]) returns the property number of the combiner of CON and FUN subject groups CO.
			%  N = Element.GETPROPNUMBER(CO) returns the property number of 'CO'.
			%  N = Element.GETPROPNUMBER('CombineGroups_CON_FUN_MP') returns the property number of 'CombineGroups_CON_FUN_MP'.
			%
			% Note that the Element.GETPROPNUMBER(CO) and Element.GETPROPNUMBER('CombineGroups_CON_FUN_MP')
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
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 3;
				case 5 % Category.RESULT
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in combiner of CON and FUN subject groups/error.
			%
			% CHECK = CombineGroups_CON_FUN_MP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CO.EXISTSPROP(PROP) checks whether PROP exists for CO.
			%  CHECK = Element.EXISTSPROP(CO, PROP) checks whether PROP exists for CO.
			%  CHECK = Element.EXISTSPROP(CombineGroups_CON_FUN_MP, PROP) checks whether PROP exists for CombineGroups_CON_FUN_MP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:CombineGroups_CON_FUN_MP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CO.EXISTSPROP(PROP) throws error if PROP does NOT exist for CO.
			%   Error id: [BRAPH2:CombineGroups_CON_FUN_MP:WrongInput]
			%  Element.EXISTSPROP(CO, PROP) throws error if PROP does NOT exist for CO.
			%   Error id: [BRAPH2:CombineGroups_CON_FUN_MP:WrongInput]
			%  Element.EXISTSPROP(CombineGroups_CON_FUN_MP, PROP) throws error if PROP does NOT exist for CombineGroups_CON_FUN_MP.
			%   Error id: [BRAPH2:CombineGroups_CON_FUN_MP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(CO) and Element.EXISTSPROP('CombineGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 12 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CombineGroups_CON_FUN_MP:' 'WrongInput'], ...
					['BRAPH2' ':CombineGroups_CON_FUN_MP:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for CombineGroups_CON_FUN_MP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in combiner of CON and FUN subject groups/error.
			%
			% CHECK = CombineGroups_CON_FUN_MP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CO.EXISTSTAG(TAG) checks whether TAG exists for CO.
			%  CHECK = Element.EXISTSTAG(CO, TAG) checks whether TAG exists for CO.
			%  CHECK = Element.EXISTSTAG(CombineGroups_CON_FUN_MP, TAG) checks whether TAG exists for CombineGroups_CON_FUN_MP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:CombineGroups_CON_FUN_MP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CO.EXISTSTAG(TAG) throws error if TAG does NOT exist for CO.
			%   Error id: [BRAPH2:CombineGroups_CON_FUN_MP:WrongInput]
			%  Element.EXISTSTAG(CO, TAG) throws error if TAG does NOT exist for CO.
			%   Error id: [BRAPH2:CombineGroups_CON_FUN_MP:WrongInput]
			%  Element.EXISTSTAG(CombineGroups_CON_FUN_MP, TAG) throws error if TAG does NOT exist for CombineGroups_CON_FUN_MP.
			%   Error id: [BRAPH2:CombineGroups_CON_FUN_MP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(CO) and Element.EXISTSTAG('CombineGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_CON'  'GR_FUN'  'GR_CON_FUN_MP' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CombineGroups_CON_FUN_MP:' 'WrongInput'], ...
					['BRAPH2' ':CombineGroups_CON_FUN_MP:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for CombineGroups_CON_FUN_MP.'] ...
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
			%  PROPERTY = CO.GETPROPPROP(POINTER) returns property number of POINTER of CO.
			%  PROPERTY = Element.GETPROPPROP(CombineGroups_CON_FUN_MP, POINTER) returns property number of POINTER of CombineGroups_CON_FUN_MP.
			%  PROPERTY = CO.GETPROPPROP(CombineGroups_CON_FUN_MP, POINTER) returns property number of POINTER of CombineGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPPROP(CO) and Element.GETPROPPROP('CombineGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_CON'  'GR_FUN'  'GR_CON_FUN_MP' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = CO.GETPROPTAG(POINTER) returns tag of POINTER of CO.
			%  TAG = Element.GETPROPTAG(CombineGroups_CON_FUN_MP, POINTER) returns tag of POINTER of CombineGroups_CON_FUN_MP.
			%  TAG = CO.GETPROPTAG(CombineGroups_CON_FUN_MP, POINTER) returns tag of POINTER of CombineGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPTAG(CO) and Element.GETPROPTAG('CombineGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				combinegroups_con_fun_mp_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_CON'  'GR_FUN'  'GR_CON_FUN_MP' };
				tag = combinegroups_con_fun_mp_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = CO.GETPROPCATEGORY(POINTER) returns category of POINTER of CO.
			%  CATEGORY = Element.GETPROPCATEGORY(CombineGroups_CON_FUN_MP, POINTER) returns category of POINTER of CombineGroups_CON_FUN_MP.
			%  CATEGORY = CO.GETPROPCATEGORY(CombineGroups_CON_FUN_MP, POINTER) returns category of POINTER of CombineGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPCATEGORY(CO) and Element.GETPROPCATEGORY('CombineGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = CombineGroups_CON_FUN_MP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			combinegroups_con_fun_mp_category_list = { 1  1  1  3  4  2  2  6  2  4  4  5 };
			prop_category = combinegroups_con_fun_mp_category_list{prop};
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
			%  FORMAT = CO.GETPROPFORMAT(POINTER) returns format of POINTER of CO.
			%  FORMAT = Element.GETPROPFORMAT(CombineGroups_CON_FUN_MP, POINTER) returns format of POINTER of CombineGroups_CON_FUN_MP.
			%  FORMAT = CO.GETPROPFORMAT(CombineGroups_CON_FUN_MP, POINTER) returns format of POINTER of CombineGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPFORMAT(CO) and Element.GETPROPFORMAT('CombineGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = CombineGroups_CON_FUN_MP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			combinegroups_con_fun_mp_format_list = { 2  2  2  8  2  2  2  2  4  8  8  8 };
			prop_format = combinegroups_con_fun_mp_format_list{prop};
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
			%  DESCRIPTION = CO.GETPROPDESCRIPTION(POINTER) returns description of POINTER of CO.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CombineGroups_CON_FUN_MP, POINTER) returns description of POINTER of CombineGroups_CON_FUN_MP.
			%  DESCRIPTION = CO.GETPROPDESCRIPTION(CombineGroups_CON_FUN_MP, POINTER) returns description of POINTER of CombineGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPDESCRIPTION(CO) and Element.GETPROPDESCRIPTION('CombineGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = CombineGroups_CON_FUN_MP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			combinegroups_con_fun_mp_description_list = { 'ELCLASS (constant, string) is the class of the combiner of CON and FUN subject groups.'  'NAME (constant, string) is the name of the combiner of CON and FUN subject groups.'  'DESCRIPTION (constant, string) is the description of the combiner of CON and FUN subject groups.'  'TEMPLATE (parameter, item) is the template of the combiner of CON and FUN subject groups.'  'ID (data, string) is a few-letter code for the combiner of CON and FUN subject groups.'  'LABEL (metadata, string) is an extended label of the combiner of CON and FUN subject groups.'  'NOTES (metadata, string) are some specific notes about the combiner of CON and FUN subject groups.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (metadata, logical) detemines whether to show the waitbar.'  'GR_CON (data, item) is a group of subjects with connectivity data.'  'GR_FUN (data, item) is a group of subjects with functional data.'  'GR_CON_FUN_MP (result, item) is a group of subjects with connectivity and functional data.' };
			prop_description = combinegroups_con_fun_mp_description_list{prop};
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
			%  SETTINGS = CO.GETPROPSETTINGS(POINTER) returns settings of POINTER of CO.
			%  SETTINGS = Element.GETPROPSETTINGS(CombineGroups_CON_FUN_MP, POINTER) returns settings of POINTER of CombineGroups_CON_FUN_MP.
			%  SETTINGS = CO.GETPROPSETTINGS(CombineGroups_CON_FUN_MP, POINTER) returns settings of POINTER of CombineGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPSETTINGS(CO) and Element.GETPROPSETTINGS('CombineGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = CombineGroups_CON_FUN_MP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % CombineGroups_CON_FUN_MP.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 10 % CombineGroups_CON_FUN_MP.GR_CON
					prop_settings = 'Group';
				case 11 % CombineGroups_CON_FUN_MP.GR_FUN
					prop_settings = 'Group';
				case 12 % CombineGroups_CON_FUN_MP.GR_CON_FUN_MP
					prop_settings = 'Group';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = CombineGroups_CON_FUN_MP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = CombineGroups_CON_FUN_MP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CO.GETPROPDEFAULT(POINTER) returns the default value of POINTER of CO.
			%  DEFAULT = Element.GETPROPDEFAULT(CombineGroups_CON_FUN_MP, POINTER) returns the default value of POINTER of CombineGroups_CON_FUN_MP.
			%  DEFAULT = CO.GETPROPDEFAULT(CombineGroups_CON_FUN_MP, POINTER) returns the default value of POINTER of CombineGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPDEFAULT(CO) and Element.GETPROPDEFAULT('CombineGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CombineGroups_CON_FUN_MP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % CombineGroups_CON_FUN_MP.WAITBAR
					prop_default = Format.getFormatDefault(4, CombineGroups_CON_FUN_MP.getPropSettings(prop));
				case 10 % CombineGroups_CON_FUN_MP.GR_CON
					prop_default = Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'));
				case 11 % CombineGroups_CON_FUN_MP.GR_FUN
					prop_default = Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'));
				case 12 % CombineGroups_CON_FUN_MP.GR_CON_FUN_MP
					prop_default = Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'));
				case 1 % CombineGroups_CON_FUN_MP.ELCLASS
					prop_default = 'CombineGroups_CON_FUN_MP';
				case 2 % CombineGroups_CON_FUN_MP.NAME
					prop_default = 'Multiplex Connectivity-Functional Group Combiner';
				case 3 % CombineGroups_CON_FUN_MP.DESCRIPTION
					prop_default = 'CombineGroups_CON_FUN_MP combines a group of subjects with connectivity data (SubjectCON) with a group of subjects with functional data (SubjectFUN) into a group of subjects with connectivity and functional data (SubjectCON_FUN_MP). The subject ids of the two groups must match. The brain atlas and variables of interest are copied from the SubjectCON group.';
				case 5 % CombineGroups_CON_FUN_MP.ID
					prop_default = 'CombineGroups_CON_FUN_MP ID';
				case 6 % CombineGroups_CON_FUN_MP.LABEL
					prop_default = 'CombineGroups_CON_FUN_MP label';
				case 7 % CombineGroups_CON_FUN_MP.NOTES
					prop_default = 'CombineGroups_CON_FUN_MP notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = CombineGroups_CON_FUN_MP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = CombineGroups_CON_FUN_MP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CO.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of CO.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(CombineGroups_CON_FUN_MP, POINTER) returns the conditioned default value of POINTER of CombineGroups_CON_FUN_MP.
			%  DEFAULT = CO.GETPROPDEFAULTCONDITIONED(CombineGroups_CON_FUN_MP, POINTER) returns the conditioned default value of POINTER of CombineGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(CO) and Element.GETPROPDEFAULTCONDITIONED('CombineGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = CombineGroups_CON_FUN_MP.getPropProp(pointer);
			
			prop_default = CombineGroups_CON_FUN_MP.conditioning(prop, CombineGroups_CON_FUN_MP.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = CO.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = CO.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of CO.
			%  CHECK = Element.CHECKPROP(CombineGroups_CON_FUN_MP, PROP, VALUE) checks VALUE format for PROP of CombineGroups_CON_FUN_MP.
			%  CHECK = CO.CHECKPROP(CombineGroups_CON_FUN_MP, PROP, VALUE) checks VALUE format for PROP of CombineGroups_CON_FUN_MP.
			% 
			% CO.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:CombineGroups_CON_FUN_MP:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CO.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of CO.
			%   Error id: BRAPH2:CombineGroups_CON_FUN_MP:WrongInput
			%  Element.CHECKPROP(CombineGroups_CON_FUN_MP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CombineGroups_CON_FUN_MP.
			%   Error id: BRAPH2:CombineGroups_CON_FUN_MP:WrongInput
			%  CO.CHECKPROP(CombineGroups_CON_FUN_MP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CombineGroups_CON_FUN_MP.
			%   Error id: BRAPH2:CombineGroups_CON_FUN_MP:WrongInput]
			% 
			% Note that the Element.CHECKPROP(CO) and Element.CHECKPROP('CombineGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = CombineGroups_CON_FUN_MP.getPropProp(pointer);
			
			switch prop
				case 9 % CombineGroups_CON_FUN_MP.WAITBAR
					check = Format.checkFormat(4, value, CombineGroups_CON_FUN_MP.getPropSettings(prop));
				case 10 % CombineGroups_CON_FUN_MP.GR_CON
					check = Format.checkFormat(8, value, CombineGroups_CON_FUN_MP.getPropSettings(prop));
					if check
						check = any(strcmp(value.get('SUB_CLASS'), SubjectCON.getSubclasses()));
					end
				case 11 % CombineGroups_CON_FUN_MP.GR_FUN
					check = Format.checkFormat(8, value, CombineGroups_CON_FUN_MP.getPropSettings(prop));
					if check
						check = any(strcmp(value.get('SUB_CLASS'), SubjectFUN.getSubclasses()));
					end
				case 12 % CombineGroups_CON_FUN_MP.GR_CON_FUN_MP
					check = Format.checkFormat(8, value, CombineGroups_CON_FUN_MP.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CombineGroups_CON_FUN_MP:' 'WrongInput'], ...
					['BRAPH2' ':CombineGroups_CON_FUN_MP:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' CombineGroups_CON_FUN_MP.getPropTag(prop) ' (' CombineGroups_CON_FUN_MP.getFormatTag(CombineGroups_CON_FUN_MP.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(co, prop, varargin)
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
				case 12 % CombineGroups_CON_FUN_MP.GR_CON_FUN_MP
					rng_settings_ = rng(); rng(co.getPropSeed(12), 'twister')
					
					wb = braph2waitbar(co.get('WAITBAR'), 0, 'Combining subject groups ...');
					
					% get connectivity and functional groups
					gr_CON = co.get('GR_CON');
					gr_FUN = co.get('GR_FUN');
					if gr_CON.get('SUB_DICT').get('LENGTH') ~= gr_FUN.get('SUB_DICT').get('LENGTH')
					    error( ...
					        ['BRAPH2' ':' class(co) ':' 'WrongInput'], ...
					        ['BRAPH2' ':' class(co) ':' 'WrongInput' '\n' ...
					        'The groups to be combined must have the same number of subjects, ', ...
					        'while group CON has ' int2str(gr_CON.get('SUB_DICT').get('LENGTH')) ' subjects and group FUN has ' int2str(gr_FUN.get('SUB_DICT').get('LENGTH')) ' subjects.'] ...
					        )   
					end
					    
					% creates empty group
					gr = Group( ...
					    'SUB_CLASS', 'SubjectCON_FUN_MP', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'), ...
					    'ID', [gr_CON.get('ID') ' + ' gr_FUN.get('ID')], ...
					    'LABEL', [gr_CON.get('LABEL') ' -- ' gr_FUN.get('LABEL')], ...
					    'NOTES', ['Group combining the connectivity group ' gr_CON.get('ID') ' and the functional group ' gr_FUN.get('ID')] ...
					    );
					
					sub_dict = gr.get('SUB_DICT');
					sub_dict_gr_CON = gr_CON.get('SUB_DICT');
					sub_dict_gr_FUN = gr_FUN.get('SUB_DICT');
					
					for i = 1:1:gr_CON.get('SUB_DICT').get('LENGTH')
					    braph2waitbar(wb, .15 + .85 * i / gr_CON.get('SUB_DICT').get('LENGTH'), ['Combining subject ' num2str(i) ' of ' num2str(gr_CON.get('SUB_DICT').get('LENGTH')) ' ...'])
					
					    sub_CON = sub_dict_gr_CON.get('IT', i);
					    sub_id = sub_CON.get('ID');
					    
					    sub_FUN = sub_dict_gr_FUN.get('IT', sub_id);
					    
					    sub = SubjectCON_FUN_MP( ...
					        'ID', sub_id, ...
					        'BA', sub_CON.get('BA'), ...
					        'VOI_DICT', sub_CON.get('VOI_DICT').copy(), ...
					        'CON', sub_CON.get('CON'), ...
					        'FUN', sub_FUN.get('FUN') ...
					        );
					    sub_dict.get('ADD', sub);
					end
					
					value = gr;
					
					braph2waitbar(wb, 'close')
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(co, prop, varargin{:});
					else
						value = calculateValue@Element(co, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(co, prop, value)
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
			msg = ['Error while checking ' tostring(co) ' ' co.getPropTag(prop) '.'];
			
			switch prop
				case 12 % CombineGroups_CON_FUN_MP.GR_CON_FUN_MP
					check = any(strcmp(value.get('SUB_CLASS'), SubjectCON_FUN_MP.getSubclasses()));
					
				otherwise
					if prop <= 8
						[check, msg] = checkValue@ConcreteElement(co, prop, value);
					end
			end
		end
	end
end
