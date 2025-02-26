classdef PanelFig < Panel
	%PanelFig plots the panel of a figure.
	% It is a subclass of <a href="matlab:help Panel">Panel</a>.
	%
	% A Figure Panel (PanelFig) plots a figure.
	% 
	% CONSTRUCTOR - To construct a PanelFig use, e.g.:
	% 
	%     pf = PanelFig('<strong>PARENT</strong>', <parent element>)
	%   
	%  where the <parent element> can be a GUI or a Panel, 
	%   but most often a GUIFig.
	%   
	% DRAW - To draw the panel, call:
	% 
	%     pf.get('<strong>DRAW</strong>'[, 'Name', <value>, ...])
	%     p = pf.get('<strong>H</strong>'); % p is the handle of the generated panel
	%  
	%  The query pf.get('<strong>DRAWN</strong>') returns whether the Panel has 
	%   been drawn and therefore can be shown.
	%   
	% CALLBACKS - These are the public callback (to be further implemented by the derived panels):
	% 
	%     pf.get('<strong>SHOW</strong>') - shows the figure containing the panel.
	%     pf.get('<strong>HIDE</strong>') - hides the figure containing the panel.
	%     pf.get('<strong>DELETE</strong>') - resets the handles when the panel is deleted.
	%     pf.get('<strong>CLOSE</strong>') - closes the figure containing the panel.
	%     pf.get('<strong>RESIZEX</strong>') - resizes the x-extension of the element panel and its prop panels.
	%     pf.get('<strong>RESIZEY</strong>') - resizes the y-extension of the element panel and its prop panels.
	%
	% The list of PanelFig properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the figure panel.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the figure panel.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the figure panel.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the figure panel.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the figure panel.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the figure panel.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the figure panel.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the figure panel.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the figure panel is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel.
	%  <strong>20</strong> <strong>ST_POSITION</strong> 	ST_POSITION (figure, item) determines the panel position.
	%  <strong>21</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.
	%  <strong>22</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
	%
	% PanelFig methods (constructor):
	%  PanelFig - constructor
	%
	% PanelFig methods:
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
	% PanelFig methods (display):
	%  tostring - string with information about the figure panel
	%  disp - displays information about the figure panel
	%  tree - displays the tree of the figure panel
	%
	% PanelFig methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two figure panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the figure panel
	%
	% PanelFig methods (save/load, Static):
	%  save - saves BRAPH2 figure panel as b2 file
	%  load - loads a BRAPH2 figure panel from a b2 file
	%
	% PanelFig method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the figure panel
	%
	% PanelFig method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the figure panel
	%
	% PanelFig methods (inspection, Static):
	%  getClass - returns the class of the figure panel
	%  getSubclasses - returns all subclasses of PanelFig
	%  getProps - returns the property list of the figure panel
	%  getPropNumber - returns the property number of the figure panel
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
	% PanelFig methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelFig methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelFig methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelFig methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelFig; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelFig constants</a>.
	%
	%
	% See also uipanel, GUIFig, Settings.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		ST_POSITION = 20; %CET: Computational Efficiency Trick
		ST_POSITION_TAG = 'ST_POSITION';
		ST_POSITION_CATEGORY = 8;
		ST_POSITION_FORMAT = 8;
		
		H_TOOLBAR = 21; %CET: Computational Efficiency Trick
		H_TOOLBAR_TAG = 'H_TOOLBAR';
		H_TOOLBAR_CATEGORY = 7;
		H_TOOLBAR_FORMAT = 18;
		
		H_TOOLS = 22; %CET: Computational Efficiency Trick
		H_TOOLS_TAG = 'H_TOOLS';
		H_TOOLS_CATEGORY = 7;
		H_TOOLS_FORMAT = 19;
	end
	methods % constructor
		function pf = PanelFig(varargin)
			%PanelFig() creates a figure panel.
			%
			% PanelFig(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelFig(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PanelFig properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the figure panel.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the figure panel.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the figure panel.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the figure panel.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the figure panel.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the figure panel.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the figure panel.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the figure panel.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the figure panel is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel.
			%  <strong>20</strong> <strong>ST_POSITION</strong> 	ST_POSITION (figure, item) determines the panel position.
			%  <strong>21</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.
			%  <strong>22</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
			%
			% See also Category, Format.
			
			pf = pf@Panel(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the figure panel.
			%
			% BUILD = PanelFig.GETBUILD() returns the build of 'PanelFig'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PF.GETBUILD() returns the build of the figure panel PF.
			%  BUILD = Element.GETBUILD(PF) returns the build of 'PF'.
			%  BUILD = Element.GETBUILD('PanelFig') returns the build of 'PanelFig'.
			%
			% Note that the Element.GETBUILD(PF) and Element.GETBUILD('PanelFig')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pf_class = getClass()
			%GETCLASS returns the class of the figure panel.
			%
			% CLASS = PanelFig.GETCLASS() returns the class 'PanelFig'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the figure panel PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('PanelFig') returns 'PanelFig'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('PanelFig')
			%  are less computationally efficient.
			
			pf_class = 'PanelFig';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the figure panel.
			%
			% LIST = PanelFig.GETSUBCLASSES() returns all subclasses of 'PanelFig'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the figure panel PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('PanelFig') returns all subclasses of 'PanelFig'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('PanelFig')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'PanelFig'  'NNClassifierMLP_CrossValidationPF_ROC'  'NNClassifierMLP_EvaluatorPF_ROC'  'NNRegressorMLP_CrossValidationPF_Scatter'  'NNRegressorMLP_EvaluatorPF_Scatter'  'NNxMLP_FeatureImportanceBrainSurfacePF'  'NNxMLP_FeatureImportanceBrainSurfacePF_BB'  'NNxMLP_FeatureImportanceBrainSurfacePF_BS'  'NNxMLP_FeatureImportanceBrainSurfacePF_BU'  'NNxMLP_FeatureImportanceBrainSurfacePF_GB'  'NNxMLP_FeatureImportanceBrainSurfacePF_GS'  'NNxMLP_FeatureImportanceBrainSurfacePF_GU'  'NNxMLP_FeatureImportanceBrainSurfacePF_NB'  'NNxMLP_FeatureImportanceBrainSurfacePF_NS'  'NNxMLP_FeatureImportanceBrainSurfacePF_NU'  'ComparisonEnsembleBrainPF'  'ComparisonEnsembleBrainPF_BB'  'ComparisonEnsembleBrainPF_BS'  'ComparisonEnsembleBrainPF_BU'  'ComparisonEnsembleBrainPF_GB'  'ComparisonEnsembleBrainPF_GS'  'ComparisonEnsembleBrainPF_GU'  'ComparisonEnsembleBrainPF_NB'  'ComparisonEnsembleBrainPF_NS'  'ComparisonEnsembleBrainPF_NU'  'ComparisonEnsemblePF'  'ComparisonEnsemblePF_BB'  'ComparisonEnsemblePF_BS'  'ComparisonEnsemblePF_BU'  'ComparisonEnsemblePF_GB'  'ComparisonEnsemblePF_GS'  'ComparisonEnsemblePF_GU'  'ComparisonEnsemblePF_NB'  'ComparisonEnsemblePF_NS'  'ComparisonEnsemblePF_NU'  'ComparisonGroupBrainPF'  'ComparisonGroupBrainPF_BB'  'ComparisonGroupBrainPF_BS'  'ComparisonGroupBrainPF_BU'  'ComparisonGroupBrainPF_GB'  'ComparisonGroupBrainPF_GS'  'ComparisonGroupBrainPF_GU'  'ComparisonGroupBrainPF_NB'  'ComparisonGroupBrainPF_NS'  'ComparisonGroupBrainPF_NU'  'ComparisonGroupPF'  'ComparisonGroupPF_BB'  'ComparisonGroupPF_BS'  'ComparisonGroupPF_BU'  'ComparisonGroupPF_GB'  'ComparisonGroupPF_GS'  'ComparisonGroupPF_GU'  'ComparisonGroupPF_NB'  'ComparisonGroupPF_NS'  'ComparisonGroupPF_NU'  'MeasureEnsembleBrainPF'  'MeasureEnsembleBrainPF_BB'  'MeasureEnsembleBrainPF_BS'  'MeasureEnsembleBrainPF_BU'  'MeasureEnsembleBrainPF_GB'  'MeasureEnsembleBrainPF_GS'  'MeasureEnsembleBrainPF_GU'  'MeasureEnsembleBrainPF_NB'  'MeasureEnsembleBrainPF_NS'  'MeasureEnsembleBrainPF_NU'  'MeasureEnsemblePF'  'MeasureEnsemblePF_BB'  'MeasureEnsemblePF_BS'  'MeasureEnsemblePF_BU'  'MeasureEnsemblePF_GB'  'MeasureEnsemblePF_GS'  'MeasureEnsemblePF_GU'  'MeasureEnsemblePF_NB'  'MeasureEnsemblePF_NS'  'MeasureEnsemblePF_NU'  'MeasureGroupBrainPF'  'MeasureGroupBrainPF_BB'  'MeasureGroupBrainPF_BS'  'MeasureGroupBrainPF_BU'  'MeasureGroupBrainPF_GB'  'MeasureGroupBrainPF_GS'  'MeasureGroupBrainPF_GU'  'MeasureGroupBrainPF_NB'  'MeasureGroupBrainPF_NS'  'MeasureGroupBrainPF_NU'  'BrainAtlasPF'  'BrainSurfacePF'  'GraphAdjPF'  'GraphHistPF'  'MeasurePF'  'MeasurePF_BB'  'MeasurePF_BS'  'MeasurePF_BU'  'MeasurePF_GB'  'MeasurePF_GS'  'MeasurePF_GU'  'MeasurePF_NB'  'MeasurePF_NS'  'MeasurePF_NU' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of figure panel.
			%
			% PROPS = PanelFig.GETPROPS() returns the property list of figure panel
			%  as a row vector.
			%
			% PROPS = PanelFig.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the figure panel PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('PanelFig'[, CATEGORY]) returns the property list of 'PanelFig'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('PanelFig')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22];
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
					prop_list = [10 15 21 22];
				case 8 % Category.FIGURE
					prop_list = [14 20];
				case 9 % Category.GUI
					prop_list = [9 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of figure panel.
			%
			% N = PanelFig.GETPROPNUMBER() returns the property number of figure panel.
			%
			% N = PanelFig.GETPROPNUMBER(CATEGORY) returns the property number of figure panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the figure panel PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('PanelFig') returns the property number of 'PanelFig'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('PanelFig')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 22;
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
					prop_number = 4;
				case 8 % Category.FIGURE
					prop_number = 2;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in figure panel/error.
			%
			% CHECK = PanelFig.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PanelFig, PROP) checks whether PROP exists for PanelFig.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelFig:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:PanelFig:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:PanelFig:WrongInput]
			%  Element.EXISTSPROP(PanelFig, PROP) throws error if PROP does NOT exist for PanelFig.
			%   Error id: [BRAPH2:PanelFig:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('PanelFig')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 22 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelFig:' 'WrongInput'], ...
					['BRAPH2' ':PanelFig:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelFig.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in figure panel/error.
			%
			% CHECK = PanelFig.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PanelFig, TAG) checks whether TAG exists for PanelFig.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelFig:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:PanelFig:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:PanelFig:WrongInput]
			%  Element.EXISTSTAG(PanelFig, TAG) throws error if TAG does NOT exist for PanelFig.
			%   Error id: [BRAPH2:PanelFig:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('PanelFig')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelFig:' 'WrongInput'], ...
					['BRAPH2' ':PanelFig:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for PanelFig.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelFig, POINTER) returns property number of POINTER of PanelFig.
			%  PROPERTY = PF.GETPROPPROP(PanelFig, POINTER) returns property number of POINTER of PanelFig.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('PanelFig')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(PanelFig, POINTER) returns tag of POINTER of PanelFig.
			%  TAG = PF.GETPROPTAG(PanelFig, POINTER) returns tag of POINTER of PanelFig.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('PanelFig')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				panelfig_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS' };
				tag = panelfig_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelFig, POINTER) returns category of POINTER of PanelFig.
			%  CATEGORY = PF.GETPROPCATEGORY(PanelFig, POINTER) returns category of POINTER of PanelFig.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('PanelFig')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelFig.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelfig_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  8  7  7 };
			prop_category = panelfig_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(PanelFig, POINTER) returns format of POINTER of PanelFig.
			%  FORMAT = PF.GETPROPFORMAT(PanelFig, POINTER) returns format of POINTER of PanelFig.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('PanelFig')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelFig.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelfig_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  8  18  19 };
			prop_format = panelfig_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelFig, POINTER) returns description of POINTER of PanelFig.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(PanelFig, POINTER) returns description of POINTER of PanelFig.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('PanelFig')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelFig.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelfig_description_list = { 'ELCLASS (constant, string) is the class of the figure panel.'  'NAME (constant, string) is the name of the figure panel.'  'DESCRIPTION (constant, string) is the description of the figure panel.'  'TEMPLATE (parameter, item) is the template of the figure panel.'  'ID (data, string) is a few-letter code for the figure panel.'  'LABEL (metadata, string) is an extended label of the figure panel.'  'NOTES (metadata, string) are some specific notes about the figure panel.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the figure panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel.'  'HIDE (query, logical) hides the figure containing the panel.'  'DELETE (query, logical) resets the handles when the figure panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel.'  'ST_POSITION (figure, item) determines the panel position.'  'H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.'  'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.' };
			prop_description = panelfig_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelFig, POINTER) returns settings of POINTER of PanelFig.
			%  SETTINGS = PF.GETPROPSETTINGS(PanelFig, POINTER) returns settings of POINTER of PanelFig.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('PanelFig')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelFig.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 20 % PanelFig.ST_POSITION
					prop_settings = 'SettingsPosition';
				case 21 % PanelFig.H_TOOLBAR
					prop_settings = Format.getFormatSettings(18);
				case 22 % PanelFig.H_TOOLS
					prop_settings = Format.getFormatSettings(19);
				case 4 % PanelFig.TEMPLATE
					prop_settings = 'PanelFig';
				otherwise
					prop_settings = getPropSettings@Panel(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelFig.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelFig.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelFig, POINTER) returns the default value of POINTER of PanelFig.
			%  DEFAULT = PF.GETPROPDEFAULT(PanelFig, POINTER) returns the default value of POINTER of PanelFig.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('PanelFig')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelFig.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 20 % PanelFig.ST_POSITION
					prop_default = Format.getFormatDefault(8, PanelFig.getPropSettings(prop));
				case 21 % PanelFig.H_TOOLBAR
					prop_default = Format.getFormatDefault(18, PanelFig.getPropSettings(prop));
				case 22 % PanelFig.H_TOOLS
					prop_default = Format.getFormatDefault(19, PanelFig.getPropSettings(prop));
				case 1 % PanelFig.ELCLASS
					prop_default = 'PanelFig';
				case 2 % PanelFig.NAME
					prop_default = 'Figure Panel';
				case 3 % PanelFig.DESCRIPTION
					prop_default = 'A Figure Panel (PanelFig) plots a figure.';
				case 4 % PanelFig.TEMPLATE
					prop_default = Format.getFormatDefault(8, PanelFig.getPropSettings(prop));
				case 5 % PanelFig.ID
					prop_default = 'PanelFig ID';
				case 6 % PanelFig.LABEL
					prop_default = 'PanelFig label';
				case 7 % PanelFig.NOTES
					prop_default = 'PanelFig notes';
				case 14 % PanelFig.BKGCOLOR
					prop_default = [1 1 1];
				otherwise
					prop_default = getPropDefault@Panel(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelFig.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelFig.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelFig, POINTER) returns the conditioned default value of POINTER of PanelFig.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(PanelFig, POINTER) returns the conditioned default value of POINTER of PanelFig.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('PanelFig')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelFig.getPropProp(pointer);
			
			prop_default = PanelFig.conditioning(prop, PanelFig.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelFig, PROP, VALUE) checks VALUE format for PROP of PanelFig.
			%  CHECK = PF.CHECKPROP(PanelFig, PROP, VALUE) checks VALUE format for PROP of PanelFig.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:PanelFig:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: BRAPH2:PanelFig:WrongInput
			%  Element.CHECKPROP(PanelFig, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelFig.
			%   Error id: BRAPH2:PanelFig:WrongInput
			%  PF.CHECKPROP(PanelFig, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelFig.
			%   Error id: BRAPH2:PanelFig:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('PanelFig')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelFig.getPropProp(pointer);
			
			switch prop
				case 20 % PanelFig.ST_POSITION
					check = Format.checkFormat(8, value, PanelFig.getPropSettings(prop));
				case 21 % PanelFig.H_TOOLBAR
					check = Format.checkFormat(18, value, PanelFig.getPropSettings(prop));
				case 22 % PanelFig.H_TOOLS
					check = Format.checkFormat(19, value, PanelFig.getPropSettings(prop));
				case 4 % PanelFig.TEMPLATE
					check = Format.checkFormat(8, value, PanelFig.getPropSettings(prop));
				otherwise
					if prop <= 19
						check = checkProp@Panel(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelFig:' 'WrongInput'], ...
					['BRAPH2' ':PanelFig:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelFig.getPropTag(prop) ' (' PanelFig.getFormatTag(PanelFig.getPropFormat(prop)) ').'] ...
					)
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
				case 21 % PanelFig.H_TOOLBAR
					value = findobj(ancestor(pf.memorize('PARENT').memorize('H'), 'Figure'), 'Tag', 'TOOLBAR');
					
				case 22 % PanelFig.H_TOOLS
					value = {};
					
				case 11 % PanelFig.DRAW
					if check_graphics(pf.memorize('H'), 'uipanel') % H = p for panel
					    
					    pf.memorize('ST_POSITION').set('PANEL', pf, 'PROP', pf.H).get('SETUP')
					    
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pf)], ...
					        ['BRAPH2' ':' class(pf) '\n' ...
					        'The call pf.get(''DRAW'') did not work.\n' ...
					        'This shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 18 % PanelFig.DELETE
					value = calculateValue@Panel(pf, 18, varargin{:}); % also warning
					if value
					    pf.set('H_TOOLBAR', Element.getNoValue())
					    pf.set('H_TOOLS', Element.getNoValue())
					end
					
				otherwise
					if prop <= 19
						value = calculateValue@Panel(pf, prop, varargin{:});
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
				case 20 % PanelFig.ST_POSITION
					pr = SettingsPositionPP('EL', pf, 'PROP', 20, varargin{:});
					
				otherwise
					pr = getPanelProp@Panel(pf, prop, varargin{:});
					
			end
		end
	end
end
