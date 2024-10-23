classdef AnalyzeEnsemblePP_GDict < PanelProp
	%AnalyzeEnsemblePP_GDict plots the panel to manage the graph of an ensemble analysis.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% AnalyzeEnsemblePP_GDict plots the panel to manage the graph and measures of an ensemble analysis.
	% It is intended to be used only with the property ME_DICT of AnalyzeEnsemble.
	%
	% The list of AnalyzeEnsemblePP_GDict properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the graph and measure panel.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the graph and measure panel.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the graph and measure panel.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the graph and measure panel.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the graph and measure panel.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graph and measure panel.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.
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
	%  <strong>36</strong> <strong>TABLE_HEIGHT</strong> 	TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.
	%  <strong>37</strong> <strong>SELECTED</strong> 	SELECTED (gui, cvector) is the list of selected items.
	%  <strong>38</strong> <strong>TABLE</strong> 	TABLE (evanescent, handle) is the table.
	%  <strong>39</strong> <strong>CONTEXTMENU</strong> 	CONTEXTMENU (evanescent, handle) is the context menu.
	%  <strong>40</strong> <strong>GUI_G_DICT</strong> 	GUI_G_DICT (gui, idict) contains the GUIs for the graph.
	%
	% AnalyzeEnsemblePP_GDict methods (constructor):
	%  AnalyzeEnsemblePP_GDict - constructor
	%
	% AnalyzeEnsemblePP_GDict methods:
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
	% AnalyzeEnsemblePP_GDict methods (display):
	%  tostring - string with information about the graph and measure plot
	%  disp - displays information about the graph and measure plot
	%  tree - displays the tree of the graph and measure plot
	%
	% AnalyzeEnsemblePP_GDict methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph and measure plot are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph and measure plot
	%
	% AnalyzeEnsemblePP_GDict methods (save/load, Static):
	%  save - saves BRAPH2 graph and measure plot as b2 file
	%  load - loads a BRAPH2 graph and measure plot from a b2 file
	%
	% AnalyzeEnsemblePP_GDict method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph and measure plot
	%
	% AnalyzeEnsemblePP_GDict method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph and measure plot
	%
	% AnalyzeEnsemblePP_GDict methods (inspection, Static):
	%  getClass - returns the class of the graph and measure plot
	%  getSubclasses - returns all subclasses of AnalyzeEnsemblePP_GDict
	%  getProps - returns the property list of the graph and measure plot
	%  getPropNumber - returns the property number of the graph and measure plot
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
	% AnalyzeEnsemblePP_GDict methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% AnalyzeEnsemblePP_GDict methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% AnalyzeEnsemblePP_GDict methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeEnsemblePP_GDict methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?AnalyzeEnsemblePP_GDict; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">AnalyzeEnsemblePP_GDict constants</a>.
	%
	%
	% See also uitable, AnalyzeEnsemble, Graph, Measure.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		TABLE_HEIGHT = 36; %CET: Computational Efficiency Trick
		TABLE_HEIGHT_TAG = 'TABLE_HEIGHT';
		TABLE_HEIGHT_CATEGORY = 9;
		TABLE_HEIGHT_FORMAT = 22;
		
		SELECTED = 37; %CET: Computational Efficiency Trick
		SELECTED_TAG = 'SELECTED';
		SELECTED_CATEGORY = 9;
		SELECTED_FORMAT = 13;
		
		TABLE = 38; %CET: Computational Efficiency Trick
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = 7;
		TABLE_FORMAT = 18;
		
		CONTEXTMENU = 39; %CET: Computational Efficiency Trick
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = 7;
		CONTEXTMENU_FORMAT = 18;
		
		GUI_G_DICT = 40; %CET: Computational Efficiency Trick
		GUI_G_DICT_TAG = 'GUI_G_DICT';
		GUI_G_DICT_CATEGORY = 9;
		GUI_G_DICT_FORMAT = 10;
	end
	methods % constructor
		function pr = AnalyzeEnsemblePP_GDict(varargin)
			%AnalyzeEnsemblePP_GDict() creates a graph and measure plot.
			%
			% AnalyzeEnsemblePP_GDict(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeEnsemblePP_GDict(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of AnalyzeEnsemblePP_GDict properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the graph and measure panel.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the graph and measure panel.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the graph and measure panel.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the graph and measure panel.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the graph and measure panel.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graph and measure panel.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.
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
			%  <strong>36</strong> <strong>TABLE_HEIGHT</strong> 	TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.
			%  <strong>37</strong> <strong>SELECTED</strong> 	SELECTED (gui, cvector) is the list of selected items.
			%  <strong>38</strong> <strong>TABLE</strong> 	TABLE (evanescent, handle) is the table.
			%  <strong>39</strong> <strong>CONTEXTMENU</strong> 	CONTEXTMENU (evanescent, handle) is the context menu.
			%  <strong>40</strong> <strong>GUI_G_DICT</strong> 	GUI_G_DICT (gui, idict) contains the GUIs for the graph.
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the graph and measure plot.
			%
			% BUILD = AnalyzeEnsemblePP_GDict.GETBUILD() returns the build of 'AnalyzeEnsemblePP_GDict'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the graph and measure plot PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('AnalyzeEnsemblePP_GDict') returns the build of 'AnalyzeEnsemblePP_GDict'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the graph and measure plot.
			%
			% CLASS = AnalyzeEnsemblePP_GDict.GETCLASS() returns the class 'AnalyzeEnsemblePP_GDict'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the graph and measure plot PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('AnalyzeEnsemblePP_GDict') returns 'AnalyzeEnsemblePP_GDict'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			
			pr_class = 'AnalyzeEnsemblePP_GDict';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph and measure plot.
			%
			% LIST = AnalyzeEnsemblePP_GDict.GETSUBCLASSES() returns all subclasses of 'AnalyzeEnsemblePP_GDict'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the graph and measure plot PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('AnalyzeEnsemblePP_GDict') returns all subclasses of 'AnalyzeEnsemblePP_GDict'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'AnalyzeEnsemblePP_GDict' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph and measure plot.
			%
			% PROPS = AnalyzeEnsemblePP_GDict.GETPROPS() returns the property list of graph and measure plot
			%  as a row vector.
			%
			% PROPS = AnalyzeEnsemblePP_GDict.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the graph and measure plot PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('AnalyzeEnsemblePP_GDict'[, CATEGORY]) returns the property list of 'AnalyzeEnsemblePP_GDict'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40];
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
					prop_list = [10 15 27 28 30 31 32 33 34 35 38 39];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36 37 40];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph and measure plot.
			%
			% N = AnalyzeEnsemblePP_GDict.GETPROPNUMBER() returns the property number of graph and measure plot.
			%
			% N = AnalyzeEnsemblePP_GDict.GETPROPNUMBER(CATEGORY) returns the property number of graph and measure plot
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the graph and measure plot PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('AnalyzeEnsemblePP_GDict') returns the property number of 'AnalyzeEnsemblePP_GDict'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 40;
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
					prop_number = 12;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 7;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph and measure plot/error.
			%
			% CHECK = AnalyzeEnsemblePP_GDict.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(AnalyzeEnsemblePP_GDict, PROP) checks whether PROP exists for AnalyzeEnsemblePP_GDict.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			%  Element.EXISTSPROP(AnalyzeEnsemblePP_GDict, PROP) throws error if PROP does NOT exist for AnalyzeEnsemblePP_GDict.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 40 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeEnsemblePP_GDict:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeEnsemblePP_GDict:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeEnsemblePP_GDict.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph and measure plot/error.
			%
			% CHECK = AnalyzeEnsemblePP_GDict.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(AnalyzeEnsemblePP_GDict, TAG) checks whether TAG exists for AnalyzeEnsemblePP_GDict.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			%  Element.EXISTSTAG(AnalyzeEnsemblePP_GDict, TAG) throws error if TAG does NOT exist for AnalyzeEnsemblePP_GDict.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'TABLE_HEIGHT'  'SELECTED'  'TABLE'  'CONTEXTMENU'  'GUI_G_DICT' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeEnsemblePP_GDict:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeEnsemblePP_GDict:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for AnalyzeEnsemblePP_GDict.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(AnalyzeEnsemblePP_GDict, POINTER) returns property number of POINTER of AnalyzeEnsemblePP_GDict.
			%  PROPERTY = PR.GETPROPPROP(AnalyzeEnsemblePP_GDict, POINTER) returns property number of POINTER of AnalyzeEnsemblePP_GDict.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'TABLE_HEIGHT'  'SELECTED'  'TABLE'  'CONTEXTMENU'  'GUI_G_DICT' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(AnalyzeEnsemblePP_GDict, POINTER) returns tag of POINTER of AnalyzeEnsemblePP_GDict.
			%  TAG = PR.GETPROPTAG(AnalyzeEnsemblePP_GDict, POINTER) returns tag of POINTER of AnalyzeEnsemblePP_GDict.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				analyzeensemblepp_gdict_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'TABLE_HEIGHT'  'SELECTED'  'TABLE'  'CONTEXTMENU'  'GUI_G_DICT' };
				tag = analyzeensemblepp_gdict_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeEnsemblePP_GDict, POINTER) returns category of POINTER of AnalyzeEnsemblePP_GDict.
			%  CATEGORY = PR.GETPROPCATEGORY(AnalyzeEnsemblePP_GDict, POINTER) returns category of POINTER of AnalyzeEnsemblePP_GDict.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemblePP_GDict.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzeensemblepp_gdict_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  9  7  7  9 };
			prop_category = analyzeensemblepp_gdict_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeEnsemblePP_GDict, POINTER) returns format of POINTER of AnalyzeEnsemblePP_GDict.
			%  FORMAT = PR.GETPROPFORMAT(AnalyzeEnsemblePP_GDict, POINTER) returns format of POINTER of AnalyzeEnsemblePP_GDict.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemblePP_GDict.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzeensemblepp_gdict_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  22  13  18  18  10 };
			prop_format = analyzeensemblepp_gdict_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeEnsemblePP_GDict, POINTER) returns description of POINTER of AnalyzeEnsemblePP_GDict.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(AnalyzeEnsemblePP_GDict, POINTER) returns description of POINTER of AnalyzeEnsemblePP_GDict.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemblePP_GDict.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzeensemblepp_gdict_description_list = { 'ELCLASS (constant, string) is the class of the % % % .'  'NAME (constant, string) is the name of the graph and measure panel.'  'DESCRIPTION (constant, string) is the description of the graph and measure panel.'  'TEMPLATE (parameter, item) is the template of the graph and measure panel.'  'ID (data, string) is a few-letter code for the graph and measure panel.'  'LABEL (metadata, string) is an extended label of the graph and measure panel.'  'NOTES (metadata, string) are some specific notes about the graph and measure panel.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the table.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the prop panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.'  'SELECTED (gui, cvector) is the list of selected items.'  'TABLE (evanescent, handle) is the table.'  'CONTEXTMENU (evanescent, handle) is the context menu.'  'GUI_G_DICT (gui, idict) contains the GUIs for the graph.' };
			prop_description = analyzeensemblepp_gdict_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeEnsemblePP_GDict, POINTER) returns settings of POINTER of AnalyzeEnsemblePP_GDict.
			%  SETTINGS = PR.GETPROPSETTINGS(AnalyzeEnsemblePP_GDict, POINTER) returns settings of POINTER of AnalyzeEnsemblePP_GDict.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemblePP_GDict.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % AnalyzeEnsemblePP_GDict.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(22);
				case 37 % AnalyzeEnsemblePP_GDict.SELECTED
					prop_settings = Format.getFormatSettings(13);
				case 38 % AnalyzeEnsemblePP_GDict.TABLE
					prop_settings = Format.getFormatSettings(18);
				case 39 % AnalyzeEnsemblePP_GDict.CONTEXTMENU
					prop_settings = Format.getFormatSettings(18);
				case 40 % AnalyzeEnsemblePP_GDict.GUI_G_DICT
					prop_settings = 'GUIElement';
				case 4 % AnalyzeEnsemblePP_GDict.TEMPLATE
					prop_settings = 'AnalyzeEnsemblePP_GDict';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeEnsemblePP_GDict.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemblePP_GDict.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeEnsemblePP_GDict, POINTER) returns the default value of POINTER of AnalyzeEnsemblePP_GDict.
			%  DEFAULT = PR.GETPROPDEFAULT(AnalyzeEnsemblePP_GDict, POINTER) returns the default value of POINTER of AnalyzeEnsemblePP_GDict.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeEnsemblePP_GDict.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % AnalyzeEnsemblePP_GDict.TABLE_HEIGHT
					prop_default = 360;
				case 37 % AnalyzeEnsemblePP_GDict.SELECTED
					prop_default = Format.getFormatDefault(13, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case 38 % AnalyzeEnsemblePP_GDict.TABLE
					prop_default = Format.getFormatDefault(18, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case 39 % AnalyzeEnsemblePP_GDict.CONTEXTMENU
					prop_default = Format.getFormatDefault(18, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case 40 % AnalyzeEnsemblePP_GDict.GUI_G_DICT
					prop_default = Format.getFormatDefault(10, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case 1 % AnalyzeEnsemblePP_GDict.ELCLASS
					prop_default = 'AnalyzeEnsemblePP_GDict';
				case 2 % AnalyzeEnsemblePP_GDict.NAME
					prop_default = 'AnalyzeEnsemblePP_GDict';
				case 3 % AnalyzeEnsemblePP_GDict.DESCRIPTION
					prop_default = 'AnalyzeEnsemblePP_GDict plots the panel to manage the graph and measures of an ensemble analysis.';
				case 4 % AnalyzeEnsemblePP_GDict.TEMPLATE
					prop_default = Format.getFormatDefault(8, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case 5 % AnalyzeEnsemblePP_GDict.ID
					prop_default = 'AnalyzeEnsemblePP_GDict';
				case 6 % AnalyzeEnsemblePP_GDict.LABEL
					prop_default = 'AnalyzeEnsemblePP_GDict label';
				case 7 % AnalyzeEnsemblePP_GDict.NOTES
					prop_default = 'AnalyzeEnsemblePP_GDict';
				case 23 % AnalyzeEnsemblePP_GDict.EL
					prop_default = AnalyzeEnsemble();
				case 24 % AnalyzeEnsemblePP_GDict.PROP
					prop_default = 12;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeEnsemblePP_GDict.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemblePP_GDict.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemblePP_GDict, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemblePP_GDict.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemblePP_GDict, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemblePP_GDict.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = AnalyzeEnsemblePP_GDict.getPropProp(pointer);
			
			prop_default = AnalyzeEnsemblePP_GDict.conditioning(prop, AnalyzeEnsemblePP_GDict.getPropDefault(prop));
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
			
			prop = AnalyzeEnsemblePP_GDict.getPropProp(pointer);
			
			switch prop
				case 37 % AnalyzeEnsemblePP_GDict.SELECTED
					if isrow(value)
					    value = value';
					end
					
				otherwise
					if prop <= 35
						value = conditioning@PanelProp(pointer, value);
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
			%  CHECK = Element.CHECKPROP(AnalyzeEnsemblePP_GDict, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemblePP_GDict.
			%  CHECK = PR.CHECKPROP(AnalyzeEnsemblePP_GDict, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemblePP_GDict.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput
			%  Element.CHECKPROP(AnalyzeEnsemblePP_GDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemblePP_GDict.
			%   Error id: BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput
			%  PR.CHECKPROP(AnalyzeEnsemblePP_GDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemblePP_GDict.
			%   Error id: BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = AnalyzeEnsemblePP_GDict.getPropProp(pointer);
			
			switch prop
				case 36 % AnalyzeEnsemblePP_GDict.TABLE_HEIGHT
					check = Format.checkFormat(22, value, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case 37 % AnalyzeEnsemblePP_GDict.SELECTED
					check = Format.checkFormat(13, value, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case 38 % AnalyzeEnsemblePP_GDict.TABLE
					check = Format.checkFormat(18, value, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case 39 % AnalyzeEnsemblePP_GDict.CONTEXTMENU
					check = Format.checkFormat(18, value, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case 40 % AnalyzeEnsemblePP_GDict.GUI_G_DICT
					check = Format.checkFormat(10, value, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case 4 % AnalyzeEnsemblePP_GDict.TEMPLATE
					check = Format.checkFormat(8, value, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeEnsemblePP_GDict:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeEnsemblePP_GDict:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeEnsemblePP_GDict.getPropTag(prop) ' (' AnalyzeEnsemblePP_GDict.getFormatTag(AnalyzeEnsemblePP_GDict.getPropFormat(prop)) ').'] ...
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
				case 38 % AnalyzeEnsemblePP_GDict.TABLE
					table = uitable( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'table', ...
					    'FontSize', 12, ...
					    'ColumnSortable', true, ...
					    'ColumnName', {'', 'Subject', 'Notes'}, ...
					    'ColumnFormat', {'logical',  'char', 'char'}, ...
					    'ColumnWidth', {30, 'auto', 'auto'}, ...
					    'ColumnEditable', [true false false], ...
					    'CellEditCallback', {@cb_table} ...
					    );
					value = table;
					
				case 39 % AnalyzeEnsemblePP_GDict.CONTEXTMENU
					contextmenu = uicontextmenu( ...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_select_all = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_SELECT_ALL', ...
					    'Text', 'Select All Graphs', ...
					    'MenuSelectedFcn', {@cb_select_all} ...
					    );
					menu_clear_selection = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_CLEAR_SELECTION', ...
					    'Text', 'Clear Selection', ...
					    'MenuSelectedFcn', {@cb_clear_selection} ...
					    );
					menu_invert_selection = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_INVERT_SELECTION', ...
					    'Text', 'Invert Selection', ...
					    'MenuSelectedFcn', {@cb_invert_selection} ...
					    );
					menu_open_g_pl = uimenu( ...
						'Parent', contextmenu, ...
						'Tag', 'MENU_OPEN_G_PL', ...
						'Text', 'Plot Selected Adjacency Matrices', ...
						'MenuSelectedFcn', {@cb_open_g_pl} ...
						);
					menu_hide_g_pl = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_G_PL', ...
					    'Text', 'Hide Selected Adjacency Matrices', ...
					    'MenuSelectedFcn', {@cb_hide_g_pl} ...
						);
					menu_open_g_h = uimenu( ...
						'Parent', contextmenu, ...
						'Tag', 'MENU_OPEN_G_H', ...
						'Text', 'Plot Selected Histograms', ...
						'MenuSelectedFcn', {@cb_open_g_h} ...
						);
					menu_hide_g_pl = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_G_H', ...
					    'Text', 'Hide Selected Histograms', ...
					    'MenuSelectedFcn', {@cb_hide_g_h} ...
						);
					menu_open_g_el = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_OPEN_G_EL', ...
					    'Text', 'Data Selected Graph ...', ...
					    'MenuSelectedFcn', {@cb_open_g_el} ...
					    );
					menu_hide_g_el = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_G_EL', ...
					    'Text', 'Hide Selected Graph Data', ...
						'MenuSelectedFcn', {@cb_hide_g_el} ...
					    );
					
					set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					
					value = contextmenu;
					
				case 20 % AnalyzeEnsemblePP_GDict.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					end
					
				case 21 % AnalyzeEnsemblePP_GDict.UPDATE
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value
						el = pr.get('EL');
						prop = pr.get('PROP');
					        
						if isa(el.getr(prop), 'NoValue')
					        % don't plot anything for a result not yet calculated
					        pr.set('HEIGHT', pr.getPropDefault('HEIGHT'))
					        set(pr.get('TABLE'), 'Visible', 'off')
					    else
					        set_table()
					        pr.set('HEIGHT', pr.getPropDefault('HEIGHT') + pr.get('TABLE_HEIGHT'))
					        set(pr.get('TABLE'), 'Visible', 'on')
					    end
					end
					
				case 22 % AnalyzeEnsemblePP_GDict.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [4 4 w_p-8 max(1, pr.get('HEIGHT')-27)])
					end
					
				case 16 % AnalyzeEnsemblePP_GDict.SHOW
					value = calculateValue@PanelProp(pr, 16, varargin{:}); % also warning
					if value
					    % Graph
					    gui_g_dict = pr.get('GUI_G_DICT');
					    for i = 1:1:gui_g_dict.get('LENGTH')
					        gui = gui_g_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					end
					
				case 17 % AnalyzeEnsemblePP_GDict.HIDE
					value = calculateValue@PanelProp(pr, 17, varargin{:}); % also warning
					if value
					    % Graph
					    gui_g_dict = pr.get('GUI_G_DICT');
					    for i = 1:1:gui_g_dict.get('LENGTH')
					        gui = gui_g_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					end
					
				case 18 % AnalyzeEnsemblePP_GDict.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					end
					
				case 19 % AnalyzeEnsemblePP_GDict.CLOSE
					value = calculateValue@PanelProp(pr, 19, varargin{:}); % also warning
					if value
					    % Graph
					    gui_g_dict = pr.get('GUI_G_DICT');
					    for i = 1:1:gui_g_dict.get('LENGTH')
					        gui = gui_g_dict.get('IT', i);
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
			
			function cb_table(~, event) % (src, event)
			    % only needs to update the selector
			
			        i = event.Indices(1);
			        
			        selected = pr.get('SELECTED');
			        if event.NewData == 1
			            pr.set('SELECTED', sort(unique([selected; i])));
			        else
			            pr.set('SELECTED', selected(selected ~= i));
			        end
			        
			        pr.get('UPDATE')    
			end
			function cb_open_g_pl(~, ~)
			    a = pr.get('EL');
			    g_dict = a.get(pr.get('PROP')); 
			    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key
			
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI
			    N = ceil(sqrt(length(g_key_list))); % number of row and columns of figures
			
			    selected = pr.get('SELECTED');
			    gui_g_dict = pr.memorize('GUI_G_DICT');
			    
			    for s = 1:1:length(selected)
			        i = selected(s);
			        g_key = g_key_list{i}; % key for graph
			        if ~gui_g_dict.get('CONTAINS_KEY', g_key)
			            g = g_dict.get('IT', g_key); % actual graph
			            gui = GUIElement( ...
			                'ID', g_key, ... % this is the dictionary key for graph
			                'PE', g, ...
			                'POSITION', [ ...
			                x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
			                y0(f, 'normalized') ... % y = f_gr_y / screen_h;
			                w(f, 'normalized') ... % w = f_gr_w / screen_w;
			                .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
			                ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_g_dict.get('ADD', gui)
			        end
			
			        gui = gui_g_dict.get('IT', g_key);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			
			        gui_pfga = gui.get('PE').get('PR_DICT').get('IT', 'PFGA').memorize('GUI_ITEM');
			        set(gui_pfga, 'TITLE', ['Adjacency matrices plot - ' g_key]);
			        if ~gui_pfga.get('DRAWN')
			            gui_pfga.get('DRAW')
			        end
			
			        gui_pfga.get('SHOW')
			    end
			end
			function cb_hide_g_pl(~, ~)
			    g_dict = pr.get('EL').get(pr.get('PROP'));
			    g_key_list =  cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key
			    
			    gui_g_dict = pr.memorize('GUI_G_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        g_key = g_key_list{i}; % key for graph
			        
			        if gui_g_dict.get('CONTAINS_KEY', g_key)
			            gui = gui_g_dict.get('IT', g_key);
			            gui_pfga = gui.get('PE').get('PR_DICT').get('IT', 'PFGA').memorize('GUI_ITEM');
			            if gui.get('DRAWN')
			                gui_pfga.get('HIDE')
			            end
			        end
			    end
			end
			function cb_open_g_h(~, ~)
			    a = pr.get('EL');
			    g_dict = a.get(pr.get('PROP')); 
			    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key
			
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI
			    N = ceil(sqrt(length(g_key_list))); % number of row and columns of figures
			
			    selected = pr.get('SELECTED');
			    gui_g_dict = pr.memorize('GUI_G_DICT');
			    
			    for s = 1:1:length(selected)
			        i = selected(s);
			        g_key = g_key_list{i}; % key for graph
			        if ~gui_g_dict.get('CONTAINS_KEY', g_key)
			            g = g_dict.get('IT', g_key); % actual graph
			            gui = GUIElement( ...
			                'ID', g_key, ... % this is the dictionary key for graph
			                'PE', g, ...
			                'POSITION', [ ...
			                x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
			                y0(f, 'normalized') ... % y = f_gr_y / screen_h;
			                w(f, 'normalized') ... % w = f_gr_w / screen_w;
			                .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
			                ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_g_dict.get('ADD', gui)
			        end
			
			        gui = gui_g_dict.get('IT', g_key);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			
			        gui_pfgh = gui.get('PE').get('PR_DICT').get('IT', 'PFGH').memorize('GUI_ITEM');
			        set(gui_pfgh, 'TITLE', ['Histograms plot - ' g_key]);
			        if ~gui_pfgh.get('DRAWN')
			            gui_pfgh.get('DRAW')
			        end
			        
			        gui_pfgh.get('SHOW')
			    end
			end
			function cb_hide_g_h(~, ~)
			    g_dict = pr.get('EL').get(pr.get('PROP'));
			    g_key_list =  cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key
			    
			    gui_g_dict = pr.memorize('GUI_G_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        g_key = g_key_list{i}; % key for graph
			        
			        if gui_g_dict.get('CONTAINS_KEY', g_key)
			            gui = gui_g_dict.get('IT', g_key);
			            gui_pfgh = gui.get('PE').get('PR_DICT').get('IT', 'PFGH').memorize('GUI_ITEM');
			            if gui.get('DRAWN')
			                gui_pfgh.get('HIDE')
			            end
			        end
			    end
			end
			function cb_open_g_el(~, ~)
			    a = pr.get('EL');
			    g_dict = a.get(pr.get('PROP'));
			    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI
			    N = ceil(sqrt(length(g_key_list))); % number of row and columns of figures
			    
			    gui_g_dict = pr.memorize('GUI_G_DICT');
			    
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			    
			        g_key = g_key_list{i}; % key for graph
			    
			        if ~gui_g_dict.get('CONTAINS_KEY', g_key)
			            g = g_dict.get('IT', g_key); % actural graph
			            gui = GUIElement( ...
			                'ID', g_key, ... % this is the dictionary key for graph
			                'PE', g, ... 
			                'POSITION', [ ...
			                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
			                    y0(f, 'normalized') ... % y = f_gr_y / screen_h;
			                    w(f, 'normalized') ... % w = f_gr_w / screen_w;
			                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
			                    ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_g_dict.get('ADD', gui)
			        end
			        gui = gui_g_dict.get('IT', g_key);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			        gui.get('SHOW')
			    end
			end
			function cb_hide_g_el(~, ~)
			    g_dict = pr.get('EL').get(pr.get('PROP'));
			    g_key_list =  cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key
			    
			    gui_g_dict = pr.memorize('GUI_G_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        g_key = g_key_list{i}; % key for graph
			        
			        if gui_g_dict.get('CONTAINS_KEY', g_key)
			            gui = gui_g_dict.get('IT', g_key);
			            if gui.get('DRAWN')
			                gui.get('HIDE')
			            end
			        end
			    end
			end
			function cb_select_all(~, ~) 
			    g_dict = pr.get('EL').get(pr.get('PROP'));
			    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false);
			
			    pr.set('SELECTED', [1:1:length(g_key_list)])
			
			    pr.get('UPDATE')
			end
			function cb_clear_selection(~, ~) 
			    pr.set('SELECTED', [])
			
			    pr.get('UPDATE')
			end
			function cb_invert_selection(~, ~) 
			    g_dict = pr.get('EL').get(pr.get('PROP'));
			    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false);
			
			    selected_tmp = [1:1:length(g_key_list)];
			    selected_tmp(pr.get('SELECTED')) = [];
			    pr.set('SELECTED', selected_tmp);
			
			    pr.get('UPDATE')
			end
			function set_table()
			    a = pr.get('EL');
			    prop = pr.get('PROP');
			    if isa(a.getr('GRAPH_TEMPLATE'), 'NoValue')
			        g = a.getPropDefaultConditioned('GRAPH_TEMPLATE'); % default graph
			    else
			        g = a.get('GRAPH_TEMPLATE'); % actual graph
			    end
			    
			    g_dict = a.get(prop);
			    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false);
			    
			    rowname = cell(length(g_key_list), 1);
			    data = cell(length(g_key_list), 3);
			    for gi = 1:1:length(g_key_list)
			        if any(pr.get('SELECTED') == gi)
			            data{gi, 1} = true;
			        else
			            data{gi, 1} = false;
			        end
			    
			        data{gi, 2} = g_key_list{gi};
			        data{gi, 3} = g_dict.get('IT', gi).get('NOTES');
			    end
			
			    set(pr.get('TABLE'), ...
			        'RowName', rowname, ...
			        'Data', data ...
			        )
			
			    % style SELECTED
			    styles_row = find(pr.get('TABLE').StyleConfigurations.Target == 'row');
			    if ~isempty(styles_row)
			        removeStyle(pr.get('TABLE'), styles_row)
			    end
			    if ~isempty(pr.get('SELECTED'))
			        addStyle(pr.get('TABLE'), uistyle('FontWeight', 'bold'), 'row', pr.get('SELECTED'))
			    end
			end
		end
	end
end
