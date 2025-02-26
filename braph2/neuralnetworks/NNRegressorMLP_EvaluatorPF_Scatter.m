classdef NNRegressorMLP_EvaluatorPF_Scatter < PanelFig
	%NNRegressorMLP_EvaluatorPF_Scatter is the panel for scatter plots in a regression task.
	% It is a subclass of <a href="matlab:help PanelFig">PanelFig</a>.
	%
	% The scatter plot panel for an evaluator with a MLP regressor
	%  (NNRegressorMLP_EvaluatorPF_Scatter) manages the functionalities to plot 
	%  a panel of the scatter plot in a regression task.
	%
	% The list of NNRegressorMLP_EvaluatorPF_Scatter properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel scatter plot for an evaluator with MLP regressor.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel scatter plot for an evaluator with a MLP regressor.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel scatter plot for an evaluator with a MLP regressor.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel scatter plot for an evaluator with a MLP regressor.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel scatter plot for an evaluator with a MLP regressor.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel scatter plot for an evaluator with a MLP regressor.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel scatter plot for an evaluator with a MLP regressor.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the scatter plot figure.
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
	%  <strong>27</strong> <strong>PREDICTIONS_VALUE</strong> 	PREDICTIONS_VALUE (metadata, matrix) is the predictions value.
	%  <strong>28</strong> <strong>GROUNDTRUTH_VALUE</strong> 	GROUNDTRUTH_VALUE (metadata, matrix) is the ground truth value.
	%  <strong>29</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the prediction value and ground truth value, and then initializes the panel figure.
	%  <strong>30</strong> <strong>H_PREDICTIONS</strong> 	H_PREDICTIONS (evanescent, handlelist) is the set of handles for the prediction plots.
	%  <strong>31</strong> <strong>PREDICTIONS</strong> 	PREDICTIONS (figure, logical) determines whether the prediction plot are shown.
	%  <strong>32</strong> <strong>PREDICTION_DICT</strong> 	PREDICTION_DICT (figure, idict) contains the prediction plot for each target.
	%  <strong>33</strong> <strong>H_LINE_BASE</strong> 	H_LINE_BASE (evanescent, handle) is the handle for the base line.
	%  <strong>34</strong> <strong>ST_LINE_BASE</strong> 	ST_LINE_BASE (figure, item) determines the base line settings.
	%  <strong>35</strong> <strong>LISTENER_ST_LINE_BASE</strong> 	LISTENER_ST_LINE_BASE (evanescent, handle) contains the listener to the base line settings to update the pushbutton.
	%  <strong>36</strong> <strong>H_TITLE</strong> 	H_TITLE (evanescent, handle) is the axis title.
	%  <strong>37</strong> <strong>ST_TITLE</strong> 	ST_TITLE (figure, item) determines the title settings.
	%  <strong>38</strong> <strong>H_XLABEL</strong> 	H_XLABEL (evanescent, handle) is the axis x-label.
	%  <strong>39</strong> <strong>ST_XLABEL</strong> 	ST_XLABEL (figure, item) determines the x-label settings.
	%  <strong>40</strong> <strong>H_YLABEL</strong> 	H_YLABEL (evanescent, handle) is the axis y-label.
	%  <strong>41</strong> <strong>ST_YLABEL</strong> 	ST_YLABEL (figure, item) determines the y-label settings.
	%
	% NNRegressorMLP_EvaluatorPF_Scatter methods (constructor):
	%  NNRegressorMLP_EvaluatorPF_Scatter - constructor
	%
	% NNRegressorMLP_EvaluatorPF_Scatter methods:
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
	% NNRegressorMLP_EvaluatorPF_Scatter methods (display):
	%  tostring - string with information about the panel scatter plot figure
	%  disp - displays information about the panel scatter plot figure
	%  tree - displays the tree of the panel scatter plot figure
	%
	% NNRegressorMLP_EvaluatorPF_Scatter methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel scatter plot figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel scatter plot figure
	%
	% NNRegressorMLP_EvaluatorPF_Scatter methods (save/load, Static):
	%  save - saves BRAPH2 panel scatter plot figure as b2 file
	%  load - loads a BRAPH2 panel scatter plot figure from a b2 file
	%
	% NNRegressorMLP_EvaluatorPF_Scatter method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel scatter plot figure
	%
	% NNRegressorMLP_EvaluatorPF_Scatter method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel scatter plot figure
	%
	% NNRegressorMLP_EvaluatorPF_Scatter methods (inspection, Static):
	%  getClass - returns the class of the panel scatter plot figure
	%  getSubclasses - returns all subclasses of NNRegressorMLP_EvaluatorPF_Scatter
	%  getProps - returns the property list of the panel scatter plot figure
	%  getPropNumber - returns the property number of the panel scatter plot figure
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
	% NNRegressorMLP_EvaluatorPF_Scatter methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNRegressorMLP_EvaluatorPF_Scatter methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNRegressorMLP_EvaluatorPF_Scatter methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNRegressorMLP_EvaluatorPF_Scatter methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNRegressorMLP_EvaluatorPF_Scatter; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNRegressorMLP_EvaluatorPF_Scatter constants</a>.
	%
	%
	% See also NNRegressorMLP_Evaluator.
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
		
		PREDICTIONS_VALUE = 27; %CET: Computational Efficiency Trick
		PREDICTIONS_VALUE_TAG = 'PREDICTIONS_VALUE';
		PREDICTIONS_VALUE_CATEGORY = 2;
		PREDICTIONS_VALUE_FORMAT = 14;
		
		GROUNDTRUTH_VALUE = 28; %CET: Computational Efficiency Trick
		GROUNDTRUTH_VALUE_TAG = 'GROUNDTRUTH_VALUE';
		GROUNDTRUTH_VALUE_CATEGORY = 2;
		GROUNDTRUTH_VALUE_FORMAT = 14;
		
		SETUP = 29; %CET: Computational Efficiency Trick
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = 6;
		SETUP_FORMAT = 1;
		
		H_PREDICTIONS = 30; %CET: Computational Efficiency Trick
		H_PREDICTIONS_TAG = 'H_PREDICTIONS';
		H_PREDICTIONS_CATEGORY = 7;
		H_PREDICTIONS_FORMAT = 19;
		
		PREDICTIONS = 31; %CET: Computational Efficiency Trick
		PREDICTIONS_TAG = 'PREDICTIONS';
		PREDICTIONS_CATEGORY = 8;
		PREDICTIONS_FORMAT = 4;
		
		PREDICTION_DICT = 32; %CET: Computational Efficiency Trick
		PREDICTION_DICT_TAG = 'PREDICTION_DICT';
		PREDICTION_DICT_CATEGORY = 8;
		PREDICTION_DICT_FORMAT = 10;
		
		H_LINE_BASE = 33; %CET: Computational Efficiency Trick
		H_LINE_BASE_TAG = 'H_LINE_BASE';
		H_LINE_BASE_CATEGORY = 7;
		H_LINE_BASE_FORMAT = 18;
		
		ST_LINE_BASE = 34; %CET: Computational Efficiency Trick
		ST_LINE_BASE_TAG = 'ST_LINE_BASE';
		ST_LINE_BASE_CATEGORY = 8;
		ST_LINE_BASE_FORMAT = 8;
		
		LISTENER_ST_LINE_BASE = 35; %CET: Computational Efficiency Trick
		LISTENER_ST_LINE_BASE_TAG = 'LISTENER_ST_LINE_BASE';
		LISTENER_ST_LINE_BASE_CATEGORY = 7;
		LISTENER_ST_LINE_BASE_FORMAT = 18;
		
		H_TITLE = 36; %CET: Computational Efficiency Trick
		H_TITLE_TAG = 'H_TITLE';
		H_TITLE_CATEGORY = 7;
		H_TITLE_FORMAT = 18;
		
		ST_TITLE = 37; %CET: Computational Efficiency Trick
		ST_TITLE_TAG = 'ST_TITLE';
		ST_TITLE_CATEGORY = 8;
		ST_TITLE_FORMAT = 8;
		
		H_XLABEL = 38; %CET: Computational Efficiency Trick
		H_XLABEL_TAG = 'H_XLABEL';
		H_XLABEL_CATEGORY = 7;
		H_XLABEL_FORMAT = 18;
		
		ST_XLABEL = 39; %CET: Computational Efficiency Trick
		ST_XLABEL_TAG = 'ST_XLABEL';
		ST_XLABEL_CATEGORY = 8;
		ST_XLABEL_FORMAT = 8;
		
		H_YLABEL = 40; %CET: Computational Efficiency Trick
		H_YLABEL_TAG = 'H_YLABEL';
		H_YLABEL_CATEGORY = 7;
		H_YLABEL_FORMAT = 18;
		
		ST_YLABEL = 41; %CET: Computational Efficiency Trick
		ST_YLABEL_TAG = 'ST_YLABEL';
		ST_YLABEL_CATEGORY = 8;
		ST_YLABEL_FORMAT = 8;
	end
	methods % constructor
		function pf = NNRegressorMLP_EvaluatorPF_Scatter(varargin)
			%NNRegressorMLP_EvaluatorPF_Scatter() creates a panel scatter plot figure.
			%
			% NNRegressorMLP_EvaluatorPF_Scatter(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNRegressorMLP_EvaluatorPF_Scatter(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNRegressorMLP_EvaluatorPF_Scatter properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel scatter plot for an evaluator with MLP regressor.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel scatter plot for an evaluator with a MLP regressor.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel scatter plot for an evaluator with a MLP regressor.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel scatter plot for an evaluator with a MLP regressor.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel scatter plot for an evaluator with a MLP regressor.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel scatter plot for an evaluator with a MLP regressor.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel scatter plot for an evaluator with a MLP regressor.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the scatter plot figure.
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
			%  <strong>27</strong> <strong>PREDICTIONS_VALUE</strong> 	PREDICTIONS_VALUE (metadata, matrix) is the predictions value.
			%  <strong>28</strong> <strong>GROUNDTRUTH_VALUE</strong> 	GROUNDTRUTH_VALUE (metadata, matrix) is the ground truth value.
			%  <strong>29</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the prediction value and ground truth value, and then initializes the panel figure.
			%  <strong>30</strong> <strong>H_PREDICTIONS</strong> 	H_PREDICTIONS (evanescent, handlelist) is the set of handles for the prediction plots.
			%  <strong>31</strong> <strong>PREDICTIONS</strong> 	PREDICTIONS (figure, logical) determines whether the prediction plot are shown.
			%  <strong>32</strong> <strong>PREDICTION_DICT</strong> 	PREDICTION_DICT (figure, idict) contains the prediction plot for each target.
			%  <strong>33</strong> <strong>H_LINE_BASE</strong> 	H_LINE_BASE (evanescent, handle) is the handle for the base line.
			%  <strong>34</strong> <strong>ST_LINE_BASE</strong> 	ST_LINE_BASE (figure, item) determines the base line settings.
			%  <strong>35</strong> <strong>LISTENER_ST_LINE_BASE</strong> 	LISTENER_ST_LINE_BASE (evanescent, handle) contains the listener to the base line settings to update the pushbutton.
			%  <strong>36</strong> <strong>H_TITLE</strong> 	H_TITLE (evanescent, handle) is the axis title.
			%  <strong>37</strong> <strong>ST_TITLE</strong> 	ST_TITLE (figure, item) determines the title settings.
			%  <strong>38</strong> <strong>H_XLABEL</strong> 	H_XLABEL (evanescent, handle) is the axis x-label.
			%  <strong>39</strong> <strong>ST_XLABEL</strong> 	ST_XLABEL (figure, item) determines the x-label settings.
			%  <strong>40</strong> <strong>H_YLABEL</strong> 	H_YLABEL (evanescent, handle) is the axis y-label.
			%  <strong>41</strong> <strong>ST_YLABEL</strong> 	ST_YLABEL (figure, item) determines the y-label settings.
			%
			% See also Category, Format.
			
			pf = pf@PanelFig(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the panel scatter plot figure.
			%
			% BUILD = NNRegressorMLP_EvaluatorPF_Scatter.GETBUILD() returns the build of 'NNRegressorMLP_EvaluatorPF_Scatter'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PF.GETBUILD() returns the build of the panel scatter plot figure PF.
			%  BUILD = Element.GETBUILD(PF) returns the build of 'PF'.
			%  BUILD = Element.GETBUILD('NNRegressorMLP_EvaluatorPF_Scatter') returns the build of 'NNRegressorMLP_EvaluatorPF_Scatter'.
			%
			% Note that the Element.GETBUILD(PF) and Element.GETBUILD('NNRegressorMLP_EvaluatorPF_Scatter')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pf_class = getClass()
			%GETCLASS returns the class of the panel scatter plot figure.
			%
			% CLASS = NNRegressorMLP_EvaluatorPF_Scatter.GETCLASS() returns the class 'NNRegressorMLP_EvaluatorPF_Scatter'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel scatter plot figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('NNRegressorMLP_EvaluatorPF_Scatter') returns 'NNRegressorMLP_EvaluatorPF_Scatter'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('NNRegressorMLP_EvaluatorPF_Scatter')
			%  are less computationally efficient.
			
			pf_class = 'NNRegressorMLP_EvaluatorPF_Scatter';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel scatter plot figure.
			%
			% LIST = NNRegressorMLP_EvaluatorPF_Scatter.GETSUBCLASSES() returns all subclasses of 'NNRegressorMLP_EvaluatorPF_Scatter'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel scatter plot figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('NNRegressorMLP_EvaluatorPF_Scatter') returns all subclasses of 'NNRegressorMLP_EvaluatorPF_Scatter'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('NNRegressorMLP_EvaluatorPF_Scatter')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNRegressorMLP_EvaluatorPF_Scatter' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel scatter plot figure.
			%
			% PROPS = NNRegressorMLP_EvaluatorPF_Scatter.GETPROPS() returns the property list of panel scatter plot figure
			%  as a row vector.
			%
			% PROPS = NNRegressorMLP_EvaluatorPF_Scatter.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel scatter plot figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('NNRegressorMLP_EvaluatorPF_Scatter'[, CATEGORY]) returns the property list of 'NNRegressorMLP_EvaluatorPF_Scatter'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('NNRegressorMLP_EvaluatorPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 26 27 28];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = 5;
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 29];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 21 22 23 25 30 33 35 36 38 40];
				case 8 % Category.FIGURE
					prop_list = [14 20 24 31 32 34 37 39 41];
				case 9 % Category.GUI
					prop_list = [9 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel scatter plot figure.
			%
			% N = NNRegressorMLP_EvaluatorPF_Scatter.GETPROPNUMBER() returns the property number of panel scatter plot figure.
			%
			% N = NNRegressorMLP_EvaluatorPF_Scatter.GETPROPNUMBER(CATEGORY) returns the property number of panel scatter plot figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel scatter plot figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('NNRegressorMLP_EvaluatorPF_Scatter') returns the property number of 'NNRegressorMLP_EvaluatorPF_Scatter'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('NNRegressorMLP_EvaluatorPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 41;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 5;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 8;
				case 7 % Category.EVANESCENT
					prop_number = 12;
				case 8 % Category.FIGURE
					prop_number = 9;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel scatter plot figure/error.
			%
			% CHECK = NNRegressorMLP_EvaluatorPF_Scatter.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(NNRegressorMLP_EvaluatorPF_Scatter, PROP) checks whether PROP exists for NNRegressorMLP_EvaluatorPF_Scatter.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNRegressorMLP_EvaluatorPF_Scatter:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:NNRegressorMLP_EvaluatorPF_Scatter:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:NNRegressorMLP_EvaluatorPF_Scatter:WrongInput]
			%  Element.EXISTSPROP(NNRegressorMLP_EvaluatorPF_Scatter, PROP) throws error if PROP does NOT exist for NNRegressorMLP_EvaluatorPF_Scatter.
			%   Error id: [BRAPH2:NNRegressorMLP_EvaluatorPF_Scatter:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('NNRegressorMLP_EvaluatorPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 41 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNRegressorMLP_EvaluatorPF_Scatter:' 'WrongInput'], ...
					['BRAPH2' ':NNRegressorMLP_EvaluatorPF_Scatter:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNRegressorMLP_EvaluatorPF_Scatter.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel scatter plot figure/error.
			%
			% CHECK = NNRegressorMLP_EvaluatorPF_Scatter.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(NNRegressorMLP_EvaluatorPF_Scatter, TAG) checks whether TAG exists for NNRegressorMLP_EvaluatorPF_Scatter.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNRegressorMLP_EvaluatorPF_Scatter:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:NNRegressorMLP_EvaluatorPF_Scatter:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:NNRegressorMLP_EvaluatorPF_Scatter:WrongInput]
			%  Element.EXISTSTAG(NNRegressorMLP_EvaluatorPF_Scatter, TAG) throws error if TAG does NOT exist for NNRegressorMLP_EvaluatorPF_Scatter.
			%   Error id: [BRAPH2:NNRegressorMLP_EvaluatorPF_Scatter:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('NNRegressorMLP_EvaluatorPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'NNE'  'PREDICTIONS_VALUE'  'GROUNDTRUTH_VALUE'  'SETUP'  'H_PREDICTIONS'  'PREDICTIONS'  'PREDICTION_DICT'  'H_LINE_BASE'  'ST_LINE_BASE'  'LISTENER_ST_LINE_BASE'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNRegressorMLP_EvaluatorPF_Scatter:' 'WrongInput'], ...
					['BRAPH2' ':NNRegressorMLP_EvaluatorPF_Scatter:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNRegressorMLP_EvaluatorPF_Scatter.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNRegressorMLP_EvaluatorPF_Scatter, POINTER) returns property number of POINTER of NNRegressorMLP_EvaluatorPF_Scatter.
			%  PROPERTY = PF.GETPROPPROP(NNRegressorMLP_EvaluatorPF_Scatter, POINTER) returns property number of POINTER of NNRegressorMLP_EvaluatorPF_Scatter.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('NNRegressorMLP_EvaluatorPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'NNE'  'PREDICTIONS_VALUE'  'GROUNDTRUTH_VALUE'  'SETUP'  'H_PREDICTIONS'  'PREDICTIONS'  'PREDICTION_DICT'  'H_LINE_BASE'  'ST_LINE_BASE'  'LISTENER_ST_LINE_BASE'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(NNRegressorMLP_EvaluatorPF_Scatter, POINTER) returns tag of POINTER of NNRegressorMLP_EvaluatorPF_Scatter.
			%  TAG = PF.GETPROPTAG(NNRegressorMLP_EvaluatorPF_Scatter, POINTER) returns tag of POINTER of NNRegressorMLP_EvaluatorPF_Scatter.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('NNRegressorMLP_EvaluatorPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnregressormlp_evaluatorpf_scatter_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'NNE'  'PREDICTIONS_VALUE'  'GROUNDTRUTH_VALUE'  'SETUP'  'H_PREDICTIONS'  'PREDICTIONS'  'PREDICTION_DICT'  'H_LINE_BASE'  'ST_LINE_BASE'  'LISTENER_ST_LINE_BASE'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' };
				tag = nnregressormlp_evaluatorpf_scatter_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNRegressorMLP_EvaluatorPF_Scatter, POINTER) returns category of POINTER of NNRegressorMLP_EvaluatorPF_Scatter.
			%  CATEGORY = PF.GETPROPCATEGORY(NNRegressorMLP_EvaluatorPF_Scatter, POINTER) returns category of POINTER of NNRegressorMLP_EvaluatorPF_Scatter.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('NNRegressorMLP_EvaluatorPF_Scatter')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_EvaluatorPF_Scatter.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnregressormlp_evaluatorpf_scatter_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  8  7  7  7  8  7  2  2  2  6  7  8  8  7  8  7  7  8  7  8  7  8 };
			prop_category = nnregressormlp_evaluatorpf_scatter_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(NNRegressorMLP_EvaluatorPF_Scatter, POINTER) returns format of POINTER of NNRegressorMLP_EvaluatorPF_Scatter.
			%  FORMAT = PF.GETPROPFORMAT(NNRegressorMLP_EvaluatorPF_Scatter, POINTER) returns format of POINTER of NNRegressorMLP_EvaluatorPF_Scatter.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('NNRegressorMLP_EvaluatorPF_Scatter')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_EvaluatorPF_Scatter.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnregressormlp_evaluatorpf_scatter_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  8  18  19  18  8  18  8  14  14  1  19  4  10  18  8  18  18  8  18  8  18  8 };
			prop_format = nnregressormlp_evaluatorpf_scatter_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNRegressorMLP_EvaluatorPF_Scatter, POINTER) returns description of POINTER of NNRegressorMLP_EvaluatorPF_Scatter.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(NNRegressorMLP_EvaluatorPF_Scatter, POINTER) returns description of POINTER of NNRegressorMLP_EvaluatorPF_Scatter.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('NNRegressorMLP_EvaluatorPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_EvaluatorPF_Scatter.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnregressormlp_evaluatorpf_scatter_description_list = { 'ELCLASS (constant, string) is the class of the panel scatter plot for an evaluator with MLP regressor.'  'NAME (constant, string) is the name of the panel scatter plot for an evaluator with a MLP regressor.'  'DESCRIPTION (constant, string) is the description of the panel scatter plot for an evaluator with a MLP regressor.'  'TEMPLATE (parameter, item) is the template of the panel scatter plot for an evaluator with a MLP regressor.'  'ID (data, string) is a few-letter code for the panel scatter plot for an evaluator with a MLP regressor.'  'LABEL (metadata, string) is an extended label of the panel scatter plot for an evaluator with a MLP regressor.'  'NOTES (metadata, string) are some specific notes about the panel scatter plot for an evaluator with a MLP regressor.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the scatter plot figure.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel.'  'HIDE (query, logical) hides the figure containing the panel.'  'DELETE (query, logical) resets the handles when the panel figure graph is deleted.'  'CLOSE (query, logical) closes the figure containing the panel.'  'ST_POSITION (figure, item) determines the panel position.'  'H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.'  'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.'  'H_AXES (evanescent, handle) is the handle for the axes.'  'ST_AXIS (figure, item) determines the axis settings.'  'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.'  'NNE (metadata, item) is the neural network evaluator.'  'PREDICTIONS_VALUE (metadata, matrix) is the predictions value.'  'GROUNDTRUTH_VALUE (metadata, matrix) is the ground truth value.'  'SETUP (query, empty) calculates the prediction value and ground truth value, and then initializes the panel figure.'  'H_PREDICTIONS (evanescent, handlelist) is the set of handles for the prediction plots.'  'PREDICTIONS (figure, logical) determines whether the prediction plot are shown.'  'PREDICTION_DICT (figure, idict) contains the prediction plot for each target.'  'H_LINE_BASE (evanescent, handle) is the handle for the base line.'  'ST_LINE_BASE (figure, item) determines the base line settings.'  'LISTENER_ST_LINE_BASE (evanescent, handle) contains the listener to the base line settings to update the pushbutton.'  'H_TITLE (evanescent, handle) is the axis title.'  'ST_TITLE (figure, item) determines the title settings.'  'H_XLABEL (evanescent, handle) is the axis x-label.'  'ST_XLABEL (figure, item) determines the x-label settings.'  'H_YLABEL (evanescent, handle) is the axis y-label.'  'ST_YLABEL (figure, item) determines the y-label settings.' };
			prop_description = nnregressormlp_evaluatorpf_scatter_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNRegressorMLP_EvaluatorPF_Scatter, POINTER) returns settings of POINTER of NNRegressorMLP_EvaluatorPF_Scatter.
			%  SETTINGS = PF.GETPROPSETTINGS(NNRegressorMLP_EvaluatorPF_Scatter, POINTER) returns settings of POINTER of NNRegressorMLP_EvaluatorPF_Scatter.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('NNRegressorMLP_EvaluatorPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_EvaluatorPF_Scatter.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 23 % NNRegressorMLP_EvaluatorPF_Scatter.H_AXES
					prop_settings = Format.getFormatSettings(18);
				case 24 % NNRegressorMLP_EvaluatorPF_Scatter.ST_AXIS
					prop_settings = 'SettingsAxis';
				case 25 % NNRegressorMLP_EvaluatorPF_Scatter.LISTENER_ST_AXIS
					prop_settings = Format.getFormatSettings(18);
				case 26 % NNRegressorMLP_EvaluatorPF_Scatter.NNE
					prop_settings = 'NNRegressorMLP_Evaluator';
				case 27 % NNRegressorMLP_EvaluatorPF_Scatter.PREDICTIONS_VALUE
					prop_settings = Format.getFormatSettings(14);
				case 28 % NNRegressorMLP_EvaluatorPF_Scatter.GROUNDTRUTH_VALUE
					prop_settings = Format.getFormatSettings(14);
				case 29 % NNRegressorMLP_EvaluatorPF_Scatter.SETUP
					prop_settings = Format.getFormatSettings(1);
				case 30 % NNRegressorMLP_EvaluatorPF_Scatter.H_PREDICTIONS
					prop_settings = Format.getFormatSettings(19);
				case 31 % NNRegressorMLP_EvaluatorPF_Scatter.PREDICTIONS
					prop_settings = Format.getFormatSettings(4);
				case 32 % NNRegressorMLP_EvaluatorPF_Scatter.PREDICTION_DICT
					prop_settings = 'SettingsLine';
				case 33 % NNRegressorMLP_EvaluatorPF_Scatter.H_LINE_BASE
					prop_settings = Format.getFormatSettings(18);
				case 34 % NNRegressorMLP_EvaluatorPF_Scatter.ST_LINE_BASE
					prop_settings = 'SettingsLine';
				case 35 % NNRegressorMLP_EvaluatorPF_Scatter.LISTENER_ST_LINE_BASE
					prop_settings = Format.getFormatSettings(18);
				case 36 % NNRegressorMLP_EvaluatorPF_Scatter.H_TITLE
					prop_settings = Format.getFormatSettings(18);
				case 37 % NNRegressorMLP_EvaluatorPF_Scatter.ST_TITLE
					prop_settings = 'SettingsText';
				case 38 % NNRegressorMLP_EvaluatorPF_Scatter.H_XLABEL
					prop_settings = Format.getFormatSettings(18);
				case 39 % NNRegressorMLP_EvaluatorPF_Scatter.ST_XLABEL
					prop_settings = 'SettingsText';
				case 40 % NNRegressorMLP_EvaluatorPF_Scatter.H_YLABEL
					prop_settings = Format.getFormatSettings(18);
				case 41 % NNRegressorMLP_EvaluatorPF_Scatter.ST_YLABEL
					prop_settings = 'SettingsText';
				case 4 % NNRegressorMLP_EvaluatorPF_Scatter.TEMPLATE
					prop_settings = 'NNRegressorMLP_EvaluatorPF_Scatter';
				otherwise
					prop_settings = getPropSettings@PanelFig(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNRegressorMLP_EvaluatorPF_Scatter.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorMLP_EvaluatorPF_Scatter.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(NNRegressorMLP_EvaluatorPF_Scatter, POINTER) returns the default value of POINTER of NNRegressorMLP_EvaluatorPF_Scatter.
			%  DEFAULT = PF.GETPROPDEFAULT(NNRegressorMLP_EvaluatorPF_Scatter, POINTER) returns the default value of POINTER of NNRegressorMLP_EvaluatorPF_Scatter.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('NNRegressorMLP_EvaluatorPF_Scatter')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNRegressorMLP_EvaluatorPF_Scatter.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 23 % NNRegressorMLP_EvaluatorPF_Scatter.H_AXES
					prop_default = Format.getFormatDefault(18, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 24 % NNRegressorMLP_EvaluatorPF_Scatter.ST_AXIS
					prop_default = SettingsAxis('AXIS', true, 'GRID', false, 'EQUAL', false);
				case 25 % NNRegressorMLP_EvaluatorPF_Scatter.LISTENER_ST_AXIS
					prop_default = Format.getFormatDefault(18, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 26 % NNRegressorMLP_EvaluatorPF_Scatter.NNE
					prop_default = Format.getFormatDefault(8, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 27 % NNRegressorMLP_EvaluatorPF_Scatter.PREDICTIONS_VALUE
					prop_default = Format.getFormatDefault(14, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 28 % NNRegressorMLP_EvaluatorPF_Scatter.GROUNDTRUTH_VALUE
					prop_default = Format.getFormatDefault(14, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 29 % NNRegressorMLP_EvaluatorPF_Scatter.SETUP
					prop_default = Format.getFormatDefault(1, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 30 % NNRegressorMLP_EvaluatorPF_Scatter.H_PREDICTIONS
					prop_default = Format.getFormatDefault(19, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 31 % NNRegressorMLP_EvaluatorPF_Scatter.PREDICTIONS
					prop_default = true;
				case 32 % NNRegressorMLP_EvaluatorPF_Scatter.PREDICTION_DICT
					prop_default = Format.getFormatDefault(10, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 33 % NNRegressorMLP_EvaluatorPF_Scatter.H_LINE_BASE
					prop_default = Format.getFormatDefault(18, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 34 % NNRegressorMLP_EvaluatorPF_Scatter.ST_LINE_BASE
					prop_default = Format.getFormatDefault(8, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 35 % NNRegressorMLP_EvaluatorPF_Scatter.LISTENER_ST_LINE_BASE
					prop_default = Format.getFormatDefault(18, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 36 % NNRegressorMLP_EvaluatorPF_Scatter.H_TITLE
					prop_default = Format.getFormatDefault(18, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 37 % NNRegressorMLP_EvaluatorPF_Scatter.ST_TITLE
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', 24, 'HALIGN', 'center', 'VALIGN', 'middle');
				case 38 % NNRegressorMLP_EvaluatorPF_Scatter.H_XLABEL
					prop_default = Format.getFormatDefault(18, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 39 % NNRegressorMLP_EvaluatorPF_Scatter.ST_XLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', 24, 'HALIGN', 'center', 'VALIGN', 'middle');
				case 40 % NNRegressorMLP_EvaluatorPF_Scatter.H_YLABEL
					prop_default = Format.getFormatDefault(18, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 41 % NNRegressorMLP_EvaluatorPF_Scatter.ST_YLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', 24, 'HALIGN', 'center', 'VALIGN', 'middle', 'ROTATION', 90);
				case 1 % NNRegressorMLP_EvaluatorPF_Scatter.ELCLASS
					prop_default = 'NNRegressorMLP_EvaluatorPF_Scatter';
				case 2 % NNRegressorMLP_EvaluatorPF_Scatter.NAME
					prop_default = 'Scatter Plot Panel for an Evaluator with MLP Regressor';
				case 3 % NNRegressorMLP_EvaluatorPF_Scatter.DESCRIPTION
					prop_default = 'The scatter plot panel for an evaluator with a MLP regressor (NNRegressorMLP_EvaluatorPF_Scatter) manages the functionalities to plot a panel of the scatter plots in a regression task.';
				case 4 % NNRegressorMLP_EvaluatorPF_Scatter.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 5 % NNRegressorMLP_EvaluatorPF_Scatter.ID
					prop_default = 'NNRegressorMLP_EvaluatorPF_Scatter ID';
				case 6 % NNRegressorMLP_EvaluatorPF_Scatter.LABEL
					prop_default = 'NNRegressorMLP_EvaluatorPF_Scatter label';
				case 7 % NNRegressorMLP_EvaluatorPF_Scatter.NOTES
					prop_default = 'NNRegressorMLP_EvaluatorPF_Scatter notes';
				otherwise
					prop_default = getPropDefault@PanelFig(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNRegressorMLP_EvaluatorPF_Scatter.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorMLP_EvaluatorPF_Scatter.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNRegressorMLP_EvaluatorPF_Scatter, POINTER) returns the conditioned default value of POINTER of NNRegressorMLP_EvaluatorPF_Scatter.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(NNRegressorMLP_EvaluatorPF_Scatter, POINTER) returns the conditioned default value of POINTER of NNRegressorMLP_EvaluatorPF_Scatter.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('NNRegressorMLP_EvaluatorPF_Scatter')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNRegressorMLP_EvaluatorPF_Scatter.getPropProp(pointer);
			
			prop_default = NNRegressorMLP_EvaluatorPF_Scatter.conditioning(prop, NNRegressorMLP_EvaluatorPF_Scatter.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNRegressorMLP_EvaluatorPF_Scatter, PROP, VALUE) checks VALUE format for PROP of NNRegressorMLP_EvaluatorPF_Scatter.
			%  CHECK = PF.CHECKPROP(NNRegressorMLP_EvaluatorPF_Scatter, PROP, VALUE) checks VALUE format for PROP of NNRegressorMLP_EvaluatorPF_Scatter.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNRegressorMLP_EvaluatorPF_Scatter:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: BRAPH2:NNRegressorMLP_EvaluatorPF_Scatter:WrongInput
			%  Element.CHECKPROP(NNRegressorMLP_EvaluatorPF_Scatter, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorMLP_EvaluatorPF_Scatter.
			%   Error id: BRAPH2:NNRegressorMLP_EvaluatorPF_Scatter:WrongInput
			%  PF.CHECKPROP(NNRegressorMLP_EvaluatorPF_Scatter, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorMLP_EvaluatorPF_Scatter.
			%   Error id: BRAPH2:NNRegressorMLP_EvaluatorPF_Scatter:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('NNRegressorMLP_EvaluatorPF_Scatter')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNRegressorMLP_EvaluatorPF_Scatter.getPropProp(pointer);
			
			switch prop
				case 23 % NNRegressorMLP_EvaluatorPF_Scatter.H_AXES
					check = Format.checkFormat(18, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 24 % NNRegressorMLP_EvaluatorPF_Scatter.ST_AXIS
					check = Format.checkFormat(8, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 25 % NNRegressorMLP_EvaluatorPF_Scatter.LISTENER_ST_AXIS
					check = Format.checkFormat(18, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 26 % NNRegressorMLP_EvaluatorPF_Scatter.NNE
					check = Format.checkFormat(8, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 27 % NNRegressorMLP_EvaluatorPF_Scatter.PREDICTIONS_VALUE
					check = Format.checkFormat(14, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 28 % NNRegressorMLP_EvaluatorPF_Scatter.GROUNDTRUTH_VALUE
					check = Format.checkFormat(14, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 29 % NNRegressorMLP_EvaluatorPF_Scatter.SETUP
					check = Format.checkFormat(1, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 30 % NNRegressorMLP_EvaluatorPF_Scatter.H_PREDICTIONS
					check = Format.checkFormat(19, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 31 % NNRegressorMLP_EvaluatorPF_Scatter.PREDICTIONS
					check = Format.checkFormat(4, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 32 % NNRegressorMLP_EvaluatorPF_Scatter.PREDICTION_DICT
					check = Format.checkFormat(10, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 33 % NNRegressorMLP_EvaluatorPF_Scatter.H_LINE_BASE
					check = Format.checkFormat(18, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 34 % NNRegressorMLP_EvaluatorPF_Scatter.ST_LINE_BASE
					check = Format.checkFormat(8, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 35 % NNRegressorMLP_EvaluatorPF_Scatter.LISTENER_ST_LINE_BASE
					check = Format.checkFormat(18, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 36 % NNRegressorMLP_EvaluatorPF_Scatter.H_TITLE
					check = Format.checkFormat(18, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 37 % NNRegressorMLP_EvaluatorPF_Scatter.ST_TITLE
					check = Format.checkFormat(8, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 38 % NNRegressorMLP_EvaluatorPF_Scatter.H_XLABEL
					check = Format.checkFormat(18, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 39 % NNRegressorMLP_EvaluatorPF_Scatter.ST_XLABEL
					check = Format.checkFormat(8, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 40 % NNRegressorMLP_EvaluatorPF_Scatter.H_YLABEL
					check = Format.checkFormat(18, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 41 % NNRegressorMLP_EvaluatorPF_Scatter.ST_YLABEL
					check = Format.checkFormat(8, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				case 4 % NNRegressorMLP_EvaluatorPF_Scatter.TEMPLATE
					check = Format.checkFormat(8, value, NNRegressorMLP_EvaluatorPF_Scatter.getPropSettings(prop));
				otherwise
					if prop <= 22
						check = checkProp@PanelFig(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNRegressorMLP_EvaluatorPF_Scatter:' 'WrongInput'], ...
					['BRAPH2' ':NNRegressorMLP_EvaluatorPF_Scatter:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNRegressorMLP_EvaluatorPF_Scatter.getPropTag(prop) ' (' NNRegressorMLP_EvaluatorPF_Scatter.getFormatTag(NNRegressorMLP_EvaluatorPF_Scatter.getPropFormat(prop)) ').'] ...
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
				case 24 % NNRegressorMLP_EvaluatorPF_Scatter.ST_AXIS
					if pf.get('DRAWN')
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
					        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
					    end
					end
					
				case 31 % NNRegressorMLP_EvaluatorPF_Scatter.PREDICTIONS
					if ~pf.get('PREDICTIONS') % false
					    h_predictions = pf.get('H_PREDICTIONS');
					    for i = 1:1:length(h_predictions)
					        set(h_predictions{i}, 'Visible', false)
					    end
					else % true
					    % triggers the update of SPH_DICT
					    pf.set('PREDICTION_DICT', pf.get('PREDICTION_DICT'))
					end
					
					% update state of toggle tool
					toolbar = pf.get('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    set(findobj(toolbar, 'Tag', 'TOOL.Predictions'), 'State', pf.get('PREDICTIONS'))
					end
					
					pf.get('SETUP');
					
				case 32 % NNRegressorMLP_EvaluatorPF_Scatter.PREDICTION_DICT
					if pf.get('PREDICTIONS') && ~isa(pf.getr('NNE'), 'NoValue')
					    predictions = pf.memorize('PREDICTIONS_VALUE');
					    ground_truth = pf.memorize('GROUNDTRUTH_VALUE');
					    if ~isa(pf.memorize('NNE').getr('D'), 'NoValue')
					        targets = pf.memorize('NNE').get('D').get('DP_DICT').get('IT', 1).get('TARGET_IDS');
					    else
					        targets = {};
					    end
					    if pf.get('PREDICTION_DICT').get('LENGTH') == 0 && ~isempty(ground_truth)
					        for i = 1:1:length(targets)
					            target = targets{i};
					            prediction_st_lines{i} = SettingsLine( ...
					                'ID', target, ...
					                'X', ground_truth(:, i), ...
					                'Y', predictions(:, i), ...
					                'I', i, ...
					                'PANEL', pf, ...
					                'PROP', 30, ...
					                'LINESTYLE', 'none', ...
					                'VISIBLE', false ...
					                );
					        end
					        prediction_st_lines{1}.set('VISIBLE', true);
					        pf.get('PREDICTION_DICT').set('IT_LIST', prediction_st_lines)
					    end
					    for i = 1:1:length(targets)
					        pf.get('PREDICTION_DICT').get('IT', i).get('SETUP')
					    end
					end
					
				case 37 % NNRegressorMLP_EvaluatorPF_Scatter.ST_TITLE
					pf.get('SETUP');
					
				otherwise
					if prop <= 22
						postset@PanelFig(pf, prop);
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
				case 23 % NNRegressorMLP_EvaluatorPF_Scatter.H_AXES
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
					
				case 25 % NNRegressorMLP_EvaluatorPF_Scatter.LISTENER_ST_AXIS
					value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis);
					
				case 29 % NNRegressorMLP_EvaluatorPF_Scatter.SETUP
					pf.memorize('H_PREDICTIONS');
					
					nne = pf.get('NNE');
					if isa(pf.getr('PREDICTIONS_VALUE'), 'NoValue') && ~isa(pf.getr('NNE'), 'NoValue')
					    predictions = cell2mat(nne.get('NN').get('PREDICT', nne.get('D')));
					    pf.set('PREDICTIONS_VALUE', predictions);
					end
					
					if isa(pf.getr('GROUNDTRUTH_VALUE'), 'NoValue') && ~isa(pf.getr('NNE'), 'NoValue')
					    ground_truth = nne.get('GROUND_TRUTH');
					    pf.set('GROUNDTRUTH_VALUE', ground_truth);
					end
					
					predictions = pf.get('PREDICTIONS_VALUE');
					ground_truth = pf.get('GROUNDTRUTH_VALUE');
					
					pf.memorize('PREDICTION_DICT');
					
					if pf.get('PREDICTIONS')
					    pred_st_list = pf.get('PREDICTION_DICT').get('IT_LIST');
					    visible_status = find(cell2mat(cellfun(@(pred_st_line) pred_st_line.get('VISIBLE') , pred_st_list,'UniformOutput', false)) == 1);
					    if any(visible_status)
					        baseline_X = pred_st_list{visible_status(1)}.get('X');
					        baseline_Y = pred_st_list{visible_status(1)}.get('X');
					    else
					        baseline_X = [0];
					        baseline_Y = [0];
					    end
					    pf.memorize('ST_LINE_BASE').set('X', [min(baseline_X) max(baseline_X)], ...
					        'Y', [min(baseline_Y) max(baseline_Y)], ...
					        'SYMBOL', 'none', ...
					        'LINECOLOR', [0.8 0.8 0.8])
					end
					
					xlim = pf.get('H_AXES').get('XLim');
					ylim = pf.get('H_AXES').get('YLim');
					plot_title = nne.get('LABEL');
					pf.get('ST_TITLE').set( ...
					    'TXT', plot_title, ...
					    'X', .5 * (xlim(2) + xlim(1)), ...
					    'Y', ylim(2) + .07 * (ylim(2) - ylim(1)), ...
					    'Z', 0 ...
					    )
					pf.get('ST_XLABEL').set( ...
					    'TXT', 'Ground Truth', ...
					    'X', .5 * (xlim(2) + xlim(1)), ...
					    'Y', ylim(1) - .07 * (ylim(2) - ylim(1)), ...
					    'Z', 0 ...
					    )
					pf.get('ST_YLABEL').set( ...
						'TXT', 'Prediction', ...
					    'X', xlim(1) - .14 * (xlim(2) - xlim(1)), ...
					    'Y', .5 * (ylim(2) + ylim(1)), ...
					    'Z', 0 ...
					    )
					
					value = [];
					
				case 30 % NNRegressorMLP_EvaluatorPF_Scatter.H_PREDICTIONS
					if ~isa(pf.memorize('NNE').getr('D'), 'NoValue')
					    targets = pf.memorize('NNE').get('D').get('DP_DICT').get('IT', 1).get('TARGET_IDS');
					else
					    targets = {};
					end
					L = length(targets);
					h_predictions = cell(1, L);
					for i = 1:1:L
					    h_predictions{i} = plot(pf.get('H_AXES'), [0], [0], 'x');
					end
					value = h_predictions;
					
				case 33 % NNRegressorMLP_EvaluatorPF_Scatter.H_LINE_BASE
					value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);
					
				case 35 % NNRegressorMLP_EvaluatorPF_Scatter.LISTENER_ST_LINE_BASE
					value = listener(pf.get('ST_LINE_BASE'), 'PropSet', @cb_listener_st_line_base);
					
				case 36 % NNRegressorMLP_EvaluatorPF_Scatter.H_TITLE
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
					
				case 38 % NNRegressorMLP_EvaluatorPF_Scatter.H_XLABEL
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
					
				case 40 % NNRegressorMLP_EvaluatorPF_Scatter.H_YLABEL
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
					
				case 11 % NNRegressorMLP_EvaluatorPF_Scatter.DRAW
					value = calculateValue@PanelFig(pf, 11, varargin{:}); % also warning
					if value
					    pf.memorize('H_AXES')
					    
					    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', 23).get('SETUP')
					    pf.memorize('LISTENER_ST_AXIS');
					    
					    pf.memorize('H_PREDICTIONS')
					    
					    pf.memorize('H_LINE_BASE')
					    pf.memorize('ST_LINE_BASE').set('PANEL', pf, 'PROP', 33).get('SETUP')
						pf.memorize('LISTENER_ST_LINE_BASE');
					
					    pf.memorize('H_TITLE')
					    pf.memorize('ST_TITLE').set('PANEL', pf, 'PROP', 36).get('SETUP')
					
					    pf.memorize('H_XLABEL')
					    pf.memorize('ST_XLABEL').set('PANEL', pf, 'PROP', 38).get('SETUP')
					    
					    pf.memorize('H_YLABEL')
					    pf.memorize('ST_YLABEL').set('PANEL', pf, 'PROP', 40).get('SETUP')
					
					    pf.get('SETUP')
					end
					
				case 18 % NNRegressorMLP_EvaluatorPF_Scatter.DELETE
					value = calculateValue@PanelFig(pf, 18, varargin{:}); % also warning
					if value
					    pf.set('H_AXES', Element.getNoValue())
					
					    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
					 
					    pf.set('H_PREDICTIONS', Element.getNoValue())
					
					    pf.set('H_LINE_BASE', Element.getNoValue())
					    pf.set('LISTENER_ST_LINE_BASE', Element.getNoValue())
					
					    pf.set('H_TITLE', Element.getNoValue())
					
					    pf.set('H_XLABEL', Element.getNoValue())
					    
					    pf.set('H_YLABEL', Element.getNoValue())
					end
					
				case 22 % NNRegressorMLP_EvaluatorPF_Scatter.H_TOOLS
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
					    tool_predictions = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Predictions', ...
					        'State', pf.get('PREDICTIONS'), ...
					        'Tooltip', 'Show Prediction plots', ...
					        'CData', imresize(imread('icon_line.png'), [24 24]), ... % % % make icon 16x16
					        'OnCallback', {@cb_predictions, true}, ...
					        'OffCallback', {@cb_predictions, false});
					
					    % Base Line
					    tool_line_base = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Line_CI', ...
					        'State', pf.get('ST_LINE_BASE').get('VISIBLE'), ...
					        'Tooltip', 'Show base line (slope = 1)', ...
					        'CData', imresize(imread('icon_line.png'), [24 24]), ... % % % imread('icon_lines_two.png'), ...
					        'OnCallback', {@cb_line_base, true}, ...
					        'OffCallback', {@cb_line_base, false});
					
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_axis, tool_grid, ... 
					        tool_separator_2, ... 
					        tool_predictions, tool_line_base ...
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
			function cb_listener_st_line_base(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Line_Base'), 'State', pf.get('ST_LINE_BASE').get('VISIBLE'))
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
			function cb_predictions(~, ~, visible) % (src, event)
				pf.set('PREDICTIONS', visible)
			end
			function cb_line_base(~, ~, visible) % (src, event)
				pf.get('ST_LINE_BASE').set('VISIBLE', visible)
			
			    % triggers the update of ST_LINE_DIFF
			    pf.set('ST_LINE_BASE', pf.get('ST_LINE_BASE'))
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
				case 24 % NNRegressorMLP_EvaluatorPF_Scatter.ST_AXIS
					pr = SettingsAxisPP('EL', pf, 'PROP', 24, varargin{:});
					
				case 32 % NNRegressorMLP_EvaluatorPF_Scatter.PREDICTION_DICT
					SETUP = pf.getPropProp('SETUP');
					EL = PanelPropIDictTable.getPropProp('EL');
					pr = PanelPropIDictTable('EL', pf, 'PROP', 32, ...
					    'CB_TAB_EDIT', ['cb_table_edit_default(); pr.get(' num2str(EL) ').get(' num2str(SETUP) ')'], ...
					    'COLS', [-1 15 22 23 24 25], ...
					    varargin{:});
					
				case 34 % NNRegressorMLP_EvaluatorPF_Scatter.ST_LINE_BASE
					pr = SettingsLinePP('EL', pf, 'PROP', 34, varargin{:});
					
				case 37 % NNRegressorMLP_EvaluatorPF_Scatter.ST_TITLE
					pr = SettingsTextPP('EL', pf, 'PROP', 37, varargin{:});
					
				case 39 % NNRegressorMLP_EvaluatorPF_Scatter.ST_XLABEL
					pr = SettingsTextPP('EL', pf, 'PROP', 39, varargin{:});
					
				case 41 % NNRegressorMLP_EvaluatorPF_Scatter.ST_YLABEL
					pr = SettingsTextPP('EL', pf, 'PROP', 41, varargin{:});
					
				otherwise
					pr = getPanelProp@PanelFig(pf, prop, varargin{:});
					
			end
		end
	end
end
