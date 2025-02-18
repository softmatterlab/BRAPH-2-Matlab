classdef (Sealed=true) Callback < Element
	%Callback is a callback for a property of an element.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% A callback refers to a property of another element, which are identified 
	%  by its properties EL and PROP/TAG.
	% For computational efficiency, it is best to use only one instance of Callback
	%  for each prop of an instance of a concrete element EL, using 
	%  EL.getCallback('PROP', <prop number>) or EL.getCallback('TAG', <prop tag>),
	%  instead of creating new callback instances using its constructor. 
	% No element can be a subclass of Callback.
	%
	% The list of Callback properties is:
	%  <strong>1</strong> <strong>EL</strong> 	EL (data, item) is the callback element.
	%  <strong>2</strong> <strong>PROP</strong> 	PROP (data, scalar) is the callback property number.
	%  <strong>3</strong> <strong>TAG</strong> 	TAG (data, string) is the callback property tag.
	%  <strong>4</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the object.
	%
	% Callback methods (constructor):
	%  Callback - constructor
	%
	% Callback methods:
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
	% Callback methods (display):
	%  tostring - string with information about the callback
	%  disp - displays information about the callback
	%  tree - displays the tree of the callback
	%
	% Callback methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two callback are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the callback
	%
	% Callback methods (save/load, Static):
	%  save - saves BRAPH2 callback as b2 file
	%  load - loads a BRAPH2 callback from a b2 file
	%
	% Callback method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the callback
	%
	% Callback method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the callback
	%
	% Callback methods (inspection, Static):
	%  getClass - returns the class of the callback
	%  getSubclasses - returns all subclasses of Callback
	%  getProps - returns the property list of the callback
	%  getPropNumber - returns the property number of the callback
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
	% Callback methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Callback methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Callback methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Callback methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Callback; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Callback constants</a>.
	%
	%
	% See also Element.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		EL = 1; %CET: Computational Efficiency Trick
		EL_TAG = 'EL';
		EL_CATEGORY = 4;
		EL_FORMAT = 8;
		
		PROP = 2; %CET: Computational Efficiency Trick
		PROP_TAG = 'PROP';
		PROP_CATEGORY = 4;
		PROP_FORMAT = 11;
		
		TAG = 3; %CET: Computational Efficiency Trick
		TAG_TAG = 'TAG';
		TAG_CATEGORY = 4;
		TAG_FORMAT = 2;
		
		TOSTRING = 4; %CET: Computational Efficiency Trick
		TOSTRING_TAG = 'TOSTRING';
		TOSTRING_CATEGORY = 6;
		TOSTRING_FORMAT = 2;
	end
	methods % constructor
		function cb = Callback(varargin)
			%Callback() creates a callback.
			%
			% Callback(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Callback(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Callback properties is:
			%  <strong>1</strong> <strong>EL</strong> 	EL (data, item) is the callback element.
			%  <strong>2</strong> <strong>PROP</strong> 	PROP (data, scalar) is the callback property number.
			%  <strong>3</strong> <strong>TAG</strong> 	TAG (data, string) is the callback property tag.
			%  <strong>4</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the object.
			%
			% See also Category, Format.
			
			cb = cb@Element(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the callback.
			%
			% BUILD = Callback.GETBUILD() returns the build of 'Callback'.
			%
			% Alternative forms to call this method are:
			%  BUILD = CB.GETBUILD() returns the build of the callback CB.
			%  BUILD = Element.GETBUILD(CB) returns the build of 'CB'.
			%  BUILD = Element.GETBUILD('Callback') returns the build of 'Callback'.
			%
			% Note that the Element.GETBUILD(CB) and Element.GETBUILD('Callback')
			%  are less computationally efficient.
			
			build = 1;
		end
		function cb_class = getClass()
			%GETCLASS returns the class of the callback.
			%
			% CLASS = Callback.GETCLASS() returns the class 'Callback'.
			%
			% Alternative forms to call this method are:
			%  CLASS = CB.GETCLASS() returns the class of the callback CB.
			%  CLASS = Element.GETCLASS(CB) returns the class of 'CB'.
			%  CLASS = Element.GETCLASS('Callback') returns 'Callback'.
			%
			% Note that the Element.GETCLASS(CB) and Element.GETCLASS('Callback')
			%  are less computationally efficient.
			
			cb_class = 'Callback';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the callback.
			%
			% LIST = Callback.GETSUBCLASSES() returns all subclasses of 'Callback'.
			%
			% Alternative forms to call this method are:
			%  LIST = CB.GETSUBCLASSES() returns all subclasses of the callback CB.
			%  LIST = Element.GETSUBCLASSES(CB) returns all subclasses of 'CB'.
			%  LIST = Element.GETSUBCLASSES('Callback') returns all subclasses of 'Callback'.
			%
			% Note that the Element.GETSUBCLASSES(CB) and Element.GETSUBCLASSES('Callback')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'Callback' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of callback.
			%
			% PROPS = Callback.GETPROPS() returns the property list of callback
			%  as a row vector.
			%
			% PROPS = Callback.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = CB.GETPROPS([CATEGORY]) returns the property list of the callback CB.
			%  PROPS = Element.GETPROPS(CB[, CATEGORY]) returns the property list of 'CB'.
			%  PROPS = Element.GETPROPS('Callback'[, CATEGORY]) returns the property list of 'Callback'.
			%
			% Note that the Element.GETPROPS(CB) and Element.GETPROPS('Callback')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4];
				return
			end
			
			switch category
				case 4 % Category.DATA
					prop_list = [1 2 3];
				case 6 % Category.QUERY
					prop_list = 4;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of callback.
			%
			% N = Callback.GETPROPNUMBER() returns the property number of callback.
			%
			% N = Callback.GETPROPNUMBER(CATEGORY) returns the property number of callback
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = CB.GETPROPNUMBER([CATEGORY]) returns the property number of the callback CB.
			%  N = Element.GETPROPNUMBER(CB) returns the property number of 'CB'.
			%  N = Element.GETPROPNUMBER('Callback') returns the property number of 'Callback'.
			%
			% Note that the Element.GETPROPNUMBER(CB) and Element.GETPROPNUMBER('Callback')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 4;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 4 % Category.DATA
					prop_number = 3;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in callback/error.
			%
			% CHECK = Callback.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CB.EXISTSPROP(PROP) checks whether PROP exists for CB.
			%  CHECK = Element.EXISTSPROP(CB, PROP) checks whether PROP exists for CB.
			%  CHECK = Element.EXISTSPROP(Callback, PROP) checks whether PROP exists for Callback.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Callback:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CB.EXISTSPROP(PROP) throws error if PROP does NOT exist for CB.
			%   Error id: [BRAPH2:Callback:WrongInput]
			%  Element.EXISTSPROP(CB, PROP) throws error if PROP does NOT exist for CB.
			%   Error id: [BRAPH2:Callback:WrongInput]
			%  Element.EXISTSPROP(Callback, PROP) throws error if PROP does NOT exist for Callback.
			%   Error id: [BRAPH2:Callback:WrongInput]
			%
			% Note that the Element.EXISTSPROP(CB) and Element.EXISTSPROP('Callback')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 4 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Callback:' 'WrongInput'], ...
					['BRAPH2' ':Callback:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Callback.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in callback/error.
			%
			% CHECK = Callback.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CB.EXISTSTAG(TAG) checks whether TAG exists for CB.
			%  CHECK = Element.EXISTSTAG(CB, TAG) checks whether TAG exists for CB.
			%  CHECK = Element.EXISTSTAG(Callback, TAG) checks whether TAG exists for Callback.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Callback:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CB.EXISTSTAG(TAG) throws error if TAG does NOT exist for CB.
			%   Error id: [BRAPH2:Callback:WrongInput]
			%  Element.EXISTSTAG(CB, TAG) throws error if TAG does NOT exist for CB.
			%   Error id: [BRAPH2:Callback:WrongInput]
			%  Element.EXISTSTAG(Callback, TAG) throws error if TAG does NOT exist for Callback.
			%   Error id: [BRAPH2:Callback:WrongInput]
			%
			% Note that the Element.EXISTSTAG(CB) and Element.EXISTSTAG('Callback')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'EL'  'PROP'  'TAG'  'TOSTRING' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Callback:' 'WrongInput'], ...
					['BRAPH2' ':Callback:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for Callback.'] ...
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
			%  PROPERTY = CB.GETPROPPROP(POINTER) returns property number of POINTER of CB.
			%  PROPERTY = Element.GETPROPPROP(Callback, POINTER) returns property number of POINTER of Callback.
			%  PROPERTY = CB.GETPROPPROP(Callback, POINTER) returns property number of POINTER of Callback.
			%
			% Note that the Element.GETPROPPROP(CB) and Element.GETPROPPROP('Callback')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'EL'  'PROP'  'TAG'  'TOSTRING' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = CB.GETPROPTAG(POINTER) returns tag of POINTER of CB.
			%  TAG = Element.GETPROPTAG(Callback, POINTER) returns tag of POINTER of Callback.
			%  TAG = CB.GETPROPTAG(Callback, POINTER) returns tag of POINTER of Callback.
			%
			% Note that the Element.GETPROPTAG(CB) and Element.GETPROPTAG('Callback')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				callback_tag_list = { 'EL'  'PROP'  'TAG'  'TOSTRING' };
				tag = callback_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = CB.GETPROPCATEGORY(POINTER) returns category of POINTER of CB.
			%  CATEGORY = Element.GETPROPCATEGORY(Callback, POINTER) returns category of POINTER of Callback.
			%  CATEGORY = CB.GETPROPCATEGORY(Callback, POINTER) returns category of POINTER of Callback.
			%
			% Note that the Element.GETPROPCATEGORY(CB) and Element.GETPROPCATEGORY('Callback')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Callback.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			callback_category_list = { 4  4  4  6 };
			prop_category = callback_category_list{prop};
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
			%  FORMAT = CB.GETPROPFORMAT(POINTER) returns format of POINTER of CB.
			%  FORMAT = Element.GETPROPFORMAT(Callback, POINTER) returns format of POINTER of Callback.
			%  FORMAT = CB.GETPROPFORMAT(Callback, POINTER) returns format of POINTER of Callback.
			%
			% Note that the Element.GETPROPFORMAT(CB) and Element.GETPROPFORMAT('Callback')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Callback.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			callback_format_list = { 8  11  2  2 };
			prop_format = callback_format_list{prop};
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
			%  DESCRIPTION = CB.GETPROPDESCRIPTION(POINTER) returns description of POINTER of CB.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Callback, POINTER) returns description of POINTER of Callback.
			%  DESCRIPTION = CB.GETPROPDESCRIPTION(Callback, POINTER) returns description of POINTER of Callback.
			%
			% Note that the Element.GETPROPDESCRIPTION(CB) and Element.GETPROPDESCRIPTION('Callback')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Callback.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			callback_description_list = { 'EL (data, item) is the callback element.'  'PROP (data, scalar) is the callback property number.'  'TAG (data, string) is the callback property tag.'  'TOSTRING (query, string) returns a string that represents the object.' };
			prop_description = callback_description_list{prop};
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
			%  SETTINGS = CB.GETPROPSETTINGS(POINTER) returns settings of POINTER of CB.
			%  SETTINGS = Element.GETPROPSETTINGS(Callback, POINTER) returns settings of POINTER of Callback.
			%  SETTINGS = CB.GETPROPSETTINGS(Callback, POINTER) returns settings of POINTER of Callback.
			%
			% Note that the Element.GETPROPSETTINGS(CB) and Element.GETPROPSETTINGS('Callback')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Callback.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % Callback.EL
					prop_settings = 'ConcreteElement';
				case 2 % Callback.PROP
					prop_settings = Format.getFormatSettings(11);
				case 3 % Callback.TAG
					prop_settings = Format.getFormatSettings(2);
				case 4 % Callback.TOSTRING
					prop_settings = Format.getFormatSettings(2);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Callback.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Callback.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CB.GETPROPDEFAULT(POINTER) returns the default value of POINTER of CB.
			%  DEFAULT = Element.GETPROPDEFAULT(Callback, POINTER) returns the default value of POINTER of Callback.
			%  DEFAULT = CB.GETPROPDEFAULT(Callback, POINTER) returns the default value of POINTER of Callback.
			%
			% Note that the Element.GETPROPDEFAULT(CB) and Element.GETPROPDEFAULT('Callback')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Callback.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % Callback.EL
					prop_default = Format.getFormatDefault(8, Callback.getPropSettings(prop));
				case 2 % Callback.PROP
					prop_default = Format.getFormatDefault(11, Callback.getPropSettings(prop));
				case 3 % Callback.TAG
					prop_default = Format.getFormatDefault(2, Callback.getPropSettings(prop));
				case 4 % Callback.TOSTRING
					prop_default = Format.getFormatDefault(2, Callback.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Callback.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Callback.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CB.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of CB.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Callback, POINTER) returns the conditioned default value of POINTER of Callback.
			%  DEFAULT = CB.GETPROPDEFAULTCONDITIONED(Callback, POINTER) returns the conditioned default value of POINTER of Callback.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(CB) and Element.GETPROPDEFAULTCONDITIONED('Callback')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Callback.getPropProp(pointer);
			
			prop_default = Callback.conditioning(prop, Callback.getPropDefault(prop));
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
			% CHECK = CB.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = CB.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of CB.
			%  CHECK = Element.CHECKPROP(Callback, PROP, VALUE) checks VALUE format for PROP of Callback.
			%  CHECK = CB.CHECKPROP(Callback, PROP, VALUE) checks VALUE format for PROP of Callback.
			% 
			% CB.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:Callback:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CB.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of CB.
			%   Error id: BRAPH2:Callback:WrongInput
			%  Element.CHECKPROP(Callback, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Callback.
			%   Error id: BRAPH2:Callback:WrongInput
			%  CB.CHECKPROP(Callback, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Callback.
			%   Error id: BRAPH2:Callback:WrongInput]
			% 
			% Note that the Element.CHECKPROP(CB) and Element.CHECKPROP('Callback')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Callback.getPropProp(pointer);
			
			switch prop
				case 1 % Callback.EL
					check = Format.checkFormat(8, value, Callback.getPropSettings(prop));
				case 2 % Callback.PROP
					check = Format.checkFormat(11, value, Callback.getPropSettings(prop));
				case 3 % Callback.TAG
					check = Format.checkFormat(2, value, Callback.getPropSettings(prop));
				case 4 % Callback.TOSTRING
					check = Format.checkFormat(2, value, Callback.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Callback:' 'WrongInput'], ...
					['BRAPH2' ':Callback:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Callback.getPropTag(prop) ' (' Callback.getFormatTag(Callback.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(cb, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case 2 % Callback.PROP
					el = cb.get('EL');
					prop = cb.get('PROP');
					if ~strcmp(cb.get('TAG'), el.getPropTag(prop))
					    cb.set('TAG', el.getPropTag(prop));
					end
					
				case 3 % Callback.TAG
					el = cb.get('EL');
					tag = cb.get('TAG');
					if cb.get('PROP') ~= el.getPropProp(tag)
					    cb.set('PROP', el.getPropProp(tag));
					end
					
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(cb, prop, varargin)
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
				case 4 % Callback.TOSTRING
					value = cb.tostring();
					
				otherwise
					if prop <= Element.getPropNumber()
						value = calculateValue@Element(cb, prop, varargin{:});
					else
						value = calculateValue@Element(cb, prop, varargin{:});
					end
			end
			
		end
	end
end
