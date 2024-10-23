classdef ExporterGroupSubjectCON_TXT < Exporter
	%ExporterGroupSubjectCON_TXT exports a group of subjects with connectivity data to a series of TXT file.
	% It is a subclass of <a href="matlab:help Exporter">Exporter</a>.
	%
	% ExporterGroupSubjectCON_TXT exports a group of subjects with connectivity 
	%  data to a series of tab-separated TXT files contained in a folder named 
	%  "GROUP_ID". All these files are saved in the same folder. Each file 
	%  contains a table of values corresponding to the adjacency matrix.
	% The variables of interest (if existing) are saved in another tab-separated 
	%  TXT file named "GROUP_ID.vois.txt" consisting of the following columns: 
	%  Subject ID (column 1), covariates (subsequent columns). 
	%  The 1st row contains the headers, the 2nd row a string with the categorical
	%  variables of interest, and each subsequent row the values for each subject.
	%
	% The list of ExporterGroupSubjectCON_TXT properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the CON subject group exporter in TXT.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the CON subject group exporter in TXT.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the CON subject group exporter in TXT.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the CON subject group exporter in TXT.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the CON subject group exporter in TXT.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the CON subject group exporter in TXT.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the CON subject group exporter in TXT.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>GR</strong> 	GR (data, item) is a group of subjects with connectivity data.
	%  <strong>11</strong> <strong>DIRECTORY</strong> 	DIRECTORY (data, string) is the directory name where to save the group of subjects with connectivity data.
	%  <strong>12</strong> <strong>PUT_DIR</strong> 	PUT_DIR (query, item) opens a dialog box to set the directory where to save the group of subjects with connectivity data.
	%  <strong>13</strong> <strong>SAVE</strong> 	SAVE (result, empty) saves the group of subjects with connectivity data in TXT files in the selected directory.
	%
	% ExporterGroupSubjectCON_TXT methods (constructor):
	%  ExporterGroupSubjectCON_TXT - constructor
	%
	% ExporterGroupSubjectCON_TXT methods:
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
	% ExporterGroupSubjectCON_TXT methods (display):
	%  tostring - string with information about the exporter of CON subject group in TXT
	%  disp - displays information about the exporter of CON subject group in TXT
	%  tree - displays the tree of the exporter of CON subject group in TXT
	%
	% ExporterGroupSubjectCON_TXT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two exporter of CON subject group in TXT are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the exporter of CON subject group in TXT
	%
	% ExporterGroupSubjectCON_TXT methods (save/load, Static):
	%  save - saves BRAPH2 exporter of CON subject group in TXT as b2 file
	%  load - loads a BRAPH2 exporter of CON subject group in TXT from a b2 file
	%
	% ExporterGroupSubjectCON_TXT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the exporter of CON subject group in TXT
	%
	% ExporterGroupSubjectCON_TXT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the exporter of CON subject group in TXT
	%
	% ExporterGroupSubjectCON_TXT methods (inspection, Static):
	%  getClass - returns the class of the exporter of CON subject group in TXT
	%  getSubclasses - returns all subclasses of ExporterGroupSubjectCON_TXT
	%  getProps - returns the property list of the exporter of CON subject group in TXT
	%  getPropNumber - returns the property number of the exporter of CON subject group in TXT
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
	% ExporterGroupSubjectCON_TXT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ExporterGroupSubjectCON_TXT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ExporterGroupSubjectCON_TXT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ExporterGroupSubjectCON_TXT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ExporterGroupSubjectCON_TXT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ExporterGroupSubjectCON_TXT constants</a>.
	%
	%
	% See also Group, SunbjectCON, ImporterGroupSubjectCON_TXT.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		GR = 10; %CET: Computational Efficiency Trick
		GR_TAG = 'GR';
		GR_CATEGORY = 4;
		GR_FORMAT = 8;
		
		DIRECTORY = 11; %CET: Computational Efficiency Trick
		DIRECTORY_TAG = 'DIRECTORY';
		DIRECTORY_CATEGORY = 4;
		DIRECTORY_FORMAT = 2;
		
		PUT_DIR = 12; %CET: Computational Efficiency Trick
		PUT_DIR_TAG = 'PUT_DIR';
		PUT_DIR_CATEGORY = 6;
		PUT_DIR_FORMAT = 8;
		
		SAVE = 13; %CET: Computational Efficiency Trick
		SAVE_TAG = 'SAVE';
		SAVE_CATEGORY = 5;
		SAVE_FORMAT = 1;
	end
	methods % constructor
		function ex = ExporterGroupSubjectCON_TXT(varargin)
			%ExporterGroupSubjectCON_TXT() creates a exporter of CON subject group in TXT.
			%
			% ExporterGroupSubjectCON_TXT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ExporterGroupSubjectCON_TXT(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ExporterGroupSubjectCON_TXT properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the CON subject group exporter in TXT.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the CON subject group exporter in TXT.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the CON subject group exporter in TXT.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the CON subject group exporter in TXT.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the CON subject group exporter in TXT.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the CON subject group exporter in TXT.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the CON subject group exporter in TXT.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>GR</strong> 	GR (data, item) is a group of subjects with connectivity data.
			%  <strong>11</strong> <strong>DIRECTORY</strong> 	DIRECTORY (data, string) is the directory name where to save the group of subjects with connectivity data.
			%  <strong>12</strong> <strong>PUT_DIR</strong> 	PUT_DIR (query, item) opens a dialog box to set the directory where to save the group of subjects with connectivity data.
			%  <strong>13</strong> <strong>SAVE</strong> 	SAVE (result, empty) saves the group of subjects with connectivity data in TXT files in the selected directory.
			%
			% See also Category, Format.
			
			ex = ex@Exporter(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the exporter of CON subject group in TXT.
			%
			% BUILD = ExporterGroupSubjectCON_TXT.GETBUILD() returns the build of 'ExporterGroupSubjectCON_TXT'.
			%
			% Alternative forms to call this method are:
			%  BUILD = EX.GETBUILD() returns the build of the exporter of CON subject group in TXT EX.
			%  BUILD = Element.GETBUILD(EX) returns the build of 'EX'.
			%  BUILD = Element.GETBUILD('ExporterGroupSubjectCON_TXT') returns the build of 'ExporterGroupSubjectCON_TXT'.
			%
			% Note that the Element.GETBUILD(EX) and Element.GETBUILD('ExporterGroupSubjectCON_TXT')
			%  are less computationally efficient.
			
			build = 1;
		end
		function ex_class = getClass()
			%GETCLASS returns the class of the exporter of CON subject group in TXT.
			%
			% CLASS = ExporterGroupSubjectCON_TXT.GETCLASS() returns the class 'ExporterGroupSubjectCON_TXT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = EX.GETCLASS() returns the class of the exporter of CON subject group in TXT EX.
			%  CLASS = Element.GETCLASS(EX) returns the class of 'EX'.
			%  CLASS = Element.GETCLASS('ExporterGroupSubjectCON_TXT') returns 'ExporterGroupSubjectCON_TXT'.
			%
			% Note that the Element.GETCLASS(EX) and Element.GETCLASS('ExporterGroupSubjectCON_TXT')
			%  are less computationally efficient.
			
			ex_class = 'ExporterGroupSubjectCON_TXT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the exporter of CON subject group in TXT.
			%
			% LIST = ExporterGroupSubjectCON_TXT.GETSUBCLASSES() returns all subclasses of 'ExporterGroupSubjectCON_TXT'.
			%
			% Alternative forms to call this method are:
			%  LIST = EX.GETSUBCLASSES() returns all subclasses of the exporter of CON subject group in TXT EX.
			%  LIST = Element.GETSUBCLASSES(EX) returns all subclasses of 'EX'.
			%  LIST = Element.GETSUBCLASSES('ExporterGroupSubjectCON_TXT') returns all subclasses of 'ExporterGroupSubjectCON_TXT'.
			%
			% Note that the Element.GETSUBCLASSES(EX) and Element.GETSUBCLASSES('ExporterGroupSubjectCON_TXT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ExporterGroupSubjectCON_TXT' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of exporter of CON subject group in TXT.
			%
			% PROPS = ExporterGroupSubjectCON_TXT.GETPROPS() returns the property list of exporter of CON subject group in TXT
			%  as a row vector.
			%
			% PROPS = ExporterGroupSubjectCON_TXT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = EX.GETPROPS([CATEGORY]) returns the property list of the exporter of CON subject group in TXT EX.
			%  PROPS = Element.GETPROPS(EX[, CATEGORY]) returns the property list of 'EX'.
			%  PROPS = Element.GETPROPS('ExporterGroupSubjectCON_TXT'[, CATEGORY]) returns the property list of 'ExporterGroupSubjectCON_TXT'.
			%
			% Note that the Element.GETPROPS(EX) and Element.GETPROPS('ExporterGroupSubjectCON_TXT')
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
			%GETPROPNUMBER returns the property number of exporter of CON subject group in TXT.
			%
			% N = ExporterGroupSubjectCON_TXT.GETPROPNUMBER() returns the property number of exporter of CON subject group in TXT.
			%
			% N = ExporterGroupSubjectCON_TXT.GETPROPNUMBER(CATEGORY) returns the property number of exporter of CON subject group in TXT
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = EX.GETPROPNUMBER([CATEGORY]) returns the property number of the exporter of CON subject group in TXT EX.
			%  N = Element.GETPROPNUMBER(EX) returns the property number of 'EX'.
			%  N = Element.GETPROPNUMBER('ExporterGroupSubjectCON_TXT') returns the property number of 'ExporterGroupSubjectCON_TXT'.
			%
			% Note that the Element.GETPROPNUMBER(EX) and Element.GETPROPNUMBER('ExporterGroupSubjectCON_TXT')
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
			%EXISTSPROP checks whether property exists in exporter of CON subject group in TXT/error.
			%
			% CHECK = ExporterGroupSubjectCON_TXT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSPROP(PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(EX, PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(ExporterGroupSubjectCON_TXT, PROP) checks whether PROP exists for ExporterGroupSubjectCON_TXT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ExporterGroupSubjectCON_TXT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSPROP(PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectCON_TXT:WrongInput]
			%  Element.EXISTSPROP(EX, PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectCON_TXT:WrongInput]
			%  Element.EXISTSPROP(ExporterGroupSubjectCON_TXT, PROP) throws error if PROP does NOT exist for ExporterGroupSubjectCON_TXT.
			%   Error id: [BRAPH2:ExporterGroupSubjectCON_TXT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(EX) and Element.EXISTSPROP('ExporterGroupSubjectCON_TXT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ExporterGroupSubjectCON_TXT:' 'WrongInput'], ...
					['BRAPH2' ':ExporterGroupSubjectCON_TXT:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ExporterGroupSubjectCON_TXT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in exporter of CON subject group in TXT/error.
			%
			% CHECK = ExporterGroupSubjectCON_TXT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSTAG(TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(EX, TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(ExporterGroupSubjectCON_TXT, TAG) checks whether TAG exists for ExporterGroupSubjectCON_TXT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ExporterGroupSubjectCON_TXT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSTAG(TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectCON_TXT:WrongInput]
			%  Element.EXISTSTAG(EX, TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectCON_TXT:WrongInput]
			%  Element.EXISTSTAG(ExporterGroupSubjectCON_TXT, TAG) throws error if TAG does NOT exist for ExporterGroupSubjectCON_TXT.
			%   Error id: [BRAPH2:ExporterGroupSubjectCON_TXT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(EX) and Element.EXISTSTAG('ExporterGroupSubjectCON_TXT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'DIRECTORY'  'PUT_DIR'  'SAVE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ExporterGroupSubjectCON_TXT:' 'WrongInput'], ...
					['BRAPH2' ':ExporterGroupSubjectCON_TXT:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ExporterGroupSubjectCON_TXT.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ExporterGroupSubjectCON_TXT, POINTER) returns property number of POINTER of ExporterGroupSubjectCON_TXT.
			%  PROPERTY = EX.GETPROPPROP(ExporterGroupSubjectCON_TXT, POINTER) returns property number of POINTER of ExporterGroupSubjectCON_TXT.
			%
			% Note that the Element.GETPROPPROP(EX) and Element.GETPROPPROP('ExporterGroupSubjectCON_TXT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'DIRECTORY'  'PUT_DIR'  'SAVE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(ExporterGroupSubjectCON_TXT, POINTER) returns tag of POINTER of ExporterGroupSubjectCON_TXT.
			%  TAG = EX.GETPROPTAG(ExporterGroupSubjectCON_TXT, POINTER) returns tag of POINTER of ExporterGroupSubjectCON_TXT.
			%
			% Note that the Element.GETPROPTAG(EX) and Element.GETPROPTAG('ExporterGroupSubjectCON_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				exportergroupsubjectcon_txt_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'DIRECTORY'  'PUT_DIR'  'SAVE' };
				tag = exportergroupsubjectcon_txt_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(ExporterGroupSubjectCON_TXT, POINTER) returns category of POINTER of ExporterGroupSubjectCON_TXT.
			%  CATEGORY = EX.GETPROPCATEGORY(ExporterGroupSubjectCON_TXT, POINTER) returns category of POINTER of ExporterGroupSubjectCON_TXT.
			%
			% Note that the Element.GETPROPCATEGORY(EX) and Element.GETPROPCATEGORY('ExporterGroupSubjectCON_TXT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ExporterGroupSubjectCON_TXT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			exportergroupsubjectcon_txt_category_list = { 1  1  1  3  4  2  2  6  9  4  4  6  5 };
			prop_category = exportergroupsubjectcon_txt_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(ExporterGroupSubjectCON_TXT, POINTER) returns format of POINTER of ExporterGroupSubjectCON_TXT.
			%  FORMAT = EX.GETPROPFORMAT(ExporterGroupSubjectCON_TXT, POINTER) returns format of POINTER of ExporterGroupSubjectCON_TXT.
			%
			% Note that the Element.GETPROPFORMAT(EX) and Element.GETPROPFORMAT('ExporterGroupSubjectCON_TXT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ExporterGroupSubjectCON_TXT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			exportergroupsubjectcon_txt_format_list = { 2  2  2  8  2  2  2  2  4  8  2  8  1 };
			prop_format = exportergroupsubjectcon_txt_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ExporterGroupSubjectCON_TXT, POINTER) returns description of POINTER of ExporterGroupSubjectCON_TXT.
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(ExporterGroupSubjectCON_TXT, POINTER) returns description of POINTER of ExporterGroupSubjectCON_TXT.
			%
			% Note that the Element.GETPROPDESCRIPTION(EX) and Element.GETPROPDESCRIPTION('ExporterGroupSubjectCON_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ExporterGroupSubjectCON_TXT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			exportergroupsubjectcon_txt_description_list = { 'ELCLASS (constant, string) is the class of the CON subject group exporter in TXT.'  'NAME (constant, string) is the name of the CON subject group exporter in TXT.'  'DESCRIPTION (constant, string) is the description of the CON subject group exporter in TXT.'  'TEMPLATE (parameter, item) is the template of the CON subject group exporter in TXT.'  'ID (data, string) is a few-letter code for the CON subject group exporter in TXT.'  'LABEL (metadata, string) is an extended label of the CON subject group exporter in TXT.'  'NOTES (metadata, string) are some specific notes about the CON subject group exporter in TXT.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'GR (data, item) is a group of subjects with connectivity data.'  'DIRECTORY (data, string) is the directory name where to save the group of subjects with connectivity data.'  'PUT_DIR (query, item) opens a dialog box to set the directory where to save the group of subjects with connectivity data.'  'SAVE (result, empty) saves the group of subjects with connectivity data in TXT files in the selected directory.' };
			prop_description = exportergroupsubjectcon_txt_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(ExporterGroupSubjectCON_TXT, POINTER) returns settings of POINTER of ExporterGroupSubjectCON_TXT.
			%  SETTINGS = EX.GETPROPSETTINGS(ExporterGroupSubjectCON_TXT, POINTER) returns settings of POINTER of ExporterGroupSubjectCON_TXT.
			%
			% Note that the Element.GETPROPSETTINGS(EX) and Element.GETPROPSETTINGS('ExporterGroupSubjectCON_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ExporterGroupSubjectCON_TXT.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ExporterGroupSubjectCON_TXT.GR
					prop_settings = 'Group';
				case 11 % ExporterGroupSubjectCON_TXT.DIRECTORY
					prop_settings = Format.getFormatSettings(2);
				case 12 % ExporterGroupSubjectCON_TXT.PUT_DIR
					prop_settings = 'ExporterGroupSubjectCON_TXT';
				case 13 % ExporterGroupSubjectCON_TXT.SAVE
					prop_settings = Format.getFormatSettings(1);
				case 4 % ExporterGroupSubjectCON_TXT.TEMPLATE
					prop_settings = 'ExporterGroupSubjectCON_TXT';
				otherwise
					prop_settings = getPropSettings@Exporter(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ExporterGroupSubjectCON_TXT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterGroupSubjectCON_TXT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULT(ExporterGroupSubjectCON_TXT, POINTER) returns the default value of POINTER of ExporterGroupSubjectCON_TXT.
			%  DEFAULT = EX.GETPROPDEFAULT(ExporterGroupSubjectCON_TXT, POINTER) returns the default value of POINTER of ExporterGroupSubjectCON_TXT.
			%
			% Note that the Element.GETPROPDEFAULT(EX) and Element.GETPROPDEFAULT('ExporterGroupSubjectCON_TXT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ExporterGroupSubjectCON_TXT.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ExporterGroupSubjectCON_TXT.GR
					prop_default = Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'));
				case 11 % ExporterGroupSubjectCON_TXT.DIRECTORY
					prop_default = [fileparts(which('test_braph2')) filesep 'default_group_subjects_CON_most_likely_to_be_erased'];
				case 12 % ExporterGroupSubjectCON_TXT.PUT_DIR
					prop_default = Format.getFormatDefault(8, ExporterGroupSubjectCON_TXT.getPropSettings(prop));
				case 13 % ExporterGroupSubjectCON_TXT.SAVE
					prop_default = Format.getFormatDefault(1, ExporterGroupSubjectCON_TXT.getPropSettings(prop));
				case 1 % ExporterGroupSubjectCON_TXT.ELCLASS
					prop_default = 'ExporterGroupSubjectCON_TXT';
				case 2 % ExporterGroupSubjectCON_TXT.NAME
					prop_default = 'Connectivity Subject Group TXT Exporter';
				case 3 % ExporterGroupSubjectCON_TXT.DESCRIPTION
					prop_default = 'ExporterGroupSubjectCON_TXT exports a group of subjects with connectivity data to a series of TXT file and their covariates age and sex (if existing) to another TXT file.';
				case 4 % ExporterGroupSubjectCON_TXT.TEMPLATE
					prop_default = Format.getFormatDefault(8, ExporterGroupSubjectCON_TXT.getPropSettings(prop));
				case 5 % ExporterGroupSubjectCON_TXT.ID
					prop_default = 'ExporterGroupSubjectCON_TXT ID';
				case 6 % ExporterGroupSubjectCON_TXT.LABEL
					prop_default = 'ExporterGroupSubjectCON_TXT label';
				case 7 % ExporterGroupSubjectCON_TXT.NOTES
					prop_default = 'ExporterGroupSubjectCON_TXT notes';
				otherwise
					prop_default = getPropDefault@Exporter(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ExporterGroupSubjectCON_TXT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterGroupSubjectCON_TXT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ExporterGroupSubjectCON_TXT, POINTER) returns the conditioned default value of POINTER of ExporterGroupSubjectCON_TXT.
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(ExporterGroupSubjectCON_TXT, POINTER) returns the conditioned default value of POINTER of ExporterGroupSubjectCON_TXT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(EX) and Element.GETPROPDEFAULTCONDITIONED('ExporterGroupSubjectCON_TXT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ExporterGroupSubjectCON_TXT.getPropProp(pointer);
			
			prop_default = ExporterGroupSubjectCON_TXT.conditioning(prop, ExporterGroupSubjectCON_TXT.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ExporterGroupSubjectCON_TXT, PROP, VALUE) checks VALUE format for PROP of ExporterGroupSubjectCON_TXT.
			%  CHECK = EX.CHECKPROP(ExporterGroupSubjectCON_TXT, PROP, VALUE) checks VALUE format for PROP of ExporterGroupSubjectCON_TXT.
			% 
			% EX.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ExporterGroupSubjectCON_TXT:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  EX.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EX.
			%   Error id: BRAPH2:ExporterGroupSubjectCON_TXT:WrongInput
			%  Element.CHECKPROP(ExporterGroupSubjectCON_TXT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterGroupSubjectCON_TXT.
			%   Error id: BRAPH2:ExporterGroupSubjectCON_TXT:WrongInput
			%  EX.CHECKPROP(ExporterGroupSubjectCON_TXT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterGroupSubjectCON_TXT.
			%   Error id: BRAPH2:ExporterGroupSubjectCON_TXT:WrongInput]
			% 
			% Note that the Element.CHECKPROP(EX) and Element.CHECKPROP('ExporterGroupSubjectCON_TXT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ExporterGroupSubjectCON_TXT.getPropProp(pointer);
			
			switch prop
				case 10 % ExporterGroupSubjectCON_TXT.GR
					check = Format.checkFormat(8, value, ExporterGroupSubjectCON_TXT.getPropSettings(prop));
				case 11 % ExporterGroupSubjectCON_TXT.DIRECTORY
					check = Format.checkFormat(2, value, ExporterGroupSubjectCON_TXT.getPropSettings(prop));
				case 12 % ExporterGroupSubjectCON_TXT.PUT_DIR
					check = Format.checkFormat(8, value, ExporterGroupSubjectCON_TXT.getPropSettings(prop));
				case 13 % ExporterGroupSubjectCON_TXT.SAVE
					check = Format.checkFormat(1, value, ExporterGroupSubjectCON_TXT.getPropSettings(prop));
				case 4 % ExporterGroupSubjectCON_TXT.TEMPLATE
					check = Format.checkFormat(8, value, ExporterGroupSubjectCON_TXT.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@Exporter(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ExporterGroupSubjectCON_TXT:' 'WrongInput'], ...
					['BRAPH2' ':ExporterGroupSubjectCON_TXT:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ExporterGroupSubjectCON_TXT.getPropTag(prop) ' (' ExporterGroupSubjectCON_TXT.getFormatTag(ExporterGroupSubjectCON_TXT.getPropFormat(prop)) ').'] ...
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
				case 12 % ExporterGroupSubjectCON_TXT.PUT_DIR
					directory = uigetdir('Select directory');
					if ischar(directory) && isfolder(directory)
						ex.set('DIRECTORY', directory);
					end
					value = ex;
					
				case 13 % ExporterGroupSubjectCON_TXT.SAVE
					rng_settings_ = rng(); rng(ex.getPropSeed(13), 'twister')
					
					directory = ex.get('DIRECTORY');
					
					if isfolder(directory)
					    wb = braph2waitbar(ex.get('WAITBAR'), 0, 'Retrieving path ...');
					    
					    gr = ex.get('GR');
					
					    gr_directory = [directory filesep() gr.get('ID')];
					    if ~exist(gr_directory, 'dir')
					        mkdir(gr_directory)
					    end
					    
					    braph2waitbar(wb, .15, 'Organizing info ...')
					    
					    sub_dict = gr.get('SUB_DICT');
					    sub_number = sub_dict.get('LENGTH');
					    
					    for i = 1:1:sub_number
					        braph2waitbar(wb, .15 + .85 * i / sub_number, ['Saving subject ' num2str(i) ' of ' num2str(sub_number) '...'])
					        
					        sub = sub_dict.get('IT', i);
					        sub_id = sub.get('ID');
					        sub_CON = sub.get('CON');
					
					        tab = table(sub_CON);
					
					        sub_file = [gr_directory filesep() sub_id '.txt'];
					
					        % save file
					        writetable(tab, sub_file, 'Delimiter', '	', 'WriteVariableNames', false);
					    end
					    
					    % variables of interest
					    voi_ids = {};
					    for i = 1:1:sub_number
					        sub = sub_dict.get('IT', i);
					        voi_ids = unique([voi_ids, sub.get('VOI_DICT').get('KEYS')]);
					    end
					    if ~isempty(voi_ids)
					        vois = cell(2 + sub_number, 1 + length(voi_ids));
					        vois{1, 1} = 'Subject ID';
					        vois(1, 2:end) = voi_ids;
					        for i = 1:1:sub_number
					            sub = sub_dict.get('IT', i);
					            vois{2 + i, 1} = sub.get('ID');
					            
					            voi_dict = sub.get('VOI_DICT');
					            for v = 1:1:voi_dict.get('LENGTH')
					                voi = voi_dict.get('IT', v);
					                voi_id = voi.get('ID');
					                if isa(voi, 'VOINumeric') % Numeric
					                    vois{2 + i, 1 + find(strcmp(voi_id, voi_ids))} = voi.get('V');
					                elseif isa(voi, 'VOICategoric') % Categoric
					                    categories = voi.get('CATEGORIES');
					                    vois{2, 1 + find(strcmp(voi_id, voi_ids))} = {['{' sprintf(' ''%s'' ', categories{:}) '}']};
					                    vois{2 + i, 1 + find(strcmp(voi_id, voi_ids))} = categories{voi.get('V')};
					                end
					            end
					        end
					        writetable(table(vois), [gr_directory '.vois.txt'], 'Delimiter', '	', 'WriteVariableNames', false)
					    end
					    
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
	methods (Access=protected) % check value
		function [check, msg] = checkValue(ex, prop, value)
			%CHECKVALUE checks the value of a property after it is set/calculated.
			%
			% [CHECK, MSG] = CHECKVALUE(EL, PROP, VALUE) checks the value
			%  of the property PROP after it is set/calculated. This function by
			%  default returns a CHECK = true and MSG = '. It should be implemented in
			%  the subclasses of Element when needed.
			%
			% See also conditioning, preset, checkProp, postset, postprocessing,
			%  calculateValue.
			
			check = true;
			msg = ['Error while checking ' tostring(ex) ' ' ex.getPropTag(prop) '.'];
			
			switch prop
				case 10 % ExporterGroupSubjectCON_TXT.GR
					check = any(strcmp(value.get('SUB_CLASS'), subclasses('SubjectCON', [], [], true))); % Format.checkFormat(8, value, 'Group') already checked
					
				otherwise
					if prop <= 9
						[check, msg] = checkValue@Exporter(ex, prop, value);
					end
			end
		end
	end
end
