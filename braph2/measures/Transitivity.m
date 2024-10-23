classdef Transitivity < Triangles
	%Transitivity is the graph Transitivity.
	% It is a subclass of <a href="matlab:help Triangles">Triangles</a>.
	%
	% The Transitivity (Transitivity) of a graph is the fraction of triangles to the number 
	%  of (unordered) triplets within a layer.
	%
	% The list of Transitivity properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Transitivity.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Transitivity.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Transitivity.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Transitivity.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Transitivity.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Transitivity.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Transitivity.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Transitivity.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>16</strong> <strong>RULE</strong> 	RULE (parameter, option) is the rule to determine what is a triangle in a directed graph.
	%
	% Transitivity methods (constructor):
	%  Transitivity - constructor
	%
	% Transitivity methods:
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
	% Transitivity methods (display):
	%  tostring - string with information about the transitivity
	%  disp - displays information about the transitivity
	%  tree - displays the tree of the transitivity
	%
	% Transitivity methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two transitivity are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the transitivity
	%
	% Transitivity methods (save/load, Static):
	%  save - saves BRAPH2 transitivity as b2 file
	%  load - loads a BRAPH2 transitivity from a b2 file
	%
	% Transitivity method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the transitivity
	%
	% Transitivity method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the transitivity
	%
	% Transitivity methods (inspection, Static):
	%  getClass - returns the class of the transitivity
	%  getSubclasses - returns all subclasses of Transitivity
	%  getProps - returns the property list of the transitivity
	%  getPropNumber - returns the property number of the transitivity
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
	% Transitivity methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Transitivity methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Transitivity methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Transitivity methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Transitivity; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Transitivity constants</a>.
	%
	
	methods % constructor
		function m = Transitivity(varargin)
			%Transitivity() creates a transitivity.
			%
			% Transitivity(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Transitivity(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Transitivity properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Transitivity.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Transitivity.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Transitivity.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Transitivity.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Transitivity.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Transitivity.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Transitivity.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Transitivity.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>16</strong> <strong>RULE</strong> 	RULE (parameter, option) is the rule to determine what is a triangle in a directed graph.
			%
			% See also Category, Format.
			
			m = m@Triangles(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the transitivity.
			%
			% BUILD = Transitivity.GETBUILD() returns the build of 'Transitivity'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the transitivity M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('Transitivity') returns the build of 'Transitivity'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('Transitivity')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the transitivity.
			%
			% CLASS = Transitivity.GETCLASS() returns the class 'Transitivity'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the transitivity M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Transitivity') returns 'Transitivity'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('Transitivity')
			%  are less computationally efficient.
			
			m_class = 'Transitivity';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the transitivity.
			%
			% LIST = Transitivity.GETSUBCLASSES() returns all subclasses of 'Transitivity'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the transitivity M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('Transitivity') returns all subclasses of 'Transitivity'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('Transitivity')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'Transitivity' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of transitivity.
			%
			% PROPS = Transitivity.GETPROPS() returns the property list of transitivity
			%  as a row vector.
			%
			% PROPS = Transitivity.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the transitivity M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Transitivity'[, CATEGORY]) returns the property list of 'Transitivity'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('Transitivity')
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
			%GETPROPNUMBER returns the property number of transitivity.
			%
			% N = Transitivity.GETPROPNUMBER() returns the property number of transitivity.
			%
			% N = Transitivity.GETPROPNUMBER(CATEGORY) returns the property number of transitivity
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the transitivity M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Transitivity') returns the property number of 'Transitivity'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('Transitivity')
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
			%EXISTSPROP checks whether property exists in transitivity/error.
			%
			% CHECK = Transitivity.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Transitivity, PROP) checks whether PROP exists for Transitivity.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Transitivity:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Transitivity:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Transitivity:WrongInput]
			%  Element.EXISTSPROP(Transitivity, PROP) throws error if PROP does NOT exist for Transitivity.
			%   Error id: [BRAPH2:Transitivity:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('Transitivity')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 16 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Transitivity:' 'WrongInput'], ...
					['BRAPH2' ':Transitivity:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Transitivity.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in transitivity/error.
			%
			% CHECK = Transitivity.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Transitivity, TAG) checks whether TAG exists for Transitivity.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Transitivity:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Transitivity:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Transitivity:WrongInput]
			%  Element.EXISTSTAG(Transitivity, TAG) throws error if TAG does NOT exist for Transitivity.
			%   Error id: [BRAPH2:Transitivity:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('Transitivity')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Transitivity:' 'WrongInput'], ...
					['BRAPH2' ':Transitivity:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for Transitivity.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Transitivity, POINTER) returns property number of POINTER of Transitivity.
			%  PROPERTY = M.GETPROPPROP(Transitivity, POINTER) returns property number of POINTER of Transitivity.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('Transitivity')
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
			%  TAG = Element.GETPROPTAG(Transitivity, POINTER) returns tag of POINTER of Transitivity.
			%  TAG = M.GETPROPTAG(Transitivity, POINTER) returns tag of POINTER of Transitivity.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('Transitivity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				transitivity_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE' };
				tag = transitivity_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(Transitivity, POINTER) returns category of POINTER of Transitivity.
			%  CATEGORY = M.GETPROPCATEGORY(Transitivity, POINTER) returns category of POINTER of Transitivity.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('Transitivity')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Transitivity.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			transitivity_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3 };
			prop_category = transitivity_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(Transitivity, POINTER) returns format of POINTER of Transitivity.
			%  FORMAT = M.GETPROPFORMAT(Transitivity, POINTER) returns format of POINTER of Transitivity.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('Transitivity')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Transitivity.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			transitivity_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  5 };
			prop_format = transitivity_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Transitivity, POINTER) returns description of POINTER of Transitivity.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Transitivity, POINTER) returns description of POINTER of Transitivity.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('Transitivity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Transitivity.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			transitivity_description_list = { 'ELCLASS (constant, string) is the class of the Transitivity.'  'NAME (constant, string) is the name of the Transitivity.'  'DESCRIPTION (constant, string) is the description of the Transitivity.'  'TEMPLATE (parameter, item) is the template of the Transitivity.'  'ID (data, string) is a few-letter code of the Transitivity.'  'LABEL (metadata, string) is an extended label of the Transitivity.'  'NOTES (metadata, string) are some specific notes about the Transitivity.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Transitivity.'  'PFM (gui, item) contains the panel figure of the measure.'  'RULE (parameter, option) is the rule to determine what is a triangle in a directed graph.' };
			prop_description = transitivity_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(Transitivity, POINTER) returns settings of POINTER of Transitivity.
			%  SETTINGS = M.GETPROPSETTINGS(Transitivity, POINTER) returns settings of POINTER of Transitivity.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('Transitivity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Transitivity.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % Transitivity.TEMPLATE
					prop_settings = 'Transitivity';
				otherwise
					prop_settings = getPropSettings@Triangles(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Transitivity.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Transitivity.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Transitivity, POINTER) returns the default value of POINTER of Transitivity.
			%  DEFAULT = M.GETPROPDEFAULT(Transitivity, POINTER) returns the default value of POINTER of Transitivity.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('Transitivity')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Transitivity.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % Transitivity.ELCLASS
					prop_default = 'Transitivity';
				case 2 % Transitivity.NAME
					prop_default = 'Transitivity';
				case 3 % Transitivity.DESCRIPTION
					prop_default = 'The Transitivity (Transitivity) of a graph is the fraction of triangles to the number of (unordered) triplets within a layer.';
				case 4 % Transitivity.TEMPLATE
					prop_default = Format.getFormatDefault(8, Transitivity.getPropSettings(prop));
				case 5 % Transitivity.ID
					prop_default = 'Transitivity ID';
				case 6 % Transitivity.LABEL
					prop_default = 'Transitivity label';
				case 7 % Transitivity.NOTES
					prop_default = 'Transitivity notes';
				case 9 % Transitivity.SHAPE
					prop_default = 1;
				case 10 % Transitivity.SCOPE
					prop_default = 2;
				case 11 % Transitivity.PARAMETRICITY
					prop_default = 2;
				case 12 % Transitivity.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT' 'MultilayerWU' 'OrdMlWU'};
				otherwise
					prop_default = getPropDefault@Triangles(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Transitivity.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Transitivity.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Transitivity, POINTER) returns the conditioned default value of POINTER of Transitivity.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Transitivity, POINTER) returns the conditioned default value of POINTER of Transitivity.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('Transitivity')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Transitivity.getPropProp(pointer);
			
			prop_default = Transitivity.conditioning(prop, Transitivity.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Transitivity, PROP, VALUE) checks VALUE format for PROP of Transitivity.
			%  CHECK = M.CHECKPROP(Transitivity, PROP, VALUE) checks VALUE format for PROP of Transitivity.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:Transitivity:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:Transitivity:WrongInput
			%  Element.CHECKPROP(Transitivity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Transitivity.
			%   Error id: BRAPH2:Transitivity:WrongInput
			%  M.CHECKPROP(Transitivity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Transitivity.
			%   Error id: BRAPH2:Transitivity:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('Transitivity')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Transitivity.getPropProp(pointer);
			
			switch prop
				case 4 % Transitivity.TEMPLATE
					check = Format.checkFormat(8, value, Transitivity.getPropSettings(prop));
				otherwise
					if prop <= 16
						check = checkProp@Triangles(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Transitivity:' 'WrongInput'], ...
					['BRAPH2' ':Transitivity:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Transitivity.getPropTag(prop) ' (' Transitivity.getFormatTag(Transitivity.getPropFormat(prop)) ').'] ...
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
				case 14 % Transitivity.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					
					transitivity = cell(L, 1);
					triangles = calculateValue@Triangles(m, prop);
					
					directionality_type =  g.get('DIRECTIONALITY_TYPE', g.get('LAYERNUMBER'));
					parfor li = 1:1:L      
					    Aii = A{li, li};
					    if directionality_type == 2  % undirected graphs
					        
					        degree = Degree('G', g).get('M');
					        
					        transitivity_layer = 2 * sum(triangles{li}) ./ sum((degree{li} .* (degree{li} - 1)));
					        
					    else  % directed graphs
					        
					        in_degree = DegreeIn('G', g).get('M');
					        
					        out_degree = DegreeOut('G', g).get('M');
					        
					        transitivity_layer = sum(triangles{li}) ./ sum(((out_degree{li} + in_degree{li}) .* (out_degree{li} + in_degree{li} - 1) - 2 * diag(Aii^2)));
					    end
					    transitivity_layer(isnan(transitivity_layer)) = 0;  % Should return zeros, not NaN
					    transitivity(li) = {transitivity_layer};
					end
					value = transitivity;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 16
						value = calculateValue@Triangles(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
