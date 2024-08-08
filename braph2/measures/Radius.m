classdef Radius < Measure
	%Radius is the graph Radius.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Radius (Radius) is the minimum eccentricity among the vertices within a layer.
	%
	% Radius methods (constructor):
	%  Radius - constructor
	%
	% Radius methods:
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
	% Radius methods (display):
	%  tostring - string with information about the radius
	%  disp - displays information about the radius
	%  tree - displays the tree of the radius
	%
	% Radius methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two radius are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the radius
	%
	% Radius methods (save/load, Static):
	%  save - saves BRAPH2 radius as b2 file
	%  load - loads a BRAPH2 radius from a b2 file
	%
	% Radius method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the radius
	%
	% Radius method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the radius
	%
	% Radius methods (inspection, Static):
	%  getClass - returns the class of the radius
	%  getSubclasses - returns all subclasses of Radius
	%  getProps - returns the property list of the radius
	%  getPropNumber - returns the property number of the radius
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
	% Radius methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Radius methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Radius methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Radius methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Radius; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Radius constants</a>.
	%
	
	properties (Constant) % properties
		RULE = Measure.getPropNumber() + 1;
		RULE_TAG = 'RULE';
		RULE_CATEGORY = Category.PARAMETER;
		RULE_FORMAT = Format.OPTION;
	end
	methods % constructor
		function m = Radius(varargin)
			%Radius() creates a radius.
			%
			% Radius(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Radius(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the radius.
			%
			% CLASS = Radius.GETCLASS() returns the class 'Radius'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the radius M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Radius') returns 'Radius'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('Radius')
			%  are less computationally efficient.
			
			m_class = 'Radius';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the radius.
			%
			% LIST = Radius.GETSUBCLASSES() returns all subclasses of 'Radius'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the radius M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('Radius') returns all subclasses of 'Radius'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('Radius')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Radius', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of radius.
			%
			% PROPS = Radius.GETPROPS() returns the property list of radius
			%  as a row vector.
			%
			% PROPS = Radius.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the radius M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Radius'[, CATEGORY]) returns the property list of 'Radius'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('Radius')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						Radius.RULE ...
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
						Radius.RULE ...
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
			%GETPROPNUMBER returns the property number of radius.
			%
			% N = Radius.GETPROPNUMBER() returns the property number of radius.
			%
			% N = Radius.GETPROPNUMBER(CATEGORY) returns the property number of radius
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the radius M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Radius') returns the property number of 'Radius'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('Radius')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Radius.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in radius/error.
			%
			% CHECK = Radius.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Radius, PROP) checks whether PROP exists for Radius.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Radius:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Radius:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Radius:WrongInput]
			%  Element.EXISTSPROP(Radius, PROP) throws error if PROP does NOT exist for Radius.
			%   Error id: [BRAPH2:Radius:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('Radius')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Radius.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Radius:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Radius:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Radius.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in radius/error.
			%
			% CHECK = Radius.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Radius, TAG) checks whether TAG exists for Radius.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Radius:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Radius:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Radius:WrongInput]
			%  Element.EXISTSTAG(Radius, TAG) throws error if TAG does NOT exist for Radius.
			%   Error id: [BRAPH2:Radius:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('Radius')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			radius_tag_list = cellfun(@(x) Radius.getPropTag(x), num2cell(Radius.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, radius_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Radius:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Radius:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Radius.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Radius, POINTER) returns property number of POINTER of Radius.
			%  PROPERTY = M.GETPROPPROP(Radius, POINTER) returns property number of POINTER of Radius.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('Radius')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				radius_tag_list = cellfun(@(x) Radius.getPropTag(x), num2cell(Radius.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, radius_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(Radius, POINTER) returns tag of POINTER of Radius.
			%  TAG = M.GETPROPTAG(Radius, POINTER) returns tag of POINTER of Radius.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('Radius')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case Radius.RULE
						tag = Radius.RULE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(Radius, POINTER) returns category of POINTER of Radius.
			%  CATEGORY = M.GETPROPCATEGORY(Radius, POINTER) returns category of POINTER of Radius.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('Radius')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Radius.getPropProp(pointer);
			
			switch prop
				case Radius.RULE
					prop_category = Radius.RULE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(Radius, POINTER) returns format of POINTER of Radius.
			%  FORMAT = M.GETPROPFORMAT(Radius, POINTER) returns format of POINTER of Radius.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('Radius')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Radius.getPropProp(pointer);
			
			switch prop
				case Radius.RULE
					prop_format = Radius.RULE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Radius, POINTER) returns description of POINTER of Radius.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Radius, POINTER) returns description of POINTER of Radius.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('Radius')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Radius.getPropProp(pointer);
			
			switch prop
				case Radius.RULE
					prop_description = 'RULE (parameter, OPTION) % calculation in a graph or its subgraph';
				case Radius.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Radius.';
				case Radius.NAME
					prop_description = 'NAME (constant, string) is the name of the Radius.';
				case Radius.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Radius.';
				case Radius.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Radius.';
				case Radius.ID
					prop_description = 'ID (data, string) is a few-letter code of the Radius.';
				case Radius.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Radius.';
				case Radius.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Radius.';
				case Radius.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.';
				case Radius.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case Radius.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case Radius.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case Radius.M
					prop_description = 'M (result, cell) is the Radius.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(Radius, POINTER) returns settings of POINTER of Radius.
			%  SETTINGS = M.GETPROPSETTINGS(Radius, POINTER) returns settings of POINTER of Radius.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('Radius')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Radius.getPropProp(pointer);
			
			switch prop
				case Radius.RULE
					prop_settings = {'all', 'subgraphs'};
				case Radius.TEMPLATE
					prop_settings = 'Radius';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Radius.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Radius.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Radius, POINTER) returns the default value of POINTER of Radius.
			%  DEFAULT = M.GETPROPDEFAULT(Radius, POINTER) returns the default value of POINTER of Radius.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('Radius')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Radius.getPropProp(pointer);
			
			switch prop
				case Radius.RULE
					prop_default = 'all';
				case Radius.ELCLASS
					prop_default = 'Radius';
				case Radius.NAME
					prop_default = 'Radius';
				case Radius.DESCRIPTION
					prop_default = 'The Radius (Radius) is the minimum eccentricity among the vertices within a layer.';
				case Radius.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, Radius.getPropSettings(prop));
				case Radius.ID
					prop_default = 'Radius ID';
				case Radius.LABEL
					prop_default = 'Radius label';
				case Radius.NOTES
					prop_default = 'Radius notes';
				case Radius.SHAPE
					prop_default = Measure.GLOBAL;
				case Radius.SCOPE
					prop_default = Measure.UNILAYER;
				case Radius.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case Radius.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Radius.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Radius.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Radius, POINTER) returns the conditioned default value of POINTER of Radius.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Radius, POINTER) returns the conditioned default value of POINTER of Radius.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('Radius')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Radius.getPropProp(pointer);
			
			prop_default = Radius.conditioning(prop, Radius.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Radius, PROP, VALUE) checks VALUE format for PROP of Radius.
			%  CHECK = M.CHECKPROP(Radius, PROP, VALUE) checks VALUE format for PROP of Radius.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Radius:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:Radius:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Radius, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Radius.
			%   Error id: €BRAPH2.STR€:Radius:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(Radius, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Radius.
			%   Error id: €BRAPH2.STR€:Radius:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('Radius')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Radius.getPropProp(pointer);
			
			switch prop
				case Radius.RULE % __Radius.RULE__
					check = Format.checkFormat(Format.OPTION, value, Radius.getPropSettings(prop));
				case Radius.TEMPLATE % __Radius.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, Radius.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Radius:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Radius:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Radius.getPropTag(prop) ' (' Radius.getFormatTag(Radius.getPropFormat(prop)) ').'] ...
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
				case Radius.M % __Radius.M__
					rng_settings_ = rng(); rng(m.getPropSeed(Radius.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell matrix for graph, multigraph, or multiplex, etc
					L = g.get('LAYERNUMBER');
					eccentricity = Eccentricity('G', g, 'RULE', m.get('RULE')).get('M');
					radius = cell(L, 1);
					
					parfor li = 1:1:L
					    radius(li) = {min(eccentricity{li})};
					end
					
					value = radius;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Measure.getPropNumber()
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
