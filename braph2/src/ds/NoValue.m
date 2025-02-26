classdef (Sealed=true) NoValue < Element
	%NoValue represents a value that has not been set or calculated.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% NoValue is an element without values used to represent a value that has
	%  not been set (for properties of categories METADATA, PARAMETER, DATA, FIGURE or GUI) 
	%  or calculated (for properties of category RESULT, QUERY, EVANESCENT), 
	%  while it should not be used for properties of category CONSTANT.
	% For computational efficiency, it is best to use only one instance of NoValue 
	%  using Element.getNoValue(), instead of creating new instances using the 
	%  constructor NoValue(). 
	% No element can be a subclass of NoValue.
	%
	% NoValue has no properties.
	%
	% NoValue methods (constructor):
	%  NoValue - constructor
	%
	% NoValue methods:
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
	% NoValue methods (display):
	%  tostring - string with information about the NoValue
	%  disp - displays information about the NoValue
	%  tree - displays the tree of the NoValue
	%
	% NoValue methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two NoValue are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the NoValue
	%
	% NoValue methods (save/load, Static):
	%  save - saves BRAPH2 NoValue as b2 file
	%  load - loads a BRAPH2 NoValue from a b2 file
	%
	% NoValue method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the NoValue
	%
	% NoValue method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the NoValue
	%
	% NoValue methods (inspection, Static):
	%  getClass - returns the class of the NoValue
	%  getSubclasses - returns all subclasses of NoValue
	%  getProps - returns the property list of the NoValue
	%  getPropNumber - returns the property number of the NoValue
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
	% NoValue methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NoValue methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NoValue methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NoValue methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NoValue; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NoValue constants</a>.
	%
	%
	% See also ConcreteElement.
	%
	% BUILD BRAPH2 7 class_name 1
	
	methods % constructor
		function nv = NoValue(varargin)
			%NoValue() creates a NoValue.
			%
			% NoValue(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NoValue(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% NoValue has no properties.
			%
			% See also Category, Format.
			
			nv = nv@Element(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the NoValue.
			%
			% BUILD = NoValue.GETBUILD() returns the build of 'NoValue'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NV.GETBUILD() returns the build of the NoValue NV.
			%  BUILD = Element.GETBUILD(NV) returns the build of 'NV'.
			%  BUILD = Element.GETBUILD('NoValue') returns the build of 'NoValue'.
			%
			% Note that the Element.GETBUILD(NV) and Element.GETBUILD('NoValue')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nv_class = getClass()
			%GETCLASS returns the class of the NoValue.
			%
			% CLASS = NoValue.GETCLASS() returns the class 'NoValue'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NV.GETCLASS() returns the class of the NoValue NV.
			%  CLASS = Element.GETCLASS(NV) returns the class of 'NV'.
			%  CLASS = Element.GETCLASS('NoValue') returns 'NoValue'.
			%
			% Note that the Element.GETCLASS(NV) and Element.GETCLASS('NoValue')
			%  are less computationally efficient.
			
			nv_class = 'NoValue';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the NoValue.
			%
			% LIST = NoValue.GETSUBCLASSES() returns all subclasses of 'NoValue'.
			%
			% Alternative forms to call this method are:
			%  LIST = NV.GETSUBCLASSES() returns all subclasses of the NoValue NV.
			%  LIST = Element.GETSUBCLASSES(NV) returns all subclasses of 'NV'.
			%  LIST = Element.GETSUBCLASSES('NoValue') returns all subclasses of 'NoValue'.
			%
			% Note that the Element.GETSUBCLASSES(NV) and Element.GETSUBCLASSES('NoValue')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NoValue' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of NoValue.
			%
			% PROPS = NoValue.GETPROPS() returns the property list of NoValue
			%  as a row vector.
			%
			% PROPS = NoValue.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NV.GETPROPS([CATEGORY]) returns the property list of the NoValue NV.
			%  PROPS = Element.GETPROPS(NV[, CATEGORY]) returns the property list of 'NV'.
			%  PROPS = Element.GETPROPS('NoValue'[, CATEGORY]) returns the property list of 'NoValue'.
			%
			% Note that the Element.GETPROPS(NV) and Element.GETPROPS('NoValue')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [];
				return
			end
			
			switch category
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of NoValue.
			%
			% N = NoValue.GETPROPNUMBER() returns the property number of NoValue.
			%
			% N = NoValue.GETPROPNUMBER(CATEGORY) returns the property number of NoValue
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NV.GETPROPNUMBER([CATEGORY]) returns the property number of the NoValue NV.
			%  N = Element.GETPROPNUMBER(NV) returns the property number of 'NV'.
			%  N = Element.GETPROPNUMBER('NoValue') returns the property number of 'NoValue'.
			%
			% Note that the Element.GETPROPNUMBER(NV) and Element.GETPROPNUMBER('NoValue')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 0;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in NoValue/error.
			%
			% CHECK = NoValue.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NV.EXISTSPROP(PROP) checks whether PROP exists for NV.
			%  CHECK = Element.EXISTSPROP(NV, PROP) checks whether PROP exists for NV.
			%  CHECK = Element.EXISTSPROP(NoValue, PROP) checks whether PROP exists for NoValue.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NoValue:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NV.EXISTSPROP(PROP) throws error if PROP does NOT exist for NV.
			%   Error id: [BRAPH2:NoValue:WrongInput]
			%  Element.EXISTSPROP(NV, PROP) throws error if PROP does NOT exist for NV.
			%   Error id: [BRAPH2:NoValue:WrongInput]
			%  Element.EXISTSPROP(NoValue, PROP) throws error if PROP does NOT exist for NoValue.
			%   Error id: [BRAPH2:NoValue:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NV) and Element.EXISTSPROP('NoValue')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 0 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NoValue:' 'WrongInput'], ...
					['BRAPH2' ':NoValue:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NoValue.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in NoValue/error.
			%
			% CHECK = NoValue.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NV.EXISTSTAG(TAG) checks whether TAG exists for NV.
			%  CHECK = Element.EXISTSTAG(NV, TAG) checks whether TAG exists for NV.
			%  CHECK = Element.EXISTSTAG(NoValue, TAG) checks whether TAG exists for NoValue.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NoValue:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NV.EXISTSTAG(TAG) throws error if TAG does NOT exist for NV.
			%   Error id: [BRAPH2:NoValue:WrongInput]
			%  Element.EXISTSTAG(NV, TAG) throws error if TAG does NOT exist for NV.
			%   Error id: [BRAPH2:NoValue:WrongInput]
			%  Element.EXISTSTAG(NoValue, TAG) throws error if TAG does NOT exist for NoValue.
			%   Error id: [BRAPH2:NoValue:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NV) and Element.EXISTSTAG('NoValue')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, {})); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NoValue:' 'WrongInput'], ...
					['BRAPH2' ':NoValue:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NoValue.'] ...
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
			%  PROPERTY = NV.GETPROPPROP(POINTER) returns property number of POINTER of NV.
			%  PROPERTY = Element.GETPROPPROP(NoValue, POINTER) returns property number of POINTER of NoValue.
			%  PROPERTY = NV.GETPROPPROP(NoValue, POINTER) returns property number of POINTER of NoValue.
			%
			% Note that the Element.GETPROPPROP(NV) and Element.GETPROPPROP('NoValue')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, {})); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = NV.GETPROPTAG(POINTER) returns tag of POINTER of NV.
			%  TAG = Element.GETPROPTAG(NoValue, POINTER) returns tag of POINTER of NoValue.
			%  TAG = NV.GETPROPTAG(NoValue, POINTER) returns tag of POINTER of NoValue.
			%
			% Note that the Element.GETPROPTAG(NV) and Element.GETPROPTAG('NoValue')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				novalue_tag_list = {}; % will throw an error if called
				tag = novalue_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = NV.GETPROPCATEGORY(POINTER) returns category of POINTER of NV.
			%  CATEGORY = Element.GETPROPCATEGORY(NoValue, POINTER) returns category of POINTER of NoValue.
			%  CATEGORY = NV.GETPROPCATEGORY(NoValue, POINTER) returns category of POINTER of NoValue.
			%
			% Note that the Element.GETPROPCATEGORY(NV) and Element.GETPROPCATEGORY('NoValue')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NoValue.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			novalue_category_list = {};
			prop_category = novalue_category_list{prop};
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
			%  FORMAT = NV.GETPROPFORMAT(POINTER) returns format of POINTER of NV.
			%  FORMAT = Element.GETPROPFORMAT(NoValue, POINTER) returns format of POINTER of NoValue.
			%  FORMAT = NV.GETPROPFORMAT(NoValue, POINTER) returns format of POINTER of NoValue.
			%
			% Note that the Element.GETPROPFORMAT(NV) and Element.GETPROPFORMAT('NoValue')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NoValue.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			novalue_format_list = {};
			prop_format = novalue_format_list{prop};
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
			%  DESCRIPTION = NV.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NV.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NoValue, POINTER) returns description of POINTER of NoValue.
			%  DESCRIPTION = NV.GETPROPDESCRIPTION(NoValue, POINTER) returns description of POINTER of NoValue.
			%
			% Note that the Element.GETPROPDESCRIPTION(NV) and Element.GETPROPDESCRIPTION('NoValue')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NoValue.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			novalue_description_list = {};
			prop_description = novalue_description_list{prop};
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
			%  SETTINGS = NV.GETPROPSETTINGS(POINTER) returns settings of POINTER of NV.
			%  SETTINGS = Element.GETPROPSETTINGS(NoValue, POINTER) returns settings of POINTER of NoValue.
			%  SETTINGS = NV.GETPROPSETTINGS(NoValue, POINTER) returns settings of POINTER of NoValue.
			%
			% Note that the Element.GETPROPSETTINGS(NV) and Element.GETPROPSETTINGS('NoValue')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NoValue.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NoValue.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NoValue.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NV.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NV.
			%  DEFAULT = Element.GETPROPDEFAULT(NoValue, POINTER) returns the default value of POINTER of NoValue.
			%  DEFAULT = NV.GETPROPDEFAULT(NoValue, POINTER) returns the default value of POINTER of NoValue.
			%
			% Note that the Element.GETPROPDEFAULT(NV) and Element.GETPROPDEFAULT('NoValue')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NoValue.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NoValue.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NoValue.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NV.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NV.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NoValue, POINTER) returns the conditioned default value of POINTER of NoValue.
			%  DEFAULT = NV.GETPROPDEFAULTCONDITIONED(NoValue, POINTER) returns the conditioned default value of POINTER of NoValue.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NV) and Element.GETPROPDEFAULTCONDITIONED('NoValue')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NoValue.getPropProp(pointer);
			
			prop_default = NoValue.conditioning(prop, NoValue.getPropDefault(prop));
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(~, value)
			%CONDITIONING conditions a value before setting a property.
			%
			% VALUE = CONDITIONING(EL, PROP, VALUE) conditions the value VALUE before
			%  it is set as the value of the property PROP.
			%  By default, this function does not do anything, so it should be
			%  implemented in the subclasses of Element when needed.
			%
			% Conditioning is only used for props of 2,
			%  3, 4, 8 and 9.
			%
			% See also preset, checkProp, postset, postprocessing, calculateValue,
			%  checkValue.
			
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NV.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NV.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NV.
			%  CHECK = Element.CHECKPROP(NoValue, PROP, VALUE) checks VALUE format for PROP of NoValue.
			%  CHECK = NV.CHECKPROP(NoValue, PROP, VALUE) checks VALUE format for PROP of NoValue.
			% 
			% NV.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NoValue:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NV.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NV.
			%   Error id: BRAPH2:NoValue:WrongInput
			%  Element.CHECKPROP(NoValue, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NoValue.
			%   Error id: BRAPH2:NoValue:WrongInput
			%  NV.CHECKPROP(NoValue, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NoValue.
			%   Error id: BRAPH2:NoValue:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NV) and Element.CHECKPROP('NoValue')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NoValue.getPropProp(pointer);
			
			switch prop
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NoValue:' 'WrongInput'], ...
					['BRAPH2' ':NoValue:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NoValue.getPropTag(prop) ' (' NoValue.getFormatTag(NoValue.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
