classdef GraphAdjPF < PanelFig
	%GraphAdjPF is a plot of the panel figure for the graph adjacency matrix.
	% It is a subclass of <a href="matlab:help PanelFig">PanelFig</a>.
	%
	% A Panel Figure for Graph Adjacency Matrix (GraphAdjPF) manages the plot of the panel figure for the adjacency matrix.
	%
	% The list of GraphAdjPF properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel figure for graph adjacency matrix (GraphAdjPF).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel figure for graph adjacency matrix.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel figure for graph adjacency matrix.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel figure for graph adjacency matrix.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel figure for graph adjacency matrix.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel figure for graph adjacency matrix.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel figure for graph adjacency matrix.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the figure graph adjacency matrix.
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
	%  <strong>29</strong> <strong>COLORBAR</strong> 	COLORBAR (figure, logical) detemines whether to show the colorbar.
	%  <strong>30</strong> <strong>ST_AMBIENT</strong> 	ST_AMBIENT (figure, item) determines the ambient settings.
	%  <strong>31</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the adjacency matrix ans stores it.
	%  <strong>32</strong> <strong>H_ADJ</strong> 	H_ADJ (evanescent, handle) is the handle for weighted adjacency matrix.
	%
	% GraphAdjPF methods (constructor):
	%  GraphAdjPF - constructor
	%
	% GraphAdjPF methods:
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
	% GraphAdjPF methods (display):
	%  tostring - string with information about the panel figure for graph adjacency matrix
	%  disp - displays information about the panel figure for graph adjacency matrix
	%  tree - displays the tree of the panel figure for graph adjacency matrix
	%
	% GraphAdjPF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for graph adjacency matrix are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for graph adjacency matrix
	%
	% GraphAdjPF methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for graph adjacency matrix as b2 file
	%  load - loads a BRAPH2 panel figure for graph adjacency matrix from a b2 file
	%
	% GraphAdjPF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for graph adjacency matrix
	%
	% GraphAdjPF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for graph adjacency matrix
	%
	% GraphAdjPF methods (inspection, Static):
	%  getClass - returns the class of the panel figure for graph adjacency matrix
	%  getSubclasses - returns all subclasses of GraphAdjPF
	%  getProps - returns the property list of the panel figure for graph adjacency matrix
	%  getPropNumber - returns the property number of the panel figure for graph adjacency matrix
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
	% GraphAdjPF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GraphAdjPF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GraphAdjPF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GraphAdjPF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GraphAdjPF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GraphAdjPF constants</a>.
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
		
		COLORBAR = 29; %CET: Computational Efficiency Trick
		COLORBAR_TAG = 'COLORBAR';
		COLORBAR_CATEGORY = 8;
		COLORBAR_FORMAT = 4;
		
		ST_AMBIENT = 30; %CET: Computational Efficiency Trick
		ST_AMBIENT_TAG = 'ST_AMBIENT';
		ST_AMBIENT_CATEGORY = 8;
		ST_AMBIENT_FORMAT = 8;
		
		SETUP = 31; %CET: Computational Efficiency Trick
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = 6;
		SETUP_FORMAT = 1;
		
		H_ADJ = 32; %CET: Computational Efficiency Trick
		H_ADJ_TAG = 'H_ADJ';
		H_ADJ_CATEGORY = 7;
		H_ADJ_FORMAT = 18;
	end
	methods % constructor
		function pf = GraphAdjPF(varargin)
			%GraphAdjPF() creates a panel figure for graph adjacency matrix.
			%
			% GraphAdjPF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GraphAdjPF(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GraphAdjPF properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel figure for graph adjacency matrix (GraphAdjPF).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel figure for graph adjacency matrix.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel figure for graph adjacency matrix.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel figure for graph adjacency matrix.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel figure for graph adjacency matrix.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel figure for graph adjacency matrix.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel figure for graph adjacency matrix.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the figure graph adjacency matrix.
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
			%  <strong>29</strong> <strong>COLORBAR</strong> 	COLORBAR (figure, logical) detemines whether to show the colorbar.
			%  <strong>30</strong> <strong>ST_AMBIENT</strong> 	ST_AMBIENT (figure, item) determines the ambient settings.
			%  <strong>31</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the adjacency matrix ans stores it.
			%  <strong>32</strong> <strong>H_ADJ</strong> 	H_ADJ (evanescent, handle) is the handle for weighted adjacency matrix.
			%
			% See also Category, Format.
			
			pf = pf@PanelFig(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the panel figure for graph adjacency matrix.
			%
			% BUILD = GraphAdjPF.GETBUILD() returns the build of 'GraphAdjPF'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PF.GETBUILD() returns the build of the panel figure for graph adjacency matrix PF.
			%  BUILD = Element.GETBUILD(PF) returns the build of 'PF'.
			%  BUILD = Element.GETBUILD('GraphAdjPF') returns the build of 'GraphAdjPF'.
			%
			% Note that the Element.GETBUILD(PF) and Element.GETBUILD('GraphAdjPF')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pf_class = getClass()
			%GETCLASS returns the class of the panel figure for graph adjacency matrix.
			%
			% CLASS = GraphAdjPF.GETCLASS() returns the class 'GraphAdjPF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for graph adjacency matrix PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('GraphAdjPF') returns 'GraphAdjPF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('GraphAdjPF')
			%  are less computationally efficient.
			
			pf_class = 'GraphAdjPF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for graph adjacency matrix.
			%
			% LIST = GraphAdjPF.GETSUBCLASSES() returns all subclasses of 'GraphAdjPF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for graph adjacency matrix PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('GraphAdjPF') returns all subclasses of 'GraphAdjPF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GraphAdjPF' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for graph adjacency matrix.
			%
			% PROPS = GraphAdjPF.GETPROPS() returns the property list of panel figure for graph adjacency matrix
			%  as a row vector.
			%
			% PROPS = GraphAdjPF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for graph adjacency matrix PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('GraphAdjPF'[, CATEGORY]) returns the property list of 'GraphAdjPF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32];
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
					prop_list = [10 15 21 22 23 25 32];
				case 8 % Category.FIGURE
					prop_list = [14 20 24 27 29 30];
				case 9 % Category.GUI
					prop_list = [9 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for graph adjacency matrix.
			%
			% N = GraphAdjPF.GETPROPNUMBER() returns the property number of panel figure for graph adjacency matrix.
			%
			% N = GraphAdjPF.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for graph adjacency matrix
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for graph adjacency matrix PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('GraphAdjPF') returns the property number of 'GraphAdjPF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 32;
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
					prop_number = 7;
				case 8 % Category.FIGURE
					prop_number = 6;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for graph adjacency matrix/error.
			%
			% CHECK = GraphAdjPF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(GraphAdjPF, PROP) checks whether PROP exists for GraphAdjPF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GraphAdjPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:GraphAdjPF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:GraphAdjPF:WrongInput]
			%  Element.EXISTSPROP(GraphAdjPF, PROP) throws error if PROP does NOT exist for GraphAdjPF.
			%   Error id: [BRAPH2:GraphAdjPF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 32 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GraphAdjPF:' 'WrongInput'], ...
					['BRAPH2' ':GraphAdjPF:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GraphAdjPF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for graph adjacency matrix/error.
			%
			% CHECK = GraphAdjPF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(GraphAdjPF, TAG) checks whether TAG exists for GraphAdjPF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GraphAdjPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:GraphAdjPF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:GraphAdjPF:WrongInput]
			%  Element.EXISTSTAG(GraphAdjPF, TAG) throws error if TAG does NOT exist for GraphAdjPF.
			%   Error id: [BRAPH2:GraphAdjPF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'G'  'LAYERS'  'LAYERLOCK'  'COLORBAR'  'ST_AMBIENT'  'SETUP'  'H_ADJ' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GraphAdjPF:' 'WrongInput'], ...
					['BRAPH2' ':GraphAdjPF:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GraphAdjPF.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GraphAdjPF, POINTER) returns property number of POINTER of GraphAdjPF.
			%  PROPERTY = PF.GETPROPPROP(GraphAdjPF, POINTER) returns property number of POINTER of GraphAdjPF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'G'  'LAYERS'  'LAYERLOCK'  'COLORBAR'  'ST_AMBIENT'  'SETUP'  'H_ADJ' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(GraphAdjPF, POINTER) returns tag of POINTER of GraphAdjPF.
			%  TAG = PF.GETPROPTAG(GraphAdjPF, POINTER) returns tag of POINTER of GraphAdjPF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				graphadjpf_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'G'  'LAYERS'  'LAYERLOCK'  'COLORBAR'  'ST_AMBIENT'  'SETUP'  'H_ADJ' };
				tag = graphadjpf_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(GraphAdjPF, POINTER) returns category of POINTER of GraphAdjPF.
			%  CATEGORY = PF.GETPROPCATEGORY(GraphAdjPF, POINTER) returns category of POINTER of GraphAdjPF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GraphAdjPF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			graphadjpf_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  8  7  7  7  8  7  2  8  2  8  8  6  7 };
			prop_category = graphadjpf_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(GraphAdjPF, POINTER) returns format of POINTER of GraphAdjPF.
			%  FORMAT = PF.GETPROPFORMAT(GraphAdjPF, POINTER) returns format of POINTER of GraphAdjPF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphAdjPF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			graphadjpf_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  8  18  19  18  8  18  8  12  4  4  8  1  18 };
			prop_format = graphadjpf_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GraphAdjPF, POINTER) returns description of POINTER of GraphAdjPF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(GraphAdjPF, POINTER) returns description of POINTER of GraphAdjPF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphAdjPF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			graphadjpf_description_list = { 'ELCLASS (constant, string) is the class of the panel figure for graph adjacency matrix (GraphAdjPF).'  'NAME (constant, string) is the name of the panel figure for graph adjacency matrix.'  'DESCRIPTION (constant, string) is the description of the panel figure for graph adjacency matrix.'  'TEMPLATE (parameter, item) is the template of the panel figure for graph adjacency matrix.'  'ID (data, string) is a few-letter code for the panel figure for graph adjacency matrix.'  'LABEL (metadata, string) is an extended label of the panel figure for graph adjacency matrix.'  'NOTES (metadata, string) are some specific notes about the panel figure for graph adjacency matrix.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the figure graph adjacency matrix.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel.'  'HIDE (query, logical) hides the figure containing the panel.'  'DELETE (query, logical) resets the handles when the panel figure graph is deleted.'  'CLOSE (query, logical) closes the figure containing the panel.'  'ST_POSITION (figure, item) determines the panel position.'  'H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.'  'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.'  'H_AXES (evanescent, handle) is the handle for the axes.'  'ST_AXIS (figure, item) determines the axis settings.'  'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.'  'G (metadata, item) is the graph.'  'LAYERS (figure, rvector) determines the indices of the layers.'  'LAYERLOCK (metadata, logical) is whether the two layers are locked so that only the diagonal is shown.'  'COLORBAR (figure, logical) detemines whether to show the colorbar.'  'ST_AMBIENT (figure, item) determines the ambient settings.'  'SETUP (query, empty) calculates the adjacency matrix ans stores it.'  'H_ADJ (evanescent, handle) is the handle for weighted adjacency matrix.' };
			prop_description = graphadjpf_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(GraphAdjPF, POINTER) returns settings of POINTER of GraphAdjPF.
			%  SETTINGS = PF.GETPROPSETTINGS(GraphAdjPF, POINTER) returns settings of POINTER of GraphAdjPF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GraphAdjPF.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 23 % GraphAdjPF.H_AXES
					prop_settings = Format.getFormatSettings(18);
				case 24 % GraphAdjPF.ST_AXIS
					prop_settings = 'SettingsAxis';
				case 25 % GraphAdjPF.LISTENER_ST_AXIS
					prop_settings = Format.getFormatSettings(18);
				case 26 % GraphAdjPF.G
					prop_settings = 'Graph';
				case 27 % GraphAdjPF.LAYERS
					prop_settings = Format.getFormatSettings(12);
				case 28 % GraphAdjPF.LAYERLOCK
					prop_settings = Format.getFormatSettings(4);
				case 29 % GraphAdjPF.COLORBAR
					prop_settings = Format.getFormatSettings(4);
				case 30 % GraphAdjPF.ST_AMBIENT
					prop_settings = 'SettingsAmbient';
				case 31 % GraphAdjPF.SETUP
					prop_settings = Format.getFormatSettings(1);
				case 32 % GraphAdjPF.H_ADJ
					prop_settings = Format.getFormatSettings(18);
				case 4 % GraphAdjPF.TEMPLATE
					prop_settings = 'GraphAdjPF';
				otherwise
					prop_settings = getPropSettings@PanelFig(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GraphAdjPF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphAdjPF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(GraphAdjPF, POINTER) returns the default value of POINTER of GraphAdjPF.
			%  DEFAULT = PF.GETPROPDEFAULT(GraphAdjPF, POINTER) returns the default value of POINTER of GraphAdjPF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GraphAdjPF.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 23 % GraphAdjPF.H_AXES
					prop_default = Format.getFormatDefault(18, GraphAdjPF.getPropSettings(prop));
				case 24 % GraphAdjPF.ST_AXIS
					prop_default = SettingsAxis('GRID', false, 'AXIS', false, 'BOX', true);
				case 25 % GraphAdjPF.LISTENER_ST_AXIS
					prop_default = Format.getFormatDefault(18, GraphAdjPF.getPropSettings(prop));
				case 26 % GraphAdjPF.G
					prop_default = Format.getFormatDefault(8, GraphAdjPF.getPropSettings(prop));
				case 27 % GraphAdjPF.LAYERS
					prop_default = [1 1];
				case 28 % GraphAdjPF.LAYERLOCK
					prop_default = false;
				case 29 % GraphAdjPF.COLORBAR
					prop_default = true;
				case 30 % GraphAdjPF.ST_AMBIENT
					prop_default = SettingsAmbient('LIGHTING', 'none', 'MATERIAL', 'dull', 'CAMLIGHT', 'none', 'SHADING', 'flat', 'COLORMAP', 'jet');
				case 31 % GraphAdjPF.SETUP
					prop_default = Format.getFormatDefault(1, GraphAdjPF.getPropSettings(prop));
				case 32 % GraphAdjPF.H_ADJ
					prop_default = Format.getFormatDefault(18, GraphAdjPF.getPropSettings(prop));
				case 1 % GraphAdjPF.ELCLASS
					prop_default = 'GraphAdjPF';
				case 2 % GraphAdjPF.NAME
					prop_default = 'Panel Figure for Graph Adjacency Matrix';
				case 3 % GraphAdjPF.DESCRIPTION
					prop_default = 'A Panel Figure for Graph Adjacency Matrix (GraphAdjPF) manages the plot of an adjacency matrix.';
				case 4 % GraphAdjPF.TEMPLATE
					prop_default = Format.getFormatDefault(8, GraphAdjPF.getPropSettings(prop));
				case 5 % GraphAdjPF.ID
					prop_default = 'GraphAdjPF ID';
				case 6 % GraphAdjPF.LABEL
					prop_default = 'GraphAdjPF label';
				case 7 % GraphAdjPF.NOTES
					prop_default = 'GraphAdjPF notes';
				otherwise
					prop_default = getPropDefault@PanelFig(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GraphAdjPF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphAdjPF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GraphAdjPF, POINTER) returns the conditioned default value of POINTER of GraphAdjPF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(GraphAdjPF, POINTER) returns the conditioned default value of POINTER of GraphAdjPF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GraphAdjPF.getPropProp(pointer);
			
			prop_default = GraphAdjPF.conditioning(prop, GraphAdjPF.getPropDefault(prop));
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
				case 27 % GraphAdjPF.LAYERS
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
			%  CHECK = Element.CHECKPROP(GraphAdjPF, PROP, VALUE) checks VALUE format for PROP of GraphAdjPF.
			%  CHECK = PF.CHECKPROP(GraphAdjPF, PROP, VALUE) checks VALUE format for PROP of GraphAdjPF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GraphAdjPF:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: BRAPH2:GraphAdjPF:WrongInput
			%  Element.CHECKPROP(GraphAdjPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphAdjPF.
			%   Error id: BRAPH2:GraphAdjPF:WrongInput
			%  PF.CHECKPROP(GraphAdjPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphAdjPF.
			%   Error id: BRAPH2:GraphAdjPF:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GraphAdjPF.getPropProp(pointer);
			
			switch prop
				case 23 % GraphAdjPF.H_AXES
					check = Format.checkFormat(18, value, GraphAdjPF.getPropSettings(prop));
				case 24 % GraphAdjPF.ST_AXIS
					check = Format.checkFormat(8, value, GraphAdjPF.getPropSettings(prop));
				case 25 % GraphAdjPF.LISTENER_ST_AXIS
					check = Format.checkFormat(18, value, GraphAdjPF.getPropSettings(prop));
				case 26 % GraphAdjPF.G
					check = Format.checkFormat(8, value, GraphAdjPF.getPropSettings(prop));
				case 27 % GraphAdjPF.LAYERS
					check = Format.checkFormat(12, value, GraphAdjPF.getPropSettings(prop));
				case 28 % GraphAdjPF.LAYERLOCK
					check = Format.checkFormat(4, value, GraphAdjPF.getPropSettings(prop));
				case 29 % GraphAdjPF.COLORBAR
					check = Format.checkFormat(4, value, GraphAdjPF.getPropSettings(prop));
				case 30 % GraphAdjPF.ST_AMBIENT
					check = Format.checkFormat(8, value, GraphAdjPF.getPropSettings(prop));
				case 31 % GraphAdjPF.SETUP
					check = Format.checkFormat(1, value, GraphAdjPF.getPropSettings(prop));
				case 32 % GraphAdjPF.H_ADJ
					check = Format.checkFormat(18, value, GraphAdjPF.getPropSettings(prop));
				case 4 % GraphAdjPF.TEMPLATE
					check = Format.checkFormat(8, value, GraphAdjPF.getPropSettings(prop));
				otherwise
					if prop <= 22
						check = checkProp@PanelFig(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GraphAdjPF:' 'WrongInput'], ...
					['BRAPH2' ':GraphAdjPF:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GraphAdjPF.getPropTag(prop) ' (' GraphAdjPF.getFormatTag(GraphAdjPF.getPropFormat(prop)) ').'] ...
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
				case 24 % GraphAdjPF.ST_AXIS
					if pf.get('DRAWN')
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
					        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
					    end
					end
					
				case 27 % GraphAdjPF.LAYERS
					pf.get('SETUP')
					
				case 28 % GraphAdjPF.LAYERLOCK
					if pf.get('LAYERLOCK')
					    layers = pf.get('LAYERS');
					    if layers(1) ~= layers(2)
					        pf.set('LAYERS', [layers(1) layers(1)])
					    end
					end
					
				case 29 % GraphAdjPF.COLORBAR
					if pf.get('DRAWN')
					    if pf.get('COLORBAR')
					        colorbar(pf.get('H_AXES'))
					    else
					        colorbar(pf.get('H_AXES'), 'off')
					    end
					
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Colormap'), 'State', pf.get('COLORBAR'))
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
				case 23 % GraphAdjPF.H_AXES
					h_axes = uiaxes( ...
					    'Parent', pf.memorize('H'), ...
					    'Tag', 'H_AXES', ...
					    'Units', 'normalized', ...
					    'OuterPosition', [0 0 1 1], ...
					    'XAxisLocation', 'top', ...
						'YAxisLocation', 'left', ...
					    'YDir', 'Reverse' ...
					    );
					h_axes.Toolbar.Visible = 'off';
					h_axes.Interactions = [];
					value = h_axes;
					
				case 25 % GraphAdjPF.LISTENER_ST_AXIS
					value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis);
					
				case 31 % GraphAdjPF.SETUP
					A = pf.get('G').get('A');
					if numel(A) <= 1
					    A = cell2mat(A);
					else
					    layers = pf.get('LAYERS');
					    A = A{layers(1), layers(2)};
					end
					
					row_number = size(A, 1);
					column_number = size(A, 2);
					
					pf.get('H_ADJ').set( ...
					    'XData', (0:1:column_number), ...
					    'YData', (0:1:row_number), ...
					    'ZData', [A, zeros(row_number, 1); zeros(1, column_number + 1)] ...
					    );
					
					pf.set('COLORBAR', pf.get('COLORBAR'))
					pf.get('ST_AMBIENT').get('SETUP')
					
					nodelabels = pf.get('G').get('ANODELABELS');
					if isequal(nodelabels, {'numbered'})
					    nodelabels = 'numbered';
					end
					
					set(pf.get('H_AXES'), ...
					    'XTickLabelRotation', 90, ...
					    'XTick', (1:1:column_number) - .5, ...
					    'XTickLabel', nodelabels, ...
					    'YTick', (1:1:row_number) - .5, ...    
					    'YTickLabels', nodelabels ...
					    )
					
					value = [];
					
				case 32 % GraphAdjPF.H_ADJ
					value = surf(pf.get('H_AXES'), [], [], []);
					
				case 11 % GraphAdjPF.DRAW
					value = calculateValue@PanelFig(pf, 11, varargin{:}); % also warning
					if value
					    pf.memorize('H_AXES')
					    
					    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', 23).get('SETUP')
					    pf.memorize('LISTENER_ST_AXIS');
					    
					    pf.memorize('ST_AMBIENT').set('PANEL', pf, 'PROP', 23).get('SETUP')
					    
					    pf.memorize('H_ADJ')
					
					    pf.get('SETUP')
					end
					
				case 18 % GraphAdjPF.DELETE
					value = calculateValue@PanelFig(pf, 18, varargin{:}); % also warning
					if value
					    pf.set('H_AXES', Element.getNoValue())
					
					    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
					    
					    pf.set('H_ADJ', Element.getNoValue())
					end
					
				case 22 % GraphAdjPF.H_TOOLS
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
					    
					% % %     % % Weighted
					% % %     % tool_weighted = uitoggletool(toolbar, ...
					% % %     %     'Tag', 'TOOL.Weighted', ...
					% % %     %     'Separator', 'on', ...
					% % %     %     'State', pf.get('WEIGHTED'), ...
					% % %     %     'Tooltip', 'Show weighted adjacency matrix', ...
					% % %     %     'CData', imread('icon_weighted.png'), ...
					% % %     %     'OnCallback', {@cb_weighted, true}, ...
					% % %     %     'OffCallback', {@cb_weighted, false});
					% % %     % 
					% % %     % % Binary
					% % %     % tool_binary = uitoggletool(toolbar, ...
					% % %     %     'Tag', 'TOOL.Binary', ...
					% % %     %     'State', ~pf.get('WEIGHTED'), ...
					% % %     %     'Tooltip', 'Show binary adjacency matrix', ...
					% % %     %     'CData', imread('icon_binary.png'), ...
					% % %     %     'OnCallback', {@cb_weighted, false}, ...
					% % %     %     'OffCallback', {@cb_weighted, true});
					
					    % Colormap
					    tool_colorbar = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Colormap', ...
					        'State', pf.get('COLORBAR'), ...
					        'Tooltip', 'Show colorbar', ... 
					        'CData', imread('icon_colorbar.png'), ...
					        'OnCallback', {@cb_colorbar, true}, ...
					        'OffCallback', {@cb_colorbar, false});
					    
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_axis, tool_grid, ...
					        tool_separator_2, tool_colorbar ...
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
			function cb_weighted(~, ~, weighted) % (src, event)
			    pf.set('WEIGHTED', weighted)
			end
			function cb_colorbar(~, ~, colorbar) % (src, event)
			    pf.set('COLORBAR', colorbar)
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
				case 24 % GraphAdjPF.ST_AXIS
					pr = SettingsAxisPP('EL', pf, 'PROP', 24, varargin{:});
					
				case 27 % GraphAdjPF.LAYERS
					pr = LayersPP('EL', pf, 'PROP', 27, ...
					    'G_PROP', 26, ...
					    varargin{:});
					
				case 30 % GraphAdjPF.ST_AMBIENT
					pr = SettingsAmbientPP('EL', pf, 'PROP', 30, varargin{:});
					
				otherwise
					pr = getPanelProp@PanelFig(pf, prop, varargin{:});
					
			end
		end
	end
end
