classdef NNxMLP_FeatureImportanceBrainSurface_CV < NNxMLP_FeatureImportance_CV
	%NNxMLP_FeatureImportanceBrainSurface_CV manages the visuazation of the feature importance on the brain surface within neural network evaluators.
	% It is a subclass of <a href="matlab:help NNxMLP_FeatureImportance_CV">NNxMLP_FeatureImportance_CV</a>.
	%
	% A neural network feature importace on brain surface (NNFeatureImportanceBrainSurface) 
	%  manages the visualization of feature importance within neural network evaluators, particularly on the brain surface.
	% It handles different types of neural network inputs, including graph data 
	%  (for visualizng the importance of connections between nodes), measures (for visualizing the importance of nodal measures),
	%  and the subject data (connectivity data or structural data).
	%
	% The list of NNxMLP_FeatureImportanceBrainSurface_CV properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the element to manage the visuazation of the neural network feature importance on the brain surface.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about managing the visuazation of the neural network feature importance on the brain surface.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>NNCV</strong> 	NNCV (data, item) is the neural network cross validation to be tested on feature importance.
	%  <strong>10</strong> <strong>FI_TEMPLATE</strong> 	FI_TEMPLATE (parameter, item) is the feature importance template to set all feature importance analysis and visualization parameters.
	%  <strong>11</strong> <strong>FI_LIST</strong> 	FI_LIST (result, itemlist) contains a list of feature importance analysis for all folds.
	%  <strong>12</strong> <strong>P</strong> 	P (parameter, scalar) is the permutation number that determines the statistical significance of the features. 
	%  <strong>13</strong> <strong>PERM_SEEDS</strong> 	PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
	%  <strong>14</strong> <strong>APPLY_BONFERRONI</strong> 	APPLY_BONFERRONI (parameter, logical) determines whether to apply bonferroni correction.
	%  <strong>15</strong> <strong>APPLY_CONFIDENCE_INTERVALS</strong> 	APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.
	%  <strong>16</strong> <strong>VERBOSE</strong> 	VERBOSE (metadata, logical) is an indicator to display permutation progress information.
	%  <strong>17</strong> <strong>SIG_LEVEL</strong> 	SIG_LEVEL (parameter, scalar) determines the significant level.
	%  <strong>18</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
	%  <strong>19</strong> <strong>INTERRUPTIBLE</strong> 	INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.
	%  <strong>20</strong> <strong>AV_FEATURE_IMPORTANCE</strong> 	AV_FEATURE_IMPORTANCE (result, cell) is determined by obtaining the average value from the feature importance element list.
	%  <strong>21</strong> <strong>RESHAPED_AV_FEATURE_IMPORTANCE</strong> 	RESHAPED_AV_FEATURE_IMPORTANCE (result, cell) reshapes the cell of feature importances with the input data.
	%  <strong>22</strong> <strong>MAP_TO_CELL</strong> 	MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.
	%  <strong>23</strong> <strong>COUNT_ELEMENTS</strong> 	COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.
	%  <strong>24</strong> <strong>FLATTEN_CELL</strong> 	FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.
	%  <strong>25</strong> <strong>BA</strong> 	BA (parameter, item) is the brain atlas.
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (constructor):
	%  NNxMLP_FeatureImportanceBrainSurface_CV - constructor
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV methods:
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
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (display):
	%  tostring - string with information about the neural network feature importace for multi-layer perceptron
	%  disp - displays information about the neural network feature importace for multi-layer perceptron
	%  tree - displays the tree of the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network feature importace for multi-layer perceptron are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (save/load, Static):
	%  save - saves BRAPH2 neural network feature importace for multi-layer perceptron as b2 file
	%  load - loads a BRAPH2 neural network feature importace for multi-layer perceptron from a b2 file
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (inspection, Static):
	%  getClass - returns the class of the neural network feature importace for multi-layer perceptron
	%  getSubclasses - returns all subclasses of NNxMLP_FeatureImportanceBrainSurface_CV
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
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNxMLP_FeatureImportanceBrainSurface_CV methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNxMLP_FeatureImportanceBrainSurface_CV; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNxMLP_FeatureImportanceBrainSurface_CV constants</a>.
	%
	%
	% See also NNEvaluator, NNDataPoint_Graph_CLA, NNDataPoint_Measure_REG, NNDataPoint_CON_CLA, NNDataPoint_ST_CLA.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		BA = 25; %CET: Computational Efficiency Trick
		BA_TAG = 'BA';
		BA_CATEGORY = 3;
		BA_FORMAT = 8;
	end
	methods % constructor
		function nnficv = NNxMLP_FeatureImportanceBrainSurface_CV(varargin)
			%NNxMLP_FeatureImportanceBrainSurface_CV() creates a neural network feature importace for multi-layer perceptron.
			%
			% NNxMLP_FeatureImportanceBrainSurface_CV(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNxMLP_FeatureImportanceBrainSurface_CV(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNxMLP_FeatureImportanceBrainSurface_CV properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the element to manage the visuazation of the neural network feature importance on the brain surface.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about managing the visuazation of the neural network feature importance on the brain surface.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>NNCV</strong> 	NNCV (data, item) is the neural network cross validation to be tested on feature importance.
			%  <strong>10</strong> <strong>FI_TEMPLATE</strong> 	FI_TEMPLATE (parameter, item) is the feature importance template to set all feature importance analysis and visualization parameters.
			%  <strong>11</strong> <strong>FI_LIST</strong> 	FI_LIST (result, itemlist) contains a list of feature importance analysis for all folds.
			%  <strong>12</strong> <strong>P</strong> 	P (parameter, scalar) is the permutation number that determines the statistical significance of the features. 
			%  <strong>13</strong> <strong>PERM_SEEDS</strong> 	PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
			%  <strong>14</strong> <strong>APPLY_BONFERRONI</strong> 	APPLY_BONFERRONI (parameter, logical) determines whether to apply bonferroni correction.
			%  <strong>15</strong> <strong>APPLY_CONFIDENCE_INTERVALS</strong> 	APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.
			%  <strong>16</strong> <strong>VERBOSE</strong> 	VERBOSE (metadata, logical) is an indicator to display permutation progress information.
			%  <strong>17</strong> <strong>SIG_LEVEL</strong> 	SIG_LEVEL (parameter, scalar) determines the significant level.
			%  <strong>18</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
			%  <strong>19</strong> <strong>INTERRUPTIBLE</strong> 	INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.
			%  <strong>20</strong> <strong>AV_FEATURE_IMPORTANCE</strong> 	AV_FEATURE_IMPORTANCE (result, cell) is determined by obtaining the average value from the feature importance element list.
			%  <strong>21</strong> <strong>RESHAPED_AV_FEATURE_IMPORTANCE</strong> 	RESHAPED_AV_FEATURE_IMPORTANCE (result, cell) reshapes the cell of feature importances with the input data.
			%  <strong>22</strong> <strong>MAP_TO_CELL</strong> 	MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.
			%  <strong>23</strong> <strong>COUNT_ELEMENTS</strong> 	COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.
			%  <strong>24</strong> <strong>FLATTEN_CELL</strong> 	FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.
			%  <strong>25</strong> <strong>BA</strong> 	BA (parameter, item) is the brain atlas.
			%
			% See also Category, Format.
			
			nnficv = nnficv@NNxMLP_FeatureImportance_CV(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the neural network feature importace for multi-layer perceptron.
			%
			% BUILD = NNxMLP_FeatureImportanceBrainSurface_CV.GETBUILD() returns the build of 'NNxMLP_FeatureImportanceBrainSurface_CV'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NNFICV.GETBUILD() returns the build of the neural network feature importace for multi-layer perceptron NNFICV.
			%  BUILD = Element.GETBUILD(NNFICV) returns the build of 'NNFICV'.
			%  BUILD = Element.GETBUILD('NNxMLP_FeatureImportanceBrainSurface_CV') returns the build of 'NNxMLP_FeatureImportanceBrainSurface_CV'.
			%
			% Note that the Element.GETBUILD(NNFICV) and Element.GETBUILD('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nnficv_class = getClass()
			%GETCLASS returns the class of the neural network feature importace for multi-layer perceptron.
			%
			% CLASS = NNxMLP_FeatureImportanceBrainSurface_CV.GETCLASS() returns the class 'NNxMLP_FeatureImportanceBrainSurface_CV'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNFICV.GETCLASS() returns the class of the neural network feature importace for multi-layer perceptron NNFICV.
			%  CLASS = Element.GETCLASS(NNFICV) returns the class of 'NNFICV'.
			%  CLASS = Element.GETCLASS('NNxMLP_FeatureImportanceBrainSurface_CV') returns 'NNxMLP_FeatureImportanceBrainSurface_CV'.
			%
			% Note that the Element.GETCLASS(NNFICV) and Element.GETCLASS('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			
			nnficv_class = 'NNxMLP_FeatureImportanceBrainSurface_CV';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network feature importace for multi-layer perceptron.
			%
			% LIST = NNxMLP_FeatureImportanceBrainSurface_CV.GETSUBCLASSES() returns all subclasses of 'NNxMLP_FeatureImportanceBrainSurface_CV'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNFICV.GETSUBCLASSES() returns all subclasses of the neural network feature importace for multi-layer perceptron NNFICV.
			%  LIST = Element.GETSUBCLASSES(NNFICV) returns all subclasses of 'NNFICV'.
			%  LIST = Element.GETSUBCLASSES('NNxMLP_FeatureImportanceBrainSurface_CV') returns all subclasses of 'NNxMLP_FeatureImportanceBrainSurface_CV'.
			%
			% Note that the Element.GETSUBCLASSES(NNFICV) and Element.GETSUBCLASSES('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNxMLP_FeatureImportanceBrainSurface_CV' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network feature importace for multi-layer perceptron.
			%
			% PROPS = NNxMLP_FeatureImportanceBrainSurface_CV.GETPROPS() returns the property list of neural network feature importace for multi-layer perceptron
			%  as a row vector.
			%
			% PROPS = NNxMLP_FeatureImportanceBrainSurface_CV.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNFICV.GETPROPS([CATEGORY]) returns the property list of the neural network feature importace for multi-layer perceptron NNFICV.
			%  PROPS = Element.GETPROPS(NNFICV[, CATEGORY]) returns the property list of 'NNFICV'.
			%  PROPS = Element.GETPROPS('NNxMLP_FeatureImportanceBrainSurface_CV'[, CATEGORY]) returns the property list of 'NNxMLP_FeatureImportanceBrainSurface_CV'.
			%
			% Note that the Element.GETPROPS(NNFICV) and Element.GETPROPS('NNxMLP_FeatureImportanceBrainSurface_CV')
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
					prop_list = [6 7 16];
				case 3 % Category.PARAMETER
					prop_list = [4 10 12 14 15 17 25];
				case 4 % Category.DATA
					prop_list = [5 9];
				case 5 % Category.RESULT
					prop_list = [11 13 20 21];
				case 6 % Category.QUERY
					prop_list = [8 22 23 24];
				case 9 % Category.GUI
					prop_list = [18 19];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportanceBrainSurface_CV.GETPROPNUMBER() returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportanceBrainSurface_CV.GETPROPNUMBER(CATEGORY) returns the property number of neural network feature importace for multi-layer perceptron
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNFICV.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network feature importace for multi-layer perceptron NNFICV.
			%  N = Element.GETPROPNUMBER(NNFICV) returns the property number of 'NNFICV'.
			%  N = Element.GETPROPNUMBER('NNxMLP_FeatureImportanceBrainSurface_CV') returns the property number of 'NNxMLP_FeatureImportanceBrainSurface_CV'.
			%
			% Note that the Element.GETPROPNUMBER(NNFICV) and Element.GETPROPNUMBER('NNxMLP_FeatureImportanceBrainSurface_CV')
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
					prop_number = 7;
				case 4 % Category.DATA
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 4;
				case 6 % Category.QUERY
					prop_number = 4;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportanceBrainSurface_CV.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFICV.EXISTSPROP(PROP) checks whether PROP exists for NNFICV.
			%  CHECK = Element.EXISTSPROP(NNFICV, PROP) checks whether PROP exists for NNFICV.
			%  CHECK = Element.EXISTSPROP(NNxMLP_FeatureImportanceBrainSurface_CV, PROP) checks whether PROP exists for NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFICV.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			%  Element.EXISTSPROP(NNFICV, PROP) throws error if PROP does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			%  Element.EXISTSPROP(NNxMLP_FeatureImportanceBrainSurface_CV, PROP) throws error if PROP does NOT exist for NNxMLP_FeatureImportanceBrainSurface_CV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNFICV) and Element.EXISTSPROP('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 25 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurface_CV:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurface_CV:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNxMLP_FeatureImportanceBrainSurface_CV.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportanceBrainSurface_CV.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFICV.EXISTSTAG(TAG) checks whether TAG exists for NNFICV.
			%  CHECK = Element.EXISTSTAG(NNFICV, TAG) checks whether TAG exists for NNFICV.
			%  CHECK = Element.EXISTSTAG(NNxMLP_FeatureImportanceBrainSurface_CV, TAG) checks whether TAG exists for NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFICV.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			%  Element.EXISTSTAG(NNFICV, TAG) throws error if TAG does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			%  Element.EXISTSTAG(NNxMLP_FeatureImportanceBrainSurface_CV, TAG) throws error if TAG does NOT exist for NNxMLP_FeatureImportanceBrainSurface_CV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNFICV) and Element.EXISTSTAG('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NNCV'  'FI_TEMPLATE'  'FI_LIST'  'P'  'PERM_SEEDS'  'APPLY_BONFERRONI'  'APPLY_CONFIDENCE_INTERVALS'  'VERBOSE'  'SIG_LEVEL'  'WAITBAR'  'INTERRUPTIBLE'  'AV_FEATURE_IMPORTANCE'  'RESHAPED_AV_FEATURE_IMPORTANCE'  'MAP_TO_CELL'  'COUNT_ELEMENTS'  'FLATTEN_CELL'  'BA' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurface_CV:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurface_CV:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNxMLP_FeatureImportanceBrainSurface_CV.'] ...
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
			%  PROPERTY = NNFICV.GETPROPPROP(POINTER) returns property number of POINTER of NNFICV.
			%  PROPERTY = Element.GETPROPPROP(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  PROPERTY = NNFICV.GETPROPPROP(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Note that the Element.GETPROPPROP(NNFICV) and Element.GETPROPPROP('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NNCV'  'FI_TEMPLATE'  'FI_LIST'  'P'  'PERM_SEEDS'  'APPLY_BONFERRONI'  'APPLY_CONFIDENCE_INTERVALS'  'VERBOSE'  'SIG_LEVEL'  'WAITBAR'  'INTERRUPTIBLE'  'AV_FEATURE_IMPORTANCE'  'RESHAPED_AV_FEATURE_IMPORTANCE'  'MAP_TO_CELL'  'COUNT_ELEMENTS'  'FLATTEN_CELL'  'BA' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = NNFICV.GETPROPTAG(POINTER) returns tag of POINTER of NNFICV.
			%  TAG = Element.GETPROPTAG(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  TAG = NNFICV.GETPROPTAG(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Note that the Element.GETPROPTAG(NNFICV) and Element.GETPROPTAG('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnxmlp_featureimportancebrainsurface_cv_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NNCV'  'FI_TEMPLATE'  'FI_LIST'  'P'  'PERM_SEEDS'  'APPLY_BONFERRONI'  'APPLY_CONFIDENCE_INTERVALS'  'VERBOSE'  'SIG_LEVEL'  'WAITBAR'  'INTERRUPTIBLE'  'AV_FEATURE_IMPORTANCE'  'RESHAPED_AV_FEATURE_IMPORTANCE'  'MAP_TO_CELL'  'COUNT_ELEMENTS'  'FLATTEN_CELL'  'BA' };
				tag = nnxmlp_featureimportancebrainsurface_cv_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = NNFICV.GETPROPCATEGORY(POINTER) returns category of POINTER of NNFICV.
			%  CATEGORY = Element.GETPROPCATEGORY(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  CATEGORY = NNFICV.GETPROPCATEGORY(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Note that the Element.GETPROPCATEGORY(NNFICV) and Element.GETPROPCATEGORY('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface_CV.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportancebrainsurface_cv_category_list = { 1  1  1  3  4  2  2  6  4  3  5  3  5  3  3  2  3  9  9  5  5  6  6  6  3 };
			prop_category = nnxmlp_featureimportancebrainsurface_cv_category_list{prop};
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
			%  FORMAT = NNFICV.GETPROPFORMAT(POINTER) returns format of POINTER of NNFICV.
			%  FORMAT = Element.GETPROPFORMAT(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  FORMAT = NNFICV.GETPROPFORMAT(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Note that the Element.GETPROPFORMAT(NNFICV) and Element.GETPROPFORMAT('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface_CV.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportancebrainsurface_cv_format_list = { 2  2  2  8  2  2  2  2  8  8  9  11  12  4  4  4  11  4  11  16  16  1  1  1  8 };
			prop_format = nnxmlp_featureimportancebrainsurface_cv_format_list{prop};
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
			%  DESCRIPTION = NNFICV.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNFICV.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  DESCRIPTION = NNFICV.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNFICV) and Element.GETPROPDESCRIPTION('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface_CV.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnxmlp_featureimportancebrainsurface_cv_description_list = { 'ELCLASS (constant, string) is the class of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'NAME (constant, string) is the name of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'DESCRIPTION (constant, string) is the description of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'TEMPLATE (parameter, item) is the template of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'ID (data, string) is a few-letter code of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'LABEL (metadata, string) is an extended label of the element to manage the visuazation of the neural network feature importance on the brain surface.'  'NOTES (metadata, string) are some specific notes about managing the visuazation of the neural network feature importance on the brain surface.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'NNCV (data, item) is the neural network cross validation to be tested on feature importance.'  'FI_TEMPLATE (parameter, item) is the feature importance template to set all feature importance analysis and visualization parameters.'  'FI_LIST (result, itemlist) contains a list of feature importance analysis for all folds.'  'P (parameter, scalar) is the permutation number that determines the statistical significance of the features. '  'PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.'  'APPLY_BONFERRONI (parameter, logical) determines whether to apply bonferroni correction.'  'APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.'  'VERBOSE (metadata, logical) is an indicator to display permutation progress information.'  'SIG_LEVEL (parameter, scalar) determines the significant level.'  'WAITBAR (gui, logical) determines whether to show the waitbar.'  'INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.'  'AV_FEATURE_IMPORTANCE (result, cell) is determined by obtaining the average value from the feature importance element list.'  'RESHAPED_AV_FEATURE_IMPORTANCE (result, cell) reshapes the cell of feature importances with the input data.'  'MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.'  'COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.'  'FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.'  'BA (parameter, item) is the brain atlas.' };
			prop_description = nnxmlp_featureimportancebrainsurface_cv_description_list{prop};
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
			%  SETTINGS = NNFICV.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNFICV.
			%  SETTINGS = Element.GETPROPSETTINGS(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  SETTINGS = NNFICV.GETPROPSETTINGS(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Note that the Element.GETPROPSETTINGS(NNFICV) and Element.GETPROPSETTINGS('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface_CV.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 25 % NNxMLP_FeatureImportanceBrainSurface_CV.BA
					prop_settings = 'BrainAtlas';
				case 4 % NNxMLP_FeatureImportanceBrainSurface_CV.TEMPLATE
					prop_settings = 'NNxMLP_FeatureImportanceBrainSurface_CV';
				case 10 % NNxMLP_FeatureImportanceBrainSurface_CV.FI_TEMPLATE
					prop_settings = 'NNxMLP_FeatureImportanceBrainSurface';
				otherwise
					prop_settings = getPropSettings@NNxMLP_FeatureImportance_CV(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurface_CV.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurface_CV.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFICV.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNFICV.
			%  DEFAULT = Element.GETPROPDEFAULT(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  DEFAULT = NNFICV.GETPROPDEFAULT(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Note that the Element.GETPROPDEFAULT(NNFICV) and Element.GETPROPDEFAULT('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface_CV.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 25 % NNxMLP_FeatureImportanceBrainSurface_CV.BA
					prop_default = Format.getFormatDefault(8, NNxMLP_FeatureImportanceBrainSurface_CV.getPropSettings(prop));
				case 1 % NNxMLP_FeatureImportanceBrainSurface_CV.ELCLASS
					prop_default = 'NNxMLP_FeatureImportanceBrainSurface_CV';
				case 2 % NNxMLP_FeatureImportanceBrainSurface_CV.NAME
					prop_default = 'Feature Importace for Multi-layer Perceptron';
				case 3 % NNxMLP_FeatureImportanceBrainSurface_CV.DESCRIPTION
					prop_default = 'A neural network feature importace on brain surface (NNFeatureImportanceBrainSurface) manages the visualization of feature importance within neural network evaluators, particularly on the brain surface. It handles different types of neural network inputs, including graph data (for visualizng the importance of connections between nodes), measures (for visualizing the importance of nodal measures), and the subject data (connectivity data or structural data).';
				case 4 % NNxMLP_FeatureImportanceBrainSurface_CV.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNxMLP_FeatureImportanceBrainSurface_CV.getPropSettings(prop));
				case 5 % NNxMLP_FeatureImportanceBrainSurface_CV.ID
					prop_default = 'NNxMLP_FeatureImportanceBrainSurface_CV ID';
				case 6 % NNxMLP_FeatureImportanceBrainSurface_CV.LABEL
					prop_default = 'NNxMLP_FeatureImportanceBrainSurface_CV label';
				case 7 % NNxMLP_FeatureImportanceBrainSurface_CV.NOTES
					prop_default = 'NNxMLP_FeatureImportanceBrainSurface_CV notes';
				case 10 % NNxMLP_FeatureImportanceBrainSurface_CV.FI_TEMPLATE
					prop_default = Format.getFormatDefault(8, NNxMLP_FeatureImportanceBrainSurface_CV.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNxMLP_FeatureImportance_CV(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurface_CV.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceBrainSurface_CV.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFICV.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNFICV.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  DEFAULT = NNFICV.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceBrainSurface_CV, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceBrainSurface_CV.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNFICV) and Element.GETPROPDEFAULTCONDITIONED('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNxMLP_FeatureImportanceBrainSurface_CV.getPropProp(pointer);
			
			prop_default = NNxMLP_FeatureImportanceBrainSurface_CV.conditioning(prop, NNxMLP_FeatureImportanceBrainSurface_CV.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNFICV.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNFICV.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNFICV.
			%  CHECK = Element.CHECKPROP(NNxMLP_FeatureImportanceBrainSurface_CV, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceBrainSurface_CV.
			%  CHECK = NNFICV.CHECKPROP(NNxMLP_FeatureImportanceBrainSurface_CV, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceBrainSurface_CV.
			% 
			% NNFICV.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNFICV.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNFICV.
			%   Error id: BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput
			%  Element.CHECKPROP(NNxMLP_FeatureImportanceBrainSurface_CV, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceBrainSurface_CV.
			%   Error id: BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput
			%  NNFICV.CHECKPROP(NNxMLP_FeatureImportanceBrainSurface_CV, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceBrainSurface_CV.
			%   Error id: BRAPH2:NNxMLP_FeatureImportanceBrainSurface_CV:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NNFICV) and Element.CHECKPROP('NNxMLP_FeatureImportanceBrainSurface_CV')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNxMLP_FeatureImportanceBrainSurface_CV.getPropProp(pointer);
			
			switch prop
				case 25 % NNxMLP_FeatureImportanceBrainSurface_CV.BA
					check = Format.checkFormat(8, value, NNxMLP_FeatureImportanceBrainSurface_CV.getPropSettings(prop));
				case 4 % NNxMLP_FeatureImportanceBrainSurface_CV.TEMPLATE
					check = Format.checkFormat(8, value, NNxMLP_FeatureImportanceBrainSurface_CV.getPropSettings(prop));
				case 10 % NNxMLP_FeatureImportanceBrainSurface_CV.FI_TEMPLATE
					check = Format.checkFormat(8, value, NNxMLP_FeatureImportanceBrainSurface_CV.getPropSettings(prop));
				otherwise
					if prop <= 24
						check = checkProp@NNxMLP_FeatureImportance_CV(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurface_CV:' 'WrongInput'], ...
					['BRAPH2' ':NNxMLP_FeatureImportanceBrainSurface_CV:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNxMLP_FeatureImportanceBrainSurface_CV.getPropTag(prop) ' (' NNxMLP_FeatureImportanceBrainSurface_CV.getFormatTag(NNxMLP_FeatureImportanceBrainSurface_CV.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(nnficv, prop, varargin)
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
				case 20 % NNxMLP_FeatureImportanceBrainSurface_CV.AV_FEATURE_IMPORTANCE
					if isempty(nnficv.get('NNCV').get('D_LIST'))
					    input_dataset = NNDataset();
					else
					    input_dataset = nnficv.get('NNCV').get('D_LIST_IT', 1);
					end
					dp_class = input_dataset.get('DP_CLASS');
					graph_dp_classes = {NNDataPoint_Graph_CLA().get('ELCLASS'), NNDataPoint_Graph_REG().get('ELCLASS')};
					measure_dp_classes = {NNDataPoint_Measure_CLA().get('ELCLASS'), NNDataPoint_Measure_REG().get('ELCLASS')};
					
					if any(strcmp(dp_class, graph_dp_classes)) % GRAPH input
					    pr = NNxMLP_FeatureImportanceBrainSurfacePP_Graph('EL', nnficv, 'BA', nnficv.get('BA'), 'D', input_dataset, 'PROP', 20, 'RESHAPED_PROP', 21, varargin{:});
					elseif any(strcmp(dp_class, measure_dp_classes))% MEASURE input
					    pr = NNxMLP_FeatureImportanceBrainSurfacePP_Measure('EL', nnficv, 'BA', nnficv.get('BA'), 'D', input_dataset, 'PROP', 20, 'RESHAPED_PROP', 21, varargin{:});
					else % DATA input
					    pr = NNxMLP_FeatureImportanceBrainSurfacePP_Data('EL', nnficv, 'BA', nnficv.get('BA'), 'D', input_dataset, 'PROP', 20, 'RESHAPED_PROP', 21, varargin{:});
					end
					
				otherwise
					pr = getPanelProp@NNxMLP_FeatureImportance_CV(nnficv, prop, varargin{:});
					
			end
		end
	end
end
