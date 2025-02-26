classdef SettingsPosition < Settings
	%SettingsPosition contains the figure panel position settings.
	% It is a subclass of <a href="matlab:help Settings">Settings</a>.
	%
	% A Position Settings (SettingsPosition) provides the settings 
	%  for a posistion settings panel, including autopositioning, x0, y0, height 
	%  and width.
	% The handle can be an uipanel.
	%
	% The list of SettingsPosition properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the position settings.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the position settings.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the position settings.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the position settings.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the position settings.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the position settings.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the position settings.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
	%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
	%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
	%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
	%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
	%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
	%  <strong>15</strong> <strong>AUTOPOS</strong> 	AUTOPOS (figure, logical) determines whether the position is adjusted automatically.
	%  <strong>16</strong> <strong>X0</strong> 	X0 (figure, scalar) is the lower left x-coordinate of the panel in pixels.
	%  <strong>17</strong> <strong>Y0</strong> 	Y0 (figure, scalar) is the lower-left y-coordinate of the panel in pixels.
	%  <strong>18</strong> <strong>WIDTH</strong> 	WIDTH (figure, size) is the width of the panel in pixels.
	%  <strong>19</strong> <strong>HEIGHT</strong> 	HEIGHT (figure, size) is the height of the panel in pixels.
	%
	% SettingsPosition methods (constructor):
	%  SettingsPosition - constructor
	%
	% SettingsPosition methods:
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
	% SettingsPosition methods (display):
	%  tostring - string with information about the position settings
	%  disp - displays information about the position settings
	%  tree - displays the tree of the position settings
	%
	% SettingsPosition methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two position settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the position settings
	%
	% SettingsPosition methods (save/load, Static):
	%  save - saves BRAPH2 position settings as b2 file
	%  load - loads a BRAPH2 position settings from a b2 file
	%
	% SettingsPosition method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the position settings
	%
	% SettingsPosition method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the position settings
	%
	% SettingsPosition methods (inspection, Static):
	%  getClass - returns the class of the position settings
	%  getSubclasses - returns all subclasses of SettingsPosition
	%  getProps - returns the property list of the position settings
	%  getPropNumber - returns the property number of the position settings
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
	% SettingsPosition methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsPosition methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsPosition methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsPosition methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsPosition; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsPosition constants</a>.
	%
	%
	% See also uipanel, SettingsPositionPP, PanelFig, GUIFig, check_graphics.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		AUTOPOS = 15; %CET: Computational Efficiency Trick
		AUTOPOS_TAG = 'AUTOPOS';
		AUTOPOS_CATEGORY = 8;
		AUTOPOS_FORMAT = 4;
		
		X0 = 16; %CET: Computational Efficiency Trick
		X0_TAG = 'X0';
		X0_CATEGORY = 8;
		X0_FORMAT = 11;
		
		Y0 = 17; %CET: Computational Efficiency Trick
		Y0_TAG = 'Y0';
		Y0_CATEGORY = 8;
		Y0_FORMAT = 11;
		
		WIDTH = 18; %CET: Computational Efficiency Trick
		WIDTH_TAG = 'WIDTH';
		WIDTH_CATEGORY = 8;
		WIDTH_FORMAT = 22;
		
		HEIGHT = 19; %CET: Computational Efficiency Trick
		HEIGHT_TAG = 'HEIGHT';
		HEIGHT_CATEGORY = 8;
		HEIGHT_FORMAT = 22;
	end
	methods % constructor
		function st = SettingsPosition(varargin)
			%SettingsPosition() creates a position settings.
			%
			% SettingsPosition(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsPosition(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SettingsPosition properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the position settings.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the position settings.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the position settings.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the position settings.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the position settings.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the position settings.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the position settings.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
			%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
			%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
			%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
			%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
			%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
			%  <strong>15</strong> <strong>AUTOPOS</strong> 	AUTOPOS (figure, logical) determines whether the position is adjusted automatically.
			%  <strong>16</strong> <strong>X0</strong> 	X0 (figure, scalar) is the lower left x-coordinate of the panel in pixels.
			%  <strong>17</strong> <strong>Y0</strong> 	Y0 (figure, scalar) is the lower-left y-coordinate of the panel in pixels.
			%  <strong>18</strong> <strong>WIDTH</strong> 	WIDTH (figure, size) is the width of the panel in pixels.
			%  <strong>19</strong> <strong>HEIGHT</strong> 	HEIGHT (figure, size) is the height of the panel in pixels.
			%
			% See also Category, Format.
			
			st = st@Settings(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the position settings.
			%
			% BUILD = SettingsPosition.GETBUILD() returns the build of 'SettingsPosition'.
			%
			% Alternative forms to call this method are:
			%  BUILD = ST.GETBUILD() returns the build of the position settings ST.
			%  BUILD = Element.GETBUILD(ST) returns the build of 'ST'.
			%  BUILD = Element.GETBUILD('SettingsPosition') returns the build of 'SettingsPosition'.
			%
			% Note that the Element.GETBUILD(ST) and Element.GETBUILD('SettingsPosition')
			%  are less computationally efficient.
			
			build = 1;
		end
		function st_class = getClass()
			%GETCLASS returns the class of the position settings.
			%
			% CLASS = SettingsPosition.GETCLASS() returns the class 'SettingsPosition'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the position settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsPosition') returns 'SettingsPosition'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsPosition')
			%  are less computationally efficient.
			
			st_class = 'SettingsPosition';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the position settings.
			%
			% LIST = SettingsPosition.GETSUBCLASSES() returns all subclasses of 'SettingsPosition'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the position settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsPosition') returns all subclasses of 'SettingsPosition'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SettingsPosition' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of position settings.
			%
			% PROPS = SettingsPosition.GETPROPS() returns the property list of position settings
			%  as a row vector.
			%
			% PROPS = SettingsPosition.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the position settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsPosition'[, CATEGORY]) returns the property list of 'SettingsPosition'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19];
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
				case 8 % Category.FIGURE
					prop_list = [15 16 17 18 19];
				case 9 % Category.GUI
					prop_list = [9 10 11 12];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of position settings.
			%
			% N = SettingsPosition.GETPROPNUMBER() returns the property number of position settings.
			%
			% N = SettingsPosition.GETPROPNUMBER(CATEGORY) returns the property number of position settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the position settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsPosition') returns the property number of 'SettingsPosition'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 19;
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
				case 8 % Category.FIGURE
					prop_number = 5;
				case 9 % Category.GUI
					prop_number = 4;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in position settings/error.
			%
			% CHECK = SettingsPosition.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsPosition, PROP) checks whether PROP exists for SettingsPosition.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsPosition:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsPosition:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsPosition:WrongInput]
			%  Element.EXISTSPROP(SettingsPosition, PROP) throws error if PROP does NOT exist for SettingsPosition.
			%   Error id: [BRAPH2:SettingsPosition:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 19 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsPosition:' 'WrongInput'], ...
					['BRAPH2' ':SettingsPosition:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsPosition.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in position settings/error.
			%
			% CHECK = SettingsPosition.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsPosition, TAG) checks whether TAG exists for SettingsPosition.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsPosition:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsPosition:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsPosition:WrongInput]
			%  Element.EXISTSTAG(SettingsPosition, TAG) throws error if TAG does NOT exist for SettingsPosition.
			%   Error id: [BRAPH2:SettingsPosition:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'AUTOPOS'  'X0'  'Y0'  'WIDTH'  'HEIGHT' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsPosition:' 'WrongInput'], ...
					['BRAPH2' ':SettingsPosition:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SettingsPosition.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsPosition, POINTER) returns property number of POINTER of SettingsPosition.
			%  PROPERTY = ST.GETPROPPROP(SettingsPosition, POINTER) returns property number of POINTER of SettingsPosition.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'AUTOPOS'  'X0'  'Y0'  'WIDTH'  'HEIGHT' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(SettingsPosition, POINTER) returns tag of POINTER of SettingsPosition.
			%  TAG = ST.GETPROPTAG(SettingsPosition, POINTER) returns tag of POINTER of SettingsPosition.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				settingsposition_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'AUTOPOS'  'X0'  'Y0'  'WIDTH'  'HEIGHT' };
				tag = settingsposition_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsPosition, POINTER) returns category of POINTER of SettingsPosition.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsPosition, POINTER) returns category of POINTER of SettingsPosition.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsPosition.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsposition_category_list = { 1  1  1  3  4  2  2  6  9  9  9  9  6  6  8  8  8  8  8 };
			prop_category = settingsposition_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsPosition, POINTER) returns format of POINTER of SettingsPosition.
			%  FORMAT = ST.GETPROPFORMAT(SettingsPosition, POINTER) returns format of POINTER of SettingsPosition.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsPosition.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsposition_format_list = { 2  2  2  8  2  2  2  2  8  11  2  11  18  11  4  11  11  22  22 };
			prop_format = settingsposition_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsPosition, POINTER) returns description of POINTER of SettingsPosition.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsPosition, POINTER) returns description of POINTER of SettingsPosition.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsPosition.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsposition_description_list = { 'ELCLASS (constant, string) is the class of the position settings.'  'NAME (constant, string) is the name of the position settings.'  'DESCRIPTION (constant, string) is the description of the position settings.'  'TEMPLATE (parameter, item) is the template of the position settings.'  'ID (data, string) is a few-letter code for the position settings.'  'LABEL (metadata, string) is an extended label of the position settings.'  'NOTES (metadata, string) are some specific notes about the position settings.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'PANEL (gui, item) is the panel to which the graphics object belongs.'  'PROP (gui, scalar) is the prop of the graphics handle(list).'  'TAG (gui, string) is the tag of the graphics handle(s).'  'I (gui, scalar) is the index of the handle, used only by handlelists.'  'H (query, handle) is the graphics object handle.'  'SETUP (query, scalar) sets all figure props.'  'AUTOPOS (figure, logical) determines whether the position is adjusted automatically.'  'X0 (figure, scalar) is the lower left x-coordinate of the panel in pixels.'  'Y0 (figure, scalar) is the lower-left y-coordinate of the panel in pixels.'  'WIDTH (figure, size) is the width of the panel in pixels.'  'HEIGHT (figure, size) is the height of the panel in pixels.' };
			prop_description = settingsposition_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsPosition, POINTER) returns settings of POINTER of SettingsPosition.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsPosition, POINTER) returns settings of POINTER of SettingsPosition.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsPosition.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SettingsPosition.AUTOPOS
					prop_settings = Format.getFormatSettings(4);
				case 16 % SettingsPosition.X0
					prop_settings = Format.getFormatSettings(11);
				case 17 % SettingsPosition.Y0
					prop_settings = Format.getFormatSettings(11);
				case 18 % SettingsPosition.WIDTH
					prop_settings = Format.getFormatSettings(22);
				case 19 % SettingsPosition.HEIGHT
					prop_settings = Format.getFormatSettings(22);
				case 4 % SettingsPosition.TEMPLATE
					prop_settings = 'SettingsPosition';
				otherwise
					prop_settings = getPropSettings@Settings(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsPosition.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsPosition.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsPosition, POINTER) returns the default value of POINTER of SettingsPosition.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsPosition, POINTER) returns the default value of POINTER of SettingsPosition.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsPosition.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SettingsPosition.AUTOPOS
					prop_default = true;
				case 16 % SettingsPosition.X0
					prop_default = 1;
				case 17 % SettingsPosition.Y0
					prop_default = 1;
				case 18 % SettingsPosition.WIDTH
					prop_default = 800;
				case 19 % SettingsPosition.HEIGHT
					prop_default = 600;
				case 1 % SettingsPosition.ELCLASS
					prop_default = 'SettingsPosition';
				case 2 % SettingsPosition.NAME
					prop_default = 'Posiiton Settings';
				case 3 % SettingsPosition.DESCRIPTION
					prop_default = 'A Position Settings (SettingsPosition) provides the settings for a posistion settings panel, including autopositioning, x0, y0, height and width. The handle can be an uipanel.';
				case 4 % SettingsPosition.TEMPLATE
					prop_default = Format.getFormatDefault(8, SettingsPosition.getPropSettings(prop));
				case 5 % SettingsPosition.ID
					prop_default = 'SettingsPosition ID';
				case 6 % SettingsPosition.LABEL
					prop_default = 'SettingsPosition label';
				case 7 % SettingsPosition.NOTES
					prop_default = 'SettingsPosition notes';
				otherwise
					prop_default = getPropDefault@Settings(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsPosition.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsPosition.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsPosition, POINTER) returns the conditioned default value of POINTER of SettingsPosition.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsPosition, POINTER) returns the conditioned default value of POINTER of SettingsPosition.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsPosition.getPropProp(pointer);
			
			prop_default = SettingsPosition.conditioning(prop, SettingsPosition.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsPosition, PROP, VALUE) checks VALUE format for PROP of SettingsPosition.
			%  CHECK = ST.CHECKPROP(SettingsPosition, PROP, VALUE) checks VALUE format for PROP of SettingsPosition.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SettingsPosition:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: BRAPH2:SettingsPosition:WrongInput
			%  Element.CHECKPROP(SettingsPosition, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsPosition.
			%   Error id: BRAPH2:SettingsPosition:WrongInput
			%  ST.CHECKPROP(SettingsPosition, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsPosition.
			%   Error id: BRAPH2:SettingsPosition:WrongInput]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsPosition.getPropProp(pointer);
			
			switch prop
				case 15 % SettingsPosition.AUTOPOS
					check = Format.checkFormat(4, value, SettingsPosition.getPropSettings(prop));
				case 16 % SettingsPosition.X0
					check = Format.checkFormat(11, value, SettingsPosition.getPropSettings(prop));
				case 17 % SettingsPosition.Y0
					check = Format.checkFormat(11, value, SettingsPosition.getPropSettings(prop));
				case 18 % SettingsPosition.WIDTH
					check = Format.checkFormat(22, value, SettingsPosition.getPropSettings(prop));
				case 19 % SettingsPosition.HEIGHT
					check = Format.checkFormat(22, value, SettingsPosition.getPropSettings(prop));
				case 4 % SettingsPosition.TEMPLATE
					check = Format.checkFormat(8, value, SettingsPosition.getPropSettings(prop));
				otherwise
					if prop <= 14
						check = checkProp@Settings(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsPosition:' 'WrongInput'], ...
					['BRAPH2' ':SettingsPosition:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsPosition.getPropTag(prop) ' (' SettingsPosition.getFormatTag(SettingsPosition.getPropFormat(prop)) ').'] ...
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
				case 15 % SettingsPosition.AUTOPOS
					p = st.get('H');
					if check_graphics(p, 'uipanel')
					    if st.get('AUTOPOS')
					        set(p, ...
					            'Units', 'normalized', ...
					            'Position', [0 0 1 1] ...
					            )
					        set(get(p, 'Parent'), 'Scrollable', 'off')
					    else
					        set(p, ...
					            'Units', 'pixels', ...
					            'Position', [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')] ...
					            )
					        set(get(p, 'Parent'), 'Scrollable', 'on')
					    end
					end
					
				case 16 % SettingsPosition.X0
					p = st.get('H');
					if check_graphics(p, 'uipanel')
					    if ~st.get('AUTOPOS')
					        set(p, 'Position', [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')])
					    end
					end
					
				case 17 % SettingsPosition.Y0
					p = st.get('H');
					if check_graphics(p, 'uipanel')
					    if ~st.get('AUTOPOS')
					        set(p, 'Position', [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')])
					    end
					end
					
				case 18 % SettingsPosition.WIDTH
					p = st.get('H');
					if check_graphics(p, 'uipanel')
					    if ~st.get('AUTOPOS')
					        set(p, 'Position', [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')])
					    end
					end
					
				case 19 % SettingsPosition.HEIGHT
					p = st.get('H');
					if check_graphics(p, 'uipanel')
					    if ~st.get('AUTOPOS')
					        set(p, 'Position', [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')])
					    end
					end
					
				otherwise
					if prop <= 14
						postset@Settings(st, prop);
					end
			end
		end
	end
end
