classdef Settings < ConcreteElement
	%Settings contains some graphics settings.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Graphics Settings (Settings) provides the base element for all graphics settings.
	%  Typically, only its subclasses are employed.
	% 
	%  The graphics objects is identified by its handle(list), which can be retrieved as:
	%  
	%     h = st.get('<strong>H</strong>');
	%     
	%  It returns an empty object identifier if the graphical object handle has not been 
	%   set yet.
	%     
	%  The handle can be set by setting the props PANEL and PROP (or TAG) for props 
	%   of 18, and PANEL, PROP (or TAG) and I for props of 19.
	%  
	% The initial setup of the figure props (initial postset) can be done by calling:
	% 
	%     st.get('<strong>SETUP</strong>')
	% 
	% Typically, it is used as a prop of a subclass of Panel (pn) and it is 
	%  initialized in the prop DRAW with a code smiliar to this:
	% 
	% 	pn.set(''ST'', Settings(''PANEL'', pn, ''PROP'', prop[, ''I'', i]) % preferred
	% 	pn.set(''ST'', Settings(''PANEL'', pn, ''TAG'', tag[, ''I'', i])
	%  
	%   The option with PROP is to be preferred, because it is faster.
	% 
	%  It might be necessary to add some listeners (e.g., to update toogle buttons).
	%
	% The list of Settings properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the graphics settings.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the graphics settings.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the graphics settings.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the line graphics settings.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the graphics settings.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the graphics settings.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graphics settings.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
	%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
	%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
	%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
	%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
	%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
	%
	% Settings methods (constructor):
	%  Settings - constructor
	%
	% Settings methods:
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
	% Settings methods (display):
	%  tostring - string with information about the graphics settings
	%  disp - displays information about the graphics settings
	%  tree - displays the tree of the graphics settings
	%
	% Settings methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graphics settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graphics settings
	%
	% Settings methods (save/load, Static):
	%  save - saves BRAPH2 graphics settings as b2 file
	%  load - loads a BRAPH2 graphics settings from a b2 file
	%
	% Settings method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graphics settings
	%
	% Settings method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graphics settings
	%
	% Settings methods (inspection, Static):
	%  getClass - returns the class of the graphics settings
	%  getSubclasses - returns all subclasses of Settings
	%  getProps - returns the property list of the graphics settings
	%  getPropNumber - returns the property number of the graphics settings
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
	% Settings methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Settings methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Settings methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Settings methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Settings; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Settings constants</a>.
	%
	%
	% See also Panel, listener.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		PANEL = 9; %CET: Computational Efficiency Trick
		PANEL_TAG = 'PANEL';
		PANEL_CATEGORY = 9;
		PANEL_FORMAT = 8;
		
		PROP = 10; %CET: Computational Efficiency Trick
		PROP_TAG = 'PROP';
		PROP_CATEGORY = 9;
		PROP_FORMAT = 11;
		
		TAG = 11; %CET: Computational Efficiency Trick
		TAG_TAG = 'TAG';
		TAG_CATEGORY = 9;
		TAG_FORMAT = 2;
		
		I = 12; %CET: Computational Efficiency Trick
		I_TAG = 'I';
		I_CATEGORY = 9;
		I_FORMAT = 11;
		
		H = 13; %CET: Computational Efficiency Trick
		H_TAG = 'H';
		H_CATEGORY = 6;
		H_FORMAT = 18;
		
		SETUP = 14; %CET: Computational Efficiency Trick
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = 6;
		SETUP_FORMAT = 11;
	end
	methods % constructor
		function st = Settings(varargin)
			%Settings() creates a graphics settings.
			%
			% Settings(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Settings(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Settings properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the graphics settings.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the graphics settings.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the graphics settings.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the line graphics settings.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the graphics settings.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the graphics settings.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graphics settings.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
			%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
			%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
			%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
			%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
			%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
			%
			% See also Category, Format.
			
			st = st@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the graphics settings.
			%
			% BUILD = Settings.GETBUILD() returns the build of 'Settings'.
			%
			% Alternative forms to call this method are:
			%  BUILD = ST.GETBUILD() returns the build of the graphics settings ST.
			%  BUILD = Element.GETBUILD(ST) returns the build of 'ST'.
			%  BUILD = Element.GETBUILD('Settings') returns the build of 'Settings'.
			%
			% Note that the Element.GETBUILD(ST) and Element.GETBUILD('Settings')
			%  are less computationally efficient.
			
			build = 1;
		end
		function st_class = getClass()
			%GETCLASS returns the class of the graphics settings.
			%
			% CLASS = Settings.GETCLASS() returns the class 'Settings'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the graphics settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('Settings') returns 'Settings'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('Settings')
			%  are less computationally efficient.
			
			st_class = 'Settings';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graphics settings.
			%
			% LIST = Settings.GETSUBCLASSES() returns all subclasses of 'Settings'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the graphics settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('Settings') returns all subclasses of 'Settings'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('Settings')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'Settings'  'SettingsAmbient'  'SettingsArea'  'SettingsAxis'  'SettingsLine'  'SettingsPosition'  'SettingsSphere'  'SettingsSurface'  'SettingsSymbol'  'SettingsText' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graphics settings.
			%
			% PROPS = Settings.GETPROPS() returns the property list of graphics settings
			%  as a row vector.
			%
			% PROPS = Settings.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the graphics settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('Settings'[, CATEGORY]) returns the property list of 'Settings'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('Settings')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14];
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
					prop_list = [8 13 14];
				case 9 % Category.GUI
					prop_list = [9 10 11 12];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graphics settings.
			%
			% N = Settings.GETPROPNUMBER() returns the property number of graphics settings.
			%
			% N = Settings.GETPROPNUMBER(CATEGORY) returns the property number of graphics settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the graphics settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('Settings') returns the property number of 'Settings'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('Settings')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 14;
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
					prop_number = 3;
				case 9 % Category.GUI
					prop_number = 4;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graphics settings/error.
			%
			% CHECK = Settings.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(Settings, PROP) checks whether PROP exists for Settings.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Settings:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:Settings:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:Settings:WrongInput]
			%  Element.EXISTSPROP(Settings, PROP) throws error if PROP does NOT exist for Settings.
			%   Error id: [BRAPH2:Settings:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('Settings')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 14 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Settings:' 'WrongInput'], ...
					['BRAPH2' ':Settings:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Settings.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graphics settings/error.
			%
			% CHECK = Settings.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(Settings, TAG) checks whether TAG exists for Settings.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Settings:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:Settings:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:Settings:WrongInput]
			%  Element.EXISTSTAG(Settings, TAG) throws error if TAG does NOT exist for Settings.
			%   Error id: [BRAPH2:Settings:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('Settings')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Settings:' 'WrongInput'], ...
					['BRAPH2' ':Settings:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for Settings.'] ...
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
			%  PROPERTY = ST.GETPROPPROP(POINTER) returns property number of POINTER of ST.
			%  PROPERTY = Element.GETPROPPROP(Settings, POINTER) returns property number of POINTER of Settings.
			%  PROPERTY = ST.GETPROPPROP(Settings, POINTER) returns property number of POINTER of Settings.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('Settings')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = ST.GETPROPTAG(POINTER) returns tag of POINTER of ST.
			%  TAG = Element.GETPROPTAG(Settings, POINTER) returns tag of POINTER of Settings.
			%  TAG = ST.GETPROPTAG(Settings, POINTER) returns tag of POINTER of Settings.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('Settings')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				settings_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP' };
				tag = settings_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = ST.GETPROPCATEGORY(POINTER) returns category of POINTER of ST.
			%  CATEGORY = Element.GETPROPCATEGORY(Settings, POINTER) returns category of POINTER of Settings.
			%  CATEGORY = ST.GETPROPCATEGORY(Settings, POINTER) returns category of POINTER of Settings.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('Settings')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Settings.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settings_category_list = { 1  1  1  3  4  2  2  6  9  9  9  9  6  6 };
			prop_category = settings_category_list{prop};
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
			%  FORMAT = ST.GETPROPFORMAT(POINTER) returns format of POINTER of ST.
			%  FORMAT = Element.GETPROPFORMAT(Settings, POINTER) returns format of POINTER of Settings.
			%  FORMAT = ST.GETPROPFORMAT(Settings, POINTER) returns format of POINTER of Settings.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('Settings')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Settings.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settings_format_list = { 2  2  2  8  2  2  2  2  8  11  2  11  18  11 };
			prop_format = settings_format_list{prop};
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
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ST.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Settings, POINTER) returns description of POINTER of Settings.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(Settings, POINTER) returns description of POINTER of Settings.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('Settings')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Settings.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settings_description_list = { 'ELCLASS (constant, string) is the class of the graphics settings.'  'NAME (constant, string) is the name of the graphics settings.'  'DESCRIPTION (constant, string) is the description of the graphics settings.'  'TEMPLATE (parameter, item) is the template of the line graphics settings.'  'ID (data, string) is a few-letter code for the graphics settings.'  'LABEL (metadata, string) is an extended label of the graphics settings.'  'NOTES (metadata, string) are some specific notes about the graphics settings.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'PANEL (gui, item) is the panel to which the graphics object belongs.'  'PROP (gui, scalar) is the prop of the graphics handle(list).'  'TAG (gui, string) is the tag of the graphics handle(s).'  'I (gui, scalar) is the index of the handle, used only by handlelists.'  'H (query, handle) is the graphics object handle.'  'SETUP (query, scalar) sets all figure props.' };
			prop_description = settings_description_list{prop};
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
			%  SETTINGS = ST.GETPROPSETTINGS(POINTER) returns settings of POINTER of ST.
			%  SETTINGS = Element.GETPROPSETTINGS(Settings, POINTER) returns settings of POINTER of Settings.
			%  SETTINGS = ST.GETPROPSETTINGS(Settings, POINTER) returns settings of POINTER of Settings.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('Settings')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Settings.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % Settings.PANEL
					prop_settings = 'Panel';
				case 10 % Settings.PROP
					prop_settings = Format.getFormatSettings(11);
				case 11 % Settings.TAG
					prop_settings = Format.getFormatSettings(2);
				case 12 % Settings.I
					prop_settings = Format.getFormatSettings(11);
				case 13 % Settings.H
					prop_settings = Format.getFormatSettings(18);
				case 14 % Settings.SETUP
					prop_settings = Format.getFormatSettings(11);
				case 4 % Settings.TEMPLATE
					prop_settings = 'Settings';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Settings.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Settings.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(Settings, POINTER) returns the default value of POINTER of Settings.
			%  DEFAULT = ST.GETPROPDEFAULT(Settings, POINTER) returns the default value of POINTER of Settings.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('Settings')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Settings.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % Settings.PANEL
					prop_default = Format.getFormatDefault(8, Settings.getPropSettings(prop));
				case 10 % Settings.PROP
					prop_default = 15;
				case 11 % Settings.TAG
					prop_default = 'H';
				case 12 % Settings.I
					prop_default = Format.getFormatDefault(11, Settings.getPropSettings(prop));
				case 13 % Settings.H
					prop_default = Format.getFormatDefault(18, Settings.getPropSettings(prop));
				case 14 % Settings.SETUP
					prop_default = Format.getFormatDefault(11, Settings.getPropSettings(prop));
				case 1 % Settings.ELCLASS
					prop_default = 'Settings';
				case 2 % Settings.NAME
					prop_default = 'Graphics Settings';
				case 3 % Settings.DESCRIPTION
					prop_default = 'A Graphics Settings (Settings) provides the base element for all graphics settings. Typically, only its subclasses are employed.';
				case 4 % Settings.TEMPLATE
					prop_default = Format.getFormatDefault(8, Settings.getPropSettings(prop));
				case 5 % Settings.ID
					prop_default = 'Settings ID';
				case 6 % Settings.LABEL
					prop_default = 'Settings label';
				case 7 % Settings.NOTES
					prop_default = 'Settings notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Settings.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Settings.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Settings, POINTER) returns the conditioned default value of POINTER of Settings.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(Settings, POINTER) returns the conditioned default value of POINTER of Settings.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('Settings')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Settings.getPropProp(pointer);
			
			prop_default = Settings.conditioning(prop, Settings.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = ST.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = ST.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of ST.
			%  CHECK = Element.CHECKPROP(Settings, PROP, VALUE) checks VALUE format for PROP of Settings.
			%  CHECK = ST.CHECKPROP(Settings, PROP, VALUE) checks VALUE format for PROP of Settings.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:Settings:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: BRAPH2:Settings:WrongInput
			%  Element.CHECKPROP(Settings, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Settings.
			%   Error id: BRAPH2:Settings:WrongInput
			%  ST.CHECKPROP(Settings, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Settings.
			%   Error id: BRAPH2:Settings:WrongInput]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('Settings')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Settings.getPropProp(pointer);
			
			switch prop
				case 9 % Settings.PANEL
					check = Format.checkFormat(8, value, Settings.getPropSettings(prop));
				case 10 % Settings.PROP
					check = Format.checkFormat(11, value, Settings.getPropSettings(prop));
				case 11 % Settings.TAG
					check = Format.checkFormat(2, value, Settings.getPropSettings(prop));
				case 12 % Settings.I
					check = Format.checkFormat(11, value, Settings.getPropSettings(prop));
				case 13 % Settings.H
					check = Format.checkFormat(18, value, Settings.getPropSettings(prop));
				case 14 % Settings.SETUP
					check = Format.checkFormat(11, value, Settings.getPropSettings(prop));
				case 4 % Settings.TEMPLATE
					check = Format.checkFormat(8, value, Settings.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Settings:' 'WrongInput'], ...
					['BRAPH2' ':Settings:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Settings.getPropTag(prop) ' (' Settings.getFormatTag(Settings.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(st, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case 10 % Settings.PROP
					pn = st.get('PANEL');
					prop = st.get('PROP');
					if ~strcmp(st.get('TAG'), pn.getPropTag(prop))
					    st.set('TAG', pn.getPropTag(prop));
					end
					
				case 11 % Settings.TAG
					pn = st.get('PANEL');
					tag = st.get('TAG');
					if st.get('PROP') ~= pn.getPropProp(tag)
					    st.set('PROP', pn.getPropProp(tag));
					end
					
				otherwise
					if prop <= 8
						postset@ConcreteElement(st, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(st, prop, varargin)
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
				case 13 % Settings.H
					pn = st.get('PANEL');
					prop = st.get('PROP');
					switch pn.getPropFormat(prop)
					    case 18
					        if ~isa(pn.getr(prop), 'NoValue')
					            value = pn.get(prop);
					        else
					            value = gobjects(1);
					        end
					        
					    case 19
					        if ~isa(pn.getr(prop), 'NoValue') && ~isa(st.getr('I'), 'NoValue')
					            i = st.get('I');
					            handlelists = pn.get(prop);
					            value = handlelists{i};
					        else
					            value = gobjects(1);
					        end
					end
					
				case 14 % Settings.SETUP
					figure_props = st.getProps(8);
					settings = cell(1, 2 * length(figure_props));
					for i = 1:1:length(figure_props)
					    figure_prop = figure_props(i);
					    settings{2 * i - 1} = figure_prop;
					    settings{2 * i} = st.get(figure_prop);
					end
					st.set(settings{:})
					value = length(figure_props);
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(st, prop, varargin{:});
					else
						value = calculateValue@Element(st, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(st, prop, value)
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
			msg = ['Error while checking ' tostring(st) ' ' st.getPropTag(prop) '.'];
			
			switch prop
				case 10 % Settings.PROP
					check = st.get('PANEL').getPropCategory(value) == 7 && any(st.get('PANEL').getPropFormat(value) == [18 19]);
					if check
					    msg = 'All ok';
					else
					    msg = ['The PROP ' tostring(value) ') must be evanescent handle(list), ' ...
					        'while it is ' Category.getCategoryName(st.get('PANEL').getPropCategory(value)) ...
					        ' ' Format.getFormatName(st.get('PANEL').getPropFormat(value)) '.'];
					end
					
				case 11 % Settings.TAG
					check = st.get('PANEL').getPropCategory(value) == 7 && any(st.get('PANEL').getPropFormat(value) == [18 19]);
					if check
					    msg = 'All ok';
					else
					    msg = ['The PROP ' tostring(value) ') must be evanescent handle(list), ' ...
					        'while it is ' Category.getCategoryName(st.get('PANEL').getPropCategory(value)) ...
					        ' ' Format.getFormatName(st.get('PANEL').getPropFormat(value)) '.'];
					end
					
				otherwise
					if prop <= 8
						[check, msg] = checkValue@ConcreteElement(st, prop, value);
					end
			end
		end
	end
end
