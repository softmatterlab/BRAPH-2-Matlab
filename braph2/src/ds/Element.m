classdef Element < Category & Format & matlab.mixin.Copyable
    %Element is the base class for all elements.
    % Element provides the infrastructure necessary for all elements. Even
    %  though it is possible to create instances of Element, typically 
    %  one uses its subclasses. It is a subclass of Category, Format,
    %  handle, and matlab.mixin.Copyable.
    %
    % Each element is essentially a container for a series of properties.
    %  Each propery has a category (see <a href="matlab:help Category">Category</a>) and a format (see <a href="matlab:help Format">Format</a>).
    %  Each subelement can implement the following protected methods (see <a href="matlab:help Element.set">Element.set</a>):
    %   <strong>conditioning</strong>   - conditions a value before setting a property (static function) <a href="matlab:help Element.conditioning">read more</a> 
    %   <strong>preset</strong>         - presets a value before setting a property <a href="matlab:help Element.preset">read more</a> 
    %   <strong>checkProp</strong>      - checks the property format before setting <a href="matlab:help Element.checkProp">read more</a> 
    %   <strong>postset</strong>        - postsets a property after it has been set <a href="matlab:help Element.postset">read more</a> 
    %   <strong>postprocessing</strong> - postprocesses the value of a prop 
    %                    AFTER all properties have been set <a href="matlab:help Element.postprocessing">read more</a> 
    %   <strong>calculateValue</strong> - (only for results) calculates the value of a property <a href="matlab:help Element.calculateValue">read more</a> 
    %   <strong>checkValue</strong>     - checks the value of a property 
    %                    (for a result, after it is calculated) <a href="matlab:help Element.checkValue">read more</a>
    %
    % An element notifies the following <a href="matlab:help event">events</a>:
    %  <strong>PropSet</strong>         - when a property is successfully set 
    %                    with event data in <a href="matlab:help EventPropSet">EventPropSet</a>
    %  <strong>PropMemorized</strong>   - when a property of category RESULT, QUERY 
    %                    or EVANESCENT is successfully memorized
    %                    with event data in <a href="matlab:help EventPropMemorized">EventPropMemorized</a>
    %  <strong>PropLocked</strong>      - when a property is locked
    %                    with event data in <a href="matlab:help EventPropMemorized">EventPropLocked</a>
    %
    % Element methods (constructor):
    %  Element - constructor
    %  
    % Element methods:
    %  set - sets values of a property
    %  check - checks the values of all properties
    %  getr - returns the raw value of a property
    %  get - returns the value of a property
    %  memorize - returns the value of a property and memorizes it 
    %             (for RESULT, QUERY, and EVANESCENT properties)
    %  getPropSeed - returns the seed of a property
    %  isLocked - returns whether a property is locked
    %  lock - locks irreversibly a property
    %  isChecked - returns whether a property is checked
    %  checked - sets a property to checked
    %  unchecked - sets a property to NOT checked
    %  
    % Element methods (display):
    %  tostring - string with information about the element
    %  disp - displays information about the element
    %  tree - displays the element tree
    %
    % Element methods (miscellanea):
    %  getNoValue - returns a pointer to a persistent instance of NoValue
    %  getCallback - returns the callback to a property
    %  isequal - determines whether two elements are equal (values, locked)
    %  getElementList - returns a list with all subelements
    %  copy - copies the element
    %
    % Element methods (save/load, Static):
    %  save - saves BRAPH2 element as b2 file
    %  load - loads a BRAPH2 element from a b2 file
    %  
    % Element method (JSON encode):
    %  encodeJSON - returns a JSON string encoding the element
    %
    % Element method (JSON decode, Static):
    %  decodeJSON - returns the element encoded by a JSON string
    %
    % Element methods (inspection, Static):
    %  getClass - returns the class of the element
    %  getSubclasses - returns all subclasses of an element.
    %  getProps - returns the property list of an element
    %  getPropNumber - returns the property number of an element
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
    % Element methods (GUI):
    %  getPanelProp - returns a prop panel
    %
    % Element methods (GUI, Static):
    %  getGUIMenuImport - returns the basic import menu
    %  getGUIMenuExport - returns the basic export menu
    %
    % Element methods (category, Static):
    %  getCategories - returns the list of categories
    %  getCategoryNumber - returns the number of categories
    %  existsCategory - returns whether a category exists/error
    %  getCategoryTag - returns the tag of a category
    %  getCategoryName - returns the name of a category
    %  getCategoryDescription - returns the description of a category
    %
    % Element methods (format, Static):
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
    % See also Category, Format, NoValue, Callback, ConcreteElement,
    %  IndexedDictionary, handle, matlab.mixin.Copyable.
    %
    % BUILD BRAPH2 7 Element 7
   
	properties (Access=private)
        % props is a private struct containing the element properties whose
        % details depend on the property category (YOCO, YADIR):
        %
        % CONSTANT:
        %  props{prop}.value    - value
        %  props{prop}.seed     - seed for rng
        %  props{prop}.checked 	- true (default) | false
        %  props{prop}.locked   - false (default) | true    NOT USED
        %  props{prop}.callback - empty or Callback()
        %
        % METADATA:
        %  props{prop}.value    - NoValue() or value
        %  props{prop}.seed     - seed for rng
        %  props{prop}.checked 	- true (default) | false
        %  props{prop}.locked   - false (default) | true
        %  props{prop}.callback - empty or Callback()       NOT USED
        %
        % PARAMETER, DATA, FIGURE, GUI:
        %  props{prop}.value    - NoValue() or Callback() or value
        %  props{prop}.seed     - seed for rng
        %  props{prop}.checked  - true (default) | false
        %  props{prop}.locked   - false (default) | true
        %  props{prop}.callback - empty or Callback()
        %
        % RESULT, QUERY, EVANESCENT:
        %  props{prop}.value    - NoValue() or value
        %  props{prop}.seed     - seed for rng
        %  props{prop}.checked  - true (default) | false
        %  props{prop}.locked   - false (default) | true
        %  props{prop}.callback - empty or Callback()
        %
        % The PARAMETER and DATA properties of the element get locked the
        %  first time a RESULT property is successfully calculated.
        % Typically, QUERY should have value NoValue() and EVANESCENT a
        %  concrete value.

        props = {}
    end
    events
        PropSet
        PropMemorized
        PropLocked
    end
    methods (Static) % inspection
        function build = getBuild(el)
            %GETBUILD returns the build of the element.
            %
            % BUILD = Element.GETBUILD() returns the €7€ = 7.
            %
            % Alternative forms to call this method are:
            %  BUILD = EL.GETBUILD() returns the build of EL.
            %  BUILD = Element.BUILD(EL) returns the build of EL.
            %  BUILD = Element.GETBUILD(CLASS) returns the build of CLASS.
            %
            % Note that the Element.BUILD(EL) and Element.BUILD(CLASS) 
            %  are less computationally efficient. 

            % calls from Element
            if nargin == 0
                build = 7;
                return
            end
            
            % calls from subclasses of Element
            build = eval([Element.getClass(el) '.getBuild()']);
        end
        function el_class = getClass(el)
            %GETCLASS returns the class of the element.
            %
            % CLASS = Element.GETCLASS() returns the class 'Element'.
            %
            % Alternative forms to call this method are:
            %  CLASS = EL.GETCLASS() returns the class of EL.
            %  CLASS = Element.GETCLASS(EL) returns the class of EL.
            %  CLASS = Element.GETCLASS(CLASS) returns CLASS.
            %
            % Note that the Element.GETCLASS(EL) and Element.GETCLASS(CLASS) 
            %  are less computationally efficient. 

            % calls from Element
            if nargin == 0
                el_class = 'Element';
                return
            end
            
            % calls from subclasses of Element
            if isa(el, 'Element')
                el_class = class(el);
            else % el should be a string with the element class - otherwise it'll most likely produce some error
                el_class = el;
                % assert( ...
                %     exist(el_class, 'class') == 8, ...
                %     ['BRAPH2' ':Element:' 'WrongInput'], ...
                %     ['BRAPH2' ':Element:' 'WrongInput' ' ' ...
                %     'The value ' tostring(el, 100, '...') ' is not a valid class name.'] ...
                %     )
                %CET
            end
        end
        function subclass_list = getSubclasses(el)
            %GETSUBCLASSES returns all subclasses of Element.
            %
            % LIST = Element.GETSUBCLASSES() returns all subclasses of Element.
            %
            % Alternative forms to call this method are:
            %  LIST = EL.GETSUBCLASSES() returns all subclasses of EL.
            %  LIST = Element.GETSUBCLASSES(EL) returns all subclasses of EL.
            %  LIST = Element.GETSUBCLASSES(CLASS) returns all subclasses of CLASS.
            %
            % Note that the Element.GETSUBCLASSES(EL) and Element.GETSUBCLASSES(CLASS) 
            %  are less computationally efficient. 
            %
            % See also subclasses.
            
            persistent element_subclass_list %CET
            if isempty(element_subclass_list)
                element_subclass_list = subclasses('Element', [], [], true);
            end
            
            % calls from Element
            if nargin == 0 % no arguments
                subclass_list = element_subclass_list; % subclasses('Element', [], [], true); %CET
                return
            elseif strcmp(Element.getClass(el), 'Element')
                subclass_list = element_subclass_list; % subclasses('Element', [], [], true); %CET
                return
            end
            
            % calls from subclasses of Element
            subclass_list = eval([Element.getClass(el) '.getSubclasses()']);
        end
        function prop_list = getProps(el, category)
            %GETPROPS returns the property list of an element.
            %
            % PROPS = Element.GETPROPS() returns the property list of Element
            %  as a row vector.
            %
            % PROPS = Element.GETPROPS(CATEGORY) returns the property list
            %  of category CATEGORY as a row vector.
            %
            % Alternative forms to call this method are:
            %  PROPS = EL.GETPROPS([CATEGORY]) returns the property list of EL.
            %  PROPS = Element.GETPROPS(EL[, CATEGORY]) returns the property list of EL.
            %  PROPS = Element.GETPROPS(CLASS[, CATEGORY]) returns the property list of CLASS.
            %
            % Note that the Element.GETPROPS(EL) and Element.GETPROPS(CLASS) 
            %  are less computationally efficient. 
            %
            % See also getPropNumber, Category.
            
            % calls from Element
            if nargin == 0 % no arguments
                prop_list = [];
                return
            elseif nargin == 1 && isnumeric(el) % el = category argument
                prop_list = [];
                return
            end
            
            % calls from subclasses of Element
            if nargin == 1
                prop_list = eval([Element.getClass(el) '.getProps()']);
            else % nargin == 2
                Category.existsCategory(category);
                
                prop_list = eval([Element.getClass(el) '.getProps(category)']);
            end
        end
        function prop_number = getPropNumber(el, category) %#ok<INUSD>
            %GETPROPNUMBER returns the property number of an element.
            %
            % N = Element.GETPROPNUMBER() returns the number of properties in Element.
            %
            % N = Element.GETPROPNUMBER(CATEGORY) returns the number of properties
            %  of category CATEGORY.
            %
            % Alternative forms to call this method are:
            %  N = EL.GETPROPNUMBER([CATEGORY]) returns the property number of EL.
            %  N = Element.GETPROPNUMBER(EL[, CATEGORY]) returns the property number of EL.
            %  N = Element.GETPROPNUMBER(CLASS[, CATEGORY]) returns the property number of CLASS.
            %
            % Note that the Element.GETPROPNUMBER(EL) and Element.GETPROPNUMBER(CLASS) 
            %  are less computationally efficient. 
            %
            % See also getProps, Category.
            
            % calls from Element
            if nargin == 0
                prop_number = 0;
                return
            elseif nargin == 1 && isnumeric(el) % el = category argument
                prop_number = 0;
                return
            end
            
            % calls from subclasses of Element
            if nargin == 1
                prop_number = eval([Element.getClass(el) '.getPropNumber()']);
            else % nargin == 2
                prop_number = eval([Element.getClass(el) '.getPropNumber(category)']);
            end
        end
        function check_out = existsProp(el, prop)
            %EXISTSPROP checks whether property exists/error.
            %
            % CHECK = Element.EXISTSPROP(PROP) checks whether the property
            %  PROP exists.
            %
            % Alternative forms to call this method are:
            %  CHECK = EL.EXISTSPROP(PROP) checks PROP for EL.
            %  CHECK = Element.EXISTSPROP(EL, PROP) checks PROP for EL.
            %  CHECK = Element.EXISTSPROP(CLASS, PROP) checks PROP for CLASS.
            %
            % Element.EXISTSPROP(PROP) throws an error if the PROP does NOT
            %  exist.
            %  Error id: BRAPH2:Element:WrongInput
            %
            % Alternative forms to call this method are:
            %  EL.EXISTSPROP(PROP) throws error if PROP does NOT exist for EL.
            %   Error id: [BRAPH2:Element:WrongInput]
            %  Element.EXISTSPROP(EL, PROP) throws error if PROP does NOT exist for EL.
            %   Error id: [BRAPH2:CLASS:WrongInput]
            %  Element.EXISTSPROP(CLASS, PROP) throws error if PROP does NOT exist for CLASS.
            %   Error id: [BRAPH2:CLASS:WrongInput]
            %
            % Note that the Element.EXISTSPROP(EL) and Element.EXISTSPROP(CLASS) 
            %  are less computationally efficient. 
            %
            % See also getProps, existsTag.
            
            % calls from Element
            if nargin < 2
                prop = el;
                el = 'Element';
                check = false;
            else % calls from subclasses of Element
                check = eval([Element.getClass(el) '.existsProp(prop)']);
            end
                        
            if nargout == 1
                check_out = check;
            elseif ~check
                error( ...
                    ['BRAPH2' ':' Element.getClass(el) ':' 'WrongInput'], ...
                    ['BRAPH2' ':' Element.getClass(el) ':' 'WrongInput' '\n' ...
                    'The value ' tostring(prop) ' is not a valid prop for ' Element.getClass(el) '.'] ...
                    )
            end
        end
        function check_out = existsTag(el, tag)
            %EXISTSTAG checks whether tag exists/error.
            %
            % CHECK = Element.EXISTSTAG(TAG) checks whether tag TAG exists.
            %
            % Alternative forms to call this method are:
            %  CHECK = EL.EXISTSTAG(TAG) checks tag TAG for EL.
            %  CHECK = Element.EXISTSTAG(EL, TAG) checks tag TAG for EL.
            %  CHECK = Element.EXISTSTAG(CLASS, TAG) checks tag TAG for CLASS.
            %
            % Element.EXISTSTAG(TAG) throws an error if the TAG NOT exist.
            %  Error id: BRAPH2:Element:WrongInput
            %
            % Alternative forms to call this method are:
            %  EL.EXISTSTAG(TAG) throws error if TAG does NOT exist for EL.
            %   Error id: [BRAPH2:Element:WrongInput]
            %  Element.EXISTSTAG(EL, TAG) throws error if TAG does NOT
            %   exist for EL. Error id: BRAPH2:<CLASS>:WrongInput
            %  Element.EXISTSTAG(CLASS, TAG) throws error if TAG does NOT
            %   exist for CLASS. Error id: BRAPH2:<CLASS>:WrongInput
            %
            % Note that the Element.EXISTSTAG(EL) and Element.EXISTSTAG(CLASS) 
            %  are less computationally efficient. 
            %
            % See also getProps, existsProp.
            
            % calls from Element
            if nargin < 2
                tag = el;
                el = 'Element';
                check = false;
            else % calls from subclasses of Element
                check = eval([Element.getClass(el) '.existsTag(tag)']);
            end
            
            if nargout == 1
                check_out = check;
            elseif ~check
                error( ...
                    ['BRAPH2' ':' Element.getClass(el) ':' 'WrongInput'], ...
                    ['BRAPH2' ':' Element.getClass(el) ':' 'WrongInput' '\n' ...
                    'The value ''' tag ''' is not a valid tag for ' Element.getClass(el) '.'] ...
                    )
            end
        end
        function prop_prop = getPropProp(el, pointer) %#ok<INUSD>
            % GETPROPPROP returns the property number of a property.
            %
            % PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the property number
            %  of the property PROP.
            %
            % PROP = Element.GETPROPPROP(TAG) returns the property number of the
            %  property with tag TAG. 
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  PROP = EL.GETPROPPROP(POINTER) returns property number of POINTER of EL.
            %  PROP = Element.GETPROPPROP(EL, POINTER) returns property number of POINTER of EL.
            %  PROP = Element.GETPROPPROP(CLASS, POINTER) returns property number of POINTER of CLASS.
            %
            % Note that the Element.GETPROPPROP(EL) and Element.GETPROPPROP(CLASS) 
            %  are less computationally efficient. 
            %
            % See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
            % getPropSettings, getPropDefault, checkProp.

            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end

            % calls from subclasses of Element
            prop_prop = eval([Element.getClass(el) '.getPropProp(pointer)']);
        end
        function prop_tag = getPropTag(el, pointer) %#ok<INUSD>
            % GETPROPTAG returns the tag of a property.
            %
            % TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the property PROP.
            %
            % TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of the property
            %  with tag TAG. 
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  TAG = EL.GETPROPTAG(POINTER) returns tag of POINTER of EL.
            %  TAG = Element.GETPROPTAG(EL, POINTER) returns tag of POINTER of EL.
            %  TAG = Element.GETPROPTAG(CLASS, POINTER) returns tag of POINTER of CLASS.
            %
            % Note that the Element.GETPROPTAG(EL) and Element.GETPROPTAG(CLASS) 
            %  are less computationally efficient. 
            %
            % See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
            %  getPropDescription, getPropDefault, checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_tag = eval([Element.getClass(el) '.getPropTag(pointer)']);
        end
        function prop_category = getPropCategory(el, pointer) %#ok<INUSD>
            % GETPROPCATEGORY returns the category of a property.
            %
            % CATEGORY = Element.GETPROPCATEGORY(PROP) returns the category of the
            %  property PROP.
            %
            % CATEGORY = Element.GETPROPCATEGORY(TAG) returns the category of the
            %  property with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  CATEGORY = EL.GETPROPCATEGORY(POINTER) returns category of POINTER of EL.
            %  CATEGORY = Element.GETPROPCATEGORY(EL, POINTER) returns category of POINTER of EL.
            %  CATEGORY = Element.GETPROPCATEGORY(CLASS, POINTER) returns category of POINTER of CLASS.
            %
            % Note that the Element.GETPROPCATEGORY(EL) and Element.GETPROPCATEGORY(CLASS) 
            %  are less computationally efficient. 
            %
            % See also Category, getPropProp, getPropTag, getPropSettings,
            %  getPropFormat, getPropDescription, getPropDefault, checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_category = eval([Element.getClass(el) '.getPropCategory(pointer)']);
        end
        function prop_format = getPropFormat(el, pointer) %#ok<INUSD>
            % GETPROPFORMAT returns the format of a property.
            %
            % FORMAT = Element.GETPROPFORMAT(PROP) returns the format of property PROP.
            %
            % FORMAT = Element.GETPROPFORMAT(TAG) returns the format of the property
            %  with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  FORMAT = EL.GETPROPFORMAT(POINTER) returns format of POINTER of EL.
            %  FORMAT = Element.GETPROPFORMAT(EL, POINTER) returns format of POINTER of EL.
            %  FORMAT = Element.GETPROPFORMAT(CLASS, POINTER) returns format of POINTER of CLASS.
            %
            % Note that the Element.GETPROPFORMAT(EL) and Element.GETPROPFORMAT(CLASS) 
            %  are less computationally efficient. 
            %
            % See also Format, getPropProp, getPropTag, getPropCategory,
            %  getPropDescription, getPropSettings, getPropDefault, checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_format = eval([Element.getClass(el) '.getPropFormat(pointer)']);
        end
        function prop_description = getPropDescription(el, pointer) %#ok<INUSD>
            % GETPROPDESCRIPTION returns the description of a property.
            %
            % DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the description of
            %  the property PROP.
            %
            % DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the description of
            %  the property with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  DESCRIPTION = EL.GETPROPDESCRIPTION(POINTER) returns description of POINTER of EL.
            %  DESCRIPTION = Element.GETPROPDESCRIPTION(EL, POINTER) returns description of POINTER of EL.
            %  DESCRIPTION = Element.GETPROPDESCRIPTION(CLASS, POINTER) returns description of POINTER of CLASS.
            %
            % Note that the Element.GETPROPDESCRIPTION(EL) and Element.GETPROPDESCRIPTION(CLASS) 
            %  are less computationally efficient. 
            %
            % See also getPropProp, getPropTag, getPropCategory, getPropFormat,
            %  getPropSettings, getPropDefault, checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_description = eval([Element.getClass(el) '.getPropDescription(pointer)']);
        end
        function prop_settings = getPropSettings(el, pointer) %#ok<INUSD>
            % GETPROPSETTINGS returns the settings of a property.
            %
            % SETTINGS = Element.GETPROPSETTINGS(PROP) returns the settings of the
            %  property PROP.
            %
            % SETTINGS = Element.GETPROPSETTINGS(TAG) returns the settings of the
            %  property with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  SETTINGS = EL.GETPROPSETTINGS(POINTER) returns settings of POINTER of EL.
            %  SETTINGS = Element.GETPROPSETTINGS(EL, POINTER) returns settings of POINTER of EL.
            %  SETTINGS = Element.GETPROPSETTINGS(CLASS, POINTER) returns settings of POINTER of CLASS.
            %
            % Note that the Element.GETPROPSETTINGS(EL) and Element.GETPROPSETTINGS(CLASS) 
            %  are less computationally efficient. 
            %
            % See also getPropProp, getPropTag, getPropCategory, getPropFormat,
            %  getPropDescription, getPropDefault, checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_settings = eval([Element.getClass(el) '.getPropSettings(pointer)']);
        end
        function prop_default = getPropDefault(el, pointer) %#ok<INUSD>
            %GETPROPDEFAULT returns the default value of a property.
            %
            % DEFAULT = Element.GETPROPDEFAULT(PROP) returns the default value of the
            %  property PROP.
            %
            % DEFAULT = Element.GETPROPDEFAULT(TAG) returns the default value of the
            %  property with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  TAG = EL.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EL.
            %  TAG = Element.GETPROPDEFAULT(EL, POINTER) returns the default value of POINTER of EL.
            %  TAG = Element.GETPROPDEFAULT(CLASS, POINTER) returns the default value of POINTER of CLASS.
            %
            % Note that the Element.GETPROPDEFAULT(EL) and Element.GETPROPDEFAULT(CLASS) 
            %  are less computationally efficient. 
            %
            % See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
            %  getPropCategory, getPropFormat, getPropDescription, checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_default = eval([Element.getClass(el) '.getPropDefault(pointer)']);
        end
        function prop_default = getPropDefaultConditioned(el, pointer) %#ok<INUSD>
            %GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
            %
            % DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned
            %  default value of the property PROP.
            %
            % DEFAULT = Element.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned
            %  default value of the property with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  TAG = EL.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EL.
            %  TAG = Element.GETPROPDEFAULTCONDITIONED(EL, POINTER) returns the conditioned default value of POINTER of EL.
            %  TAG = Element.GETPROPDEFAULTCONDITIONED(CLASS, POINTER) returns the conditioned default value of POINTER of CLASS.
            %
            % Note that the Element.GETPROPDEFAULTCONDITIONED(EL) and Element.GETPROPDEFAULTCONDITIONED(CLASS) 
            %  are less computationally efficient. 
            %
            % See also conditioning, getPropDefault, getPropProp, getPropTag,
            %  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
            %  checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_default = eval([Element.getClass(el) '.getPropDefaultConditioned(pointer)']);
        end
    end
    methods (Static) % getNoValue
        function nv = getNoValue()
            %GETNOVALUE returns a pointer to a persistent instance of NoValue.
            %
            % NV = GETNOVALUE() returns a pointer to a persistent instance of NoValue.
            %  For computational efficiency, it is best to use Element.getNoValue(),
            %  instead of creating new instances using the constructor NoValue().

            persistent local_nv

            if isempty(local_nv) || ~isvalid(local_nv)
                local_nv = NoValue();
            end
            nv = local_nv;
        end    
    end
    methods % getCallback
        function cb = getCallback(el, pointer)
            %GETCALLBACK returns the callback to a property.
            %
            % CB = GETCALLBACK(EL, POINTER) returns a callback to the property POINTER
            %  of element EL. POINTER can be either a property number (PROP) or tag (TAG).
            %  The property cannot be METADATA.
            %
            % See also Callback.
            
            prop = el.getPropProp(pointer);
            
            if ~isa(el.props{prop}.callback, 'Callback')
                cb = Callback('EL', el, 'PROP', prop);
                cb.props{1}.locked = true;
                cb.props{2}.locked = true;
                cb.props{3}.locked = true;
                el.props{prop}.callback = cb;
            end
            
            cb = el.props{prop}.callback;
        end
    end
    methods % constructor
        function el = Element(varargin)
            %ELEMENT() creates an Element.
            %
            % ELEMENT(PROP, VALUE, ...) with property PROP initialized to VALUE.
            %
            % ELEMENT(TAG, VALUE, ...) with property with tag TAG set to VALUE.
            %
            % Multiple properties can be initialized at once identifying them with
            %  either property numbers (PROP) or tags (TAG).
            % 
            % The random number generator shuffle [rng('shuffle', 'twister')] should be
            %  done before creating the element to ensure reproducibility of the 
            %  random numbers.  
            %
            % See also Category, Format, set, check.

            % Undocumented trick to avoid inizialization of props by having a single
            % value ('_VOID_') in the varargin (e.g. when deep-copying)
            if length(varargin) == 1 && isequal(varargin{1}, '_VOID_')
                return
            end
            
            for prop = 1:1:el.getPropNumber()
                el.props{prop}.value = Element.getNoValue();
                el.props{prop}.seed = randi(intmax('uint32'));
                el.props{prop}.checked = true;
                el.props{prop}.locked = false;
                el.props{prop}.callback = [];
            end

            el.set(varargin{:})
        end
    end
    methods % set/check/get/lock
        function el_out = set(el, varargin)
            %SET sets some values of a property.
            %
            % SET(EL, POINTER1, VALUE1, POINTER2, VALUE2, ...) sets the value of
            %  POINTER1 to VALUE1, POINTER2 to VALUE2, ... where the pointers can be
            %  either property numbers or property tags.
            %
            % Each value is:
            %  1.   <strong>CONDITIONED</strong> before being set (by calling the protected static 
            %       function <a href="matlab:help Element.conditioning">conditioning</a>, which is defined in each subelement).
            %  2.   <strong>PRESET</strong> before being set (by calling the protected function <a
            %       href="matlab:help Element.preset">preset</a>, 
            %       which is defined in each subelement).
            %  3.   If a property is checked, it is <strong>FORMAT CHECKED</strong> before proceeding
            %       to its setting by calling <a href="matlab:help Format.checkFormat">Format.checkFormat</a>. 
            %       If the check fails, the property is not set and an error is thrown.
            %       Error id: BRAPH2:<Element Class>:WrongInput
            %  4.   <strong>SET</strong>
            %           If the property is of category PARAMETER, DATA, FIGURE, or GUI,
            %            the value is set only if the property is unlocked. If an
            %            attempt is made to set a locked property, no setting occurs
            %            and a warning is thrown.
            %            Warning id: BRAPH2:<Element Class>
            %
            %           If the value is a Callback, a warning is thrown if the element,
            %            property number and/or settings of the callback do not
            %            coincide with those of the property.
            %            Warning id: BRAPH2:<Element Class>
            %
            %           If the property is of category RESULT, QUERY or EVANESCENT, the
            %            value can only be set to Element.getNoValue().
            %
            %  5.   <strong>POSTSET</strong> after being set (by calling the protected function <a
            %       href="matlab:help Element.postset">postset</a>, 
            %       which is defined in each subelement).
            %  6.   ALL properties are <strong>POSTPROCESSED</strong> after being set (by calling the
            %       protected function <a href="matlab:help Element.postprocessing">postprocessing</a>, which is defined in each subelement).
            %  7.   If ANY property is checked, the method Element.check() is called
            %       after all settings are made and the consistency of the values of
            %       all properties is <strong>CHECKED</strong>. If the check fails an error is thrown.
            %       Error id: BRAPH2:<Element Class>:WrongInput
            %
            % Note that, when BRAPH2.CHECKED = false, no checks are performed.
            %
            % EL = SET(EL, POINTER1, VALUE1, ...) returns the element.
            %
            % When some properties are successfully set, an <strong>event PropSet</strong> is notified.
            %
            % See also get, getr, memorize, check, isChecked, checked, unchecked,
            %  isLocked, lock, NoValue, Callback, EventPropSet.

            % backup properties (if any prop is checked)
            checked = BRAPH2.CHECKED && el.getPropNumber() && any(cellfun(@(x) x.checked, el.props));
            if checked
                props_backup = el.props; % props backup
            end

            % set
            for i = 1:2:length(varargin)
                prop = el.getPropProp(varargin{i});
                Element.existsProp(el, prop)
                
                value = varargin{i+1};
                
                switch el.getPropCategory(prop)
                    case 2 % Category.METADATA
                        value = el.conditioning(prop, value);
                        
                        value = el.preset(prop, value);
                        
                        if BRAPH2.CHECKED && el.props{prop}.checked % el.isChecked(prop) %CET
                            el.checkProp(prop, value) % check value format
                        end

                        el.props{prop}.value = value;

                        el.postset(prop); 
                        
                    case {3 4 8 9} % {Category.PARAMETER Category.DATA Category.FIGURE Category.GUI}
                        if ~el.isLocked(prop)
                            if isa(value, 'Callback')
                                if el.getPropFormat(prop) ~= value.get('EL').getPropFormat(value.get('PROP'))
                                    warning( ...
                                        ['BRAPH2' ':' class(el)], ...
                                        ['BRAPH2' ':' class(el) '\n' ...
                                        'Different formats for prop ' class(el) '.' el.getPropTag(prop) ' (' Format.getFormatName(el.getPropFormat(prop)) ') ' ...
                                        'and its callback (' Format.getFormatName(value.get('EL').getPropFormat(value.get('PROP'))) '). ' ...
                                        'This is not necessarily a problem.'] ...
                                        )
                                elseif ~isequal(el.getPropSettings(prop), value.get('EL').getPropSettings(value.get('PROP')))
                                    warning( ...
                                        ['BRAPH2' ':' class(el)], ...
                                        ['BRAPH2' ':' class(el) '\n' ...
                                        'Different format settings for prop ' class(el) '.' el.getPropTag(prop) ' (' Format.getFormatName(el.getPropFormat(prop)) ', ' tostring(el.getPropSettings(prop)) ') ' ...
                                        'and its callback (' Format.getFormatName(value.get('EL').getPropFormat(value.get('PROP'))) ', ' tostring(value.get('EL').getPropSettings(value.get('PROP'))) '). ' ...
                                        'This is not necessarily a problem.'] ...
                                        )                                
                                end

                                el.props{prop}.value = value;
                            else
                                value = el.conditioning(prop, value);
                                
                                value = el.preset(prop, value);

                                if BRAPH2.CHECKED && el.props{prop}.checked % el.isChecked(prop) %CET
                                    el.checkProp(prop, value) % check value format
                                end

                                el.props{prop}.value = value;
                                
                                el.postset(prop);
                            end
                        else
                            warning( ...
                                ['BRAPH2' ':' class(el)], ...
                                ['BRAPH2' ':' class(el) '\n' ... 
                                'Attempt to set the values of a LOCKED property (' el.getPropTag(prop) '), which was obviously not done.\n' ...
                                'Hopefully this won''t create problems, but your code shouldn''t let this happen!'] ...
                                )                            
                        end

                    case {5 6 7} % {Category.RESULT Category.QUERY Category.EVANESCENT}
                        if isa(value, 'NoValue')
                            el.props{prop}.value = Element.getNoValue();
                        else
                            warning( ...
                                ['BRAPH2' ':' class(el)], ...
                                ['BRAPH2' ':' class(el) '\n' ...
                                'Rightfully unsuccessful attempt to set a ' Category.getCategoryName(el.getPropCategory(prop)) ...
                                ' property (' el.getPropTag(prop) ') to a value.\n' ...
                                'Probably not a problem, but shouldn''t happen with well-written code!'] ...
                                )
                        end
                    case 1 % Category.CONSTANT
                        if isa(value, 'NoValue')
                            el.props{prop}.value = Element.getNoValue();
                        else
                            warning( ...
                                ['BRAPH2' ':' class(el)], ...
                                ['BRAPH2' ':' class(el) '\n' ...
                                'Rightfully unsuccessful attempt to set a ' Category.getCategoryName(1) ...
                                ' property (' el.getPropTag(prop) ') to a value.\n' ...
                                'Probably not a problem, but shouldn''t happen with well-written code!'] ...
                                )
                        end
                end
            end

            for prop = el.getProps()
                el.postprocessing(prop)
            end

            % check values and restore (if any prop is checked)
            if checked
                [check, msg] = el.check();
                if ~check
                    el.props = props_backup; % restore props backup
                    error( ...
                        ['BRAPH2' ':' class(el) ':' 'WrongInput'], ...
                        ['BRAPH2' ':' class(el) ':' 'WrongInput' '\n' ...
                        msg '\n' ...
                        'The value of this ' class(el) ' has been restored, \n' ...
                        'so you can keep on working if you are using command line. \n' ...
                        'Nevertheless, there might be problems, so better you check your code!'] ...
                        )
                end
            end

            % notify event prop set
            if ~checked || (checked && check)
                notify(el, 'PropSet', EventPropSet(el, varargin{1:2:end}))
            end

            % output
            if nargout > 0
                el_out = el;
            end
        end
        function [element_check, element_msg] = check(el)
            %CHECK checks the values of all properties.
            %
            % [PASS, MSG] = CHECK(EL) checks the values of all properties of element
            %  EL. It returns a flag PASS (true = passed check; false = failed check)
            %  and a message MSG. The check is performed by calling the protected
            %  function <a href="matlab:help Element.checkValue">checkValue</a>, which is defined in each subclass. By default
            %  checkValue does not make any check.
            %
            % CHECK(EL) checks the values of all properties of element EL and thorws an
            %  error if the check fails.
            %  Error id: BRAPH2:<Element Class>:ErrorFunc
            %
            % See also isChecked, checked, unchecked, set, get, getr, memorize.

            value_checks = ones(el.getPropNumber(), true);
            value_msgs = repmat({''}, el.getPropNumber(), 1);
            for prop = 1:1:el.getPropNumber()
                if el.isChecked(prop)
                    value = el.getr(prop);
                    switch el.getPropCategory(prop)
                        case 2 % Category.METADATA
                            if ~isa(value, 'NoValue')
                                [value_check, value_msg] = el.checkValue(prop, value);
                            else % NoValue
                                value_check = true;
                                value_msg = '';
                            end

                        case {3 4 8 9} % {Category.PARAMETER Category.DATA Category.FIGURE Category.GUI}
                            while isa(value, 'Callback')
                                value = value.get('EL').get(value.get('PROP'));
                            end
                            if ~isa(value, 'NoValue')
                                [value_check, value_msg] = el.checkValue(prop, value);
                            else % NoValue
                                value_check = true;
                                value_msg = '';
                            end

                        case {5 6 7} % {Category.RESULT Category.QUERY Category.EVANESCENT}
                            if ~isa(value, 'NoValue')
                                [value_check, value_msg] = el.checkValue(prop, value);
                            else % NoValue
                                value_check = true;
                                value_msg = '';
                            end
                            
                        case 1 % Category.CONSTANT
                            value_check = true;
                            value_msg = '';
                    end
                    value_checks(prop) = value_check;
                    if ~value_check
                        value_msgs{prop} = value_msg;
                    end
                end
            end
            check = all(value_checks);
            msg = join(value_msgs);
            msg = strtrim(msg{1});

            if nargout >= 1
                element_check = check;
                element_msg = msg;
            elseif ~check
                error( ...
                    ['BRAPH2' ':' el.getClass() ':' 'ErrorFunc'], ...
                    ['BRAPH2' ':' el.getClass() ':' 'ErrorFunc' '\n' ...
                    msg] ...
                    )
            end
        end        
        function value = getr(el, pointer)
            %GETR returns the raw value of a property.
            %
            % VALUE = GETR(EL, POINTER) returns the raw value of property POINTER of
            %  element EL. POINTER can be either a property number (PROP) or tag (TAG).
            %
            % See also get, memorize, set, check.

            prop = el.getPropProp(pointer);
            
            value = el.props{prop}.value; % raw element value
        end
        function value_out = get(el, pointer, varargin)
            %GET returns the value of a property.
            %
            % VALUE = GET(EL, POINTER) returns the value of property POINTER of element
            %  EL. POINTER can be either a property number (PROP) or tag (TAG).
            %
            % If the raw value of the property is a NoValue, it proceeds to return the
            %  default property value (for categories METADATA, PARAMETER, DATA,
            %  FIGURE, and GUI).
            %
            % If the raw value of the property is a Callback, it retrieves the value of
            %  the linked property (for categories PARAMETER, DATA, FIGURE, and GUI).
            %
            % If a property of category RESULT, QUERY, or EVANESCENT is not calculated
            %  (i.e., its raw value is NoValue), it proceeds to calculate it (but NOT
            %  memorize it). After the calculation of a property of category RESULT all
            %  properties of categories PARAMETER and DATA are irreversibly locked.
            % If the property is checked, it proceeds to check all properties
            %  after the calculation calling the function <a href="matlab:help Element.check">check</a>.
            %  If the check fails, it resets the property to NoValue and returns NoValue,
            %  does not lock the property, and throws a warning.
            %  Warning id: BRAPH2:<Element Class>
            %
            % VALUE = GET(EL, QUERY, VARARGIN) can be used with VARARGIN for properties
            %  of category QUERY. VARARGIN will be ignored for properties of other
            %  categories.
            %
            % GET(EL, POINTER) does not return any output value.
            %
            % See also getr, memorize, set, check, NoValue, Callback, getPropDefault,
            %  lock.

            prop = el.getPropProp(pointer);

            value = el.getr(prop);

            switch el.getPropCategory(prop)
                case 1 % Category.CONSTANT
                    if isa(value, 'NoValue')
                        value = el.getPropDefaultConditioned(prop);
                    end
                    
                case 2 % Category.METADATA
                    if isa(value, 'NoValue')
                        value = el.getPropDefaultConditioned(prop);
                    end

                case {3 4 8 9} % {Category.PARAMETER Category.DATA Category.FIGURE Category.GUI}
                    if isa(value, 'NoValue')
                        value = el.getPropDefaultConditioned(prop);
                    elseif isa(value, 'Callback')
                        value = value.get('EL').get(value.get('PROP'));
                    end

                case 5 % Category.RESULT
                    if isa(value, 'NoValue')

                        % backup properties (if prop is checked)
                        if BRAPH2.CHECKED && el.isChecked(prop)
                            props_backup = el.props; % props backup
                        end                        

                        value = el.calculateValue(prop);

                        if ~BRAPH2.CHECKED || ~el.isChecked(prop)
                            el.lock()
                        else
                            % check values and restore (if prop is checked)
                            el.props{prop}.value = value; % temporality memorize value for the check
                            [check, msg] = el.check();
                            el.props{prop}.value = Element.getNoValue(); % restores the original NoValue
                            if check
                                el.lock()
                            else
                                el.props = props_backup; % restore props backup
                                value = el.props{prop}.value; % value is also set to the original NoValue()
                                warning( ...
                                    ['BRAPH2' ':' class(el)], ...
                                    ['BRAPH2' ':' class(el) '\n' ...
                                    msg '\n' ...
                                    'The value of this ' class(el) ' has been restored,\n' ...
                                    'but there might be problems, so better you check your code!'] ...
                                    )
                            end
                        end
                    end
                    
                case 6 % Category.QUERY
                    if isa(value, 'NoValue')

                        % backup properties (if prop is checked)
                        if BRAPH2.CHECKED && el.isChecked(prop)
                            props_backup = el.props; % props backup
                        end                        

                        value = el.calculateValue(prop, varargin{:});

                        if BRAPH2.CHECKED && el.isChecked(prop)
                            % check values and restore (if prop is checked)
                            el.props{prop}.value = value; % temporality memorize value for the check
                            [check, msg] = el.check();
                            el.props{prop}.value = Element.getNoValue(); % restores the original NoValue
                            if ~check
                                el.props = props_backup; % restore props backup
                                value = el.props{prop}.value; % value is also set to the original NoValue()
                                warning( ...
                                    ['BRAPH2' ':' class(el)], ...
                                    ['BRAPH2' ':' class(el) '\n' ...
                                    msg '\n' ...
                                    'The value of this ' class(el) ' has been restored,\n' ...
                                    'but there might be problems, so better you check your code!'] ...
                                    )
                            end
                        end
                        
                        if el.getPropCategory(prop) == 7
                            warning( ...
                                ['BRAPH2' ':' class(el)], ...
                                ['BRAPH2' ':' class(el) '\n' ...
                                'The EVANESCENT property ' el.getPropTag(pointer) ' has NOT been memorized.\n' ...
                                'While not necessarily an error, EVANESCENT properties are generally supposed to be memorized at first use.\n' ...
                                'If this behavior is intended, consider enclosing the command between warning off and warning on.'] ...
                                )
                        end
                    end
                    
                case 7 % Category.EVANESCENT
                    if isa(value, 'NoValue')

                        % backup properties (if prop is checked)
                        if BRAPH2.CHECKED && el.isChecked(prop)
                            props_backup = el.props; % props backup
                        end                        

                        value = el.calculateValue(prop);

                        if BRAPH2.CHECKED && el.isChecked(prop)
                            % check values and restore (if prop is checked)
                            el.props{prop}.value = value; % temporality memorize value for the check
                            [check, msg] = el.check();
                            el.props{prop}.value = Element.getNoValue(); % restores the original NoValue
                            if ~check
                                el.props = props_backup; % restore props backup
                                value = el.props{prop}.value; % value is also set to the original NoValue()
                                warning( ...
                                    ['BRAPH2' ':' class(el)], ...
                                    ['BRAPH2' ':' class(el) '\n' ...
                                    msg '\n' ...
                                    'The value of this ' class(el) ' has been restored,\n' ...
                                    'but there might be problems, so better you check your code!'] ...
                                    )
                            end
                        end
                        
                        if el.getPropCategory(prop) == 7
                            warning( ...
                                ['BRAPH2' ':' class(el)], ...
                                ['BRAPH2' ':' class(el) '\n' ...
                                'The EVANESCENT property ' el.getPropTag(pointer) ' has NOT been memorized.\n' ...
                                'While not necessarily an error, EVANESCENT properties are generally supposed to be memorized at first use.\n' ...
                                'If this behavior is intended, consider enclosing the command between warning off and warning on.'] ...
                                )
                        end
                    end
            end
            
            if nargout == 1
                value_out = value;
            end
        end
        function value_out = memorize(el, pointer)
            %MEMORIZE returns and memorizes the value of a property.
            %
            % VALUE = MEMORIZE(EL, POINTER) returns and memorize the value of property POINTER of
            %  element EL. POINTER can be either a property number (PROP) or tag (TAG).
            % 
            % It calls the function <a href="matlab:help Element.check">check</a> and proceed to save the result,
            %  if the property is of category RESULT, QUERY, or EVANESCENT.
            %
            % If the property is NOT of category RESULT, QUERY, or EVANESCENT and has
            %  not been set yet, it sets it to its default value.
            %
            % If the property is NOT of category RESULT, QUERY, or EVANESCENT and is a
            %  Callback, it iteratively memorizes the property of the element in the
            %  Callback.
            %
            % If a property of category QUERY is memorized, a warning is thrown. 
            %  Warning id: BRAPH2:<Element Class>
            % QUERY properties are generally not supposed to be memorized. If such
            %  behavior is intended, consider enclosing the command between warning off
            %  and warning on.
            % 
            % MEMORIZE(EL, POINTER) does not return any output value.
            %
            % When a property of categories RESULT, QUERY or EVANESCENT is memorized,
            %  an <strong>event PropMemorized</strong> is notified.
            %
            % See also get, getr, set, check, Callback, EventPropMemorized.

            prop = el.getPropProp(pointer);

            if isa(el.props{prop}.value, 'Callback')
                cb = el.props{prop}.value;
                value = cb.get('EL').memorize(cb.get('PROP'));
            else
                if isa(el.props{prop}.value, 'NoValue')
                    switch el.getPropCategory(prop)
                        case 5 % Category.RESULT
                            % calculates the value
                            el.props{prop}.value = el.get(prop);
                            
                            % notify event result memorized
                            notify(el, 'PropMemorized', EventPropMemorized(el, prop))
                            
                        case 6 % Category.QUERY
                            % calculates the value
                            el.props{prop}.value = el.get(prop);
                            
                            % notify event query memorized
                            notify(el, 'PropMemorized', EventPropMemorized(el, prop))
                            
                            warning( ...
                                ['BRAPH2' ':' class(el)], ...
                                ['BRAPH2' ':' class(el) '\n' ...
                                'The QUERY property ' el.getPropTag(prop) ' has been memorized.\n' ...
                                'While not necessarily an error, QUERY properties are generally not supposed to be memorized.\n' ...
                                'If this behavior is intended, consider enclosing the command between warning off and warning on.'] ...
                                )
                            
                        case 7 % Category.EVANESCENT
                            % calculates the value
                            backup_warning_state = warning('off', ['BRAPH2' ':' class(el)]); % to avoid the warning when memorizing an EVANESCENT property
                            el.props{prop}.value = el.get(prop);
                            warning(backup_warning_state)
                            
                            % notify event evanescent memorized
                            notify(el, 'PropMemorized', EventPropMemorized(el, prop))
                            
                        case {2 3 4 8 9} % {Category.METADATA Category.PARAMETER Category.DATA Category.FIGURE Category.GUI}
                            % sets the value
                            el.set(prop, el.getPropDefault(prop))
                            
                        case 1 % Category.CONSTANT
                            % retrieves the conitioned default value
                            el.props{prop}.value = el.getPropDefaultConditioned(prop);
                    end
                end
                
                value = el.props{prop}.value;
            end
            
            if nargout == 1
                value_out = value;
            end
        end
        function seed = getPropSeed(el, pointer)
            %GETPROPSEED returns the seed of a property.
            %
            % SEED = GETPROPSEED(EL, POINTER) returns the seed of property POINTER of
            %  element EL. POINTER can be either a property number (PROP) or tag (TAG).
            %
            % The seed of each property is a 32-bit unsigned integer and is initialized
            %  when an element is constructed by calling randi(intmax('uint32')).
            % 
            % See also randi.

            prop = el.getPropProp(pointer);

            seed = el.props{prop}.seed;
        end
        function locked = isLocked(el, pointer)
            %ISLOCKED returns whether a property is locked.
            %
            % LOCKED = ISLOCKED(EL, POINTER) returns whether the property POINTER of
            %  element EL is locked. POINTER can be either a property number (PROP) or
            %  tag (TAG).
            %
            % Properties can be locked by the user using the function <a href="matalb:help Element.lock">lock</a>.
            % Only properties of category PARAMETER, DATA, FIGURE, and GUI can be locked.
            % All properties with category PARAMETER and DATA are
            %  automatically locked as soon as the first result is calculated.
            %  Afterwards they cannot be unlocked. 
            %
            % See also lock.

            prop = el.getPropProp(pointer);

            locked = el.props{prop}.locked;
        end
        function el_out = lock(el, pointer, varargin)
            %LOCK locks irreversibly a property.
            %
            % LOCK(EL) locks irreversibly all properties of category PARAMETER or
            %  DATA of element EL. 
            %
            % LOCK(EL, POINTER) locks irreversibly the property POINTER of element EL.
            %  POINTER can be either a property number (PROP) or tag (TAG).
            %  It only locks properties of category PARAMETER, DATA, FIGURE, and GUI 
            % If an attempt is made to lock a property of another category, no locking
            %  occurs and a warning is thrown. 
            %  Warning id: BRAPH2:<Element Class>
            %
            % LOCK(EL, POINTER, 'Iterative', false) only locks the property but does not
            %  iteratively lock the corresponding element(s) (if ITEM, ITEMLIST, or
            %  IDICT) 
            %
            % EL = LOCK(EL[, POINTER]) returns the element.
            %
            % When a property is locked, an <strong>event PropLocked</strong> is notified.
            % 
            % See also isLocked, EventPropLocked.

            if nargin < 2
                for prop = [el.getProps(3) el.getProps(4)]
                    el.lock(prop)
                end
            else
                prop = el.getPropProp(pointer);
                
                if any(el.getPropCategory(prop) == [3 4 8 9])
                    if ~el.isLocked(prop)
                        el.props{prop}.locked = true;

                        if get_from_varargin(true, 'Iterative', varargin)
                            value = el.getr(prop);
                            if isa(value, 'Element')
                                value.lock();
                            elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
                                cellfun(@(x) x.lock(), value)
                            end
                        end
                        
                        % notify event prop locked
                        notify(el, 'PropLocked', EventPropLocked(el, prop))
                    end
                else
                    warning( ...
                        ['BRAPH2' ':' class(el)], ...
                        ['BRAPH2' ':' class(el) '\n' ...
                        'Rightfully unsuccessful attempt to lock a ' Category.getCategoryName(el.getPropCategory(pointer)) ...
                        ' property (' el.getPropTag(pointer) ').\n' ...
                        'Probably not a problem, but shouldn''t happen with well-written code!'] ...
                        )
                end
            end
            
            if nargout == 1
                el_out = el;
            end
        end
        function checked = isChecked(el, pointer)
            %ISCHECKED returns whether a property is checked.
            %
            % CHECKED = ISCHECKED(EL, POINTER) returns whether the property POINTER of
            %  element EL is checked. POINTER can be either a property number (PROP) or
            %  tag (TAG).
            %
            % Checked properties are checked:
            %  1. for format when they are set (<a href="matalb:help Element.set">set</a>).
            %  2. for value when they are set/calculated (<a href="matalb:help Element.get">get</a>).
            %
            % Note that, when BRAPH2.CHECKED = false, no checks are performed.
            %
            % See also checked, unchecked, BRAPH2.

            prop = el.getPropProp(pointer);

            checked = el.props{prop}.checked;
        end
        function checked(el, pointer)
            %CHECKED sets a property to checked.
            %
            % CHECKED(EL) sets all properties of element EL to checked.
            %
            % CHECKED(EL, POINTER) sets the property POINTER of element EL to checked.
            %  POINTER can be either a property number (PROP) or tag (TAG).
            %
            % See also unchecked, isChecked.

            if nargin < 2
                for prop = 1:1:el.getPropNumber()
                    el.checked(prop)
                end
            else
                if ~el.isChecked(pointer) % This condition is for computational efficiency 
                    prop = el.getPropProp(pointer);

                    el.props{prop}.checked = true;

                    value = el.getr(prop);
                    if isa(value, 'Element')
                        value.checked();
                    elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
                        cellfun(@(x) x.checked(), value)
                    end
                end
            end
        end
        function unchecked(el, pointer)
            %UNCHECKED sets a property to NOT checked.
            %
            % UNCHECKED(EL) sets all properties of element EL to NOT checked.
            %
            % UNCHECKED(EL, POINTER) sets the property POINTER of element EL to NOT checked.
            %  POINTER can be either a property number (PROP) or tag (TAG).
            %
            % See also checked, isChecked.

            if nargin < 2
                for prop = 1:1:el.getPropNumber()
                    el.unchecked(prop)
                end
            else
                if el.isChecked(pointer) % This condition is for computational efficiency 
                    prop = el.getPropProp(pointer);

                    el.props{prop}.checked = false;

                    value = el.getr(prop);
                    if isa(value, 'Element')
                        value.unchecked();
                    elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
                        cellfun(@(x) x.unchecked(), value)
                    end
                end
            end
        end     
    end
    methods (Static, Access=protected) % conditioning
        function value = conditioning(el, prop, value) %#ok<INUSL>
            %CONDITIONING conditions a value before setting a property.
            %
            % VALUE = CONDITIONING(EL, PROP, VALUE) conditions the value VALUE before
            %  it is set as the value of the property PROP. 
            %  By default, this function does not do anything, so it should be
            %  implemented in the subclasses of Element when needed.
            %
            % Conditioning is only used for props of category METADATA,
            %  PARAMETER, DATA, FIGURE, and GUI.
            %
            % See also preset, checkProp, postset, postprocessing, calculateValue,
            %  checkValue.
            
            % calls from Element
            if nargin < 3
                % value = pointer;
                % pointer = el; %#ok<NASGU>
                % el = 'Element'; %#ok<NASGU>
                return
            end
            
            % calls from subclasses of Element
            value = eval([Element.getClass(el) '.conditioning(prop, value)']);
        end
    end
    methods (Access=protected) % preset
        function value = preset(el, prop, value) %#ok<INUSL>
            %PRESET preprocesses the value of a property before setting it.
            %
            % VALUE = PRESET(EL, PROP, VALUE) preprocesses the VALUE of the property
            %  PROP. It works only with properties with category METADATA,
            %  PARAMETER, DATA, FIGURE and GUI. By default, this function does not do 
            %  anything, so it should be implemented in the subclasses of Element when
            %  needed.
            %
            % See also conditioning, checkProp, postset, postprocessing,
            %  calculateValue, checkValue. 
        end
    end  
    methods (Static) % checkProp
        function prop_check = checkProp(el, pointer, value) %#ok<INUSD>
            %CHECKPROP checks whether a value has the correct format/error.
            %
            % CHECK = Element.CHECKPROP(POINTER, VALUE) checks whether VALUE is an
            %  acceptable value for the format of the property POINTER (POINTER = PROP
            %  or TAG).
            %
            % Alternative forms to call this method are:
            %  CHECK = EL.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of EL.
            %  CHECK = Element.CHECKPROP(EL, PROP, VALUE) checks VALUE format for PROP of EL.
            %  CHECK = Element.CHECKPROP(CLASS, PROP, VALUE) checks VALUE format for PROP of CLASS.
            %
            % Element.CHECKPROP(POINTER, VALUE) throws an error if VALUE is NOT an
            %  acceptable value for the format of the property POINTER.
            %   Error id: [BRAPH2:Element:WrongInput]
            %
            % Alternative forms to call this method are:
            %  EL.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EL.
            %   Error id: [BRAPH2:Element:WrongInput]
            %  Element.CHECKPROP(EL, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EL.
            %   Error id: [BRAPH2:CLASS:WrongInput]
            %  Element.CHECKPROP(CLASS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CLASS.
            %   Error id: [BRAPH2:CLASS:WrongInput]
            %
            % Note that the Element.CHECKPROP(EL) and Element.CHECKPROP(CLASS) 
            %  are less computationally efficient. 
            %
            % See also Format, getPropProp, getPropTag, getPropSettings,
            %  getPropCategory, getPropFormat, getPropDescription, getPropDefault.
            
            if nargout == 1
                prop_check = eval([Element.getClass(el) '.checkProp(pointer, value)']);
            else
                eval([Element.getClass(el) '.checkProp(pointer, value)']);
            end
        end
    end
    methods (Access=protected) % postset
        function postset(el, prop) %#ok<INUSD>
            %POSTSET postprocessing after a prop has been set.
            %
            % POSTSET(EL, PROP) postprocessing after PROP has been set. By default, 
            %  this function does not do anything, so it should be implemented
            %  in the subclasses of Element when needed.
            %
            % This postprocessing occurs only when PROP is set.
            %
            % See also conditioning, preset, checkProp, postprocessing, calculateValue,
            %  checkValue.
        end
    end
    methods (Access=protected) % postprocessing
        function postprocessing(el, prop)   %#ok<INUSD>
            %POSTPROCESSING postprocessesing after setting.
            %
            % POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By
            %  default, this function does not do anything, so it should be implemented
            %  in the subclasses of Element when needed.
            %
            % The postprocessing of all properties occurs each time set is called.
            %
            % See also conditioning, preset, checkProp, postset, calculateValue,
            %  checkValue.
        end
    end
    methods (Access=protected) % calculate value
        function value = calculateValue(el, prop)
            %CALCULATEVALUE calculates the value of a property.
            %
            % VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
            %  PROP. It works only with properties with category RESULT,
            %  QUERY, and EVANESCENT. By default this function returns the default
            %  value for the prop and should be implemented in the subclasses of
            %  Element when needed.
            %
            % VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
            %  QUERY.
            %
            % See also getPropDefaultConditioned, conditioning, preset, checkProp,
            %  postset, postprocessing, checkValue.

            value = el.getPropDefaultConditioned(prop);
        end
    end    
    methods (Access=protected) % check value
        function [value_check, value_msg] = checkValue(el, prop, value) %#ok<INUSD>
            %CHECKVALUE checks the value of a property after it is set/calculated.
            %
            % [CHECK, MSG] = CONDITCHECKVALUEIONING(EL, PROP, VALUE) checks the value
            %  of the property PROP after it is set/calculated. This function by
            %  default returns a CHECK = true and MSG = ''. It should be implemented in
            %  the subclasses of Element when needed.
            %
            % See also conditioning, preset, checkProp, postset, postprocessing,
            %  calculateValue.

            value_check = true;
            value_msg = '';
        end
    end
    methods % display
        function str = tostring(el, varargin)
            %TOSTRING string with information about the element.
            %
            % STR = TOSTRING(EL) returns a string with information about the element.
            %
            % STR = TOSTRING(EL, N) trims the string to the first N characters.
            %
            % STR = TOSTRING(EL, N, ENDING) ends the string with ENDING if it has
            %  been trimmed.
            %
            % See also disp, tree.

            if isa(el, 'IndexedDictionary')
                str = [class(el) ' with ' int2str(el.get('LENGTH')) ' ' el.get('IT_CLASS')];
            elseif isa(el, 'ConcreteElement')
                str = [class(el) '(' el.get('ID') ')'];
            elseif isa(el, 'NoValue')
                str = '__';
            elseif isa(el, 'Callback')
                str = ['@' tostring(el.get('EL')) '.' el.get('TAG') '(' tostring(el.get('PROP')) ')' ];
            elseif isa(el, 'Element')
                str = 'Element';
            end
            
            str = tostring(str, varargin{:});
            str = str(2:1:end-1);
        end
        function disp(el)
            % DISP displays information about the element.
            %
            % DISP(EL) displays information about the element.
            %
            % See also tostring, tree.

            disp(['<a href="matlab:help ' class(el) '">' class(el) '</a>']);
            el.tree()
        end
        function txt_output = tree(el, level, prop_list, n, ending)
            %TREE displays the element tree.
            %
            % TREE(EL) displays the first level of the element tree.
            %
            % TREE(EL, LEVEL) displays a number LEVEL of the levels of the element tree.
            %
            % TREE(EL, [], PROPS) displays only PROPS at the first level.
            %
            % TREE(EL, [], [], N[, ENDING]) trims the string of each property to the
            %  first N characters and, optionally, ends the string with ENDING if it
            %  has been trimmed.
            %
            % STR = TREE(EL) returns the element tree as a string.
            %
            % See also tostring, tree.  
                        
            if nargin < 5
                ending = ' ...';
            end

            if nargin < 4 || isempty(n)
                n = 100;
            end

            if nargin < 3 || isempty(prop_list)
                prop_list = 1:1:el.getPropNumber();
            end
            
            if nargin < 2 || isempty(level)
                level = 0;
            end
            
            txt_el = sprintf(['<strong>' class(el) '</strong>\n']);
            
            for prop = prop_list
                category = Category.getCategoryTag(el.getPropCategory(prop));
                format = Format.getFormatTag(el.getPropFormat(prop));
                value = el.getr(prop);
                
                % \ -> \\
                if ischar(value) && contains(value, '\')
                    value = insertAfter(value, '\', '\');                    
                end
                
                if el.isLocked(prop)
                    txt_locked = ['<strong>' char(254) '</strong>'];
                else
                    txt_locked = ' ';
                end
                
                if el.isChecked(prop)
                    txt_checked = ['<strong>' char(391) '</strong> '];
                else
                    txt_checked = '  ';
                end
                
                txt_el = [txt_el ...
                    sprintf([ ...
                    int2str(prop) ' ' ...
                    category ' ' ...
                    format ...
                    '\t' pad(el.getPropTag(prop), 20) ...
                    txt_locked txt_checked ...
                    '\t' pad(int2str(el.getPropSeed(prop)), 12) ...
                    tostring(value, n, ending) ...
                    '\n'])]; %#ok<AGROW>
                
                if level > 0
                    if isa(value, 'Callback')
                        cb = value;
                        cb_element = cb.get('EL');
                        cb_prop = cb.get('PROP');
                        txt_cd = cb_element.tree(level - 1, cb_prop, n, ending);
                        lines = splitlines(txt_cd);
                        for i = 1:1:length(lines)
                            txt_el = [txt_el ...
                                sprintf(['  ' lines{i} '\n']) ... % indent
                                ]; %#ok<AGROW>
                        end
                    elseif isa(value, 'Element')
                        value_el = value;
                        txt_value_el = value_el.tree(level - 1, [], n, ending);
                        lines = splitlines(txt_value_el);
                        for i = 1:1:length(lines)
                            txt_el = [txt_el ...
                                sprintf(['  ' lines{i} '\n']) ... % indent
                                ]; %#ok<AGROW>
                        end                    
                    elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
                        for i = 1:1:length(value)
                            txt_el = [txt_el ...
                                sprintf(['  index:<strong>' int2str(i) '</strong> item:']) ... % indent
                                ]; %#ok<AGROW>
                            txt_value_dict_i = value{i}.tree(level - 1, [], n, ending);
                            lines = splitlines(txt_value_dict_i);
                            txt_el = [txt_el ...
                                sprintf([lines{1} '\n']) ...
                                ]; %#ok<AGROW>
                            for j = 2:1:length(lines)
                                txt_el = [txt_el ...
                                    sprintf(['  ' lines{j} '\n']) ... % indent
                                    ]; %#ok<AGROW>
                            end
                        end
                    end
                end
            end
            
            txt_el = txt_el(1:end - 1); % eliminates last carriage return

            if nargout == 1
                txt_output = txt_el;
            else
                disp(txt_el)
            end
        end
    end
    methods % comparison
        function el_list = getElementList(el, el_list)
            %GETELEMETLIST returns a list with all subelements.
            %
            % LIST = GETELEMETLIST(EL) returns a list with all subelements of element
            %  EL (including EL itself).
            %
            % LIST = GETELEMETLIST(EL, LIST) appends the subelements of element EL
            %  (including EL itself) to LIST. This form of the function is mainly used
            %  internally within the class Element.
            %
            % See also isequal, encodeJSON, decodeJSON, copy.

            if nargin < 2
                el_list = {};
            end
            
            if all(cellfun(@(x) el ~= x, el_list))
                el_list = [el_list(:); {el}];
            
                for prop = 1:1:el.getPropNumber()
                    value = el.getr(prop);

                    if isa(value, 'Element')
                        el_list = value.getElementList(el_list);
                    elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
                        for i = 1:1:length(value)
                            el_list = value{i}.getElementList(el_list);
                        end
                    end
                end
            end
        end        
        function check = isequal(el1, el2)
            %ISEQUAL determines whether two elements are equal (values, locked).
            %
            % CHECK = ISEQUAL(EL1, EL2) determines whether elements EL1 and EL2 are
            %  equal in terms of values and locked status. It ignores EVANESCENT props.
            %
            % Note that, instead, EL1 == EL2 determines whether the two handles 
            %  EL1 and EL2 refer to the very same element.
            %
            % See also getElementList.

            check = false;
            
            if ~isa(el2, 'Element') || ~strcmp(el1.getClass(), el2.getClass()) % isequal is called by el1, which thus must be an Element
                return % check = false;
            else
                el1_list = el1.getElementList();
                el2_list = el2.getElementList();
                
                if length(el1_list) ~= length(el2_list)
                    return % check = false;
                else
                    for i = 1:1:length(el1_list)
                        if ~strcmp(el1_list{i}.getClass(), el2_list{i}.getClass())
                            return % check = false;
                        else 
                            for prop = 1:1:el1_list{i}.getPropNumber()
                                if  el1_list{i}.getPropCategory(prop) ~= 7 ... % Category.EVANESCENT
                                        && all(el1_list{i}.getPropFormat(prop) ~= [8 9 10]) ... % [Format.ITEM Format.ITEMLIST Format.IDICT]
                                        && ~isa(el1_list{i}.getr(prop), 'Callback')
                                    if ~isequaln(el1_list{i}.getr(prop), el2_list{i}.getr(prop)) ...
                                            || el1_list{i}.isLocked(prop) ~= el2_list{i}.isLocked(prop)
                                        return  % check = false;
                                    end
                                end
                            end
                        end
                    end
                end
            end
            
            check = true; % only if all tests have been passed
        end
    end
    methods (Access=protected) % deep copy
        function el_copy = copyElement(el)
            %COPYELEMENT copies the element.
            %
            % EL_COPY = COPYELEMENT(EL) copies the element EL making a deep copy of all
            %  its properties (except EVANESCENT properties).
            %
            % See also copy.

            el_list = el.getElementList();
            
            % creates empty elements
            % fills them with shallow copies of props
            el_copy_list = cell(size(el_list));
            for i = 1:1:length(el_list)
                el_class = el_list{i}.getClass();
                if strcmp(el_class, 'NoValue')
                    el_copy_list{i} = Element.getNoValue();
                else
                    el_copy_list{i} = eval([el_class '(''_VOID_'')']);
                    el_copy_list{i}.props = el_list{i}.props;
                end
            end
            
            % reinitializes evanescent properties
            % fills in handle props
            for i = 1:1:length(el_list)
                for prop = 1:1:el_list{i}.getPropNumber()
                    if el_list{i}.getPropCategory(prop) == 7
                        % reinitializes evanescent properties
                        
                        el_copy_list{i}.props{prop}.value = Element.getNoValue();
                    else
                        % fills in handle props
                    
                        value = el_copy_list{i}.getr(prop);

                        if isa(value, 'Element')
                            el_copy_list{i}.props{prop}.value = el_copy_list{cellfun(@(x) x == value, el_list)};
                        elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
                            for j = 1:1:length(value)
                                el_copy_list{i}.props{prop}.value{j} = el_copy_list{cellfun(@(x) x == value{j}, el_list)};
                            end
                        end
                    end
                end
            end
            
            % links the copied callbacks
            for i = 1:1:length(el_copy_list)
                if isa(el_copy_list{i}, 'Callback')
                    el_copy_list{i}.get('EL').props{el_copy_list{i}.get('PROP')}.callback = el_copy_list{i};
                end
            end
            
            el_copy = el_copy_list{1};
        end
    end
    methods (Static) % BRAPH2 save/load elements
        function saved_out = save(el, filename, waitbar)
            %SAVE saves BRAPH2 element as b2 file.
            %
            % SAVED = SAVE(EL, FILEMANE) saves the element EL in the file FILENAME.
            %
            % SAVED = SAVE(EL) opens a dialog box to select the file.
            %
            % SAVED = SAVE(EL, [], TRUE) shows the waitbar during the saving process.
            %
            % It saves a deep copy of EL to reinitialize evanescent properties (e.g.,
            %  handles of figures). 
            %
            % See also load, uiputfile.
            
            if nargin < 3
                waitbar = false;
            end
            
            if nargin < 2 || isempty(filename)
                % select file
                [file, path, filterindex] = uiputfile(BRAPH2.EXT_ELEMENT, ['Select the ' el.get('NAME') ' file.']);
                % save file
                if filterindex
                    filename = fullfile(path, file);
                else 
                    filename = '';
                end
            end
            
            if ~isempty(filename)
                
                wb = braph2waitbar(waitbar, .5, 'Saving file (this might take a while) ...'); 
                drawnow()

                el = el.copy();
                build = 7;
                matlab_version = ver('MATLAB').Version;
                matlab_version_details = ver();
                build_log = load('build_log.mat', '-mat');  % % % double-check
                save(filename, 'el', 'build', 'matlab_version', 'matlab_version_details', 'build_log', '-v7.3');  % % % double-check
                
                saved = true;
                
                braph2waitbar(wb, 'close')
            else
                saved = false;
            end
            
            if nargout
                saved_out = saved;
            end
        end
        function [el, build, matlab_version, matlab_version_details] = load(filename, waitbar)
            %LOAD loads a BRAPH2 element from a b2 file.
            %
            % EL = LOAD(FILENAME) loads the element EL from the file b2 FILENAME. 
            %  If the element is not loaded, EL = false.
            %
            % EL = LOAD() opens a dialog box to select the file to be loaded. 
            %
            % EL = LOAD([], TRUE) determines whether to show the waitbar.
            %
            % [EL, BUILD, V, VD] = LOAD() returns also the BRAPH2 BUILD, the MatLab
            %  version number, and the details of the MatLab version RD.
            %
            % See also save, uigetfile.
            
            if nargin < 2
                waitbar = false;
            end
            
            if nargin < 1 || isempty(filename)
                % select file
                [file, path, filterindex] = uigetfile(BRAPH2.EXT_ELEMENT, 'Select the element file.');
                if filterindex
                    filename = fullfile(path, file);
                else 
                    filename = '';
                end
            end
            
            if isfile(filename)

                wb = braph2waitbar(waitbar, .5, 'Loading file (this might take a while) ...'); 
                drawnow()
                
                tmp = load(filename, '-mat', 'el', 'build', 'matlab_version', 'matlab_version_details', 'build_log');  % % % double-check
                el = tmp.el;
                build  = tmp.build;
                matlab_version = tmp.matlab_version;
                matlab_version_details = tmp.matlab_version_details;
                build_log = tmp.build_log;  % % % double-check
                
                braph2waitbar(wb, 'close')                
            else
                el = false;
                build  = [];
                matlab_version = [];
                matlab_version_details = [];
            end
        end
    end
    methods % encodeJSON
        function [json, struct, el_list] = encodeJSON(el)
            %ENCODEJSON returns a JSON string encoding the element.
            %
            % JSON = ENCODEJSON(EL) returns a JSON string encoding the element EL.
            %  Properties of category EVANESCENT and 
            %  of formats HANDLE and NET are not saved.
            %
            % See also decodeJSON.
            
            el_list = el.getElementList();
            
            if all(cellfun(@(x) Element.getNoValue() ~= x, el_list))
                el_list = [el_list(:); {Element.getNoValue()}];
            end
            
            for i = 1:1:length(el_list)
                el = el_list{i};
                
                struct{i}.class = el.getClass(); %#ok<AGROW>
                
                for prop = 1:1:el.getPropNumber()
                    value = el.getr(prop);

                    struct{i}.props{prop}.prop = prop;
                    struct{i}.props{prop}.tag = el.getPropTag(prop);
                    
                    if isa(value, 'NoValue')
                        struct{i}.props{prop}.value = find(cellfun(@(x) value == x, el_list)); % value = Element.getNoValue()
                    elseif isa(value, 'Callback')
                        struct{i}.props{prop}.value = find(cellfun(@(x) value == x, el_list));
                    else
                        if el.getPropCategory(prop) == 7 % Category.EVANESCENT % set to NoValue
                            struct{i}.props{prop}.value = find(cellfun(@(x) Element.getNoValue() == x, el_list));
                        else
                            switch el.getPropFormat(prop)
                                case 1 % Format.EMPTY
                                    struct{i}.props{prop}.value = regexprep(tostring(value), '''', '''''');
                                case {2 5 6 23 24} % {Format.STRING Format.OPTION Format.CLASS Format.MARKER Format.LINE}
                                    struct{i}.props{prop}.value = regexprep(tostring(value), '''', '''''');
                                case {4 11 12 13 14 15 20 21 22} % {Format.LOGICAL Format.SCALAR Format.RVECTOR Format.CVECTOR Format.MATRIX Format.SMATRIX Format.COLOR Format.ALPHA Format.SIZE}
                                    struct{i}.props{prop}.value = mat2str(value);
                                case {7 3} % {Format.CLASSLIST Format.STRINGLIST}
                                    json_str = '{';
                                    for j = 1:1:length(value)
                                        json_str = [json_str ' ''' value{j} ''' ']; %#ok<AGROW>
                                    end
                                    json_str = [json_str '}']; %#ok<AGROW>
                                    struct{i}.props{prop}.value = json_str;
                                case {8 10} % {Format.ITEM Format.IDICT}
                                    struct{i}.props{prop}.value = find(cellfun(@(x) value == x, el_list));
                                case 9 % Format.ITEMLIST
                                    indices = zeros(1, length(value));
                                    for j = 1:1:length(value)
                                        indices(j) = find(cellfun(@(x) value{j} == x, el_list));
                                    end
                                    struct{i}.props{prop}.value = indices;
                                case 16 % Format.CELL
                                    json_str = '{';
                                    for j = 1:1:size(value, 1)
                                        for k = 1:1:size(value, 2)
                                            if k < size(value, 2)
                                                json_str = [json_str mat2str(value{j, k}) ', ']; %#ok<AGROW>
                                            elseif j < size(value, 1)
                                                json_str = [json_str mat2str(value{j, k}) '; ']; %#ok<AGROW>
                                            else
                                                json_str = [json_str mat2str(value{j, k})]; %#ok<AGROW>
                                            end
                                        end
                                    end
                                    json_str = [json_str '}']; %#ok<AGROW>
                                    struct{i}.props{prop}.value = json_str;
                                case 17 % Format.NET % set to NoValue
                                    struct{i}.props{prop}.value = find(cellfun(@(x) Element.getNoValue() == x, el_list));
                                case {18 19} % {Format.HANDLE Format.HANDLELIST} % set to NoValue
                                    struct{i}.props{prop}.value = find(cellfun(@(x) Element.getNoValue() == x, el_list));
                            end
                        end
                    end
                    struct{i}.props{prop}.seed = el.getPropSeed(prop);
                    struct{i}.props{prop}.locked = el.isLocked(prop);
                    struct{i}.props{prop}.checked = el.isChecked(prop);
                end
            end

            json = jsonencode(struct);
        end
    end
    methods (Static) % decodeJSON
        function [el, struct, el_list] = decodeJSON(json)
            %DECODEJSON returns the element corresponding to a JSON string.
            %
            % EL = DECODEJSON(JSON) returns the element EL decoding the a JSON string.
            %  Note that properties of category EVANESCENT and 
            %  of formats HANDLE and NET are not saved.
            %
            % See also encodeJSON.
            
            struct = jsondecode(regexprep(json, '\\', '\\\\'));
            
            % manages special case when only one element
            if length(struct) == 1
                struct_tmp{1}.class = struct.class;
                if isfield(struct, 'props')
                    struct_tmp{1}.props = struct.props;
                end
                struct = struct_tmp;
                clear struct_tmp
            end

            % creates empty elements
            el_list = cell(length(struct), 1);
            for i = 1:1:length(struct)
                el_class = struct{i}.class;
                if strcmp(el_class, 'NoValue')
                    el_list{i} = NoValue.getNoValue();
                else
                    el_list{i} = eval([el_class '()']);
                end
            end
            
            % fills in props
            for i = 1:1:length(el_list)
                el = el_list{i};

                if isa(el, 'NoValue')
                    continue
                end
                
                for json_prop = 1:1:length(struct{i}.props)
                    value = struct{i}.props(json_prop).value;
                
                    tag = struct{i}.props(json_prop).tag;
                    prop = el.getPropProp(tag);

                    if isnumeric(value)
                        if ~isequal(el.getPropFormat(prop), 9) || (numel(value) == 1 && isa(el_list{value}, 'NoValue')) % case {Format.ITEM Format.IDICT}
                            el.props{prop}.value = el_list{value};
                        else % case Format.ITEMLIST
                            indices = value;
                            el.props{prop}.value = el_list(indices)';
                        end
                    else
                        switch el.getPropFormat(prop)
                            case 1 % Format.EMPTY
                                el.props{prop}.value = eval(value);
                            case {2 5 6 23 24} % {Format.STRING Format.OPTION Format.CLASS Format.MARKER Format.LINE}
                                el.props{prop}.value = eval(value(2:end-1));
                            case {4 11 12 13 14 15 20 21 22} % {Format.LOGICAL Format.SCALAR Format.RVECTOR Format.CVECTOR Format.MATRIX Format.SMATRIX Format.COLOR Format.ALPHA Format.SIZE}
                                el.props{prop}.value = eval(value);
                            case {7 3} % {Format.CLASSLIST Format.STRINGLIST}
                                el.props{prop}.value = eval(value);
                            case 16 % Format.CELL
                                el.props{prop}.value = eval(value);
                            case 17 % Format.NET
                                el.props{prop}.value = Element.getNoValue(); % NET properties are not saved
                            case {18 19} % {Format.HANDLE Format.HANDLELIST}
                                el.props{prop}.value = Element.getNoValue(); % HANDLE and HANDLELIST properties are not saved
                        end
                    end
                    el.props{prop}.seed = uint32(struct{i}.props(json_prop).seed);
                    el.props{prop}.locked = struct{i}.props(json_prop).locked;
                    el.props{prop}.checked = struct{i}.props(json_prop).checked;
                end
            end
            
            % links the decoded callbacks
            for i = 1:1:length(el_list)
                if isa(el_list{i}, 'Callback')
                    el_list{i}.get('EL').props{el_list{i}.get('PROP')}.callback = el_list{i};
                end
            end

            el = el_list{1};
        end
    end    
    methods % GUI
        function pr = getPanelProp(el, prop, varargin)
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

            switch el.getPropFormat(prop)
                case 1 % Format.EMPTY
                    pr = PanelProp( ... 
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 2 % Format.STRING
                    pr = PanelPropString( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 3 % Format.STRINGLIST
                    pr = PanelPropStringList( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 4 % Format.LOGICAL
                    pr = PanelPropLogical( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 5 % Format.OPTION
                    pr = PanelPropOption( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 6 % Format.CLASS
                    pr = PanelPropClass( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 7 % Format.CLASSLIST
                    pr = PanelPropClassList( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 8 % Format.ITEM
                    pr = PanelPropItem( ... 
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 9 % Format.ITEMLIST
                    pr = PanelPropItemList( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 10 % Format.IDICT
                    pr = PanelPropIDict( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 11 % Format.SCALAR
                    pr = PanelPropScalar( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 12 % Format.RVECTOR
                    pr = PanelPropMatrix( ... 
                        'EL', el, ...
                        'PROP', prop, ... 
                        'ROWNAME', {}, ...
                        varargin{:});
                case 13 % Format.CVECTOR
                    pr = PanelPropMatrix( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        'COLUMNNAME', {}, ...
                        varargin{:});
                case 14 % Format.MATRIX
                    pr = PanelPropMatrix( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 15 % Format.SMATRIX
                    pr = PanelPropMatrix( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 16 % Format.CELL
                    pr = PanelPropCell( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 17 % Format.NET
                    pr = PanelPropNet( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 18 % Format.HANDLE
                    warning([BRAPH2.STR ':Element'], [BRAPH2.STR ':Element \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
% % %                     pr = PanelPropHandle( ...
% % %                         'EL', el, ...
% % %                         'PROP', prop, ...
% % %                         varargin{:});
                case 19 % Format.HANDLELIST
                    warning([BRAPH2.STR ':Element'], [BRAPH2.STR ':Element \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
% % %                     pr = PanelPropHandleList( ...
% % %                         'EL', el, ...
% % %                         'PROP', prop, ...
% % %                         varargin{:});
                case 20 % Format.COLOR
                    pr = PanelPropColor( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 21 % Format.ALPHA
                    pr = PanelPropAlpha( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 22 % Format.SIZE
                    pr = PanelPropSize( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 23 % Format.MARKER
                    pr = PanelPropMarker( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case 24 % Format.LINE
                    pr = PanelPropLine( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                otherwise
                    pr = PanelProp( ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
            end
        end        
    end  
    methods (Static) % GUI Static
        function getGUIMenuImport(el, menu_import, pe) %#ok<INUSD> 
            %GETGUIMENUIMPORT sets the import submenu gui json.
            % 
            % GETGUIMENUIMPORT(EL, UI_MENU, PL) sets the import submenu
            %  json for the menu UI_MENU for the plot element PL.
            % 
            % See also getGUI, getGUIMenuExport, PLotElement.
            
            uimenu(menu_import, ...
                'Tag', 'MENU.Import.JSON', ...
                'Label', 'Import JSON ...', ...
                'Callback', {@cb_import_json})
                 
            function cb_import_json(~,~)
                [file, path, filterindex] = uigetfile('.json', ['Select ' el.get('NAME') ' file location.']);
                if filterindex
                    filename = fullfile(path, file);
                    fid = fopen(filename);
                    raw = fread(fid, inf);
                    str = char(raw');
                    fclose(fid);

                    gui = GUIElement('PE', Element.decodeJSON(str));
                    gui.get('DRAW')
                    gui.get('SHOW')
                end
            end
        end
        function getGUIMenuExport(el, menu_export, pe)
            %GETGUIMENUEXPORT sets the export submenu gui json.
            % 
            % GETGUIMENUEXPORT(EL, UI_MENU) sets the export submenu for the ui menu UI_MENU.
            % 
            % See also getGUI, getGUIMenuImport.
                     
            uimenu(menu_export, ...
                'Tag', 'MENU.Export.JSON', ...
                'Label', 'Export JSON ...', ...
                'Callback', {@cb_export_json})
          
            function cb_export_json(~,~)
                [file, path, filterindex] = uiputfile({'*.json', '*.json'}, ['Select ' el.get('NAME')  ' file location.']);
                if filterindex
                    filename = fullfile(path, file);
                    [json, ~, ~] = encodeJSON(pe.get('EL'));
                    fid = fopen(filename, 'w');
                    fprintf(fid, json);
                    fclose(fid);
                end
            end
        end
    end    
end
