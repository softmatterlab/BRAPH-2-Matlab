classdef PipelinePP_Notes < PanelPropStringTextArea
	%PipelinePP_Notes plots the panel for a pipeline notes.
	% It is a subclass of <a href="matlab:help PanelPropStringTextArea">PanelPropStringTextArea</a>.
	%
	% A Prop Panel for Pipeline Notes (PipelinePP_Notes) plots a text area with 
	%  the pipeline notes enhnaced with a popup context menu to open the web 
	%  tutorial and the pdf tuorial, as well as to edit or clone the pipeline.
	% It should be used only with the prop NOTES of the element Pipeline.
	%
	% The list of PipelinePP_Notes properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the prop panel for pipeline notes.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the prop panel for pipeline notes.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the prop panel for pipeline notes.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the prop panel for pipeline notes.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the prop panel for pipeline notes.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the prop panel for pipeline notes.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the prop panel for pipeline notes.
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
	%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the prop panel.
	%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the text-area and popup context menu.
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
	%  <strong>36</strong> <strong>ENABLE</strong> 	ENABLE (gui, logical) switches the text-area between active and inactive appearance when not editable.
	%  <strong>37</strong> <strong>TEXTAREA</strong> 	TEXTAREA (evanescent, handle) is the string value text-area.
	%  <strong>38</strong> <strong>CONTEXTMENU</strong> 	CONTEXTMENU (evanescent, handle) is the popup context menu.
	%  <strong>39</strong> <strong>MENUS</strong> 	MENUS (evanescent, handlelist) is the list of context menus.
	%
	% PipelinePP_Notes methods (constructor):
	%  PipelinePP_Notes - constructor
	%
	% PipelinePP_Notes methods:
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
	% PipelinePP_Notes methods (display):
	%  tostring - string with information about the prop panel for pipeline notes
	%  disp - displays information about the prop panel for pipeline notes
	%  tree - displays the tree of the prop panel for pipeline notes
	%
	% PipelinePP_Notes methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel for pipeline notes are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel for pipeline notes
	%
	% PipelinePP_Notes methods (save/load, Static):
	%  save - saves BRAPH2 prop panel for pipeline notes as b2 file
	%  load - loads a BRAPH2 prop panel for pipeline notes from a b2 file
	%
	% PipelinePP_Notes method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel for pipeline notes
	%
	% PipelinePP_Notes method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel for pipeline notes
	%
	% PipelinePP_Notes methods (inspection, Static):
	%  getClass - returns the class of the prop panel for pipeline notes
	%  getSubclasses - returns all subclasses of PipelinePP_Notes
	%  getProps - returns the property list of the prop panel for pipeline notes
	%  getPropNumber - returns the property number of the prop panel for pipeline notes
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
	% PipelinePP_Notes methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PipelinePP_Notes methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PipelinePP_Notes methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PipelinePP_Notes methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PipelinePP_Notes; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PipelinePP_Notes constants</a>.
	%
	%
	% See also uitextarea, uicontextmenu, Pipeline.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		CONTEXTMENU = 38; %CET: Computational Efficiency Trick
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = 7;
		CONTEXTMENU_FORMAT = 18;
		
		MENUS = 39; %CET: Computational Efficiency Trick
		MENUS_TAG = 'MENUS';
		MENUS_CATEGORY = 7;
		MENUS_FORMAT = 19;
	end
	methods % constructor
		function pr = PipelinePP_Notes(varargin)
			%PipelinePP_Notes() creates a prop panel for pipeline notes.
			%
			% PipelinePP_Notes(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PipelinePP_Notes(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PipelinePP_Notes properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the prop panel for pipeline notes.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the prop panel for pipeline notes.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the prop panel for pipeline notes.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the prop panel for pipeline notes.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the prop panel for pipeline notes.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the prop panel for pipeline notes.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the prop panel for pipeline notes.
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
			%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the prop panel.
			%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the text-area and popup context menu.
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
			%  <strong>36</strong> <strong>ENABLE</strong> 	ENABLE (gui, logical) switches the text-area between active and inactive appearance when not editable.
			%  <strong>37</strong> <strong>TEXTAREA</strong> 	TEXTAREA (evanescent, handle) is the string value text-area.
			%  <strong>38</strong> <strong>CONTEXTMENU</strong> 	CONTEXTMENU (evanescent, handle) is the popup context menu.
			%  <strong>39</strong> <strong>MENUS</strong> 	MENUS (evanescent, handlelist) is the list of context menus.
			%
			% See also Category, Format.
			
			pr = pr@PanelPropStringTextArea(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the prop panel for pipeline notes.
			%
			% BUILD = PipelinePP_Notes.GETBUILD() returns the build of 'PipelinePP_Notes'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the prop panel for pipeline notes PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('PipelinePP_Notes') returns the build of 'PipelinePP_Notes'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('PipelinePP_Notes')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the prop panel for pipeline notes.
			%
			% CLASS = PipelinePP_Notes.GETCLASS() returns the class 'PipelinePP_Notes'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel for pipeline notes PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PipelinePP_Notes') returns 'PipelinePP_Notes'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PipelinePP_Notes')
			%  are less computationally efficient.
			
			pr_class = 'PipelinePP_Notes';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel for pipeline notes.
			%
			% LIST = PipelinePP_Notes.GETSUBCLASSES() returns all subclasses of 'PipelinePP_Notes'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel for pipeline notes PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PipelinePP_Notes') returns all subclasses of 'PipelinePP_Notes'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'PipelinePP_Notes' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel for pipeline notes.
			%
			% PROPS = PipelinePP_Notes.GETPROPS() returns the property list of prop panel for pipeline notes
			%  as a row vector.
			%
			% PROPS = PipelinePP_Notes.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel for pipeline notes PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PipelinePP_Notes'[, CATEGORY]) returns the property list of 'PipelinePP_Notes'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PipelinePP_Notes')
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
					prop_list = [5 23 24 29];
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 20 21 22];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 27 28 30 31 32 33 34 35 37 38 39];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel for pipeline notes.
			%
			% N = PipelinePP_Notes.GETPROPNUMBER() returns the property number of prop panel for pipeline notes.
			%
			% N = PipelinePP_Notes.GETPROPNUMBER(CATEGORY) returns the property number of prop panel for pipeline notes
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel for pipeline notes PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PipelinePP_Notes') returns the property number of 'PipelinePP_Notes'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PipelinePP_Notes')
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
					prop_number = 4;
				case 6 % Category.QUERY
					prop_number = 10;
				case 7 % Category.EVANESCENT
					prop_number = 13;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 5;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel for pipeline notes/error.
			%
			% CHECK = PipelinePP_Notes.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PipelinePP_Notes, PROP) checks whether PROP exists for PipelinePP_Notes.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PipelinePP_Notes:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PipelinePP_Notes:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PipelinePP_Notes:WrongInput]
			%  Element.EXISTSPROP(PipelinePP_Notes, PROP) throws error if PROP does NOT exist for PipelinePP_Notes.
			%   Error id: [BRAPH2:PipelinePP_Notes:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 39 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PipelinePP_Notes:' 'WrongInput'], ...
					['BRAPH2' ':PipelinePP_Notes:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PipelinePP_Notes.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel for pipeline notes/error.
			%
			% CHECK = PipelinePP_Notes.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PipelinePP_Notes, TAG) checks whether TAG exists for PipelinePP_Notes.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PipelinePP_Notes:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PipelinePP_Notes:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PipelinePP_Notes:WrongInput]
			%  Element.EXISTSTAG(PipelinePP_Notes, TAG) throws error if TAG does NOT exist for PipelinePP_Notes.
			%   Error id: [BRAPH2:PipelinePP_Notes:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'TEXTAREA'  'CONTEXTMENU'  'MENUS' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PipelinePP_Notes:' 'WrongInput'], ...
					['BRAPH2' ':PipelinePP_Notes:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for PipelinePP_Notes.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PipelinePP_Notes, POINTER) returns property number of POINTER of PipelinePP_Notes.
			%  PROPERTY = PR.GETPROPPROP(PipelinePP_Notes, POINTER) returns property number of POINTER of PipelinePP_Notes.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'TEXTAREA'  'CONTEXTMENU'  'MENUS' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(PipelinePP_Notes, POINTER) returns tag of POINTER of PipelinePP_Notes.
			%  TAG = PR.GETPROPTAG(PipelinePP_Notes, POINTER) returns tag of POINTER of PipelinePP_Notes.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				pipelinepp_notes_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'TEXTAREA'  'CONTEXTMENU'  'MENUS' };
				tag = pipelinepp_notes_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(PipelinePP_Notes, POINTER) returns category of POINTER of PipelinePP_Notes.
			%  CATEGORY = PR.GETPROPCATEGORY(PipelinePP_Notes, POINTER) returns category of POINTER of PipelinePP_Notes.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PipelinePP_Notes.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pipelinepp_notes_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  7  7  7 };
			prop_category = pipelinepp_notes_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(PipelinePP_Notes, POINTER) returns format of POINTER of PipelinePP_Notes.
			%  FORMAT = PR.GETPROPFORMAT(PipelinePP_Notes, POINTER) returns format of POINTER of PipelinePP_Notes.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PipelinePP_Notes.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pipelinepp_notes_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  4  18  18  19 };
			prop_format = pipelinepp_notes_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PipelinePP_Notes, POINTER) returns description of POINTER of PipelinePP_Notes.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PipelinePP_Notes, POINTER) returns description of POINTER of PipelinePP_Notes.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PipelinePP_Notes.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pipelinepp_notes_description_list = { 'ELCLASS (constant, string) is the class of the prop panel for pipeline notes.'  'NAME (constant, string) is the name of the prop panel for pipeline notes.'  'DESCRIPTION (constant, string) is the description of the prop panel for pipeline notes.'  'TEMPLATE (parameter, item) is the template of the prop panel for pipeline notes.'  'ID (data, string) is a few-letter code for the prop panel for pipeline notes.'  'LABEL (metadata, string) is an extended label of the prop panel for pipeline notes.'  'NOTES (metadata, string) are some specific notes about the prop panel for pipeline notes.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.'  'X_DRAW (query, logical) draws the prop panel.'  'UPDATE (query, logical) updates the content and permissions of the text-area and popup context menu.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the prop panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'ENABLE (gui, logical) switches the text-area between active and inactive appearance when not editable.'  'TEXTAREA (evanescent, handle) is the string value text-area.'  'CONTEXTMENU (evanescent, handle) is the popup context menu.'  'MENUS (evanescent, handlelist) is the list of context menus.' };
			prop_description = pipelinepp_notes_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(PipelinePP_Notes, POINTER) returns settings of POINTER of PipelinePP_Notes.
			%  SETTINGS = PR.GETPROPSETTINGS(PipelinePP_Notes, POINTER) returns settings of POINTER of PipelinePP_Notes.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PipelinePP_Notes.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 38 % PipelinePP_Notes.CONTEXTMENU
					prop_settings = Format.getFormatSettings(18);
				case 39 % PipelinePP_Notes.MENUS
					prop_settings = Format.getFormatSettings(19);
				case 4 % PipelinePP_Notes.TEMPLATE
					prop_settings = 'PipelinePP_Notes';
				case 23 % PipelinePP_Notes.EL
					prop_settings = 'Pipeline';
				otherwise
					prop_settings = getPropSettings@PanelPropStringTextArea(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PipelinePP_Notes.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelinePP_Notes.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PipelinePP_Notes, POINTER) returns the default value of POINTER of PipelinePP_Notes.
			%  DEFAULT = PR.GETPROPDEFAULT(PipelinePP_Notes, POINTER) returns the default value of POINTER of PipelinePP_Notes.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PipelinePP_Notes.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 38 % PipelinePP_Notes.CONTEXTMENU
					prop_default = Format.getFormatDefault(18, PipelinePP_Notes.getPropSettings(prop));
				case 39 % PipelinePP_Notes.MENUS
					prop_default = Format.getFormatDefault(19, PipelinePP_Notes.getPropSettings(prop));
				case 1 % PipelinePP_Notes.ELCLASS
					prop_default = 'PipelinePP_Notes';
				case 2 % PipelinePP_Notes.NAME
					prop_default = 'Prop Panel for Pipeline Notes';
				case 3 % PipelinePP_Notes.DESCRIPTION
					prop_default = 'A Prop Panel for Pipeline Notes (PipelinePP_Notes) plots a text area with the pipeline notes enhnaced with a popup context menu to open the web tutorial and the pdf tuorial, as well as to edit or clone the pipeline. It should be used only with the prop NOTES of the element Pipeline.';
				case 4 % PipelinePP_Notes.TEMPLATE
					prop_default = Format.getFormatDefault(8, PipelinePP_Notes.getPropSettings(prop));
				case 5 % PipelinePP_Notes.ID
					prop_default = 'PipelinePP_Notes ID';
				case 6 % PipelinePP_Notes.LABEL
					prop_default = 'PipelinePP_Notes label';
				case 7 % PipelinePP_Notes.NOTES
					prop_default = 'PipelinePP_Notes notes';
				case 23 % PipelinePP_Notes.EL
					prop_default = Format.getFormatDefault(8, PipelinePP_Notes.getPropSettings(prop));
				case 24 % PipelinePP_Notes.PROP
					prop_default = 7;
				case 25 % PipelinePP_Notes.HEIGHT
					prop_default = 120;
				otherwise
					prop_default = getPropDefault@PanelPropStringTextArea(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PipelinePP_Notes.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelinePP_Notes.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PipelinePP_Notes, POINTER) returns the conditioned default value of POINTER of PipelinePP_Notes.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PipelinePP_Notes, POINTER) returns the conditioned default value of POINTER of PipelinePP_Notes.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PipelinePP_Notes.getPropProp(pointer);
			
			prop_default = PipelinePP_Notes.conditioning(prop, PipelinePP_Notes.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PipelinePP_Notes, PROP, VALUE) checks VALUE format for PROP of PipelinePP_Notes.
			%  CHECK = PR.CHECKPROP(PipelinePP_Notes, PROP, VALUE) checks VALUE format for PROP of PipelinePP_Notes.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:PipelinePP_Notes:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:PipelinePP_Notes:WrongInput
			%  Element.CHECKPROP(PipelinePP_Notes, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelinePP_Notes.
			%   Error id: BRAPH2:PipelinePP_Notes:WrongInput
			%  PR.CHECKPROP(PipelinePP_Notes, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelinePP_Notes.
			%   Error id: BRAPH2:PipelinePP_Notes:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PipelinePP_Notes')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PipelinePP_Notes.getPropProp(pointer);
			
			switch prop
				case 38 % PipelinePP_Notes.CONTEXTMENU
					check = Format.checkFormat(18, value, PipelinePP_Notes.getPropSettings(prop));
				case 39 % PipelinePP_Notes.MENUS
					check = Format.checkFormat(19, value, PipelinePP_Notes.getPropSettings(prop));
				case 4 % PipelinePP_Notes.TEMPLATE
					check = Format.checkFormat(8, value, PipelinePP_Notes.getPropSettings(prop));
				case 23 % PipelinePP_Notes.EL
					check = Format.checkFormat(8, value, PipelinePP_Notes.getPropSettings(prop));
				otherwise
					if prop <= 37
						check = checkProp@PanelPropStringTextArea(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PipelinePP_Notes:' 'WrongInput'], ...
					['BRAPH2' ':PipelinePP_Notes:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PipelinePP_Notes.getPropTag(prop) ' (' PipelinePP_Notes.getFormatTag(PipelinePP_Notes.getPropFormat(prop)) ').'] ...
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
				case 38 % PipelinePP_Notes.CONTEXTMENU
					pip = pr.get('EL');
					NOTES = pr.get('PROP');
					
					contextmenu = uicontextmenu( ...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'TAG', 'CONTEXTMENU' ...
					    );
					
					set(pr.get('TEXTAREA'), 'ContextMenu', contextmenu)
					
					value = contextmenu;
					
				case 39 % PipelinePP_Notes.MENUS
					contextmenu = pr.get('CONTEXTMENU');
					
					menu_tut_web = uimenu( ...
					    'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_TUT_WEB', ...
					    'Text', 'Web Tutorial ...', ...
					    'Enable', 'off', ...
					    'MenuSelectedFcn', {@cb_tut_web} ...
					    );
					menu_tut_pdf = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_TUT_PDF', ...
					    'Text', 'PDF Tutorial ...', ...
					    'Enable', 'off', ...
					    'MenuSelectedFcn', {@cb_tut_pdf} ...
					    );
					menu_pip_edit = uimenu( ...
					    'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_PIP_EDIT', ...
					    'Text', 'Edit Pipeline ...', ...
					    'MenuSelectedFcn', {@cb_pip_edit} ...
					    );
					menu_pip_clone = uimenu( ...
					    'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_PIP_CLONE', ...
					    'Text', 'Clone Pipeline ...', ...
					    'MenuSelectedFcn', {@cb_pip_clone} ...
					    );
					
					value = [menu_tut_web, menu_tut_pdf, menu_pip_edit, menu_pip_clone];
					
				case 20 % PipelinePP_Notes.X_DRAW
					value = calculateValue@PanelPropStringTextArea(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('CONTEXTMENU')
					    pr.memorize('MENUS')
					end
					
				case 21 % PipelinePP_Notes.UPDATE
					value = calculateValue@PanelPropStringTextArea(pr, 21, varargin{:}); % also warning
					if value
					
					    pip = pr.get('EL');
					    NOTES = pr.get('PROP');
					    
					    notes = pip.get(NOTES);
					
					    pdf = regexp(notes, '/tutorials/pipelines/\w+/\w+\.pdf', 'match', 'once'); % note \ for compilation
					    notes = regexprep(notes, ['PDF:.*?(' newline() '|$)'], '');
					
					    md = regexp(notes, '/tutorials/pipelines/\w+/readme\.md', 'match', 'once'); % note \ for compilation
					    notes = regexprep(notes, ['README:.*?(' newline() '|$)'], '');
					
					    notes = strtrim(notes);
					
					    set(pr.get('TEXTAREA'), 'Value', strrep(notes, '\n', char(10))) % note \ for compilation
					    if pip.isLocked(NOTES)
					        set(pr.get('TEXTAREA'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					    end
					
					    menus = pr.get('MENUS');
					    set(menus(1), 'Enable', ~isempty(pip.get('README'))) % menus(1) = menu_tut_web
					    set(menus(2), 'Enable', ~isempty(pip.get('PDF'))) % menus(2) = menu_tut_pdf
					end
					
				case 18 % PipelinePP_Notes.DELETE
					value = calculateValue@PanelPropStringTextArea(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('CONTEXTMENU', Element.getNoValue())
					    pr.set('MENUS', Element.getNoValue())
					end
					
				case 37 % PipelinePP_Notes.TEXTAREA
					pip = pr.get('EL');
					NOTES = pr.get('PROP');
					
					textarea = uitextarea( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'TEXTAREA', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(pip.getPropProp(NOTES)) ' ' pip.getPropDescription(NOTES)], ...
					    'ValueChangedFcn', {@cb_textarea} ...
					    );
					
					value = textarea;
					
				otherwise
					if prop <= 37
						value = calculateValue@PanelPropStringTextArea(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_tut_web(~, ~)
			    pip = pr.get('EL');
			
			    web([BRAPH2.GITHUB '/tree/develop' pip.get('README')]);
			end
			function cb_tut_pdf(~, ~)
			    pip = pr.get('EL');
			
			    if ismac()
			        system(['open -a Preview ' fileparts(fileparts(BRAPH2.LAUNCHER)) pip.get('PDF')]);
			    elseif isunix()
			        system(['xdg-open "' fileparts(fileparts(BRAPH2.LAUNCHER)) regexprep(pip.get('PDF'), '/', '\') '"']);
			    elseif ispc()
			        system(['start "" "' fileparts(fileparts(BRAPH2.LAUNCHER)) pip.get('PDF') '"']);
			    end
			end
			function cb_pip_edit(~, ~)
			    pip = pr.get('EL');
			
			    edit([pip.get('ID') '.braph2'])
			end
			function cb_pip_clone(~, ~)
			    pip = pr.get('EL');
			
			    pip_file_name = which([pip.get('ID') '.braph2']);
			    
			    cloned_pip = ImporterPipelineBRAPH2( ...
			        'FILE', pip_file_name, ...
			        'WAITBAR', true ...
			        ).get('PIP');
			
			    [path, name, ext] = fileparts(pip_file_name);
			    cloned_name = ['cloned_' name];
			
			    pip.set( ...
			        'ID', cloned_name, ...
			        'LABEL', ['Clone of ' cloned_pip.get('LABEL')], ...
			        'NOTES', ['This is a clone of another pipeline!' newline() ' ' newline() cloned_pip.get('NOTES')] ...
			        )
			    
			    cloned_file_name = [path filesep() cloned_name ext];
			    ExporterPipelineBRAPH2( ...
			        'PIP', cloned_pip, ...
			        'FILE', cloned_file_name, ...
			        'WAITBAR', true ...
			        ).get('SAVE')
			
			    edit(cloned_file_name)
			end
			function cb_textarea(~, ~)
			    notes = get(pr.get('TEXTAREA'), 'Value');
			
			    
			
			    pr.get('EL').set(pr.get('PROP'), sprintf('%s\\n', value{:})) % double \ to be converted to single \ in compilation
			end
		end
	end
end
