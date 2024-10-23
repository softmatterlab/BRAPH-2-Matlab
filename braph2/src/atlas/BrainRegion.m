classdef BrainRegion < ConcreteElement
	%BrainRegion is a brain region.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Brain Region (BrainRegion) contains the information of a brain region.
	%  It provides the methods necessary to handle the brain regions data.
	%  BrainRegion contains and manages the id, label, x coordinate, y 
	%  coordinate, and z coordinate of a brain region.
	%
	% The list of BrainRegion properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the brain region.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the brain region.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the brain region.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the brain region.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the brain region.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the brain region.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the brain region.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>X</strong> 	X (data, scalar) is the x-coordinate of the brain region.
	%  <strong>10</strong> <strong>Y</strong> 	Y (data, scalar) is the y-coordinate of the brain region.
	%  <strong>11</strong> <strong>Z</strong> 	Z (data, scalar) is the z-coordinate of the brain region.
	%
	% BrainRegion methods (constructor):
	%  BrainRegion - constructor
	%
	% BrainRegion methods:
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
	% BrainRegion methods (display):
	%  tostring - string with information about the brain region
	%  disp - displays information about the brain region
	%  tree - displays the tree of the brain region
	%
	% BrainRegion methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two brain region are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the brain region
	%
	% BrainRegion methods (save/load, Static):
	%  save - saves BRAPH2 brain region as b2 file
	%  load - loads a BRAPH2 brain region from a b2 file
	%
	% BrainRegion method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the brain region
	%
	% BrainRegion method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the brain region
	%
	% BrainRegion methods (inspection, Static):
	%  getClass - returns the class of the brain region
	%  getSubclasses - returns all subclasses of BrainRegion
	%  getProps - returns the property list of the brain region
	%  getPropNumber - returns the property number of the brain region
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
	% BrainRegion methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% BrainRegion methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% BrainRegion methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% BrainRegion methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?BrainRegion; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">BrainRegion constants</a>.
	%
	%
	% See also BrainAtlas, BrainSurface.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		X = 9; %CET: Computational Efficiency Trick
		X_TAG = 'X';
		X_CATEGORY = 4;
		X_FORMAT = 11;
		
		Y = 10; %CET: Computational Efficiency Trick
		Y_TAG = 'Y';
		Y_CATEGORY = 4;
		Y_FORMAT = 11;
		
		Z = 11; %CET: Computational Efficiency Trick
		Z_TAG = 'Z';
		Z_CATEGORY = 4;
		Z_FORMAT = 11;
	end
	methods % constructor
		function br = BrainRegion(varargin)
			%BrainRegion() creates a brain region.
			%
			% BrainRegion(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% BrainRegion(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of BrainRegion properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the brain region.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the brain region.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the brain region.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the brain region.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the brain region.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the brain region.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the brain region.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>X</strong> 	X (data, scalar) is the x-coordinate of the brain region.
			%  <strong>10</strong> <strong>Y</strong> 	Y (data, scalar) is the y-coordinate of the brain region.
			%  <strong>11</strong> <strong>Z</strong> 	Z (data, scalar) is the z-coordinate of the brain region.
			%
			% See also Category, Format.
			
			br = br@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the brain region.
			%
			% BUILD = BrainRegion.GETBUILD() returns the build of 'BrainRegion'.
			%
			% Alternative forms to call this method are:
			%  BUILD = BR.GETBUILD() returns the build of the brain region BR.
			%  BUILD = Element.GETBUILD(BR) returns the build of 'BR'.
			%  BUILD = Element.GETBUILD('BrainRegion') returns the build of 'BrainRegion'.
			%
			% Note that the Element.GETBUILD(BR) and Element.GETBUILD('BrainRegion')
			%  are less computationally efficient.
			
			build = 1;
		end
		function br_class = getClass()
			%GETCLASS returns the class of the brain region.
			%
			% CLASS = BrainRegion.GETCLASS() returns the class 'BrainRegion'.
			%
			% Alternative forms to call this method are:
			%  CLASS = BR.GETCLASS() returns the class of the brain region BR.
			%  CLASS = Element.GETCLASS(BR) returns the class of 'BR'.
			%  CLASS = Element.GETCLASS('BrainRegion') returns 'BrainRegion'.
			%
			% Note that the Element.GETCLASS(BR) and Element.GETCLASS('BrainRegion')
			%  are less computationally efficient.
			
			br_class = 'BrainRegion';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the brain region.
			%
			% LIST = BrainRegion.GETSUBCLASSES() returns all subclasses of 'BrainRegion'.
			%
			% Alternative forms to call this method are:
			%  LIST = BR.GETSUBCLASSES() returns all subclasses of the brain region BR.
			%  LIST = Element.GETSUBCLASSES(BR) returns all subclasses of 'BR'.
			%  LIST = Element.GETSUBCLASSES('BrainRegion') returns all subclasses of 'BrainRegion'.
			%
			% Note that the Element.GETSUBCLASSES(BR) and Element.GETSUBCLASSES('BrainRegion')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'BrainRegion' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of brain region.
			%
			% PROPS = BrainRegion.GETPROPS() returns the property list of brain region
			%  as a row vector.
			%
			% PROPS = BrainRegion.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = BR.GETPROPS([CATEGORY]) returns the property list of the brain region BR.
			%  PROPS = Element.GETPROPS(BR[, CATEGORY]) returns the property list of 'BR'.
			%  PROPS = Element.GETPROPS('BrainRegion'[, CATEGORY]) returns the property list of 'BrainRegion'.
			%
			% Note that the Element.GETPROPS(BR) and Element.GETPROPS('BrainRegion')
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
			%GETPROPNUMBER returns the property number of brain region.
			%
			% N = BrainRegion.GETPROPNUMBER() returns the property number of brain region.
			%
			% N = BrainRegion.GETPROPNUMBER(CATEGORY) returns the property number of brain region
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = BR.GETPROPNUMBER([CATEGORY]) returns the property number of the brain region BR.
			%  N = Element.GETPROPNUMBER(BR) returns the property number of 'BR'.
			%  N = Element.GETPROPNUMBER('BrainRegion') returns the property number of 'BrainRegion'.
			%
			% Note that the Element.GETPROPNUMBER(BR) and Element.GETPROPNUMBER('BrainRegion')
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
			%EXISTSPROP checks whether property exists in brain region/error.
			%
			% CHECK = BrainRegion.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BR.EXISTSPROP(PROP) checks whether PROP exists for BR.
			%  CHECK = Element.EXISTSPROP(BR, PROP) checks whether PROP exists for BR.
			%  CHECK = Element.EXISTSPROP(BrainRegion, PROP) checks whether PROP exists for BrainRegion.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:BrainRegion:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BR.EXISTSPROP(PROP) throws error if PROP does NOT exist for BR.
			%   Error id: [BRAPH2:BrainRegion:WrongInput]
			%  Element.EXISTSPROP(BR, PROP) throws error if PROP does NOT exist for BR.
			%   Error id: [BRAPH2:BrainRegion:WrongInput]
			%  Element.EXISTSPROP(BrainRegion, PROP) throws error if PROP does NOT exist for BrainRegion.
			%   Error id: [BRAPH2:BrainRegion:WrongInput]
			%
			% Note that the Element.EXISTSPROP(BR) and Element.EXISTSPROP('BrainRegion')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 11 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BrainRegion:' 'WrongInput'], ...
					['BRAPH2' ':BrainRegion:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for BrainRegion.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in brain region/error.
			%
			% CHECK = BrainRegion.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BR.EXISTSTAG(TAG) checks whether TAG exists for BR.
			%  CHECK = Element.EXISTSTAG(BR, TAG) checks whether TAG exists for BR.
			%  CHECK = Element.EXISTSTAG(BrainRegion, TAG) checks whether TAG exists for BrainRegion.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:BrainRegion:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BR.EXISTSTAG(TAG) throws error if TAG does NOT exist for BR.
			%   Error id: [BRAPH2:BrainRegion:WrongInput]
			%  Element.EXISTSTAG(BR, TAG) throws error if TAG does NOT exist for BR.
			%   Error id: [BRAPH2:BrainRegion:WrongInput]
			%  Element.EXISTSTAG(BrainRegion, TAG) throws error if TAG does NOT exist for BrainRegion.
			%   Error id: [BRAPH2:BrainRegion:WrongInput]
			%
			% Note that the Element.EXISTSTAG(BR) and Element.EXISTSTAG('BrainRegion')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'X'  'Y'  'Z' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BrainRegion:' 'WrongInput'], ...
					['BRAPH2' ':BrainRegion:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for BrainRegion.'] ...
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
			%  PROPERTY = BR.GETPROPPROP(POINTER) returns property number of POINTER of BR.
			%  PROPERTY = Element.GETPROPPROP(BrainRegion, POINTER) returns property number of POINTER of BrainRegion.
			%  PROPERTY = BR.GETPROPPROP(BrainRegion, POINTER) returns property number of POINTER of BrainRegion.
			%
			% Note that the Element.GETPROPPROP(BR) and Element.GETPROPPROP('BrainRegion')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'X'  'Y'  'Z' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = BR.GETPROPTAG(POINTER) returns tag of POINTER of BR.
			%  TAG = Element.GETPROPTAG(BrainRegion, POINTER) returns tag of POINTER of BrainRegion.
			%  TAG = BR.GETPROPTAG(BrainRegion, POINTER) returns tag of POINTER of BrainRegion.
			%
			% Note that the Element.GETPROPTAG(BR) and Element.GETPROPTAG('BrainRegion')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				brainregion_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'X'  'Y'  'Z' };
				tag = brainregion_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = BR.GETPROPCATEGORY(POINTER) returns category of POINTER of BR.
			%  CATEGORY = Element.GETPROPCATEGORY(BrainRegion, POINTER) returns category of POINTER of BrainRegion.
			%  CATEGORY = BR.GETPROPCATEGORY(BrainRegion, POINTER) returns category of POINTER of BrainRegion.
			%
			% Note that the Element.GETPROPCATEGORY(BR) and Element.GETPROPCATEGORY('BrainRegion')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = BrainRegion.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			brainregion_category_list = { 1  1  1  3  4  2  2  6  4  4  4 };
			prop_category = brainregion_category_list{prop};
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
			%  FORMAT = BR.GETPROPFORMAT(POINTER) returns format of POINTER of BR.
			%  FORMAT = Element.GETPROPFORMAT(BrainRegion, POINTER) returns format of POINTER of BrainRegion.
			%  FORMAT = BR.GETPROPFORMAT(BrainRegion, POINTER) returns format of POINTER of BrainRegion.
			%
			% Note that the Element.GETPROPFORMAT(BR) and Element.GETPROPFORMAT('BrainRegion')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = BrainRegion.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			brainregion_format_list = { 2  2  2  8  2  2  2  2  11  11  11 };
			prop_format = brainregion_format_list{prop};
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
			%  DESCRIPTION = BR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of BR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(BrainRegion, POINTER) returns description of POINTER of BrainRegion.
			%  DESCRIPTION = BR.GETPROPDESCRIPTION(BrainRegion, POINTER) returns description of POINTER of BrainRegion.
			%
			% Note that the Element.GETPROPDESCRIPTION(BR) and Element.GETPROPDESCRIPTION('BrainRegion')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = BrainRegion.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			brainregion_description_list = { 'ELCLASS (constant, string) is the class of the brain region.'  'NAME (constant, string) is the name of the brain region.'  'DESCRIPTION (constant, string) is the description of the brain region.'  'TEMPLATE (parameter, item) is the template of the brain region.'  'ID (data, string) is a few-letter code for the brain region.'  'LABEL (metadata, string) is an extended label of the brain region.'  'NOTES (metadata, string) are some specific notes about the brain region.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'X (data, scalar) is the x-coordinate of the brain region.'  'Y (data, scalar) is the y-coordinate of the brain region.'  'Z (data, scalar) is the z-coordinate of the brain region.' };
			prop_description = brainregion_description_list{prop};
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
			%  SETTINGS = BR.GETPROPSETTINGS(POINTER) returns settings of POINTER of BR.
			%  SETTINGS = Element.GETPROPSETTINGS(BrainRegion, POINTER) returns settings of POINTER of BrainRegion.
			%  SETTINGS = BR.GETPROPSETTINGS(BrainRegion, POINTER) returns settings of POINTER of BrainRegion.
			%
			% Note that the Element.GETPROPSETTINGS(BR) and Element.GETPROPSETTINGS('BrainRegion')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = BrainRegion.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % BrainRegion.X
					prop_settings = Format.getFormatSettings(11);
				case 10 % BrainRegion.Y
					prop_settings = Format.getFormatSettings(11);
				case 11 % BrainRegion.Z
					prop_settings = Format.getFormatSettings(11);
				case 4 % BrainRegion.TEMPLATE
					prop_settings = 'BrainRegion';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = BrainRegion.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainRegion.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of BR.
			%  DEFAULT = Element.GETPROPDEFAULT(BrainRegion, POINTER) returns the default value of POINTER of BrainRegion.
			%  DEFAULT = BR.GETPROPDEFAULT(BrainRegion, POINTER) returns the default value of POINTER of BrainRegion.
			%
			% Note that the Element.GETPROPDEFAULT(BR) and Element.GETPROPDEFAULT('BrainRegion')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BrainRegion.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % BrainRegion.X
					prop_default = Format.getFormatDefault(11, BrainRegion.getPropSettings(prop));
				case 10 % BrainRegion.Y
					prop_default = Format.getFormatDefault(11, BrainRegion.getPropSettings(prop));
				case 11 % BrainRegion.Z
					prop_default = Format.getFormatDefault(11, BrainRegion.getPropSettings(prop));
				case 1 % BrainRegion.ELCLASS
					prop_default = 'BrainRegion';
				case 2 % BrainRegion.NAME
					prop_default = 'Brain Region';
				case 3 % BrainRegion.DESCRIPTION
					prop_default = 'A Brain Region (BrainRegion) contains the information of a brain region. It provides the methods necessary to handle the brain regions data. BrainRegion contains and manages the id, label, x coordinate, y coordinate, and z coordinate of a brain region.';
				case 4 % BrainRegion.TEMPLATE
					prop_default = Format.getFormatDefault(8, BrainRegion.getPropSettings(prop));
				case 5 % BrainRegion.ID
					prop_default = 'BrainRegion ID';
				case 6 % BrainRegion.LABEL
					prop_default = 'BrainRegion label';
				case 7 % BrainRegion.NOTES
					prop_default = 'BrainRegion notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = BrainRegion.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainRegion.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of BR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(BrainRegion, POINTER) returns the conditioned default value of POINTER of BrainRegion.
			%  DEFAULT = BR.GETPROPDEFAULTCONDITIONED(BrainRegion, POINTER) returns the conditioned default value of POINTER of BrainRegion.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(BR) and Element.GETPROPDEFAULTCONDITIONED('BrainRegion')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = BrainRegion.getPropProp(pointer);
			
			prop_default = BrainRegion.conditioning(prop, BrainRegion.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = BR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = BR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of BR.
			%  CHECK = Element.CHECKPROP(BrainRegion, PROP, VALUE) checks VALUE format for PROP of BrainRegion.
			%  CHECK = BR.CHECKPROP(BrainRegion, PROP, VALUE) checks VALUE format for PROP of BrainRegion.
			% 
			% BR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:BrainRegion:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  BR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of BR.
			%   Error id: BRAPH2:BrainRegion:WrongInput
			%  Element.CHECKPROP(BrainRegion, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainRegion.
			%   Error id: BRAPH2:BrainRegion:WrongInput
			%  BR.CHECKPROP(BrainRegion, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainRegion.
			%   Error id: BRAPH2:BrainRegion:WrongInput]
			% 
			% Note that the Element.CHECKPROP(BR) and Element.CHECKPROP('BrainRegion')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = BrainRegion.getPropProp(pointer);
			
			switch prop
				case 9 % BrainRegion.X
					check = Format.checkFormat(11, value, BrainRegion.getPropSettings(prop));
				case 10 % BrainRegion.Y
					check = Format.checkFormat(11, value, BrainRegion.getPropSettings(prop));
				case 11 % BrainRegion.Z
					check = Format.checkFormat(11, value, BrainRegion.getPropSettings(prop));
				case 4 % BrainRegion.TEMPLATE
					check = Format.checkFormat(8, value, BrainRegion.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BrainRegion:' 'WrongInput'], ...
					['BRAPH2' ':BrainRegion:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' BrainRegion.getPropTag(prop) ' (' BrainRegion.getFormatTag(BrainRegion.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
