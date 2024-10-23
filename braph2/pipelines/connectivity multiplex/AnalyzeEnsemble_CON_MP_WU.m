classdef AnalyzeEnsemble_CON_MP_WU < AnalyzeEnsemble
	%AnalyzeEnsemble_CON_MP_WU is an ensemble-based graph analysis using connectivity multiplex data.
	% It is a subclass of <a href="matlab:help AnalyzeEnsemble">AnalyzeEnsemble</a>.
	%
	% This graph analysis (AnalyzeEnsemble_CON_MP_WU) analyzes connectivity multiplex data using weighted undirected graphs.
	%
	% The list of AnalyzeEnsemble_CON_MP_WU properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the ensemble-based graph analysis with connectivity multiplex data.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ensemble-based graph analysis with connectivity multiplex data.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with connectivity multiplex data.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with connectivity multiplex data.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ensemble-based graph analysis with connectivity multiplex data.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with connectivity multiplex data.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with connectivity multiplex data.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>GR</strong> 	GR (data, item) is the subject group, which also defines the subject class SubjectCON_MP.
	%  <strong>11</strong> <strong>GRAPH_TEMPLATE</strong> 	GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
	%  <strong>12</strong> <strong>G_DICT</strong> 	G_DICT (result, idict) is the graph (MultiplexWU) ensemble obtained from this analysis.
	%  <strong>13</strong> <strong>ME_DICT</strong> 	ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
	%  <strong>14</strong> <strong>MEASUREENSEMBLE</strong> 	MEASUREENSEMBLE (query, item) returns an ensemble-based measure.
	%
	% AnalyzeEnsemble_CON_MP_WU methods (constructor):
	%  AnalyzeEnsemble_CON_MP_WU - constructor
	%
	% AnalyzeEnsemble_CON_MP_WU methods:
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
	% AnalyzeEnsemble_CON_MP_WU methods (display):
	%  tostring - string with information about the graph analysis with connectivity multiplex data
	%  disp - displays information about the graph analysis with connectivity multiplex data
	%  tree - displays the tree of the graph analysis with connectivity multiplex data
	%
	% AnalyzeEnsemble_CON_MP_WU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph analysis with connectivity multiplex data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph analysis with connectivity multiplex data
	%
	% AnalyzeEnsemble_CON_MP_WU methods (save/load, Static):
	%  save - saves BRAPH2 graph analysis with connectivity multiplex data as b2 file
	%  load - loads a BRAPH2 graph analysis with connectivity multiplex data from a b2 file
	%
	% AnalyzeEnsemble_CON_MP_WU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph analysis with connectivity multiplex data
	%
	% AnalyzeEnsemble_CON_MP_WU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph analysis with connectivity multiplex data
	%
	% AnalyzeEnsemble_CON_MP_WU methods (inspection, Static):
	%  getClass - returns the class of the graph analysis with connectivity multiplex data
	%  getSubclasses - returns all subclasses of AnalyzeEnsemble_CON_MP_WU
	%  getProps - returns the property list of the graph analysis with connectivity multiplex data
	%  getPropNumber - returns the property number of the graph analysis with connectivity multiplex data
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
	% AnalyzeEnsemble_CON_MP_WU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% AnalyzeEnsemble_CON_MP_WU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% AnalyzeEnsemble_CON_MP_WU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeEnsemble_CON_MP_WU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?AnalyzeEnsemble_CON_MP_WU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">AnalyzeEnsemble_CON_MP_WU constants</a>.
	%
	%
	% See also SubjectCON_MP, MultiplexWU..
	%
	% BUILD BRAPH2 6 class_name 1
	
	methods % constructor
		function a = AnalyzeEnsemble_CON_MP_WU(varargin)
			%AnalyzeEnsemble_CON_MP_WU() creates a graph analysis with connectivity multiplex data.
			%
			% AnalyzeEnsemble_CON_MP_WU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeEnsemble_CON_MP_WU(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of AnalyzeEnsemble_CON_MP_WU properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the ensemble-based graph analysis with connectivity multiplex data.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ensemble-based graph analysis with connectivity multiplex data.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with connectivity multiplex data.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with connectivity multiplex data.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ensemble-based graph analysis with connectivity multiplex data.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with connectivity multiplex data.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with connectivity multiplex data.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>GR</strong> 	GR (data, item) is the subject group, which also defines the subject class SubjectCON_MP.
			%  <strong>11</strong> <strong>GRAPH_TEMPLATE</strong> 	GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
			%  <strong>12</strong> <strong>G_DICT</strong> 	G_DICT (result, idict) is the graph (MultiplexWU) ensemble obtained from this analysis.
			%  <strong>13</strong> <strong>ME_DICT</strong> 	ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
			%  <strong>14</strong> <strong>MEASUREENSEMBLE</strong> 	MEASUREENSEMBLE (query, item) returns an ensemble-based measure.
			%
			% See also Category, Format.
			
			a = a@AnalyzeEnsemble(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the graph analysis with connectivity multiplex data.
			%
			% BUILD = AnalyzeEnsemble_CON_MP_WU.GETBUILD() returns the build of 'AnalyzeEnsemble_CON_MP_WU'.
			%
			% Alternative forms to call this method are:
			%  BUILD = A.GETBUILD() returns the build of the graph analysis with connectivity multiplex data A.
			%  BUILD = Element.GETBUILD(A) returns the build of 'A'.
			%  BUILD = Element.GETBUILD('AnalyzeEnsemble_CON_MP_WU') returns the build of 'AnalyzeEnsemble_CON_MP_WU'.
			%
			% Note that the Element.GETBUILD(A) and Element.GETBUILD('AnalyzeEnsemble_CON_MP_WU')
			%  are less computationally efficient.
			
			build = 1;
		end
		function a_class = getClass()
			%GETCLASS returns the class of the graph analysis with connectivity multiplex data.
			%
			% CLASS = AnalyzeEnsemble_CON_MP_WU.GETCLASS() returns the class 'AnalyzeEnsemble_CON_MP_WU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = A.GETCLASS() returns the class of the graph analysis with connectivity multiplex data A.
			%  CLASS = Element.GETCLASS(A) returns the class of 'A'.
			%  CLASS = Element.GETCLASS('AnalyzeEnsemble_CON_MP_WU') returns 'AnalyzeEnsemble_CON_MP_WU'.
			%
			% Note that the Element.GETCLASS(A) and Element.GETCLASS('AnalyzeEnsemble_CON_MP_WU')
			%  are less computationally efficient.
			
			a_class = 'AnalyzeEnsemble_CON_MP_WU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph analysis with connectivity multiplex data.
			%
			% LIST = AnalyzeEnsemble_CON_MP_WU.GETSUBCLASSES() returns all subclasses of 'AnalyzeEnsemble_CON_MP_WU'.
			%
			% Alternative forms to call this method are:
			%  LIST = A.GETSUBCLASSES() returns all subclasses of the graph analysis with connectivity multiplex data A.
			%  LIST = Element.GETSUBCLASSES(A) returns all subclasses of 'A'.
			%  LIST = Element.GETSUBCLASSES('AnalyzeEnsemble_CON_MP_WU') returns all subclasses of 'AnalyzeEnsemble_CON_MP_WU'.
			%
			% Note that the Element.GETSUBCLASSES(A) and Element.GETSUBCLASSES('AnalyzeEnsemble_CON_MP_WU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'AnalyzeEnsemble_CON_MP_WU' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph analysis with connectivity multiplex data.
			%
			% PROPS = AnalyzeEnsemble_CON_MP_WU.GETPROPS() returns the property list of graph analysis with connectivity multiplex data
			%  as a row vector.
			%
			% PROPS = AnalyzeEnsemble_CON_MP_WU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = A.GETPROPS([CATEGORY]) returns the property list of the graph analysis with connectivity multiplex data A.
			%  PROPS = Element.GETPROPS(A[, CATEGORY]) returns the property list of 'A'.
			%  PROPS = Element.GETPROPS('AnalyzeEnsemble_CON_MP_WU'[, CATEGORY]) returns the property list of 'AnalyzeEnsemble_CON_MP_WU'.
			%
			% Note that the Element.GETPROPS(A) and Element.GETPROPS('AnalyzeEnsemble_CON_MP_WU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 11];
				case 4 % Category.DATA
					prop_list = [5 10];
				case 5 % Category.RESULT
					prop_list = [12 13];
				case 6 % Category.QUERY
					prop_list = [8 14];
				case 9 % Category.GUI
					prop_list = 9;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph analysis with connectivity multiplex data.
			%
			% N = AnalyzeEnsemble_CON_MP_WU.GETPROPNUMBER() returns the property number of graph analysis with connectivity multiplex data.
			%
			% N = AnalyzeEnsemble_CON_MP_WU.GETPROPNUMBER(CATEGORY) returns the property number of graph analysis with connectivity multiplex data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = A.GETPROPNUMBER([CATEGORY]) returns the property number of the graph analysis with connectivity multiplex data A.
			%  N = Element.GETPROPNUMBER(A) returns the property number of 'A'.
			%  N = Element.GETPROPNUMBER('AnalyzeEnsemble_CON_MP_WU') returns the property number of 'AnalyzeEnsemble_CON_MP_WU'.
			%
			% Note that the Element.GETPROPNUMBER(A) and Element.GETPROPNUMBER('AnalyzeEnsemble_CON_MP_WU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 14;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 2;
				case 4 % Category.DATA
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 2;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph analysis with connectivity multiplex data/error.
			%
			% CHECK = AnalyzeEnsemble_CON_MP_WU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSPROP(PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(A, PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(AnalyzeEnsemble_CON_MP_WU, PROP) checks whether PROP exists for AnalyzeEnsemble_CON_MP_WU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemble_CON_MP_WU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSPROP(PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_MP_WU:WrongInput]
			%  Element.EXISTSPROP(A, PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_MP_WU:WrongInput]
			%  Element.EXISTSPROP(AnalyzeEnsemble_CON_MP_WU, PROP) throws error if PROP does NOT exist for AnalyzeEnsemble_CON_MP_WU.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_MP_WU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(A) and Element.EXISTSPROP('AnalyzeEnsemble_CON_MP_WU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 14 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeEnsemble_CON_MP_WU:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeEnsemble_CON_MP_WU:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeEnsemble_CON_MP_WU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph analysis with connectivity multiplex data/error.
			%
			% CHECK = AnalyzeEnsemble_CON_MP_WU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSTAG(TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(A, TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(AnalyzeEnsemble_CON_MP_WU, TAG) checks whether TAG exists for AnalyzeEnsemble_CON_MP_WU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemble_CON_MP_WU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSTAG(TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_MP_WU:WrongInput]
			%  Element.EXISTSTAG(A, TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_MP_WU:WrongInput]
			%  Element.EXISTSTAG(AnalyzeEnsemble_CON_MP_WU, TAG) throws error if TAG does NOT exist for AnalyzeEnsemble_CON_MP_WU.
			%   Error id: [BRAPH2:AnalyzeEnsemble_CON_MP_WU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(A) and Element.EXISTSTAG('AnalyzeEnsemble_CON_MP_WU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'GRAPH_TEMPLATE'  'G_DICT'  'ME_DICT'  'MEASUREENSEMBLE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeEnsemble_CON_MP_WU:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeEnsemble_CON_MP_WU:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for AnalyzeEnsemble_CON_MP_WU.'] ...
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
			%  PROPERTY = A.GETPROPPROP(POINTER) returns property number of POINTER of A.
			%  PROPERTY = Element.GETPROPPROP(AnalyzeEnsemble_CON_MP_WU, POINTER) returns property number of POINTER of AnalyzeEnsemble_CON_MP_WU.
			%  PROPERTY = A.GETPROPPROP(AnalyzeEnsemble_CON_MP_WU, POINTER) returns property number of POINTER of AnalyzeEnsemble_CON_MP_WU.
			%
			% Note that the Element.GETPROPPROP(A) and Element.GETPROPPROP('AnalyzeEnsemble_CON_MP_WU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'GRAPH_TEMPLATE'  'G_DICT'  'ME_DICT'  'MEASUREENSEMBLE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = A.GETPROPTAG(POINTER) returns tag of POINTER of A.
			%  TAG = Element.GETPROPTAG(AnalyzeEnsemble_CON_MP_WU, POINTER) returns tag of POINTER of AnalyzeEnsemble_CON_MP_WU.
			%  TAG = A.GETPROPTAG(AnalyzeEnsemble_CON_MP_WU, POINTER) returns tag of POINTER of AnalyzeEnsemble_CON_MP_WU.
			%
			% Note that the Element.GETPROPTAG(A) and Element.GETPROPTAG('AnalyzeEnsemble_CON_MP_WU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				analyzeensemble_con_mp_wu_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'GRAPH_TEMPLATE'  'G_DICT'  'ME_DICT'  'MEASUREENSEMBLE' };
				tag = analyzeensemble_con_mp_wu_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = A.GETPROPCATEGORY(POINTER) returns category of POINTER of A.
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeEnsemble_CON_MP_WU, POINTER) returns category of POINTER of AnalyzeEnsemble_CON_MP_WU.
			%  CATEGORY = A.GETPROPCATEGORY(AnalyzeEnsemble_CON_MP_WU, POINTER) returns category of POINTER of AnalyzeEnsemble_CON_MP_WU.
			%
			% Note that the Element.GETPROPCATEGORY(A) and Element.GETPROPCATEGORY('AnalyzeEnsemble_CON_MP_WU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble_CON_MP_WU.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzeensemble_con_mp_wu_category_list = { 1  1  1  3  4  2  2  6  9  4  3  5  5  6 };
			prop_category = analyzeensemble_con_mp_wu_category_list{prop};
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
			%  FORMAT = A.GETPROPFORMAT(POINTER) returns format of POINTER of A.
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeEnsemble_CON_MP_WU, POINTER) returns format of POINTER of AnalyzeEnsemble_CON_MP_WU.
			%  FORMAT = A.GETPROPFORMAT(AnalyzeEnsemble_CON_MP_WU, POINTER) returns format of POINTER of AnalyzeEnsemble_CON_MP_WU.
			%
			% Note that the Element.GETPROPFORMAT(A) and Element.GETPROPFORMAT('AnalyzeEnsemble_CON_MP_WU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble_CON_MP_WU.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzeensemble_con_mp_wu_format_list = { 2  2  2  8  2  2  2  2  4  8  8  10  10  8 };
			prop_format = analyzeensemble_con_mp_wu_format_list{prop};
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
			%  DESCRIPTION = A.GETPROPDESCRIPTION(POINTER) returns description of POINTER of A.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeEnsemble_CON_MP_WU, POINTER) returns description of POINTER of AnalyzeEnsemble_CON_MP_WU.
			%  DESCRIPTION = A.GETPROPDESCRIPTION(AnalyzeEnsemble_CON_MP_WU, POINTER) returns description of POINTER of AnalyzeEnsemble_CON_MP_WU.
			%
			% Note that the Element.GETPROPDESCRIPTION(A) and Element.GETPROPDESCRIPTION('AnalyzeEnsemble_CON_MP_WU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble_CON_MP_WU.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzeensemble_con_mp_wu_description_list = { 'ELCLASS (constant, string) is the class of the ensemble-based graph analysis with connectivity multiplex data.'  'NAME (constant, string) is the name of the ensemble-based graph analysis with connectivity multiplex data.'  'DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with connectivity multiplex data.'  'TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with connectivity multiplex data.'  'ID (data, string) is a few-letter code for the ensemble-based graph analysis with connectivity multiplex data.'  'LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with connectivity multiplex data.'  'NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with connectivity multiplex data.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'GR (data, item) is the subject group, which also defines the subject class SubjectCON_MP.'  'GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.'  'G_DICT (result, idict) is the graph (MultiplexWU) ensemble obtained from this analysis.'  'ME_DICT (result, idict) contains the calculated measures of the graph ensemble.'  'MEASUREENSEMBLE (query, item) returns an ensemble-based measure.' };
			prop_description = analyzeensemble_con_mp_wu_description_list{prop};
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
			%  SETTINGS = A.GETPROPSETTINGS(POINTER) returns settings of POINTER of A.
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeEnsemble_CON_MP_WU, POINTER) returns settings of POINTER of AnalyzeEnsemble_CON_MP_WU.
			%  SETTINGS = A.GETPROPSETTINGS(AnalyzeEnsemble_CON_MP_WU, POINTER) returns settings of POINTER of AnalyzeEnsemble_CON_MP_WU.
			%
			% Note that the Element.GETPROPSETTINGS(A) and Element.GETPROPSETTINGS('AnalyzeEnsemble_CON_MP_WU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble_CON_MP_WU.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % AnalyzeEnsemble_CON_MP_WU.TEMPLATE
					prop_settings = 'AnalyzeEnsemble_CON_MP_WU';
				case 11 % AnalyzeEnsemble_CON_MP_WU.GRAPH_TEMPLATE
					prop_settings = 'MultiplexWU';
				case 12 % AnalyzeEnsemble_CON_MP_WU.G_DICT
					prop_settings = 'MultiplexWU';
				otherwise
					prop_settings = getPropSettings@AnalyzeEnsemble(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeEnsemble_CON_MP_WU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemble_CON_MP_WU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULT(POINTER) returns the default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeEnsemble_CON_MP_WU, POINTER) returns the default value of POINTER of AnalyzeEnsemble_CON_MP_WU.
			%  DEFAULT = A.GETPROPDEFAULT(AnalyzeEnsemble_CON_MP_WU, POINTER) returns the default value of POINTER of AnalyzeEnsemble_CON_MP_WU.
			%
			% Note that the Element.GETPROPDEFAULT(A) and Element.GETPROPDEFAULT('AnalyzeEnsemble_CON_MP_WU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeEnsemble_CON_MP_WU.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % AnalyzeEnsemble_CON_MP_WU.ELCLASS
					prop_default = 'AnalyzeEnsemble_CON_MP_WU';
				case 2 % AnalyzeEnsemble_CON_MP_WU.NAME
					prop_default = 'Multiplex Connectivity Weighted Undirected Analyze Ensemble';
				case 3 % AnalyzeEnsemble_CON_MP_WU.DESCRIPTION
					prop_default = 'This graph analysis (AnalyzeEnsemble_CON_MP_WU) analyzes connectivity multiplex data using weighted undirected graphs.';
				case 4 % AnalyzeEnsemble_CON_MP_WU.TEMPLATE
					prop_default = Format.getFormatDefault(8, AnalyzeEnsemble_CON_MP_WU.getPropSettings(prop));
				case 5 % AnalyzeEnsemble_CON_MP_WU.ID
					prop_default = 'AnalyzeEnsemble_CON_MP_WU ID';
				case 6 % AnalyzeEnsemble_CON_MP_WU.LABEL
					prop_default = 'AnalyzeEnsemble_CON_MP_WU label';
				case 7 % AnalyzeEnsemble_CON_MP_WU.NOTES
					prop_default = 'AnalyzeEnsemble_CON_MP_WU notes';
				case 10 % AnalyzeEnsemble_CON_MP_WU.GR
					prop_default = Group('SUB_CLASS', 'SubjectCON_MP');
				case 11 % AnalyzeEnsemble_CON_MP_WU.GRAPH_TEMPLATE
					prop_default = Format.getFormatDefault(8, AnalyzeEnsemble_CON_MP_WU.getPropSettings(prop));
				case 12 % AnalyzeEnsemble_CON_MP_WU.G_DICT
					prop_default = Format.getFormatDefault(10, AnalyzeEnsemble_CON_MP_WU.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@AnalyzeEnsemble(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeEnsemble_CON_MP_WU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemble_CON_MP_WU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemble_CON_MP_WU, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemble_CON_MP_WU.
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemble_CON_MP_WU, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemble_CON_MP_WU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(A) and Element.GETPROPDEFAULTCONDITIONED('AnalyzeEnsemble_CON_MP_WU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = AnalyzeEnsemble_CON_MP_WU.getPropProp(pointer);
			
			prop_default = AnalyzeEnsemble_CON_MP_WU.conditioning(prop, AnalyzeEnsemble_CON_MP_WU.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = A.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = A.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of A.
			%  CHECK = Element.CHECKPROP(AnalyzeEnsemble_CON_MP_WU, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemble_CON_MP_WU.
			%  CHECK = A.CHECKPROP(AnalyzeEnsemble_CON_MP_WU, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemble_CON_MP_WU.
			% 
			% A.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:AnalyzeEnsemble_CON_MP_WU:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  A.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of A.
			%   Error id: BRAPH2:AnalyzeEnsemble_CON_MP_WU:WrongInput
			%  Element.CHECKPROP(AnalyzeEnsemble_CON_MP_WU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemble_CON_MP_WU.
			%   Error id: BRAPH2:AnalyzeEnsemble_CON_MP_WU:WrongInput
			%  A.CHECKPROP(AnalyzeEnsemble_CON_MP_WU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemble_CON_MP_WU.
			%   Error id: BRAPH2:AnalyzeEnsemble_CON_MP_WU:WrongInput]
			% 
			% Note that the Element.CHECKPROP(A) and Element.CHECKPROP('AnalyzeEnsemble_CON_MP_WU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = AnalyzeEnsemble_CON_MP_WU.getPropProp(pointer);
			
			switch prop
				case 4 % AnalyzeEnsemble_CON_MP_WU.TEMPLATE
					check = Format.checkFormat(8, value, AnalyzeEnsemble_CON_MP_WU.getPropSettings(prop));
				case 11 % AnalyzeEnsemble_CON_MP_WU.GRAPH_TEMPLATE
					check = Format.checkFormat(8, value, AnalyzeEnsemble_CON_MP_WU.getPropSettings(prop));
				case 12 % AnalyzeEnsemble_CON_MP_WU.G_DICT
					check = Format.checkFormat(10, value, AnalyzeEnsemble_CON_MP_WU.getPropSettings(prop));
				otherwise
					if prop <= 14
						check = checkProp@AnalyzeEnsemble(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeEnsemble_CON_MP_WU:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeEnsemble_CON_MP_WU:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeEnsemble_CON_MP_WU.getPropTag(prop) ' (' AnalyzeEnsemble_CON_MP_WU.getFormatTag(AnalyzeEnsemble_CON_MP_WU.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(a, prop, varargin)
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
				case 12 % AnalyzeEnsemble_CON_MP_WU.G_DICT
					rng_settings_ = rng(); rng(a.getPropSeed(12), 'twister')
					
					g_dict = IndexedDictionary('IT_CLASS', 'MultiplexWU');
					gr = a.get('GR');
					
					for i = 1:1:gr.get('SUB_DICT').get('LENGTH')
					    sub = gr.get('SUB_DICT').get('IT', i);
					    L = sub.get('L');
					
					    g = MultiplexWU( ...
					        'ID', ['graph ' sub.get('ID')], ...
					        'B', sub.getCallback('CON_MP'), ... 
					        'LAYERLABELS', cellfun(@(x) ['L' num2str(x)], num2cell([1:1:L]), 'UniformOutput', false), ...
					        'NODELABELS', a.get('GR').get('SUB_DICT').get('IT', 1).get('BA').get('BR_DICT').get('KEYS') ...
					        );
					    g_dict.get('ADD', g)
					end
					
					if ~isa(a.get('GRAPH_TEMPLATE'), 'NoValue')
					    for i = 1:1:g_dict.get('LENGTH')
					        g_dict.get('IT', i).set('TEMPLATE', a.get('GRAPH_TEMPLATE'))
					    end
					end
					
					value = g_dict;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 14
						value = calculateValue@AnalyzeEnsemble(a, prop, varargin{:});
					else
						value = calculateValue@Element(a, prop, varargin{:});
					end
			end
			
		end
	end
end
