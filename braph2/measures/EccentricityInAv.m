classdef EccentricityInAv < EccentricityIn
	%EccentricityInAv is the graph Average In-Eccentricity.
	% It is a subclass of <a href="matlab:help EccentricityIn">EccentricityIn</a>.
	%
	% The Average In-Eccentricity (EccentricityInAv) of a node is the sum of the nodal 
	% in-eccentricities divided by their number within a layer.
	%
	% The list of EccentricityInAv properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Average In-Eccentricity.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Average In-Eccentricity.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Average In-Eccentricity.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Average In-Eccentricity.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Average In-Eccentricity.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Average In-Eccentricity.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Average In-Eccentricity.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Average In-Eccentricity.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>16</strong> <strong>RULE</strong> 	RULE (parameter, OPTION)  % calculation in a graph or its subgraph
	%
	% EccentricityInAv methods (constructor):
	%  EccentricityInAv - constructor
	%
	% EccentricityInAv methods:
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
	% EccentricityInAv methods (display):
	%  tostring - string with information about the average in-eccentricity
	%  disp - displays information about the average in-eccentricity
	%  tree - displays the tree of the average in-eccentricity
	%
	% EccentricityInAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average in-eccentricity are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average in-eccentricity
	%
	% EccentricityInAv methods (save/load, Static):
	%  save - saves BRAPH2 average in-eccentricity as b2 file
	%  load - loads a BRAPH2 average in-eccentricity from a b2 file
	%
	% EccentricityInAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average in-eccentricity
	%
	% EccentricityInAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average in-eccentricity
	%
	% EccentricityInAv methods (inspection, Static):
	%  getClass - returns the class of the average in-eccentricity
	%  getSubclasses - returns all subclasses of EccentricityInAv
	%  getProps - returns the property list of the average in-eccentricity
	%  getPropNumber - returns the property number of the average in-eccentricity
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
	% EccentricityInAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% EccentricityInAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% EccentricityInAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% EccentricityInAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?EccentricityInAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">EccentricityInAv constants</a>.
	%
	
	methods % constructor
		function m = EccentricityInAv(varargin)
			%EccentricityInAv() creates a average in-eccentricity.
			%
			% EccentricityInAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% EccentricityInAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of EccentricityInAv properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Average In-Eccentricity.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Average In-Eccentricity.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Average In-Eccentricity.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Average In-Eccentricity.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Average In-Eccentricity.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Average In-Eccentricity.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Average In-Eccentricity.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Average In-Eccentricity.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>16</strong> <strong>RULE</strong> 	RULE (parameter, OPTION)  % calculation in a graph or its subgraph
			%
			% See also Category, Format.
			
			m = m@EccentricityIn(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the average in-eccentricity.
			%
			% BUILD = EccentricityInAv.GETBUILD() returns the build of 'EccentricityInAv'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the average in-eccentricity M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('EccentricityInAv') returns the build of 'EccentricityInAv'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('EccentricityInAv')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the average in-eccentricity.
			%
			% CLASS = EccentricityInAv.GETCLASS() returns the class 'EccentricityInAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average in-eccentricity M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('EccentricityInAv') returns 'EccentricityInAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('EccentricityInAv')
			%  are less computationally efficient.
			
			m_class = 'EccentricityInAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average in-eccentricity.
			%
			% LIST = EccentricityInAv.GETSUBCLASSES() returns all subclasses of 'EccentricityInAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average in-eccentricity M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('EccentricityInAv') returns all subclasses of 'EccentricityInAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('EccentricityInAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'EccentricityInAv' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average in-eccentricity.
			%
			% PROPS = EccentricityInAv.GETPROPS() returns the property list of average in-eccentricity
			%  as a row vector.
			%
			% PROPS = EccentricityInAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average in-eccentricity M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('EccentricityInAv'[, CATEGORY]) returns the property list of 'EccentricityInAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('EccentricityInAv')
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
			%GETPROPNUMBER returns the property number of average in-eccentricity.
			%
			% N = EccentricityInAv.GETPROPNUMBER() returns the property number of average in-eccentricity.
			%
			% N = EccentricityInAv.GETPROPNUMBER(CATEGORY) returns the property number of average in-eccentricity
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average in-eccentricity M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('EccentricityInAv') returns the property number of 'EccentricityInAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('EccentricityInAv')
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
			%EXISTSPROP checks whether property exists in average in-eccentricity/error.
			%
			% CHECK = EccentricityInAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(EccentricityInAv, PROP) checks whether PROP exists for EccentricityInAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:EccentricityInAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityInAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityInAv:WrongInput]
			%  Element.EXISTSPROP(EccentricityInAv, PROP) throws error if PROP does NOT exist for EccentricityInAv.
			%   Error id: [BRAPH2:EccentricityInAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('EccentricityInAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 16 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':EccentricityInAv:' 'WrongInput'], ...
					['BRAPH2' ':EccentricityInAv:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for EccentricityInAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average in-eccentricity/error.
			%
			% CHECK = EccentricityInAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(EccentricityInAv, TAG) checks whether TAG exists for EccentricityInAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:EccentricityInAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityInAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityInAv:WrongInput]
			%  Element.EXISTSTAG(EccentricityInAv, TAG) throws error if TAG does NOT exist for EccentricityInAv.
			%   Error id: [BRAPH2:EccentricityInAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('EccentricityInAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':EccentricityInAv:' 'WrongInput'], ...
					['BRAPH2' ':EccentricityInAv:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for EccentricityInAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(EccentricityInAv, POINTER) returns property number of POINTER of EccentricityInAv.
			%  PROPERTY = M.GETPROPPROP(EccentricityInAv, POINTER) returns property number of POINTER of EccentricityInAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('EccentricityInAv')
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
			%  TAG = Element.GETPROPTAG(EccentricityInAv, POINTER) returns tag of POINTER of EccentricityInAv.
			%  TAG = M.GETPROPTAG(EccentricityInAv, POINTER) returns tag of POINTER of EccentricityInAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('EccentricityInAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				eccentricityinav_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE' };
				tag = eccentricityinav_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(EccentricityInAv, POINTER) returns category of POINTER of EccentricityInAv.
			%  CATEGORY = M.GETPROPCATEGORY(EccentricityInAv, POINTER) returns category of POINTER of EccentricityInAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('EccentricityInAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = EccentricityInAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			eccentricityinav_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3 };
			prop_category = eccentricityinav_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(EccentricityInAv, POINTER) returns format of POINTER of EccentricityInAv.
			%  FORMAT = M.GETPROPFORMAT(EccentricityInAv, POINTER) returns format of POINTER of EccentricityInAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('EccentricityInAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = EccentricityInAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			eccentricityinav_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  5 };
			prop_format = eccentricityinav_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(EccentricityInAv, POINTER) returns description of POINTER of EccentricityInAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(EccentricityInAv, POINTER) returns description of POINTER of EccentricityInAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('EccentricityInAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = EccentricityInAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			eccentricityinav_description_list = { 'ELCLASS (constant, string) is the class of the Average In-Eccentricity.'  'NAME (constant, string) is the name of the Average In-Eccentricity.'  'DESCRIPTION (constant, string) is the description of the Average In-Eccentricity.'  'TEMPLATE (parameter, item) is the template of the Average In-Eccentricity.'  'ID (data, string) is a few-letter code of the Average In-Eccentricity.'  'LABEL (metadata, string) is an extended label of the Average In-Eccentricity.'  'NOTES (metadata, string) are some specific notes about the Average In-Eccentricity.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Average In-Eccentricity.'  'PFM (gui, item) contains the panel figure of the measure.'  'RULE (parameter, OPTION)  % calculation in a graph or its subgraph' };
			prop_description = eccentricityinav_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(EccentricityInAv, POINTER) returns settings of POINTER of EccentricityInAv.
			%  SETTINGS = M.GETPROPSETTINGS(EccentricityInAv, POINTER) returns settings of POINTER of EccentricityInAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('EccentricityInAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = EccentricityInAv.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % EccentricityInAv.TEMPLATE
					prop_settings = 'EccentricityInAv';
				otherwise
					prop_settings = getPropSettings@EccentricityIn(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = EccentricityInAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = EccentricityInAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(EccentricityInAv, POINTER) returns the default value of POINTER of EccentricityInAv.
			%  DEFAULT = M.GETPROPDEFAULT(EccentricityInAv, POINTER) returns the default value of POINTER of EccentricityInAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('EccentricityInAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = EccentricityInAv.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % EccentricityInAv.ELCLASS
					prop_default = 'EccentricityInAv';
				case 2 % EccentricityInAv.NAME
					prop_default = 'Average In-Eccentricity';
				case 3 % EccentricityInAv.DESCRIPTION
					prop_default = 'The Average In-Eccentricity (EccentricityInAv) of a node is the sum of the nodal in-eccentricities divided by their number within a layer.';
				case 4 % EccentricityInAv.TEMPLATE
					prop_default = Format.getFormatDefault(8, EccentricityInAv.getPropSettings(prop));
				case 5 % EccentricityInAv.ID
					prop_default = 'EccentricityInAv ID';
				case 6 % EccentricityInAv.LABEL
					prop_default = 'Average In-Eccentricity label';
				case 7 % EccentricityInAv.NOTES
					prop_default = 'Average In-Eccentricity notes';
				case 9 % EccentricityInAv.SHAPE
					prop_default = 1;
				case 10 % EccentricityInAv.SCOPE
					prop_default = 2;
				case 11 % EccentricityInAv.PARAMETRICITY
					prop_default = 2;
				case 12 % EccentricityInAv.COMPATIBLE_GRAPHS
					prop_default = {'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxWD'};;
				otherwise
					prop_default = getPropDefault@EccentricityIn(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = EccentricityInAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = EccentricityInAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(EccentricityInAv, POINTER) returns the conditioned default value of POINTER of EccentricityInAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(EccentricityInAv, POINTER) returns the conditioned default value of POINTER of EccentricityInAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('EccentricityInAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = EccentricityInAv.getPropProp(pointer);
			
			prop_default = EccentricityInAv.conditioning(prop, EccentricityInAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(EccentricityInAv, PROP, VALUE) checks VALUE format for PROP of EccentricityInAv.
			%  CHECK = M.CHECKPROP(EccentricityInAv, PROP, VALUE) checks VALUE format for PROP of EccentricityInAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:EccentricityInAv:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:EccentricityInAv:WrongInput
			%  Element.CHECKPROP(EccentricityInAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EccentricityInAv.
			%   Error id: BRAPH2:EccentricityInAv:WrongInput
			%  M.CHECKPROP(EccentricityInAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EccentricityInAv.
			%   Error id: BRAPH2:EccentricityInAv:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('EccentricityInAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = EccentricityInAv.getPropProp(pointer);
			
			switch prop
				case 4 % EccentricityInAv.TEMPLATE
					check = Format.checkFormat(8, value, EccentricityInAv.getPropSettings(prop));
				otherwise
					if prop <= 16
						check = checkProp@EccentricityIn(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':EccentricityInAv:' 'WrongInput'], ...
					['BRAPH2' ':EccentricityInAv:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' EccentricityInAv.getPropTag(prop) ' (' EccentricityInAv.getFormatTag(EccentricityInAv.getPropFormat(prop)) ').'] ...
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
				case 14 % EccentricityInAv.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					
					eccentricity = calculateValue@EccentricityIn(m, prop); 
					
					eccentricity_av = cell(L, 1);
					
					parfor li = 1:L
					    eccentricity_av(li) = {mean(eccentricity{li})};
					end
					
					value = eccentricity_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 16
						value = calculateValue@EccentricityIn(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
