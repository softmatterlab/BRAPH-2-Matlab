classdef NNClassifierMLP_Evaluator < NNEvaluator
	%NNClassifierMLP_Evaluator evaluates the performance of a multi-layer perceptron classifier with a given dataset.
	% It is a subclass of <a href="matlab:help NNEvaluator">NNEvaluator</a>.
	%
	% A neural network evaluator for a multi-layer perceptron classifier (NNClassifierMLP_Evaluator) evaluates the performance of a multi-layer perceptron classifier with a given dataset.
	% NNClassifierMLP_Evaluator evaluates the performance of the trained classifier with a given dataset in terms of various classification metrics (e.g., confusion matrix, area under the receiver operating characteristic curve).
	%
	% The list of NNClassifierMLP_Evaluator properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the neural network evaluator for a multi-layer perceptron classifier.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural network evaluator for a multi-layer perceptron classifier.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural network evaluator for a multi-layer perceptron classifier.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural network evaluator for a multi-layer perceptron classifier.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the neural network evaluator for a multi-layer perceptron classifier.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural network evaluator for a multi-layer perceptron classifier.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the neural network evaluator for a multi-layer perceptron classifier.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>NN</strong> 	NN (data, item) contains a trained neural network multi-layer perceptron classifier.
	%  <strong>10</strong> <strong>D</strong> 	D (data, item) is the dataset to evaluate the neural network model.
	%  <strong>11</strong> <strong>GROUND_TRUTH</strong> 	GROUND_TRUTH (query, stringlist) returns the matrix of ground truth derived from the targets.
	%  <strong>12</strong> <strong>AUC</strong> 	AUC (result, rvector) provides the value of the area under the receiver operating characteristic curve.
	%  <strong>13</strong> <strong>PFROC</strong> 	PFROC (gui, item) contains the panel figure of the ROC plot for classification model.
	%  <strong>14</strong> <strong>MACRO_AUC</strong> 	MACRO_AUC (result, scalar) provides the metric of the average AUC value.
	%  <strong>15</strong> <strong>C_MATRIX</strong> 	C_MATRIX (result, matrix) provides the confusion matrix.
	%
	% NNClassifierMLP_Evaluator methods (constructor):
	%  NNClassifierMLP_Evaluator - constructor
	%
	% NNClassifierMLP_Evaluator methods:
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
	% NNClassifierMLP_Evaluator methods (display):
	%  tostring - string with information about the neural network evaluator for multi-layer perceptron classifier
	%  disp - displays information about the neural network evaluator for multi-layer perceptron classifier
	%  tree - displays the tree of the neural network evaluator for multi-layer perceptron classifier
	%
	% NNClassifierMLP_Evaluator methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network evaluator for multi-layer perceptron classifier are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network evaluator for multi-layer perceptron classifier
	%
	% NNClassifierMLP_Evaluator methods (save/load, Static):
	%  save - saves BRAPH2 neural network evaluator for multi-layer perceptron classifier as b2 file
	%  load - loads a BRAPH2 neural network evaluator for multi-layer perceptron classifier from a b2 file
	%
	% NNClassifierMLP_Evaluator method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network evaluator for multi-layer perceptron classifier
	%
	% NNClassifierMLP_Evaluator method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network evaluator for multi-layer perceptron classifier
	%
	% NNClassifierMLP_Evaluator methods (inspection, Static):
	%  getClass - returns the class of the neural network evaluator for multi-layer perceptron classifier
	%  getSubclasses - returns all subclasses of NNClassifierMLP_Evaluator
	%  getProps - returns the property list of the neural network evaluator for multi-layer perceptron classifier
	%  getPropNumber - returns the property number of the neural network evaluator for multi-layer perceptron classifier
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
	% NNClassifierMLP_Evaluator methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNClassifierMLP_Evaluator methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNClassifierMLP_Evaluator methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNClassifierMLP_Evaluator methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNClassifierMLP_Evaluator; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNClassifierMLP_Evaluator constants</a>.
	%
	%
	% See also NNDataPoint_CON_CLA, NNClassifierMLP.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		GROUND_TRUTH = 11; %CET: Computational Efficiency Trick
		GROUND_TRUTH_TAG = 'GROUND_TRUTH';
		GROUND_TRUTH_CATEGORY = 6;
		GROUND_TRUTH_FORMAT = 3;
		
		AUC = 12; %CET: Computational Efficiency Trick
		AUC_TAG = 'AUC';
		AUC_CATEGORY = 5;
		AUC_FORMAT = 12;
		
		PFROC = 13; %CET: Computational Efficiency Trick
		PFROC_TAG = 'PFROC';
		PFROC_CATEGORY = 9;
		PFROC_FORMAT = 8;
		
		MACRO_AUC = 14; %CET: Computational Efficiency Trick
		MACRO_AUC_TAG = 'MACRO_AUC';
		MACRO_AUC_CATEGORY = 5;
		MACRO_AUC_FORMAT = 11;
		
		C_MATRIX = 15; %CET: Computational Efficiency Trick
		C_MATRIX_TAG = 'C_MATRIX';
		C_MATRIX_CATEGORY = 5;
		C_MATRIX_FORMAT = 14;
	end
	methods % constructor
		function nne = NNClassifierMLP_Evaluator(varargin)
			%NNClassifierMLP_Evaluator() creates a neural network evaluator for multi-layer perceptron classifier.
			%
			% NNClassifierMLP_Evaluator(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNClassifierMLP_Evaluator(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNClassifierMLP_Evaluator properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the neural network evaluator for a multi-layer perceptron classifier.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural network evaluator for a multi-layer perceptron classifier.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural network evaluator for a multi-layer perceptron classifier.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural network evaluator for a multi-layer perceptron classifier.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the neural network evaluator for a multi-layer perceptron classifier.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural network evaluator for a multi-layer perceptron classifier.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the neural network evaluator for a multi-layer perceptron classifier.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>NN</strong> 	NN (data, item) contains a trained neural network multi-layer perceptron classifier.
			%  <strong>10</strong> <strong>D</strong> 	D (data, item) is the dataset to evaluate the neural network model.
			%  <strong>11</strong> <strong>GROUND_TRUTH</strong> 	GROUND_TRUTH (query, stringlist) returns the matrix of ground truth derived from the targets.
			%  <strong>12</strong> <strong>AUC</strong> 	AUC (result, rvector) provides the value of the area under the receiver operating characteristic curve.
			%  <strong>13</strong> <strong>PFROC</strong> 	PFROC (gui, item) contains the panel figure of the ROC plot for classification model.
			%  <strong>14</strong> <strong>MACRO_AUC</strong> 	MACRO_AUC (result, scalar) provides the metric of the average AUC value.
			%  <strong>15</strong> <strong>C_MATRIX</strong> 	C_MATRIX (result, matrix) provides the confusion matrix.
			%
			% See also Category, Format.
			
			nne = nne@NNEvaluator(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the neural network evaluator for multi-layer perceptron classifier.
			%
			% BUILD = NNClassifierMLP_Evaluator.GETBUILD() returns the build of 'NNClassifierMLP_Evaluator'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NNE.GETBUILD() returns the build of the neural network evaluator for multi-layer perceptron classifier NNE.
			%  BUILD = Element.GETBUILD(NNE) returns the build of 'NNE'.
			%  BUILD = Element.GETBUILD('NNClassifierMLP_Evaluator') returns the build of 'NNClassifierMLP_Evaluator'.
			%
			% Note that the Element.GETBUILD(NNE) and Element.GETBUILD('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nne_class = getClass()
			%GETCLASS returns the class of the neural network evaluator for multi-layer perceptron classifier.
			%
			% CLASS = NNClassifierMLP_Evaluator.GETCLASS() returns the class 'NNClassifierMLP_Evaluator'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNE.GETCLASS() returns the class of the neural network evaluator for multi-layer perceptron classifier NNE.
			%  CLASS = Element.GETCLASS(NNE) returns the class of 'NNE'.
			%  CLASS = Element.GETCLASS('NNClassifierMLP_Evaluator') returns 'NNClassifierMLP_Evaluator'.
			%
			% Note that the Element.GETCLASS(NNE) and Element.GETCLASS('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			
			nne_class = 'NNClassifierMLP_Evaluator';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network evaluator for multi-layer perceptron classifier.
			%
			% LIST = NNClassifierMLP_Evaluator.GETSUBCLASSES() returns all subclasses of 'NNClassifierMLP_Evaluator'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNE.GETSUBCLASSES() returns all subclasses of the neural network evaluator for multi-layer perceptron classifier NNE.
			%  LIST = Element.GETSUBCLASSES(NNE) returns all subclasses of 'NNE'.
			%  LIST = Element.GETSUBCLASSES('NNClassifierMLP_Evaluator') returns all subclasses of 'NNClassifierMLP_Evaluator'.
			%
			% Note that the Element.GETSUBCLASSES(NNE) and Element.GETSUBCLASSES('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNClassifierMLP_Evaluator' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network evaluator for multi-layer perceptron classifier.
			%
			% PROPS = NNClassifierMLP_Evaluator.GETPROPS() returns the property list of neural network evaluator for multi-layer perceptron classifier
			%  as a row vector.
			%
			% PROPS = NNClassifierMLP_Evaluator.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNE.GETPROPS([CATEGORY]) returns the property list of the neural network evaluator for multi-layer perceptron classifier NNE.
			%  PROPS = Element.GETPROPS(NNE[, CATEGORY]) returns the property list of 'NNE'.
			%  PROPS = Element.GETPROPS('NNClassifierMLP_Evaluator'[, CATEGORY]) returns the property list of 'NNClassifierMLP_Evaluator'.
			%
			% Note that the Element.GETPROPS(NNE) and Element.GETPROPS('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
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
					prop_list = [5 9 10];
				case 5 % Category.RESULT
					prop_list = [12 14 15];
				case 6 % Category.QUERY
					prop_list = [8 11];
				case 9 % Category.GUI
					prop_list = 13;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network evaluator for multi-layer perceptron classifier.
			%
			% N = NNClassifierMLP_Evaluator.GETPROPNUMBER() returns the property number of neural network evaluator for multi-layer perceptron classifier.
			%
			% N = NNClassifierMLP_Evaluator.GETPROPNUMBER(CATEGORY) returns the property number of neural network evaluator for multi-layer perceptron classifier
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNE.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network evaluator for multi-layer perceptron classifier NNE.
			%  N = Element.GETPROPNUMBER(NNE) returns the property number of 'NNE'.
			%  N = Element.GETPROPNUMBER('NNClassifierMLP_Evaluator') returns the property number of 'NNClassifierMLP_Evaluator'.
			%
			% Note that the Element.GETPROPNUMBER(NNE) and Element.GETPROPNUMBER('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 15;
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
					prop_number = 3;
				case 5 % Category.RESULT
					prop_number = 3;
				case 6 % Category.QUERY
					prop_number = 2;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network evaluator for multi-layer perceptron classifier/error.
			%
			% CHECK = NNClassifierMLP_Evaluator.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSPROP(PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNE, PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNClassifierMLP_Evaluator, PROP) checks whether PROP exists for NNClassifierMLP_Evaluator.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%  Element.EXISTSPROP(NNE, PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%  Element.EXISTSPROP(NNClassifierMLP_Evaluator, PROP) throws error if PROP does NOT exist for NNClassifierMLP_Evaluator.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNE) and Element.EXISTSPROP('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 15 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_Evaluator:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_Evaluator:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNClassifierMLP_Evaluator.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network evaluator for multi-layer perceptron classifier/error.
			%
			% CHECK = NNClassifierMLP_Evaluator.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSTAG(TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNE, TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNClassifierMLP_Evaluator, TAG) checks whether TAG exists for NNClassifierMLP_Evaluator.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%  Element.EXISTSTAG(NNE, TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%  Element.EXISTSTAG(NNClassifierMLP_Evaluator, TAG) throws error if TAG does NOT exist for NNClassifierMLP_Evaluator.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNE) and Element.EXISTSTAG('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NN'  'D'  'GROUND_TRUTH'  'AUC'  'PFROC'  'MACRO_AUC'  'C_MATRIX' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_Evaluator:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_Evaluator:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNClassifierMLP_Evaluator.'] ...
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
			%  PROPERTY = NNE.GETPROPPROP(POINTER) returns property number of POINTER of NNE.
			%  PROPERTY = Element.GETPROPPROP(NNClassifierMLP_Evaluator, POINTER) returns property number of POINTER of NNClassifierMLP_Evaluator.
			%  PROPERTY = NNE.GETPROPPROP(NNClassifierMLP_Evaluator, POINTER) returns property number of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPPROP(NNE) and Element.GETPROPPROP('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NN'  'D'  'GROUND_TRUTH'  'AUC'  'PFROC'  'MACRO_AUC'  'C_MATRIX' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = NNE.GETPROPTAG(POINTER) returns tag of POINTER of NNE.
			%  TAG = Element.GETPROPTAG(NNClassifierMLP_Evaluator, POINTER) returns tag of POINTER of NNClassifierMLP_Evaluator.
			%  TAG = NNE.GETPROPTAG(NNClassifierMLP_Evaluator, POINTER) returns tag of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPTAG(NNE) and Element.GETPROPTAG('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnclassifiermlp_evaluator_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NN'  'D'  'GROUND_TRUTH'  'AUC'  'PFROC'  'MACRO_AUC'  'C_MATRIX' };
				tag = nnclassifiermlp_evaluator_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = NNE.GETPROPCATEGORY(POINTER) returns category of POINTER of NNE.
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierMLP_Evaluator, POINTER) returns category of POINTER of NNClassifierMLP_Evaluator.
			%  CATEGORY = NNE.GETPROPCATEGORY(NNClassifierMLP_Evaluator, POINTER) returns category of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPCATEGORY(NNE) and Element.GETPROPCATEGORY('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_evaluator_category_list = { 1  1  1  3  4  2  2  6  4  4  6  5  9  5  5 };
			prop_category = nnclassifiermlp_evaluator_category_list{prop};
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
			%  FORMAT = NNE.GETPROPFORMAT(POINTER) returns format of POINTER of NNE.
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierMLP_Evaluator, POINTER) returns format of POINTER of NNClassifierMLP_Evaluator.
			%  FORMAT = NNE.GETPROPFORMAT(NNClassifierMLP_Evaluator, POINTER) returns format of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPFORMAT(NNE) and Element.GETPROPFORMAT('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_evaluator_format_list = { 2  2  2  8  2  2  2  2  8  8  3  12  8  11  14 };
			prop_format = nnclassifiermlp_evaluator_format_list{prop};
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
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNE.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierMLP_Evaluator, POINTER) returns description of POINTER of NNClassifierMLP_Evaluator.
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(NNClassifierMLP_Evaluator, POINTER) returns description of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNE) and Element.GETPROPDESCRIPTION('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnclassifiermlp_evaluator_description_list = { 'ELCLASS (constant, string) is the class of the neural network evaluator for a multi-layer perceptron classifier.'  'NAME (constant, string) is the name of the neural network evaluator for a multi-layer perceptron classifier.'  'DESCRIPTION (constant, string) is the description of the neural network evaluator for a multi-layer perceptron classifier.'  'TEMPLATE (parameter, item) is the template of the neural network evaluator for a multi-layer perceptron classifier.'  'ID (data, string) is a few-letter code for the neural network evaluator for a multi-layer perceptron classifier.'  'LABEL (metadata, string) is an extended label of the neural network evaluator for a multi-layer perceptron classifier.'  'NOTES (metadata, string) are some specific notes about the neural network evaluator for a multi-layer perceptron classifier.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'NN (data, item) contains a trained neural network multi-layer perceptron classifier.'  'D (data, item) is the dataset to evaluate the neural network model.'  'GROUND_TRUTH (query, stringlist) returns the matrix of ground truth derived from the targets.'  'AUC (result, rvector) provides the value of the area under the receiver operating characteristic curve.'  'PFROC (gui, item) contains the panel figure of the ROC plot for classification model.'  'MACRO_AUC (result, scalar) provides the metric of the average AUC value.'  'C_MATRIX (result, matrix) provides the confusion matrix.' };
			prop_description = nnclassifiermlp_evaluator_description_list{prop};
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
			%  SETTINGS = NNE.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNE.
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierMLP_Evaluator, POINTER) returns settings of POINTER of NNClassifierMLP_Evaluator.
			%  SETTINGS = NNE.GETPROPSETTINGS(NNClassifierMLP_Evaluator, POINTER) returns settings of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPSETTINGS(NNE) and Element.GETPROPSETTINGS('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 11 % NNClassifierMLP_Evaluator.GROUND_TRUTH
					prop_settings = Format.getFormatSettings(3);
				case 12 % NNClassifierMLP_Evaluator.AUC
					prop_settings = Format.getFormatSettings(12);
				case 13 % NNClassifierMLP_Evaluator.PFROC
					prop_settings = 'NNClassifierMLP_EvaluatorPF_ROC';
				case 14 % NNClassifierMLP_Evaluator.MACRO_AUC
					prop_settings = Format.getFormatSettings(11);
				case 15 % NNClassifierMLP_Evaluator.C_MATRIX
					prop_settings = Format.getFormatSettings(14);
				case 4 % NNClassifierMLP_Evaluator.TEMPLATE
					prop_settings = 'NNClassifierMLP_Evaluator';
				case 9 % NNClassifierMLP_Evaluator.NN
					prop_settings = 'NNClassifierMLP';
				otherwise
					prop_settings = getPropSettings@NNEvaluator(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNClassifierMLP_Evaluator.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_Evaluator.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULT(NNClassifierMLP_Evaluator, POINTER) returns the default value of POINTER of NNClassifierMLP_Evaluator.
			%  DEFAULT = NNE.GETPROPDEFAULT(NNClassifierMLP_Evaluator, POINTER) returns the default value of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPDEFAULT(NNE) and Element.GETPROPDEFAULT('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 11 % NNClassifierMLP_Evaluator.GROUND_TRUTH
					prop_default = Format.getFormatDefault(3, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 12 % NNClassifierMLP_Evaluator.AUC
					prop_default = Format.getFormatDefault(12, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 13 % NNClassifierMLP_Evaluator.PFROC
					prop_default = Format.getFormatDefault(8, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 14 % NNClassifierMLP_Evaluator.MACRO_AUC
					prop_default = Format.getFormatDefault(11, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 15 % NNClassifierMLP_Evaluator.C_MATRIX
					prop_default = Format.getFormatDefault(14, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 1 % NNClassifierMLP_Evaluator.ELCLASS
					prop_default = 'NNClassifierMLP_Evaluator';
				case 2 % NNClassifierMLP_Evaluator.NAME
					prop_default = 'Neural Network Evaluator for a Multi-layer Perceptron Classifier';
				case 3 % NNClassifierMLP_Evaluator.DESCRIPTION
					prop_default = 'A neural network evaluator for a multi-layer perceptron classifier (NNClassifierMLP_Evaluator) evaluates the performance of a multi-layer perceptron classifier with a given dataset. NNClassifierMLP_Evaluator evaluates the performance of the trained classifier with a given dataset in terms of various classification metrics (e.g., confusion matrix, area under the receiver operating characteristic curve).';
				case 4 % NNClassifierMLP_Evaluator.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 5 % NNClassifierMLP_Evaluator.ID
					prop_default = 'NNClassifierMLP_Evaluator ID';
				case 6 % NNClassifierMLP_Evaluator.LABEL
					prop_default = 'NNClassifierMLP_Evaluator label';
				case 7 % NNClassifierMLP_Evaluator.NOTES
					prop_default = 'NNClassifierMLP_Evaluator notes';
				case 9 % NNClassifierMLP_Evaluator.NN
					prop_default = Format.getFormatDefault(8, NNClassifierMLP_Evaluator.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNEvaluator(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNClassifierMLP_Evaluator.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_Evaluator.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_Evaluator, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_Evaluator.
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_Evaluator, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNE) and Element.GETPROPDEFAULTCONDITIONED('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			prop_default = NNClassifierMLP_Evaluator.conditioning(prop, NNClassifierMLP_Evaluator.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNE.
			%  CHECK = Element.CHECKPROP(NNClassifierMLP_Evaluator, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_Evaluator.
			%  CHECK = NNE.CHECKPROP(NNClassifierMLP_Evaluator, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_Evaluator.
			% 
			% NNE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNClassifierMLP_Evaluator:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNE.
			%   Error id: BRAPH2:NNClassifierMLP_Evaluator:WrongInput
			%  Element.CHECKPROP(NNClassifierMLP_Evaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_Evaluator.
			%   Error id: BRAPH2:NNClassifierMLP_Evaluator:WrongInput
			%  NNE.CHECKPROP(NNClassifierMLP_Evaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_Evaluator.
			%   Error id: BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NNE) and Element.CHECKPROP('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			switch prop
				case 11 % NNClassifierMLP_Evaluator.GROUND_TRUTH
					check = Format.checkFormat(3, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 12 % NNClassifierMLP_Evaluator.AUC
					check = Format.checkFormat(12, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 13 % NNClassifierMLP_Evaluator.PFROC
					check = Format.checkFormat(8, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 14 % NNClassifierMLP_Evaluator.MACRO_AUC
					check = Format.checkFormat(11, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 15 % NNClassifierMLP_Evaluator.C_MATRIX
					check = Format.checkFormat(14, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 4 % NNClassifierMLP_Evaluator.TEMPLATE
					check = Format.checkFormat(8, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case 9 % NNClassifierMLP_Evaluator.NN
					check = Format.checkFormat(8, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				otherwise
					if prop <= 10
						check = checkProp@NNEvaluator(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNClassifierMLP_Evaluator:' 'WrongInput'], ...
					['BRAPH2' ':NNClassifierMLP_Evaluator:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNClassifierMLP_Evaluator.getPropTag(prop) ' (' NNClassifierMLP_Evaluator.getFormatTag(NNClassifierMLP_Evaluator.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(nne, prop)
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
				case 13 % NNClassifierMLP_Evaluator.PFROC
					if isa(nne.getr('PFROC'), 'NoValue')
					    nne.set('PFROC', NNClassifierMLP_EvaluatorPF_ROC('NNE', nne));
					end
					
				otherwise
					if prop <= 10
						postprocessing@NNEvaluator(nne, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nne, prop, varargin)
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
				case 11 % NNClassifierMLP_Evaluator.GROUND_TRUTH
					targets = nne.get('NN').get('TARGET_CLASSES', nne.get('D'));
					if isempty(targets)
					    value = {''};
					else
					    value = targets;
					end
					
				case 12 % NNClassifierMLP_Evaluator.AUC
					rng_settings_ = rng(); rng(nne.getPropSeed(12), 'twister')
					
					predictions = cell2mat(nne.get('NN').get('PREDICT', nne.get('D')));
					if isempty(predictions)
					    value = [];
					else
					    class_names = nne.get('NN').get('MODEL').Layers(end).Classes;
					    ground_truth = categorical(nne.get('GROUND_TRUTH'));
					    rocNet = rocmetrics(ground_truth, predictions, class_names);
					    value = rocNet.AUC;
					end
					
					rng(rng_settings_)
					
				case 14 % NNClassifierMLP_Evaluator.MACRO_AUC
					rng_settings_ = rng(); rng(nne.getPropSeed(14), 'twister')
					
					auc = nne.get('AUC');
					if isempty(auc)
					    value = 0;
					else
					    value = double(mean(auc));
					end
					
					rng(rng_settings_)
					
				case 15 % NNClassifierMLP_Evaluator.C_MATRIX
					rng_settings_ = rng(); rng(nne.getPropSeed(15), 'twister')
					
					predictions = cell2mat(nne.get('NN').get('PREDICT', nne.get('D')));
					[~, maxIndices] = max(predictions, [], 2);
					predictions = logical(full(sparse(1:numel(maxIndices), maxIndices, 1, size(predictions, 1), size(predictions, 2))));
					if isempty(predictions)
					    value = [];
					else
					    classNames = nne.get('NN').get('MODEL').Layers(end).Classes;
					    for i = 1:length(predictions)
					        classified(i) = classNames(predictions(i, :));
					    end
					    ground_truth = categorical(nne.get('GROUND_TRUTH'));
					    value = confusionmat(classified, ground_truth);
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 10
						value = calculateValue@NNEvaluator(nne, prop, varargin{:});
					else
						value = calculateValue@Element(nne, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(nne, prop, varargin)
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
				case 13 % NNClassifierMLP_Evaluator.PFROC
					pr = PanelPropItem('EL', nne, 'PROP', 13, ...
					    'GUICLASS', 'GUIFig', ...
						'BUTTON_TEXT', ['ROC Plot'], ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@NNEvaluator(nne, prop, varargin{:});
					
			end
		end
	end
end
