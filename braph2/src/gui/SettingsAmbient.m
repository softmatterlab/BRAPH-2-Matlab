classdef SettingsAmbient < Settings
	%SettingsAmbient contains the ambient settings.
	% It is a subclass of <a href="matlab:help Settings">Settings</a>.
	%
	% An Ambient Settings (SettingsAmbient) provides the settings 
	%  for the ambient lightning and material, including lighting, material, 
	%  camlight, shading, and colormap.
	% The handle can be an axes (uiaxes).
	%
	% The list of SettingsAmbient properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the ambient settings.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ambient settings.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ambient settings.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ambient settings.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ambient settings.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ambient settings.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ambient settings.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
	%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
	%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
	%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
	%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
	%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
	%  <strong>15</strong> <strong>LIGHTING</strong> 	LIGHTING (figure, option) is the lighting value.
	%  <strong>16</strong> <strong>MATERIAL</strong> 	MATERIAL (figure, option) is the material value.
	%  <strong>17</strong> <strong>CAMLIGHT</strong> 	CAMLIGHT (figure, option) is the camlight value.
	%  <strong>18</strong> <strong>SHADING</strong> 	SHADING (figure, option) is the shading value.
	%  <strong>19</strong> <strong>COLORMAP</strong> 	COLORMAP (figure, option) is the colormap.
	%
	% SettingsAmbient methods (constructor):
	%  SettingsAmbient - constructor
	%
	% SettingsAmbient methods:
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
	% SettingsAmbient methods (display):
	%  tostring - string with information about the ambient settings
	%  disp - displays information about the ambient settings
	%  tree - displays the tree of the ambient settings
	%
	% SettingsAmbient methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ambient settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ambient settings
	%
	% SettingsAmbient methods (save/load, Static):
	%  save - saves BRAPH2 ambient settings as b2 file
	%  load - loads a BRAPH2 ambient settings from a b2 file
	%
	% SettingsAmbient method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ambient settings
	%
	% SettingsAmbient method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ambient settings
	%
	% SettingsAmbient methods (inspection, Static):
	%  getClass - returns the class of the ambient settings
	%  getSubclasses - returns all subclasses of SettingsAmbient
	%  getProps - returns the property list of the ambient settings
	%  getPropNumber - returns the property number of the ambient settings
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
	% SettingsAmbient methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsAmbient methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsAmbient methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsAmbient methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsAmbient; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsAmbient constants</a>.
	%
	%
	% See also uiaxes, SettingsAmbientPP, PanelFig, GUIFig, check_graphics.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		LIGHTING = 15; %CET: Computational Efficiency Trick
		LIGHTING_TAG = 'LIGHTING';
		LIGHTING_CATEGORY = 8;
		LIGHTING_FORMAT = 5;
		
		MATERIAL = 16; %CET: Computational Efficiency Trick
		MATERIAL_TAG = 'MATERIAL';
		MATERIAL_CATEGORY = 8;
		MATERIAL_FORMAT = 5;
		
		CAMLIGHT = 17; %CET: Computational Efficiency Trick
		CAMLIGHT_TAG = 'CAMLIGHT';
		CAMLIGHT_CATEGORY = 8;
		CAMLIGHT_FORMAT = 5;
		
		SHADING = 18; %CET: Computational Efficiency Trick
		SHADING_TAG = 'SHADING';
		SHADING_CATEGORY = 8;
		SHADING_FORMAT = 5;
		
		COLORMAP = 19; %CET: Computational Efficiency Trick
		COLORMAP_TAG = 'COLORMAP';
		COLORMAP_CATEGORY = 8;
		COLORMAP_FORMAT = 5;
	end
	methods % constructor
		function st = SettingsAmbient(varargin)
			%SettingsAmbient() creates a ambient settings.
			%
			% SettingsAmbient(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsAmbient(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SettingsAmbient properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the ambient settings.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ambient settings.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ambient settings.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ambient settings.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ambient settings.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ambient settings.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ambient settings.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
			%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
			%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
			%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
			%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
			%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
			%  <strong>15</strong> <strong>LIGHTING</strong> 	LIGHTING (figure, option) is the lighting value.
			%  <strong>16</strong> <strong>MATERIAL</strong> 	MATERIAL (figure, option) is the material value.
			%  <strong>17</strong> <strong>CAMLIGHT</strong> 	CAMLIGHT (figure, option) is the camlight value.
			%  <strong>18</strong> <strong>SHADING</strong> 	SHADING (figure, option) is the shading value.
			%  <strong>19</strong> <strong>COLORMAP</strong> 	COLORMAP (figure, option) is the colormap.
			%
			% See also Category, Format.
			
			st = st@Settings(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the ambient settings.
			%
			% BUILD = SettingsAmbient.GETBUILD() returns the build of 'SettingsAmbient'.
			%
			% Alternative forms to call this method are:
			%  BUILD = ST.GETBUILD() returns the build of the ambient settings ST.
			%  BUILD = Element.GETBUILD(ST) returns the build of 'ST'.
			%  BUILD = Element.GETBUILD('SettingsAmbient') returns the build of 'SettingsAmbient'.
			%
			% Note that the Element.GETBUILD(ST) and Element.GETBUILD('SettingsAmbient')
			%  are less computationally efficient.
			
			build = 1;
		end
		function st_class = getClass()
			%GETCLASS returns the class of the ambient settings.
			%
			% CLASS = SettingsAmbient.GETCLASS() returns the class 'SettingsAmbient'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the ambient settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsAmbient') returns 'SettingsAmbient'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsAmbient')
			%  are less computationally efficient.
			
			st_class = 'SettingsAmbient';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ambient settings.
			%
			% LIST = SettingsAmbient.GETSUBCLASSES() returns all subclasses of 'SettingsAmbient'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the ambient settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsAmbient') returns all subclasses of 'SettingsAmbient'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SettingsAmbient' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ambient settings.
			%
			% PROPS = SettingsAmbient.GETPROPS() returns the property list of ambient settings
			%  as a row vector.
			%
			% PROPS = SettingsAmbient.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the ambient settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsAmbient'[, CATEGORY]) returns the property list of 'SettingsAmbient'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsAmbient')
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
			%GETPROPNUMBER returns the property number of ambient settings.
			%
			% N = SettingsAmbient.GETPROPNUMBER() returns the property number of ambient settings.
			%
			% N = SettingsAmbient.GETPROPNUMBER(CATEGORY) returns the property number of ambient settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the ambient settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsAmbient') returns the property number of 'SettingsAmbient'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsAmbient')
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
			%EXISTSPROP checks whether property exists in ambient settings/error.
			%
			% CHECK = SettingsAmbient.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsAmbient, PROP) checks whether PROP exists for SettingsAmbient.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsAmbient:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsAmbient:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsAmbient:WrongInput]
			%  Element.EXISTSPROP(SettingsAmbient, PROP) throws error if PROP does NOT exist for SettingsAmbient.
			%   Error id: [BRAPH2:SettingsAmbient:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 19 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsAmbient:' 'WrongInput'], ...
					['BRAPH2' ':SettingsAmbient:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsAmbient.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ambient settings/error.
			%
			% CHECK = SettingsAmbient.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsAmbient, TAG) checks whether TAG exists for SettingsAmbient.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsAmbient:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsAmbient:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsAmbient:WrongInput]
			%  Element.EXISTSTAG(SettingsAmbient, TAG) throws error if TAG does NOT exist for SettingsAmbient.
			%   Error id: [BRAPH2:SettingsAmbient:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'LIGHTING'  'MATERIAL'  'CAMLIGHT'  'SHADING'  'COLORMAP' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsAmbient:' 'WrongInput'], ...
					['BRAPH2' ':SettingsAmbient:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SettingsAmbient.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsAmbient, POINTER) returns property number of POINTER of SettingsAmbient.
			%  PROPERTY = ST.GETPROPPROP(SettingsAmbient, POINTER) returns property number of POINTER of SettingsAmbient.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'LIGHTING'  'MATERIAL'  'CAMLIGHT'  'SHADING'  'COLORMAP' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(SettingsAmbient, POINTER) returns tag of POINTER of SettingsAmbient.
			%  TAG = ST.GETPROPTAG(SettingsAmbient, POINTER) returns tag of POINTER of SettingsAmbient.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				settingsambient_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'LIGHTING'  'MATERIAL'  'CAMLIGHT'  'SHADING'  'COLORMAP' };
				tag = settingsambient_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsAmbient, POINTER) returns category of POINTER of SettingsAmbient.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsAmbient, POINTER) returns category of POINTER of SettingsAmbient.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAmbient.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsambient_category_list = { 1  1  1  3  4  2  2  6  9  9  9  9  6  6  8  8  8  8  8 };
			prop_category = settingsambient_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsAmbient, POINTER) returns format of POINTER of SettingsAmbient.
			%  FORMAT = ST.GETPROPFORMAT(SettingsAmbient, POINTER) returns format of POINTER of SettingsAmbient.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAmbient.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsambient_format_list = { 2  2  2  8  2  2  2  2  8  11  2  11  18  11  5  5  5  5  5 };
			prop_format = settingsambient_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsAmbient, POINTER) returns description of POINTER of SettingsAmbient.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsAmbient, POINTER) returns description of POINTER of SettingsAmbient.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAmbient.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsambient_description_list = { 'ELCLASS (constant, string) is the class of the ambient settings.'  'NAME (constant, string) is the name of the ambient settings.'  'DESCRIPTION (constant, string) is the description of the ambient settings.'  'TEMPLATE (parameter, item) is the template of the ambient settings.'  'ID (data, string) is a few-letter code for the ambient settings.'  'LABEL (metadata, string) is an extended label of the ambient settings.'  'NOTES (metadata, string) are some specific notes about the ambient settings.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'PANEL (gui, item) is the panel to which the graphics object belongs.'  'PROP (gui, scalar) is the prop of the graphics handle(list).'  'TAG (gui, string) is the tag of the graphics handle(s).'  'I (gui, scalar) is the index of the handle, used only by handlelists.'  'H (query, handle) is the graphics object handle.'  'SETUP (query, scalar) sets all figure props.'  'LIGHTING (figure, option) is the lighting value.'  'MATERIAL (figure, option) is the material value.'  'CAMLIGHT (figure, option) is the camlight value.'  'SHADING (figure, option) is the shading value.'  'COLORMAP (figure, option) is the colormap.' };
			prop_description = settingsambient_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsAmbient, POINTER) returns settings of POINTER of SettingsAmbient.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsAmbient, POINTER) returns settings of POINTER of SettingsAmbient.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAmbient.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SettingsAmbient.LIGHTING
					prop_settings = {'none' 'phong' 'flat' 'gouraud'};
				case 16 % SettingsAmbient.MATERIAL
					prop_settings = {'shiny' 'dull' 'metal'};
				case 17 % SettingsAmbient.CAMLIGHT
					prop_settings = {'none' 'headlight' 'headlight (x2)' 'headlight (x3)' 'right' 'right (x2)' 'right (x3)' 'left' 'left (x2)' 'left (x3)'};
				case 18 % SettingsAmbient.SHADING
					prop_settings = {'none' 'interp' 'flat' 'faceted'};
				case 19 % SettingsAmbient.COLORMAP
					prop_settings = {'none', 'white', 'parula', 'jet', 'hsv', 'hot', 'cool', 'spring', 'summer', 'autumn', 'winter', 'gray', 'bone', 'copper', 'pink', 'lines', 'colorcube', 'prism', 'flag'};
				case 4 % SettingsAmbient.TEMPLATE
					prop_settings = 'SettingsAmbient';
				otherwise
					prop_settings = getPropSettings@Settings(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsAmbient.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAmbient.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsAmbient, POINTER) returns the default value of POINTER of SettingsAmbient.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsAmbient, POINTER) returns the default value of POINTER of SettingsAmbient.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsAmbient.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SettingsAmbient.LIGHTING
					prop_default = 'gouraud';
				case 16 % SettingsAmbient.MATERIAL
					prop_default = 'shiny';
				case 17 % SettingsAmbient.CAMLIGHT
					prop_default = 'headlight (x2)';
				case 18 % SettingsAmbient.SHADING
					prop_default = 'none';
				case 19 % SettingsAmbient.COLORMAP
					prop_default = 'none';
				case 1 % SettingsAmbient.ELCLASS
					prop_default = 'SettingsAmbient';
				case 2 % SettingsAmbient.NAME
					prop_default = 'Ambient Settings';
				case 3 % SettingsAmbient.DESCRIPTION
					prop_default = 'An Ambient Settings (SettingsAmbient) provides the settings for the ambient lightning and material, including lighting, material, camlight, shading, and colormap. The handle can be an axes (uiaxes).';
				case 4 % SettingsAmbient.TEMPLATE
					prop_default = Format.getFormatDefault(8, SettingsAmbient.getPropSettings(prop));
				case 5 % SettingsAmbient.ID
					prop_default = 'SettingsAmbient ID';
				case 6 % SettingsAmbient.LABEL
					prop_default = 'SettingsAmbient label';
				case 7 % SettingsAmbient.NOTES
					prop_default = 'SettingsAmbient notes';
				otherwise
					prop_default = getPropDefault@Settings(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsAmbient.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAmbient.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsAmbient, POINTER) returns the conditioned default value of POINTER of SettingsAmbient.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsAmbient, POINTER) returns the conditioned default value of POINTER of SettingsAmbient.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsAmbient.getPropProp(pointer);
			
			prop_default = SettingsAmbient.conditioning(prop, SettingsAmbient.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsAmbient, PROP, VALUE) checks VALUE format for PROP of SettingsAmbient.
			%  CHECK = ST.CHECKPROP(SettingsAmbient, PROP, VALUE) checks VALUE format for PROP of SettingsAmbient.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SettingsAmbient:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: BRAPH2:SettingsAmbient:WrongInput
			%  Element.CHECKPROP(SettingsAmbient, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAmbient.
			%   Error id: BRAPH2:SettingsAmbient:WrongInput
			%  ST.CHECKPROP(SettingsAmbient, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAmbient.
			%   Error id: BRAPH2:SettingsAmbient:WrongInput]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsAmbient.getPropProp(pointer);
			
			switch prop
				case 15 % SettingsAmbient.LIGHTING
					check = Format.checkFormat(5, value, SettingsAmbient.getPropSettings(prop));
				case 16 % SettingsAmbient.MATERIAL
					check = Format.checkFormat(5, value, SettingsAmbient.getPropSettings(prop));
				case 17 % SettingsAmbient.CAMLIGHT
					check = Format.checkFormat(5, value, SettingsAmbient.getPropSettings(prop));
				case 18 % SettingsAmbient.SHADING
					check = Format.checkFormat(5, value, SettingsAmbient.getPropSettings(prop));
				case 19 % SettingsAmbient.COLORMAP
					check = Format.checkFormat(5, value, SettingsAmbient.getPropSettings(prop));
				case 4 % SettingsAmbient.TEMPLATE
					check = Format.checkFormat(8, value, SettingsAmbient.getPropSettings(prop));
				otherwise
					if prop <= 14
						check = checkProp@Settings(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsAmbient:' 'WrongInput'], ...
					['BRAPH2' ':SettingsAmbient:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsAmbient.getPropTag(prop) ' (' SettingsAmbient.getFormatTag(SettingsAmbient.getPropFormat(prop)) ').'] ...
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
				case 15 % SettingsAmbient.LIGHTING
					a = st.get('H');
					if check_graphics(a, 'axes')
					    lighting(a, st.get('LIGHTING'))
					end
					
				case 16 % SettingsAmbient.MATERIAL
					a = st.get('H');
					if check_graphics(a, 'axes')
					    material(a, st.get('MATERIAL'))
					end
					
				case 17 % SettingsAmbient.CAMLIGHT
					a = st.get('H');
					if check_graphics(a, 'axes')
					    delete(findall(a, 'Type', 'light'))    
					    switch st.get('CAMLIGHT')
					        case 'headlight' 
					            camlight(a, 'headlight');
					        case 'headlight (x2)'
					            camlight(a, 'headlight');
					            camlight(a, 'headlight');
					        case 'headlight (x3)'
					            camlight(a, 'headlight');
					            camlight(a, 'headlight');
					            camlight(a, 'headlight');
					        case 'right'
					            camlight(a, 'right');
					        case 'right (x2)'
					            camlight(a, 'right');
					            camlight(a, 'right');
					        case 'right (x3)'
					            camlight(a, 'right');
					            camlight(a, 'right');
					            camlight(a, 'right');
					        case 'left'
					            camlight(a, 'left');
					        case 'left (x2)'
					            camlight(a, 'left');
					            camlight(a, 'left');
					        case 'left (x3)'
					            camlight(a, 'left');
					            camlight(a, 'left');
					            camlight(a, 'left');
					    end
					end
					
				case 18 % SettingsAmbient.SHADING
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if ~strcmpi(st.get('SHADING'), 'none') && ~strcmpi(st.get('COLORMAP'), 'none')
					        colormap(a, st.get('COLORMAP'))
					        shading(a, st.get('SHADING'))
					    end
					end
					
				case 19 % SettingsAmbient.COLORMAP
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if ~strcmpi(st.get('SHADING'), 'none') && ~strcmpi(st.get('COLORMAP'), 'none')
					        colormap(a, st.get('COLORMAP'))
					        shading(a, st.get('SHADING'))
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
