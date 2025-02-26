classdef GUIElement < GUI
	%GUIElement is a GUI for an element.
	% It is a subclass of <a href="matlab:help GUI">GUI</a>.
	%
	% An Element GUI (GUIElement) renders an element in a figure.
	% 
	% CONSTRUCTOR - To construct a GUI use, e.g.:
	% 
	%     gui = GUIElement(''PE'', <element>)
	%     
	% DRAW - To create the element figure, use:
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
	% The list of GUIElement properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the element GUI.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the element GUI.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the element GUI.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the element GUI.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the element GUI.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the element GUI.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the element GUI.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the contents of a GUI before showing it.
	%  <strong>11</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the GUI has been drawn.
	%  <strong>12</strong> <strong>TITLE</strong> 	TITLE (gui, string) is the name of the GUI.
	%  <strong>13</strong> <strong>POSITION</strong> 	POSITION (gui, rvector) is the normalized position of the GUI on the screen.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (gui, color) is the GUI background color.
	%  <strong>15</strong> <strong>H_MENUBAR</strong> 	H_MENUBAR (evanescent, handlelist) is the list of handles for the menus.
	%  <strong>16</strong> <strong>MENUBAR</strong> 	MENUBAR (gui, logical) determines whether to show the menubar.
	%  <strong>17</strong> <strong>H_MENU_ABOUT</strong> 	H_MENU_ABOUT (evanescent, handle) is the handle of the menu about.
	%  <strong>18</strong> <strong>MENU_ABOUT</strong> 	MENU_ABOUT (gui, logical) determines whether to show the menu about.
	%  <strong>19</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) is the handle list of the toolbar.
	%  <strong>20</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the handle list of the toolbar followed by the tools from the first.
	%  <strong>21</strong> <strong>TOOLBAR</strong> 	TOOLBAR (gui, logical) determines whether to show the toolbar.
	%  <strong>22</strong> <strong>TOOL_ABOUT</strong> 	TOOL_ABOUT (gui, logical) determines whether to show the toolbar about buttons.
	%  <strong>23</strong> <strong>CLOSEREQ</strong> 	CLOSEREQ (gui, logical) determines whether to confirm close.
	%  <strong>24</strong> <strong>H</strong> 	H (evanescent, handle) is the figure handle.
	%  <strong>25</strong> <strong>RESIZE</strong> 	RESIZE (query, logical) updates prop POSITION and panel PanelElement when figure size is changed.
	%  <strong>26</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure and its dependent figures.
	%  <strong>27</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure and its dependent figures.
	%  <strong>28</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the figure is deleted.
	%  <strong>29</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure and its dependent figures.
	%  <strong>30</strong> <strong>PE</strong> 	PE (data, item) is the panel element.
	%  <strong>31</strong> <strong>FILE</strong> 	FILE (metadata, string) is the B2 file where the element is saved.
	%  <strong>32</strong> <strong>TEXT_FILE</strong> 	TEXT_FILE (evanescent, handle) is the label where the file name is shown.
	%  <strong>33</strong> <strong>LAYOUT</strong> 	LAYOUT (data, item) is the handle to the figure to manage layout.
	%  <strong>34</strong> <strong>H_MENU_FILE</strong> 	H_MENU_FILE (evanescent, handle) is the handle of the menu file.
	%  <strong>35</strong> <strong>MENU_FILE</strong> 	MENU_FILE (gui, logical) determines whether to show the menu file.
	%  <strong>36</strong> <strong>H_MENU_IMPORT</strong> 	H_MENU_IMPORT (evanescent, handle) is the handle of the menu import.
	%  <strong>37</strong> <strong>MENU_IMPORT</strong> 	MENU_IMPORT (gui, logical) determines whether to show the menu import.
	%  <strong>38</strong> <strong>H_MENU_EXPORT</strong> 	H_MENU_EXPORT (evanescent, handle) is the handle of the menu export.
	%  <strong>39</strong> <strong>MENU_EXPORT</strong> 	MENU_EXPORT (gui, logical) determines whether to show the menu export.
	%  <strong>40</strong> <strong>H_MENU_PERSONALIZE</strong> 	H_MENU_PERSONALIZE (evanescent, handle) is the handle of the menu personalize.
	%  <strong>41</strong> <strong>MENU_PERSONALIZE</strong> 	MENU_PERSONALIZE (gui, logical) determines whether to show the menu personalize.
	%  <strong>42</strong> <strong>TOOL_FILE</strong> 	TOOL_FILE (gui, logical) determines whether to show the toolbar file buttons.
	%
	% GUIElement methods (constructor):
	%  GUIElement - constructor
	%
	% GUIElement methods:
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
	% GUIElement methods (display):
	%  tostring - string with information about the element GUI
	%  disp - displays information about the element GUI
	%  tree - displays the tree of the element GUI
	%
	% GUIElement methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two element GUI are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the element GUI
	%
	% GUIElement methods (save/load, Static):
	%  save - saves BRAPH2 element GUI as b2 file
	%  load - loads a BRAPH2 element GUI from a b2 file
	%
	% GUIElement method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the element GUI
	%
	% GUIElement method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the element GUI
	%
	% GUIElement methods (inspection, Static):
	%  getClass - returns the class of the element GUI
	%  getSubclasses - returns all subclasses of GUIElement
	%  getProps - returns the property list of the element GUI
	%  getPropNumber - returns the property number of the element GUI
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
	% GUIElement methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GUIElement methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GUIElement methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GUIElement methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GUIElement; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GUIElement constants</a>.
	%
	%
	% See also uifigure, ConcreteElement, PanelElement.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		PE = 30; %CET: Computational Efficiency Trick
		PE_TAG = 'PE';
		PE_CATEGORY = 4;
		PE_FORMAT = 8;
		
		FILE = 31; %CET: Computational Efficiency Trick
		FILE_TAG = 'FILE';
		FILE_CATEGORY = 2;
		FILE_FORMAT = 2;
		
		TEXT_FILE = 32; %CET: Computational Efficiency Trick
		TEXT_FILE_TAG = 'TEXT_FILE';
		TEXT_FILE_CATEGORY = 7;
		TEXT_FILE_FORMAT = 18;
		
		LAYOUT = 33; %CET: Computational Efficiency Trick
		LAYOUT_TAG = 'LAYOUT';
		LAYOUT_CATEGORY = 4;
		LAYOUT_FORMAT = 8;
		
		H_MENU_FILE = 34; %CET: Computational Efficiency Trick
		H_MENU_FILE_TAG = 'H_MENU_FILE';
		H_MENU_FILE_CATEGORY = 7;
		H_MENU_FILE_FORMAT = 18;
		
		MENU_FILE = 35; %CET: Computational Efficiency Trick
		MENU_FILE_TAG = 'MENU_FILE';
		MENU_FILE_CATEGORY = 9;
		MENU_FILE_FORMAT = 4;
		
		H_MENU_IMPORT = 36; %CET: Computational Efficiency Trick
		H_MENU_IMPORT_TAG = 'H_MENU_IMPORT';
		H_MENU_IMPORT_CATEGORY = 7;
		H_MENU_IMPORT_FORMAT = 18;
		
		MENU_IMPORT = 37; %CET: Computational Efficiency Trick
		MENU_IMPORT_TAG = 'MENU_IMPORT';
		MENU_IMPORT_CATEGORY = 9;
		MENU_IMPORT_FORMAT = 4;
		
		H_MENU_EXPORT = 38; %CET: Computational Efficiency Trick
		H_MENU_EXPORT_TAG = 'H_MENU_EXPORT';
		H_MENU_EXPORT_CATEGORY = 7;
		H_MENU_EXPORT_FORMAT = 18;
		
		MENU_EXPORT = 39; %CET: Computational Efficiency Trick
		MENU_EXPORT_TAG = 'MENU_EXPORT';
		MENU_EXPORT_CATEGORY = 9;
		MENU_EXPORT_FORMAT = 4;
		
		H_MENU_PERSONALIZE = 40; %CET: Computational Efficiency Trick
		H_MENU_PERSONALIZE_TAG = 'H_MENU_PERSONALIZE';
		H_MENU_PERSONALIZE_CATEGORY = 7;
		H_MENU_PERSONALIZE_FORMAT = 18;
		
		MENU_PERSONALIZE = 41; %CET: Computational Efficiency Trick
		MENU_PERSONALIZE_TAG = 'MENU_PERSONALIZE';
		MENU_PERSONALIZE_CATEGORY = 9;
		MENU_PERSONALIZE_FORMAT = 4;
		
		TOOL_FILE = 42; %CET: Computational Efficiency Trick
		TOOL_FILE_TAG = 'TOOL_FILE';
		TOOL_FILE_CATEGORY = 9;
		TOOL_FILE_FORMAT = 4;
	end
	methods % constructor
		function gui = GUIElement(varargin)
			%GUIElement() creates a element GUI.
			%
			% GUIElement(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GUIElement(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GUIElement properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the element GUI.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the element GUI.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the element GUI.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the element GUI.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the element GUI.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the element GUI.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the element GUI.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the contents of a GUI before showing it.
			%  <strong>11</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the GUI has been drawn.
			%  <strong>12</strong> <strong>TITLE</strong> 	TITLE (gui, string) is the name of the GUI.
			%  <strong>13</strong> <strong>POSITION</strong> 	POSITION (gui, rvector) is the normalized position of the GUI on the screen.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (gui, color) is the GUI background color.
			%  <strong>15</strong> <strong>H_MENUBAR</strong> 	H_MENUBAR (evanescent, handlelist) is the list of handles for the menus.
			%  <strong>16</strong> <strong>MENUBAR</strong> 	MENUBAR (gui, logical) determines whether to show the menubar.
			%  <strong>17</strong> <strong>H_MENU_ABOUT</strong> 	H_MENU_ABOUT (evanescent, handle) is the handle of the menu about.
			%  <strong>18</strong> <strong>MENU_ABOUT</strong> 	MENU_ABOUT (gui, logical) determines whether to show the menu about.
			%  <strong>19</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) is the handle list of the toolbar.
			%  <strong>20</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the handle list of the toolbar followed by the tools from the first.
			%  <strong>21</strong> <strong>TOOLBAR</strong> 	TOOLBAR (gui, logical) determines whether to show the toolbar.
			%  <strong>22</strong> <strong>TOOL_ABOUT</strong> 	TOOL_ABOUT (gui, logical) determines whether to show the toolbar about buttons.
			%  <strong>23</strong> <strong>CLOSEREQ</strong> 	CLOSEREQ (gui, logical) determines whether to confirm close.
			%  <strong>24</strong> <strong>H</strong> 	H (evanescent, handle) is the figure handle.
			%  <strong>25</strong> <strong>RESIZE</strong> 	RESIZE (query, logical) updates prop POSITION and panel PanelElement when figure size is changed.
			%  <strong>26</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure and its dependent figures.
			%  <strong>27</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure and its dependent figures.
			%  <strong>28</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the figure is deleted.
			%  <strong>29</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure and its dependent figures.
			%  <strong>30</strong> <strong>PE</strong> 	PE (data, item) is the panel element.
			%  <strong>31</strong> <strong>FILE</strong> 	FILE (metadata, string) is the B2 file where the element is saved.
			%  <strong>32</strong> <strong>TEXT_FILE</strong> 	TEXT_FILE (evanescent, handle) is the label where the file name is shown.
			%  <strong>33</strong> <strong>LAYOUT</strong> 	LAYOUT (data, item) is the handle to the figure to manage layout.
			%  <strong>34</strong> <strong>H_MENU_FILE</strong> 	H_MENU_FILE (evanescent, handle) is the handle of the menu file.
			%  <strong>35</strong> <strong>MENU_FILE</strong> 	MENU_FILE (gui, logical) determines whether to show the menu file.
			%  <strong>36</strong> <strong>H_MENU_IMPORT</strong> 	H_MENU_IMPORT (evanescent, handle) is the handle of the menu import.
			%  <strong>37</strong> <strong>MENU_IMPORT</strong> 	MENU_IMPORT (gui, logical) determines whether to show the menu import.
			%  <strong>38</strong> <strong>H_MENU_EXPORT</strong> 	H_MENU_EXPORT (evanescent, handle) is the handle of the menu export.
			%  <strong>39</strong> <strong>MENU_EXPORT</strong> 	MENU_EXPORT (gui, logical) determines whether to show the menu export.
			%  <strong>40</strong> <strong>H_MENU_PERSONALIZE</strong> 	H_MENU_PERSONALIZE (evanescent, handle) is the handle of the menu personalize.
			%  <strong>41</strong> <strong>MENU_PERSONALIZE</strong> 	MENU_PERSONALIZE (gui, logical) determines whether to show the menu personalize.
			%  <strong>42</strong> <strong>TOOL_FILE</strong> 	TOOL_FILE (gui, logical) determines whether to show the toolbar file buttons.
			%
			% See also Category, Format.
			
			gui = gui@GUI(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the element GUI.
			%
			% BUILD = GUIElement.GETBUILD() returns the build of 'GUIElement'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GUI.GETBUILD() returns the build of the element GUI GUI.
			%  BUILD = Element.GETBUILD(GUI) returns the build of 'GUI'.
			%  BUILD = Element.GETBUILD('GUIElement') returns the build of 'GUIElement'.
			%
			% Note that the Element.GETBUILD(GUI) and Element.GETBUILD('GUIElement')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gui_class = getClass()
			%GETCLASS returns the class of the element GUI.
			%
			% CLASS = GUIElement.GETCLASS() returns the class 'GUIElement'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GUI.GETCLASS() returns the class of the element GUI GUI.
			%  CLASS = Element.GETCLASS(GUI) returns the class of 'GUI'.
			%  CLASS = Element.GETCLASS('GUIElement') returns 'GUIElement'.
			%
			% Note that the Element.GETCLASS(GUI) and Element.GETCLASS('GUIElement')
			%  are less computationally efficient.
			
			gui_class = 'GUIElement';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the element GUI.
			%
			% LIST = GUIElement.GETSUBCLASSES() returns all subclasses of 'GUIElement'.
			%
			% Alternative forms to call this method are:
			%  LIST = GUI.GETSUBCLASSES() returns all subclasses of the element GUI GUI.
			%  LIST = Element.GETSUBCLASSES(GUI) returns all subclasses of 'GUI'.
			%  LIST = Element.GETSUBCLASSES('GUIElement') returns all subclasses of 'GUIElement'.
			%
			% Note that the Element.GETSUBCLASSES(GUI) and Element.GETSUBCLASSES('GUIElement')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GUIElement' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of element GUI.
			%
			% PROPS = GUIElement.GETPROPS() returns the property list of element GUI
			%  as a row vector.
			%
			% PROPS = GUIElement.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GUI.GETPROPS([CATEGORY]) returns the property list of the element GUI GUI.
			%  PROPS = Element.GETPROPS(GUI[, CATEGORY]) returns the property list of 'GUI'.
			%  PROPS = Element.GETPROPS('GUIElement'[, CATEGORY]) returns the property list of 'GUIElement'.
			%
			% Note that the Element.GETPROPS(GUI) and Element.GETPROPS('GUIElement')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 31];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 30 33];
				case 6 % Category.QUERY
					prop_list = [8 10 11 25 26 27 28 29];
				case 7 % Category.EVANESCENT
					prop_list = [15 17 19 20 24 32 34 36 38 40];
				case 9 % Category.GUI
					prop_list = [9 12 13 14 16 18 21 22 23 35 37 39 41 42];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of element GUI.
			%
			% N = GUIElement.GETPROPNUMBER() returns the property number of element GUI.
			%
			% N = GUIElement.GETPROPNUMBER(CATEGORY) returns the property number of element GUI
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GUI.GETPROPNUMBER([CATEGORY]) returns the property number of the element GUI GUI.
			%  N = Element.GETPROPNUMBER(GUI) returns the property number of 'GUI'.
			%  N = Element.GETPROPNUMBER('GUIElement') returns the property number of 'GUIElement'.
			%
			% Note that the Element.GETPROPNUMBER(GUI) and Element.GETPROPNUMBER('GUIElement')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 42;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 3;
				case 6 % Category.QUERY
					prop_number = 8;
				case 7 % Category.EVANESCENT
					prop_number = 10;
				case 9 % Category.GUI
					prop_number = 14;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in element GUI/error.
			%
			% CHECK = GUIElement.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GUI.EXISTSPROP(PROP) checks whether PROP exists for GUI.
			%  CHECK = Element.EXISTSPROP(GUI, PROP) checks whether PROP exists for GUI.
			%  CHECK = Element.EXISTSPROP(GUIElement, PROP) checks whether PROP exists for GUIElement.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GUIElement:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GUI.EXISTSPROP(PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUIElement:WrongInput]
			%  Element.EXISTSPROP(GUI, PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUIElement:WrongInput]
			%  Element.EXISTSPROP(GUIElement, PROP) throws error if PROP does NOT exist for GUIElement.
			%   Error id: [BRAPH2:GUIElement:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GUI) and Element.EXISTSPROP('GUIElement')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 42 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GUIElement:' 'WrongInput'], ...
					['BRAPH2' ':GUIElement:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GUIElement.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in element GUI/error.
			%
			% CHECK = GUIElement.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GUI.EXISTSTAG(TAG) checks whether TAG exists for GUI.
			%  CHECK = Element.EXISTSTAG(GUI, TAG) checks whether TAG exists for GUI.
			%  CHECK = Element.EXISTSTAG(GUIElement, TAG) checks whether TAG exists for GUIElement.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GUIElement:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GUI.EXISTSTAG(TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUIElement:WrongInput]
			%  Element.EXISTSTAG(GUI, TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUIElement:WrongInput]
			%  Element.EXISTSTAG(GUIElement, TAG) throws error if TAG does NOT exist for GUIElement.
			%   Error id: [BRAPH2:GUIElement:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GUI) and Element.EXISTSTAG('GUIElement')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DRAW'  'DRAWN'  'TITLE'  'POSITION'  'BKGCOLOR'  'H_MENUBAR'  'MENUBAR'  'H_MENU_ABOUT'  'MENU_ABOUT'  'H_TOOLBAR'  'H_TOOLS'  'TOOLBAR'  'TOOL_ABOUT'  'CLOSEREQ'  'H'  'RESIZE'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'PE'  'FILE'  'TEXT_FILE'  'LAYOUT'  'H_MENU_FILE'  'MENU_FILE'  'H_MENU_IMPORT'  'MENU_IMPORT'  'H_MENU_EXPORT'  'MENU_EXPORT'  'H_MENU_PERSONALIZE'  'MENU_PERSONALIZE'  'TOOL_FILE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GUIElement:' 'WrongInput'], ...
					['BRAPH2' ':GUIElement:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GUIElement.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GUIElement, POINTER) returns property number of POINTER of GUIElement.
			%  PROPERTY = GUI.GETPROPPROP(GUIElement, POINTER) returns property number of POINTER of GUIElement.
			%
			% Note that the Element.GETPROPPROP(GUI) and Element.GETPROPPROP('GUIElement')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DRAW'  'DRAWN'  'TITLE'  'POSITION'  'BKGCOLOR'  'H_MENUBAR'  'MENUBAR'  'H_MENU_ABOUT'  'MENU_ABOUT'  'H_TOOLBAR'  'H_TOOLS'  'TOOLBAR'  'TOOL_ABOUT'  'CLOSEREQ'  'H'  'RESIZE'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'PE'  'FILE'  'TEXT_FILE'  'LAYOUT'  'H_MENU_FILE'  'MENU_FILE'  'H_MENU_IMPORT'  'MENU_IMPORT'  'H_MENU_EXPORT'  'MENU_EXPORT'  'H_MENU_PERSONALIZE'  'MENU_PERSONALIZE'  'TOOL_FILE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(GUIElement, POINTER) returns tag of POINTER of GUIElement.
			%  TAG = GUI.GETPROPTAG(GUIElement, POINTER) returns tag of POINTER of GUIElement.
			%
			% Note that the Element.GETPROPTAG(GUI) and Element.GETPROPTAG('GUIElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				guielement_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DRAW'  'DRAWN'  'TITLE'  'POSITION'  'BKGCOLOR'  'H_MENUBAR'  'MENUBAR'  'H_MENU_ABOUT'  'MENU_ABOUT'  'H_TOOLBAR'  'H_TOOLS'  'TOOLBAR'  'TOOL_ABOUT'  'CLOSEREQ'  'H'  'RESIZE'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'PE'  'FILE'  'TEXT_FILE'  'LAYOUT'  'H_MENU_FILE'  'MENU_FILE'  'H_MENU_IMPORT'  'MENU_IMPORT'  'H_MENU_EXPORT'  'MENU_EXPORT'  'H_MENU_PERSONALIZE'  'MENU_PERSONALIZE'  'TOOL_FILE' };
				tag = guielement_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(GUIElement, POINTER) returns category of POINTER of GUIElement.
			%  CATEGORY = GUI.GETPROPCATEGORY(GUIElement, POINTER) returns category of POINTER of GUIElement.
			%
			% Note that the Element.GETPROPCATEGORY(GUI) and Element.GETPROPCATEGORY('GUIElement')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GUIElement.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			guielement_category_list = { 1  1  1  3  4  2  2  6  9  6  6  9  9  9  7  9  7  9  7  7  9  9  9  7  6  6  6  6  6  4  2  7  4  7  9  7  9  7  9  7  9  9 };
			prop_category = guielement_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(GUIElement, POINTER) returns format of POINTER of GUIElement.
			%  FORMAT = GUI.GETPROPFORMAT(GUIElement, POINTER) returns format of POINTER of GUIElement.
			%
			% Note that the Element.GETPROPFORMAT(GUI) and Element.GETPROPFORMAT('GUIElement')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GUIElement.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			guielement_format_list = { 2  2  2  8  2  2  2  2  4  4  4  2  12  20  19  4  18  4  18  19  4  4  4  18  4  4  4  4  4  8  2  18  8  18  4  18  4  18  4  18  4  4 };
			prop_format = guielement_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GUIElement, POINTER) returns description of POINTER of GUIElement.
			%  DESCRIPTION = GUI.GETPROPDESCRIPTION(GUIElement, POINTER) returns description of POINTER of GUIElement.
			%
			% Note that the Element.GETPROPDESCRIPTION(GUI) and Element.GETPROPDESCRIPTION('GUIElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GUIElement.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			guielement_description_list = { 'ELCLASS (constant, string) is the class of the element GUI.'  'NAME (constant, string) is the name of the element GUI.'  'DESCRIPTION (constant, string) is the description of the element GUI.'  'TEMPLATE (parameter, item) is the template of the element GUI.'  'ID (data, string) is a few-letter code for the element GUI.'  'LABEL (metadata, string) is an extended label of the element GUI.'  'NOTES (metadata, string) are some specific notes about the element GUI.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'DRAW (query, logical) draws the contents of a GUI before showing it.'  'DRAWN (query, logical) returns whether the GUI has been drawn.'  'TITLE (gui, string) is the name of the GUI.'  'POSITION (gui, rvector) is the normalized position of the GUI on the screen.'  'BKGCOLOR (gui, color) is the GUI background color.'  'H_MENUBAR (evanescent, handlelist) is the list of handles for the menus.'  'MENUBAR (gui, logical) determines whether to show the menubar.'  'H_MENU_ABOUT (evanescent, handle) is the handle of the menu about.'  'MENU_ABOUT (gui, logical) determines whether to show the menu about.'  'H_TOOLBAR (evanescent, handle) is the handle list of the toolbar.'  'H_TOOLS (evanescent, handlelist) is the handle list of the toolbar followed by the tools from the first.'  'TOOLBAR (gui, logical) determines whether to show the toolbar.'  'TOOL_ABOUT (gui, logical) determines whether to show the toolbar about buttons.'  'CLOSEREQ (gui, logical) determines whether to confirm close.'  'H (evanescent, handle) is the figure handle.'  'RESIZE (query, logical) updates prop POSITION and panel PanelElement when figure size is changed.'  'SHOW (query, logical) shows the figure and its dependent figures.'  'HIDE (query, logical) hides the figure and its dependent figures.'  'DELETE (query, logical) resets the handles when the figure is deleted.'  'CLOSE (query, logical) closes the figure and its dependent figures.'  'PE (data, item) is the panel element.'  'FILE (metadata, string) is the B2 file where the element is saved.'  'TEXT_FILE (evanescent, handle) is the label where the file name is shown.'  'LAYOUT (data, item) is the handle to the figure to manage layout.'  'H_MENU_FILE (evanescent, handle) is the handle of the menu file.'  'MENU_FILE (gui, logical) determines whether to show the menu file.'  'H_MENU_IMPORT (evanescent, handle) is the handle of the menu import.'  'MENU_IMPORT (gui, logical) determines whether to show the menu import.'  'H_MENU_EXPORT (evanescent, handle) is the handle of the menu export.'  'MENU_EXPORT (gui, logical) determines whether to show the menu export.'  'H_MENU_PERSONALIZE (evanescent, handle) is the handle of the menu personalize.'  'MENU_PERSONALIZE (gui, logical) determines whether to show the menu personalize.'  'TOOL_FILE (gui, logical) determines whether to show the toolbar file buttons.' };
			prop_description = guielement_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(GUIElement, POINTER) returns settings of POINTER of GUIElement.
			%  SETTINGS = GUI.GETPROPSETTINGS(GUIElement, POINTER) returns settings of POINTER of GUIElement.
			%
			% Note that the Element.GETPROPSETTINGS(GUI) and Element.GETPROPSETTINGS('GUIElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GUIElement.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 30 % GUIElement.PE
					prop_settings = 'PanelElement';
				case 31 % GUIElement.FILE
					prop_settings = Format.getFormatSettings(2);
				case 32 % GUIElement.TEXT_FILE
					prop_settings = Format.getFormatSettings(18);
				case 33 % GUIElement.LAYOUT
					prop_settings = 'GUILayout';
				case 34 % GUIElement.H_MENU_FILE
					prop_settings = Format.getFormatSettings(18);
				case 35 % GUIElement.MENU_FILE
					prop_settings = Format.getFormatSettings(4);
				case 36 % GUIElement.H_MENU_IMPORT
					prop_settings = Format.getFormatSettings(18);
				case 37 % GUIElement.MENU_IMPORT
					prop_settings = Format.getFormatSettings(4);
				case 38 % GUIElement.H_MENU_EXPORT
					prop_settings = Format.getFormatSettings(18);
				case 39 % GUIElement.MENU_EXPORT
					prop_settings = Format.getFormatSettings(4);
				case 40 % GUIElement.H_MENU_PERSONALIZE
					prop_settings = Format.getFormatSettings(18);
				case 41 % GUIElement.MENU_PERSONALIZE
					prop_settings = Format.getFormatSettings(4);
				case 42 % GUIElement.TOOL_FILE
					prop_settings = Format.getFormatSettings(4);
				case 4 % GUIElement.TEMPLATE
					prop_settings = 'GUIElement';
				otherwise
					prop_settings = getPropSettings@GUI(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GUIElement.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GUIElement.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GUI.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GUI.
			%  DEFAULT = Element.GETPROPDEFAULT(GUIElement, POINTER) returns the default value of POINTER of GUIElement.
			%  DEFAULT = GUI.GETPROPDEFAULT(GUIElement, POINTER) returns the default value of POINTER of GUIElement.
			%
			% Note that the Element.GETPROPDEFAULT(GUI) and Element.GETPROPDEFAULT('GUIElement')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GUIElement.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 30 % GUIElement.PE
					prop_default = Format.getFormatDefault(8, GUIElement.getPropSettings(prop));
				case 31 % GUIElement.FILE
					prop_default = Format.getFormatDefault(2, GUIElement.getPropSettings(prop));
				case 32 % GUIElement.TEXT_FILE
					prop_default = Format.getFormatDefault(18, GUIElement.getPropSettings(prop));
				case 33 % GUIElement.LAYOUT
					prop_default = Format.getFormatDefault(8, GUIElement.getPropSettings(prop));
				case 34 % GUIElement.H_MENU_FILE
					prop_default = Format.getFormatDefault(18, GUIElement.getPropSettings(prop));
				case 35 % GUIElement.MENU_FILE
					prop_default = true;
				case 36 % GUIElement.H_MENU_IMPORT
					prop_default = Format.getFormatDefault(18, GUIElement.getPropSettings(prop));
				case 37 % GUIElement.MENU_IMPORT
					prop_default = true;
				case 38 % GUIElement.H_MENU_EXPORT
					prop_default = Format.getFormatDefault(18, GUIElement.getPropSettings(prop));
				case 39 % GUIElement.MENU_EXPORT
					prop_default = true;
				case 40 % GUIElement.H_MENU_PERSONALIZE
					prop_default = Format.getFormatDefault(18, GUIElement.getPropSettings(prop));
				case 41 % GUIElement.MENU_PERSONALIZE
					prop_default = true;
				case 42 % GUIElement.TOOL_FILE
					prop_default = true;
				case 1 % GUIElement.ELCLASS
					prop_default = 'GUIElement';
				case 2 % GUIElement.NAME
					prop_default = 'Element GUI';
				case 3 % GUIElement.DESCRIPTION
					prop_default = 'An Element GUI (GUIElement) renders an element in a figure.';
				case 4 % GUIElement.TEMPLATE
					prop_default = Format.getFormatDefault(8, GUIElement.getPropSettings(prop));
				case 5 % GUIElement.ID
					prop_default = 'GUIElement ID';
				case 6 % GUIElement.LABEL
					prop_default = 'GUIElement label';
				case 7 % GUIElement.NOTES
					prop_default = 'GUIElement notes';
				case 16 % GUIElement.MENUBAR
					prop_default = true;
				case 18 % GUIElement.MENU_ABOUT
					prop_default = true;
				case 21 % GUIElement.TOOLBAR
					prop_default = true;
				case 22 % GUIElement.TOOL_ABOUT
					prop_default = true;
				otherwise
					prop_default = getPropDefault@GUI(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GUIElement.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GUIElement.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GUI.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GUIElement, POINTER) returns the conditioned default value of POINTER of GUIElement.
			%  DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(GUIElement, POINTER) returns the conditioned default value of POINTER of GUIElement.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GUI) and Element.GETPROPDEFAULTCONDITIONED('GUIElement')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GUIElement.getPropProp(pointer);
			
			prop_default = GUIElement.conditioning(prop, GUIElement.getPropDefault(prop));
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
			
			prop = GUIElement.getPropProp(pointer);
			
			switch prop
				case 30 % GUIElement.PE
					if ~isa(value, 'PanelElement')
					    value = PanelElement( ...
					        'EL', value, ...
					        'ID', ['Panel of ' value.get('TOSTRING')] ...
					        );
					end
					
				otherwise
					if prop <= 29
						value = conditioning@GUI(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % preset
		function value = preset(gui, prop, value)
			%PRESET preprocesses the value of a property before setting it.
			%
			% VALUE = PRESET(EL, PROP, VALUE) prepropcesses the VALUE of the property
			%  PROP. It works only with properties with 2,
			%  3, 4, 8 and 9. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% See also conditioning, checkProp, postset, postprocessing,
			%  calculateValue, checkValue.
			
			switch prop
				case 33 % GUIElement.LAYOUT
					if isa(value.getr('EL_CLASS'), 'NoValue')
					    f = gui.get('H');
					    value.set( ...
					        'EL_CLASS', gui.get('PE').get('EL'), ...
					        'POSITION', [x0(f)+w(f) y0(f)+h(f)*2/3 w(f) h(f)/3], ...
					        'CLOSEREQ', false ...
					        )
					end
					
				otherwise
					if prop <= 29
						value = preset@GUI(gui, prop, value);
					end
			end
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
			%  CHECK = Element.CHECKPROP(GUIElement, PROP, VALUE) checks VALUE format for PROP of GUIElement.
			%  CHECK = GUI.CHECKPROP(GUIElement, PROP, VALUE) checks VALUE format for PROP of GUIElement.
			% 
			% GUI.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GUIElement:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GUI.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GUI.
			%   Error id: BRAPH2:GUIElement:WrongInput
			%  Element.CHECKPROP(GUIElement, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GUIElement.
			%   Error id: BRAPH2:GUIElement:WrongInput
			%  GUI.CHECKPROP(GUIElement, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GUIElement.
			%   Error id: BRAPH2:GUIElement:WrongInput]
			% 
			% Note that the Element.CHECKPROP(GUI) and Element.CHECKPROP('GUIElement')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GUIElement.getPropProp(pointer);
			
			switch prop
				case 30 % GUIElement.PE
					check = Format.checkFormat(8, value, GUIElement.getPropSettings(prop));
				case 31 % GUIElement.FILE
					check = Format.checkFormat(2, value, GUIElement.getPropSettings(prop));
				case 32 % GUIElement.TEXT_FILE
					check = Format.checkFormat(18, value, GUIElement.getPropSettings(prop));
				case 33 % GUIElement.LAYOUT
					check = Format.checkFormat(8, value, GUIElement.getPropSettings(prop));
				case 34 % GUIElement.H_MENU_FILE
					check = Format.checkFormat(18, value, GUIElement.getPropSettings(prop));
				case 35 % GUIElement.MENU_FILE
					check = Format.checkFormat(4, value, GUIElement.getPropSettings(prop));
				case 36 % GUIElement.H_MENU_IMPORT
					check = Format.checkFormat(18, value, GUIElement.getPropSettings(prop));
				case 37 % GUIElement.MENU_IMPORT
					check = Format.checkFormat(4, value, GUIElement.getPropSettings(prop));
				case 38 % GUIElement.H_MENU_EXPORT
					check = Format.checkFormat(18, value, GUIElement.getPropSettings(prop));
				case 39 % GUIElement.MENU_EXPORT
					check = Format.checkFormat(4, value, GUIElement.getPropSettings(prop));
				case 40 % GUIElement.H_MENU_PERSONALIZE
					check = Format.checkFormat(18, value, GUIElement.getPropSettings(prop));
				case 41 % GUIElement.MENU_PERSONALIZE
					check = Format.checkFormat(4, value, GUIElement.getPropSettings(prop));
				case 42 % GUIElement.TOOL_FILE
					check = Format.checkFormat(4, value, GUIElement.getPropSettings(prop));
				case 4 % GUIElement.TEMPLATE
					check = Format.checkFormat(8, value, GUIElement.getPropSettings(prop));
				otherwise
					if prop <= 29
						check = checkProp@GUI(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GUIElement:' 'WrongInput'], ...
					['BRAPH2' ':GUIElement:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GUIElement.getPropTag(prop) ' (' GUIElement.getFormatTag(GUIElement.getPropFormat(prop)) ').'] ...
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
				case 30 % GUIElement.PE
					pe = gui.get('PE');
					pe.set('PARENT', gui)
					if isa(gui.getr('TITLE'), 'NoValue')
					    el = pe.get('EL');
					    gui.set('TITLE', [el.getClass() ' - ' el.get('ID') ' - ' 'BRAPH2'])
					end
					gui.lock('PE', 'Iterative', false)
					
					if isa(pe.getr('WAITBAR'), 'NoValue')
						pe.set('WAITBAR', gui.getCallback('WAITBAR'))
					end
					
				case 31 % GUIElement.FILE
					if gui.get('DRAWN')
					    set(gui.get('TEXT_FILE'), ...
					        'Text', gui.get('FILE'), ...
					        'Tooltip', gui.get('FILE') ...
					        )
					end
					
				otherwise
					if prop <= 29
						postset@GUI(gui, prop);
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
				case 32 % GUIElement.TEXT_FILE
					text_file = uilabel( ...
					    'Parent', gui.memorize('H'), ... % H = p for Panel
					    'Tag', 'TEXT_FILE', ...    
					    'Text', gui.get('FILE'), ...
					    'FontSize', 12, ...
					    'Tooltip', gui.get('FILE'), ...
					    'HorizontalAlignment', 'left', ...
					    'Position', [5 0 w(gui.get('H'), 'pixels')-10 24] ...
					    );
					value = text_file;
					
				case 34 % GUIElement.H_MENU_FILE
					menu_file = uimenu(gui.memorize('H'), ... % f for figure
					    'Tag', 'MENU.File', ...
					    'Label', 'File' ...
					    );
					
					uimenu(menu_file, ...
					    'Tag', 'MENU.File.Open', ...
					    'Label', 'Open ...', ...
					    'Accelerator', 'O', ...
					    'Callback', {@cb_open})
					uimenu(menu_file, ...
					    'Tag', 'MENU.File.Save', ...
					    'Label', 'Save', ...
					    'Accelerator', 'S', ...
					    'Callback', {@cb_save})
					uimenu(menu_file, ...
					    'Tag', 'MENU.File.Saveas', ...
					    'Label', 'Save as ...', ...
					    'Accelerator', 'A', ...
					    'Callback', {@cb_saveas})
					uimenu(menu_file, ...
					    'Separator', 'on', ...
					    'Tag', 'MENU.File.Close', ...
					    'Label', 'Quit', ...
					    'Accelerator', 'Q', ...
					    'Callback', {@cb_get, 'CLOSE'})
					
					value = menu_file;
					
				case 36 % GUIElement.H_MENU_IMPORT
					menu_import = uimenu(gui.memorize('H'), ... % f for figure
					    'Tag', 'MENU.Import', ...
					    'Label', 'Import', ...
					    'Callback', {@cb_refresh_import_menu});
					value = menu_import;
					
				case 38 % GUIElement.H_MENU_EXPORT
					menu_export = uimenu(gui.memorize('H'), ... % f for figure
					    'Tag', 'MENU.Export', ...
						'Label', 'Export', ...
						'Callback', {@cb_refresh_export_menu});
					value = menu_export;
					
				case 40 % GUIElement.H_MENU_PERSONALIZE
					menu_file = uimenu(gui.memorize('H'), ... % f for figure
					    'Tag', 'MENU.Personalize', ...
					    'Label', 'Personalize' ...
					    );
					
					uimenu(menu_file, ...
					    'Tag', 'MENU.Personalize.Layout', ...
					    'Label', 'Layout ...', ...
					    'Callback', {@cb_layout})
					
					value = menu_file;
					
				case 15 % GUIElement.H_MENUBAR
					value = {};
					if gui.get('MENU_FILE')
					    value = [value, gui.memorize('H_MENU_FILE')];
					end
					if gui.get('MENU_IMPORT')
					    value = [value, gui.memorize('H_MENU_IMPORT')];
					end
					if gui.get('MENU_EXPORT')
					    value = [value, gui.memorize('H_MENU_EXPORT')];
					end
					if gui.get('MENU_PERSONALIZE')
					    value = [value, gui.memorize('H_MENU_PERSONALIZE')];
					end
					if gui.get('MENU_ABOUT')
					    value = [value, gui.memorize('H_MENU_ABOUT')];
					end
					
				case 20 % GUIElement.H_TOOLS
					toolbar = gui.memorize('H_TOOLBAR');
					
					children = calculateValue@GUI(gui, 20);
					
					value = {};
					if gui.get('TOOL_FILE')
					    
					    el = gui.get('PE').get('EL');
					    
					    % OPEN
					    tool_file_open = uipushtool(toolbar, ...
					        'Tag', 'TOOL.Open', ...                
					        'Tooltip', ['Open ' el.get('NAME')], ...
					        'CData', imread('icon_open_ml.png'), ...
					        'ClickedCallback', {@cb_open});
					
					    % Save
					    tool_file_save = uipushtool(toolbar, ...
					        'Tag', 'TOOL.Save', ...                
					        'Tooltip', ['Save ' el.get('NAME')], ...
					        'CData', imread('icon_save_ml.png'), ...
					        'ClickedCallback', {@cb_save});
					    
					    value = {value{:}, tool_file_open, tool_file_save};
					end
					
					value = {value{:}, children{:}};
					
					% reorder tools
					toolbar.Children = [value{end:-1:1}];
					
				case 10 % GUIElement.DRAW
					if check_graphics(gui.memorize('H'), 'figure')
					
					    if gui.get('MENUBAR')
					        gui.memorize('H_MENUBAR')
					    end
					    
					    if gui.get('TOOLBAR')
					        % gui.memorize('H_TOOLBAR') % performed automatically by gui.memorize('H_TOOLS')
					        gui.memorize('H_TOOLS')
					    end
					    
					    pe = gui.memorize('PE');
					    pe.get('DRAW')
					    pe.get('RESIZEY')
					    
					    gui.memorize('TEXT_FILE')
					    
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
					
				case 25 % GUIElement.RESIZE
					value = calculateValue@GUI(gui, 25, varargin{:}); % also warning
					if value
					    gui.get('PE').get('RESIZEX')
					
					    set(gui.get('TEXT_FILE'), 'Position', [5 0 w(gui.get('H'), 'pixels')-10 24])
					end
					
				case 24 % GUIElement.H
					f = calculateValue@GUI(gui, 24);
					el = gui.memorize('PE').memorize('EL');
					value = f;
					
				case 26 % GUIElement.SHOW
					if gui.get('DRAWN')
					
					    % panel element
					    gui.get('PE').get('SHOW', 'ShowParentFigure', false)
					
					    % figure layout editor
					    if isa(gui.getr('LAYOUT'), 'GUILayout') && gui.get('LAYOUT').get('DRAWN')
					        gui.get('LAYOUT').get('SHOW')
					    end
					    
					    value = calculateValue@GUI(gui, 26, varargin{:});
					else
					    warning( ...
					        ['BRAPH2' ':' class(gui)], ...
					        ['BRAPH2' ':' class(gui) '\n' ...
					        'The call gui.get(''SHOW'') has NOT been executed.\n' ...
					        'First, the figure ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 27 % GUIElement.HIDE
					if gui.get('DRAWN')
					    
					    % panel element
					    gui.get('PE').get('HIDE', 'HideParentFigure', false)
					    
					    % figure layout editor
					    if isa(gui.getr('LAYOUT'), 'GUILayout') && gui.get('LAYOUT').get('DRAWN')
					        gui.get('LAYOUT').get('HIDE')
					    end
					    
					    value = calculateValue@GUI(gui, 27, varargin{:});
					else
					    warning( ...
					        ['BRAPH2' ':' class(gui)], ...
					        ['BRAPH2' ':' class(gui) '\n' ...
					        'The call gui.get(''HIDE'') has NOT been executed.\n' ...
					        'First, the figure ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 28 % GUIElement.DELETE
					if gui.get('DRAWN')
					    
					    gui.set('TEXT_FILE', Element.getNoValue())
					
					    gui.set('H_MENU_FILE', Element.getNoValue())
					    gui.set('H_MENU_IMPORT', Element.getNoValue())
					    gui.set('H_MENU_EXPORT', Element.getNoValue())
					    gui.set('H_MENU_PERSONALIZE', Element.getNoValue())
					    
					    value = calculateValue@GUI(gui, 28, varargin{:});
					else
					    warning( ...
					        ['BRAPH2' ':' class(gui)], ...
					        ['BRAPH2' ':' class(gui) '\n' ...
					        'The call gui.get(''DELETE'') has NOT been executed.\n' ...
					        'First, the panel ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 29 % GUIElement.CLOSE
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
					        % panel element
					        gui.get('PE').get('CLOSE', 'CloseParentFigure', false)
					
					        % figure layout editor
					        if isa(gui.getr('LAYOUT'), 'GUILayout') && gui.get('LAYOUT').get('DRAWN')
					            gui.get('LAYOUT').get('CLOSE')
					        end
					        
					        % main figure
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
					if prop <= 29
						value = calculateValue@GUI(gui, prop, varargin{:});
					else
						value = calculateValue@Element(gui, prop, varargin{:});
					end
			end
			
			function cb_get(~, ~, varargin)
				gui.get(varargin{:})
			end
			function cb_open(~, ~)
			    el = gui.get('PE').get('EL');
			    % select file
			    [file, path, filterindex] = uigetfile(BRAPH2.EXT_ELEMENT, ['Select the ' el.get('NAME') ' file.']);
			    if filterindex
			        filename = fullfile(path, file);
			        tmp_el = Element.load(filename, gui.get('WAITBAR'));
			        %TODO: add checks for BRAPH2 version
			        if isa(tmp_el, 'PanelFig')
			            tmp_gui = GUIFig('PF', tmp_el, 'FILE', filename, 'WAITBAR', gui.get('WAITBAR'));
			        else
			            tmp_gui = GUIElement('PE', tmp_el, 'FILE', filename, 'WAITBAR', gui.get('WAITBAR'));
			        end
			        tmp_gui.get('DRAW')
			        tmp_gui.get('SHOW')
			    end
			end
			function cb_save(~, ~)
			    filename = gui.get('FILE');
			    if isfile(filename)
			        el = gui.get('PE').get('EL');
			        Element.save(el, filename, gui.get('WAITBAR'))
			    else
			        cb_saveas();
			    end
			end
			function cb_saveas(~, ~)
			    el = gui.get('PE').get('EL');
			    % select file
			    [file, path, filterindex] = uiputfile(BRAPH2.EXT_ELEMENT, ['Select the ' el.get('NAME') ' file.']);
			    % save file
			    if filterindex
			        filename = fullfile(path, file);
			        Element.save(el, filename, gui.get('WAITBAR'))
			        gui.set('FILE', filename)
			    end
			end
			function cb_refresh_import_menu(~, ~)
			    menu_import = gui.get('H_MENU_IMPORT');
			    
			    im_menus = get(menu_import, 'Children');
			    for i = 1:1:length(im_menus)
			        delete(im_menus(i));
			    end
			    
			    pe = gui.get('PE');
			    el = pe.get('EL');
			    eval([el.getClass() '.getGUIMenuImport(el, menu_import, pe)']);
			end
			function cb_refresh_export_menu(~, ~)
			    menu_export = gui.get('H_MENU_EXPORT');
			    
			    ex_menus = get(menu_export, 'Children');
			    for i = 1:1:length(ex_menus)
			        delete(ex_menus(i));
			    end
			    
			    pe = gui.get('PE');
			    el = pe.get('EL');
			    eval([el.getClass() '.getGUIMenuExport(el, menu_export, pe)']);
			end
			function cb_layout(~, ~)
			    gui_layout = gui.memorize('LAYOUT');
			
			    gui_layout.get('DRAW')
			    gui_layout.get('SHOW')
			end
		end
	end
end
