classdef ExporterBrainAtlasTXT < Exporter
	%ExporterBrainAtlasTXT exports a brain atlas to a TXT file.
	% It is a subclass of <a href="matlab:help Exporter">Exporter</a>.
	%
	% A Brain Atlas Exporter in TXT Files (ExporterBrainAtlasTXT) exports a brain atlas to a TXT file.
	%
	% The list of ExporterBrainAtlasTXT properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the brain atlas exporter in TXT.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the brain atlas exporter in TXT.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the brain atlas exporter in TXT.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the brain atlas exporter in TXT.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the brain atlas exporter in TXT.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the brain atlas exporter in TXT.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the brain atlas exporter in TXT.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>BA</strong> 	BA (data, item) is a brain atlas.
	%  <strong>11</strong> <strong>FILE</strong> 	FILE (data, string) is the TXT file where to save the brain atlas.
	%  <strong>12</strong> <strong>PUT_FILE</strong> 	PUT_FILE (query, item) opens a dialog box to set the TXT file where to save the brain atlas.
	%  <strong>13</strong> <strong>SAVE</strong> 	SAVE (result, empty) saves the brain atlas in the selected TXT file.
	%
	% ExporterBrainAtlasTXT methods (constructor):
	%  ExporterBrainAtlasTXT - constructor
	%
	% ExporterBrainAtlasTXT methods:
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
	% ExporterBrainAtlasTXT methods (display):
	%  tostring - string with information about the brain atlas exporter in TXT
	%  disp - displays information about the brain atlas exporter in TXT
	%  tree - displays the tree of the brain atlas exporter in TXT
	%
	% ExporterBrainAtlasTXT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two brain atlas exporter in TXT are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the brain atlas exporter in TXT
	%
	% ExporterBrainAtlasTXT methods (save/load, Static):
	%  save - saves BRAPH2 brain atlas exporter in TXT as b2 file
	%  load - loads a BRAPH2 brain atlas exporter in TXT from a b2 file
	%
	% ExporterBrainAtlasTXT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the brain atlas exporter in TXT
	%
	% ExporterBrainAtlasTXT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the brain atlas exporter in TXT
	%
	% ExporterBrainAtlasTXT methods (inspection, Static):
	%  getClass - returns the class of the brain atlas exporter in TXT
	%  getSubclasses - returns all subclasses of ExporterBrainAtlasTXT
	%  getProps - returns the property list of the brain atlas exporter in TXT
	%  getPropNumber - returns the property number of the brain atlas exporter in TXT
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
	% ExporterBrainAtlasTXT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ExporterBrainAtlasTXT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ExporterBrainAtlasTXT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ExporterBrainAtlasTXT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ExporterBrainAtlasTXT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ExporterBrainAtlasTXT constants</a>.
	%
	%
	% See also BrainAtlas, ImporterBrainAtlasTXT.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		BA = 10; %CET: Computational Efficiency Trick
		BA_TAG = 'BA';
		BA_CATEGORY = 4;
		BA_FORMAT = 8;
		
		FILE = 11; %CET: Computational Efficiency Trick
		FILE_TAG = 'FILE';
		FILE_CATEGORY = 4;
		FILE_FORMAT = 2;
		
		PUT_FILE = 12; %CET: Computational Efficiency Trick
		PUT_FILE_TAG = 'PUT_FILE';
		PUT_FILE_CATEGORY = 6;
		PUT_FILE_FORMAT = 8;
		
		SAVE = 13; %CET: Computational Efficiency Trick
		SAVE_TAG = 'SAVE';
		SAVE_CATEGORY = 5;
		SAVE_FORMAT = 1;
	end
	methods % constructor
		function ex = ExporterBrainAtlasTXT(varargin)
			%ExporterBrainAtlasTXT() creates a brain atlas exporter in TXT.
			%
			% ExporterBrainAtlasTXT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ExporterBrainAtlasTXT(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ExporterBrainAtlasTXT properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the brain atlas exporter in TXT.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the brain atlas exporter in TXT.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the brain atlas exporter in TXT.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the brain atlas exporter in TXT.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the brain atlas exporter in TXT.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the brain atlas exporter in TXT.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the brain atlas exporter in TXT.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>BA</strong> 	BA (data, item) is a brain atlas.
			%  <strong>11</strong> <strong>FILE</strong> 	FILE (data, string) is the TXT file where to save the brain atlas.
			%  <strong>12</strong> <strong>PUT_FILE</strong> 	PUT_FILE (query, item) opens a dialog box to set the TXT file where to save the brain atlas.
			%  <strong>13</strong> <strong>SAVE</strong> 	SAVE (result, empty) saves the brain atlas in the selected TXT file.
			%
			% See also Category, Format.
			
			ex = ex@Exporter(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the brain atlas exporter in TXT.
			%
			% BUILD = ExporterBrainAtlasTXT.GETBUILD() returns the build of 'ExporterBrainAtlasTXT'.
			%
			% Alternative forms to call this method are:
			%  BUILD = EX.GETBUILD() returns the build of the brain atlas exporter in TXT EX.
			%  BUILD = Element.GETBUILD(EX) returns the build of 'EX'.
			%  BUILD = Element.GETBUILD('ExporterBrainAtlasTXT') returns the build of 'ExporterBrainAtlasTXT'.
			%
			% Note that the Element.GETBUILD(EX) and Element.GETBUILD('ExporterBrainAtlasTXT')
			%  are less computationally efficient.
			
			build = 1;
		end
		function ex_class = getClass()
			%GETCLASS returns the class of the brain atlas exporter in TXT.
			%
			% CLASS = ExporterBrainAtlasTXT.GETCLASS() returns the class 'ExporterBrainAtlasTXT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = EX.GETCLASS() returns the class of the brain atlas exporter in TXT EX.
			%  CLASS = Element.GETCLASS(EX) returns the class of 'EX'.
			%  CLASS = Element.GETCLASS('ExporterBrainAtlasTXT') returns 'ExporterBrainAtlasTXT'.
			%
			% Note that the Element.GETCLASS(EX) and Element.GETCLASS('ExporterBrainAtlasTXT')
			%  are less computationally efficient.
			
			ex_class = 'ExporterBrainAtlasTXT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the brain atlas exporter in TXT.
			%
			% LIST = ExporterBrainAtlasTXT.GETSUBCLASSES() returns all subclasses of 'ExporterBrainAtlasTXT'.
			%
			% Alternative forms to call this method are:
			%  LIST = EX.GETSUBCLASSES() returns all subclasses of the brain atlas exporter in TXT EX.
			%  LIST = Element.GETSUBCLASSES(EX) returns all subclasses of 'EX'.
			%  LIST = Element.GETSUBCLASSES('ExporterBrainAtlasTXT') returns all subclasses of 'ExporterBrainAtlasTXT'.
			%
			% Note that the Element.GETSUBCLASSES(EX) and Element.GETSUBCLASSES('ExporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ExporterBrainAtlasTXT' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of brain atlas exporter in TXT.
			%
			% PROPS = ExporterBrainAtlasTXT.GETPROPS() returns the property list of brain atlas exporter in TXT
			%  as a row vector.
			%
			% PROPS = ExporterBrainAtlasTXT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = EX.GETPROPS([CATEGORY]) returns the property list of the brain atlas exporter in TXT EX.
			%  PROPS = Element.GETPROPS(EX[, CATEGORY]) returns the property list of 'EX'.
			%  PROPS = Element.GETPROPS('ExporterBrainAtlasTXT'[, CATEGORY]) returns the property list of 'ExporterBrainAtlasTXT'.
			%
			% Note that the Element.GETPROPS(EX) and Element.GETPROPS('ExporterBrainAtlasTXT')
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
			%GETPROPNUMBER returns the property number of brain atlas exporter in TXT.
			%
			% N = ExporterBrainAtlasTXT.GETPROPNUMBER() returns the property number of brain atlas exporter in TXT.
			%
			% N = ExporterBrainAtlasTXT.GETPROPNUMBER(CATEGORY) returns the property number of brain atlas exporter in TXT
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = EX.GETPROPNUMBER([CATEGORY]) returns the property number of the brain atlas exporter in TXT EX.
			%  N = Element.GETPROPNUMBER(EX) returns the property number of 'EX'.
			%  N = Element.GETPROPNUMBER('ExporterBrainAtlasTXT') returns the property number of 'ExporterBrainAtlasTXT'.
			%
			% Note that the Element.GETPROPNUMBER(EX) and Element.GETPROPNUMBER('ExporterBrainAtlasTXT')
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
			%EXISTSPROP checks whether property exists in brain atlas exporter in TXT/error.
			%
			% CHECK = ExporterBrainAtlasTXT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSPROP(PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(EX, PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(ExporterBrainAtlasTXT, PROP) checks whether PROP exists for ExporterBrainAtlasTXT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ExporterBrainAtlasTXT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSPROP(PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterBrainAtlasTXT:WrongInput]
			%  Element.EXISTSPROP(EX, PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterBrainAtlasTXT:WrongInput]
			%  Element.EXISTSPROP(ExporterBrainAtlasTXT, PROP) throws error if PROP does NOT exist for ExporterBrainAtlasTXT.
			%   Error id: [BRAPH2:ExporterBrainAtlasTXT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(EX) and Element.EXISTSPROP('ExporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ExporterBrainAtlasTXT:' 'WrongInput'], ...
					['BRAPH2' ':ExporterBrainAtlasTXT:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ExporterBrainAtlasTXT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in brain atlas exporter in TXT/error.
			%
			% CHECK = ExporterBrainAtlasTXT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSTAG(TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(EX, TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(ExporterBrainAtlasTXT, TAG) checks whether TAG exists for ExporterBrainAtlasTXT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ExporterBrainAtlasTXT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSTAG(TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterBrainAtlasTXT:WrongInput]
			%  Element.EXISTSTAG(EX, TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterBrainAtlasTXT:WrongInput]
			%  Element.EXISTSTAG(ExporterBrainAtlasTXT, TAG) throws error if TAG does NOT exist for ExporterBrainAtlasTXT.
			%   Error id: [BRAPH2:ExporterBrainAtlasTXT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(EX) and Element.EXISTSTAG('ExporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'BA'  'FILE'  'PUT_FILE'  'SAVE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ExporterBrainAtlasTXT:' 'WrongInput'], ...
					['BRAPH2' ':ExporterBrainAtlasTXT:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ExporterBrainAtlasTXT.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ExporterBrainAtlasTXT, POINTER) returns property number of POINTER of ExporterBrainAtlasTXT.
			%  PROPERTY = EX.GETPROPPROP(ExporterBrainAtlasTXT, POINTER) returns property number of POINTER of ExporterBrainAtlasTXT.
			%
			% Note that the Element.GETPROPPROP(EX) and Element.GETPROPPROP('ExporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'BA'  'FILE'  'PUT_FILE'  'SAVE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(ExporterBrainAtlasTXT, POINTER) returns tag of POINTER of ExporterBrainAtlasTXT.
			%  TAG = EX.GETPROPTAG(ExporterBrainAtlasTXT, POINTER) returns tag of POINTER of ExporterBrainAtlasTXT.
			%
			% Note that the Element.GETPROPTAG(EX) and Element.GETPROPTAG('ExporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				exporterbrainatlastxt_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'BA'  'FILE'  'PUT_FILE'  'SAVE' };
				tag = exporterbrainatlastxt_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(ExporterBrainAtlasTXT, POINTER) returns category of POINTER of ExporterBrainAtlasTXT.
			%  CATEGORY = EX.GETPROPCATEGORY(ExporterBrainAtlasTXT, POINTER) returns category of POINTER of ExporterBrainAtlasTXT.
			%
			% Note that the Element.GETPROPCATEGORY(EX) and Element.GETPROPCATEGORY('ExporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ExporterBrainAtlasTXT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			exporterbrainatlastxt_category_list = { 1  1  1  3  4  2  2  6  9  4  4  6  5 };
			prop_category = exporterbrainatlastxt_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(ExporterBrainAtlasTXT, POINTER) returns format of POINTER of ExporterBrainAtlasTXT.
			%  FORMAT = EX.GETPROPFORMAT(ExporterBrainAtlasTXT, POINTER) returns format of POINTER of ExporterBrainAtlasTXT.
			%
			% Note that the Element.GETPROPFORMAT(EX) and Element.GETPROPFORMAT('ExporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ExporterBrainAtlasTXT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			exporterbrainatlastxt_format_list = { 2  2  2  8  2  2  2  2  4  8  2  8  1 };
			prop_format = exporterbrainatlastxt_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ExporterBrainAtlasTXT, POINTER) returns description of POINTER of ExporterBrainAtlasTXT.
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(ExporterBrainAtlasTXT, POINTER) returns description of POINTER of ExporterBrainAtlasTXT.
			%
			% Note that the Element.GETPROPDESCRIPTION(EX) and Element.GETPROPDESCRIPTION('ExporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ExporterBrainAtlasTXT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			exporterbrainatlastxt_description_list = { 'ELCLASS (constant, string) is the class of the brain atlas exporter in TXT.'  'NAME (constant, string) is the name of the brain atlas exporter in TXT.'  'DESCRIPTION (constant, string) is the description of the brain atlas exporter in TXT.'  'TEMPLATE (parameter, item) is the template of the brain atlas exporter in TXT.'  'ID (data, string) is a few-letter code for the brain atlas exporter in TXT.'  'LABEL (metadata, string) is an extended label of the brain atlas exporter in TXT.'  'NOTES (metadata, string) are some specific notes about the brain atlas exporter in TXT.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'BA (data, item) is a brain atlas.'  'FILE (data, string) is the TXT file where to save the brain atlas.'  'PUT_FILE (query, item) opens a dialog box to set the TXT file where to save the brain atlas.'  'SAVE (result, empty) saves the brain atlas in the selected TXT file.' };
			prop_description = exporterbrainatlastxt_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(ExporterBrainAtlasTXT, POINTER) returns settings of POINTER of ExporterBrainAtlasTXT.
			%  SETTINGS = EX.GETPROPSETTINGS(ExporterBrainAtlasTXT, POINTER) returns settings of POINTER of ExporterBrainAtlasTXT.
			%
			% Note that the Element.GETPROPSETTINGS(EX) and Element.GETPROPSETTINGS('ExporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ExporterBrainAtlasTXT.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ExporterBrainAtlasTXT.BA
					prop_settings = 'BrainAtlas';
				case 11 % ExporterBrainAtlasTXT.FILE
					prop_settings = Format.getFormatSettings(2);
				case 12 % ExporterBrainAtlasTXT.PUT_FILE
					prop_settings = 'ExporterBrainAtlasTXT';
				case 13 % ExporterBrainAtlasTXT.SAVE
					prop_settings = Format.getFormatSettings(1);
				case 4 % ExporterBrainAtlasTXT.TEMPLATE
					prop_settings = 'ExporterBrainAtlasTXT';
				otherwise
					prop_settings = getPropSettings@Exporter(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ExporterBrainAtlasTXT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterBrainAtlasTXT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULT(ExporterBrainAtlasTXT, POINTER) returns the default value of POINTER of ExporterBrainAtlasTXT.
			%  DEFAULT = EX.GETPROPDEFAULT(ExporterBrainAtlasTXT, POINTER) returns the default value of POINTER of ExporterBrainAtlasTXT.
			%
			% Note that the Element.GETPROPDEFAULT(EX) and Element.GETPROPDEFAULT('ExporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ExporterBrainAtlasTXT.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ExporterBrainAtlasTXT.BA
					prop_default = Format.getFormatDefault(8, ExporterBrainAtlasTXT.getPropSettings(prop));
				case 11 % ExporterBrainAtlasTXT.FILE
					prop_default = [fileparts(which('test_braph2')) filesep 'default_txt_file_to_save_brain_atlas_most_likely_to_be_erased.txt'];
				case 12 % ExporterBrainAtlasTXT.PUT_FILE
					prop_default = Format.getFormatDefault(8, ExporterBrainAtlasTXT.getPropSettings(prop));
				case 13 % ExporterBrainAtlasTXT.SAVE
					prop_default = Format.getFormatDefault(1, ExporterBrainAtlasTXT.getPropSettings(prop));
				case 1 % ExporterBrainAtlasTXT.ELCLASS
					prop_default = 'ExporterBrainAtlasTXT';
				case 2 % ExporterBrainAtlasTXT.NAME
					prop_default = 'Brain Atlas Exporter in TXT Files';
				case 3 % ExporterBrainAtlasTXT.DESCRIPTION
					prop_default = 'A Brain Atlas Exporter in TXT Files (ExporterBrainAtlasTXT) exports a brain atlas to a TXT file.';
				case 4 % ExporterBrainAtlasTXT.TEMPLATE
					prop_default = Format.getFormatDefault(8, ExporterBrainAtlasTXT.getPropSettings(prop));
				case 5 % ExporterBrainAtlasTXT.ID
					prop_default = 'ExporterBrainAtlasTXT ID';
				case 6 % ExporterBrainAtlasTXT.LABEL
					prop_default = 'ExporterBrainAtlasTXT label';
				case 7 % ExporterBrainAtlasTXT.NOTES
					prop_default = 'ExporterBrainAtlasTXT notes';
				otherwise
					prop_default = getPropDefault@Exporter(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ExporterBrainAtlasTXT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterBrainAtlasTXT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ExporterBrainAtlasTXT, POINTER) returns the conditioned default value of POINTER of ExporterBrainAtlasTXT.
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(ExporterBrainAtlasTXT, POINTER) returns the conditioned default value of POINTER of ExporterBrainAtlasTXT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(EX) and Element.GETPROPDEFAULTCONDITIONED('ExporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ExporterBrainAtlasTXT.getPropProp(pointer);
			
			prop_default = ExporterBrainAtlasTXT.conditioning(prop, ExporterBrainAtlasTXT.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ExporterBrainAtlasTXT, PROP, VALUE) checks VALUE format for PROP of ExporterBrainAtlasTXT.
			%  CHECK = EX.CHECKPROP(ExporterBrainAtlasTXT, PROP, VALUE) checks VALUE format for PROP of ExporterBrainAtlasTXT.
			% 
			% EX.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ExporterBrainAtlasTXT:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  EX.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EX.
			%   Error id: BRAPH2:ExporterBrainAtlasTXT:WrongInput
			%  Element.CHECKPROP(ExporterBrainAtlasTXT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterBrainAtlasTXT.
			%   Error id: BRAPH2:ExporterBrainAtlasTXT:WrongInput
			%  EX.CHECKPROP(ExporterBrainAtlasTXT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterBrainAtlasTXT.
			%   Error id: BRAPH2:ExporterBrainAtlasTXT:WrongInput]
			% 
			% Note that the Element.CHECKPROP(EX) and Element.CHECKPROP('ExporterBrainAtlasTXT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ExporterBrainAtlasTXT.getPropProp(pointer);
			
			switch prop
				case 10 % ExporterBrainAtlasTXT.BA
					check = Format.checkFormat(8, value, ExporterBrainAtlasTXT.getPropSettings(prop));
				case 11 % ExporterBrainAtlasTXT.FILE
					check = Format.checkFormat(2, value, ExporterBrainAtlasTXT.getPropSettings(prop));
				case 12 % ExporterBrainAtlasTXT.PUT_FILE
					check = Format.checkFormat(8, value, ExporterBrainAtlasTXT.getPropSettings(prop));
				case 13 % ExporterBrainAtlasTXT.SAVE
					check = Format.checkFormat(1, value, ExporterBrainAtlasTXT.getPropSettings(prop));
				case 4 % ExporterBrainAtlasTXT.TEMPLATE
					check = Format.checkFormat(8, value, ExporterBrainAtlasTXT.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@Exporter(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ExporterBrainAtlasTXT:' 'WrongInput'], ...
					['BRAPH2' ':ExporterBrainAtlasTXT:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ExporterBrainAtlasTXT.getPropTag(prop) ' (' ExporterBrainAtlasTXT.getFormatTag(ExporterBrainAtlasTXT.getPropFormat(prop)) ').'] ...
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
				case 12 % ExporterBrainAtlasTXT.PUT_FILE
					[filename, filepath, filterindex] = uiputfile('*.txt', 'Select TXT file');
					if filterindex
					    file = [filepath filename];
					    ex.set('FILE', file);
					end
					value = ex;
					
				case 13 % ExporterBrainAtlasTXT.SAVE
					rng_settings_ = rng(); rng(ex.getPropSeed(13), 'twister')
					
					file = ex.get('FILE');
					
					if isfolder(fileparts(file))
					    wb = braph2waitbar(ex.get('WAITBAR'), 0, 'Retrieving path ...');
					
					    ba = ex.get('BA');
					    ba_id = ba.get('ID');
					    if ~isempty(ba.get('LABEL'))
					        ba_label = ba.get('LABEL');
					    else
					        ba_label = ' ';
					    end
					    if ~isempty(ba.get('NOTES'))
					        ba_notes = ba.get('NOTES');
					    else
					        ba_notes = ' ';
					    end
					
					    % gets brain region data
						braph2waitbar(wb, .15, 'Organizing info ...')
					    
					    br_dict = ba.get('BR_DICT');
					    br_ids = cell(br_dict.get('LENGTH'), 1);
					    br_labels = cell(br_dict.get('LENGTH'), 1);
					    br_notes = cell(br_dict.get('LENGTH'), 1);
					    br_x = cell(br_dict.get('LENGTH'), 1);
					    br_y = cell(br_dict.get('LENGTH'), 1);
					    br_z = cell(br_dict.get('LENGTH'), 1);
					    for i = 1:1:br_dict.get('LENGTH')
					        braph2waitbar(wb, .25 + .75 * i / br_dict.get('LENGTH'), ['Saving brain region ' num2str(i) ' of ' num2str(br_dict.get('LENGTH'))]);
					        
					        br = br_dict.get('IT', i);
					        br_ids{i} = br.get('ID');
					        if ~isempty(br.get('LABEL'))
					            br_labels{i} = br.get('LABEL');
					        else
					            br_labels{i} = ' ';
					        end
					        if ~isempty(br.get('NOTES'))
					            br_notes{i} = br.get('NOTES');
					        else
					            br_notes{i} = ' ';
					        end
					        br_x{i} = br.get('X');
					        br_y{i} = br.get('Y');
					        br_z{i} = br.get('Z');
					    end
					
					    % creates table
					    tab = [
					        {ba_id, {}, {}, {}, {}, {}};
					        {ba_label, {}, {}, {}, {}, {}};
					        {ba_notes, {}, {}, {}, {}, {}};
					        {{}, {}, {}, {}, {}, {}};
					        table(br_ids, br_labels, br_x, br_y, br_z, br_notes)
					        ];
					
					    % saves
					    braph2waitbar(wb, 1, 'Finalizing ...')
					
					    writetable(tab, file, 'Delimiter', '	', 'WriteVariableNames', false);
					
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
