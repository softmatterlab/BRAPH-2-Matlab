classdef PanelPropIDict < PanelProp
	%PanelPropIDict plots the panel of a property idict.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% An Indexed-Dictionary Prop Panel (PanelPropIDict) plots the panel for a IDICT property with a button.
	%  It works for all categories.
	%
	% The list of PanelPropIDict properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the idict property panel.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the idict property panel.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the idict property panel.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the idict property panel.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the idict property panel.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the idict property panel.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the idict property panel.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the item figure.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the item figure.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles and closes the dependent figures when the panel is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figure.
	%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the property panel.
	%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the button.
	%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
	%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
	%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
	%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the property panel.
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
	%  <strong>36</strong> <strong>BUTTON_TEXT</strong> 	BUTTON_TEXT (gui, string) is the button text.
	%  <strong>37</strong> <strong>BUTTON</strong> 	BUTTON (evanescent, handle) is the logical value dropdown.
	%  <strong>38</strong> <strong>GUICLASS</strong> 	GUICLASS (gui, option) is the GUI kind.
	%  <strong>39</strong> <strong>GUI_ITEM</strong> 	GUI_ITEM (data, item) is the handle to the item figure.
	%
	% PanelPropIDict methods (constructor):
	%  PanelPropIDict - constructor
	%
	% PanelPropIDict methods:
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
	% PanelPropIDict methods (display):
	%  tostring - string with information about the idict prop panel
	%  disp - displays information about the idict prop panel
	%  tree - displays the tree of the idict prop panel
	%
	% PanelPropIDict methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two idict prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the idict prop panel
	%
	% PanelPropIDict methods (save/load, Static):
	%  save - saves BRAPH2 idict prop panel as b2 file
	%  load - loads a BRAPH2 idict prop panel from a b2 file
	%
	% PanelPropIDict method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the idict prop panel
	%
	% PanelPropIDict method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the idict prop panel
	%
	% PanelPropIDict methods (inspection, Static):
	%  getClass - returns the class of the idict prop panel
	%  getSubclasses - returns all subclasses of PanelPropIDict
	%  getProps - returns the property list of the idict prop panel
	%  getPropNumber - returns the property number of the idict prop panel
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
	% PanelPropIDict methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropIDict methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropIDict methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropIDict methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropIDict; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropIDict constants</a>.
	%
	%
	% See also uibutton, GUI, PanelElement, GUIElement.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		BUTTON_TEXT = 36; %CET: Computational Efficiency Trick
		BUTTON_TEXT_TAG = 'BUTTON_TEXT';
		BUTTON_TEXT_CATEGORY = 9;
		BUTTON_TEXT_FORMAT = 2;
		
		BUTTON = 37; %CET: Computational Efficiency Trick
		BUTTON_TAG = 'BUTTON';
		BUTTON_CATEGORY = 7;
		BUTTON_FORMAT = 18;
		
		GUICLASS = 38; %CET: Computational Efficiency Trick
		GUICLASS_TAG = 'GUICLASS';
		GUICLASS_CATEGORY = 9;
		GUICLASS_FORMAT = 5;
		
		GUI_ITEM = 39; %CET: Computational Efficiency Trick
		GUI_ITEM_TAG = 'GUI_ITEM';
		GUI_ITEM_CATEGORY = 4;
		GUI_ITEM_FORMAT = 8;
	end
	methods % constructor
		function pr = PanelPropIDict(varargin)
			%PanelPropIDict() creates a idict prop panel.
			%
			% PanelPropIDict(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropIDict(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PanelPropIDict properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the idict property panel.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the idict property panel.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the idict property panel.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the idict property panel.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the idict property panel.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the idict property panel.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the idict property panel.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the item figure.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the item figure.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles and closes the dependent figures when the panel is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figure.
			%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the property panel.
			%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the button.
			%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
			%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
			%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
			%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the property panel.
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
			%  <strong>36</strong> <strong>BUTTON_TEXT</strong> 	BUTTON_TEXT (gui, string) is the button text.
			%  <strong>37</strong> <strong>BUTTON</strong> 	BUTTON (evanescent, handle) is the logical value dropdown.
			%  <strong>38</strong> <strong>GUICLASS</strong> 	GUICLASS (gui, option) is the GUI kind.
			%  <strong>39</strong> <strong>GUI_ITEM</strong> 	GUI_ITEM (data, item) is the handle to the item figure.
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the idict prop panel.
			%
			% BUILD = PanelPropIDict.GETBUILD() returns the build of 'PanelPropIDict'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the idict prop panel PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('PanelPropIDict') returns the build of 'PanelPropIDict'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('PanelPropIDict')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the idict prop panel.
			%
			% CLASS = PanelPropIDict.GETCLASS() returns the class 'PanelPropIDict'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the idict prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropIDict') returns 'PanelPropIDict'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropIDict')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropIDict';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the idict prop panel.
			%
			% LIST = PanelPropIDict.GETSUBCLASSES() returns all subclasses of 'PanelPropIDict'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the idict prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropIDict') returns all subclasses of 'PanelPropIDict'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'PanelPropIDict' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of idict prop panel.
			%
			% PROPS = PanelPropIDict.GETPROPS() returns the property list of idict prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropIDict.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the idict prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropIDict'[, CATEGORY]) returns the property list of 'PanelPropIDict'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39];
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
					prop_list = [5 23 24 29 39];
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 20 21 22];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 27 28 30 31 32 33 34 35 37];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36 38];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of idict prop panel.
			%
			% N = PanelPropIDict.GETPROPNUMBER() returns the property number of idict prop panel.
			%
			% N = PanelPropIDict.GETPROPNUMBER(CATEGORY) returns the property number of idict prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the idict prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropIDict') returns the property number of 'PanelPropIDict'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 39;
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
					prop_number = 5;
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
			%EXISTSPROP checks whether property exists in idict prop panel/error.
			%
			% CHECK = PanelPropIDict.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropIDict, PROP) checks whether PROP exists for PanelPropIDict.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropIDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropIDict:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropIDict:WrongInput]
			%  Element.EXISTSPROP(PanelPropIDict, PROP) throws error if PROP does NOT exist for PanelPropIDict.
			%   Error id: [BRAPH2:PanelPropIDict:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 39 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropIDict:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropIDict:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropIDict.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in idict prop panel/error.
			%
			% CHECK = PanelPropIDict.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropIDict, TAG) checks whether TAG exists for PanelPropIDict.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropIDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropIDict:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropIDict:WrongInput]
			%  Element.EXISTSTAG(PanelPropIDict, TAG) throws error if TAG does NOT exist for PanelPropIDict.
			%   Error id: [BRAPH2:PanelPropIDict:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'BUTTON_TEXT'  'BUTTON'  'GUICLASS'  'GUI_ITEM' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropIDict:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropIDict:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropIDict.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropIDict, POINTER) returns property number of POINTER of PanelPropIDict.
			%  PROPERTY = PR.GETPROPPROP(PanelPropIDict, POINTER) returns property number of POINTER of PanelPropIDict.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'BUTTON_TEXT'  'BUTTON'  'GUICLASS'  'GUI_ITEM' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(PanelPropIDict, POINTER) returns tag of POINTER of PanelPropIDict.
			%  TAG = PR.GETPROPTAG(PanelPropIDict, POINTER) returns tag of POINTER of PanelPropIDict.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				panelpropidict_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'BUTTON_TEXT'  'BUTTON'  'GUICLASS'  'GUI_ITEM' };
				tag = panelpropidict_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropIDict, POINTER) returns category of POINTER of PanelPropIDict.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropIDict, POINTER) returns category of POINTER of PanelPropIDict.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropIDict.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelpropidict_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  7  9  4 };
			prop_category = panelpropidict_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropIDict, POINTER) returns format of POINTER of PanelPropIDict.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropIDict, POINTER) returns format of POINTER of PanelPropIDict.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropIDict.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelpropidict_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  2  18  5  8 };
			prop_format = panelpropidict_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropIDict, POINTER) returns description of POINTER of PanelPropIDict.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropIDict, POINTER) returns description of POINTER of PanelPropIDict.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropIDict.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelpropidict_description_list = { 'ELCLASS (constant, string) is the class of the idict property panel.'  'NAME (constant, string) is the name of the idict property panel.'  'DESCRIPTION (constant, string) is the description of the idict property panel.'  'TEMPLATE (parameter, item) is the template of the idict property panel.'  'ID (data, string) is a few-letter code for the idict property panel.'  'LABEL (metadata, string) is an extended label of the idict property panel.'  'NOTES (metadata, string) are some specific notes about the idict property panel.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figure.'  'DELETE (query, logical) resets the handles and closes the dependent figures when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figure.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the button.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the property panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'BUTTON_TEXT (gui, string) is the button text.'  'BUTTON (evanescent, handle) is the logical value dropdown.'  'GUICLASS (gui, option) is the GUI kind.'  'GUI_ITEM (data, item) is the handle to the item figure.' };
			prop_description = panelpropidict_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropIDict, POINTER) returns settings of POINTER of PanelPropIDict.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropIDict, POINTER) returns settings of POINTER of PanelPropIDict.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropIDict.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % PanelPropIDict.BUTTON_TEXT
					prop_settings = Format.getFormatSettings(2);
				case 37 % PanelPropIDict.BUTTON
					prop_settings = Format.getFormatSettings(18);
				case 38 % PanelPropIDict.GUICLASS
					prop_settings = {'GUIElement', 'GUIFig'};
				case 39 % PanelPropIDict.GUI_ITEM
					prop_settings = 'GUIElement';
				case 4 % PanelPropIDict.TEMPLATE
					prop_settings = 'PanelPropIDict';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropIDict.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropIDict.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropIDict, POINTER) returns the default value of POINTER of PanelPropIDict.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropIDict, POINTER) returns the default value of POINTER of PanelPropIDict.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropIDict.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % PanelPropIDict.BUTTON_TEXT
					prop_default = Format.getFormatDefault(2, PanelPropIDict.getPropSettings(prop));
				case 37 % PanelPropIDict.BUTTON
					prop_default = Format.getFormatDefault(18, PanelPropIDict.getPropSettings(prop));
				case 38 % PanelPropIDict.GUICLASS
					prop_default = Format.getFormatDefault(5, PanelPropIDict.getPropSettings(prop));
				case 39 % PanelPropIDict.GUI_ITEM
					prop_default = Format.getFormatDefault(8, PanelPropIDict.getPropSettings(prop));
				case 1 % PanelPropIDict.ELCLASS
					prop_default = 'PanelPropIDict';
				case 2 % PanelPropIDict.NAME
					prop_default = 'Indexed-Dictionary Prop Panel';
				case 3 % PanelPropIDict.DESCRIPTION
					prop_default = 'An Indexed-Dictionary Prop Panel (PanelPropIDict) plots the panel for a IDICT property with a button. It works for all categories.';
				case 4 % PanelPropIDict.TEMPLATE
					prop_default = Format.getFormatDefault(8, PanelPropIDict.getPropSettings(prop));
				case 5 % PanelPropIDict.ID
					prop_default = 'PanelPropIDict ID';
				case 6 % PanelPropIDict.LABEL
					prop_default = 'PanelPropIDict label';
				case 7 % PanelPropIDict.NOTES
					prop_default = 'PanelPropIDict notes';
				case 23 % PanelPropIDict.EL
					prop_default = Pipeline();
				case 24 % PanelPropIDict.PROP
					prop_default = 11;
				case 25 % PanelPropIDict.HEIGHT
					prop_default = 48;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropIDict.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropIDict.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropIDict, POINTER) returns the conditioned default value of POINTER of PanelPropIDict.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropIDict, POINTER) returns the conditioned default value of POINTER of PanelPropIDict.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropIDict.getPropProp(pointer);
			
			prop_default = PanelPropIDict.conditioning(prop, PanelPropIDict.getPropDefault(prop));
		end
	end
	methods (Access=protected) % preset
		function value = preset(pr, prop, value)
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
				case 39 % PanelPropIDict.GUI_ITEM
					if isa(value.getr('PE'), 'NoValue') % i.e., default initialization
					    f = ancestor(pr.get('H'), 'figure');
					
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    value = GUIElement( ...
					        'PE', el.memorize(prop), ... % ensure that the prop is stored
					        'POSITION', [ ...
					            x0(f, 'normalized')+w(f, 'normalized') ...
					            y0(f, 'normalized') ...
					            w(f, 'normalized') ...
					            h(f, 'normalized') ...
					            ], ...
					        'WAITBAR', pr.getCallback('WAITBAR'), ...
					        'CLOSEREQ', false ...
					        );
					end
					
				otherwise
					if prop <= 35
						value = preset@PanelProp(pr, prop, value);
					end
			end
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
			%  CHECK = Element.CHECKPROP(PanelPropIDict, PROP, VALUE) checks VALUE format for PROP of PanelPropIDict.
			%  CHECK = PR.CHECKPROP(PanelPropIDict, PROP, VALUE) checks VALUE format for PROP of PanelPropIDict.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:PanelPropIDict:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:PanelPropIDict:WrongInput
			%  Element.CHECKPROP(PanelPropIDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropIDict.
			%   Error id: BRAPH2:PanelPropIDict:WrongInput
			%  PR.CHECKPROP(PanelPropIDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropIDict.
			%   Error id: BRAPH2:PanelPropIDict:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropIDict.getPropProp(pointer);
			
			switch prop
				case 36 % PanelPropIDict.BUTTON_TEXT
					check = Format.checkFormat(2, value, PanelPropIDict.getPropSettings(prop));
				case 37 % PanelPropIDict.BUTTON
					check = Format.checkFormat(18, value, PanelPropIDict.getPropSettings(prop));
				case 38 % PanelPropIDict.GUICLASS
					check = Format.checkFormat(5, value, PanelPropIDict.getPropSettings(prop));
				case 39 % PanelPropIDict.GUI_ITEM
					check = Format.checkFormat(8, value, PanelPropIDict.getPropSettings(prop));
				case 4 % PanelPropIDict.TEMPLATE
					check = Format.checkFormat(8, value, PanelPropIDict.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropIDict:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropIDict:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropIDict.getPropTag(prop) ' (' PanelPropIDict.getFormatTag(PanelPropIDict.getPropFormat(prop)) ').'] ...
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
				case 37 % PanelPropIDict.BUTTON
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					button = uibutton( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'BUTTON', ...
					    'Text', '', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ButtonPushedFcn', {@cb_button}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					
					value = button;
					
				case 20 % PanelPropIDict.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('BUTTON')
					end
					
				case 21 % PanelPropIDict.UPDATE
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if ~isa(pr.getr('BUTTON_TEXT'), 'NoValue')
					        button_text = pr.get('BUTTON_TEXT');
					    else % isa(pr.getr('BUTTON_TEXT'), 'NoValue')
					        if isa(el.getr(prop), 'NoValue')
					            button_text = el.getPropDefault(prop).get('TOSTRING');
					        else
					            button_text = el.get(prop).get('TOSTRING');
					        end
					    end
					    
					    switch el.getPropCategory(prop)
					        case {1, 2, 3, 4, 8, 9}
					            set(pr.get('BUTTON'), ...
					                'Text', button_text, ...
					                'Tooltip', regexprep(el.get(prop).tree(), {'<strong>', '</strong>'}, {'' ''}) ...
					                )
					        
					        case {5 6 7}
					            if isa(el.getr(prop), 'NoValue')
					                set(pr.get('BUTTON'), ...
					                    'Text', button_text, ...
					                    'Tooltip', regexprep(el.getPropDefault(prop).tree(), {'<strong>', '</strong>'}, {'' ''}), ...
					                    'Enable', 'off' ...
					                    )
					            else
					                set(pr.get('BUTTON'), ...
					                    'Text', button_text, ...
					                    'Tooltip', regexprep(el.get(prop).tree(), {'<strong>', '</strong>'}, {'' ''}), ...
					                    'Enable', 'on' ...
					                    )
					            end
					    end
					    
					    value = true;
					end
					
				case 22 % PanelPropIDict.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('BUTTON'), 'Position', [4 4 .70*w_p 21])
					end
					
				case 16 % PanelPropIDict.SHOW
					value = calculateValue@PanelProp(pr, 16, varargin{:}); % also warning
					if value
					    % figure item
					    if isa(pr.getr('GUI_ITEM'), 'GUI') && pr.get('GUI_ITEM').get('DRAWN')
					        pr.get('GUI_ITEM').get('SHOW')
					    end
					end
					
				case 17 % PanelPropIDict.HIDE
					value = calculateValue@PanelProp(pr, 17, varargin{:}); % also warning
					if value
					    % figure item
					    if isa(pr.getr('GUI_ITEM'), 'GUI') && pr.get('GUI_ITEM').get('DRAWN')
					        pr.get('GUI_ITEM').get('HIDE')
					    end
					end
					
				case 18 % PanelPropIDict.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value    
					    pr.set('BUTTON', Element.getNoValue())
					end
					
				case 19 % PanelPropIDict.CLOSE
					value = calculateValue@PanelProp(pr, 19, varargin{:}); % also warning
					if value
					    % figure item
					    if isa(pr.getr('GUI_ITEM'), 'GUI') && pr.get('GUI_ITEM').get('DRAWN')
					        pr.get('GUI_ITEM').get('CLOSE')
					    end
					end
					
				otherwise
					if prop <= 35
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_button(~, ~)
			    gui_item = pr.memorize('GUI_ITEM');
			
			    if ~gui_item.get('DRAWN')
			        gui_item.get('DRAW')
			        gui_item.get('SHOW')
			    else
			        if get(gui_item.get('H'), 'Visible')
			            gui_item.get('HIDE')
			        else
			            gui_item.get('SHOW')
			        end
			    end
			end
		end
	end
end
