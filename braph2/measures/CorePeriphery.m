classdef CorePeriphery < Richness
	%CorePeriphery is the graph Core-Periphery.
	% It is a subclass of <a href="matlab:help Richness">Richness</a>.
	%
	% The Core-Periphery (CorePeriphery) of a node is the value of the rank corresponding 
	% to the maximum richness nodes. It returns 1 for a node belonging to the 
	% core and zero otherwise.
	%
	% The list of CorePeriphery properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Core-Periphery.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Core-Periphery.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Core-Periphery.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Core-Periphery.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Core-Periphery.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Core-Periphery.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Core-Periphery.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Core-Periphery.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%
	% CorePeriphery methods (constructor):
	%  CorePeriphery - constructor
	%
	% CorePeriphery methods:
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
	% CorePeriphery methods (display):
	%  tostring - string with information about the core-periphery
	%  disp - displays information about the core-periphery
	%  tree - displays the tree of the core-periphery
	%
	% CorePeriphery methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two core-periphery are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the core-periphery
	%
	% CorePeriphery methods (save/load, Static):
	%  save - saves BRAPH2 core-periphery as b2 file
	%  load - loads a BRAPH2 core-periphery from a b2 file
	%
	% CorePeriphery method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the core-periphery
	%
	% CorePeriphery method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the core-periphery
	%
	% CorePeriphery methods (inspection, Static):
	%  getClass - returns the class of the core-periphery
	%  getSubclasses - returns all subclasses of CorePeriphery
	%  getProps - returns the property list of the core-periphery
	%  getPropNumber - returns the property number of the core-periphery
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
	% CorePeriphery methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% CorePeriphery methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% CorePeriphery methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% CorePeriphery methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?CorePeriphery; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">CorePeriphery constants</a>.
	%
	
	methods % constructor
		function m = CorePeriphery(varargin)
			%CorePeriphery() creates a core-periphery.
			%
			% CorePeriphery(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% CorePeriphery(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of CorePeriphery properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Core-Periphery.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Core-Periphery.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Core-Periphery.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Core-Periphery.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Core-Periphery.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Core-Periphery.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Core-Periphery.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Core-Periphery.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%
			% See also Category, Format.
			
			m = m@Richness(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the core-periphery.
			%
			% BUILD = CorePeriphery.GETBUILD() returns the build of 'CorePeriphery'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the core-periphery M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('CorePeriphery') returns the build of 'CorePeriphery'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('CorePeriphery')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the core-periphery.
			%
			% CLASS = CorePeriphery.GETCLASS() returns the class 'CorePeriphery'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the core-periphery M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('CorePeriphery') returns 'CorePeriphery'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('CorePeriphery')
			%  are less computationally efficient.
			
			m_class = 'CorePeriphery';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the core-periphery.
			%
			% LIST = CorePeriphery.GETSUBCLASSES() returns all subclasses of 'CorePeriphery'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the core-periphery M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('CorePeriphery') returns all subclasses of 'CorePeriphery'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('CorePeriphery')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'CorePeriphery' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of core-periphery.
			%
			% PROPS = CorePeriphery.GETPROPS() returns the property list of core-periphery
			%  as a row vector.
			%
			% PROPS = CorePeriphery.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the core-periphery M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('CorePeriphery'[, CATEGORY]) returns the property list of 'CorePeriphery'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('CorePeriphery')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3 9 10 11 12];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 13];
				case 5 % Category.RESULT
					prop_list = 14;
				case 6 % Category.QUERY
					prop_list = 8;
				case 9 % Category.GUI
					prop_list = 15;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of core-periphery.
			%
			% N = CorePeriphery.GETPROPNUMBER() returns the property number of core-periphery.
			%
			% N = CorePeriphery.GETPROPNUMBER(CATEGORY) returns the property number of core-periphery
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the core-periphery M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('CorePeriphery') returns the property number of 'CorePeriphery'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('CorePeriphery')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 15;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 7;
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
			%EXISTSPROP checks whether property exists in core-periphery/error.
			%
			% CHECK = CorePeriphery.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(CorePeriphery, PROP) checks whether PROP exists for CorePeriphery.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:CorePeriphery:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:CorePeriphery:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:CorePeriphery:WrongInput]
			%  Element.EXISTSPROP(CorePeriphery, PROP) throws error if PROP does NOT exist for CorePeriphery.
			%   Error id: [BRAPH2:CorePeriphery:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('CorePeriphery')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 15 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CorePeriphery:' 'WrongInput'], ...
					['BRAPH2' ':CorePeriphery:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for CorePeriphery.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in core-periphery/error.
			%
			% CHECK = CorePeriphery.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(CorePeriphery, TAG) checks whether TAG exists for CorePeriphery.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:CorePeriphery:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:CorePeriphery:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:CorePeriphery:WrongInput]
			%  Element.EXISTSTAG(CorePeriphery, TAG) throws error if TAG does NOT exist for CorePeriphery.
			%   Error id: [BRAPH2:CorePeriphery:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('CorePeriphery')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CorePeriphery:' 'WrongInput'], ...
					['BRAPH2' ':CorePeriphery:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for CorePeriphery.'] ...
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
			%  PROPERTY = M.GETPROPPROP(POINTER) returns property number of POINTER of M.
			%  PROPERTY = Element.GETPROPPROP(CorePeriphery, POINTER) returns property number of POINTER of CorePeriphery.
			%  PROPERTY = M.GETPROPPROP(CorePeriphery, POINTER) returns property number of POINTER of CorePeriphery.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('CorePeriphery')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = M.GETPROPTAG(POINTER) returns tag of POINTER of M.
			%  TAG = Element.GETPROPTAG(CorePeriphery, POINTER) returns tag of POINTER of CorePeriphery.
			%  TAG = M.GETPROPTAG(CorePeriphery, POINTER) returns tag of POINTER of CorePeriphery.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('CorePeriphery')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				coreperiphery_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' };
				tag = coreperiphery_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = M.GETPROPCATEGORY(POINTER) returns category of POINTER of M.
			%  CATEGORY = Element.GETPROPCATEGORY(CorePeriphery, POINTER) returns category of POINTER of CorePeriphery.
			%  CATEGORY = M.GETPROPCATEGORY(CorePeriphery, POINTER) returns category of POINTER of CorePeriphery.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('CorePeriphery')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = CorePeriphery.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			coreperiphery_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9 };
			prop_category = coreperiphery_category_list{prop};
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
			%  FORMAT = M.GETPROPFORMAT(POINTER) returns format of POINTER of M.
			%  FORMAT = Element.GETPROPFORMAT(CorePeriphery, POINTER) returns format of POINTER of CorePeriphery.
			%  FORMAT = M.GETPROPFORMAT(CorePeriphery, POINTER) returns format of POINTER of CorePeriphery.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('CorePeriphery')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = CorePeriphery.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			coreperiphery_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8 };
			prop_format = coreperiphery_format_list{prop};
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
			%  DESCRIPTION = M.GETPROPDESCRIPTION(POINTER) returns description of POINTER of M.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CorePeriphery, POINTER) returns description of POINTER of CorePeriphery.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(CorePeriphery, POINTER) returns description of POINTER of CorePeriphery.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('CorePeriphery')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = CorePeriphery.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			coreperiphery_description_list = { 'ELCLASS (constant, string) is the class of the Core-Periphery.'  'NAME (constant, string) is the name of the Core-Periphery.'  'DESCRIPTION (constant, string) is the description of the Core-Periphery.'  'TEMPLATE (parameter, item) is the template of the Core-Periphery.'  'ID (data, string) is a few-letter code of the Core-Periphery.'  'LABEL (metadata, string) is an extended label of the Core-Periphery.'  'NOTES (metadata, string) are some specific notes about the Core-Periphery.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Core-Periphery.'  'PFM (gui, item) contains the panel figure of the measure.' };
			prop_description = coreperiphery_description_list{prop};
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
			%  SETTINGS = M.GETPROPSETTINGS(POINTER) returns settings of POINTER of M.
			%  SETTINGS = Element.GETPROPSETTINGS(CorePeriphery, POINTER) returns settings of POINTER of CorePeriphery.
			%  SETTINGS = M.GETPROPSETTINGS(CorePeriphery, POINTER) returns settings of POINTER of CorePeriphery.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('CorePeriphery')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = CorePeriphery.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % CorePeriphery.TEMPLATE
					prop_settings = 'CorePeriphery';
				otherwise
					prop_settings = getPropSettings@Richness(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = CorePeriphery.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = CorePeriphery.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(CorePeriphery, POINTER) returns the default value of POINTER of CorePeriphery.
			%  DEFAULT = M.GETPROPDEFAULT(CorePeriphery, POINTER) returns the default value of POINTER of CorePeriphery.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('CorePeriphery')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CorePeriphery.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % CorePeriphery.ELCLASS
					prop_default = 'CorePeriphery';
				case 2 % CorePeriphery.NAME
					prop_default = 'Core-Periphery';
				case 3 % CorePeriphery.DESCRIPTION
					prop_default = 'The Core-Periphery (CorePeriphery) of a node is the value of the rank corresponding to the maximum richness nodes. It returns 1 for a node belonging to the core and zero otherwise.';
				case 4 % CorePeriphery.TEMPLATE
					prop_default = Format.getFormatDefault(8, CorePeriphery.getPropSettings(prop));
				case 5 % CorePeriphery.ID
					prop_default = 'CorePeriphery ID';
				case 6 % CorePeriphery.LABEL
					prop_default = 'Core-Periphery label';
				case 7 % CorePeriphery.NOTES
					prop_default = 'Core-Periphery notes';
				case 9 % CorePeriphery.SHAPE
					prop_default = 2;
				case 10 % CorePeriphery.SCOPE
					prop_default = 2;
				case 11 % CorePeriphery.PARAMETRICITY
					prop_default = 2;
				case 12 % CorePeriphery.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT' 'MultilayerWD' 'OrdMlWD'} ;;
				otherwise
					prop_default = getPropDefault@Richness(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = CorePeriphery.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = CorePeriphery.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(CorePeriphery, POINTER) returns the conditioned default value of POINTER of CorePeriphery.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(CorePeriphery, POINTER) returns the conditioned default value of POINTER of CorePeriphery.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('CorePeriphery')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = CorePeriphery.getPropProp(pointer);
			
			prop_default = CorePeriphery.conditioning(prop, CorePeriphery.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = M.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = M.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of M.
			%  CHECK = Element.CHECKPROP(CorePeriphery, PROP, VALUE) checks VALUE format for PROP of CorePeriphery.
			%  CHECK = M.CHECKPROP(CorePeriphery, PROP, VALUE) checks VALUE format for PROP of CorePeriphery.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:CorePeriphery:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:CorePeriphery:WrongInput
			%  Element.CHECKPROP(CorePeriphery, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CorePeriphery.
			%   Error id: BRAPH2:CorePeriphery:WrongInput
			%  M.CHECKPROP(CorePeriphery, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CorePeriphery.
			%   Error id: BRAPH2:CorePeriphery:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('CorePeriphery')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = CorePeriphery.getPropProp(pointer);
			
			switch prop
				case 4 % CorePeriphery.TEMPLATE
					check = Format.checkFormat(8, value, CorePeriphery.getPropSettings(prop));
				otherwise
					if prop <= 15
						check = checkProp@Richness(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CorePeriphery:' 'WrongInput'], ...
					['BRAPH2' ':CorePeriphery:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' CorePeriphery.getPropTag(prop) ' (' CorePeriphery.getFormatTag(CorePeriphery.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop, varargin)
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
				case 14 % CorePeriphery.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					richness = calculateValue@Richness(m, prop);
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					
					if L == 0
					    value = {};
					else
					    directionality_layer =  g.get('DIRECTIONALITY_TYPE', L);
					    connectivity_layer =  g.get('CONNECTIVITY_TYPE', L);
					    core_periphery = cell(L, 1);
					    
					    for li = 1:1:L
					        core_periphery_partition = zeros(N(1), 1);
					        
					        if connectivity_layer == 1  % weighted graphs
					            if directionality_layer == 2  % undirected graphs
					                
					                strength = Strength('G', g).get('M');
					                deg = strength{li};
					                
					            else  % directed graphs
					                
					                in_strength = StrengthIn('G', g).get('M');
					                out_strength = StrengthOut('G', g).get('M');
					                deg = (in_strength{li} + out_strength{li})/2;
					            end
					            
					        else  % binary graphs
					            if directionality_layer == 2  % undirected graphs
					                
					                degree = Degree('G', g).get('M');
					                deg = degree{li};
					                
					            else  % directed graphs
					                
					                in_degree = DegreeIn('G', g).get('M');
					                out_degree = DegreeOut('G', g).get('M');
					                deg = (in_degree{li} + out_degree{li})/2;
					            end
					        end
					        
					        [~, rankingInd] = sort(deg, 'descend');
					        richness_partition = richness{li};
					        [~, rankOfMaxRichness] = max(richness_partition(rankingInd), [], 'all');  
					        core_periphery_partition(rankingInd(1:rankOfMaxRichness)) = 1;
					        core_periphery(li) = {core_periphery_partition};
					    end
					    value = core_periphery;
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 15
						value = calculateValue@Richness(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
