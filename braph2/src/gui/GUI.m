classdef GUI < ConcreteElement
	%GUI renders a GUI figure.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A GUI renders a figure with its basic functionalities.
	% 
	% CONSTRUCTOR - To construct a GUI use, e.g.:
	% 
	%     gui = GUI('<strong>TITLE</strong>', 'Figure Title', '<strong>POSITION</strong>', [x0 y0 w h], '<strong>BKGCOLOR</strong>', [r g b]);
	%     
	% DRAW - To create and show the figure, use:
	% 
	%     gui.get('<strong>DRAW</strong>')
	%     gui.get('<strong>SHOW</strong>')
	%     f = gui.get('<strong>H</strong>'); % f is the figure handle.
	% 
	%  The query gui.get('<strong>DRAWN</strong>') returns whether the GUI has 
	%   been drawn and therefore can be shown.
	%  
	% CALLBACK - These are the public callbacks:
	% 
	%     gui.get('<strong>RESIZE</strong>') - updates POSITION when figure size is changed
	%     gui.get('<strong>SHOW</strong>') - brings to the front the figure and its dependent figures
	%     gui.get('<strong>HIDE</strong>') - hides the figure and its dependent figures
	%     gui.get('<strong>DELETE</strong>') - resets the handles (automatically called when the figure is deleted)
	%     gui.get('<strong>CLOSE</strong>') - closes the figure and its dependent figures
	%
	% The list of GUI properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the graphical user interface.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the graphical user interface.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the graphical user interface.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the graphical user interface.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the graphical user interface.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the graphical user interface.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graphical user interface.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the contents of a GUI before showing it.
	%  <strong>11</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the GUI has been drawn.
	%  <strong>12</strong> <strong>TITLE</strong> 	TITLE (gui, string) is the name of the GUI.
	%  <strong>13</strong> <strong>POSITION</strong> 	POSITION (gui, rvector) is the normalized position of the GUI on the screen.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (gui, color) is the GUI background color.
	%  <strong>15</strong> <strong>H_MENUBAR</strong> 	H_MENUBAR (evanescent, handlelist) is the list of handles for the menus.
	%  <strong>16</strong> <strong>MENUBAR</strong> 	MENUBAR (gui, logical) determines whether to show the menubar [set before DRAW].
	%  <strong>17</strong> <strong>H_MENU_ABOUT</strong> 	H_MENU_ABOUT (evanescent, handle) is the handle of the menu about.
	%  <strong>18</strong> <strong>MENU_ABOUT</strong> 	MENU_ABOUT (gui, logical) determines whether to show the menu about [set before DRAW].
	%  <strong>19</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) is the handle list of the toolbar.
	%  <strong>20</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the handle list of the tools from the first.
	%  <strong>21</strong> <strong>TOOLBAR</strong> 	TOOLBAR (gui, logical) determines whether to show the toolbar [set before DRAW].
	%  <strong>22</strong> <strong>TOOL_ABOUT</strong> 	TOOL_ABOUT (gui, logical) determines whether to show the toolbar about buttons [set before DRAW].
	%  <strong>23</strong> <strong>CLOSEREQ</strong> 	CLOSEREQ (gui, logical) determines whether to confirm close.
	%  <strong>24</strong> <strong>H</strong> 	H (evanescent, handle) is the figure handle.
	%  <strong>25</strong> <strong>RESIZE</strong> 	RESIZE (query, logical) updates POSITION when figure size is changed.
	%  <strong>26</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure and its dependent figures.
	%  <strong>27</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure and its dependent figures.
	%  <strong>28</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the figure is deleted.
	%  <strong>29</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure and its dependent figures.
	%
	% GUI methods (constructor):
	%  GUI - constructor
	%
	% GUI methods:
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
	% GUI methods (display):
	%  tostring - string with information about the graphical user interface
	%  disp - displays information about the graphical user interface
	%  tree - displays the tree of the graphical user interface
	%
	% GUI methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graphical user interface are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graphical user interface
	%
	% GUI methods (save/load, Static):
	%  save - saves BRAPH2 graphical user interface as b2 file
	%  load - loads a BRAPH2 graphical user interface from a b2 file
	%
	% GUI method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graphical user interface
	%
	% GUI method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graphical user interface
	%
	% GUI methods (inspection, Static):
	%  getClass - returns the class of the graphical user interface
	%  getSubclasses - returns all subclasses of GUI
	%  getProps - returns the property list of the graphical user interface
	%  getPropNumber - returns the property number of the graphical user interface
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
	% GUI methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GUI methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GUI methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GUI methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GUI; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GUI constants</a>.
	%
	%
	% See also uifigure, GUIElement, GUIFig.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		WAITBAR = 9; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
		
		DRAW = 10; %CET: Computational Efficiency Trick
		DRAW_TAG = 'DRAW';
		DRAW_CATEGORY = 6;
		DRAW_FORMAT = 4;
		
		DRAWN = 11; %CET: Computational Efficiency Trick
		DRAWN_TAG = 'DRAWN';
		DRAWN_CATEGORY = 6;
		DRAWN_FORMAT = 4;
		
		TITLE = 12; %CET: Computational Efficiency Trick
		TITLE_TAG = 'TITLE';
		TITLE_CATEGORY = 9;
		TITLE_FORMAT = 2;
		
		POSITION = 13; %CET: Computational Efficiency Trick
		POSITION_TAG = 'POSITION';
		POSITION_CATEGORY = 9;
		POSITION_FORMAT = 12;
		
		BKGCOLOR = 14; %CET: Computational Efficiency Trick
		BKGCOLOR_TAG = 'BKGCOLOR';
		BKGCOLOR_CATEGORY = 9;
		BKGCOLOR_FORMAT = 20;
		
		H_MENUBAR = 15; %CET: Computational Efficiency Trick
		H_MENUBAR_TAG = 'H_MENUBAR';
		H_MENUBAR_CATEGORY = 7;
		H_MENUBAR_FORMAT = 19;
		
		MENUBAR = 16; %CET: Computational Efficiency Trick
		MENUBAR_TAG = 'MENUBAR';
		MENUBAR_CATEGORY = 9;
		MENUBAR_FORMAT = 4;
		
		H_MENU_ABOUT = 17; %CET: Computational Efficiency Trick
		H_MENU_ABOUT_TAG = 'H_MENU_ABOUT';
		H_MENU_ABOUT_CATEGORY = 7;
		H_MENU_ABOUT_FORMAT = 18;
		
		MENU_ABOUT = 18; %CET: Computational Efficiency Trick
		MENU_ABOUT_TAG = 'MENU_ABOUT';
		MENU_ABOUT_CATEGORY = 9;
		MENU_ABOUT_FORMAT = 4;
		
		H_TOOLBAR = 19; %CET: Computational Efficiency Trick
		H_TOOLBAR_TAG = 'H_TOOLBAR';
		H_TOOLBAR_CATEGORY = 7;
		H_TOOLBAR_FORMAT = 18;
		
		H_TOOLS = 20; %CET: Computational Efficiency Trick
		H_TOOLS_TAG = 'H_TOOLS';
		H_TOOLS_CATEGORY = 7;
		H_TOOLS_FORMAT = 19;
		
		TOOLBAR = 21; %CET: Computational Efficiency Trick
		TOOLBAR_TAG = 'TOOLBAR';
		TOOLBAR_CATEGORY = 9;
		TOOLBAR_FORMAT = 4;
		
		TOOL_ABOUT = 22; %CET: Computational Efficiency Trick
		TOOL_ABOUT_TAG = 'TOOL_ABOUT';
		TOOL_ABOUT_CATEGORY = 9;
		TOOL_ABOUT_FORMAT = 4;
		
		CLOSEREQ = 23; %CET: Computational Efficiency Trick
		CLOSEREQ_TAG = 'CLOSEREQ';
		CLOSEREQ_CATEGORY = 9;
		CLOSEREQ_FORMAT = 4;
		
		H = 24; %CET: Computational Efficiency Trick
		H_TAG = 'H';
		H_CATEGORY = 7;
		H_FORMAT = 18;
		
		RESIZE = 25; %CET: Computational Efficiency Trick
		RESIZE_TAG = 'RESIZE';
		RESIZE_CATEGORY = 6;
		RESIZE_FORMAT = 4;
		
		SHOW = 26; %CET: Computational Efficiency Trick
		SHOW_TAG = 'SHOW';
		SHOW_CATEGORY = 6;
		SHOW_FORMAT = 4;
		
		HIDE = 27; %CET: Computational Efficiency Trick
		HIDE_TAG = 'HIDE';
		HIDE_CATEGORY = 6;
		HIDE_FORMAT = 4;
		
		DELETE = 28; %CET: Computational Efficiency Trick
		DELETE_TAG = 'DELETE';
		DELETE_CATEGORY = 6;
		DELETE_FORMAT = 4;
		
		CLOSE = 29; %CET: Computational Efficiency Trick
		CLOSE_TAG = 'CLOSE';
		CLOSE_CATEGORY = 6;
		CLOSE_FORMAT = 4;
	end
	methods % constructor
		function gui = GUI(varargin)
			%GUI() creates a graphical user interface.
			%
			% GUI(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GUI(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GUI properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the graphical user interface.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the graphical user interface.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the graphical user interface.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the graphical user interface.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the graphical user interface.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the graphical user interface.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graphical user interface.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the contents of a GUI before showing it.
			%  <strong>11</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the GUI has been drawn.
			%  <strong>12</strong> <strong>TITLE</strong> 	TITLE (gui, string) is the name of the GUI.
			%  <strong>13</strong> <strong>POSITION</strong> 	POSITION (gui, rvector) is the normalized position of the GUI on the screen.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (gui, color) is the GUI background color.
			%  <strong>15</strong> <strong>H_MENUBAR</strong> 	H_MENUBAR (evanescent, handlelist) is the list of handles for the menus.
			%  <strong>16</strong> <strong>MENUBAR</strong> 	MENUBAR (gui, logical) determines whether to show the menubar [set before DRAW].
			%  <strong>17</strong> <strong>H_MENU_ABOUT</strong> 	H_MENU_ABOUT (evanescent, handle) is the handle of the menu about.
			%  <strong>18</strong> <strong>MENU_ABOUT</strong> 	MENU_ABOUT (gui, logical) determines whether to show the menu about [set before DRAW].
			%  <strong>19</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) is the handle list of the toolbar.
			%  <strong>20</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the handle list of the tools from the first.
			%  <strong>21</strong> <strong>TOOLBAR</strong> 	TOOLBAR (gui, logical) determines whether to show the toolbar [set before DRAW].
			%  <strong>22</strong> <strong>TOOL_ABOUT</strong> 	TOOL_ABOUT (gui, logical) determines whether to show the toolbar about buttons [set before DRAW].
			%  <strong>23</strong> <strong>CLOSEREQ</strong> 	CLOSEREQ (gui, logical) determines whether to confirm close.
			%  <strong>24</strong> <strong>H</strong> 	H (evanescent, handle) is the figure handle.
			%  <strong>25</strong> <strong>RESIZE</strong> 	RESIZE (query, logical) updates POSITION when figure size is changed.
			%  <strong>26</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure and its dependent figures.
			%  <strong>27</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure and its dependent figures.
			%  <strong>28</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the figure is deleted.
			%  <strong>29</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure and its dependent figures.
			%
			% See also Category, Format.
			
			gui = gui@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the graphical user interface.
			%
			% BUILD = GUI.GETBUILD() returns the build of 'GUI'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GUI.GETBUILD() returns the build of the graphical user interface GUI.
			%  BUILD = Element.GETBUILD(GUI) returns the build of 'GUI'.
			%  BUILD = Element.GETBUILD('GUI') returns the build of 'GUI'.
			%
			% Note that the Element.GETBUILD(GUI) and Element.GETBUILD('GUI')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gui_class = getClass()
			%GETCLASS returns the class of the graphical user interface.
			%
			% CLASS = GUI.GETCLASS() returns the class 'GUI'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GUI.GETCLASS() returns the class of the graphical user interface GUI.
			%  CLASS = Element.GETCLASS(GUI) returns the class of 'GUI'.
			%  CLASS = Element.GETCLASS('GUI') returns 'GUI'.
			%
			% Note that the Element.GETCLASS(GUI) and Element.GETCLASS('GUI')
			%  are less computationally efficient.
			
			gui_class = 'GUI';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graphical user interface.
			%
			% LIST = GUI.GETSUBCLASSES() returns all subclasses of 'GUI'.
			%
			% Alternative forms to call this method are:
			%  LIST = GUI.GETSUBCLASSES() returns all subclasses of the graphical user interface GUI.
			%  LIST = Element.GETSUBCLASSES(GUI) returns all subclasses of 'GUI'.
			%  LIST = Element.GETSUBCLASSES('GUI') returns all subclasses of 'GUI'.
			%
			% Note that the Element.GETSUBCLASSES(GUI) and Element.GETSUBCLASSES('GUI')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GUI'  'GUIElement'  'GUIFig'  'GUILayout' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graphical user interface.
			%
			% PROPS = GUI.GETPROPS() returns the property list of graphical user interface
			%  as a row vector.
			%
			% PROPS = GUI.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GUI.GETPROPS([CATEGORY]) returns the property list of the graphical user interface GUI.
			%  PROPS = Element.GETPROPS(GUI[, CATEGORY]) returns the property list of 'GUI'.
			%  PROPS = Element.GETPROPS('GUI'[, CATEGORY]) returns the property list of 'GUI'.
			%
			% Note that the Element.GETPROPS(GUI) and Element.GETPROPS('GUI')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29];
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
					prop_list = [8 10 11 25 26 27 28 29];
				case 7 % Category.EVANESCENT
					prop_list = [15 17 19 20 24];
				case 9 % Category.GUI
					prop_list = [9 12 13 14 16 18 21 22 23];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graphical user interface.
			%
			% N = GUI.GETPROPNUMBER() returns the property number of graphical user interface.
			%
			% N = GUI.GETPROPNUMBER(CATEGORY) returns the property number of graphical user interface
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GUI.GETPROPNUMBER([CATEGORY]) returns the property number of the graphical user interface GUI.
			%  N = Element.GETPROPNUMBER(GUI) returns the property number of 'GUI'.
			%  N = Element.GETPROPNUMBER('GUI') returns the property number of 'GUI'.
			%
			% Note that the Element.GETPROPNUMBER(GUI) and Element.GETPROPNUMBER('GUI')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 29;
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
					prop_number = 8;
				case 7 % Category.EVANESCENT
					prop_number = 5;
				case 9 % Category.GUI
					prop_number = 9;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graphical user interface/error.
			%
			% CHECK = GUI.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GUI.EXISTSPROP(PROP) checks whether PROP exists for GUI.
			%  CHECK = Element.EXISTSPROP(GUI, PROP) checks whether PROP exists for GUI.
			%  CHECK = Element.EXISTSPROP(GUI, PROP) checks whether PROP exists for GUI.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GUI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GUI.EXISTSPROP(PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%  Element.EXISTSPROP(GUI, PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%  Element.EXISTSPROP(GUI, PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GUI) and Element.EXISTSPROP('GUI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 29 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GUI:' 'WrongInput'], ...
					['BRAPH2' ':GUI:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GUI.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graphical user interface/error.
			%
			% CHECK = GUI.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GUI.EXISTSTAG(TAG) checks whether TAG exists for GUI.
			%  CHECK = Element.EXISTSTAG(GUI, TAG) checks whether TAG exists for GUI.
			%  CHECK = Element.EXISTSTAG(GUI, TAG) checks whether TAG exists for GUI.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GUI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GUI.EXISTSTAG(TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%  Element.EXISTSTAG(GUI, TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%  Element.EXISTSTAG(GUI, TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GUI) and Element.EXISTSTAG('GUI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DRAW'  'DRAWN'  'TITLE'  'POSITION'  'BKGCOLOR'  'H_MENUBAR'  'MENUBAR'  'H_MENU_ABOUT'  'MENU_ABOUT'  'H_TOOLBAR'  'H_TOOLS'  'TOOLBAR'  'TOOL_ABOUT'  'CLOSEREQ'  'H'  'RESIZE'  'SHOW'  'HIDE'  'DELETE'  'CLOSE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GUI:' 'WrongInput'], ...
					['BRAPH2' ':GUI:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GUI.'] ...
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
			%  PROPERTY = GUI.GETPROPPROP(POINTER) returns property number of POINTER of GUI.
			%  PROPERTY = Element.GETPROPPROP(GUI, POINTER) returns property number of POINTER of GUI.
			%  PROPERTY = GUI.GETPROPPROP(GUI, POINTER) returns property number of POINTER of GUI.
			%
			% Note that the Element.GETPROPPROP(GUI) and Element.GETPROPPROP('GUI')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DRAW'  'DRAWN'  'TITLE'  'POSITION'  'BKGCOLOR'  'H_MENUBAR'  'MENUBAR'  'H_MENU_ABOUT'  'MENU_ABOUT'  'H_TOOLBAR'  'H_TOOLS'  'TOOLBAR'  'TOOL_ABOUT'  'CLOSEREQ'  'H'  'RESIZE'  'SHOW'  'HIDE'  'DELETE'  'CLOSE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = GUI.GETPROPTAG(POINTER) returns tag of POINTER of GUI.
			%  TAG = Element.GETPROPTAG(GUI, POINTER) returns tag of POINTER of GUI.
			%  TAG = GUI.GETPROPTAG(GUI, POINTER) returns tag of POINTER of GUI.
			%
			% Note that the Element.GETPROPTAG(GUI) and Element.GETPROPTAG('GUI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				gui_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DRAW'  'DRAWN'  'TITLE'  'POSITION'  'BKGCOLOR'  'H_MENUBAR'  'MENUBAR'  'H_MENU_ABOUT'  'MENU_ABOUT'  'H_TOOLBAR'  'H_TOOLS'  'TOOLBAR'  'TOOL_ABOUT'  'CLOSEREQ'  'H'  'RESIZE'  'SHOW'  'HIDE'  'DELETE'  'CLOSE' };
				tag = gui_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = GUI.GETPROPCATEGORY(POINTER) returns category of POINTER of GUI.
			%  CATEGORY = Element.GETPROPCATEGORY(GUI, POINTER) returns category of POINTER of GUI.
			%  CATEGORY = GUI.GETPROPCATEGORY(GUI, POINTER) returns category of POINTER of GUI.
			%
			% Note that the Element.GETPROPCATEGORY(GUI) and Element.GETPROPCATEGORY('GUI')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gui_category_list = { 1  1  1  3  4  2  2  6  9  6  6  9  9  9  7  9  7  9  7  7  9  9  9  7  6  6  6  6  6 };
			prop_category = gui_category_list{prop};
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
			%  FORMAT = GUI.GETPROPFORMAT(POINTER) returns format of POINTER of GUI.
			%  FORMAT = Element.GETPROPFORMAT(GUI, POINTER) returns format of POINTER of GUI.
			%  FORMAT = GUI.GETPROPFORMAT(GUI, POINTER) returns format of POINTER of GUI.
			%
			% Note that the Element.GETPROPFORMAT(GUI) and Element.GETPROPFORMAT('GUI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gui_format_list = { 2  2  2  8  2  2  2  2  4  4  4  2  12  20  19  4  18  4  18  19  4  4  4  18  4  4  4  4  4 };
			prop_format = gui_format_list{prop};
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
			%  DESCRIPTION = GUI.GETPROPDESCRIPTION(POINTER) returns description of POINTER of GUI.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GUI, POINTER) returns description of POINTER of GUI.
			%  DESCRIPTION = GUI.GETPROPDESCRIPTION(GUI, POINTER) returns description of POINTER of GUI.
			%
			% Note that the Element.GETPROPDESCRIPTION(GUI) and Element.GETPROPDESCRIPTION('GUI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gui_description_list = { 'ELCLASS (constant, string) is the class of the graphical user interface.'  'NAME (constant, string) is the name of the graphical user interface.'  'DESCRIPTION (constant, string) is the description of the graphical user interface.'  'TEMPLATE (parameter, item) is the template of the graphical user interface.'  'ID (data, string) is a few-letter code for the graphical user interface.'  'LABEL (metadata, string) is an extended label of the graphical user interface.'  'NOTES (metadata, string) are some specific notes about the graphical user interface.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'DRAW (query, logical) draws the contents of a GUI before showing it.'  'DRAWN (query, logical) returns whether the GUI has been drawn.'  'TITLE (gui, string) is the name of the GUI.'  'POSITION (gui, rvector) is the normalized position of the GUI on the screen.'  'BKGCOLOR (gui, color) is the GUI background color.'  'H_MENUBAR (evanescent, handlelist) is the list of handles for the menus.'  'MENUBAR (gui, logical) determines whether to show the menubar [set before DRAW].'  'H_MENU_ABOUT (evanescent, handle) is the handle of the menu about.'  'MENU_ABOUT (gui, logical) determines whether to show the menu about [set before DRAW].'  'H_TOOLBAR (evanescent, handle) is the handle list of the toolbar.'  'H_TOOLS (evanescent, handlelist) is the handle list of the tools from the first.'  'TOOLBAR (gui, logical) determines whether to show the toolbar [set before DRAW].'  'TOOL_ABOUT (gui, logical) determines whether to show the toolbar about buttons [set before DRAW].'  'CLOSEREQ (gui, logical) determines whether to confirm close.'  'H (evanescent, handle) is the figure handle.'  'RESIZE (query, logical) updates POSITION when figure size is changed.'  'SHOW (query, logical) shows the figure and its dependent figures.'  'HIDE (query, logical) hides the figure and its dependent figures.'  'DELETE (query, logical) resets the handles when the figure is deleted.'  'CLOSE (query, logical) closes the figure and its dependent figures.' };
			prop_description = gui_description_list{prop};
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
			%  SETTINGS = GUI.GETPROPSETTINGS(POINTER) returns settings of POINTER of GUI.
			%  SETTINGS = Element.GETPROPSETTINGS(GUI, POINTER) returns settings of POINTER of GUI.
			%  SETTINGS = GUI.GETPROPSETTINGS(GUI, POINTER) returns settings of POINTER of GUI.
			%
			% Note that the Element.GETPROPSETTINGS(GUI) and Element.GETPROPSETTINGS('GUI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GUI.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 10 % GUI.DRAW
					prop_settings = Format.getFormatSettings(4);
				case 11 % GUI.DRAWN
					prop_settings = Format.getFormatSettings(4);
				case 12 % GUI.TITLE
					prop_settings = Format.getFormatSettings(2);
				case 13 % GUI.POSITION
					prop_settings = Format.getFormatSettings(12);
				case 14 % GUI.BKGCOLOR
					prop_settings = Format.getFormatSettings(20);
				case 15 % GUI.H_MENUBAR
					prop_settings = Format.getFormatSettings(19);
				case 16 % GUI.MENUBAR
					prop_settings = Format.getFormatSettings(4);
				case 17 % GUI.H_MENU_ABOUT
					prop_settings = Format.getFormatSettings(18);
				case 18 % GUI.MENU_ABOUT
					prop_settings = Format.getFormatSettings(4);
				case 19 % GUI.H_TOOLBAR
					prop_settings = Format.getFormatSettings(18);
				case 20 % GUI.H_TOOLS
					prop_settings = Format.getFormatSettings(19);
				case 21 % GUI.TOOLBAR
					prop_settings = Format.getFormatSettings(4);
				case 22 % GUI.TOOL_ABOUT
					prop_settings = Format.getFormatSettings(4);
				case 23 % GUI.CLOSEREQ
					prop_settings = Format.getFormatSettings(4);
				case 24 % GUI.H
					prop_settings = Format.getFormatSettings(18);
				case 25 % GUI.RESIZE
					prop_settings = Format.getFormatSettings(4);
				case 26 % GUI.SHOW
					prop_settings = Format.getFormatSettings(4);
				case 27 % GUI.HIDE
					prop_settings = Format.getFormatSettings(4);
				case 28 % GUI.DELETE
					prop_settings = Format.getFormatSettings(4);
				case 29 % GUI.CLOSE
					prop_settings = Format.getFormatSettings(4);
				case 4 % GUI.TEMPLATE
					prop_settings = 'GUI';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GUI.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GUI.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GUI.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GUI.
			%  DEFAULT = Element.GETPROPDEFAULT(GUI, POINTER) returns the default value of POINTER of GUI.
			%  DEFAULT = GUI.GETPROPDEFAULT(GUI, POINTER) returns the default value of POINTER of GUI.
			%
			% Note that the Element.GETPROPDEFAULT(GUI) and Element.GETPROPDEFAULT('GUI')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GUI.WAITBAR
					prop_default = Format.getFormatDefault(4, GUI.getPropSettings(prop));
				case 10 % GUI.DRAW
					prop_default = Format.getFormatDefault(4, GUI.getPropSettings(prop));
				case 11 % GUI.DRAWN
					prop_default = Format.getFormatDefault(4, GUI.getPropSettings(prop));
				case 12 % GUI.TITLE
					prop_default = 'BRAPH2';
				case 13 % GUI.POSITION
					prop_default = [.00 .00 (PanelElement.getPropDefault('MIN_WIDTH')+20)/w(0, 'pixels') 1.00];
				case 14 % GUI.BKGCOLOR
					prop_default = [1 0.9725 0.929];
				case 15 % GUI.H_MENUBAR
					prop_default = Format.getFormatDefault(19, GUI.getPropSettings(prop));
				case 16 % GUI.MENUBAR
					prop_default = false;
				case 17 % GUI.H_MENU_ABOUT
					prop_default = Format.getFormatDefault(18, GUI.getPropSettings(prop));
				case 18 % GUI.MENU_ABOUT
					prop_default = false;
				case 19 % GUI.H_TOOLBAR
					prop_default = Format.getFormatDefault(18, GUI.getPropSettings(prop));
				case 20 % GUI.H_TOOLS
					prop_default = Format.getFormatDefault(19, GUI.getPropSettings(prop));
				case 21 % GUI.TOOLBAR
					prop_default = false;
				case 22 % GUI.TOOL_ABOUT
					prop_default = false;
				case 23 % GUI.CLOSEREQ
					prop_default = true;
				case 24 % GUI.H
					prop_default = Format.getFormatDefault(18, GUI.getPropSettings(prop));
				case 25 % GUI.RESIZE
					prop_default = Format.getFormatDefault(4, GUI.getPropSettings(prop));
				case 26 % GUI.SHOW
					prop_default = Format.getFormatDefault(4, GUI.getPropSettings(prop));
				case 27 % GUI.HIDE
					prop_default = Format.getFormatDefault(4, GUI.getPropSettings(prop));
				case 28 % GUI.DELETE
					prop_default = Format.getFormatDefault(4, GUI.getPropSettings(prop));
				case 29 % GUI.CLOSE
					prop_default = Format.getFormatDefault(4, GUI.getPropSettings(prop));
				case 1 % GUI.ELCLASS
					prop_default = 'GUI';
				case 2 % GUI.NAME
					prop_default = 'GUI';
				case 3 % GUI.DESCRIPTION
					prop_default = 'A GUI renders a figure with its basic functionalities.';
				case 4 % GUI.TEMPLATE
					prop_default = Format.getFormatDefault(8, GUI.getPropSettings(prop));
				case 5 % GUI.ID
					prop_default = 'GUI ID';
				case 6 % GUI.LABEL
					prop_default = 'GUI label';
				case 7 % GUI.NOTES
					prop_default = 'GUI notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GUI.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GUI, POINTER) returns the conditioned default value of POINTER of GUI.
			%  DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(GUI, POINTER) returns the conditioned default value of POINTER of GUI.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GUI) and Element.GETPROPDEFAULTCONDITIONED('GUI')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			prop_default = GUI.conditioning(prop, GUI.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = GUI.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = GUI.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of GUI.
			%  CHECK = Element.CHECKPROP(GUI, PROP, VALUE) checks VALUE format for PROP of GUI.
			%  CHECK = GUI.CHECKPROP(GUI, PROP, VALUE) checks VALUE format for PROP of GUI.
			% 
			% GUI.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GUI:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GUI.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GUI.
			%   Error id: BRAPH2:GUI:WrongInput
			%  Element.CHECKPROP(GUI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GUI.
			%   Error id: BRAPH2:GUI:WrongInput
			%  GUI.CHECKPROP(GUI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GUI.
			%   Error id: BRAPH2:GUI:WrongInput]
			% 
			% Note that the Element.CHECKPROP(GUI) and Element.CHECKPROP('GUI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GUI.getPropProp(pointer);
			
			switch prop
				case 9 % GUI.WAITBAR
					check = Format.checkFormat(4, value, GUI.getPropSettings(prop));
				case 10 % GUI.DRAW
					check = Format.checkFormat(4, value, GUI.getPropSettings(prop));
				case 11 % GUI.DRAWN
					check = Format.checkFormat(4, value, GUI.getPropSettings(prop));
				case 12 % GUI.TITLE
					check = Format.checkFormat(2, value, GUI.getPropSettings(prop));
				case 13 % GUI.POSITION
					check = Format.checkFormat(12, value, GUI.getPropSettings(prop));
					if check
						check = (length(value) == 4) && all(value(3:4) >= 0);
					end
				case 14 % GUI.BKGCOLOR
					check = Format.checkFormat(20, value, GUI.getPropSettings(prop));
				case 15 % GUI.H_MENUBAR
					check = Format.checkFormat(19, value, GUI.getPropSettings(prop));
				case 16 % GUI.MENUBAR
					check = Format.checkFormat(4, value, GUI.getPropSettings(prop));
				case 17 % GUI.H_MENU_ABOUT
					check = Format.checkFormat(18, value, GUI.getPropSettings(prop));
				case 18 % GUI.MENU_ABOUT
					check = Format.checkFormat(4, value, GUI.getPropSettings(prop));
				case 19 % GUI.H_TOOLBAR
					check = Format.checkFormat(18, value, GUI.getPropSettings(prop));
				case 20 % GUI.H_TOOLS
					check = Format.checkFormat(19, value, GUI.getPropSettings(prop));
				case 21 % GUI.TOOLBAR
					check = Format.checkFormat(4, value, GUI.getPropSettings(prop));
				case 22 % GUI.TOOL_ABOUT
					check = Format.checkFormat(4, value, GUI.getPropSettings(prop));
				case 23 % GUI.CLOSEREQ
					check = Format.checkFormat(4, value, GUI.getPropSettings(prop));
				case 24 % GUI.H
					check = Format.checkFormat(18, value, GUI.getPropSettings(prop));
				case 25 % GUI.RESIZE
					check = Format.checkFormat(4, value, GUI.getPropSettings(prop));
				case 26 % GUI.SHOW
					check = Format.checkFormat(4, value, GUI.getPropSettings(prop));
				case 27 % GUI.HIDE
					check = Format.checkFormat(4, value, GUI.getPropSettings(prop));
				case 28 % GUI.DELETE
					check = Format.checkFormat(4, value, GUI.getPropSettings(prop));
				case 29 % GUI.CLOSE
					check = Format.checkFormat(4, value, GUI.getPropSettings(prop));
				case 4 % GUI.TEMPLATE
					check = Format.checkFormat(8, value, GUI.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GUI:' 'WrongInput'], ...
					['BRAPH2' ':GUI:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GUI.getPropTag(prop) ' (' GUI.getFormatTag(GUI.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(gui, prop)
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
				case 12 % GUI.TITLE
					if gui.get('DRAWN')
					    set(gui.get('H'), 'Name', gui.get('TITLE'))
					end
					
				case 13 % GUI.POSITION
					if gui.get('DRAWN')
					    set(gui.get('H'), 'Position', gui.get('POSITION'))
					end
					
				case 14 % GUI.BKGCOLOR
					if gui.get('DRAWN')
					    set(gui.get('H'), 'Color', gui.get('BKGCOLOR'))
					end
					
				otherwise
					if prop <= 8
						postset@ConcreteElement(gui, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(gui, prop, varargin)
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
				case 10 % GUI.DRAW
					if check_graphics(gui.memorize('H'), 'figure')
					
					    if gui.get('MENUBAR')
					        gui.memorize('H_MENUBAR')
					    end
					
					    if gui.get('TOOLBAR')
					        % gui.memorize('H_TOOLBAR') % performed automatically by gui.memorize('H_TOOLS')
					        gui.memorize('H_TOOLS')
					    end
					    
					    drawnow()
					    
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(gui)], ...
					        ['BRAPH2' ':' class(gui) '\n' ...
					        'The call gui.get(''DRAW'') did not work.\n' ...
					        'This shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 11 % GUI.DRAWN
					value = check_graphics(gui.getr('H'), 'figure');
					
				case 15 % GUI.H_MENUBAR
					value = {};
					if gui.get('MENU_ABOUT')
					    value = [value, gui.memorize('H_MENU_ABOUT')];
					end
					
				case 17 % GUI.H_MENU_ABOUT
					menu_about = uimenu(gui.get('H'), ... % f for figure
					    'Tag', 'MENU.About', ...
					    'Label', 'About' ...
					    );
					
					uimenu(menu_about, ...
					    'Tag', 'MENU.About.Web', ...
					    'Label', 'BRAPH.org ...', ...
					    'Callback', 'BRAPH2.web()')
					uimenu(menu_about, ...
					    'Tag', 'MENU.About.Forum', ...
					    'Label', 'Forums ...', ...
					    'Callback', 'BRAPH2.forum()')
					uimenu(menu_about, ...
					    'Tag', 'MENU.About.Bluesky', ...
					    'Label', 'Bluesky ...', ...
					    'Callback', 'BRAPH2.bluesky()')
					uimenu(menu_about, ...
					    'Tag', 'MENU.About.License', ...
					    'Label', 'License ...', ...
					    'Callback', 'BRAPH2.license()')
					uimenu(menu_about, ...
					    'Tag', 'MENU.About.Credits', ...
					    'Label', 'Credits ...', ...
					    'Callback', 'BRAPH2.credits()')
					
					value = menu_about;
					
				case 19 % GUI.H_TOOLBAR
					value = uitoolbar(gui.memorize('H'), 'Tag', 'TOOLBAR');
					
				case 20 % GUI.H_TOOLS
					toolbar = gui.memorize('H_TOOLBAR');
					
					value = {};
					
					if gui.get('TOOL_ABOUT')
					    tool_spacer_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % Website
					    tool_about_web = uipushtool(toolbar, ...
					        'Tag', 'BRAPH2.Web', ...                
					        'Separator', 'on', ...
					        'Tooltip', 'Link to braph.org', ...
					        'CData', imread('icon_web.png'), ...
					        'ClickedCallback', 'BRAPH2.web()');
					
					    % Forum
					    tool_about_forum = uipushtool(toolbar, ...
					        'Tag', 'BRAPH2.Forum', ...                
					        'Separator', 'off', ...
					        'Tooltip', 'Link to the BRAPH 2.0 forums', ...
					        'CData', imread('icon_forum.png'), ...
					        'ClickedCallback', 'BRAPH2.forum()');
					
					    % Bluesky
					    tool_about_bluesky = uipushtool(toolbar, ...
					        'Tag', 'BRAPH2.Bluesky', ...                
					        'Separator', 'off', ...
					        'Tooltip', 'Link to the BRAPH 2 Bluesky', ...
					        'CData', imread('icon_bluesky.png'), ...
					        'ClickedCallback', 'BRAPH2.bluesky()');
					
					    tool_spacer_2 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % License
					    tool_about_license = uipushtool(toolbar, ...
					        'Tag', 'BRAPH2.License', ...                
					        'Separator', 'on', ...
					        'Tooltip', 'BRAPH 2.0 License', ...
					        'CData', imread('icon_license.png'), ...
					        'ClickedCallback', 'BRAPH2.license()');
					
					    % Credits
					    tool_about_credits = uipushtool(toolbar, ...
					        'Tag', 'BRAPH2.Credits', ...                
					        'Separator', 'off', ...
					        'Tooltip', 'Informtion about BRAPH 2.0 and credits', ...
					        'CData', imread('icon_about.png'), ...
					        'ClickedCallback', 'BRAPH2.credits()');
					    
					    value = {value{:}, tool_spacer_1, tool_about_web, tool_about_forum, tool_about_bluesky, tool_spacer_2, tool_about_license, tool_about_credits};
					end
					
				case 24 % GUI.H
					f = uifigure( ...
					    'Visible', 'off', ...
					    'Tag', 'H', ...
					    'UserData', gui, ... % handle to retrieve gui
					    'Name', gui.get('TITLE'), ...
					    'Units', 'normalized', ...
					    'Position', gui.get('POSITION'), ...
					    'Color', gui.get('BKGCOLOR'), ...
					    'Icon', 'braph2icon.png', ...
					    'AutoResizeChildren', false, ...
					    'SizeChangedFcn', {@cb_get, 'RESIZE'}, ...
					    'DeleteFcn', {@cb_get, 'DELETE'}, ...
					    'CloseRequestFcn', {@cb_get, 'CLOSE'} ...
					    );
					value = f;
					
				case 25 % GUI.RESIZE
					if gui.get('DRAWN')
					    gui.set('POSITION', gui.get('H').get('Position'))
					    
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(gui)], ...
					        ['BRAPH2' ':' class(gui) '\n' ...
					        'The call gui.get(''RESIZE'') has NOT been executed.\n' ...
					        'First, the gui ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 26 % GUI.SHOW
					if gui.get('DRAWN')
					    figure(gui.get('H')) 
					    set(gui.get('H'), ...
					        'Visible', 'on', ...
					        'WindowState', 'normal' ...
					        )
					
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(gui)], ...
					        ['BRAPH2' ':' class(gui) '\n' ...
					        'The call gui.get(''SHOW'') has NOT been executed.\n' ...
					        'First, the gui ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 27 % GUI.HIDE
					if gui.get('DRAWN')
					    set(gui.get('H'), 'Visible', 'off')
					
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(gui)], ...
					        ['BRAPH2' ':' class(gui) '\n' ...
					        'The call gui.get(''HIDE'') has NOT been executed.\n' ...
					        'First, the gui ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 28 % GUI.DELETE
					if gui.get('DRAWN')
					    gui.set('POSITION', gui.get('H').get('Position'))
					
					    gui.set('H', Element.getNoValue())
					
					    gui.set('H_MENUBAR', Element.getNoValue())
					    gui.set('H_MENU_ABOUT', Element.getNoValue())
					
					    gui.set('H_TOOLBAR', Element.getNoValue())
					    gui.set('H_TOOLS', Element.getNoValue())
					    
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(gui)], ...
					        ['BRAPH2' ':' class(gui) '\n' ...
					        'The call gui.get(''DELETE'') has NOT been executed.\n' ...
					        'First, the gui ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 29 % GUI.CLOSE
					if gui.get('DRAWN')
					
					    title = gui.get('TITLE');
					
					    if gui.get('CLOSEREQ')
					        %TODO implement and use braph2msgbox instead of uiconfirm
					        selection = uiconfirm(gui.get('H'), ...
					            ['Do you want to close ' title '?'], ...
					            ['Close ' title], ...
					            'Options', {'Yes', 'No'}, ...
					            'DefaultOption', 2 ...
					            );
					    else
					        selection = 'Yes';
					    end
					
					    if strcmp(selection, 'Yes')
					        delete(gui.get('H'))
					    end
					
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(gui)], ...
					        ['BRAPH2' ':' class(gui) '\n' ...
					        'The call gui.get(''CLOSE'') has NOT been executed.\n' ...
					        'First, the gui ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(gui, prop, varargin{:});
					else
						value = calculateValue@Element(gui, prop, varargin{:});
					end
			end
			
			function cb_get(~, ~, varargin)
				gui.get(varargin{:})
			end
		end
	end
end
