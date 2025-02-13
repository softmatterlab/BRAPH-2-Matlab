classdef VOICategoric < VOI
	%VOICategoric is a categorical variable of interest.
	% It is a subclass of <a href="matlab:help VOI">VOI</a>.
	%
	% A Categorical Variable Of Interest (VOICategoric) is a categorical variable of interest.
	%
	% The list of VOICategoric properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the categorical variable of interest.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the categorical variable of interest.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the categorical variable of interest.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the categorical variable of interest.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the categorical variable of interest.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the categorical variable of interest.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the categorical variable of interest.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>V</strong> 	V (data, scalar) is the value of the categorical variable of interest.
	%  <strong>10</strong> <strong>CATEGORIES</strong> 	CATEGORIES (parameter, stringlist) is the list of categories.
	%
	% VOICategoric methods (constructor):
	%  VOICategoric - constructor
	%
	% VOICategoric methods:
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
	% VOICategoric methods (display):
	%  tostring - string with information about the categorical variable of interest
	%  disp - displays information about the categorical variable of interest
	%  tree - displays the tree of the categorical variable of interest
	%
	% VOICategoric methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two categorical variable of interest are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the categorical variable of interest
	%
	% VOICategoric methods (save/load, Static):
	%  save - saves BRAPH2 categorical variable of interest as b2 file
	%  load - loads a BRAPH2 categorical variable of interest from a b2 file
	%
	% VOICategoric method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the categorical variable of interest
	%
	% VOICategoric method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the categorical variable of interest
	%
	% VOICategoric methods (inspection, Static):
	%  getClass - returns the class of the categorical variable of interest
	%  getSubclasses - returns all subclasses of VOICategoric
	%  getProps - returns the property list of the categorical variable of interest
	%  getPropNumber - returns the property number of the categorical variable of interest
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
	% VOICategoric methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% VOICategoric methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% VOICategoric methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% VOICategoric methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?VOICategoric; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">VOICategoric constants</a>.
	%
	%
	% See also VOINumeric.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		CATEGORIES = 10; %CET: Computational Efficiency Trick
		CATEGORIES_TAG = 'CATEGORIES';
		CATEGORIES_CATEGORY = 3;
		CATEGORIES_FORMAT = 3;
	end
	methods % constructor
		function voi = VOICategoric(varargin)
			%VOICategoric() creates a categorical variable of interest.
			%
			% VOICategoric(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% VOICategoric(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of VOICategoric properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the categorical variable of interest.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the categorical variable of interest.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the categorical variable of interest.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the categorical variable of interest.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the categorical variable of interest.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the categorical variable of interest.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the categorical variable of interest.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>V</strong> 	V (data, scalar) is the value of the categorical variable of interest.
			%  <strong>10</strong> <strong>CATEGORIES</strong> 	CATEGORIES (parameter, stringlist) is the list of categories.
			%
			% See also Category, Format.
			
			voi = voi@VOI(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the categorical variable of interest.
			%
			% BUILD = VOICategoric.GETBUILD() returns the build of 'VOICategoric'.
			%
			% Alternative forms to call this method are:
			%  BUILD = VOI.GETBUILD() returns the build of the categorical variable of interest VOI.
			%  BUILD = Element.GETBUILD(VOI) returns the build of 'VOI'.
			%  BUILD = Element.GETBUILD('VOICategoric') returns the build of 'VOICategoric'.
			%
			% Note that the Element.GETBUILD(VOI) and Element.GETBUILD('VOICategoric')
			%  are less computationally efficient.
			
			build = 1;
		end
		function voi_class = getClass()
			%GETCLASS returns the class of the categorical variable of interest.
			%
			% CLASS = VOICategoric.GETCLASS() returns the class 'VOICategoric'.
			%
			% Alternative forms to call this method are:
			%  CLASS = VOI.GETCLASS() returns the class of the categorical variable of interest VOI.
			%  CLASS = Element.GETCLASS(VOI) returns the class of 'VOI'.
			%  CLASS = Element.GETCLASS('VOICategoric') returns 'VOICategoric'.
			%
			% Note that the Element.GETCLASS(VOI) and Element.GETCLASS('VOICategoric')
			%  are less computationally efficient.
			
			voi_class = 'VOICategoric';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the categorical variable of interest.
			%
			% LIST = VOICategoric.GETSUBCLASSES() returns all subclasses of 'VOICategoric'.
			%
			% Alternative forms to call this method are:
			%  LIST = VOI.GETSUBCLASSES() returns all subclasses of the categorical variable of interest VOI.
			%  LIST = Element.GETSUBCLASSES(VOI) returns all subclasses of 'VOI'.
			%  LIST = Element.GETSUBCLASSES('VOICategoric') returns all subclasses of 'VOICategoric'.
			%
			% Note that the Element.GETSUBCLASSES(VOI) and Element.GETSUBCLASSES('VOICategoric')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'VOICategoric' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of categorical variable of interest.
			%
			% PROPS = VOICategoric.GETPROPS() returns the property list of categorical variable of interest
			%  as a row vector.
			%
			% PROPS = VOICategoric.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = VOI.GETPROPS([CATEGORY]) returns the property list of the categorical variable of interest VOI.
			%  PROPS = Element.GETPROPS(VOI[, CATEGORY]) returns the property list of 'VOI'.
			%  PROPS = Element.GETPROPS('VOICategoric'[, CATEGORY]) returns the property list of 'VOICategoric'.
			%
			% Note that the Element.GETPROPS(VOI) and Element.GETPROPS('VOICategoric')
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
					prop_list = [4 10];
				case 4 % Category.DATA
					prop_list = [5 9];
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of categorical variable of interest.
			%
			% N = VOICategoric.GETPROPNUMBER() returns the property number of categorical variable of interest.
			%
			% N = VOICategoric.GETPROPNUMBER(CATEGORY) returns the property number of categorical variable of interest
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = VOI.GETPROPNUMBER([CATEGORY]) returns the property number of the categorical variable of interest VOI.
			%  N = Element.GETPROPNUMBER(VOI) returns the property number of 'VOI'.
			%  N = Element.GETPROPNUMBER('VOICategoric') returns the property number of 'VOICategoric'.
			%
			% Note that the Element.GETPROPNUMBER(VOI) and Element.GETPROPNUMBER('VOICategoric')
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
					prop_number = 2;
				case 4 % Category.DATA
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in categorical variable of interest/error.
			%
			% CHECK = VOICategoric.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = VOI.EXISTSPROP(PROP) checks whether PROP exists for VOI.
			%  CHECK = Element.EXISTSPROP(VOI, PROP) checks whether PROP exists for VOI.
			%  CHECK = Element.EXISTSPROP(VOICategoric, PROP) checks whether PROP exists for VOICategoric.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:VOICategoric:WrongInput]
			%
			% Alternative forms to call this method are:
			%  VOI.EXISTSPROP(PROP) throws error if PROP does NOT exist for VOI.
			%   Error id: [BRAPH2:VOICategoric:WrongInput]
			%  Element.EXISTSPROP(VOI, PROP) throws error if PROP does NOT exist for VOI.
			%   Error id: [BRAPH2:VOICategoric:WrongInput]
			%  Element.EXISTSPROP(VOICategoric, PROP) throws error if PROP does NOT exist for VOICategoric.
			%   Error id: [BRAPH2:VOICategoric:WrongInput]
			%
			% Note that the Element.EXISTSPROP(VOI) and Element.EXISTSPROP('VOICategoric')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 10 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':VOICategoric:' 'WrongInput'], ...
					['BRAPH2' ':VOICategoric:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for VOICategoric.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in categorical variable of interest/error.
			%
			% CHECK = VOICategoric.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = VOI.EXISTSTAG(TAG) checks whether TAG exists for VOI.
			%  CHECK = Element.EXISTSTAG(VOI, TAG) checks whether TAG exists for VOI.
			%  CHECK = Element.EXISTSTAG(VOICategoric, TAG) checks whether TAG exists for VOICategoric.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:VOICategoric:WrongInput]
			%
			% Alternative forms to call this method are:
			%  VOI.EXISTSTAG(TAG) throws error if TAG does NOT exist for VOI.
			%   Error id: [BRAPH2:VOICategoric:WrongInput]
			%  Element.EXISTSTAG(VOI, TAG) throws error if TAG does NOT exist for VOI.
			%   Error id: [BRAPH2:VOICategoric:WrongInput]
			%  Element.EXISTSTAG(VOICategoric, TAG) throws error if TAG does NOT exist for VOICategoric.
			%   Error id: [BRAPH2:VOICategoric:WrongInput]
			%
			% Note that the Element.EXISTSTAG(VOI) and Element.EXISTSTAG('VOICategoric')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'V'  'CATEGORIES' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':VOICategoric:' 'WrongInput'], ...
					['BRAPH2' ':VOICategoric:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for VOICategoric.'] ...
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
			%  PROPERTY = VOI.GETPROPPROP(POINTER) returns property number of POINTER of VOI.
			%  PROPERTY = Element.GETPROPPROP(VOICategoric, POINTER) returns property number of POINTER of VOICategoric.
			%  PROPERTY = VOI.GETPROPPROP(VOICategoric, POINTER) returns property number of POINTER of VOICategoric.
			%
			% Note that the Element.GETPROPPROP(VOI) and Element.GETPROPPROP('VOICategoric')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'V'  'CATEGORIES' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = VOI.GETPROPTAG(POINTER) returns tag of POINTER of VOI.
			%  TAG = Element.GETPROPTAG(VOICategoric, POINTER) returns tag of POINTER of VOICategoric.
			%  TAG = VOI.GETPROPTAG(VOICategoric, POINTER) returns tag of POINTER of VOICategoric.
			%
			% Note that the Element.GETPROPTAG(VOI) and Element.GETPROPTAG('VOICategoric')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				voicategoric_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'V'  'CATEGORIES' };
				tag = voicategoric_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = VOI.GETPROPCATEGORY(POINTER) returns category of POINTER of VOI.
			%  CATEGORY = Element.GETPROPCATEGORY(VOICategoric, POINTER) returns category of POINTER of VOICategoric.
			%  CATEGORY = VOI.GETPROPCATEGORY(VOICategoric, POINTER) returns category of POINTER of VOICategoric.
			%
			% Note that the Element.GETPROPCATEGORY(VOI) and Element.GETPROPCATEGORY('VOICategoric')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = VOICategoric.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			voicategoric_category_list = { 1  1  1  3  4  2  2  6  4  3 };
			prop_category = voicategoric_category_list{prop};
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
			%  FORMAT = VOI.GETPROPFORMAT(POINTER) returns format of POINTER of VOI.
			%  FORMAT = Element.GETPROPFORMAT(VOICategoric, POINTER) returns format of POINTER of VOICategoric.
			%  FORMAT = VOI.GETPROPFORMAT(VOICategoric, POINTER) returns format of POINTER of VOICategoric.
			%
			% Note that the Element.GETPROPFORMAT(VOI) and Element.GETPROPFORMAT('VOICategoric')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = VOICategoric.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			voicategoric_format_list = { 2  2  2  8  2  2  2  2  11  3 };
			prop_format = voicategoric_format_list{prop};
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
			%  DESCRIPTION = VOI.GETPROPDESCRIPTION(POINTER) returns description of POINTER of VOI.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(VOICategoric, POINTER) returns description of POINTER of VOICategoric.
			%  DESCRIPTION = VOI.GETPROPDESCRIPTION(VOICategoric, POINTER) returns description of POINTER of VOICategoric.
			%
			% Note that the Element.GETPROPDESCRIPTION(VOI) and Element.GETPROPDESCRIPTION('VOICategoric')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = VOICategoric.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			voicategoric_description_list = { 'ELCLASS (constant, string) is the class of the categorical variable of interest.'  'NAME (constant, string) is the name of the categorical variable of interest.'  'DESCRIPTION (constant, string) is the description of the categorical variable of interest.'  'TEMPLATE (parameter, item) is the template of the categorical variable of interest.'  'ID (data, string) is a few-letter code for the categorical variable of interest.'  'LABEL (metadata, string) is an extended label of the categorical variable of interest.'  'NOTES (metadata, string) are some specific notes about the categorical variable of interest.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'V (data, scalar) is the value of the categorical variable of interest.'  'CATEGORIES (parameter, stringlist) is the list of categories.' };
			prop_description = voicategoric_description_list{prop};
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
			%  SETTINGS = VOI.GETPROPSETTINGS(POINTER) returns settings of POINTER of VOI.
			%  SETTINGS = Element.GETPROPSETTINGS(VOICategoric, POINTER) returns settings of POINTER of VOICategoric.
			%  SETTINGS = VOI.GETPROPSETTINGS(VOICategoric, POINTER) returns settings of POINTER of VOICategoric.
			%
			% Note that the Element.GETPROPSETTINGS(VOI) and Element.GETPROPSETTINGS('VOICategoric')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = VOICategoric.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % VOICategoric.CATEGORIES
					prop_settings = Format.getFormatSettings(3);
				case 4 % VOICategoric.TEMPLATE
					prop_settings = 'VOICategoric';
				otherwise
					prop_settings = getPropSettings@VOI(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = VOICategoric.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = VOICategoric.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = VOI.GETPROPDEFAULT(POINTER) returns the default value of POINTER of VOI.
			%  DEFAULT = Element.GETPROPDEFAULT(VOICategoric, POINTER) returns the default value of POINTER of VOICategoric.
			%  DEFAULT = VOI.GETPROPDEFAULT(VOICategoric, POINTER) returns the default value of POINTER of VOICategoric.
			%
			% Note that the Element.GETPROPDEFAULT(VOI) and Element.GETPROPDEFAULT('VOICategoric')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = VOICategoric.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % VOICategoric.CATEGORIES
					prop_default = {'Male', 'Female'};
				case 1 % VOICategoric.ELCLASS
					prop_default = 'VOICategoric';
				case 2 % VOICategoric.NAME
					prop_default = 'Categorical Variable Of Interest';
				case 3 % VOICategoric.DESCRIPTION
					prop_default = 'A Categorical Variable Of Interest (VOICategoric) is a categorical variable of interest.';
				case 4 % VOICategoric.TEMPLATE
					prop_default = Format.getFormatDefault(8, VOICategoric.getPropSettings(prop));
				case 5 % VOICategoric.ID
					prop_default = 'VOICategoric ID';
				case 6 % VOICategoric.LABEL
					prop_default = 'VOICategoric label';
				case 7 % VOICategoric.NOTES
					prop_default = 'VOICategoric notes';
				case 9 % VOICategoric.V
					prop_default = 1;
				otherwise
					prop_default = getPropDefault@VOI(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = VOICategoric.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = VOICategoric.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = VOI.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of VOI.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(VOICategoric, POINTER) returns the conditioned default value of POINTER of VOICategoric.
			%  DEFAULT = VOI.GETPROPDEFAULTCONDITIONED(VOICategoric, POINTER) returns the conditioned default value of POINTER of VOICategoric.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(VOI) and Element.GETPROPDEFAULTCONDITIONED('VOICategoric')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = VOICategoric.getPropProp(pointer);
			
			prop_default = VOICategoric.conditioning(prop, VOICategoric.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = VOI.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = VOI.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of VOI.
			%  CHECK = Element.CHECKPROP(VOICategoric, PROP, VALUE) checks VALUE format for PROP of VOICategoric.
			%  CHECK = VOI.CHECKPROP(VOICategoric, PROP, VALUE) checks VALUE format for PROP of VOICategoric.
			% 
			% VOI.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:VOICategoric:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  VOI.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of VOI.
			%   Error id: BRAPH2:VOICategoric:WrongInput
			%  Element.CHECKPROP(VOICategoric, PROP, VALUE) throws error if VALUE has not a valid format for PROP of VOICategoric.
			%   Error id: BRAPH2:VOICategoric:WrongInput
			%  VOI.CHECKPROP(VOICategoric, PROP, VALUE) throws error if VALUE has not a valid format for PROP of VOICategoric.
			%   Error id: BRAPH2:VOICategoric:WrongInput]
			% 
			% Note that the Element.CHECKPROP(VOI) and Element.CHECKPROP('VOICategoric')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = VOICategoric.getPropProp(pointer);
			
			switch prop
				case 10 % VOICategoric.CATEGORIES
					check = Format.checkFormat(3, value, VOICategoric.getPropSettings(prop));
				case 4 % VOICategoric.TEMPLATE
					check = Format.checkFormat(8, value, VOICategoric.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@VOI(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':VOICategoric:' 'WrongInput'], ...
					['BRAPH2' ':VOICategoric:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' VOICategoric.getPropTag(prop) ' (' VOICategoric.getFormatTag(VOICategoric.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(voi, prop, value)
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
			msg = ['Error while checking ' tostring(voi) ' ' voi.getPropTag(prop) '.'];
			
			switch prop
				case 9 % VOICategoric.V
					check = ismember(voi.get('V'), [1:1:length(voi.get('CATEGORIES'))]);
					if check 
					    msg = 'All ok!';
					else
					    msg = ['V should be an integer corresponding to one of the CATEGORIES (here, ' cell2str(voi.get('CATEGORIES')) '), while is is ' num2str(voi.get('V')) '.'];
					end
					
				otherwise
					if prop <= 9
						[check, msg] = checkValue@VOI(voi, prop, value);
					end
			end
		end
	end
end
