classdef SettingsLinePP < SettingsPP
	%SettingsLinePP is the panel with line settings.
	% It is a subclass of <a href="matlab:help SettingsPP">SettingsPP</a>.
	%
	% A Prop Panel for Line Settings (SettingsLinePP) plots the panel for 
	%  line settings, including visibility, line style, size and color, 
	%  and symbol style, size, edge color, and face color.
	% It works for all categories.
	%
	% The list of SettingsLinePP properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the property panel for line settings.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the property panel for line settings.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the property panel for line settings.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the property panel for line settings.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the property panel for line settings.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the property panel for line settings.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the property panel for line settings.
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
	%  <strong>37</strong> <strong>CHECKBOX_VISIBLE</strong> 	CHECKBOX_VISIBLE (evanescent, handle) determines whether the line is visible.
	%  <strong>38</strong> <strong>DROPDOWN_LINESTYLE</strong> 	DROPDOWN_LINESTYLE (evanescent, handle) is the line style dropdown.
	%  <strong>39</strong> <strong>EDITFIELD_LINEWIDTH</strong> 	EDITFIELD_LINEWIDTH (evanescent, handle) is the line width edit field.
	%  <strong>40</strong> <strong>BUTTON_LINECOLOR</strong> 	BUTTON_LINECOLOR (evanescent, handle) is the line color button.
	%  <strong>41</strong> <strong>DROPDOWN_SYMBOL</strong> 	DROPDOWN_SYMBOL (evanescent, handle) is the marker value dropdown.
	%  <strong>42</strong> <strong>EDITFIELD_SYMBOLSIZE</strong> 	EDITFIELD_SYMBOLSIZE (evanescent, handle) is the symbol size edit field.
	%  <strong>43</strong> <strong>BUTTON_FACECOLOR</strong> 	BUTTON_FACECOLOR (evanescent, handle) is the marker face color button.
	%  <strong>44</strong> <strong>BUTTON_EDGECOLOR</strong> 	BUTTON_EDGECOLOR (evanescent, handle) is the marker edge color button.
	%
	% SettingsLinePP methods (constructor):
	%  SettingsLinePP - constructor
	%
	% SettingsLinePP methods:
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
	% SettingsLinePP methods (display):
	%  tostring - string with information about the prop panel for line settings
	%  disp - displays information about the prop panel for line settings
	%  tree - displays the tree of the prop panel for line settings
	%
	% SettingsLinePP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel for line settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel for line settings
	%
	% SettingsLinePP methods (save/load, Static):
	%  save - saves BRAPH2 prop panel for line settings as b2 file
	%  load - loads a BRAPH2 prop panel for line settings from a b2 file
	%
	% SettingsLinePP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel for line settings
	%
	% SettingsLinePP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel for line settings
	%
	% SettingsLinePP methods (inspection, Static):
	%  getClass - returns the class of the prop panel for line settings
	%  getSubclasses - returns all subclasses of SettingsLinePP
	%  getProps - returns the property list of the prop panel for line settings
	%  getPropNumber - returns the property number of the prop panel for line settings
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
	% SettingsLinePP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsLinePP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsLinePP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsLinePP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsLinePP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsLinePP constants</a>.
	%
	%
	% See also SettingsLine, uicheckbox, uidropdown, uieditfield, uipushbutton.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		ENABLE = 36; %CET: Computational Efficiency Trick
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = 9;
		ENABLE_FORMAT = 4;
		
		CHECKBOX_VISIBLE = 37; %CET: Computational Efficiency Trick
		CHECKBOX_VISIBLE_TAG = 'CHECKBOX_VISIBLE';
		CHECKBOX_VISIBLE_CATEGORY = 7;
		CHECKBOX_VISIBLE_FORMAT = 18;
		
		DROPDOWN_LINESTYLE = 38; %CET: Computational Efficiency Trick
		DROPDOWN_LINESTYLE_TAG = 'DROPDOWN_LINESTYLE';
		DROPDOWN_LINESTYLE_CATEGORY = 7;
		DROPDOWN_LINESTYLE_FORMAT = 18;
		
		EDITFIELD_LINEWIDTH = 39; %CET: Computational Efficiency Trick
		EDITFIELD_LINEWIDTH_TAG = 'EDITFIELD_LINEWIDTH';
		EDITFIELD_LINEWIDTH_CATEGORY = 7;
		EDITFIELD_LINEWIDTH_FORMAT = 18;
		
		BUTTON_LINECOLOR = 40; %CET: Computational Efficiency Trick
		BUTTON_LINECOLOR_TAG = 'BUTTON_LINECOLOR';
		BUTTON_LINECOLOR_CATEGORY = 7;
		BUTTON_LINECOLOR_FORMAT = 18;
		
		DROPDOWN_SYMBOL = 41; %CET: Computational Efficiency Trick
		DROPDOWN_SYMBOL_TAG = 'DROPDOWN_SYMBOL';
		DROPDOWN_SYMBOL_CATEGORY = 7;
		DROPDOWN_SYMBOL_FORMAT = 18;
		
		EDITFIELD_SYMBOLSIZE = 42; %CET: Computational Efficiency Trick
		EDITFIELD_SYMBOLSIZE_TAG = 'EDITFIELD_SYMBOLSIZE';
		EDITFIELD_SYMBOLSIZE_CATEGORY = 7;
		EDITFIELD_SYMBOLSIZE_FORMAT = 18;
		
		BUTTON_FACECOLOR = 43; %CET: Computational Efficiency Trick
		BUTTON_FACECOLOR_TAG = 'BUTTON_FACECOLOR';
		BUTTON_FACECOLOR_CATEGORY = 7;
		BUTTON_FACECOLOR_FORMAT = 18;
		
		BUTTON_EDGECOLOR = 44; %CET: Computational Efficiency Trick
		BUTTON_EDGECOLOR_TAG = 'BUTTON_EDGECOLOR';
		BUTTON_EDGECOLOR_CATEGORY = 7;
		BUTTON_EDGECOLOR_FORMAT = 18;
	end
	methods % constructor
		function pr = SettingsLinePP(varargin)
			%SettingsLinePP() creates a prop panel for line settings.
			%
			% SettingsLinePP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsLinePP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SettingsLinePP properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the property panel for line settings.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the property panel for line settings.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the property panel for line settings.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the property panel for line settings.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the property panel for line settings.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the property panel for line settings.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the property panel for line settings.
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
			%  <strong>37</strong> <strong>CHECKBOX_VISIBLE</strong> 	CHECKBOX_VISIBLE (evanescent, handle) determines whether the line is visible.
			%  <strong>38</strong> <strong>DROPDOWN_LINESTYLE</strong> 	DROPDOWN_LINESTYLE (evanescent, handle) is the line style dropdown.
			%  <strong>39</strong> <strong>EDITFIELD_LINEWIDTH</strong> 	EDITFIELD_LINEWIDTH (evanescent, handle) is the line width edit field.
			%  <strong>40</strong> <strong>BUTTON_LINECOLOR</strong> 	BUTTON_LINECOLOR (evanescent, handle) is the line color button.
			%  <strong>41</strong> <strong>DROPDOWN_SYMBOL</strong> 	DROPDOWN_SYMBOL (evanescent, handle) is the marker value dropdown.
			%  <strong>42</strong> <strong>EDITFIELD_SYMBOLSIZE</strong> 	EDITFIELD_SYMBOLSIZE (evanescent, handle) is the symbol size edit field.
			%  <strong>43</strong> <strong>BUTTON_FACECOLOR</strong> 	BUTTON_FACECOLOR (evanescent, handle) is the marker face color button.
			%  <strong>44</strong> <strong>BUTTON_EDGECOLOR</strong> 	BUTTON_EDGECOLOR (evanescent, handle) is the marker edge color button.
			%
			% See also Category, Format.
			
			pr = pr@SettingsPP(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the prop panel for line settings.
			%
			% BUILD = SettingsLinePP.GETBUILD() returns the build of 'SettingsLinePP'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the prop panel for line settings PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('SettingsLinePP') returns the build of 'SettingsLinePP'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('SettingsLinePP')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the prop panel for line settings.
			%
			% CLASS = SettingsLinePP.GETCLASS() returns the class 'SettingsLinePP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel for line settings PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SettingsLinePP') returns 'SettingsLinePP'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SettingsLinePP')
			%  are less computationally efficient.
			
			pr_class = 'SettingsLinePP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel for line settings.
			%
			% LIST = SettingsLinePP.GETSUBCLASSES() returns all subclasses of 'SettingsLinePP'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel for line settings PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SettingsLinePP') returns all subclasses of 'SettingsLinePP'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SettingsLinePP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel for line settings.
			%
			% PROPS = SettingsLinePP.GETPROPS() returns the property list of prop panel for line settings
			%  as a row vector.
			%
			% PROPS = SettingsLinePP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel for line settings PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SettingsLinePP'[, CATEGORY]) returns the property list of 'SettingsLinePP'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44];
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
					prop_list = [10 15 27 28 30 31 32 33 34 35 37 38 39 40 41 42 43 44];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel for line settings.
			%
			% N = SettingsLinePP.GETPROPNUMBER() returns the property number of prop panel for line settings.
			%
			% N = SettingsLinePP.GETPROPNUMBER(CATEGORY) returns the property number of prop panel for line settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel for line settings PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SettingsLinePP') returns the property number of 'SettingsLinePP'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 44;
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
					prop_number = 18;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 5;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel for line settings/error.
			%
			% CHECK = SettingsLinePP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SettingsLinePP, PROP) checks whether PROP exists for SettingsLinePP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsLinePP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsLinePP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsLinePP:WrongInput]
			%  Element.EXISTSPROP(SettingsLinePP, PROP) throws error if PROP does NOT exist for SettingsLinePP.
			%   Error id: [BRAPH2:SettingsLinePP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 44 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsLinePP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsLinePP:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsLinePP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel for line settings/error.
			%
			% CHECK = SettingsLinePP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SettingsLinePP, TAG) checks whether TAG exists for SettingsLinePP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsLinePP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsLinePP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsLinePP:WrongInput]
			%  Element.EXISTSTAG(SettingsLinePP, TAG) throws error if TAG does NOT exist for SettingsLinePP.
			%   Error id: [BRAPH2:SettingsLinePP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'CHECKBOX_VISIBLE'  'DROPDOWN_LINESTYLE'  'EDITFIELD_LINEWIDTH'  'BUTTON_LINECOLOR'  'DROPDOWN_SYMBOL'  'EDITFIELD_SYMBOLSIZE'  'BUTTON_FACECOLOR'  'BUTTON_EDGECOLOR' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsLinePP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsLinePP:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SettingsLinePP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsLinePP, POINTER) returns property number of POINTER of SettingsLinePP.
			%  PROPERTY = PR.GETPROPPROP(SettingsLinePP, POINTER) returns property number of POINTER of SettingsLinePP.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'CHECKBOX_VISIBLE'  'DROPDOWN_LINESTYLE'  'EDITFIELD_LINEWIDTH'  'BUTTON_LINECOLOR'  'DROPDOWN_SYMBOL'  'EDITFIELD_SYMBOLSIZE'  'BUTTON_FACECOLOR'  'BUTTON_EDGECOLOR' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(SettingsLinePP, POINTER) returns tag of POINTER of SettingsLinePP.
			%  TAG = PR.GETPROPTAG(SettingsLinePP, POINTER) returns tag of POINTER of SettingsLinePP.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				settingslinepp_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'CHECKBOX_VISIBLE'  'DROPDOWN_LINESTYLE'  'EDITFIELD_LINEWIDTH'  'BUTTON_LINECOLOR'  'DROPDOWN_SYMBOL'  'EDITFIELD_SYMBOLSIZE'  'BUTTON_FACECOLOR'  'BUTTON_EDGECOLOR' };
				tag = settingslinepp_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsLinePP, POINTER) returns category of POINTER of SettingsLinePP.
			%  CATEGORY = PR.GETPROPCATEGORY(SettingsLinePP, POINTER) returns category of POINTER of SettingsLinePP.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsLinePP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingslinepp_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  7  7  7  7  7  7  7  7 };
			prop_category = settingslinepp_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsLinePP, POINTER) returns format of POINTER of SettingsLinePP.
			%  FORMAT = PR.GETPROPFORMAT(SettingsLinePP, POINTER) returns format of POINTER of SettingsLinePP.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsLinePP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingslinepp_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  4  18  18  18  18  18  18  18  18 };
			prop_format = settingslinepp_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsLinePP, POINTER) returns description of POINTER of SettingsLinePP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SettingsLinePP, POINTER) returns description of POINTER of SettingsLinePP.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsLinePP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingslinepp_description_list = { 'ELCLASS (constant, string) is the class of the property panel for line settings.'  'NAME (constant, string) is the name of the property panel for line settings.'  'DESCRIPTION (constant, string) is the description of the property panel for line settings.'  'TEMPLATE (parameter, item) is the template of the property panel for line settings.'  'ID (data, string) is a few-letter code for the property panel for line settings.'  'LABEL (metadata, string) is an extended label of the property panel for line settings.'  'NOTES (metadata, string) are some specific notes about the property panel for line settings.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the settings position panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.'  'CHECKBOX_VISIBLE (evanescent, handle) determines whether the line is visible.'  'DROPDOWN_LINESTYLE (evanescent, handle) is the line style dropdown.'  'EDITFIELD_LINEWIDTH (evanescent, handle) is the line width edit field.'  'BUTTON_LINECOLOR (evanescent, handle) is the line color button.'  'DROPDOWN_SYMBOL (evanescent, handle) is the marker value dropdown.'  'EDITFIELD_SYMBOLSIZE (evanescent, handle) is the symbol size edit field.'  'BUTTON_FACECOLOR (evanescent, handle) is the marker face color button.'  'BUTTON_EDGECOLOR (evanescent, handle) is the marker edge color button.' };
			prop_description = settingslinepp_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsLinePP, POINTER) returns settings of POINTER of SettingsLinePP.
			%  SETTINGS = PR.GETPROPSETTINGS(SettingsLinePP, POINTER) returns settings of POINTER of SettingsLinePP.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsLinePP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % SettingsLinePP.ENABLE
					prop_settings = Format.getFormatSettings(4);
				case 37 % SettingsLinePP.CHECKBOX_VISIBLE
					prop_settings = Format.getFormatSettings(18);
				case 38 % SettingsLinePP.DROPDOWN_LINESTYLE
					prop_settings = Format.getFormatSettings(18);
				case 39 % SettingsLinePP.EDITFIELD_LINEWIDTH
					prop_settings = Format.getFormatSettings(18);
				case 40 % SettingsLinePP.BUTTON_LINECOLOR
					prop_settings = Format.getFormatSettings(18);
				case 41 % SettingsLinePP.DROPDOWN_SYMBOL
					prop_settings = Format.getFormatSettings(18);
				case 42 % SettingsLinePP.EDITFIELD_SYMBOLSIZE
					prop_settings = Format.getFormatSettings(18);
				case 43 % SettingsLinePP.BUTTON_FACECOLOR
					prop_settings = Format.getFormatSettings(18);
				case 44 % SettingsLinePP.BUTTON_EDGECOLOR
					prop_settings = Format.getFormatSettings(18);
				case 4 % SettingsLinePP.TEMPLATE
					prop_settings = 'SettingsLinePP';
				otherwise
					prop_settings = getPropSettings@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsLinePP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsLinePP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsLinePP, POINTER) returns the default value of POINTER of SettingsLinePP.
			%  DEFAULT = PR.GETPROPDEFAULT(SettingsLinePP, POINTER) returns the default value of POINTER of SettingsLinePP.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsLinePP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % SettingsLinePP.ENABLE
					prop_default = true;
				case 37 % SettingsLinePP.CHECKBOX_VISIBLE
					prop_default = Format.getFormatDefault(18, SettingsLinePP.getPropSettings(prop));
				case 38 % SettingsLinePP.DROPDOWN_LINESTYLE
					prop_default = Format.getFormatDefault(18, SettingsLinePP.getPropSettings(prop));
				case 39 % SettingsLinePP.EDITFIELD_LINEWIDTH
					prop_default = Format.getFormatDefault(18, SettingsLinePP.getPropSettings(prop));
				case 40 % SettingsLinePP.BUTTON_LINECOLOR
					prop_default = Format.getFormatDefault(18, SettingsLinePP.getPropSettings(prop));
				case 41 % SettingsLinePP.DROPDOWN_SYMBOL
					prop_default = Format.getFormatDefault(18, SettingsLinePP.getPropSettings(prop));
				case 42 % SettingsLinePP.EDITFIELD_SYMBOLSIZE
					prop_default = Format.getFormatDefault(18, SettingsLinePP.getPropSettings(prop));
				case 43 % SettingsLinePP.BUTTON_FACECOLOR
					prop_default = Format.getFormatDefault(18, SettingsLinePP.getPropSettings(prop));
				case 44 % SettingsLinePP.BUTTON_EDGECOLOR
					prop_default = Format.getFormatDefault(18, SettingsLinePP.getPropSettings(prop));
				case 1 % SettingsLinePP.ELCLASS
					prop_default = 'SettingsLinePP';
				case 2 % SettingsLinePP.NAME
					prop_default = 'Prop Panel for Line Settings';
				case 3 % SettingsLinePP.DESCRIPTION
					prop_default = 'A Prop Panel for Line Settings (SettingsLinePP) plots the panel for line settings, including visibility, line style, size and color, and symbol style, size, edge color, and face color. It works for all categories.';
				case 4 % SettingsLinePP.TEMPLATE
					prop_default = Format.getFormatDefault(8, SettingsLinePP.getPropSettings(prop));
				case 5 % SettingsLinePP.ID
					prop_default = 'SettingsLinePP ID';
				case 6 % SettingsLinePP.LABEL
					prop_default = 'SettingsLinePP label';
				case 7 % SettingsLinePP.NOTES
					prop_default = 'SettingsLinePP notes';
				case 23 % SettingsLinePP.EL
					prop_default = GraphHistPF();
				case 24 % SettingsLinePP.PROP
					prop_default = 36;
				case 25 % SettingsLinePP.HEIGHT
					prop_default = 111;
				otherwise
					prop_default = getPropDefault@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsLinePP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsLinePP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsLinePP, POINTER) returns the conditioned default value of POINTER of SettingsLinePP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SettingsLinePP, POINTER) returns the conditioned default value of POINTER of SettingsLinePP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsLinePP.getPropProp(pointer);
			
			prop_default = SettingsLinePP.conditioning(prop, SettingsLinePP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsLinePP, PROP, VALUE) checks VALUE format for PROP of SettingsLinePP.
			%  CHECK = PR.CHECKPROP(SettingsLinePP, PROP, VALUE) checks VALUE format for PROP of SettingsLinePP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SettingsLinePP:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:SettingsLinePP:WrongInput
			%  Element.CHECKPROP(SettingsLinePP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsLinePP.
			%   Error id: BRAPH2:SettingsLinePP:WrongInput
			%  PR.CHECKPROP(SettingsLinePP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsLinePP.
			%   Error id: BRAPH2:SettingsLinePP:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsLinePP.getPropProp(pointer);
			
			switch prop
				case 36 % SettingsLinePP.ENABLE
					check = Format.checkFormat(4, value, SettingsLinePP.getPropSettings(prop));
				case 37 % SettingsLinePP.CHECKBOX_VISIBLE
					check = Format.checkFormat(18, value, SettingsLinePP.getPropSettings(prop));
				case 38 % SettingsLinePP.DROPDOWN_LINESTYLE
					check = Format.checkFormat(18, value, SettingsLinePP.getPropSettings(prop));
				case 39 % SettingsLinePP.EDITFIELD_LINEWIDTH
					check = Format.checkFormat(18, value, SettingsLinePP.getPropSettings(prop));
				case 40 % SettingsLinePP.BUTTON_LINECOLOR
					check = Format.checkFormat(18, value, SettingsLinePP.getPropSettings(prop));
				case 41 % SettingsLinePP.DROPDOWN_SYMBOL
					check = Format.checkFormat(18, value, SettingsLinePP.getPropSettings(prop));
				case 42 % SettingsLinePP.EDITFIELD_SYMBOLSIZE
					check = Format.checkFormat(18, value, SettingsLinePP.getPropSettings(prop));
				case 43 % SettingsLinePP.BUTTON_FACECOLOR
					check = Format.checkFormat(18, value, SettingsLinePP.getPropSettings(prop));
				case 44 % SettingsLinePP.BUTTON_EDGECOLOR
					check = Format.checkFormat(18, value, SettingsLinePP.getPropSettings(prop));
				case 4 % SettingsLinePP.TEMPLATE
					check = Format.checkFormat(8, value, SettingsLinePP.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@SettingsPP(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsLinePP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsLinePP:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsLinePP.getPropTag(prop) ' (' SettingsLinePP.getFormatTag(SettingsLinePP.getPropFormat(prop)) ').'] ...
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
				case 37 % SettingsLinePP.CHECKBOX_VISIBLE
					el = pr.get('EL');
					prop = pr.get('PROP');
					checkbox_visible = uicheckbox( ...
					    'Parent', pr.memorize('H'), ...
						'Tag', 'CHECKBOX_VISIBLE', ...
					    'Text', 'visible', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('VISIBLE')) ' ' el.get(prop).getPropDescription('VISIBLE')], ...
					    'ValueChangedFcn', {@cb_visible} ...
					    );
					value = checkbox_visible;
					
				case 38 % SettingsLinePP.DROPDOWN_LINESTYLE
					el = pr.get('EL');
					prop = pr.get('PROP');
					dropdown_linestyle = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN_LINESTYLE', ...
					    'Items', el.get(prop).getPropSettings('LINESTYLE'), ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LINESTYLE')) ' ' el.get(prop).getPropDescription('LINESTYLE')], ...
					    'ValueChangedFcn', {@cb_dropdown_linestyle} ...
					    );
					
					value = dropdown_linestyle;
					
				case 39 % SettingsLinePP.EDITFIELD_LINEWIDTH
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_linewidth = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD_LINEWIDTH', ...
					    'Limits', [0 +Inf], ...
					    'LowerLimitInclusive', false, ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LINEWIDTH')) ' ' el.get(prop).getPropDescription('LINEWIDTH')], ...
					    'ValueChangedFcn', {@cb_editfield_linewidth} ...
					    );
					
					value = editfield_linewidth;
					
				case 40 % SettingsLinePP.BUTTON_LINECOLOR
					el = pr.get('EL');
					prop = pr.get('PROP');
					button_linecolor = uibutton( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'BUTTON_LINECOLOR', ...
					    'Text', 'line', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LINECOLOR')) ' ' el.get(prop).getPropDescription('LINECOLOR')], ...
					    'ButtonPushedFcn', {@cb_button_linecolor}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					value = button_linecolor;
					
				case 41 % SettingsLinePP.DROPDOWN_SYMBOL
					el = pr.get('EL');
					prop = pr.get('PROP');
					dropdown_symbol = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN_SYMBOL', ...
					    'Items', el.get(prop).getPropSettings('SYMBOL'), ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('SYMBOL')) ' ' el.get(prop).getPropDescription('SYMBOL')], ...
					    'ValueChangedFcn', {@cb_dropdown_symbol} ...
					    );
					
					value = dropdown_symbol;
					
				case 42 % SettingsLinePP.EDITFIELD_SYMBOLSIZE
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield_symbolsize = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD_SYMBOLSIZE', ...
					    'Limits', [0 +Inf], ...
					    'LowerLimitInclusive', false, ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('SYMBOLSIZE')) ' ' el.get(prop).getPropDescription('SYMBOLSIZE')], ...
					    'ValueChangedFcn', {@cb_editfield_symbolsize} ...
					    );
					
					value = editfield_symbolsize;
					
				case 43 % SettingsLinePP.BUTTON_FACECOLOR
					el = pr.get('EL');
					prop = pr.get('PROP');
					button_facecolor = uibutton( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'BUTTON_FACECOLOR', ...
					    'Text', 'face', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FACECOLOR')) ' ' el.get(prop).getPropDescription('FACECOLOR')], ...
					    'ButtonPushedFcn', {@cb_button_facecolor}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					value = button_facecolor;
					
				case 44 % SettingsLinePP.BUTTON_EDGECOLOR
					el = pr.get('EL');
					prop = pr.get('PROP');
					button_edgecolor = uibutton( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'BUTTON_EDGECOLOR', ...
					    'Text', 'edge', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('EDGECOLOR')) ' ' el.get(prop).getPropDescription('EDGECOLOR')], ...
					    'ButtonPushedFcn', {@cb_button_edgecolor}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					value = button_edgecolor;
					
				case 20 % SettingsLinePP.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('CHECKBOX_VISIBLE')
					
					    pr.memorize('DROPDOWN_LINESTYLE')
					    pr.memorize('EDITFIELD_LINEWIDTH')
					    pr.memorize('BUTTON_LINECOLOR')
					    
					    pr.memorize('DROPDOWN_SYMBOL')
					    pr.memorize('EDITFIELD_SYMBOLSIZE')
					    pr.memorize('BUTTON_FACECOLOR')
					    pr.memorize('BUTTON_EDGECOLOR')
					end
					
				case 21 % SettingsLinePP.UPDATE
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if el.isLocked(prop)
					        set(pr.get('CHECKBOX_VISIBLE'), 'Enable', pr.get('ENABLE'))
					        
					        set(pr.get('DROPDOWN_LINESTYLE'), 'Enable', 'off')
					        set(pr.get('EDITFIELD_LINEWIDTH'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('BUTTON_LINECOLOR'), 'Enable', pr.get('ENABLE'))        
					
					        set(pr.get('DROPDOWN_SYMBOL'), 'Enable', 'off')
					        set(pr.get('EDITFIELD_SYMBOLSIZE'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('BUTTON_FACECOLOR'), 'Enable', pr.get('ENABLE'))        
					        set(pr.get('BUTTON_EDGECOLOR'), 'Enable', pr.get('ENABLE'))
					    end
					
					    switch el.getPropCategory(prop)
					        case 2
					            set(pr.get('CHECKBOX_VISIBLE'), 'Value', el.get(prop).get('VISIBLE'))
					            
					            set(pr.get('DROPDOWN_LINESTYLE'), 'Value', el.get(prop).get('LINESTYLE'))
					            set(pr.get('EDITFIELD_LINEWIDTH'), 'Value', el.get(prop).get('LINEWIDTH'))
					            set(pr.get('BUTTON_LINECOLOR'), 'BackgroundColor', el.get(prop).get('LINECOLOR'))
					
					            set(pr.get('DROPDOWN_SYMBOL'), 'Value', el.get(prop).get('SYMBOL'))
					            set(pr.get('EDITFIELD_SYMBOLSIZE'), 'Value', el.get(prop).get('SYMBOLSIZE'))
					            set(pr.get('BUTTON_FACECOLOR'), 'BackgroundColor', el.get(prop).get('FACECOLOR'))
					            set(pr.get('BUTTON_EDGECOLOR'), 'BackgroundColor', el.get(prop).get('EDGECOLOR'))
					            
					        case {3, 4, 8, 9}
					            set(pr.get('CHECKBOX_VISIBLE'), 'Value', el.get(prop).get('VISIBLE'))
					
					            set(pr.get('DROPDOWN_LINESTYLE'), 'Value', el.get(prop).get('LINESTYLE'))
					            set(pr.get('EDITFIELD_LINEWIDTH'), 'Value', el.get(prop).get('LINEWIDTH'))
					            set(pr.get('BUTTON_LINECOLOR'), 'BackgroundColor', el.get(prop).get('LINECOLOR'))
					
					            set(pr.get('DROPDOWN_SYMBOL'), 'Value', el.get(prop).get('SYMBOL'))
					            set(pr.get('EDITFIELD_SYMBOLSIZE'), 'Value', el.get(prop).get('SYMBOLSIZE'))
					            set(pr.get('BUTTON_FACECOLOR'), 'BackgroundColor', el.get(prop).get('FACECOLOR'))
					            set(pr.get('BUTTON_EDGECOLOR'), 'BackgroundColor', el.get(prop).get('EDGECOLOR'))
					            
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('VISIBLE'), 'Callback')
					                set(pr.get('CHECKBOX_VISIBLE'), 'Enable', pr.get('ENABLE'))
					            end
					            
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('LINESTYLE'), 'Callback')
					                set(pr.get('DROPDOWN_LINESTYLE'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('LINEWIDTH'), 'Callback')
					                set(pr.get('EDITFIELD_LINEWIDTH'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('LINECOLOR'), 'Callback')
					                set(pr.get('BUTTON_LINECOLOR'), 'Enable', pr.get('ENABLE'))
					            end
					            
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('SYMBOL'), 'Callback')
					                set(pr.get('DROPDOWN_SYMBOL'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('SYMBOLSIZE'), 'Callback')
					                set(pr.get('EDITFIELD_SYMBOLSIZE'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end            
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FACECOLOR'), 'Callback')
					                set(pr.get('BUTTON_FACECOLOR'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('EDGECOLOR'), 'Callback')
					                set(pr.get('BUTTON_EDGECOLOR'), 'Enable', pr.get('ENABLE'))
					            end
					            
					        case 5
					            value = el.getr(prop);
					
					            if isa(value, 'NoValue')
					                set(pr.get('CHECKBOX_VISIBLE'), ...
					                    'Value', el.get(prop).getPropDefault('VISIBLE'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                
					                set(pr.get('DROPDOWN_LINESTYLE'), ...
					                    'Value', el.get(prop).getPropDefault('LINESTYLE'), ...
					                    'Enable', 'off' ...
					                    )
					                set(pr.get('EDITFIELD_LINEWIDTH'), ...
					                    'Value', el.get(prop).getPropDefault('LINEWIDTH'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('BUTTON_LINECOLOR'), ...
					                    'BackgroundColor', el.get(prop).getPropDefault('LINECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                
					                set(pr.get('DROPDOWN_SYMBOL'), ...
					                    'Value', el.get(prop).getPropDefault('SYMBOL'), ...
					                    'Enable', 'off' ...
					                    )
					                set(pr.get('EDITFIELD_SYMBOLSIZE'), ...
					                    'Value', el.get(prop).getPropDefault('SYMBOLSIZE'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('BUTTON_FACECOLOR'), ...
					                    'BackgroundColor', el.get(prop).getPropDefault('FACECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('BUTTON_EDGECOLOR'), ...
					                    'BackgroundColor', el.get(prop).getPropDefault('EDGECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            else
					                set(pr.get('CHECKBOX_VISIBLE'), ...
					                    'Value', el.get(prop).get('VISIBLE'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                
					                set(pr.get('DROPDOWN_LINESTYLE'), ...
					                    'Value', el.get(prop).get('LINESTYLE'), ...
					                    'Enable', 'off' ...
					                    )
					                set(pr.get('EDITFIELD_LINEWIDTH'), ...
					                    'Value', el.get(prop).get('LINEWIDTH'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('BUTTON_LINECOLOR'), ...
					                    'BackgroundColor', el.get(prop).get('LINECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					
					                set(pr.get('DROPDOWN_SYMBOL'), ...
					                    'Value', el.get(prop).get('SYMBOL'), ...
					                    'Enable', 'off' ...
					                    )
					                set(pr.get('EDITFIELD_SYMBOLSIZE'), ...
					                    'Value', el.get(prop).get('SYMBOLSIZE'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('BUTTON_FACECOLOR'), ...
					                    'BackgroundColor', el.get(prop).get('FACECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('BUTTON_EDGECOLOR'), ...
					                    'BackgroundColor', el.get(prop).get('EDGECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					    end
					end
					
				case 22 % SettingsLinePP.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('CHECKBOX_VISIBLE'), 'Position', [4 69 .30*w_p 21])
					
					    set(pr.get('DROPDOWN_LINESTYLE'),   'Position', [4          39 .15*w_p 21])
					    set(pr.get('EDITFIELD_LINEWIDTH'),  'Position', [4+.20*w_p  39 .15*w_p 21])
					    set(pr.get('BUTTON_LINECOLOR'),     'Position', [4+.40*w_p  39 .20*w_p 21])
					    
					    set(pr.get('DROPDOWN_SYMBOL'),      'Position', [4          9 .15*w_p 21])
					    set(pr.get('EDITFIELD_SYMBOLSIZE'), 'Position', [4+.20*w_p  9 .15*w_p 21])
					    set(pr.get('BUTTON_FACECOLOR'),     'Position', [4+.40*w_p  9 .20*w_p 21])
					    set(pr.get('BUTTON_EDGECOLOR'),     'Position', [4+.65*w_p  9 .20*w_p 21])
					end
					
				case 18 % SettingsLinePP.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
						pr.set('CHECKBOX_VISIBLE', Element.getNoValue())
					    
					    pr.set('DROPDOWN_LINESTYLE', Element.getNoValue())
					    pr.set('EDITFIELD_LINEWIDTH', Element.getNoValue())
					    pr.set('BUTTON_LINECOLOR', Element.getNoValue())
					    
					    pr.set('DROPDOWN_SYMBOL', Element.getNoValue())
					    pr.set('EDITFIELD_SYMBOLSIZE', Element.getNoValue())
					    pr.set('BUTTON_FACECOLOR', Element.getNoValue())
					    pr.set('BUTTON_EDGECOLOR', Element.getNoValue())
					end
					
				otherwise
					if prop <= 35
						value = calculateValue@SettingsPP(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_visible(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('VISIBLE', get(pr.get('CHECKBOX_VISIBLE'), 'Value'))
			end
			function cb_dropdown_linestyle(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('LINESTYLE', get(pr.get('DROPDOWN_LINESTYLE'), 'Value'))
			end
			function cb_editfield_linewidth(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('LINEWIDTH', get(pr.get('EDITFIELD_LINEWIDTH'), 'Value'))
			end
			function cb_button_linecolor(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    new_color = uisetcolor(el.get(prop).get('LINECOLOR'));
			    if ~isequal(new_color, el.get(prop).get('LINECOLOR'))
			        el.get(prop).set('LINECOLOR', new_color)
			
			        pr.get('UPDATE')
			    end
			end
			function cb_dropdown_symbol(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('SYMBOL', get(pr.get('DROPDOWN_SYMBOL'), 'Value'))
			end
			function cb_editfield_symbolsize(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('SYMBOLSIZE', get(pr.get('EDITFIELD_SYMBOLSIZE'), 'Value'))
			end
			function cb_button_facecolor(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    new_color = uisetcolor(el.get(prop).get('FACECOLOR'));
			    if ~isequal(new_color, el.get(prop).get('FACECOLOR'))
			        el.get(prop).set('FACECOLOR', new_color)
			
			        pr.get('UPDATE')
			    end
			end
			function cb_button_edgecolor(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    new_color = uisetcolor(el.get(prop).get('EDGECOLOR'));
			    if ~isequal(new_color, el.get(prop).get('EDGECOLOR'))
			        el.get(prop).set('EDGECOLOR', new_color)
			
			        pr.get('UPDATE')
			    end
			end
		end
	end
end
