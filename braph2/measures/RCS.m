classdef RCS < Strength
	%RCS is the graph Rich-Club Strength.
	% It is a subclass of <a href="matlab:help Strength">Strength</a>.
	%
	% The Rich-Club Strength (RCS) of a node at level PARAMETRIC_VALUE is the sum of the weighted edges 
	%  that connect nodes of strength s or higher within a layer. 
	%  PARAMETRIC_VALUE is set by the user and it can be a vector containing all the strength thresholds 
	%  the default value is equal to 1.
	%
	% The list of RCS properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Rich-Club Strength.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Rich-Club Strength.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Rich-Club Strength.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Rich-Club Strength.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Rich-Club Strength.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Rich-Club Strength.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Rich-Club Strength.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.PARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Rich-Club Strength.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>16</strong> <strong>PARAMETRIC_VALUE</strong> 	PARAMETRIC_VALUE (parameter, RVECTOR) is the strength level.
	%
	% RCS methods (constructor):
	%  RCS - constructor
	%
	% RCS methods:
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
	% RCS methods (display):
	%  tostring - string with information about the rich-club strength
	%  disp - displays information about the rich-club strength
	%  tree - displays the tree of the rich-club strength
	%
	% RCS methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two rich-club strength are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the rich-club strength
	%
	% RCS methods (save/load, Static):
	%  save - saves BRAPH2 rich-club strength as b2 file
	%  load - loads a BRAPH2 rich-club strength from a b2 file
	%
	% RCS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the rich-club strength
	%
	% RCS method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the rich-club strength
	%
	% RCS methods (inspection, Static):
	%  getClass - returns the class of the rich-club strength
	%  getSubclasses - returns all subclasses of RCS
	%  getProps - returns the property list of the rich-club strength
	%  getPropNumber - returns the property number of the rich-club strength
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
	% RCS methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% RCS methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% RCS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% RCS methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?RCS; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">RCS constants</a>.
	%
	
	properties (Constant) % properties
		PARAMETRIC_VALUE = 16; %CET: Computational Efficiency Trick
		PARAMETRIC_VALUE_TAG = 'PARAMETRIC_VALUE';
		PARAMETRIC_VALUE_CATEGORY = 3;
		PARAMETRIC_VALUE_FORMAT = 12;
	end
	methods % constructor
		function m = RCS(varargin)
			%RCS() creates a rich-club strength.
			%
			% RCS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% RCS(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of RCS properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Rich-Club Strength.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Rich-Club Strength.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Rich-Club Strength.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Rich-Club Strength.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Rich-Club Strength.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Rich-Club Strength.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Rich-Club Strength.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.PARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Rich-Club Strength.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>16</strong> <strong>PARAMETRIC_VALUE</strong> 	PARAMETRIC_VALUE (parameter, RVECTOR) is the strength level.
			%
			% See also Category, Format.
			
			m = m@Strength(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the rich-club strength.
			%
			% BUILD = RCS.GETBUILD() returns the build of 'RCS'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the rich-club strength M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('RCS') returns the build of 'RCS'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('RCS')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the rich-club strength.
			%
			% CLASS = RCS.GETCLASS() returns the class 'RCS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the rich-club strength M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('RCS') returns 'RCS'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('RCS')
			%  are less computationally efficient.
			
			m_class = 'RCS';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the rich-club strength.
			%
			% LIST = RCS.GETSUBCLASSES() returns all subclasses of 'RCS'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the rich-club strength M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('RCS') returns all subclasses of 'RCS'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('RCS')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'RCS'  'MultiplexRCS' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of rich-club strength.
			%
			% PROPS = RCS.GETPROPS() returns the property list of rich-club strength
			%  as a row vector.
			%
			% PROPS = RCS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the rich-club strength M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('RCS'[, CATEGORY]) returns the property list of 'RCS'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('RCS')
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
			%GETPROPNUMBER returns the property number of rich-club strength.
			%
			% N = RCS.GETPROPNUMBER() returns the property number of rich-club strength.
			%
			% N = RCS.GETPROPNUMBER(CATEGORY) returns the property number of rich-club strength
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the rich-club strength M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('RCS') returns the property number of 'RCS'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('RCS')
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
			%EXISTSPROP checks whether property exists in rich-club strength/error.
			%
			% CHECK = RCS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(RCS, PROP) checks whether PROP exists for RCS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:RCS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:RCS:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:RCS:WrongInput]
			%  Element.EXISTSPROP(RCS, PROP) throws error if PROP does NOT exist for RCS.
			%   Error id: [BRAPH2:RCS:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('RCS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 16 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':RCS:' 'WrongInput'], ...
					['BRAPH2' ':RCS:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for RCS.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in rich-club strength/error.
			%
			% CHECK = RCS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(RCS, TAG) checks whether TAG exists for RCS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:RCS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:RCS:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:RCS:WrongInput]
			%  Element.EXISTSTAG(RCS, TAG) throws error if TAG does NOT exist for RCS.
			%   Error id: [BRAPH2:RCS:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('RCS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'PARAMETRIC_VALUE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':RCS:' 'WrongInput'], ...
					['BRAPH2' ':RCS:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for RCS.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(RCS, POINTER) returns property number of POINTER of RCS.
			%  PROPERTY = M.GETPROPPROP(RCS, POINTER) returns property number of POINTER of RCS.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('RCS')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'PARAMETRIC_VALUE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(RCS, POINTER) returns tag of POINTER of RCS.
			%  TAG = M.GETPROPTAG(RCS, POINTER) returns tag of POINTER of RCS.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('RCS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				rcs_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'PARAMETRIC_VALUE' };
				tag = rcs_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(RCS, POINTER) returns category of POINTER of RCS.
			%  CATEGORY = M.GETPROPCATEGORY(RCS, POINTER) returns category of POINTER of RCS.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('RCS')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = RCS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			rcs_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3 };
			prop_category = rcs_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(RCS, POINTER) returns format of POINTER of RCS.
			%  FORMAT = M.GETPROPFORMAT(RCS, POINTER) returns format of POINTER of RCS.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('RCS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = RCS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			rcs_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  12 };
			prop_format = rcs_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(RCS, POINTER) returns description of POINTER of RCS.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(RCS, POINTER) returns description of POINTER of RCS.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('RCS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = RCS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			rcs_description_list = { 'ELCLASS (constant, string) is the class of the Rich-Club Strength.'  'NAME (constant, string) is the name of the Rich-Club Strength.'  'DESCRIPTION (constant, string) is the description of the Rich-Club Strength.'  'TEMPLATE (parameter, item) is the template of the Rich-Club Strength.'  'ID (data, string) is a few-letter code of the Rich-Club Strength.'  'LABEL (metadata, string) is an extended label of the Rich-Club Strength.'  'NOTES (metadata, string) are some specific notes about the Rich-Club Strength.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.PARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Rich-Club Strength.'  'PFM (gui, item) contains the panel figure of the measure.'  'PARAMETRIC_VALUE (parameter, RVECTOR) is the strength level.' };
			prop_description = rcs_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(RCS, POINTER) returns settings of POINTER of RCS.
			%  SETTINGS = M.GETPROPSETTINGS(RCS, POINTER) returns settings of POINTER of RCS.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('RCS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = RCS.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % RCS.PARAMETRIC_VALUE
					prop_settings = Format.getFormatSettings(12);
				case 4 % RCS.TEMPLATE
					prop_settings = 'RCS';
				otherwise
					prop_settings = getPropSettings@Strength(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = RCS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = RCS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(RCS, POINTER) returns the default value of POINTER of RCS.
			%  DEFAULT = M.GETPROPDEFAULT(RCS, POINTER) returns the default value of POINTER of RCS.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('RCS')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = RCS.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % RCS.PARAMETRIC_VALUE
					prop_default = 1;
				case 1 % RCS.ELCLASS
					prop_default = 'RCS';
				case 2 % RCS.NAME
					prop_default = 'Rich-Club Strength';
				case 3 % RCS.DESCRIPTION
					prop_default = 'The Rich-Club Strength (RCS) of a node at level PARAMETRIC_VALUE is the sum of the weighted edges that connect nodes of strength s or higher within a layer. PARAMETRIC_VALUE is set by the user and it can be a vector containing all the strength thresholds the default value is equal to 1.';
				case 4 % RCS.TEMPLATE
					prop_default = Format.getFormatDefault(8, RCS.getPropSettings(prop));
				case 5 % RCS.ID
					prop_default = 'RCS ID';
				case 6 % RCS.LABEL
					prop_default = 'Rich-Club Strength label';
				case 7 % RCS.NOTES
					prop_default = 'Rich-Club Strength notes';
				case 9 % RCS.SHAPE
					prop_default = 2;
				case 10 % RCS.SCOPE
					prop_default = 2;
				case 11 % RCS.PARAMETRICITY
					prop_default = 1;
				case 12 % RCS.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphWD' 'MultiplexWU' 'MultiplexWD'};;
				otherwise
					prop_default = getPropDefault@Strength(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = RCS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = RCS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(RCS, POINTER) returns the conditioned default value of POINTER of RCS.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(RCS, POINTER) returns the conditioned default value of POINTER of RCS.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('RCS')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = RCS.getPropProp(pointer);
			
			prop_default = RCS.conditioning(prop, RCS.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(RCS, PROP, VALUE) checks VALUE format for PROP of RCS.
			%  CHECK = M.CHECKPROP(RCS, PROP, VALUE) checks VALUE format for PROP of RCS.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:RCS:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:RCS:WrongInput
			%  Element.CHECKPROP(RCS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of RCS.
			%   Error id: BRAPH2:RCS:WrongInput
			%  M.CHECKPROP(RCS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of RCS.
			%   Error id: BRAPH2:RCS:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('RCS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = RCS.getPropProp(pointer);
			
			switch prop
				case 16 % RCS.PARAMETRIC_VALUE
					check = Format.checkFormat(12, value, RCS.getPropSettings(prop));
				case 4 % RCS.TEMPLATE
					check = Format.checkFormat(8, value, RCS.getPropSettings(prop));
				otherwise
					if prop <= 15
						check = checkProp@Strength(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':RCS:' 'WrongInput'], ...
					['BRAPH2' ':RCS:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' RCS.getPropTag(prop) ' (' RCS.getFormatTag(RCS.getPropFormat(prop)) ').'] ...
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
				case 14 % RCS.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					
					rich_club_strength = cell(L, 1); 
					directionality_type = g.get('DIRECTIONALITY_TYPE', L);
					richclub_threshold = m.get('PARAMETRIC_VALUE');
					assert(isnumeric(richclub_threshold) == 1, ...
					    ['BRAPH2' ':RCS:' 'WrongInput'], ...
					    ['RCS threshold must be an integer value ' ...
					    'while it is ' tostring(richclub_threshold)])
					
					s_levels = abs(richclub_threshold);
					for li = 1:1:L
					    
					    Aii = A{li, li};
					    directionality_layer = directionality_type(li, li);
					
					    if directionality_layer == 2  % undirected graphs
					       
					        strength = calculateValue@Strength(m, prop);
					        st = strength{li};
					
					    else  % directed graphs
					      
					        in_strength = StrengthIn('G', g).get('M');        
					        out_strength = StrengthOut('G', g).get('M');       
					
					        st = (in_strength{li}' + out_strength{li})/2;
					    end
					
					    rich_club_strength_layer = zeros(N(1), 1, length(s_levels));
					    count = 1;
					    for s = s_levels
					        low_rich_nodes = find(st <= s);  % get lower rich nodes with strength <= s
					        subAii = Aii;  % extract subnetwork of nodes >s by removing nodes <=s of Aii
					        subAii(low_rich_nodes, :) = 0;  % remove rows
					        subAii(:, low_rich_nodes) = 0;  % remove columns
					        
					        if directionality_layer == 2  % undirected graphs
					            rich_club_strength_layer(:, :, count) = round(sum(subAii, 1), 6)';  % strength of high rich nodes
					        else
					            rich_club_strength_layer(:, :, count) = round((sum(subAii, 1)' + sum(subAii, 2)), 6)/2;  % strength of high rich nodes
					        end
					        count = count + 1;
					    end
					    rich_club_strength(li) = {rich_club_strength_layer};  %#ok<SAGROW> % add rich club strength of layer li
					end
					
					value = rich_club_strength;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 15
						value = calculateValue@Strength(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
