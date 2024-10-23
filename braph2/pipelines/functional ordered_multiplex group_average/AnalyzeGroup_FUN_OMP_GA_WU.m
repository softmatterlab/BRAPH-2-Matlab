classdef AnalyzeGroup_FUN_OMP_GA_WU < AnalyzeGroup
	%AnalyzeGroup_FUN_OMP_GA_WU is a graph analysis using functional ordinal multiplex data.
	% It is a subclass of <a href="matlab:help AnalyzeGroup">AnalyzeGroup</a>.
	%
	% 
	%
	% The list of AnalyzeGroup_FUN_OMP_GA_WU properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the graph analysis with functional ordinal multiplex data.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the graph analysis with functional ordinal multiplex data.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the graph analysis with functional ordinal multiplex data.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the graph analysis with functional ordinal multiplex data.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the graph analysis with functional ordinal multiplex data.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the graph analysis with functional ordinal multiplex data.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis with functional ordinal multiplex data.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>GR</strong> 	GR (data, item) is the subject group, which also defines the subject class SubjectFUN_MP.
	%  <strong>11</strong> <strong>G</strong> 	G (result, item) is the average graph (OrdMxWU) obtained from this analysis.
	%  <strong>12</strong> <strong>REPETITION</strong> 	REPETITION (parameter, scalar) is the number of repetitions
	%  <strong>13</strong> <strong>F_MIN</strong> 	F_MIN (parameter, scalar) is the minimum frequency value
	%  <strong>14</strong> <strong>F_MAX</strong> 	F_MAX (parameter, scalar) is the maximum frequency value
	%  <strong>15</strong> <strong>CORRELATION_RULE</strong> 	CORRELATION_RULE (parameter, option) is the correlation type.
	%  <strong>16</strong> <strong>NEGATIVE_WEIGHT_RULE</strong> 	NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
	%
	% AnalyzeGroup_FUN_OMP_GA_WU methods (constructor):
	%  AnalyzeGroup_FUN_OMP_GA_WU - constructor
	%
	% AnalyzeGroup_FUN_OMP_GA_WU methods:
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
	% AnalyzeGroup_FUN_OMP_GA_WU methods (display):
	%  tostring - string with information about the graph analysis with functional ordinal multiplex data
	%  disp - displays information about the graph analysis with functional ordinal multiplex data
	%  tree - displays the tree of the graph analysis with functional ordinal multiplex data
	%
	% AnalyzeGroup_FUN_OMP_GA_WU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph analysis with functional ordinal multiplex data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph analysis with functional ordinal multiplex data
	%
	% AnalyzeGroup_FUN_OMP_GA_WU methods (save/load, Static):
	%  save - saves BRAPH2 graph analysis with functional ordinal multiplex data as b2 file
	%  load - loads a BRAPH2 graph analysis with functional ordinal multiplex data from a b2 file
	%
	% AnalyzeGroup_FUN_OMP_GA_WU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph analysis with functional ordinal multiplex data
	%
	% AnalyzeGroup_FUN_OMP_GA_WU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph analysis with functional ordinal multiplex data
	%
	% AnalyzeGroup_FUN_OMP_GA_WU methods (inspection, Static):
	%  getClass - returns the class of the graph analysis with functional ordinal multiplex data
	%  getSubclasses - returns all subclasses of AnalyzeGroup_FUN_OMP_GA_WU
	%  getProps - returns the property list of the graph analysis with functional ordinal multiplex data
	%  getPropNumber - returns the property number of the graph analysis with functional ordinal multiplex data
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
	% AnalyzeGroup_FUN_OMP_GA_WU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% AnalyzeGroup_FUN_OMP_GA_WU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% AnalyzeGroup_FUN_OMP_GA_WU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeGroup_FUN_OMP_GA_WU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?AnalyzeGroup_FUN_OMP_GA_WU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">AnalyzeGroup_FUN_OMP_GA_WU constants</a>.
	%
	%
	% See also SubjectFUN_MP, OrdMxWU.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		REPETITION = 12; %CET: Computational Efficiency Trick
		REPETITION_TAG = 'REPETITION';
		REPETITION_CATEGORY = 3;
		REPETITION_FORMAT = 11;
		
		F_MIN = 13; %CET: Computational Efficiency Trick
		F_MIN_TAG = 'F_MIN';
		F_MIN_CATEGORY = 3;
		F_MIN_FORMAT = 11;
		
		F_MAX = 14; %CET: Computational Efficiency Trick
		F_MAX_TAG = 'F_MAX';
		F_MAX_CATEGORY = 3;
		F_MAX_FORMAT = 11;
		
		CORRELATION_RULE = 15; %CET: Computational Efficiency Trick
		CORRELATION_RULE_TAG = 'CORRELATION_RULE';
		CORRELATION_RULE_CATEGORY = 3;
		CORRELATION_RULE_FORMAT = 5;
		
		NEGATIVE_WEIGHT_RULE = 16; %CET: Computational Efficiency Trick
		NEGATIVE_WEIGHT_RULE_TAG = 'NEGATIVE_WEIGHT_RULE';
		NEGATIVE_WEIGHT_RULE_CATEGORY = 3;
		NEGATIVE_WEIGHT_RULE_FORMAT = 5;
	end
	methods % constructor
		function a = AnalyzeGroup_FUN_OMP_GA_WU(varargin)
			%AnalyzeGroup_FUN_OMP_GA_WU() creates a graph analysis with functional ordinal multiplex data.
			%
			% AnalyzeGroup_FUN_OMP_GA_WU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeGroup_FUN_OMP_GA_WU(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of AnalyzeGroup_FUN_OMP_GA_WU properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the graph analysis with functional ordinal multiplex data.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the graph analysis with functional ordinal multiplex data.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the graph analysis with functional ordinal multiplex data.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the graph analysis with functional ordinal multiplex data.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the graph analysis with functional ordinal multiplex data.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the graph analysis with functional ordinal multiplex data.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graph analysis with functional ordinal multiplex data.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>GR</strong> 	GR (data, item) is the subject group, which also defines the subject class SubjectFUN_MP.
			%  <strong>11</strong> <strong>G</strong> 	G (result, item) is the average graph (OrdMxWU) obtained from this analysis.
			%  <strong>12</strong> <strong>REPETITION</strong> 	REPETITION (parameter, scalar) is the number of repetitions
			%  <strong>13</strong> <strong>F_MIN</strong> 	F_MIN (parameter, scalar) is the minimum frequency value
			%  <strong>14</strong> <strong>F_MAX</strong> 	F_MAX (parameter, scalar) is the maximum frequency value
			%  <strong>15</strong> <strong>CORRELATION_RULE</strong> 	CORRELATION_RULE (parameter, option) is the correlation type.
			%  <strong>16</strong> <strong>NEGATIVE_WEIGHT_RULE</strong> 	NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
			%
			% See also Category, Format.
			
			a = a@AnalyzeGroup(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the graph analysis with functional ordinal multiplex data.
			%
			% BUILD = AnalyzeGroup_FUN_OMP_GA_WU.GETBUILD() returns the build of 'AnalyzeGroup_FUN_OMP_GA_WU'.
			%
			% Alternative forms to call this method are:
			%  BUILD = A.GETBUILD() returns the build of the graph analysis with functional ordinal multiplex data A.
			%  BUILD = Element.GETBUILD(A) returns the build of 'A'.
			%  BUILD = Element.GETBUILD('AnalyzeGroup_FUN_OMP_GA_WU') returns the build of 'AnalyzeGroup_FUN_OMP_GA_WU'.
			%
			% Note that the Element.GETBUILD(A) and Element.GETBUILD('AnalyzeGroup_FUN_OMP_GA_WU')
			%  are less computationally efficient.
			
			build = 1;
		end
		function a_class = getClass()
			%GETCLASS returns the class of the graph analysis with functional ordinal multiplex data.
			%
			% CLASS = AnalyzeGroup_FUN_OMP_GA_WU.GETCLASS() returns the class 'AnalyzeGroup_FUN_OMP_GA_WU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = A.GETCLASS() returns the class of the graph analysis with functional ordinal multiplex data A.
			%  CLASS = Element.GETCLASS(A) returns the class of 'A'.
			%  CLASS = Element.GETCLASS('AnalyzeGroup_FUN_OMP_GA_WU') returns 'AnalyzeGroup_FUN_OMP_GA_WU'.
			%
			% Note that the Element.GETCLASS(A) and Element.GETCLASS('AnalyzeGroup_FUN_OMP_GA_WU')
			%  are less computationally efficient.
			
			a_class = 'AnalyzeGroup_FUN_OMP_GA_WU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph analysis with functional ordinal multiplex data.
			%
			% LIST = AnalyzeGroup_FUN_OMP_GA_WU.GETSUBCLASSES() returns all subclasses of 'AnalyzeGroup_FUN_OMP_GA_WU'.
			%
			% Alternative forms to call this method are:
			%  LIST = A.GETSUBCLASSES() returns all subclasses of the graph analysis with functional ordinal multiplex data A.
			%  LIST = Element.GETSUBCLASSES(A) returns all subclasses of 'A'.
			%  LIST = Element.GETSUBCLASSES('AnalyzeGroup_FUN_OMP_GA_WU') returns all subclasses of 'AnalyzeGroup_FUN_OMP_GA_WU'.
			%
			% Note that the Element.GETSUBCLASSES(A) and Element.GETSUBCLASSES('AnalyzeGroup_FUN_OMP_GA_WU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'AnalyzeGroup_FUN_OMP_GA_WU' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph analysis with functional ordinal multiplex data.
			%
			% PROPS = AnalyzeGroup_FUN_OMP_GA_WU.GETPROPS() returns the property list of graph analysis with functional ordinal multiplex data
			%  as a row vector.
			%
			% PROPS = AnalyzeGroup_FUN_OMP_GA_WU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = A.GETPROPS([CATEGORY]) returns the property list of the graph analysis with functional ordinal multiplex data A.
			%  PROPS = Element.GETPROPS(A[, CATEGORY]) returns the property list of 'A'.
			%  PROPS = Element.GETPROPS('AnalyzeGroup_FUN_OMP_GA_WU'[, CATEGORY]) returns the property list of 'AnalyzeGroup_FUN_OMP_GA_WU'.
			%
			% Note that the Element.GETPROPS(A) and Element.GETPROPS('AnalyzeGroup_FUN_OMP_GA_WU')
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
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 12 13 14 15 16];
				case 4 % Category.DATA
					prop_list = [5 10];
				case 5 % Category.RESULT
					prop_list = 11;
				case 6 % Category.QUERY
					prop_list = 8;
				case 9 % Category.GUI
					prop_list = 9;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph analysis with functional ordinal multiplex data.
			%
			% N = AnalyzeGroup_FUN_OMP_GA_WU.GETPROPNUMBER() returns the property number of graph analysis with functional ordinal multiplex data.
			%
			% N = AnalyzeGroup_FUN_OMP_GA_WU.GETPROPNUMBER(CATEGORY) returns the property number of graph analysis with functional ordinal multiplex data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = A.GETPROPNUMBER([CATEGORY]) returns the property number of the graph analysis with functional ordinal multiplex data A.
			%  N = Element.GETPROPNUMBER(A) returns the property number of 'A'.
			%  N = Element.GETPROPNUMBER('AnalyzeGroup_FUN_OMP_GA_WU') returns the property number of 'AnalyzeGroup_FUN_OMP_GA_WU'.
			%
			% Note that the Element.GETPROPNUMBER(A) and Element.GETPROPNUMBER('AnalyzeGroup_FUN_OMP_GA_WU')
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
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 6;
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
			%EXISTSPROP checks whether property exists in graph analysis with functional ordinal multiplex data/error.
			%
			% CHECK = AnalyzeGroup_FUN_OMP_GA_WU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSPROP(PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(A, PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(AnalyzeGroup_FUN_OMP_GA_WU, PROP) checks whether PROP exists for AnalyzeGroup_FUN_OMP_GA_WU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroup_FUN_OMP_GA_WU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSPROP(PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_FUN_OMP_GA_WU:WrongInput]
			%  Element.EXISTSPROP(A, PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_FUN_OMP_GA_WU:WrongInput]
			%  Element.EXISTSPROP(AnalyzeGroup_FUN_OMP_GA_WU, PROP) throws error if PROP does NOT exist for AnalyzeGroup_FUN_OMP_GA_WU.
			%   Error id: [BRAPH2:AnalyzeGroup_FUN_OMP_GA_WU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(A) and Element.EXISTSPROP('AnalyzeGroup_FUN_OMP_GA_WU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 16 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeGroup_FUN_OMP_GA_WU:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeGroup_FUN_OMP_GA_WU:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeGroup_FUN_OMP_GA_WU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph analysis with functional ordinal multiplex data/error.
			%
			% CHECK = AnalyzeGroup_FUN_OMP_GA_WU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSTAG(TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(A, TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(AnalyzeGroup_FUN_OMP_GA_WU, TAG) checks whether TAG exists for AnalyzeGroup_FUN_OMP_GA_WU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroup_FUN_OMP_GA_WU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSTAG(TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_FUN_OMP_GA_WU:WrongInput]
			%  Element.EXISTSTAG(A, TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_FUN_OMP_GA_WU:WrongInput]
			%  Element.EXISTSTAG(AnalyzeGroup_FUN_OMP_GA_WU, TAG) throws error if TAG does NOT exist for AnalyzeGroup_FUN_OMP_GA_WU.
			%   Error id: [BRAPH2:AnalyzeGroup_FUN_OMP_GA_WU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(A) and Element.EXISTSTAG('AnalyzeGroup_FUN_OMP_GA_WU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'G'  'REPETITION'  'F_MIN'  'F_MAX'  'CORRELATION_RULE'  'NEGATIVE_WEIGHT_RULE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeGroup_FUN_OMP_GA_WU:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeGroup_FUN_OMP_GA_WU:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for AnalyzeGroup_FUN_OMP_GA_WU.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(AnalyzeGroup_FUN_OMP_GA_WU, POINTER) returns property number of POINTER of AnalyzeGroup_FUN_OMP_GA_WU.
			%  PROPERTY = A.GETPROPPROP(AnalyzeGroup_FUN_OMP_GA_WU, POINTER) returns property number of POINTER of AnalyzeGroup_FUN_OMP_GA_WU.
			%
			% Note that the Element.GETPROPPROP(A) and Element.GETPROPPROP('AnalyzeGroup_FUN_OMP_GA_WU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'G'  'REPETITION'  'F_MIN'  'F_MAX'  'CORRELATION_RULE'  'NEGATIVE_WEIGHT_RULE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(AnalyzeGroup_FUN_OMP_GA_WU, POINTER) returns tag of POINTER of AnalyzeGroup_FUN_OMP_GA_WU.
			%  TAG = A.GETPROPTAG(AnalyzeGroup_FUN_OMP_GA_WU, POINTER) returns tag of POINTER of AnalyzeGroup_FUN_OMP_GA_WU.
			%
			% Note that the Element.GETPROPTAG(A) and Element.GETPROPTAG('AnalyzeGroup_FUN_OMP_GA_WU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				analyzegroup_fun_omp_ga_wu_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'G'  'REPETITION'  'F_MIN'  'F_MAX'  'CORRELATION_RULE'  'NEGATIVE_WEIGHT_RULE' };
				tag = analyzegroup_fun_omp_ga_wu_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeGroup_FUN_OMP_GA_WU, POINTER) returns category of POINTER of AnalyzeGroup_FUN_OMP_GA_WU.
			%  CATEGORY = A.GETPROPCATEGORY(AnalyzeGroup_FUN_OMP_GA_WU, POINTER) returns category of POINTER of AnalyzeGroup_FUN_OMP_GA_WU.
			%
			% Note that the Element.GETPROPCATEGORY(A) and Element.GETPROPCATEGORY('AnalyzeGroup_FUN_OMP_GA_WU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeGroup_FUN_OMP_GA_WU.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzegroup_fun_omp_ga_wu_category_list = { 1  1  1  3  4  2  2  6  9  4  5  3  3  3  3  3 };
			prop_category = analyzegroup_fun_omp_ga_wu_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeGroup_FUN_OMP_GA_WU, POINTER) returns format of POINTER of AnalyzeGroup_FUN_OMP_GA_WU.
			%  FORMAT = A.GETPROPFORMAT(AnalyzeGroup_FUN_OMP_GA_WU, POINTER) returns format of POINTER of AnalyzeGroup_FUN_OMP_GA_WU.
			%
			% Note that the Element.GETPROPFORMAT(A) and Element.GETPROPFORMAT('AnalyzeGroup_FUN_OMP_GA_WU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeGroup_FUN_OMP_GA_WU.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzegroup_fun_omp_ga_wu_format_list = { 2  2  2  8  2  2  2  2  4  8  8  11  11  11  5  5 };
			prop_format = analyzegroup_fun_omp_ga_wu_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeGroup_FUN_OMP_GA_WU, POINTER) returns description of POINTER of AnalyzeGroup_FUN_OMP_GA_WU.
			%  DESCRIPTION = A.GETPROPDESCRIPTION(AnalyzeGroup_FUN_OMP_GA_WU, POINTER) returns description of POINTER of AnalyzeGroup_FUN_OMP_GA_WU.
			%
			% Note that the Element.GETPROPDESCRIPTION(A) and Element.GETPROPDESCRIPTION('AnalyzeGroup_FUN_OMP_GA_WU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeGroup_FUN_OMP_GA_WU.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzegroup_fun_omp_ga_wu_description_list = { 'ELCLASS (constant, string) is the class of the graph analysis with functional ordinal multiplex data.'  'NAME (constant, string) is the name of the graph analysis with functional ordinal multiplex data.'  'DESCRIPTION (constant, string) is the description of the graph analysis with functional ordinal multiplex data.'  'TEMPLATE (parameter, item) is the template of the graph analysis with functional ordinal multiplex data.'  'ID (data, string) is a few-letter code for the graph analysis with functional ordinal multiplex data.'  'LABEL (metadata, string) is an extended label of the graph analysis with functional ordinal multiplex data.'  'NOTES (metadata, string) are some specific notes about the graph analysis with functional ordinal multiplex data.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'GR (data, item) is the subject group, which also defines the subject class SubjectFUN_MP.'  'G (result, item) is the average graph (OrdMxWU) obtained from this analysis.'  'REPETITION (parameter, scalar) is the number of repetitions'  'F_MIN (parameter, scalar) is the minimum frequency value'  'F_MAX (parameter, scalar) is the maximum frequency value'  'CORRELATION_RULE (parameter, option) is the correlation type.'  'NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.' };
			prop_description = analyzegroup_fun_omp_ga_wu_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeGroup_FUN_OMP_GA_WU, POINTER) returns settings of POINTER of AnalyzeGroup_FUN_OMP_GA_WU.
			%  SETTINGS = A.GETPROPSETTINGS(AnalyzeGroup_FUN_OMP_GA_WU, POINTER) returns settings of POINTER of AnalyzeGroup_FUN_OMP_GA_WU.
			%
			% Note that the Element.GETPROPSETTINGS(A) and Element.GETPROPSETTINGS('AnalyzeGroup_FUN_OMP_GA_WU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeGroup_FUN_OMP_GA_WU.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 12 % AnalyzeGroup_FUN_OMP_GA_WU.REPETITION
					prop_settings = Format.getFormatSettings(11);
				case 13 % AnalyzeGroup_FUN_OMP_GA_WU.F_MIN
					prop_settings = Format.getFormatSettings(11);
				case 14 % AnalyzeGroup_FUN_OMP_GA_WU.F_MAX
					prop_settings = Format.getFormatSettings(11);
				case 15 % AnalyzeGroup_FUN_OMP_GA_WU.CORRELATION_RULE
					prop_settings = Correlation.CORRELATION_RULE_LIST(1:3);
				case 16 % AnalyzeGroup_FUN_OMP_GA_WU.NEGATIVE_WEIGHT_RULE
					prop_settings = Correlation.NEGATIVE_WEIGHT_RULE_LIST;
				case 4 % AnalyzeGroup_FUN_OMP_GA_WU.TEMPLATE
					prop_settings = 'AnalyzeGroup_FUN_OMP_GA_WU';
				case 11 % AnalyzeGroup_FUN_OMP_GA_WU.G
					prop_settings = 'OrdMxWU';
				otherwise
					prop_settings = getPropSettings@AnalyzeGroup(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeGroup_FUN_OMP_GA_WU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroup_FUN_OMP_GA_WU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULT(POINTER) returns the default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeGroup_FUN_OMP_GA_WU, POINTER) returns the default value of POINTER of AnalyzeGroup_FUN_OMP_GA_WU.
			%  DEFAULT = A.GETPROPDEFAULT(AnalyzeGroup_FUN_OMP_GA_WU, POINTER) returns the default value of POINTER of AnalyzeGroup_FUN_OMP_GA_WU.
			%
			% Note that the Element.GETPROPDEFAULT(A) and Element.GETPROPDEFAULT('AnalyzeGroup_FUN_OMP_GA_WU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeGroup_FUN_OMP_GA_WU.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 12 % AnalyzeGroup_FUN_OMP_GA_WU.REPETITION
					prop_default = 1;
				case 13 % AnalyzeGroup_FUN_OMP_GA_WU.F_MIN
					prop_default = 0;
				case 14 % AnalyzeGroup_FUN_OMP_GA_WU.F_MAX
					prop_default = Inf;
				case 15 % AnalyzeGroup_FUN_OMP_GA_WU.CORRELATION_RULE
					prop_default = Correlation.CORRELATION_RULE_LIST{1};
				case 16 % AnalyzeGroup_FUN_OMP_GA_WU.NEGATIVE_WEIGHT_RULE
					prop_default = Correlation.NEGATIVE_WEIGHT_RULE_LIST{1};
				case 1 % AnalyzeGroup_FUN_OMP_GA_WU.ELCLASS
					prop_default = 'AnalyzeGroup_FUN_OMP_GA_WU';
				case 2 % AnalyzeGroup_FUN_OMP_GA_WU.NAME
					prop_default = 'Multiplex Functional Ordered Weighted Undirected Group Average Analyze Ensemble';
				case 3 % AnalyzeGroup_FUN_OMP_GA_WU.DESCRIPTION
					prop_default = 'This graph analysis uses functional ordinal multiplex data and analyzes them using weighted undirected graphs.';
				case 4 % AnalyzeGroup_FUN_OMP_GA_WU.TEMPLATE
					prop_default = Format.getFormatDefault(8, AnalyzeGroup_FUN_OMP_GA_WU.getPropSettings(prop));
				case 5 % AnalyzeGroup_FUN_OMP_GA_WU.ID
					prop_default = 'AnalyzeGroup_FUN_OMP_GA_WU ID';
				case 6 % AnalyzeGroup_FUN_OMP_GA_WU.LABEL
					prop_default = 'AnalyzeGroup_FUN_OMP_GA_WU label';
				case 7 % AnalyzeGroup_FUN_OMP_GA_WU.NOTES
					prop_default = 'AnalyzeGroup_FUN_OMP_GA_WU notes';
				case 10 % AnalyzeGroup_FUN_OMP_GA_WU.GR
					prop_default = Group('SUB_CLASS', 'SubjectFUN_MP');
				case 11 % AnalyzeGroup_FUN_OMP_GA_WU.G
					prop_default = OrdMxWU();
				otherwise
					prop_default = getPropDefault@AnalyzeGroup(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeGroup_FUN_OMP_GA_WU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroup_FUN_OMP_GA_WU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeGroup_FUN_OMP_GA_WU, POINTER) returns the conditioned default value of POINTER of AnalyzeGroup_FUN_OMP_GA_WU.
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(AnalyzeGroup_FUN_OMP_GA_WU, POINTER) returns the conditioned default value of POINTER of AnalyzeGroup_FUN_OMP_GA_WU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(A) and Element.GETPROPDEFAULTCONDITIONED('AnalyzeGroup_FUN_OMP_GA_WU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = AnalyzeGroup_FUN_OMP_GA_WU.getPropProp(pointer);
			
			prop_default = AnalyzeGroup_FUN_OMP_GA_WU.conditioning(prop, AnalyzeGroup_FUN_OMP_GA_WU.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(AnalyzeGroup_FUN_OMP_GA_WU, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroup_FUN_OMP_GA_WU.
			%  CHECK = A.CHECKPROP(AnalyzeGroup_FUN_OMP_GA_WU, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroup_FUN_OMP_GA_WU.
			% 
			% A.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:AnalyzeGroup_FUN_OMP_GA_WU:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  A.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of A.
			%   Error id: BRAPH2:AnalyzeGroup_FUN_OMP_GA_WU:WrongInput
			%  Element.CHECKPROP(AnalyzeGroup_FUN_OMP_GA_WU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroup_FUN_OMP_GA_WU.
			%   Error id: BRAPH2:AnalyzeGroup_FUN_OMP_GA_WU:WrongInput
			%  A.CHECKPROP(AnalyzeGroup_FUN_OMP_GA_WU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroup_FUN_OMP_GA_WU.
			%   Error id: BRAPH2:AnalyzeGroup_FUN_OMP_GA_WU:WrongInput]
			% 
			% Note that the Element.CHECKPROP(A) and Element.CHECKPROP('AnalyzeGroup_FUN_OMP_GA_WU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = AnalyzeGroup_FUN_OMP_GA_WU.getPropProp(pointer);
			
			switch prop
				case 12 % AnalyzeGroup_FUN_OMP_GA_WU.REPETITION
					check = Format.checkFormat(11, value, AnalyzeGroup_FUN_OMP_GA_WU.getPropSettings(prop));
				case 13 % AnalyzeGroup_FUN_OMP_GA_WU.F_MIN
					check = Format.checkFormat(11, value, AnalyzeGroup_FUN_OMP_GA_WU.getPropSettings(prop));
				case 14 % AnalyzeGroup_FUN_OMP_GA_WU.F_MAX
					check = Format.checkFormat(11, value, AnalyzeGroup_FUN_OMP_GA_WU.getPropSettings(prop));
				case 15 % AnalyzeGroup_FUN_OMP_GA_WU.CORRELATION_RULE
					check = Format.checkFormat(5, value, AnalyzeGroup_FUN_OMP_GA_WU.getPropSettings(prop));
				case 16 % AnalyzeGroup_FUN_OMP_GA_WU.NEGATIVE_WEIGHT_RULE
					check = Format.checkFormat(5, value, AnalyzeGroup_FUN_OMP_GA_WU.getPropSettings(prop));
				case 4 % AnalyzeGroup_FUN_OMP_GA_WU.TEMPLATE
					check = Format.checkFormat(8, value, AnalyzeGroup_FUN_OMP_GA_WU.getPropSettings(prop));
				case 11 % AnalyzeGroup_FUN_OMP_GA_WU.G
					check = Format.checkFormat(8, value, AnalyzeGroup_FUN_OMP_GA_WU.getPropSettings(prop));
				otherwise
					if prop <= 11
						check = checkProp@AnalyzeGroup(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeGroup_FUN_OMP_GA_WU:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeGroup_FUN_OMP_GA_WU:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeGroup_FUN_OMP_GA_WU.getPropTag(prop) ' (' AnalyzeGroup_FUN_OMP_GA_WU.getFormatTag(AnalyzeGroup_FUN_OMP_GA_WU.getPropFormat(prop)) ').'] ...
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
				case 11 % AnalyzeGroup_FUN_OMP_GA_WU.G
					rng_settings_ = rng(); rng(a.getPropSeed(11), 'twister')
					
					gr = a.get('GR');
					subjects_number = gr.get('SUB_DICT').get('LENGTH');
					
					T = a.get('REPETITION');
					fmin = a.get('F_MIN');
					fmax = a.get('F_MAX');
					A_fun_omp = cell(1, 2);
					for i = 1:1:subjects_number
						sub = gr.get('SUB_DICT').get('IT', i);
					    FUN_MP = sub.getr('FUN_MP');
					    L = sub.get('L');
					    
					    for j = 1:1:L
					        data = FUN_MP{j};
					        fs = 1 / T;
					        
					        if fmax > fmin && T > 0
					            NFFT = 2 * ceil(size(data, 1) / 2);
					            ft = fft(data, NFFT);  % Fourier transform
					            f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
					            ft(f < fmin | f > fmax, :) = 0;
					            data = ifft(ft, NFFT);
					        end
					        
					        A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
					        
					        if i == 1
					            A_fun_omp(j) = {A};
					        else
					            A_fun_omp(j) = {A_fun_omp{j} + A};
					        end
					    end
					end
					
					L = length(A_fun_omp);
					g = OrdMxWU( ...
					    'ID', ['Graph ' gr.get('ID')], ...
					    'B', cellfun(@(a) a / subjects_number, A_fun_omp, 'UniformOutput', false), ...
					    'LAYERLABELS', cellfun(@(x) ['L' num2str(x)], num2cell([1:1:L]), 'UniformOutput', false) ...
					    );
					
					if ~isa(a.getr('TEMPLATE'), 'NoValue') % the analysis has a template
					    g.set('TEMPLATE', a.get('TEMPLATE').memorize('G')) % the template is memorized
					end
					
					if a.get('GR').get('SUB_DICT').get('LENGTH')
					    g.set('NODELABELS', a.get('GR').get('SUB_DICT').get('IT', 1).get('BA').get('BR_DICT').get('KEYS'))
					end
					
					value = g;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 11
						value = calculateValue@AnalyzeGroup(a, prop, varargin{:});
					else
						value = calculateValue@Element(a, prop, varargin{:});
					end
			end
			
		end
	end
end
