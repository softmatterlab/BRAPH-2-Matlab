classdef SettingsText < Settings
	%SettingsText contains the text settings.
	% It is a subclass of <a href="matlab:help Settings">Settings</a>.
	%
	% A Text Settings (SettingsText) provides the settings for a text, 
	% including visibility, x, y, z, font color, font size, and interpreter.
	% The handle can be a text.
	%
	% The list of SettingsText properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the text settings.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the text settings.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the text settings.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the text settings.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the text settings.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the text settings.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the text settings.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
	%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
	%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
	%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
	%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
	%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
	%  <strong>15</strong> <strong>VISIBLE</strong> 	VISIBLE (figure, logical) determines whether the text is visible.
	%  <strong>16</strong> <strong>X</strong> 	X (figure, scalar) is the x-coordinate.
	%  <strong>17</strong> <strong>Y</strong> 	Y (figure, scalar) is the y-coordinate.
	%  <strong>18</strong> <strong>Z</strong> 	Z (figure, scalar) is the z-coordinate.
	%  <strong>19</strong> <strong>TXT</strong> 	TXT (figure, string) is the text.
	%  <strong>20</strong> <strong>FONTSIZE</strong> 	FONTSIZE (figure, size) is the font size.
	%  <strong>21</strong> <strong>FONTNAME</strong> 	FONTNAME (figure, string) is the font name.
	%  <strong>22</strong> <strong>FONTCOLOR</strong> 	FONTCOLOR (figure, color) is the text color.
	%  <strong>23</strong> <strong>FONTWEIGHT</strong> 	FONTWEIGHT (figure, option) is the font weight.
	%  <strong>24</strong> <strong>INTERPRETER</strong> 	INTERPRETER (figure, option) is the text interpreter.
	%  <strong>25</strong> <strong>HALIGN</strong> 	HALIGN (figure, option) is the text horizonthal alignment.
	%  <strong>26</strong> <strong>VALIGN</strong> 	VALIGN (figure, option) is the text vertical alignment.
	%  <strong>27</strong> <strong>ROTATION</strong> 	ROTATION (figure, scalar) is the text rotation.
	%
	% SettingsText methods (constructor):
	%  SettingsText - constructor
	%
	% SettingsText methods:
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
	% SettingsText methods (display):
	%  tostring - string with information about the text settings
	%  disp - displays information about the text settings
	%  tree - displays the tree of the text settings
	%
	% SettingsText methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two text settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the text settings
	%
	% SettingsText methods (save/load, Static):
	%  save - saves BRAPH2 text settings as b2 file
	%  load - loads a BRAPH2 text settings from a b2 file
	%
	% SettingsText method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the text settings
	%
	% SettingsText method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the text settings
	%
	% SettingsText methods (inspection, Static):
	%  getClass - returns the class of the text settings
	%  getSubclasses - returns all subclasses of SettingsText
	%  getProps - returns the property list of the text settings
	%  getPropNumber - returns the property number of the text settings
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
	% SettingsText methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsText methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsText methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsText methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsText; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsText constants</a>.
	%
	%
	% See also text, PanelFig, GUIFig, check_graphics.
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
		
		TXT = 19; %CET: Computational Efficiency Trick
		TXT_TAG = 'TXT';
		TXT_CATEGORY = 8;
		TXT_FORMAT = 2;
		
		FONTSIZE = 20; %CET: Computational Efficiency Trick
		FONTSIZE_TAG = 'FONTSIZE';
		FONTSIZE_CATEGORY = 8;
		FONTSIZE_FORMAT = 22;
		
		FONTNAME = 21; %CET: Computational Efficiency Trick
		FONTNAME_TAG = 'FONTNAME';
		FONTNAME_CATEGORY = 8;
		FONTNAME_FORMAT = 2;
		
		FONTCOLOR = 22; %CET: Computational Efficiency Trick
		FONTCOLOR_TAG = 'FONTCOLOR';
		FONTCOLOR_CATEGORY = 8;
		FONTCOLOR_FORMAT = 20;
		
		FONTWEIGHT = 23; %CET: Computational Efficiency Trick
		FONTWEIGHT_TAG = 'FONTWEIGHT';
		FONTWEIGHT_CATEGORY = 8;
		FONTWEIGHT_FORMAT = 5;
		
		INTERPRETER = 24; %CET: Computational Efficiency Trick
		INTERPRETER_TAG = 'INTERPRETER';
		INTERPRETER_CATEGORY = 8;
		INTERPRETER_FORMAT = 5;
		
		HALIGN = 25; %CET: Computational Efficiency Trick
		HALIGN_TAG = 'HALIGN';
		HALIGN_CATEGORY = 8;
		HALIGN_FORMAT = 5;
		
		VALIGN = 26; %CET: Computational Efficiency Trick
		VALIGN_TAG = 'VALIGN';
		VALIGN_CATEGORY = 8;
		VALIGN_FORMAT = 5;
		
		ROTATION = 27; %CET: Computational Efficiency Trick
		ROTATION_TAG = 'ROTATION';
		ROTATION_CATEGORY = 8;
		ROTATION_FORMAT = 11;
	end
	methods % constructor
		function st = SettingsText(varargin)
			%SettingsText() creates a text settings.
			%
			% SettingsText(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsText(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SettingsText properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the text settings.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the text settings.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the text settings.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the text settings.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the text settings.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the text settings.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the text settings.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>PANEL</strong> 	PANEL (gui, item) is the panel to which the graphics object belongs.
			%  <strong>10</strong> <strong>PROP</strong> 	PROP (gui, scalar) is the prop of the graphics handle(list).
			%  <strong>11</strong> <strong>TAG</strong> 	TAG (gui, string) is the tag of the graphics handle(s).
			%  <strong>12</strong> <strong>I</strong> 	I (gui, scalar) is the index of the handle, used only by handlelists.
			%  <strong>13</strong> <strong>H</strong> 	H (query, handle) is the graphics object handle.
			%  <strong>14</strong> <strong>SETUP</strong> 	SETUP (query, scalar) sets all figure props.
			%  <strong>15</strong> <strong>VISIBLE</strong> 	VISIBLE (figure, logical) determines whether the text is visible.
			%  <strong>16</strong> <strong>X</strong> 	X (figure, scalar) is the x-coordinate.
			%  <strong>17</strong> <strong>Y</strong> 	Y (figure, scalar) is the y-coordinate.
			%  <strong>18</strong> <strong>Z</strong> 	Z (figure, scalar) is the z-coordinate.
			%  <strong>19</strong> <strong>TXT</strong> 	TXT (figure, string) is the text.
			%  <strong>20</strong> <strong>FONTSIZE</strong> 	FONTSIZE (figure, size) is the font size.
			%  <strong>21</strong> <strong>FONTNAME</strong> 	FONTNAME (figure, string) is the font name.
			%  <strong>22</strong> <strong>FONTCOLOR</strong> 	FONTCOLOR (figure, color) is the text color.
			%  <strong>23</strong> <strong>FONTWEIGHT</strong> 	FONTWEIGHT (figure, option) is the font weight.
			%  <strong>24</strong> <strong>INTERPRETER</strong> 	INTERPRETER (figure, option) is the text interpreter.
			%  <strong>25</strong> <strong>HALIGN</strong> 	HALIGN (figure, option) is the text horizonthal alignment.
			%  <strong>26</strong> <strong>VALIGN</strong> 	VALIGN (figure, option) is the text vertical alignment.
			%  <strong>27</strong> <strong>ROTATION</strong> 	ROTATION (figure, scalar) is the text rotation.
			%
			% See also Category, Format.
			
			st = st@Settings(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the text settings.
			%
			% BUILD = SettingsText.GETBUILD() returns the build of 'SettingsText'.
			%
			% Alternative forms to call this method are:
			%  BUILD = ST.GETBUILD() returns the build of the text settings ST.
			%  BUILD = Element.GETBUILD(ST) returns the build of 'ST'.
			%  BUILD = Element.GETBUILD('SettingsText') returns the build of 'SettingsText'.
			%
			% Note that the Element.GETBUILD(ST) and Element.GETBUILD('SettingsText')
			%  are less computationally efficient.
			
			build = 1;
		end
		function st_class = getClass()
			%GETCLASS returns the class of the text settings.
			%
			% CLASS = SettingsText.GETCLASS() returns the class 'SettingsText'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the text settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsText') returns 'SettingsText'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsText')
			%  are less computationally efficient.
			
			st_class = 'SettingsText';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the text settings.
			%
			% LIST = SettingsText.GETSUBCLASSES() returns all subclasses of 'SettingsText'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the text settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsText') returns all subclasses of 'SettingsText'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsText')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SettingsText' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of text settings.
			%
			% PROPS = SettingsText.GETPROPS() returns the property list of text settings
			%  as a row vector.
			%
			% PROPS = SettingsText.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the text settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsText'[, CATEGORY]) returns the property list of 'SettingsText'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsText')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27];
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
					prop_list = [15 16 17 18 19 20 21 22 23 24 25 26 27];
				case 9 % Category.GUI
					prop_list = [9 10 11 12];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of text settings.
			%
			% N = SettingsText.GETPROPNUMBER() returns the property number of text settings.
			%
			% N = SettingsText.GETPROPNUMBER(CATEGORY) returns the property number of text settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the text settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsText') returns the property number of 'SettingsText'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsText')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 27;
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
					prop_number = 13;
				case 9 % Category.GUI
					prop_number = 4;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in text settings/error.
			%
			% CHECK = SettingsText.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsText, PROP) checks whether PROP exists for SettingsText.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsText:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsText:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsText:WrongInput]
			%  Element.EXISTSPROP(SettingsText, PROP) throws error if PROP does NOT exist for SettingsText.
			%   Error id: [BRAPH2:SettingsText:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsText')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 27 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsText:' 'WrongInput'], ...
					['BRAPH2' ':SettingsText:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsText.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in text settings/error.
			%
			% CHECK = SettingsText.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsText, TAG) checks whether TAG exists for SettingsText.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsText:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsText:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsText:WrongInput]
			%  Element.EXISTSTAG(SettingsText, TAG) throws error if TAG does NOT exist for SettingsText.
			%   Error id: [BRAPH2:SettingsText:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsText')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'VISIBLE'  'X'  'Y'  'Z'  'TXT'  'FONTSIZE'  'FONTNAME'  'FONTCOLOR'  'FONTWEIGHT'  'INTERPRETER'  'HALIGN'  'VALIGN'  'ROTATION' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsText:' 'WrongInput'], ...
					['BRAPH2' ':SettingsText:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SettingsText.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsText, POINTER) returns property number of POINTER of SettingsText.
			%  PROPERTY = ST.GETPROPPROP(SettingsText, POINTER) returns property number of POINTER of SettingsText.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsText')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'VISIBLE'  'X'  'Y'  'Z'  'TXT'  'FONTSIZE'  'FONTNAME'  'FONTCOLOR'  'FONTWEIGHT'  'INTERPRETER'  'HALIGN'  'VALIGN'  'ROTATION' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(SettingsText, POINTER) returns tag of POINTER of SettingsText.
			%  TAG = ST.GETPROPTAG(SettingsText, POINTER) returns tag of POINTER of SettingsText.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsText')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				settingstext_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PANEL'  'PROP'  'TAG'  'I'  'H'  'SETUP'  'VISIBLE'  'X'  'Y'  'Z'  'TXT'  'FONTSIZE'  'FONTNAME'  'FONTCOLOR'  'FONTWEIGHT'  'INTERPRETER'  'HALIGN'  'VALIGN'  'ROTATION' };
				tag = settingstext_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsText, POINTER) returns category of POINTER of SettingsText.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsText, POINTER) returns category of POINTER of SettingsText.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsText')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsText.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingstext_category_list = { 1  1  1  3  4  2  2  6  9  9  9  9  6  6  8  8  8  8  8  8  8  8  8  8  8  8  8 };
			prop_category = settingstext_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsText, POINTER) returns format of POINTER of SettingsText.
			%  FORMAT = ST.GETPROPFORMAT(SettingsText, POINTER) returns format of POINTER of SettingsText.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsText')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsText.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingstext_format_list = { 2  2  2  8  2  2  2  2  8  11  2  11  18  11  4  11  11  11  2  22  2  20  5  5  5  5  11 };
			prop_format = settingstext_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsText, POINTER) returns description of POINTER of SettingsText.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsText, POINTER) returns description of POINTER of SettingsText.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsText')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsText.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingstext_description_list = { 'ELCLASS (constant, string) is the class of the text settings.'  'NAME (constant, string) is the name of the text settings.'  'DESCRIPTION (constant, string) is the description of the text settings.'  'TEMPLATE (parameter, item) is the template of the text settings.'  'ID (data, string) is a few-letter code for the text settings.'  'LABEL (metadata, string) is an extended label of the text settings.'  'NOTES (metadata, string) are some specific notes about the text settings.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'PANEL (gui, item) is the panel to which the graphics object belongs.'  'PROP (gui, scalar) is the prop of the graphics handle(list).'  'TAG (gui, string) is the tag of the graphics handle(s).'  'I (gui, scalar) is the index of the handle, used only by handlelists.'  'H (query, handle) is the graphics object handle.'  'SETUP (query, scalar) sets all figure props.'  'VISIBLE (figure, logical) determines whether the text is visible.'  'X (figure, scalar) is the x-coordinate.'  'Y (figure, scalar) is the y-coordinate.'  'Z (figure, scalar) is the z-coordinate.'  'TXT (figure, string) is the text.'  'FONTSIZE (figure, size) is the font size.'  'FONTNAME (figure, string) is the font name.'  'FONTCOLOR (figure, color) is the text color.'  'FONTWEIGHT (figure, option) is the font weight.'  'INTERPRETER (figure, option) is the text interpreter.'  'HALIGN (figure, option) is the text horizonthal alignment.'  'VALIGN (figure, option) is the text vertical alignment.'  'ROTATION (figure, scalar) is the text rotation.' };
			prop_description = settingstext_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsText, POINTER) returns settings of POINTER of SettingsText.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsText, POINTER) returns settings of POINTER of SettingsText.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsText')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsText.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SettingsText.VISIBLE
					prop_settings = Format.getFormatSettings(4);
				case 16 % SettingsText.X
					prop_settings = Format.getFormatSettings(11);
				case 17 % SettingsText.Y
					prop_settings = Format.getFormatSettings(11);
				case 18 % SettingsText.Z
					prop_settings = Format.getFormatSettings(11);
				case 19 % SettingsText.TXT
					prop_settings = Format.getFormatSettings(2);
				case 20 % SettingsText.FONTSIZE
					prop_settings = Format.getFormatSettings(22);
				case 21 % SettingsText.FONTNAME
					prop_settings = Format.getFormatSettings(2);
				case 22 % SettingsText.FONTCOLOR
					prop_settings = Format.getFormatSettings(20);
				case 23 % SettingsText.FONTWEIGHT
					prop_settings = {'normal' 'bold'};
				case 24 % SettingsText.INTERPRETER
					prop_settings = {'none', 'TeX', 'LaTeX'};
				case 25 % SettingsText.HALIGN
					prop_settings = {'left', 'center', 'right'};
				case 26 % SettingsText.VALIGN
					prop_settings = {'middle', 'top', 'bottom', 'baseline', 'cap'};
				case 27 % SettingsText.ROTATION
					prop_settings = Format.getFormatSettings(11);
				case 4 % SettingsText.TEMPLATE
					prop_settings = 'SettingsText';
				otherwise
					prop_settings = getPropSettings@Settings(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsText.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsText.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsText, POINTER) returns the default value of POINTER of SettingsText.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsText, POINTER) returns the default value of POINTER of SettingsText.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsText')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsText.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % SettingsText.VISIBLE
					prop_default = Format.getFormatDefault(4, SettingsText.getPropSettings(prop));
				case 16 % SettingsText.X
					prop_default = Format.getFormatDefault(11, SettingsText.getPropSettings(prop));
				case 17 % SettingsText.Y
					prop_default = Format.getFormatDefault(11, SettingsText.getPropSettings(prop));
				case 18 % SettingsText.Z
					prop_default = Format.getFormatDefault(11, SettingsText.getPropSettings(prop));
				case 19 % SettingsText.TXT
					prop_default = Format.getFormatDefault(2, SettingsText.getPropSettings(prop));
				case 20 % SettingsText.FONTSIZE
					prop_default = 12;
				case 21 % SettingsText.FONTNAME
					prop_default = 'Helvetica';
				case 22 % SettingsText.FONTCOLOR
					prop_default = [0 0 0];
				case 23 % SettingsText.FONTWEIGHT
					prop_default = 'normal';
				case 24 % SettingsText.INTERPRETER
					prop_default = 'none';
				case 25 % SettingsText.HALIGN
					prop_default = Format.getFormatDefault(5, SettingsText.getPropSettings(prop));
				case 26 % SettingsText.VALIGN
					prop_default = Format.getFormatDefault(5, SettingsText.getPropSettings(prop));
				case 27 % SettingsText.ROTATION
					prop_default = Format.getFormatDefault(11, SettingsText.getPropSettings(prop));
				case 1 % SettingsText.ELCLASS
					prop_default = 'SettingsText';
				case 2 % SettingsText.NAME
					prop_default = 'Text Settings';
				case 3 % SettingsText.DESCRIPTION
					prop_default = 'A Text Settings (SettingsText) provides the settings for a text, including visibility, x, y, z, font color, font size, and interpreter.';
				case 4 % SettingsText.TEMPLATE
					prop_default = Format.getFormatDefault(8, SettingsText.getPropSettings(prop));
				case 5 % SettingsText.ID
					prop_default = 'SettingsText ID';
				case 6 % SettingsText.LABEL
					prop_default = 'SettingsText label';
				case 7 % SettingsText.NOTES
					prop_default = 'SettingsText notes';
				otherwise
					prop_default = getPropDefault@Settings(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsText.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsText.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsText, POINTER) returns the conditioned default value of POINTER of SettingsText.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsText, POINTER) returns the conditioned default value of POINTER of SettingsText.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsText')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsText.getPropProp(pointer);
			
			prop_default = SettingsText.conditioning(prop, SettingsText.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsText, PROP, VALUE) checks VALUE format for PROP of SettingsText.
			%  CHECK = ST.CHECKPROP(SettingsText, PROP, VALUE) checks VALUE format for PROP of SettingsText.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SettingsText:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: BRAPH2:SettingsText:WrongInput
			%  Element.CHECKPROP(SettingsText, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsText.
			%   Error id: BRAPH2:SettingsText:WrongInput
			%  ST.CHECKPROP(SettingsText, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsText.
			%   Error id: BRAPH2:SettingsText:WrongInput]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsText')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsText.getPropProp(pointer);
			
			switch prop
				case 15 % SettingsText.VISIBLE
					check = Format.checkFormat(4, value, SettingsText.getPropSettings(prop));
				case 16 % SettingsText.X
					check = Format.checkFormat(11, value, SettingsText.getPropSettings(prop));
				case 17 % SettingsText.Y
					check = Format.checkFormat(11, value, SettingsText.getPropSettings(prop));
				case 18 % SettingsText.Z
					check = Format.checkFormat(11, value, SettingsText.getPropSettings(prop));
				case 19 % SettingsText.TXT
					check = Format.checkFormat(2, value, SettingsText.getPropSettings(prop));
				case 20 % SettingsText.FONTSIZE
					check = Format.checkFormat(22, value, SettingsText.getPropSettings(prop));
				case 21 % SettingsText.FONTNAME
					check = Format.checkFormat(2, value, SettingsText.getPropSettings(prop));
				case 22 % SettingsText.FONTCOLOR
					check = Format.checkFormat(20, value, SettingsText.getPropSettings(prop));
				case 23 % SettingsText.FONTWEIGHT
					check = Format.checkFormat(5, value, SettingsText.getPropSettings(prop));
				case 24 % SettingsText.INTERPRETER
					check = Format.checkFormat(5, value, SettingsText.getPropSettings(prop));
				case 25 % SettingsText.HALIGN
					check = Format.checkFormat(5, value, SettingsText.getPropSettings(prop));
				case 26 % SettingsText.VALIGN
					check = Format.checkFormat(5, value, SettingsText.getPropSettings(prop));
				case 27 % SettingsText.ROTATION
					check = Format.checkFormat(11, value, SettingsText.getPropSettings(prop));
				case 4 % SettingsText.TEMPLATE
					check = Format.checkFormat(8, value, SettingsText.getPropSettings(prop));
				otherwise
					if prop <= 14
						check = checkProp@Settings(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsText:' 'WrongInput'], ...
					['BRAPH2' ':SettingsText:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsText.getPropTag(prop) ' (' SettingsText.getFormatTag(SettingsText.getPropFormat(prop)) ').'] ...
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
				case 15 % SettingsText.VISIBLE
					h = st.get('H');
					if check_graphics(h, 'text') && ( ...
					        get(h, 'Visible') ~= st.get('VISIBLE') || ...
					        ~isequal(get(h, 'Position'), [st.get('X') st.get('Y') st.get('Z')]) || ...
					        ~isequal(get(h, 'String'), st.get('TXT')) || ...
					        get(h, 'FontSize') ~= st.get('FONTSIZE') || ...
					        ~isequal(get(h, 'FontName'), st.get('FONTNAME')) || ...
					        ~isequal(get(h, 'Color'), st.get('FONTCOLOR')) || ...
					        ~isequal(get(h, 'FontWeight'), st.get('FONTWEIGHT')) || ...        
					        ~isequal(get(h, 'Interpreter'), st.get('INTERPRETER')) || ...
					        ~isequal(get(h, 'HorizontalAlignment'), st.get('HALIGN')) || ...
					        ~isequal(get(h, 'VerticalAlignment'), st.get('VALIGN')) || ...
					        get(h, 'Rotation') ~= st.get('ROTATION') ...
					        )
					    if st.get('VISIBLE')
					        set(h, ...
					            'Position', [st.get('X') st.get('Y') st.get('Z')], ...
					            'String', st.get('TXT'), ...
					            'FontSize', st.get('FONTSIZE'), ...
					            'FontName', st.get('FONTNAME'), ...
					            'Color', st.get('FONTCOLOR'), ...
					            'FontWeight', st.get('FONTWEIGHT'), ...
					            'Interpreter', st.get('INTERPRETER'), ...
					            'HorizontalAlignment', st.get('HALIGN'), ...
					            'VerticalAlignment', st.get('VALIGN'), ...
					            'Rotation', st.get('ROTATION'), ...
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
