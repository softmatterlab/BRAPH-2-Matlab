classdef FlexibilityAv < Flexibility
	%FlexibilityAv is the graph Average Flexibility.
	% It is a subclass of <a href="matlab:help Flexibility">Flexibility</a>.
	%
	% The Average Flexibility (FlexibilityAv) of a multilayer graph is the average of the flexibility 
	% of all nodes.
	%
	% The list of FlexibilityAv properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Average Flexibility.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Average Flexibility.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Average Flexibility.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Average Flexibility.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Average Flexibility.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Average Flexibility.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Average Flexibility.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.SUPERGLOBAL.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Average Flexibility.
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
	% FlexibilityAv methods (constructor):
	%  FlexibilityAv - constructor
	%
	% FlexibilityAv methods:
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
	% FlexibilityAv methods (display):
	%  tostring - string with information about the average flexibility
	%  disp - displays information about the average flexibility
	%  tree - displays the tree of the average flexibility
	%
	% FlexibilityAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average flexibility are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average flexibility
	%
	% FlexibilityAv methods (save/load, Static):
	%  save - saves BRAPH2 average flexibility as b2 file
	%  load - loads a BRAPH2 average flexibility from a b2 file
	%
	% FlexibilityAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average flexibility
	%
	% FlexibilityAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average flexibility
	%
	% FlexibilityAv methods (inspection, Static):
	%  getClass - returns the class of the average flexibility
	%  getSubclasses - returns all subclasses of FlexibilityAv
	%  getProps - returns the property list of the average flexibility
	%  getPropNumber - returns the property number of the average flexibility
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
	% FlexibilityAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% FlexibilityAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% FlexibilityAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% FlexibilityAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?FlexibilityAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">FlexibilityAv constants</a>.
	%
	
	methods % constructor
		function m = FlexibilityAv(varargin)
			%FlexibilityAv() creates a average flexibility.
			%
			% FlexibilityAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% FlexibilityAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of FlexibilityAv properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Average Flexibility.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Average Flexibility.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Average Flexibility.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Average Flexibility.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Average Flexibility.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Average Flexibility.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Average Flexibility.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.SUPERGLOBAL.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Average Flexibility.
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
			
			m = m@Flexibility(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the average flexibility.
			%
			% BUILD = FlexibilityAv.GETBUILD() returns the build of 'FlexibilityAv'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the average flexibility M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('FlexibilityAv') returns the build of 'FlexibilityAv'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('FlexibilityAv')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the average flexibility.
			%
			% CLASS = FlexibilityAv.GETCLASS() returns the class 'FlexibilityAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average flexibility M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('FlexibilityAv') returns 'FlexibilityAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('FlexibilityAv')
			%  are less computationally efficient.
			
			m_class = 'FlexibilityAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average flexibility.
			%
			% LIST = FlexibilityAv.GETSUBCLASSES() returns all subclasses of 'FlexibilityAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average flexibility M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('FlexibilityAv') returns all subclasses of 'FlexibilityAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('FlexibilityAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'FlexibilityAv' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average flexibility.
			%
			% PROPS = FlexibilityAv.GETPROPS() returns the property list of average flexibility
			%  as a row vector.
			%
			% PROPS = FlexibilityAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average flexibility M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('FlexibilityAv'[, CATEGORY]) returns the property list of 'FlexibilityAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('FlexibilityAv')
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
			%GETPROPNUMBER returns the property number of average flexibility.
			%
			% N = FlexibilityAv.GETPROPNUMBER() returns the property number of average flexibility.
			%
			% N = FlexibilityAv.GETPROPNUMBER(CATEGORY) returns the property number of average flexibility
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average flexibility M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('FlexibilityAv') returns the property number of 'FlexibilityAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('FlexibilityAv')
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
			%EXISTSPROP checks whether property exists in average flexibility/error.
			%
			% CHECK = FlexibilityAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(FlexibilityAv, PROP) checks whether PROP exists for FlexibilityAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:FlexibilityAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:FlexibilityAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:FlexibilityAv:WrongInput]
			%  Element.EXISTSPROP(FlexibilityAv, PROP) throws error if PROP does NOT exist for FlexibilityAv.
			%   Error id: [BRAPH2:FlexibilityAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('FlexibilityAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 23 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':FlexibilityAv:' 'WrongInput'], ...
					['BRAPH2' ':FlexibilityAv:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for FlexibilityAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average flexibility/error.
			%
			% CHECK = FlexibilityAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(FlexibilityAv, TAG) checks whether TAG exists for FlexibilityAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:FlexibilityAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:FlexibilityAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:FlexibilityAv:WrongInput]
			%  Element.EXISTSTAG(FlexibilityAv, TAG) throws error if TAG does NOT exist for FlexibilityAv.
			%   Error id: [BRAPH2:FlexibilityAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('FlexibilityAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'LIMIT'  'RANDORD'  'RANDMOVE'  'GAMMA'  'OMEGA'  'S0'  'OM'  'QUALITY_FUNCTION' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':FlexibilityAv:' 'WrongInput'], ...
					['BRAPH2' ':FlexibilityAv:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for FlexibilityAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(FlexibilityAv, POINTER) returns property number of POINTER of FlexibilityAv.
			%  PROPERTY = M.GETPROPPROP(FlexibilityAv, POINTER) returns property number of POINTER of FlexibilityAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('FlexibilityAv')
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
			%  TAG = Element.GETPROPTAG(FlexibilityAv, POINTER) returns tag of POINTER of FlexibilityAv.
			%  TAG = M.GETPROPTAG(FlexibilityAv, POINTER) returns tag of POINTER of FlexibilityAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('FlexibilityAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				flexibilityav_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'LIMIT'  'RANDORD'  'RANDMOVE'  'GAMMA'  'OMEGA'  'S0'  'OM'  'QUALITY_FUNCTION' };
				tag = flexibilityav_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(FlexibilityAv, POINTER) returns category of POINTER of FlexibilityAv.
			%  CATEGORY = M.GETPROPCATEGORY(FlexibilityAv, POINTER) returns category of POINTER of FlexibilityAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('FlexibilityAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = FlexibilityAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			flexibilityav_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3  3  3  3  3  4  4  4 };
			prop_category = flexibilityav_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(FlexibilityAv, POINTER) returns format of POINTER of FlexibilityAv.
			%  FORMAT = M.GETPROPFORMAT(FlexibilityAv, POINTER) returns format of POINTER of FlexibilityAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('FlexibilityAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = FlexibilityAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			flexibilityav_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  11  4  4  11  11  13  14  14 };
			prop_format = flexibilityav_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(FlexibilityAv, POINTER) returns description of POINTER of FlexibilityAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(FlexibilityAv, POINTER) returns description of POINTER of FlexibilityAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('FlexibilityAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = FlexibilityAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			flexibilityav_description_list = { 'ELCLASS (constant, string) is the class of the Average Flexibility.'  'NAME (constant, string) is the name of the Average Flexibility.'  'DESCRIPTION (constant, string) is the description of the Average Flexibility.'  'TEMPLATE (parameter, item) is the template of the Average Flexibility.'  'ID (data, string) is a few-letter code of the Average Flexibility.'  'LABEL (metadata, string) is an extended label of the Average Flexibility.'  'NOTES (metadata, string) are some specific notes about the Average Flexibility.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.'  'SCOPE (constant, scalar) is the measure scope Measure.SUPERGLOBAL.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Average Flexibility.'  'PFM (gui, item) contains the panel figure of the measure.'  'LIMIT (parameter, SCALAR) is the maximum size of multilayer modularity matrix.'  'RANDORD (parameter, LOGICAL) is used to set randperm.'  'RANDMOVE (parameter, LOGICAL) is the move function.'  'GAMMA (parameter, SCALAR) is the resolution parameter.'  'OMEGA (parameter, SCALAR) is the inter-layer coupling parameter.'  'S0 (data, cvector) is the initial partition size of the multilayer modularity matrix.'  'OM (data, MATRIX) is the multilayer modularity matrix.'  'QUALITY_FUNCTION (data, MATRIX) is the multilayer modularity quality function.' };
			prop_description = flexibilityav_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(FlexibilityAv, POINTER) returns settings of POINTER of FlexibilityAv.
			%  SETTINGS = M.GETPROPSETTINGS(FlexibilityAv, POINTER) returns settings of POINTER of FlexibilityAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('FlexibilityAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = FlexibilityAv.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % FlexibilityAv.TEMPLATE
					prop_settings = 'FlexibilityAv';
				otherwise
					prop_settings = getPropSettings@Flexibility(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = FlexibilityAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = FlexibilityAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(FlexibilityAv, POINTER) returns the default value of POINTER of FlexibilityAv.
			%  DEFAULT = M.GETPROPDEFAULT(FlexibilityAv, POINTER) returns the default value of POINTER of FlexibilityAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('FlexibilityAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = FlexibilityAv.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % FlexibilityAv.ELCLASS
					prop_default = 'FlexibilityAv';
				case 2 % FlexibilityAv.NAME
					prop_default = 'Average Flexibility';
				case 3 % FlexibilityAv.DESCRIPTION
					prop_default = 'The Average Flexibility (FlexibilityAv) of a multilayer graph is the average of the flexibility of all nodes.';
				case 4 % FlexibilityAv.TEMPLATE
					prop_default = Format.getFormatDefault(8, FlexibilityAv.getPropSettings(prop));
				case 5 % FlexibilityAv.ID
					prop_default = 'FlexibilityAv ID';
				case 6 % FlexibilityAv.LABEL
					prop_default = 'Average Flexibility label';
				case 7 % FlexibilityAv.NOTES
					prop_default = 'Average Flexibility notes';
				case 9 % FlexibilityAv.SHAPE
					prop_default = 1;
				case 10 % FlexibilityAv.SCOPE
					prop_default = 1;
				case 11 % FlexibilityAv.PARAMETRICITY
					prop_default = 2;
				case 12 % FlexibilityAv.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexWD' 'OrdMxWU' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUT' 'MultiplexBUD' 'MultilayerBU' 'MultilayerWU' 'OrdMlWU'};;
				otherwise
					prop_default = getPropDefault@Flexibility(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = FlexibilityAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = FlexibilityAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(FlexibilityAv, POINTER) returns the conditioned default value of POINTER of FlexibilityAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(FlexibilityAv, POINTER) returns the conditioned default value of POINTER of FlexibilityAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('FlexibilityAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = FlexibilityAv.getPropProp(pointer);
			
			prop_default = FlexibilityAv.conditioning(prop, FlexibilityAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(FlexibilityAv, PROP, VALUE) checks VALUE format for PROP of FlexibilityAv.
			%  CHECK = M.CHECKPROP(FlexibilityAv, PROP, VALUE) checks VALUE format for PROP of FlexibilityAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:FlexibilityAv:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:FlexibilityAv:WrongInput
			%  Element.CHECKPROP(FlexibilityAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of FlexibilityAv.
			%   Error id: BRAPH2:FlexibilityAv:WrongInput
			%  M.CHECKPROP(FlexibilityAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of FlexibilityAv.
			%   Error id: BRAPH2:FlexibilityAv:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('FlexibilityAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = FlexibilityAv.getPropProp(pointer);
			
			switch prop
				case 4 % FlexibilityAv.TEMPLATE
					check = Format.checkFormat(8, value, FlexibilityAv.getPropSettings(prop));
				otherwise
					if prop <= 23
						check = checkProp@Flexibility(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':FlexibilityAv:' 'WrongInput'], ...
					['BRAPH2' ':FlexibilityAv:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' FlexibilityAv.getPropTag(prop) ' (' FlexibilityAv.getFormatTag(FlexibilityAv.getPropFormat(prop)) ').'] ...
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
				case 14 % FlexibilityAv.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					flexibility_av = calculateValue@Flexibility(m, prop);
					flexibility_av = {mean(flexibility_av{1})};
					
					value = flexibility_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 23
						value = calculateValue@Flexibility(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
