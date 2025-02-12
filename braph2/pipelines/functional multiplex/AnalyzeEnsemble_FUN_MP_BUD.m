classdef AnalyzeEnsemble_FUN_MP_BUD < AnalyzeEnsemble
	%AnalyzeEnsemble_FUN_MP_BUD is an ensemble-based graph analysis using functional multiplex data of fixed density.
	% It is a subclass of <a href="matlab:help AnalyzeEnsemble">AnalyzeEnsemble</a>.
	%
	% This graph analysis (AnalyzeEnsemble_FUN_MP_BUD) analyzes functional multiplex data 
	% using binary undirected multigraphs with fixed densities.
	%
	% The list of AnalyzeEnsemble_FUN_MP_BUD properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the ensemble-based graph analysis with functional multiplex data of fixed threshold.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ensemble-based graph analysis with functional multiplex data of fixed density.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with functional multiplex data of fixed density.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with functional multiplex data of fixed density.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ensemble-based graph analysis with functional multiplex data of fixed density.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with functional multiplex data of fixed density.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with functional multiplex data of fixed density.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>GR</strong> 	GR (data, item) is the subject group, which also defines the subject class SubjectFUN_MP.
	%  <strong>11</strong> <strong>GRAPH_TEMPLATE</strong> 	GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
	%  <strong>12</strong> <strong>G_DICT</strong> 	G_DICT (result, idict) is the graph (MultiplexBUD) ensemble obtained from this analysis.
	%  <strong>13</strong> <strong>ME_DICT</strong> 	ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
	%  <strong>14</strong> <strong>MEASUREENSEMBLE</strong> 	MEASUREENSEMBLE (query, item) returns an ensemble-based measure.
	%  <strong>15</strong> <strong>REPETITION</strong> 	REPETITION (parameter, scalar) is the number of repetitions.
	%  <strong>16</strong> <strong>F_MIN</strong> 	F_MIN (parameter, scalar) is the minimum frequency value.
	%  <strong>17</strong> <strong>F_MAX</strong> 	F_MAX (parameter, scalar) is the maximum frequency value.
	%  <strong>18</strong> <strong>CORRELATION_RULE</strong> 	CORRELATION_RULE (parameter, option) is the correlation type.
	%  <strong>19</strong> <strong>NEGATIVE_WEIGHT_RULE</strong> 	NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
	%  <strong>20</strong> <strong>DENSITIES</strong> 	DENSITIES (parameter, rvector) is the vector of densities.
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods (constructor):
	%  AnalyzeEnsemble_FUN_MP_BUD - constructor
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods:
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
	% AnalyzeEnsemble_FUN_MP_BUD methods (display):
	%  tostring - string with information about the graph analysis with functional multiplex data of fixed density
	%  disp - displays information about the graph analysis with functional multiplex data of fixed density
	%  tree - displays the tree of the graph analysis with functional multiplex data of fixed density
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph analysis with functional multiplex data of fixed density are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph analysis with functional multiplex data of fixed density
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods (save/load, Static):
	%  save - saves BRAPH2 graph analysis with functional multiplex data of fixed density as b2 file
	%  load - loads a BRAPH2 graph analysis with functional multiplex data of fixed density from a b2 file
	%
	% AnalyzeEnsemble_FUN_MP_BUD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph analysis with functional multiplex data of fixed density
	%
	% AnalyzeEnsemble_FUN_MP_BUD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph analysis with functional multiplex data of fixed density
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods (inspection, Static):
	%  getClass - returns the class of the graph analysis with functional multiplex data of fixed density
	%  getSubclasses - returns all subclasses of AnalyzeEnsemble_FUN_MP_BUD
	%  getProps - returns the property list of the graph analysis with functional multiplex data of fixed density
	%  getPropNumber - returns the property number of the graph analysis with functional multiplex data of fixed density
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
	% AnalyzeEnsemble_FUN_MP_BUD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeEnsemble_FUN_MP_BUD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?AnalyzeEnsemble_FUN_MP_BUD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">AnalyzeEnsemble_FUN_MP_BUD constants</a>.
	%
	%
	% See also SubjectFUN_MP, MultiplexBUD.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		REPETITION = 15; %CET: Computational Efficiency Trick
		REPETITION_TAG = 'REPETITION';
		REPETITION_CATEGORY = 3;
		REPETITION_FORMAT = 11;
		
		F_MIN = 16; %CET: Computational Efficiency Trick
		F_MIN_TAG = 'F_MIN';
		F_MIN_CATEGORY = 3;
		F_MIN_FORMAT = 11;
		
		F_MAX = 17; %CET: Computational Efficiency Trick
		F_MAX_TAG = 'F_MAX';
		F_MAX_CATEGORY = 3;
		F_MAX_FORMAT = 11;
		
		CORRELATION_RULE = 18; %CET: Computational Efficiency Trick
		CORRELATION_RULE_TAG = 'CORRELATION_RULE';
		CORRELATION_RULE_CATEGORY = 3;
		CORRELATION_RULE_FORMAT = 5;
		
		NEGATIVE_WEIGHT_RULE = 19; %CET: Computational Efficiency Trick
		NEGATIVE_WEIGHT_RULE_TAG = 'NEGATIVE_WEIGHT_RULE';
		NEGATIVE_WEIGHT_RULE_CATEGORY = 3;
		NEGATIVE_WEIGHT_RULE_FORMAT = 5;
		
		DENSITIES = 20; %CET: Computational Efficiency Trick
		DENSITIES_TAG = 'DENSITIES';
		DENSITIES_CATEGORY = 3;
		DENSITIES_FORMAT = 12;
	end
	methods % constructor
		function a = AnalyzeEnsemble_FUN_MP_BUD(varargin)
			%AnalyzeEnsemble_FUN_MP_BUD() creates a graph analysis with functional multiplex data of fixed density.
			%
			% AnalyzeEnsemble_FUN_MP_BUD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeEnsemble_FUN_MP_BUD(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of AnalyzeEnsemble_FUN_MP_BUD properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the ensemble-based graph analysis with functional multiplex data of fixed threshold.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ensemble-based graph analysis with functional multiplex data of fixed density.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with functional multiplex data of fixed density.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with functional multiplex data of fixed density.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ensemble-based graph analysis with functional multiplex data of fixed density.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with functional multiplex data of fixed density.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with functional multiplex data of fixed density.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>GR</strong> 	GR (data, item) is the subject group, which also defines the subject class SubjectFUN_MP.
			%  <strong>11</strong> <strong>GRAPH_TEMPLATE</strong> 	GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
			%  <strong>12</strong> <strong>G_DICT</strong> 	G_DICT (result, idict) is the graph (MultiplexBUD) ensemble obtained from this analysis.
			%  <strong>13</strong> <strong>ME_DICT</strong> 	ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
			%  <strong>14</strong> <strong>MEASUREENSEMBLE</strong> 	MEASUREENSEMBLE (query, item) returns an ensemble-based measure.
			%  <strong>15</strong> <strong>REPETITION</strong> 	REPETITION (parameter, scalar) is the number of repetitions.
			%  <strong>16</strong> <strong>F_MIN</strong> 	F_MIN (parameter, scalar) is the minimum frequency value.
			%  <strong>17</strong> <strong>F_MAX</strong> 	F_MAX (parameter, scalar) is the maximum frequency value.
			%  <strong>18</strong> <strong>CORRELATION_RULE</strong> 	CORRELATION_RULE (parameter, option) is the correlation type.
			%  <strong>19</strong> <strong>NEGATIVE_WEIGHT_RULE</strong> 	NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
			%  <strong>20</strong> <strong>DENSITIES</strong> 	DENSITIES (parameter, rvector) is the vector of densities.
			%
			% See also Category, Format.
			
			a = a@AnalyzeEnsemble(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the graph analysis with functional multiplex data of fixed density.
			%
			% BUILD = AnalyzeEnsemble_FUN_MP_BUD.GETBUILD() returns the build of 'AnalyzeEnsemble_FUN_MP_BUD'.
			%
			% Alternative forms to call this method are:
			%  BUILD = A.GETBUILD() returns the build of the graph analysis with functional multiplex data of fixed density A.
			%  BUILD = Element.GETBUILD(A) returns the build of 'A'.
			%  BUILD = Element.GETBUILD('AnalyzeEnsemble_FUN_MP_BUD') returns the build of 'AnalyzeEnsemble_FUN_MP_BUD'.
			%
			% Note that the Element.GETBUILD(A) and Element.GETBUILD('AnalyzeEnsemble_FUN_MP_BUD')
			%  are less computationally efficient.
			
			build = 1;
		end
		function a_class = getClass()
			%GETCLASS returns the class of the graph analysis with functional multiplex data of fixed density.
			%
			% CLASS = AnalyzeEnsemble_FUN_MP_BUD.GETCLASS() returns the class 'AnalyzeEnsemble_FUN_MP_BUD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = A.GETCLASS() returns the class of the graph analysis with functional multiplex data of fixed density A.
			%  CLASS = Element.GETCLASS(A) returns the class of 'A'.
			%  CLASS = Element.GETCLASS('AnalyzeEnsemble_FUN_MP_BUD') returns 'AnalyzeEnsemble_FUN_MP_BUD'.
			%
			% Note that the Element.GETCLASS(A) and Element.GETCLASS('AnalyzeEnsemble_FUN_MP_BUD')
			%  are less computationally efficient.
			
			a_class = 'AnalyzeEnsemble_FUN_MP_BUD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph analysis with functional multiplex data of fixed density.
			%
			% LIST = AnalyzeEnsemble_FUN_MP_BUD.GETSUBCLASSES() returns all subclasses of 'AnalyzeEnsemble_FUN_MP_BUD'.
			%
			% Alternative forms to call this method are:
			%  LIST = A.GETSUBCLASSES() returns all subclasses of the graph analysis with functional multiplex data of fixed density A.
			%  LIST = Element.GETSUBCLASSES(A) returns all subclasses of 'A'.
			%  LIST = Element.GETSUBCLASSES('AnalyzeEnsemble_FUN_MP_BUD') returns all subclasses of 'AnalyzeEnsemble_FUN_MP_BUD'.
			%
			% Note that the Element.GETSUBCLASSES(A) and Element.GETSUBCLASSES('AnalyzeEnsemble_FUN_MP_BUD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'AnalyzeEnsemble_FUN_MP_BUD' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph analysis with functional multiplex data of fixed density.
			%
			% PROPS = AnalyzeEnsemble_FUN_MP_BUD.GETPROPS() returns the property list of graph analysis with functional multiplex data of fixed density
			%  as a row vector.
			%
			% PROPS = AnalyzeEnsemble_FUN_MP_BUD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = A.GETPROPS([CATEGORY]) returns the property list of the graph analysis with functional multiplex data of fixed density A.
			%  PROPS = Element.GETPROPS(A[, CATEGORY]) returns the property list of 'A'.
			%  PROPS = Element.GETPROPS('AnalyzeEnsemble_FUN_MP_BUD'[, CATEGORY]) returns the property list of 'AnalyzeEnsemble_FUN_MP_BUD'.
			%
			% Note that the Element.GETPROPS(A) and Element.GETPROPS('AnalyzeEnsemble_FUN_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 11 15 16 17 18 19 20];
				case 4 % Category.DATA
					prop_list = [5 10];
				case 5 % Category.RESULT
					prop_list = [12 13];
				case 6 % Category.QUERY
					prop_list = [8 14];
				case 9 % Category.GUI
					prop_list = 9;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph analysis with functional multiplex data of fixed density.
			%
			% N = AnalyzeEnsemble_FUN_MP_BUD.GETPROPNUMBER() returns the property number of graph analysis with functional multiplex data of fixed density.
			%
			% N = AnalyzeEnsemble_FUN_MP_BUD.GETPROPNUMBER(CATEGORY) returns the property number of graph analysis with functional multiplex data of fixed density
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = A.GETPROPNUMBER([CATEGORY]) returns the property number of the graph analysis with functional multiplex data of fixed density A.
			%  N = Element.GETPROPNUMBER(A) returns the property number of 'A'.
			%  N = Element.GETPROPNUMBER('AnalyzeEnsemble_FUN_MP_BUD') returns the property number of 'AnalyzeEnsemble_FUN_MP_BUD'.
			%
			% Note that the Element.GETPROPNUMBER(A) and Element.GETPROPNUMBER('AnalyzeEnsemble_FUN_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 20;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 8;
				case 4 % Category.DATA
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 2;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph analysis with functional multiplex data of fixed density/error.
			%
			% CHECK = AnalyzeEnsemble_FUN_MP_BUD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSPROP(PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(A, PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(AnalyzeEnsemble_FUN_MP_BUD, PROP) checks whether PROP exists for AnalyzeEnsemble_FUN_MP_BUD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSPROP(PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%  Element.EXISTSPROP(A, PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%  Element.EXISTSPROP(AnalyzeEnsemble_FUN_MP_BUD, PROP) throws error if PROP does NOT exist for AnalyzeEnsemble_FUN_MP_BUD.
			%   Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(A) and Element.EXISTSPROP('AnalyzeEnsemble_FUN_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 20 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeEnsemble_FUN_MP_BUD:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeEnsemble_FUN_MP_BUD:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeEnsemble_FUN_MP_BUD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph analysis with functional multiplex data of fixed density/error.
			%
			% CHECK = AnalyzeEnsemble_FUN_MP_BUD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSTAG(TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(A, TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(AnalyzeEnsemble_FUN_MP_BUD, TAG) checks whether TAG exists for AnalyzeEnsemble_FUN_MP_BUD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSTAG(TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%  Element.EXISTSTAG(A, TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%  Element.EXISTSTAG(AnalyzeEnsemble_FUN_MP_BUD, TAG) throws error if TAG does NOT exist for AnalyzeEnsemble_FUN_MP_BUD.
			%   Error id: [BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(A) and Element.EXISTSTAG('AnalyzeEnsemble_FUN_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'GRAPH_TEMPLATE'  'G_DICT'  'ME_DICT'  'MEASUREENSEMBLE'  'REPETITION'  'F_MIN'  'F_MAX'  'CORRELATION_RULE'  'NEGATIVE_WEIGHT_RULE'  'DENSITIES' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeEnsemble_FUN_MP_BUD:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeEnsemble_FUN_MP_BUD:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for AnalyzeEnsemble_FUN_MP_BUD.'] ...
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
			%  PROPERTY = A.GETPROPPROP(POINTER) returns property number of POINTER of A.
			%  PROPERTY = Element.GETPROPPROP(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns property number of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%  PROPERTY = A.GETPROPPROP(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns property number of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%
			% Note that the Element.GETPROPPROP(A) and Element.GETPROPPROP('AnalyzeEnsemble_FUN_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'GRAPH_TEMPLATE'  'G_DICT'  'ME_DICT'  'MEASUREENSEMBLE'  'REPETITION'  'F_MIN'  'F_MAX'  'CORRELATION_RULE'  'NEGATIVE_WEIGHT_RULE'  'DENSITIES' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = A.GETPROPTAG(POINTER) returns tag of POINTER of A.
			%  TAG = Element.GETPROPTAG(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns tag of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%  TAG = A.GETPROPTAG(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns tag of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%
			% Note that the Element.GETPROPTAG(A) and Element.GETPROPTAG('AnalyzeEnsemble_FUN_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				analyzeensemble_fun_mp_bud_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'GR'  'GRAPH_TEMPLATE'  'G_DICT'  'ME_DICT'  'MEASUREENSEMBLE'  'REPETITION'  'F_MIN'  'F_MAX'  'CORRELATION_RULE'  'NEGATIVE_WEIGHT_RULE'  'DENSITIES' };
				tag = analyzeensemble_fun_mp_bud_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = A.GETPROPCATEGORY(POINTER) returns category of POINTER of A.
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns category of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%  CATEGORY = A.GETPROPCATEGORY(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns category of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%
			% Note that the Element.GETPROPCATEGORY(A) and Element.GETPROPCATEGORY('AnalyzeEnsemble_FUN_MP_BUD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble_FUN_MP_BUD.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzeensemble_fun_mp_bud_category_list = { 1  1  1  3  4  2  2  6  9  4  3  5  5  6  3  3  3  3  3  3 };
			prop_category = analyzeensemble_fun_mp_bud_category_list{prop};
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
			%  FORMAT = A.GETPROPFORMAT(POINTER) returns format of POINTER of A.
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns format of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%  FORMAT = A.GETPROPFORMAT(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns format of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%
			% Note that the Element.GETPROPFORMAT(A) and Element.GETPROPFORMAT('AnalyzeEnsemble_FUN_MP_BUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble_FUN_MP_BUD.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzeensemble_fun_mp_bud_format_list = { 2  2  2  8  2  2  2  2  4  8  8  10  10  8  11  11  11  5  5  12 };
			prop_format = analyzeensemble_fun_mp_bud_format_list{prop};
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
			%  DESCRIPTION = A.GETPROPDESCRIPTION(POINTER) returns description of POINTER of A.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns description of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%  DESCRIPTION = A.GETPROPDESCRIPTION(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns description of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%
			% Note that the Element.GETPROPDESCRIPTION(A) and Element.GETPROPDESCRIPTION('AnalyzeEnsemble_FUN_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble_FUN_MP_BUD.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			analyzeensemble_fun_mp_bud_description_list = { 'ELCLASS (constant, string) is the class of the ensemble-based graph analysis with functional multiplex data of fixed threshold.'  'NAME (constant, string) is the name of the ensemble-based graph analysis with functional multiplex data of fixed density.'  'DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with functional multiplex data of fixed density.'  'TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with functional multiplex data of fixed density.'  'ID (data, string) is a few-letter code for the ensemble-based graph analysis with functional multiplex data of fixed density.'  'LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with functional multiplex data of fixed density.'  'NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with functional multiplex data of fixed density.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'GR (data, item) is the subject group, which also defines the subject class SubjectFUN_MP.'  'GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.'  'G_DICT (result, idict) is the graph (MultiplexBUD) ensemble obtained from this analysis.'  'ME_DICT (result, idict) contains the calculated measures of the graph ensemble.'  'MEASUREENSEMBLE (query, item) returns an ensemble-based measure.'  'REPETITION (parameter, scalar) is the number of repetitions.'  'F_MIN (parameter, scalar) is the minimum frequency value.'  'F_MAX (parameter, scalar) is the maximum frequency value.'  'CORRELATION_RULE (parameter, option) is the correlation type.'  'NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.'  'DENSITIES (parameter, rvector) is the vector of densities.' };
			prop_description = analyzeensemble_fun_mp_bud_description_list{prop};
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
			%  SETTINGS = A.GETPROPSETTINGS(POINTER) returns settings of POINTER of A.
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns settings of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%  SETTINGS = A.GETPROPSETTINGS(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns settings of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%
			% Note that the Element.GETPROPSETTINGS(A) and Element.GETPROPSETTINGS('AnalyzeEnsemble_FUN_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemble_FUN_MP_BUD.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % AnalyzeEnsemble_FUN_MP_BUD.REPETITION
					prop_settings = Format.getFormatSettings(11);
				case 16 % AnalyzeEnsemble_FUN_MP_BUD.F_MIN
					prop_settings = Format.getFormatSettings(11);
				case 17 % AnalyzeEnsemble_FUN_MP_BUD.F_MAX
					prop_settings = Format.getFormatSettings(11);
				case 18 % AnalyzeEnsemble_FUN_MP_BUD.CORRELATION_RULE
					prop_settings = Correlation.CORRELATION_RULE_LIST(1:3);
				case 19 % AnalyzeEnsemble_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE
					prop_settings = Correlation.NEGATIVE_WEIGHT_RULE_LIST;
				case 20 % AnalyzeEnsemble_FUN_MP_BUD.DENSITIES
					prop_settings = Format.getFormatSettings(12);
				case 4 % AnalyzeEnsemble_FUN_MP_BUD.TEMPLATE
					prop_settings = 'AnalyzeEnsemble_FUN_MP_BUD';
				case 11 % AnalyzeEnsemble_FUN_MP_BUD.GRAPH_TEMPLATE
					prop_settings = 'MultiplexBUD';
				case 12 % AnalyzeEnsemble_FUN_MP_BUD.G_DICT
					prop_settings = 'MultiplexBUD';
				otherwise
					prop_settings = getPropSettings@AnalyzeEnsemble(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeEnsemble_FUN_MP_BUD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemble_FUN_MP_BUD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULT(POINTER) returns the default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns the default value of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%  DEFAULT = A.GETPROPDEFAULT(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns the default value of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%
			% Note that the Element.GETPROPDEFAULT(A) and Element.GETPROPDEFAULT('AnalyzeEnsemble_FUN_MP_BUD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeEnsemble_FUN_MP_BUD.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 15 % AnalyzeEnsemble_FUN_MP_BUD.REPETITION
					prop_default = 1;
				case 16 % AnalyzeEnsemble_FUN_MP_BUD.F_MIN
					prop_default = 0;
				case 17 % AnalyzeEnsemble_FUN_MP_BUD.F_MAX
					prop_default = Inf;
				case 18 % AnalyzeEnsemble_FUN_MP_BUD.CORRELATION_RULE
					prop_default = Correlation.CORRELATION_RULE_LIST{1};
				case 19 % AnalyzeEnsemble_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE
					prop_default = Correlation.NEGATIVE_WEIGHT_RULE_LIST{1};
				case 20 % AnalyzeEnsemble_FUN_MP_BUD.DENSITIES
					prop_default = [1:1:10];
				case 1 % AnalyzeEnsemble_FUN_MP_BUD.ELCLASS
					prop_default = 'AnalyzeEnsemble_FUN_MP_BUD';
				case 2 % AnalyzeEnsemble_FUN_MP_BUD.NAME
					prop_default = 'Multiplex Functional Binary Undirected at fixed Densities Analyze Ensemble';
				case 3 % AnalyzeEnsemble_FUN_MP_BUD.DESCRIPTION
					prop_default = 'This graph analysis (AnalyzeEnsemble_FUN_MP_BUD) analyzes functional multiplex data using binary undirected multigraphs with fixed densities.';
				case 4 % AnalyzeEnsemble_FUN_MP_BUD.TEMPLATE
					prop_default = Format.getFormatDefault(8, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				case 5 % AnalyzeEnsemble_FUN_MP_BUD.ID
					prop_default = 'AnalyzeEnsemble_FUN_MP_BUD ID';
				case 6 % AnalyzeEnsemble_FUN_MP_BUD.LABEL
					prop_default = 'AnalyzeEnsemble_FUN_MP_BUD label';
				case 7 % AnalyzeEnsemble_FUN_MP_BUD.NOTES
					prop_default = 'AnalyzeEnsemble_FUN_MP_BUD notes';
				case 10 % AnalyzeEnsemble_FUN_MP_BUD.GR
					prop_default = Group('SUB_CLASS', 'SubjectFUN_MP');
				case 11 % AnalyzeEnsemble_FUN_MP_BUD.GRAPH_TEMPLATE
					prop_default = Format.getFormatDefault(8, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				case 12 % AnalyzeEnsemble_FUN_MP_BUD.G_DICT
					prop_default = Format.getFormatDefault(10, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@AnalyzeEnsemble(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeEnsemble_FUN_MP_BUD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemble_FUN_MP_BUD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemble_FUN_MP_BUD, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemble_FUN_MP_BUD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(A) and Element.GETPROPDEFAULTCONDITIONED('AnalyzeEnsemble_FUN_MP_BUD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = AnalyzeEnsemble_FUN_MP_BUD.getPropProp(pointer);
			
			prop_default = AnalyzeEnsemble_FUN_MP_BUD.conditioning(prop, AnalyzeEnsemble_FUN_MP_BUD.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = A.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = A.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of A.
			%  CHECK = Element.CHECKPROP(AnalyzeEnsemble_FUN_MP_BUD, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemble_FUN_MP_BUD.
			%  CHECK = A.CHECKPROP(AnalyzeEnsemble_FUN_MP_BUD, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemble_FUN_MP_BUD.
			% 
			% A.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  A.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of A.
			%   Error id: BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput
			%  Element.CHECKPROP(AnalyzeEnsemble_FUN_MP_BUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemble_FUN_MP_BUD.
			%   Error id: BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput
			%  A.CHECKPROP(AnalyzeEnsemble_FUN_MP_BUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemble_FUN_MP_BUD.
			%   Error id: BRAPH2:AnalyzeEnsemble_FUN_MP_BUD:WrongInput]
			% 
			% Note that the Element.CHECKPROP(A) and Element.CHECKPROP('AnalyzeEnsemble_FUN_MP_BUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = AnalyzeEnsemble_FUN_MP_BUD.getPropProp(pointer);
			
			switch prop
				case 15 % AnalyzeEnsemble_FUN_MP_BUD.REPETITION
					check = Format.checkFormat(11, value, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				case 16 % AnalyzeEnsemble_FUN_MP_BUD.F_MIN
					check = Format.checkFormat(11, value, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				case 17 % AnalyzeEnsemble_FUN_MP_BUD.F_MAX
					check = Format.checkFormat(11, value, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				case 18 % AnalyzeEnsemble_FUN_MP_BUD.CORRELATION_RULE
					check = Format.checkFormat(5, value, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				case 19 % AnalyzeEnsemble_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE
					check = Format.checkFormat(5, value, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				case 20 % AnalyzeEnsemble_FUN_MP_BUD.DENSITIES
					check = Format.checkFormat(12, value, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				case 4 % AnalyzeEnsemble_FUN_MP_BUD.TEMPLATE
					check = Format.checkFormat(8, value, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				case 11 % AnalyzeEnsemble_FUN_MP_BUD.GRAPH_TEMPLATE
					check = Format.checkFormat(8, value, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				case 12 % AnalyzeEnsemble_FUN_MP_BUD.G_DICT
					check = Format.checkFormat(10, value, AnalyzeEnsemble_FUN_MP_BUD.getPropSettings(prop));
				otherwise
					if prop <= 14
						check = checkProp@AnalyzeEnsemble(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':AnalyzeEnsemble_FUN_MP_BUD:' 'WrongInput'], ...
					['BRAPH2' ':AnalyzeEnsemble_FUN_MP_BUD:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeEnsemble_FUN_MP_BUD.getPropTag(prop) ' (' AnalyzeEnsemble_FUN_MP_BUD.getFormatTag(AnalyzeEnsemble_FUN_MP_BUD.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(a, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case 20 % AnalyzeEnsemble_FUN_MP_BUD.DENSITIES
					a.memorize('GRAPH_TEMPLATE').set('DENSITIES', a.getCallback('DENSITIES'));
					
				otherwise
					if prop <= 14
						postset@AnalyzeEnsemble(a, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(a, prop, varargin)
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
				case 12 % AnalyzeEnsemble_FUN_MP_BUD.G_DICT
					rng_settings_ = rng(); rng(a.getPropSeed(12), 'twister')
					
					g_dict = IndexedDictionary('IT_CLASS', 'MultiplexBUD');
					gr = a.get('GR');
					
					T = a.get('REPETITION');
					fs = 1 / T;
					fmin = a.get('F_MIN');
					fmax = a.get('F_MAX');
					
					densities = a.get('DENSITIES'); % this is a vector
					
					for i = 1:1:gr.get('SUB_DICT').get('LENGTH')
						sub = gr.get('SUB_DICT').get('IT', i);
					    FUN_MP = sub.getr('FUN_MP');
					    L = sub.get('L');
					
					    A = cell(1, L);
					    
					    for j = 1:1:L
					        data = FUN_MP{j};
					        
					        if fmax > fmin && T > 0
					            NFFT = 2 * ceil(size(data, 1) / 2);
					            ft = fft(data, NFFT);  % Fourier transform
					            f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
					            ft(f < fmin | f > fmax, :) = 0;
					            data = ifft(ft, NFFT);
					        end
					        
					        A(j) = {Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'))};
					    end
					    
					    g = MultiplexBUD( ...
					        'ID', ['g ' sub.get('ID')], ...
					        'B', A, ...
					        'DENSITIES', densities, ... 
					        'LAYERLABELS', cellfun(@(x) ['L' num2str(x)], num2cell([1:1:L]), 'UniformOutput', false), ...
					        'NODELABELS', a.get('GR').get('SUB_DICT').get('IT', 1).get('BA').get('BR_DICT').get('KEYS') ...
					        );
					    g_dict.get('ADD', g)
					end
					
					if ~isa(a.get('GRAPH_TEMPLATE'), 'NoValue')
					    for i = 1:1:g_dict.get('LENGTH')
					        g_dict.get('IT', i).set('TEMPLATE', a.get('GRAPH_TEMPLATE'))
					    end
					end
					
					value = g_dict;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 14
						value = calculateValue@AnalyzeEnsemble(a, prop, varargin{:});
					else
						value = calculateValue@Element(a, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(a, prop, varargin)
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
				case 20 % AnalyzeEnsemble_FUN_MP_BUD.DENSITIES
					pr = PanelPropRVectorSmart('EL', a, 'PROP', 20, ...
					    'MIN', 0, 'MAX', 100, ...
					    'DEFAULT', AnalyzeEnsemble_FUN_MP_BUD.getPropDefault('DENSITIES'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@AnalyzeEnsemble(a, prop, varargin{:});
					
			end
		end
	end
end
