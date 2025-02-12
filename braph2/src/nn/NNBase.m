classdef NNBase < ConcreteElement
	%NNBase comprises a neural network model with a dataset.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Neural Network Base (NNBase) comprises a neural network model with a specific dataset.
	%  Instances of this class should not be created. Use one of its subclasses instead.
	% 
	% Its subclasses need to implement the props MODEL, INPUTS and TARGETS.
	%  Each subclass is typically optimized to work with the subclasses of NNDataPoint in the prop DP_CLASSES.
	% 
	% To train a neural network nn use: nn.get('TRAIN')
	% To obtain the prediction on a dataset D use: predictions = nn.get('PREDICT', D)
	%
	% The list of NNBase properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the neural network base.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural network base.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural network base.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural network base.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the neural network base.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural network base.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the neural network base.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>D</strong> 	D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
	%  <strong>10</strong> <strong>DP_CLASSES</strong> 	DP_CLASSES (parameter, classlist) is the list of compatible data points.
	%  <strong>11</strong> <strong>EPOCHS</strong> 	EPOCHS (parameter, scalar) is the maximum number of epochs.
	%  <strong>12</strong> <strong>BATCH</strong> 	BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
	%  <strong>13</strong> <strong>SHUFFLE</strong> 	SHUFFLE (parameter, option) is an option for data shuffling.
	%  <strong>14</strong> <strong>SOLVER</strong> 	SOLVER (parameter, option) is an option for the solver.
	%  <strong>15</strong> <strong>MODEL</strong> 	MODEL (result, net) is a trained neural network model with the given dataset.
	%  <strong>16</strong> <strong>INPUTS</strong> 	INPUTS (query, cell) constructs the cell array of the data.
	%  <strong>17</strong> <strong>TARGETS</strong> 	TARGETS (query, cell) constructs the cell array of the targets.
	%  <strong>18</strong> <strong>TRAIN</strong> 	TRAIN (query, empty) trains the neural network model with the given dataset.
	%  <strong>19</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display training progress information.
	%  <strong>20</strong> <strong>PLOT_TRAINING</strong> 	PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
	%  <strong>21</strong> <strong>PREDICT</strong> 	PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.
	%
	% NNBase methods (constructor):
	%  NNBase - constructor
	%
	% NNBase methods:
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
	% NNBase methods (display):
	%  tostring - string with information about the neural network
	%  disp - displays information about the neural network
	%  tree - displays the tree of the neural network
	%
	% NNBase methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network
	%
	% NNBase methods (save/load, Static):
	%  save - saves BRAPH2 neural network as b2 file
	%  load - loads a BRAPH2 neural network from a b2 file
	%
	% NNBase method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network
	%
	% NNBase method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network
	%
	% NNBase methods (inspection, Static):
	%  getClass - returns the class of the neural network
	%  getSubclasses - returns all subclasses of NNBase
	%  getProps - returns the property list of the neural network
	%  getPropNumber - returns the property number of the neural network
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
	% NNBase methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNBase methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNBase methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNBase methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNBase; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNBase constants</a>.
	%
	%
	% See also NNDataPoint, NNDataset, NNEvaluator.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		D = 9; %CET: Computational Efficiency Trick
		D_TAG = 'D';
		D_CATEGORY = 4;
		D_FORMAT = 8;
		
		DP_CLASSES = 10; %CET: Computational Efficiency Trick
		DP_CLASSES_TAG = 'DP_CLASSES';
		DP_CLASSES_CATEGORY = 3;
		DP_CLASSES_FORMAT = 7;
		
		EPOCHS = 11; %CET: Computational Efficiency Trick
		EPOCHS_TAG = 'EPOCHS';
		EPOCHS_CATEGORY = 3;
		EPOCHS_FORMAT = 11;
		
		BATCH = 12; %CET: Computational Efficiency Trick
		BATCH_TAG = 'BATCH';
		BATCH_CATEGORY = 3;
		BATCH_FORMAT = 11;
		
		SHUFFLE = 13; %CET: Computational Efficiency Trick
		SHUFFLE_TAG = 'SHUFFLE';
		SHUFFLE_CATEGORY = 3;
		SHUFFLE_FORMAT = 5;
		
		SOLVER = 14; %CET: Computational Efficiency Trick
		SOLVER_TAG = 'SOLVER';
		SOLVER_CATEGORY = 3;
		SOLVER_FORMAT = 5;
		
		MODEL = 15; %CET: Computational Efficiency Trick
		MODEL_TAG = 'MODEL';
		MODEL_CATEGORY = 5;
		MODEL_FORMAT = 17;
		
		INPUTS = 16; %CET: Computational Efficiency Trick
		INPUTS_TAG = 'INPUTS';
		INPUTS_CATEGORY = 6;
		INPUTS_FORMAT = 16;
		
		TARGETS = 17; %CET: Computational Efficiency Trick
		TARGETS_TAG = 'TARGETS';
		TARGETS_CATEGORY = 6;
		TARGETS_FORMAT = 16;
		
		TRAIN = 18; %CET: Computational Efficiency Trick
		TRAIN_TAG = 'TRAIN';
		TRAIN_CATEGORY = 6;
		TRAIN_FORMAT = 1;
		
		VERBOSE = 19; %CET: Computational Efficiency Trick
		VERBOSE_TAG = 'VERBOSE';
		VERBOSE_CATEGORY = 9;
		VERBOSE_FORMAT = 4;
		
		PLOT_TRAINING = 20; %CET: Computational Efficiency Trick
		PLOT_TRAINING_TAG = 'PLOT_TRAINING';
		PLOT_TRAINING_CATEGORY = 2;
		PLOT_TRAINING_FORMAT = 5;
		
		PREDICT = 21; %CET: Computational Efficiency Trick
		PREDICT_TAG = 'PREDICT';
		PREDICT_CATEGORY = 6;
		PREDICT_FORMAT = 16;
	end
	methods % constructor
		function nn = NNBase(varargin)
			%NNBase() creates a neural network.
			%
			% NNBase(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNBase(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNBase properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the neural network base.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural network base.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural network base.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural network base.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the neural network base.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural network base.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the neural network base.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>D</strong> 	D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
			%  <strong>10</strong> <strong>DP_CLASSES</strong> 	DP_CLASSES (parameter, classlist) is the list of compatible data points.
			%  <strong>11</strong> <strong>EPOCHS</strong> 	EPOCHS (parameter, scalar) is the maximum number of epochs.
			%  <strong>12</strong> <strong>BATCH</strong> 	BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
			%  <strong>13</strong> <strong>SHUFFLE</strong> 	SHUFFLE (parameter, option) is an option for data shuffling.
			%  <strong>14</strong> <strong>SOLVER</strong> 	SOLVER (parameter, option) is an option for the solver.
			%  <strong>15</strong> <strong>MODEL</strong> 	MODEL (result, net) is a trained neural network model with the given dataset.
			%  <strong>16</strong> <strong>INPUTS</strong> 	INPUTS (query, cell) constructs the cell array of the data.
			%  <strong>17</strong> <strong>TARGETS</strong> 	TARGETS (query, cell) constructs the cell array of the targets.
			%  <strong>18</strong> <strong>TRAIN</strong> 	TRAIN (query, empty) trains the neural network model with the given dataset.
			%  <strong>19</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display training progress information.
			%  <strong>20</strong> <strong>PLOT_TRAINING</strong> 	PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
			%  <strong>21</strong> <strong>PREDICT</strong> 	PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.
			%
			% See also Category, Format.
			
			nn = nn@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the neural network.
			%
			% BUILD = NNBase.GETBUILD() returns the build of 'NNBase'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NN.GETBUILD() returns the build of the neural network NN.
			%  BUILD = Element.GETBUILD(NN) returns the build of 'NN'.
			%  BUILD = Element.GETBUILD('NNBase') returns the build of 'NNBase'.
			%
			% Note that the Element.GETBUILD(NN) and Element.GETBUILD('NNBase')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nn_class = getClass()
			%GETCLASS returns the class of the neural network.
			%
			% CLASS = NNBase.GETCLASS() returns the class 'NNBase'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NN.GETCLASS() returns the class of the neural network NN.
			%  CLASS = Element.GETCLASS(NN) returns the class of 'NN'.
			%  CLASS = Element.GETCLASS('NNBase') returns 'NNBase'.
			%
			% Note that the Element.GETCLASS(NN) and Element.GETCLASS('NNBase')
			%  are less computationally efficient.
			
			nn_class = 'NNBase';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network.
			%
			% LIST = NNBase.GETSUBCLASSES() returns all subclasses of 'NNBase'.
			%
			% Alternative forms to call this method are:
			%  LIST = NN.GETSUBCLASSES() returns all subclasses of the neural network NN.
			%  LIST = Element.GETSUBCLASSES(NN) returns all subclasses of 'NN'.
			%  LIST = Element.GETSUBCLASSES('NNBase') returns all subclasses of 'NNBase'.
			%
			% Note that the Element.GETSUBCLASSES(NN) and Element.GETSUBCLASSES('NNBase')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNBase'  'NNClassifierMLP'  'NNRegressorMLP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network.
			%
			% PROPS = NNBase.GETPROPS() returns the property list of neural network
			%  as a row vector.
			%
			% PROPS = NNBase.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NN.GETPROPS([CATEGORY]) returns the property list of the neural network NN.
			%  PROPS = Element.GETPROPS(NN[, CATEGORY]) returns the property list of 'NN'.
			%  PROPS = Element.GETPROPS('NNBase'[, CATEGORY]) returns the property list of 'NNBase'.
			%
			% Note that the Element.GETPROPS(NN) and Element.GETPROPS('NNBase')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21];
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
					prop_list = [5 9];
				case 5 % Category.RESULT
					prop_list = 15;
				case 6 % Category.QUERY
					prop_list = [8 16 17 18 21];
				case 9 % Category.GUI
					prop_list = 19;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network.
			%
			% N = NNBase.GETPROPNUMBER() returns the property number of neural network.
			%
			% N = NNBase.GETPROPNUMBER(CATEGORY) returns the property number of neural network
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NN.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network NN.
			%  N = Element.GETPROPNUMBER(NN) returns the property number of 'NN'.
			%  N = Element.GETPROPNUMBER('NNBase') returns the property number of 'NNBase'.
			%
			% Note that the Element.GETPROPNUMBER(NN) and Element.GETPROPNUMBER('NNBase')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 21;
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
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 5;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network/error.
			%
			% CHECK = NNBase.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NN.EXISTSPROP(PROP) checks whether PROP exists for NN.
			%  CHECK = Element.EXISTSPROP(NN, PROP) checks whether PROP exists for NN.
			%  CHECK = Element.EXISTSPROP(NNBase, PROP) checks whether PROP exists for NNBase.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNBase:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NN.EXISTSPROP(PROP) throws error if PROP does NOT exist for NN.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%  Element.EXISTSPROP(NN, PROP) throws error if PROP does NOT exist for NN.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%  Element.EXISTSPROP(NNBase, PROP) throws error if PROP does NOT exist for NNBase.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NN) and Element.EXISTSPROP('NNBase')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 21 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNBase:' 'WrongInput'], ...
					['BRAPH2' ':NNBase:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNBase.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network/error.
			%
			% CHECK = NNBase.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NN.EXISTSTAG(TAG) checks whether TAG exists for NN.
			%  CHECK = Element.EXISTSTAG(NN, TAG) checks whether TAG exists for NN.
			%  CHECK = Element.EXISTSTAG(NNBase, TAG) checks whether TAG exists for NNBase.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNBase:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NN.EXISTSTAG(TAG) throws error if TAG does NOT exist for NN.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%  Element.EXISTSTAG(NN, TAG) throws error if TAG does NOT exist for NN.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%  Element.EXISTSTAG(NNBase, TAG) throws error if TAG does NOT exist for NNBase.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NN) and Element.EXISTSTAG('NNBase')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNBase:' 'WrongInput'], ...
					['BRAPH2' ':NNBase:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNBase.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNBase, POINTER) returns property number of POINTER of NNBase.
			%  PROPERTY = NN.GETPROPPROP(NNBase, POINTER) returns property number of POINTER of NNBase.
			%
			% Note that the Element.GETPROPPROP(NN) and Element.GETPROPPROP('NNBase')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(NNBase, POINTER) returns tag of POINTER of NNBase.
			%  TAG = NN.GETPROPTAG(NNBase, POINTER) returns tag of POINTER of NNBase.
			%
			% Note that the Element.GETPROPTAG(NN) and Element.GETPROPTAG('NNBase')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnbase_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT' };
				tag = nnbase_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNBase, POINTER) returns category of POINTER of NNBase.
			%  CATEGORY = NN.GETPROPCATEGORY(NNBase, POINTER) returns category of POINTER of NNBase.
			%
			% Note that the Element.GETPROPCATEGORY(NN) and Element.GETPROPCATEGORY('NNBase')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnbase_category_list = { 1  1  1  3  4  2  2  6  4  3  3  3  3  3  5  6  6  6  9  2  6 };
			prop_category = nnbase_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(NNBase, POINTER) returns format of POINTER of NNBase.
			%  FORMAT = NN.GETPROPFORMAT(NNBase, POINTER) returns format of POINTER of NNBase.
			%
			% Note that the Element.GETPROPFORMAT(NN) and Element.GETPROPFORMAT('NNBase')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnbase_format_list = { 2  2  2  8  2  2  2  2  8  7  11  11  5  5  17  16  16  1  4  5  16 };
			prop_format = nnbase_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNBase, POINTER) returns description of POINTER of NNBase.
			%  DESCRIPTION = NN.GETPROPDESCRIPTION(NNBase, POINTER) returns description of POINTER of NNBase.
			%
			% Note that the Element.GETPROPDESCRIPTION(NN) and Element.GETPROPDESCRIPTION('NNBase')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnbase_description_list = { 'ELCLASS (constant, string) is the class of the neural network base.'  'NAME (constant, string) is the name of the neural network base.'  'DESCRIPTION (constant, string) is the description of the neural network base.'  'TEMPLATE (parameter, item) is the template of the neural network base.'  'ID (data, string) is a few-letter code for the neural network base.'  'LABEL (metadata, string) is an extended label of the neural network base.'  'NOTES (metadata, string) are some specific notes about the neural network base.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.'  'DP_CLASSES (parameter, classlist) is the list of compatible data points.'  'EPOCHS (parameter, scalar) is the maximum number of epochs.'  'BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.'  'SHUFFLE (parameter, option) is an option for data shuffling.'  'SOLVER (parameter, option) is an option for the solver.'  'MODEL (result, net) is a trained neural network model with the given dataset.'  'INPUTS (query, cell) constructs the cell array of the data.'  'TARGETS (query, cell) constructs the cell array of the targets.'  'TRAIN (query, empty) trains the neural network model with the given dataset.'  'VERBOSE (gui, logical) is an indicator to display training progress information.'  'PLOT_TRAINING (metadata, option) determines whether to plot the training progress.'  'PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.' };
			prop_description = nnbase_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNBase, POINTER) returns settings of POINTER of NNBase.
			%  SETTINGS = NN.GETPROPSETTINGS(NNBase, POINTER) returns settings of POINTER of NNBase.
			%
			% Note that the Element.GETPROPSETTINGS(NN) and Element.GETPROPSETTINGS('NNBase')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNBase.D
					prop_settings = 'NNDataset';
				case 10 % NNBase.DP_CLASSES
					prop_settings = Format.getFormatSettings(7);
				case 11 % NNBase.EPOCHS
					prop_settings = Format.getFormatSettings(11);
				case 12 % NNBase.BATCH
					prop_settings = Format.getFormatSettings(11);
				case 13 % NNBase.SHUFFLE
					prop_settings = {'once' 'never' 'every-epoch'};
				case 14 % NNBase.SOLVER
					prop_settings = {'adam' 'sgdm' 'rmsprop'};
				case 15 % NNBase.MODEL
					prop_settings = Format.getFormatSettings(17);
				case 16 % NNBase.INPUTS
					prop_settings = Format.getFormatSettings(16);
				case 17 % NNBase.TARGETS
					prop_settings = Format.getFormatSettings(16);
				case 18 % NNBase.TRAIN
					prop_settings = Format.getFormatSettings(1);
				case 19 % NNBase.VERBOSE
					prop_settings = Format.getFormatSettings(4);
				case 20 % NNBase.PLOT_TRAINING
					prop_settings = {'none' 'training-progress'};
				case 21 % NNBase.PREDICT
					prop_settings = Format.getFormatSettings(16);
				case 4 % NNBase.TEMPLATE
					prop_settings = 'NNBase';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNBase.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNBase.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NN.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NN.
			%  DEFAULT = Element.GETPROPDEFAULT(NNBase, POINTER) returns the default value of POINTER of NNBase.
			%  DEFAULT = NN.GETPROPDEFAULT(NNBase, POINTER) returns the default value of POINTER of NNBase.
			%
			% Note that the Element.GETPROPDEFAULT(NN) and Element.GETPROPDEFAULT('NNBase')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNBase.D
					prop_default = NNDataset('DP_CLASS', 'NNDataPoint');
				case 10 % NNBase.DP_CLASSES
					prop_default = {'NNDataPoint'};
				case 11 % NNBase.EPOCHS
					prop_default = 20;
				case 12 % NNBase.BATCH
					prop_default = 8;
				case 13 % NNBase.SHUFFLE
					prop_default = Format.getFormatDefault(5, NNBase.getPropSettings(prop));
				case 14 % NNBase.SOLVER
					prop_default = Format.getFormatDefault(5, NNBase.getPropSettings(prop));
				case 15 % NNBase.MODEL
					prop_default = Format.getFormatDefault(17, NNBase.getPropSettings(prop));
				case 16 % NNBase.INPUTS
					prop_default = Format.getFormatDefault(16, NNBase.getPropSettings(prop));
				case 17 % NNBase.TARGETS
					prop_default = Format.getFormatDefault(16, NNBase.getPropSettings(prop));
				case 18 % NNBase.TRAIN
					prop_default = Format.getFormatDefault(1, NNBase.getPropSettings(prop));
				case 19 % NNBase.VERBOSE
					prop_default = false;
				case 20 % NNBase.PLOT_TRAINING
					prop_default = Format.getFormatDefault(5, NNBase.getPropSettings(prop));
				case 21 % NNBase.PREDICT
					prop_default = Format.getFormatDefault(16, NNBase.getPropSettings(prop));
				case 1 % NNBase.ELCLASS
					prop_default = 'NNBase';
				case 2 % NNBase.NAME
					prop_default = 'Neural Network Base';
				case 3 % NNBase.DESCRIPTION
					prop_default = 'A Neural Network Base (NNBase) comprises a neural network model with a specific dataset. Instances of this class should not be created. Use one of its subclasses instead. Its subclasses need to implement the props MODEL, INPUTS and TARGETS.';
				case 4 % NNBase.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNBase.getPropSettings(prop));
				case 5 % NNBase.ID
					prop_default = 'NNBase ID';
				case 6 % NNBase.LABEL
					prop_default = 'NNBase label';
				case 7 % NNBase.NOTES
					prop_default = 'NNBase notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNBase.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNBase.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NN.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NN.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNBase, POINTER) returns the conditioned default value of POINTER of NNBase.
			%  DEFAULT = NN.GETPROPDEFAULTCONDITIONED(NNBase, POINTER) returns the conditioned default value of POINTER of NNBase.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NN) and Element.GETPROPDEFAULTCONDITIONED('NNBase')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			prop_default = NNBase.conditioning(prop, NNBase.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNBase, PROP, VALUE) checks VALUE format for PROP of NNBase.
			%  CHECK = NN.CHECKPROP(NNBase, PROP, VALUE) checks VALUE format for PROP of NNBase.
			% 
			% NN.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNBase:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NN.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NN.
			%   Error id: BRAPH2:NNBase:WrongInput
			%  Element.CHECKPROP(NNBase, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNBase.
			%   Error id: BRAPH2:NNBase:WrongInput
			%  NN.CHECKPROP(NNBase, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNBase.
			%   Error id: BRAPH2:NNBase:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NN) and Element.CHECKPROP('NNBase')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNBase.getPropProp(pointer);
			
			switch prop
				case 9 % NNBase.D
					check = Format.checkFormat(8, value, NNBase.getPropSettings(prop));
				case 10 % NNBase.DP_CLASSES
					check = Format.checkFormat(7, value, NNBase.getPropSettings(prop));
				case 11 % NNBase.EPOCHS
					check = Format.checkFormat(11, value, NNBase.getPropSettings(prop));
				case 12 % NNBase.BATCH
					check = Format.checkFormat(11, value, NNBase.getPropSettings(prop));
				case 13 % NNBase.SHUFFLE
					check = Format.checkFormat(5, value, NNBase.getPropSettings(prop));
				case 14 % NNBase.SOLVER
					check = Format.checkFormat(5, value, NNBase.getPropSettings(prop));
				case 15 % NNBase.MODEL
					check = Format.checkFormat(17, value, NNBase.getPropSettings(prop));
				case 16 % NNBase.INPUTS
					check = Format.checkFormat(16, value, NNBase.getPropSettings(prop));
				case 17 % NNBase.TARGETS
					check = Format.checkFormat(16, value, NNBase.getPropSettings(prop));
				case 18 % NNBase.TRAIN
					check = Format.checkFormat(1, value, NNBase.getPropSettings(prop));
				case 19 % NNBase.VERBOSE
					check = Format.checkFormat(4, value, NNBase.getPropSettings(prop));
				case 20 % NNBase.PLOT_TRAINING
					check = Format.checkFormat(5, value, NNBase.getPropSettings(prop));
				case 21 % NNBase.PREDICT
					check = Format.checkFormat(16, value, NNBase.getPropSettings(prop));
				case 4 % NNBase.TEMPLATE
					check = Format.checkFormat(8, value, NNBase.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNBase:' 'WrongInput'], ...
					['BRAPH2' ':NNBase:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNBase.getPropTag(prop) ' (' NNBase.getFormatTag(NNBase.getPropFormat(prop)) ').'] ...
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
				case 15 % NNBase.MODEL
					rng_settings_ = rng(); rng(nn.getPropSeed(15), 'twister')
					
					value = network();
					
					rng(rng_settings_)
					
				case 16 % NNBase.INPUTS
					% inputs = nn.get('inputs', D) returns a cell array with the
					%  inputs for all data points in dataset D.
					value = {};
					
				case 17 % NNBase.TARGETS
					% targets = nn.get('PREDICT', D) returns a cell array with the
					%  targets for all data points in dataset D.
					value = {};
					
				case 18 % NNBase.TRAIN
					nn.memorize('MODEL');
					value = [];
					
				case 21 % NNBase.PREDICT
					% PREDICTIONS = nn.get('PREDICT', D) returns a cell array with the
					%  predictions for all data points in dataset D.
					if isempty(varargin)
					    value = {};
					    return
					end
					
					d = varargin{1};
					inputs = nn.get('INPUTS', d);
					if isempty(cell2mat(inputs))
					    predictions = {};
					else
					    net = nn.get('MODEL');
					    predictions = {net.predict(cell2mat(inputs))};
					end
					value = predictions;
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(nn, prop, varargin{:});
					else
						value = calculateValue@Element(nn, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(nn, prop, value)
			%CHECKVALUE checks the value of a property after it is set/calculated.
			%
			% [CHECK, MSG] = CHECKVALUE(EL, PROP, VALUE) checks the value
			%  of the property PROP after it is set/calculated. This function by
			%  default returns a CHECK = true and MSG = '. It should be implemented in
			%  the subclasses of Element when needed.
			%
			% See also conditioning, preset, checkProp, postset, postprocessing,
			%  calculateValue.
			
			check = true;
			msg = ['Error while checking ' tostring(nn) ' ' nn.getPropTag(prop) '.'];
			
			switch prop
				case 9 % NNBase.D
					check = ismember(value.get('DP_CLASS'), nn.get('DP_CLASSES'));
					
				otherwise
					if prop <= 8
						[check, msg] = checkValue@ConcreteElement(nn, prop, value);
					end
			end
		end
	end
end
