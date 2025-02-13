classdef Pipeline < ConcreteElement
	%Pipeline is an analysis pipeline.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Pipeline is an analysis pipeline.
	%
	% The list of Pipeline properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the pipeline.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the pipeline.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the pipeline.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the pipeline.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the pipeline.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the pipeline.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the pipeline.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>README</strong> 	README (metadata, string) is the web tutorial address (/tutorials/pipelines/tut/readme.md).
	%  <strong>10</strong> <strong>PDF</strong> 	PDF (metadata, string) is the PDF tutorial file (/tutorials/pipelines/tut/tut.pdf).
	%  <strong>11</strong> <strong>PS_DICT</strong> 	PS_DICT (data, idict) is an indexed dictionary with the code sections.
	%
	% Pipeline methods (constructor):
	%  Pipeline - constructor
	%
	% Pipeline methods:
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
	% Pipeline methods (display):
	%  tostring - string with information about the analysis pipeline
	%  disp - displays information about the analysis pipeline
	%  tree - displays the tree of the analysis pipeline
	%
	% Pipeline methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two analysis pipeline are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the analysis pipeline
	%
	% Pipeline methods (save/load, Static):
	%  save - saves BRAPH2 analysis pipeline as b2 file
	%  load - loads a BRAPH2 analysis pipeline from a b2 file
	%
	% Pipeline method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the analysis pipeline
	%
	% Pipeline method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the analysis pipeline
	%
	% Pipeline methods (inspection, Static):
	%  getClass - returns the class of the analysis pipeline
	%  getSubclasses - returns all subclasses of Pipeline
	%  getProps - returns the property list of the analysis pipeline
	%  getPropNumber - returns the property number of the analysis pipeline
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
	% Pipeline methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Pipeline methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Pipeline methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Pipeline methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Pipeline; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Pipeline constants</a>.
	%
	%
	% See also PipelinePP_PSDict, PipelineSection, PipelineCode.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		README = 9; %CET: Computational Efficiency Trick
		README_TAG = 'README';
		README_CATEGORY = 2;
		README_FORMAT = 2;
		
		PDF = 10; %CET: Computational Efficiency Trick
		PDF_TAG = 'PDF';
		PDF_CATEGORY = 2;
		PDF_FORMAT = 2;
		
		PS_DICT = 11; %CET: Computational Efficiency Trick
		PS_DICT_TAG = 'PS_DICT';
		PS_DICT_CATEGORY = 4;
		PS_DICT_FORMAT = 10;
	end
	methods % constructor
		function pip = Pipeline(varargin)
			%Pipeline() creates a analysis pipeline.
			%
			% Pipeline(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Pipeline(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Pipeline properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the pipeline.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the pipeline.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the pipeline.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the pipeline.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the pipeline.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the pipeline.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the pipeline.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>README</strong> 	README (metadata, string) is the web tutorial address (/tutorials/pipelines/tut/readme.md).
			%  <strong>10</strong> <strong>PDF</strong> 	PDF (metadata, string) is the PDF tutorial file (/tutorials/pipelines/tut/tut.pdf).
			%  <strong>11</strong> <strong>PS_DICT</strong> 	PS_DICT (data, idict) is an indexed dictionary with the code sections.
			%
			% See also Category, Format.
			
			pip = pip@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the analysis pipeline.
			%
			% BUILD = Pipeline.GETBUILD() returns the build of 'Pipeline'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PIP.GETBUILD() returns the build of the analysis pipeline PIP.
			%  BUILD = Element.GETBUILD(PIP) returns the build of 'PIP'.
			%  BUILD = Element.GETBUILD('Pipeline') returns the build of 'Pipeline'.
			%
			% Note that the Element.GETBUILD(PIP) and Element.GETBUILD('Pipeline')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pip_class = getClass()
			%GETCLASS returns the class of the analysis pipeline.
			%
			% CLASS = Pipeline.GETCLASS() returns the class 'Pipeline'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PIP.GETCLASS() returns the class of the analysis pipeline PIP.
			%  CLASS = Element.GETCLASS(PIP) returns the class of 'PIP'.
			%  CLASS = Element.GETCLASS('Pipeline') returns 'Pipeline'.
			%
			% Note that the Element.GETCLASS(PIP) and Element.GETCLASS('Pipeline')
			%  are less computationally efficient.
			
			pip_class = 'Pipeline';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the analysis pipeline.
			%
			% LIST = Pipeline.GETSUBCLASSES() returns all subclasses of 'Pipeline'.
			%
			% Alternative forms to call this method are:
			%  LIST = PIP.GETSUBCLASSES() returns all subclasses of the analysis pipeline PIP.
			%  LIST = Element.GETSUBCLASSES(PIP) returns all subclasses of 'PIP'.
			%  LIST = Element.GETSUBCLASSES('Pipeline') returns all subclasses of 'Pipeline'.
			%
			% Note that the Element.GETSUBCLASSES(PIP) and Element.GETSUBCLASSES('Pipeline')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'Pipeline' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of analysis pipeline.
			%
			% PROPS = Pipeline.GETPROPS() returns the property list of analysis pipeline
			%  as a row vector.
			%
			% PROPS = Pipeline.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PIP.GETPROPS([CATEGORY]) returns the property list of the analysis pipeline PIP.
			%  PROPS = Element.GETPROPS(PIP[, CATEGORY]) returns the property list of 'PIP'.
			%  PROPS = Element.GETPROPS('Pipeline'[, CATEGORY]) returns the property list of 'Pipeline'.
			%
			% Note that the Element.GETPROPS(PIP) and Element.GETPROPS('Pipeline')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11];
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
					prop_list = [5 11];
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of analysis pipeline.
			%
			% N = Pipeline.GETPROPNUMBER() returns the property number of analysis pipeline.
			%
			% N = Pipeline.GETPROPNUMBER(CATEGORY) returns the property number of analysis pipeline
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PIP.GETPROPNUMBER([CATEGORY]) returns the property number of the analysis pipeline PIP.
			%  N = Element.GETPROPNUMBER(PIP) returns the property number of 'PIP'.
			%  N = Element.GETPROPNUMBER('Pipeline') returns the property number of 'Pipeline'.
			%
			% Note that the Element.GETPROPNUMBER(PIP) and Element.GETPROPNUMBER('Pipeline')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 11;
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
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in analysis pipeline/error.
			%
			% CHECK = Pipeline.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PIP.EXISTSPROP(PROP) checks whether PROP exists for PIP.
			%  CHECK = Element.EXISTSPROP(PIP, PROP) checks whether PROP exists for PIP.
			%  CHECK = Element.EXISTSPROP(Pipeline, PROP) checks whether PROP exists for Pipeline.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Pipeline:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PIP.EXISTSPROP(PROP) throws error if PROP does NOT exist for PIP.
			%   Error id: [BRAPH2:Pipeline:WrongInput]
			%  Element.EXISTSPROP(PIP, PROP) throws error if PROP does NOT exist for PIP.
			%   Error id: [BRAPH2:Pipeline:WrongInput]
			%  Element.EXISTSPROP(Pipeline, PROP) throws error if PROP does NOT exist for Pipeline.
			%   Error id: [BRAPH2:Pipeline:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PIP) and Element.EXISTSPROP('Pipeline')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 11 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Pipeline:' 'WrongInput'], ...
					['BRAPH2' ':Pipeline:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Pipeline.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in analysis pipeline/error.
			%
			% CHECK = Pipeline.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PIP.EXISTSTAG(TAG) checks whether TAG exists for PIP.
			%  CHECK = Element.EXISTSTAG(PIP, TAG) checks whether TAG exists for PIP.
			%  CHECK = Element.EXISTSTAG(Pipeline, TAG) checks whether TAG exists for Pipeline.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Pipeline:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PIP.EXISTSTAG(TAG) throws error if TAG does NOT exist for PIP.
			%   Error id: [BRAPH2:Pipeline:WrongInput]
			%  Element.EXISTSTAG(PIP, TAG) throws error if TAG does NOT exist for PIP.
			%   Error id: [BRAPH2:Pipeline:WrongInput]
			%  Element.EXISTSTAG(Pipeline, TAG) throws error if TAG does NOT exist for Pipeline.
			%   Error id: [BRAPH2:Pipeline:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PIP) and Element.EXISTSTAG('Pipeline')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'README'  'PDF'  'PS_DICT' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Pipeline:' 'WrongInput'], ...
					['BRAPH2' ':Pipeline:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for Pipeline.'] ...
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
			%  PROPERTY = PIP.GETPROPPROP(POINTER) returns property number of POINTER of PIP.
			%  PROPERTY = Element.GETPROPPROP(Pipeline, POINTER) returns property number of POINTER of Pipeline.
			%  PROPERTY = PIP.GETPROPPROP(Pipeline, POINTER) returns property number of POINTER of Pipeline.
			%
			% Note that the Element.GETPROPPROP(PIP) and Element.GETPROPPROP('Pipeline')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'README'  'PDF'  'PS_DICT' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = PIP.GETPROPTAG(POINTER) returns tag of POINTER of PIP.
			%  TAG = Element.GETPROPTAG(Pipeline, POINTER) returns tag of POINTER of Pipeline.
			%  TAG = PIP.GETPROPTAG(Pipeline, POINTER) returns tag of POINTER of Pipeline.
			%
			% Note that the Element.GETPROPTAG(PIP) and Element.GETPROPTAG('Pipeline')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				pipeline_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'README'  'PDF'  'PS_DICT' };
				tag = pipeline_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = PIP.GETPROPCATEGORY(POINTER) returns category of POINTER of PIP.
			%  CATEGORY = Element.GETPROPCATEGORY(Pipeline, POINTER) returns category of POINTER of Pipeline.
			%  CATEGORY = PIP.GETPROPCATEGORY(Pipeline, POINTER) returns category of POINTER of Pipeline.
			%
			% Note that the Element.GETPROPCATEGORY(PIP) and Element.GETPROPCATEGORY('Pipeline')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Pipeline.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pipeline_category_list = { 1  1  1  3  4  2  2  6  2  2  4 };
			prop_category = pipeline_category_list{prop};
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
			%  FORMAT = PIP.GETPROPFORMAT(POINTER) returns format of POINTER of PIP.
			%  FORMAT = Element.GETPROPFORMAT(Pipeline, POINTER) returns format of POINTER of Pipeline.
			%  FORMAT = PIP.GETPROPFORMAT(Pipeline, POINTER) returns format of POINTER of Pipeline.
			%
			% Note that the Element.GETPROPFORMAT(PIP) and Element.GETPROPFORMAT('Pipeline')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Pipeline.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pipeline_format_list = { 2  2  2  8  2  2  2  2  2  2  10 };
			prop_format = pipeline_format_list{prop};
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
			%  DESCRIPTION = PIP.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PIP.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Pipeline, POINTER) returns description of POINTER of Pipeline.
			%  DESCRIPTION = PIP.GETPROPDESCRIPTION(Pipeline, POINTER) returns description of POINTER of Pipeline.
			%
			% Note that the Element.GETPROPDESCRIPTION(PIP) and Element.GETPROPDESCRIPTION('Pipeline')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Pipeline.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			pipeline_description_list = { 'ELCLASS (constant, string) is the class of the pipeline.'  'NAME (constant, string) is the name of the pipeline.'  'DESCRIPTION (constant, string) is the description of the pipeline.'  'TEMPLATE (parameter, item) is the template of the pipeline.'  'ID (data, string) is a few-letter code for the pipeline.'  'LABEL (metadata, string) is an extended label of the pipeline.'  'NOTES (metadata, string) are some specific notes about the pipeline.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'README (metadata, string) is the web tutorial address (/tutorials/pipelines/tut/readme.md).'  'PDF (metadata, string) is the PDF tutorial file (/tutorials/pipelines/tut/tut.pdf).'  'PS_DICT (data, idict) is an indexed dictionary with the code sections.' };
			prop_description = pipeline_description_list{prop};
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
			%  SETTINGS = PIP.GETPROPSETTINGS(POINTER) returns settings of POINTER of PIP.
			%  SETTINGS = Element.GETPROPSETTINGS(Pipeline, POINTER) returns settings of POINTER of Pipeline.
			%  SETTINGS = PIP.GETPROPSETTINGS(Pipeline, POINTER) returns settings of POINTER of Pipeline.
			%
			% Note that the Element.GETPROPSETTINGS(PIP) and Element.GETPROPSETTINGS('Pipeline')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Pipeline.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % Pipeline.README
					prop_settings = Format.getFormatSettings(2);
				case 10 % Pipeline.PDF
					prop_settings = Format.getFormatSettings(2);
				case 11 % Pipeline.PS_DICT
					prop_settings = 'PipelineSection';
				case 4 % Pipeline.TEMPLATE
					prop_settings = 'Pipeline';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Pipeline.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Pipeline.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PIP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PIP.
			%  DEFAULT = Element.GETPROPDEFAULT(Pipeline, POINTER) returns the default value of POINTER of Pipeline.
			%  DEFAULT = PIP.GETPROPDEFAULT(Pipeline, POINTER) returns the default value of POINTER of Pipeline.
			%
			% Note that the Element.GETPROPDEFAULT(PIP) and Element.GETPROPDEFAULT('Pipeline')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Pipeline.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % Pipeline.README
					prop_default = Format.getFormatDefault(2, Pipeline.getPropSettings(prop));
				case 10 % Pipeline.PDF
					prop_default = Format.getFormatDefault(2, Pipeline.getPropSettings(prop));
				case 11 % Pipeline.PS_DICT
					prop_default = Format.getFormatDefault(10, Pipeline.getPropSettings(prop));
				case 1 % Pipeline.ELCLASS
					prop_default = 'Pipeline';
				case 2 % Pipeline.NAME
					prop_default = 'Pipeline';
				case 3 % Pipeline.DESCRIPTION
					prop_default = 'A Pipeline is an analysis pipeline.';
				case 4 % Pipeline.TEMPLATE
					prop_default = Format.getFormatDefault(8, Pipeline.getPropSettings(prop));
				case 5 % Pipeline.ID
					prop_default = 'Pipeline ID';
				case 6 % Pipeline.LABEL
					prop_default = 'Pipeline label';
				case 7 % Pipeline.NOTES
					prop_default = 'Pipeline notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Pipeline.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Pipeline.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PIP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PIP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Pipeline, POINTER) returns the conditioned default value of POINTER of Pipeline.
			%  DEFAULT = PIP.GETPROPDEFAULTCONDITIONED(Pipeline, POINTER) returns the conditioned default value of POINTER of Pipeline.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PIP) and Element.GETPROPDEFAULTCONDITIONED('Pipeline')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Pipeline.getPropProp(pointer);
			
			prop_default = Pipeline.conditioning(prop, Pipeline.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PIP.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PIP.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PIP.
			%  CHECK = Element.CHECKPROP(Pipeline, PROP, VALUE) checks VALUE format for PROP of Pipeline.
			%  CHECK = PIP.CHECKPROP(Pipeline, PROP, VALUE) checks VALUE format for PROP of Pipeline.
			% 
			% PIP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:Pipeline:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PIP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PIP.
			%   Error id: BRAPH2:Pipeline:WrongInput
			%  Element.CHECKPROP(Pipeline, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Pipeline.
			%   Error id: BRAPH2:Pipeline:WrongInput
			%  PIP.CHECKPROP(Pipeline, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Pipeline.
			%   Error id: BRAPH2:Pipeline:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PIP) and Element.CHECKPROP('Pipeline')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Pipeline.getPropProp(pointer);
			
			switch prop
				case 9 % Pipeline.README
					check = Format.checkFormat(2, value, Pipeline.getPropSettings(prop));
				case 10 % Pipeline.PDF
					check = Format.checkFormat(2, value, Pipeline.getPropSettings(prop));
				case 11 % Pipeline.PS_DICT
					check = Format.checkFormat(10, value, Pipeline.getPropSettings(prop));
				case 4 % Pipeline.TEMPLATE
					check = Format.checkFormat(8, value, Pipeline.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Pipeline:' 'WrongInput'], ...
					['BRAPH2' ':Pipeline:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Pipeline.getPropTag(prop) ' (' Pipeline.getFormatTag(Pipeline.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(pip, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case 11 % Pipeline.PS_DICT
					pr = PipelinePP_PSDict('EL', pip, 'PROP', 11, varargin{:});
					
				case 7 % Pipeline.NOTES
					pr = PipelinePP_Notes('EL', pip, 'PROP', 7, varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(pip, prop, varargin{:});
					
			end
		end
	end
	methods (Static) % GUI static methods
		function getGUIMenuImport(el, menu_import, pe)
			%GETGUIMENUIMPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu import
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuExporter, PlotElement.
			
			Element.getGUIMenuImport(el, menu_import, pe);
			
			uimenu(menu_import, ...
			    'Tag', 'MENU.Import.BRAPH2', ...
			    'Label', 'Import BRAPH2 ...', ...
			    'Callback', {@cb_importer_BRAPH2});
			function cb_importer_BRAPH2(~, ~)
			    try
			        im = ImporterPipelineBRAPH2( ...
			            'ID', 'Import BRAPH2 Pipeline', ...
			            'WAITBAR', true ...
			            ).get('GET_FILE');
			        if ~isa(im.getr('FILE'), 'NoValue')
			            pip = im.get('PIP');
			            gui = GUIElement('PE', pip);
			            gui.get('DRAW')
			            gui.get('SHOW')
			        end
			    catch e
			        %TODO implement and use braph2msgbox instead of warndlg
			        warndlg(['Please, select a valid input Pipeline in BRAPH2 format. ' newline() ...
			            newline() ...
			            'Error message:' newline() ...
			            newline() ...
			            e.message newline()], 'Warning');
			    end
			end
			
		end
		function getGUIMenuExport(el, menu_export, pe)
			%GETGUIMENUEXPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu export
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuImporter, PlotElement.
			
			Element.getGUIMenuExport(el, menu_export, pe);
			
			uimenu(menu_export, ...
			    'Tag', 'MENU.Export.BRAPH2', ...
			    'Label', 'Export BRAPH2 ...', ...
			    'Callback', {@cb_exporter_BRAPH2});
			function cb_exporter_BRAPH2(~, ~)
			    ex = ExporterPipelineBRAPH2( ...
			        'ID', 'Export BRAPH2 Pipeline', ...
			        'PIP', el, ...
			        'WAITBAR', true ...
			        ).get('PUT_FILE');
			    if ~isa(ex.getr('FILE'), 'NoValue')
			        ex.get('SAVE');
			    end
			end
			
		end
	end
end
