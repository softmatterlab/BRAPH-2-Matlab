classdef NNClassifierMLP_EvaluatorPF_ROC < PanelFig
	%NNClassifierMLP_EvaluatorPF_ROC plots a panel of receiver operating characteristic curves.
	% It is a subclass of <a href="matlab:help PanelFig">PanelFig</a>.
	%
	% The receiver operating characteristic panel for an evaluator of MLP classifier 
	%  (NNClassifierMLP_EvaluatorPF_ROC) manages the functionalities to plot 
	%  a panel of the receiver operating characteristic curves.
	%
	% The list of NNClassifierMLP_EvaluatorPF_ROC properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel of the ensemble-based comparison.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel ensemble-based comparison figure.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel ensemble-based comparison figure.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel ensemble-based comparison figure.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel ensemble-based comparison figure.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel ensemble-based comparison figure.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel ensemble-based comparison figure.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the receiver operating characteristic figure.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel figure graph is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel.
	%  <strong>20</strong> <strong>ST_POSITION</strong> 	ST_POSITION (figure, item) determines the panel position.
	%  <strong>21</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.
	%  <strong>22</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
	%  <strong>23</strong> <strong>H_AXES</strong> 	H_AXES (evanescent, handle) is the handle for the axes.
	%  <strong>24</strong> <strong>ST_AXIS</strong> 	ST_AXIS (figure, item) determines the axis settings.
	%  <strong>25</strong> <strong>LISTENER_ST_AXIS</strong> 	LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.
	%  <strong>26</strong> <strong>NNE</strong> 	NNE (metadata, item) is the neural network evaluator.
	%  <strong>27</strong> <strong>CLASSNAMES</strong> 	CLASSNAMES (metadata, stringlist) is the class names.
	%  <strong>28</strong> <strong>X_VALUES</strong> 	X_VALUES (metadata, matrix) gets the x values for receiver operating characteristic curves.
	%  <strong>29</strong> <strong>Y_VALUES</strong> 	Y_VALUES (metadata, matrix) gets the y values for receiver operating characteristic curves.
	%  <strong>30</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the the receiver operating characteristic values and initializes the receiver operating characteristic figure.
	%  <strong>31</strong> <strong>H_ROC</strong> 	H_ROC (evanescent, handlelist) is the set of handles for the ROC plots.
	%  <strong>32</strong> <strong>ROC</strong> 	ROC (figure, logical) determines whether the ROC plots are shown.
	%  <strong>33</strong> <strong>ROC_DICT</strong> 	ROC_DICT (figure, idict) contains the ROC plot for each class.
	%  <strong>34</strong> <strong>H_TITLE</strong> 	H_TITLE (evanescent, handle) is the axis title.
	%  <strong>35</strong> <strong>ST_TITLE</strong> 	ST_TITLE (figure, item) determines the title settings.
	%  <strong>36</strong> <strong>H_XLABEL</strong> 	H_XLABEL (evanescent, handle) is the axis x-label.
	%  <strong>37</strong> <strong>ST_XLABEL</strong> 	ST_XLABEL (figure, item) determines the x-label settings.
	%  <strong>38</strong> <strong>H_YLABEL</strong> 	H_YLABEL (evanescent, handle) is the axis y-label.
	%  <strong>39</strong> <strong>ST_YLABEL</strong> 	ST_YLABEL (figure, item) determines the y-label settings.
	%
	% NNClassifierMLP_EvaluatorPF_ROC methods (constructor):
	%  NNClassifierMLP_EvaluatorPF_ROC - constructor
	%
	% NNClassifierMLP_EvaluatorPF_ROC methods:
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
	% NNClassifierMLP_EvaluatorPF_ROC methods (display):
	%  tostring - string with information about the panel receiver operating characteristic figure
	%  disp - displays information about the panel receiver operating characteristic figure
	%  tree - displays the tree of the panel receiver operating characteristic figure
	%
	% NNClassifierMLP_EvaluatorPF_ROC methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel receiver operating characteristic figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel receiver operating characteristic figure
	%
	% NNClassifierMLP_EvaluatorPF_ROC methods (save/load, Static):
	%  save - saves BRAPH2 panel receiver operating characteristic figure as b2 file
	%  load - loads a BRAPH2 panel receiver operating characteristic figure from a b2 file
	%
	% NNClassifierMLP_EvaluatorPF_ROC method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel receiver operating characteristic figure
	%
	% NNClassifierMLP_EvaluatorPF_ROC method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel receiver operating characteristic figure
	%
	% NNClassifierMLP_EvaluatorPF_ROC methods (inspection, Static):
	%  getClass - returns the class of the panel receiver operating characteristic figure
	%  getSubclasses - returns all subclasses of NNClassifierMLP_EvaluatorPF_ROC
	%  getProps - returns the property list of the panel receiver operating characteristic figure
	%  getPropNumber - returns the property number of the panel receiver operating characteristic figure
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
	% NNClassifierMLP_EvaluatorPF_ROC methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNClassifierMLP_EvaluatorPF_ROC methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNClassifierMLP_EvaluatorPF_ROC methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNClassifierMLP_EvaluatorPF_ROC methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNClassifierMLP_EvaluatorPF_ROC; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNClassifierMLP_EvaluatorPF_ROC constants</a>.
	%
	%
	% See also NNClassifierMLP_Evaluator.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		H_AXES = 23; %CET: Computational Efficiency Trick
		H_AXES_TAG = 'H_AXES';
		H_AXES_CATEGORY = 7;
		H_AXES_FORMAT = 18;
		
		ST_AXIS = 24; %CET: Computational Efficiency Trick
		ST_AXIS_TAG = 'ST_AXIS';
		ST_AXIS_CATEGORY = 8;
		ST_AXIS_FORMAT = 8;
		
		LISTENER_ST_AXIS = 25; %CET: Computational Efficiency Trick
		LISTENER_ST_AXIS_TAG = 'LISTENER_ST_AXIS';
		LISTENER_ST_AXIS_CATEGORY = 7;
		LISTENER_ST_AXIS_FORMAT = 18;
		
		NNE = 26; %CET: Computational Efficiency Trick
		NNE_TAG = 'NNE';
		NNE_CATEGORY = 2;
		NNE_FORMAT = 8;
		
		CLASSNAMES = 27; %CET: Computational Efficiency Trick
		CLASSNAMES_TAG = 'CLASSNAMES';
		CLASSNAMES_CATEGORY = 2;
		CLASSNAMES_FORMAT = 3;
		
		X_VALUES = 28; %CET: Computational Efficiency Trick
		X_VALUES_TAG = 'X_VALUES';
		X_VALUES_CATEGORY = 2;
		X_VALUES_FORMAT = 14;
		
		Y_VALUES = 29; %CET: Computational Efficiency Trick
		Y_VALUES_TAG = 'Y_VALUES';
		Y_VALUES_CATEGORY = 2;
		Y_VALUES_FORMAT = 14;
		
		SETUP = 30; %CET: Computational Efficiency Trick
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = 6;
		SETUP_FORMAT = 1;
		
		H_ROC = 31; %CET: Computational Efficiency Trick
		H_ROC_TAG = 'H_ROC';
		H_ROC_CATEGORY = 7;
		H_ROC_FORMAT = 19;
		
		ROC = 32; %CET: Computational Efficiency Trick
		ROC_TAG = 'ROC';
		ROC_CATEGORY = 8;
		ROC_FORMAT = 4;
		
		ROC_DICT = 33; %CET: Computational Efficiency Trick
		ROC_DICT_TAG = 'ROC_DICT';
		ROC_DICT_CATEGORY = 8;
		ROC_DICT_FORMAT = 10;
		
		H_TITLE = 34; %CET: Computational Efficiency Trick
		H_TITLE_TAG = 'H_TITLE';
		H_TITLE_CATEGORY = 7;
		H_TITLE_FORMAT = 18;
		
		ST_TITLE = 35; %CET: Computational Efficiency Trick
		ST_TITLE_TAG = 'ST_TITLE';
		ST_TITLE_CATEGORY = 8;
		ST_TITLE_FORMAT = 8;
		
		H_XLABEL = 36; %CET: Computational Efficiency Trick
		H_XLABEL_TAG = 'H_XLABEL';
		H_XLABEL_CATEGORY = 7;
		H_XLABEL_FORMAT = 18;
		
		ST_XLABEL = 37; %CET: Computational Efficiency Trick
		ST_XLABEL_TAG = 'ST_XLABEL';
		ST_XLABEL_CATEGORY = 8;
		ST_XLABEL_FORMAT = 8;
		
		H_YLABEL = 38; %CET: Computational Efficiency Trick
		H_YLABEL_TAG = 'H_YLABEL';
		H_YLABEL_CATEGORY = 7;
		H_YLABEL_FORMAT = 18;
		
		ST_YLABEL = 39; %CET: Computational Efficiency Trick
		ST_YLABEL_TAG = 'ST_YLABEL';
		ST_YLABEL_CATEGORY = 8;
		ST_YLABEL_FORMAT = 8;
	end
	methods % constructor
		function pf = NNClassifierMLP_EvaluatorPF_ROC(varargin)
			%NNClassifierMLP_EvaluatorPF_ROC() creates a panel receiver operating characteristic figure.
			%
			% NNClassifierMLP_EvaluatorPF_ROC(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNClassifierMLP_EvaluatorPF_ROC(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNClassifierMLP_EvaluatorPF_ROC properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel of the ensemble-based comparison.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel ensemble-based comparison figure.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel ensemble-based comparison figure.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel ensemble-based comparison figure.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel ensemble-based comparison figure.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel ensemble-based comparison figure.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel ensemble-based comparison figure.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the receiver operating characteristic figure.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel figure graph is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel.
			%  <strong>20</strong> <strong>ST_POSITION</strong> 	ST_POSITION (figure, item) determines the panel position.
			%  <strong>21</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.
			%  <strong>22</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
			%  <strong>23</strong> <strong>H_AXES</strong> 	H_AXES (evanescent, handle) is the handle for the axes.
			%  <strong>24</strong> <strong>ST_AXIS</strong> 	ST_AXIS (figure, item) determines the axis settings.
			%  <strong>25</strong> <strong>LISTENER_ST_AXIS</strong> 	LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.
			%  <strong>26</strong> <strong>NNE</strong> 	NNE (metadata, item) is the neural network evaluator.
			%  <strong>27</strong> <strong>CLASSNAMES</strong> 	CLASSNAMES (metadata, stringlist) is the class names.
			%  <strong>28</strong> <strong>X_VALUES</strong> 	X_VALUES (metadata, matrix) gets the x values for receiver operating characteristic curves.
			%  <strong>29</strong> <strong>Y_VALUES</strong> 	Y_VALUES (metadata, matrix) gets the y values for receiver operating characteristic curves.
			%  <strong>30</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the the receiver operating characteristic values and initializes the receiver operating characteristic figure.
			%  <strong>31</strong> <strong>H_ROC</strong> 	H_ROC (evanescent, handlelist) is the set of handles for the ROC plots.
			%  <strong>32</strong> <strong>ROC</strong> 	ROC (figure, logical) determines whether the ROC plots are shown.
			%  <strong>33</strong> <strong>ROC_DICT</strong> 	ROC_DICT (figure, idict) contains the ROC plot for each class.
			%  <strong>34</strong> <strong>H_TITLE</strong> 	H_TITLE (evanescent, handle) is the axis title.
			%  <strong>35</strong> <strong>ST_TITLE</strong> 	ST_TITLE (figure, item) determines the title settings.
			%  <strong>36</strong> <strong>H_XLABEL</strong> 	H_XLABEL (evanescent, handle) is the axis x-label.
			%  <strong>37</strong> <strong>ST_XLABEL</strong> 	ST_XLABEL (figure, item) determines the x-label settings.
			%  <strong>38</strong> <strong>H_YLABEL</strong> 	H_YLABEL (evanescent, handle) is the axis y-label.
			%  <strong>39</strong> <strong>ST_YLABEL</strong> 	ST_YLABEL (figure, item) determines the y-label settings.
			%
			% See also Category, Format.
			
			pf = pf@PanelFig(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the panel receiver operating characteristic figure.
			%
			% BUILD = NNClassifierMLP_EvaluatorPF_ROC.GETBUILD() returns the build of 'NNClassifierMLP_EvaluatorPF_ROC'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PF.GETBUILD() returns the build of the panel receiver operating characteristic figure PF.
			%  BUILD = Element.GETBUILD(PF) returns the build of 'PF'.
			%  BUILD = Element.GETBUILD('NNClassifierMLP_EvaluatorPF_ROC') returns the build of 'NNClassifierMLP_EvaluatorPF_ROC'.
			%
			% Note that the Element.GETBUILD(PF) and Element.GETBUILD('NNClassifierMLP_EvaluatorPF_ROC')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pf_class = getClass()
			%GETCLASS returns the class of the panel receiver operating characteristic figure.
			%
			% CLASS = NNClassifierMLP_EvaluatorPF_ROC.GETCLASS() returns the class 'NNClassifierMLP_EvaluatorPF_ROC'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel receiver operating characteristic figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('NNClassifierMLP_EvaluatorPF_ROC') returns 'NNClassifierMLP_EvaluatorPF_ROC'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('NNClassifierMLP_EvaluatorPF_ROC')
			%  are less computationally efficient.
			
			pf_class = 'NNClassifierMLP_EvaluatorPF_ROC';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel receiver operating characteristic figure.
			%
			% LIST = NNClassifierMLP_EvaluatorPF_ROC.GETSUBCLASSES() returns all subclasses of 'NNClassifierMLP_EvaluatorPF_ROC'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel receiver operating characteristic figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('NNClassifierMLP_EvaluatorPF_ROC') returns all subclasses of 'NNClassifierMLP_EvaluatorPF_ROC'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('NNClassifierMLP_EvaluatorPF_ROC')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNClassifierMLP_EvaluatorPF_ROC' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel receiver operating characteristic figure.
			%
			% PROPS = NNClassifierMLP_EvaluatorPF_ROC.GETPROPS() returns the property list of panel receiver operating characteristic figure
			%  as a row vector.
			%
			% PROPS = NNClassifierMLP_EvaluatorPF_ROC.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel receiver operating characteristic figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('NNClassifierMLP_EvaluatorPF_ROC'[, CATEGORY]) returns the property list of 'NNClassifierMLP_EvaluatorPF_ROC'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('NNClassifierMLP_EvaluatorPF_ROC')
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
					prop_list = [6 7 26 27 28 29];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = 5;
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 30];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 21 22 23 25 31 34 36 38];
				case 8 % Category.FIGURE
					prop_list = [14 20 24 32 33 35 37 39];
				case 9 % Category.GUI
					prop_list = [9 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel receiver operating characteristic figure.
			%
			% N = NNClassifierMLP_EvaluatorPF_ROC.GETPROPNUMBER() returns the property number of panel receiver operating characteristic figure.
			%
			% N = NNClassifierMLP_EvaluatorPF_ROC.GETPROPNUMBER(CATEGORY) returns the property number of panel receiver operating characteristic figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel receiver operating characteristic figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('NNClassifierMLP_EvaluatorPF_ROC') returns the property number of 'NNClassifierMLP_EvaluatorPF_ROC'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('NNClassifierMLP_EvaluatorPF_ROC')
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
					prop_number = 6;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 8;
				case 7 % Category.EVANESCENT
					prop_number = 10;
				case 8 % Category.FIGURE
					prop_number = 8;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel receiver operating characteristic figure/error.
			%
			% CHECK = NNClassifierMLP_EvaluatorPF_ROC.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(NNClassifierMLP_EvaluatorPF_ROC, PROP) checks whether PROP exists for NNClassifierMLP_EvaluatorPF_ROC.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_EvaluatorPF_ROC:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:NNClassifierMLP_EvaluatorPF_ROC:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:NNClassifierMLP_EvaluatorPF_ROC:WrongInput]
			%  Element.EXISTSPROP(NNClassifierMLP_EvaluatorPF_ROC, PROP) throws error if PROP does NOT exist for NNClassifierMLP_EvaluatorPF_ROC.
			%   Error id: [BRAPH2:NNClassifierMLP_EvaluatorPF_ROC:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('NNClassifierMLP_EvaluatorPF_ROC')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 39 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_EvaluatorPF_ROC:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_EvaluatorPF_ROC:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNClassifierMLP_EvaluatorPF_ROC.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel receiver operating characteristic figure/error.
			%
			% CHECK = NNClassifierMLP_EvaluatorPF_ROC.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(NNClassifierMLP_EvaluatorPF_ROC, TAG) checks whether TAG exists for NNClassifierMLP_EvaluatorPF_ROC.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_EvaluatorPF_ROC:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:NNClassifierMLP_EvaluatorPF_ROC:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:NNClassifierMLP_EvaluatorPF_ROC:WrongInput]
			%  Element.EXISTSTAG(NNClassifierMLP_EvaluatorPF_ROC, TAG) throws error if TAG does NOT exist for NNClassifierMLP_EvaluatorPF_ROC.
			%   Error id: [BRAPH2:NNClassifierMLP_EvaluatorPF_ROC:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('NNClassifierMLP_EvaluatorPF_ROC')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'NNE'  'CLASSNAMES'  'X_VALUES'  'Y_VALUES'  'SETUP'  'H_ROC'  'ROC'  'ROC_DICT'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_EvaluatorPF_ROC:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_EvaluatorPF_ROC:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNClassifierMLP_EvaluatorPF_ROC.'] ...
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
			%  PROPERTY = PF.GETPROPPROP(POINTER) returns property number of POINTER of PF.
			%  PROPERTY = Element.GETPROPPROP(NNClassifierMLP_EvaluatorPF_ROC, POINTER) returns property number of POINTER of NNClassifierMLP_EvaluatorPF_ROC.
			%  PROPERTY = PF.GETPROPPROP(NNClassifierMLP_EvaluatorPF_ROC, POINTER) returns property number of POINTER of NNClassifierMLP_EvaluatorPF_ROC.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('NNClassifierMLP_EvaluatorPF_ROC')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'NNE'  'CLASSNAMES'  'X_VALUES'  'Y_VALUES'  'SETUP'  'H_ROC'  'ROC'  'ROC_DICT'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = PF.GETPROPTAG(POINTER) returns tag of POINTER of PF.
			%  TAG = Element.GETPROPTAG(NNClassifierMLP_EvaluatorPF_ROC, POINTER) returns tag of POINTER of NNClassifierMLP_EvaluatorPF_ROC.
			%  TAG = PF.GETPROPTAG(NNClassifierMLP_EvaluatorPF_ROC, POINTER) returns tag of POINTER of NNClassifierMLP_EvaluatorPF_ROC.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('NNClassifierMLP_EvaluatorPF_ROC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnclassifiermlp_evaluatorpf_roc_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'NNE'  'CLASSNAMES'  'X_VALUES'  'Y_VALUES'  'SETUP'  'H_ROC'  'ROC'  'ROC_DICT'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' };
				tag = nnclassifiermlp_evaluatorpf_roc_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = PF.GETPROPCATEGORY(POINTER) returns category of POINTER of PF.
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierMLP_EvaluatorPF_ROC, POINTER) returns category of POINTER of NNClassifierMLP_EvaluatorPF_ROC.
			%  CATEGORY = PF.GETPROPCATEGORY(NNClassifierMLP_EvaluatorPF_ROC, POINTER) returns category of POINTER of NNClassifierMLP_EvaluatorPF_ROC.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('NNClassifierMLP_EvaluatorPF_ROC')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_evaluatorpf_roc_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  8  7  7  7  8  7  2  2  2  2  6  7  8  8  7  8  7  8  7  8 };
			prop_category = nnclassifiermlp_evaluatorpf_roc_category_list{prop};
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
			%  FORMAT = PF.GETPROPFORMAT(POINTER) returns format of POINTER of PF.
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierMLP_EvaluatorPF_ROC, POINTER) returns format of POINTER of NNClassifierMLP_EvaluatorPF_ROC.
			%  FORMAT = PF.GETPROPFORMAT(NNClassifierMLP_EvaluatorPF_ROC, POINTER) returns format of POINTER of NNClassifierMLP_EvaluatorPF_ROC.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('NNClassifierMLP_EvaluatorPF_ROC')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_evaluatorpf_roc_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  8  18  19  18  8  18  8  3  14  14  1  19  4  10  18  8  18  8  18  8 };
			prop_format = nnclassifiermlp_evaluatorpf_roc_format_list{prop};
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
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PF.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierMLP_EvaluatorPF_ROC, POINTER) returns description of POINTER of NNClassifierMLP_EvaluatorPF_ROC.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(NNClassifierMLP_EvaluatorPF_ROC, POINTER) returns description of POINTER of NNClassifierMLP_EvaluatorPF_ROC.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('NNClassifierMLP_EvaluatorPF_ROC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_evaluatorpf_roc_description_list = { 'ELCLASS (constant, string) is the class of the panel of the ensemble-based comparison.'  'NAME (constant, string) is the name of the panel ensemble-based comparison figure.'  'DESCRIPTION (constant, string) is the description of the panel ensemble-based comparison figure.'  'TEMPLATE (parameter, item) is the template of the panel ensemble-based comparison figure.'  'ID (data, string) is a few-letter code for the panel ensemble-based comparison figure.'  'LABEL (metadata, string) is an extended label of the panel ensemble-based comparison figure.'  'NOTES (metadata, string) are some specific notes about the panel ensemble-based comparison figure.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the receiver operating characteristic figure.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel.'  'HIDE (query, logical) hides the figure containing the panel.'  'DELETE (query, logical) resets the handles when the panel figure graph is deleted.'  'CLOSE (query, logical) closes the figure containing the panel.'  'ST_POSITION (figure, item) determines the panel position.'  'H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.'  'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.'  'H_AXES (evanescent, handle) is the handle for the axes.'  'ST_AXIS (figure, item) determines the axis settings.'  'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.'  'NNE (metadata, item) is the neural network evaluator.'  'CLASSNAMES (metadata, stringlist) is the class names.'  'X_VALUES (metadata, matrix) gets the x values for receiver operating characteristic curves.'  'Y_VALUES (metadata, matrix) gets the y values for receiver operating characteristic curves.'  'SETUP (query, empty) calculates the the receiver operating characteristic values and initializes the receiver operating characteristic figure.'  'H_ROC (evanescent, handlelist) is the set of handles for the ROC plots.'  'ROC (figure, logical) determines whether the ROC plots are shown.'  'ROC_DICT (figure, idict) contains the ROC plot for each class.'  'H_TITLE (evanescent, handle) is the axis title.'  'ST_TITLE (figure, item) determines the title settings.'  'H_XLABEL (evanescent, handle) is the axis x-label.'  'ST_XLABEL (figure, item) determines the x-label settings.'  'H_YLABEL (evanescent, handle) is the axis y-label.'  'ST_YLABEL (figure, item) determines the y-label settings.' };
			prop_description = nnclassifiermlp_evaluatorpf_roc_description_list{prop};
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
			%  SETTINGS = PF.GETPROPSETTINGS(POINTER) returns settings of POINTER of PF.
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierMLP_EvaluatorPF_ROC, POINTER) returns settings of POINTER of NNClassifierMLP_EvaluatorPF_ROC.
			%  SETTINGS = PF.GETPROPSETTINGS(NNClassifierMLP_EvaluatorPF_ROC, POINTER) returns settings of POINTER of NNClassifierMLP_EvaluatorPF_ROC.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('NNClassifierMLP_EvaluatorPF_ROC')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 23 % NNClassifierMLP_EvaluatorPF_ROC.H_AXES
					prop_settings = Format.getFormatSettings(18);
				case 24 % NNClassifierMLP_EvaluatorPF_ROC.ST_AXIS
					prop_settings = 'SettingsAxis';
				case 25 % NNClassifierMLP_EvaluatorPF_ROC.LISTENER_ST_AXIS
					prop_settings = Format.getFormatSettings(18);
				case 26 % NNClassifierMLP_EvaluatorPF_ROC.NNE
					prop_settings = 'NNClassifierMLP_Evaluator';
				case 27 % NNClassifierMLP_EvaluatorPF_ROC.CLASSNAMES
					prop_settings = Format.getFormatSettings(3);
				case 28 % NNClassifierMLP_EvaluatorPF_ROC.X_VALUES
					prop_settings = Format.getFormatSettings(14);
				case 29 % NNClassifierMLP_EvaluatorPF_ROC.Y_VALUES
					prop_settings = Format.getFormatSettings(14);
				case 30 % NNClassifierMLP_EvaluatorPF_ROC.SETUP
					prop_settings = Format.getFormatSettings(1);
				case 31 % NNClassifierMLP_EvaluatorPF_ROC.H_ROC
					prop_settings = Format.getFormatSettings(19);
				case 32 % NNClassifierMLP_EvaluatorPF_ROC.ROC
					prop_settings = Format.getFormatSettings(4);
				case 33 % NNClassifierMLP_EvaluatorPF_ROC.ROC_DICT
					prop_settings = 'SettingsLine';
				case 34 % NNClassifierMLP_EvaluatorPF_ROC.H_TITLE
					prop_settings = Format.getFormatSettings(18);
				case 35 % NNClassifierMLP_EvaluatorPF_ROC.ST_TITLE
					prop_settings = 'SettingsText';
				case 36 % NNClassifierMLP_EvaluatorPF_ROC.H_XLABEL
					prop_settings = Format.getFormatSettings(18);
				case 37 % NNClassifierMLP_EvaluatorPF_ROC.ST_XLABEL
					prop_settings = 'SettingsText';
				case 38 % NNClassifierMLP_EvaluatorPF_ROC.H_YLABEL
					prop_settings = Format.getFormatSettings(18);
				case 39 % NNClassifierMLP_EvaluatorPF_ROC.ST_YLABEL
					prop_settings = 'SettingsText';
				case 4 % NNClassifierMLP_EvaluatorPF_ROC.TEMPLATE
					prop_settings = 'NNClassifierMLP_EvaluatorPF_ROC';
				otherwise
					prop_settings = getPropSettings@PanelFig(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNClassifierMLP_EvaluatorPF_ROC.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_EvaluatorPF_ROC.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(NNClassifierMLP_EvaluatorPF_ROC, POINTER) returns the default value of POINTER of NNClassifierMLP_EvaluatorPF_ROC.
			%  DEFAULT = PF.GETPROPDEFAULT(NNClassifierMLP_EvaluatorPF_ROC, POINTER) returns the default value of POINTER of NNClassifierMLP_EvaluatorPF_ROC.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('NNClassifierMLP_EvaluatorPF_ROC')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 23 % NNClassifierMLP_EvaluatorPF_ROC.H_AXES
					prop_default = Format.getFormatDefault(18, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 24 % NNClassifierMLP_EvaluatorPF_ROC.ST_AXIS
					prop_default = SettingsAxis('AXIS', true, 'GRID', false, 'EQUAL', false);
				case 25 % NNClassifierMLP_EvaluatorPF_ROC.LISTENER_ST_AXIS
					prop_default = Format.getFormatDefault(18, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 26 % NNClassifierMLP_EvaluatorPF_ROC.NNE
					prop_default = Format.getFormatDefault(8, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 27 % NNClassifierMLP_EvaluatorPF_ROC.CLASSNAMES
					prop_default = Format.getFormatDefault(3, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 28 % NNClassifierMLP_EvaluatorPF_ROC.X_VALUES
					prop_default = Format.getFormatDefault(14, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 29 % NNClassifierMLP_EvaluatorPF_ROC.Y_VALUES
					prop_default = Format.getFormatDefault(14, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 30 % NNClassifierMLP_EvaluatorPF_ROC.SETUP
					prop_default = Format.getFormatDefault(1, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 31 % NNClassifierMLP_EvaluatorPF_ROC.H_ROC
					prop_default = Format.getFormatDefault(19, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 32 % NNClassifierMLP_EvaluatorPF_ROC.ROC
					prop_default = true;
				case 33 % NNClassifierMLP_EvaluatorPF_ROC.ROC_DICT
					prop_default = Format.getFormatDefault(10, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 34 % NNClassifierMLP_EvaluatorPF_ROC.H_TITLE
					prop_default = Format.getFormatDefault(18, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 35 % NNClassifierMLP_EvaluatorPF_ROC.ST_TITLE
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', 24, 'HALIGN', 'center', 'VALIGN', 'middle');
				case 36 % NNClassifierMLP_EvaluatorPF_ROC.H_XLABEL
					prop_default = Format.getFormatDefault(18, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 37 % NNClassifierMLP_EvaluatorPF_ROC.ST_XLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', 24, 'HALIGN', 'center', 'VALIGN', 'middle');
				case 38 % NNClassifierMLP_EvaluatorPF_ROC.H_YLABEL
					prop_default = Format.getFormatDefault(18, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 39 % NNClassifierMLP_EvaluatorPF_ROC.ST_YLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', 24, 'HALIGN', 'center', 'VALIGN', 'middle', 'ROTATION', 90);
				case 1 % NNClassifierMLP_EvaluatorPF_ROC.ELCLASS
					prop_default = 'NNClassifierMLP_EvaluatorPF_ROC';
				case 2 % NNClassifierMLP_EvaluatorPF_ROC.NAME
					prop_default = 'ROC Panel for an Evaluator of MLP Classifier';
				case 3 % NNClassifierMLP_EvaluatorPF_ROC.DESCRIPTION
					prop_default = 'The receiver operating characteristic panel for an evaluator of MLP classifier (NNClassifierMLP_EvaluatorPF_ROC) manages the functionalities to plot a panel of the receiver operating characteristic curves.';
				case 4 % NNClassifierMLP_EvaluatorPF_ROC.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 5 % NNClassifierMLP_EvaluatorPF_ROC.ID
					prop_default = 'NNClassifierMLP_EvaluatorPF_ROC ID';
				case 6 % NNClassifierMLP_EvaluatorPF_ROC.LABEL
					prop_default = 'NNClassifierMLP_EvaluatorPF_ROC label';
				case 7 % NNClassifierMLP_EvaluatorPF_ROC.NOTES
					prop_default = 'NNClassifierMLP_EvaluatorPF_ROC notes';
				otherwise
					prop_default = getPropDefault@PanelFig(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNClassifierMLP_EvaluatorPF_ROC.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_EvaluatorPF_ROC.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_EvaluatorPF_ROC, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_EvaluatorPF_ROC.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_EvaluatorPF_ROC, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_EvaluatorPF_ROC.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('NNClassifierMLP_EvaluatorPF_ROC')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC.getPropProp(pointer);
			
			prop_default = NNClassifierMLP_EvaluatorPF_ROC.conditioning(prop, NNClassifierMLP_EvaluatorPF_ROC.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PF.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PF.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PF.
			%  CHECK = Element.CHECKPROP(NNClassifierMLP_EvaluatorPF_ROC, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_EvaluatorPF_ROC.
			%  CHECK = PF.CHECKPROP(NNClassifierMLP_EvaluatorPF_ROC, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_EvaluatorPF_ROC.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNClassifierMLP_EvaluatorPF_ROC:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: BRAPH2:NNClassifierMLP_EvaluatorPF_ROC:WrongInput
			%  Element.CHECKPROP(NNClassifierMLP_EvaluatorPF_ROC, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_EvaluatorPF_ROC.
			%   Error id: BRAPH2:NNClassifierMLP_EvaluatorPF_ROC:WrongInput
			%  PF.CHECKPROP(NNClassifierMLP_EvaluatorPF_ROC, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_EvaluatorPF_ROC.
			%   Error id: BRAPH2:NNClassifierMLP_EvaluatorPF_ROC:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('NNClassifierMLP_EvaluatorPF_ROC')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNClassifierMLP_EvaluatorPF_ROC.getPropProp(pointer);
			
			switch prop
				case 23 % NNClassifierMLP_EvaluatorPF_ROC.H_AXES
					check = Format.checkFormat(18, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 24 % NNClassifierMLP_EvaluatorPF_ROC.ST_AXIS
					check = Format.checkFormat(8, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 25 % NNClassifierMLP_EvaluatorPF_ROC.LISTENER_ST_AXIS
					check = Format.checkFormat(18, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 26 % NNClassifierMLP_EvaluatorPF_ROC.NNE
					check = Format.checkFormat(8, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 27 % NNClassifierMLP_EvaluatorPF_ROC.CLASSNAMES
					check = Format.checkFormat(3, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 28 % NNClassifierMLP_EvaluatorPF_ROC.X_VALUES
					check = Format.checkFormat(14, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 29 % NNClassifierMLP_EvaluatorPF_ROC.Y_VALUES
					check = Format.checkFormat(14, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 30 % NNClassifierMLP_EvaluatorPF_ROC.SETUP
					check = Format.checkFormat(1, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 31 % NNClassifierMLP_EvaluatorPF_ROC.H_ROC
					check = Format.checkFormat(19, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 32 % NNClassifierMLP_EvaluatorPF_ROC.ROC
					check = Format.checkFormat(4, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 33 % NNClassifierMLP_EvaluatorPF_ROC.ROC_DICT
					check = Format.checkFormat(10, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 34 % NNClassifierMLP_EvaluatorPF_ROC.H_TITLE
					check = Format.checkFormat(18, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 35 % NNClassifierMLP_EvaluatorPF_ROC.ST_TITLE
					check = Format.checkFormat(8, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 36 % NNClassifierMLP_EvaluatorPF_ROC.H_XLABEL
					check = Format.checkFormat(18, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 37 % NNClassifierMLP_EvaluatorPF_ROC.ST_XLABEL
					check = Format.checkFormat(8, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 38 % NNClassifierMLP_EvaluatorPF_ROC.H_YLABEL
					check = Format.checkFormat(18, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 39 % NNClassifierMLP_EvaluatorPF_ROC.ST_YLABEL
					check = Format.checkFormat(8, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				case 4 % NNClassifierMLP_EvaluatorPF_ROC.TEMPLATE
					check = Format.checkFormat(8, value, NNClassifierMLP_EvaluatorPF_ROC.getPropSettings(prop));
				otherwise
					if prop <= 22
						check = checkProp@PanelFig(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_EvaluatorPF_ROC:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_EvaluatorPF_ROC:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNClassifierMLP_EvaluatorPF_ROC.getPropTag(prop) ' (' NNClassifierMLP_EvaluatorPF_ROC.getFormatTag(NNClassifierMLP_EvaluatorPF_ROC.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pf, prop)
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
				case 24 % NNClassifierMLP_EvaluatorPF_ROC.ST_AXIS
					if pf.get('DRAWN')
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
					        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
					    end
					end
					
				case 32 % NNClassifierMLP_EvaluatorPF_ROC.ROC
					if ~pf.get('ROC') % false
					    h_roc = pf.get('H_ROC');
					    for i = 1:1:length(H_ROC)
					        set(h_roc{i}, 'Visible', false)
					    end
					else % true
					    % triggers the update of SPH_DICT
					    pf.set('ROC_DICT', pf.get('ROC_DICT'))
					end
					
					% update state of toggle tool
					toolbar = pf.get('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    set(findobj(toolbar, 'Tag', 'TOOL.ROC'), 'State', pf.get('ROC'))
					end
					
					pf.get('SETUP');
					
				case 33 % NNClassifierMLP_EvaluatorPF_ROC.ROC_DICT
					if pf.get('ROC') && ~isa(pf.getr('NNE'), 'NoValue')
					    x_values = pf.memorize('X_VALUES');
					    y_values = pf.memorize('Y_VALUES');
					    classNames = pf.get('CLASSNAMES');
					    
					    if pf.get('ROC_DICT').get('LENGTH') == 0 && ~isempty(classNames)
					        for i = 1:1:length(classNames)
					            className = classNames{i};
					            roc_st_lines{i} = SettingsLine( ...
					                'ID', className, ...
					                'X', x_values(i, :), ...
					                'Y', y_values(i, :), ...
					                'I', i, ...
					                'PANEL', pf, ...
					                'PROP', 31, ...
					                'LINESTYLE', '--', ...
					                'VISIBLE', false ...
					                );
					        end
					        roc_st_lines{1}.set('VISIBLE', true);
					        pf.get('ROC_DICT').set('IT_LIST', roc_st_lines)
					    end
					    for i = 1:1:length(classNames)
					        pf.get('ROC_DICT').get('IT', i).get('SETUP')
					    end
					end
					
				otherwise
					if prop <= 22
						postset@PanelFig(pf, prop);
					end
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(pf, prop)
			%POSTPROCESSING postprocessesing after setting.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% The postprocessing of all properties occurs each time set is called.
			%
			% See also conditioning, preset, checkProp, postset, calculateValue,
			%  checkValue.
			
			switch prop
				case 27 % NNClassifierMLP_EvaluatorPF_ROC.CLASSNAMES
					if isa(pf.getr('CLASSNAMES'), 'NoValue') && ~isa(pf.get('NNE').get('NN').getr('MODEL'), 'NoValue')
					    pf.set('CLASSNAMES', cellstr(pf.memorize('NNE').get('NN').get('MODEL').Layers(end).Classes));
					end
					
				case 28 % NNClassifierMLP_EvaluatorPF_ROC.X_VALUES
					if isa(pf.getr('X_VALUES'), 'NoValue') && ~isa(pf.get('NNE').get('NN').getr('MODEL'), 'NoValue')
					    class_names = pf.get('CLASSNAMES');
					    predictions = cell2mat(pf.get('NNE').get('NN').get('PREDICT', pf.get('NNE').get('D')));
					    ground_truth = categorical(pf.get('NNE').get('GROUND_TRUTH'));
					    rocNet = rocmetrics(ground_truth, predictions, class_names);
					    for i = 1:1:length(class_names)
					        idx_class = strcmp(rocNet.Metrics.ClassName, class_names{i});
					        values(i, :) = rocNet.Metrics(idx_class,:).FalsePositiveRate;
					    end
					    pf.set('X_VALUES', values);
					end
					
				case 29 % NNClassifierMLP_EvaluatorPF_ROC.Y_VALUES
					if isa(pf.getr('Y_VALUES'), 'NoValue') && ~isa(pf.get('NNE').get('NN').getr('MODEL'), 'NoValue')
					    class_names = pf.get('CLASSNAMES');
					    predictions = cell2mat(pf.get('NNE').get('NN').get('PREDICT', pf.get('NNE').get('D')));
					    ground_truth = categorical(pf.get('NNE').get('GROUND_TRUTH'));
					    rocNet = rocmetrics(ground_truth, predictions, class_names);
					    for i = 1:1:length(class_names)
					        idx_class = strcmp(rocNet.Metrics.ClassName, class_names{i});
					        values(i, :) = rocNet.Metrics(idx_class,:).TruePositiveRate;
					    end
					    pf.set('Y_VALUES', values);
					end
					
				otherwise
					if prop <= 22
						postprocessing@PanelFig(pf, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pf, prop, varargin)
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
				case 23 % NNClassifierMLP_EvaluatorPF_ROC.H_AXES
					h_axes = uiaxes( ...
					    'Parent', pf.memorize('H'), ...
					    'Tag', 'H_AXES', ...
					    'Units', 'normalized', ...
					    'OuterPosition', [.2 .2 .6 .6] ... % % % %TODO transform this into a prop?
					    );
					h_axes.Toolbar.Visible = 'off';
					h_axes.Interactions = [];
					box(h_axes, 'on')
					hold(h_axes, 'on')
					value = h_axes;
					
				case 25 % NNClassifierMLP_EvaluatorPF_ROC.LISTENER_ST_AXIS
					value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis);
					
				case 30 % NNClassifierMLP_EvaluatorPF_ROC.SETUP
					pf.memorize('H_ROC');
					
					nne = pf.get('NNE');
					
					x_values = pf.get('X_VALUES');
					y_values = pf.get('Y_VALUES');
					
					pf.memorize('ROC_DICT');
					
					xlim = pf.get('H_AXES').get('XLim');
					ylim = pf.get('H_AXES').get('YLim');
					plot_title = 'ROC curves';
					pf.get('ST_TITLE').set( ...
					    'TXT', plot_title, ...
					    'X', .5 * (xlim(2) + xlim(1)), ...
					    'Y', ylim(2) + .07 * (ylim(2) - ylim(1)), ...
					    'Z', 0 ...
					    )
					pf.get('ST_XLABEL').set( ...
					    'TXT', 'False Positive Rate', ...
					    'X', .5 * (xlim(2) + xlim(1)), ...
					    'Y', ylim(1) - .07 * (ylim(2) - ylim(1)), ...
					    'Z', 0 ...
					    )
					pf.get('ST_YLABEL').set( ...
						'TXT', 'True Positive Rate', ...
					    'X', xlim(1) - .14 * (xlim(2) - xlim(1)), ...
					    'Y', .5 * (ylim(2) + ylim(1)), ...
					    'Z', 0 ...
					    )
					
					value = [];
					
				case 31 % NNClassifierMLP_EvaluatorPF_ROC.H_ROC
					classNames = pf.get('CLASSNAMES');
					L = length(classNames);
					H_ROC = cell(1, L);
					for i = 1:1:L
					    H_ROC{i} = plot(pf.get('H_AXES'), [0], [0], 'x');
					end
					value = H_ROC;
					
				case 34 % NNClassifierMLP_EvaluatorPF_ROC.H_TITLE
					value = title(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_TITLE'), 'NoValue')
					    st = pf.memorize('ST_TITLE');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', pf.get('NNE').get('LABEL'), ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case 36 % NNClassifierMLP_EvaluatorPF_ROC.H_XLABEL
					value = xlabel(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_XLABEL'), 'NoValue')
					    st = pf.memorize('ST_XLABEL');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', 'Layer', ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case 38 % NNClassifierMLP_EvaluatorPF_ROC.H_YLABEL
					value = ylabel(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_YLABEL'), 'NoValue')
					    st = pf.memorize('ST_YLABEL');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', 'Difference', ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case 11 % NNClassifierMLP_EvaluatorPF_ROC.DRAW
					value = calculateValue@PanelFig(pf, 11, varargin{:}); % also warning
					if value
					    pf.memorize('H_AXES')
					    
					    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', 23).get('SETUP')
					    pf.memorize('LISTENER_ST_AXIS');
					    
					    pf.memorize('H_ROC')
					    
					    pf.memorize('H_TITLE')
					    pf.memorize('ST_TITLE').set('PANEL', pf, 'PROP', 34).get('SETUP')
					
					    pf.memorize('H_XLABEL')
					    pf.memorize('ST_XLABEL').set('PANEL', pf, 'PROP', 36).get('SETUP')
					    
					    pf.memorize('H_YLABEL')
					    pf.memorize('ST_YLABEL').set('PANEL', pf, 'PROP', 38).get('SETUP')
					
					    pf.get('SETUP')
					end
					
				case 18 % NNClassifierMLP_EvaluatorPF_ROC.DELETE
					value = calculateValue@PanelFig(pf, 18, varargin{:}); % also warning
					if value
					    pf.set('H_AXES', Element.getNoValue())
					
					    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
					 
					    pf.set('H_ROC', Element.getNoValue())
					
					    pf.set('H_TITLE', Element.getNoValue())
					
					    pf.set('H_XLABEL', Element.getNoValue())
					    
					    pf.set('H_YLABEL', Element.getNoValue())
					end
					
				case 22 % NNClassifierMLP_EvaluatorPF_ROC.H_TOOLS
					toolbar = pf.memorize('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    value = calculateValue@PanelFig(pf, 22);
					    
					    tool_separator_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % Axis
					    tool_axis = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Axis', ...
					        'Separator', 'on', ...
					        'State', pf.get('ST_AXIS').get('AXIS'), ...
					        'Tooltip', 'Show axis', ...
					        'CData', imread('icon_axis.png'), ...
					        'OnCallback', {@cb_axis, true}, ...
					        'OffCallback', {@cb_axis, false});
					
					    % Grid
					    tool_grid = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Grid', ...
					        'State', pf.get('ST_AXIS').get('GRID'), ...
					        'Tooltip', 'Show grid', ...
					        'CData', imread('icon_grid.png'), ...
					        'OnCallback', {@cb_grid, true}, ...
					        'OffCallback', {@cb_grid, false});
					
					    tool_separator_2 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					    
					    % Prediction Line
					    tool_roc = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.ROC', ...
					        'State', pf.get('ROC'), ...
					        'Tooltip', 'Show ROC Curves', ...
					        'CData', imresize(imread('icon_line.png'), [24 24]), ... % % % make icon 16x16
					        'OnCallback', {@cb_roc, true}, ...
					        'OffCallback', {@cb_roc, false});
					
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_axis, tool_grid, ... 
					        tool_separator_2, ... 
					        tool_roc ...
					        };
					else
					    value = {};
					end
					
				otherwise
					if prop <= 22
						value = calculateValue@PanelFig(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
			function cb_listener_st_axis(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
			            set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
			        end
			    end
			end
			function cb_axis(~, ~, axis) % (src, event)
			    pf.get('ST_AXIS').set('AXIS', axis);
			    
			    % triggers the update of ST_AXIS
			    pf.set('ST_AXIS', pf.get('ST_AXIS'))
			end
			function cb_grid(~, ~, grid) % (src, event)
			    pf.get('ST_AXIS').set('GRID', grid);
			
			    % triggers the update of ST_AXIS
			    pf.set('ST_AXIS', pf.get('ST_AXIS'))
			end
			function cb_roc(~, ~, visible) % (src, event)
				pf.set('ROC', visible)
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(pf, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case 24 % NNClassifierMLP_EvaluatorPF_ROC.ST_AXIS
					pr = SettingsAxisPP('EL', pf, 'PROP', 24, varargin{:});
					
				case 33 % NNClassifierMLP_EvaluatorPF_ROC.ROC_DICT
					SETUP = pf.getPropProp('SETUP');
					EL = PanelPropIDictTable.getPropProp('EL');
					pr = PanelPropIDictTable('EL', pf, 'PROP', 33, ...
					    'CB_TAB_EDIT', ['cb_table_edit_default(); pr.get(' num2str(EL) ').get(' num2str(SETUP) ')'], ...
					    'COLS', [-1 15 19 21 20 22 23 24 25], ...
					    varargin{:});
					
				case 35 % NNClassifierMLP_EvaluatorPF_ROC.ST_TITLE
					pr = SettingsTextPP('EL', pf, 'PROP', 35, varargin{:});
					
				case 37 % NNClassifierMLP_EvaluatorPF_ROC.ST_XLABEL
					pr = SettingsTextPP('EL', pf, 'PROP', 37, varargin{:});
					
				case 39 % NNClassifierMLP_EvaluatorPF_ROC.ST_YLABEL
					pr = SettingsTextPP('EL', pf, 'PROP', 39, varargin{:});
					
				otherwise
					pr = getPanelProp@PanelFig(pf, prop, varargin{:});
					
			end
		end
	end
end
