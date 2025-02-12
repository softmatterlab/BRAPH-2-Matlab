classdef SubjectFUN < Subject
	%SubjectFUN is a subject with functional matrix (e.
	% It is a subclass of <a href="matlab:help Subject">Subject</a>.
	%
	% Subject with a functional matrix (e.g. obtained from fMRI).
	%
	% The list of SubjectFUN properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the subject.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the subject.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the subject.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the subject.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the subject.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the subject.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the subject.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>VOI_DICT</strong> 	VOI_DICT (data, idict) contains the variables of interest of the subject.
	%  <strong>10</strong> <strong>BA</strong> 	BA (data, item) is a brain atlas.
	%  <strong>11</strong> <strong>FUN</strong> 	FUN (data, matrix) is an adjacency matrix.
	%
	% SubjectFUN methods (constructor):
	%  SubjectFUN - constructor
	%
	% SubjectFUN methods:
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
	% SubjectFUN methods (display):
	%  tostring - string with information about the subject with functional matrix
	%  disp - displays information about the subject with functional matrix
	%  tree - displays the tree of the subject with functional matrix
	%
	% SubjectFUN methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two subject with functional matrix are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the subject with functional matrix
	%
	% SubjectFUN methods (save/load, Static):
	%  save - saves BRAPH2 subject with functional matrix as b2 file
	%  load - loads a BRAPH2 subject with functional matrix from a b2 file
	%
	% SubjectFUN method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the subject with functional matrix
	%
	% SubjectFUN method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the subject with functional matrix
	%
	% SubjectFUN methods (inspection, Static):
	%  getClass - returns the class of the subject with functional matrix
	%  getSubclasses - returns all subclasses of SubjectFUN
	%  getProps - returns the property list of the subject with functional matrix
	%  getPropNumber - returns the property number of the subject with functional matrix
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
	% SubjectFUN methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SubjectFUN methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SubjectFUN methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SubjectFUN methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SubjectFUN; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SubjectFUN constants</a>.
	%
	%
	% See also ImporterGroupSubjectFUN_TXT, ExporterGroupSubjectFUN_TXT, ImporterGroupSubjectFUN_XLS, ExporterGroupSubjectFUN_XLS.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		BA = 10; %CET: Computational Efficiency Trick
		BA_TAG = 'BA';
		BA_CATEGORY = 4;
		BA_FORMAT = 8;
		
		FUN = 11; %CET: Computational Efficiency Trick
		FUN_TAG = 'FUN';
		FUN_CATEGORY = 4;
		FUN_FORMAT = 14;
	end
	methods % constructor
		function sub = SubjectFUN(varargin)
			%SubjectFUN() creates a subject with functional matrix.
			%
			% SubjectFUN(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SubjectFUN(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SubjectFUN properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the subject.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the subject.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the subject.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the subject.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the subject.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the subject.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the subject.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>VOI_DICT</strong> 	VOI_DICT (data, idict) contains the variables of interest of the subject.
			%  <strong>10</strong> <strong>BA</strong> 	BA (data, item) is a brain atlas.
			%  <strong>11</strong> <strong>FUN</strong> 	FUN (data, matrix) is an adjacency matrix.
			%
			% See also Category, Format.
			
			sub = sub@Subject(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the subject with functional matrix.
			%
			% BUILD = SubjectFUN.GETBUILD() returns the build of 'SubjectFUN'.
			%
			% Alternative forms to call this method are:
			%  BUILD = SUB.GETBUILD() returns the build of the subject with functional matrix SUB.
			%  BUILD = Element.GETBUILD(SUB) returns the build of 'SUB'.
			%  BUILD = Element.GETBUILD('SubjectFUN') returns the build of 'SubjectFUN'.
			%
			% Note that the Element.GETBUILD(SUB) and Element.GETBUILD('SubjectFUN')
			%  are less computationally efficient.
			
			build = 1;
		end
		function sub_class = getClass()
			%GETCLASS returns the class of the subject with functional matrix.
			%
			% CLASS = SubjectFUN.GETCLASS() returns the class 'SubjectFUN'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SUB.GETCLASS() returns the class of the subject with functional matrix SUB.
			%  CLASS = Element.GETCLASS(SUB) returns the class of 'SUB'.
			%  CLASS = Element.GETCLASS('SubjectFUN') returns 'SubjectFUN'.
			%
			% Note that the Element.GETCLASS(SUB) and Element.GETCLASS('SubjectFUN')
			%  are less computationally efficient.
			
			sub_class = 'SubjectFUN';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the subject with functional matrix.
			%
			% LIST = SubjectFUN.GETSUBCLASSES() returns all subclasses of 'SubjectFUN'.
			%
			% Alternative forms to call this method are:
			%  LIST = SUB.GETSUBCLASSES() returns all subclasses of the subject with functional matrix SUB.
			%  LIST = Element.GETSUBCLASSES(SUB) returns all subclasses of 'SUB'.
			%  LIST = Element.GETSUBCLASSES('SubjectFUN') returns all subclasses of 'SubjectFUN'.
			%
			% Note that the Element.GETSUBCLASSES(SUB) and Element.GETSUBCLASSES('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SubjectFUN' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of subject with functional matrix.
			%
			% PROPS = SubjectFUN.GETPROPS() returns the property list of subject with functional matrix
			%  as a row vector.
			%
			% PROPS = SubjectFUN.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SUB.GETPROPS([CATEGORY]) returns the property list of the subject with functional matrix SUB.
			%  PROPS = Element.GETPROPS(SUB[, CATEGORY]) returns the property list of 'SUB'.
			%  PROPS = Element.GETPROPS('SubjectFUN'[, CATEGORY]) returns the property list of 'SubjectFUN'.
			%
			% Note that the Element.GETPROPS(SUB) and Element.GETPROPS('SubjectFUN')
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
					prop_list = [5 9 10 11];
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of subject with functional matrix.
			%
			% N = SubjectFUN.GETPROPNUMBER() returns the property number of subject with functional matrix.
			%
			% N = SubjectFUN.GETPROPNUMBER(CATEGORY) returns the property number of subject with functional matrix
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = SUB.GETPROPNUMBER([CATEGORY]) returns the property number of the subject with functional matrix SUB.
			%  N = Element.GETPROPNUMBER(SUB) returns the property number of 'SUB'.
			%  N = Element.GETPROPNUMBER('SubjectFUN') returns the property number of 'SubjectFUN'.
			%
			% Note that the Element.GETPROPNUMBER(SUB) and Element.GETPROPNUMBER('SubjectFUN')
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
					prop_number = 4;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in subject with functional matrix/error.
			%
			% CHECK = SubjectFUN.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSPROP(PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SUB, PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SubjectFUN, PROP) checks whether PROP exists for SubjectFUN.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SubjectFUN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSPROP(PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%  Element.EXISTSPROP(SUB, PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%  Element.EXISTSPROP(SubjectFUN, PROP) throws error if PROP does NOT exist for SubjectFUN.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%
			% Note that the Element.EXISTSPROP(SUB) and Element.EXISTSPROP('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 11 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SubjectFUN:' 'WrongInput'], ...
					['BRAPH2' ':SubjectFUN:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SubjectFUN.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in subject with functional matrix/error.
			%
			% CHECK = SubjectFUN.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSTAG(TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SUB, TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SubjectFUN, TAG) checks whether TAG exists for SubjectFUN.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SubjectFUN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSTAG(TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%  Element.EXISTSTAG(SUB, TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%  Element.EXISTSTAG(SubjectFUN, TAG) throws error if TAG does NOT exist for SubjectFUN.
			%   Error id: [BRAPH2:SubjectFUN:WrongInput]
			%
			% Note that the Element.EXISTSTAG(SUB) and Element.EXISTSTAG('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'VOI_DICT'  'BA'  'FUN' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SubjectFUN:' 'WrongInput'], ...
					['BRAPH2' ':SubjectFUN:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SubjectFUN.'] ...
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
			%  PROPERTY = SUB.GETPROPPROP(POINTER) returns property number of POINTER of SUB.
			%  PROPERTY = Element.GETPROPPROP(SubjectFUN, POINTER) returns property number of POINTER of SubjectFUN.
			%  PROPERTY = SUB.GETPROPPROP(SubjectFUN, POINTER) returns property number of POINTER of SubjectFUN.
			%
			% Note that the Element.GETPROPPROP(SUB) and Element.GETPROPPROP('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'VOI_DICT'  'BA'  'FUN' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = SUB.GETPROPTAG(POINTER) returns tag of POINTER of SUB.
			%  TAG = Element.GETPROPTAG(SubjectFUN, POINTER) returns tag of POINTER of SubjectFUN.
			%  TAG = SUB.GETPROPTAG(SubjectFUN, POINTER) returns tag of POINTER of SubjectFUN.
			%
			% Note that the Element.GETPROPTAG(SUB) and Element.GETPROPTAG('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				subjectfun_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'VOI_DICT'  'BA'  'FUN' };
				tag = subjectfun_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = SUB.GETPROPCATEGORY(POINTER) returns category of POINTER of SUB.
			%  CATEGORY = Element.GETPROPCATEGORY(SubjectFUN, POINTER) returns category of POINTER of SubjectFUN.
			%  CATEGORY = SUB.GETPROPCATEGORY(SubjectFUN, POINTER) returns category of POINTER of SubjectFUN.
			%
			% Note that the Element.GETPROPCATEGORY(SUB) and Element.GETPROPCATEGORY('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			subjectfun_category_list = { 1  1  1  3  4  2  2  6  4  4  4 };
			prop_category = subjectfun_category_list{prop};
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
			%  FORMAT = SUB.GETPROPFORMAT(POINTER) returns format of POINTER of SUB.
			%  FORMAT = Element.GETPROPFORMAT(SubjectFUN, POINTER) returns format of POINTER of SubjectFUN.
			%  FORMAT = SUB.GETPROPFORMAT(SubjectFUN, POINTER) returns format of POINTER of SubjectFUN.
			%
			% Note that the Element.GETPROPFORMAT(SUB) and Element.GETPROPFORMAT('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			subjectfun_format_list = { 2  2  2  8  2  2  2  2  10  8  14 };
			prop_format = subjectfun_format_list{prop};
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
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(POINTER) returns description of POINTER of SUB.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SubjectFUN, POINTER) returns description of POINTER of SubjectFUN.
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(SubjectFUN, POINTER) returns description of POINTER of SubjectFUN.
			%
			% Note that the Element.GETPROPDESCRIPTION(SUB) and Element.GETPROPDESCRIPTION('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			subjectfun_description_list = { 'ELCLASS (constant, string) is the class of the subject.'  'NAME (constant, string) is the name of the subject.'  'DESCRIPTION (constant, string) is the description of the subject.'  'TEMPLATE (parameter, item) is the template of the subject.'  'ID (data, string) is a few-letter code for the subject.'  'LABEL (metadata, string) is an extended label of the subject.'  'NOTES (metadata, string) are some specific notes about the subject.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'VOI_DICT (data, idict) contains the variables of interest of the subject.'  'BA (data, item) is a brain atlas.'  'FUN (data, matrix) is an adjacency matrix.' };
			prop_description = subjectfun_description_list{prop};
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
			%  SETTINGS = SUB.GETPROPSETTINGS(POINTER) returns settings of POINTER of SUB.
			%  SETTINGS = Element.GETPROPSETTINGS(SubjectFUN, POINTER) returns settings of POINTER of SubjectFUN.
			%  SETTINGS = SUB.GETPROPSETTINGS(SubjectFUN, POINTER) returns settings of POINTER of SubjectFUN.
			%
			% Note that the Element.GETPROPSETTINGS(SUB) and Element.GETPROPSETTINGS('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % SubjectFUN.BA
					prop_settings = 'BrainAtlas';
				case 11 % SubjectFUN.FUN
					prop_settings = Format.getFormatSettings(14);
				otherwise
					prop_settings = getPropSettings@Subject(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SubjectFUN.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectFUN.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULT(SubjectFUN, POINTER) returns the default value of POINTER of SubjectFUN.
			%  DEFAULT = SUB.GETPROPDEFAULT(SubjectFUN, POINTER) returns the default value of POINTER of SubjectFUN.
			%
			% Note that the Element.GETPROPDEFAULT(SUB) and Element.GETPROPDEFAULT('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % SubjectFUN.BA
					prop_default = Format.getFormatDefault(8, SubjectFUN.getPropSettings(prop));
				case 11 % SubjectFUN.FUN
					prop_default = Format.getFormatDefault(14, SubjectFUN.getPropSettings(prop));
				case 1 % SubjectFUN.ELCLASS
					prop_default = 'SubjectFUN';
				case 2 % SubjectFUN.NAME
					prop_default = 'Functional Subject';
				case 3 % SubjectFUN.DESCRIPTION
					prop_default = 'Subject with a functional matrix (e.g. obtained from fMRI).';
				case 5 % SubjectFUN.ID
					prop_default = 'SubjectFUN ID';
				case 6 % SubjectFUN.LABEL
					prop_default = 'SubjectFUN label';
				case 7 % SubjectFUN.NOTES
					prop_default = 'SubjectFUN notes';
				otherwise
					prop_default = getPropDefault@Subject(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SubjectFUN.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectFUN.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SubjectFUN, POINTER) returns the conditioned default value of POINTER of SubjectFUN.
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(SubjectFUN, POINTER) returns the conditioned default value of POINTER of SubjectFUN.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(SUB) and Element.GETPROPDEFAULTCONDITIONED('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			prop_default = SubjectFUN.conditioning(prop, SubjectFUN.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = SUB.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = SUB.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of SUB.
			%  CHECK = Element.CHECKPROP(SubjectFUN, PROP, VALUE) checks VALUE format for PROP of SubjectFUN.
			%  CHECK = SUB.CHECKPROP(SubjectFUN, PROP, VALUE) checks VALUE format for PROP of SubjectFUN.
			% 
			% SUB.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SubjectFUN:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SUB.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SUB.
			%   Error id: BRAPH2:SubjectFUN:WrongInput
			%  Element.CHECKPROP(SubjectFUN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectFUN.
			%   Error id: BRAPH2:SubjectFUN:WrongInput
			%  SUB.CHECKPROP(SubjectFUN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectFUN.
			%   Error id: BRAPH2:SubjectFUN:WrongInput]
			% 
			% Note that the Element.CHECKPROP(SUB) and Element.CHECKPROP('SubjectFUN')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SubjectFUN.getPropProp(pointer);
			
			switch prop
				case 10 % SubjectFUN.BA
					check = Format.checkFormat(8, value, SubjectFUN.getPropSettings(prop));
				case 11 % SubjectFUN.FUN
					check = Format.checkFormat(14, value, SubjectFUN.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@Subject(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SubjectFUN:' 'WrongInput'], ...
					['BRAPH2' ':SubjectFUN:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SubjectFUN.getPropTag(prop) ' (' SubjectFUN.getFormatTag(SubjectFUN.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(sub, prop, value)
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
			msg = ['Error while checking ' tostring(sub) ' ' sub.getPropTag(prop) '.'];
			
			switch prop
				case 11 % SubjectFUN.FUN
					br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
					check = size(value, 2) == br_number; % Format.checkFormat(14, value) already checked
					if check
					    msg = 'All ok!';
					else   
					    msg = ['FUN must be a matrix with the same number of columns as the brain regions (' int2str(br_number) ').'];
					end
					
				otherwise
					if prop <= 9
						[check, msg] = checkValue@Subject(sub, prop, value);
					end
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(sub, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case 11 % SubjectFUN.FUN
					pr = PanelPropMatrix('EL', sub, 'PROP', 11, ...
					    'ROWNAME', {'numbered'}, ...
					    'COLUMNNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@Subject(sub, prop, varargin{:});
					
			end
		end
	end
	methods (Static) % GUI static methods
		function getGUIMenuImport(el, menu_import, pe)
			%GETGUIMENUIMPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu import
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuExporter, PlotElement.
			
			Element.getGUIMenuImport(el, menu_import, pe);
			
			if isa(el, 'Group')
			    uimenu(menu_import, ...
			        'Tag', 'MENU.Import.TXT', ...        
			        'Label', 'Import TXT ...', ...
			        'Callback', {@cb_importer_TXT});
			end
			function cb_importer_TXT(~, ~)
			    try
			        im = ImporterGroupSubjectFUN_TXT( ...
			            'ID', 'Import Group of SubjectCons from TXT', ...
			            'WAITBAR', true ...
			            ).get('GET_DIR');
			        if ~isa(im.getr('DIRECTORY'), 'NoValue')
			            gr = im.get('GR');
			            
			            gui = GUIElement('PE', gr);
			            gui.get('DRAW')
			            gui.get('SHOW')
			        end
			    catch e
			        %TODO implement and use braph2msgbox instead of warndlg
			        warndlg(['Please, select a valid input Group of SubjectCons in TXT format. ' newline() ...
			            newline() ...
			            'Error message:' newline() ...
			            newline() ...
			            e.message newline()], 'Warning');
			    end
			end
			
			if isa(el, 'Group')
			    uimenu(menu_import, ...
			        'Tag', 'MENU.Import.XLS', ...
			        'Label', 'Import XLS ...', ...
			        'Callback', {@cb_importer_XLS});
			end
			function cb_importer_XLS(~, ~)
			    try
			        im = ImporterGroupSubjectFUN_XLS( ...
			            'ID', 'Import Group of SubjectCons from XLS', ...
			            'WAITBAR', true ...
			            ).get('GET_DIR');
			        if ~isa(im.getr('DIRECTORY'), 'NoValue')
			            gr = im.get('GR');
			            gui = GUIElement('PE', gr);
			            gui.get('DRAW')
			            gui.get('SHOW')
			        end
			    catch e
			        %TODO implement and use braph2msgbox instead of warndlg
			        warndlg(['Please, select a valid input Group of SubjectCons in XLS format. ' newline() ...
			            newline() ...
			            'Error message:' newline() ...
			            newline() ...
			            e.message newline()], 'Warning');
			    end
			end
			
		end
		function getGUIMenuExport(el, menu_export, pe)
			%GETGUIMENUEXPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu export
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuImporter, PlotElement.
			
			Element.getGUIMenuExport(el, menu_export, pe);
			
			if isa(el, 'Group')
			    uimenu(menu_export, ...
			        'Tag', 'MENU.Export.TXT', ...
			        'Label', 'Export TXT ...', ...
			        'Callback', {@cb_exporter_TXT});
			end
			function cb_exporter_TXT(~, ~)
			    ex = ExporterGroupSubjectFUN_TXT( ...
			        'ID', 'Export Brain Group of SubjectCons to TXT', ...
			        'GR', el, ...
			        'WAITBAR', true ...
			        ).get('PUT_DIR');
			    if ~isa(ex.get('DIRECTORY'), 'NoValue')
			        ex.get('SAVE');
			    end
			end
			
			if isa(el, 'Group')
			    uimenu(menu_export, ...
			        'Tag', 'MENU.Export.XLS', ...
			        'Label', 'Export XLS ...', ...
			        'Callback', {@cb_exporter_XLS});
			end
			function cb_exporter_XLS(~, ~)
			    ex = ExporterGroupSubjectFUN_XLS( ...
			        'ID', 'Export Brain Group of SubjectCons to XLS', ...
			        'GR', el, ...
			        'WAITBAR', true ...
			        ).get('PUT_DIR');;
			    if ~isa(ex.get('DIRECTORY'), 'NoValue')
			        ex.get('SAVE');
			    end
			end
			
		end
	end
end
