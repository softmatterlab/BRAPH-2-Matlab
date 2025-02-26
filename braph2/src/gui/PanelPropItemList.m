classdef PanelPropItemList < PanelProp
	%PanelPropItemList plots the panel of a property item-list.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% An Item-List Prop Panel (PanelPropItemList) plots the panel for a ITEMLIST property with a table.
	%  It works for all categories. 
	%  
	% It can be personalized with the following props:
	%   COLS - Numerical array with the columns to be visualized. It can include 
	%          -1 and/or prop numbers of the item class.
	%   ROWNAME - String list with the row names as per uitable format.
	%          It can be a string list or 'numbered' or {} (to reset it).
	%   COLUMNAME - String list with the column names as per uitable format.
	%          It can be a string list or 'numbered'.
	%   COLUMNWIDTH - String list with the cloumn width as per uitable format.
	%          It can be a string list (e.g. {'1x' '2x'}) or 'auto'.
	%   COLUMNEDITABLE - Row vector to determine the cloumn editability as per uitable format.
	%          It can be a row vector of booleans.
	%   COLUMNFORMAT - Code to determine the column format as per uitable format.
	%          The format should be, e.g., {'char' 'logical' 'numeric' {'op1' 'op2'}}.
	%   CB_TAB_EDIT - Code in a cell array for the edit callback to be evaluated 
	%          by the table edit callback. It can refer to the variables:
	%           el, prop, dict, it_class, pr, i, col, newdata
	%          and use the standard callback function:
	%           cb_table_edit_default()
	%
	% The list of PanelPropItemList properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the item-list property panel.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the item-list property panel.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the item-list property panel.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the item-list property panel.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the item-list property panel.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the item-list property panel.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the item-list property panel.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.
	%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the property panel.
	%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the table.
	%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
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
	%  <strong>36</strong> <strong>TABLE_HEIGHT</strong> 	TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.
	%  <strong>37</strong> <strong>SELECTED</strong> 	SELECTED (gui, cvector) is the list of selected items.
	%  <strong>38</strong> <strong>COLS</strong> 	COLS (gui, rvector) is the ordered list of columns.
	%  <strong>39</strong> <strong>ROWNAME</strong> 	ROWNAME (gui, stringlist) determines the table row names.
	%  <strong>40</strong> <strong>COLUMNNAME</strong> 	COLUMNNAME (gui, stringlist) determines the table column names.
	%  <strong>41</strong> <strong>COLUMNWIDTH</strong> 	COLUMNWIDTH (gui, stringlist) determines the column widths.
	%  <strong>42</strong> <strong>COLUMNEDITABLE</strong> 	COLUMNEDITABLE (gui, rvector) determines whether the columns are editable.
	%  <strong>43</strong> <strong>COLUMNFORMAT</strong> 	COLUMNFORMAT (gui, stringlist) determines the columns formats.
	%  <strong>44</strong> <strong>CB_TAB_EDIT</strong> 	CB_TAB_EDIT (gui, string) is executed when a cell is updated (to be evaluated).
	%  <strong>45</strong> <strong>TABLE</strong> 	TABLE (evanescent, handle) is the table.
	%  <strong>46</strong> <strong>MENU_OPEN_ITEMS</strong> 	MENU_OPEN_ITEMS (gui, logical) determines whether to show the context menu to open the items.
	%  <strong>47</strong> <strong>MENU_EXPORT</strong> 	MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.
	%  <strong>48</strong> <strong>CONTEXTMENU</strong> 	CONTEXTMENU (evanescent, handle) is the context menu.
	%  <strong>49</strong> <strong>GUI_ITS_DICT</strong> 	GUI_ITS_DICT (gui, idict) contains the GUIs for the items.
	%
	% PanelPropItemList methods (constructor):
	%  PanelPropItemList - constructor
	%
	% PanelPropItemList methods:
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
	% PanelPropItemList methods (display):
	%  tostring - string with information about the item-list prop panel
	%  disp - displays information about the item-list prop panel
	%  tree - displays the tree of the item-list prop panel
	%
	% PanelPropItemList methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two item-list prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the item-list prop panel
	%
	% PanelPropItemList methods (save/load, Static):
	%  save - saves BRAPH2 item-list prop panel as b2 file
	%  load - loads a BRAPH2 item-list prop panel from a b2 file
	%
	% PanelPropItemList method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the item-list prop panel
	%
	% PanelPropItemList method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the item-list prop panel
	%
	% PanelPropItemList methods (inspection, Static):
	%  getClass - returns the class of the item-list prop panel
	%  getSubclasses - returns all subclasses of PanelPropItemList
	%  getProps - returns the property list of the item-list prop panel
	%  getPropNumber - returns the property number of the item-list prop panel
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
	% PanelPropItemList methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropItemList methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropItemList methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropItemList methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropItemList; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropItemList constants</a>.
	%
	%
	% See also uitable, GUI, PanelElement, GUIElement.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % constants
		SELECTOR = -1 % code for the selector column.
	end
	properties (Constant) % properties
		TABLE_HEIGHT = 36; %CET: Computational Efficiency Trick
		TABLE_HEIGHT_TAG = 'TABLE_HEIGHT';
		TABLE_HEIGHT_CATEGORY = 9;
		TABLE_HEIGHT_FORMAT = 22;
		
		SELECTED = 37; %CET: Computational Efficiency Trick
		SELECTED_TAG = 'SELECTED';
		SELECTED_CATEGORY = 9;
		SELECTED_FORMAT = 13;
		
		COLS = 38; %CET: Computational Efficiency Trick
		COLS_TAG = 'COLS';
		COLS_CATEGORY = 9;
		COLS_FORMAT = 12;
		
		ROWNAME = 39; %CET: Computational Efficiency Trick
		ROWNAME_TAG = 'ROWNAME';
		ROWNAME_CATEGORY = 9;
		ROWNAME_FORMAT = 3;
		
		COLUMNNAME = 40; %CET: Computational Efficiency Trick
		COLUMNNAME_TAG = 'COLUMNNAME';
		COLUMNNAME_CATEGORY = 9;
		COLUMNNAME_FORMAT = 3;
		
		COLUMNWIDTH = 41; %CET: Computational Efficiency Trick
		COLUMNWIDTH_TAG = 'COLUMNWIDTH';
		COLUMNWIDTH_CATEGORY = 9;
		COLUMNWIDTH_FORMAT = 3;
		
		COLUMNEDITABLE = 42; %CET: Computational Efficiency Trick
		COLUMNEDITABLE_TAG = 'COLUMNEDITABLE';
		COLUMNEDITABLE_CATEGORY = 9;
		COLUMNEDITABLE_FORMAT = 12;
		
		COLUMNFORMAT = 43; %CET: Computational Efficiency Trick
		COLUMNFORMAT_TAG = 'COLUMNFORMAT';
		COLUMNFORMAT_CATEGORY = 9;
		COLUMNFORMAT_FORMAT = 3;
		
		CB_TAB_EDIT = 44; %CET: Computational Efficiency Trick
		CB_TAB_EDIT_TAG = 'CB_TAB_EDIT';
		CB_TAB_EDIT_CATEGORY = 9;
		CB_TAB_EDIT_FORMAT = 2;
		
		TABLE = 45; %CET: Computational Efficiency Trick
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = 7;
		TABLE_FORMAT = 18;
		
		MENU_OPEN_ITEMS = 46; %CET: Computational Efficiency Trick
		MENU_OPEN_ITEMS_TAG = 'MENU_OPEN_ITEMS';
		MENU_OPEN_ITEMS_CATEGORY = 9;
		MENU_OPEN_ITEMS_FORMAT = 4;
		
		MENU_EXPORT = 47; %CET: Computational Efficiency Trick
		MENU_EXPORT_TAG = 'MENU_EXPORT';
		MENU_EXPORT_CATEGORY = 9;
		MENU_EXPORT_FORMAT = 4;
		
		CONTEXTMENU = 48; %CET: Computational Efficiency Trick
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = 7;
		CONTEXTMENU_FORMAT = 18;
		
		GUI_ITS_DICT = 49; %CET: Computational Efficiency Trick
		GUI_ITS_DICT_TAG = 'GUI_ITS_DICT';
		GUI_ITS_DICT_CATEGORY = 9;
		GUI_ITS_DICT_FORMAT = 10;
	end
	methods % constructor
		function pr = PanelPropItemList(varargin)
			%PanelPropItemList() creates a item-list prop panel.
			%
			% PanelPropItemList(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropItemList(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PanelPropItemList properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the item-list property panel.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the item-list property panel.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the item-list property panel.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the item-list property panel.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the item-list property panel.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the item-list property panel.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the item-list property panel.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.
			%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the property panel.
			%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the table.
			%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
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
			%  <strong>36</strong> <strong>TABLE_HEIGHT</strong> 	TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.
			%  <strong>37</strong> <strong>SELECTED</strong> 	SELECTED (gui, cvector) is the list of selected items.
			%  <strong>38</strong> <strong>COLS</strong> 	COLS (gui, rvector) is the ordered list of columns.
			%  <strong>39</strong> <strong>ROWNAME</strong> 	ROWNAME (gui, stringlist) determines the table row names.
			%  <strong>40</strong> <strong>COLUMNNAME</strong> 	COLUMNNAME (gui, stringlist) determines the table column names.
			%  <strong>41</strong> <strong>COLUMNWIDTH</strong> 	COLUMNWIDTH (gui, stringlist) determines the column widths.
			%  <strong>42</strong> <strong>COLUMNEDITABLE</strong> 	COLUMNEDITABLE (gui, rvector) determines whether the columns are editable.
			%  <strong>43</strong> <strong>COLUMNFORMAT</strong> 	COLUMNFORMAT (gui, stringlist) determines the columns formats.
			%  <strong>44</strong> <strong>CB_TAB_EDIT</strong> 	CB_TAB_EDIT (gui, string) is executed when a cell is updated (to be evaluated).
			%  <strong>45</strong> <strong>TABLE</strong> 	TABLE (evanescent, handle) is the table.
			%  <strong>46</strong> <strong>MENU_OPEN_ITEMS</strong> 	MENU_OPEN_ITEMS (gui, logical) determines whether to show the context menu to open the items.
			%  <strong>47</strong> <strong>MENU_EXPORT</strong> 	MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.
			%  <strong>48</strong> <strong>CONTEXTMENU</strong> 	CONTEXTMENU (evanescent, handle) is the context menu.
			%  <strong>49</strong> <strong>GUI_ITS_DICT</strong> 	GUI_ITS_DICT (gui, idict) contains the GUIs for the items.
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the item-list prop panel.
			%
			% BUILD = PanelPropItemList.GETBUILD() returns the build of 'PanelPropItemList'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the item-list prop panel PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('PanelPropItemList') returns the build of 'PanelPropItemList'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('PanelPropItemList')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the item-list prop panel.
			%
			% CLASS = PanelPropItemList.GETCLASS() returns the class 'PanelPropItemList'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the item-list prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropItemList') returns 'PanelPropItemList'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropItemList')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropItemList';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the item-list prop panel.
			%
			% LIST = PanelPropItemList.GETSUBCLASSES() returns all subclasses of 'PanelPropItemList'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the item-list prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropItemList') returns all subclasses of 'PanelPropItemList'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'PanelPropItemList' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of item-list prop panel.
			%
			% PROPS = PanelPropItemList.GETPROPS() returns the property list of item-list prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropItemList.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the item-list prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropItemList'[, CATEGORY]) returns the property list of 'PanelPropItemList'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49];
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
					prop_list = [10 15 27 28 30 31 32 33 34 35 45 48];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36 37 38 39 40 41 42 43 44 46 47 49];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of item-list prop panel.
			%
			% N = PanelPropItemList.GETPROPNUMBER() returns the property number of item-list prop panel.
			%
			% N = PanelPropItemList.GETPROPNUMBER(CATEGORY) returns the property number of item-list prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the item-list prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropItemList') returns the property number of 'PanelPropItemList'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 49;
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
					prop_number = 16;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in item-list prop panel/error.
			%
			% CHECK = PanelPropItemList.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropItemList, PROP) checks whether PROP exists for PanelPropItemList.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropItemList:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropItemList:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropItemList:WrongInput]
			%  Element.EXISTSPROP(PanelPropItemList, PROP) throws error if PROP does NOT exist for PanelPropItemList.
			%   Error id: [BRAPH2:PanelPropItemList:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 49 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropItemList:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropItemList:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropItemList.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in item-list prop panel/error.
			%
			% CHECK = PanelPropItemList.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropItemList, TAG) checks whether TAG exists for PanelPropItemList.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropItemList:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropItemList:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropItemList:WrongInput]
			%  Element.EXISTSTAG(PanelPropItemList, TAG) throws error if TAG does NOT exist for PanelPropItemList.
			%   Error id: [BRAPH2:PanelPropItemList:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'TABLE_HEIGHT'  'SELECTED'  'COLS'  'ROWNAME'  'COLUMNNAME'  'COLUMNWIDTH'  'COLUMNEDITABLE'  'COLUMNFORMAT'  'CB_TAB_EDIT'  'TABLE'  'MENU_OPEN_ITEMS'  'MENU_EXPORT'  'CONTEXTMENU'  'GUI_ITS_DICT' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropItemList:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropItemList:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropItemList.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropItemList, POINTER) returns property number of POINTER of PanelPropItemList.
			%  PROPERTY = PR.GETPROPPROP(PanelPropItemList, POINTER) returns property number of POINTER of PanelPropItemList.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'TABLE_HEIGHT'  'SELECTED'  'COLS'  'ROWNAME'  'COLUMNNAME'  'COLUMNWIDTH'  'COLUMNEDITABLE'  'COLUMNFORMAT'  'CB_TAB_EDIT'  'TABLE'  'MENU_OPEN_ITEMS'  'MENU_EXPORT'  'CONTEXTMENU'  'GUI_ITS_DICT' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(PanelPropItemList, POINTER) returns tag of POINTER of PanelPropItemList.
			%  TAG = PR.GETPROPTAG(PanelPropItemList, POINTER) returns tag of POINTER of PanelPropItemList.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				panelpropitemlist_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'TABLE_HEIGHT'  'SELECTED'  'COLS'  'ROWNAME'  'COLUMNNAME'  'COLUMNWIDTH'  'COLUMNEDITABLE'  'COLUMNFORMAT'  'CB_TAB_EDIT'  'TABLE'  'MENU_OPEN_ITEMS'  'MENU_EXPORT'  'CONTEXTMENU'  'GUI_ITS_DICT' };
				tag = panelpropitemlist_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropItemList, POINTER) returns category of POINTER of PanelPropItemList.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropItemList, POINTER) returns category of POINTER of PanelPropItemList.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropItemList.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelpropitemlist_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  9  9  9  9  9  9  9  9  7  9  9  7  9 };
			prop_category = panelpropitemlist_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropItemList, POINTER) returns format of POINTER of PanelPropItemList.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropItemList, POINTER) returns format of POINTER of PanelPropItemList.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropItemList.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelpropitemlist_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  22  13  12  3  3  3  12  3  2  18  4  4  18  10 };
			prop_format = panelpropitemlist_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropItemList, POINTER) returns description of POINTER of PanelPropItemList.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropItemList, POINTER) returns description of POINTER of PanelPropItemList.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropItemList.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelpropitemlist_description_list = { 'ELCLASS (constant, string) is the class of the item-list property panel.'  'NAME (constant, string) is the name of the item-list property panel.'  'DESCRIPTION (constant, string) is the description of the item-list property panel.'  'TEMPLATE (parameter, item) is the template of the item-list property panel.'  'ID (data, string) is a few-letter code for the item-list property panel.'  'LABEL (metadata, string) is an extended label of the item-list property panel.'  'NOTES (metadata, string) are some specific notes about the item-list property panel.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the table.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the prop panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.'  'SELECTED (gui, cvector) is the list of selected items.'  'COLS (gui, rvector) is the ordered list of columns.'  'ROWNAME (gui, stringlist) determines the table row names.'  'COLUMNNAME (gui, stringlist) determines the table column names.'  'COLUMNWIDTH (gui, stringlist) determines the column widths.'  'COLUMNEDITABLE (gui, rvector) determines whether the columns are editable.'  'COLUMNFORMAT (gui, stringlist) determines the columns formats.'  'CB_TAB_EDIT (gui, string) is executed when a cell is updated (to be evaluated).'  'TABLE (evanescent, handle) is the table.'  'MENU_OPEN_ITEMS (gui, logical) determines whether to show the context menu to open the items.'  'MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.'  'CONTEXTMENU (evanescent, handle) is the context menu.'  'GUI_ITS_DICT (gui, idict) contains the GUIs for the items.' };
			prop_description = panelpropitemlist_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropItemList, POINTER) returns settings of POINTER of PanelPropItemList.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropItemList, POINTER) returns settings of POINTER of PanelPropItemList.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropItemList.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % PanelPropItemList.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(22);
				case 37 % PanelPropItemList.SELECTED
					prop_settings = Format.getFormatSettings(13);
				case 38 % PanelPropItemList.COLS
					prop_settings = Format.getFormatSettings(12);
				case 39 % PanelPropItemList.ROWNAME
					prop_settings = Format.getFormatSettings(3);
				case 40 % PanelPropItemList.COLUMNNAME
					prop_settings = Format.getFormatSettings(3);
				case 41 % PanelPropItemList.COLUMNWIDTH
					prop_settings = Format.getFormatSettings(3);
				case 42 % PanelPropItemList.COLUMNEDITABLE
					prop_settings = Format.getFormatSettings(12);
				case 43 % PanelPropItemList.COLUMNFORMAT
					prop_settings = Format.getFormatSettings(3);
				case 44 % PanelPropItemList.CB_TAB_EDIT
					prop_settings = Format.getFormatSettings(2);
				case 45 % PanelPropItemList.TABLE
					prop_settings = Format.getFormatSettings(18);
				case 46 % PanelPropItemList.MENU_OPEN_ITEMS
					prop_settings = Format.getFormatSettings(4);
				case 47 % PanelPropItemList.MENU_EXPORT
					prop_settings = Format.getFormatSettings(4);
				case 48 % PanelPropItemList.CONTEXTMENU
					prop_settings = Format.getFormatSettings(18);
				case 49 % PanelPropItemList.GUI_ITS_DICT
					prop_settings = 'GUI';
				case 4 % PanelPropItemList.TEMPLATE
					prop_settings = 'PanelPropItemList';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropItemList.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropItemList.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropItemList, POINTER) returns the default value of POINTER of PanelPropItemList.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropItemList, POINTER) returns the default value of POINTER of PanelPropItemList.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropItemList.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % PanelPropItemList.TABLE_HEIGHT
					prop_default = 240;
				case 37 % PanelPropItemList.SELECTED
					prop_default = Format.getFormatDefault(13, PanelPropItemList.getPropSettings(prop));
				case 38 % PanelPropItemList.COLS
					prop_default = Format.getFormatDefault(12, PanelPropItemList.getPropSettings(prop));
				case 39 % PanelPropItemList.ROWNAME
					prop_default = Format.getFormatDefault(3, PanelPropItemList.getPropSettings(prop));
				case 40 % PanelPropItemList.COLUMNNAME
					prop_default = Format.getFormatDefault(3, PanelPropItemList.getPropSettings(prop));
				case 41 % PanelPropItemList.COLUMNWIDTH
					prop_default = Format.getFormatDefault(3, PanelPropItemList.getPropSettings(prop));
				case 42 % PanelPropItemList.COLUMNEDITABLE
					prop_default = Format.getFormatDefault(12, PanelPropItemList.getPropSettings(prop));
				case 43 % PanelPropItemList.COLUMNFORMAT
					prop_default = Format.getFormatDefault(3, PanelPropItemList.getPropSettings(prop));
				case 44 % PanelPropItemList.CB_TAB_EDIT
					prop_default = Format.getFormatDefault(2, PanelPropItemList.getPropSettings(prop));
				case 45 % PanelPropItemList.TABLE
					prop_default = Format.getFormatDefault(18, PanelPropItemList.getPropSettings(prop));
				case 46 % PanelPropItemList.MENU_OPEN_ITEMS
					prop_default = true;
				case 47 % PanelPropItemList.MENU_EXPORT
					prop_default = false;
				case 48 % PanelPropItemList.CONTEXTMENU
					prop_default = Format.getFormatDefault(18, PanelPropItemList.getPropSettings(prop));
				case 49 % PanelPropItemList.GUI_ITS_DICT
					prop_default = Format.getFormatDefault(10, PanelPropItemList.getPropSettings(prop));
				case 1 % PanelPropItemList.ELCLASS
					prop_default = 'PanelPropItemList';
				case 2 % PanelPropItemList.NAME
					prop_default = 'Item-List Prop Panel';
				case 3 % PanelPropItemList.DESCRIPTION
					prop_default = 'An Item-List Prop Panel (PanelPropItemList) plots the panel for a ITEMLIST property with a table. It works for all categories. It can be personalized with the following props: COLS, ROWNAME, COLUMNAME, COLUMNWIDTH, COLUMNEDITABLE, COLUMNFORMAT, CB_TAB_EDIT.';
				case 4 % PanelPropItemList.TEMPLATE
					prop_default = Format.getFormatDefault(8, PanelPropItemList.getPropSettings(prop));
				case 5 % PanelPropItemList.ID
					prop_default = 'PanelPropItemList ID';
				case 6 % PanelPropItemList.LABEL
					prop_default = 'PanelPropItemList label';
				case 7 % PanelPropItemList.NOTES
					prop_default = 'PanelPropItemList notes';
				case 23 % PanelPropItemList.EL
					prop_default = IndexedDictionary();
				case 24 % PanelPropItemList.PROP
					prop_default = 11;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropItemList.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropItemList.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropItemList, POINTER) returns the conditioned default value of POINTER of PanelPropItemList.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropItemList, POINTER) returns the conditioned default value of POINTER of PanelPropItemList.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropItemList.getPropProp(pointer);
			
			prop_default = PanelPropItemList.conditioning(prop, PanelPropItemList.getPropDefault(prop));
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			%CONDITIONING conditions a value before setting a property.
			%
			% VALUE = CONDITIONING(EL, PROP, VALUE) conditions the value VALUE before
			%  it is set as the value of the property PROP.
			%  By default, this function does not do anything, so it should be
			%  implemented in the subclasses of Element when needed.
			%
			% Conditioning is only used for props of 2,
			%  3, 4, 8 and 9.
			%
			% See also preset, checkProp, postset, postprocessing, calculateValue,
			%  checkValue.
			
			prop = PanelPropItemList.getPropProp(pointer);
			
			switch prop
				case 37 % PanelPropItemList.SELECTED
					if isrow(value)
					    value = value';
					end
					
				case 44 % PanelPropItemList.CB_TAB_EDIT
					if iscell(value)
					    value = sprintf('%s;', value{:});
					end
					
				otherwise
					if prop <= 35
						value = conditioning@PanelProp(pointer, value);
					end
			end
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
				case 38 % PanelPropItemList.COLS
					if isempty(value)
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    it_class = el.getPropSettings(prop);
					
					    % columns to be to be shown in the table
					    % col = pr.SELECTOR for the selector column
					    % col = prop for the prop columns
					    cols = [pr.SELECTOR Element.getProps(it_class)];
					    
					    value = cols;
					end
					
				case 39 % PanelPropItemList.ROWNAME
					if isempty(value)
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    it_list = el.get(prop);
					    
					    rowname = cellfun(@(it) it.get('ID'), it_list, 'UniformOutput', false);
					    
					    value = rowname;
					    
					elseif isequal(value, 'numbered')
					    value = {'numbered'};
					end
					
				case 40 % PanelPropItemList.COLUMNNAME
					if isempty(value)
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    it_class = el.getPropSettings(prop);
					
					    cols = pr.memorize('COLS');
					    
					    columnname = repmat({''}, 1, length(cols));
					    for c = 1:1:length(cols)
					        col = cols(c);
					        if col == pr.SELECTOR
					            columnname{c} = '';
					        elseif Element.existsProp(it_class, col) % prop = col;
					            columnname{c} = Element.getPropTag(it_class, col);
					        end
					    end
					    
					    value = columnname;
					    
					elseif isequal(value, 'numbered')
					    value = {'numbered'};
					end
					
				case 41 % PanelPropItemList.COLUMNWIDTH
					if isempty(value) || isequal(value, 'auto')
					    columnwidth = {'auto'};
					    
					    value = columnwidth;
					end
					
				case 42 % PanelPropItemList.COLUMNEDITABLE
					if isempty(value)
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    it_class = el.getPropSettings(prop);
					    
					    cols = pr.memorize('COLS');
					    
					    columneditable = false(1, length(cols));
					    for c = 1:1:length(cols)
					        col = cols(c);
					        if col == pr.SELECTOR
					            columneditable(c) = true; % always true
					        else
					            if ~el.isLocked(prop)
					                switch Element.getPropFormat(it_class, col)
					                    case 1 % Format.EMPTY
					                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					                    
					                    case 2 % Format.STRING
					                        columneditable(c) = true;
					                        
					                    case 3 % Format.STRINGLIST
					                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					
					                    case 4 % Format.LOGICAL
					                        columneditable(c) = true;
					                        
					                    case 5 % Format.OPTION
					                        columneditable(c) = true;
					                        
					                    case 6 % Format.CLASS
					                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					
					                    case 7 % Format.CLASSLIST
					                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					                        
					                    case 8 % Format.ITEM
					                        columneditable(c) = false;
					                        
					                    case 9 % Format.ITEMLIST
					                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					
					                    case 10 % Format.IDICT
					                        columneditable(c) = false;
					                        
					                    case 11 % Format.SCALAR
					                        columneditable(c) = true;
					                        
					                    case {12 13 14 15} % {Format.RVECTOR Format.CVECTOR Format.MATRIX Format.SMATRIX}
					                        columneditable(c) = false;
					                        
					                    case 16 % Format.CELL
					                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					
					                    case 17 % Format.NET
					                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					                        
					                    case 18 % Format.HANDLE
					                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					
					                    case 19 % Format.HANDLELIST
					                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					
					                    case 20 % Format.COLOR
					                        columneditable(c) = true;
					                        
					                    case 21 % Format.ALPHA
					                        columneditable(c) = true;
					                        
					                    case 22 % Format.SIZE
					                        columneditable(c) = true;
					                        
					                    case 23 % Format.MARKER
					                        columneditable(c) = true;
					                        
					                    case 24 % Format.LINE
					                        columneditable(c) = true;
					                end
					            end
					        end
					    end
					    
					    value = columneditable;
					end
					
					% ensures that the value is numeric (not logical)
					value = int8(columneditable);
					
				case 43 % PanelPropItemList.COLUMNFORMAT
					if isempty(value)
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    it_class = el.getPropSettings(prop);
					    
					    cols = pr.memorize('COLS');
					
					    columnformat = repmat({''}, 1, length(cols));
					    for c = 1:1:length(cols)
					        col = cols(c);
					        if col == pr.SELECTOR
					            columnformat{c} = 'logical';
					        elseif Element.existsProp(it_class, col) % prop = col;
					            switch Element.getPropFormat(it_class, col)
					                case 1 % Format.EMPTY
					                    warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					
					                case 2 % Format.STRING
					                    columnformat{c} = 'char';
					
					                case 3 % Format.STRINGLIST
					                    warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					
					                case 4 % Format.LOGICAL
					                    columnformat{c} = 'logical';
					
					                case 5 % Format.OPTION
					                    columnformat{c} = Element.getPropSettings(it_class, col);
					
					                case 6 % Format.CLASS
					                    warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					
					                case 7 % Format.CLASSLIST
					                    warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					
					                case 8 % Format.ITEM
					                    columnformat{c} = 'char';
					
					                case 9 % Format.ITEMLIST
					                    warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					
					                case 10 % Format.IDICT
					                    columnformat{c} = 'char';
					
					                case 11 % Format.SCALAR
					                    columnformat{c} = 'numeric';
					
					                case {12 13 14 15} % {Format.RVECTOR Format.CVECTOR Format.MATRIX Format.SMATRIX}
					                    columnformat{c} = 'char';
					
					                case 16 % Format.CELL
					                    warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					
					                case 17 % Format.NET
					                    warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					
					                case 18 % Format.HANDLE
					                    warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					
					                case 19 % Format.HANDLELIST
					                    warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					
					                case 20 % Format.COLOR
					                    columnformat{c} = 'char';
					
					                case 21 % Format.ALPHA
					                    columnformat{c} = 'numeric';
					
					                case 22 % Format.SIZE
					                    columnformat{c} = 'numeric';
					
					                case 23 % Format.MARKER
					                    columnformat{c} = Element.getPropSettings(it_class, col);
					
					                case 24 % Format.LINE
					                    columnformat{c} = Element.getPropSettings(it_class, col);
					            end            
					        end
					    end
					    
					    value = columnformat;
					end
					
					for i = 1:1:length(value)
					    if iscell(value{i})
					        value{i} = cell2str(value{i});
					    end
					end
					
				otherwise
					if prop <= 35
						value = preset@PanelProp(pr, prop, value);
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
			%  CHECK = Element.CHECKPROP(PanelPropItemList, PROP, VALUE) checks VALUE format for PROP of PanelPropItemList.
			%  CHECK = PR.CHECKPROP(PanelPropItemList, PROP, VALUE) checks VALUE format for PROP of PanelPropItemList.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:PanelPropItemList:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:PanelPropItemList:WrongInput
			%  Element.CHECKPROP(PanelPropItemList, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropItemList.
			%   Error id: BRAPH2:PanelPropItemList:WrongInput
			%  PR.CHECKPROP(PanelPropItemList, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropItemList.
			%   Error id: BRAPH2:PanelPropItemList:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropItemList.getPropProp(pointer);
			
			switch prop
				case 36 % PanelPropItemList.TABLE_HEIGHT
					check = Format.checkFormat(22, value, PanelPropItemList.getPropSettings(prop));
				case 37 % PanelPropItemList.SELECTED
					check = Format.checkFormat(13, value, PanelPropItemList.getPropSettings(prop));
				case 38 % PanelPropItemList.COLS
					check = Format.checkFormat(12, value, PanelPropItemList.getPropSettings(prop));
				case 39 % PanelPropItemList.ROWNAME
					check = Format.checkFormat(3, value, PanelPropItemList.getPropSettings(prop));
				case 40 % PanelPropItemList.COLUMNNAME
					check = Format.checkFormat(3, value, PanelPropItemList.getPropSettings(prop));
				case 41 % PanelPropItemList.COLUMNWIDTH
					check = Format.checkFormat(3, value, PanelPropItemList.getPropSettings(prop));
				case 42 % PanelPropItemList.COLUMNEDITABLE
					check = Format.checkFormat(12, value, PanelPropItemList.getPropSettings(prop));
				case 43 % PanelPropItemList.COLUMNFORMAT
					check = Format.checkFormat(3, value, PanelPropItemList.getPropSettings(prop));
				case 44 % PanelPropItemList.CB_TAB_EDIT
					check = Format.checkFormat(2, value, PanelPropItemList.getPropSettings(prop));
				case 45 % PanelPropItemList.TABLE
					check = Format.checkFormat(18, value, PanelPropItemList.getPropSettings(prop));
				case 46 % PanelPropItemList.MENU_OPEN_ITEMS
					check = Format.checkFormat(4, value, PanelPropItemList.getPropSettings(prop));
				case 47 % PanelPropItemList.MENU_EXPORT
					check = Format.checkFormat(4, value, PanelPropItemList.getPropSettings(prop));
				case 48 % PanelPropItemList.CONTEXTMENU
					check = Format.checkFormat(18, value, PanelPropItemList.getPropSettings(prop));
				case 49 % PanelPropItemList.GUI_ITS_DICT
					check = Format.checkFormat(10, value, PanelPropItemList.getPropSettings(prop));
				case 4 % PanelPropItemList.TEMPLATE
					check = Format.checkFormat(8, value, PanelPropItemList.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropItemList:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropItemList:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropItemList.getPropTag(prop) ' (' PanelPropItemList.getFormatTag(PanelPropItemList.getPropFormat(prop)) ').'] ...
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
				case 45 % PanelPropItemList.TABLE
					table = uitable( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'table', ...
					    'FontSize', 12, ...
					    'ColumnSortable', true, ...
					    'CellEditCallback', {@cb_table} ...
					    );
					value = table;
					
				case 48 % PanelPropItemList.CONTEXTMENU
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					it_class = el.getPropSettings(prop);
					    
					contextmenu = uicontextmenu( ...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_select_all = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_SELECT_ALL', ...
					    'Text', 'Select All', ...
					    'MenuSelectedFcn', {@cb_select_all} ...
					    );
					menu_clear_selection = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_CLEAR_SELECTION', ...
					    'Text', 'Clear Selection', ...
					    'MenuSelectedFcn', {@cb_clear_selection} ...
					    );
					menu_invert_selection = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_INVERT_SELECTION', ...
					    'Text', 'Invert Selection', ...
					    'MenuSelectedFcn', {@cb_invert_selection} ...
					    );
					menu_apply_to_selection = uimenu( ...
					    'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_APPLY_TO_SELECTION', ...
					    'Text', 'Apply to Selection', ...
					    'Checked', false ...
					    );
					set(menu_apply_to_selection, ...
					    'MenuSelectedFcn', {@cb_apply_to_selection, menu_apply_to_selection} ...
					    );
					if pr.get('MENU_OPEN_ITEMS')
					    menu_open_selection = uimenu( ...
					        'Separator', 'on', ...
					        'Parent', contextmenu, ...
					        'Tag', 'MENU_OPEN_SELECTION', ...
					        'Text', 'Open Selection', ...
					        'MenuSelectedFcn', {@cb_open_selection} ...
					        );
					    menu_hide_selection = uimenu( ...
					        'Parent', contextmenu, ...
					        'Tag', 'MENU_HIDE_SELECTION', ...
					        'Text', 'Hide Selection', ...
					        'MenuSelectedFcn', {@cb_hide_selection} ...
					        );
					    menu_hide_all = uimenu( ...
					        'Parent', contextmenu, ...
					        'Tag', 'MENU_HIDE_ALL', ...
					        'Text', 'Hide All', ...
					        'MenuSelectedFcn', {@cb_hide_all} ...
					        );
					end
					if (isempty(pr.get('COLS')) && any(cellfun(@(prop) isequal(Element.getPropFormat(it_class, prop), 20), num2cell(Element.getProps(it_class))))) ...
					        || any(cellfun(@(prop) prop > 0 && isequal(Element.getPropFormat(it_class, prop), 20), num2cell(pr.get('COLS'))))
					    menu_colorize_table = uimenu( ...
					        'Separator', 'on', ...
					        'Parent', contextmenu, ...
					        'Tag', 'MENU_COLORIZE_TABLE', ...
					        'Text', 'Colorize Table', ...
					        'Checked', false ...
					        );
						set(menu_colorize_table, ...
					        'MenuSelectedFcn', {@cb_colorize_table, menu_colorize_table} ...
					        );
					end
					if pr.get('MENU_EXPORT')
					    menu_export_to_xls = uimenu( ...
					        'Separator', 'on', ...
					        'Parent', contextmenu, ...
					        'Tag', 'MENU_EXPORT_TO_XLS', ...
					        'Text', 'Export to XLS', ...
					        'MenuSelectedFcn', {@cb_export_to_xls});
					end
					if isempty(pr.get('COLS')) || ismember(pr.SELECTOR, pr.get('COLS'))
					    set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					end
					
					value = contextmenu;
					
				case 20 % PanelPropItemList.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value 
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					end
					
				case 21 % PanelPropItemList.UPDATE
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value 
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if any(el.getPropCategory(prop) == [5 6 7]) && isa(el.getr(prop), 'NoValue')
					        pr.set('HEIGHT', 24)
					    else
					        it_list = el.get(prop);
					        pr.set('HEIGHT', min(54 + 24 * length(it_list), pr.get('TABLE_HEIGHT')))
					    end
					
					    switch el.getPropCategory(prop)
					        case 1 % Category.CONSTANT
					            set_table()
					            set(pr.get('TABLE'), 'ColumnEditable', false)
					            
					        case 2 % Category.METADATA
					            set_table()
					
					            if el.isLocked(prop)
					                set(pr.get('TABLE'), 'ColumnEditable', false)
					            end
					        case {3 4 8 9} % {Category.PARAMETER Category.DATA Category.FIGURE Category.GUI}
					            set_table()
					            
					            if el.isLocked(prop)
					                set(pr.get('TABLE'), 'ColumnEditable', false)
					            end
					            
					            prop_value = el.getr(prop);
					            if isa(prop_value, 'Callback')
					                set(pr.get('TABLE'), 'ColumnEditable', false)
					            end
					
					        case {5 6 7} % {Category.RESULT Category.QUERY Category.EVANESCENT}
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                % don't plot anything for a result not yet calculated
					                set(pr.get('TABLE'), 'Visible', 'off')
					            else
					                set_table()
					                set(pr.get('TABLE'), 'Visible', 'on')
					            end
					    end
					end
					
				case 22 % PanelPropItemList.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [4 4 w_p-8 max(1, pr.get('HEIGHT')-27)])
					end
					
				case 16 % PanelPropItemList.SHOW
					value = calculateValue@PanelProp(pr, 16, varargin{:}); % also warning
					if value
					    % figures for items
					    gui_its_dict = pr.get('GUI_ITS_DICT');
					    for i = 1:1:gui_its_dict.get('LENGTH')
					        gui = gui_its_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					end
					
				case 17 % PanelPropItemList.HIDE
					value = calculateValue@PanelProp(pr, 17, varargin{:}); % also warning
					if value    
					    % figures for items
					    gui_its_dict = pr.get('GUI_ITS_DICT');
					    for i = 1:1:gui_its_dict.get('LENGTH')
					        gui = gui_its_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					end
					
				case 18 % PanelPropItemList.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					end
					
				case 19 % PanelPropItemList.CLOSE
					value = calculateValue@PanelProp(pr, 19, varargin{:}); % also warning
					if value
					    % figures for items
					    gui_its_dict = pr.get('GUI_ITS_DICT');
					    for i = 1:1:gui_its_dict.get('LENGTH')
					        gui = gui_its_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('CLOSE')
					        end
					    end
					end
					
				otherwise
					if prop <= 35
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_table(~, event) % (src, event)
			    menu_apply_to_selection = findobj(pr.get('CONTEXTMENU'), 'Tag', 'MENU_APPLY_TO_SELECTION');
				if ~get(menu_apply_to_selection, 'Checked')
			        cols = pr.get('COLS');
			        cb_table_edit(event.Indices(1), cols(event.Indices(2)), event.NewData)
			    else
			        cols = pr.get('COLS');
			
			        % adds current item to selected
			        if cols(event.Indices(2)) == pr.SELECTOR
			            cb_table_edit(event.Indices(1), pr.SELECTOR, event.NewData)
			        else
			            cb_table_edit(event.Indices(1), pr.SELECTOR, true)
			        end
			
			        % updates all selected
			        selected = pr.get('SELECTED');
			        for s = 1:1:length(selected)
			            cb_table_edit(selected(s), cols(event.Indices(2)), event.NewData)
			        end
				end
			
			    pr.get('UPDATE') % placed here for numerical efficiency
			
			    function cb_table_edit(i, col, newdata)
			
			        el = pr.get('EL');
			        prop = pr.get('PROP');
			        
			        it_class = el.getPropSettings(prop);
			        
			        if ~isempty(pr.get('CB_TAB_EDIT'))
			            eval(pr.get('CB_TAB_EDIT'))
			        else
			            cb_table_edit_default()
			        end
			        function cb_table_edit_default()
			            if col == pr.SELECTOR
			                selected = pr.get('SELECTED');
			                if newdata == 1
			                    pr.set('SELECTED', sort(unique([selected; i])));
			                else
			                    pr.set('SELECTED', selected(selected ~= i));
			                end
			            elseif Element.existsProp(it_class, col) % prop = col;
			                switch Element.getPropFormat(it_class, col)
			                    case 1 % Format.EMPTY
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			    
			                    case 2 % Format.STRING
			                        dict.get('IT', i).set(col, newdata)
			                        
			                    case 3 % Format.STRINGLIST
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			
			                    case 4 % Format.LOGICAL
			                        dict.get('IT', i).set(col, newdata)
			    
			                    case 5 % Format.OPTION
			                        dict.get('IT', i).set(col, newdata)
			    
			                    case 6 % Format.CLASS
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			    
			                    case 7 % Format.CLASSLIST
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			    
			                    case 8 % Format.ITEM
			                        %
			    
			                    case 9 % Format.ITEMLIST
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			    
			                    case 10 % Format.IDICT
			                        %
			    
			                    case 11 % Format.SCALAR % Format.SCALAR
			                        dict.get('IT', i).set(col, newdata)
			    
			                    case {12 13 14 15} % {Format.RVECTOR Format.CVECTOR Format.MATRIX Format.SMATRIX}
			                        %
			    
			                    case 16 % Format.CELL
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			    
			                    case 17 % Format.NET
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			    
			                    case 18 % Format.HANDLE
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			
			                    case 19 % Format.HANDLELIST
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			
			                    case 20 % Format.COLOR
			                        try
			                            rgb = [hex2dec(newdata(1:2))/255 hex2dec(newdata(3:4))/255 hex2dec(newdata(5:6))/255];
			                            dict.get('IT', i).set(col, rgb)
			                        catch
			                            %
			                        end
			    
			                    case 21 % Format.ALPHA
			                        dict.get('IT', i).set(col, min(abs(newdata), 1))
			    
			                    case 22 % Format.SIZE
			                        if newdata ~= 0
			                            dict.get('IT', i).set(col, abs(newdata))
			                        end
			    
			                    case 23 % Format.MARKER
			                        dict.get('IT', i).set(col, newdata)
			    
			                    case 24 % Format.LINE
			                        dict.get('IT', i).set(col, newdata)
			                end
			            end        
			        end
			        
			    % pr.get('UPDATE') % placed above for numerical efficiency
			    end
			
			end
			function cb_select_all(~, ~) 
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    it_list = el.get(prop);
			
			    pr.set('SELECTED', [1:1:length(it_list)])
			
			    pr.get('UPDATE')
			end
			function cb_clear_selection(~, ~) 
			    pr.set('SELECTED', [])
			
			    pr.get('UPDATE')
			end
			function cb_invert_selection(~, ~) 
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    it_list = el.get(prop);
			
			    selected_tmp = [1:1:length(it_list)];
			    selected_tmp(pr.get('SELECTED')) = [];
			    pr.set('SELECTED', selected_tmp)
			
			    pr.get('UPDATE')
			end
			function cb_apply_to_selection(~, ~, menu_apply_to_selection) 
			    if get(menu_apply_to_selection, 'Checked')
			        set(menu_apply_to_selection, 'Checked', false)
			    else
			        set(menu_apply_to_selection, 'Checked', true)
				end
			end
			function cb_open_selection(~, ~) 
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    it_list = el.get(prop);
			
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(it_list))); % number of row and columns of figures
			    selected = pr.get('SELECTED');
			
			    gui_its_dict = pr.memorize('GUI_ITS_DICT');
			    
			    for s = 1:1:length(selected)
			        i = selected(s);
			
			        it = it_list{i};
			        key = int2str(i);
			        
			        if ~gui_its_dict.get('CONTAINS_KEY', key)
			            gui = GUIElement( ...
			                'ID', key, ... % the key is the position number of the item in the list
			                'PE', it, ... 
			                'POSITION', [ ...
			                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
			                    y0(f, 'normalized') ... % y = f_gr_y / screen_h;
			                    w(f, 'normalized') ... % w = f_gr_w / screen_w;
			                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
			                    ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_its_dict.get('ADD', gui)
			        end
			        
			        gui = gui_its_dict.get('IT', key);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			        gui.get('SHOW')
			    end
			end
			function cb_hide_selection(~, ~) 
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    selected = pr.get('SELECTED');
			    
			    gui_its_dict = pr.memorize('GUI_ITS_DICT');
			
			    for s = 1:1:length(selected)
			        key = int2str(selected(s));
			        
			        if gui_its_dict.get('CONTAINS_KEY', key)
			            gui = gui_its_dict.get('IT', key);
			            gui.get('HIDE')
			        end
			    end
			end
			function cb_hide_all(~, ~) 
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    it_list = el.get(prop);
			
			    gui_its_dict = pr.memorize('GUI_ITS_DICT');
			
			    for i = 1:1:length(it_list)
			        
			        key = int2str(i);
			        
			        if gui_its_dict.get('CONTAINS_KEY', key)
			            gui = gui_its_dict.get('IT', key);
			            gui.get('HIDE')
			        end
			    end
			end
			function cb_colorize_table(~, ~, menu_colorize_table)
			    if get(menu_colorize_table, 'Checked')
			        set(menu_colorize_table, 'Checked', false)
			    else
			        set(menu_colorize_table, 'Checked', true)
			    end
			    pr.get('UPDATE')
			end
			function cb_export_to_xls(~, ~)
			    if isempty(pr.get('SELECTED'))
			        el = pr.get('EL');
			        prop = pr.get('PROP');
			        dict = el.get(prop);
			
			        selected = [1:1:dict.get('LENGTH')];
			    else
			        selected = pr.get('SELECTED');
			    end
			    
			    % create data table
			    data = pr.get('TABLE').Data(selected, :);
			    columns = pr.get('TABLE').ColumnName;
			    rows = pr.get('TABLE').RowName;
			    % special rules: selection column, numbered rownames.
			    if isempty(columns{1})
			        columns{1} = 'sel';
			    end
			    if isequal(rows, 'numbered')
			        rows = cellfun(@(x) num2str(x), num2cell(selected), 'UniformOutput', false)';
			    elseif length(selected) ~= length(rows)
			        rows = rows(reshape(selected, [1 length(selected)]));
			    end
			    
			    t = cell2table(data, ...
			        'VariableNames', columns, ...
			        'RowNames', rows);
			
			    % save file
			    [filename, filepath, filterindex] = uiputfile({'*.xlsx';'*.xls'}, 'Select Excel file');
			    if filterindex
			        file = [filepath filename];
			        writetable(t, file, 'WriteRowNames', true);
			    end
			end
			function set_table()
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    it_list = el.get(prop);
			    it_class = el.getPropSettings(prop);
			
			    % columns to be to be shown in the table
			    % col = pr.SELECTOR for the selector column
			    % col = prop for the prop columns
			    if isempty(pr.get('COLS')) % empty pr.get('COLS')
			        pr.set('COLS', pr.get('COLS'))
			    end
				cols = pr.memorize('COLS');
			
			    % data
				data = cell(length(it_list), length(cols));
			    for i = 1:1:length(it_list)
			        for c = 1:1:length(cols)
			            col = cols(c);
			            if col == pr.SELECTOR
			                if any(pr.get('SELECTED') == i)
			                    data{i, c} = true;
			                else
			                    data{i, c} = false;
			                end
			            elseif Element.existsProp(it_class, col) % prop = col;
			                switch Element.getPropFormat(it_class, col)
			                    case 1 % Format.EMPTY
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			                    
			                    case 2 % Format.STRING
			                        data{i, c} = it_list{i}.get(col);
			                        
			                    case 3 % Format.STRINGLIST
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			                    
			                    case 4 % Format.LOGICAL
			                        data{i, c} = it_list{i}.get(col);
			                        
			                    case 5 % Format.OPTION
			                        data{i, c} = it_list{i}.get(col);
			                        
			                    case 6 % Format.CLASS
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			
			                    case 7 % Format.CLASSLIST
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			                        
			                    case 8 % Format.ITEM
			                        data{i, c} = it_list{i}.get(col).get('TOSTRING');
			                        
			                    case 9 % Format.ITEMLIST
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			
			                    case 10 % Format.IDICT
			                        data{i, c} = it_list{i}.get(col).get('TOSTRING');
			                        
			                    case 11 % Format.SCALAR
			                        data{i, c} = it_list{i}.get(col);
			                        
			                    case {12 13 14 15} % {Format.RVECTOR Format.CVECTOR Format.MATRIX Format.SMATRIX}
			                        prop_value = it_list{i}.get(col);
			                        data{i, c} = [int2str(size(prop_value, 1)) ' x ' int2str(size(prop_value, 2))];
			                        
			                    case 16 % Format.CELL
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			
			                    case 17 % Format.NET
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			                        
			                    case 18 % Format.HANDLE
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			
			                    case 19 % Format.HANDLELIST
			                        warning([BRAPH2.STR ':PanelPropItemList'], [BRAPH2.STR ':PanelPropItemList \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
			
			                    case 20 % Format.COLOR
			                        rgb = it_list{i}.get(col);
			                        data{i, c} = [dec2hex(round(rgb(1) * 255), 2) dec2hex(round(rgb(2) * 255), 2) dec2hex(round(rgb(3) * 255), 2)];
			                        
			                    case 21 % Format.ALPHA
			                        data{i, c} = it_list{i}.get(col);
			                        
			                    case 22 % Format.SIZE
			                        data{i, c} = it_list{i}.get(col);
			                        
			                    case 23 % Format.MARKER
			                        data{i, c} = it_list{i}.get(col);
			                        
			                    case 24 % Format.LINE
			                        data{i, c} = it_list{i}.get(col);
			                end
			            end
			        end
			    end
			    
			    % rowname: string list or {'numbered'}
			    rowname = pr.memorize('ROWNAME');
			    if isempty(rowname)
			        pr.set('ROWNAME', rowname)
			        rowname = pr.memorize('ROWNAME'); % triggers preset
			    elseif isequal(rowname, {'numbered'})
			        rowname = 'numbered';
			    end
			    
			    % columnname: string list or {'numbered'}
			    columnname = pr.memorize('COLUMNNAME');
			    if isequal(columnname, {'numbered'})
			        columnname = 'numbered';
			    end
			
			    % columnwidth
			    columnwidth = pr.memorize('COLUMNWIDTH');
			    if isequal(columnwidth, {'auto'})
			        columnwidth = 'auto';
			    end
			
			    % columneditable
			    columneditable = logical(pr.memorize('COLUMNEDITABLE'));
			
			    % columnformat
				columnformat = pr.memorize('COLUMNFORMAT');
			    for i = 1:1:length(columnformat)
			        columnformat_i_as_cell = str2cell(columnformat{i});
			        if length(columnformat_i_as_cell) ~= 1
			            columnformat{i} = columnformat_i_as_cell'; % ColumnFormat popupmenu definitions must be row vectors
			        end
			    end
			
			    set(pr.get('TABLE'), ...
			        'Data', data, ...
			        'RowName', rowname, ...
			        'ColumnName', columnname, ... 
			        'ColumnWidth', columnwidth, ...
			        'ColumnEditable', columneditable, ...
			        'ColumnFormat', columnformat ...
			        )
			
			    % style SELECTED
			    styles_row = find(pr.get('TABLE').StyleConfigurations.Target == 'row');
			    if ~isempty(styles_row)
			        removeStyle(pr.get('TABLE'), styles_row)
			    end
			    if ~isempty(pr.get('SELECTED'))
			        addStyle(pr.get('TABLE'), uistyle('FontWeight', 'bold'), 'row', pr.get('SELECTED'))
			    end
			        
			    % style COLOR
			    menu_colorize_table = findobj(pr.get('CONTEXTMENU'), 'Tag', 'MENU_COLORIZE_TABLE');
			    
			    styles_cell = find(pr.get('TABLE').StyleConfigurations.Target == 'cell');
			    if check_graphics(menu_colorize_table, 'uimenu') && get(menu_colorize_table, 'Checked')
			        if isempty(styles_cell)
			            for c = 1:1:length(cols)
			                col = cols(c);
			                if col > 0 && isequal(Element.getPropFormat(it_class, col), 20)                            
			                    for i = 1:1:dict.get('LENGTH')
			                        addStyle(pr.get('TABLE'), ...
			                            uistyle('FontColor', dict.get('IT', i).get(col)), ...
			                            'cell', [i, c] ...
			                            )
			                    end
			                end
			            end
			        else
			            for c = 1:1:length(cols)
			                col = cols(c);
			                if col > 0 && isequal(Element.getPropFormat(it_class, col), 20)
			                    for i = 1:1:dict.get('LENGTH')
			                        cell_to_be_removed = find(cellfun(@(x) isequal(x, [i, c]), pr.get('TABLE').StyleConfigurations.TargetIndex));
			                        if ~isempty(cell_to_be_removed)
			                            current_rgb = pr.get('TABLE').StyleConfigurations.Style(cell_to_be_removed).FontColor;
			                            new_rgb = dict.get('IT', i).get(col);
			                            if ~isequal(current_rgb, new_rgb)
			                                removeStyle(pr.get('TABLE'), cell_to_be_removed)
			                                addStyle(pr.get('TABLE'), ...
			                                    uistyle('FontColor', new_rgb), ...
			                                    'cell', [i, c] ...
			                                    )
			                            end
			                        end
			                    end
			                end
			            end
			        end
			    else
			        if ~isempty(styles_cell)
			            removeStyle(pr.get('TABLE'), styles_cell)
			        end
			    end
			end
		end
	end
end
