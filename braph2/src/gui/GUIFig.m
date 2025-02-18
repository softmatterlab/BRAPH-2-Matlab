classdef GUIFig < GUI
	%GUIFig is a GUI for a figure.
	% It is a subclass of <a href="matlab:help GUI">GUI</a>.
	%
	% A Figure GUI (GUIFIG) renders a figure.
	% 
	% CONSTRUCTOR - To construct a GUI use, e.g.:
	% 
	%     gui = GUIElement(''PF'', <element>)
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
	% The list of GUIFig properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the figure GUI.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the figure GUI.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the figure GUI.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the figure GUI.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the figure GUI.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the figure GUI.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the figure GUI.
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
	%  <strong>25</strong> <strong>RESIZE</strong> 	RESIZE (query, logical) updates POSITION when figure size is changed.
	%  <strong>26</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure and its dependent figures.
	%  <strong>27</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure and its dependent figures.
	%  <strong>28</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles and closes the dependent figures when the figure is deleted.
	%  <strong>29</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure and its dependent figures.
	%  <strong>30</strong> <strong>PF</strong> 	PF (data, item) is the panel figure.
	%  <strong>31</strong> <strong>FILE</strong> 	FILE (metadata, string) is the B2 file where the element is saved.
	%  <strong>32</strong> <strong>TEXT_FILE</strong> 	TEXT_FILE (evanescent, handle) is the label where the file name is shown.
	%  <strong>33</strong> <strong>GUI_LAYOUT</strong> 	GUI_LAYOUT (data, item) is the handle to the figure to manage the layout.
	%  <strong>34</strong> <strong>GUI_SETTINGS</strong> 	GUI_SETTINGS (data, item) is the handle to the figure to manage the figure settings.
	%  <strong>35</strong> <strong>H_MENU_FILE</strong> 	H_MENU_FILE (evanescent, handle) is the handle of the menu file.
	%  <strong>36</strong> <strong>MENU_FILE</strong> 	MENU_FILE (gui, logical) determines whether to show the menu file.
	%  <strong>37</strong> <strong>H_MENU_PRINT</strong> 	H_MENU_PRINT (evanescent, handle) is the handle of the menu to print to image file.
	%  <strong>38</strong> <strong>MENU_PRINT</strong> 	MENU_PRINT (gui, logical) determines whether to show the menu to print to image file.
	%  <strong>39</strong> <strong>H_MENU_GUI_SETTINGS</strong> 	H_MENU_GUI_SETTINGS (evanescent, handle) is the handle of the menu settings.
	%  <strong>40</strong> <strong>MENU_GUI_SETTINGS</strong> 	MENU_GUI_SETTINGS (gui, logical) determines whether to show the menu settings.
	%  <strong>41</strong> <strong>H_MENU_PERSONALIZE</strong> 	H_MENU_PERSONALIZE (evanescent, handle) is the handle of the menu personalize.
	%  <strong>42</strong> <strong>MENU_PERSONALIZE</strong> 	MENU_PERSONALIZE (gui, logical) determines whether to show the menu personalize.
	%  <strong>43</strong> <strong>TOOL_FILE</strong> 	TOOL_FILE (gui, logical) determines whether to show the toolbar file buttons.
	%  <strong>44</strong> <strong>TOOL_PRINT</strong> 	TOOL_PRINT (gui, logical) determines whether to show the toolbar print button.
	%  <strong>45</strong> <strong>TOOL_GUI_SETTINGS</strong> 	TOOL_GUI_SETTINGS (gui, logical) determines whether to show the toolbar settings buttons.
	%
	% GUIFig methods (constructor):
	%  GUIFig - constructor
	%
	% GUIFig methods:
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
	% GUIFig methods (display):
	%  tostring - string with information about the figure GUI
	%  disp - displays information about the figure GUI
	%  tree - displays the tree of the figure GUI
	%
	% GUIFig methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two figure GUI are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the figure GUI
	%
	% GUIFig methods (save/load, Static):
	%  save - saves BRAPH2 figure GUI as b2 file
	%  load - loads a BRAPH2 figure GUI from a b2 file
	%
	% GUIFig method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the figure GUI
	%
	% GUIFig method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the figure GUI
	%
	% GUIFig methods (inspection, Static):
	%  getClass - returns the class of the figure GUI
	%  getSubclasses - returns all subclasses of GUIFig
	%  getProps - returns the property list of the figure GUI
	%  getPropNumber - returns the property number of the figure GUI
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
	% GUIFig methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GUIFig methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GUIFig methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GUIFig methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GUIFig; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GUIFig constants</a>.
	%
	%
	% See also uifigure, PanelFig.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		PF = 30; %CET: Computational Efficiency Trick
		PF_TAG = 'PF';
		PF_CATEGORY = 4;
		PF_FORMAT = 8;
		
		FILE = 31; %CET: Computational Efficiency Trick
		FILE_TAG = 'FILE';
		FILE_CATEGORY = 2;
		FILE_FORMAT = 2;
		
		TEXT_FILE = 32; %CET: Computational Efficiency Trick
		TEXT_FILE_TAG = 'TEXT_FILE';
		TEXT_FILE_CATEGORY = 7;
		TEXT_FILE_FORMAT = 18;
		
		GUI_LAYOUT = 33; %CET: Computational Efficiency Trick
		GUI_LAYOUT_TAG = 'GUI_LAYOUT';
		GUI_LAYOUT_CATEGORY = 4;
		GUI_LAYOUT_FORMAT = 8;
		
		GUI_SETTINGS = 34; %CET: Computational Efficiency Trick
		GUI_SETTINGS_TAG = 'GUI_SETTINGS';
		GUI_SETTINGS_CATEGORY = 4;
		GUI_SETTINGS_FORMAT = 8;
		
		H_MENU_FILE = 35; %CET: Computational Efficiency Trick
		H_MENU_FILE_TAG = 'H_MENU_FILE';
		H_MENU_FILE_CATEGORY = 7;
		H_MENU_FILE_FORMAT = 18;
		
		MENU_FILE = 36; %CET: Computational Efficiency Trick
		MENU_FILE_TAG = 'MENU_FILE';
		MENU_FILE_CATEGORY = 9;
		MENU_FILE_FORMAT = 4;
		
		H_MENU_PRINT = 37; %CET: Computational Efficiency Trick
		H_MENU_PRINT_TAG = 'H_MENU_PRINT';
		H_MENU_PRINT_CATEGORY = 7;
		H_MENU_PRINT_FORMAT = 18;
		
		MENU_PRINT = 38; %CET: Computational Efficiency Trick
		MENU_PRINT_TAG = 'MENU_PRINT';
		MENU_PRINT_CATEGORY = 9;
		MENU_PRINT_FORMAT = 4;
		
		H_MENU_GUI_SETTINGS = 39; %CET: Computational Efficiency Trick
		H_MENU_GUI_SETTINGS_TAG = 'H_MENU_GUI_SETTINGS';
		H_MENU_GUI_SETTINGS_CATEGORY = 7;
		H_MENU_GUI_SETTINGS_FORMAT = 18;
		
		MENU_GUI_SETTINGS = 40; %CET: Computational Efficiency Trick
		MENU_GUI_SETTINGS_TAG = 'MENU_GUI_SETTINGS';
		MENU_GUI_SETTINGS_CATEGORY = 9;
		MENU_GUI_SETTINGS_FORMAT = 4;
		
		H_MENU_PERSONALIZE = 41; %CET: Computational Efficiency Trick
		H_MENU_PERSONALIZE_TAG = 'H_MENU_PERSONALIZE';
		H_MENU_PERSONALIZE_CATEGORY = 7;
		H_MENU_PERSONALIZE_FORMAT = 18;
		
		MENU_PERSONALIZE = 42; %CET: Computational Efficiency Trick
		MENU_PERSONALIZE_TAG = 'MENU_PERSONALIZE';
		MENU_PERSONALIZE_CATEGORY = 9;
		MENU_PERSONALIZE_FORMAT = 4;
		
		TOOL_FILE = 43; %CET: Computational Efficiency Trick
		TOOL_FILE_TAG = 'TOOL_FILE';
		TOOL_FILE_CATEGORY = 9;
		TOOL_FILE_FORMAT = 4;
		
		TOOL_PRINT = 44; %CET: Computational Efficiency Trick
		TOOL_PRINT_TAG = 'TOOL_PRINT';
		TOOL_PRINT_CATEGORY = 9;
		TOOL_PRINT_FORMAT = 4;
		
		TOOL_GUI_SETTINGS = 45; %CET: Computational Efficiency Trick
		TOOL_GUI_SETTINGS_TAG = 'TOOL_GUI_SETTINGS';
		TOOL_GUI_SETTINGS_CATEGORY = 9;
		TOOL_GUI_SETTINGS_FORMAT = 4;
	end
	methods % constructor
		function gui = GUIFig(varargin)
			%GUIFig() creates a figure GUI.
			%
			% GUIFig(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GUIFig(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GUIFig properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the figure GUI.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the figure GUI.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the figure GUI.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the figure GUI.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the figure GUI.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the figure GUI.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the figure GUI.
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
			%  <strong>25</strong> <strong>RESIZE</strong> 	RESIZE (query, logical) updates POSITION when figure size is changed.
			%  <strong>26</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure and its dependent figures.
			%  <strong>27</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure and its dependent figures.
			%  <strong>28</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles and closes the dependent figures when the figure is deleted.
			%  <strong>29</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure and its dependent figures.
			%  <strong>30</strong> <strong>PF</strong> 	PF (data, item) is the panel figure.
			%  <strong>31</strong> <strong>FILE</strong> 	FILE (metadata, string) is the B2 file where the element is saved.
			%  <strong>32</strong> <strong>TEXT_FILE</strong> 	TEXT_FILE (evanescent, handle) is the label where the file name is shown.
			%  <strong>33</strong> <strong>GUI_LAYOUT</strong> 	GUI_LAYOUT (data, item) is the handle to the figure to manage the layout.
			%  <strong>34</strong> <strong>GUI_SETTINGS</strong> 	GUI_SETTINGS (data, item) is the handle to the figure to manage the figure settings.
			%  <strong>35</strong> <strong>H_MENU_FILE</strong> 	H_MENU_FILE (evanescent, handle) is the handle of the menu file.
			%  <strong>36</strong> <strong>MENU_FILE</strong> 	MENU_FILE (gui, logical) determines whether to show the menu file.
			%  <strong>37</strong> <strong>H_MENU_PRINT</strong> 	H_MENU_PRINT (evanescent, handle) is the handle of the menu to print to image file.
			%  <strong>38</strong> <strong>MENU_PRINT</strong> 	MENU_PRINT (gui, logical) determines whether to show the menu to print to image file.
			%  <strong>39</strong> <strong>H_MENU_GUI_SETTINGS</strong> 	H_MENU_GUI_SETTINGS (evanescent, handle) is the handle of the menu settings.
			%  <strong>40</strong> <strong>MENU_GUI_SETTINGS</strong> 	MENU_GUI_SETTINGS (gui, logical) determines whether to show the menu settings.
			%  <strong>41</strong> <strong>H_MENU_PERSONALIZE</strong> 	H_MENU_PERSONALIZE (evanescent, handle) is the handle of the menu personalize.
			%  <strong>42</strong> <strong>MENU_PERSONALIZE</strong> 	MENU_PERSONALIZE (gui, logical) determines whether to show the menu personalize.
			%  <strong>43</strong> <strong>TOOL_FILE</strong> 	TOOL_FILE (gui, logical) determines whether to show the toolbar file buttons.
			%  <strong>44</strong> <strong>TOOL_PRINT</strong> 	TOOL_PRINT (gui, logical) determines whether to show the toolbar print button.
			%  <strong>45</strong> <strong>TOOL_GUI_SETTINGS</strong> 	TOOL_GUI_SETTINGS (gui, logical) determines whether to show the toolbar settings buttons.
			%
			% See also Category, Format.
			
			gui = gui@GUI(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the figure GUI.
			%
			% BUILD = GUIFig.GETBUILD() returns the build of 'GUIFig'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GUI.GETBUILD() returns the build of the figure GUI GUI.
			%  BUILD = Element.GETBUILD(GUI) returns the build of 'GUI'.
			%  BUILD = Element.GETBUILD('GUIFig') returns the build of 'GUIFig'.
			%
			% Note that the Element.GETBUILD(GUI) and Element.GETBUILD('GUIFig')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gui_class = getClass()
			%GETCLASS returns the class of the figure GUI.
			%
			% CLASS = GUIFig.GETCLASS() returns the class 'GUIFig'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GUI.GETCLASS() returns the class of the figure GUI GUI.
			%  CLASS = Element.GETCLASS(GUI) returns the class of 'GUI'.
			%  CLASS = Element.GETCLASS('GUIFig') returns 'GUIFig'.
			%
			% Note that the Element.GETCLASS(GUI) and Element.GETCLASS('GUIFig')
			%  are less computationally efficient.
			
			gui_class = 'GUIFig';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the figure GUI.
			%
			% LIST = GUIFig.GETSUBCLASSES() returns all subclasses of 'GUIFig'.
			%
			% Alternative forms to call this method are:
			%  LIST = GUI.GETSUBCLASSES() returns all subclasses of the figure GUI GUI.
			%  LIST = Element.GETSUBCLASSES(GUI) returns all subclasses of 'GUI'.
			%  LIST = Element.GETSUBCLASSES('GUIFig') returns all subclasses of 'GUIFig'.
			%
			% Note that the Element.GETSUBCLASSES(GUI) and Element.GETSUBCLASSES('GUIFig')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GUIFig' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of figure GUI.
			%
			% PROPS = GUIFig.GETPROPS() returns the property list of figure GUI
			%  as a row vector.
			%
			% PROPS = GUIFig.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GUI.GETPROPS([CATEGORY]) returns the property list of the figure GUI GUI.
			%  PROPS = Element.GETPROPS(GUI[, CATEGORY]) returns the property list of 'GUI'.
			%  PROPS = Element.GETPROPS('GUIFig'[, CATEGORY]) returns the property list of 'GUIFig'.
			%
			% Note that the Element.GETPROPS(GUI) and Element.GETPROPS('GUIFig')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45];
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
					prop_list = [5 30 33 34];
				case 6 % Category.QUERY
					prop_list = [8 10 11 25 26 27 28 29];
				case 7 % Category.EVANESCENT
					prop_list = [15 17 19 20 24 32 35 37 39 41];
				case 9 % Category.GUI
					prop_list = [9 12 13 14 16 18 21 22 23 36 38 40 42 43 44 45];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of figure GUI.
			%
			% N = GUIFig.GETPROPNUMBER() returns the property number of figure GUI.
			%
			% N = GUIFig.GETPROPNUMBER(CATEGORY) returns the property number of figure GUI
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GUI.GETPROPNUMBER([CATEGORY]) returns the property number of the figure GUI GUI.
			%  N = Element.GETPROPNUMBER(GUI) returns the property number of 'GUI'.
			%  N = Element.GETPROPNUMBER('GUIFig') returns the property number of 'GUIFig'.
			%
			% Note that the Element.GETPROPNUMBER(GUI) and Element.GETPROPNUMBER('GUIFig')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 45;
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
					prop_number = 4;
				case 6 % Category.QUERY
					prop_number = 8;
				case 7 % Category.EVANESCENT
					prop_number = 10;
				case 9 % Category.GUI
					prop_number = 16;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in figure GUI/error.
			%
			% CHECK = GUIFig.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GUI.EXISTSPROP(PROP) checks whether PROP exists for GUI.
			%  CHECK = Element.EXISTSPROP(GUI, PROP) checks whether PROP exists for GUI.
			%  CHECK = Element.EXISTSPROP(GUIFig, PROP) checks whether PROP exists for GUIFig.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GUIFig:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GUI.EXISTSPROP(PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUIFig:WrongInput]
			%  Element.EXISTSPROP(GUI, PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUIFig:WrongInput]
			%  Element.EXISTSPROP(GUIFig, PROP) throws error if PROP does NOT exist for GUIFig.
			%   Error id: [BRAPH2:GUIFig:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GUI) and Element.EXISTSPROP('GUIFig')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 45 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GUIFig:' 'WrongInput'], ...
					['BRAPH2' ':GUIFig:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GUIFig.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in figure GUI/error.
			%
			% CHECK = GUIFig.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GUI.EXISTSTAG(TAG) checks whether TAG exists for GUI.
			%  CHECK = Element.EXISTSTAG(GUI, TAG) checks whether TAG exists for GUI.
			%  CHECK = Element.EXISTSTAG(GUIFig, TAG) checks whether TAG exists for GUIFig.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GUIFig:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GUI.EXISTSTAG(TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUIFig:WrongInput]
			%  Element.EXISTSTAG(GUI, TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUIFig:WrongInput]
			%  Element.EXISTSTAG(GUIFig, TAG) throws error if TAG does NOT exist for GUIFig.
			%   Error id: [BRAPH2:GUIFig:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GUI) and Element.EXISTSTAG('GUIFig')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DRAW'  'DRAWN'  'TITLE'  'POSITION'  'BKGCOLOR'  'H_MENUBAR'  'MENUBAR'  'H_MENU_ABOUT'  'MENU_ABOUT'  'H_TOOLBAR'  'H_TOOLS'  'TOOLBAR'  'TOOL_ABOUT'  'CLOSEREQ'  'H'  'RESIZE'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'PF'  'FILE'  'TEXT_FILE'  'GUI_LAYOUT'  'GUI_SETTINGS'  'H_MENU_FILE'  'MENU_FILE'  'H_MENU_PRINT'  'MENU_PRINT'  'H_MENU_GUI_SETTINGS'  'MENU_GUI_SETTINGS'  'H_MENU_PERSONALIZE'  'MENU_PERSONALIZE'  'TOOL_FILE'  'TOOL_PRINT'  'TOOL_GUI_SETTINGS' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GUIFig:' 'WrongInput'], ...
					['BRAPH2' ':GUIFig:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GUIFig.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GUIFig, POINTER) returns property number of POINTER of GUIFig.
			%  PROPERTY = GUI.GETPROPPROP(GUIFig, POINTER) returns property number of POINTER of GUIFig.
			%
			% Note that the Element.GETPROPPROP(GUI) and Element.GETPROPPROP('GUIFig')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DRAW'  'DRAWN'  'TITLE'  'POSITION'  'BKGCOLOR'  'H_MENUBAR'  'MENUBAR'  'H_MENU_ABOUT'  'MENU_ABOUT'  'H_TOOLBAR'  'H_TOOLS'  'TOOLBAR'  'TOOL_ABOUT'  'CLOSEREQ'  'H'  'RESIZE'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'PF'  'FILE'  'TEXT_FILE'  'GUI_LAYOUT'  'GUI_SETTINGS'  'H_MENU_FILE'  'MENU_FILE'  'H_MENU_PRINT'  'MENU_PRINT'  'H_MENU_GUI_SETTINGS'  'MENU_GUI_SETTINGS'  'H_MENU_PERSONALIZE'  'MENU_PERSONALIZE'  'TOOL_FILE'  'TOOL_PRINT'  'TOOL_GUI_SETTINGS' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(GUIFig, POINTER) returns tag of POINTER of GUIFig.
			%  TAG = GUI.GETPROPTAG(GUIFig, POINTER) returns tag of POINTER of GUIFig.
			%
			% Note that the Element.GETPROPTAG(GUI) and Element.GETPROPTAG('GUIFig')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				guifig_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DRAW'  'DRAWN'  'TITLE'  'POSITION'  'BKGCOLOR'  'H_MENUBAR'  'MENUBAR'  'H_MENU_ABOUT'  'MENU_ABOUT'  'H_TOOLBAR'  'H_TOOLS'  'TOOLBAR'  'TOOL_ABOUT'  'CLOSEREQ'  'H'  'RESIZE'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'PF'  'FILE'  'TEXT_FILE'  'GUI_LAYOUT'  'GUI_SETTINGS'  'H_MENU_FILE'  'MENU_FILE'  'H_MENU_PRINT'  'MENU_PRINT'  'H_MENU_GUI_SETTINGS'  'MENU_GUI_SETTINGS'  'H_MENU_PERSONALIZE'  'MENU_PERSONALIZE'  'TOOL_FILE'  'TOOL_PRINT'  'TOOL_GUI_SETTINGS' };
				tag = guifig_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(GUIFig, POINTER) returns category of POINTER of GUIFig.
			%  CATEGORY = GUI.GETPROPCATEGORY(GUIFig, POINTER) returns category of POINTER of GUIFig.
			%
			% Note that the Element.GETPROPCATEGORY(GUI) and Element.GETPROPCATEGORY('GUIFig')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GUIFig.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			guifig_category_list = { 1  1  1  3  4  2  2  6  9  6  6  9  9  9  7  9  7  9  7  7  9  9  9  7  6  6  6  6  6  4  2  7  4  4  7  9  7  9  7  9  7  9  9  9  9 };
			prop_category = guifig_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(GUIFig, POINTER) returns format of POINTER of GUIFig.
			%  FORMAT = GUI.GETPROPFORMAT(GUIFig, POINTER) returns format of POINTER of GUIFig.
			%
			% Note that the Element.GETPROPFORMAT(GUI) and Element.GETPROPFORMAT('GUIFig')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GUIFig.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			guifig_format_list = { 2  2  2  8  2  2  2  2  4  4  4  2  12  20  19  4  18  4  18  19  4  4  4  18  4  4  4  4  4  8  2  18  8  8  18  4  18  4  18  4  18  4  4  4  4 };
			prop_format = guifig_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GUIFig, POINTER) returns description of POINTER of GUIFig.
			%  DESCRIPTION = GUI.GETPROPDESCRIPTION(GUIFig, POINTER) returns description of POINTER of GUIFig.
			%
			% Note that the Element.GETPROPDESCRIPTION(GUI) and Element.GETPROPDESCRIPTION('GUIFig')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GUIFig.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			guifig_description_list = { 'ELCLASS (constant, string) is the class of the figure GUI.'  'NAME (constant, string) is the name of the figure GUI.'  'DESCRIPTION (constant, string) is the description of the figure GUI.'  'TEMPLATE (parameter, item) is the template of the figure GUI.'  'ID (data, string) is a few-letter code for the figure GUI.'  'LABEL (metadata, string) is an extended label of the figure GUI.'  'NOTES (metadata, string) are some specific notes about the figure GUI.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'DRAW (query, logical) draws the contents of a GUI before showing it.'  'DRAWN (query, logical) returns whether the GUI has been drawn.'  'TITLE (gui, string) is the name of the GUI.'  'POSITION (gui, rvector) is the normalized position of the GUI on the screen.'  'BKGCOLOR (gui, color) is the GUI background color.'  'H_MENUBAR (evanescent, handlelist) is the list of handles for the menus.'  'MENUBAR (gui, logical) determines whether to show the menubar.'  'H_MENU_ABOUT (evanescent, handle) is the handle of the menu about.'  'MENU_ABOUT (gui, logical) determines whether to show the menu about.'  'H_TOOLBAR (evanescent, handle) is the handle list of the toolbar.'  'H_TOOLS (evanescent, handlelist) is the handle list of the toolbar followed by the tools from the first.'  'TOOLBAR (gui, logical) determines whether to show the toolbar.'  'TOOL_ABOUT (gui, logical) determines whether to show the toolbar about buttons.'  'CLOSEREQ (gui, logical) determines whether to confirm close.'  'H (evanescent, handle) is the figure handle.'  'RESIZE (query, logical) updates POSITION when figure size is changed.'  'SHOW (query, logical) shows the figure and its dependent figures.'  'HIDE (query, logical) hides the figure and its dependent figures.'  'DELETE (query, logical) resets the handles and closes the dependent figures when the figure is deleted.'  'CLOSE (query, logical) closes the figure and its dependent figures.'  'PF (data, item) is the panel figure.'  'FILE (metadata, string) is the B2 file where the element is saved.'  'TEXT_FILE (evanescent, handle) is the label where the file name is shown.'  'GUI_LAYOUT (data, item) is the handle to the figure to manage the layout.'  'GUI_SETTINGS (data, item) is the handle to the figure to manage the figure settings.'  'H_MENU_FILE (evanescent, handle) is the handle of the menu file.'  'MENU_FILE (gui, logical) determines whether to show the menu file.'  'H_MENU_PRINT (evanescent, handle) is the handle of the menu to print to image file.'  'MENU_PRINT (gui, logical) determines whether to show the menu to print to image file.'  'H_MENU_GUI_SETTINGS (evanescent, handle) is the handle of the menu settings.'  'MENU_GUI_SETTINGS (gui, logical) determines whether to show the menu settings.'  'H_MENU_PERSONALIZE (evanescent, handle) is the handle of the menu personalize.'  'MENU_PERSONALIZE (gui, logical) determines whether to show the menu personalize.'  'TOOL_FILE (gui, logical) determines whether to show the toolbar file buttons.'  'TOOL_PRINT (gui, logical) determines whether to show the toolbar print button.'  'TOOL_GUI_SETTINGS (gui, logical) determines whether to show the toolbar settings buttons.' };
			prop_description = guifig_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(GUIFig, POINTER) returns settings of POINTER of GUIFig.
			%  SETTINGS = GUI.GETPROPSETTINGS(GUIFig, POINTER) returns settings of POINTER of GUIFig.
			%
			% Note that the Element.GETPROPSETTINGS(GUI) and Element.GETPROPSETTINGS('GUIFig')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GUIFig.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 30 % GUIFig.PF
					prop_settings = 'PanelFig';
				case 31 % GUIFig.FILE
					prop_settings = Format.getFormatSettings(2);
				case 32 % GUIFig.TEXT_FILE
					prop_settings = Format.getFormatSettings(18);
				case 33 % GUIFig.GUI_LAYOUT
					prop_settings = 'GUILayout';
				case 34 % GUIFig.GUI_SETTINGS
					prop_settings = 'GUIElement';
				case 35 % GUIFig.H_MENU_FILE
					prop_settings = Format.getFormatSettings(18);
				case 36 % GUIFig.MENU_FILE
					prop_settings = Format.getFormatSettings(4);
				case 37 % GUIFig.H_MENU_PRINT
					prop_settings = Format.getFormatSettings(18);
				case 38 % GUIFig.MENU_PRINT
					prop_settings = Format.getFormatSettings(4);
				case 39 % GUIFig.H_MENU_GUI_SETTINGS
					prop_settings = Format.getFormatSettings(18);
				case 40 % GUIFig.MENU_GUI_SETTINGS
					prop_settings = Format.getFormatSettings(4);
				case 41 % GUIFig.H_MENU_PERSONALIZE
					prop_settings = Format.getFormatSettings(18);
				case 42 % GUIFig.MENU_PERSONALIZE
					prop_settings = Format.getFormatSettings(4);
				case 43 % GUIFig.TOOL_FILE
					prop_settings = Format.getFormatSettings(4);
				case 44 % GUIFig.TOOL_PRINT
					prop_settings = Format.getFormatSettings(4);
				case 45 % GUIFig.TOOL_GUI_SETTINGS
					prop_settings = Format.getFormatSettings(4);
				case 4 % GUIFig.TEMPLATE
					prop_settings = 'GUIFig';
				otherwise
					prop_settings = getPropSettings@GUI(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GUIFig.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GUIFig.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GUI.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GUI.
			%  DEFAULT = Element.GETPROPDEFAULT(GUIFig, POINTER) returns the default value of POINTER of GUIFig.
			%  DEFAULT = GUI.GETPROPDEFAULT(GUIFig, POINTER) returns the default value of POINTER of GUIFig.
			%
			% Note that the Element.GETPROPDEFAULT(GUI) and Element.GETPROPDEFAULT('GUIFig')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GUIFig.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 30 % GUIFig.PF
					prop_default = Format.getFormatDefault(8, GUIFig.getPropSettings(prop));
				case 31 % GUIFig.FILE
					prop_default = Format.getFormatDefault(2, GUIFig.getPropSettings(prop));
				case 32 % GUIFig.TEXT_FILE
					prop_default = Format.getFormatDefault(18, GUIFig.getPropSettings(prop));
				case 33 % GUIFig.GUI_LAYOUT
					prop_default = Format.getFormatDefault(8, GUIFig.getPropSettings(prop));
				case 34 % GUIFig.GUI_SETTINGS
					prop_default = Format.getFormatDefault(8, GUIFig.getPropSettings(prop));
				case 35 % GUIFig.H_MENU_FILE
					prop_default = Format.getFormatDefault(18, GUIFig.getPropSettings(prop));
				case 36 % GUIFig.MENU_FILE
					prop_default = true;
				case 37 % GUIFig.H_MENU_PRINT
					prop_default = Format.getFormatDefault(18, GUIFig.getPropSettings(prop));
				case 38 % GUIFig.MENU_PRINT
					prop_default = true;
				case 39 % GUIFig.H_MENU_GUI_SETTINGS
					prop_default = Format.getFormatDefault(18, GUIFig.getPropSettings(prop));
				case 40 % GUIFig.MENU_GUI_SETTINGS
					prop_default = true;
				case 41 % GUIFig.H_MENU_PERSONALIZE
					prop_default = Format.getFormatDefault(18, GUIFig.getPropSettings(prop));
				case 42 % GUIFig.MENU_PERSONALIZE
					prop_default = true;
				case 43 % GUIFig.TOOL_FILE
					prop_default = true;
				case 44 % GUIFig.TOOL_PRINT
					prop_default = true;
				case 45 % GUIFig.TOOL_GUI_SETTINGS
					prop_default = true;
				case 1 % GUIFig.ELCLASS
					prop_default = 'GUIFig';
				case 2 % GUIFig.NAME
					prop_default = 'Figure GUI';
				case 3 % GUIFig.DESCRIPTION
					prop_default = 'A Figure GUI (GUIFIG) renders a figure.';
				case 4 % GUIFig.TEMPLATE
					prop_default = Format.getFormatDefault(8, GUIFig.getPropSettings(prop));
				case 5 % GUIFig.ID
					prop_default = 'GUIFIG ID';
				case 6 % GUIFig.LABEL
					prop_default = 'GUIFIG label';
				case 7 % GUIFig.NOTES
					prop_default = 'GUIFIG notes';
				case 13 % GUIFig.POSITION
					prop_default = [.30 .40 .39 .47];
				case 14 % GUIFig.BKGCOLOR
					prop_default = [0.7 0.7 0.7];
				case 16 % GUIFig.MENUBAR
					prop_default = true;
				case 18 % GUIFig.MENU_ABOUT
					prop_default = true;
				case 21 % GUIFig.TOOLBAR
					prop_default = true;
				case 22 % GUIFig.TOOL_ABOUT
					prop_default = true;
				otherwise
					prop_default = getPropDefault@GUI(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GUIFig.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GUIFig.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GUI.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GUIFig, POINTER) returns the conditioned default value of POINTER of GUIFig.
			%  DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(GUIFig, POINTER) returns the conditioned default value of POINTER of GUIFig.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GUI) and Element.GETPROPDEFAULTCONDITIONED('GUIFig')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GUIFig.getPropProp(pointer);
			
			prop_default = GUIFig.conditioning(prop, GUIFig.getPropDefault(prop));
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
				case 33 % GUIFig.GUI_LAYOUT
					if isa(value.getr('EL_CLASS'), 'NoValue')
					    f = gui.get('H');
					    value.set( ...
					        'EL_CLASS', gui.get('PF'), ...
					        'POSITION', [x0(f)+w(f) y0(f)+h(f)*2/3 w(f) h(f)/3], ...
					        'CLOSEREQ', false ...
					        )
					end
					
				case 34 % GUIFig.GUI_SETTINGS
					if isa(value.getr('PE'), 'NoValue') % i.e., default initialization
					    pf = gui.memorize('PF');
					    f = gui.get('H');
					    
					    pe = PanelElement('EL', pf);
					    
					    pr_visible = int8(pe.get('PR_VISIBLE') & ismember(1:1:pf.getPropNumber(), pf.getProps(8))); % Category.FIGURE
					
					    pr_order = pe.get('PR_ORDER');
					    pr_order(pr_visible == 0) = NaN;
					    for i = sum(pr_visible):-1:1
					        pr_order(pr_order == max(pr_order)) = -i;
					    end
					    pr_order = -pr_order;
					    
					    pe.set( ...
					        'PR_VISIBLE', pr_visible, ...
					        'PR_ORDER', pr_order ...
					        )
					    
						value.set( ...
					        'PE', pe, ...
					        'TITLE', ['Settings - ' gui.get('TITLE')], ...
					        'POSITION', [ ...
					            min(x0(f, 'normalized') + w(f, 'normalized'), 1 - (pe.get('MIN_WIDTH') + 20) / w(0, 'pixels')) ... % min to ensure that figure within screen
					            y0(f, 'normalized') ...
					            (pe.get('MIN_WIDTH') + 20) / w(0, 'pixels') ...
					            h(f, 'normalized') ...
					            ], ...
					        'MENUBAR', false, ...
					        'TOOLBAR', false, ...
					        'WAITBAR', gui.getCallback('WAITBAR'), ...
					        'CLOSEREQ', false ...
					        );
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
			%  CHECK = Element.CHECKPROP(GUIFig, PROP, VALUE) checks VALUE format for PROP of GUIFig.
			%  CHECK = GUI.CHECKPROP(GUIFig, PROP, VALUE) checks VALUE format for PROP of GUIFig.
			% 
			% GUI.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GUIFig:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GUI.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GUI.
			%   Error id: BRAPH2:GUIFig:WrongInput
			%  Element.CHECKPROP(GUIFig, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GUIFig.
			%   Error id: BRAPH2:GUIFig:WrongInput
			%  GUI.CHECKPROP(GUIFig, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GUIFig.
			%   Error id: BRAPH2:GUIFig:WrongInput]
			% 
			% Note that the Element.CHECKPROP(GUI) and Element.CHECKPROP('GUIFig')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GUIFig.getPropProp(pointer);
			
			switch prop
				case 30 % GUIFig.PF
					check = Format.checkFormat(8, value, GUIFig.getPropSettings(prop));
				case 31 % GUIFig.FILE
					check = Format.checkFormat(2, value, GUIFig.getPropSettings(prop));
				case 32 % GUIFig.TEXT_FILE
					check = Format.checkFormat(18, value, GUIFig.getPropSettings(prop));
				case 33 % GUIFig.GUI_LAYOUT
					check = Format.checkFormat(8, value, GUIFig.getPropSettings(prop));
				case 34 % GUIFig.GUI_SETTINGS
					check = Format.checkFormat(8, value, GUIFig.getPropSettings(prop));
				case 35 % GUIFig.H_MENU_FILE
					check = Format.checkFormat(18, value, GUIFig.getPropSettings(prop));
				case 36 % GUIFig.MENU_FILE
					check = Format.checkFormat(4, value, GUIFig.getPropSettings(prop));
				case 37 % GUIFig.H_MENU_PRINT
					check = Format.checkFormat(18, value, GUIFig.getPropSettings(prop));
				case 38 % GUIFig.MENU_PRINT
					check = Format.checkFormat(4, value, GUIFig.getPropSettings(prop));
				case 39 % GUIFig.H_MENU_GUI_SETTINGS
					check = Format.checkFormat(18, value, GUIFig.getPropSettings(prop));
				case 40 % GUIFig.MENU_GUI_SETTINGS
					check = Format.checkFormat(4, value, GUIFig.getPropSettings(prop));
				case 41 % GUIFig.H_MENU_PERSONALIZE
					check = Format.checkFormat(18, value, GUIFig.getPropSettings(prop));
				case 42 % GUIFig.MENU_PERSONALIZE
					check = Format.checkFormat(4, value, GUIFig.getPropSettings(prop));
				case 43 % GUIFig.TOOL_FILE
					check = Format.checkFormat(4, value, GUIFig.getPropSettings(prop));
				case 44 % GUIFig.TOOL_PRINT
					check = Format.checkFormat(4, value, GUIFig.getPropSettings(prop));
				case 45 % GUIFig.TOOL_GUI_SETTINGS
					check = Format.checkFormat(4, value, GUIFig.getPropSettings(prop));
				case 4 % GUIFig.TEMPLATE
					check = Format.checkFormat(8, value, GUIFig.getPropSettings(prop));
				otherwise
					if prop <= 29
						check = checkProp@GUI(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GUIFig:' 'WrongInput'], ...
					['BRAPH2' ':GUIFig:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GUIFig.getPropTag(prop) ' (' GUIFig.getFormatTag(GUIFig.getPropFormat(prop)) ').'] ...
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
				case 30 % GUIFig.PF
					pf = gui.get('PF');
					pf.set('PARENT', gui)
					if isa(gui.getr('TITLE'), 'NoValue')
					    gui.set('TITLE', [pf.getClass() ' - ' pf.get('ID') ' - ' 'BRAPH2'])
					end
					gui.lock('PF', 'Iterative', false)
					
				case 31 % GUIFig.FILE
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
				case 32 % GUIFig.TEXT_FILE
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
					
				case 35 % GUIFig.H_MENU_FILE
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
					
				case 37 % GUIFig.H_MENU_PRINT
					menu_print = uimenu(gui.memorize('H'), ... % f for figure
					    'Tag', 'MENU.Print', ...
					    'Label', 'Print' ...
					    );
					
					uimenu(menu_print, ...
					    'Tag', 'MENU.Print.Print', ...
					    'Label', 'Print ...', ...
					    'Accelerator', 'P', ...
					    'Callback', {@cb_print})
					uimenu(menu_print, ...
					    'Tag', 'MENU.Print.Vectorial', ...
					    'Label', 'Vectorial ...', ...
					    'Callback', {@cb_print, 'vector'})
					uimenu(menu_print, ...
					    'Separator', 'on', ...
					    'Tag', 'MENU.Print.HR300', ...
					    'Label', 'Hi-res (300 dpi) ...', ...
					    'Callback', {@cb_print, 'image', 300})
					uimenu(menu_print, ...
					    'Tag', 'MENU.Print.HR600', ...
					    'Label', 'Hi-res (600 dpi) ...', ...
					    'Callback', {@cb_print, 'image', 600})
					uimenu(menu_print, ...
					    'Tag', 'MENU.Print.HR1200', ...
					    'Label', 'Hi-res (1200 dpi) ...', ...
					    'Callback', {@cb_print, 'image', 1200})
					uimenu(menu_print, ...
					    'Separator', 'on', ...
					    'Tag', 'MENU.Print.Grayscale', ...
					    'Label', 'Grayscale ...', ...
					    'Callback', {@cb_print, [], [], 'gray'})
					uimenu(menu_print, ...
					    'Tag', 'MENU.Print.VectorialGrayscale', ...
					    'Label', 'Vectorial grayscale ...', ...
					    'Callback', {@cb_print, 'vector', [], 'gray'})
					uimenu(menu_print, ...
					    'Separator', 'on', ...
					    'Tag', 'MENU.Print.CMYK', ...
					    'Label', 'CMYK ...', ...
					    'Callback', {@cb_print, [], [], 'cmyk'})
					uimenu(menu_print, ...
					    'Tag', 'MENU.Print.VEctorialCMYK', ...
					    'Label', 'Vectorial CMYK ...', ...
					    'Callback', {@cb_print, 'vector', [], 'cmyk'})
					
					value = menu_print;
					
				case 39 % GUIFig.H_MENU_GUI_SETTINGS
					menu_settings = uimenu(gui.memorize('H'), ... % f for figure
					    'Tag', 'MENU.Settings', ...
					    'Label', 'Settings' ...
					    );
					
					uimenu(menu_settings, ...
					    'Tag', 'MENU.Settings.Settings', ...
					    'Label', 'Settings ...', ...
					    'Callback', {@cb_settings})
					
					value = menu_settings;
					
				case 41 % GUIFig.H_MENU_PERSONALIZE
					menu_personalize = uimenu(gui.memorize('H'), ... % f for figure
					    'Tag', 'MENU.Personalize', ...
					    'Label', 'Personalize' ...
					    );
					
					uimenu(menu_personalize, ...
					    'Tag', 'MENU.Personalize.Layout', ...
					    'Label', 'Layout ...', ...
					    'Callback', {@cb_layout})
					
					value = menu_personalize;
					
				case 15 % GUIFig.H_MENUBAR
					value = {};
					if gui.get('MENU_FILE')
					    value = [value, gui.memorize('H_MENU_FILE')];
					end
					if gui.get('MENU_PRINT')
					    value = [value, gui.memorize('H_MENU_PRINT')];
					end
					if gui.get('MENU_GUI_SETTINGS')
					    value = [value, gui.memorize('H_MENU_GUI_SETTINGS')];
					end
					if gui.get('MENU_PERSONALIZE')
					    value = [value, gui.memorize('H_MENU_PERSONALIZE')];
					end
					if gui.get('MENU_ABOUT')
					    value = [value, gui.memorize('H_MENU_ABOUT')];
					end
					
				case 20 % GUIFig.H_TOOLS
					toolbar = gui.memorize('H_TOOLBAR');
					
					children = calculateValue@GUI(gui, 20);
					
					pf = gui.memorize('PF');
					
					value = {};
					
					if gui.get('TOOL_FILE')
					    % OPEN
					    tool_file_open = uipushtool(toolbar, ...
					        'Tag', 'TOOL.Open', ...                
					        'Tooltip', ['Open ' pf.get('NAME')], ...
					        'CData', imread('icon_open_ml.png'), ...
					        'ClickedCallback', {@cb_open});
					    % Save
					    tool_file_save = uipushtool(toolbar, ...
					        'Tag', 'TOOL.Save', ...                
					        'Tooltip', ['Save ' pf.get('NAME')], ...
					        'CData', imread('icon_save_ml.png'), ...
					        'ClickedCallback', {@cb_save});
					    
					    value = {value{:}, tool_file_open, tool_file_save};
					end
					if gui.get('TOOL_PRINT')
					    % Print
					    tool_print = uipushtool(toolbar, ...
					        'Tag', 'TOOL.Print', ...                
					        'Tooltip', ['Print/Export to image file ' pf.get('NAME')], ...
					        'CData', imread('icon_print_ml.png'), ...
					        'ClickedCallback', {@cb_print, 'auto', 300});
					
					    value = {value{:}, tool_print};
					end
					if gui.get('TOOL_GUI_SETTINGS')
					    % Settings
					    tool_settings = uipushtool(toolbar, ...
					        'Tag', 'TOOL.Settings', ...       
					        'Separator', 'on', ...
					        'Tooltip', ['Settings ' pf.get('NAME')], ... 
					        'CData', imread('icon_settings_ml.png'), ...
					        'ClickedCallback', {@cb_settings});
					  
					    value = {value{:}, tool_settings};
					end
					
					panel_tools = pf.memorize('H_TOOLS');
					value = {value{:}, panel_tools{:}};
					
					value = {value{:}, children{:}};
					
					% reorder tools
					toolbar.Children = [value{end:-1:1}];
					
				case 10 % GUIFig.DRAW
					if check_graphics(gui.memorize('H'), 'figure')
					
					    if gui.get('MENUBAR')
					        gui.memorize('H_MENUBAR')
					    end
					    
					    if gui.get('TOOLBAR')
					        % gui.memorize('H_TOOLBAR') % performed automatically by gui.memorize('H_TOOLS')
					        gui.memorize('H_TOOLS')
					    end
					    
					    pf = gui.memorize('PF');
					    pf.get('DRAW')
					
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
					
				case 24 % GUIFig.H
					f = calculateValue@GUI(gui, 24);
					pf = gui.memorize('PF');
					value = f;
					
				case 26 % GUIFig.SHOW
					value = calculateValue@GUI(gui, 26, varargin{:}); % also warning
					if value
					    % figure layout editor
					    if isa(gui.getr('GUI_LAYOUT'), 'GUILayout') && gui.get('GUI_LAYOUT').get('DRAWN')
					        gui.get('GUI_LAYOUT').get('SHOW')
					    end
					    
					    % figure settings
					    if isa(gui.getr('GUI_SETTINGS'), 'GUIElement') && gui.get('GUI_SETTINGS').get('DRAWN')
					        gui.get('GUI_SETTINGS').get('SHOW')
					    end
					end
					
				case 27 % GUIFig.HIDE
					value = calculateValue@GUI(gui, 27, varargin{:}); % also warning
					if value
					    % figure layout editor
					    if isa(gui.getr('GUI_LAYOUT'), 'GUILayout') && gui.get('GUI_LAYOUT').get('DRAWN')
					        gui.get('GUI_LAYOUT').get('HIDE')
					    end
					
					    % figure settings
					    if isa(gui.getr('GUI_SETTINGS'), 'GUIElement') && gui.get('GUI_SETTINGS').get('DRAWN')
					        gui.get('GUI_SETTINGS').get('HIDE')
					    end
					end
					
				case 28 % GUIFig.DELETE
					value = calculateValue@GUI(gui, 28, varargin{:}); % also warning
					if value
						gui.set('TEXT_FILE', Element.getNoValue())
					
					 	gui.set('H_MENU_FILE', Element.getNoValue())
						gui.set('H_MENU_PRINT', Element.getNoValue())
					 	gui.set('H_MENU_GUI_SETTINGS', Element.getNoValue())
					 	gui.set('H_MENU_PERSONALIZE', Element.getNoValue())
					end
					
				case 29 % GUIFig.CLOSE
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
					        % figure layout editor
					        if isa(gui.getr('GUI_LAYOUT'), 'GUILayout') && gui.get('GUI_LAYOUT').get('DRAWN')
					            gui.get('GUI_LAYOUT').get('CLOSE')
					        end
					
					        % figure settings
					        if isa(gui.getr('GUI_SETTINGS'), 'GUIElement') && gui.get('GUI_SETTINGS').get('DRAWN')
					            gui.get('GUI_SETTINGS').get('CLOSE')
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
			    pf = gui.get('PF');
			    % select file
			    [file, path, filterindex] = uigetfile(BRAPH2.EXT_ELEMENT, ['Select the ' pf.get('NAME') ' file.']);
			    if filterindex
			        filename = fullfile(path, file);
			        tmp_el = Element.load(filename, gui.get('WAITBAR'));
			        % % % %TODO: add checks for BRAPH2 version
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
			        pf = gui.get('PF');
			        Element.save(pf, filename, gui.get('WAITBAR'))
			    else
			        cb_saveas();
			    end
			end
			function cb_saveas(~, ~)
			    pf = gui.get('PF');
			    % select file
			    [file, path, filterindex] = uiputfile(BRAPH2.EXT_ELEMENT, ['Select the ' pf.get('NAME') ' file.']);
			    % save file
			    if filterindex
			        filename = fullfile(path, file);
			        Element.save(pf, filename, gui.get('WAITBAR'))
			        gui.set('FILE', filename)
			    end
			end
			function cb_print(~, ~, contenttype, resolution, colorspace)
			    if nargin < 5 || isempty(colorspace)
			        colorspace = 'rgb';
			    end
			    if nargin < 4 || isempty(resolution)
			        resolution = 150;
			    end
			    if nargin < 3 || isempty(contenttype)
			        contenttype = 'auto';
			    end        
			    braph2print(gui.get('PF').get('H'), [], 'ContentType', contenttype, 'Resolution', resolution, 'Colorspace', colorspace)
			end
			function cb_settings(~, ~)
				gui_settings = gui.memorize('GUI_SETTINGS');
			
			    if ~gui_settings.get('DRAWN')
			        gui_settings.get('DRAW')
			        gui_settings.get('SHOW')
			    else
			        if get(gui_settings.get('H'), 'Visible')
			            gui_settings.get('HIDE')
			        else
			            gui_settings.get('SHOW')
			        end
			    end
			end
			function cb_layout(~, ~)
			    gui_layout = gui.memorize('GUI_LAYOUT');
			
			    gui_layout.get('DRAW')
			    gui_layout.get('SHOW')
			end
		end
	end
end
