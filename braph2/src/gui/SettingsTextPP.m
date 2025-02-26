classdef SettingsTextPP < SettingsPP
	%SettingsTextPP is the panel with text settings.
	% It is a subclass of <a href="matlab:help SettingsPP">SettingsPP</a>.
	%
	% A Prop Panel for Text Settings (SettingsTextPP) plots the panel 
	%  for text settings, including text, x, y, and z position, 
	%  font color, size, rotation and weight, 
	%  interpreter, horizontal and vertical alignment.
	% It works for all categories.
	%
	% The list of SettingsTextPP properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the prop panel for text settings.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the prop panel for text settings.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the prop panel for text settings.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the prop panel for text settings.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the prop panel for text settings.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the prop panel for text settings.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the prop panel for text settings.
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
	%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the property panel.
	%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
	%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
	%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
	%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the prop panel for text settings.
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
	%  <strong>37</strong> <strong>EDITFIELD_X</strong> 	EDITFIELD_X (evanescent, handle) is the text value edit field for the X property.
	%  <strong>38</strong> <strong>EDITFIELD_Y</strong> 	EDITFIELD_Y (evanescent, handle) is the text value edit field for the Y property.
	%  <strong>39</strong> <strong>EDITFIELD_Z</strong> 	EDITFIELD_Z (evanescent, handle) is the text value edit field for the Z property.
	%  <strong>40</strong> <strong>EDITFIELD_TXT</strong> 	EDITFIELD_TXT (evanescent, handle) is the text value edit field for the TXT property.
	%  <strong>41</strong> <strong>BUTTON_FONTCOLOR</strong> 	BUTTON_FONTCOLOR (evanescent, handle) is the text color button.
	%  <strong>42</strong> <strong>EDITFIELD_FONTSIZE</strong> 	EDITFIELD_FONTSIZE (evanescent, handle) is the font size edit field.
	%  <strong>43</strong> <strong>SLIDER_FONTSIZE</strong> 	SLIDER_FONTSIZE (evanescent, handle) is the font size slider.
	%  <strong>44</strong> <strong>EDITFIELD_ROTATION</strong> 	EDITFIELD_ROTATION (evanescent, handle) is the rotation edit field.
	%  <strong>45</strong> <strong>SLIDER_ROTATION</strong> 	SLIDER_ROTATION (evanescent, handle) is the rotation slider.
	%  <strong>46</strong> <strong>EDITFIELD_FONTNAME</strong> 	EDITFIELD_FONTNAME (evanescent, handle) is the text value edit field for the FONTNAME property.
	%  <strong>47</strong> <strong>DROPDOWN_FONTWEIGHT</strong> 	DROPDOWN_FONTWEIGHT (evanescent, handle) is the font weight dropdown.
	%  <strong>48</strong> <strong>DROPDOWN_INTERPRETER</strong> 	DROPDOWN_INTERPRETER (evanescent, handle) is the interpreter dropdown.
	%  <strong>49</strong> <strong>DROPDOWN_HALIGN</strong> 	DROPDOWN_HALIGN (evanescent, handle) is the horizontal alignment dropdown.
	%  <strong>50</strong> <strong>DROPDOWN_VALIGN</strong> 	DROPDOWN_VALIGN (evanescent, handle) is the vertical alignment dropdown.
	%
	% SettingsTextPP methods (constructor):
	%  SettingsTextPP - constructor
	%
	% SettingsTextPP methods:
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
	% SettingsTextPP methods (display):
	%  tostring - string with information about the prop panel for text settings
	%  disp - displays information about the prop panel for text settings
	%  tree - displays the tree of the prop panel for text settings
	%
	% SettingsTextPP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel for text settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel for text settings
	%
	% SettingsTextPP methods (save/load, Static):
	%  save - saves BRAPH2 prop panel for text settings as b2 file
	%  load - loads a BRAPH2 prop panel for text settings from a b2 file
	%
	% SettingsTextPP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel for text settings
	%
	% SettingsTextPP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel for text settings
	%
	% SettingsTextPP methods (inspection, Static):
	%  getClass - returns the class of the prop panel for text settings
	%  getSubclasses - returns all subclasses of SettingsTextPP
	%  getProps - returns the property list of the prop panel for text settings
	%  getPropNumber - returns the property number of the prop panel for text settings
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
	% SettingsTextPP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsTextPP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsTextPP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsTextPP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsTextPP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsTextPP constants</a>.
	%
	%
	% See also SettingsText, uieditfield, uipushbutton, uislider.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		ENABLE = 36; %CET: Computational Efficiency Trick
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = 9;
		ENABLE_FORMAT = 4;
		
		EDITFIELD_X = 37; %CET: Computational Efficiency Trick
		EDITFIELD_X_TAG = 'EDITFIELD_X';
		EDITFIELD_X_CATEGORY = 7;
		EDITFIELD_X_FORMAT = 18;
		
		EDITFIELD_Y = 38; %CET: Computational Efficiency Trick
		EDITFIELD_Y_TAG = 'EDITFIELD_Y';
		EDITFIELD_Y_CATEGORY = 7;
		EDITFIELD_Y_FORMAT = 18;
		
		EDITFIELD_Z = 39; %CET: Computational Efficiency Trick
		EDITFIELD_Z_TAG = 'EDITFIELD_Z';
		EDITFIELD_Z_CATEGORY = 7;
		EDITFIELD_Z_FORMAT = 18;
		
		EDITFIELD_TXT = 40; %CET: Computational Efficiency Trick
		EDITFIELD_TXT_TAG = 'EDITFIELD_TXT';
		EDITFIELD_TXT_CATEGORY = 7;
		EDITFIELD_TXT_FORMAT = 18;
		
		BUTTON_FONTCOLOR = 41; %CET: Computational Efficiency Trick
		BUTTON_FONTCOLOR_TAG = 'BUTTON_FONTCOLOR';
		BUTTON_FONTCOLOR_CATEGORY = 7;
		BUTTON_FONTCOLOR_FORMAT = 18;
		
		EDITFIELD_FONTSIZE = 42; %CET: Computational Efficiency Trick
		EDITFIELD_FONTSIZE_TAG = 'EDITFIELD_FONTSIZE';
		EDITFIELD_FONTSIZE_CATEGORY = 7;
		EDITFIELD_FONTSIZE_FORMAT = 18;
		
		SLIDER_FONTSIZE = 43; %CET: Computational Efficiency Trick
		SLIDER_FONTSIZE_TAG = 'SLIDER_FONTSIZE';
		SLIDER_FONTSIZE_CATEGORY = 7;
		SLIDER_FONTSIZE_FORMAT = 18;
		
		EDITFIELD_ROTATION = 44; %CET: Computational Efficiency Trick
		EDITFIELD_ROTATION_TAG = 'EDITFIELD_ROTATION';
		EDITFIELD_ROTATION_CATEGORY = 7;
		EDITFIELD_ROTATION_FORMAT = 18;
		
		SLIDER_ROTATION = 45; %CET: Computational Efficiency Trick
		SLIDER_ROTATION_TAG = 'SLIDER_ROTATION';
		SLIDER_ROTATION_CATEGORY = 7;
		SLIDER_ROTATION_FORMAT = 18;
		
		EDITFIELD_FONTNAME = 46; %CET: Computational Efficiency Trick
		EDITFIELD_FONTNAME_TAG = 'EDITFIELD_FONTNAME';
		EDITFIELD_FONTNAME_CATEGORY = 7;
		EDITFIELD_FONTNAME_FORMAT = 18;
		
		DROPDOWN_FONTWEIGHT = 47; %CET: Computational Efficiency Trick
		DROPDOWN_FONTWEIGHT_TAG = 'DROPDOWN_FONTWEIGHT';
		DROPDOWN_FONTWEIGHT_CATEGORY = 7;
		DROPDOWN_FONTWEIGHT_FORMAT = 18;
		
		DROPDOWN_INTERPRETER = 48; %CET: Computational Efficiency Trick
		DROPDOWN_INTERPRETER_TAG = 'DROPDOWN_INTERPRETER';
		DROPDOWN_INTERPRETER_CATEGORY = 7;
		DROPDOWN_INTERPRETER_FORMAT = 18;
		
		DROPDOWN_HALIGN = 49; %CET: Computational Efficiency Trick
		DROPDOWN_HALIGN_TAG = 'DROPDOWN_HALIGN';
		DROPDOWN_HALIGN_CATEGORY = 7;
		DROPDOWN_HALIGN_FORMAT = 18;
		
		DROPDOWN_VALIGN = 50; %CET: Computational Efficiency Trick
		DROPDOWN_VALIGN_TAG = 'DROPDOWN_VALIGN';
		DROPDOWN_VALIGN_CATEGORY = 7;
		DROPDOWN_VALIGN_FORMAT = 18;
	end
	methods % constructor
		function pr = SettingsTextPP(varargin)
			%SettingsTextPP() creates a prop panel for text settings.
			%
			% SettingsTextPP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsTextPP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SettingsTextPP properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the prop panel for text settings.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the prop panel for text settings.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the prop panel for text settings.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the prop panel for text settings.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the prop panel for text settings.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the prop panel for text settings.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the prop panel for text settings.
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
			%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the property panel.
			%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
			%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
			%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
			%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the prop panel for text settings.
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
			%  <strong>37</strong> <strong>EDITFIELD_X</strong> 	EDITFIELD_X (evanescent, handle) is the text value edit field for the X property.
			%  <strong>38</strong> <strong>EDITFIELD_Y</strong> 	EDITFIELD_Y (evanescent, handle) is the text value edit field for the Y property.
			%  <strong>39</strong> <strong>EDITFIELD_Z</strong> 	EDITFIELD_Z (evanescent, handle) is the text value edit field for the Z property.
			%  <strong>40</strong> <strong>EDITFIELD_TXT</strong> 	EDITFIELD_TXT (evanescent, handle) is the text value edit field for the TXT property.
			%  <strong>41</strong> <strong>BUTTON_FONTCOLOR</strong> 	BUTTON_FONTCOLOR (evanescent, handle) is the text color button.
			%  <strong>42</strong> <strong>EDITFIELD_FONTSIZE</strong> 	EDITFIELD_FONTSIZE (evanescent, handle) is the font size edit field.
			%  <strong>43</strong> <strong>SLIDER_FONTSIZE</strong> 	SLIDER_FONTSIZE (evanescent, handle) is the font size slider.
			%  <strong>44</strong> <strong>EDITFIELD_ROTATION</strong> 	EDITFIELD_ROTATION (evanescent, handle) is the rotation edit field.
			%  <strong>45</strong> <strong>SLIDER_ROTATION</strong> 	SLIDER_ROTATION (evanescent, handle) is the rotation slider.
			%  <strong>46</strong> <strong>EDITFIELD_FONTNAME</strong> 	EDITFIELD_FONTNAME (evanescent, handle) is the text value edit field for the FONTNAME property.
			%  <strong>47</strong> <strong>DROPDOWN_FONTWEIGHT</strong> 	DROPDOWN_FONTWEIGHT (evanescent, handle) is the font weight dropdown.
			%  <strong>48</strong> <strong>DROPDOWN_INTERPRETER</strong> 	DROPDOWN_INTERPRETER (evanescent, handle) is the interpreter dropdown.
			%  <strong>49</strong> <strong>DROPDOWN_HALIGN</strong> 	DROPDOWN_HALIGN (evanescent, handle) is the horizontal alignment dropdown.
			%  <strong>50</strong> <strong>DROPDOWN_VALIGN</strong> 	DROPDOWN_VALIGN (evanescent, handle) is the vertical alignment dropdown.
			%
			% See also Category, Format.
			
			pr = pr@SettingsPP(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the prop panel for text settings.
			%
			% BUILD = SettingsTextPP.GETBUILD() returns the build of 'SettingsTextPP'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the prop panel for text settings PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('SettingsTextPP') returns the build of 'SettingsTextPP'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('SettingsTextPP')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the prop panel for text settings.
			%
			% CLASS = SettingsTextPP.GETCLASS() returns the class 'SettingsTextPP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel for text settings PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SettingsTextPP') returns 'SettingsTextPP'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SettingsTextPP')
			%  are less computationally efficient.
			
			pr_class = 'SettingsTextPP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel for text settings.
			%
			% LIST = SettingsTextPP.GETSUBCLASSES() returns all subclasses of 'SettingsTextPP'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel for text settings PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SettingsTextPP') returns all subclasses of 'SettingsTextPP'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SettingsTextPP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel for text settings.
			%
			% PROPS = SettingsTextPP.GETPROPS() returns the property list of prop panel for text settings
			%  as a row vector.
			%
			% PROPS = SettingsTextPP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel for text settings PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SettingsTextPP'[, CATEGORY]) returns the property list of 'SettingsTextPP'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50];
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
					prop_list = [10 15 27 28 30 31 32 33 34 35 37 38 39 40 41 42 43 44 45 46 47 48 49 50];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel for text settings.
			%
			% N = SettingsTextPP.GETPROPNUMBER() returns the property number of prop panel for text settings.
			%
			% N = SettingsTextPP.GETPROPNUMBER(CATEGORY) returns the property number of prop panel for text settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel for text settings PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SettingsTextPP') returns the property number of 'SettingsTextPP'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 50;
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
					prop_number = 24;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 5;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel for text settings/error.
			%
			% CHECK = SettingsTextPP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SettingsTextPP, PROP) checks whether PROP exists for SettingsTextPP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsTextPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsTextPP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsTextPP:WrongInput]
			%  Element.EXISTSPROP(SettingsTextPP, PROP) throws error if PROP does NOT exist for SettingsTextPP.
			%   Error id: [BRAPH2:SettingsTextPP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 50 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsTextPP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsTextPP:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsTextPP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel for text settings/error.
			%
			% CHECK = SettingsTextPP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SettingsTextPP, TAG) checks whether TAG exists for SettingsTextPP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsTextPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsTextPP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsTextPP:WrongInput]
			%  Element.EXISTSTAG(SettingsTextPP, TAG) throws error if TAG does NOT exist for SettingsTextPP.
			%   Error id: [BRAPH2:SettingsTextPP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'EDITFIELD_X'  'EDITFIELD_Y'  'EDITFIELD_Z'  'EDITFIELD_TXT'  'BUTTON_FONTCOLOR'  'EDITFIELD_FONTSIZE'  'SLIDER_FONTSIZE'  'EDITFIELD_ROTATION'  'SLIDER_ROTATION'  'EDITFIELD_FONTNAME'  'DROPDOWN_FONTWEIGHT'  'DROPDOWN_INTERPRETER'  'DROPDOWN_HALIGN'  'DROPDOWN_VALIGN' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsTextPP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsTextPP:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SettingsTextPP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsTextPP, POINTER) returns property number of POINTER of SettingsTextPP.
			%  PROPERTY = PR.GETPROPPROP(SettingsTextPP, POINTER) returns property number of POINTER of SettingsTextPP.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'EDITFIELD_X'  'EDITFIELD_Y'  'EDITFIELD_Z'  'EDITFIELD_TXT'  'BUTTON_FONTCOLOR'  'EDITFIELD_FONTSIZE'  'SLIDER_FONTSIZE'  'EDITFIELD_ROTATION'  'SLIDER_ROTATION'  'EDITFIELD_FONTNAME'  'DROPDOWN_FONTWEIGHT'  'DROPDOWN_INTERPRETER'  'DROPDOWN_HALIGN'  'DROPDOWN_VALIGN' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(SettingsTextPP, POINTER) returns tag of POINTER of SettingsTextPP.
			%  TAG = PR.GETPROPTAG(SettingsTextPP, POINTER) returns tag of POINTER of SettingsTextPP.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				settingstextpp_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'EDITFIELD_X'  'EDITFIELD_Y'  'EDITFIELD_Z'  'EDITFIELD_TXT'  'BUTTON_FONTCOLOR'  'EDITFIELD_FONTSIZE'  'SLIDER_FONTSIZE'  'EDITFIELD_ROTATION'  'SLIDER_ROTATION'  'EDITFIELD_FONTNAME'  'DROPDOWN_FONTWEIGHT'  'DROPDOWN_INTERPRETER'  'DROPDOWN_HALIGN'  'DROPDOWN_VALIGN' };
				tag = settingstextpp_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsTextPP, POINTER) returns category of POINTER of SettingsTextPP.
			%  CATEGORY = PR.GETPROPCATEGORY(SettingsTextPP, POINTER) returns category of POINTER of SettingsTextPP.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsTextPP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingstextpp_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  7  7  7  7  7  7  7  7  7  7  7  7  7  7 };
			prop_category = settingstextpp_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsTextPP, POINTER) returns format of POINTER of SettingsTextPP.
			%  FORMAT = PR.GETPROPFORMAT(SettingsTextPP, POINTER) returns format of POINTER of SettingsTextPP.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsTextPP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingstextpp_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  4  18  18  18  18  18  18  18  18  18  18  18  18  18  18 };
			prop_format = settingstextpp_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsTextPP, POINTER) returns description of POINTER of SettingsTextPP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SettingsTextPP, POINTER) returns description of POINTER of SettingsTextPP.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsTextPP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			settingstextpp_description_list = { 'ELCLASS (constant, string) is the class of the prop panel for text settings.'  'NAME (constant, string) is the name of the prop panel for text settings.'  'DESCRIPTION (constant, string) is the description of the prop panel for text settings.'  'TEMPLATE (parameter, item) is the template of the prop panel for text settings.'  'ID (data, string) is a few-letter code for the prop panel for text settings.'  'LABEL (metadata, string) is an extended label of the prop panel for text settings.'  'NOTES (metadata, string) are some specific notes about the prop panel for text settings.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the property panel.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the prop panel for text settings.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.'  'EDITFIELD_X (evanescent, handle) is the text value edit field for the X property.'  'EDITFIELD_Y (evanescent, handle) is the text value edit field for the Y property.'  'EDITFIELD_Z (evanescent, handle) is the text value edit field for the Z property.'  'EDITFIELD_TXT (evanescent, handle) is the text value edit field for the TXT property.'  'BUTTON_FONTCOLOR (evanescent, handle) is the text color button.'  'EDITFIELD_FONTSIZE (evanescent, handle) is the font size edit field.'  'SLIDER_FONTSIZE (evanescent, handle) is the font size slider.'  'EDITFIELD_ROTATION (evanescent, handle) is the rotation edit field.'  'SLIDER_ROTATION (evanescent, handle) is the rotation slider.'  'EDITFIELD_FONTNAME (evanescent, handle) is the text value edit field for the FONTNAME property.'  'DROPDOWN_FONTWEIGHT (evanescent, handle) is the font weight dropdown.'  'DROPDOWN_INTERPRETER (evanescent, handle) is the interpreter dropdown.'  'DROPDOWN_HALIGN (evanescent, handle) is the horizontal alignment dropdown.'  'DROPDOWN_VALIGN (evanescent, handle) is the vertical alignment dropdown.' };
			prop_description = settingstextpp_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsTextPP, POINTER) returns settings of POINTER of SettingsTextPP.
			%  SETTINGS = PR.GETPROPSETTINGS(SettingsTextPP, POINTER) returns settings of POINTER of SettingsTextPP.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsTextPP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % SettingsTextPP.ENABLE
					prop_settings = Format.getFormatSettings(4);
				case 37 % SettingsTextPP.EDITFIELD_X
					prop_settings = Format.getFormatSettings(18);
				case 38 % SettingsTextPP.EDITFIELD_Y
					prop_settings = Format.getFormatSettings(18);
				case 39 % SettingsTextPP.EDITFIELD_Z
					prop_settings = Format.getFormatSettings(18);
				case 40 % SettingsTextPP.EDITFIELD_TXT
					prop_settings = Format.getFormatSettings(18);
				case 41 % SettingsTextPP.BUTTON_FONTCOLOR
					prop_settings = Format.getFormatSettings(18);
				case 42 % SettingsTextPP.EDITFIELD_FONTSIZE
					prop_settings = Format.getFormatSettings(18);
				case 43 % SettingsTextPP.SLIDER_FONTSIZE
					prop_settings = Format.getFormatSettings(18);
				case 44 % SettingsTextPP.EDITFIELD_ROTATION
					prop_settings = Format.getFormatSettings(18);
				case 45 % SettingsTextPP.SLIDER_ROTATION
					prop_settings = Format.getFormatSettings(18);
				case 46 % SettingsTextPP.EDITFIELD_FONTNAME
					prop_settings = Format.getFormatSettings(18);
				case 47 % SettingsTextPP.DROPDOWN_FONTWEIGHT
					prop_settings = Format.getFormatSettings(18);
				case 48 % SettingsTextPP.DROPDOWN_INTERPRETER
					prop_settings = Format.getFormatSettings(18);
				case 49 % SettingsTextPP.DROPDOWN_HALIGN
					prop_settings = Format.getFormatSettings(18);
				case 50 % SettingsTextPP.DROPDOWN_VALIGN
					prop_settings = Format.getFormatSettings(18);
				case 4 % SettingsTextPP.TEMPLATE
					prop_settings = 'SettingsTextPP';
				otherwise
					prop_settings = getPropSettings@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsTextPP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsTextPP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsTextPP, POINTER) returns the default value of POINTER of SettingsTextPP.
			%  DEFAULT = PR.GETPROPDEFAULT(SettingsTextPP, POINTER) returns the default value of POINTER of SettingsTextPP.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsTextPP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % SettingsTextPP.ENABLE
					prop_default = true;
				case 37 % SettingsTextPP.EDITFIELD_X
					prop_default = Format.getFormatDefault(18, SettingsTextPP.getPropSettings(prop));
				case 38 % SettingsTextPP.EDITFIELD_Y
					prop_default = Format.getFormatDefault(18, SettingsTextPP.getPropSettings(prop));
				case 39 % SettingsTextPP.EDITFIELD_Z
					prop_default = Format.getFormatDefault(18, SettingsTextPP.getPropSettings(prop));
				case 40 % SettingsTextPP.EDITFIELD_TXT
					prop_default = Format.getFormatDefault(18, SettingsTextPP.getPropSettings(prop));
				case 41 % SettingsTextPP.BUTTON_FONTCOLOR
					prop_default = Format.getFormatDefault(18, SettingsTextPP.getPropSettings(prop));
				case 42 % SettingsTextPP.EDITFIELD_FONTSIZE
					prop_default = Format.getFormatDefault(18, SettingsTextPP.getPropSettings(prop));
				case 43 % SettingsTextPP.SLIDER_FONTSIZE
					prop_default = Format.getFormatDefault(18, SettingsTextPP.getPropSettings(prop));
				case 44 % SettingsTextPP.EDITFIELD_ROTATION
					prop_default = Format.getFormatDefault(18, SettingsTextPP.getPropSettings(prop));
				case 45 % SettingsTextPP.SLIDER_ROTATION
					prop_default = Format.getFormatDefault(18, SettingsTextPP.getPropSettings(prop));
				case 46 % SettingsTextPP.EDITFIELD_FONTNAME
					prop_default = Format.getFormatDefault(18, SettingsTextPP.getPropSettings(prop));
				case 47 % SettingsTextPP.DROPDOWN_FONTWEIGHT
					prop_default = Format.getFormatDefault(18, SettingsTextPP.getPropSettings(prop));
				case 48 % SettingsTextPP.DROPDOWN_INTERPRETER
					prop_default = Format.getFormatDefault(18, SettingsTextPP.getPropSettings(prop));
				case 49 % SettingsTextPP.DROPDOWN_HALIGN
					prop_default = Format.getFormatDefault(18, SettingsTextPP.getPropSettings(prop));
				case 50 % SettingsTextPP.DROPDOWN_VALIGN
					prop_default = Format.getFormatDefault(18, SettingsTextPP.getPropSettings(prop));
				case 1 % SettingsTextPP.ELCLASS
					prop_default = 'SettingsTextPP';
				case 2 % SettingsTextPP.NAME
					prop_default = 'Prop Panel for Text Settings';
				case 3 % SettingsTextPP.DESCRIPTION
					prop_default = 'A Prop Panel for Text Settings (SettingsTextPP) plots the panel for text settings, including text, x, y, and z position, font color, size, rotation and weight, interpreter, horizontal and vertical alignment. It works for all categories.';
				case 4 % SettingsTextPP.TEMPLATE
					prop_default = Format.getFormatDefault(8, SettingsTextPP.getPropSettings(prop));
				case 5 % SettingsTextPP.ID
					prop_default = 'SettingsTextPP ID';
				case 6 % SettingsTextPP.LABEL
					prop_default = 'SettingsTextPP label';
				case 7 % SettingsTextPP.NOTES
					prop_default = 'SettingsTextPP notes';
				case 23 % SettingsTextPP.EL
					prop_default = MeasurePF();
				case 24 % SettingsTextPP.PROP
					prop_default = 35;
				case 25 % SettingsTextPP.HEIGHT
					prop_default = 111;
				otherwise
					prop_default = getPropDefault@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsTextPP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsTextPP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsTextPP, POINTER) returns the conditioned default value of POINTER of SettingsTextPP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SettingsTextPP, POINTER) returns the conditioned default value of POINTER of SettingsTextPP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsTextPP.getPropProp(pointer);
			
			prop_default = SettingsTextPP.conditioning(prop, SettingsTextPP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsTextPP, PROP, VALUE) checks VALUE format for PROP of SettingsTextPP.
			%  CHECK = PR.CHECKPROP(SettingsTextPP, PROP, VALUE) checks VALUE format for PROP of SettingsTextPP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SettingsTextPP:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:SettingsTextPP:WrongInput
			%  Element.CHECKPROP(SettingsTextPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsTextPP.
			%   Error id: BRAPH2:SettingsTextPP:WrongInput
			%  PR.CHECKPROP(SettingsTextPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsTextPP.
			%   Error id: BRAPH2:SettingsTextPP:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsTextPP.getPropProp(pointer);
			
			switch prop
				case 36 % SettingsTextPP.ENABLE
					check = Format.checkFormat(4, value, SettingsTextPP.getPropSettings(prop));
				case 37 % SettingsTextPP.EDITFIELD_X
					check = Format.checkFormat(18, value, SettingsTextPP.getPropSettings(prop));
				case 38 % SettingsTextPP.EDITFIELD_Y
					check = Format.checkFormat(18, value, SettingsTextPP.getPropSettings(prop));
				case 39 % SettingsTextPP.EDITFIELD_Z
					check = Format.checkFormat(18, value, SettingsTextPP.getPropSettings(prop));
				case 40 % SettingsTextPP.EDITFIELD_TXT
					check = Format.checkFormat(18, value, SettingsTextPP.getPropSettings(prop));
				case 41 % SettingsTextPP.BUTTON_FONTCOLOR
					check = Format.checkFormat(18, value, SettingsTextPP.getPropSettings(prop));
				case 42 % SettingsTextPP.EDITFIELD_FONTSIZE
					check = Format.checkFormat(18, value, SettingsTextPP.getPropSettings(prop));
				case 43 % SettingsTextPP.SLIDER_FONTSIZE
					check = Format.checkFormat(18, value, SettingsTextPP.getPropSettings(prop));
				case 44 % SettingsTextPP.EDITFIELD_ROTATION
					check = Format.checkFormat(18, value, SettingsTextPP.getPropSettings(prop));
				case 45 % SettingsTextPP.SLIDER_ROTATION
					check = Format.checkFormat(18, value, SettingsTextPP.getPropSettings(prop));
				case 46 % SettingsTextPP.EDITFIELD_FONTNAME
					check = Format.checkFormat(18, value, SettingsTextPP.getPropSettings(prop));
				case 47 % SettingsTextPP.DROPDOWN_FONTWEIGHT
					check = Format.checkFormat(18, value, SettingsTextPP.getPropSettings(prop));
				case 48 % SettingsTextPP.DROPDOWN_INTERPRETER
					check = Format.checkFormat(18, value, SettingsTextPP.getPropSettings(prop));
				case 49 % SettingsTextPP.DROPDOWN_HALIGN
					check = Format.checkFormat(18, value, SettingsTextPP.getPropSettings(prop));
				case 50 % SettingsTextPP.DROPDOWN_VALIGN
					check = Format.checkFormat(18, value, SettingsTextPP.getPropSettings(prop));
				case 4 % SettingsTextPP.TEMPLATE
					check = Format.checkFormat(8, value, SettingsTextPP.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@SettingsPP(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SettingsTextPP:' 'WrongInput'], ...
					['BRAPH2' ':SettingsTextPP:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsTextPP.getPropTag(prop) ' (' SettingsTextPP.getFormatTag(SettingsTextPP.getPropFormat(prop)) ').'] ...
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
				case 37 % SettingsTextPP.EDITFIELD_X
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD_X', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('X')) ' ' el.get(prop).getPropDescription('X')], ...
					    'ValueChangedFcn', {@cb_editfield_x} ...
					    );
					
					value = editfield;
					
				case 38 % SettingsTextPP.EDITFIELD_Y
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD_Y', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('Y')) ' ' el.get(prop).getPropDescription('Y')], ...
					    'ValueChangedFcn', {@cb_editfield_y} ...
					    );
					
					value = editfield;
					
				case 39 % SettingsTextPP.EDITFIELD_Z
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD_Z', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('Z')) ' ' el.get(prop).getPropDescription('Z')], ...
					    'ValueChangedFcn', {@cb_editfield_Z} ...
					    );
					
					value = editfield;
					
				case 40 % SettingsTextPP.EDITFIELD_TXT
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield = uieditfield( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD_TXT', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('TXT')) ' ' el.get(prop).getPropDescription('TXT')], ...
					    'ValueChangedFcn', {@cb_editfield_txt} ...
					    );
					
					value = editfield;
					
				case 41 % SettingsTextPP.BUTTON_FONTCOLOR
					el = pr.get('EL');
					prop = pr.get('PROP');
					button_fontcolor = uibutton( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'BUTTON_FONTCOLOR', ...
					    'Text', 'face', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FONTCOLOR')) ' ' el.get(prop).getPropDescription('FONTCOLOR')], ...
					    'ButtonPushedFcn', {@cb_button_fontcolor}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					value = button_fontcolor;
					
				case 42 % SettingsTextPP.EDITFIELD_FONTSIZE
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_fontsize = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'EDITFIELD_FONTSIZE', ...
					    'Limits', [0 100], ...
					    'LowerLimitInclusive', 'off', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FONTSIZE')) ' ' el.get(prop).getPropDescription('FONTSIZE')], ...
					    'ValueChangedFcn', {@cb_editfield_fontsize} ...
					    );
					value = editfield_fontsize;
					
				case 43 % SettingsTextPP.SLIDER_FONTSIZE
					el = pr.get('EL');
					prop = pr.get('PROP');
					slider_fontsize = uislider( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'SLIDER_FONTSIZE', ...
					    'Limits', [0 100], ...
					    'FontSize', 12 / 2, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FONTSIZE')) ' ' el.get(prop).getPropDescription('FONTSIZE')], ...
					    'ValueChangedFcn', {@cb_slider_fontsize} ...
					    );
					value = slider_fontsize;
					
				case 44 % SettingsTextPP.EDITFIELD_ROTATION
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_rotation = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'EDITFIELD_ROTATION', ...
					    'Limits', [-180 180], ...
					    'LowerLimitInclusive', 'on', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('ROTATION')) ' ' el.get(prop).getPropDescription('ROTATION')], ...
					    'ValueChangedFcn', {@cb_editfield_rotation} ...
					    );
					value = editfield_rotation;
					
				case 45 % SettingsTextPP.SLIDER_ROTATION
					el = pr.get('EL');
					prop = pr.get('PROP');
					slider_rotation = uislider( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'SLIDER_ROTATION', ...
					    'Limits', [-180 180], ...
					    'FontSize', 12 / 2, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('ROTATION')) ' ' el.get(prop).getPropDescription('ROTATION')], ...
					    'ValueChangedFcn', {@cb_slider_rotation} ...
					    );
					value = slider_rotation;
					
				case 46 % SettingsTextPP.EDITFIELD_FONTNAME
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield_fontname = uieditfield( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD_FONTNAME', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FONTNAME')) ' ' el.get(prop).getPropDescription('FONTNAME')], ...
					    'ValueChangedFcn', {@cb_editfield_fontname} ...
					    );
					
					value = editfield_fontname;
					
				case 47 % SettingsTextPP.DROPDOWN_FONTWEIGHT
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown_fontweight = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN_FONTWEIGHT', ...
					    'Items', el.get(prop).getPropSettings('FONTWEIGHT'), ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FONTWEIGHT')) ' ' el.get(prop).getPropDescription('FONTWEIGHT')], ...
					    'ValueChangedFcn', {@cb_dropdown_fontweight} ...
					    );
					
					value = dropdown_fontweight;
					
				case 48 % SettingsTextPP.DROPDOWN_INTERPRETER
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown_interpreter = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN_INTERPRETER', ...
					    'Items', el.get(prop).getPropSettings('INTERPRETER'), ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('INTERPRETER')) ' ' el.get(prop).getPropDescription('INTERPRETER')], ...
					    'ValueChangedFcn', {@cb_dropdown_interpreter} ...
					    );
					
					value = dropdown_interpreter;
					
				case 49 % SettingsTextPP.DROPDOWN_HALIGN
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown_halign = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN_HALIGN', ...
					    'Items', el.get(prop).getPropSettings('HALIGN'), ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('HALIGN')) ' ' el.get(prop).getPropDescription('HALIGN')], ...
					    'ValueChangedFcn', {@cb_dropdown_halign} ...
					    );
					
					value = dropdown_halign;
					
				case 50 % SettingsTextPP.DROPDOWN_VALIGN
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown_valign = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN_VALIGN', ...
					    'Items', el.get(prop).getPropSettings('VALIGN'), ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('VALIGN')) ' ' el.get(prop).getPropDescription('VALIGN')], ...
					    'ValueChangedFcn', {@cb_dropdown_valign} ...
					    );
					
					value = dropdown_valign;
					
				case 20 % SettingsTextPP.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('EDITFIELD_X')
					    pr.memorize('EDITFIELD_Y')
					    pr.memorize('EDITFIELD_Z')
					    pr.memorize('EDITFIELD_TXT')
					    
					    pr.memorize('BUTTON_FONTCOLOR')
					    pr.memorize('EDITFIELD_FONTSIZE')
					    pr.memorize('SLIDER_FONTSIZE')
					    pr.memorize('EDITFIELD_ROTATION')
					    pr.memorize('SLIDER_ROTATION')
					        
					    pr.memorize('EDITFIELD_FONTNAME')
					    pr.memorize('DROPDOWN_FONTWEIGHT')
					    pr.memorize('DROPDOWN_INTERPRETER')
					    pr.memorize('DROPDOWN_HALIGN')
					    pr.memorize('DROPDOWN_VALIGN')
					end
					
				case 21 % SettingsTextPP.UPDATE
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if el.isLocked(prop)
					        set(pr.get('EDITFIELD_X'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('EDITFIELD_Y'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('EDITFIELD_Z'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('EDITFIELD_TXT'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )        
					        
					        set(pr.get('BUTTON_FONTCOLOR'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('EDITFIELD_FONTSIZE'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('SLIDER_FONTSIZE'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('EDITFIELD_ROTATION'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('SLIDER_ROTATION'), 'Enable', pr.get('ENABLE'))
					        
					        set(pr.get('EDITFIELD_FONTNAME'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('DROPDOWN_FONTWEIGHT'), 'Enable', 'off')
					        set(pr.get('DROPDOWN_INTERPRETER'), 'Enable', 'off')
					        set(pr.get('DROPDOWN_HALIGN'), 'Enable', 'off')
					        set(pr.get('DROPDOWN_VALIGN'), 'Enable', 'off')
					    end
					
					    switch el.getPropCategory(prop)
					        case 2
					            set(pr.get('EDITFIELD_X'), 'Value', el.get(prop).get('X'))
					            set(pr.get('EDITFIELD_Y'), 'Value', el.get(prop).get('Y'))
					            set(pr.get('EDITFIELD_Z'), 'Value', el.get(prop).get('Z'))
					            set(pr.get('EDITFIELD_TXT'), 'Value', el.get(prop).get('TXT'))
					            
					            set(pr.get('BUTTON_FONTCOLOR'), 'BackgroundColor', el.get(prop).get('COLOR'))
					            set(pr.get('EDITFIELD_FONTSIZE'), 'Value', el.get(prop).get('FONTSIZE'))
					            set(pr.get('SLIDER_FONTSIZE'), 'Value', el.get(prop).get('FONTSIZE'))
					            set(pr.get('EDITFIELD_ROTATION'), 'Value', el.get(prop).get('ROTATION'))
					            set(pr.get('SLIDER_ROTATION'), 'Value', el.get(prop).get('ROTATION'))
					
					            set(pr.get('EDITFIELD_FONTNAME'), 'Value', el.get(prop).get('FONTNAME'))
					            set(pr.get('DROPDOWN_FONTWEIGHT'), 'Value', el.get(prop).get('FONTWEIGHT'))
					            set(pr.get('DROPDOWN_INTERPRETER'), 'Value', el.get(prop).get('INTERPRETER'))
					            set(pr.get('DROPDOWN_HALIGN'), 'Value', el.get(prop).get('HALIGN'))
					            set(pr.get('DROPDOWN_VALIGN'), 'Value', el.get(prop).get('VALIGN'))
					            
					        case {3, 4, 8, 9}
					            set(pr.get('EDITFIELD_X'), 'Value', el.get(prop).get('X'))
					            set(pr.get('EDITFIELD_Y'), 'Value', el.get(prop).get('Y'))
					            set(pr.get('EDITFIELD_Z'), 'Value', el.get(prop).get('Z'))
					            set(pr.get('EDITFIELD_TXT'), 'Value', el.get(prop).get('TXT'))
					            
					            set(pr.get('BUTTON_FONTCOLOR'), 'BackgroundColor', el.get(prop).get('FONTCOLOR'))
					            set(pr.get('EDITFIELD_FONTSIZE'), 'Value', el.get(prop).get('FONTSIZE'))
					            set(pr.get('SLIDER_FONTSIZE'), 'Value', el.get(prop).get('FONTSIZE'))
					            set(pr.get('EDITFIELD_ROTATION'), 'Value', el.get(prop).get('ROTATION'))
					            set(pr.get('SLIDER_ROTATION'), 'Value', el.get(prop).get('ROTATION'))
					
					            set(pr.get('EDITFIELD_FONTNAME'), 'Value', el.get(prop).get('FONTNAME'))
					            set(pr.get('DROPDOWN_FONTWEIGHT'), 'Value', el.get(prop).get('FONTWEIGHT'))
					            set(pr.get('DROPDOWN_INTERPRETER'), 'Value', el.get(prop).get('INTERPRETER'))
					            set(pr.get('DROPDOWN_HALIGN'), 'Value', el.get(prop).get('HALIGN'))
					            set(pr.get('DROPDOWN_VALIGN'), 'Value', el.get(prop).get('VALIGN'))
					
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('X'), 'Callback')
					                set(pr.get('EDITFIELD_X'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('Y'), 'Callback')
					                set(pr.get('EDITFIELD_Y'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('Z'), 'Callback')
					                set(pr.get('EDITFIELD_Z'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('TXT'), 'Callback')
					                set(pr.get('EDITFIELD_TXT'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FONTSIZE'), 'Callback')
					                set(pr.get('BUTTON_FONTCOLOR'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FONTSIZE'), 'Callback')
					                set(pr.get('EDITFIELD_FONTSIZE'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_FONTSIZE'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('ROTATION'), 'Callback')
					                set(pr.get('EDITFIELD_ROTATION'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_ROTATION'), 'Enable', pr.get('ENABLE'))
					            end
					            
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FONTNAME'), 'Callback')
					                set(pr.get('EDITFIELD_FONTNAME'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FONTWEIGHT'), 'Callback')
					                set(pr.get('DROPDOWN_FONTWEIGHT'), 'Enable', 'off')
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('INTERPRETER'), 'Callback')
					                set(pr.get('DROPDOWN_INTERPRETER'), 'Enable', 'off')
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('HALIGN'), 'Callback')
					                set(pr.get('DROPDOWN_HALIGN'), 'Enable', 'off')
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('VALIGN'), 'Callback')
					                set(pr.get('DROPDOWN_VALIGN'), 'Enable', 'off')
					            end
					            
					        case 5
					            value = el.getr(prop);
					            
					            if isa(value, 'NoValue')
					                set(pr.get('EDITFIELD_X'), ...
					                    'Value', el.get(prop).getPropDefault('X'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_Y'), ...
					                    'Value', el.get(prop).getPropDefault('Y'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_Z'), ...
					                    'Value', el.get(prop).getPropDefault('Z'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_TXT'), ...
					                    'Value', el.get(prop).getPropDefault('TXT'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					
					                set(pr.get('BUTTON_FONTCOLOR'), ...
					                    'BackgroundColor', el.get(prop).getPropDefault('FONTCOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_FONTSIZE'), ...
					                    'Value', el.get(prop).getPropDefault('FONTSIZE'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_FONTSIZE'), ...
					                    'Value', el.get(prop).getPropDefault('FONTSIZE'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_ROTATION'), ...
					                    'Value', el.get(prop).getPropDefault('ROTATION'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_ROTATION'), ...
					                    'Value', el.get(prop).getPropDefault('ROTATION'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					
					                set(pr.get('EDITFIELD_FONTNAME'), ...
					                    'Value', el.get(prop).getPropDefault('FONTNAME'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_FONTWEIGHT'), ...
					                    'Value', el.get(prop).getPropDefault('FONTWEIGHT'), ...
					                    'Editable', 'off' ...
					                    )
					                set(pr.get('DROPDOWN_INTERPRETER'), ...
					                    'Value', el.get(prop).getPropDefault('INTERPRETER'), ...
					                    'Editable', 'off' ...
					                    )
					                set(pr.get('DROPDOWN_HALIGN'), ...
					                    'Value', el.get(prop).getPropDefault('HALIGN'), ...
					                    'Editable', 'off' ...
					                    )
					                set(pr.get('DROPDOWN_VALIGN'), ...
					                    'Value', el.get(prop).getPropDefault('VALIGN'), ...
					                    'Editable', 'off' ...
					                    )
					            else
					                set(pr.get('EDITFIELD_X'), ...
					                    'Value', el.get(prop).get('X'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_Y'), ...
					                    'Value', el.get(prop).get('Y'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_Z'), ...
					                    'Value', el.get(prop).get('Z'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_TXT'), ...
					                    'Value', el.get(prop).get('TXT'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					
					                set(pr.get('BUTTON_FONTCOLOR'), ...
					                    'BackgroundColor', el.get(prop).get('FONTCOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_FONTSIZE'), ...
					                    'Value', el.get(prop).get('FONTSIZE'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_FONTSIZE'), ...
					                    'Value', el.get(prop).get('FONTSIZE'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_ROTATION'), ...
					                    'Value', el.get(prop).get('ROTATION'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_ROTATION'), ...
					                    'Value', el.get(prop).get('ROTATION'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					
					                set(pr.get('EDITFIELD_FONTNAME'), ...
					                    'Value', el.get(prop).get('FONTNAME'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_FONTWEIGHT'), ...
					                    'Value', el.get(prop).get('FONTWEIGHT'), ...
					                    'Editable', 'off' ...
					                    )
					                set(pr.get('DROPDOWN_INTERPRETER'), ...
					                    'Value', el.get(prop).get('INTERPRETER'), ...
					                    'Editable', 'off' ...
					                    )
					                set(pr.get('DROPDOWN_HALIGN'), ...
					                    'Value', el.get(prop).get('HALIGN'), ...
					                    'Editable', 'off' ...
					                    )
					                set(pr.get('DROPDOWN_VALIGN'), ...
					                    'Value', el.get(prop).get('VALIGN'), ...
					                    'Editable', 'off' ...
					                    )
					            end
					    end
					end
					
				case 22 % SettingsTextPP.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
						w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					
					    set(pr.get('EDITFIELD_X'),   'Position', [4           74   .10*w_p     21])
					    set(pr.get('EDITFIELD_Y'),   'Position', [8+.10*w_p   74   .10*w_p     21])
					    set(pr.get('EDITFIELD_Z'),   'Position', [11+.20*w_p   74   .10*w_p     21])
					    set(pr.get('EDITFIELD_TXT'), 'Position', [15+.30*w_p  74  .60*w_p     21])
					    
					    set(pr.get('BUTTON_FONTCOLOR'),   'Position', [4            39  .20*w_p   21])
					    set(pr.get('EDITFIELD_FONTSIZE'), 'Position', [8+.20*w_p	39  .15*w_p   21])
					    set(pr.get('SLIDER_FONTSIZE'),    'Position', [11+.35*w_p	57 .20*w_p   3]) % the height of a slider cannot be changed
					    set(pr.get('EDITFIELD_ROTATION'), 'Position', [18+.55*w_p	39  .15*w_p   21])
					    set(pr.get('SLIDER_ROTATION'),    'Position', [22+.70*w_p	57 .20*w_p   3]) % the height of a slider cannot be changed
					    
					    set(pr.get('EDITFIELD_FONTNAME'),   'Position', [4          4   .20*w_p     21])    
					    set(pr.get('DROPDOWN_FONTWEIGHT'),  'Position', [8+.20*w_p  4   .18*w_p     21])    
					    set(pr.get('DROPDOWN_INTERPRETER'), 'Position', [11+.38*w_p  4   .18*w_p     21])    
					    set(pr.get('DROPDOWN_HALIGN'),      'Position', [15+.56*w_p	4   .18*w_p     21])    
					    set(pr.get('DROPDOWN_VALIGN'),      'Position', [18+.74*w_p	4   .18*w_p     21])    
					end
					
				case 18 % SettingsTextPP.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('EDITFIELD_X', Element.getNoValue())
					    pr.set('EDITFIELD_Y', Element.getNoValue())
					    pr.set('EDITFIELD_Z', Element.getNoValue())
					    pr.set('EDITFIELD_TXT', Element.getNoValue())
					    
					    pr.set('BUTTON_FONTCOLOR', Element.getNoValue())
					    pr.set('EDITFIELD_FONTSIZE', Element.getNoValue())
					    pr.set('SLIDER_FONTSIZE', Element.getNoValue())
					    pr.set('EDITFIELD_ROTATION', Element.getNoValue())
					    pr.set('SLIDER_ROTATION', Element.getNoValue())
					
					    pr.set('EDITFIELD_FONTNAME', Element.getNoValue())
					    pr.set('DROPDOWN_FONTWEIGHT', Element.getNoValue())
					    pr.set('DROPDOWN_INTERPRETER', Element.getNoValue())
					    pr.set('DROPDOWN_HALIGN', Element.getNoValue())
					    pr.set('DROPDOWN_VALIGN', Element.getNoValue())
					end
					
				otherwise
					if prop <= 35
						value = calculateValue@SettingsPP(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_editfield_x(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('X', get(pr.get('EDITFIELD_X'), 'Value'))
			end
			function cb_editfield_y(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('Y', get(pr.get('EDITFIELD_Y'), 'Value'))
			end
			function cb_editfield_z(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('Z', get(pr.get('EDITFIELD_Z'), 'Value'))
			end
			function cb_editfield_txt(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('TXT', get(pr.get('EDITFIELD_TXT'), 'Value'))
			end
			function cb_button_fontcolor(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    new_color = uisetcolor(el.get(prop).get('FONTCOLOR'));
			    if ~isequal(new_color, el.get(prop).get('FONTCOLOR'))
			        el.get(prop).set('FONTCOLOR', new_color)
			
			        pr.get('UPDATE')
			    end
			end
			function cb_editfield_fontsize(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('FONTSIZE', get(pr.get('EDITFIELD_FONTSIZE'), 'Value'))
			
				pr.get('UPDATE')
			end
			function cb_slider_fontsize(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('FONTSIZE', max(0.01, get(pr.get('SLIDER_FONTSIZE'), 'Value')))
			
				pr.get('UPDATE')
			end
			function cb_editfield_rotation(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('ROTATION', get(pr.get('EDITFIELD_ROTATION'), 'Value'))
			
				pr.get('UPDATE')
			end
			function cb_slider_rotation(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('ROTATION', get(pr.get('SLIDER_ROTATION'), 'Value'))
			
				pr.get('UPDATE')
			end
			function cb_editfield_fontname(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('FONTNAME', get(pr.get('EDITFIELD_FONTNAME'), 'Value'))
			end
			function cb_dropdown_fontweight(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('FONTWEIGHT', get(pr.get('DROPDOWN_FONTWEIGHT'), 'Value'))
			end
			function cb_dropdown_interpreter(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('INTERPRETER', get(pr.get('DROPDOWN_INTERPRETER'), 'Value'))
			end
			function cb_dropdown_halign(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('HALIGN', get(pr.get('DROPDOWN_HALIGN'), 'Value'))
			end
			function cb_dropdown_valign(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('VALIGN', get(pr.get('DROPDOWN_VALIGN'), 'Value'))
			end
		end
	end
end
