classdef SettingsSymbol < Settings
	%SettingsSymbol contains the symbol settings.
	% It is a subclass of <a href="matlab:help Settings">Settings</a>.
	%
	% A Symbol Settings (SettingsSymbol) provides the settings for a symbol, 
	% including visibility, x, y, z, symbol marker, symbol size, face color, and edge color.
	% The handle can be a line.
	%
	% The list of SettingsSymbol properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the symbol settings.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the symbol settings.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the symbol settings.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the symbol settings.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the symbol settings.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the symbol settings.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the symbol settings.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
	%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
	%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
	%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
	%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
	%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
	%  <strong>15</strong> <strong>VISIBLE</strong> 	VISIBLE (figure, logical) determines whether the symbol is visible.
	%  <strong>16</strong> <strong>X</strong> 	X (figure, scalar) is the x-coordinate.
	%  <strong>17</strong> <strong>Y</strong> 	Y (figure, scalar) is the y-coordinate.
	%  <strong>18</strong> <strong>Z</strong> 	Z (figure, scalar) is the z-coordinate.
	%  <strong>19</strong> <strong>SYMBOL</strong> 	SYMBOL (figure, marker) is the symbol.
	%  <strong>20</strong> <strong>SYMBOLSIZE</strong> 	SYMBOLSIZE (figure, size) is the symbol size.
	%  <strong>21</strong> <strong>EDGECOLOR</strong> 	EDGECOLOR (figure, color) is the symbol RGB edge color.
	%  <strong>22</strong> <strong>FACECOLOR</strong> 	FACECOLOR (figure, color) is the symbol RGB face color.
	%
	% SettingsSymbol methods (constructor):
	%  SettingsSymbol - constructor
	%
	% SettingsSymbol methods:
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
	% SettingsSymbol methods (display):
	%  tostring - string with information about the symbol settings
	%  disp - displays information about the symbol settings
	%  tree - displays the tree of the symbol settings
	%
	% SettingsSymbol methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two symbol settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the symbol settings
	%
	% SettingsSymbol methods (save/load, Static):
	%  save - saves BRAPH2 symbol settings as b2 file
	%  load - loads a BRAPH2 symbol settings from a b2 file
	%
	% SettingsSymbol method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the symbol settings
	%
	% SettingsSymbol method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the symbol settings
	%
	% SettingsSymbol methods (inspection, Static):
	%  getClass - returns the class of the symbol settings
	%  getSubclasses - returns all subclasses of SettingsSymbol
	%  getProps - returns the property list of the symbol settings
	%  getPropNumber - returns the property number of the symbol settings
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
	% SettingsSymbol methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsSymbol methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsSymbol methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsSymbol methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsSymbol; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsSymbol constants</a>.
	%
	%
	% See also line, PanelFig, GUIFig, check_graphics.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		VISIBLE = 15; %CET: Computational Efficiency Trick
		VISIBLE_TAG = 'VISIBLE';
		VISIBLE_CATEGORY = 8;
		VISIBLE_FORMAT = 4;
		
		X = 16; %CET: Computational Efficiency Trick
		X_TAG = 'X';
		X_CATEGORY = 8;
		X_FORMAT = 11;
		
		Y = 17; %CET: Computational Efficiency Trick
		Y_TAG = 'Y';
		Y_CATEGORY = 8;
		Y_FORMAT = 11;
		
		Z = 18; %CET: Computational Efficiency Trick
		Z_TAG = 'Z';
		Z_CATEGORY = 8;
		Z_FORMAT = 11;
		
		SYMBOL = 19; %CET: Computational Efficiency Trick
		SYMBOL_TAG = 'SYMBOL';
		SYMBOL_CATEGORY = 8;
		SYMBOL_FORMAT = 23;
		
		SYMBOLSIZE = 20; %CET: Computational Efficiency Trick
		SYMBOLSIZE_TAG = 'SYMBOLSIZE';
		SYMBOLSIZE_CATEGORY = 8;
		SYMBOLSIZE_FORMAT = 22;
		
		EDGECOLOR = 21; %CET: Computational Efficiency Trick
		EDGECOLOR_TAG = 'EDGECOLOR';
		EDGECOLOR_CATEGORY = 8;
		EDGECOLOR_FORMAT = 20;
		
		FACECOLOR = 22; %CET: Computational Efficiency Trick
		FACECOLOR_TAG = 'FACECOLOR';
		FACECOLOR_CATEGORY = 8;
		FACECOLOR_FORMAT = 20;
	end
	methods % constructor
		function st = SettingsSymbol(varargin)
			%SettingsSymbol() creates a symbol settings.
			%
			% SettingsSymbol(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsSymbol(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SettingsSymbol properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the symbol settings.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the symbol settings.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the symbol settings.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the symbol settings.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the symbol settings.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the symbol settings.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the symbol settings.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
			%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
			%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
			%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
			%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
			%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
			%  <strong>15</strong> <strong>VISIBLE</strong> 	VISIBLE (figure, logical) determines whether the symbol is visible.
			%  <strong>16</strong> <strong>X</strong> 	X (figure, scalar) is the x-coordinate.
			%  <strong>17</strong> <strong>Y</strong> 	Y (figure, scalar) is the y-coordinate.
			%  <strong>18</strong> <strong>Z</strong> 	Z (figure, scalar) is the z-coordinate.
			%  <strong>19</strong> <strong>SYMBOL</strong> 	SYMBOL (figure, marker) is the symbol.
			%  <strong>20</strong> <strong>SYMBOLSIZE</strong> 	SYMBOLSIZE (figure, size) is the symbol size.
			%  <strong>21</strong> <strong>EDGECOLOR</strong> 	EDGECOLOR (figure, color) is the symbol RGB edge color.
			%  <strong>22</strong> <strong>FACECOLOR</strong> 	FACECOLOR (figure, color) is the symbol RGB face color.
			%
			% See also Category, Format.
			
			st = st@Settings(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the symbol settings.
			%
			% BUILD = SettingsSymbol.GETBUILD() returns the build of 'SettingsSymbol'.
			%
			% Alternative forms to call this method are:
			%  BUILD = ST.GETBUILD() returns the build of the symbol settings ST.
			%  BUILD = Element.GETBUILD(ST) returns the build of 'ST'.
			%  BUILD = Element.GETBUILD('SettingsSymbol') returns the build of 'SettingsSymbol'.
			%
			% Note that the Element.GETBUILD(ST) and Element.GETBUILD('SettingsSymbol')
			%  are less computationally efficient.
			
			build = 1;
		end
		function st_class = getClass()
			%GETCLASS returns the class of the symbol settings.
			%
			% CLASS = SettingsSymbol.GETCLASS() returns the class 'SettingsSymbol'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the symbol settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsSymbol') returns 'SettingsSymbol'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsSymbol')
			%  are less computationally efficient.
			
			st_class = 'SettingsSymbol';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the symbol settings.
			%
			% LIST = SettingsSymbol.GETSUBCLASSES() returns all subclasses of 'SettingsSymbol'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the symbol settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsSymbol') returns all subclasses of 'SettingsSymbol'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SettingsSymbol' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of symbol settings.
			%
			% PROPS = SettingsSymbol.GETPROPS() returns the property list of symbol settings
			%  as a row vector.
			%
			% PROPS = SettingsSymbol.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the symbol settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsSymbol'[, CATEGORY]) returns the property list of 'SettingsSymbol'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22];
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
					prop_list = [15 16 17 18 19 20 21 22];
				case 9 % Category.GUI
					prop_list = [9 10 11 12];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of symbol settings.
			%
			% N = SettingsSymbol.GETPROPNUMBER() returns the property number of symbol settings.
			%
			% N = SettingsSymbol.GETPROPNUMBER(CATEGORY) returns the property number of symbol settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the symbol settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsSymbol') returns the property number of 'SettingsSymbol'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 22;
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
					prop_number = 8;
				case 9 % Category.GUI
					prop_number = 4;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in symbol settings/error.
			%
			% CHECK = SettingsSymbol.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsSymbol, PROP) checks whether PROP exists for SettingsSymbol.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsSymbol:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSymbol:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSymbol:WrongInput]
			%  Element.EXISTSPROP(SettingsSymbol, PROP) throws error if PROP does NOT exist for SettingsSymbol.
			%   Error id: [BRAPH2:SettingsSymbol:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 22 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsSymbol:' 'WrongInput'], ...
					['BRAPH2' ':SettingsSymbol:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsSymbol.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in symbol settings/error.
			%
			% CHECK = SettingsSymbol.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsSymbol, TAG) checks whether TAG exists for SettingsSymbol.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsSymbol:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSymbol:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSymbol:WrongInput]
			%  Element.EXISTSTAG(SettingsSymbol, TAG) throws error if TAG does NOT exist for SettingsSymbol.
			%   Error id: [BRAPH2:SettingsSymbol:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'VISIBLE'  'X'  'Y'  'Z'  'SYMBOL'  'SYMBOLSIZE'  'EDGECOLOR'  'FACECOLOR' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsSymbol:' 'WrongInput'], ...
					['BRAPH2' ':SettingsSymbol:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SettingsSymbol.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsSymbol, POINTER) returns property number of POINTER of SettingsSymbol.
			%  PROPERTY = ST.GETPROPPROP(SettingsSymbol, POINTER) returns property number of POINTER of SettingsSymbol.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'VISIBLE'  'X'  'Y'  'Z'  'SYMBOL'  'SYMBOLSIZE'  'EDGECOLOR'  'FACECOLOR' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(SettingsSymbol, POINTER) returns tag of POINTER of SettingsSymbol.
			%  TAG = ST.GETPROPTAG(SettingsSymbol, POINTER) returns tag of POINTER of SettingsSymbol.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				settingssymbol_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'VISIBLE'  'X'  'Y'  'Z'  'SYMBOL'  'SYMBOLSIZE'  'EDGECOLOR'  'FACECOLOR' };
				tag = settingssymbol_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsSymbol, POINTER) returns category of POINTER of SettingsSymbol.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsSymbol, POINTER) returns category of POINTER of SettingsSymbol.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsSymbol.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingssymbol_category_list = { 1  1  1  3  4  2  2  6  9  9  9  9  6  6  8  8  8  8  8  8  8  8 };
			prop_category = settingssymbol_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsSymbol, POINTER) returns format of POINTER of SettingsSymbol.
			%  FORMAT = ST.GETPROPFORMAT(SettingsSymbol, POINTER) returns format of POINTER of SettingsSymbol.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsSymbol.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingssymbol_format_list = { 2  2  2  8  2  2  2  2  8  11  2  11  18  11  4  11  11  11  23  22  20  20 };
			prop_format = settingssymbol_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsSymbol, POINTER) returns description of POINTER of SettingsSymbol.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsSymbol, POINTER) returns description of POINTER of SettingsSymbol.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsSymbol.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingssymbol_description_list = { 'ELCLASS (constant, string) is the class of the symbol settings.'  'NAME (constant, string) is the name of the symbol settings.'  'DESCRIPTION (constant, string) is the description of the symbol settings.'  'TEMPLATE (parameter, item) is the template of the symbol settings.'  'ID (data, string) is a few-letter code for the symbol settings.'  'LABEL (metadata, string) is an extended label of the symbol settings.'  'NOTES (metadata, string) are some specific notes about the symbol settings.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'PANEL (gui, item) is the panel to which the graphics object belongs.'  'PROP (gui, scalar) is the prop of the graphics handle(list).'  'TAG (gui, string) is the tag of the graphics handle(s).'  'I (gui, scalar) is the index of the handle, used only by handlelists.'  'H (query, handle) is the graphics object handle.'  'SETUP (query, scalar) sets all figure props.'  'VISIBLE (figure, logical) determines whether the symbol is visible.'  'X (figure, scalar) is the x-coordinate.'  'Y (figure, scalar) is the y-coordinate.'  'Z (figure, scalar) is the z-coordinate.'  'SYMBOL (figure, marker) is the symbol.'  'SYMBOLSIZE (figure, size) is the symbol size.'  'EDGECOLOR (figure, color) is the symbol RGB edge color.'  'FACECOLOR (figure, color) is the symbol RGB face color.' };
			prop_description = settingssymbol_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsSymbol, POINTER) returns settings of POINTER of SettingsSymbol.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsSymbol, POINTER) returns settings of POINTER of SettingsSymbol.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsSymbol.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SettingsSymbol.VISIBLE
					prop_settings = Format.getFormatSettings(4);
				case 16 % SettingsSymbol.X
					prop_settings = Format.getFormatSettings(11);
				case 17 % SettingsSymbol.Y
					prop_settings = Format.getFormatSettings(11);
				case 18 % SettingsSymbol.Z
					prop_settings = Format.getFormatSettings(11);
				case 19 % SettingsSymbol.SYMBOL
					prop_settings = Format.getFormatSettings(23);
				case 20 % SettingsSymbol.SYMBOLSIZE
					prop_settings = Format.getFormatSettings(22);
				case 21 % SettingsSymbol.EDGECOLOR
					prop_settings = Format.getFormatSettings(20);
				case 22 % SettingsSymbol.FACECOLOR
					prop_settings = Format.getFormatSettings(20);
				case 4 % SettingsSymbol.TEMPLATE
					prop_settings = 'SettingsSymbol';
				otherwise
					prop_settings = getPropSettings@Settings(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsSymbol.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsSymbol.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsSymbol, POINTER) returns the default value of POINTER of SettingsSymbol.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsSymbol, POINTER) returns the default value of POINTER of SettingsSymbol.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsSymbol.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SettingsSymbol.VISIBLE
					prop_default = false;
				case 16 % SettingsSymbol.X
					prop_default = Format.getFormatDefault(11, SettingsSymbol.getPropSettings(prop));
				case 17 % SettingsSymbol.Y
					prop_default = Format.getFormatDefault(11, SettingsSymbol.getPropSettings(prop));
				case 18 % SettingsSymbol.Z
					prop_default = Format.getFormatDefault(11, SettingsSymbol.getPropSettings(prop));
				case 19 % SettingsSymbol.SYMBOL
					prop_default = Format.getFormatDefault(23, SettingsSymbol.getPropSettings(prop));
				case 20 % SettingsSymbol.SYMBOLSIZE
					prop_default = 10;
				case 21 % SettingsSymbol.EDGECOLOR
					prop_default = [0 0 0];
				case 22 % SettingsSymbol.FACECOLOR
					prop_default = [0.9 0.4 0.1];
				case 1 % SettingsSymbol.ELCLASS
					prop_default = 'SettingsSymbol';
				case 2 % SettingsSymbol.NAME
					prop_default = 'Symbol Settings';
				case 3 % SettingsSymbol.DESCRIPTION
					prop_default = 'A Symbol Settings (SettingsSymbol) provides the settings for a symbol, including visibility, x, y, z, symbol marker, symbol size, face color, and edge color.';
				case 4 % SettingsSymbol.TEMPLATE
					prop_default = Format.getFormatDefault(8, SettingsSymbol.getPropSettings(prop));
				case 5 % SettingsSymbol.ID
					prop_default = 'SettingsSymbol ID';
				case 6 % SettingsSymbol.LABEL
					prop_default = 'SettingsSymbol label';
				case 7 % SettingsSymbol.NOTES
					prop_default = 'SettingsSymbol notes';
				otherwise
					prop_default = getPropDefault@Settings(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsSymbol.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsSymbol.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsSymbol, POINTER) returns the conditioned default value of POINTER of SettingsSymbol.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsSymbol, POINTER) returns the conditioned default value of POINTER of SettingsSymbol.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsSymbol.getPropProp(pointer);
			
			prop_default = SettingsSymbol.conditioning(prop, SettingsSymbol.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsSymbol, PROP, VALUE) checks VALUE format for PROP of SettingsSymbol.
			%  CHECK = ST.CHECKPROP(SettingsSymbol, PROP, VALUE) checks VALUE format for PROP of SettingsSymbol.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SettingsSymbol:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: BRAPH2:SettingsSymbol:WrongInput
			%  Element.CHECKPROP(SettingsSymbol, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsSymbol.
			%   Error id: BRAPH2:SettingsSymbol:WrongInput
			%  ST.CHECKPROP(SettingsSymbol, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsSymbol.
			%   Error id: BRAPH2:SettingsSymbol:WrongInput]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsSymbol.getPropProp(pointer);
			
			switch prop
				case 15 % SettingsSymbol.VISIBLE
					check = Format.checkFormat(4, value, SettingsSymbol.getPropSettings(prop));
				case 16 % SettingsSymbol.X
					check = Format.checkFormat(11, value, SettingsSymbol.getPropSettings(prop));
				case 17 % SettingsSymbol.Y
					check = Format.checkFormat(11, value, SettingsSymbol.getPropSettings(prop));
				case 18 % SettingsSymbol.Z
					check = Format.checkFormat(11, value, SettingsSymbol.getPropSettings(prop));
				case 19 % SettingsSymbol.SYMBOL
					check = Format.checkFormat(23, value, SettingsSymbol.getPropSettings(prop));
				case 20 % SettingsSymbol.SYMBOLSIZE
					check = Format.checkFormat(22, value, SettingsSymbol.getPropSettings(prop));
				case 21 % SettingsSymbol.EDGECOLOR
					check = Format.checkFormat(20, value, SettingsSymbol.getPropSettings(prop));
				case 22 % SettingsSymbol.FACECOLOR
					check = Format.checkFormat(20, value, SettingsSymbol.getPropSettings(prop));
				case 4 % SettingsSymbol.TEMPLATE
					check = Format.checkFormat(8, value, SettingsSymbol.getPropSettings(prop));
				otherwise
					if prop <= 14
						check = checkProp@Settings(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsSymbol:' 'WrongInput'], ...
					['BRAPH2' ':SettingsSymbol:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsSymbol.getPropTag(prop) ' (' SettingsSymbol.getFormatTag(SettingsSymbol.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(st, prop)
			%POSTPROCESSING postprocessesing after setting.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% The postprocessing of all properties occurs each time set is called.
			%
			% See also conditioning, preset, checkProp, postset, calculateValue,
			%  checkValue.
			
			switch prop
				case 15 % SettingsSymbol.VISIBLE
					h = st.get('H');
					if check_graphics(h, 'line') && ( ...
					        get(h, 'Visible') ~= st.get('VISIBLE') || ...
					        get(h, 'XData') ~= st.get('X') || ...
					        get(h, 'YData') ~= st.get('Y') || ...
					        get(h, 'ZData') ~= st.get('Z') || ...
					        ~isequal(get(h, 'Marker'), regexprep(st.get('SYMBOL'), 'none', '')) || ...
					        get(h, 'MarkerSize') ~= st.get('SYMBOLSIZE') || ...
					        ~isequal(get(h, 'MarkerEdgeColor'), st.get('EDGECOLOR')) || ...
					        ~isequal(get(h, 'MarkerFaceColor'), st.get('FACECOLOR')) ...
					        )
					    if st.get('VISIBLE')
					        set(h, ...
					            'XData', st.get('X'), ...
					            'YData', st.get('Y'), ...
					            'ZData', st.get('Z'), ...
					            'Marker', st.get('SYMBOL'), ...
					            'MarkerSize', st.get('SYMBOLSIZE'), ...
					            'MarkerEdgeColor', st.get('EDGECOLOR'), ...
					            'MarkerFaceColor', st.get('FACECOLOR'), ...
					            'Visible', true ...
					            )
					    else
					        set(h, 'VISIBLE', false)
					    end
					end
					
				otherwise
					if prop <= 14
						postprocessing@Settings(st, prop);
					end
			end
		end
	end
end
