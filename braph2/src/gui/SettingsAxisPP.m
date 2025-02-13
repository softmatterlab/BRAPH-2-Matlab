classdef SettingsAxisPP < SettingsPP
	%SettingsAxisPP is the panel with axis settings.
	% It is a subclass of <a href="matlab:help SettingsPP">SettingsPP</a>.
	%
	% A Prop Panel for Axis Settings (SettingsAxisPP) plots the panel 
	%  for axis settings, including a button for the axis color and 
	%  checkboxes for axis on/off, grid on/off, equal on/off, and tight on/off.
	% It works for all categories.
	%
	% The list of SettingsAxisPP properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the property panel for axis settings.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the property panel for axis settings.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the property panel for axis settings.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the property panel for axis settings.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the property panel for axis settings.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the property panel for axis settings.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the property panel for axis settings.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.
	%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the property panel.
	%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.
	%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
	%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
	%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
	%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the settings position panel.
	%  <strong>26</strong> <strong>TITLE</strong> 	TITLE (gui, string) is the property title.
	%  <strong>27</strong> <strong>LABEL_TITLE</strong> 	LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.
	%  <strong>28</strong> <strong>BUTTON_CB</strong> 	BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].
	%  <strong>29</strong> <strong>GUI_CB</strong> 	GUI_CB (data, item) is the handle to the item figure.
	%  <strong>30</strong> <strong>LISTENER_CB</strong> 	LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.
	%  <strong>31</strong> <strong>BUTTON_CALC</strong> 	BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].
	%  <strong>32</strong> <strong>BUTTON_DEL</strong> 	BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].
	%  <strong>33</strong> <strong>LISTENER_SET</strong> 	LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.
	%  <strong>34</strong> <strong>LISTENER_MEMORIZED</strong> 	LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.
	%  <strong>35</strong> <strong>LISTENER_LOCKED</strong> 	LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.
	%  <strong>36</strong> <strong>ENABLE</strong> 	ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.
	%  <strong>37</strong> <strong>BUTTON_AXISCOLOR</strong> 	BUTTON_AXISCOLOR (evanescent, handle) is the axis color button.
	%  <strong>38</strong> <strong>CHECKBOX_AXIS</strong> 	CHECKBOX_AXIS (evanescent, handle) is the axis checkbox.
	%  <strong>39</strong> <strong>CHECKBOX_GRID</strong> 	CHECKBOX_GRID (evanescent, handle) is the grid checkbox.
	%  <strong>40</strong> <strong>CHECKBOX_EQUAL</strong> 	CHECKBOX_EQUAL (evanescent, handle) is the equal checkbox.
	%  <strong>41</strong> <strong>CHECKBOX_TIGHT</strong> 	CHECKBOX_TIGHT (evanescent, handle) is the tight checkbox.
	%  <strong>42</strong> <strong>CHECKBOX_BOX</strong> 	CHECKBOX_BOX (evanescent, handle) is the box checkbox.
	%
	% SettingsAxisPP methods (constructor):
	%  SettingsAxisPP - constructor
	%
	% SettingsAxisPP methods:
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
	% SettingsAxisPP methods (display):
	%  tostring - string with information about the prop panel for axis settings
	%  disp - displays information about the prop panel for axis settings
	%  tree - displays the tree of the prop panel for axis settings
	%
	% SettingsAxisPP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel for axis settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel for axis settings
	%
	% SettingsAxisPP methods (save/load, Static):
	%  save - saves BRAPH2 prop panel for axis settings as b2 file
	%  load - loads a BRAPH2 prop panel for axis settings from a b2 file
	%
	% SettingsAxisPP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel for axis settings
	%
	% SettingsAxisPP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel for axis settings
	%
	% SettingsAxisPP methods (inspection, Static):
	%  getClass - returns the class of the prop panel for axis settings
	%  getSubclasses - returns all subclasses of SettingsAxisPP
	%  getProps - returns the property list of the prop panel for axis settings
	%  getPropNumber - returns the property number of the prop panel for axis settings
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
	% SettingsAxisPP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsAxisPP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsAxisPP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsAxisPP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsAxisPP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsAxisPP constants</a>.
	%
	%
	% See also SettingsPosition, uicheckbox, uipushbutton.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		ENABLE = 36; %CET: Computational Efficiency Trick
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = 9;
		ENABLE_FORMAT = 4;
		
		BUTTON_AXISCOLOR = 37; %CET: Computational Efficiency Trick
		BUTTON_AXISCOLOR_TAG = 'BUTTON_AXISCOLOR';
		BUTTON_AXISCOLOR_CATEGORY = 7;
		BUTTON_AXISCOLOR_FORMAT = 18;
		
		CHECKBOX_AXIS = 38; %CET: Computational Efficiency Trick
		CHECKBOX_AXIS_TAG = 'CHECKBOX_AXIS';
		CHECKBOX_AXIS_CATEGORY = 7;
		CHECKBOX_AXIS_FORMAT = 18;
		
		CHECKBOX_GRID = 39; %CET: Computational Efficiency Trick
		CHECKBOX_GRID_TAG = 'CHECKBOX_GRID';
		CHECKBOX_GRID_CATEGORY = 7;
		CHECKBOX_GRID_FORMAT = 18;
		
		CHECKBOX_EQUAL = 40; %CET: Computational Efficiency Trick
		CHECKBOX_EQUAL_TAG = 'CHECKBOX_EQUAL';
		CHECKBOX_EQUAL_CATEGORY = 7;
		CHECKBOX_EQUAL_FORMAT = 18;
		
		CHECKBOX_TIGHT = 41; %CET: Computational Efficiency Trick
		CHECKBOX_TIGHT_TAG = 'CHECKBOX_TIGHT';
		CHECKBOX_TIGHT_CATEGORY = 7;
		CHECKBOX_TIGHT_FORMAT = 18;
		
		CHECKBOX_BOX = 42; %CET: Computational Efficiency Trick
		CHECKBOX_BOX_TAG = 'CHECKBOX_BOX';
		CHECKBOX_BOX_CATEGORY = 7;
		CHECKBOX_BOX_FORMAT = 18;
	end
	methods % constructor
		function pr = SettingsAxisPP(varargin)
			%SettingsAxisPP() creates a prop panel for axis settings.
			%
			% SettingsAxisPP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsAxisPP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SettingsAxisPP properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the property panel for axis settings.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the property panel for axis settings.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the property panel for axis settings.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the property panel for axis settings.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the property panel for axis settings.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the property panel for axis settings.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the property panel for axis settings.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.
			%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the property panel.
			%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.
			%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
			%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
			%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
			%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the settings position panel.
			%  <strong>26</strong> <strong>TITLE</strong> 	TITLE (gui, string) is the property title.
			%  <strong>27</strong> <strong>LABEL_TITLE</strong> 	LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.
			%  <strong>28</strong> <strong>BUTTON_CB</strong> 	BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].
			%  <strong>29</strong> <strong>GUI_CB</strong> 	GUI_CB (data, item) is the handle to the item figure.
			%  <strong>30</strong> <strong>LISTENER_CB</strong> 	LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.
			%  <strong>31</strong> <strong>BUTTON_CALC</strong> 	BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].
			%  <strong>32</strong> <strong>BUTTON_DEL</strong> 	BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].
			%  <strong>33</strong> <strong>LISTENER_SET</strong> 	LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.
			%  <strong>34</strong> <strong>LISTENER_MEMORIZED</strong> 	LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.
			%  <strong>35</strong> <strong>LISTENER_LOCKED</strong> 	LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.
			%  <strong>36</strong> <strong>ENABLE</strong> 	ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.
			%  <strong>37</strong> <strong>BUTTON_AXISCOLOR</strong> 	BUTTON_AXISCOLOR (evanescent, handle) is the axis color button.
			%  <strong>38</strong> <strong>CHECKBOX_AXIS</strong> 	CHECKBOX_AXIS (evanescent, handle) is the axis checkbox.
			%  <strong>39</strong> <strong>CHECKBOX_GRID</strong> 	CHECKBOX_GRID (evanescent, handle) is the grid checkbox.
			%  <strong>40</strong> <strong>CHECKBOX_EQUAL</strong> 	CHECKBOX_EQUAL (evanescent, handle) is the equal checkbox.
			%  <strong>41</strong> <strong>CHECKBOX_TIGHT</strong> 	CHECKBOX_TIGHT (evanescent, handle) is the tight checkbox.
			%  <strong>42</strong> <strong>CHECKBOX_BOX</strong> 	CHECKBOX_BOX (evanescent, handle) is the box checkbox.
			%
			% See also Category, Format.
			
			pr = pr@SettingsPP(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the prop panel for axis settings.
			%
			% BUILD = SettingsAxisPP.GETBUILD() returns the build of 'SettingsAxisPP'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the prop panel for axis settings PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('SettingsAxisPP') returns the build of 'SettingsAxisPP'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('SettingsAxisPP')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the prop panel for axis settings.
			%
			% CLASS = SettingsAxisPP.GETCLASS() returns the class 'SettingsAxisPP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel for axis settings PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SettingsAxisPP') returns 'SettingsAxisPP'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SettingsAxisPP')
			%  are less computationally efficient.
			
			pr_class = 'SettingsAxisPP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel for axis settings.
			%
			% LIST = SettingsAxisPP.GETSUBCLASSES() returns all subclasses of 'SettingsAxisPP'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel for axis settings PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SettingsAxisPP') returns all subclasses of 'SettingsAxisPP'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SettingsAxisPP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel for axis settings.
			%
			% PROPS = SettingsAxisPP.GETPROPS() returns the property list of prop panel for axis settings
			%  as a row vector.
			%
			% PROPS = SettingsAxisPP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel for axis settings PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SettingsAxisPP'[, CATEGORY]) returns the property list of 'SettingsAxisPP'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SettingsAxisPP')
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
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 23 24 29];
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 20 21 22];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 27 28 30 31 32 33 34 35 37 38 39 40 41 42];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel for axis settings.
			%
			% N = SettingsAxisPP.GETPROPNUMBER() returns the property number of prop panel for axis settings.
			%
			% N = SettingsAxisPP.GETPROPNUMBER(CATEGORY) returns the property number of prop panel for axis settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel for axis settings PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SettingsAxisPP') returns the property number of 'SettingsAxisPP'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SettingsAxisPP')
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
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 4;
				case 6 % Category.QUERY
					prop_number = 10;
				case 7 % Category.EVANESCENT
					prop_number = 16;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 5;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel for axis settings/error.
			%
			% CHECK = SettingsAxisPP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SettingsAxisPP, PROP) checks whether PROP exists for SettingsAxisPP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsAxisPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAxisPP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAxisPP:WrongInput]
			%  Element.EXISTSPROP(SettingsAxisPP, PROP) throws error if PROP does NOT exist for SettingsAxisPP.
			%   Error id: [BRAPH2:SettingsAxisPP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 42 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsAxisPP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsAxisPP:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsAxisPP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel for axis settings/error.
			%
			% CHECK = SettingsAxisPP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SettingsAxisPP, TAG) checks whether TAG exists for SettingsAxisPP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsAxisPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAxisPP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAxisPP:WrongInput]
			%  Element.EXISTSTAG(SettingsAxisPP, TAG) throws error if TAG does NOT exist for SettingsAxisPP.
			%   Error id: [BRAPH2:SettingsAxisPP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'BUTTON_AXISCOLOR'  'CHECKBOX_AXIS'  'CHECKBOX_GRID'  'CHECKBOX_EQUAL'  'CHECKBOX_TIGHT'  'CHECKBOX_BOX' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsAxisPP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsAxisPP:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SettingsAxisPP.'] ...
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
			%  PROPERTY = PR.GETPROPPROP(POINTER) returns property number of POINTER of PR.
			%  PROPERTY = Element.GETPROPPROP(SettingsAxisPP, POINTER) returns property number of POINTER of SettingsAxisPP.
			%  PROPERTY = PR.GETPROPPROP(SettingsAxisPP, POINTER) returns property number of POINTER of SettingsAxisPP.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'BUTTON_AXISCOLOR'  'CHECKBOX_AXIS'  'CHECKBOX_GRID'  'CHECKBOX_EQUAL'  'CHECKBOX_TIGHT'  'CHECKBOX_BOX' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = PR.GETPROPTAG(POINTER) returns tag of POINTER of PR.
			%  TAG = Element.GETPROPTAG(SettingsAxisPP, POINTER) returns tag of POINTER of SettingsAxisPP.
			%  TAG = PR.GETPROPTAG(SettingsAxisPP, POINTER) returns tag of POINTER of SettingsAxisPP.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				settingsaxispp_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'BUTTON_AXISCOLOR'  'CHECKBOX_AXIS'  'CHECKBOX_GRID'  'CHECKBOX_EQUAL'  'CHECKBOX_TIGHT'  'CHECKBOX_BOX' };
				tag = settingsaxispp_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = PR.GETPROPCATEGORY(POINTER) returns category of POINTER of PR.
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsAxisPP, POINTER) returns category of POINTER of SettingsAxisPP.
			%  CATEGORY = PR.GETPROPCATEGORY(SettingsAxisPP, POINTER) returns category of POINTER of SettingsAxisPP.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAxisPP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsaxispp_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  7  7  7  7  7  7 };
			prop_category = settingsaxispp_category_list{prop};
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
			%  FORMAT = PR.GETPROPFORMAT(POINTER) returns format of POINTER of PR.
			%  FORMAT = Element.GETPROPFORMAT(SettingsAxisPP, POINTER) returns format of POINTER of SettingsAxisPP.
			%  FORMAT = PR.GETPROPFORMAT(SettingsAxisPP, POINTER) returns format of POINTER of SettingsAxisPP.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAxisPP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsaxispp_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  4  18  18  18  18  18  18 };
			prop_format = settingsaxispp_format_list{prop};
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
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsAxisPP, POINTER) returns description of POINTER of SettingsAxisPP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SettingsAxisPP, POINTER) returns description of POINTER of SettingsAxisPP.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAxisPP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsaxispp_description_list = { 'ELCLASS (constant, string) is the class of the property panel for axis settings.'  'NAME (constant, string) is the name of the property panel for axis settings.'  'DESCRIPTION (constant, string) is the description of the property panel for axis settings.'  'TEMPLATE (parameter, item) is the template of the property panel for axis settings.'  'ID (data, string) is a few-letter code for the property panel for axis settings.'  'LABEL (metadata, string) is an extended label of the property panel for axis settings.'  'NOTES (metadata, string) are some specific notes about the property panel for axis settings.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the settings position panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.'  'BUTTON_AXISCOLOR (evanescent, handle) is the axis color button.'  'CHECKBOX_AXIS (evanescent, handle) is the axis checkbox.'  'CHECKBOX_GRID (evanescent, handle) is the grid checkbox.'  'CHECKBOX_EQUAL (evanescent, handle) is the equal checkbox.'  'CHECKBOX_TIGHT (evanescent, handle) is the tight checkbox.'  'CHECKBOX_BOX (evanescent, handle) is the box checkbox.' };
			prop_description = settingsaxispp_description_list{prop};
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
			%  SETTINGS = PR.GETPROPSETTINGS(POINTER) returns settings of POINTER of PR.
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsAxisPP, POINTER) returns settings of POINTER of SettingsAxisPP.
			%  SETTINGS = PR.GETPROPSETTINGS(SettingsAxisPP, POINTER) returns settings of POINTER of SettingsAxisPP.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAxisPP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % SettingsAxisPP.ENABLE
					prop_settings = Format.getFormatSettings(4);
				case 37 % SettingsAxisPP.BUTTON_AXISCOLOR
					prop_settings = Format.getFormatSettings(18);
				case 38 % SettingsAxisPP.CHECKBOX_AXIS
					prop_settings = Format.getFormatSettings(18);
				case 39 % SettingsAxisPP.CHECKBOX_GRID
					prop_settings = Format.getFormatSettings(18);
				case 40 % SettingsAxisPP.CHECKBOX_EQUAL
					prop_settings = Format.getFormatSettings(18);
				case 41 % SettingsAxisPP.CHECKBOX_TIGHT
					prop_settings = Format.getFormatSettings(18);
				case 42 % SettingsAxisPP.CHECKBOX_BOX
					prop_settings = Format.getFormatSettings(18);
				case 4 % SettingsAxisPP.TEMPLATE
					prop_settings = 'SettingsAxisPP';
				otherwise
					prop_settings = getPropSettings@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsAxisPP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAxisPP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsAxisPP, POINTER) returns the default value of POINTER of SettingsAxisPP.
			%  DEFAULT = PR.GETPROPDEFAULT(SettingsAxisPP, POINTER) returns the default value of POINTER of SettingsAxisPP.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsAxisPP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % SettingsAxisPP.ENABLE
					prop_default = true;
				case 37 % SettingsAxisPP.BUTTON_AXISCOLOR
					prop_default = Format.getFormatDefault(18, SettingsAxisPP.getPropSettings(prop));
				case 38 % SettingsAxisPP.CHECKBOX_AXIS
					prop_default = Format.getFormatDefault(18, SettingsAxisPP.getPropSettings(prop));
				case 39 % SettingsAxisPP.CHECKBOX_GRID
					prop_default = Format.getFormatDefault(18, SettingsAxisPP.getPropSettings(prop));
				case 40 % SettingsAxisPP.CHECKBOX_EQUAL
					prop_default = Format.getFormatDefault(18, SettingsAxisPP.getPropSettings(prop));
				case 41 % SettingsAxisPP.CHECKBOX_TIGHT
					prop_default = Format.getFormatDefault(18, SettingsAxisPP.getPropSettings(prop));
				case 42 % SettingsAxisPP.CHECKBOX_BOX
					prop_default = Format.getFormatDefault(18, SettingsAxisPP.getPropSettings(prop));
				case 1 % SettingsAxisPP.ELCLASS
					prop_default = 'SettingsAxisPP';
				case 2 % SettingsAxisPP.NAME
					prop_default = 'Prop Panel for Axis Settings';
				case 3 % SettingsAxisPP.DESCRIPTION
					prop_default = 'A Prop Panel for Axis Settings (SettingsAxisPP) plots the panel for axis settings, including a button for the axis color and checkboxes for axis on/off, grid on/off, equal on/off, and tight on/off. It works for all categories.';
				case 4 % SettingsAxisPP.TEMPLATE
					prop_default = Format.getFormatDefault(8, SettingsAxisPP.getPropSettings(prop));
				case 5 % SettingsAxisPP.ID
					prop_default = 'SettingsAxisPP ID';
				case 6 % SettingsAxisPP.LABEL
					prop_default = 'SettingsAxisPP label';
				case 7 % SettingsAxisPP.NOTES
					prop_default = 'SettingsAxisPP notes';
				case 23 % SettingsAxisPP.EL
					prop_default = BrainSurfacePF();
				case 24 % SettingsAxisPP.PROP
					prop_default = 25;
				case 25 % SettingsAxisPP.HEIGHT
					prop_default = 66;
				otherwise
					prop_default = getPropDefault@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsAxisPP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAxisPP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsAxisPP, POINTER) returns the conditioned default value of POINTER of SettingsAxisPP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SettingsAxisPP, POINTER) returns the conditioned default value of POINTER of SettingsAxisPP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsAxisPP.getPropProp(pointer);
			
			prop_default = SettingsAxisPP.conditioning(prop, SettingsAxisPP.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PR.
			%  CHECK = Element.CHECKPROP(SettingsAxisPP, PROP, VALUE) checks VALUE format for PROP of SettingsAxisPP.
			%  CHECK = PR.CHECKPROP(SettingsAxisPP, PROP, VALUE) checks VALUE format for PROP of SettingsAxisPP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SettingsAxisPP:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:SettingsAxisPP:WrongInput
			%  Element.CHECKPROP(SettingsAxisPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAxisPP.
			%   Error id: BRAPH2:SettingsAxisPP:WrongInput
			%  PR.CHECKPROP(SettingsAxisPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAxisPP.
			%   Error id: BRAPH2:SettingsAxisPP:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsAxisPP.getPropProp(pointer);
			
			switch prop
				case 36 % SettingsAxisPP.ENABLE
					check = Format.checkFormat(4, value, SettingsAxisPP.getPropSettings(prop));
				case 37 % SettingsAxisPP.BUTTON_AXISCOLOR
					check = Format.checkFormat(18, value, SettingsAxisPP.getPropSettings(prop));
				case 38 % SettingsAxisPP.CHECKBOX_AXIS
					check = Format.checkFormat(18, value, SettingsAxisPP.getPropSettings(prop));
				case 39 % SettingsAxisPP.CHECKBOX_GRID
					check = Format.checkFormat(18, value, SettingsAxisPP.getPropSettings(prop));
				case 40 % SettingsAxisPP.CHECKBOX_EQUAL
					check = Format.checkFormat(18, value, SettingsAxisPP.getPropSettings(prop));
				case 41 % SettingsAxisPP.CHECKBOX_TIGHT
					check = Format.checkFormat(18, value, SettingsAxisPP.getPropSettings(prop));
				case 42 % SettingsAxisPP.CHECKBOX_BOX
					check = Format.checkFormat(18, value, SettingsAxisPP.getPropSettings(prop));
				case 4 % SettingsAxisPP.TEMPLATE
					check = Format.checkFormat(8, value, SettingsAxisPP.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@SettingsPP(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsAxisPP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsAxisPP:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsAxisPP.getPropTag(prop) ' (' SettingsAxisPP.getFormatTag(SettingsAxisPP.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pr, prop, varargin)
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
				case 37 % SettingsAxisPP.BUTTON_AXISCOLOR
					el = pr.get('EL');
					prop = pr.get('PROP');
					button_axiscolor = uibutton( ...
					    'Parent', pr.memorize('H'), ...
						'Tag', 'BUTTON_AXISCOLOR', ...
						'Text', '', ...
						'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('AXISCOLOR')) ' ' el.get(prop).getPropDescription('AXISCOLOR')], ...
						'ButtonPushedFcn', {@cb_button_axiscolor}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
						);
					value = button_axiscolor;
					
				case 38 % SettingsAxisPP.CHECKBOX_AXIS
					el = pr.get('EL');
					prop = pr.get('PROP');
					checkbox_axis = uicheckbox( ...
					    'Parent', pr.memorize('H'), ...
						'Tag', 'CHECKBOX_AXIS', ...
					    'Text', 'axis', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('AXIS')) ' ' el.get(prop).getPropDescription('AXIS')], ...
					    'ValueChangedFcn', {@cb_axis} ...
					    );
					value = checkbox_axis;
					
				case 39 % SettingsAxisPP.CHECKBOX_GRID
					el = pr.get('EL');
					prop = pr.get('PROP');
					checkbox_grid = uicheckbox( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'CHECKBOX_GRID', ...
					    'Text', 'grid', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('GRID')) ' ' el.get(prop).getPropDescription('GRID')], ...
					    'ValueChangedFcn', {@cb_axis} ... % callback in CHECKBOX_AXIS
					    );
					value = checkbox_grid;
					
				case 40 % SettingsAxisPP.CHECKBOX_EQUAL
					el = pr.get('EL');
					prop = pr.get('PROP');
					checkbox_equal = uicheckbox( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'CHECKBOX_EQUAL', ...
					    'Text', 'equal', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('EQUAL')) ' ' el.get(prop).getPropDescription('EQUAL')], ...
					    'ValueChangedFcn', {@cb_axis} ... % callback in CHECKBOX_AXIS
					    );
					value = checkbox_equal;
					
				case 41 % SettingsAxisPP.CHECKBOX_TIGHT
					el = pr.get('EL');
					prop = pr.get('PROP');
					checkbox_tight = uicheckbox( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'CHECKBOX_TIGHT', ...
					    'Text', 'tight', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('TIGHT')) ' ' el.get(prop).getPropDescription('TIGHT')], ...
					    'ValueChangedFcn', {@cb_axis} ... % callback in CHECKBOX_AXIS
					    );
					value = checkbox_tight;
					
				case 42 % SettingsAxisPP.CHECKBOX_BOX
					el = pr.get('EL');
					prop = pr.get('PROP');
					checkbox_box = uicheckbox( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'CHECKBOX_BOX', ...
					    'Text', 'box', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('BOX')) ' ' el.get(prop).getPropDescription('BOX')], ...
					    'ValueChangedFcn', {@cb_axis} ... % callback in CHECKBOX_AXIS
					    );
					value = checkbox_box;
					
				case 20 % SettingsAxisPP.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('BUTTON_AXISCOLOR')
					    pr.memorize('CHECKBOX_AXIS')
					    pr.memorize('CHECKBOX_GRID')
					    pr.memorize('CHECKBOX_EQUAL')
					    pr.memorize('CHECKBOX_TIGHT')
					    pr.memorize('CHECKBOX_BOX')
					end
					
				case 21 % SettingsAxisPP.UPDATE
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value
					
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if el.isLocked(prop)
					        set(pr.get('BUTTON_AXISCOLOR'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('CHECKBOX_AXIS'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('CHECKBOX_GRID'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('CHECKBOX_EQUAL'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('CHECKBOX_TIGHT'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('CHECKBOX_BOX'), 'Enable', pr.get('ENABLE'))
					    end
					
					    switch el.getPropCategory(prop)
					        case 2
					            set(pr.get('BUTTON_AXISCOLOR'), 'BackgroundColor', el.get(prop).get('AXISCOLOR'))
					            set(pr.get('CHECKBOX_AXIS'), 'Value', el.get(prop).get('AXIS'))
					            set(pr.get('CHECKBOX_GRID'), 'Value', el.get(prop).get('GRID'))
					            set(pr.get('CHECKBOX_EQUAL'), 'Value', el.get(prop).get('EQUAL'))
					            set(pr.get('CHECKBOX_TIGHT'), 'Value', el.get(prop).get('TIGHT'))
					            set(pr.get('CHECKBOX_BOX'), 'Value', el.get(prop).get('BOX'))
					
					        case {3, 4, 8, 9}
					            set(pr.get('BUTTON_AXISCOLOR'), 'BackgroundColor', el.get(prop).get('AXISCOLOR'))
					            set(pr.get('CHECKBOX_AXIS'), 'Value', el.get(prop).get('AXIS'))
					            set(pr.get('CHECKBOX_GRID'), 'Value', el.get(prop).get('GRID'))
					            set(pr.get('CHECKBOX_EQUAL'), 'Value', el.get(prop).get('EQUAL'))
					            set(pr.get('CHECKBOX_TIGHT'), 'Value', el.get(prop).get('TIGHT'))
					            set(pr.get('CHECKBOX_BOX'), 'Value', el.get(prop).get('BOX'))
					
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('AXISCOLOR'), 'Callback')
					                set(pr.get('BUTTON_AXISCOLOR'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('AXIS'), 'Callback')
					                set(pr.get('CHECKBOX_AXIS'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('GRID'), 'Callback')
					                set(pr.get('CHECKBOX_GRID'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('EQUAL'), 'Callback')
					                set(pr.get('CHECKBOX_EQUAL'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('TIGHT'), 'Callback')
					                set(pr.get('CHECKBOX_TIGHT'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('BOX'), 'Callback')
					                set(pr.get('CHECKBOX_BOX'), 'Enable', pr.get('ENABLE'))
					            end
					            
					        case 5
					            value = el.getr(prop);
					
					            if isa(value, 'NoValue')
					                set(pr.get('BUTTON_AXISCOLOR'), ...
					                    'BackgroundColor', el.get(prop).getPropDefault('AXISCOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_AXIS'), ...
					                    'Value', el.get(prop).getPropDefault('AXIS'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_GRID'), ...
					                    'Value', el.get(prop).getPropDefault('GRID'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_EQUAL'), ...
					                    'Value', el.get(prop).getPropDefault('EQUAL'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_TIGHT'), ...
					                    'Value', el.get(prop).getPropDefault('TIGHT'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_BOX'), ...
					                    'Value', el.get(prop).getPropDefault('BOX'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            else
					                set(pr.get('BUTTON_AXISCOLOR'), ...
					                    'BackgroundColor', el.get(prop).get('AXISCOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_AXIS'), ...
					                    'Value', el.get(prop).get('AXIS'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_GRID'), ...
					                    'Value', el.get(prop).get('GRID'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_EQUAL'), ...
					                    'Value', el.get(prop).get('EQUAL'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_TIGHT'), ...
					                    'Value', el.get(prop).get('TIGHT'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_BOX'), ...
					                    'Value', el.get(prop).get('BOX'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					    end
					end
					
				case 22 % SettingsAxisPP.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('BUTTON_AXISCOLOR'), 'Position', [11+.60*w_p 28 .30*w_p 21])
					    set(pr.get('CHECKBOX_AXIS'), 'Position', [4 28 .30*w_p 21])
					    set(pr.get('CHECKBOX_GRID'), 'Position', [8+.30*w_p 28 .30*w_p 21])
					    set(pr.get('CHECKBOX_EQUAL'), 'Position', [4 4 .30*w_p 21])
					    set(pr.get('CHECKBOX_TIGHT'), 'Position', [8+.30*w_p 4 .30*w_p 21])
					    set(pr.get('CHECKBOX_BOX'), 'Position', [8+.60*w_p 4 .30*w_p 21])
					end
					
				case 18 % SettingsAxisPP.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('BUTTON_AXISCOLOR', Element.getNoValue())
					    pr.set('CHECKBOX_AXIS', Element.getNoValue())
					    pr.set('CHECKBOX_GRID', Element.getNoValue())
					    pr.set('CHECKBOX_EQUAL', Element.getNoValue())
					    pr.set('CHECKBOX_TIGHT', Element.getNoValue())
					    pr.set('CHECKBOX_BOX', Element.getNoValue())
					end
					
				otherwise
					if prop <= 35
						value = calculateValue@SettingsPP(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_button_axiscolor(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    new_color = uisetcolor(el.get(prop).get('AXISCOLOR'));
			    if ~isequal(new_color, el.get(prop).get('AXISCOLOR'))
			        el.get(prop).set('AXISCOLOR', new_color)
			
			        pr.get('UPDATE')
			    end
			end
			function cb_axis(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set( ...
			        'AXIS', get(pr.get('CHECKBOX_AXIS'), 'Value'), ...
			        'GRID', get(pr.get('CHECKBOX_GRID'), 'Value'), ...
			        'EQUAL', get(pr.get('CHECKBOX_EQUAL'), 'Value'), ...
			        'TIGHT', get(pr.get('CHECKBOX_TIGHT'), 'Value'), ...
			        'BOX', get(pr.get('CHECKBOX_BOX'), 'Value') ...
			        )
			
			end
		end
	end
end
