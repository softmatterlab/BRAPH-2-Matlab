classdef SettingsAreaPP < SettingsPP
	%SettingsAreaPP is the panel with area settings.
	% It is a subclass of <a href="matlab:help SettingsPP">SettingsPP</a>.
	%
	% A Prop Panel for Area Settings (SettingsAreaPP) plots the panel for area settings,
	%  including visibility, face color, face alpha, edge color, and edge alpha.
	% It works for all categories.
	%
	% The list of SettingsAreaPP properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the property panel for area settings.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the property panel for area settings.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the property panel for area settings.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the property panel for area settings.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the property panel for area settings.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the property panel for area settings.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the property panel for area settings.
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
	%  <strong>37</strong> <strong>CHECKBOX_VISIBLE</strong> 	CHECKBOX_VISIBLE (evanescent, handle) determines whether the area is visible.
	%  <strong>38</strong> <strong>BUTTON_FACECOLOR</strong> 	BUTTON_FACECOLOR (evanescent, handle) is the face color button.
	%  <strong>39</strong> <strong>EDITFIELD_FACEALPHA</strong> 	EDITFIELD_FACEALPHA (evanescent, handle) is the face alpha edit field.
	%  <strong>40</strong> <strong>SLIDER_FACEALPHA</strong> 	SLIDER_FACEALPHA (evanescent, handle) is the face alpha slider.
	%  <strong>41</strong> <strong>BUTTON_EDGECOLOR</strong> 	BUTTON_EDGECOLOR (evanescent, handle) is the edge color button.
	%  <strong>42</strong> <strong>EDITFIELD_EDGEALPHA</strong> 	EDITFIELD_EDGEALPHA (evanescent, handle) is the edge alpha edit field.
	%  <strong>43</strong> <strong>SLIDER_EDGEALPHA</strong> 	SLIDER_EDGEALPHA (evanescent, handle) is the edge alpha slider.
	%
	% SettingsAreaPP methods (constructor):
	%  SettingsAreaPP - constructor
	%
	% SettingsAreaPP methods:
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
	% SettingsAreaPP methods (display):
	%  tostring - string with information about the prop panel for area settings
	%  disp - displays information about the prop panel for area settings
	%  tree - displays the tree of the prop panel for area settings
	%
	% SettingsAreaPP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel for area settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel for area settings
	%
	% SettingsAreaPP methods (save/load, Static):
	%  save - saves BRAPH2 prop panel for area settings as b2 file
	%  load - loads a BRAPH2 prop panel for area settings from a b2 file
	%
	% SettingsAreaPP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel for area settings
	%
	% SettingsAreaPP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel for area settings
	%
	% SettingsAreaPP methods (inspection, Static):
	%  getClass - returns the class of the prop panel for area settings
	%  getSubclasses - returns all subclasses of SettingsAreaPP
	%  getProps - returns the property list of the prop panel for area settings
	%  getPropNumber - returns the property number of the prop panel for area settings
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
	% SettingsAreaPP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsAreaPP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsAreaPP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsAreaPP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsAreaPP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsAreaPP constants</a>.
	%
	%
	% See also SettingsArea, uicheckbox, , uipushbutton, uieditfield, uislider.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		ENABLE = 36; %CET: Computational Efficiency Trick
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = 9;
		ENABLE_FORMAT = 4;
		
		CHECKBOX_VISIBLE = 37; %CET: Computational Efficiency Trick
		CHECKBOX_VISIBLE_TAG = 'CHECKBOX_VISIBLE';
		CHECKBOX_VISIBLE_CATEGORY = 7;
		CHECKBOX_VISIBLE_FORMAT = 18;
		
		BUTTON_FACECOLOR = 38; %CET: Computational Efficiency Trick
		BUTTON_FACECOLOR_TAG = 'BUTTON_FACECOLOR';
		BUTTON_FACECOLOR_CATEGORY = 7;
		BUTTON_FACECOLOR_FORMAT = 18;
		
		EDITFIELD_FACEALPHA = 39; %CET: Computational Efficiency Trick
		EDITFIELD_FACEALPHA_TAG = 'EDITFIELD_FACEALPHA';
		EDITFIELD_FACEALPHA_CATEGORY = 7;
		EDITFIELD_FACEALPHA_FORMAT = 18;
		
		SLIDER_FACEALPHA = 40; %CET: Computational Efficiency Trick
		SLIDER_FACEALPHA_TAG = 'SLIDER_FACEALPHA';
		SLIDER_FACEALPHA_CATEGORY = 7;
		SLIDER_FACEALPHA_FORMAT = 18;
		
		BUTTON_EDGECOLOR = 41; %CET: Computational Efficiency Trick
		BUTTON_EDGECOLOR_TAG = 'BUTTON_EDGECOLOR';
		BUTTON_EDGECOLOR_CATEGORY = 7;
		BUTTON_EDGECOLOR_FORMAT = 18;
		
		EDITFIELD_EDGEALPHA = 42; %CET: Computational Efficiency Trick
		EDITFIELD_EDGEALPHA_TAG = 'EDITFIELD_EDGEALPHA';
		EDITFIELD_EDGEALPHA_CATEGORY = 7;
		EDITFIELD_EDGEALPHA_FORMAT = 18;
		
		SLIDER_EDGEALPHA = 43; %CET: Computational Efficiency Trick
		SLIDER_EDGEALPHA_TAG = 'SLIDER_EDGEALPHA';
		SLIDER_EDGEALPHA_CATEGORY = 7;
		SLIDER_EDGEALPHA_FORMAT = 18;
	end
	methods % constructor
		function pr = SettingsAreaPP(varargin)
			%SettingsAreaPP() creates a prop panel for area settings.
			%
			% SettingsAreaPP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsAreaPP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SettingsAreaPP properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the property panel for area settings.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the property panel for area settings.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the property panel for area settings.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the property panel for area settings.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the property panel for area settings.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the property panel for area settings.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the property panel for area settings.
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
			%  <strong>37</strong> <strong>CHECKBOX_VISIBLE</strong> 	CHECKBOX_VISIBLE (evanescent, handle) determines whether the area is visible.
			%  <strong>38</strong> <strong>BUTTON_FACECOLOR</strong> 	BUTTON_FACECOLOR (evanescent, handle) is the face color button.
			%  <strong>39</strong> <strong>EDITFIELD_FACEALPHA</strong> 	EDITFIELD_FACEALPHA (evanescent, handle) is the face alpha edit field.
			%  <strong>40</strong> <strong>SLIDER_FACEALPHA</strong> 	SLIDER_FACEALPHA (evanescent, handle) is the face alpha slider.
			%  <strong>41</strong> <strong>BUTTON_EDGECOLOR</strong> 	BUTTON_EDGECOLOR (evanescent, handle) is the edge color button.
			%  <strong>42</strong> <strong>EDITFIELD_EDGEALPHA</strong> 	EDITFIELD_EDGEALPHA (evanescent, handle) is the edge alpha edit field.
			%  <strong>43</strong> <strong>SLIDER_EDGEALPHA</strong> 	SLIDER_EDGEALPHA (evanescent, handle) is the edge alpha slider.
			%
			% See also Category, Format.
			
			pr = pr@SettingsPP(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the prop panel for area settings.
			%
			% BUILD = SettingsAreaPP.GETBUILD() returns the build of 'SettingsAreaPP'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the prop panel for area settings PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('SettingsAreaPP') returns the build of 'SettingsAreaPP'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('SettingsAreaPP')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the prop panel for area settings.
			%
			% CLASS = SettingsAreaPP.GETCLASS() returns the class 'SettingsAreaPP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel for area settings PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SettingsAreaPP') returns 'SettingsAreaPP'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SettingsAreaPP')
			%  are less computationally efficient.
			
			pr_class = 'SettingsAreaPP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel for area settings.
			%
			% LIST = SettingsAreaPP.GETSUBCLASSES() returns all subclasses of 'SettingsAreaPP'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel for area settings PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SettingsAreaPP') returns all subclasses of 'SettingsAreaPP'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SettingsAreaPP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel for area settings.
			%
			% PROPS = SettingsAreaPP.GETPROPS() returns the property list of prop panel for area settings
			%  as a row vector.
			%
			% PROPS = SettingsAreaPP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel for area settings PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SettingsAreaPP'[, CATEGORY]) returns the property list of 'SettingsAreaPP'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43];
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
					prop_list = [10 15 27 28 30 31 32 33 34 35 37 38 39 40 41 42 43];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel for area settings.
			%
			% N = SettingsAreaPP.GETPROPNUMBER() returns the property number of prop panel for area settings.
			%
			% N = SettingsAreaPP.GETPROPNUMBER(CATEGORY) returns the property number of prop panel for area settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel for area settings PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SettingsAreaPP') returns the property number of 'SettingsAreaPP'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 43;
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
					prop_number = 17;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 5;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel for area settings/error.
			%
			% CHECK = SettingsAreaPP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SettingsAreaPP, PROP) checks whether PROP exists for SettingsAreaPP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsAreaPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAreaPP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAreaPP:WrongInput]
			%  Element.EXISTSPROP(SettingsAreaPP, PROP) throws error if PROP does NOT exist for SettingsAreaPP.
			%   Error id: [BRAPH2:SettingsAreaPP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 43 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsAreaPP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsAreaPP:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsAreaPP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel for area settings/error.
			%
			% CHECK = SettingsAreaPP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SettingsAreaPP, TAG) checks whether TAG exists for SettingsAreaPP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsAreaPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAreaPP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAreaPP:WrongInput]
			%  Element.EXISTSTAG(SettingsAreaPP, TAG) throws error if TAG does NOT exist for SettingsAreaPP.
			%   Error id: [BRAPH2:SettingsAreaPP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'CHECKBOX_VISIBLE'  'BUTTON_FACECOLOR'  'EDITFIELD_FACEALPHA'  'SLIDER_FACEALPHA'  'BUTTON_EDGECOLOR'  'EDITFIELD_EDGEALPHA'  'SLIDER_EDGEALPHA' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsAreaPP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsAreaPP:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SettingsAreaPP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsAreaPP, POINTER) returns property number of POINTER of SettingsAreaPP.
			%  PROPERTY = PR.GETPROPPROP(SettingsAreaPP, POINTER) returns property number of POINTER of SettingsAreaPP.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'CHECKBOX_VISIBLE'  'BUTTON_FACECOLOR'  'EDITFIELD_FACEALPHA'  'SLIDER_FACEALPHA'  'BUTTON_EDGECOLOR'  'EDITFIELD_EDGEALPHA'  'SLIDER_EDGEALPHA' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(SettingsAreaPP, POINTER) returns tag of POINTER of SettingsAreaPP.
			%  TAG = PR.GETPROPTAG(SettingsAreaPP, POINTER) returns tag of POINTER of SettingsAreaPP.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				settingsareapp_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'CHECKBOX_VISIBLE'  'BUTTON_FACECOLOR'  'EDITFIELD_FACEALPHA'  'SLIDER_FACEALPHA'  'BUTTON_EDGECOLOR'  'EDITFIELD_EDGEALPHA'  'SLIDER_EDGEALPHA' };
				tag = settingsareapp_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsAreaPP, POINTER) returns category of POINTER of SettingsAreaPP.
			%  CATEGORY = PR.GETPROPCATEGORY(SettingsAreaPP, POINTER) returns category of POINTER of SettingsAreaPP.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAreaPP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsareapp_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  7  7  7  7  7  7  7 };
			prop_category = settingsareapp_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsAreaPP, POINTER) returns format of POINTER of SettingsAreaPP.
			%  FORMAT = PR.GETPROPFORMAT(SettingsAreaPP, POINTER) returns format of POINTER of SettingsAreaPP.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAreaPP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsareapp_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  4  18  18  18  18  18  18  18 };
			prop_format = settingsareapp_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsAreaPP, POINTER) returns description of POINTER of SettingsAreaPP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SettingsAreaPP, POINTER) returns description of POINTER of SettingsAreaPP.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAreaPP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsareapp_description_list = { 'ELCLASS (constant, string) is the class of the property panel for area settings.'  'NAME (constant, string) is the name of the property panel for area settings.'  'DESCRIPTION (constant, string) is the description of the property panel for area settings.'  'TEMPLATE (parameter, item) is the template of the property panel for area settings.'  'ID (data, string) is a few-letter code for the property panel for area settings.'  'LABEL (metadata, string) is an extended label of the property panel for area settings.'  'NOTES (metadata, string) are some specific notes about the property panel for area settings.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the settings position panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.'  'CHECKBOX_VISIBLE (evanescent, handle) determines whether the area is visible.'  'BUTTON_FACECOLOR (evanescent, handle) is the face color button.'  'EDITFIELD_FACEALPHA (evanescent, handle) is the face alpha edit field.'  'SLIDER_FACEALPHA (evanescent, handle) is the face alpha slider.'  'BUTTON_EDGECOLOR (evanescent, handle) is the edge color button.'  'EDITFIELD_EDGEALPHA (evanescent, handle) is the edge alpha edit field.'  'SLIDER_EDGEALPHA (evanescent, handle) is the edge alpha slider.' };
			prop_description = settingsareapp_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsAreaPP, POINTER) returns settings of POINTER of SettingsAreaPP.
			%  SETTINGS = PR.GETPROPSETTINGS(SettingsAreaPP, POINTER) returns settings of POINTER of SettingsAreaPP.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAreaPP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % SettingsAreaPP.ENABLE
					prop_settings = Format.getFormatSettings(4);
				case 37 % SettingsAreaPP.CHECKBOX_VISIBLE
					prop_settings = Format.getFormatSettings(18);
				case 38 % SettingsAreaPP.BUTTON_FACECOLOR
					prop_settings = Format.getFormatSettings(18);
				case 39 % SettingsAreaPP.EDITFIELD_FACEALPHA
					prop_settings = Format.getFormatSettings(18);
				case 40 % SettingsAreaPP.SLIDER_FACEALPHA
					prop_settings = Format.getFormatSettings(18);
				case 41 % SettingsAreaPP.BUTTON_EDGECOLOR
					prop_settings = Format.getFormatSettings(18);
				case 42 % SettingsAreaPP.EDITFIELD_EDGEALPHA
					prop_settings = Format.getFormatSettings(18);
				case 43 % SettingsAreaPP.SLIDER_EDGEALPHA
					prop_settings = Format.getFormatSettings(18);
				case 4 % SettingsAreaPP.TEMPLATE
					prop_settings = 'SettingsAreaPP';
				otherwise
					prop_settings = getPropSettings@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsAreaPP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAreaPP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsAreaPP, POINTER) returns the default value of POINTER of SettingsAreaPP.
			%  DEFAULT = PR.GETPROPDEFAULT(SettingsAreaPP, POINTER) returns the default value of POINTER of SettingsAreaPP.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsAreaPP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % SettingsAreaPP.ENABLE
					prop_default = true;
				case 37 % SettingsAreaPP.CHECKBOX_VISIBLE
					prop_default = Format.getFormatDefault(18, SettingsAreaPP.getPropSettings(prop));
				case 38 % SettingsAreaPP.BUTTON_FACECOLOR
					prop_default = Format.getFormatDefault(18, SettingsAreaPP.getPropSettings(prop));
				case 39 % SettingsAreaPP.EDITFIELD_FACEALPHA
					prop_default = Format.getFormatDefault(18, SettingsAreaPP.getPropSettings(prop));
				case 40 % SettingsAreaPP.SLIDER_FACEALPHA
					prop_default = Format.getFormatDefault(18, SettingsAreaPP.getPropSettings(prop));
				case 41 % SettingsAreaPP.BUTTON_EDGECOLOR
					prop_default = Format.getFormatDefault(18, SettingsAreaPP.getPropSettings(prop));
				case 42 % SettingsAreaPP.EDITFIELD_EDGEALPHA
					prop_default = Format.getFormatDefault(18, SettingsAreaPP.getPropSettings(prop));
				case 43 % SettingsAreaPP.SLIDER_EDGEALPHA
					prop_default = Format.getFormatDefault(18, SettingsAreaPP.getPropSettings(prop));
				case 1 % SettingsAreaPP.ELCLASS
					prop_default = 'SettingsAreaPP';
				case 2 % SettingsAreaPP.NAME
					prop_default = 'Prop Panel for Area Settings';
				case 3 % SettingsAreaPP.DESCRIPTION
					prop_default = 'A Prop Panel for Area Settings (SettingsAreaPP) plots the panel for area settings, including visibility, face color, face alpha, edge color, and edge alpha. It works for all categories.';
				case 4 % SettingsAreaPP.TEMPLATE
					prop_default = Format.getFormatDefault(8, SettingsAreaPP.getPropSettings(prop));
				case 5 % SettingsAreaPP.ID
					prop_default = 'SettingsAreaPP ID';
				case 6 % SettingsAreaPP.LABEL
					prop_default = 'SettingsAreaPP label';
				case 7 % SettingsAreaPP.NOTES
					prop_default = 'SettingsAreaPP notes';
				case 23 % SettingsAreaPP.EL
					prop_default = GraphHistPF();
				case 24 % SettingsAreaPP.PROP
					prop_default = 33;
				case 25 % SettingsAreaPP.HEIGHT
					prop_default = 111;
				otherwise
					prop_default = getPropDefault@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsAreaPP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAreaPP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsAreaPP, POINTER) returns the conditioned default value of POINTER of SettingsAreaPP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SettingsAreaPP, POINTER) returns the conditioned default value of POINTER of SettingsAreaPP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsAreaPP.getPropProp(pointer);
			
			prop_default = SettingsAreaPP.conditioning(prop, SettingsAreaPP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsAreaPP, PROP, VALUE) checks VALUE format for PROP of SettingsAreaPP.
			%  CHECK = PR.CHECKPROP(SettingsAreaPP, PROP, VALUE) checks VALUE format for PROP of SettingsAreaPP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SettingsAreaPP:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:SettingsAreaPP:WrongInput
			%  Element.CHECKPROP(SettingsAreaPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAreaPP.
			%   Error id: BRAPH2:SettingsAreaPP:WrongInput
			%  PR.CHECKPROP(SettingsAreaPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAreaPP.
			%   Error id: BRAPH2:SettingsAreaPP:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsAreaPP.getPropProp(pointer);
			
			switch prop
				case 36 % SettingsAreaPP.ENABLE
					check = Format.checkFormat(4, value, SettingsAreaPP.getPropSettings(prop));
				case 37 % SettingsAreaPP.CHECKBOX_VISIBLE
					check = Format.checkFormat(18, value, SettingsAreaPP.getPropSettings(prop));
				case 38 % SettingsAreaPP.BUTTON_FACECOLOR
					check = Format.checkFormat(18, value, SettingsAreaPP.getPropSettings(prop));
				case 39 % SettingsAreaPP.EDITFIELD_FACEALPHA
					check = Format.checkFormat(18, value, SettingsAreaPP.getPropSettings(prop));
				case 40 % SettingsAreaPP.SLIDER_FACEALPHA
					check = Format.checkFormat(18, value, SettingsAreaPP.getPropSettings(prop));
				case 41 % SettingsAreaPP.BUTTON_EDGECOLOR
					check = Format.checkFormat(18, value, SettingsAreaPP.getPropSettings(prop));
				case 42 % SettingsAreaPP.EDITFIELD_EDGEALPHA
					check = Format.checkFormat(18, value, SettingsAreaPP.getPropSettings(prop));
				case 43 % SettingsAreaPP.SLIDER_EDGEALPHA
					check = Format.checkFormat(18, value, SettingsAreaPP.getPropSettings(prop));
				case 4 % SettingsAreaPP.TEMPLATE
					check = Format.checkFormat(8, value, SettingsAreaPP.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@SettingsPP(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsAreaPP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsAreaPP:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsAreaPP.getPropTag(prop) ' (' SettingsAreaPP.getFormatTag(SettingsAreaPP.getPropFormat(prop)) ').'] ...
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
				case 37 % SettingsAreaPP.CHECKBOX_VISIBLE
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
					
				case 38 % SettingsAreaPP.BUTTON_FACECOLOR
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
					
				case 39 % SettingsAreaPP.EDITFIELD_FACEALPHA
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_facealpha = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'EDITFIELD_FACEALPHA', ...
					    'Limits', [0 1], ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FACEALPHA')) ' ' el.get(prop).getPropDescription('FACEALPHA')], ...
					    'ValueChangedFcn', {@cb_editfield_facealpha} ...
					    );
					value = editfield_facealpha;
					
				case 40 % SettingsAreaPP.SLIDER_FACEALPHA
					el = pr.get('EL');
					prop = pr.get('PROP');
					slider_facealpha = uislider( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'SLIDER_FACEALPHA', ...
					    'Limits', [0 1], ...
					    'FontSize', 12 / 2, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FACEALPHA')) ' ' el.get(prop).getPropDescription('FACEALPHA')], ...
					    'ValueChangedFcn', {@cb_slider_facealpha} ...
					    );
					value = slider_facealpha;
					
				case 41 % SettingsAreaPP.BUTTON_EDGECOLOR
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
					
				case 42 % SettingsAreaPP.EDITFIELD_EDGEALPHA
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_edgealpha = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'EDITFIELD_EDGEALPHA', ...
					    'Limits', [0 1], ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('EDGEALPHA')) ' ' el.get(prop).getPropDescription('EDGEALPHA')], ...
					    'ValueChangedFcn', {@cb_editfield_edgealpha} ...
					    );
					value = editfield_edgealpha;
					
				case 43 % SettingsAreaPP.SLIDER_EDGEALPHA
					el = pr.get('EL');
					prop = pr.get('PROP');
					slider_edgealpha = uislider( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'SLIDER_EDGEALPHA', ...
					    'Limits', [0 1], ...
					    'FontSize', 12 / 2, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('EDGEALPHA')) ' ' el.get(prop).getPropDescription('EDGEALPHA')], ...
					    'ValueChangedFcn', {@cb_slider_edgealpha} ...
					    );
					value = slider_edgealpha;
					
				case 20 % SettingsAreaPP.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('CHECKBOX_VISIBLE')
					
					    pr.memorize('BUTTON_FACECOLOR')
					    pr.memorize('EDITFIELD_FACEALPHA')
					    pr.memorize('SLIDER_FACEALPHA')
					    
					    pr.memorize('BUTTON_EDGECOLOR')
					    pr.memorize('EDITFIELD_EDGEALPHA')
					    pr.memorize('SLIDER_EDGEALPHA')
					end
					
				case 21 % SettingsAreaPP.UPDATE
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if el.isLocked(prop)
					        set(pr.get('CHECKBOX_VISIBLE'), 'Enable', pr.get('ENABLE'))
					
					        set(pr.get('BUTTON_FACECOLOR'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('EDITFIELD_FACEALPHA'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('SLIDER_FACEALPHA'), 'Enable', pr.get('ENABLE'))
					        
					        set(pr.get('BUTTON_EDGECOLOR'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('EDITFIELD_EDGEALPHA'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('SLIDER_EDGEALPHA'), 'Enable', pr.get('ENABLE'))
					    end
					
					    switch el.getPropCategory(prop)
					        case 2
					            set(pr.get('CHECKBOX_VISIBLE'), 'Value', el.get(prop).get('VISIBLE'))
					
					            set(pr.get('BUTTON_FACECOLOR'), 'BackgroundColor', el.get(prop).get('FACECOLOR'))
					            set(pr.get('EDITFIELD_FACEALPHA'), 'Value', el.get(prop).get('FACEALPHA'))
					            set(pr.get('SLIDER_FACEALPHA'), 'Value', el.get(prop).get('FACEALPHA'))
					            
					            set(pr.get('BUTTON_EDGECOLOR'), 'BackgroundColor', el.get(prop).get('EDGECOLOR'))
					            set(pr.get('EDITFIELD_EDGEALPHA'), 'Value', el.get(prop).get('EDGEALPHA'))
					            set(pr.get('SLIDER_EDGEALPHA'), 'Value', el.get(prop).get('EDGEALPHA'))
					        case {3, 4, 8, 9}
					            set(pr.get('CHECKBOX_VISIBLE'), 'Value', el.get(prop).get('VISIBLE'))
					
					            set(pr.get('BUTTON_FACECOLOR'), 'BackgroundColor', el.get(prop).get('FACECOLOR'))
					            set(pr.get('EDITFIELD_FACEALPHA'), 'Value', el.get(prop).get('FACEALPHA'))
					            set(pr.get('SLIDER_FACEALPHA'), 'Value', el.get(prop).get('FACEALPHA'))
					            
					            set(pr.get('BUTTON_EDGECOLOR'), 'BackgroundColor', el.get(prop).get('EDGECOLOR'))
					            set(pr.get('EDITFIELD_EDGEALPHA'), 'Value', el.get(prop).get('EDGEALPHA'))
					            set(pr.get('SLIDER_EDGEALPHA'), 'Value', el.get(prop).get('EDGEALPHA'))
					
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('VISIBLE'), 'Callback')
					                set(pr.get('CHECKBOX_VISIBLE'), 'Enable', pr.get('ENABLE'))
					            end
					
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FACECOLOR'), 'Callback')
					                set(pr.get('BUTTON_FACECOLOR'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FACEALPHA'), 'Callback')
					                set(pr.get('EDITFIELD_FACEALPHA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_FACEALPHA'), 'Enable', pr.get('ENABLE'))
					            end
					            
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('EDGECOLOR'), 'Callback')
					                set(pr.get('BUTTON_EDGECOLOR'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('EDGEALPHA'), 'Callback')
					                set(pr.get('EDITFIELD_EDGEALPHA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_EDGEALPHA'), 'Enable', pr.get('ENABLE'))
					            end
					            
					        case 5
					            value = el.getr(prop);
					
					            if isa(value, 'NoValue')
					                set(pr.get('CHECKBOX_VISIBLE'), ...
					                    'Value', el.get(prop).getPropDefault('VISIBLE'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					
					                set(pr.get('BUTTON_FACECOLOR'), ...
					                    'BackgroundColor', el.get(prop).getPropDefault('FACECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_FACEALPHA'), ...
					                    'Value', el.get(prop).getPropDefault('FACEALPHA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_FACEALPHA'), ...
					                    'Value', el.get(prop).getPropDefault('FACEALPHA'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                
					                set(pr.get('BUTTON_EDGECOLOR'), ...
					                    'BackgroundColor', el.get(prop).getPropDefault('EDGECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_EDGEALPHA'), ...
					                    'Value', el.get(prop).getPropDefault('EDGEALPHA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_EDGEALPHA'), ...
					                    'Value', el.get(prop).getPropDefault('EDGEALPHA'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            else
					                set(pr.get('CHECKBOX_VISIBLE'), ...
					                    'Value', el.get(prop).get('VISIBLE'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                
					                set(pr.get('BUTTON_FACECOLOR'), ...
					                    'BackgroundColor', el.get(prop).get('FACECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_FACEALPHA'), ...
					                    'Value', el.get(prop).get('FACEALPHA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_FACEALPHA'), ...
					                    'Value', el.get(prop).get('FACEALPHA'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					
					                set(pr.get('BUTTON_EDGECOLOR'), ...
					                    'BackgroundColor', el.get(prop).get('EDGECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_EDGEALPHA'), ...
					                    'Value', el.get(prop).get('EDGEALPHA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_EDGEALPHA'), ...
					                    'Value', el.get(prop).get('EDGEALPHA'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					    end
					end
					
				case 22 % SettingsAreaPP.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('CHECKBOX_VISIBLE'), 'Position', [4 69 .30*w_p 21])
					
					    set(pr.get('BUTTON_FACECOLOR'),    'Position', [4                  39  .20*w_p   21])
					    set(pr.get('EDITFIELD_FACEALPHA'), 'Position', [8+.20*w_p          39  .15*w_p   21])
					    set(pr.get('SLIDER_FACEALPHA'),    'Position', [8+.35*w_p+21   57 .50*w_p   3]) % the height of a slider cannot be changed
					
					    set(pr.get('BUTTON_EDGECOLOR'),    'Position', [4                  9   .20*w_p   21])
					    set(pr.get('EDITFIELD_EDGEALPHA'), 'Position', [8+.20*w_p          9   .15*w_p   21])
					    set(pr.get('SLIDER_EDGEALPHA'),    'Position', [8+.35*w_p+21   27 .50*w_p   3]) % the height of a slider cannot be changed
					end
					
				case 18 % SettingsAreaPP.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('CHECKBOX_VISIBLE', Element.getNoValue())
					
					    pr.set('BUTTON_FACECOLOR', Element.getNoValue())
					    pr.set('EDITFIELD_FACEALPHA', Element.getNoValue())
					    pr.set('SLIDER_FACEALPHA', Element.getNoValue())
					
					    pr.set('BUTTON_EDGECOLOR', Element.getNoValue())
					    pr.set('EDITFIELD_EDGEALPHA', Element.getNoValue())
					    pr.set('SLIDER_EDGEALPHA', Element.getNoValue())
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
			function cb_button_facecolor(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    new_color = uisetcolor(el.get(prop).get('FACECOLOR'));
			    if ~isequal(new_color, el.get(prop).get('FACECOLOR'))
			        el.get(prop).set('FACECOLOR', new_color)
			
			        pr.get('UPDATE')
			    end
			end
			function cb_editfield_facealpha(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('FACEALPHA', get(pr.get('EDITFIELD_FACEALPHA'), 'Value'))
			
				pr.get('UPDATE')
			end
			function cb_slider_facealpha(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('FACEALPHA', get(pr.get('SLIDER_FACEALPHA'), 'Value'))
			
				pr.get('UPDATE')
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
			function cb_editfield_edgealpha(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('EDGEALPHA', get(pr.get('EDITFIELD_EDGEALPHA'), 'Value'))
			
				pr.get('UPDATE')
			end
			function cb_slider_edgealpha(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('EDGEALPHA', get(pr.get('SLIDER_EDGEALPHA'), 'Value'))
			    
				pr.get('UPDATE')
			end
		end
	end
end
