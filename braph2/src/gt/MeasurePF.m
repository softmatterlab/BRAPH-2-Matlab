classdef MeasurePF < PanelFig
	%MeasurePF is the base element to plot the panel figure of the measure.
	% It is a subclass of <a href="matlab:help PanelFig">PanelFig</a>.
	%
	% A Panel Figure for Measure (MeasurePF) manages the basic functionalities to plot the panel figure of a measure.
	%
	% The list of MeasurePF properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel figure for measure (MeasurePF).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel figure for measure.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel figure for measure.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel figure for measure.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel figure for measure.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel figure for measure.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel figure for measure.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the figure measure.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel figure graph is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel.
	%  <strong>20</strong> <strong>ST_POSITION</strong> 	ST_POSITION (figure, item) determines the panel position.
	%  <strong>21</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.
	%  <strong>22</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
	%  <strong>23</strong> <strong>H_AXES</strong> 	H_AXES (evanescent, handle) is the handle for the axes.
	%  <strong>24</strong> <strong>ST_AXIS</strong> 	ST_AXIS (figure, item) determines the axis settings.
	%  <strong>25</strong> <strong>LISTENER_ST_AXIS</strong> 	LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.
	%  <strong>26</strong> <strong>M</strong> 	M (metadata, item) is the measure.
	%  <strong>27</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the measure value and stores it to be implemented in the subelements.
	%  <strong>28</strong> <strong>H_AREA</strong> 	H_AREA (evanescent, handle) is the handle for the measure area.
	%  <strong>29</strong> <strong>ST_AREA</strong> 	ST_AREA (figure, item) determines the area settings.
	%  <strong>30</strong> <strong>LISTENER_ST_AREA</strong> 	LISTENER_ST_AREA (evanescent, handle) contains the listener to the measure area settings to update the pushbutton.
	%  <strong>31</strong> <strong>H_LINE</strong> 	H_LINE (evanescent, handle) is the handle for the measure line.
	%  <strong>32</strong> <strong>ST_LINE</strong> 	ST_LINE (figure, item) determines the line settings.
	%  <strong>33</strong> <strong>LISTENER_ST_LINE</strong> 	LISTENER_ST_LINE (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.
	%  <strong>34</strong> <strong>H_TITLE</strong> 	H_TITLE (evanescent, handle) is the axis title.
	%  <strong>35</strong> <strong>ST_TITLE</strong> 	ST_TITLE (figure, item) determines the title settings.
	%  <strong>36</strong> <strong>H_XLABEL</strong> 	H_XLABEL (evanescent, handle) is the axis x-label.
	%  <strong>37</strong> <strong>ST_XLABEL</strong> 	ST_XLABEL (figure, item) determines the x-label settings.
	%  <strong>38</strong> <strong>H_YLABEL</strong> 	H_YLABEL (evanescent, handle) is the axis y-label.
	%  <strong>39</strong> <strong>ST_YLABEL</strong> 	ST_YLABEL (figure, item) determines the y-label settings.
	%
	% MeasurePF methods (constructor):
	%  MeasurePF - constructor
	%
	% MeasurePF methods:
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
	% MeasurePF methods (display):
	%  tostring - string with information about the panel figure for measure
	%  disp - displays information about the panel figure for measure
	%  tree - displays the tree of the panel figure for measure
	%
	% MeasurePF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for measure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for measure
	%
	% MeasurePF methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for measure as b2 file
	%  load - loads a BRAPH2 panel figure for measure from a b2 file
	%
	% MeasurePF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for measure
	%
	% MeasurePF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for measure
	%
	% MeasurePF methods (inspection, Static):
	%  getClass - returns the class of the panel figure for measure
	%  getSubclasses - returns all subclasses of MeasurePF
	%  getProps - returns the property list of the panel figure for measure
	%  getPropNumber - returns the property number of the panel figure for measure
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
	% MeasurePF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasurePF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasurePF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasurePF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasurePF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasurePF constants</a>.
	%
	%
	% See also Measure.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		H_AXES = 23; %CET: Computational Efficiency Trick
		H_AXES_TAG = 'H_AXES';
		H_AXES_CATEGORY = 7;
		H_AXES_FORMAT = 18;
		
		ST_AXIS = 24; %CET: Computational Efficiency Trick
		ST_AXIS_TAG = 'ST_AXIS';
		ST_AXIS_CATEGORY = 8;
		ST_AXIS_FORMAT = 8;
		
		LISTENER_ST_AXIS = 25; %CET: Computational Efficiency Trick
		LISTENER_ST_AXIS_TAG = 'LISTENER_ST_AXIS';
		LISTENER_ST_AXIS_CATEGORY = 7;
		LISTENER_ST_AXIS_FORMAT = 18;
		
		M = 26; %CET: Computational Efficiency Trick
		M_TAG = 'M';
		M_CATEGORY = 2;
		M_FORMAT = 8;
		
		SETUP = 27; %CET: Computational Efficiency Trick
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = 6;
		SETUP_FORMAT = 1;
		
		H_AREA = 28; %CET: Computational Efficiency Trick
		H_AREA_TAG = 'H_AREA';
		H_AREA_CATEGORY = 7;
		H_AREA_FORMAT = 18;
		
		ST_AREA = 29; %CET: Computational Efficiency Trick
		ST_AREA_TAG = 'ST_AREA';
		ST_AREA_CATEGORY = 8;
		ST_AREA_FORMAT = 8;
		
		LISTENER_ST_AREA = 30; %CET: Computational Efficiency Trick
		LISTENER_ST_AREA_TAG = 'LISTENER_ST_AREA';
		LISTENER_ST_AREA_CATEGORY = 7;
		LISTENER_ST_AREA_FORMAT = 18;
		
		H_LINE = 31; %CET: Computational Efficiency Trick
		H_LINE_TAG = 'H_LINE';
		H_LINE_CATEGORY = 7;
		H_LINE_FORMAT = 18;
		
		ST_LINE = 32; %CET: Computational Efficiency Trick
		ST_LINE_TAG = 'ST_LINE';
		ST_LINE_CATEGORY = 8;
		ST_LINE_FORMAT = 8;
		
		LISTENER_ST_LINE = 33; %CET: Computational Efficiency Trick
		LISTENER_ST_LINE_TAG = 'LISTENER_ST_LINE';
		LISTENER_ST_LINE_CATEGORY = 7;
		LISTENER_ST_LINE_FORMAT = 18;
		
		H_TITLE = 34; %CET: Computational Efficiency Trick
		H_TITLE_TAG = 'H_TITLE';
		H_TITLE_CATEGORY = 7;
		H_TITLE_FORMAT = 18;
		
		ST_TITLE = 35; %CET: Computational Efficiency Trick
		ST_TITLE_TAG = 'ST_TITLE';
		ST_TITLE_CATEGORY = 8;
		ST_TITLE_FORMAT = 8;
		
		H_XLABEL = 36; %CET: Computational Efficiency Trick
		H_XLABEL_TAG = 'H_XLABEL';
		H_XLABEL_CATEGORY = 7;
		H_XLABEL_FORMAT = 18;
		
		ST_XLABEL = 37; %CET: Computational Efficiency Trick
		ST_XLABEL_TAG = 'ST_XLABEL';
		ST_XLABEL_CATEGORY = 8;
		ST_XLABEL_FORMAT = 8;
		
		H_YLABEL = 38; %CET: Computational Efficiency Trick
		H_YLABEL_TAG = 'H_YLABEL';
		H_YLABEL_CATEGORY = 7;
		H_YLABEL_FORMAT = 18;
		
		ST_YLABEL = 39; %CET: Computational Efficiency Trick
		ST_YLABEL_TAG = 'ST_YLABEL';
		ST_YLABEL_CATEGORY = 8;
		ST_YLABEL_FORMAT = 8;
	end
	methods % constructor
		function pf = MeasurePF(varargin)
			%MeasurePF() creates a panel figure for measure.
			%
			% MeasurePF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasurePF(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of MeasurePF properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel figure for measure (MeasurePF).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel figure for measure.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel figure for measure.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel figure for measure.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel figure for measure.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel figure for measure.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel figure for measure.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the figure measure.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel figure graph is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel.
			%  <strong>20</strong> <strong>ST_POSITION</strong> 	ST_POSITION (figure, item) determines the panel position.
			%  <strong>21</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.
			%  <strong>22</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
			%  <strong>23</strong> <strong>H_AXES</strong> 	H_AXES (evanescent, handle) is the handle for the axes.
			%  <strong>24</strong> <strong>ST_AXIS</strong> 	ST_AXIS (figure, item) determines the axis settings.
			%  <strong>25</strong> <strong>LISTENER_ST_AXIS</strong> 	LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.
			%  <strong>26</strong> <strong>M</strong> 	M (metadata, item) is the measure.
			%  <strong>27</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the measure value and stores it to be implemented in the subelements.
			%  <strong>28</strong> <strong>H_AREA</strong> 	H_AREA (evanescent, handle) is the handle for the measure area.
			%  <strong>29</strong> <strong>ST_AREA</strong> 	ST_AREA (figure, item) determines the area settings.
			%  <strong>30</strong> <strong>LISTENER_ST_AREA</strong> 	LISTENER_ST_AREA (evanescent, handle) contains the listener to the measure area settings to update the pushbutton.
			%  <strong>31</strong> <strong>H_LINE</strong> 	H_LINE (evanescent, handle) is the handle for the measure line.
			%  <strong>32</strong> <strong>ST_LINE</strong> 	ST_LINE (figure, item) determines the line settings.
			%  <strong>33</strong> <strong>LISTENER_ST_LINE</strong> 	LISTENER_ST_LINE (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.
			%  <strong>34</strong> <strong>H_TITLE</strong> 	H_TITLE (evanescent, handle) is the axis title.
			%  <strong>35</strong> <strong>ST_TITLE</strong> 	ST_TITLE (figure, item) determines the title settings.
			%  <strong>36</strong> <strong>H_XLABEL</strong> 	H_XLABEL (evanescent, handle) is the axis x-label.
			%  <strong>37</strong> <strong>ST_XLABEL</strong> 	ST_XLABEL (figure, item) determines the x-label settings.
			%  <strong>38</strong> <strong>H_YLABEL</strong> 	H_YLABEL (evanescent, handle) is the axis y-label.
			%  <strong>39</strong> <strong>ST_YLABEL</strong> 	ST_YLABEL (figure, item) determines the y-label settings.
			%
			% See also Category, Format.
			
			pf = pf@PanelFig(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the panel figure for measure.
			%
			% BUILD = MeasurePF.GETBUILD() returns the build of 'MeasurePF'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PF.GETBUILD() returns the build of the panel figure for measure PF.
			%  BUILD = Element.GETBUILD(PF) returns the build of 'PF'.
			%  BUILD = Element.GETBUILD('MeasurePF') returns the build of 'MeasurePF'.
			%
			% Note that the Element.GETBUILD(PF) and Element.GETBUILD('MeasurePF')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pf_class = getClass()
			%GETCLASS returns the class of the panel figure for measure.
			%
			% CLASS = MeasurePF.GETCLASS() returns the class 'MeasurePF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for measure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('MeasurePF') returns 'MeasurePF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('MeasurePF')
			%  are less computationally efficient.
			
			pf_class = 'MeasurePF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for measure.
			%
			% LIST = MeasurePF.GETSUBCLASSES() returns all subclasses of 'MeasurePF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for measure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('MeasurePF') returns all subclasses of 'MeasurePF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('MeasurePF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'MeasurePF'  'MeasurePF_BB'  'MeasurePF_BS'  'MeasurePF_BU'  'MeasurePF_GB'  'MeasurePF_GS'  'MeasurePF_GU'  'MeasurePF_NB'  'MeasurePF_NS'  'MeasurePF_NU' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for measure.
			%
			% PROPS = MeasurePF.GETPROPS() returns the property list of panel figure for measure
			%  as a row vector.
			%
			% PROPS = MeasurePF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for measure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('MeasurePF'[, CATEGORY]) returns the property list of 'MeasurePF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 26];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = 5;
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 27];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 21 22 23 25 28 30 31 33 34 36 38];
				case 8 % Category.FIGURE
					prop_list = [14 20 24 29 32 35 37 39];
				case 9 % Category.GUI
					prop_list = [9 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for measure.
			%
			% N = MeasurePF.GETPROPNUMBER() returns the property number of panel figure for measure.
			%
			% N = MeasurePF.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for measure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for measure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('MeasurePF') returns the property number of 'MeasurePF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 39;
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
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 8;
				case 7 % Category.EVANESCENT
					prop_number = 13;
				case 8 % Category.FIGURE
					prop_number = 8;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for measure/error.
			%
			% CHECK = MeasurePF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(MeasurePF, PROP) checks whether PROP exists for MeasurePF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasurePF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF:WrongInput]
			%  Element.EXISTSPROP(MeasurePF, PROP) throws error if PROP does NOT exist for MeasurePF.
			%   Error id: [BRAPH2:MeasurePF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 39 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MeasurePF:' 'WrongInput'], ...
					['BRAPH2' ':MeasurePF:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasurePF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for measure/error.
			%
			% CHECK = MeasurePF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(MeasurePF, TAG) checks whether TAG exists for MeasurePF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasurePF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF:WrongInput]
			%  Element.EXISTSTAG(MeasurePF, TAG) throws error if TAG does NOT exist for MeasurePF.
			%   Error id: [BRAPH2:MeasurePF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'M'  'SETUP'  'H_AREA'  'ST_AREA'  'LISTENER_ST_AREA'  'H_LINE'  'ST_LINE'  'LISTENER_ST_LINE'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MeasurePF:' 'WrongInput'], ...
					['BRAPH2' ':MeasurePF:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for MeasurePF.'] ...
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
			%  PROPERTY = PF.GETPROPPROP(POINTER) returns property number of POINTER of PF.
			%  PROPERTY = Element.GETPROPPROP(MeasurePF, POINTER) returns property number of POINTER of MeasurePF.
			%  PROPERTY = PF.GETPROPPROP(MeasurePF, POINTER) returns property number of POINTER of MeasurePF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'M'  'SETUP'  'H_AREA'  'ST_AREA'  'LISTENER_ST_AREA'  'H_LINE'  'ST_LINE'  'LISTENER_ST_LINE'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = PF.GETPROPTAG(POINTER) returns tag of POINTER of PF.
			%  TAG = Element.GETPROPTAG(MeasurePF, POINTER) returns tag of POINTER of MeasurePF.
			%  TAG = PF.GETPROPTAG(MeasurePF, POINTER) returns tag of POINTER of MeasurePF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				measurepf_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'M'  'SETUP'  'H_AREA'  'ST_AREA'  'LISTENER_ST_AREA'  'H_LINE'  'ST_LINE'  'LISTENER_ST_LINE'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' };
				tag = measurepf_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = PF.GETPROPCATEGORY(POINTER) returns category of POINTER of PF.
			%  CATEGORY = Element.GETPROPCATEGORY(MeasurePF, POINTER) returns category of POINTER of MeasurePF.
			%  CATEGORY = PF.GETPROPCATEGORY(MeasurePF, POINTER) returns category of POINTER of MeasurePF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('MeasurePF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasurePF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measurepf_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  8  7  7  7  8  7  2  6  7  8  7  7  8  7  7  8  7  8  7  8 };
			prop_category = measurepf_category_list{prop};
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
			%  FORMAT = PF.GETPROPFORMAT(POINTER) returns format of POINTER of PF.
			%  FORMAT = Element.GETPROPFORMAT(MeasurePF, POINTER) returns format of POINTER of MeasurePF.
			%  FORMAT = PF.GETPROPFORMAT(MeasurePF, POINTER) returns format of POINTER of MeasurePF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('MeasurePF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasurePF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measurepf_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  8  18  19  18  8  18  8  1  18  8  18  18  8  18  18  8  18  8  18  8 };
			prop_format = measurepf_format_list{prop};
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
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PF.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasurePF, POINTER) returns description of POINTER of MeasurePF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(MeasurePF, POINTER) returns description of POINTER of MeasurePF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasurePF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measurepf_description_list = { 'ELCLASS (constant, string) is the class of the panel figure for measure (MeasurePF).'  'NAME (constant, string) is the name of the panel figure for measure.'  'DESCRIPTION (constant, string) is the description of the panel figure for measure.'  'TEMPLATE (parameter, item) is the template of the panel figure for measure.'  'ID (data, string) is a few-letter code for the panel figure for measure.'  'LABEL (metadata, string) is an extended label of the panel figure for measure.'  'NOTES (metadata, string) are some specific notes about the panel figure for measure.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the figure measure.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel.'  'HIDE (query, logical) hides the figure containing the panel.'  'DELETE (query, logical) resets the handles when the panel figure graph is deleted.'  'CLOSE (query, logical) closes the figure containing the panel.'  'ST_POSITION (figure, item) determines the panel position.'  'H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.'  'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.'  'H_AXES (evanescent, handle) is the handle for the axes.'  'ST_AXIS (figure, item) determines the axis settings.'  'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.'  'M (metadata, item) is the measure.'  'SETUP (query, empty) calculates the measure value and stores it to be implemented in the subelements.'  'H_AREA (evanescent, handle) is the handle for the measure area.'  'ST_AREA (figure, item) determines the area settings.'  'LISTENER_ST_AREA (evanescent, handle) contains the listener to the measure area settings to update the pushbutton.'  'H_LINE (evanescent, handle) is the handle for the measure line.'  'ST_LINE (figure, item) determines the line settings.'  'LISTENER_ST_LINE (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.'  'H_TITLE (evanescent, handle) is the axis title.'  'ST_TITLE (figure, item) determines the title settings.'  'H_XLABEL (evanescent, handle) is the axis x-label.'  'ST_XLABEL (figure, item) determines the x-label settings.'  'H_YLABEL (evanescent, handle) is the axis y-label.'  'ST_YLABEL (figure, item) determines the y-label settings.' };
			prop_description = measurepf_description_list{prop};
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
			%  SETTINGS = PF.GETPROPSETTINGS(POINTER) returns settings of POINTER of PF.
			%  SETTINGS = Element.GETPROPSETTINGS(MeasurePF, POINTER) returns settings of POINTER of MeasurePF.
			%  SETTINGS = PF.GETPROPSETTINGS(MeasurePF, POINTER) returns settings of POINTER of MeasurePF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasurePF.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 23 % MeasurePF.H_AXES
					prop_settings = Format.getFormatSettings(18);
				case 24 % MeasurePF.ST_AXIS
					prop_settings = 'SettingsAxis';
				case 25 % MeasurePF.LISTENER_ST_AXIS
					prop_settings = Format.getFormatSettings(18);
				case 26 % MeasurePF.M
					prop_settings = 'Measure';
				case 27 % MeasurePF.SETUP
					prop_settings = Format.getFormatSettings(1);
				case 28 % MeasurePF.H_AREA
					prop_settings = Format.getFormatSettings(18);
				case 29 % MeasurePF.ST_AREA
					prop_settings = 'SettingsArea';
				case 30 % MeasurePF.LISTENER_ST_AREA
					prop_settings = Format.getFormatSettings(18);
				case 31 % MeasurePF.H_LINE
					prop_settings = Format.getFormatSettings(18);
				case 32 % MeasurePF.ST_LINE
					prop_settings = 'SettingsLine';
				case 33 % MeasurePF.LISTENER_ST_LINE
					prop_settings = Format.getFormatSettings(18);
				case 34 % MeasurePF.H_TITLE
					prop_settings = Format.getFormatSettings(18);
				case 35 % MeasurePF.ST_TITLE
					prop_settings = 'SettingsText';
				case 36 % MeasurePF.H_XLABEL
					prop_settings = Format.getFormatSettings(18);
				case 37 % MeasurePF.ST_XLABEL
					prop_settings = 'SettingsText';
				case 38 % MeasurePF.H_YLABEL
					prop_settings = Format.getFormatSettings(18);
				case 39 % MeasurePF.ST_YLABEL
					prop_settings = 'SettingsText';
				case 4 % MeasurePF.TEMPLATE
					prop_settings = 'MeasurePF';
				otherwise
					prop_settings = getPropSettings@PanelFig(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasurePF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasurePF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasurePF, POINTER) returns the default value of POINTER of MeasurePF.
			%  DEFAULT = PF.GETPROPDEFAULT(MeasurePF, POINTER) returns the default value of POINTER of MeasurePF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasurePF.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 23 % MeasurePF.H_AXES
					prop_default = Format.getFormatDefault(18, MeasurePF.getPropSettings(prop));
				case 24 % MeasurePF.ST_AXIS
					prop_default = SettingsAxis('AXIS', true, 'GRID', false, 'EQUAL', false);
				case 25 % MeasurePF.LISTENER_ST_AXIS
					prop_default = Format.getFormatDefault(18, MeasurePF.getPropSettings(prop));
				case 26 % MeasurePF.M
					prop_default = Format.getFormatDefault(8, MeasurePF.getPropSettings(prop));
				case 27 % MeasurePF.SETUP
					prop_default = Format.getFormatDefault(1, MeasurePF.getPropSettings(prop));
				case 28 % MeasurePF.H_AREA
					prop_default = Format.getFormatDefault(18, MeasurePF.getPropSettings(prop));
				case 29 % MeasurePF.ST_AREA
					prop_default = Format.getFormatDefault(8, MeasurePF.getPropSettings(prop));
				case 30 % MeasurePF.LISTENER_ST_AREA
					prop_default = Format.getFormatDefault(18, MeasurePF.getPropSettings(prop));
				case 31 % MeasurePF.H_LINE
					prop_default = Format.getFormatDefault(18, MeasurePF.getPropSettings(prop));
				case 32 % MeasurePF.ST_LINE
					prop_default = Format.getFormatDefault(8, MeasurePF.getPropSettings(prop));
				case 33 % MeasurePF.LISTENER_ST_LINE
					prop_default = Format.getFormatDefault(18, MeasurePF.getPropSettings(prop));
				case 34 % MeasurePF.H_TITLE
					prop_default = Format.getFormatDefault(18, MeasurePF.getPropSettings(prop));
				case 35 % MeasurePF.ST_TITLE
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', 24, 'HALIGN', 'center', 'VALIGN', 'middle');
				case 36 % MeasurePF.H_XLABEL
					prop_default = Format.getFormatDefault(18, MeasurePF.getPropSettings(prop));
				case 37 % MeasurePF.ST_XLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', 24, 'HALIGN', 'center', 'VALIGN', 'middle');
				case 38 % MeasurePF.H_YLABEL
					prop_default = Format.getFormatDefault(18, MeasurePF.getPropSettings(prop));
				case 39 % MeasurePF.ST_YLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', 24, 'HALIGN', 'center', 'VALIGN', 'middle', 'ROTATION', 90);
				case 1 % MeasurePF.ELCLASS
					prop_default = 'MeasurePF';
				case 2 % MeasurePF.NAME
					prop_default = 'Panel Figure for Measure';
				case 3 % MeasurePF.DESCRIPTION
					prop_default = 'A Panel Figure for Measure (MeasurePF) manages the basic functionalities to plot of a measure.';
				case 4 % MeasurePF.TEMPLATE
					prop_default = Format.getFormatDefault(8, MeasurePF.getPropSettings(prop));
				case 5 % MeasurePF.ID
					prop_default = 'MeasurePF ID';
				case 6 % MeasurePF.LABEL
					prop_default = 'MeasurePF label';
				case 7 % MeasurePF.NOTES
					prop_default = 'MeasurePF notes';
				otherwise
					prop_default = getPropDefault@PanelFig(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasurePF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasurePF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasurePF, POINTER) returns the conditioned default value of POINTER of MeasurePF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(MeasurePF, POINTER) returns the conditioned default value of POINTER of MeasurePF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('MeasurePF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasurePF.getPropProp(pointer);
			
			prop_default = MeasurePF.conditioning(prop, MeasurePF.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PF.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PF.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PF.
			%  CHECK = Element.CHECKPROP(MeasurePF, PROP, VALUE) checks VALUE format for PROP of MeasurePF.
			%  CHECK = PF.CHECKPROP(MeasurePF, PROP, VALUE) checks VALUE format for PROP of MeasurePF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:MeasurePF:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: BRAPH2:MeasurePF:WrongInput
			%  Element.CHECKPROP(MeasurePF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasurePF.
			%   Error id: BRAPH2:MeasurePF:WrongInput
			%  PF.CHECKPROP(MeasurePF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasurePF.
			%   Error id: BRAPH2:MeasurePF:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('MeasurePF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasurePF.getPropProp(pointer);
			
			switch prop
				case 23 % MeasurePF.H_AXES
					check = Format.checkFormat(18, value, MeasurePF.getPropSettings(prop));
				case 24 % MeasurePF.ST_AXIS
					check = Format.checkFormat(8, value, MeasurePF.getPropSettings(prop));
				case 25 % MeasurePF.LISTENER_ST_AXIS
					check = Format.checkFormat(18, value, MeasurePF.getPropSettings(prop));
				case 26 % MeasurePF.M
					check = Format.checkFormat(8, value, MeasurePF.getPropSettings(prop));
				case 27 % MeasurePF.SETUP
					check = Format.checkFormat(1, value, MeasurePF.getPropSettings(prop));
				case 28 % MeasurePF.H_AREA
					check = Format.checkFormat(18, value, MeasurePF.getPropSettings(prop));
				case 29 % MeasurePF.ST_AREA
					check = Format.checkFormat(8, value, MeasurePF.getPropSettings(prop));
				case 30 % MeasurePF.LISTENER_ST_AREA
					check = Format.checkFormat(18, value, MeasurePF.getPropSettings(prop));
				case 31 % MeasurePF.H_LINE
					check = Format.checkFormat(18, value, MeasurePF.getPropSettings(prop));
				case 32 % MeasurePF.ST_LINE
					check = Format.checkFormat(8, value, MeasurePF.getPropSettings(prop));
				case 33 % MeasurePF.LISTENER_ST_LINE
					check = Format.checkFormat(18, value, MeasurePF.getPropSettings(prop));
				case 34 % MeasurePF.H_TITLE
					check = Format.checkFormat(18, value, MeasurePF.getPropSettings(prop));
				case 35 % MeasurePF.ST_TITLE
					check = Format.checkFormat(8, value, MeasurePF.getPropSettings(prop));
				case 36 % MeasurePF.H_XLABEL
					check = Format.checkFormat(18, value, MeasurePF.getPropSettings(prop));
				case 37 % MeasurePF.ST_XLABEL
					check = Format.checkFormat(8, value, MeasurePF.getPropSettings(prop));
				case 38 % MeasurePF.H_YLABEL
					check = Format.checkFormat(18, value, MeasurePF.getPropSettings(prop));
				case 39 % MeasurePF.ST_YLABEL
					check = Format.checkFormat(8, value, MeasurePF.getPropSettings(prop));
				case 4 % MeasurePF.TEMPLATE
					check = Format.checkFormat(8, value, MeasurePF.getPropSettings(prop));
				otherwise
					if prop <= 22
						check = checkProp@PanelFig(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MeasurePF:' 'WrongInput'], ...
					['BRAPH2' ':MeasurePF:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasurePF.getPropTag(prop) ' (' MeasurePF.getFormatTag(MeasurePF.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pf, prop)
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
				case 24 % MeasurePF.ST_AXIS
					if pf.get('DRAWN')
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
					        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
					    end
					end
					
				otherwise
					if prop <= 22
						postset@PanelFig(pf, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pf, prop, varargin)
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
				case 23 % MeasurePF.H_AXES
					h_axes = uiaxes( ...
					    'Parent', pf.memorize('H'), ...
					    'Tag', 'H_AXES', ...
					    'Units', 'normalized', ...
					    'OuterPosition', [.2 .2 .6 .6] ... % % % %TODO transform this into a prop?
					    );
					h_axes.Toolbar.Visible = 'off';
					h_axes.Interactions = [];
					box(h_axes, 'on')
					hold(h_axes, 'on')
					value = h_axes;
					
				case 25 % MeasurePF.LISTENER_ST_AXIS
					value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis);
					
				case 27 % MeasurePF.SETUP
					value = [];
					
				case 28 % MeasurePF.H_AREA
					value = fill(pf.get('H_AXES'), [0], [0], 'k');
					
				case 30 % MeasurePF.LISTENER_ST_AREA
					value = listener(pf.get('ST_AREA'), 'PropSet', @cb_listener_st_area);
					
				case 31 % MeasurePF.H_LINE
					value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);
					
				case 33 % MeasurePF.LISTENER_ST_LINE
					value = listener(pf.get('ST_LINE'), 'PropSet', @cb_listener_st_line);
					
				case 34 % MeasurePF.H_TITLE
					value = title(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_TITLE'), 'NoValue')
					    st = pf.memorize('ST_TITLE');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', pf.get('M').get('LABEL'), ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case 36 % MeasurePF.H_XLABEL
					value = xlabel(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_XLABEL'), 'NoValue')
					    st = pf.memorize('ST_XLABEL');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', 'Layer', ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case 38 % MeasurePF.H_YLABEL
					value = ylabel(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_YLABEL'), 'NoValue')
					    st = pf.memorize('ST_YLABEL');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', 'Measure Value', ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case 11 % MeasurePF.DRAW
					value = calculateValue@PanelFig(pf, 11, varargin{:}); % also warning
					if value
					    pf.memorize('H_AXES')
					
					    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', 23).get('SETUP')
					    pf.memorize('LISTENER_ST_AXIS');
					
					    pf.memorize('H_AREA')
					    pf.memorize('ST_AREA').set('PANEL', pf, 'PROP', 28).get('SETUP')
					    pf.memorize('LISTENER_ST_AREA');
					
					    pf.memorize('H_LINE')
					    pf.memorize('ST_LINE').set('PANEL', pf, 'PROP', 31).get('SETUP')
					    pf.memorize('LISTENER_ST_LINE');
					
					    pf.memorize('H_TITLE')
					    pf.memorize('ST_TITLE').set('PANEL', pf, 'PROP', 34).get('SETUP')
					
					    pf.memorize('H_XLABEL')
					    pf.memorize('ST_XLABEL').set('PANEL', pf, 'PROP', 36).get('SETUP')
					
					    pf.memorize('H_YLABEL')
					    pf.memorize('ST_YLABEL').set('PANEL', pf, 'PROP', 38).get('SETUP')
					
					    pf.get('SETUP')
					end
					
				case 18 % MeasurePF.DELETE
					value = calculateValue@PanelFig(pf, 18, varargin{:}); % also warning
					if value
					    pf.set('H_AXES', Element.getNoValue())
					
					    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
					    
					    pf.set('H_AREA', Element.getNoValue())
					    pf.set('LISTENER_ST_AREA', Element.getNoValue())
					 
					    pf.set('H_LINE', Element.getNoValue())
					    pf.set('LISTENER_ST_LINE', Element.getNoValue())
					
					    pf.set('H_TITLE', Element.getNoValue())
					
					    pf.set('H_XLABEL', Element.getNoValue())
					    
					    pf.set('H_YLABEL', Element.getNoValue())
					end
					
				case 22 % MeasurePF.H_TOOLS
					toolbar = pf.memorize('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    value = calculateValue@PanelFig(pf, 22);
					    
					    tool_separator_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % Axis
					    tool_axis = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Axis', ...
					        'Separator', 'on', ...
					        'State', pf.get('ST_AXIS').get('AXIS'), ...
					        'Tooltip', 'Show axis', ...
					        'CData', imread('icon_axis.png'), ...
					        'OnCallback', {@cb_axis, true}, ...
					        'OffCallback', {@cb_axis, false});
					
					    % Grid
					    tool_grid = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Grid', ...
					        'State', pf.get('ST_AXIS').get('GRID'), ...
					        'Tooltip', 'Show grid', ...
					        'CData', imread('icon_grid.png'), ...
					        'OnCallback', {@cb_grid, true}, ...
					        'OffCallback', {@cb_grid, false});
					
					    tool_separator_2 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % Measure Area
					    tool_area = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Area', ...
					        'State', pf.get('ST_AREA').get('VISIBLE'), ...
					        'Tooltip', 'Show measure area', ...
					        'CData', imread('icon_area.png'), ...
					        'OnCallback', {@cb_area, true}, ...
					        'OffCallback', {@cb_area, false});
					    
					    % Measure Line
					    tool_line = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Line', ...
					        'State', pf.get('ST_LINE').get('VISIBLE'), ...
					        'Tooltip', 'Show measure line', ...
					        'CData', imread('icon_line.png'), ...
					        'OnCallback', {@cb_line, true}, ...
					        'OffCallback', {@cb_line, false});
					
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_axis, tool_grid, ...
					        tool_separator_2, ...
					        tool_area, tool_line ...
					        };
					else
					    value = {};
					end
					
				otherwise
					if prop <= 22
						value = calculateValue@PanelFig(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
			function cb_listener_st_axis(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
			            set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
			        end
			    end
			end
			function cb_listener_st_area(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Area'), 'State', pf.get('ST_AREA').get('VISIBLE'))
			        end
			    end
			end
			function cb_listener_st_line(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Line'), 'State', pf.get('ST_LINE').get('VISIBLE'))
			        end
			    end
			end
			function cb_axis(~, ~, axis) % (src, event)
			    pf.get('ST_AXIS').set('AXIS', axis);
			    
			    % triggers the update of ST_AXIS
			    pf.set('ST_AXIS', pf.get('ST_AXIS'))
			end
			function cb_grid(~, ~, grid) % (src, event)
			    pf.get('ST_AXIS').set('GRID', grid);
			
			    % triggers the update of ST_AXIS
			    pf.set('ST_AXIS', pf.get('ST_AXIS'))
			end
			function cb_area(~, ~, visible) % (src, event)
			    pf.get('ST_AREA').set('VISIBLE', visible)
			
			    % triggers the update of ST_AREA
			    pf.set('ST_AREA', pf.get('ST_AREA'))
			end
			function cb_line(~, ~, visible) % (src, event)
				pf.get('ST_LINE').set('VISIBLE', visible)
			
			    % triggers the update of ST_LINE
			    pf.set('ST_LINE', pf.get('ST_LINE'))
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(pf, prop, varargin)
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
				case 24 % MeasurePF.ST_AXIS
					pr = SettingsAxisPP('EL', pf, 'PROP', 24, varargin{:});
					
				case 29 % MeasurePF.ST_AREA
					pr = SettingsAreaPP('EL', pf, 'PROP', 29, varargin{:});
					
				case 32 % MeasurePF.ST_LINE
					pr = SettingsLinePP('EL', pf, 'PROP', 32, varargin{:});
					
				case 35 % MeasurePF.ST_TITLE
					pr = SettingsTextPP('EL', pf, 'PROP', 35, varargin{:});
					
				case 37 % MeasurePF.ST_XLABEL
					pr = SettingsTextPP('EL', pf, 'PROP', 37, varargin{:});
					
				case 39 % MeasurePF.ST_YLABEL
					pr = SettingsTextPP('EL', pf, 'PROP', 39, varargin{:});
					
				otherwise
					pr = getPanelProp@PanelFig(pf, prop, varargin{:});
					
			end
		end
	end
end
