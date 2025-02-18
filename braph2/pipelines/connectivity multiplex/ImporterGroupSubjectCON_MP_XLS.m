classdef ImporterGroupSubjectCON_MP_XLS < Importer
	%ImporterGroupSubjectCON_MP_XLS imports a group of subjects with connectivity multiplex data from a series of XLS/XLSX file.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% ImporterGroupSubjectCON_MP_XLS imports a group of subjects with connectivity 
	%  multiplex data from a series of XLS/XLSX files contained in a folder named 
	%  "GROUP_ID". All these files must be in the same folder; also, no other 
	%  files should be in the folder. Each file contains a table of values 
	%  corresponding to the adjacency matrix of a layer. Files should be labeled 
	%  with the layer number indicated as, e.g., "SUBJECT_ID.1.xlsx" and 
	%  "SUBJECT_ID.2.xlsx".
	% The variables of interest are from another XLS/XLSX file named "GROUP_ID.vois.xlsx" 
	%  (if exisitng) consisting of the following columns: 
	%  Subject ID (column 1), covariates (subsequent columns). 
	%  The 1st row contains the headers, the 2nd row a string with the categorical
	%  variables of interest, and each subsequent row the values for each subject.
	%
	% The list of ImporterGroupSubjectCON_MP_XLS properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the CON MP subject group importer from XLS/XLSX.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the CON MP subject group importer from XLS/XLSX.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the CON MP subject group importer from XLS/XLSX.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the CON MP subject group importer from XLS/XLSX.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the CON MP subject group importer from XLS/XLSX.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the CON MP subject group importer from XLS/XLSX.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the CON MP subject group importer from XLS/XLSX.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>DIRECTORY</strong> 	DIRECTORY (data, string) is the directory containing the CON MP subject folders from which to load the L layers of the group.
	%  <strong>11</strong> <strong>GET_DIR</strong> 	GET_DIR (query, item) opens a dialog box to set the directory from where to load the XLS/XLSX files of the FUN MP subject group with L layers.
	%  <strong>12</strong> <strong>BA</strong> 	BA (data, item) is a brain atlas.
	%  <strong>13</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with connectivity multiplex data.
	%
	% ImporterGroupSubjectCON_MP_XLS methods (constructor):
	%  ImporterGroupSubjectCON_MP_XLS - constructor
	%
	% ImporterGroupSubjectCON_MP_XLS methods:
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
	% ImporterGroupSubjectCON_MP_XLS methods (display):
	%  tostring - string with information about the importer of CON MP subject group from XLS/XLSX
	%  disp - displays information about the importer of CON MP subject group from XLS/XLSX
	%  tree - displays the tree of the importer of CON MP subject group from XLS/XLSX
	%
	% ImporterGroupSubjectCON_MP_XLS methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two importer of CON MP subject group from XLS/XLSX are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the importer of CON MP subject group from XLS/XLSX
	%
	% ImporterGroupSubjectCON_MP_XLS methods (save/load, Static):
	%  save - saves BRAPH2 importer of CON MP subject group from XLS/XLSX as b2 file
	%  load - loads a BRAPH2 importer of CON MP subject group from XLS/XLSX from a b2 file
	%
	% ImporterGroupSubjectCON_MP_XLS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the importer of CON MP subject group from XLS/XLSX
	%
	% ImporterGroupSubjectCON_MP_XLS method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the importer of CON MP subject group from XLS/XLSX
	%
	% ImporterGroupSubjectCON_MP_XLS methods (inspection, Static):
	%  getClass - returns the class of the importer of CON MP subject group from XLS/XLSX
	%  getSubclasses - returns all subclasses of ImporterGroupSubjectCON_MP_XLS
	%  getProps - returns the property list of the importer of CON MP subject group from XLS/XLSX
	%  getPropNumber - returns the property number of the importer of CON MP subject group from XLS/XLSX
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
	% ImporterGroupSubjectCON_MP_XLS methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ImporterGroupSubjectCON_MP_XLS methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ImporterGroupSubjectCON_MP_XLS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterGroupSubjectCON_MP_XLS methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ImporterGroupSubjectCON_MP_XLS; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ImporterGroupSubjectCON_MP_XLS constants</a>.
	%
	%
	% See also Group, SubjectCON_MP, ExporterGroupSubjectCON_MP_XLS.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		DIRECTORY = 10; %CET: Computational Efficiency Trick
		DIRECTORY_TAG = 'DIRECTORY';
		DIRECTORY_CATEGORY = 4;
		DIRECTORY_FORMAT = 2;
		
		GET_DIR = 11; %CET: Computational Efficiency Trick
		GET_DIR_TAG = 'GET_DIR';
		GET_DIR_CATEGORY = 6;
		GET_DIR_FORMAT = 8;
		
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
		function im = ImporterGroupSubjectCON_MP_XLS(varargin)
			%ImporterGroupSubjectCON_MP_XLS() creates a importer of CON MP subject group from XLS/XLSX.
			%
			% ImporterGroupSubjectCON_MP_XLS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterGroupSubjectCON_MP_XLS(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ImporterGroupSubjectCON_MP_XLS properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the CON MP subject group importer from XLS/XLSX.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the CON MP subject group importer from XLS/XLSX.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the CON MP subject group importer from XLS/XLSX.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the CON MP subject group importer from XLS/XLSX.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the CON MP subject group importer from XLS/XLSX.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the CON MP subject group importer from XLS/XLSX.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the CON MP subject group importer from XLS/XLSX.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>DIRECTORY</strong> 	DIRECTORY (data, string) is the directory containing the CON MP subject folders from which to load the L layers of the group.
			%  <strong>11</strong> <strong>GET_DIR</strong> 	GET_DIR (query, item) opens a dialog box to set the directory from where to load the XLS/XLSX files of the FUN MP subject group with L layers.
			%  <strong>12</strong> <strong>BA</strong> 	BA (data, item) is a brain atlas.
			%  <strong>13</strong> <strong>GR</strong> 	GR (result, item) is a group of subjects with connectivity multiplex data.
			%
			% See also Category, Format.
			
			im = im@Importer(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the importer of CON MP subject group from XLS/XLSX.
			%
			% BUILD = ImporterGroupSubjectCON_MP_XLS.GETBUILD() returns the build of 'ImporterGroupSubjectCON_MP_XLS'.
			%
			% Alternative forms to call this method are:
			%  BUILD = IM.GETBUILD() returns the build of the importer of CON MP subject group from XLS/XLSX IM.
			%  BUILD = Element.GETBUILD(IM) returns the build of 'IM'.
			%  BUILD = Element.GETBUILD('ImporterGroupSubjectCON_MP_XLS') returns the build of 'ImporterGroupSubjectCON_MP_XLS'.
			%
			% Note that the Element.GETBUILD(IM) and Element.GETBUILD('ImporterGroupSubjectCON_MP_XLS')
			%  are less computationally efficient.
			
			build = 1;
		end
		function im_class = getClass()
			%GETCLASS returns the class of the importer of CON MP subject group from XLS/XLSX.
			%
			% CLASS = ImporterGroupSubjectCON_MP_XLS.GETCLASS() returns the class 'ImporterGroupSubjectCON_MP_XLS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer of CON MP subject group from XLS/XLSX IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterGroupSubjectCON_MP_XLS') returns 'ImporterGroupSubjectCON_MP_XLS'.
			%
			% Note that the Element.GETCLASS(IM) and Element.GETCLASS('ImporterGroupSubjectCON_MP_XLS')
			%  are less computationally efficient.
			
			im_class = 'ImporterGroupSubjectCON_MP_XLS';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the importer of CON MP subject group from XLS/XLSX.
			%
			% LIST = ImporterGroupSubjectCON_MP_XLS.GETSUBCLASSES() returns all subclasses of 'ImporterGroupSubjectCON_MP_XLS'.
			%
			% Alternative forms to call this method are:
			%  LIST = IM.GETSUBCLASSES() returns all subclasses of the importer of CON MP subject group from XLS/XLSX IM.
			%  LIST = Element.GETSUBCLASSES(IM) returns all subclasses of 'IM'.
			%  LIST = Element.GETSUBCLASSES('ImporterGroupSubjectCON_MP_XLS') returns all subclasses of 'ImporterGroupSubjectCON_MP_XLS'.
			%
			% Note that the Element.GETSUBCLASSES(IM) and Element.GETSUBCLASSES('ImporterGroupSubjectCON_MP_XLS')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ImporterGroupSubjectCON_MP_XLS' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer of CON MP subject group from XLS/XLSX.
			%
			% PROPS = ImporterGroupSubjectCON_MP_XLS.GETPROPS() returns the property list of importer of CON MP subject group from XLS/XLSX
			%  as a row vector.
			%
			% PROPS = ImporterGroupSubjectCON_MP_XLS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer of CON MP subject group from XLS/XLSX IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterGroupSubjectCON_MP_XLS'[, CATEGORY]) returns the property list of 'ImporterGroupSubjectCON_MP_XLS'.
			%
			% Note that the Element.GETPROPS(IM) and Element.GETPROPS('ImporterGroupSubjectCON_MP_XLS')
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
			%GETPROPNUMBER returns the property number of importer of CON MP subject group from XLS/XLSX.
			%
			% N = ImporterGroupSubjectCON_MP_XLS.GETPROPNUMBER() returns the property number of importer of CON MP subject group from XLS/XLSX.
			%
			% N = ImporterGroupSubjectCON_MP_XLS.GETPROPNUMBER(CATEGORY) returns the property number of importer of CON MP subject group from XLS/XLSX
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER([CATEGORY]) returns the property number of the importer of CON MP subject group from XLS/XLSX IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterGroupSubjectCON_MP_XLS') returns the property number of 'ImporterGroupSubjectCON_MP_XLS'.
			%
			% Note that the Element.GETPROPNUMBER(IM) and Element.GETPROPNUMBER('ImporterGroupSubjectCON_MP_XLS')
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
			%EXISTSPROP checks whether property exists in importer of CON MP subject group from XLS/XLSX/error.
			%
			% CHECK = ImporterGroupSubjectCON_MP_XLS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterGroupSubjectCON_MP_XLS, PROP) checks whether PROP exists for ImporterGroupSubjectCON_MP_XLS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectCON_MP_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_MP_XLS:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_MP_XLS:WrongInput]
			%  Element.EXISTSPROP(ImporterGroupSubjectCON_MP_XLS, PROP) throws error if PROP does NOT exist for ImporterGroupSubjectCON_MP_XLS.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_MP_XLS:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IM) and Element.EXISTSPROP('ImporterGroupSubjectCON_MP_XLS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterGroupSubjectCON_MP_XLS:' 'WrongInput'], ...
					['BRAPH2' ':ImporterGroupSubjectCON_MP_XLS:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterGroupSubjectCON_MP_XLS.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer of CON MP subject group from XLS/XLSX/error.
			%
			% CHECK = ImporterGroupSubjectCON_MP_XLS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterGroupSubjectCON_MP_XLS, TAG) checks whether TAG exists for ImporterGroupSubjectCON_MP_XLS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterGroupSubjectCON_MP_XLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_MP_XLS:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_MP_XLS:WrongInput]
			%  Element.EXISTSTAG(ImporterGroupSubjectCON_MP_XLS, TAG) throws error if TAG does NOT exist for ImporterGroupSubjectCON_MP_XLS.
			%   Error id: [BRAPH2:ImporterGroupSubjectCON_MP_XLS:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IM) and Element.EXISTSTAG('ImporterGroupSubjectCON_MP_XLS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DIRECTORY'  'GET_DIR'  'BA'  'GR' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterGroupSubjectCON_MP_XLS:' 'WrongInput'], ...
					['BRAPH2' ':ImporterGroupSubjectCON_MP_XLS:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ImporterGroupSubjectCON_MP_XLS.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ImporterGroupSubjectCON_MP_XLS, POINTER) returns property number of POINTER of ImporterGroupSubjectCON_MP_XLS.
			%  PROPERTY = IM.GETPROPPROP(ImporterGroupSubjectCON_MP_XLS, POINTER) returns property number of POINTER of ImporterGroupSubjectCON_MP_XLS.
			%
			% Note that the Element.GETPROPPROP(IM) and Element.GETPROPPROP('ImporterGroupSubjectCON_MP_XLS')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DIRECTORY'  'GET_DIR'  'BA'  'GR' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(ImporterGroupSubjectCON_MP_XLS, POINTER) returns tag of POINTER of ImporterGroupSubjectCON_MP_XLS.
			%  TAG = IM.GETPROPTAG(ImporterGroupSubjectCON_MP_XLS, POINTER) returns tag of POINTER of ImporterGroupSubjectCON_MP_XLS.
			%
			% Note that the Element.GETPROPTAG(IM) and Element.GETPROPTAG('ImporterGroupSubjectCON_MP_XLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				importergroupsubjectcon_mp_xls_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DIRECTORY'  'GET_DIR'  'BA'  'GR' };
				tag = importergroupsubjectcon_mp_xls_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterGroupSubjectCON_MP_XLS, POINTER) returns category of POINTER of ImporterGroupSubjectCON_MP_XLS.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterGroupSubjectCON_MP_XLS, POINTER) returns category of POINTER of ImporterGroupSubjectCON_MP_XLS.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('ImporterGroupSubjectCON_MP_XLS')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectCON_MP_XLS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importergroupsubjectcon_mp_xls_category_list = { 1  1  1  3  4  2  2  6  9  4  6  4  5 };
			prop_category = importergroupsubjectcon_mp_xls_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(ImporterGroupSubjectCON_MP_XLS, POINTER) returns format of POINTER of ImporterGroupSubjectCON_MP_XLS.
			%  FORMAT = IM.GETPROPFORMAT(ImporterGroupSubjectCON_MP_XLS, POINTER) returns format of POINTER of ImporterGroupSubjectCON_MP_XLS.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('ImporterGroupSubjectCON_MP_XLS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectCON_MP_XLS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importergroupsubjectcon_mp_xls_format_list = { 2  2  2  8  2  2  2  2  4  2  8  8  8 };
			prop_format = importergroupsubjectcon_mp_xls_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterGroupSubjectCON_MP_XLS, POINTER) returns description of POINTER of ImporterGroupSubjectCON_MP_XLS.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterGroupSubjectCON_MP_XLS, POINTER) returns description of POINTER of ImporterGroupSubjectCON_MP_XLS.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('ImporterGroupSubjectCON_MP_XLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectCON_MP_XLS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importergroupsubjectcon_mp_xls_description_list = { 'ELCLASS (constant, string) is the class of the CON MP subject group importer from XLS/XLSX.'  'NAME (constant, string) is the name of the CON MP subject group importer from XLS/XLSX.'  'DESCRIPTION (constant, string) is the description of the CON MP subject group importer from XLS/XLSX.'  'TEMPLATE (parameter, item) is the template of the CON MP subject group importer from XLS/XLSX.'  'ID (data, string) is a few-letter code for the CON MP subject group importer from XLS/XLSX.'  'LABEL (metadata, string) is an extended label of the CON MP subject group importer from XLS/XLSX.'  'NOTES (metadata, string) are some specific notes about the CON MP subject group importer from XLS/XLSX.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'DIRECTORY (data, string) is the directory containing the CON MP subject folders from which to load the L layers of the group.'  'GET_DIR (query, item) opens a dialog box to set the directory from where to load the XLS/XLSX files of the FUN MP subject group with L layers.'  'BA (data, item) is a brain atlas.'  'GR (result, item) is a group of subjects with connectivity multiplex data.' };
			prop_description = importergroupsubjectcon_mp_xls_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterGroupSubjectCON_MP_XLS, POINTER) returns settings of POINTER of ImporterGroupSubjectCON_MP_XLS.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterGroupSubjectCON_MP_XLS, POINTER) returns settings of POINTER of ImporterGroupSubjectCON_MP_XLS.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('ImporterGroupSubjectCON_MP_XLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterGroupSubjectCON_MP_XLS.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ImporterGroupSubjectCON_MP_XLS.DIRECTORY
					prop_settings = Format.getFormatSettings(2);
				case 11 % ImporterGroupSubjectCON_MP_XLS.GET_DIR
					prop_settings = 'ImporterGroupSubjectCON_MP_XLS';
				case 12 % ImporterGroupSubjectCON_MP_XLS.BA
					prop_settings = 'BrainAtlas';
				case 13 % ImporterGroupSubjectCON_MP_XLS.GR
					prop_settings = 'Group';
				case 4 % ImporterGroupSubjectCON_MP_XLS.TEMPLATE
					prop_settings = 'ImporterGroupSubjectCON_MP_XLS';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectCON_MP_XLS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectCON_MP_XLS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterGroupSubjectCON_MP_XLS, POINTER) returns the default value of POINTER of ImporterGroupSubjectCON_MP_XLS.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterGroupSubjectCON_MP_XLS, POINTER) returns the default value of POINTER of ImporterGroupSubjectCON_MP_XLS.
			%
			% Note that the Element.GETPROPDEFAULT(IM) and Element.GETPROPDEFAULT('ImporterGroupSubjectCON_MP_XLS')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterGroupSubjectCON_MP_XLS.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ImporterGroupSubjectCON_MP_XLS.DIRECTORY
					prop_default = fileparts(which('test_braph2'));
				case 11 % ImporterGroupSubjectCON_MP_XLS.GET_DIR
					prop_default = Format.getFormatDefault(8, ImporterGroupSubjectCON_MP_XLS.getPropSettings(prop));
				case 12 % ImporterGroupSubjectCON_MP_XLS.BA
					prop_default = Format.getFormatDefault(8, ImporterGroupSubjectCON_MP_XLS.getPropSettings(prop));
				case 13 % ImporterGroupSubjectCON_MP_XLS.GR
					prop_default = Group('SUB_CLASS', 'SubjectCON_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_MP'));
				case 1 % ImporterGroupSubjectCON_MP_XLS.ELCLASS
					prop_default = 'ImporterGroupSubjectCON_MP_XLS';
				case 2 % ImporterGroupSubjectCON_MP_XLS.NAME
					prop_default = 'Multiplex Connectivity Subject Group XLS Importer';
				case 3 % ImporterGroupSubjectCON_MP_XLS.DESCRIPTION
					prop_default = 'ImporterGroupSubjectCON_MP_XLS imports a group of subjects with connectivity multiplex data from a series of XLS/XLSX files and their covariates (optional) from another XLS/XLSX file.';
				case 4 % ImporterGroupSubjectCON_MP_XLS.TEMPLATE
					prop_default = Format.getFormatDefault(8, ImporterGroupSubjectCON_MP_XLS.getPropSettings(prop));
				case 5 % ImporterGroupSubjectCON_MP_XLS.ID
					prop_default = 'ImporterGroupSubjectCON_MP_XLS ID';
				case 6 % ImporterGroupSubjectCON_MP_XLS.LABEL
					prop_default = 'ImporterGroupSubjectCON_MP_XLS label';
				case 7 % ImporterGroupSubjectCON_MP_XLS.NOTES
					prop_default = 'ImporterGroupSubjectCON_MP_XLS notes';
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterGroupSubjectCON_MP_XLS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterGroupSubjectCON_MP_XLS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectCON_MP_XLS, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectCON_MP_XLS.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterGroupSubjectCON_MP_XLS, POINTER) returns the conditioned default value of POINTER of ImporterGroupSubjectCON_MP_XLS.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IM) and Element.GETPROPDEFAULTCONDITIONED('ImporterGroupSubjectCON_MP_XLS')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ImporterGroupSubjectCON_MP_XLS.getPropProp(pointer);
			
			prop_default = ImporterGroupSubjectCON_MP_XLS.conditioning(prop, ImporterGroupSubjectCON_MP_XLS.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ImporterGroupSubjectCON_MP_XLS, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectCON_MP_XLS.
			%  CHECK = IM.CHECKPROP(ImporterGroupSubjectCON_MP_XLS, PROP, VALUE) checks VALUE format for PROP of ImporterGroupSubjectCON_MP_XLS.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ImporterGroupSubjectCON_MP_XLS:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: BRAPH2:ImporterGroupSubjectCON_MP_XLS:WrongInput
			%  Element.CHECKPROP(ImporterGroupSubjectCON_MP_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectCON_MP_XLS.
			%   Error id: BRAPH2:ImporterGroupSubjectCON_MP_XLS:WrongInput
			%  IM.CHECKPROP(ImporterGroupSubjectCON_MP_XLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterGroupSubjectCON_MP_XLS.
			%   Error id: BRAPH2:ImporterGroupSubjectCON_MP_XLS:WrongInput]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('ImporterGroupSubjectCON_MP_XLS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ImporterGroupSubjectCON_MP_XLS.getPropProp(pointer);
			
			switch prop
				case 10 % ImporterGroupSubjectCON_MP_XLS.DIRECTORY
					check = Format.checkFormat(2, value, ImporterGroupSubjectCON_MP_XLS.getPropSettings(prop));
				case 11 % ImporterGroupSubjectCON_MP_XLS.GET_DIR
					check = Format.checkFormat(8, value, ImporterGroupSubjectCON_MP_XLS.getPropSettings(prop));
				case 12 % ImporterGroupSubjectCON_MP_XLS.BA
					check = Format.checkFormat(8, value, ImporterGroupSubjectCON_MP_XLS.getPropSettings(prop));
				case 13 % ImporterGroupSubjectCON_MP_XLS.GR
					check = Format.checkFormat(8, value, ImporterGroupSubjectCON_MP_XLS.getPropSettings(prop));
				case 4 % ImporterGroupSubjectCON_MP_XLS.TEMPLATE
					check = Format.checkFormat(8, value, ImporterGroupSubjectCON_MP_XLS.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@Importer(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterGroupSubjectCON_MP_XLS:' 'WrongInput'], ...
					['BRAPH2' ':ImporterGroupSubjectCON_MP_XLS:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterGroupSubjectCON_MP_XLS.getPropTag(prop) ' (' ImporterGroupSubjectCON_MP_XLS.getFormatTag(ImporterGroupSubjectCON_MP_XLS.getPropFormat(prop)) ').'] ...
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
				case 11 % ImporterGroupSubjectCON_MP_XLS.GET_DIR
					directory = uigetdir('Select directory');
					if ischar(directory) && isfolder(directory)
					    im.set('DIRECTORY', directory);
					end
					value = im;
					
				case 13 % ImporterGroupSubjectCON_MP_XLS.GR
					rng_settings_ = rng(); rng(im.getPropSeed(13), 'twister')
					
					% creates empty Group
					gr = Group( ...
					    'SUB_CLASS', 'SubjectCON_MP', ...
					    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_MP') ...
					    );
					
					gr.lock('SUB_CLASS');
					
					directory = im.get('DIRECTORY');
					if isfolder(directory)
					    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading directory ...');
					
					    [~, name] = fileparts(directory);
					    gr.set( ...
					        'ID', name, ...
					        'LABEL', name, ...
					        'NOTES', ['Group loaded from ' directory] ...
					        );
					
					    try
					        braph2waitbar(wb, .15, 'Loading subject group ...')
					
					        files = [dir(fullfile(directory, '*.xlsx')); dir(fullfile(directory, '*.xls'))];
					        
					        if ~isempty(files)
					            % brain atlas
					            ba = im.get('BA');
					            if ba.get('BR_DICT').get('LENGTH') == 0
					                % adds the number of regions of the first file to the brain atlas
					                br_number = size(xlsread(fullfile(directory, files(1).name)), 1);
					                br_dict = ba.memorize('BR_DICT');
					                for j = 1:1:br_number
					                    br_dict.get('ADD', BrainRegion('ID', ['br' int2str(j)]))
					                end
					            end
					            
					            % determines the number of layers and the subjects
					            L = 0;
					            sub_ids = {};
					            for i = 1:1:length(files)
					                [~, sub_id_layer_no] = fileparts(files(i).name);
					                splits = regexp(sub_id_layer_no, '(.+)\.(\d+)', 'tokens');
					                sub_ids = [sub_ids, splits{1}{1}];
					                L = max(L, str2double(splits{1}{2}));
					            end
					            sub_ids = unique(sub_ids);
					            
					            % adds subjects
					            sub_dict = gr.memorize('SUB_DICT');
					            for i = 1:1:length(sub_ids)
					                braph2waitbar(wb, .15 + .85 * i / length(sub_ids), ['Loading subject ' num2str(i) ' of ' num2str(length(sub_ids)) ' ...'])
					
					                % read files
					                sub_id = sub_ids{i};
					                CON_MP = {};
					                for l = 1:1:L
					                    filename = fullfile(directory, [sub_id '.' int2str(l) '.xls']);
					                    if isfile(filename)
					                        CON = xlsread(filename);
					                    else
					                        CON = xlsread([filename 'x']);
					                    end
					                    if size(CON, 1) ~= ba.get('BR_DICT').get('LENGTH') || size(CON, 2) ~= ba.get('BR_DICT').get('LENGTH')
					                        error( ...
					                            ['BRAPH2' ':' class(im) ':' 'ErrorIO'], ...
					                            ['BRAPH2' ':' class(im) ':' 'ErrorIO' '\n' ...
					                            'The file ' sub_id ' should contain a matrix ' int2str(ba.get('BR_DICT').get('LENGTH')) 'x' int2str(ba.get('BR_DICT').get('LENGTH')) ', ' ...
					                            'while it is ' int2str(size(CON, 1)) 'x' int2str(size(CON, 2)) '.'] ...
					                            )
					                    end
					                    CON_MP = [CON_MP, CON];
					                end
					                
					                sub = SubjectCON_MP( ...
					                    'ID', sub_id, ...
					                    'BA', ba, ...
					                    'L', L, ...
					                    'CON_MP', CON_MP ...
					                );
					                sub_dict.get('ADD', sub);
					            end
					            
					            % variables of interest
					            vois = [];
					            if isfile([directory '.vois.xls'])
					                [~, ~, vois] = xlsread([directory '.vois.xls']);
					            elseif isfile([directory '.vois.xlsx'])
					                [~, ~, vois] = xlsread([directory '.vois.xlsx']);
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
					        end
					    catch e
					            braph2waitbar(wb, 'close')
					
					            rethrow(e)
					    end
					    
					    braph2waitbar(wb, 'close')
					else
					    error(['BRAPH2' ':ImporterGroupSubjectCON_MP_XLS:' 'ErrorIO'], ...
					        ['BRAPH2' ':ImporterGroupSubjectCON_MP_XLS:' 'ErrorIO' '\n' ...
					        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
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
				case 13 % ImporterGroupSubjectCON_MP_XLS.GR
					check = any(strcmp(value.get('SUB_CLASS'), subclasses('SubjectCON_MP', [], [], true)));
					
				otherwise
					if prop <= 9
						[check, msg] = checkValue@Importer(im, prop, value);
					end
			end
		end
	end
end
