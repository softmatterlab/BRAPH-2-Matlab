classdef MeasureEnsemble < ConcreteElement
	%MeasureEnsemble is a graph ensemble measure.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% MeasureEnsemble provides the methods necessary for a graph ensemble measure.
	%
	% The list of MeasureEnsemble properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the graph ensemble measure.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the graph ensemble measure.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the graph ensemble measure.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the graph ensemble measure.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the graph ensemble measure.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graph ensemble measure.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>MEASURE</strong> 	MEASURE (data, class) is the measure class.
	%  <strong>10</strong> <strong>A</strong> 	A (data, item) is the ensemble-based graph analysis.
	%  <strong>11</strong> <strong>M</strong> 	M (result, cell) is the measure group-average result.
	%  <strong>12</strong> <strong>PFME</strong> 	PFME (gui, item) contains the panel figure of the measure.
	%  <strong>13</strong> <strong>PFBG</strong> 	PFBG (gui, item) contains the panel figure of the brain graph.
	%
	% MeasureEnsemble methods (constructor):
	%  MeasureEnsemble - constructor
	%
	% MeasureEnsemble methods:
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
	% MeasureEnsemble methods (display):
	%  tostring - string with information about the graph ensemble measure
	%  disp - displays information about the graph ensemble measure
	%  tree - displays the tree of the graph ensemble measure
	%
	% MeasureEnsemble methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph ensemble measure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph ensemble measure
	%
	% MeasureEnsemble methods (save/load, Static):
	%  save - saves BRAPH2 graph ensemble measure as b2 file
	%  load - loads a BRAPH2 graph ensemble measure from a b2 file
	%
	% MeasureEnsemble method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph ensemble measure
	%
	% MeasureEnsemble method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph ensemble measure
	%
	% MeasureEnsemble methods (inspection, Static):
	%  getClass - returns the class of the graph ensemble measure
	%  getSubclasses - returns all subclasses of MeasureEnsemble
	%  getProps - returns the property list of the graph ensemble measure
	%  getPropNumber - returns the property number of the graph ensemble measure
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
	% MeasureEnsemble methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasureEnsemble methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasureEnsemble methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasureEnsemble methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasureEnsemble; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasureEnsemble constants</a>.
	%
	%
	% See also AnalyzeEnsemble, CompareEnsemble.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		MEASURE = 9; %CET: Computational Efficiency Trick
		MEASURE_TAG = 'MEASURE';
		MEASURE_CATEGORY = 4;
		MEASURE_FORMAT = 6;
		
		A = 10; %CET: Computational Efficiency Trick
		A_TAG = 'A';
		A_CATEGORY = 4;
		A_FORMAT = 8;
		
		M = 11; %CET: Computational Efficiency Trick
		M_TAG = 'M';
		M_CATEGORY = 5;
		M_FORMAT = 16;
		
		PFME = 12; %CET: Computational Efficiency Trick
		PFME_TAG = 'PFME';
		PFME_CATEGORY = 9;
		PFME_FORMAT = 8;
		
		PFBG = 13; %CET: Computational Efficiency Trick
		PFBG_TAG = 'PFBG';
		PFBG_CATEGORY = 9;
		PFBG_FORMAT = 8;
	end
	methods % constructor
		function me = MeasureEnsemble(varargin)
			%MeasureEnsemble() creates a graph ensemble measure.
			%
			% MeasureEnsemble(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasureEnsemble(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of MeasureEnsemble properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the graph ensemble measure.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the graph ensemble measure.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the graph ensemble measure.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the graph ensemble measure.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the graph ensemble measure.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graph ensemble measure.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>MEASURE</strong> 	MEASURE (data, class) is the measure class.
			%  <strong>10</strong> <strong>A</strong> 	A (data, item) is the ensemble-based graph analysis.
			%  <strong>11</strong> <strong>M</strong> 	M (result, cell) is the measure group-average result.
			%  <strong>12</strong> <strong>PFME</strong> 	PFME (gui, item) contains the panel figure of the measure.
			%  <strong>13</strong> <strong>PFBG</strong> 	PFBG (gui, item) contains the panel figure of the brain graph.
			%
			% See also Category, Format.
			
			me = me@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the graph ensemble measure.
			%
			% BUILD = MeasureEnsemble.GETBUILD() returns the build of 'MeasureEnsemble'.
			%
			% Alternative forms to call this method are:
			%  BUILD = ME.GETBUILD() returns the build of the graph ensemble measure ME.
			%  BUILD = Element.GETBUILD(ME) returns the build of 'ME'.
			%  BUILD = Element.GETBUILD('MeasureEnsemble') returns the build of 'MeasureEnsemble'.
			%
			% Note that the Element.GETBUILD(ME) and Element.GETBUILD('MeasureEnsemble')
			%  are less computationally efficient.
			
			build = 1;
		end
		function me_class = getClass()
			%GETCLASS returns the class of the graph ensemble measure.
			%
			% CLASS = MeasureEnsemble.GETCLASS() returns the class 'MeasureEnsemble'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ME.GETCLASS() returns the class of the graph ensemble measure ME.
			%  CLASS = Element.GETCLASS(ME) returns the class of 'ME'.
			%  CLASS = Element.GETCLASS('MeasureEnsemble') returns 'MeasureEnsemble'.
			%
			% Note that the Element.GETCLASS(ME) and Element.GETCLASS('MeasureEnsemble')
			%  are less computationally efficient.
			
			me_class = 'MeasureEnsemble';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph ensemble measure.
			%
			% LIST = MeasureEnsemble.GETSUBCLASSES() returns all subclasses of 'MeasureEnsemble'.
			%
			% Alternative forms to call this method are:
			%  LIST = ME.GETSUBCLASSES() returns all subclasses of the graph ensemble measure ME.
			%  LIST = Element.GETSUBCLASSES(ME) returns all subclasses of 'ME'.
			%  LIST = Element.GETSUBCLASSES('MeasureEnsemble') returns all subclasses of 'MeasureEnsemble'.
			%
			% Note that the Element.GETSUBCLASSES(ME) and Element.GETSUBCLASSES('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'MeasureEnsemble' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph ensemble measure.
			%
			% PROPS = MeasureEnsemble.GETPROPS() returns the property list of graph ensemble measure
			%  as a row vector.
			%
			% PROPS = MeasureEnsemble.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ME.GETPROPS([CATEGORY]) returns the property list of the graph ensemble measure ME.
			%  PROPS = Element.GETPROPS(ME[, CATEGORY]) returns the property list of 'ME'.
			%  PROPS = Element.GETPROPS('MeasureEnsemble'[, CATEGORY]) returns the property list of 'MeasureEnsemble'.
			%
			% Note that the Element.GETPROPS(ME) and Element.GETPROPS('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 9 10];
				case 5 % Category.RESULT
					prop_list = 11;
				case 6 % Category.QUERY
					prop_list = 8;
				case 9 % Category.GUI
					prop_list = [12 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph ensemble measure.
			%
			% N = MeasureEnsemble.GETPROPNUMBER() returns the property number of graph ensemble measure.
			%
			% N = MeasureEnsemble.GETPROPNUMBER(CATEGORY) returns the property number of graph ensemble measure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ME.GETPROPNUMBER([CATEGORY]) returns the property number of the graph ensemble measure ME.
			%  N = Element.GETPROPNUMBER(ME) returns the property number of 'ME'.
			%  N = Element.GETPROPNUMBER('MeasureEnsemble') returns the property number of 'MeasureEnsemble'.
			%
			% Note that the Element.GETPROPNUMBER(ME) and Element.GETPROPNUMBER('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 13;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 3;
				case 5 % Category.RESULT
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph ensemble measure/error.
			%
			% CHECK = MeasureEnsemble.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ME.EXISTSPROP(PROP) checks whether PROP exists for ME.
			%  CHECK = Element.EXISTSPROP(ME, PROP) checks whether PROP exists for ME.
			%  CHECK = Element.EXISTSPROP(MeasureEnsemble, PROP) checks whether PROP exists for MeasureEnsemble.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ME.EXISTSPROP(PROP) throws error if PROP does NOT exist for ME.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%  Element.EXISTSPROP(ME, PROP) throws error if PROP does NOT exist for ME.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%  Element.EXISTSPROP(MeasureEnsemble, PROP) throws error if PROP does NOT exist for MeasureEnsemble.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ME) and Element.EXISTSPROP('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MeasureEnsemble:' 'WrongInput'], ...
					['BRAPH2' ':MeasureEnsemble:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasureEnsemble.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph ensemble measure/error.
			%
			% CHECK = MeasureEnsemble.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ME.EXISTSTAG(TAG) checks whether TAG exists for ME.
			%  CHECK = Element.EXISTSTAG(ME, TAG) checks whether TAG exists for ME.
			%  CHECK = Element.EXISTSTAG(MeasureEnsemble, TAG) checks whether TAG exists for MeasureEnsemble.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ME.EXISTSTAG(TAG) throws error if TAG does NOT exist for ME.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%  Element.EXISTSTAG(ME, TAG) throws error if TAG does NOT exist for ME.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%  Element.EXISTSTAG(MeasureEnsemble, TAG) throws error if TAG does NOT exist for MeasureEnsemble.
			%   Error id: [BRAPH2:MeasureEnsemble:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ME) and Element.EXISTSTAG('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'MEASURE'  'A'  'M'  'PFME'  'PFBG' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MeasureEnsemble:' 'WrongInput'], ...
					['BRAPH2' ':MeasureEnsemble:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for MeasureEnsemble.'] ...
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
			%  PROPERTY = ME.GETPROPPROP(POINTER) returns property number of POINTER of ME.
			%  PROPERTY = Element.GETPROPPROP(MeasureEnsemble, POINTER) returns property number of POINTER of MeasureEnsemble.
			%  PROPERTY = ME.GETPROPPROP(MeasureEnsemble, POINTER) returns property number of POINTER of MeasureEnsemble.
			%
			% Note that the Element.GETPROPPROP(ME) and Element.GETPROPPROP('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'MEASURE'  'A'  'M'  'PFME'  'PFBG' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = ME.GETPROPTAG(POINTER) returns tag of POINTER of ME.
			%  TAG = Element.GETPROPTAG(MeasureEnsemble, POINTER) returns tag of POINTER of MeasureEnsemble.
			%  TAG = ME.GETPROPTAG(MeasureEnsemble, POINTER) returns tag of POINTER of MeasureEnsemble.
			%
			% Note that the Element.GETPROPTAG(ME) and Element.GETPROPTAG('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				measureensemble_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'MEASURE'  'A'  'M'  'PFME'  'PFBG' };
				tag = measureensemble_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = ME.GETPROPCATEGORY(POINTER) returns category of POINTER of ME.
			%  CATEGORY = Element.GETPROPCATEGORY(MeasureEnsemble, POINTER) returns category of POINTER of MeasureEnsemble.
			%  CATEGORY = ME.GETPROPCATEGORY(MeasureEnsemble, POINTER) returns category of POINTER of MeasureEnsemble.
			%
			% Note that the Element.GETPROPCATEGORY(ME) and Element.GETPROPCATEGORY('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measureensemble_category_list = { 1  1  1  3  4  2  2  6  4  4  5  9  9 };
			prop_category = measureensemble_category_list{prop};
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
			%  FORMAT = ME.GETPROPFORMAT(POINTER) returns format of POINTER of ME.
			%  FORMAT = Element.GETPROPFORMAT(MeasureEnsemble, POINTER) returns format of POINTER of MeasureEnsemble.
			%  FORMAT = ME.GETPROPFORMAT(MeasureEnsemble, POINTER) returns format of POINTER of MeasureEnsemble.
			%
			% Note that the Element.GETPROPFORMAT(ME) and Element.GETPROPFORMAT('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measureensemble_format_list = { 2  2  2  8  2  2  2  2  6  8  16  8  8 };
			prop_format = measureensemble_format_list{prop};
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
			%  DESCRIPTION = ME.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ME.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasureEnsemble, POINTER) returns description of POINTER of MeasureEnsemble.
			%  DESCRIPTION = ME.GETPROPDESCRIPTION(MeasureEnsemble, POINTER) returns description of POINTER of MeasureEnsemble.
			%
			% Note that the Element.GETPROPDESCRIPTION(ME) and Element.GETPROPDESCRIPTION('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measureensemble_description_list = { 'ELCLASS (constant, string) is the class of the % % % .'  'NAME (constant, string) is the name of the graph ensemble measure.'  'DESCRIPTION (constant, string) is the description of the graph ensemble measure.'  'TEMPLATE (parameter, item) is the template of the graph ensemble measure.'  'ID (data, string) is a few-letter code for the graph ensemble measure.'  'LABEL (metadata, string) is an extended label of the graph ensemble measure.'  'NOTES (metadata, string) are some specific notes about the graph ensemble measure.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'MEASURE (data, class) is the measure class.'  'A (data, item) is the ensemble-based graph analysis.'  'M (result, cell) is the measure group-average result.'  'PFME (gui, item) contains the panel figure of the measure.'  'PFBG (gui, item) contains the panel figure of the brain graph.' };
			prop_description = measureensemble_description_list{prop};
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
			%  SETTINGS = ME.GETPROPSETTINGS(POINTER) returns settings of POINTER of ME.
			%  SETTINGS = Element.GETPROPSETTINGS(MeasureEnsemble, POINTER) returns settings of POINTER of MeasureEnsemble.
			%  SETTINGS = ME.GETPROPSETTINGS(MeasureEnsemble, POINTER) returns settings of POINTER of MeasureEnsemble.
			%
			% Note that the Element.GETPROPSETTINGS(ME) and Element.GETPROPSETTINGS('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % MeasureEnsemble.MEASURE
					prop_settings = 'Measure';
				case 10 % MeasureEnsemble.A
					prop_settings = 'AnalyzeEnsemble';
				case 11 % MeasureEnsemble.M
					prop_settings = Format.getFormatSettings(16);
				case 12 % MeasureEnsemble.PFME
					prop_settings = Format.getFormatSettings(8);
				case 13 % MeasureEnsemble.PFBG
					prop_settings = Format.getFormatSettings(8);
				case 4 % MeasureEnsemble.TEMPLATE
					prop_settings = 'MeasureEnsemble';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasureEnsemble.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsemble.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ME.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ME.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasureEnsemble, POINTER) returns the default value of POINTER of MeasureEnsemble.
			%  DEFAULT = ME.GETPROPDEFAULT(MeasureEnsemble, POINTER) returns the default value of POINTER of MeasureEnsemble.
			%
			% Note that the Element.GETPROPDEFAULT(ME) and Element.GETPROPDEFAULT('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % MeasureEnsemble.MEASURE
					prop_default = Format.getFormatDefault(6, MeasureEnsemble.getPropSettings(prop));
				case 10 % MeasureEnsemble.A
					prop_default = Format.getFormatDefault(8, MeasureEnsemble.getPropSettings(prop));
				case 11 % MeasureEnsemble.M
					prop_default = Format.getFormatDefault(16, MeasureEnsemble.getPropSettings(prop));
				case 12 % MeasureEnsemble.PFME
					prop_default = Format.getFormatDefault(8, MeasureEnsemble.getPropSettings(prop));
				case 13 % MeasureEnsemble.PFBG
					prop_default = Format.getFormatDefault(8, MeasureEnsemble.getPropSettings(prop));
				case 1 % MeasureEnsemble.ELCLASS
					prop_default = 'MeasureEnsemble';
				case 2 % MeasureEnsemble.NAME
					prop_default = 'MeasureEnsemble';
				case 3 % MeasureEnsemble.DESCRIPTION
					prop_default = 'MeasureEnsemble provides the methods necessary for a graph ensemble measure.';
				case 4 % MeasureEnsemble.TEMPLATE
					prop_default = Format.getFormatDefault(8, MeasureEnsemble.getPropSettings(prop));
				case 5 % MeasureEnsemble.ID
					prop_default = 'MeasureEnsemble ID';
				case 6 % MeasureEnsemble.LABEL
					prop_default = 'MeasureEnsemble label';
				case 7 % MeasureEnsemble.NOTES
					prop_default = 'MeasureEnsemble notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasureEnsemble.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsemble.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ME.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ME.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasureEnsemble, POINTER) returns the conditioned default value of POINTER of MeasureEnsemble.
			%  DEFAULT = ME.GETPROPDEFAULTCONDITIONED(MeasureEnsemble, POINTER) returns the conditioned default value of POINTER of MeasureEnsemble.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ME) and Element.GETPROPDEFAULTCONDITIONED('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			prop_default = MeasureEnsemble.conditioning(prop, MeasureEnsemble.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = ME.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = ME.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of ME.
			%  CHECK = Element.CHECKPROP(MeasureEnsemble, PROP, VALUE) checks VALUE format for PROP of MeasureEnsemble.
			%  CHECK = ME.CHECKPROP(MeasureEnsemble, PROP, VALUE) checks VALUE format for PROP of MeasureEnsemble.
			% 
			% ME.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:MeasureEnsemble:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ME.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ME.
			%   Error id: BRAPH2:MeasureEnsemble:WrongInput
			%  Element.CHECKPROP(MeasureEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsemble.
			%   Error id: BRAPH2:MeasureEnsemble:WrongInput
			%  ME.CHECKPROP(MeasureEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsemble.
			%   Error id: BRAPH2:MeasureEnsemble:WrongInput]
			% 
			% Note that the Element.CHECKPROP(ME) and Element.CHECKPROP('MeasureEnsemble')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasureEnsemble.getPropProp(pointer);
			
			switch prop
				case 9 % MeasureEnsemble.MEASURE
					check = Format.checkFormat(6, value, MeasureEnsemble.getPropSettings(prop));
				case 10 % MeasureEnsemble.A
					check = Format.checkFormat(8, value, MeasureEnsemble.getPropSettings(prop));
				case 11 % MeasureEnsemble.M
					check = Format.checkFormat(16, value, MeasureEnsemble.getPropSettings(prop));
				case 12 % MeasureEnsemble.PFME
					check = Format.checkFormat(8, value, MeasureEnsemble.getPropSettings(prop));
				case 13 % MeasureEnsemble.PFBG
					check = Format.checkFormat(8, value, MeasureEnsemble.getPropSettings(prop));
				case 4 % MeasureEnsemble.TEMPLATE
					check = Format.checkFormat(8, value, MeasureEnsemble.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MeasureEnsemble:' 'WrongInput'], ...
					['BRAPH2' ':MeasureEnsemble:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasureEnsemble.getPropTag(prop) ' (' MeasureEnsemble.getFormatTag(MeasureEnsemble.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(me, prop)
			%POSTPROCESSING postprocessesing after setting.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% The postprocessing of all properties occurs each time set is called.
			%
			% See also conditioning, preset, checkProp, postset, calculateValue,
			%  checkValue.
			
			switch prop
				case 12 % MeasureEnsemble.PFME
					if isa(me.getr('PFME'), 'NoValue')
					
					    measure = me.get('MEASURE');
					
					    switch Element.getPropDefault(measure, 'SHAPE')
					        case 1 % Measure.GLOBAL
					            switch Element.getPropDefault(measure, 'SCOPE')
					                case 1 % Measure.SUPERGLOBAL
					                    me.set('PFME', MeasureEnsemblePF_GS('ME', me))
					                case 2 % Measure.UNILAYER
					                    me.set('PFME', MeasureEnsemblePF_GU('ME', me))
					                case 3 % Measure.BILAYER
					                    me.set('PFME', MeasureEnsemblePF_GB('ME', me))
					            end
					        case 2 % Measure.NODAL
					            switch Element.getPropDefault(measure, 'SCOPE')
					                case 1 % Measure.SUPERGLOBAL
					                    me.set('PFME', MeasureEnsemblePF_NS('ME', me))
					                case 2 % Measure.UNILAYER
					                    me.set('PFME', MeasureEnsemblePF_NU('ME', me))
					                case 3 % Measure.BILAYER
					                    me.set('PFME', MeasureEnsemblePF_NB('ME', me))
					            end
					        case 3 % Measure.BINODAL
					            switch Element.getPropDefault(measure, 'SCOPE')
					                case 1 % Measure.SUPERGLOBAL
					                    me.set('PFME', MeasureEnsemblePF_BS('ME', me))
					                case 2 % Measure.UNILAYER
					                    me.set('PFME', MeasureEnsemblePF_BU('ME', me))
					                case 3 % Measure.BILAYER
					                    me.set('PFME', MeasureEnsemblePF_BB('ME', me))
					            end
					    end
					end
					
				otherwise
					if prop <= 8
						postprocessing@ConcreteElement(me, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(me, prop, varargin)
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
				case 11 % MeasureEnsemble.M
					rng_settings_ = rng(); rng(me.getPropSeed(11), 'twister')
					
					m_list = cellfun(@(x) x.get('MEASURE', me.get('MEASURE')).get('M'), me.get('A').get('G_DICT').get('IT_LIST'), 'UniformOutput', false);
					
					if isempty(m_list)
					    m_av = {};
					else
					    m_av = cell(size(m_list{1}));
					    for i = 1:1:size(m_list{1}, 1)
					        for j = 1:1:size(m_list{1}, 2)
					            m_ij_list = cellfun(@(x) x{i, j}, m_list, 'UniformOutput', false);
					            m_av{i, j} = mean(cat(ndims(m_ij_list{1}) + 1, m_ij_list{:}), ndims(m_ij_list{1}) + 1);
					        end
					    end
					end
					
					value = m_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(me, prop, varargin{:});
					else
						value = calculateValue@Element(me, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(me, prop, varargin)
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
				case 11 % MeasureEnsemble.M
					if me.get('A').get('G_DICT').get('LENGTH')
					    g = me.get('A').get('G_DICT').get('IT', 1);
					else
					    g = me.get('A').get('GRAPH_TEMPLATE');
					end
					g.memorize('A');
					
					measure = me.get('MEASURE');
					
					pr = PanelPropCell('EL', me, 'PROP', 11, varargin{:});
					
					if Element.getPropDefault(measure, 'SHAPE') == 1 % Measure.GLOBAL
					    pr.set( ...
					        'TABLE_HEIGHT', 48, ...
					        'ROWNAME', {}, ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == 2 % Measure.NODAL
					    pr.set( ...
					        'TABLE_HEIGHT', 480, ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == 3 % Measure.BINODAL
					    pr.set( ...
					        'TABLE_HEIGHT', 480, ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', g.getCallback('ANODELABELS') ...
					        )
					end
					
					if g.get('LAYERNUMBER') == 1
					    pr.set( ...
					        'XSLIDERSHOW', false, ...
					        'YSLIDERSHOW', false ...
					        )
					else % multigraph, multiplex, multilayer
					    if  Element.getPropDefault(measure, 'SCOPE') == 1 % Measure.SUPERGLOBAL
					        if isempty(g.get('APARTITIONLABELS'))
					            pr.set( ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', false ...
					                )
					        else
					            pr.set( ...
					                'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), 12 * length(g.get('APARTITIONLABELS'))), ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', true, ...
					                'YSLIDERLABELS', g.getCallback('APARTITIONLABELS'), ...
					                'YSLIDERWIDTH', 60 ...
					                )
					        end
					    elseif Element.getPropDefault(measure, 'SCOPE') == 2 % Measure.UNILAYER
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), 12 * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', 60 ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == 3 % Measure.BILAYER
					        pr.set( ...
					            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), 36 + 12 * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', true, ...
					            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'XSLIDERHEIGHT', 36, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', 60 ...
					            )
					    end
					end
					
				case 12 % MeasureEnsemble.PFME
					pr = PanelPropItem('EL', me, 'PROP', 12, ...
					    'GUICLASS', 'GUIFig', ...
						'BUTTON_TEXT', ['Plot ' me.get('MEASURE') ' Ensemble'], ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(me, prop, varargin{:});
					
			end
		end
	end
end
