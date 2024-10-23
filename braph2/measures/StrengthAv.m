classdef StrengthAv < Strength
	%StrengthAv is the graph Average Strength.
	% It is a subclass of <a href="matlab:help Strength">Strength</a>.
	%
	% The Average Strength (StrengthAv) of a graph is the average of the sum of all weights of 
	%  the edges connected to a node within a layer.
	%
	% The list of StrengthAv properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Average Strength.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Average Strength.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Average Strength.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Average Strength.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Average Strength.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Average Strength.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Average Strength.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Average Strength.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%
	% StrengthAv methods (constructor):
	%  StrengthAv - constructor
	%
	% StrengthAv methods:
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
	% StrengthAv methods (display):
	%  tostring - string with information about the average strength
	%  disp - displays information about the average strength
	%  tree - displays the tree of the average strength
	%
	% StrengthAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average strength are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average strength
	%
	% StrengthAv methods (save/load, Static):
	%  save - saves BRAPH2 average strength as b2 file
	%  load - loads a BRAPH2 average strength from a b2 file
	%
	% StrengthAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average strength
	%
	% StrengthAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average strength
	%
	% StrengthAv methods (inspection, Static):
	%  getClass - returns the class of the average strength
	%  getSubclasses - returns all subclasses of StrengthAv
	%  getProps - returns the property list of the average strength
	%  getPropNumber - returns the property number of the average strength
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
	% StrengthAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% StrengthAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% StrengthAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% StrengthAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?StrengthAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">StrengthAv constants</a>.
	%
	
	methods % constructor
		function m = StrengthAv(varargin)
			%StrengthAv() creates a average strength.
			%
			% StrengthAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% StrengthAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of StrengthAv properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Average Strength.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Average Strength.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Average Strength.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Average Strength.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Average Strength.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Average Strength.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Average Strength.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Average Strength.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%
			% See also Category, Format.
			
			m = m@Strength(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the average strength.
			%
			% BUILD = StrengthAv.GETBUILD() returns the build of 'StrengthAv'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the average strength M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('StrengthAv') returns the build of 'StrengthAv'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('StrengthAv')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the average strength.
			%
			% CLASS = StrengthAv.GETCLASS() returns the class 'StrengthAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average strength M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('StrengthAv') returns 'StrengthAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('StrengthAv')
			%  are less computationally efficient.
			
			m_class = 'StrengthAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average strength.
			%
			% LIST = StrengthAv.GETSUBCLASSES() returns all subclasses of 'StrengthAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average strength M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('StrengthAv') returns all subclasses of 'StrengthAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('StrengthAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'StrengthAv' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average strength.
			%
			% PROPS = StrengthAv.GETPROPS() returns the property list of average strength
			%  as a row vector.
			%
			% PROPS = StrengthAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average strength M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('StrengthAv'[, CATEGORY]) returns the property list of 'StrengthAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('StrengthAv')
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
			%GETPROPNUMBER returns the property number of average strength.
			%
			% N = StrengthAv.GETPROPNUMBER() returns the property number of average strength.
			%
			% N = StrengthAv.GETPROPNUMBER(CATEGORY) returns the property number of average strength
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average strength M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('StrengthAv') returns the property number of 'StrengthAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('StrengthAv')
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
			%EXISTSPROP checks whether property exists in average strength/error.
			%
			% CHECK = StrengthAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(StrengthAv, PROP) checks whether PROP exists for StrengthAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:StrengthAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:StrengthAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:StrengthAv:WrongInput]
			%  Element.EXISTSPROP(StrengthAv, PROP) throws error if PROP does NOT exist for StrengthAv.
			%   Error id: [BRAPH2:StrengthAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('StrengthAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 15 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':StrengthAv:' 'WrongInput'], ...
					['BRAPH2' ':StrengthAv:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for StrengthAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average strength/error.
			%
			% CHECK = StrengthAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(StrengthAv, TAG) checks whether TAG exists for StrengthAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:StrengthAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:StrengthAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:StrengthAv:WrongInput]
			%  Element.EXISTSTAG(StrengthAv, TAG) throws error if TAG does NOT exist for StrengthAv.
			%   Error id: [BRAPH2:StrengthAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('StrengthAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':StrengthAv:' 'WrongInput'], ...
					['BRAPH2' ':StrengthAv:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for StrengthAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(StrengthAv, POINTER) returns property number of POINTER of StrengthAv.
			%  PROPERTY = M.GETPROPPROP(StrengthAv, POINTER) returns property number of POINTER of StrengthAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('StrengthAv')
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
			%  TAG = Element.GETPROPTAG(StrengthAv, POINTER) returns tag of POINTER of StrengthAv.
			%  TAG = M.GETPROPTAG(StrengthAv, POINTER) returns tag of POINTER of StrengthAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('StrengthAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				strengthav_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' };
				tag = strengthav_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(StrengthAv, POINTER) returns category of POINTER of StrengthAv.
			%  CATEGORY = M.GETPROPCATEGORY(StrengthAv, POINTER) returns category of POINTER of StrengthAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('StrengthAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = StrengthAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			strengthav_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9 };
			prop_category = strengthav_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(StrengthAv, POINTER) returns format of POINTER of StrengthAv.
			%  FORMAT = M.GETPROPFORMAT(StrengthAv, POINTER) returns format of POINTER of StrengthAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('StrengthAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = StrengthAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			strengthav_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8 };
			prop_format = strengthav_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(StrengthAv, POINTER) returns description of POINTER of StrengthAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(StrengthAv, POINTER) returns description of POINTER of StrengthAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('StrengthAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = StrengthAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			strengthav_description_list = { 'ELCLASS (constant, string) is the class of the Average Strength.'  'NAME (constant, string) is the name of the Average Strength.'  'DESCRIPTION (constant, string) is the description of the Average Strength.'  'TEMPLATE (parameter, item) is the template of the Average Strength.'  'ID (data, string) is a few-letter code of the Average Strength.'  'LABEL (metadata, string) is an extended label of the Average Strength.'  'NOTES (metadata, string) are some specific notes about the Average Strength.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Average Strength.'  'PFM (gui, item) contains the panel figure of the measure.' };
			prop_description = strengthav_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(StrengthAv, POINTER) returns settings of POINTER of StrengthAv.
			%  SETTINGS = M.GETPROPSETTINGS(StrengthAv, POINTER) returns settings of POINTER of StrengthAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('StrengthAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = StrengthAv.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % StrengthAv.TEMPLATE
					prop_settings = 'StrengthAv';
				otherwise
					prop_settings = getPropSettings@Strength(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = StrengthAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = StrengthAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(StrengthAv, POINTER) returns the default value of POINTER of StrengthAv.
			%  DEFAULT = M.GETPROPDEFAULT(StrengthAv, POINTER) returns the default value of POINTER of StrengthAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('StrengthAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = StrengthAv.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % StrengthAv.ELCLASS
					prop_default = 'StrengthAv';
				case 2 % StrengthAv.NAME
					prop_default = 'Average Strength';
				case 3 % StrengthAv.DESCRIPTION
					prop_default = 'The Average Strength (StrengthAv) of a graph is the average of the sum of all weights of the edges connected to a node within a layer.';
				case 4 % StrengthAv.TEMPLATE
					prop_default = Format.getFormatDefault(8, StrengthAv.getPropSettings(prop));
				case 5 % StrengthAv.ID
					prop_default = 'StrengthAv ID';
				case 6 % StrengthAv.LABEL
					prop_default = 'Average Strength label';
				case 7 % StrengthAv.NOTES
					prop_default = 'Average Strength notes';
				case 9 % StrengthAv.SHAPE
					prop_default = 1;
				case 10 % StrengthAv.SCOPE
					prop_default = 2;
				case 11 % StrengthAv.PARAMETRICITY
					prop_default = 2;
				case 12 % StrengthAv.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'MultiplexWU' 'OrdMxWU' 'MultilayerWU' 'OrdMlWU'};
				otherwise
					prop_default = getPropDefault@Strength(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = StrengthAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = StrengthAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(StrengthAv, POINTER) returns the conditioned default value of POINTER of StrengthAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(StrengthAv, POINTER) returns the conditioned default value of POINTER of StrengthAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('StrengthAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = StrengthAv.getPropProp(pointer);
			
			prop_default = StrengthAv.conditioning(prop, StrengthAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(StrengthAv, PROP, VALUE) checks VALUE format for PROP of StrengthAv.
			%  CHECK = M.CHECKPROP(StrengthAv, PROP, VALUE) checks VALUE format for PROP of StrengthAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:StrengthAv:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:StrengthAv:WrongInput
			%  Element.CHECKPROP(StrengthAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of StrengthAv.
			%   Error id: BRAPH2:StrengthAv:WrongInput
			%  M.CHECKPROP(StrengthAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of StrengthAv.
			%   Error id: BRAPH2:StrengthAv:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('StrengthAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = StrengthAv.getPropProp(pointer);
			
			switch prop
				case 4 % StrengthAv.TEMPLATE
					check = Format.checkFormat(8, value, StrengthAv.getPropSettings(prop));
				otherwise
					if prop <= 15
						check = checkProp@Strength(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':StrengthAv:' 'WrongInput'], ...
					['BRAPH2' ':StrengthAv:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' StrengthAv.getPropTag(prop) ' (' StrengthAv.getFormatTag(StrengthAv.getPropFormat(prop)) ').'] ...
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
				case 14 % StrengthAv.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					L = g.get('LAYERNUMBER');
					
					strength = calculateValue@Strength(m, prop);
					
					strength_av = cell(L, 1);
					parfor li = 1:L
					    strength_av(li) = {mean(strength{li})};
					end
					
					value = strength_av;
					
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
