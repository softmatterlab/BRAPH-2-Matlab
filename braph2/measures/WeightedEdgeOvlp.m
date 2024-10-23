classdef WeightedEdgeOvlp < Measure
	%WeightedEdgeOvlp is the graph Weighted Edge Overlap.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Weighted Edge Overlap (WeightedEdgeOvlp) of a graph is the average weight of an edge 
	% across all layers.
	%
	% The list of WeightedEdgeOvlp properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Weighted Edge Overlap.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Weighted Edge Overlap.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Weighted Edge Overlap.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Weighted Edge Overlap.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Weighted Edge Overlap.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Weighted Edge Overlap.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Weighted Edge Overlap.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Weighted Edge Overlap.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%
	% WeightedEdgeOvlp methods (constructor):
	%  WeightedEdgeOvlp - constructor
	%
	% WeightedEdgeOvlp methods:
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
	% WeightedEdgeOvlp methods (display):
	%  tostring - string with information about the weighted edge overlap
	%  disp - displays information about the weighted edge overlap
	%  tree - displays the tree of the weighted edge overlap
	%
	% WeightedEdgeOvlp methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two weighted edge overlap are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the weighted edge overlap
	%
	% WeightedEdgeOvlp methods (save/load, Static):
	%  save - saves BRAPH2 weighted edge overlap as b2 file
	%  load - loads a BRAPH2 weighted edge overlap from a b2 file
	%
	% WeightedEdgeOvlp method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the weighted edge overlap
	%
	% WeightedEdgeOvlp method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the weighted edge overlap
	%
	% WeightedEdgeOvlp methods (inspection, Static):
	%  getClass - returns the class of the weighted edge overlap
	%  getSubclasses - returns all subclasses of WeightedEdgeOvlp
	%  getProps - returns the property list of the weighted edge overlap
	%  getPropNumber - returns the property number of the weighted edge overlap
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
	% WeightedEdgeOvlp methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% WeightedEdgeOvlp methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% WeightedEdgeOvlp methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% WeightedEdgeOvlp methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?WeightedEdgeOvlp; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">WeightedEdgeOvlp constants</a>.
	%
	
	methods % constructor
		function m = WeightedEdgeOvlp(varargin)
			%WeightedEdgeOvlp() creates a weighted edge overlap.
			%
			% WeightedEdgeOvlp(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% WeightedEdgeOvlp(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of WeightedEdgeOvlp properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Weighted Edge Overlap.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Weighted Edge Overlap.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Weighted Edge Overlap.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Weighted Edge Overlap.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the Weighted Edge Overlap.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Weighted Edge Overlap.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Weighted Edge Overlap.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the Weighted Edge Overlap.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the weighted edge overlap.
			%
			% BUILD = WeightedEdgeOvlp.GETBUILD() returns the build of 'WeightedEdgeOvlp'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the weighted edge overlap M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('WeightedEdgeOvlp') returns the build of 'WeightedEdgeOvlp'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('WeightedEdgeOvlp')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the weighted edge overlap.
			%
			% CLASS = WeightedEdgeOvlp.GETCLASS() returns the class 'WeightedEdgeOvlp'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the weighted edge overlap M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('WeightedEdgeOvlp') returns 'WeightedEdgeOvlp'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('WeightedEdgeOvlp')
			%  are less computationally efficient.
			
			m_class = 'WeightedEdgeOvlp';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the weighted edge overlap.
			%
			% LIST = WeightedEdgeOvlp.GETSUBCLASSES() returns all subclasses of 'WeightedEdgeOvlp'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the weighted edge overlap M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('WeightedEdgeOvlp') returns all subclasses of 'WeightedEdgeOvlp'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('WeightedEdgeOvlp')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'WeightedEdgeOvlp' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of weighted edge overlap.
			%
			% PROPS = WeightedEdgeOvlp.GETPROPS() returns the property list of weighted edge overlap
			%  as a row vector.
			%
			% PROPS = WeightedEdgeOvlp.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the weighted edge overlap M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('WeightedEdgeOvlp'[, CATEGORY]) returns the property list of 'WeightedEdgeOvlp'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('WeightedEdgeOvlp')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3 9 10 11 12];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = 4;
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
			%GETPROPNUMBER returns the property number of weighted edge overlap.
			%
			% N = WeightedEdgeOvlp.GETPROPNUMBER() returns the property number of weighted edge overlap.
			%
			% N = WeightedEdgeOvlp.GETPROPNUMBER(CATEGORY) returns the property number of weighted edge overlap
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the weighted edge overlap M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('WeightedEdgeOvlp') returns the property number of 'WeightedEdgeOvlp'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('WeightedEdgeOvlp')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 15;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 7;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
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
			%EXISTSPROP checks whether property exists in weighted edge overlap/error.
			%
			% CHECK = WeightedEdgeOvlp.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(WeightedEdgeOvlp, PROP) checks whether PROP exists for WeightedEdgeOvlp.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:WeightedEdgeOvlp:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:WeightedEdgeOvlp:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:WeightedEdgeOvlp:WrongInput]
			%  Element.EXISTSPROP(WeightedEdgeOvlp, PROP) throws error if PROP does NOT exist for WeightedEdgeOvlp.
			%   Error id: [BRAPH2:WeightedEdgeOvlp:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('WeightedEdgeOvlp')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 15 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':WeightedEdgeOvlp:' 'WrongInput'], ...
					['BRAPH2' ':WeightedEdgeOvlp:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for WeightedEdgeOvlp.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in weighted edge overlap/error.
			%
			% CHECK = WeightedEdgeOvlp.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(WeightedEdgeOvlp, TAG) checks whether TAG exists for WeightedEdgeOvlp.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:WeightedEdgeOvlp:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:WeightedEdgeOvlp:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:WeightedEdgeOvlp:WrongInput]
			%  Element.EXISTSTAG(WeightedEdgeOvlp, TAG) throws error if TAG does NOT exist for WeightedEdgeOvlp.
			%   Error id: [BRAPH2:WeightedEdgeOvlp:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('WeightedEdgeOvlp')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':WeightedEdgeOvlp:' 'WrongInput'], ...
					['BRAPH2' ':WeightedEdgeOvlp:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for WeightedEdgeOvlp.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(WeightedEdgeOvlp, POINTER) returns property number of POINTER of WeightedEdgeOvlp.
			%  PROPERTY = M.GETPROPPROP(WeightedEdgeOvlp, POINTER) returns property number of POINTER of WeightedEdgeOvlp.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('WeightedEdgeOvlp')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(WeightedEdgeOvlp, POINTER) returns tag of POINTER of WeightedEdgeOvlp.
			%  TAG = M.GETPROPTAG(WeightedEdgeOvlp, POINTER) returns tag of POINTER of WeightedEdgeOvlp.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('WeightedEdgeOvlp')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				weightededgeovlp_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' };
				tag = weightededgeovlp_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(WeightedEdgeOvlp, POINTER) returns category of POINTER of WeightedEdgeOvlp.
			%  CATEGORY = M.GETPROPCATEGORY(WeightedEdgeOvlp, POINTER) returns category of POINTER of WeightedEdgeOvlp.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('WeightedEdgeOvlp')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = WeightedEdgeOvlp.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			weightededgeovlp_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9 };
			prop_category = weightededgeovlp_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(WeightedEdgeOvlp, POINTER) returns format of POINTER of WeightedEdgeOvlp.
			%  FORMAT = M.GETPROPFORMAT(WeightedEdgeOvlp, POINTER) returns format of POINTER of WeightedEdgeOvlp.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('WeightedEdgeOvlp')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = WeightedEdgeOvlp.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			weightededgeovlp_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8 };
			prop_format = weightededgeovlp_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(WeightedEdgeOvlp, POINTER) returns description of POINTER of WeightedEdgeOvlp.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(WeightedEdgeOvlp, POINTER) returns description of POINTER of WeightedEdgeOvlp.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('WeightedEdgeOvlp')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = WeightedEdgeOvlp.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			weightededgeovlp_description_list = { 'ELCLASS (constant, string) is the class of the Weighted Edge Overlap.'  'NAME (constant, string) is the name of the Weighted Edge Overlap.'  'DESCRIPTION (constant, string) is the description of the Weighted Edge Overlap.'  'TEMPLATE (parameter, item) is the template of the Weighted Edge Overlap.'  'ID (data, string) is a few-letter code of the Weighted Edge Overlap.'  'LABEL (metadata, string) is an extended label of the Weighted Edge Overlap.'  'NOTES (metadata, string) are some specific notes about the Weighted Edge Overlap.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the Weighted Edge Overlap.'  'PFM (gui, item) contains the panel figure of the measure.' };
			prop_description = weightededgeovlp_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(WeightedEdgeOvlp, POINTER) returns settings of POINTER of WeightedEdgeOvlp.
			%  SETTINGS = M.GETPROPSETTINGS(WeightedEdgeOvlp, POINTER) returns settings of POINTER of WeightedEdgeOvlp.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('WeightedEdgeOvlp')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = WeightedEdgeOvlp.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % WeightedEdgeOvlp.TEMPLATE
					prop_settings = 'WeightedEdgeOvlp';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = WeightedEdgeOvlp.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = WeightedEdgeOvlp.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(WeightedEdgeOvlp, POINTER) returns the default value of POINTER of WeightedEdgeOvlp.
			%  DEFAULT = M.GETPROPDEFAULT(WeightedEdgeOvlp, POINTER) returns the default value of POINTER of WeightedEdgeOvlp.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('WeightedEdgeOvlp')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = WeightedEdgeOvlp.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % WeightedEdgeOvlp.ELCLASS
					prop_default = 'WeightedEdgeOvlp';
				case 2 % WeightedEdgeOvlp.NAME
					prop_default = 'Weighted Edge Overlap';
				case 3 % WeightedEdgeOvlp.DESCRIPTION
					prop_default = 'The Weighted Edge Overlap (WeightedEdgeOvlp) of a graph is the average weight of an edge across all layers.';
				case 4 % WeightedEdgeOvlp.TEMPLATE
					prop_default = Format.getFormatDefault(8, WeightedEdgeOvlp.getPropSettings(prop));
				case 5 % WeightedEdgeOvlp.ID
					prop_default = 'WeightedEdgeOvlp ID';
				case 6 % WeightedEdgeOvlp.LABEL
					prop_default = 'Weighted Edge Overlap label';
				case 7 % WeightedEdgeOvlp.NOTES
					prop_default = 'Weighted Edge Overlap notes';
				case 9 % WeightedEdgeOvlp.SHAPE
					prop_default = 3;
				case 10 % WeightedEdgeOvlp.SCOPE
					prop_default = 1;
				case 11 % WeightedEdgeOvlp.PARAMETRICITY
					prop_default = 2;
				case 12 % WeightedEdgeOvlp.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexWD' 'OrdMxWU' 'OrdMxWD' 'MultilayerWU' 'MultilayerWD' 'OrdMxWU' 'OrdMxWD'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = WeightedEdgeOvlp.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = WeightedEdgeOvlp.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(WeightedEdgeOvlp, POINTER) returns the conditioned default value of POINTER of WeightedEdgeOvlp.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(WeightedEdgeOvlp, POINTER) returns the conditioned default value of POINTER of WeightedEdgeOvlp.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('WeightedEdgeOvlp')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = WeightedEdgeOvlp.getPropProp(pointer);
			
			prop_default = WeightedEdgeOvlp.conditioning(prop, WeightedEdgeOvlp.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(WeightedEdgeOvlp, PROP, VALUE) checks VALUE format for PROP of WeightedEdgeOvlp.
			%  CHECK = M.CHECKPROP(WeightedEdgeOvlp, PROP, VALUE) checks VALUE format for PROP of WeightedEdgeOvlp.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:WeightedEdgeOvlp:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:WeightedEdgeOvlp:WrongInput
			%  Element.CHECKPROP(WeightedEdgeOvlp, PROP, VALUE) throws error if VALUE has not a valid format for PROP of WeightedEdgeOvlp.
			%   Error id: BRAPH2:WeightedEdgeOvlp:WrongInput
			%  M.CHECKPROP(WeightedEdgeOvlp, PROP, VALUE) throws error if VALUE has not a valid format for PROP of WeightedEdgeOvlp.
			%   Error id: BRAPH2:WeightedEdgeOvlp:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('WeightedEdgeOvlp')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = WeightedEdgeOvlp.getPropProp(pointer);
			
			switch prop
				case 4 % WeightedEdgeOvlp.TEMPLATE
					check = Format.checkFormat(8, value, WeightedEdgeOvlp.getPropSettings(prop));
				otherwise
					if prop <= 15
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':WeightedEdgeOvlp:' 'WrongInput'], ...
					['BRAPH2' ':WeightedEdgeOvlp:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' WeightedEdgeOvlp.getPropTag(prop) ' (' WeightedEdgeOvlp.getFormatTag(WeightedEdgeOvlp.getPropFormat(prop)) ').'] ...
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
				case 14 % WeightedEdgeOvlp.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					
					if l == 0
					    value = {};
					else
					    N = g.get('NODENUMBER');
					   weighted_edge_overlap = zeros(N(1));
					
					    for li = 1:l
					        Aii = A{li, li};
					        weighted_edge_overlap = weighted_edge_overlap + Aii;
					    end
					    value = {weighted_edge_overlap / l};
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 15
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
