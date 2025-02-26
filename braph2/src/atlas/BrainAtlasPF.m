classdef BrainAtlasPF < BrainSurfacePF
	%BrainAtlasPF is a panel to manage the plot of a brain atlas.
	% It is a subclass of <a href="matlab:help BrainSurfacePF">BrainSurfacePF</a>.
	%
	% A Panel Figure for Brain Atlas (BrainAtlasPF) manages the plot of the brain 
	%  regions symbols, spheres, ids and labels. 
	% BrainAtlasPF utilizes the surface created from BrainSurfacePF to integrate 
	%  the regions to a brain surface.
	%
	% The list of BrainAtlasPF properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel figure for brain atlas.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel figure for brain atlas.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel figure for brain atlas.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel figure for brain atlas.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel figure for brain atlas.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel figure for brain atlas.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel figure for brain atlas.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the panel figure for brain atlas.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel figure for brain atlas is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel.
	%  <strong>20</strong> <strong>ST_POSITION</strong> 	ST_POSITION (figure, item) determines the panel position.
	%  <strong>21</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.
	%  <strong>22</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the panel figure for brain atlas.
	%  <strong>23</strong> <strong>H_AXES</strong> 	H_AXES (evanescent, handle) is the handle for the axes.
	%  <strong>24</strong> <strong>VIEW</strong> 	VIEW (figure, rvector) sets the desired view as the line-of-sight azimuth and elevation angles.
	%  <strong>25</strong> <strong>ST_AXIS</strong> 	ST_AXIS (figure, item) determines the axis settings.
	%  <strong>26</strong> <strong>LISTENER_ST_AXIS</strong> 	LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.
	%  <strong>27</strong> <strong>SURFFILE</strong> 	SURFFILE (figure, option) is the name of the file of the brain surface to be plotted.
	%  <strong>28</strong> <strong>SURF</strong> 	SURF (metadata, item) is the brain surface to be plotted.
	%  <strong>29</strong> <strong>H_BRAIN</strong> 	H_BRAIN (evanescent, handle) is the handle for brain surface.
	%  <strong>30</strong> <strong>BRAIN</strong> 	BRAIN (figure, logical) determines whether the brain surface is shown.
	%  <strong>31</strong> <strong>ST_SURFACE</strong> 	ST_SURFACE (figure, item) determines the surface settings.
	%  <strong>32</strong> <strong>ST_AMBIENT</strong> 	ST_AMBIENT (figure, item) determines the ambient settings.
	%  <strong>33</strong> <strong>BA</strong> 	BA (metadata, item) is the brain atlas with the brain regions.
	%  <strong>34</strong> <strong>H_SPHS</strong> 	H_SPHS (evanescent, handlelist) is the set of handles for the spheres.
	%  <strong>35</strong> <strong>SPHS</strong> 	SPHS (figure, logical) determines whether the spheres are shown.
	%  <strong>36</strong> <strong>SPH_DICT</strong> 	SPH_DICT (figure, idict) contains the spheres of the brain regions.
	%  <strong>37</strong> <strong>H_SYMS</strong> 	H_SYMS (evanescent, handlelist) is the set of handles for the symbols.
	%  <strong>38</strong> <strong>SYMS</strong> 	SYMS (figure, logical) determines whether the symbols are shown.
	%  <strong>39</strong> <strong>SYM_DICT</strong> 	SYM_DICT (figure, idict) contains the symbols of the brain regions.
	%  <strong>40</strong> <strong>H_IDS</strong> 	H_IDS (evanescent, handlelist) is the set of handles for the ids.
	%  <strong>41</strong> <strong>IDS</strong> 	IDS (figure, logical) determines whether the ids are shown.
	%  <strong>42</strong> <strong>ID_DICT</strong> 	ID_DICT (figure, idict) contains the ids of the brain regions.
	%  <strong>43</strong> <strong>H_LABS</strong> 	H_LABS (evanescent, handlelist) is the set of handles for the labels.
	%  <strong>44</strong> <strong>LABS</strong> 	LABS (figure, logical) determines whether the labels are shown.
	%  <strong>45</strong> <strong>LAB_DICT</strong> 	LAB_DICT (figure, idict) contains the labels of the brain regions.
	%
	% BrainAtlasPF methods (constructor):
	%  BrainAtlasPF - constructor
	%
	% BrainAtlasPF methods:
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
	% BrainAtlasPF methods (display):
	%  tostring - string with information about the panel figure for brain atlas
	%  disp - displays information about the panel figure for brain atlas
	%  tree - displays the tree of the panel figure for brain atlas
	%
	% BrainAtlasPF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for brain atlas are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for brain atlas
	%
	% BrainAtlasPF methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for brain atlas as b2 file
	%  load - loads a BRAPH2 panel figure for brain atlas from a b2 file
	%
	% BrainAtlasPF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for brain atlas
	%
	% BrainAtlasPF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for brain atlas
	%
	% BrainAtlasPF methods (inspection, Static):
	%  getClass - returns the class of the panel figure for brain atlas
	%  getSubclasses - returns all subclasses of BrainAtlasPF
	%  getProps - returns the property list of the panel figure for brain atlas
	%  getPropNumber - returns the property number of the panel figure for brain atlas
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
	% BrainAtlasPF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% BrainAtlasPF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% BrainAtlasPF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% BrainAtlasPF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?BrainAtlasPF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">BrainAtlasPF constants</a>.
	%
	%
	% See also BrainAtlas, BrainSurface.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		BA = 33; %CET: Computational Efficiency Trick
		BA_TAG = 'BA';
		BA_CATEGORY = 2;
		BA_FORMAT = 8;
		
		H_SPHS = 34; %CET: Computational Efficiency Trick
		H_SPHS_TAG = 'H_SPHS';
		H_SPHS_CATEGORY = 7;
		H_SPHS_FORMAT = 19;
		
		SPHS = 35; %CET: Computational Efficiency Trick
		SPHS_TAG = 'SPHS';
		SPHS_CATEGORY = 8;
		SPHS_FORMAT = 4;
		
		SPH_DICT = 36; %CET: Computational Efficiency Trick
		SPH_DICT_TAG = 'SPH_DICT';
		SPH_DICT_CATEGORY = 8;
		SPH_DICT_FORMAT = 10;
		
		H_SYMS = 37; %CET: Computational Efficiency Trick
		H_SYMS_TAG = 'H_SYMS';
		H_SYMS_CATEGORY = 7;
		H_SYMS_FORMAT = 19;
		
		SYMS = 38; %CET: Computational Efficiency Trick
		SYMS_TAG = 'SYMS';
		SYMS_CATEGORY = 8;
		SYMS_FORMAT = 4;
		
		SYM_DICT = 39; %CET: Computational Efficiency Trick
		SYM_DICT_TAG = 'SYM_DICT';
		SYM_DICT_CATEGORY = 8;
		SYM_DICT_FORMAT = 10;
		
		H_IDS = 40; %CET: Computational Efficiency Trick
		H_IDS_TAG = 'H_IDS';
		H_IDS_CATEGORY = 7;
		H_IDS_FORMAT = 19;
		
		IDS = 41; %CET: Computational Efficiency Trick
		IDS_TAG = 'IDS';
		IDS_CATEGORY = 8;
		IDS_FORMAT = 4;
		
		ID_DICT = 42; %CET: Computational Efficiency Trick
		ID_DICT_TAG = 'ID_DICT';
		ID_DICT_CATEGORY = 8;
		ID_DICT_FORMAT = 10;
		
		H_LABS = 43; %CET: Computational Efficiency Trick
		H_LABS_TAG = 'H_LABS';
		H_LABS_CATEGORY = 7;
		H_LABS_FORMAT = 19;
		
		LABS = 44; %CET: Computational Efficiency Trick
		LABS_TAG = 'LABS';
		LABS_CATEGORY = 8;
		LABS_FORMAT = 4;
		
		LAB_DICT = 45; %CET: Computational Efficiency Trick
		LAB_DICT_TAG = 'LAB_DICT';
		LAB_DICT_CATEGORY = 8;
		LAB_DICT_FORMAT = 10;
	end
	methods % constructor
		function pf = BrainAtlasPF(varargin)
			%BrainAtlasPF() creates a panel figure for brain atlas.
			%
			% BrainAtlasPF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% BrainAtlasPF(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of BrainAtlasPF properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel figure for brain atlas.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel figure for brain atlas.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel figure for brain atlas.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel figure for brain atlas.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel figure for brain atlas.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel figure for brain atlas.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel figure for brain atlas.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the panel figure for brain atlas.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel figure for brain atlas is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel.
			%  <strong>20</strong> <strong>ST_POSITION</strong> 	ST_POSITION (figure, item) determines the panel position.
			%  <strong>21</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.
			%  <strong>22</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the panel figure for brain atlas.
			%  <strong>23</strong> <strong>H_AXES</strong> 	H_AXES (evanescent, handle) is the handle for the axes.
			%  <strong>24</strong> <strong>VIEW</strong> 	VIEW (figure, rvector) sets the desired view as the line-of-sight azimuth and elevation angles.
			%  <strong>25</strong> <strong>ST_AXIS</strong> 	ST_AXIS (figure, item) determines the axis settings.
			%  <strong>26</strong> <strong>LISTENER_ST_AXIS</strong> 	LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.
			%  <strong>27</strong> <strong>SURFFILE</strong> 	SURFFILE (figure, option) is the name of the file of the brain surface to be plotted.
			%  <strong>28</strong> <strong>SURF</strong> 	SURF (metadata, item) is the brain surface to be plotted.
			%  <strong>29</strong> <strong>H_BRAIN</strong> 	H_BRAIN (evanescent, handle) is the handle for brain surface.
			%  <strong>30</strong> <strong>BRAIN</strong> 	BRAIN (figure, logical) determines whether the brain surface is shown.
			%  <strong>31</strong> <strong>ST_SURFACE</strong> 	ST_SURFACE (figure, item) determines the surface settings.
			%  <strong>32</strong> <strong>ST_AMBIENT</strong> 	ST_AMBIENT (figure, item) determines the ambient settings.
			%  <strong>33</strong> <strong>BA</strong> 	BA (metadata, item) is the brain atlas with the brain regions.
			%  <strong>34</strong> <strong>H_SPHS</strong> 	H_SPHS (evanescent, handlelist) is the set of handles for the spheres.
			%  <strong>35</strong> <strong>SPHS</strong> 	SPHS (figure, logical) determines whether the spheres are shown.
			%  <strong>36</strong> <strong>SPH_DICT</strong> 	SPH_DICT (figure, idict) contains the spheres of the brain regions.
			%  <strong>37</strong> <strong>H_SYMS</strong> 	H_SYMS (evanescent, handlelist) is the set of handles for the symbols.
			%  <strong>38</strong> <strong>SYMS</strong> 	SYMS (figure, logical) determines whether the symbols are shown.
			%  <strong>39</strong> <strong>SYM_DICT</strong> 	SYM_DICT (figure, idict) contains the symbols of the brain regions.
			%  <strong>40</strong> <strong>H_IDS</strong> 	H_IDS (evanescent, handlelist) is the set of handles for the ids.
			%  <strong>41</strong> <strong>IDS</strong> 	IDS (figure, logical) determines whether the ids are shown.
			%  <strong>42</strong> <strong>ID_DICT</strong> 	ID_DICT (figure, idict) contains the ids of the brain regions.
			%  <strong>43</strong> <strong>H_LABS</strong> 	H_LABS (evanescent, handlelist) is the set of handles for the labels.
			%  <strong>44</strong> <strong>LABS</strong> 	LABS (figure, logical) determines whether the labels are shown.
			%  <strong>45</strong> <strong>LAB_DICT</strong> 	LAB_DICT (figure, idict) contains the labels of the brain regions.
			%
			% See also Category, Format.
			
			pf = pf@BrainSurfacePF(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the panel figure for brain atlas.
			%
			% BUILD = BrainAtlasPF.GETBUILD() returns the build of 'BrainAtlasPF'.
			%
			% Alternative forms to call this method are:
			%  BUILD = PF.GETBUILD() returns the build of the panel figure for brain atlas PF.
			%  BUILD = Element.GETBUILD(PF) returns the build of 'PF'.
			%  BUILD = Element.GETBUILD('BrainAtlasPF') returns the build of 'BrainAtlasPF'.
			%
			% Note that the Element.GETBUILD(PF) and Element.GETBUILD('BrainAtlasPF')
			%  are less computationally efficient.
			
			build = 1;
		end
		function pf_class = getClass()
			%GETCLASS returns the class of the panel figure for brain atlas.
			%
			% CLASS = BrainAtlasPF.GETCLASS() returns the class 'BrainAtlasPF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for brain atlas PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('BrainAtlasPF') returns 'BrainAtlasPF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('BrainAtlasPF')
			%  are less computationally efficient.
			
			pf_class = 'BrainAtlasPF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for brain atlas.
			%
			% LIST = BrainAtlasPF.GETSUBCLASSES() returns all subclasses of 'BrainAtlasPF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for brain atlas PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('BrainAtlasPF') returns all subclasses of 'BrainAtlasPF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'BrainAtlasPF'  'NNxMLP_FeatureImportanceBrainSurfacePF'  'NNxMLP_FeatureImportanceBrainSurfacePF_BB'  'NNxMLP_FeatureImportanceBrainSurfacePF_BS'  'NNxMLP_FeatureImportanceBrainSurfacePF_BU'  'NNxMLP_FeatureImportanceBrainSurfacePF_GB'  'NNxMLP_FeatureImportanceBrainSurfacePF_GS'  'NNxMLP_FeatureImportanceBrainSurfacePF_GU'  'NNxMLP_FeatureImportanceBrainSurfacePF_NB'  'NNxMLP_FeatureImportanceBrainSurfacePF_NS'  'NNxMLP_FeatureImportanceBrainSurfacePF_NU'  'ComparisonEnsembleBrainPF'  'ComparisonEnsembleBrainPF_BB'  'ComparisonEnsembleBrainPF_BS'  'ComparisonEnsembleBrainPF_BU'  'ComparisonEnsembleBrainPF_GB'  'ComparisonEnsembleBrainPF_GS'  'ComparisonEnsembleBrainPF_GU'  'ComparisonEnsembleBrainPF_NB'  'ComparisonEnsembleBrainPF_NS'  'ComparisonEnsembleBrainPF_NU'  'ComparisonGroupBrainPF'  'ComparisonGroupBrainPF_BB'  'ComparisonGroupBrainPF_BS'  'ComparisonGroupBrainPF_BU'  'ComparisonGroupBrainPF_GB'  'ComparisonGroupBrainPF_GS'  'ComparisonGroupBrainPF_GU'  'ComparisonGroupBrainPF_NB'  'ComparisonGroupBrainPF_NS'  'ComparisonGroupBrainPF_NU'  'MeasureEnsembleBrainPF'  'MeasureEnsembleBrainPF_BB'  'MeasureEnsembleBrainPF_BS'  'MeasureEnsembleBrainPF_BU'  'MeasureEnsembleBrainPF_GB'  'MeasureEnsembleBrainPF_GS'  'MeasureEnsembleBrainPF_GU'  'MeasureEnsembleBrainPF_NB'  'MeasureEnsembleBrainPF_NS'  'MeasureEnsembleBrainPF_NU'  'MeasureGroupBrainPF'  'MeasureGroupBrainPF_BB'  'MeasureGroupBrainPF_BS'  'MeasureGroupBrainPF_BU'  'MeasureGroupBrainPF_GB'  'MeasureGroupBrainPF_GS'  'MeasureGroupBrainPF_GU'  'MeasureGroupBrainPF_NB'  'MeasureGroupBrainPF_NS'  'MeasureGroupBrainPF_NU' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for brain atlas.
			%
			% PROPS = BrainAtlasPF.GETPROPS() returns the property list of panel figure for brain atlas
			%  as a row vector.
			%
			% PROPS = BrainAtlasPF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for brain atlas PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('BrainAtlasPF'[, CATEGORY]) returns the property list of 'BrainAtlasPF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 28 33];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = 5;
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 21 22 23 26 29 34 37 40 43];
				case 8 % Category.FIGURE
					prop_list = [14 20 24 25 27 30 31 32 35 36 38 39 41 42 44 45];
				case 9 % Category.GUI
					prop_list = [9 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for brain atlas.
			%
			% N = BrainAtlasPF.GETPROPNUMBER() returns the property number of panel figure for brain atlas.
			%
			% N = BrainAtlasPF.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for brain atlas
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for brain atlas PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('BrainAtlasPF') returns the property number of 'BrainAtlasPF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 45;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 4;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 7;
				case 7 % Category.EVANESCENT
					prop_number = 11;
				case 8 % Category.FIGURE
					prop_number = 16;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for brain atlas/error.
			%
			% CHECK = BrainAtlasPF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(BrainAtlasPF, PROP) checks whether PROP exists for BrainAtlasPF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:BrainAtlasPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:BrainAtlasPF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:BrainAtlasPF:WrongInput]
			%  Element.EXISTSPROP(BrainAtlasPF, PROP) throws error if PROP does NOT exist for BrainAtlasPF.
			%   Error id: [BRAPH2:BrainAtlasPF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 45 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BrainAtlasPF:' 'WrongInput'], ...
					['BRAPH2' ':BrainAtlasPF:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for BrainAtlasPF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for brain atlas/error.
			%
			% CHECK = BrainAtlasPF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(BrainAtlasPF, TAG) checks whether TAG exists for BrainAtlasPF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:BrainAtlasPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:BrainAtlasPF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:BrainAtlasPF:WrongInput]
			%  Element.EXISTSTAG(BrainAtlasPF, TAG) throws error if TAG does NOT exist for BrainAtlasPF.
			%   Error id: [BRAPH2:BrainAtlasPF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'VIEW'  'ST_AXIS'  'LISTENER_ST_AXIS'  'SURFFILE'  'SURF'  'H_BRAIN'  'BRAIN'  'ST_SURFACE'  'ST_AMBIENT'  'BA'  'H_SPHS'  'SPHS'  'SPH_DICT'  'H_SYMS'  'SYMS'  'SYM_DICT'  'H_IDS'  'IDS'  'ID_DICT'  'H_LABS'  'LABS'  'LAB_DICT' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BrainAtlasPF:' 'WrongInput'], ...
					['BRAPH2' ':BrainAtlasPF:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for BrainAtlasPF.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(BrainAtlasPF, POINTER) returns property number of POINTER of BrainAtlasPF.
			%  PROPERTY = PF.GETPROPPROP(BrainAtlasPF, POINTER) returns property number of POINTER of BrainAtlasPF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'VIEW'  'ST_AXIS'  'LISTENER_ST_AXIS'  'SURFFILE'  'SURF'  'H_BRAIN'  'BRAIN'  'ST_SURFACE'  'ST_AMBIENT'  'BA'  'H_SPHS'  'SPHS'  'SPH_DICT'  'H_SYMS'  'SYMS'  'SYM_DICT'  'H_IDS'  'IDS'  'ID_DICT'  'H_LABS'  'LABS'  'LAB_DICT' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(BrainAtlasPF, POINTER) returns tag of POINTER of BrainAtlasPF.
			%  TAG = PF.GETPROPTAG(BrainAtlasPF, POINTER) returns tag of POINTER of BrainAtlasPF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				brainatlaspf_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'VIEW'  'ST_AXIS'  'LISTENER_ST_AXIS'  'SURFFILE'  'SURF'  'H_BRAIN'  'BRAIN'  'ST_SURFACE'  'ST_AMBIENT'  'BA'  'H_SPHS'  'SPHS'  'SPH_DICT'  'H_SYMS'  'SYMS'  'SYM_DICT'  'H_IDS'  'IDS'  'ID_DICT'  'H_LABS'  'LABS'  'LAB_DICT' };
				tag = brainatlaspf_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(BrainAtlasPF, POINTER) returns category of POINTER of BrainAtlasPF.
			%  CATEGORY = PF.GETPROPCATEGORY(BrainAtlasPF, POINTER) returns category of POINTER of BrainAtlasPF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = BrainAtlasPF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			brainatlaspf_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  8  7  7  7  8  8  7  8  2  7  8  8  8  2  7  8  8  7  8  8  7  8  8  7  8  8 };
			prop_category = brainatlaspf_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(BrainAtlasPF, POINTER) returns format of POINTER of BrainAtlasPF.
			%  FORMAT = PF.GETPROPFORMAT(BrainAtlasPF, POINTER) returns format of POINTER of BrainAtlasPF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = BrainAtlasPF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			brainatlaspf_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  8  18  19  18  12  8  18  5  8  18  4  8  8  8  19  4  10  19  4  10  19  4  10  19  4  10 };
			prop_format = brainatlaspf_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(BrainAtlasPF, POINTER) returns description of POINTER of BrainAtlasPF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(BrainAtlasPF, POINTER) returns description of POINTER of BrainAtlasPF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = BrainAtlasPF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			brainatlaspf_description_list = { 'ELCLASS (constant, string) is the class of the panel figure for brain atlas.'  'NAME (constant, string) is the name of the panel figure for brain atlas.'  'DESCRIPTION (constant, string) is the description of the panel figure for brain atlas.'  'TEMPLATE (parameter, item) is the template of the panel figure for brain atlas.'  'ID (data, string) is a few-letter code for the panel figure for brain atlas.'  'LABEL (metadata, string) is an extended label of the panel figure for brain atlas.'  'NOTES (metadata, string) are some specific notes about the panel figure for brain atlas.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the panel figure for brain atlas.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel.'  'HIDE (query, logical) hides the figure containing the panel.'  'DELETE (query, logical) resets the handles when the panel figure for brain atlas is deleted.'  'CLOSE (query, logical) closes the figure containing the panel.'  'ST_POSITION (figure, item) determines the panel position.'  'H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.'  'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the panel figure for brain atlas.'  'H_AXES (evanescent, handle) is the handle for the axes.'  'VIEW (figure, rvector) sets the desired view as the line-of-sight azimuth and elevation angles.'  'ST_AXIS (figure, item) determines the axis settings.'  'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.'  'SURFFILE (figure, option) is the name of the file of the brain surface to be plotted.'  'SURF (metadata, item) is the brain surface to be plotted.'  'H_BRAIN (evanescent, handle) is the handle for brain surface.'  'BRAIN (figure, logical) determines whether the brain surface is shown.'  'ST_SURFACE (figure, item) determines the surface settings.'  'ST_AMBIENT (figure, item) determines the ambient settings.'  'BA (metadata, item) is the brain atlas with the brain regions.'  'H_SPHS (evanescent, handlelist) is the set of handles for the spheres.'  'SPHS (figure, logical) determines whether the spheres are shown.'  'SPH_DICT (figure, idict) contains the spheres of the brain regions.'  'H_SYMS (evanescent, handlelist) is the set of handles for the symbols.'  'SYMS (figure, logical) determines whether the symbols are shown.'  'SYM_DICT (figure, idict) contains the symbols of the brain regions.'  'H_IDS (evanescent, handlelist) is the set of handles for the ids.'  'IDS (figure, logical) determines whether the ids are shown.'  'ID_DICT (figure, idict) contains the ids of the brain regions.'  'H_LABS (evanescent, handlelist) is the set of handles for the labels.'  'LABS (figure, logical) determines whether the labels are shown.'  'LAB_DICT (figure, idict) contains the labels of the brain regions.' };
			prop_description = brainatlaspf_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(BrainAtlasPF, POINTER) returns settings of POINTER of BrainAtlasPF.
			%  SETTINGS = PF.GETPROPSETTINGS(BrainAtlasPF, POINTER) returns settings of POINTER of BrainAtlasPF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = BrainAtlasPF.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 33 % BrainAtlasPF.BA
					prop_settings = 'BrainAtlas';
				case 34 % BrainAtlasPF.H_SPHS
					prop_settings = Format.getFormatSettings(19);
				case 35 % BrainAtlasPF.SPHS
					prop_settings = Format.getFormatSettings(4);
				case 36 % BrainAtlasPF.SPH_DICT
					prop_settings = 'SettingsSphere';
				case 37 % BrainAtlasPF.H_SYMS
					prop_settings = Format.getFormatSettings(19);
				case 38 % BrainAtlasPF.SYMS
					prop_settings = Format.getFormatSettings(4);
				case 39 % BrainAtlasPF.SYM_DICT
					prop_settings = 'SettingsSymbol';
				case 40 % BrainAtlasPF.H_IDS
					prop_settings = Format.getFormatSettings(19);
				case 41 % BrainAtlasPF.IDS
					prop_settings = Format.getFormatSettings(4);
				case 42 % BrainAtlasPF.ID_DICT
					prop_settings = 'SettingsText';
				case 43 % BrainAtlasPF.H_LABS
					prop_settings = Format.getFormatSettings(19);
				case 44 % BrainAtlasPF.LABS
					prop_settings = Format.getFormatSettings(4);
				case 45 % BrainAtlasPF.LAB_DICT
					prop_settings = 'SettingsText';
				case 4 % BrainAtlasPF.TEMPLATE
					prop_settings = 'BrainAtlasPF';
				otherwise
					prop_settings = getPropSettings@BrainSurfacePF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = BrainAtlasPF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainAtlasPF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(BrainAtlasPF, POINTER) returns the default value of POINTER of BrainAtlasPF.
			%  DEFAULT = PF.GETPROPDEFAULT(BrainAtlasPF, POINTER) returns the default value of POINTER of BrainAtlasPF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BrainAtlasPF.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 33 % BrainAtlasPF.BA
					prop_default = Format.getFormatDefault(8, BrainAtlasPF.getPropSettings(prop));
				case 34 % BrainAtlasPF.H_SPHS
					prop_default = Format.getFormatDefault(19, BrainAtlasPF.getPropSettings(prop));
				case 35 % BrainAtlasPF.SPHS
					prop_default = true;
				case 36 % BrainAtlasPF.SPH_DICT
					prop_default = Format.getFormatDefault(10, BrainAtlasPF.getPropSettings(prop));
				case 37 % BrainAtlasPF.H_SYMS
					prop_default = Format.getFormatDefault(19, BrainAtlasPF.getPropSettings(prop));
				case 38 % BrainAtlasPF.SYMS
					prop_default = false;
				case 39 % BrainAtlasPF.SYM_DICT
					prop_default = Format.getFormatDefault(10, BrainAtlasPF.getPropSettings(prop));
				case 40 % BrainAtlasPF.H_IDS
					prop_default = Format.getFormatDefault(19, BrainAtlasPF.getPropSettings(prop));
				case 41 % BrainAtlasPF.IDS
					prop_default = false;
				case 42 % BrainAtlasPF.ID_DICT
					prop_default = Format.getFormatDefault(10, BrainAtlasPF.getPropSettings(prop));
				case 43 % BrainAtlasPF.H_LABS
					prop_default = Format.getFormatDefault(19, BrainAtlasPF.getPropSettings(prop));
				case 44 % BrainAtlasPF.LABS
					prop_default = false;
				case 45 % BrainAtlasPF.LAB_DICT
					prop_default = Format.getFormatDefault(10, BrainAtlasPF.getPropSettings(prop));
				case 1 % BrainAtlasPF.ELCLASS
					prop_default = 'BrainAtlasPF';
				case 2 % BrainAtlasPF.NAME
					prop_default = 'Panel Figure for Brain Atlas';
				case 3 % BrainAtlasPF.DESCRIPTION
					prop_default = 'A Panel Figure for Brain Atlas (BrainAtlasPF) manages the plot of the brain regions symbols, spheres, ids and labels. BrainAtlasPF utilizes the surface created from BrainSurfacePF to integrate the regions to a brain surface.';
				case 4 % BrainAtlasPF.TEMPLATE
					prop_default = Format.getFormatDefault(8, BrainAtlasPF.getPropSettings(prop));
				case 5 % BrainAtlasPF.ID
					prop_default = 'BrainAtlasPF ID';
				case 6 % BrainAtlasPF.LABEL
					prop_default = 'BrainAtlasPF label';
				case 7 % BrainAtlasPF.NOTES
					prop_default = 'BrainAtlasPF notes';
				otherwise
					prop_default = getPropDefault@BrainSurfacePF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = BrainAtlasPF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainAtlasPF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(BrainAtlasPF, POINTER) returns the conditioned default value of POINTER of BrainAtlasPF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(BrainAtlasPF, POINTER) returns the conditioned default value of POINTER of BrainAtlasPF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = BrainAtlasPF.getPropProp(pointer);
			
			prop_default = BrainAtlasPF.conditioning(prop, BrainAtlasPF.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(BrainAtlasPF, PROP, VALUE) checks VALUE format for PROP of BrainAtlasPF.
			%  CHECK = PF.CHECKPROP(BrainAtlasPF, PROP, VALUE) checks VALUE format for PROP of BrainAtlasPF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:BrainAtlasPF:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: BRAPH2:BrainAtlasPF:WrongInput
			%  Element.CHECKPROP(BrainAtlasPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainAtlasPF.
			%   Error id: BRAPH2:BrainAtlasPF:WrongInput
			%  PF.CHECKPROP(BrainAtlasPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainAtlasPF.
			%   Error id: BRAPH2:BrainAtlasPF:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = BrainAtlasPF.getPropProp(pointer);
			
			switch prop
				case 33 % BrainAtlasPF.BA
					check = Format.checkFormat(8, value, BrainAtlasPF.getPropSettings(prop));
				case 34 % BrainAtlasPF.H_SPHS
					check = Format.checkFormat(19, value, BrainAtlasPF.getPropSettings(prop));
				case 35 % BrainAtlasPF.SPHS
					check = Format.checkFormat(4, value, BrainAtlasPF.getPropSettings(prop));
				case 36 % BrainAtlasPF.SPH_DICT
					check = Format.checkFormat(10, value, BrainAtlasPF.getPropSettings(prop));
				case 37 % BrainAtlasPF.H_SYMS
					check = Format.checkFormat(19, value, BrainAtlasPF.getPropSettings(prop));
				case 38 % BrainAtlasPF.SYMS
					check = Format.checkFormat(4, value, BrainAtlasPF.getPropSettings(prop));
				case 39 % BrainAtlasPF.SYM_DICT
					check = Format.checkFormat(10, value, BrainAtlasPF.getPropSettings(prop));
				case 40 % BrainAtlasPF.H_IDS
					check = Format.checkFormat(19, value, BrainAtlasPF.getPropSettings(prop));
				case 41 % BrainAtlasPF.IDS
					check = Format.checkFormat(4, value, BrainAtlasPF.getPropSettings(prop));
				case 42 % BrainAtlasPF.ID_DICT
					check = Format.checkFormat(10, value, BrainAtlasPF.getPropSettings(prop));
				case 43 % BrainAtlasPF.H_LABS
					check = Format.checkFormat(19, value, BrainAtlasPF.getPropSettings(prop));
				case 44 % BrainAtlasPF.LABS
					check = Format.checkFormat(4, value, BrainAtlasPF.getPropSettings(prop));
				case 45 % BrainAtlasPF.LAB_DICT
					check = Format.checkFormat(10, value, BrainAtlasPF.getPropSettings(prop));
				case 4 % BrainAtlasPF.TEMPLATE
					check = Format.checkFormat(8, value, BrainAtlasPF.getPropSettings(prop));
				otherwise
					if prop <= 32
						check = checkProp@BrainSurfacePF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BrainAtlasPF:' 'WrongInput'], ...
					['BRAPH2' ':BrainAtlasPF:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' BrainAtlasPF.getPropTag(prop) ' (' BrainAtlasPF.getFormatTag(BrainAtlasPF.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pf, prop)
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
				case 35 % BrainAtlasPF.SPHS
					if ~pf.get('SPHS') % false
					    h_sphs = pf.get('H_SPHS');
					    for i = 1:1:length(h_sphs)
					        set(h_sphs{i}, 'Visible', false)
					    end
					else % true
					    % triggers the update of SPH_DICT
					    pf.set('SPH_DICT', pf.get('SPH_DICT'))
					end
					
					% update state of toggle tool
					toolbar = pf.get('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    set(findobj(toolbar, 'Tag', 'TOOL.Sphs'), 'State', pf.get('SPHS'))
					end
					
				case 36 % BrainAtlasPF.SPH_DICT
					if pf.get('SPHS') && ~isa(pf.getr('BA'), 'NoValue')
					    
					    br_dict = pf.get('BA').get('BR_DICT');
					    
					    if pf.get('SPH_DICT').get('LENGTH') == 0 && br_dict.get('LENGTH')
					        for i = 1:1:br_dict.get('LENGTH')
					            br = br_dict.get('IT', i);
					            sphs{i} = SettingsSphere( ...
					                'PANEL', pf, ...
					                'PROP', 34, ...
					                'I', i, ...
					                'VISIBLE', true, ...
					                'ID', br.get('ID'), ... % Callback('EL', br, 'TAG', 'ID'), ...
					                'X', br.get('X'), ... % Callback('EL', br, 'TAG', 'X'), ...
					                'Y', br.get('Y'), ... % Callback('EL', br, 'TAG', 'Y'), ...
					                'Z', br.get('Z'), ... % Callback('EL', br, 'TAG', 'Z') ...
					                'FACECOLOR', [0.9 0.4 0.1], ...
					                'FACEALPHA', 1 ...
					                );
					        end
					        pf.get('SPH_DICT').set('IT_LIST', sphs)
					    end
					    
					    for i = 1:1:br_dict.get('LENGTH')
					        pf.get('SPH_DICT').get('IT', i).get('SETUP')
					    end
					    
					    % reset the ambient lighting
					    pf.get('ST_AMBIENT').get('SETUP')
					end
					
				case 38 % BrainAtlasPF.SYMS
					if ~pf.get('SYMS') % false
					    h_syms = pf.get('H_SYMS');
					    for i = 1:1:length(h_syms)
					        set(h_syms{i}, 'Visible', false)
					    end        
					else % true
					    % triggers the update of SYM_DICT
					    pf.set('SYM_DICT', pf.get('SYM_DICT'))
					end
					
					% update state of toggle tool
					toolbar = pf.get('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    set(findobj(toolbar, 'Tag', 'TOOL.Syms'), 'State', pf.get('SYMS'))
					end
					
				case 39 % BrainAtlasPF.SYM_DICT
					if pf.get('SYMS') && ~isa(pf.getr('BA'), 'NoValue')
					    
					    br_dict = pf.get('BA').get('BR_DICT');
					
						if pf.get('SYM_DICT').get('LENGTH') == 0 && br_dict.get('LENGTH')
					        for i = 1:1:br_dict.get('LENGTH')
					            br = br_dict.get('IT', i);
					            syms{i} = SettingsSymbol( ...
					                'PANEL', pf, ...
					                'PROP', 37, ...
					                'I', i, ...
					                'VISIBLE', true, ...
					                'ID', br.get('ID'), ... % Callback('EL', br, 'TAG', 'ID'), ...
					                'X', br.get('X'), ... % Callback('EL', br, 'TAG', 'X'), ...
					                'Y', br.get('Y'), ... % Callback('EL', br, 'TAG', 'Y'), ...
					                'Z', br.get('Z') ... % Callback('EL', br, 'TAG', 'Z') ...
					                );
					        end
					        pf.get('SYM_DICT').set('IT_LIST', syms)
					    end
					    
					    for i = 1:1:br_dict.get('LENGTH')
					        pf.get('SYM_DICT').get('IT', i).get('SETUP')
					    end
					end
					
				case 41 % BrainAtlasPF.IDS
					if ~pf.get('IDS') % false
					    h_ids = pf.get('H_IDS');
					    for i = 1:1:length(h_ids)
					        set(h_ids{i}, 'Visible', false)
					    end        
					else % true
					    % triggers the update of ID_DICT
					    pf.set('ID_DICT', pf.get('ID_DICT'))
					end
					
					% update state of toggle tool
					toolbar = pf.get('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    set(findobj(toolbar, 'Tag', 'TOOL.Ids'), 'State', pf.get('IDS'))
					end
					
				case 42 % BrainAtlasPF.ID_DICT
					if pf.get('IDS') && ~isa(pf.getr('BA'), 'NoValue')
					
					    br_dict = pf.get('BA').get('BR_DICT');
					
					    if pf.get('ID_DICT').get('LENGTH') == 0 && br_dict.get('LENGTH')
					        for i = 1:1:br_dict.get('LENGTH')
					            br = br_dict.get('IT', i);
					            ids{i} = SettingsText( ...
					                'PANEL', pf, ...
					                'PROP', 40, ...
					                'I', i, ...
					                'VISIBLE', true, ...
					                'ID', br.get('ID'), ... % Callback('EL', br, 'TAG', 'ID'), ...
					                'X', br.get('X'), ... % Callback('EL', br, 'TAG', 'X'), ...
					                'Y', br.get('Y'), ... % Callback('EL', br, 'TAG', 'Y'), ...
					                'Z', br.get('Z'), ... % Callback('EL', br, 'TAG', 'Z'), ...
					                'TXT', br.get('ID') ... % Callback('EL', br, 'TAG', 'ID') ...
					                );
					        end
					        pf.get('ID_DICT').set('IT_LIST', ids)
					    end
					    
					    for i = 1:1:br_dict.get('LENGTH')
					        pf.get('ID_DICT').get('IT', i).get('SETUP')
					    end
					end
					
				case 44 % BrainAtlasPF.LABS
					if ~pf.get('LABS') % false
					    h_labs = pf.get('H_LABS');
					    for i = 1:1:length(h_labs)
					        set(h_labs{i}, 'Visible', false)
					    end        
					else % true
						% triggers the update of LAB_DICT
						pf.set('LAB_DICT', pf.get('LAB_DICT'))
					end
					
					% update state of toggle tool
					toolbar = pf.get('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    set(findobj(toolbar, 'Tag', 'TOOL.Labs'), 'State', pf.get('LABS'))
					end
					
				case 45 % BrainAtlasPF.LAB_DICT
					if pf.get('LABS') && ~isa(pf.getr('BA'), 'NoValue')
					
					    br_dict = pf.get('BA').get('BR_DICT');
					
					    if pf.get('LAB_DICT').get('LENGTH') == 0 && br_dict.get('LENGTH')
					        for i = 1:1:br_dict.get('LENGTH')
					            br = br_dict.get('IT', i);
					            labs{i} = SettingsText( ...
					                'PANEL', pf, ...
					                'PROP', 43, ...
					                'I', i, ...
					                'VISIBLE', true, ...
					                'ID', br.get('ID'), ... % Callback('EL', br, 'TAG', 'ID'), ...
					                'X', br.get('X'), ... % Callback('EL', br, 'TAG', 'X'), ...
					                'Y', br.get('Y'), ... % Callback('EL', br, 'TAG', 'Y'), ...
					                'Z', br.get('Z'), ... % Callback('EL', br, 'TAG', 'Z'), ...
					                'TXT', br.get('LABEL') ... % Callback('EL', br, 'TAG', 'LABEL') ...
					                );
					        end
					        pf.get('LAB_DICT').set('IT_LIST', labs)
					    end
					    
					    for i = 1:1:br_dict.get('LENGTH')
					        pf.get('LAB_DICT').get('IT', i).get('SETUP')
					    end
					end
					
				otherwise
					if prop <= 32
						postset@BrainSurfacePF(pf, prop);
					end
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
				case 34 % BrainAtlasPF.H_SPHS
					L = pf.memorize('BA').get('BR_DICT').get('LENGTH');
					h_sphs = cell(1, L);
					for i = 1:1:L
					    h_sphs{i} = surf([], [], [], ...
					        'Parent', pf.memorize('H_AXES'), ...
					        'Tag', ['H_SPHS{' int2str(i) '}'], ...
					        'Visible', false ...
					        );
					end
					value = h_sphs;
					
				case 37 % BrainAtlasPF.H_SYMS
					L = pf.memorize('BA').get('BR_DICT').get('LENGTH');
					h_syms = cell(1, L);
					for i = 1:1:L
					    h_syms{i} = plot3(0, 0, 0, ...
					        'Parent', pf.get('H_AXES'), ...
					        'Tag', ['H_SYMS{' int2str(i) '}'], ...
					        'Visible', false ...
					        );
					end
					value = h_syms;
					
				case 40 % BrainAtlasPF.H_IDS
					L = pf.memorize('BA').get('BR_DICT').get('LENGTH');
					h_ids = cell(1, L);
					for i = 1:1:L
					    h_ids{i} = text(0, 0, 0, '', ...
					        'Parent', pf.get('H_AXES'), ...
					        'Tag', ['H_IDS{' int2str(i) '}'], ...
					        'Visible', false ...
					        );
					end
					value = h_ids;
					
				case 43 % BrainAtlasPF.H_LABS
					L = pf.memorize('BA').get('BR_DICT').get('LENGTH');
					h_labs = cell(1, L);
					for i = 1:1:L
					    h_labs{i} = text(0, 0, 0, '', ...
					        'Parent', pf.get('H_AXES'), ...
					        'Tag', ['H_LABS{' int2str(i) '}'], ...
					        'Visible', false ...
					        );
					end
					value = h_labs;
					
				case 11 % BrainAtlasPF.DRAW
					value = calculateValue@BrainSurfacePF(pf, 11, varargin{:}); % also warning
					if value
					    pf.memorize('H_SPHS')
					    pf.set('SPHS', pf.get('SPHS')) % sets also   SPH_DICT  
					
					    pf.memorize('H_SYMS')
					    pf.set('SYMS', pf.get('SYMS')) % sets also   SYM_DICT  
					
					    pf.memorize('H_IDS')
					    pf.set('SPHS', pf.get('SPHS')) % sets also   ID_DICT  
					
					    pf.memorize('H_LABS')
					    pf.set('LABS', pf.get('LABS')) % sets also   LAB_DICT  
					
					    % reset the ambient lighting
					    pf.get('ST_AMBIENT').get('SETUP')
					end
					
				case 18 % BrainAtlasPF.DELETE
					value = calculateValue@BrainSurfacePF(pf, 18, varargin{:}); % also warning
					if value
					    pf.set('H_SPHS', Element.getNoValue())
					    pf.set('H_SYMS', Element.getNoValue())
					    pf.set('H_IDS', Element.getNoValue())
					    pf.set('H_LABS', Element.getNoValue())
					end
					
				case 22 % BrainAtlasPF.H_TOOLS
					toolbar = pf.memorize(21);
					if check_graphics(toolbar, 'uitoolbar')
						value = calculateValue@BrainSurfacePF(pf, 22);
					    
					    tool_separator_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % Spheres
					    tool_sphs = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Sphs', ...
					        'Separator', 'on', ...
					        'State', pf.get('SPHS'), ...
					        'Tooltip', 'Show Spheres', ...
					        'CData', imread('icon_sphere.png'), ...
					        'OnCallback', {@cb_sphs, true}, ...
					        'OffCallback', {@cb_sphs, false});
					
					    % Symbols
					    tool_syms = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Syms', ...
					        'Separator', 'on', ...
					        'State', pf.get('SYMS'), ...
					        'Tooltip', 'Show Symbols', ...
					        'CData', imread('icon_symbol.png'), ...
					        'OnCallback', {@cb_syms, true}, ...
					        'OffCallback', {@cb_syms, false});
					
					    % IDs
					    tool_ids = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Ids', ...
					        'Separator', 'on', ...
					        'State', pf.get('IDS'), ...
					        'Tooltip', 'Show IDs', ...
					        'CData', imread('icon_id.png'), ...
					        'OnCallback', {@cb_ids, true}, ...
					        'OffCallback', {@cb_ids, false});
					
					    % Labels
					    tool_labs = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Labs', ...
					        'Separator', 'on', ...
					        'State', pf.get('LABS'), ...
					        'Tooltip', 'Show Labels', ...
					        'CData', imread('icon_label.png'), ...
					        'OnCallback', {@cb_labs, true}, ...
					        'OffCallback', {@cb_labs, false});
					    
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_sphs, tool_syms, tool_ids, tool_labs ...
					        };
					else
						value = {};
					end
					
				otherwise
					if prop <= 32
						value = calculateValue@BrainSurfacePF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
			function cb_sphs(~, ~, sphs) % (src, event)
			    pf.set('SPHS', sphs)
			end
			function cb_syms(~, ~, syms) % (src, event)
			    pf.set('SYMS', syms)
			end
			function cb_ids(~, ~, ids) % (src, event)
			    pf.set('IDS', ids)
			end
			function cb_labs(~, ~, labs) % (src, event)
			    pf.set('LABS', labs)
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
				case 36 % BrainAtlasPF.SPH_DICT
					pr = PanelPropIDictTable('EL', pf, 'PROP', 36, ...
					    'COLS', [-1 19 20 21 22 23 17 18 15 16], ...
					    varargin{:});
					
				case 39 % BrainAtlasPF.SYM_DICT
					pr = PanelPropIDictTable('EL', pf, 'PROP', 39, ...
					    'COLS', [-1 15 16 17 18 19 20 21 22], ...
					    varargin{:});
					
				case 42 % BrainAtlasPF.ID_DICT
					pr = PanelPropIDictTable('EL', pf, 'PROP', 42, ...
					    'COLS', [-1 15 16 17 18 27 19 21 20 22 24], ...
					    varargin{:});
					
				case 45 % BrainAtlasPF.LAB_DICT
					pr = PanelPropIDictTable('EL', pf, 'PROP', 45, ...
					    'COLS', [-1 15 16 17 18 27 19 21 20 22 24], ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@BrainSurfacePF(pf, prop, varargin{:});
					
			end
		end
	end
end
