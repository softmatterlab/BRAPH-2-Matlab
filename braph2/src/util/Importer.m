classdef Importer < ConcreteElement
	%Importer imports an element from a file.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% An Importer is the base class for the importer of an element (ConcreteElement) from a file.
	%
	% The list of Importer properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the importer.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the importer.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the importer.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the importer.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the importer.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the importer.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the importer.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%
	% Importer methods (constructor):
	%  Importer - constructor
	%
	% Importer methods:
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
	% Importer methods (display):
	%  tostring - string with information about the importer from a file
	%  disp - displays information about the importer from a file
	%  tree - displays the tree of the importer from a file
	%
	% Importer methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two importer from a file are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the importer from a file
	%
	% Importer methods (save/load, Static):
	%  save - saves BRAPH2 importer from a file as b2 file
	%  load - loads a BRAPH2 importer from a file from a b2 file
	%
	% Importer method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the importer from a file
	%
	% Importer method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the importer from a file
	%
	% Importer methods (inspection, Static):
	%  getClass - returns the class of the importer from a file
	%  getSubclasses - returns all subclasses of Importer
	%  getProps - returns the property list of the importer from a file
	%  getPropNumber - returns the property number of the importer from a file
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
	% Importer methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Importer methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Importer methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Importer methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Importer; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Importer constants</a>.
	%
	%
	% See also ConcreteElement, Exporter.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		WAITBAR = 9; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
	end
	methods % constructor
		function im = Importer(varargin)
			%Importer() creates a importer from a file.
			%
			% Importer(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Importer(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Importer properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the importer.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the importer.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the importer.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the importer.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the importer.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the importer.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the importer.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%
			% See also Category, Format.
			
			im = im@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the importer from a file.
			%
			% BUILD = Importer.GETBUILD() returns the build of 'Importer'.
			%
			% Alternative forms to call this method are:
			%  BUILD = IM.GETBUILD() returns the build of the importer from a file IM.
			%  BUILD = Element.GETBUILD(IM) returns the build of 'IM'.
			%  BUILD = Element.GETBUILD('Importer') returns the build of 'Importer'.
			%
			% Note that the Element.GETBUILD(IM) and Element.GETBUILD('Importer')
			%  are less computationally efficient.
			
			build = 1;
		end
		function im_class = getClass()
			%GETCLASS returns the class of the importer from a file.
			%
			% CLASS = Importer.GETCLASS() returns the class 'Importer'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer from a file IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('Importer') returns 'Importer'.
			%
			% Note that the Element.GETCLASS(IM) and Element.GETCLASS('Importer')
			%  are less computationally efficient.
			
			im_class = 'Importer';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the importer from a file.
			%
			% LIST = Importer.GETSUBCLASSES() returns all subclasses of 'Importer'.
			%
			% Alternative forms to call this method are:
			%  LIST = IM.GETSUBCLASSES() returns all subclasses of the importer from a file IM.
			%  LIST = Element.GETSUBCLASSES(IM) returns all subclasses of 'IM'.
			%  LIST = Element.GETSUBCLASSES('Importer') returns all subclasses of 'Importer'.
			%
			% Note that the Element.GETSUBCLASSES(IM) and Element.GETSUBCLASSES('Importer')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'Importer'  'ImporterGroupSubjectCON_TXT'  'ImporterGroupSubjectCON_XLS'  'ImporterGroupSubjectCON_MP_TXT'  'ImporterGroupSubjectCON_MP_XLS'  'ImporterGroupSubjectFUN_TXT'  'ImporterGroupSubjectFUN_XLS'  'ImporterGroupSubjectFUN_MP_TXT'  'ImporterGroupSubjectFUN_MP_XLS'  'ImporterGroupSubjectST_TXT'  'ImporterGroupSubjectST_XLS'  'ImporterGroupSubjectST_MP_TXT'  'ImporterGroupSubjectST_MP_XLS'  'ImporterBrainAtlasTXT'  'ImporterBrainAtlasXLS'  'ImporterBrainSurfaceNV'  'ImporterPipelineBRAPH2' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer from a file.
			%
			% PROPS = Importer.GETPROPS() returns the property list of importer from a file
			%  as a row vector.
			%
			% PROPS = Importer.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer from a file IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('Importer'[, CATEGORY]) returns the property list of 'Importer'.
			%
			% Note that the Element.GETPROPS(IM) and Element.GETPROPS('Importer')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9];
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
					prop_list = 5;
				case 6 % Category.QUERY
					prop_list = 8;
				case 9 % Category.GUI
					prop_list = 9;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of importer from a file.
			%
			% N = Importer.GETPROPNUMBER() returns the property number of importer from a file.
			%
			% N = Importer.GETPROPNUMBER(CATEGORY) returns the property number of importer from a file
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER([CATEGORY]) returns the property number of the importer from a file IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('Importer') returns the property number of 'Importer'.
			%
			% Note that the Element.GETPROPNUMBER(IM) and Element.GETPROPNUMBER('Importer')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 9;
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
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in importer from a file/error.
			%
			% CHECK = Importer.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(Importer, PROP) checks whether PROP exists for Importer.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Importer:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%  Element.EXISTSPROP(Importer, PROP) throws error if PROP does NOT exist for Importer.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IM) and Element.EXISTSPROP('Importer')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 9 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Importer:' 'WrongInput'], ...
					['BRAPH2' ':Importer:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Importer.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer from a file/error.
			%
			% CHECK = Importer.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(Importer, TAG) checks whether TAG exists for Importer.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Importer:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%  Element.EXISTSTAG(Importer, TAG) throws error if TAG does NOT exist for Importer.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IM) and Element.EXISTSTAG('Importer')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Importer:' 'WrongInput'], ...
					['BRAPH2' ':Importer:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for Importer.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Importer, POINTER) returns property number of POINTER of Importer.
			%  PROPERTY = IM.GETPROPPROP(Importer, POINTER) returns property number of POINTER of Importer.
			%
			% Note that the Element.GETPROPPROP(IM) and Element.GETPROPPROP('Importer')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(Importer, POINTER) returns tag of POINTER of Importer.
			%  TAG = IM.GETPROPTAG(Importer, POINTER) returns tag of POINTER of Importer.
			%
			% Note that the Element.GETPROPTAG(IM) and Element.GETPROPTAG('Importer')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				importer_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR' };
				tag = importer_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(Importer, POINTER) returns category of POINTER of Importer.
			%  CATEGORY = IM.GETPROPCATEGORY(Importer, POINTER) returns category of POINTER of Importer.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('Importer')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importer_category_list = { 1  1  1  3  4  2  2  6  9 };
			prop_category = importer_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(Importer, POINTER) returns format of POINTER of Importer.
			%  FORMAT = IM.GETPROPFORMAT(Importer, POINTER) returns format of POINTER of Importer.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('Importer')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importer_format_list = { 2  2  2  8  2  2  2  2  4 };
			prop_format = importer_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Importer, POINTER) returns description of POINTER of Importer.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(Importer, POINTER) returns description of POINTER of Importer.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('Importer')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importer_description_list = { 'ELCLASS (constant, string) is the class of the importer.'  'NAME (constant, string) is the name of the importer.'  'DESCRIPTION (constant, string) is the description of the importer.'  'TEMPLATE (parameter, item) is the template of the importer.'  'ID (data, string) is a few-letter code for the importer.'  'LABEL (metadata, string) is an extended label of the importer.'  'NOTES (metadata, string) are some specific notes about the importer.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.' };
			prop_description = importer_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(Importer, POINTER) returns settings of POINTER of Importer.
			%  SETTINGS = IM.GETPROPSETTINGS(Importer, POINTER) returns settings of POINTER of Importer.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('Importer')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % Importer.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 4 % Importer.TEMPLATE
					prop_settings = 'Importer';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Importer.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Importer.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(Importer, POINTER) returns the default value of POINTER of Importer.
			%  DEFAULT = IM.GETPROPDEFAULT(Importer, POINTER) returns the default value of POINTER of Importer.
			%
			% Note that the Element.GETPROPDEFAULT(IM) and Element.GETPROPDEFAULT('Importer')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % Importer.WAITBAR
					prop_default = Format.getFormatDefault(4, Importer.getPropSettings(prop));
				case 1 % Importer.ELCLASS
					prop_default = 'Importer';
				case 2 % Importer.NAME
					prop_default = 'Importer';
				case 3 % Importer.DESCRIPTION
					prop_default = 'Importer is the base class for the importer of an element (ConcreteElement) from a file.';
				case 4 % Importer.TEMPLATE
					prop_default = Format.getFormatDefault(8, Importer.getPropSettings(prop));
				case 5 % Importer.ID
					prop_default = 'Importer ID';
				case 6 % Importer.LABEL
					prop_default = 'Importer label';
				case 7 % Importer.NOTES
					prop_default = 'Importer notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Importer.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Importer.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Importer, POINTER) returns the conditioned default value of POINTER of Importer.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(Importer, POINTER) returns the conditioned default value of POINTER of Importer.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IM) and Element.GETPROPDEFAULTCONDITIONED('Importer')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			prop_default = Importer.conditioning(prop, Importer.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Importer, PROP, VALUE) checks VALUE format for PROP of Importer.
			%  CHECK = IM.CHECKPROP(Importer, PROP, VALUE) checks VALUE format for PROP of Importer.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:Importer:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: BRAPH2:Importer:WrongInput
			%  Element.CHECKPROP(Importer, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Importer.
			%   Error id: BRAPH2:Importer:WrongInput
			%  IM.CHECKPROP(Importer, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Importer.
			%   Error id: BRAPH2:Importer:WrongInput]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('Importer')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Importer.getPropProp(pointer);
			
			switch prop
				case 9 % Importer.WAITBAR
					check = Format.checkFormat(4, value, Importer.getPropSettings(prop));
				case 4 % Importer.TEMPLATE
					check = Format.checkFormat(8, value, Importer.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Importer:' 'WrongInput'], ...
					['BRAPH2' ':Importer:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Importer.getPropTag(prop) ' (' Importer.getFormatTag(Importer.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
