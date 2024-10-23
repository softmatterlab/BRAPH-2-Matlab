classdef OrdMxBD < Graph
	%OrdMxBD is a ordinal multiplex binary directed graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In an ordinal multiplex binary directed graph (OrdMxBD), all layers have the same number 
	%  of nodes with within-layer directed edges either 0 (absence of connection) 
	%  or 1 (existence of connection).
	% There are connections between layers connecting the corresponding nodes.
	%
	% The list of OrdMxBD properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the ordinal multiplex binary directed graph.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ordinal multiplex binary directed graph.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ordinal multiplex binary directed graph.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ordinal multiplex binary directed graph.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ordinal multiplex binary directed graph.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ordinal multiplex binary directed graph.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ordinal multiplex binary directed graph.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>GRAPH_TYPE</strong> 	GRAPH_TYPE (constant, scalar) returns the graph type Graph.ORDERED_MULTIPLEX__.
	%  <strong>10</strong> <strong>CONNECTIVITY_TYPE</strong> 	CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type Graph.BINARY * ones(layernumber).
	%  <strong>11</strong> <strong>DIRECTIONALITY_TYPE</strong> 	DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type Graph.DIRECTED * ones(layernumber).
	%  <strong>12</strong> <strong>SELFCONNECTIVITY_TYPE</strong> 	SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type Graph.NONSELFCONNECTED on the diagonal and Graph.SELFCONNECTED off diagonal.
	%  <strong>13</strong> <strong>NEGATIVITY_TYPE</strong> 	NEGATIVITY_TYPE (query, smatrix) returns the negativity type Graph.NONNEGATIVE * ones(layernumber).
	%  <strong>14</strong> <strong>LAYERTICKS</strong> 	LAYERTICKS (metadata, rvector) are the layer tick values.
	%  <strong>15</strong> <strong>ALAYERTICKS</strong> 	ALAYERTICKS (query, rvector) returns the layer tick values.
	%  <strong>16</strong> <strong>LAYERLABELS</strong> 	LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.
	%  <strong>17</strong> <strong>ALAYERLABELS</strong> 	ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.
	%  <strong>18</strong> <strong>PARTITIONTICKS</strong> 	PARTITIONTICKS (metadata, rvector) are the partition tick values.
	%  <strong>19</strong> <strong>APARTITIONTICKS</strong> 	APARTITIONTICKS (query, rvector) returns the partition tick values.
	%  <strong>20</strong> <strong>PARTITIONLABELS</strong> 	PARTITIONLABELS (metadata, stringlist) are the partition labels provided by the user.
	%  <strong>21</strong> <strong>APARTITIONLABELS</strong> 	APARTITIONLABELS (query, stringlist) returns the partition labels for A.
	%  <strong>22</strong> <strong>NODELABELS</strong> 	NODELABELS (metadata, stringlist) are the node labels provided by the user.
	%  <strong>23</strong> <strong>ANODELABELS</strong> 	ANODELABELS (query, stringlist) returns the node labels for each layer.
	%  <strong>24</strong> <strong>RANDOMIZE</strong> 	RANDOMIZE (parameter, logical) determines whether to randomize the graph.
	%  <strong>25</strong> <strong>RANDOM_SEED</strong> 	RANDOM_SEED (parameter, scalar) is the randomization seed.
	%  <strong>26</strong> <strong>A</strong> 	A (result, cell) is the cell containing the multiplex binary adjacency matrices of the multiplex binary directed graph.
	%  <strong>27</strong> <strong>A_CHECK</strong> 	A_CHECK (query, logical) checks the format of the adjacency matrix.
	%  <strong>28</strong> <strong>NODENUMBER</strong> 	NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.
	%  <strong>29</strong> <strong>LAYERNUMBER</strong> 	LAYERNUMBER (result, scalar) returns the number of layers in the graph.
	%  <strong>30</strong> <strong>PARTITIONS</strong> 	PARTITIONS (result, rvector) returns the number of layers in the partitions of the graph.
	%  <strong>31</strong> <strong>M_DICT</strong> 	M_DICT (result, idict) contains the calculated measures of the graph.
	%  <strong>32</strong> <strong>COMPATIBLE_MEASURES</strong> 	COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
	%  <strong>33</strong> <strong>MEASURE</strong> 	MEASURE (query, item) returns a measure.
	%  <strong>34</strong> <strong>PFGA</strong> 	PFGA (gui, item) contains the panel figure of the graph adjacency matrix.
	%  <strong>35</strong> <strong>PFGH</strong> 	PFGH (gui, item) contains the panel figure of the graph histogram.
	%  <strong>36</strong> <strong>B</strong> 	B (data, cell) is the input cell containing the multiplex adjacency matrices.
	%  <strong>37</strong> <strong>SEMIPOSITIVIZE_RULE</strong> 	SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.
	%  <strong>38</strong> <strong>ATTEMPTSPEREDGE</strong> 	ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
	%  <strong>39</strong> <strong>RANDOMIZATION</strong> 	RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.
	%
	% OrdMxBD methods (constructor):
	%  OrdMxBD - constructor
	%
	% OrdMxBD methods:
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
	% OrdMxBD methods (display):
	%  tostring - string with information about the ordinal multiplex binary directed graph
	%  disp - displays information about the ordinal multiplex binary directed graph
	%  tree - displays the tree of the ordinal multiplex binary directed graph
	%
	% OrdMxBD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ordinal multiplex binary directed graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ordinal multiplex binary directed graph
	%
	% OrdMxBD methods (save/load, Static):
	%  save - saves BRAPH2 ordinal multiplex binary directed graph as b2 file
	%  load - loads a BRAPH2 ordinal multiplex binary directed graph from a b2 file
	%
	% OrdMxBD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ordinal multiplex binary directed graph
	%
	% OrdMxBD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ordinal multiplex binary directed graph
	%
	% OrdMxBD methods (inspection, Static):
	%  getClass - returns the class of the ordinal multiplex binary directed graph
	%  getSubclasses - returns all subclasses of OrdMxBD
	%  getProps - returns the property list of the ordinal multiplex binary directed graph
	%  getPropNumber - returns the property number of the ordinal multiplex binary directed graph
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
	% OrdMxBD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OrdMxBD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OrdMxBD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OrdMxBD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OrdMxBD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OrdMxBD constants</a>.
	%
	
	properties (Constant) % properties
		B = 36; %CET: Computational Efficiency Trick
		B_TAG = 'B';
		B_CATEGORY = 4;
		B_FORMAT = 16;
		
		SEMIPOSITIVIZE_RULE = 37; %CET: Computational Efficiency Trick
		SEMIPOSITIVIZE_RULE_TAG = 'SEMIPOSITIVIZE_RULE';
		SEMIPOSITIVIZE_RULE_CATEGORY = 3;
		SEMIPOSITIVIZE_RULE_FORMAT = 5;
		
		ATTEMPTSPEREDGE = 38; %CET: Computational Efficiency Trick
		ATTEMPTSPEREDGE_TAG = 'ATTEMPTSPEREDGE';
		ATTEMPTSPEREDGE_CATEGORY = 3;
		ATTEMPTSPEREDGE_FORMAT = 11;
		
		RANDOMIZATION = 39; %CET: Computational Efficiency Trick
		RANDOMIZATION_TAG = 'RANDOMIZATION';
		RANDOMIZATION_CATEGORY = 6;
		RANDOMIZATION_FORMAT = 16;
	end
	methods % constructor
		function g = OrdMxBD(varargin)
			%OrdMxBD() creates a ordinal multiplex binary directed graph.
			%
			% OrdMxBD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OrdMxBD(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of OrdMxBD properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the ordinal multiplex binary directed graph.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ordinal multiplex binary directed graph.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the ordinal multiplex binary directed graph.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ordinal multiplex binary directed graph.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ordinal multiplex binary directed graph.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ordinal multiplex binary directed graph.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ordinal multiplex binary directed graph.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>GRAPH_TYPE</strong> 	GRAPH_TYPE (constant, scalar) returns the graph type Graph.ORDERED_MULTIPLEX__.
			%  <strong>10</strong> <strong>CONNECTIVITY_TYPE</strong> 	CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type Graph.BINARY * ones(layernumber).
			%  <strong>11</strong> <strong>DIRECTIONALITY_TYPE</strong> 	DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type Graph.DIRECTED * ones(layernumber).
			%  <strong>12</strong> <strong>SELFCONNECTIVITY_TYPE</strong> 	SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type Graph.NONSELFCONNECTED on the diagonal and Graph.SELFCONNECTED off diagonal.
			%  <strong>13</strong> <strong>NEGATIVITY_TYPE</strong> 	NEGATIVITY_TYPE (query, smatrix) returns the negativity type Graph.NONNEGATIVE * ones(layernumber).
			%  <strong>14</strong> <strong>LAYERTICKS</strong> 	LAYERTICKS (metadata, rvector) are the layer tick values.
			%  <strong>15</strong> <strong>ALAYERTICKS</strong> 	ALAYERTICKS (query, rvector) returns the layer tick values.
			%  <strong>16</strong> <strong>LAYERLABELS</strong> 	LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.
			%  <strong>17</strong> <strong>ALAYERLABELS</strong> 	ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.
			%  <strong>18</strong> <strong>PARTITIONTICKS</strong> 	PARTITIONTICKS (metadata, rvector) are the partition tick values.
			%  <strong>19</strong> <strong>APARTITIONTICKS</strong> 	APARTITIONTICKS (query, rvector) returns the partition tick values.
			%  <strong>20</strong> <strong>PARTITIONLABELS</strong> 	PARTITIONLABELS (metadata, stringlist) are the partition labels provided by the user.
			%  <strong>21</strong> <strong>APARTITIONLABELS</strong> 	APARTITIONLABELS (query, stringlist) returns the partition labels for A.
			%  <strong>22</strong> <strong>NODELABELS</strong> 	NODELABELS (metadata, stringlist) are the node labels provided by the user.
			%  <strong>23</strong> <strong>ANODELABELS</strong> 	ANODELABELS (query, stringlist) returns the node labels for each layer.
			%  <strong>24</strong> <strong>RANDOMIZE</strong> 	RANDOMIZE (parameter, logical) determines whether to randomize the graph.
			%  <strong>25</strong> <strong>RANDOM_SEED</strong> 	RANDOM_SEED (parameter, scalar) is the randomization seed.
			%  <strong>26</strong> <strong>A</strong> 	A (result, cell) is the cell containing the multiplex binary adjacency matrices of the multiplex binary directed graph.
			%  <strong>27</strong> <strong>A_CHECK</strong> 	A_CHECK (query, logical) checks the format of the adjacency matrix.
			%  <strong>28</strong> <strong>NODENUMBER</strong> 	NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.
			%  <strong>29</strong> <strong>LAYERNUMBER</strong> 	LAYERNUMBER (result, scalar) returns the number of layers in the graph.
			%  <strong>30</strong> <strong>PARTITIONS</strong> 	PARTITIONS (result, rvector) returns the number of layers in the partitions of the graph.
			%  <strong>31</strong> <strong>M_DICT</strong> 	M_DICT (result, idict) contains the calculated measures of the graph.
			%  <strong>32</strong> <strong>COMPATIBLE_MEASURES</strong> 	COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
			%  <strong>33</strong> <strong>MEASURE</strong> 	MEASURE (query, item) returns a measure.
			%  <strong>34</strong> <strong>PFGA</strong> 	PFGA (gui, item) contains the panel figure of the graph adjacency matrix.
			%  <strong>35</strong> <strong>PFGH</strong> 	PFGH (gui, item) contains the panel figure of the graph histogram.
			%  <strong>36</strong> <strong>B</strong> 	B (data, cell) is the input cell containing the multiplex adjacency matrices.
			%  <strong>37</strong> <strong>SEMIPOSITIVIZE_RULE</strong> 	SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.
			%  <strong>38</strong> <strong>ATTEMPTSPEREDGE</strong> 	ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
			%  <strong>39</strong> <strong>RANDOMIZATION</strong> 	RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.
			%
			% See also Category, Format.
			
			g = g@Graph(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the ordinal multiplex binary directed graph.
			%
			% BUILD = OrdMxBD.GETBUILD() returns the build of 'OrdMxBD'.
			%
			% Alternative forms to call this method are:
			%  BUILD = G.GETBUILD() returns the build of the ordinal multiplex binary directed graph G.
			%  BUILD = Element.GETBUILD(G) returns the build of 'G'.
			%  BUILD = Element.GETBUILD('OrdMxBD') returns the build of 'OrdMxBD'.
			%
			% Note that the Element.GETBUILD(G) and Element.GETBUILD('OrdMxBD')
			%  are less computationally efficient.
			
			build = 1;
		end
		function g_class = getClass()
			%GETCLASS returns the class of the ordinal multiplex binary directed graph.
			%
			% CLASS = OrdMxBD.GETCLASS() returns the class 'OrdMxBD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the ordinal multiplex binary directed graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('OrdMxBD') returns 'OrdMxBD'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('OrdMxBD')
			%  are less computationally efficient.
			
			g_class = 'OrdMxBD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ordinal multiplex binary directed graph.
			%
			% LIST = OrdMxBD.GETSUBCLASSES() returns all subclasses of 'OrdMxBD'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the ordinal multiplex binary directed graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('OrdMxBD') returns all subclasses of 'OrdMxBD'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'OrdMxBD' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ordinal multiplex binary directed graph.
			%
			% PROPS = OrdMxBD.GETPROPS() returns the property list of ordinal multiplex binary directed graph
			%  as a row vector.
			%
			% PROPS = OrdMxBD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the ordinal multiplex binary directed graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('OrdMxBD'[, CATEGORY]) returns the property list of 'OrdMxBD'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3 9 32];
				case 2 % Category.METADATA
					prop_list = [6 7 14 16 18 20 22];
				case 3 % Category.PARAMETER
					prop_list = [4 24 25 37 38];
				case 4 % Category.DATA
					prop_list = [5 36];
				case 5 % Category.RESULT
					prop_list = [26 28 29 30 31];
				case 6 % Category.QUERY
					prop_list = [8 10 11 12 13 15 17 19 21 23 27 33 39];
				case 9 % Category.GUI
					prop_list = [34 35];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of ordinal multiplex binary directed graph.
			%
			% N = OrdMxBD.GETPROPNUMBER() returns the property number of ordinal multiplex binary directed graph.
			%
			% N = OrdMxBD.GETPROPNUMBER(CATEGORY) returns the property number of ordinal multiplex binary directed graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the ordinal multiplex binary directed graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('OrdMxBD') returns the property number of 'OrdMxBD'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 39;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 5;
				case 2 % Category.METADATA
					prop_number = 7;
				case 3 % Category.PARAMETER
					prop_number = 5;
				case 4 % Category.DATA
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 5;
				case 6 % Category.QUERY
					prop_number = 13;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in ordinal multiplex binary directed graph/error.
			%
			% CHECK = OrdMxBD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(OrdMxBD, PROP) checks whether PROP exists for OrdMxBD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OrdMxBD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBD:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBD:WrongInput]
			%  Element.EXISTSPROP(OrdMxBD, PROP) throws error if PROP does NOT exist for OrdMxBD.
			%   Error id: [BRAPH2:OrdMxBD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 39 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':OrdMxBD:' 'WrongInput'], ...
					['BRAPH2' ':OrdMxBD:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OrdMxBD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ordinal multiplex binary directed graph/error.
			%
			% CHECK = OrdMxBD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(OrdMxBD, TAG) checks whether TAG exists for OrdMxBD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OrdMxBD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBD:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBD:WrongInput]
			%  Element.EXISTSTAG(OrdMxBD, TAG) throws error if TAG does NOT exist for OrdMxBD.
			%   Error id: [BRAPH2:OrdMxBD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GRAPH_TYPE'  'CONNECTIVITY_TYPE'  'DIRECTIONALITY_TYPE'  'SELFCONNECTIVITY_TYPE'  'NEGATIVITY_TYPE'  'LAYERTICKS'  'ALAYERTICKS'  'LAYERLABELS'  'ALAYERLABELS'  'PARTITIONTICKS'  'APARTITIONTICKS'  'PARTITIONLABELS'  'APARTITIONLABELS'  'NODELABELS'  'ANODELABELS'  'RANDOMIZE'  'RANDOM_SEED'  'A'  'A_CHECK'  'NODENUMBER'  'LAYERNUMBER'  'PARTITIONS'  'M_DICT'  'COMPATIBLE_MEASURES'  'MEASURE'  'PFGA'  'PFGH'  'B'  'SEMIPOSITIVIZE_RULE'  'ATTEMPTSPEREDGE'  'RANDOMIZATION' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':OrdMxBD:' 'WrongInput'], ...
					['BRAPH2' ':OrdMxBD:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for OrdMxBD.'] ...
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
			%  PROPERTY = G.GETPROPPROP(POINTER) returns property number of POINTER of G.
			%  PROPERTY = Element.GETPROPPROP(OrdMxBD, POINTER) returns property number of POINTER of OrdMxBD.
			%  PROPERTY = G.GETPROPPROP(OrdMxBD, POINTER) returns property number of POINTER of OrdMxBD.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GRAPH_TYPE'  'CONNECTIVITY_TYPE'  'DIRECTIONALITY_TYPE'  'SELFCONNECTIVITY_TYPE'  'NEGATIVITY_TYPE'  'LAYERTICKS'  'ALAYERTICKS'  'LAYERLABELS'  'ALAYERLABELS'  'PARTITIONTICKS'  'APARTITIONTICKS'  'PARTITIONLABELS'  'APARTITIONLABELS'  'NODELABELS'  'ANODELABELS'  'RANDOMIZE'  'RANDOM_SEED'  'A'  'A_CHECK'  'NODENUMBER'  'LAYERNUMBER'  'PARTITIONS'  'M_DICT'  'COMPATIBLE_MEASURES'  'MEASURE'  'PFGA'  'PFGH'  'B'  'SEMIPOSITIVIZE_RULE'  'ATTEMPTSPEREDGE'  'RANDOMIZATION' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = G.GETPROPTAG(POINTER) returns tag of POINTER of G.
			%  TAG = Element.GETPROPTAG(OrdMxBD, POINTER) returns tag of POINTER of OrdMxBD.
			%  TAG = G.GETPROPTAG(OrdMxBD, POINTER) returns tag of POINTER of OrdMxBD.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				ordmxbd_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GRAPH_TYPE'  'CONNECTIVITY_TYPE'  'DIRECTIONALITY_TYPE'  'SELFCONNECTIVITY_TYPE'  'NEGATIVITY_TYPE'  'LAYERTICKS'  'ALAYERTICKS'  'LAYERLABELS'  'ALAYERLABELS'  'PARTITIONTICKS'  'APARTITIONTICKS'  'PARTITIONLABELS'  'APARTITIONLABELS'  'NODELABELS'  'ANODELABELS'  'RANDOMIZE'  'RANDOM_SEED'  'A'  'A_CHECK'  'NODENUMBER'  'LAYERNUMBER'  'PARTITIONS'  'M_DICT'  'COMPATIBLE_MEASURES'  'MEASURE'  'PFGA'  'PFGH'  'B'  'SEMIPOSITIVIZE_RULE'  'ATTEMPTSPEREDGE'  'RANDOMIZATION' };
				tag = ordmxbd_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = G.GETPROPCATEGORY(POINTER) returns category of POINTER of G.
			%  CATEGORY = Element.GETPROPCATEGORY(OrdMxBD, POINTER) returns category of POINTER of OrdMxBD.
			%  CATEGORY = G.GETPROPCATEGORY(OrdMxBD, POINTER) returns category of POINTER of OrdMxBD.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMxBD.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			ordmxbd_category_list = { 1  1  1  3  4  2  2  6  1  6  6  6  6  2  6  2  6  2  6  2  6  2  6  3  3  5  6  5  5  5  5  1  6  9  9  4  3  3  6 };
			prop_category = ordmxbd_category_list{prop};
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
			%  FORMAT = G.GETPROPFORMAT(POINTER) returns format of POINTER of G.
			%  FORMAT = Element.GETPROPFORMAT(OrdMxBD, POINTER) returns format of POINTER of OrdMxBD.
			%  FORMAT = G.GETPROPFORMAT(OrdMxBD, POINTER) returns format of POINTER of OrdMxBD.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMxBD.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			ordmxbd_format_list = { 2  2  2  8  2  2  2  2  11  15  15  15  11  12  12  3  3  12  12  3  3  3  3  4  11  16  4  12  11  12  10  7  8  8  8  16  5  11  16 };
			prop_format = ordmxbd_format_list{prop};
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
			%  DESCRIPTION = G.GETPROPDESCRIPTION(POINTER) returns description of POINTER of G.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OrdMxBD, POINTER) returns description of POINTER of OrdMxBD.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(OrdMxBD, POINTER) returns description of POINTER of OrdMxBD.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMxBD.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			ordmxbd_description_list = { 'ELCLASS (constant, string) is the class of the ordinal multiplex binary directed graph.'  'NAME (constant, string) is the name of the ordinal multiplex binary directed graph.'  'DESCRIPTION (constant, string) is the description of the ordinal multiplex binary directed graph.'  'TEMPLATE (parameter, item) is the template of the ordinal multiplex binary directed graph.'  'ID (data, string) is a few-letter code for the ordinal multiplex binary directed graph.'  'LABEL (metadata, string) is an extended label of the ordinal multiplex binary directed graph.'  'NOTES (metadata, string) are some specific notes about the ordinal multiplex binary directed graph.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'GRAPH_TYPE (constant, scalar) returns the graph type Graph.ORDERED_MULTIPLEX__.'  'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type Graph.BINARY * ones(layernumber).'  'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type Graph.DIRECTED * ones(layernumber).'  'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type Graph.NONSELFCONNECTED on the diagonal and Graph.SELFCONNECTED off diagonal.'  'NEGATIVITY_TYPE (query, smatrix) returns the negativity type Graph.NONNEGATIVE * ones(layernumber).'  'LAYERTICKS (metadata, rvector) are the layer tick values.'  'ALAYERTICKS (query, rvector) returns the layer tick values.'  'LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.'  'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.'  'PARTITIONTICKS (metadata, rvector) are the partition tick values.'  'APARTITIONTICKS (query, rvector) returns the partition tick values.'  'PARTITIONLABELS (metadata, stringlist) are the partition labels provided by the user.'  'APARTITIONLABELS (query, stringlist) returns the partition labels for A.'  'NODELABELS (metadata, stringlist) are the node labels provided by the user.'  'ANODELABELS (query, stringlist) returns the node labels for each layer.'  'RANDOMIZE (parameter, logical) determines whether to randomize the graph.'  'RANDOM_SEED (parameter, scalar) is the randomization seed.'  'A (result, cell) is the cell containing the multiplex binary adjacency matrices of the multiplex binary directed graph.'  'A_CHECK (query, logical) checks the format of the adjacency matrix.'  'NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.'  'LAYERNUMBER (result, scalar) returns the number of layers in the graph.'  'PARTITIONS (result, rvector) returns the number of layers in the partitions of the graph.'  'M_DICT (result, idict) contains the calculated measures of the graph.'  'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.'  'MEASURE (query, item) returns a measure.'  'PFGA (gui, item) contains the panel figure of the graph adjacency matrix.'  'PFGH (gui, item) contains the panel figure of the graph histogram.'  'B (data, cell) is the input cell containing the multiplex adjacency matrices.'  'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.'  'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.'  'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.' };
			prop_description = ordmxbd_description_list{prop};
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
			%  SETTINGS = G.GETPROPSETTINGS(POINTER) returns settings of POINTER of G.
			%  SETTINGS = Element.GETPROPSETTINGS(OrdMxBD, POINTER) returns settings of POINTER of OrdMxBD.
			%  SETTINGS = G.GETPROPSETTINGS(OrdMxBD, POINTER) returns settings of POINTER of OrdMxBD.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMxBD.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % OrdMxBD.B
					prop_settings = Format.getFormatSettings(16);
				case 37 % OrdMxBD.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case 38 % OrdMxBD.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(11);
				case 39 % OrdMxBD.RANDOMIZATION
					prop_settings = Format.getFormatSettings(16);
				case 4 % OrdMxBD.TEMPLATE
					prop_settings = 'OrdMxBD';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OrdMxBD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMxBD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(OrdMxBD, POINTER) returns the default value of POINTER of OrdMxBD.
			%  DEFAULT = G.GETPROPDEFAULT(OrdMxBD, POINTER) returns the default value of POINTER of OrdMxBD.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OrdMxBD.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % OrdMxBD.B
					prop_default = {[] []};
				case 37 % OrdMxBD.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(5, OrdMxBD.getPropSettings(prop));
				case 38 % OrdMxBD.ATTEMPTSPEREDGE
					prop_default = 5;
				case 39 % OrdMxBD.RANDOMIZATION
					prop_default = Format.getFormatDefault(16, OrdMxBD.getPropSettings(prop));
				case 1 % OrdMxBD.ELCLASS
					prop_default = 'OrdMxBD';
				case 2 % OrdMxBD.NAME
					prop_default = 'Ordinal Multiplex Binary Directed Graph';
				case 3 % OrdMxBD.DESCRIPTION
					prop_default = 'In an ordinal multiplex binary directed graph (OrdMxBD), all layers have the same number of nodes with within-layer directed edges either 0 (absence of connection) or 1 (existence of connection). There are connections between layers connecting the corresponding nodes.';
				case 4 % OrdMxBD.TEMPLATE
					prop_default = Format.getFormatDefault(8, OrdMxBD.getPropSettings(prop));
				case 5 % OrdMxBD.ID
					prop_default = 'OrdMxBD ID';
				case 6 % OrdMxBD.LABEL
					prop_default = 'OrdMxBD label';
				case 7 % OrdMxBD.NOTES
					prop_default = 'OrdMxBD notes';
				case 9 % OrdMxBD.GRAPH_TYPE
					prop_default = 3;
				case 32 % OrdMxBD.COMPATIBLE_MEASURES
					prop_default = { 'DegreeIn'  'DegreeInAv'  'DegreeOut'  'DegreeOutAv'  'Distance'  'GlobalEfficiencyIn'  'GlobalEfficiencyInAv'  'GlobalEfficiencyOut'  'GlobalEfficiencyOutAv'  'OverlappingDegIn'  'OverlappingDegInAv'  'OverlappingDegOut'  'OverlappingDegOutAv'  'PathLengthOut'  'Triangles' };
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OrdMxBD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMxBD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OrdMxBD, POINTER) returns the conditioned default value of POINTER of OrdMxBD.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(OrdMxBD, POINTER) returns the conditioned default value of POINTER of OrdMxBD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OrdMxBD.getPropProp(pointer);
			
			prop_default = OrdMxBD.conditioning(prop, OrdMxBD.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = G.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = G.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of G.
			%  CHECK = Element.CHECKPROP(OrdMxBD, PROP, VALUE) checks VALUE format for PROP of OrdMxBD.
			%  CHECK = G.CHECKPROP(OrdMxBD, PROP, VALUE) checks VALUE format for PROP of OrdMxBD.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:OrdMxBD:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: BRAPH2:OrdMxBD:WrongInput
			%  Element.CHECKPROP(OrdMxBD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMxBD.
			%   Error id: BRAPH2:OrdMxBD:WrongInput
			%  G.CHECKPROP(OrdMxBD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMxBD.
			%   Error id: BRAPH2:OrdMxBD:WrongInput]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('OrdMxBD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OrdMxBD.getPropProp(pointer);
			
			switch prop
				case 36 % OrdMxBD.B
					check = Format.checkFormat(16, value, OrdMxBD.getPropSettings(prop));
				case 37 % OrdMxBD.SEMIPOSITIVIZE_RULE
					check = Format.checkFormat(5, value, OrdMxBD.getPropSettings(prop));
				case 38 % OrdMxBD.ATTEMPTSPEREDGE
					check = Format.checkFormat(11, value, OrdMxBD.getPropSettings(prop));
				case 39 % OrdMxBD.RANDOMIZATION
					check = Format.checkFormat(16, value, OrdMxBD.getPropSettings(prop));
				case 4 % OrdMxBD.TEMPLATE
					check = Format.checkFormat(8, value, OrdMxBD.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':OrdMxBD:' 'WrongInput'], ...
					['BRAPH2' ':OrdMxBD:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OrdMxBD.getPropTag(prop) ' (' OrdMxBD.getFormatTag(OrdMxBD.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(g, prop, varargin)
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
				case 39 % OrdMxBD.RANDOMIZATION
					rng(g.get('RANDOM_SEED'), 'twister')
					
					if isempty(varargin)
					    value = {};
					    return
					end
					
					A = varargin{1};
					attempts_per_edge = g.get('ATTEMPTSPEREDGE');
					
					for i = 1:length(A)
					    tmp_a = A{i,i};
					
					    tmp_g = GraphBD();
					    tmp_g.set('ATTEMPTSPEREDGE', g.get('ATTEMPTSPEREDGE'));
					    random_A = tmp_g.get('RANDOMIZATION', {tmp_a});
					    A{i, i} = random_A;
					end
					value = A;
					
				case 10 % OrdMxBD.CONNECTIVITY_TYPE
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = 2 * ones(layernumber);
					
				case 11 % OrdMxBD.DIRECTIONALITY_TYPE
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value =  ones(layernumber);
					
				case 12 % OrdMxBD.SELFCONNECTIVITY_TYPE
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = 2 * ones(layernumber);
					value(1:layernumber+1:end) = 1;
					
				case 13 % OrdMxBD.NEGATIVITY_TYPE
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value =  ones(layernumber);
					
				case 26 % OrdMxBD.A
					rng_settings_ = rng(); rng(g.getPropSeed(26), 'twister')
					
					B = g.get('B'); %#ok<PROPLC>
					L = length(B); %#ok<PROPLC> % number of layers
					A = cell(L, L);
					
					for i = 1:1:L
					    M = dediagonalize(B{i}); %#ok<PROPLC> % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(B{i}, 'DediagonalizeRule', 0)
					    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
					    M = binarize(M, varargin{:}); % rescales adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
					    A(i, i) = {M};
					    if ~isempty(A{1, 1})
					        for j = i+1:1:L
					            if j == i+1
					                A(i, j) = {eye(length(A{1, 1}))};
					                A(j, i) = {eye(length(A{1, 1}))};
					            else
					                A(i, j) = {zeros(length(A{1, 1}))};
					                A(j, i) = {zeros(length(A{1, 1}))};
					            end
					        end
					    end
					end
					if g.get('RANDOMIZE')
					    A = g.get('RANDOMIZATION', A);
					end
					value = A;
					
					rng(rng_settings_)
					
				case 17 % OrdMxBD.ALAYERLABELS
					alayerlabels = g.get('LAYERLABELS');
					if isempty(alayerlabels) && ~isa(g.getr('A'), 'NoValue') % ensures that it's not unecessarily calculated
					    alayerlabels = cellfun(@num2str, num2cell([1:1:g.get('LAYERNUMBER')]), 'uniformoutput', false);
					end
					value = alayerlabels;
					
				otherwise
					if prop <= 35
						value = calculateValue@Graph(g, prop, varargin{:});
					else
						value = calculateValue@Element(g, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(g, prop, varargin)
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
				case 36 % OrdMxBD.B
					pr = PanelPropCell('EL', g, 'PROP', 36, ...
					    'TABLE_HEIGHT', 480, ...
					    'XSLIDERSHOW', true, ...
					    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
					    'XSLIDERHEIGHT', 42, ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case 26 % OrdMxBD.A
					pr = PanelPropCell('EL', g, 'PROP', 26, ...
					    'TABLE_HEIGHT', 480, ...
					    'XYSLIDERLOCK', true, ... 
					    'XSLIDERSHOW', false, ...
					    'YSLIDERSHOW', true, ...
					    'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					    'YSLIDERWIDTH', 60, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@Graph(g, prop, varargin{:});
					
			end
		end
	end
end
