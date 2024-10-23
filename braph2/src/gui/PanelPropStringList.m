classdef PanelPropStringList < PanelProp
	%PanelPropStringList plots the panel of a property string-list.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% PanelPropStringList plots the panel for a STRINGLIST property with a text area.
	% It works for all categories.
	% 
	% It can be personalized with the following property:
	%  TA_HEIGHT - Text area height in pixels when the table is shown.
	%
	% The list of PanelPropStringList properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the string-list property panel.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the string-list property panel.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the string-list property panel.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the string-list property panel.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the string-list property panel.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the string-list property panel.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the string-list property panel.
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
	%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the editfield.
	%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
	%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
	%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
	%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the prop panel.
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
	%  <strong>36</strong> <strong>ENABLE</strong> 	ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.
	%  <strong>37</strong> <strong>TA_HEIGHT</strong> 	TA_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.
	%  <strong>38</strong> <strong>TEXTAREA</strong> 	TEXTAREA (evanescent, handle) is the string value text area.
	%
	% PanelPropStringList methods (constructor):
	%  PanelPropStringList - constructor
	%
	% PanelPropStringList methods:
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
	% PanelPropStringList methods (display):
	%  tostring - string with information about the string-list prop panel
	%  disp - displays information about the string-list prop panel
	%  tree - displays the tree of the string-list prop panel
	%
	% PanelPropStringList methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two string-list prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the string-list prop panel
	%
	% PanelPropStringList methods (save/load, Static):
	%  save - saves BRAPH2 string-list prop panel as b2 file
	%  load - loads a BRAPH2 string-list prop panel from a b2 file
	%
	% PanelPropStringList method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the string-list prop panel
	%
	% PanelPropStringList method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the string-list prop panel
	%
	% PanelPropStringList methods (inspection, Static):
	%  getClass - returns the class of the string-list prop panel
	%  getSubclasses - returns all subclasses of PanelPropStringList
	%  getProps - returns the property list of the string-list prop panel
	%  getPropNumber - returns the property number of the string-list prop panel
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
	% PanelPropStringList methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropStringList methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropStringList methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropStringList methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropStringList; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropStringList constants</a>.
	%
	%
	% See also uitextarea, GUI, PanelElement.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		ENABLE = 36; %CET: Computational Efficiency Trick
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = 9;
		ENABLE_FORMAT = 4;
		
		TA_HEIGHT = 37; %CET: Computational Efficiency Trick
		TA_HEIGHT_TAG = 'TA_HEIGHT';
		TA_HEIGHT_CATEGORY = 9;
		TA_HEIGHT_FORMAT = 22;
		
		TEXTAREA = 38; %CET: Computational Efficiency Trick
		TEXTAREA_TAG = 'TEXTAREA';
		TEXTAREA_CATEGORY = 7;
		TEXTAREA_FORMAT = 18;
	end
	methods % constructor
		function pr = PanelPropStringList(varargin)
			%PanelPropStringList() creates a string-list prop panel.
			%
			% PanelPropStringList(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropStringList(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PanelPropStringList properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the string-list property panel.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the string-list property panel.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the string-list property panel.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the string-list property panel.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the string-list property panel.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the string-list property panel.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the string-list property panel.
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
			%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the editfield.
			%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
			%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
			%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
			%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the prop panel.
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
			%  <strong>36</strong> <strong>ENABLE</strong> 	ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.
			%  <strong>37</strong> <strong>TA_HEIGHT</strong> 	TA_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.
			%  <strong>38</strong> <strong>TEXTAREA</strong> 	TEXTAREA (evanescent, handle) is the string value text area.
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the string-list prop panel.
			%
			% BUILD = PanelPropStringList.GETBUILD() returns the build of 'PanelPropStringList'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the string-list prop panel PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('PanelPropStringList') returns the build of 'PanelPropStringList'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('PanelPropStringList')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the string-list prop panel.
			%
			% CLASS = PanelPropStringList.GETCLASS() returns the class 'PanelPropStringList'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the string-list prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropStringList') returns 'PanelPropStringList'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropStringList')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropStringList';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the string-list prop panel.
			%
			% LIST = PanelPropStringList.GETSUBCLASSES() returns all subclasses of 'PanelPropStringList'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the string-list prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropStringList') returns all subclasses of 'PanelPropStringList'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'PanelPropStringList' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of string-list prop panel.
			%
			% PROPS = PanelPropStringList.GETPROPS() returns the property list of string-list prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropStringList.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the string-list prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropStringList'[, CATEGORY]) returns the property list of 'PanelPropStringList'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38];
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
					prop_list = [10 15 27 28 30 31 32 33 34 35 38];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36 37];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of string-list prop panel.
			%
			% N = PanelPropStringList.GETPROPNUMBER() returns the property number of string-list prop panel.
			%
			% N = PanelPropStringList.GETPROPNUMBER(CATEGORY) returns the property number of string-list prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the string-list prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropStringList') returns the property number of 'PanelPropStringList'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 38;
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
					prop_number = 11;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 6;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in string-list prop panel/error.
			%
			% CHECK = PanelPropStringList.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropStringList, PROP) checks whether PROP exists for PanelPropStringList.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropStringList:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropStringList:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropStringList:WrongInput]
			%  Element.EXISTSPROP(PanelPropStringList, PROP) throws error if PROP does NOT exist for PanelPropStringList.
			%   Error id: [BRAPH2:PanelPropStringList:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 38 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropStringList:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropStringList:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropStringList.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in string-list prop panel/error.
			%
			% CHECK = PanelPropStringList.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropStringList, TAG) checks whether TAG exists for PanelPropStringList.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropStringList:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropStringList:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropStringList:WrongInput]
			%  Element.EXISTSTAG(PanelPropStringList, TAG) throws error if TAG does NOT exist for PanelPropStringList.
			%   Error id: [BRAPH2:PanelPropStringList:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'TA_HEIGHT'  'TEXTAREA' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropStringList:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropStringList:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropStringList.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropStringList, POINTER) returns property number of POINTER of PanelPropStringList.
			%  PROPERTY = PR.GETPROPPROP(PanelPropStringList, POINTER) returns property number of POINTER of PanelPropStringList.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'TA_HEIGHT'  'TEXTAREA' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(PanelPropStringList, POINTER) returns tag of POINTER of PanelPropStringList.
			%  TAG = PR.GETPROPTAG(PanelPropStringList, POINTER) returns tag of POINTER of PanelPropStringList.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				panelpropstringlist_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'TA_HEIGHT'  'TEXTAREA' };
				tag = panelpropstringlist_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropStringList, POINTER) returns category of POINTER of PanelPropStringList.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropStringList, POINTER) returns category of POINTER of PanelPropStringList.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropStringList.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelpropstringlist_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  9  7 };
			prop_category = panelpropstringlist_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropStringList, POINTER) returns format of POINTER of PanelPropStringList.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropStringList, POINTER) returns format of POINTER of PanelPropStringList.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropStringList.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelpropstringlist_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  4  22  18 };
			prop_format = panelpropstringlist_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropStringList, POINTER) returns description of POINTER of PanelPropStringList.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropStringList, POINTER) returns description of POINTER of PanelPropStringList.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropStringList.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelpropstringlist_description_list = { 'ELCLASS (constant, string) is the class of the string-list property panel.'  'NAME (constant, string) is the name of the string-list property panel.'  'DESCRIPTION (constant, string) is the description of the string-list property panel.'  'TEMPLATE (parameter, item) is the template of the string-list property panel.'  'ID (data, string) is a few-letter code for the string-list property panel.'  'LABEL (metadata, string) is an extended label of the string-list property panel.'  'NOTES (metadata, string) are some specific notes about the string-list property panel.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the editfield.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the prop panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.'  'TA_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.'  'TEXTAREA (evanescent, handle) is the string value text area.' };
			prop_description = panelpropstringlist_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropStringList, POINTER) returns settings of POINTER of PanelPropStringList.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropStringList, POINTER) returns settings of POINTER of PanelPropStringList.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropStringList.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % PanelPropStringList.ENABLE
					prop_settings = Format.getFormatSettings(4);
				case 37 % PanelPropStringList.TA_HEIGHT
					prop_settings = Format.getFormatSettings(22);
				case 38 % PanelPropStringList.TEXTAREA
					prop_settings = Format.getFormatSettings(18);
				case 4 % PanelPropStringList.TEMPLATE
					prop_settings = 'PanelPropStringList';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropStringList.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropStringList.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropStringList, POINTER) returns the default value of POINTER of PanelPropStringList.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropStringList, POINTER) returns the default value of POINTER of PanelPropStringList.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropStringList.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % PanelPropStringList.ENABLE
					prop_default = true;
				case 37 % PanelPropStringList.TA_HEIGHT
					prop_default = 240;
				case 38 % PanelPropStringList.TEXTAREA
					prop_default = Format.getFormatDefault(18, PanelPropStringList.getPropSettings(prop));
				case 1 % PanelPropStringList.ELCLASS
					prop_default = 'PanelPropStringList';
				case 2 % PanelPropStringList.NAME
					prop_default = 'String-List Prop Panel';
				case 3 % PanelPropStringList.DESCRIPTION
					prop_default = 'PanelPropStringList plots the panel for a STRINGLIST property with a text area. It works for all categories. It can be personalized with the following props: TA_HEIGHT.';
				case 4 % PanelPropStringList.TEMPLATE
					prop_default = Format.getFormatDefault(8, PanelPropStringList.getPropSettings(prop));
				case 5 % PanelPropStringList.ID
					prop_default = 'PanelPropStringList ID';
				case 6 % PanelPropStringList.LABEL
					prop_default = 'PanelPropStringList label';
				case 7 % PanelPropStringList.NOTES
					prop_default = 'PanelPropStringList notes';
				case 23 % PanelPropStringList.EL
					prop_default = Graph();
				case 24 % PanelPropStringList.PROP
					prop_default = 16;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropStringList.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropStringList.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropStringList, POINTER) returns the conditioned default value of POINTER of PanelPropStringList.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropStringList, POINTER) returns the conditioned default value of POINTER of PanelPropStringList.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropStringList.getPropProp(pointer);
			
			prop_default = PanelPropStringList.conditioning(prop, PanelPropStringList.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropStringList, PROP, VALUE) checks VALUE format for PROP of PanelPropStringList.
			%  CHECK = PR.CHECKPROP(PanelPropStringList, PROP, VALUE) checks VALUE format for PROP of PanelPropStringList.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:PanelPropStringList:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:PanelPropStringList:WrongInput
			%  Element.CHECKPROP(PanelPropStringList, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropStringList.
			%   Error id: BRAPH2:PanelPropStringList:WrongInput
			%  PR.CHECKPROP(PanelPropStringList, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropStringList.
			%   Error id: BRAPH2:PanelPropStringList:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropStringList')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropStringList.getPropProp(pointer);
			
			switch prop
				case 36 % PanelPropStringList.ENABLE
					check = Format.checkFormat(4, value, PanelPropStringList.getPropSettings(prop));
				case 37 % PanelPropStringList.TA_HEIGHT
					check = Format.checkFormat(22, value, PanelPropStringList.getPropSettings(prop));
				case 38 % PanelPropStringList.TEXTAREA
					check = Format.checkFormat(18, value, PanelPropStringList.getPropSettings(prop));
				case 4 % PanelPropStringList.TEMPLATE
					check = Format.checkFormat(8, value, PanelPropStringList.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropStringList:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropStringList:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropStringList.getPropTag(prop) ' (' PanelPropStringList.getFormatTag(PanelPropStringList.getPropFormat(prop)) ').'] ...
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
				case 38 % PanelPropStringList.TEXTAREA
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					textarea = uitextarea( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'TEXTAREA', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_textarea} ...
					    );
					
					value = textarea;
					
				case 20 % PanelPropStringList.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('TEXTAREA')
					end
					
				case 21 % PanelPropStringList.UPDATE
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value
					
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    if any(el.getPropCategory(prop) == [5 6 7]) && isa(el.getr(prop), 'NoValue')
					        pr.set('HEIGHT', 24)
					    else
					        pr.set('HEIGHT', min(24 + 24 * (length(el.get(prop)) + 1), pr.get('TA_HEIGHT')))
					    end
					    
					    switch el.getPropCategory(prop)
					        case 1
					            set(pr.get('TEXTAREA'), ...
					                'Value', cell2str(el.get(prop)), ...
					                'Editable', 'off', ...
					                'Enable', pr.get('ENABLE') ...
					                )
					            
					        case 2
					            set(pr.get('TEXTAREA'), 'Value', cell2str(el.get(prop)))
					
					            if el.isLocked(prop)
					                set(pr.get('TEXTAREA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            
					        case {3, 4, 8, 9}
					            set(pr.get('TEXTAREA'), 'Value', cell2str(el.get(prop)))
					
					            prop_value = el.getr(prop);
					            if el.isLocked(prop) || isa(prop_value, 'Callback')
					                set(pr.get('TEXTAREA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					
					        case {5 6 7}
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                if isempty(el.getPropDefault(prop))
					                    set(pr.get('TEXTAREA'), 'Visible', false)
					                else
					                    set(pr.get('TEXTAREA'), ...
					                        'Value', cell2str(el.getPropDefault(prop)), ...
					                        'Visible', true ...
					                        )
					                end
					            else
					                set(pr.get('TEXTAREA'), ...
					                    'Value', cell2str(el.get(prop)), ...
					                    'Visible', true ...
					                    )
					            end
					            
					            set(pr.get('TEXTAREA'), ...
					                'Editable', 'off', ...
					                'Enable', pr.get('ENABLE') ...
					                )
					    end
					end
					
				case 22 % PanelPropStringList.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TEXTAREA'), 'Position', [4 4 w_p-8 max(1, pr.get('HEIGHT')-27)])
					end
					
				case 18 % PanelPropStringList.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('TEXTAREA', Element.getNoValue())
					end
					
				otherwise
					if prop <= 35
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_textarea(~, ~)
			    value = get(pr.get('TEXTAREA'), 'Value');
			    pr.get('EL').set(pr.get('PROP'), str2cell(value))
			end
		end
	end
end
