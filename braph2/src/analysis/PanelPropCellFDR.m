classdef PanelPropCellFDR < PanelProp
	%PanelPropCellFDR plots the panel of a prop cell with fdr values.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Cell Prop Panel (PanelPropCellFDR) plots the panel for a CELL prop with a table and two sliders.
	%   Paints of green color those cells that survive FDR correction. It works for all categories.
	% 
	% It can be personalized with the following props:
	%  TABLE_HEIGHT - Panel height in pixels when the table is shown.
	%  XSLIDERSHOW - Whether to show the x-slider.
	%  XSLIDERLABELS - Labels for the x-slider.
	%  XSLIDERHEIGHT - Height of x-slider in pixels.
	%  YSLIDERSHOW - Whether to show the y-slider.
	%  YSLIDERLABELS - Labels for the y-slider.
	%  YSLIDERWIDTH - Width of y-slider in pixels.
	%  XYSLIDERLOCK - Whether the sliders are locked so that only the diagonal is shown.
	%  ROWNAME - String list with row names (no names if empty; numbered if {'numbered'}). Dynamically updatable.
	%  COLUMNAME - String list with column names (no names if empty; numbered if {'numbered'}). Dynamically updatable.
	%  MENU_EXPORT - Whether to show the export menu. To be defined before drawing.
	%
	% The list of PanelPropCellFDR properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the cell prop panel.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the cell prop panel.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the cell prop panel.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the cell prop panel.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the cell prop panel.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the cell prop panel.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the cell prop panel.
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
	%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the prop panel.
	%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the table.
	%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.
	%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
	%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the prop number.
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
	%  <strong>36</strong> <strong>XSLIDERSHOW</strong> 	XSLIDERSHOW (gui, logical) determines whether to show the xslider.
	%  <strong>37</strong> <strong>XSLIDERLABELS</strong> 	XSLIDERLABELS (gui, stringlist) determines the xslider labels.
	%  <strong>38</strong> <strong>XSLIDERHEIGHT</strong> 	XSLIDERHEIGHT (gui, size) is the height below the xslider in font size units.
	%  <strong>39</strong> <strong>XSLIDER</strong> 	XSLIDER (evanescent, handle) is the x-slider.
	%  <strong>40</strong> <strong>YSLIDERSHOW</strong> 	YSLIDERSHOW (gui, logical) determines whether to show the yslider.
	%  <strong>41</strong> <strong>YSLIDERLABELS</strong> 	YSLIDERLABELS (gui, stringlist) determines the yslider labels.
	%  <strong>42</strong> <strong>YSLIDERWIDTH</strong> 	YSLIDERWIDTH (gui, size) is the width to the right of the yslider in font size units.
	%  <strong>43</strong> <strong>YSLIDER</strong> 	YSLIDER (evanescent, handle) is the y-slider.
	%  <strong>44</strong> <strong>XYSLIDERLOCK</strong> 	XYSLIDERLOCK (gui, logical) determines whether the sliders are locked so that only the diagonal is shown.
	%  <strong>45</strong> <strong>ENABLE</strong> 	ENABLE (gui, option) switches table between on and off.
	%  <strong>46</strong> <strong>ROWNAME</strong> 	ROWNAME (gui, stringlist) determines the table row names.
	%  <strong>47</strong> <strong>COLUMNNAME</strong> 	COLUMNNAME (gui, stringlist) determines the table column names.
	%  <strong>48</strong> <strong>MENU_EXPORT</strong> 	MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.
	%  <strong>49</strong> <strong>TABLE_HEIGHT</strong> 	TABLE_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.
	%  <strong>50</strong> <strong>TABLEQVALUE</strong> 	TABLEQVALUE (gui, scalar) is the mask value of the table use in fdr
	%  <strong>51</strong> <strong>TABLEFDR</strong> 	TABLEFDR (gui, logical) is the mask value of the table use in fdr
	%  <strong>52</strong> <strong>TABLE</strong> 	TABLE (evanescent, handle) is the alpha value edit field.
	%  <strong>53</strong> <strong>CONTEXTMENU</strong> 	CONTEXTMENU (evanescent, handle) is the context menu.
	%
	% PanelPropCellFDR methods (constructor):
	%  PanelPropCellFDR - constructor
	%
	% PanelPropCellFDR methods:
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
	% PanelPropCellFDR methods (display):
	%  tostring - string with information about the cell prop panel fdr
	%  disp - displays information about the cell prop panel fdr
	%  tree - displays the tree of the cell prop panel fdr
	%
	% PanelPropCellFDR methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two cell prop panel fdr are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the cell prop panel fdr
	%
	% PanelPropCellFDR methods (save/load, Static):
	%  save - saves BRAPH2 cell prop panel fdr as b2 file
	%  load - loads a BRAPH2 cell prop panel fdr from a b2 file
	%
	% PanelPropCellFDR method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the cell prop panel fdr
	%
	% PanelPropCellFDR method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the cell prop panel fdr
	%
	% PanelPropCellFDR methods (inspection, Static):
	%  getClass - returns the class of the cell prop panel fdr
	%  getSubclasses - returns all subclasses of PanelPropCellFDR
	%  getProps - returns the property list of the cell prop panel fdr
	%  getPropNumber - returns the property number of the cell prop panel fdr
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
	% PanelPropCellFDR methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropCellFDR methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropCellFDR methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropCellFDR methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropCellFDR; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropCellFDR constants</a>.
	%
	%
	% See also uitable, uislider, GUI, PanelElement.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		XSLIDERSHOW = 36; %CET: Computational Efficiency Trick
		XSLIDERSHOW_TAG = 'XSLIDERSHOW';
		XSLIDERSHOW_CATEGORY = 9;
		XSLIDERSHOW_FORMAT = 4;
		
		XSLIDERLABELS = 37; %CET: Computational Efficiency Trick
		XSLIDERLABELS_TAG = 'XSLIDERLABELS';
		XSLIDERLABELS_CATEGORY = 9;
		XSLIDERLABELS_FORMAT = 3;
		
		XSLIDERHEIGHT = 38; %CET: Computational Efficiency Trick
		XSLIDERHEIGHT_TAG = 'XSLIDERHEIGHT';
		XSLIDERHEIGHT_CATEGORY = 9;
		XSLIDERHEIGHT_FORMAT = 22;
		
		XSLIDER = 39; %CET: Computational Efficiency Trick
		XSLIDER_TAG = 'XSLIDER';
		XSLIDER_CATEGORY = 7;
		XSLIDER_FORMAT = 18;
		
		YSLIDERSHOW = 40; %CET: Computational Efficiency Trick
		YSLIDERSHOW_TAG = 'YSLIDERSHOW';
		YSLIDERSHOW_CATEGORY = 9;
		YSLIDERSHOW_FORMAT = 4;
		
		YSLIDERLABELS = 41; %CET: Computational Efficiency Trick
		YSLIDERLABELS_TAG = 'YSLIDERLABELS';
		YSLIDERLABELS_CATEGORY = 9;
		YSLIDERLABELS_FORMAT = 3;
		
		YSLIDERWIDTH = 42; %CET: Computational Efficiency Trick
		YSLIDERWIDTH_TAG = 'YSLIDERWIDTH';
		YSLIDERWIDTH_CATEGORY = 9;
		YSLIDERWIDTH_FORMAT = 22;
		
		YSLIDER = 43; %CET: Computational Efficiency Trick
		YSLIDER_TAG = 'YSLIDER';
		YSLIDER_CATEGORY = 7;
		YSLIDER_FORMAT = 18;
		
		XYSLIDERLOCK = 44; %CET: Computational Efficiency Trick
		XYSLIDERLOCK_TAG = 'XYSLIDERLOCK';
		XYSLIDERLOCK_CATEGORY = 9;
		XYSLIDERLOCK_FORMAT = 4;
		
		ENABLE = 45; %CET: Computational Efficiency Trick
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = 9;
		ENABLE_FORMAT = 5;
		
		ROWNAME = 46; %CET: Computational Efficiency Trick
		ROWNAME_TAG = 'ROWNAME';
		ROWNAME_CATEGORY = 9;
		ROWNAME_FORMAT = 3;
		
		COLUMNNAME = 47; %CET: Computational Efficiency Trick
		COLUMNNAME_TAG = 'COLUMNNAME';
		COLUMNNAME_CATEGORY = 9;
		COLUMNNAME_FORMAT = 3;
		
		MENU_EXPORT = 48; %CET: Computational Efficiency Trick
		MENU_EXPORT_TAG = 'MENU_EXPORT';
		MENU_EXPORT_CATEGORY = 9;
		MENU_EXPORT_FORMAT = 4;
		
		TABLE_HEIGHT = 49; %CET: Computational Efficiency Trick
		TABLE_HEIGHT_TAG = 'TABLE_HEIGHT';
		TABLE_HEIGHT_CATEGORY = 9;
		TABLE_HEIGHT_FORMAT = 22;
		
		TABLEQVALUE = 50; %CET: Computational Efficiency Trick
		TABLEQVALUE_TAG = 'TABLEQVALUE';
		TABLEQVALUE_CATEGORY = 9;
		TABLEQVALUE_FORMAT = 11;
		
		TABLEFDR = 51; %CET: Computational Efficiency Trick
		TABLEFDR_TAG = 'TABLEFDR';
		TABLEFDR_CATEGORY = 9;
		TABLEFDR_FORMAT = 4;
		
		TABLE = 52; %CET: Computational Efficiency Trick
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = 7;
		TABLE_FORMAT = 18;
		
		CONTEXTMENU = 53; %CET: Computational Efficiency Trick
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = 7;
		CONTEXTMENU_FORMAT = 18;
	end
	methods % constructor
		function pr = PanelPropCellFDR(varargin)
			%PanelPropCellFDR() creates a cell prop panel fdr.
			%
			% PanelPropCellFDR(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropCellFDR(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PanelPropCellFDR properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the cell prop panel.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the cell prop panel.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the cell prop panel.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the cell prop panel.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the cell prop panel.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the cell prop panel.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the cell prop panel.
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
			%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the prop panel.
			%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the table.
			%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.
			%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
			%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the prop number.
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
			%  <strong>36</strong> <strong>XSLIDERSHOW</strong> 	XSLIDERSHOW (gui, logical) determines whether to show the xslider.
			%  <strong>37</strong> <strong>XSLIDERLABELS</strong> 	XSLIDERLABELS (gui, stringlist) determines the xslider labels.
			%  <strong>38</strong> <strong>XSLIDERHEIGHT</strong> 	XSLIDERHEIGHT (gui, size) is the height below the xslider in font size units.
			%  <strong>39</strong> <strong>XSLIDER</strong> 	XSLIDER (evanescent, handle) is the x-slider.
			%  <strong>40</strong> <strong>YSLIDERSHOW</strong> 	YSLIDERSHOW (gui, logical) determines whether to show the yslider.
			%  <strong>41</strong> <strong>YSLIDERLABELS</strong> 	YSLIDERLABELS (gui, stringlist) determines the yslider labels.
			%  <strong>42</strong> <strong>YSLIDERWIDTH</strong> 	YSLIDERWIDTH (gui, size) is the width to the right of the yslider in font size units.
			%  <strong>43</strong> <strong>YSLIDER</strong> 	YSLIDER (evanescent, handle) is the y-slider.
			%  <strong>44</strong> <strong>XYSLIDERLOCK</strong> 	XYSLIDERLOCK (gui, logical) determines whether the sliders are locked so that only the diagonal is shown.
			%  <strong>45</strong> <strong>ENABLE</strong> 	ENABLE (gui, option) switches table between on and off.
			%  <strong>46</strong> <strong>ROWNAME</strong> 	ROWNAME (gui, stringlist) determines the table row names.
			%  <strong>47</strong> <strong>COLUMNNAME</strong> 	COLUMNNAME (gui, stringlist) determines the table column names.
			%  <strong>48</strong> <strong>MENU_EXPORT</strong> 	MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.
			%  <strong>49</strong> <strong>TABLE_HEIGHT</strong> 	TABLE_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.
			%  <strong>50</strong> <strong>TABLEQVALUE</strong> 	TABLEQVALUE (gui, scalar) is the mask value of the table use in fdr
			%  <strong>51</strong> <strong>TABLEFDR</strong> 	TABLEFDR (gui, logical) is the mask value of the table use in fdr
			%  <strong>52</strong> <strong>TABLE</strong> 	TABLE (evanescent, handle) is the alpha value edit field.
			%  <strong>53</strong> <strong>CONTEXTMENU</strong> 	CONTEXTMENU (evanescent, handle) is the context menu.
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the cell prop panel fdr.
			%
			% BUILD = PanelPropCellFDR.GETBUILD() returns the build of 'PanelPropCellFDR'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PR.GETBUILD() returns the build of the cell prop panel fdr PR.
			%  BUILD = Element.GETBUILD(PR) returns the build of 'PR'.
			%  BUILD = Element.GETBUILD('PanelPropCellFDR') returns the build of 'PanelPropCellFDR'.
			%
			% Note that the Element.GETBUILD(PR) and Element.GETBUILD('PanelPropCellFDR')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pr_class = getClass()
			%GETCLASS returns the class of the cell prop panel fdr.
			%
			% CLASS = PanelPropCellFDR.GETCLASS() returns the class 'PanelPropCellFDR'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the cell prop panel fdr PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropCellFDR') returns 'PanelPropCellFDR'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropCellFDR')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropCellFDR';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the cell prop panel fdr.
			%
			% LIST = PanelPropCellFDR.GETSUBCLASSES() returns all subclasses of 'PanelPropCellFDR'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the cell prop panel fdr PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropCellFDR') returns all subclasses of 'PanelPropCellFDR'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'PanelPropCellFDR' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of cell prop panel fdr.
			%
			% PROPS = PanelPropCellFDR.GETPROPS() returns the property list of cell prop panel fdr
			%  as a row vector.
			%
			% PROPS = PanelPropCellFDR.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the cell prop panel fdr PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropCellFDR'[, CATEGORY]) returns the property list of 'PanelPropCellFDR'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53];
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
					prop_list = [10 15 27 28 30 31 32 33 34 35 39 43 52 53];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36 37 38 40 41 42 44 45 46 47 48 49 50 51];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of cell prop panel fdr.
			%
			% N = PanelPropCellFDR.GETPROPNUMBER() returns the property number of cell prop panel fdr.
			%
			% N = PanelPropCellFDR.GETPROPNUMBER(CATEGORY) returns the property number of cell prop panel fdr
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the cell prop panel fdr PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropCellFDR') returns the property number of 'PanelPropCellFDR'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 53;
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
					prop_number = 14;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 18;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in cell prop panel fdr/error.
			%
			% CHECK = PanelPropCellFDR.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropCellFDR, PROP) checks whether PROP exists for PanelPropCellFDR.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropCellFDR:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropCellFDR:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropCellFDR:WrongInput]
			%  Element.EXISTSPROP(PanelPropCellFDR, PROP) throws error if PROP does NOT exist for PanelPropCellFDR.
			%   Error id: [BRAPH2:PanelPropCellFDR:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 53 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropCellFDR:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropCellFDR:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropCellFDR.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in cell prop panel fdr/error.
			%
			% CHECK = PanelPropCellFDR.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropCellFDR, TAG) checks whether TAG exists for PanelPropCellFDR.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropCellFDR:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropCellFDR:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropCellFDR:WrongInput]
			%  Element.EXISTSTAG(PanelPropCellFDR, TAG) throws error if TAG does NOT exist for PanelPropCellFDR.
			%   Error id: [BRAPH2:PanelPropCellFDR:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'XSLIDERSHOW'  'XSLIDERLABELS'  'XSLIDERHEIGHT'  'XSLIDER'  'YSLIDERSHOW'  'YSLIDERLABELS'  'YSLIDERWIDTH'  'YSLIDER'  'XYSLIDERLOCK'  'ENABLE'  'ROWNAME'  'COLUMNNAME'  'MENU_EXPORT'  'TABLE_HEIGHT'  'TABLEQVALUE'  'TABLEFDR'  'TABLE'  'CONTEXTMENU' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropCellFDR:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropCellFDR:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropCellFDR.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropCellFDR, POINTER) returns property number of POINTER of PanelPropCellFDR.
			%  PROPERTY = PR.GETPROPPROP(PanelPropCellFDR, POINTER) returns property number of POINTER of PanelPropCellFDR.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'XSLIDERSHOW'  'XSLIDERLABELS'  'XSLIDERHEIGHT'  'XSLIDER'  'YSLIDERSHOW'  'YSLIDERLABELS'  'YSLIDERWIDTH'  'YSLIDER'  'XYSLIDERLOCK'  'ENABLE'  'ROWNAME'  'COLUMNNAME'  'MENU_EXPORT'  'TABLE_HEIGHT'  'TABLEQVALUE'  'TABLEFDR'  'TABLE'  'CONTEXTMENU' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(PanelPropCellFDR, POINTER) returns tag of POINTER of PanelPropCellFDR.
			%  TAG = PR.GETPROPTAG(PanelPropCellFDR, POINTER) returns tag of POINTER of PanelPropCellFDR.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				panelpropcellfdr_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'XSLIDERSHOW'  'XSLIDERLABELS'  'XSLIDERHEIGHT'  'XSLIDER'  'YSLIDERSHOW'  'YSLIDERLABELS'  'YSLIDERWIDTH'  'YSLIDER'  'XYSLIDERLOCK'  'ENABLE'  'ROWNAME'  'COLUMNNAME'  'MENU_EXPORT'  'TABLE_HEIGHT'  'TABLEQVALUE'  'TABLEFDR'  'TABLE'  'CONTEXTMENU' };
				tag = panelpropcellfdr_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropCellFDR, POINTER) returns category of POINTER of PanelPropCellFDR.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropCellFDR, POINTER) returns category of POINTER of PanelPropCellFDR.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropCellFDR.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelpropcellfdr_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  9  9  7  9  9  9  7  9  9  9  9  9  9  9  9  7  7 };
			prop_category = panelpropcellfdr_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropCellFDR, POINTER) returns format of POINTER of PanelPropCellFDR.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropCellFDR, POINTER) returns format of POINTER of PanelPropCellFDR.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropCellFDR.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelpropcellfdr_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  4  3  22  18  4  3  22  18  4  5  3  3  4  22  11  4  18  18 };
			prop_format = panelpropcellfdr_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropCellFDR, POINTER) returns description of POINTER of PanelPropCellFDR.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropCellFDR, POINTER) returns description of POINTER of PanelPropCellFDR.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropCellFDR.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelpropcellfdr_description_list = { 'ELCLASS (constant, string) is the class of the cell prop panel.'  'NAME (constant, string) is the name of the cell prop panel.'  'DESCRIPTION (constant, string) is the description of the cell prop panel.'  'TEMPLATE (parameter, item) is the template of the cell prop panel.'  'ID (data, string) is a few-letter code for the cell prop panel.'  'LABEL (metadata, string) is an extended label of the cell prop panel.'  'NOTES (metadata, string) are some specific notes about the cell prop panel.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.'  'X_DRAW (query, logical) draws the prop panel.'  'UPDATE (query, logical) updates the content and permissions of the table.'  'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the prop number.'  'HEIGHT (gui, size) is the pixel height of the prop panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'XSLIDERSHOW (gui, logical) determines whether to show the xslider.'  'XSLIDERLABELS (gui, stringlist) determines the xslider labels.'  'XSLIDERHEIGHT (gui, size) is the height below the xslider in font size units.'  'XSLIDER (evanescent, handle) is the x-slider.'  'YSLIDERSHOW (gui, logical) determines whether to show the yslider.'  'YSLIDERLABELS (gui, stringlist) determines the yslider labels.'  'YSLIDERWIDTH (gui, size) is the width to the right of the yslider in font size units.'  'YSLIDER (evanescent, handle) is the y-slider.'  'XYSLIDERLOCK (gui, logical) determines whether the sliders are locked so that only the diagonal is shown.'  'ENABLE (gui, option) switches table between on and off.'  'ROWNAME (gui, stringlist) determines the table row names.'  'COLUMNNAME (gui, stringlist) determines the table column names.'  'MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.'  'TABLE_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.'  'TABLEQVALUE (gui, scalar) is the mask value of the table use in fdr'  'TABLEFDR (gui, logical) is the mask value of the table use in fdr'  'TABLE (evanescent, handle) is the alpha value edit field.'  'CONTEXTMENU (evanescent, handle) is the context menu.' };
			prop_description = panelpropcellfdr_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropCellFDR, POINTER) returns settings of POINTER of PanelPropCellFDR.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropCellFDR, POINTER) returns settings of POINTER of PanelPropCellFDR.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropCellFDR.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % PanelPropCellFDR.XSLIDERSHOW
					prop_settings = Format.getFormatSettings(4);
				case 37 % PanelPropCellFDR.XSLIDERLABELS
					prop_settings = Format.getFormatSettings(3);
				case 38 % PanelPropCellFDR.XSLIDERHEIGHT
					prop_settings = Format.getFormatSettings(22);
				case 39 % PanelPropCellFDR.XSLIDER
					prop_settings = Format.getFormatSettings(18);
				case 40 % PanelPropCellFDR.YSLIDERSHOW
					prop_settings = Format.getFormatSettings(4);
				case 41 % PanelPropCellFDR.YSLIDERLABELS
					prop_settings = Format.getFormatSettings(3);
				case 42 % PanelPropCellFDR.YSLIDERWIDTH
					prop_settings = Format.getFormatSettings(22);
				case 43 % PanelPropCellFDR.YSLIDER
					prop_settings = Format.getFormatSettings(18);
				case 44 % PanelPropCellFDR.XYSLIDERLOCK
					prop_settings = Format.getFormatSettings(4);
				case 45 % PanelPropCellFDR.ENABLE
					prop_settings = {'on', 'off'};
				case 46 % PanelPropCellFDR.ROWNAME
					prop_settings = Format.getFormatSettings(3);
				case 47 % PanelPropCellFDR.COLUMNNAME
					prop_settings = Format.getFormatSettings(3);
				case 48 % PanelPropCellFDR.MENU_EXPORT
					prop_settings = Format.getFormatSettings(4);
				case 49 % PanelPropCellFDR.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(22);
				case 50 % PanelPropCellFDR.TABLEQVALUE
					prop_settings = Format.getFormatSettings(11);
				case 51 % PanelPropCellFDR.TABLEFDR
					prop_settings = Format.getFormatSettings(4);
				case 52 % PanelPropCellFDR.TABLE
					prop_settings = Format.getFormatSettings(18);
				case 53 % PanelPropCellFDR.CONTEXTMENU
					prop_settings = Format.getFormatSettings(18);
				case 4 % PanelPropCellFDR.TEMPLATE
					prop_settings = 'PanelPropCellFDR';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropCellFDR.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropCellFDR.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropCellFDR, POINTER) returns the default value of POINTER of PanelPropCellFDR.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropCellFDR, POINTER) returns the default value of POINTER of PanelPropCellFDR.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropCellFDR.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % PanelPropCellFDR.XSLIDERSHOW
					prop_default = true;
				case 37 % PanelPropCellFDR.XSLIDERLABELS
					prop_default = Format.getFormatDefault(3, PanelPropCellFDR.getPropSettings(prop));
				case 38 % PanelPropCellFDR.XSLIDERHEIGHT
					prop_default = 36;
				case 39 % PanelPropCellFDR.XSLIDER
					prop_default = Format.getFormatDefault(18, PanelPropCellFDR.getPropSettings(prop));
				case 40 % PanelPropCellFDR.YSLIDERSHOW
					prop_default = true;
				case 41 % PanelPropCellFDR.YSLIDERLABELS
					prop_default = Format.getFormatDefault(3, PanelPropCellFDR.getPropSettings(prop));
				case 42 % PanelPropCellFDR.YSLIDERWIDTH
					prop_default = 36;
				case 43 % PanelPropCellFDR.YSLIDER
					prop_default = Format.getFormatDefault(18, PanelPropCellFDR.getPropSettings(prop));
				case 44 % PanelPropCellFDR.XYSLIDERLOCK
					prop_default = false;
				case 45 % PanelPropCellFDR.ENABLE
					prop_default = 'on';
				case 46 % PanelPropCellFDR.ROWNAME
					prop_default = {'numbered'};
				case 47 % PanelPropCellFDR.COLUMNNAME
					prop_default = {'numbered'};
				case 48 % PanelPropCellFDR.MENU_EXPORT
					prop_default = true;
				case 49 % PanelPropCellFDR.TABLE_HEIGHT
					prop_default = 240;
				case 50 % PanelPropCellFDR.TABLEQVALUE
					prop_default = 0.05;
				case 51 % PanelPropCellFDR.TABLEFDR
					prop_default = false;
				case 52 % PanelPropCellFDR.TABLE
					prop_default = Format.getFormatDefault(18, PanelPropCellFDR.getPropSettings(prop));
				case 53 % PanelPropCellFDR.CONTEXTMENU
					prop_default = Format.getFormatDefault(18, PanelPropCellFDR.getPropSettings(prop));
				case 1 % PanelPropCellFDR.ELCLASS
					prop_default = 'PanelPropCellFDR';
				case 2 % PanelPropCellFDR.NAME
					prop_default = 'Cell Prop Panel FDR';
				case 3 % PanelPropCellFDR.DESCRIPTION
					prop_default = 'A Cell Prop Panel (PanelPropCellFDR) plots the panel for a CELL prop with a table and two sliders. Paints of green color those cells that survive FDR correction. It works for all categories. It can be personalized with the following props: TABLE_HEIGHT, XSLIDERSHOW, XSLIDERLABELS, XSLIDERHEIGHT, YSLIDERSHOW, YSLIDERLABELS, YSLIDERHEIGHT, XYSLIDERLOCK, ROWNAME, COLUMNAME, MENU_EXPORT.';
				case 4 % PanelPropCellFDR.TEMPLATE
					prop_default = Format.getFormatDefault(8, PanelPropCellFDR.getPropSettings(prop));
				case 5 % PanelPropCellFDR.ID
					prop_default = 'PanelPropCellFDR ID';
				case 6 % PanelPropCellFDR.LABEL
					prop_default = 'PanelPropCellFDR label';
				case 7 % PanelPropCellFDR.NOTES
					prop_default = 'PanelPropCellFDR notes';
				case 23 % PanelPropCellFDR.EL
					prop_default = Graph();
				case 24 % PanelPropCellFDR.PROP
					prop_default = 26;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropCellFDR.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropCellFDR.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropCellFDR, POINTER) returns the conditioned default value of POINTER of PanelPropCellFDR.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropCellFDR, POINTER) returns the conditioned default value of POINTER of PanelPropCellFDR.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropCellFDR.getPropProp(pointer);
			
			prop_default = PanelPropCellFDR.conditioning(prop, PanelPropCellFDR.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropCellFDR, PROP, VALUE) checks VALUE format for PROP of PanelPropCellFDR.
			%  CHECK = PR.CHECKPROP(PanelPropCellFDR, PROP, VALUE) checks VALUE format for PROP of PanelPropCellFDR.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:PanelPropCellFDR:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:PanelPropCellFDR:WrongInput
			%  Element.CHECKPROP(PanelPropCellFDR, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropCellFDR.
			%   Error id: BRAPH2:PanelPropCellFDR:WrongInput
			%  PR.CHECKPROP(PanelPropCellFDR, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropCellFDR.
			%   Error id: BRAPH2:PanelPropCellFDR:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropCellFDR')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropCellFDR.getPropProp(pointer);
			
			switch prop
				case 36 % PanelPropCellFDR.XSLIDERSHOW
					check = Format.checkFormat(4, value, PanelPropCellFDR.getPropSettings(prop));
				case 37 % PanelPropCellFDR.XSLIDERLABELS
					check = Format.checkFormat(3, value, PanelPropCellFDR.getPropSettings(prop));
				case 38 % PanelPropCellFDR.XSLIDERHEIGHT
					check = Format.checkFormat(22, value, PanelPropCellFDR.getPropSettings(prop));
				case 39 % PanelPropCellFDR.XSLIDER
					check = Format.checkFormat(18, value, PanelPropCellFDR.getPropSettings(prop));
				case 40 % PanelPropCellFDR.YSLIDERSHOW
					check = Format.checkFormat(4, value, PanelPropCellFDR.getPropSettings(prop));
				case 41 % PanelPropCellFDR.YSLIDERLABELS
					check = Format.checkFormat(3, value, PanelPropCellFDR.getPropSettings(prop));
				case 42 % PanelPropCellFDR.YSLIDERWIDTH
					check = Format.checkFormat(22, value, PanelPropCellFDR.getPropSettings(prop));
				case 43 % PanelPropCellFDR.YSLIDER
					check = Format.checkFormat(18, value, PanelPropCellFDR.getPropSettings(prop));
				case 44 % PanelPropCellFDR.XYSLIDERLOCK
					check = Format.checkFormat(4, value, PanelPropCellFDR.getPropSettings(prop));
				case 45 % PanelPropCellFDR.ENABLE
					check = Format.checkFormat(5, value, PanelPropCellFDR.getPropSettings(prop));
				case 46 % PanelPropCellFDR.ROWNAME
					check = Format.checkFormat(3, value, PanelPropCellFDR.getPropSettings(prop));
				case 47 % PanelPropCellFDR.COLUMNNAME
					check = Format.checkFormat(3, value, PanelPropCellFDR.getPropSettings(prop));
				case 48 % PanelPropCellFDR.MENU_EXPORT
					check = Format.checkFormat(4, value, PanelPropCellFDR.getPropSettings(prop));
				case 49 % PanelPropCellFDR.TABLE_HEIGHT
					check = Format.checkFormat(22, value, PanelPropCellFDR.getPropSettings(prop));
				case 50 % PanelPropCellFDR.TABLEQVALUE
					check = Format.checkFormat(11, value, PanelPropCellFDR.getPropSettings(prop));
				case 51 % PanelPropCellFDR.TABLEFDR
					check = Format.checkFormat(4, value, PanelPropCellFDR.getPropSettings(prop));
				case 52 % PanelPropCellFDR.TABLE
					check = Format.checkFormat(18, value, PanelPropCellFDR.getPropSettings(prop));
				case 53 % PanelPropCellFDR.CONTEXTMENU
					check = Format.checkFormat(18, value, PanelPropCellFDR.getPropSettings(prop));
				case 4 % PanelPropCellFDR.TEMPLATE
					check = Format.checkFormat(8, value, PanelPropCellFDR.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropCellFDR:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropCellFDR:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropCellFDR.getPropTag(prop) ' (' PanelPropCellFDR.getFormatTag(PanelPropCellFDR.getPropFormat(prop)) ').'] ...
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
				case 46 % PanelPropCellFDR.ROWNAME
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				case 47 % PanelPropCellFDR.COLUMNNAME
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				otherwise
					if prop <= 35
						postset@PanelProp(pr, prop);
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
				case 39 % PanelPropCellFDR.XSLIDER
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					xslider = uislider( ...
					    'Parent', pr.get('H'), ...
					    'Tag', 'XSLIDER', ...
					    'MajorTicksMode', 'manual', ...
					    'MajorTickLabelsMode', 'manual', ...
					    'MinorTicksMode', 'manual', ...
					    'MinorTicks', [], ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_xslider} ...
					    );
					
					value = xslider;
					
				case 43 % PanelPropCellFDR.YSLIDER
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					yslider = uislider( ...
					    'Parent', pr.get('H'), ...
					    'Tag', 'YSLIDER', ...
					    'Orientation', 'vertical', ...
					    'MajorTicksMode', 'manual', ...
					    'MajorTickLabelsMode', 'manual', ...
					    'MinorTicksMode', 'manual', ...
					    'MinorTicks', [], ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_yslider} ...
					    );
					
					value = yslider;
					
				case 52 % PanelPropCellFDR.TABLE
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					table = uitable( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'TABLE', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'CellEditCallback', {@cb_table} ...
					    );
					
					value = table;
					
				case 53 % PanelPropCellFDR.CONTEXTMENU
					contextmenu = uicontextmenu(...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_export_to_xls = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_EXPORT_TO_XLS', ...
					    'Text', 'Export to XLS', ...
					    'MenuSelectedFcn', {@cb_export_to_xls} ...
					    );
					if pr.get('MENU_EXPORT')
					    set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					end
					value = contextmenu;
					
				case 20 % PanelPropCellFDR.X_DRAW
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					    pr.memorize('XSLIDER')
					    pr.memorize('YSLIDER')
					end
					
				case 21 % PanelPropCellFDR.UPDATE
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    if any(el.getPropCategory(prop) == [5 6 7]) && isa(el.getr(prop), 'NoValue')
					        pr.set('HEIGHT', 24)
					    else
					        pr.set('HEIGHT', pr.get('TABLE_HEIGHT'))
					    end
					    
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    % % % %TODO Add the management of the cases where the names are different for each cell
					    rowname = pr.get('ROWNAME');
					    if isequal(rowname, {'numbered'})
					        rowname = 'numbered';
					    end
					    columnname = pr.get('COLUMNNAME');
					    if isequal(columnname, {'numbered'})
					        columnname = 'numbered';
					    end
					    set(pr.get('TABLE'), ...
					        'RowName', rowname, ...
					        'ColumnName', columnname ...
					        );
					
					    if el.isLocked(prop)
					        set(pr.get('TABLE'), 'Enable', pr.get('ENABLE'))
					    end
					    
					    switch el.getPropCategory(prop)
					        case 1
					            set(pr.get('TABLE'), ...
					                'Data', set_sliders_and_get_value(), ...
					                'ColumnEditable', false ...
					                )
					            
					        case 2
					            set(pr.get('TABLE'), ...
					                'Data', set_sliders_and_get_value(), ...
					                'ColumnEditable', ~el.isLocked(prop) ...
					                )
					            
					        case {3, 4, 8, 9}
					            set(pr.get('TABLE'), ...
					                'Data', set_sliders_and_get_value(), ...
					                'ColumnEditable', ~el.isLocked(prop) ...
					                )
					            
					            prop_value = el.getr(prop);
					            if isa(prop_value, 'Callback')
					                set(pr.get('TABLE'), ...
					                    'Enable', pr.get('ENABLE'), ...
					                    'ColumnEditable', false ...
					                    )
					            end
					
					        case {5 6 7}
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                % don't plot anything for a result not yet calculated
					                set(pr.get('TABLE'), 'Visible', 'off')
					                set(pr.get('XSLIDER'), 'Visible', 'off')
					                set(pr.get('YSLIDER'), 'Visible', 'off')
					            else
					                set(pr.get('TABLE'), ...
					                    'Data', set_sliders_and_get_value(), ...
					                    'Enable', pr.get('ENABLE'), ...
					                    'ColumnEditable', false, ...
					                    'Visible', 'on' ...
					                    )
					            end
					    end
					
					    % fdr
					    tmp_val = get(pr.get('TABLE'), 'DATA');
					    if size(tmp_val, 2) == 1
					        tmp_val = tmp_val';
					    end
					    if pr.get('TABLEFDR')
					        [~, mask] = fdr(tmp_val, pr.get('TABLEQVALUE'));
					        s = uistyle("BackgroundColor", BRAPH2.COL_FDR);
					        if size(mask, 1) == 1
					            mask = mask';
					        end
					        [row, col] = find(mask);
					        addStyle(pr.get('TABLE'), s, "cell", [row, col]);
					    end
					end
					
				case 22 % PanelPropCellFDR.REDRAW
					value = calculateValue@PanelProp(pr, 22, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    if ~pr.get('XSLIDERSHOW') && ~pr.get('YSLIDERSHOW')
					        set(pr.get('TABLE'), 'Position', [4 4 max(1, w_p-8) max(1, pr.get('HEIGHT')-27)])
					    elseif pr.get('XSLIDERSHOW') && ~pr.get('YSLIDERSHOW')
					        set(pr.get('TABLE'), 'Position', [4 4 max(1, w_p-8) max(1, pr.get('HEIGHT')-27-pr.get('XSLIDERHEIGHT'))])
					        set(pr.get('XSLIDER'), 'Position', [4 max(1, pr.get('HEIGHT')-24-4) max(1, w_p-8) 3])
					    elseif ~pr.get('XSLIDERSHOW') && pr.get('YSLIDERSHOW')
					        set(pr.get('TABLE'), 'Position', [4+pr.get('YSLIDERWIDTH') 4 max(1, w_p-8-pr.get('YSLIDERWIDTH')) max(1, pr.get('HEIGHT')-27)])
					        set(pr.get('YSLIDER'), 'Position', [4 4 3 max(1, pr.get('HEIGHT')-27)])
					    else % pr.get('XSLIDERSHOW') && pr.get('YSLIDERSHOW')
					        set(pr.get('TABLE'), 'Position', [4+pr.get('YSLIDERWIDTH') 4 max(1, w_p-8-pr.get('YSLIDERWIDTH')) max(1, pr.get('HEIGHT')-27-pr.get('XSLIDERHEIGHT'))])
					        set(pr.get('XSLIDER'), 'Position', [4+pr.get('YSLIDERWIDTH') max(1, pr.get('HEIGHT')-24-4) max(1, w_p-8-pr.get('YSLIDERWIDTH')) 3])
					        set(pr.get('YSLIDER'), 'Position', [4 4 3 max(1, pr.get('HEIGHT')-27-8-pr.get('XSLIDERHEIGHT'))])
					    end
					end
					
				case 18 % PanelPropCellFDR.DELETE
					value = calculateValue@PanelProp(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					    pr.set('XSLIDER', Element.getNoValue())
					    pr.set('YSLIDER', Element.getNoValue())
					end
					
				otherwise
					if prop <= 35
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_xslider(~, ~)
			    set(pr.get('XSLIDER'), 'Value', round(get(pr.get('XSLIDER'), 'Value')))
			    
			    pr.get('UPDATE')
			end
			function cb_yslider(~, ~)
			    set(pr.get('YSLIDER'), 'Value', round(get(pr.get('YSLIDER'), 'Value')))
			    
			    if pr.get('XYSLIDERLOCK')
			        el = pr.get('EL');
			        prop = pr.get('PROP');
			        value = el.get(prop);
			        [R, C] = size(value);
			        
			        C = max(C, 1); % to manage the case in which C = R = 0 (empty cell)
			
			        set(pr.get('XSLIDER'), 'Value', C + 1 - get(pr.get('YSLIDER'), 'Value'))
			    end
			
			    pr.get('UPDATE')
			end
			function cb_table(~, event)
			    i = event.Indices(1);
			    j = event.Indices(2); 
			    newdata = event.NewData;
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    value = el.get(prop);
			    [R, C] = size(value);
			    
			    r = R + 1 - get(pr.get('YSLIDER'), 'Value');
			    c = get(pr.get('XSLIDER'), 'Value');
			    
			    value_rc = value{r, c};
			    value_rc(i, j) = newdata;
			    value{r, c} = value_rc;
			    el.set(prop, value)
			end
			function cb_export_to_xls(~, ~)
			    table = pr.get('TABLE');
			    data = table.Data;
			    
			    columns = table.ColumnName;
			    if isempty(columns)
			        columns = cellfun(@(x) ['Column ' num2str(x)], num2cell([1:1:size(data, 2)]), 'UniformOutput', false);
			    elseif isequal(columns, 'numbered')
			        columns = cellfun(@(x) num2str(x), num2cell([1:1:size(data, 2)]), 'UniformOutput', false);
			    end
			    
			    rows = table.RowName;
			    if isempty(rows)
			        rows = cellfun(@(x) ['Column ' num2str(x)], num2cell([1:1:size(data, 1)]), 'UniformOutput', false);
			    elseif isequal(rows, 'numbered')
			        rows = cellfun(@(x) num2str(x), num2cell([1:1:size(data, 1)]), 'UniformOutput', false);
			    end
			    
			    t = cell2table([rows, num2cell(data)], ...
			        'VariableNames', [' '; columns] ...
			        );
			
			    % save file
			    [filename, filepath, filterindex] = uiputfile({'*.xlsx';'*.xls'}, 'Select Excel file');
			    if filterindex
			        file = [filepath filename];
			        writetable(t, file, 'WriteRowNames', true);
			    end
			end
			function value = set_sliders_and_get_value()
			    value = el.get(prop);
			    if isempty(value)
			        set(pr.get('XSLIDER'), ...
			            'Limits', [.6 1.4], ...
			            'MajorTicks', [1], ...
			            'MajorTickLabels', {}, ...
			            'Value', 1, ...
			            'Visible', pr.get('XSLIDERSHOW') ...
			            )
			        set(pr.get('YSLIDER'), ...
			            'Limits', [.6 1.4], ...
			            'MajorTicks', [1], ...
			            'MajorTickLabels', {}, ...
			            'Value', 1, ...
			            'Visible', pr.get('YSLIDERSHOW') ...
			            )
			    else
			        [R, C] = size(value);
			        set(pr.get('XSLIDER'), ...
			            'Limits', [.6 C+.4], ...
			            'MajorTicks', [1:1:C], ...
			            'MajorTickLabels', pr.get('XSLIDERLABELS'), ...
			            'Value', max(1, min(round(get(pr.get('XSLIDER'), 'Value'), C))), ...
			            'Visible', pr.get('XSLIDERSHOW') ...
			            )
			        set(pr.get('YSLIDER'), ...
			            'Limits', [.6 R+.4], ...
			            'MajorTicks', [1:1:R], ...
			            'MajorTickLabels', flip(pr.get('YSLIDERLABELS')), ...
			            'Value', max(1, min(round(get(pr.get('YSLIDER'), 'Value'), R))), ...
			            'Visible', pr.get('YSLIDERSHOW') ...
			            )
			
			        if pr.get('XYSLIDERLOCK')
			            set(pr.get('YSLIDER'), 'Value', R + 1 - get(pr.get('XSLIDER'), 'Value'))
			        end
			
			        value = value{R + 1 - get(pr.get('YSLIDER'), 'Value'), get(pr.get('XSLIDER'), 'Value')};
			    end
			end
		end
	end
end
