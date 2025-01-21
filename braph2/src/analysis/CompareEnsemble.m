classdef CompareEnsemble < ConcreteElement
	%CompareEnsemble is a comparison between two ensemble-based analyses.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% CompareEnsemble compares two ensemble-based analyses, 
	% which need to be of the same class.
	%
	% The list of CompareEnsemble properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the comparison between two ensemble-based analyses.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the comparison between two ensemble-based analyses.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the comparison between two ensemble-based analyses.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the comparison between two ensemble-based analyses.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the comparison between two ensemble-based analyses.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the comparison between two ensemble-based analyses.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) sets whether to write the progress of the comparisons.
	%  <strong>11</strong> <strong>INTERRUPTIBLE</strong> 	INTERRUPTIBLE (gui, scalar) sets whether the comparison computation is interruptible for multitasking.
	%  <strong>12</strong> <strong>MEMORIZE</strong> 	MEMORIZE (metadata, logical) sets whether to memorize the permuted analyses.
	%  <strong>13</strong> <strong>P</strong> 	P (parameter, scalar) is the permutation number.
	%  <strong>14</strong> <strong>LONGITUDINAL</strong> 	LONGITUDINAL (parameter, logical) determines whether the comparison is longitudinal.
	%  <strong>15</strong> <strong>A1</strong> 	A1 (data, item) is the first analysis to compare.
	%  <strong>16</strong> <strong>A2</strong> 	A2 (data, item) is the second analysis to compare.
	%  <strong>17</strong> <strong>PERM_SEEDS</strong> 	PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
	%  <strong>18</strong> <strong>A1_PERM_DICT</strong> 	A1_PERM_DICT (result, idict) is the list of permuted analyses for the first analysis.
	%  <strong>19</strong> <strong>A2_PERM_DICT</strong> 	A2_PERM_DICT (result, idict) is the list of permuted analyses for the second analysis.
	%  <strong>20</strong> <strong>CP_DICT</strong> 	CP_DICT (result, idict) contains the results of the comparison.
	%  <strong>21</strong> <strong>COMPARISON</strong> 	COMPARISON (query, item) returns a comparison.
	%  <strong>22</strong> <strong>PERM</strong> 	PERM (query, itemlist) returns the permuted analyses.
	%
	% CompareEnsemble methods (constructor):
	%  CompareEnsemble - constructor
	%
	% CompareEnsemble methods:
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
	% CompareEnsemble methods (display):
	%  tostring - string with information about the ensemble-based comparison
	%  disp - displays information about the ensemble-based comparison
	%  tree - displays the tree of the ensemble-based comparison
	%
	% CompareEnsemble methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ensemble-based comparison are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ensemble-based comparison
	%
	% CompareEnsemble methods (save/load, Static):
	%  save - saves BRAPH2 ensemble-based comparison as b2 file
	%  load - loads a BRAPH2 ensemble-based comparison from a b2 file
	%
	% CompareEnsemble method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ensemble-based comparison
	%
	% CompareEnsemble method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ensemble-based comparison
	%
	% CompareEnsemble methods (inspection, Static):
	%  getClass - returns the class of the ensemble-based comparison
	%  getSubclasses - returns all subclasses of CompareEnsemble
	%  getProps - returns the property list of the ensemble-based comparison
	%  getPropNumber - returns the property number of the ensemble-based comparison
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
	% CompareEnsemble methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% CompareEnsemble methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% CompareEnsemble methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% CompareEnsemble methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?CompareEnsemble; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">CompareEnsemble constants</a>.
	%
	%
	% See also AnalyzeEnsemble, ComparisonEnsemble.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		WAITBAR = 9; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
		
		VERBOSE = 10; %CET: Computational Efficiency Trick
		VERBOSE_TAG = 'VERBOSE';
		VERBOSE_CATEGORY = 9;
		VERBOSE_FORMAT = 4;
		
		INTERRUPTIBLE = 11; %CET: Computational Efficiency Trick
		INTERRUPTIBLE_TAG = 'INTERRUPTIBLE';
		INTERRUPTIBLE_CATEGORY = 9;
		INTERRUPTIBLE_FORMAT = 11;
		
		MEMORIZE = 12; %CET: Computational Efficiency Trick
		MEMORIZE_TAG = 'MEMORIZE';
		MEMORIZE_CATEGORY = 2;
		MEMORIZE_FORMAT = 4;
		
		P = 13; %CET: Computational Efficiency Trick
		P_TAG = 'P';
		P_CATEGORY = 3;
		P_FORMAT = 11;
		
		LONGITUDINAL = 14; %CET: Computational Efficiency Trick
		LONGITUDINAL_TAG = 'LONGITUDINAL';
		LONGITUDINAL_CATEGORY = 3;
		LONGITUDINAL_FORMAT = 4;
		
		A1 = 15; %CET: Computational Efficiency Trick
		A1_TAG = 'A1';
		A1_CATEGORY = 4;
		A1_FORMAT = 8;
		
		A2 = 16; %CET: Computational Efficiency Trick
		A2_TAG = 'A2';
		A2_CATEGORY = 4;
		A2_FORMAT = 8;
		
		PERM_SEEDS = 17; %CET: Computational Efficiency Trick
		PERM_SEEDS_TAG = 'PERM_SEEDS';
		PERM_SEEDS_CATEGORY = 5;
		PERM_SEEDS_FORMAT = 12;
		
		A1_PERM_DICT = 18; %CET: Computational Efficiency Trick
		A1_PERM_DICT_TAG = 'A1_PERM_DICT';
		A1_PERM_DICT_CATEGORY = 5;
		A1_PERM_DICT_FORMAT = 10;
		
		A2_PERM_DICT = 19; %CET: Computational Efficiency Trick
		A2_PERM_DICT_TAG = 'A2_PERM_DICT';
		A2_PERM_DICT_CATEGORY = 5;
		A2_PERM_DICT_FORMAT = 10;
		
		CP_DICT = 20; %CET: Computational Efficiency Trick
		CP_DICT_TAG = 'CP_DICT';
		CP_DICT_CATEGORY = 5;
		CP_DICT_FORMAT = 10;
		
		COMPARISON = 21; %CET: Computational Efficiency Trick
		COMPARISON_TAG = 'COMPARISON';
		COMPARISON_CATEGORY = 6;
		COMPARISON_FORMAT = 8;
		
		PERM = 22; %CET: Computational Efficiency Trick
		PERM_TAG = 'PERM';
		PERM_CATEGORY = 6;
		PERM_FORMAT = 9;
	end
	methods % constructor
		function c = CompareEnsemble(varargin)
			%CompareEnsemble() creates a ensemble-based comparison.
			%
			% CompareEnsemble(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% CompareEnsemble(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of CompareEnsemble properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % % .
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the comparison between two ensemble-based analyses.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the comparison between two ensemble-based analyses.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the comparison between two ensemble-based analyses.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the comparison between two ensemble-based analyses.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the comparison between two ensemble-based analyses.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the comparison between two ensemble-based analyses.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) sets whether to write the progress of the comparisons.
			%  <strong>11</strong> <strong>INTERRUPTIBLE</strong> 	INTERRUPTIBLE (gui, scalar) sets whether the comparison computation is interruptible for multitasking.
			%  <strong>12</strong> <strong>MEMORIZE</strong> 	MEMORIZE (metadata, logical) sets whether to memorize the permuted analyses.
			%  <strong>13</strong> <strong>P</strong> 	P (parameter, scalar) is the permutation number.
			%  <strong>14</strong> <strong>LONGITUDINAL</strong> 	LONGITUDINAL (parameter, logical) determines whether the comparison is longitudinal.
			%  <strong>15</strong> <strong>A1</strong> 	A1 (data, item) is the first analysis to compare.
			%  <strong>16</strong> <strong>A2</strong> 	A2 (data, item) is the second analysis to compare.
			%  <strong>17</strong> <strong>PERM_SEEDS</strong> 	PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
			%  <strong>18</strong> <strong>A1_PERM_DICT</strong> 	A1_PERM_DICT (result, idict) is the list of permuted analyses for the first analysis.
			%  <strong>19</strong> <strong>A2_PERM_DICT</strong> 	A2_PERM_DICT (result, idict) is the list of permuted analyses for the second analysis.
			%  <strong>20</strong> <strong>CP_DICT</strong> 	CP_DICT (result, idict) contains the results of the comparison.
			%  <strong>21</strong> <strong>COMPARISON</strong> 	COMPARISON (query, item) returns a comparison.
			%  <strong>22</strong> <strong>PERM</strong> 	PERM (query, itemlist) returns the permuted analyses.
			%
			% See also Category, Format.
			
			c = c@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the ensemble-based comparison.
			%
			% BUILD = CompareEnsemble.GETBUILD() returns the build of 'CompareEnsemble'.
			%
			% Alternative forms to call this method are:
			%  BUILD = C.GETBUILD() returns the build of the ensemble-based comparison C.
			%  BUILD = Element.GETBUILD(C) returns the build of 'C'.
			%  BUILD = Element.GETBUILD('CompareEnsemble') returns the build of 'CompareEnsemble'.
			%
			% Note that the Element.GETBUILD(C) and Element.GETBUILD('CompareEnsemble')
			%  are less computationally efficient.
			
			build = 1;
		end
		function c_class = getClass()
			%GETCLASS returns the class of the ensemble-based comparison.
			%
			% CLASS = CompareEnsemble.GETCLASS() returns the class 'CompareEnsemble'.
			%
			% Alternative forms to call this method are:
			%  CLASS = C.GETCLASS() returns the class of the ensemble-based comparison C.
			%  CLASS = Element.GETCLASS(C) returns the class of 'C'.
			%  CLASS = Element.GETCLASS('CompareEnsemble') returns 'CompareEnsemble'.
			%
			% Note that the Element.GETCLASS(C) and Element.GETCLASS('CompareEnsemble')
			%  are less computationally efficient.
			
			c_class = 'CompareEnsemble';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ensemble-based comparison.
			%
			% LIST = CompareEnsemble.GETSUBCLASSES() returns all subclasses of 'CompareEnsemble'.
			%
			% Alternative forms to call this method are:
			%  LIST = C.GETSUBCLASSES() returns all subclasses of the ensemble-based comparison C.
			%  LIST = Element.GETSUBCLASSES(C) returns all subclasses of 'C'.
			%  LIST = Element.GETSUBCLASSES('CompareEnsemble') returns all subclasses of 'CompareEnsemble'.
			%
			% Note that the Element.GETSUBCLASSES(C) and Element.GETSUBCLASSES('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'CompareEnsemble' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ensemble-based comparison.
			%
			% PROPS = CompareEnsemble.GETPROPS() returns the property list of ensemble-based comparison
			%  as a row vector.
			%
			% PROPS = CompareEnsemble.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = C.GETPROPS([CATEGORY]) returns the property list of the ensemble-based comparison C.
			%  PROPS = Element.GETPROPS(C[, CATEGORY]) returns the property list of 'C'.
			%  PROPS = Element.GETPROPS('CompareEnsemble'[, CATEGORY]) returns the property list of 'CompareEnsemble'.
			%
			% Note that the Element.GETPROPS(C) and Element.GETPROPS('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 12];
				case 3 % Category.PARAMETER
					prop_list = [4 13 14];
				case 4 % Category.DATA
					prop_list = [5 15 16];
				case 5 % Category.RESULT
					prop_list = [17 18 19 20];
				case 6 % Category.QUERY
					prop_list = [8 21 22];
				case 9 % Category.GUI
					prop_list = [9 10 11];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of ensemble-based comparison.
			%
			% N = CompareEnsemble.GETPROPNUMBER() returns the property number of ensemble-based comparison.
			%
			% N = CompareEnsemble.GETPROPNUMBER(CATEGORY) returns the property number of ensemble-based comparison
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = C.GETPROPNUMBER([CATEGORY]) returns the property number of the ensemble-based comparison C.
			%  N = Element.GETPROPNUMBER(C) returns the property number of 'C'.
			%  N = Element.GETPROPNUMBER('CompareEnsemble') returns the property number of 'CompareEnsemble'.
			%
			% Note that the Element.GETPROPNUMBER(C) and Element.GETPROPNUMBER('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 22;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 3;
				case 4 % Category.DATA
					prop_number = 3;
				case 5 % Category.RESULT
					prop_number = 4;
				case 6 % Category.QUERY
					prop_number = 3;
				case 9 % Category.GUI
					prop_number = 3;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in ensemble-based comparison/error.
			%
			% CHECK = CompareEnsemble.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = C.EXISTSPROP(PROP) checks whether PROP exists for C.
			%  CHECK = Element.EXISTSPROP(C, PROP) checks whether PROP exists for C.
			%  CHECK = Element.EXISTSPROP(CompareEnsemble, PROP) checks whether PROP exists for CompareEnsemble.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  C.EXISTSPROP(PROP) throws error if PROP does NOT exist for C.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%  Element.EXISTSPROP(C, PROP) throws error if PROP does NOT exist for C.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%  Element.EXISTSPROP(CompareEnsemble, PROP) throws error if PROP does NOT exist for CompareEnsemble.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%
			% Note that the Element.EXISTSPROP(C) and Element.EXISTSPROP('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 22 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CompareEnsemble:' 'WrongInput'], ...
					['BRAPH2' ':CompareEnsemble:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for CompareEnsemble.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ensemble-based comparison/error.
			%
			% CHECK = CompareEnsemble.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = C.EXISTSTAG(TAG) checks whether TAG exists for C.
			%  CHECK = Element.EXISTSTAG(C, TAG) checks whether TAG exists for C.
			%  CHECK = Element.EXISTSTAG(CompareEnsemble, TAG) checks whether TAG exists for CompareEnsemble.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  C.EXISTSTAG(TAG) throws error if TAG does NOT exist for C.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%  Element.EXISTSTAG(C, TAG) throws error if TAG does NOT exist for C.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%  Element.EXISTSTAG(CompareEnsemble, TAG) throws error if TAG does NOT exist for CompareEnsemble.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%
			% Note that the Element.EXISTSTAG(C) and Element.EXISTSTAG('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'VERBOSE'  'INTERRUPTIBLE'  'MEMORIZE'  'P'  'LONGITUDINAL'  'A1'  'A2'  'PERM_SEEDS'  'A1_PERM_DICT'  'A2_PERM_DICT'  'CP_DICT'  'COMPARISON'  'PERM' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CompareEnsemble:' 'WrongInput'], ...
					['BRAPH2' ':CompareEnsemble:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for CompareEnsemble.'] ...
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
			%  PROPERTY = C.GETPROPPROP(POINTER) returns property number of POINTER of C.
			%  PROPERTY = Element.GETPROPPROP(CompareEnsemble, POINTER) returns property number of POINTER of CompareEnsemble.
			%  PROPERTY = C.GETPROPPROP(CompareEnsemble, POINTER) returns property number of POINTER of CompareEnsemble.
			%
			% Note that the Element.GETPROPPROP(C) and Element.GETPROPPROP('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'VERBOSE'  'INTERRUPTIBLE'  'MEMORIZE'  'P'  'LONGITUDINAL'  'A1'  'A2'  'PERM_SEEDS'  'A1_PERM_DICT'  'A2_PERM_DICT'  'CP_DICT'  'COMPARISON'  'PERM' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = C.GETPROPTAG(POINTER) returns tag of POINTER of C.
			%  TAG = Element.GETPROPTAG(CompareEnsemble, POINTER) returns tag of POINTER of CompareEnsemble.
			%  TAG = C.GETPROPTAG(CompareEnsemble, POINTER) returns tag of POINTER of CompareEnsemble.
			%
			% Note that the Element.GETPROPTAG(C) and Element.GETPROPTAG('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				compareensemble_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'VERBOSE'  'INTERRUPTIBLE'  'MEMORIZE'  'P'  'LONGITUDINAL'  'A1'  'A2'  'PERM_SEEDS'  'A1_PERM_DICT'  'A2_PERM_DICT'  'CP_DICT'  'COMPARISON'  'PERM' };
				tag = compareensemble_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = C.GETPROPCATEGORY(POINTER) returns category of POINTER of C.
			%  CATEGORY = Element.GETPROPCATEGORY(CompareEnsemble, POINTER) returns category of POINTER of CompareEnsemble.
			%  CATEGORY = C.GETPROPCATEGORY(CompareEnsemble, POINTER) returns category of POINTER of CompareEnsemble.
			%
			% Note that the Element.GETPROPCATEGORY(C) and Element.GETPROPCATEGORY('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			compareensemble_category_list = { 1  1  1  3  4  2  2  6  9  9  9  2  3  3  4  4  5  5  5  5  6  6 };
			prop_category = compareensemble_category_list{prop};
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
			%  FORMAT = C.GETPROPFORMAT(POINTER) returns format of POINTER of C.
			%  FORMAT = Element.GETPROPFORMAT(CompareEnsemble, POINTER) returns format of POINTER of CompareEnsemble.
			%  FORMAT = C.GETPROPFORMAT(CompareEnsemble, POINTER) returns format of POINTER of CompareEnsemble.
			%
			% Note that the Element.GETPROPFORMAT(C) and Element.GETPROPFORMAT('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			compareensemble_format_list = { 2  2  2  8  2  2  2  2  4  4  11  4  11  4  8  8  12  10  10  10  8  9 };
			prop_format = compareensemble_format_list{prop};
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
			%  DESCRIPTION = C.GETPROPDESCRIPTION(POINTER) returns description of POINTER of C.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CompareEnsemble, POINTER) returns description of POINTER of CompareEnsemble.
			%  DESCRIPTION = C.GETPROPDESCRIPTION(CompareEnsemble, POINTER) returns description of POINTER of CompareEnsemble.
			%
			% Note that the Element.GETPROPDESCRIPTION(C) and Element.GETPROPDESCRIPTION('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			compareensemble_description_list = { 'ELCLASS (constant, string) is the class of the % % % .'  'NAME (constant, string) is the name of the comparison between two ensemble-based analyses.'  'DESCRIPTION (constant, string) is the description of the comparison between two ensemble-based analyses.'  'TEMPLATE (parameter, item) is the template of the comparison between two ensemble-based analyses.'  'ID (data, string) is a few-letter code for the comparison between two ensemble-based analyses.'  'LABEL (metadata, string) is an extended label of the comparison between two ensemble-based analyses.'  'NOTES (metadata, string) are some specific notes about the comparison between two ensemble-based analyses.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'VERBOSE (gui, logical) sets whether to write the progress of the comparisons.'  'INTERRUPTIBLE (gui, scalar) sets whether the comparison computation is interruptible for multitasking.'  'MEMORIZE (metadata, logical) sets whether to memorize the permuted analyses.'  'P (parameter, scalar) is the permutation number.'  'LONGITUDINAL (parameter, logical) determines whether the comparison is longitudinal.'  'A1 (data, item) is the first analysis to compare.'  'A2 (data, item) is the second analysis to compare.'  'PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.'  'A1_PERM_DICT (result, idict) is the list of permuted analyses for the first analysis.'  'A2_PERM_DICT (result, idict) is the list of permuted analyses for the second analysis.'  'CP_DICT (result, idict) contains the results of the comparison.'  'COMPARISON (query, item) returns a comparison.'  'PERM (query, itemlist) returns the permuted analyses.' };
			prop_description = compareensemble_description_list{prop};
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
			%  SETTINGS = C.GETPROPSETTINGS(POINTER) returns settings of POINTER of C.
			%  SETTINGS = Element.GETPROPSETTINGS(CompareEnsemble, POINTER) returns settings of POINTER of CompareEnsemble.
			%  SETTINGS = C.GETPROPSETTINGS(CompareEnsemble, POINTER) returns settings of POINTER of CompareEnsemble.
			%
			% Note that the Element.GETPROPSETTINGS(C) and Element.GETPROPSETTINGS('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % CompareEnsemble.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 10 % CompareEnsemble.VERBOSE
					prop_settings = Format.getFormatSettings(4);
				case 11 % CompareEnsemble.INTERRUPTIBLE
					prop_settings = Format.getFormatSettings(11);
				case 12 % CompareEnsemble.MEMORIZE
					prop_settings = Format.getFormatSettings(4);
				case 13 % CompareEnsemble.P
					prop_settings = Format.getFormatSettings(11);
				case 14 % CompareEnsemble.LONGITUDINAL
					prop_settings = Format.getFormatSettings(4);
				case 15 % CompareEnsemble.A1
					prop_settings = 'AnalyzeEnsemble';
				case 16 % CompareEnsemble.A2
					prop_settings = 'AnalyzeEnsemble';
				case 17 % CompareEnsemble.PERM_SEEDS
					prop_settings = Format.getFormatSettings(12);
				case 18 % CompareEnsemble.A1_PERM_DICT
					prop_settings = 'AnalyzeEnsemble';
				case 19 % CompareEnsemble.A2_PERM_DICT
					prop_settings = 'AnalyzeEnsemble';
				case 20 % CompareEnsemble.CP_DICT
					prop_settings = 'ComparisonEnsemble';
				case 21 % CompareEnsemble.COMPARISON
					prop_settings = 'ComparisonEnsemble';
				case 22 % CompareEnsemble.PERM
					prop_settings = Format.getFormatSettings(9);
				case 4 % CompareEnsemble.TEMPLATE
					prop_settings = 'CompareEnsemble';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = CompareEnsemble.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = CompareEnsemble.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = C.GETPROPDEFAULT(POINTER) returns the default value of POINTER of C.
			%  DEFAULT = Element.GETPROPDEFAULT(CompareEnsemble, POINTER) returns the default value of POINTER of CompareEnsemble.
			%  DEFAULT = C.GETPROPDEFAULT(CompareEnsemble, POINTER) returns the default value of POINTER of CompareEnsemble.
			%
			% Note that the Element.GETPROPDEFAULT(C) and Element.GETPROPDEFAULT('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % CompareEnsemble.WAITBAR
					prop_default = true;
				case 10 % CompareEnsemble.VERBOSE
					prop_default = false;
				case 11 % CompareEnsemble.INTERRUPTIBLE
					prop_default = .001;
				case 12 % CompareEnsemble.MEMORIZE
					prop_default = Format.getFormatDefault(4, CompareEnsemble.getPropSettings(prop));
				case 13 % CompareEnsemble.P
					prop_default = 1e+4;
				case 14 % CompareEnsemble.LONGITUDINAL
					prop_default = Format.getFormatDefault(4, CompareEnsemble.getPropSettings(prop));
				case 15 % CompareEnsemble.A1
					prop_default = Format.getFormatDefault(8, CompareEnsemble.getPropSettings(prop));
				case 16 % CompareEnsemble.A2
					prop_default = Format.getFormatDefault(8, CompareEnsemble.getPropSettings(prop));
				case 17 % CompareEnsemble.PERM_SEEDS
					prop_default = Format.getFormatDefault(12, CompareEnsemble.getPropSettings(prop));
				case 18 % CompareEnsemble.A1_PERM_DICT
					prop_default = Format.getFormatDefault(10, CompareEnsemble.getPropSettings(prop));
				case 19 % CompareEnsemble.A2_PERM_DICT
					prop_default = Format.getFormatDefault(10, CompareEnsemble.getPropSettings(prop));
				case 20 % CompareEnsemble.CP_DICT
					prop_default = Format.getFormatDefault(10, CompareEnsemble.getPropSettings(prop));
				case 21 % CompareEnsemble.COMPARISON
					prop_default = Format.getFormatDefault(8, CompareEnsemble.getPropSettings(prop));
				case 22 % CompareEnsemble.PERM
					prop_default = Format.getFormatDefault(9, CompareEnsemble.getPropSettings(prop));
				case 1 % CompareEnsemble.ELCLASS
					prop_default = 'CompareEnsemble';
				case 2 % CompareEnsemble.NAME
					prop_default = 'CompareEnsemble';
				case 3 % CompareEnsemble.DESCRIPTION
					prop_default = 'CompareEnsemble compares two ensemble-based analyses, which need to be of the same class.';
				case 4 % CompareEnsemble.TEMPLATE
					prop_default = Format.getFormatDefault(8, CompareEnsemble.getPropSettings(prop));
				case 5 % CompareEnsemble.ID
					prop_default = 'CompareEnsemble ID';
				case 6 % CompareEnsemble.LABEL
					prop_default = 'CompareEnsemble label';
				case 7 % CompareEnsemble.NOTES
					prop_default = 'CompareEnsemble notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = CompareEnsemble.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = CompareEnsemble.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = C.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of C.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(CompareEnsemble, POINTER) returns the conditioned default value of POINTER of CompareEnsemble.
			%  DEFAULT = C.GETPROPDEFAULTCONDITIONED(CompareEnsemble, POINTER) returns the conditioned default value of POINTER of CompareEnsemble.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(C) and Element.GETPROPDEFAULTCONDITIONED('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			prop_default = CompareEnsemble.conditioning(prop, CompareEnsemble.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = C.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = C.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of C.
			%  CHECK = Element.CHECKPROP(CompareEnsemble, PROP, VALUE) checks VALUE format for PROP of CompareEnsemble.
			%  CHECK = C.CHECKPROP(CompareEnsemble, PROP, VALUE) checks VALUE format for PROP of CompareEnsemble.
			% 
			% C.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:CompareEnsemble:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  C.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of C.
			%   Error id: BRAPH2:CompareEnsemble:WrongInput
			%  Element.CHECKPROP(CompareEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CompareEnsemble.
			%   Error id: BRAPH2:CompareEnsemble:WrongInput
			%  C.CHECKPROP(CompareEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CompareEnsemble.
			%   Error id: BRAPH2:CompareEnsemble:WrongInput]
			% 
			% Note that the Element.CHECKPROP(C) and Element.CHECKPROP('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			switch prop
				case 9 % CompareEnsemble.WAITBAR
					check = Format.checkFormat(4, value, CompareEnsemble.getPropSettings(prop));
				case 10 % CompareEnsemble.VERBOSE
					check = Format.checkFormat(4, value, CompareEnsemble.getPropSettings(prop));
				case 11 % CompareEnsemble.INTERRUPTIBLE
					check = Format.checkFormat(11, value, CompareEnsemble.getPropSettings(prop));
				case 12 % CompareEnsemble.MEMORIZE
					check = Format.checkFormat(4, value, CompareEnsemble.getPropSettings(prop));
				case 13 % CompareEnsemble.P
					check = Format.checkFormat(11, value, CompareEnsemble.getPropSettings(prop));
					if check
						check = value > 0 && value == round(value);
					end
				case 14 % CompareEnsemble.LONGITUDINAL
					check = Format.checkFormat(4, value, CompareEnsemble.getPropSettings(prop));
				case 15 % CompareEnsemble.A1
					check = Format.checkFormat(8, value, CompareEnsemble.getPropSettings(prop));
				case 16 % CompareEnsemble.A2
					check = Format.checkFormat(8, value, CompareEnsemble.getPropSettings(prop));
				case 17 % CompareEnsemble.PERM_SEEDS
					check = Format.checkFormat(12, value, CompareEnsemble.getPropSettings(prop));
				case 18 % CompareEnsemble.A1_PERM_DICT
					check = Format.checkFormat(10, value, CompareEnsemble.getPropSettings(prop));
				case 19 % CompareEnsemble.A2_PERM_DICT
					check = Format.checkFormat(10, value, CompareEnsemble.getPropSettings(prop));
				case 20 % CompareEnsemble.CP_DICT
					check = Format.checkFormat(10, value, CompareEnsemble.getPropSettings(prop));
				case 21 % CompareEnsemble.COMPARISON
					check = Format.checkFormat(8, value, CompareEnsemble.getPropSettings(prop));
				case 22 % CompareEnsemble.PERM
					check = Format.checkFormat(9, value, CompareEnsemble.getPropSettings(prop));
				case 4 % CompareEnsemble.TEMPLATE
					check = Format.checkFormat(8, value, CompareEnsemble.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CompareEnsemble:' 'WrongInput'], ...
					['BRAPH2' ':CompareEnsemble:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' CompareEnsemble.getPropTag(prop) ' (' CompareEnsemble.getFormatTag(CompareEnsemble.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(c, prop, varargin)
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
				case 17 % CompareEnsemble.PERM_SEEDS
					rng_settings_ = rng(); rng(c.getPropSeed(17), 'twister')
					
					value = randi(intmax('uint32'), 1, c.get('P'));
					
					rng(rng_settings_)
					
				case 18 % CompareEnsemble.A1_PERM_DICT
					rng_settings_ = rng(); rng(c.getPropSeed(18), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'AnalyzeEnsemble', 'IT_KEY', 1);
					
					rng(rng_settings_)
					
				case 19 % CompareEnsemble.A2_PERM_DICT
					rng_settings_ = rng(); rng(c.getPropSeed(19), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'AnalyzeEnsemble', 'IT_KEY', 1);
					
					rng(rng_settings_)
					
				case 20 % CompareEnsemble.CP_DICT
					rng_settings_ = rng(); rng(c.getPropSeed(20), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'ComparisonEnsemble', 'IT_KEY', 9);
					
					rng(rng_settings_)
					
				case 21 % CompareEnsemble.COMPARISON
					% CP = c.get('COMPARISON', MEASURE_CLASS) checks if the comparison exists 
					%  in the comparison dictionary CP_DICT. If not, it creates a new comparison
					%  CP of class MEASURE_CLASS. The user must call getValue() for the new
					%  comparison CP to retrieve the value of the comparison. 
					if isempty(varargin)
					    value = ComparisonEnsemble();
					    
					    % % Warning commented because it most likely will lead to an error anyways
					    % warning( ...
					    %     ['BRAPH2' ':' class(g)], ...
					    %     ['BRAPH2' ':' class(g) '\n' ...
					    %     'Missing argument MEASURE_CLASS when using CompareGroup.get(''COMPARISON'', MEASURE_CLASS).'] ...
					    %     )
					    
					    return
					end
					measure_class = varargin{1};
					
					g = c.get('A1').get('GRAPH_TEMPLATE');
					m_list = g.get('COMPATIBLE_MEASURES');
					assert( ...
					    contains(measure_class, m_list), ...
					    ['BRAPH2' ':CompareEnsemble:' 'WrongInput'], ...
					    ['BRAPH2' ':CompareEnsemble:' 'WrongInput' ' \n' ...
						 c.get('A1').getClass() ' utilizes graphs of type ' g.getClass() '. \n' ...
					     measure_class ' is not a compatible Measure with ' g.getClass() '. \n' ...
					    'Use ' g.getClass() '().get(''COMPATIBLE_MEASURES'') for a list of compatible measures.']);
					
					
					cp_dict = c.memorize('CP_DICT');
					if cp_dict.get('CONTAINS_KEY', measure_class)
						cp = cp_dict.get('IT', measure_class);
					else
					    cp = ComparisonEnsemble( ...
					        'ID', [measure_class ' comparison ' c.get('A1').get('ID') ' vs. ' c.get('A2').get('ID')], ...
					        'MEASURE', measure_class, ...
					        'C', c ...
					        );
						cp_dict.get('ADD', cp);
					end
					
					value = cp;
					
				case 22 % CompareEnsemble.PERM
					% {A1P, A2P} = c.get('PERM', I) retunrs the I-th permutations for the analysis
					%  A1P and A2P. The number of perutations must be smaller than the
					%  permutation number P, which is one of the properties of the comparison.
					%
					% {A1P, A2P} = c.get(C, I, true) memorizes the resulting permutations.
					i = 1;
					if length(varargin) >= 1
					    i = varargin{1};
					end 
					memorize = false;
					if length(varargin) >= 2
					    memorize = varargin{2};
					end
					
					a1 = c.get('A1');
					key1 = [a1.get('ID') ' permutation ' int2str(i)];
					
					a2 = c.get('A2');
					key2 = [a2.get('ID') ' permutation ' int2str(i)];
					
					a1_perm_dict = c.memorize('A1_PERM_DICT');
					a2_perm_dict = c.memorize('A2_PERM_DICT');
					if a1_perm_dict.get('CONTAINS_KEY', key1) && a2_perm_dict.get('CONTAINS_KEY', key2)
						% retrieves if already memorized
					    a1_perm = a1_perm_dict.get('IT', key1);
					    a2_perm = a2_perm_dict.get('IT', key2);
					else    
					    % permutation
					    seeds = c.get('PERM_SEEDS');
					    rng(seeds(i), 'twister')
					
					    subs1 = a1.get('GR').get('SUB_DICT').get('IT_LIST');
					    subs2 = a2.get('GR').get('SUB_DICT').get('IT_LIST');
					
					    gdict1 = a1.get('G_DICT').get('IT_LIST');
					    gdict2 = a2.get('G_DICT').get('IT_LIST');
					
					    subs1_gdict1 = cellfun(@(x, y) {x, y}, subs1, gdict1, 'UniformOutput', false);
					    subs2_gdict2 = cellfun(@(x, y) {x, y}, subs2, gdict2, 'UniformOutput', false);
					
					    [subs1_gdict1_perm, subs2_gdict2_perm] = permutation(subs1_gdict1, subs2_gdict2, c.get('LONGITUDINAL'));
					
					    gr1 = a1.get('GR');
					    a1_perm = eval([a1.getClass() '(''TEMPLATE'', a1)']); % % % a1_perm = c.get('A1').clone();
					    a1_perm.set( ...
					        'ID', key1, ...
					        'GR', Group('TEMPLATE', gr1) ... % % % c.get('A1').get('GR').clone() ...
					        )
					    a1_perm.get('GR').set('SUB_DICT', IndexedDictionary('TEMPLATE', gr1.get('SUB_DICT'))) % % % a1_perm.get('GR').set('SUB_DICT', c.get('A1').get('GR').get('SUB_DICT').clone())
						a1_perm.get('GR').get('SUB_DICT').set('IT_LIST', cellfun(@(x) x(1), subs1_gdict1_perm))
					    a1_perm.memorize('G_DICT').set('IT_LIST', cellfun(@(x) x(2), subs1_gdict1_perm))
					
					    gr2 = a2.get('GR');
					    a2_perm = eval([a2.getClass() '(''TEMPLATE'', a2)']); % % % a2_perm = c.get('A1').clone(); % a2_perm = c.get('A2').clone();
					    a2_perm.set( ...
					        'ID', key2, ...
					        'GR', Group('TEMPLATE', gr2) ... % % % c.get('A2').get('GR').clone() ...
					        )
					    a2_perm.get('GR').set('SUB_DICT', IndexedDictionary('TEMPLATE', gr2.get('SUB_DICT'))) % % % a2_perm.get('GR').set('SUB_DICT', c.get('A2').get('GR').get('SUB_DICT').clone())
						a2_perm.get('GR').get('SUB_DICT').set('IT_LIST', cellfun(@(x) x(1), subs2_gdict2_perm))
						a2_perm.memorize('G_DICT').set('IT_LIST', cellfun(@(x) x(2), subs2_gdict2_perm))
					         
					    % memorize permutations if required
					    if memorize
					        a1_perm_dict.get('ADD', a1_perm)
					        a2_perm_dict.get('ADD', a2_perm)
					    end
					end
					
					value = {a1_perm, a2_perm};
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(c, prop, varargin{:});
					else
						value = calculateValue@Element(c, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(c, prop, value)
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
			msg = ['Error while checking ' tostring(c) ' ' c.getPropTag(prop) '.'];
			
			switch prop
				case 15 % CompareEnsemble.A1
					check = isa(value, c.get('A2').getClass());
					
				case 16 % CompareEnsemble.A2
					check = isa(value, c.get('A1').getClass());
					
				otherwise
					if prop <= 8
						[check, msg] = checkValue@ConcreteElement(c, prop, value);
					end
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(c, prop, varargin)
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
				case 20 % CompareEnsemble.CP_DICT
					pr = CompareEnsemblePP_CpDict('EL', c, 'PROP', 20, ...
					    'WAITBAR', c.getCallback('WAITBAR'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(c, prop, varargin{:});
					
			end
		end
	end
end
