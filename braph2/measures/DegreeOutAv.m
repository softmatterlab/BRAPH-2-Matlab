classdef DegreeOutAv < DegreeOut
	%DegreeOutAv is the graph Average Out-Degree.
	% It is a subclass of <a href="matlab:help DegreeOut">DegreeOut</a>.
	%
	% The Average Out-Degree (DegreeOutAv) of a graph is the average of all number of outward edges connected to a node within a layer.
	%
	% The list of DegreeOutAv properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Average Out-Degree.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Average Out-Degree.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Average Out-Degree.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Average Out-Degree.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the average out-degree.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Average Out-Degree.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Average Out-Degree.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the cell containing the Average Out-Degree.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%
	% DegreeOutAv methods (constructor):
	%  DegreeOutAv - constructor
	%
	% DegreeOutAv methods:
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
	% DegreeOutAv methods (display):
	%  tostring - string with information about the average out-degree
	%  disp - displays information about the average out-degree
	%  tree - displays the tree of the average out-degree
	%
	% DegreeOutAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average out-degree are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average out-degree
	%
	% DegreeOutAv methods (save/load, Static):
	%  save - saves BRAPH2 average out-degree as b2 file
	%  load - loads a BRAPH2 average out-degree from a b2 file
	%
	% DegreeOutAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average out-degree
	%
	% DegreeOutAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average out-degree
	%
	% DegreeOutAv methods (inspection, Static):
	%  getClass - returns the class of the average out-degree
	%  getSubclasses - returns all subclasses of DegreeOutAv
	%  getProps - returns the property list of the average out-degree
	%  getPropNumber - returns the property number of the average out-degree
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
	% DegreeOutAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% DegreeOutAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% DegreeOutAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% DegreeOutAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?DegreeOutAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">DegreeOutAv constants</a>.
	%
	
	methods % constructor
		function m = DegreeOutAv(varargin)
			%DegreeOutAv() creates a average out-degree.
			%
			% DegreeOutAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% DegreeOutAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of DegreeOutAv properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Average Out-Degree.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Average Out-Degree.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Average Out-Degree.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Average Out-Degree.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the average out-degree.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Average Out-Degree.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Average Out-Degree.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the cell containing the Average Out-Degree.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%
			% See also Category, Format.
			
			m = m@DegreeOut(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the average out-degree.
			%
			% BUILD = DegreeOutAv.GETBUILD() returns the build of 'DegreeOutAv'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the average out-degree M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('DegreeOutAv') returns the build of 'DegreeOutAv'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('DegreeOutAv')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the average out-degree.
			%
			% CLASS = DegreeOutAv.GETCLASS() returns the class 'DegreeOutAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average out-degree M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('DegreeOutAv') returns 'DegreeOutAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('DegreeOutAv')
			%  are less computationally efficient.
			
			m_class = 'DegreeOutAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average out-degree.
			%
			% LIST = DegreeOutAv.GETSUBCLASSES() returns all subclasses of 'DegreeOutAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average out-degree M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('DegreeOutAv') returns all subclasses of 'DegreeOutAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('DegreeOutAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'DegreeOutAv' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average out-degree.
			%
			% PROPS = DegreeOutAv.GETPROPS() returns the property list of average out-degree
			%  as a row vector.
			%
			% PROPS = DegreeOutAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average out-degree M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('DegreeOutAv'[, CATEGORY]) returns the property list of 'DegreeOutAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('DegreeOutAv')
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
			%GETPROPNUMBER returns the property number of average out-degree.
			%
			% N = DegreeOutAv.GETPROPNUMBER() returns the property number of average out-degree.
			%
			% N = DegreeOutAv.GETPROPNUMBER(CATEGORY) returns the property number of average out-degree
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average out-degree M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('DegreeOutAv') returns the property number of 'DegreeOutAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('DegreeOutAv')
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
			%EXISTSPROP checks whether property exists in average out-degree/error.
			%
			% CHECK = DegreeOutAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(DegreeOutAv, PROP) checks whether PROP exists for DegreeOutAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:DegreeOutAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:DegreeOutAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:DegreeOutAv:WrongInput]
			%  Element.EXISTSPROP(DegreeOutAv, PROP) throws error if PROP does NOT exist for DegreeOutAv.
			%   Error id: [BRAPH2:DegreeOutAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('DegreeOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 15 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':DegreeOutAv:' 'WrongInput'], ...
					['BRAPH2' ':DegreeOutAv:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for DegreeOutAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average out-degree/error.
			%
			% CHECK = DegreeOutAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(DegreeOutAv, TAG) checks whether TAG exists for DegreeOutAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:DegreeOutAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:DegreeOutAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:DegreeOutAv:WrongInput]
			%  Element.EXISTSTAG(DegreeOutAv, TAG) throws error if TAG does NOT exist for DegreeOutAv.
			%   Error id: [BRAPH2:DegreeOutAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('DegreeOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':DegreeOutAv:' 'WrongInput'], ...
					['BRAPH2' ':DegreeOutAv:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for DegreeOutAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(DegreeOutAv, POINTER) returns property number of POINTER of DegreeOutAv.
			%  PROPERTY = M.GETPROPPROP(DegreeOutAv, POINTER) returns property number of POINTER of DegreeOutAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('DegreeOutAv')
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
			%  TAG = Element.GETPROPTAG(DegreeOutAv, POINTER) returns tag of POINTER of DegreeOutAv.
			%  TAG = M.GETPROPTAG(DegreeOutAv, POINTER) returns tag of POINTER of DegreeOutAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('DegreeOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				degreeoutav_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' };
				tag = degreeoutav_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(DegreeOutAv, POINTER) returns category of POINTER of DegreeOutAv.
			%  CATEGORY = M.GETPROPCATEGORY(DegreeOutAv, POINTER) returns category of POINTER of DegreeOutAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('DegreeOutAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = DegreeOutAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			degreeoutav_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9 };
			prop_category = degreeoutav_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(DegreeOutAv, POINTER) returns format of POINTER of DegreeOutAv.
			%  FORMAT = M.GETPROPFORMAT(DegreeOutAv, POINTER) returns format of POINTER of DegreeOutAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('DegreeOutAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = DegreeOutAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			degreeoutav_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8 };
			prop_format = degreeoutav_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(DegreeOutAv, POINTER) returns description of POINTER of DegreeOutAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(DegreeOutAv, POINTER) returns description of POINTER of DegreeOutAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('DegreeOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = DegreeOutAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			degreeoutav_description_list = { 'ELCLASS (constant, string) is the class of the Average Out-Degree.'  'NAME (constant, string) is the name of the Average Out-Degree.'  'DESCRIPTION (constant, string) is the description of the Average Out-Degree.'  'TEMPLATE (parameter, item) is the template of the Average Out-Degree.'  'ID (data, string) is a few-letter code of the average out-degree.'  'LABEL (metadata, string) is an extended label of the Average Out-Degree.'  'NOTES (metadata, string) are some specific notes about the Average Out-Degree.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the cell containing the Average Out-Degree.'  'PFM (gui, item) contains the panel figure of the measure.' };
			prop_description = degreeoutav_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(DegreeOutAv, POINTER) returns settings of POINTER of DegreeOutAv.
			%  SETTINGS = M.GETPROPSETTINGS(DegreeOutAv, POINTER) returns settings of POINTER of DegreeOutAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('DegreeOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = DegreeOutAv.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % DegreeOutAv.TEMPLATE
					prop_settings = 'DegreeOutAv';
				otherwise
					prop_settings = getPropSettings@DegreeOut(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = DegreeOutAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = DegreeOutAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(DegreeOutAv, POINTER) returns the default value of POINTER of DegreeOutAv.
			%  DEFAULT = M.GETPROPDEFAULT(DegreeOutAv, POINTER) returns the default value of POINTER of DegreeOutAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('DegreeOutAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = DegreeOutAv.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % DegreeOutAv.ELCLASS
					prop_default = 'DegreeOutAv';
				case 2 % DegreeOutAv.NAME
					prop_default = 'Average Out-Degree';
				case 3 % DegreeOutAv.DESCRIPTION
					prop_default = 'The Average Out-Degree (DegreeOutAv) of a graph is the average of all number of outward edges connected to a node within a layer.';
				case 4 % DegreeOutAv.TEMPLATE
					prop_default = Format.getFormatDefault(8, DegreeOutAv.getPropSettings(prop));
				case 5 % DegreeOutAv.ID
					prop_default = 'DegreeOutAv ID';
				case 6 % DegreeOutAv.LABEL
					prop_default = 'Average Out-Degree label';
				case 7 % DegreeOutAv.NOTES
					prop_default = 'Average Out-Degree notes';
				case 9 % DegreeOutAv.SHAPE
					prop_default = 1;
				case 10 % DegreeOutAv.SCOPE
					prop_default = 2;
				case 11 % DegreeOutAv.PARAMETRICITY
					prop_default = 2;
				case 12 % DegreeOutAv.COMPATIBLE_GRAPHS
					prop_default = {'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxWD' 'OrdMxBD' 'OrdMlWD'};;
				otherwise
					prop_default = getPropDefault@DegreeOut(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = DegreeOutAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = DegreeOutAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(DegreeOutAv, POINTER) returns the conditioned default value of POINTER of DegreeOutAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(DegreeOutAv, POINTER) returns the conditioned default value of POINTER of DegreeOutAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('DegreeOutAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = DegreeOutAv.getPropProp(pointer);
			
			prop_default = DegreeOutAv.conditioning(prop, DegreeOutAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(DegreeOutAv, PROP, VALUE) checks VALUE format for PROP of DegreeOutAv.
			%  CHECK = M.CHECKPROP(DegreeOutAv, PROP, VALUE) checks VALUE format for PROP of DegreeOutAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:DegreeOutAv:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:DegreeOutAv:WrongInput
			%  Element.CHECKPROP(DegreeOutAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DegreeOutAv.
			%   Error id: BRAPH2:DegreeOutAv:WrongInput
			%  M.CHECKPROP(DegreeOutAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DegreeOutAv.
			%   Error id: BRAPH2:DegreeOutAv:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('DegreeOutAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = DegreeOutAv.getPropProp(pointer);
			
			switch prop
				case 4 % DegreeOutAv.TEMPLATE
					check = Format.checkFormat(8, value, DegreeOutAv.getPropSettings(prop));
				otherwise
					if prop <= 15
						check = checkProp@DegreeOut(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':DegreeOutAv:' 'WrongInput'], ...
					['BRAPH2' ':DegreeOutAv:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' DegreeOutAv.getPropTag(prop) ' (' DegreeOutAv.getFormatTag(DegreeOutAv.getPropFormat(prop)) ').'] ...
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
				case 14 % DegreeOutAv.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					out_degree = calculateValue@DegreeOut(m, prop);	
					g = m.get('G'); % graph from measure class
					L = g.get('LAYERNUMBER');
					degree_out_av = cell(L, 1);
					
					parfor li = 1:1:L
					    degree_out_av(li) = {mean(out_degree{li})};
					end
					
					value = degree_out_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 15
						value = calculateValue@DegreeOut(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
