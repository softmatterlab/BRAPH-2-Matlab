classdef Graph < ConcreteElement
	%Graph is a graph.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Graph provides the methods necessary for all graphs.
	%  Instances of this class should not be created. 
	%  Use one of its subclasses instead.
	% 
	% The kinds of graphs are:
	%  
	%  1. <strong>Graph</strong>: A graph consists of a single layer.
	% 
	%  2. <strong>Multigraph</strong>: A multigraph consists of multiple unconnected layers.
	%  
	%  3. <strong>Ordered Multipex</strong>: An ordered multiplex consists of a sequence of layers with ordinal connectionsbetween corresponding nodes in subsequent layers.
	% 
	%  4. <strong>Multiplex</strong>: A multiplex consists of multiple layers with categorical connections between corresponding nodes in different layers.
	% 
	%  5. <strong>Ordered Multilayer</strong>: An ordered multilayer consists of multiple layers with ordinal connections between any nodes.
	% 
	%  6. <strong>Multilayer</strong>: A multilayer consists of multiple layers with categorical between any nodes.
	%
	% The list of Graph properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the graph (Graph).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the graph.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the graph.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the graph.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the graph.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the graph.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graph.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>GRAPH_TYPE</strong> 	GRAPH_TYPE (constant, scalar) is the graph type.
	%  <strong>10</strong> <strong>CONNECTIVITY_TYPE</strong> 	CONNECTIVITY_TYPE (query, smatrix) is the connectivity type of the graph.
	%  <strong>11</strong> <strong>DIRECTIONALITY_TYPE</strong> 	DIRECTIONALITY_TYPE (query, smatrix) is the directionality type of the graph.
	%  <strong>12</strong> <strong>SELFCONNECTIVITY_TYPE</strong> 	SELFCONNECTIVITY_TYPE (query, smatrix) is the self-connectivity type of the graph.
	%  <strong>13</strong> <strong>NEGATIVITY_TYPE</strong> 	NEGATIVITY_TYPE (query, scalar) is the negativity type of the graph.
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
	%  <strong>26</strong> <strong>A</strong> 	A (result, cell) is the graph adjacency matrix. 
	%  <strong>27</strong> <strong>A_CHECK</strong> 	A_CHECK (query, logical) checks the format of the adjacency matrix.
	%  <strong>28</strong> <strong>NODENUMBER</strong> 	NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.
	%  <strong>29</strong> <strong>LAYERNUMBER</strong> 	LAYERNUMBER (result, scalar) returns the number of layers in the graph.
	%  <strong>30</strong> <strong>PARTITIONS</strong> 	PARTITIONS (result, rvector) returns the number of layers in the partitions of the graph.
	%  <strong>31</strong> <strong>M_DICT</strong> 	M_DICT (result, idict) contains the calculated measures of the graph.
	%  <strong>32</strong> <strong>COMPATIBLE_MEASURES</strong> 	COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
	%  <strong>33</strong> <strong>MEASURE</strong> 	MEASURE (query, item) returns a measure.
	%  <strong>34</strong> <strong>PFGA</strong> 	PFGA (gui, item) contains the panel figure of the graph adjacency matrix.
	%  <strong>35</strong> <strong>PFGH</strong> 	PFGH (gui, item) contains the panel figure of the graph histogram.
	%
	% Graph methods (constructor):
	%  Graph - constructor
	%
	% Graph methods:
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
	% Graph methods (display):
	%  tostring - string with information about the graph
	%  disp - displays information about the graph
	%  tree - displays the tree of the graph
	%
	% Graph methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph
	%
	% Graph methods (save/load, Static):
	%  save - saves BRAPH2 graph as b2 file
	%  load - loads a BRAPH2 graph from a b2 file
	%
	% Graph method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph
	%
	% Graph method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph
	%
	% Graph methods (inspection, Static):
	%  getClass - returns the class of the graph
	%  getSubclasses - returns all subclasses of Graph
	%  getProps - returns the property list of the graph
	%  getPropNumber - returns the property number of the graph
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
	% Graph methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Graph methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Graph methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Graph methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Graph; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Graph constants</a>.
	%
	%
	% See also Measure.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % constants
		% Graph types
		GRAPH = 1
		GRAPH_NAME = 'Graph'
		GRAPH_DESCRIPTION = 'A graph consists of a single layer.'
		
		MULTIGRAPH = 2
		MULTIGRAPH_NAME = 'Multigraph'
		MULTIGRAPH_DESCRIPTION = 'A multigraph consists of multiple unconnected layers.'
		
		ORDERED_MULTIPLEX = 3
		ORDERED_MULTIPLEX_NAME = 'Ordered Multipex'
		ORDERED_MULTIPLEX_DESCRIPTION = ['An ordered multiplex consists of ' ...
		    'a sequence of layers with ordinal connections' ...
		    'between corresponding nodes in subsequent layers.']
		
		MULTIPLEX = 4
		MULTIPLEX_NAME = 'Multiplex'
		MULTIPLEX_DESCRIPTION = ['A multiplex consists of ' ...
		    'multiple layers with categorical connections ' ...
		    'between corresponding nodes in different layers.']
		
		ORDERED_MULTILAYER = 5
		ORDERED_MULTILAYER_NAME = 'Ordered Multilayer'
		ORDERED_MULTILAYER_DESCRIPTION = ['An ordered multilayer consists of ' ...
		    'multiple layers with ordinal connections between any nodes.']
		
		MULTILAYER = 6
		MULTILAYER_NAME = 'Multilayer'
		MULTILAYER_DESCRIPTION = ['A multilayer consists of ' ...
		    'multiple layers with categorical between any nodes.']
		
		TYPE_NUMBER = 6
		
		TYPE_NAME = {
		    'Graph'
		    'Multigraph'
		    'Ordered Multipex'
		    'Multiplex'
		    'Ordered Multilayer'
		    'Multilayer'
		    }
		
		TYPE_DESCRIPTION = {
		    'A graph consists of a single layer.'
		    'A multigraph consists of multiple unconnected layers.'
		    'An ordered multiplex consists of a sequence of layers with ordinal connectionsbetween corresponding nodes in subsequent layers.'
		    'A multiplex consists of multiple layers with categorical connections between corresponding nodes in different layers.'
		    'An ordered multilayer consists of multiple layers with ordinal connections between any nodes.'
		    'A multilayer consists of multiple layers with categorical between any nodes.'
		    }
		
		% Connectivity types
		WEIGHTED = 1
		WEIGHTED_NAME = 'Weighted'
		WEIGHTED_DESCRIPTION = 'Graph with weighted connections.'
		
		BINARY = 2
		BINARY_NAME = 'Binary'
		BINARY_DESCRIPTION = 'Graph with binary (0 or 1) connections.'
		
		CONNECTIVITY_TYPE_NUMBER = 2
		
		CONNECTIVITY_TYPE_NAME = {
		    'Weighted'
		    'Binary'
		    }
		
		CONNECTIVITY_TYPE_DESCRIPTION = {
		    'Graph with weighted connections.'
		    'Graph with binary (0 or 1) connections.'
		    }
		
		% Directionality types
		DIRECTED = 1
		DIRECTED_NAME = 'Directed'
		DIRECTED_DESCRIPTION = 'Graph with directed edges.'
		
		UNDIRECTED = 2
		UNDIRECTED_NAME = 'Undirected'
		UNDIRECTED_DESCRIPTION = 'Graph with undirected edges.'
		
		DIRECTIONALITY_TYPE_NUMBER = 2
		
		DIRECTIONALITY_TYPE_NAME = {
		    'Directed'
		    'Undirected'
		    }
		
		DIRECTIONALITY_TYPE_DESCRIPTION = {
		    'Graph with directed edges.'
		    'Graph with undirected edges.'
		    }
		
		% Selfconnectedness types
		NONSELFCONNECTED = 1
		NONSELFCONNECTED_NAME = 'Non-self-connected'
		NONSELFCONNECTED_DESCRIPTION = 'Graph without self-connections.';
		
		SELFCONNECTED = 2
		SELFCONNECTED_NAME = 'Self-connected'
		SELFCONNECTED_DESCRIPTION = 'Graph with self-connections.';
		
		SELFCONNECTIVITY_TYPE_NUMBER = 2
		
		SELFCONNECTIVITY_TYPE_NAME = {
		    'Non-self-connected'
		    'Self-connected'
		    }
		
		SELFCONNECTIVITY_TYPE_DESCRIPTION = {
		    'Graph without self-connections.'
		    'Graph with self-connections.'
		    }
		
		% Negativity
		NONNEGATIVE = 1
		NONNEGATIVE_NAME = 'Non-negative';
		NONNEGATIVE_DESCRIPTION = 'Graph without negative edges.';
		
		NEGATIVE = 2
		NEGATIVE_NAME = 'Negative';
		NEGATIVE_DESCRIPTION = 'Graph allowing negative edges.';
		
		NEGATIVITY_TYPE_NUMBER = 2
		
		NEGATIVITY_TYPE_NAME = {
		    'Non-negative'
		    'Negative'
		    }
		
		NEGATIVITY_TYPE_DESCRIPTION = {
		    'Graph without negative edges.'
		    'Graph allowing negative edges.'
		    }
	end
	properties (Constant) % properties
		GRAPH_TYPE = 9; %CET: Computational Efficiency Trick
		GRAPH_TYPE_TAG = 'GRAPH_TYPE';
		GRAPH_TYPE_CATEGORY = 1;
		GRAPH_TYPE_FORMAT = 11;
		
		CONNECTIVITY_TYPE = 10; %CET: Computational Efficiency Trick
		CONNECTIVITY_TYPE_TAG = 'CONNECTIVITY_TYPE';
		CONNECTIVITY_TYPE_CATEGORY = 6;
		CONNECTIVITY_TYPE_FORMAT = 15;
		
		DIRECTIONALITY_TYPE = 11; %CET: Computational Efficiency Trick
		DIRECTIONALITY_TYPE_TAG = 'DIRECTIONALITY_TYPE';
		DIRECTIONALITY_TYPE_CATEGORY = 6;
		DIRECTIONALITY_TYPE_FORMAT = 15;
		
		SELFCONNECTIVITY_TYPE = 12; %CET: Computational Efficiency Trick
		SELFCONNECTIVITY_TYPE_TAG = 'SELFCONNECTIVITY_TYPE';
		SELFCONNECTIVITY_TYPE_CATEGORY = 6;
		SELFCONNECTIVITY_TYPE_FORMAT = 15;
		
		NEGATIVITY_TYPE = 13; %CET: Computational Efficiency Trick
		NEGATIVITY_TYPE_TAG = 'NEGATIVITY_TYPE';
		NEGATIVITY_TYPE_CATEGORY = 6;
		NEGATIVITY_TYPE_FORMAT = 11;
		
		LAYERTICKS = 14; %CET: Computational Efficiency Trick
		LAYERTICKS_TAG = 'LAYERTICKS';
		LAYERTICKS_CATEGORY = 2;
		LAYERTICKS_FORMAT = 12;
		
		ALAYERTICKS = 15; %CET: Computational Efficiency Trick
		ALAYERTICKS_TAG = 'ALAYERTICKS';
		ALAYERTICKS_CATEGORY = 6;
		ALAYERTICKS_FORMAT = 12;
		
		LAYERLABELS = 16; %CET: Computational Efficiency Trick
		LAYERLABELS_TAG = 'LAYERLABELS';
		LAYERLABELS_CATEGORY = 2;
		LAYERLABELS_FORMAT = 3;
		
		ALAYERLABELS = 17; %CET: Computational Efficiency Trick
		ALAYERLABELS_TAG = 'ALAYERLABELS';
		ALAYERLABELS_CATEGORY = 6;
		ALAYERLABELS_FORMAT = 3;
		
		PARTITIONTICKS = 18; %CET: Computational Efficiency Trick
		PARTITIONTICKS_TAG = 'PARTITIONTICKS';
		PARTITIONTICKS_CATEGORY = 2;
		PARTITIONTICKS_FORMAT = 12;
		
		APARTITIONTICKS = 19; %CET: Computational Efficiency Trick
		APARTITIONTICKS_TAG = 'APARTITIONTICKS';
		APARTITIONTICKS_CATEGORY = 6;
		APARTITIONTICKS_FORMAT = 12;
		
		PARTITIONLABELS = 20; %CET: Computational Efficiency Trick
		PARTITIONLABELS_TAG = 'PARTITIONLABELS';
		PARTITIONLABELS_CATEGORY = 2;
		PARTITIONLABELS_FORMAT = 3;
		
		APARTITIONLABELS = 21; %CET: Computational Efficiency Trick
		APARTITIONLABELS_TAG = 'APARTITIONLABELS';
		APARTITIONLABELS_CATEGORY = 6;
		APARTITIONLABELS_FORMAT = 3;
		
		NODELABELS = 22; %CET: Computational Efficiency Trick
		NODELABELS_TAG = 'NODELABELS';
		NODELABELS_CATEGORY = 2;
		NODELABELS_FORMAT = 3;
		
		ANODELABELS = 23; %CET: Computational Efficiency Trick
		ANODELABELS_TAG = 'ANODELABELS';
		ANODELABELS_CATEGORY = 6;
		ANODELABELS_FORMAT = 3;
		
		RANDOMIZE = 24; %CET: Computational Efficiency Trick
		RANDOMIZE_TAG = 'RANDOMIZE';
		RANDOMIZE_CATEGORY = 3;
		RANDOMIZE_FORMAT = 4;
		
		RANDOM_SEED = 25; %CET: Computational Efficiency Trick
		RANDOM_SEED_TAG = 'RANDOM_SEED';
		RANDOM_SEED_CATEGORY = 3;
		RANDOM_SEED_FORMAT = 11;
		
		A = 26; %CET: Computational Efficiency Trick
		A_TAG = 'A';
		A_CATEGORY = 5;
		A_FORMAT = 16;
		
		A_CHECK = 27; %CET: Computational Efficiency Trick
		A_CHECK_TAG = 'A_CHECK';
		A_CHECK_CATEGORY = 6;
		A_CHECK_FORMAT = 4;
		
		NODENUMBER = 28; %CET: Computational Efficiency Trick
		NODENUMBER_TAG = 'NODENUMBER';
		NODENUMBER_CATEGORY = 5;
		NODENUMBER_FORMAT = 12;
		
		LAYERNUMBER = 29; %CET: Computational Efficiency Trick
		LAYERNUMBER_TAG = 'LAYERNUMBER';
		LAYERNUMBER_CATEGORY = 5;
		LAYERNUMBER_FORMAT = 11;
		
		PARTITIONS = 30; %CET: Computational Efficiency Trick
		PARTITIONS_TAG = 'PARTITIONS';
		PARTITIONS_CATEGORY = 5;
		PARTITIONS_FORMAT = 12;
		
		M_DICT = 31; %CET: Computational Efficiency Trick
		M_DICT_TAG = 'M_DICT';
		M_DICT_CATEGORY = 5;
		M_DICT_FORMAT = 10;
		
		COMPATIBLE_MEASURES = 32; %CET: Computational Efficiency Trick
		COMPATIBLE_MEASURES_TAG = 'COMPATIBLE_MEASURES';
		COMPATIBLE_MEASURES_CATEGORY = 1;
		COMPATIBLE_MEASURES_FORMAT = 7;
		
		MEASURE = 33; %CET: Computational Efficiency Trick
		MEASURE_TAG = 'MEASURE';
		MEASURE_CATEGORY = 6;
		MEASURE_FORMAT = 8;
		
		PFGA = 34; %CET: Computational Efficiency Trick
		PFGA_TAG = 'PFGA';
		PFGA_CATEGORY = 9;
		PFGA_FORMAT = 8;
		
		PFGH = 35; %CET: Computational Efficiency Trick
		PFGH_TAG = 'PFGH';
		PFGH_CATEGORY = 9;
		PFGH_FORMAT = 8;
	end
	methods % constructor
		function g = Graph(varargin)
			%Graph() creates a graph.
			%
			% Graph(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Graph(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Graph properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the graph (Graph).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the graph.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the graph.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the graph.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the graph.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the graph.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graph.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>GRAPH_TYPE</strong> 	GRAPH_TYPE (constant, scalar) is the graph type.
			%  <strong>10</strong> <strong>CONNECTIVITY_TYPE</strong> 	CONNECTIVITY_TYPE (query, smatrix) is the connectivity type of the graph.
			%  <strong>11</strong> <strong>DIRECTIONALITY_TYPE</strong> 	DIRECTIONALITY_TYPE (query, smatrix) is the directionality type of the graph.
			%  <strong>12</strong> <strong>SELFCONNECTIVITY_TYPE</strong> 	SELFCONNECTIVITY_TYPE (query, smatrix) is the self-connectivity type of the graph.
			%  <strong>13</strong> <strong>NEGATIVITY_TYPE</strong> 	NEGATIVITY_TYPE (query, scalar) is the negativity type of the graph.
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
			%  <strong>26</strong> <strong>A</strong> 	A (result, cell) is the graph adjacency matrix. 
			%  <strong>27</strong> <strong>A_CHECK</strong> 	A_CHECK (query, logical) checks the format of the adjacency matrix.
			%  <strong>28</strong> <strong>NODENUMBER</strong> 	NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.
			%  <strong>29</strong> <strong>LAYERNUMBER</strong> 	LAYERNUMBER (result, scalar) returns the number of layers in the graph.
			%  <strong>30</strong> <strong>PARTITIONS</strong> 	PARTITIONS (result, rvector) returns the number of layers in the partitions of the graph.
			%  <strong>31</strong> <strong>M_DICT</strong> 	M_DICT (result, idict) contains the calculated measures of the graph.
			%  <strong>32</strong> <strong>COMPATIBLE_MEASURES</strong> 	COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
			%  <strong>33</strong> <strong>MEASURE</strong> 	MEASURE (query, item) returns a measure.
			%  <strong>34</strong> <strong>PFGA</strong> 	PFGA (gui, item) contains the panel figure of the graph adjacency matrix.
			%  <strong>35</strong> <strong>PFGH</strong> 	PFGH (gui, item) contains the panel figure of the graph histogram.
			%
			% See also Category, Format.
			
			g = g@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the graph.
			%
			% BUILD = Graph.GETBUILD() returns the build of 'Graph'.
			%
			% Alternative forms to call this method are:
			%  BUILD = G.GETBUILD() returns the build of the graph G.
			%  BUILD = Element.GETBUILD(G) returns the build of 'G'.
			%  BUILD = Element.GETBUILD('Graph') returns the build of 'Graph'.
			%
			% Note that the Element.GETBUILD(G) and Element.GETBUILD('Graph')
			%  are less computationally efficient.
			
			build = 1;
		end
		function g_class = getClass()
			%GETCLASS returns the class of the graph.
			%
			% CLASS = Graph.GETCLASS() returns the class 'Graph'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('Graph') returns 'Graph'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('Graph')
			%  are less computationally efficient.
			
			g_class = 'Graph';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph.
			%
			% LIST = Graph.GETSUBCLASSES() returns all subclasses of 'Graph'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('Graph') returns all subclasses of 'Graph'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('Graph')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'Graph'  'GraphBD'  'GraphBU'  'GraphWD'  'GraphWU'  'MultigraphBUD'  'MultigraphBUT'  'MultilayerBD'  'MultilayerBU'  'MultilayerBUD'  'MultilayerBUT'  'MultilayerWD'  'MultilayerWU'  'MultiplexBD'  'MultiplexBU'  'MultiplexBUD'  'MultiplexBUT'  'MultiplexWD'  'MultiplexWU'  'OrdMlBD'  'OrdMlBU'  'OrdMlBUD'  'OrdMlBUT'  'OrdMlWD'  'OrdMlWU'  'OrdMxBD'  'OrdMxBU'  'OrdMxBUD'  'OrdMxBUT'  'OrdMxWD'  'OrdMxWU' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph.
			%
			% PROPS = Graph.GETPROPS() returns the property list of graph
			%  as a row vector.
			%
			% PROPS = Graph.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('Graph'[, CATEGORY]) returns the property list of 'Graph'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('Graph')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3 9 32];
				case 2 % Category.METADATA
					prop_list = [6 7 14 16 18 20 22];
				case 3 % Category.PARAMETER
					prop_list = [4 24 25];
				case 4 % Category.DATA
					prop_list = 5;
				case 5 % Category.RESULT
					prop_list = [26 28 29 30 31];
				case 6 % Category.QUERY
					prop_list = [8 10 11 12 13 15 17 19 21 23 27 33];
				case 9 % Category.GUI
					prop_list = [34 35];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph.
			%
			% N = Graph.GETPROPNUMBER() returns the property number of graph.
			%
			% N = Graph.GETPROPNUMBER(CATEGORY) returns the property number of graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('Graph') returns the property number of 'Graph'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('Graph')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 35;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 5;
				case 2 % Category.METADATA
					prop_number = 7;
				case 3 % Category.PARAMETER
					prop_number = 3;
				case 4 % Category.DATA
					prop_number = 1;
				case 5 % Category.RESULT
					prop_number = 5;
				case 6 % Category.QUERY
					prop_number = 12;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph/error.
			%
			% CHECK = Graph.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(Graph, PROP) checks whether PROP exists for Graph.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Graph:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:Graph:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:Graph:WrongInput]
			%  Element.EXISTSPROP(Graph, PROP) throws error if PROP does NOT exist for Graph.
			%   Error id: [BRAPH2:Graph:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('Graph')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 35 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Graph:' 'WrongInput'], ...
					['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Graph.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph/error.
			%
			% CHECK = Graph.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(Graph, TAG) checks whether TAG exists for Graph.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Graph:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:Graph:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:Graph:WrongInput]
			%  Element.EXISTSTAG(Graph, TAG) throws error if TAG does NOT exist for Graph.
			%   Error id: [BRAPH2:Graph:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('Graph')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GRAPH_TYPE'  'CONNECTIVITY_TYPE'  'DIRECTIONALITY_TYPE'  'SELFCONNECTIVITY_TYPE'  'NEGATIVITY_TYPE'  'LAYERTICKS'  'ALAYERTICKS'  'LAYERLABELS'  'ALAYERLABELS'  'PARTITIONTICKS'  'APARTITIONTICKS'  'PARTITIONLABELS'  'APARTITIONLABELS'  'NODELABELS'  'ANODELABELS'  'RANDOMIZE'  'RANDOM_SEED'  'A'  'A_CHECK'  'NODENUMBER'  'LAYERNUMBER'  'PARTITIONS'  'M_DICT'  'COMPATIBLE_MEASURES'  'MEASURE'  'PFGA'  'PFGH' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Graph:' 'WrongInput'], ...
					['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for Graph.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Graph, POINTER) returns property number of POINTER of Graph.
			%  PROPERTY = G.GETPROPPROP(Graph, POINTER) returns property number of POINTER of Graph.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('Graph')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GRAPH_TYPE'  'CONNECTIVITY_TYPE'  'DIRECTIONALITY_TYPE'  'SELFCONNECTIVITY_TYPE'  'NEGATIVITY_TYPE'  'LAYERTICKS'  'ALAYERTICKS'  'LAYERLABELS'  'ALAYERLABELS'  'PARTITIONTICKS'  'APARTITIONTICKS'  'PARTITIONLABELS'  'APARTITIONLABELS'  'NODELABELS'  'ANODELABELS'  'RANDOMIZE'  'RANDOM_SEED'  'A'  'A_CHECK'  'NODENUMBER'  'LAYERNUMBER'  'PARTITIONS'  'M_DICT'  'COMPATIBLE_MEASURES'  'MEASURE'  'PFGA'  'PFGH' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(Graph, POINTER) returns tag of POINTER of Graph.
			%  TAG = G.GETPROPTAG(Graph, POINTER) returns tag of POINTER of Graph.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('Graph')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				graph_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GRAPH_TYPE'  'CONNECTIVITY_TYPE'  'DIRECTIONALITY_TYPE'  'SELFCONNECTIVITY_TYPE'  'NEGATIVITY_TYPE'  'LAYERTICKS'  'ALAYERTICKS'  'LAYERLABELS'  'ALAYERLABELS'  'PARTITIONTICKS'  'APARTITIONTICKS'  'PARTITIONLABELS'  'APARTITIONLABELS'  'NODELABELS'  'ANODELABELS'  'RANDOMIZE'  'RANDOM_SEED'  'A'  'A_CHECK'  'NODENUMBER'  'LAYERNUMBER'  'PARTITIONS'  'M_DICT'  'COMPATIBLE_MEASURES'  'MEASURE'  'PFGA'  'PFGH' };
				tag = graph_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(Graph, POINTER) returns category of POINTER of Graph.
			%  CATEGORY = G.GETPROPCATEGORY(Graph, POINTER) returns category of POINTER of Graph.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('Graph')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			graph_category_list = { 1  1  1  3  4  2  2  6  1  6  6  6  6  2  6  2  6  2  6  2  6  2  6  3  3  5  6  5  5  5  5  1  6  9  9 };
			prop_category = graph_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(Graph, POINTER) returns format of POINTER of Graph.
			%  FORMAT = G.GETPROPFORMAT(Graph, POINTER) returns format of POINTER of Graph.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('Graph')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			graph_format_list = { 2  2  2  8  2  2  2  2  11  15  15  15  11  12  12  3  3  12  12  3  3  3  3  4  11  16  4  12  11  12  10  7  8  8  8 };
			prop_format = graph_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Graph, POINTER) returns description of POINTER of Graph.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(Graph, POINTER) returns description of POINTER of Graph.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('Graph')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			graph_description_list = { 'ELCLASS (constant, string) is the class of the graph (Graph).'  'NAME (constant, string) is the name of the graph.'  'DESCRIPTION (constant, string) is the description of the graph.'  'TEMPLATE (parameter, item) is the template of the graph.'  'ID (data, string) is a few-letter code for the graph.'  'LABEL (metadata, string) is an extended label of the graph.'  'NOTES (metadata, string) are some specific notes about the graph.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'GRAPH_TYPE (constant, scalar) is the graph type.'  'CONNECTIVITY_TYPE (query, smatrix) is the connectivity type of the graph.'  'DIRECTIONALITY_TYPE (query, smatrix) is the directionality type of the graph.'  'SELFCONNECTIVITY_TYPE (query, smatrix) is the self-connectivity type of the graph.'  'NEGATIVITY_TYPE (query, scalar) is the negativity type of the graph.'  'LAYERTICKS (metadata, rvector) are the layer tick values.'  'ALAYERTICKS (query, rvector) returns the layer tick values.'  'LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.'  'ALAYERLABELS (query, stringlist) returns the layer labels for A.'  'PARTITIONTICKS (metadata, rvector) are the partition tick values.'  'APARTITIONTICKS (query, rvector) returns the partition tick values.'  'PARTITIONLABELS (metadata, stringlist) are the partition labels provided by the user.'  'APARTITIONLABELS (query, stringlist) returns the partition labels for A.'  'NODELABELS (metadata, stringlist) are the node labels provided by the user.'  'ANODELABELS (query, stringlist) returns the node labels for each layer.'  'RANDOMIZE (parameter, logical) determines whether to randomize the graph.'  'RANDOM_SEED (parameter, scalar) is the randomization seed.'  'A (result, cell) is the graph adjacency matrix. '  'A_CHECK (query, logical) checks the format of the adjacency matrix.'  'NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.'  'LAYERNUMBER (result, scalar) returns the number of layers in the graph.'  'PARTITIONS (result, rvector) returns the number of layers in the partitions of the graph.'  'M_DICT (result, idict) contains the calculated measures of the graph.'  'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.'  'MEASURE (query, item) returns a measure.'  'PFGA (gui, item) contains the panel figure of the graph adjacency matrix.'  'PFGH (gui, item) contains the panel figure of the graph histogram.' };
			prop_description = graph_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(Graph, POINTER) returns settings of POINTER of Graph.
			%  SETTINGS = G.GETPROPSETTINGS(Graph, POINTER) returns settings of POINTER of Graph.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('Graph')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % Graph.GRAPH_TYPE
					prop_settings = Format.getFormatSettings(11);
				case 10 % Graph.CONNECTIVITY_TYPE
					prop_settings = Format.getFormatSettings(15);
				case 11 % Graph.DIRECTIONALITY_TYPE
					prop_settings = Format.getFormatSettings(15);
				case 12 % Graph.SELFCONNECTIVITY_TYPE
					prop_settings = Format.getFormatSettings(15);
				case 13 % Graph.NEGATIVITY_TYPE
					prop_settings = Format.getFormatSettings(11);
				case 14 % Graph.LAYERTICKS
					prop_settings = Format.getFormatSettings(12);
				case 15 % Graph.ALAYERTICKS
					prop_settings = Format.getFormatSettings(12);
				case 16 % Graph.LAYERLABELS
					prop_settings = Format.getFormatSettings(3);
				case 17 % Graph.ALAYERLABELS
					prop_settings = Format.getFormatSettings(3);
				case 18 % Graph.PARTITIONTICKS
					prop_settings = Format.getFormatSettings(12);
				case 19 % Graph.APARTITIONTICKS
					prop_settings = Format.getFormatSettings(12);
				case 20 % Graph.PARTITIONLABELS
					prop_settings = Format.getFormatSettings(3);
				case 21 % Graph.APARTITIONLABELS
					prop_settings = Format.getFormatSettings(3);
				case 22 % Graph.NODELABELS
					prop_settings = Format.getFormatSettings(3);
				case 23 % Graph.ANODELABELS
					prop_settings = Format.getFormatSettings(3);
				case 24 % Graph.RANDOMIZE
					prop_settings = Format.getFormatSettings(4);
				case 25 % Graph.RANDOM_SEED
					prop_settings = Format.getFormatSettings(11);
				case 26 % Graph.A
					prop_settings = Format.getFormatSettings(16);
				case 27 % Graph.A_CHECK
					prop_settings = Format.getFormatSettings(4);
				case 28 % Graph.NODENUMBER
					prop_settings = Format.getFormatSettings(12);
				case 29 % Graph.LAYERNUMBER
					prop_settings = Format.getFormatSettings(11);
				case 30 % Graph.PARTITIONS
					prop_settings = Format.getFormatSettings(12);
				case 31 % Graph.M_DICT
					prop_settings = 'Measure';
				case 32 % Graph.COMPATIBLE_MEASURES
					prop_settings = 'Measure';
				case 33 % Graph.MEASURE
					prop_settings = 'Measure';
				case 34 % Graph.PFGA
					prop_settings = 'GraphAdjPF';
				case 35 % Graph.PFGH
					prop_settings = 'GraphHistPF';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Graph.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Graph.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(Graph, POINTER) returns the default value of POINTER of Graph.
			%  DEFAULT = G.GETPROPDEFAULT(Graph, POINTER) returns the default value of POINTER of Graph.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('Graph')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % Graph.GRAPH_TYPE
					prop_default = 1;
				case 10 % Graph.CONNECTIVITY_TYPE
					prop_default = Format.getFormatDefault(15, Graph.getPropSettings(prop));
				case 11 % Graph.DIRECTIONALITY_TYPE
					prop_default = Format.getFormatDefault(15, Graph.getPropSettings(prop));
				case 12 % Graph.SELFCONNECTIVITY_TYPE
					prop_default = Format.getFormatDefault(15, Graph.getPropSettings(prop));
				case 13 % Graph.NEGATIVITY_TYPE
					prop_default = Format.getFormatDefault(11, Graph.getPropSettings(prop));
				case 14 % Graph.LAYERTICKS
					prop_default = Format.getFormatDefault(12, Graph.getPropSettings(prop));
				case 15 % Graph.ALAYERTICKS
					prop_default = Format.getFormatDefault(12, Graph.getPropSettings(prop));
				case 16 % Graph.LAYERLABELS
					prop_default = Format.getFormatDefault(3, Graph.getPropSettings(prop));
				case 17 % Graph.ALAYERLABELS
					prop_default = Format.getFormatDefault(3, Graph.getPropSettings(prop));
				case 18 % Graph.PARTITIONTICKS
					prop_default = Format.getFormatDefault(12, Graph.getPropSettings(prop));
				case 19 % Graph.APARTITIONTICKS
					prop_default = Format.getFormatDefault(12, Graph.getPropSettings(prop));
				case 20 % Graph.PARTITIONLABELS
					prop_default = Format.getFormatDefault(3, Graph.getPropSettings(prop));
				case 21 % Graph.APARTITIONLABELS
					prop_default = Format.getFormatDefault(3, Graph.getPropSettings(prop));
				case 22 % Graph.NODELABELS
					prop_default = {'numbered'};
				case 23 % Graph.ANODELABELS
					prop_default = Format.getFormatDefault(3, Graph.getPropSettings(prop));
				case 24 % Graph.RANDOMIZE
					prop_default = Format.getFormatDefault(4, Graph.getPropSettings(prop));
				case 25 % Graph.RANDOM_SEED
					prop_default = Format.getFormatDefault(11, Graph.getPropSettings(prop));
				case 26 % Graph.A
					prop_default = Format.getFormatDefault(16, Graph.getPropSettings(prop));
				case 27 % Graph.A_CHECK
					prop_default = Format.getFormatDefault(4, Graph.getPropSettings(prop));
				case 28 % Graph.NODENUMBER
					prop_default = Format.getFormatDefault(12, Graph.getPropSettings(prop));
				case 29 % Graph.LAYERNUMBER
					prop_default = Format.getFormatDefault(11, Graph.getPropSettings(prop));
				case 30 % Graph.PARTITIONS
					prop_default = Format.getFormatDefault(12, Graph.getPropSettings(prop));
				case 31 % Graph.M_DICT
					prop_default = Format.getFormatDefault(10, Graph.getPropSettings(prop));
				case 32 % Graph.COMPATIBLE_MEASURES
					prop_default = Format.getFormatDefault(7, Graph.getPropSettings(prop));
				case 33 % Graph.MEASURE
					prop_default = Format.getFormatDefault(8, Graph.getPropSettings(prop));
				case 34 % Graph.PFGA
					prop_default = Format.getFormatDefault(8, Graph.getPropSettings(prop));
				case 35 % Graph.PFGH
					prop_default = Format.getFormatDefault(8, Graph.getPropSettings(prop));
				case 1 % Graph.ELCLASS
					prop_default = 'Graph';
				case 2 % Graph.NAME
					prop_default = 'Graph';
				case 3 % Graph.DESCRIPTION
					prop_default = 'A Graph provides the methods necessary for all graphs. Instances of this class should not be created. Use one of its subclasses instead.';
				case 5 % Graph.ID
					prop_default = 'Graph ID';
				case 6 % Graph.LABEL
					prop_default = 'Graph label';
				case 7 % Graph.NOTES
					prop_default = 'Graph notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Graph.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Graph.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Graph, POINTER) returns the conditioned default value of POINTER of Graph.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(Graph, POINTER) returns the conditioned default value of POINTER of Graph.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('Graph')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			prop_default = Graph.conditioning(prop, Graph.getPropDefault(prop));
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
			
			prop = Graph.getPropProp(pointer);
			
			switch prop
				case 22 % Graph.NODELABELS
					if isa(value, 'BrainAtlas')
					    value = value.get('BR_DICT').get('KEYS');
					end
					
				otherwise
					if prop <= 8
						value = conditioning@ConcreteElement(pointer, value);
					end
			end
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
			%  CHECK = Element.CHECKPROP(Graph, PROP, VALUE) checks VALUE format for PROP of Graph.
			%  CHECK = G.CHECKPROP(Graph, PROP, VALUE) checks VALUE format for PROP of Graph.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:Graph:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: BRAPH2:Graph:WrongInput
			%  Element.CHECKPROP(Graph, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Graph.
			%   Error id: BRAPH2:Graph:WrongInput
			%  G.CHECKPROP(Graph, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Graph.
			%   Error id: BRAPH2:Graph:WrongInput]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('Graph')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Graph.getPropProp(pointer);
			
			switch prop
				case 9 % Graph.GRAPH_TYPE
					check = Format.checkFormat(11, value, Graph.getPropSettings(prop));
				case 10 % Graph.CONNECTIVITY_TYPE
					check = Format.checkFormat(15, value, Graph.getPropSettings(prop));
				case 11 % Graph.DIRECTIONALITY_TYPE
					check = Format.checkFormat(15, value, Graph.getPropSettings(prop));
				case 12 % Graph.SELFCONNECTIVITY_TYPE
					check = Format.checkFormat(15, value, Graph.getPropSettings(prop));
				case 13 % Graph.NEGATIVITY_TYPE
					check = Format.checkFormat(11, value, Graph.getPropSettings(prop));
				case 14 % Graph.LAYERTICKS
					check = Format.checkFormat(12, value, Graph.getPropSettings(prop));
				case 15 % Graph.ALAYERTICKS
					check = Format.checkFormat(12, value, Graph.getPropSettings(prop));
				case 16 % Graph.LAYERLABELS
					check = Format.checkFormat(3, value, Graph.getPropSettings(prop));
				case 17 % Graph.ALAYERLABELS
					check = Format.checkFormat(3, value, Graph.getPropSettings(prop));
				case 18 % Graph.PARTITIONTICKS
					check = Format.checkFormat(12, value, Graph.getPropSettings(prop));
				case 19 % Graph.APARTITIONTICKS
					check = Format.checkFormat(12, value, Graph.getPropSettings(prop));
				case 20 % Graph.PARTITIONLABELS
					check = Format.checkFormat(3, value, Graph.getPropSettings(prop));
				case 21 % Graph.APARTITIONLABELS
					check = Format.checkFormat(3, value, Graph.getPropSettings(prop));
				case 22 % Graph.NODELABELS
					check = Format.checkFormat(3, value, Graph.getPropSettings(prop));
				case 23 % Graph.ANODELABELS
					check = Format.checkFormat(3, value, Graph.getPropSettings(prop));
				case 24 % Graph.RANDOMIZE
					check = Format.checkFormat(4, value, Graph.getPropSettings(prop));
				case 25 % Graph.RANDOM_SEED
					check = Format.checkFormat(11, value, Graph.getPropSettings(prop));
				case 26 % Graph.A
					check = Format.checkFormat(16, value, Graph.getPropSettings(prop));
				case 27 % Graph.A_CHECK
					check = Format.checkFormat(4, value, Graph.getPropSettings(prop));
				case 28 % Graph.NODENUMBER
					check = Format.checkFormat(12, value, Graph.getPropSettings(prop));
				case 29 % Graph.LAYERNUMBER
					check = Format.checkFormat(11, value, Graph.getPropSettings(prop));
				case 30 % Graph.PARTITIONS
					check = Format.checkFormat(12, value, Graph.getPropSettings(prop));
				case 31 % Graph.M_DICT
					check = Format.checkFormat(10, value, Graph.getPropSettings(prop));
				case 32 % Graph.COMPATIBLE_MEASURES
					check = Format.checkFormat(7, value, Graph.getPropSettings(prop));
				case 33 % Graph.MEASURE
					check = Format.checkFormat(8, value, Graph.getPropSettings(prop));
				case 34 % Graph.PFGA
					check = Format.checkFormat(8, value, Graph.getPropSettings(prop));
				case 35 % Graph.PFGH
					check = Format.checkFormat(8, value, Graph.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Graph:' 'WrongInput'], ...
					['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Graph.getPropTag(prop) ' (' Graph.getFormatTag(Graph.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(g, prop)
			%POSTPROCESSING postprocessesing after setting.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% The postprocessing of all properties occurs each time set is called.
			%
			% See also conditioning, preset, checkProp, postset, calculateValue,
			%  checkValue.
			
			switch prop
				case 34 % Graph.PFGA
					if isa(g.getr('PFGA'), 'NoValue')
					    g.memorize('PFGA').set('G', g)
					end
					
				case 35 % Graph.PFGH
					if isa(g.getr('PFGH'), 'NoValue')
					    g.memorize('PFGH').set('G', g)
					end
					
				otherwise
					if prop <= 8
						postprocessing@ConcreteElement(g, prop);
					end
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
				case 10 % Graph.CONNECTIVITY_TYPE
					value = 1;
					
				case 11 % Graph.DIRECTIONALITY_TYPE
					value = 1;
					
				case 12 % Graph.SELFCONNECTIVITY_TYPE
					value = 2;
					
				case 13 % Graph.NEGATIVITY_TYPE
					value = 2;
					
				case 15 % Graph.ALAYERTICKS
					alayerticks = g.get('LAYERTICKS');
					if isempty(alayerticks) && ~isa(g.getr('A'), 'NoValue') % ensures that it's not unecessarily calculated
					    alayerticks = [1:1:g.get('LAYERNUMBER')];
					end
					value = alayerticks;
					
				case 17 % Graph.ALAYERLABELS
					value = g.get('LAYERLABELS');
					
				case 19 % Graph.APARTITIONTICKS
					value = g.get('PARTITIONTICKS');
					
				case 21 % Graph.APARTITIONLABELS
					value = g.get('PARTITIONLABELS');
					
				case 23 % Graph.ANODELABELS
					value = g.get('NODELABELS');
					
				case 26 % Graph.A
					rng_settings_ = rng(); rng(g.getPropSeed(26), 'twister')
					
					value = {};
					
					rng(rng_settings_)
					
				case 27 % Graph.A_CHECK
					A = g.get('A');
					checkA(g.get('GRAPH_TYPE'), A);  % performs all necessary checks on A
					checkConnectivity(g.get('CONNECTIVITY_TYPE', length(A)), A);
					checkDirectionality(g.get('DIRECTIONALITY_TYPE', length(A)), A);
					checkSelfConnectivity(g.get('SELFCONNECTIVITY_TYPE', length(A)), A);
					checkNegativity(g.get('NEGATIVITY_TYPE', length(A)), A);
					value = true; % only if no error is thrown by the previous code!
					
				case 28 % Graph.NODENUMBER
					rng_settings_ = rng(); rng(g.getPropSeed(28), 'twister')
					
					A = g.get('A');
					value = cellfun(@(a) length(a), A(1:length(A)+1:end)); % vector with number of nodes per layer
					
					rng(rng_settings_)
					
				case 29 % Graph.LAYERNUMBER
					rng_settings_ = rng(); rng(g.getPropSeed(29), 'twister')
					
					value = length(g.get('A')); % number of layers
					
					rng(rng_settings_)
					
				case 30 % Graph.PARTITIONS
					rng_settings_ = rng(); rng(g.getPropSeed(30), 'twister')
					
					value = g.get('LAYERNUMBER'); % by default, there is a single partition
					
					rng(rng_settings_)
					
				case 31 % Graph.M_DICT
					rng_settings_ = rng(); rng(g.getPropSeed(31), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'Measure', 'IT_KEY', 1);
					
					rng(rng_settings_)
					
				case 33 % Graph.MEASURE
					% M = g.get('MEASURE', MEASURE_CLASS) checks whether the measure exists in the
					%  property M_DICT. If not, it creates a new measure M of class MEASURE_CLASS
					%  with properties defined by the graph settings. The user must call
					%  getValue() for the new measure M to retrieve the value of measure M.
					if isempty(varargin)
					    value = Measure();
					    
					    % % Warning commented because it most likely will lead to an error anyways
					    % warning( ...
					    %     ['BRAPH2' ':' class(g)], ...
					    %     ['BRAPH2' ':' class(g) '\n' ...
					    %     'Missing argument MEASURE_CLASS when using Graph.get(''MEASURE'', MEASURE_CLASS).'] ...
					    %     )
					    
					    return
					end
					measure_class = varargin{1};
					
					m_list = g.get('COMPATIBLE_MEASURES');
					if ~contains(measure_class, m_list)
					    error(...
					        ['BRAPH2' ':Graph:' 'WrongInput'], ...
					        ['BRAPH2' ':Graph:' 'WrongInput' ' \n' ...
					        measure_class ' is not a compatible Measure with ' g.getClass() '. \n' ...
					        'Use ' g.getClass() '().get(''COMPATIBLE_MEASURES'') for a list of compatible measures.'])
					end
					
					m_dict = g.memorize('M_DICT');
					if m_dict.get('CONTAINS_KEY', measure_class)
					    m = m_dict.get('IT', measure_class);
					else
					    if isa(g.getr('TEMPLATE'), 'NoValue')
					        m = eval([measure_class '(''ID'', measure_class, ''G'', g)']);
					    else % the graph has a template
					        m_template = g.get('TEMPLATE').get('MEASURE', measure_class); %#ok<NASGU>
					        
					        m = eval([measure_class '(''ID'', measure_class, ''G'', g, ''TEMPLATE'', m_template)']);
					    end
					
					    m_dict.get('ADD', m);
					end
					
					value = m;
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(g, prop, varargin{:});
					else
						value = calculateValue@Element(g, prop, varargin{:});
					end
			end
			
			function checkA(graph_type, A)
			    %CHECKA checks whether adjacency matrix A is correct for the type of graph.
			    %
			    % CHECKA(GRAPH_TYPE, A) checks if adjacency matrix A is correct for the
			    %  GRAPH_TYPE.
			    %
			    % See also checkConnectivity, checkDirectionality, checkNegativity,
			    % checkSelfConnectivity.
			
			    % Basic checks
			    % square cell array of matrices
			    if ~iscell(A) || ~ismatrix(A) || size(A, 1) ~= size(A, 2)
			        error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			            ['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
			            'A must be a superadjacency matrix (square cell array of matrices).'])
			    end
			    % all submatrices in the diagonal are square
			    if any(cellfun(@(a) size(a, 1) ~= size(a, 2), A(1:length(A)+1:end)))
			        error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			            ['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
			            'All submatrices in the cell diagonal must be square.'])
			    end
			
			    % Additional checks
			    switch graph_type
			        case 1 % Graph.GRAPH
			            % no additional checks
			
			        case  2 % Graph.MULTIGRAPH
			            % no additional checks
			
			        case 3 % Graph.ORDERED_MULTIPLEX
			            if ~isempty(A) && any(cellfun(@(a) size(a, 1), A(1:length(A)+1:end)) ~= cellfun(@(a) size(a, 1), A(1, 1)))
			                error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                    ['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
			                    'In a sequence, submatrices in the cell diagonal must have the same dimensions.'])
			            end
			            if ~isempty(A) && any(cellfun(@(a) size(a, 1), A(2:length(A)+1:end)) ~= cellfun(@(a) size(a, 1), A(1, 1)))
			                erro(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                    ['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
			                    'In a sequence, submatrices in the cell sub-diagonal must have the same dimensions.'])
			            end
			            if ~isempty(A) && any(cellfun(@(a) size(a, 1), A(length(A)+1:length(A)+1:end)) ~= cellfun(@(a) size(a, 1), A(1, 1)))
			                erro(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                    ['BRAPH2' ':Graph:' 'WrongInput'
			                    'In a sequence, submatrices in the cell super-diagonal must have the same dimensions.'])
			            end
			
			        case 4 % Graph.MULTIPLEX
			            % all submatrices must be square.
			            if any(cellfun(@(a) size(a, 1) ~= size(a, 2), A(:)))
			                error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                    ['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
			                    'In a multiplex, all submatrices must be square.'])
			            end
			            % all submatrices have same dimensions.
			            if ~isempty(A) && any(cellfun(@(a) size(a, 1), A(:)) ~= cellfun(@(a) size(a, 1), A(1, 1)))
			                error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                    ['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
			                    'In a multiplex, all submatrices must have the same dimensions.'])
			            end
			
			        case 5 % Graph.ORDERED_MULTILAYER
			            if any(cellfun(@(a) size(a, 1), A(2:length(A)+1:end)) ~= cellfun(@(a) size(a, 1), A(length(A)+2:length(A)+1:end)))
			                error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                    ['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
			                    'Sub-diagonal submatrices in the same row must have the same number of rows.'])
			            end
			            if any(cellfun(@(a) size(a, 2), A(2:length(A)+1:end)) ~= cellfun(@(a) size(a, 2), A(1:length(A)+1:end-1)))
			                error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                    ['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
			                    'Sub-diagonal submatrices in the same column must have the same number of columns.'])
			            end
			            if any(cellfun(@(a) size(a, 1), A(length(A)+1:length(A)+1:end)) ~= cellfun(@(a) size(a, 1), A(1:length(A)+1:end-1)))
			                error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                    ['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
			                    'Super-diagonal submatrices in the same row must have the same number of rows.'])
			            end
			            if any(cellfun(@(a) size(a, 2), A(length(A)+1:length(A)+1:end)) ~= cellfun(@(a) size(a, 2), A(length(A)+2:length(A)+1:end)))
			                error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                    ['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
			                    'Super-diagonal submatrices in the same column must have the same number of columns.'])
			            end
			
			        case 6 % Graph.MULTILAYER
			            if any(any(cellfun(@(a) size(a, 1), A) ~= cellfun(@(a) size(a, 1), A(:, 1))))
			                error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                    ['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
			                    'All submatrices in the same row must have the same number of rows.'])
			            end
			            if any(any(cellfun(@(a) size(a, 2), A) ~= cellfun(@(a) size(a, 2), A(1, :))))
			                error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                    ['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
			                    'All submatrices in the same column must have the same number of columns.'])
			            end
			    end
			end
			function checkConnectivity(connectivity_type, A)
			    %CHECKCONNECTIVITY checks if adjacency matrix A is correct for the connectivity type.
			    %
			    % CHECKCONNECTIVITY(CONNECTIVITY_TYPE, A) checks if adjacency matrix A is
			    %  correct for the CONNECTIVITY_TYPE of the graph.
			    %  This check assumes that checkA has already been passed.
			    %
			    % See also checkA, checkDirectionality, checkNegativity, checkSelfConnectivity.
			
			    if isnumeric(A)  % A is a matrix
			        switch connectivity_type
			            case 2 % Graph.BINARY
			                if any(any(A ~= 0 & A ~= 1))
			                    error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                        ['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
			                        'For connectivity type Graph.BINARY (%i), A must be binary (0s and 1s),' ...
			                        ' while it is ' mat2str(A)], ...
			                        2)
			                end
			
			            case 1 % Graph.WEIGHTED
			                % no further check needed
			
			            otherwise
			                error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                    ['Connectivity type must be Graph.BINARY (%i) or Graph.WEIGHTED (%i),' ...
			                    ' while it is ' mat2str(connectivity_type)], ...
			                    2, 1)
			        end
			    else  % A is 2D cell array
			
			        if numel(connectivity_type) == 1
			            connectivity_type = connectivity_type * ones(size(A));
			        end
			
			        for i = 1:1:size(A, 1)
			            for j = 1:1:size(A, 2)
			                checkConnectivity(connectivity_type(i, j), A{i, j});
			            end
			        end
			    end
			end
			function checkDirectionality(directionality_type, A, At)
			    %CHECKDIRECTIONALITY checks if adjacency matrix A is correct for the directionality type.
			    %
			    % CHECKDIRECTIONALITY(DIRECTIONALITY_TYPE, A) checks if adjacency matrix A
			    %  is correct for the DIRECTIONALITY_TYPE of the graph.
			    %  This check assumes that checkA has already been passed.
			    %
			    % See also checkA, checkConnectivity, checkNegativity, checkSelfConnectivity.
			
			    if nargin < 3
			        At = A';
			    end
			
			    if isnumeric(A)  % A is a matrix
			        switch directionality_type
			            case 2 % Graph.UNDIRECTED
			                assert(all(all(A == At)), ...
			                    ['BRAPH2' ':Graph:' 'WrongInput'], ...
			                    ['For directionality type _Graph.UNDIRECTED_ (%i), A must equal to At,' ...
			                    ' while it is A = ' mat2str(A) ...
			                    ' and At = ' mat2str(At)], ...
			                    2)
			
			            case 1 % Graph.DIRECTED
			                % no further check needed
			
			            otherwise
			                error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                    ['Directionality type must be Graph.DIRECTED (%i) or Graph.UNDIRECTED (%i),' ...
			                    ' while it is ' mat2str(directionality_type)], ...
			                    1, 2)
			        end
			    else  % A is 2D cell array
			
			        if numel(directionality_type) == 1
			            directionality_type = directionality_type * ones(size(A));
			        end
			        assert(all(all(directionality_type == directionality_type')), ...
			            ['BRAPH2' ':Graph:' 'WrongInput'], ...
			            ['The directionality type must be symmetric,' ...
			            ' while it is ' mat2str(directionality_type)])
			
			        for i = 1:1:size(A, 1)
			            for j = 1:1:size(A, 2)
			                checkDirectionality(directionality_type(i, j), A{i, j}, A{j, i}');
			            end
			        end
			    end
			end
			function checkSelfConnectivity(selfconnectivity_type, A)
			    %CHECKSELFCONNECTIVITY checks if adjacency matrix A is correct for the self-connectivity type.
			    %
			    % CHECKSELFCONNECTIVITY(SELFCONNECTIVITY_TYPE, A) checks if adjacency
			    %  matrix A is correct for the SELFCONNECTIVITY_TYPE of the graph.
			    %  This check assumes that checkA has already been passed.
			    %
			    % See also checkA, checkConnectivity, checkDirectionality, checkNegativity.
			
			    if isnumeric(A)  % A is a matrix
			        switch selfconnectivity_type
			            case 1 % Graph.NONSELFCONNECTED
			                if any(any(A(1:length(A)+1:end) ~= 0))
			                    error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                        ['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
			                        'For self-connectivity type Graph.NONSELFCONNECTED (%i), A must have' ...
			                        ' 0 values along the diagonal while it is ' mat2str(A)], ...
			                        1)
			                end
			
			            case 2 % Graph.SELFCONNECTED
			                % no further check needed
			
			            otherwise
			                error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                    ['Self-connectivity type must be Graph.SELFCONNECTED (%i) or' ...
			                    ' Graph.NONSELFCONNECTED (%i), while it is ' mat2str(selfconnectivity_type)], ...
			                    2, 1)
			        end
			    else  % A is 2D cell array
			
			        if numel(selfconnectivity_type) == 1
			            selfconnectivity_type = selfconnectivity_type * ones(size(A));
			        end
			
			        for i = 1:1:size(A, 1)
			            checkSelfConnectivity(selfconnectivity_type(i, i), A{i, i});
			        end
			    end
			end
			function checkNegativity(negativity_type, A)
			    %CHECKNEGATIVITY checks if adjacency matrix A is correct for the negativity type.
			    %
			    % CHECKNEGATIVITY(NEGATIVITY_TYPE, A) checks if adjacency matrix A is
			    %  correct for the NEGATIVITY_TYPE of the graph.
			    %  This check assumes that checkA has already been passed.
			    %
			    % See also checkA, checkConnectivity, checkDirectionality, checkSelfConnectivity.
			
			    if isnumeric(A)  % A is a matrix
			        switch negativity_type
			            case 1 % Graph.NONNEGATIVE
			                if any(any(A < 0))
			                    error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                        ['BRAPH2' ':Graph:' 'WrongInput' '\n' ...
			                        'For negativity type Graph.NONNEGATIVE (%i), A must have' ...
			                        ' non-negative values, while it is ' mat2str(A)], ...
			                        1)
			                end
			                
			            case 2 % Graph.NEGATIVE
			                % no further check needed
			
			            otherwise
			                error(['BRAPH2' ':Graph:' 'WrongInput'], ...
			                    ['Negativity type must be Graph.NEGATIVE (%i) or' ...
			                    ' Graph.NONNEGATIVE (%i), while it is ' mat2str(negativity_type)], ...
			                    2, 1)
			        end
			    else  % A is 2D cell array
			
			        if numel(negativity_type) == 1
			            negativity_type = negativity_type * ones(size(A));
			        end
			
			        for i = 1:1:size(A, 1)
			            for j = 1:1:size(A, 2)
			                checkNegativity(negativity_type(i, j), A{i, j});
			            end
			        end
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
				case 14 % Graph.LAYERTICKS
					pr = PanelPropRVectorSmart('EL', g, 'PROP', 14, varargin{:});
					
				case 18 % Graph.PARTITIONTICKS
					pr = PanelPropRVectorSmart('EL', g, 'PROP', 18, varargin{:});
					
				case 31 % Graph.M_DICT
					pr = GraphPP_MDict('EL', g, 'PROP', 31, varargin{:});
					
				case 34 % Graph.PFGA
					pr = PanelPropItem('EL', g, 'PROP', 34, ...
					    'GUICLASS', 'GUIFig', ...
					    'BUTTON_TEXT', 'Plot Adjacency Matrix', ...
					    varargin{:});
					
				case 35 % Graph.PFGH
					pr = PanelPropItem('EL', g, 'PROP', 35, ...
					    'GUICLASS', 'GUIFig', ...
					    'BUTTON_TEXT', 'Plot Histogram', ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(g, prop, varargin{:});
					
			end
		end
	end
end
