classdef ImporterBrainSurfaceNV < Importer
	%ImporterBrainSurfaceNV imports a brain surface from a NV file.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% A Brain Surface Importer from NV Files (ImporterBrainSurfaceNV) imports a brain surface from a NV file.
	%
	% The list of ImporterBrainSurfaceNV properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the brain surface importer from NV.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the brain surface importer from NV.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the brain surface importer from NV.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the importe of the brain surface from NVr.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the brain surface importer from NV.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the brain surface importer from NV.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the brain surface importer from NV.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>FILE</strong> 	FILE (data, string) is the NV file from where to load the brain atlas.
	%  <strong>11</strong> <strong>GET_FILE</strong> 	GET_FILE (query, item) opens a dialog box to set the NV file where to save the brain atlas.
	%  <strong>12</strong> <strong>SURF</strong> 	SURF (result, item) is a brain surface.
	%
	% ImporterBrainSurfaceNV methods (constructor):
	%  ImporterBrainSurfaceNV - constructor
	%
	% ImporterBrainSurfaceNV methods:
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
	% ImporterBrainSurfaceNV methods (display):
	%  tostring - string with information about the brain surface importer from NV
	%  disp - displays information about the brain surface importer from NV
	%  tree - displays the tree of the brain surface importer from NV
	%
	% ImporterBrainSurfaceNV methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two brain surface importer from NV are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the brain surface importer from NV
	%
	% ImporterBrainSurfaceNV methods (save/load, Static):
	%  save - saves BRAPH2 brain surface importer from NV as b2 file
	%  load - loads a BRAPH2 brain surface importer from NV from a b2 file
	%
	% ImporterBrainSurfaceNV method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the brain surface importer from NV
	%
	% ImporterBrainSurfaceNV method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the brain surface importer from NV
	%
	% ImporterBrainSurfaceNV methods (inspection, Static):
	%  getClass - returns the class of the brain surface importer from NV
	%  getSubclasses - returns all subclasses of ImporterBrainSurfaceNV
	%  getProps - returns the property list of the brain surface importer from NV
	%  getPropNumber - returns the property number of the brain surface importer from NV
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
	% ImporterBrainSurfaceNV methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ImporterBrainSurfaceNV methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ImporterBrainSurfaceNV methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterBrainSurfaceNV methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ImporterBrainSurfaceNV; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ImporterBrainSurfaceNV constants</a>.
	%
	%
	% See also BrainSurface.
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
		
		SURF = 12; %CET: Computational Efficiency Trick
		SURF_TAG = 'SURF';
		SURF_CATEGORY = 5;
		SURF_FORMAT = 8;
	end
	methods % constructor
		function im = ImporterBrainSurfaceNV(varargin)
			%ImporterBrainSurfaceNV() creates a brain surface importer from NV.
			%
			% ImporterBrainSurfaceNV(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterBrainSurfaceNV(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ImporterBrainSurfaceNV properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the brain surface importer from NV.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the brain surface importer from NV.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the brain surface importer from NV.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the importe of the brain surface from NVr.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the brain surface importer from NV.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the brain surface importer from NV.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the brain surface importer from NV.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>FILE</strong> 	FILE (data, string) is the NV file from where to load the brain atlas.
			%  <strong>11</strong> <strong>GET_FILE</strong> 	GET_FILE (query, item) opens a dialog box to set the NV file where to save the brain atlas.
			%  <strong>12</strong> <strong>SURF</strong> 	SURF (result, item) is a brain surface.
			%
			% See also Category, Format.
			
			im = im@Importer(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the brain surface importer from NV.
			%
			% BUILD = ImporterBrainSurfaceNV.GETBUILD() returns the build of 'ImporterBrainSurfaceNV'.
			%
			% Alternative forms to call this method are:
			%  BUILD = IM.GETBUILD() returns the build of the brain surface importer from NV IM.
			%  BUILD = Element.GETBUILD(IM) returns the build of 'IM'.
			%  BUILD = Element.GETBUILD('ImporterBrainSurfaceNV') returns the build of 'ImporterBrainSurfaceNV'.
			%
			% Note that the Element.GETBUILD(IM) and Element.GETBUILD('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			
			build = 1;
		end
		function im_class = getClass()
			%GETCLASS returns the class of the brain surface importer from NV.
			%
			% CLASS = ImporterBrainSurfaceNV.GETCLASS() returns the class 'ImporterBrainSurfaceNV'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the brain surface importer from NV IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterBrainSurfaceNV') returns 'ImporterBrainSurfaceNV'.
			%
			% Note that the Element.GETCLASS(IM) and Element.GETCLASS('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			
			im_class = 'ImporterBrainSurfaceNV';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the brain surface importer from NV.
			%
			% LIST = ImporterBrainSurfaceNV.GETSUBCLASSES() returns all subclasses of 'ImporterBrainSurfaceNV'.
			%
			% Alternative forms to call this method are:
			%  LIST = IM.GETSUBCLASSES() returns all subclasses of the brain surface importer from NV IM.
			%  LIST = Element.GETSUBCLASSES(IM) returns all subclasses of 'IM'.
			%  LIST = Element.GETSUBCLASSES('ImporterBrainSurfaceNV') returns all subclasses of 'ImporterBrainSurfaceNV'.
			%
			% Note that the Element.GETSUBCLASSES(IM) and Element.GETSUBCLASSES('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ImporterBrainSurfaceNV' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of brain surface importer from NV.
			%
			% PROPS = ImporterBrainSurfaceNV.GETPROPS() returns the property list of brain surface importer from NV
			%  as a row vector.
			%
			% PROPS = ImporterBrainSurfaceNV.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the brain surface importer from NV IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterBrainSurfaceNV'[, CATEGORY]) returns the property list of 'ImporterBrainSurfaceNV'.
			%
			% Note that the Element.GETPROPS(IM) and Element.GETPROPS('ImporterBrainSurfaceNV')
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
			%GETPROPNUMBER returns the property number of brain surface importer from NV.
			%
			% N = ImporterBrainSurfaceNV.GETPROPNUMBER() returns the property number of brain surface importer from NV.
			%
			% N = ImporterBrainSurfaceNV.GETPROPNUMBER(CATEGORY) returns the property number of brain surface importer from NV
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER([CATEGORY]) returns the property number of the brain surface importer from NV IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterBrainSurfaceNV') returns the property number of 'ImporterBrainSurfaceNV'.
			%
			% Note that the Element.GETPROPNUMBER(IM) and Element.GETPROPNUMBER('ImporterBrainSurfaceNV')
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
			%EXISTSPROP checks whether property exists in brain surface importer from NV/error.
			%
			% CHECK = ImporterBrainSurfaceNV.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterBrainSurfaceNV, PROP) checks whether PROP exists for ImporterBrainSurfaceNV.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%  Element.EXISTSPROP(ImporterBrainSurfaceNV, PROP) throws error if PROP does NOT exist for ImporterBrainSurfaceNV.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IM) and Element.EXISTSPROP('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 12 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterBrainSurfaceNV:' 'WrongInput'], ...
					['BRAPH2' ':ImporterBrainSurfaceNV:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterBrainSurfaceNV.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in brain surface importer from NV/error.
			%
			% CHECK = ImporterBrainSurfaceNV.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterBrainSurfaceNV, TAG) checks whether TAG exists for ImporterBrainSurfaceNV.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%  Element.EXISTSTAG(ImporterBrainSurfaceNV, TAG) throws error if TAG does NOT exist for ImporterBrainSurfaceNV.
			%   Error id: [BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IM) and Element.EXISTSTAG('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'FILE'  'GET_FILE'  'SURF' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterBrainSurfaceNV:' 'WrongInput'], ...
					['BRAPH2' ':ImporterBrainSurfaceNV:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ImporterBrainSurfaceNV.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ImporterBrainSurfaceNV, POINTER) returns property number of POINTER of ImporterBrainSurfaceNV.
			%  PROPERTY = IM.GETPROPPROP(ImporterBrainSurfaceNV, POINTER) returns property number of POINTER of ImporterBrainSurfaceNV.
			%
			% Note that the Element.GETPROPPROP(IM) and Element.GETPROPPROP('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'FILE'  'GET_FILE'  'SURF' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(ImporterBrainSurfaceNV, POINTER) returns tag of POINTER of ImporterBrainSurfaceNV.
			%  TAG = IM.GETPROPTAG(ImporterBrainSurfaceNV, POINTER) returns tag of POINTER of ImporterBrainSurfaceNV.
			%
			% Note that the Element.GETPROPTAG(IM) and Element.GETPROPTAG('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				importerbrainsurfacenv_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'FILE'  'GET_FILE'  'SURF' };
				tag = importerbrainsurfacenv_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterBrainSurfaceNV, POINTER) returns category of POINTER of ImporterBrainSurfaceNV.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterBrainSurfaceNV, POINTER) returns category of POINTER of ImporterBrainSurfaceNV.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importerbrainsurfacenv_category_list = { 1  1  1  3  4  2  2  6  9  4  6  5 };
			prop_category = importerbrainsurfacenv_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(ImporterBrainSurfaceNV, POINTER) returns format of POINTER of ImporterBrainSurfaceNV.
			%  FORMAT = IM.GETPROPFORMAT(ImporterBrainSurfaceNV, POINTER) returns format of POINTER of ImporterBrainSurfaceNV.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importerbrainsurfacenv_format_list = { 2  2  2  8  2  2  2  2  4  2  8  8 };
			prop_format = importerbrainsurfacenv_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterBrainSurfaceNV, POINTER) returns description of POINTER of ImporterBrainSurfaceNV.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterBrainSurfaceNV, POINTER) returns description of POINTER of ImporterBrainSurfaceNV.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importerbrainsurfacenv_description_list = { 'ELCLASS (constant, string) is the class of the brain surface importer from NV.'  'NAME (constant, string) is the name of the brain surface importer from NV.'  'DESCRIPTION (constant, string) is the description of the brain surface importer from NV.'  'TEMPLATE (parameter, item) is the template of the importe of the brain surface from NVr.'  'ID (data, string) is a few-letter code for the brain surface importer from NV.'  'LABEL (metadata, string) is an extended label of the brain surface importer from NV.'  'NOTES (metadata, string) are some specific notes about the brain surface importer from NV.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'FILE (data, string) is the NV file from where to load the brain atlas.'  'GET_FILE (query, item) opens a dialog box to set the NV file where to save the brain atlas.'  'SURF (result, item) is a brain surface.' };
			prop_description = importerbrainsurfacenv_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterBrainSurfaceNV, POINTER) returns settings of POINTER of ImporterBrainSurfaceNV.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterBrainSurfaceNV, POINTER) returns settings of POINTER of ImporterBrainSurfaceNV.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ImporterBrainSurfaceNV.FILE
					prop_settings = Format.getFormatSettings(2);
				case 11 % ImporterBrainSurfaceNV.GET_FILE
					prop_settings = 'ImporterBrainSurfaceNV';
				case 12 % ImporterBrainSurfaceNV.SURF
					prop_settings = 'BrainSurface';
				case 4 % ImporterBrainSurfaceNV.TEMPLATE
					prop_settings = 'ImporterBrainSurfaceNV';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterBrainSurfaceNV.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterBrainSurfaceNV.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterBrainSurfaceNV, POINTER) returns the default value of POINTER of ImporterBrainSurfaceNV.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterBrainSurfaceNV, POINTER) returns the default value of POINTER of ImporterBrainSurfaceNV.
			%
			% Note that the Element.GETPROPDEFAULT(IM) and Element.GETPROPDEFAULT('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ImporterBrainSurfaceNV.FILE
					prop_default = 'human_ICBM152.nv';
				case 11 % ImporterBrainSurfaceNV.GET_FILE
					prop_default = Format.getFormatDefault(8, ImporterBrainSurfaceNV.getPropSettings(prop));
				case 12 % ImporterBrainSurfaceNV.SURF
					prop_default = Format.getFormatDefault(8, ImporterBrainSurfaceNV.getPropSettings(prop));
				case 1 % ImporterBrainSurfaceNV.ELCLASS
					prop_default = 'ImporterBrainSurfaceNV';
				case 2 % ImporterBrainSurfaceNV.NAME
					prop_default = 'Brain Surface Importer from NV Files';
				case 3 % ImporterBrainSurfaceNV.DESCRIPTION
					prop_default = 'A Brain Surface Importer from NV Files (ImporterBrainSurfaceNV) imports a brain surface from a NV file.';
				case 4 % ImporterBrainSurfaceNV.TEMPLATE
					prop_default = Format.getFormatDefault(8, ImporterBrainSurfaceNV.getPropSettings(prop));
				case 5 % ImporterBrainSurfaceNV.ID
					prop_default = 'ImporterBrainSurfaceNV ID';
				case 6 % ImporterBrainSurfaceNV.LABEL
					prop_default = 'ImporterBrainSurfaceNV label';
				case 7 % ImporterBrainSurfaceNV.NOTES
					prop_default = 'ImporterBrainSurfaceNV notes';
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterBrainSurfaceNV.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterBrainSurfaceNV.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterBrainSurfaceNV, POINTER) returns the conditioned default value of POINTER of ImporterBrainSurfaceNV.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterBrainSurfaceNV, POINTER) returns the conditioned default value of POINTER of ImporterBrainSurfaceNV.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IM) and Element.GETPROPDEFAULTCONDITIONED('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			prop_default = ImporterBrainSurfaceNV.conditioning(prop, ImporterBrainSurfaceNV.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ImporterBrainSurfaceNV, PROP, VALUE) checks VALUE format for PROP of ImporterBrainSurfaceNV.
			%  CHECK = IM.CHECKPROP(ImporterBrainSurfaceNV, PROP, VALUE) checks VALUE format for PROP of ImporterBrainSurfaceNV.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ImporterBrainSurfaceNV:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: BRAPH2:ImporterBrainSurfaceNV:WrongInput
			%  Element.CHECKPROP(ImporterBrainSurfaceNV, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterBrainSurfaceNV.
			%   Error id: BRAPH2:ImporterBrainSurfaceNV:WrongInput
			%  IM.CHECKPROP(ImporterBrainSurfaceNV, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterBrainSurfaceNV.
			%   Error id: BRAPH2:ImporterBrainSurfaceNV:WrongInput]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('ImporterBrainSurfaceNV')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ImporterBrainSurfaceNV.getPropProp(pointer);
			
			switch prop
				case 10 % ImporterBrainSurfaceNV.FILE
					check = Format.checkFormat(2, value, ImporterBrainSurfaceNV.getPropSettings(prop));
				case 11 % ImporterBrainSurfaceNV.GET_FILE
					check = Format.checkFormat(8, value, ImporterBrainSurfaceNV.getPropSettings(prop));
				case 12 % ImporterBrainSurfaceNV.SURF
					check = Format.checkFormat(8, value, ImporterBrainSurfaceNV.getPropSettings(prop));
				case 4 % ImporterBrainSurfaceNV.TEMPLATE
					check = Format.checkFormat(8, value, ImporterBrainSurfaceNV.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@Importer(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterBrainSurfaceNV:' 'WrongInput'], ...
					['BRAPH2' ':ImporterBrainSurfaceNV:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterBrainSurfaceNV.getPropTag(prop) ' (' ImporterBrainSurfaceNV.getFormatTag(ImporterBrainSurfaceNV.getPropFormat(prop)) ').'] ...
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
				case 11 % ImporterBrainSurfaceNV.GET_FILE
					[filename, filepath, filterindex] = uigetfile('*.nv', 'Select NV file');
					if filterindex
					    file = [filepath filename];
					    im.set('FILE', file);
					end
					value = im;
					
				case 12 % ImporterBrainSurfaceNV.SURF
					rng_settings_ = rng(); rng(im.getPropSeed(12), 'twister')
					
					% creates empty BrainSurface
					bs = BrainSurface();
					
					% analyzes file
					file = im.get('FILE');
					if ~isfile(file)
					    file = [fileparts(which('braph2')) filesep 'brainsurfs' filesep file];
					end
					
					if isfile(file)
						wb = braph2waitbar(im.get('WAITBAR'), .15, 'Reading brain surface file ...');
					    
					    fid = fopen(file);
					    vertex_number = fscanf(fid, '%f', 1);
					    coord = fscanf(fid, '%f', [3, vertex_number])';
					    tri_number = fscanf(fid, '%f', 1);
					    tri = fscanf(fid, '%d', [3, tri_number])';
					    fclose(fid);
					    
					    splits = split(file, filesep);
					    name = splits{end};
					    
					    bs.set('ID', name)
					    bs.set('VERTEX_NUMBER', vertex_number);
					    bs.set('COORDINATES', coord);
					    bs.set('TRIANGLES_NUMBER', tri_number);
					    bs.set('TRIANGLES', tri);
					    
						braph2waitbar(wb, 'close')
					else
					    error(['BRAPH2' ':ImporterBrainSurfaceNV:' 'CancelIO'], ...
					        ['BRAPH2' ':ImporterBrainSurfaceNV:' 'CancelIO' '\n' ...
					        'The prop FILE must be an existing file, but it is ''' file '''.'] ...
					        );    
					end
					
					value = bs;
					
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
