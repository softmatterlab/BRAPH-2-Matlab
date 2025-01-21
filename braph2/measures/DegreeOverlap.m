classdef DegreeOverlap < EdgeOverlap
	%DegreeOverlap is the graph Degree Overlap.
	% It is a subclass of <a href="matlab:help EdgeOverlap">EdgeOverlap</a>.
	%
	% The Degree Overlap (DegreeOverlap) is the number of edges connected to a node in all layers. 
	% Connection weights are ignored in calculations.
	%
	% The list of DegreeOverlap properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Degree Overlap.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Degree Overlap.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Degree Overlap.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Degree Overlap.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Degree Overlap.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Degree Overlap.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Degree Overlap.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Degree Overlap.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%
	% DegreeOverlap methods (constructor):
	%  DegreeOverlap - constructor
	%
	% DegreeOverlap methods:
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
	% DegreeOverlap methods (display):
	%  tostring - string with information about the degree overlap
	%  disp - displays information about the degree overlap
	%  tree - displays the tree of the degree overlap
	%
	% DegreeOverlap methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two degree overlap are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the degree overlap
	%
	% DegreeOverlap methods (save/load, Static):
	%  save - saves BRAPH2 degree overlap as b2 file
	%  load - loads a BRAPH2 degree overlap from a b2 file
	%
	% DegreeOverlap method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the degree overlap
	%
	% DegreeOverlap method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the degree overlap
	%
	% DegreeOverlap methods (inspection, Static):
	%  getClass - returns the class of the degree overlap
	%  getSubclasses - returns all subclasses of DegreeOverlap
	%  getProps - returns the property list of the degree overlap
	%  getPropNumber - returns the property number of the degree overlap
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
	% DegreeOverlap methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% DegreeOverlap methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% DegreeOverlap methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% DegreeOverlap methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?DegreeOverlap; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">DegreeOverlap constants</a>.
	%
	
	methods % constructor
		function m = DegreeOverlap(varargin)
			%DegreeOverlap() creates a degree overlap.
			%
			% DegreeOverlap(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% DegreeOverlap(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of DegreeOverlap properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Degree Overlap.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Degree Overlap.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Degree Overlap.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Degree Overlap.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Degree Overlap.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Degree Overlap.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Degree Overlap.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Degree Overlap.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%
			% See also Category, Format.
			
			m = m@EdgeOverlap(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the degree overlap.
			%
			% BUILD = DegreeOverlap.GETBUILD() returns the build of 'DegreeOverlap'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the degree overlap M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('DegreeOverlap') returns the build of 'DegreeOverlap'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('DegreeOverlap')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the degree overlap.
			%
			% CLASS = DegreeOverlap.GETCLASS() returns the class 'DegreeOverlap'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the degree overlap M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('DegreeOverlap') returns 'DegreeOverlap'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('DegreeOverlap')
			%  are less computationally efficient.
			
			m_class = 'DegreeOverlap';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the degree overlap.
			%
			% LIST = DegreeOverlap.GETSUBCLASSES() returns all subclasses of 'DegreeOverlap'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the degree overlap M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('DegreeOverlap') returns all subclasses of 'DegreeOverlap'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'DegreeOverlap'  'DegreeOverlapAv' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of degree overlap.
			%
			% PROPS = DegreeOverlap.GETPROPS() returns the property list of degree overlap
			%  as a row vector.
			%
			% PROPS = DegreeOverlap.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the degree overlap M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('DegreeOverlap'[, CATEGORY]) returns the property list of 'DegreeOverlap'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('DegreeOverlap')
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
			%GETPROPNUMBER returns the property number of degree overlap.
			%
			% N = DegreeOverlap.GETPROPNUMBER() returns the property number of degree overlap.
			%
			% N = DegreeOverlap.GETPROPNUMBER(CATEGORY) returns the property number of degree overlap
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the degree overlap M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('DegreeOverlap') returns the property number of 'DegreeOverlap'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('DegreeOverlap')
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
			%EXISTSPROP checks whether property exists in degree overlap/error.
			%
			% CHECK = DegreeOverlap.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(DegreeOverlap, PROP) checks whether PROP exists for DegreeOverlap.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:DegreeOverlap:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:DegreeOverlap:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:DegreeOverlap:WrongInput]
			%  Element.EXISTSPROP(DegreeOverlap, PROP) throws error if PROP does NOT exist for DegreeOverlap.
			%   Error id: [BRAPH2:DegreeOverlap:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 15 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':DegreeOverlap:' 'WrongInput'], ...
					['BRAPH2' ':DegreeOverlap:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for DegreeOverlap.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in degree overlap/error.
			%
			% CHECK = DegreeOverlap.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(DegreeOverlap, TAG) checks whether TAG exists for DegreeOverlap.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:DegreeOverlap:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:DegreeOverlap:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:DegreeOverlap:WrongInput]
			%  Element.EXISTSTAG(DegreeOverlap, TAG) throws error if TAG does NOT exist for DegreeOverlap.
			%   Error id: [BRAPH2:DegreeOverlap:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':DegreeOverlap:' 'WrongInput'], ...
					['BRAPH2' ':DegreeOverlap:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for DegreeOverlap.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(DegreeOverlap, POINTER) returns property number of POINTER of DegreeOverlap.
			%  PROPERTY = M.GETPROPPROP(DegreeOverlap, POINTER) returns property number of POINTER of DegreeOverlap.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('DegreeOverlap')
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
			%  TAG = Element.GETPROPTAG(DegreeOverlap, POINTER) returns tag of POINTER of DegreeOverlap.
			%  TAG = M.GETPROPTAG(DegreeOverlap, POINTER) returns tag of POINTER of DegreeOverlap.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				degreeoverlap_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' };
				tag = degreeoverlap_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(DegreeOverlap, POINTER) returns category of POINTER of DegreeOverlap.
			%  CATEGORY = M.GETPROPCATEGORY(DegreeOverlap, POINTER) returns category of POINTER of DegreeOverlap.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = DegreeOverlap.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			degreeoverlap_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9 };
			prop_category = degreeoverlap_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(DegreeOverlap, POINTER) returns format of POINTER of DegreeOverlap.
			%  FORMAT = M.GETPROPFORMAT(DegreeOverlap, POINTER) returns format of POINTER of DegreeOverlap.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = DegreeOverlap.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			degreeoverlap_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8 };
			prop_format = degreeoverlap_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(DegreeOverlap, POINTER) returns description of POINTER of DegreeOverlap.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(DegreeOverlap, POINTER) returns description of POINTER of DegreeOverlap.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = DegreeOverlap.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			degreeoverlap_description_list = { 'ELCLASS (constant, string) is the class of the Degree Overlap.'  'NAME (constant, string) is the name of the Degree Overlap.'  'DESCRIPTION (constant, string) is the description of the Degree Overlap.'  'TEMPLATE (parameter, item) is the template of the Degree Overlap.'  'ID (data, string) is a few-letter code of the Degree Overlap.'  'LABEL (metadata, string) is an extended label of the Degree Overlap.'  'NOTES (metadata, string) are some specific notes about the Degree Overlap.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Degree Overlap.'  'PFM (gui, item) contains the panel figure of the measure.' };
			prop_description = degreeoverlap_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(DegreeOverlap, POINTER) returns settings of POINTER of DegreeOverlap.
			%  SETTINGS = M.GETPROPSETTINGS(DegreeOverlap, POINTER) returns settings of POINTER of DegreeOverlap.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = DegreeOverlap.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % DegreeOverlap.TEMPLATE
					prop_settings = 'DegreeOverlap';
				otherwise
					prop_settings = getPropSettings@EdgeOverlap(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = DegreeOverlap.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = DegreeOverlap.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(DegreeOverlap, POINTER) returns the default value of POINTER of DegreeOverlap.
			%  DEFAULT = M.GETPROPDEFAULT(DegreeOverlap, POINTER) returns the default value of POINTER of DegreeOverlap.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = DegreeOverlap.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % DegreeOverlap.ELCLASS
					prop_default = 'DegreeOverlap';
				case 2 % DegreeOverlap.NAME
					prop_default = 'Degree Overlap';
				case 3 % DegreeOverlap.DESCRIPTION
					prop_default = 'The Degree Overlap (DegreeOverlap) is the number of edges connected to a node in all layers. Connection weights are ignored in calculations.';
				case 4 % DegreeOverlap.TEMPLATE
					prop_default = Format.getFormatDefault(8, DegreeOverlap.getPropSettings(prop));
				case 5 % DegreeOverlap.ID
					prop_default = 'DegreeOverlap ID';
				case 6 % DegreeOverlap.LABEL
					prop_default = 'Degree Overlap label';
				case 7 % DegreeOverlap.NOTES
					prop_default = 'Degree Overlap notes';
				case 9 % DegreeOverlap.SHAPE
					prop_default = 2;
				case 10 % DegreeOverlap.SCOPE
					prop_default = 1;
				case 11 % DegreeOverlap.PARAMETRICITY
					prop_default = 2;
				case 12 % DegreeOverlap.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxBU' 'MultilayerWU' 'MultilayerBU' 'MultilayerBUD' 'MultilayerBUT' 'OrdMlBU' 'OrdMlWU'};;
				otherwise
					prop_default = getPropDefault@EdgeOverlap(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = DegreeOverlap.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = DegreeOverlap.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(DegreeOverlap, POINTER) returns the conditioned default value of POINTER of DegreeOverlap.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(DegreeOverlap, POINTER) returns the conditioned default value of POINTER of DegreeOverlap.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = DegreeOverlap.getPropProp(pointer);
			
			prop_default = DegreeOverlap.conditioning(prop, DegreeOverlap.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(DegreeOverlap, PROP, VALUE) checks VALUE format for PROP of DegreeOverlap.
			%  CHECK = M.CHECKPROP(DegreeOverlap, PROP, VALUE) checks VALUE format for PROP of DegreeOverlap.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:DegreeOverlap:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:DegreeOverlap:WrongInput
			%  Element.CHECKPROP(DegreeOverlap, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DegreeOverlap.
			%   Error id: BRAPH2:DegreeOverlap:WrongInput
			%  M.CHECKPROP(DegreeOverlap, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DegreeOverlap.
			%   Error id: BRAPH2:DegreeOverlap:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('DegreeOverlap')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = DegreeOverlap.getPropProp(pointer);
			
			switch prop
				case 4 % DegreeOverlap.TEMPLATE
					check = Format.checkFormat(8, value, DegreeOverlap.getPropSettings(prop));
				otherwise
					if prop <= 15
						check = checkProp@EdgeOverlap(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':DegreeOverlap:' 'WrongInput'], ...
					['BRAPH2' ':DegreeOverlap:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' DegreeOverlap.getPropTag(prop) ' (' DegreeOverlap.getFormatTag(DegreeOverlap.getPropFormat(prop)) ').'] ...
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
				case 14 % DegreeOverlap.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					ls = g.get('PARTITIONS');
					
					if l == 0
					    value = {};
					else
					    edge_overlap = calculateValue@EdgeOverlap(m, prop);
					    degree_overlap = cell(length(ls), 1);
					    
					    for i=1:length(ls)
					        edge_overlap_partition = edge_overlap{i};
					        degree_overlap(i) = {sum(edge_overlap_partition == 1, 2)};
					    end
					    value = degree_overlap;
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 15
						value = calculateValue@EdgeOverlap(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
