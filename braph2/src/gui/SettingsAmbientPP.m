classdef SettingsAmbientPP < SettingsPP
	%SettingsAmbientPP is the panel with ambient settings.
	% It is a subclass of <a href="matlab:help SettingsPP">SettingsPP</a>.
	%
	% A Prop Panel for Ambient Settings (SettingsAmbientPP) plots the panel 
	%  for ambient settings, including drop-down lists for lighting, material, 
	%  camlight, shading, and colormap.
	% It works for all categories.
	%
	% The list of SettingsAmbientPP properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the prop panel for ambient settings.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the prop panel for ambient settings.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the prop panel for ambient settings.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the prop panel for ambient settings.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the prop panel for ambient settings.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the prop panel for ambient settings.
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
	%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
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
	%  <strong>37</strong> <strong>LABEL_LIGHTING</strong> 	LABEL_LIGHTING (evanescent, handle) is the label of the lighting dropdown menu.
	%  <strong>38</strong> <strong>DROPDOWN_LIGHTING</strong> 	DROPDOWN_LIGHTING (evanescent, handle) is the lighting dropdown menu.
	%  <strong>39</strong> <strong>LABEL_MATERIAL</strong> 	LABEL_MATERIAL (evanescent, handle) is the label of the of the material dropdown menu.
	%  <strong>40</strong> <strong>DROPDOWN_MATERIAL</strong> 	DROPDOWN_MATERIAL (evanescent, handle) is the material dropdown menu.
	%  <strong>41</strong> <strong>LABEL_CAMLIGHT</strong> 	LABEL_CAMLIGHT (evanescent, handle) is the label of the camlight dropdown menu.
	%  <strong>42</strong> <strong>DROPDOWN_CAMLIGHT</strong> 	DROPDOWN_CAMLIGHT (evanescent, handle) is the camlight dropdown menu.
	%  <strong>43</strong> <strong>LABEL_SHADING</strong> 	LABEL_SHADING (evanescent, handle) is the label of the shading dropdown menu.
	%  <strong>44</strong> <strong>DROPDOWN_SHADING</strong> 	DROPDOWN_SHADING (evanescent, handle) is the shading dropdown menu.
	%  <strong>45</strong> <strong>LABEL_COLORMAP</strong> 	LABEL_COLORMAP (evanescent, handle) is the label of the colormap dropdown menu.
	%  <strong>46</strong> <strong>DROPDOWN_COLORMAP</strong> 	DROPDOWN_COLORMAP (evanescent, handle) is the colormap dropdown menu.
	%
	% SettingsAmbientPP methods (constructor):
	%  SettingsAmbientPP - constructor
	%
	% SettingsAmbientPP methods:
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
	% SettingsAmbientPP methods (display):
	%  tostring - string with information about the prop panel for ambient settings
	%  disp - displays information about the prop panel for ambient settings
	%  tree - displays the tree of the prop panel for ambient settings
	%
	% SettingsAmbientPP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel for ambient settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel for ambient settings
	%
	% SettingsAmbientPP methods (save/load, Static):
	%  save - saves BRAPH2 prop panel for ambient settings as b2 file
	%  load - loads a BRAPH2 prop panel for ambient settings from a b2 file
	%
	% SettingsAmbientPP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel for ambient settings
	%
	% SettingsAmbientPP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel for ambient settings
	%
	% SettingsAmbientPP methods (inspection, Static):
	%  getClass - returns the class of the prop panel for ambient settings
	%  getSubclasses - returns all subclasses of SettingsAmbientPP
	%  getProps - returns the property list of the prop panel for ambient settings
	%  getPropNumber - returns the property number of the prop panel for ambient settings
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
	% SettingsAmbientPP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsAmbientPP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsAmbientPP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsAmbientPP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsAmbientPP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsAmbientPP constants</a>.
	%
	%
	% See also SettingsAmbient, uidropdown.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		ENABLE = 36; %CET: Computational Efficiency Trick
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = 9;
		ENABLE_FORMAT = 4;
		
		LABEL_LIGHTING = 37; %CET: Computational Efficiency Trick
		LABEL_LIGHTING_TAG = 'LABEL_LIGHTING';
		LABEL_LIGHTING_CATEGORY = 7;
		LABEL_LIGHTING_FORMAT = 18;
		
		DROPDOWN_LIGHTING = 38; %CET: Computational Efficiency Trick
		DROPDOWN_LIGHTING_TAG = 'DROPDOWN_LIGHTING';
		DROPDOWN_LIGHTING_CATEGORY = 7;
		DROPDOWN_LIGHTING_FORMAT = 18;
		
		LABEL_MATERIAL = 39; %CET: Computational Efficiency Trick
		LABEL_MATERIAL_TAG = 'LABEL_MATERIAL';
		LABEL_MATERIAL_CATEGORY = 7;
		LABEL_MATERIAL_FORMAT = 18;
		
		DROPDOWN_MATERIAL = 40; %CET: Computational Efficiency Trick
		DROPDOWN_MATERIAL_TAG = 'DROPDOWN_MATERIAL';
		DROPDOWN_MATERIAL_CATEGORY = 7;
		DROPDOWN_MATERIAL_FORMAT = 18;
		
		LABEL_CAMLIGHT = 41; %CET: Computational Efficiency Trick
		LABEL_CAMLIGHT_TAG = 'LABEL_CAMLIGHT';
		LABEL_CAMLIGHT_CATEGORY = 7;
		LABEL_CAMLIGHT_FORMAT = 18;
		
		DROPDOWN_CAMLIGHT = 42; %CET: Computational Efficiency Trick
		DROPDOWN_CAMLIGHT_TAG = 'DROPDOWN_CAMLIGHT';
		DROPDOWN_CAMLIGHT_CATEGORY = 7;
		DROPDOWN_CAMLIGHT_FORMAT = 18;
		
		LABEL_SHADING = 43; %CET: Computational Efficiency Trick
		LABEL_SHADING_TAG = 'LABEL_SHADING';
		LABEL_SHADING_CATEGORY = 7;
		LABEL_SHADING_FORMAT = 18;
		
		DROPDOWN_SHADING = 44; %CET: Computational Efficiency Trick
		DROPDOWN_SHADING_TAG = 'DROPDOWN_SHADING';
		DROPDOWN_SHADING_CATEGORY = 7;
		DROPDOWN_SHADING_FORMAT = 18;
		
		LABEL_COLORMAP = 45; %CET: Computational Efficiency Trick
		LABEL_COLORMAP_TAG = 'LABEL_COLORMAP';
		LABEL_COLORMAP_CATEGORY = 7;
		LABEL_COLORMAP_FORMAT = 18;
		
		DROPDOWN_COLORMAP = 46; %CET: Computational Efficiency Trick
		DROPDOWN_COLORMAP_TAG = 'DROPDOWN_COLORMAP';
		DROPDOWN_COLORMAP_CATEGORY = 7;
		DROPDOWN_COLORMAP_FORMAT = 18;
	end
	methods % constructor
		function pr = SettingsAmbientPP(varargin)
			%SettingsAmbientPP() creates a prop panel for ambient settings.
			%
			% SettingsAmbientPP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsAmbientPP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SettingsAmbientPP properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the prop panel for ambient settings.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the prop panel for ambient settings.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the prop panel for ambient settings.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the prop panel for ambient settings.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the prop panel for ambient settings.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the prop panel for ambient settings.
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
			%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
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
			%  <strong>37</strong> <strong>LABEL_LIGHTING</strong> 	LABEL_LIGHTING (evanescent, handle) is the label of the lighting dropdown menu.
			%  <strong>38</strong> <strong>DROPDOWN_LIGHTING</strong> 	DROPDOWN_LIGHTING (evanescent, handle) is the lighting dropdown menu.
			%  <strong>39</strong> <strong>LABEL_MATERIAL</strong> 	LABEL_MATERIAL (evanescent, handle) is the label of the of the material dropdown menu.
			%  <strong>40</strong> <strong>DROPDOWN_MATERIAL</strong> 	DROPDOWN_MATERIAL (evanescent, handle) is the material dropdown menu.
			%  <strong>41</strong> <strong>LABEL_CAMLIGHT</strong> 	LABEL_CAMLIGHT (evanescent, handle) is the label of the camlight dropdown menu.
			%  <strong>42</strong> <strong>DROPDOWN_CAMLIGHT</strong> 	DROPDOWN_CAMLIGHT (evanescent, handle) is the camlight dropdown menu.
			%  <strong>43</strong> <strong>LABEL_SHADING</strong> 	LABEL_SHADING (evanescent, handle) is the label of the shading dropdown menu.
			%  <strong>44</strong> <strong>DROPDOWN_SHADING</strong> 	DROPDOWN_SHADING (evanescent, handle) is the shading dropdown menu.
			%  <strong>45</strong> <strong>LABEL_COLORMAP</strong> 	LABEL_COLORMAP (evanescent, handle) is the label of the colormap dropdown menu.
			%  <strong>46</strong> <strong>DROPDOWN_COLORMAP</strong> 	DROPDOWN_COLORMAP (evanescent, handle) is the colormap dropdown menu.
			%
			% See also Category, Format.
			
			pr = pr@SettingsPP(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the prop panel for ambient settings.
			%
			% BUILD = SettingsAmbientPP.GETBUILD() returns the build of 'SettingsAmbientPP'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the prop panel for ambient settings PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('SettingsAmbientPP') returns the build of 'SettingsAmbientPP'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('SettingsAmbientPP')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the prop panel for ambient settings.
			%
			% CLASS = SettingsAmbientPP.GETCLASS() returns the class 'SettingsAmbientPP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel for ambient settings PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SettingsAmbientPP') returns 'SettingsAmbientPP'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SettingsAmbientPP')
			%  are less computationally efficient.
			
			pr_class = 'SettingsAmbientPP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel for ambient settings.
			%
			% LIST = SettingsAmbientPP.GETSUBCLASSES() returns all subclasses of 'SettingsAmbientPP'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel for ambient settings PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SettingsAmbientPP') returns all subclasses of 'SettingsAmbientPP'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SettingsAmbientPP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel for ambient settings.
			%
			% PROPS = SettingsAmbientPP.GETPROPS() returns the property list of prop panel for ambient settings
			%  as a row vector.
			%
			% PROPS = SettingsAmbientPP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel for ambient settings PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SettingsAmbientPP'[, CATEGORY]) returns the property list of 'SettingsAmbientPP'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46];
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
					prop_list = [10 15 27 28 30 31 32 33 34 35 37 38 39 40 41 42 43 44 45 46];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel for ambient settings.
			%
			% N = SettingsAmbientPP.GETPROPNUMBER() returns the property number of prop panel for ambient settings.
			%
			% N = SettingsAmbientPP.GETPROPNUMBER(CATEGORY) returns the property number of prop panel for ambient settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel for ambient settings PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SettingsAmbientPP') returns the property number of 'SettingsAmbientPP'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 46;
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
					prop_number = 20;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 5;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel for ambient settings/error.
			%
			% CHECK = SettingsAmbientPP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SettingsAmbientPP, PROP) checks whether PROP exists for SettingsAmbientPP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsAmbientPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAmbientPP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAmbientPP:WrongInput]
			%  Element.EXISTSPROP(SettingsAmbientPP, PROP) throws error if PROP does NOT exist for SettingsAmbientPP.
			%   Error id: [BRAPH2:SettingsAmbientPP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 46 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsAmbientPP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsAmbientPP:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsAmbientPP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel for ambient settings/error.
			%
			% CHECK = SettingsAmbientPP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SettingsAmbientPP, TAG) checks whether TAG exists for SettingsAmbientPP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsAmbientPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAmbientPP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAmbientPP:WrongInput]
			%  Element.EXISTSTAG(SettingsAmbientPP, TAG) throws error if TAG does NOT exist for SettingsAmbientPP.
			%   Error id: [BRAPH2:SettingsAmbientPP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'LABEL_LIGHTING'  'DROPDOWN_LIGHTING'  'LABEL_MATERIAL'  'DROPDOWN_MATERIAL'  'LABEL_CAMLIGHT'  'DROPDOWN_CAMLIGHT'  'LABEL_SHADING'  'DROPDOWN_SHADING'  'LABEL_COLORMAP'  'DROPDOWN_COLORMAP' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsAmbientPP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsAmbientPP:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SettingsAmbientPP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsAmbientPP, POINTER) returns property number of POINTER of SettingsAmbientPP.
			%  PROPERTY = PR.GETPROPPROP(SettingsAmbientPP, POINTER) returns property number of POINTER of SettingsAmbientPP.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'LABEL_LIGHTING'  'DROPDOWN_LIGHTING'  'LABEL_MATERIAL'  'DROPDOWN_MATERIAL'  'LABEL_CAMLIGHT'  'DROPDOWN_CAMLIGHT'  'LABEL_SHADING'  'DROPDOWN_SHADING'  'LABEL_COLORMAP'  'DROPDOWN_COLORMAP' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(SettingsAmbientPP, POINTER) returns tag of POINTER of SettingsAmbientPP.
			%  TAG = PR.GETPROPTAG(SettingsAmbientPP, POINTER) returns tag of POINTER of SettingsAmbientPP.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				settingsambientpp_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'LABEL_LIGHTING'  'DROPDOWN_LIGHTING'  'LABEL_MATERIAL'  'DROPDOWN_MATERIAL'  'LABEL_CAMLIGHT'  'DROPDOWN_CAMLIGHT'  'LABEL_SHADING'  'DROPDOWN_SHADING'  'LABEL_COLORMAP'  'DROPDOWN_COLORMAP' };
				tag = settingsambientpp_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsAmbientPP, POINTER) returns category of POINTER of SettingsAmbientPP.
			%  CATEGORY = PR.GETPROPCATEGORY(SettingsAmbientPP, POINTER) returns category of POINTER of SettingsAmbientPP.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAmbientPP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsambientpp_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  7  7  7  7  7  7  7  7  7  7 };
			prop_category = settingsambientpp_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsAmbientPP, POINTER) returns format of POINTER of SettingsAmbientPP.
			%  FORMAT = PR.GETPROPFORMAT(SettingsAmbientPP, POINTER) returns format of POINTER of SettingsAmbientPP.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAmbientPP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsambientpp_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  4  18  18  18  18  18  18  18  18  18  18 };
			prop_format = settingsambientpp_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsAmbientPP, POINTER) returns description of POINTER of SettingsAmbientPP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SettingsAmbientPP, POINTER) returns description of POINTER of SettingsAmbientPP.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAmbientPP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingsambientpp_description_list = { 'ELCLASS (constant, string) is the class of the concrete element.'  'NAME (constant, string) is the name of the prop panel for ambient settings.'  'DESCRIPTION (constant, string) is the description of the prop panel for ambient settings.'  'TEMPLATE (parameter, item) is the template of the prop panel for ambient settings.'  'ID (data, string) is a few-letter code for the prop panel for ambient settings.'  'LABEL (metadata, string) is an extended label of the prop panel for ambient settings.'  'NOTES (metadata, string) are some specific notes about the prop panel for ambient settings.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the settings position panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.'  'LABEL_LIGHTING (evanescent, handle) is the label of the lighting dropdown menu.'  'DROPDOWN_LIGHTING (evanescent, handle) is the lighting dropdown menu.'  'LABEL_MATERIAL (evanescent, handle) is the label of the of the material dropdown menu.'  'DROPDOWN_MATERIAL (evanescent, handle) is the material dropdown menu.'  'LABEL_CAMLIGHT (evanescent, handle) is the label of the camlight dropdown menu.'  'DROPDOWN_CAMLIGHT (evanescent, handle) is the camlight dropdown menu.'  'LABEL_SHADING (evanescent, handle) is the label of the shading dropdown menu.'  'DROPDOWN_SHADING (evanescent, handle) is the shading dropdown menu.'  'LABEL_COLORMAP (evanescent, handle) is the label of the colormap dropdown menu.'  'DROPDOWN_COLORMAP (evanescent, handle) is the colormap dropdown menu.' };
			prop_description = settingsambientpp_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsAmbientPP, POINTER) returns settings of POINTER of SettingsAmbientPP.
			%  SETTINGS = PR.GETPROPSETTINGS(SettingsAmbientPP, POINTER) returns settings of POINTER of SettingsAmbientPP.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAmbientPP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % SettingsAmbientPP.ENABLE
					prop_settings = Format.getFormatSettings(4);
				case 37 % SettingsAmbientPP.LABEL_LIGHTING
					prop_settings = Format.getFormatSettings(18);
				case 38 % SettingsAmbientPP.DROPDOWN_LIGHTING
					prop_settings = Format.getFormatSettings(18);
				case 39 % SettingsAmbientPP.LABEL_MATERIAL
					prop_settings = Format.getFormatSettings(18);
				case 40 % SettingsAmbientPP.DROPDOWN_MATERIAL
					prop_settings = Format.getFormatSettings(18);
				case 41 % SettingsAmbientPP.LABEL_CAMLIGHT
					prop_settings = Format.getFormatSettings(18);
				case 42 % SettingsAmbientPP.DROPDOWN_CAMLIGHT
					prop_settings = Format.getFormatSettings(18);
				case 43 % SettingsAmbientPP.LABEL_SHADING
					prop_settings = Format.getFormatSettings(18);
				case 44 % SettingsAmbientPP.DROPDOWN_SHADING
					prop_settings = Format.getFormatSettings(18);
				case 45 % SettingsAmbientPP.LABEL_COLORMAP
					prop_settings = Format.getFormatSettings(18);
				case 46 % SettingsAmbientPP.DROPDOWN_COLORMAP
					prop_settings = Format.getFormatSettings(18);
				case 4 % SettingsAmbientPP.TEMPLATE
					prop_settings = 'SettingsAmbientPP';
				otherwise
					prop_settings = getPropSettings@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsAmbientPP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAmbientPP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsAmbientPP, POINTER) returns the default value of POINTER of SettingsAmbientPP.
			%  DEFAULT = PR.GETPROPDEFAULT(SettingsAmbientPP, POINTER) returns the default value of POINTER of SettingsAmbientPP.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsAmbientPP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % SettingsAmbientPP.ENABLE
					prop_default = true;
				case 37 % SettingsAmbientPP.LABEL_LIGHTING
					prop_default = Format.getFormatDefault(18, SettingsAmbientPP.getPropSettings(prop));
				case 38 % SettingsAmbientPP.DROPDOWN_LIGHTING
					prop_default = Format.getFormatDefault(18, SettingsAmbientPP.getPropSettings(prop));
				case 39 % SettingsAmbientPP.LABEL_MATERIAL
					prop_default = Format.getFormatDefault(18, SettingsAmbientPP.getPropSettings(prop));
				case 40 % SettingsAmbientPP.DROPDOWN_MATERIAL
					prop_default = Format.getFormatDefault(18, SettingsAmbientPP.getPropSettings(prop));
				case 41 % SettingsAmbientPP.LABEL_CAMLIGHT
					prop_default = Format.getFormatDefault(18, SettingsAmbientPP.getPropSettings(prop));
				case 42 % SettingsAmbientPP.DROPDOWN_CAMLIGHT
					prop_default = Format.getFormatDefault(18, SettingsAmbientPP.getPropSettings(prop));
				case 43 % SettingsAmbientPP.LABEL_SHADING
					prop_default = Format.getFormatDefault(18, SettingsAmbientPP.getPropSettings(prop));
				case 44 % SettingsAmbientPP.DROPDOWN_SHADING
					prop_default = Format.getFormatDefault(18, SettingsAmbientPP.getPropSettings(prop));
				case 45 % SettingsAmbientPP.LABEL_COLORMAP
					prop_default = Format.getFormatDefault(18, SettingsAmbientPP.getPropSettings(prop));
				case 46 % SettingsAmbientPP.DROPDOWN_COLORMAP
					prop_default = Format.getFormatDefault(18, SettingsAmbientPP.getPropSettings(prop));
				case 1 % SettingsAmbientPP.ELCLASS
					prop_default = 'SettingsAmbientPP';
				case 2 % SettingsAmbientPP.NAME
					prop_default = 'Prop Panel for Ambient Settings';
				case 3 % SettingsAmbientPP.DESCRIPTION
					prop_default = 'A Prop Panel for Ambient Settings (SettingsAmbientPP) plots the panel for ambient settings, including drop-down lists for lighting, material, camlight, shading, and colormap. It works for all categories.';
				case 4 % SettingsAmbientPP.TEMPLATE
					prop_default = Format.getFormatDefault(8, SettingsAmbientPP.getPropSettings(prop));
				case 5 % SettingsAmbientPP.ID
					prop_default = 'SettingsAmbientPP ID';
				case 6 % SettingsAmbientPP.LABEL
					prop_default = 'SettingsAmbientPP label';
				case 7 % SettingsAmbientPP.NOTES
					prop_default = 'SettingsAmbientPP notes';
				case 23 % SettingsAmbientPP.EL
					prop_default = BrainSurfacePF();
				case 24 % SettingsAmbientPP.PROP
					prop_default = 32;
				case 25 % SettingsAmbientPP.HEIGHT
					prop_default = 150;
				otherwise
					prop_default = getPropDefault@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsAmbientPP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAmbientPP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsAmbientPP, POINTER) returns the conditioned default value of POINTER of SettingsAmbientPP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SettingsAmbientPP, POINTER) returns the conditioned default value of POINTER of SettingsAmbientPP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsAmbientPP.getPropProp(pointer);
			
			prop_default = SettingsAmbientPP.conditioning(prop, SettingsAmbientPP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsAmbientPP, PROP, VALUE) checks VALUE format for PROP of SettingsAmbientPP.
			%  CHECK = PR.CHECKPROP(SettingsAmbientPP, PROP, VALUE) checks VALUE format for PROP of SettingsAmbientPP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SettingsAmbientPP:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:SettingsAmbientPP:WrongInput
			%  Element.CHECKPROP(SettingsAmbientPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAmbientPP.
			%   Error id: BRAPH2:SettingsAmbientPP:WrongInput
			%  PR.CHECKPROP(SettingsAmbientPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAmbientPP.
			%   Error id: BRAPH2:SettingsAmbientPP:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsAmbientPP.getPropProp(pointer);
			
			switch prop
				case 36 % SettingsAmbientPP.ENABLE
					check = Format.checkFormat(4, value, SettingsAmbientPP.getPropSettings(prop));
				case 37 % SettingsAmbientPP.LABEL_LIGHTING
					check = Format.checkFormat(18, value, SettingsAmbientPP.getPropSettings(prop));
				case 38 % SettingsAmbientPP.DROPDOWN_LIGHTING
					check = Format.checkFormat(18, value, SettingsAmbientPP.getPropSettings(prop));
				case 39 % SettingsAmbientPP.LABEL_MATERIAL
					check = Format.checkFormat(18, value, SettingsAmbientPP.getPropSettings(prop));
				case 40 % SettingsAmbientPP.DROPDOWN_MATERIAL
					check = Format.checkFormat(18, value, SettingsAmbientPP.getPropSettings(prop));
				case 41 % SettingsAmbientPP.LABEL_CAMLIGHT
					check = Format.checkFormat(18, value, SettingsAmbientPP.getPropSettings(prop));
				case 42 % SettingsAmbientPP.DROPDOWN_CAMLIGHT
					check = Format.checkFormat(18, value, SettingsAmbientPP.getPropSettings(prop));
				case 43 % SettingsAmbientPP.LABEL_SHADING
					check = Format.checkFormat(18, value, SettingsAmbientPP.getPropSettings(prop));
				case 44 % SettingsAmbientPP.DROPDOWN_SHADING
					check = Format.checkFormat(18, value, SettingsAmbientPP.getPropSettings(prop));
				case 45 % SettingsAmbientPP.LABEL_COLORMAP
					check = Format.checkFormat(18, value, SettingsAmbientPP.getPropSettings(prop));
				case 46 % SettingsAmbientPP.DROPDOWN_COLORMAP
					check = Format.checkFormat(18, value, SettingsAmbientPP.getPropSettings(prop));
				case 4 % SettingsAmbientPP.TEMPLATE
					check = Format.checkFormat(8, value, SettingsAmbientPP.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@SettingsPP(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsAmbientPP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsAmbientPP:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsAmbientPP.getPropTag(prop) ' (' SettingsAmbientPP.getFormatTag(SettingsAmbientPP.getPropFormat(prop)) ').'] ...
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
				case 37 % SettingsAmbientPP.LABEL_LIGHTING
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_lighting =  uilabel( ...
					    'Parent', pr.memorize('H'), ...
						'Tag', 'LABEL_LIGHTING', ...
						'Text', 'lighting', ...
						'Interpreter', 'html', ...
						'FontSize', 12, ...
						'HorizontalAlignment', 'right', ...
						'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LIGHTING')) ' ' el.get(prop).getPropDescription('LIGHTING')], ...
						'BackgroundColor', pr.get('BKGCOLOR') ...
						);
					value = label_lighting;
					
				case 38 % SettingsAmbientPP.DROPDOWN_LIGHTING
					el = pr.get('EL');
					prop = pr.get('PROP');
					dropdown_lighting = uidropdown( ...
					    'Parent', pr.memorize('H'), ...
						'Tag', 'DROPDOWN_LIGHTING', ...
						'Items', el.get(prop).getPropSettings('LIGHTING'), ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LIGHTING')) ' ' el.get(prop).getPropDescription('LIGHTING')], ...
					    'ValueChangedFcn', {@cb_ambient} ...
					    );
					value = dropdown_lighting;
					
				case 39 % SettingsAmbientPP.LABEL_MATERIAL
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_material =  uilabel( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'LABEL_MATERIAL', ...
					    'Text', 'material', ...
					    'Interpreter', 'html', ...
					    'FontSize', 12, ...
					    'HorizontalAlignment', 'right', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('MATERIAL')) ' ' el.get(prop).getPropDescription('MATERIAL')], ...
					    'BackgroundColor', pr.get('BKGCOLOR') ...
					    );
					value = label_material;
					
				case 40 % SettingsAmbientPP.DROPDOWN_MATERIAL
					el = pr.get('EL');
					prop = pr.get('PROP');
					dropdown_material = uidropdown( ...
					    'Parent', pr.memorize('H'), ...
					        'Tag', 'DROPDOWN_MATERIAL', ...
					        'Items', el.get(prop).getPropSettings('MATERIAL'), ...
					        'FontSize', 12, ...
					        'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('MATERIAL')) ' ' el.get(prop).getPropDescription('MATERIAL')], ...
					        'ValueChangedFcn', {@cb_ambient} ... % callback in DROPBOX_LIGHTING
					        );
					value = dropdown_material;
					
				case 41 % SettingsAmbientPP.LABEL_CAMLIGHT
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_camlight =  uilabel( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'LABEL_CAMLIGHT', ...
					    'Text', 'camera light', ...
					    'Interpreter', 'html', ...
					    'FontSize', 12, ...
					    'HorizontalAlignment', 'right', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('CAMLIGHT')) ' ' el.get(prop).getPropDescription('CAMLIGHT')], ...
					    'BackgroundColor', pr.get('BKGCOLOR') ...
					    );
					value = label_camlight;
					
				case 42 % SettingsAmbientPP.DROPDOWN_CAMLIGHT
					el = pr.get('EL');
					prop = pr.get('PROP');
					dropdown_camlight = uidropdown( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'DROPDOWN_CAMLIGHT', ...
					    'Items', el.get(prop).getPropSettings('CAMLIGHT'), ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('CAMLIGHT')) ' ' el.get(prop).getPropDescription('CAMLIGHT')], ...
					    'ValueChangedFcn', {@cb_ambient} ... % callback in DROPBOX_LIGHTING
					    );
					value = dropdown_camlight;
					
				case 43 % SettingsAmbientPP.LABEL_SHADING
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_shading =  uilabel( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'LABEL_SHADING', ...
					    'Text', 'shading', ...
					    'Interpreter', 'html', ...
					    'FontSize', 12, ...
					    'HorizontalAlignment', 'right', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('SHADING')) ' ' el.get(prop).getPropDescription('SHADING')], ...
					    'BackgroundColor', pr.get('BKGCOLOR') ...
					    );
					value = label_shading;
					
				case 44 % SettingsAmbientPP.DROPDOWN_SHADING
					el = pr.get('EL');
					prop = pr.get('PROP');
					dropdown_shading = uidropdown( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'DROPDOWN_SHADING', ...
					    'Items', el.get(prop).getPropSettings('SHADING'), ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('SHADING')) ' ' el.get(prop).getPropDescription('SHADING')], ...
					    'ValueChangedFcn', {@cb_ambient} ... % callback in DROPBOX_LIGHTING
					    );
					value = dropdown_shading;
					
				case 45 % SettingsAmbientPP.LABEL_COLORMAP
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_colormap =  uilabel( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'LABEL_COLORMAP', ...
					    'Text', 'colormap', ...
					    'Interpreter', 'html', ...
					    'FontSize', 12, ...
					    'HorizontalAlignment', 'right', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('COLORMAP')) ' ' el.get(prop).getPropDescription('COLORMAP')], ...
					    'BackgroundColor', pr.get('BKGCOLOR') ...
					    );
					value = label_colormap;
					
				case 46 % SettingsAmbientPP.DROPDOWN_COLORMAP
					el = pr.get('EL');
					prop = pr.get('PROP');
					dropdown_colormap = uidropdown( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'DROPDOWN_COLORMAP', ...
					    'Items', el.get(prop).getPropSettings('COLORMAP'), ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('COLORMAP')) ' ' el.get(prop).getPropDescription('COLORMAP')], ...
					    'ValueChangedFcn', {@cb_ambient} ... % callback in DROPBOX_LIGHTING
					    );
					value = dropdown_colormap;
					
				case 20 % SettingsAmbientPP.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('LABEL_LIGHTING')
					    pr.memorize('DROPDOWN_LIGHTING')
					
					    pr.memorize('LABEL_MATERIAL')
					    pr.memorize('DROPDOWN_MATERIAL')
					
					    pr.memorize('LABEL_CAMLIGHT')
					    pr.memorize('DROPDOWN_CAMLIGHT')
					
					    pr.memorize('LABEL_SHADING')
					    pr.memorize('DROPDOWN_SHADING')
					
					    pr.memorize('LABEL_COLORMAP')
					    pr.memorize('DROPDOWN_COLORMAP')
					end
					
				case 21 % SettingsAmbientPP.UPDATE
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value
					
						el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if el.isLocked(prop)
					        set(pr.get('DROPDOWN_LIGHTING'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('DROPDOWN_MATERIAL'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('DROPDOWN_CAMLIGHT'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('DROPDOWN_SHADING'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('DROPDOWN_COLORMAP'), 'Enable', pr.get('ENABLE'))
					    end
					
					    switch el.getPropCategory(prop)
					        case 2
					            set(pr.get('DROPDOWN_LIGHTING'), 'Value', el.get(prop).get('LIGHTING'))
					            set(pr.get('DROPDOWN_MATERIAL'), 'Value', el.get(prop).get('MATERIAL'))
					            set(pr.get('DROPDOWN_CAMLIGHT'), 'Value', el.get(prop).get('CAMLIGHT'))
					            set(pr.get('DROPDOWN_SHADING'), 'Value', el.get(prop).get('SHADING'))
					            set(pr.get('DROPDOWN_COLORMAP'), 'Value', el.get(prop).get('COLORMAP'))
					
					        case {3, 4, 8, 9}
					            set(pr.get('DROPDOWN_LIGHTING'), 'Value', el.get(prop).get('LIGHTING'))
					            set(pr.get('DROPDOWN_MATERIAL'), 'Value', el.get(prop).get('MATERIAL'))
					            set(pr.get('DROPDOWN_CAMLIGHT'), 'Value', el.get(prop).get('CAMLIGHT'))
					            set(pr.get('DROPDOWN_SHADING'), 'Value', el.get(prop).get('SHADING'))
					            set(pr.get('DROPDOWN_COLORMAP'), 'Value', el.get(prop).get('COLORMAP'))
					
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('LIGHTING'), 'Callback')
					                set(pr.get('DROPDOWN_LIGHTING'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('MATERIAL'), 'Callback')
					                set(pr.get('DROPDOWN_MATERIAL'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('CAMLIGHT'), 'Callback')
					                set(pr.get('DROPDOWN_CAMLIGHT'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('SHADING'), 'Callback')
					                set(pr.get('DROPDOWN_SHADING'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('COLORMAP'), 'Callback')
					                set(pr.get('DROPDOWN_COLORMAP'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            
					        case 5
					            value = el.getr(prop);
					
					            if isa(value, 'NoValue')
					                set(pr.get('DROPDOWN_LIGHTING'), ...
					                    'Value', el.get(prop).getPropDefault('LIGHTING'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_MATERIAL'), ...
					                    'Value', el.get(prop).getPropDefault('MATERIAL'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_CAMLIGHT'), ...
					                    'Value', el.get(prop).getPropDefault('CAMLIGHT'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_SHADING'), ...
					                    'Value', el.get(prop).getPropDefault('SHADING'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_COLORMAP'), ...
					                    'Value', el.get(prop).getPropDefault('COLORMAP'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )                
					            else
					                set(pr.get('DROPDOWN_LIGHTING'), ...
					                    'Value', el.get(prop).get('LIGHTING'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_MATERIAL'), ...
					                    'Value', el.get(prop).get('MATERIAL'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_CAMLIGHT'), ...
					                    'Value', el.get(prop).get('CAMLIGHT'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_SHADING'), ...
					                    'Value', el.get(prop).get('SHADING'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_COLORMAP'), ...
					                    'Value', el.get(prop).get('COLORMAP'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )                
					            end
					    end
					end
					
				case 22 % SettingsAmbientPP.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('LABEL_LIGHTING'), 'Position', [4 100 96 21])
					    set(pr.get('DROPDOWN_LIGHTING'), 'Position', [104 100 w_p-120 21])
					
					    set(pr.get('LABEL_MATERIAL'), 'Position', [4 76 96 21])
					    set(pr.get('DROPDOWN_MATERIAL'), 'Position', [104 76 w_p-120 21])
					
					    set(pr.get('LABEL_CAMLIGHT'), 'Position', [4 52 96 21])
					    set(pr.get('DROPDOWN_CAMLIGHT'), 'Position', [104 52 w_p-120 21])
					
					    set(pr.get('LABEL_SHADING'), 'Position', [4 28 96 21])
					    set(pr.get('DROPDOWN_SHADING'), 'Position', [104 28 w_p-120 21])
					
					    set(pr.get('LABEL_COLORMAP'), 'Position', [4 4 96 21])
					    set(pr.get('DROPDOWN_COLORMAP'), 'Position', [104 4 w_p-120 21])
					end
					
				case 18 % SettingsAmbientPP.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('LABEL_LIGHTING', Element.getNoValue())
					    pr.set('DROPDOWN_LIGHTING', Element.getNoValue())
					
					    pr.set('LABEL_MATERIAL', Element.getNoValue())
					    pr.set('DROPDOWN_MATERIAL', Element.getNoValue())
					
					    pr.set('LABEL_CAMLIGHT', Element.getNoValue())
					    pr.set('DROPDOWN_CAMLIGHT', Element.getNoValue())
					
					    pr.set('LABEL_SHADING', Element.getNoValue())
					    pr.set('DROPDOWN_SHADING', Element.getNoValue())
					
					    pr.set('LABEL_COLORMAP', Element.getNoValue())
					    pr.set('DROPDOWN_COLORMAP', Element.getNoValue())
					end
					
				otherwise
					if prop <= 35
						value = calculateValue@SettingsPP(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_ambient(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    el.get(prop).set( ...
			        'LIGHTING', get(pr.get('DROPDOWN_LIGHTING'), 'Value'), ...
			        'MATERIAL', get(pr.get('DROPDOWN_MATERIAL'), 'Value'), ...
			        'CAMLIGHT', get(pr.get('DROPDOWN_CAMLIGHT'), 'Value'), ...
			        'SHADING', get(pr.get('DROPDOWN_SHADING'), 'Value'), ...
			        'COLORMAP', get(pr.get('DROPDOWN_COLORMAP'), 'Value') ...
			        )
			end
		end
	end
end
