classdef ComparisonEnsemble < ConcreteElement
	%ComparisonEnsemble contains the results of an ensemble-based comparison.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% ComparisonEnsemble contains the results of an ensemble-based comparison for a given measure.
	% Specifically, it contains the one-tailed and two-tailed p-values 
	% and the 95%% confidence interval.
	%
	% The list of ComparisonEnsemble properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the results of an ensemble-based comparison.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the results of an ensemble-based comparison.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the results of an ensemble-based comparison.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the results of an ensemble-based comparison.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the results of an ensemble-based comparison.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the results of an ensemble-based comparison.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>MEASURE</strong> 	MEASURE (parameter, class) is the measure class.
	%  <strong>10</strong> <strong>C</strong> 	C (data, item) is the ensemble-based comparison.
	%  <strong>11</strong> <strong>DIFF</strong> 	DIFF (result, cell) is the ensemble comparison value.
	%  <strong>12</strong> <strong>P1</strong> 	P1 (result, cell) is the one-tailed p-value.
	%  <strong>13</strong> <strong>P2</strong> 	P2 (result, cell) is the two-tailed p-value.
	%  <strong>14</strong> <strong>CIL</strong> 	CIL (result, cell) is the lower value of the 95%% confidence interval.
	%  <strong>15</strong> <strong>CIU</strong> 	CIU (result, cell) is the upper value of the 95%% confidence interval.
	%  <strong>16</strong> <strong>QVALUE</strong> 	QVALUE (metadata, scalar) is the selected qvalue threshold.
	%  <strong>17</strong> <strong>PFC</strong> 	PFC (gui, item) contains the panel figure of the comparison.
	%  <strong>18</strong> <strong>PFB</strong> 	PFB (gui, item) contains the panel figure of the comparison.
	%  <strong>19</strong> <strong>CALCULATE_RESULTS</strong> 	CALCULATE_RESULTS (evanescent, cell) calculates the comparison results {diff, p1, p2, ci_lower, ci_upper}.
	%
	% ComparisonEnsemble methods (constructor):
	%  ComparisonEnsemble - constructor
	%
	% ComparisonEnsemble methods:
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
	% ComparisonEnsemble methods (display):
	%  tostring - string with information about the ensemble-based comparison results
	%  disp - displays information about the ensemble-based comparison results
	%  tree - displays the tree of the ensemble-based comparison results
	%
	% ComparisonEnsemble methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ensemble-based comparison results are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ensemble-based comparison results
	%
	% ComparisonEnsemble methods (save/load, Static):
	%  save - saves BRAPH2 ensemble-based comparison results as b2 file
	%  load - loads a BRAPH2 ensemble-based comparison results from a b2 file
	%
	% ComparisonEnsemble method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ensemble-based comparison results
	%
	% ComparisonEnsemble method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ensemble-based comparison results
	%
	% ComparisonEnsemble methods (inspection, Static):
	%  getClass - returns the class of the ensemble-based comparison results
	%  getSubclasses - returns all subclasses of ComparisonEnsemble
	%  getProps - returns the property list of the ensemble-based comparison results
	%  getPropNumber - returns the property number of the ensemble-based comparison results
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
	% ComparisonEnsemble methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonEnsemble methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonEnsemble methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonEnsemble methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonEnsemble; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonEnsemble constants</a>.
	%
	%
	% See also CompareEnsemble, AnalyzeEnsemble.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		MEASURE = 9; %CET: Computational Efficiency Trick
		MEASURE_TAG = 'MEASURE';
		MEASURE_CATEGORY = 3;
		MEASURE_FORMAT = 6;
		
		C = 10; %CET: Computational Efficiency Trick
		C_TAG = 'C';
		C_CATEGORY = 4;
		C_FORMAT = 8;
		
		DIFF = 11; %CET: Computational Efficiency Trick
		DIFF_TAG = 'DIFF';
		DIFF_CATEGORY = 5;
		DIFF_FORMAT = 16;
		
		P1 = 12; %CET: Computational Efficiency Trick
		P1_TAG = 'P1';
		P1_CATEGORY = 5;
		P1_FORMAT = 16;
		
		P2 = 13; %CET: Computational Efficiency Trick
		P2_TAG = 'P2';
		P2_CATEGORY = 5;
		P2_FORMAT = 16;
		
		CIL = 14; %CET: Computational Efficiency Trick
		CIL_TAG = 'CIL';
		CIL_CATEGORY = 5;
		CIL_FORMAT = 16;
		
		CIU = 15; %CET: Computational Efficiency Trick
		CIU_TAG = 'CIU';
		CIU_CATEGORY = 5;
		CIU_FORMAT = 16;
		
		QVALUE = 16; %CET: Computational Efficiency Trick
		QVALUE_TAG = 'QVALUE';
		QVALUE_CATEGORY = 2;
		QVALUE_FORMAT = 11;
		
		PFC = 17; %CET: Computational Efficiency Trick
		PFC_TAG = 'PFC';
		PFC_CATEGORY = 9;
		PFC_FORMAT = 8;
		
		PFB = 18; %CET: Computational Efficiency Trick
		PFB_TAG = 'PFB';
		PFB_CATEGORY = 9;
		PFB_FORMAT = 8;
		
		CALCULATE_RESULTS = 19; %CET: Computational Efficiency Trick
		CALCULATE_RESULTS_TAG = 'CALCULATE_RESULTS';
		CALCULATE_RESULTS_CATEGORY = 7;
		CALCULATE_RESULTS_FORMAT = 16;
	end
	methods % constructor
		function cp = ComparisonEnsemble(varargin)
			%ComparisonEnsemble() creates a ensemble-based comparison results.
			%
			% ComparisonEnsemble(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonEnsemble(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ComparisonEnsemble properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the results of an ensemble-based comparison.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the results of an ensemble-based comparison.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the results of an ensemble-based comparison.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the results of an ensemble-based comparison.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the results of an ensemble-based comparison.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the results of an ensemble-based comparison.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>MEASURE</strong> 	MEASURE (parameter, class) is the measure class.
			%  <strong>10</strong> <strong>C</strong> 	C (data, item) is the ensemble-based comparison.
			%  <strong>11</strong> <strong>DIFF</strong> 	DIFF (result, cell) is the ensemble comparison value.
			%  <strong>12</strong> <strong>P1</strong> 	P1 (result, cell) is the one-tailed p-value.
			%  <strong>13</strong> <strong>P2</strong> 	P2 (result, cell) is the two-tailed p-value.
			%  <strong>14</strong> <strong>CIL</strong> 	CIL (result, cell) is the lower value of the 95%% confidence interval.
			%  <strong>15</strong> <strong>CIU</strong> 	CIU (result, cell) is the upper value of the 95%% confidence interval.
			%  <strong>16</strong> <strong>QVALUE</strong> 	QVALUE (metadata, scalar) is the selected qvalue threshold.
			%  <strong>17</strong> <strong>PFC</strong> 	PFC (gui, item) contains the panel figure of the comparison.
			%  <strong>18</strong> <strong>PFB</strong> 	PFB (gui, item) contains the panel figure of the comparison.
			%  <strong>19</strong> <strong>CALCULATE_RESULTS</strong> 	CALCULATE_RESULTS (evanescent, cell) calculates the comparison results {diff, p1, p2, ci_lower, ci_upper}.
			%
			% See also Category, Format.
			
			cp = cp@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the ensemble-based comparison results.
			%
			% BUILD = ComparisonEnsemble.GETBUILD() returns the build of 'ComparisonEnsemble'.
			%
			% Alternative forms to call this method are:
			%  BUILD = CP.GETBUILD() returns the build of the ensemble-based comparison results CP.
			%  BUILD = Element.GETBUILD(CP) returns the build of 'CP'.
			%  BUILD = Element.GETBUILD('ComparisonEnsemble') returns the build of 'ComparisonEnsemble'.
			%
			% Note that the Element.GETBUILD(CP) and Element.GETBUILD('ComparisonEnsemble')
			%  are less computationally efficient.
			
			build = 1;
		end
		function cp_class = getClass()
			%GETCLASS returns the class of the ensemble-based comparison results.
			%
			% CLASS = ComparisonEnsemble.GETCLASS() returns the class 'ComparisonEnsemble'.
			%
			% Alternative forms to call this method are:
			%  CLASS = CP.GETCLASS() returns the class of the ensemble-based comparison results CP.
			%  CLASS = Element.GETCLASS(CP) returns the class of 'CP'.
			%  CLASS = Element.GETCLASS('ComparisonEnsemble') returns 'ComparisonEnsemble'.
			%
			% Note that the Element.GETCLASS(CP) and Element.GETCLASS('ComparisonEnsemble')
			%  are less computationally efficient.
			
			cp_class = 'ComparisonEnsemble';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ensemble-based comparison results.
			%
			% LIST = ComparisonEnsemble.GETSUBCLASSES() returns all subclasses of 'ComparisonEnsemble'.
			%
			% Alternative forms to call this method are:
			%  LIST = CP.GETSUBCLASSES() returns all subclasses of the ensemble-based comparison results CP.
			%  LIST = Element.GETSUBCLASSES(CP) returns all subclasses of 'CP'.
			%  LIST = Element.GETSUBCLASSES('ComparisonEnsemble') returns all subclasses of 'ComparisonEnsemble'.
			%
			% Note that the Element.GETSUBCLASSES(CP) and Element.GETSUBCLASSES('ComparisonEnsemble')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ComparisonEnsemble' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ensemble-based comparison results.
			%
			% PROPS = ComparisonEnsemble.GETPROPS() returns the property list of ensemble-based comparison results
			%  as a row vector.
			%
			% PROPS = ComparisonEnsemble.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = CP.GETPROPS([CATEGORY]) returns the property list of the ensemble-based comparison results CP.
			%  PROPS = Element.GETPROPS(CP[, CATEGORY]) returns the property list of 'CP'.
			%  PROPS = Element.GETPROPS('ComparisonEnsemble'[, CATEGORY]) returns the property list of 'ComparisonEnsemble'.
			%
			% Note that the Element.GETPROPS(CP) and Element.GETPROPS('ComparisonEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 16];
				case 3 % Category.PARAMETER
					prop_list = [4 9];
				case 4 % Category.DATA
					prop_list = [5 10];
				case 5 % Category.RESULT
					prop_list = [11 12 13 14 15];
				case 6 % Category.QUERY
					prop_list = 8;
				case 7 % Category.EVANESCENT
					prop_list = 19;
				case 9 % Category.GUI
					prop_list = [17 18];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of ensemble-based comparison results.
			%
			% N = ComparisonEnsemble.GETPROPNUMBER() returns the property number of ensemble-based comparison results.
			%
			% N = ComparisonEnsemble.GETPROPNUMBER(CATEGORY) returns the property number of ensemble-based comparison results
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = CP.GETPROPNUMBER([CATEGORY]) returns the property number of the ensemble-based comparison results CP.
			%  N = Element.GETPROPNUMBER(CP) returns the property number of 'CP'.
			%  N = Element.GETPROPNUMBER('ComparisonEnsemble') returns the property number of 'ComparisonEnsemble'.
			%
			% Note that the Element.GETPROPNUMBER(CP) and Element.GETPROPNUMBER('ComparisonEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 19;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 2;
				case 4 % Category.DATA
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 5;
				case 6 % Category.QUERY
					prop_number = 1;
				case 7 % Category.EVANESCENT
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in ensemble-based comparison results/error.
			%
			% CHECK = ComparisonEnsemble.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CP.EXISTSPROP(PROP) checks whether PROP exists for CP.
			%  CHECK = Element.EXISTSPROP(CP, PROP) checks whether PROP exists for CP.
			%  CHECK = Element.EXISTSPROP(ComparisonEnsemble, PROP) checks whether PROP exists for ComparisonEnsemble.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CP.EXISTSPROP(PROP) throws error if PROP does NOT exist for CP.
			%   Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%  Element.EXISTSPROP(CP, PROP) throws error if PROP does NOT exist for CP.
			%   Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%  Element.EXISTSPROP(ComparisonEnsemble, PROP) throws error if PROP does NOT exist for ComparisonEnsemble.
			%   Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%
			% Note that the Element.EXISTSPROP(CP) and Element.EXISTSPROP('ComparisonEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 19 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ComparisonEnsemble:' 'WrongInput'], ...
					['BRAPH2' ':ComparisonEnsemble:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonEnsemble.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ensemble-based comparison results/error.
			%
			% CHECK = ComparisonEnsemble.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CP.EXISTSTAG(TAG) checks whether TAG exists for CP.
			%  CHECK = Element.EXISTSTAG(CP, TAG) checks whether TAG exists for CP.
			%  CHECK = Element.EXISTSTAG(ComparisonEnsemble, TAG) checks whether TAG exists for ComparisonEnsemble.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CP.EXISTSTAG(TAG) throws error if TAG does NOT exist for CP.
			%   Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%  Element.EXISTSTAG(CP, TAG) throws error if TAG does NOT exist for CP.
			%   Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%  Element.EXISTSTAG(ComparisonEnsemble, TAG) throws error if TAG does NOT exist for ComparisonEnsemble.
			%   Error id: [BRAPH2:ComparisonEnsemble:WrongInput]
			%
			% Note that the Element.EXISTSTAG(CP) and Element.EXISTSTAG('ComparisonEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'MEASURE'  'C'  'DIFF'  'P1'  'P2'  'CIL'  'CIU'  'QVALUE'  'PFC'  'PFB'  'CALCULATE_RESULTS' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ComparisonEnsemble:' 'WrongInput'], ...
					['BRAPH2' ':ComparisonEnsemble:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonEnsemble.'] ...
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
			%  PROPERTY = CP.GETPROPPROP(POINTER) returns property number of POINTER of CP.
			%  PROPERTY = Element.GETPROPPROP(ComparisonEnsemble, POINTER) returns property number of POINTER of ComparisonEnsemble.
			%  PROPERTY = CP.GETPROPPROP(ComparisonEnsemble, POINTER) returns property number of POINTER of ComparisonEnsemble.
			%
			% Note that the Element.GETPROPPROP(CP) and Element.GETPROPPROP('ComparisonEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'MEASURE'  'C'  'DIFF'  'P1'  'P2'  'CIL'  'CIU'  'QVALUE'  'PFC'  'PFB'  'CALCULATE_RESULTS' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = CP.GETPROPTAG(POINTER) returns tag of POINTER of CP.
			%  TAG = Element.GETPROPTAG(ComparisonEnsemble, POINTER) returns tag of POINTER of ComparisonEnsemble.
			%  TAG = CP.GETPROPTAG(ComparisonEnsemble, POINTER) returns tag of POINTER of ComparisonEnsemble.
			%
			% Note that the Element.GETPROPTAG(CP) and Element.GETPROPTAG('ComparisonEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				comparisonensemble_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'MEASURE'  'C'  'DIFF'  'P1'  'P2'  'CIL'  'CIU'  'QVALUE'  'PFC'  'PFB'  'CALCULATE_RESULTS' };
				tag = comparisonensemble_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = CP.GETPROPCATEGORY(POINTER) returns category of POINTER of CP.
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonEnsemble, POINTER) returns category of POINTER of ComparisonEnsemble.
			%  CATEGORY = CP.GETPROPCATEGORY(ComparisonEnsemble, POINTER) returns category of POINTER of ComparisonEnsemble.
			%
			% Note that the Element.GETPROPCATEGORY(CP) and Element.GETPROPCATEGORY('ComparisonEnsemble')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsemble.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			comparisonensemble_category_list = { 1  1  1  3  4  2  2  6  3  4  5  5  5  5  5  2  9  9  7 };
			prop_category = comparisonensemble_category_list{prop};
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
			%  FORMAT = CP.GETPROPFORMAT(POINTER) returns format of POINTER of CP.
			%  FORMAT = Element.GETPROPFORMAT(ComparisonEnsemble, POINTER) returns format of POINTER of ComparisonEnsemble.
			%  FORMAT = CP.GETPROPFORMAT(ComparisonEnsemble, POINTER) returns format of POINTER of ComparisonEnsemble.
			%
			% Note that the Element.GETPROPFORMAT(CP) and Element.GETPROPFORMAT('ComparisonEnsemble')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsemble.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			comparisonensemble_format_list = { 2  2  2  8  2  2  2  2  6  8  16  16  16  16  16  11  8  8  16 };
			prop_format = comparisonensemble_format_list{prop};
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
			%  DESCRIPTION = CP.GETPROPDESCRIPTION(POINTER) returns description of POINTER of CP.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonEnsemble, POINTER) returns description of POINTER of ComparisonEnsemble.
			%  DESCRIPTION = CP.GETPROPDESCRIPTION(ComparisonEnsemble, POINTER) returns description of POINTER of ComparisonEnsemble.
			%
			% Note that the Element.GETPROPDESCRIPTION(CP) and Element.GETPROPDESCRIPTION('ComparisonEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsemble.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			comparisonensemble_description_list = { 'ELCLASS (constant, string) is the class of the % % % .'  'NAME (constant, string) is the name of the results of an ensemble-based comparison.'  'DESCRIPTION (constant, string) is the description of the results of an ensemble-based comparison.'  'TEMPLATE (parameter, item) is the template of the results of an ensemble-based comparison.'  'ID (data, string) is a few-letter code for the results of an ensemble-based comparison.'  'LABEL (metadata, string) is an extended label of the results of an ensemble-based comparison.'  'NOTES (metadata, string) are some specific notes about the results of an ensemble-based comparison.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'MEASURE (parameter, class) is the measure class.'  'C (data, item) is the ensemble-based comparison.'  'DIFF (result, cell) is the ensemble comparison value.'  'P1 (result, cell) is the one-tailed p-value.'  'P2 (result, cell) is the two-tailed p-value.'  'CIL (result, cell) is the lower value of the 95%% confidence interval.'  'CIU (result, cell) is the upper value of the 95%% confidence interval.'  'QVALUE (metadata, scalar) is the selected qvalue threshold.'  'PFC (gui, item) contains the panel figure of the comparison.'  'PFB (gui, item) contains the panel figure of the comparison.'  'CALCULATE_RESULTS (evanescent, cell) calculates the comparison results {diff, p1, p2, ci_lower, ci_upper}.' };
			prop_description = comparisonensemble_description_list{prop};
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
			%  SETTINGS = CP.GETPROPSETTINGS(POINTER) returns settings of POINTER of CP.
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonEnsemble, POINTER) returns settings of POINTER of ComparisonEnsemble.
			%  SETTINGS = CP.GETPROPSETTINGS(ComparisonEnsemble, POINTER) returns settings of POINTER of ComparisonEnsemble.
			%
			% Note that the Element.GETPROPSETTINGS(CP) and Element.GETPROPSETTINGS('ComparisonEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsemble.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % ComparisonEnsemble.MEASURE
					prop_settings = 'Measure';
				case 10 % ComparisonEnsemble.C
					prop_settings = 'CompareEnsemble';
				case 11 % ComparisonEnsemble.DIFF
					prop_settings = Format.getFormatSettings(16);
				case 12 % ComparisonEnsemble.P1
					prop_settings = Format.getFormatSettings(16);
				case 13 % ComparisonEnsemble.P2
					prop_settings = Format.getFormatSettings(16);
				case 14 % ComparisonEnsemble.CIL
					prop_settings = Format.getFormatSettings(16);
				case 15 % ComparisonEnsemble.CIU
					prop_settings = Format.getFormatSettings(16);
				case 16 % ComparisonEnsemble.QVALUE
					prop_settings = Format.getFormatSettings(11);
				case 17 % ComparisonEnsemble.PFC
					prop_settings = 'ComparisonEnsemblePF';
				case 18 % ComparisonEnsemble.PFB
					prop_settings = 'ComparisonEnsembleBrainPF';
				case 19 % ComparisonEnsemble.CALCULATE_RESULTS
					prop_settings = Format.getFormatSettings(16);
				case 4 % ComparisonEnsemble.TEMPLATE
					prop_settings = 'ComparisonEnsemble';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonEnsemble.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsemble.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of CP.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonEnsemble, POINTER) returns the default value of POINTER of ComparisonEnsemble.
			%  DEFAULT = CP.GETPROPDEFAULT(ComparisonEnsemble, POINTER) returns the default value of POINTER of ComparisonEnsemble.
			%
			% Note that the Element.GETPROPDEFAULT(CP) and Element.GETPROPDEFAULT('ComparisonEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonEnsemble.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % ComparisonEnsemble.MEASURE
					prop_default = Format.getFormatDefault(6, ComparisonEnsemble.getPropSettings(prop));
				case 10 % ComparisonEnsemble.C
					prop_default = Format.getFormatDefault(8, ComparisonEnsemble.getPropSettings(prop));
				case 11 % ComparisonEnsemble.DIFF
					prop_default = Format.getFormatDefault(16, ComparisonEnsemble.getPropSettings(prop));
				case 12 % ComparisonEnsemble.P1
					prop_default = Format.getFormatDefault(16, ComparisonEnsemble.getPropSettings(prop));
				case 13 % ComparisonEnsemble.P2
					prop_default = Format.getFormatDefault(16, ComparisonEnsemble.getPropSettings(prop));
				case 14 % ComparisonEnsemble.CIL
					prop_default = Format.getFormatDefault(16, ComparisonEnsemble.getPropSettings(prop));
				case 15 % ComparisonEnsemble.CIU
					prop_default = Format.getFormatDefault(16, ComparisonEnsemble.getPropSettings(prop));
				case 16 % ComparisonEnsemble.QVALUE
					prop_default = 0.05;
				case 17 % ComparisonEnsemble.PFC
					prop_default = Format.getFormatDefault(8, ComparisonEnsemble.getPropSettings(prop));
				case 18 % ComparisonEnsemble.PFB
					prop_default = Format.getFormatDefault(8, ComparisonEnsemble.getPropSettings(prop));
				case 19 % ComparisonEnsemble.CALCULATE_RESULTS
					prop_default = Format.getFormatDefault(16, ComparisonEnsemble.getPropSettings(prop));
				case 1 % ComparisonEnsemble.ELCLASS
					prop_default = 'ComparisonEnsemble';
				case 2 % ComparisonEnsemble.NAME
					prop_default = 'ComparisonEnsemble';
				case 3 % ComparisonEnsemble.DESCRIPTION
					prop_default = 'ComparisonEnsemble contains the results of an ensemble-based comparison for a given measure. Specifically, it contains the one-tailed and two-tailed p-values and the 95%% confidence interval.';
				case 4 % ComparisonEnsemble.TEMPLATE
					prop_default = Format.getFormatDefault(8, ComparisonEnsemble.getPropSettings(prop));
				case 5 % ComparisonEnsemble.ID
					prop_default = 'ComparisonEnsemble ID';
				case 6 % ComparisonEnsemble.LABEL
					prop_default = 'ComparisonEnsemble label';
				case 7 % ComparisonEnsemble.NOTES
					prop_default = 'ComparisonEnsemble notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonEnsemble.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsemble.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of CP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonEnsemble, POINTER) returns the conditioned default value of POINTER of ComparisonEnsemble.
			%  DEFAULT = CP.GETPROPDEFAULTCONDITIONED(ComparisonEnsemble, POINTER) returns the conditioned default value of POINTER of ComparisonEnsemble.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(CP) and Element.GETPROPDEFAULTCONDITIONED('ComparisonEnsemble')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonEnsemble.getPropProp(pointer);
			
			prop_default = ComparisonEnsemble.conditioning(prop, ComparisonEnsemble.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = CP.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = CP.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of CP.
			%  CHECK = Element.CHECKPROP(ComparisonEnsemble, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsemble.
			%  CHECK = CP.CHECKPROP(ComparisonEnsemble, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsemble.
			% 
			% CP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ComparisonEnsemble:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of CP.
			%   Error id: BRAPH2:ComparisonEnsemble:WrongInput
			%  Element.CHECKPROP(ComparisonEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsemble.
			%   Error id: BRAPH2:ComparisonEnsemble:WrongInput
			%  CP.CHECKPROP(ComparisonEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsemble.
			%   Error id: BRAPH2:ComparisonEnsemble:WrongInput]
			% 
			% Note that the Element.CHECKPROP(CP) and Element.CHECKPROP('ComparisonEnsemble')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonEnsemble.getPropProp(pointer);
			
			switch prop
				case 9 % ComparisonEnsemble.MEASURE
					check = Format.checkFormat(6, value, ComparisonEnsemble.getPropSettings(prop));
				case 10 % ComparisonEnsemble.C
					check = Format.checkFormat(8, value, ComparisonEnsemble.getPropSettings(prop));
				case 11 % ComparisonEnsemble.DIFF
					check = Format.checkFormat(16, value, ComparisonEnsemble.getPropSettings(prop));
				case 12 % ComparisonEnsemble.P1
					check = Format.checkFormat(16, value, ComparisonEnsemble.getPropSettings(prop));
				case 13 % ComparisonEnsemble.P2
					check = Format.checkFormat(16, value, ComparisonEnsemble.getPropSettings(prop));
				case 14 % ComparisonEnsemble.CIL
					check = Format.checkFormat(16, value, ComparisonEnsemble.getPropSettings(prop));
				case 15 % ComparisonEnsemble.CIU
					check = Format.checkFormat(16, value, ComparisonEnsemble.getPropSettings(prop));
				case 16 % ComparisonEnsemble.QVALUE
					check = Format.checkFormat(11, value, ComparisonEnsemble.getPropSettings(prop));
				case 17 % ComparisonEnsemble.PFC
					check = Format.checkFormat(8, value, ComparisonEnsemble.getPropSettings(prop));
				case 18 % ComparisonEnsemble.PFB
					check = Format.checkFormat(8, value, ComparisonEnsemble.getPropSettings(prop));
				case 19 % ComparisonEnsemble.CALCULATE_RESULTS
					check = Format.checkFormat(16, value, ComparisonEnsemble.getPropSettings(prop));
				case 4 % ComparisonEnsemble.TEMPLATE
					check = Format.checkFormat(8, value, ComparisonEnsemble.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ComparisonEnsemble:' 'WrongInput'], ...
					['BRAPH2' ':ComparisonEnsemble:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonEnsemble.getPropTag(prop) ' (' ComparisonEnsemble.getFormatTag(ComparisonEnsemble.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(cp, prop)
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
				case 17 % ComparisonEnsemble.PFC
					if isa(cp.getr('PFC'), 'NoValue')
					
					    measure = cp.get('MEASURE');
					
					    switch Element.getPropDefault(measure, 'SHAPE')
					        case 1 % Measure.GLOBAL
					            switch Element.getPropDefault(measure, 'SCOPE')
					                case 1 % Measure.SUPERGLOBAL
					                    cp.set('PFC', ComparisonEnsemblePF_GS('CP', cp))
					                case 2 % Measure.UNILAYER
					                    cp.set('PFC', ComparisonEnsemblePF_GU('CP', cp))
					                case 3 % Measure.BILAYER
					                    cp.set('PFC', ComparisonEnsemblePF_GB('CP', cp))
					            end
					        case 2 % Measure.NODAL
					            switch Element.getPropDefault(measure, 'SCOPE')
					                case 1 % Measure.SUPERGLOBAL
					                    cp.set('PFC', ComparisonEnsemblePF_NS('CP', cp))
					                case 2 % Measure.UNILAYER
					                    cp.set('PFC', ComparisonEnsemblePF_NU('CP', cp))
					                case 3 % Measure.BILAYER
					                    cp.set('PFC', ComparisonEnsemblePF_NB('CP', cp))
					            end
					        case 3 % Measure.BINODAL
					            switch Element.getPropDefault(measure, 'SCOPE')
					                case 1 % Measure.SUPERGLOBAL
					                    cp.set('PFC', ComparisonEnsemblePF_BS('CP', cp))
					                case 2 % Measure.UNILAYER
					                    cp.set('PFC', ComparisonEnsemblePF_BU('CP', cp))
					                case 3 % Measure.BILAYER
					                    cp.set('PFC', ComparisonEnsemblePF_BB('CP', cp))
					            end
					    end
					end
					
				case 18 % ComparisonEnsemble.PFB
					if isa(cp.getr('PFB'), 'NoValue')
					
					    measure = cp.get('MEASURE');
					    if isempty(cp.get('C').get('A1').get('GR').get('SUB_DICT').get('IT_LIST'))
					        brain_atlas = BrainAtlas();
					    else
					        brain_atlas = cp.get('C').get('A1').get('GR').get('SUB_DICT').get('IT', 1).get('BA');
					    end
					    switch Element.getPropDefault(measure, 'SHAPE')
					        case 1 % Measure.GLOBAL
					            switch Element.getPropDefault(measure, 'SCOPE')
					                case 1 % Measure.SUPERGLOBAL
					                    cp.set('PFB', ComparisonEnsembleBrainPF_GS('CP', cp, 'BA', brain_atlas))
					                case 2 % Measure.UNILAYER
					                    cp.set('PFB', ComparisonEnsembleBrainPF_GU('CP', cp, 'BA', brain_atlas))
					                case 3 % Measure.BILAYER
					                    cp.set('PFB', ComparisonEnsembleBrainPF_GB('CP', cp, 'BA', brain_atlas))
					            end
					        case 2 % Measure.NODAL
					            switch Element.getPropDefault(measure, 'SCOPE')
					                case 1 % Measure.SUPERGLOBAL
					                    cp.set('PFB', ComparisonEnsembleBrainPF_NS('CP', cp, 'BA', brain_atlas))
					                case 2 % Measure.UNILAYER
					                    cp.set('PFB', ComparisonEnsembleBrainPF_NU('CP', cp, 'BA', brain_atlas))
					                case 3 % Measure.BILAYER
					                    cp.set('PFB', ComparisonEnsembleBrainPF_NB('CP', cp, 'BA', brain_atlas))
					            end
					        case 3 % Measure.BINODAL
					            switch Element.getPropDefault(measure, 'SCOPE')
					                case 1 % Measure.SUPERGLOBAL
					                    cp.set('PFB', ComparisonEnsembleBrainPF_BS('CP', cp, 'BA', brain_atlas))
					                case 2 % Measure.UNILAYER
					                    cp.set('PFB', ComparisonEnsembleBrainPF_BU('CP', cp, 'BA', brain_atlas))
					                case 3 % Measure.BILAYER
					                    cp.set('PFB',ComparisonEnsembleBrainPF_BB('CP', cp, 'BA', brain_atlas))
					            end
					    end
					end
					
				otherwise
					if prop <= 8
						postprocessing@ConcreteElement(cp, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(cp, prop, varargin)
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
				case 11 % ComparisonEnsemble.DIFF
					rng_settings_ = rng(); rng(cp.getPropSeed(11), 'twister')
					
					results = cp.memorize('CALCULATE_RESULTS');
					value = results{1}; % diff
					
					rng(rng_settings_)
					
				case 12 % ComparisonEnsemble.P1
					rng_settings_ = rng(); rng(cp.getPropSeed(12), 'twister')
					
					results = cp.memorize('CALCULATE_RESULTS');
					value = results{2}; % p1
					
					rng(rng_settings_)
					
				case 13 % ComparisonEnsemble.P2
					rng_settings_ = rng(); rng(cp.getPropSeed(13), 'twister')
					
					results = cp.memorize('CALCULATE_RESULTS');
					value = results{3}; % p2
					
					rng(rng_settings_)
					
				case 14 % ComparisonEnsemble.CIL
					rng_settings_ = rng(); rng(cp.getPropSeed(14), 'twister')
					
					results = cp.memorize('CALCULATE_RESULTS');
					value = results{4}; % ci_lower
					
					rng(rng_settings_)
					
				case 15 % ComparisonEnsemble.CIU
					rng_settings_ = rng(); rng(cp.getPropSeed(15), 'twister')
					
					results = cp.memorize('CALCULATE_RESULTS');
					value = results{5}; % ci_upper
					
					rng(rng_settings_)
					
				case 19 % ComparisonEnsemble.CALCULATE_RESULTS
					% {DIFF, P1, P2, CIL, CIU} = cp.get('CALCULATE_RESULTS') calcultes the 
					%  one-talied p-value P1, the two-tailed p-value P2, the lower bound of the 
					%  confidence interval CIL, and the the upper bound of the confidence interval.
					%  Typically, this methos is only called internally.
					
					measure_class = cp.get('MEASURE');
					if strcmpi(cp.get('MEASURE'), 'Measure')
					    diff = {};
					    p1 = {};
					    p2 = {};
					    ci_lower = {};
					    ci_upper = {};
					    value = {diff, p1, p2, ci_lower, ci_upper};
					    return
					end
					
					c = cp.get('C');
					
					wb = braph2waitbar(c.get('WAITBAR'), 0, ['Comparing ensemble ' cp.get('MEASURE') '...']);
					
					% Pre-calculate and save measures of all subjects
					ms1 = cellfun(@(x) x.get('MEASURE', measure_class, varargin{:}).memorize('M'), c.get('A1').memorize('G_DICT').get('IT_LIST'), 'UniformOutput', false);
					ms2 = cellfun(@(x) x.get('MEASURE', measure_class, varargin{:}).memorize('M'), c.get('A2').memorize('G_DICT').get('IT_LIST'), 'UniformOutput', false);
					
					% Measure for groups 1 and 2, and their difference
					m1 = c.get('A1').get('MEASUREENSEMBLE', measure_class).memorize('M');
					m2 = c.get('A2').get('MEASUREENSEMBLE', measure_class).memorize('M');
					diff = cellfun(@(x, y) y - x, m1, m2, 'UniformOutput', false);
					
					% Permutations
					P = c.get('P'); %#ok<*PROPLC>
					
					m1_perms = cell(1, P);
					m2_perms = cell(1, P);
					diff_perms = cell(1, P);
					
					start = tic;
					seeds = c.memorize('PERM_SEEDS');
					for p = 1:20:P
					    parfor q = p:min(p+20, P)
					        % [a1_perm, a2_perm] = c.getPerm(i, memorize);
					        % 
					        % m1_perms{1, i} = a1_perm.getMeasureEnsemble(measure_class).memorize('M');
					        % m2_perms{1, i} = a2_perm.getMeasureEnsemble(measure_class).memorize('M');
					        % diff_perms{1, i} = cellfun(@(x, y) y - x, m1_perms{1, i}, m2_perms{1, i}, 'UniformOutput', false);
					
					        rng(seeds(q), 'twister')
					
					        [ms1_perm, ms2_perm] = permutation(ms1, ms2, c.get('LONGITUDINAL'));
					
					        ms1_av = cell(size(ms1_perm{1}));
					        ms2_av = cell(size(ms1_perm{1}));
					        for i = 1:1:size(ms1_perm{1}, 1)
					            for j = 1:1:size(ms1_perm{1}, 2)
					
					                ms1_perm_ij = cellfun(@(x) x{i, j}, ms1_perm, 'UniformOutput', false);
					                ms1_av{i, j} = mean(cat(ndims(ms1_perm_ij{1}) + 1, ms1_perm_ij{:}), ndims(ms1_perm_ij{1}) + 1);
					
					                ms2_perm_ij = cellfun(@(x) x{i, j}, ms2_perm, 'UniformOutput', false);
					                ms2_av{i, j} = mean(cat(ndims(ms2_perm_ij{1}) + 1, ms2_perm_ij{:}), ndims(ms2_perm_ij{1}) + 1);
					            end
					        end
					        m1_perms{1, q} = ms1_av;
					        m2_perms{1, q} = ms2_av;
					        diff_perms{1, q} = cellfun(@(x, y) y - x, m1_perms{1, q}, m2_perms{1, q}, 'UniformOutput', false);
					    end
					
					    braph2waitbar(wb, p / P, ['Comparing group ' cp.get('MEASURE') '. Permutation ' num2str(p) ' of ' num2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...'])
					    if c.get('VERBOSE')
					        disp(['** PERMUTATION TEST - sampling #' int2str(p) '/' int2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
					    end
					    if c.get('INTERRUPTIBLE')
					        pause(c.get('INTERRUPTIBLE'))
					    end
					end
					
					braph2waitbar(wb, 'close')
					
					% Statistical analysis
					p1 = cell(size(diff));
					p2 = cell(size(diff));
					ci_lower = cell(size(diff));
					ci_upper = cell(size(diff));
					for i = 1:1:size(diff, 1)
					    for j = 1:1:size(diff, 2)
					        p1(i, j) = pvalue1(diff(i, j), cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false));
					        p2(i, j) = pvalue2(diff(i, j), cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false));
					        qtl = quantiles(cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false), 40);
					        ci_lower(i, j) = {cellfun(@(x) x(2), qtl)};
					        ci_upper(i, j) = {cellfun(@(x) x(40), qtl)};
						end
					end
					
					value = {diff, p1, p2, ci_lower, ci_upper};
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(cp, prop, varargin{:});
					else
						value = calculateValue@Element(cp, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(cp, prop, varargin)
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
				case 11 % ComparisonEnsemble.DIFF
					if cp.get('C').get('A1').get('G_DICT').get('LENGTH')
					    g = cp.get('C').get('A1').get('G_DICT').get('IT', 1);
					else
					    g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
					end
					g.memorize('A');
					measure = cp.get('MEASURE');
					
					pr = PanelPropCellFDR('EL', cp, 'PROP', 11,  ...
					    'TABLEQVALUE', cp.get('QVALUE'), 'TABLEFDR', true, varargin{:}); 
					
					if Element.getPropDefault(measure, 'SHAPE') == 1 % Measure.GLOBAL
					    pr.set( ...
					        'TABLE_HEIGHT', 48, ...
					        'ROWNAME', {}, ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == 2 % Measure.NODAL
					    pr.set( ...
					        'TABLE_HEIGHT', 480, ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == 3 % Measure.BINODAL
					    pr.set( ...
					        'TABLE_HEIGHT', 480, ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', g.getCallback('ANODELABELS') ...
					        )
					end
					
					if g.get('LAYERNUMBER') == 1
					    pr.set( ...
					        'XSLIDERSHOW', false, ...
					        'YSLIDERSHOW', false ...
					        )
					else % multigraph, multiplex, multilayer
					    if  Element.getPropDefault(measure, 'SCOPE') == 1 % Measure.SUPERGLOBAL
					        if isempty(g.get('APARTITIONLABELS'))
					            pr.set( ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', false ...
					                )
					        else
					            pr.set( ...
					                'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), 12 * length(g.get('APARTITIONLABELS'))), ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', true, ...
					                'YSLIDERLABELS', g.getCallback('APARTITIONLABELS'), ...
					                'YSLIDERWIDTH', 60 ...
					                )
					        end
					    elseif Element.getPropDefault(measure, 'SCOPE') == 2 % Measure.UNILAYER
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), 12 * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', 60 ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == 3 % Measure.BILAYER
					        pr.set( ...
					            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), 36 + 12 * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', true, ...
					            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'XSLIDERHEIGHT', 36, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', 60 ...
					            )
					    end
					end
					
				case 12 % ComparisonEnsemble.P1
					if cp.get('C').get('A1').get('G_DICT').get('LENGTH')
					    g = cp.get('C').get('A1').get('G_DICT').get('IT', 1);
					else
					    g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
					end
					g.memorize('A');
					measure = cp.get('MEASURE');
					
					pr = PanelPropCell('EL', cp, 'PROP', 12, varargin{:});
					
					if Element.getPropDefault(measure, 'SHAPE') == 1 % Measure.GLOBAL
					    pr.set( ...
					        'TABLE_HEIGHT', 48, ...
					        'ROWNAME', {}, ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == 2 % Measure.NODAL
					    pr.set( ...
					        'TABLE_HEIGHT', 480, ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == 3 % Measure.BINODAL
					    pr.set( ...
					        'TABLE_HEIGHT', 480, ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', g.getCallback('ANODELABELS') ...
					        )
					end
					
					if g.get('LAYERNUMBER') == 1
					    pr.set( ...
					        'XSLIDERSHOW', false, ...
					        'YSLIDERSHOW', false ...
					        )
					else % multigraph, multiplex, multilayer
					    if  Element.getPropDefault(measure, 'SCOPE') == 1 % Measure.SUPERGLOBAL
					        if isempty(g.get('APARTITIONLABELS'))
					            pr.set( ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', false ...
					                )
					        else
					            pr.set( ...
					                'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), 12 * length(g.get('APARTITIONLABELS'))), ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', true, ...
					                'YSLIDERLABELS', g.getCallback('APARTITIONLABELS'), ...
					                'YSLIDERWIDTH', 60 ...
					                )
					        end
					    elseif Element.getPropDefault(measure, 'SCOPE') == 2 % Measure.UNILAYER
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), 12 * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', 60 ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == 3 % Measure.BILAYER
					        pr.set( ...
					            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), 36 + 12 * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', true, ...
					            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'XSLIDERHEIGHT', 36, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', 60 ...
					            )
					    end
					end
					
				case 13 % ComparisonEnsemble.P2
					if cp.get('C').get('A1').get('G_DICT').get('LENGTH')
					    g = cp.get('C').get('A1').get('G_DICT').get('IT', 1);
					else
					    g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
					end
					g.memorize('A');
					measure = cp.get('MEASURE');
					
					pr = PanelPropCell('EL', cp, 'PROP', 13, varargin{:});
					
					if Element.getPropDefault(measure, 'SHAPE') == 1 % Measure.GLOBAL
					    pr.set( ...
					        'TABLE_HEIGHT', 48, ...
					        'ROWNAME', {}, ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == 2 % Measure.NODAL
					    pr.set( ...
					        'TABLE_HEIGHT', 480, ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == 3 % Measure.BINODAL
					    pr.set( ...
					        'TABLE_HEIGHT', 480, ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', g.getCallback('ANODELABELS') ...
					        )
					end
					
					if g.get('LAYERNUMBER') == 1
					    pr.set( ...
					        'XSLIDERSHOW', false, ...
					        'YSLIDERSHOW', false ...
					        )
					else % multigraph, multiplex, multilayer
					    if  Element.getPropDefault(measure, 'SCOPE') == 1 % Measure.SUPERGLOBAL
					        if isempty(g.get('APARTITIONLABELS'))
					            pr.set( ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', false ...
					                )
					        else
					            pr.set( ...
					                'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), 12 * length(g.get('APARTITIONLABELS'))), ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', true, ...
					                'YSLIDERLABELS', g.getCallback('APARTITIONLABELS'), ...
					                'YSLIDERWIDTH', 60 ...
					                )
					        end
					    elseif Element.getPropDefault(measure, 'SCOPE') == 2 % Measure.UNILAYER
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), 12 * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', 60 ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == 3 % Measure.BILAYER
					        pr.set( ...
					            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), 36 + 12 * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', true, ...
					            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'XSLIDERHEIGHT', 36, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', 60 ...
					            )
					    end
					end
					
				case 14 % ComparisonEnsemble.CIL
					if cp.get('C').get('A1').get('G_DICT').get('LENGTH')
					    g = cp.get('C').get('A1').get('G_DICT').get('IT', 1);
					else
					    g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
					end
					g.memorize('A');
					measure = cp.get('MEASURE');
					
					pr = PanelPropCell('EL', cp, 'PROP', 14, varargin{:});
					
					if Element.getPropDefault(measure, 'SHAPE') == 1 % Measure.GLOBAL
					    pr.set( ...
					        'TABLE_HEIGHT', 48, ...
					        'ROWNAME', {}, ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == 2 % Measure.NODAL
					    pr.set( ...
					        'TABLE_HEIGHT', 480, ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == 3 % Measure.BINODAL
					    pr.set( ...
					        'TABLE_HEIGHT', 480, ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', g.getCallback('ANODELABELS') ...
					        )
					end
					
					if g.get('LAYERNUMBER') == 1
					    pr.set( ...
					        'XSLIDERSHOW', false, ...
					        'YSLIDERSHOW', false ...
					        )
					else % multigraph, multiplex, multilayer
					    if  Element.getPropDefault(measure, 'SCOPE') == 1 % Measure.SUPERGLOBAL
					        if isempty(g.get('APARTITIONLABELS'))
					            pr.set( ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', false ...
					                )
					        else
					            pr.set( ...
					                'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), 12 * length(g.get('APARTITIONLABELS'))), ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', true, ...
					                'YSLIDERLABELS', g.getCallback('APARTITIONLABELS'), ...
					                'YSLIDERWIDTH', 60 ...
					                )
					        end
					    elseif Element.getPropDefault(measure, 'SCOPE') == 2 % Measure.UNILAYER
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), 12 * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', 60 ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == 3 % Measure.BILAYER
					        pr.set( ...
					            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), 36 + 12 * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', true, ...
					            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'XSLIDERHEIGHT', 36, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', 60 ...
					            )
					    end
					end
					
				case 15 % ComparisonEnsemble.CIU
					if cp.get('C').get('A1').get('G_DICT').get('LENGTH')
					    g = cp.get('C').get('A1').get('G_DICT').get('IT', 1);
					else
					    g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
					end
					g.memorize('A');
					measure = cp.get('MEASURE');
					
					pr = PanelPropCell('EL', cp, 'PROP', 15, varargin{:});
					
					if Element.getPropDefault(measure, 'SHAPE') == 1 % Measure.GLOBAL
					    pr.set( ...
					        'TABLE_HEIGHT', 48, ...
					        'ROWNAME', {}, ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == 2 % Measure.NODAL
					    pr.set( ...
					        'TABLE_HEIGHT', 480, ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == 3 % Measure.BINODAL
					    pr.set( ...
					        'TABLE_HEIGHT', 480, ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', g.getCallback('ANODELABELS') ...
					        )
					end
					
					if g.get('LAYERNUMBER') == 1
					    pr.set( ...
					        'XSLIDERSHOW', false, ...
					        'YSLIDERSHOW', false ...
					        )
					else % multigraph, multiplex, multilayer
					    if  Element.getPropDefault(measure, 'SCOPE') == 1 % Measure.SUPERGLOBAL
					        if isempty(g.get('APARTITIONLABELS'))
					            pr.set( ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', false ...
					                )
					        else
					            pr.set( ...
					                'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), 12 * length(g.get('APARTITIONLABELS'))), ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', true, ...
					                'YSLIDERLABELS', g.getCallback('APARTITIONLABELS'), ...
					                'YSLIDERWIDTH', 60 ...
					                )
					        end
					    elseif Element.getPropDefault(measure, 'SCOPE') == 2 % Measure.UNILAYER
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), 12 * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', 60 ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == 3 % Measure.BILAYER
					        pr.set( ...
					            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), 36 + 12 * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', true, ...
					            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'XSLIDERHEIGHT', 36, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', 60 ...
					            )
					    end
					end
					
				case 17 % ComparisonEnsemble.PFC
					pr = PanelPropItem('EL', cp, 'PROP', 17, ...
					    'GUICLASS', 'GUIFig', ...
						'BUTTON_TEXT', ['Plot ' cp.get('MEASURE') ' Comparison'], ...
					    varargin{:});
					
				case 18 % ComparisonEnsemble.PFB
					pr = PanelPropItem('EL', cp, 'PROP', 18, ...
					    'GUICLASS', 'GUIFig', ...
						'BUTTON_TEXT', ['Plot ' cp.get('MEASURE') ' Comparison'], ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(cp, prop, varargin{:});
					
			end
		end
	end
end
