classdef RichClub < Degree
	%RichClub is the graph Rich-Club.
	% It is a subclass of <a href="matlab:help Degree">Degree</a>.
	%
	% The Rich-Club coefficient (RichClub) of a node at level k is the fraction of 
	%  the edges that connect nodes of degree k or higher out of the 
	%  maximum number of edges that such nodes might share within a 
	%  layer. k is set by the user, the default value is equal to 1.
	%
	% The list of RichClub properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Rich-Club.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Rich-Club.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Rich-Club.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Rich-Club.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Rich-Club.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Rich-Club.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Rich-Club.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.PARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Rich-Club.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>16</strong> <strong>PARAMETRIC_VALUE</strong> 	PARAMETRIC_VALUE (parameter, scalar) is the threshold (k).
	%
	% RichClub methods (constructor):
	%  RichClub - constructor
	%
	% RichClub methods:
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
	% RichClub methods (display):
	%  tostring - string with information about the rich-club
	%  disp - displays information about the rich-club
	%  tree - displays the tree of the rich-club
	%
	% RichClub methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two rich-club are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the rich-club
	%
	% RichClub methods (save/load, Static):
	%  save - saves BRAPH2 rich-club as b2 file
	%  load - loads a BRAPH2 rich-club from a b2 file
	%
	% RichClub method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the rich-club
	%
	% RichClub method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the rich-club
	%
	% RichClub methods (inspection, Static):
	%  getClass - returns the class of the rich-club
	%  getSubclasses - returns all subclasses of RichClub
	%  getProps - returns the property list of the rich-club
	%  getPropNumber - returns the property number of the rich-club
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
	% RichClub methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% RichClub methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% RichClub methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% RichClub methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?RichClub; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">RichClub constants</a>.
	%
	
	properties (Constant) % properties
		PARAMETRIC_VALUE = 16; %CET: Computational Efficiency Trick
		PARAMETRIC_VALUE_TAG = 'PARAMETRIC_VALUE';
		PARAMETRIC_VALUE_CATEGORY = 3;
		PARAMETRIC_VALUE_FORMAT = 11;
	end
	methods % constructor
		function m = RichClub(varargin)
			%RichClub() creates a rich-club.
			%
			% RichClub(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% RichClub(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of RichClub properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Rich-Club.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Rich-Club.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Rich-Club.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Rich-Club.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Rich-Club.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Rich-Club.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Rich-Club.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.PARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Rich-Club.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>16</strong> <strong>PARAMETRIC_VALUE</strong> 	PARAMETRIC_VALUE (parameter, scalar) is the threshold (k).
			%
			% See also Category, Format.
			
			m = m@Degree(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the rich-club.
			%
			% BUILD = RichClub.GETBUILD() returns the build of 'RichClub'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the rich-club M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('RichClub') returns the build of 'RichClub'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('RichClub')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the rich-club.
			%
			% CLASS = RichClub.GETCLASS() returns the class 'RichClub'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the rich-club M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('RichClub') returns 'RichClub'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('RichClub')
			%  are less computationally efficient.
			
			m_class = 'RichClub';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the rich-club.
			%
			% LIST = RichClub.GETSUBCLASSES() returns all subclasses of 'RichClub'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the rich-club M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('RichClub') returns all subclasses of 'RichClub'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('RichClub')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'RichClub' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of rich-club.
			%
			% PROPS = RichClub.GETPROPS() returns the property list of rich-club
			%  as a row vector.
			%
			% PROPS = RichClub.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the rich-club M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('RichClub'[, CATEGORY]) returns the property list of 'RichClub'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('RichClub')
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
			%GETPROPNUMBER returns the property number of rich-club.
			%
			% N = RichClub.GETPROPNUMBER() returns the property number of rich-club.
			%
			% N = RichClub.GETPROPNUMBER(CATEGORY) returns the property number of rich-club
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the rich-club M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('RichClub') returns the property number of 'RichClub'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('RichClub')
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
			%EXISTSPROP checks whether property exists in rich-club/error.
			%
			% CHECK = RichClub.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(RichClub, PROP) checks whether PROP exists for RichClub.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:RichClub:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:RichClub:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:RichClub:WrongInput]
			%  Element.EXISTSPROP(RichClub, PROP) throws error if PROP does NOT exist for RichClub.
			%   Error id: [BRAPH2:RichClub:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('RichClub')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 16 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':RichClub:' 'WrongInput'], ...
					['BRAPH2' ':RichClub:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for RichClub.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in rich-club/error.
			%
			% CHECK = RichClub.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(RichClub, TAG) checks whether TAG exists for RichClub.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:RichClub:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:RichClub:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:RichClub:WrongInput]
			%  Element.EXISTSTAG(RichClub, TAG) throws error if TAG does NOT exist for RichClub.
			%   Error id: [BRAPH2:RichClub:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('RichClub')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'PARAMETRIC_VALUE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':RichClub:' 'WrongInput'], ...
					['BRAPH2' ':RichClub:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for RichClub.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(RichClub, POINTER) returns property number of POINTER of RichClub.
			%  PROPERTY = M.GETPROPPROP(RichClub, POINTER) returns property number of POINTER of RichClub.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('RichClub')
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
			%  TAG = Element.GETPROPTAG(RichClub, POINTER) returns tag of POINTER of RichClub.
			%  TAG = M.GETPROPTAG(RichClub, POINTER) returns tag of POINTER of RichClub.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('RichClub')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				richclub_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'PARAMETRIC_VALUE' };
				tag = richclub_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(RichClub, POINTER) returns category of POINTER of RichClub.
			%  CATEGORY = M.GETPROPCATEGORY(RichClub, POINTER) returns category of POINTER of RichClub.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('RichClub')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = RichClub.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			richclub_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3 };
			prop_category = richclub_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(RichClub, POINTER) returns format of POINTER of RichClub.
			%  FORMAT = M.GETPROPFORMAT(RichClub, POINTER) returns format of POINTER of RichClub.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('RichClub')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = RichClub.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			richclub_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  11 };
			prop_format = richclub_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(RichClub, POINTER) returns description of POINTER of RichClub.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(RichClub, POINTER) returns description of POINTER of RichClub.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('RichClub')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = RichClub.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			richclub_description_list = { 'ELCLASS (constant, string) is the class of the Rich-Club.'  'NAME (constant, string) is the name of the Rich-Club.'  'DESCRIPTION (constant, string) is the description of the Rich-Club.'  'TEMPLATE (parameter, item) is the template of the Rich-Club.'  'ID (data, string) is a few-letter code of the Rich-Club.'  'LABEL (metadata, string) is an extended label of the Rich-Club.'  'NOTES (metadata, string) are some specific notes about the Rich-Club.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.PARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Rich-Club.'  'PFM (gui, item) contains the panel figure of the measure.'  'PARAMETRIC_VALUE (parameter, scalar) is the threshold (k).' };
			prop_description = richclub_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(RichClub, POINTER) returns settings of POINTER of RichClub.
			%  SETTINGS = M.GETPROPSETTINGS(RichClub, POINTER) returns settings of POINTER of RichClub.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('RichClub')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = RichClub.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % RichClub.PARAMETRIC_VALUE
					prop_settings = Format.getFormatSettings(11);
				case 4 % RichClub.TEMPLATE
					prop_settings = 'RichClub';
				otherwise
					prop_settings = getPropSettings@Degree(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = RichClub.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = RichClub.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(RichClub, POINTER) returns the default value of POINTER of RichClub.
			%  DEFAULT = M.GETPROPDEFAULT(RichClub, POINTER) returns the default value of POINTER of RichClub.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('RichClub')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = RichClub.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % RichClub.PARAMETRIC_VALUE
					prop_default = 1;
				case 1 % RichClub.ELCLASS
					prop_default = 'RichClub';
				case 2 % RichClub.NAME
					prop_default = 'Rich-Club';
				case 3 % RichClub.DESCRIPTION
					prop_default = 'The Rich-Club coefficient (RichClub) of a node at level k is the fraction of the edges that connect nodes of degree k or higher out of the maximum number of edges that such nodes might share within a layer. k is set by the user, the default value is equal to 1.';
				case 4 % RichClub.TEMPLATE
					prop_default = Format.getFormatDefault(8, RichClub.getPropSettings(prop));
				case 5 % RichClub.ID
					prop_default = 'RichClub ID';
				case 6 % RichClub.LABEL
					prop_default = 'Rich-Club label';
				case 7 % RichClub.NOTES
					prop_default = 'Rich-Club notes';
				case 9 % RichClub.SHAPE
					prop_default = 1;
				case 10 % RichClub.SCOPE
					prop_default = 2;
				case 11 % RichClub.PARAMETRICITY
					prop_default = 1;
				case 12 % RichClub.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT'};
				otherwise
					prop_default = getPropDefault@Degree(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = RichClub.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = RichClub.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(RichClub, POINTER) returns the conditioned default value of POINTER of RichClub.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(RichClub, POINTER) returns the conditioned default value of POINTER of RichClub.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('RichClub')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = RichClub.getPropProp(pointer);
			
			prop_default = RichClub.conditioning(prop, RichClub.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(RichClub, PROP, VALUE) checks VALUE format for PROP of RichClub.
			%  CHECK = M.CHECKPROP(RichClub, PROP, VALUE) checks VALUE format for PROP of RichClub.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:RichClub:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:RichClub:WrongInput
			%  Element.CHECKPROP(RichClub, PROP, VALUE) throws error if VALUE has not a valid format for PROP of RichClub.
			%   Error id: BRAPH2:RichClub:WrongInput
			%  M.CHECKPROP(RichClub, PROP, VALUE) throws error if VALUE has not a valid format for PROP of RichClub.
			%   Error id: BRAPH2:RichClub:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('RichClub')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = RichClub.getPropProp(pointer);
			
			switch prop
				case 16 % RichClub.PARAMETRIC_VALUE
					check = Format.checkFormat(11, value, RichClub.getPropSettings(prop));
				case 4 % RichClub.TEMPLATE
					check = Format.checkFormat(8, value, RichClub.getPropSettings(prop));
				otherwise
					if prop <= 15
						check = checkProp@Degree(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':RichClub:' 'WrongInput'], ...
					['BRAPH2' ':RichClub:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' RichClub.getPropTag(prop) ' (' RichClub.getFormatTag(RichClub.getPropFormat(prop)) ').'] ...
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
				case 14 % RichClub.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					
					rich_club = cell(L, 1);
					directionality_type = g.get('DIRECTIONALITY_TYPE', L);
					richclub_threshold = m.get('PARAMETRIC_VALUE');
					assert(mod(richclub_threshold, 1) == 0, ...
					    ['BRAPH2' ':RichClub:' 'WrongInput'], ...
					    ['RichClub threshold must be an integer value ' ...
					    'while it is ' tostring(richclub_threshold)])
					
					k_level = abs(richclub_threshold);
					for li = 1:1:L
					    
					    Aii = A{li, li};
					    directionality_layer = directionality_type(li, li);
					      
					    if directionality_layer == 2  % undirected graphs
					        
					        degree = calculateValue@Degree(m, prop);        
					        deg = degree{li};
					        
					    else  % directed graphs        
					        
					        in_degree = DegreeIn('G', g).get('M');        
					        out_degree = DegreeOut('G', g).get('M');
					        deg = (in_degree{li} + out_degree{li})/2;
					    end
					    
					    richclub_layer = zeros(1, 1, k_level);
					    Nk = zeros(1, k_level);
					    Ek = zeros(1, k_level);
					    for k = 1:1:k_level
					        low_rich_nodes = find(deg <= k);  % get lower rich nodes with degree <= k
					        Aii = binarize(Aii);  % binarizes the adjacency matrix
					        subAii = Aii;  % extract subnetwork of nodes >k by removing nodes <= k of Aii
					        subAii(low_rich_nodes, :) = [];  % remove rows
					        subAii(:, low_rich_nodes) = [];  % remove columns
					        Nk(k) = size(subAii, 2);  % number of nodes with degree > k
					        Ek(k) = sum(subAii(:));  % total number of connections in subgraph
					        richclub_layer(1, 1, k) = Ek(k)/(Nk(k)*(Nk(k)-1));  % unweighted rich-club coefficient
					    end
					    richclub_layer(isnan(richclub_layer)) = 0;  % Should return zeros, since NaN happens when subAii has zero nodes with degree > k
					    rich_club(li) = {richclub_layer};  % add rich club degree of layer li
					end
					
					value = rich_club;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 15
						value = calculateValue@Degree(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
