classdef CompareEnsemblePP_CpDict < PanelProp
	%CompareEnsemblePP_CpDict plots the panel to manage the comparisons of an ensemble analysis.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Comparison Plot for Ensemble Analysis (CompareEnsemblePP_CpDict) plots the panel to manage the comparisons of an ensemble analysis.
	% It is intended to be used only with the property CP_DICT of CompareEnsemble.
	%
	% The list of CompareEnsemblePP_CpDict properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the comparison panel for ensemble analysis.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the comparison panel for ensemble analysis.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the comparison panel for ensemble analysis.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the comparison panel for ensemble analysis.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the comparison panel for ensemble analysis.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the comparison panel for ensemble analysis.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the comparison panel for ensemble analysis.
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
	%  <strong>40</strong> <strong>GUI_CP_DICT</strong> 	GUI_CP_DICT (gui, idict) contains the GUIs for the comparison.
	%
	% CompareEnsemblePP_CpDict methods (constructor):
	%  CompareEnsemblePP_CpDict - constructor
	%
	% CompareEnsemblePP_CpDict methods:
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
	% CompareEnsemblePP_CpDict methods (display):
	%  tostring - string with information about the comparison plot for ensemble analysis
	%  disp - displays information about the comparison plot for ensemble analysis
	%  tree - displays the tree of the comparison plot for ensemble analysis
	%
	% CompareEnsemblePP_CpDict methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two comparison plot for ensemble analysis are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the comparison plot for ensemble analysis
	%
	% CompareEnsemblePP_CpDict methods (save/load, Static):
	%  save - saves BRAPH2 comparison plot for ensemble analysis as b2 file
	%  load - loads a BRAPH2 comparison plot for ensemble analysis from a b2 file
	%
	% CompareEnsemblePP_CpDict method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the comparison plot for ensemble analysis
	%
	% CompareEnsemblePP_CpDict method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the comparison plot for ensemble analysis
	%
	% CompareEnsemblePP_CpDict methods (inspection, Static):
	%  getClass - returns the class of the comparison plot for ensemble analysis
	%  getSubclasses - returns all subclasses of CompareEnsemblePP_CpDict
	%  getProps - returns the property list of the comparison plot for ensemble analysis
	%  getPropNumber - returns the property number of the comparison plot for ensemble analysis
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
	% CompareEnsemblePP_CpDict methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% CompareEnsemblePP_CpDict methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% CompareEnsemblePP_CpDict methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% CompareEnsemblePP_CpDict methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?CompareEnsemblePP_CpDict; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">CompareEnsemblePP_CpDict constants</a>.
	%
	%
	% See also uitable, CompareEnsemble, ComparisonEnsemble.
	%
	% BUILD BRAPH2 7 class_name 1
	
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
		
		GUI_CP_DICT = 40; %CET: Computational Efficiency Trick
		GUI_CP_DICT_TAG = 'GUI_CP_DICT';
		GUI_CP_DICT_CATEGORY = 9;
		GUI_CP_DICT_FORMAT = 10;
	end
	methods % constructor
		function pr = CompareEnsemblePP_CpDict(varargin)
			%CompareEnsemblePP_CpDict() creates a comparison plot for ensemble analysis.
			%
			% CompareEnsemblePP_CpDict(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% CompareEnsemblePP_CpDict(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of CompareEnsemblePP_CpDict properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the comparison panel for ensemble analysis.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the comparison panel for ensemble analysis.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the comparison panel for ensemble analysis.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the comparison panel for ensemble analysis.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the comparison panel for ensemble analysis.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the comparison panel for ensemble analysis.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the comparison panel for ensemble analysis.
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
			%  <strong>40</strong> <strong>GUI_CP_DICT</strong> 	GUI_CP_DICT (gui, idict) contains the GUIs for the comparison.
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the comparison plot for ensemble analysis.
			%
			% BUILD = CompareEnsemblePP_CpDict.GETBUILD() returns the build of 'CompareEnsemblePP_CpDict'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the comparison plot for ensemble analysis PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('CompareEnsemblePP_CpDict') returns the build of 'CompareEnsemblePP_CpDict'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the comparison plot for ensemble analysis.
			%
			% CLASS = CompareEnsemblePP_CpDict.GETCLASS() returns the class 'CompareEnsemblePP_CpDict'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the comparison plot for ensemble analysis PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('CompareEnsemblePP_CpDict') returns 'CompareEnsemblePP_CpDict'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			
			pr_class = 'CompareEnsemblePP_CpDict';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the comparison plot for ensemble analysis.
			%
			% LIST = CompareEnsemblePP_CpDict.GETSUBCLASSES() returns all subclasses of 'CompareEnsemblePP_CpDict'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the comparison plot for ensemble analysis PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('CompareEnsemblePP_CpDict') returns all subclasses of 'CompareEnsemblePP_CpDict'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'CompareEnsemblePP_CpDict' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of comparison plot for ensemble analysis.
			%
			% PROPS = CompareEnsemblePP_CpDict.GETPROPS() returns the property list of comparison plot for ensemble analysis
			%  as a row vector.
			%
			% PROPS = CompareEnsemblePP_CpDict.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the comparison plot for ensemble analysis PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('CompareEnsemblePP_CpDict'[, CATEGORY]) returns the property list of 'CompareEnsemblePP_CpDict'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('CompareEnsemblePP_CpDict')
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
			%GETPROPNUMBER returns the property number of comparison plot for ensemble analysis.
			%
			% N = CompareEnsemblePP_CpDict.GETPROPNUMBER() returns the property number of comparison plot for ensemble analysis.
			%
			% N = CompareEnsemblePP_CpDict.GETPROPNUMBER(CATEGORY) returns the property number of comparison plot for ensemble analysis
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the comparison plot for ensemble analysis PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('CompareEnsemblePP_CpDict') returns the property number of 'CompareEnsemblePP_CpDict'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('CompareEnsemblePP_CpDict')
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
			%EXISTSPROP checks whether property exists in comparison plot for ensemble analysis/error.
			%
			% CHECK = CompareEnsemblePP_CpDict.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(CompareEnsemblePP_CpDict, PROP) checks whether PROP exists for CompareEnsemblePP_CpDict.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			%  Element.EXISTSPROP(CompareEnsemblePP_CpDict, PROP) throws error if PROP does NOT exist for CompareEnsemblePP_CpDict.
			%   Error id: [BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 40 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CompareEnsemblePP_CpDict:' 'WrongInput'], ...
					['BRAPH2' ':CompareEnsemblePP_CpDict:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for CompareEnsemblePP_CpDict.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in comparison plot for ensemble analysis/error.
			%
			% CHECK = CompareEnsemblePP_CpDict.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(CompareEnsemblePP_CpDict, TAG) checks whether TAG exists for CompareEnsemblePP_CpDict.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			%  Element.EXISTSTAG(CompareEnsemblePP_CpDict, TAG) throws error if TAG does NOT exist for CompareEnsemblePP_CpDict.
			%   Error id: [BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'TABLE_HEIGHT'  'SELECTED'  'TABLE'  'CONTEXTMENU'  'GUI_CP_DICT' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CompareEnsemblePP_CpDict:' 'WrongInput'], ...
					['BRAPH2' ':CompareEnsemblePP_CpDict:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for CompareEnsemblePP_CpDict.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(CompareEnsemblePP_CpDict, POINTER) returns property number of POINTER of CompareEnsemblePP_CpDict.
			%  PROPERTY = PR.GETPROPPROP(CompareEnsemblePP_CpDict, POINTER) returns property number of POINTER of CompareEnsemblePP_CpDict.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'TABLE_HEIGHT'  'SELECTED'  'TABLE'  'CONTEXTMENU'  'GUI_CP_DICT' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(CompareEnsemblePP_CpDict, POINTER) returns tag of POINTER of CompareEnsemblePP_CpDict.
			%  TAG = PR.GETPROPTAG(CompareEnsemblePP_CpDict, POINTER) returns tag of POINTER of CompareEnsemblePP_CpDict.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				compareensemblepp_cpdict_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'TABLE_HEIGHT'  'SELECTED'  'TABLE'  'CONTEXTMENU'  'GUI_CP_DICT' };
				tag = compareensemblepp_cpdict_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(CompareEnsemblePP_CpDict, POINTER) returns category of POINTER of CompareEnsemblePP_CpDict.
			%  CATEGORY = PR.GETPROPCATEGORY(CompareEnsemblePP_CpDict, POINTER) returns category of POINTER of CompareEnsemblePP_CpDict.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = CompareEnsemblePP_CpDict.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			compareensemblepp_cpdict_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  9  7  7  9 };
			prop_category = compareensemblepp_cpdict_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(CompareEnsemblePP_CpDict, POINTER) returns format of POINTER of CompareEnsemblePP_CpDict.
			%  FORMAT = PR.GETPROPFORMAT(CompareEnsemblePP_CpDict, POINTER) returns format of POINTER of CompareEnsemblePP_CpDict.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = CompareEnsemblePP_CpDict.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			compareensemblepp_cpdict_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  22  13  18  18  10 };
			prop_format = compareensemblepp_cpdict_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CompareEnsemblePP_CpDict, POINTER) returns description of POINTER of CompareEnsemblePP_CpDict.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(CompareEnsemblePP_CpDict, POINTER) returns description of POINTER of CompareEnsemblePP_CpDict.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = CompareEnsemblePP_CpDict.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			compareensemblepp_cpdict_description_list = { 'ELCLASS (constant, string) is the class of the comparison panel for ensemble analysis.'  'NAME (constant, string) is the name of the comparison panel for ensemble analysis.'  'DESCRIPTION (constant, string) is the description of the comparison panel for ensemble analysis.'  'TEMPLATE (parameter, item) is the template of the comparison panel for ensemble analysis.'  'ID (data, string) is a few-letter code for the comparison panel for ensemble analysis.'  'LABEL (metadata, string) is an extended label of the comparison panel for ensemble analysis.'  'NOTES (metadata, string) are some specific notes about the comparison panel for ensemble analysis.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the table.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the prop panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.'  'SELECTED (gui, cvector) is the list of selected items.'  'TABLE (evanescent, handle) is the table.'  'CONTEXTMENU (evanescent, handle) is the context menu.'  'GUI_CP_DICT (gui, idict) contains the GUIs for the comparison.' };
			prop_description = compareensemblepp_cpdict_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(CompareEnsemblePP_CpDict, POINTER) returns settings of POINTER of CompareEnsemblePP_CpDict.
			%  SETTINGS = PR.GETPROPSETTINGS(CompareEnsemblePP_CpDict, POINTER) returns settings of POINTER of CompareEnsemblePP_CpDict.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = CompareEnsemblePP_CpDict.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % CompareEnsemblePP_CpDict.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(22);
				case 37 % CompareEnsemblePP_CpDict.SELECTED
					prop_settings = Format.getFormatSettings(13);
				case 38 % CompareEnsemblePP_CpDict.TABLE
					prop_settings = Format.getFormatSettings(18);
				case 39 % CompareEnsemblePP_CpDict.CONTEXTMENU
					prop_settings = Format.getFormatSettings(18);
				case 40 % CompareEnsemblePP_CpDict.GUI_CP_DICT
					prop_settings = 'GUIElement';
				case 4 % CompareEnsemblePP_CpDict.TEMPLATE
					prop_settings = 'CompareEnsemblePP_CpDict';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = CompareEnsemblePP_CpDict.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = CompareEnsemblePP_CpDict.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(CompareEnsemblePP_CpDict, POINTER) returns the default value of POINTER of CompareEnsemblePP_CpDict.
			%  DEFAULT = PR.GETPROPDEFAULT(CompareEnsemblePP_CpDict, POINTER) returns the default value of POINTER of CompareEnsemblePP_CpDict.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CompareEnsemblePP_CpDict.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % CompareEnsemblePP_CpDict.TABLE_HEIGHT
					prop_default = 360;
				case 37 % CompareEnsemblePP_CpDict.SELECTED
					prop_default = Format.getFormatDefault(13, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case 38 % CompareEnsemblePP_CpDict.TABLE
					prop_default = Format.getFormatDefault(18, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case 39 % CompareEnsemblePP_CpDict.CONTEXTMENU
					prop_default = Format.getFormatDefault(18, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case 40 % CompareEnsemblePP_CpDict.GUI_CP_DICT
					prop_default = Format.getFormatDefault(10, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case 1 % CompareEnsemblePP_CpDict.ELCLASS
					prop_default = 'CompareEnsemblePP_CpDict';
				case 2 % CompareEnsemblePP_CpDict.NAME
					prop_default = 'CompareEnsemblePP_CpDict';
				case 3 % CompareEnsemblePP_CpDict.DESCRIPTION
					prop_default = 'A Comparison Plot for Ensemble Analysis (CompareEnsemblePP_CpDict) plots the panel to manage the comparisons of an ensemble analysis. It is intended to be used only with the property CP_DICT of CompareEnsemble.';
				case 4 % CompareEnsemblePP_CpDict.TEMPLATE
					prop_default = Format.getFormatDefault(8, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case 5 % CompareEnsemblePP_CpDict.ID
					prop_default = 'CompareEnsemblePP_CpDict';
				case 6 % CompareEnsemblePP_CpDict.LABEL
					prop_default = 'CompareEnsemblePP_CpDict label';
				case 7 % CompareEnsemblePP_CpDict.NOTES
					prop_default = 'CompareEnsemblePP_CpDict';
				case 23 % CompareEnsemblePP_CpDict.EL
					prop_default = CompareEnsemble();
				case 24 % CompareEnsemblePP_CpDict.PROP
					prop_default = 20;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = CompareEnsemblePP_CpDict.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = CompareEnsemblePP_CpDict.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(CompareEnsemblePP_CpDict, POINTER) returns the conditioned default value of POINTER of CompareEnsemblePP_CpDict.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(CompareEnsemblePP_CpDict, POINTER) returns the conditioned default value of POINTER of CompareEnsemblePP_CpDict.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = CompareEnsemblePP_CpDict.getPropProp(pointer);
			
			prop_default = CompareEnsemblePP_CpDict.conditioning(prop, CompareEnsemblePP_CpDict.getPropDefault(prop));
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
			
			prop = CompareEnsemblePP_CpDict.getPropProp(pointer);
			
			switch prop
				case 37 % CompareEnsemblePP_CpDict.SELECTED
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
			%  CHECK = Element.CHECKPROP(CompareEnsemblePP_CpDict, PROP, VALUE) checks VALUE format for PROP of CompareEnsemblePP_CpDict.
			%  CHECK = PR.CHECKPROP(CompareEnsemblePP_CpDict, PROP, VALUE) checks VALUE format for PROP of CompareEnsemblePP_CpDict.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:CompareEnsemblePP_CpDict:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:CompareEnsemblePP_CpDict:WrongInput
			%  Element.CHECKPROP(CompareEnsemblePP_CpDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CompareEnsemblePP_CpDict.
			%   Error id: BRAPH2:CompareEnsemblePP_CpDict:WrongInput
			%  PR.CHECKPROP(CompareEnsemblePP_CpDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CompareEnsemblePP_CpDict.
			%   Error id: BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = CompareEnsemblePP_CpDict.getPropProp(pointer);
			
			switch prop
				case 36 % CompareEnsemblePP_CpDict.TABLE_HEIGHT
					check = Format.checkFormat(22, value, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case 37 % CompareEnsemblePP_CpDict.SELECTED
					check = Format.checkFormat(13, value, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case 38 % CompareEnsemblePP_CpDict.TABLE
					check = Format.checkFormat(18, value, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case 39 % CompareEnsemblePP_CpDict.CONTEXTMENU
					check = Format.checkFormat(18, value, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case 40 % CompareEnsemblePP_CpDict.GUI_CP_DICT
					check = Format.checkFormat(10, value, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case 4 % CompareEnsemblePP_CpDict.TEMPLATE
					check = Format.checkFormat(8, value, CompareEnsemblePP_CpDict.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CompareEnsemblePP_CpDict:' 'WrongInput'], ...
					['BRAPH2' ':CompareEnsemblePP_CpDict:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' CompareEnsemblePP_CpDict.getPropTag(prop) ' (' CompareEnsemblePP_CpDict.getFormatTag(CompareEnsemblePP_CpDict.getPropFormat(prop)) ').'] ...
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
				case 38 % CompareEnsemblePP_CpDict.TABLE
					table = uitable( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'table', ...
					    'FontSize', 12, ...
					    'ColumnSortable', true, ...
					    'ColumnName', {'', 'Measure', 'Shape', 'Scope', 'Notes'}, ...
					    'ColumnFormat', {'logical',  'char', 'char', 'char', 'char'}, ...
					    'ColumnWidth', {30, 'auto', 'auto', 'auto', 'auto'}, ...
					    'ColumnEditable', [true false false false false], ...
					    'CellEditCallback', {@cb_table} ...
					    );
					value = table;
					
				case 39 % CompareEnsemblePP_CpDict.CONTEXTMENU
					contextmenu = uicontextmenu( ...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_select_all = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_SELECT_ALL', ...
					    'Text', 'Select All Comparisons', ...
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
					menu_calculate = uimenu( ...
						'Separator', 'on', ...
						'Parent', contextmenu, ...
						'Tag', 'MENU_CALCULATE', ...
					    'Text', 'Calculate Selected Comparisons', ...
						'MenuSelectedFcn', {@cb_calculate} ...
					    );
					menu_open_mbrain = uimenu( ...
						'Separator', 'on', ...
						'Parent', contextmenu, ...
						'Tag', 'MENU_OPEN_MBRAIN', ...
						'Text', 'Plot Selected Comparisons on Brain ...', ...
						'MenuSelectedFcn', {@cb_open_mbrain} ... % % %
						);
					menu_hide_mbrain = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_MBRAIN', ...
					    'Text', 'Hide Selected Brain-Plots', ...
					    'MenuSelectedFcn', {@cb_hide_mbrain} ... % % %
						);
					menu_open_plots = uimenu( ...
						'Separator', 'on', ...
						'Parent', contextmenu, ...
						'Tag', 'MENU_OPEN_PLOTS', ...
						'Text', 'Plot Selected Comparisons ...', ...
						'MenuSelectedFcn', {@cb_open_plots} ...
						);
					menu_hide_plots = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_PLOTS', ...
					    'Text', 'Hide Selected Plots', ...
					    'MenuSelectedFcn', {@cb_hide_plots} ...
						);
					menu_open_elements = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_OPEN_ELEMENTS', ...
					    'Text', 'Data Selected Comparisons ...', ...
					    'MenuSelectedFcn', {@cb_open_elements} ...
					    );
					menu_hide_elements = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_ELEMENTS', ...
					    'Text', 'Hide Selected Data', ...
						'MenuSelectedFcn', {@cb_hide_elements} ...
					    );
					
					set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					
					value = contextmenu;
					
				case 20 % CompareEnsemblePP_CpDict.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					end
					
				case 21 % CompareEnsemblePP_CpDict.UPDATE
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
					
				case 22 % CompareEnsemblePP_CpDict.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [4 4 w_p-8 max(1, pr.get('HEIGHT')-27)])
					end
					
				case 16 % CompareEnsemblePP_CpDict.SHOW
					value = calculateValue@PanelProp(pr, 16, varargin{:}); % also warning
					if value    
					    % figures for comparison data
					    gui_cp_dict = pr.get('GUI_CP_DICT');
					    for i = 1:1:gui_cp_dict.get('LENGTH')
					        gui = gui_cp_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					end
					
				case 17 % CompareEnsemblePP_CpDict.HIDE
					value = calculateValue@PanelProp(pr, 17, varargin{:}); % also warning
					if value
					    % figures for measure data
					    gui_cp_dict = pr.get('GUI_CP_DICT');
					    for i = 1:1:gui_cp_dict.get('LENGTH')
					        gui = gui_cp_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					end
					
				case 18 % CompareEnsemblePP_CpDict.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					end
					
				case 19 % CompareEnsemblePP_CpDict.CLOSE
					value = calculateValue@PanelProp(pr, 19, varargin{:}); % also warning
					if value
					    % figures for measure data
					    gui_cp_dict = pr.get('GUI_CP_DICT');
					    for i = 1:1:gui_cp_dict.get('LENGTH')
					        gui = gui_cp_dict.get('IT', i);
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
			function cb_select_all(~, ~) 
			    c = pr.get('EL');
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    m_list = g.get('COMPATIBLE_MEASURES');
			
			    pr.set('SELECTED', [1:1:length(m_list)])
			
			    pr.get('UPDATE')
			end
			function cb_clear_selection(~, ~) 
			    pr.set('SELECTED', [])
			
			    pr.get('UPDATE')
			end
			function cb_invert_selection(~, ~) 
			    c = pr.get('EL');
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    m_list = g.get('COMPATIBLE_MEASURES');
			
			    selected_tmp = [1:1:length(m_list)];
			    selected_tmp(pr.get('SELECTED')) = [];
			    pr.set('SELECTED', selected_tmp);
			
			    pr.get('UPDATE')
			end
			function cb_calculate(~, ~) 
			    c = pr.get('EL');
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    m_list = g.get('COMPATIBLE_MEASURES');
			    selected = pr.get('SELECTED');
			    
			    wb = braph2waitbar(pr.get('WAITBAR'), 0, ['Calculating ' num2str(length(selected))  ' comparisons ...']);
			    if check_graphics(wb, 'figure')
			        set(wb, 'Position', [x0(wb) y0(wb)+h(wb) w(wb) h(wb)])
			    end
			
			    for i = 1:1:length(m_list)
			        if ismember(i, selected)
			            measure = m_list{i};
			
			            braph2waitbar(wb, .1 + .9 * i / length(selected), ['Calculating comparison ' int2str(sum(selected <= i)) ' (' measure ') of ' int2str(length(selected)) ' ...'])
			
			            if isa(c.get('COMPARISON', measure).getr('DIFF'), 'NoValue')
			                c.get('COMPARISON', measure).memorize('DIFF');
			                c.get('COMPARISON', measure).memorize('P1');
			                c.get('COMPARISON', measure).memorize('P2');
			                c.get('COMPARISON', measure).memorize('CIL');
			                c.get('COMPARISON', measure).memorize('CIU');
			            end
			        end
			    end
			    
				braph2waitbar(wb, 'close')
			
				pr.get('UPDATE');
			end
			function cb_open_plots(~, ~)
			    c = pr.get('EL');
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			
			    gui_cp_dict = pr.memorize('GUI_CP_DICT');
			    
			    selected = pr.get('SELECTED');
				for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			
			        cp = c.get('COMPARISON', measure);
			        cp.get('C').get('A1').get('GRAPH_TEMPLATE').memorize('A');
			        
			        if ~gui_cp_dict.get('CONTAINS_KEY', measure)
			            gui = GUIElement( ...
			                'ID', measure, ... % this is the dictionary key
			                'PE', cp, ... % .get('PFC'), ...
			                'POSITION', [ ...
			                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ...
			                    y0(f, 'normalized') ...
			                    w(f, 'normalized') ...
			                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ...
			                    ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_cp_dict.get('ADD', gui)
			        end
			        
			        gui = gui_cp_dict.get('IT', measure);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			        gui_pfc = gui.get('PE').get('PR_DICT').get('IT', 'PFC').memorize('GUI_ITEM');
			        set(gui_pfc, 'TITLE', ['Comparison plot - ' g.get('MEASURE', measure).get('NAME')]);
			        if ~gui_pfc.get('DRAWN')
			            gui_pfc.get('DRAW')
			        end
			
			        gui_pfc.get('SHOW')
				
			    end
			end
			function cb_hide_plots(~, ~)
			    c = pr.get('EL');
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    gui_cp_dict = pr.memorize('GUI_CP_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			        
			        if gui_cp_dict.get('CONTAINS_KEY', measure)
			            gui = gui_cp_dict.get('IT', measure);
			            gui_pfc = gui.get('PE').get('PR_DICT').get('IT', 'PFC').memorize('GUI_ITEM');
			            if gui_pfc.get('DRAWN')
			                gui_pfc.get('HIDE')
			            end
			        end
			    end
			end
			function cb_open_elements(~, ~)
			    c = pr.get('EL');
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    g.memorize('A'); % memorizing A to get correct ALAYERLABELS
			    
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			
			    gui_cp_dict = pr.memorize('GUI_CP_DICT');
			    
			    selected = pr.get('SELECTED');
				for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			
			        cp = c.get('COMPARISON', measure);
			        
			        if ~gui_cp_dict.get('CONTAINS_KEY', measure)
			            gui = GUIElement( ...
			                'ID', measure, ... % this is the dictionary key
			                'PE', cp, ... 
			                'POSITION', [ ...
			                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
			                    y0(f, 'normalized') ... % y = f_gr_y / screen_h;
			                    w(f, 'normalized') ... % w = f_gr_w / screen_w;
			                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
			                    ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_cp_dict.get('ADD', gui)
			        end
			        
			        gui = gui_cp_dict.get('IT', measure);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			        gui.get('SHOW')
				end
			end
			function cb_hide_elements(~, ~)
			    c = pr.get('EL');
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    gui_m_dict = pr.memorize('GUI_CP_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			        
			        if gui_m_dict.get('CONTAINS_KEY', measure)
			            gui = gui_m_dict.get('IT', measure);
			            if gui.get('DRAWN')
			                gui.get('HIDE')
			            end
			        end
			    end
			end
			function cb_hide_brains(~, ~)
			    c = pr.get('EL');
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    gui_f_dict = pr.memorize('GUI_F_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			        
			        if gui_f_dict.get('CONTAINS_KEY', measure)
			            gui = gui_f_dict.get('IT', measure);
			            if gui.get('DRAWN')
			                gui.get('HIDE')
			            end
			        end
			    end
			end
			
			function cb_open_mbrain(~, ~)
			    c = pr.get('EL');
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    m_list = g.get('COMPATIBLE_MEASURES');
			
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			
			    gui_cp_dict = pr.memorize('GUI_CP_DICT');
			
			    selected = pr.get('SELECTED');
				for s = 1:1:length(selected)
			        i = selected(s);
			
			        measure = m_list{i}; % also key
			
			        cp = c.get('COMPARISON', measure);
			
			        if ~gui_cp_dict.get('CONTAINS_KEY', measure)
			            gui = GUIElement( ...
			                'ID', measure, ... % this is the dictionary key
			                'PE', cp, ... %.get('PFB'), ...
			                'POSITION', [ ...
			                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ...
			                    y0(f, 'normalized') ...
			                    w(f, 'normalized')...
			                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ...
			                    ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_cp_dict.get('ADD', gui)
			        end
			
			        gui = gui_cp_dict.get('IT', measure);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			        gui_pfbg = gui.get('PE').get('PR_DICT').get('IT', 'PFB').memorize('GUI_ITEM');
			        set(gui_pfbg, 'TITLE', ['Comparison brain plot - ' g.get('MEASURE', measure).get('NAME')]);
			        if ~gui_pfbg.get('DRAWN')
			            gui_pfbg.get('DRAW')
			        end
			
			        gui_pfbg.get('SHOW')
			    end    
			end
			
			function cb_hide_mbrain(~, ~)
			    c = pr.get('EL');
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    gui_cp_dict = pr.memorize('GUI_CP_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			        
			        if gui_cp_dict.get('CONTAINS_KEY', measure)
			            gui = gui_cp_dict.get('IT', measure);
			            gui_pfbg = gui.get('PE').get('PR_DICT').get('IT', 'PFB').memorize('GUI_ITEM');
			            if gui_pfbg.get('DRAWN')
			                gui_pfbg.get('HIDE')
			            end
			        end
			    end
			end
			function set_table()
			    c = pr.get('EL');
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			
			    m_list = g.get('COMPATIBLE_MEASURES');
			    cplist_already_calculated = cellfun(@(x) x.get('MEASURE'), c.get('CP_DICT').get('IT_LIST'), 'UniformOutput', false);
			
			    rowname = cell(length(m_list), 1);
			    data = cell(length(m_list), 5);
			    for mi = 1:1:length(m_list)
			        if any(cellfun(@(y) isequal(m_list{mi}, y), cplist_already_calculated)) && ~isa(c.get('COMPARISON', m_list{mi}).getr('DIFF'), 'NoValue')
			            rowname{mi} = 'C';
			        else
			            rowname{mi} = '';
			        end                
			
			        if any(pr.get('SELECTED') == mi)
			            data{mi, 1} = true;
			        else
			            data{mi, 1} = false;
			        end
			
			        data{mi, 2} = eval([m_list{mi} '.getPropDefault(''NAME'')']);
			
			        if Element.getPropDefault(m_list{mi}, 'SHAPE') == 2
			            data{mi, 3} = 'NODAL';
			        elseif Element.getPropDefault(m_list{mi}, 'SHAPE') == 1
			            data{mi, 3} = 'GLOBAL';
			        elseif Element.getPropDefault(m_list{mi}, 'SHAPE') == 3
			            data{mi, 3} = 'BINODAL';
			        end
			
			        if Element.getPropDefault(m_list{mi}, 'SCOPE') == 1
			            data{mi, 4} = 'SUPERGLOBAL';
			        elseif Element.getPropDefault(m_list{mi}, 'SCOPE') == 2
			            data{mi, 4} = 'UNILAYER';
			        elseif Element.getPropDefault(m_list{mi}, 'SCOPE') == 3
			            data{mi, 4} = 'BILAYER';
			        end
			        
			        data{mi, 5} = eval([m_list{mi} '.getPropDefault(''DESCRIPTION'')']);
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
