classdef PanelPropRVectorView < PanelProp
	%PanelPropRVectorView plots the panel of a view with azimuth and elevation angles.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A View Prop Panel (PanelPropRVectorView) plots the panel for the azimuth and elevation angles of the camera''s line of sight.
	%  Azimuth — The angle of rotation around the z-axis, as measured from the negative y-axis. 
	%   Increasing this angle corresponds to counterclockwise rotation about the z-axis 
	%   when viewing the xy plane from above.
	%  Elevation — The minimum angle between the line of sight and the xy plane. Increasing the elevation 
	%   from -90 to 90 degrees corresponds to a rotation from the negative z-axis to the positive z-axis.
	% It works for all categories.
	%
	% The list of PanelPropRVectorView properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel of a view with azimuth and elevation angles.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel of a view with azimuth and elevation angles.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel of a view with azimuth and elevation angles.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel of a view with azimuth and elevation angles.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel of a view with azimuth and elevation angles.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel of a view with azimuth and elevation angles.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel of a view with azimuth and elevation angles.
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
	%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.
	%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.
	%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
	%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
	%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the settings position panel.
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
	%  <strong>36</strong> <strong>ENABLE</strong> 	ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.
	%  <strong>37</strong> <strong>LABEL_AZ</strong> 	LABEL_AZ (evanescent, handle) is the azimuthal angle label.
	%  <strong>38</strong> <strong>EDITFIELD_AZ</strong> 	EDITFIELD_AZ (evanescent, handle) is the azimuthal angle edit field.
	%  <strong>39</strong> <strong>SLIDER_AZ</strong> 	SLIDER_AZ (evanescent, handle) is the azimuthal angle slider.
	%  <strong>40</strong> <strong>LABEL_EL</strong> 	LABEL_EL (evanescent, handle) is the elevation angle label.
	%  <strong>41</strong> <strong>EDITFIELD_EL</strong> 	EDITFIELD_EL (evanescent, handle) is the elevation angle edit field.
	%  <strong>42</strong> <strong>SLIDER_EL</strong> 	SLIDER_EL (evanescent, handle) is the elevation angle slider.
	%
	% PanelPropRVectorView methods (constructor):
	%  PanelPropRVectorView - constructor
	%
	% PanelPropRVectorView methods:
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
	% PanelPropRVectorView methods (display):
	%  tostring - string with information about the view prop panel
	%  disp - displays information about the view prop panel
	%  tree - displays the tree of the view prop panel
	%
	% PanelPropRVectorView methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two view prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the view prop panel
	%
	% PanelPropRVectorView methods (save/load, Static):
	%  save - saves BRAPH2 view prop panel as b2 file
	%  load - loads a BRAPH2 view prop panel from a b2 file
	%
	% PanelPropRVectorView method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the view prop panel
	%
	% PanelPropRVectorView method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the view prop panel
	%
	% PanelPropRVectorView methods (inspection, Static):
	%  getClass - returns the class of the view prop panel
	%  getSubclasses - returns all subclasses of PanelPropRVectorView
	%  getProps - returns the property list of the view prop panel
	%  getPropNumber - returns the property number of the view prop panel
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
	% PanelPropRVectorView methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropRVectorView methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropRVectorView methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropRVectorView methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropRVectorView; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropRVectorView constants</a>.
	%
	%
	% See also GUI, PanelElement, view, uieditfield, uislider.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		ENABLE = 36; %CET: Computational Efficiency Trick
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = 9;
		ENABLE_FORMAT = 4;
		
		LABEL_AZ = 37; %CET: Computational Efficiency Trick
		LABEL_AZ_TAG = 'LABEL_AZ';
		LABEL_AZ_CATEGORY = 7;
		LABEL_AZ_FORMAT = 18;
		
		EDITFIELD_AZ = 38; %CET: Computational Efficiency Trick
		EDITFIELD_AZ_TAG = 'EDITFIELD_AZ';
		EDITFIELD_AZ_CATEGORY = 7;
		EDITFIELD_AZ_FORMAT = 18;
		
		SLIDER_AZ = 39; %CET: Computational Efficiency Trick
		SLIDER_AZ_TAG = 'SLIDER_AZ';
		SLIDER_AZ_CATEGORY = 7;
		SLIDER_AZ_FORMAT = 18;
		
		LABEL_EL = 40; %CET: Computational Efficiency Trick
		LABEL_EL_TAG = 'LABEL_EL';
		LABEL_EL_CATEGORY = 7;
		LABEL_EL_FORMAT = 18;
		
		EDITFIELD_EL = 41; %CET: Computational Efficiency Trick
		EDITFIELD_EL_TAG = 'EDITFIELD_EL';
		EDITFIELD_EL_CATEGORY = 7;
		EDITFIELD_EL_FORMAT = 18;
		
		SLIDER_EL = 42; %CET: Computational Efficiency Trick
		SLIDER_EL_TAG = 'SLIDER_EL';
		SLIDER_EL_CATEGORY = 7;
		SLIDER_EL_FORMAT = 18;
	end
	methods % constructor
		function pr = PanelPropRVectorView(varargin)
			%PanelPropRVectorView() creates a view prop panel.
			%
			% PanelPropRVectorView(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropRVectorView(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PanelPropRVectorView properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel of a view with azimuth and elevation angles.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel of a view with azimuth and elevation angles.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel of a view with azimuth and elevation angles.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel of a view with azimuth and elevation angles.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel of a view with azimuth and elevation angles.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel of a view with azimuth and elevation angles.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel of a view with azimuth and elevation angles.
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
			%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.
			%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.
			%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
			%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
			%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the settings position panel.
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
			%  <strong>36</strong> <strong>ENABLE</strong> 	ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.
			%  <strong>37</strong> <strong>LABEL_AZ</strong> 	LABEL_AZ (evanescent, handle) is the azimuthal angle label.
			%  <strong>38</strong> <strong>EDITFIELD_AZ</strong> 	EDITFIELD_AZ (evanescent, handle) is the azimuthal angle edit field.
			%  <strong>39</strong> <strong>SLIDER_AZ</strong> 	SLIDER_AZ (evanescent, handle) is the azimuthal angle slider.
			%  <strong>40</strong> <strong>LABEL_EL</strong> 	LABEL_EL (evanescent, handle) is the elevation angle label.
			%  <strong>41</strong> <strong>EDITFIELD_EL</strong> 	EDITFIELD_EL (evanescent, handle) is the elevation angle edit field.
			%  <strong>42</strong> <strong>SLIDER_EL</strong> 	SLIDER_EL (evanescent, handle) is the elevation angle slider.
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the view prop panel.
			%
			% BUILD = PanelPropRVectorView.GETBUILD() returns the build of 'PanelPropRVectorView'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the view prop panel PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('PanelPropRVectorView') returns the build of 'PanelPropRVectorView'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('PanelPropRVectorView')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the view prop panel.
			%
			% CLASS = PanelPropRVectorView.GETCLASS() returns the class 'PanelPropRVectorView'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the view prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropRVectorView') returns 'PanelPropRVectorView'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropRVectorView')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropRVectorView';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the view prop panel.
			%
			% LIST = PanelPropRVectorView.GETSUBCLASSES() returns all subclasses of 'PanelPropRVectorView'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the view prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropRVectorView') returns all subclasses of 'PanelPropRVectorView'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'PanelPropRVectorView' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of view prop panel.
			%
			% PROPS = PanelPropRVectorView.GETPROPS() returns the property list of view prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropRVectorView.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the view prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropRVectorView'[, CATEGORY]) returns the property list of 'PanelPropRVectorView'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42];
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
					prop_list = [10 15 27 28 30 31 32 33 34 35 37 38 39 40 41 42];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of view prop panel.
			%
			% N = PanelPropRVectorView.GETPROPNUMBER() returns the property number of view prop panel.
			%
			% N = PanelPropRVectorView.GETPROPNUMBER(CATEGORY) returns the property number of view prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the view prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropRVectorView') returns the property number of 'PanelPropRVectorView'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 42;
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
					prop_number = 16;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 5;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in view prop panel/error.
			%
			% CHECK = PanelPropRVectorView.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropRVectorView, PROP) checks whether PROP exists for PanelPropRVectorView.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropRVectorView:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropRVectorView:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropRVectorView:WrongInput]
			%  Element.EXISTSPROP(PanelPropRVectorView, PROP) throws error if PROP does NOT exist for PanelPropRVectorView.
			%   Error id: [BRAPH2:PanelPropRVectorView:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 42 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropRVectorView:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropRVectorView:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropRVectorView.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in view prop panel/error.
			%
			% CHECK = PanelPropRVectorView.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropRVectorView, TAG) checks whether TAG exists for PanelPropRVectorView.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropRVectorView:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropRVectorView:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropRVectorView:WrongInput]
			%  Element.EXISTSTAG(PanelPropRVectorView, TAG) throws error if TAG does NOT exist for PanelPropRVectorView.
			%   Error id: [BRAPH2:PanelPropRVectorView:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'LABEL_AZ'  'EDITFIELD_AZ'  'SLIDER_AZ'  'LABEL_EL'  'EDITFIELD_EL'  'SLIDER_EL' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropRVectorView:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropRVectorView:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropRVectorView.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropRVectorView, POINTER) returns property number of POINTER of PanelPropRVectorView.
			%  PROPERTY = PR.GETPROPPROP(PanelPropRVectorView, POINTER) returns property number of POINTER of PanelPropRVectorView.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'LABEL_AZ'  'EDITFIELD_AZ'  'SLIDER_AZ'  'LABEL_EL'  'EDITFIELD_EL'  'SLIDER_EL' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(PanelPropRVectorView, POINTER) returns tag of POINTER of PanelPropRVectorView.
			%  TAG = PR.GETPROPTAG(PanelPropRVectorView, POINTER) returns tag of POINTER of PanelPropRVectorView.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				panelproprvectorview_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'LABEL_AZ'  'EDITFIELD_AZ'  'SLIDER_AZ'  'LABEL_EL'  'EDITFIELD_EL'  'SLIDER_EL' };
				tag = panelproprvectorview_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropRVectorView, POINTER) returns category of POINTER of PanelPropRVectorView.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropRVectorView, POINTER) returns category of POINTER of PanelPropRVectorView.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropRVectorView.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelproprvectorview_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  7  7  7  7  7  7 };
			prop_category = panelproprvectorview_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropRVectorView, POINTER) returns format of POINTER of PanelPropRVectorView.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropRVectorView, POINTER) returns format of POINTER of PanelPropRVectorView.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropRVectorView.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelproprvectorview_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  4  18  18  18  18  18  18 };
			prop_format = panelproprvectorview_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropRVectorView, POINTER) returns description of POINTER of PanelPropRVectorView.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropRVectorView, POINTER) returns description of POINTER of PanelPropRVectorView.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropRVectorView.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelproprvectorview_description_list = { 'ELCLASS (constant, string) is the class of the panel of a view with azimuth and elevation angles.'  'NAME (constant, string) is the name of the panel of a view with azimuth and elevation angles.'  'DESCRIPTION (constant, string) is the description of the panel of a view with azimuth and elevation angles.'  'TEMPLATE (parameter, item) is the template of the panel of a view with azimuth and elevation angles.'  'ID (data, string) is a few-letter code for the panel of a view with azimuth and elevation angles.'  'LABEL (metadata, string) is an extended label of the panel of a view with azimuth and elevation angles.'  'NOTES (metadata, string) are some specific notes about the panel of a view with azimuth and elevation angles.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.'  'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the settings position panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.'  'LABEL_AZ (evanescent, handle) is the azimuthal angle label.'  'EDITFIELD_AZ (evanescent, handle) is the azimuthal angle edit field.'  'SLIDER_AZ (evanescent, handle) is the azimuthal angle slider.'  'LABEL_EL (evanescent, handle) is the elevation angle label.'  'EDITFIELD_EL (evanescent, handle) is the elevation angle edit field.'  'SLIDER_EL (evanescent, handle) is the elevation angle slider.' };
			prop_description = panelproprvectorview_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropRVectorView, POINTER) returns settings of POINTER of PanelPropRVectorView.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropRVectorView, POINTER) returns settings of POINTER of PanelPropRVectorView.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropRVectorView.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % PanelPropRVectorView.ENABLE
					prop_settings = Format.getFormatSettings(4);
				case 37 % PanelPropRVectorView.LABEL_AZ
					prop_settings = Format.getFormatSettings(18);
				case 38 % PanelPropRVectorView.EDITFIELD_AZ
					prop_settings = Format.getFormatSettings(18);
				case 39 % PanelPropRVectorView.SLIDER_AZ
					prop_settings = Format.getFormatSettings(18);
				case 40 % PanelPropRVectorView.LABEL_EL
					prop_settings = Format.getFormatSettings(18);
				case 41 % PanelPropRVectorView.EDITFIELD_EL
					prop_settings = Format.getFormatSettings(18);
				case 42 % PanelPropRVectorView.SLIDER_EL
					prop_settings = Format.getFormatSettings(18);
				case 4 % PanelPropRVectorView.TEMPLATE
					prop_settings = 'PanelPropRVectorView';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropRVectorView.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropRVectorView.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropRVectorView, POINTER) returns the default value of POINTER of PanelPropRVectorView.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropRVectorView, POINTER) returns the default value of POINTER of PanelPropRVectorView.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropRVectorView.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % PanelPropRVectorView.ENABLE
					prop_default = true;
				case 37 % PanelPropRVectorView.LABEL_AZ
					prop_default = Format.getFormatDefault(18, PanelPropRVectorView.getPropSettings(prop));
				case 38 % PanelPropRVectorView.EDITFIELD_AZ
					prop_default = Format.getFormatDefault(18, PanelPropRVectorView.getPropSettings(prop));
				case 39 % PanelPropRVectorView.SLIDER_AZ
					prop_default = Format.getFormatDefault(18, PanelPropRVectorView.getPropSettings(prop));
				case 40 % PanelPropRVectorView.LABEL_EL
					prop_default = Format.getFormatDefault(18, PanelPropRVectorView.getPropSettings(prop));
				case 41 % PanelPropRVectorView.EDITFIELD_EL
					prop_default = Format.getFormatDefault(18, PanelPropRVectorView.getPropSettings(prop));
				case 42 % PanelPropRVectorView.SLIDER_EL
					prop_default = Format.getFormatDefault(18, PanelPropRVectorView.getPropSettings(prop));
				case 1 % PanelPropRVectorView.ELCLASS
					prop_default = 'PanelPropRVectorView';
				case 2 % PanelPropRVectorView.NAME
					prop_default = 'View Prop Panel';
				case 3 % PanelPropRVectorView.DESCRIPTION
					prop_default = 'A View Prop Panel (PanelPropRVectorView) plots the panel for the azimuth and elevation angles of the camera''s line of sight. Azimuth — The angle of rotation around the z-axis, as measured from the negative y-axis. Increasing this angle corresponds to counterclockwise rotation about the z-axis when viewing the xy plane from above. Elevation — The minimum angle between the line of sight and the xy plane. Increasing the elevation from -90 to 90 degrees corresponds to a rotation from the negative z-axis to the positive z-axis.It works for all categories.';
				case 4 % PanelPropRVectorView.TEMPLATE
					prop_default = Format.getFormatDefault(8, PanelPropRVectorView.getPropSettings(prop));
				case 5 % PanelPropRVectorView.ID
					prop_default = 'PanelPropRVectorView ID';
				case 6 % PanelPropRVectorView.LABEL
					prop_default = 'PanelPropRVectorView label';
				case 7 % PanelPropRVectorView.NOTES
					prop_default = 'PanelPropRVectorView notes';
				case 23 % PanelPropRVectorView.EL
					prop_default = BrainSurfacePF();
				case 24 % PanelPropRVectorView.PROP
					prop_default = 24;
				case 25 % PanelPropRVectorView.HEIGHT
					prop_default = 77;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropRVectorView.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropRVectorView.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropRVectorView, POINTER) returns the conditioned default value of POINTER of PanelPropRVectorView.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropRVectorView, POINTER) returns the conditioned default value of POINTER of PanelPropRVectorView.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropRVectorView.getPropProp(pointer);
			
			prop_default = PanelPropRVectorView.conditioning(prop, PanelPropRVectorView.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropRVectorView, PROP, VALUE) checks VALUE format for PROP of PanelPropRVectorView.
			%  CHECK = PR.CHECKPROP(PanelPropRVectorView, PROP, VALUE) checks VALUE format for PROP of PanelPropRVectorView.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:PanelPropRVectorView:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:PanelPropRVectorView:WrongInput
			%  Element.CHECKPROP(PanelPropRVectorView, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropRVectorView.
			%   Error id: BRAPH2:PanelPropRVectorView:WrongInput
			%  PR.CHECKPROP(PanelPropRVectorView, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropRVectorView.
			%   Error id: BRAPH2:PanelPropRVectorView:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropRVectorView')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropRVectorView.getPropProp(pointer);
			
			switch prop
				case 36 % PanelPropRVectorView.ENABLE
					check = Format.checkFormat(4, value, PanelPropRVectorView.getPropSettings(prop));
				case 37 % PanelPropRVectorView.LABEL_AZ
					check = Format.checkFormat(18, value, PanelPropRVectorView.getPropSettings(prop));
				case 38 % PanelPropRVectorView.EDITFIELD_AZ
					check = Format.checkFormat(18, value, PanelPropRVectorView.getPropSettings(prop));
				case 39 % PanelPropRVectorView.SLIDER_AZ
					check = Format.checkFormat(18, value, PanelPropRVectorView.getPropSettings(prop));
				case 40 % PanelPropRVectorView.LABEL_EL
					check = Format.checkFormat(18, value, PanelPropRVectorView.getPropSettings(prop));
				case 41 % PanelPropRVectorView.EDITFIELD_EL
					check = Format.checkFormat(18, value, PanelPropRVectorView.getPropSettings(prop));
				case 42 % PanelPropRVectorView.SLIDER_EL
					check = Format.checkFormat(18, value, PanelPropRVectorView.getPropSettings(prop));
				case 4 % PanelPropRVectorView.TEMPLATE
					check = Format.checkFormat(8, value, PanelPropRVectorView.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropRVectorView:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropRVectorView:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropRVectorView.getPropTag(prop) ' (' PanelPropRVectorView.getFormatTag(PanelPropRVectorView.getPropFormat(prop)) ').'] ...
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
				case 37 % PanelPropRVectorView.LABEL_AZ
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_az =  uilabel( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'LABEL_AZ', ...
					    'Text', 'azimuth', ...
					    'FontSize', 12, ...
					    'HorizontalAlignment', 'right', ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'BackgroundColor', pr.get('BKGCOLOR') ...
					    );
					value = label_az;
					
				case 38 % PanelPropRVectorView.EDITFIELD_AZ
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_az = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'EDITFIELD_AZ', ...
					    'Limits', [-180 180], ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_editfield_az} ...
					    );
					value = editfield_az;
					
				case 39 % PanelPropRVectorView.SLIDER_AZ
					el = pr.get('EL');
					prop = pr.get('PROP');
					slider_az = uislider( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'SLIDER_AZ', ...
					    'Limits', [-180 180], ...
					    'FontSize', 12 / 2, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_slider_az} ...
					    );
					value = slider_az;
					
				case 40 % PanelPropRVectorView.LABEL_EL
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_el =  uilabel( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'LABEL_EL', ...
					    'Text', 'elevation', ...
					    'FontSize', 12, ...
					    'HorizontalAlignment', 'right', ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'BackgroundColor', pr.get('BKGCOLOR') ...
					    );
					value = label_el;
					
				case 41 % PanelPropRVectorView.EDITFIELD_EL
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_el = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'EDITFIELD_EL', ...
					    'Limits', [-90 90], ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_editfield_el} ...
					    );
					value = editfield_el;
					
				case 42 % PanelPropRVectorView.SLIDER_EL
					el = pr.get('EL');
					prop = pr.get('PROP');
					slider_el = uislider( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'SLIDER_EL', ...
					    'Limits', [-90 90], ...
					    'FontSize', 12 / 2, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_slider_el} ...
					    );
					value = slider_el;
					
				case 20 % PanelPropRVectorView.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('LABEL_AZ')
					    pr.memorize('EDITFIELD_AZ')
					    pr.memorize('SLIDER_AZ')
					
					    pr.memorize('LABEL_EL')
					    pr.memorize('EDITFIELD_EL')
					    pr.memorize('SLIDER_EL')
					end
					
				case 21 % PanelPropRVectorView.UPDATE
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if el.isLocked(prop)
					        set(pr.get('EDITFIELD_AZ'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('SLIDER_AZ'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('EDITFIELD_EL'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('SLIDER_EL'), 'Enable', pr.get('ENABLE'))
					    end
					
					    switch el.getPropCategory(prop)
					        case 2
					            v = el.get(prop);
					            set(pr.get('EDITFIELD_AZ'), 'Value', v(1))
					            set(pr.get('SLIDER_AZ'), 'Value', v(1))
					            set(pr.get('EDITFIELD_EL'), 'Value', v(2))
					            set(pr.get('SLIDER_EL'), 'Value', v(2))
					
					        case {3, 4, 8, 9}
					            v = el.get(prop);
					            set(pr.get('EDITFIELD_AZ'), 'Value', v(1))
					            set(pr.get('SLIDER_AZ'), 'Value', v(1))
					            set(pr.get('EDITFIELD_EL'), 'Value', v(2))
					            set(pr.get('SLIDER_EL'), 'Value', v(2))
					
					            prop_value = el.getr(prop);
					            if isa(prop_value, 'Callback')
					                set(pr.get('EDITFIELD_AZ'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_AZ'), 'Enable', pr.get('ENABLE'))
					                set(pr.get('EDITFIELD_EL'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_EL'), 'Enable', pr.get('ENABLE'))
					            end
					
					        case 5
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                v = el.getPropDefault(prop);
					                set(pr.get('EDITFIELD_AZ'), ...
					                    'Value', v(1), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_AZ'), ...
					                    'Value', v(1), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_EL'), ...
					                    'Value', v(2), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_EL'), ...
					                    'Value', v(2), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            else
					                v = el.get(prop);
					                set(pr.get('EDITFIELD_AZ'), ...
					                    'Value', v(1), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_AZ'), ...
					                    'Value', v(1), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_EL'), ...
					                    'Value', v(2), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_EL'), ...
					                    'Value', v(2), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					    end
					end
					
				case 22 % PanelPropRVectorView.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('LABEL_AZ'),     'Position', [4                 39  .20*w_p   21])
					    set(pr.get('EDITFIELD_AZ'), 'Position', [8+.20*w_p         39  .15*w_p   21])
					    set(pr.get('SLIDER_AZ'),    'Position', [8+.35*w_p+21  57 .50*w_p   3]) % the height of a slider cannot be changed
					    set(pr.get('LABEL_EL'),     'Position', [4                 9   .20*w_p   21])
					    set(pr.get('EDITFIELD_EL'), 'Position', [8+.20*w_p         9   .15*w_p   21])
					    set(pr.get('SLIDER_EL'),    'Position', [8+.35*w_p+21  27 .50*w_p   3]) % the height of a slider cannot be changed
					end
					
				case 18 % PanelPropRVectorView.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('LABEL_AZ', Element.getNoValue())
					    pr.set('EDITFIELD_AZ', Element.getNoValue())
					    pr.set('SLIDER_AZ', Element.getNoValue())
					
					    pr.set('LABEL_EL', Element.getNoValue())
					    pr.set('EDITFIELD_EL', Element.getNoValue())
					    pr.set('SLIDER_EL', Element.getNoValue())
					end
					
				otherwise
					if prop <= 35
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_editfield_az(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    azimuth = get(pr.get('EDITFIELD_AZ'), 'Value');
			    
			    old_v = el.get(prop);
			    elevation = old_v(2);
			    
			    el.set(prop, [azimuth, elevation])
			end
			function cb_slider_az(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    azimuth = get(pr.get('SLIDER_AZ'), 'Value');
			    
			    old_v = el.get(prop);
			    elevation = old_v(2);
			    
			    el.set(prop, [azimuth, elevation])
			end
			function cb_editfield_el(~, ~) % (src, event)
			    
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    old_v = el.get(prop);
			    azimuth = old_v(1);
			
			    elevation = get(pr.get('EDITFIELD_EL'), 'Value');
			    
			    el.set(prop, [azimuth, elevation])
			end
			function cb_slider_el(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    old_v = el.get(prop);
			    azimuth = old_v(1);
			    
			    elevation = get(pr.get('SLIDER_EL'), 'Value');
			    
			    el.set(prop, [azimuth, elevation])
			end
		end
	end
end
