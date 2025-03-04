classdef SubjectST_MP < Subject
	%SubjectST_MP is a subject with structural multiplex data (e.
	% It is a subclass of <a href="matlab:help Subject">Subject</a>.
	%
	% Subject with data for each brain region correspponding to L structural layers (e.g. cortical thickness obtained from structural MRI).
	%
	% The list of SubjectST_MP properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the subject.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the subject.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the subject.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the subject.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the subject.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the subject.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the subject.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>VOI_DICT</strong> 	VOI_DICT (data, idict) contains the variables of interest of the subject.
	%  <strong>10</strong> <strong>BA</strong> 	BA (data, item) is a brain atlas.
	%  <strong>11</strong> <strong>L</strong> 	L (data, scalar) is the number of layers of subject data.
	%  <strong>12</strong> <strong>LAYERLABELS</strong> 	LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.
	%  <strong>13</strong> <strong>ALAYERLABELS</strong> 	ALAYERLABELS (query, stringlist) returns the processed layer labels.
	%  <strong>14</strong> <strong>ST_MP</strong> 	ST_MP (data, cell) is a cell containing L vectors, each with data for each brain region.
	%
	% SubjectST_MP methods (constructor):
	%  SubjectST_MP - constructor
	%
	% SubjectST_MP methods:
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
	% SubjectST_MP methods (display):
	%  tostring - string with information about the subject with structural multiplex data
	%  disp - displays information about the subject with structural multiplex data
	%  tree - displays the tree of the subject with structural multiplex data
	%
	% SubjectST_MP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two subject with structural multiplex data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the subject with structural multiplex data
	%
	% SubjectST_MP methods (save/load, Static):
	%  save - saves BRAPH2 subject with structural multiplex data as b2 file
	%  load - loads a BRAPH2 subject with structural multiplex data from a b2 file
	%
	% SubjectST_MP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the subject with structural multiplex data
	%
	% SubjectST_MP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the subject with structural multiplex data
	%
	% SubjectST_MP methods (inspection, Static):
	%  getClass - returns the class of the subject with structural multiplex data
	%  getSubclasses - returns all subclasses of SubjectST_MP
	%  getProps - returns the property list of the subject with structural multiplex data
	%  getPropNumber - returns the property number of the subject with structural multiplex data
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
	% SubjectST_MP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SubjectST_MP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SubjectST_MP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SubjectST_MP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SubjectST_MP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SubjectST_MP constants</a>.
	%
	%
	% See also ImporterGroupSubjectST_MP_TXT, ExporterGroupSubjectST_MP_TXT, ImporterGroupSubjectST_MP_XLS, ExporterGroupSubjectST_MP_XLS.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		BA = 10; %CET: Computational Efficiency Trick
		BA_TAG = 'BA';
		BA_CATEGORY = 4;
		BA_FORMAT = 8;
		
		L = 11; %CET: Computational Efficiency Trick
		L_TAG = 'L';
		L_CATEGORY = 4;
		L_FORMAT = 11;
		
		LAYERLABELS = 12; %CET: Computational Efficiency Trick
		LAYERLABELS_TAG = 'LAYERLABELS';
		LAYERLABELS_CATEGORY = 2;
		LAYERLABELS_FORMAT = 3;
		
		ALAYERLABELS = 13; %CET: Computational Efficiency Trick
		ALAYERLABELS_TAG = 'ALAYERLABELS';
		ALAYERLABELS_CATEGORY = 6;
		ALAYERLABELS_FORMAT = 3;
		
		ST_MP = 14; %CET: Computational Efficiency Trick
		ST_MP_TAG = 'ST_MP';
		ST_MP_CATEGORY = 4;
		ST_MP_FORMAT = 16;
	end
	methods % constructor
		function sub = SubjectST_MP(varargin)
			%SubjectST_MP() creates a subject with structural multiplex data.
			%
			% SubjectST_MP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SubjectST_MP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SubjectST_MP properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the subject.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the subject.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the subject.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the subject.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the subject.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the subject.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the subject.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>VOI_DICT</strong> 	VOI_DICT (data, idict) contains the variables of interest of the subject.
			%  <strong>10</strong> <strong>BA</strong> 	BA (data, item) is a brain atlas.
			%  <strong>11</strong> <strong>L</strong> 	L (data, scalar) is the number of layers of subject data.
			%  <strong>12</strong> <strong>LAYERLABELS</strong> 	LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.
			%  <strong>13</strong> <strong>ALAYERLABELS</strong> 	ALAYERLABELS (query, stringlist) returns the processed layer labels.
			%  <strong>14</strong> <strong>ST_MP</strong> 	ST_MP (data, cell) is a cell containing L vectors, each with data for each brain region.
			%
			% See also Category, Format.
			
			sub = sub@Subject(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the subject with structural multiplex data.
			%
			% BUILD = SubjectST_MP.GETBUILD() returns the build of 'SubjectST_MP'.
			%
			% Alternative forms to call this method are:
			%  BUILD = SUB.GETBUILD() returns the build of the subject with structural multiplex data SUB.
			%  BUILD = Element.GETBUILD(SUB) returns the build of 'SUB'.
			%  BUILD = Element.GETBUILD('SubjectST_MP') returns the build of 'SubjectST_MP'.
			%
			% Note that the Element.GETBUILD(SUB) and Element.GETBUILD('SubjectST_MP')
			%  are less computationally efficient.
			
			build = 1;
		end
		function sub_class = getClass()
			%GETCLASS returns the class of the subject with structural multiplex data.
			%
			% CLASS = SubjectST_MP.GETCLASS() returns the class 'SubjectST_MP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SUB.GETCLASS() returns the class of the subject with structural multiplex data SUB.
			%  CLASS = Element.GETCLASS(SUB) returns the class of 'SUB'.
			%  CLASS = Element.GETCLASS('SubjectST_MP') returns 'SubjectST_MP'.
			%
			% Note that the Element.GETCLASS(SUB) and Element.GETCLASS('SubjectST_MP')
			%  are less computationally efficient.
			
			sub_class = 'SubjectST_MP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the subject with structural multiplex data.
			%
			% LIST = SubjectST_MP.GETSUBCLASSES() returns all subclasses of 'SubjectST_MP'.
			%
			% Alternative forms to call this method are:
			%  LIST = SUB.GETSUBCLASSES() returns all subclasses of the subject with structural multiplex data SUB.
			%  LIST = Element.GETSUBCLASSES(SUB) returns all subclasses of 'SUB'.
			%  LIST = Element.GETSUBCLASSES('SubjectST_MP') returns all subclasses of 'SubjectST_MP'.
			%
			% Note that the Element.GETSUBCLASSES(SUB) and Element.GETSUBCLASSES('SubjectST_MP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SubjectST_MP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of subject with structural multiplex data.
			%
			% PROPS = SubjectST_MP.GETPROPS() returns the property list of subject with structural multiplex data
			%  as a row vector.
			%
			% PROPS = SubjectST_MP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SUB.GETPROPS([CATEGORY]) returns the property list of the subject with structural multiplex data SUB.
			%  PROPS = Element.GETPROPS(SUB[, CATEGORY]) returns the property list of 'SUB'.
			%  PROPS = Element.GETPROPS('SubjectST_MP'[, CATEGORY]) returns the property list of 'SubjectST_MP'.
			%
			% Note that the Element.GETPROPS(SUB) and Element.GETPROPS('SubjectST_MP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 12];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 9 10 11 14];
				case 6 % Category.QUERY
					prop_list = [8 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of subject with structural multiplex data.
			%
			% N = SubjectST_MP.GETPROPNUMBER() returns the property number of subject with structural multiplex data.
			%
			% N = SubjectST_MP.GETPROPNUMBER(CATEGORY) returns the property number of subject with structural multiplex data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = SUB.GETPROPNUMBER([CATEGORY]) returns the property number of the subject with structural multiplex data SUB.
			%  N = Element.GETPROPNUMBER(SUB) returns the property number of 'SUB'.
			%  N = Element.GETPROPNUMBER('SubjectST_MP') returns the property number of 'SubjectST_MP'.
			%
			% Note that the Element.GETPROPNUMBER(SUB) and Element.GETPROPNUMBER('SubjectST_MP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 14;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 5;
				case 6 % Category.QUERY
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in subject with structural multiplex data/error.
			%
			% CHECK = SubjectST_MP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSPROP(PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SUB, PROP) checks whether PROP exists for SUB.
			%  CHECK = Element.EXISTSPROP(SubjectST_MP, PROP) checks whether PROP exists for SubjectST_MP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SubjectST_MP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSPROP(PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectST_MP:WrongInput]
			%  Element.EXISTSPROP(SUB, PROP) throws error if PROP does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectST_MP:WrongInput]
			%  Element.EXISTSPROP(SubjectST_MP, PROP) throws error if PROP does NOT exist for SubjectST_MP.
			%   Error id: [BRAPH2:SubjectST_MP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(SUB) and Element.EXISTSPROP('SubjectST_MP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 14 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SubjectST_MP:' 'WrongInput'], ...
					['BRAPH2' ':SubjectST_MP:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SubjectST_MP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in subject with structural multiplex data/error.
			%
			% CHECK = SubjectST_MP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SUB.EXISTSTAG(TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SUB, TAG) checks whether TAG exists for SUB.
			%  CHECK = Element.EXISTSTAG(SubjectST_MP, TAG) checks whether TAG exists for SubjectST_MP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SubjectST_MP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SUB.EXISTSTAG(TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectST_MP:WrongInput]
			%  Element.EXISTSTAG(SUB, TAG) throws error if TAG does NOT exist for SUB.
			%   Error id: [BRAPH2:SubjectST_MP:WrongInput]
			%  Element.EXISTSTAG(SubjectST_MP, TAG) throws error if TAG does NOT exist for SubjectST_MP.
			%   Error id: [BRAPH2:SubjectST_MP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(SUB) and Element.EXISTSTAG('SubjectST_MP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'VOI_DICT'  'BA'  'L'  'LAYERLABELS'  'ALAYERLABELS'  'ST_MP' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SubjectST_MP:' 'WrongInput'], ...
					['BRAPH2' ':SubjectST_MP:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SubjectST_MP.'] ...
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
			%  PROPERTY = SUB.GETPROPPROP(POINTER) returns property number of POINTER of SUB.
			%  PROPERTY = Element.GETPROPPROP(SubjectST_MP, POINTER) returns property number of POINTER of SubjectST_MP.
			%  PROPERTY = SUB.GETPROPPROP(SubjectST_MP, POINTER) returns property number of POINTER of SubjectST_MP.
			%
			% Note that the Element.GETPROPPROP(SUB) and Element.GETPROPPROP('SubjectST_MP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'VOI_DICT'  'BA'  'L'  'LAYERLABELS'  'ALAYERLABELS'  'ST_MP' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = SUB.GETPROPTAG(POINTER) returns tag of POINTER of SUB.
			%  TAG = Element.GETPROPTAG(SubjectST_MP, POINTER) returns tag of POINTER of SubjectST_MP.
			%  TAG = SUB.GETPROPTAG(SubjectST_MP, POINTER) returns tag of POINTER of SubjectST_MP.
			%
			% Note that the Element.GETPROPTAG(SUB) and Element.GETPROPTAG('SubjectST_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				subjectst_mp_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'VOI_DICT'  'BA'  'L'  'LAYERLABELS'  'ALAYERLABELS'  'ST_MP' };
				tag = subjectst_mp_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = SUB.GETPROPCATEGORY(POINTER) returns category of POINTER of SUB.
			%  CATEGORY = Element.GETPROPCATEGORY(SubjectST_MP, POINTER) returns category of POINTER of SubjectST_MP.
			%  CATEGORY = SUB.GETPROPCATEGORY(SubjectST_MP, POINTER) returns category of POINTER of SubjectST_MP.
			%
			% Note that the Element.GETPROPCATEGORY(SUB) and Element.GETPROPCATEGORY('SubjectST_MP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectST_MP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			subjectst_mp_category_list = { 1  1  1  3  4  2  2  6  4  4  4  2  6  4 };
			prop_category = subjectst_mp_category_list{prop};
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
			%  FORMAT = SUB.GETPROPFORMAT(POINTER) returns format of POINTER of SUB.
			%  FORMAT = Element.GETPROPFORMAT(SubjectST_MP, POINTER) returns format of POINTER of SubjectST_MP.
			%  FORMAT = SUB.GETPROPFORMAT(SubjectST_MP, POINTER) returns format of POINTER of SubjectST_MP.
			%
			% Note that the Element.GETPROPFORMAT(SUB) and Element.GETPROPFORMAT('SubjectST_MP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectST_MP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			subjectst_mp_format_list = { 2  2  2  8  2  2  2  2  10  8  11  3  3  16 };
			prop_format = subjectst_mp_format_list{prop};
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
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(POINTER) returns description of POINTER of SUB.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SubjectST_MP, POINTER) returns description of POINTER of SubjectST_MP.
			%  DESCRIPTION = SUB.GETPROPDESCRIPTION(SubjectST_MP, POINTER) returns description of POINTER of SubjectST_MP.
			%
			% Note that the Element.GETPROPDESCRIPTION(SUB) and Element.GETPROPDESCRIPTION('SubjectST_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectST_MP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			subjectst_mp_description_list = { 'ELCLASS (constant, string) is the class of the subject.'  'NAME (constant, string) is the name of the subject.'  'DESCRIPTION (constant, string) is the description of the subject.'  'TEMPLATE (parameter, item) is the template of the subject.'  'ID (data, string) is a few-letter code for the subject.'  'LABEL (metadata, string) is an extended label of the subject.'  'NOTES (metadata, string) are some specific notes about the subject.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'VOI_DICT (data, idict) contains the variables of interest of the subject.'  'BA (data, item) is a brain atlas.'  'L (data, scalar) is the number of layers of subject data.'  'LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.'  'ALAYERLABELS (query, stringlist) returns the processed layer labels.'  'ST_MP (data, cell) is a cell containing L vectors, each with data for each brain region.' };
			prop_description = subjectst_mp_description_list{prop};
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
			%  SETTINGS = SUB.GETPROPSETTINGS(POINTER) returns settings of POINTER of SUB.
			%  SETTINGS = Element.GETPROPSETTINGS(SubjectST_MP, POINTER) returns settings of POINTER of SubjectST_MP.
			%  SETTINGS = SUB.GETPROPSETTINGS(SubjectST_MP, POINTER) returns settings of POINTER of SubjectST_MP.
			%
			% Note that the Element.GETPROPSETTINGS(SUB) and Element.GETPROPSETTINGS('SubjectST_MP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectST_MP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % SubjectST_MP.BA
					prop_settings = 'BrainAtlas';
				case 11 % SubjectST_MP.L
					prop_settings = Format.getFormatSettings(11);
				case 12 % SubjectST_MP.LAYERLABELS
					prop_settings = Format.getFormatSettings(3);
				case 13 % SubjectST_MP.ALAYERLABELS
					prop_settings = Format.getFormatSettings(3);
				case 14 % SubjectST_MP.ST_MP
					prop_settings = Format.getFormatSettings(16);
				otherwise
					prop_settings = getPropSettings@Subject(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SubjectST_MP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectST_MP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULT(SubjectST_MP, POINTER) returns the default value of POINTER of SubjectST_MP.
			%  DEFAULT = SUB.GETPROPDEFAULT(SubjectST_MP, POINTER) returns the default value of POINTER of SubjectST_MP.
			%
			% Note that the Element.GETPROPDEFAULT(SUB) and Element.GETPROPDEFAULT('SubjectST_MP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SubjectST_MP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % SubjectST_MP.BA
					prop_default = Format.getFormatDefault(8, SubjectST_MP.getPropSettings(prop));
				case 11 % SubjectST_MP.L
					prop_default = Format.getFormatDefault(11, SubjectST_MP.getPropSettings(prop));
				case 12 % SubjectST_MP.LAYERLABELS
					prop_default = Format.getFormatDefault(3, SubjectST_MP.getPropSettings(prop));
				case 13 % SubjectST_MP.ALAYERLABELS
					prop_default = Format.getFormatDefault(3, SubjectST_MP.getPropSettings(prop));
				case 14 % SubjectST_MP.ST_MP
					prop_default = Format.getFormatDefault(16, SubjectST_MP.getPropSettings(prop));
				case 1 % SubjectST_MP.ELCLASS
					prop_default = 'SubjectST_MP';
				case 2 % SubjectST_MP.NAME
					prop_default = 'Multiplex Structural Subject';
				case 3 % SubjectST_MP.DESCRIPTION
					prop_default = 'Subject with data for each brain region correspponding to L structural layers (e.g. cortical thickness obtained from structural MRI).';
				case 5 % SubjectST_MP.ID
					prop_default = 'SubjectST_MP ID';
				case 6 % SubjectST_MP.LABEL
					prop_default = 'SubjectST_MP label';
				case 7 % SubjectST_MP.NOTES
					prop_default = 'SubjectST_MP notes';
				otherwise
					prop_default = getPropDefault@Subject(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SubjectST_MP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectST_MP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SUB.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SubjectST_MP, POINTER) returns the conditioned default value of POINTER of SubjectST_MP.
			%  DEFAULT = SUB.GETPROPDEFAULTCONDITIONED(SubjectST_MP, POINTER) returns the conditioned default value of POINTER of SubjectST_MP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(SUB) and Element.GETPROPDEFAULTCONDITIONED('SubjectST_MP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SubjectST_MP.getPropProp(pointer);
			
			prop_default = SubjectST_MP.conditioning(prop, SubjectST_MP.getPropDefault(prop));
		end
	end
	methods (Access=protected) % preset
		function value = preset(sub, prop, value)
			%PRESET preprocesses the value of a property before setting it.
			%
			% VALUE = PRESET(EL, PROP, VALUE) prepropcesses the VALUE of the property
			%  PROP. It works only with properties with 2,
			%  3, 4, 8 and 9. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% See also conditioning, checkProp, postset, postprocessing,
			%  calculateValue, checkValue.
			
			switch prop
				case 11 % SubjectST_MP.L
					value = abs(round(value));
					
				otherwise
					if prop <= 9
						value = preset@Subject(sub, prop, value);
					end
			end
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = SUB.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = SUB.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of SUB.
			%  CHECK = Element.CHECKPROP(SubjectST_MP, PROP, VALUE) checks VALUE format for PROP of SubjectST_MP.
			%  CHECK = SUB.CHECKPROP(SubjectST_MP, PROP, VALUE) checks VALUE format for PROP of SubjectST_MP.
			% 
			% SUB.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SubjectST_MP:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SUB.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SUB.
			%   Error id: BRAPH2:SubjectST_MP:WrongInput
			%  Element.CHECKPROP(SubjectST_MP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectST_MP.
			%   Error id: BRAPH2:SubjectST_MP:WrongInput
			%  SUB.CHECKPROP(SubjectST_MP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectST_MP.
			%   Error id: BRAPH2:SubjectST_MP:WrongInput]
			% 
			% Note that the Element.CHECKPROP(SUB) and Element.CHECKPROP('SubjectST_MP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SubjectST_MP.getPropProp(pointer);
			
			switch prop
				case 10 % SubjectST_MP.BA
					check = Format.checkFormat(8, value, SubjectST_MP.getPropSettings(prop));
				case 11 % SubjectST_MP.L
					check = Format.checkFormat(11, value, SubjectST_MP.getPropSettings(prop));
				case 12 % SubjectST_MP.LAYERLABELS
					check = Format.checkFormat(3, value, SubjectST_MP.getPropSettings(prop));
				case 13 % SubjectST_MP.ALAYERLABELS
					check = Format.checkFormat(3, value, SubjectST_MP.getPropSettings(prop));
				case 14 % SubjectST_MP.ST_MP
					check = Format.checkFormat(16, value, SubjectST_MP.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@Subject(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SubjectST_MP:' 'WrongInput'], ...
					['BRAPH2' ':SubjectST_MP:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SubjectST_MP.getPropTag(prop) ' (' SubjectST_MP.getFormatTag(SubjectST_MP.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(sub, prop)
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
				case 11 % SubjectST_MP.L
					if ~isa(sub.getr('ST_MP'), 'NoValue') && sub.get('L') ~= length(sub.get('ST_MP'))
					    sub.set('L', length(sub.get('ST_MP')))
					end
					
				case 12 % SubjectST_MP.LAYERLABELS
					if ~isa(sub.getr('L'), 'NoValue') && length(sub.get('LAYERLABELS')) ~= sub.get('L')
					    title = ['About Layer Labels'];
					    message = {''
					        ['{\bf\color{orange}' 'BRAPH2' '}'] % note to use double slashes to avoid genesis problem
					        ['{\color{gray}version ' '2.0.1' '}']
					        ['{\color{gray}build ' int2str(7) '}']
					        ''
					        'Please, select a valid number of Layer Labels.'
					        ''
					        ''};
					    braph2msgbox(title, message)
					    
					    sub.set('LAYERLABELS', cat(1, strsplit(num2str(1:1:length(sub.get('ST_MP'))))))
					end
					
				case 14 % SubjectST_MP.ST_MP
					if length(sub.get('LAYERLABELS')) ~= sub.get('L')
					    sub.set('LAYERLABELS', cat(1, strsplit(num2str(1:1:length(sub.get('ST_MP'))))))
					end
					
				otherwise
					if prop <= 9
						postset@Subject(sub, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(sub, prop, varargin)
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
				case 13 % SubjectST_MP.ALAYERLABELS
					value = sub.get('LAYERLABELS');
					
				otherwise
					if prop <= 9
						value = calculateValue@Subject(sub, prop, varargin{:});
					else
						value = calculateValue@Element(sub, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(sub, prop, value)
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
			msg = ['Error while checking ' tostring(sub) ' ' sub.getPropTag(prop) '.'];
			
			switch prop
				case 14 % SubjectST_MP.ST_MP
					br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
					num_layers = sub.get('L');
					check = (iscell(value) && isequal(length(value), num_layers)  && isequal( cellfun(@(v) size(v, 1), value), ones(1, num_layers) * br_number)) || (isempty(value) && br_number == 0); 
					if check
					    msg = 'All ok!';
					else   
					    msg = ['ST_MP must be a column vector with the same number of element as the brain regions (' int2str(br_number) ').'];
					end
					
				otherwise
					if prop <= 9
						[check, msg] = checkValue@Subject(sub, prop, value);
					end
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(sub, prop, varargin)
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
				case 14 % SubjectST_MP.ST_MP
					pr = PanelPropCell('EL', sub, 'PROP', 14, ...
					    'TABLE_HEIGHT', 480, ...
					    'XSLIDERSHOW', true, ...
					    'XSLIDERLABELS', sub.getCallback('ALAYERLABELS'), ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
					    'COLUMNNAME', {}, ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@Subject(sub, prop, varargin{:});
					
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
			
			if isa(el, 'Group')
			    uimenu(menu_import, ...
			        'Tag', 'MENU.Import.TXT', ...
			        'Label', 'Import TXT ...', ...
			        'Callback', {@cb_importer_TXT});
			end
			function cb_importer_TXT(~, ~)
			    try
			        im = ImporterGroupSubjectST_MP_TXT( ...
			            'ID', 'Import Group of SubjectStMPs from TXT', ...
			            'WAITBAR', true ...
			            ).get('GET_DIR');
			        if ~isa(im.getr('DIRECTORY'), 'NoValue')
			            gr = im.get('GR');
			            gui = GUIElement('PE', gr);
			            gui.get('DRAW')
			            gui.get('SHOW')
			        end
			    catch e
			        %TODO implement and use braph2msgbox instead of warndlg
			        warndlg(['Please, select a valid input Group of SubjectStMps in TXT format. ' newline() ...
			            newline() ...
			            'Error message:' newline() ...
			            newline() ...
			            e.message newline()], 'Warning');
			    end
			end
			
			if isa(el, 'Group')
			    uimenu(menu_import, ...
			        'Tag', 'MENU.Import.XLS', ...
			        'Label', 'Import XLS ...', ...
			        'Callback', {@cb_importer_XLS});
			end
			function cb_importer_XLS(~, ~)
			    try
			        im = ImporterGroupSubjectST_MP_XLS( ...
			            'ID', 'Import Group of SubjectStMPs from XLS', ...
			            'WAITBAR', true ...
			            ).get('GET_DIR');
			        if ~isa(im.getr('DIRECTORY'), 'NoValue')
			            gr = im.get('GR');
			            gui = GUIElement('PE', gr);
			            gui.get('DRAW')
			            gui.get('SHOW')
			        end
			    catch e
			        %TODO implement and use braph2msgbox instead of warndlg
			        warndlg(['Please, select a valid input Group of SubjectStMps in XLS format. ' newline() ...
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
			
			if isa(el, 'Group')
			    uimenu(menu_export, ...
			        'Tag', 'MENU.Export.TXT', ...
			        'Label', 'Export TXT ...', ...
			        'Callback', {@cb_exporter_TXT});
			end
			function cb_exporter_TXT(~, ~)
			    ex = ExporterGroupSubjectST_MP_TXT( ...
			        'ID', 'Export Brain Group of SubjectST_MPs to TXT', ...
			        'GR', el, ...
			        'WAITBAR', true ...
			        ).get('PUT_DIR');
			    if ~isa(ex.get('DIRECTORY'), 'NoValue')
			        ex.get('SAVE');
			    end
			end
			
			if isa(el, 'Group')
			    uimenu(menu_export, ...
			        'Tag', 'MENU.Export.XLS', ...
			        'Label', 'Export XLS ...', ...
			        'Callback', {@cb_exporter_XLS});
			end
			function cb_exporter_XLS(~, ~)
			    ex = ExporterGroupSubjectST_MP_XLS( ...
			        'ID', 'Export Brain Group of SubjectST_MPs to XLS', ...
			        'GR', el, ... 
			        'WAITBAR', true ...
			        ).get('PUT_DIR');
			    if ~isa(ex.get('DIRECTORY'), 'NoValue')
			        ex.get('SAVE');
			    end
			end
			
		end
	end
end
