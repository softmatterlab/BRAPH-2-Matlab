classdef PipelinePP_PSDict < PanelProp
	%PipelinePP_PSDict manages the dictionary of pipeline panel plots.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Pipeline Plot (PipelinePP_PSDict) plots a pipeline allowing the user to execute it in the correct order.
	% It opens PanelFig elements using GUIFig, and all other elements using GUIElement.
	% It should be used only with the prop PS_DICT of the element Pipeline.
	%
	% The list of PipelinePP_PSDict properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the pipeline panel plot dictionary.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the pipeline panel plot dictionary.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the pipeline panel plot dictionary.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the pipeline panel plot dictionary.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the pipeline panel plot dictionary.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the pipeline panel plot dictionary.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the pipeline plot.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figures of the elements/buttons.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figures of the elements/buttons.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.
	%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the property panel.
	%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the table.
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
	%  <strong>36</strong> <strong>HEIGHT_MIN</strong> 	HEIGHT_MIN (gui, scalar) is the default (minumum) height.
	%  <strong>37</strong> <strong>HEIGHT_PS_HEADER</strong> 	HEIGHT_PS_HEADER (gui, scalar) is the height section header.
	%  <strong>38</strong> <strong>HEIGHT_PC</strong> 	HEIGHT_PC (gui, scalar) is the height code button.
	%  <strong>39</strong> <strong>HEIGHT_PS_FOOTER</strong> 	HEIGHT_PS_FOOTER (gui, scalar) is the height section footer.
	%  <strong>40</strong> <strong>HEIGHT_PS_MARGIN</strong> 	HEIGHT_PS_MARGIN (gui, scalar) is the height section margin.
	%  <strong>41</strong> <strong>HANDLES</strong> 	HANDLES (evanescent, handlelist) is the list of section panels and buttons.
	%  <strong>42</strong> <strong>PS_PANEL</strong> 	PS_PANEL (query, handle) returns graphics handle of a section panel.
	%  <strong>43</strong> <strong>PC_BTN</strong> 	PC_BTN (query, handle) returns graphics handle of a button.
	%  <strong>44</strong> <strong>PC_CLEAR_BTN</strong> 	PC_CLEAR_BTN (query, handle) returns graphics handle of a clear button.
	%  <strong>45</strong> <strong>GUI_PC_DICT</strong> 	GUI_PC_DICT (gui, idict) contains the GUIs for the element/buttons.
	%
	% PipelinePP_PSDict methods (constructor):
	%  PipelinePP_PSDict - constructor
	%
	% PipelinePP_PSDict methods:
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
	% PipelinePP_PSDict methods (display):
	%  tostring - string with information about the pipeline plot
	%  disp - displays information about the pipeline plot
	%  tree - displays the tree of the pipeline plot
	%
	% PipelinePP_PSDict methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two pipeline plot are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the pipeline plot
	%
	% PipelinePP_PSDict methods (save/load, Static):
	%  save - saves BRAPH2 pipeline plot as b2 file
	%  load - loads a BRAPH2 pipeline plot from a b2 file
	%
	% PipelinePP_PSDict method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the pipeline plot
	%
	% PipelinePP_PSDict method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the pipeline plot
	%
	% PipelinePP_PSDict methods (inspection, Static):
	%  getClass - returns the class of the pipeline plot
	%  getSubclasses - returns all subclasses of PipelinePP_PSDict
	%  getProps - returns the property list of the pipeline plot
	%  getPropNumber - returns the property number of the pipeline plot
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
	% PipelinePP_PSDict methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PipelinePP_PSDict methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PipelinePP_PSDict methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PipelinePP_PSDict methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PipelinePP_PSDict; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PipelinePP_PSDict constants</a>.
	%
	%
	% See also Pipeline.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		HEIGHT_MIN = 36; %CET: Computational Efficiency Trick
		HEIGHT_MIN_TAG = 'HEIGHT_MIN';
		HEIGHT_MIN_CATEGORY = 9;
		HEIGHT_MIN_FORMAT = 11;
		
		HEIGHT_PS_HEADER = 37; %CET: Computational Efficiency Trick
		HEIGHT_PS_HEADER_TAG = 'HEIGHT_PS_HEADER';
		HEIGHT_PS_HEADER_CATEGORY = 9;
		HEIGHT_PS_HEADER_FORMAT = 11;
		
		HEIGHT_PC = 38; %CET: Computational Efficiency Trick
		HEIGHT_PC_TAG = 'HEIGHT_PC';
		HEIGHT_PC_CATEGORY = 9;
		HEIGHT_PC_FORMAT = 11;
		
		HEIGHT_PS_FOOTER = 39; %CET: Computational Efficiency Trick
		HEIGHT_PS_FOOTER_TAG = 'HEIGHT_PS_FOOTER';
		HEIGHT_PS_FOOTER_CATEGORY = 9;
		HEIGHT_PS_FOOTER_FORMAT = 11;
		
		HEIGHT_PS_MARGIN = 40; %CET: Computational Efficiency Trick
		HEIGHT_PS_MARGIN_TAG = 'HEIGHT_PS_MARGIN';
		HEIGHT_PS_MARGIN_CATEGORY = 9;
		HEIGHT_PS_MARGIN_FORMAT = 11;
		
		HANDLES = 41; %CET: Computational Efficiency Trick
		HANDLES_TAG = 'HANDLES';
		HANDLES_CATEGORY = 7;
		HANDLES_FORMAT = 19;
		
		PS_PANEL = 42; %CET: Computational Efficiency Trick
		PS_PANEL_TAG = 'PS_PANEL';
		PS_PANEL_CATEGORY = 6;
		PS_PANEL_FORMAT = 18;
		
		PC_BTN = 43; %CET: Computational Efficiency Trick
		PC_BTN_TAG = 'PC_BTN';
		PC_BTN_CATEGORY = 6;
		PC_BTN_FORMAT = 18;
		
		PC_CLEAR_BTN = 44; %CET: Computational Efficiency Trick
		PC_CLEAR_BTN_TAG = 'PC_CLEAR_BTN';
		PC_CLEAR_BTN_CATEGORY = 6;
		PC_CLEAR_BTN_FORMAT = 18;
		
		GUI_PC_DICT = 45; %CET: Computational Efficiency Trick
		GUI_PC_DICT_TAG = 'GUI_PC_DICT';
		GUI_PC_DICT_CATEGORY = 9;
		GUI_PC_DICT_FORMAT = 10;
	end
	methods % constructor
		function pr = PipelinePP_PSDict(varargin)
			%PipelinePP_PSDict() creates a pipeline plot.
			%
			% PipelinePP_PSDict(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PipelinePP_PSDict(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PipelinePP_PSDict properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the pipeline panel plot dictionary.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the pipeline panel plot dictionary.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the pipeline panel plot dictionary.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the pipeline panel plot dictionary.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the pipeline panel plot dictionary.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the pipeline panel plot dictionary.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the pipeline plot.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figures of the elements/buttons.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figures of the elements/buttons.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.
			%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the property panel.
			%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the table.
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
			%  <strong>36</strong> <strong>HEIGHT_MIN</strong> 	HEIGHT_MIN (gui, scalar) is the default (minumum) height.
			%  <strong>37</strong> <strong>HEIGHT_PS_HEADER</strong> 	HEIGHT_PS_HEADER (gui, scalar) is the height section header.
			%  <strong>38</strong> <strong>HEIGHT_PC</strong> 	HEIGHT_PC (gui, scalar) is the height code button.
			%  <strong>39</strong> <strong>HEIGHT_PS_FOOTER</strong> 	HEIGHT_PS_FOOTER (gui, scalar) is the height section footer.
			%  <strong>40</strong> <strong>HEIGHT_PS_MARGIN</strong> 	HEIGHT_PS_MARGIN (gui, scalar) is the height section margin.
			%  <strong>41</strong> <strong>HANDLES</strong> 	HANDLES (evanescent, handlelist) is the list of section panels and buttons.
			%  <strong>42</strong> <strong>PS_PANEL</strong> 	PS_PANEL (query, handle) returns graphics handle of a section panel.
			%  <strong>43</strong> <strong>PC_BTN</strong> 	PC_BTN (query, handle) returns graphics handle of a button.
			%  <strong>44</strong> <strong>PC_CLEAR_BTN</strong> 	PC_CLEAR_BTN (query, handle) returns graphics handle of a clear button.
			%  <strong>45</strong> <strong>GUI_PC_DICT</strong> 	GUI_PC_DICT (gui, idict) contains the GUIs for the element/buttons.
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the pipeline plot.
			%
			% BUILD = PipelinePP_PSDict.GETBUILD() returns the build of 'PipelinePP_PSDict'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the pipeline plot PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('PipelinePP_PSDict') returns the build of 'PipelinePP_PSDict'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('PipelinePP_PSDict')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the pipeline plot.
			%
			% CLASS = PipelinePP_PSDict.GETCLASS() returns the class 'PipelinePP_PSDict'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the pipeline plot PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PipelinePP_PSDict') returns 'PipelinePP_PSDict'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PipelinePP_PSDict')
			%  are less computationally efficient.
			
			pr_class = 'PipelinePP_PSDict';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the pipeline plot.
			%
			% LIST = PipelinePP_PSDict.GETSUBCLASSES() returns all subclasses of 'PipelinePP_PSDict'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the pipeline plot PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PipelinePP_PSDict') returns all subclasses of 'PipelinePP_PSDict'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'PipelinePP_PSDict' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of pipeline plot.
			%
			% PROPS = PipelinePP_PSDict.GETPROPS() returns the property list of pipeline plot
			%  as a row vector.
			%
			% PROPS = PipelinePP_PSDict.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the pipeline plot PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PipelinePP_PSDict'[, CATEGORY]) returns the property list of 'PipelinePP_PSDict'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PipelinePP_PSDict')
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
					prop_list = [8 11 12 16 17 18 19 20 21 22 42 43 44];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 27 28 30 31 32 33 34 35 41];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36 37 38 39 40 45];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of pipeline plot.
			%
			% N = PipelinePP_PSDict.GETPROPNUMBER() returns the property number of pipeline plot.
			%
			% N = PipelinePP_PSDict.GETPROPNUMBER(CATEGORY) returns the property number of pipeline plot
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the pipeline plot PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PipelinePP_PSDict') returns the property number of 'PipelinePP_PSDict'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PipelinePP_PSDict')
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
					prop_number = 13;
				case 7 % Category.EVANESCENT
					prop_number = 11;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 10;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in pipeline plot/error.
			%
			% CHECK = PipelinePP_PSDict.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PipelinePP_PSDict, PROP) checks whether PROP exists for PipelinePP_PSDict.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PipelinePP_PSDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PipelinePP_PSDict:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PipelinePP_PSDict:WrongInput]
			%  Element.EXISTSPROP(PipelinePP_PSDict, PROP) throws error if PROP does NOT exist for PipelinePP_PSDict.
			%   Error id: [BRAPH2:PipelinePP_PSDict:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 45 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PipelinePP_PSDict:' 'WrongInput'], ...
					['BRAPH2' ':PipelinePP_PSDict:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PipelinePP_PSDict.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in pipeline plot/error.
			%
			% CHECK = PipelinePP_PSDict.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PipelinePP_PSDict, TAG) checks whether TAG exists for PipelinePP_PSDict.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PipelinePP_PSDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PipelinePP_PSDict:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PipelinePP_PSDict:WrongInput]
			%  Element.EXISTSTAG(PipelinePP_PSDict, TAG) throws error if TAG does NOT exist for PipelinePP_PSDict.
			%   Error id: [BRAPH2:PipelinePP_PSDict:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'HEIGHT_MIN'  'HEIGHT_PS_HEADER'  'HEIGHT_PC'  'HEIGHT_PS_FOOTER'  'HEIGHT_PS_MARGIN'  'HANDLES'  'PS_PANEL'  'PC_BTN'  'PC_CLEAR_BTN'  'GUI_PC_DICT' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PipelinePP_PSDict:' 'WrongInput'], ...
					['BRAPH2' ':PipelinePP_PSDict:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for PipelinePP_PSDict.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PipelinePP_PSDict, POINTER) returns property number of POINTER of PipelinePP_PSDict.
			%  PROPERTY = PR.GETPROPPROP(PipelinePP_PSDict, POINTER) returns property number of POINTER of PipelinePP_PSDict.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'HEIGHT_MIN'  'HEIGHT_PS_HEADER'  'HEIGHT_PC'  'HEIGHT_PS_FOOTER'  'HEIGHT_PS_MARGIN'  'HANDLES'  'PS_PANEL'  'PC_BTN'  'PC_CLEAR_BTN'  'GUI_PC_DICT' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(PipelinePP_PSDict, POINTER) returns tag of POINTER of PipelinePP_PSDict.
			%  TAG = PR.GETPROPTAG(PipelinePP_PSDict, POINTER) returns tag of POINTER of PipelinePP_PSDict.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				pipelinepp_psdict_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'HEIGHT_MIN'  'HEIGHT_PS_HEADER'  'HEIGHT_PC'  'HEIGHT_PS_FOOTER'  'HEIGHT_PS_MARGIN'  'HANDLES'  'PS_PANEL'  'PC_BTN'  'PC_CLEAR_BTN'  'GUI_PC_DICT' };
				tag = pipelinepp_psdict_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(PipelinePP_PSDict, POINTER) returns category of POINTER of PipelinePP_PSDict.
			%  CATEGORY = PR.GETPROPCATEGORY(PipelinePP_PSDict, POINTER) returns category of POINTER of PipelinePP_PSDict.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PipelinePP_PSDict.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pipelinepp_psdict_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  9  9  9  9  7  6  6  6  9 };
			prop_category = pipelinepp_psdict_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(PipelinePP_PSDict, POINTER) returns format of POINTER of PipelinePP_PSDict.
			%  FORMAT = PR.GETPROPFORMAT(PipelinePP_PSDict, POINTER) returns format of POINTER of PipelinePP_PSDict.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PipelinePP_PSDict.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pipelinepp_psdict_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  11  11  11  11  11  19  18  18  18  10 };
			prop_format = pipelinepp_psdict_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PipelinePP_PSDict, POINTER) returns description of POINTER of PipelinePP_PSDict.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PipelinePP_PSDict, POINTER) returns description of POINTER of PipelinePP_PSDict.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PipelinePP_PSDict.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pipelinepp_psdict_description_list = { 'ELCLASS (constant, string) is the class of the pipeline panel plot dictionary.'  'NAME (constant, string) is the name of the pipeline panel plot dictionary.'  'DESCRIPTION (constant, string) is the description of the pipeline panel plot dictionary.'  'TEMPLATE (parameter, item) is the template of the pipeline panel plot dictionary.'  'ID (data, string) is a few-letter code for the pipeline panel plot dictionary.'  'LABEL (metadata, string) is an extended label of the pipeline panel plot dictionary.'  'NOTES (metadata, string) are some specific notes about the pipeline plot.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figures of the elements/buttons.'  'HIDE (query, logical) hides the figures of the elements/buttons.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the table.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the prop panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'HEIGHT_MIN (gui, scalar) is the default (minumum) height.'  'HEIGHT_PS_HEADER (gui, scalar) is the height section header.'  'HEIGHT_PC (gui, scalar) is the height code button.'  'HEIGHT_PS_FOOTER (gui, scalar) is the height section footer.'  'HEIGHT_PS_MARGIN (gui, scalar) is the height section margin.'  'HANDLES (evanescent, handlelist) is the list of section panels and buttons.'  'PS_PANEL (query, handle) returns graphics handle of a section panel.'  'PC_BTN (query, handle) returns graphics handle of a button.'  'PC_CLEAR_BTN (query, handle) returns graphics handle of a clear button.'  'GUI_PC_DICT (gui, idict) contains the GUIs for the element/buttons.' };
			prop_description = pipelinepp_psdict_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(PipelinePP_PSDict, POINTER) returns settings of POINTER of PipelinePP_PSDict.
			%  SETTINGS = PR.GETPROPSETTINGS(PipelinePP_PSDict, POINTER) returns settings of POINTER of PipelinePP_PSDict.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PipelinePP_PSDict.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % PipelinePP_PSDict.HEIGHT_MIN
					prop_settings = Format.getFormatSettings(11);
				case 37 % PipelinePP_PSDict.HEIGHT_PS_HEADER
					prop_settings = Format.getFormatSettings(11);
				case 38 % PipelinePP_PSDict.HEIGHT_PC
					prop_settings = Format.getFormatSettings(11);
				case 39 % PipelinePP_PSDict.HEIGHT_PS_FOOTER
					prop_settings = Format.getFormatSettings(11);
				case 40 % PipelinePP_PSDict.HEIGHT_PS_MARGIN
					prop_settings = Format.getFormatSettings(11);
				case 41 % PipelinePP_PSDict.HANDLES
					prop_settings = Format.getFormatSettings(19);
				case 42 % PipelinePP_PSDict.PS_PANEL
					prop_settings = Format.getFormatSettings(18);
				case 43 % PipelinePP_PSDict.PC_BTN
					prop_settings = Format.getFormatSettings(18);
				case 44 % PipelinePP_PSDict.PC_CLEAR_BTN
					prop_settings = Format.getFormatSettings(18);
				case 45 % PipelinePP_PSDict.GUI_PC_DICT
					prop_settings = 'GUI';
				case 4 % PipelinePP_PSDict.TEMPLATE
					prop_settings = 'PipelinePP_PSDict';
				case 23 % PipelinePP_PSDict.EL
					prop_settings = 'Pipeline';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PipelinePP_PSDict.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelinePP_PSDict.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PipelinePP_PSDict, POINTER) returns the default value of POINTER of PipelinePP_PSDict.
			%  DEFAULT = PR.GETPROPDEFAULT(PipelinePP_PSDict, POINTER) returns the default value of POINTER of PipelinePP_PSDict.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PipelinePP_PSDict.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % PipelinePP_PSDict.HEIGHT_MIN
					prop_default = 24;
				case 37 % PipelinePP_PSDict.HEIGHT_PS_HEADER
					prop_default = 24;
				case 38 % PipelinePP_PSDict.HEIGHT_PC
					prop_default = 30;
				case 39 % PipelinePP_PSDict.HEIGHT_PS_FOOTER
					prop_default = 6;
				case 40 % PipelinePP_PSDict.HEIGHT_PS_MARGIN
					prop_default = 6;
				case 41 % PipelinePP_PSDict.HANDLES
					prop_default = Format.getFormatDefault(19, PipelinePP_PSDict.getPropSettings(prop));
				case 42 % PipelinePP_PSDict.PS_PANEL
					prop_default = Format.getFormatDefault(18, PipelinePP_PSDict.getPropSettings(prop));
				case 43 % PipelinePP_PSDict.PC_BTN
					prop_default = Format.getFormatDefault(18, PipelinePP_PSDict.getPropSettings(prop));
				case 44 % PipelinePP_PSDict.PC_CLEAR_BTN
					prop_default = Format.getFormatDefault(18, PipelinePP_PSDict.getPropSettings(prop));
				case 45 % PipelinePP_PSDict.GUI_PC_DICT
					prop_default = Format.getFormatDefault(10, PipelinePP_PSDict.getPropSettings(prop));
				case 1 % PipelinePP_PSDict.ELCLASS
					prop_default = 'PipelinePP_PSDict';
				case 2 % PipelinePP_PSDict.NAME
					prop_default = 'Pipeline Plot';
				case 3 % PipelinePP_PSDict.DESCRIPTION
					prop_default = 'A Pipeline Plot (PipelinePP_PSDict) plots a pipeline allowing the user to execute it in the correct order. It opens PanelFig elements using GUIFig, and all other elements using GUIElement. It should be used only with the prop PS_DICT of the element Pipeline.';
				case 4 % PipelinePP_PSDict.TEMPLATE
					prop_default = Format.getFormatDefault(8, PipelinePP_PSDict.getPropSettings(prop));
				case 5 % PipelinePP_PSDict.ID
					prop_default = 'PipelinePP_PSDict ID';
				case 6 % PipelinePP_PSDict.LABEL
					prop_default = 'PipelinePP_PSDict label';
				case 7 % PipelinePP_PSDict.NOTES
					prop_default = 'PipelinePP_PSDict notes';
				case 23 % PipelinePP_PSDict.EL
					prop_default = Format.getFormatDefault(8, PipelinePP_PSDict.getPropSettings(prop));
				case 24 % PipelinePP_PSDict.PROP
					prop_default = 11;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PipelinePP_PSDict.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelinePP_PSDict.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PipelinePP_PSDict, POINTER) returns the conditioned default value of POINTER of PipelinePP_PSDict.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PipelinePP_PSDict, POINTER) returns the conditioned default value of POINTER of PipelinePP_PSDict.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PipelinePP_PSDict.getPropProp(pointer);
			
			prop_default = PipelinePP_PSDict.conditioning(prop, PipelinePP_PSDict.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PipelinePP_PSDict, PROP, VALUE) checks VALUE format for PROP of PipelinePP_PSDict.
			%  CHECK = PR.CHECKPROP(PipelinePP_PSDict, PROP, VALUE) checks VALUE format for PROP of PipelinePP_PSDict.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:PipelinePP_PSDict:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:PipelinePP_PSDict:WrongInput
			%  Element.CHECKPROP(PipelinePP_PSDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelinePP_PSDict.
			%   Error id: BRAPH2:PipelinePP_PSDict:WrongInput
			%  PR.CHECKPROP(PipelinePP_PSDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelinePP_PSDict.
			%   Error id: BRAPH2:PipelinePP_PSDict:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PipelinePP_PSDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PipelinePP_PSDict.getPropProp(pointer);
			
			switch prop
				case 36 % PipelinePP_PSDict.HEIGHT_MIN
					check = Format.checkFormat(11, value, PipelinePP_PSDict.getPropSettings(prop));
				case 37 % PipelinePP_PSDict.HEIGHT_PS_HEADER
					check = Format.checkFormat(11, value, PipelinePP_PSDict.getPropSettings(prop));
				case 38 % PipelinePP_PSDict.HEIGHT_PC
					check = Format.checkFormat(11, value, PipelinePP_PSDict.getPropSettings(prop));
				case 39 % PipelinePP_PSDict.HEIGHT_PS_FOOTER
					check = Format.checkFormat(11, value, PipelinePP_PSDict.getPropSettings(prop));
				case 40 % PipelinePP_PSDict.HEIGHT_PS_MARGIN
					check = Format.checkFormat(11, value, PipelinePP_PSDict.getPropSettings(prop));
				case 41 % PipelinePP_PSDict.HANDLES
					check = Format.checkFormat(19, value, PipelinePP_PSDict.getPropSettings(prop));
				case 42 % PipelinePP_PSDict.PS_PANEL
					check = Format.checkFormat(18, value, PipelinePP_PSDict.getPropSettings(prop));
				case 43 % PipelinePP_PSDict.PC_BTN
					check = Format.checkFormat(18, value, PipelinePP_PSDict.getPropSettings(prop));
				case 44 % PipelinePP_PSDict.PC_CLEAR_BTN
					check = Format.checkFormat(18, value, PipelinePP_PSDict.getPropSettings(prop));
				case 45 % PipelinePP_PSDict.GUI_PC_DICT
					check = Format.checkFormat(10, value, PipelinePP_PSDict.getPropSettings(prop));
				case 4 % PipelinePP_PSDict.TEMPLATE
					check = Format.checkFormat(8, value, PipelinePP_PSDict.getPropSettings(prop));
				case 23 % PipelinePP_PSDict.EL
					check = Format.checkFormat(8, value, PipelinePP_PSDict.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PipelinePP_PSDict:' 'WrongInput'], ...
					['BRAPH2' ':PipelinePP_PSDict:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PipelinePP_PSDict.getPropTag(prop) ' (' PipelinePP_PSDict.getFormatTag(PipelinePP_PSDict.getPropFormat(prop)) ').'] ...
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
				case 41 % PipelinePP_PSDict.HANDLES
					pip = pr.get('EL');
					
					ps_dict = pip.get('PS_DICT');
					ps_panels = cell(1, ps_dict.get('LENGTH'));
					pc_btns = cell(1, ps_dict.get('LENGTH'));
					for sec = 1:1:ps_dict.get('LENGTH')
					    ps = ps_dict.get('IT', sec);
					
					    ps_panels{sec} = uipanel( ...
					        'Parent', pr.get('H'), ...
					        'Tag', int2str(sec), ... % Tag used by PS_PANEL
					        'Title', [ps.get('ID') '. ' ps.get('LABEL')], ... 
					        'Tooltip', ps.get('DESCRIPTION'), ...
					        'FontSize', 12, ...
					        'BorderType', 'none' ...
					        );
					
					        pc_dict = ps.get('PC_DICT');
					        pc_btns{sec} = cell(1, pc_dict.get('LENGTH'));
					        for cl = 1:1:pc_dict.get('LENGTH')
					            pc = pc_dict.get('IT', cl);
					
					            pc_btns{sec}{cl} = uibutton( ...
					                'Parent', ps_panels{sec}, ... 
					                'Tag', [int2str(sec) '.' int2str(cl)], ... % Tag used by PC_CLEAR_BTN 
					                'Tooltip', pc.get('DESCRIPTION'), ...
					                'Enable', 'off', ...
					                'Text', pc.get('TEXT_BEFORE_EXEC'), ...
					                'FontAngle', 'italic', ...
					                'FontSize', 12, ...
					                'UserData', [sec cl], ...
					                'ButtonPushedFcn', {@cb_pc_btn}, ...
					                'Interruptible', 'off', ...
					                'BusyAction', 'cancel' ...
					                );
					
					            pc_delete_btns{sec}{cl} = uibutton( ...
					                'Parent', ps_panels{sec}, ... 
					                'Tag', ['delete ' int2str(sec) '.' int2str(cl)], ... % Tag used by PC_CLEAR_BTN
					                'Tooltip', ['Delete ' pc.get('MONIKER')], ...
					                'Enable', 'off', ...
					                'Text', 'D', ...
					                'FontSize', 12, ...
					                'FontWeight', 'bold', ...
					                'UserData', [sec cl], ...
					                'ButtonPushedFcn', {@cb_pc_clear_btn}, ...
					                'Interruptible', 'off', ...
					                'BusyAction', 'cancel' ...
					                );
					        end
					end
					
					% output value
					handles = {};
					for sec = 1:1:length(ps_panels)
					    handles = [handles ps_panels(sec) pc_btns{sec}(:)' pc_delete_btns{sec}(:)'];
					end
					value = handles;
					
				case 42 % PipelinePP_PSDict.PS_PANEL
					% H = pr.get('PS_PANEL', SEC) returns the hande H of the section SEC panel.
					value = gobjects(); % default output
					if isempty(varargin)
					    return
					end    
					sec = varargin{1};
					
					handles = pr.memorize('HANDLES');
					
					for i = 1:1:length(handles)
					    if check_graphics(handles{i}, 'uipanel') && strcmpi(handles{i}.get('Tag'), int2str(sec)) % for Tag see HANDLES
					        value = handles{i}; % output value
					        break
					    end
					end
					
				case 43 % PipelinePP_PSDict.PC_BTN
					% H = pr.get('PC_BTN', SEC, CL) returns the hande H of the button of code 
					% line CL of section SEC panel.
					value = gobjects(); % default output
					if isempty(varargin)
					    return
					end    
					sec = varargin{1};
					cl = varargin{2};
					
					handles = pr.memorize('HANDLES');
					
					for i = 1:1:length(handles)
					    if check_graphics(handles{i}, 'uibutton') && strcmpi(handles{i}.get('Tag'), [int2str(sec) '.' int2str(cl)]) % for Tag see HANDLES
					        value = handles{i}; % output value
					        break
					    end
					end
					
				case 44 % PipelinePP_PSDict.PC_CLEAR_BTN
					% H = pr.get('PC_BTN', SEC, CL) returns the hande H of the button of code 
					% line CL of section SEC panel.
					value = gobjects(); % default output
					if isempty(varargin)
					    return
					end    
					sec = varargin{1};
					cl = varargin{2};
					
					handles = pr.memorize('HANDLES');
					
					for i = 1:1:length(handles)
					    if check_graphics(handles{i}, 'uibutton') && strcmpi(handles{i}.get('Tag'), ['delete ' int2str(sec) '.' int2str(cl)]) % for Tag see HANDLES
					        value = handles{i}; % output value
					        break
					    end
					end
					
				case 20 % PipelinePP_PSDict.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('HANDLES')
					end
					
				case 21 % PipelinePP_PSDict.UPDATE
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value
					    pip = pr.get('EL');
					
					    ps_dict = pip.get('PS_DICT');
					    ps_number = ps_dict.get('LENGTH');
					    pc_numbers = cellfun(@(ps) ps.get('PC_DICT').get('LENGTH'), ps_dict.get('IT_LIST'));
					    pr.set('HEIGHT', pr.get('HEIGHT_MIN') + (pr.get('HEIGHT_PS_MARGIN') + pr.get('HEIGHT_PS_HEADER') + pr.get('HEIGHT_PS_FOOTER')) * ps_number + pr.get('HEIGHT_PC') * sum(pc_numbers));
					    
					    s_selected = get_from_varargin(0, 'Section', varargin); % selected section
					    c_selected = get_from_varargin(0, 'Code', varargin); % selected code
					
					    to_be_executed = {};
					    
					    s_to_be_calculated = 1;
					    s_dict = pip.get('PS_DICT');
					    for sec = 1:1:s_dict.get('LENGTH')
					        section = s_dict.get('IT', sec);
					        
					        code_dict = section.get('PC_DICT');
					        for cl = 1:1:code_dict.get('LENGTH')
					            code = code_dict.get('IT', cl);
					            moniker = code.get('MONIKER');
					            if strcmpi(moniker, 'varargin')
					                error( ...
					                    ['BRAPH2' ':' pr.getClass() ':' 'WrongInput'], ...
					                    ['BRAPH2' ':' pr.getClass() ':' 'WrongInput' '\n' ...
					                    'The moniker should not be ''varagin''.'] ...
					                    )
					            end
					            
					            % callback code -- CALCULATE
					            if sec == s_selected && cl == c_selected && isa(code.getr('EL'), 'NoValue') % the code has not been calculated yet -- CALCULATE
					                try
					                    set(pr.get('PC_BTN', sec, cl), 'Enable', 'off')
					                    x_pip_update(to_be_executed{:}, ...
					                        {moniker, code, [moniker ' = ' code.get('CODE') ';']}, ... % varargin{1}{2} = code
					                        {moniker, code, ['varargin{1}{2}.set(''EL'', ' moniker ');']}) % varargin{1}{2} = code
					                catch e
					                    set(pr.get('PC_BTN', sec, cl), 'Enable', 'on')
					
					                    if isempty(regexp(e.message, ['^' 'BRAPH2' ':.*:' 'CancelIO' '$'], 'once'))
					                        %TODO make this with braph2message
					                        warndlg(['An error occurred while trying to execute the code:' newline() ...
					                            newline() ...
					                            moniker ' = ' code.get('CODE') ';' newline() ...
					                            newline() ...
					                            'Error message:' newline() ...
					                            newline() ...
					                            e.message newline()], 'Warning');
					                    end
					                end
					            end
					
					            % If a code has already been executed and the relative element exists, 
					            % 1. loads the calculated element to the workspace
					            % 2. updates the ID in the btn
					            % 3. calculates whether to move to the next section
					            if ~isa(code.getr('EL'), 'NoValue')
					                to_be_executed = {to_be_executed{:}, {moniker, code, [moniker ' = varargin{1}{2}.get(''EL'');']}}; % varargin{1}{2} = code
					
					                set(pr.get('PC_BTN', sec, cl), ...
					                    'Enable', 'on', ...
					                    'Text', [code.get('TEXT_AFTER_EXEC') ' / ' code.get('EL').get('ID')], ...
					                    'FontAngle', 'normal', ...
					                    'FontWeight', 'normal' ...
					                    )
					                set(pr.get('PC_CLEAR_BTN', sec, cl), 'Enable', 'on')
					
					                % if all section codes calculated, updates the section to be calculated
					                if all(cellfun(@(pc) ~isa(pc.getr('EL'), 'NoValue'), code_dict.get('IT_LIST')))
					                    s_to_be_calculated = sec + 1;
					                end
					                
					                % disables clear buttons of previous section
					                if sec > 1
					                    for cl_tmp = 1:1:s_dict.get('IT', sec - 1).get('PC_DICT').get('LENGTH')
					                        set(pr.get('PC_CLEAR_BTN', sec - 1, cl_tmp), 'Enable', 'off')
					                    end
					                end
					            end
					            
					            % activates the next section that can be calculated
					            % (only the codes that have not been calculated yet)
					            if sec == s_to_be_calculated && isa(code.getr('EL'), 'NoValue')
					                set(pr.get('PC_BTN', sec, cl), ...
					                    'Enable', 'on', ...
					                    'Text', code.get('TEXT_BEFORE_EXEC'), ...
					                    'FontAngle', 'normal', ...
					                    'FontWeight', 'bold' ...
					                    )
					                set(pr.get('PC_CLEAR_BTN', sec, cl), 'Enable', 'off')
					            end
					            
					            % deactivates the subsequent sections
					            if sec > s_to_be_calculated 
					                set(pr.get('PC_BTN', sec, cl), ...
					                    'Enable', 'off', ...
					                    'Text', code.get('TEXT_BEFORE_EXEC'), ...
					                    'FontAngle', 'italic', ...
					                    'FontWeight', 'normal' ...
					                    )
					                set(pr.get('PC_CLEAR_BTN', sec, cl), 'Enable', 'off')
					            end
					            
					            % callback code -- GUI
					            if sec == s_selected && cl == c_selected && ~isa(code.getr('EL'), 'NoValue') % the code has already been calculated -- GUI
					                key = [int2str(sec) '.' int2str(cl)];
					                gui_pc_dict = pr.memorize('GUI_PC_DICT');
					                if ~gui_pc_dict.get('CONTAINS_KEY', key)
					                    f_pip = ancestor(pr.get('H'), 'Figure'); % Pipeline GUI
					
					                    if isa(code.get('EL'), 'PanelFig')
					                        gui = GUIFig( ...
					                            'ID', key, ... % this is the dictionary key
					                            'PF', code.get('EL'), ...
					                            'POSITION', [ ...
					                                x0(f_pip, 'normalized')+w(f_pip, 'normalized') ...
					                                y0(f_pip, 'normalized') ...
					                                w(0,'normalized')-x0(f_pip, 'normalized')-w(f_pip, 'normalized') ...
					                                h(f_pip, 'normalized') ...
					                                ], ...
					                            'WAITBAR', pr.getCallback('WAITBAR'), ...
					                            'CLOSEREQ', false ...
					                            );
					                    else
					                        gui = GUIElement( ...
					                            'ID', key, ... % this is the dictionary key
					                            'PE', code.get('EL'), ...
					                            'POSITION', [ ...
					                                x0(f_pip, 'normalized') + w(f_pip) ...
					                                y0(f_pip, 'normalized') ...
					                                w(f_pip) ...
					                                h(f_pip, 'normalized') ...
					                                ], ...
					                            'WAITBAR', pr.getCallback('WAITBAR'), ...
					                            'CLOSEREQ', false ...
					                            );
					                    end
					                    gui_pc_dict.get('ADD', gui)
					                end
					
					                gui = gui_pc_dict.get('IT', key);
					                if ~gui.get('DRAWN')
					                    gui.get('DRAW')
					                end
					                if get(gui.get('H'), 'Visible')
					                    gui.get('HIDE')
					                else
					                    gui.get('SHOW')
					                end
					            end
					        end
					    end
					end
					
				case 22 % PipelinePP_PSDict.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    pip = pr.get('EL');
					    ps_dict = pip.get('PS_DICT');
					        
					    ps_number = ps_dict.get('LENGTH');
					    pc_numbers = cellfun(@(ps) ps.get('PC_DICT').get('LENGTH'), ps_dict.get('IT_LIST'));
					    
					    for sec = 1:1:ps_number
					        ps_y = pr.get('HEIGHT_PS_HEADER') * (ps_number - sec) ...
					            + pr.get('HEIGHT_PC') * sum(pc_numbers(sec+1:end)) ...
					            + pr.get('HEIGHT_PS_FOOTER') * (ps_number - sec) ...
					            + pr.get('HEIGHT_PS_MARGIN') * (ps_number - sec + 1);
					        ps_h = pr.get('HEIGHT_PS_HEADER') + pr.get('HEIGHT_PC') * pc_numbers(sec) + pr.get('HEIGHT_PS_FOOTER');
					        
					        set(pr.get('PS_PANEL', sec), ...
					            'Units', 'pixels', ...
					            'Position', [4 ps_y w_p-8 ps_h] ...
					            )
					        
					        for cl = 1:1:pc_numbers(sec)
					            set(pr.get('PC_BTN', sec, cl), 'Position', [4 (pr.get('HEIGHT_PS_FOOTER')+(pc_numbers(sec)-cl)*pr.get('HEIGHT_PC')) w(pr.get('PS_PANEL', sec), 'pixels')-pr.get('HEIGHT_PC')-11 pr.get('HEIGHT_PC')])
					            set(pr.get('PC_CLEAR_BTN', sec, cl), 'Position', [w(pr.get('PS_PANEL', sec), 'pixels')-pr.get('HEIGHT_PC')-4 (pr.get('HEIGHT_PS_FOOTER')+(pc_numbers(sec)-cl)*pr.get('HEIGHT_PC')) pr.get('HEIGHT_PC') pr.get('HEIGHT_PC')])
					        end
					    end
					end
					
				case 16 % PipelinePP_PSDict.SHOW
					value = calculateValue@PanelProp(pr, 16, varargin{:}); % also warning
					if value
					    % % figures for elements/buttons, currently not in use
					    % gui_pc_dict = pr.get('GUI_PC_DICT');
					    % for i = 1:1:gui_pc_dict.get('LENGTH')
					    %     gui = gui_pc_dict.get('IT', i);
					    %     if gui.get('DRAWN')
					    %         gui.get('SHOW')
					    %     end
					    % end
					end
					
				case 17 % PipelinePP_PSDict.HIDE
					value = calculateValue@PanelProp(pr, 17, varargin{:}); % also warning
					if value
					    % figures for items
					    gui_pc_dict = pr.get('GUI_PC_DICT');
					    for i = 1:1:gui_pc_dict.get('LENGTH')
					        gui = gui_pc_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					end
					
				case 18 % PipelinePP_PSDict.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('HANDLES', Element.getNoValue())
					end
					
				case 19 % PipelinePP_PSDict.CLOSE
					value = calculateValue@PanelProp(pr, 19, varargin{:}); % also warning
					if value
					    % figures for items
					    gui_pc_dict = pr.get('GUI_PC_DICT');
					    for i = 1:1:gui_pc_dict.get('LENGTH')
					        gui = gui_pc_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('CLOSE')
					        end
					    end
					end
					
				otherwise
					if prop <= 35
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_pc_btn(src, ~)
			    userdata = get(src, 'UserData');
			    sec = userdata(1);
			    cl = userdata(2);
			
			    pr.get('UPDATE', 'Section', sec, 'Code', cl)
			end
			function cb_pc_clear_btn(src, ~)
			
			    userdata = get(src, 'UserData');
			    sec = userdata(1);
			    cl = userdata(2);
			    
			    % resets the code eliminating element
			    pc_dict = pip.get('PS_DICT').get('IT', sec).get('PC_DICT');
			    code = pc_dict.get('IT', cl);
			    code_new = PipelineCode( ...
			        'TEMPLATE', code.get('TEMPLATE'), ...
			        'ID', code.get('ID'), ...
			        'LABEL', code.get('LABEL'), ...
			        'NOTES', code.get('NOTES'), ...
			        'TEMPLATE', code.get('TEMPLATE'), ...
			        'TEXT_BEFORE_EXEC', code.get('TEXT_BEFORE_EXEC'), ...
			        'TEXT_AFTER_EXEC', code.get('TEXT_AFTER_EXEC'), ...
			        'MONIKER', code.get('MONIKER'), ...
			        'CODE', code.get('CODE') ...
			        );
			    pc_dict.get('REPLACE_IT', code, code_new)
			    
			    % closes and removes the GUI
			    key = [int2str(sec) '.' int2str(cl)];
			    gui_pc_dict = pr.get('GUI_PC_DICT');
			    if gui_pc_dict.get('CONTAINS_KEY', key)
			        gui_pc = gui_pc_dict.get('IT', key);
			        if gui_pc.get('DRAWN')
			            gui_pc.get('CLOSE')
			        end
			        gui_pc_dict.get('REMOVE', key)
			    end
			    
			    pr.get('UPDATE')
			end
		end
	end
end
