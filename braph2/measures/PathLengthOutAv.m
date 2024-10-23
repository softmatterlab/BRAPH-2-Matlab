classdef PathLengthOutAv < PathLengthOut
	%PathLengthOutAv is the graph Average Out-Path Length.
	% It is a subclass of <a href="matlab:help PathLengthOut">PathLengthOut</a>.
	%
	% The Average Out-Path Length (PathLengthOutAv) is the average shortest out-path lengths of one node to all other nodes within a layer.
	%
	% The list of PathLengthOutAv properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Average Out-Path Length.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Average Out-Path Length.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Average Out-Path Length.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Average Out-Path Length.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Average Out-Path Length.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Average Out-Path Length.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Average Out-Path Length.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the cell containing the Average Out-Path Length.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>16</strong> <strong>RULE</strong> 	RULE (parameter, option) is the PathLengthOut algorithm
	%
	% PathLengthOutAv methods (constructor):
	%  PathLengthOutAv - constructor
	%
	% PathLengthOutAv methods:
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
	% PathLengthOutAv methods (display):
	%  tostring - string with information about the average out-path length
	%  disp - displays information about the average out-path length
	%  tree - displays the tree of the average out-path length
	%
	% PathLengthOutAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average out-path length are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average out-path length
	%
	% PathLengthOutAv methods (save/load, Static):
	%  save - saves BRAPH2 average out-path length as b2 file
	%  load - loads a BRAPH2 average out-path length from a b2 file
	%
	% PathLengthOutAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average out-path length
	%
	% PathLengthOutAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average out-path length
	%
	% PathLengthOutAv methods (inspection, Static):
	%  getClass - returns the class of the average out-path length
	%  getSubclasses - returns all subclasses of PathLengthOutAv
	%  getProps - returns the property list of the average out-path length
	%  getPropNumber - returns the property number of the average out-path length
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
	% PathLengthOutAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PathLengthOutAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PathLengthOutAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PathLengthOutAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PathLengthOutAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PathLengthOutAv constants</a>.
	%
	
	methods % constructor
		function m = PathLengthOutAv(varargin)
			%PathLengthOutAv() creates a average out-path length.
			%
			% PathLengthOutAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PathLengthOutAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PathLengthOutAv properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Average Out-Path Length.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Average Out-Path Length.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Average Out-Path Length.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Average Out-Path Length.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Average Out-Path Length.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Average Out-Path Length.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Average Out-Path Length.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the cell containing the Average Out-Path Length.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>16</strong> <strong>RULE</strong> 	RULE (parameter, option) is the PathLengthOut algorithm
			%
			% See also Category, Format.
			
			m = m@PathLengthOut(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the average out-path length.
			%
			% BUILD = PathLengthOutAv.GETBUILD() returns the build of 'PathLengthOutAv'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the average out-path length M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('PathLengthOutAv') returns the build of 'PathLengthOutAv'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('PathLengthOutAv')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the average out-path length.
			%
			% CLASS = PathLengthOutAv.GETCLASS() returns the class 'PathLengthOutAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average out-path length M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('PathLengthOutAv') returns 'PathLengthOutAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('PathLengthOutAv')
			%  are less computationally efficient.
			
			m_class = 'PathLengthOutAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average out-path length.
			%
			% LIST = PathLengthOutAv.GETSUBCLASSES() returns all subclasses of 'PathLengthOutAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average out-path length M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('PathLengthOutAv') returns all subclasses of 'PathLengthOutAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'PathLengthOutAv' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average out-path length.
			%
			% PROPS = PathLengthOutAv.GETPROPS() returns the property list of average out-path length
			%  as a row vector.
			%
			% PROPS = PathLengthOutAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average out-path length M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('PathLengthOutAv'[, CATEGORY]) returns the property list of 'PathLengthOutAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('PathLengthOutAv')
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
			%GETPROPNUMBER returns the property number of average out-path length.
			%
			% N = PathLengthOutAv.GETPROPNUMBER() returns the property number of average out-path length.
			%
			% N = PathLengthOutAv.GETPROPNUMBER(CATEGORY) returns the property number of average out-path length
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average out-path length M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('PathLengthOutAv') returns the property number of 'PathLengthOutAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('PathLengthOutAv')
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
			%EXISTSPROP checks whether property exists in average out-path length/error.
			%
			% CHECK = PathLengthOutAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(PathLengthOutAv, PROP) checks whether PROP exists for PathLengthOutAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PathLengthOutAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthOutAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthOutAv:WrongInput]
			%  Element.EXISTSPROP(PathLengthOutAv, PROP) throws error if PROP does NOT exist for PathLengthOutAv.
			%   Error id: [BRAPH2:PathLengthOutAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 16 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PathLengthOutAv:' 'WrongInput'], ...
					['BRAPH2' ':PathLengthOutAv:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PathLengthOutAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average out-path length/error.
			%
			% CHECK = PathLengthOutAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(PathLengthOutAv, TAG) checks whether TAG exists for PathLengthOutAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PathLengthOutAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthOutAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:PathLengthOutAv:WrongInput]
			%  Element.EXISTSTAG(PathLengthOutAv, TAG) throws error if TAG does NOT exist for PathLengthOutAv.
			%   Error id: [BRAPH2:PathLengthOutAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PathLengthOutAv:' 'WrongInput'], ...
					['BRAPH2' ':PathLengthOutAv:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for PathLengthOutAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PathLengthOutAv, POINTER) returns property number of POINTER of PathLengthOutAv.
			%  PROPERTY = M.GETPROPPROP(PathLengthOutAv, POINTER) returns property number of POINTER of PathLengthOutAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('PathLengthOutAv')
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
			%  TAG = Element.GETPROPTAG(PathLengthOutAv, POINTER) returns tag of POINTER of PathLengthOutAv.
			%  TAG = M.GETPROPTAG(PathLengthOutAv, POINTER) returns tag of POINTER of PathLengthOutAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				pathlengthoutav_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE' };
				tag = pathlengthoutav_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(PathLengthOutAv, POINTER) returns category of POINTER of PathLengthOutAv.
			%  CATEGORY = M.GETPROPCATEGORY(PathLengthOutAv, POINTER) returns category of POINTER of PathLengthOutAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PathLengthOutAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pathlengthoutav_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3 };
			prop_category = pathlengthoutav_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(PathLengthOutAv, POINTER) returns format of POINTER of PathLengthOutAv.
			%  FORMAT = M.GETPROPFORMAT(PathLengthOutAv, POINTER) returns format of POINTER of PathLengthOutAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PathLengthOutAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pathlengthoutav_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  5 };
			prop_format = pathlengthoutav_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PathLengthOutAv, POINTER) returns description of POINTER of PathLengthOutAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(PathLengthOutAv, POINTER) returns description of POINTER of PathLengthOutAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PathLengthOutAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pathlengthoutav_description_list = { 'ELCLASS (constant, string) is the class of the Average Out-Path Length.'  'NAME (constant, string) is the name of the Average Out-Path Length.'  'DESCRIPTION (constant, string) is the description of the Average Out-Path Length.'  'TEMPLATE (parameter, item) is the template of the Average Out-Path Length.'  'ID (data, string) is a few-letter code of the Average Out-Path Length.'  'LABEL (metadata, string) is an extended label of the Average Out-Path Length.'  'NOTES (metadata, string) are some specific notes about the Average Out-Path Length.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the cell containing the Average Out-Path Length.'  'PFM (gui, item) contains the panel figure of the measure.'  'RULE (parameter, option) is the PathLengthOut algorithm' };
			prop_description = pathlengthoutav_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(PathLengthOutAv, POINTER) returns settings of POINTER of PathLengthOutAv.
			%  SETTINGS = M.GETPROPSETTINGS(PathLengthOutAv, POINTER) returns settings of POINTER of PathLengthOutAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PathLengthOutAv.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % PathLengthOutAv.TEMPLATE
					prop_settings = 'PathLengthOutAv';
				otherwise
					prop_settings = getPropSettings@PathLengthOut(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PathLengthOutAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PathLengthOutAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(PathLengthOutAv, POINTER) returns the default value of POINTER of PathLengthOutAv.
			%  DEFAULT = M.GETPROPDEFAULT(PathLengthOutAv, POINTER) returns the default value of POINTER of PathLengthOutAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PathLengthOutAv.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % PathLengthOutAv.ELCLASS
					prop_default = 'PathLengthOutAv';
				case 2 % PathLengthOutAv.NAME
					prop_default = 'Average Out-Path Length';
				case 3 % PathLengthOutAv.DESCRIPTION
					prop_default = 'The Average Out-Path Length (PathLengthOutAv) is the average shortest out-path lengths of one node to all other nodes within a layer.';
				case 4 % PathLengthOutAv.TEMPLATE
					prop_default = Format.getFormatDefault(8, PathLengthOutAv.getPropSettings(prop));
				case 5 % PathLengthOutAv.ID
					prop_default = 'PathLengthOutAv ID';
				case 6 % PathLengthOutAv.LABEL
					prop_default = 'Average Out-Path Length label';
				case 7 % PathLengthOutAv.NOTES
					prop_default = 'Average Out-Path Length notes';
				case 9 % PathLengthOutAv.SHAPE
					prop_default = 2;
				case 10 % PathLengthOutAv.SCOPE
					prop_default = 2;
				case 11 % PathLengthOutAv.PARAMETRICITY
					prop_default = 2;
				case 12 % PathLengthOutAv.COMPATIBLE_GRAPHS
					prop_default = {'GraphBD' 'GraphWD' 'MultiplexBD' 'MultiplexWD' 'MultilayerBD' 'OrdMlBD'};
				otherwise
					prop_default = getPropDefault@PathLengthOut(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PathLengthOutAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PathLengthOutAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PathLengthOutAv, POINTER) returns the conditioned default value of POINTER of PathLengthOutAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(PathLengthOutAv, POINTER) returns the conditioned default value of POINTER of PathLengthOutAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PathLengthOutAv.getPropProp(pointer);
			
			prop_default = PathLengthOutAv.conditioning(prop, PathLengthOutAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PathLengthOutAv, PROP, VALUE) checks VALUE format for PROP of PathLengthOutAv.
			%  CHECK = M.CHECKPROP(PathLengthOutAv, PROP, VALUE) checks VALUE format for PROP of PathLengthOutAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:PathLengthOutAv:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:PathLengthOutAv:WrongInput
			%  Element.CHECKPROP(PathLengthOutAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PathLengthOutAv.
			%   Error id: BRAPH2:PathLengthOutAv:WrongInput
			%  M.CHECKPROP(PathLengthOutAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PathLengthOutAv.
			%   Error id: BRAPH2:PathLengthOutAv:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('PathLengthOutAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PathLengthOutAv.getPropProp(pointer);
			
			switch prop
				case 4 % PathLengthOutAv.TEMPLATE
					check = Format.checkFormat(8, value, PathLengthOutAv.getPropSettings(prop));
				otherwise
					if prop <= 16
						check = checkProp@PathLengthOut(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PathLengthOutAv:' 'WrongInput'], ...
					['BRAPH2' ':PathLengthOutAv:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PathLengthOutAv.getPropTag(prop) ' (' PathLengthOutAv.getFormatTag(PathLengthOutAv.getPropFormat(prop)) ').'] ...
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
				case 14 % PathLengthOutAv.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G');  % graph from measure class
					L = g.get('LAYERNUMBER');
					
					out_path_length = calculateValue@PathLengthOut(m, prop);
					out_path_length_av = cell(L, 1);
					path_length_rule = m.get('RULE');
					parfor li = 1:1:length(out_path_length_av)
					    switch lower(path_length_rule)
					        case {'subgraphs'}
					            player = out_path_length{li};
					            out_path_length_av(li) = {mean(player(player~=Inf))};
					        case {'mean'}
					            out_path_length_av(li) = {mean(out_path_length{li})};
					        otherwise  % 'harmonic' 'default'
					            out_path_length_av(li) = {harmmean(out_path_length{li})};
					    end
					end
					value = out_path_length_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 16
						value = calculateValue@PathLengthOut(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
