classdef PanelProp < Panel
	%PanelProp is a property panel.
	% It is a subclass of <a href="matlab:help Panel">Panel</a>.
	%
	% A Prop Panel (PanelProp) renders a property of an element in a panel. 
	%  It contains a text with the prop tag and a tooltip with the prop description.
	%  For parameter, data, figure and gui callbacks, it also features a callback button.
	%  For results, it features calculate and delete buttons.
	%  It is typically employed in one of its derived forms, 
	%  where also the contents of the element property are shown.
	% 
	%  Children of PanelProp should update the props:
	%   <strong>X_DRAW</strong> - to initially create the panel and its graphical objects
	%   <strong>UPDATE</strong> - to update the information content of the panel and of the element
	%   <strong>REDRAW</strong> - to resize the panel and reposition its graphical objcts
	%   <strong>HEIGHT</strong> - to determine the height of the panel
	% 
	% CONSTRUCTOR - To construct a PanelProp use, e.g.:
	% 
	% 	pr = PanelProp('<strong>PARENT</strong>', <parent element>, '<strong>EL</strong>', <element>)
	%     
	%  where the <parent element> is most often a PanelElement.
	%    
	% DRAW - To create the initial prop panel (title text and buttons), call:
	% 
	%     pr.get('<strong>DRAW</strong>'[, 'Name', <value>, ...])
	%     p = pr.get('<strong>H</strong>'); % p is the handle of the generated panel
	% 
	%  The query pn.get('<strong>DRAWN</strong>') returns whether the Panel has 
	%   been drawn and therefore can be shown.
	% 
	% UPDATE - Updates the information content of the panel and of the element.
	%   Typically, it does not need to be called explicitly.
	%   It is internally called by PanelElement when needed.
	% 
	% REDRAW - Resizes the panel and repositions its graphical objcts.
	%   Typically, it does not need to be called explicitly.
	%   It is internally called by PanelElement when needed.
	% 
	% CALLBACKS - These are the public callback (to be further implemented by the derived panels):
	% 
	%     pn.get('<strong>SHOW</strong>') - shows the figure containing the panel.
	%     pn.get('<strong>HIDE</strong>') - hides the figure containing the panel.
	%     pn.get('<strong>DELETE</strong>') - resets the handles when the panel is deleted.
	%     pn.get('<strong>CLOSE</strong>') - closes the figure containing the panel.
	%
	% The list of PanelProp properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the property panel.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the property panel.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the property panel.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the property panel.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the property panel.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the property panel.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the property panel.
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
	%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the graphical objects of the prop panel [to be implemented in subelements].
	%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content of the prop panel and its graphical objects.
	%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the prop panel and repositions its graphical objects [accept Width-value pair].
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
	%
	% PanelProp methods (constructor):
	%  PanelProp - constructor
	%
	% PanelProp methods:
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
	% PanelProp methods (display):
	%  tostring - string with information about the prop panel
	%  disp - displays information about the prop panel
	%  tree - displays the tree of the prop panel
	%
	% PanelProp methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel
	%
	% PanelProp methods (save/load, Static):
	%  save - saves BRAPH2 prop panel as b2 file
	%  load - loads a BRAPH2 prop panel from a b2 file
	%
	% PanelProp method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel
	%
	% PanelProp method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel
	%
	% PanelProp methods (inspection, Static):
	%  getClass - returns the class of the prop panel
	%  getSubclasses - returns all subclasses of PanelProp
	%  getProps - returns the property list of the prop panel
	%  getPropNumber - returns the property number of the prop panel
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
	% PanelProp methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelProp methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelProp methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelProp methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelProp; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelProp constants</a>.
	%
	%
	% See also uipanel, uilabel, uibutton, GUI, GUIElement, PanelElement.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		X_DRAW = 20; %CET: Computational Efficiency Trick
		X_DRAW_TAG = 'X_DRAW';
		X_DRAW_CATEGORY = 6;
		X_DRAW_FORMAT = 4;
		
		UPDATE = 21; %CET: Computational Efficiency Trick
		UPDATE_TAG = 'UPDATE';
		UPDATE_CATEGORY = 6;
		UPDATE_FORMAT = 4;
		
		REDRAW = 22; %CET: Computational Efficiency Trick
		REDRAW_TAG = 'REDRAW';
		REDRAW_CATEGORY = 6;
		REDRAW_FORMAT = 4;
		
		EL = 23; %CET: Computational Efficiency Trick
		EL_TAG = 'EL';
		EL_CATEGORY = 4;
		EL_FORMAT = 8;
		
		PROP = 24; %CET: Computational Efficiency Trick
		PROP_TAG = 'PROP';
		PROP_CATEGORY = 4;
		PROP_FORMAT = 11;
		
		HEIGHT = 25; %CET: Computational Efficiency Trick
		HEIGHT_TAG = 'HEIGHT';
		HEIGHT_CATEGORY = 9;
		HEIGHT_FORMAT = 22;
		
		TITLE = 26; %CET: Computational Efficiency Trick
		TITLE_TAG = 'TITLE';
		TITLE_CATEGORY = 9;
		TITLE_FORMAT = 2;
		
		LABEL_TITLE = 27; %CET: Computational Efficiency Trick
		LABEL_TITLE_TAG = 'LABEL_TITLE';
		LABEL_TITLE_CATEGORY = 7;
		LABEL_TITLE_FORMAT = 18;
		
		BUTTON_CB = 28; %CET: Computational Efficiency Trick
		BUTTON_CB_TAG = 'BUTTON_CB';
		BUTTON_CB_CATEGORY = 7;
		BUTTON_CB_FORMAT = 18;
		
		GUI_CB = 29; %CET: Computational Efficiency Trick
		GUI_CB_TAG = 'GUI_CB';
		GUI_CB_CATEGORY = 4;
		GUI_CB_FORMAT = 8;
		
		LISTENER_CB = 30; %CET: Computational Efficiency Trick
		LISTENER_CB_TAG = 'LISTENER_CB';
		LISTENER_CB_CATEGORY = 7;
		LISTENER_CB_FORMAT = 18;
		
		BUTTON_CALC = 31; %CET: Computational Efficiency Trick
		BUTTON_CALC_TAG = 'BUTTON_CALC';
		BUTTON_CALC_CATEGORY = 7;
		BUTTON_CALC_FORMAT = 18;
		
		BUTTON_DEL = 32; %CET: Computational Efficiency Trick
		BUTTON_DEL_TAG = 'BUTTON_DEL';
		BUTTON_DEL_CATEGORY = 7;
		BUTTON_DEL_FORMAT = 18;
		
		LISTENER_SET = 33; %CET: Computational Efficiency Trick
		LISTENER_SET_TAG = 'LISTENER_SET';
		LISTENER_SET_CATEGORY = 7;
		LISTENER_SET_FORMAT = 19;
		
		LISTENER_MEMORIZED = 34; %CET: Computational Efficiency Trick
		LISTENER_MEMORIZED_TAG = 'LISTENER_MEMORIZED';
		LISTENER_MEMORIZED_CATEGORY = 7;
		LISTENER_MEMORIZED_FORMAT = 19;
		
		LISTENER_LOCKED = 35; %CET: Computational Efficiency Trick
		LISTENER_LOCKED_TAG = 'LISTENER_LOCKED';
		LISTENER_LOCKED_CATEGORY = 7;
		LISTENER_LOCKED_FORMAT = 19;
	end
	methods % constructor
		function pr = PanelProp(varargin)
			%PanelProp() creates a prop panel.
			%
			% PanelProp(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelProp(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PanelProp properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the property panel.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the property panel.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the property panel.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the property panel.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the property panel.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the property panel.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the property panel.
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
			%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the graphical objects of the prop panel [to be implemented in subelements].
			%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content of the prop panel and its graphical objects.
			%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the prop panel and repositions its graphical objects [accept Width-value pair].
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
			%
			% See also Category, Format.
			
			pr = pr@Panel(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the prop panel.
			%
			% BUILD = PanelProp.GETBUILD() returns the build of 'PanelProp'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the prop panel PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('PanelProp') returns the build of 'PanelProp'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('PanelProp')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the prop panel.
			%
			% CLASS = PanelProp.GETCLASS() returns the class 'PanelProp'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelProp') returns 'PanelProp'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelProp')
			%  are less computationally efficient.
			
			pr_class = 'PanelProp';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel.
			%
			% LIST = PanelProp.GETSUBCLASSES() returns all subclasses of 'PanelProp'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelProp') returns all subclasses of 'PanelProp'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelProp')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'PanelProp'  'NNxMLP_FeatureImportanceBSPF_xSPP_Layer'  'NNxMLP_FeatureImportanceBSPF_xUPP_Layer'  'NNxMLP_FeatureImportanceBrainSurfacePP_Data'  'NNxMLP_FeatureImportanceBrainSurfacePP_Graph'  'NNxMLP_FeatureImportanceBrainSurfacePP_Measure'  'AnalyzeEnsemblePP_GDict'  'AnalyzeEnsemblePP_MeDict'  'AnalyzeGroupPP_G'  'CompareEnsemblePP_CpDict'  'CompareGroupPP_CpDict'  'ComparisonEnsembleBrainPF_xSPP_Layer'  'ComparisonEnsembleBrainPF_xUPP_Layer'  'ComparisonEnsemblePF_BxPP_Nodes'  'ComparisonEnsemblePF_NxPP_Node'  'ComparisonEnsemblePF_xUPP_Layer'  'ComparisonGroupBrainPF_xSPP_Layer'  'ComparisonGroupBrainPF_xUPP_Layer'  'ComparisonGroupPF_BxPP_Nodes'  'ComparisonGroupPF_NxPP_Node'  'ComparisonGroupPF_xUPP_Layer'  'MeasureEnsembleBrainPF_xSPP_Layer'  'MeasureEnsembleBrainPF_xUPP_Layer'  'MeasureEnsemblePF_BxPP_Nodes'  'MeasureEnsemblePF_NxPP_Node'  'MeasureEnsemblePF_xUPP_Layer'  'MeasureGroupBrainPF_xSPP_Layer'  'MeasureGroupBrainPF_xUPP_Layer'  'PanelPropCellFDR'  'SubjectPP_VOIDict'  'GraphPP_MDict'  'LayersPP'  'MeasurePF_BxPP_Nodes'  'MeasurePF_NxPP_Node'  'MeasurePF_xUPP_Layer'  'PanelPropAlpha'  'PanelPropCell'  'PanelPropClass'  'PanelPropClassList'  'PanelPropColor'  'PanelPropIDict'  'PanelPropIDictTable'  'PanelPropItem'  'PanelPropItemList'  'PanelPropLine'  'PanelPropLogical'  'PanelPropMarker'  'PanelPropMatrix'  'PanelPropNet'  'PanelPropOption'  'PanelPropRVectorSmart'  'PanelPropRVectorView'  'PanelPropScalar'  'PanelPropSize'  'PanelPropString'  'PanelPropStringList'  'PanelPropStringTextArea'  'PipelinePP_Notes'  'PipelinePP_PSDict'  'SettingsAmbientPP'  'SettingsAreaPP'  'SettingsAxisPP'  'SettingsLinePP'  'SettingsPP'  'SettingsPositionPP'  'SettingsSurfacePP'  'SettingsTextPP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel.
			%
			% PROPS = PanelProp.GETPROPS() returns the property list of prop panel
			%  as a row vector.
			%
			% PROPS = PanelProp.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelProp'[, CATEGORY]) returns the property list of 'PanelProp'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35];
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
					prop_list = [10 15 27 28 30 31 32 33 34 35];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel.
			%
			% N = PanelProp.GETPROPNUMBER() returns the property number of prop panel.
			%
			% N = PanelProp.GETPROPNUMBER(CATEGORY) returns the property number of prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelProp') returns the property number of 'PanelProp'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelProp')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 35;
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
					prop_number = 10;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 4;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel/error.
			%
			% CHECK = PanelProp.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelProp, PROP) checks whether PROP exists for PanelProp.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelProp:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelProp:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelProp:WrongInput]
			%  Element.EXISTSPROP(PanelProp, PROP) throws error if PROP does NOT exist for PanelProp.
			%   Error id: [BRAPH2:PanelProp:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelProp')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 35 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelProp:' 'WrongInput'], ...
					['BRAPH2' ':PanelProp:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelProp.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel/error.
			%
			% CHECK = PanelProp.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelProp, TAG) checks whether TAG exists for PanelProp.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelProp:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelProp:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelProp:WrongInput]
			%  Element.EXISTSTAG(PanelProp, TAG) throws error if TAG does NOT exist for PanelProp.
			%   Error id: [BRAPH2:PanelProp:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelProp')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelProp:' 'WrongInput'], ...
					['BRAPH2' ':PanelProp:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for PanelProp.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelProp, POINTER) returns property number of POINTER of PanelProp.
			%  PROPERTY = PR.GETPROPPROP(PanelProp, POINTER) returns property number of POINTER of PanelProp.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(PanelProp, POINTER) returns tag of POINTER of PanelProp.
			%  TAG = PR.GETPROPTAG(PanelProp, POINTER) returns tag of POINTER of PanelProp.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				panelprop_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED' };
				tag = panelprop_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelProp, POINTER) returns category of POINTER of PanelProp.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelProp, POINTER) returns category of POINTER of PanelProp.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelProp')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelProp.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelprop_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7 };
			prop_category = panelprop_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(PanelProp, POINTER) returns format of POINTER of PanelProp.
			%  FORMAT = PR.GETPROPFORMAT(PanelProp, POINTER) returns format of POINTER of PanelProp.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelProp')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelProp.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelprop_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19 };
			prop_format = panelprop_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelProp, POINTER) returns description of POINTER of PanelProp.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelProp, POINTER) returns description of POINTER of PanelProp.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelProp.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelprop_description_list = { 'ELCLASS (constant, string) is the class of the property panel.'  'NAME (constant, string) is the name of the property panel.'  'DESCRIPTION (constant, string) is the description of the property panel.'  'TEMPLATE (parameter, item) is the template of the property panel.'  'ID (data, string) is a few-letter code for the property panel.'  'LABEL (metadata, string) is an extended label of the property panel.'  'NOTES (metadata, string) are some specific notes about the property panel.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.'  'X_DRAW (query, logical) draws the graphical objects of the prop panel [to be implemented in subelements].'  'UPDATE (query, logical) updates the content of the prop panel and its graphical objects.'  'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects [accept Width-value pair].'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the prop panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.' };
			prop_description = panelprop_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelProp, POINTER) returns settings of POINTER of PanelProp.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelProp, POINTER) returns settings of POINTER of PanelProp.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelProp.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 20 % PanelProp.X_DRAW
					prop_settings = Format.getFormatSettings(4);
				case 21 % PanelProp.UPDATE
					prop_settings = Format.getFormatSettings(4);
				case 22 % PanelProp.REDRAW
					prop_settings = Format.getFormatSettings(4);
				case 23 % PanelProp.EL
					prop_settings = Format.getFormatSettings(8);
				case 24 % PanelProp.PROP
					prop_settings = Format.getFormatSettings(11);
				case 25 % PanelProp.HEIGHT
					prop_settings = Format.getFormatSettings(22);
				case 26 % PanelProp.TITLE
					prop_settings = Format.getFormatSettings(2);
				case 27 % PanelProp.LABEL_TITLE
					prop_settings = Format.getFormatSettings(18);
				case 28 % PanelProp.BUTTON_CB
					prop_settings = Format.getFormatSettings(18);
				case 29 % PanelProp.GUI_CB
					prop_settings = 'GUI';
				case 30 % PanelProp.LISTENER_CB
					prop_settings = Format.getFormatSettings(18);
				case 31 % PanelProp.BUTTON_CALC
					prop_settings = Format.getFormatSettings(18);
				case 32 % PanelProp.BUTTON_DEL
					prop_settings = Format.getFormatSettings(18);
				case 33 % PanelProp.LISTENER_SET
					prop_settings = Format.getFormatSettings(19);
				case 34 % PanelProp.LISTENER_MEMORIZED
					prop_settings = Format.getFormatSettings(19);
				case 35 % PanelProp.LISTENER_LOCKED
					prop_settings = Format.getFormatSettings(19);
				case 4 % PanelProp.TEMPLATE
					prop_settings = 'PanelProp';
				otherwise
					prop_settings = getPropSettings@Panel(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelProp.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelProp.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelProp, POINTER) returns the default value of POINTER of PanelProp.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelProp, POINTER) returns the default value of POINTER of PanelProp.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelProp.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 20 % PanelProp.X_DRAW
					prop_default = Format.getFormatDefault(4, PanelProp.getPropSettings(prop));
				case 21 % PanelProp.UPDATE
					prop_default = Format.getFormatDefault(4, PanelProp.getPropSettings(prop));
				case 22 % PanelProp.REDRAW
					prop_default = Format.getFormatDefault(4, PanelProp.getPropSettings(prop));
				case 23 % PanelProp.EL
					prop_default = Format.getFormatDefault(8, PanelProp.getPropSettings(prop));
				case 24 % PanelProp.PROP
					prop_default = 1;
				case 25 % PanelProp.HEIGHT
					prop_default = 24;
				case 26 % PanelProp.TITLE
					prop_default = Format.getFormatDefault(2, PanelProp.getPropSettings(prop));
				case 27 % PanelProp.LABEL_TITLE
					prop_default = Format.getFormatDefault(18, PanelProp.getPropSettings(prop));
				case 28 % PanelProp.BUTTON_CB
					prop_default = Format.getFormatDefault(18, PanelProp.getPropSettings(prop));
				case 29 % PanelProp.GUI_CB
					prop_default = Format.getFormatDefault(8, PanelProp.getPropSettings(prop));
				case 30 % PanelProp.LISTENER_CB
					prop_default = Format.getFormatDefault(18, PanelProp.getPropSettings(prop));
				case 31 % PanelProp.BUTTON_CALC
					prop_default = Format.getFormatDefault(18, PanelProp.getPropSettings(prop));
				case 32 % PanelProp.BUTTON_DEL
					prop_default = Format.getFormatDefault(18, PanelProp.getPropSettings(prop));
				case 33 % PanelProp.LISTENER_SET
					prop_default = Format.getFormatDefault(19, PanelProp.getPropSettings(prop));
				case 34 % PanelProp.LISTENER_MEMORIZED
					prop_default = Format.getFormatDefault(19, PanelProp.getPropSettings(prop));
				case 35 % PanelProp.LISTENER_LOCKED
					prop_default = Format.getFormatDefault(19, PanelProp.getPropSettings(prop));
				case 1 % PanelProp.ELCLASS
					prop_default = 'PanelProp';
				case 2 % PanelProp.NAME
					prop_default = 'Prop Panel';
				case 3 % PanelProp.DESCRIPTION
					prop_default = 'A Prop Panel (PanelProp) renders a property of an element in a panel.';
				case 4 % PanelProp.TEMPLATE
					prop_default = Format.getFormatDefault(8, PanelProp.getPropSettings(prop));
				case 5 % PanelProp.ID
					prop_default = 'PanelProp ID';
				case 6 % PanelProp.LABEL
					prop_default = 'PanelProp label';
				case 7 % PanelProp.NOTES
					prop_default = 'PanelProp notes';
				otherwise
					prop_default = getPropDefault@Panel(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelProp.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelProp.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelProp, POINTER) returns the conditioned default value of POINTER of PanelProp.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelProp, POINTER) returns the conditioned default value of POINTER of PanelProp.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelProp')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelProp.getPropProp(pointer);
			
			prop_default = PanelProp.conditioning(prop, PanelProp.getPropDefault(prop));
		end
	end
	methods (Access=protected) % preset
		function value = preset(pr, prop, value)
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
				case 29 % PanelProp.GUI_CB
					if isequal(value.getClass(), 'GUI') % i.e., default initialization
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    if isa(el.getr(prop), 'Callback')
					        f = ancestor(pr.get('H'), 'figure');
					
					        value = GUIElement( ...
					            'PE', el.getr(prop).get('EL'), ... % ensure that the element is stored
					            'POSITION', [ ...
					                x0(f, 'normalized')+w(f, 'normalized') ...
					                y0(f, 'normalized') ...
					                w(f, 'normalized') ...
					                h(f, 'normalized') ...
					                ], ...
					            'WAITBAR', pr.getCallback('WAITBAR'), ...
					            'CLOSEREQ', false ...
					            );
					    end
					end
					
				otherwise
					if prop <= 19
						value = preset@Panel(pr, prop, value);
					end
			end
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
			%  CHECK = Element.CHECKPROP(PanelProp, PROP, VALUE) checks VALUE format for PROP of PanelProp.
			%  CHECK = PR.CHECKPROP(PanelProp, PROP, VALUE) checks VALUE format for PROP of PanelProp.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:PanelProp:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:PanelProp:WrongInput
			%  Element.CHECKPROP(PanelProp, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelProp.
			%   Error id: BRAPH2:PanelProp:WrongInput
			%  PR.CHECKPROP(PanelProp, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelProp.
			%   Error id: BRAPH2:PanelProp:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelProp')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelProp.getPropProp(pointer);
			
			switch prop
				case 20 % PanelProp.X_DRAW
					check = Format.checkFormat(4, value, PanelProp.getPropSettings(prop));
				case 21 % PanelProp.UPDATE
					check = Format.checkFormat(4, value, PanelProp.getPropSettings(prop));
				case 22 % PanelProp.REDRAW
					check = Format.checkFormat(4, value, PanelProp.getPropSettings(prop));
				case 23 % PanelProp.EL
					check = Format.checkFormat(8, value, PanelProp.getPropSettings(prop));
				case 24 % PanelProp.PROP
					check = Format.checkFormat(11, value, PanelProp.getPropSettings(prop));
				case 25 % PanelProp.HEIGHT
					check = Format.checkFormat(22, value, PanelProp.getPropSettings(prop));
				case 26 % PanelProp.TITLE
					check = Format.checkFormat(2, value, PanelProp.getPropSettings(prop));
				case 27 % PanelProp.LABEL_TITLE
					check = Format.checkFormat(18, value, PanelProp.getPropSettings(prop));
				case 28 % PanelProp.BUTTON_CB
					check = Format.checkFormat(18, value, PanelProp.getPropSettings(prop));
				case 29 % PanelProp.GUI_CB
					check = Format.checkFormat(8, value, PanelProp.getPropSettings(prop));
				case 30 % PanelProp.LISTENER_CB
					check = Format.checkFormat(18, value, PanelProp.getPropSettings(prop));
				case 31 % PanelProp.BUTTON_CALC
					check = Format.checkFormat(18, value, PanelProp.getPropSettings(prop));
				case 32 % PanelProp.BUTTON_DEL
					check = Format.checkFormat(18, value, PanelProp.getPropSettings(prop));
				case 33 % PanelProp.LISTENER_SET
					check = Format.checkFormat(19, value, PanelProp.getPropSettings(prop));
				case 34 % PanelProp.LISTENER_MEMORIZED
					check = Format.checkFormat(19, value, PanelProp.getPropSettings(prop));
				case 35 % PanelProp.LISTENER_LOCKED
					check = Format.checkFormat(19, value, PanelProp.getPropSettings(prop));
				case 4 % PanelProp.TEMPLATE
					check = Format.checkFormat(8, value, PanelProp.getPropSettings(prop));
				otherwise
					if prop <= 19
						check = checkProp@Panel(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelProp:' 'WrongInput'], ...
					['BRAPH2' ':PanelProp:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelProp.getPropTag(prop) ' (' PanelProp.getFormatTag(PanelProp.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pr, prop)
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
				case 23 % PanelProp.EL
					pr.lock('EL', 'Iterative', false)
					if ~isa(pr.getr('PROP'), 'NoValue')
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    settings = {};
					    if isa(pr.getr('ID'), 'NoValue')
					        settings = [settings 'ID' el.getPropTag(prop)];
					    end
					    if isa(pr.getr('TITLE'), 'NoValue')
					        settings = [settings 'TITLE' el.getPropTag(prop)];
					    end
					    if isa(pr.getr('BKGCOLOR'), 'NoValue')
					        switch el.getPropCategory(prop)
					            case 1
					                color = [0.5 0.5 0.5];
					            case 2
					                color = [0.2 0.5 0.8];
					            case 3
					                color = [0.4 0.5 0.6];
					            case 4
					                color = [0.6 0.5 0.4];
					            case 5
					                color = [0.8 0.5 0.2];
					            case 6
					                color = [0.9 0.5 0.1];
					            case 7
					                color = [0.6 0.6 0.6];
					            case 8
					                color = [0.7 0.7 0.7];
					            case 9
					                color = [0.8 0.8 0.8];
					        end
					        settings = [settings 'BKGCOLOR' color];
					    end
					    if ~isempty(settings)
					        pr.set(settings{:})
					    end
					end
					
				case 24 % PanelProp.PROP
					pr.lock('PROP', 'Iterative', false)
					if ~isa(pr.getr('EL'), 'NoValue')
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    settings = {};
					    if isa(pr.getr('ID'), 'NoValue')
					        settings = [settings 'ID' el.getPropTag(prop)];
					    end
					    if isa(pr.getr('TITLE'), 'NoValue')
					        settings = [settings 'TITLE' el.getPropTag(prop)];
					    end
					    if isa(pr.getr('BKGCOLOR'), 'NoValue')
					        switch el.getPropCategory(prop)
					            case 1
					                color = [0.5 0.5 0.5];
					            case 2
					                color = [0.2 0.5 0.8];
					            case 3
					                color = [0.4 0.5 0.6];
					            case 4
					                color = [0.6 0.5 0.4];
					            case 5
					                color = [0.8 0.5 0.2];
					            case 6
					                color = [0.9 0.5 0.1];
					            case 7
					                color = [0.6 0.6 0.6];
					            case 8
					                color = [0.7 0.7 0.7];
					            case 9
					                color = [0.8 0.8 0.8];
					        end
					        settings = [settings 'BKGCOLOR' color];
					    end
					    if ~isempty(settings)
					        pr.set(settings{:})
					    end
					end
					
				case 25 % PanelProp.HEIGHT
					if pr.get('DRAWN')
					    pr.get('REDRAW')
					end
					
				otherwise
					if prop <= 19
						postset@Panel(pr, prop);
					end
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
				case 20 % PanelProp.X_DRAW
					value = true;
					
				case 21 % PanelProp.UPDATE
					if pr.get('DRAWN')
					    switch pr.get('EL').getPropCategory(pr.get('PROP'))
					        case {1 2} % {Category.CONSTANT Category.METADATA}
					            %
					
					        case {3 4 8 9} % {Category.PARAMETER Category.DATA Category.FIGURE Category.GUI}
					            prop_value = pr.get('EL').getr(pr.get('PROP'));
					            if isa(prop_value, 'Callback')
					                set(pr.get('BUTTON_CB'), ...
					                    'Tooltip', prop_value.get('TOSTRING'), ...
					                    'Visible', 'on' ...
					                    )
					            else
					                set(pr.get('BUTTON_CB'), ...
					                    'Visible', 'off' ...
					                    )
					            end
					
					        case {5 7} % {Category.RESULT Category.EVANESCENT}
					            prop_value = pr.get('EL').getr(pr.get('PROP'));
					            if isa(prop_value, 'NoValue')
					                set(pr.get('BUTTON_CALC'), 'Enable', 'on')
					                set(pr.get('BUTTON_DEL'), 'Enable', 'off')
					            else
					                set(pr.get('BUTTON_CALC'), 'Enable', 'off')
					                set(pr.get('BUTTON_DEL'), 'Enable', 'on')
					            end
					            
					        case 6 % Category.QUERY
					            prop_value = get_from_varargin(pr.get('EL').getr(pr.get('PROP')), 'Value', varargin); % see BUTTON_CALC
					            if isa(prop_value, 'NoValue')
					                set(pr.get('BUTTON_CALC'), 'Enable', 'on')
					                set(pr.get('BUTTON_DEL'), 'Enable', 'off')
					            else
					                set(pr.get('BUTTON_CALC'), 'Enable', 'on')
					                set(pr.get('BUTTON_DEL'), 'Enable', 'on')
					            end
					            
					    end
					    
					    % resets the LISTENER_CB
					    pr.set('LISTENER_CB', Element.getNoValue())
					    pr.memorize('LISTENER_CB');
					    
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pr)], ...
					        ['BRAPH2' ':' class(pr) '\n' ...
					        'The call pr.get(''UPDATE'') has NOT been executed.\n' ...
					        'First, the prop panel ' pr.get('ID') ' should be drawn calling pr.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 22 % PanelProp.REDRAW
					if pr.get('DRAWN')
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    h_p = pr.get('HEIGHT'); % should be identical to h(pr.get('H'), 'pixels') 
					                            % the panel height should be set to this value 
					                            % by some external code controlling the PanelProp
					    
					    % places label_title to the top
					    set(pr.get('LABEL_TITLE'), 'Position', [4 h_p-16+1 w_p 16])
					
					    % places the relevant buttons (depending on category)
					    switch pr.get('EL').getPropCategory(pr.get('PROP'))
					        case {1 2} % {Category.CONSTANT Category.METADATA}
					            %
					
					        case {3 4 8 9} % {Category.PARAMETER Category.DATA Category.FIGURE Category.GUI}
					            set(pr.get('BUTTON_CB'), 'Position', [w_p-26 h_p-23 21 21])
					
					        case {5 6 7} % {Category.RESULT Category.QUERY Category.EVANESCENT}
					            set(pr.get('BUTTON_CALC'), 'Position', [w_p-51 h_p-23 21 21])
					            set(pr.get('BUTTON_DEL'), 'Position', [w_p-26 h_p-23 21 21])
					    end
					     
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pr)], ...
					        ['BRAPH2' ':' class(pr) '\n' ...
					        'The call pr.get(''REDRAW'') has NOT been executed.\n' ...
					        'First, the prop panel ' pr.get('ID') ' should be drawn calling pr.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 27 % PanelProp.LABEL_TITLE
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					pr_string_title = pr.get('TITLE');
					if isempty(pr_string_title)
					    pr_string_title = upper(el.getPropTag(prop));
					end
					
					label_title =  uilabel( ...
					    'Parent', pr.get('H'), ... % H = p for Panel
					    'Tag', 'LABEL_TAG', ...
					    'Text', pr_string_title, ...
					    'FontSize', 12, ...
					    'HorizontalAlignment', 'left', ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'BackgroundColor', pr.get('BKGCOLOR') ...
					    );
					
					value = label_title;
					
				case 28 % PanelProp.BUTTON_CB
					button_cb = uibutton( ...
					    'Parent', pr.get('H'), ... % H = p for Panel
					    'Tag', 'BUTTON_CB', ...
					    'Text', '@', ...
					    'FontWeight', 'bold', ...
					    'ButtonPushedFcn', {@cb_button_cb}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					value = button_cb;
					
				case 30 % PanelProp.LISTENER_CB
					el = pr.get('EL');
					prop = pr.get('PROP');
					if isa(el.getr(prop), 'Callback')
					    while isa(el.getr(prop), 'Callback')
					        cb = el.getr(prop);
					        el = cb.get('EL');
					        prop = cb.get('PROP');
					    end
					    value = listener(el, 'PropSet', @cb_listener_cb); 
					else
						value = gobjects(1);
					end
					
				case 31 % PanelProp.BUTTON_CALC
					button_calc = uibutton( ...
					    'Parent', pr.get('H'), ... % H = p for Panel
					    'Tag', 'BUTTON_CALC', ...
					    'Text', 'C', ...
					    'FontWeight', 'bold', ...
					    'Tooltip', 'Calculate', ...
					    'ButtonPushedFcn', {@cb_button_calc}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					value = button_calc;
					
				case 32 % PanelProp.BUTTON_DEL
					button_del = uibutton( ...
					    'Parent', pr.get('H'), ... % H = p for Panel
					    'Tag', 'BUTTON_DEL', ...
					    'Text', 'D', ...
					    'FontWeight', 'bold', ...
					    'Tooltip', 'Delete', ...
					    'ButtonPushedFcn', {@cb_button_del}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					value = button_del;
					
				case 33 % PanelProp.LISTENER_SET
					value = {listener(pr.get('EL'), 'PropSet', @cb_listener_set)};
					
				case 34 % PanelProp.LISTENER_MEMORIZED
					value = {listener(pr.get('EL'), 'PropMemorized', @cb_listener_memorized)};
					
				case 35 % PanelProp.LISTENER_LOCKED
					value = {listener(pr.get('EL'), 'PropLocked', @cb_listener_locked)};
					
				case 11 % PanelProp.DRAW
					value = calculateValue@Panel(pr, 11, varargin{:}); % also warning
					if value
					    switch pr.get('EL').getPropCategory(pr.get('PROP'))
					        case {1 2} % {Category.CONSTANT Category.METADATA}
					            pr.memorize('LABEL_TITLE')
					
					            pr.memorize('LISTENER_SET')
					            pr.memorize('LISTENER_LOCKED')
					
					        case {3 4 8 9} % {Category.PARAMETER Category.DATA Category.FIGURE Category.GUI}
					            pr.memorize('LABEL_TITLE')
					
					            pr.memorize('BUTTON_CB')
					
					            pr.memorize('LISTENER_SET')
					            pr.memorize('LISTENER_LOCKED')
					
					        case {5 6 7} % {Category.RESULT Category.QUERY Category.EVANESCENT}
					            pr.memorize('LABEL_TITLE')
					
					            pr.memorize('BUTTON_CALC')
					            pr.memorize('BUTTON_DEL')
					
					            pr.memorize('LISTENER_SET')
					            pr.memorize('LISTENER_MEMORIZED')
					            pr.memorize('LISTENER_LOCKED')
					    end
					
					    pr.get('X_DRAW')    
					    pr.get('UPDATE')
					    pr.get('REDRAW')
					end
					
				case 16 % PanelProp.SHOW
					if pr.get('DRAWN')
					
					    calculateValue@Panel(pr, 16, varargin{:}); % 16 = Panel.SHOW
					
					    % figure cb
					    if isa(pr.getr('GUI_CB'), 'GUI') && pr.get('GUI_CB').get('DRAWN')
					        pr.get('GUI_CB').get('SHOW')
					    end
					    
						value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pr)], ...
					        ['BRAPH2' ':' class(pr) '\n' ...
					        'The call pr.get(''SHOW'') has NOT been executed.\n' ...
					        'First, the panel ' pr.get('ID') ' should be drawn calling pr.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 17 % PanelProp.HIDE
					if pr.get('DRAWN')
					
					    calculateValue@Panel(pr, 17, varargin{:}); % 17 = Panel.HIDE
					    
					    % figure cb
					    if isa(pr.getr('GUI_CB'), 'GUI') && pr.get('GUI_CB').get('DRAWN')
					        pr.get('GUI_CB').get('HIDE')
					    end
					    
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pr)], ...
					        ['BRAPH2' ':' class(pr) '\n' ...
					        'The call pr.get(''HIDE'') has NOT been executed.\n' ...
					        'First, the panel ' pr.get('ID') ' should be drawn calling pr.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 18 % PanelProp.DELETE
					value = calculateValue@Panel(pr, 18, varargin{:}); % 18 = Panel.DELETE % also warning
					if value
					    pr.set('LABEL_TITLE', Element.getNoValue())
					    
					    pr.set('BUTTON_CB', Element.getNoValue())
					    pr.set('LISTENER_CB', Element.getNoValue())
					
					    pr.set('BUTTON_CALC', Element.getNoValue())
					    pr.set('BUTTON_DEL', Element.getNoValue())
					    
					    pr.set('LISTENER_SET', Element.getNoValue())
					    pr.set('LISTENER_MEMORIZED', Element.getNoValue())
					    pr.set('LISTENER_LOCKED', Element.getNoValue())   
					end
					
				case 19 % PanelProp.CLOSE
					if pr.get('DRAWN')
					
					    calculateValue@Panel(pr, 19, varargin{:}); % 19 = Panel.CLOSE
					    
					    % figure cb
					    if isa(pr.getr('GUI_CB'), 'GUI') && pr.get('GUI_CB').get('DRAWN')
					        pr.get('GUI_CB').get('CLOSE')
					    end
					    
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pr)], ...
					        ['BRAPH2' ':' class(pr) '\n' ...
					        'The call pr.get(''CLOSE'') has NOT been executed.\n' ...
					        'First, the panel ' pr.get('ID') ' should be drawn calling pr.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				otherwise
					if prop <= 19
						value = calculateValue@Panel(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_button_cb(~, ~)
			    gui_cb = pr.memorize('GUI_CB');
			
			    if ~gui_cb.get('DRAWN')
			        gui_cb.get('DRAW')
			        gui_cb.get('SHOW')
			    else
			        if get(gui_cb.get('H'), 'Visible')
			            gui_cb.get('HIDE')
			        else
			            gui_cb.get('SHOW')
			        end
			    end
			end
			function cb_listener_cb(~, event)
			    if any(cellfun(@(prop) prop, event.props), pr.get('PROP'))
			        pr.get('UPDATE')
			    end
			end
			function cb_button_calc(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    switch el.getPropCategory(prop)
			        case {5 7}
			
			            el.memorize(prop);
			            
			            pr.get('UPDATE')
			            pr.get('REDRAW')
			            
			        case 6
			            
			            value = el.get(prop);
			            
			            pr.get('UPDATE', 'Value', value)
			            pr.get('REDRAW')
			            
			    end
			end
			function cb_button_del(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.set(prop, NoValue.getNoValue())
			    
			    pr.get('UPDATE')
			    pr.get('REDRAW')    
			end
			function cb_listener_set(~, event)
			    if ismember(pr.get('PROP'), cell2mat(event.props)) && pr.get('DRAWN')
			        pr.get('UPDATE')
			        pr.get('REDRAW')        
			    end
			end
			function cb_listener_memorized(~, event)
			    if pr.get('PROP') == event.prop && pr.get('DRAWN')
			        pr.get('UPDATE')
			        pr.get('REDRAW')        
			    end
			end
			function cb_listener_locked(~, event)
			    if pr.get('PROP') == event.prop && pr.get('DRAWN')
			        pr.get('UPDATE')
			        pr.get('REDRAW')
			    end
			end
		end
	end
end
