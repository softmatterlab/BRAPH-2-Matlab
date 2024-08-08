classdef EdgeBetwCentr < Measure
	%EdgeBetwCentr is the Edge Betweenness Centrality.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Edge Betweenness Centrality (EdgeBetwCentr) of a graph is the fraction of all shortest paths in the 
	% graph that pass through a given edge within a layer. Edges with high values 
	% of betweenness centrality participate in a large number of shortest paths.
	%
	% EdgeBetwCentr methods (constructor):
	%  EdgeBetwCentr - constructor
	%
	% EdgeBetwCentr methods:
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
	% EdgeBetwCentr methods (display):
	%  tostring - string with information about the edge betweenness centrality
	%  disp - displays information about the edge betweenness centrality
	%  tree - displays the tree of the edge betweenness centrality
	%
	% EdgeBetwCentr methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two edge betweenness centrality are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the edge betweenness centrality
	%
	% EdgeBetwCentr methods (save/load, Static):
	%  save - saves BRAPH2 edge betweenness centrality as b2 file
	%  load - loads a BRAPH2 edge betweenness centrality from a b2 file
	%
	% EdgeBetwCentr method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the edge betweenness centrality
	%
	% EdgeBetwCentr method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the edge betweenness centrality
	%
	% EdgeBetwCentr methods (inspection, Static):
	%  getClass - returns the class of the edge betweenness centrality
	%  getSubclasses - returns all subclasses of EdgeBetwCentr
	%  getProps - returns the property list of the edge betweenness centrality
	%  getPropNumber - returns the property number of the edge betweenness centrality
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
	% EdgeBetwCentr methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% EdgeBetwCentr methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% EdgeBetwCentr methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% EdgeBetwCentr methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?EdgeBetwCentr; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">EdgeBetwCentr constants</a>.
	%
	
	methods % constructor
		function m = EdgeBetwCentr(varargin)
			%EdgeBetwCentr() creates a edge betweenness centrality.
			%
			% EdgeBetwCentr(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% EdgeBetwCentr(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the edge betweenness centrality.
			%
			% CLASS = EdgeBetwCentr.GETCLASS() returns the class 'EdgeBetwCentr'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the edge betweenness centrality M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('EdgeBetwCentr') returns 'EdgeBetwCentr'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('EdgeBetwCentr')
			%  are less computationally efficient.
			
			m_class = 'EdgeBetwCentr';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the edge betweenness centrality.
			%
			% LIST = EdgeBetwCentr.GETSUBCLASSES() returns all subclasses of 'EdgeBetwCentr'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the edge betweenness centrality M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('EdgeBetwCentr') returns all subclasses of 'EdgeBetwCentr'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('EdgeBetwCentr')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('EdgeBetwCentr', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of edge betweenness centrality.
			%
			% PROPS = EdgeBetwCentr.GETPROPS() returns the property list of edge betweenness centrality
			%  as a row vector.
			%
			% PROPS = EdgeBetwCentr.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the edge betweenness centrality M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('EdgeBetwCentr'[, CATEGORY]) returns the property list of 'EdgeBetwCentr'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('EdgeBetwCentr')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Measure.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Measure.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Measure.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Measure.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						Measure.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Measure.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Measure.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Measure.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Measure.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of edge betweenness centrality.
			%
			% N = EdgeBetwCentr.GETPROPNUMBER() returns the property number of edge betweenness centrality.
			%
			% N = EdgeBetwCentr.GETPROPNUMBER(CATEGORY) returns the property number of edge betweenness centrality
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the edge betweenness centrality M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('EdgeBetwCentr') returns the property number of 'EdgeBetwCentr'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('EdgeBetwCentr')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(EdgeBetwCentr.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in edge betweenness centrality/error.
			%
			% CHECK = EdgeBetwCentr.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(EdgeBetwCentr, PROP) checks whether PROP exists for EdgeBetwCentr.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:EdgeBetwCentr:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EdgeBetwCentr:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EdgeBetwCentr:WrongInput]
			%  Element.EXISTSPROP(EdgeBetwCentr, PROP) throws error if PROP does NOT exist for EdgeBetwCentr.
			%   Error id: [BRAPH2:EdgeBetwCentr:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('EdgeBetwCentr')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == EdgeBetwCentr.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EdgeBetwCentr:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EdgeBetwCentr:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for EdgeBetwCentr.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in edge betweenness centrality/error.
			%
			% CHECK = EdgeBetwCentr.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(EdgeBetwCentr, TAG) checks whether TAG exists for EdgeBetwCentr.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:EdgeBetwCentr:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EdgeBetwCentr:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EdgeBetwCentr:WrongInput]
			%  Element.EXISTSTAG(EdgeBetwCentr, TAG) throws error if TAG does NOT exist for EdgeBetwCentr.
			%   Error id: [BRAPH2:EdgeBetwCentr:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('EdgeBetwCentr')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			edgebetwcentr_tag_list = cellfun(@(x) EdgeBetwCentr.getPropTag(x), num2cell(EdgeBetwCentr.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, edgebetwcentr_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EdgeBetwCentr:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EdgeBetwCentr:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for EdgeBetwCentr.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(EdgeBetwCentr, POINTER) returns property number of POINTER of EdgeBetwCentr.
			%  PROPERTY = M.GETPROPPROP(EdgeBetwCentr, POINTER) returns property number of POINTER of EdgeBetwCentr.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('EdgeBetwCentr')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				edgebetwcentr_tag_list = cellfun(@(x) EdgeBetwCentr.getPropTag(x), num2cell(EdgeBetwCentr.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, edgebetwcentr_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(EdgeBetwCentr, POINTER) returns tag of POINTER of EdgeBetwCentr.
			%  TAG = M.GETPROPTAG(EdgeBetwCentr, POINTER) returns tag of POINTER of EdgeBetwCentr.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('EdgeBetwCentr')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					otherwise
						tag = getPropTag@Measure(prop);
				end
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
			%  CATEGORY = Element.GETPROPCATEGORY(EdgeBetwCentr, POINTER) returns category of POINTER of EdgeBetwCentr.
			%  CATEGORY = M.GETPROPCATEGORY(EdgeBetwCentr, POINTER) returns category of POINTER of EdgeBetwCentr.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('EdgeBetwCentr')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = EdgeBetwCentr.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@Measure(prop);
			end
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
			%  FORMAT = Element.GETPROPFORMAT(EdgeBetwCentr, POINTER) returns format of POINTER of EdgeBetwCentr.
			%  FORMAT = M.GETPROPFORMAT(EdgeBetwCentr, POINTER) returns format of POINTER of EdgeBetwCentr.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('EdgeBetwCentr')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = EdgeBetwCentr.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@Measure(prop);
			end
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(EdgeBetwCentr, POINTER) returns description of POINTER of EdgeBetwCentr.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(EdgeBetwCentr, POINTER) returns description of POINTER of EdgeBetwCentr.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('EdgeBetwCentr')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = EdgeBetwCentr.getPropProp(pointer);
			
			switch prop
				case EdgeBetwCentr.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Edge Betweenness Centrality.';
				case EdgeBetwCentr.NAME
					prop_description = 'NAME (constant, string) is the name of the Edge Betweenness Centrality.';
				case EdgeBetwCentr.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Edge Betweenness Centrality.';
				case EdgeBetwCentr.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Edge Betweenness Centrality.';
				case EdgeBetwCentr.ID
					prop_description = 'ID (data, string) is a few-letter code of the Edge Betweenness Centrality.';
				case EdgeBetwCentr.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Edge Betweenness Centrality.';
				case EdgeBetwCentr.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Edge Betweenness Centrality.';
				case EdgeBetwCentr.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.BINODAL__.';
				case EdgeBetwCentr.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case EdgeBetwCentr.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case EdgeBetwCentr.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case EdgeBetwCentr.M
					prop_description = 'M (result, cell) is the Edge Betweenness Centrality.';
				otherwise
					prop_description = getPropDescription@Measure(prop);
			end
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
			%  SETTINGS = Element.GETPROPSETTINGS(EdgeBetwCentr, POINTER) returns settings of POINTER of EdgeBetwCentr.
			%  SETTINGS = M.GETPROPSETTINGS(EdgeBetwCentr, POINTER) returns settings of POINTER of EdgeBetwCentr.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('EdgeBetwCentr')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = EdgeBetwCentr.getPropProp(pointer);
			
			switch prop
				case EdgeBetwCentr.TEMPLATE
					prop_settings = 'EdgeBetwCentr';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = EdgeBetwCentr.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = EdgeBetwCentr.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(EdgeBetwCentr, POINTER) returns the default value of POINTER of EdgeBetwCentr.
			%  DEFAULT = M.GETPROPDEFAULT(EdgeBetwCentr, POINTER) returns the default value of POINTER of EdgeBetwCentr.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('EdgeBetwCentr')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = EdgeBetwCentr.getPropProp(pointer);
			
			switch prop
				case EdgeBetwCentr.ELCLASS
					prop_default = 'EdgeBetwCentr';
				case EdgeBetwCentr.NAME
					prop_default = 'Edge Betweenness Centrality';
				case EdgeBetwCentr.DESCRIPTION
					prop_default = 'The Edge Betweenness Centrality (EdgeBetwCentr) of a graph is the fraction of all shortest paths in the graph that pass through a given edge within a layer. Edges with high values of betweenness centrality participate in a large number of shortest paths.';
				case EdgeBetwCentr.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, EdgeBetwCentr.getPropSettings(prop));
				case EdgeBetwCentr.ID
					prop_default = 'EdgeBetwCentr ID';
				case EdgeBetwCentr.LABEL
					prop_default = 'Edge Betweenness Centrality label';
				case EdgeBetwCentr.NOTES
					prop_default = 'Edge Betweenness Centrality notes';
				case EdgeBetwCentr.SHAPE
					prop_default = Measure.BINODAL;
				case EdgeBetwCentr.SCOPE
					prop_default = Measure.UNILAYER;
				case EdgeBetwCentr.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case EdgeBetwCentr.COMPATIBLE_GRAPHS
					prop_default = {'GraphBD' 'GraphBU' 'GraphWD' 'GraphWU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexBD' 'MultiplexBU' 'MultiplexWD' 'MultiplexWU' 'MultiplexBUD' 'MultiplexBUT'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = EdgeBetwCentr.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = EdgeBetwCentr.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(EdgeBetwCentr, POINTER) returns the conditioned default value of POINTER of EdgeBetwCentr.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(EdgeBetwCentr, POINTER) returns the conditioned default value of POINTER of EdgeBetwCentr.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('EdgeBetwCentr')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = EdgeBetwCentr.getPropProp(pointer);
			
			prop_default = EdgeBetwCentr.conditioning(prop, EdgeBetwCentr.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(EdgeBetwCentr, PROP, VALUE) checks VALUE format for PROP of EdgeBetwCentr.
			%  CHECK = M.CHECKPROP(EdgeBetwCentr, PROP, VALUE) checks VALUE format for PROP of EdgeBetwCentr.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:EdgeBetwCentr:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:EdgeBetwCentr:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(EdgeBetwCentr, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EdgeBetwCentr.
			%   Error id: €BRAPH2.STR€:EdgeBetwCentr:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(EdgeBetwCentr, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EdgeBetwCentr.
			%   Error id: €BRAPH2.STR€:EdgeBetwCentr:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('EdgeBetwCentr')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = EdgeBetwCentr.getPropProp(pointer);
			
			switch prop
				case EdgeBetwCentr.TEMPLATE % __EdgeBetwCentr.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, EdgeBetwCentr.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EdgeBetwCentr:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EdgeBetwCentr:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' EdgeBetwCentr.getPropTag(prop) ' (' EdgeBetwCentr.getFormatTag(EdgeBetwCentr.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with Category.RESULT,
			%  Category.QUERY, and Category.EVANESCENT. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  Category.QUERY.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case EdgeBetwCentr.M % __EdgeBetwCentr.M__
					rng_settings_ = rng(); rng(m.getPropSeed(EdgeBetwCentr.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					
					edgebetweennesscentrality = cell(L, 1);
					connectivity_type =  g.get('CONNECTIVITY_TYPE', L);
					for li = 1:L    
					    Aii = A{li, li};
					    connectivity_layer = connectivity_type(li, li);   
					    
					    if connectivity_layer == Graph.WEIGHTED  % weighted graphs
					        edge_betweenness_centrality_layer = getWeightedCalculation(Aii);
					    else  % binary graphs
					        edge_betweenness_centrality_layer = getBinaryCalculation(Aii);
					    end
					    edgebetweennesscentrality(li) = {edge_betweenness_centrality_layer};
					end
					
					value = edgebetweennesscentrality;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Measure.getPropNumber()
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
			function binary_edge_betweenness_centrality = getBinaryCalculation(A)
			% GETBINARYCALCULATION calculates the edge betweenness centrality value of a binary adjacency matrix
			%
			% BINARY_EDGE_BETWEENNESS_CENTRALITY = GETBINARYCALCULATION(m, A) returns the value
			% of the edge betweenness centrality of a binary adjacency matrix A.
			
			n = length(A);
			BC = zeros(n,1);  % vertex betweenness
			EBC = zeros(n);  % edge betweenness
			for u=1:n
			    D = false(1, n); D(u) = 1;  % distance from u
			    NP = zeros(1, n); NP(u) = 1;  % number of paths from u
			    P = false(n);  % predecessors
			    Q = zeros(1, n); q = n;  % order of non-increasing distance
			    Gu = A;
			    V = u;
			    while V
			        Gu(:, V) = 0;  % remove remaining in-edges
			        for v = V
			            Q(q) = v; q = q-1;
			            W = find(Gu(v, :));  % neighbors of v
			            for w = W
			                if D(w)
			                    NP(w) = NP(w) + NP(v);  % NP(u->w) sum of old and new
			                    P(w, v) = 1;  % v is a predecessor
			                else
			                    D(w) = 1;
			                    NP(w) = NP(v);  % NP(u->w) = NP of new path
			                    P(w, v) = 1;  % v is a predecessor
			                end
			            end
			        end
			        V = find(any(Gu(V, :), 1));
			    end
			    if ~all(D)  % if some vertices unreachable,
			        Q(1:q) = find(~D);  % ...these are first-in-line
			    end
			    DP = zeros(n, 1);  % dependency
			    for w=Q(1:n-1)
			        BC(w) = BC(w) + DP(w);
			        for v = find(P(w, :))
			            DPvw = (1+DP(w)).*NP(v)./NP(w);
			            DP(v) = DP(v) + DPvw;
			            EBC(v, w) = EBC(v, w) + DPvw;
			        end
			    end
			end
			binary_edge_betweenness_centrality = EBC;
			binary_edge_betweenness_centrality(isnan(binary_edge_betweenness_centrality)) = 0;  % Should return zeros, not NaN
			end
			function weighted_edge_betweenness_centrality = getWeightedCalculation(A)
			% GETWEIGHTEDCALCULATION calculates the edge betweenness centrality value of a weighted adjacency matrix
			%
			% WEIGHTED_EDGE_BETWEENNESS_CENTRALITY  = GETWEIGHTEDCALCULATION(m, A)
			% returns the value of the edge betweenness centrality of a weighted
			% adjacency matrix A.
			
			n = length(A);
			BC = zeros(n,1);  % vertex betweenness
			EBC = zeros(n);  % edge betweenness
			for u=1:n
			    D = inf(1, n); D(u) = 0;  % distance from u
			    NP = zeros(1, n); NP(u) = 1;  % number of paths from u
			    S = true(1, n);  % distance permanence (true is temporary)
			    P = false(n);  % predecessors
			    Q = zeros(1, n); q = n;  % order of non-increasing distance
			    G1 = A;
			    V = u;
			    while 1
			        S(V) = 0;  % distance u->V is now permanent
			        G1(:, V) = 0;  % no in-edges as already shortest
			        for v = V
			            Q(q) = v; q = q-1;
			            W = find(G1(v, :));  % neighbors of v
			            for w = W
			                Duw = D(v) + G1(v, w);  % path length to be tested
			                if Duw < D(w)  % if new u->w shorter than old
			                    D(w) = Duw;
			                    NP(w) = NP(v);  % NP(u->w) = NP of new path
			                    P(w,: ) = 0;
			                    P(w, v) = 1;  % v is the only predecessor
			                elseif Duw == D(w)  % if new u->w equal to old
			                    NP(w) = NP(w) + NP(v);  % NP(u->w) sum of old and new
			                    P(w, v) = 1;  % v is also a predecessor
			                end
			            end
			        end
			        minD = min(D(S));
			        if isempty(minD), break  % all nodes reached, or
			        elseif isinf(minD)  % ...some cannot be reached:
			            Q(1:q) = find(isinf(D)); break	 % ...these are first-in-line
			        end
			        V = find(D == minD);
			    end
			    DP=zeros(n, 1);  % dependency
			    for w = Q(1:n-1)
			        BC(w) = BC(w) + DP(w);
			        for v = find(P(w,:))
			            DPvw = (1+DP(w)).*NP(v)./NP(w);
			            DP(v) = DP(v) + DPvw;
			            EBC(v, w) = EBC(v, w) + DPvw;
			        end
			    end
			end
			weighted_edge_betweenness_centrality = EBC;
			weighted_edge_betweenness_centrality(isnan(weighted_edge_betweenness_centrality)) = 0;  % Should return zeros, not NaN
			end
		end
	end
end
