classdef MultiplexKCor < Measure
	%MultiplexKCor is the graph Multiplex K-Core.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Multiplex K-Core (MultiplexKCor) of a graph is the largest subnetwork comprising nodes of overlapping degree k or higher. 
	% k is set by the user; the default value is equal to 1.
	%
	% The list of MultiplexKCor properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Multiplex K-Core.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Multiplex K-Core.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Multiplex K-Core.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Multiplex K-Core.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Multiplex K-Core.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Multiplex K-Core.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Multiplex K-Core.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Multiplex K-Core.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>16</strong> <strong>MULTIPLEXKCORETHRESHOLD</strong> 	MULTIPLEXKCORETHRESHOLD (parameter, scalar) is the multiplex k-core threshold.
	%
	% MultiplexKCor methods (constructor):
	%  MultiplexKCor - constructor
	%
	% MultiplexKCor methods:
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
	% MultiplexKCor methods (display):
	%  tostring - string with information about the multiplex k-core
	%  disp - displays information about the multiplex k-core
	%  tree - displays the tree of the multiplex k-core
	%
	% MultiplexKCor methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multiplex k-core are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multiplex k-core
	%
	% MultiplexKCor methods (save/load, Static):
	%  save - saves BRAPH2 multiplex k-core as b2 file
	%  load - loads a BRAPH2 multiplex k-core from a b2 file
	%
	% MultiplexKCor method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multiplex k-core
	%
	% MultiplexKCor method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multiplex k-core
	%
	% MultiplexKCor methods (inspection, Static):
	%  getClass - returns the class of the multiplex k-core
	%  getSubclasses - returns all subclasses of MultiplexKCor
	%  getProps - returns the property list of the multiplex k-core
	%  getPropNumber - returns the property number of the multiplex k-core
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
	% MultiplexKCor methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiplexKCor methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiplexKCor methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexKCor methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiplexKCor; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiplexKCor constants</a>.
	%
	
	properties (Constant) % properties
		MULTIPLEXKCORETHRESHOLD = 16; %CET: Computational Efficiency Trick
		MULTIPLEXKCORETHRESHOLD_TAG = 'MULTIPLEXKCORETHRESHOLD';
		MULTIPLEXKCORETHRESHOLD_CATEGORY = 3;
		MULTIPLEXKCORETHRESHOLD_FORMAT = 11;
	end
	methods % constructor
		function m = MultiplexKCor(varargin)
			%MultiplexKCor() creates a multiplex k-core.
			%
			% MultiplexKCor(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexKCor(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of MultiplexKCor properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Multiplex K-Core.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Multiplex K-Core.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Multiplex K-Core.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Multiplex K-Core.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Multiplex K-Core.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Multiplex K-Core.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Multiplex K-Core.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Multiplex K-Core.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>16</strong> <strong>MULTIPLEXKCORETHRESHOLD</strong> 	MULTIPLEXKCORETHRESHOLD (parameter, scalar) is the multiplex k-core threshold.
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the multiplex k-core.
			%
			% BUILD = MultiplexKCor.GETBUILD() returns the build of 'MultiplexKCor'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the multiplex k-core M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('MultiplexKCor') returns the build of 'MultiplexKCor'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('MultiplexKCor')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the multiplex k-core.
			%
			% CLASS = MultiplexKCor.GETCLASS() returns the class 'MultiplexKCor'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multiplex k-core M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultiplexKCor') returns 'MultiplexKCor'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('MultiplexKCor')
			%  are less computationally efficient.
			
			m_class = 'MultiplexKCor';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multiplex k-core.
			%
			% LIST = MultiplexKCor.GETSUBCLASSES() returns all subclasses of 'MultiplexKCor'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the multiplex k-core M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('MultiplexKCor') returns all subclasses of 'MultiplexKCor'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('MultiplexKCor')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'MultiplexKCor' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multiplex k-core.
			%
			% PROPS = MultiplexKCor.GETPROPS() returns the property list of multiplex k-core
			%  as a row vector.
			%
			% PROPS = MultiplexKCor.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multiplex k-core M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultiplexKCor'[, CATEGORY]) returns the property list of 'MultiplexKCor'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('MultiplexKCor')
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
			%GETPROPNUMBER returns the property number of multiplex k-core.
			%
			% N = MultiplexKCor.GETPROPNUMBER() returns the property number of multiplex k-core.
			%
			% N = MultiplexKCor.GETPROPNUMBER(CATEGORY) returns the property number of multiplex k-core
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the multiplex k-core M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultiplexKCor') returns the property number of 'MultiplexKCor'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('MultiplexKCor')
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
			%EXISTSPROP checks whether property exists in multiplex k-core/error.
			%
			% CHECK = MultiplexKCor.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultiplexKCor, PROP) checks whether PROP exists for MultiplexKCor.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexKCor:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexKCor:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexKCor:WrongInput]
			%  Element.EXISTSPROP(MultiplexKCor, PROP) throws error if PROP does NOT exist for MultiplexKCor.
			%   Error id: [BRAPH2:MultiplexKCor:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('MultiplexKCor')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 16 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultiplexKCor:' 'WrongInput'], ...
					['BRAPH2' ':MultiplexKCor:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexKCor.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multiplex k-core/error.
			%
			% CHECK = MultiplexKCor.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultiplexKCor, TAG) checks whether TAG exists for MultiplexKCor.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexKCor:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexKCor:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexKCor:WrongInput]
			%  Element.EXISTSTAG(MultiplexKCor, TAG) throws error if TAG does NOT exist for MultiplexKCor.
			%   Error id: [BRAPH2:MultiplexKCor:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('MultiplexKCor')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'MULTIPLEXKCORETHRESHOLD' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultiplexKCor:' 'WrongInput'], ...
					['BRAPH2' ':MultiplexKCor:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for MultiplexKCor.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexKCor, POINTER) returns property number of POINTER of MultiplexKCor.
			%  PROPERTY = M.GETPROPPROP(MultiplexKCor, POINTER) returns property number of POINTER of MultiplexKCor.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('MultiplexKCor')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'MULTIPLEXKCORETHRESHOLD' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(MultiplexKCor, POINTER) returns tag of POINTER of MultiplexKCor.
			%  TAG = M.GETPROPTAG(MultiplexKCor, POINTER) returns tag of POINTER of MultiplexKCor.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('MultiplexKCor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				multiplexkcor_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'MULTIPLEXKCORETHRESHOLD' };
				tag = multiplexkcor_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexKCor, POINTER) returns category of POINTER of MultiplexKCor.
			%  CATEGORY = M.GETPROPCATEGORY(MultiplexKCor, POINTER) returns category of POINTER of MultiplexKCor.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('MultiplexKCor')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexKCor.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multiplexkcor_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3 };
			prop_category = multiplexkcor_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexKCor, POINTER) returns format of POINTER of MultiplexKCor.
			%  FORMAT = M.GETPROPFORMAT(MultiplexKCor, POINTER) returns format of POINTER of MultiplexKCor.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('MultiplexKCor')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexKCor.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multiplexkcor_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  11 };
			prop_format = multiplexkcor_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexKCor, POINTER) returns description of POINTER of MultiplexKCor.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultiplexKCor, POINTER) returns description of POINTER of MultiplexKCor.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('MultiplexKCor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexKCor.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multiplexkcor_description_list = { 'ELCLASS (constant, string) is the class of the Multiplex K-Core.'  'NAME (constant, string) is the name of the Multiplex K-Core.'  'DESCRIPTION (constant, string) is the description of the Multiplex K-Core.'  'TEMPLATE (parameter, item) is the template of the Multiplex K-Core.'  'ID (data, string) is a few-letter code of the Multiplex K-Core.'  'LABEL (metadata, string) is an extended label of the Multiplex K-Core.'  'NOTES (metadata, string) are some specific notes about the Multiplex K-Core.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Multiplex K-Core.'  'PFM (gui, item) contains the panel figure of the measure.'  'MULTIPLEXKCORETHRESHOLD (parameter, scalar) is the multiplex k-core threshold.' };
			prop_description = multiplexkcor_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexKCor, POINTER) returns settings of POINTER of MultiplexKCor.
			%  SETTINGS = M.GETPROPSETTINGS(MultiplexKCor, POINTER) returns settings of POINTER of MultiplexKCor.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('MultiplexKCor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexKCor.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % MultiplexKCor.MULTIPLEXKCORETHRESHOLD
					prop_settings = Format.getFormatSettings(11);
				case 4 % MultiplexKCor.TEMPLATE
					prop_settings = 'MultiplexKCor';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexKCor.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexKCor.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexKCor, POINTER) returns the default value of POINTER of MultiplexKCor.
			%  DEFAULT = M.GETPROPDEFAULT(MultiplexKCor, POINTER) returns the default value of POINTER of MultiplexKCor.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('MultiplexKCor')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexKCor.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % MultiplexKCor.MULTIPLEXKCORETHRESHOLD
					prop_default = 1;
				case 1 % MultiplexKCor.ELCLASS
					prop_default = 'MultiplexKCor';
				case 2 % MultiplexKCor.NAME
					prop_default = 'Multiplex K-Core';
				case 3 % MultiplexKCor.DESCRIPTION
					prop_default = 'The Multiplex K-Core (MultiplexKCor) of a graph is the largest subnetwork comprising nodes of overlapping degree k or higher. k is set by the user; the default value is equal to 1.';
				case 4 % MultiplexKCor.TEMPLATE
					prop_default = Format.getFormatDefault(8, MultiplexKCor.getPropSettings(prop));
				case 5 % MultiplexKCor.ID
					prop_default = 'MultiplexKCor ID';
				case 6 % MultiplexKCor.LABEL
					prop_default = 'Multiplex K-Core label';
				case 7 % MultiplexKCor.NOTES
					prop_default = 'Multiplex K-Core notes';
				case 9 % MultiplexKCor.SHAPE
					prop_default = 3;
				case 10 % MultiplexKCor.SCOPE
					prop_default = 1;
				case 11 % MultiplexKCor.PARAMETRICITY
					prop_default = 2;
				case 12 % MultiplexKCor.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'OrdMxWU' 'OrdMxBU'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexKCor.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexKCor.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexKCor, POINTER) returns the conditioned default value of POINTER of MultiplexKCor.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultiplexKCor, POINTER) returns the conditioned default value of POINTER of MultiplexKCor.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('MultiplexKCor')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiplexKCor.getPropProp(pointer);
			
			prop_default = MultiplexKCor.conditioning(prop, MultiplexKCor.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexKCor, PROP, VALUE) checks VALUE format for PROP of MultiplexKCor.
			%  CHECK = M.CHECKPROP(MultiplexKCor, PROP, VALUE) checks VALUE format for PROP of MultiplexKCor.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:MultiplexKCor:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:MultiplexKCor:WrongInput
			%  Element.CHECKPROP(MultiplexKCor, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexKCor.
			%   Error id: BRAPH2:MultiplexKCor:WrongInput
			%  M.CHECKPROP(MultiplexKCor, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexKCor.
			%   Error id: BRAPH2:MultiplexKCor:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('MultiplexKCor')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiplexKCor.getPropProp(pointer);
			
			switch prop
				case 16 % MultiplexKCor.MULTIPLEXKCORETHRESHOLD
					check = Format.checkFormat(11, value, MultiplexKCor.getPropSettings(prop));
				case 4 % MultiplexKCor.TEMPLATE
					check = Format.checkFormat(8, value, MultiplexKCor.getPropSettings(prop));
				otherwise
					if prop <= 15
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultiplexKCor:' 'WrongInput'], ...
					['BRAPH2' ':MultiplexKCor:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexKCor.getPropTag(prop) ' (' MultiplexKCor.getFormatTag(MultiplexKCor.getPropFormat(prop)) ').'] ...
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
				case 14 % MultiplexKCor.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					ls = g.get('PARTITIONS');  
					
					if l == 0
					    value = {};
					else
					    N = g.get('NODENUMBER');
					    multiplex_kcore_threshold = m.get('MULTIPLEXKCORETHRESHOLD');
					    assert(mod(multiplex_kcore_threshold, 1) == 0, ...
					        ['BRAPH2' ':MultiplexKCore:' 'WrongInput'], ...
					        ['MultiplexKCore threshold must be an integer value ' ...
					        'while it is ' tostring(multiplex_kcore_threshold)])
					    
					    directionality_layer = g.get('DIRECTIONALITY_TYPE', l);
					    multiplex_k_core = cell(length(ls), 1);
					    for i = 1:1:length(ls)
					        A_sum = zeros(N(1), N(1));
					        for j = 1:1:length(l)
					            A_sum = A_sum + A{j, j};
					        end
					        iter = 0;
					        subAii = binarize(A_sum);
					        while 1
					            if directionality_layer == 2  % undirected graphs
					                ovdeg = sum(subAii, 1)';   % ov. degree undirected 
					            else
					                ovdeg = (sum(subAii, 1)' + sum(subAii, 2));  % ov. degree directed
					            end
					         
					            % find nodes with degree < k
					            low_k_nodes = find((ovdeg < multiplex_kcore_threshold) & (ovdeg > 0));
					
					            % if none found -> stop
					            if (isempty(low_k_nodes)) break; end; %#ok<SEPEX>
					
					            % peel away found nodes
					            iter = iter + 1;
					            subAii(low_k_nodes, :) = 0;
					            subAii(:, low_k_nodes) = 0;
					        end
					        multiplex_k_core(i) = {subAii};  % add multiplex k-core 
					    end
					    value = multiplex_k_core;
					end
					
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
