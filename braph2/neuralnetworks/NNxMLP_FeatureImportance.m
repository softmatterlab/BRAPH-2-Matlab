classdef NNxMLP_FeatureImportance < ConcreteElement
	%NNxMLP_FeatureImportance provides feature importance analysis for multi-layer perceptron (MLP) using shuffled feature method.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A neural network feature importace for multi-layer perceptron (NNxMLP_FeatureImportance) 
	%  assesses the importance of features by measuring the increase in model error when the feature values are randomly shuffled. 
	% It introduces the permutation method to establish the significance of each feature (or composite features) by comparing the 
	%  original model loss to the distribution of losses obtained from several shuffled iterations, providing a robust statistical 
	%  analysis of feature importance using a user-defined confidence interval and adjusting for multiple comparisons with the Bonferroni correction.
	%
	% The list of NNxMLP_FeatureImportance properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the feature importance analysis.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the feature importance analysis.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the feature importance analysis.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the feature importance analysis.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the feature importance analysis.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the feature importance analysis.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the feature importance analysis.
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
	%  <strong>24</strong> <strong>FEATURE_IMPORTANCE</strong> 	FEATURE_IMPORTANCE (result, cell) is determined by applying Bonferroni correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.
	%  <strong>25</strong> <strong>RESHAPED_FEATURE_IMPORTANCE</strong> 	RESHAPED_FEATURE_IMPORTANCE (query, empty) reshapes the cell of feature importances with the input data.
	%  <strong>26</strong> <strong>MAP_TO_CELL</strong> 	MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.
	%  <strong>27</strong> <strong>COUNT_ELEMENTS</strong> 	COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.
	%  <strong>28</strong> <strong>FLATTEN_CELL</strong> 	FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.
	%  <strong>29</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display permutation progress information.
	%  <strong>30</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
	%  <strong>31</strong> <strong>INTERRUPTIBLE</strong> 	INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.
	%
	% NNxMLP_FeatureImportance methods (constructor):
	%  NNxMLP_FeatureImportance - constructor
	%
	% NNxMLP_FeatureImportance methods:
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
	% NNxMLP_FeatureImportance methods (display):
	%  tostring - string with information about the neural network feature importace for multi-layer perceptron
	%  disp - displays information about the neural network feature importace for multi-layer perceptron
	%  tree - displays the tree of the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportance methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network feature importace for multi-layer perceptron are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportance methods (save/load, Static):
	%  save - saves BRAPH2 neural network feature importace for multi-layer perceptron as b2 file
	%  load - loads a BRAPH2 neural network feature importace for multi-layer perceptron from a b2 file
	%
	% NNxMLP_FeatureImportance method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportance method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportance methods (inspection, Static):
	%  getClass - returns the class of the neural network feature importace for multi-layer perceptron
	%  getSubclasses - returns all subclasses of NNxMLP_FeatureImportance
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
	% NNxMLP_FeatureImportance methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNxMLP_FeatureImportance methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNxMLP_FeatureImportance methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNxMLP_FeatureImportance methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNxMLP_FeatureImportance; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNxMLP_FeatureImportance constants</a>.
	%
	%
	% See also NNDataset, NNDataPointMLP_Shuffled, NNRegressorMLP, NNClassifierMLP, NNxMLP_FeatureImportanceAcrossMeasures.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		D = 9; %CET: Computational Efficiency Trick
		D_TAG = 'D';
		D_CATEGORY = 4;
		D_FORMAT = 8;
		
		NN = 10; %CET: Computational Efficiency Trick
		NN_TAG = 'NN';
		NN_CATEGORY = 4;
		NN_FORMAT = 8;
		
		P = 11; %CET: Computational Efficiency Trick
		P_TAG = 'P';
		P_CATEGORY = 3;
		P_FORMAT = 11;
		
		PERM_SEEDS = 12; %CET: Computational Efficiency Trick
		PERM_SEEDS_TAG = 'PERM_SEEDS';
		PERM_SEEDS_CATEGORY = 5;
		PERM_SEEDS_FORMAT = 12;
		
		APPLY_CONFIDENCE_INTERVALS = 13; %CET: Computational Efficiency Trick
		APPLY_CONFIDENCE_INTERVALS_TAG = 'APPLY_CONFIDENCE_INTERVALS';
		APPLY_CONFIDENCE_INTERVALS_CATEGORY = 3;
		APPLY_CONFIDENCE_INTERVALS_FORMAT = 4;
		
		SIG_LEVEL = 14; %CET: Computational Efficiency Trick
		SIG_LEVEL_TAG = 'SIG_LEVEL';
		SIG_LEVEL_CATEGORY = 3;
		SIG_LEVEL_FORMAT = 11;
		
		APPLY_BONFERRONI = 15; %CET: Computational Efficiency Trick
		APPLY_BONFERRONI_TAG = 'APPLY_BONFERRONI';
		APPLY_BONFERRONI_CATEGORY = 3;
		APPLY_BONFERRONI_FORMAT = 4;
		
		BASELINE_INPUTS = 16; %CET: Computational Efficiency Trick
		BASELINE_INPUTS_TAG = 'BASELINE_INPUTS';
		BASELINE_INPUTS_CATEGORY = 5;
		BASELINE_INPUTS_FORMAT = 16;
		
		COMP_FEATURE_INDICES = 17; %CET: Computational Efficiency Trick
		COMP_FEATURE_INDICES_TAG = 'COMP_FEATURE_INDICES';
		COMP_FEATURE_INDICES_CATEGORY = 5;
		COMP_FEATURE_INDICES_FORMAT = 16;
		
		D_SHUFFLED = 18; %CET: Computational Efficiency Trick
		D_SHUFFLED_TAG = 'D_SHUFFLED';
		D_SHUFFLED_CATEGORY = 6;
		D_SHUFFLED_FORMAT = 8;
		
		BASELINE_LOSS = 19; %CET: Computational Efficiency Trick
		BASELINE_LOSS_TAG = 'BASELINE_LOSS';
		BASELINE_LOSS_CATEGORY = 5;
		BASELINE_LOSS_FORMAT = 11;
		
		SHUFFLED_LOSS = 20; %CET: Computational Efficiency Trick
		SHUFFLED_LOSS_TAG = 'SHUFFLED_LOSS';
		SHUFFLED_LOSS_CATEGORY = 6;
		SHUFFLED_LOSS_FORMAT = 12;
		
		PERM_SHUFFLED_LOSS = 21; %CET: Computational Efficiency Trick
		PERM_SHUFFLED_LOSS_TAG = 'PERM_SHUFFLED_LOSS';
		PERM_SHUFFLED_LOSS_CATEGORY = 5;
		PERM_SHUFFLED_LOSS_FORMAT = 16;
		
		CONFIDENCE_INTERVALS = 22; %CET: Computational Efficiency Trick
		CONFIDENCE_INTERVALS_TAG = 'CONFIDENCE_INTERVALS';
		CONFIDENCE_INTERVALS_CATEGORY = 6;
		CONFIDENCE_INTERVALS_FORMAT = 12;
		
		STAT_SIG_MASK = 23; %CET: Computational Efficiency Trick
		STAT_SIG_MASK_TAG = 'STAT_SIG_MASK';
		STAT_SIG_MASK_CATEGORY = 5;
		STAT_SIG_MASK_FORMAT = 12;
		
		FEATURE_IMPORTANCE = 24; %CET: Computational Efficiency Trick
		FEATURE_IMPORTANCE_TAG = 'FEATURE_IMPORTANCE';
		FEATURE_IMPORTANCE_CATEGORY = 5;
		FEATURE_IMPORTANCE_FORMAT = 16;
		
		RESHAPED_FEATURE_IMPORTANCE = 25; %CET: Computational Efficiency Trick
		RESHAPED_FEATURE_IMPORTANCE_TAG = 'RESHAPED_FEATURE_IMPORTANCE';
		RESHAPED_FEATURE_IMPORTANCE_CATEGORY = 6;
		RESHAPED_FEATURE_IMPORTANCE_FORMAT = 1;
		
		MAP_TO_CELL = 26; %CET: Computational Efficiency Trick
		MAP_TO_CELL_TAG = 'MAP_TO_CELL';
		MAP_TO_CELL_CATEGORY = 6;
		MAP_TO_CELL_FORMAT = 1;
		
		COUNT_ELEMENTS = 27; %CET: Computational Efficiency Trick
		COUNT_ELEMENTS_TAG = 'COUNT_ELEMENTS';
		COUNT_ELEMENTS_CATEGORY = 6;
		COUNT_ELEMENTS_FORMAT = 1;
		
		FLATTEN_CELL = 28; %CET: Computational Efficiency Trick
		FLATTEN_CELL_TAG = 'FLATTEN_CELL';
		FLATTEN_CELL_CATEGORY = 6;
		FLATTEN_CELL_FORMAT = 1;
		
		VERBOSE = 29; %CET: Computational Efficiency Trick
		VERBOSE_TAG = 'VERBOSE';
		VERBOSE_CATEGORY = 9;
		VERBOSE_FORMAT = 4;
		
		WAITBAR = 30; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
		
		INTERRUPTIBLE = 31; %CET: Computational Efficiency Trick
		INTERRUPTIBLE_TAG = 'INTERRUPTIBLE';
		INTERRUPTIBLE_CATEGORY = 9;
		INTERRUPTIBLE_FORMAT = 11;
	end
	methods % constructor
		function nnfi = NNxMLP_FeatureImportance(varargin)
			%NNxMLP_FeatureImportance() creates a neural network feature importace for multi-layer perceptron.
			%
			% NNxMLP_FeatureImportance(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNxMLP_FeatureImportance(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNxMLP_FeatureImportance properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the feature importance analysis.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the feature importance analysis.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the feature importance analysis.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the feature importance analysis.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the feature importance analysis.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the feature importance analysis.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the feature importance analysis.
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
			%  <strong>24</strong> <strong>FEATURE_IMPORTANCE</strong> 	FEATURE_IMPORTANCE (result, cell) is determined by applying Bonferroni correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.
			%  <strong>25</strong> <strong>RESHAPED_FEATURE_IMPORTANCE</strong> 	RESHAPED_FEATURE_IMPORTANCE (query, empty) reshapes the cell of feature importances with the input data.
			%  <strong>26</strong> <strong>MAP_TO_CELL</strong> 	MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.
			%  <strong>27</strong> <strong>COUNT_ELEMENTS</strong> 	COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.
			%  <strong>28</strong> <strong>FLATTEN_CELL</strong> 	FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.
			%  <strong>29</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display permutation progress information.
			%  <strong>30</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
			%  <strong>31</strong> <strong>INTERRUPTIBLE</strong> 	INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.
			%
			% See also Category, Format.
			
			nnfi = nnfi@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the neural network feature importace for multi-layer perceptron.
			%
			% BUILD = NNxMLP_FeatureImportance.GETBUILD() returns the build of 'NNxMLP_FeatureImportance'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NNFI.GETBUILD() returns the build of the neural network feature importace for multi-layer perceptron NNFI.
			%  BUILD = Element.GETBUILD(NNFI) returns the build of 'NNFI'.
			%  BUILD = Element.GETBUILD('NNxMLP_FeatureImportance') returns the build of 'NNxMLP_FeatureImportance'.
			%
			% Note that the Element.GETBUILD(NNFI) and Element.GETBUILD('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nnfi_class = getClass()
			%GETCLASS returns the class of the neural network feature importace for multi-layer perceptron.
			%
			% CLASS = NNxMLP_FeatureImportance.GETCLASS() returns the class 'NNxMLP_FeatureImportance'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNFI.GETCLASS() returns the class of the neural network feature importace for multi-layer perceptron NNFI.
			%  CLASS = Element.GETCLASS(NNFI) returns the class of 'NNFI'.
			%  CLASS = Element.GETCLASS('NNxMLP_FeatureImportance') returns 'NNxMLP_FeatureImportance'.
			%
			% Note that the Element.GETCLASS(NNFI) and Element.GETCLASS('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			
			nnfi_class = 'NNxMLP_FeatureImportance';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network feature importace for multi-layer perceptron.
			%
			% LIST = NNxMLP_FeatureImportance.GETSUBCLASSES() returns all subclasses of 'NNxMLP_FeatureImportance'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNFI.GETSUBCLASSES() returns all subclasses of the neural network feature importace for multi-layer perceptron NNFI.
			%  LIST = Element.GETSUBCLASSES(NNFI) returns all subclasses of 'NNFI'.
			%  LIST = Element.GETSUBCLASSES('NNxMLP_FeatureImportance') returns all subclasses of 'NNxMLP_FeatureImportance'.
			%
			% Note that the Element.GETSUBCLASSES(NNFI) and Element.GETSUBCLASSES('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNxMLP_FeatureImportance'  'NNxMLP_FeatureImportanceAcrossMeasures'  'NNxMLP_FeatureImportanceBrainSurface' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network feature importace for multi-layer perceptron.
			%
			% PROPS = NNxMLP_FeatureImportance.GETPROPS() returns the property list of neural network feature importace for multi-layer perceptron
			%  as a row vector.
			%
			% PROPS = NNxMLP_FeatureImportance.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNFI.GETPROPS([CATEGORY]) returns the property list of the neural network feature importace for multi-layer perceptron NNFI.
			%  PROPS = Element.GETPROPS(NNFI[, CATEGORY]) returns the property list of 'NNFI'.
			%  PROPS = Element.GETPROPS('NNxMLP_FeatureImportance'[, CATEGORY]) returns the property list of 'NNxMLP_FeatureImportance'.
			%
			% Note that the Element.GETPROPS(NNFI) and Element.GETPROPS('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31];
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
			% N = NNxMLP_FeatureImportance.GETPROPNUMBER() returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportance.GETPROPNUMBER(CATEGORY) returns the property number of neural network feature importace for multi-layer perceptron
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNFI.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network feature importace for multi-layer perceptron NNFI.
			%  N = Element.GETPROPNUMBER(NNFI) returns the property number of 'NNFI'.
			%  N = Element.GETPROPNUMBER('NNxMLP_FeatureImportance') returns the property number of 'NNxMLP_FeatureImportance'.
			%
			% Note that the Element.GETPROPNUMBER(NNFI) and Element.GETPROPNUMBER('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 31;
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
			% CHECK = NNxMLP_FeatureImportance.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFI.EXISTSPROP(PROP) checks whether PROP exists for NNFI.
			%  CHECK = Element.EXISTSPROP(NNFI, PROP) checks whether PROP exists for NNFI.
			%  CHECK = Element.EXISTSPROP(NNxMLP_FeatureImportance, PROP) checks whether PROP exists for NNxMLP_FeatureImportance.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFI.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNFI.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			%  Element.EXISTSPROP(NNFI, PROP) throws error if PROP does NOT exist for NNFI.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			%  Element.EXISTSPROP(NNxMLP_FeatureImportance, PROP) throws error if PROP does NOT exist for NNxMLP_FeatureImportance.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNFI) and Element.EXISTSPROP('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 31 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportance:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportance:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNxMLP_FeatureImportance.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportance.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFI.EXISTSTAG(TAG) checks whether TAG exists for NNFI.
			%  CHECK = Element.EXISTSTAG(NNFI, TAG) checks whether TAG exists for NNFI.
			%  CHECK = Element.EXISTSTAG(NNxMLP_FeatureImportance, TAG) checks whether TAG exists for NNxMLP_FeatureImportance.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFI.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNFI.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			%  Element.EXISTSTAG(NNFI, TAG) throws error if TAG does NOT exist for NNFI.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			%  Element.EXISTSTAG(NNxMLP_FeatureImportance, TAG) throws error if TAG does NOT exist for NNxMLP_FeatureImportance.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNFI) and Element.EXISTSTAG('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'NN'  'P'  'PERM_SEEDS'  'APPLY_CONFIDENCE_INTERVALS'  'SIG_LEVEL'  'APPLY_BONFERRONI'  'BASELINE_INPUTS'  'COMP_FEATURE_INDICES'  'D_SHUFFLED'  'BASELINE_LOSS'  'SHUFFLED_LOSS'  'PERM_SHUFFLED_LOSS'  'CONFIDENCE_INTERVALS'  'STAT_SIG_MASK'  'FEATURE_IMPORTANCE'  'RESHAPED_FEATURE_IMPORTANCE'  'MAP_TO_CELL'  'COUNT_ELEMENTS'  'FLATTEN_CELL'  'VERBOSE'  'WAITBAR'  'INTERRUPTIBLE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportance:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportance:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNxMLP_FeatureImportance.'] ...
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
			%  PROPERTY = NNFI.GETPROPPROP(POINTER) returns property number of POINTER of NNFI.
			%  PROPERTY = Element.GETPROPPROP(NNxMLP_FeatureImportance, POINTER) returns property number of POINTER of NNxMLP_FeatureImportance.
			%  PROPERTY = NNFI.GETPROPPROP(NNxMLP_FeatureImportance, POINTER) returns property number of POINTER of NNxMLP_FeatureImportance.
			%
			% Note that the Element.GETPROPPROP(NNFI) and Element.GETPROPPROP('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'NN'  'P'  'PERM_SEEDS'  'APPLY_CONFIDENCE_INTERVALS'  'SIG_LEVEL'  'APPLY_BONFERRONI'  'BASELINE_INPUTS'  'COMP_FEATURE_INDICES'  'D_SHUFFLED'  'BASELINE_LOSS'  'SHUFFLED_LOSS'  'PERM_SHUFFLED_LOSS'  'CONFIDENCE_INTERVALS'  'STAT_SIG_MASK'  'FEATURE_IMPORTANCE'  'RESHAPED_FEATURE_IMPORTANCE'  'MAP_TO_CELL'  'COUNT_ELEMENTS'  'FLATTEN_CELL'  'VERBOSE'  'WAITBAR'  'INTERRUPTIBLE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = NNFI.GETPROPTAG(POINTER) returns tag of POINTER of NNFI.
			%  TAG = Element.GETPROPTAG(NNxMLP_FeatureImportance, POINTER) returns tag of POINTER of NNxMLP_FeatureImportance.
			%  TAG = NNFI.GETPROPTAG(NNxMLP_FeatureImportance, POINTER) returns tag of POINTER of NNxMLP_FeatureImportance.
			%
			% Note that the Element.GETPROPTAG(NNFI) and Element.GETPROPTAG('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnxmlp_featureimportance_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'NN'  'P'  'PERM_SEEDS'  'APPLY_CONFIDENCE_INTERVALS'  'SIG_LEVEL'  'APPLY_BONFERRONI'  'BASELINE_INPUTS'  'COMP_FEATURE_INDICES'  'D_SHUFFLED'  'BASELINE_LOSS'  'SHUFFLED_LOSS'  'PERM_SHUFFLED_LOSS'  'CONFIDENCE_INTERVALS'  'STAT_SIG_MASK'  'FEATURE_IMPORTANCE'  'RESHAPED_FEATURE_IMPORTANCE'  'MAP_TO_CELL'  'COUNT_ELEMENTS'  'FLATTEN_CELL'  'VERBOSE'  'WAITBAR'  'INTERRUPTIBLE' };
				tag = nnxmlp_featureimportance_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = NNFI.GETPROPCATEGORY(POINTER) returns category of POINTER of NNFI.
			%  CATEGORY = Element.GETPROPCATEGORY(NNxMLP_FeatureImportance, POINTER) returns category of POINTER of NNxMLP_FeatureImportance.
			%  CATEGORY = NNFI.GETPROPCATEGORY(NNxMLP_FeatureImportance, POINTER) returns category of POINTER of NNxMLP_FeatureImportance.
			%
			% Note that the Element.GETPROPCATEGORY(NNFI) and Element.GETPROPCATEGORY('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportance.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportance_category_list = { 1  1  1  3  4  2  2  6  4  4  3  5  3  3  3  5  5  6  5  6  5  6  5  5  6  6  6  6  9  9  9 };
			prop_category = nnxmlp_featureimportance_category_list{prop};
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
			%  FORMAT = NNFI.GETPROPFORMAT(POINTER) returns format of POINTER of NNFI.
			%  FORMAT = Element.GETPROPFORMAT(NNxMLP_FeatureImportance, POINTER) returns format of POINTER of NNxMLP_FeatureImportance.
			%  FORMAT = NNFI.GETPROPFORMAT(NNxMLP_FeatureImportance, POINTER) returns format of POINTER of NNxMLP_FeatureImportance.
			%
			% Note that the Element.GETPROPFORMAT(NNFI) and Element.GETPROPFORMAT('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportance.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportance_format_list = { 2  2  2  8  2  2  2  2  8  8  11  12  4  11  4  16  16  8  11  12  16  12  12  16  1  1  1  1  4  4  11 };
			prop_format = nnxmlp_featureimportance_format_list{prop};
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
			%  DESCRIPTION = NNFI.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNFI.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNxMLP_FeatureImportance, POINTER) returns description of POINTER of NNxMLP_FeatureImportance.
			%  DESCRIPTION = NNFI.GETPROPDESCRIPTION(NNxMLP_FeatureImportance, POINTER) returns description of POINTER of NNxMLP_FeatureImportance.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNFI) and Element.GETPROPDESCRIPTION('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportance.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportance_description_list = { 'ELCLASS (constant, string) is the class of the feature importance analysis.'  'NAME (constant, string) is the name of the feature importance analysis.'  'DESCRIPTION (constant, string) is the description of the feature importance analysis.'  'TEMPLATE (parameter, item) is the template of the feature importance analysis.'  'ID (data, string) is a few-letter code of the feature importance analysis.'  'LABEL (metadata, string) is an extended label of the feature importance analysis.'  'NOTES (metadata, string) are some specific notes about the feature importance analysis.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'D (data, item) is the neural networks dataset for feature importance analysis.'  'NN (data, item) contains a trained neural network multi-layer perceptron classifier or regressor.'  'P (parameter, scalar) is the permutation number that determines the statistical significance of the specific feature. '  'PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.'  'APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.'  'SIG_LEVEL (parameter, scalar) determines the significant level.'  'APPLY_BONFERRONI (parameter, logical) determines whether to apply Bonferroni correction.'  'BASELINE_INPUTS (result, cell) retrieves the input data to be shuffled.'  'COMP_FEATURE_INDICES (result, cell) provides the indices of combined features, represented as a cell array containing sets of feature indices, such as {[1], [2], [3]} by default, or {[1, 2], [2, 3], [1, 3]}.'  'D_SHUFFLED (query, item) generates a shuffled version of the dataset where the features of given indexes are replaced with random values drawn from a distribution with the same mean and standard deviation as the orginal ones.'  'BASELINE_LOSS (result, scalar) is the loss value obtained from original dataset, acting as a baseline loss value for evaluating the feature importance.'  'SHUFFLED_LOSS (query, rvector) is the loss value obtained from shuffled datasets.'  'PERM_SHUFFLED_LOSS (result, cell) is the permutation test for obtaining shuffled loss for a number of times in order to establish confidence interval.'  'CONFIDENCE_INTERVALS (query, rvector) derives the 95 percent of confidence interval for the permuation of shuffled loss values.'  'STAT_SIG_MASK (result, rvector) provides the statistical significance mask for composite features indicating which composite features has significant contribution.'  'FEATURE_IMPORTANCE (result, cell) is determined by applying Bonferroni correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.'  'RESHAPED_FEATURE_IMPORTANCE (query, empty) reshapes the cell of feature importances with the input data.'  'MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.'  'COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.'  'FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.'  'VERBOSE (gui, logical) is an indicator to display permutation progress information.'  'WAITBAR (gui, logical) determines whether to show the waitbar.'  'INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.' };
			prop_description = nnxmlp_featureimportance_description_list{prop};
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
			%  SETTINGS = NNFI.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNFI.
			%  SETTINGS = Element.GETPROPSETTINGS(NNxMLP_FeatureImportance, POINTER) returns settings of POINTER of NNxMLP_FeatureImportance.
			%  SETTINGS = NNFI.GETPROPSETTINGS(NNxMLP_FeatureImportance, POINTER) returns settings of POINTER of NNxMLP_FeatureImportance.
			%
			% Note that the Element.GETPROPSETTINGS(NNFI) and Element.GETPROPSETTINGS('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportance.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNxMLP_FeatureImportance.D
					prop_settings = 'NNDataset';
				case 10 % NNxMLP_FeatureImportance.NN
					prop_settings = 'NNBase';
				case 11 % NNxMLP_FeatureImportance.P
					prop_settings = Format.getFormatSettings(11);
				case 12 % NNxMLP_FeatureImportance.PERM_SEEDS
					prop_settings = Format.getFormatSettings(12);
				case 13 % NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS
					prop_settings = Format.getFormatSettings(4);
				case 14 % NNxMLP_FeatureImportance.SIG_LEVEL
					prop_settings = Format.getFormatSettings(11);
				case 15 % NNxMLP_FeatureImportance.APPLY_BONFERRONI
					prop_settings = Format.getFormatSettings(4);
				case 16 % NNxMLP_FeatureImportance.BASELINE_INPUTS
					prop_settings = Format.getFormatSettings(16);
				case 17 % NNxMLP_FeatureImportance.COMP_FEATURE_INDICES
					prop_settings = Format.getFormatSettings(16);
				case 18 % NNxMLP_FeatureImportance.D_SHUFFLED
					prop_settings = 'NNDataset';
				case 19 % NNxMLP_FeatureImportance.BASELINE_LOSS
					prop_settings = Format.getFormatSettings(11);
				case 20 % NNxMLP_FeatureImportance.SHUFFLED_LOSS
					prop_settings = Format.getFormatSettings(12);
				case 21 % NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS
					prop_settings = Format.getFormatSettings(16);
				case 22 % NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS
					prop_settings = Format.getFormatSettings(12);
				case 23 % NNxMLP_FeatureImportance.STAT_SIG_MASK
					prop_settings = Format.getFormatSettings(12);
				case 24 % NNxMLP_FeatureImportance.FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(16);
				case 25 % NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(1);
				case 26 % NNxMLP_FeatureImportance.MAP_TO_CELL
					prop_settings = Format.getFormatSettings(1);
				case 27 % NNxMLP_FeatureImportance.COUNT_ELEMENTS
					prop_settings = Format.getFormatSettings(1);
				case 28 % NNxMLP_FeatureImportance.FLATTEN_CELL
					prop_settings = Format.getFormatSettings(1);
				case 29 % NNxMLP_FeatureImportance.VERBOSE
					prop_settings = Format.getFormatSettings(4);
				case 30 % NNxMLP_FeatureImportance.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 31 % NNxMLP_FeatureImportance.INTERRUPTIBLE
					prop_settings = Format.getFormatSettings(11);
				case 4 % NNxMLP_FeatureImportance.TEMPLATE
					prop_settings = 'NNxMLP_FeatureImportance';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportance.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportance.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFI.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNFI.
			%  DEFAULT = Element.GETPROPDEFAULT(NNxMLP_FeatureImportance, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportance.
			%  DEFAULT = NNFI.GETPROPDEFAULT(NNxMLP_FeatureImportance, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportance.
			%
			% Note that the Element.GETPROPDEFAULT(NNFI) and Element.GETPROPDEFAULT('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNxMLP_FeatureImportance.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNxMLP_FeatureImportance.D
					prop_default = Format.getFormatDefault(8, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 10 % NNxMLP_FeatureImportance.NN
					prop_default = Format.getFormatDefault(8, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 11 % NNxMLP_FeatureImportance.P
					prop_default = 1e+2;
				case 12 % NNxMLP_FeatureImportance.PERM_SEEDS
					prop_default = Format.getFormatDefault(12, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 13 % NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS
					prop_default = true;
				case 14 % NNxMLP_FeatureImportance.SIG_LEVEL
					prop_default = 0.05;
				case 15 % NNxMLP_FeatureImportance.APPLY_BONFERRONI
					prop_default = true;
				case 16 % NNxMLP_FeatureImportance.BASELINE_INPUTS
					prop_default = Format.getFormatDefault(16, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 17 % NNxMLP_FeatureImportance.COMP_FEATURE_INDICES
					prop_default = Format.getFormatDefault(16, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 18 % NNxMLP_FeatureImportance.D_SHUFFLED
					prop_default = Format.getFormatDefault(8, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 19 % NNxMLP_FeatureImportance.BASELINE_LOSS
					prop_default = Format.getFormatDefault(11, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 20 % NNxMLP_FeatureImportance.SHUFFLED_LOSS
					prop_default = Format.getFormatDefault(12, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 21 % NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS
					prop_default = Format.getFormatDefault(16, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 22 % NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS
					prop_default = Format.getFormatDefault(12, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 23 % NNxMLP_FeatureImportance.STAT_SIG_MASK
					prop_default = Format.getFormatDefault(12, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 24 % NNxMLP_FeatureImportance.FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(16, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 25 % NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(1, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 26 % NNxMLP_FeatureImportance.MAP_TO_CELL
					prop_default = Format.getFormatDefault(1, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 27 % NNxMLP_FeatureImportance.COUNT_ELEMENTS
					prop_default = Format.getFormatDefault(1, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 28 % NNxMLP_FeatureImportance.FLATTEN_CELL
					prop_default = Format.getFormatDefault(1, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 29 % NNxMLP_FeatureImportance.VERBOSE
					prop_default = false;
				case 30 % NNxMLP_FeatureImportance.WAITBAR
					prop_default = true;
				case 31 % NNxMLP_FeatureImportance.INTERRUPTIBLE
					prop_default = .001;
				case 1 % NNxMLP_FeatureImportance.ELCLASS
					prop_default = 'NNxMLP_FeatureImportance';
				case 2 % NNxMLP_FeatureImportance.NAME
					prop_default = 'Neural Network Feature Importace for Multi-layer Perceptron';
				case 3 % NNxMLP_FeatureImportance.DESCRIPTION
					prop_default = 'A neural network feature importace for multi-layer perceptron (NNxMLP_FeatureImportance) assesses the importance of features by measuring the increase in model error when the feature values are randomly shuffled. It introduces the permutation method to establish the significance of each feature (or composite features) by comparing the original model loss to the distribution of losses obtained from several shuffled iterations, providing a robust statistical analysis of feature importance using a user-defined confidence interval and adjusting for multiple comparisons with the Bonferroni correction.';
				case 4 % NNxMLP_FeatureImportance.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 5 % NNxMLP_FeatureImportance.ID
					prop_default = 'NNxMLP_FeatureImportance ID';
				case 6 % NNxMLP_FeatureImportance.LABEL
					prop_default = 'NNxMLP_FeatureImportance label';
				case 7 % NNxMLP_FeatureImportance.NOTES
					prop_default = 'NNxMLP_FeatureImportance notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportance.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportance.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFI.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNFI.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportance, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportance.
			%  DEFAULT = NNFI.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportance, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportance.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNFI) and Element.GETPROPDEFAULTCONDITIONED('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNxMLP_FeatureImportance.getPropProp(pointer);
			
			prop_default = NNxMLP_FeatureImportance.conditioning(prop, NNxMLP_FeatureImportance.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNFI.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNFI.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNFI.
			%  CHECK = Element.CHECKPROP(NNxMLP_FeatureImportance, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportance.
			%  CHECK = NNFI.CHECKPROP(NNxMLP_FeatureImportance, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportance.
			% 
			% NNFI.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNxMLP_FeatureImportance:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNFI.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNFI.
			%   Error id: BRAPH2:NNxMLP_FeatureImportance:WrongInput
			%  Element.CHECKPROP(NNxMLP_FeatureImportance, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportance.
			%   Error id: BRAPH2:NNxMLP_FeatureImportance:WrongInput
			%  NNFI.CHECKPROP(NNxMLP_FeatureImportance, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportance.
			%   Error id: BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NNFI) and Element.CHECKPROP('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNxMLP_FeatureImportance.getPropProp(pointer);
			
			switch prop
				case 9 % NNxMLP_FeatureImportance.D
					check = Format.checkFormat(8, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 10 % NNxMLP_FeatureImportance.NN
					check = Format.checkFormat(8, value, NNxMLP_FeatureImportance.getPropSettings(prop));
					if check
						check = any(strcmp(value.get('ELCLASS'), {'NNBase', 'NNClassifierMLP', 'NNRegressorMLP'}));
					end
				case 11 % NNxMLP_FeatureImportance.P
					check = Format.checkFormat(11, value, NNxMLP_FeatureImportance.getPropSettings(prop));
					if check
						check = value > 0 && value == round(value);
					end
				case 12 % NNxMLP_FeatureImportance.PERM_SEEDS
					check = Format.checkFormat(12, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 13 % NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS
					check = Format.checkFormat(4, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 14 % NNxMLP_FeatureImportance.SIG_LEVEL
					check = Format.checkFormat(11, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 15 % NNxMLP_FeatureImportance.APPLY_BONFERRONI
					check = Format.checkFormat(4, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 16 % NNxMLP_FeatureImportance.BASELINE_INPUTS
					check = Format.checkFormat(16, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 17 % NNxMLP_FeatureImportance.COMP_FEATURE_INDICES
					check = Format.checkFormat(16, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 18 % NNxMLP_FeatureImportance.D_SHUFFLED
					check = Format.checkFormat(8, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 19 % NNxMLP_FeatureImportance.BASELINE_LOSS
					check = Format.checkFormat(11, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 20 % NNxMLP_FeatureImportance.SHUFFLED_LOSS
					check = Format.checkFormat(12, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 21 % NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS
					check = Format.checkFormat(16, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 22 % NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS
					check = Format.checkFormat(12, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 23 % NNxMLP_FeatureImportance.STAT_SIG_MASK
					check = Format.checkFormat(12, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 24 % NNxMLP_FeatureImportance.FEATURE_IMPORTANCE
					check = Format.checkFormat(16, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 25 % NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE
					check = Format.checkFormat(1, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 26 % NNxMLP_FeatureImportance.MAP_TO_CELL
					check = Format.checkFormat(1, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 27 % NNxMLP_FeatureImportance.COUNT_ELEMENTS
					check = Format.checkFormat(1, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 28 % NNxMLP_FeatureImportance.FLATTEN_CELL
					check = Format.checkFormat(1, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 29 % NNxMLP_FeatureImportance.VERBOSE
					check = Format.checkFormat(4, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 30 % NNxMLP_FeatureImportance.WAITBAR
					check = Format.checkFormat(4, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 31 % NNxMLP_FeatureImportance.INTERRUPTIBLE
					check = Format.checkFormat(11, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case 4 % NNxMLP_FeatureImportance.TEMPLATE
					check = Format.checkFormat(8, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportance:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportance:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNxMLP_FeatureImportance.getPropTag(prop) ' (' NNxMLP_FeatureImportance.getFormatTag(NNxMLP_FeatureImportance.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nnfi, prop, varargin)
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
				case 12 % NNxMLP_FeatureImportance.PERM_SEEDS
					rng_settings_ = rng(); rng(nnfi.getPropSeed(12), 'twister')
					
					value = randi(intmax('uint32'), 1, nnfi.get('P'));
					
					rng(rng_settings_)
					
				case 16 % NNxMLP_FeatureImportance.BASELINE_INPUTS
					rng_settings_ = rng(); rng(nnfi.getPropSeed(16), 'twister')
					
					value = nnfi.get('NN').get('INPUTS', nnfi.get('D'));
					
					rng(rng_settings_)
					
				case 17 % NNxMLP_FeatureImportance.COMP_FEATURE_INDICES
					rng_settings_ = rng(); rng(nnfi.getPropSeed(17), 'twister')
					
					inputs = cell2mat(nnfi.memorize('BASELINE_INPUTS'));
					num_feature = size(inputs, 2);
					value = num2cell(1:num_feature);
					
					rng(rng_settings_)
					
				case 18 % NNxMLP_FeatureImportance.D_SHUFFLED
					if isempty(varargin)
					    value = NNDataset();
					    return
					end
					comp_feature_combination = varargin{1}; % the composite indexes to be shuffled
					
					d = nnfi.get('D');
					dp_it_list = d.get('DP_DICT').get('IT_LIST');
					P = nnfi.get('P');
					
					inputs = cell2mat(nnfi.memorize('BASELINE_INPUTS'));
					shuffled_inputs = inputs;
					for i = 1:length(comp_feature_combination)
					    feature_idx = comp_feature_combination(i);
					    permuted_value = squeeze(normrnd(mean(inputs(:, feature_idx)), std(inputs(:, feature_idx)), squeeze(size(inputs(:, feature_idx)))));
					    shuffled_inputs(:, feature_idx) = permuted_value;
					end
					
					for i = 1:length(dp_it_list)
					    dp = dp_it_list{i};
					    shuffled_input = {shuffled_inputs(i, :)};
					    shuffled_dp_list{i} = NNDataPointMLP_Shuffled('SHUFFLED_INPUT', shuffled_input);
					end
					
					shuffled_dp_dict = IndexedDictionary(...
					        'IT_CLASS', 'NNDataPointMLP_Shuffled', ...
					        'IT_LIST', shuffled_dp_list ...
					        );
					
					value = NNDataset( ...
					    'DP_CLASS', 'NNDataPointMLP_Shuffled', ...
					    'DP_DICT', shuffled_dp_dict ...
					    );
					
				case 19 % NNxMLP_FeatureImportance.BASELINE_LOSS
					rng_settings_ = rng(); rng(nnfi.getPropSeed(19), 'twister')
					
					d = nnfi.get('D');
					nn = nnfi.get('NN');
					net = nn.get('MODEL');
					inputs = cell2mat(nnfi.memorize('BASELINE_INPUTS'));
					targets = nn.get('TARGETS', d);
					if isempty(inputs)
					    baseline_loss = 0;
					else
					    baseline_loss = crossentropy(net.predict(inputs), targets);
					end
					value = baseline_loss;
					
					rng(rng_settings_)
					
				case 20 % NNxMLP_FeatureImportance.SHUFFLED_LOSS
					if isempty(varargin)
					    value = [];
					    return
					end
					seed = varargin{1};
					rng(seed, 'twister')
					
					shuffled_loss = [];
					d = nnfi.get('D');
					if isa(d.getr('DP_DICT'), 'NoValue')
					    value = shuffled_loss;
					    return
					end
					
					nn = nnfi.get('NN');
					targets = nn.get('TARGETS', d);
					
					comp_feature_indices = nnfi.get('COMP_FEATURE_INDICES');
					num_comp_feature_combinations = length(comp_feature_indices);
					leap_parallel = 2^10;
					shuffled_loss = [];
					
					start = tic;
					for j = 1:leap_parallel:num_comp_feature_combinations
					    for i = j:min(j+leap_parallel, num_comp_feature_combinations)
					        comp_feature_combination = comp_feature_indices{i};
					        d_perm = nnfi.get('D_SHUFFLED', comp_feature_combination);
					        predictions = nn.get('PREDICT', d_perm);
					        scrambled_loss = crossentropy(predictions, targets);
					        shuffled_loss(i) = scrambled_loss;
					    end
					    if nnfi.get('VERBOSE')
					        disp(['** PERMUTATION FEATURE IMPORTANCE - (composite) features #' int2str(min(j+leap_parallel-1, num_comp_feature_combinations)) '/' int2str(num_comp_feature_combinations) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
					    end
					    if nnfi.get('INTERRUPTIBLE')
					        pause(nnfi.get('INTERRUPTIBLE'))
					    end
					end
					
					value = shuffled_loss;
					
				case 21 % NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS
					rng_settings_ = rng(); rng(nnfi.getPropSeed(21), 'twister')
					
					nnfi.memorize('BASELINE_INPUTS');
					p = nnfi.get('P');
					seeds = nnfi.get('PERM_SEEDS');
					value = {};
					leap_parallel = 2^5;
					wb = braph2waitbar(nnfi.get('WAITBAR'), 0, ['Feature importance permutation ...']);
					
					% % % delete(gcp('nocreate')); parpool('Threads'); % add a property to config Threads or Processes for the profile 
					start = tic;
					for j = 1:leap_parallel:p
					    parfor i = j:min(j+leap_parallel, p)
					        perm_shuflled_loss{i} = nnfi.get('SHUFFLED_LOSS', seeds(i));
					    end
					    if nnfi.get('VERBOSE')
					        disp(['** PERMUTATION FEATURE IMPORTANCE - sampling #' int2str(min(j+leap_parallel-1, p)) '/' int2str(p) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
					    end
					    if nnfi.get('INTERRUPTIBLE')
					        pause(nnfi.get('INTERRUPTIBLE'))
					    end
					    braph2waitbar(wb, .15 + .85 * min(j+leap_parallel-1, p) / p, ['Permutation sampling # ' num2str(min(j+leap_parallel-1, p)) ' of ' num2str(p) ' ...'])
					end
					
					braph2waitbar(wb, 'close')
					
					value = perm_shuflled_loss;
					
					rng(rng_settings_)
					
				case 22 % NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS
					if isempty(varargin)
					    value = [];
					    return
					end
					data = varargin{1};
					sig_level = varargin{2};
					sampleMean = mean(data); % Mean of the data
					sampleStd = std(data); % Std of the data
					n = numel(data);  % Sample size
					z = norminv(1 - sig_level/2);  % Z-score for the desired confidence level
					marginError = z * sampleStd / sqrt(n);  % Margin of error
					value = [sampleMean - marginError, sampleMean + marginError];
					
				case 23 % NNxMLP_FeatureImportance.STAT_SIG_MASK
					rng_settings_ = rng(); rng(nnfi.getPropSeed(23), 'twister')
					
					perm_shuffled_loss = nnfi.memorize('PERM_SHUFFLED_LOSS');
					perm_shuffled_loss = cell2mat(perm_shuffled_loss.');
					baseline_loss = nnfi.get('BASELINE_LOSS');
					
					comp_feature_indices = nnfi.get('COMP_FEATURE_INDICES');
					num_comp_feature_combinations = length(comp_feature_indices);
					
					sig_level = nnfi.get('SIG_LEVEL');
					if nnfi.get('APPLY_BONFERRONI')
					    sig_level = sig_level / num_comp_feature_combinations;
					end
					
					significant_flags = [];
					for i = 1:num_comp_feature_combinations
					    perm_values = squeeze(perm_shuffled_loss(:, i));
					    confidenceInterval = nnfi.get('CONFIDENCE_INTERVALS', perm_values, sig_level);
					    if confidenceInterval(1) - baseline_loss > 1e-04
					        significant_flag = 1;
					    else
					        significant_flag = 0;
					    end
					    significant_flags(i) = significant_flag;
					end
					
					value = significant_flags;
					
					rng(rng_settings_)
					
				case 24 % NNxMLP_FeatureImportance.FEATURE_IMPORTANCE
					rng_settings_ = rng(); rng(nnfi.getPropSeed(24), 'twister')
					
					nnfi.memorize('BASELINE_INPUTS');
					baseline_loss = nnfi.memorize('BASELINE_LOSS');
					perm_shuffled_loss = nnfi.memorize('PERM_SHUFFLED_LOSS');
					perm_shuffled_loss = cell2mat(perm_shuffled_loss.');
					
					comp_feature_indices = nnfi.get('COMP_FEATURE_INDICES');
					num_comp_feature_combinations = length(comp_feature_indices);
					
					fi_value = mean(perm_shuffled_loss, 1)/baseline_loss;
					
					if nnfi.get('APPLY_CONFIDENCE_INTERVALS') 
					    statistic_significance_mask = nnfi.get('STAT_SIG_MASK');
					    fi_value(~statistic_significance_mask) = 0;
					end
					
					value = {fi_value};
					
					rng(rng_settings_)
					
				case 25 % NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE
					cell1 = nnfi.get('FEATURE_IMPORTANCE');
					d = nnfi.get('D');
					if isa(d.getr('DP_DICT'), 'NoValue')
					    value = {};
					    return
					end
					cell2 = d.get('DP_DICT').get('IT', 1).get('INPUT');
					if ~isequal(numel(cell2mat(cell1)), numel(cell2)) 
					    cell1 = nnfi.get('MAP_TO_CELL', cell2mat(cell1), cell2);
					end
					
					value = cell1;
					
				case 26 % NNxMLP_FeatureImportance.MAP_TO_CELL
					if isempty(varargin)
					    value = {};
					    return
					end
					vector = varargin{1};
					cell_template = varargin{2};
					mappedCellArray = cell_template;
					index = 1;
					for i = 1:numel(cell_template)
					    cellData = cell_template{i};
					    if iscell(cellData)
					        % Map the vector to nested cell arrays recursively
					        numElements = nnfi.get('COUNT_ELEMENTS', cellData);
					        nestedVector = vector(index:index + numElements - 1);
					        mappedCellArray{i} = nnfi.get('MAP_TO_CELL', nestedVector, cellData);
					        index = index + numElements;
					    else
					        % Assign elements from the vector to cells
					        numElements = numel(cellData);
					        mappedCellArray{i} = reshape(vector(index:index + numElements - 1), size(cellData));
					        index = index + numElements;
					    end
					end
					
					value = mappedCellArray;
					
				case 27 % NNxMLP_FeatureImportance.COUNT_ELEMENTS
					if isempty(varargin)
					    value = {};
					    return
					end
					cell_data = varargin{1};
					count = 0;
					for i = 1:numel(cell_data)
					    if iscell(cell_data{i})
					        count = count + nnfi.get('COUNT_ELEMENTS', cell_data{i});
					    else
					        count = count + numel(cell_data{i});
					    end
					end
					
					value = count;
					
				case 28 % NNxMLP_FeatureImportance.FLATTEN_CELL
					if isempty(varargin)
					    value = {};
					    return
					end
					cell_input = varargin{1};
					flattened_input = [];
					while ~isempty(cell_input)
					    currentData = cell_input{end};  % Get the last element from the stack
					    cell_input = cell_input(1:end-1);   % Remove the last element
					
					    if iscell(currentData)
					        % If it's a cell array, add its contents to the stack
					        cell_input = [cell_input currentData{:}];
					    else
					        % If it's numeric or other data, append it to the vector
					        flattened_input = [currentData(:); flattened_input];
					    end
					end
					value = flattened_input;
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(nnfi, prop, varargin{:});
					else
						value = calculateValue@Element(nnfi, prop, varargin{:});
					end
			end
			
		end
	end
end
