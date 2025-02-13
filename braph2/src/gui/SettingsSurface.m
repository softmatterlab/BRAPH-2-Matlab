classdef SettingsSurface < Settings
	%SettingsSurface contains the surface settings.
	% It is a subclass of <a href="matlab:help Settings">Settings</a>.
	%
	% A Surface Settings (SettingsSurface) provides the settings for a surface, 
	%  including face color, face alpha, edge color, and edge alpha.
	% The handle can be either a patch or a surface.
	%
	% The list of SettingsSurface properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the surface settings.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the surface settings.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the surface settings.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the surface settings.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the surface settings.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the surface settings.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the surface settings.
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
	%
	% SettingsSurface methods (constructor):
	%  SettingsSurface - constructor
	%
	% SettingsSurface methods:
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
	% SettingsSurface methods (display):
	%  tostring - string with information about the surface settings
	%  disp - displays information about the surface settings
	%  tree - displays the tree of the surface settings
	%
	% SettingsSurface methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two surface settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the surface settings
	%
	% SettingsSurface methods (save/load, Static):
	%  save - saves BRAPH2 surface settings as b2 file
	%  load - loads a BRAPH2 surface settings from a b2 file
	%
	% SettingsSurface method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the surface settings
	%
	% SettingsSurface method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the surface settings
	%
	% SettingsSurface methods (inspection, Static):
	%  getClass - returns the class of the surface settings
	%  getSubclasses - returns all subclasses of SettingsSurface
	%  getProps - returns the property list of the surface settings
	%  getPropNumber - returns the property number of the surface settings
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
	% SettingsSurface methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsSurface methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsSurface methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsSurface methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsSurface; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsSurface constants</a>.
	%
	%
	% See also patch, surface, SettingsSurfacePP, PanelFig, GUIFig, check_graphics.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		EDGECOLOR = 15; %CET: Computational Efficiency Trick
		EDGECOLOR_TAG = 'EDGECOLOR';
		EDGECOLOR_CATEGORY = 8;
		EDGECOLOR_FORMAT = 20;
		
		EDGEALPHA = 16; %CET: Computational Efficiency Trick
		EDGEALPHA_TAG = 'EDGEALPHA';
		EDGEALPHA_CATEGORY = 8;
		EDGEALPHA_FORMAT = 21;
		
		FACECOLOR = 17; %CET: Computational Efficiency Trick
		FACECOLOR_TAG = 'FACECOLOR';
		FACECOLOR_CATEGORY = 8;
		FACECOLOR_FORMAT = 20;
		
		FACEALPHA = 18; %CET: Computational Efficiency Trick
		FACEALPHA_TAG = 'FACEALPHA';
		FACEALPHA_CATEGORY = 8;
		FACEALPHA_FORMAT = 21;
	end
	methods % constructor
		function st = SettingsSurface(varargin)
			%SettingsSurface() creates a surface settings.
			%
			% SettingsSurface(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsSurface(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SettingsSurface properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the surface settings.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the surface settings.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the surface settings.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the surface settings.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the surface settings.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the surface settings.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the surface settings.
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
			%
			% See also Category, Format.
			
			st = st@Settings(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the surface settings.
			%
			% BUILD = SettingsSurface.GETBUILD() returns the build of 'SettingsSurface'.
			%
			% Alternative forms to call this method are:
			%  BUILD = ST.GETBUILD() returns the build of the surface settings ST.
			%  BUILD = Element.GETBUILD(ST) returns the build of 'ST'.
			%  BUILD = Element.GETBUILD('SettingsSurface') returns the build of 'SettingsSurface'.
			%
			% Note that the Element.GETBUILD(ST) and Element.GETBUILD('SettingsSurface')
			%  are less computationally efficient.
			
			build = 1;
		end
		function st_class = getClass()
			%GETCLASS returns the class of the surface settings.
			%
			% CLASS = SettingsSurface.GETCLASS() returns the class 'SettingsSurface'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the surface settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsSurface') returns 'SettingsSurface'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsSurface')
			%  are less computationally efficient.
			
			st_class = 'SettingsSurface';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the surface settings.
			%
			% LIST = SettingsSurface.GETSUBCLASSES() returns all subclasses of 'SettingsSurface'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the surface settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsSurface') returns all subclasses of 'SettingsSurface'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SettingsSurface'  'SettingsSphere' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of surface settings.
			%
			% PROPS = SettingsSurface.GETPROPS() returns the property list of surface settings
			%  as a row vector.
			%
			% PROPS = SettingsSurface.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the surface settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsSurface'[, CATEGORY]) returns the property list of 'SettingsSurface'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18];
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
					prop_list = [15 16 17 18];
				case 9 % Category.GUI
					prop_list = [9 10 11 12];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of surface settings.
			%
			% N = SettingsSurface.GETPROPNUMBER() returns the property number of surface settings.
			%
			% N = SettingsSurface.GETPROPNUMBER(CATEGORY) returns the property number of surface settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the surface settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsSurface') returns the property number of 'SettingsSurface'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 18;
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
					prop_number = 4;
				case 9 % Category.GUI
					prop_number = 4;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in surface settings/error.
			%
			% CHECK = SettingsSurface.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsSurface, PROP) checks whether PROP exists for SettingsSurface.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsSurface:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSurface:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSurface:WrongInput]
			%  Element.EXISTSPROP(SettingsSurface, PROP) throws error if PROP does NOT exist for SettingsSurface.
			%   Error id: [BRAPH2:SettingsSurface:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 18 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsSurface:' 'WrongInput'], ...
					['BRAPH2' ':SettingsSurface:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsSurface.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in surface settings/error.
			%
			% CHECK = SettingsSurface.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsSurface, TAG) checks whether TAG exists for SettingsSurface.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsSurface:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSurface:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSurface:WrongInput]
			%  Element.EXISTSTAG(SettingsSurface, TAG) throws error if TAG does NOT exist for SettingsSurface.
			%   Error id: [BRAPH2:SettingsSurface:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'EDGECOLOR'  'EDGEALPHA'  'FACECOLOR'  'FACEALPHA' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsSurface:' 'WrongInput'], ...
					['BRAPH2' ':SettingsSurface:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SettingsSurface.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsSurface, POINTER) returns property number of POINTER of SettingsSurface.
			%  PROPERTY = ST.GETPROPPROP(SettingsSurface, POINTER) returns property number of POINTER of SettingsSurface.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'EDGECOLOR'  'EDGEALPHA'  'FACECOLOR'  'FACEALPHA' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(SettingsSurface, POINTER) returns tag of POINTER of SettingsSurface.
			%  TAG = ST.GETPROPTAG(SettingsSurface, POINTER) returns tag of POINTER of SettingsSurface.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				settingssurface_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'EDGECOLOR'  'EDGEALPHA'  'FACECOLOR'  'FACEALPHA' };
				tag = settingssurface_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsSurface, POINTER) returns category of POINTER of SettingsSurface.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsSurface, POINTER) returns category of POINTER of SettingsSurface.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsSurface.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingssurface_category_list = { 1  1  1  3  4  2  2  6  9  9  9  9  6  6  8  8  8  8 };
			prop_category = settingssurface_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsSurface, POINTER) returns format of POINTER of SettingsSurface.
			%  FORMAT = ST.GETPROPFORMAT(SettingsSurface, POINTER) returns format of POINTER of SettingsSurface.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsSurface.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingssurface_format_list = { 2  2  2  8  2  2  2  2  8  11  2  11  18  11  20  21  20  21 };
			prop_format = settingssurface_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsSurface, POINTER) returns description of POINTER of SettingsSurface.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsSurface, POINTER) returns description of POINTER of SettingsSurface.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsSurface.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingssurface_description_list = { 'ELCLASS (constant, string) is the class of the surface settings.'  'NAME (constant, string) is the name of the surface settings.'  'DESCRIPTION (constant, string) is the description of the surface settings.'  'TEMPLATE (parameter, item) is the template of the surface settings.'  'ID (data, string) is a few-letter code for the surface settings.'  'LABEL (metadata, string) is an extended label of the surface settings.'  'NOTES (metadata, string) are some specific notes about the surface settings.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'PANEL (gui, item) is the panel to which the graphics object belongs.'  'PROP (gui, scalar) is the prop of the graphics handle(list).'  'TAG (gui, string) is the tag of the graphics handle(s).'  'I (gui, scalar) is the index of the handle, used only by handlelists.'  'H (query, handle) is the graphics object handle.'  'SETUP (query, scalar) sets all figure props.'  'EDGECOLOR (figure, color) is the RGB edge color.'  'EDGEALPHA (figure, alpha) is the edge transparency.'  'FACECOLOR (figure, color) is the RGB face color.'  'FACEALPHA (figure, alpha) is the face transparency.' };
			prop_description = settingssurface_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsSurface, POINTER) returns settings of POINTER of SettingsSurface.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsSurface, POINTER) returns settings of POINTER of SettingsSurface.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsSurface.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SettingsSurface.EDGECOLOR
					prop_settings = Format.getFormatSettings(20);
				case 16 % SettingsSurface.EDGEALPHA
					prop_settings = Format.getFormatSettings(21);
				case 17 % SettingsSurface.FACECOLOR
					prop_settings = Format.getFormatSettings(20);
				case 18 % SettingsSurface.FACEALPHA
					prop_settings = Format.getFormatSettings(21);
				case 4 % SettingsSurface.TEMPLATE
					prop_settings = 'SettingsSurface';
				otherwise
					prop_settings = getPropSettings@Settings(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsSurface.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsSurface.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsSurface, POINTER) returns the default value of POINTER of SettingsSurface.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsSurface, POINTER) returns the default value of POINTER of SettingsSurface.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsSurface.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SettingsSurface.EDGECOLOR
					prop_default = [0 0 0];
				case 16 % SettingsSurface.EDGEALPHA
					prop_default = 0;
				case 17 % SettingsSurface.FACECOLOR
					prop_default = [.5 .5 .5];
				case 18 % SettingsSurface.FACEALPHA
					prop_default = .5;
				case 1 % SettingsSurface.ELCLASS
					prop_default = 'SettingsSurface';
				case 2 % SettingsSurface.NAME
					prop_default = 'Surface Settings';
				case 3 % SettingsSurface.DESCRIPTION
					prop_default = 'A Surface Settings (SettingsSurface) provides the settings for a surface, including face color, face alpha, edge color, and edge alpha.';
				case 4 % SettingsSurface.TEMPLATE
					prop_default = Format.getFormatDefault(8, SettingsSurface.getPropSettings(prop));
				case 5 % SettingsSurface.ID
					prop_default = 'SettingsSurface ID';
				case 6 % SettingsSurface.LABEL
					prop_default = 'SettingsSurface label';
				case 7 % SettingsSurface.NOTES
					prop_default = 'SettingsSurface notes';
				otherwise
					prop_default = getPropDefault@Settings(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsSurface.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsSurface.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsSurface, POINTER) returns the conditioned default value of POINTER of SettingsSurface.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsSurface, POINTER) returns the conditioned default value of POINTER of SettingsSurface.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsSurface.getPropProp(pointer);
			
			prop_default = SettingsSurface.conditioning(prop, SettingsSurface.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsSurface, PROP, VALUE) checks VALUE format for PROP of SettingsSurface.
			%  CHECK = ST.CHECKPROP(SettingsSurface, PROP, VALUE) checks VALUE format for PROP of SettingsSurface.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SettingsSurface:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: BRAPH2:SettingsSurface:WrongInput
			%  Element.CHECKPROP(SettingsSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsSurface.
			%   Error id: BRAPH2:SettingsSurface:WrongInput
			%  ST.CHECKPROP(SettingsSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsSurface.
			%   Error id: BRAPH2:SettingsSurface:WrongInput]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsSurface.getPropProp(pointer);
			
			switch prop
				case 15 % SettingsSurface.EDGECOLOR
					check = Format.checkFormat(20, value, SettingsSurface.getPropSettings(prop));
				case 16 % SettingsSurface.EDGEALPHA
					check = Format.checkFormat(21, value, SettingsSurface.getPropSettings(prop));
				case 17 % SettingsSurface.FACECOLOR
					check = Format.checkFormat(20, value, SettingsSurface.getPropSettings(prop));
				case 18 % SettingsSurface.FACEALPHA
					check = Format.checkFormat(21, value, SettingsSurface.getPropSettings(prop));
				case 4 % SettingsSurface.TEMPLATE
					check = Format.checkFormat(8, value, SettingsSurface.getPropSettings(prop));
				otherwise
					if prop <= 14
						check = checkProp@Settings(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsSurface:' 'WrongInput'], ...
					['BRAPH2' ':SettingsSurface:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsSurface.getPropTag(prop) ' (' SettingsSurface.getFormatTag(SettingsSurface.getPropFormat(prop)) ').'] ...
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
				case 15 % SettingsSurface.EDGECOLOR
					h = st.get('H');
					if check_graphics(h, 'patch') || check_graphics(h, 'surface')
					    set(h, 'EdgeColor', st.get('EDGECOLOR'))
					end
					
				case 16 % SettingsSurface.EDGEALPHA
					h = st.get('H');
					if check_graphics(h, 'patch') || check_graphics(h, 'surface')
					    set(h, 'EdgeAlpha', st.get('EDGEALPHA'))
					end
					
				case 17 % SettingsSurface.FACECOLOR
					h = st.get('H');
					if check_graphics(h, 'patch') || check_graphics(h, 'surface')
					    set(h, 'FaceColor', st.get('FACECOLOR'))
					end
					
				case 18 % SettingsSurface.FACEALPHA
					h = st.get('H');
					if check_graphics(h, 'patch') || check_graphics(h, 'surface')
					    set(h, 'FaceAlpha', st.get('FACEALPHA'))
					end
					
				otherwise
					if prop <= 14
						postset@Settings(st, prop);
					end
			end
		end
	end
end
