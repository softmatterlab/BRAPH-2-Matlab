classdef MultiplexRCS < RCS
	%MultiplexRCS is the graph Multiplex Rich-Club Strength.
	% It is a subclass of <a href="matlab:help RCS">RCS</a>.
	%
	% The Multiplex Rich-Club Strength (MultiplexRCS) of a node at level s is the sum of the 
	%  weighted edges that connect nodes of strength s or higher in all layers. 
	% The relevance of each layer is controlled by the coefficients c that are 
	%  between 0 and 1; the default coefficients are (1/layernumber).
	%
	% The list of MultiplexRCS properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Multiplex Rich-Club Strength.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Multiplex Rich-Club Strength.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Multiplex Rich-Club Strength.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Multiplex Rich-Club Strength.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Multiplex Rich-Club Strength.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Multiplex Rich-Club Strength.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Multiplex Rich-Club Strength.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Multiplex Rich-Club Strength.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>16</strong> <strong>PARAMETRIC_VALUE</strong> 	PARAMETRIC_VALUE (parameter, RVECTOR) is the strength level.
	%  <strong>17</strong> <strong>WEIGHTED_MULTIRICHCLUB_COEFFICIENTS</strong> 	WEIGHTED_MULTIRICHCLUB_COEFFICIENTS (parameter, RVECTOR) is the multi rich-club strength coefficients
	%
	% MultiplexRCS methods (constructor):
	%  MultiplexRCS - constructor
	%
	% MultiplexRCS methods:
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
	% MultiplexRCS methods (display):
	%  tostring - string with information about the multi rich-club strength
	%  disp - displays information about the multi rich-club strength
	%  tree - displays the tree of the multi rich-club strength
	%
	% MultiplexRCS methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multi rich-club strength are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multi rich-club strength
	%
	% MultiplexRCS methods (save/load, Static):
	%  save - saves BRAPH2 multi rich-club strength as b2 file
	%  load - loads a BRAPH2 multi rich-club strength from a b2 file
	%
	% MultiplexRCS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multi rich-club strength
	%
	% MultiplexRCS method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multi rich-club strength
	%
	% MultiplexRCS methods (inspection, Static):
	%  getClass - returns the class of the multi rich-club strength
	%  getSubclasses - returns all subclasses of MultiplexRCS
	%  getProps - returns the property list of the multi rich-club strength
	%  getPropNumber - returns the property number of the multi rich-club strength
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
	% MultiplexRCS methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiplexRCS methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiplexRCS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexRCS methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiplexRCS; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiplexRCS constants</a>.
	%
	
	properties (Constant) % properties
		WEIGHTED_MULTIRICHCLUB_COEFFICIENTS = 17; %CET: Computational Efficiency Trick
		WEIGHTED_MULTIRICHCLUB_COEFFICIENTS_TAG = 'WEIGHTED_MULTIRICHCLUB_COEFFICIENTS';
		WEIGHTED_MULTIRICHCLUB_COEFFICIENTS_CATEGORY = 3;
		WEIGHTED_MULTIRICHCLUB_COEFFICIENTS_FORMAT = 12;
	end
	methods % constructor
		function m = MultiplexRCS(varargin)
			%MultiplexRCS() creates a multi rich-club strength.
			%
			% MultiplexRCS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexRCS(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of MultiplexRCS properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Multiplex Rich-Club Strength.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Multiplex Rich-Club Strength.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Multiplex Rich-Club Strength.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Multiplex Rich-Club Strength.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Multiplex Rich-Club Strength.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Multiplex Rich-Club Strength.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Multiplex Rich-Club Strength.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Multiplex Rich-Club Strength.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>16</strong> <strong>PARAMETRIC_VALUE</strong> 	PARAMETRIC_VALUE (parameter, RVECTOR) is the strength level.
			%  <strong>17</strong> <strong>WEIGHTED_MULTIRICHCLUB_COEFFICIENTS</strong> 	WEIGHTED_MULTIRICHCLUB_COEFFICIENTS (parameter, RVECTOR) is the multi rich-club strength coefficients
			%
			% See also Category, Format.
			
			m = m@RCS(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the multi rich-club strength.
			%
			% BUILD = MultiplexRCS.GETBUILD() returns the build of 'MultiplexRCS'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the multi rich-club strength M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('MultiplexRCS') returns the build of 'MultiplexRCS'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('MultiplexRCS')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the multi rich-club strength.
			%
			% CLASS = MultiplexRCS.GETCLASS() returns the class 'MultiplexRCS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multi rich-club strength M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultiplexRCS') returns 'MultiplexRCS'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('MultiplexRCS')
			%  are less computationally efficient.
			
			m_class = 'MultiplexRCS';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multi rich-club strength.
			%
			% LIST = MultiplexRCS.GETSUBCLASSES() returns all subclasses of 'MultiplexRCS'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the multi rich-club strength M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('MultiplexRCS') returns all subclasses of 'MultiplexRCS'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('MultiplexRCS')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'MultiplexRCS' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multi rich-club strength.
			%
			% PROPS = MultiplexRCS.GETPROPS() returns the property list of multi rich-club strength
			%  as a row vector.
			%
			% PROPS = MultiplexRCS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multi rich-club strength M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultiplexRCS'[, CATEGORY]) returns the property list of 'MultiplexRCS'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('MultiplexRCS')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3 9 10 11 12];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 16 17];
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
			%GETPROPNUMBER returns the property number of multi rich-club strength.
			%
			% N = MultiplexRCS.GETPROPNUMBER() returns the property number of multi rich-club strength.
			%
			% N = MultiplexRCS.GETPROPNUMBER(CATEGORY) returns the property number of multi rich-club strength
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the multi rich-club strength M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultiplexRCS') returns the property number of 'MultiplexRCS'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('MultiplexRCS')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 17;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 7;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 3;
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
			%EXISTSPROP checks whether property exists in multi rich-club strength/error.
			%
			% CHECK = MultiplexRCS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultiplexRCS, PROP) checks whether PROP exists for MultiplexRCS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexRCS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexRCS:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexRCS:WrongInput]
			%  Element.EXISTSPROP(MultiplexRCS, PROP) throws error if PROP does NOT exist for MultiplexRCS.
			%   Error id: [BRAPH2:MultiplexRCS:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('MultiplexRCS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 17 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultiplexRCS:' 'WrongInput'], ...
					['BRAPH2' ':MultiplexRCS:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexRCS.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multi rich-club strength/error.
			%
			% CHECK = MultiplexRCS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultiplexRCS, TAG) checks whether TAG exists for MultiplexRCS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexRCS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexRCS:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexRCS:WrongInput]
			%  Element.EXISTSTAG(MultiplexRCS, TAG) throws error if TAG does NOT exist for MultiplexRCS.
			%   Error id: [BRAPH2:MultiplexRCS:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('MultiplexRCS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'PARAMETRIC_VALUE'  'WEIGHTED_MULTIRICHCLUB_COEFFICIENTS' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultiplexRCS:' 'WrongInput'], ...
					['BRAPH2' ':MultiplexRCS:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for MultiplexRCS.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexRCS, POINTER) returns property number of POINTER of MultiplexRCS.
			%  PROPERTY = M.GETPROPPROP(MultiplexRCS, POINTER) returns property number of POINTER of MultiplexRCS.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('MultiplexRCS')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'PARAMETRIC_VALUE'  'WEIGHTED_MULTIRICHCLUB_COEFFICIENTS' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(MultiplexRCS, POINTER) returns tag of POINTER of MultiplexRCS.
			%  TAG = M.GETPROPTAG(MultiplexRCS, POINTER) returns tag of POINTER of MultiplexRCS.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('MultiplexRCS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				multiplexrcs_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'PARAMETRIC_VALUE'  'WEIGHTED_MULTIRICHCLUB_COEFFICIENTS' };
				tag = multiplexrcs_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexRCS, POINTER) returns category of POINTER of MultiplexRCS.
			%  CATEGORY = M.GETPROPCATEGORY(MultiplexRCS, POINTER) returns category of POINTER of MultiplexRCS.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('MultiplexRCS')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexRCS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multiplexrcs_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3  3 };
			prop_category = multiplexrcs_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexRCS, POINTER) returns format of POINTER of MultiplexRCS.
			%  FORMAT = M.GETPROPFORMAT(MultiplexRCS, POINTER) returns format of POINTER of MultiplexRCS.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('MultiplexRCS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexRCS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multiplexrcs_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  12  12 };
			prop_format = multiplexrcs_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexRCS, POINTER) returns description of POINTER of MultiplexRCS.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultiplexRCS, POINTER) returns description of POINTER of MultiplexRCS.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('MultiplexRCS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexRCS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multiplexrcs_description_list = { 'ELCLASS (constant, string) is the class of the Multiplex Rich-Club Strength.'  'NAME (constant, string) is the name of the Multiplex Rich-Club Strength.'  'DESCRIPTION (constant, string) is the description of the Multiplex Rich-Club Strength.'  'TEMPLATE (parameter, item) is the template of the Multiplex Rich-Club Strength.'  'ID (data, string) is a few-letter code of the Multiplex Rich-Club Strength.'  'LABEL (metadata, string) is an extended label of the Multiplex Rich-Club Strength.'  'NOTES (metadata, string) are some specific notes about the Multiplex Rich-Club Strength.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Multiplex Rich-Club Strength.'  'PFM (gui, item) contains the panel figure of the measure.'  'PARAMETRIC_VALUE (parameter, RVECTOR) is the strength level.'  'WEIGHTED_MULTIRICHCLUB_COEFFICIENTS (parameter, RVECTOR) is the multi rich-club strength coefficients' };
			prop_description = multiplexrcs_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexRCS, POINTER) returns settings of POINTER of MultiplexRCS.
			%  SETTINGS = M.GETPROPSETTINGS(MultiplexRCS, POINTER) returns settings of POINTER of MultiplexRCS.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('MultiplexRCS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexRCS.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 17 % MultiplexRCS.WEIGHTED_MULTIRICHCLUB_COEFFICIENTS
					prop_settings = Format.getFormatSettings(12);
				case 4 % Multiplex4
					prop_settings = 'MultiplexRCS';
				otherwise
					prop_settings = getPropSettings@RCS(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexRCS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexRCS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexRCS, POINTER) returns the default value of POINTER of MultiplexRCS.
			%  DEFAULT = M.GETPROPDEFAULT(MultiplexRCS, POINTER) returns the default value of POINTER of MultiplexRCS.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('MultiplexRCS')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexRCS.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 17 % MultiplexRCS.WEIGHTED_MULTIRICHCLUB_COEFFICIENTS
					prop_default = [0];
				case 1 % Multiplex1
					prop_default = 'MultiplexRCS';
				case 2 % Multiplex2
					prop_default = 'Multiplex Rich-Club Strength';
				case 3 % Multiplex3
					prop_default = 'The Multiplex Rich-Club Strength (MultiplexRCS) of a node at level s is the sum of the weighted edges that connect nodes of strength s or higher in all layers. The relevance of each layer is controlled by the coefficients c that are between 0 and 1; the default coefficients are (1/layernumber).';
				case 4 % Multiplex4
					prop_default = Format.getFormatDefault(8, MultiplexRCS.getPropSettings(prop));
				case 5 % Multiplex5
					prop_default = 'MultiplexRCS ID';
				case 6 % Multiplex6
					prop_default = 'Multiplex Rich-Club Strength label';
				case 7 % Multiplex7
					prop_default = 'Multiplex Rich-Club Strength notes';
				case 9 % Multiplex9
					prop_default = 2;
				case 10 % Multiplex10
					prop_default = 1;
				case 11 % Multiplex11
					prop_default = 2;
				case 12 % Multiplex12
					prop_default = {'MultiplexWU' 'MultiplexWD' 'OrdMxWU'};;
				otherwise
					prop_default = getPropDefault@RCS(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexRCS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexRCS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexRCS, POINTER) returns the conditioned default value of POINTER of MultiplexRCS.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultiplexRCS, POINTER) returns the conditioned default value of POINTER of MultiplexRCS.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('MultiplexRCS')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiplexRCS.getPropProp(pointer);
			
			prop_default = MultiplexRCS.conditioning(prop, MultiplexRCS.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexRCS, PROP, VALUE) checks VALUE format for PROP of MultiplexRCS.
			%  CHECK = M.CHECKPROP(MultiplexRCS, PROP, VALUE) checks VALUE format for PROP of MultiplexRCS.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:MultiplexRCS:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:MultiplexRCS:WrongInput
			%  Element.CHECKPROP(MultiplexRCS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexRCS.
			%   Error id: BRAPH2:MultiplexRCS:WrongInput
			%  M.CHECKPROP(MultiplexRCS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexRCS.
			%   Error id: BRAPH2:MultiplexRCS:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('MultiplexRCS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiplexRCS.getPropProp(pointer);
			
			switch prop
				case 17 % MultiplexRCS.WEIGHTED_MULTIRICHCLUB_COEFFICIENTS
					check = Format.checkFormat(12, value, MultiplexRCS.getPropSettings(prop));
				case 4 % Multiplex4
					check = Format.checkFormat(8, value, MultiplexRCS.getPropSettings(prop));
				otherwise
					if prop <= 16
						check = checkProp@RCS(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultiplexRCS:' 'WrongInput'], ...
					['BRAPH2' ':MultiplexRCS:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexRCS.getPropTag(prop) ' (' MultiplexRCS.getFormatTag(MultiplexRCS.getPropFormat(prop)) ').'] ...
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
				case 14 % Multiplex14
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					ls = g.get('PARTITIONS');
					
					rich_club_strength = calculateValue@RCS(m, prop);   
					
					if l == 0
					    value = {};
					else
					    N = g.get('NODENUMBER');
					    weighted_rich_club_threshold = m.get('PARAMETRIC_VALUE');
					    s_levels = abs(weighted_rich_club_threshold);
					
					    weighted_multi_rich_club_coefficients = m.get('WEIGHTED_MULTIRICHCLUB_COEFFICIENTS');
					    assert(length(weighted_multi_rich_club_coefficients) == l || all(weighted_multi_rich_club_coefficients == 0), ...
					        ['BRAPH2' ':WeightedMultiRichClubCoefficients:' 'WrongInput'], ...
					        ['WeightedMultiRichClubCoefficients coefficients must have the same length than the ' ...
					        'number of layers (' tostring(l) ') while its length is ' tostring(length(weighted_multi_rich_club_coefficients))])
					    
					    if length(weighted_multi_rich_club_coefficients) == l
					        assert(all(weighted_multi_rich_club_coefficients <= 1) && all(weighted_multi_rich_club_coefficients >= 0), ...
					            ['BRAPH2' ':WeightedMultiRichClubCoefficients:' 'WrongInput'], ...
					            ['WeightedMultiRichClubCoefficients coefficients must be between 0 and 1 ' ...
					            'while they are ' tostring(weighted_multi_rich_club_coefficients)])
					        c = weighted_multi_rich_club_coefficients;
					    else  % same relevance for each layer
					        c = ones(1, l)/l;
					    end
					    
					    multi_rich_club_strength = zeros(N(1), 1, length(s_levels));
					    for li = 1:1:l
					        wrich = rich_club_strength{li};
					        % loop over the 3rd dimension of richness (s_level)
					        for s = 1:1:length(s_levels)
					            multi_rich_club_strength(:, :, s) = multi_rich_club_strength(:, :, s) + c(li)*wrich(:, :, s);
					        end
					    end
					    value = {multi_rich_club_strength};
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 16
						value = calculateValue@RCS(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
