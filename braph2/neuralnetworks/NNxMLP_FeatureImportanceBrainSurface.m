classdef NNxMLP_FeatureImportanceBrainSurface < NNxMLP_FeatureImportance
	%NNxMLP_FeatureImportanceBrainSurface manages the visuazation of the feature importance on the brain surface within neural network evaluators.
	% It is a subclass of <a href="matlab:help NNxMLP_FeatureImportance">NNxMLP_FeatureImportance</a>.
	%
	% A neural network feature importace for multi-layer perceptron for visualizing on brain surface (NNxMLP_FeatureImportanceBrainSurface) 
	%  assesses the importance of features and visualizes on a brain surface. 
	% It introduces the permutation method to establish the significance of each feature (or composite features) by comparing the 
	%  original model loss to the distribution of losses obtained from several shuffled iterations, providing a robust statistical 
	%  analysis of feature importance using a user-defined confidence interval and adjusting for multiple comparisons with the Bonferroni correction.
	%
	% The list of NNxMLP_FeatureImportanceBrainSurface properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about managing the visuazation of the neural network feature importance on the brain surface.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>D</strong> 	D (data, item) is the neural networks dataset for feature importance analysis.
	%  <strong>10</strong> <strong>NN</strong> 	NN (data, item) contains a trained neural network multi-layer perceptron classifier or regressor.
	%  <strong>11</strong> <strong>P</strong> 	P (parameter, scalar) is the permutation number that determines the statistical significance of the specific feature. 
	%  <strong>12</strong> <strong>PERM_SEEDS</strong> 	PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
	%  <strong>13</strong> <strong>APPLY_CONFIDENCE_INTERVALS</strong> 	APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.
	%  <strong>14</strong> <strong>SIG_LEVEL</strong> 	SIG_LEVEL (parameter, scalar) determines the significant level.
	%  <strong>15</strong> <strong>APPLY_BONFERRONI</strong> 	APPLY_BONFERRONI (parameter, logical) determines whether to apply Bonferroni correction.
	%  <strong>16</strong> <strong>BASELINE_INPUTS</strong> 	BASELINE_INPUTS (result, cell) retrieves the input data to be shuffled.
	%  <strong>17</strong> <strong>COMP_FEATURE_INDICES</strong> 	COMP_FEATURE_INDICES (result, cell) provides the indices of combined features, represented as a cell array containing sets of feature indices, such as {[1], [2], [3]} by default, or {[1, 2], [2, 3], [1, 3]}.
	%  <strong>18</strong> <strong>D_SHUFFLED</strong> 	D_SHUFFLED (query, item) generates a shuffled version of the dataset where the features of given indexes are replaced with random values drawn from a distribution with the same mean and standard deviation as the orginal ones.
	%  <strong>19</strong> <strong>BASELINE_LOSS</strong> 	BASELINE_LOSS (result, scalar) is the loss value obtained from original dataset, acting as a baseline loss value for evaluating the feature importance.
	%  <strong>20</strong> <strong>SHUFFLED_LOSS</strong> 	SHUFFLED_LOSS (query, rvector) is the loss value obtained from shuffled datasets.
	%  <strong>21</strong> <strong>PERM_SHUFFLED_LOSS</strong> 	PERM_SHUFFLED_LOSS (result, cell) is the permutation test for obtaining shuffled loss for a number of times in order to establish confidence interval.
	%  <strong>22</strong> <strong>CONFIDENCE_INTERVALS</strong> 	CONFIDENCE_INTERVALS (query, rvector) derives the 95 percent of confidence interval for the permuation of shuffled loss values.
	%  <strong>23</strong> <strong>STAT_SIG_MASK</strong> 	STAT_SIG_MASK (result, rvector) provides the statistical significance mask for composite features indicating which composite features has significant contribution.
	%  <strong>24</strong> <strong>FEATURE_IMPORTANCE</strong> 	FEATURE_IMPORTANCE (result, cell) is determined by obtaining the average value from the feature importance element list.
	%  <strong>25</strong> <strong>RESHAPED_FEATURE_IMPORTANCE</strong> 	RESHAPED_FEATURE_IMPORTANCE (query, empty) reshapes the cell of feature importances with the input data.
	%  <strong>26</strong> <strong>MAP_TO_CELL</strong> 	MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.
	%  <strong>27</strong> <strong>COUNT_ELEMENTS</strong> 	COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.
	%  <strong>28</strong> <strong>FLATTEN_CELL</strong> 	FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.
	%  <strong>29</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display permutation progress information.
	%  <strong>30</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
	%  <strong>31</strong> <strong>INTERRUPTIBLE</strong> 	INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.
	%  <strong>32</strong> <strong>BA</strong> 	BA (parameter, item) is the brain atlas.
	%
	% NNxMLP_FeatureImportanceBrainSurface methods (constructor):
	%  NNxMLP_FeatureImportanceBrainSurface - constructor
	%
	% NNxMLP_FeatureImportanceBrainSurface methods:
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
	% NNxMLP_FeatureImportanceBrainSurface methods (display):
	%  tostring - string with information about the neural network feature importace for multi-layer perceptron
	%  disp - displays information about the neural network feature importace for multi-layer perceptron
	%  tree - displays the tree of the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceBrainSurface methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network feature importace for multi-layer perceptron are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceBrainSurface methods (save/load, Static):
	%  save - saves BRAPH2 neural network feature importace for multi-layer perceptron as b2 file
	%  load - loads a BRAPH2 neural network feature importace for multi-layer perceptron from a b2 file
	%
	% NNxMLP_FeatureImportanceBrainSurface method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceBrainSurface method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceBrainSurface methods (inspection, Static):
	%  getClass - returns the class of the neural network feature importace for multi-layer perceptron
	%  getSubclasses - returns all subclasses of NNxMLP_FeatureImportanceBrainSurface
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
	% NNxMLP_FeatureImportanceBrainSurface methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNxMLP_FeatureImportanceBrainSurface methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNxMLP_FeatureImportanceBrainSurface methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNxMLP_FeatureImportanceBrainSurface methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNxMLP_FeatureImportanceBrainSurface; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNxMLP_FeatureImportanceBrainSurface constants</a>.
	%
	%
	% See also NNxMLP_FeatureImportance, NNxMLP_FeatureImportanceAcrossMeasures.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		BA = 32; %CET: Computational Efficiency Trick
		BA_TAG = 'BA';
		BA_CATEGORY = 3;
		BA_FORMAT = 8;
	end
	methods % constructor
		function nnfib = NNxMLP_FeatureImportanceBrainSurface(varargin)
			%NNxMLP_FeatureImportanceBrainSurface() creates a neural network feature importace for multi-layer perceptron.
			%
			% NNxMLP_FeatureImportanceBrainSurface(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNxMLP_FeatureImportanceBrainSurface(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNxMLP_FeatureImportanceBrainSurface properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about managing the visuazation of the neural network feature importance on the brain surface.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>D</strong> 	D (data, item) is the neural networks dataset for feature importance analysis.
			%  <strong>10</strong> <strong>NN</strong> 	NN (data, item) contains a trained neural network multi-layer perceptron classifier or regressor.
			%  <strong>11</strong> <strong>P</strong> 	P (parameter, scalar) is the permutation number that determines the statistical significance of the specific feature. 
			%  <strong>12</strong> <strong>PERM_SEEDS</strong> 	PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
			%  <strong>13</strong> <strong>APPLY_CONFIDENCE_INTERVALS</strong> 	APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.
			%  <strong>14</strong> <strong>SIG_LEVEL</strong> 	SIG_LEVEL (parameter, scalar) determines the significant level.
			%  <strong>15</strong> <strong>APPLY_BONFERRONI</strong> 	APPLY_BONFERRONI (parameter, logical) determines whether to apply Bonferroni correction.
			%  <strong>16</strong> <strong>BASELINE_INPUTS</strong> 	BASELINE_INPUTS (result, cell) retrieves the input data to be shuffled.
			%  <strong>17</strong> <strong>COMP_FEATURE_INDICES</strong> 	COMP_FEATURE_INDICES (result, cell) provides the indices of combined features, represented as a cell array containing sets of feature indices, such as {[1], [2], [3]} by default, or {[1, 2], [2, 3], [1, 3]}.
			%  <strong>18</strong> <strong>D_SHUFFLED</strong> 	D_SHUFFLED (query, item) generates a shuffled version of the dataset where the features of given indexes are replaced with random values drawn from a distribution with the same mean and standard deviation as the orginal ones.
			%  <strong>19</strong> <strong>BASELINE_LOSS</strong> 	BASELINE_LOSS (result, scalar) is the loss value obtained from original dataset, acting as a baseline loss value for evaluating the feature importance.
			%  <strong>20</strong> <strong>SHUFFLED_LOSS</strong> 	SHUFFLED_LOSS (query, rvector) is the loss value obtained from shuffled datasets.
			%  <strong>21</strong> <strong>PERM_SHUFFLED_LOSS</strong> 	PERM_SHUFFLED_LOSS (result, cell) is the permutation test for obtaining shuffled loss for a number of times in order to establish confidence interval.
			%  <strong>22</strong> <strong>CONFIDENCE_INTERVALS</strong> 	CONFIDENCE_INTERVALS (query, rvector) derives the 95 percent of confidence interval for the permuation of shuffled loss values.
			%  <strong>23</strong> <strong>STAT_SIG_MASK</strong> 	STAT_SIG_MASK (result, rvector) provides the statistical significance mask for composite features indicating which composite features has significant contribution.
			%  <strong>24</strong> <strong>FEATURE_IMPORTANCE</strong> 	FEATURE_IMPORTANCE (result, cell) is determined by obtaining the average value from the feature importance element list.
			%  <strong>25</strong> <strong>RESHAPED_FEATURE_IMPORTANCE</strong> 	RESHAPED_FEATURE_IMPORTANCE (query, empty) reshapes the cell of feature importances with the input data.
			%  <strong>26</strong> <strong>MAP_TO_CELL</strong> 	MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.
			%  <strong>27</strong> <strong>COUNT_ELEMENTS</strong> 	COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.
			%  <strong>28</strong> <strong>FLATTEN_CELL</strong> 	FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.
			%  <strong>29</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display permutation progress information.
			%  <strong>30</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
			%  <strong>31</strong> <strong>INTERRUPTIBLE</strong> 	INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.
			%  <strong>32</strong> <strong>BA</strong> 	BA (parameter, item) is the brain atlas.
			%
			% See also Category, Format.
			
			nnfib = nnfib@NNxMLP_FeatureImportance(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the neural network feature importace for multi-layer perceptron.
			%
			% BUILD = NNxMLP_FeatureImportanceBrainSurface.GETBUILD() returns the build of 'NNxMLP_FeatureImportanceBrainSurface'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NNFIB.GETBUILD() returns the build of the neural network feature importace for multi-layer perceptron NNFIB.
			%  BUILD = Element.GETBUILD(NNFIB) returns the build of 'NNFIB'.
			%  BUILD = Element.GETBUILD('NNxMLP_FeatureImportanceBrainSurface') returns the build of 'NNxMLP_FeatureImportanceBrainSurface'.
			%
			% Note that the Element.GETBUILD(NNFIB) and Element.GETBUILD('NNxMLP_FeatureImportanceBrainSurface')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nnfib_class = getClass()
			%GETCLASS returns the class of the neural network feature importace for multi-layer perceptron.
			%
			% CLASS = NNxMLP_FeatureImportanceBrainSurface.GETCLASS() returns the class 'NNxMLP_FeatureImportanceBrainSurface'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNFIB.GETCLASS() returns the class of the neural network feature importace for multi-layer perceptron NNFIB.
			%  CLASS = Element.GETCLASS(NNFIB) returns the class of 'NNFIB'.
			%  CLASS = Element.GETCLASS('NNxMLP_FeatureImportanceBrainSurface') returns 'NNxMLP_FeatureImportanceBrainSurface'.
			%
			% Note that the Element.GETCLASS(NNFIB) and Element.GETCLASS('NNxMLP_FeatureImportanceBrainSurface')
			%  are less computationally efficient.
			
			nnfib_class = 'NNxMLP_FeatureImportanceBrainSurface';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network feature importace for multi-layer perceptron.
			%
			% LIST = NNxMLP_FeatureImportanceBrainSurface.GETSUBCLASSES() returns all subclasses of 'NNxMLP_FeatureImportanceBrainSurface'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNFIB.GETSUBCLASSES() returns all subclasses of the neural network feature importace for multi-layer perceptron NNFIB.
			%  LIST = Element.GETSUBCLASSES(NNFIB) returns all subclasses of 'NNFIB'.
			%  LIST = Element.GETSUBCLASSES('NNxMLP_FeatureImportanceBrainSurface') returns all subclasses of 'NNxMLP_FeatureImportanceBrainSurface'.
			%
			% Note that the Element.GETSUBCLASSES(NNFIB) and Element.GETSUBCLASSES('NNxMLP_FeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNxMLP_FeatureImportanceBrainSurface' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network feature importace for multi-layer perceptron.
			%
			% PROPS = NNxMLP_FeatureImportanceBrainSurface.GETPROPS() returns the property list of neural network feature importace for multi-layer perceptron
			%  as a row vector.
			%
			% PROPS = NNxMLP_FeatureImportanceBrainSurface.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNFIB.GETPROPS([CATEGORY]) returns the property list of the neural network feature importace for multi-layer perceptron NNFIB.
			%  PROPS = Element.GETPROPS(NNFIB[, CATEGORY]) returns the property list of 'NNFIB'.
			%  PROPS = Element.GETPROPS('NNxMLP_FeatureImportanceBrainSurface'[, CATEGORY]) returns the property list of 'NNxMLP_FeatureImportanceBrainSurface'.
			%
			% Note that the Element.GETPROPS(NNFIB) and Element.GETPROPS('NNxMLP_FeatureImportanceBrainSurface')
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
					prop_list = [4 11 13 14 15 32];
				case 4 % Category.DATA
					prop_list = [5 9 10];
				case 5 % Category.RESULT
					prop_list = [12 16 17 19 21 23 24];
				case 6 % Category.QUERY
					prop_list = [8 18 20 22 25 26 27 28];
				case 9 % Category.GUI
					prop_list = [29 30 31];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportanceBrainSurface.GETPROPNUMBER() returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportanceBrainSurface.GETPROPNUMBER(CATEGORY) returns the property number of neural network feature importace for multi-layer perceptron
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNFIB.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network feature importace for multi-layer perceptron NNFIB.
			%  N = Element.GETPROPNUMBER(NNFIB) returns the property number of 'NNFIB'.
			%  N = Element.GETPROPNUMBER('NNxMLP_FeatureImportanceBrainSurface') returns the property number of 'NNxMLP_FeatureImportanceBrainSurface'.
			%
			% Note that the Element.GETPROPNUMBER(NNFIB) and Element.GETPROPNUMBER('NNxMLP_FeatureImportanceBrainSurface')
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
					prop_number = 6;
				case 4 % Category.DATA
					prop_number = 3;
				case 5 % Category.RESULT
					prop_number = 7;
				case 6 % Category.QUERY
					prop_number = 8;
				case 9 % Category.GUI
					prop_number = 3;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportanceBrainSurface.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFIB.EXISTSPROP(PROP) checks whether PROP exists for NNFIB.
			%  CHECK = Element.EXISTSPROP(NNFIB, PROP) checks whether PROP exists for NNFIB.
			%  CHECK = Element.EXISTSPROP(NNxMLP_FeatureImportanceBrainSurface, PROP) checks whether PROP exists for NNxMLP_FeatureImportanceBrainSurface.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFIB.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNFIB.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface:WrongInput]
			%  Element.EXISTSPROP(NNFIB, PROP) throws error if PROP does NOT exist for NNFIB.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface:WrongInput]
			%  Element.EXISTSPROP(NNxMLP_FeatureImportanceBrainSurface, PROP) throws error if PROP does NOT exist for NNxMLP_FeatureImportanceBrainSurface.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNFIB) and Element.EXISTSPROP('NNxMLP_FeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 32 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurface:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurface:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNxMLP_FeatureImportanceBrainSurface.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportanceBrainSurface.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFIB.EXISTSTAG(TAG) checks whether TAG exists for NNFIB.
			%  CHECK = Element.EXISTSTAG(NNFIB, TAG) checks whether TAG exists for NNFIB.
			%  CHECK = Element.EXISTSTAG(NNxMLP_FeatureImportanceBrainSurface, TAG) checks whether TAG exists for NNxMLP_FeatureImportanceBrainSurface.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFIB.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNFIB.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface:WrongInput]
			%  Element.EXISTSTAG(NNFIB, TAG) throws error if TAG does NOT exist for NNFIB.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface:WrongInput]
			%  Element.EXISTSTAG(NNxMLP_FeatureImportanceBrainSurface, TAG) throws error if TAG does NOT exist for NNxMLP_FeatureImportanceBrainSurface.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNFIB) and Element.EXISTSTAG('NNxMLP_FeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'NN'  'P'  'PERM_SEEDS'  'APPLY_CONFIDENCE_INTERVALS'  'SIG_LEVEL'  'APPLY_BONFERRONI'  'BASELINE_INPUTS'  'COMP_FEATURE_INDICES'  'D_SHUFFLED'  'BASELINE_LOSS'  'SHUFFLED_LOSS'  'PERM_SHUFFLED_LOSS'  'CONFIDENCE_INTERVALS'  'STAT_SIG_MASK'  'FEATURE_IMPORTANCE'  'RESHAPED_FEATURE_IMPORTANCE'  'MAP_TO_CELL'  'COUNT_ELEMENTS'  'FLATTEN_CELL'  'VERBOSE'  'WAITBAR'  'INTERRUPTIBLE'  'BA' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurface:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurface:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNxMLP_FeatureImportanceBrainSurface.'] ...
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
			%  PROPERTY = NNFIB.GETPROPPROP(POINTER) returns property number of POINTER of NNFIB.
			%  PROPERTY = Element.GETPROPPROP(NNxMLP_FeatureImportanceBrainSurface, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceBrainSurface.
			%  PROPERTY = NNFIB.GETPROPPROP(NNxMLP_FeatureImportanceBrainSurface, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceBrainSurface.
			%
			% Note that the Element.GETPROPPROP(NNFIB) and Element.GETPROPPROP('NNxMLP_FeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'NN'  'P'  'PERM_SEEDS'  'APPLY_CONFIDENCE_INTERVALS'  'SIG_LEVEL'  'APPLY_BONFERRONI'  'BASELINE_INPUTS'  'COMP_FEATURE_INDICES'  'D_SHUFFLED'  'BASELINE_LOSS'  'SHUFFLED_LOSS'  'PERM_SHUFFLED_LOSS'  'CONFIDENCE_INTERVALS'  'STAT_SIG_MASK'  'FEATURE_IMPORTANCE'  'RESHAPED_FEATURE_IMPORTANCE'  'MAP_TO_CELL'  'COUNT_ELEMENTS'  'FLATTEN_CELL'  'VERBOSE'  'WAITBAR'  'INTERRUPTIBLE'  'BA' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = NNFIB.GETPROPTAG(POINTER) returns tag of POINTER of NNFIB.
			%  TAG = Element.GETPROPTAG(NNxMLP_FeatureImportanceBrainSurface, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceBrainSurface.
			%  TAG = NNFIB.GETPROPTAG(NNxMLP_FeatureImportanceBrainSurface, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceBrainSurface.
			%
			% Note that the Element.GETPROPTAG(NNFIB) and Element.GETPROPTAG('NNxMLP_FeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnxmlp_featureimportancebrainsurface_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'NN'  'P'  'PERM_SEEDS'  'APPLY_CONFIDENCE_INTERVALS'  'SIG_LEVEL'  'APPLY_BONFERRONI'  'BASELINE_INPUTS'  'COMP_FEATURE_INDICES'  'D_SHUFFLED'  'BASELINE_LOSS'  'SHUFFLED_LOSS'  'PERM_SHUFFLED_LOSS'  'CONFIDENCE_INTERVALS'  'STAT_SIG_MASK'  'FEATURE_IMPORTANCE'  'RESHAPED_FEATURE_IMPORTANCE'  'MAP_TO_CELL'  'COUNT_ELEMENTS'  'FLATTEN_CELL'  'VERBOSE'  'WAITBAR'  'INTERRUPTIBLE'  'BA' };
				tag = nnxmlp_featureimportancebrainsurface_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = NNFIB.GETPROPCATEGORY(POINTER) returns category of POINTER of NNFIB.
			%  CATEGORY = Element.GETPROPCATEGORY(NNxMLP_FeatureImportanceBrainSurface, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceBrainSurface.
			%  CATEGORY = NNFIB.GETPROPCATEGORY(NNxMLP_FeatureImportanceBrainSurface, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceBrainSurface.
			%
			% Note that the Element.GETPROPCATEGORY(NNFIB) and Element.GETPROPCATEGORY('NNxMLP_FeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportancebrainsurface_category_list = { 1  1  1  3  4  2  2  6  4  4  3  5  3  3  3  5  5  6  5  6  5  6  5  5  6  6  6  6  9  9  9  3 };
			prop_category = nnxmlp_featureimportancebrainsurface_category_list{prop};
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
			%  FORMAT = NNFIB.GETPROPFORMAT(POINTER) returns format of POINTER of NNFIB.
			%  FORMAT = Element.GETPROPFORMAT(NNxMLP_FeatureImportanceBrainSurface, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceBrainSurface.
			%  FORMAT = NNFIB.GETPROPFORMAT(NNxMLP_FeatureImportanceBrainSurface, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceBrainSurface.
			%
			% Note that the Element.GETPROPFORMAT(NNFIB) and Element.GETPROPFORMAT('NNxMLP_FeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportancebrainsurface_format_list = { 2  2  2  8  2  2  2  2  8  8  11  12  4  11  4  16  16  8  11  12  16  12  12  16  1  1  1  1  4  4  11  8 };
			prop_format = nnxmlp_featureimportancebrainsurface_format_list{prop};
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
			%  DESCRIPTION = NNFIB.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNFIB.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceBrainSurface, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceBrainSurface.
			%  DESCRIPTION = NNFIB.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceBrainSurface, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceBrainSurface.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNFIB) and Element.GETPROPDESCRIPTION('NNxMLP_FeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportancebrainsurface_description_list = { 'ELCLASS (constant, string) is the class of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'NAME (constant, string) is the name of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'DESCRIPTION (constant, string) is the description of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'TEMPLATE (parameter, item) is the template of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'ID (data, string) is a few-letter code of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'LABEL (metadata, string) is an extended label of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'NOTES (metadata, string) are some specific notes about managing the visuazation of the neural network feature importance on the brain surface.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'D (data, item) is the neural networks dataset for feature importance analysis.'  'NN (data, item) contains a trained neural network multi-layer perceptron classifier or regressor.'  'P (parameter, scalar) is the permutation number that determines the statistical significance of the specific feature. '  'PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.'  'APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.'  'SIG_LEVEL (parameter, scalar) determines the significant level.'  'APPLY_BONFERRONI (parameter, logical) determines whether to apply Bonferroni correction.'  'BASELINE_INPUTS (result, cell) retrieves the input data to be shuffled.'  'COMP_FEATURE_INDICES (result, cell) provides the indices of combined features, represented as a cell array containing sets of feature indices, such as {[1], [2], [3]} by default, or {[1, 2], [2, 3], [1, 3]}.'  'D_SHUFFLED (query, item) generates a shuffled version of the dataset where the features of given indexes are replaced with random values drawn from a distribution with the same mean and standard deviation as the orginal ones.'  'BASELINE_LOSS (result, scalar) is the loss value obtained from original dataset, acting as a baseline loss value for evaluating the feature importance.'  'SHUFFLED_LOSS (query, rvector) is the loss value obtained from shuffled datasets.'  'PERM_SHUFFLED_LOSS (result, cell) is the permutation test for obtaining shuffled loss for a number of times in order to establish confidence interval.'  'CONFIDENCE_INTERVALS (query, rvector) derives the 95 percent of confidence interval for the permuation of shuffled loss values.'  'STAT_SIG_MASK (result, rvector) provides the statistical significance mask for composite features indicating which composite features has significant contribution.'  'FEATURE_IMPORTANCE (result, cell) is determined by obtaining the average value from the feature importance element list.'  'RESHAPED_FEATURE_IMPORTANCE (query, empty) reshapes the cell of feature importances with the input data.'  'MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.'  'COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.'  'FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.'  'VERBOSE (gui, logical) is an indicator to display permutation progress information.'  'WAITBAR (gui, logical) determines whether to show the waitbar.'  'INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.'  'BA (parameter, item) is the brain atlas.' };
			prop_description = nnxmlp_featureimportancebrainsurface_description_list{prop};
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
			%  SETTINGS = NNFIB.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNFIB.
			%  SETTINGS = Element.GETPROPSETTINGS(NNxMLP_FeatureImportanceBrainSurface, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceBrainSurface.
			%  SETTINGS = NNFIB.GETPROPSETTINGS(NNxMLP_FeatureImportanceBrainSurface, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceBrainSurface.
			%
			% Note that the Element.GETPROPSETTINGS(NNFIB) and Element.GETPROPSETTINGS('NNxMLP_FeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 32 % NNxMLP_FeatureImportanceBrainSurface.BA
					prop_settings = 'BrainAtlas';
				case 4 % NNxMLP_FeatureImportance4
					prop_settings = 'NNxMLP_FeatureImportanceBrainSurface';
				otherwise
					prop_settings = getPropSettings@NNxMLP_FeatureImportance(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurface.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurface.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFIB.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNFIB.
			%  DEFAULT = Element.GETPROPDEFAULT(NNxMLP_FeatureImportanceBrainSurface, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceBrainSurface.
			%  DEFAULT = NNFIB.GETPROPDEFAULT(NNxMLP_FeatureImportanceBrainSurface, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceBrainSurface.
			%
			% Note that the Element.GETPROPDEFAULT(NNFIB) and Element.GETPROPDEFAULT('NNxMLP_FeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 32 % NNxMLP_FeatureImportanceBrainSurface.BA
					prop_default = Format.getFormatDefault(8, NNxMLP_FeatureImportanceBrainSurface.getPropSettings(prop));
				case 1 % NNxMLP_FeatureImportance1
					prop_default = 'NNxMLP_FeatureImportanceBrainSurface';
				case 2 % NNxMLP_FeatureImportance2
					prop_default = 'Feature Importace for Multi-layer Perceptron on Brain Surface';
				case 3 % NNxMLP_FeatureImportance3
					prop_default = 'A neural network feature importace on brain surface (NNFeatureImportanceBrainSurface) manages the visualization of feature importance within neural network evaluators, particularly on the brain surface. It handles different types of neural network inputs, including graph data (for visualizng the importance of connections between nodes), measures (for visualizing the importance of nodal measures), and the subject data (connectivity data or structural data).';
				case 4 % NNxMLP_FeatureImportance4
					prop_default = Format.getFormatDefault(8, NNxMLP_FeatureImportanceBrainSurface.getPropSettings(prop));
				case 5 % NNxMLP_FeatureImportance5
					prop_default = 'NNxMLP_FeatureImportanceBrainSurface ID';
				case 6 % NNxMLP_FeatureImportance6
					prop_default = 'NNxMLP_FeatureImportanceBrainSurface label';
				case 7 % NNxMLP_FeatureImportance7
					prop_default = 'NNxMLP_FeatureImportanceBrainSurface notes';
				otherwise
					prop_default = getPropDefault@NNxMLP_FeatureImportance(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurface.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurface.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFIB.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNFIB.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceBrainSurface, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceBrainSurface.
			%  DEFAULT = NNFIB.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceBrainSurface, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceBrainSurface.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNFIB) and Element.GETPROPDEFAULTCONDITIONED('NNxMLP_FeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface.getPropProp(pointer);
			
			prop_default = NNxMLP_FeatureImportanceBrainSurface.conditioning(prop, NNxMLP_FeatureImportanceBrainSurface.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNFIB.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNFIB.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNFIB.
			%  CHECK = Element.CHECKPROP(NNxMLP_FeatureImportanceBrainSurface, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceBrainSurface.
			%  CHECK = NNFIB.CHECKPROP(NNxMLP_FeatureImportanceBrainSurface, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceBrainSurface.
			% 
			% NNFIB.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNxMLP_FeatureImportanceBrainSurface:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNFIB.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNFIB.
			%   Error id: BRAPH2:NNxMLP_FeatureImportanceBrainSurface:WrongInput
			%  Element.CHECKPROP(NNxMLP_FeatureImportanceBrainSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceBrainSurface.
			%   Error id: BRAPH2:NNxMLP_FeatureImportanceBrainSurface:WrongInput
			%  NNFIB.CHECKPROP(NNxMLP_FeatureImportanceBrainSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceBrainSurface.
			%   Error id: BRAPH2:NNxMLP_FeatureImportanceBrainSurface:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NNFIB) and Element.CHECKPROP('NNxMLP_FeatureImportanceBrainSurface')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNxMLP_FeatureImportanceBrainSurface.getPropProp(pointer);
			
			switch prop
				case 32 % NNxMLP_FeatureImportanceBrainSurface.BA
					check = Format.checkFormat(8, value, NNxMLP_FeatureImportanceBrainSurface.getPropSettings(prop));
				case 4 % NNxMLP_FeatureImportance4
					check = Format.checkFormat(8, value, NNxMLP_FeatureImportanceBrainSurface.getPropSettings(prop));
				otherwise
					if prop <= 31
						check = checkProp@NNxMLP_FeatureImportance(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurface:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurface:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNxMLP_FeatureImportanceBrainSurface.getPropTag(prop) ' (' NNxMLP_FeatureImportanceBrainSurface.getFormatTag(NNxMLP_FeatureImportanceBrainSurface.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(nnfib, prop, varargin)
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
				case 24 % NNxMLP_FeatureImportanceBrainSurface.FEATURE_IMPORTANCE
					input_dataset = nnfib.get('D');
					dp_class = input_dataset.get('DP_CLASS');
					graph_dp_classes = {NNDataPoint_Graph_CLA().get('ELCLASS'), NNDataPoint_Graph_REG().get('ELCLASS')};
					measure_dp_classes = {NNDataPoint_Measure_CLA().get('ELCLASS'), NNDataPoint_Measure_REG().get('ELCLASS')};
					
					if any(strcmp(dp_class, graph_dp_classes)) % GRAPH input
					    pr = NNxMLP_FeatureImportanceBrainSurfacePP_Graph('EL', nnfib, 'BA', nnfib.get('BA'), 'D', input_dataset, 'PROP', 24, 'RESHAPED_PROP', 25, varargin{:});
					elseif any(strcmp(dp_class, measure_dp_classes))% MEASURE input
					    pr = NNxMLP_FeatureImportanceBrainSurfacePP_Measure('EL', nnfib, 'BA', nnfib.get('BA'), 'D', input_dataset, 'PROP', 24, 'RESHAPED_PROP', 25, varargin{:});
					else % DATA input
					    pr = NNxMLP_FeatureImportanceBrainSurfacePP_Data('EL', nnfib, 'BA', nnfib.get('BA'), 'D', input_dataset, 'PROP', 24, 'RESHAPED_PROP', 25, varargin{:});
					end
					
				otherwise
					pr = getPanelProp@NNxMLP_FeatureImportance(nnfib, prop, varargin{:});
					
			end
		end
	end
end
