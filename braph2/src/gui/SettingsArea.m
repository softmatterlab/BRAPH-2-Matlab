classdef SettingsArea < Settings
	%SettingsArea contains the area settings.
	% It is a subclass of <a href="matlab:help Settings">Settings</a>.
	%
	% An Area Settings (SettingsArea) provides the settings for a filled area plot,
	%  including visibility, x, y, z, face color, and face alpha.
	% The handle must be a patch.
	%
	% The list of SettingsArea properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the area settings.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the area settings.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the area settings.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the area settings.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the area settings.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the area settings.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
	%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
	%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
	%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
	%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
	%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
	%  <strong>15</strong> <strong>VISIBLE</strong> 	VISIBLE (figure, logical) determines whether the symbol is visible.
	%  <strong>16</strong> <strong>X</strong> 	X (figure, rvector) is the vector of the x-coordinates.
	%  <strong>17</strong> <strong>Y</strong> 	Y (figure, rvector) is the vector of y-coordinates.
	%  <strong>18</strong> <strong>Z</strong> 	Z (figure, rvector) is the vector of the z-coordinates.
	%  <strong>19</strong> <strong>FACECOLOR</strong> 	FACECOLOR (figure, color) is the symbol RGB face color.
	%  <strong>20</strong> <strong>FACEALPHA</strong> 	FACEALPHA (figure, scalar) is the symbol RGB face color.
	%  <strong>21</strong> <strong>EDGECOLOR</strong> 	EDGECOLOR (figure, color) is the symbol RGB edge color.
	%  <strong>22</strong> <strong>EDGEALPHA</strong> 	EDGEALPHA (figure, scalar) is the symbol RGB edge color.
	%
	% SettingsArea methods (constructor):
	%  SettingsArea - constructor
	%
	% SettingsArea methods:
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
	% SettingsArea methods (display):
	%  tostring - string with information about the area settings
	%  disp - displays information about the area settings
	%  tree - displays the tree of the area settings
	%
	% SettingsArea methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two area settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the area settings
	%
	% SettingsArea methods (save/load, Static):
	%  save - saves BRAPH2 area settings as b2 file
	%  load - loads a BRAPH2 area settings from a b2 file
	%
	% SettingsArea method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the area settings
	%
	% SettingsArea method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the area settings
	%
	% SettingsArea methods (inspection, Static):
	%  getClass - returns the class of the area settings
	%  getSubclasses - returns all subclasses of SettingsArea
	%  getProps - returns the property list of the area settings
	%  getPropNumber - returns the property number of the area settings
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
	% SettingsArea methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsArea methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsArea methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsArea methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsArea; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsArea constants</a>.
	%
	%
	% See also patch, PanelFig, GUIFig.
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
		X_FORMAT = 12;
		
		Y = 17; %CET: Computational Efficiency Trick
		Y_TAG = 'Y';
		Y_CATEGORY = 8;
		Y_FORMAT = 12;
		
		Z = 18; %CET: Computational Efficiency Trick
		Z_TAG = 'Z';
		Z_CATEGORY = 8;
		Z_FORMAT = 12;
		
		FACECOLOR = 19; %CET: Computational Efficiency Trick
		FACECOLOR_TAG = 'FACECOLOR';
		FACECOLOR_CATEGORY = 8;
		FACECOLOR_FORMAT = 20;
		
		FACEALPHA = 20; %CET: Computational Efficiency Trick
		FACEALPHA_TAG = 'FACEALPHA';
		FACEALPHA_CATEGORY = 8;
		FACEALPHA_FORMAT = 11;
		
		EDGECOLOR = 21; %CET: Computational Efficiency Trick
		EDGECOLOR_TAG = 'EDGECOLOR';
		EDGECOLOR_CATEGORY = 8;
		EDGECOLOR_FORMAT = 20;
		
		EDGEALPHA = 22; %CET: Computational Efficiency Trick
		EDGEALPHA_TAG = 'EDGEALPHA';
		EDGEALPHA_CATEGORY = 8;
		EDGEALPHA_FORMAT = 11;
	end
	methods % constructor
		function st = SettingsArea(varargin)
			%SettingsArea() creates a area settings.
			%
			% SettingsArea(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsArea(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SettingsArea properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the area settings.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the area settings.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the area settings.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the area settings.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the area settings.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the area settings.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
			%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
			%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
			%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
			%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
			%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
			%  <strong>15</strong> <strong>VISIBLE</strong> 	VISIBLE (figure, logical) determines whether the symbol is visible.
			%  <strong>16</strong> <strong>X</strong> 	X (figure, rvector) is the vector of the x-coordinates.
			%  <strong>17</strong> <strong>Y</strong> 	Y (figure, rvector) is the vector of y-coordinates.
			%  <strong>18</strong> <strong>Z</strong> 	Z (figure, rvector) is the vector of the z-coordinates.
			%  <strong>19</strong> <strong>FACECOLOR</strong> 	FACECOLOR (figure, color) is the symbol RGB face color.
			%  <strong>20</strong> <strong>FACEALPHA</strong> 	FACEALPHA (figure, scalar) is the symbol RGB face color.
			%  <strong>21</strong> <strong>EDGECOLOR</strong> 	EDGECOLOR (figure, color) is the symbol RGB edge color.
			%  <strong>22</strong> <strong>EDGEALPHA</strong> 	EDGEALPHA (figure, scalar) is the symbol RGB edge color.
			%
			% See also Category, Format.
			
			st = st@Settings(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the area settings.
			%
			% BUILD = SettingsArea.GETBUILD() returns the build of 'SettingsArea'.
			%
			% Alternative forms to call this method are:
			%  BUILD = ST.GETBUILD() returns the build of the area settings ST.
			%  BUILD = Element.GETBUILD(ST) returns the build of 'ST'.
			%  BUILD = Element.GETBUILD('SettingsArea') returns the build of 'SettingsArea'.
			%
			% Note that the Element.GETBUILD(ST) and Element.GETBUILD('SettingsArea')
			%  are less computationally efficient.
			
			build = 1;
		end
		function st_class = getClass()
			%GETCLASS returns the class of the area settings.
			%
			% CLASS = SettingsArea.GETCLASS() returns the class 'SettingsArea'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the area settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsArea') returns 'SettingsArea'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsArea')
			%  are less computationally efficient.
			
			st_class = 'SettingsArea';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the area settings.
			%
			% LIST = SettingsArea.GETSUBCLASSES() returns all subclasses of 'SettingsArea'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the area settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsArea') returns all subclasses of 'SettingsArea'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsArea')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SettingsArea' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of area settings.
			%
			% PROPS = SettingsArea.GETPROPS() returns the property list of area settings
			%  as a row vector.
			%
			% PROPS = SettingsArea.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the area settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsArea'[, CATEGORY]) returns the property list of 'SettingsArea'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsArea')
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
			%GETPROPNUMBER returns the property number of area settings.
			%
			% N = SettingsArea.GETPROPNUMBER() returns the property number of area settings.
			%
			% N = SettingsArea.GETPROPNUMBER(CATEGORY) returns the property number of area settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the area settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsArea') returns the property number of 'SettingsArea'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsArea')
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
			%EXISTSPROP checks whether property exists in area settings/error.
			%
			% CHECK = SettingsArea.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsArea, PROP) checks whether PROP exists for SettingsArea.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsArea:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsArea:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsArea:WrongInput]
			%  Element.EXISTSPROP(SettingsArea, PROP) throws error if PROP does NOT exist for SettingsArea.
			%   Error id: [BRAPH2:SettingsArea:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsArea')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 22 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsArea:' 'WrongInput'], ...
					['BRAPH2' ':SettingsArea:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsArea.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in area settings/error.
			%
			% CHECK = SettingsArea.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsArea, TAG) checks whether TAG exists for SettingsArea.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsArea:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsArea:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsArea:WrongInput]
			%  Element.EXISTSTAG(SettingsArea, TAG) throws error if TAG does NOT exist for SettingsArea.
			%   Error id: [BRAPH2:SettingsArea:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsArea')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'VISIBLE'  'X'  'Y'  'Z'  'FACECOLOR'  'FACEALPHA'  'EDGECOLOR'  'EDGEALPHA' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsArea:' 'WrongInput'], ...
					['BRAPH2' ':SettingsArea:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SettingsArea.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsArea, POINTER) returns property number of POINTER of SettingsArea.
			%  PROPERTY = ST.GETPROPPROP(SettingsArea, POINTER) returns property number of POINTER of SettingsArea.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsArea')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'VISIBLE'  'X'  'Y'  'Z'  'FACECOLOR'  'FACEALPHA'  'EDGECOLOR'  'EDGEALPHA' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(SettingsArea, POINTER) returns tag of POINTER of SettingsArea.
			%  TAG = ST.GETPROPTAG(SettingsArea, POINTER) returns tag of POINTER of SettingsArea.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsArea')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				settingsarea_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'VISIBLE'  'X'  'Y'  'Z'  'FACECOLOR'  'FACEALPHA'  'EDGECOLOR'  'EDGEALPHA' };
				tag = settingsarea_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsArea, POINTER) returns category of POINTER of SettingsArea.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsArea, POINTER) returns category of POINTER of SettingsArea.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsArea')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsArea.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsarea_category_list = { 1  1  1  3  4  2  2  6  9  9  9  9  6  6  8  8  8  8  8  8  8  8 };
			prop_category = settingsarea_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsArea, POINTER) returns format of POINTER of SettingsArea.
			%  FORMAT = ST.GETPROPFORMAT(SettingsArea, POINTER) returns format of POINTER of SettingsArea.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsArea')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsArea.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsarea_format_list = { 2  2  2  8  2  2  2  2  8  11  2  11  18  11  4  12  12  12  20  11  20  11 };
			prop_format = settingsarea_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsArea, POINTER) returns description of POINTER of SettingsArea.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsArea, POINTER) returns description of POINTER of SettingsArea.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsArea')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsArea.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsarea_description_list = { 'ELCLASS (constant, string) is the class of the concrete element.'  'NAME (constant, string) is the name of the area settings.'  'DESCRIPTION (constant, string) is the description of the area settings.'  'TEMPLATE (parameter, item) is the template of the area settings.'  'ID (data, string) is a few-letter code for the area settings.'  'LABEL (metadata, string) is an extended label of the area settings.'  'NOTES (metadata, string) are some specific notes about the area settings.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'PANEL (gui, item) is the panel to which the graphics object belongs.'  'PROP (gui, scalar) is the prop of the graphics handle(list).'  'TAG (gui, string) is the tag of the graphics handle(s).'  'I (gui, scalar) is the index of the handle, used only by handlelists.'  'H (query, handle) is the graphics object handle.'  'SETUP (query, scalar) sets all figure props.'  'VISIBLE (figure, logical) determines whether the symbol is visible.'  'X (figure, rvector) is the vector of the x-coordinates.'  'Y (figure, rvector) is the vector of y-coordinates.'  'Z (figure, rvector) is the vector of the z-coordinates.'  'FACECOLOR (figure, color) is the symbol RGB face color.'  'FACEALPHA (figure, scalar) is the symbol RGB face color.'  'EDGECOLOR (figure, color) is the symbol RGB edge color.'  'EDGEALPHA (figure, scalar) is the symbol RGB edge color.' };
			prop_description = settingsarea_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsArea, POINTER) returns settings of POINTER of SettingsArea.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsArea, POINTER) returns settings of POINTER of SettingsArea.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsArea')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsArea.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SettingsArea.VISIBLE
					prop_settings = Format.getFormatSettings(4);
				case 16 % SettingsArea.X
					prop_settings = Format.getFormatSettings(12);
				case 17 % SettingsArea.Y
					prop_settings = Format.getFormatSettings(12);
				case 18 % SettingsArea.Z
					prop_settings = Format.getFormatSettings(12);
				case 19 % SettingsArea.FACECOLOR
					prop_settings = Format.getFormatSettings(20);
				case 20 % SettingsArea.FACEALPHA
					prop_settings = Format.getFormatSettings(11);
				case 21 % SettingsArea.EDGECOLOR
					prop_settings = Format.getFormatSettings(20);
				case 22 % SettingsArea.EDGEALPHA
					prop_settings = Format.getFormatSettings(11);
				case 4 % SettingsArea.TEMPLATE
					prop_settings = 'SettingsArea';
				otherwise
					prop_settings = getPropSettings@Settings(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsArea.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsArea.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsArea, POINTER) returns the default value of POINTER of SettingsArea.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsArea, POINTER) returns the default value of POINTER of SettingsArea.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsArea')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsArea.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SettingsArea.VISIBLE
					prop_default = true;
				case 16 % SettingsArea.X
					prop_default = Format.getFormatDefault(12, SettingsArea.getPropSettings(prop));
				case 17 % SettingsArea.Y
					prop_default = Format.getFormatDefault(12, SettingsArea.getPropSettings(prop));
				case 18 % SettingsArea.Z
					prop_default = Format.getFormatDefault(12, SettingsArea.getPropSettings(prop));
				case 19 % SettingsArea.FACECOLOR
					prop_default = [0.9 0.4 0.1];
				case 20 % SettingsArea.FACEALPHA
					prop_default = 0.5;
				case 21 % SettingsArea.EDGECOLOR
					prop_default = [0 0 0];
				case 22 % SettingsArea.EDGEALPHA
					prop_default = 0;
				case 1 % SettingsArea.ELCLASS
					prop_default = 'SettingsArea';
				case 2 % SettingsArea.NAME
					prop_default = 'Area Settings';
				case 3 % SettingsArea.DESCRIPTION
					prop_default = 'An Area Settings (SettingsArea) provides the settings for a filled area plot, including visibility, x, y, z, face color, and face alpha. The handle must be a patch.';
				case 4 % SettingsArea.TEMPLATE
					prop_default = Format.getFormatDefault(8, SettingsArea.getPropSettings(prop));
				case 5 % SettingsArea.ID
					prop_default = 'SettingsArea ID';
				case 6 % SettingsArea.LABEL
					prop_default = 'SettingsArea label';
				case 7 % SettingsArea.NOTES
					prop_default = 'SettingsArea notes';
				otherwise
					prop_default = getPropDefault@Settings(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsArea.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsArea.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsArea, POINTER) returns the conditioned default value of POINTER of SettingsArea.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsArea, POINTER) returns the conditioned default value of POINTER of SettingsArea.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsArea')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsArea.getPropProp(pointer);
			
			prop_default = SettingsArea.conditioning(prop, SettingsArea.getPropDefault(prop));
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			%CONDITIONING conditions a value before setting a property.
			%
			% VALUE = CONDITIONING(EL, PROP, VALUE) conditions the value VALUE before
			%  it is set as the value of the property PROP.
			%  By default, this function does not do anything, so it should be
			%  implemented in the subclasses of Element when needed.
			%
			% Conditioning is only used for props of 2,
			%  3, 4, 8 and 9.
			%
			% See also preset, checkProp, postset, postprocessing, calculateValue,
			%  checkValue.
			
			prop = SettingsArea.getPropProp(pointer);
			
			switch prop
				case 16 % SettingsArea.X
					value = value(:)';
					
				case 17 % SettingsArea.Y
					value = value(:)';
					
				case 18 % SettingsArea.Z
					value = value(:)';
					
				otherwise
					if prop <= 14
						value = conditioning@Settings(pointer, value);
					end
			end
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
			%  CHECK = Element.CHECKPROP(SettingsArea, PROP, VALUE) checks VALUE format for PROP of SettingsArea.
			%  CHECK = ST.CHECKPROP(SettingsArea, PROP, VALUE) checks VALUE format for PROP of SettingsArea.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SettingsArea:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: BRAPH2:SettingsArea:WrongInput
			%  Element.CHECKPROP(SettingsArea, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsArea.
			%   Error id: BRAPH2:SettingsArea:WrongInput
			%  ST.CHECKPROP(SettingsArea, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsArea.
			%   Error id: BRAPH2:SettingsArea:WrongInput]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsArea')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsArea.getPropProp(pointer);
			
			switch prop
				case 15 % SettingsArea.VISIBLE
					check = Format.checkFormat(4, value, SettingsArea.getPropSettings(prop));
				case 16 % SettingsArea.X
					check = Format.checkFormat(12, value, SettingsArea.getPropSettings(prop));
				case 17 % SettingsArea.Y
					check = Format.checkFormat(12, value, SettingsArea.getPropSettings(prop));
				case 18 % SettingsArea.Z
					check = Format.checkFormat(12, value, SettingsArea.getPropSettings(prop));
				case 19 % SettingsArea.FACECOLOR
					check = Format.checkFormat(20, value, SettingsArea.getPropSettings(prop));
				case 20 % SettingsArea.FACEALPHA
					check = Format.checkFormat(11, value, SettingsArea.getPropSettings(prop));
				case 21 % SettingsArea.EDGECOLOR
					check = Format.checkFormat(20, value, SettingsArea.getPropSettings(prop));
				case 22 % SettingsArea.EDGEALPHA
					check = Format.checkFormat(11, value, SettingsArea.getPropSettings(prop));
				case 4 % SettingsArea.TEMPLATE
					check = Format.checkFormat(8, value, SettingsArea.getPropSettings(prop));
				otherwise
					if prop <= 14
						check = checkProp@Settings(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsArea:' 'WrongInput'], ...
					['BRAPH2' ':SettingsArea:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsArea.getPropTag(prop) ' (' SettingsArea.getFormatTag(SettingsArea.getPropFormat(prop)) ').'] ...
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
				case 15 % SettingsArea.VISIBLE
					h = st.get('H');
					if check_graphics(h, 'patch') && ( ...
					        get(h, 'Visible') ~= st.get('VISIBLE') || ...
					        ~isequal(get(h, 'XData'), st.get('X')) || ...
					        ~isequal(get(h, 'YData'), st.get('Y')) || ...
					        ~isequal(get(h, 'ZData'), st.get('Z')) || ...
					        ~isequal(get(h, 'FaceColor'), st.get('FACEALPHA')) || ...
					        get(h, 'FaceAlpha') ~= st.get('FACEALPHA') || ...
					        ~isequal(get(h, 'EdgeColor'), st.get('EDGEALPHA')) || ...
					        get(h, 'EdgeAlpha') ~= st.get('EDGEALPHA') ...
					        )
					    if st.get('VISIBLE')
					        set(h, ...
					            'XData', st.get('X'), ...
					            'YData', st.get('Y'), ...
					            'ZData', st.get('Z'), ...
					            'FaceColor', st.get('FACECOLOR'), ...
					            'FaceAlpha', st.get('FACEALPHA'), ...
					            'EdgeColor', st.get('EDGECOLOR'), ...
					            'EdgeAlpha', st.get('EDGEALPHA'), ...
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
