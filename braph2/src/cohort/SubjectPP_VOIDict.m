classdef SubjectPP_VOIDict < PanelProp
	%SubjectPP_VOIDict plots the panel for a VOI dictionary.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A VOI Prop Panel (SubjectPP_VOIDict) plots a VOI (variables of interest) dictionary using 
	%  numeric editfields and drop-down lists.
	% It is intended to be used with the property VOI_DICT of Subject.
	%
	% The list of SubjectPP_VOIDict properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the VOI prop panel.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the VOI prop panel.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the VOI prop panel.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the VOI prop panel.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the VOI prop panel.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the VOI prop panel.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the VOI prop panel.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.
	%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the property panel.
	%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the table.
	%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
	%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
	%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
	%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the prop panel.
	%  <strong>26</strong> <strong>TITLE</strong> 	TITLE (gui, string) is the property title.
	%  <strong>27</strong> <strong>LABEL_TITLE</strong> 	LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.
	%  <strong>28</strong> <strong>BUTTON_CB</strong> 	BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].
	%  <strong>29</strong> <strong>GUI_CB</strong> 	GUI_CB (data, item) is the handle to the item figure.
	%  <strong>30</strong> <strong>LISTENER_CB</strong> 	LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.
	%  <strong>31</strong> <strong>BUTTON_CALC</strong> 	BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].
	%  <strong>32</strong> <strong>BUTTON_DEL</strong> 	BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].
	%  <strong>33</strong> <strong>LISTENER_SET</strong> 	LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.
	%  <strong>34</strong> <strong>LISTENER_MEMORIZED</strong> 	LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.
	%  <strong>35</strong> <strong>LISTENER_LOCKED</strong> 	LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.
	%  <strong>36</strong> <strong>HEIGHT_MIN</strong> 	HEIGHT_MIN (gui, scalar) is the default (minumum) height.
	%  <strong>37</strong> <strong>HEIGHT_VOI_EDITFIELD</strong> 	HEIGHT_VOI_EDITFIELD (gui, scalar) is the height of each VOI editfield.
	%  <strong>38</strong> <strong>HEIGHT_VOI_DROPDOWN</strong> 	HEIGHT_VOI_DROPDOWN (gui, scalar) is the height of each VOI drop-down list.
	%  <strong>39</strong> <strong>ENABLE</strong> 	ENABLE (gui, logical) switches the editfields between active and inactive appearance when not editable.
	%  <strong>40</strong> <strong>HANDLES_VOI</strong> 	HANDLES_VOI (evanescent, handlelist) is the list of VOI numeric editfields and drop-down lists.
	%  <strong>41</strong> <strong>LABELS_VOI</strong> 	LABELS_VOI (evanescent, handlelist) is the list of VOI labels.
	%
	% SubjectPP_VOIDict methods (constructor):
	%  SubjectPP_VOIDict - constructor
	%
	% SubjectPP_VOIDict methods:
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
	% SubjectPP_VOIDict methods (display):
	%  tostring - string with information about the VOI prop panel
	%  disp - displays information about the VOI prop panel
	%  tree - displays the tree of the VOI prop panel
	%
	% SubjectPP_VOIDict methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two VOI prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the VOI prop panel
	%
	% SubjectPP_VOIDict methods (save/load, Static):
	%  save - saves BRAPH2 VOI prop panel as b2 file
	%  load - loads a BRAPH2 VOI prop panel from a b2 file
	%
	% SubjectPP_VOIDict method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the VOI prop panel
	%
	% SubjectPP_VOIDict method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the VOI prop panel
	%
	% SubjectPP_VOIDict methods (inspection, Static):
	%  getClass - returns the class of the VOI prop panel
	%  getSubclasses - returns all subclasses of SubjectPP_VOIDict
	%  getProps - returns the property list of the VOI prop panel
	%  getPropNumber - returns the property number of the VOI prop panel
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
	% SubjectPP_VOIDict methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SubjectPP_VOIDict methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SubjectPP_VOIDict methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SubjectPP_VOIDict methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SubjectPP_VOIDict; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SubjectPP_VOIDict constants</a>.
	%
	%
	% See also Subject, uieditfield, uidropdown.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		HEIGHT_MIN = 36; %CET: Computational Efficiency Trick
		HEIGHT_MIN_TAG = 'HEIGHT_MIN';
		HEIGHT_MIN_CATEGORY = 9;
		HEIGHT_MIN_FORMAT = 11;
		
		HEIGHT_VOI_EDITFIELD = 37; %CET: Computational Efficiency Trick
		HEIGHT_VOI_EDITFIELD_TAG = 'HEIGHT_VOI_EDITFIELD';
		HEIGHT_VOI_EDITFIELD_CATEGORY = 9;
		HEIGHT_VOI_EDITFIELD_FORMAT = 11;
		
		HEIGHT_VOI_DROPDOWN = 38; %CET: Computational Efficiency Trick
		HEIGHT_VOI_DROPDOWN_TAG = 'HEIGHT_VOI_DROPDOWN';
		HEIGHT_VOI_DROPDOWN_CATEGORY = 9;
		HEIGHT_VOI_DROPDOWN_FORMAT = 11;
		
		ENABLE = 39; %CET: Computational Efficiency Trick
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = 9;
		ENABLE_FORMAT = 4;
		
		HANDLES_VOI = 40; %CET: Computational Efficiency Trick
		HANDLES_VOI_TAG = 'HANDLES_VOI';
		HANDLES_VOI_CATEGORY = 7;
		HANDLES_VOI_FORMAT = 19;
		
		LABELS_VOI = 41; %CET: Computational Efficiency Trick
		LABELS_VOI_TAG = 'LABELS_VOI';
		LABELS_VOI_CATEGORY = 7;
		LABELS_VOI_FORMAT = 19;
	end
	methods % constructor
		function pr = SubjectPP_VOIDict(varargin)
			%SubjectPP_VOIDict() creates a VOI prop panel.
			%
			% SubjectPP_VOIDict(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SubjectPP_VOIDict(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SubjectPP_VOIDict properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the VOI prop panel.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the VOI prop panel.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the VOI prop panel.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the VOI prop panel.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the VOI prop panel.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the VOI prop panel.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the VOI prop panel.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.
			%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the property panel.
			%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the table.
			%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
			%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
			%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
			%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the prop panel.
			%  <strong>26</strong> <strong>TITLE</strong> 	TITLE (gui, string) is the property title.
			%  <strong>27</strong> <strong>LABEL_TITLE</strong> 	LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.
			%  <strong>28</strong> <strong>BUTTON_CB</strong> 	BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].
			%  <strong>29</strong> <strong>GUI_CB</strong> 	GUI_CB (data, item) is the handle to the item figure.
			%  <strong>30</strong> <strong>LISTENER_CB</strong> 	LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.
			%  <strong>31</strong> <strong>BUTTON_CALC</strong> 	BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].
			%  <strong>32</strong> <strong>BUTTON_DEL</strong> 	BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].
			%  <strong>33</strong> <strong>LISTENER_SET</strong> 	LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.
			%  <strong>34</strong> <strong>LISTENER_MEMORIZED</strong> 	LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.
			%  <strong>35</strong> <strong>LISTENER_LOCKED</strong> 	LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.
			%  <strong>36</strong> <strong>HEIGHT_MIN</strong> 	HEIGHT_MIN (gui, scalar) is the default (minumum) height.
			%  <strong>37</strong> <strong>HEIGHT_VOI_EDITFIELD</strong> 	HEIGHT_VOI_EDITFIELD (gui, scalar) is the height of each VOI editfield.
			%  <strong>38</strong> <strong>HEIGHT_VOI_DROPDOWN</strong> 	HEIGHT_VOI_DROPDOWN (gui, scalar) is the height of each VOI drop-down list.
			%  <strong>39</strong> <strong>ENABLE</strong> 	ENABLE (gui, logical) switches the editfields between active and inactive appearance when not editable.
			%  <strong>40</strong> <strong>HANDLES_VOI</strong> 	HANDLES_VOI (evanescent, handlelist) is the list of VOI numeric editfields and drop-down lists.
			%  <strong>41</strong> <strong>LABELS_VOI</strong> 	LABELS_VOI (evanescent, handlelist) is the list of VOI labels.
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the VOI prop panel.
			%
			% BUILD = SubjectPP_VOIDict.GETBUILD() returns the build of 'SubjectPP_VOIDict'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the VOI prop panel PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('SubjectPP_VOIDict') returns the build of 'SubjectPP_VOIDict'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('SubjectPP_VOIDict')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the VOI prop panel.
			%
			% CLASS = SubjectPP_VOIDict.GETCLASS() returns the class 'SubjectPP_VOIDict'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the VOI prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SubjectPP_VOIDict') returns 'SubjectPP_VOIDict'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SubjectPP_VOIDict')
			%  are less computationally efficient.
			
			pr_class = 'SubjectPP_VOIDict';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the VOI prop panel.
			%
			% LIST = SubjectPP_VOIDict.GETSUBCLASSES() returns all subclasses of 'SubjectPP_VOIDict'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the VOI prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SubjectPP_VOIDict') returns all subclasses of 'SubjectPP_VOIDict'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SubjectPP_VOIDict' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of VOI prop panel.
			%
			% PROPS = SubjectPP_VOIDict.GETPROPS() returns the property list of VOI prop panel
			%  as a row vector.
			%
			% PROPS = SubjectPP_VOIDict.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the VOI prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SubjectPP_VOIDict'[, CATEGORY]) returns the property list of 'SubjectPP_VOIDict'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41];
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
					prop_list = [5 23 24 29];
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 20 21 22];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 27 28 30 31 32 33 34 35 40 41];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36 37 38 39];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of VOI prop panel.
			%
			% N = SubjectPP_VOIDict.GETPROPNUMBER() returns the property number of VOI prop panel.
			%
			% N = SubjectPP_VOIDict.GETPROPNUMBER(CATEGORY) returns the property number of VOI prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the VOI prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SubjectPP_VOIDict') returns the property number of 'SubjectPP_VOIDict'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 41;
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
					prop_number = 4;
				case 6 % Category.QUERY
					prop_number = 10;
				case 7 % Category.EVANESCENT
					prop_number = 12;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 8;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in VOI prop panel/error.
			%
			% CHECK = SubjectPP_VOIDict.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SubjectPP_VOIDict, PROP) checks whether PROP exists for SubjectPP_VOIDict.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SubjectPP_VOIDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SubjectPP_VOIDict:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SubjectPP_VOIDict:WrongInput]
			%  Element.EXISTSPROP(SubjectPP_VOIDict, PROP) throws error if PROP does NOT exist for SubjectPP_VOIDict.
			%   Error id: [BRAPH2:SubjectPP_VOIDict:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 41 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SubjectPP_VOIDict:' 'WrongInput'], ...
					['BRAPH2' ':SubjectPP_VOIDict:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SubjectPP_VOIDict.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in VOI prop panel/error.
			%
			% CHECK = SubjectPP_VOIDict.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SubjectPP_VOIDict, TAG) checks whether TAG exists for SubjectPP_VOIDict.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SubjectPP_VOIDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SubjectPP_VOIDict:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SubjectPP_VOIDict:WrongInput]
			%  Element.EXISTSTAG(SubjectPP_VOIDict, TAG) throws error if TAG does NOT exist for SubjectPP_VOIDict.
			%   Error id: [BRAPH2:SubjectPP_VOIDict:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'HEIGHT_MIN'  'HEIGHT_VOI_EDITFIELD'  'HEIGHT_VOI_DROPDOWN'  'ENABLE'  'HANDLES_VOI'  'LABELS_VOI' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SubjectPP_VOIDict:' 'WrongInput'], ...
					['BRAPH2' ':SubjectPP_VOIDict:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SubjectPP_VOIDict.'] ...
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
			%  PROPERTY = PR.GETPROPPROP(POINTER) returns property number of POINTER of PR.
			%  PROPERTY = Element.GETPROPPROP(SubjectPP_VOIDict, POINTER) returns property number of POINTER of SubjectPP_VOIDict.
			%  PROPERTY = PR.GETPROPPROP(SubjectPP_VOIDict, POINTER) returns property number of POINTER of SubjectPP_VOIDict.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'HEIGHT_MIN'  'HEIGHT_VOI_EDITFIELD'  'HEIGHT_VOI_DROPDOWN'  'ENABLE'  'HANDLES_VOI'  'LABELS_VOI' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = PR.GETPROPTAG(POINTER) returns tag of POINTER of PR.
			%  TAG = Element.GETPROPTAG(SubjectPP_VOIDict, POINTER) returns tag of POINTER of SubjectPP_VOIDict.
			%  TAG = PR.GETPROPTAG(SubjectPP_VOIDict, POINTER) returns tag of POINTER of SubjectPP_VOIDict.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				subjectpp_voidict_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'HEIGHT_MIN'  'HEIGHT_VOI_EDITFIELD'  'HEIGHT_VOI_DROPDOWN'  'ENABLE'  'HANDLES_VOI'  'LABELS_VOI' };
				tag = subjectpp_voidict_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = PR.GETPROPCATEGORY(POINTER) returns category of POINTER of PR.
			%  CATEGORY = Element.GETPROPCATEGORY(SubjectPP_VOIDict, POINTER) returns category of POINTER of SubjectPP_VOIDict.
			%  CATEGORY = PR.GETPROPCATEGORY(SubjectPP_VOIDict, POINTER) returns category of POINTER of SubjectPP_VOIDict.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectPP_VOIDict.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			subjectpp_voidict_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  9  9  9  7  7 };
			prop_category = subjectpp_voidict_category_list{prop};
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
			%  FORMAT = PR.GETPROPFORMAT(POINTER) returns format of POINTER of PR.
			%  FORMAT = Element.GETPROPFORMAT(SubjectPP_VOIDict, POINTER) returns format of POINTER of SubjectPP_VOIDict.
			%  FORMAT = PR.GETPROPFORMAT(SubjectPP_VOIDict, POINTER) returns format of POINTER of SubjectPP_VOIDict.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectPP_VOIDict.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			subjectpp_voidict_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  11  11  11  4  19  19 };
			prop_format = subjectpp_voidict_format_list{prop};
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
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SubjectPP_VOIDict, POINTER) returns description of POINTER of SubjectPP_VOIDict.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SubjectPP_VOIDict, POINTER) returns description of POINTER of SubjectPP_VOIDict.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SubjectPP_VOIDict.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			subjectpp_voidict_description_list = { 'ELCLASS (constant, string) is the class of the VOI prop panel.'  'NAME (constant, string) is the name of the VOI prop panel.'  'DESCRIPTION (constant, string) is the description of the VOI prop panel.'  'TEMPLATE (parameter, item) is the template of the VOI prop panel.'  'ID (data, string) is a few-letter code for the VOI prop panel.'  'LABEL (metadata, string) is an extended label of the VOI prop panel.'  'NOTES (metadata, string) are some specific notes about the VOI prop panel.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the table.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the prop panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'HEIGHT_MIN (gui, scalar) is the default (minumum) height.'  'HEIGHT_VOI_EDITFIELD (gui, scalar) is the height of each VOI editfield.'  'HEIGHT_VOI_DROPDOWN (gui, scalar) is the height of each VOI drop-down list.'  'ENABLE (gui, logical) switches the editfields between active and inactive appearance when not editable.'  'HANDLES_VOI (evanescent, handlelist) is the list of VOI numeric editfields and drop-down lists.'  'LABELS_VOI (evanescent, handlelist) is the list of VOI labels.' };
			prop_description = subjectpp_voidict_description_list{prop};
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
			%  SETTINGS = PR.GETPROPSETTINGS(POINTER) returns settings of POINTER of PR.
			%  SETTINGS = Element.GETPROPSETTINGS(SubjectPP_VOIDict, POINTER) returns settings of POINTER of SubjectPP_VOIDict.
			%  SETTINGS = PR.GETPROPSETTINGS(SubjectPP_VOIDict, POINTER) returns settings of POINTER of SubjectPP_VOIDict.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SubjectPP_VOIDict.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % SubjectPP_VOIDict.HEIGHT_MIN
					prop_settings = Format.getFormatSettings(11);
				case 37 % SubjectPP_VOIDict.HEIGHT_VOI_EDITFIELD
					prop_settings = Format.getFormatSettings(11);
				case 38 % SubjectPP_VOIDict.HEIGHT_VOI_DROPDOWN
					prop_settings = Format.getFormatSettings(11);
				case 39 % SubjectPP_VOIDict.ENABLE
					prop_settings = Format.getFormatSettings(4);
				case 40 % SubjectPP_VOIDict.HANDLES_VOI
					prop_settings = Format.getFormatSettings(19);
				case 41 % SubjectPP_VOIDict.LABELS_VOI
					prop_settings = Format.getFormatSettings(19);
				case 4 % SubjectPP_VOIDict.TEMPLATE
					prop_settings = 'SubjectPP_VOIDict';
				case 23 % SubjectPP_VOIDict.EL
					prop_settings = 'Subject';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SubjectPP_VOIDict.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectPP_VOIDict.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SubjectPP_VOIDict, POINTER) returns the default value of POINTER of SubjectPP_VOIDict.
			%  DEFAULT = PR.GETPROPDEFAULT(SubjectPP_VOIDict, POINTER) returns the default value of POINTER of SubjectPP_VOIDict.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SubjectPP_VOIDict.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % SubjectPP_VOIDict.HEIGHT_MIN
					prop_default = 24;
				case 37 % SubjectPP_VOIDict.HEIGHT_VOI_EDITFIELD
					prop_default = 24;
				case 38 % SubjectPP_VOIDict.HEIGHT_VOI_DROPDOWN
					prop_default = 24;
				case 39 % SubjectPP_VOIDict.ENABLE
					prop_default = true;
				case 40 % SubjectPP_VOIDict.HANDLES_VOI
					prop_default = Format.getFormatDefault(19, SubjectPP_VOIDict.getPropSettings(prop));
				case 41 % SubjectPP_VOIDict.LABELS_VOI
					prop_default = Format.getFormatDefault(19, SubjectPP_VOIDict.getPropSettings(prop));
				case 1 % SubjectPP_VOIDict.ELCLASS
					prop_default = 'SubjectPP_VOIDict';
				case 2 % SubjectPP_VOIDict.NAME
					prop_default = 'VOI Prop Panel';
				case 3 % SubjectPP_VOIDict.DESCRIPTION
					prop_default = 'A VOI Prop Panel (SubjectPP_VOIDict) plots a VOI (variables of interest) dictionary using numeric editfields and drop-down lists. It is intended to be used with the property VOI_DICT of Subject.';
				case 4 % SubjectPP_VOIDict.TEMPLATE
					prop_default = Format.getFormatDefault(8, SubjectPP_VOIDict.getPropSettings(prop));
				case 5 % SubjectPP_VOIDict.ID
					prop_default = 'SubjectPP_VOIDict ID';
				case 6 % SubjectPP_VOIDict.LABEL
					prop_default = 'SubjectPP_VOIDict label';
				case 7 % SubjectPP_VOIDict.NOTES
					prop_default = 'SubjectPP_VOIDict notes';
				case 23 % SubjectPP_VOIDict.EL
					prop_default = Format.getFormatDefault(8, SubjectPP_VOIDict.getPropSettings(prop));
				case 24 % SubjectPP_VOIDict.PROP
					prop_default = 9;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SubjectPP_VOIDict.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SubjectPP_VOIDict.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SubjectPP_VOIDict, POINTER) returns the conditioned default value of POINTER of SubjectPP_VOIDict.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SubjectPP_VOIDict, POINTER) returns the conditioned default value of POINTER of SubjectPP_VOIDict.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SubjectPP_VOIDict.getPropProp(pointer);
			
			prop_default = SubjectPP_VOIDict.conditioning(prop, SubjectPP_VOIDict.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PR.
			%  CHECK = Element.CHECKPROP(SubjectPP_VOIDict, PROP, VALUE) checks VALUE format for PROP of SubjectPP_VOIDict.
			%  CHECK = PR.CHECKPROP(SubjectPP_VOIDict, PROP, VALUE) checks VALUE format for PROP of SubjectPP_VOIDict.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SubjectPP_VOIDict:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:SubjectPP_VOIDict:WrongInput
			%  Element.CHECKPROP(SubjectPP_VOIDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectPP_VOIDict.
			%   Error id: BRAPH2:SubjectPP_VOIDict:WrongInput
			%  PR.CHECKPROP(SubjectPP_VOIDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SubjectPP_VOIDict.
			%   Error id: BRAPH2:SubjectPP_VOIDict:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SubjectPP_VOIDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SubjectPP_VOIDict.getPropProp(pointer);
			
			switch prop
				case 36 % SubjectPP_VOIDict.HEIGHT_MIN
					check = Format.checkFormat(11, value, SubjectPP_VOIDict.getPropSettings(prop));
				case 37 % SubjectPP_VOIDict.HEIGHT_VOI_EDITFIELD
					check = Format.checkFormat(11, value, SubjectPP_VOIDict.getPropSettings(prop));
				case 38 % SubjectPP_VOIDict.HEIGHT_VOI_DROPDOWN
					check = Format.checkFormat(11, value, SubjectPP_VOIDict.getPropSettings(prop));
				case 39 % SubjectPP_VOIDict.ENABLE
					check = Format.checkFormat(4, value, SubjectPP_VOIDict.getPropSettings(prop));
				case 40 % SubjectPP_VOIDict.HANDLES_VOI
					check = Format.checkFormat(19, value, SubjectPP_VOIDict.getPropSettings(prop));
				case 41 % SubjectPP_VOIDict.LABELS_VOI
					check = Format.checkFormat(19, value, SubjectPP_VOIDict.getPropSettings(prop));
				case 4 % SubjectPP_VOIDict.TEMPLATE
					check = Format.checkFormat(8, value, SubjectPP_VOIDict.getPropSettings(prop));
				case 23 % SubjectPP_VOIDict.EL
					check = Format.checkFormat(8, value, SubjectPP_VOIDict.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SubjectPP_VOIDict:' 'WrongInput'], ...
					['BRAPH2' ':SubjectPP_VOIDict:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SubjectPP_VOIDict.getPropTag(prop) ' (' SubjectPP_VOIDict.getFormatTag(SubjectPP_VOIDict.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pr, prop, varargin)
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
				case 40 % SubjectPP_VOIDict.HANDLES_VOI
					sub = pr.get('EL');
					prop = pr.get('PROP');
					
					voi_dict = sub.get('VOI_DICT');
					handles_voi = cell(1, voi_dict.get('LENGTH'));
					for i = 1:1:voi_dict.get('LENGTH')
					    voi = voi_dict.get('IT', i);
					    
					    if isa(voi, 'VOICategoric')
					        dropdown = uidropdown( ...
					            'Parent', pr.memorize('H'), ... % H = p for Panel
					            'Tag', ['DROPDOWN ' int2str(i)], ... 
					            'Items', voi.get('CATEGORIES'), ...
					            'FontSize', 12, ...
					            'Tooltip', [num2str(sub.getPropProp(prop)) ' ' sub.getPropDescription(prop)], ...
					            'ValueChangedFcn', {@cb_voi_dropdown}, ...
					            'UserData', i ...
					            );
					
					        handles_voi{i} = dropdown;
					    else % isa(voi, 'VOINumeric')
					        editfield = uieditfield('numeric', ...
					            'Parent', pr.memorize('H'), ... % H = p for Panel
					            'Tag', ['EDITFIELD ' int2str(i)], ...
					            'FontSize', 12, ... 
					            'Tooltip', [num2str(sub.getPropProp(prop)) ' ' sub.getPropDescription(prop)], ...
					            'ValueChangedFcn', {@cb_voi_editfield}, ...
					            'UserData', i ...
					            );
					
					        handles_voi{i} = editfield;
					    end
					end
					
					value = handles_voi;
					
				case 41 % SubjectPP_VOIDict.LABELS_VOI
					sub = pr.get('EL');
					prop = pr.get('PROP');
					
					voi_dict = sub.get('VOI_DICT');
					labels_voi = cell(1, voi_dict.get('LENGTH'));
					for i = 1:1:voi_dict.get('LENGTH')
					    voi = voi_dict.get('IT', i);
					    
					    labels_voi{i} = uilabel( ...
					        'Parent', pr.memorize('H'), ...
					        'Tag', ['LABEL ' int2str(i)], ...
					        'Interpreter', 'html', ...
					        'FontSize', 12, ...
					        'HorizontalAlignment', 'right', ... 
					        'Tooltip', [num2str(sub.getPropProp(prop)) ' ' sub.getPropDescription(prop)], ...
					        'BackgroundColor', pr.get('BKGCOLOR') ...
					        );
					end
					
					value = labels_voi;
					
				case 20 % SubjectPP_VOIDict.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('HANDLES_VOI')
					    pr.memorize('LABELS_VOI')
					end
					
				case 21 % SubjectPP_VOIDict.UPDATE
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value
					    sub = pr.get('EL');
					
					    height = pr.get('HEIGHT_MIN');
					
					    voi_dict = sub.get('VOI_DICT');
						labels_voi = pr.get('LABELS_VOI');
					    handles_voi = pr.get('HANDLES_VOI');
					    for i = 1:1:voi_dict.get('LENGTH')
					        voi = voi_dict.get('IT', i);
					        
					        label = labels_voi{i};
					        set(label, 'Text', voi.get('ID'))
					        
					        if isa(voi, 'VOICategoric')
					            height = height + pr.get('HEIGHT_VOI_DROPDOWN');
					
					            dropdown = handles_voi{i};
					            
					            voi_categories = voi.get('CATEGORIES');
					            set(dropdown, 'Value', voi_categories{voi.get('V')})
					
					            prop_value = voi.getr('V');
					            if voi.isLocked('V') || isa(prop_value, 'Callback')
					                set(dropdown, 'Enable', 'off')
					            end
					        else % isa(voi, 'VOINumeric')
					            height = height + pr.get('HEIGHT_VOI_EDITFIELD');
					            
					            editfield = handles_voi{i};
					            
					            set(editfield, 'Value', voi.get('V'))
					
					            prop_value = voi.getr('V');
					            if voi.isLocked('V') || isa(prop_value, 'Callback')
					                set(editfield, ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					        end
					    end
					    
					    pr.set('HEIGHT', height)
					end
					
				case 22 % SubjectPP_VOIDict.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
						w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    sub = pr.get('EL');
					
					    h = 0;
					    
					    voi_dict = sub.get('VOI_DICT');
					    labels_voi = pr.get('LABELS_VOI');
					    handles_voi = pr.get('HANDLES_VOI');
					    for i = voi_dict.get('LENGTH'):-1:1
					        voi = voi_dict.get('IT', i);
					        
					        label = labels_voi{i};
					        set(label, 'Position', [4 h+4 .30*w_p-8 21])
					        
					        if isa(voi, 'VOICategoric')
					            dropdown = handles_voi{i};
					            
					            set(dropdown, 'Position', [.30*w_p h+4 .65*w_p 21])
					
					            h = h + pr.get('HEIGHT_VOI_DROPDOWN');
					        else % isa(voi, 'VOINumeric')
					            editfield = handles_voi{i};
					            
					            set(editfield, 'Position', [.30*w_p h+4 .45*w_p 21])
					            
					            h = h + pr.get('HEIGHT_VOI_EDITFIELD');
					        end
					    end
					end
					
				case 18 % SubjectPP_VOIDict.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('HANDLES_VOI', Element.getNoValue())
					    pr.set('LABELS_VOI', Element.getNoValue())
					end
					
				otherwise
					if prop <= 35
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_voi_editfield(src, ~)
			    i = get(src, 'UserData');
			
			    handles_voi = pr.get('HANDLES_VOI');
			    editfield = handles_voi{i};
			    
			    voi_dict = pr.get('EL').get(pr.get('PROP'));
			    voi = voi_dict.get('IT', i);
			    
			    voi.set('V', get(editfield, 'Value'))
			end
			function cb_voi_dropdown(src, ~)
			    i = get(src, 'UserData');
			
			    handles_voi = pr.get('HANDLES_VOI');
			    dropdown = handles_voi{i};
			    
			    voi_dict = pr.get('EL').get(pr.get('PROP'));
			    voi = voi_dict.get('IT', i);
			    
			    voi.set('V', find(strcmp(get(dropdown, 'Value'), voi.get('CATEGORIES'))))
			end
		end
	end
end
