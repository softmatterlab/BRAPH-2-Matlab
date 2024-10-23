classdef NNClassifierMLP_CrossValidation < NNCrossValidation
	%NNClassifierMLP_CrossValidation is a process for evaluating multi-layer perceptron classifiers using cross-validation.
	% It is a subclass of <a href="matlab:help NNCrossValidation">NNCrossValidation</a>.
	%
	% A cross validation for multi-layer perceptron classifiers (NNClassifierMLP_CrossValidation) is a process that facilitates the evaluation of multi-layer perceptron classifiers using cross-validation. 
	%  It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. 
	%  This helps in assessing the generalization performance of the model and detecting overfitting.
	% 
	% To train all the neural networks for all folds, use: nncv.get('TRAIN')
	%
	% The list of NNClassifierMLP_CrossValidation properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the cross-validation.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the cross-validation.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the cross-validation.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the cross-validation.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the cross-validation.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the cross-validation.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the cross-validation.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>KFOLDS</strong> 	KFOLDS (data, scalar) is the number of folds.
	%  <strong>11</strong> <strong>SPLIT</strong> 	SPLIT (data, cell) is a cell containing the ratio numbers or the vectors stating which datapoints belong to the splitted neural network datasets.
	%  <strong>12</strong> <strong>D</strong> 	D (data, itemlist) is the datasets from groups to be cross-validated.
	%  <strong>13</strong> <strong>NN_TEMPLATE</strong> 	NN_TEMPLATE (parameter, item) is the neural network template to set all neural network parameters.
	%  <strong>14</strong> <strong>NNEVALUATOR_TEMPLATE</strong> 	NNEVALUATOR_TEMPLATE (parameter, item) is the neural network evaluator template to set all evalutor parameters.
	%  <strong>15</strong> <strong>DSP</strong> 	DSP (result, itemlist) is a list of dataset splitter that splits the dataset per group.
	%  <strong>16</strong> <strong>DCO</strong> 	DCO (result, itemlist) is a list of dataset combiners that combines the datasets per fold.
	%  <strong>17</strong> <strong>D_LIST</strong> 	D_LIST (result, itemlist) contains the split datasets corresponding to the k folds.
	%  <strong>18</strong> <strong>D_LIST_IT</strong> 	D_LIST_IT (query, item) returns a dataset at a specified index in the itemlist of splitted neural network datasets.
	%  <strong>19</strong> <strong>NN_LIST</strong> 	NN_LIST (result, itemlist) contains the neural network models corresponding to k folds.
	%  <strong>20</strong> <strong>NN_LIST_IT</strong> 	NN_LIST_IT (query, item) returns a neural networks model at a specified index in the itemlist of splitted neural network datasets.
	%  <strong>21</strong> <strong>EVALUATOR_LIST</strong> 	EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to k folds.
	%  <strong>22</strong> <strong>EVALUATOR_LIST_IT</strong> 	EVALUATOR_LIST_IT (query, item) returns a neural networks evaluator at a specified index in the itemlist of splitted neural network datasets.
	%  <strong>23</strong> <strong>EPOCHS</strong> 	EPOCHS (parameter, scalar) is the maximum number of epochs.
	%  <strong>24</strong> <strong>BATCH</strong> 	BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
	%  <strong>25</strong> <strong>SHUFFLE</strong> 	SHUFFLE (parameter, option) is an option for data shuffling.
	%  <strong>26</strong> <strong>SOLVER</strong> 	SOLVER (parameter, option) is an option for the solver.
	%  <strong>27</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display training progress information.
	%  <strong>28</strong> <strong>PLOT_TRAINING</strong> 	PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
	%  <strong>29</strong> <strong>TRAIN</strong> 	TRAIN (query, empty) trains all neural network models for all folds.
	%  <strong>30</strong> <strong>AV_AUC</strong> 	AV_AUC (result, rvector) provides the average value of the area under the receiver operating characteristic curve across k folds.
	%  <strong>31</strong> <strong>PFROC</strong> 	PFROC (gui, item) contains the panel figure of the ROC plot for classification model.
	%  <strong>32</strong> <strong>AV_MACRO_AUC</strong> 	AV_MACRO_AUC (result, scalar) provides the metric of the average macro AUC value across k folds.
	%  <strong>33</strong> <strong>C_MATRIX</strong> 	C_MATRIX (result, matrix) provides the confusion matrix across k folds.
	%
	% NNClassifierMLP_CrossValidation methods (constructor):
	%  NNClassifierMLP_CrossValidation - constructor
	%
	% NNClassifierMLP_CrossValidation methods:
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
	% NNClassifierMLP_CrossValidation methods (display):
	%  tostring - string with information about the neural network cross-validation for MLP classifiers
	%  disp - displays information about the neural network cross-validation for MLP classifiers
	%  tree - displays the tree of the neural network cross-validation for MLP classifiers
	%
	% NNClassifierMLP_CrossValidation methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network cross-validation for MLP classifiers are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network cross-validation for MLP classifiers
	%
	% NNClassifierMLP_CrossValidation methods (save/load, Static):
	%  save - saves BRAPH2 neural network cross-validation for MLP classifiers as b2 file
	%  load - loads a BRAPH2 neural network cross-validation for MLP classifiers from a b2 file
	%
	% NNClassifierMLP_CrossValidation method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network cross-validation for MLP classifiers
	%
	% NNClassifierMLP_CrossValidation method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network cross-validation for MLP classifiers
	%
	% NNClassifierMLP_CrossValidation methods (inspection, Static):
	%  getClass - returns the class of the neural network cross-validation for MLP classifiers
	%  getSubclasses - returns all subclasses of NNClassifierMLP_CrossValidation
	%  getProps - returns the property list of the neural network cross-validation for MLP classifiers
	%  getPropNumber - returns the property number of the neural network cross-validation for MLP classifiers
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
	% NNClassifierMLP_CrossValidation methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNClassifierMLP_CrossValidation methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNClassifierMLP_CrossValidation methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNClassifierMLP_CrossValidation methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNClassifierMLP_CrossValidation; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNClassifierMLP_CrossValidation constants</a>.
	%
	%
	% See also NNDataPoint, NNDataset, NNEvaluator.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		AV_AUC = 30; %CET: Computational Efficiency Trick
		AV_AUC_TAG = 'AV_AUC';
		AV_AUC_CATEGORY = 5;
		AV_AUC_FORMAT = 12;
		
		PFROC = 31; %CET: Computational Efficiency Trick
		PFROC_TAG = 'PFROC';
		PFROC_CATEGORY = 9;
		PFROC_FORMAT = 8;
		
		AV_MACRO_AUC = 32; %CET: Computational Efficiency Trick
		AV_MACRO_AUC_TAG = 'AV_MACRO_AUC';
		AV_MACRO_AUC_CATEGORY = 5;
		AV_MACRO_AUC_FORMAT = 11;
		
		C_MATRIX = 33; %CET: Computational Efficiency Trick
		C_MATRIX_TAG = 'C_MATRIX';
		C_MATRIX_CATEGORY = 5;
		C_MATRIX_FORMAT = 14;
	end
	methods % constructor
		function nncv = NNClassifierMLP_CrossValidation(varargin)
			%NNClassifierMLP_CrossValidation() creates a neural network cross-validation for MLP classifiers.
			%
			% NNClassifierMLP_CrossValidation(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNClassifierMLP_CrossValidation(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNClassifierMLP_CrossValidation properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the cross-validation.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the cross-validation.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the cross-validation.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the cross-validation.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the cross-validation.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the cross-validation.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the cross-validation.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>KFOLDS</strong> 	KFOLDS (data, scalar) is the number of folds.
			%  <strong>11</strong> <strong>SPLIT</strong> 	SPLIT (data, cell) is a cell containing the ratio numbers or the vectors stating which datapoints belong to the splitted neural network datasets.
			%  <strong>12</strong> <strong>D</strong> 	D (data, itemlist) is the datasets from groups to be cross-validated.
			%  <strong>13</strong> <strong>NN_TEMPLATE</strong> 	NN_TEMPLATE (parameter, item) is the neural network template to set all neural network parameters.
			%  <strong>14</strong> <strong>NNEVALUATOR_TEMPLATE</strong> 	NNEVALUATOR_TEMPLATE (parameter, item) is the neural network evaluator template to set all evalutor parameters.
			%  <strong>15</strong> <strong>DSP</strong> 	DSP (result, itemlist) is a list of dataset splitter that splits the dataset per group.
			%  <strong>16</strong> <strong>DCO</strong> 	DCO (result, itemlist) is a list of dataset combiners that combines the datasets per fold.
			%  <strong>17</strong> <strong>D_LIST</strong> 	D_LIST (result, itemlist) contains the split datasets corresponding to the k folds.
			%  <strong>18</strong> <strong>D_LIST_IT</strong> 	D_LIST_IT (query, item) returns a dataset at a specified index in the itemlist of splitted neural network datasets.
			%  <strong>19</strong> <strong>NN_LIST</strong> 	NN_LIST (result, itemlist) contains the neural network models corresponding to k folds.
			%  <strong>20</strong> <strong>NN_LIST_IT</strong> 	NN_LIST_IT (query, item) returns a neural networks model at a specified index in the itemlist of splitted neural network datasets.
			%  <strong>21</strong> <strong>EVALUATOR_LIST</strong> 	EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to k folds.
			%  <strong>22</strong> <strong>EVALUATOR_LIST_IT</strong> 	EVALUATOR_LIST_IT (query, item) returns a neural networks evaluator at a specified index in the itemlist of splitted neural network datasets.
			%  <strong>23</strong> <strong>EPOCHS</strong> 	EPOCHS (parameter, scalar) is the maximum number of epochs.
			%  <strong>24</strong> <strong>BATCH</strong> 	BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
			%  <strong>25</strong> <strong>SHUFFLE</strong> 	SHUFFLE (parameter, option) is an option for data shuffling.
			%  <strong>26</strong> <strong>SOLVER</strong> 	SOLVER (parameter, option) is an option for the solver.
			%  <strong>27</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display training progress information.
			%  <strong>28</strong> <strong>PLOT_TRAINING</strong> 	PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
			%  <strong>29</strong> <strong>TRAIN</strong> 	TRAIN (query, empty) trains all neural network models for all folds.
			%  <strong>30</strong> <strong>AV_AUC</strong> 	AV_AUC (result, rvector) provides the average value of the area under the receiver operating characteristic curve across k folds.
			%  <strong>31</strong> <strong>PFROC</strong> 	PFROC (gui, item) contains the panel figure of the ROC plot for classification model.
			%  <strong>32</strong> <strong>AV_MACRO_AUC</strong> 	AV_MACRO_AUC (result, scalar) provides the metric of the average macro AUC value across k folds.
			%  <strong>33</strong> <strong>C_MATRIX</strong> 	C_MATRIX (result, matrix) provides the confusion matrix across k folds.
			%
			% See also Category, Format.
			
			nncv = nncv@NNCrossValidation(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the neural network cross-validation for MLP classifiers.
			%
			% BUILD = NNClassifierMLP_CrossValidation.GETBUILD() returns the build of 'NNClassifierMLP_CrossValidation'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NNCV.GETBUILD() returns the build of the neural network cross-validation for MLP classifiers NNCV.
			%  BUILD = Element.GETBUILD(NNCV) returns the build of 'NNCV'.
			%  BUILD = Element.GETBUILD('NNClassifierMLP_CrossValidation') returns the build of 'NNClassifierMLP_CrossValidation'.
			%
			% Note that the Element.GETBUILD(NNCV) and Element.GETBUILD('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nncv_class = getClass()
			%GETCLASS returns the class of the neural network cross-validation for MLP classifiers.
			%
			% CLASS = NNClassifierMLP_CrossValidation.GETCLASS() returns the class 'NNClassifierMLP_CrossValidation'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNCV.GETCLASS() returns the class of the neural network cross-validation for MLP classifiers NNCV.
			%  CLASS = Element.GETCLASS(NNCV) returns the class of 'NNCV'.
			%  CLASS = Element.GETCLASS('NNClassifierMLP_CrossValidation') returns 'NNClassifierMLP_CrossValidation'.
			%
			% Note that the Element.GETCLASS(NNCV) and Element.GETCLASS('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			
			nncv_class = 'NNClassifierMLP_CrossValidation';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network cross-validation for MLP classifiers.
			%
			% LIST = NNClassifierMLP_CrossValidation.GETSUBCLASSES() returns all subclasses of 'NNClassifierMLP_CrossValidation'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNCV.GETSUBCLASSES() returns all subclasses of the neural network cross-validation for MLP classifiers NNCV.
			%  LIST = Element.GETSUBCLASSES(NNCV) returns all subclasses of 'NNCV'.
			%  LIST = Element.GETSUBCLASSES('NNClassifierMLP_CrossValidation') returns all subclasses of 'NNClassifierMLP_CrossValidation'.
			%
			% Note that the Element.GETSUBCLASSES(NNCV) and Element.GETSUBCLASSES('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNClassifierMLP_CrossValidation' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network cross-validation for MLP classifiers.
			%
			% PROPS = NNClassifierMLP_CrossValidation.GETPROPS() returns the property list of neural network cross-validation for MLP classifiers
			%  as a row vector.
			%
			% PROPS = NNClassifierMLP_CrossValidation.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNCV.GETPROPS([CATEGORY]) returns the property list of the neural network cross-validation for MLP classifiers NNCV.
			%  PROPS = Element.GETPROPS(NNCV[, CATEGORY]) returns the property list of 'NNCV'.
			%  PROPS = Element.GETPROPS('NNClassifierMLP_CrossValidation'[, CATEGORY]) returns the property list of 'NNClassifierMLP_CrossValidation'.
			%
			% Note that the Element.GETPROPS(NNCV) and Element.GETPROPS('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 28];
				case 3 % Category.PARAMETER
					prop_list = [4 13 14 23 24 25 26];
				case 4 % Category.DATA
					prop_list = [5 10 11 12];
				case 5 % Category.RESULT
					prop_list = [15 16 17 19 21 30 32 33];
				case 6 % Category.QUERY
					prop_list = [8 18 20 22 29];
				case 9 % Category.GUI
					prop_list = [9 27 31];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network cross-validation for MLP classifiers.
			%
			% N = NNClassifierMLP_CrossValidation.GETPROPNUMBER() returns the property number of neural network cross-validation for MLP classifiers.
			%
			% N = NNClassifierMLP_CrossValidation.GETPROPNUMBER(CATEGORY) returns the property number of neural network cross-validation for MLP classifiers
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNCV.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network cross-validation for MLP classifiers NNCV.
			%  N = Element.GETPROPNUMBER(NNCV) returns the property number of 'NNCV'.
			%  N = Element.GETPROPNUMBER('NNClassifierMLP_CrossValidation') returns the property number of 'NNClassifierMLP_CrossValidation'.
			%
			% Note that the Element.GETPROPNUMBER(NNCV) and Element.GETPROPNUMBER('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 33;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 7;
				case 4 % Category.DATA
					prop_number = 4;
				case 5 % Category.RESULT
					prop_number = 8;
				case 6 % Category.QUERY
					prop_number = 5;
				case 9 % Category.GUI
					prop_number = 3;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network cross-validation for MLP classifiers/error.
			%
			% CHECK = NNClassifierMLP_CrossValidation.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNCV.EXISTSPROP(PROP) checks whether PROP exists for NNCV.
			%  CHECK = Element.EXISTSPROP(NNCV, PROP) checks whether PROP exists for NNCV.
			%  CHECK = Element.EXISTSPROP(NNClassifierMLP_CrossValidation, PROP) checks whether PROP exists for NNClassifierMLP_CrossValidation.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNCV.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			%  Element.EXISTSPROP(NNCV, PROP) throws error if PROP does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			%  Element.EXISTSPROP(NNClassifierMLP_CrossValidation, PROP) throws error if PROP does NOT exist for NNClassifierMLP_CrossValidation.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNCV) and Element.EXISTSPROP('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 33 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_CrossValidation:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_CrossValidation:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNClassifierMLP_CrossValidation.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network cross-validation for MLP classifiers/error.
			%
			% CHECK = NNClassifierMLP_CrossValidation.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNCV.EXISTSTAG(TAG) checks whether TAG exists for NNCV.
			%  CHECK = Element.EXISTSTAG(NNCV, TAG) checks whether TAG exists for NNCV.
			%  CHECK = Element.EXISTSTAG(NNClassifierMLP_CrossValidation, TAG) checks whether TAG exists for NNClassifierMLP_CrossValidation.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNCV.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			%  Element.EXISTSTAG(NNCV, TAG) throws error if TAG does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			%  Element.EXISTSTAG(NNClassifierMLP_CrossValidation, TAG) throws error if TAG does NOT exist for NNClassifierMLP_CrossValidation.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNCV) and Element.EXISTSTAG('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'KFOLDS'  'SPLIT'  'D'  'NN_TEMPLATE'  'NNEVALUATOR_TEMPLATE'  'DSP'  'DCO'  'D_LIST'  'D_LIST_IT'  'NN_LIST'  'NN_LIST_IT'  'EVALUATOR_LIST'  'EVALUATOR_LIST_IT'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'VERBOSE'  'PLOT_TRAINING'  'TRAIN'  'AV_AUC'  'PFROC'  'AV_MACRO_AUC'  'C_MATRIX' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_CrossValidation:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_CrossValidation:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNClassifierMLP_CrossValidation.'] ...
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
			%  PROPERTY = NNCV.GETPROPPROP(POINTER) returns property number of POINTER of NNCV.
			%  PROPERTY = Element.GETPROPPROP(NNClassifierMLP_CrossValidation, POINTER) returns property number of POINTER of NNClassifierMLP_CrossValidation.
			%  PROPERTY = NNCV.GETPROPPROP(NNClassifierMLP_CrossValidation, POINTER) returns property number of POINTER of NNClassifierMLP_CrossValidation.
			%
			% Note that the Element.GETPROPPROP(NNCV) and Element.GETPROPPROP('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'KFOLDS'  'SPLIT'  'D'  'NN_TEMPLATE'  'NNEVALUATOR_TEMPLATE'  'DSP'  'DCO'  'D_LIST'  'D_LIST_IT'  'NN_LIST'  'NN_LIST_IT'  'EVALUATOR_LIST'  'EVALUATOR_LIST_IT'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'VERBOSE'  'PLOT_TRAINING'  'TRAIN'  'AV_AUC'  'PFROC'  'AV_MACRO_AUC'  'C_MATRIX' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = NNCV.GETPROPTAG(POINTER) returns tag of POINTER of NNCV.
			%  TAG = Element.GETPROPTAG(NNClassifierMLP_CrossValidation, POINTER) returns tag of POINTER of NNClassifierMLP_CrossValidation.
			%  TAG = NNCV.GETPROPTAG(NNClassifierMLP_CrossValidation, POINTER) returns tag of POINTER of NNClassifierMLP_CrossValidation.
			%
			% Note that the Element.GETPROPTAG(NNCV) and Element.GETPROPTAG('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnclassifiermlp_crossvalidation_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'KFOLDS'  'SPLIT'  'D'  'NN_TEMPLATE'  'NNEVALUATOR_TEMPLATE'  'DSP'  'DCO'  'D_LIST'  'D_LIST_IT'  'NN_LIST'  'NN_LIST_IT'  'EVALUATOR_LIST'  'EVALUATOR_LIST_IT'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'VERBOSE'  'PLOT_TRAINING'  'TRAIN'  'AV_AUC'  'PFROC'  'AV_MACRO_AUC'  'C_MATRIX' };
				tag = nnclassifiermlp_crossvalidation_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = NNCV.GETPROPCATEGORY(POINTER) returns category of POINTER of NNCV.
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierMLP_CrossValidation, POINTER) returns category of POINTER of NNClassifierMLP_CrossValidation.
			%  CATEGORY = NNCV.GETPROPCATEGORY(NNClassifierMLP_CrossValidation, POINTER) returns category of POINTER of NNClassifierMLP_CrossValidation.
			%
			% Note that the Element.GETPROPCATEGORY(NNCV) and Element.GETPROPCATEGORY('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidation.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_crossvalidation_category_list = { 1  1  1  3  4  2  2  6  9  4  4  4  3  3  5  5  5  6  5  6  5  6  3  3  3  3  9  2  6  5  9  5  5 };
			prop_category = nnclassifiermlp_crossvalidation_category_list{prop};
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
			%  FORMAT = NNCV.GETPROPFORMAT(POINTER) returns format of POINTER of NNCV.
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierMLP_CrossValidation, POINTER) returns format of POINTER of NNClassifierMLP_CrossValidation.
			%  FORMAT = NNCV.GETPROPFORMAT(NNClassifierMLP_CrossValidation, POINTER) returns format of POINTER of NNClassifierMLP_CrossValidation.
			%
			% Note that the Element.GETPROPFORMAT(NNCV) and Element.GETPROPFORMAT('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidation.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_crossvalidation_format_list = { 2  2  2  8  2  2  2  2  4  11  16  9  8  8  9  9  9  8  9  8  9  8  11  11  5  5  4  5  1  12  8  11  14 };
			prop_format = nnclassifiermlp_crossvalidation_format_list{prop};
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
			%  DESCRIPTION = NNCV.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNCV.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierMLP_CrossValidation, POINTER) returns description of POINTER of NNClassifierMLP_CrossValidation.
			%  DESCRIPTION = NNCV.GETPROPDESCRIPTION(NNClassifierMLP_CrossValidation, POINTER) returns description of POINTER of NNClassifierMLP_CrossValidation.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNCV) and Element.GETPROPDESCRIPTION('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidation.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_crossvalidation_description_list = { 'ELCLASS (constant, string) is the class of the cross-validation.'  'NAME (constant, string) is the name of the cross-validation.'  'DESCRIPTION (constant, string) is the description of the cross-validation.'  'TEMPLATE (parameter, item) is the template of the cross-validation.'  'ID (data, string) is a few-letter code for the cross-validation.'  'LABEL (metadata, string) is an extended label of the cross-validation.'  'NOTES (metadata, string) are some specific notes about the cross-validation.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'KFOLDS (data, scalar) is the number of folds.'  'SPLIT (data, cell) is a cell containing the ratio numbers or the vectors stating which datapoints belong to the splitted neural network datasets.'  'D (data, itemlist) is the datasets from groups to be cross-validated.'  'NN_TEMPLATE (parameter, item) is the neural network template to set all neural network parameters.'  'NNEVALUATOR_TEMPLATE (parameter, item) is the neural network evaluator template to set all evalutor parameters.'  'DSP (result, itemlist) is a list of dataset splitter that splits the dataset per group.'  'DCO (result, itemlist) is a list of dataset combiners that combines the datasets per fold.'  'D_LIST (result, itemlist) contains the split datasets corresponding to the k folds.'  'D_LIST_IT (query, item) returns a dataset at a specified index in the itemlist of splitted neural network datasets.'  'NN_LIST (result, itemlist) contains the neural network models corresponding to k folds.'  'NN_LIST_IT (query, item) returns a neural networks model at a specified index in the itemlist of splitted neural network datasets.'  'EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to k folds.'  'EVALUATOR_LIST_IT (query, item) returns a neural networks evaluator at a specified index in the itemlist of splitted neural network datasets.'  'EPOCHS (parameter, scalar) is the maximum number of epochs.'  'BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.'  'SHUFFLE (parameter, option) is an option for data shuffling.'  'SOLVER (parameter, option) is an option for the solver.'  'VERBOSE (gui, logical) is an indicator to display training progress information.'  'PLOT_TRAINING (metadata, option) determines whether to plot the training progress.'  'TRAIN (query, empty) trains all neural network models for all folds.'  'AV_AUC (result, rvector) provides the average value of the area under the receiver operating characteristic curve across k folds.'  'PFROC (gui, item) contains the panel figure of the ROC plot for classification model.'  'AV_MACRO_AUC (result, scalar) provides the metric of the average macro AUC value across k folds.'  'C_MATRIX (result, matrix) provides the confusion matrix across k folds.' };
			prop_description = nnclassifiermlp_crossvalidation_description_list{prop};
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
			%  SETTINGS = NNCV.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNCV.
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierMLP_CrossValidation, POINTER) returns settings of POINTER of NNClassifierMLP_CrossValidation.
			%  SETTINGS = NNCV.GETPROPSETTINGS(NNClassifierMLP_CrossValidation, POINTER) returns settings of POINTER of NNClassifierMLP_CrossValidation.
			%
			% Note that the Element.GETPROPSETTINGS(NNCV) and Element.GETPROPSETTINGS('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidation.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 30 % NNClassifierMLP_CrossValidation.AV_AUC
					prop_settings = Format.getFormatSettings(12);
				case 31 % NNClassifierMLP_CrossValidation.PFROC
					prop_settings = 'NNClassifierMLP_CrossValidationPF_ROC';
				case 32 % NNClassifierMLP_CrossValidation.AV_MACRO_AUC
					prop_settings = Format.getFormatSettings(11);
				case 33 % NNClassifierMLP_CrossValidation.C_MATRIX
					prop_settings = Format.getFormatSettings(14);
				case 4 % NNClassifierMLP_CrossValidation.TEMPLATE
					prop_settings = 'NNClassifierMLP_CrossValidation';
				case 13 % NNClassifierMLP_CrossValidation.NN_TEMPLATE
					prop_settings = 'NNClassifierMLP';
				case 14 % NNClassifierMLP_CrossValidation.NNEVALUATOR_TEMPLATE
					prop_settings = 'NNClassifierMLP_Evaluator';
				otherwise
					prop_settings = getPropSettings@NNCrossValidation(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNClassifierMLP_CrossValidation.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_CrossValidation.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNCV.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNCV.
			%  DEFAULT = Element.GETPROPDEFAULT(NNClassifierMLP_CrossValidation, POINTER) returns the default value of POINTER of NNClassifierMLP_CrossValidation.
			%  DEFAULT = NNCV.GETPROPDEFAULT(NNClassifierMLP_CrossValidation, POINTER) returns the default value of POINTER of NNClassifierMLP_CrossValidation.
			%
			% Note that the Element.GETPROPDEFAULT(NNCV) and Element.GETPROPDEFAULT('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierMLP_CrossValidation.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 30 % NNClassifierMLP_CrossValidation.AV_AUC
					prop_default = Format.getFormatDefault(12, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case 31 % NNClassifierMLP_CrossValidation.PFROC
					prop_default = Format.getFormatDefault(8, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case 32 % NNClassifierMLP_CrossValidation.AV_MACRO_AUC
					prop_default = Format.getFormatDefault(11, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case 33 % NNClassifierMLP_CrossValidation.C_MATRIX
					prop_default = Format.getFormatDefault(14, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case 1 % NNClassifierMLP_CrossValidation.ELCLASS
					prop_default = 'NNClassifierMLP_CrossValidation';
				case 2 % NNClassifierMLP_CrossValidation.NAME
					prop_default = 'Neural Network Cross-Validation for Multi-layer Perceptron Classifiers';
				case 3 % NNClassifierMLP_CrossValidation.DESCRIPTION
					prop_default = 'A cross validation for multi-layer perceptron classifiers (NNClassifierMLP_CrossValidation) is a process that facilitates the evaluation of multi-layer perceptron classifiers using cross-validation. It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. This helps in assessing the generalization performance of the model and detecting overfitting.';
				case 4 % NNClassifierMLP_CrossValidation.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case 5 % NNClassifierMLP_CrossValidation.ID
					prop_default = 'NNClassifierMLP_CrossValidation ID';
				case 6 % NNClassifierMLP_CrossValidation.LABEL
					prop_default = 'NNClassifierMLP_CrossValidation label';
				case 7 % NNClassifierMLP_CrossValidation.NOTES
					prop_default = 'NNClassifierMLP_CrossValidation notes';
				case 13 % NNClassifierMLP_CrossValidation.NN_TEMPLATE
					prop_default = Format.getFormatDefault(8, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case 14 % NNClassifierMLP_CrossValidation.NNEVALUATOR_TEMPLATE
					prop_default = Format.getFormatDefault(8, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNCrossValidation(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNClassifierMLP_CrossValidation.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_CrossValidation.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNCV.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNCV.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_CrossValidation, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_CrossValidation.
			%  DEFAULT = NNCV.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_CrossValidation, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_CrossValidation.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNCV) and Element.GETPROPDEFAULTCONDITIONED('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNClassifierMLP_CrossValidation.getPropProp(pointer);
			
			prop_default = NNClassifierMLP_CrossValidation.conditioning(prop, NNClassifierMLP_CrossValidation.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNCV.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNCV.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNCV.
			%  CHECK = Element.CHECKPROP(NNClassifierMLP_CrossValidation, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_CrossValidation.
			%  CHECK = NNCV.CHECKPROP(NNClassifierMLP_CrossValidation, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_CrossValidation.
			% 
			% NNCV.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNClassifierMLP_CrossValidation:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNCV.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNCV.
			%   Error id: BRAPH2:NNClassifierMLP_CrossValidation:WrongInput
			%  Element.CHECKPROP(NNClassifierMLP_CrossValidation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_CrossValidation.
			%   Error id: BRAPH2:NNClassifierMLP_CrossValidation:WrongInput
			%  NNCV.CHECKPROP(NNClassifierMLP_CrossValidation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_CrossValidation.
			%   Error id: BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NNCV) and Element.CHECKPROP('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNClassifierMLP_CrossValidation.getPropProp(pointer);
			
			switch prop
				case 30 % NNClassifierMLP_CrossValidation.AV_AUC
					check = Format.checkFormat(12, value, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case 31 % NNClassifierMLP_CrossValidation.PFROC
					check = Format.checkFormat(8, value, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case 32 % NNClassifierMLP_CrossValidation.AV_MACRO_AUC
					check = Format.checkFormat(11, value, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case 33 % NNClassifierMLP_CrossValidation.C_MATRIX
					check = Format.checkFormat(14, value, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case 4 % NNClassifierMLP_CrossValidation.TEMPLATE
					check = Format.checkFormat(8, value, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case 13 % NNClassifierMLP_CrossValidation.NN_TEMPLATE
					check = Format.checkFormat(8, value, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case 14 % NNClassifierMLP_CrossValidation.NNEVALUATOR_TEMPLATE
					check = Format.checkFormat(8, value, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				otherwise
					if prop <= 29
						check = checkProp@NNCrossValidation(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_CrossValidation:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_CrossValidation:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNClassifierMLP_CrossValidation.getPropTag(prop) ' (' NNClassifierMLP_CrossValidation.getFormatTag(NNClassifierMLP_CrossValidation.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(nncv, prop)
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
				case 31 % NNClassifierMLP_CrossValidation.PFROC
					if isa(nncv.getr('PFROC'), 'NoValue')
					    nncv.set('PFROC', NNClassifierMLP_CrossValidationPF_ROC('NNCV', nncv));
					end
					
				otherwise
					if prop <= 29
						postprocessing@NNCrossValidation(nncv, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nncv, prop, varargin)
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
				case 30 % NNClassifierMLP_CrossValidation.AV_AUC
					rng_settings_ = rng(); rng(nncv.getPropSeed(30), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					aucs = cellfun(@(e) e.get('AUC'), ...
					    e_list, 'UniformOutput', false);
					
					if isempty(aucs)
					    value = [];
					else
					    value = mean(cell2mat(aucs), 1);
					end
					
					rng(rng_settings_)
					
				case 32 % NNClassifierMLP_CrossValidation.AV_MACRO_AUC
					rng_settings_ = rng(); rng(nncv.getPropSeed(32), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					macro_aucs = cellfun(@(e) e.get('MACRO_AUC'), ...
					    e_list, 'UniformOutput', false);
					
					if isempty(macro_aucs)
					    value = 0;
					else
					    value = mean(cell2mat(macro_aucs), 1);
					end
					
					rng(rng_settings_)
					
				case 33 % NNClassifierMLP_CrossValidation.C_MATRIX
					rng_settings_ = rng(); rng(nncv.getPropSeed(33), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					c_matrices = cellfun(@(e) e.get('C_MATRIX'), ...
					    e_list, 'UniformOutput', false);
					
					combined_c_matrix = cellfun(@(x) double(x), c_matrices, 'UniformOutput', false);
					value = sum(cat(3, combined_c_matrix{:}), 3);
					
					rng(rng_settings_)
					
				case 19 % NNClassifierMLP_CrossValidation.NN_LIST
					rng_settings_ = rng(); rng(nncv.getPropSeed(19), 'twister')
					
					d_list = nncv.get('D_LIST');
					
					if isempty(d_list)
					    value = {};
					else
					    for i = 1:length(d_list)
					        d_training_set{i} = d_list;
					        d_training_set{i}(i) = [];  % Exclude the i-th element
					        d_training_set{i} = NNDatasetCombine('D_LIST', d_training_set{i}).get('D');
					    end
					    
					    d_training_set = d_training_set';
					    
					    if ~isa(nncv.getr('NN_TEMPLATE'), 'NoValue')
					        nn_template = nncv.get('NN_TEMPLATE');
					    else
					        nn_template = NNClassifierMLP( ...
					            'EPOCHS', nncv.get('EPOCHS'), ...
					            'BATCH', nncv.get('BATCH'), ...
					            'SHUFFLE', nncv.get('SHUFFLE'), ...
					            'SOLVER', nncv.get('SOLVER'), ...
					            'VERBOSE', nncv.get('VERBOSE'), ...
					            'PLOT_TRAINING', nncv.get('PLOT_TRAINING'));
					    end
					    
					    value = cellfun(@(d) NNClassifierMLP( ...
					        'TEMPLATE', nn_template, 'D', d, 'VERBOSE', nncv.get('VERBOSE'), 'PLOT_TRAINING', nncv.get('PLOT_TRAINING')), ...
					        d_training_set, 'UniformOutput', false);
					end
					
					rng(rng_settings_)
					
				case 21 % NNClassifierMLP_CrossValidation.EVALUATOR_LIST
					rng_settings_ = rng(); rng(nncv.getPropSeed(21), 'twister')
					
					d_list = nncv.get('D_LIST');
					nn_list = nncv.get('NN_LIST');
					
					if ~isa(nncv.getr('NNEVALUATOR_TEMPLATE'), 'NoValue')
					    nne_template = nncv.get('NNEVALUATOR_TEMPLATE');
					else
					    nne_template = NNClassifierMLP_Evaluator();
					end
					
					value = cellfun(@(d, nn) NNClassifierMLP_Evaluator('TEMPLATE', nne_template, 'D', d, 'NN', nn), ...
					    d_list, nn_list, 'UniformOutput', false);
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 29
						value = calculateValue@NNCrossValidation(nncv, prop, varargin{:});
					else
						value = calculateValue@Element(nncv, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(nncv, prop, varargin)
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
				case 31 % NNClassifierMLP_CrossValidation.PFROC
					pr = PanelPropItem('EL', nncv, 'PROP', 31, ...
					    'GUICLASS', 'GUIFig', ...
						'BUTTON_TEXT', ['ROC Plot'], ...
					    varargin{:});
					
				case 33 % NNClassifierMLP_CrossValidation.C_MATRIX
					d = NNDatasetCombine('D_LIST', nncv.get('D')).get('D');
					targets = NNClassifierMLP().get('TARGET_CLASSES', d);
					class_names = unique(targets);
					pr = PanelPropMatrix('EL', nncv, 'PROP', 33, ...
					    'TABLE_HEIGHT', 480, ...
					    'ROWNAME', class_names, ...
					    'COLUMNNAME', class_names, ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@NNCrossValidation(nncv, prop, varargin{:});
					
			end
		end
	end
end
