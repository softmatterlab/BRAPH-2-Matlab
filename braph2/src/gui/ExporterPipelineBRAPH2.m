classdef ExporterPipelineBRAPH2 < Exporter
	%ExporterPipelineBRAPH2 exports a pipeline in a BRAPH2 file.
	% It is a subclass of <a href="matlab:help Exporter">Exporter</a>.
	%
	% A Pipeline Exporter in BRAPH2 File (ExporterPipelineBRAPH2) exports a pipeline to a BRAPH2 file.
	%
	% The list of ExporterPipelineBRAPH2 properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the exporter of a pipeline to a BRAPH2 file.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the exporter of a pipeline to a BRAPH2 file.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the exporter of a pipeline to a BRAPH2 file.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the exporter of a pipeline to a BRAPH2 file.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the exporter of a pipeline v a BRAPH2 file.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the exporter of a pipeline to a BRAPH2 file.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the exporter of a pipeline to a BRAPH2 file.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>PIP</strong> 	PIP (data, item) is a pipeline.
	%  <strong>11</strong> <strong>FILE</strong> 	FILE (data, string) is the BRAPH2 file where to save the pipeline.
	%  <strong>12</strong> <strong>PUT_FILE</strong> 	PUT_FILE (query, empty) opens a dialog box to set the BRAPH2 file where to save the brain atlas.
	%  <strong>13</strong> <strong>SAVE</strong> 	SAVE (result, empty) saves the pipeline in the selected BRAPH2 file.
	%
	% ExporterPipelineBRAPH2 methods (constructor):
	%  ExporterPipelineBRAPH2 - constructor
	%
	% ExporterPipelineBRAPH2 methods:
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
	% ExporterPipelineBRAPH2 methods (display):
	%  tostring - string with information about the pipeline exporter in BRAPH2
	%  disp - displays information about the pipeline exporter in BRAPH2
	%  tree - displays the tree of the pipeline exporter in BRAPH2
	%
	% ExporterPipelineBRAPH2 methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two pipeline exporter in BRAPH2 are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the pipeline exporter in BRAPH2
	%
	% ExporterPipelineBRAPH2 methods (save/load, Static):
	%  save - saves BRAPH2 pipeline exporter in BRAPH2 as b2 file
	%  load - loads a BRAPH2 pipeline exporter in BRAPH2 from a b2 file
	%
	% ExporterPipelineBRAPH2 method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the pipeline exporter in BRAPH2
	%
	% ExporterPipelineBRAPH2 method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the pipeline exporter in BRAPH2
	%
	% ExporterPipelineBRAPH2 methods (inspection, Static):
	%  getClass - returns the class of the pipeline exporter in BRAPH2
	%  getSubclasses - returns all subclasses of ExporterPipelineBRAPH2
	%  getProps - returns the property list of the pipeline exporter in BRAPH2
	%  getPropNumber - returns the property number of the pipeline exporter in BRAPH2
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
	% ExporterPipelineBRAPH2 methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ExporterPipelineBRAPH2 methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ExporterPipelineBRAPH2 methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ExporterPipelineBRAPH2 methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ExporterPipelineBRAPH2; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ExporterPipelineBRAPH2 constants</a>.
	%
	%
	% See also Exporter, Pipeline, ImporterPipelineBRAPH2.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		PIP = 10; %CET: Computational Efficiency Trick
		PIP_TAG = 'PIP';
		PIP_CATEGORY = 4;
		PIP_FORMAT = 8;
		
		FILE = 11; %CET: Computational Efficiency Trick
		FILE_TAG = 'FILE';
		FILE_CATEGORY = 4;
		FILE_FORMAT = 2;
		
		PUT_FILE = 12; %CET: Computational Efficiency Trick
		PUT_FILE_TAG = 'PUT_FILE';
		PUT_FILE_CATEGORY = 6;
		PUT_FILE_FORMAT = 1;
		
		SAVE = 13; %CET: Computational Efficiency Trick
		SAVE_TAG = 'SAVE';
		SAVE_CATEGORY = 5;
		SAVE_FORMAT = 1;
	end
	methods % constructor
		function ex = ExporterPipelineBRAPH2(varargin)
			%ExporterPipelineBRAPH2() creates a pipeline exporter in BRAPH2.
			%
			% ExporterPipelineBRAPH2(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ExporterPipelineBRAPH2(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ExporterPipelineBRAPH2 properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the exporter of a pipeline to a BRAPH2 file.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the exporter of a pipeline to a BRAPH2 file.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the exporter of a pipeline to a BRAPH2 file.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the exporter of a pipeline to a BRAPH2 file.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the exporter of a pipeline v a BRAPH2 file.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the exporter of a pipeline to a BRAPH2 file.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the exporter of a pipeline to a BRAPH2 file.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>PIP</strong> 	PIP (data, item) is a pipeline.
			%  <strong>11</strong> <strong>FILE</strong> 	FILE (data, string) is the BRAPH2 file where to save the pipeline.
			%  <strong>12</strong> <strong>PUT_FILE</strong> 	PUT_FILE (query, empty) opens a dialog box to set the BRAPH2 file where to save the brain atlas.
			%  <strong>13</strong> <strong>SAVE</strong> 	SAVE (result, empty) saves the pipeline in the selected BRAPH2 file.
			%
			% See also Category, Format.
			
			ex = ex@Exporter(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the pipeline exporter in BRAPH2.
			%
			% BUILD = ExporterPipelineBRAPH2.GETBUILD() returns the build of 'ExporterPipelineBRAPH2'.
			%
			% Alternative forms to call this method are:
			%  BUILD = EX.GETBUILD() returns the build of the pipeline exporter in BRAPH2 EX.
			%  BUILD = Element.GETBUILD(EX) returns the build of 'EX'.
			%  BUILD = Element.GETBUILD('ExporterPipelineBRAPH2') returns the build of 'ExporterPipelineBRAPH2'.
			%
			% Note that the Element.GETBUILD(EX) and Element.GETBUILD('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			
			build = 1;
		end
		function ex_class = getClass()
			%GETCLASS returns the class of the pipeline exporter in BRAPH2.
			%
			% CLASS = ExporterPipelineBRAPH2.GETCLASS() returns the class 'ExporterPipelineBRAPH2'.
			%
			% Alternative forms to call this method are:
			%  CLASS = EX.GETCLASS() returns the class of the pipeline exporter in BRAPH2 EX.
			%  CLASS = Element.GETCLASS(EX) returns the class of 'EX'.
			%  CLASS = Element.GETCLASS('ExporterPipelineBRAPH2') returns 'ExporterPipelineBRAPH2'.
			%
			% Note that the Element.GETCLASS(EX) and Element.GETCLASS('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			
			ex_class = 'ExporterPipelineBRAPH2';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the pipeline exporter in BRAPH2.
			%
			% LIST = ExporterPipelineBRAPH2.GETSUBCLASSES() returns all subclasses of 'ExporterPipelineBRAPH2'.
			%
			% Alternative forms to call this method are:
			%  LIST = EX.GETSUBCLASSES() returns all subclasses of the pipeline exporter in BRAPH2 EX.
			%  LIST = Element.GETSUBCLASSES(EX) returns all subclasses of 'EX'.
			%  LIST = Element.GETSUBCLASSES('ExporterPipelineBRAPH2') returns all subclasses of 'ExporterPipelineBRAPH2'.
			%
			% Note that the Element.GETSUBCLASSES(EX) and Element.GETSUBCLASSES('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ExporterPipelineBRAPH2' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of pipeline exporter in BRAPH2.
			%
			% PROPS = ExporterPipelineBRAPH2.GETPROPS() returns the property list of pipeline exporter in BRAPH2
			%  as a row vector.
			%
			% PROPS = ExporterPipelineBRAPH2.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = EX.GETPROPS([CATEGORY]) returns the property list of the pipeline exporter in BRAPH2 EX.
			%  PROPS = Element.GETPROPS(EX[, CATEGORY]) returns the property list of 'EX'.
			%  PROPS = Element.GETPROPS('ExporterPipelineBRAPH2'[, CATEGORY]) returns the property list of 'ExporterPipelineBRAPH2'.
			%
			% Note that the Element.GETPROPS(EX) and Element.GETPROPS('ExporterPipelineBRAPH2')
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
					prop_list = [5 10 11];
				case 5 % Category.RESULT
					prop_list = 13;
				case 6 % Category.QUERY
					prop_list = [8 12];
				case 9 % Category.GUI
					prop_list = 9;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of pipeline exporter in BRAPH2.
			%
			% N = ExporterPipelineBRAPH2.GETPROPNUMBER() returns the property number of pipeline exporter in BRAPH2.
			%
			% N = ExporterPipelineBRAPH2.GETPROPNUMBER(CATEGORY) returns the property number of pipeline exporter in BRAPH2
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = EX.GETPROPNUMBER([CATEGORY]) returns the property number of the pipeline exporter in BRAPH2 EX.
			%  N = Element.GETPROPNUMBER(EX) returns the property number of 'EX'.
			%  N = Element.GETPROPNUMBER('ExporterPipelineBRAPH2') returns the property number of 'ExporterPipelineBRAPH2'.
			%
			% Note that the Element.GETPROPNUMBER(EX) and Element.GETPROPNUMBER('ExporterPipelineBRAPH2')
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
					prop_number = 2;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in pipeline exporter in BRAPH2/error.
			%
			% CHECK = ExporterPipelineBRAPH2.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSPROP(PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(EX, PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(ExporterPipelineBRAPH2, PROP) checks whether PROP exists for ExporterPipelineBRAPH2.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSPROP(PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%  Element.EXISTSPROP(EX, PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%  Element.EXISTSPROP(ExporterPipelineBRAPH2, PROP) throws error if PROP does NOT exist for ExporterPipelineBRAPH2.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%
			% Note that the Element.EXISTSPROP(EX) and Element.EXISTSPROP('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ExporterPipelineBRAPH2:' 'WrongInput'], ...
					['BRAPH2' ':ExporterPipelineBRAPH2:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ExporterPipelineBRAPH2.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in pipeline exporter in BRAPH2/error.
			%
			% CHECK = ExporterPipelineBRAPH2.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSTAG(TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(EX, TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(ExporterPipelineBRAPH2, TAG) checks whether TAG exists for ExporterPipelineBRAPH2.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSTAG(TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%  Element.EXISTSTAG(EX, TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%  Element.EXISTSTAG(ExporterPipelineBRAPH2, TAG) throws error if TAG does NOT exist for ExporterPipelineBRAPH2.
			%   Error id: [BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			%
			% Note that the Element.EXISTSTAG(EX) and Element.EXISTSTAG('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'PIP'  'FILE'  'PUT_FILE'  'SAVE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ExporterPipelineBRAPH2:' 'WrongInput'], ...
					['BRAPH2' ':ExporterPipelineBRAPH2:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ExporterPipelineBRAPH2.'] ...
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
			%  PROPERTY = EX.GETPROPPROP(POINTER) returns property number of POINTER of EX.
			%  PROPERTY = Element.GETPROPPROP(ExporterPipelineBRAPH2, POINTER) returns property number of POINTER of ExporterPipelineBRAPH2.
			%  PROPERTY = EX.GETPROPPROP(ExporterPipelineBRAPH2, POINTER) returns property number of POINTER of ExporterPipelineBRAPH2.
			%
			% Note that the Element.GETPROPPROP(EX) and Element.GETPROPPROP('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'PIP'  'FILE'  'PUT_FILE'  'SAVE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = EX.GETPROPTAG(POINTER) returns tag of POINTER of EX.
			%  TAG = Element.GETPROPTAG(ExporterPipelineBRAPH2, POINTER) returns tag of POINTER of ExporterPipelineBRAPH2.
			%  TAG = EX.GETPROPTAG(ExporterPipelineBRAPH2, POINTER) returns tag of POINTER of ExporterPipelineBRAPH2.
			%
			% Note that the Element.GETPROPTAG(EX) and Element.GETPROPTAG('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				exporterpipelinebraph2_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'PIP'  'FILE'  'PUT_FILE'  'SAVE' };
				tag = exporterpipelinebraph2_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = EX.GETPROPCATEGORY(POINTER) returns category of POINTER of EX.
			%  CATEGORY = Element.GETPROPCATEGORY(ExporterPipelineBRAPH2, POINTER) returns category of POINTER of ExporterPipelineBRAPH2.
			%  CATEGORY = EX.GETPROPCATEGORY(ExporterPipelineBRAPH2, POINTER) returns category of POINTER of ExporterPipelineBRAPH2.
			%
			% Note that the Element.GETPROPCATEGORY(EX) and Element.GETPROPCATEGORY('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			exporterpipelinebraph2_category_list = { 1  1  1  3  4  2  2  6  9  4  4  6  5 };
			prop_category = exporterpipelinebraph2_category_list{prop};
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
			%  FORMAT = EX.GETPROPFORMAT(POINTER) returns format of POINTER of EX.
			%  FORMAT = Element.GETPROPFORMAT(ExporterPipelineBRAPH2, POINTER) returns format of POINTER of ExporterPipelineBRAPH2.
			%  FORMAT = EX.GETPROPFORMAT(ExporterPipelineBRAPH2, POINTER) returns format of POINTER of ExporterPipelineBRAPH2.
			%
			% Note that the Element.GETPROPFORMAT(EX) and Element.GETPROPFORMAT('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			exporterpipelinebraph2_format_list = { 2  2  2  8  2  2  2  2  4  8  2  1  1 };
			prop_format = exporterpipelinebraph2_format_list{prop};
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
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(POINTER) returns description of POINTER of EX.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ExporterPipelineBRAPH2, POINTER) returns description of POINTER of ExporterPipelineBRAPH2.
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(ExporterPipelineBRAPH2, POINTER) returns description of POINTER of ExporterPipelineBRAPH2.
			%
			% Note that the Element.GETPROPDESCRIPTION(EX) and Element.GETPROPDESCRIPTION('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			exporterpipelinebraph2_description_list = { 'ELCLASS (constant, string) is the class of the exporter of a pipeline to a BRAPH2 file.'  'NAME (constant, string) is the name of the exporter of a pipeline to a BRAPH2 file.'  'DESCRIPTION (constant, string) is the description of the exporter of a pipeline to a BRAPH2 file.'  'TEMPLATE (parameter, item) is the template of the exporter of a pipeline to a BRAPH2 file.'  'ID (data, string) is a few-letter code for the exporter of a pipeline v a BRAPH2 file.'  'LABEL (metadata, string) is an extended label of the exporter of a pipeline to a BRAPH2 file.'  'NOTES (metadata, string) are some specific notes about the exporter of a pipeline to a BRAPH2 file.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'PIP (data, item) is a pipeline.'  'FILE (data, string) is the BRAPH2 file where to save the pipeline.'  'PUT_FILE (query, empty) opens a dialog box to set the BRAPH2 file where to save the brain atlas.'  'SAVE (result, empty) saves the pipeline in the selected BRAPH2 file.' };
			prop_description = exporterpipelinebraph2_description_list{prop};
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
			%  SETTINGS = EX.GETPROPSETTINGS(POINTER) returns settings of POINTER of EX.
			%  SETTINGS = Element.GETPROPSETTINGS(ExporterPipelineBRAPH2, POINTER) returns settings of POINTER of ExporterPipelineBRAPH2.
			%  SETTINGS = EX.GETPROPSETTINGS(ExporterPipelineBRAPH2, POINTER) returns settings of POINTER of ExporterPipelineBRAPH2.
			%
			% Note that the Element.GETPROPSETTINGS(EX) and Element.GETPROPSETTINGS('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ExporterPipelineBRAPH2.PIP
					prop_settings = 'Pipeline';
				case 11 % ExporterPipelineBRAPH2.FILE
					prop_settings = Format.getFormatSettings(2);
				case 12 % ExporterPipelineBRAPH2.PUT_FILE
					prop_settings = 'ExporterPipelineBRAPH2';
				case 13 % ExporterPipelineBRAPH2.SAVE
					prop_settings = Format.getFormatSettings(1);
				case 4 % ExporterPipelineBRAPH2.TEMPLATE
					prop_settings = 'ExporterPipelineBRAPH2';
				otherwise
					prop_settings = getPropSettings@Exporter(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ExporterPipelineBRAPH2.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterPipelineBRAPH2.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULT(ExporterPipelineBRAPH2, POINTER) returns the default value of POINTER of ExporterPipelineBRAPH2.
			%  DEFAULT = EX.GETPROPDEFAULT(ExporterPipelineBRAPH2, POINTER) returns the default value of POINTER of ExporterPipelineBRAPH2.
			%
			% Note that the Element.GETPROPDEFAULT(EX) and Element.GETPROPDEFAULT('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ExporterPipelineBRAPH2.PIP
					prop_default = Format.getFormatDefault(8, ExporterPipelineBRAPH2.getPropSettings(prop));
				case 11 % ExporterPipelineBRAPH2.FILE
					prop_default = [fileparts(which('test_braph2')) filesep 'default_braph2_file_to_save_pipeline_most_likely_to_be_erased.braph2'];
				case 12 % ExporterPipelineBRAPH2.PUT_FILE
					prop_default = Format.getFormatDefault(1, ExporterPipelineBRAPH2.getPropSettings(prop));
				case 13 % ExporterPipelineBRAPH2.SAVE
					prop_default = Format.getFormatDefault(1, ExporterPipelineBRAPH2.getPropSettings(prop));
				case 1 % ExporterPipelineBRAPH2.ELCLASS
					prop_default = 'ExporterPipelineBRAPH2';
				case 2 % ExporterPipelineBRAPH2.NAME
					prop_default = 'Pipeline Exporter in BRAPH2 File';
				case 3 % ExporterPipelineBRAPH2.DESCRIPTION
					prop_default = 'A Pipeline Exporter in BRAPH2 File (ExporterPipelineBRAPH2) exports a pipeline to a BRAPH2 file.';
				case 4 % ExporterPipelineBRAPH2.TEMPLATE
					prop_default = Format.getFormatDefault(8, ExporterPipelineBRAPH2.getPropSettings(prop));
				case 5 % ExporterPipelineBRAPH2.ID
					prop_default = 'ExporterPipelineBRAPH2 ID';
				case 6 % ExporterPipelineBRAPH2.LABEL
					prop_default = 'ExporterPipelineBRAPH2 label';
				case 7 % ExporterPipelineBRAPH2.NOTES
					prop_default = 'ExporterPipelineBRAPH2 notes';
				otherwise
					prop_default = getPropDefault@Exporter(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ExporterPipelineBRAPH2.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterPipelineBRAPH2.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ExporterPipelineBRAPH2, POINTER) returns the conditioned default value of POINTER of ExporterPipelineBRAPH2.
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(ExporterPipelineBRAPH2, POINTER) returns the conditioned default value of POINTER of ExporterPipelineBRAPH2.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(EX) and Element.GETPROPDEFAULTCONDITIONED('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			prop_default = ExporterPipelineBRAPH2.conditioning(prop, ExporterPipelineBRAPH2.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = EX.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = EX.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of EX.
			%  CHECK = Element.CHECKPROP(ExporterPipelineBRAPH2, PROP, VALUE) checks VALUE format for PROP of ExporterPipelineBRAPH2.
			%  CHECK = EX.CHECKPROP(ExporterPipelineBRAPH2, PROP, VALUE) checks VALUE format for PROP of ExporterPipelineBRAPH2.
			% 
			% EX.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ExporterPipelineBRAPH2:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  EX.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EX.
			%   Error id: BRAPH2:ExporterPipelineBRAPH2:WrongInput
			%  Element.CHECKPROP(ExporterPipelineBRAPH2, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterPipelineBRAPH2.
			%   Error id: BRAPH2:ExporterPipelineBRAPH2:WrongInput
			%  EX.CHECKPROP(ExporterPipelineBRAPH2, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterPipelineBRAPH2.
			%   Error id: BRAPH2:ExporterPipelineBRAPH2:WrongInput]
			% 
			% Note that the Element.CHECKPROP(EX) and Element.CHECKPROP('ExporterPipelineBRAPH2')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ExporterPipelineBRAPH2.getPropProp(pointer);
			
			switch prop
				case 10 % ExporterPipelineBRAPH2.PIP
					check = Format.checkFormat(8, value, ExporterPipelineBRAPH2.getPropSettings(prop));
				case 11 % ExporterPipelineBRAPH2.FILE
					check = Format.checkFormat(2, value, ExporterPipelineBRAPH2.getPropSettings(prop));
				case 12 % ExporterPipelineBRAPH2.PUT_FILE
					check = Format.checkFormat(1, value, ExporterPipelineBRAPH2.getPropSettings(prop));
				case 13 % ExporterPipelineBRAPH2.SAVE
					check = Format.checkFormat(1, value, ExporterPipelineBRAPH2.getPropSettings(prop));
				case 4 % ExporterPipelineBRAPH2.TEMPLATE
					check = Format.checkFormat(8, value, ExporterPipelineBRAPH2.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@Exporter(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ExporterPipelineBRAPH2:' 'WrongInput'], ...
					['BRAPH2' ':ExporterPipelineBRAPH2:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ExporterPipelineBRAPH2.getPropTag(prop) ' (' ExporterPipelineBRAPH2.getFormatTag(ExporterPipelineBRAPH2.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(ex, prop, varargin)
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
				case 12 % ExporterPipelineBRAPH2.PUT_FILE
					[filename, filepath, filterindex] = uiputfile(BRAPH2.EXT_PIPELINE, 'Select BRAPH2 Pipeline file');
					if filterindex
					    file = [filepath filename];
					    ex.set('FILE', file);
					end
					value = ex;
					
				case 13 % ExporterPipelineBRAPH2.SAVE
					rng_settings_ = rng(); rng(ex.getPropSeed(13), 'twister')
					
					file = ex.get('FILE');
					
					if isfolder(fileparts(file))
						wb = braph2waitbar(ex.get('WAITBAR'), 0, 'Retrieving path ...');
					    
					    pip = ex.get('PIP');
					   
					    txt = [ ...
					        '%% ' pip.get('LABEL') newline()  ...
					        newline() ...
					        ];
					
					    notes = cellfun(@(x) ['% ' strtrim(x) newline()], str2cell(pip.get('NOTES')), 'UniformOutput', false);
					    for i = 1:1:length(notes)
					        txt = [txt notes{i}];
					    end
					
					    txt = [ txt ...
					        newline() ...
					        '% PDF: ' pip.get('PDF') newline() ...
					        '% README: ' pip.get('README') newline() ...
					        ];
					
					    ps_dict = pip.get('PS_DICT');
					    for s = 1:1:ps_dict.get('LENGTH')
					        ps = ps_dict.get('IT', s);
					        
					        txt = [ txt ...
					            newline() ...
					            '%% ' ps.get('LABEL') newline() ...
					            ];
					        
					        pc_dict = ps.get('PC_DICT');
					        for c = 1:1:pc_dict.get('LENGTH')
					            braph2waitbar(wb,  1.00 * (s - 1 + c / pc_dict.get('LENGTH')) / ps_dict.get('LENGTH'), ...
					                ['Saving pipeline section ' num2str(s) ' of ' num2str(ps_dict.get('LENGTH')) ...
					                ', code line ' num2str(c) ' of ' num2str(pc_dict.get('LENGTH')) ' ...'])
					                
					            pc = pc_dict.get('IT', c);
					            
					            txt = [ txt ...
					                pc.get('MONIKER') ' = ' pc.get('CODE') ' % ' pc.get('TEXT_BEFORE_EXEC') ' % ' pc.get('TEXT_AFTER_EXEC') newline() ...
					                ];
					        end
					    end
					    
					    txt = regexprep(txt, '%', '%%');
					    
					    object_file = fopen(ex.get('FILE'), 'w');
					    fprintf(object_file, txt);
					    fclose(object_file);
					    
					    braph2waitbar(wb, 'close')
					end
					
					% sets value to empty
					value = [];
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 9
						value = calculateValue@Exporter(ex, prop, varargin{:});
					else
						value = calculateValue@Element(ex, prop, varargin{:});
					end
			end
			
		end
	end
end
