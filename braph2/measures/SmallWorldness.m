classdef SmallWorldness < PathLengthAv
	%SmallWorldness is the graph Small-Worldness.
	% It is a subclass of <a href="matlab:help PathLengthAv">PathLengthAv</a>.
	%
	% The Small-Worldness (SmallWorldness) coefficient is the fraction of the clustering coefficient 
	%   and average path length of each layer and the clustering coefficient and 
	%   average path length of 100 random graphs.
	%
	% The list of SmallWorldness properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Small-Worldness.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Small-Worldness.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Small-Worldness.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Small-Worldness.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Small-Worldness.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Small-Worldness.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Small-Worldness.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Small-Worldness.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>16</strong> <strong>RULE</strong> 	RULE (parameter, option) is the pathlength algorithm
	%
	% SmallWorldness methods (constructor):
	%  SmallWorldness - constructor
	%
	% SmallWorldness methods:
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
	% SmallWorldness methods (display):
	%  tostring - string with information about the small-worldness
	%  disp - displays information about the small-worldness
	%  tree - displays the tree of the small-worldness
	%
	% SmallWorldness methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two small-worldness are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the small-worldness
	%
	% SmallWorldness methods (save/load, Static):
	%  save - saves BRAPH2 small-worldness as b2 file
	%  load - loads a BRAPH2 small-worldness from a b2 file
	%
	% SmallWorldness method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the small-worldness
	%
	% SmallWorldness method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the small-worldness
	%
	% SmallWorldness methods (inspection, Static):
	%  getClass - returns the class of the small-worldness
	%  getSubclasses - returns all subclasses of SmallWorldness
	%  getProps - returns the property list of the small-worldness
	%  getPropNumber - returns the property number of the small-worldness
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
	% SmallWorldness methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SmallWorldness methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SmallWorldness methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SmallWorldness methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SmallWorldness; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SmallWorldness constants</a>.
	%
	
	methods % constructor
		function m = SmallWorldness(varargin)
			%SmallWorldness() creates a small-worldness.
			%
			% SmallWorldness(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SmallWorldness(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SmallWorldness properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Small-Worldness.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Small-Worldness.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Small-Worldness.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Small-Worldness.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Small-Worldness.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Small-Worldness.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Small-Worldness.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Small-Worldness.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>16</strong> <strong>RULE</strong> 	RULE (parameter, option) is the pathlength algorithm
			%
			% See also Category, Format.
			
			m = m@PathLengthAv(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the small-worldness.
			%
			% BUILD = SmallWorldness.GETBUILD() returns the build of 'SmallWorldness'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the small-worldness M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('SmallWorldness') returns the build of 'SmallWorldness'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('SmallWorldness')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the small-worldness.
			%
			% CLASS = SmallWorldness.GETCLASS() returns the class 'SmallWorldness'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the small-worldness M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('SmallWorldness') returns 'SmallWorldness'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('SmallWorldness')
			%  are less computationally efficient.
			
			m_class = 'SmallWorldness';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the small-worldness.
			%
			% LIST = SmallWorldness.GETSUBCLASSES() returns all subclasses of 'SmallWorldness'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the small-worldness M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('SmallWorldness') returns all subclasses of 'SmallWorldness'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('SmallWorldness')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SmallWorldness' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of small-worldness.
			%
			% PROPS = SmallWorldness.GETPROPS() returns the property list of small-worldness
			%  as a row vector.
			%
			% PROPS = SmallWorldness.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the small-worldness M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('SmallWorldness'[, CATEGORY]) returns the property list of 'SmallWorldness'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('SmallWorldness')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3 9 10 11 12];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 16];
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
			%GETPROPNUMBER returns the property number of small-worldness.
			%
			% N = SmallWorldness.GETPROPNUMBER() returns the property number of small-worldness.
			%
			% N = SmallWorldness.GETPROPNUMBER(CATEGORY) returns the property number of small-worldness
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the small-worldness M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('SmallWorldness') returns the property number of 'SmallWorldness'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('SmallWorldness')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 16;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 7;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 2;
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
			%EXISTSPROP checks whether property exists in small-worldness/error.
			%
			% CHECK = SmallWorldness.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(SmallWorldness, PROP) checks whether PROP exists for SmallWorldness.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SmallWorldness:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:SmallWorldness:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:SmallWorldness:WrongInput]
			%  Element.EXISTSPROP(SmallWorldness, PROP) throws error if PROP does NOT exist for SmallWorldness.
			%   Error id: [BRAPH2:SmallWorldness:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('SmallWorldness')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 16 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SmallWorldness:' 'WrongInput'], ...
					['BRAPH2' ':SmallWorldness:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SmallWorldness.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in small-worldness/error.
			%
			% CHECK = SmallWorldness.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(SmallWorldness, TAG) checks whether TAG exists for SmallWorldness.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SmallWorldness:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:SmallWorldness:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:SmallWorldness:WrongInput]
			%  Element.EXISTSTAG(SmallWorldness, TAG) throws error if TAG does NOT exist for SmallWorldness.
			%   Error id: [BRAPH2:SmallWorldness:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('SmallWorldness')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SmallWorldness:' 'WrongInput'], ...
					['BRAPH2' ':SmallWorldness:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SmallWorldness.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SmallWorldness, POINTER) returns property number of POINTER of SmallWorldness.
			%  PROPERTY = M.GETPROPPROP(SmallWorldness, POINTER) returns property number of POINTER of SmallWorldness.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('SmallWorldness')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(SmallWorldness, POINTER) returns tag of POINTER of SmallWorldness.
			%  TAG = M.GETPROPTAG(SmallWorldness, POINTER) returns tag of POINTER of SmallWorldness.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('SmallWorldness')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				smallworldness_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE' };
				tag = smallworldness_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(SmallWorldness, POINTER) returns category of POINTER of SmallWorldness.
			%  CATEGORY = M.GETPROPCATEGORY(SmallWorldness, POINTER) returns category of POINTER of SmallWorldness.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('SmallWorldness')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SmallWorldness.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			smallworldness_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3 };
			prop_category = smallworldness_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(SmallWorldness, POINTER) returns format of POINTER of SmallWorldness.
			%  FORMAT = M.GETPROPFORMAT(SmallWorldness, POINTER) returns format of POINTER of SmallWorldness.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('SmallWorldness')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SmallWorldness.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			smallworldness_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  5 };
			prop_format = smallworldness_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SmallWorldness, POINTER) returns description of POINTER of SmallWorldness.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(SmallWorldness, POINTER) returns description of POINTER of SmallWorldness.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('SmallWorldness')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SmallWorldness.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			smallworldness_description_list = { 'ELCLASS (constant, string) is the class of the Small-Worldness.'  'NAME (constant, string) is the name of the Small-Worldness.'  'DESCRIPTION (constant, string) is the description of the Small-Worldness.'  'TEMPLATE (parameter, item) is the template of the Small-Worldness.'  'ID (data, string) is a few-letter code of the Small-Worldness.'  'LABEL (metadata, string) is an extended label of the Small-Worldness.'  'NOTES (metadata, string) are some specific notes about the Small-Worldness.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Small-Worldness.'  'PFM (gui, item) contains the panel figure of the measure.'  'RULE (parameter, option) is the pathlength algorithm' };
			prop_description = smallworldness_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(SmallWorldness, POINTER) returns settings of POINTER of SmallWorldness.
			%  SETTINGS = M.GETPROPSETTINGS(SmallWorldness, POINTER) returns settings of POINTER of SmallWorldness.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('SmallWorldness')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SmallWorldness.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % SmallWorldness.TEMPLATE
					prop_settings = 'SmallWorldness';
				otherwise
					prop_settings = getPropSettings@PathLengthAv(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SmallWorldness.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SmallWorldness.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(SmallWorldness, POINTER) returns the default value of POINTER of SmallWorldness.
			%  DEFAULT = M.GETPROPDEFAULT(SmallWorldness, POINTER) returns the default value of POINTER of SmallWorldness.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('SmallWorldness')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SmallWorldness.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % SmallWorldness.ELCLASS
					prop_default = 'SmallWorldness';
				case 2 % SmallWorldness.NAME
					prop_default = 'Small-Worldness';
				case 3 % SmallWorldness.DESCRIPTION
					prop_default = 'The Small-Worldness (SmallWorldness) coefficient is the fraction of the clustering coefficient and average path length of each layer and the clustering coefficient and average path length of 100 random graphs.';
				case 4 % SmallWorldness.TEMPLATE
					prop_default = Format.getFormatDefault(8, SmallWorldness.getPropSettings(prop));
				case 5 % SmallWorldness.ID
					prop_default = 'SmallWorldness ID';
				case 6 % SmallWorldness.LABEL
					prop_default = 'Small-Worldness label';
				case 7 % SmallWorldness.NOTES
					prop_default = 'Small-Worldness notes';
				case 9 % SmallWorldness.SHAPE
					prop_default = 1;
				case 10 % SmallWorldness.SCOPE
					prop_default = 2;
				case 11 % SmallWorldness.PARAMETRICITY
					prop_default = 2;
				otherwise
					prop_default = getPropDefault@PathLengthAv(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SmallWorldness.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SmallWorldness.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SmallWorldness, POINTER) returns the conditioned default value of POINTER of SmallWorldness.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(SmallWorldness, POINTER) returns the conditioned default value of POINTER of SmallWorldness.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('SmallWorldness')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SmallWorldness.getPropProp(pointer);
			
			prop_default = SmallWorldness.conditioning(prop, SmallWorldness.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SmallWorldness, PROP, VALUE) checks VALUE format for PROP of SmallWorldness.
			%  CHECK = M.CHECKPROP(SmallWorldness, PROP, VALUE) checks VALUE format for PROP of SmallWorldness.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SmallWorldness:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:SmallWorldness:WrongInput
			%  Element.CHECKPROP(SmallWorldness, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SmallWorldness.
			%   Error id: BRAPH2:SmallWorldness:WrongInput
			%  M.CHECKPROP(SmallWorldness, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SmallWorldness.
			%   Error id: BRAPH2:SmallWorldness:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('SmallWorldness')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SmallWorldness.getPropProp(pointer);
			
			switch prop
				case 4 % SmallWorldness.TEMPLATE
					check = Format.checkFormat(8, value, SmallWorldness.getPropSettings(prop));
				otherwise
					if prop <= 16
						check = checkProp@PathLengthAv(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SmallWorldness:' 'WrongInput'], ...
					['BRAPH2' ':SmallWorldness:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SmallWorldness.getPropTag(prop) ' (' SmallWorldness.getFormatTag(SmallWorldness.getPropFormat(prop)) ').'] ...
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
				case 14 % SmallWorldness.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G');  % graph from measure class
					if isempty(g.get('A'))
					    value = {};
					    return;
					end
					L = g.get('LAYERNUMBER');
					path_length_rule = m.get('RULE');
					clustering_av = ClusteringAv('G', g).get('M');
					path_length_av = calculateValue@PathLengthAv(m, prop);
					
					M = 100;  % number of random graphs
					clustering_av_random = cell(1, M);
					path_length_av_random = cell(1, M);
					for r = 1:1:M
					    tmp_b = g.get('B'); %#ok<NASGU>
					    g_random = eval([g.getClass() '(''B'', tmp_b, ''TEMPLATE'', g)']);
					    g_random.set('RANDOMIZE', true);
					
					    clustering_av_random(r) = {ClusteringAv('G', g_random).get('M')};
					    path_length_av_random(r) = {PathLengthAv('G', g_random, 'RULE', path_length_rule).get('M')}; 
					    
					end
					path_length_av_random = cellfun(@(x) cell2mat(x), path_length_av_random, 'UniformOutput', false);
					clustering_av_random = cellfun(@(x) cell2mat(x), clustering_av_random, 'UniformOutput', false);
					path_length_av_random = cell2mat(path_length_av_random);
					clustering_av_random = cell2mat(clustering_av_random);
					path_length_av_random = mean(path_length_av_random, 2);
					clustering_av_random = mean(clustering_av_random, 2);
					
					small_worldness = cell(L, 1);
					for li = 1:1:L
					    small_worldness_layer = (clustering_av{li}/clustering_av_random(li)) / (path_length_av{li}/ path_length_av_random(li));
					    small_worldness_layer(isnan(small_worldness_layer)) = 0;  % node NaN corresponds to 0/0 or Inf/Inf from path length (disconnected nodes)
					    small_worldness(li) = {small_worldness_layer};
					end
					
					value = small_worldness;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 16
						value = calculateValue@PathLengthAv(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
