classdef NNxMLP_FeatureImportanceBrainSurfacePP_Measure < PanelProp
	%NNxMLP_FeatureImportanceBrainSurfacePP_Measure plots the panel to manage the feature importance of a neural network analysis with graph measures.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A panel for neural networks feature importance analysis with the graph measures of the subjects (NNxMLP_FeatureImportanceBrainSurfacePP_Measure) 
	%  plots the panel to show the feature importance values, matching the layer number and node number of the graph measures.
	%
	% The list of NNxMLP_FeatureImportanceBrainSurfacePP_Measure properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel for feature importance.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel for feature importance.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel for feature importance.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel for feature importance.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel for feature importance.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel for feature importance.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel for feature importance.
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
	%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the prop panel.
	%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the table.
	%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.
	%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
	%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the prop number.
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
	%  <strong>36</strong> <strong>D</strong> 	D (metadata, item) is the input dataset.
	%  <strong>37</strong> <strong>RESHAPED_PROP</strong> 	RESHAPED_PROP (data, scalar) is the prop number for the reshaped prop.
	%  <strong>38</strong> <strong>BA</strong> 	BA (parameter, item) is the brain atlas.
	%  <strong>39</strong> <strong>ENABLE</strong> 	ENABLE (gui, option) switches table between on and off.
	%  <strong>40</strong> <strong>ROWNAME</strong> 	ROWNAME (gui, stringlist) determines the table row names.
	%  <strong>41</strong> <strong>COLUMNNAME</strong> 	COLUMNNAME (gui, stringlist) determines the table column names.
	%  <strong>42</strong> <strong>MENU_EXPORT</strong> 	MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.
	%  <strong>43</strong> <strong>TABLE_HEIGHT</strong> 	TABLE_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.
	%  <strong>44</strong> <strong>SELECTED</strong> 	SELECTED (gui, cvector) is the list of selected items.
	%  <strong>45</strong> <strong>TABLE</strong> 	TABLE (evanescent, handle) is the table.
	%  <strong>46</strong> <strong>CONTEXTMENU</strong> 	CONTEXTMENU (evanescent, handle) is the context menu.
	%  <strong>47</strong> <strong>GUI_B_DICT</strong> 	GUI_B_DICT (gui, idict) contains the GUIs for the brain measures.
	%  <strong>48</strong> <strong>GUI_FI_DICT</strong> 	GUI_FI_DICT (gui, idict) contains the GUIs for the feature measures.
	%
	% NNxMLP_FeatureImportanceBrainSurfacePP_Measure methods (constructor):
	%  NNxMLP_FeatureImportanceBrainSurfacePP_Measure - constructor
	%
	% NNxMLP_FeatureImportanceBrainSurfacePP_Measure methods:
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
	% NNxMLP_FeatureImportanceBrainSurfacePP_Measure methods (display):
	%  tostring - string with information about the panel property feature importance
	%  disp - displays information about the panel property feature importance
	%  tree - displays the tree of the panel property feature importance
	%
	% NNxMLP_FeatureImportanceBrainSurfacePP_Measure methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel property feature importance are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel property feature importance
	%
	% NNxMLP_FeatureImportanceBrainSurfacePP_Measure methods (save/load, Static):
	%  save - saves BRAPH2 panel property feature importance as b2 file
	%  load - loads a BRAPH2 panel property feature importance from a b2 file
	%
	% NNxMLP_FeatureImportanceBrainSurfacePP_Measure method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel property feature importance
	%
	% NNxMLP_FeatureImportanceBrainSurfacePP_Measure method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel property feature importance
	%
	% NNxMLP_FeatureImportanceBrainSurfacePP_Measure methods (inspection, Static):
	%  getClass - returns the class of the panel property feature importance
	%  getSubclasses - returns all subclasses of NNxMLP_FeatureImportanceBrainSurfacePP_Measure
	%  getProps - returns the property list of the panel property feature importance
	%  getPropNumber - returns the property number of the panel property feature importance
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
	% NNxMLP_FeatureImportanceBrainSurfacePP_Measure methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNxMLP_FeatureImportanceBrainSurfacePP_Measure methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNxMLP_FeatureImportanceBrainSurfacePP_Measure methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNxMLP_FeatureImportanceBrainSurfacePP_Measure methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNxMLP_FeatureImportanceBrainSurfacePP_Measure; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNxMLP_FeatureImportanceBrainSurfacePP_Measure constants</a>.
	%
	%
	% See also NNxMLP_FeatureImportanceBrainSurface, NNxMLP_FeatureImportanceBrainSurfacePP_Graph, NNxMLP_FeatureImportanceBrainSurfacePP_Data.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		D = 36; %CET: Computational Efficiency Trick
		D_TAG = 'D';
		D_CATEGORY = 2;
		D_FORMAT = 8;
		
		RESHAPED_PROP = 37; %CET: Computational Efficiency Trick
		RESHAPED_PROP_TAG = 'RESHAPED_PROP';
		RESHAPED_PROP_CATEGORY = 4;
		RESHAPED_PROP_FORMAT = 11;
		
		BA = 38; %CET: Computational Efficiency Trick
		BA_TAG = 'BA';
		BA_CATEGORY = 3;
		BA_FORMAT = 8;
		
		ENABLE = 39; %CET: Computational Efficiency Trick
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = 9;
		ENABLE_FORMAT = 5;
		
		ROWNAME = 40; %CET: Computational Efficiency Trick
		ROWNAME_TAG = 'ROWNAME';
		ROWNAME_CATEGORY = 9;
		ROWNAME_FORMAT = 3;
		
		COLUMNNAME = 41; %CET: Computational Efficiency Trick
		COLUMNNAME_TAG = 'COLUMNNAME';
		COLUMNNAME_CATEGORY = 9;
		COLUMNNAME_FORMAT = 3;
		
		MENU_EXPORT = 42; %CET: Computational Efficiency Trick
		MENU_EXPORT_TAG = 'MENU_EXPORT';
		MENU_EXPORT_CATEGORY = 9;
		MENU_EXPORT_FORMAT = 4;
		
		TABLE_HEIGHT = 43; %CET: Computational Efficiency Trick
		TABLE_HEIGHT_TAG = 'TABLE_HEIGHT';
		TABLE_HEIGHT_CATEGORY = 9;
		TABLE_HEIGHT_FORMAT = 22;
		
		SELECTED = 44; %CET: Computational Efficiency Trick
		SELECTED_TAG = 'SELECTED';
		SELECTED_CATEGORY = 9;
		SELECTED_FORMAT = 13;
		
		TABLE = 45; %CET: Computational Efficiency Trick
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = 7;
		TABLE_FORMAT = 18;
		
		CONTEXTMENU = 46; %CET: Computational Efficiency Trick
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = 7;
		CONTEXTMENU_FORMAT = 18;
		
		GUI_B_DICT = 47; %CET: Computational Efficiency Trick
		GUI_B_DICT_TAG = 'GUI_B_DICT';
		GUI_B_DICT_CATEGORY = 9;
		GUI_B_DICT_FORMAT = 10;
		
		GUI_FI_DICT = 48; %CET: Computational Efficiency Trick
		GUI_FI_DICT_TAG = 'GUI_FI_DICT';
		GUI_FI_DICT_CATEGORY = 9;
		GUI_FI_DICT_FORMAT = 10;
	end
	methods % constructor
		function pr = NNxMLP_FeatureImportanceBrainSurfacePP_Measure(varargin)
			%NNxMLP_FeatureImportanceBrainSurfacePP_Measure() creates a panel property feature importance.
			%
			% NNxMLP_FeatureImportanceBrainSurfacePP_Measure(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNxMLP_FeatureImportanceBrainSurfacePP_Measure(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNxMLP_FeatureImportanceBrainSurfacePP_Measure properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel for feature importance.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel for feature importance.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel for feature importance.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel for feature importance.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel for feature importance.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel for feature importance.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel for feature importance.
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
			%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the prop panel.
			%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the table.
			%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.
			%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
			%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the prop number.
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
			%  <strong>36</strong> <strong>D</strong> 	D (metadata, item) is the input dataset.
			%  <strong>37</strong> <strong>RESHAPED_PROP</strong> 	RESHAPED_PROP (data, scalar) is the prop number for the reshaped prop.
			%  <strong>38</strong> <strong>BA</strong> 	BA (parameter, item) is the brain atlas.
			%  <strong>39</strong> <strong>ENABLE</strong> 	ENABLE (gui, option) switches table between on and off.
			%  <strong>40</strong> <strong>ROWNAME</strong> 	ROWNAME (gui, stringlist) determines the table row names.
			%  <strong>41</strong> <strong>COLUMNNAME</strong> 	COLUMNNAME (gui, stringlist) determines the table column names.
			%  <strong>42</strong> <strong>MENU_EXPORT</strong> 	MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.
			%  <strong>43</strong> <strong>TABLE_HEIGHT</strong> 	TABLE_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.
			%  <strong>44</strong> <strong>SELECTED</strong> 	SELECTED (gui, cvector) is the list of selected items.
			%  <strong>45</strong> <strong>TABLE</strong> 	TABLE (evanescent, handle) is the table.
			%  <strong>46</strong> <strong>CONTEXTMENU</strong> 	CONTEXTMENU (evanescent, handle) is the context menu.
			%  <strong>47</strong> <strong>GUI_B_DICT</strong> 	GUI_B_DICT (gui, idict) contains the GUIs for the brain measures.
			%  <strong>48</strong> <strong>GUI_FI_DICT</strong> 	GUI_FI_DICT (gui, idict) contains the GUIs for the feature measures.
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the panel property feature importance.
			%
			% BUILD = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GETBUILD() returns the build of 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the panel property feature importance PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('NNxMLP_FeatureImportanceBrainSurfacePP_Measure') returns the build of 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('NNxMLP_FeatureImportanceBrainSurfacePP_Measure')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the panel property feature importance.
			%
			% CLASS = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GETCLASS() returns the class 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the panel property feature importance PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('NNxMLP_FeatureImportanceBrainSurfacePP_Measure') returns 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('NNxMLP_FeatureImportanceBrainSurfacePP_Measure')
			%  are less computationally efficient.
			
			pr_class = 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel property feature importance.
			%
			% LIST = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GETSUBCLASSES() returns all subclasses of 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the panel property feature importance PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('NNxMLP_FeatureImportanceBrainSurfacePP_Measure') returns all subclasses of 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('NNxMLP_FeatureImportanceBrainSurfacePP_Measure')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel property feature importance.
			%
			% PROPS = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GETPROPS() returns the property list of panel property feature importance
			%  as a row vector.
			%
			% PROPS = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the panel property feature importance PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('NNxMLP_FeatureImportanceBrainSurfacePP_Measure'[, CATEGORY]) returns the property list of 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('NNxMLP_FeatureImportanceBrainSurfacePP_Measure')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 36];
				case 3 % Category.PARAMETER
					prop_list = [4 38];
				case 4 % Category.DATA
					prop_list = [5 23 24 29 37];
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 20 21 22];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 27 28 30 31 32 33 34 35 45 46];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 39 40 41 42 43 44 47 48];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel property feature importance.
			%
			% N = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GETPROPNUMBER() returns the property number of panel property feature importance.
			%
			% N = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GETPROPNUMBER(CATEGORY) returns the property number of panel property feature importance
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the panel property feature importance PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('NNxMLP_FeatureImportanceBrainSurfacePP_Measure') returns the property number of 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('NNxMLP_FeatureImportanceBrainSurfacePP_Measure')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 48;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 2;
				case 4 % Category.DATA
					prop_number = 5;
				case 6 % Category.QUERY
					prop_number = 10;
				case 7 % Category.EVANESCENT
					prop_number = 12;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 12;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel property feature importance/error.
			%
			% CHECK = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, PROP) checks whether PROP exists for NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePP_Measure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePP_Measure:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePP_Measure:WrongInput]
			%  Element.EXISTSPROP(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, PROP) throws error if PROP does NOT exist for NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePP_Measure:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('NNxMLP_FeatureImportanceBrainSurfacePP_Measure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 48 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurfacePP_Measure:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurfacePP_Measure:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNxMLP_FeatureImportanceBrainSurfacePP_Measure.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel property feature importance/error.
			%
			% CHECK = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, TAG) checks whether TAG exists for NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePP_Measure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePP_Measure:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePP_Measure:WrongInput]
			%  Element.EXISTSTAG(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, TAG) throws error if TAG does NOT exist for NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePP_Measure:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('NNxMLP_FeatureImportanceBrainSurfacePP_Measure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'D'  'RESHAPED_PROP'  'BA'  'ENABLE'  'ROWNAME'  'COLUMNNAME'  'MENU_EXPORT'  'TABLE_HEIGHT'  'SELECTED'  'TABLE'  'CONTEXTMENU'  'GUI_B_DICT'  'GUI_FI_DICT' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurfacePP_Measure:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurfacePP_Measure:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNxMLP_FeatureImportanceBrainSurfacePP_Measure.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%  PROPERTY = PR.GETPROPPROP(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('NNxMLP_FeatureImportanceBrainSurfacePP_Measure')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'D'  'RESHAPED_PROP'  'BA'  'ENABLE'  'ROWNAME'  'COLUMNNAME'  'MENU_EXPORT'  'TABLE_HEIGHT'  'SELECTED'  'TABLE'  'CONTEXTMENU'  'GUI_B_DICT'  'GUI_FI_DICT' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%  TAG = PR.GETPROPTAG(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('NNxMLP_FeatureImportanceBrainSurfacePP_Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnxmlp_featureimportancebrainsurfacepp_measure_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'D'  'RESHAPED_PROP'  'BA'  'ENABLE'  'ROWNAME'  'COLUMNNAME'  'MENU_EXPORT'  'TABLE_HEIGHT'  'SELECTED'  'TABLE'  'CONTEXTMENU'  'GUI_B_DICT'  'GUI_FI_DICT' };
				tag = nnxmlp_featureimportancebrainsurfacepp_measure_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%  CATEGORY = PR.GETPROPCATEGORY(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('NNxMLP_FeatureImportanceBrainSurfacePP_Measure')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportancebrainsurfacepp_measure_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  2  4  3  9  9  9  9  9  9  7  7  9  9 };
			prop_category = nnxmlp_featureimportancebrainsurfacepp_measure_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%  FORMAT = PR.GETPROPFORMAT(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('NNxMLP_FeatureImportanceBrainSurfacePP_Measure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportancebrainsurfacepp_measure_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  8  11  8  5  3  3  4  22  13  18  18  10  10 };
			prop_format = nnxmlp_featureimportancebrainsurfacepp_measure_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('NNxMLP_FeatureImportanceBrainSurfacePP_Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportancebrainsurfacepp_measure_description_list = { 'ELCLASS (constant, string) is the class of the panel for feature importance.'  'NAME (constant, string) is the name of the panel for feature importance.'  'DESCRIPTION (constant, string) is the description of the panel for feature importance.'  'TEMPLATE (parameter, item) is the template of the panel for feature importance.'  'ID (data, string) is a few-letter code for the panel for feature importance.'  'LABEL (metadata, string) is an extended label of the panel for feature importance.'  'NOTES (metadata, string) are some specific notes about the panel for feature importance.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.'  'X_DRAW (query, logical) draws the prop panel.'  'UPDATE (query, logical) updates the content and permissions of the table.'  'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the prop number.'  'HEIGHT (gui, size) is the pixel height of the prop panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'D (metadata, item) is the input dataset.'  'RESHAPED_PROP (data, scalar) is the prop number for the reshaped prop.'  'BA (parameter, item) is the brain atlas.'  'ENABLE (gui, option) switches table between on and off.'  'ROWNAME (gui, stringlist) determines the table row names.'  'COLUMNNAME (gui, stringlist) determines the table column names.'  'MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.'  'TABLE_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.'  'SELECTED (gui, cvector) is the list of selected items.'  'TABLE (evanescent, handle) is the table.'  'CONTEXTMENU (evanescent, handle) is the context menu.'  'GUI_B_DICT (gui, idict) contains the GUIs for the brain measures.'  'GUI_FI_DICT (gui, idict) contains the GUIs for the feature measures.' };
			prop_description = nnxmlp_featureimportancebrainsurfacepp_measure_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%  SETTINGS = PR.GETPROPSETTINGS(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('NNxMLP_FeatureImportanceBrainSurfacePP_Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.D
					prop_settings = Format.getFormatSettings(8);
				case 37 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.RESHAPED_PROP
					prop_settings = Format.getFormatSettings(11);
				case 38 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.BA
					prop_settings = 'BrainAtlas';
				case 39 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.ENABLE
					prop_settings = {'on', 'off'};
				case 40 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.ROWNAME
					prop_settings = Format.getFormatSettings(3);
				case 41 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.COLUMNNAME
					prop_settings = Format.getFormatSettings(3);
				case 42 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.MENU_EXPORT
					prop_settings = Format.getFormatSettings(4);
				case 43 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(22);
				case 44 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.SELECTED
					prop_settings = Format.getFormatSettings(13);
				case 45 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.TABLE
					prop_settings = Format.getFormatSettings(18);
				case 46 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.CONTEXTMENU
					prop_settings = Format.getFormatSettings(18);
				case 47 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GUI_B_DICT
					prop_settings = 'GUIFig';
				case 48 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GUI_FI_DICT
					prop_settings = 'GUIElement';
				case 4 % NNxMLP_FeatureImportanceBrainSurfacePP_4
					prop_settings = 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%  DEFAULT = PR.GETPROPDEFAULT(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('NNxMLP_FeatureImportanceBrainSurfacePP_Measure')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.D
					prop_default = NNDataset();
				case 37 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.RESHAPED_PROP
					prop_default = 25;
				case 38 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.BA
					prop_default = Format.getFormatDefault(8, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 39 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.ENABLE
					prop_default = 'on';
				case 40 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.ROWNAME
					prop_default = {'numbered'};
				case 41 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.COLUMNNAME
					prop_default = {'numbered'};
				case 42 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.MENU_EXPORT
					prop_default = true;
				case 43 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.TABLE_HEIGHT
					prop_default = 240;
				case 44 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.SELECTED
					prop_default = Format.getFormatDefault(13, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 45 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.TABLE
					prop_default = Format.getFormatDefault(18, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 46 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.CONTEXTMENU
					prop_default = Format.getFormatDefault(18, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 47 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GUI_B_DICT
					prop_default = Format.getFormatDefault(10, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 48 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GUI_FI_DICT
					prop_default = Format.getFormatDefault(10, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 1 % NNxMLP_FeatureImportanceBrainSurfacePP_1
					prop_default = 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure';
				case 2 % NNxMLP_FeatureImportanceBrainSurfacePP_2
					prop_default = 'A Panel for Neural Networks Feature Importance';
				case 3 % NNxMLP_FeatureImportanceBrainSurfacePP_3
					prop_default = 'A panel for neural networks feature importance analysis with the graph measures of the subjects (NNxMLP_FeatureImportanceBrainSurfacePP_Measure) plots the panel to show the feature importance values, matching the layer number and node number of the graph measures.';
				case 4 % NNxMLP_FeatureImportanceBrainSurfacePP_4
					prop_default = Format.getFormatDefault(8, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 5 % NNxMLP_FeatureImportanceBrainSurfacePP_5
					prop_default = 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure ID';
				case 6 % NNxMLP_FeatureImportanceBrainSurfacePP_6
					prop_default = 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure label';
				case 7 % NNxMLP_FeatureImportanceBrainSurfacePP_7
					prop_default = 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure notes';
				case 23 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.EL
					prop_default = NNxMLP_FeatureImportanceBrainSurface();
				case 24 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.PROP
					prop_default = 24;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('NNxMLP_FeatureImportanceBrainSurfacePP_Measure')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropProp(pointer);
			
			prop_default = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.conditioning(prop, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropDefault(prop));
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
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropProp(pointer);
			
			switch prop
				case 44 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.SELECTED
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
			%  CHECK = Element.CHECKPROP(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%  CHECK = PR.CHECKPROP(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePP_Measure:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePP_Measure:WrongInput
			%  Element.CHECKPROP(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%   Error id: BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePP_Measure:WrongInput
			%  PR.CHECKPROP(NNxMLP_FeatureImportanceBrainSurfacePP_Measure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceBrainSurfacePP_Measure.
			%   Error id: BRAPH2:NNxMLP_FeatureImportanceBrainSurfacePP_Measure:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('NNxMLP_FeatureImportanceBrainSurfacePP_Measure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropProp(pointer);
			
			switch prop
				case 36 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.D
					check = Format.checkFormat(8, value, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 37 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.RESHAPED_PROP
					check = Format.checkFormat(11, value, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 38 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.BA
					check = Format.checkFormat(8, value, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 39 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.ENABLE
					check = Format.checkFormat(5, value, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 40 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.ROWNAME
					check = Format.checkFormat(3, value, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 41 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.COLUMNNAME
					check = Format.checkFormat(3, value, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 42 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.MENU_EXPORT
					check = Format.checkFormat(4, value, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 43 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.TABLE_HEIGHT
					check = Format.checkFormat(22, value, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 44 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.SELECTED
					check = Format.checkFormat(13, value, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 45 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.TABLE
					check = Format.checkFormat(18, value, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 46 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.CONTEXTMENU
					check = Format.checkFormat(18, value, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 47 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GUI_B_DICT
					check = Format.checkFormat(10, value, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 48 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.GUI_FI_DICT
					check = Format.checkFormat(10, value, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				case 4 % NNxMLP_FeatureImportanceBrainSurfacePP_4
					check = Format.checkFormat(8, value, NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurfacePP_Measure:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurfacePP_Measure:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropTag(prop) ' (' NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getFormatTag(NNxMLP_FeatureImportanceBrainSurfacePP_Measure.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pr, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case 40 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.ROWNAME
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				case 41 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.COLUMNNAME
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				otherwise
					if prop <= 35
						postset@PanelProp(pr, prop);
					end
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
				case 45 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.TABLE
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
					
				case 46 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.CONTEXTMENU
					contextmenu = uicontextmenu( ...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_select_all = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_SELECT_ALL', ...
					    'Text', 'Select All Measures', ...
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
					menu_open_mbrain = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_OPEN_MBRAIN', ...
					    'Text', 'Plot Selected Measures on Brain ...', ...
					    'MenuSelectedFcn', {@cb_open_mbrain} ...
					    );
					menu_hide_mbrain = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_MBRAIN', ...
					    'Text', 'Hide Selected Brain-Plots', ...
						'MenuSelectedFcn', {@cb_hide_mbrain} ...
					    );
					menu_open_elements = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_OPEN_ELEMENTS', ...
					    'Text', 'Data Selected Measures ...', ...
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
					
				case 20 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					end
					
				case 21 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.UPDATE
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
					
				case 22 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [4 4 w_p-8 max(1, pr.get('HEIGHT')-27)])
					end
					
				case 16 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.SHOW
					value = calculateValue@PanelProp(pr, 16, varargin{:}); % also warning
					if value
					    % figures for brain figure
					    gui_b_dict = pr.get('GUI_B_DICT');
					    for i = 1:1:gui_b_dict.get('LENGTH')
					        gui = gui_b_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					    % element for feature importance
					    gui_fi_dict = pr.get('GUI_FI_DICT');
					    for i = 1:1:gui_fi_dict.get('LENGTH')
					        gui = gui_fi_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					end
					
				case 17 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.HIDE
					value = calculateValue@PanelProp(pr, 17, varargin{:}); % also warning
					if value
					    % figures for brain figures
					    gui_b_dict = pr.get('GUI_B_DICT');
					    for i = 1:1:gui_b_dict.get('LENGTH')
					        gui = gui_b_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					    % element for feature importance
					    gui_fi_dict = pr.get('GUI_FI_DICT');
					    for i = 1:1:gui_fi_dict.get('LENGTH')
					        gui = gui_fi_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					end
					
				case 18 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					end
					
				case 19 % NNxMLP_FeatureImportanceBrainSurfacePP_Measure.CLOSE
					value = calculateValue@PanelProp(pr, 19, varargin{:}); % also warning
					if value
					    % figures for brain figures
					    gui_b_dict = pr.get('GUI_B_DICT');
					    for i = 1:1:gui_b_dict.get('LENGTH')
					        gui = gui_b_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('CLOSE')
					        end
					    end
					    % element for feature importance
					    gui_fi_dict = pr.get('GUI_FI_DICT');
					    for i = 1:1:gui_fi_dict.get('LENGTH')
					        gui = gui_fi_dict.get('IT', i);
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
			    input_dataset = pr.get('D');
			    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
			
			    pr.set('SELECTED', [1:1:length(m_list)])
			
			    pr.get('UPDATE')
			end
			function cb_clear_selection(~, ~) 
			    pr.set('SELECTED', [])
			
			    pr.get('UPDATE')
			end
			function cb_invert_selection(~, ~) 
			    input_dataset = pr.get('D');
			    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
			
			    selected_tmp = [1:1:length(m_list)];
			    selected_tmp(pr.get('SELECTED')) = [];
			    pr.set('SELECTED', selected_tmp);
			
			    pr.get('UPDATE')
			end
			function cb_open_mbrain(~, ~)
			    input_dataset = pr.get('D');
			    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
			
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			
			    gui_b_dict = pr.memorize('GUI_B_DICT');
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			
			        measure = m_list{i}; % also key
			        el = pr.get('EL');
			        reshaped_prop = pr.get('RESHAPED_PROP');
			        values = el.get(reshaped_prop);
			        value = values{i};
			
			        if ~gui_b_dict.get('CONTAINS_KEY', measure)
			
			            brain_atlas = el.get('BA'); 
			            switch Element.getPropDefault(measure, 'SHAPE')
			                case 1 % Measure.GLOBAL
			                    switch Element.getPropDefault(measure, 'SCOPE')
			                        case 1 % Measure.SUPERGLOBAL
			                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_GS('FI', value, 'BA', brain_atlas, 'D', input_dataset);
			                        case 2 % Measure.UNILAYER
			                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_GU('FI', value, 'BA', brain_atlas, 'D', input_dataset);
			                        case 3 % Measure.BILAYER
			                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_GB('FI', value, 'BA', brain_atlas, 'D', input_dataset);
			                    end
			                case 2 % Measure.NODAL
			                    switch Element.getPropDefault(measure, 'SCOPE')
			                        case 1 % Measure.SUPERGLOBAL
			                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_NS('FI', value, 'BA', brain_atlas, 'D', input_dataset);
			                        case 2 % Measure.UNILAYER
			                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_NU('FI', value, 'BA', brain_atlas, 'D', input_dataset);
			                        case 3 % Measure.BILAYER
			                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_NB('FI', value, 'BA', brain_atlas, 'D', input_dataset);
			                    end
			                case 3 % Measure.BINODAL
			                    switch Element.getPropDefault(measure, 'SCOPE')
			                        case 1 % Measure.SUPERGLOBAL
			                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_BS('FI', value, 'BA', brain_atlas, 'D', input_dataset);
			                        case 2 % Measure.UNILAYER
			                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_BU('FI', value, 'BA', brain_atlas, 'D', input_dataset);
			                        case 3 % Measure.BILAYER
			                            mbfipf = NNxMLP_FeatureImportanceBrainSurfacePF_BB('FI', value, 'BA', brain_atlas, 'D', input_dataset);
			                    end
			            end
			
			            gui = GUIFig( ...
			                'ID', measure, ... % this is the dictionary key
			                'PF', mbfipf, ...
			                'POSITION', [ ...
			                x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ...
			                y0(f, 'normalized') ...
			                w(f, 'normalized') * 3 ...
			                .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ...
			                ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_b_dict.get('ADD', gui)
			        end
			
			        gui = gui_b_dict.get('IT', measure);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			        gui.get('SHOW')
			    end
			end
			function cb_hide_mbrain(~, ~)
			    input_dataset = pr.get('D');
			    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
			
			    gui_b_dict = pr.memorize('GUI_B_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			
			        measure = m_list{i}; % also key
			
			        if gui_b_dict.get('CONTAINS_KEY', measure)
			            gui = gui_b_dict.get('IT', measure);
			            if gui.get('DRAWN')
			                gui.get('HIDE')
			            end
			        end
			    end
			end
			function cb_open_elements(~, ~)
			    input_dataset = pr.get('D');
			    g = input_dataset.get('DP_DICT').get('IT', 1).get('G');
			    g.memorize('A'); % memorizing A to get correct ALAYERLABELS
			
			    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			
			    gui_fi_dict = pr.memorize('GUI_FI_DICT');
			    
			    selected = pr.get('SELECTED');
				for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			        m_template = g.get('M_DICT').get('IT', measure).get('TEMPLATE');
			        
			        el = pr.get('EL');
			        reshaped_prop = pr.get('RESHAPED_PROP');
			        values = el.get(reshaped_prop);
			        value = values{i};
			        
			        fim = NNFeatureImportanceMeasure('G', g, 'M', m_template, 'FI', value);
			        
			        if ~gui_fi_dict.get('CONTAINS_KEY', measure)
			            gui = GUIElement( ...
			                'ID', measure, ... % this is the dictionary key
			                'PE', fim, ... 
			                'POSITION', [ ...
			                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
			                    y0(f, 'normalized') ... % y = f_gr_y / screen_h;
			                    w(f, 'normalized') ... % w = f_gr_w / screen_w;
			                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
			                    ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_fi_dict.get('ADD', gui)
			        end
			        
			        gui = gui_fi_dict.get('IT', measure);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			        gui.get('SHOW')
				end
			end
			function cb_hide_elements(~, ~)
			    input_dataset = pr.get('D');
			    g = input_dataset.get('DP_DICT').get('IT', 1).get('G');
			    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
			
			    gui_fi_dict = pr.memorize('GUI_FI_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			        
			        if gui_fi_dict.get('CONTAINS_KEY', measure)
			            gui = gui_fi_dict.get('IT', measure);
			            if gui.get('DRAWN')
			                gui.get('HIDE')
			            end
			        end
			    end
			end
			function set_table()
			
			    input_dataset = pr.get('D');
			    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
			    
			    rowname = cell(length(m_list), 1);
			    data = cell(length(m_list), 5);
			    for mi = 1:1:length(m_list)
			
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
end
