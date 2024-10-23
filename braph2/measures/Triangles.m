classdef Triangles < Measure
	%Triangles is the graph Triangles.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Triangles (Triangles) are calculated as the number of neighbors of a node that are 
	%  also neighbors of each other within a layer. In weighted graphs, the triangles are 
	%  calculated as the geometric mean of the weights of the edges forming the triangle.
	%
	% The list of Triangles properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Triangles.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Triangles.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Triangles.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Triangles.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Triangles.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Triangles.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Triangles.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Triangles.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>16</strong> <strong>RULE</strong> 	RULE (parameter, option) is the rule to determine what is a triangle in a directed graph.
	%
	% Triangles methods (constructor):
	%  Triangles - constructor
	%
	% Triangles methods:
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
	% Triangles methods (display):
	%  tostring - string with information about the triangles
	%  disp - displays information about the triangles
	%  tree - displays the tree of the triangles
	%
	% Triangles methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two triangles are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the triangles
	%
	% Triangles methods (save/load, Static):
	%  save - saves BRAPH2 triangles as b2 file
	%  load - loads a BRAPH2 triangles from a b2 file
	%
	% Triangles method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the triangles
	%
	% Triangles method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the triangles
	%
	% Triangles methods (inspection, Static):
	%  getClass - returns the class of the triangles
	%  getSubclasses - returns all subclasses of Triangles
	%  getProps - returns the property list of the triangles
	%  getPropNumber - returns the property number of the triangles
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
	% Triangles methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Triangles methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Triangles methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Triangles methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Triangles; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Triangles constants</a>.
	%
	
	properties (Constant) % properties
		RULE = 16; %CET: Computational Efficiency Trick
		RULE_TAG = 'RULE';
		RULE_CATEGORY = 3;
		RULE_FORMAT = 5;
	end
	methods % constructor
		function m = Triangles(varargin)
			%Triangles() creates a triangles.
			%
			% Triangles(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Triangles(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Triangles properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Triangles.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Triangles.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Triangles.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Triangles.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Triangles.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Triangles.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Triangles.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Triangles.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>16</strong> <strong>RULE</strong> 	RULE (parameter, option) is the rule to determine what is a triangle in a directed graph.
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the triangles.
			%
			% BUILD = Triangles.GETBUILD() returns the build of 'Triangles'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the triangles M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('Triangles') returns the build of 'Triangles'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('Triangles')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the triangles.
			%
			% CLASS = Triangles.GETCLASS() returns the class 'Triangles'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the triangles M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Triangles') returns 'Triangles'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('Triangles')
			%  are less computationally efficient.
			
			m_class = 'Triangles';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the triangles.
			%
			% LIST = Triangles.GETSUBCLASSES() returns all subclasses of 'Triangles'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the triangles M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('Triangles') returns all subclasses of 'Triangles'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('Triangles')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'Triangles'  'Clustering'  'ClusteringAv'  'Transitivity' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of triangles.
			%
			% PROPS = Triangles.GETPROPS() returns the property list of triangles
			%  as a row vector.
			%
			% PROPS = Triangles.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the triangles M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Triangles'[, CATEGORY]) returns the property list of 'Triangles'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('Triangles')
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
			%GETPROPNUMBER returns the property number of triangles.
			%
			% N = Triangles.GETPROPNUMBER() returns the property number of triangles.
			%
			% N = Triangles.GETPROPNUMBER(CATEGORY) returns the property number of triangles
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the triangles M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Triangles') returns the property number of 'Triangles'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('Triangles')
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
			%EXISTSPROP checks whether property exists in triangles/error.
			%
			% CHECK = Triangles.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Triangles, PROP) checks whether PROP exists for Triangles.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Triangles:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Triangles:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Triangles:WrongInput]
			%  Element.EXISTSPROP(Triangles, PROP) throws error if PROP does NOT exist for Triangles.
			%   Error id: [BRAPH2:Triangles:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('Triangles')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 16 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Triangles:' 'WrongInput'], ...
					['BRAPH2' ':Triangles:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Triangles.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in triangles/error.
			%
			% CHECK = Triangles.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Triangles, TAG) checks whether TAG exists for Triangles.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Triangles:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Triangles:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Triangles:WrongInput]
			%  Element.EXISTSTAG(Triangles, TAG) throws error if TAG does NOT exist for Triangles.
			%   Error id: [BRAPH2:Triangles:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('Triangles')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Triangles:' 'WrongInput'], ...
					['BRAPH2' ':Triangles:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for Triangles.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Triangles, POINTER) returns property number of POINTER of Triangles.
			%  PROPERTY = M.GETPROPPROP(Triangles, POINTER) returns property number of POINTER of Triangles.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('Triangles')
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
			%  TAG = Element.GETPROPTAG(Triangles, POINTER) returns tag of POINTER of Triangles.
			%  TAG = M.GETPROPTAG(Triangles, POINTER) returns tag of POINTER of Triangles.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('Triangles')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				triangles_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE' };
				tag = triangles_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(Triangles, POINTER) returns category of POINTER of Triangles.
			%  CATEGORY = M.GETPROPCATEGORY(Triangles, POINTER) returns category of POINTER of Triangles.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('Triangles')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Triangles.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			triangles_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3 };
			prop_category = triangles_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(Triangles, POINTER) returns format of POINTER of Triangles.
			%  FORMAT = M.GETPROPFORMAT(Triangles, POINTER) returns format of POINTER of Triangles.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('Triangles')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Triangles.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			triangles_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  5 };
			prop_format = triangles_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Triangles, POINTER) returns description of POINTER of Triangles.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Triangles, POINTER) returns description of POINTER of Triangles.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('Triangles')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Triangles.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			triangles_description_list = { 'ELCLASS (constant, string) is the class of the Triangles.'  'NAME (constant, string) is the name of the Triangles.'  'DESCRIPTION (constant, string) is the description of the Triangles.'  'TEMPLATE (parameter, item) is the template of the Triangles.'  'ID (data, string) is a few-letter code of the Triangles.'  'LABEL (metadata, string) is an extended label of the Triangles.'  'NOTES (metadata, string) are some specific notes about the Triangles.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Triangles.'  'PFM (gui, item) contains the panel figure of the measure.'  'RULE (parameter, option) is the rule to determine what is a triangle in a directed graph.' };
			prop_description = triangles_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(Triangles, POINTER) returns settings of POINTER of Triangles.
			%  SETTINGS = M.GETPROPSETTINGS(Triangles, POINTER) returns settings of POINTER of Triangles.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('Triangles')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Triangles.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % Triangles.RULE
					prop_settings = {'all' 'middleman' 'in' 'out' 'cycle'};
				case 4 % Triangles.TEMPLATE
					prop_settings = 'Triangles';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Triangles.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Triangles.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Triangles, POINTER) returns the default value of POINTER of Triangles.
			%  DEFAULT = M.GETPROPDEFAULT(Triangles, POINTER) returns the default value of POINTER of Triangles.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('Triangles')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Triangles.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % Triangles.RULE
					prop_default = 'cycle';
				case 1 % Triangles.ELCLASS
					prop_default = 'Triangles';
				case 2 % Triangles.NAME
					prop_default = 'Triangles';
				case 3 % Triangles.DESCRIPTION
					prop_default = 'The Triangles (Triangles) are calculated as the number of neighbors of a node that are also neighbors of each other within a layer. In weighted graphs, the triangles are calculated as the geometric mean of the weights of the edges forming the triangle.';
				case 4 % Triangles.TEMPLATE
					prop_default = Format.getFormatDefault(8, Triangles.getPropSettings(prop));
				case 5 % Triangles.ID
					prop_default = 'Triangles ID';
				case 6 % Triangles.LABEL
					prop_default = 'Triangles label';
				case 7 % Triangles.NOTES
					prop_default = 'Triangles notes';
				case 9 % Triangles.SHAPE
					prop_default = 2;
				case 10 % Triangles.SCOPE
					prop_default = 2;
				case 11 % Triangles.PARAMETRICITY
					prop_default = 2;
				case 12 % Triangles.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxWD' 'OrdMxBU' 'OrdMxBD' 'OrdMxBUT' 'MultilayerWD' 'MultilayerBD'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Triangles.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Triangles.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Triangles, POINTER) returns the conditioned default value of POINTER of Triangles.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Triangles, POINTER) returns the conditioned default value of POINTER of Triangles.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('Triangles')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Triangles.getPropProp(pointer);
			
			prop_default = Triangles.conditioning(prop, Triangles.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Triangles, PROP, VALUE) checks VALUE format for PROP of Triangles.
			%  CHECK = M.CHECKPROP(Triangles, PROP, VALUE) checks VALUE format for PROP of Triangles.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:Triangles:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:Triangles:WrongInput
			%  Element.CHECKPROP(Triangles, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Triangles.
			%   Error id: BRAPH2:Triangles:WrongInput
			%  M.CHECKPROP(Triangles, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Triangles.
			%   Error id: BRAPH2:Triangles:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('Triangles')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Triangles.getPropProp(pointer);
			
			switch prop
				case 16 % Triangles.RULE
					check = Format.checkFormat(5, value, Triangles.getPropSettings(prop));
				case 4 % Triangles.TEMPLATE
					check = Format.checkFormat(8, value, Triangles.getPropSettings(prop));
				otherwise
					if prop <= 15
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Triangles:' 'WrongInput'], ...
					['BRAPH2' ':Triangles:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Triangles.getPropTag(prop) ' (' Triangles.getFormatTag(Triangles.getPropFormat(prop)) ').'] ...
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
				case 14 % Triangles.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G');  % graph from measure class
					A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.) 
					L = g.get('LAYERNUMBER');
					
					triangles = cell(L, 1);
					            
					directionality_type =   g.get('DIRECTIONALITY_TYPE', L);
					for li = 1:1:L        
					    Aii = A{li, li};    
					    
					    if directionality_type == 2  % undirected graphs
					        triangles_layer = diag((Aii.^(1/3))^3) / 2;
					        triangles_layer(isnan(triangles_layer)) = 0;  % Should return zeros, not NaN
					        triangles(li) = {triangles_layer};
					        
					    else  % directed graphs
					        directed_triangles_rule = m.get('RULE');
					        switch lower(directed_triangles_rule)
					            case 'all'  % all rule
					                triangles_layer = diag((Aii.^(1/3) + transpose(Aii).^(1/3))^3) / 2;
					            case 'middleman'  % middleman rule
					                triangles_layer = diag(Aii.^(1/3) * transpose(Aii).^(1/3) * Aii.^(1/3));
					            case 'in'  % in rule
					                triangles_layer = diag(transpose(Aii).^(1/3) * (Aii.^(1/3))^2);
					            case 'out'  % out rule
					                triangles_layer = diag((Aii.^(1/3))^2 * transpose(Aii).^(1/3));
					            otherwise  % {'cycle'}  % cycle rule
					                triangles_layer = diag((Aii.^(1/3))^3);
					        end
					        triangles_layer(isnan(triangles_layer)) = 0;  % Should return zeros, not NaN
					        triangles(li) = {triangles_layer};
					    end
					end
					value = triangles;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 15
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
