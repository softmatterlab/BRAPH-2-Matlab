classdef MeasureEnsemblePF_BxPP_Nodes < PanelProp
	%MeasureEnsemblePF_BxPP_Nodes plots the panel to select a couple of nodes.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Nodes Prop Panel (MeasureEnsemblePF_BxPP_Nodes) plots the panel to select the nodes from two drop-down lists.
	% It is supposed to be used with the property NODES of MeasureEnsemblePF_BU, MeasureEnsemblePF_BS, or MeasureEnsemblePF_BB.
	%
	% The list of MeasureEnsemblePF_BxPP_Nodes properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the nodes prop panel.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the nodes prop panel.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the nodes prop panel.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the nodes prop panel.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the nodes prop panel.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the nodes prop panel.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the nodes prop panel.
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
	%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the editfield.
	%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
	%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
	%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
	%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the property panel.
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
	%  <strong>36</strong> <strong>DROPDOWN_NODE1</strong> 	DROPDOWN_NODE1 (evanescent, handle) is the dropdown for the first node.
	%  <strong>37</strong> <strong>DROPDOWN_NODE2</strong> 	DROPDOWN_NODE2 (evanescent, handle) is the dropdown for the second node.
	%
	% MeasureEnsemblePF_BxPP_Nodes methods (constructor):
	%  MeasureEnsemblePF_BxPP_Nodes - constructor
	%
	% MeasureEnsemblePF_BxPP_Nodes methods:
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
	% MeasureEnsemblePF_BxPP_Nodes methods (display):
	%  tostring - string with information about the nodes prop panel
	%  disp - displays information about the nodes prop panel
	%  tree - displays the tree of the nodes prop panel
	%
	% MeasureEnsemblePF_BxPP_Nodes methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two nodes prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the nodes prop panel
	%
	% MeasureEnsemblePF_BxPP_Nodes methods (save/load, Static):
	%  save - saves BRAPH2 nodes prop panel as b2 file
	%  load - loads a BRAPH2 nodes prop panel from a b2 file
	%
	% MeasureEnsemblePF_BxPP_Nodes method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the nodes prop panel
	%
	% MeasureEnsemblePF_BxPP_Nodes method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the nodes prop panel
	%
	% MeasureEnsemblePF_BxPP_Nodes methods (inspection, Static):
	%  getClass - returns the class of the nodes prop panel
	%  getSubclasses - returns all subclasses of MeasureEnsemblePF_BxPP_Nodes
	%  getProps - returns the property list of the nodes prop panel
	%  getPropNumber - returns the property number of the nodes prop panel
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
	% MeasureEnsemblePF_BxPP_Nodes methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasureEnsemblePF_BxPP_Nodes methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasureEnsemblePF_BxPP_Nodes methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasureEnsemblePF_BxPP_Nodes methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasureEnsemblePF_BxPP_Nodes; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasureEnsemblePF_BxPP_Nodes constants</a>.
	%
	%
	% See also uidropdown, GUI, MeasureEnsemblePF_BU, MeasureEnsemblePF_BS, MeasureEnsemblePF_BB.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		DROPDOWN_NODE1 = 36; %CET: Computational Efficiency Trick
		DROPDOWN_NODE1_TAG = 'DROPDOWN_NODE1';
		DROPDOWN_NODE1_CATEGORY = 7;
		DROPDOWN_NODE1_FORMAT = 18;
		
		DROPDOWN_NODE2 = 37; %CET: Computational Efficiency Trick
		DROPDOWN_NODE2_TAG = 'DROPDOWN_NODE2';
		DROPDOWN_NODE2_CATEGORY = 7;
		DROPDOWN_NODE2_FORMAT = 18;
	end
	methods % constructor
		function pr = MeasureEnsemblePF_BxPP_Nodes(varargin)
			%MeasureEnsemblePF_BxPP_Nodes() creates a nodes prop panel.
			%
			% MeasureEnsemblePF_BxPP_Nodes(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasureEnsemblePF_BxPP_Nodes(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of MeasureEnsemblePF_BxPP_Nodes properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the nodes prop panel.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the nodes prop panel.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the nodes prop panel.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the nodes prop panel.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the nodes prop panel.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the nodes prop panel.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the nodes prop panel.
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
			%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the editfield.
			%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
			%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
			%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
			%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the property panel.
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
			%  <strong>36</strong> <strong>DROPDOWN_NODE1</strong> 	DROPDOWN_NODE1 (evanescent, handle) is the dropdown for the first node.
			%  <strong>37</strong> <strong>DROPDOWN_NODE2</strong> 	DROPDOWN_NODE2 (evanescent, handle) is the dropdown for the second node.
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the nodes prop panel.
			%
			% BUILD = MeasureEnsemblePF_BxPP_Nodes.GETBUILD() returns the build of 'MeasureEnsemblePF_BxPP_Nodes'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the nodes prop panel PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('MeasureEnsemblePF_BxPP_Nodes') returns the build of 'MeasureEnsemblePF_BxPP_Nodes'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('MeasureEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the nodes prop panel.
			%
			% CLASS = MeasureEnsemblePF_BxPP_Nodes.GETCLASS() returns the class 'MeasureEnsemblePF_BxPP_Nodes'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the nodes prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('MeasureEnsemblePF_BxPP_Nodes') returns 'MeasureEnsemblePF_BxPP_Nodes'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('MeasureEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			
			pr_class = 'MeasureEnsemblePF_BxPP_Nodes';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the nodes prop panel.
			%
			% LIST = MeasureEnsemblePF_BxPP_Nodes.GETSUBCLASSES() returns all subclasses of 'MeasureEnsemblePF_BxPP_Nodes'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the nodes prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('MeasureEnsemblePF_BxPP_Nodes') returns all subclasses of 'MeasureEnsemblePF_BxPP_Nodes'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('MeasureEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'MeasureEnsemblePF_BxPP_Nodes' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of nodes prop panel.
			%
			% PROPS = MeasureEnsemblePF_BxPP_Nodes.GETPROPS() returns the property list of nodes prop panel
			%  as a row vector.
			%
			% PROPS = MeasureEnsemblePF_BxPP_Nodes.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the nodes prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('MeasureEnsemblePF_BxPP_Nodes'[, CATEGORY]) returns the property list of 'MeasureEnsemblePF_BxPP_Nodes'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('MeasureEnsemblePF_BxPP_Nodes')
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
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 23 24 29];
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 20 21 22];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 27 28 30 31 32 33 34 35 36 37];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of nodes prop panel.
			%
			% N = MeasureEnsemblePF_BxPP_Nodes.GETPROPNUMBER() returns the property number of nodes prop panel.
			%
			% N = MeasureEnsemblePF_BxPP_Nodes.GETPROPNUMBER(CATEGORY) returns the property number of nodes prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the nodes prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('MeasureEnsemblePF_BxPP_Nodes') returns the property number of 'MeasureEnsemblePF_BxPP_Nodes'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('MeasureEnsemblePF_BxPP_Nodes')
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
					prop_number = 4;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in nodes prop panel/error.
			%
			% CHECK = MeasureEnsemblePF_BxPP_Nodes.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(MeasureEnsemblePF_BxPP_Nodes, PROP) checks whether PROP exists for MeasureEnsemblePF_BxPP_Nodes.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsemblePF_BxPP_Nodes:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:MeasureEnsemblePF_BxPP_Nodes:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:MeasureEnsemblePF_BxPP_Nodes:WrongInput]
			%  Element.EXISTSPROP(MeasureEnsemblePF_BxPP_Nodes, PROP) throws error if PROP does NOT exist for MeasureEnsemblePF_BxPP_Nodes.
			%   Error id: [BRAPH2:MeasureEnsemblePF_BxPP_Nodes:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('MeasureEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 37 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MeasureEnsemblePF_BxPP_Nodes:' 'WrongInput'], ...
					['BRAPH2' ':MeasureEnsemblePF_BxPP_Nodes:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasureEnsemblePF_BxPP_Nodes.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in nodes prop panel/error.
			%
			% CHECK = MeasureEnsemblePF_BxPP_Nodes.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(MeasureEnsemblePF_BxPP_Nodes, TAG) checks whether TAG exists for MeasureEnsemblePF_BxPP_Nodes.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsemblePF_BxPP_Nodes:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:MeasureEnsemblePF_BxPP_Nodes:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:MeasureEnsemblePF_BxPP_Nodes:WrongInput]
			%  Element.EXISTSTAG(MeasureEnsemblePF_BxPP_Nodes, TAG) throws error if TAG does NOT exist for MeasureEnsemblePF_BxPP_Nodes.
			%   Error id: [BRAPH2:MeasureEnsemblePF_BxPP_Nodes:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('MeasureEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'DROPDOWN_NODE1'  'DROPDOWN_NODE2' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MeasureEnsemblePF_BxPP_Nodes:' 'WrongInput'], ...
					['BRAPH2' ':MeasureEnsemblePF_BxPP_Nodes:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for MeasureEnsemblePF_BxPP_Nodes.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MeasureEnsemblePF_BxPP_Nodes, POINTER) returns property number of POINTER of MeasureEnsemblePF_BxPP_Nodes.
			%  PROPERTY = PR.GETPROPPROP(MeasureEnsemblePF_BxPP_Nodes, POINTER) returns property number of POINTER of MeasureEnsemblePF_BxPP_Nodes.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('MeasureEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'DROPDOWN_NODE1'  'DROPDOWN_NODE2' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(MeasureEnsemblePF_BxPP_Nodes, POINTER) returns tag of POINTER of MeasureEnsemblePF_BxPP_Nodes.
			%  TAG = PR.GETPROPTAG(MeasureEnsemblePF_BxPP_Nodes, POINTER) returns tag of POINTER of MeasureEnsemblePF_BxPP_Nodes.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('MeasureEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				measureensemblepf_bxpp_nodes_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'DROPDOWN_NODE1'  'DROPDOWN_NODE2' };
				tag = measureensemblepf_bxpp_nodes_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(MeasureEnsemblePF_BxPP_Nodes, POINTER) returns category of POINTER of MeasureEnsemblePF_BxPP_Nodes.
			%  CATEGORY = PR.GETPROPCATEGORY(MeasureEnsemblePF_BxPP_Nodes, POINTER) returns category of POINTER of MeasureEnsemblePF_BxPP_Nodes.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('MeasureEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsemblePF_BxPP_Nodes.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measureensemblepf_bxpp_nodes_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  7  7 };
			prop_category = measureensemblepf_bxpp_nodes_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(MeasureEnsemblePF_BxPP_Nodes, POINTER) returns format of POINTER of MeasureEnsemblePF_BxPP_Nodes.
			%  FORMAT = PR.GETPROPFORMAT(MeasureEnsemblePF_BxPP_Nodes, POINTER) returns format of POINTER of MeasureEnsemblePF_BxPP_Nodes.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('MeasureEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsemblePF_BxPP_Nodes.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measureensemblepf_bxpp_nodes_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  18  18 };
			prop_format = measureensemblepf_bxpp_nodes_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasureEnsemblePF_BxPP_Nodes, POINTER) returns description of POINTER of MeasureEnsemblePF_BxPP_Nodes.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(MeasureEnsemblePF_BxPP_Nodes, POINTER) returns description of POINTER of MeasureEnsemblePF_BxPP_Nodes.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('MeasureEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsemblePF_BxPP_Nodes.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measureensemblepf_bxpp_nodes_description_list = { 'ELCLASS (constant, string) is the class of the nodes prop panel.'  'NAME (constant, string) is the name of the nodes prop panel.'  'DESCRIPTION (constant, string) is the description of the nodes prop panel.'  'TEMPLATE (parameter, item) is the template of the nodes prop panel.'  'ID (data, string) is a few-letter code for the nodes prop panel.'  'LABEL (metadata, string) is an extended label of the nodes prop panel.'  'NOTES (metadata, string) are some specific notes about the nodes prop panel.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the editfield.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the property panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'DROPDOWN_NODE1 (evanescent, handle) is the dropdown for the first node.'  'DROPDOWN_NODE2 (evanescent, handle) is the dropdown for the second node.' };
			prop_description = measureensemblepf_bxpp_nodes_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(MeasureEnsemblePF_BxPP_Nodes, POINTER) returns settings of POINTER of MeasureEnsemblePF_BxPP_Nodes.
			%  SETTINGS = PR.GETPROPSETTINGS(MeasureEnsemblePF_BxPP_Nodes, POINTER) returns settings of POINTER of MeasureEnsemblePF_BxPP_Nodes.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('MeasureEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsemblePF_BxPP_Nodes.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % MeasureEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1
					prop_settings = Format.getFormatSettings(18);
				case 37 % MeasureEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2
					prop_settings = Format.getFormatSettings(18);
				case 4 % MeasureEnsemblePF_BxPP_Nodes.TEMPLATE
					prop_settings = 'MeasureEnsemblePF_BxPP_Nodes';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasureEnsemblePF_BxPP_Nodes.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsemblePF_BxPP_Nodes.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasureEnsemblePF_BxPP_Nodes, POINTER) returns the default value of POINTER of MeasureEnsemblePF_BxPP_Nodes.
			%  DEFAULT = PR.GETPROPDEFAULT(MeasureEnsemblePF_BxPP_Nodes, POINTER) returns the default value of POINTER of MeasureEnsemblePF_BxPP_Nodes.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('MeasureEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureEnsemblePF_BxPP_Nodes.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % MeasureEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1
					prop_default = Format.getFormatDefault(18, MeasureEnsemblePF_BxPP_Nodes.getPropSettings(prop));
				case 37 % MeasureEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2
					prop_default = Format.getFormatDefault(18, MeasureEnsemblePF_BxPP_Nodes.getPropSettings(prop));
				case 1 % MeasureEnsemblePF_BxPP_Nodes.ELCLASS
					prop_default = 'MeasureEnsemblePF_BxPP_Nodes';
				case 2 % MeasureEnsemblePF_BxPP_Nodes.NAME
					prop_default = 'Nodes Prop Panel';
				case 3 % MeasureEnsemblePF_BxPP_Nodes.DESCRIPTION
					prop_default = 'A Nodes Prop Panel (MeasureEnsemblePF_BxPP_Nodes) plots the panel to select the nodes from two drop-down lists. It is supposed to be used with the property NODES of MeasurePF_BU, MeasurePF_BS, or MeasurePF_BB.';
				case 4 % MeasureEnsemblePF_BxPP_Nodes.TEMPLATE
					prop_default = Format.getFormatDefault(8, MeasureEnsemblePF_BxPP_Nodes.getPropSettings(prop));
				case 5 % MeasureEnsemblePF_BxPP_Nodes.ID
					prop_default = 'MeasureEnsemblePF_BxPP_Nodes ID';
				case 6 % MeasureEnsemblePF_BxPP_Nodes.LABEL
					prop_default = 'MeasureEnsemblePF_BxPP_Nodes label';
				case 7 % MeasureEnsemblePF_BxPP_Nodes.NOTES
					prop_default = 'MeasureEnsemblePF_BxPP_Nodes notes';
				case 23 % MeasureEnsemblePF_BxPP_Nodes.EL
					prop_default = MeasureEnsemblePF_BU();
				case 24 % MeasureEnsemblePF_BxPP_Nodes.PROP
					prop_default = 40;
				case 25 % MeasureEnsemblePF_BxPP_Nodes.HEIGHT
					prop_default = 48;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasureEnsemblePF_BxPP_Nodes.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsemblePF_BxPP_Nodes.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasureEnsemblePF_BxPP_Nodes, POINTER) returns the conditioned default value of POINTER of MeasureEnsemblePF_BxPP_Nodes.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(MeasureEnsemblePF_BxPP_Nodes, POINTER) returns the conditioned default value of POINTER of MeasureEnsemblePF_BxPP_Nodes.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('MeasureEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasureEnsemblePF_BxPP_Nodes.getPropProp(pointer);
			
			prop_default = MeasureEnsemblePF_BxPP_Nodes.conditioning(prop, MeasureEnsemblePF_BxPP_Nodes.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MeasureEnsemblePF_BxPP_Nodes, PROP, VALUE) checks VALUE format for PROP of MeasureEnsemblePF_BxPP_Nodes.
			%  CHECK = PR.CHECKPROP(MeasureEnsemblePF_BxPP_Nodes, PROP, VALUE) checks VALUE format for PROP of MeasureEnsemblePF_BxPP_Nodes.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:MeasureEnsemblePF_BxPP_Nodes:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:MeasureEnsemblePF_BxPP_Nodes:WrongInput
			%  Element.CHECKPROP(MeasureEnsemblePF_BxPP_Nodes, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsemblePF_BxPP_Nodes.
			%   Error id: BRAPH2:MeasureEnsemblePF_BxPP_Nodes:WrongInput
			%  PR.CHECKPROP(MeasureEnsemblePF_BxPP_Nodes, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsemblePF_BxPP_Nodes.
			%   Error id: BRAPH2:MeasureEnsemblePF_BxPP_Nodes:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('MeasureEnsemblePF_BxPP_Nodes')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasureEnsemblePF_BxPP_Nodes.getPropProp(pointer);
			
			switch prop
				case 36 % MeasureEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1
					check = Format.checkFormat(18, value, MeasureEnsemblePF_BxPP_Nodes.getPropSettings(prop));
				case 37 % MeasureEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2
					check = Format.checkFormat(18, value, MeasureEnsemblePF_BxPP_Nodes.getPropSettings(prop));
				case 4 % MeasureEnsemblePF_BxPP_Nodes.TEMPLATE
					check = Format.checkFormat(8, value, MeasureEnsemblePF_BxPP_Nodes.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MeasureEnsemblePF_BxPP_Nodes:' 'WrongInput'], ...
					['BRAPH2' ':MeasureEnsemblePF_BxPP_Nodes:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasureEnsemblePF_BxPP_Nodes.getPropTag(prop) ' (' MeasureEnsemblePF_BxPP_Nodes.getFormatTag(MeasureEnsemblePF_BxPP_Nodes.getPropFormat(prop)) ').'] ...
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
				case 36 % MeasureEnsemblePF_BxPP_Nodes.DROPDOWN_NODE1
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN_NODE1', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_dropdown_node} ...
					    );
					
					value = dropdown;
					
				case 37 % MeasureEnsemblePF_BxPP_Nodes.DROPDOWN_NODE2
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN_NODE2', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_dropdown_node} ...
					    );
					
					value = dropdown;
					
				case 20 % MeasureEnsemblePF_BxPP_Nodes.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('DROPDOWN_NODE1')
					    pr.memorize('DROPDOWN_NODE2')
					end
					
				case 21 % MeasureEnsemblePF_BxPP_Nodes.UPDATE
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value
					    pf = pr.get('EL');
					    NODES = pr.get('PROP');
					    
					    if pf.get('ME').get('A').get('G_DICT').get('LENGTH')
					        g = pf.get('ME').get('A').get('G_DICT').get('IT', 1);
					    else
					        g = pf.get('ME').get('A').get('GRAPH_TEMPLATE');
					    end
					    keys = g.get('ANODELABELS');
					    
					    nodes = pf.get(NODES);
					    set(pr.get('DROPDOWN_NODE1'), ...
					        'Items', keys, ...
					        'ItemsData', [1:1:length(keys)], ...
					        'Value', nodes(1) ...
					        )
					    set(pr.get('DROPDOWN_NODE2'), ...
					        'Items', keys, ...
					        'ItemsData', [1:1:length(keys)], ...
					        'Value', nodes(2) ...
					        )
					
					    prop_value = pf.getr(NODES);
					    if pf.isLocked(NODES) || isa(prop_value, 'Callback')
					        set(pr.get('DROPDOWN_NODE1'), 'Enable', 'off')
					        set(pr.get('DROPDOWN_NODE2'), 'Enable', 'off')
					    end
					end
					
				case 22 % MeasureEnsemblePF_BxPP_Nodes.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('DROPDOWN_NODE1'), 'Position', [4            4 .40*w_p 21])
					    set(pr.get('DROPDOWN_NODE2'), 'Position', [4+.50*w_p    4 .40*w_p 21])
					end
					
				case 18 % MeasureEnsemblePF_BxPP_Nodes.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('DROPDOWN_NODE1', Element.getNoValue())
					    pr.set('DROPDOWN_NODE2', Element.getNoValue())
					end
					
				otherwise
					if prop <= 35
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_dropdown_node(~, ~)
			    pr.get('EL').set(pr.get('PROP'), [get(pr.get('DROPDOWN_NODE1'), 'Value') get(pr.get('DROPDOWN_NODE2'), 'Value')])
			end
			function cb_dropdown_node2(~, ~)
			    pr.get('EL').set(pr.get('PROP'), [get(pr.get('DROPDOWN_NODE1'), 'Value') get(pr.get('DROPDOWN_NODE2'), 'Value')])
			end
		end
	end
end
