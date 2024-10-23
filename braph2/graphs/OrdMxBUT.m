classdef OrdMxBUT < OrdMxWU
	%OrdMxBUT is a ordinal multiplex binary undirected with fixed thresholds.
	% It is a subclass of <a href="matlab:help OrdMxWU">OrdMxWU</a>.
	%
	% In a ordinal multiplex binary undirected graph with fixed thresholds (OrdMxBUT), 
	% all the layers consist of binary undirected multiplex graphs 
	% derived from the same weighted supra-connectivity matrices 
	% binarized at different thresholds.
	% The supra-connectivity matrix has a number of partitions equal to the number of thresholds.
	% The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.
	%
	% The list of OrdMxBUT properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the ordinal multiplex binary undirected with fixed thresholds.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ordinal multiplex binary undirected with fixed thresholds.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the binary undirected multiplex with fixed thresholds.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ordinal multiplex binary undirected with fixed thresholds.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ordinal multiplex binary undirected with fixed thresholds.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ordinal multiplex binary undirected with fixed thresholds.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ordinal multiplex binary undirected with fixed thresholds.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>GRAPH_TYPE</strong> 	GRAPH_TYPE (constant, scalar) returns the graph type Graph.ORDERED_MULTIPLEX.
	%  <strong>10</strong> <strong>CONNECTIVITY_TYPE</strong> 	CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type Graph.BINARY * ones(layernumber).
	%  <strong>11</strong> <strong>DIRECTIONALITY_TYPE</strong> 	DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type Graph.UNDIRECTED * ones(layernumber).
	%  <strong>12</strong> <strong>SELFCONNECTIVITY_TYPE</strong> 	SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type Graph.NONSELFCONNECTED on the diagonal and Graph.SELFCONNECTED off diagonal.
	%  <strong>13</strong> <strong>NEGATIVITY_TYPE</strong> 	NEGATIVITY_TYPE (query, smatrix) returns the negativity type Graph.NONNEGATIVE * ones(layernumber).
	%  <strong>14</strong> <strong>LAYERTICKS</strong> 	LAYERTICKS (metadata, rvector) are the layer tick values.
	%  <strong>15</strong> <strong>ALAYERTICKS</strong> 	ALAYERTICKS (query, rvector) returns the layer tick values.
	%  <strong>16</strong> <strong>LAYERLABELS</strong> 	LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.
	%  <strong>17</strong> <strong>ALAYERLABELS</strong> 	ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.
	%  <strong>18</strong> <strong>PARTITIONTICKS</strong> 	PARTITIONTICKS (metadata, rvector) are the partition tick values.
	%  <strong>19</strong> <strong>APARTITIONTICKS</strong> 	APARTITIONTICKS (query, rvector) returns the partition (threshold) ticks for A.
	%  <strong>20</strong> <strong>PARTITIONLABELS</strong> 	PARTITIONLABELS (metadata, stringlist) are the partition labels provided by the user.
	%  <strong>21</strong> <strong>APARTITIONLABELS</strong> 	APARTITIONLABELS (query, stringlist) returns the partition (threshold) labels for A.
	%  <strong>22</strong> <strong>NODELABELS</strong> 	NODELABELS (metadata, stringlist) are the node labels provided by the user.
	%  <strong>23</strong> <strong>ANODELABELS</strong> 	ANODELABELS (query, stringlist) returns the node labels for each layer.
	%  <strong>24</strong> <strong>RANDOMIZE</strong> 	RANDOMIZE (parameter, logical) determines whether to randomize the graph.
	%  <strong>25</strong> <strong>RANDOM_SEED</strong> 	RANDOM_SEED (parameter, scalar) is the randomization seed.
	%  <strong>26</strong> <strong>A</strong> 	A (result, cell) is the cell array containing the binary supra-adjacency matrix of the binary undirected multiplex with fixed thresholds (BUT).
	%  <strong>27</strong> <strong>A_CHECK</strong> 	A_CHECK (query, logical) checks the format of the adjacency matrix.
	%  <strong>28</strong> <strong>NODENUMBER</strong> 	NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.
	%  <strong>29</strong> <strong>LAYERNUMBER</strong> 	LAYERNUMBER (result, scalar) returns the number of layers in the graph.
	%  <strong>30</strong> <strong>PARTITIONS</strong> 	PARTITIONS (result, rvector) returns the number of layers for each partition (threshold) of the graph.
	%  <strong>31</strong> <strong>M_DICT</strong> 	M_DICT (result, idict) contains the calculated measures of the graph.
	%  <strong>32</strong> <strong>COMPATIBLE_MEASURES</strong> 	COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
	%  <strong>33</strong> <strong>MEASURE</strong> 	MEASURE (query, item) returns a measure.
	%  <strong>34</strong> <strong>PFGA</strong> 	PFGA (gui, item) contains the panel figure of the graph adjacency matrix.
	%  <strong>35</strong> <strong>PFGH</strong> 	PFGH (gui, item) contains the panel figure of the graph histogram.
	%  <strong>36</strong> <strong>B</strong> 	B (data, cell) is the input cell containing the multiplex adjacency matrices on the diagonal.
	%  <strong>37</strong> <strong>SYMMETRIZE_RULE</strong> 	SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.
	%  <strong>38</strong> <strong>SEMIPOSITIVIZE_RULE</strong> 	SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.
	%  <strong>39</strong> <strong>STANDARDIZE_RULE</strong> 	STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.
	%  <strong>40</strong> <strong>ATTEMPTSPEREDGE</strong> 	ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
	%  <strong>41</strong> <strong>NUMBEROFWEIGHTS</strong> 	NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.
	%  <strong>42</strong> <strong>RANDOMIZATION</strong> 	RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.
	%  <strong>43</strong> <strong>THRESHOLDS</strong> 	THRESHOLDS (parameter, rvector) is the vector of thresholds.
	%
	% OrdMxBUT methods (constructor):
	%  OrdMxBUT - constructor
	%
	% OrdMxBUT methods:
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
	% OrdMxBUT methods (display):
	%  tostring - string with information about the ordinal multiplex binary undirected with fixed thresholds
	%  disp - displays information about the ordinal multiplex binary undirected with fixed thresholds
	%  tree - displays the tree of the ordinal multiplex binary undirected with fixed thresholds
	%
	% OrdMxBUT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ordinal multiplex binary undirected with fixed thresholds are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ordinal multiplex binary undirected with fixed thresholds
	%
	% OrdMxBUT methods (save/load, Static):
	%  save - saves BRAPH2 ordinal multiplex binary undirected with fixed thresholds as b2 file
	%  load - loads a BRAPH2 ordinal multiplex binary undirected with fixed thresholds from a b2 file
	%
	% OrdMxBUT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ordinal multiplex binary undirected with fixed thresholds
	%
	% OrdMxBUT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ordinal multiplex binary undirected with fixed thresholds
	%
	% OrdMxBUT methods (inspection, Static):
	%  getClass - returns the class of the ordinal multiplex binary undirected with fixed thresholds
	%  getSubclasses - returns all subclasses of OrdMxBUT
	%  getProps - returns the property list of the ordinal multiplex binary undirected with fixed thresholds
	%  getPropNumber - returns the property number of the ordinal multiplex binary undirected with fixed thresholds
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
	% OrdMxBUT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OrdMxBUT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OrdMxBUT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OrdMxBUT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OrdMxBUT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OrdMxBUT constants</a>.
	%
	
	properties (Constant) % properties
		THRESHOLDS = 43; %CET: Computational Efficiency Trick
		THRESHOLDS_TAG = 'THRESHOLDS';
		THRESHOLDS_CATEGORY = 3;
		THRESHOLDS_FORMAT = 12;
	end
	methods % constructor
		function g = OrdMxBUT(varargin)
			%OrdMxBUT() creates a ordinal multiplex binary undirected with fixed thresholds.
			%
			% OrdMxBUT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OrdMxBUT(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of OrdMxBUT properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the ordinal multiplex binary undirected with fixed thresholds.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the ordinal multiplex binary undirected with fixed thresholds.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the binary undirected multiplex with fixed thresholds.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the ordinal multiplex binary undirected with fixed thresholds.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the ordinal multiplex binary undirected with fixed thresholds.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the ordinal multiplex binary undirected with fixed thresholds.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the ordinal multiplex binary undirected with fixed thresholds.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>GRAPH_TYPE</strong> 	GRAPH_TYPE (constant, scalar) returns the graph type Graph.ORDERED_MULTIPLEX.
			%  <strong>10</strong> <strong>CONNECTIVITY_TYPE</strong> 	CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type Graph.BINARY * ones(layernumber).
			%  <strong>11</strong> <strong>DIRECTIONALITY_TYPE</strong> 	DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type Graph.UNDIRECTED * ones(layernumber).
			%  <strong>12</strong> <strong>SELFCONNECTIVITY_TYPE</strong> 	SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type Graph.NONSELFCONNECTED on the diagonal and Graph.SELFCONNECTED off diagonal.
			%  <strong>13</strong> <strong>NEGATIVITY_TYPE</strong> 	NEGATIVITY_TYPE (query, smatrix) returns the negativity type Graph.NONNEGATIVE * ones(layernumber).
			%  <strong>14</strong> <strong>LAYERTICKS</strong> 	LAYERTICKS (metadata, rvector) are the layer tick values.
			%  <strong>15</strong> <strong>ALAYERTICKS</strong> 	ALAYERTICKS (query, rvector) returns the layer tick values.
			%  <strong>16</strong> <strong>LAYERLABELS</strong> 	LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.
			%  <strong>17</strong> <strong>ALAYERLABELS</strong> 	ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.
			%  <strong>18</strong> <strong>PARTITIONTICKS</strong> 	PARTITIONTICKS (metadata, rvector) are the partition tick values.
			%  <strong>19</strong> <strong>APARTITIONTICKS</strong> 	APARTITIONTICKS (query, rvector) returns the partition (threshold) ticks for A.
			%  <strong>20</strong> <strong>PARTITIONLABELS</strong> 	PARTITIONLABELS (metadata, stringlist) are the partition labels provided by the user.
			%  <strong>21</strong> <strong>APARTITIONLABELS</strong> 	APARTITIONLABELS (query, stringlist) returns the partition (threshold) labels for A.
			%  <strong>22</strong> <strong>NODELABELS</strong> 	NODELABELS (metadata, stringlist) are the node labels provided by the user.
			%  <strong>23</strong> <strong>ANODELABELS</strong> 	ANODELABELS (query, stringlist) returns the node labels for each layer.
			%  <strong>24</strong> <strong>RANDOMIZE</strong> 	RANDOMIZE (parameter, logical) determines whether to randomize the graph.
			%  <strong>25</strong> <strong>RANDOM_SEED</strong> 	RANDOM_SEED (parameter, scalar) is the randomization seed.
			%  <strong>26</strong> <strong>A</strong> 	A (result, cell) is the cell array containing the binary supra-adjacency matrix of the binary undirected multiplex with fixed thresholds (BUT).
			%  <strong>27</strong> <strong>A_CHECK</strong> 	A_CHECK (query, logical) checks the format of the adjacency matrix.
			%  <strong>28</strong> <strong>NODENUMBER</strong> 	NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.
			%  <strong>29</strong> <strong>LAYERNUMBER</strong> 	LAYERNUMBER (result, scalar) returns the number of layers in the graph.
			%  <strong>30</strong> <strong>PARTITIONS</strong> 	PARTITIONS (result, rvector) returns the number of layers for each partition (threshold) of the graph.
			%  <strong>31</strong> <strong>M_DICT</strong> 	M_DICT (result, idict) contains the calculated measures of the graph.
			%  <strong>32</strong> <strong>COMPATIBLE_MEASURES</strong> 	COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
			%  <strong>33</strong> <strong>MEASURE</strong> 	MEASURE (query, item) returns a measure.
			%  <strong>34</strong> <strong>PFGA</strong> 	PFGA (gui, item) contains the panel figure of the graph adjacency matrix.
			%  <strong>35</strong> <strong>PFGH</strong> 	PFGH (gui, item) contains the panel figure of the graph histogram.
			%  <strong>36</strong> <strong>B</strong> 	B (data, cell) is the input cell containing the multiplex adjacency matrices on the diagonal.
			%  <strong>37</strong> <strong>SYMMETRIZE_RULE</strong> 	SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.
			%  <strong>38</strong> <strong>SEMIPOSITIVIZE_RULE</strong> 	SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.
			%  <strong>39</strong> <strong>STANDARDIZE_RULE</strong> 	STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.
			%  <strong>40</strong> <strong>ATTEMPTSPEREDGE</strong> 	ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
			%  <strong>41</strong> <strong>NUMBEROFWEIGHTS</strong> 	NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.
			%  <strong>42</strong> <strong>RANDOMIZATION</strong> 	RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.
			%  <strong>43</strong> <strong>THRESHOLDS</strong> 	THRESHOLDS (parameter, rvector) is the vector of thresholds.
			%
			% See also Category, Format.
			
			g = g@OrdMxWU(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the ordinal multiplex binary undirected with fixed thresholds.
			%
			% BUILD = OrdMxBUT.GETBUILD() returns the build of 'OrdMxBUT'.
			%
			% Alternative forms to call this method are:
			%  BUILD = G.GETBUILD() returns the build of the ordinal multiplex binary undirected with fixed thresholds G.
			%  BUILD = Element.GETBUILD(G) returns the build of 'G'.
			%  BUILD = Element.GETBUILD('OrdMxBUT') returns the build of 'OrdMxBUT'.
			%
			% Note that the Element.GETBUILD(G) and Element.GETBUILD('OrdMxBUT')
			%  are less computationally efficient.
			
			build = 1;
		end
		function g_class = getClass()
			%GETCLASS returns the class of the ordinal multiplex binary undirected with fixed thresholds.
			%
			% CLASS = OrdMxBUT.GETCLASS() returns the class 'OrdMxBUT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the ordinal multiplex binary undirected with fixed thresholds G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('OrdMxBUT') returns 'OrdMxBUT'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('OrdMxBUT')
			%  are less computationally efficient.
			
			g_class = 'OrdMxBUT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ordinal multiplex binary undirected with fixed thresholds.
			%
			% LIST = OrdMxBUT.GETSUBCLASSES() returns all subclasses of 'OrdMxBUT'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the ordinal multiplex binary undirected with fixed thresholds G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('OrdMxBUT') returns all subclasses of 'OrdMxBUT'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'OrdMxBUT' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ordinal multiplex binary undirected with fixed thresholds.
			%
			% PROPS = OrdMxBUT.GETPROPS() returns the property list of ordinal multiplex binary undirected with fixed thresholds
			%  as a row vector.
			%
			% PROPS = OrdMxBUT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the ordinal multiplex binary undirected with fixed thresholds G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('OrdMxBUT'[, CATEGORY]) returns the property list of 'OrdMxBUT'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3 9 32];
				case 2 % Category.METADATA
					prop_list = [6 7 14 16 18 20 22];
				case 3 % Category.PARAMETER
					prop_list = [4 24 25 37 38 39 40 41 43];
				case 4 % Category.DATA
					prop_list = [5 36];
				case 5 % Category.RESULT
					prop_list = [26 28 29 30 31];
				case 6 % Category.QUERY
					prop_list = [8 10 11 12 13 15 17 19 21 23 27 33 42];
				case 9 % Category.GUI
					prop_list = [34 35];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of ordinal multiplex binary undirected with fixed thresholds.
			%
			% N = OrdMxBUT.GETPROPNUMBER() returns the property number of ordinal multiplex binary undirected with fixed thresholds.
			%
			% N = OrdMxBUT.GETPROPNUMBER(CATEGORY) returns the property number of ordinal multiplex binary undirected with fixed thresholds
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the ordinal multiplex binary undirected with fixed thresholds G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('OrdMxBUT') returns the property number of 'OrdMxBUT'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 43;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 5;
				case 2 % Category.METADATA
					prop_number = 7;
				case 3 % Category.PARAMETER
					prop_number = 9;
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
			%EXISTSPROP checks whether property exists in ordinal multiplex binary undirected with fixed thresholds/error.
			%
			% CHECK = OrdMxBUT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(OrdMxBUT, PROP) checks whether PROP exists for OrdMxBUT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OrdMxBUT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBUT:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBUT:WrongInput]
			%  Element.EXISTSPROP(OrdMxBUT, PROP) throws error if PROP does NOT exist for OrdMxBUT.
			%   Error id: [BRAPH2:OrdMxBUT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 43 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':OrdMxBUT:' 'WrongInput'], ...
					['BRAPH2' ':OrdMxBUT:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OrdMxBUT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ordinal multiplex binary undirected with fixed thresholds/error.
			%
			% CHECK = OrdMxBUT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(OrdMxBUT, TAG) checks whether TAG exists for OrdMxBUT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OrdMxBUT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBUT:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:OrdMxBUT:WrongInput]
			%  Element.EXISTSTAG(OrdMxBUT, TAG) throws error if TAG does NOT exist for OrdMxBUT.
			%   Error id: [BRAPH2:OrdMxBUT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GRAPH_TYPE'  'CONNECTIVITY_TYPE'  'DIRECTIONALITY_TYPE'  'SELFCONNECTIVITY_TYPE'  'NEGATIVITY_TYPE'  'LAYERTICKS'  'ALAYERTICKS'  'LAYERLABELS'  'ALAYERLABELS'  'PARTITIONTICKS'  'APARTITIONTICKS'  'PARTITIONLABELS'  'APARTITIONLABELS'  'NODELABELS'  'ANODELABELS'  'RANDOMIZE'  'RANDOM_SEED'  'A'  'A_CHECK'  'NODENUMBER'  'LAYERNUMBER'  'PARTITIONS'  'M_DICT'  'COMPATIBLE_MEASURES'  'MEASURE'  'PFGA'  'PFGH'  'B'  'SYMMETRIZE_RULE'  'SEMIPOSITIVIZE_RULE'  'STANDARDIZE_RULE'  'ATTEMPTSPEREDGE'  'NUMBEROFWEIGHTS'  'RANDOMIZATION'  'THRESHOLDS' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':OrdMxBUT:' 'WrongInput'], ...
					['BRAPH2' ':OrdMxBUT:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for OrdMxBUT.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(OrdMxBUT, POINTER) returns property number of POINTER of OrdMxBUT.
			%  PROPERTY = G.GETPROPPROP(OrdMxBUT, POINTER) returns property number of POINTER of OrdMxBUT.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GRAPH_TYPE'  'CONNECTIVITY_TYPE'  'DIRECTIONALITY_TYPE'  'SELFCONNECTIVITY_TYPE'  'NEGATIVITY_TYPE'  'LAYERTICKS'  'ALAYERTICKS'  'LAYERLABELS'  'ALAYERLABELS'  'PARTITIONTICKS'  'APARTITIONTICKS'  'PARTITIONLABELS'  'APARTITIONLABELS'  'NODELABELS'  'ANODELABELS'  'RANDOMIZE'  'RANDOM_SEED'  'A'  'A_CHECK'  'NODENUMBER'  'LAYERNUMBER'  'PARTITIONS'  'M_DICT'  'COMPATIBLE_MEASURES'  'MEASURE'  'PFGA'  'PFGH'  'B'  'SYMMETRIZE_RULE'  'SEMIPOSITIVIZE_RULE'  'STANDARDIZE_RULE'  'ATTEMPTSPEREDGE'  'NUMBEROFWEIGHTS'  'RANDOMIZATION'  'THRESHOLDS' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(OrdMxBUT, POINTER) returns tag of POINTER of OrdMxBUT.
			%  TAG = G.GETPROPTAG(OrdMxBUT, POINTER) returns tag of POINTER of OrdMxBUT.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				ordmxbut_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'GRAPH_TYPE'  'CONNECTIVITY_TYPE'  'DIRECTIONALITY_TYPE'  'SELFCONNECTIVITY_TYPE'  'NEGATIVITY_TYPE'  'LAYERTICKS'  'ALAYERTICKS'  'LAYERLABELS'  'ALAYERLABELS'  'PARTITIONTICKS'  'APARTITIONTICKS'  'PARTITIONLABELS'  'APARTITIONLABELS'  'NODELABELS'  'ANODELABELS'  'RANDOMIZE'  'RANDOM_SEED'  'A'  'A_CHECK'  'NODENUMBER'  'LAYERNUMBER'  'PARTITIONS'  'M_DICT'  'COMPATIBLE_MEASURES'  'MEASURE'  'PFGA'  'PFGH'  'B'  'SYMMETRIZE_RULE'  'SEMIPOSITIVIZE_RULE'  'STANDARDIZE_RULE'  'ATTEMPTSPEREDGE'  'NUMBEROFWEIGHTS'  'RANDOMIZATION'  'THRESHOLDS' };
				tag = ordmxbut_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(OrdMxBUT, POINTER) returns category of POINTER of OrdMxBUT.
			%  CATEGORY = G.GETPROPCATEGORY(OrdMxBUT, POINTER) returns category of POINTER of OrdMxBUT.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMxBUT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			ordmxbut_category_list = { 1  1  1  3  4  2  2  6  1  6  6  6  6  2  6  2  6  2  6  2  6  2  6  3  3  5  6  5  5  5  5  1  6  9  9  4  3  3  3  3  3  6  3 };
			prop_category = ordmxbut_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(OrdMxBUT, POINTER) returns format of POINTER of OrdMxBUT.
			%  FORMAT = G.GETPROPFORMAT(OrdMxBUT, POINTER) returns format of POINTER of OrdMxBUT.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMxBUT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			ordmxbut_format_list = { 2  2  2  8  2  2  2  2  11  15  15  15  11  12  12  3  3  12  12  3  3  3  3  4  11  16  4  12  11  12  10  7  8  8  8  16  5  5  5  11  11  16  12 };
			prop_format = ordmxbut_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OrdMxBUT, POINTER) returns description of POINTER of OrdMxBUT.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(OrdMxBUT, POINTER) returns description of POINTER of OrdMxBUT.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OrdMxBUT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			ordmxbut_description_list = { 'ELCLASS (constant, string) is the class of the ordinal multiplex binary undirected with fixed thresholds.'  'NAME (constant, string) is the name of the ordinal multiplex binary undirected with fixed thresholds.'  'DESCRIPTION (constant, string) is the description of the binary undirected multiplex with fixed thresholds.'  'TEMPLATE (parameter, item) is the template of the ordinal multiplex binary undirected with fixed thresholds.'  'ID (data, string) is a few-letter code for the ordinal multiplex binary undirected with fixed thresholds.'  'LABEL (metadata, string) is an extended label of the ordinal multiplex binary undirected with fixed thresholds.'  'NOTES (metadata, string) are some specific notes about the ordinal multiplex binary undirected with fixed thresholds.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'GRAPH_TYPE (constant, scalar) returns the graph type Graph.ORDERED_MULTIPLEX.'  'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type Graph.BINARY * ones(layernumber).'  'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type Graph.UNDIRECTED * ones(layernumber).'  'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type Graph.NONSELFCONNECTED on the diagonal and Graph.SELFCONNECTED off diagonal.'  'NEGATIVITY_TYPE (query, smatrix) returns the negativity type Graph.NONNEGATIVE * ones(layernumber).'  'LAYERTICKS (metadata, rvector) are the layer tick values.'  'ALAYERTICKS (query, rvector) returns the layer tick values.'  'LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.'  'ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.'  'PARTITIONTICKS (metadata, rvector) are the partition tick values.'  'APARTITIONTICKS (query, rvector) returns the partition (threshold) ticks for A.'  'PARTITIONLABELS (metadata, stringlist) are the partition labels provided by the user.'  'APARTITIONLABELS (query, stringlist) returns the partition (threshold) labels for A.'  'NODELABELS (metadata, stringlist) are the node labels provided by the user.'  'ANODELABELS (query, stringlist) returns the node labels for each layer.'  'RANDOMIZE (parameter, logical) determines whether to randomize the graph.'  'RANDOM_SEED (parameter, scalar) is the randomization seed.'  'A (result, cell) is the cell array containing the binary supra-adjacency matrix of the binary undirected multiplex with fixed thresholds (BUT).'  'A_CHECK (query, logical) checks the format of the adjacency matrix.'  'NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.'  'LAYERNUMBER (result, scalar) returns the number of layers in the graph.'  'PARTITIONS (result, rvector) returns the number of layers for each partition (threshold) of the graph.'  'M_DICT (result, idict) contains the calculated measures of the graph.'  'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.'  'MEASURE (query, item) returns a measure.'  'PFGA (gui, item) contains the panel figure of the graph adjacency matrix.'  'PFGH (gui, item) contains the panel figure of the graph histogram.'  'B (data, cell) is the input cell containing the multiplex adjacency matrices on the diagonal.'  'SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.'  'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.'  'STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.'  'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.'  'NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.'  'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.'  'THRESHOLDS (parameter, rvector) is the vector of thresholds.' };
			prop_description = ordmxbut_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(OrdMxBUT, POINTER) returns settings of POINTER of OrdMxBUT.
			%  SETTINGS = G.GETPROPSETTINGS(OrdMxBUT, POINTER) returns settings of POINTER of OrdMxBUT.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OrdMxBUT.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 43 % OrdMxBUT.THRESHOLDS
					prop_settings = Format.getFormatSettings(12);
				case 4 % OrdMxBUT.TEMPLATE
					prop_settings = 'OrdMxBUT';
				otherwise
					prop_settings = getPropSettings@OrdMxWU(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OrdMxBUT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMxBUT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(OrdMxBUT, POINTER) returns the default value of POINTER of OrdMxBUT.
			%  DEFAULT = G.GETPROPDEFAULT(OrdMxBUT, POINTER) returns the default value of POINTER of OrdMxBUT.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OrdMxBUT.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 43 % OrdMxBUT.THRESHOLDS
					prop_default = Format.getFormatDefault(12, OrdMxBUT.getPropSettings(prop));
				case 1 % OrdMxBUT.ELCLASS
					prop_default = 'OrdMxBUT';
				case 2 % OrdMxBUT.NAME
					prop_default = 'Ordinal Multiplex Binary Undirected at fixed Thresholds';
				case 3 % OrdMxBUT.DESCRIPTION
					prop_default = 'In a ordinal multiplex binary undirected graph with fixed threshold (OrdMxBUT),  all the layers consist of binary undirected multiplex graphs  derived from the same weighted supra-connectivity matrices  binarized at different thresholds. The supra-connectivity matrix has a number of partitions equal to the number of thresholds. The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.';
				case 4 % OrdMxBUT.TEMPLATE
					prop_default = Format.getFormatDefault(8, OrdMxBUT.getPropSettings(prop));
				case 5 % OrdMxBUT.ID
					prop_default = 'OrdMxBUT ID';
				case 6 % OrdMxBUT.LABEL
					prop_default = 'OrdMxBUT label';
				case 7 % OrdMxBUT.NOTES
					prop_default = 'OrdMxBUT notes';
				case 9 % OrdMxBUT.GRAPH_TYPE
					prop_default = 3;
				case 32 % OrdMxBUT.COMPATIBLE_MEASURES
					prop_default = { 'Degree'  'DegreeAv'  'Distance'  'EdgeOverlap'  'GlobalEfficiency'  'GlobalEfficiencyAv'  'MultiplexRCDeg'  'MultiplexT'  'Triangles' };
				case 40 % OrdMxBUT.ATTEMPTSPEREDGE
					prop_default = 5;
				otherwise
					prop_default = getPropDefault@OrdMxWU(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OrdMxBUT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OrdMxBUT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OrdMxBUT, POINTER) returns the conditioned default value of POINTER of OrdMxBUT.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(OrdMxBUT, POINTER) returns the conditioned default value of POINTER of OrdMxBUT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OrdMxBUT.getPropProp(pointer);
			
			prop_default = OrdMxBUT.conditioning(prop, OrdMxBUT.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(OrdMxBUT, PROP, VALUE) checks VALUE format for PROP of OrdMxBUT.
			%  CHECK = G.CHECKPROP(OrdMxBUT, PROP, VALUE) checks VALUE format for PROP of OrdMxBUT.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:OrdMxBUT:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: BRAPH2:OrdMxBUT:WrongInput
			%  Element.CHECKPROP(OrdMxBUT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMxBUT.
			%   Error id: BRAPH2:OrdMxBUT:WrongInput
			%  G.CHECKPROP(OrdMxBUT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OrdMxBUT.
			%   Error id: BRAPH2:OrdMxBUT:WrongInput]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('OrdMxBUT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OrdMxBUT.getPropProp(pointer);
			
			switch prop
				case 43 % OrdMxBUT.THRESHOLDS
					check = Format.checkFormat(12, value, OrdMxBUT.getPropSettings(prop));
				case 4 % OrdMxBUT.TEMPLATE
					check = Format.checkFormat(8, value, OrdMxBUT.getPropSettings(prop));
				otherwise
					if prop <= 42
						check = checkProp@OrdMxWU(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':OrdMxBUT:' 'WrongInput'], ...
					['BRAPH2' ':OrdMxBUT:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OrdMxBUT.getPropTag(prop) ' (' OrdMxBUT.getFormatTag(OrdMxBUT.getPropFormat(prop)) ').'] ...
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
				case 10 % OrdMxBUT.CONNECTIVITY_TYPE
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = 2 * ones(layernumber);
					
				case 11 % OrdMxBUT.DIRECTIONALITY_TYPE
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = 2 * ones(layernumber);
					
				case 12 % OrdMxBUT.SELFCONNECTIVITY_TYPE
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value = 2 * ones(layernumber);
					value(1:layernumber+1:end) = 1;
					
				case 13 % OrdMxBUT.NEGATIVITY_TYPE
					if isempty(varargin)
					    layernumber = 1;
					else
					    layernumber = varargin{1};
					end
					value =  ones(layernumber);
					
				case 26 % OrdMxBUT.A
					rng_settings_ = rng(); rng(g.getPropSeed(26), 'twister')
					
					A_WU = calculateValue@OrdMxWU(g, prop);
					
					thresholds = g.get('THRESHOLDS');
					L = length(A_WU); % number of layers
					A = cell(length(thresholds)*L);
					
					if L > 0 && ~isempty(cell2mat(A_WU))
					    A(:, :) = {zeros(length(A_WU{1, 1}))};
					    for i = 1:1:length(thresholds)
					        threshold = thresholds(i);
					        layer = 1;
					        for j = (i - 1) * L + 1:1:i * L
						        for k = (i - 1) * L + 1:1:i * L
					                if j == k
					                    A{j, j} = dediagonalize(binarize(A_WU{layer, layer}, 'threshold', threshold));
					                elseif (j-k)==1 || (k-j)==1
					                    A(j, k) = {eye(length(A{1, 1}))};
					                else
					                    A(j, k) = {zeros(length(A{1, 1}))};
					                end
					            end
					            layer = layer + 1;
					        end
					    end
					end
					if g.get('RANDOMIZE')
					    A = g.get('RANDOMIZATION', A);
					end
					value = A;
					
					rng(rng_settings_)
					
				case 30 % OrdMxBUT.PARTITIONS
					rng_settings_ = rng(); rng(g.getPropSeed(30), 'twister')
					
					l = g.get('LAYERNUMBER');
					thresholds = g.get('THRESHOLDS');
					value = ones(1, length(thresholds)) * l / length(thresholds);
					
					rng(rng_settings_)
					
				case 17 % OrdMxBUT.ALAYERLABELS
					alayerlabels = g.get('LAYERLABELS');
					if ~isa(g.getr('A'), 'NoValue') && length(alayerlabels) ~= g.get('LAYERNUMBER') % ensures that it's not unecessarily calculated
					    thresholds = cellfun(@num2str, num2cell(g.get('THRESHOLDS')), 'uniformoutput', false);
					
					    if length(alayerlabels) == length(g.get('B'))
					        blayerlabels = alayerlabels;
					    else % includes isempty(layerlabels)
					        blayerlabels = cellfun(@num2str, num2cell([1:1:length(g.get('B'))]), 'uniformoutput', false);
					    end
					    
					    alayerlabels = {};
					    for i = 1:1:length(thresholds)
					        for j = 1:1:length(blayerlabels)
					            alayerlabels = [alayerlabels, [blayerlabels{j} '|' thresholds{i}]];
					        end
					    end
					end
					value = alayerlabels;
					
				case 21 % OrdMxBUT.APARTITIONLABELS
					apartitionlabels = g.get('PARTITIONLABELS');
					if ~isa(g.getr('A'), 'NoValue') && length(apartitionlabels) ~= length(g.get('THRESHOLDS')) % ensures that it's not unecessarily calculated
					    apartitionlabels = cellfun(@num2str, num2cell(g.get('THRESHOLDS')), 'uniformoutput', false);
					end
					value = apartitionlabels;
					
				case 15 % OrdMxBUT.ALAYERTICKS
					alayerticks = g.get('LAYERTICKS');
					if length(alayerticks) ~= (g.get('LAYERNUMBER') / length(g.get('THRESHOLDS'))) % ensures that it's not unecessarily calculated
					    l = g.get('LAYERNUMBER');
					    thresholds = g.get('THRESHOLDS');
					    alayerticks = [1:1:(l / length(thresholds))];
					end
					value = alayerticks;
					
				case 19 % OrdMxBUT.APARTITIONTICKS
					value = g.get('THRESHOLDS');
					
				case 42 % OrdMxBUT.RANDOMIZATION
					rng(g.get('RANDOM_SEED'), 'twister')
					
					if isempty(varargin)
					    value = {};
					    return
					end
					
					A = varargin{1};
					attempts_per_edge = g.get('ATTEMPTSPEREDGE');
					
					for i = 1:length(A)
					    tmp_a = A{i,i};
					
					    random_g = GraphBU();
					    random_g.set('ATTEMPTSPEREDGE', g.get('ATTEMPTSPEREDGE'));
					    random_A = random_g.get('RANDOMIZATION', {tmp_a});
					    A{i, i} = random_A;
					end
					value = A;
					
				otherwise
					if prop <= 42
						value = calculateValue@OrdMxWU(g, prop, varargin{:});
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
				case 43 % OrdMxBUT.THRESHOLDS
					pr = PanelPropRVectorSmart('EL', g, 'PROP', 43, 'MAX', 1, 'MIN', -1, varargin{:});
					
				case 26 % OrdMxBUT.A
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
					pr = getPanelProp@OrdMxWU(g, prop, varargin{:});
					
			end
		end
	end
end
