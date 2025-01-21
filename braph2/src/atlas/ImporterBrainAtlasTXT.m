classdef ImporterBrainAtlasTXT < Importer
	%ImporterBrainAtlasTXT imports a brain atlas from a TXT file.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% A Brain Atlas Importer from TXT Files (ImporterBrainAtlasTXT) imports a 
	%  brain atlas from a TXT file.
	% The TXT file consists of 6 columns and many rows. The first 4 rows: 
	%  BrainAtlas ID (row 1, column 1), BrainAtlas LABEL (row 2, column 1), 
	%  BrainAtlas NOTES (row 3, column 1), BrainSurface Name (row 4, column 1).
	%  And from row 5 to the end, the following columns: BrainRegion ID (column 1),
	%  BrainRegion LABEL (column 2), BrainRegions (column 3 to column 5; 
	%  coordinates x, y, z, one per column), and BrainRegion NOTES (column 6).
	%
	% The list of ImporterBrainAtlasTXT properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the brain atlas importer from TXT.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the brain atlas importer from TXT.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the brain atlas importer from TXT.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the brain atlas importer from TXT.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the brain atlas importer from TXT.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the brain atlas importer from TXT.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the brain atlas importer from TXT.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>FILE</strong> 	FILE (data, string) is the TXT file from where to load the brain atlas.
	%  <strong>11</strong> <strong>GET_FILE</strong> 	GET_FILE (query, item) opens a dialog box to get the TXT file from where to load the brain atlas.
	%  <strong>12</strong> <strong>BA</strong> 	BA (result, item) is a brain atlas.
	%
	% ImporterBrainAtlasTXT methods (constructor):
	%  ImporterBrainAtlasTXT - constructor
	%
	% ImporterBrainAtlasTXT methods:
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
	% ImporterBrainAtlasTXT methods (display):
	%  tostring - string with information about the brain atlas importer from TXT
	%  disp - displays information about the brain atlas importer from TXT
	%  tree - displays the tree of the brain atlas importer from TXT
	%
	% ImporterBrainAtlasTXT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two brain atlas importer from TXT are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the brain atlas importer from TXT
	%
	% ImporterBrainAtlasTXT methods (save/load, Static):
	%  save - saves BRAPH2 brain atlas importer from TXT as b2 file
	%  load - loads a BRAPH2 brain atlas importer from TXT from a b2 file
	%
	% ImporterBrainAtlasTXT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the brain atlas importer from TXT
	%
	% ImporterBrainAtlasTXT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the brain atlas importer from TXT
	%
	% ImporterBrainAtlasTXT methods (inspection, Static):
	%  getClass - returns the class of the brain atlas importer from TXT
	%  getSubclasses - returns all subclasses of ImporterBrainAtlasTXT
	%  getProps - returns the property list of the brain atlas importer from TXT
	%  getPropNumber - returns the property number of the brain atlas importer from TXT
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
	% ImporterBrainAtlasTXT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ImporterBrainAtlasTXT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ImporterBrainAtlasTXT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterBrainAtlasTXT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ImporterBrainAtlasTXT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ImporterBrainAtlasTXT constants</a>.
	%
	%
	% See also BrainAtlas, ExporterBrainAtlasTXT.
	%
	% BUILD BRAPH2 6 class_name 1
	
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
		function im = ImporterBrainAtlasTXT(varargin)
			%ImporterBrainAtlasTXT() creates a brain atlas importer from TXT.
			%
			% ImporterBrainAtlasTXT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterBrainAtlasTXT(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ImporterBrainAtlasTXT properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the brain atlas importer from TXT.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the brain atlas importer from TXT.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the brain atlas importer from TXT.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the brain atlas importer from TXT.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the brain atlas importer from TXT.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the brain atlas importer from TXT.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the brain atlas importer from TXT.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>FILE</strong> 	FILE (data, string) is the TXT file from where to load the brain atlas.
			%  <strong>11</strong> <strong>GET_FILE</strong> 	GET_FILE (query, item) opens a dialog box to get the TXT file from where to load the brain atlas.
			%  <strong>12</strong> <strong>BA</strong> 	BA (result, item) is a brain atlas.
			%
			% See also Category, Format.
			
			im = im@Importer(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the brain atlas importer from TXT.
			%
			% BUILD = ImporterBrainAtlasTXT.GETBUILD() returns the build of 'ImporterBrainAtlasTXT'.
			%
			% Alternative forms to call this method are:
			%  BUILD = IM.GETBUILD() returns the build of the brain atlas importer from TXT IM.
			%  BUILD = Element.GETBUILD(IM) returns the build of 'IM'.
			%  BUILD = Element.GETBUILD('ImporterBrainAtlasTXT') returns the build of 'ImporterBrainAtlasTXT'.
			%
			% Note that the Element.GETBUILD(IM) and Element.GETBUILD('ImporterBrainAtlasTXT')
			%  are less computationally efficient.
			
			build = 1;
		end
		function im_class = getClass()
			%GETCLASS returns the class of the brain atlas importer from TXT.
			%
			% CLASS = ImporterBrainAtlasTXT.GETCLASS() returns the class 'ImporterBrainAtlasTXT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the brain atlas importer from TXT IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterBrainAtlasTXT') returns 'ImporterBrainAtlasTXT'.
			%
			% Note that the Element.GETCLASS(IM) and Element.GETCLASS('ImporterBrainAtlasTXT')
			%  are less computationally efficient.
			
			im_class = 'ImporterBrainAtlasTXT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the brain atlas importer from TXT.
			%
			% LIST = ImporterBrainAtlasTXT.GETSUBCLASSES() returns all subclasses of 'ImporterBrainAtlasTXT'.
			%
			% Alternative forms to call this method are:
			%  LIST = IM.GETSUBCLASSES() returns all subclasses of the brain atlas importer from TXT IM.
			%  LIST = Element.GETSUBCLASSES(IM) returns all subclasses of 'IM'.
			%  LIST = Element.GETSUBCLASSES('ImporterBrainAtlasTXT') returns all subclasses of 'ImporterBrainAtlasTXT'.
			%
			% Note that the Element.GETSUBCLASSES(IM) and Element.GETSUBCLASSES('ImporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ImporterBrainAtlasTXT' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of brain atlas importer from TXT.
			%
			% PROPS = ImporterBrainAtlasTXT.GETPROPS() returns the property list of brain atlas importer from TXT
			%  as a row vector.
			%
			% PROPS = ImporterBrainAtlasTXT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the brain atlas importer from TXT IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterBrainAtlasTXT'[, CATEGORY]) returns the property list of 'ImporterBrainAtlasTXT'.
			%
			% Note that the Element.GETPROPS(IM) and Element.GETPROPS('ImporterBrainAtlasTXT')
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
			%GETPROPNUMBER returns the property number of brain atlas importer from TXT.
			%
			% N = ImporterBrainAtlasTXT.GETPROPNUMBER() returns the property number of brain atlas importer from TXT.
			%
			% N = ImporterBrainAtlasTXT.GETPROPNUMBER(CATEGORY) returns the property number of brain atlas importer from TXT
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER([CATEGORY]) returns the property number of the brain atlas importer from TXT IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterBrainAtlasTXT') returns the property number of 'ImporterBrainAtlasTXT'.
			%
			% Note that the Element.GETPROPNUMBER(IM) and Element.GETPROPNUMBER('ImporterBrainAtlasTXT')
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
			%EXISTSPROP checks whether property exists in brain atlas importer from TXT/error.
			%
			% CHECK = ImporterBrainAtlasTXT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterBrainAtlasTXT, PROP) checks whether PROP exists for ImporterBrainAtlasTXT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterBrainAtlasTXT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainAtlasTXT:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainAtlasTXT:WrongInput]
			%  Element.EXISTSPROP(ImporterBrainAtlasTXT, PROP) throws error if PROP does NOT exist for ImporterBrainAtlasTXT.
			%   Error id: [BRAPH2:ImporterBrainAtlasTXT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IM) and Element.EXISTSPROP('ImporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 12 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterBrainAtlasTXT:' 'WrongInput'], ...
					['BRAPH2' ':ImporterBrainAtlasTXT:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterBrainAtlasTXT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in brain atlas importer from TXT/error.
			%
			% CHECK = ImporterBrainAtlasTXT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterBrainAtlasTXT, TAG) checks whether TAG exists for ImporterBrainAtlasTXT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterBrainAtlasTXT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainAtlasTXT:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainAtlasTXT:WrongInput]
			%  Element.EXISTSTAG(ImporterBrainAtlasTXT, TAG) throws error if TAG does NOT exist for ImporterBrainAtlasTXT.
			%   Error id: [BRAPH2:ImporterBrainAtlasTXT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IM) and Element.EXISTSTAG('ImporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'FILE'  'GET_FILE'  'BA' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterBrainAtlasTXT:' 'WrongInput'], ...
					['BRAPH2' ':ImporterBrainAtlasTXT:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ImporterBrainAtlasTXT.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ImporterBrainAtlasTXT, POINTER) returns property number of POINTER of ImporterBrainAtlasTXT.
			%  PROPERTY = IM.GETPROPPROP(ImporterBrainAtlasTXT, POINTER) returns property number of POINTER of ImporterBrainAtlasTXT.
			%
			% Note that the Element.GETPROPPROP(IM) and Element.GETPROPPROP('ImporterBrainAtlasTXT')
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
			%  TAG = Element.GETPROPTAG(ImporterBrainAtlasTXT, POINTER) returns tag of POINTER of ImporterBrainAtlasTXT.
			%  TAG = IM.GETPROPTAG(ImporterBrainAtlasTXT, POINTER) returns tag of POINTER of ImporterBrainAtlasTXT.
			%
			% Note that the Element.GETPROPTAG(IM) and Element.GETPROPTAG('ImporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				importerbrainatlastxt_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'FILE'  'GET_FILE'  'BA' };
				tag = importerbrainatlastxt_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterBrainAtlasTXT, POINTER) returns category of POINTER of ImporterBrainAtlasTXT.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterBrainAtlasTXT, POINTER) returns category of POINTER of ImporterBrainAtlasTXT.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('ImporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterBrainAtlasTXT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importerbrainatlastxt_category_list = { 1  1  1  3  4  2  2  6  9  4  6  5 };
			prop_category = importerbrainatlastxt_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(ImporterBrainAtlasTXT, POINTER) returns format of POINTER of ImporterBrainAtlasTXT.
			%  FORMAT = IM.GETPROPFORMAT(ImporterBrainAtlasTXT, POINTER) returns format of POINTER of ImporterBrainAtlasTXT.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('ImporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterBrainAtlasTXT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importerbrainatlastxt_format_list = { 2  2  2  8  2  2  2  2  4  2  8  8 };
			prop_format = importerbrainatlastxt_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterBrainAtlasTXT, POINTER) returns description of POINTER of ImporterBrainAtlasTXT.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterBrainAtlasTXT, POINTER) returns description of POINTER of ImporterBrainAtlasTXT.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('ImporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterBrainAtlasTXT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importerbrainatlastxt_description_list = { 'ELCLASS (constant, string) is the class of the brain atlas importer from TXT.'  'NAME (constant, string) is the name of the brain atlas importer from TXT.'  'DESCRIPTION (constant, string) is the description of the brain atlas importer from TXT.'  'TEMPLATE (parameter, item) is the template of the brain atlas importer from TXT.'  'ID (data, string) is a few-letter code for the brain atlas importer from TXT.'  'LABEL (metadata, string) is an extended label of the brain atlas importer from TXT.'  'NOTES (metadata, string) are some specific notes about the brain atlas importer from TXT.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'FILE (data, string) is the TXT file from where to load the brain atlas.'  'GET_FILE (query, item) opens a dialog box to get the TXT file from where to load the brain atlas.'  'BA (result, item) is a brain atlas.' };
			prop_description = importerbrainatlastxt_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterBrainAtlasTXT, POINTER) returns settings of POINTER of ImporterBrainAtlasTXT.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterBrainAtlasTXT, POINTER) returns settings of POINTER of ImporterBrainAtlasTXT.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('ImporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterBrainAtlasTXT.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ImporterBrainAtlasTXT.FILE
					prop_settings = Format.getFormatSettings(2);
				case 11 % ImporterBrainAtlasTXT.GET_FILE
					prop_settings = 'ImporterBrainAtlasTXT';
				case 12 % ImporterBrainAtlasTXT.BA
					prop_settings = 'BrainAtlas';
				case 4 % ImporterBrainAtlasTXT.TEMPLATE
					prop_settings = 'ImporterBrainAtlasTXT';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterBrainAtlasTXT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterBrainAtlasTXT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterBrainAtlasTXT, POINTER) returns the default value of POINTER of ImporterBrainAtlasTXT.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterBrainAtlasTXT, POINTER) returns the default value of POINTER of ImporterBrainAtlasTXT.
			%
			% Note that the Element.GETPROPDEFAULT(IM) and Element.GETPROPDEFAULT('ImporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterBrainAtlasTXT.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ImporterBrainAtlasTXT.FILE
					prop_default = 'desikan_atlas.txt';
				case 11 % ImporterBrainAtlasTXT.GET_FILE
					prop_default = Format.getFormatDefault(8, ImporterBrainAtlasTXT.getPropSettings(prop));
				case 12 % ImporterBrainAtlasTXT.BA
					prop_default = BrainAtlas();
				case 1 % ImporterBrainAtlasTXT.ELCLASS
					prop_default = 'ImporterBrainAtlasTXT';
				case 2 % ImporterBrainAtlasTXT.NAME
					prop_default = 'Brain Atlas Importer from TXT Files';
				case 3 % ImporterBrainAtlasTXT.DESCRIPTION
					prop_default = 'A Brain Atlas Importer from TXT Files (ImporterBrainAtlasTXT) imports a brain atlas from a TXT file. The TXT file consists of 6 columns and many rows. The first 4 rows: BrainAtlas ID (row 1, column 1), BrainAtlas LABEL (row 2, column 1), BrainAtlas NOTES (row 3, column 1), BrainSurface Name (row 4, column 1). And from row 5 to the end, the following columns: BrainRegion ID (column 1), BrainRegion LABEL (column 2), BrainRegions (column 3 to column 5; coordinates x, y, z, one per column), and BrainRegion NOTES (column 6).';
				case 4 % ImporterBrainAtlasTXT.TEMPLATE
					prop_default = Format.getFormatDefault(8, ImporterBrainAtlasTXT.getPropSettings(prop));
				case 5 % ImporterBrainAtlasTXT.ID
					prop_default = 'ImporterBrainAtlasTXT ID';
				case 6 % ImporterBrainAtlasTXT.LABEL
					prop_default = 'ImporterBrainAtlasTXT label';
				case 7 % ImporterBrainAtlasTXT.NOTES
					prop_default = 'ImporterBrainAtlasTXT notes';
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterBrainAtlasTXT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterBrainAtlasTXT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterBrainAtlasTXT, POINTER) returns the conditioned default value of POINTER of ImporterBrainAtlasTXT.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterBrainAtlasTXT, POINTER) returns the conditioned default value of POINTER of ImporterBrainAtlasTXT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IM) and Element.GETPROPDEFAULTCONDITIONED('ImporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ImporterBrainAtlasTXT.getPropProp(pointer);
			
			prop_default = ImporterBrainAtlasTXT.conditioning(prop, ImporterBrainAtlasTXT.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ImporterBrainAtlasTXT, PROP, VALUE) checks VALUE format for PROP of ImporterBrainAtlasTXT.
			%  CHECK = IM.CHECKPROP(ImporterBrainAtlasTXT, PROP, VALUE) checks VALUE format for PROP of ImporterBrainAtlasTXT.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ImporterBrainAtlasTXT:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: BRAPH2:ImporterBrainAtlasTXT:WrongInput
			%  Element.CHECKPROP(ImporterBrainAtlasTXT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterBrainAtlasTXT.
			%   Error id: BRAPH2:ImporterBrainAtlasTXT:WrongInput
			%  IM.CHECKPROP(ImporterBrainAtlasTXT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterBrainAtlasTXT.
			%   Error id: BRAPH2:ImporterBrainAtlasTXT:WrongInput]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('ImporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ImporterBrainAtlasTXT.getPropProp(pointer);
			
			switch prop
				case 10 % ImporterBrainAtlasTXT.FILE
					check = Format.checkFormat(2, value, ImporterBrainAtlasTXT.getPropSettings(prop));
				case 11 % ImporterBrainAtlasTXT.GET_FILE
					check = Format.checkFormat(8, value, ImporterBrainAtlasTXT.getPropSettings(prop));
				case 12 % ImporterBrainAtlasTXT.BA
					check = Format.checkFormat(8, value, ImporterBrainAtlasTXT.getPropSettings(prop));
				case 4 % ImporterBrainAtlasTXT.TEMPLATE
					check = Format.checkFormat(8, value, ImporterBrainAtlasTXT.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@Importer(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterBrainAtlasTXT:' 'WrongInput'], ...
					['BRAPH2' ':ImporterBrainAtlasTXT:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterBrainAtlasTXT.getPropTag(prop) ' (' ImporterBrainAtlasTXT.getFormatTag(ImporterBrainAtlasTXT.getPropFormat(prop)) ').'] ...
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
				case 11 % ImporterBrainAtlasTXT.GET_FILE
					[filename, filepath, filterindex] = uigetfile('*.txt', 'Select TXT file');
					if filterindex
					    file = [filepath filename];
					    im.set('FILE', file);
					end
					value = im;
					
				case 12 % ImporterBrainAtlasTXT.BA
					rng_settings_ = rng(); rng(im.getPropSeed(12), 'twister')
					
					% creates empty BrainAtlas
					ba = BrainAtlas();
					
					% analyzes file
					file = im.get('FILE');
					if ~isfile(file)
					    file = [fileparts(which('braph2')) filesep 'atlases' filesep file];
					end
					
					if isfile(file)
						wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading brain atlas file ...');
					
					    try
					        raw = textread(file, '%s', 'delimiter', '	', 'whitespace', '');
					        raw = raw(~cellfun('isempty', raw));  % remove empty cells
					        
					        % adds props
					        braph2waitbar(wb, .15, 'Loading brain atlas file ...')
					        
					        ba.set( ...
					            'ID', raw{1, 1}, ...
					            'LABEL', raw{2, 1}, ...
					            'NOTES', raw{3, 1} ...
					            );
					        
					        idict = ba.get('BR_DICT');
					        
					        % adds brain regions
					        braph2waitbar(wb, .25, 'Extracting brain regions ...')
					        
					        for i = 4:6:size(raw, 1)
					            braph2waitbar(wb, .25 + .75 * i / size(raw, 1), ['Loading brain region ' num2str((i - 4) / 6 + 1) ' of ' num2str((size(raw, 1) - 3) / 6) ' ...'])
					            
					            br = BrainRegion( ...
					                'ID', char(raw{i, 1}), ...
					                'LABEL', char(raw{i+1, 1}), ...
					                'X', str2double(raw{i+2, 1}), ...
					                'Y', str2double(raw{i+3, 1}), ...
					                'Z', str2double(raw{i+4, 1}), ...
					                'NOTES', char(raw{i+5, 1}) ...
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
