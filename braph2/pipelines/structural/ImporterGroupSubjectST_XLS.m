classdef ImporterGroupSubjectST_XLS < Importer
	%ImporterGroupSubjectST_XLS imports a group of subjects with structural data from an XLS/XLSX file.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% ImporterGroupSubjectST_XLS imports a group of subjects with structural data 
	%  from an XLS/XLSX file named "GROUP_ID.xlsx". This file contains the 
	%  following columns: Subject ID (column 1), Subject LABEL (column 2), 
	%  Subject NOTES (column 3) and BrainRegions (columns 4-end; one brain region 
	%  value per column). The first row contains the headers and each subsequent 
	%  row the values for each subject.
	% The variables of interest are from another XLS/XLSX file named "GROUP_ID.vois.xlsx" 
	%  (if existing) consisting of the following columns: 
	%  Subject ID (column 1), covariates (subsequent columns). 
	%  The 1st row contains the headers, the 2nd row a string with the categorical
	%  variables of interest, and each subsequent row the values for each subject.
	%
	% The list of ImporterGroupSubjectST_XLS properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the ST subject group importer from XLS/XLSX.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ST subject group importer from XLS/XLSX.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ST subject group importer from XLS/XLSX.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ST subject group importer from XLS/XLSX.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ST subject group importer from XLS/XLSX.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ST subject group importer from XLS/XLSX.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ST subject group importer from XLS/XLSX.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>FILE</strong> 	FILE (data, string) is the XLS/XLSX file from where to load the ST subject group.
	%  <strong>11</strong> <strong>GET_FILE</strong> 	GET_FILE (query, item) opens a dialog box to set the XLS/XLSX file from where to load the ST subject group.
	%  <strong>12</strong> <strong>BA</strong> 	BA (data, item) is a brain atlas.
	%  <strong>13</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with structural data.
	%
	% ImporterGroupSubjectST_XLS methods (constructor):
	%  ImporterGroupSubjectST_XLS - constructor
	%
	% ImporterGroupSubjectST_XLS methods:
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
	% ImporterGroupSubjectST_XLS methods (display):
	%  tostring - string with information about the importer of ST subject group from XLS/XLSX
	%  disp - displays information about the importer of ST subject group from XLS/XLSX
	%  tree - displays the tree of the importer of ST subject group from XLS/XLSX
	%
	% ImporterGroupSubjectST_XLS methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two importer of ST subject group from XLS/XLSX are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the importer of ST subject group from XLS/XLSX
	%
	% ImporterGroupSubjectST_XLS methods (save/load, Static):
	%  save - saves BRAPH2 importer of ST subject group from XLS/XLSX as b2 file
	%  load - loads a BRAPH2 importer of ST subject group from XLS/XLSX from a b2 file
	%
	% ImporterGroupSubjectST_XLS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the importer of ST subject group from XLS/XLSX
	%
	% ImporterGroupSubjectST_XLS method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the importer of ST subject group from XLS/XLSX
	%
	% ImporterGroupSubjectST_XLS methods (inspection, Static):
	%  getClass - returns the class of the importer of ST subject group from XLS/XLSX
	%  getSubclasses - returns all subclasses of ImporterGroupSubjectST_XLS
	%  getProps - returns the property list of the importer of ST subject group from XLS/XLSX
	%  getPropNumber - returns the property number of the importer of ST subject group from XLS/XLSX
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
	% ImporterGroupSubjectST_XLS methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ImporterGroupSubjectST_XLS methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ImporterGroupSubjectST_XLS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterGroupSubjectST_XLS methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ImporterGroupSubjectST_XLS; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ImporterGroupSubjectST_XLS constants</a>.
	%
	%
	% See also Group, SubjectST, ExporterGroupSubjectST_XLS.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		FILE = 10; %CET: Computational Efficiency Trick
		FILE_TAG = 'FILE';
		FILE_CATEGORY = 4;
		FILE_FORMAT = 2;
		
		GET_FILE = 11; %CET: Computational Efficiency Trick
		GET_FILE_TAG = 'GET_FILE';
		GET_FILE_CATEGORY = 6;
		GET_FILE_FORMAT = 8;
		
		BA = 12; %CET: Computational Efficiency Trick
		BA_TAG = 'BA';
		BA_CATEGORY = 4;
		BA_FORMAT = 8;
		
		GR = 13; %CET: Computational Efficiency Trick
		GR_TAG = 'GR';
		GR_CATEGORY = 5;
		GR_FORMAT = 8;
	end
	methods % constructor
		function im = ImporterGroupSubjectST_XLS(varargin)
			%ImporterGroupSubjectST_XLS() creates a importer of ST subject group from XLS/XLSX.
			%
			% ImporterGroupSubjectST_XLS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterGroupSubjectST_XLS(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ImporterGroupSubjectST_XLS properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the ST subject group importer from XLS/XLSX.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ST subject group importer from XLS/XLSX.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ST subject group importer from XLS/XLSX.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ST subject group importer from XLS/XLSX.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ST subject group importer from XLS/XLSX.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ST subject group importer from XLS/XLSX.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ST subject group importer from XLS/XLSX.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>FILE</strong> 	FILE (data, string) is the XLS/XLSX file from where to load the ST subject group.
			%  <strong>11</strong> <strong>GET_FILE</strong> 	GET_FILE (query, item) opens a dialog box to set the XLS/XLSX file from where to load the ST subject group.
			%  <strong>12</strong> <strong>BA</strong> 	BA (data, item) is a brain atlas.
			%  <strong>13</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with structural data.
			%
			% See also Category, Format.
			
			im = im@Importer(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the importer of ST subject group from XLS/XLSX.
			%
			% BUILD = ImporterGroupSubjectST_XLS.GETBUILD() returns the build of 'ImporterGroupSubjectST_XLS'.
			%
			% Alternative forms to call this method are:
			%  BUILD = IM.GETBUILD() returns the build of the importer of ST subject group from XLS/XLSX IM.
			%  BUILD = Element.GETBUILD(IM) returns the build of 'IM'.
			%  BUILD = Element.GETBUILD('ImporterGroupSubjectST_XLS') returns the build of 'ImporterGroupSubjectST_XLS'.
			%
			% Note that the Element.GETBUILD(IM) and Element.GETBUILD('ImporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			
			build = 1;
		end
		function im_class = getClass()
			%GETCLASS returns the class of the importer of ST subject group from XLS/XLSX.
			%
			% CLASS = ImporterGroupSubjectST_XLS.GETCLASS() returns the class 'ImporterGroupSubjectST_XLS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer of ST subject group from XLS/XLSX IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterGroupSubjectST_XLS') returns 'ImporterGroupSubjectST_XLS'.
			%
			% Note that the Element.GETCLASS(IM) and Element.GETCLASS('ImporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			
			im_class = 'ImporterGroupSubjectST_XLS';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the importer of ST subject group from XLS/XLSX.
			%
			% LIST = ImporterGroupSubjectST_XLS.GETSUBCLASSES() returns all subclasses of 'ImporterGroupSubjectST_XLS'.
			%
			% Alternative forms to call this method are:
			%  LIST = IM.GETSUBCLASSES() returns all subclasses of the importer of ST subject group from XLS/XLSX IM.
			%  LIST = Element.GETSUBCLASSES(IM) returns all subclasses of 'IM'.
			%  LIST = Element.GETSUBCLASSES('ImporterGroupSubjectST_XLS') returns all subclasses of 'ImporterGroupSubjectST_XLS'.
			%
			% Note that the Element.GETSUBCLASSES(IM) and Element.GETSUBCLASSES('ImporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ImporterGroupSubjectST_XLS' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer of ST subject group from XLS/XLSX.
			%
			% PROPS = ImporterGroupSubjectST_XLS.GETPROPS() returns the property list of importer of ST subject group from XLS/XLSX
			%  as a row vector.
			%
			% PROPS = ImporterGroupSubjectST_XLS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer of ST subject group from XLS/XLSX IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterGroupSubjectST_XLS'[, CATEGORY]) returns the property list of 'ImporterGroupSubjectST_XLS'.
			%
			% Note that the Element.GETPROPS(IM) and Element.GETPROPS('ImporterGroupSubjectST_XLS')
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
					prop_list = [5 10 12];
				case 5 % Category.RESULT
					prop_list = 13;
				case 6 % Category.QUERY
					prop_list = [8 11];
				case 9 % Category.GUI
					prop_list = 9;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of importer of ST subject group from XLS/XLSX.
			%
			% N = ImporterGroupSubjectST_XLS.GETPROPNUMBER() returns the property number of importer of ST subject group from XLS/XLSX.
			%
			% N = ImporterGroupSubjectST_XLS.GETPROPNUMBER(CATEGORY) returns the property number of importer of ST subject group from XLS/XLSX
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER([CATEGORY]) returns the property number of the importer of ST subject group from XLS/XLSX IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterGroupSubjectST_XLS') returns the property number of 'ImporterGroupSubjectST_XLS'.
			%
			% Note that the Element.GETPROPNUMBER(IM) and Element.GETPROPNUMBER('ImporterGroupSubjectST_XLS')
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
			%EXISTSPROP checks whether property exists in importer of ST subject group from XLS/XLSX/error.
			%
			% CHECK = ImporterGroupSubjectST_XLS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterGroupSubjectST_XLS, PROP) checks whether PROP exists for ImporterGroupSubjectST_XLS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%  Element.EXISTSPROP(ImporterGroupSubjectST_XLS, PROP) throws error if PROP does NOT exist for ImporterGroupSubjectST_XLS.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IM) and Element.EXISTSPROP('ImporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterGroupSubjectST_XLS:' 'WrongInput'], ...
					['BRAPH2' ':ImporterGroupSubjectST_XLS:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterGroupSubjectST_XLS.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer of ST subject group from XLS/XLSX/error.
			%
			% CHECK = ImporterGroupSubjectST_XLS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterGroupSubjectST_XLS, TAG) checks whether TAG exists for ImporterGroupSubjectST_XLS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%  Element.EXISTSTAG(ImporterGroupSubjectST_XLS, TAG) throws error if TAG does NOT exist for ImporterGroupSubjectST_XLS.
			%   Error id: [BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IM) and Element.EXISTSTAG('ImporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'FILE'  'GET_FILE'  'BA'  'GR' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterGroupSubjectST_XLS:' 'WrongInput'], ...
					['BRAPH2' ':ImporterGroupSubjectST_XLS:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ImporterGroupSubjectST_XLS.'] ...
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
			%  PROPERTY = IM.GETPROPPROP(POINTER) returns property number of POINTER of IM.
			%  PROPERTY = Element.GETPROPPROP(ImporterGroupSubjectST_XLS, POINTER) returns property number of POINTER of ImporterGroupSubjectST_XLS.
			%  PROPERTY = IM.GETPROPPROP(ImporterGroupSubjectST_XLS, POINTER) returns property number of POINTER of ImporterGroupSubjectST_XLS.
			%
			% Note that the Element.GETPROPPROP(IM) and Element.GETPROPPROP('ImporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'FILE'  'GET_FILE'  'BA'  'GR' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = IM.GETPROPTAG(POINTER) returns tag of POINTER of IM.
			%  TAG = Element.GETPROPTAG(ImporterGroupSubjectST_XLS, POINTER) returns tag of POINTER of ImporterGroupSubjectST_XLS.
			%  TAG = IM.GETPROPTAG(ImporterGroupSubjectST_XLS, POINTER) returns tag of POINTER of ImporterGroupSubjectST_XLS.
			%
			% Note that the Element.GETPROPTAG(IM) and Element.GETPROPTAG('ImporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				importergroupsubjectst_xls_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'FILE'  'GET_FILE'  'BA'  'GR' };
				tag = importergroupsubjectst_xls_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = IM.GETPROPCATEGORY(POINTER) returns category of POINTER of IM.
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterGroupSubjectST_XLS, POINTER) returns category of POINTER of ImporterGroupSubjectST_XLS.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterGroupSubjectST_XLS, POINTER) returns category of POINTER of ImporterGroupSubjectST_XLS.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('ImporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectST_XLS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importergroupsubjectst_xls_category_list = { 1  1  1  3  4  2  2  6  9  4  6  4  5 };
			prop_category = importergroupsubjectst_xls_category_list{prop};
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
			%  FORMAT = IM.GETPROPFORMAT(POINTER) returns format of POINTER of IM.
			%  FORMAT = Element.GETPROPFORMAT(ImporterGroupSubjectST_XLS, POINTER) returns format of POINTER of ImporterGroupSubjectST_XLS.
			%  FORMAT = IM.GETPROPFORMAT(ImporterGroupSubjectST_XLS, POINTER) returns format of POINTER of ImporterGroupSubjectST_XLS.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('ImporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectST_XLS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importergroupsubjectst_xls_format_list = { 2  2  2  8  2  2  2  2  4  2  8  8  8 };
			prop_format = importergroupsubjectst_xls_format_list{prop};
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
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(POINTER) returns description of POINTER of IM.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterGroupSubjectST_XLS, POINTER) returns description of POINTER of ImporterGroupSubjectST_XLS.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterGroupSubjectST_XLS, POINTER) returns description of POINTER of ImporterGroupSubjectST_XLS.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('ImporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectST_XLS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importergroupsubjectst_xls_description_list = { 'ELCLASS (constant, string) is the class of the ST subject group importer from XLS/XLSX.'  'NAME (constant, string) is the name of the ST subject group importer from XLS/XLSX.'  'DESCRIPTION (constant, string) is the description of the ST subject group importer from XLS/XLSX.'  'TEMPLATE (parameter, item) is the template of the ST subject group importer from XLS/XLSX.'  'ID (data, string) is a few-letter code for the ST subject group importer from XLS/XLSX.'  'LABEL (metadata, string) is an extended label of the ST subject group importer from XLS/XLSX.'  'NOTES (metadata, string) are some specific notes about the ST subject group importer from XLS/XLSX.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'FILE (data, string) is the XLS/XLSX file from where to load the ST subject group.'  'GET_FILE (query, item) opens a dialog box to set the XLS/XLSX file from where to load the ST subject group.'  'BA (data, item) is a brain atlas.'  'GR (result, item) is a group of subjects with structural data.' };
			prop_description = importergroupsubjectst_xls_description_list{prop};
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
			%  SETTINGS = IM.GETPROPSETTINGS(POINTER) returns settings of POINTER of IM.
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterGroupSubjectST_XLS, POINTER) returns settings of POINTER of ImporterGroupSubjectST_XLS.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterGroupSubjectST_XLS, POINTER) returns settings of POINTER of ImporterGroupSubjectST_XLS.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('ImporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectST_XLS.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ImporterGroupSubjectST_XLS.FILE
					prop_settings = Format.getFormatSettings(2);
				case 11 % ImporterGroupSubjectST_XLS.GET_FILE
					prop_settings = 'ImporterGroupSubjectST_XLS';
				case 12 % ImporterGroupSubjectST_XLS.BA
					prop_settings = 'BrainAtlas';
				case 13 % ImporterGroupSubjectST_XLS.GR
					prop_settings = 'Group';
				case 4 % ImporterGroupSubjectST_XLS.TEMPLATE
					prop_settings = 'ImporterGroupSubjectST_XLS';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectST_XLS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectST_XLS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterGroupSubjectST_XLS, POINTER) returns the default value of POINTER of ImporterGroupSubjectST_XLS.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterGroupSubjectST_XLS, POINTER) returns the default value of POINTER of ImporterGroupSubjectST_XLS.
			%
			% Note that the Element.GETPROPDEFAULT(IM) and Element.GETPROPDEFAULT('ImporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterGroupSubjectST_XLS.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ImporterGroupSubjectST_XLS.FILE
					prop_default = '';
				case 11 % ImporterGroupSubjectST_XLS.GET_FILE
					prop_default = Format.getFormatDefault(8, ImporterGroupSubjectST_XLS.getPropSettings(prop));
				case 12 % ImporterGroupSubjectST_XLS.BA
					prop_default = Format.getFormatDefault(8, ImporterGroupSubjectST_XLS.getPropSettings(prop));
				case 13 % ImporterGroupSubjectST_XLS.GR
					prop_default = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
				case 1 % ImporterGroupSubjectST_XLS.ELCLASS
					prop_default = 'ImporterGroupSubjectST_XLS';
				case 2 % ImporterGroupSubjectST_XLS.NAME
					prop_default = 'Structural Subject Group XLS Importer';
				case 3 % ImporterGroupSubjectST_XLS.DESCRIPTION
					prop_default = 'ImporterGroupSubjectST_XLS imports a group of subjects with structural data and their covariates (optional) from another XLS/XLSX file.';
				case 4 % ImporterGroupSubjectST_XLS.TEMPLATE
					prop_default = Format.getFormatDefault(8, ImporterGroupSubjectST_XLS.getPropSettings(prop));
				case 5 % ImporterGroupSubjectST_XLS.ID
					prop_default = 'ImporterGroupSubjectST_XLS ID';
				case 6 % ImporterGroupSubjectST_XLS.LABEL
					prop_default = 'ImporterGroupSubjectST_XLS label';
				case 7 % ImporterGroupSubjectST_XLS.NOTES
					prop_default = 'ImporterGroupSubjectST_XLS notes';
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectST_XLS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectST_XLS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectST_XLS, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectST_XLS.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectST_XLS, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectST_XLS.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IM) and Element.GETPROPDEFAULTCONDITIONED('ImporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ImporterGroupSubjectST_XLS.getPropProp(pointer);
			
			prop_default = ImporterGroupSubjectST_XLS.conditioning(prop, ImporterGroupSubjectST_XLS.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = IM.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = IM.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of IM.
			%  CHECK = Element.CHECKPROP(ImporterGroupSubjectST_XLS, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectST_XLS.
			%  CHECK = IM.CHECKPROP(ImporterGroupSubjectST_XLS, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectST_XLS.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ImporterGroupSubjectST_XLS:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: BRAPH2:ImporterGroupSubjectST_XLS:WrongInput
			%  Element.CHECKPROP(ImporterGroupSubjectST_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectST_XLS.
			%   Error id: BRAPH2:ImporterGroupSubjectST_XLS:WrongInput
			%  IM.CHECKPROP(ImporterGroupSubjectST_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectST_XLS.
			%   Error id: BRAPH2:ImporterGroupSubjectST_XLS:WrongInput]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('ImporterGroupSubjectST_XLS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ImporterGroupSubjectST_XLS.getPropProp(pointer);
			
			switch prop
				case 10 % ImporterGroupSubjectST_XLS.FILE
					check = Format.checkFormat(2, value, ImporterGroupSubjectST_XLS.getPropSettings(prop));
				case 11 % ImporterGroupSubjectST_XLS.GET_FILE
					check = Format.checkFormat(8, value, ImporterGroupSubjectST_XLS.getPropSettings(prop));
				case 12 % ImporterGroupSubjectST_XLS.BA
					check = Format.checkFormat(8, value, ImporterGroupSubjectST_XLS.getPropSettings(prop));
				case 13 % ImporterGroupSubjectST_XLS.GR
					check = Format.checkFormat(8, value, ImporterGroupSubjectST_XLS.getPropSettings(prop));
				case 4 % ImporterGroupSubjectST_XLS.TEMPLATE
					check = Format.checkFormat(8, value, ImporterGroupSubjectST_XLS.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@Importer(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterGroupSubjectST_XLS:' 'WrongInput'], ...
					['BRAPH2' ':ImporterGroupSubjectST_XLS:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterGroupSubjectST_XLS.getPropTag(prop) ' (' ImporterGroupSubjectST_XLS.getFormatTag(ImporterGroupSubjectST_XLS.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(im, prop, varargin)
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
				case 11 % ImporterGroupSubjectST_XLS.GET_FILE
					[filename, filepath, filterindex] = uigetfile({'*.xlsx';'*.xls'}, 'Select Excel file');
					if filterindex
					    file = [filepath filename];
					    im.set('FILE', file);
					end
					value = im;
					
				case 13 % ImporterGroupSubjectST_XLS.GR
					rng_settings_ = rng(); rng(im.getPropSeed(13), 'twister')
					
					% creates empty Group
					gr = Group( ...
					    'SUB_CLASS', 'SubjectST', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST') ...
					    );
					
					gr.lock('SUB_CLASS');
					
					% analyzes file
					file = im.get('FILE');
					if isfile(file)
					    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading Directory ...');
					    
					    [~, ~, raw] = xlsread(file);
					        
					    try
					        braph2waitbar(wb, .15, 'Loading subject group ...')
					        
					        [~, name, ext] = fileparts(file);
					        gr.set( ...
					            'ID', name, ...
					            'LABEL', [name ext], ...
					            'NOTES', ['Group loaded from ' file] ...
					            );
					        
					        % brain atlas
					        braph2waitbar(wb, .25, 'Loading brain atlas ...')
					        ba = im.get('BA');
					        br_number = size(raw, 2) - 3;
					        if ba.get('BR_DICT').get('LENGTH') == 0
					            % adds the number of regions of the first file to the brain atlas
					            ba = BrainAtlas();
					            br_dict = ba.memorize('BR_DICT');
					            for j = 4:1:length(raw)
					                br_id = raw{1, j};
					                br = BrainRegion('ID', br_id);
					                br_dict.get('ADD', br)
					            end
					        end
					        if br_number ~= ba.get('BR_DICT').get('LENGTH')
					            error( ...
					                ['BRAPH2' ':' class(im) ':' 'ErrorIO'], ...
					                ['BRAPH2' ':' class(im) ':' 'ErrorIO' '\n' ...
					                'The file ' name '.' ext ' should contain a matrix with ' int2str(ba.get('BR_DICT').get('LENGTH')) ' columns corresponding to the brain regions, ' ...
					                'while it contains ' int2str(br_number) ' columns.'] ...
					                )
					        end
					                
					        % adds subjects
					        sub_dict = gr.memorize('SUB_DICT');
					        for i = 2:1:size(raw, 1)
					            braph2waitbar(wb, .25 + .75 * (i - 1) / size(raw, 1), ['Loading subject ' num2str(i - 1) ' of ' num2str(size(raw, 1) - 1) ' ...'])
					            
					            ST = zeros(br_number, 1);
					            for j = 1:1:length(ST)
					                ST(j) = raw{i, 3 + j};
					            end
					            sub = SubjectST( ...
					                'ID', num2str(raw{i, 1}), ...
					                'LABEL', num2str(raw{i, 2}), ...
					                'NOTES', num2str(raw{i, 3}), ...
					                'BA', ba, ...
					                'ST', ST ...
					                );
					            sub_dict.get('ADD', sub);
					        end
					        
					        % variables of interest
					        vois = [];
					        if isfile([fileparts(file) filesep() name '.vois.xls'])
					            [~, ~, vois] = xlsread([fileparts(file) filesep() name '.vois.xls']);
					        elseif isfile([fileparts(file) filesep() name '.vois.xlsx'])
					            [~, ~, vois] = xlsread([fileparts(file) filesep() name '.vois.xlsx']);
					        end
					        if ~isempty(vois)
					            for i = 3:1:size(vois, 1)
					                sub_id = vois{i, 1};
					                sub = sub_dict.get('IT', sub_id);
					                for v = 2:1:size(vois, 2)
					                    voi_id = vois{1, v};
					                    if isnumeric(vois{2, v}) % VOINumeric
					                        sub.memorize('VOI_DICT').get('ADD', ...
					                            VOINumeric( ...
					                                'ID', voi_id, ...
					                                'V', vois{i, v} ...
					                                ) ...
					                            );
					                    elseif ischar(vois{2, v}) % VOICategoric
					                        sub.memorize('VOI_DICT').get('ADD', ...
					                            VOICategoric( ...
					                                'ID', voi_id, ...
					                                'CATEGORIES', str2cell(vois{2, v}), ...
					                                'V', find(strcmp(vois{i, v}, str2cell(vois{2, v}))) ...
					                                ) ...
					                            );
					                    end                        
					                end
					            end
					        end
					    catch e
					        braph2waitbar(wb, 'close')
					
					        rethrow(e)
					    end
					    
					    braph2waitbar(wb, 'close')
					elseif ~isempty(file)
					    error(['BRAPH2' ':ImporterGroupSubjectST_XLS:' 'ErrorIO'], ...
					        ['BRAPH2' ':ImporterGroupSubjectST_XLS:' 'ErrorIO' '\n' ...
					        'The prop FILE must be an existing file, but it is ''' file '''.'] ...
					        );
					end
					
					value = gr;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 9
						value = calculateValue@Importer(im, prop, varargin{:});
					else
						value = calculateValue@Element(im, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(im, prop, value)
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
			msg = ['Error while checking ' tostring(im) ' ' im.getPropTag(prop) '.'];
			
			switch prop
				case 13 % ImporterGroupSubjectST_XLS.GR
					check = any(strcmp(value.get('SUB_CLASS'), subclasses('SubjectST', [], [], true))); % Format.checkFormat(8, value, 'Group') already checked
					
				otherwise
					if prop <= 9
						[check, msg] = checkValue@Importer(im, prop, value);
					end
			end
		end
	end
end
