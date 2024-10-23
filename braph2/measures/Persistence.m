classdef Persistence < MultilayerCommunity
	%Persistence is the graph Persistence.
	% It is a subclass of <a href="matlab:help MultilayerCommunity">MultilayerCommunity</a>.
	%
	% The Persistence (Persistence) of a multilayer network is calculated as the normalized 
	% sum of the number of nodes that do not change community assignments. It 
	% varies between 0 and 1. 
	% In categorical multilayer networks, it is the sum over all pairs of layers 
	% of the number of nodes that do not change community assignments, whereas 
	% in ordinal multilayer networks (e.g. temporal), it is the number of nodes 
	% that do not change community assignments between consecutive layers.
	%
	% The list of Persistence properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Persistence.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Persistence.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Persistence.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Persistence.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Persistence.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Persistence.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Persistence.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the categorical Persistence.
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
	% Persistence methods (constructor):
	%  Persistence - constructor
	%
	% Persistence methods:
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
	% Persistence methods (display):
	%  tostring - string with information about the persistence
	%  disp - displays information about the persistence
	%  tree - displays the tree of the persistence
	%
	% Persistence methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two persistence are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the persistence
	%
	% Persistence methods (save/load, Static):
	%  save - saves BRAPH2 persistence as b2 file
	%  load - loads a BRAPH2 persistence from a b2 file
	%
	% Persistence method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the persistence
	%
	% Persistence method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the persistence
	%
	% Persistence methods (inspection, Static):
	%  getClass - returns the class of the persistence
	%  getSubclasses - returns all subclasses of Persistence
	%  getProps - returns the property list of the persistence
	%  getPropNumber - returns the property number of the persistence
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
	% Persistence methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Persistence methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Persistence methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Persistence methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Persistence; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Persistence constants</a>.
	%
	
	methods % constructor
		function m = Persistence(varargin)
			%Persistence() creates a persistence.
			%
			% Persistence(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Persistence(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Persistence properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Persistence.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Persistence.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Persistence.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Persistence.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Persistence.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Persistence.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Persistence.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the categorical Persistence.
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
			
			m = m@MultilayerCommunity(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the persistence.
			%
			% BUILD = Persistence.GETBUILD() returns the build of 'Persistence'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the persistence M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('Persistence') returns the build of 'Persistence'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('Persistence')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the persistence.
			%
			% CLASS = Persistence.GETCLASS() returns the class 'Persistence'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the persistence M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Persistence') returns 'Persistence'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('Persistence')
			%  are less computationally efficient.
			
			m_class = 'Persistence';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the persistence.
			%
			% LIST = Persistence.GETSUBCLASSES() returns all subclasses of 'Persistence'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the persistence M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('Persistence') returns all subclasses of 'Persistence'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('Persistence')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'Persistence' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of persistence.
			%
			% PROPS = Persistence.GETPROPS() returns the property list of persistence
			%  as a row vector.
			%
			% PROPS = Persistence.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the persistence M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Persistence'[, CATEGORY]) returns the property list of 'Persistence'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('Persistence')
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
			%GETPROPNUMBER returns the property number of persistence.
			%
			% N = Persistence.GETPROPNUMBER() returns the property number of persistence.
			%
			% N = Persistence.GETPROPNUMBER(CATEGORY) returns the property number of persistence
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the persistence M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Persistence') returns the property number of 'Persistence'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('Persistence')
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
			%EXISTSPROP checks whether property exists in persistence/error.
			%
			% CHECK = Persistence.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Persistence, PROP) checks whether PROP exists for Persistence.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Persistence:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Persistence:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Persistence:WrongInput]
			%  Element.EXISTSPROP(Persistence, PROP) throws error if PROP does NOT exist for Persistence.
			%   Error id: [BRAPH2:Persistence:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('Persistence')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 23 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Persistence:' 'WrongInput'], ...
					['BRAPH2' ':Persistence:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Persistence.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in persistence/error.
			%
			% CHECK = Persistence.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Persistence, TAG) checks whether TAG exists for Persistence.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Persistence:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Persistence:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Persistence:WrongInput]
			%  Element.EXISTSTAG(Persistence, TAG) throws error if TAG does NOT exist for Persistence.
			%   Error id: [BRAPH2:Persistence:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('Persistence')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'LIMIT'  'RANDORD'  'RANDMOVE'  'GAMMA'  'OMEGA'  'S0'  'OM'  'QUALITY_FUNCTION' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Persistence:' 'WrongInput'], ...
					['BRAPH2' ':Persistence:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for Persistence.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Persistence, POINTER) returns property number of POINTER of Persistence.
			%  PROPERTY = M.GETPROPPROP(Persistence, POINTER) returns property number of POINTER of Persistence.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('Persistence')
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
			%  TAG = Element.GETPROPTAG(Persistence, POINTER) returns tag of POINTER of Persistence.
			%  TAG = M.GETPROPTAG(Persistence, POINTER) returns tag of POINTER of Persistence.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('Persistence')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				persistence_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'LIMIT'  'RANDORD'  'RANDMOVE'  'GAMMA'  'OMEGA'  'S0'  'OM'  'QUALITY_FUNCTION' };
				tag = persistence_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(Persistence, POINTER) returns category of POINTER of Persistence.
			%  CATEGORY = M.GETPROPCATEGORY(Persistence, POINTER) returns category of POINTER of Persistence.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('Persistence')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Persistence.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			persistence_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3  3  3  3  3  4  4  4 };
			prop_category = persistence_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(Persistence, POINTER) returns format of POINTER of Persistence.
			%  FORMAT = M.GETPROPFORMAT(Persistence, POINTER) returns format of POINTER of Persistence.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('Persistence')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Persistence.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			persistence_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  11  4  4  11  11  13  14  14 };
			prop_format = persistence_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Persistence, POINTER) returns description of POINTER of Persistence.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Persistence, POINTER) returns description of POINTER of Persistence.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('Persistence')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Persistence.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			persistence_description_list = { 'ELCLASS (constant, string) is the class of the Persistence.'  'NAME (constant, string) is the name of the Persistence.'  'DESCRIPTION (constant, string) is the description of the Persistence.'  'TEMPLATE (parameter, item) is the template of the Persistence.'  'ID (data, string) is a few-letter code of the Persistence.'  'LABEL (metadata, string) is an extended label of the Persistence.'  'NOTES (metadata, string) are some specific notes about the Persistence.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the categorical Persistence.'  'PFM (gui, item) contains the panel figure of the measure.'  'LIMIT (parameter, SCALAR) is the maximum size of multilayer modularity matrix.'  'RANDORD (parameter, LOGICAL) is used to set randperm.'  'RANDMOVE (parameter, LOGICAL) is the move function.'  'GAMMA (parameter, SCALAR) is the resolution parameter.'  'OMEGA (parameter, SCALAR) is the inter-layer coupling parameter.'  'S0 (data, cvector) is the initial partition size of the multilayer modularity matrix.'  'OM (data, MATRIX) is the multilayer modularity matrix.'  'QUALITY_FUNCTION (data, MATRIX) is the multilayer modularity quality function.' };
			prop_description = persistence_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(Persistence, POINTER) returns settings of POINTER of Persistence.
			%  SETTINGS = M.GETPROPSETTINGS(Persistence, POINTER) returns settings of POINTER of Persistence.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('Persistence')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Persistence.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % Persistence.TEMPLATE
					prop_settings = 'Persistence';
				otherwise
					prop_settings = getPropSettings@MultilayerCommunity(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Persistence.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Persistence.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Persistence, POINTER) returns the default value of POINTER of Persistence.
			%  DEFAULT = M.GETPROPDEFAULT(Persistence, POINTER) returns the default value of POINTER of Persistence.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('Persistence')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Persistence.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % Persistence.ELCLASS
					prop_default = 'Persistence';
				case 2 % Persistence.NAME
					prop_default = 'Persistence';
				case 3 % Persistence.DESCRIPTION
					prop_default = 'The Persistence (Persistence) of a multilayer network is calculated as the normalized sum of the number of nodes that do not change community assignments. It varies between 0 and 1. In categorical multilayer networks, it is the sum over all pairs of layers of the number of nodes that do not change community assignments, whereas in ordinal multilayer networks (e.g. temporal), it is the number of nodes that do not change community assignments between consecutive layers.';
				case 4 % Persistence.TEMPLATE
					prop_default = Format.getFormatDefault(8, Persistence.getPropSettings(prop));
				case 5 % Persistence.ID
					prop_default = 'Persistence ID';
				case 6 % Persistence.LABEL
					prop_default = 'Persistence label';
				case 7 % Persistence.NOTES
					prop_default = 'Persistence notes';
				case 9 % Persistence.SHAPE
					prop_default = 1;
				case 10 % Persistence.SCOPE
					prop_default = 1;
				case 11 % Persistence.PARAMETRICITY
					prop_default = 2;
				case 12 % Persistence.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexWD' 'OrdMxWU' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUT' 'MultiplexBUD' 'MultilayerBU' 'MultilayerWU' 'OrdMlWU'};;
				otherwise
					prop_default = getPropDefault@MultilayerCommunity(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Persistence.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Persistence.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Persistence, POINTER) returns the conditioned default value of POINTER of Persistence.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Persistence, POINTER) returns the conditioned default value of POINTER of Persistence.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('Persistence')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Persistence.getPropProp(pointer);
			
			prop_default = Persistence.conditioning(prop, Persistence.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Persistence, PROP, VALUE) checks VALUE format for PROP of Persistence.
			%  CHECK = M.CHECKPROP(Persistence, PROP, VALUE) checks VALUE format for PROP of Persistence.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:Persistence:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:Persistence:WrongInput
			%  Element.CHECKPROP(Persistence, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Persistence.
			%   Error id: BRAPH2:Persistence:WrongInput
			%  M.CHECKPROP(Persistence, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Persistence.
			%   Error id: BRAPH2:Persistence:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('Persistence')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Persistence.getPropProp(pointer);
			
			switch prop
				case 4 % Persistence.TEMPLATE
					check = Format.checkFormat(8, value, Persistence.getPropSettings(prop));
				otherwise
					if prop <= 23
						check = checkProp@MultilayerCommunity(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Persistence:' 'WrongInput'], ...
					['BRAPH2' ':Persistence:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Persistence.getPropTag(prop) ' (' Persistence.getFormatTag(Persistence.getPropFormat(prop)) ').'] ...
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
				case 14 % Persistence.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					graph_type = g.get('GRAPH_TYPE');
					if isempty(N)
					    N(1) = 1;
					end
					N = N(1);
					%S = MultilayerCommunity('G', g).get('M');
					S = calculateValue@MultilayerCommunity(m, prop);
					S = cell2mat(S');
					S = {S};
					persistence = zeros(length(S), 1); 
					
					if graph_type == 4 || graph_type == 6
					    % categorical  
					    all2all = N*[(-L+1):-1,1:(L-1)];
					    A = spdiags(ones(N*L, 2*L-2), all2all, N*L, N*L);
					    for i = 1:length(S)
					        G = sparse(1:length(S{i}(:)), S{i}(:), 1);
					        persistence(i) = trace(G'*A*G)/(N*L*(L-1));
					    end
					  
					elseif graph_type== 3|| graph_type== 5
					    % ordinal
					    for i = 1:length(S)
					        persistence(i) = sum(sum(S{i}(:,1:end-1)==S{i}(:,2:end)))/(N*(L-1));
					    end 
					end
					value = {persistence};
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 23
						value = calculateValue@MultilayerCommunity(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
