classdef IndexedDictionary < ConcreteElement
	%IndexedDictionary is an indexed dictionary.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% An Indexed Dictionary (IndexedDictionary) provides the methods necessary 
	%  to handle data in an indexed dictionary. It contains and manages an 
	%  ordered list of couples {KEY, IT}, where KEY is a unique alphanumeric key 
	%  (a string) provided by a property of format STRING or CLASS and of 
	%  category PARAMETER or DATA, and IT is an element of a class defined in the 
	%  constructor using the property IT_CLASS.
	%
	% The list of IndexedDictionary properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the indexed dictionary (IndexedDictionary).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the indexed dictionary.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the indexed dictionary.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the indexed dictionary.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the indexed dictionary.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the indexed dictionary.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the indexed dictionary.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>IT_CLASS</strong> 	IT_CLASS (parameter, class) is the class of the item elements.
	%  <strong>10</strong> <strong>IT_KEY</strong> 	IT_KEY (parameter, scalar) is the property of the elements to be used as key (its category must be parameter or data, and its format must be string or class).
	%  <strong>11</strong> <strong>IT_LIST</strong> 	IT_LIST (data, itemlist) is the list containing the items.
	%  <strong>12</strong> <strong>LENGTH</strong> 	LENGTH (query, scalar) returns the number of items in the indexed dictionary.
	%  <strong>13</strong> <strong>CONTAINS</strong> 	CONTAINS (query, logical) checks whether an item exists in an indexed dictionary.
	%  <strong>14</strong> <strong>CONTAINS_INDEX</strong> 	CONTAINS_INDEX (query, logical) checks whether an index exists in an indexed dictionary.
	%  <strong>15</strong> <strong>CONTAINS_KEY</strong> 	CONTAINS_KEY (query, logical) checks whether a key exists in an indexed dictionary.
	%  <strong>16</strong> <strong>CONTAINS_IT</strong> 	CONTAINS_IT (query, logical) checks whether an item exists in an indexed dictionary
	%  <strong>17</strong> <strong>INDEX</strong> 	INDEX (query, scalar) returns the index of a key or item.
	%  <strong>18</strong> <strong>INDEX_FROM_KEY</strong> 	INDEX_FROM_KEY (query, scalar) returns the index of a key.
	%  <strong>19</strong> <strong>INDEX_FROM_IT</strong> 	INDEX_FROM_IT (query, scalar) returns the index of an item.
	%  <strong>20</strong> <strong>KEYS</strong> 	KEYS (query, stringlist) returns all the keys in the indexed dictionary.
	%  <strong>21</strong> <strong>KEY</strong> 	KEY (query, string) returns the key of an index or item.
	%  <strong>22</strong> <strong>KEY_FROM_INDEX</strong> 	KEY_FROM_INDEX (query, string) returns the key of an index
	%  <strong>23</strong> <strong>KEY_FROM_IT</strong> 	KEY_FROM_IT (query, string) returns the key of an item.
	%  <strong>24</strong> <strong>IT</strong> 	IT (query, item) returns the item of an index or key.
	%  <strong>25</strong> <strong>IT_FROM_INDEX</strong> 	IT_FROM_INDEX (query, item) returns the item of an index.
	%  <strong>26</strong> <strong>IT_FROM_KEY</strong> 	IT_FROM_KEY (query, item) returns the item of a key.
	%  <strong>27</strong> <strong>ADD</strong> 	ADD (query, empty) adds an item and key to an indexed dictionary
	%  <strong>28</strong> <strong>REMOVE</strong> 	REMOVE (query, empty) removes a key and item from an indexed dictionary.
	%  <strong>29</strong> <strong>REPLACE</strong> 	REPLACE (query, empty) replaces an item and key in an indexed dictionary.
	%  <strong>30</strong> <strong>REPLACE_KEY</strong> 	REPLACE_KEY (query, empty) replaces key in indexed dictionary.
	%  <strong>31</strong> <strong>REPLACE_IT</strong> 	REPLACE_IT (query, empty) replaces item in indexed dictionary.
	%  <strong>32</strong> <strong>INVERT</strong> 	INVERT (query, empty) inverts position of two items in indexed dictionary.
	%  <strong>33</strong> <strong>MOVE_TO</strong> 	MOVE_TO (query, empty) moves an item of an indexed dictionary to another position.
	%  <strong>34</strong> <strong>REMOVE_ALL</strong> 	REMOVE_ALL (query, rvector) removes selected items.
	%  <strong>35</strong> <strong>MOVE_UP</strong> 	MOVE_UP (query, rvector) moves up selected items.
	%  <strong>36</strong> <strong>MOVE_DOWN</strong> 	MOVE_DOWN (query, rvector) moves down selected items.
	%  <strong>37</strong> <strong>MOVE_TO_TOP</strong> 	MOVE_TO_TOP (query, empty) moves selected items to top.
	%  <strong>38</strong> <strong>MOVE_TO_BOTTOM</strong> 	MOVE_TO_BOTTOM (query, rvector) moves selected items to bottom.
	%
	% IndexedDictionary methods (constructor):
	%  IndexedDictionary - constructor
	%
	% IndexedDictionary methods:
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
	% IndexedDictionary methods (display):
	%  tostring - string with information about the indexed dictionary
	%  disp - displays information about the indexed dictionary
	%  tree - displays the tree of the indexed dictionary
	%
	% IndexedDictionary methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two indexed dictionary are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the indexed dictionary
	%
	% IndexedDictionary methods (save/load, Static):
	%  save - saves BRAPH2 indexed dictionary as b2 file
	%  load - loads a BRAPH2 indexed dictionary from a b2 file
	%
	% IndexedDictionary method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the indexed dictionary
	%
	% IndexedDictionary method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the indexed dictionary
	%
	% IndexedDictionary methods (inspection, Static):
	%  getClass - returns the class of the indexed dictionary
	%  getSubclasses - returns all subclasses of IndexedDictionary
	%  getProps - returns the property list of the indexed dictionary
	%  getPropNumber - returns the property number of the indexed dictionary
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
	% IndexedDictionary methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% IndexedDictionary methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% IndexedDictionary methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% IndexedDictionary methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?IndexedDictionary; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">IndexedDictionary constants</a>.
	%
	
	properties (Constant) % properties
		IT_CLASS = 9; %CET: Computational Efficiency Trick
		IT_CLASS_TAG = 'IT_CLASS';
		IT_CLASS_CATEGORY = 3;
		IT_CLASS_FORMAT = 6;
		
		IT_KEY = 10; %CET: Computational Efficiency Trick
		IT_KEY_TAG = 'IT_KEY';
		IT_KEY_CATEGORY = 3;
		IT_KEY_FORMAT = 11;
		
		IT_LIST = 11; %CET: Computational Efficiency Trick
		IT_LIST_TAG = 'IT_LIST';
		IT_LIST_CATEGORY = 4;
		IT_LIST_FORMAT = 9;
		
		LENGTH = 12; %CET: Computational Efficiency Trick
		LENGTH_TAG = 'LENGTH';
		LENGTH_CATEGORY = 6;
		LENGTH_FORMAT = 11;
		
		CONTAINS = 13; %CET: Computational Efficiency Trick
		CONTAINS_TAG = 'CONTAINS';
		CONTAINS_CATEGORY = 6;
		CONTAINS_FORMAT = 4;
		
		CONTAINS_INDEX = 14; %CET: Computational Efficiency Trick
		CONTAINS_INDEX_TAG = 'CONTAINS_INDEX';
		CONTAINS_INDEX_CATEGORY = 6;
		CONTAINS_INDEX_FORMAT = 4;
		
		CONTAINS_KEY = 15; %CET: Computational Efficiency Trick
		CONTAINS_KEY_TAG = 'CONTAINS_KEY';
		CONTAINS_KEY_CATEGORY = 6;
		CONTAINS_KEY_FORMAT = 4;
		
		CONTAINS_IT = 16; %CET: Computational Efficiency Trick
		CONTAINS_IT_TAG = 'CONTAINS_IT';
		CONTAINS_IT_CATEGORY = 6;
		CONTAINS_IT_FORMAT = 4;
		
		INDEX = 17; %CET: Computational Efficiency Trick
		INDEX_TAG = 'INDEX';
		INDEX_CATEGORY = 6;
		INDEX_FORMAT = 11;
		
		INDEX_FROM_KEY = 18; %CET: Computational Efficiency Trick
		INDEX_FROM_KEY_TAG = 'INDEX_FROM_KEY';
		INDEX_FROM_KEY_CATEGORY = 6;
		INDEX_FROM_KEY_FORMAT = 11;
		
		INDEX_FROM_IT = 19; %CET: Computational Efficiency Trick
		INDEX_FROM_IT_TAG = 'INDEX_FROM_IT';
		INDEX_FROM_IT_CATEGORY = 6;
		INDEX_FROM_IT_FORMAT = 11;
		
		KEYS = 20; %CET: Computational Efficiency Trick
		KEYS_TAG = 'KEYS';
		KEYS_CATEGORY = 6;
		KEYS_FORMAT = 3;
		
		KEY = 21; %CET: Computational Efficiency Trick
		KEY_TAG = 'KEY';
		KEY_CATEGORY = 6;
		KEY_FORMAT = 2;
		
		KEY_FROM_INDEX = 22; %CET: Computational Efficiency Trick
		KEY_FROM_INDEX_TAG = 'KEY_FROM_INDEX';
		KEY_FROM_INDEX_CATEGORY = 6;
		KEY_FROM_INDEX_FORMAT = 2;
		
		KEY_FROM_IT = 23; %CET: Computational Efficiency Trick
		KEY_FROM_IT_TAG = 'KEY_FROM_IT';
		KEY_FROM_IT_CATEGORY = 6;
		KEY_FROM_IT_FORMAT = 2;
		
		IT = 24; %CET: Computational Efficiency Trick
		IT_TAG = 'IT';
		IT_CATEGORY = 6;
		IT_FORMAT = 8;
		
		IT_FROM_INDEX = 25; %CET: Computational Efficiency Trick
		IT_FROM_INDEX_TAG = 'IT_FROM_INDEX';
		IT_FROM_INDEX_CATEGORY = 6;
		IT_FROM_INDEX_FORMAT = 8;
		
		IT_FROM_KEY = 26; %CET: Computational Efficiency Trick
		IT_FROM_KEY_TAG = 'IT_FROM_KEY';
		IT_FROM_KEY_CATEGORY = 6;
		IT_FROM_KEY_FORMAT = 8;
		
		ADD = 27; %CET: Computational Efficiency Trick
		ADD_TAG = 'ADD';
		ADD_CATEGORY = 6;
		ADD_FORMAT = 1;
		
		REMOVE = 28; %CET: Computational Efficiency Trick
		REMOVE_TAG = 'REMOVE';
		REMOVE_CATEGORY = 6;
		REMOVE_FORMAT = 1;
		
		REPLACE = 29; %CET: Computational Efficiency Trick
		REPLACE_TAG = 'REPLACE';
		REPLACE_CATEGORY = 6;
		REPLACE_FORMAT = 1;
		
		REPLACE_KEY = 30; %CET: Computational Efficiency Trick
		REPLACE_KEY_TAG = 'REPLACE_KEY';
		REPLACE_KEY_CATEGORY = 6;
		REPLACE_KEY_FORMAT = 1;
		
		REPLACE_IT = 31; %CET: Computational Efficiency Trick
		REPLACE_IT_TAG = 'REPLACE_IT';
		REPLACE_IT_CATEGORY = 6;
		REPLACE_IT_FORMAT = 1;
		
		INVERT = 32; %CET: Computational Efficiency Trick
		INVERT_TAG = 'INVERT';
		INVERT_CATEGORY = 6;
		INVERT_FORMAT = 1;
		
		MOVE_TO = 33; %CET: Computational Efficiency Trick
		MOVE_TO_TAG = 'MOVE_TO';
		MOVE_TO_CATEGORY = 6;
		MOVE_TO_FORMAT = 1;
		
		REMOVE_ALL = 34; %CET: Computational Efficiency Trick
		REMOVE_ALL_TAG = 'REMOVE_ALL';
		REMOVE_ALL_CATEGORY = 6;
		REMOVE_ALL_FORMAT = 12;
		
		MOVE_UP = 35; %CET: Computational Efficiency Trick
		MOVE_UP_TAG = 'MOVE_UP';
		MOVE_UP_CATEGORY = 6;
		MOVE_UP_FORMAT = 12;
		
		MOVE_DOWN = 36; %CET: Computational Efficiency Trick
		MOVE_DOWN_TAG = 'MOVE_DOWN';
		MOVE_DOWN_CATEGORY = 6;
		MOVE_DOWN_FORMAT = 12;
		
		MOVE_TO_TOP = 37; %CET: Computational Efficiency Trick
		MOVE_TO_TOP_TAG = 'MOVE_TO_TOP';
		MOVE_TO_TOP_CATEGORY = 6;
		MOVE_TO_TOP_FORMAT = 1;
		
		MOVE_TO_BOTTOM = 38; %CET: Computational Efficiency Trick
		MOVE_TO_BOTTOM_TAG = 'MOVE_TO_BOTTOM';
		MOVE_TO_BOTTOM_CATEGORY = 6;
		MOVE_TO_BOTTOM_FORMAT = 12;
	end
	methods % constructor
		function idict = IndexedDictionary(varargin)
			%IndexedDictionary() creates a indexed dictionary.
			%
			% IndexedDictionary(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% IndexedDictionary(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of IndexedDictionary properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the indexed dictionary (IndexedDictionary).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the indexed dictionary.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the indexed dictionary.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the indexed dictionary.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the indexed dictionary.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the indexed dictionary.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the indexed dictionary.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>IT_CLASS</strong> 	IT_CLASS (parameter, class) is the class of the item elements.
			%  <strong>10</strong> <strong>IT_KEY</strong> 	IT_KEY (parameter, scalar) is the property of the elements to be used as key (its category must be parameter or data, and its format must be string or class).
			%  <strong>11</strong> <strong>IT_LIST</strong> 	IT_LIST (data, itemlist) is the list containing the items.
			%  <strong>12</strong> <strong>LENGTH</strong> 	LENGTH (query, scalar) returns the number of items in the indexed dictionary.
			%  <strong>13</strong> <strong>CONTAINS</strong> 	CONTAINS (query, logical) checks whether an item exists in an indexed dictionary.
			%  <strong>14</strong> <strong>CONTAINS_INDEX</strong> 	CONTAINS_INDEX (query, logical) checks whether an index exists in an indexed dictionary.
			%  <strong>15</strong> <strong>CONTAINS_KEY</strong> 	CONTAINS_KEY (query, logical) checks whether a key exists in an indexed dictionary.
			%  <strong>16</strong> <strong>CONTAINS_IT</strong> 	CONTAINS_IT (query, logical) checks whether an item exists in an indexed dictionary
			%  <strong>17</strong> <strong>INDEX</strong> 	INDEX (query, scalar) returns the index of a key or item.
			%  <strong>18</strong> <strong>INDEX_FROM_KEY</strong> 	INDEX_FROM_KEY (query, scalar) returns the index of a key.
			%  <strong>19</strong> <strong>INDEX_FROM_IT</strong> 	INDEX_FROM_IT (query, scalar) returns the index of an item.
			%  <strong>20</strong> <strong>KEYS</strong> 	KEYS (query, stringlist) returns all the keys in the indexed dictionary.
			%  <strong>21</strong> <strong>KEY</strong> 	KEY (query, string) returns the key of an index or item.
			%  <strong>22</strong> <strong>KEY_FROM_INDEX</strong> 	KEY_FROM_INDEX (query, string) returns the key of an index
			%  <strong>23</strong> <strong>KEY_FROM_IT</strong> 	KEY_FROM_IT (query, string) returns the key of an item.
			%  <strong>24</strong> <strong>IT</strong> 	IT (query, item) returns the item of an index or key.
			%  <strong>25</strong> <strong>IT_FROM_INDEX</strong> 	IT_FROM_INDEX (query, item) returns the item of an index.
			%  <strong>26</strong> <strong>IT_FROM_KEY</strong> 	IT_FROM_KEY (query, item) returns the item of a key.
			%  <strong>27</strong> <strong>ADD</strong> 	ADD (query, empty) adds an item and key to an indexed dictionary
			%  <strong>28</strong> <strong>REMOVE</strong> 	REMOVE (query, empty) removes a key and item from an indexed dictionary.
			%  <strong>29</strong> <strong>REPLACE</strong> 	REPLACE (query, empty) replaces an item and key in an indexed dictionary.
			%  <strong>30</strong> <strong>REPLACE_KEY</strong> 	REPLACE_KEY (query, empty) replaces key in indexed dictionary.
			%  <strong>31</strong> <strong>REPLACE_IT</strong> 	REPLACE_IT (query, empty) replaces item in indexed dictionary.
			%  <strong>32</strong> <strong>INVERT</strong> 	INVERT (query, empty) inverts position of two items in indexed dictionary.
			%  <strong>33</strong> <strong>MOVE_TO</strong> 	MOVE_TO (query, empty) moves an item of an indexed dictionary to another position.
			%  <strong>34</strong> <strong>REMOVE_ALL</strong> 	REMOVE_ALL (query, rvector) removes selected items.
			%  <strong>35</strong> <strong>MOVE_UP</strong> 	MOVE_UP (query, rvector) moves up selected items.
			%  <strong>36</strong> <strong>MOVE_DOWN</strong> 	MOVE_DOWN (query, rvector) moves down selected items.
			%  <strong>37</strong> <strong>MOVE_TO_TOP</strong> 	MOVE_TO_TOP (query, empty) moves selected items to top.
			%  <strong>38</strong> <strong>MOVE_TO_BOTTOM</strong> 	MOVE_TO_BOTTOM (query, rvector) moves selected items to bottom.
			%
			% See also Category, Format.
			
			idict = idict@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the indexed dictionary.
			%
			% BUILD = IndexedDictionary.GETBUILD() returns the build of 'IndexedDictionary'.
			%
			% Alternative forms to call this method are:
			%  BUILD = IDICT.GETBUILD() returns the build of the indexed dictionary IDICT.
			%  BUILD = Element.GETBUILD(IDICT) returns the build of 'IDICT'.
			%  BUILD = Element.GETBUILD('IndexedDictionary') returns the build of 'IndexedDictionary'.
			%
			% Note that the Element.GETBUILD(IDICT) and Element.GETBUILD('IndexedDictionary')
			%  are less computationally efficient.
			
			build = 1;
		end
		function idict_class = getClass()
			%GETCLASS returns the class of the indexed dictionary.
			%
			% CLASS = IndexedDictionary.GETCLASS() returns the class 'IndexedDictionary'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IDICT.GETCLASS() returns the class of the indexed dictionary IDICT.
			%  CLASS = Element.GETCLASS(IDICT) returns the class of 'IDICT'.
			%  CLASS = Element.GETCLASS('IndexedDictionary') returns 'IndexedDictionary'.
			%
			% Note that the Element.GETCLASS(IDICT) and Element.GETCLASS('IndexedDictionary')
			%  are less computationally efficient.
			
			idict_class = 'IndexedDictionary';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the indexed dictionary.
			%
			% LIST = IndexedDictionary.GETSUBCLASSES() returns all subclasses of 'IndexedDictionary'.
			%
			% Alternative forms to call this method are:
			%  LIST = IDICT.GETSUBCLASSES() returns all subclasses of the indexed dictionary IDICT.
			%  LIST = Element.GETSUBCLASSES(IDICT) returns all subclasses of 'IDICT'.
			%  LIST = Element.GETSUBCLASSES('IndexedDictionary') returns all subclasses of 'IndexedDictionary'.
			%
			% Note that the Element.GETSUBCLASSES(IDICT) and Element.GETSUBCLASSES('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'IndexedDictionary' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of indexed dictionary.
			%
			% PROPS = IndexedDictionary.GETPROPS() returns the property list of indexed dictionary
			%  as a row vector.
			%
			% PROPS = IndexedDictionary.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IDICT.GETPROPS([CATEGORY]) returns the property list of the indexed dictionary IDICT.
			%  PROPS = Element.GETPROPS(IDICT[, CATEGORY]) returns the property list of 'IDICT'.
			%  PROPS = Element.GETPROPS('IndexedDictionary'[, CATEGORY]) returns the property list of 'IndexedDictionary'.
			%
			% Note that the Element.GETPROPS(IDICT) and Element.GETPROPS('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 9 10];
				case 4 % Category.DATA
					prop_list = [5 11];
				case 6 % Category.QUERY
					prop_list = [8 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of indexed dictionary.
			%
			% N = IndexedDictionary.GETPROPNUMBER() returns the property number of indexed dictionary.
			%
			% N = IndexedDictionary.GETPROPNUMBER(CATEGORY) returns the property number of indexed dictionary
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IDICT.GETPROPNUMBER([CATEGORY]) returns the property number of the indexed dictionary IDICT.
			%  N = Element.GETPROPNUMBER(IDICT) returns the property number of 'IDICT'.
			%  N = Element.GETPROPNUMBER('IndexedDictionary') returns the property number of 'IndexedDictionary'.
			%
			% Note that the Element.GETPROPNUMBER(IDICT) and Element.GETPROPNUMBER('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 38;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 3;
				case 4 % Category.DATA
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 28;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in indexed dictionary/error.
			%
			% CHECK = IndexedDictionary.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IDICT.EXISTSPROP(PROP) checks whether PROP exists for IDICT.
			%  CHECK = Element.EXISTSPROP(IDICT, PROP) checks whether PROP exists for IDICT.
			%  CHECK = Element.EXISTSPROP(IndexedDictionary, PROP) checks whether PROP exists for IndexedDictionary.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IDICT.EXISTSPROP(PROP) throws error if PROP does NOT exist for IDICT.
			%   Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%  Element.EXISTSPROP(IDICT, PROP) throws error if PROP does NOT exist for IDICT.
			%   Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%  Element.EXISTSPROP(IndexedDictionary, PROP) throws error if PROP does NOT exist for IndexedDictionary.
			%   Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IDICT) and Element.EXISTSPROP('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 38 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':IndexedDictionary:' 'WrongInput'], ...
					['BRAPH2' ':IndexedDictionary:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for IndexedDictionary.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in indexed dictionary/error.
			%
			% CHECK = IndexedDictionary.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IDICT.EXISTSTAG(TAG) checks whether TAG exists for IDICT.
			%  CHECK = Element.EXISTSTAG(IDICT, TAG) checks whether TAG exists for IDICT.
			%  CHECK = Element.EXISTSTAG(IndexedDictionary, TAG) checks whether TAG exists for IndexedDictionary.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IDICT.EXISTSTAG(TAG) throws error if TAG does NOT exist for IDICT.
			%   Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%  Element.EXISTSTAG(IDICT, TAG) throws error if TAG does NOT exist for IDICT.
			%   Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%  Element.EXISTSTAG(IndexedDictionary, TAG) throws error if TAG does NOT exist for IndexedDictionary.
			%   Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IDICT) and Element.EXISTSTAG('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'IT_CLASS'  'IT_KEY'  'IT_LIST'  'LENGTH'  'CONTAINS'  'CONTAINS_INDEX'  'CONTAINS_KEY'  'CONTAINS_IT'  'INDEX'  'INDEX_FROM_KEY'  'INDEX_FROM_IT'  'KEYS'  'KEY'  'KEY_FROM_INDEX'  'KEY_FROM_IT'  'IT'  'IT_FROM_INDEX'  'IT_FROM_KEY'  'ADD'  'REMOVE'  'REPLACE'  'REPLACE_KEY'  'REPLACE_IT'  'INVERT'  'MOVE_TO'  'REMOVE_ALL'  'MOVE_UP'  'MOVE_DOWN'  'MOVE_TO_TOP'  'MOVE_TO_BOTTOM' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':IndexedDictionary:' 'WrongInput'], ...
					['BRAPH2' ':IndexedDictionary:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for IndexedDictionary.'] ...
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
			%  PROPERTY = IDICT.GETPROPPROP(POINTER) returns property number of POINTER of IDICT.
			%  PROPERTY = Element.GETPROPPROP(IndexedDictionary, POINTER) returns property number of POINTER of IndexedDictionary.
			%  PROPERTY = IDICT.GETPROPPROP(IndexedDictionary, POINTER) returns property number of POINTER of IndexedDictionary.
			%
			% Note that the Element.GETPROPPROP(IDICT) and Element.GETPROPPROP('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'IT_CLASS'  'IT_KEY'  'IT_LIST'  'LENGTH'  'CONTAINS'  'CONTAINS_INDEX'  'CONTAINS_KEY'  'CONTAINS_IT'  'INDEX'  'INDEX_FROM_KEY'  'INDEX_FROM_IT'  'KEYS'  'KEY'  'KEY_FROM_INDEX'  'KEY_FROM_IT'  'IT'  'IT_FROM_INDEX'  'IT_FROM_KEY'  'ADD'  'REMOVE'  'REPLACE'  'REPLACE_KEY'  'REPLACE_IT'  'INVERT'  'MOVE_TO'  'REMOVE_ALL'  'MOVE_UP'  'MOVE_DOWN'  'MOVE_TO_TOP'  'MOVE_TO_BOTTOM' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = IDICT.GETPROPTAG(POINTER) returns tag of POINTER of IDICT.
			%  TAG = Element.GETPROPTAG(IndexedDictionary, POINTER) returns tag of POINTER of IndexedDictionary.
			%  TAG = IDICT.GETPROPTAG(IndexedDictionary, POINTER) returns tag of POINTER of IndexedDictionary.
			%
			% Note that the Element.GETPROPTAG(IDICT) and Element.GETPROPTAG('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				indexeddictionary_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'IT_CLASS'  'IT_KEY'  'IT_LIST'  'LENGTH'  'CONTAINS'  'CONTAINS_INDEX'  'CONTAINS_KEY'  'CONTAINS_IT'  'INDEX'  'INDEX_FROM_KEY'  'INDEX_FROM_IT'  'KEYS'  'KEY'  'KEY_FROM_INDEX'  'KEY_FROM_IT'  'IT'  'IT_FROM_INDEX'  'IT_FROM_KEY'  'ADD'  'REMOVE'  'REPLACE'  'REPLACE_KEY'  'REPLACE_IT'  'INVERT'  'MOVE_TO'  'REMOVE_ALL'  'MOVE_UP'  'MOVE_DOWN'  'MOVE_TO_TOP'  'MOVE_TO_BOTTOM' };
				tag = indexeddictionary_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = IDICT.GETPROPCATEGORY(POINTER) returns category of POINTER of IDICT.
			%  CATEGORY = Element.GETPROPCATEGORY(IndexedDictionary, POINTER) returns category of POINTER of IndexedDictionary.
			%  CATEGORY = IDICT.GETPROPCATEGORY(IndexedDictionary, POINTER) returns category of POINTER of IndexedDictionary.
			%
			% Note that the Element.GETPROPCATEGORY(IDICT) and Element.GETPROPCATEGORY('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			indexeddictionary_category_list = { 1  1  1  3  4  2  2  6  3  3  4  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6  6 };
			prop_category = indexeddictionary_category_list{prop};
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
			%  FORMAT = IDICT.GETPROPFORMAT(POINTER) returns format of POINTER of IDICT.
			%  FORMAT = Element.GETPROPFORMAT(IndexedDictionary, POINTER) returns format of POINTER of IndexedDictionary.
			%  FORMAT = IDICT.GETPROPFORMAT(IndexedDictionary, POINTER) returns format of POINTER of IndexedDictionary.
			%
			% Note that the Element.GETPROPFORMAT(IDICT) and Element.GETPROPFORMAT('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			indexeddictionary_format_list = { 2  2  2  8  2  2  2  2  6  11  9  11  4  4  4  4  11  11  11  3  2  2  2  8  8  8  1  1  1  1  1  1  1  12  12  12  1  12 };
			prop_format = indexeddictionary_format_list{prop};
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
			%  DESCRIPTION = IDICT.GETPROPDESCRIPTION(POINTER) returns description of POINTER of IDICT.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(IndexedDictionary, POINTER) returns description of POINTER of IndexedDictionary.
			%  DESCRIPTION = IDICT.GETPROPDESCRIPTION(IndexedDictionary, POINTER) returns description of POINTER of IndexedDictionary.
			%
			% Note that the Element.GETPROPDESCRIPTION(IDICT) and Element.GETPROPDESCRIPTION('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			indexeddictionary_description_list = { 'ELCLASS (constant, string) is the class of the indexed dictionary (IndexedDictionary).'  'NAME (constant, string) is the name of the indexed dictionary.'  'DESCRIPTION (constant, string) is the description of the indexed dictionary.'  'TEMPLATE (parameter, item) is the template of the indexed dictionary.'  'ID (data, string) is a few-letter code for the indexed dictionary.'  'LABEL (metadata, string) is an extended label of the indexed dictionary.'  'NOTES (metadata, string) are some specific notes about the indexed dictionary.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'IT_CLASS (parameter, class) is the class of the item elements.'  'IT_KEY (parameter, scalar) is the property of the elements to be used as key (its category must be parameter or data, and its format must be string or class).'  'IT_LIST (data, itemlist) is the list containing the items.'  'LENGTH (query, scalar) returns the number of items in the indexed dictionary.'  'CONTAINS (query, logical) checks whether an item exists in an indexed dictionary.'  'CONTAINS_INDEX (query, logical) checks whether an index exists in an indexed dictionary.'  'CONTAINS_KEY (query, logical) checks whether a key exists in an indexed dictionary.'  'CONTAINS_IT (query, logical) checks whether an item exists in an indexed dictionary'  'INDEX (query, scalar) returns the index of a key or item.'  'INDEX_FROM_KEY (query, scalar) returns the index of a key.'  'INDEX_FROM_IT (query, scalar) returns the index of an item.'  'KEYS (query, stringlist) returns all the keys in the indexed dictionary.'  'KEY (query, string) returns the key of an index or item.'  'KEY_FROM_INDEX (query, string) returns the key of an index'  'KEY_FROM_IT (query, string) returns the key of an item.'  'IT (query, item) returns the item of an index or key.'  'IT_FROM_INDEX (query, item) returns the item of an index.'  'IT_FROM_KEY (query, item) returns the item of a key.'  'ADD (query, empty) adds an item and key to an indexed dictionary'  'REMOVE (query, empty) removes a key and item from an indexed dictionary.'  'REPLACE (query, empty) replaces an item and key in an indexed dictionary.'  'REPLACE_KEY (query, empty) replaces key in indexed dictionary.'  'REPLACE_IT (query, empty) replaces item in indexed dictionary.'  'INVERT (query, empty) inverts position of two items in indexed dictionary.'  'MOVE_TO (query, empty) moves an item of an indexed dictionary to another position.'  'REMOVE_ALL (query, rvector) removes selected items.'  'MOVE_UP (query, rvector) moves up selected items.'  'MOVE_DOWN (query, rvector) moves down selected items.'  'MOVE_TO_TOP (query, empty) moves selected items to top.'  'MOVE_TO_BOTTOM (query, rvector) moves selected items to bottom.' };
			prop_description = indexeddictionary_description_list{prop};
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
			%  SETTINGS = IDICT.GETPROPSETTINGS(POINTER) returns settings of POINTER of IDICT.
			%  SETTINGS = Element.GETPROPSETTINGS(IndexedDictionary, POINTER) returns settings of POINTER of IndexedDictionary.
			%  SETTINGS = IDICT.GETPROPSETTINGS(IndexedDictionary, POINTER) returns settings of POINTER of IndexedDictionary.
			%
			% Note that the Element.GETPROPSETTINGS(IDICT) and Element.GETPROPSETTINGS('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % IndexedDictionary.IT_CLASS
					prop_settings = Format.getFormatSettings(6);
				case 10 % IndexedDictionary.IT_KEY
					prop_settings = Format.getFormatSettings(11);
				case 11 % IndexedDictionary.IT_LIST
					prop_settings = Format.getFormatSettings(9);
				case 12 % IndexedDictionary.LENGTH
					prop_settings = Format.getFormatSettings(11);
				case 13 % IndexedDictionary.CONTAINS
					prop_settings = Format.getFormatSettings(4);
				case 14 % IndexedDictionary.CONTAINS_INDEX
					prop_settings = Format.getFormatSettings(4);
				case 15 % IndexedDictionary.CONTAINS_KEY
					prop_settings = Format.getFormatSettings(4);
				case 16 % IndexedDictionary.CONTAINS_IT
					prop_settings = Format.getFormatSettings(4);
				case 17 % IndexedDictionary.INDEX
					prop_settings = Format.getFormatSettings(11);
				case 18 % IndexedDictionary.INDEX_FROM_KEY
					prop_settings = Format.getFormatSettings(11);
				case 19 % IndexedDictionary.INDEX_FROM_IT
					prop_settings = Format.getFormatSettings(11);
				case 20 % IndexedDictionary.KEYS
					prop_settings = Format.getFormatSettings(3);
				case 21 % IndexedDictionary.KEY
					prop_settings = Format.getFormatSettings(2);
				case 22 % IndexedDictionary.KEY_FROM_INDEX
					prop_settings = Format.getFormatSettings(2);
				case 23 % IndexedDictionary.KEY_FROM_IT
					prop_settings = Format.getFormatSettings(2);
				case 24 % IndexedDictionary.IT
					prop_settings = Format.getFormatSettings(8);
				case 25 % IndexedDictionary.IT_FROM_INDEX
					prop_settings = Format.getFormatSettings(8);
				case 26 % IndexedDictionary.IT_FROM_KEY
					prop_settings = Format.getFormatSettings(8);
				case 27 % IndexedDictionary.ADD
					prop_settings = Format.getFormatSettings(1);
				case 28 % IndexedDictionary.REMOVE
					prop_settings = Format.getFormatSettings(1);
				case 29 % IndexedDictionary.REPLACE
					prop_settings = Format.getFormatSettings(1);
				case 30 % IndexedDictionary.REPLACE_KEY
					prop_settings = Format.getFormatSettings(1);
				case 31 % IndexedDictionary.REPLACE_IT
					prop_settings = Format.getFormatSettings(1);
				case 32 % IndexedDictionary.INVERT
					prop_settings = Format.getFormatSettings(1);
				case 33 % IndexedDictionary.MOVE_TO
					prop_settings = Format.getFormatSettings(1);
				case 34 % IndexedDictionary.REMOVE_ALL
					prop_settings = Format.getFormatSettings(12);
				case 35 % IndexedDictionary.MOVE_UP
					prop_settings = Format.getFormatSettings(12);
				case 36 % IndexedDictionary.MOVE_DOWN
					prop_settings = Format.getFormatSettings(12);
				case 37 % IndexedDictionary.MOVE_TO_TOP
					prop_settings = Format.getFormatSettings(1);
				case 38 % IndexedDictionary.MOVE_TO_BOTTOM
					prop_settings = Format.getFormatSettings(12);
				case 4 % IndexedDictionary.TEMPLATE
					prop_settings = 'IndexedDictionary';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = IndexedDictionary.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = IndexedDictionary.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IDICT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IDICT.
			%  DEFAULT = Element.GETPROPDEFAULT(IndexedDictionary, POINTER) returns the default value of POINTER of IndexedDictionary.
			%  DEFAULT = IDICT.GETPROPDEFAULT(IndexedDictionary, POINTER) returns the default value of POINTER of IndexedDictionary.
			%
			% Note that the Element.GETPROPDEFAULT(IDICT) and Element.GETPROPDEFAULT('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % IndexedDictionary.IT_CLASS
					prop_default = Format.getFormatDefault(6, IndexedDictionary.getPropSettings(prop));
				case 10 % IndexedDictionary.IT_KEY
					prop_default = 5;
				case 11 % IndexedDictionary.IT_LIST
					prop_default = Format.getFormatDefault(9, IndexedDictionary.getPropSettings(prop));
				case 12 % IndexedDictionary.LENGTH
					prop_default = Format.getFormatDefault(11, IndexedDictionary.getPropSettings(prop));
				case 13 % IndexedDictionary.CONTAINS
					prop_default = Format.getFormatDefault(4, IndexedDictionary.getPropSettings(prop));
				case 14 % IndexedDictionary.CONTAINS_INDEX
					prop_default = Format.getFormatDefault(4, IndexedDictionary.getPropSettings(prop));
				case 15 % IndexedDictionary.CONTAINS_KEY
					prop_default = Format.getFormatDefault(4, IndexedDictionary.getPropSettings(prop));
				case 16 % IndexedDictionary.CONTAINS_IT
					prop_default = Format.getFormatDefault(4, IndexedDictionary.getPropSettings(prop));
				case 17 % IndexedDictionary.INDEX
					prop_default = Format.getFormatDefault(11, IndexedDictionary.getPropSettings(prop));
				case 18 % IndexedDictionary.INDEX_FROM_KEY
					prop_default = Format.getFormatDefault(11, IndexedDictionary.getPropSettings(prop));
				case 19 % IndexedDictionary.INDEX_FROM_IT
					prop_default = Format.getFormatDefault(11, IndexedDictionary.getPropSettings(prop));
				case 20 % IndexedDictionary.KEYS
					prop_default = Format.getFormatDefault(3, IndexedDictionary.getPropSettings(prop));
				case 21 % IndexedDictionary.KEY
					prop_default = Format.getFormatDefault(2, IndexedDictionary.getPropSettings(prop));
				case 22 % IndexedDictionary.KEY_FROM_INDEX
					prop_default = Format.getFormatDefault(2, IndexedDictionary.getPropSettings(prop));
				case 23 % IndexedDictionary.KEY_FROM_IT
					prop_default = Format.getFormatDefault(2, IndexedDictionary.getPropSettings(prop));
				case 24 % IndexedDictionary.IT
					prop_default = Format.getFormatDefault(8, IndexedDictionary.getPropSettings(prop));
				case 25 % IndexedDictionary.IT_FROM_INDEX
					prop_default = Format.getFormatDefault(8, IndexedDictionary.getPropSettings(prop));
				case 26 % IndexedDictionary.IT_FROM_KEY
					prop_default = Format.getFormatDefault(8, IndexedDictionary.getPropSettings(prop));
				case 27 % IndexedDictionary.ADD
					prop_default = Format.getFormatDefault(1, IndexedDictionary.getPropSettings(prop));
				case 28 % IndexedDictionary.REMOVE
					prop_default = Format.getFormatDefault(1, IndexedDictionary.getPropSettings(prop));
				case 29 % IndexedDictionary.REPLACE
					prop_default = Format.getFormatDefault(1, IndexedDictionary.getPropSettings(prop));
				case 30 % IndexedDictionary.REPLACE_KEY
					prop_default = Format.getFormatDefault(1, IndexedDictionary.getPropSettings(prop));
				case 31 % IndexedDictionary.REPLACE_IT
					prop_default = Format.getFormatDefault(1, IndexedDictionary.getPropSettings(prop));
				case 32 % IndexedDictionary.INVERT
					prop_default = Format.getFormatDefault(1, IndexedDictionary.getPropSettings(prop));
				case 33 % IndexedDictionary.MOVE_TO
					prop_default = Format.getFormatDefault(1, IndexedDictionary.getPropSettings(prop));
				case 34 % IndexedDictionary.REMOVE_ALL
					prop_default = Format.getFormatDefault(12, IndexedDictionary.getPropSettings(prop));
				case 35 % IndexedDictionary.MOVE_UP
					prop_default = Format.getFormatDefault(12, IndexedDictionary.getPropSettings(prop));
				case 36 % IndexedDictionary.MOVE_DOWN
					prop_default = Format.getFormatDefault(12, IndexedDictionary.getPropSettings(prop));
				case 37 % IndexedDictionary.MOVE_TO_TOP
					prop_default = Format.getFormatDefault(1, IndexedDictionary.getPropSettings(prop));
				case 38 % IndexedDictionary.MOVE_TO_BOTTOM
					prop_default = Format.getFormatDefault(12, IndexedDictionary.getPropSettings(prop));
				case 1 % IndexedDictionary.ELCLASS
					prop_default = 'IndexedDictionary';
				case 2 % IndexedDictionary.NAME
					prop_default = 'Indexed Dictionary';
				case 3 % IndexedDictionary.DESCRIPTION
					prop_default = 'An Indexed Dictionary (IndexedDictionary) provides the methods necessary to handle data in an indexed dictionary. It contains and manages an ordered list of couples {KEY, IT}, where KEY is a unique alphanumeric key (a string) provided by a property of format STRING or CLASS and of category PARAMETER or DATA, and IT is an element of a class defined in the constructor using the property IT_CLASS.';
				case 4 % IndexedDictionary.TEMPLATE
					prop_default = Format.getFormatDefault(8, IndexedDictionary.getPropSettings(prop));
				case 5 % IndexedDictionary.ID
					prop_default = 'IndexedDictionary ID';
				case 6 % IndexedDictionary.LABEL
					prop_default = 'IndexedDictionary label';
				case 7 % IndexedDictionary.NOTES
					prop_default = 'IndexedDictionary notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = IndexedDictionary.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = IndexedDictionary.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IDICT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IDICT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(IndexedDictionary, POINTER) returns the conditioned default value of POINTER of IndexedDictionary.
			%  DEFAULT = IDICT.GETPROPDEFAULTCONDITIONED(IndexedDictionary, POINTER) returns the conditioned default value of POINTER of IndexedDictionary.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IDICT) and Element.GETPROPDEFAULTCONDITIONED('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			prop_default = IndexedDictionary.conditioning(prop, IndexedDictionary.getPropDefault(prop));
		end
	end
	methods (Access=protected) % preset
		function value = preset(idict, prop, value)
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
				case 10 % IndexedDictionary.IT_KEY
					it_class = idict.get('IT_CLASS');
					category = Element.getPropCategory(it_class, value);
					format = Element.getPropFormat(it_class, value);
					if ~(any(format == [2 6]) && any(category == [1 3 4]))
					    error( ...
					        ['BRAPH2' ':IndexedDictionary:' 'WrongInput'], ...
					        ['BRAPH2' ':IndexedDictionary:' 'WrongInput' '\n' ...
					        'The format of property ''IT_KEY'' must be ''' int2str(2) ''' or ''' int2str(6) ''' (it is ''' int2str(format) ''').\n' ...
					        'Its category must be ''' int2str(1) ''', ''' int2str(3) ''' or ''' int2str(4) ''' (it is ''' int2str(category) ''').'] ...
					        )
					end
					
				case 11 % IndexedDictionary.IT_LIST
					if ~all(cellfun(@(x) isa(x, idict.get('IT_CLASS')), idict.get('IT_LIST')))
					    error( ...
					        ['BRAPH2' ':IndexedDictionary:' 'WrongInput'], ...
					        ['BRAPH2' ':IndexedDictionary:' 'WrongInput' '\n' ...
					        'All items of ''IT_LIST'' must be ' idict.get('IT_CLASS') '.'] ...
					        )
					end
					
				otherwise
					if prop <= 8
						value = preset@ConcreteElement(idict, prop, value);
					end
			end
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = IDICT.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = IDICT.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of IDICT.
			%  CHECK = Element.CHECKPROP(IndexedDictionary, PROP, VALUE) checks VALUE format for PROP of IndexedDictionary.
			%  CHECK = IDICT.CHECKPROP(IndexedDictionary, PROP, VALUE) checks VALUE format for PROP of IndexedDictionary.
			% 
			% IDICT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:IndexedDictionary:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IDICT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IDICT.
			%   Error id: BRAPH2:IndexedDictionary:WrongInput
			%  Element.CHECKPROP(IndexedDictionary, PROP, VALUE) throws error if VALUE has not a valid format for PROP of IndexedDictionary.
			%   Error id: BRAPH2:IndexedDictionary:WrongInput
			%  IDICT.CHECKPROP(IndexedDictionary, PROP, VALUE) throws error if VALUE has not a valid format for PROP of IndexedDictionary.
			%   Error id: BRAPH2:IndexedDictionary:WrongInput]
			% 
			% Note that the Element.CHECKPROP(IDICT) and Element.CHECKPROP('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			switch prop
				case 9 % IndexedDictionary.IT_CLASS
					check = Format.checkFormat(6, value, IndexedDictionary.getPropSettings(prop));
				case 10 % IndexedDictionary.IT_KEY
					check = Format.checkFormat(11, value, IndexedDictionary.getPropSettings(prop));
				case 11 % IndexedDictionary.IT_LIST
					check = Format.checkFormat(9, value, IndexedDictionary.getPropSettings(prop));
				case 12 % IndexedDictionary.LENGTH
					check = Format.checkFormat(11, value, IndexedDictionary.getPropSettings(prop));
				case 13 % IndexedDictionary.CONTAINS
					check = Format.checkFormat(4, value, IndexedDictionary.getPropSettings(prop));
				case 14 % IndexedDictionary.CONTAINS_INDEX
					check = Format.checkFormat(4, value, IndexedDictionary.getPropSettings(prop));
				case 15 % IndexedDictionary.CONTAINS_KEY
					check = Format.checkFormat(4, value, IndexedDictionary.getPropSettings(prop));
				case 16 % IndexedDictionary.CONTAINS_IT
					check = Format.checkFormat(4, value, IndexedDictionary.getPropSettings(prop));
				case 17 % IndexedDictionary.INDEX
					check = Format.checkFormat(11, value, IndexedDictionary.getPropSettings(prop));
				case 18 % IndexedDictionary.INDEX_FROM_KEY
					check = Format.checkFormat(11, value, IndexedDictionary.getPropSettings(prop));
				case 19 % IndexedDictionary.INDEX_FROM_IT
					check = Format.checkFormat(11, value, IndexedDictionary.getPropSettings(prop));
				case 20 % IndexedDictionary.KEYS
					check = Format.checkFormat(3, value, IndexedDictionary.getPropSettings(prop));
				case 21 % IndexedDictionary.KEY
					check = Format.checkFormat(2, value, IndexedDictionary.getPropSettings(prop));
				case 22 % IndexedDictionary.KEY_FROM_INDEX
					check = Format.checkFormat(2, value, IndexedDictionary.getPropSettings(prop));
				case 23 % IndexedDictionary.KEY_FROM_IT
					check = Format.checkFormat(2, value, IndexedDictionary.getPropSettings(prop));
				case 24 % IndexedDictionary.IT
					check = Format.checkFormat(8, value, IndexedDictionary.getPropSettings(prop));
				case 25 % IndexedDictionary.IT_FROM_INDEX
					check = Format.checkFormat(8, value, IndexedDictionary.getPropSettings(prop));
				case 26 % IndexedDictionary.IT_FROM_KEY
					check = Format.checkFormat(8, value, IndexedDictionary.getPropSettings(prop));
				case 27 % IndexedDictionary.ADD
					check = Format.checkFormat(1, value, IndexedDictionary.getPropSettings(prop));
				case 28 % IndexedDictionary.REMOVE
					check = Format.checkFormat(1, value, IndexedDictionary.getPropSettings(prop));
				case 29 % IndexedDictionary.REPLACE
					check = Format.checkFormat(1, value, IndexedDictionary.getPropSettings(prop));
				case 30 % IndexedDictionary.REPLACE_KEY
					check = Format.checkFormat(1, value, IndexedDictionary.getPropSettings(prop));
				case 31 % IndexedDictionary.REPLACE_IT
					check = Format.checkFormat(1, value, IndexedDictionary.getPropSettings(prop));
				case 32 % IndexedDictionary.INVERT
					check = Format.checkFormat(1, value, IndexedDictionary.getPropSettings(prop));
				case 33 % IndexedDictionary.MOVE_TO
					check = Format.checkFormat(1, value, IndexedDictionary.getPropSettings(prop));
				case 34 % IndexedDictionary.REMOVE_ALL
					check = Format.checkFormat(12, value, IndexedDictionary.getPropSettings(prop));
				case 35 % IndexedDictionary.MOVE_UP
					check = Format.checkFormat(12, value, IndexedDictionary.getPropSettings(prop));
				case 36 % IndexedDictionary.MOVE_DOWN
					check = Format.checkFormat(12, value, IndexedDictionary.getPropSettings(prop));
				case 37 % IndexedDictionary.MOVE_TO_TOP
					check = Format.checkFormat(1, value, IndexedDictionary.getPropSettings(prop));
				case 38 % IndexedDictionary.MOVE_TO_BOTTOM
					check = Format.checkFormat(12, value, IndexedDictionary.getPropSettings(prop));
				case 4 % IndexedDictionary.TEMPLATE
					check = Format.checkFormat(8, value, IndexedDictionary.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':IndexedDictionary:' 'WrongInput'], ...
					['BRAPH2' ':IndexedDictionary:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' IndexedDictionary.getPropTag(prop) ' (' IndexedDictionary.getFormatTag(IndexedDictionary.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(idict, prop, varargin)
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
				case 12 % IndexedDictionary.LENGTH
					value = length(idict.get('IT_LIST')); 
					% length = value
					
				case 13 % IndexedDictionary.CONTAINS
					% BOOL = idict.get('CONTAINS', POINTER) returns true if POINTER (index, key
					%  or item) exists in the indexed dictionary.
					if isempty(varargin)
					    value = false;
					    return
					end    
					pointer = varargin{1};
					
					if isa(pointer, 'numeric')  % pointer is index
					    value = idict.get('CONTAINS_INDEX', pointer);
					elseif isa(pointer, 'char')  % pointer is key
					    value = idict.get('CONTAINS_KEY', pointer);
					elseif isa(pointer, idict.get('IT_CLASS'))  % pointer is item - not necessarily unique
					    value = idict.get('CONTAINS_IT', pointer);
					else
					    value = false;
					end
					% bool = value
					
				case 14 % IndexedDictionary.CONTAINS_INDEX
					% BOOL = idict.get('CONTAINS_INDEX', INDEX) returns true if the INDEX exists in
					%  the indexed dictionary.
					if isempty(varargin)
					    value = false;
					    return
					end
					index = varargin{1};
					
					value = index >= 1 && index <= idict.get('LENGTH') && round(index) == index;
					% bool = value
					
				case 15 % IndexedDictionary.CONTAINS_KEY
					% BOOL = idict.get('CONTAINS_KEY', KEY) returns true if the KEY exists in
					%  the indexed dictionary.
					if isempty(varargin)
					    value = false;
					    return
					end
					key = varargin{1};
					
					it_key = idict.get('IT_KEY');
					value = any(cellfun(@(it) strcmp(it.get(it_key), key), idict.get('IT_LIST')));
					% bool = value
					
				case 16 % IndexedDictionary.CONTAINS_IT
					% BOOL = idict.get('CONTAINS_IT', IT) returns true if IT exists in
					%  the indexed dictionary.
					if isempty(varargin)
					    value = false;
					    return
					end
					item = varargin{1};
					
					value = any(cellfun(@(it) it == item, idict.get('IT_LIST')));
					% bool = value
					
				case 17 % IndexedDictionary.INDEX
					% INDEX = idict.get('INDEX', POINTER) returns the index of a POINTER (a key
					%  or item).
					if isempty(varargin)
					    value = -1;
					    return
					end
					pointer = varargin{1};
					
					if isa(pointer, 'numeric')  % pointer is index
					    value = pointer;
					elseif isa(pointer, 'char')  % pointer is key
					    value = idict.get('INDEX_FROM_KEY', pointer);
					elseif isa(pointer, idict.get('IT_CLASS'))  % pointer is item - not necessarily unique
					    value = idict.get('INDEX_FROM_IT', pointer);
					end
					% index = value
					
				case 18 % IndexedDictionary.INDEX_FROM_KEY
					% INDEX = idict.get('INDEX_FROM_KEY', KEY) returns the index of KEY.
					if isempty(varargin)
					    value = -1;
					    return
					end
					key = varargin{1};
					
					value = find(strcmp(key, idict.get('KEYS')));
					% index = value 
					% error if idict does not contain the key
					
				case 19 % IndexedDictionary.INDEX_FROM_IT
					% INDEX = idict.get('INDEX_FROM_IT', IT) returns the index of the first
					% occurrence of item IT.
					if isempty(varargin)
					    value = -1;
					    return
					end
					item = varargin{1};
					
					value = find(cellfun(@(it) it == item, idict.get('IT_LIST'))); % return the first occurrence
					% index = value 
					% error if idict does not contain the item
					
				case 20 % IndexedDictionary.KEYS
					it_key = idict.get('IT_KEY');
					value = cellfun(@(it) it.get(it_key), idict.get('IT_LIST'), 'UniformOutput', false);
					% keys = value
					
				case 21 % IndexedDictionary.KEY
					% KEY = idict.get('KEY', POINTER) returns the key of POINTER (an index or
					%  item). If the POINTER is an item, it returns the first occurrence.
					if isempty(varargin)
					    value = '';
					    return
					end
					pointer = varargin{1};
					
					if isa(pointer, idict.get('IT_CLASS'))  % pointer is item - not necessarily unique
					   value = idict.get('KEY_FROM_IT', pointer);  % first occurrence
					else  % pointer is an index
					    it_list = idict.get('IT_LIST');
					    value = it_list{pointer}.get(idict.get('IT_KEY'));
					end
					% key = value
					
				case 22 % IndexedDictionary.KEY_FROM_INDEX
					% KEY = idict.get('KEY_FROM_INDEX', INDEX) returns the key of INDEX.
					if isempty(varargin)
					    value = '';
					    return
					end
					index = varargin{1};
					
					it_list = idict.get('IT_LIST');
					value = it_list{index}.get(idict.get('IT_KEY'));
					% key = value % error if index does not exist
					
				case 23 % IndexedDictionary.KEY_FROM_IT
					% KEY = get('KEY_FROM_IT', IT) returns the key of the first occurrence
					%  of item IT.
					if isempty(varargin)
					    value = '';
					    return
					end
					item = varargin{1};
					
					it_list = idict.get('IT_LIST');
					value = it_list{idict.get('INDEX_FROM_IT', item)}.get(idict.get('IT_KEY'));
					% key = value % error if idict does not contain the item
					
				case 24 % IndexedDictionary.IT
					% IT = idict.get('IT', POINTER) returns the item of POINTER (an index or key).
					if isempty(varargin)
					    value = ConcreteElement();
					    return
					end
					pointer = varargin{1};
					
					if isa(pointer, 'char')  % pointer is a key
					    value = idict.get('IT_FROM_KEY', pointer);
					else  % pointer is an index
					    value = idict.get('IT_FROM_INDEX', pointer);
					end
					% item = value
					
				case 25 % IndexedDictionary.IT_FROM_INDEX
					% IT = idict.get('IT_FROM_INDEX', INDEX) returns the item of INDEX.
					if isempty(varargin)
					    value = ConcreteElement();
					    return
					end
					index = varargin{1};
					
					it_list = idict.get('IT_LIST');
					value = it_list{index};
					% item = value % error if the index does not exist
					
				case 26 % IndexedDictionary.IT_FROM_KEY
					% IT = idict.get('IT_FROM_KEY', KEY) returns the item of KEY.
					if isempty(varargin)
					    value = ConcreteElement();
					    return
					end
					key = varargin{1};
					
					it_list = idict.get('IT_LIST');
					value = it_list{idict.get('INDEX_FROM_KEY', key)};
					% item = value % error if idict does not contain the key
					
				case 27 % IndexedDictionary.ADD
					% idict.get('ADD', IT, INDEX) adds an item and key to the indexed
					%  dictionary in position INDEX. If INDEX is empty, it adds it to the end
					%  of IDICT.
					if isempty(varargin)
					    value = [];
					    return
					end
					item = varargin{1};
					if length(varargin) == 2
					    index = varargin{2};
					else
					    index = idict.get('LENGTH') + 1;
					end
					
					if index <= 0 || index > idict.get('LENGTH')
					    index = idict.get('LENGTH') + 1;
					end
					
					if ~isa(item, idict.get('IT_CLASS'))
					    error(...
					        ['BRAPH2' ':' class(idict) ':' 'WrongInput'], ...
					        ['BRAPH2' ':' class(idict) ':' 'WrongInput' '\n' ...
					        'Item must be an object of class ' idict.get('IT_CLASS') ',' ...
					        ' while it is of class ' class(item) '.'] ...
					        )
					end
					if idict.get('CONTAINS_KEY', item.get(idict.get('IT_KEY'))) % key = item.get(idict.get('IT_KEY'))
					    error( ...
					        ['BRAPH2' ':' class(idict) ':' 'WrongInput'], ...
					        ['BRAPH2' ':' class(idict) ':' 'WrongInput' '\n' ...
					        'Key ''' item.get(idict.get('IT_KEY')) ''' is already contained in the indexed dictionary.'] ... % key = item.get(idict.get('IT_KEY'))
					        )
					end
					
					it_list = idict.get('IT_LIST');
					if index <= idict.get('LENGTH')  
					    % create space for {key, item}
					    it_list(index + 1:end + 1) = it_list(index:end);
					    it_list{index} = item;
					else
					    it_list{end + 1} = item;
					end
					idict.set('IT_LIST', it_list)
					
					value = [];
					
				case 28 % IndexedDictionary.REMOVE
					% idict.get('REMOVE', POINTER) removes the key and item of POINTER (an
					%  index, key or item) from the indexed dictionary IDICT.
					if isempty(varargin)
					    value = [];
					    return
					end
					pointer = varargin{1};
					
					index = idict.get('INDEX', pointer);
					
					it_list = idict.get('IT_LIST');
					it_list(index) = [];
					idict.set('IT_LIST', it_list);
					
					value = [];
					
				case 29 % IndexedDictionary.REPLACE
					% idict.get('REPLACE', NEW_IT, INDEX) replaces the item and key of INDEX
					%  in the indexed dictionary IDICT with item NEW_IT.
					if isempty(varargin)
					    value = [];
					    return
					end
					new_item = varargin{1};
					index = varargin{2};
					
					if ~isa(new_item, idict.get('IT_CLASS'))
					    error( ...
					        ['BRAPH2' ':IndexedDictionary:' 'WrongInput'], ...
					        ['The item class must be ' idict.get('IT_CLASS') '.'] ...
					        )
					end
					
					if idict.get('CONTAINS', index)
					    idict.get('REMOVE', index)
					    idict.get('ADD', new_item, index)
					end
					
					value = [];
					
				case 30 % IndexedDictionary.REPLACE_KEY
					% idict.get('REPLACE_KEY', OLD_KEY, NEW_KEY) replaces OLD_KEY in the
					%  indexed dictionary IDICT with NEW_KEY.
					if isempty(varargin)
					    value = [];
					    return
					end
					old_key = varargin{1};
					new_key = varargin{2};
					
					if ~idict.get('CONTAINS', new_key)
					    item = idict.get('IT_FROM_KEY', old_key);
					    item.set(idict.get('IT_KEY'), new_key)
					end
					
					value = [];
					
				case 31 % IndexedDictionary.REPLACE_IT
					% idict.get('REPLACE_IT', OLD_IT, NEW_IT) replaces OLD_IT with
					%  NEW_IT in the indexed dictionary IDICT. It replaces only the first
					%  occurrence of OLD_IT.
					if isempty(varargin)
					    value = [];
					    return
					end
					old_it = varargin{1};
					new_it = varargin{2};
					
					index = idict.get('INDEX_FROM_IT', old_it);
					idict.get('REPLACE', new_it, index);
					
					value = [];
					
				case 32 % IndexedDictionary.INVERT
					% idict.get('INVERT', INDEXI, INDEXJ) inverts the positions of the items at
					%  INDEX_I and INDEX_J in the indexed dictionary IDICT.
					if isempty(varargin)
					    value = [];
					    return
					end
					i = varargin{1};
					j = varargin{2};
					
					if i > j
					    if i > 0 && i <= idict.get('LENGTH') && j > 0 && j <= idict.get('LENGTH') && i ~= j
					        item_i = idict.get('IT', i);
					        item_j = idict.get('IT', j);
					
					        idict.get('REMOVE', i)
					        idict.get('REMOVE', j)
					
					        idict.get('ADD', item_i, j);
					        idict.get('ADD', item_j, i);
					    end
					elseif i ~= j
					    idict.get('INVERT', j, i);
					end
					
					value = [];
					
				case 33 % IndexedDictionary.MOVE_TO
					% idict.get('MOVE_TO', OLD_INDEX, NEW_INDEX) moves an item from position
					%  OLD_INDEX to position NEW_INDEX in the indexed dictionary IDICT.
					if isempty(varargin)
					    value = [];
					    return
					end
					i = varargin{1};
					j = varargin{2};
					
					if i > 0 && i <= idict.get('LENGTH') && j > 0 && j <= idict.get('LENGTH') && i ~= j
					    item = idict.get('IT', i);
					    idict.get('REMOVE', i)
					    idict.get('ADD', item, j)
					end
					
					value = [];
					
				case 34 % IndexedDictionary.REMOVE_ALL
					% SELECTED = idict.get('REMOVE_ALL', SELECTED) removes all items whose
					%  positions in the indexed dictionary DICT are included in the array
					%  SELECTED. It returns an empty array.
					if isempty(varargin)
					    value = [];
					    return
					end
					selected = varargin{1};
					
					for i = length(selected):-1:1
					    idict.get('REMOVE', selected(i))
					end
					value = []; % selected = value;
					
				case 35 % IndexedDictionary.MOVE_UP
					% SELECTED = idict.get('MOVE_UP', SELECTED) moves up by one position all
					%  items whose positions in the indexed dictionary DICT are included in the
					%  SELECTED array and returns their final positions.
					if isempty(varargin)
					    value = [];
					    return
					end
					selected = varargin{1};
					
					if ~isempty(selected)
					    first_index_to_process = 1;
					    unprocessable_length = 1;
					    while first_index_to_process <= idict.get('LENGTH') ...
					            && first_index_to_process <= numel(selected) ...
					            && selected(first_index_to_process) == unprocessable_length
					        first_index_to_process = first_index_to_process + 1;
					        unprocessable_length = unprocessable_length + 1;
					    end
					
					    for i = first_index_to_process:1:numel(selected)
					        idict.get('INVERT', selected(i), selected(i)-1);
					        selected(i) = selected(i) - 1;
					    end
					end
					
					value = selected;
					
				case 36 % IndexedDictionary.MOVE_DOWN
					% SELECTED = idict.get('MOVE_DOWN', SELECTED) moves down by one position
					%  all items whose positions in the indexed dictionary DICT are included in
					%  the SELECTED array and returns their final positions.  
					if isempty(varargin)
					    value = [];
					    return
					end
					selected = varargin{1};
					
					if ~isempty(selected)
					    last_index_to_process = numel(selected);
					    unprocessable_length = idict.get('LENGTH');
					    while last_index_to_process > 0 ...
					            && selected(last_index_to_process) == unprocessable_length
					        last_index_to_process = last_index_to_process - 1;
					        unprocessable_length = unprocessable_length - 1;
					    end
					
					    for i = last_index_to_process:-1:1
					        idict.get('INVERT', selected(i), selected(i) + 1);
					        selected(i) = selected(i) + 1;
					    end
					end
					
					value = selected;
					
				case 37 % IndexedDictionary.MOVE_TO_TOP
					% SELECTED = idict.get('MOVE_TO_TOP', SELECTED) moves to top all items
					%  whose positions in the indexed dictionary DICT are included in the
					%  SELECTED array and returns their final positions.
					if isempty(varargin)
					    value = [];
					    return
					end
					selected = varargin{1};
					
					if ~isempty(selected)
					    for i = 1:1:numel(selected)
					        idict.get('MOVE_TO', selected(i), i);
					    end
					    selected = reshape(1:1:numel(selected), size(selected));
					end
					
					value = selected;
					
				case 38 % IndexedDictionary.MOVE_TO_BOTTOM
					% SELECTED = idict.get('MOVE_TO_BOTTOM', SELECTED) moves to bottom all
					%  items whose positions in the indexed dictionary DICT dictionary are
					%  included in the SELECTED array and returns their final positions.
					if isempty(varargin)
					    value = [];
					    return
					end
					selected = varargin{1};
					
					idict_length = idict.get('LENGTH');
					if ~isempty(selected)
					    for i = numel(selected):-1:1
					        idict.get('MOVE_TO', selected(i), idict_length - (numel(selected)-i));
					    end
					    selected = reshape(idict_length - numel(selected)+1:1:idict_length, size(selected));
					end
					
					value = selected;
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(idict, prop, varargin{:});
					else
						value = calculateValue@Element(idict, prop, varargin{:});
					end
			end
			
		end
	end
end
