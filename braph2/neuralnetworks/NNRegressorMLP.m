classdef NNRegressorMLP < NNBase
	%NNRegressorMLP comprises a multi-layer perceptron regressor model and a given dataset.
	% It is a subclass of <a href="matlab:help NNBase">NNBase</a>.
	%
	% A neural network multi-layer perceptron regressor (NNRegressorMLP) comprises 
	%  a multi-layer perceptron regressor model and a given dataset.
	% NNRegressorMLP trains the multi-layer perceptron regressor with a formatted
	%  inputs ("CB", channel and batch) derived from the given dataset.
	%
	% The list of NNRegressorMLP properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the neural network multi-layer perceptron regressor.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural network multi-layer perceptron regressor.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural network multi-layer perceptron regressor.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural network multi-layer perceptron regressor.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the neural network multi-layer perceptron regressor.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural network multi-layer perceptron regressor.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the neural network multi-layer perceptron regressor.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>D</strong> 	D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
	%  <strong>10</strong> <strong>DP_CLASSES</strong> 	DP_CLASSES (parameter, classlist) is the list of compatible data points.
	%  <strong>11</strong> <strong>EPOCHS</strong> 	EPOCHS (parameter, scalar) is the maximum number of epochs.
	%  <strong>12</strong> <strong>BATCH</strong> 	BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
	%  <strong>13</strong> <strong>SHUFFLE</strong> 	SHUFFLE (parameter, option) is an option for data shuffling.
	%  <strong>14</strong> <strong>SOLVER</strong> 	SOLVER (parameter, option) is an option for the solver.
	%  <strong>15</strong> <strong>MODEL</strong> 	MODEL (result, net) is a trained neural network model.
	%  <strong>16</strong> <strong>INPUTS</strong> 	INPUTS (query, cell) constructs the data in the CB (channel-batch) format.
	%  <strong>17</strong> <strong>TARGETS</strong> 	TARGETS (query, cell) constructs the targets in the CB (channel-batch) format.
	%  <strong>18</strong> <strong>TRAIN</strong> 	TRAIN (query, empty) trains the neural network model with the given dataset.
	%  <strong>19</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display training progress information.
	%  <strong>20</strong> <strong>PLOT_TRAINING</strong> 	PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
	%  <strong>21</strong> <strong>PREDICT</strong> 	PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.
	%  <strong>22</strong> <strong>LAYERS</strong> 	LAYERS (data, rvector) defines the number of layers and their neurons.
	%  <strong>23</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>24</strong> <strong>INTERRUPTIBLE</strong> 	INTERRUPTIBLE (gui, scalar) sets whether the comparison computation is interruptible for multitasking.
	%  <strong>25</strong> <strong>FEATURE_IMPORTANCE</strong> 	FEATURE_IMPORTANCE (query, cell) evaluates the average significance of each feature by iteratively shuffling its values P times and measuring the resulting average decrease in model performance.
	%
	% NNRegressorMLP methods (constructor):
	%  NNRegressorMLP - constructor
	%
	% NNRegressorMLP methods:
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
	% NNRegressorMLP methods (display):
	%  tostring - string with information about the multi-layer perceptron regressor
	%  disp - displays information about the multi-layer perceptron regressor
	%  tree - displays the tree of the multi-layer perceptron regressor
	%
	% NNRegressorMLP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multi-layer perceptron regressor are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multi-layer perceptron regressor
	%
	% NNRegressorMLP methods (save/load, Static):
	%  save - saves BRAPH2 multi-layer perceptron regressor as b2 file
	%  load - loads a BRAPH2 multi-layer perceptron regressor from a b2 file
	%
	% NNRegressorMLP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multi-layer perceptron regressor
	%
	% NNRegressorMLP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multi-layer perceptron regressor
	%
	% NNRegressorMLP methods (inspection, Static):
	%  getClass - returns the class of the multi-layer perceptron regressor
	%  getSubclasses - returns all subclasses of NNRegressorMLP
	%  getProps - returns the property list of the multi-layer perceptron regressor
	%  getPropNumber - returns the property number of the multi-layer perceptron regressor
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
	% NNRegressorMLP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNRegressorMLP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNRegressorMLP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNRegressorMLP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNRegressorMLP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNRegressorMLP constants</a>.
	%
	%
	% See also NNDataPoint_CON_REG, NNRegressor_Evaluator.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		LAYERS = 22; %CET: Computational Efficiency Trick
		LAYERS_TAG = 'LAYERS';
		LAYERS_CATEGORY = 4;
		LAYERS_FORMAT = 12;
		
		WAITBAR = 23; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
		
		INTERRUPTIBLE = 24; %CET: Computational Efficiency Trick
		INTERRUPTIBLE_TAG = 'INTERRUPTIBLE';
		INTERRUPTIBLE_CATEGORY = 9;
		INTERRUPTIBLE_FORMAT = 11;
		
		FEATURE_IMPORTANCE = 25; %CET: Computational Efficiency Trick
		FEATURE_IMPORTANCE_TAG = 'FEATURE_IMPORTANCE';
		FEATURE_IMPORTANCE_CATEGORY = 6;
		FEATURE_IMPORTANCE_FORMAT = 16;
	end
	methods % constructor
		function nn = NNRegressorMLP(varargin)
			%NNRegressorMLP() creates a multi-layer perceptron regressor.
			%
			% NNRegressorMLP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNRegressorMLP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNRegressorMLP properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the neural network multi-layer perceptron regressor.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural network multi-layer perceptron regressor.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural network multi-layer perceptron regressor.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural network multi-layer perceptron regressor.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the neural network multi-layer perceptron regressor.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural network multi-layer perceptron regressor.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the neural network multi-layer perceptron regressor.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>D</strong> 	D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
			%  <strong>10</strong> <strong>DP_CLASSES</strong> 	DP_CLASSES (parameter, classlist) is the list of compatible data points.
			%  <strong>11</strong> <strong>EPOCHS</strong> 	EPOCHS (parameter, scalar) is the maximum number of epochs.
			%  <strong>12</strong> <strong>BATCH</strong> 	BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
			%  <strong>13</strong> <strong>SHUFFLE</strong> 	SHUFFLE (parameter, option) is an option for data shuffling.
			%  <strong>14</strong> <strong>SOLVER</strong> 	SOLVER (parameter, option) is an option for the solver.
			%  <strong>15</strong> <strong>MODEL</strong> 	MODEL (result, net) is a trained neural network model.
			%  <strong>16</strong> <strong>INPUTS</strong> 	INPUTS (query, cell) constructs the data in the CB (channel-batch) format.
			%  <strong>17</strong> <strong>TARGETS</strong> 	TARGETS (query, cell) constructs the targets in the CB (channel-batch) format.
			%  <strong>18</strong> <strong>TRAIN</strong> 	TRAIN (query, empty) trains the neural network model with the given dataset.
			%  <strong>19</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display training progress information.
			%  <strong>20</strong> <strong>PLOT_TRAINING</strong> 	PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
			%  <strong>21</strong> <strong>PREDICT</strong> 	PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.
			%  <strong>22</strong> <strong>LAYERS</strong> 	LAYERS (data, rvector) defines the number of layers and their neurons.
			%  <strong>23</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>24</strong> <strong>INTERRUPTIBLE</strong> 	INTERRUPTIBLE (gui, scalar) sets whether the comparison computation is interruptible for multitasking.
			%  <strong>25</strong> <strong>FEATURE_IMPORTANCE</strong> 	FEATURE_IMPORTANCE (query, cell) evaluates the average significance of each feature by iteratively shuffling its values P times and measuring the resulting average decrease in model performance.
			%
			% See also Category, Format.
			
			nn = nn@NNBase(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the multi-layer perceptron regressor.
			%
			% BUILD = NNRegressorMLP.GETBUILD() returns the build of 'NNRegressorMLP'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NN.GETBUILD() returns the build of the multi-layer perceptron regressor NN.
			%  BUILD = Element.GETBUILD(NN) returns the build of 'NN'.
			%  BUILD = Element.GETBUILD('NNRegressorMLP') returns the build of 'NNRegressorMLP'.
			%
			% Note that the Element.GETBUILD(NN) and Element.GETBUILD('NNRegressorMLP')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nn_class = getClass()
			%GETCLASS returns the class of the multi-layer perceptron regressor.
			%
			% CLASS = NNRegressorMLP.GETCLASS() returns the class 'NNRegressorMLP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NN.GETCLASS() returns the class of the multi-layer perceptron regressor NN.
			%  CLASS = Element.GETCLASS(NN) returns the class of 'NN'.
			%  CLASS = Element.GETCLASS('NNRegressorMLP') returns 'NNRegressorMLP'.
			%
			% Note that the Element.GETCLASS(NN) and Element.GETCLASS('NNRegressorMLP')
			%  are less computationally efficient.
			
			nn_class = 'NNRegressorMLP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multi-layer perceptron regressor.
			%
			% LIST = NNRegressorMLP.GETSUBCLASSES() returns all subclasses of 'NNRegressorMLP'.
			%
			% Alternative forms to call this method are:
			%  LIST = NN.GETSUBCLASSES() returns all subclasses of the multi-layer perceptron regressor NN.
			%  LIST = Element.GETSUBCLASSES(NN) returns all subclasses of 'NN'.
			%  LIST = Element.GETSUBCLASSES('NNRegressorMLP') returns all subclasses of 'NNRegressorMLP'.
			%
			% Note that the Element.GETSUBCLASSES(NN) and Element.GETSUBCLASSES('NNRegressorMLP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNRegressorMLP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multi-layer perceptron regressor.
			%
			% PROPS = NNRegressorMLP.GETPROPS() returns the property list of multi-layer perceptron regressor
			%  as a row vector.
			%
			% PROPS = NNRegressorMLP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NN.GETPROPS([CATEGORY]) returns the property list of the multi-layer perceptron regressor NN.
			%  PROPS = Element.GETPROPS(NN[, CATEGORY]) returns the property list of 'NN'.
			%  PROPS = Element.GETPROPS('NNRegressorMLP'[, CATEGORY]) returns the property list of 'NNRegressorMLP'.
			%
			% Note that the Element.GETPROPS(NN) and Element.GETPROPS('NNRegressorMLP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 20];
				case 3 % Category.PARAMETER
					prop_list = [4 10 11 12 13 14];
				case 4 % Category.DATA
					prop_list = [5 9 22];
				case 5 % Category.RESULT
					prop_list = 15;
				case 6 % Category.QUERY
					prop_list = [8 16 17 18 21 25];
				case 9 % Category.GUI
					prop_list = [19 23 24];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of multi-layer perceptron regressor.
			%
			% N = NNRegressorMLP.GETPROPNUMBER() returns the property number of multi-layer perceptron regressor.
			%
			% N = NNRegressorMLP.GETPROPNUMBER(CATEGORY) returns the property number of multi-layer perceptron regressor
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NN.GETPROPNUMBER([CATEGORY]) returns the property number of the multi-layer perceptron regressor NN.
			%  N = Element.GETPROPNUMBER(NN) returns the property number of 'NN'.
			%  N = Element.GETPROPNUMBER('NNRegressorMLP') returns the property number of 'NNRegressorMLP'.
			%
			% Note that the Element.GETPROPNUMBER(NN) and Element.GETPROPNUMBER('NNRegressorMLP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 25;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 6;
				case 4 % Category.DATA
					prop_number = 3;
				case 5 % Category.RESULT
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 6;
				case 9 % Category.GUI
					prop_number = 3;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multi-layer perceptron regressor/error.
			%
			% CHECK = NNRegressorMLP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NN.EXISTSPROP(PROP) checks whether PROP exists for NN.
			%  CHECK = Element.EXISTSPROP(NN, PROP) checks whether PROP exists for NN.
			%  CHECK = Element.EXISTSPROP(NNRegressorMLP, PROP) checks whether PROP exists for NNRegressorMLP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNRegressorMLP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NN.EXISTSPROP(PROP) throws error if PROP does NOT exist for NN.
			%   Error id: [BRAPH2:NNRegressorMLP:WrongInput]
			%  Element.EXISTSPROP(NN, PROP) throws error if PROP does NOT exist for NN.
			%   Error id: [BRAPH2:NNRegressorMLP:WrongInput]
			%  Element.EXISTSPROP(NNRegressorMLP, PROP) throws error if PROP does NOT exist for NNRegressorMLP.
			%   Error id: [BRAPH2:NNRegressorMLP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NN) and Element.EXISTSPROP('NNRegressorMLP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 25 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNRegressorMLP:' 'WrongInput'], ...
					['BRAPH2' ':NNRegressorMLP:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNRegressorMLP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multi-layer perceptron regressor/error.
			%
			% CHECK = NNRegressorMLP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NN.EXISTSTAG(TAG) checks whether TAG exists for NN.
			%  CHECK = Element.EXISTSTAG(NN, TAG) checks whether TAG exists for NN.
			%  CHECK = Element.EXISTSTAG(NNRegressorMLP, TAG) checks whether TAG exists for NNRegressorMLP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNRegressorMLP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NN.EXISTSTAG(TAG) throws error if TAG does NOT exist for NN.
			%   Error id: [BRAPH2:NNRegressorMLP:WrongInput]
			%  Element.EXISTSTAG(NN, TAG) throws error if TAG does NOT exist for NN.
			%   Error id: [BRAPH2:NNRegressorMLP:WrongInput]
			%  Element.EXISTSTAG(NNRegressorMLP, TAG) throws error if TAG does NOT exist for NNRegressorMLP.
			%   Error id: [BRAPH2:NNRegressorMLP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NN) and Element.EXISTSTAG('NNRegressorMLP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT'  'LAYERS'  'WAITBAR'  'INTERRUPTIBLE'  'FEATURE_IMPORTANCE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNRegressorMLP:' 'WrongInput'], ...
					['BRAPH2' ':NNRegressorMLP:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNRegressorMLP.'] ...
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
			%  PROPERTY = NN.GETPROPPROP(POINTER) returns property number of POINTER of NN.
			%  PROPERTY = Element.GETPROPPROP(NNRegressorMLP, POINTER) returns property number of POINTER of NNRegressorMLP.
			%  PROPERTY = NN.GETPROPPROP(NNRegressorMLP, POINTER) returns property number of POINTER of NNRegressorMLP.
			%
			% Note that the Element.GETPROPPROP(NN) and Element.GETPROPPROP('NNRegressorMLP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT'  'LAYERS'  'WAITBAR'  'INTERRUPTIBLE'  'FEATURE_IMPORTANCE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = NN.GETPROPTAG(POINTER) returns tag of POINTER of NN.
			%  TAG = Element.GETPROPTAG(NNRegressorMLP, POINTER) returns tag of POINTER of NNRegressorMLP.
			%  TAG = NN.GETPROPTAG(NNRegressorMLP, POINTER) returns tag of POINTER of NNRegressorMLP.
			%
			% Note that the Element.GETPROPTAG(NN) and Element.GETPROPTAG('NNRegressorMLP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnregressormlp_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT'  'LAYERS'  'WAITBAR'  'INTERRUPTIBLE'  'FEATURE_IMPORTANCE' };
				tag = nnregressormlp_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = NN.GETPROPCATEGORY(POINTER) returns category of POINTER of NN.
			%  CATEGORY = Element.GETPROPCATEGORY(NNRegressorMLP, POINTER) returns category of POINTER of NNRegressorMLP.
			%  CATEGORY = NN.GETPROPCATEGORY(NNRegressorMLP, POINTER) returns category of POINTER of NNRegressorMLP.
			%
			% Note that the Element.GETPROPCATEGORY(NN) and Element.GETPROPCATEGORY('NNRegressorMLP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNRegressorMLP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnregressormlp_category_list = { 1  1  1  3  4  2  2  6  4  3  3  3  3  3  5  6  6  6  9  2  6  4  9  9  6 };
			prop_category = nnregressormlp_category_list{prop};
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
			%  FORMAT = NN.GETPROPFORMAT(POINTER) returns format of POINTER of NN.
			%  FORMAT = Element.GETPROPFORMAT(NNRegressorMLP, POINTER) returns format of POINTER of NNRegressorMLP.
			%  FORMAT = NN.GETPROPFORMAT(NNRegressorMLP, POINTER) returns format of POINTER of NNRegressorMLP.
			%
			% Note that the Element.GETPROPFORMAT(NN) and Element.GETPROPFORMAT('NNRegressorMLP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNRegressorMLP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnregressormlp_format_list = { 2  2  2  8  2  2  2  2  8  7  11  11  5  5  17  16  16  1  4  5  16  12  4  11  16 };
			prop_format = nnregressormlp_format_list{prop};
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
			%  DESCRIPTION = NN.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NN.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNRegressorMLP, POINTER) returns description of POINTER of NNRegressorMLP.
			%  DESCRIPTION = NN.GETPROPDESCRIPTION(NNRegressorMLP, POINTER) returns description of POINTER of NNRegressorMLP.
			%
			% Note that the Element.GETPROPDESCRIPTION(NN) and Element.GETPROPDESCRIPTION('NNRegressorMLP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNRegressorMLP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnregressormlp_description_list = { 'ELCLASS (constant, string) is the class of the neural network multi-layer perceptron regressor.'  'NAME (constant, string) is the name of the neural network multi-layer perceptron regressor.'  'DESCRIPTION (constant, string) is the description of the neural network multi-layer perceptron regressor.'  'TEMPLATE (parameter, item) is the template of the neural network multi-layer perceptron regressor.'  'ID (data, string) is a few-letter code for the neural network multi-layer perceptron regressor.'  'LABEL (metadata, string) is an extended label of the neural network multi-layer perceptron regressor.'  'NOTES (metadata, string) are some specific notes about the neural network multi-layer perceptron regressor.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.'  'DP_CLASSES (parameter, classlist) is the list of compatible data points.'  'EPOCHS (parameter, scalar) is the maximum number of epochs.'  'BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.'  'SHUFFLE (parameter, option) is an option for data shuffling.'  'SOLVER (parameter, option) is an option for the solver.'  'MODEL (result, net) is a trained neural network model.'  'INPUTS (query, cell) constructs the data in the CB (channel-batch) format.'  'TARGETS (query, cell) constructs the targets in the CB (channel-batch) format.'  'TRAIN (query, empty) trains the neural network model with the given dataset.'  'VERBOSE (gui, logical) is an indicator to display training progress information.'  'PLOT_TRAINING (metadata, option) determines whether to plot the training progress.'  'PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.'  'LAYERS (data, rvector) defines the number of layers and their neurons.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'INTERRUPTIBLE (gui, scalar) sets whether the comparison computation is interruptible for multitasking.'  'FEATURE_IMPORTANCE (query, cell) evaluates the average significance of each feature by iteratively shuffling its values P times and measuring the resulting average decrease in model performance.' };
			prop_description = nnregressormlp_description_list{prop};
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
			%  SETTINGS = NN.GETPROPSETTINGS(POINTER) returns settings of POINTER of NN.
			%  SETTINGS = Element.GETPROPSETTINGS(NNRegressorMLP, POINTER) returns settings of POINTER of NNRegressorMLP.
			%  SETTINGS = NN.GETPROPSETTINGS(NNRegressorMLP, POINTER) returns settings of POINTER of NNRegressorMLP.
			%
			% Note that the Element.GETPROPSETTINGS(NN) and Element.GETPROPSETTINGS('NNRegressorMLP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNRegressorMLP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 22 % NNRegressorMLP.LAYERS
					prop_settings = Format.getFormatSettings(12);
				case 23 % NNRegressorMLP.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 24 % NNRegressorMLP.INTERRUPTIBLE
					prop_settings = Format.getFormatSettings(11);
				case 25 % NNRegressorMLP.FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(16);
				case 4 % NNRegressorMLP.TEMPLATE
					prop_settings = 'NNRegressorMLP';
				case 9 % NNRegressorMLP.D
					prop_settings = 'NNDataset';
				otherwise
					prop_settings = getPropSettings@NNBase(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNRegressorMLP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorMLP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NN.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NN.
			%  DEFAULT = Element.GETPROPDEFAULT(NNRegressorMLP, POINTER) returns the default value of POINTER of NNRegressorMLP.
			%  DEFAULT = NN.GETPROPDEFAULT(NNRegressorMLP, POINTER) returns the default value of POINTER of NNRegressorMLP.
			%
			% Note that the Element.GETPROPDEFAULT(NN) and Element.GETPROPDEFAULT('NNRegressorMLP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNRegressorMLP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 22 % NNRegressorMLP.LAYERS
					prop_default = [32 32];
				case 23 % NNRegressorMLP.WAITBAR
					prop_default = true;
				case 24 % NNRegressorMLP.INTERRUPTIBLE
					prop_default = .001;
				case 25 % NNRegressorMLP.FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(16, NNRegressorMLP.getPropSettings(prop));
				case 1 % NNRegressorMLP.ELCLASS
					prop_default = 'NNRegressorMLP';
				case 2 % NNRegressorMLP.NAME
					prop_default = 'Neural Network Multi-layer Perceptron Regressor';
				case 3 % NNRegressorMLP.DESCRIPTION
					prop_default = 'A neural network multi-layer perceptron regressor (NNRegressorMLP) comprises a multi-layer perceptron regressor model and a given dataset. NNRegressorMLP trains the multi-layer perceptron regressor with a formatted inputs ("CB", channel and batch) derived from the given dataset.';
				case 4 % NNRegressorMLP.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNRegressorMLP.getPropSettings(prop));
				case 5 % NNRegressorMLP.ID
					prop_default = 'NNRegressorMLP ID';
				case 6 % NNRegressorMLP.LABEL
					prop_default = 'NNRegressorMLP label';
				case 7 % NNRegressorMLP.NOTES
					prop_default = 'NNRegressorMLP notes';
				case 9 % NNRegressorMLP.D
					prop_default = NNDataset('DP_CLASS', 'NNDataPoint_CON_REG');
				case 10 % NNRegressorMLP.DP_CLASSES
					prop_default = {'NNDataPoint_CON_REG' 'NNDataPoint_CON_FUN_MP_REG' 'NNDataPoint_FUN_REG' 'NNDataPoint_ST_REG' 'NNDataPoint_ST_MM_REG' 'NNDataPoint_Graph_REG' 'NNDataPoint_Measure_REG'};
				otherwise
					prop_default = getPropDefault@NNBase(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNRegressorMLP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorMLP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NN.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NN.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNRegressorMLP, POINTER) returns the conditioned default value of POINTER of NNRegressorMLP.
			%  DEFAULT = NN.GETPROPDEFAULTCONDITIONED(NNRegressorMLP, POINTER) returns the conditioned default value of POINTER of NNRegressorMLP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NN) and Element.GETPROPDEFAULTCONDITIONED('NNRegressorMLP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNRegressorMLP.getPropProp(pointer);
			
			prop_default = NNRegressorMLP.conditioning(prop, NNRegressorMLP.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NN.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NN.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NN.
			%  CHECK = Element.CHECKPROP(NNRegressorMLP, PROP, VALUE) checks VALUE format for PROP of NNRegressorMLP.
			%  CHECK = NN.CHECKPROP(NNRegressorMLP, PROP, VALUE) checks VALUE format for PROP of NNRegressorMLP.
			% 
			% NN.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNRegressorMLP:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NN.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NN.
			%   Error id: BRAPH2:NNRegressorMLP:WrongInput
			%  Element.CHECKPROP(NNRegressorMLP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorMLP.
			%   Error id: BRAPH2:NNRegressorMLP:WrongInput
			%  NN.CHECKPROP(NNRegressorMLP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorMLP.
			%   Error id: BRAPH2:NNRegressorMLP:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NN) and Element.CHECKPROP('NNRegressorMLP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNRegressorMLP.getPropProp(pointer);
			
			switch prop
				case 22 % NNRegressorMLP.LAYERS
					check = Format.checkFormat(12, value, NNRegressorMLP.getPropSettings(prop));
				case 23 % NNRegressorMLP.WAITBAR
					check = Format.checkFormat(4, value, NNRegressorMLP.getPropSettings(prop));
				case 24 % NNRegressorMLP.INTERRUPTIBLE
					check = Format.checkFormat(11, value, NNRegressorMLP.getPropSettings(prop));
				case 25 % NNRegressorMLP.FEATURE_IMPORTANCE
					check = Format.checkFormat(16, value, NNRegressorMLP.getPropSettings(prop));
				case 4 % NNRegressorMLP.TEMPLATE
					check = Format.checkFormat(8, value, NNRegressorMLP.getPropSettings(prop));
				case 9 % NNRegressorMLP.D
					check = Format.checkFormat(8, value, NNRegressorMLP.getPropSettings(prop));
				otherwise
					if prop <= 21
						check = checkProp@NNBase(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNRegressorMLP:' 'WrongInput'], ...
					['BRAPH2' ':NNRegressorMLP:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNRegressorMLP.getPropTag(prop) ' (' NNRegressorMLP.getFormatTag(NNRegressorMLP.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nn, prop, varargin)
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
				case 25 % NNRegressorMLP.FEATURE_IMPORTANCE
					% fi = nn.get('FEATURE_IMPORTANCE', D) retrieves a cell array containing
					%  the feature importance values for the trained model, as assessed by
					%  evaluating it on the input dataset D.
					if isempty(varargin)
					    value = {};
					    return
					end
					d = varargin{1};
					P = varargin{2};
					seeds = varargin{3};
					
					inputs = cell2mat(nn.get('INPUTS', d));
					if isempty(inputs)
					    value = {};
					    return
					end
					targets = cell2mat(nn.get('TARGETS', d));
					net = nn.get('MODEL');
					
					number_features = size(inputs, 2);
					original_loss = crossentropy(net.predict(inputs), targets);
					
					wb = braph2waitbar(nn.get('WAITBAR'), 0, ['Feature importance permutation ...']);
					
					start = tic;
					
					for i = 1:1:P
					    rng(seeds(i), 'twister')
					
					    warning('off', 'MATLAB:remoteparfor:ParforWorkerAborted')
					    parfor j = 1:1:number_features
					        scrambled_inputs = inputs;
					        permuted_value = squeeze(normrnd(mean(inputs(:, j)), std(inputs(:, j)), squeeze(size(inputs(:, j))))) + squeeze(randn(size(inputs(:, j)))) + mean(inputs(:, j));
					        scrambled_inputs(:, j) = permuted_value;
					        scrambled_loss = crossentropy(net.predict(scrambled_inputs), targets);
					        feature_importance(j) = scrambled_loss;
					    end
					    warning('on', 'MATLAB:remoteparfor:ParforWorkerAborted')
					
					    feature_importance_all_permutations{i} = feature_importance / original_loss;
					
					    braph2waitbar(wb, i / P, ['Feature importance permutation ' num2str(i) ' of ' num2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...'])
					    if nn.get('VERBOSE')
					        disp(['** PERMUTATION FEATURE IMPORTANCE - sampling #' int2str(i) '/' int2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
					    end
					    if nn.get('INTERRUPTIBLE')
					        pause(nn.get('INTERRUPTIBLE'))
					    end
					end
					
					braph2waitbar(wb, 'close')
					
					value = feature_importance_all_permutations;
					
				case 16 % NNRegressorMLP.INPUTS
					% inputs = nn.get('inputs', D) returns a cell array with the
					%  inputs for all data points in dataset D.
					if isempty(varargin)
					    value = {};
					    return
					end
					d = varargin{1};
					inputs_group = d.get('INPUTS');
					if isempty(inputs_group)
					    value = {};
					else
					    flattened_inputs_group = [];
					    for i = 1:1:length(inputs_group)
					        inputs_individual = inputs_group{i};
					        flattened_inputs_individual = [];
					        while ~isempty(inputs_individual)
					            currentData = inputs_individual{end};  % Get the last element from the stack
					            inputs_individual = inputs_individual(1:end-1);   % Remove the last element
					
					            if iscell(currentData)
					                % If it's a cell array, add its contents to the stack
					                inputs_individual = [inputs_individual currentData{:}];
					            else
					                % If it's numeric or other data, append it to the vector
					                flattened_inputs_individual = [currentData(:); flattened_inputs_individual];
					            end
					        end
					        flattened_inputs_group = [flattened_inputs_group; flattened_inputs_individual'];
					    end
					    value = {flattened_inputs_group};
					end
					
				case 17 % NNRegressorMLP.TARGETS
					% targets = nn.get('PREDICT', D) returns a cell array with the
					%  targets for all data points in dataset D.
					if isempty(varargin)
					    value = {};
					    return
					end
					d = varargin{1};
					targets = d.get('TARGETS');
					if isempty(targets)
					    value = {};
					else
					    nn_targets = [];
					    for i = 1:1:length(targets)
					        target = cell2mat(targets{i});
					        nn_targets = [nn_targets; target(:)'];
					    end
					    value = {nn_targets};
					end
					
				case 15 % NNRegressorMLP.MODEL
					rng_settings_ = rng(); rng(nn.getPropSeed(15), 'twister')
					
					inputs = cell2mat(nn.get('INPUTS', nn.get('D')));
					targets = cell2mat(nn.get('TARGETS', nn.get('D')));
					if isempty(inputs) || isempty(targets)
					    value = network();
					else
					    number_features = size(inputs, 2);
					    number_targets = size(targets, 2);
					    layers = nn.get('LAYERS');
					    
					    nn_architecture = [featureInputLayer(number_features, 'Name', 'Input')];
					    for i = 1:1:length(layers)
					        nn_architecture = [nn_architecture
					            fullyConnectedLayer(layers(i), 'Name', ['Dense_' num2str(i)])
					            batchNormalizationLayer('Name', ['BatchNormalization_' num2str(i)])
					            dropoutLayer('Name', ['Dropout_' num2str(i)])
					            ];
					    end
					    nn_architecture = [nn_architecture
					        reluLayer('Name', 'Relu_output')
					        fullyConnectedLayer(number_targets, 'Name', 'Dense_output')
					        regressionLayer('Name', 'Output')
					        ];
					    
					    % specify trianing options
					    options = trainingOptions( ...
					        nn.get('SOLVER'), ...
					        'MiniBatchSize', nn.get('BATCH'), ...
					        'MaxEpochs', nn.get('EPOCHS'), ...
					        'Shuffle', nn.get('SHUFFLE'), ...
					        'Plots', nn.get('PLOT_TRAINING'), ...
					        'Verbose', nn.get('VERBOSE') ...
					        );
					
					    % train the neural network
					    value = trainNetwork(inputs, targets, nn_architecture, options);
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 21
						value = calculateValue@NNBase(nn, prop, varargin{:});
					else
						value = calculateValue@Element(nn, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(nn, prop, varargin)
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
				case 22 % NNRegressorMLP.LAYERS
					pr = PanelPropRVectorSmart('EL', nn, 'PROP', 22, ...
					    'MIN', 0, 'MAX', 2000, ...
					    'UNIQUE_VALUE', false, ...
					    'DEFAULT', NNRegressorMLP.getPropDefault('LAYERS'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@NNBase(nn, prop, varargin{:});
					
			end
		end
	end
end
