classdef NNxMLP_FeatureImportanceAcrossMeasures < NNxMLP_FeatureImportance
	%NNxMLP_FeatureImportanceAcrossMeasures provides feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
	% It is a subclass of <a href="matlab:help NNxMLP_FeatureImportance">NNxMLP_FeatureImportance</a>.
	%
	% Neural Network Feature Importance Across Graph Measures (NNxMLP_FeatureImportanceAcrossMeasures) 
	%  assesses the importance of graph measures by measuring the increase in model error 
	%  when specific graph measure values are randomly shuffled.
	%
	% The list of NNxMLP_FeatureImportanceAcrossMeasures properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>D</strong> 	D (data, item) is the neural networks dataset for feature importance analysis.
	%  <strong>10</strong> <strong>NN</strong> 	NN (data, item) contains a trained neural network multi-layer perceptron classifier or regressor.
	%  <strong>11</strong> <strong>P</strong> 	P (parameter, scalar) is the permutation number that determines the statistical significance of the specific feature. 
	%  <strong>12</strong> <strong>PERM_SEEDS</strong> 	PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
	%  <strong>13</strong> <strong>APPLY_CONFIDENCE_INTERVALS</strong> 	APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.
	%  <strong>14</strong> <strong>SIG_LEVEL</strong> 	SIG_LEVEL (parameter, scalar) determines the significant level.
	%  <strong>15</strong> <strong>APPLY_BONFERRONI</strong> 	APPLY_BONFERRONI (parameter, logical) determines whether to apply Bonferroni correction.
	%  <strong>16</strong> <strong>BASELINE_INPUTS</strong> 	BASELINE_INPUTS (result, cell) retrieves the input data to be shuffled.
	%  <strong>17</strong> <strong>COMP_FEATURE_INDICES</strong> 	COMP_FEATURE_INDICES (result, cell) provides the indices of combined features, represented as a cell array containing sets of feature indices, such as {[1, 2], [2, 3], [1, 3]}.
	%  <strong>18</strong> <strong>D_SHUFFLED</strong> 	D_SHUFFLED (query, item) generates a shuffled version of the dataset where the features of given indexes are replaced with random values drawn from a distribution with the same mean and standard deviation as the orginal ones.
	%  <strong>19</strong> <strong>BASELINE_LOSS</strong> 	BASELINE_LOSS (result, scalar) is the loss value obtained from original dataset, acting as a baseline loss value for evaluating the feature importance.
	%  <strong>20</strong> <strong>SHUFFLED_LOSS</strong> 	SHUFFLED_LOSS (query, rvector) is the loss value obtained from shuffled datasets.
	%  <strong>21</strong> <strong>PERM_SHUFFLED_LOSS</strong> 	PERM_SHUFFLED_LOSS (result, cell) is the permutation test for obtaining shuffled loss for a number of times in order to establish confidence interval.
	%  <strong>22</strong> <strong>CONFIDENCE_INTERVALS</strong> 	CONFIDENCE_INTERVALS (query, rvector) derives the 95 percent of confidence interval for the permuation of shuffled loss values.
	%  <strong>23</strong> <strong>STAT_SIG_MASK</strong> 	STAT_SIG_MASK (result, rvector) provides the statistical significance mask for composite features indicating which composite features has significant contribution.
	%  <strong>24</strong> <strong>FEATURE_IMPORTANCE</strong> 	FEATURE_IMPORTANCE (result, cell) is determined by applying Bonferroni correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.
	%  <strong>25</strong> <strong>RESHAPED_FEATURE_IMPORTANCE</strong> 	RESHAPED_FEATURE_IMPORTANCE (query, empty) reshapes the cell of feature importances with the input data.
	%  <strong>26</strong> <strong>MAP_TO_CELL</strong> 	MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.
	%  <strong>27</strong> <strong>COUNT_ELEMENTS</strong> 	COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.
	%  <strong>28</strong> <strong>FLATTEN_CELL</strong> 	FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.
	%  <strong>29</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display permutation progress information.
	%  <strong>30</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
	%  <strong>31</strong> <strong>INTERRUPTIBLE</strong> 	INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.
	%  <strong>32</strong> <strong>INPUT_MASK</strong> 	INPUT_MASK (query, empty) creates a mask that covers the top-level index of interest in the input cell array, maintaining the same structure.
	%
	% NNxMLP_FeatureImportanceAcrossMeasures methods (constructor):
	%  NNxMLP_FeatureImportanceAcrossMeasures - constructor
	%
	% NNxMLP_FeatureImportanceAcrossMeasures methods:
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
	% NNxMLP_FeatureImportanceAcrossMeasures methods (display):
	%  tostring - string with information about the neural network feature importace for multi-layer perceptron
	%  disp - displays information about the neural network feature importace for multi-layer perceptron
	%  tree - displays the tree of the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceAcrossMeasures methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network feature importace for multi-layer perceptron are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceAcrossMeasures methods (save/load, Static):
	%  save - saves BRAPH2 neural network feature importace for multi-layer perceptron as b2 file
	%  load - loads a BRAPH2 neural network feature importace for multi-layer perceptron from a b2 file
	%
	% NNxMLP_FeatureImportanceAcrossMeasures method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceAcrossMeasures method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceAcrossMeasures methods (inspection, Static):
	%  getClass - returns the class of the neural network feature importace for multi-layer perceptron
	%  getSubclasses - returns all subclasses of NNxMLP_FeatureImportanceAcrossMeasures
	%  getProps - returns the property list of the neural network feature importace for multi-layer perceptron
	%  getPropNumber - returns the property number of the neural network feature importace for multi-layer perceptron
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
	% NNxMLP_FeatureImportanceAcrossMeasures methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNxMLP_FeatureImportanceAcrossMeasures methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNxMLP_FeatureImportanceAcrossMeasures methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNxMLP_FeatureImportanceAcrossMeasures methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNxMLP_FeatureImportanceAcrossMeasures; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNxMLP_FeatureImportanceAcrossMeasures constants</a>.
	%
	%
	% See also NNxMLP_FeatureImportance, NNDataPoint_Measure_CLA, NNDataPoint_Measure_REG.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		INPUT_MASK = 32; %CET: Computational Efficiency Trick
		INPUT_MASK_TAG = 'INPUT_MASK';
		INPUT_MASK_CATEGORY = 6;
		INPUT_MASK_FORMAT = 1;
	end
	methods % constructor
		function nnfiam = NNxMLP_FeatureImportanceAcrossMeasures(varargin)
			%NNxMLP_FeatureImportanceAcrossMeasures() creates a neural network feature importace for multi-layer perceptron.
			%
			% NNxMLP_FeatureImportanceAcrossMeasures(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNxMLP_FeatureImportanceAcrossMeasures(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNxMLP_FeatureImportanceAcrossMeasures properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>D</strong> 	D (data, item) is the neural networks dataset for feature importance analysis.
			%  <strong>10</strong> <strong>NN</strong> 	NN (data, item) contains a trained neural network multi-layer perceptron classifier or regressor.
			%  <strong>11</strong> <strong>P</strong> 	P (parameter, scalar) is the permutation number that determines the statistical significance of the specific feature. 
			%  <strong>12</strong> <strong>PERM_SEEDS</strong> 	PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
			%  <strong>13</strong> <strong>APPLY_CONFIDENCE_INTERVALS</strong> 	APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.
			%  <strong>14</strong> <strong>SIG_LEVEL</strong> 	SIG_LEVEL (parameter, scalar) determines the significant level.
			%  <strong>15</strong> <strong>APPLY_BONFERRONI</strong> 	APPLY_BONFERRONI (parameter, logical) determines whether to apply Bonferroni correction.
			%  <strong>16</strong> <strong>BASELINE_INPUTS</strong> 	BASELINE_INPUTS (result, cell) retrieves the input data to be shuffled.
			%  <strong>17</strong> <strong>COMP_FEATURE_INDICES</strong> 	COMP_FEATURE_INDICES (result, cell) provides the indices of combined features, represented as a cell array containing sets of feature indices, such as {[1, 2], [2, 3], [1, 3]}.
			%  <strong>18</strong> <strong>D_SHUFFLED</strong> 	D_SHUFFLED (query, item) generates a shuffled version of the dataset where the features of given indexes are replaced with random values drawn from a distribution with the same mean and standard deviation as the orginal ones.
			%  <strong>19</strong> <strong>BASELINE_LOSS</strong> 	BASELINE_LOSS (result, scalar) is the loss value obtained from original dataset, acting as a baseline loss value for evaluating the feature importance.
			%  <strong>20</strong> <strong>SHUFFLED_LOSS</strong> 	SHUFFLED_LOSS (query, rvector) is the loss value obtained from shuffled datasets.
			%  <strong>21</strong> <strong>PERM_SHUFFLED_LOSS</strong> 	PERM_SHUFFLED_LOSS (result, cell) is the permutation test for obtaining shuffled loss for a number of times in order to establish confidence interval.
			%  <strong>22</strong> <strong>CONFIDENCE_INTERVALS</strong> 	CONFIDENCE_INTERVALS (query, rvector) derives the 95 percent of confidence interval for the permuation of shuffled loss values.
			%  <strong>23</strong> <strong>STAT_SIG_MASK</strong> 	STAT_SIG_MASK (result, rvector) provides the statistical significance mask for composite features indicating which composite features has significant contribution.
			%  <strong>24</strong> <strong>FEATURE_IMPORTANCE</strong> 	FEATURE_IMPORTANCE (result, cell) is determined by applying Bonferroni correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.
			%  <strong>25</strong> <strong>RESHAPED_FEATURE_IMPORTANCE</strong> 	RESHAPED_FEATURE_IMPORTANCE (query, empty) reshapes the cell of feature importances with the input data.
			%  <strong>26</strong> <strong>MAP_TO_CELL</strong> 	MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.
			%  <strong>27</strong> <strong>COUNT_ELEMENTS</strong> 	COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.
			%  <strong>28</strong> <strong>FLATTEN_CELL</strong> 	FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.
			%  <strong>29</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display permutation progress information.
			%  <strong>30</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
			%  <strong>31</strong> <strong>INTERRUPTIBLE</strong> 	INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.
			%  <strong>32</strong> <strong>INPUT_MASK</strong> 	INPUT_MASK (query, empty) creates a mask that covers the top-level index of interest in the input cell array, maintaining the same structure.
			%
			% See also Category, Format.
			
			nnfiam = nnfiam@NNxMLP_FeatureImportance(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the neural network feature importace for multi-layer perceptron.
			%
			% BUILD = NNxMLP_FeatureImportanceAcrossMeasures.GETBUILD() returns the build of 'NNxMLP_FeatureImportanceAcrossMeasures'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NNFIAM.GETBUILD() returns the build of the neural network feature importace for multi-layer perceptron NNFIAM.
			%  BUILD = Element.GETBUILD(NNFIAM) returns the build of 'NNFIAM'.
			%  BUILD = Element.GETBUILD('NNxMLP_FeatureImportanceAcrossMeasures') returns the build of 'NNxMLP_FeatureImportanceAcrossMeasures'.
			%
			% Note that the Element.GETBUILD(NNFIAM) and Element.GETBUILD('NNxMLP_FeatureImportanceAcrossMeasures')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nnfiam_class = getClass()
			%GETCLASS returns the class of the neural network feature importace for multi-layer perceptron.
			%
			% CLASS = NNxMLP_FeatureImportanceAcrossMeasures.GETCLASS() returns the class 'NNxMLP_FeatureImportanceAcrossMeasures'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNFIAM.GETCLASS() returns the class of the neural network feature importace for multi-layer perceptron NNFIAM.
			%  CLASS = Element.GETCLASS(NNFIAM) returns the class of 'NNFIAM'.
			%  CLASS = Element.GETCLASS('NNxMLP_FeatureImportanceAcrossMeasures') returns 'NNxMLP_FeatureImportanceAcrossMeasures'.
			%
			% Note that the Element.GETCLASS(NNFIAM) and Element.GETCLASS('NNxMLP_FeatureImportanceAcrossMeasures')
			%  are less computationally efficient.
			
			nnfiam_class = 'NNxMLP_FeatureImportanceAcrossMeasures';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network feature importace for multi-layer perceptron.
			%
			% LIST = NNxMLP_FeatureImportanceAcrossMeasures.GETSUBCLASSES() returns all subclasses of 'NNxMLP_FeatureImportanceAcrossMeasures'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNFIAM.GETSUBCLASSES() returns all subclasses of the neural network feature importace for multi-layer perceptron NNFIAM.
			%  LIST = Element.GETSUBCLASSES(NNFIAM) returns all subclasses of 'NNFIAM'.
			%  LIST = Element.GETSUBCLASSES('NNxMLP_FeatureImportanceAcrossMeasures') returns all subclasses of 'NNxMLP_FeatureImportanceAcrossMeasures'.
			%
			% Note that the Element.GETSUBCLASSES(NNFIAM) and Element.GETSUBCLASSES('NNxMLP_FeatureImportanceAcrossMeasures')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNxMLP_FeatureImportanceAcrossMeasures' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network feature importace for multi-layer perceptron.
			%
			% PROPS = NNxMLP_FeatureImportanceAcrossMeasures.GETPROPS() returns the property list of neural network feature importace for multi-layer perceptron
			%  as a row vector.
			%
			% PROPS = NNxMLP_FeatureImportanceAcrossMeasures.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNFIAM.GETPROPS([CATEGORY]) returns the property list of the neural network feature importace for multi-layer perceptron NNFIAM.
			%  PROPS = Element.GETPROPS(NNFIAM[, CATEGORY]) returns the property list of 'NNFIAM'.
			%  PROPS = Element.GETPROPS('NNxMLP_FeatureImportanceAcrossMeasures'[, CATEGORY]) returns the property list of 'NNxMLP_FeatureImportanceAcrossMeasures'.
			%
			% Note that the Element.GETPROPS(NNFIAM) and Element.GETPROPS('NNxMLP_FeatureImportanceAcrossMeasures')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 11 13 14 15];
				case 4 % Category.DATA
					prop_list = [5 9 10];
				case 5 % Category.RESULT
					prop_list = [12 16 17 19 21 23 24];
				case 6 % Category.QUERY
					prop_list = [8 18 20 22 25 26 27 28 32];
				case 9 % Category.GUI
					prop_list = [29 30 31];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportanceAcrossMeasures.GETPROPNUMBER() returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportanceAcrossMeasures.GETPROPNUMBER(CATEGORY) returns the property number of neural network feature importace for multi-layer perceptron
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNFIAM.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network feature importace for multi-layer perceptron NNFIAM.
			%  N = Element.GETPROPNUMBER(NNFIAM) returns the property number of 'NNFIAM'.
			%  N = Element.GETPROPNUMBER('NNxMLP_FeatureImportanceAcrossMeasures') returns the property number of 'NNxMLP_FeatureImportanceAcrossMeasures'.
			%
			% Note that the Element.GETPROPNUMBER(NNFIAM) and Element.GETPROPNUMBER('NNxMLP_FeatureImportanceAcrossMeasures')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 32;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 5;
				case 4 % Category.DATA
					prop_number = 3;
				case 5 % Category.RESULT
					prop_number = 7;
				case 6 % Category.QUERY
					prop_number = 9;
				case 9 % Category.GUI
					prop_number = 3;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportanceAcrossMeasures.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFIAM.EXISTSPROP(PROP) checks whether PROP exists for NNFIAM.
			%  CHECK = Element.EXISTSPROP(NNFIAM, PROP) checks whether PROP exists for NNFIAM.
			%  CHECK = Element.EXISTSPROP(NNxMLP_FeatureImportanceAcrossMeasures, PROP) checks whether PROP exists for NNxMLP_FeatureImportanceAcrossMeasures.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFIAM.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNFIAM.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures:WrongInput]
			%  Element.EXISTSPROP(NNFIAM, PROP) throws error if PROP does NOT exist for NNFIAM.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures:WrongInput]
			%  Element.EXISTSPROP(NNxMLP_FeatureImportanceAcrossMeasures, PROP) throws error if PROP does NOT exist for NNxMLP_FeatureImportanceAcrossMeasures.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNFIAM) and Element.EXISTSPROP('NNxMLP_FeatureImportanceAcrossMeasures')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 32 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportanceAcrossMeasures:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportanceAcrossMeasures:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNxMLP_FeatureImportanceAcrossMeasures.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportanceAcrossMeasures.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFIAM.EXISTSTAG(TAG) checks whether TAG exists for NNFIAM.
			%  CHECK = Element.EXISTSTAG(NNFIAM, TAG) checks whether TAG exists for NNFIAM.
			%  CHECK = Element.EXISTSTAG(NNxMLP_FeatureImportanceAcrossMeasures, TAG) checks whether TAG exists for NNxMLP_FeatureImportanceAcrossMeasures.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFIAM.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNFIAM.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures:WrongInput]
			%  Element.EXISTSTAG(NNFIAM, TAG) throws error if TAG does NOT exist for NNFIAM.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures:WrongInput]
			%  Element.EXISTSTAG(NNxMLP_FeatureImportanceAcrossMeasures, TAG) throws error if TAG does NOT exist for NNxMLP_FeatureImportanceAcrossMeasures.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNFIAM) and Element.EXISTSTAG('NNxMLP_FeatureImportanceAcrossMeasures')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'NN'  'P'  'PERM_SEEDS'  'APPLY_CONFIDENCE_INTERVALS'  'SIG_LEVEL'  'APPLY_BONFERRONI'  'BASELINE_INPUTS'  'COMP_FEATURE_INDICES'  'D_SHUFFLED'  'BASELINE_LOSS'  'SHUFFLED_LOSS'  'PERM_SHUFFLED_LOSS'  'CONFIDENCE_INTERVALS'  'STAT_SIG_MASK'  'FEATURE_IMPORTANCE'  'RESHAPED_FEATURE_IMPORTANCE'  'MAP_TO_CELL'  'COUNT_ELEMENTS'  'FLATTEN_CELL'  'VERBOSE'  'WAITBAR'  'INTERRUPTIBLE'  'INPUT_MASK' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportanceAcrossMeasures:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportanceAcrossMeasures:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNxMLP_FeatureImportanceAcrossMeasures.'] ...
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
			%  PROPERTY = NNFIAM.GETPROPPROP(POINTER) returns property number of POINTER of NNFIAM.
			%  PROPERTY = Element.GETPROPPROP(NNxMLP_FeatureImportanceAcrossMeasures, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceAcrossMeasures.
			%  PROPERTY = NNFIAM.GETPROPPROP(NNxMLP_FeatureImportanceAcrossMeasures, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceAcrossMeasures.
			%
			% Note that the Element.GETPROPPROP(NNFIAM) and Element.GETPROPPROP('NNxMLP_FeatureImportanceAcrossMeasures')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'NN'  'P'  'PERM_SEEDS'  'APPLY_CONFIDENCE_INTERVALS'  'SIG_LEVEL'  'APPLY_BONFERRONI'  'BASELINE_INPUTS'  'COMP_FEATURE_INDICES'  'D_SHUFFLED'  'BASELINE_LOSS'  'SHUFFLED_LOSS'  'PERM_SHUFFLED_LOSS'  'CONFIDENCE_INTERVALS'  'STAT_SIG_MASK'  'FEATURE_IMPORTANCE'  'RESHAPED_FEATURE_IMPORTANCE'  'MAP_TO_CELL'  'COUNT_ELEMENTS'  'FLATTEN_CELL'  'VERBOSE'  'WAITBAR'  'INTERRUPTIBLE'  'INPUT_MASK' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = NNFIAM.GETPROPTAG(POINTER) returns tag of POINTER of NNFIAM.
			%  TAG = Element.GETPROPTAG(NNxMLP_FeatureImportanceAcrossMeasures, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceAcrossMeasures.
			%  TAG = NNFIAM.GETPROPTAG(NNxMLP_FeatureImportanceAcrossMeasures, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceAcrossMeasures.
			%
			% Note that the Element.GETPROPTAG(NNFIAM) and Element.GETPROPTAG('NNxMLP_FeatureImportanceAcrossMeasures')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnxmlp_featureimportanceacrossmeasures_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'NN'  'P'  'PERM_SEEDS'  'APPLY_CONFIDENCE_INTERVALS'  'SIG_LEVEL'  'APPLY_BONFERRONI'  'BASELINE_INPUTS'  'COMP_FEATURE_INDICES'  'D_SHUFFLED'  'BASELINE_LOSS'  'SHUFFLED_LOSS'  'PERM_SHUFFLED_LOSS'  'CONFIDENCE_INTERVALS'  'STAT_SIG_MASK'  'FEATURE_IMPORTANCE'  'RESHAPED_FEATURE_IMPORTANCE'  'MAP_TO_CELL'  'COUNT_ELEMENTS'  'FLATTEN_CELL'  'VERBOSE'  'WAITBAR'  'INTERRUPTIBLE'  'INPUT_MASK' };
				tag = nnxmlp_featureimportanceacrossmeasures_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = NNFIAM.GETPROPCATEGORY(POINTER) returns category of POINTER of NNFIAM.
			%  CATEGORY = Element.GETPROPCATEGORY(NNxMLP_FeatureImportanceAcrossMeasures, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceAcrossMeasures.
			%  CATEGORY = NNFIAM.GETPROPCATEGORY(NNxMLP_FeatureImportanceAcrossMeasures, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceAcrossMeasures.
			%
			% Note that the Element.GETPROPCATEGORY(NNFIAM) and Element.GETPROPCATEGORY('NNxMLP_FeatureImportanceAcrossMeasures')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossMeasures.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportanceacrossmeasures_category_list = { 1  1  1  3  4  2  2  6  4  4  3  5  3  3  3  5  5  6  5  6  5  6  5  5  6  6  6  6  9  9  9  6 };
			prop_category = nnxmlp_featureimportanceacrossmeasures_category_list{prop};
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
			%  FORMAT = NNFIAM.GETPROPFORMAT(POINTER) returns format of POINTER of NNFIAM.
			%  FORMAT = Element.GETPROPFORMAT(NNxMLP_FeatureImportanceAcrossMeasures, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceAcrossMeasures.
			%  FORMAT = NNFIAM.GETPROPFORMAT(NNxMLP_FeatureImportanceAcrossMeasures, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceAcrossMeasures.
			%
			% Note that the Element.GETPROPFORMAT(NNFIAM) and Element.GETPROPFORMAT('NNxMLP_FeatureImportanceAcrossMeasures')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossMeasures.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportanceacrossmeasures_format_list = { 2  2  2  8  2  2  2  2  8  8  11  12  4  11  4  16  16  8  11  12  16  12  12  16  1  1  1  1  4  4  11  1 };
			prop_format = nnxmlp_featureimportanceacrossmeasures_format_list{prop};
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
			%  DESCRIPTION = NNFIAM.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNFIAM.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceAcrossMeasures, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceAcrossMeasures.
			%  DESCRIPTION = NNFIAM.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceAcrossMeasures, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceAcrossMeasures.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNFIAM) and Element.GETPROPDESCRIPTION('NNxMLP_FeatureImportanceAcrossMeasures')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossMeasures.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportanceacrossmeasures_description_list = { 'ELCLASS (constant, string) is the class of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.'  'NAME (constant, string) is the name of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.'  'DESCRIPTION (constant, string) is the description of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.'  'TEMPLATE (parameter, item) is the template of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.'  'ID (data, string) is a few-letter code of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.'  'LABEL (metadata, string) is an extended label of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.'  'NOTES (metadata, string) are some specific notes about the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'D (data, item) is the neural networks dataset for feature importance analysis.'  'NN (data, item) contains a trained neural network multi-layer perceptron classifier or regressor.'  'P (parameter, scalar) is the permutation number that determines the statistical significance of the specific feature. '  'PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.'  'APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.'  'SIG_LEVEL (parameter, scalar) determines the significant level.'  'APPLY_BONFERRONI (parameter, logical) determines whether to apply Bonferroni correction.'  'BASELINE_INPUTS (result, cell) retrieves the input data to be shuffled.'  'COMP_FEATURE_INDICES (result, cell) provides the indices of combined features, represented as a cell array containing sets of feature indices, such as {[1, 2], [2, 3], [1, 3]}.'  'D_SHUFFLED (query, item) generates a shuffled version of the dataset where the features of given indexes are replaced with random values drawn from a distribution with the same mean and standard deviation as the orginal ones.'  'BASELINE_LOSS (result, scalar) is the loss value obtained from original dataset, acting as a baseline loss value for evaluating the feature importance.'  'SHUFFLED_LOSS (query, rvector) is the loss value obtained from shuffled datasets.'  'PERM_SHUFFLED_LOSS (result, cell) is the permutation test for obtaining shuffled loss for a number of times in order to establish confidence interval.'  'CONFIDENCE_INTERVALS (query, rvector) derives the 95 percent of confidence interval for the permuation of shuffled loss values.'  'STAT_SIG_MASK (result, rvector) provides the statistical significance mask for composite features indicating which composite features has significant contribution.'  'FEATURE_IMPORTANCE (result, cell) is determined by applying Bonferroni correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.'  'RESHAPED_FEATURE_IMPORTANCE (query, empty) reshapes the cell of feature importances with the input data.'  'MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.'  'COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.'  'FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.'  'VERBOSE (gui, logical) is an indicator to display permutation progress information.'  'WAITBAR (gui, logical) determines whether to show the waitbar.'  'INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.'  'INPUT_MASK (query, empty) creates a mask that covers the top-level index of interest in the input cell array, maintaining the same structure.' };
			prop_description = nnxmlp_featureimportanceacrossmeasures_description_list{prop};
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
			%  SETTINGS = NNFIAM.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNFIAM.
			%  SETTINGS = Element.GETPROPSETTINGS(NNxMLP_FeatureImportanceAcrossMeasures, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceAcrossMeasures.
			%  SETTINGS = NNFIAM.GETPROPSETTINGS(NNxMLP_FeatureImportanceAcrossMeasures, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceAcrossMeasures.
			%
			% Note that the Element.GETPROPSETTINGS(NNFIAM) and Element.GETPROPSETTINGS('NNxMLP_FeatureImportanceAcrossMeasures')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossMeasures.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 32 % NNxMLP_FeatureImportanceAcrossMeasures.INPUT_MASK
					prop_settings = Format.getFormatSettings(1);
				case 4 % NNxMLP_FeatureImportanceAcrossMeasures.TEMPLATE
					prop_settings = 'NNxMLP_FeatureImportanceAcrossMeasures';
				otherwise
					prop_settings = getPropSettings@NNxMLP_FeatureImportance(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceAcrossMeasures.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceAcrossMeasures.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFIAM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNFIAM.
			%  DEFAULT = Element.GETPROPDEFAULT(NNxMLP_FeatureImportanceAcrossMeasures, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceAcrossMeasures.
			%  DEFAULT = NNFIAM.GETPROPDEFAULT(NNxMLP_FeatureImportanceAcrossMeasures, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceAcrossMeasures.
			%
			% Note that the Element.GETPROPDEFAULT(NNFIAM) and Element.GETPROPDEFAULT('NNxMLP_FeatureImportanceAcrossMeasures')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossMeasures.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 32 % NNxMLP_FeatureImportanceAcrossMeasures.INPUT_MASK
					prop_default = Format.getFormatDefault(1, NNxMLP_FeatureImportanceAcrossMeasures.getPropSettings(prop));
				case 1 % NNxMLP_FeatureImportanceAcrossMeasures.ELCLASS
					prop_default = 'NNxMLP_FeatureImportanceAcrossMeasures';
				case 2 % NNxMLP_FeatureImportanceAcrossMeasures.NAME
					prop_default = 'Feature Importace for Multi-layer Perceptron Across Graph Measures';
				case 3 % NNxMLP_FeatureImportanceAcrossMeasures.DESCRIPTION
					prop_default = 'Neural Network Feature Importance Across Graph Measures (NNxMLP_FeatureImportanceAcrossMeasures) assesses the importance of graph measures by measuring the increase in model error when specific graph measure values are randomly shuffled.';
				case 4 % NNxMLP_FeatureImportanceAcrossMeasures.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNxMLP_FeatureImportanceAcrossMeasures.getPropSettings(prop));
				case 5 % NNxMLP_FeatureImportanceAcrossMeasures.ID
					prop_default = 'NNxMLP_FeatureImportanceAcrossMeasures ID';
				case 6 % NNxMLP_FeatureImportanceAcrossMeasures.LABEL
					prop_default = 'NNxMLP_FeatureImportanceAcrossMeasures label';
				case 7 % NNxMLP_FeatureImportanceAcrossMeasures.NOTES
					prop_default = 'NNxMLP_FeatureImportanceAcrossMeasures notes';
				otherwise
					prop_default = getPropDefault@NNxMLP_FeatureImportance(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceAcrossMeasures.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceAcrossMeasures.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFIAM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNFIAM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceAcrossMeasures, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceAcrossMeasures.
			%  DEFAULT = NNFIAM.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceAcrossMeasures, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceAcrossMeasures.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNFIAM) and Element.GETPROPDEFAULTCONDITIONED('NNxMLP_FeatureImportanceAcrossMeasures')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossMeasures.getPropProp(pointer);
			
			prop_default = NNxMLP_FeatureImportanceAcrossMeasures.conditioning(prop, NNxMLP_FeatureImportanceAcrossMeasures.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNFIAM.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNFIAM.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNFIAM.
			%  CHECK = Element.CHECKPROP(NNxMLP_FeatureImportanceAcrossMeasures, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceAcrossMeasures.
			%  CHECK = NNFIAM.CHECKPROP(NNxMLP_FeatureImportanceAcrossMeasures, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceAcrossMeasures.
			% 
			% NNFIAM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNFIAM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNFIAM.
			%   Error id: BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures:WrongInput
			%  Element.CHECKPROP(NNxMLP_FeatureImportanceAcrossMeasures, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceAcrossMeasures.
			%   Error id: BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures:WrongInput
			%  NNFIAM.CHECKPROP(NNxMLP_FeatureImportanceAcrossMeasures, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceAcrossMeasures.
			%   Error id: BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NNFIAM) and Element.CHECKPROP('NNxMLP_FeatureImportanceAcrossMeasures')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNxMLP_FeatureImportanceAcrossMeasures.getPropProp(pointer);
			
			switch prop
				case 32 % NNxMLP_FeatureImportanceAcrossMeasures.INPUT_MASK
					check = Format.checkFormat(1, value, NNxMLP_FeatureImportanceAcrossMeasures.getPropSettings(prop));
				case 4 % NNxMLP_FeatureImportanceAcrossMeasures.TEMPLATE
					check = Format.checkFormat(8, value, NNxMLP_FeatureImportanceAcrossMeasures.getPropSettings(prop));
				otherwise
					if prop <= 31
						check = checkProp@NNxMLP_FeatureImportance(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportanceAcrossMeasures:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportanceAcrossMeasures:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNxMLP_FeatureImportanceAcrossMeasures.getPropTag(prop) ' (' NNxMLP_FeatureImportanceAcrossMeasures.getFormatTag(NNxMLP_FeatureImportanceAcrossMeasures.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nnfiam, prop, varargin)
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
				case 32 % NNxMLP_FeatureImportanceAcrossMeasures.INPUT_MASK
					if isempty(varargin)
					    value = {};
					    return
					end
					cell_array = varargin{1};
					index = varargin{2};
					current_level = varargin{3};
					mask = cell(size(cell_array));
					
					for i = 1:length(cell_array)
					    if iscell(cell_array{i})
					        if ismember(i, index)
					            index_for_cell = 1:1:length(cell_array{i});
					        else
					            index_for_cell = 0;
					        end
					        mask{i} = NNxMLP_FeatureImportanceAcrossMeasures().get('INPUT_MASK' ,cell_array{i}, index_for_cell, current_level + 1);
					    else
					        if ismember(i, index)
					            mask{i} = ones(size(cell_array{i}));
					        else
					            mask{i} = zeros(size(cell_array{i}));
					        end
					    end
					end
					value = mask;
					
				case 17 % NNxMLP_FeatureImportanceAcrossMeasures.COMP_FEATURE_INDICES
					rng_settings_ = rng(); rng(nnfiam.getPropSeed(17), 'twister')
					
					input_dataset = nnfiam.get('D');
					if isa(input_dataset.getr('DP_DICT'), 'NoValue')
					    value = {};
					    return
					end
					m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
					example_input_cell = input_dataset.get('DP_DICT').get('IT', 1).get('INPUT');
					for i = 1:length(m_list)
					    single_measure_indexes = nnfiam.get('INPUT_MASK', example_input_cell, i, 1);
					    flattened_indexes = nnfiam.get('FLATTEN_CELL', single_measure_indexes);
					    comp_feature_indices{i} = find(flattened_indexes);
					end
					
					value = comp_feature_indices;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 31
						value = calculateValue@NNxMLP_FeatureImportance(nnfiam, prop, varargin{:});
					else
						value = calculateValue@Element(nnfiam, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(nnfiam, prop, varargin)
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
				case 24 % NNxMLP_FeatureImportanceAcrossMeasures.FEATURE_IMPORTANCE
					input_dataset = nnfiam.get('D');
					m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
					pr = PanelPropCell('EL', nnfiam, 'PROP', 24, ...
					    'TABLE_HEIGHT', 480, ...
					    'ROWNAME', {}, ...
					    'COLUMNNAME', m_list, ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@NNxMLP_FeatureImportance(nnfiam, prop, varargin{:});
					
			end
		end
	end
end
