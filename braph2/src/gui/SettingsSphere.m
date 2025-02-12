classdef SettingsSphere < SettingsSurface
	%SettingsSphere contains the sphere settings.
	% It is a subclass of <a href="matlab:help SettingsSurface">SettingsSurface</a>.
	%
	% A Sphere Settings (SettingsSphere) provides the settings for a sphere, 
	%  including visibility, x, y, z, radius, face color and alpha, edge color and alpha.
	% The handle can be either a patch or a surface.
	%
	% The list of SettingsSphere properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the sphere settings.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the sphere settings.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the sphere settings.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the sphere settings.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the sphere settings.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the sphere settings.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the sphere settings.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
	%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
	%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
	%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
	%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
	%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
	%  <strong>15</strong> <strong>EDGECOLOR</strong> 	EDGECOLOR (figure, color) is the RGB edge color.
	%  <strong>16</strong> <strong>EDGEALPHA</strong> 	EDGEALPHA (figure, alpha) is the edge transparency.
	%  <strong>17</strong> <strong>FACECOLOR</strong> 	FACECOLOR (figure, color) is the RGB face color.
	%  <strong>18</strong> <strong>FACEALPHA</strong> 	FACEALPHA (figure, alpha) is the face transparency.
	%  <strong>19</strong> <strong>VISIBLE</strong> 	VISIBLE (figure, logical) determines whether the sphere is visible.
	%  <strong>20</strong> <strong>X</strong> 	X (figure, scalar) is the x-coordinate.
	%  <strong>21</strong> <strong>Y</strong> 	Y (figure, scalar) is the y-coordinate.
	%  <strong>22</strong> <strong>Z</strong> 	Z (figure, scalar) is the z-coordinate.
	%  <strong>23</strong> <strong>SPHERESIZE</strong> 	SPHERESIZE (figure, size) is the sphere size.
	%
	% SettingsSphere methods (constructor):
	%  SettingsSphere - constructor
	%
	% SettingsSphere methods:
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
	% SettingsSphere methods (display):
	%  tostring - string with information about the sphere settings
	%  disp - displays information about the sphere settings
	%  tree - displays the tree of the sphere settings
	%
	% SettingsSphere methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two sphere settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the sphere settings
	%
	% SettingsSphere methods (save/load, Static):
	%  save - saves BRAPH2 sphere settings as b2 file
	%  load - loads a BRAPH2 sphere settings from a b2 file
	%
	% SettingsSphere method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the sphere settings
	%
	% SettingsSphere method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the sphere settings
	%
	% SettingsSphere methods (inspection, Static):
	%  getClass - returns the class of the sphere settings
	%  getSubclasses - returns all subclasses of SettingsSphere
	%  getProps - returns the property list of the sphere settings
	%  getPropNumber - returns the property number of the sphere settings
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
	% SettingsSphere methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsSphere methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsSphere methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsSphere methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsSphere; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsSphere constants</a>.
	%
	%
	% See also patch, surface, PanelFig, GUIFig, check_graphics.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		VISIBLE = 19; %CET: Computational Efficiency Trick
		VISIBLE_TAG = 'VISIBLE';
		VISIBLE_CATEGORY = 8;
		VISIBLE_FORMAT = 4;
		
		X = 20; %CET: Computational Efficiency Trick
		X_TAG = 'X';
		X_CATEGORY = 8;
		X_FORMAT = 11;
		
		Y = 21; %CET: Computational Efficiency Trick
		Y_TAG = 'Y';
		Y_CATEGORY = 8;
		Y_FORMAT = 11;
		
		Z = 22; %CET: Computational Efficiency Trick
		Z_TAG = 'Z';
		Z_CATEGORY = 8;
		Z_FORMAT = 11;
		
		SPHERESIZE = 23; %CET: Computational Efficiency Trick
		SPHERESIZE_TAG = 'SPHERESIZE';
		SPHERESIZE_CATEGORY = 8;
		SPHERESIZE_FORMAT = 22;
	end
	methods % constructor
		function st = SettingsSphere(varargin)
			%SettingsSphere() creates a sphere settings.
			%
			% SettingsSphere(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsSphere(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SettingsSphere properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the sphere settings.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the sphere settings.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the sphere settings.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the sphere settings.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the sphere settings.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the sphere settings.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the sphere settings.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
			%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
			%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
			%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
			%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
			%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
			%  <strong>15</strong> <strong>EDGECOLOR</strong> 	EDGECOLOR (figure, color) is the RGB edge color.
			%  <strong>16</strong> <strong>EDGEALPHA</strong> 	EDGEALPHA (figure, alpha) is the edge transparency.
			%  <strong>17</strong> <strong>FACECOLOR</strong> 	FACECOLOR (figure, color) is the RGB face color.
			%  <strong>18</strong> <strong>FACEALPHA</strong> 	FACEALPHA (figure, alpha) is the face transparency.
			%  <strong>19</strong> <strong>VISIBLE</strong> 	VISIBLE (figure, logical) determines whether the sphere is visible.
			%  <strong>20</strong> <strong>X</strong> 	X (figure, scalar) is the x-coordinate.
			%  <strong>21</strong> <strong>Y</strong> 	Y (figure, scalar) is the y-coordinate.
			%  <strong>22</strong> <strong>Z</strong> 	Z (figure, scalar) is the z-coordinate.
			%  <strong>23</strong> <strong>SPHERESIZE</strong> 	SPHERESIZE (figure, size) is the sphere size.
			%
			% See also Category, Format.
			
			st = st@SettingsSurface(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the sphere settings.
			%
			% BUILD = SettingsSphere.GETBUILD() returns the build of 'SettingsSphere'.
			%
			% Alternative forms to call this method are:
			%  BUILD = ST.GETBUILD() returns the build of the sphere settings ST.
			%  BUILD = Element.GETBUILD(ST) returns the build of 'ST'.
			%  BUILD = Element.GETBUILD('SettingsSphere') returns the build of 'SettingsSphere'.
			%
			% Note that the Element.GETBUILD(ST) and Element.GETBUILD('SettingsSphere')
			%  are less computationally efficient.
			
			build = 1;
		end
		function st_class = getClass()
			%GETCLASS returns the class of the sphere settings.
			%
			% CLASS = SettingsSphere.GETCLASS() returns the class 'SettingsSphere'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the sphere settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsSphere') returns 'SettingsSphere'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsSphere')
			%  are less computationally efficient.
			
			st_class = 'SettingsSphere';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the sphere settings.
			%
			% LIST = SettingsSphere.GETSUBCLASSES() returns all subclasses of 'SettingsSphere'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the sphere settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsSphere') returns all subclasses of 'SettingsSphere'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SettingsSphere' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of sphere settings.
			%
			% PROPS = SettingsSphere.GETPROPS() returns the property list of sphere settings
			%  as a row vector.
			%
			% PROPS = SettingsSphere.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the sphere settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsSphere'[, CATEGORY]) returns the property list of 'SettingsSphere'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23];
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
					prop_list = [15 16 17 18 19 20 21 22 23];
				case 9 % Category.GUI
					prop_list = [9 10 11 12];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of sphere settings.
			%
			% N = SettingsSphere.GETPROPNUMBER() returns the property number of sphere settings.
			%
			% N = SettingsSphere.GETPROPNUMBER(CATEGORY) returns the property number of sphere settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the sphere settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsSphere') returns the property number of 'SettingsSphere'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 23;
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
					prop_number = 9;
				case 9 % Category.GUI
					prop_number = 4;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in sphere settings/error.
			%
			% CHECK = SettingsSphere.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsSphere, PROP) checks whether PROP exists for SettingsSphere.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsSphere:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSphere:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSphere:WrongInput]
			%  Element.EXISTSPROP(SettingsSphere, PROP) throws error if PROP does NOT exist for SettingsSphere.
			%   Error id: [BRAPH2:SettingsSphere:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 23 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsSphere:' 'WrongInput'], ...
					['BRAPH2' ':SettingsSphere:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsSphere.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in sphere settings/error.
			%
			% CHECK = SettingsSphere.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsSphere, TAG) checks whether TAG exists for SettingsSphere.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsSphere:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSphere:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSphere:WrongInput]
			%  Element.EXISTSTAG(SettingsSphere, TAG) throws error if TAG does NOT exist for SettingsSphere.
			%   Error id: [BRAPH2:SettingsSphere:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'EDGECOLOR'  'EDGEALPHA'  'FACECOLOR'  'FACEALPHA'  'VISIBLE'  'X'  'Y'  'Z'  'SPHERESIZE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsSphere:' 'WrongInput'], ...
					['BRAPH2' ':SettingsSphere:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SettingsSphere.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsSphere, POINTER) returns property number of POINTER of SettingsSphere.
			%  PROPERTY = ST.GETPROPPROP(SettingsSphere, POINTER) returns property number of POINTER of SettingsSphere.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'EDGECOLOR'  'EDGEALPHA'  'FACECOLOR'  'FACEALPHA'  'VISIBLE'  'X'  'Y'  'Z'  'SPHERESIZE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(SettingsSphere, POINTER) returns tag of POINTER of SettingsSphere.
			%  TAG = ST.GETPROPTAG(SettingsSphere, POINTER) returns tag of POINTER of SettingsSphere.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				settingssphere_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'EDGECOLOR'  'EDGEALPHA'  'FACECOLOR'  'FACEALPHA'  'VISIBLE'  'X'  'Y'  'Z'  'SPHERESIZE' };
				tag = settingssphere_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsSphere, POINTER) returns category of POINTER of SettingsSphere.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsSphere, POINTER) returns category of POINTER of SettingsSphere.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsSphere.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingssphere_category_list = { 1  1  1  3  4  2  2  6  9  9  9  9  6  6  8  8  8  8  8  8  8  8  8 };
			prop_category = settingssphere_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsSphere, POINTER) returns format of POINTER of SettingsSphere.
			%  FORMAT = ST.GETPROPFORMAT(SettingsSphere, POINTER) returns format of POINTER of SettingsSphere.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsSphere.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingssphere_format_list = { 2  2  2  8  2  2  2  2  8  11  2  11  18  11  20  21  20  21  4  11  11  11  22 };
			prop_format = settingssphere_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsSphere, POINTER) returns description of POINTER of SettingsSphere.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsSphere, POINTER) returns description of POINTER of SettingsSphere.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsSphere.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingssphere_description_list = { 'ELCLASS (constant, string) is the class of the sphere settings.'  'NAME (constant, string) is the name of the sphere settings.'  'DESCRIPTION (constant, string) is the description of the sphere settings.'  'TEMPLATE (parameter, item) is the template of the sphere settings.'  'ID (data, string) is a few-letter code for the sphere settings.'  'LABEL (metadata, string) is an extended label of the sphere settings.'  'NOTES (metadata, string) are some specific notes about the sphere settings.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'PANEL (gui, item) is the panel to which the graphics object belongs.'  'PROP (gui, scalar) is the prop of the graphics handle(list).'  'TAG (gui, string) is the tag of the graphics handle(s).'  'I (gui, scalar) is the index of the handle, used only by handlelists.'  'H (query, handle) is the graphics object handle.'  'SETUP (query, scalar) sets all figure props.'  'EDGECOLOR (figure, color) is the RGB edge color.'  'EDGEALPHA (figure, alpha) is the edge transparency.'  'FACECOLOR (figure, color) is the RGB face color.'  'FACEALPHA (figure, alpha) is the face transparency.'  'VISIBLE (figure, logical) determines whether the sphere is visible.'  'X (figure, scalar) is the x-coordinate.'  'Y (figure, scalar) is the y-coordinate.'  'Z (figure, scalar) is the z-coordinate.'  'SPHERESIZE (figure, size) is the sphere size.' };
			prop_description = settingssphere_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsSphere, POINTER) returns settings of POINTER of SettingsSphere.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsSphere, POINTER) returns settings of POINTER of SettingsSphere.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsSphere.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 19 % SettingsSphere.VISIBLE
					prop_settings = Format.getFormatSettings(4);
				case 20 % SettingsSphere.X
					prop_settings = Format.getFormatSettings(11);
				case 21 % SettingsSphere.Y
					prop_settings = Format.getFormatSettings(11);
				case 22 % SettingsSphere.Z
					prop_settings = Format.getFormatSettings(11);
				case 23 % SettingsSphere.SPHERESIZE
					prop_settings = Format.getFormatSettings(22);
				case 4 % SettingsSphere.TEMPLATE
					prop_settings = 'SettingsSphere';
				otherwise
					prop_settings = getPropSettings@SettingsSurface(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsSphere.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsSphere.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsSphere, POINTER) returns the default value of POINTER of SettingsSphere.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsSphere, POINTER) returns the default value of POINTER of SettingsSphere.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsSphere.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 19 % SettingsSphere.VISIBLE
					prop_default = Format.getFormatDefault(4, SettingsSphere.getPropSettings(prop));
				case 20 % SettingsSphere.X
					prop_default = Format.getFormatDefault(11, SettingsSphere.getPropSettings(prop));
				case 21 % SettingsSphere.Y
					prop_default = Format.getFormatDefault(11, SettingsSphere.getPropSettings(prop));
				case 22 % SettingsSphere.Z
					prop_default = Format.getFormatDefault(11, SettingsSphere.getPropSettings(prop));
				case 23 % SettingsSphere.SPHERESIZE
					prop_default = 5;
				case 1 % SettingsSphere.ELCLASS
					prop_default = 'SettingsSphere';
				case 2 % SettingsSphere.NAME
					prop_default = 'Sphere Settings';
				case 3 % SettingsSphere.DESCRIPTION
					prop_default = 'A Sphere Settings (SettingsSphere) provides the settings for a sphere, including visibility, x, y, z, radius, face color and alpha, edge color and alpha.';
				case 4 % SettingsSphere.TEMPLATE
					prop_default = Format.getFormatDefault(8, SettingsSphere.getPropSettings(prop));
				case 5 % SettingsSphere.ID
					prop_default = 'SettingsSphere ID';
				case 6 % SettingsSphere.LABEL
					prop_default = 'SettingsSphere label';
				case 7 % SettingsSphere.NOTES
					prop_default = 'SettingsSphere notes';
				otherwise
					prop_default = getPropDefault@SettingsSurface(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsSphere.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsSphere.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsSphere, POINTER) returns the conditioned default value of POINTER of SettingsSphere.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsSphere, POINTER) returns the conditioned default value of POINTER of SettingsSphere.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsSphere.getPropProp(pointer);
			
			prop_default = SettingsSphere.conditioning(prop, SettingsSphere.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsSphere, PROP, VALUE) checks VALUE format for PROP of SettingsSphere.
			%  CHECK = ST.CHECKPROP(SettingsSphere, PROP, VALUE) checks VALUE format for PROP of SettingsSphere.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SettingsSphere:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: BRAPH2:SettingsSphere:WrongInput
			%  Element.CHECKPROP(SettingsSphere, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsSphere.
			%   Error id: BRAPH2:SettingsSphere:WrongInput
			%  ST.CHECKPROP(SettingsSphere, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsSphere.
			%   Error id: BRAPH2:SettingsSphere:WrongInput]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsSphere.getPropProp(pointer);
			
			switch prop
				case 19 % SettingsSphere.VISIBLE
					check = Format.checkFormat(4, value, SettingsSphere.getPropSettings(prop));
				case 20 % SettingsSphere.X
					check = Format.checkFormat(11, value, SettingsSphere.getPropSettings(prop));
				case 21 % SettingsSphere.Y
					check = Format.checkFormat(11, value, SettingsSphere.getPropSettings(prop));
				case 22 % SettingsSphere.Z
					check = Format.checkFormat(11, value, SettingsSphere.getPropSettings(prop));
				case 23 % SettingsSphere.SPHERESIZE
					check = Format.checkFormat(22, value, SettingsSphere.getPropSettings(prop));
				case 4 % SettingsSphere.TEMPLATE
					check = Format.checkFormat(8, value, SettingsSphere.getPropSettings(prop));
				otherwise
					if prop <= 18
						check = checkProp@SettingsSurface(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsSphere:' 'WrongInput'], ...
					['BRAPH2' ':SettingsSphere:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsSphere.getPropTag(prop) ' (' SettingsSphere.getFormatTag(SettingsSphere.getPropFormat(prop)) ').'] ...
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
				case 19 % SettingsSphere.VISIBLE
					h = st.get('H');
					if (check_graphics(h, 'patch') || check_graphics(h, 'surface')) && ( ...
					        get(h, 'Visible') ~= st.get('VISIBLE') || ...
					        ~isequal(get(h, 'UserData'), [st.get('X') st.get('Y') st.get('Z') st.get('SPHERESIZE')]) ...
					        )
					    if st.get('VISIBLE')
					        [sx, sy, sz] = sphere();
					        set(h, ...
					            'XData', st.get('X') + st.get('SPHERESIZE') * sx, ...
					            'YData', st.get('Y') + st.get('SPHERESIZE') * sy, ...
					            'ZData', st.get('Z') + st.get('SPHERESIZE') * sz, ...
					            'UserData', [st.get('X') st.get('Y') st.get('Z') st.get('SPHERESIZE')], ...
					            'Visible', true ...
					            )
					    else
					        set(h, 'Visible', false)
					    end
					end
					
				otherwise
					if prop <= 18
						postprocessing@SettingsSurface(st, prop);
					end
			end
		end
	end
end
