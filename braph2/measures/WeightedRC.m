classdef WeightedRC < Strength
	%WeightedRC is the graph Weighted Rich-Club.
	% It is a subclass of <a href="matlab:help Strength">Strength</a>.
	%
	% The Weighted Rich-Club (WeightedRC) coefficient of a node at level s is the fraction of the 
	%  edges weights that connect nodes of strength s or higher out of the 
	%  maximum number of edges weights that such nodes might share within a layer. 
	%  Parameter s is set by the user and it can be a vector containing all the 
	%  strength thresholds; the default value is equal to 1.
	%
	% The list of WeightedRC properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Weighted Rich-Club.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Weighted Rich-Club.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Weighted Rich-Club.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Weighted Rich-Club.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Weighted Rich-Club.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Weighted Rich-Club.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Weighted Rich-Club.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.PARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Weighted Rich-Club.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>16</strong> <strong>PARAMETRIC_VALUE</strong> 	PARAMETRIC_VALUE (parameter, RVECTOR) is the threshold (s).
	%
	% WeightedRC methods (constructor):
	%  WeightedRC - constructor
	%
	% WeightedRC methods:
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
	% WeightedRC methods (display):
	%  tostring - string with information about the weighted rich-club
	%  disp - displays information about the weighted rich-club
	%  tree - displays the tree of the weighted rich-club
	%
	% WeightedRC methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two weighted rich-club are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the weighted rich-club
	%
	% WeightedRC methods (save/load, Static):
	%  save - saves BRAPH2 weighted rich-club as b2 file
	%  load - loads a BRAPH2 weighted rich-club from a b2 file
	%
	% WeightedRC method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the weighted rich-club
	%
	% WeightedRC method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the weighted rich-club
	%
	% WeightedRC methods (inspection, Static):
	%  getClass - returns the class of the weighted rich-club
	%  getSubclasses - returns all subclasses of WeightedRC
	%  getProps - returns the property list of the weighted rich-club
	%  getPropNumber - returns the property number of the weighted rich-club
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
	% WeightedRC methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% WeightedRC methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% WeightedRC methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% WeightedRC methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?WeightedRC; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">WeightedRC constants</a>.
	%
	
	properties (Constant) % properties
		PARAMETRIC_VALUE = 16; %CET: Computational Efficiency Trick
		PARAMETRIC_VALUE_TAG = 'PARAMETRIC_VALUE';
		PARAMETRIC_VALUE_CATEGORY = 3;
		PARAMETRIC_VALUE_FORMAT = 12;
	end
	methods % constructor
		function m = WeightedRC(varargin)
			%WeightedRC() creates a weighted rich-club.
			%
			% WeightedRC(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% WeightedRC(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of WeightedRC properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Weighted Rich-Club.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Weighted Rich-Club.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Weighted Rich-Club.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Weighted Rich-Club.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Weighted Rich-Club.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Weighted Rich-Club.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Weighted Rich-Club.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.PARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Weighted Rich-Club.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>16</strong> <strong>PARAMETRIC_VALUE</strong> 	PARAMETRIC_VALUE (parameter, RVECTOR) is the threshold (s).
			%
			% See also Category, Format.
			
			m = m@Strength(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the weighted rich-club.
			%
			% BUILD = WeightedRC.GETBUILD() returns the build of 'WeightedRC'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the weighted rich-club M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('WeightedRC') returns the build of 'WeightedRC'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('WeightedRC')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the weighted rich-club.
			%
			% CLASS = WeightedRC.GETCLASS() returns the class 'WeightedRC'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the weighted rich-club M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('WeightedRC') returns 'WeightedRC'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('WeightedRC')
			%  are less computationally efficient.
			
			m_class = 'WeightedRC';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the weighted rich-club.
			%
			% LIST = WeightedRC.GETSUBCLASSES() returns all subclasses of 'WeightedRC'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the weighted rich-club M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('WeightedRC') returns all subclasses of 'WeightedRC'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('WeightedRC')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'WeightedRC' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of weighted rich-club.
			%
			% PROPS = WeightedRC.GETPROPS() returns the property list of weighted rich-club
			%  as a row vector.
			%
			% PROPS = WeightedRC.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the weighted rich-club M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('WeightedRC'[, CATEGORY]) returns the property list of 'WeightedRC'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('WeightedRC')
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
			%GETPROPNUMBER returns the property number of weighted rich-club.
			%
			% N = WeightedRC.GETPROPNUMBER() returns the property number of weighted rich-club.
			%
			% N = WeightedRC.GETPROPNUMBER(CATEGORY) returns the property number of weighted rich-club
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the weighted rich-club M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('WeightedRC') returns the property number of 'WeightedRC'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('WeightedRC')
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
			%EXISTSPROP checks whether property exists in weighted rich-club/error.
			%
			% CHECK = WeightedRC.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(WeightedRC, PROP) checks whether PROP exists for WeightedRC.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:WeightedRC:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:WeightedRC:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:WeightedRC:WrongInput]
			%  Element.EXISTSPROP(WeightedRC, PROP) throws error if PROP does NOT exist for WeightedRC.
			%   Error id: [BRAPH2:WeightedRC:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('WeightedRC')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 16 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':WeightedRC:' 'WrongInput'], ...
					['BRAPH2' ':WeightedRC:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for WeightedRC.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in weighted rich-club/error.
			%
			% CHECK = WeightedRC.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(WeightedRC, TAG) checks whether TAG exists for WeightedRC.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:WeightedRC:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:WeightedRC:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:WeightedRC:WrongInput]
			%  Element.EXISTSTAG(WeightedRC, TAG) throws error if TAG does NOT exist for WeightedRC.
			%   Error id: [BRAPH2:WeightedRC:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('WeightedRC')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'PARAMETRIC_VALUE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':WeightedRC:' 'WrongInput'], ...
					['BRAPH2' ':WeightedRC:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for WeightedRC.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(WeightedRC, POINTER) returns property number of POINTER of WeightedRC.
			%  PROPERTY = M.GETPROPPROP(WeightedRC, POINTER) returns property number of POINTER of WeightedRC.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('WeightedRC')
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
			%  TAG = Element.GETPROPTAG(WeightedRC, POINTER) returns tag of POINTER of WeightedRC.
			%  TAG = M.GETPROPTAG(WeightedRC, POINTER) returns tag of POINTER of WeightedRC.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('WeightedRC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				weightedrc_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'PARAMETRIC_VALUE' };
				tag = weightedrc_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(WeightedRC, POINTER) returns category of POINTER of WeightedRC.
			%  CATEGORY = M.GETPROPCATEGORY(WeightedRC, POINTER) returns category of POINTER of WeightedRC.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('WeightedRC')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = WeightedRC.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			weightedrc_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3 };
			prop_category = weightedrc_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(WeightedRC, POINTER) returns format of POINTER of WeightedRC.
			%  FORMAT = M.GETPROPFORMAT(WeightedRC, POINTER) returns format of POINTER of WeightedRC.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('WeightedRC')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = WeightedRC.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			weightedrc_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  12 };
			prop_format = weightedrc_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(WeightedRC, POINTER) returns description of POINTER of WeightedRC.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(WeightedRC, POINTER) returns description of POINTER of WeightedRC.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('WeightedRC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = WeightedRC.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			weightedrc_description_list = { 'ELCLASS (constant, string) is the class of the Weighted Rich-Club.'  'NAME (constant, string) is the name of the Weighted Rich-Club.'  'DESCRIPTION (constant, string) is the description of the Weighted Rich-Club.'  'TEMPLATE (parameter, item) is the template of the Weighted Rich-Club.'  'ID (data, string) is a few-letter code of the Weighted Rich-Club.'  'LABEL (metadata, string) is an extended label of the Weighted Rich-Club.'  'NOTES (metadata, string) are some specific notes about the Weighted Rich-Club.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.PARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Weighted Rich-Club.'  'PFM (gui, item) contains the panel figure of the measure.'  'PARAMETRIC_VALUE (parameter, RVECTOR) is the threshold (s).' };
			prop_description = weightedrc_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(WeightedRC, POINTER) returns settings of POINTER of WeightedRC.
			%  SETTINGS = M.GETPROPSETTINGS(WeightedRC, POINTER) returns settings of POINTER of WeightedRC.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('WeightedRC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = WeightedRC.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % WeightedRC.PARAMETRIC_VALUE
					prop_settings = Format.getFormatSettings(12);
				case 4 % WeightedRC.TEMPLATE
					prop_settings = 'WeightedRC';
				otherwise
					prop_settings = getPropSettings@Strength(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = WeightedRC.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = WeightedRC.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(WeightedRC, POINTER) returns the default value of POINTER of WeightedRC.
			%  DEFAULT = M.GETPROPDEFAULT(WeightedRC, POINTER) returns the default value of POINTER of WeightedRC.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('WeightedRC')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = WeightedRC.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % WeightedRC.PARAMETRIC_VALUE
					prop_default = 1;
				case 1 % WeightedRC.ELCLASS
					prop_default = 'WeightedRC';
				case 2 % WeightedRC.NAME
					prop_default = 'Weighted Rich-Club';
				case 3 % WeightedRC.DESCRIPTION
					prop_default = 'The Weighted Rich-Club (WeightedRC) coefficient of a node at level s is the fraction of the edges weights that connect nodes of strength s or higher out of the maximum number of edges weights that such nodes might share within a layer. Parameter s is set by the user and it can be a vector containing all the strength thresholds; the default value is equal to 1.';
				case 4 % WeightedRC.TEMPLATE
					prop_default = Format.getFormatDefault(8, WeightedRC.getPropSettings(prop));
				case 5 % WeightedRC.ID
					prop_default = 'WeightedRC ID';
				case 6 % WeightedRC.LABEL
					prop_default = 'Weighted Rich-Club label';
				case 7 % WeightedRC.NOTES
					prop_default = 'Weighted Rich-Club notes';
				case 9 % WeightedRC.SHAPE
					prop_default = 2;
				case 10 % WeightedRC.SCOPE
					prop_default = 1;
				case 11 % WeightedRC.PARAMETRICITY
					prop_default = 1;
				case 12 % WeightedRC.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'MultiplexWU'};;
				otherwise
					prop_default = getPropDefault@Strength(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = WeightedRC.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = WeightedRC.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(WeightedRC, POINTER) returns the conditioned default value of POINTER of WeightedRC.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(WeightedRC, POINTER) returns the conditioned default value of POINTER of WeightedRC.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('WeightedRC')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = WeightedRC.getPropProp(pointer);
			
			prop_default = WeightedRC.conditioning(prop, WeightedRC.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(WeightedRC, PROP, VALUE) checks VALUE format for PROP of WeightedRC.
			%  CHECK = M.CHECKPROP(WeightedRC, PROP, VALUE) checks VALUE format for PROP of WeightedRC.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:WeightedRC:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:WeightedRC:WrongInput
			%  Element.CHECKPROP(WeightedRC, PROP, VALUE) throws error if VALUE has not a valid format for PROP of WeightedRC.
			%   Error id: BRAPH2:WeightedRC:WrongInput
			%  M.CHECKPROP(WeightedRC, PROP, VALUE) throws error if VALUE has not a valid format for PROP of WeightedRC.
			%   Error id: BRAPH2:WeightedRC:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('WeightedRC')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = WeightedRC.getPropProp(pointer);
			
			switch prop
				case 16 % WeightedRC.PARAMETRIC_VALUE
					check = Format.checkFormat(12, value, WeightedRC.getPropSettings(prop));
				case 4 % WeightedRC.TEMPLATE
					check = Format.checkFormat(8, value, WeightedRC.getPropSettings(prop));
				otherwise
					if prop <= 15
						check = checkProp@Strength(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':WeightedRC:' 'WrongInput'], ...
					['BRAPH2' ':WeightedRC:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' WeightedRC.getPropTag(prop) ' (' WeightedRC.getFormatTag(WeightedRC.getPropFormat(prop)) ').'] ...
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
				case 14 % WeightedRC.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					
					weighted_rich_club = cell(l, 1);
					directionality_layer = g.get('DIRECTIONALITY_TYPE', l);
					weighted_rich_club_threshold = m.get('PARAMETRIC_VALUE');
					assert(isnumeric(weighted_rich_club_threshold) == 1, ...
					    ['BRAPH2' ':WeightedRichClub:' 'WrongInput'], ...
					    ['WeightedRichClub threshold must be a positive number ' ...
					    'while it is ' tostring(weighted_rich_club_threshold)])
					
					s_levels = abs(weighted_rich_club_threshold);
					directionality_type = g.get('DIRECTIONALITY_TYPE', l);
					    
					for li = 1:1:l
					    
					    Aii = A{li, li};
					    directionality_layer = directionality_type(li, li);
					   
					    if directionality_layer == 2  % undirected graphs
					
					        strength = calculateValue@Strength(m, prop);
					        st = strength{li};
					
					    else  % directed graphs
					
					        in_strength = StrengthIn('G', g).get('M');
					        out_strength = StrengthOut('G', g).get('M');
					
					        st = (in_strength{li} + out_strength{li})/2;
					    end
					
					    weighted_rich_club_layer = zeros(1, 1, length(s_levels));
					    wrank = sort(Aii(:), 'descend');  % wrank contains the ranked weights of the network, with strongest connections on top
					    count = 1;
					    
					    for s = s_levels
					        low_rich_nodes = find(st < s);  % get lower rich nodes with strength < s
					        subAii = Aii;  % extract subnetwork of nodes >=s by removing nodes < s of Aii
					        subAii(low_rich_nodes, :) = [];  % remove rows
					        subAii(:, low_rich_nodes) = [];  % remove columns
					
					        Wr = sum(subAii(:));  % total weight of connections in subgraph > s
					        Er = length(find(subAii~=0));  % total number of connections in subgraph
					        wrank_r = wrank(1:1:Er);  % E>r number of connections with max weight in network
					        % Calculate weighted rich-club coefficient
					        weighted_rich_club_layer(1, 1, count) = Wr / sum(wrank_r);
					        count = count + 1;
					    end
					    weighted_rich_club_layer(isnan(weighted_rich_club_layer)) = 0;  % Should return zeros, since NaN happens when subAii has zero nodes with strength > s
					    weighted_rich_club(li) = {weighted_rich_club_layer};  % add rich club strength of layer li
					end
					value = weighted_rich_club;
					
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
