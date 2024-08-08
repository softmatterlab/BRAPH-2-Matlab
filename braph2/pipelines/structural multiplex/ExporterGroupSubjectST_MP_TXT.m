classdef ExporterGroupSubjectST_MP_TXT < Exporter
	%ExporterGroupSubjectST_MP_TXT exports a group of subjects with structural multiplex data to an TXT file.
	% It is a subclass of <a href="matlab:help Exporter">Exporter</a>.
	%
	% ExporterGroupSubjectST_MP_TXT exports a group of subjects with structural 
	%  multiplex data to a series of TXT files contained in a folder named 
	%  "GROUP_ID". Each file corresponds to a layer of the multiplex and is 
	%  labeled with the layer number indicated as, e.g., "GROUP_ID.1.txt" and 
	%  "GROUP_ID.2.txt". 
	%  Each file contains the following columns: Subject ID (column 1), Subject 
	%  LABEL (column 2), Subject NOTES (column 3) and BrainRegions 
	%  (columns 4-end; one brain region value per column). The first row contains 
	%  the headers and each subsequent row the values for each subject.
	% The variables of interest are from another XLSX file named "GROUP_ID.vois.txt" 
	%  (if exisitng) consisting of the following columns: 
	%  Subject ID (column 1), covariates (subsequent columns). 
	%  The 1st row contains the headers, the 2nd row a string with the categorical
	%  variables of interest, and each subsequent row the values for each subject.
	%
	% ExporterGroupSubjectST_MP_TXT methods (constructor):
	%  ExporterGroupSubjectST_MP_TXT - constructor
	%
	% ExporterGroupSubjectST_MP_TXT methods:
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
	% ExporterGroupSubjectST_MP_TXT methods (display):
	%  tostring - string with information about the exporter of ST MP subject group in TXT
	%  disp - displays information about the exporter of ST MP subject group in TXT
	%  tree - displays the tree of the exporter of ST MP subject group in TXT
	%
	% ExporterGroupSubjectST_MP_TXT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two exporter of ST MP subject group in TXT are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the exporter of ST MP subject group in TXT
	%
	% ExporterGroupSubjectST_MP_TXT methods (save/load, Static):
	%  save - saves BRAPH2 exporter of ST MP subject group in TXT as b2 file
	%  load - loads a BRAPH2 exporter of ST MP subject group in TXT from a b2 file
	%
	% ExporterGroupSubjectST_MP_TXT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the exporter of ST MP subject group in TXT
	%
	% ExporterGroupSubjectST_MP_TXT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the exporter of ST MP subject group in TXT
	%
	% ExporterGroupSubjectST_MP_TXT methods (inspection, Static):
	%  getClass - returns the class of the exporter of ST MP subject group in TXT
	%  getSubclasses - returns all subclasses of ExporterGroupSubjectST_MP_TXT
	%  getProps - returns the property list of the exporter of ST MP subject group in TXT
	%  getPropNumber - returns the property number of the exporter of ST MP subject group in TXT
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
	% ExporterGroupSubjectST_MP_TXT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ExporterGroupSubjectST_MP_TXT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ExporterGroupSubjectST_MP_TXT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ExporterGroupSubjectST_MP_TXT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ExporterGroupSubjectST_MP_TXT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ExporterGroupSubjectST_MP_TXT constants</a>.
	%
	%
	% See also Group, SubjectST_MP, ImporterGroupSubjectST_MP_TXT.
	
	properties (Constant) % properties
		GR = Exporter.getPropNumber() + 1;
		GR_TAG = 'GR';
		GR_CATEGORY = Category.DATA;
		GR_FORMAT = Format.ITEM;
		
		DIRECTORY = Exporter.getPropNumber() + 2;
		DIRECTORY_TAG = 'DIRECTORY';
		DIRECTORY_CATEGORY = Category.DATA;
		DIRECTORY_FORMAT = Format.STRING;
		
		PUT_DIR = Exporter.getPropNumber() + 3;
		PUT_DIR_TAG = 'PUT_DIR';
		PUT_DIR_CATEGORY = Category.QUERY;
		PUT_DIR_FORMAT = Format.ITEM;
		
		SAVE = Exporter.getPropNumber() + 4;
		SAVE_TAG = 'SAVE';
		SAVE_CATEGORY = Category.RESULT;
		SAVE_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function ex = ExporterGroupSubjectST_MP_TXT(varargin)
			%ExporterGroupSubjectST_MP_TXT() creates a exporter of ST MP subject group in TXT.
			%
			% ExporterGroupSubjectST_MP_TXT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ExporterGroupSubjectST_MP_TXT(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			ex = ex@Exporter(varargin{:});
		end
	end
	methods (Static) % inspection
		function ex_class = getClass()
			%GETCLASS returns the class of the exporter of ST MP subject group in TXT.
			%
			% CLASS = ExporterGroupSubjectST_MP_TXT.GETCLASS() returns the class 'ExporterGroupSubjectST_MP_TXT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = EX.GETCLASS() returns the class of the exporter of ST MP subject group in TXT EX.
			%  CLASS = Element.GETCLASS(EX) returns the class of 'EX'.
			%  CLASS = Element.GETCLASS('ExporterGroupSubjectST_MP_TXT') returns 'ExporterGroupSubjectST_MP_TXT'.
			%
			% Note that the Element.GETCLASS(EX) and Element.GETCLASS('ExporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			
			ex_class = 'ExporterGroupSubjectST_MP_TXT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the exporter of ST MP subject group in TXT.
			%
			% LIST = ExporterGroupSubjectST_MP_TXT.GETSUBCLASSES() returns all subclasses of 'ExporterGroupSubjectST_MP_TXT'.
			%
			% Alternative forms to call this method are:
			%  LIST = EX.GETSUBCLASSES() returns all subclasses of the exporter of ST MP subject group in TXT EX.
			%  LIST = Element.GETSUBCLASSES(EX) returns all subclasses of 'EX'.
			%  LIST = Element.GETSUBCLASSES('ExporterGroupSubjectST_MP_TXT') returns all subclasses of 'ExporterGroupSubjectST_MP_TXT'.
			%
			% Note that the Element.GETSUBCLASSES(EX) and Element.GETSUBCLASSES('ExporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ExporterGroupSubjectST_MP_TXT', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of exporter of ST MP subject group in TXT.
			%
			% PROPS = ExporterGroupSubjectST_MP_TXT.GETPROPS() returns the property list of exporter of ST MP subject group in TXT
			%  as a row vector.
			%
			% PROPS = ExporterGroupSubjectST_MP_TXT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = EX.GETPROPS([CATEGORY]) returns the property list of the exporter of ST MP subject group in TXT EX.
			%  PROPS = Element.GETPROPS(EX[, CATEGORY]) returns the property list of 'EX'.
			%  PROPS = Element.GETPROPS('ExporterGroupSubjectST_MP_TXT'[, CATEGORY]) returns the property list of 'ExporterGroupSubjectST_MP_TXT'.
			%
			% Note that the Element.GETPROPS(EX) and Element.GETPROPS('ExporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Exporter.getProps() ...
						ExporterGroupSubjectST_MP_TXT.GR ...
						ExporterGroupSubjectST_MP_TXT.DIRECTORY ...
						ExporterGroupSubjectST_MP_TXT.PUT_DIR ...
						ExporterGroupSubjectST_MP_TXT.SAVE ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Exporter.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Exporter.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Exporter.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Exporter.getProps(Category.DATA) ...
						ExporterGroupSubjectST_MP_TXT.GR ...
						ExporterGroupSubjectST_MP_TXT.DIRECTORY ...
						];
				case Category.RESULT
					prop_list = [
						Exporter.getProps(Category.RESULT) ...
						ExporterGroupSubjectST_MP_TXT.SAVE ...
						];
				case Category.QUERY
					prop_list = [ ...
						Exporter.getProps(Category.QUERY) ...
						ExporterGroupSubjectST_MP_TXT.PUT_DIR ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Exporter.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Exporter.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Exporter.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of exporter of ST MP subject group in TXT.
			%
			% N = ExporterGroupSubjectST_MP_TXT.GETPROPNUMBER() returns the property number of exporter of ST MP subject group in TXT.
			%
			% N = ExporterGroupSubjectST_MP_TXT.GETPROPNUMBER(CATEGORY) returns the property number of exporter of ST MP subject group in TXT
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = EX.GETPROPNUMBER([CATEGORY]) returns the property number of the exporter of ST MP subject group in TXT EX.
			%  N = Element.GETPROPNUMBER(EX) returns the property number of 'EX'.
			%  N = Element.GETPROPNUMBER('ExporterGroupSubjectST_MP_TXT') returns the property number of 'ExporterGroupSubjectST_MP_TXT'.
			%
			% Note that the Element.GETPROPNUMBER(EX) and Element.GETPROPNUMBER('ExporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ExporterGroupSubjectST_MP_TXT.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in exporter of ST MP subject group in TXT/error.
			%
			% CHECK = ExporterGroupSubjectST_MP_TXT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSPROP(PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(EX, PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(ExporterGroupSubjectST_MP_TXT, PROP) checks whether PROP exists for ExporterGroupSubjectST_MP_TXT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ExporterGroupSubjectST_MP_TXT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSPROP(PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_MP_TXT:WrongInput]
			%  Element.EXISTSPROP(EX, PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_MP_TXT:WrongInput]
			%  Element.EXISTSPROP(ExporterGroupSubjectST_MP_TXT, PROP) throws error if PROP does NOT exist for ExporterGroupSubjectST_MP_TXT.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_MP_TXT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(EX) and Element.EXISTSPROP('ExporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ExporterGroupSubjectST_MP_TXT.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ExporterGroupSubjectST_MP_TXT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterGroupSubjectST_MP_TXT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ExporterGroupSubjectST_MP_TXT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in exporter of ST MP subject group in TXT/error.
			%
			% CHECK = ExporterGroupSubjectST_MP_TXT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSTAG(TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(EX, TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(ExporterGroupSubjectST_MP_TXT, TAG) checks whether TAG exists for ExporterGroupSubjectST_MP_TXT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ExporterGroupSubjectST_MP_TXT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSTAG(TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_MP_TXT:WrongInput]
			%  Element.EXISTSTAG(EX, TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_MP_TXT:WrongInput]
			%  Element.EXISTSTAG(ExporterGroupSubjectST_MP_TXT, TAG) throws error if TAG does NOT exist for ExporterGroupSubjectST_MP_TXT.
			%   Error id: [BRAPH2:ExporterGroupSubjectST_MP_TXT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(EX) and Element.EXISTSTAG('ExporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			exportergroupsubjectst_mp_txt_tag_list = cellfun(@(x) ExporterGroupSubjectST_MP_TXT.getPropTag(x), num2cell(ExporterGroupSubjectST_MP_TXT.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, exportergroupsubjectst_mp_txt_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ExporterGroupSubjectST_MP_TXT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterGroupSubjectST_MP_TXT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ExporterGroupSubjectST_MP_TXT.'] ...
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
			%  PROPERTY = EX.GETPROPPROP(POINTER) returns property number of POINTER of EX.
			%  PROPERTY = Element.GETPROPPROP(ExporterGroupSubjectST_MP_TXT, POINTER) returns property number of POINTER of ExporterGroupSubjectST_MP_TXT.
			%  PROPERTY = EX.GETPROPPROP(ExporterGroupSubjectST_MP_TXT, POINTER) returns property number of POINTER of ExporterGroupSubjectST_MP_TXT.
			%
			% Note that the Element.GETPROPPROP(EX) and Element.GETPROPPROP('ExporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				exportergroupsubjectst_mp_txt_tag_list = cellfun(@(x) ExporterGroupSubjectST_MP_TXT.getPropTag(x), num2cell(ExporterGroupSubjectST_MP_TXT.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, exportergroupsubjectst_mp_txt_tag_list)); % tag = pointer
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
			%  TAG = EX.GETPROPTAG(POINTER) returns tag of POINTER of EX.
			%  TAG = Element.GETPROPTAG(ExporterGroupSubjectST_MP_TXT, POINTER) returns tag of POINTER of ExporterGroupSubjectST_MP_TXT.
			%  TAG = EX.GETPROPTAG(ExporterGroupSubjectST_MP_TXT, POINTER) returns tag of POINTER of ExporterGroupSubjectST_MP_TXT.
			%
			% Note that the Element.GETPROPTAG(EX) and Element.GETPROPTAG('ExporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ExporterGroupSubjectST_MP_TXT.GR
						tag = ExporterGroupSubjectST_MP_TXT.GR_TAG;
					case ExporterGroupSubjectST_MP_TXT.DIRECTORY
						tag = ExporterGroupSubjectST_MP_TXT.DIRECTORY_TAG;
					case ExporterGroupSubjectST_MP_TXT.PUT_DIR
						tag = ExporterGroupSubjectST_MP_TXT.PUT_DIR_TAG;
					case ExporterGroupSubjectST_MP_TXT.SAVE
						tag = ExporterGroupSubjectST_MP_TXT.SAVE_TAG;
					otherwise
						tag = getPropTag@Exporter(prop);
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
			%  CATEGORY = EX.GETPROPCATEGORY(POINTER) returns category of POINTER of EX.
			%  CATEGORY = Element.GETPROPCATEGORY(ExporterGroupSubjectST_MP_TXT, POINTER) returns category of POINTER of ExporterGroupSubjectST_MP_TXT.
			%  CATEGORY = EX.GETPROPCATEGORY(ExporterGroupSubjectST_MP_TXT, POINTER) returns category of POINTER of ExporterGroupSubjectST_MP_TXT.
			%
			% Note that the Element.GETPROPCATEGORY(EX) and Element.GETPROPCATEGORY('ExporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ExporterGroupSubjectST_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectST_MP_TXT.GR
					prop_category = ExporterGroupSubjectST_MP_TXT.GR_CATEGORY;
				case ExporterGroupSubjectST_MP_TXT.DIRECTORY
					prop_category = ExporterGroupSubjectST_MP_TXT.DIRECTORY_CATEGORY;
				case ExporterGroupSubjectST_MP_TXT.PUT_DIR
					prop_category = ExporterGroupSubjectST_MP_TXT.PUT_DIR_CATEGORY;
				case ExporterGroupSubjectST_MP_TXT.SAVE
					prop_category = ExporterGroupSubjectST_MP_TXT.SAVE_CATEGORY;
				otherwise
					prop_category = getPropCategory@Exporter(prop);
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
			%  FORMAT = EX.GETPROPFORMAT(POINTER) returns format of POINTER of EX.
			%  FORMAT = Element.GETPROPFORMAT(ExporterGroupSubjectST_MP_TXT, POINTER) returns format of POINTER of ExporterGroupSubjectST_MP_TXT.
			%  FORMAT = EX.GETPROPFORMAT(ExporterGroupSubjectST_MP_TXT, POINTER) returns format of POINTER of ExporterGroupSubjectST_MP_TXT.
			%
			% Note that the Element.GETPROPFORMAT(EX) and Element.GETPROPFORMAT('ExporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ExporterGroupSubjectST_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectST_MP_TXT.GR
					prop_format = ExporterGroupSubjectST_MP_TXT.GR_FORMAT;
				case ExporterGroupSubjectST_MP_TXT.DIRECTORY
					prop_format = ExporterGroupSubjectST_MP_TXT.DIRECTORY_FORMAT;
				case ExporterGroupSubjectST_MP_TXT.PUT_DIR
					prop_format = ExporterGroupSubjectST_MP_TXT.PUT_DIR_FORMAT;
				case ExporterGroupSubjectST_MP_TXT.SAVE
					prop_format = ExporterGroupSubjectST_MP_TXT.SAVE_FORMAT;
				otherwise
					prop_format = getPropFormat@Exporter(prop);
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
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(POINTER) returns description of POINTER of EX.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ExporterGroupSubjectST_MP_TXT, POINTER) returns description of POINTER of ExporterGroupSubjectST_MP_TXT.
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(ExporterGroupSubjectST_MP_TXT, POINTER) returns description of POINTER of ExporterGroupSubjectST_MP_TXT.
			%
			% Note that the Element.GETPROPDESCRIPTION(EX) and Element.GETPROPDESCRIPTION('ExporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ExporterGroupSubjectST_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectST_MP_TXT.GR
					prop_description = 'GR (data, item) is a group of subjects with structural multiplex data.';
				case ExporterGroupSubjectST_MP_TXT.DIRECTORY
					prop_description = 'DIRECTORY (data, string) is the directory name where to save the group of subjects with structural multiplex data.';
				case ExporterGroupSubjectST_MP_TXT.PUT_DIR
					prop_description = 'PUT_DIR (query, item) opens a dialog box to set the directory where to save the group of subjects with structural multiplex data.';
				case ExporterGroupSubjectST_MP_TXT.SAVE
					prop_description = 'SAVE (result, empty) saves the group of subjects with structural multiplex data in TXT files in the selected directory.';
				case ExporterGroupSubjectST_MP_TXT.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the ST subject group exporter in TXT.';
				case ExporterGroupSubjectST_MP_TXT.NAME
					prop_description = 'NAME (constant, string) is the name of the ST subject group exporter in TXT.';
				case ExporterGroupSubjectST_MP_TXT.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the ST subject group exporter in TXT.';
				case ExporterGroupSubjectST_MP_TXT.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the ST subject group exporter in TXT.';
				case ExporterGroupSubjectST_MP_TXT.ID
					prop_description = 'ID (data, string) is a few-letter code for the ST subject group exporter in TXT.';
				case ExporterGroupSubjectST_MP_TXT.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the ST subject group exporter in TXT.';
				case ExporterGroupSubjectST_MP_TXT.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the ST subject group exporter in TXT.';
				otherwise
					prop_description = getPropDescription@Exporter(prop);
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
			%  SETTINGS = EX.GETPROPSETTINGS(POINTER) returns settings of POINTER of EX.
			%  SETTINGS = Element.GETPROPSETTINGS(ExporterGroupSubjectST_MP_TXT, POINTER) returns settings of POINTER of ExporterGroupSubjectST_MP_TXT.
			%  SETTINGS = EX.GETPROPSETTINGS(ExporterGroupSubjectST_MP_TXT, POINTER) returns settings of POINTER of ExporterGroupSubjectST_MP_TXT.
			%
			% Note that the Element.GETPROPSETTINGS(EX) and Element.GETPROPSETTINGS('ExporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ExporterGroupSubjectST_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectST_MP_TXT.GR
					prop_settings = 'Group';
				case ExporterGroupSubjectST_MP_TXT.DIRECTORY
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ExporterGroupSubjectST_MP_TXT.PUT_DIR
					prop_settings = 'ExporterGroupSubjectST_MP_TXT';
				case ExporterGroupSubjectST_MP_TXT.SAVE
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case ExporterGroupSubjectST_MP_TXT.TEMPLATE
					prop_settings = 'ExporterGroupSubjectST_MP_TXT';
				otherwise
					prop_settings = getPropSettings@Exporter(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ExporterGroupSubjectST_MP_TXT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterGroupSubjectST_MP_TXT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULT(ExporterGroupSubjectST_MP_TXT, POINTER) returns the default value of POINTER of ExporterGroupSubjectST_MP_TXT.
			%  DEFAULT = EX.GETPROPDEFAULT(ExporterGroupSubjectST_MP_TXT, POINTER) returns the default value of POINTER of ExporterGroupSubjectST_MP_TXT.
			%
			% Note that the Element.GETPROPDEFAULT(EX) and Element.GETPROPDEFAULT('ExporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ExporterGroupSubjectST_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectST_MP_TXT.GR
					prop_default = Group('SUB_CLASS', 'SubjectST_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST_MP'));
				case ExporterGroupSubjectST_MP_TXT.DIRECTORY
					prop_default = [fileparts(which('test_braph2')) filesep 'default_group_subjects_ST_ML_most_likely_to_be_erased'];
				case ExporterGroupSubjectST_MP_TXT.PUT_DIR
					prop_default = Format.getFormatDefault(Format.ITEM, ExporterGroupSubjectST_MP_TXT.getPropSettings(prop));
				case ExporterGroupSubjectST_MP_TXT.SAVE
					prop_default = Format.getFormatDefault(Format.EMPTY, ExporterGroupSubjectST_MP_TXT.getPropSettings(prop));
				case ExporterGroupSubjectST_MP_TXT.ELCLASS
					prop_default = 'ExporterGroupSubjectST_MP_TXT';
				case ExporterGroupSubjectST_MP_TXT.NAME
					prop_default = 'Multiplex Structural Subject Group TXT Exporter';
				case ExporterGroupSubjectST_MP_TXT.DESCRIPTION
					prop_default = 'ExporterGroupSubjectST_MP_TXT exports a group of subjects with structural multiplex data to an TXT file and their covariates age and sex (if existing) to another TXT file.';
				case ExporterGroupSubjectST_MP_TXT.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ExporterGroupSubjectST_MP_TXT.getPropSettings(prop));
				case ExporterGroupSubjectST_MP_TXT.ID
					prop_default = 'ExporterGroupSubjectST_MP_TXT ID';
				case ExporterGroupSubjectST_MP_TXT.LABEL
					prop_default = 'ExporterGroupSubjectST_MP_TXT label';
				case ExporterGroupSubjectST_MP_TXT.NOTES
					prop_default = 'ExporterGroupSubjectST_MP_TXT notes';
				otherwise
					prop_default = getPropDefault@Exporter(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ExporterGroupSubjectST_MP_TXT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ExporterGroupSubjectST_MP_TXT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ExporterGroupSubjectST_MP_TXT, POINTER) returns the conditioned default value of POINTER of ExporterGroupSubjectST_MP_TXT.
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(ExporterGroupSubjectST_MP_TXT, POINTER) returns the conditioned default value of POINTER of ExporterGroupSubjectST_MP_TXT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(EX) and Element.GETPROPDEFAULTCONDITIONED('ExporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ExporterGroupSubjectST_MP_TXT.getPropProp(pointer);
			
			prop_default = ExporterGroupSubjectST_MP_TXT.conditioning(prop, ExporterGroupSubjectST_MP_TXT.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = EX.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = EX.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of EX.
			%  CHECK = Element.CHECKPROP(ExporterGroupSubjectST_MP_TXT, PROP, VALUE) checks VALUE format for PROP of ExporterGroupSubjectST_MP_TXT.
			%  CHECK = EX.CHECKPROP(ExporterGroupSubjectST_MP_TXT, PROP, VALUE) checks VALUE format for PROP of ExporterGroupSubjectST_MP_TXT.
			% 
			% EX.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ExporterGroupSubjectST_MP_TXT:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  EX.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EX.
			%   Error id: €BRAPH2.STR€:ExporterGroupSubjectST_MP_TXT:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ExporterGroupSubjectST_MP_TXT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterGroupSubjectST_MP_TXT.
			%   Error id: €BRAPH2.STR€:ExporterGroupSubjectST_MP_TXT:€BRAPH2.WRONG_INPUT€
			%  EX.CHECKPROP(ExporterGroupSubjectST_MP_TXT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ExporterGroupSubjectST_MP_TXT.
			%   Error id: €BRAPH2.STR€:ExporterGroupSubjectST_MP_TXT:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(EX) and Element.CHECKPROP('ExporterGroupSubjectST_MP_TXT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ExporterGroupSubjectST_MP_TXT.getPropProp(pointer);
			
			switch prop
				case ExporterGroupSubjectST_MP_TXT.GR % __ExporterGroupSubjectST_MP_TXT.GR__
					check = Format.checkFormat(Format.ITEM, value, ExporterGroupSubjectST_MP_TXT.getPropSettings(prop));
					if check
						check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectST_MP', [], [], true)));
					end
				case ExporterGroupSubjectST_MP_TXT.DIRECTORY % __ExporterGroupSubjectST_MP_TXT.DIRECTORY__
					check = Format.checkFormat(Format.STRING, value, ExporterGroupSubjectST_MP_TXT.getPropSettings(prop));
				case ExporterGroupSubjectST_MP_TXT.PUT_DIR % __ExporterGroupSubjectST_MP_TXT.PUT_DIR__
					check = Format.checkFormat(Format.ITEM, value, ExporterGroupSubjectST_MP_TXT.getPropSettings(prop));
				case ExporterGroupSubjectST_MP_TXT.SAVE % __ExporterGroupSubjectST_MP_TXT.SAVE__
					check = Format.checkFormat(Format.EMPTY, value, ExporterGroupSubjectST_MP_TXT.getPropSettings(prop));
				case ExporterGroupSubjectST_MP_TXT.TEMPLATE % __ExporterGroupSubjectST_MP_TXT.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ExporterGroupSubjectST_MP_TXT.getPropSettings(prop));
				otherwise
					if prop <= Exporter.getPropNumber()
						check = checkProp@Exporter(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ExporterGroupSubjectST_MP_TXT:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ExporterGroupSubjectST_MP_TXT:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ExporterGroupSubjectST_MP_TXT.getPropTag(prop) ' (' ExporterGroupSubjectST_MP_TXT.getFormatTag(ExporterGroupSubjectST_MP_TXT.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(ex, prop, varargin)
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
				case ExporterGroupSubjectST_MP_TXT.PUT_DIR % __ExporterGroupSubjectST_MP_TXT.PUT_DIR__
					directory = uigetdir('Select directory');
					if ischar(directory) && isfolder(directory)
					    ex.set('DIRECTORY', directory);
					end
					value = ex;
					
				case ExporterGroupSubjectST_MP_TXT.SAVE % __ExporterGroupSubjectST_MP_TXT.SAVE__
					rng_settings_ = rng(); rng(ex.getPropSeed(ExporterGroupSubjectST_MP_TXT.SAVE), 'twister')
					
					directory = ex.get('DIRECTORY');
					
					if isfolder(directory)
					    wb = braph2waitbar(ex.get('WAITBAR'), 0, 'Retrieving path ...');
					
					    gr = ex.get('GR');
					
					    gr_directory = [directory filesep() gr.get('ID')];
					    if ~exist(gr_directory, 'dir')
					        mkdir(gr_directory)
					    end
					
					    braph2waitbar(wb, .15, 'Organizing info ...')
					
					    sub_dict = gr.get('SUB_DICT');
					    sub_number = sub_dict.get('LENGTH');
					
						L = sub_dict.get('IT', 1).get('L');
					    for l = 1:1:L
					        braph2waitbar(wb, .25 + .75 * l / L, ['Saving layer ' num2str(l) ' of ' num2str(L) ' ...'])
					        
					        if sub_number == 0
					            tab = {'ID', 'Label', 'Notes'};
					        else
					            sub = sub_dict.get('IT', 1);
					            ba = sub.get('BA');
					            br_list = cellfun(@(i) ba.get('BR_DICT').get('IT', i), ...
					                num2cell([1:1:ba.get('BR_DICT').get('LENGTH')]), 'UniformOutput', false);
					            br_labels = cellfun(@(br) br.get('ID'), br_list, 'UniformOutput', false);
					
					            tab = cell(1 + sub_number, 3 + numel(br_labels));
					            tab{1, 1} = 'ID';
					            tab{1, 2} = 'Label';
					            tab{1, 3} = 'Notes';
					            for j = 1:1:length(br_labels)
					                tab{1, 3 + j} = br_labels{j};
					            end
					
					            for i = 1:1:sub_number
					                sub = sub_dict.get('IT', i);
					
					                tab{1 + i, 1} = sub.get('ID');
					                tab{1 + i, 2} = sub.get('LABEL');
					                tab{1 + i, 3} = sub.get('NOTES');
					
					                sub_ST_MP = sub.get('ST_MP');
					                sub_ST = sub_ST_MP{l};
					                for j = 1:1:length(sub_ST)
					                    tab{1 + i, 3 + j} = sub_ST(j);
					                end
					            end
					        end
					        
					        layer_file = [gr_directory filesep() gr.get('ID') '.' int2str(l) '.txt'];
					
					        writetable(table(tab), layer_file, 'Delimiter', '	', 'WriteVariableNames', false);        
					    end
					    
					    % variables of interest
					    voi_ids = {};
					    for i = 1:1:sub_number
					        sub = sub_dict.get('IT', i);
					        voi_ids = unique([voi_ids, sub.get('VOI_DICT').get('KEYS')]);
					    end
					    if ~isempty(voi_ids)
					        vois = cell(2 + sub_number, 1 + length(voi_ids));
					        vois{1, 1} = 'Subject ID';
					        vois(1, 2:end) = voi_ids;
					        for i = 1:1:sub_number
					            sub = sub_dict.get('IT', i);
					            vois{2 + i, 1} = sub.get('ID');
					            
					            voi_dict = sub.get('VOI_DICT');
					            for v = 1:1:voi_dict.get('LENGTH')
					                voi = voi_dict.get('IT', v);
					                voi_id = voi.get('ID');
					                if isa(voi, 'VOINumeric') % Numeric
					                    vois{2 + i, 1 + find(strcmp(voi_id, voi_ids))} = voi.get('V');
					                elseif isa(voi, 'VOICategoric') % Categoric
					                    categories = voi.get('CATEGORIES');
					                    vois{2, 1 + find(strcmp(voi_id, voi_ids))} = {['{' sprintf(' ''%s'' ', categories{:}) '}']};
					                    vois{2 + i, 1 + find(strcmp(voi_id, voi_ids))} = categories{voi.get('V')};
					                end
					            end
					        end
					        writetable(table(vois), [gr_directory '.vois.txt'], 'Delimiter', '	', 'WriteVariableNames', false)
					    end
					    
					    braph2waitbar(wb, 'close')
					end
					
					% sets value to empty
					value = [];
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Exporter.getPropNumber()
						value = calculateValue@Exporter(ex, prop, varargin{:});
					else
						value = calculateValue@Element(ex, prop, varargin{:});
					end
			end
			
		end
	end
end
