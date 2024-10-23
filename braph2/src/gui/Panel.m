classdef Panel < ConcreteElement
	%Panel is a panel.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Panel is the basic element to manage graphical representations of elements.
	%  It is an empty graphical panel. It is filled with the graphical content 
	%  representing an element (PanelElement) or figure (PanelFig) or property 
	%  (typically, PanelProp and derived classes). It must be placed within 
	%  another container; for example, a figure (e.g., PanelElement into 
	%  GUIElement, or PanelFig into GUIFig) or another panel (e.g., PanelProp 
	%  into PanelElement).
	% 
	% CONSTRUCTOR - To construct a Panel use, e.g.:
	% 
	%     pn = Panel('<strong>PARENT</strong>', <parent element>);
	% 
	%  where the <parent element> can be a GUI or a Panel.
	% 
	% DRAW - To draw the panel, call:
	%     
	%     pn.get('<strong>DRAW</strong>'[, 'Name', <value>, ...])
	%     p = pn.get('<strong>H</strong>'); % p is the handle of the generated panel
	%  
	%  The query pn.get('<strong>DRAWN</strong>') returns whether the Panel has 
	%   been drawn and therefore can be shown.
	% 
	% CALLBACKS - These are the public callback (to be further implemented by the derived panels):
	% 
	%     pn.get('<strong>SHOW</strong>') - shows the figure containing the panel.
	%     pn.get('<strong>HIDE</strong>') - hides the figure containing the panel.
	%     pn.get('<strong>DELETE</strong>') - resets the handles when the panel is deleted.
	%     pn.get('<strong>CLOSE</strong>') - closes the figure containing the panel.
	%
	% The list of Panel properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the panel [accepts uipanel Name-Value pairs].
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel.
	%
	% Panel methods (constructor):
	%  Panel - constructor
	%
	% Panel methods:
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
	% Panel methods (display):
	%  tostring - string with information about the panel
	%  disp - displays information about the panel
	%  tree - displays the tree of the panel
	%
	% Panel methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel
	%
	% Panel methods (save/load, Static):
	%  save - saves BRAPH2 panel as b2 file
	%  load - loads a BRAPH2 panel from a b2 file
	%
	% Panel method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel
	%
	% Panel method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel
	%
	% Panel methods (inspection, Static):
	%  getClass - returns the class of the panel
	%  getSubclasses - returns all subclasses of Panel
	%  getProps - returns the property list of the panel
	%  getPropNumber - returns the property number of the panel
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
	% Panel methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Panel methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Panel methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Panel methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Panel; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Panel constants</a>.
	%
	%
	% See also uipanel, PanelElement, PanelProp, PanelFig, GUI, GUIElement, GUIFig.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		WAITBAR = 9; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
		
		H_WAITBAR = 10; %CET: Computational Efficiency Trick
		H_WAITBAR_TAG = 'H_WAITBAR';
		H_WAITBAR_CATEGORY = 7;
		H_WAITBAR_FORMAT = 18;
		
		DRAW = 11; %CET: Computational Efficiency Trick
		DRAW_TAG = 'DRAW';
		DRAW_CATEGORY = 6;
		DRAW_FORMAT = 4;
		
		DRAWN = 12; %CET: Computational Efficiency Trick
		DRAWN_TAG = 'DRAWN';
		DRAWN_CATEGORY = 6;
		DRAWN_FORMAT = 4;
		
		PARENT = 13; %CET: Computational Efficiency Trick
		PARENT_TAG = 'PARENT';
		PARENT_CATEGORY = 9;
		PARENT_FORMAT = 8;
		
		BKGCOLOR = 14; %CET: Computational Efficiency Trick
		BKGCOLOR_TAG = 'BKGCOLOR';
		BKGCOLOR_CATEGORY = 8;
		BKGCOLOR_FORMAT = 20;
		
		H = 15; %CET: Computational Efficiency Trick
		H_TAG = 'H';
		H_CATEGORY = 7;
		H_FORMAT = 18;
		
		SHOW = 16; %CET: Computational Efficiency Trick
		SHOW_TAG = 'SHOW';
		SHOW_CATEGORY = 6;
		SHOW_FORMAT = 4;
		
		HIDE = 17; %CET: Computational Efficiency Trick
		HIDE_TAG = 'HIDE';
		HIDE_CATEGORY = 6;
		HIDE_FORMAT = 4;
		
		DELETE = 18; %CET: Computational Efficiency Trick
		DELETE_TAG = 'DELETE';
		DELETE_CATEGORY = 6;
		DELETE_FORMAT = 4;
		
		CLOSE = 19; %CET: Computational Efficiency Trick
		CLOSE_TAG = 'CLOSE';
		CLOSE_CATEGORY = 6;
		CLOSE_FORMAT = 4;
	end
	methods % constructor
		function pn = Panel(varargin)
			%Panel() creates a panel.
			%
			% Panel(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Panel(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Panel properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the panel [accepts uipanel Name-Value pairs].
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel.
			%
			% See also Category, Format.
			
			pn = pn@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the panel.
			%
			% BUILD = Panel.GETBUILD() returns the build of 'Panel'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PN.GETBUILD() returns the build of the panel PN.
			%  BUILD = Element.GETBUILD(PN) returns the build of 'PN'.
			%  BUILD = Element.GETBUILD('Panel') returns the build of 'Panel'.
			%
			% Note that the Element.GETBUILD(PN) and Element.GETBUILD('Panel')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pn_class = getClass()
			%GETCLASS returns the class of the panel.
			%
			% CLASS = Panel.GETCLASS() returns the class 'Panel'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PN.GETCLASS() returns the class of the panel PN.
			%  CLASS = Element.GETCLASS(PN) returns the class of 'PN'.
			%  CLASS = Element.GETCLASS('Panel') returns 'Panel'.
			%
			% Note that the Element.GETCLASS(PN) and Element.GETCLASS('Panel')
			%  are less computationally efficient.
			
			pn_class = 'Panel';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel.
			%
			% LIST = Panel.GETSUBCLASSES() returns all subclasses of 'Panel'.
			%
			% Alternative forms to call this method are:
			%  LIST = PN.GETSUBCLASSES() returns all subclasses of the panel PN.
			%  LIST = Element.GETSUBCLASSES(PN) returns all subclasses of 'PN'.
			%  LIST = Element.GETSUBCLASSES('Panel') returns all subclasses of 'Panel'.
			%
			% Note that the Element.GETSUBCLASSES(PN) and Element.GETSUBCLASSES('Panel')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'Panel'  'NNClassifierMLP_CrossValidationPF_ROC'  'NNClassifierMLP_EvaluatorPF_ROC'  'NNRegressorMLP_CrossValidationPF_Scatter'  'NNRegressorMLP_EvaluatorPF_Scatter'  'NNxMLP_FeatureImportanceBSPF_xSPP_Layer'  'NNxMLP_FeatureImportanceBSPF_xUPP_Layer'  'NNxMLP_FeatureImportanceBrainSurfacePF'  'NNxMLP_FeatureImportanceBrainSurfacePF_BB'  'NNxMLP_FeatureImportanceBrainSurfacePF_BS'  'NNxMLP_FeatureImportanceBrainSurfacePF_BU'  'NNxMLP_FeatureImportanceBrainSurfacePF_GB'  'NNxMLP_FeatureImportanceBrainSurfacePF_GS'  'NNxMLP_FeatureImportanceBrainSurfacePF_GU'  'NNxMLP_FeatureImportanceBrainSurfacePF_NB'  'NNxMLP_FeatureImportanceBrainSurfacePF_NS'  'NNxMLP_FeatureImportanceBrainSurfacePF_NU'  'NNxMLP_FeatureImportanceBrainSurfacePP_Data'  'NNxMLP_FeatureImportanceBrainSurfacePP_Graph'  'NNxMLP_FeatureImportanceBrainSurfacePP_Measure'  'AnalyzeEnsemblePP_GDict'  'AnalyzeEnsemblePP_MeDict'  'AnalyzeGroupPP_G'  'CompareEnsemblePP_CpDict'  'CompareGroupPP_CpDict'  'ComparisonEnsembleBrainPF'  'ComparisonEnsembleBrainPF_BB'  'ComparisonEnsembleBrainPF_BS'  'ComparisonEnsembleBrainPF_BU'  'ComparisonEnsembleBrainPF_GB'  'ComparisonEnsembleBrainPF_GS'  'ComparisonEnsembleBrainPF_GU'  'ComparisonEnsembleBrainPF_NB'  'ComparisonEnsembleBrainPF_NS'  'ComparisonEnsembleBrainPF_NU'  'ComparisonEnsembleBrainPF_xSPP_Layer'  'ComparisonEnsembleBrainPF_xUPP_Layer'  'ComparisonEnsemblePF'  'ComparisonEnsemblePF_BB'  'ComparisonEnsemblePF_BS'  'ComparisonEnsemblePF_BU'  'ComparisonEnsemblePF_BxPP_Nodes'  'ComparisonEnsemblePF_GB'  'ComparisonEnsemblePF_GS'  'ComparisonEnsemblePF_GU'  'ComparisonEnsemblePF_NB'  'ComparisonEnsemblePF_NS'  'ComparisonEnsemblePF_NU'  'ComparisonEnsemblePF_NxPP_Node'  'ComparisonEnsemblePF_xUPP_Layer'  'ComparisonGroupBrainPF'  'ComparisonGroupBrainPF_BB'  'ComparisonGroupBrainPF_BS'  'ComparisonGroupBrainPF_BU'  'ComparisonGroupBrainPF_GB'  'ComparisonGroupBrainPF_GS'  'ComparisonGroupBrainPF_GU'  'ComparisonGroupBrainPF_NB'  'ComparisonGroupBrainPF_NS'  'ComparisonGroupBrainPF_NU'  'ComparisonGroupBrainPF_xSPP_Layer'  'ComparisonGroupBrainPF_xUPP_Layer'  'ComparisonGroupPF'  'ComparisonGroupPF_BB'  'ComparisonGroupPF_BS'  'ComparisonGroupPF_BU'  'ComparisonGroupPF_BxPP_Nodes'  'ComparisonGroupPF_GB'  'ComparisonGroupPF_GS'  'ComparisonGroupPF_GU'  'ComparisonGroupPF_NB'  'ComparisonGroupPF_NS'  'ComparisonGroupPF_NU'  'ComparisonGroupPF_NxPP_Node'  'ComparisonGroupPF_xUPP_Layer'  'MeasureEnsembleBrainPF'  'MeasureEnsembleBrainPF_BB'  'MeasureEnsembleBrainPF_BS'  'MeasureEnsembleBrainPF_BU'  'MeasureEnsembleBrainPF_GB'  'MeasureEnsembleBrainPF_GS'  'MeasureEnsembleBrainPF_GU'  'MeasureEnsembleBrainPF_NB'  'MeasureEnsembleBrainPF_NS'  'MeasureEnsembleBrainPF_NU'  'MeasureEnsembleBrainPF_xSPP_Layer'  'MeasureEnsembleBrainPF_xUPP_Layer'  'MeasureEnsemblePF'  'MeasureEnsemblePF_BB'  'MeasureEnsemblePF_BS'  'MeasureEnsemblePF_BU'  'MeasureEnsemblePF_BxPP_Nodes'  'MeasureEnsemblePF_GB'  'MeasureEnsemblePF_GS'  'MeasureEnsemblePF_GU'  'MeasureEnsemblePF_NB'  'MeasureEnsemblePF_NS'  'MeasureEnsemblePF_NU'  'MeasureEnsemblePF_NxPP_Node'  'MeasureEnsemblePF_xUPP_Layer'  'MeasureGroupBrainPF'  'MeasureGroupBrainPF_BB'  'MeasureGroupBrainPF_BS'  'MeasureGroupBrainPF_BU'  'MeasureGroupBrainPF_GB'  'MeasureGroupBrainPF_GS'  'MeasureGroupBrainPF_GU'  'MeasureGroupBrainPF_NB'  'MeasureGroupBrainPF_NS'  'MeasureGroupBrainPF_NU'  'MeasureGroupBrainPF_xSPP_Layer'  'MeasureGroupBrainPF_xUPP_Layer'  'PanelPropCellFDR'  'BrainAtlasPF'  'BrainSurfacePF'  'SubjectPP_VOIDict'  'GraphAdjPF'  'GraphHistPF'  'GraphPP_MDict'  'LayersPP'  'MeasurePF'  'MeasurePF_BB'  'MeasurePF_BS'  'MeasurePF_BU'  'MeasurePF_BxPP_Nodes'  'MeasurePF_GB'  'MeasurePF_GS'  'MeasurePF_GU'  'MeasurePF_NB'  'MeasurePF_NS'  'MeasurePF_NU'  'MeasurePF_NxPP_Node'  'MeasurePF_xUPP_Layer'  'PanelElement'  'PanelFig'  'PanelProp'  'PanelPropAlpha'  'PanelPropCell'  'PanelPropClass'  'PanelPropClassList'  'PanelPropColor'  'PanelPropIDict'  'PanelPropIDictTable'  'PanelPropItem'  'PanelPropItemList'  'PanelPropLine'  'PanelPropLogical'  'PanelPropMarker'  'PanelPropMatrix'  'PanelPropNet'  'PanelPropOption'  'PanelPropRVectorSmart'  'PanelPropRVectorView'  'PanelPropScalar'  'PanelPropSize'  'PanelPropString'  'PanelPropStringList'  'PanelPropStringTextArea'  'PipelinePP_Notes'  'PipelinePP_PSDict'  'SettingsAmbientPP'  'SettingsAreaPP'  'SettingsAxisPP'  'SettingsLinePP'  'SettingsPP'  'SettingsPositionPP'  'SettingsSurfacePP'  'SettingsTextPP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel.
			%
			% PROPS = Panel.GETPROPS() returns the property list of panel
			%  as a row vector.
			%
			% PROPS = Panel.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PN.GETPROPS([CATEGORY]) returns the property list of the panel PN.
			%  PROPS = Element.GETPROPS(PN[, CATEGORY]) returns the property list of 'PN'.
			%  PROPS = Element.GETPROPS('Panel'[, CATEGORY]) returns the property list of 'Panel'.
			%
			% Note that the Element.GETPROPS(PN) and Element.GETPROPS('Panel')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19];
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
					prop_list = 5;
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19];
				case 7 % Category.EVANESCENT
					prop_list = [10 15];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel.
			%
			% N = Panel.GETPROPNUMBER() returns the property number of panel.
			%
			% N = Panel.GETPROPNUMBER(CATEGORY) returns the property number of panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PN.GETPROPNUMBER([CATEGORY]) returns the property number of the panel PN.
			%  N = Element.GETPROPNUMBER(PN) returns the property number of 'PN'.
			%  N = Element.GETPROPNUMBER('Panel') returns the property number of 'Panel'.
			%
			% Note that the Element.GETPROPNUMBER(PN) and Element.GETPROPNUMBER('Panel')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 19;
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
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 7;
				case 7 % Category.EVANESCENT
					prop_number = 2;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel/error.
			%
			% CHECK = Panel.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PN.EXISTSPROP(PROP) checks whether PROP exists for PN.
			%  CHECK = Element.EXISTSPROP(PN, PROP) checks whether PROP exists for PN.
			%  CHECK = Element.EXISTSPROP(Panel, PROP) checks whether PROP exists for Panel.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Panel:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PN.EXISTSPROP(PROP) throws error if PROP does NOT exist for PN.
			%   Error id: [BRAPH2:Panel:WrongInput]
			%  Element.EXISTSPROP(PN, PROP) throws error if PROP does NOT exist for PN.
			%   Error id: [BRAPH2:Panel:WrongInput]
			%  Element.EXISTSPROP(Panel, PROP) throws error if PROP does NOT exist for Panel.
			%   Error id: [BRAPH2:Panel:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PN) and Element.EXISTSPROP('Panel')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 19 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Panel:' 'WrongInput'], ...
					['BRAPH2' ':Panel:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Panel.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel/error.
			%
			% CHECK = Panel.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PN.EXISTSTAG(TAG) checks whether TAG exists for PN.
			%  CHECK = Element.EXISTSTAG(PN, TAG) checks whether TAG exists for PN.
			%  CHECK = Element.EXISTSTAG(Panel, TAG) checks whether TAG exists for Panel.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Panel:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PN.EXISTSTAG(TAG) throws error if TAG does NOT exist for PN.
			%   Error id: [BRAPH2:Panel:WrongInput]
			%  Element.EXISTSTAG(PN, TAG) throws error if TAG does NOT exist for PN.
			%   Error id: [BRAPH2:Panel:WrongInput]
			%  Element.EXISTSTAG(Panel, TAG) throws error if TAG does NOT exist for Panel.
			%   Error id: [BRAPH2:Panel:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PN) and Element.EXISTSTAG('Panel')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Panel:' 'WrongInput'], ...
					['BRAPH2' ':Panel:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for Panel.'] ...
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
			%  PROPERTY = PN.GETPROPPROP(POINTER) returns property number of POINTER of PN.
			%  PROPERTY = Element.GETPROPPROP(Panel, POINTER) returns property number of POINTER of Panel.
			%  PROPERTY = PN.GETPROPPROP(Panel, POINTER) returns property number of POINTER of Panel.
			%
			% Note that the Element.GETPROPPROP(PN) and Element.GETPROPPROP('Panel')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = PN.GETPROPTAG(POINTER) returns tag of POINTER of PN.
			%  TAG = Element.GETPROPTAG(Panel, POINTER) returns tag of POINTER of Panel.
			%  TAG = PN.GETPROPTAG(Panel, POINTER) returns tag of POINTER of Panel.
			%
			% Note that the Element.GETPROPTAG(PN) and Element.GETPROPTAG('Panel')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				panel_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE' };
				tag = panel_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = PN.GETPROPCATEGORY(POINTER) returns category of POINTER of PN.
			%  CATEGORY = Element.GETPROPCATEGORY(Panel, POINTER) returns category of POINTER of Panel.
			%  CATEGORY = PN.GETPROPCATEGORY(Panel, POINTER) returns category of POINTER of Panel.
			%
			% Note that the Element.GETPROPCATEGORY(PN) and Element.GETPROPCATEGORY('Panel')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Panel.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panel_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6 };
			prop_category = panel_category_list{prop};
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
			%  FORMAT = PN.GETPROPFORMAT(POINTER) returns format of POINTER of PN.
			%  FORMAT = Element.GETPROPFORMAT(Panel, POINTER) returns format of POINTER of Panel.
			%  FORMAT = PN.GETPROPFORMAT(Panel, POINTER) returns format of POINTER of Panel.
			%
			% Note that the Element.GETPROPFORMAT(PN) and Element.GETPROPFORMAT('Panel')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Panel.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panel_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4 };
			prop_format = panel_format_list{prop};
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
			%  DESCRIPTION = PN.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PN.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Panel, POINTER) returns description of POINTER of Panel.
			%  DESCRIPTION = PN.GETPROPDESCRIPTION(Panel, POINTER) returns description of POINTER of Panel.
			%
			% Note that the Element.GETPROPDESCRIPTION(PN) and Element.GETPROPDESCRIPTION('Panel')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Panel.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panel_description_list = { 'ELCLASS (constant, string) is the class of the panel.'  'NAME (constant, string) is the name of the panel.'  'DESCRIPTION (constant, string) is the description of the panel.'  'TEMPLATE (parameter, item) is the template of the panel.'  'ID (data, string) is a few-letter code for the panel.'  'LABEL (metadata, string) is an extended label of the panel.'  'NOTES (metadata, string) are some specific notes about the panel.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the panel [accepts uipanel Name-Value pairs].'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel.'  'HIDE (query, logical) hides the figure containing the panel.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel.' };
			prop_description = panel_description_list{prop};
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
			%  SETTINGS = PN.GETPROPSETTINGS(POINTER) returns settings of POINTER of PN.
			%  SETTINGS = Element.GETPROPSETTINGS(Panel, POINTER) returns settings of POINTER of Panel.
			%  SETTINGS = PN.GETPROPSETTINGS(Panel, POINTER) returns settings of POINTER of Panel.
			%
			% Note that the Element.GETPROPSETTINGS(PN) and Element.GETPROPSETTINGS('Panel')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Panel.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % Panel.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 10 % Panel.H_WAITBAR
					prop_settings = Format.getFormatSettings(18);
				case 11 % Panel.DRAW
					prop_settings = Format.getFormatSettings(4);
				case 12 % Panel.DRAWN
					prop_settings = Format.getFormatSettings(4);
				case 13 % Panel.PARENT
					prop_settings = Format.getFormatSettings(8);
				case 14 % Panel.BKGCOLOR
					prop_settings = Format.getFormatSettings(20);
				case 15 % Panel.H
					prop_settings = Format.getFormatSettings(18);
				case 16 % Panel.SHOW
					prop_settings = Format.getFormatSettings(4);
				case 17 % Panel.HIDE
					prop_settings = Format.getFormatSettings(4);
				case 18 % Panel.DELETE
					prop_settings = Format.getFormatSettings(4);
				case 19 % Panel.CLOSE
					prop_settings = Format.getFormatSettings(4);
				case 4 % Panel.TEMPLATE
					prop_settings = 'Panel';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Panel.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Panel.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PN.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PN.
			%  DEFAULT = Element.GETPROPDEFAULT(Panel, POINTER) returns the default value of POINTER of Panel.
			%  DEFAULT = PN.GETPROPDEFAULT(Panel, POINTER) returns the default value of POINTER of Panel.
			%
			% Note that the Element.GETPROPDEFAULT(PN) and Element.GETPROPDEFAULT('Panel')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Panel.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % Panel.WAITBAR
					prop_default = Format.getFormatDefault(4, Panel.getPropSettings(prop));
				case 10 % Panel.H_WAITBAR
					prop_default = Format.getFormatDefault(18, Panel.getPropSettings(prop));
				case 11 % Panel.DRAW
					prop_default = Format.getFormatDefault(4, Panel.getPropSettings(prop));
				case 12 % Panel.DRAWN
					prop_default = Format.getFormatDefault(4, Panel.getPropSettings(prop));
				case 13 % Panel.PARENT
					prop_default = GUI();
				case 14 % Panel.BKGCOLOR
					prop_default = [1 0.9725 0.929];
				case 15 % Panel.H
					prop_default = Format.getFormatDefault(18, Panel.getPropSettings(prop));
				case 16 % Panel.SHOW
					prop_default = Format.getFormatDefault(4, Panel.getPropSettings(prop));
				case 17 % Panel.HIDE
					prop_default = Format.getFormatDefault(4, Panel.getPropSettings(prop));
				case 18 % Panel.DELETE
					prop_default = Format.getFormatDefault(4, Panel.getPropSettings(prop));
				case 19 % Panel.CLOSE
					prop_default = Format.getFormatDefault(4, Panel.getPropSettings(prop));
				case 1 % Panel.ELCLASS
					prop_default = 'Panel';
				case 2 % Panel.NAME
					prop_default = 'Panel';
				case 3 % Panel.DESCRIPTION
					prop_default = 'A Panel is the basic element to manage graphical representations of elements. It is an empty graphical panel. It is filled with the graphical content representing an element (PanelElement) or figure (PanelFig) or property (typically, PanelProp and derived classes). It must be placed within another container; for example, a figure (e.g., PanelElement into GUIElement, or PanelFig into GUIFig) or another panel (e.g., PanelProp into PanelElement).';
				case 4 % Panel.TEMPLATE
					prop_default = Format.getFormatDefault(8, Panel.getPropSettings(prop));
				case 5 % Panel.ID
					prop_default = 'Panel ID';
				case 6 % Panel.LABEL
					prop_default = 'Panel label';
				case 7 % Panel.NOTES
					prop_default = 'Panel notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Panel.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Panel.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PN.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PN.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Panel, POINTER) returns the conditioned default value of POINTER of Panel.
			%  DEFAULT = PN.GETPROPDEFAULTCONDITIONED(Panel, POINTER) returns the conditioned default value of POINTER of Panel.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PN) and Element.GETPROPDEFAULTCONDITIONED('Panel')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Panel.getPropProp(pointer);
			
			prop_default = Panel.conditioning(prop, Panel.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PN.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PN.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PN.
			%  CHECK = Element.CHECKPROP(Panel, PROP, VALUE) checks VALUE format for PROP of Panel.
			%  CHECK = PN.CHECKPROP(Panel, PROP, VALUE) checks VALUE format for PROP of Panel.
			% 
			% PN.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:Panel:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PN.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PN.
			%   Error id: BRAPH2:Panel:WrongInput
			%  Element.CHECKPROP(Panel, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Panel.
			%   Error id: BRAPH2:Panel:WrongInput
			%  PN.CHECKPROP(Panel, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Panel.
			%   Error id: BRAPH2:Panel:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PN) and Element.CHECKPROP('Panel')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Panel.getPropProp(pointer);
			
			switch prop
				case 9 % Panel.WAITBAR
					check = Format.checkFormat(4, value, Panel.getPropSettings(prop));
				case 10 % Panel.H_WAITBAR
					check = Format.checkFormat(18, value, Panel.getPropSettings(prop));
				case 11 % Panel.DRAW
					check = Format.checkFormat(4, value, Panel.getPropSettings(prop));
				case 12 % Panel.DRAWN
					check = Format.checkFormat(4, value, Panel.getPropSettings(prop));
				case 13 % Panel.PARENT
					check = Format.checkFormat(8, value, Panel.getPropSettings(prop));
					if check
						check = isa(value, 'GUI') || isa(value, 'Panel');
					end
				case 14 % Panel.BKGCOLOR
					check = Format.checkFormat(20, value, Panel.getPropSettings(prop));
				case 15 % Panel.H
					check = Format.checkFormat(18, value, Panel.getPropSettings(prop));
				case 16 % Panel.SHOW
					check = Format.checkFormat(4, value, Panel.getPropSettings(prop));
				case 17 % Panel.HIDE
					check = Format.checkFormat(4, value, Panel.getPropSettings(prop));
				case 18 % Panel.DELETE
					check = Format.checkFormat(4, value, Panel.getPropSettings(prop));
				case 19 % Panel.CLOSE
					check = Format.checkFormat(4, value, Panel.getPropSettings(prop));
				case 4 % Panel.TEMPLATE
					check = Format.checkFormat(8, value, Panel.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Panel:' 'WrongInput'], ...
					['BRAPH2' ':Panel:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Panel.getPropTag(prop) ' (' Panel.getFormatTag(Panel.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pn, prop)
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
				case 13 % Panel.PARENT
					if check_graphics(pn.getr('H'), 'uipanel') % H = p for panel
					    set(pn.get('H'), 'Parent', pn.get('PARENT').get('H')) % H = f for GUI and H = p for Panel
					end
					
				case 14 % Panel.BKGCOLOR
					if pn.get('DRAWN') && ~isequal(get(pn.get('H'), 'BackgroundColor'), pn.get('BKGCOLOR'))
					    set(pn.get('H'), 'BackgroundColor', pn.get('BKGCOLOR'))
					end
					
				otherwise
					if prop <= 8
						postset@ConcreteElement(pn, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pn, prop, varargin)
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
				case 11 % Panel.DRAW
					if check_graphics(pn.memorize('H'), 'uipanel') % H = p for panel
					    p = pn.get('H');
					    
					    if ~isempty(varargin)
					        set(p, varargin{:})
					    end
					    
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pn)], ...
					        ['BRAPH2' ':' class(pn) '\n' ...
					        'The call pn.get(''DRAW'') did not work.\n' ...
					        'This shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 12 % Panel.DRAWN
					value = check_graphics(pn.getr('H'), 'uipanel'); % H = p for panel
					
				case 15 % Panel.H
					p = uipanel( ...
					    'Parent', pn.memorize('PARENT').memorize('H'), ... % H = f for GUI and H = p for Panel
					    'Tag', 'H', ...
					    'UserData', pn, ... % handle to retrieve the panel
					    'BackgroundColor', pn.get('BKGCOLOR'), ...
					    'BorderType', 'none', ...
					    'DeleteFcn', {@cb_get, 'DELETE'} ...
					    );
					value = p;
					
				case 16 % Panel.SHOW
					if pn.get('DRAWN')
					    if get_from_varargin(true, 'ShowParentFigure', varargin)
					        pn.get('PARENT').get('SHOW')
					    end
					    
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pn)], ...
					        ['BRAPH2' ':' class(pn) '\n' ...
					        'The call pn.get(''SHOW'') has NOT been executed.\n' ...
					        'First, the panel ' pn.get('ID') ' should be drawn calling pn.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 17 % Panel.HIDE
					if pn.get('DRAWN')
					    if get_from_varargin(true, 'HideParentFigure', varargin)
					        pn.get('PARENT').get('HIDE')
					    end
					    
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pn)], ...
					        ['BRAPH2' ':' class(pn) '\n' ...
					        'The call pn.get(''HIDE'') has NOT been executed.\n' ...
					        'First, the panel ' pn.get('ID') ' should be drawn calling pn.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 18 % Panel.DELETE
					if pn.get('DRAWN')
					    pn.set('H', Element.getNoValue())
					
					    pn.set('H_WAITBAR', Element.getNoValue())
					    
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pn)], ...
					        ['BRAPH2' ':' class(pn) '\n' ...
					        'The call pn.get(''DELETE'') has NOT been executed.\n' ...
					        'First, the panel ' pn.get('ID') ' should be drawn calling pn.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 19 % Panel.CLOSE
					if pn.get('DRAWN')
					    if get_from_varargin(true, 'CloseParentFigure', varargin)
					        pn.get('PARENT').get('CLOSE')
					    end
					    
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pn)], ...
					        ['BRAPH2' ':' class(pn) '\n' ...
					        'The call pn.get(''CLOSE'') has NOT been executed.\n' ...
					        'First, the panel ' pn.get('ID') ' should be drawn calling pn.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(pn, prop, varargin{:});
					else
						value = calculateValue@Element(pn, prop, varargin{:});
					end
			end
			
			function cb_get(~, ~, varargin)
				pn.get(varargin{:})
			end
		end
	end
end
