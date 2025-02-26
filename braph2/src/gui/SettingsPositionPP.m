classdef SettingsPositionPP < SettingsPP
	%SettingsPositionPP is the panel with position settings.
	% It is a subclass of <a href="matlab:help SettingsPP">SettingsPP</a>.
	%
	% A Prop Panel for Position Settings (SettingsPositionPP) plots the panel 
	%  for position settings, including a checkbox for autopositioning 
	%  and numeric edit fields for x0, y0, height and width.
	% It works for all categories.
	%
	% The list of SettingsPositionPP properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the property panel for position settings.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the property panel for position settings.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the property panel for position settings.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the property panel for position settings.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the property panel for position settings.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the property panel for position settings.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the property panel for position settings.
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
	%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the property panel for position settings.
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
	%  <strong>37</strong> <strong>CHECKBOX_AUTOPOS</strong> 	CHECKBOX_AUTOPOS (evanescent, handle) is the autopositioning checkbox.
	%  <strong>38</strong> <strong>LABEL_X0</strong> 	LABEL_X0 (evanescent, handle) is the label of the x0 edit field.
	%  <strong>39</strong> <strong>EDITFIELD_X0</strong> 	EDITFIELD_X0 (evanescent, handle) is the x0 edit field.
	%  <strong>40</strong> <strong>LABEL_Y0</strong> 	LABEL_Y0 (evanescent, handle) is the label of the y0 edit field.
	%  <strong>41</strong> <strong>EDITFIELD_Y0</strong> 	EDITFIELD_Y0 (evanescent, handle) is the y0 edit field.
	%  <strong>42</strong> <strong>LABEL_W</strong> 	LABEL_W (evanescent, handle) is the label of the witdth edit field.
	%  <strong>43</strong> <strong>EDITFIELD_W</strong> 	EDITFIELD_W (evanescent, handle) is the width edit field.
	%  <strong>44</strong> <strong>LABEL_H</strong> 	LABEL_H (evanescent, handle) is the label of the height edit field.
	%  <strong>45</strong> <strong>EDITFIELD_H</strong> 	EDITFIELD_H (evanescent, handle) is the height edit field.
	%
	% SettingsPositionPP methods (constructor):
	%  SettingsPositionPP - constructor
	%
	% SettingsPositionPP methods:
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
	% SettingsPositionPP methods (display):
	%  tostring - string with information about the prop panel for position settings
	%  disp - displays information about the prop panel for position settings
	%  tree - displays the tree of the prop panel for position settings
	%
	% SettingsPositionPP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel for position settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel for position settings
	%
	% SettingsPositionPP methods (save/load, Static):
	%  save - saves BRAPH2 prop panel for position settings as b2 file
	%  load - loads a BRAPH2 prop panel for position settings from a b2 file
	%
	% SettingsPositionPP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel for position settings
	%
	% SettingsPositionPP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel for position settings
	%
	% SettingsPositionPP methods (inspection, Static):
	%  getClass - returns the class of the prop panel for position settings
	%  getSubclasses - returns all subclasses of SettingsPositionPP
	%  getProps - returns the property list of the prop panel for position settings
	%  getPropNumber - returns the property number of the prop panel for position settings
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
	% SettingsPositionPP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsPositionPP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsPositionPP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsPositionPP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsPositionPP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsPositionPP constants</a>.
	%
	%
	% See also SettingsPosition, uicheckbox, uieditfield.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		ENABLE = 36; %CET: Computational Efficiency Trick
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = 9;
		ENABLE_FORMAT = 4;
		
		CHECKBOX_AUTOPOS = 37; %CET: Computational Efficiency Trick
		CHECKBOX_AUTOPOS_TAG = 'CHECKBOX_AUTOPOS';
		CHECKBOX_AUTOPOS_CATEGORY = 7;
		CHECKBOX_AUTOPOS_FORMAT = 18;
		
		LABEL_X0 = 38; %CET: Computational Efficiency Trick
		LABEL_X0_TAG = 'LABEL_X0';
		LABEL_X0_CATEGORY = 7;
		LABEL_X0_FORMAT = 18;
		
		EDITFIELD_X0 = 39; %CET: Computational Efficiency Trick
		EDITFIELD_X0_TAG = 'EDITFIELD_X0';
		EDITFIELD_X0_CATEGORY = 7;
		EDITFIELD_X0_FORMAT = 18;
		
		LABEL_Y0 = 40; %CET: Computational Efficiency Trick
		LABEL_Y0_TAG = 'LABEL_Y0';
		LABEL_Y0_CATEGORY = 7;
		LABEL_Y0_FORMAT = 18;
		
		EDITFIELD_Y0 = 41; %CET: Computational Efficiency Trick
		EDITFIELD_Y0_TAG = 'EDITFIELD_Y0';
		EDITFIELD_Y0_CATEGORY = 7;
		EDITFIELD_Y0_FORMAT = 18;
		
		LABEL_W = 42; %CET: Computational Efficiency Trick
		LABEL_W_TAG = 'LABEL_W';
		LABEL_W_CATEGORY = 7;
		LABEL_W_FORMAT = 18;
		
		EDITFIELD_W = 43; %CET: Computational Efficiency Trick
		EDITFIELD_W_TAG = 'EDITFIELD_W';
		EDITFIELD_W_CATEGORY = 7;
		EDITFIELD_W_FORMAT = 18;
		
		LABEL_H = 44; %CET: Computational Efficiency Trick
		LABEL_H_TAG = 'LABEL_H';
		LABEL_H_CATEGORY = 7;
		LABEL_H_FORMAT = 18;
		
		EDITFIELD_H = 45; %CET: Computational Efficiency Trick
		EDITFIELD_H_TAG = 'EDITFIELD_H';
		EDITFIELD_H_CATEGORY = 7;
		EDITFIELD_H_FORMAT = 18;
	end
	methods % constructor
		function pr = SettingsPositionPP(varargin)
			%SettingsPositionPP() creates a prop panel for position settings.
			%
			% SettingsPositionPP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsPositionPP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SettingsPositionPP properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the property panel for position settings.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the property panel for position settings.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the property panel for position settings.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the property panel for position settings.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the property panel for position settings.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the property panel for position settings.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the property panel for position settings.
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
			%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the property panel for position settings.
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
			%  <strong>37</strong> <strong>CHECKBOX_AUTOPOS</strong> 	CHECKBOX_AUTOPOS (evanescent, handle) is the autopositioning checkbox.
			%  <strong>38</strong> <strong>LABEL_X0</strong> 	LABEL_X0 (evanescent, handle) is the label of the x0 edit field.
			%  <strong>39</strong> <strong>EDITFIELD_X0</strong> 	EDITFIELD_X0 (evanescent, handle) is the x0 edit field.
			%  <strong>40</strong> <strong>LABEL_Y0</strong> 	LABEL_Y0 (evanescent, handle) is the label of the y0 edit field.
			%  <strong>41</strong> <strong>EDITFIELD_Y0</strong> 	EDITFIELD_Y0 (evanescent, handle) is the y0 edit field.
			%  <strong>42</strong> <strong>LABEL_W</strong> 	LABEL_W (evanescent, handle) is the label of the witdth edit field.
			%  <strong>43</strong> <strong>EDITFIELD_W</strong> 	EDITFIELD_W (evanescent, handle) is the width edit field.
			%  <strong>44</strong> <strong>LABEL_H</strong> 	LABEL_H (evanescent, handle) is the label of the height edit field.
			%  <strong>45</strong> <strong>EDITFIELD_H</strong> 	EDITFIELD_H (evanescent, handle) is the height edit field.
			%
			% See also Category, Format.
			
			pr = pr@SettingsPP(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the prop panel for position settings.
			%
			% BUILD = SettingsPositionPP.GETBUILD() returns the build of 'SettingsPositionPP'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the prop panel for position settings PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('SettingsPositionPP') returns the build of 'SettingsPositionPP'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('SettingsPositionPP')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the prop panel for position settings.
			%
			% CLASS = SettingsPositionPP.GETCLASS() returns the class 'SettingsPositionPP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel for position settings PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SettingsPositionPP') returns 'SettingsPositionPP'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SettingsPositionPP')
			%  are less computationally efficient.
			
			pr_class = 'SettingsPositionPP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel for position settings.
			%
			% LIST = SettingsPositionPP.GETSUBCLASSES() returns all subclasses of 'SettingsPositionPP'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel for position settings PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SettingsPositionPP') returns all subclasses of 'SettingsPositionPP'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SettingsPositionPP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel for position settings.
			%
			% PROPS = SettingsPositionPP.GETPROPS() returns the property list of prop panel for position settings
			%  as a row vector.
			%
			% PROPS = SettingsPositionPP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel for position settings PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SettingsPositionPP'[, CATEGORY]) returns the property list of 'SettingsPositionPP'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SettingsPositionPP')
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
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 23 24 29];
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 20 21 22];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 27 28 30 31 32 33 34 35 37 38 39 40 41 42 43 44 45];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel for position settings.
			%
			% N = SettingsPositionPP.GETPROPNUMBER() returns the property number of prop panel for position settings.
			%
			% N = SettingsPositionPP.GETPROPNUMBER(CATEGORY) returns the property number of prop panel for position settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel for position settings PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SettingsPositionPP') returns the property number of 'SettingsPositionPP'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SettingsPositionPP')
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
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 4;
				case 6 % Category.QUERY
					prop_number = 10;
				case 7 % Category.EVANESCENT
					prop_number = 19;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 5;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel for position settings/error.
			%
			% CHECK = SettingsPositionPP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SettingsPositionPP, PROP) checks whether PROP exists for SettingsPositionPP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsPositionPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsPositionPP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsPositionPP:WrongInput]
			%  Element.EXISTSPROP(SettingsPositionPP, PROP) throws error if PROP does NOT exist for SettingsPositionPP.
			%   Error id: [BRAPH2:SettingsPositionPP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 45 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsPositionPP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsPositionPP:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsPositionPP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel for position settings/error.
			%
			% CHECK = SettingsPositionPP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SettingsPositionPP, TAG) checks whether TAG exists for SettingsPositionPP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsPositionPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsPositionPP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsPositionPP:WrongInput]
			%  Element.EXISTSTAG(SettingsPositionPP, TAG) throws error if TAG does NOT exist for SettingsPositionPP.
			%   Error id: [BRAPH2:SettingsPositionPP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'CHECKBOX_AUTOPOS'  'LABEL_X0'  'EDITFIELD_X0'  'LABEL_Y0'  'EDITFIELD_Y0'  'LABEL_W'  'EDITFIELD_W'  'LABEL_H'  'EDITFIELD_H' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsPositionPP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsPositionPP:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SettingsPositionPP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsPositionPP, POINTER) returns property number of POINTER of SettingsPositionPP.
			%  PROPERTY = PR.GETPROPPROP(SettingsPositionPP, POINTER) returns property number of POINTER of SettingsPositionPP.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'CHECKBOX_AUTOPOS'  'LABEL_X0'  'EDITFIELD_X0'  'LABEL_Y0'  'EDITFIELD_Y0'  'LABEL_W'  'EDITFIELD_W'  'LABEL_H'  'EDITFIELD_H' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(SettingsPositionPP, POINTER) returns tag of POINTER of SettingsPositionPP.
			%  TAG = PR.GETPROPTAG(SettingsPositionPP, POINTER) returns tag of POINTER of SettingsPositionPP.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				settingspositionpp_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'CHECKBOX_AUTOPOS'  'LABEL_X0'  'EDITFIELD_X0'  'LABEL_Y0'  'EDITFIELD_Y0'  'LABEL_W'  'EDITFIELD_W'  'LABEL_H'  'EDITFIELD_H' };
				tag = settingspositionpp_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsPositionPP, POINTER) returns category of POINTER of SettingsPositionPP.
			%  CATEGORY = PR.GETPROPCATEGORY(SettingsPositionPP, POINTER) returns category of POINTER of SettingsPositionPP.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsPositionPP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingspositionpp_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  7  7  7  7  7  7  7  7  7 };
			prop_category = settingspositionpp_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsPositionPP, POINTER) returns format of POINTER of SettingsPositionPP.
			%  FORMAT = PR.GETPROPFORMAT(SettingsPositionPP, POINTER) returns format of POINTER of SettingsPositionPP.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsPositionPP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingspositionpp_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  4  18  18  18  18  18  18  18  18  18 };
			prop_format = settingspositionpp_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsPositionPP, POINTER) returns description of POINTER of SettingsPositionPP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SettingsPositionPP, POINTER) returns description of POINTER of SettingsPositionPP.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsPositionPP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingspositionpp_description_list = { 'ELCLASS (constant, string) is the class of the property panel for position settings.'  'NAME (constant, string) is the name of the property panel for position settings.'  'DESCRIPTION (constant, string) is the description of the property panel for position settings.'  'TEMPLATE (parameter, item) is the template of the property panel for position settings.'  'ID (data, string) is a few-letter code for the property panel for position settings.'  'LABEL (metadata, string) is an extended label of the property panel for position settings.'  'NOTES (metadata, string) are some specific notes about the property panel for position settings.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the property panel for position settings.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.'  'CHECKBOX_AUTOPOS (evanescent, handle) is the autopositioning checkbox.'  'LABEL_X0 (evanescent, handle) is the label of the x0 edit field.'  'EDITFIELD_X0 (evanescent, handle) is the x0 edit field.'  'LABEL_Y0 (evanescent, handle) is the label of the y0 edit field.'  'EDITFIELD_Y0 (evanescent, handle) is the y0 edit field.'  'LABEL_W (evanescent, handle) is the label of the witdth edit field.'  'EDITFIELD_W (evanescent, handle) is the width edit field.'  'LABEL_H (evanescent, handle) is the label of the height edit field.'  'EDITFIELD_H (evanescent, handle) is the height edit field.' };
			prop_description = settingspositionpp_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsPositionPP, POINTER) returns settings of POINTER of SettingsPositionPP.
			%  SETTINGS = PR.GETPROPSETTINGS(SettingsPositionPP, POINTER) returns settings of POINTER of SettingsPositionPP.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsPositionPP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % SettingsPositionPP.ENABLE
					prop_settings = Format.getFormatSettings(4);
				case 37 % SettingsPositionPP.CHECKBOX_AUTOPOS
					prop_settings = Format.getFormatSettings(18);
				case 38 % SettingsPositionPP.LABEL_X0
					prop_settings = Format.getFormatSettings(18);
				case 39 % SettingsPositionPP.EDITFIELD_X0
					prop_settings = Format.getFormatSettings(18);
				case 40 % SettingsPositionPP.LABEL_Y0
					prop_settings = Format.getFormatSettings(18);
				case 41 % SettingsPositionPP.EDITFIELD_Y0
					prop_settings = Format.getFormatSettings(18);
				case 42 % SettingsPositionPP.LABEL_W
					prop_settings = Format.getFormatSettings(18);
				case 43 % SettingsPositionPP.EDITFIELD_W
					prop_settings = Format.getFormatSettings(18);
				case 44 % SettingsPositionPP.LABEL_H
					prop_settings = Format.getFormatSettings(18);
				case 45 % SettingsPositionPP.EDITFIELD_H
					prop_settings = Format.getFormatSettings(18);
				case 4 % SettingsPositionPP.TEMPLATE
					prop_settings = 'SettingsPositionPP';
				otherwise
					prop_settings = getPropSettings@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsPositionPP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsPositionPP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsPositionPP, POINTER) returns the default value of POINTER of SettingsPositionPP.
			%  DEFAULT = PR.GETPROPDEFAULT(SettingsPositionPP, POINTER) returns the default value of POINTER of SettingsPositionPP.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsPositionPP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % SettingsPositionPP.ENABLE
					prop_default = true;
				case 37 % SettingsPositionPP.CHECKBOX_AUTOPOS
					prop_default = Format.getFormatDefault(18, SettingsPositionPP.getPropSettings(prop));
				case 38 % SettingsPositionPP.LABEL_X0
					prop_default = Format.getFormatDefault(18, SettingsPositionPP.getPropSettings(prop));
				case 39 % SettingsPositionPP.EDITFIELD_X0
					prop_default = Format.getFormatDefault(18, SettingsPositionPP.getPropSettings(prop));
				case 40 % SettingsPositionPP.LABEL_Y0
					prop_default = Format.getFormatDefault(18, SettingsPositionPP.getPropSettings(prop));
				case 41 % SettingsPositionPP.EDITFIELD_Y0
					prop_default = Format.getFormatDefault(18, SettingsPositionPP.getPropSettings(prop));
				case 42 % SettingsPositionPP.LABEL_W
					prop_default = Format.getFormatDefault(18, SettingsPositionPP.getPropSettings(prop));
				case 43 % SettingsPositionPP.EDITFIELD_W
					prop_default = Format.getFormatDefault(18, SettingsPositionPP.getPropSettings(prop));
				case 44 % SettingsPositionPP.LABEL_H
					prop_default = Format.getFormatDefault(18, SettingsPositionPP.getPropSettings(prop));
				case 45 % SettingsPositionPP.EDITFIELD_H
					prop_default = Format.getFormatDefault(18, SettingsPositionPP.getPropSettings(prop));
				case 1 % SettingsPositionPP.ELCLASS
					prop_default = 'SettingsPositionPP';
				case 2 % SettingsPositionPP.NAME
					prop_default = 'Prop Panel for Position Settings';
				case 3 % SettingsPositionPP.DESCRIPTION
					prop_default = 'A Prop Panel for Position Settings (SettingsPositionPP) plots the panel for position settings, including a checkbox for autopositioning and numeric edit fields for x0, y0, height and width. It works for all categories.';
				case 4 % SettingsPositionPP.TEMPLATE
					prop_default = Format.getFormatDefault(8, SettingsPositionPP.getPropSettings(prop));
				case 5 % SettingsPositionPP.ID
					prop_default = 'SettingsPositionPP ID';
				case 6 % SettingsPositionPP.LABEL
					prop_default = 'SettingsPositionPP label';
				case 7 % SettingsPositionPP.NOTES
					prop_default = 'SettingsPositionPP notes';
				case 23 % SettingsPositionPP.EL
					prop_default = PanelFig();
				case 24 % SettingsPositionPP.PROP
					prop_default = 20;
				case 25 % SettingsPositionPP.HEIGHT
					prop_default = 48;
				otherwise
					prop_default = getPropDefault@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsPositionPP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsPositionPP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsPositionPP, POINTER) returns the conditioned default value of POINTER of SettingsPositionPP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SettingsPositionPP, POINTER) returns the conditioned default value of POINTER of SettingsPositionPP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsPositionPP.getPropProp(pointer);
			
			prop_default = SettingsPositionPP.conditioning(prop, SettingsPositionPP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsPositionPP, PROP, VALUE) checks VALUE format for PROP of SettingsPositionPP.
			%  CHECK = PR.CHECKPROP(SettingsPositionPP, PROP, VALUE) checks VALUE format for PROP of SettingsPositionPP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SettingsPositionPP:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:SettingsPositionPP:WrongInput
			%  Element.CHECKPROP(SettingsPositionPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsPositionPP.
			%   Error id: BRAPH2:SettingsPositionPP:WrongInput
			%  PR.CHECKPROP(SettingsPositionPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsPositionPP.
			%   Error id: BRAPH2:SettingsPositionPP:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsPositionPP.getPropProp(pointer);
			
			switch prop
				case 36 % SettingsPositionPP.ENABLE
					check = Format.checkFormat(4, value, SettingsPositionPP.getPropSettings(prop));
				case 37 % SettingsPositionPP.CHECKBOX_AUTOPOS
					check = Format.checkFormat(18, value, SettingsPositionPP.getPropSettings(prop));
				case 38 % SettingsPositionPP.LABEL_X0
					check = Format.checkFormat(18, value, SettingsPositionPP.getPropSettings(prop));
				case 39 % SettingsPositionPP.EDITFIELD_X0
					check = Format.checkFormat(18, value, SettingsPositionPP.getPropSettings(prop));
				case 40 % SettingsPositionPP.LABEL_Y0
					check = Format.checkFormat(18, value, SettingsPositionPP.getPropSettings(prop));
				case 41 % SettingsPositionPP.EDITFIELD_Y0
					check = Format.checkFormat(18, value, SettingsPositionPP.getPropSettings(prop));
				case 42 % SettingsPositionPP.LABEL_W
					check = Format.checkFormat(18, value, SettingsPositionPP.getPropSettings(prop));
				case 43 % SettingsPositionPP.EDITFIELD_W
					check = Format.checkFormat(18, value, SettingsPositionPP.getPropSettings(prop));
				case 44 % SettingsPositionPP.LABEL_H
					check = Format.checkFormat(18, value, SettingsPositionPP.getPropSettings(prop));
				case 45 % SettingsPositionPP.EDITFIELD_H
					check = Format.checkFormat(18, value, SettingsPositionPP.getPropSettings(prop));
				case 4 % SettingsPositionPP.TEMPLATE
					check = Format.checkFormat(8, value, SettingsPositionPP.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@SettingsPP(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsPositionPP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsPositionPP:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsPositionPP.getPropTag(prop) ' (' SettingsPositionPP.getFormatTag(SettingsPositionPP.getPropFormat(prop)) ').'] ...
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
				case 37 % SettingsPositionPP.CHECKBOX_AUTOPOS
					el = pr.get('EL');
					prop = pr.get('PROP');
					checkbox_autopos = uicheckbox( ...
						'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'CHECKBOX_AUTOPOS', ...
					    'Text', 'auto', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('AUTOPOS')) ' ' el.get(prop).getPropDescription('AUTOPOS')], ...
					    'ValueChangedFcn', {@cb_position} ...
					    );
					value = checkbox_autopos;
					
				case 38 % SettingsPositionPP.LABEL_X0
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_x0 =  uilabel( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'LABEL_X0', ...
					    'Text', 'x<sub>0</sub>', ...
					    'Interpreter', 'html', ...
					    'FontSize', 12, ...
					    'HorizontalAlignment', 'right', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('X0')) ' ' el.get(prop).getPropDescription('X0')], ...
					    'BackgroundColor', pr.get('BKGCOLOR') ...
					    );
					value = label_x0;
					
				case 39 % SettingsPositionPP.EDITFIELD_X0
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_x0 = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD_X0', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('X0')) ' ' el.get(prop).getPropDescription('X0')], ...
					    'ValueChangedFcn', {@cb_position} ... % callback in CHECKBOX_AUTOPOS
					    );
					value = editfield_x0;
					
				case 40 % SettingsPositionPP.LABEL_Y0
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_y0 =  uilabel( ...
						'Parent', pr.memorize('H'), ... % H = p for Panel
						'Tag', 'LABEL_Y0', ...
						'Text', 'y<sub>0</sub>', ...
						'Interpreter', 'html', ...
						'FontSize', 12, ...
						'HorizontalAlignment', 'right', ...
						'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('Y0')) ' ' el.get(prop).getPropDescription('Y0')], ...
						'BackgroundColor', pr.get('BKGCOLOR') ...
						);
					value = label_y0;
					
				case 41 % SettingsPositionPP.EDITFIELD_Y0
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_y0 = uieditfield('numeric', ...
						'Parent', pr.memorize('H'), ... % H = p for Panel
						'Tag', 'EDITFIELD_Y0', ...
						'FontSize', 12, ...
						'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('Y0')) ' ' el.get(prop).getPropDescription('Y0')], ...
						'ValueChangedFcn', {@cb_position} ... % callback in CHECKBOX_AUTOPOS
						);
					value = editfield_y0;
					
				case 42 % SettingsPositionPP.LABEL_W
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_w =  uilabel( ...
						'Parent', pr.memorize('H'), ... % H = p for Panel
						'Tag', 'LABEL_W', ...
						'Text', 'w', ...
						'Interpreter', 'html', ...
						'FontSize', 12, ...
						'HorizontalAlignment', 'right', ...
						'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('WIDTH')) ' ' el.get(prop).getPropDescription('WIDTH')], ...
						'BackgroundColor', pr.get('BKGCOLOR') ...
						);
					value = label_w;
					
				case 43 % SettingsPositionPP.EDITFIELD_W
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_w = uieditfield('numeric', ...
						'Parent', pr.memorize('H'), ... % H = p for Panel
						'Tag', 'EDITFIELD_W', ...
						'Limits', [0 +Inf], ...
						'FontSize', 12, ...
						'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('WIDTH')) ' ' el.get(prop).getPropDescription('WIDTH')], ...
						'ValueChangedFcn', {@cb_position} ... % callback in CHECKBOX_AUTOPOS
						);
					value = editfield_w;
					
				case 44 % SettingsPositionPP.LABEL_H
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_h =  uilabel( ...
						'Parent', pr.memorize('H'), ... % H = p for Panel
						'Tag', 'LABEL_H', ...
						'Text', 'h', ...
						'Interpreter', 'html', ...
						'FontSize', 12, ...
						'HorizontalAlignment', 'right', ...
						'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('HEIGHT')) ' ' el.get(prop).getPropDescription('HEIGHT')], ...
						'BackgroundColor', pr.get('BKGCOLOR') ...
						);
					value = label_h;
					
				case 45 % SettingsPositionPP.EDITFIELD_H
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_h = uieditfield('numeric', ...
						'Parent', pr.memorize('H'), ... % H = p for Panel
						'Tag', 'EDITFIELD_H', ...
						'Limits', [0 +Inf], ...
						'FontSize', 12, ...
						'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('HEIGHT')) ' ' el.get(prop).getPropDescription('HEIGHT')], ...
						'ValueChangedFcn', {@cb_position} ... % callback in CHECKBOX_AUTOPOS
					    );
					value = editfield_h;
					
				case 20 % SettingsPositionPP.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('CHECKBOX_AUTOPOS')
					    
					    pr.memorize('LABEL_X0')
					    pr.memorize('EDITFIELD_X0')
					    
					    pr.memorize('LABEL_Y0')
					    pr.memorize('EDITFIELD_Y0')
					    
					    pr.memorize('LABEL_W')
					    pr.memorize('EDITFIELD_W')
					    
					    pr.memorize('LABEL_H')
					    pr.memorize('EDITFIELD_H')
					end
					
				case 21 % SettingsPositionPP.UPDATE
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if el.isLocked(prop) || el.getPropCategory(prop) == 1
					        set(pr.checkbox_autopos, 'Enable', pr.get('ENABLE'))
					        set(pr.editfield_x0, ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.editfield_y0, ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.editfield_w, ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.editfield_h, ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )        
					    end
					    
					    switch el.getPropCategory(prop)
					        case 1
					            set(pr.get('CHECKBOX_AUTOPOS'), 'Value', el.get(prop).get('AUTOPOS'))
					            set(pr.get('EDITFIELD_X0'), 'Value', el.get(prop).get('X0'))
					            set(pr.get('EDITFIELD_Y0'), 'Value', el.get(prop).get('Y0'))
					            set(pr.get('EDITFIELD_W'), 'Value', el.get(prop).get('WIDTH'))
					            set(pr.get('EDITFIELD_H'), 'Value', el.get(prop).get('HEIGHT'))
					            
					        case 2
					            set(pr.get('CHECKBOX_AUTOPOS'), 'Value', el.get(prop).get('AUTOPOS'))
					            set(pr.get('EDITFIELD_X0'), 'Value', el.get(prop).get('X0'))
					            set(pr.get('EDITFIELD_Y0'), 'Value', el.get(prop).get('Y0'))
					            set(pr.get('EDITFIELD_W'), 'Value', el.get(prop).get('WIDTH'))
					            set(pr.get('EDITFIELD_H'), 'Value', el.get(prop).get('HEIGHT'))
					
					        case {3, 4, 8, 9}
					            set(pr.get('CHECKBOX_AUTOPOS'), 'Value', el.get(prop).get('AUTOPOS'))
					            set(pr.get('EDITFIELD_X0'), 'Value', el.get(prop).get('X0'))
					            set(pr.get('EDITFIELD_Y0'), 'Value', el.get(prop).get('Y0'))
					            set(pr.get('EDITFIELD_W'), 'Value', el.get(prop).get('WIDTH'))
					            set(pr.get('EDITFIELD_H'), 'Value', el.get(prop).get('HEIGHT'))
					            
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('AUTOPOS'), 'Callback')
					                set(pr.get('CHECKBOX_AUTOPOS'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('X0'), 'Callback')
					                set(pr.get('EDITFIELD_X0'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('Y0'), 'Callback')
					                set(pr.get('EDITFIELD_Y0'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('WIDTH'), 'Callback')
					                set(pr.get('EDITFIELD_W'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('HEIGHT'), 'Callback')
					                set(pr.get('EDITFIELD_H'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					
					        case {5 6 7}
					            value = el.getr(prop);
					
					            if isa(value, 'NoValue')
					                set(pr.get('CHECKBOX_AUTOPOS'), ...
					                    el.getPropDefault(prop).getPropDefault('AUTOPOS'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_X0'), ...
					                    'Value', el.getPropDefault(prop).getPropDefault('X0'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_Y0'), ...
					                    'Value', el.getPropDefault(prop).getPropDefault('Y0'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_W'), ...
					                    'Value', el.getPropDefault(prop).getPropDefault('WIDTH'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_H'), ...
					                    'Value', el.getPropDefault(prop).getPropDefault('HEIGHT'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            else
					                set(pr.get('CHECKBOX_AUTOPOS'), ...
					                    el.get(prop).get('AUTOPOS'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_X0'), ...
					                    'Value', el.get(prop).get('X0'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_Y0'), ...
					                    'Value', el.get(prop).get('Y0'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_W'), ...
					                    'Value', el.get(prop).get('WIDTH'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_H'), ...
					                    'Value', el.get(prop).get('HEIGHT'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
						end
					end
					
				case 22 % SettingsPositionPP.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('CHECKBOX_AUTOPOS'), 'Position', [4 4 .15*w_p 21])
					
					    set(pr.get('LABEL_X0'), 'Position', [.20*w_p 4 .04*w_p 21])
					    set(pr.get('EDITFIELD_X0'), 'Position', [.25*w_p 4 .12*w_p 21])
					    
					    set(pr.get('LABEL_Y0'), 'Position', [.40*w_p 4 .04*w_p 21])
					    set(pr.get('EDITFIELD_Y0'), 'Position', [.45*w_p 4 .12*w_p 21])
					
					    set(pr.get('LABEL_W'), 'Position', [.60*w_p 4 .04*w_p 21])
					    set(pr.get('EDITFIELD_W'), 'Position', [.65*w_p 4 .12*w_p 21])
					
					    set(pr.get('LABEL_H'), 'Position', [.80*w_p 4 .04*w_p 21])
					    set(pr.get('EDITFIELD_H'), 'Position', [.85*w_p 4 .12*w_p 21])
					end
					
				case 18 % SettingsPositionPP.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('CHECKBOX_AUTOPOS', Element.getNoValue())
					    
					    pr.set('LABEL_X0', Element.getNoValue())
					    pr.set('EDITFIELD_X0', Element.getNoValue())
					    
					    pr.set('LABEL_Y0', Element.getNoValue())
					    pr.set('EDITFIELD_Y0', Element.getNoValue())
					    
					    pr.set('LABEL_W', Element.getNoValue())
					    pr.set('EDITFIELD_W', Element.getNoValue())
					    
					    pr.set('LABEL_H', Element.getNoValue())
					    pr.set('EDITFIELD_H', Element.getNoValue())
					end
					
				otherwise
					if prop <= 35
						value = calculateValue@SettingsPP(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_position(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set( ...
			        'AUTOPOS', get(pr.get('CHECKBOX_AUTOPOS'), 'Value'), ...
			        'X0', get(pr.get('EDITFIELD_X0'), 'Value'), ...
			        'Y0', get(pr.get('EDITFIELD_Y0'), 'Value'), ...
			        'WIDTH', get(pr.get('EDITFIELD_W'), 'Value'), ...
			        'HEIGHT', get(pr.get('EDITFIELD_H'), 'Value') ...
			        )
			end
		end
	end
end
