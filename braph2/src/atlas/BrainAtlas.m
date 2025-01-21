classdef BrainAtlas < ConcreteElement
	%BrainAtlas is a brain atlas.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Brain Atlas (BrainAtlas) represents a brain atlas, constituted 
	%  by a collection of brain regions.
	% BrainAtlas contains and manages brain regions inside an IndexedDictionary; 
	%  thus, it has access to all IndexedDictionary methods.
	% BrainAtlas can be imported/exported to .txt, .xls and .json files.
	%
	% The list of BrainAtlas properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the brain atlas (BrainAtlas).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the brain atlas.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the brain atlas.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the brain atlas.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the brain atlas.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the brain atlas.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the brain atlas.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>BR_DICT</strong> 	BR_DICT (data, idict) contains the brain regions of the brain atlas.
	%  <strong>10</strong> <strong>PFBA</strong> 	PFBA (gui, item) contains the panel figure of the brain atlas.
	%
	% BrainAtlas methods (constructor):
	%  BrainAtlas - constructor
	%
	% BrainAtlas methods:
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
	% BrainAtlas methods (display):
	%  tostring - string with information about the brain atlas
	%  disp - displays information about the brain atlas
	%  tree - displays the tree of the brain atlas
	%
	% BrainAtlas methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two brain atlas are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the brain atlas
	%
	% BrainAtlas methods (save/load, Static):
	%  save - saves BRAPH2 brain atlas as b2 file
	%  load - loads a BRAPH2 brain atlas from a b2 file
	%
	% BrainAtlas method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the brain atlas
	%
	% BrainAtlas method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the brain atlas
	%
	% BrainAtlas methods (inspection, Static):
	%  getClass - returns the class of the brain atlas
	%  getSubclasses - returns all subclasses of BrainAtlas
	%  getProps - returns the property list of the brain atlas
	%  getPropNumber - returns the property number of the brain atlas
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
	% BrainAtlas methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% BrainAtlas methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% BrainAtlas methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% BrainAtlas methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?BrainAtlas; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">BrainAtlas constants</a>.
	%
	%
	% See also BrainRegion, BrainSurface, ImporterBrainAtlasXLS, ImporterBrainAtlasTXT, ExporterBrainAtlasXLS, ExporterBrainAtlasTXT.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		BR_DICT = 9; %CET: Computational Efficiency Trick
		BR_DICT_TAG = 'BR_DICT';
		BR_DICT_CATEGORY = 4;
		BR_DICT_FORMAT = 10;
		
		PFBA = 10; %CET: Computational Efficiency Trick
		PFBA_TAG = 'PFBA';
		PFBA_CATEGORY = 9;
		PFBA_FORMAT = 8;
	end
	methods % constructor
		function ba = BrainAtlas(varargin)
			%BrainAtlas() creates a brain atlas.
			%
			% BrainAtlas(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% BrainAtlas(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of BrainAtlas properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the brain atlas (BrainAtlas).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the brain atlas.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the brain atlas.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the brain atlas.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the brain atlas.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the brain atlas.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the brain atlas.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>BR_DICT</strong> 	BR_DICT (data, idict) contains the brain regions of the brain atlas.
			%  <strong>10</strong> <strong>PFBA</strong> 	PFBA (gui, item) contains the panel figure of the brain atlas.
			%
			% See also Category, Format.
			
			ba = ba@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the brain atlas.
			%
			% BUILD = BrainAtlas.GETBUILD() returns the build of 'BrainAtlas'.
			%
			% Alternative forms to call this method are:
			%  BUILD = BA.GETBUILD() returns the build of the brain atlas BA.
			%  BUILD = Element.GETBUILD(BA) returns the build of 'BA'.
			%  BUILD = Element.GETBUILD('BrainAtlas') returns the build of 'BrainAtlas'.
			%
			% Note that the Element.GETBUILD(BA) and Element.GETBUILD('BrainAtlas')
			%  are less computationally efficient.
			
			build = 1;
		end
		function ba_class = getClass()
			%GETCLASS returns the class of the brain atlas.
			%
			% CLASS = BrainAtlas.GETCLASS() returns the class 'BrainAtlas'.
			%
			% Alternative forms to call this method are:
			%  CLASS = BA.GETCLASS() returns the class of the brain atlas BA.
			%  CLASS = Element.GETCLASS(BA) returns the class of 'BA'.
			%  CLASS = Element.GETCLASS('BrainAtlas') returns 'BrainAtlas'.
			%
			% Note that the Element.GETCLASS(BA) and Element.GETCLASS('BrainAtlas')
			%  are less computationally efficient.
			
			ba_class = 'BrainAtlas';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the brain atlas.
			%
			% LIST = BrainAtlas.GETSUBCLASSES() returns all subclasses of 'BrainAtlas'.
			%
			% Alternative forms to call this method are:
			%  LIST = BA.GETSUBCLASSES() returns all subclasses of the brain atlas BA.
			%  LIST = Element.GETSUBCLASSES(BA) returns all subclasses of 'BA'.
			%  LIST = Element.GETSUBCLASSES('BrainAtlas') returns all subclasses of 'BrainAtlas'.
			%
			% Note that the Element.GETSUBCLASSES(BA) and Element.GETSUBCLASSES('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'BrainAtlas' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of brain atlas.
			%
			% PROPS = BrainAtlas.GETPROPS() returns the property list of brain atlas
			%  as a row vector.
			%
			% PROPS = BrainAtlas.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = BA.GETPROPS([CATEGORY]) returns the property list of the brain atlas BA.
			%  PROPS = Element.GETPROPS(BA[, CATEGORY]) returns the property list of 'BA'.
			%  PROPS = Element.GETPROPS('BrainAtlas'[, CATEGORY]) returns the property list of 'BrainAtlas'.
			%
			% Note that the Element.GETPROPS(BA) and Element.GETPROPS('BrainAtlas')
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
				case 6 % Category.QUERY
					prop_list = 8;
				case 9 % Category.GUI
					prop_list = 10;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of brain atlas.
			%
			% N = BrainAtlas.GETPROPNUMBER() returns the property number of brain atlas.
			%
			% N = BrainAtlas.GETPROPNUMBER(CATEGORY) returns the property number of brain atlas
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = BA.GETPROPNUMBER([CATEGORY]) returns the property number of the brain atlas BA.
			%  N = Element.GETPROPNUMBER(BA) returns the property number of 'BA'.
			%  N = Element.GETPROPNUMBER('BrainAtlas') returns the property number of 'BrainAtlas'.
			%
			% Note that the Element.GETPROPNUMBER(BA) and Element.GETPROPNUMBER('BrainAtlas')
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
				case 6 % Category.QUERY
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in brain atlas/error.
			%
			% CHECK = BrainAtlas.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BA.EXISTSPROP(PROP) checks whether PROP exists for BA.
			%  CHECK = Element.EXISTSPROP(BA, PROP) checks whether PROP exists for BA.
			%  CHECK = Element.EXISTSPROP(BrainAtlas, PROP) checks whether PROP exists for BrainAtlas.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:BrainAtlas:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BA.EXISTSPROP(PROP) throws error if PROP does NOT exist for BA.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%  Element.EXISTSPROP(BA, PROP) throws error if PROP does NOT exist for BA.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%  Element.EXISTSPROP(BrainAtlas, PROP) throws error if PROP does NOT exist for BrainAtlas.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%
			% Note that the Element.EXISTSPROP(BA) and Element.EXISTSPROP('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 10 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BrainAtlas:' 'WrongInput'], ...
					['BRAPH2' ':BrainAtlas:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for BrainAtlas.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in brain atlas/error.
			%
			% CHECK = BrainAtlas.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BA.EXISTSTAG(TAG) checks whether TAG exists for BA.
			%  CHECK = Element.EXISTSTAG(BA, TAG) checks whether TAG exists for BA.
			%  CHECK = Element.EXISTSTAG(BrainAtlas, TAG) checks whether TAG exists for BrainAtlas.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:BrainAtlas:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BA.EXISTSTAG(TAG) throws error if TAG does NOT exist for BA.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%  Element.EXISTSTAG(BA, TAG) throws error if TAG does NOT exist for BA.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%  Element.EXISTSTAG(BrainAtlas, TAG) throws error if TAG does NOT exist for BrainAtlas.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%
			% Note that the Element.EXISTSTAG(BA) and Element.EXISTSTAG('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'BR_DICT'  'PFBA' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BrainAtlas:' 'WrongInput'], ...
					['BRAPH2' ':BrainAtlas:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for BrainAtlas.'] ...
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
			%  PROPERTY = BA.GETPROPPROP(POINTER) returns property number of POINTER of BA.
			%  PROPERTY = Element.GETPROPPROP(BrainAtlas, POINTER) returns property number of POINTER of BrainAtlas.
			%  PROPERTY = BA.GETPROPPROP(BrainAtlas, POINTER) returns property number of POINTER of BrainAtlas.
			%
			% Note that the Element.GETPROPPROP(BA) and Element.GETPROPPROP('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'BR_DICT'  'PFBA' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = BA.GETPROPTAG(POINTER) returns tag of POINTER of BA.
			%  TAG = Element.GETPROPTAG(BrainAtlas, POINTER) returns tag of POINTER of BrainAtlas.
			%  TAG = BA.GETPROPTAG(BrainAtlas, POINTER) returns tag of POINTER of BrainAtlas.
			%
			% Note that the Element.GETPROPTAG(BA) and Element.GETPROPTAG('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				brainatlas_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'BR_DICT'  'PFBA' };
				tag = brainatlas_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = BA.GETPROPCATEGORY(POINTER) returns category of POINTER of BA.
			%  CATEGORY = Element.GETPROPCATEGORY(BrainAtlas, POINTER) returns category of POINTER of BrainAtlas.
			%  CATEGORY = BA.GETPROPCATEGORY(BrainAtlas, POINTER) returns category of POINTER of BrainAtlas.
			%
			% Note that the Element.GETPROPCATEGORY(BA) and Element.GETPROPCATEGORY('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			brainatlas_category_list = { 1  1  1  3  4  2  2  6  4  9 };
			prop_category = brainatlas_category_list{prop};
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
			%  FORMAT = BA.GETPROPFORMAT(POINTER) returns format of POINTER of BA.
			%  FORMAT = Element.GETPROPFORMAT(BrainAtlas, POINTER) returns format of POINTER of BrainAtlas.
			%  FORMAT = BA.GETPROPFORMAT(BrainAtlas, POINTER) returns format of POINTER of BrainAtlas.
			%
			% Note that the Element.GETPROPFORMAT(BA) and Element.GETPROPFORMAT('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			brainatlas_format_list = { 2  2  2  8  2  2  2  2  10  8 };
			prop_format = brainatlas_format_list{prop};
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
			%  DESCRIPTION = BA.GETPROPDESCRIPTION(POINTER) returns description of POINTER of BA.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(BrainAtlas, POINTER) returns description of POINTER of BrainAtlas.
			%  DESCRIPTION = BA.GETPROPDESCRIPTION(BrainAtlas, POINTER) returns description of POINTER of BrainAtlas.
			%
			% Note that the Element.GETPROPDESCRIPTION(BA) and Element.GETPROPDESCRIPTION('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			brainatlas_description_list = { 'ELCLASS (constant, string) is the class of the brain atlas (BrainAtlas).'  'NAME (constant, string) is the name of the brain atlas.'  'DESCRIPTION (constant, string) is the description of the brain atlas.'  'TEMPLATE (parameter, item) is the template of the brain atlas.'  'ID (data, string) is a few-letter code for the brain atlas.'  'LABEL (metadata, string) is an extended label of the brain atlas.'  'NOTES (metadata, string) are some specific notes about the brain atlas.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'BR_DICT (data, idict) contains the brain regions of the brain atlas.'  'PFBA (gui, item) contains the panel figure of the brain atlas.' };
			prop_description = brainatlas_description_list{prop};
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
			%  SETTINGS = BA.GETPROPSETTINGS(POINTER) returns settings of POINTER of BA.
			%  SETTINGS = Element.GETPROPSETTINGS(BrainAtlas, POINTER) returns settings of POINTER of BrainAtlas.
			%  SETTINGS = BA.GETPROPSETTINGS(BrainAtlas, POINTER) returns settings of POINTER of BrainAtlas.
			%
			% Note that the Element.GETPROPSETTINGS(BA) and Element.GETPROPSETTINGS('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % BrainAtlas.BR_DICT
					prop_settings = 'BrainRegion';
				case 10 % BrainAtlas.PFBA
					prop_settings = 'BrainAtlasPF';
				case 4 % BrainAtlas.TEMPLATE
					prop_settings = 'BrainAtlas';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = BrainAtlas.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainAtlas.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BA.GETPROPDEFAULT(POINTER) returns the default value of POINTER of BA.
			%  DEFAULT = Element.GETPROPDEFAULT(BrainAtlas, POINTER) returns the default value of POINTER of BrainAtlas.
			%  DEFAULT = BA.GETPROPDEFAULT(BrainAtlas, POINTER) returns the default value of POINTER of BrainAtlas.
			%
			% Note that the Element.GETPROPDEFAULT(BA) and Element.GETPROPDEFAULT('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % BrainAtlas.BR_DICT
					prop_default = Format.getFormatDefault(10, BrainAtlas.getPropSettings(prop));
				case 10 % BrainAtlas.PFBA
					prop_default = Format.getFormatDefault(8, BrainAtlas.getPropSettings(prop));
				case 1 % BrainAtlas.ELCLASS
					prop_default = 'BrainAtlas';
				case 2 % BrainAtlas.NAME
					prop_default = 'Brain Atlas';
				case 3 % BrainAtlas.DESCRIPTION
					prop_default = 'A Brain Atlas (BrainAtlas) represents a brain atlas, constituted by a collection of brain regions. BrainAtlas contains and manages brain regions inside an IndexedDictionary; thus, it has access to all IndexedDictionary methods. BrainAtlas can be imported/exported to .txt, .xls and .json files.';
				case 4 % BrainAtlas.TEMPLATE
					prop_default = Format.getFormatDefault(8, BrainAtlas.getPropSettings(prop));
				case 5 % BrainAtlas.ID
					prop_default = 'BrainAtlas ID';
				case 6 % BrainAtlas.LABEL
					prop_default = 'BrainAtlas label';
				case 7 % BrainAtlas.NOTES
					prop_default = 'BrainAtlas notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = BrainAtlas.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainAtlas.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BA.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of BA.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(BrainAtlas, POINTER) returns the conditioned default value of POINTER of BrainAtlas.
			%  DEFAULT = BA.GETPROPDEFAULTCONDITIONED(BrainAtlas, POINTER) returns the conditioned default value of POINTER of BrainAtlas.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(BA) and Element.GETPROPDEFAULTCONDITIONED('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			prop_default = BrainAtlas.conditioning(prop, BrainAtlas.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = BA.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = BA.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of BA.
			%  CHECK = Element.CHECKPROP(BrainAtlas, PROP, VALUE) checks VALUE format for PROP of BrainAtlas.
			%  CHECK = BA.CHECKPROP(BrainAtlas, PROP, VALUE) checks VALUE format for PROP of BrainAtlas.
			% 
			% BA.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:BrainAtlas:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  BA.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of BA.
			%   Error id: BRAPH2:BrainAtlas:WrongInput
			%  Element.CHECKPROP(BrainAtlas, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainAtlas.
			%   Error id: BRAPH2:BrainAtlas:WrongInput
			%  BA.CHECKPROP(BrainAtlas, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainAtlas.
			%   Error id: BRAPH2:BrainAtlas:WrongInput]
			% 
			% Note that the Element.CHECKPROP(BA) and Element.CHECKPROP('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			switch prop
				case 9 % BrainAtlas.BR_DICT
					check = Format.checkFormat(10, value, BrainAtlas.getPropSettings(prop));
				case 10 % BrainAtlas.PFBA
					check = Format.checkFormat(8, value, BrainAtlas.getPropSettings(prop));
				case 4 % BrainAtlas.TEMPLATE
					check = Format.checkFormat(8, value, BrainAtlas.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BrainAtlas:' 'WrongInput'], ...
					['BRAPH2' ':BrainAtlas:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' BrainAtlas.getPropTag(prop) ' (' BrainAtlas.getFormatTag(BrainAtlas.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(ba, prop)
			%POSTPROCESSING postprocessesing after setting.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% The postprocessing of all properties occurs each time set is called.
			%
			% See also conditioning, preset, checkProp, postset, calculateValue,
			%  checkValue.
			
			switch prop
				case 10 % BrainAtlas.PFBA
					if isa(ba.getr('PFBA'), 'NoValue')
					    ba.memorize('PFBA').set('BA', ba)
					end
					
				otherwise
					if prop <= 8
						postprocessing@ConcreteElement(ba, prop);
					end
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(ba, prop, varargin)
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
				case 9 % BrainAtlas.BR_DICT
					% % example code to use CB_TAB_EDIT
					% cb_tab_edit_code = {
					%     'switch col'
					%         'case 5'
					%             'if ~dict.get('CONTAINS_KEY', newdata)'
					%                 '' % change brain region id
					%                 'dict.get('IT', i).set(''ID'', newdata)'
					%                 '' % change brain region key in idict
					%                 'dict.get('REPLACE_KEY', dict.get('KEY', i), newdata);' % oldkey = dict.get('KEY', i)
					%             'end'
					%     'otherwise'
					%         'cb_table_edit_default()'
					%     'end'
					%     };
					pr = PanelPropIDictTable('EL', ba, 'PROP', 9, ... 
						'COLS', [-1 5 6 9 10 11 7], ...
						'ROWNAME', 'numbered', ... % 'CB_TAB_EDIT', cb_tab_edit_code, ... % example code to use CB_TAB_EDIT
					    'APPLY_TO_SELECTION', false, ...
						varargin{:});
					
				case 10 % BrainAtlas.PFBA
					pr = PanelPropItem('EL', ba, 'PROP', 10, ...
					    'GUICLASS', 'GUIFig', ...
					    'BUTTON_TEXT', 'Plot Brain Atlas', ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(ba, prop, varargin{:});
					
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
			
			uimenu(menu_import, ...
			    'Tag', 'MENU.Import.TXT', ...
			    'Label', 'Import TXT ...', ...
			    'Callback', {@cb_importer_TXT});
			function cb_importer_TXT(~, ~)
			    try
			        im = ImporterBrainAtlasTXT( ...
			            'ID', 'Import Brain Atlas from TXT', ...
			            'WAITBAR', true ...
			            ).get('GET_FILE');
			        if ~isa(im.getr('FILE'), 'NoValue')
			            ba = im.get('BA');
			            gui = GUIElement('PE', ba);
			            gui.get('DRAW')
			            gui.get('SHOW')
			        end
			    catch e
			        %TODO implement and use braph2msgbox instead of warndlg
			        warndlg(['Please, select a valid input BrainAtlas in TXT format. ' newline() ...
			            newline() ...
			            'Error message:' newline() ...
			            newline() ...
			            e.message newline()], 'Warning');
			    end
			end
			
			uimenu(menu_import, ...
			    'Tag', 'MENU.Import.XLS', ...
			    'Label', 'Import XLS ...', ...
			    'Callback', {@cb_importer_XLS});
			function cb_importer_XLS(~, ~)
			    try
			        im = ImporterBrainAtlasXLS( ...
			            'ID', 'Import Brain Atlas from XLS', ...
			            'WAITBAR', true ...
			            ).get('GET_FILE');
			        if ~isa(im.getr('FILE'), 'NoValue')
			            ba = im.get('BA');
			            gui = GUIElement('PE', ba);
			            gui.get('DRAW')
			            gui.get('SHOW')
			        end
			    catch e
			        %TODO implement and use braph2msgbox instead of warndlg
			        warndlg(['Please, select a valid input BrainAtlas in XLS format. ' newline() ...
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
			
			uimenu(menu_export, ...
			    'Tag', 'MENU.Export.TXT', ...
			    'Label', 'Export TXT ...', ...
			    'Callback', {@cb_exporter_TXT});
			function cb_exporter_TXT(~, ~)
			    ex = ExporterBrainAtlasTXT( ...
			        'ID', 'Export Brain Atlas to TXT', ...
			        'BA', el, ...
			        'WAITBAR', true ...
			        ).get('PUT_FILE');
			    if ~isa(ex.getr('FILE'), 'NoValue')
			        ex.get('SAVE');
			    end
			end
			
			uimenu(menu_export, ...
			    'Tag', 'MENU.Export.XLS', ...
			    'Label', 'Export XLS ...', ...
			    'Callback', {@cb_exporter_XLS});
			function cb_exporter_XLS(~, ~)
			    ex = ExporterBrainAtlasXLS( ...
			        'ID', 'Export Brain Atlas to XLS', ...
			        'BA', el, ...
			        'WAITBAR', true ...
			        ).get('PUT_FILE');
			    if ~isa(ex.getr('FILE'), 'NoValue')
			        ex.get('SAVE');
			    end
			end
			
		end
	end
end
