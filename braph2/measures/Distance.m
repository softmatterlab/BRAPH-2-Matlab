classdef Distance < Measure
	%Distance is the Distance.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Distance (Distance) of a graph is the shortest path between all pairs of nodes 
	%  within a layer of the graph.
	% For weighted graphs, the distance is calculated with the Dijkstra algorithm
	%  using the inverse weight as the distance associated to the edge.
	%
	% The list of Distance properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Distance.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Distance.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Distance.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Distance.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Distance.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Distance.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Distance.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.BINODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Distance.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%
	% Distance methods (constructor):
	%  Distance - constructor
	%
	% Distance methods:
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
	% Distance methods (display):
	%  tostring - string with information about the distance
	%  disp - displays information about the distance
	%  tree - displays the tree of the distance
	%
	% Distance methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two distance are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the distance
	%
	% Distance methods (save/load, Static):
	%  save - saves BRAPH2 distance as b2 file
	%  load - loads a BRAPH2 distance from a b2 file
	%
	% Distance method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the distance
	%
	% Distance method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the distance
	%
	% Distance methods (inspection, Static):
	%  getClass - returns the class of the distance
	%  getSubclasses - returns all subclasses of Distance
	%  getProps - returns the property list of the distance
	%  getPropNumber - returns the property number of the distance
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
	% Distance methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Distance methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Distance methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Distance methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Distance; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Distance constants</a>.
	%
	
	methods % constructor
		function m = Distance(varargin)
			%Distance() creates a distance.
			%
			% Distance(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Distance(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Distance properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Distance.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Distance.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Distance.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Distance.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Distance.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Distance.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Distance.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.BINODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Distance.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the distance.
			%
			% BUILD = Distance.GETBUILD() returns the build of 'Distance'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the distance M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('Distance') returns the build of 'Distance'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('Distance')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the distance.
			%
			% CLASS = Distance.GETCLASS() returns the class 'Distance'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the distance M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Distance') returns 'Distance'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('Distance')
			%  are less computationally efficient.
			
			m_class = 'Distance';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the distance.
			%
			% LIST = Distance.GETSUBCLASSES() returns all subclasses of 'Distance'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the distance M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('Distance') returns all subclasses of 'Distance'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('Distance')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'Distance'  'GlobalEfficiency'  'GlobalEfficiencyAv'  'GlobalEfficiencyIn'  'GlobalEfficiencyInAv'  'GlobalEfficiencyOut'  'GlobalEfficiencyOutAv' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of distance.
			%
			% PROPS = Distance.GETPROPS() returns the property list of distance
			%  as a row vector.
			%
			% PROPS = Distance.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the distance M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Distance'[, CATEGORY]) returns the property list of 'Distance'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('Distance')
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
			%GETPROPNUMBER returns the property number of distance.
			%
			% N = Distance.GETPROPNUMBER() returns the property number of distance.
			%
			% N = Distance.GETPROPNUMBER(CATEGORY) returns the property number of distance
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the distance M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Distance') returns the property number of 'Distance'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('Distance')
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
			%EXISTSPROP checks whether property exists in distance/error.
			%
			% CHECK = Distance.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Distance, PROP) checks whether PROP exists for Distance.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Distance:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Distance:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Distance:WrongInput]
			%  Element.EXISTSPROP(Distance, PROP) throws error if PROP does NOT exist for Distance.
			%   Error id: [BRAPH2:Distance:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('Distance')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 15 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Distance:' 'WrongInput'], ...
					['BRAPH2' ':Distance:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Distance.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in distance/error.
			%
			% CHECK = Distance.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Distance, TAG) checks whether TAG exists for Distance.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Distance:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Distance:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Distance:WrongInput]
			%  Element.EXISTSTAG(Distance, TAG) throws error if TAG does NOT exist for Distance.
			%   Error id: [BRAPH2:Distance:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('Distance')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Distance:' 'WrongInput'], ...
					['BRAPH2' ':Distance:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for Distance.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Distance, POINTER) returns property number of POINTER of Distance.
			%  PROPERTY = M.GETPROPPROP(Distance, POINTER) returns property number of POINTER of Distance.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('Distance')
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
			%  TAG = Element.GETPROPTAG(Distance, POINTER) returns tag of POINTER of Distance.
			%  TAG = M.GETPROPTAG(Distance, POINTER) returns tag of POINTER of Distance.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('Distance')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				distance_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' };
				tag = distance_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(Distance, POINTER) returns category of POINTER of Distance.
			%  CATEGORY = M.GETPROPCATEGORY(Distance, POINTER) returns category of POINTER of Distance.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('Distance')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Distance.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			distance_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9 };
			prop_category = distance_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(Distance, POINTER) returns format of POINTER of Distance.
			%  FORMAT = M.GETPROPFORMAT(Distance, POINTER) returns format of POINTER of Distance.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('Distance')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Distance.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			distance_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8 };
			prop_format = distance_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Distance, POINTER) returns description of POINTER of Distance.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Distance, POINTER) returns description of POINTER of Distance.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('Distance')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Distance.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			distance_description_list = { 'ELCLASS (constant, string) is the class of the Distance.'  'NAME (constant, string) is the name of the Distance.'  'DESCRIPTION (constant, string) is the description of the Distance.'  'TEMPLATE (parameter, item) is the template of the Distance.'  'ID (data, string) is a few-letter code of the Distance.'  'LABEL (metadata, string) is an extended label of the Distance.'  'NOTES (metadata, string) are some specific notes about the Distance.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.BINODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Distance.'  'PFM (gui, item) contains the panel figure of the measure.' };
			prop_description = distance_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(Distance, POINTER) returns settings of POINTER of Distance.
			%  SETTINGS = M.GETPROPSETTINGS(Distance, POINTER) returns settings of POINTER of Distance.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('Distance')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Distance.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % Distance.TEMPLATE
					prop_settings = 'Distance';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Distance.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Distance.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Distance, POINTER) returns the default value of POINTER of Distance.
			%  DEFAULT = M.GETPROPDEFAULT(Distance, POINTER) returns the default value of POINTER of Distance.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('Distance')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Distance.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % Distance.ELCLASS
					prop_default = 'Distance';
				case 2 % Distance.NAME
					prop_default = 'Distance';
				case 3 % Distance.DESCRIPTION
					prop_default = 'The Distance (Distance) of a graph is the shortest path between all pairs of nodes within a layer of the graph. For weighted graphs, the distance is calculated with the Dijkstra algorithm using the inverse weight as the distance associated to the edge.';
				case 4 % Distance.TEMPLATE
					prop_default = Format.getFormatDefault(8, Distance.getPropSettings(prop));
				case 5 % Distance.ID
					prop_default = 'Distance ID';
				case 6 % Distance.LABEL
					prop_default = 'Distance label';
				case 7 % Distance.NOTES
					prop_default = 'Distance notes';
				case 9 % Distance.SHAPE
					prop_default = 3;
				case 10 % Distance.SCOPE
					prop_default = 2;
				case 11 % Distance.PARAMETRICITY
					prop_default = 2;
				case 12 % Distance.COMPATIBLE_GRAPHS
					prop_default = {'GraphBD' 'GraphBU' 'GraphWD' 'GraphWU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexBD' 'MultiplexBU' 'MultiplexWD' 'MultiplexWU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxBD' 'OrdMxBUD' 'OrdMxBU' 'OrdMxWD' 'OrdMxWU' 'OrdMxBUT' 'MultilayerWD' 'MultilayerBD' 'MultilayerWU' 'OrdMlWD' 'OrdMlWU' 'OrdMlBD' 'MultilayerBUT' 'MultilayerBU' 'MultilayerBUD' 'OrdMlBU' 'OrdMlBUD' 'OrdMlBUT'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Distance.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Distance.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Distance, POINTER) returns the conditioned default value of POINTER of Distance.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Distance, POINTER) returns the conditioned default value of POINTER of Distance.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('Distance')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Distance.getPropProp(pointer);
			
			prop_default = Distance.conditioning(prop, Distance.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Distance, PROP, VALUE) checks VALUE format for PROP of Distance.
			%  CHECK = M.CHECKPROP(Distance, PROP, VALUE) checks VALUE format for PROP of Distance.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:Distance:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:Distance:WrongInput
			%  Element.CHECKPROP(Distance, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Distance.
			%   Error id: BRAPH2:Distance:WrongInput
			%  M.CHECKPROP(Distance, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Distance.
			%   Error id: BRAPH2:Distance:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('Distance')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Distance.getPropProp(pointer);
			
			switch prop
				case 4 % Distance.TEMPLATE
					check = Format.checkFormat(8, value, Distance.getPropSettings(prop));
				otherwise
					if prop <= 15
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Distance:' 'WrongInput'], ...
					['BRAPH2' ':Distance:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Distance.getPropTag(prop) ' (' Distance.getFormatTag(Distance.getPropFormat(prop)) ').'] ...
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
				case 14 % Distance.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					
					distance = cell(g.get('LAYERNUMBER'), 1);
					connectivity_type =  g.get('CONNECTIVITY_TYPE', g.get('LAYERNUMBER'));
					connectivity_type = diag(connectivity_type);
					Aii_tmp = {};
					for li = 1:1:g.get('LAYERNUMBER')
					    Aii_tmp{li} = A{li, li}; %#ok<AGROW>
					end
					for li = 1:1:g.get('LAYERNUMBER')
					    Aii = Aii_tmp{li};
					    connectivity_layer = connectivity_type(li);
					
					    if connectivity_layer == 1  % weighted graphs
					        distance(li) = {getWeightedCalculation(Aii)};
					    else  % binary graphs
					        distance(li) = {getBinaryCalculation(Aii)};
					    end
					end
					
					value = distance;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 15
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
			function weighted_distance = getWeightedCalculation(A)
			    %GETWEIGHTEDCALCULATION calculates the distance value of a weighted adjacency matrix.
			    %
			    % WEIGHTED_DISTANCE = GETWEIGHTEDCALCULATION(A) returns the value of the
			    %  distance of a weighted adjacency matrix A.
			
			    ind = A~=0;
			    A(ind) = A(ind).^-1;
			    n = length(A);
			    D = inf(n);
			    D(1:n+1:end) = 0; % distance matrix
			
			    for u = 1:n
			        S = true(1, n); % distance permanence (true is temporary)
			        L1 = A;
			        V = u;
			
			        while 1
			            S(V) = 0; % distance u->V is now permanent
			            L1(:, V) = 0; % no in-edges as already shortest
			
			            for v = V
			                T = find(L1(v, :)); % neighbors of shortest nodes
			                [d, ~] = min([D(u, T);D(u, v)+L1(v, T)]);
			                D(u, T) = d; % smallest of old/new path lengths
			                % ind = T(wi==2); % indices of lengthened paths
			            end
			
			            minD = min(D(u, S));
			            if isempty(minD) || isinf(minD) % isempty: all nodes reached;
			                break % isinf: some nodes cannot be reached
			            end
			
			            V = find(D(u,:)==minD);
			        end
			    end
			    weighted_distance = D;
			end
			function binary_distance = getBinaryCalculation(A)
			    %GETBINARYCALCULATION calculates the distance value of a binary adjacency matrix.
			    %
			    % BINARY_DISTANCE = GETBINARYCALCULATION(A) returns the value of the
			    %  distance of a binary adjacency matrix A.
			
			    l = 1; % path length
			    D = A; % distance matrix
			
			    Lpath = A;
			    Idx = true;
			    while any(Idx(:))
			        l = l+1;
			        Lpath = Lpath * A;
			        Idx = (Lpath ~= 0) & (D == 0);
			        D(Idx) = l;
			    end
			
			    D(~D) = inf; % assign inf to disconnected nodes
			    binary_distance = dediagonalize(D); % assign 0 to the diagonal
			end
		end
	end
end
