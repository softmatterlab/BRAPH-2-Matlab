classdef MultiRC < Richness
	%MultiRC is the graph Multirichness.
	% It is a subclass of <a href="matlab:help Richness">Richness</a>.
	%
	% The Multirichness (MultiRC) of a node is the sum of the edges that connect nodes 
	%  of degree k or higher in all layers. The relevance of each layer is 
	%  controlled by the coefficients c that are between 0 and 1; 
	%  the default coefficients are (1/layernumber).
	%
	% The list of MultiRC properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Multirichness.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Multirichness.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Multirichness.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the multirichness.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Multirichness.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Multirichness.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Multirichness.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Multirichness.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>16</strong> <strong>MULTIRICHNESS_COEFFICIENTS</strong> 	MULTIRICHNESS_COEFFICIENTS (parameter, RVECTOR) are the coefficients c that are between 0 and 1 that control the relevance of each layer, the default coefficients are (1/layernumber).
	%
	% MultiRC methods (constructor):
	%  MultiRC - constructor
	%
	% MultiRC methods:
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
	% MultiRC methods (display):
	%  tostring - string with information about the multirichness
	%  disp - displays information about the multirichness
	%  tree - displays the tree of the multirichness
	%
	% MultiRC methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multirichness are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multirichness
	%
	% MultiRC methods (save/load, Static):
	%  save - saves BRAPH2 multirichness as b2 file
	%  load - loads a BRAPH2 multirichness from a b2 file
	%
	% MultiRC method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multirichness
	%
	% MultiRC method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multirichness
	%
	% MultiRC methods (inspection, Static):
	%  getClass - returns the class of the multirichness
	%  getSubclasses - returns all subclasses of MultiRC
	%  getProps - returns the property list of the multirichness
	%  getPropNumber - returns the property number of the multirichness
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
	% MultiRC methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiRC methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiRC methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiRC methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiRC; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiRC constants</a>.
	%
	
	properties (Constant) % properties
		MULTIRICHNESS_COEFFICIENTS = 16; %CET: Computational Efficiency Trick
		MULTIRICHNESS_COEFFICIENTS_TAG = 'MULTIRICHNESS_COEFFICIENTS';
		MULTIRICHNESS_COEFFICIENTS_CATEGORY = 3;
		MULTIRICHNESS_COEFFICIENTS_FORMAT = 12;
	end
	methods % constructor
		function m = MultiRC(varargin)
			%MultiRC() creates a multirichness.
			%
			% MultiRC(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiRC(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of MultiRC properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Multirichness.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Multirichness.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Multirichness.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the multirichness.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Multirichness.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Multirichness.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Multirichness.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Multirichness.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>16</strong> <strong>MULTIRICHNESS_COEFFICIENTS</strong> 	MULTIRICHNESS_COEFFICIENTS (parameter, RVECTOR) are the coefficients c that are between 0 and 1 that control the relevance of each layer, the default coefficients are (1/layernumber).
			%
			% See also Category, Format.
			
			m = m@Richness(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the multirichness.
			%
			% BUILD = MultiRC.GETBUILD() returns the build of 'MultiRC'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the multirichness M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('MultiRC') returns the build of 'MultiRC'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('MultiRC')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the multirichness.
			%
			% CLASS = MultiRC.GETCLASS() returns the class 'MultiRC'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multirichness M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultiRC') returns 'MultiRC'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('MultiRC')
			%  are less computationally efficient.
			
			m_class = 'MultiRC';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multirichness.
			%
			% LIST = MultiRC.GETSUBCLASSES() returns all subclasses of 'MultiRC'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the multirichness M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('MultiRC') returns all subclasses of 'MultiRC'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('MultiRC')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'MultiRC'  'MultiplexCP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multirichness.
			%
			% PROPS = MultiRC.GETPROPS() returns the property list of multirichness
			%  as a row vector.
			%
			% PROPS = MultiRC.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multirichness M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultiRC'[, CATEGORY]) returns the property list of 'MultiRC'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('MultiRC')
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
			%GETPROPNUMBER returns the property number of multirichness.
			%
			% N = MultiRC.GETPROPNUMBER() returns the property number of multirichness.
			%
			% N = MultiRC.GETPROPNUMBER(CATEGORY) returns the property number of multirichness
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the multirichness M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultiRC') returns the property number of 'MultiRC'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('MultiRC')
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
			%EXISTSPROP checks whether property exists in multirichness/error.
			%
			% CHECK = MultiRC.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultiRC, PROP) checks whether PROP exists for MultiRC.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiRC:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiRC:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiRC:WrongInput]
			%  Element.EXISTSPROP(MultiRC, PROP) throws error if PROP does NOT exist for MultiRC.
			%   Error id: [BRAPH2:MultiRC:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('MultiRC')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 16 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultiRC:' 'WrongInput'], ...
					['BRAPH2' ':MultiRC:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiRC.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multirichness/error.
			%
			% CHECK = MultiRC.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultiRC, TAG) checks whether TAG exists for MultiRC.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiRC:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiRC:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiRC:WrongInput]
			%  Element.EXISTSTAG(MultiRC, TAG) throws error if TAG does NOT exist for MultiRC.
			%   Error id: [BRAPH2:MultiRC:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('MultiRC')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'MULTIRICHNESS_COEFFICIENTS' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultiRC:' 'WrongInput'], ...
					['BRAPH2' ':MultiRC:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for MultiRC.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiRC, POINTER) returns property number of POINTER of MultiRC.
			%  PROPERTY = M.GETPROPPROP(MultiRC, POINTER) returns property number of POINTER of MultiRC.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('MultiRC')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'MULTIRICHNESS_COEFFICIENTS' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(MultiRC, POINTER) returns tag of POINTER of MultiRC.
			%  TAG = M.GETPROPTAG(MultiRC, POINTER) returns tag of POINTER of MultiRC.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('MultiRC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				multirc_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'MULTIRICHNESS_COEFFICIENTS' };
				tag = multirc_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiRC, POINTER) returns category of POINTER of MultiRC.
			%  CATEGORY = M.GETPROPCATEGORY(MultiRC, POINTER) returns category of POINTER of MultiRC.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('MultiRC')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiRC.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multirc_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3 };
			prop_category = multirc_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(MultiRC, POINTER) returns format of POINTER of MultiRC.
			%  FORMAT = M.GETPROPFORMAT(MultiRC, POINTER) returns format of POINTER of MultiRC.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('MultiRC')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiRC.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multirc_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  12 };
			prop_format = multirc_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiRC, POINTER) returns description of POINTER of MultiRC.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultiRC, POINTER) returns description of POINTER of MultiRC.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('MultiRC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiRC.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multirc_description_list = { 'ELCLASS (constant, string) is the class of the Multirichness.'  'NAME (constant, string) is the name of the Multirichness.'  'DESCRIPTION (constant, string) is the description of the Multirichness.'  'TEMPLATE (parameter, item) is the template of the multirichness.'  'ID (data, string) is a few-letter code of the Multirichness.'  'LABEL (metadata, string) is an extended label of the Multirichness.'  'NOTES (metadata, string) are some specific notes about the Multirichness.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Multirichness.'  'PFM (gui, item) contains the panel figure of the measure.'  'MULTIRICHNESS_COEFFICIENTS (parameter, RVECTOR) are the coefficients c that are between 0 and 1 that control the relevance of each layer, the default coefficients are (1/layernumber).' };
			prop_description = multirc_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiRC, POINTER) returns settings of POINTER of MultiRC.
			%  SETTINGS = M.GETPROPSETTINGS(MultiRC, POINTER) returns settings of POINTER of MultiRC.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('MultiRC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiRC.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % MultiRC.MULTIRICHNESS_COEFFICIENTS
					prop_settings = Format.getFormatSettings(12);
				case 4 % MultiRC.TEMPLATE
					prop_settings = 'MultiRC';
				otherwise
					prop_settings = getPropSettings@Richness(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiRC.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiRC.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiRC, POINTER) returns the default value of POINTER of MultiRC.
			%  DEFAULT = M.GETPROPDEFAULT(MultiRC, POINTER) returns the default value of POINTER of MultiRC.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('MultiRC')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiRC.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % MultiRC.MULTIRICHNESS_COEFFICIENTS
					prop_default = [0];
				case 1 % MultiRC.ELCLASS
					prop_default = 'MultiRC';
				case 2 % MultiRC.NAME
					prop_default = 'Multirichness';
				case 3 % MultiRC.DESCRIPTION
					prop_default = 'The Multirichness (MultiRC) of a node is the sum of the edges that connect nodes of degree k or higher in all layers. The relevance of each layer is controlled by the coefficients c that are between 0 and 1; the default coefficients are (1/layernumber).';
				case 4 % MultiRC.TEMPLATE
					prop_default = Format.getFormatDefault(8, MultiRC.getPropSettings(prop));
				case 5 % MultiRC.ID
					prop_default = 'MultiRC ID';
				case 6 % MultiRC.LABEL
					prop_default = 'Multirichness label';
				case 7 % MultiRC.NOTES
					prop_default = 'Multirichness notes';
				case 9 % MultiRC.SHAPE
					prop_default = 2;
				case 10 % MultiRC.SCOPE
					prop_default = 1;
				case 11 % MultiRC.PARAMETRICITY
					prop_default = 2;
				case 12 % MultiRC.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'};;
				otherwise
					prop_default = getPropDefault@Richness(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiRC.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiRC.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiRC, POINTER) returns the conditioned default value of POINTER of MultiRC.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultiRC, POINTER) returns the conditioned default value of POINTER of MultiRC.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('MultiRC')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiRC.getPropProp(pointer);
			
			prop_default = MultiRC.conditioning(prop, MultiRC.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiRC, PROP, VALUE) checks VALUE format for PROP of MultiRC.
			%  CHECK = M.CHECKPROP(MultiRC, PROP, VALUE) checks VALUE format for PROP of MultiRC.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:MultiRC:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:MultiRC:WrongInput
			%  Element.CHECKPROP(MultiRC, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiRC.
			%   Error id: BRAPH2:MultiRC:WrongInput
			%  M.CHECKPROP(MultiRC, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiRC.
			%   Error id: BRAPH2:MultiRC:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('MultiRC')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiRC.getPropProp(pointer);
			
			switch prop
				case 16 % MultiRC.MULTIRICHNESS_COEFFICIENTS
					check = Format.checkFormat(12, value, MultiRC.getPropSettings(prop));
				case 4 % MultiRC.TEMPLATE
					check = Format.checkFormat(8, value, MultiRC.getPropSettings(prop));
				otherwise
					if prop <= 15
						check = checkProp@Richness(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultiRC:' 'WrongInput'], ...
					['BRAPH2' ':MultiRC:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiRC.getPropTag(prop) ' (' MultiRC.getFormatTag(MultiRC.getPropFormat(prop)) ').'] ...
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
				case 14 % MultiRC.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					ls = g.get('PARTITIONS');
					
					richness = calculateValue@Richness(m, prop);
					
					if l == 0
					    value = {};
					else
					    N = g.get('NODENUMBER');
					    multirichness_coefficients = m.get('MULTIRICHNESS_COEFFICIENTS');
					    assert(length(multirichness_coefficients) == ls(1) || all(multirichness_coefficients == 0), ...
					        ['BRAPH2' ':Multirichness:' 'WrongInput'], ...
					        ['Multirichness coefficients must have the same length than the ' ...
					        'number of layers (' tostring(ls(1)) ') while its length is ' tostring(length(multirichness_coefficients))])
					
					    if length(multirichness_coefficients) == ls(1)
					        assert(all(multirichness_coefficients <= 1) && all(multirichness_coefficients >= 0), ...
					            ['BRAPH2' ':Multirichness:' 'WrongInput'], ...
					            ['Multirichness coefficients must be between 0 and 1 ' ...
					            'while they are ' tostring(multirichness_coefficients)])
					        c = multirichness_coefficients;
					
					    else  % same relevance for each layer
					        c = ones(1, l)/ls(1);
					    end
					    multirichness = cell(length(ls), 1);
					    count = 1;
					    for i = 1:1:length(ls)
					        multirichness_partition = zeros(N(1), 1);
					        for li = count:1:ls(i) + count - 1
					            multirichness_partition = multirichness_partition + c(li)*richness{li};
					        end
					        count = count + ls(i);
					        multirichness(i) = {multirichness_partition};
					    end
					    value = multirichness;
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
