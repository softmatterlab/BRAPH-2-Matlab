classdef GraphHistPF < PanelFig
	%GraphHistPF is a plot of a graph histogram.
	% It is a subclass of <a href="matlab:help PanelFig">PanelFig</a>.
	%
	% A Panel Figure for Graph Histogram (GraphHistPF) manages the plot of the histogram of an adjaciency matrix.
	%
	% The list of GraphHistPF properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel figure for graph histogram (GraphHistPF).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel figure for graph histogram.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel figure for graph histogram.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel figure for graph histogram.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel figure for graph histogram.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel figure for graph histogram.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel figure for graph histogram.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the figure graph histogram.
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
	%  <strong>26</strong> <strong>G</strong> 	G (metadata, item) is the graph.
	%  <strong>27</strong> <strong>LAYERS</strong> 	LAYERS (figure, rvector) determines the indices of the layers.
	%  <strong>28</strong> <strong>LAYERLOCK</strong> 	LAYERLOCK (metadata, logical) is whether the two layers are locked so that only the diagonal is shown.
	%  <strong>29</strong> <strong>BINS</strong> 	BINS (figure, rvector) is the vector of bins.
	%  <strong>30</strong> <strong>DIAGONAL</strong> 	DIAGONAL (figure, option) excludes or includes the diagonal in the density calculation.
	%  <strong>31</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the histogram and density and stores them.
	%  <strong>32</strong> <strong>H_HIST_AREA</strong> 	H_HIST_AREA (evanescent, handle) is the handle for the histogram area.
	%  <strong>33</strong> <strong>ST_HIST_AREA</strong> 	ST_HIST_AREA (figure, item) determines the area settings.
	%  <strong>34</strong> <strong>LISTENER_ST_HIST_AREA</strong> 	LISTENER_ST_HIST_AREA (evanescent, handle) contains the listener to the histogram area settings to update the pushbutton.
	%  <strong>35</strong> <strong>H_DENSITY_LINE</strong> 	H_DENSITY_LINE (evanescent, handle) is the handle for the density line.
	%  <strong>36</strong> <strong>ST_DENSITY_LINE</strong> 	ST_DENSITY_LINE (figure, item) determines the line settings.
	%  <strong>37</strong> <strong>LISTENER_ST_DENSITY_LINE</strong> 	LISTENER_ST_DENSITY_LINE (evanescent, handle) contains the listener to the density line settings to update the pushbutton.
	%
	% GraphHistPF methods (constructor):
	%  GraphHistPF - constructor
	%
	% GraphHistPF methods:
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
	% GraphHistPF methods (display):
	%  tostring - string with information about the panel figure for graph histogram
	%  disp - displays information about the panel figure for graph histogram
	%  tree - displays the tree of the panel figure for graph histogram
	%
	% GraphHistPF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for graph histogram are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for graph histogram
	%
	% GraphHistPF methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for graph histogram as b2 file
	%  load - loads a BRAPH2 panel figure for graph histogram from a b2 file
	%
	% GraphHistPF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for graph histogram
	%
	% GraphHistPF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for graph histogram
	%
	% GraphHistPF methods (inspection, Static):
	%  getClass - returns the class of the panel figure for graph histogram
	%  getSubclasses - returns all subclasses of GraphHistPF
	%  getProps - returns the property list of the panel figure for graph histogram
	%  getPropNumber - returns the property number of the panel figure for graph histogram
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
	% GraphHistPF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GraphHistPF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GraphHistPF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GraphHistPF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GraphHistPF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GraphHistPF constants</a>.
	%
	%
	% See also Graph, GraphAdjPF.
	%
	% BUILD BRAPH2 6 class_name 1
	
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
		
		G = 26; %CET: Computational Efficiency Trick
		G_TAG = 'G';
		G_CATEGORY = 2;
		G_FORMAT = 8;
		
		LAYERS = 27; %CET: Computational Efficiency Trick
		LAYERS_TAG = 'LAYERS';
		LAYERS_CATEGORY = 8;
		LAYERS_FORMAT = 12;
		
		LAYERLOCK = 28; %CET: Computational Efficiency Trick
		LAYERLOCK_TAG = 'LAYERLOCK';
		LAYERLOCK_CATEGORY = 2;
		LAYERLOCK_FORMAT = 4;
		
		BINS = 29; %CET: Computational Efficiency Trick
		BINS_TAG = 'BINS';
		BINS_CATEGORY = 8;
		BINS_FORMAT = 12;
		
		DIAGONAL = 30; %CET: Computational Efficiency Trick
		DIAGONAL_TAG = 'DIAGONAL';
		DIAGONAL_CATEGORY = 8;
		DIAGONAL_FORMAT = 5;
		
		SETUP = 31; %CET: Computational Efficiency Trick
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = 6;
		SETUP_FORMAT = 1;
		
		H_HIST_AREA = 32; %CET: Computational Efficiency Trick
		H_HIST_AREA_TAG = 'H_HIST_AREA';
		H_HIST_AREA_CATEGORY = 7;
		H_HIST_AREA_FORMAT = 18;
		
		ST_HIST_AREA = 33; %CET: Computational Efficiency Trick
		ST_HIST_AREA_TAG = 'ST_HIST_AREA';
		ST_HIST_AREA_CATEGORY = 8;
		ST_HIST_AREA_FORMAT = 8;
		
		LISTENER_ST_HIST_AREA = 34; %CET: Computational Efficiency Trick
		LISTENER_ST_HIST_AREA_TAG = 'LISTENER_ST_HIST_AREA';
		LISTENER_ST_HIST_AREA_CATEGORY = 7;
		LISTENER_ST_HIST_AREA_FORMAT = 18;
		
		H_DENSITY_LINE = 35; %CET: Computational Efficiency Trick
		H_DENSITY_LINE_TAG = 'H_DENSITY_LINE';
		H_DENSITY_LINE_CATEGORY = 7;
		H_DENSITY_LINE_FORMAT = 18;
		
		ST_DENSITY_LINE = 36; %CET: Computational Efficiency Trick
		ST_DENSITY_LINE_TAG = 'ST_DENSITY_LINE';
		ST_DENSITY_LINE_CATEGORY = 8;
		ST_DENSITY_LINE_FORMAT = 8;
		
		LISTENER_ST_DENSITY_LINE = 37; %CET: Computational Efficiency Trick
		LISTENER_ST_DENSITY_LINE_TAG = 'LISTENER_ST_DENSITY_LINE';
		LISTENER_ST_DENSITY_LINE_CATEGORY = 7;
		LISTENER_ST_DENSITY_LINE_FORMAT = 18;
	end
	methods % constructor
		function pf = GraphHistPF(varargin)
			%GraphHistPF() creates a panel figure for graph histogram.
			%
			% GraphHistPF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GraphHistPF(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GraphHistPF properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel figure for graph histogram (GraphHistPF).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel figure for graph histogram.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel figure for graph histogram.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel figure for graph histogram.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel figure for graph histogram.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel figure for graph histogram.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel figure for graph histogram.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the figure graph histogram.
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
			%  <strong>26</strong> <strong>G</strong> 	G (metadata, item) is the graph.
			%  <strong>27</strong> <strong>LAYERS</strong> 	LAYERS (figure, rvector) determines the indices of the layers.
			%  <strong>28</strong> <strong>LAYERLOCK</strong> 	LAYERLOCK (metadata, logical) is whether the two layers are locked so that only the diagonal is shown.
			%  <strong>29</strong> <strong>BINS</strong> 	BINS (figure, rvector) is the vector of bins.
			%  <strong>30</strong> <strong>DIAGONAL</strong> 	DIAGONAL (figure, option) excludes or includes the diagonal in the density calculation.
			%  <strong>31</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the histogram and density and stores them.
			%  <strong>32</strong> <strong>H_HIST_AREA</strong> 	H_HIST_AREA (evanescent, handle) is the handle for the histogram area.
			%  <strong>33</strong> <strong>ST_HIST_AREA</strong> 	ST_HIST_AREA (figure, item) determines the area settings.
			%  <strong>34</strong> <strong>LISTENER_ST_HIST_AREA</strong> 	LISTENER_ST_HIST_AREA (evanescent, handle) contains the listener to the histogram area settings to update the pushbutton.
			%  <strong>35</strong> <strong>H_DENSITY_LINE</strong> 	H_DENSITY_LINE (evanescent, handle) is the handle for the density line.
			%  <strong>36</strong> <strong>ST_DENSITY_LINE</strong> 	ST_DENSITY_LINE (figure, item) determines the line settings.
			%  <strong>37</strong> <strong>LISTENER_ST_DENSITY_LINE</strong> 	LISTENER_ST_DENSITY_LINE (evanescent, handle) contains the listener to the density line settings to update the pushbutton.
			%
			% See also Category, Format.
			
			pf = pf@PanelFig(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the panel figure for graph histogram.
			%
			% BUILD = GraphHistPF.GETBUILD() returns the build of 'GraphHistPF'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PF.GETBUILD() returns the build of the panel figure for graph histogram PF.
			%  BUILD = Element.GETBUILD(PF) returns the build of 'PF'.
			%  BUILD = Element.GETBUILD('GraphHistPF') returns the build of 'GraphHistPF'.
			%
			% Note that the Element.GETBUILD(PF) and Element.GETBUILD('GraphHistPF')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pf_class = getClass()
			%GETCLASS returns the class of the panel figure for graph histogram.
			%
			% CLASS = GraphHistPF.GETCLASS() returns the class 'GraphHistPF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for graph histogram PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('GraphHistPF') returns 'GraphHistPF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('GraphHistPF')
			%  are less computationally efficient.
			
			pf_class = 'GraphHistPF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for graph histogram.
			%
			% LIST = GraphHistPF.GETSUBCLASSES() returns all subclasses of 'GraphHistPF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for graph histogram PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('GraphHistPF') returns all subclasses of 'GraphHistPF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GraphHistPF' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for graph histogram.
			%
			% PROPS = GraphHistPF.GETPROPS() returns the property list of panel figure for graph histogram
			%  as a row vector.
			%
			% PROPS = GraphHistPF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for graph histogram PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('GraphHistPF'[, CATEGORY]) returns the property list of 'GraphHistPF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 26 28];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = 5;
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 31];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 21 22 23 25 32 34 35 37];
				case 8 % Category.FIGURE
					prop_list = [14 20 24 27 29 30 33 36];
				case 9 % Category.GUI
					prop_list = [9 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for graph histogram.
			%
			% N = GraphHistPF.GETPROPNUMBER() returns the property number of panel figure for graph histogram.
			%
			% N = GraphHistPF.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for graph histogram
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for graph histogram PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('GraphHistPF') returns the property number of 'GraphHistPF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 37;
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
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 8;
				case 7 % Category.EVANESCENT
					prop_number = 10;
				case 8 % Category.FIGURE
					prop_number = 8;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for graph histogram/error.
			%
			% CHECK = GraphHistPF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(GraphHistPF, PROP) checks whether PROP exists for GraphHistPF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GraphHistPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:GraphHistPF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:GraphHistPF:WrongInput]
			%  Element.EXISTSPROP(GraphHistPF, PROP) throws error if PROP does NOT exist for GraphHistPF.
			%   Error id: [BRAPH2:GraphHistPF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 37 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GraphHistPF:' 'WrongInput'], ...
					['BRAPH2' ':GraphHistPF:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GraphHistPF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for graph histogram/error.
			%
			% CHECK = GraphHistPF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(GraphHistPF, TAG) checks whether TAG exists for GraphHistPF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GraphHistPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:GraphHistPF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:GraphHistPF:WrongInput]
			%  Element.EXISTSTAG(GraphHistPF, TAG) throws error if TAG does NOT exist for GraphHistPF.
			%   Error id: [BRAPH2:GraphHistPF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'G'  'LAYERS'  'LAYERLOCK'  'BINS'  'DIAGONAL'  'SETUP'  'H_HIST_AREA'  'ST_HIST_AREA'  'LISTENER_ST_HIST_AREA'  'H_DENSITY_LINE'  'ST_DENSITY_LINE'  'LISTENER_ST_DENSITY_LINE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GraphHistPF:' 'WrongInput'], ...
					['BRAPH2' ':GraphHistPF:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GraphHistPF.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GraphHistPF, POINTER) returns property number of POINTER of GraphHistPF.
			%  PROPERTY = PF.GETPROPPROP(GraphHistPF, POINTER) returns property number of POINTER of GraphHistPF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'G'  'LAYERS'  'LAYERLOCK'  'BINS'  'DIAGONAL'  'SETUP'  'H_HIST_AREA'  'ST_HIST_AREA'  'LISTENER_ST_HIST_AREA'  'H_DENSITY_LINE'  'ST_DENSITY_LINE'  'LISTENER_ST_DENSITY_LINE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(GraphHistPF, POINTER) returns tag of POINTER of GraphHistPF.
			%  TAG = PF.GETPROPTAG(GraphHistPF, POINTER) returns tag of POINTER of GraphHistPF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				graphhistpf_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'G'  'LAYERS'  'LAYERLOCK'  'BINS'  'DIAGONAL'  'SETUP'  'H_HIST_AREA'  'ST_HIST_AREA'  'LISTENER_ST_HIST_AREA'  'H_DENSITY_LINE'  'ST_DENSITY_LINE'  'LISTENER_ST_DENSITY_LINE' };
				tag = graphhistpf_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(GraphHistPF, POINTER) returns category of POINTER of GraphHistPF.
			%  CATEGORY = PF.GETPROPCATEGORY(GraphHistPF, POINTER) returns category of POINTER of GraphHistPF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GraphHistPF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			graphhistpf_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  8  7  7  7  8  7  2  8  2  8  8  6  7  8  7  7  8  7 };
			prop_category = graphhistpf_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(GraphHistPF, POINTER) returns format of POINTER of GraphHistPF.
			%  FORMAT = PF.GETPROPFORMAT(GraphHistPF, POINTER) returns format of POINTER of GraphHistPF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphHistPF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			graphhistpf_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  8  18  19  18  8  18  8  12  4  12  5  1  18  8  18  18  8  18 };
			prop_format = graphhistpf_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GraphHistPF, POINTER) returns description of POINTER of GraphHistPF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(GraphHistPF, POINTER) returns description of POINTER of GraphHistPF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphHistPF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			graphhistpf_description_list = { 'ELCLASS (constant, string) is the class of the panel figure for graph histogram (GraphHistPF).'  'NAME (constant, string) is the name of the panel figure for graph histogram.'  'DESCRIPTION (constant, string) is the description of the panel figure for graph histogram.'  'TEMPLATE (parameter, item) is the template of the panel figure for graph histogram.'  'ID (data, string) is a few-letter code for the panel figure for graph histogram.'  'LABEL (metadata, string) is an extended label of the panel figure for graph histogram.'  'NOTES (metadata, string) are some specific notes about the panel figure for graph histogram.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the figure graph histogram.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel.'  'HIDE (query, logical) hides the figure containing the panel.'  'DELETE (query, logical) resets the handles when the panel figure graph is deleted.'  'CLOSE (query, logical) closes the figure containing the panel.'  'ST_POSITION (figure, item) determines the panel position.'  'H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.'  'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.'  'H_AXES (evanescent, handle) is the handle for the axes.'  'ST_AXIS (figure, item) determines the axis settings.'  'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.'  'G (metadata, item) is the graph.'  'LAYERS (figure, rvector) determines the indices of the layers.'  'LAYERLOCK (metadata, logical) is whether the two layers are locked so that only the diagonal is shown.'  'BINS (figure, rvector) is the vector of bins.'  'DIAGONAL (figure, option) excludes or includes the diagonal in the density calculation.'  'SETUP (query, empty) calculates the histogram and density and stores them.'  'H_HIST_AREA (evanescent, handle) is the handle for the histogram area.'  'ST_HIST_AREA (figure, item) determines the area settings.'  'LISTENER_ST_HIST_AREA (evanescent, handle) contains the listener to the histogram area settings to update the pushbutton.'  'H_DENSITY_LINE (evanescent, handle) is the handle for the density line.'  'ST_DENSITY_LINE (figure, item) determines the line settings.'  'LISTENER_ST_DENSITY_LINE (evanescent, handle) contains the listener to the density line settings to update the pushbutton.' };
			prop_description = graphhistpf_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(GraphHistPF, POINTER) returns settings of POINTER of GraphHistPF.
			%  SETTINGS = PF.GETPROPSETTINGS(GraphHistPF, POINTER) returns settings of POINTER of GraphHistPF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GraphHistPF.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 23 % GraphHistPF.H_AXES
					prop_settings = Format.getFormatSettings(18);
				case 24 % GraphHistPF.ST_AXIS
					prop_settings = 'SettingsAxis';
				case 25 % GraphHistPF.LISTENER_ST_AXIS
					prop_settings = Format.getFormatSettings(18);
				case 26 % GraphHistPF.G
					prop_settings = 'Graph';
				case 27 % GraphHistPF.LAYERS
					prop_settings = Format.getFormatSettings(12);
				case 28 % GraphHistPF.LAYERLOCK
					prop_settings = Format.getFormatSettings(4);
				case 29 % GraphHistPF.BINS
					prop_settings = Format.getFormatSettings(12);
				case 30 % GraphHistPF.DIAGONAL
					prop_settings = {'exclude' 'include'};
				case 31 % GraphHistPF.SETUP
					prop_settings = Format.getFormatSettings(1);
				case 32 % GraphHistPF.H_HIST_AREA
					prop_settings = Format.getFormatSettings(18);
				case 33 % GraphHistPF.ST_HIST_AREA
					prop_settings = 'SettingsArea';
				case 34 % GraphHistPF.LISTENER_ST_HIST_AREA
					prop_settings = Format.getFormatSettings(18);
				case 35 % GraphHistPF.H_DENSITY_LINE
					prop_settings = Format.getFormatSettings(18);
				case 36 % GraphHistPF.ST_DENSITY_LINE
					prop_settings = 'SettingsLine';
				case 37 % GraphHistPF.LISTENER_ST_DENSITY_LINE
					prop_settings = Format.getFormatSettings(18);
				case 4 % GraphHistPF.TEMPLATE
					prop_settings = 'GraphHistPF';
				otherwise
					prop_settings = getPropSettings@PanelFig(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GraphHistPF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphHistPF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(GraphHistPF, POINTER) returns the default value of POINTER of GraphHistPF.
			%  DEFAULT = PF.GETPROPDEFAULT(GraphHistPF, POINTER) returns the default value of POINTER of GraphHistPF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GraphHistPF.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 23 % GraphHistPF.H_AXES
					prop_default = Format.getFormatDefault(18, GraphHistPF.getPropSettings(prop));
				case 24 % GraphHistPF.ST_AXIS
					prop_default = SettingsAxis('AXIS', true, 'GRID', false, 'EQUAL', false);
				case 25 % GraphHistPF.LISTENER_ST_AXIS
					prop_default = Format.getFormatDefault(18, GraphHistPF.getPropSettings(prop));
				case 26 % GraphHistPF.G
					prop_default = Format.getFormatDefault(8, GraphHistPF.getPropSettings(prop));
				case 27 % GraphHistPF.LAYERS
					prop_default = [1 1];
				case 28 % GraphHistPF.LAYERLOCK
					prop_default = false;
				case 29 % GraphHistPF.BINS
					prop_default = [-1:.1:1];
				case 30 % GraphHistPF.DIAGONAL
					prop_default = Format.getFormatDefault(5, GraphHistPF.getPropSettings(prop));
				case 31 % GraphHistPF.SETUP
					prop_default = Format.getFormatDefault(1, GraphHistPF.getPropSettings(prop));
				case 32 % GraphHistPF.H_HIST_AREA
					prop_default = Format.getFormatDefault(18, GraphHistPF.getPropSettings(prop));
				case 33 % GraphHistPF.ST_HIST_AREA
					prop_default = Format.getFormatDefault(8, GraphHistPF.getPropSettings(prop));
				case 34 % GraphHistPF.LISTENER_ST_HIST_AREA
					prop_default = Format.getFormatDefault(18, GraphHistPF.getPropSettings(prop));
				case 35 % GraphHistPF.H_DENSITY_LINE
					prop_default = Format.getFormatDefault(18, GraphHistPF.getPropSettings(prop));
				case 36 % GraphHistPF.ST_DENSITY_LINE
					prop_default = Format.getFormatDefault(8, GraphHistPF.getPropSettings(prop));
				case 37 % GraphHistPF.LISTENER_ST_DENSITY_LINE
					prop_default = Format.getFormatDefault(18, GraphHistPF.getPropSettings(prop));
				case 1 % GraphHistPF.ELCLASS
					prop_default = 'GraphHistPF';
				case 2 % GraphHistPF.NAME
					prop_default = 'Panel Figure for Graph Histogram';
				case 3 % GraphHistPF.DESCRIPTION
					prop_default = 'A Panel Figure for Graph Histogram (GraphHistPF) manages the plot of the histogram of an adjaciency matrix.';
				case 4 % GraphHistPF.TEMPLATE
					prop_default = Format.getFormatDefault(8, GraphHistPF.getPropSettings(prop));
				case 5 % GraphHistPF.ID
					prop_default = 'GraphHistPF ID';
				case 6 % GraphHistPF.LABEL
					prop_default = 'GraphHistPF label';
				case 7 % GraphHistPF.NOTES
					prop_default = 'GraphHistPF notes';
				otherwise
					prop_default = getPropDefault@PanelFig(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GraphHistPF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphHistPF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GraphHistPF, POINTER) returns the conditioned default value of POINTER of GraphHistPF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(GraphHistPF, POINTER) returns the conditioned default value of POINTER of GraphHistPF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GraphHistPF.getPropProp(pointer);
			
			prop_default = GraphHistPF.conditioning(prop, GraphHistPF.getPropDefault(prop));
		end
	end
	methods (Access=protected) % preset
		function value = preset(pf, prop, value)
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
				case 27 % GraphHistPF.LAYERS
					if pf.get('LAYERLOCK')
					    value = [value(1) value(1)];
					end
					
				otherwise
					if prop <= 22
						value = preset@PanelFig(pf, prop, value);
					end
			end
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
			%  CHECK = Element.CHECKPROP(GraphHistPF, PROP, VALUE) checks VALUE format for PROP of GraphHistPF.
			%  CHECK = PF.CHECKPROP(GraphHistPF, PROP, VALUE) checks VALUE format for PROP of GraphHistPF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GraphHistPF:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: BRAPH2:GraphHistPF:WrongInput
			%  Element.CHECKPROP(GraphHistPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphHistPF.
			%   Error id: BRAPH2:GraphHistPF:WrongInput
			%  PF.CHECKPROP(GraphHistPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphHistPF.
			%   Error id: BRAPH2:GraphHistPF:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GraphHistPF.getPropProp(pointer);
			
			switch prop
				case 23 % GraphHistPF.H_AXES
					check = Format.checkFormat(18, value, GraphHistPF.getPropSettings(prop));
				case 24 % GraphHistPF.ST_AXIS
					check = Format.checkFormat(8, value, GraphHistPF.getPropSettings(prop));
				case 25 % GraphHistPF.LISTENER_ST_AXIS
					check = Format.checkFormat(18, value, GraphHistPF.getPropSettings(prop));
				case 26 % GraphHistPF.G
					check = Format.checkFormat(8, value, GraphHistPF.getPropSettings(prop));
				case 27 % GraphHistPF.LAYERS
					check = Format.checkFormat(12, value, GraphHistPF.getPropSettings(prop));
				case 28 % GraphHistPF.LAYERLOCK
					check = Format.checkFormat(4, value, GraphHistPF.getPropSettings(prop));
				case 29 % GraphHistPF.BINS
					check = Format.checkFormat(12, value, GraphHistPF.getPropSettings(prop));
				case 30 % GraphHistPF.DIAGONAL
					check = Format.checkFormat(5, value, GraphHistPF.getPropSettings(prop));
				case 31 % GraphHistPF.SETUP
					check = Format.checkFormat(1, value, GraphHistPF.getPropSettings(prop));
				case 32 % GraphHistPF.H_HIST_AREA
					check = Format.checkFormat(18, value, GraphHistPF.getPropSettings(prop));
				case 33 % GraphHistPF.ST_HIST_AREA
					check = Format.checkFormat(8, value, GraphHistPF.getPropSettings(prop));
				case 34 % GraphHistPF.LISTENER_ST_HIST_AREA
					check = Format.checkFormat(18, value, GraphHistPF.getPropSettings(prop));
				case 35 % GraphHistPF.H_DENSITY_LINE
					check = Format.checkFormat(18, value, GraphHistPF.getPropSettings(prop));
				case 36 % GraphHistPF.ST_DENSITY_LINE
					check = Format.checkFormat(8, value, GraphHistPF.getPropSettings(prop));
				case 37 % GraphHistPF.LISTENER_ST_DENSITY_LINE
					check = Format.checkFormat(18, value, GraphHistPF.getPropSettings(prop));
				case 4 % GraphHistPF.TEMPLATE
					check = Format.checkFormat(8, value, GraphHistPF.getPropSettings(prop));
				otherwise
					if prop <= 22
						check = checkProp@PanelFig(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GraphHistPF:' 'WrongInput'], ...
					['BRAPH2' ':GraphHistPF:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GraphHistPF.getPropTag(prop) ' (' GraphHistPF.getFormatTag(GraphHistPF.getPropFormat(prop)) ').'] ...
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
				case 24 % GraphHistPF.ST_AXIS
					if pf.get('DRAWN')
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
					        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
					    end
					end
					
				case 27 % GraphHistPF.LAYERS
					pf.get('SETUP')
					
				case 28 % GraphHistPF.LAYERLOCK
					if pf.get('LAYERLOCK')
					    layers = pf.get('LAYERS');
					    if layers(1) ~= layers(2)
					        pf.set('LAYERS', [layers(1) layers(1)])
					    end
					end
					
				case 29 % GraphHistPF.BINS
					pf.get('SETUP')
					
				case 30 % GraphHistPF.DIAGONAL
					pf.get('SETUP')
					
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
				case 23 % GraphHistPF.H_AXES
					h_axes = uiaxes( ...
					    'Parent', pf.memorize('H'), ...
					    'Tag', 'H_AXES', ...
					    'Units', 'normalized', ...
					    'OuterPosition', [0 0 1 1] ...
					    );
					h_axes.Toolbar.Visible = 'off';
					h_axes.Interactions = [];
					box(h_axes, 'on')
					hold(h_axes, 'on')
					value = h_axes;
					
				case 25 % GraphHistPF.LISTENER_ST_AXIS
					value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis);
					
				case 31 % GraphHistPF.SETUP
					A = pf.get('G').get('A');
					if numel(A) <= 1
					    A = cell2mat(A);
					else
					    layers = pf.get('LAYERS');
					    A = A{layers(1), layers(2)};
					end
					
					[count, bins, density] = histogram(A, 'Bins', pf.get('BINS'), 'Diagonal', pf.get('DIAGONAL'));
					
					bins = [bins(1) bins bins(end)];
					count = [0 count 0];
					count = count / max(count) * 100;
					density = [100 density 0];
					
					pf.memorize('ST_HIST_AREA').set('X', bins, 'Y', count)
					
					pf.memorize('ST_DENSITY_LINE').set('X', bins, 'Y', density)
					
					if pf.get('ST_HIST_AREA').get('VISIBLE') && pf.get('ST_DENSITY_LINE').get('VISIBLE')
					    xlabel(pf.get('H_AXES'), 'coefficient value / threshold')
					    ylabel(pf.get('H_AXES'), 'coefficient percentage / density')
					elseif pf.get('ST_HIST_AREA').get('VISIBLE') && ~pf.get('ST_DENSITY_LINE').get('VISIBLE')
					    xlabel(pf.get('H_AXES'), 'coefficient value')
					    ylabel(pf.get('H_AXES'), 'coefficient percentage')
					elseif ~pf.get('ST_HIST_AREA').get('VISIBLE') && pf.get('ST_DENSITY_LINE').get('VISIBLE')
					    xlabel(pf.get('H_AXES'), 'threshold')
					    ylabel(pf.get('H_AXES'), 'density')
					else % ~pf.get('ST_HIST_AREA').get('VISIBLE') && ~pf.get('ST_DENSITY_LINE').get('VISIBLE')
					    xlabel(pf.get('H_AXES'), '')
					    ylabel(pf.get('H_AXES'), '')
					end
					
					value = [];
					
				case 32 % GraphHistPF.H_HIST_AREA
					value = fill(pf.get('H_AXES'), [0], [0], 'k');
					
				case 34 % GraphHistPF.LISTENER_ST_HIST_AREA
					value = listener(pf.get('ST_HIST_AREA'), 'PropSet', @cb_listener_st_hist_area);
					
				case 35 % GraphHistPF.H_DENSITY_LINE
					value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2, 'MarkerSize', 1);
					
				case 37 % GraphHistPF.LISTENER_ST_DENSITY_LINE
					value = listener(pf.get('ST_DENSITY_LINE'), 'PropSet', @cb_listener_st_density_line);
					
				case 11 % GraphHistPF.DRAW
					value = calculateValue@PanelFig(pf, 11, varargin{:}); % also warning
					if value
					    pf.memorize('H_AXES')
					    
					    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', 23).get('SETUP')
					    pf.memorize('LISTENER_ST_AXIS');
					    
					    pf.memorize('H_HIST_AREA')
					    pf.memorize('ST_HIST_AREA').set('PANEL', pf, 'PROP', 32).get('SETUP')
					    pf.memorize('LISTENER_ST_HIST_AREA');
					
					    pf.memorize('H_DENSITY_LINE')
					    pf.memorize('ST_DENSITY_LINE').set('PANEL', pf, 'PROP', 35).get('SETUP')
					    pf.memorize('LISTENER_ST_DENSITY_LINE');
					    
					    pf.get('SETUP')
					end
					
				case 18 % GraphHistPF.DELETE
					value = calculateValue@PanelFig(pf, 18, varargin{:}); % also warning
					if value
					    pf.set('H_AXES', Element.getNoValue())
					
					    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
					    
					    pf.set('H_HIST_AREA', Element.getNoValue())
					    pf.set('LISTENER_ST_HIST_AREA', Element.getNoValue())
					 
					    pf.set('H_DENSITY_LINE', Element.getNoValue())
					    pf.set('LISTENER_ST_DENSITY_LINE', Element.getNoValue())
					end
					
				case 22 % GraphHistPF.H_TOOLS
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
					
					    % Histogram Area
					    tool_hist_area = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.HistArea', ...
					        'State', pf.get('ST_HIST_AREA').get('VISIBLE'), ...
					        'Tooltip', 'Show histogram area', ...
					        'CData', imread('icon_area.png'), ...
					        'OnCallback', {@cb_hist_area, true}, ...
					        'OffCallback', {@cb_hist_area, false});
					    
					    % Histogram Line
					    tool_density_line = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.DensityLine', ...
					        'State', pf.get('ST_DENSITY_LINE').get('VISIBLE'), ...
					        'Tooltip', 'Show density line', ...
					        'CData', imread('icon_line.png'), ...
					        'OnCallback', {@cb_density_line, true}, ...
					        'OffCallback', {@cb_density_line, false});
					
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_axis, tool_grid, ...
					        tool_separator_2, ...
					        tool_hist_area, tool_density_line ...
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
			function cb_listener_st_hist_area(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.HistArea'), 'State', pf.get('ST_HIST_AREA').get('VISIBLE'))
			        end
			    end
			end
			function cb_listener_st_density_line(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.DensityLine'), 'State', pf.get('ST_DENSITY_LINE').get('VISIBLE'))
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
			function cb_hist_area(~, ~, visible) % (src, event)
			    pf.get('ST_HIST_AREA').set('VISIBLE', visible)
			
			    % triggers the update of ST_HIST_AREA
			    pf.set('ST_HIST_AREA', pf.get('ST_HIST_AREA'))
			end
			function cb_density_line(~, ~, visible) % (src, event)
				pf.get('ST_DENSITY_LINE').set('VISIBLE', visible)
			
			    % triggers the update of ST_DENSITY_LINE
			    pf.set('ST_DENSITY_LINE', pf.get('ST_DENSITY_LINE'))
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
				case 24 % GraphHistPF.ST_AXIS
					pr = SettingsAxisPP('EL', pf, 'PROP', 24, varargin{:});
					
				case 27 % GraphHistPF.LAYERS
					pr = LayersPP('EL', pf, 'PROP', 27, ...
					    'G_PROP', 26, ...
					    varargin{:});
					
				case 29 % GraphHistPF.BINS
					pr = PanelPropRVectorSmart('EL', pf, 'PROP', 29, 'MAX', 1, 'MIN', -1, varargin{:});
					
				case 33 % GraphHistPF.ST_HIST_AREA
					pr = SettingsAreaPP('EL', pf, 'PROP', 33, varargin{:});
					
				case 36 % GraphHistPF.ST_DENSITY_LINE
					pr = SettingsLinePP('EL', pf, 'PROP', 36, varargin{:});
					
				otherwise
					pr = getPanelProp@PanelFig(pf, prop, varargin{:});
					
			end
		end
	end
end
