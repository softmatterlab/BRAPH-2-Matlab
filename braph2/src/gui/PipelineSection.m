classdef PipelineSection < ConcreteElement
	%PipelineSection is a pipeline code section.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Pipeline Section (PipelineSection) represents a section of executable code in a pipeline.
	%
	% The list of PipelineSection properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the pipeline section.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the pipeline section.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the pipeline section.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the pipeline section.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the pipeline section.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the pipeline section.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the pipeline section.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>PC_DICT</strong> 	PC_DICT (data, idict) is an indexed dictionary with the executable code lines.
	%
	% PipelineSection methods (constructor):
	%  PipelineSection - constructor
	%
	% PipelineSection methods:
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
	% PipelineSection methods (display):
	%  tostring - string with information about the pipeline section
	%  disp - displays information about the pipeline section
	%  tree - displays the tree of the pipeline section
	%
	% PipelineSection methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two pipeline section are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the pipeline section
	%
	% PipelineSection methods (save/load, Static):
	%  save - saves BRAPH2 pipeline section as b2 file
	%  load - loads a BRAPH2 pipeline section from a b2 file
	%
	% PipelineSection method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the pipeline section
	%
	% PipelineSection method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the pipeline section
	%
	% PipelineSection methods (inspection, Static):
	%  getClass - returns the class of the pipeline section
	%  getSubclasses - returns all subclasses of PipelineSection
	%  getProps - returns the property list of the pipeline section
	%  getPropNumber - returns the property number of the pipeline section
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
	% PipelineSection methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PipelineSection methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PipelineSection methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PipelineSection methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PipelineSection; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PipelineSection constants</a>.
	%
	%
	% See also PipelinePP_PSDict, Pipeline, PipelineSection.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		PC_DICT = 9; %CET: Computational Efficiency Trick
		PC_DICT_TAG = 'PC_DICT';
		PC_DICT_CATEGORY = 4;
		PC_DICT_FORMAT = 10;
	end
	methods % constructor
		function ps = PipelineSection(varargin)
			%PipelineSection() creates a pipeline section.
			%
			% PipelineSection(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PipelineSection(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PipelineSection properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the pipeline section.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the pipeline section.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the pipeline section.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the pipeline section.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the pipeline section.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the pipeline section.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the pipeline section.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>PC_DICT</strong> 	PC_DICT (data, idict) is an indexed dictionary with the executable code lines.
			%
			% See also Category, Format.
			
			ps = ps@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the pipeline section.
			%
			% BUILD = PipelineSection.GETBUILD() returns the build of 'PipelineSection'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PS.GETBUILD() returns the build of the pipeline section PS.
			%  BUILD = Element.GETBUILD(PS) returns the build of 'PS'.
			%  BUILD = Element.GETBUILD('PipelineSection') returns the build of 'PipelineSection'.
			%
			% Note that the Element.GETBUILD(PS) and Element.GETBUILD('PipelineSection')
			%  are less computationally efficient.
			
			build = 1;
		end
		function ps_class = getClass()
			%GETCLASS returns the class of the pipeline section.
			%
			% CLASS = PipelineSection.GETCLASS() returns the class 'PipelineSection'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PS.GETCLASS() returns the class of the pipeline section PS.
			%  CLASS = Element.GETCLASS(PS) returns the class of 'PS'.
			%  CLASS = Element.GETCLASS('PipelineSection') returns 'PipelineSection'.
			%
			% Note that the Element.GETCLASS(PS) and Element.GETCLASS('PipelineSection')
			%  are less computationally efficient.
			
			ps_class = 'PipelineSection';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the pipeline section.
			%
			% LIST = PipelineSection.GETSUBCLASSES() returns all subclasses of 'PipelineSection'.
			%
			% Alternative forms to call this method are:
			%  LIST = PS.GETSUBCLASSES() returns all subclasses of the pipeline section PS.
			%  LIST = Element.GETSUBCLASSES(PS) returns all subclasses of 'PS'.
			%  LIST = Element.GETSUBCLASSES('PipelineSection') returns all subclasses of 'PipelineSection'.
			%
			% Note that the Element.GETSUBCLASSES(PS) and Element.GETSUBCLASSES('PipelineSection')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'PipelineSection' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of pipeline section.
			%
			% PROPS = PipelineSection.GETPROPS() returns the property list of pipeline section
			%  as a row vector.
			%
			% PROPS = PipelineSection.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PS.GETPROPS([CATEGORY]) returns the property list of the pipeline section PS.
			%  PROPS = Element.GETPROPS(PS[, CATEGORY]) returns the property list of 'PS'.
			%  PROPS = Element.GETPROPS('PipelineSection'[, CATEGORY]) returns the property list of 'PipelineSection'.
			%
			% Note that the Element.GETPROPS(PS) and Element.GETPROPS('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 9];
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of pipeline section.
			%
			% N = PipelineSection.GETPROPNUMBER() returns the property number of pipeline section.
			%
			% N = PipelineSection.GETPROPNUMBER(CATEGORY) returns the property number of pipeline section
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PS.GETPROPNUMBER([CATEGORY]) returns the property number of the pipeline section PS.
			%  N = Element.GETPROPNUMBER(PS) returns the property number of 'PS'.
			%  N = Element.GETPROPNUMBER('PipelineSection') returns the property number of 'PipelineSection'.
			%
			% Note that the Element.GETPROPNUMBER(PS) and Element.GETPROPNUMBER('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 9;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in pipeline section/error.
			%
			% CHECK = PipelineSection.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PS.EXISTSPROP(PROP) checks whether PROP exists for PS.
			%  CHECK = Element.EXISTSPROP(PS, PROP) checks whether PROP exists for PS.
			%  CHECK = Element.EXISTSPROP(PipelineSection, PROP) checks whether PROP exists for PipelineSection.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PipelineSection:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PS.EXISTSPROP(PROP) throws error if PROP does NOT exist for PS.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%  Element.EXISTSPROP(PS, PROP) throws error if PROP does NOT exist for PS.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%  Element.EXISTSPROP(PipelineSection, PROP) throws error if PROP does NOT exist for PipelineSection.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PS) and Element.EXISTSPROP('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 9 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PipelineSection:' 'WrongInput'], ...
					['BRAPH2' ':PipelineSection:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PipelineSection.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in pipeline section/error.
			%
			% CHECK = PipelineSection.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PS.EXISTSTAG(TAG) checks whether TAG exists for PS.
			%  CHECK = Element.EXISTSTAG(PS, TAG) checks whether TAG exists for PS.
			%  CHECK = Element.EXISTSTAG(PipelineSection, TAG) checks whether TAG exists for PipelineSection.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PipelineSection:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PS.EXISTSTAG(TAG) throws error if TAG does NOT exist for PS.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%  Element.EXISTSTAG(PS, TAG) throws error if TAG does NOT exist for PS.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%  Element.EXISTSTAG(PipelineSection, TAG) throws error if TAG does NOT exist for PipelineSection.
			%   Error id: [BRAPH2:PipelineSection:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PS) and Element.EXISTSTAG('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PC_DICT' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PipelineSection:' 'WrongInput'], ...
					['BRAPH2' ':PipelineSection:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for PipelineSection.'] ...
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
			%  PROPERTY = PS.GETPROPPROP(POINTER) returns property number of POINTER of PS.
			%  PROPERTY = Element.GETPROPPROP(PipelineSection, POINTER) returns property number of POINTER of PipelineSection.
			%  PROPERTY = PS.GETPROPPROP(PipelineSection, POINTER) returns property number of POINTER of PipelineSection.
			%
			% Note that the Element.GETPROPPROP(PS) and Element.GETPROPPROP('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PC_DICT' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = PS.GETPROPTAG(POINTER) returns tag of POINTER of PS.
			%  TAG = Element.GETPROPTAG(PipelineSection, POINTER) returns tag of POINTER of PipelineSection.
			%  TAG = PS.GETPROPTAG(PipelineSection, POINTER) returns tag of POINTER of PipelineSection.
			%
			% Note that the Element.GETPROPTAG(PS) and Element.GETPROPTAG('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				pipelinesection_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'PC_DICT' };
				tag = pipelinesection_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = PS.GETPROPCATEGORY(POINTER) returns category of POINTER of PS.
			%  CATEGORY = Element.GETPROPCATEGORY(PipelineSection, POINTER) returns category of POINTER of PipelineSection.
			%  CATEGORY = PS.GETPROPCATEGORY(PipelineSection, POINTER) returns category of POINTER of PipelineSection.
			%
			% Note that the Element.GETPROPCATEGORY(PS) and Element.GETPROPCATEGORY('PipelineSection')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pipelinesection_category_list = { 1  1  1  3  4  2  2  6  4 };
			prop_category = pipelinesection_category_list{prop};
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
			%  FORMAT = PS.GETPROPFORMAT(POINTER) returns format of POINTER of PS.
			%  FORMAT = Element.GETPROPFORMAT(PipelineSection, POINTER) returns format of POINTER of PipelineSection.
			%  FORMAT = PS.GETPROPFORMAT(PipelineSection, POINTER) returns format of POINTER of PipelineSection.
			%
			% Note that the Element.GETPROPFORMAT(PS) and Element.GETPROPFORMAT('PipelineSection')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pipelinesection_format_list = { 2  2  2  8  2  2  2  2  10 };
			prop_format = pipelinesection_format_list{prop};
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
			%  DESCRIPTION = PS.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PS.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PipelineSection, POINTER) returns description of POINTER of PipelineSection.
			%  DESCRIPTION = PS.GETPROPDESCRIPTION(PipelineSection, POINTER) returns description of POINTER of PipelineSection.
			%
			% Note that the Element.GETPROPDESCRIPTION(PS) and Element.GETPROPDESCRIPTION('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pipelinesection_description_list = { 'ELCLASS (constant, string) is the class of the pipeline section.'  'NAME (constant, string) is the name of the pipeline section.'  'DESCRIPTION (constant, string) is the description of the pipeline section.'  'TEMPLATE (parameter, item) is the template of the pipeline section.'  'ID (data, string) is a few-letter code for the pipeline section.'  'LABEL (metadata, string) is an extended label of the pipeline section.'  'NOTES (metadata, string) are some specific notes about the pipeline section.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'PC_DICT (data, idict) is an indexed dictionary with the executable code lines.' };
			prop_description = pipelinesection_description_list{prop};
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
			%  SETTINGS = PS.GETPROPSETTINGS(POINTER) returns settings of POINTER of PS.
			%  SETTINGS = Element.GETPROPSETTINGS(PipelineSection, POINTER) returns settings of POINTER of PipelineSection.
			%  SETTINGS = PS.GETPROPSETTINGS(PipelineSection, POINTER) returns settings of POINTER of PipelineSection.
			%
			% Note that the Element.GETPROPSETTINGS(PS) and Element.GETPROPSETTINGS('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % PipelineSection.PC_DICT
					prop_settings = 'PipelineCode';
				case 4 % PipelineSection.TEMPLATE
					prop_settings = 'PipelineSection';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PipelineSection.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelineSection.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PS.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PS.
			%  DEFAULT = Element.GETPROPDEFAULT(PipelineSection, POINTER) returns the default value of POINTER of PipelineSection.
			%  DEFAULT = PS.GETPROPDEFAULT(PipelineSection, POINTER) returns the default value of POINTER of PipelineSection.
			%
			% Note that the Element.GETPROPDEFAULT(PS) and Element.GETPROPDEFAULT('PipelineSection')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % PipelineSection.PC_DICT
					prop_default = Format.getFormatDefault(10, PipelineSection.getPropSettings(prop));
				case 1 % PipelineSection.ELCLASS
					prop_default = 'PipelineSection';
				case 2 % PipelineSection.NAME
					prop_default = 'Pipeline Section';
				case 3 % PipelineSection.DESCRIPTION
					prop_default = 'A Pipeline Section (PipelineSection) represents a section of executable code in a pipeline.';
				case 4 % PipelineSection.TEMPLATE
					prop_default = Format.getFormatDefault(8, PipelineSection.getPropSettings(prop));
				case 5 % PipelineSection.ID
					prop_default = 'PipelineSection ID';
				case 6 % PipelineSection.LABEL
					prop_default = 'PipelineSection label';
				case 7 % PipelineSection.NOTES
					prop_default = 'PipelineSection notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PipelineSection.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelineSection.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PS.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PS.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PipelineSection, POINTER) returns the conditioned default value of POINTER of PipelineSection.
			%  DEFAULT = PS.GETPROPDEFAULTCONDITIONED(PipelineSection, POINTER) returns the conditioned default value of POINTER of PipelineSection.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PS) and Element.GETPROPDEFAULTCONDITIONED('PipelineSection')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PipelineSection.getPropProp(pointer);
			
			prop_default = PipelineSection.conditioning(prop, PipelineSection.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PS.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PS.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PS.
			%  CHECK = Element.CHECKPROP(PipelineSection, PROP, VALUE) checks VALUE format for PROP of PipelineSection.
			%  CHECK = PS.CHECKPROP(PipelineSection, PROP, VALUE) checks VALUE format for PROP of PipelineSection.
			% 
			% PS.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:PipelineSection:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PS.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PS.
			%   Error id: BRAPH2:PipelineSection:WrongInput
			%  Element.CHECKPROP(PipelineSection, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelineSection.
			%   Error id: BRAPH2:PipelineSection:WrongInput
			%  PS.CHECKPROP(PipelineSection, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelineSection.
			%   Error id: BRAPH2:PipelineSection:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PS) and Element.CHECKPROP('PipelineSection')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PipelineSection.getPropProp(pointer);
			
			switch prop
				case 9 % PipelineSection.PC_DICT
					check = Format.checkFormat(10, value, PipelineSection.getPropSettings(prop));
				case 4 % PipelineSection.TEMPLATE
					check = Format.checkFormat(8, value, PipelineSection.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PipelineSection:' 'WrongInput'], ...
					['BRAPH2' ':PipelineSection:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PipelineSection.getPropTag(prop) ' (' PipelineSection.getFormatTag(PipelineSection.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
