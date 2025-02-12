classdef ImporterBrainAtlasXLS < Importer
	%ImporterBrainAtlasXLS imports a brain atlas from an XLS/XLSX file.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% A Brain Atlas Importer from XLS/XLSX Files (ImporterBrainAtlasXLS) imports a 
	%  brain atlas from an XLS/XLSX file.
	% The XLS file consists of 6 columns and many rows. The first 4 rows: 
	%  BrainAtlas ID (row 1, column 1), BrainAtlas LABEL (row 2, column 1), 
	%  BrainAtlas NOTES (row 3, column 1), BrainSurface Name (row 4, column 1).
	%  And from row 5 to the end, the following columns: BrainRegion ID (column 1),
	%  BrainRegion LABEL (column 2), BrainRegions (column 3 to column 5; 
	%  coordinates x, y, z, one per column), and BrainRegion NOTES (column 6).
	%
	% The list of ImporterBrainAtlasXLS properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the brain atlas importer from XLS/XLSX.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the brain atlas importer from XLS/XLSX.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the brain atlas importer from XLS/XLSX.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the brain atlas importer from XLS/XLSX.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the brain atlas importer from XLS/XLSX.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the brain atlas importer from XLS/XLSX.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the brain atlas importer from XLS/XLSX.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>FILE</strong> 	FILE (data, string) is the XLS/XLSX file from where to load the brain atlas.
	%  <strong>11</strong> <strong>GET_FILE</strong> 	GET_FILE (query, item) opens a dialog box to get the XLS/XLSX file from where to load the brain atlas.
	%  <strong>12</strong> <strong>BA</strong> 	BA (result, item) is a brain atlas.
	%
	% ImporterBrainAtlasXLS methods (constructor):
	%  ImporterBrainAtlasXLS - constructor
	%
	% ImporterBrainAtlasXLS methods:
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
	% ImporterBrainAtlasXLS methods (display):
	%  tostring - string with information about the brain atlas importer from XLS/XLSX
	%  disp - displays information about the brain atlas importer from XLS/XLSX
	%  tree - displays the tree of the brain atlas importer from XLS/XLSX
	%
	% ImporterBrainAtlasXLS methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two brain atlas importer from XLS/XLSX are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the brain atlas importer from XLS/XLSX
	%
	% ImporterBrainAtlasXLS methods (save/load, Static):
	%  save - saves BRAPH2 brain atlas importer from XLS/XLSX as b2 file
	%  load - loads a BRAPH2 brain atlas importer from XLS/XLSX from a b2 file
	%
	% ImporterBrainAtlasXLS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the brain atlas importer from XLS/XLSX
	%
	% ImporterBrainAtlasXLS method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the brain atlas importer from XLS/XLSX
	%
	% ImporterBrainAtlasXLS methods (inspection, Static):
	%  getClass - returns the class of the brain atlas importer from XLS/XLSX
	%  getSubclasses - returns all subclasses of ImporterBrainAtlasXLS
	%  getProps - returns the property list of the brain atlas importer from XLS/XLSX
	%  getPropNumber - returns the property number of the brain atlas importer from XLS/XLSX
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
	% ImporterBrainAtlasXLS methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ImporterBrainAtlasXLS methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ImporterBrainAtlasXLS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterBrainAtlasXLS methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ImporterBrainAtlasXLS; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ImporterBrainAtlasXLS constants</a>.
	%
	%
	% See also BrainAtlas, ExporterBrainAtlasXLS.
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
		BA_CATEGORY = 5;
		BA_FORMAT = 8;
	end
	methods % constructor
		function im = ImporterBrainAtlasXLS(varargin)
			%ImporterBrainAtlasXLS() creates a brain atlas importer from XLS/XLSX.
			%
			% ImporterBrainAtlasXLS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterBrainAtlasXLS(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ImporterBrainAtlasXLS properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the brain atlas importer from XLS/XLSX.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the brain atlas importer from XLS/XLSX.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the brain atlas importer from XLS/XLSX.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the brain atlas importer from XLS/XLSX.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the brain atlas importer from XLS/XLSX.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the brain atlas importer from XLS/XLSX.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the brain atlas importer from XLS/XLSX.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>FILE</strong> 	FILE (data, string) is the XLS/XLSX file from where to load the brain atlas.
			%  <strong>11</strong> <strong>GET_FILE</strong> 	GET_FILE (query, item) opens a dialog box to get the XLS/XLSX file from where to load the brain atlas.
			%  <strong>12</strong> <strong>BA</strong> 	BA (result, item) is a brain atlas.
			%
			% See also Category, Format.
			
			im = im@Importer(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the brain atlas importer from XLS/XLSX.
			%
			% BUILD = ImporterBrainAtlasXLS.GETBUILD() returns the build of 'ImporterBrainAtlasXLS'.
			%
			% Alternative forms to call this method are:
			%  BUILD = IM.GETBUILD() returns the build of the brain atlas importer from XLS/XLSX IM.
			%  BUILD = Element.GETBUILD(IM) returns the build of 'IM'.
			%  BUILD = Element.GETBUILD('ImporterBrainAtlasXLS') returns the build of 'ImporterBrainAtlasXLS'.
			%
			% Note that the Element.GETBUILD(IM) and Element.GETBUILD('ImporterBrainAtlasXLS')
			%  are less computationally efficient.
			
			build = 1;
		end
		function im_class = getClass()
			%GETCLASS returns the class of the brain atlas importer from XLS/XLSX.
			%
			% CLASS = ImporterBrainAtlasXLS.GETCLASS() returns the class 'ImporterBrainAtlasXLS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the brain atlas importer from XLS/XLSX IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterBrainAtlasXLS') returns 'ImporterBrainAtlasXLS'.
			%
			% Note that the Element.GETCLASS(IM) and Element.GETCLASS('ImporterBrainAtlasXLS')
			%  are less computationally efficient.
			
			im_class = 'ImporterBrainAtlasXLS';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the brain atlas importer from XLS/XLSX.
			%
			% LIST = ImporterBrainAtlasXLS.GETSUBCLASSES() returns all subclasses of 'ImporterBrainAtlasXLS'.
			%
			% Alternative forms to call this method are:
			%  LIST = IM.GETSUBCLASSES() returns all subclasses of the brain atlas importer from XLS/XLSX IM.
			%  LIST = Element.GETSUBCLASSES(IM) returns all subclasses of 'IM'.
			%  LIST = Element.GETSUBCLASSES('ImporterBrainAtlasXLS') returns all subclasses of 'ImporterBrainAtlasXLS'.
			%
			% Note that the Element.GETSUBCLASSES(IM) and Element.GETSUBCLASSES('ImporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ImporterBrainAtlasXLS' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of brain atlas importer from XLS/XLSX.
			%
			% PROPS = ImporterBrainAtlasXLS.GETPROPS() returns the property list of brain atlas importer from XLS/XLSX
			%  as a row vector.
			%
			% PROPS = ImporterBrainAtlasXLS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the brain atlas importer from XLS/XLSX IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterBrainAtlasXLS'[, CATEGORY]) returns the property list of 'ImporterBrainAtlasXLS'.
			%
			% Note that the Element.GETPROPS(IM) and Element.GETPROPS('ImporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12];
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
					prop_list = [5 10];
				case 5 % Category.RESULT
					prop_list = 12;
				case 6 % Category.QUERY
					prop_list = [8 11];
				case 9 % Category.GUI
					prop_list = 9;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of brain atlas importer from XLS/XLSX.
			%
			% N = ImporterBrainAtlasXLS.GETPROPNUMBER() returns the property number of brain atlas importer from XLS/XLSX.
			%
			% N = ImporterBrainAtlasXLS.GETPROPNUMBER(CATEGORY) returns the property number of brain atlas importer from XLS/XLSX
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER([CATEGORY]) returns the property number of the brain atlas importer from XLS/XLSX IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterBrainAtlasXLS') returns the property number of 'ImporterBrainAtlasXLS'.
			%
			% Note that the Element.GETPROPNUMBER(IM) and Element.GETPROPNUMBER('ImporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 12;
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
					prop_number = 2;
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
			%EXISTSPROP checks whether property exists in brain atlas importer from XLS/XLSX/error.
			%
			% CHECK = ImporterBrainAtlasXLS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterBrainAtlasXLS, PROP) checks whether PROP exists for ImporterBrainAtlasXLS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%  Element.EXISTSPROP(ImporterBrainAtlasXLS, PROP) throws error if PROP does NOT exist for ImporterBrainAtlasXLS.
			%   Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IM) and Element.EXISTSPROP('ImporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 12 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterBrainAtlasXLS:' 'WrongInput'], ...
					['BRAPH2' ':ImporterBrainAtlasXLS:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterBrainAtlasXLS.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in brain atlas importer from XLS/XLSX/error.
			%
			% CHECK = ImporterBrainAtlasXLS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterBrainAtlasXLS, TAG) checks whether TAG exists for ImporterBrainAtlasXLS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%  Element.EXISTSTAG(ImporterBrainAtlasXLS, TAG) throws error if TAG does NOT exist for ImporterBrainAtlasXLS.
			%   Error id: [BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IM) and Element.EXISTSTAG('ImporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'FILE'  'GET_FILE'  'BA' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterBrainAtlasXLS:' 'WrongInput'], ...
					['BRAPH2' ':ImporterBrainAtlasXLS:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ImporterBrainAtlasXLS.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ImporterBrainAtlasXLS, POINTER) returns property number of POINTER of ImporterBrainAtlasXLS.
			%  PROPERTY = IM.GETPROPPROP(ImporterBrainAtlasXLS, POINTER) returns property number of POINTER of ImporterBrainAtlasXLS.
			%
			% Note that the Element.GETPROPPROP(IM) and Element.GETPROPPROP('ImporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'FILE'  'GET_FILE'  'BA' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(ImporterBrainAtlasXLS, POINTER) returns tag of POINTER of ImporterBrainAtlasXLS.
			%  TAG = IM.GETPROPTAG(ImporterBrainAtlasXLS, POINTER) returns tag of POINTER of ImporterBrainAtlasXLS.
			%
			% Note that the Element.GETPROPTAG(IM) and Element.GETPROPTAG('ImporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				importerbrainatlasxls_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'FILE'  'GET_FILE'  'BA' };
				tag = importerbrainatlasxls_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterBrainAtlasXLS, POINTER) returns category of POINTER of ImporterBrainAtlasXLS.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterBrainAtlasXLS, POINTER) returns category of POINTER of ImporterBrainAtlasXLS.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('ImporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterBrainAtlasXLS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importerbrainatlasxls_category_list = { 1  1  1  3  4  2  2  6  9  4  6  5 };
			prop_category = importerbrainatlasxls_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(ImporterBrainAtlasXLS, POINTER) returns format of POINTER of ImporterBrainAtlasXLS.
			%  FORMAT = IM.GETPROPFORMAT(ImporterBrainAtlasXLS, POINTER) returns format of POINTER of ImporterBrainAtlasXLS.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('ImporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterBrainAtlasXLS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importerbrainatlasxls_format_list = { 2  2  2  8  2  2  2  2  4  2  8  8 };
			prop_format = importerbrainatlasxls_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterBrainAtlasXLS, POINTER) returns description of POINTER of ImporterBrainAtlasXLS.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterBrainAtlasXLS, POINTER) returns description of POINTER of ImporterBrainAtlasXLS.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('ImporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterBrainAtlasXLS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importerbrainatlasxls_description_list = { 'ELCLASS (constant, string) is the class of the brain atlas importer from XLS/XLSX.'  'NAME (constant, string) is the name of the brain atlas importer from XLS/XLSX.'  'DESCRIPTION (constant, string) is the description of the brain atlas importer from XLS/XLSX.'  'TEMPLATE (parameter, item) is the template of the brain atlas importer from XLS/XLSX.'  'ID (data, string) is a few-letter code for the brain atlas importer from XLS/XLSX.'  'LABEL (metadata, string) is an extended label of the brain atlas importer from XLS/XLSX.'  'NOTES (metadata, string) are some specific notes about the brain atlas importer from XLS/XLSX.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'FILE (data, string) is the XLS/XLSX file from where to load the brain atlas.'  'GET_FILE (query, item) opens a dialog box to get the XLS/XLSX file from where to load the brain atlas.'  'BA (result, item) is a brain atlas.' };
			prop_description = importerbrainatlasxls_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterBrainAtlasXLS, POINTER) returns settings of POINTER of ImporterBrainAtlasXLS.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterBrainAtlasXLS, POINTER) returns settings of POINTER of ImporterBrainAtlasXLS.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('ImporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ImporterBrainAtlasXLS.FILE
					prop_settings = Format.getFormatSettings(2);
				case 11 % ImporterBrainAtlasXLS.GET_FILE
					prop_settings = 'ImporterBrainAtlasXLS';
				case 12 % ImporterBrainAtlasXLS.BA
					prop_settings = 'BrainAtlas';
				case 4 % ImporterBrainAtlasXLS.TEMPLATE
					prop_settings = 'ImporterBrainAtlasXLS';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterBrainAtlasXLS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterBrainAtlasXLS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterBrainAtlasXLS, POINTER) returns the default value of POINTER of ImporterBrainAtlasXLS.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterBrainAtlasXLS, POINTER) returns the default value of POINTER of ImporterBrainAtlasXLS.
			%
			% Note that the Element.GETPROPDEFAULT(IM) and Element.GETPROPDEFAULT('ImporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ImporterBrainAtlasXLS.FILE
					prop_default = 'desikan_atlas.xlsx';
				case 11 % ImporterBrainAtlasXLS.GET_FILE
					prop_default = Format.getFormatDefault(8, ImporterBrainAtlasXLS.getPropSettings(prop));
				case 12 % ImporterBrainAtlasXLS.BA
					prop_default = BrainAtlas();
				case 1 % ImporterBrainAtlasXLS.ELCLASS
					prop_default = 'ImporterBrainAtlasXLS';
				case 2 % ImporterBrainAtlasXLS.NAME
					prop_default = 'Brain Atlas Importer from XLS/XLSX Files';
				case 3 % ImporterBrainAtlasXLS.DESCRIPTION
					prop_default = 'A Brain Atlas Importer from XLS/XLSX Files (ImporterBrainAtlasXLS) imports a brain atlas from an XLS/XLSX file. The XLS file consists of 6 columns and many rows. The first 4 rows: BrainAtlas ID (row 1, column 1), BrainAtlas LABEL (row 2, column 1), BrainAtlas NOTES (row 3, column 1), BrainSurface Name (row 4, column 1). And from row 5 to the end, the following columns: BrainRegion ID (column 1), BrainRegion LABEL (column 2), BrainRegions (column 3 to column 5; coordinates x, y, z, one per column), and BrainRegion NOTES (column 6).';
				case 4 % ImporterBrainAtlasXLS.TEMPLATE
					prop_default = Format.getFormatDefault(8, ImporterBrainAtlasXLS.getPropSettings(prop));
				case 5 % ImporterBrainAtlasXLS.ID
					prop_default = 'ImporterBrainAtlasXLS ID';
				case 6 % ImporterBrainAtlasXLS.LABEL
					prop_default = 'ImporterBrainAtlasXLS label';
				case 7 % ImporterBrainAtlasXLS.NOTES
					prop_default = 'ImporterBrainAtlasXLS notes';
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterBrainAtlasXLS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterBrainAtlasXLS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterBrainAtlasXLS, POINTER) returns the conditioned default value of POINTER of ImporterBrainAtlasXLS.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterBrainAtlasXLS, POINTER) returns the conditioned default value of POINTER of ImporterBrainAtlasXLS.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IM) and Element.GETPROPDEFAULTCONDITIONED('ImporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ImporterBrainAtlasXLS.getPropProp(pointer);
			
			prop_default = ImporterBrainAtlasXLS.conditioning(prop, ImporterBrainAtlasXLS.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ImporterBrainAtlasXLS, PROP, VALUE) checks VALUE format for PROP of ImporterBrainAtlasXLS.
			%  CHECK = IM.CHECKPROP(ImporterBrainAtlasXLS, PROP, VALUE) checks VALUE format for PROP of ImporterBrainAtlasXLS.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ImporterBrainAtlasXLS:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: BRAPH2:ImporterBrainAtlasXLS:WrongInput
			%  Element.CHECKPROP(ImporterBrainAtlasXLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterBrainAtlasXLS.
			%   Error id: BRAPH2:ImporterBrainAtlasXLS:WrongInput
			%  IM.CHECKPROP(ImporterBrainAtlasXLS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterBrainAtlasXLS.
			%   Error id: BRAPH2:ImporterBrainAtlasXLS:WrongInput]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('ImporterBrainAtlasXLS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ImporterBrainAtlasXLS.getPropProp(pointer);
			
			switch prop
				case 10 % ImporterBrainAtlasXLS.FILE
					check = Format.checkFormat(2, value, ImporterBrainAtlasXLS.getPropSettings(prop));
				case 11 % ImporterBrainAtlasXLS.GET_FILE
					check = Format.checkFormat(8, value, ImporterBrainAtlasXLS.getPropSettings(prop));
				case 12 % ImporterBrainAtlasXLS.BA
					check = Format.checkFormat(8, value, ImporterBrainAtlasXLS.getPropSettings(prop));
				case 4 % ImporterBrainAtlasXLS.TEMPLATE
					check = Format.checkFormat(8, value, ImporterBrainAtlasXLS.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@Importer(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterBrainAtlasXLS:' 'WrongInput'], ...
					['BRAPH2' ':ImporterBrainAtlasXLS:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterBrainAtlasXLS.getPropTag(prop) ' (' ImporterBrainAtlasXLS.getFormatTag(ImporterBrainAtlasXLS.getPropFormat(prop)) ').'] ...
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
				case 11 % ImporterBrainAtlasXLS.GET_FILE
					[filename, filepath, filterindex] = uigetfile({'*.xlsx';'*.xls'}, 'Select Excel file');
					if filterindex
					    file = [filepath filename];
					    im.set('FILE', file);
					end
					value = im;
					
				case 12 % ImporterBrainAtlasXLS.BA
					rng_settings_ = rng(); rng(im.getPropSeed(12), 'twister')
					
					% creates empty BrainAtlas
					ba = BrainAtlas();
					
					% analyzes file
					file = im.get('FILE');
					if ~isfile(file)
					    file = [fileparts(which(BRAPH2.LAUNCHER)) filesep 'atlases' filesep file];
					end
					
					if isfile(file)
						wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading File ...');
					
					    try
					        [~, ~, raw] = xlsread(file);
					        
					        % adds props
					        braph2waitbar(wb, .15, 'Loading brain atlas file ...');
					        
					        ba.set( ...
					            'ID', raw{1, 1}, ...
					            'LABEL', raw{2, 1}, ...
					            'NOTES', raw{3, 1} ...
					            );
					        
					        idict = ba.get('BR_DICT');
					        
					        % adds brain regions
					        braph2waitbar(wb, .25, 'Extracting brain regions ...')
					        
					        for i = 5:1:size(raw, 1)
					            braph2waitbar(wb, .25 + .75 * (i - 4) / (size(raw, 1) - 4), ['Loading brain region ' num2str(i - 4) ' of ' num2str(size(raw, 1) - 4) ' ...'])
					            
					            br = BrainRegion( ...
					                'ID', raw{i, 1}, ...
					                'LABEL', raw{i, 2}, ...
					                'X', raw{i, 3}, ...
					                'Y', raw{i, 4}, ...
					                'Z', raw{i, 5}, ...
					                'NOTES', raw{i, 6} ...
					                );
					            idict.get('ADD', br);
					        end
					        ba.set('BR_DICT', idict);
					    catch e
					        braph2waitbar(wb, 'close')
					
					        rethrow(e)
					    end
					    
					    braph2waitbar(wb, 'close')
					else
					    error(['BRAPH2' ':ImporterBrainAtlasXLS:' 'CancelIO'], ...
					        ['BRAPH2' ':ImporterBrainAtlasXLS:' 'CancelIO' '\n' ...
					        'The prop FILE must be an existing file, but it is ''' file '''.'] ...
					        );
					end
					
					value = ba;
					
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
end
