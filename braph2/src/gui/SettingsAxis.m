classdef SettingsAxis < Settings
	%SettingsAxis contains the axis settings.
	% It is a subclass of <a href="matlab:help Settings">Settings</a>.
	%
	% An Axis Settings (SettingsAxis) provides the settings for an axis, 
	%  including axis color, hold on/off, axis on/off, grid on/off, equal on/off, 
	%  box on/off, and tight on/off.
	% The handle can be an axes (uiaxes).
	%
	% The list of SettingsAxis properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the axis settings.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the axis settings.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the axis settings.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the axis settings.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the axis settings.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the axis settings.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the axis settings.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
	%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
	%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
	%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
	%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
	%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
	%  <strong>15</strong> <strong>AXISCOLOR</strong> 	AXISCOLOR (figure, color) is the axis background color.
	%  <strong>16</strong> <strong>HOLD</strong> 	HOLD (figure, logical) determines whether hold is on or off.
	%  <strong>17</strong> <strong>GRID</strong> 	GRID (figure, logical) determines whether the grid is shown.
	%  <strong>18</strong> <strong>AXIS</strong> 	AXIS (figure, logical) determines whether the axis is shown.
	%  <strong>19</strong> <strong>EQUAL</strong> 	EQUAL (figure, logical) determines whether the axis are equal.
	%  <strong>20</strong> <strong>TIGHT</strong> 	TIGHT (figure, logical) determines whether the axis are tight.
	%  <strong>21</strong> <strong>BOX</strong> 	BOX (figure, logical) determines whether the axis are boxed.
	%
	% SettingsAxis methods (constructor):
	%  SettingsAxis - constructor
	%
	% SettingsAxis methods:
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
	% SettingsAxis methods (display):
	%  tostring - string with information about the axis settings
	%  disp - displays information about the axis settings
	%  tree - displays the tree of the axis settings
	%
	% SettingsAxis methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two axis settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the axis settings
	%
	% SettingsAxis methods (save/load, Static):
	%  save - saves BRAPH2 axis settings as b2 file
	%  load - loads a BRAPH2 axis settings from a b2 file
	%
	% SettingsAxis method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the axis settings
	%
	% SettingsAxis method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the axis settings
	%
	% SettingsAxis methods (inspection, Static):
	%  getClass - returns the class of the axis settings
	%  getSubclasses - returns all subclasses of SettingsAxis
	%  getProps - returns the property list of the axis settings
	%  getPropNumber - returns the property number of the axis settings
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
	% SettingsAxis methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsAxis methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsAxis methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsAxis methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsAxis; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsAxis constants</a>.
	%
	%
	% See also uiaxes, SettingsAxisPP, PanelFig, GUIFig, check_graphics.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		AXISCOLOR = 15; %CET: Computational Efficiency Trick
		AXISCOLOR_TAG = 'AXISCOLOR';
		AXISCOLOR_CATEGORY = 8;
		AXISCOLOR_FORMAT = 20;
		
		HOLD = 16; %CET: Computational Efficiency Trick
		HOLD_TAG = 'HOLD';
		HOLD_CATEGORY = 8;
		HOLD_FORMAT = 4;
		
		GRID = 17; %CET: Computational Efficiency Trick
		GRID_TAG = 'GRID';
		GRID_CATEGORY = 8;
		GRID_FORMAT = 4;
		
		AXIS = 18; %CET: Computational Efficiency Trick
		AXIS_TAG = 'AXIS';
		AXIS_CATEGORY = 8;
		AXIS_FORMAT = 4;
		
		EQUAL = 19; %CET: Computational Efficiency Trick
		EQUAL_TAG = 'EQUAL';
		EQUAL_CATEGORY = 8;
		EQUAL_FORMAT = 4;
		
		TIGHT = 20; %CET: Computational Efficiency Trick
		TIGHT_TAG = 'TIGHT';
		TIGHT_CATEGORY = 8;
		TIGHT_FORMAT = 4;
		
		BOX = 21; %CET: Computational Efficiency Trick
		BOX_TAG = 'BOX';
		BOX_CATEGORY = 8;
		BOX_FORMAT = 4;
	end
	methods % constructor
		function st = SettingsAxis(varargin)
			%SettingsAxis() creates a axis settings.
			%
			% SettingsAxis(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsAxis(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SettingsAxis properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the axis settings.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the axis settings.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the axis settings.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the axis settings.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the axis settings.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the axis settings.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the axis settings.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
			%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
			%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
			%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
			%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
			%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
			%  <strong>15</strong> <strong>AXISCOLOR</strong> 	AXISCOLOR (figure, color) is the axis background color.
			%  <strong>16</strong> <strong>HOLD</strong> 	HOLD (figure, logical) determines whether hold is on or off.
			%  <strong>17</strong> <strong>GRID</strong> 	GRID (figure, logical) determines whether the grid is shown.
			%  <strong>18</strong> <strong>AXIS</strong> 	AXIS (figure, logical) determines whether the axis is shown.
			%  <strong>19</strong> <strong>EQUAL</strong> 	EQUAL (figure, logical) determines whether the axis are equal.
			%  <strong>20</strong> <strong>TIGHT</strong> 	TIGHT (figure, logical) determines whether the axis are tight.
			%  <strong>21</strong> <strong>BOX</strong> 	BOX (figure, logical) determines whether the axis are boxed.
			%
			% See also Category, Format.
			
			st = st@Settings(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the axis settings.
			%
			% BUILD = SettingsAxis.GETBUILD() returns the build of 'SettingsAxis'.
			%
			% Alternative forms to call this method are:
			%  BUILD = ST.GETBUILD() returns the build of the axis settings ST.
			%  BUILD = Element.GETBUILD(ST) returns the build of 'ST'.
			%  BUILD = Element.GETBUILD('SettingsAxis') returns the build of 'SettingsAxis'.
			%
			% Note that the Element.GETBUILD(ST) and Element.GETBUILD('SettingsAxis')
			%  are less computationally efficient.
			
			build = 1;
		end
		function st_class = getClass()
			%GETCLASS returns the class of the axis settings.
			%
			% CLASS = SettingsAxis.GETCLASS() returns the class 'SettingsAxis'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the axis settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsAxis') returns 'SettingsAxis'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsAxis')
			%  are less computationally efficient.
			
			st_class = 'SettingsAxis';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the axis settings.
			%
			% LIST = SettingsAxis.GETSUBCLASSES() returns all subclasses of 'SettingsAxis'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the axis settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsAxis') returns all subclasses of 'SettingsAxis'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SettingsAxis' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of axis settings.
			%
			% PROPS = SettingsAxis.GETPROPS() returns the property list of axis settings
			%  as a row vector.
			%
			% PROPS = SettingsAxis.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the axis settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsAxis'[, CATEGORY]) returns the property list of 'SettingsAxis'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21];
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
					prop_list = [15 16 17 18 19 20 21];
				case 9 % Category.GUI
					prop_list = [9 10 11 12];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of axis settings.
			%
			% N = SettingsAxis.GETPROPNUMBER() returns the property number of axis settings.
			%
			% N = SettingsAxis.GETPROPNUMBER(CATEGORY) returns the property number of axis settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the axis settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsAxis') returns the property number of 'SettingsAxis'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 21;
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
					prop_number = 7;
				case 9 % Category.GUI
					prop_number = 4;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in axis settings/error.
			%
			% CHECK = SettingsAxis.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsAxis, PROP) checks whether PROP exists for SettingsAxis.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsAxis:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsAxis:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsAxis:WrongInput]
			%  Element.EXISTSPROP(SettingsAxis, PROP) throws error if PROP does NOT exist for SettingsAxis.
			%   Error id: [BRAPH2:SettingsAxis:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 21 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsAxis:' 'WrongInput'], ...
					['BRAPH2' ':SettingsAxis:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsAxis.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in axis settings/error.
			%
			% CHECK = SettingsAxis.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsAxis, TAG) checks whether TAG exists for SettingsAxis.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsAxis:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsAxis:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsAxis:WrongInput]
			%  Element.EXISTSTAG(SettingsAxis, TAG) throws error if TAG does NOT exist for SettingsAxis.
			%   Error id: [BRAPH2:SettingsAxis:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'AXISCOLOR'  'HOLD'  'GRID'  'AXIS'  'EQUAL'  'TIGHT'  'BOX' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsAxis:' 'WrongInput'], ...
					['BRAPH2' ':SettingsAxis:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SettingsAxis.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsAxis, POINTER) returns property number of POINTER of SettingsAxis.
			%  PROPERTY = ST.GETPROPPROP(SettingsAxis, POINTER) returns property number of POINTER of SettingsAxis.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'AXISCOLOR'  'HOLD'  'GRID'  'AXIS'  'EQUAL'  'TIGHT'  'BOX' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(SettingsAxis, POINTER) returns tag of POINTER of SettingsAxis.
			%  TAG = ST.GETPROPTAG(SettingsAxis, POINTER) returns tag of POINTER of SettingsAxis.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				settingsaxis_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'AXISCOLOR'  'HOLD'  'GRID'  'AXIS'  'EQUAL'  'TIGHT'  'BOX' };
				tag = settingsaxis_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsAxis, POINTER) returns category of POINTER of SettingsAxis.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsAxis, POINTER) returns category of POINTER of SettingsAxis.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAxis.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsaxis_category_list = { 1  1  1  3  4  2  2  6  9  9  9  9  6  6  8  8  8  8  8  8  8 };
			prop_category = settingsaxis_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsAxis, POINTER) returns format of POINTER of SettingsAxis.
			%  FORMAT = ST.GETPROPFORMAT(SettingsAxis, POINTER) returns format of POINTER of SettingsAxis.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAxis.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsaxis_format_list = { 2  2  2  8  2  2  2  2  8  11  2  11  18  11  20  4  4  4  4  4  4 };
			prop_format = settingsaxis_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsAxis, POINTER) returns description of POINTER of SettingsAxis.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsAxis, POINTER) returns description of POINTER of SettingsAxis.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAxis.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsaxis_description_list = { 'ELCLASS (constant, string) is the class of the axis settings.'  'NAME (constant, string) is the name of the axis settings.'  'DESCRIPTION (constant, string) is the description of the axis settings.'  'TEMPLATE (parameter, item) is the template of the axis settings.'  'ID (data, string) is a few-letter code for the axis settings.'  'LABEL (metadata, string) is an extended label of the axis settings.'  'NOTES (metadata, string) are some specific notes about the axis settings.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'PANEL (gui, item) is the panel to which the graphics object belongs.'  'PROP (gui, scalar) is the prop of the graphics handle(list).'  'TAG (gui, string) is the tag of the graphics handle(s).'  'I (gui, scalar) is the index of the handle, used only by handlelists.'  'H (query, handle) is the graphics object handle.'  'SETUP (query, scalar) sets all figure props.'  'AXISCOLOR (figure, color) is the axis background color.'  'HOLD (figure, logical) determines whether hold is on or off.'  'GRID (figure, logical) determines whether the grid is shown.'  'AXIS (figure, logical) determines whether the axis is shown.'  'EQUAL (figure, logical) determines whether the axis are equal.'  'TIGHT (figure, logical) determines whether the axis are tight.'  'BOX (figure, logical) determines whether the axis are boxed.' };
			prop_description = settingsaxis_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsAxis, POINTER) returns settings of POINTER of SettingsAxis.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsAxis, POINTER) returns settings of POINTER of SettingsAxis.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAxis.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SettingsAxis.AXISCOLOR
					prop_settings = Format.getFormatSettings(20);
				case 16 % SettingsAxis.HOLD
					prop_settings = Format.getFormatSettings(4);
				case 17 % SettingsAxis.GRID
					prop_settings = Format.getFormatSettings(4);
				case 18 % SettingsAxis.AXIS
					prop_settings = Format.getFormatSettings(4);
				case 19 % SettingsAxis.EQUAL
					prop_settings = Format.getFormatSettings(4);
				case 20 % SettingsAxis.TIGHT
					prop_settings = Format.getFormatSettings(4);
				case 21 % SettingsAxis.BOX
					prop_settings = Format.getFormatSettings(4);
				case 4 % SettingsAxis.TEMPLATE
					prop_settings = 'SettingsAxis';
				otherwise
					prop_settings = getPropSettings@Settings(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsAxis.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAxis.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsAxis, POINTER) returns the default value of POINTER of SettingsAxis.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsAxis, POINTER) returns the default value of POINTER of SettingsAxis.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsAxis.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SettingsAxis.AXISCOLOR
					prop_default = [1 1 1];
				case 16 % SettingsAxis.HOLD
					prop_default = true;
				case 17 % SettingsAxis.GRID
					prop_default = false;
				case 18 % SettingsAxis.AXIS
					prop_default = true;
				case 19 % SettingsAxis.EQUAL
					prop_default = true;
				case 20 % SettingsAxis.TIGHT
					prop_default = false;
				case 21 % SettingsAxis.BOX
					prop_default = false;
				case 1 % SettingsAxis.ELCLASS
					prop_default = 'SettingsAxis';
				case 2 % SettingsAxis.NAME
					prop_default = 'Axis Settings';
				case 3 % SettingsAxis.DESCRIPTION
					prop_default = 'An Axis Settings (SettingsAxis) provides the settings for an axis, including axis color, hold on/off, axis on/off, grid on/off, equal on/off, box on/off, and tight on/off. The handle can be an axes (uiaxes).';
				case 4 % SettingsAxis.TEMPLATE
					prop_default = Format.getFormatDefault(8, SettingsAxis.getPropSettings(prop));
				case 5 % SettingsAxis.ID
					prop_default = 'SettingsAxis ID';
				case 6 % SettingsAxis.LABEL
					prop_default = 'SettingsAxis label';
				case 7 % SettingsAxis.NOTES
					prop_default = 'SettingsAxis notes';
				otherwise
					prop_default = getPropDefault@Settings(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsAxis.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAxis.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsAxis, POINTER) returns the conditioned default value of POINTER of SettingsAxis.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsAxis, POINTER) returns the conditioned default value of POINTER of SettingsAxis.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsAxis.getPropProp(pointer);
			
			prop_default = SettingsAxis.conditioning(prop, SettingsAxis.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsAxis, PROP, VALUE) checks VALUE format for PROP of SettingsAxis.
			%  CHECK = ST.CHECKPROP(SettingsAxis, PROP, VALUE) checks VALUE format for PROP of SettingsAxis.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SettingsAxis:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: BRAPH2:SettingsAxis:WrongInput
			%  Element.CHECKPROP(SettingsAxis, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAxis.
			%   Error id: BRAPH2:SettingsAxis:WrongInput
			%  ST.CHECKPROP(SettingsAxis, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAxis.
			%   Error id: BRAPH2:SettingsAxis:WrongInput]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsAxis.getPropProp(pointer);
			
			switch prop
				case 15 % SettingsAxis.AXISCOLOR
					check = Format.checkFormat(20, value, SettingsAxis.getPropSettings(prop));
				case 16 % SettingsAxis.HOLD
					check = Format.checkFormat(4, value, SettingsAxis.getPropSettings(prop));
				case 17 % SettingsAxis.GRID
					check = Format.checkFormat(4, value, SettingsAxis.getPropSettings(prop));
				case 18 % SettingsAxis.AXIS
					check = Format.checkFormat(4, value, SettingsAxis.getPropSettings(prop));
				case 19 % SettingsAxis.EQUAL
					check = Format.checkFormat(4, value, SettingsAxis.getPropSettings(prop));
				case 20 % SettingsAxis.TIGHT
					check = Format.checkFormat(4, value, SettingsAxis.getPropSettings(prop));
				case 21 % SettingsAxis.BOX
					check = Format.checkFormat(4, value, SettingsAxis.getPropSettings(prop));
				case 4 % SettingsAxis.TEMPLATE
					check = Format.checkFormat(8, value, SettingsAxis.getPropSettings(prop));
				otherwise
					if prop <= 14
						check = checkProp@Settings(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsAxis:' 'WrongInput'], ...
					['BRAPH2' ':SettingsAxis:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsAxis.getPropTag(prop) ' (' SettingsAxis.getFormatTag(SettingsAxis.getPropFormat(prop)) ').'] ...
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
				case 15 % SettingsAxis.AXISCOLOR
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if ~isequal(get(a, 'Color'), st.get('AXISCOLOR'))
					        set(a, 'Color', st.get('AXISCOLOR'))
					    end
					end
					
				case 16 % SettingsAxis.HOLD
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if st.get('HOLD')
					        hold(a, 'on')
					    else
					        hold(a, 'off')
					    end
					end
					
				case 17 % SettingsAxis.GRID
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if st.get('GRID')
					        grid(a, 'on')
					    else
					        grid(a, 'off')
					    end
					end
					
				case 18 % SettingsAxis.AXIS
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if st.get('AXIS')
					        axis(a, 'on')
					    else
					        axis(a, 'off')
					    end
					end
					
				case 19 % SettingsAxis.EQUAL
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if st.get('EQUAL')
					        daspect(a, [1 1 1])
					    else
					        daspect(a, 'auto')
					    end
					end
					
				case 20 % SettingsAxis.TIGHT
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if st.get('TIGHT')
					        axis(a, 'tight')
					    end
					end
					
				case 21 % SettingsAxis.BOX
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if st.get('BOX')
					        box(a, 'on')
					    else
					        box(a, 'off')
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
