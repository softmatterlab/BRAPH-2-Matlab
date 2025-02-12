classdef AnalyzeEnsemble < ConcreteElement
	%AnalyzeEnsemble is a ensemble-based graph analysis.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% AnalyzeEnsemble provides the methods necessary for all ensemble-based analysis subclasses.
	% Instances of this class should not be created. Use one of its subclasses instead.
	%
	% The list of AnalyzeEnsemble properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ensemble-based graph analysis.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ensemble-based graph analysis.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ensemble-based graph analysis.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>GR</strong> 	GR (data, item) is the subject group, which also defines the subject class.
	%  <strong>11</strong> <strong>GRAPH_TEMPLATE</strong> 	GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
	%  <strong>12</strong> <strong>G_DICT</strong> 	G_DICT (result, idict) is the graph ensemble obtained from this analysis.
	%  <strong>13</strong> <strong>ME_DICT</strong> 	ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
	%  <strong>14</strong> <strong>MEASUREENSEMBLE</strong> 	MEASUREENSEMBLE (query, item) returns an ensemble-based measure.
	%
	% AnalyzeEnsemble methods (constructor):
	%  AnalyzeEnsemble - constructor
	%
	% AnalyzeEnsemble methods:
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
	% AnalyzeEnsemble methods (display):
	%  tostring - string with information about the ensemble-based graph analysis
	%  disp - displays information about the ensemble-based graph analysis
	%  tree - displays the tree of the ensemble-based graph analysis
	%
	% AnalyzeEnsemble methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ensemble-based graph analysis are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ensemble-based graph analysis
	%
	% AnalyzeEnsemble methods (save/load, Static):
	%  save - saves BRAPH2 ensemble-based graph analysis as b2 file
	%  load - loads a BRAPH2 ensemble-based graph analysis from a b2 file
	%
	% AnalyzeEnsemble method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ensemble-based graph analysis
	%
	% AnalyzeEnsemble method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ensemble-based graph analysis
	%
	% AnalyzeEnsemble methods (inspection, Static):
	%  getClass - returns the class of the ensemble-based graph analysis
	%  getSubclasses - returns all subclasses of AnalyzeEnsemble
	%  getProps - returns the property list of the ensemble-based graph analysis
	%  getPropNumber - returns the property number of the ensemble-based graph analysis
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
	% AnalyzeEnsemble methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% AnalyzeEnsemble methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% AnalyzeEnsemble methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeEnsemble methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?AnalyzeEnsemble; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">AnalyzeEnsemble constants</a>.
	%
	%
	% See also CompareEnsemble.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		WAITBAR = 9; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
		
		GR = 10; %CET: Computational Efficiency Trick
		GR_TAG = 'GR';
		GR_CATEGORY = 4;
		GR_FORMAT = 8;
		
		GRAPH_TEMPLATE = 11; %CET: Computational Efficiency Trick
		GRAPH_TEMPLATE_TAG = 'GRAPH_TEMPLATE';
		GRAPH_TEMPLATE_CATEGORY = 3;
		GRAPH_TEMPLATE_FORMAT = 8;
		
		G_DICT = 12; %CET: Computational Efficiency Trick
		G_DICT_TAG = 'G_DICT';
		G_DICT_CATEGORY = 5;
		G_DICT_FORMAT = 10;
		
		ME_DICT = 13; %CET: Computational Efficiency Trick
		ME_DICT_TAG = 'ME_DICT';
		ME_DICT_CATEGORY = 5;
		ME_DICT_FORMAT = 10;
		
		MEASUREENSEMBLE = 14; %CET: Computational Efficiency Trick
		MEASUREENSEMBLE_TAG = 'MEASUREENSEMBLE';
		MEASUREENSEMBLE_CATEGORY = 6;
		MEASUREENSEMBLE_FORMAT = 8;
	end
	methods % constructor
		function a = AnalyzeEnsemble(varargin)
			%AnalyzeEnsemble() creates a ensemble-based graph analysis.
			%
			% AnalyzeEnsemble(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeEnsemble(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of AnalyzeEnsemble properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ensemble-based graph analysis.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ensemble-based graph analysis.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ensemble-based graph analysis.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>GR</strong> 	GR (data, item) is the subject group, which also defines the subject class.
			%  <strong>11</strong> <strong>GRAPH_TEMPLATE</strong> 	GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
			%  <strong>12</strong> <strong>G_DICT</strong> 	G_DICT (result, idict) is the graph ensemble obtained from this analysis.
			%  <strong>13</strong> <strong>ME_DICT</strong> 	ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
			%  <strong>14</strong> <strong>MEASUREENSEMBLE</strong> 	MEASUREENSEMBLE (query, item) returns an ensemble-based measure.
			%
			% See also Category, Format.
			
			a = a@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the ensemble-based graph analysis.
			%
			% BUILD = AnalyzeEnsemble.GETBUILD() returns the build of 'AnalyzeEnsemble'.
			%
			% Alternative forms to call this method are:
			%  BUILD = A.GETBUILD() returns the build of the ensemble-based graph analysis A.
			%  BUILD = Element.GETBUILD(A) returns the build of 'A'.
			%  BUILD = Element.GETBUILD('AnalyzeEnsemble') returns the build of 'AnalyzeEnsemble'.
			%
			% Note that the Element.GETBUILD(A) and Element.GETBUILD('AnalyzeEnsemble')
			%  are less computationally efficient.
			
			build = 1;
		end
		function a_class = getClass()
			%GETCLASS returns the class of the ensemble-based graph analysis.
			%
			% CLASS = AnalyzeEnsemble.GETCLASS() returns the class 'AnalyzeEnsemble'.
			%
			% Alternative forms to call this method are:
			%  CLASS = A.GETCLASS() returns the class of the ensemble-based graph analysis A.
			%  CLASS = Element.GETCLASS(A) returns the class of 'A'.
			%  CLASS = Element.GETCLASS('AnalyzeEnsemble') returns 'AnalyzeEnsemble'.
			%
			% Note that the Element.GETCLASS(A) and Element.GETCLASS('AnalyzeEnsemble')
			%  are less computationally efficient.
			
			a_class = 'AnalyzeEnsemble';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ensemble-based graph analysis.
			%
			% LIST = AnalyzeEnsemble.GETSUBCLASSES() returns all subclasses of 'AnalyzeEnsemble'.
			%
			% Alternative forms to call this method are:
			%  LIST = A.GETSUBCLASSES() returns all subclasses of the ensemble-based graph analysis A.
			%  LIST = Element.GETSUBCLASSES(A) returns all subclasses of 'A'.
			%  LIST = Element.GETSUBCLASSES('AnalyzeEnsemble') returns all subclasses of 'AnalyzeEnsemble'.
			%
			% Note that the Element.GETSUBCLASSES(A) and Element.GETSUBCLASSES('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'AnalyzeEnsemble'  'AnalyzeEnsemble_CON_BUD'  'AnalyzeEnsemble_CON_BUT'  'AnalyzeEnsemble_CON_WU'  'AnalyzeEnsemble_CON_WD'  'AnalyzeEnsemble_CON_MP_BUD'  'AnalyzeEnsemble_CON_MP_BUT'  'AnalyzeEnsemble_CON_MP_WU'  'AnalyzeEnsemble_CON_OMP_WU'  'AnalyzeEnsemble_CON_FUN_MP_BUD'  'AnalyzeEnsemble_CON_FUN_MP_BUT'  'AnalyzeEnsemble_CON_FUN_MP_WU'  'AnalyzeEnsemble_FUN_BUD'  'AnalyzeEnsemble_FUN_BUT'  'AnalyzeEnsemble_FUN_WU'  'AnalyzeEnsemble_FUN_MP_BUD'  'AnalyzeEnsemble_FUN_MP_BUT'  'AnalyzeEnsemble_FUN_MP_WU'  'AnalyzeEnsemble_FUN_OMP_WU' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ensemble-based graph analysis.
			%
			% PROPS = AnalyzeEnsemble.GETPROPS() returns the property list of ensemble-based graph analysis
			%  as a row vector.
			%
			% PROPS = AnalyzeEnsemble.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = A.GETPROPS([CATEGORY]) returns the property list of the ensemble-based graph analysis A.
			%  PROPS = Element.GETPROPS(A[, CATEGORY]) returns the property list of 'A'.
			%  PROPS = Element.GETPROPS('AnalyzeEnsemble'[, CATEGORY]) returns the property list of 'AnalyzeEnsemble'.
			%
			% Note that the Element.GETPROPS(A) and Element.GETPROPS('AnalyzeEnsemble')
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
			%GETPROPNUMBER returns the property number of ensemble-based graph analysis.
			%
			% N = AnalyzeEnsemble.GETPROPNUMBER() returns the property number of ensemble-based graph analysis.
			%
			% N = AnalyzeEnsemble.GETPROPNUMBER(CATEGORY) returns the property number of ensemble-based graph analysis
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = A.GETPROPNUMBER([CATEGORY]) returns the property number of the ensemble-based graph analysis A.
			%  N = Element.GETPROPNUMBER(A) returns the property number of 'A'.
			%  N = Element.GETPROPNUMBER('AnalyzeEnsemble') returns the property number of 'AnalyzeEnsemble'.
			%
			% Note that the Element.GETPROPNUMBER(A) and Element.GETPROPNUMBER('AnalyzeEnsemble')
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
			%EXISTSPROP checks whether property exists in ensemble-based graph analysis/error.
			%
			% CHECK = AnalyzeEnsemble.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSPROP(PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(A, PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(AnalyzeEnsemble, PROP) checks whether PROP exists for AnalyzeEnsemble.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSPROP(PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%  Element.EXISTSPROP(A, PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%  Element.EXISTSPROP(AnalyzeEnsemble, PROP) throws error if PROP does NOT exist for AnalyzeEnsemble.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%
			% Note that the Element.EXISTSPROP(A) and Element.EXISTSPROP('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 14 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeEnsemble:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeEnsemble:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeEnsemble.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ensemble-based graph analysis/error.
			%
			% CHECK = AnalyzeEnsemble.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSTAG(TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(A, TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(AnalyzeEnsemble, TAG) checks whether TAG exists for AnalyzeEnsemble.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSTAG(TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%  Element.EXISTSTAG(A, TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%  Element.EXISTSTAG(AnalyzeEnsemble, TAG) throws error if TAG does NOT exist for AnalyzeEnsemble.
			%   Error id: [BRAPH2:AnalyzeEnsemble:WrongInput]
			%
			% Note that the Element.EXISTSTAG(A) and Element.EXISTSTAG('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'GRAPH_TEMPLATE'  'G_DICT'  'ME_DICT'  'MEASUREENSEMBLE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeEnsemble:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeEnsemble:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for AnalyzeEnsemble.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(AnalyzeEnsemble, POINTER) returns property number of POINTER of AnalyzeEnsemble.
			%  PROPERTY = A.GETPROPPROP(AnalyzeEnsemble, POINTER) returns property number of POINTER of AnalyzeEnsemble.
			%
			% Note that the Element.GETPROPPROP(A) and Element.GETPROPPROP('AnalyzeEnsemble')
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
			%  TAG = Element.GETPROPTAG(AnalyzeEnsemble, POINTER) returns tag of POINTER of AnalyzeEnsemble.
			%  TAG = A.GETPROPTAG(AnalyzeEnsemble, POINTER) returns tag of POINTER of AnalyzeEnsemble.
			%
			% Note that the Element.GETPROPTAG(A) and Element.GETPROPTAG('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				analyzeensemble_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'GRAPH_TEMPLATE'  'G_DICT'  'ME_DICT'  'MEASUREENSEMBLE' };
				tag = analyzeensemble_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeEnsemble, POINTER) returns category of POINTER of AnalyzeEnsemble.
			%  CATEGORY = A.GETPROPCATEGORY(AnalyzeEnsemble, POINTER) returns category of POINTER of AnalyzeEnsemble.
			%
			% Note that the Element.GETPROPCATEGORY(A) and Element.GETPROPCATEGORY('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzeensemble_category_list = { 1  1  1  3  4  2  2  6  9  4  3  5  5  6 };
			prop_category = analyzeensemble_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeEnsemble, POINTER) returns format of POINTER of AnalyzeEnsemble.
			%  FORMAT = A.GETPROPFORMAT(AnalyzeEnsemble, POINTER) returns format of POINTER of AnalyzeEnsemble.
			%
			% Note that the Element.GETPROPFORMAT(A) and Element.GETPROPFORMAT('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzeensemble_format_list = { 2  2  2  8  2  2  2  2  4  8  8  10  10  8 };
			prop_format = analyzeensemble_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeEnsemble, POINTER) returns description of POINTER of AnalyzeEnsemble.
			%  DESCRIPTION = A.GETPROPDESCRIPTION(AnalyzeEnsemble, POINTER) returns description of POINTER of AnalyzeEnsemble.
			%
			% Note that the Element.GETPROPDESCRIPTION(A) and Element.GETPROPDESCRIPTION('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzeensemble_description_list = { 'ELCLASS (constant, string) is the class of the % % % .'  'NAME (constant, string) is the name of the ensemble-based graph analysis.'  'DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis.'  'TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis.'  'ID (data, string) is a few-letter code for the ensemble-based graph analysis.'  'LABEL (metadata, string) is an extended label of the ensemble-based graph analysis.'  'NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'GR (data, item) is the subject group, which also defines the subject class.'  'GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.'  'G_DICT (result, idict) is the graph ensemble obtained from this analysis.'  'ME_DICT (result, idict) contains the calculated measures of the graph ensemble.'  'MEASUREENSEMBLE (query, item) returns an ensemble-based measure.' };
			prop_description = analyzeensemble_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeEnsemble, POINTER) returns settings of POINTER of AnalyzeEnsemble.
			%  SETTINGS = A.GETPROPSETTINGS(AnalyzeEnsemble, POINTER) returns settings of POINTER of AnalyzeEnsemble.
			%
			% Note that the Element.GETPROPSETTINGS(A) and Element.GETPROPSETTINGS('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % AnalyzeEnsemble.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 10 % AnalyzeEnsemble.GR
					prop_settings = 'Group';
				case 11 % AnalyzeEnsemble.GRAPH_TEMPLATE
					prop_settings = 'Graph';
				case 12 % AnalyzeEnsemble.G_DICT
					prop_settings = 'Graph';
				case 13 % AnalyzeEnsemble.ME_DICT
					prop_settings = 'MeasureEnsemble';
				case 14 % AnalyzeEnsemble.MEASUREENSEMBLE
					prop_settings = 'MeasureEnsemble';
				case 4 % AnalyzeEnsemble.TEMPLATE
					prop_settings = 'AnalyzeEnsemble';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeEnsemble.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemble.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULT(POINTER) returns the default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeEnsemble, POINTER) returns the default value of POINTER of AnalyzeEnsemble.
			%  DEFAULT = A.GETPROPDEFAULT(AnalyzeEnsemble, POINTER) returns the default value of POINTER of AnalyzeEnsemble.
			%
			% Note that the Element.GETPROPDEFAULT(A) and Element.GETPROPDEFAULT('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % AnalyzeEnsemble.WAITBAR
					prop_default = true;
				case 10 % AnalyzeEnsemble.GR
					prop_default = Format.getFormatDefault(8, AnalyzeEnsemble.getPropSettings(prop));
				case 11 % AnalyzeEnsemble.GRAPH_TEMPLATE
					prop_default = Format.getFormatDefault(8, AnalyzeEnsemble.getPropSettings(prop));
				case 12 % AnalyzeEnsemble.G_DICT
					prop_default = Format.getFormatDefault(10, AnalyzeEnsemble.getPropSettings(prop));
				case 13 % AnalyzeEnsemble.ME_DICT
					prop_default = Format.getFormatDefault(10, AnalyzeEnsemble.getPropSettings(prop));
				case 14 % AnalyzeEnsemble.MEASUREENSEMBLE
					prop_default = Format.getFormatDefault(8, AnalyzeEnsemble.getPropSettings(prop));
				case 1 % AnalyzeEnsemble.ELCLASS
					prop_default = 'AnalyzeEnsemble';
				case 2 % AnalyzeEnsemble.NAME
					prop_default = 'AnalyzeEnsemble';
				case 3 % AnalyzeEnsemble.DESCRIPTION
					prop_default = 'AnalyzeEnsemble provides the methods necessary for all ensemble-based analysis subclasses. Instances of this class should not be created. Use one of its subclasses instead.';
				case 4 % AnalyzeEnsemble.TEMPLATE
					prop_default = Format.getFormatDefault(8, AnalyzeEnsemble.getPropSettings(prop));
				case 5 % AnalyzeEnsemble.ID
					prop_default = 'AnalyzeEnsemble ID';
				case 6 % AnalyzeEnsemble.LABEL
					prop_default = 'AnalyzeEnsemble label';
				case 7 % AnalyzeEnsemble.NOTES
					prop_default = 'AnalyzeEnsemble notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeEnsemble.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemble.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemble, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemble.
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemble, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemble.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(A) and Element.GETPROPDEFAULTCONDITIONED('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			prop_default = AnalyzeEnsemble.conditioning(prop, AnalyzeEnsemble.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(AnalyzeEnsemble, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemble.
			%  CHECK = A.CHECKPROP(AnalyzeEnsemble, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemble.
			% 
			% A.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:AnalyzeEnsemble:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  A.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of A.
			%   Error id: BRAPH2:AnalyzeEnsemble:WrongInput
			%  Element.CHECKPROP(AnalyzeEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemble.
			%   Error id: BRAPH2:AnalyzeEnsemble:WrongInput
			%  A.CHECKPROP(AnalyzeEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemble.
			%   Error id: BRAPH2:AnalyzeEnsemble:WrongInput]
			% 
			% Note that the Element.CHECKPROP(A) and Element.CHECKPROP('AnalyzeEnsemble')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = AnalyzeEnsemble.getPropProp(pointer);
			
			switch prop
				case 9 % AnalyzeEnsemble.WAITBAR
					check = Format.checkFormat(4, value, AnalyzeEnsemble.getPropSettings(prop));
				case 10 % AnalyzeEnsemble.GR
					check = Format.checkFormat(8, value, AnalyzeEnsemble.getPropSettings(prop));
				case 11 % AnalyzeEnsemble.GRAPH_TEMPLATE
					check = Format.checkFormat(8, value, AnalyzeEnsemble.getPropSettings(prop));
				case 12 % AnalyzeEnsemble.G_DICT
					check = Format.checkFormat(10, value, AnalyzeEnsemble.getPropSettings(prop));
				case 13 % AnalyzeEnsemble.ME_DICT
					check = Format.checkFormat(10, value, AnalyzeEnsemble.getPropSettings(prop));
				case 14 % AnalyzeEnsemble.MEASUREENSEMBLE
					check = Format.checkFormat(8, value, AnalyzeEnsemble.getPropSettings(prop));
				case 4 % AnalyzeEnsemble.TEMPLATE
					check = Format.checkFormat(8, value, AnalyzeEnsemble.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeEnsemble:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeEnsemble:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeEnsemble.getPropTag(prop) ' (' AnalyzeEnsemble.getFormatTag(AnalyzeEnsemble.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(a, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case 4 % AnalyzeEnsemble.TEMPLATE
					a.postset@ConcreteElement(4)
					
					a.get('TEMPLATE').memorize('GRAPH_TEMPLATE')
					
				otherwise
					if prop <= 8
						postset@ConcreteElement(a, prop);
					end
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
				case 12 % AnalyzeEnsemble.G_DICT
					rng_settings_ = rng(); rng(a.getPropSeed(12), 'twister')
					
					a.memorize('GRAPH_TEMPLATE');
					value = IndexedDictionary('IT_CLASS', 'Graph');
					
					rng(rng_settings_)
					
				case 13 % AnalyzeEnsemble.ME_DICT
					rng_settings_ = rng(); rng(a.getPropSeed(13), 'twister')
					
					a.memorize('GRAPH_TEMPLATE');
					value = IndexedDictionary('IT_CLASS', 'MeasureEnsemble', 'IT_KEY', 9);
					
					rng(rng_settings_)
					
				case 14 % AnalyzeEnsemble.MEASUREENSEMBLE
					% ME = a.get('MEASUREENSEMBLE', MEASURE_CLASS) checks whether the 
					%  measure ensemble exists in the property ME_DICT. If not it creates a new
					%  measure M of class MEASURE_CLASS with properties defined by the graph
					%  settings. The user must call getValue() for the new measure M to
					%  retrieve the value of measure ensemble ME.
					if isempty(varargin)
					    value = MeasureEnsemble();
					    
					    % % Warning commented because it most likely will lead to an error anyways
					    % warning( ...
					    %     ['BRAPH2' ':' class(a)], ...
					    %     ['BRAPH2' ':' class(a) '\n' ...
					    %     'Missing argument MEASURE_CLASS when using Analysis.get(''MEASUREENSEMBLE'', MEASURE_CLASS).'] ...
					    %     )
					    
					    return
					end
					measure_class = varargin{1};
					
					m_list = a.memorize('GRAPH_TEMPLATE').get('COMPATIBLE_MEASURES');
					if ~contains(measure_class, m_list)
					    error(...
					        ['BRAPH2' ':Analysis:' 'WrongInput'], ...
					        ['BRAPH2' ':Analysis:' 'WrongInput' ' \n' ...
					        a.getClass() ' utilizes graphs of type ' a.memorize('GRAPH_TEMPLATE').getClass() '. \n' ...
					        measure_class ' is not a compatible Measure with ' a.memorize('GRAPH_TEMPLATE').getClass() '. \n' ...
					        'Use ' a.memorize('GRAPH_TEMPLATE').getClass() '().get(''COMPATIBLE_MEASURES'') for a list of compatible measures.'])
					end
					
					g_dict = a.memorize('G_DICT');
					for i = 1:1:g_dict.get('LENGTH')
					    g_dict.get('IT', i).memorize('A');
					end
					
					me_dict = a.memorize('ME_DICT');
					if me_dict.get('CONTAINS_KEY', measure_class)
					    me = me_dict.get('IT', measure_class);
					else
					    me = MeasureEnsemble( ...
					        'ID', measure_class, ...
					        'A', a, ...
					        'MEASURE', measure_class ... % % % 'MEASURE_TEMPLATE', a.memorize('GRAPH_TEMPLATE').get('MEASURE', measure_class) ...
					        );
					    
					    me_dict.get('ADD', me);
					end
					
					value = me;
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(a, prop, varargin{:});
					else
						value = calculateValue@Element(a, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(a, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case 10 % AnalyzeEnsemble.GR
					pr = PanelPropItem('EL', a, 'PROP', 10, ...
					    'BUTTON_TEXT', a.get('GR').get('ID'), ...
					    varargin{:});
					
				case 11 % AnalyzeEnsemble.GRAPH_TEMPLATE
					pr = PanelPropItem('EL', a, 'PROP', 11, ...
					    'BUTTON_TEXT', ['GRAPH TEMPLATE (' a.get('GRAPH_TEMPLATE').getClass() ')'], ...
					    varargin{:});
					
				case 12 % AnalyzeEnsemble.G_DICT
					pr = AnalyzeEnsemblePP_GDict('EL', a, 'PROP', 12, ...
					    'WAITBAR', a.getCallback('WAITBAR'), ...
					    varargin{:});
					
				case 13 % AnalyzeEnsemble.ME_DICT
					pr = AnalyzeEnsemblePP_MeDict('EL', a, 'PROP', 13, ...
					    'WAITBAR', a.getCallback('WAITBAR'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(a, prop, varargin{:});
					
			end
		end
	end
end
