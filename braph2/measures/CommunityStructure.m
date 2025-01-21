classdef CommunityStructure < Measure
	%CommunityStructure is the graph Community Structure.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Community Structure (CommunityStructure) of a graph is a subdivision of the network into 
	% non-overlapping groups of nodes which maximizes the number of within group 
	% edges, and minimizes the number of between group edges.
	%
	% The list of CommunityStructure properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Community Structure.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Community Structure.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Community Structure.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Community Structure.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Community Structure.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the community structure.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Community Structure.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Community Structure.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>16</strong> <strong>RULE</strong> 	RULE (parameter, option)
	%  <strong>17</strong> <strong>GAMMA</strong> 	GAMMA (parameter, SCALAR) is the resolution parameter.
	%  <strong>18</strong> <strong>M0</strong> 	M0 (data, rvector) is the initial community affiliation vector.
	%  <strong>19</strong> <strong>LOUVAIN_OM</strong> 	LOUVAIN_OM (data, MATRIX) is the custom objective matrix (Louvain).
	%  <strong>20</strong> <strong>OM_TYPE</strong> 	OM_TYPE (data, OPTION) is the objective-function type algorithm (Louvain).
	%  <strong>21</strong> <strong>QUALITY_FUNCTION</strong> 	QUALITY_FUNCTION (metadata, CELL)
	%
	% CommunityStructure methods (constructor):
	%  CommunityStructure - constructor
	%
	% CommunityStructure methods:
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
	% CommunityStructure methods (display):
	%  tostring - string with information about the community structure
	%  disp - displays information about the community structure
	%  tree - displays the tree of the community structure
	%
	% CommunityStructure methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two community structure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the community structure
	%
	% CommunityStructure methods (save/load, Static):
	%  save - saves BRAPH2 community structure as b2 file
	%  load - loads a BRAPH2 community structure from a b2 file
	%
	% CommunityStructure method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the community structure
	%
	% CommunityStructure method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the community structure
	%
	% CommunityStructure methods (inspection, Static):
	%  getClass - returns the class of the community structure
	%  getSubclasses - returns all subclasses of CommunityStructure
	%  getProps - returns the property list of the community structure
	%  getPropNumber - returns the property number of the community structure
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
	% CommunityStructure methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% CommunityStructure methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% CommunityStructure methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% CommunityStructure methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?CommunityStructure; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">CommunityStructure constants</a>.
	%
	
	properties (Constant) % properties
		RULE = 16; %CET: Computational Efficiency Trick
		RULE_TAG = 'RULE';
		RULE_CATEGORY = 3;
		RULE_FORMAT = 5;
		
		GAMMA = 17; %CET: Computational Efficiency Trick
		GAMMA_TAG = 'GAMMA';
		GAMMA_CATEGORY = 3;
		GAMMA_FORMAT = 11;
		
		M0 = 18; %CET: Computational Efficiency Trick
		M0_TAG = 'M0';
		M0_CATEGORY = 4;
		M0_FORMAT = 12;
		
		LOUVAIN_OM = 19; %CET: Computational Efficiency Trick
		LOUVAIN_OM_TAG = 'LOUVAIN_OM';
		LOUVAIN_OM_CATEGORY = 4;
		LOUVAIN_OM_FORMAT = 14;
		
		OM_TYPE = 20; %CET: Computational Efficiency Trick
		OM_TYPE_TAG = 'OM_TYPE';
		OM_TYPE_CATEGORY = 4;
		OM_TYPE_FORMAT = 5;
		
		QUALITY_FUNCTION = 21; %CET: Computational Efficiency Trick
		QUALITY_FUNCTION_TAG = 'QUALITY_FUNCTION';
		QUALITY_FUNCTION_CATEGORY = 2;
		QUALITY_FUNCTION_FORMAT = 16;
	end
	methods % constructor
		function m = CommunityStructure(varargin)
			%CommunityStructure() creates a community structure.
			%
			% CommunityStructure(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% CommunityStructure(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of CommunityStructure properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Community Structure.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Community Structure.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Community Structure.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Community Structure.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Community Structure.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the community structure.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Community Structure.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Community Structure.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>16</strong> <strong>RULE</strong> 	RULE (parameter, option)
			%  <strong>17</strong> <strong>GAMMA</strong> 	GAMMA (parameter, SCALAR) is the resolution parameter.
			%  <strong>18</strong> <strong>M0</strong> 	M0 (data, rvector) is the initial community affiliation vector.
			%  <strong>19</strong> <strong>LOUVAIN_OM</strong> 	LOUVAIN_OM (data, MATRIX) is the custom objective matrix (Louvain).
			%  <strong>20</strong> <strong>OM_TYPE</strong> 	OM_TYPE (data, OPTION) is the objective-function type algorithm (Louvain).
			%  <strong>21</strong> <strong>QUALITY_FUNCTION</strong> 	QUALITY_FUNCTION (metadata, CELL)
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the community structure.
			%
			% BUILD = CommunityStructure.GETBUILD() returns the build of 'CommunityStructure'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the community structure M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('CommunityStructure') returns the build of 'CommunityStructure'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('CommunityStructure')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the community structure.
			%
			% CLASS = CommunityStructure.GETCLASS() returns the class 'CommunityStructure'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the community structure M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('CommunityStructure') returns 'CommunityStructure'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('CommunityStructure')
			%  are less computationally efficient.
			
			m_class = 'CommunityStructure';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the community structure.
			%
			% LIST = CommunityStructure.GETSUBCLASSES() returns all subclasses of 'CommunityStructure'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the community structure M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('CommunityStructure') returns all subclasses of 'CommunityStructure'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'CommunityStructure'  'Modularity' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of community structure.
			%
			% PROPS = CommunityStructure.GETPROPS() returns the property list of community structure
			%  as a row vector.
			%
			% PROPS = CommunityStructure.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the community structure M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('CommunityStructure'[, CATEGORY]) returns the property list of 'CommunityStructure'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('CommunityStructure')
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
					prop_list = [1 2 3 9 10 11 12];
				case 2 % Category.METADATA
					prop_list = [6 7 21];
				case 3 % Category.PARAMETER
					prop_list = [4 16 17];
				case 4 % Category.DATA
					prop_list = [5 13 18 19 20];
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
			%GETPROPNUMBER returns the property number of community structure.
			%
			% N = CommunityStructure.GETPROPNUMBER() returns the property number of community structure.
			%
			% N = CommunityStructure.GETPROPNUMBER(CATEGORY) returns the property number of community structure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the community structure M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('CommunityStructure') returns the property number of 'CommunityStructure'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('CommunityStructure')
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
					prop_number = 7;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 3;
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
			%EXISTSPROP checks whether property exists in community structure/error.
			%
			% CHECK = CommunityStructure.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(CommunityStructure, PROP) checks whether PROP exists for CommunityStructure.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:CommunityStructure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%  Element.EXISTSPROP(CommunityStructure, PROP) throws error if PROP does NOT exist for CommunityStructure.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 21 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CommunityStructure:' 'WrongInput'], ...
					['BRAPH2' ':CommunityStructure:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for CommunityStructure.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in community structure/error.
			%
			% CHECK = CommunityStructure.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(CommunityStructure, TAG) checks whether TAG exists for CommunityStructure.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:CommunityStructure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%  Element.EXISTSTAG(CommunityStructure, TAG) throws error if TAG does NOT exist for CommunityStructure.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE'  'GAMMA'  'M0'  'LOUVAIN_OM'  'OM_TYPE'  'QUALITY_FUNCTION' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CommunityStructure:' 'WrongInput'], ...
					['BRAPH2' ':CommunityStructure:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for CommunityStructure.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(CommunityStructure, POINTER) returns property number of POINTER of CommunityStructure.
			%  PROPERTY = M.GETPROPPROP(CommunityStructure, POINTER) returns property number of POINTER of CommunityStructure.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE'  'GAMMA'  'M0'  'LOUVAIN_OM'  'OM_TYPE'  'QUALITY_FUNCTION' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(CommunityStructure, POINTER) returns tag of POINTER of CommunityStructure.
			%  TAG = M.GETPROPTAG(CommunityStructure, POINTER) returns tag of POINTER of CommunityStructure.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				communitystructure_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE'  'GAMMA'  'M0'  'LOUVAIN_OM'  'OM_TYPE'  'QUALITY_FUNCTION' };
				tag = communitystructure_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(CommunityStructure, POINTER) returns category of POINTER of CommunityStructure.
			%  CATEGORY = M.GETPROPCATEGORY(CommunityStructure, POINTER) returns category of POINTER of CommunityStructure.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			communitystructure_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3  3  4  4  4  2 };
			prop_category = communitystructure_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(CommunityStructure, POINTER) returns format of POINTER of CommunityStructure.
			%  FORMAT = M.GETPROPFORMAT(CommunityStructure, POINTER) returns format of POINTER of CommunityStructure.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			communitystructure_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  5  11  12  14  5  16 };
			prop_format = communitystructure_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CommunityStructure, POINTER) returns description of POINTER of CommunityStructure.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(CommunityStructure, POINTER) returns description of POINTER of CommunityStructure.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			communitystructure_description_list = { 'ELCLASS (constant, string) is the class of the Community Structure.'  'NAME (constant, string) is the name of the Community Structure.'  'DESCRIPTION (constant, string) is the description of the Community Structure.'  'TEMPLATE (parameter, item) is the template of the Community Structure.'  'ID (data, string) is a few-letter code of the Community Structure.'  'LABEL (metadata, string) is an extended label of the community structure.'  'NOTES (metadata, string) are some specific notes about the Community Structure.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Community Structure.'  'PFM (gui, item) contains the panel figure of the measure.'  'RULE (parameter, option)'  'GAMMA (parameter, SCALAR) is the resolution parameter.'  'M0 (data, rvector) is the initial community affiliation vector.'  'LOUVAIN_OM (data, MATRIX) is the custom objective matrix (Louvain).'  'OM_TYPE (data, OPTION) is the objective-function type algorithm (Louvain).'  'QUALITY_FUNCTION (metadata, CELL)' };
			prop_description = communitystructure_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(CommunityStructure, POINTER) returns settings of POINTER of CommunityStructure.
			%  SETTINGS = M.GETPROPSETTINGS(CommunityStructure, POINTER) returns settings of POINTER of CommunityStructure.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % CommunityStructure.RULE
					prop_settings = { 'louvain' 'newman' 'fixed'};
				case 17 % CommunityStructure.GAMMA
					prop_settings = Format.getFormatSettings(11);
				case 18 % CommunityStructure.M0
					prop_settings = Format.getFormatSettings(12);
				case 19 % CommunityStructure.LOUVAIN_OM
					prop_settings = Format.getFormatSettings(14);
				case 20 % CommunityStructure.OM_TYPE
					prop_settings = {'modularity' 'potts' 'negative_sym' 'negative_asym'};
				case 21 % CommunityStructure.QUALITY_FUNCTION
					prop_settings = Format.getFormatSettings(16);
				case 4 % CommunityStructure.TEMPLATE
					prop_settings = 'CommunityStructure';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = CommunityStructure.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = CommunityStructure.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(CommunityStructure, POINTER) returns the default value of POINTER of CommunityStructure.
			%  DEFAULT = M.GETPROPDEFAULT(CommunityStructure, POINTER) returns the default value of POINTER of CommunityStructure.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % CommunityStructure.RULE
					prop_default = 'louvain';
				case 17 % CommunityStructure.GAMMA
					prop_default = 1;
				case 18 % CommunityStructure.M0
					prop_default = [];
				case 19 % CommunityStructure.LOUVAIN_OM
					prop_default = [];
				case 20 % CommunityStructure.OM_TYPE
					prop_default = 'modularity';
				case 21 % CommunityStructure.QUALITY_FUNCTION
					prop_default = Format.getFormatDefault(16, CommunityStructure.getPropSettings(prop));
				case 1 % CommunityStructure.ELCLASS
					prop_default = 'CommunityStructure';
				case 2 % CommunityStructure.NAME
					prop_default = 'Community Structure';
				case 3 % CommunityStructure.DESCRIPTION
					prop_default = 'The Community Structure (CommunityStructure) of a graph is a subdivision of the network into non-overlapping groups of nodes which maximizes the number of within group edges, and minimizes the number of between group edges.';
				case 4 % CommunityStructure.TEMPLATE
					prop_default = Format.getFormatDefault(8, CommunityStructure.getPropSettings(prop));
				case 5 % CommunityStructure.ID
					prop_default = 'CommunityStructure ID';
				case 6 % CommunityStructure.LABEL
					prop_default = 'Community Structure label';
				case 7 % CommunityStructure.NOTES
					prop_default = 'Community Structure notes';
				case 9 % CommunityStructure.SHAPE
					prop_default = 2;
				case 10 % CommunityStructure.SCOPE
					prop_default = 2;
				case 11 % CommunityStructure.PARAMETRICITY
					prop_default = 2;
				case 12 % CommunityStructure.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT'} ;;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = CommunityStructure.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = CommunityStructure.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(CommunityStructure, POINTER) returns the conditioned default value of POINTER of CommunityStructure.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(CommunityStructure, POINTER) returns the conditioned default value of POINTER of CommunityStructure.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			prop_default = CommunityStructure.conditioning(prop, CommunityStructure.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(CommunityStructure, PROP, VALUE) checks VALUE format for PROP of CommunityStructure.
			%  CHECK = M.CHECKPROP(CommunityStructure, PROP, VALUE) checks VALUE format for PROP of CommunityStructure.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:CommunityStructure:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:CommunityStructure:WrongInput
			%  Element.CHECKPROP(CommunityStructure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CommunityStructure.
			%   Error id: BRAPH2:CommunityStructure:WrongInput
			%  M.CHECKPROP(CommunityStructure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CommunityStructure.
			%   Error id: BRAPH2:CommunityStructure:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			switch prop
				case 16 % CommunityStructure.RULE
					check = Format.checkFormat(5, value, CommunityStructure.getPropSettings(prop));
				case 17 % CommunityStructure.GAMMA
					check = Format.checkFormat(11, value, CommunityStructure.getPropSettings(prop));
				case 18 % CommunityStructure.M0
					check = Format.checkFormat(12, value, CommunityStructure.getPropSettings(prop));
				case 19 % CommunityStructure.LOUVAIN_OM
					check = Format.checkFormat(14, value, CommunityStructure.getPropSettings(prop));
				case 20 % CommunityStructure.OM_TYPE
					check = Format.checkFormat(5, value, CommunityStructure.getPropSettings(prop));
				case 21 % CommunityStructure.QUALITY_FUNCTION
					check = Format.checkFormat(16, value, CommunityStructure.getPropSettings(prop));
				case 4 % CommunityStructure.TEMPLATE
					check = Format.checkFormat(8, value, CommunityStructure.getPropSettings(prop));
				otherwise
					if prop <= 15
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CommunityStructure:' 'WrongInput'], ...
					['BRAPH2' ':CommunityStructure:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' CommunityStructure.getPropTag(prop) ' (' CommunityStructure.getFormatTag(CommunityStructure.getPropFormat(prop)) ').'] ...
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
				case 14 % CommunityStructure.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G');  % graph from measure class
					A = g.get('A');
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					community_structure = cell(L, 1);
					gamma = m.get('GAMMA');
					community_structure_algorithm = m.get('RULE');
					
					q_function = {};
					for li = 1:1:L
					    Aii = A{li, li};
					    [community_structure(li), q_function{li}] =  community(m, Aii, N(li), gamma, community_structure_algorithm);
					end
					m.set('QUALITY_FUNCTION', q_function);
					value = community_structure;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 15
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
			function [comm_str, quality_function] = community(m, A, N, gamma, community_structure_algorithm)
			A = A;
			N = N;
			gamma = gamma;
			community_structure_algorithm = community_structure_algorithm;
			    switch lower(community_structure_algorithm)
			        case {'fixed'}
			            M0 = m.get('M0');
			            assert(isequal(size(M0, 2), size(1:N, 2)), ...
			                    ['BRAPH2' ':CommunityStructure:' 'WrongInput'], ...
			                    ['M0 initial community affiliation vector must have the same length than the number of nodes' ...
			                    '(' tostring(size(1:N, 2)) ') while its length is ' tostring(size(M0, 2))])
			            community_structure = {M0'};
			            quality_function = 1;
			
			        case {'newman'}  % Newman algorithm
			            directionality_type = g.get('DIRECTIONALITY_TYPE', g.get('LAYERNUMBER'));
			            if directionality_type(1, 1) == 2  % directed graphs
			                n_perm = randperm(N);  % randomly permute order of nodes
			                A = A(n_perm, n_perm);  % DB: use permuted matrix for subsequent analysis
			                Ki = sum(A, 1);  % in-degree
			                Ko = sum(A, 2);  % out-degree
			                mo = sum(Ki);  % number of edges
			                b = A - gamma*(Ko*Ki).'/mo;
			                B = b+b.';  % directed modularity matrix
			                Ci = ones(N,1);  % community indices
			                cn = 1;  % number of communities
			                U = [1 0];  % array of unexamined communites
			
			                ind = 1:N;
			                Bg = B;
			                Ng = N;
			
			                while U(1)  % examine community U(1)
			                    [V, D] = eig(Bg);
			                    [d1, i1] = max(real(diag(D)));  % most positive eigenvalue of Bg
			                    v1 = V(:,i1);  % corresponding eigenvector
			                    S = ones(Ng,1);
			                    S(v1 < 0) = -1;
			                    q = S.' * Bg * S;  % contribution to modularity
			
			                    if q > 1e-10  % contribution positive: U(1) is divisible
			                        qmax = q;  % maximal contribution to modularity
			                        Bg(logical(eye(Ng))) = 0;  % Bg is modified, to enable fine-tuning
			                        indg = ones(Ng, 1);  % array of unmoved indices
			                        Sit = S;
			                        while any(indg)  % iterative fine-tuning
			                            Qit = qmax - 4*Sit.*(Bg*Sit);  % this line is equivalent to:
			                            qmax = max(Qit.*indg);  % for i=1:Ng
			                            imax = (Qit==qmax);  % Sit(i)=-Sit(i);
			                            Sit(imax) = -Sit(imax);  % Qit(i)=Sit.'*Bg*Sit;
			                            indg(imax) = nan;  % Sit(i)=-Sit(i);
			                            if qmax > q  % end
			                                q = qmax;
			                                S = Sit;
			                            end
			                        end
			
			                        if abs(sum(S)) == Ng  % unsuccessful splitting of U(1)
			                            U(1) = [];
			                        else
			                            cn = cn + 1;
			                            Ci(ind(S == 1)) = U(1);  % split old U(1) into new U(1) and into cn
			                            Ci(ind(S == -1)) = cn;
			                            U = [cn, U];
			                        end
			                    else  % contribution nonpositive: U(1) is indivisible
			                        U(1) = [];
			                    end
			
			                    ind = find(Ci==U(1));  % indices of unexamined community U(1)
			                    bg = B(ind, ind);
			                    Bg = bg - diag(sum(bg));  % modularity matrix for U(1)
			                    Ng = length(ind);  % number of vertices in U(1)
			                end
			
			                s = Ci(:, ones(1, N));  % compute modularity
			                Q =~ (s-s.').*B/(2*mo);
			                Q = sum(Q(:));
			                Ci_corrected = zeros(N, 1);  % initialize Ci_corrected
			                Ci_corrected(n_perm) = Ci;  % return order of nodes to the order used at the input stage.
			                Ci = Ci_corrected;  % output corrected community assignments
			
			                quality_function = Q;   % save normalized quality function/modularity
			                community_structure = {Ci};
			
			            else  % undirected graphs
			                n_perm = randperm(N);  % randomly permute order of nodes
			                A = A(n_perm, n_perm);  % DB: use permuted matrix for subsequent analysis
			                K = sum(A);  % degree
			                mo = sum(K);  % number of edges (each undirected edge is counted twice)
			                B = A - gamma*(K.'*K)/mo;  % modularity matrix
			                Ci = ones(N, 1);  % community indices
			                cn = 1;  % number of communities
			                U = [1 0];  % array of unexamined communites
			
			                ind = 1:N;
			                Bg = B;
			                Ng = N;
			
			                while U(1)  % examine community U(1)
			                    [V, D] = eig(Bg);
			                    [d1, i1] = max(real(diag(D)));  % maximal positive (real part of) eigenvalue of Bg
			                    v1 = V(:,i1);  % corresponding eigenvector
			
			                    S = ones(Ng,1);
			                    S(v1<0) = -1;
			                    q = S.'*Bg*S;  % contribution to modularity
			
			                    if q > 1e-10  % contribution positive: U(1) is divisible
			                        qmax = q;  % maximal contribution to modularity
			                        Bg(logical(eye(Ng))) = 0;  % Bg is modified, to enable fine-tuning
			                        indg = ones(Ng, 1);  % array of unmoved indices
			                        Sit = S;
			                        while any(indg)  % iterative fine-tuning
			                            Qit = qmax-  4*Sit.*(Bg*Sit);  % this line is equivalent to:
			                            qmax = max(Qit.*indg);  % for i=1:Ng
			                            imax = (Qit == qmax);  % Sit(i)=-Sit(i);
			                            Sit(imax) = -Sit(imax);  % Qit(i)=Sit.'*Bg*Sit;
			                            indg(imax) = nan;  % Sit(i)=-Sit(i);
			                            if qmax > q  % end
			                                q = qmax;
			                                S = Sit;
			                            end
			                        end
			
			                        if abs(sum(S)) == Ng  % unsuccessful splitting of U(1)
			                            U(1) = [];
			                        else
			                            cn = cn + 1;
			                            Ci(ind(S==1)) = U(1);  % split old U(1) into new U(1) and into cn
			                            Ci(ind(S==-1)) = cn;
			                            U = [cn, U];
			                        end
			                    else  % contribution nonpositive: U(1) is indivisible
			                        U(1) = [];
			                    end
			
			                    ind = find(Ci==U(1));  % indices of unexamined community U(1)
			                    bg = B(ind, ind);
			                    Bg = bg-diag(sum(bg));  % modularity matrix for U(1)
			                    Ng = length(ind);  % number of vertices in U(1)
			                end
			
			                s = Ci(:,ones(1, N));  % compute modularity
			                Q =~ (s-s.').*B/mo;
			                Q = sum(Q(:));
			                Ci_corrected = zeros(N, 1);  % initialize Ci_corrected
			                Ci_corrected(n_perm) = Ci;  % return order of nodes to the order used at the input stage.
			                Ci = Ci_corrected;  % output corrected community assignments
			
			                quality_function = Q; % save normalized quality function/modularity
			                community_structure = {Ci};
			            end
			
			        otherwise  % {'Louvain'}  % Louvain algorithm
			
			            M0 = m.get('M0');  % initial community affiliation vector
			            OM = m.get('LOUVAIN_OM');  % custom objective matrix
			            type_OM =  m.get('OM_TYPE');  % objective-function type
			            W = double(A);  % convert to double format
			            s = sum(sum(W));  % get sum of edges
			
			            if isempty(M0)
			                M0 = 1:N;
			            else
			                assert(isequal(size(M0, 2), size(1:N, 2)), ...
			                    ['BRAPH2' ':CommunityStructure:' 'WrongInput'], ...
			                    ['M0 initial community affiliation vector must have the same length than the number of nodes' ...
			                    '(' tostring(size(1:N, 2)) ') while its length is ' tostring(size(M0, 2))])
			            end
			            [~,~,Mb] = unique(M0);
			            M = Mb;
			
			            if isempty(OM)
			                % calculate OM according to type_B
			
			                switch lower(type_OM)
			                    case {'potts'}
			                        assert(all(all(W == logical(W))), ...
			                            ['BRAPH2' ':CommunityStructure:' 'WrongInput'], ...
			                            ['Potts-model Hamiltonian requires a binary adjacency matrix' ...
			                            'while it is ' tostring(W)])
			                        OM =  W - gamma*(~W);
			                    otherwise  % {'modularity'} default
			                        OM = W - gamma*(sum(W, 2)*sum(W, 1))/s;
			                end
			            else  % OM matrix exists
			                assert(isequal(size(W), size(OM)), ...
			                    ['BRAPH2' ':CommunityStructure:' 'WrongInput'], ...
			                    ['OM matrix must have the same size than the adjacency matrix' ...
			                    '(' tostring(size(W)) ') while its size is ' tostring(size(OM))])
			            end
			
			            OM = (OM+OM.')/2;  % symmetrize modularity matrix
			            Hnm = zeros(N, N);  % node-to-module degree
			            for mo = 1:max(Mb)  % loop over modules
			                Hnm(:, mo) = sum(OM(:, Mb== mo), 2);
			            end
			            H = sum(Hnm, 2);  % node degree
			            Hm = sum(Hnm, 1);  % module degree
			
			            Q0 = -inf;
			            Q = sum(OM(bsxfun(@eq, M0, M0.')))/s;  % compute modularity
			            first_iteration = true;
			            n = N;
			            while Q-Q0 > 1e-10
			                flag = true;  % flag for within-hierarchy search
			                while flag
			                    flag = false;
			                    for u = randperm(n)  % loop over all nodes in random order
			                        ma = Mb(u);  % current module of u
			                        dQ = Hnm(u, :)- Hnm(u,ma) + OM(u, u);
			                        dQ(ma) = 0;  % (line above) algorithm condition
			
			                        [max_dQ, mb] = max(dQ);  % maximal increase in modularity and corresponding module
			                        if max_dQ > 1e-10  % if maximal increase is positive
			                            flag = true;
			                            Mb(u) = mb;  % reassign module
			
			                            Hnm(:,mb) = Hnm(:,mb) + OM(:,u);  % change node-to-module strengths
			                            Hnm(:,ma) = Hnm(:,ma) - OM(:,u);
			                            Hm(mb) = Hm(mb) + H(u);  % change module strengths
			                            Hm(ma) = Hm(ma) - H(u);
			                        end
			                    end
			                end
			                [~,~,Mb] = unique(Mb);  % new module assignments
			
			                M0 = M;
			                if first_iteration
			                    M = Mb;
			                    first_iteration = false;
			                else
			                    for u = 1:n  % loop through initial module assignments
			                        M(M0==u) = Mb(u);  % assign new modules
			                    end
			                end
			
			                n = max(Mb);  % new number of modules
			                B1 = zeros(n);  % new weighted matrix
			                for u = 1:n
			                    for v = u:n
			                        bm = sum(sum(OM(Mb==u,Mb==v)));  % pool weights of nodes in same module
			                        B1(u,v) = bm;
			                        B1(v,u) = bm;
			                    end
			                end
			                OM = B1;
			
			                Mb = 1:n;  % initial module assignments
			                Hnm = OM;  % node-to-module strength
			                H = sum(OM);  % node strength
			                Hm = H;  % module strength
			
			                Q0 = Q;
			                Q = trace(OM)/s;  % compute modularity
			            end
			            quality_function = Q;  % save normalized quality function/modularity
			            community_structure = {M};
			    end
			    comm_str = community_structure;
			end
		end
	end
end
