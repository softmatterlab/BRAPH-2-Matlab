classdef GraphBD < Graph
	%GraphBD is a binary directed graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In a binary directed graph (GraphBD), the edges are directed and they can be 
	%  either 0 (absence of connection) or 1 (existence of connection).
	%
	% The list of GraphBD properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the binary directed graph.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the binary directed graph.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the binary directed graph.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the binary directed graph.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the binary directed graph.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the binary directed graph.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the binary directed graph.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>GRAPH_TYPE</strong> 	GRAPH_TYPE (constant, scalar) returns the graph type Graph.GRAPH.
	%  <strong>10</strong> <strong>CONNECTIVITY_TYPE</strong> 	CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type Graph.BINARY.
	%  <strong>11</strong> <strong>DIRECTIONALITY_TYPE</strong> 	DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type Graph.DIRECTED.
	%  <strong>12</strong> <strong>SELFCONNECTIVITY_TYPE</strong> 	SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type Graph.NONSELFCONNECTED.
	%  <strong>13</strong> <strong>NEGATIVITY_TYPE</strong> 	NEGATIVITY_TYPE (query, smatrix) returns the negativity type Graph.NONNEGATIVE.
	%  <strong>14</strong> <strong>LAYERTICKS</strong> 	LAYERTICKS (metadata, rvector) are the layer tick values.
	%  <strong>15</strong> <strong>ALAYERTICKS</strong> 	ALAYERTICKS (query, rvector) returns the layer tick values.
	%  <strong>16</strong> <strong>LAYERLABELS</strong> 	LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.
	%  <strong>17</strong> <strong>ALAYERLABELS</strong> 	ALAYERLABELS (query, stringlist) returns the layer labels for A.
	%  <strong>18</strong> <strong>PARTITIONTICKS</strong> 	PARTITIONTICKS (metadata, rvector) are the partition tick values.
	%  <strong>19</strong> <strong>APARTITIONTICKS</strong> 	APARTITIONTICKS (query, rvector) returns the partition tick values.
	%  <strong>20</strong> <strong>PARTITIONLABELS</strong> 	PARTITIONLABELS (metadata, stringlist) are the partition labels provided by the user.
	%  <strong>21</strong> <strong>APARTITIONLABELS</strong> 	APARTITIONLABELS (query, stringlist) returns the partition labels for A.
	%  <strong>22</strong> <strong>NODELABELS</strong> 	NODELABELS (metadata, stringlist) are the node labels provided by the user.
	%  <strong>23</strong> <strong>ANODELABELS</strong> 	ANODELABELS (query, stringlist) returns the node labels for each layer.
	%  <strong>24</strong> <strong>RANDOMIZE</strong> 	RANDOMIZE (parameter, logical) determines whether to randomize the graph.
	%  <strong>25</strong> <strong>RANDOM_SEED</strong> 	RANDOM_SEED (parameter, scalar) is the randomization seed.
	%  <strong>26</strong> <strong>A</strong> 	A (result, cell) is the binary adjacency matrix of the binary directed graph.
	%  <strong>27</strong> <strong>A_CHECK</strong> 	A_CHECK (query, logical) checks the format of the adjacency matrix.
	%  <strong>28</strong> <strong>NODENUMBER</strong> 	NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.
	%  <strong>29</strong> <strong>LAYERNUMBER</strong> 	LAYERNUMBER (result, scalar) returns the number of layers in the graph.
	%  <strong>30</strong> <strong>PARTITIONS</strong> 	PARTITIONS (result, rvector) returns the number of layers in the partitions of the graph.
	%  <strong>31</strong> <strong>M_DICT</strong> 	M_DICT (result, idict) contains the calculated measures of the graph.
	%  <strong>32</strong> <strong>COMPATIBLE_MEASURES</strong> 	COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
	%  <strong>33</strong> <strong>MEASURE</strong> 	MEASURE (query, item) returns a measure.
	%  <strong>34</strong> <strong>PFGA</strong> 	PFGA (gui, item) contains the panel figure of the graph adjacency matrix.
	%  <strong>35</strong> <strong>PFGH</strong> 	PFGH (gui, item) contains the panel figure of the graph histogram.
	%  <strong>36</strong> <strong>B</strong> 	B (data, smatrix) is the input graph adjacency matrix.
	%  <strong>37</strong> <strong>SEMIPOSITIVIZE_RULE</strong> 	SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.
	%  <strong>38</strong> <strong>ATTEMPTSPEREDGE</strong> 	ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
	%  <strong>39</strong> <strong>RANDOMIZATION</strong> 	RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.
	%
	% GraphBD methods (constructor):
	%  GraphBD - constructor
	%
	% GraphBD methods:
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
	% GraphBD methods (display):
	%  tostring - string with information about the binary directed graph
	%  disp - displays information about the binary directed graph
	%  tree - displays the tree of the binary directed graph
	%
	% GraphBD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two binary directed graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the binary directed graph
	%
	% GraphBD methods (save/load, Static):
	%  save - saves BRAPH2 binary directed graph as b2 file
	%  load - loads a BRAPH2 binary directed graph from a b2 file
	%
	% GraphBD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the binary directed graph
	%
	% GraphBD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the binary directed graph
	%
	% GraphBD methods (inspection, Static):
	%  getClass - returns the class of the binary directed graph
	%  getSubclasses - returns all subclasses of GraphBD
	%  getProps - returns the property list of the binary directed graph
	%  getPropNumber - returns the property number of the binary directed graph
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
	% GraphBD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GraphBD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GraphBD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GraphBD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GraphBD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GraphBD constants</a>.
	%
	
	properties (Constant) % properties
		B = 36; %CET: Computational Efficiency Trick
		B_TAG = 'B';
		B_CATEGORY = 4;
		B_FORMAT = 15;
		
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
		function g = GraphBD(varargin)
			%GraphBD() creates a binary directed graph.
			%
			% GraphBD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GraphBD(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GraphBD properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the binary directed graph.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the binary directed graph.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the binary directed graph.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the binary directed graph.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the binary directed graph.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the binary directed graph.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the binary directed graph.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>GRAPH_TYPE</strong> 	GRAPH_TYPE (constant, scalar) returns the graph type Graph.GRAPH.
			%  <strong>10</strong> <strong>CONNECTIVITY_TYPE</strong> 	CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type Graph.BINARY.
			%  <strong>11</strong> <strong>DIRECTIONALITY_TYPE</strong> 	DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type Graph.DIRECTED.
			%  <strong>12</strong> <strong>SELFCONNECTIVITY_TYPE</strong> 	SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type Graph.NONSELFCONNECTED.
			%  <strong>13</strong> <strong>NEGATIVITY_TYPE</strong> 	NEGATIVITY_TYPE (query, smatrix) returns the negativity type Graph.NONNEGATIVE.
			%  <strong>14</strong> <strong>LAYERTICKS</strong> 	LAYERTICKS (metadata, rvector) are the layer tick values.
			%  <strong>15</strong> <strong>ALAYERTICKS</strong> 	ALAYERTICKS (query, rvector) returns the layer tick values.
			%  <strong>16</strong> <strong>LAYERLABELS</strong> 	LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.
			%  <strong>17</strong> <strong>ALAYERLABELS</strong> 	ALAYERLABELS (query, stringlist) returns the layer labels for A.
			%  <strong>18</strong> <strong>PARTITIONTICKS</strong> 	PARTITIONTICKS (metadata, rvector) are the partition tick values.
			%  <strong>19</strong> <strong>APARTITIONTICKS</strong> 	APARTITIONTICKS (query, rvector) returns the partition tick values.
			%  <strong>20</strong> <strong>PARTITIONLABELS</strong> 	PARTITIONLABELS (metadata, stringlist) are the partition labels provided by the user.
			%  <strong>21</strong> <strong>APARTITIONLABELS</strong> 	APARTITIONLABELS (query, stringlist) returns the partition labels for A.
			%  <strong>22</strong> <strong>NODELABELS</strong> 	NODELABELS (metadata, stringlist) are the node labels provided by the user.
			%  <strong>23</strong> <strong>ANODELABELS</strong> 	ANODELABELS (query, stringlist) returns the node labels for each layer.
			%  <strong>24</strong> <strong>RANDOMIZE</strong> 	RANDOMIZE (parameter, logical) determines whether to randomize the graph.
			%  <strong>25</strong> <strong>RANDOM_SEED</strong> 	RANDOM_SEED (parameter, scalar) is the randomization seed.
			%  <strong>26</strong> <strong>A</strong> 	A (result, cell) is the binary adjacency matrix of the binary directed graph.
			%  <strong>27</strong> <strong>A_CHECK</strong> 	A_CHECK (query, logical) checks the format of the adjacency matrix.
			%  <strong>28</strong> <strong>NODENUMBER</strong> 	NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.
			%  <strong>29</strong> <strong>LAYERNUMBER</strong> 	LAYERNUMBER (result, scalar) returns the number of layers in the graph.
			%  <strong>30</strong> <strong>PARTITIONS</strong> 	PARTITIONS (result, rvector) returns the number of layers in the partitions of the graph.
			%  <strong>31</strong> <strong>M_DICT</strong> 	M_DICT (result, idict) contains the calculated measures of the graph.
			%  <strong>32</strong> <strong>COMPATIBLE_MEASURES</strong> 	COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
			%  <strong>33</strong> <strong>MEASURE</strong> 	MEASURE (query, item) returns a measure.
			%  <strong>34</strong> <strong>PFGA</strong> 	PFGA (gui, item) contains the panel figure of the graph adjacency matrix.
			%  <strong>35</strong> <strong>PFGH</strong> 	PFGH (gui, item) contains the panel figure of the graph histogram.
			%  <strong>36</strong> <strong>B</strong> 	B (data, smatrix) is the input graph adjacency matrix.
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
			%GETBUILD returns the build of the binary directed graph.
			%
			% BUILD = GraphBD.GETBUILD() returns the build of 'GraphBD'.
			%
			% Alternative forms to call this method are:
			%  BUILD = G.GETBUILD() returns the build of the binary directed graph G.
			%  BUILD = Element.GETBUILD(G) returns the build of 'G'.
			%  BUILD = Element.GETBUILD('GraphBD') returns the build of 'GraphBD'.
			%
			% Note that the Element.GETBUILD(G) and Element.GETBUILD('GraphBD')
			%  are less computationally efficient.
			
			build = 1;
		end
		function g_class = getClass()
			%GETCLASS returns the class of the binary directed graph.
			%
			% CLASS = GraphBD.GETCLASS() returns the class 'GraphBD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the binary directed graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('GraphBD') returns 'GraphBD'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('GraphBD')
			%  are less computationally efficient.
			
			g_class = 'GraphBD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the binary directed graph.
			%
			% LIST = GraphBD.GETSUBCLASSES() returns all subclasses of 'GraphBD'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the binary directed graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('GraphBD') returns all subclasses of 'GraphBD'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('GraphBD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GraphBD' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of binary directed graph.
			%
			% PROPS = GraphBD.GETPROPS() returns the property list of binary directed graph
			%  as a row vector.
			%
			% PROPS = GraphBD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the binary directed graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('GraphBD'[, CATEGORY]) returns the property list of 'GraphBD'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('GraphBD')
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
			%GETPROPNUMBER returns the property number of binary directed graph.
			%
			% N = GraphBD.GETPROPNUMBER() returns the property number of binary directed graph.
			%
			% N = GraphBD.GETPROPNUMBER(CATEGORY) returns the property number of binary directed graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the binary directed graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('GraphBD') returns the property number of 'GraphBD'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('GraphBD')
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
			%EXISTSPROP checks whether property exists in binary directed graph/error.
			%
			% CHECK = GraphBD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(GraphBD, PROP) checks whether PROP exists for GraphBD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GraphBD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:GraphBD:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:GraphBD:WrongInput]
			%  Element.EXISTSPROP(GraphBD, PROP) throws error if PROP does NOT exist for GraphBD.
			%   Error id: [BRAPH2:GraphBD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('GraphBD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 39 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GraphBD:' 'WrongInput'], ...
					['BRAPH2' ':GraphBD:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GraphBD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in binary directed graph/error.
			%
			% CHECK = GraphBD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(GraphBD, TAG) checks whether TAG exists for GraphBD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GraphBD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:GraphBD:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:GraphBD:WrongInput]
			%  Element.EXISTSTAG(GraphBD, TAG) throws error if TAG does NOT exist for GraphBD.
			%   Error id: [BRAPH2:GraphBD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('GraphBD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GRAPH_TYPE'  'CONNECTIVITY_TYPE'  'DIRECTIONALITY_TYPE'  'SELFCONNECTIVITY_TYPE'  'NEGATIVITY_TYPE'  'LAYERTICKS'  'ALAYERTICKS'  'LAYERLABELS'  'ALAYERLABELS'  'PARTITIONTICKS'  'APARTITIONTICKS'  'PARTITIONLABELS'  'APARTITIONLABELS'  'NODELABELS'  'ANODELABELS'  'RANDOMIZE'  'RANDOM_SEED'  'A'  'A_CHECK'  'NODENUMBER'  'LAYERNUMBER'  'PARTITIONS'  'M_DICT'  'COMPATIBLE_MEASURES'  'MEASURE'  'PFGA'  'PFGH'  'B'  'SEMIPOSITIVIZE_RULE'  'ATTEMPTSPEREDGE'  'RANDOMIZATION' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GraphBD:' 'WrongInput'], ...
					['BRAPH2' ':GraphBD:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GraphBD.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GraphBD, POINTER) returns property number of POINTER of GraphBD.
			%  PROPERTY = G.GETPROPPROP(GraphBD, POINTER) returns property number of POINTER of GraphBD.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('GraphBD')
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
			%  TAG = Element.GETPROPTAG(GraphBD, POINTER) returns tag of POINTER of GraphBD.
			%  TAG = G.GETPROPTAG(GraphBD, POINTER) returns tag of POINTER of GraphBD.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('GraphBD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				graphbd_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GRAPH_TYPE'  'CONNECTIVITY_TYPE'  'DIRECTIONALITY_TYPE'  'SELFCONNECTIVITY_TYPE'  'NEGATIVITY_TYPE'  'LAYERTICKS'  'ALAYERTICKS'  'LAYERLABELS'  'ALAYERLABELS'  'PARTITIONTICKS'  'APARTITIONTICKS'  'PARTITIONLABELS'  'APARTITIONLABELS'  'NODELABELS'  'ANODELABELS'  'RANDOMIZE'  'RANDOM_SEED'  'A'  'A_CHECK'  'NODENUMBER'  'LAYERNUMBER'  'PARTITIONS'  'M_DICT'  'COMPATIBLE_MEASURES'  'MEASURE'  'PFGA'  'PFGH'  'B'  'SEMIPOSITIVIZE_RULE'  'ATTEMPTSPEREDGE'  'RANDOMIZATION' };
				tag = graphbd_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(GraphBD, POINTER) returns category of POINTER of GraphBD.
			%  CATEGORY = G.GETPROPCATEGORY(GraphBD, POINTER) returns category of POINTER of GraphBD.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('GraphBD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GraphBD.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			graphbd_category_list = { 1  1  1  3  4  2  2  6  1  6  6  6  6  2  6  2  6  2  6  2  6  2  6  3  3  5  6  5  5  5  5  1  6  9  9  4  3  3  6 };
			prop_category = graphbd_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(GraphBD, POINTER) returns format of POINTER of GraphBD.
			%  FORMAT = G.GETPROPFORMAT(GraphBD, POINTER) returns format of POINTER of GraphBD.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('GraphBD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphBD.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			graphbd_format_list = { 2  2  2  8  2  2  2  2  11  15  15  15  11  12  12  3  3  12  12  3  3  3  3  4  11  16  4  12  11  12  10  7  8  8  8  15  5  11  16 };
			prop_format = graphbd_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GraphBD, POINTER) returns description of POINTER of GraphBD.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(GraphBD, POINTER) returns description of POINTER of GraphBD.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('GraphBD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphBD.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			graphbd_description_list = { 'ELCLASS (constant, string) is the class of the binary directed graph.'  'NAME (constant, string) is the name of the binary directed graph.'  'DESCRIPTION (constant, string) is the description of the binary directed graph.'  'TEMPLATE (parameter, item) is the template of the binary directed graph.'  'ID (data, string) is a few-letter code for the binary directed graph.'  'LABEL (metadata, string) is an extended label of the binary directed graph.'  'NOTES (metadata, string) are some specific notes about the binary directed graph.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'GRAPH_TYPE (constant, scalar) returns the graph type Graph.GRAPH.'  'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type Graph.BINARY.'  'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type Graph.DIRECTED.'  'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type Graph.NONSELFCONNECTED.'  'NEGATIVITY_TYPE (query, smatrix) returns the negativity type Graph.NONNEGATIVE.'  'LAYERTICKS (metadata, rvector) are the layer tick values.'  'ALAYERTICKS (query, rvector) returns the layer tick values.'  'LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.'  'ALAYERLABELS (query, stringlist) returns the layer labels for A.'  'PARTITIONTICKS (metadata, rvector) are the partition tick values.'  'APARTITIONTICKS (query, rvector) returns the partition tick values.'  'PARTITIONLABELS (metadata, stringlist) are the partition labels provided by the user.'  'APARTITIONLABELS (query, stringlist) returns the partition labels for A.'  'NODELABELS (metadata, stringlist) are the node labels provided by the user.'  'ANODELABELS (query, stringlist) returns the node labels for each layer.'  'RANDOMIZE (parameter, logical) determines whether to randomize the graph.'  'RANDOM_SEED (parameter, scalar) is the randomization seed.'  'A (result, cell) is the binary adjacency matrix of the binary directed graph.'  'A_CHECK (query, logical) checks the format of the adjacency matrix.'  'NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.'  'LAYERNUMBER (result, scalar) returns the number of layers in the graph.'  'PARTITIONS (result, rvector) returns the number of layers in the partitions of the graph.'  'M_DICT (result, idict) contains the calculated measures of the graph.'  'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.'  'MEASURE (query, item) returns a measure.'  'PFGA (gui, item) contains the panel figure of the graph adjacency matrix.'  'PFGH (gui, item) contains the panel figure of the graph histogram.'  'B (data, smatrix) is the input graph adjacency matrix.'  'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.'  'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.'  'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.' };
			prop_description = graphbd_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(GraphBD, POINTER) returns settings of POINTER of GraphBD.
			%  SETTINGS = G.GETPROPSETTINGS(GraphBD, POINTER) returns settings of POINTER of GraphBD.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('GraphBD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GraphBD.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % GraphBD.B
					prop_settings = Format.getFormatSettings(15);
				case 37 % GraphBD.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case 38 % GraphBD.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(11);
				case 39 % GraphBD.RANDOMIZATION
					prop_settings = Format.getFormatSettings(16);
				case 4 % GraphBD.TEMPLATE
					prop_settings = 'GraphBD';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GraphBD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphBD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(GraphBD, POINTER) returns the default value of POINTER of GraphBD.
			%  DEFAULT = G.GETPROPDEFAULT(GraphBD, POINTER) returns the default value of POINTER of GraphBD.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('GraphBD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GraphBD.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 36 % GraphBD.B
					prop_default = Format.getFormatDefault(15, GraphBD.getPropSettings(prop));
				case 37 % GraphBD.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(5, GraphBD.getPropSettings(prop));
				case 38 % GraphBD.ATTEMPTSPEREDGE
					prop_default = 5;
				case 39 % GraphBD.RANDOMIZATION
					prop_default = Format.getFormatDefault(16, GraphBD.getPropSettings(prop));
				case 1 % GraphBD.ELCLASS
					prop_default = 'GraphBD';
				case 2 % GraphBD.NAME
					prop_default = 'Graph Binary Directed';
				case 3 % GraphBD.DESCRIPTION
					prop_default = 'In a binary directed graph (GraphBD), the edges are directed and they can be either 0 (absence of connection) or 1 (existence of connection).';
				case 4 % GraphBD.TEMPLATE
					prop_default = Format.getFormatDefault(8, GraphBD.getPropSettings(prop));
				case 5 % GraphBD.ID
					prop_default = 'GraphBD ID';
				case 6 % GraphBD.LABEL
					prop_default = 'GraphBD label';
				case 7 % GraphBD.NOTES
					prop_default = 'GraphBD notes';
				case 9 % GraphBD.GRAPH_TYPE
					prop_default = 1;
				case 32 % GraphBD.COMPATIBLE_MEASURES
					prop_default = { 'AssortInIn'  'AssortInOut'  'AssortOutIn'  'AssortOutOut'  'BetweennessCentrality'  'Clustering'  'ClusteringAv'  'CommunityStructure'  'CorePeriphery'  'DegreeIn'  'DegreeInAv'  'DegreeOut'  'DegreeOutAv'  'Distance'  'EccentricityIn'  'EccentricityInAv'  'EccentricityOut'  'EccentricityOutAv'  'EdgeBetwCentr'  'GlobalEfficiencyIn'  'GlobalEfficiencyInAv'  'GlobalEfficiencyOut'  'GlobalEfficiencyOutAv'  'KCore'  'KCorenessCentrality'  'Modularity'  'Participation'  'PathLengthIn'  'PathLengthInAv'  'PathLengthOut'  'PathLengthOutAv'  'RCDeg'  'RichClub'  'Richness'  'Transitivity'  'Triangles' };
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GraphBD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphBD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GraphBD, POINTER) returns the conditioned default value of POINTER of GraphBD.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(GraphBD, POINTER) returns the conditioned default value of POINTER of GraphBD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('GraphBD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GraphBD.getPropProp(pointer);
			
			prop_default = GraphBD.conditioning(prop, GraphBD.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GraphBD, PROP, VALUE) checks VALUE format for PROP of GraphBD.
			%  CHECK = G.CHECKPROP(GraphBD, PROP, VALUE) checks VALUE format for PROP of GraphBD.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GraphBD:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: BRAPH2:GraphBD:WrongInput
			%  Element.CHECKPROP(GraphBD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphBD.
			%   Error id: BRAPH2:GraphBD:WrongInput
			%  G.CHECKPROP(GraphBD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphBD.
			%   Error id: BRAPH2:GraphBD:WrongInput]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('GraphBD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GraphBD.getPropProp(pointer);
			
			switch prop
				case 36 % GraphBD.B
					check = Format.checkFormat(15, value, GraphBD.getPropSettings(prop));
				case 37 % GraphBD.SEMIPOSITIVIZE_RULE
					check = Format.checkFormat(5, value, GraphBD.getPropSettings(prop));
				case 38 % GraphBD.ATTEMPTSPEREDGE
					check = Format.checkFormat(11, value, GraphBD.getPropSettings(prop));
				case 39 % GraphBD.RANDOMIZATION
					check = Format.checkFormat(16, value, GraphBD.getPropSettings(prop));
				case 4 % GraphBD.TEMPLATE
					check = Format.checkFormat(8, value, GraphBD.getPropSettings(prop));
				otherwise
					if prop <= 35
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GraphBD:' 'WrongInput'], ...
					['BRAPH2' ':GraphBD:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GraphBD.getPropTag(prop) ' (' GraphBD.getFormatTag(GraphBD.getPropFormat(prop)) ').'] ...
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
				case 39 % GraphBD.RANDOMIZATION
					rng(g.get('RANDOM_SEED'), 'twister')
					
					if isempty(varargin)
					    value = {};
					    return
					end
					
					A = cell2mat(varargin{1});
					attempts_per_edge = g.get('ATTEMPTSPEREDGE');
					% remove self connections
					A(1:length(A)+1:numel(A)) = 0;
					[I_edges, J_edges] = find(A); % find all the edges
					E = length(I_edges); % number of edges
					
					if E == 0
					    value = A;
					    swaps = 0;
					    return
					end
					
					if E == 1
					    r_ab = A(I_edges(1), J_edges(1));
					    A(I_edges(1), J_edges(1)) = 0;
					    selected_nodes = randperm(size(A, 1), 2);
					    A(selected_nodes(1), selected_nodes(2)) = r_ab;
					    value = A;
					    swaps = 1;
					    return
					end
					
					random_A = A;
					swaps = 0; % number of successful edge swaps
					for attempt = 1:1:attempts_per_edge*E
					
					    % select two edges
					    selected_edges = randperm(E,2);
					    node_start_1 = I_edges(selected_edges(1));
					    node_end_1 = J_edges(selected_edges(1));
					    node_start_2 = I_edges(selected_edges(2));
					    node_end_2 = J_edges(selected_edges(2));
					    
					    
					    r_1 = random_A(node_start_1, node_end_1);
					    r_2 = random_A(node_start_2, node_end_2);
					
					    r_1 = random_A(node_start_1, node_end_1);
					    r_2 = random_A(node_start_2, node_end_2);
					
					    % Swap edges if:
					    % 1) no edge between node_start_2 and node_end_1
					    % 2) no edge between node_start_1 and node_end_2
					    % 3) node_start_1 ~= node_start_2
					    % 4) node_end_1 ~= node_end_2
					    % 5) node_start_1 ~= node_end_2
					    % 6) node_start_2 ~= node_end_1
					    if ~random_A(node_start_1, node_end_2) && ...
					            ~random_A(node_start_2, node_end_1) && ...
					            node_start_1~=node_start_2 && ...
					            node_end_1~=node_end_2 && ...
					            node_start_1~=node_end_2 && ...
					            node_start_2~=node_end_1
					        % erase old edges
					        random_A(node_start_1, node_end_1) = 0;
					        random_A(node_start_2, node_end_2) = 0;
					
					        % write new edges
					        random_A(node_start_1, node_end_2) = r_1;
					        random_A(node_start_2, node_end_1) = r_2;
					
					        % update edge list
					        J_edges(selected_edges(1)) = node_end_2;
					        J_edges(selected_edges(2)) = node_end_1;
					
					        swaps = swaps+1;
					    end
					end
					value = random_A;
					
				case 10 % GraphBD.CONNECTIVITY_TYPE
					value = 2;
					
				case 11 % GraphBD.DIRECTIONALITY_TYPE
					value = 1;
					
				case 12 % GraphBD.SELFCONNECTIVITY_TYPE
					value = 1;
					
				case 13 % GraphBD.NEGATIVITY_TYPE
					value = 1;
					
				case 26 % GraphBD.A
					rng_settings_ = rng(); rng(g.getPropSeed(26), 'twister')
					
					B = g.get('B'); %#ok<PROPLC>
					
					B = dediagonalize(B); %#ok<PROPLC> % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(B, 'DediagonalizeRule', 0)
					B = semipositivize(B, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); %#ok<PROPLC> % removes negative weights
					B = binarize(B); %#ok<PROPLC> % enforces binary adjacency matrix, equivalent to binarize(B, 'threshold', 0, 'bins', [-1:.001:1])
					
					A = {B}; %#ok<PROPLC>
					if g.get('RANDOMIZE')
					    random_A = g.get('RANDOMIZATION', A);
					    A = {random_A};
					end
					value = A;
					
					rng(rng_settings_)
					
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
				case 36 % GraphBD.B
					pr = PanelPropMatrix('EL', g, 'PROP', 36, ...
					    'TABLE_HEIGHT', 480, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case 26 % GraphBD.A
					pr = PanelPropCell('EL', g, 'PROP', 26, ...
					    'TABLE_HEIGHT', 480, ...
					    'XSLIDERSHOW', false, ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:} ...
					    );
					
				otherwise
					pr = getPanelProp@Graph(g, prop, varargin{:});
					
			end
		end
	end
end
