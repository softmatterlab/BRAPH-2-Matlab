classdef SeparateGroups_CON_FUN_MP < ConcreteElement
	%SeparateGroups_CON_FUN_MP separates a group of subjects with connectivity and functiona data.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% SeparateGroups_CON_FUN_MP separates a group of subjects with connectivity 
	%  and functional data (SubjectCON_FUN_MP) into groups of SubjectCON and 
	%  SubjectCON_FUN.
	%
	% The list of SeparateGroups_CON_FUN_MP properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the separator of a CON_FUN_MP subject group.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the separator of a CON_FUN_MP subject group.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the separator of a CON_FUN_MP subject group.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the separator of a CON_FUN_MP subject group.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the separator of a CON_FUN_MP subject group.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the separator of a CON_FUN_MP subject group.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the separator of a CON_FUN_MP subject group.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar.
	%  <strong>10</strong> <strong>GR_CON_FUN_MP</strong> 	GR_CON_FUN_MP (data, item) is a group of subjects with functional and connectivity data.
	%  <strong>11</strong> <strong>GR_CON</strong> 	GR_CON (result, item) is a group of subjects with connectivity data.
	%  <strong>12</strong> <strong>GR_FUN</strong> 	GR_FUN (result, item) is a group of subjects with functional data.
	%
	% SeparateGroups_CON_FUN_MP methods (constructor):
	%  SeparateGroups_CON_FUN_MP - constructor
	%
	% SeparateGroups_CON_FUN_MP methods:
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
	% SeparateGroups_CON_FUN_MP methods (display):
	%  tostring - string with information about the separator of a CON_FUN_MP subject group
	%  disp - displays information about the separator of a CON_FUN_MP subject group
	%  tree - displays the tree of the separator of a CON_FUN_MP subject group
	%
	% SeparateGroups_CON_FUN_MP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two separator of a CON_FUN_MP subject group are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the separator of a CON_FUN_MP subject group
	%
	% SeparateGroups_CON_FUN_MP methods (save/load, Static):
	%  save - saves BRAPH2 separator of a CON_FUN_MP subject group as b2 file
	%  load - loads a BRAPH2 separator of a CON_FUN_MP subject group from a b2 file
	%
	% SeparateGroups_CON_FUN_MP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the separator of a CON_FUN_MP subject group
	%
	% SeparateGroups_CON_FUN_MP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the separator of a CON_FUN_MP subject group
	%
	% SeparateGroups_CON_FUN_MP methods (inspection, Static):
	%  getClass - returns the class of the separator of a CON_FUN_MP subject group
	%  getSubclasses - returns all subclasses of SeparateGroups_CON_FUN_MP
	%  getProps - returns the property list of the separator of a CON_FUN_MP subject group
	%  getPropNumber - returns the property number of the separator of a CON_FUN_MP subject group
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
	% SeparateGroups_CON_FUN_MP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SeparateGroups_CON_FUN_MP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SeparateGroups_CON_FUN_MP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SeparateGroups_CON_FUN_MP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SeparateGroups_CON_FUN_MP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SeparateGroups_CON_FUN_MP constants</a>.
	%
	%
	% See also SubjectCON_FUN_MP, SubjectCON, SubjectFUN, CombineGroups_CON_FUN.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		WAITBAR = 9; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 2;
		WAITBAR_FORMAT = 4;
		
		GR_CON_FUN_MP = 10; %CET: Computational Efficiency Trick
		GR_CON_FUN_MP_TAG = 'GR_CON_FUN_MP';
		GR_CON_FUN_MP_CATEGORY = 4;
		GR_CON_FUN_MP_FORMAT = 8;
		
		GR_CON = 11; %CET: Computational Efficiency Trick
		GR_CON_TAG = 'GR_CON';
		GR_CON_CATEGORY = 5;
		GR_CON_FORMAT = 8;
		
		GR_FUN = 12; %CET: Computational Efficiency Trick
		GR_FUN_TAG = 'GR_FUN';
		GR_FUN_CATEGORY = 5;
		GR_FUN_FORMAT = 8;
	end
	methods % constructor
		function se = SeparateGroups_CON_FUN_MP(varargin)
			%SeparateGroups_CON_FUN_MP() creates a separator of a CON_FUN_MP subject group.
			%
			% SeparateGroups_CON_FUN_MP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SeparateGroups_CON_FUN_MP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SeparateGroups_CON_FUN_MP properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the separator of a CON_FUN_MP subject group.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the separator of a CON_FUN_MP subject group.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the separator of a CON_FUN_MP subject group.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the separator of a CON_FUN_MP subject group.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the separator of a CON_FUN_MP subject group.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the separator of a CON_FUN_MP subject group.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the separator of a CON_FUN_MP subject group.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (metadata, logical) determines whether to show the waitbar.
			%  <strong>10</strong> <strong>GR_CON_FUN_MP</strong> 	GR_CON_FUN_MP (data, item) is a group of subjects with functional and connectivity data.
			%  <strong>11</strong> <strong>GR_CON</strong> 	GR_CON (result, item) is a group of subjects with connectivity data.
			%  <strong>12</strong> <strong>GR_FUN</strong> 	GR_FUN (result, item) is a group of subjects with functional data.
			%
			% See also Category, Format.
			
			se = se@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the separator of a CON_FUN_MP subject group.
			%
			% BUILD = SeparateGroups_CON_FUN_MP.GETBUILD() returns the build of 'SeparateGroups_CON_FUN_MP'.
			%
			% Alternative forms to call this method are:
			%  BUILD = SE.GETBUILD() returns the build of the separator of a CON_FUN_MP subject group SE.
			%  BUILD = Element.GETBUILD(SE) returns the build of 'SE'.
			%  BUILD = Element.GETBUILD('SeparateGroups_CON_FUN_MP') returns the build of 'SeparateGroups_CON_FUN_MP'.
			%
			% Note that the Element.GETBUILD(SE) and Element.GETBUILD('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			
			build = 1;
		end
		function se_class = getClass()
			%GETCLASS returns the class of the separator of a CON_FUN_MP subject group.
			%
			% CLASS = SeparateGroups_CON_FUN_MP.GETCLASS() returns the class 'SeparateGroups_CON_FUN_MP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SE.GETCLASS() returns the class of the separator of a CON_FUN_MP subject group SE.
			%  CLASS = Element.GETCLASS(SE) returns the class of 'SE'.
			%  CLASS = Element.GETCLASS('SeparateGroups_CON_FUN_MP') returns 'SeparateGroups_CON_FUN_MP'.
			%
			% Note that the Element.GETCLASS(SE) and Element.GETCLASS('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			
			se_class = 'SeparateGroups_CON_FUN_MP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the separator of a CON_FUN_MP subject group.
			%
			% LIST = SeparateGroups_CON_FUN_MP.GETSUBCLASSES() returns all subclasses of 'SeparateGroups_CON_FUN_MP'.
			%
			% Alternative forms to call this method are:
			%  LIST = SE.GETSUBCLASSES() returns all subclasses of the separator of a CON_FUN_MP subject group SE.
			%  LIST = Element.GETSUBCLASSES(SE) returns all subclasses of 'SE'.
			%  LIST = Element.GETSUBCLASSES('SeparateGroups_CON_FUN_MP') returns all subclasses of 'SeparateGroups_CON_FUN_MP'.
			%
			% Note that the Element.GETSUBCLASSES(SE) and Element.GETSUBCLASSES('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SeparateGroups_CON_FUN_MP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of separator of a CON_FUN_MP subject group.
			%
			% PROPS = SeparateGroups_CON_FUN_MP.GETPROPS() returns the property list of separator of a CON_FUN_MP subject group
			%  as a row vector.
			%
			% PROPS = SeparateGroups_CON_FUN_MP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SE.GETPROPS([CATEGORY]) returns the property list of the separator of a CON_FUN_MP subject group SE.
			%  PROPS = Element.GETPROPS(SE[, CATEGORY]) returns the property list of 'SE'.
			%  PROPS = Element.GETPROPS('SeparateGroups_CON_FUN_MP'[, CATEGORY]) returns the property list of 'SeparateGroups_CON_FUN_MP'.
			%
			% Note that the Element.GETPROPS(SE) and Element.GETPROPS('SeparateGroups_CON_FUN_MP')
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
					prop_list = [5 10];
				case 5 % Category.RESULT
					prop_list = [11 12];
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of separator of a CON_FUN_MP subject group.
			%
			% N = SeparateGroups_CON_FUN_MP.GETPROPNUMBER() returns the property number of separator of a CON_FUN_MP subject group.
			%
			% N = SeparateGroups_CON_FUN_MP.GETPROPNUMBER(CATEGORY) returns the property number of separator of a CON_FUN_MP subject group
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = SE.GETPROPNUMBER([CATEGORY]) returns the property number of the separator of a CON_FUN_MP subject group SE.
			%  N = Element.GETPROPNUMBER(SE) returns the property number of 'SE'.
			%  N = Element.GETPROPNUMBER('SeparateGroups_CON_FUN_MP') returns the property number of 'SeparateGroups_CON_FUN_MP'.
			%
			% Note that the Element.GETPROPNUMBER(SE) and Element.GETPROPNUMBER('SeparateGroups_CON_FUN_MP')
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
			%EXISTSPROP checks whether property exists in separator of a CON_FUN_MP subject group/error.
			%
			% CHECK = SeparateGroups_CON_FUN_MP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SE.EXISTSPROP(PROP) checks whether PROP exists for SE.
			%  CHECK = Element.EXISTSPROP(SE, PROP) checks whether PROP exists for SE.
			%  CHECK = Element.EXISTSPROP(SeparateGroups_CON_FUN_MP, PROP) checks whether PROP exists for SeparateGroups_CON_FUN_MP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SE.EXISTSPROP(PROP) throws error if PROP does NOT exist for SE.
			%   Error id: [BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			%  Element.EXISTSPROP(SE, PROP) throws error if PROP does NOT exist for SE.
			%   Error id: [BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			%  Element.EXISTSPROP(SeparateGroups_CON_FUN_MP, PROP) throws error if PROP does NOT exist for SeparateGroups_CON_FUN_MP.
			%   Error id: [BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(SE) and Element.EXISTSPROP('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 12 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SeparateGroups_CON_FUN_MP:' 'WrongInput'], ...
					['BRAPH2' ':SeparateGroups_CON_FUN_MP:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SeparateGroups_CON_FUN_MP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in separator of a CON_FUN_MP subject group/error.
			%
			% CHECK = SeparateGroups_CON_FUN_MP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SE.EXISTSTAG(TAG) checks whether TAG exists for SE.
			%  CHECK = Element.EXISTSTAG(SE, TAG) checks whether TAG exists for SE.
			%  CHECK = Element.EXISTSTAG(SeparateGroups_CON_FUN_MP, TAG) checks whether TAG exists for SeparateGroups_CON_FUN_MP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SE.EXISTSTAG(TAG) throws error if TAG does NOT exist for SE.
			%   Error id: [BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			%  Element.EXISTSTAG(SE, TAG) throws error if TAG does NOT exist for SE.
			%   Error id: [BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			%  Element.EXISTSTAG(SeparateGroups_CON_FUN_MP, TAG) throws error if TAG does NOT exist for SeparateGroups_CON_FUN_MP.
			%   Error id: [BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(SE) and Element.EXISTSTAG('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_CON_FUN_MP'  'GR_CON'  'GR_FUN' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SeparateGroups_CON_FUN_MP:' 'WrongInput'], ...
					['BRAPH2' ':SeparateGroups_CON_FUN_MP:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SeparateGroups_CON_FUN_MP.'] ...
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
			%  PROPERTY = SE.GETPROPPROP(POINTER) returns property number of POINTER of SE.
			%  PROPERTY = Element.GETPROPPROP(SeparateGroups_CON_FUN_MP, POINTER) returns property number of POINTER of SeparateGroups_CON_FUN_MP.
			%  PROPERTY = SE.GETPROPPROP(SeparateGroups_CON_FUN_MP, POINTER) returns property number of POINTER of SeparateGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPPROP(SE) and Element.GETPROPPROP('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_CON_FUN_MP'  'GR_CON'  'GR_FUN' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = SE.GETPROPTAG(POINTER) returns tag of POINTER of SE.
			%  TAG = Element.GETPROPTAG(SeparateGroups_CON_FUN_MP, POINTER) returns tag of POINTER of SeparateGroups_CON_FUN_MP.
			%  TAG = SE.GETPROPTAG(SeparateGroups_CON_FUN_MP, POINTER) returns tag of POINTER of SeparateGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPTAG(SE) and Element.GETPROPTAG('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				separategroups_con_fun_mp_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR_CON_FUN_MP'  'GR_CON'  'GR_FUN' };
				tag = separategroups_con_fun_mp_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = SE.GETPROPCATEGORY(POINTER) returns category of POINTER of SE.
			%  CATEGORY = Element.GETPROPCATEGORY(SeparateGroups_CON_FUN_MP, POINTER) returns category of POINTER of SeparateGroups_CON_FUN_MP.
			%  CATEGORY = SE.GETPROPCATEGORY(SeparateGroups_CON_FUN_MP, POINTER) returns category of POINTER of SeparateGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPCATEGORY(SE) and Element.GETPROPCATEGORY('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SeparateGroups_CON_FUN_MP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			separategroups_con_fun_mp_category_list = { 1  1  1  3  4  2  2  6  2  4  5  5 };
			prop_category = separategroups_con_fun_mp_category_list{prop};
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
			%  FORMAT = SE.GETPROPFORMAT(POINTER) returns format of POINTER of SE.
			%  FORMAT = Element.GETPROPFORMAT(SeparateGroups_CON_FUN_MP, POINTER) returns format of POINTER of SeparateGroups_CON_FUN_MP.
			%  FORMAT = SE.GETPROPFORMAT(SeparateGroups_CON_FUN_MP, POINTER) returns format of POINTER of SeparateGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPFORMAT(SE) and Element.GETPROPFORMAT('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SeparateGroups_CON_FUN_MP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			separategroups_con_fun_mp_format_list = { 2  2  2  8  2  2  2  2  4  8  8  8 };
			prop_format = separategroups_con_fun_mp_format_list{prop};
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
			%  DESCRIPTION = SE.GETPROPDESCRIPTION(POINTER) returns description of POINTER of SE.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SeparateGroups_CON_FUN_MP, POINTER) returns description of POINTER of SeparateGroups_CON_FUN_MP.
			%  DESCRIPTION = SE.GETPROPDESCRIPTION(SeparateGroups_CON_FUN_MP, POINTER) returns description of POINTER of SeparateGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPDESCRIPTION(SE) and Element.GETPROPDESCRIPTION('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SeparateGroups_CON_FUN_MP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			separategroups_con_fun_mp_description_list = { 'ELCLASS (constant, string) is the class of the separator of a CON_FUN_MP subject group.'  'NAME (constant, string) is the name of the separator of a CON_FUN_MP subject group.'  'DESCRIPTION (constant, string) is the description of the separator of a CON_FUN_MP subject group.'  'TEMPLATE (parameter, item) is the template of the separator of a CON_FUN_MP subject group.'  'ID (data, string) is a few-letter code for the separator of a CON_FUN_MP subject group.'  'LABEL (metadata, string) is an extended label of the separator of a CON_FUN_MP subject group.'  'NOTES (metadata, string) are some specific notes about the separator of a CON_FUN_MP subject group.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (metadata, logical) determines whether to show the waitbar.'  'GR_CON_FUN_MP (data, item) is a group of subjects with functional and connectivity data.'  'GR_CON (result, item) is a group of subjects with connectivity data.'  'GR_FUN (result, item) is a group of subjects with functional data.' };
			prop_description = separategroups_con_fun_mp_description_list{prop};
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
			%  SETTINGS = SE.GETPROPSETTINGS(POINTER) returns settings of POINTER of SE.
			%  SETTINGS = Element.GETPROPSETTINGS(SeparateGroups_CON_FUN_MP, POINTER) returns settings of POINTER of SeparateGroups_CON_FUN_MP.
			%  SETTINGS = SE.GETPROPSETTINGS(SeparateGroups_CON_FUN_MP, POINTER) returns settings of POINTER of SeparateGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPSETTINGS(SE) and Element.GETPROPSETTINGS('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SeparateGroups_CON_FUN_MP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % SeparateGroups_CON_FUN_MP.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 10 % SeparateGroups_CON_FUN_MP.GR_CON_FUN_MP
					prop_settings = 'Group';
				case 11 % SeparateGroups_CON_FUN_MP.GR_CON
					prop_settings = 'Group';
				case 12 % SeparateGroups_CON_FUN_MP.GR_FUN
					prop_settings = 'Group';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SeparateGroups_CON_FUN_MP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SeparateGroups_CON_FUN_MP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SE.
			%  DEFAULT = Element.GETPROPDEFAULT(SeparateGroups_CON_FUN_MP, POINTER) returns the default value of POINTER of SeparateGroups_CON_FUN_MP.
			%  DEFAULT = SE.GETPROPDEFAULT(SeparateGroups_CON_FUN_MP, POINTER) returns the default value of POINTER of SeparateGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPDEFAULT(SE) and Element.GETPROPDEFAULT('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SeparateGroups_CON_FUN_MP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % SeparateGroups_CON_FUN_MP.WAITBAR
					prop_default = Format.getFormatDefault(4, SeparateGroups_CON_FUN_MP.getPropSettings(prop));
				case 10 % SeparateGroups_CON_FUN_MP.GR_CON_FUN_MP
					prop_default = Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'));
				case 11 % SeparateGroups_CON_FUN_MP.GR_CON
					prop_default = Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'));
				case 12 % SeparateGroups_CON_FUN_MP.GR_FUN
					prop_default = Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'));
				case 1 % SeparateGroups_CON_FUN_MP.ELCLASS
					prop_default = 'SeparateGroups_CON_FUN_MP';
				case 2 % SeparateGroups_CON_FUN_MP.NAME
					prop_default = 'Multiplex Connectivity-Functional Group Separator';
				case 3 % SeparateGroups_CON_FUN_MP.DESCRIPTION
					prop_default = 'SeparateGroups_CON_FUN_MP separates a group of subjects with connectivity and functional data (SubjectCON_FUN_MP) into groups of SubjectCON and SubjectCON_FUN.';
				case 5 % SeparateGroups_CON_FUN_MP.ID
					prop_default = 'SeparateGroups_CON_FUN_MP ID';
				case 6 % SeparateGroups_CON_FUN_MP.LABEL
					prop_default = 'SeparateGroups_CON_FUN_MP label';
				case 7 % SeparateGroups_CON_FUN_MP.NOTES
					prop_default = 'SeparateGroups_CON_FUN_MP notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SeparateGroups_CON_FUN_MP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SeparateGroups_CON_FUN_MP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SeparateGroups_CON_FUN_MP, POINTER) returns the conditioned default value of POINTER of SeparateGroups_CON_FUN_MP.
			%  DEFAULT = SE.GETPROPDEFAULTCONDITIONED(SeparateGroups_CON_FUN_MP, POINTER) returns the conditioned default value of POINTER of SeparateGroups_CON_FUN_MP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(SE) and Element.GETPROPDEFAULTCONDITIONED('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SeparateGroups_CON_FUN_MP.getPropProp(pointer);
			
			prop_default = SeparateGroups_CON_FUN_MP.conditioning(prop, SeparateGroups_CON_FUN_MP.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = SE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = SE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of SE.
			%  CHECK = Element.CHECKPROP(SeparateGroups_CON_FUN_MP, PROP, VALUE) checks VALUE format for PROP of SeparateGroups_CON_FUN_MP.
			%  CHECK = SE.CHECKPROP(SeparateGroups_CON_FUN_MP, PROP, VALUE) checks VALUE format for PROP of SeparateGroups_CON_FUN_MP.
			% 
			% SE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SE.
			%   Error id: BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput
			%  Element.CHECKPROP(SeparateGroups_CON_FUN_MP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SeparateGroups_CON_FUN_MP.
			%   Error id: BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput
			%  SE.CHECKPROP(SeparateGroups_CON_FUN_MP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SeparateGroups_CON_FUN_MP.
			%   Error id: BRAPH2:SeparateGroups_CON_FUN_MP:WrongInput]
			% 
			% Note that the Element.CHECKPROP(SE) and Element.CHECKPROP('SeparateGroups_CON_FUN_MP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SeparateGroups_CON_FUN_MP.getPropProp(pointer);
			
			switch prop
				case 9 % SeparateGroups_CON_FUN_MP.WAITBAR
					check = Format.checkFormat(4, value, SeparateGroups_CON_FUN_MP.getPropSettings(prop));
				case 10 % SeparateGroups_CON_FUN_MP.GR_CON_FUN_MP
					check = Format.checkFormat(8, value, SeparateGroups_CON_FUN_MP.getPropSettings(prop));
					if check
						check = any(strcmp(value.get('SUB_CLASS'), SubjectCON_FUN_MP.getSubclasses()));
					end
				case 11 % SeparateGroups_CON_FUN_MP.GR_CON
					check = Format.checkFormat(8, value, SeparateGroups_CON_FUN_MP.getPropSettings(prop));
				case 12 % SeparateGroups_CON_FUN_MP.GR_FUN
					check = Format.checkFormat(8, value, SeparateGroups_CON_FUN_MP.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SeparateGroups_CON_FUN_MP:' 'WrongInput'], ...
					['BRAPH2' ':SeparateGroups_CON_FUN_MP:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SeparateGroups_CON_FUN_MP.getPropTag(prop) ' (' SeparateGroups_CON_FUN_MP.getFormatTag(SeparateGroups_CON_FUN_MP.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(se, prop, varargin)
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
				case 11 % SeparateGroups_CON_FUN_MP.GR_CON
					rng_settings_ = rng(); rng(se.getPropSeed(11), 'twister')
					
					wb = braph2waitbar(se.get('WAITBAR'), 0, 'Extracting the connectivity group ...');
					
					gr_CON = Group( ...
					    'SUB_CLASS', 'SubjectCON', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'), ...
					    'ID', 'SubjectCON' ...
					    );
					sub_dict_CON = gr_CON.get('SUB_DICT');
					
					sub_dict = se.get('GR_CON_FUN_MP').get('SUB_DICT');
					for i = 1:1:sub_dict.get('LENGTH')
					    braph2waitbar(wb, .15 + .85 * i / sub_dict.get('LENGTH'), ['Separating subject ' num2str(i) ' of ' num2str(sub_dict.get('LENGTH')) ' ...'])
					
						sub = sub_dict.get('IT', i);
					    
					    sub_CON = SubjectCON( ...
					        'ID', sub.get('ID'), ...
					        'BA', sub.get('BA'), ...
					        'VOI_DICT', sub.get('VOI_DICT').copy(), ...
					        'CON', sub.get('CON') ...
					        );
					    sub_dict_CON.get('ADD', sub_CON);    
					end
					
					value = gr_CON;
					
					braph2waitbar(wb, 'close')
					
					rng(rng_settings_)
					
				case 12 % SeparateGroups_CON_FUN_MP.GR_FUN
					rng_settings_ = rng(); rng(se.getPropSeed(12), 'twister')
					
					wb = braph2waitbar(se.get('WAITBAR'), 0, 'Extracting the functional group ...');
					
					gr_FUN = Group( ...
					    'SUB_CLASS', 'SubjectFUN', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'), ...
					    'ID', 'SubjectFUN' ...
					    );
					sub_dict_FUN = gr_FUN.get('SUB_DICT');
					
					sub_dict = se.get('GR_CON_FUN_MP').get('SUB_DICT');
					for i = 1:1:sub_dict.get('LENGTH')
					    braph2waitbar(wb, .15 + .85 * i / sub_dict.get('LENGTH'), ['Separating subject ' num2str(i) ' of ' num2str(sub_dict.get('LENGTH')) ' ...'])
					
						sub = sub_dict.get('IT', i);
					    
					    sub_FUN = SubjectFUN( ...
					        'ID', sub.get('ID'), ...
					        'BA', sub.get('BA'), ...
					        'VOI_DICT', sub.get('VOI_DICT').copy(), ...
					        'FUN', sub.get('FUN') ...
					        );
					    sub_dict_FUN.get('ADD', sub_FUN);
					end
					
					value = gr_FUN;
					
					braph2waitbar(wb, 'close')
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(se, prop, varargin{:});
					else
						value = calculateValue@Element(se, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(se, prop, value)
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
			msg = ['Error while checking ' tostring(se) ' ' se.getPropTag(prop) '.'];
			
			switch prop
				case 11 % SeparateGroups_CON_FUN_MP.GR_CON
					check = any(strcmp(value.get('SUB_CLASS'), SubjectCON.getSubclasses()));
					
				case 12 % SeparateGroups_CON_FUN_MP.GR_FUN
					check = any(strcmp(value.get('SUB_CLASS'), SubjectFUN.getSubclasses()));
					
				otherwise
					if prop <= 8
						[check, msg] = checkValue@ConcreteElement(se, prop, value);
					end
			end
		end
	end
end
