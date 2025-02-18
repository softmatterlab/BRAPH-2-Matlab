classdef SettingsLine < Settings
	%SettingsLine contains the line settings.
	% It is a subclass of <a href="matlab:help Settings">Settings</a>.
	%
	% A Line Settings (SettingsSymbol) provides the settings for a line, 
	%  including visibility, x, y, z, line color, line width, line style, 
	%  symbol marker, symbol size, symbol face color, and symbol edge color.
	% The handle must be a line.
	%
	% The list of SettingsLine properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the line settings.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the line settings.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the line settings.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the line settings.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the line settings.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the line settings.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the line settings.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
	%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
	%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
	%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
	%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
	%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
	%  <strong>15</strong> <strong>VISIBLE</strong> 	VISIBLE (figure, logical) determines whether the symbol is visible.
	%  <strong>16</strong> <strong>X</strong> 	X (figure, rvector) is the vector of the x-coordinates.
	%  <strong>17</strong> <strong>Y</strong> 	Y (figure, rvector) is the vector of the y-coordinates.
	%  <strong>18</strong> <strong>Z</strong> 	Z (figure, rvector) is the vector of the z-coordinates.
	%  <strong>19</strong> <strong>LINESTYLE</strong> 	LINESTYLE (figure, line) is the line style.
	%  <strong>20</strong> <strong>LINEWIDTH</strong> 	LINEWIDTH (figure, size) is the line width.
	%  <strong>21</strong> <strong>LINECOLOR</strong> 	LINECOLOR (figure, color) is the line RGB color.
	%  <strong>22</strong> <strong>SYMBOL</strong> 	SYMBOL (figure, marker) is the symbol style.
	%  <strong>23</strong> <strong>SYMBOLSIZE</strong> 	SYMBOLSIZE (figure, size) is the symbol size.
	%  <strong>24</strong> <strong>EDGECOLOR</strong> 	EDGECOLOR (figure, color) is the symbol RGB edge color.
	%  <strong>25</strong> <strong>FACECOLOR</strong> 	FACECOLOR (figure, color) is the symbol RGB face color.
	%
	% SettingsLine methods (constructor):
	%  SettingsLine - constructor
	%
	% SettingsLine methods:
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
	% SettingsLine methods (display):
	%  tostring - string with information about the line settings
	%  disp - displays information about the line settings
	%  tree - displays the tree of the line settings
	%
	% SettingsLine methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two line settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the line settings
	%
	% SettingsLine methods (save/load, Static):
	%  save - saves BRAPH2 line settings as b2 file
	%  load - loads a BRAPH2 line settings from a b2 file
	%
	% SettingsLine method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the line settings
	%
	% SettingsLine method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the line settings
	%
	% SettingsLine methods (inspection, Static):
	%  getClass - returns the class of the line settings
	%  getSubclasses - returns all subclasses of SettingsLine
	%  getProps - returns the property list of the line settings
	%  getPropNumber - returns the property number of the line settings
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
	% SettingsLine methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsLine methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsLine methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsLine methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsLine; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsLine constants</a>.
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
		X_FORMAT = 12;
		
		Y = 17; %CET: Computational Efficiency Trick
		Y_TAG = 'Y';
		Y_CATEGORY = 8;
		Y_FORMAT = 12;
		
		Z = 18; %CET: Computational Efficiency Trick
		Z_TAG = 'Z';
		Z_CATEGORY = 8;
		Z_FORMAT = 12;
		
		LINESTYLE = 19; %CET: Computational Efficiency Trick
		LINESTYLE_TAG = 'LINESTYLE';
		LINESTYLE_CATEGORY = 8;
		LINESTYLE_FORMAT = 24;
		
		LINEWIDTH = 20; %CET: Computational Efficiency Trick
		LINEWIDTH_TAG = 'LINEWIDTH';
		LINEWIDTH_CATEGORY = 8;
		LINEWIDTH_FORMAT = 22;
		
		LINECOLOR = 21; %CET: Computational Efficiency Trick
		LINECOLOR_TAG = 'LINECOLOR';
		LINECOLOR_CATEGORY = 8;
		LINECOLOR_FORMAT = 20;
		
		SYMBOL = 22; %CET: Computational Efficiency Trick
		SYMBOL_TAG = 'SYMBOL';
		SYMBOL_CATEGORY = 8;
		SYMBOL_FORMAT = 23;
		
		SYMBOLSIZE = 23; %CET: Computational Efficiency Trick
		SYMBOLSIZE_TAG = 'SYMBOLSIZE';
		SYMBOLSIZE_CATEGORY = 8;
		SYMBOLSIZE_FORMAT = 22;
		
		EDGECOLOR = 24; %CET: Computational Efficiency Trick
		EDGECOLOR_TAG = 'EDGECOLOR';
		EDGECOLOR_CATEGORY = 8;
		EDGECOLOR_FORMAT = 20;
		
		FACECOLOR = 25; %CET: Computational Efficiency Trick
		FACECOLOR_TAG = 'FACECOLOR';
		FACECOLOR_CATEGORY = 8;
		FACECOLOR_FORMAT = 20;
	end
	methods % constructor
		function st = SettingsLine(varargin)
			%SettingsLine() creates a line settings.
			%
			% SettingsLine(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsLine(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SettingsLine properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the line settings.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the line settings.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the line settings.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the line settings.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the line settings.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the line settings.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the line settings.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
			%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
			%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
			%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
			%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
			%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
			%  <strong>15</strong> <strong>VISIBLE</strong> 	VISIBLE (figure, logical) determines whether the symbol is visible.
			%  <strong>16</strong> <strong>X</strong> 	X (figure, rvector) is the vector of the x-coordinates.
			%  <strong>17</strong> <strong>Y</strong> 	Y (figure, rvector) is the vector of the y-coordinates.
			%  <strong>18</strong> <strong>Z</strong> 	Z (figure, rvector) is the vector of the z-coordinates.
			%  <strong>19</strong> <strong>LINESTYLE</strong> 	LINESTYLE (figure, line) is the line style.
			%  <strong>20</strong> <strong>LINEWIDTH</strong> 	LINEWIDTH (figure, size) is the line width.
			%  <strong>21</strong> <strong>LINECOLOR</strong> 	LINECOLOR (figure, color) is the line RGB color.
			%  <strong>22</strong> <strong>SYMBOL</strong> 	SYMBOL (figure, marker) is the symbol style.
			%  <strong>23</strong> <strong>SYMBOLSIZE</strong> 	SYMBOLSIZE (figure, size) is the symbol size.
			%  <strong>24</strong> <strong>EDGECOLOR</strong> 	EDGECOLOR (figure, color) is the symbol RGB edge color.
			%  <strong>25</strong> <strong>FACECOLOR</strong> 	FACECOLOR (figure, color) is the symbol RGB face color.
			%
			% See also Category, Format.
			
			st = st@Settings(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the line settings.
			%
			% BUILD = SettingsLine.GETBUILD() returns the build of 'SettingsLine'.
			%
			% Alternative forms to call this method are:
			%  BUILD = ST.GETBUILD() returns the build of the line settings ST.
			%  BUILD = Element.GETBUILD(ST) returns the build of 'ST'.
			%  BUILD = Element.GETBUILD('SettingsLine') returns the build of 'SettingsLine'.
			%
			% Note that the Element.GETBUILD(ST) and Element.GETBUILD('SettingsLine')
			%  are less computationally efficient.
			
			build = 1;
		end
		function st_class = getClass()
			%GETCLASS returns the class of the line settings.
			%
			% CLASS = SettingsLine.GETCLASS() returns the class 'SettingsLine'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the line settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsLine') returns 'SettingsLine'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsLine')
			%  are less computationally efficient.
			
			st_class = 'SettingsLine';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the line settings.
			%
			% LIST = SettingsLine.GETSUBCLASSES() returns all subclasses of 'SettingsLine'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the line settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsLine') returns all subclasses of 'SettingsLine'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsLine')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SettingsLine' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of line settings.
			%
			% PROPS = SettingsLine.GETPROPS() returns the property list of line settings
			%  as a row vector.
			%
			% PROPS = SettingsLine.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the line settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsLine'[, CATEGORY]) returns the property list of 'SettingsLine'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25];
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
					prop_list = [15 16 17 18 19 20 21 22 23 24 25];
				case 9 % Category.GUI
					prop_list = [9 10 11 12];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of line settings.
			%
			% N = SettingsLine.GETPROPNUMBER() returns the property number of line settings.
			%
			% N = SettingsLine.GETPROPNUMBER(CATEGORY) returns the property number of line settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the line settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsLine') returns the property number of 'SettingsLine'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 25;
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
					prop_number = 11;
				case 9 % Category.GUI
					prop_number = 4;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in line settings/error.
			%
			% CHECK = SettingsLine.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsLine, PROP) checks whether PROP exists for SettingsLine.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsLine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsLine:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsLine:WrongInput]
			%  Element.EXISTSPROP(SettingsLine, PROP) throws error if PROP does NOT exist for SettingsLine.
			%   Error id: [BRAPH2:SettingsLine:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 25 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsLine:' 'WrongInput'], ...
					['BRAPH2' ':SettingsLine:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsLine.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in line settings/error.
			%
			% CHECK = SettingsLine.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsLine, TAG) checks whether TAG exists for SettingsLine.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsLine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsLine:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsLine:WrongInput]
			%  Element.EXISTSTAG(SettingsLine, TAG) throws error if TAG does NOT exist for SettingsLine.
			%   Error id: [BRAPH2:SettingsLine:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'VISIBLE'  'X'  'Y'  'Z'  'LINESTYLE'  'LINEWIDTH'  'LINECOLOR'  'SYMBOL'  'SYMBOLSIZE'  'EDGECOLOR'  'FACECOLOR' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsLine:' 'WrongInput'], ...
					['BRAPH2' ':SettingsLine:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SettingsLine.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsLine, POINTER) returns property number of POINTER of SettingsLine.
			%  PROPERTY = ST.GETPROPPROP(SettingsLine, POINTER) returns property number of POINTER of SettingsLine.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'VISIBLE'  'X'  'Y'  'Z'  'LINESTYLE'  'LINEWIDTH'  'LINECOLOR'  'SYMBOL'  'SYMBOLSIZE'  'EDGECOLOR'  'FACECOLOR' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(SettingsLine, POINTER) returns tag of POINTER of SettingsLine.
			%  TAG = ST.GETPROPTAG(SettingsLine, POINTER) returns tag of POINTER of SettingsLine.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				settingsline_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'VISIBLE'  'X'  'Y'  'Z'  'LINESTYLE'  'LINEWIDTH'  'LINECOLOR'  'SYMBOL'  'SYMBOLSIZE'  'EDGECOLOR'  'FACECOLOR' };
				tag = settingsline_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsLine, POINTER) returns category of POINTER of SettingsLine.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsLine, POINTER) returns category of POINTER of SettingsLine.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsLine')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsLine.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsline_category_list = { 1  1  1  3  4  2  2  6  9  9  9  9  6  6  8  8  8  8  8  8  8  8  8  8  8 };
			prop_category = settingsline_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsLine, POINTER) returns format of POINTER of SettingsLine.
			%  FORMAT = ST.GETPROPFORMAT(SettingsLine, POINTER) returns format of POINTER of SettingsLine.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsLine')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsLine.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsline_format_list = { 2  2  2  8  2  2  2  2  8  11  2  11  18  11  4  12  12  12  24  22  20  23  22  20  20 };
			prop_format = settingsline_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsLine, POINTER) returns description of POINTER of SettingsLine.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsLine, POINTER) returns description of POINTER of SettingsLine.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsLine.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsline_description_list = { 'ELCLASS (constant, string) is the class of the line settings.'  'NAME (constant, string) is the name of the line settings.'  'DESCRIPTION (constant, string) is the description of the line settings.'  'TEMPLATE (parameter, item) is the template of the line settings.'  'ID (data, string) is a few-letter code for the line settings.'  'LABEL (metadata, string) is an extended label of the line settings.'  'NOTES (metadata, string) are some specific notes about the line settings.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'PANEL (gui, item) is the panel to which the graphics object belongs.'  'PROP (gui, scalar) is the prop of the graphics handle(list).'  'TAG (gui, string) is the tag of the graphics handle(s).'  'I (gui, scalar) is the index of the handle, used only by handlelists.'  'H (query, handle) is the graphics object handle.'  'SETUP (query, scalar) sets all figure props.'  'VISIBLE (figure, logical) determines whether the symbol is visible.'  'X (figure, rvector) is the vector of the x-coordinates.'  'Y (figure, rvector) is the vector of the y-coordinates.'  'Z (figure, rvector) is the vector of the z-coordinates.'  'LINESTYLE (figure, line) is the line style.'  'LINEWIDTH (figure, size) is the line width.'  'LINECOLOR (figure, color) is the line RGB color.'  'SYMBOL (figure, marker) is the symbol style.'  'SYMBOLSIZE (figure, size) is the symbol size.'  'EDGECOLOR (figure, color) is the symbol RGB edge color.'  'FACECOLOR (figure, color) is the symbol RGB face color.' };
			prop_description = settingsline_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsLine, POINTER) returns settings of POINTER of SettingsLine.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsLine, POINTER) returns settings of POINTER of SettingsLine.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsLine.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SettingsLine.VISIBLE
					prop_settings = Format.getFormatSettings(4);
				case 16 % SettingsLine.X
					prop_settings = Format.getFormatSettings(12);
				case 17 % SettingsLine.Y
					prop_settings = Format.getFormatSettings(12);
				case 18 % SettingsLine.Z
					prop_settings = Format.getFormatSettings(12);
				case 19 % SettingsLine.LINESTYLE
					prop_settings = Format.getFormatSettings(24);
				case 20 % SettingsLine.LINEWIDTH
					prop_settings = Format.getFormatSettings(22);
				case 21 % SettingsLine.LINECOLOR
					prop_settings = Format.getFormatSettings(20);
				case 22 % SettingsLine.SYMBOL
					prop_settings = Format.getFormatSettings(23);
				case 23 % SettingsLine.SYMBOLSIZE
					prop_settings = Format.getFormatSettings(22);
				case 24 % SettingsLine.EDGECOLOR
					prop_settings = Format.getFormatSettings(20);
				case 25 % SettingsLine.FACECOLOR
					prop_settings = Format.getFormatSettings(20);
				case 4 % SettingsLine.TEMPLATE
					prop_settings = 'SettingsLine';
				otherwise
					prop_settings = getPropSettings@Settings(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsLine.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsLine.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsLine, POINTER) returns the default value of POINTER of SettingsLine.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsLine, POINTER) returns the default value of POINTER of SettingsLine.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsLine.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SettingsLine.VISIBLE
					prop_default = true;
				case 16 % SettingsLine.X
					prop_default = Format.getFormatDefault(12, SettingsLine.getPropSettings(prop));
				case 17 % SettingsLine.Y
					prop_default = Format.getFormatDefault(12, SettingsLine.getPropSettings(prop));
				case 18 % SettingsLine.Z
					prop_default = Format.getFormatDefault(12, SettingsLine.getPropSettings(prop));
				case 19 % SettingsLine.LINESTYLE
					prop_default = Format.getFormatDefault(24, SettingsLine.getPropSettings(prop));
				case 20 % SettingsLine.LINEWIDTH
					prop_default = Format.getFormatDefault(22, SettingsLine.getPropSettings(prop));
				case 21 % SettingsLine.LINECOLOR
					prop_default = [0 0 0];
				case 22 % SettingsLine.SYMBOL
					prop_default = Format.getFormatDefault(23, SettingsLine.getPropSettings(prop));
				case 23 % SettingsLine.SYMBOLSIZE
					prop_default = 10;
				case 24 % SettingsLine.EDGECOLOR
					prop_default = [0 0 0];
				case 25 % SettingsLine.FACECOLOR
					prop_default = [0.9 0.4 0.1];
				case 1 % SettingsLine.ELCLASS
					prop_default = 'SettingsLine';
				case 2 % SettingsLine.NAME
					prop_default = 'Line Settings';
				case 3 % SettingsLine.DESCRIPTION
					prop_default = 'A Line Settings (SettingsSymbol) provides the settings for a line, including visibility, x, y, z, line color, line width, line style, symbol marker, symbol size, symbol face color, and symbol edge color. The handle must be a line.';
				case 4 % SettingsLine.TEMPLATE
					prop_default = Format.getFormatDefault(8, SettingsLine.getPropSettings(prop));
				case 5 % SettingsLine.ID
					prop_default = 'SettingsLine ID';
				case 6 % SettingsLine.LABEL
					prop_default = 'SettingsLine label';
				case 7 % SettingsLine.NOTES
					prop_default = 'SettingsLine notes';
				otherwise
					prop_default = getPropDefault@Settings(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsLine.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsLine.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsLine, POINTER) returns the conditioned default value of POINTER of SettingsLine.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsLine, POINTER) returns the conditioned default value of POINTER of SettingsLine.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsLine')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsLine.getPropProp(pointer);
			
			prop_default = SettingsLine.conditioning(prop, SettingsLine.getPropDefault(prop));
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
			
			prop = SettingsLine.getPropProp(pointer);
			
			switch prop
				case 16 % SettingsLine.X
					value = value(:)';
					
				case 17 % SettingsLine.Y
					value = value(:)';
					
				case 18 % SettingsLine.Z
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
			%  CHECK = Element.CHECKPROP(SettingsLine, PROP, VALUE) checks VALUE format for PROP of SettingsLine.
			%  CHECK = ST.CHECKPROP(SettingsLine, PROP, VALUE) checks VALUE format for PROP of SettingsLine.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SettingsLine:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: BRAPH2:SettingsLine:WrongInput
			%  Element.CHECKPROP(SettingsLine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsLine.
			%   Error id: BRAPH2:SettingsLine:WrongInput
			%  ST.CHECKPROP(SettingsLine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsLine.
			%   Error id: BRAPH2:SettingsLine:WrongInput]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsLine')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsLine.getPropProp(pointer);
			
			switch prop
				case 15 % SettingsLine.VISIBLE
					check = Format.checkFormat(4, value, SettingsLine.getPropSettings(prop));
				case 16 % SettingsLine.X
					check = Format.checkFormat(12, value, SettingsLine.getPropSettings(prop));
				case 17 % SettingsLine.Y
					check = Format.checkFormat(12, value, SettingsLine.getPropSettings(prop));
				case 18 % SettingsLine.Z
					check = Format.checkFormat(12, value, SettingsLine.getPropSettings(prop));
				case 19 % SettingsLine.LINESTYLE
					check = Format.checkFormat(24, value, SettingsLine.getPropSettings(prop));
				case 20 % SettingsLine.LINEWIDTH
					check = Format.checkFormat(22, value, SettingsLine.getPropSettings(prop));
				case 21 % SettingsLine.LINECOLOR
					check = Format.checkFormat(20, value, SettingsLine.getPropSettings(prop));
				case 22 % SettingsLine.SYMBOL
					check = Format.checkFormat(23, value, SettingsLine.getPropSettings(prop));
				case 23 % SettingsLine.SYMBOLSIZE
					check = Format.checkFormat(22, value, SettingsLine.getPropSettings(prop));
				case 24 % SettingsLine.EDGECOLOR
					check = Format.checkFormat(20, value, SettingsLine.getPropSettings(prop));
				case 25 % SettingsLine.FACECOLOR
					check = Format.checkFormat(20, value, SettingsLine.getPropSettings(prop));
				case 4 % SettingsLine.TEMPLATE
					check = Format.checkFormat(8, value, SettingsLine.getPropSettings(prop));
				otherwise
					if prop <= 14
						check = checkProp@Settings(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsLine:' 'WrongInput'], ...
					['BRAPH2' ':SettingsLine:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsLine.getPropTag(prop) ' (' SettingsLine.getFormatTag(SettingsLine.getPropFormat(prop)) ').'] ...
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
				case 15 % SettingsLine.VISIBLE
					h = st.get('H');
					if check_graphics(h, 'line') && ( ...
					        get(h, 'Visible') ~= st.get('VISIBLE') || ...
					        ~isequal(get(h, 'XData'), st.get('X')) || ...
					        ~isequal(get(h, 'YData'), st.get('Y')) || ...
					        ~isequal(get(h, 'ZData'), st.get('Z')) || ...
					        ~isequal(get(h, 'Color'), st.get('LINECOLOR')) || ...
					        ~isequal(get(h, 'LineStyle'), st.get('LINESTYLE')) || ...
					        get(h, 'LineWidth') ~= st.get('LINEWIDTH') || ...
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
					            'Color', st.get('LINECOLOR'), ...
					            'LineStyle', st.get('LINESTYLE'), ...
					            'LineWidth', st.get('LINEWIDTH'), ...
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
