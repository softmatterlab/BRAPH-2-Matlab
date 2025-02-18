classdef PipelineCode < ConcreteElement
	%PipelineCode is an executable code line of a pipeline.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Pipeline Code Line (PipelineCode) represents a line of executable code in a pipeline.
	%
	% The list of PipelineCode properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the pipeline code line.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the pipeline code line.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the pipeline code line.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the pipeline code line.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the pipeline code line.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the pipeline code line.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the pipeline code line.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>TEXT_BEFORE_EXEC</strong> 	TEXT_BEFORE_EXEC (metadata, string) is the text before the code line execution.
	%  <strong>10</strong> <strong>TEXT_AFTER_EXEC</strong> 	TEXT_AFTER_EXEC (metadata, string) is the text after the code line execution.
	%  <strong>11</strong> <strong>MONIKER</strong> 	MONIKER (data, string) is the moniker of the calculated element.
	%  <strong>12</strong> <strong>CODE</strong> 	CODE (data, string) is the code line to calculate the element.
	%  <strong>13</strong> <strong>EL</strong> 	EL (data, item) is the calculated element.
	%
	% PipelineCode methods (constructor):
	%  PipelineCode - constructor
	%
	% PipelineCode methods:
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
	% PipelineCode methods (display):
	%  tostring - string with information about the pipeline code line
	%  disp - displays information about the pipeline code line
	%  tree - displays the tree of the pipeline code line
	%
	% PipelineCode methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two pipeline code line are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the pipeline code line
	%
	% PipelineCode methods (save/load, Static):
	%  save - saves BRAPH2 pipeline code line as b2 file
	%  load - loads a BRAPH2 pipeline code line from a b2 file
	%
	% PipelineCode method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the pipeline code line
	%
	% PipelineCode method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the pipeline code line
	%
	% PipelineCode methods (inspection, Static):
	%  getClass - returns the class of the pipeline code line
	%  getSubclasses - returns all subclasses of PipelineCode
	%  getProps - returns the property list of the pipeline code line
	%  getPropNumber - returns the property number of the pipeline code line
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
	% PipelineCode methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PipelineCode methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PipelineCode methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PipelineCode methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PipelineCode; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PipelineCode constants</a>.
	%
	%
	% See also PipelinePP_PSDict, Pipeline, PipelineSection.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		TEXT_BEFORE_EXEC = 9; %CET: Computational Efficiency Trick
		TEXT_BEFORE_EXEC_TAG = 'TEXT_BEFORE_EXEC';
		TEXT_BEFORE_EXEC_CATEGORY = 2;
		TEXT_BEFORE_EXEC_FORMAT = 2;
		
		TEXT_AFTER_EXEC = 10; %CET: Computational Efficiency Trick
		TEXT_AFTER_EXEC_TAG = 'TEXT_AFTER_EXEC';
		TEXT_AFTER_EXEC_CATEGORY = 2;
		TEXT_AFTER_EXEC_FORMAT = 2;
		
		MONIKER = 11; %CET: Computational Efficiency Trick
		MONIKER_TAG = 'MONIKER';
		MONIKER_CATEGORY = 4;
		MONIKER_FORMAT = 2;
		
		CODE = 12; %CET: Computational Efficiency Trick
		CODE_TAG = 'CODE';
		CODE_CATEGORY = 4;
		CODE_FORMAT = 2;
		
		EL = 13; %CET: Computational Efficiency Trick
		EL_TAG = 'EL';
		EL_CATEGORY = 4;
		EL_FORMAT = 8;
	end
	methods % constructor
		function pc = PipelineCode(varargin)
			%PipelineCode() creates a pipeline code line.
			%
			% PipelineCode(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PipelineCode(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PipelineCode properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the pipeline code line.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the pipeline code line.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the pipeline code line.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the pipeline code line.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the pipeline code line.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the pipeline code line.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the pipeline code line.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>TEXT_BEFORE_EXEC</strong> 	TEXT_BEFORE_EXEC (metadata, string) is the text before the code line execution.
			%  <strong>10</strong> <strong>TEXT_AFTER_EXEC</strong> 	TEXT_AFTER_EXEC (metadata, string) is the text after the code line execution.
			%  <strong>11</strong> <strong>MONIKER</strong> 	MONIKER (data, string) is the moniker of the calculated element.
			%  <strong>12</strong> <strong>CODE</strong> 	CODE (data, string) is the code line to calculate the element.
			%  <strong>13</strong> <strong>EL</strong> 	EL (data, item) is the calculated element.
			%
			% See also Category, Format.
			
			pc = pc@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the pipeline code line.
			%
			% BUILD = PipelineCode.GETBUILD() returns the build of 'PipelineCode'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PC.GETBUILD() returns the build of the pipeline code line PC.
			%  BUILD = Element.GETBUILD(PC) returns the build of 'PC'.
			%  BUILD = Element.GETBUILD('PipelineCode') returns the build of 'PipelineCode'.
			%
			% Note that the Element.GETBUILD(PC) and Element.GETBUILD('PipelineCode')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pc_class = getClass()
			%GETCLASS returns the class of the pipeline code line.
			%
			% CLASS = PipelineCode.GETCLASS() returns the class 'PipelineCode'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PC.GETCLASS() returns the class of the pipeline code line PC.
			%  CLASS = Element.GETCLASS(PC) returns the class of 'PC'.
			%  CLASS = Element.GETCLASS('PipelineCode') returns 'PipelineCode'.
			%
			% Note that the Element.GETCLASS(PC) and Element.GETCLASS('PipelineCode')
			%  are less computationally efficient.
			
			pc_class = 'PipelineCode';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the pipeline code line.
			%
			% LIST = PipelineCode.GETSUBCLASSES() returns all subclasses of 'PipelineCode'.
			%
			% Alternative forms to call this method are:
			%  LIST = PC.GETSUBCLASSES() returns all subclasses of the pipeline code line PC.
			%  LIST = Element.GETSUBCLASSES(PC) returns all subclasses of 'PC'.
			%  LIST = Element.GETSUBCLASSES('PipelineCode') returns all subclasses of 'PipelineCode'.
			%
			% Note that the Element.GETSUBCLASSES(PC) and Element.GETSUBCLASSES('PipelineCode')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'PipelineCode' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of pipeline code line.
			%
			% PROPS = PipelineCode.GETPROPS() returns the property list of pipeline code line
			%  as a row vector.
			%
			% PROPS = PipelineCode.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PC.GETPROPS([CATEGORY]) returns the property list of the pipeline code line PC.
			%  PROPS = Element.GETPROPS(PC[, CATEGORY]) returns the property list of 'PC'.
			%  PROPS = Element.GETPROPS('PipelineCode'[, CATEGORY]) returns the property list of 'PipelineCode'.
			%
			% Note that the Element.GETPROPS(PC) and Element.GETPROPS('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 9 10];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 11 12 13];
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of pipeline code line.
			%
			% N = PipelineCode.GETPROPNUMBER() returns the property number of pipeline code line.
			%
			% N = PipelineCode.GETPROPNUMBER(CATEGORY) returns the property number of pipeline code line
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PC.GETPROPNUMBER([CATEGORY]) returns the property number of the pipeline code line PC.
			%  N = Element.GETPROPNUMBER(PC) returns the property number of 'PC'.
			%  N = Element.GETPROPNUMBER('PipelineCode') returns the property number of 'PipelineCode'.
			%
			% Note that the Element.GETPROPNUMBER(PC) and Element.GETPROPNUMBER('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 13;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 4;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 4;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in pipeline code line/error.
			%
			% CHECK = PipelineCode.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PC.EXISTSPROP(PROP) checks whether PROP exists for PC.
			%  CHECK = Element.EXISTSPROP(PC, PROP) checks whether PROP exists for PC.
			%  CHECK = Element.EXISTSPROP(PipelineCode, PROP) checks whether PROP exists for PipelineCode.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PipelineCode:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PC.EXISTSPROP(PROP) throws error if PROP does NOT exist for PC.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%  Element.EXISTSPROP(PC, PROP) throws error if PROP does NOT exist for PC.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%  Element.EXISTSPROP(PipelineCode, PROP) throws error if PROP does NOT exist for PipelineCode.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PC) and Element.EXISTSPROP('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PipelineCode:' 'WrongInput'], ...
					['BRAPH2' ':PipelineCode:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PipelineCode.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in pipeline code line/error.
			%
			% CHECK = PipelineCode.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PC.EXISTSTAG(TAG) checks whether TAG exists for PC.
			%  CHECK = Element.EXISTSTAG(PC, TAG) checks whether TAG exists for PC.
			%  CHECK = Element.EXISTSTAG(PipelineCode, TAG) checks whether TAG exists for PipelineCode.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PipelineCode:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PC.EXISTSTAG(TAG) throws error if TAG does NOT exist for PC.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%  Element.EXISTSTAG(PC, TAG) throws error if TAG does NOT exist for PC.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%  Element.EXISTSTAG(PipelineCode, TAG) throws error if TAG does NOT exist for PipelineCode.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PC) and Element.EXISTSTAG('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'TEXT_BEFORE_EXEC'  'TEXT_AFTER_EXEC'  'MONIKER'  'CODE'  'EL' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PipelineCode:' 'WrongInput'], ...
					['BRAPH2' ':PipelineCode:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for PipelineCode.'] ...
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
			%  PROPERTY = PC.GETPROPPROP(POINTER) returns property number of POINTER of PC.
			%  PROPERTY = Element.GETPROPPROP(PipelineCode, POINTER) returns property number of POINTER of PipelineCode.
			%  PROPERTY = PC.GETPROPPROP(PipelineCode, POINTER) returns property number of POINTER of PipelineCode.
			%
			% Note that the Element.GETPROPPROP(PC) and Element.GETPROPPROP('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'TEXT_BEFORE_EXEC'  'TEXT_AFTER_EXEC'  'MONIKER'  'CODE'  'EL' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = PC.GETPROPTAG(POINTER) returns tag of POINTER of PC.
			%  TAG = Element.GETPROPTAG(PipelineCode, POINTER) returns tag of POINTER of PipelineCode.
			%  TAG = PC.GETPROPTAG(PipelineCode, POINTER) returns tag of POINTER of PipelineCode.
			%
			% Note that the Element.GETPROPTAG(PC) and Element.GETPROPTAG('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				pipelinecode_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'TEXT_BEFORE_EXEC'  'TEXT_AFTER_EXEC'  'MONIKER'  'CODE'  'EL' };
				tag = pipelinecode_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = PC.GETPROPCATEGORY(POINTER) returns category of POINTER of PC.
			%  CATEGORY = Element.GETPROPCATEGORY(PipelineCode, POINTER) returns category of POINTER of PipelineCode.
			%  CATEGORY = PC.GETPROPCATEGORY(PipelineCode, POINTER) returns category of POINTER of PipelineCode.
			%
			% Note that the Element.GETPROPCATEGORY(PC) and Element.GETPROPCATEGORY('PipelineCode')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pipelinecode_category_list = { 1  1  1  3  4  2  2  6  2  2  4  4  4 };
			prop_category = pipelinecode_category_list{prop};
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
			%  FORMAT = PC.GETPROPFORMAT(POINTER) returns format of POINTER of PC.
			%  FORMAT = Element.GETPROPFORMAT(PipelineCode, POINTER) returns format of POINTER of PipelineCode.
			%  FORMAT = PC.GETPROPFORMAT(PipelineCode, POINTER) returns format of POINTER of PipelineCode.
			%
			% Note that the Element.GETPROPFORMAT(PC) and Element.GETPROPFORMAT('PipelineCode')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pipelinecode_format_list = { 2  2  2  8  2  2  2  2  2  2  2  2  8 };
			prop_format = pipelinecode_format_list{prop};
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
			%  DESCRIPTION = PC.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PC.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PipelineCode, POINTER) returns description of POINTER of PipelineCode.
			%  DESCRIPTION = PC.GETPROPDESCRIPTION(PipelineCode, POINTER) returns description of POINTER of PipelineCode.
			%
			% Note that the Element.GETPROPDESCRIPTION(PC) and Element.GETPROPDESCRIPTION('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pipelinecode_description_list = { 'ELCLASS (constant, string) is the class of the pipeline code line.'  'NAME (constant, string) is the name of the pipeline code line.'  'DESCRIPTION (constant, string) is the description of the pipeline code line.'  'TEMPLATE (parameter, item) is the template of the pipeline code line.'  'ID (data, string) is a few-letter code for the pipeline code line.'  'LABEL (metadata, string) is an extended label of the pipeline code line.'  'NOTES (metadata, string) are some specific notes about the pipeline code line.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'TEXT_BEFORE_EXEC (metadata, string) is the text before the code line execution.'  'TEXT_AFTER_EXEC (metadata, string) is the text after the code line execution.'  'MONIKER (data, string) is the moniker of the calculated element.'  'CODE (data, string) is the code line to calculate the element.'  'EL (data, item) is the calculated element.' };
			prop_description = pipelinecode_description_list{prop};
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
			%  SETTINGS = PC.GETPROPSETTINGS(POINTER) returns settings of POINTER of PC.
			%  SETTINGS = Element.GETPROPSETTINGS(PipelineCode, POINTER) returns settings of POINTER of PipelineCode.
			%  SETTINGS = PC.GETPROPSETTINGS(PipelineCode, POINTER) returns settings of POINTER of PipelineCode.
			%
			% Note that the Element.GETPROPSETTINGS(PC) and Element.GETPROPSETTINGS('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % PipelineCode.TEXT_BEFORE_EXEC
					prop_settings = Format.getFormatSettings(2);
				case 10 % PipelineCode.TEXT_AFTER_EXEC
					prop_settings = Format.getFormatSettings(2);
				case 11 % PipelineCode.MONIKER
					prop_settings = Format.getFormatSettings(2);
				case 12 % PipelineCode.CODE
					prop_settings = Format.getFormatSettings(2);
				case 13 % PipelineCode.EL
					prop_settings = Format.getFormatSettings(8);
				case 4 % PipelineCode.TEMPLATE
					prop_settings = 'PipelineCode';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PipelineCode.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelineCode.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PC.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PC.
			%  DEFAULT = Element.GETPROPDEFAULT(PipelineCode, POINTER) returns the default value of POINTER of PipelineCode.
			%  DEFAULT = PC.GETPROPDEFAULT(PipelineCode, POINTER) returns the default value of POINTER of PipelineCode.
			%
			% Note that the Element.GETPROPDEFAULT(PC) and Element.GETPROPDEFAULT('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % PipelineCode.TEXT_BEFORE_EXEC
					prop_default = Format.getFormatDefault(2, PipelineCode.getPropSettings(prop));
				case 10 % PipelineCode.TEXT_AFTER_EXEC
					prop_default = Format.getFormatDefault(2, PipelineCode.getPropSettings(prop));
				case 11 % PipelineCode.MONIKER
					prop_default = Format.getFormatDefault(2, PipelineCode.getPropSettings(prop));
				case 12 % PipelineCode.CODE
					prop_default = Format.getFormatDefault(2, PipelineCode.getPropSettings(prop));
				case 13 % PipelineCode.EL
					prop_default = Format.getFormatDefault(8, PipelineCode.getPropSettings(prop));
				case 1 % PipelineCode.ELCLASS
					prop_default = 'PipelineCode';
				case 2 % PipelineCode.NAME
					prop_default = 'Pipeline Code Line';
				case 3 % PipelineCode.DESCRIPTION
					prop_default = 'A Pipeline Code Line (PipelineCode) represents a line of executable code in a pipeline.';
				case 4 % PipelineCode.TEMPLATE
					prop_default = Format.getFormatDefault(8, PipelineCode.getPropSettings(prop));
				case 5 % PipelineCode.ID
					prop_default = 'PipelineCode ID';
				case 6 % PipelineCode.LABEL
					prop_default = 'PipelineCode label';
				case 7 % PipelineCode.NOTES
					prop_default = 'PipelineCode notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PipelineCode.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelineCode.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PC.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PC.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PipelineCode, POINTER) returns the conditioned default value of POINTER of PipelineCode.
			%  DEFAULT = PC.GETPROPDEFAULTCONDITIONED(PipelineCode, POINTER) returns the conditioned default value of POINTER of PipelineCode.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PC) and Element.GETPROPDEFAULTCONDITIONED('PipelineCode')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			prop_default = PipelineCode.conditioning(prop, PipelineCode.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PC.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PC.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PC.
			%  CHECK = Element.CHECKPROP(PipelineCode, PROP, VALUE) checks VALUE format for PROP of PipelineCode.
			%  CHECK = PC.CHECKPROP(PipelineCode, PROP, VALUE) checks VALUE format for PROP of PipelineCode.
			% 
			% PC.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:PipelineCode:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PC.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PC.
			%   Error id: BRAPH2:PipelineCode:WrongInput
			%  Element.CHECKPROP(PipelineCode, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelineCode.
			%   Error id: BRAPH2:PipelineCode:WrongInput
			%  PC.CHECKPROP(PipelineCode, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelineCode.
			%   Error id: BRAPH2:PipelineCode:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PC) and Element.CHECKPROP('PipelineCode')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PipelineCode.getPropProp(pointer);
			
			switch prop
				case 9 % PipelineCode.TEXT_BEFORE_EXEC
					check = Format.checkFormat(2, value, PipelineCode.getPropSettings(prop));
				case 10 % PipelineCode.TEXT_AFTER_EXEC
					check = Format.checkFormat(2, value, PipelineCode.getPropSettings(prop));
				case 11 % PipelineCode.MONIKER
					check = Format.checkFormat(2, value, PipelineCode.getPropSettings(prop));
				case 12 % PipelineCode.CODE
					check = Format.checkFormat(2, value, PipelineCode.getPropSettings(prop));
				case 13 % PipelineCode.EL
					check = Format.checkFormat(8, value, PipelineCode.getPropSettings(prop));
				case 4 % PipelineCode.TEMPLATE
					check = Format.checkFormat(8, value, PipelineCode.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PipelineCode:' 'WrongInput'], ...
					['BRAPH2' ':PipelineCode:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PipelineCode.getPropTag(prop) ' (' PipelineCode.getFormatTag(PipelineCode.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(pc, prop, value)
			%CHECKVALUE checks the value of a property after it is set/calculated.
			%
			% [CHECK, MSG] = CHECKVALUE(EL, PROP, VALUE) checks the value
			%  of the property PROP after it is set/calculated. This function by
			%  default returns a CHECK = true and MSG = '. It should be implemented in
			%  the subclasses of Element when needed.
			%
			% See also conditioning, preset, checkProp, postset, postprocessing,
			%  calculateValue.
			
			check = true;
			msg = ['Error while checking ' tostring(pc) ' ' pc.getPropTag(prop) '.'];
			
			switch prop
				case 11 % PipelineCode.MONIKER
					check = ~iskeyword(value) && ~strcmp(value, 'varargin');
					if check 
					    msg = 'All ok!';
					else
					    msg = ['The MONIKER (' value ') cannot be a MatLab keyword ' ...
					        '(' char(join(cellfun(@(x) ['''' x ''''], iskeyword, 'UniformOutput', false))) ') ' ...
					        'or ''varargin''.'];
					end
					
				otherwise
					if prop <= 8
						[check, msg] = checkValue@ConcreteElement(pc, prop, value);
					end
			end
		end
	end
end
