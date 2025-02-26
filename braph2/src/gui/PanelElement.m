classdef PanelElement < Panel
	%PanelElement plots the panel of an element.
	% It is a subclass of <a href="matlab:help Panel">Panel</a>.
	%
	% An Element Panel (PanelElement) plots all properties of an element in a panel, 
	%  which contains a series of stacked property panels,
	%  one for each property of the element EL being plotted.
	% 
	% CONSTRUCTOR - To construct a PanelElement use, e.g.:
	% 
	%     pe = PanelElement('<strong>PARENT</strong>', <parent element>, '<strong>EL</strong>', <element>)
	%   
	%  where the <parent element> can be a GUI or a Panel, 
	%   but most often a GUIElement.
	%   
	% DRAW - To draw the panel, call:
	% 
	%     pe.get('<strong>DRAW</strong>'[, 'Name', <value>, ...])
	%     p = pe.get('<strong>H</strong>'); % p is the handle of the generated panel
	%  
	%  The query pn.get('<strong>DRAWN</strong>') returns whether the Panel has 
	%   been drawn and therefore can be shown.
	%   
	% CALLBACKS - These are the public callback (to be further implemented by the derived panels):
	% 
	%     pe.get('<strong>SHOW</strong>') - shows the figure containing the panel.
	%     pe.get('<strong>HIDE</strong>') - hides the figure containing the panel.
	%     pe.get('<strong>DELETE</strong>') - resets the handles when the panel is deleted.
	%     pe.get('<strong>CLOSE</strong>') - closes the figure containing the panel.
	%     pe.get('<strong>RESIZEX</strong>') - resizes the x-extension of the element panel and its prop panels.
	%     pe.get('<strong>RESIZEY</strong>') - resizes the y-extension of the element panel and its prop panels.
	%
	% The list of PanelElement properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the element panel.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the element panel.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the element panel.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the element panel.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the element panel.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the element panel.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the element panel.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the element panel.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the grid layout handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) brings to the front the figures dependent on the element panel.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figures dependent on the element panel.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the element panel is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figures dependent on the element panel.
	%  <strong>20</strong> <strong>EL</strong> 	EL (data, item) is the element to be plotted.
	%  <strong>21</strong> <strong>PR_ORDER</strong> 	PR_ORDER (gui, rvector) is the order of the property plots.
	%  <strong>22</strong> <strong>PR_TITLE</strong> 	PR_TITLE (gui, stringlist) is the list of property plot titles.
	%  <strong>23</strong> <strong>PR_VISIBLE</strong> 	PR_VISIBLE (gui, rvector) is the list of visible property plots.
	%  <strong>24</strong> <strong>PR_DICT</strong> 	PR_DICT (result, idict) is a dictionary of the property plots.
	%  <strong>25</strong> <strong>MIN_WIDTH</strong> 	MIN_WIDTH (gui, size) is the minimal panel width in pixels.
	%  <strong>26</strong> <strong>RESIZEX</strong> 	RESIZEX (query, logical) resizes the x-extension of the element panel and its prop panels.
	%  <strong>27</strong> <strong>RESIZEY</strong> 	RESIZEY (query, logical) resizes the y-extension of the element panel and its prop panels.
	%  <strong>28</strong> <strong>LISTENER_PPHEIGHT</strong> 	LISTENER_PPHEIGHT (evanescent, handlelist) contains the listeners to the PropSet events.
	%
	% PanelElement methods (constructor):
	%  PanelElement - constructor
	%
	% PanelElement methods:
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
	% PanelElement methods (display):
	%  tostring - string with information about the element panel
	%  disp - displays information about the element panel
	%  tree - displays the tree of the element panel
	%
	% PanelElement methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two element panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the element panel
	%
	% PanelElement methods (save/load, Static):
	%  save - saves BRAPH2 element panel as b2 file
	%  load - loads a BRAPH2 element panel from a b2 file
	%
	% PanelElement method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the element panel
	%
	% PanelElement method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the element panel
	%
	% PanelElement methods (inspection, Static):
	%  getClass - returns the class of the element panel
	%  getSubclasses - returns all subclasses of PanelElement
	%  getProps - returns the property list of the element panel
	%  getPropNumber - returns the property number of the element panel
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
	% PanelElement methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelElement methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelElement methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelElement methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelElement; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelElement constants</a>.
	%
	%
	% See also uigridlayout, GUI, GUIElement, PanelProp.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		EL = 20; %CET: Computational Efficiency Trick
		EL_TAG = 'EL';
		EL_CATEGORY = 4;
		EL_FORMAT = 8;
		
		PR_ORDER = 21; %CET: Computational Efficiency Trick
		PR_ORDER_TAG = 'PR_ORDER';
		PR_ORDER_CATEGORY = 9;
		PR_ORDER_FORMAT = 12;
		
		PR_TITLE = 22; %CET: Computational Efficiency Trick
		PR_TITLE_TAG = 'PR_TITLE';
		PR_TITLE_CATEGORY = 9;
		PR_TITLE_FORMAT = 3;
		
		PR_VISIBLE = 23; %CET: Computational Efficiency Trick
		PR_VISIBLE_TAG = 'PR_VISIBLE';
		PR_VISIBLE_CATEGORY = 9;
		PR_VISIBLE_FORMAT = 12;
		
		PR_DICT = 24; %CET: Computational Efficiency Trick
		PR_DICT_TAG = 'PR_DICT';
		PR_DICT_CATEGORY = 5;
		PR_DICT_FORMAT = 10;
		
		MIN_WIDTH = 25; %CET: Computational Efficiency Trick
		MIN_WIDTH_TAG = 'MIN_WIDTH';
		MIN_WIDTH_CATEGORY = 9;
		MIN_WIDTH_FORMAT = 22;
		
		RESIZEX = 26; %CET: Computational Efficiency Trick
		RESIZEX_TAG = 'RESIZEX';
		RESIZEX_CATEGORY = 6;
		RESIZEX_FORMAT = 4;
		
		RESIZEY = 27; %CET: Computational Efficiency Trick
		RESIZEY_TAG = 'RESIZEY';
		RESIZEY_CATEGORY = 6;
		RESIZEY_FORMAT = 4;
		
		LISTENER_PPHEIGHT = 28; %CET: Computational Efficiency Trick
		LISTENER_PPHEIGHT_TAG = 'LISTENER_PPHEIGHT';
		LISTENER_PPHEIGHT_CATEGORY = 7;
		LISTENER_PPHEIGHT_FORMAT = 19;
	end
	methods % constructor
		function pe = PanelElement(varargin)
			%PanelElement() creates a element panel.
			%
			% PanelElement(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelElement(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PanelElement properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the element panel.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the element panel.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the element panel.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the element panel.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the element panel.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the element panel.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the element panel.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the element panel.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the grid layout handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) brings to the front the figures dependent on the element panel.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figures dependent on the element panel.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the element panel is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figures dependent on the element panel.
			%  <strong>20</strong> <strong>EL</strong> 	EL (data, item) is the element to be plotted.
			%  <strong>21</strong> <strong>PR_ORDER</strong> 	PR_ORDER (gui, rvector) is the order of the property plots.
			%  <strong>22</strong> <strong>PR_TITLE</strong> 	PR_TITLE (gui, stringlist) is the list of property plot titles.
			%  <strong>23</strong> <strong>PR_VISIBLE</strong> 	PR_VISIBLE (gui, rvector) is the list of visible property plots.
			%  <strong>24</strong> <strong>PR_DICT</strong> 	PR_DICT (result, idict) is a dictionary of the property plots.
			%  <strong>25</strong> <strong>MIN_WIDTH</strong> 	MIN_WIDTH (gui, size) is the minimal panel width in pixels.
			%  <strong>26</strong> <strong>RESIZEX</strong> 	RESIZEX (query, logical) resizes the x-extension of the element panel and its prop panels.
			%  <strong>27</strong> <strong>RESIZEY</strong> 	RESIZEY (query, logical) resizes the y-extension of the element panel and its prop panels.
			%  <strong>28</strong> <strong>LISTENER_PPHEIGHT</strong> 	LISTENER_PPHEIGHT (evanescent, handlelist) contains the listeners to the PropSet events.
			%
			% See also Category, Format.
			
			pe = pe@Panel(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the element panel.
			%
			% BUILD = PanelElement.GETBUILD() returns the build of 'PanelElement'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PE.GETBUILD() returns the build of the element panel PE.
			%  BUILD = Element.GETBUILD(PE) returns the build of 'PE'.
			%  BUILD = Element.GETBUILD('PanelElement') returns the build of 'PanelElement'.
			%
			% Note that the Element.GETBUILD(PE) and Element.GETBUILD('PanelElement')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pe_class = getClass()
			%GETCLASS returns the class of the element panel.
			%
			% CLASS = PanelElement.GETCLASS() returns the class 'PanelElement'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PE.GETCLASS() returns the class of the element panel PE.
			%  CLASS = Element.GETCLASS(PE) returns the class of 'PE'.
			%  CLASS = Element.GETCLASS('PanelElement') returns 'PanelElement'.
			%
			% Note that the Element.GETCLASS(PE) and Element.GETCLASS('PanelElement')
			%  are less computationally efficient.
			
			pe_class = 'PanelElement';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the element panel.
			%
			% LIST = PanelElement.GETSUBCLASSES() returns all subclasses of 'PanelElement'.
			%
			% Alternative forms to call this method are:
			%  LIST = PE.GETSUBCLASSES() returns all subclasses of the element panel PE.
			%  LIST = Element.GETSUBCLASSES(PE) returns all subclasses of 'PE'.
			%  LIST = Element.GETSUBCLASSES('PanelElement') returns all subclasses of 'PanelElement'.
			%
			% Note that the Element.GETSUBCLASSES(PE) and Element.GETSUBCLASSES('PanelElement')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'PanelElement' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of element panel.
			%
			% PROPS = PanelElement.GETPROPS() returns the property list of element panel
			%  as a row vector.
			%
			% PROPS = PanelElement.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PE.GETPROPS([CATEGORY]) returns the property list of the element panel PE.
			%  PROPS = Element.GETPROPS(PE[, CATEGORY]) returns the property list of 'PE'.
			%  PROPS = Element.GETPROPS('PanelElement'[, CATEGORY]) returns the property list of 'PanelElement'.
			%
			% Note that the Element.GETPROPS(PE) and Element.GETPROPS('PanelElement')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28];
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
					prop_list = [5 20];
				case 5 % Category.RESULT
					prop_list = 24;
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 26 27];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 28];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 21 22 23 25];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of element panel.
			%
			% N = PanelElement.GETPROPNUMBER() returns the property number of element panel.
			%
			% N = PanelElement.GETPROPNUMBER(CATEGORY) returns the property number of element panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PE.GETPROPNUMBER([CATEGORY]) returns the property number of the element panel PE.
			%  N = Element.GETPROPNUMBER(PE) returns the property number of 'PE'.
			%  N = Element.GETPROPNUMBER('PanelElement') returns the property number of 'PanelElement'.
			%
			% Note that the Element.GETPROPNUMBER(PE) and Element.GETPROPNUMBER('PanelElement')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 28;
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
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 9;
				case 7 % Category.EVANESCENT
					prop_number = 3;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 6;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in element panel/error.
			%
			% CHECK = PanelElement.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PE.EXISTSPROP(PROP) checks whether PROP exists for PE.
			%  CHECK = Element.EXISTSPROP(PE, PROP) checks whether PROP exists for PE.
			%  CHECK = Element.EXISTSPROP(PanelElement, PROP) checks whether PROP exists for PanelElement.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelElement:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PE.EXISTSPROP(PROP) throws error if PROP does NOT exist for PE.
			%   Error id: [BRAPH2:PanelElement:WrongInput]
			%  Element.EXISTSPROP(PE, PROP) throws error if PROP does NOT exist for PE.
			%   Error id: [BRAPH2:PanelElement:WrongInput]
			%  Element.EXISTSPROP(PanelElement, PROP) throws error if PROP does NOT exist for PanelElement.
			%   Error id: [BRAPH2:PanelElement:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PE) and Element.EXISTSPROP('PanelElement')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 28 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelElement:' 'WrongInput'], ...
					['BRAPH2' ':PanelElement:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelElement.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in element panel/error.
			%
			% CHECK = PanelElement.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PE.EXISTSTAG(TAG) checks whether TAG exists for PE.
			%  CHECK = Element.EXISTSTAG(PE, TAG) checks whether TAG exists for PE.
			%  CHECK = Element.EXISTSTAG(PanelElement, TAG) checks whether TAG exists for PanelElement.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelElement:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PE.EXISTSTAG(TAG) throws error if TAG does NOT exist for PE.
			%   Error id: [BRAPH2:PanelElement:WrongInput]
			%  Element.EXISTSTAG(PE, TAG) throws error if TAG does NOT exist for PE.
			%   Error id: [BRAPH2:PanelElement:WrongInput]
			%  Element.EXISTSTAG(PanelElement, TAG) throws error if TAG does NOT exist for PanelElement.
			%   Error id: [BRAPH2:PanelElement:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PE) and Element.EXISTSTAG('PanelElement')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'EL'  'PR_ORDER'  'PR_TITLE'  'PR_VISIBLE'  'PR_DICT'  'MIN_WIDTH'  'RESIZEX'  'RESIZEY'  'LISTENER_PPHEIGHT' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelElement:' 'WrongInput'], ...
					['BRAPH2' ':PanelElement:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for PanelElement.'] ...
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
			%  PROPERTY = PE.GETPROPPROP(POINTER) returns property number of POINTER of PE.
			%  PROPERTY = Element.GETPROPPROP(PanelElement, POINTER) returns property number of POINTER of PanelElement.
			%  PROPERTY = PE.GETPROPPROP(PanelElement, POINTER) returns property number of POINTER of PanelElement.
			%
			% Note that the Element.GETPROPPROP(PE) and Element.GETPROPPROP('PanelElement')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'EL'  'PR_ORDER'  'PR_TITLE'  'PR_VISIBLE'  'PR_DICT'  'MIN_WIDTH'  'RESIZEX'  'RESIZEY'  'LISTENER_PPHEIGHT' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = PE.GETPROPTAG(POINTER) returns tag of POINTER of PE.
			%  TAG = Element.GETPROPTAG(PanelElement, POINTER) returns tag of POINTER of PanelElement.
			%  TAG = PE.GETPROPTAG(PanelElement, POINTER) returns tag of POINTER of PanelElement.
			%
			% Note that the Element.GETPROPTAG(PE) and Element.GETPROPTAG('PanelElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				panelelement_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'EL'  'PR_ORDER'  'PR_TITLE'  'PR_VISIBLE'  'PR_DICT'  'MIN_WIDTH'  'RESIZEX'  'RESIZEY'  'LISTENER_PPHEIGHT' };
				tag = panelelement_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = PE.GETPROPCATEGORY(POINTER) returns category of POINTER of PE.
			%  CATEGORY = Element.GETPROPCATEGORY(PanelElement, POINTER) returns category of POINTER of PanelElement.
			%  CATEGORY = PE.GETPROPCATEGORY(PanelElement, POINTER) returns category of POINTER of PanelElement.
			%
			% Note that the Element.GETPROPCATEGORY(PE) and Element.GETPROPCATEGORY('PanelElement')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelElement.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelelement_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  4  9  9  9  5  9  6  6  7 };
			prop_category = panelelement_category_list{prop};
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
			%  FORMAT = PE.GETPROPFORMAT(POINTER) returns format of POINTER of PE.
			%  FORMAT = Element.GETPROPFORMAT(PanelElement, POINTER) returns format of POINTER of PanelElement.
			%  FORMAT = PE.GETPROPFORMAT(PanelElement, POINTER) returns format of POINTER of PanelElement.
			%
			% Note that the Element.GETPROPFORMAT(PE) and Element.GETPROPFORMAT('PanelElement')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelElement.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelelement_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  8  12  3  12  10  22  4  4  19 };
			prop_format = panelelement_format_list{prop};
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
			%  DESCRIPTION = PE.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PE.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelElement, POINTER) returns description of POINTER of PanelElement.
			%  DESCRIPTION = PE.GETPROPDESCRIPTION(PanelElement, POINTER) returns description of POINTER of PanelElement.
			%
			% Note that the Element.GETPROPDESCRIPTION(PE) and Element.GETPROPDESCRIPTION('PanelElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelElement.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelelement_description_list = { 'ELCLASS (constant, string) is the class of the element panel.'  'NAME (constant, string) is the name of the element panel.'  'DESCRIPTION (constant, string) is the description of the element panel.'  'TEMPLATE (parameter, item) is the template of the element panel.'  'ID (data, string) is a few-letter code for the element panel.'  'LABEL (metadata, string) is an extended label of the element panel.'  'NOTES (metadata, string) are some specific notes about the element panel.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the element panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the grid layout handle.'  'SHOW (query, logical) brings to the front the figures dependent on the element panel.'  'HIDE (query, logical) hides the figures dependent on the element panel.'  'DELETE (query, logical) resets the handles when the element panel is deleted.'  'CLOSE (query, logical) closes the figures dependent on the element panel.'  'EL (data, item) is the element to be plotted.'  'PR_ORDER (gui, rvector) is the order of the property plots.'  'PR_TITLE (gui, stringlist) is the list of property plot titles.'  'PR_VISIBLE (gui, rvector) is the list of visible property plots.'  'PR_DICT (result, idict) is a dictionary of the property plots.'  'MIN_WIDTH (gui, size) is the minimal panel width in pixels.'  'RESIZEX (query, logical) resizes the x-extension of the element panel and its prop panels.'  'RESIZEY (query, logical) resizes the y-extension of the element panel and its prop panels.'  'LISTENER_PPHEIGHT (evanescent, handlelist) contains the listeners to the PropSet events.' };
			prop_description = panelelement_description_list{prop};
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
			%  SETTINGS = PE.GETPROPSETTINGS(POINTER) returns settings of POINTER of PE.
			%  SETTINGS = Element.GETPROPSETTINGS(PanelElement, POINTER) returns settings of POINTER of PanelElement.
			%  SETTINGS = PE.GETPROPSETTINGS(PanelElement, POINTER) returns settings of POINTER of PanelElement.
			%
			% Note that the Element.GETPROPSETTINGS(PE) and Element.GETPROPSETTINGS('PanelElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelElement.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 20 % PanelElement.EL
					prop_settings = Format.getFormatSettings(8);
				case 21 % PanelElement.PR_ORDER
					prop_settings = Format.getFormatSettings(12);
				case 22 % PanelElement.PR_TITLE
					prop_settings = Format.getFormatSettings(3);
				case 23 % PanelElement.PR_VISIBLE
					prop_settings = Format.getFormatSettings(12);
				case 24 % PanelElement.PR_DICT
					prop_settings = 'PanelProp';
				case 25 % PanelElement.MIN_WIDTH
					prop_settings = Format.getFormatSettings(22);
				case 26 % PanelElement.RESIZEX
					prop_settings = Format.getFormatSettings(4);
				case 27 % PanelElement.RESIZEY
					prop_settings = Format.getFormatSettings(4);
				case 28 % PanelElement.LISTENER_PPHEIGHT
					prop_settings = Format.getFormatSettings(19);
				case 4 % PanelElement.TEMPLATE
					prop_settings = 'PanelElement';
				otherwise
					prop_settings = getPropSettings@Panel(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelElement.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelElement.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PE.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelElement, POINTER) returns the default value of POINTER of PanelElement.
			%  DEFAULT = PE.GETPROPDEFAULT(PanelElement, POINTER) returns the default value of POINTER of PanelElement.
			%
			% Note that the Element.GETPROPDEFAULT(PE) and Element.GETPROPDEFAULT('PanelElement')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelElement.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 20 % PanelElement.EL
					prop_default = Format.getFormatDefault(8, PanelElement.getPropSettings(prop));
				case 21 % PanelElement.PR_ORDER
					prop_default = Format.getFormatDefault(12, PanelElement.getPropSettings(prop));
				case 22 % PanelElement.PR_TITLE
					prop_default = Format.getFormatDefault(3, PanelElement.getPropSettings(prop));
				case 23 % PanelElement.PR_VISIBLE
					prop_default = Format.getFormatDefault(12, PanelElement.getPropSettings(prop));
				case 24 % PanelElement.PR_DICT
					prop_default = Format.getFormatDefault(10, PanelElement.getPropSettings(prop));
				case 25 % PanelElement.MIN_WIDTH
					prop_default = 300;
				case 26 % PanelElement.RESIZEX
					prop_default = Format.getFormatDefault(4, PanelElement.getPropSettings(prop));
				case 27 % PanelElement.RESIZEY
					prop_default = Format.getFormatDefault(4, PanelElement.getPropSettings(prop));
				case 28 % PanelElement.LISTENER_PPHEIGHT
					prop_default = Format.getFormatDefault(19, PanelElement.getPropSettings(prop));
				case 1 % PanelElement.ELCLASS
					prop_default = 'PanelElement';
				case 2 % PanelElement.NAME
					prop_default = 'Element Panel';
				case 3 % PanelElement.DESCRIPTION
					prop_default = 'An Element Panel (PanelElement) plots all properties of an element in a panel, which contains a series of stacked property panels, one for each property of the element being plotted.';
				case 4 % PanelElement.TEMPLATE
					prop_default = Format.getFormatDefault(8, PanelElement.getPropSettings(prop));
				case 5 % PanelElement.ID
					prop_default = 'PanelElement ID';
				case 6 % PanelElement.LABEL
					prop_default = 'PanelElement label';
				case 7 % PanelElement.NOTES
					prop_default = 'PanelElement notes';
				case 13 % PanelElement.PARENT
					prop_default = GUI();
				otherwise
					prop_default = getPropDefault@Panel(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelElement.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelElement.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelElement, POINTER) returns the conditioned default value of POINTER of PanelElement.
			%  DEFAULT = PE.GETPROPDEFAULTCONDITIONED(PanelElement, POINTER) returns the conditioned default value of POINTER of PanelElement.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PE) and Element.GETPROPDEFAULTCONDITIONED('PanelElement')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelElement.getPropProp(pointer);
			
			prop_default = PanelElement.conditioning(prop, PanelElement.getPropDefault(prop));
		end
	end
	methods (Access=protected) % preset
		function value = preset(pe, prop, value)
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
				case 21 % PanelElement.PR_ORDER
					if isempty(value) && ~isa(pe.getr('EL'), 'NoValue')
					    [value, ~, ~] = load_layout(pe.get('EL'));
					end
					
				case 22 % PanelElement.PR_TITLE
					if isempty(value) && ~isa(pe.getr('EL'), 'NoValue')
					    [~, value, ~] = load_layout(pe.get('EL'));
					end
					
				case 23 % PanelElement.PR_VISIBLE
					if isempty(value) && ~isa(pe.getr('EL'), 'NoValue')
					    [~, ~, value] = load_layout(pe.get('EL'));
					end
					
				otherwise
					if prop <= 19
						value = preset@Panel(pe, prop, value);
					end
			end
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PE.
			%  CHECK = Element.CHECKPROP(PanelElement, PROP, VALUE) checks VALUE format for PROP of PanelElement.
			%  CHECK = PE.CHECKPROP(PanelElement, PROP, VALUE) checks VALUE format for PROP of PanelElement.
			% 
			% PE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:PanelElement:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PE.
			%   Error id: BRAPH2:PanelElement:WrongInput
			%  Element.CHECKPROP(PanelElement, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelElement.
			%   Error id: BRAPH2:PanelElement:WrongInput
			%  PE.CHECKPROP(PanelElement, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelElement.
			%   Error id: BRAPH2:PanelElement:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PE) and Element.CHECKPROP('PanelElement')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelElement.getPropProp(pointer);
			
			switch prop
				case 20 % PanelElement.EL
					check = Format.checkFormat(8, value, PanelElement.getPropSettings(prop));
				case 21 % PanelElement.PR_ORDER
					check = Format.checkFormat(12, value, PanelElement.getPropSettings(prop));
				case 22 % PanelElement.PR_TITLE
					check = Format.checkFormat(3, value, PanelElement.getPropSettings(prop));
				case 23 % PanelElement.PR_VISIBLE
					check = Format.checkFormat(12, value, PanelElement.getPropSettings(prop));
				case 24 % PanelElement.PR_DICT
					check = Format.checkFormat(10, value, PanelElement.getPropSettings(prop));
				case 25 % PanelElement.MIN_WIDTH
					check = Format.checkFormat(22, value, PanelElement.getPropSettings(prop));
				case 26 % PanelElement.RESIZEX
					check = Format.checkFormat(4, value, PanelElement.getPropSettings(prop));
				case 27 % PanelElement.RESIZEY
					check = Format.checkFormat(4, value, PanelElement.getPropSettings(prop));
				case 28 % PanelElement.LISTENER_PPHEIGHT
					check = Format.checkFormat(19, value, PanelElement.getPropSettings(prop));
				case 4 % PanelElement.TEMPLATE
					check = Format.checkFormat(8, value, PanelElement.getPropSettings(prop));
				case 13 % PanelElement.PARENT
					check = Format.checkFormat(8, value, PanelElement.getPropSettings(prop));
					if check
						check = isa(value, 'GUI') || isa(value, 'Panel');
					end
				otherwise
					if prop <= 19
						check = checkProp@Panel(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelElement:' 'WrongInput'], ...
					['BRAPH2' ':PanelElement:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelElement.getPropTag(prop) ' (' PanelElement.getFormatTag(PanelElement.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pe, prop)
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
				case 20 % PanelElement.EL
					pe.lock('EL', 'Iterative', false)
					
					[order, title, visible] = load_layout(pe.get('EL'));
					pe.set( ...
					    'PR_ORDER', order, ...
					    'PR_TITLE', title, ...
					    'PR_VISIBLE', visible ...
					    )
					
				case 13 % PanelElement.PARENT
					if check_graphics(pe.getr('H'), 'uigridlayout') % H = gl for grid layout
					    set(pe.get('H'), 'Parent', pe.get('PARENT').get('H')) % H = f for GUI and H = p for Panel
					end
					
				otherwise
					if prop <= 19
						postset@Panel(pe, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pe, prop, varargin)
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
				case 24 % PanelElement.PR_DICT
					rng_settings_ = rng(); rng(pe.getPropSeed(24), 'twister')
					
					el = pe.get('EL');
					
					wb = pe.memorize('H_WAITBAR');
					
					order = pe.get('PR_ORDER');
					title = pe.get('PR_TITLE');
					visible = pe.get('PR_VISIBLE');
					
					pr_list = cell(1, sum(visible)); % sum(visible) = sum of visible prop
					for prop = 1:1:el.getPropNumber()
					    
					    braph2waitbar(wb, .5 * (prop - 1) / el.getPropNumber(), ['Analyzing prop ' int2str(prop) ' of ' int2str(el.getPropNumber())])
					
					    if visible(prop)
					        pr = el.getPanelProp(prop);
					        
					        if isa(pr.getr('PARENT'), 'NoValue')
					            pr.set('PARENT', pe)
					        end
					        
					        if strcmp(pr.get('TITLE'), pr.get('ID'))
					            pr.set('TITLE', title{prop})
					        end
					        
					        if isa(pr.getr('WAITBAR'), 'NoValue')
					            pr.set('WAITBAR', pe.getCallback(9))
					        end
					        
					        pr_list{order(prop)} = pr;
					    end
					end
					
					value = IndexedDictionary( ...
					    'ID', el.get('TOSTRING'), ...
					    'IT_CLASS', 'PanelProp', ...
					    'IT_LIST', pr_list ...
					    );
					
					rng(rng_settings_)
					
				case 26 % PanelElement.RESIZEX
					if pe.get('DRAWN')
					    pr_dict = pe.get('PR_DICT');
					    
					    column_width = max(pe.get('MIN_WIDTH'), w(pe.get('PARENT').get('H'), 'pixels') - 20);
					    set(pe.get('H'), 'ColumnWidth', {column_width})
					
					    for pri = 1:1:pr_dict.get('LENGTH')
					        pr_dict.get('IT', pri).get('REDRAW', 'Width', column_width)
					    end
					   
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pe)], ...
					        ['BRAPH2' ':' class(pe) '\n' ...
					        'The call pe.get(''RESIZEX'') has NOT been executed.\n' ...
					        'First, the panel ' pe.get('ID') ' should be drawn calling pe.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 27 % PanelElement.RESIZEY
					if pe.get('DRAWN')
					    set(pe.get('H'), 'RowHeight', cellfun(@(pr) {pr.get('HEIGHT')}, pe.get('PR_DICT').get('IT_LIST')))
					
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pe)], ...
					        ['BRAPH2' ':' class(pe) '\n' ...
					        'The call pe.get(''RESIZEY'') has NOT been executed.\n' ...
					        'First, the panel ' pe.get('ID') ' should be drawn calling pe.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 28 % PanelElement.LISTENER_PPHEIGHT
					value = cellfun(@(pr) listener(pr, 'PropSet', @cb_listener_ppheight), pe.get('PR_DICT').get('IT_LIST'), 'UniformOutput', false);
					
				case 15 % PanelElement.H
					gl = uigridlayout([pe.memorize('PR_DICT').get('LENGTH') 1], ... % set grid layout
					    'Parent', pe.memorize('PARENT').memorize('H'), ... % H = f for GUI and H = p for Panel
					    'Tag', 'H', ...
					    'UserData', pe, ... % handle to retrieve the panel
					    'Scrollable', 'on', ...
					    'RowSpacing', 5, ...
					    'Padding', [5 18 15 5], ...    
					    'BackgroundColor', pe.get('BKGCOLOR'), ...
					    'DeleteFcn', {@cb_get, 'DELETE'} ...
					    );
					value = gl;
					
				case 10 % PanelElement.H_WAITBAR
					if pe.get('WAITBAR')
					    value = braph2waitbar(pe.get('WAITBAR'), 0, 'Drawing the element panel ...'); % wb
					else
					    value = gobjects(1);
					end
					
				case 11 % PanelElement.DRAW
					if check_graphics(pe.memorize('H'), 'uigridlayout') % H = gl for grid layout
					    gl = pe.get('H');
					    
					    if ~isempty(varargin)
					        set(g, varargin{:})
					    end
					
						wb = pe.memorize('H_WAITBAR');
					    
					    pr_dict = pe.memorize('PR_DICT');
					    
					    for pri = 1:1:pr_dict.get('LENGTH')
					        braph2waitbar(wb, .5 + .5 * (pri - 1) / pr_dict.get('LENGTH'), ['Drawing prop panel ' int2str(pri) ' of ' int2str(pr_dict.get('LENGTH'))])
					        
					        pr = pr_dict.get('IT', pri);
					        pr.get('DRAW')
					    end
					    
					    pe.memorize('LISTENER_PPHEIGHT')
					    
					    braph2waitbar(wb, 'close')
					    pe.set('H_WAITBAR', Element.getNoValue())
					    
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pe)], ...
					        ['BRAPH2' ':' class(pe) '\n' ...
					        'The call pe.get(''DRAW'') did not work.\n' ...
					        'This shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 12 % PanelElement.DRAWN
					value = check_graphics(pe.getr('H'), 'uigridlayout'); % H = gl for grid layout
					
				case 16 % PanelElement.SHOW
					if pe.get('DRAWN')
					    
					    pr_dict = pe.get('PR_DICT');
					    for pri = 1:1:pr_dict.get('LENGTH')
					        pr = pr_dict.get('IT', pri);
					        pr.get('SHOW', 'ShowParentFigure', false)
					    end
					
					    calculateValue@Panel(pe, 16, varargin{:});
					    
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pe)], ...
					        ['BRAPH2' ':' class(pe) '\n' ...
					        'The call pe.get(''SHOW'') has NOT been executed.\n' ...
					        'First, the panel ' pe.get('ID') ' should be drawn calling pe.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 17 % PanelElement.HIDE
					if pe.get('DRAWN')
					    
					    pr_dict = pe.get('PR_DICT');
					    for pri = 1:1:pr_dict.get('LENGTH')
					        pr = pr_dict.get('IT', pri);
					        pr.get('HIDE', 'HideParentFigure', false)
					    end
					
					    calculateValue@Panel(pe, 17, varargin{:});
					
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pe)], ...
					        ['BRAPH2' ':' class(pe) '\n' ...
					        'The call pe.get(''HIDE'') has NOT been executed.\n' ...
					        'First, the panel ' pe.get('ID') ' should be drawn calling pe.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case 18 % PanelElement.DELETE
					value = calculateValue@Panel(pe, 18, varargin{:}); % also warning
					if value
					    pe.set('LISTENER_PPHEIGHT', Element.getNoValue())
					end
					
				case 19 % PanelElement.CLOSE
					if pe.get('DRAWN')
					    
					    pr_dict = pe.get('PR_DICT');
					    for pri = 1:1:pr_dict.get('LENGTH')
					        pr = pr_dict.get('IT', pri);
					        pr.get('CLOSE', 'CloseParentFigure', false)
					    end
					    
					    calculateValue@Panel(pe, 19, varargin{:});
					    
					    value = true;
					else
					    warning( ...
					        ['BRAPH2' ':' class(pe)], ...
					        ['BRAPH2' ':' class(pe) '\n' ...
					        'The call pe.get(''CLOSE'') has NOT been executed.\n' ...
					        'First, the panel ' pe.get('ID') ' should be drawn calling pe.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				otherwise
					if prop <= 19
						value = calculateValue@Panel(pe, prop, varargin{:});
					else
						value = calculateValue@Element(pe, prop, varargin{:});
					end
			end
			
			function cb_get(~, ~, varargin)
				pe.get(varargin{:})
			end
			function cb_listener_ppheight(~, event)
			    if ismember(25, cell2mat(event.props)) && pe.get('DRAWN')
			        pe.get('RESIZEY')
			    end
			end
		end
	end
end
