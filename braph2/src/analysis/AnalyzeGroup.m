classdef AnalyzeGroup < ConcreteElement
	%AnalyzeGroup is a group-based graph analysis.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% AnalyzeGroup provides the methods necessary for all group-based analysis subclasses.
	% Instances of this class should not be created; Use one of its subclasses instead.
	%
	% The list of AnalyzeGroup properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the group-based graph analysis.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the group-based graph analysis.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the group-based graph analysis.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the group-based graph analysis.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the group-based graph analysis.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the group-based graph analysis.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>GR</strong> 	GR (data, item) is the subject group, which also defines the subject class.
	%  <strong>11</strong> <strong>G</strong> 	G (result, item) is the graph obtained from this analysis.
	%
	% AnalyzeGroup methods (constructor):
	%  AnalyzeGroup - constructor
	%
	% AnalyzeGroup methods:
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
	% AnalyzeGroup methods (display):
	%  tostring - string with information about the group-based graph analysis
	%  disp - displays information about the group-based graph analysis
	%  tree - displays the tree of the group-based graph analysis
	%
	% AnalyzeGroup methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two group-based graph analysis are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the group-based graph analysis
	%
	% AnalyzeGroup methods (save/load, Static):
	%  save - saves BRAPH2 group-based graph analysis as b2 file
	%  load - loads a BRAPH2 group-based graph analysis from a b2 file
	%
	% AnalyzeGroup method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the group-based graph analysis
	%
	% AnalyzeGroup method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the group-based graph analysis
	%
	% AnalyzeGroup methods (inspection, Static):
	%  getClass - returns the class of the group-based graph analysis
	%  getSubclasses - returns all subclasses of AnalyzeGroup
	%  getProps - returns the property list of the group-based graph analysis
	%  getPropNumber - returns the property number of the group-based graph analysis
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
	% AnalyzeGroup methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% AnalyzeGroup methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% AnalyzeGroup methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeGroup methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?AnalyzeGroup; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">AnalyzeGroup constants</a>.
	%
	%
	% See also CompareGroup.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		WAITBAR = 9; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
		
		GR = 10; %CET: Computational Efficiency Trick
		GR_TAG = 'GR';
		GR_CATEGORY = 4;
		GR_FORMAT = 8;
		
		G = 11; %CET: Computational Efficiency Trick
		G_TAG = 'G';
		G_CATEGORY = 5;
		G_FORMAT = 8;
	end
	methods % constructor
		function a = AnalyzeGroup(varargin)
			%AnalyzeGroup() creates a group-based graph analysis.
			%
			% AnalyzeGroup(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeGroup(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of AnalyzeGroup properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the group-based graph analysis.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the group-based graph analysis.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the group-based graph analysis.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the group-based graph analysis.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the group-based graph analysis.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the group-based graph analysis.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>GR</strong> 	GR (data, item) is the subject group, which also defines the subject class.
			%  <strong>11</strong> <strong>G</strong> 	G (result, item) is the graph obtained from this analysis.
			%
			% See also Category, Format.
			
			a = a@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the group-based graph analysis.
			%
			% BUILD = AnalyzeGroup.GETBUILD() returns the build of 'AnalyzeGroup'.
			%
			% Alternative forms to call this method are:
			%  BUILD = A.GETBUILD() returns the build of the group-based graph analysis A.
			%  BUILD = Element.GETBUILD(A) returns the build of 'A'.
			%  BUILD = Element.GETBUILD('AnalyzeGroup') returns the build of 'AnalyzeGroup'.
			%
			% Note that the Element.GETBUILD(A) and Element.GETBUILD('AnalyzeGroup')
			%  are less computationally efficient.
			
			build = 1;
		end
		function a_class = getClass()
			%GETCLASS returns the class of the group-based graph analysis.
			%
			% CLASS = AnalyzeGroup.GETCLASS() returns the class 'AnalyzeGroup'.
			%
			% Alternative forms to call this method are:
			%  CLASS = A.GETCLASS() returns the class of the group-based graph analysis A.
			%  CLASS = Element.GETCLASS(A) returns the class of 'A'.
			%  CLASS = Element.GETCLASS('AnalyzeGroup') returns 'AnalyzeGroup'.
			%
			% Note that the Element.GETCLASS(A) and Element.GETCLASS('AnalyzeGroup')
			%  are less computationally efficient.
			
			a_class = 'AnalyzeGroup';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the group-based graph analysis.
			%
			% LIST = AnalyzeGroup.GETSUBCLASSES() returns all subclasses of 'AnalyzeGroup'.
			%
			% Alternative forms to call this method are:
			%  LIST = A.GETSUBCLASSES() returns all subclasses of the group-based graph analysis A.
			%  LIST = Element.GETSUBCLASSES(A) returns all subclasses of 'A'.
			%  LIST = Element.GETSUBCLASSES('AnalyzeGroup') returns all subclasses of 'AnalyzeGroup'.
			%
			% Note that the Element.GETSUBCLASSES(A) and Element.GETSUBCLASSES('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'AnalyzeGroup'  'AnalyzeGroup_CON_GA_WU'  'AnalyzeGroup_CON_MP_GA_WU'  'AnalyzeGroup_CON_OMP_GA_WU'  'AnalyzeGroup_CON_FUN_MP_GA_BUD'  'AnalyzeGroup_CON_FUN_MP_GA_WU'  'AnalyzeGroup_FUN_GA_WU'  'AnalyzeGroup_FUN_MP_GA_WU'  'AnalyzeGroup_FUN_OMP_GA_WU'  'AnalyzeGroup_ST_BUD'  'AnalyzeGroup_ST_BUT'  'AnalyzeGroup_ST_WU'  'AnalyzeGroup_ST_MP_BUD'  'AnalyzeGroup_ST_MP_BUT'  'AnalyzeGroup_ST_MP_WU' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of group-based graph analysis.
			%
			% PROPS = AnalyzeGroup.GETPROPS() returns the property list of group-based graph analysis
			%  as a row vector.
			%
			% PROPS = AnalyzeGroup.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = A.GETPROPS([CATEGORY]) returns the property list of the group-based graph analysis A.
			%  PROPS = Element.GETPROPS(A[, CATEGORY]) returns the property list of 'A'.
			%  PROPS = Element.GETPROPS('AnalyzeGroup'[, CATEGORY]) returns the property list of 'AnalyzeGroup'.
			%
			% Note that the Element.GETPROPS(A) and Element.GETPROPS('AnalyzeGroup')
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
					prop_list = [5 10];
				case 5 % Category.RESULT
					prop_list = 11;
				case 6 % Category.QUERY
					prop_list = 8;
				case 9 % Category.GUI
					prop_list = 9;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of group-based graph analysis.
			%
			% N = AnalyzeGroup.GETPROPNUMBER() returns the property number of group-based graph analysis.
			%
			% N = AnalyzeGroup.GETPROPNUMBER(CATEGORY) returns the property number of group-based graph analysis
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = A.GETPROPNUMBER([CATEGORY]) returns the property number of the group-based graph analysis A.
			%  N = Element.GETPROPNUMBER(A) returns the property number of 'A'.
			%  N = Element.GETPROPNUMBER('AnalyzeGroup') returns the property number of 'AnalyzeGroup'.
			%
			% Note that the Element.GETPROPNUMBER(A) and Element.GETPROPNUMBER('AnalyzeGroup')
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
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in group-based graph analysis/error.
			%
			% CHECK = AnalyzeGroup.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSPROP(PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(A, PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(AnalyzeGroup, PROP) checks whether PROP exists for AnalyzeGroup.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSPROP(PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%  Element.EXISTSPROP(A, PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%  Element.EXISTSPROP(AnalyzeGroup, PROP) throws error if PROP does NOT exist for AnalyzeGroup.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%
			% Note that the Element.EXISTSPROP(A) and Element.EXISTSPROP('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 11 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeGroup:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeGroup:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeGroup.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in group-based graph analysis/error.
			%
			% CHECK = AnalyzeGroup.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSTAG(TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(A, TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(AnalyzeGroup, TAG) checks whether TAG exists for AnalyzeGroup.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSTAG(TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%  Element.EXISTSTAG(A, TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%  Element.EXISTSTAG(AnalyzeGroup, TAG) throws error if TAG does NOT exist for AnalyzeGroup.
			%   Error id: [BRAPH2:AnalyzeGroup:WrongInput]
			%
			% Note that the Element.EXISTSTAG(A) and Element.EXISTSTAG('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'G' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeGroup:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeGroup:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for AnalyzeGroup.'] ...
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
			%  PROPERTY = A.GETPROPPROP(POINTER) returns property number of POINTER of A.
			%  PROPERTY = Element.GETPROPPROP(AnalyzeGroup, POINTER) returns property number of POINTER of AnalyzeGroup.
			%  PROPERTY = A.GETPROPPROP(AnalyzeGroup, POINTER) returns property number of POINTER of AnalyzeGroup.
			%
			% Note that the Element.GETPROPPROP(A) and Element.GETPROPPROP('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'G' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = A.GETPROPTAG(POINTER) returns tag of POINTER of A.
			%  TAG = Element.GETPROPTAG(AnalyzeGroup, POINTER) returns tag of POINTER of AnalyzeGroup.
			%  TAG = A.GETPROPTAG(AnalyzeGroup, POINTER) returns tag of POINTER of AnalyzeGroup.
			%
			% Note that the Element.GETPROPTAG(A) and Element.GETPROPTAG('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				analyzegroup_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'G' };
				tag = analyzegroup_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = A.GETPROPCATEGORY(POINTER) returns category of POINTER of A.
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeGroup, POINTER) returns category of POINTER of AnalyzeGroup.
			%  CATEGORY = A.GETPROPCATEGORY(AnalyzeGroup, POINTER) returns category of POINTER of AnalyzeGroup.
			%
			% Note that the Element.GETPROPCATEGORY(A) and Element.GETPROPCATEGORY('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzegroup_category_list = { 1  1  1  3  4  2  2  6  9  4  5 };
			prop_category = analyzegroup_category_list{prop};
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
			%  FORMAT = A.GETPROPFORMAT(POINTER) returns format of POINTER of A.
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeGroup, POINTER) returns format of POINTER of AnalyzeGroup.
			%  FORMAT = A.GETPROPFORMAT(AnalyzeGroup, POINTER) returns format of POINTER of AnalyzeGroup.
			%
			% Note that the Element.GETPROPFORMAT(A) and Element.GETPROPFORMAT('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzegroup_format_list = { 2  2  2  8  2  2  2  2  4  8  8 };
			prop_format = analyzegroup_format_list{prop};
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
			%  DESCRIPTION = A.GETPROPDESCRIPTION(POINTER) returns description of POINTER of A.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeGroup, POINTER) returns description of POINTER of AnalyzeGroup.
			%  DESCRIPTION = A.GETPROPDESCRIPTION(AnalyzeGroup, POINTER) returns description of POINTER of AnalyzeGroup.
			%
			% Note that the Element.GETPROPDESCRIPTION(A) and Element.GETPROPDESCRIPTION('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzegroup_description_list = { 'ELCLASS (constant, string) is the class of the % % % .'  'NAME (constant, string) is the name of the group-based graph analysis.'  'DESCRIPTION (constant, string) is the description of the group-based graph analysis.'  'TEMPLATE (parameter, item) is the template of the group-based graph analysis.'  'ID (data, string) is a few-letter code for the group-based graph analysis.'  'LABEL (metadata, string) is an extended label of the group-based graph analysis.'  'NOTES (metadata, string) are some specific notes about the group-based graph analysis.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'GR (data, item) is the subject group, which also defines the subject class.'  'G (result, item) is the graph obtained from this analysis.' };
			prop_description = analyzegroup_description_list{prop};
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
			%  SETTINGS = A.GETPROPSETTINGS(POINTER) returns settings of POINTER of A.
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeGroup, POINTER) returns settings of POINTER of AnalyzeGroup.
			%  SETTINGS = A.GETPROPSETTINGS(AnalyzeGroup, POINTER) returns settings of POINTER of AnalyzeGroup.
			%
			% Note that the Element.GETPROPSETTINGS(A) and Element.GETPROPSETTINGS('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % AnalyzeGroup.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 10 % AnalyzeGroup.GR
					prop_settings = 'Group';
				case 11 % AnalyzeGroup.G
					prop_settings = 'Graph';
				case 4 % Analyze4
					prop_settings = 'AnalyzeGroup';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeGroup.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroup.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULT(POINTER) returns the default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeGroup, POINTER) returns the default value of POINTER of AnalyzeGroup.
			%  DEFAULT = A.GETPROPDEFAULT(AnalyzeGroup, POINTER) returns the default value of POINTER of AnalyzeGroup.
			%
			% Note that the Element.GETPROPDEFAULT(A) and Element.GETPROPDEFAULT('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % AnalyzeGroup.WAITBAR
					prop_default = true;
				case 10 % AnalyzeGroup.GR
					prop_default = Format.getFormatDefault(8, AnalyzeGroup.getPropSettings(prop));
				case 11 % AnalyzeGroup.G
					prop_default = Format.getFormatDefault(8, AnalyzeGroup.getPropSettings(prop));
				case 1 % Analyze1
					prop_default = 'AnalyzeGroup';
				case 2 % Analyze2
					prop_default = 'AnalyzeGroup';
				case 3 % Analyze3
					prop_default = 'AnalyzeGroup provides the methods necessary for all group-based analysis subclasses. Instances of this class should not be created; Use one of its subclasses instead.';
				case 4 % Analyze4
					prop_default = Format.getFormatDefault(8, AnalyzeGroup.getPropSettings(prop));
				case 5 % Analyze5
					prop_default = 'AnalyzeGroup ID';
				case 6 % Analyze6
					prop_default = 'AnalyzeGroup label';
				case 7 % Analyze7
					prop_default = 'AnalyzeGroup notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeGroup.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroup.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeGroup, POINTER) returns the conditioned default value of POINTER of AnalyzeGroup.
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(AnalyzeGroup, POINTER) returns the conditioned default value of POINTER of AnalyzeGroup.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(A) and Element.GETPROPDEFAULTCONDITIONED('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			prop_default = AnalyzeGroup.conditioning(prop, AnalyzeGroup.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = A.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = A.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of A.
			%  CHECK = Element.CHECKPROP(AnalyzeGroup, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroup.
			%  CHECK = A.CHECKPROP(AnalyzeGroup, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroup.
			% 
			% A.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:AnalyzeGroup:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  A.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of A.
			%   Error id: BRAPH2:AnalyzeGroup:WrongInput
			%  Element.CHECKPROP(AnalyzeGroup, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroup.
			%   Error id: BRAPH2:AnalyzeGroup:WrongInput
			%  A.CHECKPROP(AnalyzeGroup, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroup.
			%   Error id: BRAPH2:AnalyzeGroup:WrongInput]
			% 
			% Note that the Element.CHECKPROP(A) and Element.CHECKPROP('AnalyzeGroup')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = AnalyzeGroup.getPropProp(pointer);
			
			switch prop
				case 9 % AnalyzeGroup.WAITBAR
					check = Format.checkFormat(4, value, AnalyzeGroup.getPropSettings(prop));
				case 10 % AnalyzeGroup.GR
					check = Format.checkFormat(8, value, AnalyzeGroup.getPropSettings(prop));
				case 11 % AnalyzeGroup.G
					check = Format.checkFormat(8, value, AnalyzeGroup.getPropSettings(prop));
				case 4 % Analyze4
					check = Format.checkFormat(8, value, AnalyzeGroup.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeGroup:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeGroup:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeGroup.getPropTag(prop) ' (' AnalyzeGroup.getFormatTag(AnalyzeGroup.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(a, prop, varargin)
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
				case 11 % AnalyzeGroup.G
					rng_settings_ = rng(); rng(a.getPropSeed(11), 'twister')
					
					value = Graph();
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(a, prop, varargin{:});
					else
						value = calculateValue@Element(a, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(a, prop, varargin)
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
				case 10 % AnalyzeGroup.GR
					pr = PanelPropItem('EL', a, 'PROP', 10, ...
					    'BUTTON_TEXT', a.get('GR').get('ID'), ...
					    varargin{:});
					
				case 11 % AnalyzeGroup.G
					% pr = PanelPropItem('EL', a, 'PROP', 11, ...
					%     'GUICLASS', 'GUIElement', ...
					%     'BUTTON_TEXT', 'Graph & Measures', ...
					%     varargin{:});
					pr = AnalyzeGroupPP_G('EL', a, 'PROP', 11, ...
					    'WAITBAR', a.getCallback('WAITBAR'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(a, prop, varargin{:});
					
			end
		end
	end
end
