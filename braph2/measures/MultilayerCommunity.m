classdef MultilayerCommunity < Measure
	%MultilayerCommunity is the graph Multilayer Community Structure.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Multilayer Community Structure (MultilayerCommunity) of a multilayer graph is a subdivision of 
	%  the network into non-overlapping groups of nodes which maximizes the number 
	%  of within group edges, and minimizes the number of between group edges.
	%
	% The list of MultilayerCommunity properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Multilayer Community Structure.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Multilayer Community Structure.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Multilayer Community Structure.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Multilayer Community Structure.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Multilayer Community Structure.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Multilayer Community Structure.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Multilayer Community Structure.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Multilayer Community Structure.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>16</strong> <strong>LIMIT</strong> 	LIMIT (parameter, SCALAR) is the maximum size of multilayer modularity matrix.
	%  <strong>17</strong> <strong>RANDORD</strong> 	RANDORD (parameter, LOGICAL) is used to set randperm.
	%  <strong>18</strong> <strong>RANDMOVE</strong> 	RANDMOVE (parameter, LOGICAL) is the move function.
	%  <strong>19</strong> <strong>GAMMA</strong> 	GAMMA (parameter, SCALAR) is the resolution parameter.
	%  <strong>20</strong> <strong>OMEGA</strong> 	OMEGA (parameter, SCALAR) is the inter-layer coupling parameter.
	%  <strong>21</strong> <strong>S0</strong> 	S0 (data, cvector) is the initial partition size of the multilayer modularity matrix.
	%  <strong>22</strong> <strong>OM</strong> 	OM (data, MATRIX) is the multilayer modularity matrix.
	%  <strong>23</strong> <strong>QUALITY_FUNCTION</strong> 	QUALITY_FUNCTION (data, MATRIX) is the multilayer modularity quality function.
	%
	% MultilayerCommunity methods (constructor):
	%  MultilayerCommunity - constructor
	%
	% MultilayerCommunity methods:
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
	% MultilayerCommunity methods (display):
	%  tostring - string with information about the multilayer community structure
	%  disp - displays information about the multilayer community structure
	%  tree - displays the tree of the multilayer community structure
	%
	% MultilayerCommunity methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multilayer community structure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multilayer community structure
	%
	% MultilayerCommunity methods (save/load, Static):
	%  save - saves BRAPH2 multilayer community structure as b2 file
	%  load - loads a BRAPH2 multilayer community structure from a b2 file
	%
	% MultilayerCommunity method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multilayer community structure
	%
	% MultilayerCommunity method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multilayer community structure
	%
	% MultilayerCommunity methods (inspection, Static):
	%  getClass - returns the class of the multilayer community structure
	%  getSubclasses - returns all subclasses of MultilayerCommunity
	%  getProps - returns the property list of the multilayer community structure
	%  getPropNumber - returns the property number of the multilayer community structure
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
	% MultilayerCommunity methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultilayerCommunity methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultilayerCommunity methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultilayerCommunity methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultilayerCommunity; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultilayerCommunity constants</a>.
	%
	
	properties (Constant) % properties
		LIMIT = 16; %CET: Computational Efficiency Trick
		LIMIT_TAG = 'LIMIT';
		LIMIT_CATEGORY = 3;
		LIMIT_FORMAT = 11;
		
		RANDORD = 17; %CET: Computational Efficiency Trick
		RANDORD_TAG = 'RANDORD';
		RANDORD_CATEGORY = 3;
		RANDORD_FORMAT = 4;
		
		RANDMOVE = 18; %CET: Computational Efficiency Trick
		RANDMOVE_TAG = 'RANDMOVE';
		RANDMOVE_CATEGORY = 3;
		RANDMOVE_FORMAT = 4;
		
		GAMMA = 19; %CET: Computational Efficiency Trick
		GAMMA_TAG = 'GAMMA';
		GAMMA_CATEGORY = 3;
		GAMMA_FORMAT = 11;
		
		OMEGA = 20; %CET: Computational Efficiency Trick
		OMEGA_TAG = 'OMEGA';
		OMEGA_CATEGORY = 3;
		OMEGA_FORMAT = 11;
		
		S0 = 21; %CET: Computational Efficiency Trick
		S0_TAG = 'S0';
		S0_CATEGORY = 4;
		S0_FORMAT = 13;
		
		OM = 22; %CET: Computational Efficiency Trick
		OM_TAG = 'OM';
		OM_CATEGORY = 4;
		OM_FORMAT = 14;
		
		QUALITY_FUNCTION = 23; %CET: Computational Efficiency Trick
		QUALITY_FUNCTION_TAG = 'QUALITY_FUNCTION';
		QUALITY_FUNCTION_CATEGORY = 4;
		QUALITY_FUNCTION_FORMAT = 14;
	end
	methods % constructor
		function m = MultilayerCommunity(varargin)
			%MultilayerCommunity() creates a multilayer community structure.
			%
			% MultilayerCommunity(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultilayerCommunity(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of MultilayerCommunity properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Multilayer Community Structure.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Multilayer Community Structure.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Multilayer Community Structure.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Multilayer Community Structure.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Multilayer Community Structure.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Multilayer Community Structure.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Multilayer Community Structure.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Multilayer Community Structure.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>16</strong> <strong>LIMIT</strong> 	LIMIT (parameter, SCALAR) is the maximum size of multilayer modularity matrix.
			%  <strong>17</strong> <strong>RANDORD</strong> 	RANDORD (parameter, LOGICAL) is used to set randperm.
			%  <strong>18</strong> <strong>RANDMOVE</strong> 	RANDMOVE (parameter, LOGICAL) is the move function.
			%  <strong>19</strong> <strong>GAMMA</strong> 	GAMMA (parameter, SCALAR) is the resolution parameter.
			%  <strong>20</strong> <strong>OMEGA</strong> 	OMEGA (parameter, SCALAR) is the inter-layer coupling parameter.
			%  <strong>21</strong> <strong>S0</strong> 	S0 (data, cvector) is the initial partition size of the multilayer modularity matrix.
			%  <strong>22</strong> <strong>OM</strong> 	OM (data, MATRIX) is the multilayer modularity matrix.
			%  <strong>23</strong> <strong>QUALITY_FUNCTION</strong> 	QUALITY_FUNCTION (data, MATRIX) is the multilayer modularity quality function.
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the multilayer community structure.
			%
			% BUILD = MultilayerCommunity.GETBUILD() returns the build of 'MultilayerCommunity'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the multilayer community structure M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('MultilayerCommunity') returns the build of 'MultilayerCommunity'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('MultilayerCommunity')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the multilayer community structure.
			%
			% CLASS = MultilayerCommunity.GETCLASS() returns the class 'MultilayerCommunity'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multilayer community structure M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultilayerCommunity') returns 'MultilayerCommunity'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('MultilayerCommunity')
			%  are less computationally efficient.
			
			m_class = 'MultilayerCommunity';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multilayer community structure.
			%
			% LIST = MultilayerCommunity.GETSUBCLASSES() returns all subclasses of 'MultilayerCommunity'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the multilayer community structure M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('MultilayerCommunity') returns all subclasses of 'MultilayerCommunity'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'MultilayerCommunity'  'Flexibility'  'FlexibilityAv'  'MultilayerM'  'Persistence' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multilayer community structure.
			%
			% PROPS = MultilayerCommunity.GETPROPS() returns the property list of multilayer community structure
			%  as a row vector.
			%
			% PROPS = MultilayerCommunity.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multilayer community structure M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultilayerCommunity'[, CATEGORY]) returns the property list of 'MultilayerCommunity'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3 9 10 11 12];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 16 17 18 19 20];
				case 4 % Category.DATA
					prop_list = [5 13 21 22 23];
				case 5 % Category.RESULT
					prop_list = 14;
				case 6 % Category.QUERY
					prop_list = 8;
				case 9 % Category.GUI
					prop_list = 15;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of multilayer community structure.
			%
			% N = MultilayerCommunity.GETPROPNUMBER() returns the property number of multilayer community structure.
			%
			% N = MultilayerCommunity.GETPROPNUMBER(CATEGORY) returns the property number of multilayer community structure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the multilayer community structure M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultilayerCommunity') returns the property number of 'MultilayerCommunity'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 23;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 7;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 6;
				case 4 % Category.DATA
					prop_number = 5;
				case 5 % Category.RESULT
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multilayer community structure/error.
			%
			% CHECK = MultilayerCommunity.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultilayerCommunity, PROP) checks whether PROP exists for MultilayerCommunity.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultilayerCommunity:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerCommunity:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerCommunity:WrongInput]
			%  Element.EXISTSPROP(MultilayerCommunity, PROP) throws error if PROP does NOT exist for MultilayerCommunity.
			%   Error id: [BRAPH2:MultilayerCommunity:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 23 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultilayerCommunity:' 'WrongInput'], ...
					['BRAPH2' ':MultilayerCommunity:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultilayerCommunity.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multilayer community structure/error.
			%
			% CHECK = MultilayerCommunity.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultilayerCommunity, TAG) checks whether TAG exists for MultilayerCommunity.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultilayerCommunity:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerCommunity:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerCommunity:WrongInput]
			%  Element.EXISTSTAG(MultilayerCommunity, TAG) throws error if TAG does NOT exist for MultilayerCommunity.
			%   Error id: [BRAPH2:MultilayerCommunity:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'LIMIT'  'RANDORD'  'RANDMOVE'  'GAMMA'  'OMEGA'  'S0'  'OM'  'QUALITY_FUNCTION' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultilayerCommunity:' 'WrongInput'], ...
					['BRAPH2' ':MultilayerCommunity:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for MultilayerCommunity.'] ...
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
			%  PROPERTY = M.GETPROPPROP(POINTER) returns property number of POINTER of M.
			%  PROPERTY = Element.GETPROPPROP(MultilayerCommunity, POINTER) returns property number of POINTER of MultilayerCommunity.
			%  PROPERTY = M.GETPROPPROP(MultilayerCommunity, POINTER) returns property number of POINTER of MultilayerCommunity.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'LIMIT'  'RANDORD'  'RANDMOVE'  'GAMMA'  'OMEGA'  'S0'  'OM'  'QUALITY_FUNCTION' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = M.GETPROPTAG(POINTER) returns tag of POINTER of M.
			%  TAG = Element.GETPROPTAG(MultilayerCommunity, POINTER) returns tag of POINTER of MultilayerCommunity.
			%  TAG = M.GETPROPTAG(MultilayerCommunity, POINTER) returns tag of POINTER of MultilayerCommunity.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				multilayercommunity_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'LIMIT'  'RANDORD'  'RANDMOVE'  'GAMMA'  'OMEGA'  'S0'  'OM'  'QUALITY_FUNCTION' };
				tag = multilayercommunity_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = M.GETPROPCATEGORY(POINTER) returns category of POINTER of M.
			%  CATEGORY = Element.GETPROPCATEGORY(MultilayerCommunity, POINTER) returns category of POINTER of MultilayerCommunity.
			%  CATEGORY = M.GETPROPCATEGORY(MultilayerCommunity, POINTER) returns category of POINTER of MultilayerCommunity.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerCommunity.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multilayercommunity_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3  3  3  3  3  4  4  4 };
			prop_category = multilayercommunity_category_list{prop};
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
			%  FORMAT = M.GETPROPFORMAT(POINTER) returns format of POINTER of M.
			%  FORMAT = Element.GETPROPFORMAT(MultilayerCommunity, POINTER) returns format of POINTER of MultilayerCommunity.
			%  FORMAT = M.GETPROPFORMAT(MultilayerCommunity, POINTER) returns format of POINTER of MultilayerCommunity.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerCommunity.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multilayercommunity_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  11  4  4  11  11  13  14  14 };
			prop_format = multilayercommunity_format_list{prop};
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
			%  DESCRIPTION = M.GETPROPDESCRIPTION(POINTER) returns description of POINTER of M.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultilayerCommunity, POINTER) returns description of POINTER of MultilayerCommunity.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultilayerCommunity, POINTER) returns description of POINTER of MultilayerCommunity.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerCommunity.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			multilayercommunity_description_list = { 'ELCLASS (constant, string) is the class of the Multilayer Community Structure.'  'NAME (constant, string) is the name of the Multilayer Community Structure.'  'DESCRIPTION (constant, string) is the description of the Multilayer Community Structure.'  'TEMPLATE (parameter, item) is the template of the Multilayer Community Structure.'  'ID (data, string) is a few-letter code of the Multilayer Community Structure.'  'LABEL (metadata, string) is an extended label of the Multilayer Community Structure.'  'NOTES (metadata, string) are some specific notes about the Multilayer Community Structure.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Multilayer Community Structure.'  'PFM (gui, item) contains the panel figure of the measure.'  'LIMIT (parameter, SCALAR) is the maximum size of multilayer modularity matrix.'  'RANDORD (parameter, LOGICAL) is used to set randperm.'  'RANDMOVE (parameter, LOGICAL) is the move function.'  'GAMMA (parameter, SCALAR) is the resolution parameter.'  'OMEGA (parameter, SCALAR) is the inter-layer coupling parameter.'  'S0 (data, cvector) is the initial partition size of the multilayer modularity matrix.'  'OM (data, MATRIX) is the multilayer modularity matrix.'  'QUALITY_FUNCTION (data, MATRIX) is the multilayer modularity quality function.' };
			prop_description = multilayercommunity_description_list{prop};
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
			%  SETTINGS = M.GETPROPSETTINGS(POINTER) returns settings of POINTER of M.
			%  SETTINGS = Element.GETPROPSETTINGS(MultilayerCommunity, POINTER) returns settings of POINTER of MultilayerCommunity.
			%  SETTINGS = M.GETPROPSETTINGS(MultilayerCommunity, POINTER) returns settings of POINTER of MultilayerCommunity.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerCommunity.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % MultilayerCommunity.LIMIT
					prop_settings = Format.getFormatSettings(11);
				case 17 % MultilayerCommunity.RANDORD
					prop_settings = Format.getFormatSettings(4);
				case 18 % MultilayerCommunity.RANDMOVE
					prop_settings = Format.getFormatSettings(4);
				case 19 % MultilayerCommunity.GAMMA
					prop_settings = Format.getFormatSettings(11);
				case 20 % MultilayerCommunity.OMEGA
					prop_settings = Format.getFormatSettings(11);
				case 21 % MultilayerCommunity.S0
					prop_settings = Format.getFormatSettings(13);
				case 22 % MultilayerCommunity.OM
					prop_settings = Format.getFormatSettings(14);
				case 23 % MultilayerCommunity.QUALITY_FUNCTION
					prop_settings = Format.getFormatSettings(14);
				case 4 % MultilayerCommunity.TEMPLATE
					prop_settings = 'MultilayerCommunity';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultilayerCommunity.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerCommunity.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultilayerCommunity, POINTER) returns the default value of POINTER of MultilayerCommunity.
			%  DEFAULT = M.GETPROPDEFAULT(MultilayerCommunity, POINTER) returns the default value of POINTER of MultilayerCommunity.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultilayerCommunity.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % MultilayerCommunity.LIMIT
					prop_default = 10000;
				case 17 % MultilayerCommunity.RANDORD
					prop_default = true;
				case 18 % MultilayerCommunity.RANDMOVE
					prop_default = true;
				case 19 % MultilayerCommunity.GAMMA
					prop_default = 1;
				case 20 % MultilayerCommunity.OMEGA
					prop_default = 1;
				case 21 % MultilayerCommunity.S0
					prop_default = [];
				case 22 % MultilayerCommunity.OM
					prop_default = [];
				case 23 % MultilayerCommunity.QUALITY_FUNCTION
					prop_default = [];
				case 1 % MultilayerCommunity.ELCLASS
					prop_default = 'MultilayerCommunity';
				case 2 % MultilayerCommunity.NAME
					prop_default = 'Multilayer Community Structure';
				case 3 % MultilayerCommunity.DESCRIPTION
					prop_default = 'The Multilayer Community Structure (MultilayerCommunity) of a multilayer graph is a subdivision of the network into non-overlapping groups of nodes which maximizes the number of within group edges, and minimizes the number of between group edges.';
				case 4 % MultilayerCommunity.TEMPLATE
					prop_default = Format.getFormatDefault(8, MultilayerCommunity.getPropSettings(prop));
				case 5 % MultilayerCommunity.ID
					prop_default = 'MultilayerCommunity ID';
				case 6 % MultilayerCommunity.LABEL
					prop_default = 'Multilayer Community Structure label';
				case 7 % MultilayerCommunity.NOTES
					prop_default = 'Multilayer Community Structure notes';
				case 9 % MultilayerCommunity.SHAPE
					prop_default = 2;
				case 10 % MultilayerCommunity.SCOPE
					prop_default = 2;
				case 11 % MultilayerCommunity.PARAMETRICITY
					prop_default = 2;
				case 12 % MultilayerCommunity.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexWD' 'OrdMxWU' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUT' 'MultiplexBUD' 'MultilayerBU' 'MultilayerWU' 'OrdMlWU'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultilayerCommunity.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerCommunity.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultilayerCommunity, POINTER) returns the conditioned default value of POINTER of MultilayerCommunity.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultilayerCommunity, POINTER) returns the conditioned default value of POINTER of MultilayerCommunity.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultilayerCommunity.getPropProp(pointer);
			
			prop_default = MultilayerCommunity.conditioning(prop, MultilayerCommunity.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = M.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = M.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of M.
			%  CHECK = Element.CHECKPROP(MultilayerCommunity, PROP, VALUE) checks VALUE format for PROP of MultilayerCommunity.
			%  CHECK = M.CHECKPROP(MultilayerCommunity, PROP, VALUE) checks VALUE format for PROP of MultilayerCommunity.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:MultilayerCommunity:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:MultilayerCommunity:WrongInput
			%  Element.CHECKPROP(MultilayerCommunity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerCommunity.
			%   Error id: BRAPH2:MultilayerCommunity:WrongInput
			%  M.CHECKPROP(MultilayerCommunity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerCommunity.
			%   Error id: BRAPH2:MultilayerCommunity:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultilayerCommunity.getPropProp(pointer);
			
			switch prop
				case 16 % MultilayerCommunity.LIMIT
					check = Format.checkFormat(11, value, MultilayerCommunity.getPropSettings(prop));
				case 17 % MultilayerCommunity.RANDORD
					check = Format.checkFormat(4, value, MultilayerCommunity.getPropSettings(prop));
				case 18 % MultilayerCommunity.RANDMOVE
					check = Format.checkFormat(4, value, MultilayerCommunity.getPropSettings(prop));
				case 19 % MultilayerCommunity.GAMMA
					check = Format.checkFormat(11, value, MultilayerCommunity.getPropSettings(prop));
				case 20 % MultilayerCommunity.OMEGA
					check = Format.checkFormat(11, value, MultilayerCommunity.getPropSettings(prop));
				case 21 % MultilayerCommunity.S0
					check = Format.checkFormat(13, value, MultilayerCommunity.getPropSettings(prop));
				case 22 % MultilayerCommunity.OM
					check = Format.checkFormat(14, value, MultilayerCommunity.getPropSettings(prop));
				case 23 % MultilayerCommunity.QUALITY_FUNCTION
					check = Format.checkFormat(14, value, MultilayerCommunity.getPropSettings(prop));
				case 4 % MultilayerCommunity.TEMPLATE
					check = Format.checkFormat(8, value, MultilayerCommunity.getPropSettings(prop));
				otherwise
					if prop <= 15
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MultilayerCommunity:' 'WrongInput'], ...
					['BRAPH2' ':MultilayerCommunity:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultilayerCommunity.getPropTag(prop) ' (' MultilayerCommunity.getFormatTag(MultilayerCommunity.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop, varargin)
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
				case 14 % MultilayerCommunity.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G');  % graph from measure class
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					graph_type = g.get('GRAPH_TYPE');
					limit = m.get('LIMIT');  % set default for maximum size of multilayer modularity matrix
					randord = m.get('RANDORD');  % set randperm
					randmove = m.get('RANDMOVE');  % set move function
					gamma = m.get('GAMMA');
					omega = m.get('OMEGA');
					S0 = m.get('S0');
					OM = m.get('OM');
					
					if L == 0  % no value case
					    value = {};
					    return;
					end
					% set randperm- v. index-ordered
					if randord
					    myord = @(n) randperm(n);
					else
					    myord = @(n) 1:n;
					end
					
					% set move function (maximal (original Louvain) or random improvement)
					if randmove
					    if ischar(randmove)
					        if any(strcmp(randmove,{'move','moverand','moverandw'}))
					            movefunction = randmove;
					        else
					            error('unknown value for ''randmove''');
					        end
					    else
					        % backwards compatibility: randmove=true
					        movefunction = 'moverand';
					    end
					else
					    movefunction = 'move';
					end
					
					if isempty(OM)
					    directionality_type =  g.get('DIRECTIONALITY_TYPE', L);
					    directionality_firstlayer = directionality_type(1, 1);
					    A = cell(L, 1);
					    A_hold = g.get('A');
					    for i=1:L
					        A(i) = {A_hold{i, i}};
					    end
					    if graph_type == 4 || graph_type == 6
					        if directionality_firstlayer == 2  % undirected
					            [OM, twom] = multicat_undirected(m, A, gamma, omega, N(1), L);
					        else  % directed
					            [OM, twom] = multicat_directed(m, A, gamma, omega, N(1), L);
					        end
					    elseif graph_type== 3 || graph_type== 5
					        if directionality_firstlayer == 2  % undirected
					            [OM, twom] = multiord_undirected(m, A, gamma, omega, N(1), L);
					        else  % directed
					            [OM, twom] = multiord_directed(m, A, gamma, omega, N(1), L);
					        end
					    end
					end
					
					% initialise variables and do symmetry check
					if isa(OM,'function_handle')
					    n = length(OM(1));
					    S = (1:n)';
					    
					    if isempty(S0)
					        S0 = (1:n)';
					    else
					        if numel(S0) == n
					            group_handler('assign', S0);
					            S0 = group_handler('return'); % tidy config
					        else
					            error(['BRAPH2' ':MultilayerCommunity:' 'WrongInput'], ...
					                ['Initial partition size for the modularity matrix should be equal to %i,' ...
					                ' while it is ' tostring(numel(S0))], n)
					        end
					    end
					    
					    % symmetry check (only checks symmetry of a small part of the matrix)
					    M = OM;
					    it(:,1) = M(1);
					    ii = find(it(2:end)>0,3) + 1;
					    ii = [1,ii'];
					    for i=2:length(ii)
					        it(:,i)=M(ii(i));
					    end
					    it = it(ii,:);
					%     if norm(full(it-it')) > 2*eps
					%         error(['BRAPH2' ':MultilayerCommunity:' 'WrongInput'], ...
					%             'Function handle does not correspond to a symmetric matrix. Deviation: %i', norm(full(it-it')))
					%     end
					else
					    n = length(OM);
					    S = (1:n)';
					    if isempty(S0)
					        S0 = (1:n)';
					    else
					        if numel(S0)==n
					            % clean input partition
					            group_handler('assign', S0);
					            S0 = group_handler('return');
					        else
					            error(['BRAPH2' ':MultilayerCommunity:' 'WrongInput'], ...
					                ['Initial partition size for the modularity matrix should be equal to %i,' ...
					                ' while it is ' tostring(numel(S0))], n)
					        end
					    end
					    %symmetry check and fix if not symmetric
					    if nnz(OM-OM')
					        OM = (OM+OM')/2;
					        %                     disp('WARNING: Forced symmetric OM matrix')
					    end
					    M = OM;
					end
					
					dtot = eps;  % keeps track of total change in modularity
					y = S0;
					% Run using function handle, if provided
					while (isa(M,'function_handle'))  % loop around each "pass" (in language of Blondel et al) with OM function handle
					    Sb = S;
					    yb = [];
					    while ~isequal(yb,y)
					        dstep = 1;  % keeps track of change in modularity in pass
					        yb = [];
					        while (~isequal(yb,y)) && (dstep/dtot>2*eps) && (dstep>10*eps)  % This is the loop around Blondel et al's "first phase"
					            yb = y;
					            dstep = 0;
					            group_handler('assign',y);
					            for i = myord(length(M(1)))
					                di = group_handler(movefunction, i, M(i));
					                dstep = dstep + di;
					            end
					            
					            dtot = dtot + dstep;
					            y = group_handler('return');
					        end
					        yb = y;
					    end
					    
					    % update partition
					    S = y(S);  % group_handler implements tidyconfig
					    y = unique(y);  % unique also puts elements in ascending order
					    
					    % calculate modularity and return if converged
					    if isequal(Sb,S)
					        Q = 0;
					        P = sparse(y,1:length(y),1);
					        for i=1:length(M(1))
					            Q = Q + (P*M(i))'*P(:,i);
					        end
					        Q = full(Q);
					        clear('group_handler');
					        clear('metanetwork_reduce');
					        m.set('QUALITY_FUNCTION', Q/twom)  % save normalized quality function
					        S = reshape(S, N(1), L);
					        multilayer_community_structure = cell(L, 1);
					        for li = 1:1:L
					            multilayer_community_structure(li) = {S(:, li)};
					        end
					        return
					    end
					    
					    % check wether #groups < limit
					    t = length(unique(S));
					    if (t > limit)
					        metanetwork_reduce('assign', S);  % inputs group information to metanetwork_reduce
					        M = @(i) metanetwork_i(m,OM,i);  % use function handle if #groups > limit
					    else
					        metanetwork_reduce('assign', S);
					        J = zeros(t);  % convert to matrix if #groups small enough
					        for c=1:t
					            J(:,c) = metanetwork_i(m,OM,c);
					        end
					        OM = J;
					        M = OM;
					    end
					end
					
					% Run using matrix OM (old B)
					S2 = (1:length(OM))';
					Sb = [];
					while ~isequal(Sb, S2)  % loop around each "pass" (in language of Blondel et al) with B matrix
					    Sb = S2;
					    yb = [];
					    while ~isequal(yb,y)
					        dstep = 1;
					        while (~isequal(yb,y)) && (dstep/dtot > 2*eps) && (dstep > 10*eps)  % This is the loop around Blondel et al's "first phase"
					            yb = y;
					            dstep = 0;
					            group_handler('assign',y);
					            for i = myord(length(M))
					                di = group_handler(movefunction,i,M(:,i));
					                dstep = dstep+di;
					            end
					            dtot = dtot + dstep;
					            y = group_handler('return');
					        end
					        yb = y;
					    end
					    
					    % update partition
					    S = y(S);
					    S2 = y(S2);
					    
					    if isequal(Sb,S2)
					        P = sparse(y,1:length(y),1);
					        Q = full(sum(sum((P*M).*P)));
					        m.set('QUALITY_FUNCTION', Q/twom);  % save normalized quality function
					        S = reshape(S, N(1), L);
					        multilayer_community_structure = cell(L, 1);
					        for li = 1:1:L
					            multilayer_community_structure(li) = {S(:, li)};
					        end
					        value = multilayer_community_structure;
					        return
					    end
					    
					    M = metanetwork(m, OM, S2);
					    y = unique(S2);  % unique also puts elements in ascending order
					end
					m.set('QUALITY_FUNCTION', Q/twom);  % save normalized quality function
					S = reshape(S, N(1), L);
					multilayer_community_structure = cell(L, 1);
					for li = 1:1:L
					    multilayer_community_structure(li) = {S(:, li)};
					end
					
					value = multilayer_community_structure;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 15
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
			function [OM, twom] = multiord_undirected(m, A, gamma, omega, N, T)
			% MULTIORDUNDIRECTED returns the multilayer modularity matrix for ordered undirected networks
			%
			% [B, twom] = MULTIORDUNDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer
			% Newman-Girvan modularity matrix for ordered undirected networks.
			%
			%   Input: A: Cell array of NxN adjacency matrices for each layer of an
			%          ordered undirected multilayer network
			%          gamma: intralayer resolution parameter
			%          omega: interlayer coupling strength
			%
			%   Output: B: function handle where B(i) returns the ith column of
			%          [NxT]x[NxT] flattened modularity tensor for the
			%           multilayer network with uniform ordinal coupling (T is
			%           the number of layers of the network)
			%           twom: normalisation constant
			%
			%   Example of usage: [B,twom]=multiord_f(A,gamma,omega);
			%          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
			%          postprocess_ordinal_multilayer.m for how to improve output
			%          multilayer partition
			%          Q=Q/twom;
			%          S=reshape(S,N,T);
			%
			%   [B,twom] = MULTIORD_F(A,GAMMA, OMEGA) with A a cell array of square
			%   symmetric matrices of equal size each representing an undirected network
			%   "layer" computes the multilayer Newman-Girvan modularity matrix using
			%   the quality function described in Mucha et al. 2010, with intralayer
			%   resolution parameter GAMMA, and with interlayer coupling OMEGA connecting
			%   nearest-neighbor ordered layers.  The null model used for the quality
			%   function is the Newman-Girvan null model (see e.g. Bazzi et al. for other
			%   possible null models). Once the mulilayer modularity matrix is computed,
			%   optimization can be performed by the generalized Louvain code GENLOUVAIN
			%   or ITERATED_GENLOUVAIN. The output B can be used with other heuristics,
			%   provided the same mapping is used to go from the multilayer tensor to
			%   the multilayer flattened matrix. That is, the node-layer tuple (i,s)
			%   is mapped to i + (s-1)*N. [Note that we can define a mapping between a
			%   multilayer partition S_m stored as an N by T matrix and the corresponding
			%   flattened partition S stored as an NT by 1 vector. In particular
			%   S_m = reshape(S,N,T) and S = S_m(:).]
			%
			%
			%   See also
			%       genlouvain heuristics:      GENLOUVAIN, ITERATED_GENLOUVAIN
			%       multilayer wrappers:        MULTICAT, MULTICATF, MULTIORD
			%       other heuristics:           SPECTRAL23
			%       Kernighan-Lin improvement:  KLNB
			%
			%   Notes:
			%     The matrices in the cell array A are assumed to be square,
			%     symmetric, and of equal size.  These assumptions are not checked here.
			%
			%     For smaller systems, it is potentially more efficient (and easier) to
			%     directly use the sparse quality/modularity matrix B in MULTIORD. For
			%     large systems with directed layer networks, use MULTIORDDIR_F.
			%
			%     This code serves as a template and can be modified for situations
			%     with other wrinkles (e.g., different intralayer null models,
			%     different numbers of nodes from layer-to-layer, or systems which are
			%     both multiplex and longitudinal).  That is, this code is only a
			%     starting point; it is by no means exhaustive.
			%
			%     By using this code, the user implicitly acknowledges that the authors
			%     accept no liability associated with that use.  (What are you doing
			%     with it anyway that might cause there to be a potential liability?!?)
			
			if nargin < 2 || isempty(gamma)
			    gamma = 1;
			end
			
			if nargin < 3
			    omega = 1;
			end
			
			if length(gamma) == 1
			    gamma = repmat(gamma, T, 1);
			end
			
			ii=[]; jj=[]; vv=[];
			ki=[]; kj=[]; kv=[];
			twom = 0;
			for s=1:T
			    indx = (1:N)' + (s-1)*N;
			    [i, j, v] = find(A{s});
			    ii = [ii; indx(i)];
			    jj = [jj; indx(j)];
			    vv = [vv; v];
			    k = sum(A{s});
			    mm = sum(k);
			    twom = twom + mm;
			    ki = [ki; indx];
			    kj = [kj; ones(N,1)*s];
			    kv = [kv; k(:)./mm];
			end
			AA = sparse(ii, jj, vv, N*T, N*T);
			K = sparse(ki, kj, kv, N*T, T);
			clear ii jj vv ki kj kv
			kvec = full(sum(AA));
			AA = AA + omega*spdiags(ones(N*T,2),[-N,N],N*T,N*T);
			OM = @(i) AA(:,i) - gamma(ceil(i/(N+eps)))*K(:,ceil(i/(N+eps)))*kvec(i);
			twom = twom + 2*N*(T-1)*omega;
			end
			function [OM, twom] = multiord_directed(m, A, gamma, omega, N, T)
			% MULTIORDDIRECTED returns the multilayer modularity matrix for ordered directed networks
			%
			% [B, twom] = MULTIORDDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer
			% Leicht-Newman modularity matrix for ordered directed networks.
			%
			%   Input: A: Cell array of NxN adjacency matrices for each layer of an
			%          ordered directed multilayer network
			%          gamma: intralayer resolution parameter
			%          omega: interlayer coupling strength
			%
			%   Output: B: function handle where B(i) returns the ith column of
			%          [NxT]x[NxT] flattened modularity tensor for the
			%           multilayer network with uniform ordinal coupling (T is
			%           the number of layers of the network)
			%           twom: normalisation constant
			%
			%   Example of usage: [B,twom]=multiorddir_f(A,gamma,omega);
			%          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
			%          postprocess_ordinal_multilayer.m for how to improve output
			%          multilayer partition
			%          Q=Q/twom;
			%          S=reshape(S,N,T);
			%
			%   [B,twom] = MULTIORDDIR_F(A,GAMMA, OMEGA) with A a cell array of square
			%   matrices of equal size each representing an directed network "layer"
			%   computes the Leicht-Newman multilayer modularity matrix Susing the
			%   quality function described in Mucha et al. 2010, with intralayer
			%   resolution parameter GAMMA, and with interlayer coupling OMEGA
			%   connecting nearest-neighbor ordered layers. Once the mulilayer modularity
			%   matrix is computed, optimization can be performed by the generalized
			%   Louvain code GENLOUVAIN or ITERATED_GENLOUVAIN. The output B can be used
			%   with other heuristics, provided the same mapping is used to go from the
			%   multilayer tensor to the multilayer flattened matrix. That is, the
			%   node-layer tuple (i,s) is mapped to i + (s-1)*N. [Note that we can
			%   define a mapping between a multilayer partition S_m stored as an N by T
			%   matrix and the corresponding flattened partition S stored as an NT by 1
			%   vector. In particular S_m = reshape(S,N,T) and S = S_m(:).]
			%
			%   See also
			%       genlouvain heuristics:      GENLOUVAIN, ITERATED_GENLOUVAIN
			%       multilayer wrappers:        MULTICAT, MULTICATF, MULTIORD
			%       other heuristics:           SPECTRAL23
			%       Kernighan-Lin improvement:  KLNB
			%
			%   Notes:
			%     The matrices in the cell array A are assumed to be square,
			%     and of equal size.  These assumptions are not checked here.
			%
			%     For smaller systems, it is potentially more efficient (and easier) to
			%     directly use the sparse quality/modularity matrix B in MULTIORD. For
			%     large systems with undirected layer networks, use MULTIORD_F.
			%
			%     This code serves as a template and can be modified for situations
			%     with other wrinkles (e.g., different intralayer null models,
			%     different numbers of nodes from layer-to-layer, or systems which are
			%     both multiplex and longitudinal).  That is, this code is only a
			%     starting point; it is by no means exhaustive.
			%
			%     By using this code, the user implicitly acknowledges that the authors
			%     accept no liability associated with that use.  (What are you doing
			%     with it anyway that might cause there to be a potential liability?!?)
			
			if nargin < 2 || isempty(gamma)
			    gamma = 1;
			end
			
			if nargin < 3 || isempty(omega)
			    omega = 1;
			end
			
			if length(gamma) == 1
			    gamma = repmat(gamma,T,1);
			end
			m = zeros(T,1);
			for i=1:T
			    m(i) = sum(A{i}(:));
			end
			A = blkdiag(A{:});
			kout = sum(A,1);
			koutmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kout);
			kin = sum(A,2);
			kinmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kin);
			A = (A+A')./2;
			A = A + omega*spdiags(ones(N*T,2), [-N,N], N*T, N*T);
			
			OM = @(i) A(:,i) - gamma(ceil(i./(N+eps))).*(kout(i).*kinmat(:,ceil(i./(N+eps)))+kin(i).*koutmat(:,ceil(i./(N+eps))))./(2*m(ceil(i./(N+eps))));
			twom = sum(m) + omega*2*N*(T-1);
			end
			function [OM, twom] = multicat_undirected(m, A, gamma, omega, N, T)
			% MULTICATUNDIRECTED returns the multilayer modularity matrix for unordered undirected networks
			%
			% [B, twom] = MULTICATUNDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer
			% Newman-Girvan modularity matrix for unordered undirected networks.
			%
			%   Input: A: Cell array of NxN adjacency matrices for each layer of an
			%          unordered multilayer undirected network
			%          gamma: intralayer resolution parameter
			%          omega: interlayer coupling strength
			%
			%   Output: B: [NxT]x[NxT] function handle where B(i) returns the ith column
			%           of the flattened modularity tensor for the
			%           multilayer network with uniform categorical coupling (T is
			%           the number of layers of the network)
			%           twom: normalisation constant
			%
			%   Example of usage: [B,twom]=multicat_f(A,gamma,omega);
			%          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
			%          postprocess_categorical_multilayer.m for how to improve output
			%          multilayer partition
			%          Q=Q/twom;
			%          S=reshape(S,N,T);
			%
			%   [B,twom] = MULTICAT(A,GAMMA, OMEGA) with A a cell array of square
			%   symmetric matrices of equal size each representing an undirected network
			%   "layer" computes the multilayer modularity matrix using the quality
			%   function described in Mucha et al. 2010, with intralayer resolution
			%   parameter GAMMA, and with interlayer coupling OMEGA connecting
			%   all-to-all categorical layers. Once the mulilayer modularity matrix is
			%   computed, optimization can be performed by the generalized Louvain code
			%   GENLOUVAIN or ITERATED_GENLOUVAIN. The output B can be used with other
			%   heuristics, provided the same mapping is used to go from the multilayer
			%   tensor to the multilayer flattened matrix. That is, the node-layer tuple
			%   (i,s) is mapped to i + (s-1)*N. [Note that we can define a mapping between
			%   a multilayer partition S_m stored as an N by T matrix and the corresponding
			%   flattened partition S stored as an NT by 1 vector. In particular
			%   S_m = reshape(S,N,T) and S = S_m(:).]
			%
			%   Notes:
			%     The matrices in the cell array A are assumed to be symmetric, square,
			%     and of equal size.  These assumptions are not checked here.
			%
			%     For smaller systems, it is potentially more efficient (and easier) to
			%     directly use the sparse quality/modularity matrix B, as in MULTICAT.
			%
			%     This code serves as a template and can be modified for situations
			%     with other wrinkles (e.g., different intralayer null models,
			%     different numbers of nodes from layer-to-layer, or systems which are
			%     both multiplex and longitudinal).  That is, this code is only a
			%     starting point; it is by no means exhaustive.
			%
			%     By using this code, the user implicitly acknowledges that the authors
			%     accept no liability associated with that use.  (What are you doing
			%     with it anyway that might cause there to be a potential liability?!?)
			
			if nargin < 2 || isempty(gamma)
			    gamma = 1;
			end
			
			if nargin < 3 || isempty(omega)
			    omega = 1;
			end
			
			if length(gamma) == 1
			    gamma = repmat(gamma, T, 1);
			end
			
			ii = []; jj = []; vv = [];
			ki = []; kj = []; kv = [];
			twom = 0;
			for s=1:T
			    indx = [1:N]' + (s-1)*N;
			    [i, j, v] = find(A{s});
			    ii = [ii; indx(i)];
			    jj = [jj; indx(j)];
			    vv = [vv; v];
			    k = sum(A{s});
			    mm = sum(k);
			    ki = [ki; indx];
			    kj = [kj; ones(N,1)*s];
			    kv = [kv; k(:)./mm];
			    twom = twom + sum(k);
			end
			AA = sparse(ii,jj,vv,N*T,N*T);
			K=sparse(ki,kj,kv,N*T,T);
			clear ii jj vv ki kj kv
			kvec = full(sum(AA));
			all2all = N*[(-T+1):-1,1:(T-1)];
			AA = AA + omega*spdiags(ones(N*T, 2*T-2), all2all, N*T, N*T);
			OM = @(i) AA(:,i) - gamma(ceil(i/(N+eps)))*K(:, ceil(i/(N+eps)))*kvec(i);
			twom = twom + 2*N*(T-1)*T*omega;
			end
			function [OM, twom] = multicat_directed(m, A, gamma, omega, N, T)
			% MULTICATDIRECTED returns the multilayer modularity matrix for unordered directed networks
			%
			% [B, twom] = MULTICATDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer
			% Leicht-Newman modularity matrix for unordered directed networks.
			%
			%   Input: A: Cell array of NxN adjacency matrices for each layer of a
			%          categorical directed multilayer network
			%          gamma: intralayer resolution parameter
			%          omega: interlayer coupling strength
			%
			%   Output: B: function handle where B(i) returns the ith column of
			%          [NxT]x[NxT] flattened modularity tensor for the
			%           multilayer network with uniform ordinal coupling (T is
			%           the number of layers of the network)
			%           twom: normalisation constant
			%
			%   Example of usage: [B,twom]=multicatdir_f(A,gamma,omega);
			%          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
			%          postprocess_categorical_multilayer.m for how to improve output
			%          multilayer partition
			%          Q=Q/twom;
			%          S=reshape(S,N,T);
			%
			%   [B,twom] = MULTICATDIR_F(A,GAMMA, OMEGA) with A a cell array of square
			%   matrices of equal size each representing an directed network "layer"
			%   computes the Leicht-Newman multilayer modularity matrix B using the
			%   quality function described in Mucha et al. 2010, with intralayer
			%   resolution parameter GAMMA, and with interlayer coupling OMEGA
			%   connecting all-to-all categorical layers. Once the mulilayer modularity
			%   matrix is computed, optimization can be performed by the generalized
			%   Louvain code GENLOUVAIN or ITERATED_GENLOUVAIN. The output B can be used
			%   with other heuristics, provided the same mapping is used to go from the
			%   multilayer tensor to the multilayer flattened matrix. That is, the
			%   node-layer tuple (i,s) is mapped to i + (s-1)*N. [Note that we can
			%   define a mapping between a multilayer partition S_m stored as an N by T
			%   matrix and the corresponding flattened partition S stored as an NT by 1
			%   vector. In particular S_m = reshape(S,N,T) and S = S_m(:).]
			%
			%   Notes:
			%     The matrices in the cell array A are assumed to be square,
			%     and of equal size.  These assumptions are not checked here.
			%
			%     For smaller systems, it is potentially more efficient (and easier) to
			%     directly use the sparse quality/modularity matrix B in MULTICAT. For
			%     large systems with undirected layer networks, use MULTICAT_F.
			%
			%     This code serves as a template and can be modified for situations
			%     with other wrinkles (e.g., different intralayer null models,
			%     different numbers of nodes from layer-to-layer, or systems which are
			%     both multiplex and longitudinal).  That is, this code is only a
			%     starting point; it is by no means exhaustive.
			%
			%     By using this code, the user implicitly acknowledges that the authors
			%     accept no liability associated with that use.  (What are you doing
			%     with it anyway that might cause there to be a potential liability?!?)
			
			if nargin < 2 || isempty(gamma)
			    gamma = 1;
			end
			
			if nargin < 3 || isempty(omega)
			    omega = 1;
			end
			
			if length(gamma) == 1
			    gamma = repmat(gamma, T, 1);
			end
			
			m = zeros(T, 1);
			for i=1:T
			    m(i) = sum(A{i}(:));
			end
			A = blkdiag(A{:});
			kout = sum(A,1);
			koutmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kout);
			kin = sum(A,2);
			kinmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kin);
			A = (A+A')./2;
			all2all = N*[(-T+1):-1,1:(T-1)];
			A = A + omega*spdiags(ones(N*T, 2*T-2), all2all, N*T, N*T);
			
			OM = @(i) A(:,i) - gamma(ceil(i./(N+eps))).*(kout(i).*kinmat(:,ceil(i./(N+eps))) + kin(i).*koutmat(:, ceil(i./(N+eps))))./(2*m(ceil(i./(N+eps))));
			twom = sum(m) + omega*2*N*(T-1);
			end
			function M = metanetwork(m, J, S)
			% METANETWORK returns the new aggregated network (communities --> nodes)
			%
			% [B, twom] = METANETWORK(J, S) returns the new aggregated
			% network (communities --> nodes)
			
			PP = sparse(1:length(S), S, 1);
			M = PP'*J*PP;
			end
			function Mi = metanetwork_i(m, J, i)
			% METANETWORKI returns the ith column of the metanetwork
			%
			% [B, twom] = METANETWORKI(J, S) returns the ith column of
			% the metanetwork. J is a function handle
			
			ind = metanetwork_reduce('nodes',i);
			for j=ind(:)'
			    metanetwork_reduce('reduce',J(j));
			end
			Mi = metanetwork_reduce('return');
			end
		end
	end
end
