classdef Flexibility < MultilayerCommunity
	%Flexibility is the graph Flexibility.
	% It is a subclass of <a href="matlab:help MultilayerCommunity">MultilayerCommunity</a>.
	%
	% The Flexibility (Flexibility) of each node in a multilayer network is calculated 
	% as the number of times that it changes community assignment, 
	% normalized by the total possible number of changes. In ordered 
	% multilayer networks (e.g. temporal, changes are possible only between 
	% adjacent layers, whereas in categorical multilayer networks, 
	% community assignment changes are possible between any pairs of layers.
	%
	% The list of Flexibility properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Flexibility.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Flexibility.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Flexibility.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Flexibility.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Flexibility.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Flexibility.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Flexibility.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.SUPERGLOBAL.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Flexibility.
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
	% Flexibility methods (constructor):
	%  Flexibility - constructor
	%
	% Flexibility methods:
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
	% Flexibility methods (display):
	%  tostring - string with information about the flexibility
	%  disp - displays information about the flexibility
	%  tree - displays the tree of the flexibility
	%
	% Flexibility methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two flexibility are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the flexibility
	%
	% Flexibility methods (save/load, Static):
	%  save - saves BRAPH2 flexibility as b2 file
	%  load - loads a BRAPH2 flexibility from a b2 file
	%
	% Flexibility method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the flexibility
	%
	% Flexibility method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the flexibility
	%
	% Flexibility methods (inspection, Static):
	%  getClass - returns the class of the flexibility
	%  getSubclasses - returns all subclasses of Flexibility
	%  getProps - returns the property list of the flexibility
	%  getPropNumber - returns the property number of the flexibility
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
	% Flexibility methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Flexibility methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Flexibility methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Flexibility methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Flexibility; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Flexibility constants</a>.
	%
	
	methods % constructor
		function m = Flexibility(varargin)
			%Flexibility() creates a flexibility.
			%
			% Flexibility(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Flexibility(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Flexibility properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Flexibility.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Flexibility.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Flexibility.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Flexibility.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Flexibility.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Flexibility.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Flexibility.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.SUPERGLOBAL.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Flexibility.
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
			%GETBUILD returns the build of the flexibility.
			%
			% BUILD = Flexibility.GETBUILD() returns the build of 'Flexibility'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the flexibility M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('Flexibility') returns the build of 'Flexibility'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('Flexibility')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the flexibility.
			%
			% CLASS = Flexibility.GETCLASS() returns the class 'Flexibility'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the flexibility M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Flexibility') returns 'Flexibility'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('Flexibility')
			%  are less computationally efficient.
			
			m_class = 'Flexibility';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the flexibility.
			%
			% LIST = Flexibility.GETSUBCLASSES() returns all subclasses of 'Flexibility'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the flexibility M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('Flexibility') returns all subclasses of 'Flexibility'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('Flexibility')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'Flexibility'  'FlexibilityAv' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of flexibility.
			%
			% PROPS = Flexibility.GETPROPS() returns the property list of flexibility
			%  as a row vector.
			%
			% PROPS = Flexibility.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the flexibility M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Flexibility'[, CATEGORY]) returns the property list of 'Flexibility'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('Flexibility')
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
			%GETPROPNUMBER returns the property number of flexibility.
			%
			% N = Flexibility.GETPROPNUMBER() returns the property number of flexibility.
			%
			% N = Flexibility.GETPROPNUMBER(CATEGORY) returns the property number of flexibility
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the flexibility M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Flexibility') returns the property number of 'Flexibility'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('Flexibility')
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
			%EXISTSPROP checks whether property exists in flexibility/error.
			%
			% CHECK = Flexibility.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Flexibility, PROP) checks whether PROP exists for Flexibility.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Flexibility:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Flexibility:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Flexibility:WrongInput]
			%  Element.EXISTSPROP(Flexibility, PROP) throws error if PROP does NOT exist for Flexibility.
			%   Error id: [BRAPH2:Flexibility:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('Flexibility')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 23 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Flexibility:' 'WrongInput'], ...
					['BRAPH2' ':Flexibility:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Flexibility.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in flexibility/error.
			%
			% CHECK = Flexibility.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Flexibility, TAG) checks whether TAG exists for Flexibility.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Flexibility:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Flexibility:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Flexibility:WrongInput]
			%  Element.EXISTSTAG(Flexibility, TAG) throws error if TAG does NOT exist for Flexibility.
			%   Error id: [BRAPH2:Flexibility:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('Flexibility')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'LIMIT'  'RANDORD'  'RANDMOVE'  'GAMMA'  'OMEGA'  'S0'  'OM'  'QUALITY_FUNCTION' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Flexibility:' 'WrongInput'], ...
					['BRAPH2' ':Flexibility:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for Flexibility.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Flexibility, POINTER) returns property number of POINTER of Flexibility.
			%  PROPERTY = M.GETPROPPROP(Flexibility, POINTER) returns property number of POINTER of Flexibility.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('Flexibility')
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
			%  TAG = Element.GETPROPTAG(Flexibility, POINTER) returns tag of POINTER of Flexibility.
			%  TAG = M.GETPROPTAG(Flexibility, POINTER) returns tag of POINTER of Flexibility.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('Flexibility')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				flexibility_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'LIMIT'  'RANDORD'  'RANDMOVE'  'GAMMA'  'OMEGA'  'S0'  'OM'  'QUALITY_FUNCTION' };
				tag = flexibility_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(Flexibility, POINTER) returns category of POINTER of Flexibility.
			%  CATEGORY = M.GETPROPCATEGORY(Flexibility, POINTER) returns category of POINTER of Flexibility.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('Flexibility')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Flexibility.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			flexibility_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3  3  3  3  3  4  4  4 };
			prop_category = flexibility_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(Flexibility, POINTER) returns format of POINTER of Flexibility.
			%  FORMAT = M.GETPROPFORMAT(Flexibility, POINTER) returns format of POINTER of Flexibility.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('Flexibility')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Flexibility.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			flexibility_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  11  4  4  11  11  13  14  14 };
			prop_format = flexibility_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Flexibility, POINTER) returns description of POINTER of Flexibility.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Flexibility, POINTER) returns description of POINTER of Flexibility.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('Flexibility')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Flexibility.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			flexibility_description_list = { 'ELCLASS (constant, string) is the class of the Flexibility.'  'NAME (constant, string) is the name of the Flexibility.'  'DESCRIPTION (constant, string) is the description of the Flexibility.'  'TEMPLATE (parameter, item) is the template of the Flexibility.'  'ID (data, string) is a few-letter code of the Flexibility.'  'LABEL (metadata, string) is an extended label of the Flexibility.'  'NOTES (metadata, string) are some specific notes about the Flexibility.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.SUPERGLOBAL.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Flexibility.'  'PFM (gui, item) contains the panel figure of the measure.'  'LIMIT (parameter, SCALAR) is the maximum size of multilayer modularity matrix.'  'RANDORD (parameter, LOGICAL) is used to set randperm.'  'RANDMOVE (parameter, LOGICAL) is the move function.'  'GAMMA (parameter, SCALAR) is the resolution parameter.'  'OMEGA (parameter, SCALAR) is the inter-layer coupling parameter.'  'S0 (data, cvector) is the initial partition size of the multilayer modularity matrix.'  'OM (data, MATRIX) is the multilayer modularity matrix.'  'QUALITY_FUNCTION (data, MATRIX) is the multilayer modularity quality function.' };
			prop_description = flexibility_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(Flexibility, POINTER) returns settings of POINTER of Flexibility.
			%  SETTINGS = M.GETPROPSETTINGS(Flexibility, POINTER) returns settings of POINTER of Flexibility.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('Flexibility')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Flexibility.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % Flexibility.TEMPLATE
					prop_settings = 'Flexibility';
				otherwise
					prop_settings = getPropSettings@MultilayerCommunity(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Flexibility.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Flexibility.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Flexibility, POINTER) returns the default value of POINTER of Flexibility.
			%  DEFAULT = M.GETPROPDEFAULT(Flexibility, POINTER) returns the default value of POINTER of Flexibility.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('Flexibility')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Flexibility.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % Flexibility.ELCLASS
					prop_default = 'Flexibility';
				case 2 % Flexibility.NAME
					prop_default = 'Flexibility';
				case 3 % Flexibility.DESCRIPTION
					prop_default = 'The Flexibility (Flexibility) of each node in a multilayer network is calculated as the number of times that it changes community assignment, normalized by the total possible number of changes. In ordered multilayer networks (e.g. temporal, changes are possible only between adjacent layers, whereas in categorical multilayer networks, community assignment changes are possible between any pairs of layers.';
				case 4 % Flexibility.TEMPLATE
					prop_default = Format.getFormatDefault(8, Flexibility.getPropSettings(prop));
				case 5 % Flexibility.ID
					prop_default = 'Flexibility ID';
				case 6 % Flexibility.LABEL
					prop_default = 'Flexibility label';
				case 7 % Flexibility.NOTES
					prop_default = 'Flexibility notes';
				case 9 % Flexibility.SHAPE
					prop_default = 2;
				case 10 % Flexibility.SCOPE
					prop_default = 1;
				case 11 % Flexibility.PARAMETRICITY
					prop_default = 2;
				case 12 % Flexibility.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexWD' 'OrdMxWU' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUT' 'MultiplexBUD' 'MultilayerBU' 'MultilayerWU' 'OrdMlWU'};;
				otherwise
					prop_default = getPropDefault@MultilayerCommunity(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Flexibility.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Flexibility.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Flexibility, POINTER) returns the conditioned default value of POINTER of Flexibility.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Flexibility, POINTER) returns the conditioned default value of POINTER of Flexibility.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('Flexibility')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Flexibility.getPropProp(pointer);
			
			prop_default = Flexibility.conditioning(prop, Flexibility.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Flexibility, PROP, VALUE) checks VALUE format for PROP of Flexibility.
			%  CHECK = M.CHECKPROP(Flexibility, PROP, VALUE) checks VALUE format for PROP of Flexibility.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:Flexibility:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:Flexibility:WrongInput
			%  Element.CHECKPROP(Flexibility, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Flexibility.
			%   Error id: BRAPH2:Flexibility:WrongInput
			%  M.CHECKPROP(Flexibility, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Flexibility.
			%   Error id: BRAPH2:Flexibility:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('Flexibility')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Flexibility.getPropProp(pointer);
			
			switch prop
				case 4 % Flexibility.TEMPLATE
					check = Format.checkFormat(8, value, Flexibility.getPropSettings(prop));
				otherwise
					if prop <= 23
						check = checkProp@MultilayerCommunity(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Flexibility:' 'WrongInput'], ...
					['BRAPH2' ':Flexibility:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Flexibility.getPropTag(prop) ' (' Flexibility.getFormatTag(Flexibility.getPropFormat(prop)) ').'] ...
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
				case 14 % Flexibility.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					if isempty(N)
					    N(1) = 1;
					end
					N = N(1);
					S = calculateValue@MultilayerCommunity(m, prop);
					S = cell2mat(S');
					flexibility = zeros(N, 1);
					
					if g.get('GRAPH_TYPE') == 4 || g.get('GRAPH_TYPE') ==6
					    % categorical 
					    for i=1:L
					        otherlayers = 1:L;
					        otherlayers = otherlayers(otherlayers~=i); % all layers except the current one
					        flexibility = flexibility + sum(repmat(S(:,i),1, (L-1)) ~= S(:,otherlayers), 2);
					    end    
					    flexibility = flexibility/(L*(L-1));
					elseif g.get('GRAPH_TYPE') == 3 || g.get('GRAPH_TYPE') ==5
					    % ordinal 
					    for i=1:L-1
					        flexibility = flexibility + S(:, i) ~= S(:, i+1);
					    end
					    flexibility = flexibility/(L-1);
					end
					
					value = {flexibility};
					
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
