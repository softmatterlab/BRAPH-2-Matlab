classdef ClusteringAv < Clustering
	%ClusteringAv is the graph Average Clustering.
	% It is a subclass of <a href="matlab:help Clustering">Clustering</a>.
	%
	% The Average Clustering (ClusteringAv) of a graph is the average of the clustering 
	% coefficients of all nodes. Connection weights are ignored in calculations.
	%
	% The list of ClusteringAv properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Average Clustering.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Average Clustering.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Average Clustering.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Average Clustering.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Average Clustering.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Average Clustering.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Average Clustering.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the cell containing the Average Clustering.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>16</strong> <strong>RULE</strong> 	RULE (parameter, option) is the rule to determine what is a triangle in a directed graph.
	%
	% ClusteringAv methods (constructor):
	%  ClusteringAv - constructor
	%
	% ClusteringAv methods:
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
	% ClusteringAv methods (display):
	%  tostring - string with information about the average clustering
	%  disp - displays information about the average clustering
	%  tree - displays the tree of the average clustering
	%
	% ClusteringAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average clustering are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average clustering
	%
	% ClusteringAv methods (save/load, Static):
	%  save - saves BRAPH2 average clustering as b2 file
	%  load - loads a BRAPH2 average clustering from a b2 file
	%
	% ClusteringAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average clustering
	%
	% ClusteringAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average clustering
	%
	% ClusteringAv methods (inspection, Static):
	%  getClass - returns the class of the average clustering
	%  getSubclasses - returns all subclasses of ClusteringAv
	%  getProps - returns the property list of the average clustering
	%  getPropNumber - returns the property number of the average clustering
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
	% ClusteringAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ClusteringAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ClusteringAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ClusteringAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ClusteringAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ClusteringAv constants</a>.
	%
	
	methods % constructor
		function m = ClusteringAv(varargin)
			%ClusteringAv() creates a average clustering.
			%
			% ClusteringAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ClusteringAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ClusteringAv properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Average Clustering.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Average Clustering.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Average Clustering.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Average Clustering.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Average Clustering.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Average Clustering.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Average Clustering.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the cell containing the Average Clustering.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>16</strong> <strong>RULE</strong> 	RULE (parameter, option) is the rule to determine what is a triangle in a directed graph.
			%
			% See also Category, Format.
			
			m = m@Clustering(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the average clustering.
			%
			% BUILD = ClusteringAv.GETBUILD() returns the build of 'ClusteringAv'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the average clustering M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('ClusteringAv') returns the build of 'ClusteringAv'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('ClusteringAv')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the average clustering.
			%
			% CLASS = ClusteringAv.GETCLASS() returns the class 'ClusteringAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average clustering M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('ClusteringAv') returns 'ClusteringAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('ClusteringAv')
			%  are less computationally efficient.
			
			m_class = 'ClusteringAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average clustering.
			%
			% LIST = ClusteringAv.GETSUBCLASSES() returns all subclasses of 'ClusteringAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average clustering M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('ClusteringAv') returns all subclasses of 'ClusteringAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('ClusteringAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ClusteringAv' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average clustering.
			%
			% PROPS = ClusteringAv.GETPROPS() returns the property list of average clustering
			%  as a row vector.
			%
			% PROPS = ClusteringAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average clustering M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('ClusteringAv'[, CATEGORY]) returns the property list of 'ClusteringAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('ClusteringAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3 9 10 11 12];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 16];
				case 4 % Category.DATA
					prop_list = [5 13];
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
			%GETPROPNUMBER returns the property number of average clustering.
			%
			% N = ClusteringAv.GETPROPNUMBER() returns the property number of average clustering.
			%
			% N = ClusteringAv.GETPROPNUMBER(CATEGORY) returns the property number of average clustering
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average clustering M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('ClusteringAv') returns the property number of 'ClusteringAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('ClusteringAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 16;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 7;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 2;
				case 4 % Category.DATA
					prop_number = 2;
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
			%EXISTSPROP checks whether property exists in average clustering/error.
			%
			% CHECK = ClusteringAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(ClusteringAv, PROP) checks whether PROP exists for ClusteringAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ClusteringAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:ClusteringAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:ClusteringAv:WrongInput]
			%  Element.EXISTSPROP(ClusteringAv, PROP) throws error if PROP does NOT exist for ClusteringAv.
			%   Error id: [BRAPH2:ClusteringAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('ClusteringAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 16 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ClusteringAv:' 'WrongInput'], ...
					['BRAPH2' ':ClusteringAv:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ClusteringAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average clustering/error.
			%
			% CHECK = ClusteringAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(ClusteringAv, TAG) checks whether TAG exists for ClusteringAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ClusteringAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:ClusteringAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:ClusteringAv:WrongInput]
			%  Element.EXISTSTAG(ClusteringAv, TAG) throws error if TAG does NOT exist for ClusteringAv.
			%   Error id: [BRAPH2:ClusteringAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('ClusteringAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ClusteringAv:' 'WrongInput'], ...
					['BRAPH2' ':ClusteringAv:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ClusteringAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ClusteringAv, POINTER) returns property number of POINTER of ClusteringAv.
			%  PROPERTY = M.GETPROPPROP(ClusteringAv, POINTER) returns property number of POINTER of ClusteringAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('ClusteringAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(ClusteringAv, POINTER) returns tag of POINTER of ClusteringAv.
			%  TAG = M.GETPROPTAG(ClusteringAv, POINTER) returns tag of POINTER of ClusteringAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('ClusteringAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				clusteringav_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'RULE' };
				tag = clusteringav_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(ClusteringAv, POINTER) returns category of POINTER of ClusteringAv.
			%  CATEGORY = M.GETPROPCATEGORY(ClusteringAv, POINTER) returns category of POINTER of ClusteringAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('ClusteringAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ClusteringAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			clusteringav_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  3 };
			prop_category = clusteringav_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(ClusteringAv, POINTER) returns format of POINTER of ClusteringAv.
			%  FORMAT = M.GETPROPFORMAT(ClusteringAv, POINTER) returns format of POINTER of ClusteringAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('ClusteringAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ClusteringAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			clusteringav_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  5 };
			prop_format = clusteringav_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ClusteringAv, POINTER) returns description of POINTER of ClusteringAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(ClusteringAv, POINTER) returns description of POINTER of ClusteringAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('ClusteringAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ClusteringAv.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			clusteringav_description_list = { 'ELCLASS (constant, string) is the class of the Average Clustering.'  'NAME (constant, string) is the name of the Average Clustering.'  'DESCRIPTION (constant, string) is the description of the Average Clustering.'  'TEMPLATE (parameter, item) is the template of the Average Clustering.'  'ID (data, string) is a few-letter code of the Average Clustering.'  'LABEL (metadata, string) is an extended label of the Average Clustering.'  'NOTES (metadata, string) are some specific notes about the Average Clustering.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.GLOBAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the cell containing the Average Clustering.'  'PFM (gui, item) contains the panel figure of the measure.'  'RULE (parameter, option) is the rule to determine what is a triangle in a directed graph.' };
			prop_description = clusteringav_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(ClusteringAv, POINTER) returns settings of POINTER of ClusteringAv.
			%  SETTINGS = M.GETPROPSETTINGS(ClusteringAv, POINTER) returns settings of POINTER of ClusteringAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('ClusteringAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ClusteringAv.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % ClusteringAv.TEMPLATE
					prop_settings = 'ClusteringAv';
				otherwise
					prop_settings = getPropSettings@Clustering(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ClusteringAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ClusteringAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(ClusteringAv, POINTER) returns the default value of POINTER of ClusteringAv.
			%  DEFAULT = M.GETPROPDEFAULT(ClusteringAv, POINTER) returns the default value of POINTER of ClusteringAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('ClusteringAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ClusteringAv.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % ClusteringAv.ELCLASS
					prop_default = 'ClusteringAv';
				case 2 % ClusteringAv.NAME
					prop_default = 'Average Clustering';
				case 3 % ClusteringAv.DESCRIPTION
					prop_default = 'The Average Clustering (ClusteringAv) of a graph is the average of the clustering coefficients of all nodes. Connection weights are ignored in calculations.';
				case 4 % ClusteringAv.TEMPLATE
					prop_default = Format.getFormatDefault(8, ClusteringAv.getPropSettings(prop));
				case 5 % ClusteringAv.ID
					prop_default = 'ClusteringAv ID';
				case 6 % ClusteringAv.LABEL
					prop_default = 'Average Clustering label';
				case 7 % ClusteringAv.NOTES
					prop_default = 'Average Clustering notes';
				case 9 % ClusteringAv.SHAPE
					prop_default = 1;
				case 10 % ClusteringAv.SCOPE
					prop_default = 2;
				case 11 % ClusteringAv.PARAMETRICITY
					prop_default = 2;
				case 12 % ClusteringAv.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'MultiplexBD'};;
				otherwise
					prop_default = getPropDefault@Clustering(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ClusteringAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ClusteringAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ClusteringAv, POINTER) returns the conditioned default value of POINTER of ClusteringAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(ClusteringAv, POINTER) returns the conditioned default value of POINTER of ClusteringAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('ClusteringAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ClusteringAv.getPropProp(pointer);
			
			prop_default = ClusteringAv.conditioning(prop, ClusteringAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ClusteringAv, PROP, VALUE) checks VALUE format for PROP of ClusteringAv.
			%  CHECK = M.CHECKPROP(ClusteringAv, PROP, VALUE) checks VALUE format for PROP of ClusteringAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ClusteringAv:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:ClusteringAv:WrongInput
			%  Element.CHECKPROP(ClusteringAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ClusteringAv.
			%   Error id: BRAPH2:ClusteringAv:WrongInput
			%  M.CHECKPROP(ClusteringAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ClusteringAv.
			%   Error id: BRAPH2:ClusteringAv:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('ClusteringAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ClusteringAv.getPropProp(pointer);
			
			switch prop
				case 4 % ClusteringAv.TEMPLATE
					check = Format.checkFormat(8, value, ClusteringAv.getPropSettings(prop));
				otherwise
					if prop <= 16
						check = checkProp@Clustering(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ClusteringAv:' 'WrongInput'], ...
					['BRAPH2' ':ClusteringAv:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ClusteringAv.getPropTag(prop) ' (' ClusteringAv.getFormatTag(ClusteringAv.getPropFormat(prop)) ').'] ...
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
				case 14 % ClusteringAv.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					clustering  = calculateValue@Clustering(m, prop);
					layerNumber = g.get('LAYERNUMBER');
					clustering_av = cell(layerNumber, 1);
					parfor li = 1:1:length(clustering)
					    clustering_av(li) = {mean(clustering{li})};
					end
					
					value = clustering_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 16
						value = calculateValue@Clustering(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
