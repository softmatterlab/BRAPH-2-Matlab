classdef MeasureEnsemblePF_GU < MeasureEnsemblePF
	%MeasureEnsemblePF_GU is the base element to plot a global unilayer group comparison figure.
	% It is a subclass of <a href="matlab:help MeasureEnsemblePF">MeasureEnsemblePF</a>.
	%
	% MeasureEnsemblePF_GU manages the basic functionalities to plot of a global unilayer group comparison figure.
	%
	% The list of MeasureEnsemblePF_GU properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the MeasureEnsemblePF_GU.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel figure global unilayer group comparison figure.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel figure global unilayer group comparison figure.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel figure global unilayer group comparison figure.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel figure global unilayer group comparison figure.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel figure global unilayer group comparison figure.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel figure global unilayer group comparison figure.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the figure comparison figure.
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
	%  <strong>26</strong> <strong>ME</strong> 	ME (metadata, item) is the ensemble-based comparison.
	%  <strong>27</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the group comparison figure value and stores it.
	%  <strong>28</strong> <strong>H_AREA</strong> 	H_AREA (evanescent, handle) is the handle for the ensemble-based comparison confidence area.
	%  <strong>29</strong> <strong>ST_AREA</strong> 	ST_AREA (figure, item) determines the area settings.
	%  <strong>30</strong> <strong>LISTENER_ST_AREA</strong> 	LISTENER_ST_AREA (evanescent, handle) contains the listener to the measure area settings to update the pushbutton.
	%  <strong>31</strong> <strong>H_LINE_M</strong> 	H_LINE_M (evanescent, handle) is the handle for the ensemble-based comparison line.
	%  <strong>32</strong> <strong>ST_LINE_M</strong> 	ST_LINE_M (figure, item) determines the line settings.
	%  <strong>33</strong> <strong>LISTENER_ST_LINE_M</strong> 	LISTENER_ST_LINE_M (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.
	%  <strong>34</strong> <strong>H_TITLE</strong> 	H_TITLE (evanescent, handle) is the axis title.
	%  <strong>35</strong> <strong>ST_TITLE</strong> 	ST_TITLE (figure, item) determines the title settings.
	%  <strong>36</strong> <strong>H_XLABEL</strong> 	H_XLABEL (evanescent, handle) is the axis x-label.
	%  <strong>37</strong> <strong>ST_XLABEL</strong> 	ST_XLABEL (figure, item) determines the x-label settings.
	%  <strong>38</strong> <strong>H_YLABEL</strong> 	H_YLABEL (evanescent, handle) is the axis y-label.
	%  <strong>39</strong> <strong>ST_YLABEL</strong> 	ST_YLABEL (figure, item) determines the y-label settings.
	%  <strong>40</strong> <strong>LAYER</strong> 	LAYER (figure, scalar) is the layer number of the global measure.
	%
	% MeasureEnsemblePF_GU methods (constructor):
	%  MeasureEnsemblePF_GU - constructor
	%
	% MeasureEnsemblePF_GU methods:
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
	% MeasureEnsemblePF_GU methods (display):
	%  tostring - string with information about the panel global unilayer group comparison figure
	%  disp - displays information about the panel global unilayer group comparison figure
	%  tree - displays the tree of the panel global unilayer group comparison figure
	%
	% MeasureEnsemblePF_GU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel global unilayer group comparison figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel global unilayer group comparison figure
	%
	% MeasureEnsemblePF_GU methods (save/load, Static):
	%  save - saves BRAPH2 panel global unilayer group comparison figure as b2 file
	%  load - loads a BRAPH2 panel global unilayer group comparison figure from a b2 file
	%
	% MeasureEnsemblePF_GU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel global unilayer group comparison figure
	%
	% MeasureEnsemblePF_GU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel global unilayer group comparison figure
	%
	% MeasureEnsemblePF_GU methods (inspection, Static):
	%  getClass - returns the class of the panel global unilayer group comparison figure
	%  getSubclasses - returns all subclasses of MeasureEnsemblePF_GU
	%  getProps - returns the property list of the panel global unilayer group comparison figure
	%  getPropNumber - returns the property number of the panel global unilayer group comparison figure
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
	% MeasureEnsemblePF_GU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasureEnsemblePF_GU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasureEnsemblePF_GU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasureEnsemblePF_GU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasureEnsemblePF_GU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasureEnsemblePF_GU constants</a>.
	%
	%
	% See also MeasureEnsemble.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		LAYER = 40; %CET: Computational Efficiency Trick
		LAYER_TAG = 'LAYER';
		LAYER_CATEGORY = 8;
		LAYER_FORMAT = 11;
	end
	methods % constructor
		function pf = MeasureEnsemblePF_GU(varargin)
			%MeasureEnsemblePF_GU() creates a panel global unilayer group comparison figure.
			%
			% MeasureEnsemblePF_GU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasureEnsemblePF_GU(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of MeasureEnsemblePF_GU properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the MeasureEnsemblePF_GU.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel figure global unilayer group comparison figure.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel figure global unilayer group comparison figure.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel figure global unilayer group comparison figure.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel figure global unilayer group comparison figure.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel figure global unilayer group comparison figure.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel figure global unilayer group comparison figure.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the figure comparison figure.
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
			%  <strong>26</strong> <strong>ME</strong> 	ME (metadata, item) is the ensemble-based comparison.
			%  <strong>27</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the group comparison figure value and stores it.
			%  <strong>28</strong> <strong>H_AREA</strong> 	H_AREA (evanescent, handle) is the handle for the ensemble-based comparison confidence area.
			%  <strong>29</strong> <strong>ST_AREA</strong> 	ST_AREA (figure, item) determines the area settings.
			%  <strong>30</strong> <strong>LISTENER_ST_AREA</strong> 	LISTENER_ST_AREA (evanescent, handle) contains the listener to the measure area settings to update the pushbutton.
			%  <strong>31</strong> <strong>H_LINE_M</strong> 	H_LINE_M (evanescent, handle) is the handle for the ensemble-based comparison line.
			%  <strong>32</strong> <strong>ST_LINE_M</strong> 	ST_LINE_M (figure, item) determines the line settings.
			%  <strong>33</strong> <strong>LISTENER_ST_LINE_M</strong> 	LISTENER_ST_LINE_M (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.
			%  <strong>34</strong> <strong>H_TITLE</strong> 	H_TITLE (evanescent, handle) is the axis title.
			%  <strong>35</strong> <strong>ST_TITLE</strong> 	ST_TITLE (figure, item) determines the title settings.
			%  <strong>36</strong> <strong>H_XLABEL</strong> 	H_XLABEL (evanescent, handle) is the axis x-label.
			%  <strong>37</strong> <strong>ST_XLABEL</strong> 	ST_XLABEL (figure, item) determines the x-label settings.
			%  <strong>38</strong> <strong>H_YLABEL</strong> 	H_YLABEL (evanescent, handle) is the axis y-label.
			%  <strong>39</strong> <strong>ST_YLABEL</strong> 	ST_YLABEL (figure, item) determines the y-label settings.
			%  <strong>40</strong> <strong>LAYER</strong> 	LAYER (figure, scalar) is the layer number of the global measure.
			%
			% See also Category, Format.
			
			pf = pf@MeasureEnsemblePF(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the panel global unilayer group comparison figure.
			%
			% BUILD = MeasureEnsemblePF_GU.GETBUILD() returns the build of 'MeasureEnsemblePF_GU'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PF.GETBUILD() returns the build of the panel global unilayer group comparison figure PF.
			%  BUILD = Element.GETBUILD(PF) returns the build of 'PF'.
			%  BUILD = Element.GETBUILD('MeasureEnsemblePF_GU') returns the build of 'MeasureEnsemblePF_GU'.
			%
			% Note that the Element.GETBUILD(PF) and Element.GETBUILD('MeasureEnsemblePF_GU')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pf_class = getClass()
			%GETCLASS returns the class of the panel global unilayer group comparison figure.
			%
			% CLASS = MeasureEnsemblePF_GU.GETCLASS() returns the class 'MeasureEnsemblePF_GU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel global unilayer group comparison figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('MeasureEnsemblePF_GU') returns 'MeasureEnsemblePF_GU'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('MeasureEnsemblePF_GU')
			%  are less computationally efficient.
			
			pf_class = 'MeasureEnsemblePF_GU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel global unilayer group comparison figure.
			%
			% LIST = MeasureEnsemblePF_GU.GETSUBCLASSES() returns all subclasses of 'MeasureEnsemblePF_GU'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel global unilayer group comparison figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('MeasureEnsemblePF_GU') returns all subclasses of 'MeasureEnsemblePF_GU'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('MeasureEnsemblePF_GU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'MeasureEnsemblePF_GU' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel global unilayer group comparison figure.
			%
			% PROPS = MeasureEnsemblePF_GU.GETPROPS() returns the property list of panel global unilayer group comparison figure
			%  as a row vector.
			%
			% PROPS = MeasureEnsemblePF_GU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel global unilayer group comparison figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('MeasureEnsemblePF_GU'[, CATEGORY]) returns the property list of 'MeasureEnsemblePF_GU'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('MeasureEnsemblePF_GU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40];
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
					prop_list = [14 20 24 29 32 35 37 39 40];
				case 9 % Category.GUI
					prop_list = [9 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel global unilayer group comparison figure.
			%
			% N = MeasureEnsemblePF_GU.GETPROPNUMBER() returns the property number of panel global unilayer group comparison figure.
			%
			% N = MeasureEnsemblePF_GU.GETPROPNUMBER(CATEGORY) returns the property number of panel global unilayer group comparison figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel global unilayer group comparison figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('MeasureEnsemblePF_GU') returns the property number of 'MeasureEnsemblePF_GU'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('MeasureEnsemblePF_GU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 40;
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
					prop_number = 9;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel global unilayer group comparison figure/error.
			%
			% CHECK = MeasureEnsemblePF_GU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(MeasureEnsemblePF_GU, PROP) checks whether PROP exists for MeasureEnsemblePF_GU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsemblePF_GU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsemblePF_GU:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsemblePF_GU:WrongInput]
			%  Element.EXISTSPROP(MeasureEnsemblePF_GU, PROP) throws error if PROP does NOT exist for MeasureEnsemblePF_GU.
			%   Error id: [BRAPH2:MeasureEnsemblePF_GU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('MeasureEnsemblePF_GU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 40 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MeasureEnsemblePF_GU:' 'WrongInput'], ...
					['BRAPH2' ':MeasureEnsemblePF_GU:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasureEnsemblePF_GU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel global unilayer group comparison figure/error.
			%
			% CHECK = MeasureEnsemblePF_GU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(MeasureEnsemblePF_GU, TAG) checks whether TAG exists for MeasureEnsemblePF_GU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsemblePF_GU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsemblePF_GU:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsemblePF_GU:WrongInput]
			%  Element.EXISTSTAG(MeasureEnsemblePF_GU, TAG) throws error if TAG does NOT exist for MeasureEnsemblePF_GU.
			%   Error id: [BRAPH2:MeasureEnsemblePF_GU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('MeasureEnsemblePF_GU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'ME'  'SETUP'  'H_AREA'  'ST_AREA'  'LISTENER_ST_AREA'  'H_LINE_M'  'ST_LINE_M'  'LISTENER_ST_LINE_M'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL'  'LAYER' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MeasureEnsemblePF_GU:' 'WrongInput'], ...
					['BRAPH2' ':MeasureEnsemblePF_GU:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for MeasureEnsemblePF_GU.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MeasureEnsemblePF_GU, POINTER) returns property number of POINTER of MeasureEnsemblePF_GU.
			%  PROPERTY = PF.GETPROPPROP(MeasureEnsemblePF_GU, POINTER) returns property number of POINTER of MeasureEnsemblePF_GU.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('MeasureEnsemblePF_GU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'ME'  'SETUP'  'H_AREA'  'ST_AREA'  'LISTENER_ST_AREA'  'H_LINE_M'  'ST_LINE_M'  'LISTENER_ST_LINE_M'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL'  'LAYER' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(MeasureEnsemblePF_GU, POINTER) returns tag of POINTER of MeasureEnsemblePF_GU.
			%  TAG = PF.GETPROPTAG(MeasureEnsemblePF_GU, POINTER) returns tag of POINTER of MeasureEnsemblePF_GU.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('MeasureEnsemblePF_GU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				measureensemblepf_gu_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'ME'  'SETUP'  'H_AREA'  'ST_AREA'  'LISTENER_ST_AREA'  'H_LINE_M'  'ST_LINE_M'  'LISTENER_ST_LINE_M'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL'  'LAYER' };
				tag = measureensemblepf_gu_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(MeasureEnsemblePF_GU, POINTER) returns category of POINTER of MeasureEnsemblePF_GU.
			%  CATEGORY = PF.GETPROPCATEGORY(MeasureEnsemblePF_GU, POINTER) returns category of POINTER of MeasureEnsemblePF_GU.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('MeasureEnsemblePF_GU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsemblePF_GU.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measureensemblepf_gu_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  8  7  7  7  8  7  2  6  7  8  7  7  8  7  7  8  7  8  7  8  8 };
			prop_category = measureensemblepf_gu_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(MeasureEnsemblePF_GU, POINTER) returns format of POINTER of MeasureEnsemblePF_GU.
			%  FORMAT = PF.GETPROPFORMAT(MeasureEnsemblePF_GU, POINTER) returns format of POINTER of MeasureEnsemblePF_GU.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('MeasureEnsemblePF_GU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsemblePF_GU.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measureensemblepf_gu_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  8  18  19  18  8  18  8  1  18  8  18  18  8  18  18  8  18  8  18  8  11 };
			prop_format = measureensemblepf_gu_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasureEnsemblePF_GU, POINTER) returns description of POINTER of MeasureEnsemblePF_GU.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(MeasureEnsemblePF_GU, POINTER) returns description of POINTER of MeasureEnsemblePF_GU.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('MeasureEnsemblePF_GU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsemblePF_GU.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measureensemblepf_gu_description_list = { 'ELCLASS (constant, string) is the class of the MeasureEnsemblePF_GU.'  'NAME (constant, string) is the name of the panel figure global unilayer group comparison figure.'  'DESCRIPTION (constant, string) is the description of the panel figure global unilayer group comparison figure.'  'TEMPLATE (parameter, item) is the template of the panel figure global unilayer group comparison figure.'  'ID (data, string) is a few-letter code for the panel figure global unilayer group comparison figure.'  'LABEL (metadata, string) is an extended label of the panel figure global unilayer group comparison figure.'  'NOTES (metadata, string) are some specific notes about the panel figure global unilayer group comparison figure.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the figure comparison figure.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel.'  'HIDE (query, logical) hides the figure containing the panel.'  'DELETE (query, logical) resets the handles when the panel figure graph is deleted.'  'CLOSE (query, logical) closes the figure containing the panel.'  'ST_POSITION (figure, item) determines the panel position.'  'H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.'  'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.'  'H_AXES (evanescent, handle) is the handle for the axes.'  'ST_AXIS (figure, item) determines the axis settings.'  'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.'  'ME (metadata, item) is the ensemble-based comparison.'  'SETUP (query, empty) calculates the group comparison figure value and stores it.'  'H_AREA (evanescent, handle) is the handle for the ensemble-based comparison confidence area.'  'ST_AREA (figure, item) determines the area settings.'  'LISTENER_ST_AREA (evanescent, handle) contains the listener to the measure area settings to update the pushbutton.'  'H_LINE_M (evanescent, handle) is the handle for the ensemble-based comparison line.'  'ST_LINE_M (figure, item) determines the line settings.'  'LISTENER_ST_LINE_M (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.'  'H_TITLE (evanescent, handle) is the axis title.'  'ST_TITLE (figure, item) determines the title settings.'  'H_XLABEL (evanescent, handle) is the axis x-label.'  'ST_XLABEL (figure, item) determines the x-label settings.'  'H_YLABEL (evanescent, handle) is the axis y-label.'  'ST_YLABEL (figure, item) determines the y-label settings.'  'LAYER (figure, scalar) is the layer number of the global measure.' };
			prop_description = measureensemblepf_gu_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(MeasureEnsemblePF_GU, POINTER) returns settings of POINTER of MeasureEnsemblePF_GU.
			%  SETTINGS = PF.GETPROPSETTINGS(MeasureEnsemblePF_GU, POINTER) returns settings of POINTER of MeasureEnsemblePF_GU.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('MeasureEnsemblePF_GU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsemblePF_GU.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 40 % MeasureEnsemblePF_GU.LAYER
					prop_settings = Format.getFormatSettings(11);
				case 4 % MeasureEnsemblePF_GU.TEMPLATE
					prop_settings = 'MeasureEnsemblePF_GU';
				otherwise
					prop_settings = getPropSettings@MeasureEnsemblePF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasureEnsemblePF_GU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsemblePF_GU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasureEnsemblePF_GU, POINTER) returns the default value of POINTER of MeasureEnsemblePF_GU.
			%  DEFAULT = PF.GETPROPDEFAULT(MeasureEnsemblePF_GU, POINTER) returns the default value of POINTER of MeasureEnsemblePF_GU.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('MeasureEnsemblePF_GU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureEnsemblePF_GU.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 40 % MeasureEnsemblePF_GU.LAYER
					prop_default = 1;
				case 1 % MeasureEnsemblePF_GU.ELCLASS
					prop_default = 'MeasureEnsemblePF_GU';
				case 2 % MeasureEnsemblePF_GU.NAME
					prop_default = 'MeasureEnsemblePF_GU';
				case 3 % MeasureEnsemblePF_GU.DESCRIPTION
					prop_default = 'MeasureEnsemblePF_GU manages the basic functionalities to plot of a global unilayer group comparison figure.';
				case 4 % MeasureEnsemblePF_GU.TEMPLATE
					prop_default = Format.getFormatDefault(8, MeasureEnsemblePF_GU.getPropSettings(prop));
				case 5 % MeasureEnsemblePF_GU.ID
					prop_default = 'MeasureEnsemblePF_GU ID';
				case 6 % MeasureEnsemblePF_GU.LABEL
					prop_default = 'MeasureEnsemblePF_GU label';
				case 7 % MeasureEnsemblePF_GU.NOTES
					prop_default = 'MeasureEnsemblePF_GU notes';
				otherwise
					prop_default = getPropDefault@MeasureEnsemblePF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasureEnsemblePF_GU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsemblePF_GU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasureEnsemblePF_GU, POINTER) returns the conditioned default value of POINTER of MeasureEnsemblePF_GU.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(MeasureEnsemblePF_GU, POINTER) returns the conditioned default value of POINTER of MeasureEnsemblePF_GU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('MeasureEnsemblePF_GU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasureEnsemblePF_GU.getPropProp(pointer);
			
			prop_default = MeasureEnsemblePF_GU.conditioning(prop, MeasureEnsemblePF_GU.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MeasureEnsemblePF_GU, PROP, VALUE) checks VALUE format for PROP of MeasureEnsemblePF_GU.
			%  CHECK = PF.CHECKPROP(MeasureEnsemblePF_GU, PROP, VALUE) checks VALUE format for PROP of MeasureEnsemblePF_GU.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:MeasureEnsemblePF_GU:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: BRAPH2:MeasureEnsemblePF_GU:WrongInput
			%  Element.CHECKPROP(MeasureEnsemblePF_GU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsemblePF_GU.
			%   Error id: BRAPH2:MeasureEnsemblePF_GU:WrongInput
			%  PF.CHECKPROP(MeasureEnsemblePF_GU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsemblePF_GU.
			%   Error id: BRAPH2:MeasureEnsemblePF_GU:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('MeasureEnsemblePF_GU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasureEnsemblePF_GU.getPropProp(pointer);
			
			switch prop
				case 40 % MeasureEnsemblePF_GU.LAYER
					check = Format.checkFormat(11, value, MeasureEnsemblePF_GU.getPropSettings(prop));
				case 4 % MeasureEnsemblePF_GU.TEMPLATE
					check = Format.checkFormat(8, value, MeasureEnsemblePF_GU.getPropSettings(prop));
				otherwise
					if prop <= 39
						check = checkProp@MeasureEnsemblePF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MeasureEnsemblePF_GU:' 'WrongInput'], ...
					['BRAPH2' ':MeasureEnsemblePF_GU:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasureEnsemblePF_GU.getPropTag(prop) ' (' MeasureEnsemblePF_GU.getFormatTag(MeasureEnsemblePF_GU.getPropFormat(prop)) ').'] ...
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
				case 40 % MeasureEnsemblePF_GU.LAYER
					pf.get('SETUP');
					
				otherwise
					if prop <= 39
						postset@MeasureEnsemblePF(pf, prop);
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
				case 27 % MeasureEnsemblePF_GU.SETUP
					me = pf.get('ME');
					if me.get('A').get('G_DICT').get('LENGTH')
					    g = me.get('A').get('G_DICT').get('IT', 1);
					else
					    g = me.get('A').get('GRAPH_TEMPLATE');
					end
					
					x = g.get('APARTITIONTICKS');
					
					layer = pf.get('LAYER');
					m = cell2mat(me.get('M'))';
					layers_num = length(g.get('ALAYERTICKS'));
					m2 = zeros(1, length(x));
					count=1;
					for i=layer:layers_num:g.get('LAYERNUMBER')
					    m2(count) = m(i);
					    count = count + 1;
					end
					pf.memorize('ST_LINE_M').set('X', x, 'Y', m2)
					
					xlim = pf.get('H_AXES').get('XLim');
					ylim = pf.get('H_AXES').get('YLim');
					pf.get('ST_TITLE').set( ...
					    'TXT', me.get('LABEL'), ...
					    'X', .5 * (xlim(2) + xlim(1)), ...
					    'Y', ylim(2) + .07 * (ylim(2) - ylim(1)), ...
					    'Z', 0 ...
					    )
					pf.get('ST_XLABEL').set( ...
					    'TXT', 'Partition', ...
					    'X', .5 * (xlim(2) + xlim(1)), ...
					    'Y', ylim(1) - .07 * (ylim(2) - ylim(1)), ...
					    'Z', 0 ...
					    )
					pf.get('ST_YLABEL').set( ...
						'TXT', 'Measure Value', ...
					    'X', xlim(1) - .14 * (xlim(2) - xlim(1)), ...
					    'Y', .5 * (ylim(2) + ylim(1)), ...
					    'Z', 0 ...
					    )
					
					value = [];
					
				otherwise
					if prop <= 39
						value = calculateValue@MeasureEnsemblePF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
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
				case 40 % MeasureEnsemblePF_GU.LAYER
					pr = MeasureEnsemblePF_xUPP_Layer('EL', pf, 'PROP', 40);
					
				otherwise
					pr = getPanelProp@MeasureEnsemblePF(pf, prop, varargin{:});
					
			end
		end
	end
end
