classdef BrainSurface < ConcreteElement
	%BrainSurface is a brain surface.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Brain Surface (BrainSurface) contains the information of a brain surface.
	%  It provides the methods necessary to handle the brain surface data.
	% BrainSurface contains and manages the vertex_number, coordinates, 
	%  triangles_number, and triangles of a brain surface.
	%
	% The list of BrainSurface properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the brain surface.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the brain surface.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the brain surface.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the brain surface.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the brain surface.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the brain surface.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the brain surface.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>VERTEX_NUMBER</strong> 	VERTEX_NUMBER (data, scalar) is the number of triangle vertices of the brain surface.
	%  <strong>10</strong> <strong>COORDINATES</strong> 	COORDINATES (data, matrix) are the coordinates of the triangle vertices of the brain surface.
	%  <strong>11</strong> <strong>TRIANGLES_NUMBER</strong> 	TRIANGLES_NUMBER (data, scalar) is the number of triangles of the brain surface.
	%  <strong>12</strong> <strong>TRIANGLES</strong> 	TRIANGLES (data, matrix) are the triads of coordinates of the triangles of the brain surface.
	%
	% BrainSurface methods (constructor):
	%  BrainSurface - constructor
	%
	% BrainSurface methods:
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
	% BrainSurface methods (display):
	%  tostring - string with information about the brain surface
	%  disp - displays information about the brain surface
	%  tree - displays the tree of the brain surface
	%
	% BrainSurface methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two brain surface are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the brain surface
	%
	% BrainSurface methods (save/load, Static):
	%  save - saves BRAPH2 brain surface as b2 file
	%  load - loads a BRAPH2 brain surface from a b2 file
	%
	% BrainSurface method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the brain surface
	%
	% BrainSurface method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the brain surface
	%
	% BrainSurface methods (inspection, Static):
	%  getClass - returns the class of the brain surface
	%  getSubclasses - returns all subclasses of BrainSurface
	%  getProps - returns the property list of the brain surface
	%  getPropNumber - returns the property number of the brain surface
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
	% BrainSurface methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% BrainSurface methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% BrainSurface methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% BrainSurface methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?BrainSurface; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">BrainSurface constants</a>.
	%
	%
	% See also BrainAtlas, BrainRegion, BrainSurfacePF.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		VERTEX_NUMBER = 9; %CET: Computational Efficiency Trick
		VERTEX_NUMBER_TAG = 'VERTEX_NUMBER';
		VERTEX_NUMBER_CATEGORY = 4;
		VERTEX_NUMBER_FORMAT = 11;
		
		COORDINATES = 10; %CET: Computational Efficiency Trick
		COORDINATES_TAG = 'COORDINATES';
		COORDINATES_CATEGORY = 4;
		COORDINATES_FORMAT = 14;
		
		TRIANGLES_NUMBER = 11; %CET: Computational Efficiency Trick
		TRIANGLES_NUMBER_TAG = 'TRIANGLES_NUMBER';
		TRIANGLES_NUMBER_CATEGORY = 4;
		TRIANGLES_NUMBER_FORMAT = 11;
		
		TRIANGLES = 12; %CET: Computational Efficiency Trick
		TRIANGLES_TAG = 'TRIANGLES';
		TRIANGLES_CATEGORY = 4;
		TRIANGLES_FORMAT = 14;
	end
	methods % constructor
		function bs = BrainSurface(varargin)
			%BrainSurface() creates a brain surface.
			%
			% BrainSurface(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% BrainSurface(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of BrainSurface properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the brain surface.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the brain surface.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the brain surface.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the brain surface.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the brain surface.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the brain surface.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the brain surface.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>VERTEX_NUMBER</strong> 	VERTEX_NUMBER (data, scalar) is the number of triangle vertices of the brain surface.
			%  <strong>10</strong> <strong>COORDINATES</strong> 	COORDINATES (data, matrix) are the coordinates of the triangle vertices of the brain surface.
			%  <strong>11</strong> <strong>TRIANGLES_NUMBER</strong> 	TRIANGLES_NUMBER (data, scalar) is the number of triangles of the brain surface.
			%  <strong>12</strong> <strong>TRIANGLES</strong> 	TRIANGLES (data, matrix) are the triads of coordinates of the triangles of the brain surface.
			%
			% See also Category, Format.
			
			bs = bs@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the brain surface.
			%
			% BUILD = BrainSurface.GETBUILD() returns the build of 'BrainSurface'.
			%
			% Alternative forms to call this method are:
			%  BUILD = BS.GETBUILD() returns the build of the brain surface BS.
			%  BUILD = Element.GETBUILD(BS) returns the build of 'BS'.
			%  BUILD = Element.GETBUILD('BrainSurface') returns the build of 'BrainSurface'.
			%
			% Note that the Element.GETBUILD(BS) and Element.GETBUILD('BrainSurface')
			%  are less computationally efficient.
			
			build = 1;
		end
		function bs_class = getClass()
			%GETCLASS returns the class of the brain surface.
			%
			% CLASS = BrainSurface.GETCLASS() returns the class 'BrainSurface'.
			%
			% Alternative forms to call this method are:
			%  CLASS = BS.GETCLASS() returns the class of the brain surface BS.
			%  CLASS = Element.GETCLASS(BS) returns the class of 'BS'.
			%  CLASS = Element.GETCLASS('BrainSurface') returns 'BrainSurface'.
			%
			% Note that the Element.GETCLASS(BS) and Element.GETCLASS('BrainSurface')
			%  are less computationally efficient.
			
			bs_class = 'BrainSurface';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the brain surface.
			%
			% LIST = BrainSurface.GETSUBCLASSES() returns all subclasses of 'BrainSurface'.
			%
			% Alternative forms to call this method are:
			%  LIST = BS.GETSUBCLASSES() returns all subclasses of the brain surface BS.
			%  LIST = Element.GETSUBCLASSES(BS) returns all subclasses of 'BS'.
			%  LIST = Element.GETSUBCLASSES('BrainSurface') returns all subclasses of 'BrainSurface'.
			%
			% Note that the Element.GETSUBCLASSES(BS) and Element.GETSUBCLASSES('BrainSurface')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'BrainSurface' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of brain surface.
			%
			% PROPS = BrainSurface.GETPROPS() returns the property list of brain surface
			%  as a row vector.
			%
			% PROPS = BrainSurface.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = BS.GETPROPS([CATEGORY]) returns the property list of the brain surface BS.
			%  PROPS = Element.GETPROPS(BS[, CATEGORY]) returns the property list of 'BS'.
			%  PROPS = Element.GETPROPS('BrainSurface'[, CATEGORY]) returns the property list of 'BrainSurface'.
			%
			% Note that the Element.GETPROPS(BS) and Element.GETPROPS('BrainSurface')
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
					prop_list = [5 9 10 11 12];
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of brain surface.
			%
			% N = BrainSurface.GETPROPNUMBER() returns the property number of brain surface.
			%
			% N = BrainSurface.GETPROPNUMBER(CATEGORY) returns the property number of brain surface
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = BS.GETPROPNUMBER([CATEGORY]) returns the property number of the brain surface BS.
			%  N = Element.GETPROPNUMBER(BS) returns the property number of 'BS'.
			%  N = Element.GETPROPNUMBER('BrainSurface') returns the property number of 'BrainSurface'.
			%
			% Note that the Element.GETPROPNUMBER(BS) and Element.GETPROPNUMBER('BrainSurface')
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
					prop_number = 5;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in brain surface/error.
			%
			% CHECK = BrainSurface.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BS.EXISTSPROP(PROP) checks whether PROP exists for BS.
			%  CHECK = Element.EXISTSPROP(BS, PROP) checks whether PROP exists for BS.
			%  CHECK = Element.EXISTSPROP(BrainSurface, PROP) checks whether PROP exists for BrainSurface.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:BrainSurface:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BS.EXISTSPROP(PROP) throws error if PROP does NOT exist for BS.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%  Element.EXISTSPROP(BS, PROP) throws error if PROP does NOT exist for BS.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%  Element.EXISTSPROP(BrainSurface, PROP) throws error if PROP does NOT exist for BrainSurface.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%
			% Note that the Element.EXISTSPROP(BS) and Element.EXISTSPROP('BrainSurface')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 12 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BrainSurface:' 'WrongInput'], ...
					['BRAPH2' ':BrainSurface:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for BrainSurface.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in brain surface/error.
			%
			% CHECK = BrainSurface.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BS.EXISTSTAG(TAG) checks whether TAG exists for BS.
			%  CHECK = Element.EXISTSTAG(BS, TAG) checks whether TAG exists for BS.
			%  CHECK = Element.EXISTSTAG(BrainSurface, TAG) checks whether TAG exists for BrainSurface.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:BrainSurface:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BS.EXISTSTAG(TAG) throws error if TAG does NOT exist for BS.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%  Element.EXISTSTAG(BS, TAG) throws error if TAG does NOT exist for BS.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%  Element.EXISTSTAG(BrainSurface, TAG) throws error if TAG does NOT exist for BrainSurface.
			%   Error id: [BRAPH2:BrainSurface:WrongInput]
			%
			% Note that the Element.EXISTSTAG(BS) and Element.EXISTSTAG('BrainSurface')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'VERTEX_NUMBER'  'COORDINATES'  'TRIANGLES_NUMBER'  'TRIANGLES' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BrainSurface:' 'WrongInput'], ...
					['BRAPH2' ':BrainSurface:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for BrainSurface.'] ...
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
			%  PROPERTY = BS.GETPROPPROP(POINTER) returns property number of POINTER of BS.
			%  PROPERTY = Element.GETPROPPROP(BrainSurface, POINTER) returns property number of POINTER of BrainSurface.
			%  PROPERTY = BS.GETPROPPROP(BrainSurface, POINTER) returns property number of POINTER of BrainSurface.
			%
			% Note that the Element.GETPROPPROP(BS) and Element.GETPROPPROP('BrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'VERTEX_NUMBER'  'COORDINATES'  'TRIANGLES_NUMBER'  'TRIANGLES' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = BS.GETPROPTAG(POINTER) returns tag of POINTER of BS.
			%  TAG = Element.GETPROPTAG(BrainSurface, POINTER) returns tag of POINTER of BrainSurface.
			%  TAG = BS.GETPROPTAG(BrainSurface, POINTER) returns tag of POINTER of BrainSurface.
			%
			% Note that the Element.GETPROPTAG(BS) and Element.GETPROPTAG('BrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				brainsurface_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'VERTEX_NUMBER'  'COORDINATES'  'TRIANGLES_NUMBER'  'TRIANGLES' };
				tag = brainsurface_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = BS.GETPROPCATEGORY(POINTER) returns category of POINTER of BS.
			%  CATEGORY = Element.GETPROPCATEGORY(BrainSurface, POINTER) returns category of POINTER of BrainSurface.
			%  CATEGORY = BS.GETPROPCATEGORY(BrainSurface, POINTER) returns category of POINTER of BrainSurface.
			%
			% Note that the Element.GETPROPCATEGORY(BS) and Element.GETPROPCATEGORY('BrainSurface')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			brainsurface_category_list = { 1  1  1  3  4  2  2  6  4  4  4  4 };
			prop_category = brainsurface_category_list{prop};
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
			%  FORMAT = BS.GETPROPFORMAT(POINTER) returns format of POINTER of BS.
			%  FORMAT = Element.GETPROPFORMAT(BrainSurface, POINTER) returns format of POINTER of BrainSurface.
			%  FORMAT = BS.GETPROPFORMAT(BrainSurface, POINTER) returns format of POINTER of BrainSurface.
			%
			% Note that the Element.GETPROPFORMAT(BS) and Element.GETPROPFORMAT('BrainSurface')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			brainsurface_format_list = { 2  2  2  8  2  2  2  2  11  14  11  14 };
			prop_format = brainsurface_format_list{prop};
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
			%  DESCRIPTION = BS.GETPROPDESCRIPTION(POINTER) returns description of POINTER of BS.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(BrainSurface, POINTER) returns description of POINTER of BrainSurface.
			%  DESCRIPTION = BS.GETPROPDESCRIPTION(BrainSurface, POINTER) returns description of POINTER of BrainSurface.
			%
			% Note that the Element.GETPROPDESCRIPTION(BS) and Element.GETPROPDESCRIPTION('BrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			brainsurface_description_list = { 'ELCLASS (constant, string) is the class of the brain surface.'  'NAME (constant, string) is the name of the brain surface.'  'DESCRIPTION (constant, string) is the description of the brain surface.'  'TEMPLATE (parameter, item) is the template of the brain surface.'  'ID (data, string) is a few-letter code for the brain surface.'  'LABEL (metadata, string) is an extended label of the brain surface.'  'NOTES (metadata, string) are some specific notes about the brain surface.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'VERTEX_NUMBER (data, scalar) is the number of triangle vertices of the brain surface.'  'COORDINATES (data, matrix) are the coordinates of the triangle vertices of the brain surface.'  'TRIANGLES_NUMBER (data, scalar) is the number of triangles of the brain surface.'  'TRIANGLES (data, matrix) are the triads of coordinates of the triangles of the brain surface.' };
			prop_description = brainsurface_description_list{prop};
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
			%  SETTINGS = BS.GETPROPSETTINGS(POINTER) returns settings of POINTER of BS.
			%  SETTINGS = Element.GETPROPSETTINGS(BrainSurface, POINTER) returns settings of POINTER of BrainSurface.
			%  SETTINGS = BS.GETPROPSETTINGS(BrainSurface, POINTER) returns settings of POINTER of BrainSurface.
			%
			% Note that the Element.GETPROPSETTINGS(BS) and Element.GETPROPSETTINGS('BrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % BrainSurface.VERTEX_NUMBER
					prop_settings = Format.getFormatSettings(11);
				case 10 % BrainSurface.COORDINATES
					prop_settings = Format.getFormatSettings(14);
				case 11 % BrainSurface.TRIANGLES_NUMBER
					prop_settings = Format.getFormatSettings(11);
				case 12 % BrainSurface.TRIANGLES
					prop_settings = Format.getFormatSettings(14);
				case 4 % BrainSurface.TEMPLATE
					prop_settings = 'BrainSurface';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = BrainSurface.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainSurface.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BS.GETPROPDEFAULT(POINTER) returns the default value of POINTER of BS.
			%  DEFAULT = Element.GETPROPDEFAULT(BrainSurface, POINTER) returns the default value of POINTER of BrainSurface.
			%  DEFAULT = BS.GETPROPDEFAULT(BrainSurface, POINTER) returns the default value of POINTER of BrainSurface.
			%
			% Note that the Element.GETPROPDEFAULT(BS) and Element.GETPROPDEFAULT('BrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % BrainSurface.VERTEX_NUMBER
					prop_default = Format.getFormatDefault(11, BrainSurface.getPropSettings(prop));
				case 10 % BrainSurface.COORDINATES
					prop_default = Format.getFormatDefault(14, BrainSurface.getPropSettings(prop));
				case 11 % BrainSurface.TRIANGLES_NUMBER
					prop_default = Format.getFormatDefault(11, BrainSurface.getPropSettings(prop));
				case 12 % BrainSurface.TRIANGLES
					prop_default = Format.getFormatDefault(14, BrainSurface.getPropSettings(prop));
				case 1 % BrainSurface.ELCLASS
					prop_default = 'BrainSurface';
				case 2 % BrainSurface.NAME
					prop_default = 'Brain Surface';
				case 3 % BrainSurface.DESCRIPTION
					prop_default = 'A Brain Surface (BrainSurface) contains the information of a brain surface. It provides the methods necessary to handle the brain surface data. BrainSurface contains and manages the vertex_number, coordinates, triangles_number, and triangles of a brain surface.';
				case 4 % BrainSurface.TEMPLATE
					prop_default = Format.getFormatDefault(8, BrainSurface.getPropSettings(prop));
				case 5 % BrainSurface.ID
					prop_default = 'BrainSurface ID';
				case 6 % BrainSurface.LABEL
					prop_default = 'BrainSurface label';
				case 7 % BrainSurface.NOTES
					prop_default = 'BrainSurface notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = BrainSurface.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainSurface.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BS.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of BS.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(BrainSurface, POINTER) returns the conditioned default value of POINTER of BrainSurface.
			%  DEFAULT = BS.GETPROPDEFAULTCONDITIONED(BrainSurface, POINTER) returns the conditioned default value of POINTER of BrainSurface.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(BS) and Element.GETPROPDEFAULTCONDITIONED('BrainSurface')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = BrainSurface.getPropProp(pointer);
			
			prop_default = BrainSurface.conditioning(prop, BrainSurface.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = BS.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = BS.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of BS.
			%  CHECK = Element.CHECKPROP(BrainSurface, PROP, VALUE) checks VALUE format for PROP of BrainSurface.
			%  CHECK = BS.CHECKPROP(BrainSurface, PROP, VALUE) checks VALUE format for PROP of BrainSurface.
			% 
			% BS.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:BrainSurface:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  BS.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of BS.
			%   Error id: BRAPH2:BrainSurface:WrongInput
			%  Element.CHECKPROP(BrainSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainSurface.
			%   Error id: BRAPH2:BrainSurface:WrongInput
			%  BS.CHECKPROP(BrainSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainSurface.
			%   Error id: BRAPH2:BrainSurface:WrongInput]
			% 
			% Note that the Element.CHECKPROP(BS) and Element.CHECKPROP('BrainSurface')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = BrainSurface.getPropProp(pointer);
			
			switch prop
				case 9 % BrainSurface.VERTEX_NUMBER
					check = Format.checkFormat(11, value, BrainSurface.getPropSettings(prop));
					if check
						check = value >= 0;
					end
				case 10 % BrainSurface.COORDINATES
					check = Format.checkFormat(14, value, BrainSurface.getPropSettings(prop));
					if check
						check = isempty(value) || size(value, 2) == 3;
					end
				case 11 % BrainSurface.TRIANGLES_NUMBER
					check = Format.checkFormat(11, value, BrainSurface.getPropSettings(prop));
					if check
						check = value >= 0;
					end
				case 12 % BrainSurface.TRIANGLES
					check = Format.checkFormat(14, value, BrainSurface.getPropSettings(prop));
					if check
						check = isempty(value) || size(value, 2) == 3;
					end
				case 4 % BrainSurface.TEMPLATE
					check = Format.checkFormat(8, value, BrainSurface.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BrainSurface:' 'WrongInput'], ...
					['BRAPH2' ':BrainSurface:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' BrainSurface.getPropTag(prop) ' (' BrainSurface.getFormatTag(BrainSurface.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(bs, prop, value)
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
			msg = ['Error while checking ' tostring(bs) ' ' bs.getPropTag(prop) '.'];
			
			switch prop
				case 10 % BrainSurface.COORDINATES
					check = isequal(bs.get('VERTEX_NUMBER'), size(value, 1));
					if check 
					    msg = 'All ok!';
					else
					    msg = ['COORDINATES must have VERTEX_NUMBER (' num2str(bs.get('VERTEX_NUMBER')) ') columns while it has ' num2str(size(value, 2)) '.'];
					end
					
				case 12 % BrainSurface.TRIANGLES
					check = isequal(bs.get('TRIANGLES_NUMBER'), size(value, 1)) && all(all(value > 0)) && all(all(value <= bs.get('VERTEX_NUMBER')));
					if check 
					    msg = 'All ok!';
					else
					    msg = [ ...
					        'TRIANGLES must have ' num2str(bs.get('TRIANGLES_NUMBER')) ' columns while it has ' num2str(size(value, 1)) '.' ...
					        'The identifiers in TRIANGLES must be greater than 0 and smaller or equal to the VERTEX_NUMBER (' num2str(bs.get('VERTEX_NUMBER')) ') ' ...
					        'while they are ' num2str(value) '.' ...
					        ];
					end
					
				otherwise
					if prop <= 8
						[check, msg] = checkValue@ConcreteElement(bs, prop, value);
					end
			end
		end
	end
end
