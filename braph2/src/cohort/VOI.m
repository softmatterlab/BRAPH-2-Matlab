classdef VOI < ConcreteElement
	%VOI is the base element for the variables of interest.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Variable Of Interest (VOI) is the base element for a variable of interest.
	%  Instances of this class should not be created. 
	%  Use one of its subclasses instead.
	%
	% The list of VOI properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the variable of interest.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the variable of interest.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the variable of interest.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the variable of interest.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the variable of interest.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the variable of interest.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the variable of interest.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>V</strong> 	V (data, scalar) is the value of the variable of interest.
	%
	% VOI methods (constructor):
	%  VOI - constructor
	%
	% VOI methods:
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
	% VOI methods (display):
	%  tostring - string with information about the variable of interest
	%  disp - displays information about the variable of interest
	%  tree - displays the tree of the variable of interest
	%
	% VOI methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two variable of interest are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the variable of interest
	%
	% VOI methods (save/load, Static):
	%  save - saves BRAPH2 variable of interest as b2 file
	%  load - loads a BRAPH2 variable of interest from a b2 file
	%
	% VOI method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the variable of interest
	%
	% VOI method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the variable of interest
	%
	% VOI methods (inspection, Static):
	%  getClass - returns the class of the variable of interest
	%  getSubclasses - returns all subclasses of VOI
	%  getProps - returns the property list of the variable of interest
	%  getPropNumber - returns the property number of the variable of interest
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
	% VOI methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% VOI methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% VOI methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% VOI methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?VOI; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">VOI constants</a>.
	%
	%
	% See also VOINumeric, VOICategoric.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		V = 9; %CET: Computational Efficiency Trick
		V_TAG = 'V';
		V_CATEGORY = 4;
		V_FORMAT = 11;
	end
	methods % constructor
		function voi = VOI(varargin)
			%VOI() creates a variable of interest.
			%
			% VOI(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% VOI(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of VOI properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the variable of interest.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the variable of interest.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the variable of interest.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the variable of interest.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the variable of interest.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the variable of interest.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the variable of interest.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>V</strong> 	V (data, scalar) is the value of the variable of interest.
			%
			% See also Category, Format.
			
			voi = voi@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the variable of interest.
			%
			% BUILD = VOI.GETBUILD() returns the build of 'VOI'.
			%
			% Alternative forms to call this method are:
			%  BUILD = VOI.GETBUILD() returns the build of the variable of interest VOI.
			%  BUILD = Element.GETBUILD(VOI) returns the build of 'VOI'.
			%  BUILD = Element.GETBUILD('VOI') returns the build of 'VOI'.
			%
			% Note that the Element.GETBUILD(VOI) and Element.GETBUILD('VOI')
			%  are less computationally efficient.
			
			build = 1;
		end
		function voi_class = getClass()
			%GETCLASS returns the class of the variable of interest.
			%
			% CLASS = VOI.GETCLASS() returns the class 'VOI'.
			%
			% Alternative forms to call this method are:
			%  CLASS = VOI.GETCLASS() returns the class of the variable of interest VOI.
			%  CLASS = Element.GETCLASS(VOI) returns the class of 'VOI'.
			%  CLASS = Element.GETCLASS('VOI') returns 'VOI'.
			%
			% Note that the Element.GETCLASS(VOI) and Element.GETCLASS('VOI')
			%  are less computationally efficient.
			
			voi_class = 'VOI';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the variable of interest.
			%
			% LIST = VOI.GETSUBCLASSES() returns all subclasses of 'VOI'.
			%
			% Alternative forms to call this method are:
			%  LIST = VOI.GETSUBCLASSES() returns all subclasses of the variable of interest VOI.
			%  LIST = Element.GETSUBCLASSES(VOI) returns all subclasses of 'VOI'.
			%  LIST = Element.GETSUBCLASSES('VOI') returns all subclasses of 'VOI'.
			%
			% Note that the Element.GETSUBCLASSES(VOI) and Element.GETSUBCLASSES('VOI')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'VOI'  'VOICategoric'  'VOINumeric' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of variable of interest.
			%
			% PROPS = VOI.GETPROPS() returns the property list of variable of interest
			%  as a row vector.
			%
			% PROPS = VOI.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = VOI.GETPROPS([CATEGORY]) returns the property list of the variable of interest VOI.
			%  PROPS = Element.GETPROPS(VOI[, CATEGORY]) returns the property list of 'VOI'.
			%  PROPS = Element.GETPROPS('VOI'[, CATEGORY]) returns the property list of 'VOI'.
			%
			% Note that the Element.GETPROPS(VOI) and Element.GETPROPS('VOI')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9];
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
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of variable of interest.
			%
			% N = VOI.GETPROPNUMBER() returns the property number of variable of interest.
			%
			% N = VOI.GETPROPNUMBER(CATEGORY) returns the property number of variable of interest
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = VOI.GETPROPNUMBER([CATEGORY]) returns the property number of the variable of interest VOI.
			%  N = Element.GETPROPNUMBER(VOI) returns the property number of 'VOI'.
			%  N = Element.GETPROPNUMBER('VOI') returns the property number of 'VOI'.
			%
			% Note that the Element.GETPROPNUMBER(VOI) and Element.GETPROPNUMBER('VOI')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 9;
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
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in variable of interest/error.
			%
			% CHECK = VOI.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = VOI.EXISTSPROP(PROP) checks whether PROP exists for VOI.
			%  CHECK = Element.EXISTSPROP(VOI, PROP) checks whether PROP exists for VOI.
			%  CHECK = Element.EXISTSPROP(VOI, PROP) checks whether PROP exists for VOI.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:VOI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  VOI.EXISTSPROP(PROP) throws error if PROP does NOT exist for VOI.
			%   Error id: [BRAPH2:VOI:WrongInput]
			%  Element.EXISTSPROP(VOI, PROP) throws error if PROP does NOT exist for VOI.
			%   Error id: [BRAPH2:VOI:WrongInput]
			%  Element.EXISTSPROP(VOI, PROP) throws error if PROP does NOT exist for VOI.
			%   Error id: [BRAPH2:VOI:WrongInput]
			%
			% Note that the Element.EXISTSPROP(VOI) and Element.EXISTSPROP('VOI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 9 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':VOI:' 'WrongInput'], ...
					['BRAPH2' ':VOI:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for VOI.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in variable of interest/error.
			%
			% CHECK = VOI.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = VOI.EXISTSTAG(TAG) checks whether TAG exists for VOI.
			%  CHECK = Element.EXISTSTAG(VOI, TAG) checks whether TAG exists for VOI.
			%  CHECK = Element.EXISTSTAG(VOI, TAG) checks whether TAG exists for VOI.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:VOI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  VOI.EXISTSTAG(TAG) throws error if TAG does NOT exist for VOI.
			%   Error id: [BRAPH2:VOI:WrongInput]
			%  Element.EXISTSTAG(VOI, TAG) throws error if TAG does NOT exist for VOI.
			%   Error id: [BRAPH2:VOI:WrongInput]
			%  Element.EXISTSTAG(VOI, TAG) throws error if TAG does NOT exist for VOI.
			%   Error id: [BRAPH2:VOI:WrongInput]
			%
			% Note that the Element.EXISTSTAG(VOI) and Element.EXISTSTAG('VOI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'V' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':VOI:' 'WrongInput'], ...
					['BRAPH2' ':VOI:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for VOI.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(VOI, POINTER) returns property number of POINTER of VOI.
			%  PROPERTY = VOI.GETPROPPROP(VOI, POINTER) returns property number of POINTER of VOI.
			%
			% Note that the Element.GETPROPPROP(VOI) and Element.GETPROPPROP('VOI')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'V' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(VOI, POINTER) returns tag of POINTER of VOI.
			%  TAG = VOI.GETPROPTAG(VOI, POINTER) returns tag of POINTER of VOI.
			%
			% Note that the Element.GETPROPTAG(VOI) and Element.GETPROPTAG('VOI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				voi_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'V' };
				tag = voi_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(VOI, POINTER) returns category of POINTER of VOI.
			%  CATEGORY = VOI.GETPROPCATEGORY(VOI, POINTER) returns category of POINTER of VOI.
			%
			% Note that the Element.GETPROPCATEGORY(VOI) and Element.GETPROPCATEGORY('VOI')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = VOI.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			voi_category_list = { 1  1  1  3  4  2  2  6  4 };
			prop_category = voi_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(VOI, POINTER) returns format of POINTER of VOI.
			%  FORMAT = VOI.GETPROPFORMAT(VOI, POINTER) returns format of POINTER of VOI.
			%
			% Note that the Element.GETPROPFORMAT(VOI) and Element.GETPROPFORMAT('VOI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = VOI.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			voi_format_list = { 2  2  2  8  2  2  2  2  11 };
			prop_format = voi_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(VOI, POINTER) returns description of POINTER of VOI.
			%  DESCRIPTION = VOI.GETPROPDESCRIPTION(VOI, POINTER) returns description of POINTER of VOI.
			%
			% Note that the Element.GETPROPDESCRIPTION(VOI) and Element.GETPROPDESCRIPTION('VOI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = VOI.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			voi_description_list = { 'ELCLASS (constant, string) is the class of the variable of interest.'  'NAME (constant, string) is the name of the variable of interest.'  'DESCRIPTION (constant, string) is the description of the variable of interest.'  'TEMPLATE (parameter, item) is the template of the variable of interest.'  'ID (data, string) is a few-letter code for the variable of interest.'  'LABEL (metadata, string) is an extended label of the variable of interest.'  'NOTES (metadata, string) are some specific notes about the variable of interest.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'V (data, scalar) is the value of the variable of interest.' };
			prop_description = voi_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(VOI, POINTER) returns settings of POINTER of VOI.
			%  SETTINGS = VOI.GETPROPSETTINGS(VOI, POINTER) returns settings of POINTER of VOI.
			%
			% Note that the Element.GETPROPSETTINGS(VOI) and Element.GETPROPSETTINGS('VOI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = VOI.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % VOI.V
					prop_settings = Format.getFormatSettings(11);
				case 4 % VOI.TEMPLATE
					prop_settings = 'VOI';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = VOI.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = VOI.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = VOI.GETPROPDEFAULT(POINTER) returns the default value of POINTER of VOI.
			%  DEFAULT = Element.GETPROPDEFAULT(VOI, POINTER) returns the default value of POINTER of VOI.
			%  DEFAULT = VOI.GETPROPDEFAULT(VOI, POINTER) returns the default value of POINTER of VOI.
			%
			% Note that the Element.GETPROPDEFAULT(VOI) and Element.GETPROPDEFAULT('VOI')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = VOI.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % VOI.V
					prop_default = Format.getFormatDefault(11, VOI.getPropSettings(prop));
				case 1 % VOI.ELCLASS
					prop_default = 'VOI';
				case 2 % VOI.NAME
					prop_default = 'Variable Of Interest';
				case 3 % VOI.DESCRIPTION
					prop_default = 'A Variable Of Interest (VOI) is the base element for a variable of interest. Instances of this class should not be created. Use one of its subclasses instead.';
				case 4 % VOI.TEMPLATE
					prop_default = Format.getFormatDefault(8, VOI.getPropSettings(prop));
				case 5 % VOI.ID
					prop_default = 'VOI ID';
				case 6 % VOI.LABEL
					prop_default = 'VOI label';
				case 7 % VOI.NOTES
					prop_default = 'VOI notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = VOI.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = VOI.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = VOI.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of VOI.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(VOI, POINTER) returns the conditioned default value of POINTER of VOI.
			%  DEFAULT = VOI.GETPROPDEFAULTCONDITIONED(VOI, POINTER) returns the conditioned default value of POINTER of VOI.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(VOI) and Element.GETPROPDEFAULTCONDITIONED('VOI')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = VOI.getPropProp(pointer);
			
			prop_default = VOI.conditioning(prop, VOI.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(VOI, PROP, VALUE) checks VALUE format for PROP of VOI.
			%  CHECK = VOI.CHECKPROP(VOI, PROP, VALUE) checks VALUE format for PROP of VOI.
			% 
			% VOI.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:VOI:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  VOI.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of VOI.
			%   Error id: BRAPH2:VOI:WrongInput
			%  Element.CHECKPROP(VOI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of VOI.
			%   Error id: BRAPH2:VOI:WrongInput
			%  VOI.CHECKPROP(VOI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of VOI.
			%   Error id: BRAPH2:VOI:WrongInput]
			% 
			% Note that the Element.CHECKPROP(VOI) and Element.CHECKPROP('VOI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = VOI.getPropProp(pointer);
			
			switch prop
				case 9 % VOI.V
					check = Format.checkFormat(11, value, VOI.getPropSettings(prop));
				case 4 % VOI.TEMPLATE
					check = Format.checkFormat(8, value, VOI.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':VOI:' 'WrongInput'], ...
					['BRAPH2' ':VOI:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' VOI.getPropTag(prop) ' (' VOI.getFormatTag(VOI.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
