classdef EigenVectorCentrality < Measure
	%EigenVectorCentrality is the graph Eigenvector Centrality.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Eigenvector Centrality (EigenVectorCentrality) of a node is the ith element in the eigenvector corresponding 
	% to the largest eigenvalue of the largest eigenvalue of the graphs adjacency matrix.
	%
	% The list of EigenVectorCentrality properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Eigenvector Centrality.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Eigenvector Centrality.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Eigenvector Centrality.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Eigenvector Centrality.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Eigenvector Centrality.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Eigenvector Centrality.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Eigenvector Centrality.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Eigenvector Centrality.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%
	% EigenVectorCentrality methods (constructor):
	%  EigenVectorCentrality - constructor
	%
	% EigenVectorCentrality methods:
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
	% EigenVectorCentrality methods (display):
	%  tostring - string with information about the eigenvector centrality
	%  disp - displays information about the eigenvector centrality
	%  tree - displays the tree of the eigenvector centrality
	%
	% EigenVectorCentrality methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two eigenvector centrality are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the eigenvector centrality
	%
	% EigenVectorCentrality methods (save/load, Static):
	%  save - saves BRAPH2 eigenvector centrality as b2 file
	%  load - loads a BRAPH2 eigenvector centrality from a b2 file
	%
	% EigenVectorCentrality method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the eigenvector centrality
	%
	% EigenVectorCentrality method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the eigenvector centrality
	%
	% EigenVectorCentrality methods (inspection, Static):
	%  getClass - returns the class of the eigenvector centrality
	%  getSubclasses - returns all subclasses of EigenVectorCentrality
	%  getProps - returns the property list of the eigenvector centrality
	%  getPropNumber - returns the property number of the eigenvector centrality
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
	% EigenVectorCentrality methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% EigenVectorCentrality methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% EigenVectorCentrality methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% EigenVectorCentrality methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?EigenVectorCentrality; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">EigenVectorCentrality constants</a>.
	%
	
	methods % constructor
		function m = EigenVectorCentrality(varargin)
			%EigenVectorCentrality() creates a eigenvector centrality.
			%
			% EigenVectorCentrality(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% EigenVectorCentrality(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of EigenVectorCentrality properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Eigenvector Centrality.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Eigenvector Centrality.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Eigenvector Centrality.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Eigenvector Centrality.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Eigenvector Centrality.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Eigenvector Centrality.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Eigenvector Centrality.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Eigenvector Centrality.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the eigenvector centrality.
			%
			% BUILD = EigenVectorCentrality.GETBUILD() returns the build of 'EigenVectorCentrality'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the eigenvector centrality M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('EigenVectorCentrality') returns the build of 'EigenVectorCentrality'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('EigenVectorCentrality')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the eigenvector centrality.
			%
			% CLASS = EigenVectorCentrality.GETCLASS() returns the class 'EigenVectorCentrality'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the eigenvector centrality M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('EigenVectorCentrality') returns 'EigenVectorCentrality'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('EigenVectorCentrality')
			%  are less computationally efficient.
			
			m_class = 'EigenVectorCentrality';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the eigenvector centrality.
			%
			% LIST = EigenVectorCentrality.GETSUBCLASSES() returns all subclasses of 'EigenVectorCentrality'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the eigenvector centrality M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('EigenVectorCentrality') returns all subclasses of 'EigenVectorCentrality'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('EigenVectorCentrality')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'EigenVectorCentrality' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of eigenvector centrality.
			%
			% PROPS = EigenVectorCentrality.GETPROPS() returns the property list of eigenvector centrality
			%  as a row vector.
			%
			% PROPS = EigenVectorCentrality.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the eigenvector centrality M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('EigenVectorCentrality'[, CATEGORY]) returns the property list of 'EigenVectorCentrality'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('EigenVectorCentrality')
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
			%GETPROPNUMBER returns the property number of eigenvector centrality.
			%
			% N = EigenVectorCentrality.GETPROPNUMBER() returns the property number of eigenvector centrality.
			%
			% N = EigenVectorCentrality.GETPROPNUMBER(CATEGORY) returns the property number of eigenvector centrality
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the eigenvector centrality M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('EigenVectorCentrality') returns the property number of 'EigenVectorCentrality'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('EigenVectorCentrality')
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
			%EXISTSPROP checks whether property exists in eigenvector centrality/error.
			%
			% CHECK = EigenVectorCentrality.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(EigenVectorCentrality, PROP) checks whether PROP exists for EigenVectorCentrality.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:EigenVectorCentrality:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EigenVectorCentrality:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EigenVectorCentrality:WrongInput]
			%  Element.EXISTSPROP(EigenVectorCentrality, PROP) throws error if PROP does NOT exist for EigenVectorCentrality.
			%   Error id: [BRAPH2:EigenVectorCentrality:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('EigenVectorCentrality')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 15 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':EigenVectorCentrality:' 'WrongInput'], ...
					['BRAPH2' ':EigenVectorCentrality:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for EigenVectorCentrality.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in eigenvector centrality/error.
			%
			% CHECK = EigenVectorCentrality.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(EigenVectorCentrality, TAG) checks whether TAG exists for EigenVectorCentrality.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:EigenVectorCentrality:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EigenVectorCentrality:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EigenVectorCentrality:WrongInput]
			%  Element.EXISTSTAG(EigenVectorCentrality, TAG) throws error if TAG does NOT exist for EigenVectorCentrality.
			%   Error id: [BRAPH2:EigenVectorCentrality:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('EigenVectorCentrality')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':EigenVectorCentrality:' 'WrongInput'], ...
					['BRAPH2' ':EigenVectorCentrality:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for EigenVectorCentrality.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(EigenVectorCentrality, POINTER) returns property number of POINTER of EigenVectorCentrality.
			%  PROPERTY = M.GETPROPPROP(EigenVectorCentrality, POINTER) returns property number of POINTER of EigenVectorCentrality.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('EigenVectorCentrality')
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
			%  TAG = Element.GETPROPTAG(EigenVectorCentrality, POINTER) returns tag of POINTER of EigenVectorCentrality.
			%  TAG = M.GETPROPTAG(EigenVectorCentrality, POINTER) returns tag of POINTER of EigenVectorCentrality.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('EigenVectorCentrality')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				eigenvectorcentrality_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' };
				tag = eigenvectorcentrality_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(EigenVectorCentrality, POINTER) returns category of POINTER of EigenVectorCentrality.
			%  CATEGORY = M.GETPROPCATEGORY(EigenVectorCentrality, POINTER) returns category of POINTER of EigenVectorCentrality.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('EigenVectorCentrality')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = EigenVectorCentrality.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			eigenvectorcentrality_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9 };
			prop_category = eigenvectorcentrality_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(EigenVectorCentrality, POINTER) returns format of POINTER of EigenVectorCentrality.
			%  FORMAT = M.GETPROPFORMAT(EigenVectorCentrality, POINTER) returns format of POINTER of EigenVectorCentrality.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('EigenVectorCentrality')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = EigenVectorCentrality.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			eigenvectorcentrality_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8 };
			prop_format = eigenvectorcentrality_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(EigenVectorCentrality, POINTER) returns description of POINTER of EigenVectorCentrality.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(EigenVectorCentrality, POINTER) returns description of POINTER of EigenVectorCentrality.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('EigenVectorCentrality')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = EigenVectorCentrality.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			eigenvectorcentrality_description_list = { 'ELCLASS (constant, string) is the class of the Eigenvector Centrality.'  'NAME (constant, string) is the name of the Eigenvector Centrality.'  'DESCRIPTION (constant, string) is the description of the Eigenvector Centrality.'  'TEMPLATE (parameter, item) is the template of the Eigenvector Centrality.'  'ID (data, string) is a few-letter code of the Eigenvector Centrality.'  'LABEL (metadata, string) is an extended label of the Eigenvector Centrality.'  'NOTES (metadata, string) are some specific notes about the Eigenvector Centrality.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Eigenvector Centrality.'  'PFM (gui, item) contains the panel figure of the measure.' };
			prop_description = eigenvectorcentrality_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(EigenVectorCentrality, POINTER) returns settings of POINTER of EigenVectorCentrality.
			%  SETTINGS = M.GETPROPSETTINGS(EigenVectorCentrality, POINTER) returns settings of POINTER of EigenVectorCentrality.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('EigenVectorCentrality')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = EigenVectorCentrality.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % EigenVectorCentrality.TEMPLATE
					prop_settings = 'EigenVectorCentrality';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = EigenVectorCentrality.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = EigenVectorCentrality.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(EigenVectorCentrality, POINTER) returns the default value of POINTER of EigenVectorCentrality.
			%  DEFAULT = M.GETPROPDEFAULT(EigenVectorCentrality, POINTER) returns the default value of POINTER of EigenVectorCentrality.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('EigenVectorCentrality')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = EigenVectorCentrality.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % EigenVectorCentrality.ELCLASS
					prop_default = 'EigenVectorCentrality';
				case 2 % EigenVectorCentrality.NAME
					prop_default = 'Eigenvector Centrality';
				case 3 % EigenVectorCentrality.DESCRIPTION
					prop_default = 'The Eigenvector Centrality (EigenVectorCentrality) of a node is the ith element in the eigenvector corresponding to the largest eigenvalue of the largest eigenvalue of the graphs adjacency matrix.';
				case 4 % EigenVectorCentrality.TEMPLATE
					prop_default = Format.getFormatDefault(8, EigenVectorCentrality.getPropSettings(prop));
				case 5 % EigenVectorCentrality.ID
					prop_default = 'EigenVectorCentrality ID';
				case 6 % EigenVectorCentrality.LABEL
					prop_default = 'Eigenvector Centrality label';
				case 7 % EigenVectorCentrality.NOTES
					prop_default = 'Eigenvector Centrality notes';
				case 9 % EigenVectorCentrality.SHAPE
					prop_default = 2;
				case 10 % EigenVectorCentrality.SCOPE
					prop_default = 2;
				case 11 % EigenVectorCentrality.PARAMETRICITY
					prop_default = 2;
				case 12 % EigenVectorCentrality.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT'} ;;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = EigenVectorCentrality.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = EigenVectorCentrality.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(EigenVectorCentrality, POINTER) returns the conditioned default value of POINTER of EigenVectorCentrality.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(EigenVectorCentrality, POINTER) returns the conditioned default value of POINTER of EigenVectorCentrality.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('EigenVectorCentrality')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = EigenVectorCentrality.getPropProp(pointer);
			
			prop_default = EigenVectorCentrality.conditioning(prop, EigenVectorCentrality.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(EigenVectorCentrality, PROP, VALUE) checks VALUE format for PROP of EigenVectorCentrality.
			%  CHECK = M.CHECKPROP(EigenVectorCentrality, PROP, VALUE) checks VALUE format for PROP of EigenVectorCentrality.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:EigenVectorCentrality:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:EigenVectorCentrality:WrongInput
			%  Element.CHECKPROP(EigenVectorCentrality, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EigenVectorCentrality.
			%   Error id: BRAPH2:EigenVectorCentrality:WrongInput
			%  M.CHECKPROP(EigenVectorCentrality, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EigenVectorCentrality.
			%   Error id: BRAPH2:EigenVectorCentrality:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('EigenVectorCentrality')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = EigenVectorCentrality.getPropProp(pointer);
			
			switch prop
				case 4 % EigenVectorCentrality.TEMPLATE
					check = Format.checkFormat(8, value, EigenVectorCentrality.getPropSettings(prop));
				otherwise
					if prop <= 15
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':EigenVectorCentrality:' 'WrongInput'], ...
					['BRAPH2' ':EigenVectorCentrality:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' EigenVectorCentrality.getPropTag(prop) ' (' EigenVectorCentrality.getFormatTag(EigenVectorCentrality.getPropFormat(prop)) ').'] ...
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
				case 14 % EigenVectorCentrality.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					eigenvector_centrality = cell(L, 1);
					
					warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
					parfor li = 1:L
					    Aii = A{li, li};   
					    
					    if N(li) < 1000
					        [V, D] = eig(Aii);
					    else
					        [V, D] = eigs(sparse(Aii));
					    end
					    
					    [~, idx] = max(diag(D));
					    ec = abs(V(:, idx));
					    eigenvector_centrality(li) = {reshape(ec, length(ec), 1)};
					end
					warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')
					
					value = eigenvector_centrality;
					
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
