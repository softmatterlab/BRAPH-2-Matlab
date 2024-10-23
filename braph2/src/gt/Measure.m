classdef Measure < ConcreteElement
	%Measure is a measure.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Measure provides the methods necessary for all graph measures. 
	%  Instances of this class should not be created. 
	%  Use one of its subclasses instead.
	% 
	% The measures are characterized by their:
	% 
	%  SHAPE:
	%   1. <strong>Global</strong>: Global measure refers to global properties of a single layer graph and, therefore, consists of a single number for each graph.
	%   2. <strong>Nodal</strong>: Nodal measure refers to properties of the nodes ofa single layer graph and, therefore, consists of a vector of numbers, one for each node of the graph.
	%   3. <strong>Binodal</strong>: Binodal measure refers to properties between nodes ofa single layer graph and, therefore, consists of a matrix of numbers, one for each node of the graph.
	% 
	%  SCOPE:
	%   1. <strong>Superglobal</strong>: Superglobal measure consists of a single number for each non single layer graphs.
	%   2. <strong>Unilayer</strong>: Unilayer measure consists of a vector with nodal/binodal/global measures for every layer.
	%   3. <strong>Bilayer</strong>: Bilayer measure consists of a matrix with nodal/binodal/global measures between layers.
	%  
	%  PARAMETRICIY:
	%   1. <strong>Parametric</strong>: Parametric measure consists of a measure that outputs the results based on a parameter.
	%   2. <strong>Non-parametric</strong>: Non-parametric measure consists of a measure where the results are not based on a parameter.
	%
	% The list of Measure properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the graph measure (Measure).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the graph measure.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the graph measure.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the graph measure.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the graph measure.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the measure result.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%
	% Measure methods (constructor):
	%  Measure - constructor
	%
	% Measure methods:
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
	% Measure methods (display):
	%  tostring - string with information about the graph measure
	%  disp - displays information about the graph measure
	%  tree - displays the tree of the graph measure
	%
	% Measure methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph measure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph measure
	%
	% Measure methods (save/load, Static):
	%  save - saves BRAPH2 graph measure as b2 file
	%  load - loads a BRAPH2 graph measure from a b2 file
	%
	% Measure method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph measure
	%
	% Measure method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph measure
	%
	% Measure methods (inspection, Static):
	%  getClass - returns the class of the graph measure
	%  getSubclasses - returns all subclasses of Measure
	%  getProps - returns the property list of the graph measure
	%  getPropNumber - returns the property number of the graph measure
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
	% Measure methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Measure methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Measure methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Measure methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Measure; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Measure constants</a>.
	%
	%
	% See also Graph.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % constants
		% Measure shape
		GLOBAL = 1  
		GLOBAL_NAME = 'Global'
		GLOBAL_DESCRIPTION = ['Global measure refers to global properties of ' ... 
		'a single layer graph and, therefore, consists of a single number for each graph.']
		
		NODAL = 2
		NODAL_NAME = 'Nodal'
		NODAL_DESCRIPTION = ['Nodal measure refers to properties of the nodes of' ... 
		'a single layer graph and, therefore, consists of a vector of numbers, ' ...
		'one for each node of the graph.']
		
		BINODAL = 3
		BINODAL_NAME = 'Binodal'
		BINODAL_DESCRIPTION = ['Binodal measure refers to properties between nodes of' ... 
		'a single layer graph and, therefore, consists of a matrix of numbers, ' ...
		'one for each node of the graph.']
		
		SHAPE_NUMBER = 3
		
		SHAPE_NAME = {
		    'Global'
		    'Nodal'
		    'Binodal'
		    }
		
		SHAPE_DESCRIPTION = {
		    'Global measure refers to global properties of a single layer graph and, therefore, consists of a single number for each graph.'
		    'Nodal measure refers to properties of the nodes ofa single layer graph and, therefore, consists of a vector of numbers, one for each node of the graph.'
		    'Binodal measure refers to properties between nodes ofa single layer graph and, therefore, consists of a matrix of numbers, one for each node of the graph.'
		    }
		
		% Measure scope
		SUPERGLOBAL = 1
		SUPERGLOBAL_NAME = 'Superglobal'
		SUPERGLOBAL_DESCRIPTION = ['Superglobal measure consists of a single ' ...
		    'number for each non single layer graphs.']
		
		UNILAYER = 2
		UNILAYER_NAME = 'Unilayer'
		UNILAYER_DESCRIPTION = ['Unilayer measure consists of a vector with ' ... 
		'nodal/binodal/global measures for every layer.']
		
		BILAYER = 3
		BILAYER_NAME = 'Bilayer'
		BILAYER_DESCRIPTION = ['Bilayer measure consists of a matrix with '... 
		    'nodal/binodal/global measures between layers.']
		
		SCOPE_NUMBER = 3
		
		SCOPE_NAME = {
		    'Superglobal'
		    'Unilayer'
		    'Bilayer'
		    }
		
		SCOPE_DESCRIPTION = {
		    'Superglobal measure consists of a single number for each non single layer graphs.'
		    'Unilayer measure consists of a vector with nodal/binodal/global measures for every layer.'
		    'Bilayer measure consists of a matrix with nodal/binodal/global measures between layers.'
		    }
		
		% Parametricity
		PARAMETRIC = 1
		PARAMETRIC_NAME = 'Parametric'
		PARAMETRIC_DESCRIPTION = ['Parametric measure consists of a measure ' ...
		    'that outputs the results based on a parameter.']
		
		NONPARAMETRIC = 2
		NONPARAMETRIC_NAME = 'Non-parametric'
		NONPARAMETRIC_DESCRIPTION = ['Non-parametric measure consists of a measure ' ...
		    'where the results are not based on a parameter.']
		
		PARAMETRICITY_NUMBER = 2
		
		PARAMETRICITY_NAME = {
		    'Parametric'
		    'Non-parametric'
		    }
		
		PARAMETRICITY_DESCRIPTION = {
		    'Parametric measure consists of a measure that outputs the results based on a parameter.'
		    'Non-parametric measure consists of a measure where the results are not based on a parameter.'
		    }
	end
	properties (Constant) % properties
		SHAPE = 9; %CET: Computational Efficiency Trick
		SHAPE_TAG = 'SHAPE';
		SHAPE_CATEGORY = 1;
		SHAPE_FORMAT = 11;
		
		SCOPE = 10; %CET: Computational Efficiency Trick
		SCOPE_TAG = 'SCOPE';
		SCOPE_CATEGORY = 1;
		SCOPE_FORMAT = 11;
		
		PARAMETRICITY = 11; %CET: Computational Efficiency Trick
		PARAMETRICITY_TAG = 'PARAMETRICITY';
		PARAMETRICITY_CATEGORY = 1;
		PARAMETRICITY_FORMAT = 11;
		
		COMPATIBLE_GRAPHS = 12; %CET: Computational Efficiency Trick
		COMPATIBLE_GRAPHS_TAG = 'COMPATIBLE_GRAPHS';
		COMPATIBLE_GRAPHS_CATEGORY = 1;
		COMPATIBLE_GRAPHS_FORMAT = 7;
		
		G = 13; %CET: Computational Efficiency Trick
		G_TAG = 'G';
		G_CATEGORY = 4;
		G_FORMAT = 8;
		
		M = 14; %CET: Computational Efficiency Trick
		M_TAG = 'M';
		M_CATEGORY = 5;
		M_FORMAT = 16;
		
		PFM = 15; %CET: Computational Efficiency Trick
		PFM_TAG = 'PFM';
		PFM_CATEGORY = 9;
		PFM_FORMAT = 8;
	end
	methods % constructor
		function m = Measure(varargin)
			%Measure() creates a graph measure.
			%
			% Measure(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Measure(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Measure properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the graph measure (Measure).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the graph measure.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the graph measure.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the graph measure.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the graph measure.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the graph measure.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the graph measure.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the measure result.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%
			% See also Category, Format.
			
			m = m@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the graph measure.
			%
			% BUILD = Measure.GETBUILD() returns the build of 'Measure'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the graph measure M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('Measure') returns the build of 'Measure'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('Measure')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the graph measure.
			%
			% CLASS = Measure.GETCLASS() returns the class 'Measure'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the graph measure M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Measure') returns 'Measure'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('Measure')
			%  are less computationally efficient.
			
			m_class = 'Measure';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph measure.
			%
			% LIST = Measure.GETSUBCLASSES() returns all subclasses of 'Measure'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the graph measure M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('Measure') returns all subclasses of 'Measure'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('Measure')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'Measure'  'AssortInIn'  'AssortInOut'  'AssortOutIn'  'AssortOutOut'  'Assortativity'  'BetweennessCentrality'  'Clustering'  'ClusteringAv'  'CommunityStructure'  'CorePeriphery'  'Degree'  'DegreeAv'  'DegreeIn'  'DegreeInAv'  'DegreeOut'  'DegreeOutAv'  'DegreeOverlap'  'DegreeOverlapAv'  'Diameter'  'Distance'  'Eccentricity'  'EccentricityAv'  'EccentricityIn'  'EccentricityInAv'  'EccentricityOut'  'EccentricityOutAv'  'EdgeBetwCentr'  'EdgeNumDist'  'EdgeOverlap'  'EigenVectorCentrality'  'Flexibility'  'FlexibilityAv'  'GlobalEfficiency'  'GlobalEfficiencyAv'  'GlobalEfficiencyIn'  'GlobalEfficiencyInAv'  'GlobalEfficiencyOut'  'GlobalEfficiencyOutAv'  'KCore'  'KCorenessCentrality'  'LocalEfficiency'  'LocalEfficiencyAv'  'Modularity'  'MultiRC'  'MultilayerCommunity'  'MultilayerM'  'MultiplexCP'  'MultiplexCl'  'MultiplexClAv'  'MultiplexKCor'  'MultiplexKCorC'  'MultiplexP'  'MultiplexPAv'  'MultiplexPIn'  'MultiplexPOut'  'MultiplexRCDeg'  'MultiplexRCS'  'MultiplexT'  'OverlappingDeg'  'OverlappingDegAv'  'OverlappingDegIn'  'OverlappingDegInAv'  'OverlappingDegOut'  'OverlappingDegOutAv'  'OverlappingS'  'OverlappingSAv'  'OverlappingSIn'  'OverlappingSInAv'  'OverlappingSOut'  'OverlappingSOutAv'  'Participation'  'PathLength'  'PathLengthAv'  'PathLengthIn'  'PathLengthInAv'  'PathLengthOut'  'PathLengthOutAv'  'Persistence'  'RCDeg'  'RCS'  'Radius'  'RichClub'  'Richness'  'SCore'  'SmallWorldness'  'Strength'  'StrengthAv'  'StrengthIn'  'StrengthInAv'  'StrengthOut'  'StrengthOutAv'  'Transitivity'  'Triangles'  'WeightedEdgeOvlp'  'WeightedMxP'  'WeightedMxPAv'  'WeightedMxPIn'  'WeightedMxPOut'  'WeightedRC' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph measure.
			%
			% PROPS = Measure.GETPROPS() returns the property list of graph measure
			%  as a row vector.
			%
			% PROPS = Measure.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the graph measure M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Measure'[, CATEGORY]) returns the property list of 'Measure'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('Measure')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3 9 10 11 12];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 13];
				case 5 % Category.RESULT
					prop_list = 14;
				case 6 % Category.QUERY
					prop_list = 8;
				case 9 % Category.GUI
					prop_list = 15;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph measure.
			%
			% N = Measure.GETPROPNUMBER() returns the property number of graph measure.
			%
			% N = Measure.GETPROPNUMBER(CATEGORY) returns the property number of graph measure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the graph measure M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Measure') returns the property number of 'Measure'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('Measure')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 15;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 7;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph measure/error.
			%
			% CHECK = Measure.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Measure, PROP) checks whether PROP exists for Measure.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Measure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%  Element.EXISTSPROP(Measure, PROP) throws error if PROP does NOT exist for Measure.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('Measure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 15 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Measure:' 'WrongInput'], ...
					['BRAPH2' ':Measure:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Measure.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph measure/error.
			%
			% CHECK = Measure.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Measure, TAG) checks whether TAG exists for Measure.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Measure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%  Element.EXISTSTAG(Measure, TAG) throws error if TAG does NOT exist for Measure.
			%   Error id: [BRAPH2:Measure:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('Measure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Measure:' 'WrongInput'], ...
					['BRAPH2' ':Measure:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for Measure.'] ...
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
			%  PROPERTY = M.GETPROPPROP(POINTER) returns property number of POINTER of M.
			%  PROPERTY = Element.GETPROPPROP(Measure, POINTER) returns property number of POINTER of Measure.
			%  PROPERTY = M.GETPROPPROP(Measure, POINTER) returns property number of POINTER of Measure.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('Measure')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = M.GETPROPTAG(POINTER) returns tag of POINTER of M.
			%  TAG = Element.GETPROPTAG(Measure, POINTER) returns tag of POINTER of Measure.
			%  TAG = M.GETPROPTAG(Measure, POINTER) returns tag of POINTER of Measure.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				measure_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM' };
				tag = measure_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = M.GETPROPCATEGORY(POINTER) returns category of POINTER of M.
			%  CATEGORY = Element.GETPROPCATEGORY(Measure, POINTER) returns category of POINTER of Measure.
			%  CATEGORY = M.GETPROPCATEGORY(Measure, POINTER) returns category of POINTER of Measure.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('Measure')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measure_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9 };
			prop_category = measure_category_list{prop};
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
			%  FORMAT = M.GETPROPFORMAT(POINTER) returns format of POINTER of M.
			%  FORMAT = Element.GETPROPFORMAT(Measure, POINTER) returns format of POINTER of Measure.
			%  FORMAT = M.GETPROPFORMAT(Measure, POINTER) returns format of POINTER of Measure.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('Measure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measure_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8 };
			prop_format = measure_format_list{prop};
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
			%  DESCRIPTION = M.GETPROPDESCRIPTION(POINTER) returns description of POINTER of M.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Measure, POINTER) returns description of POINTER of Measure.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Measure, POINTER) returns description of POINTER of Measure.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measure_description_list = { 'ELCLASS (constant, string) is the class of the graph measure (Measure).'  'NAME (constant, string) is the name of the graph measure.'  'DESCRIPTION (constant, string) is the description of the graph measure.'  'TEMPLATE (parameter, item) is the template of the graph measure.'  'ID (data, string) is a few-letter code for the graph measure.'  'LABEL (metadata, string) is an extended label of the graph measure.'  'NOTES (metadata, string) are some specific notes about the graph measure.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape.'  'SCOPE (constant, scalar) is the measure scope.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the measure result.'  'PFM (gui, item) contains the panel figure of the measure.' };
			prop_description = measure_description_list{prop};
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
			%  SETTINGS = M.GETPROPSETTINGS(POINTER) returns settings of POINTER of M.
			%  SETTINGS = Element.GETPROPSETTINGS(Measure, POINTER) returns settings of POINTER of Measure.
			%  SETTINGS = M.GETPROPSETTINGS(Measure, POINTER) returns settings of POINTER of Measure.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % Measure.SHAPE
					prop_settings = Format.getFormatSettings(11);
				case 10 % Measure.SCOPE
					prop_settings = Format.getFormatSettings(11);
				case 11 % Measure.PARAMETRICITY
					prop_settings = Format.getFormatSettings(11);
				case 12 % Measure.COMPATIBLE_GRAPHS
					prop_settings = 'Graph';
				case 13 % Measure.G
					prop_settings = 'Graph';
				case 14 % Measure.M
					prop_settings = Format.getFormatSettings(16);
				case 15 % Measure.PFM
					prop_settings = 'MeasurePF';
				case 4 % Measure.TEMPLATE
					prop_settings = 'Measure';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Measure.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Measure.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Measure, POINTER) returns the default value of POINTER of Measure.
			%  DEFAULT = M.GETPROPDEFAULT(Measure, POINTER) returns the default value of POINTER of Measure.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('Measure')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % Measure.SHAPE
					prop_default = 2;
				case 10 % Measure.SCOPE
					prop_default = 2;
				case 11 % Measure.PARAMETRICITY
					prop_default = 2;
				case 12 % Measure.COMPATIBLE_GRAPHS
					prop_default = Format.getFormatDefault(7, Measure.getPropSettings(prop));
				case 13 % Measure.G
					prop_default = Format.getFormatDefault(8, Measure.getPropSettings(prop));
				case 14 % Measure.M
					prop_default = Format.getFormatDefault(16, Measure.getPropSettings(prop));
				case 15 % Measure.PFM
					prop_default = Format.getFormatDefault(8, Measure.getPropSettings(prop));
				case 1 % Measure.ELCLASS
					prop_default = 'Measure';
				case 2 % Measure.NAME
					prop_default = 'Measure';
				case 3 % Measure.DESCRIPTION
					prop_default = 'A Measure provides the methods necessary for all graph measures. Instances of this class should not be created. Use one of its subclasses instead.';
				case 4 % Measure.TEMPLATE
					prop_default = Format.getFormatDefault(8, Measure.getPropSettings(prop));
				case 5 % Measure.ID
					prop_default = 'Measure ID';
				case 6 % Measure.LABEL
					prop_default = 'Measure label';
				case 7 % Measure.NOTES
					prop_default = 'Measure notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Measure.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Measure.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Measure, POINTER) returns the conditioned default value of POINTER of Measure.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Measure, POINTER) returns the conditioned default value of POINTER of Measure.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('Measure')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Measure.getPropProp(pointer);
			
			prop_default = Measure.conditioning(prop, Measure.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = M.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = M.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of M.
			%  CHECK = Element.CHECKPROP(Measure, PROP, VALUE) checks VALUE format for PROP of Measure.
			%  CHECK = M.CHECKPROP(Measure, PROP, VALUE) checks VALUE format for PROP of Measure.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:Measure:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:Measure:WrongInput
			%  Element.CHECKPROP(Measure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Measure.
			%   Error id: BRAPH2:Measure:WrongInput
			%  M.CHECKPROP(Measure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Measure.
			%   Error id: BRAPH2:Measure:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('Measure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Measure.getPropProp(pointer);
			
			switch prop
				case 9 % Measure.SHAPE
					check = Format.checkFormat(11, value, Measure.getPropSettings(prop));
				case 10 % Measure.SCOPE
					check = Format.checkFormat(11, value, Measure.getPropSettings(prop));
				case 11 % Measure.PARAMETRICITY
					check = Format.checkFormat(11, value, Measure.getPropSettings(prop));
				case 12 % Measure.COMPATIBLE_GRAPHS
					check = Format.checkFormat(7, value, Measure.getPropSettings(prop));
				case 13 % Measure.G
					check = Format.checkFormat(8, value, Measure.getPropSettings(prop));
				case 14 % Measure.M
					check = Format.checkFormat(16, value, Measure.getPropSettings(prop));
				case 15 % Measure.PFM
					check = Format.checkFormat(8, value, Measure.getPropSettings(prop));
				case 4 % Measure.TEMPLATE
					check = Format.checkFormat(8, value, Measure.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Measure:' 'WrongInput'], ...
					['BRAPH2' ':Measure:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Measure.getPropTag(prop) ' (' Measure.getFormatTag(Measure.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(m, prop)
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
				case 15 % Measure.PFM
					if isa(m.getr('PFM'), 'NoValue')
					    switch m.get('SHAPE')
					        case 1 % Measure.GLOBAL
					            switch m.get('SCOPE')
					                case 1 % Measure.SUPERGLOBAL
					                    m.set('PFM', MeasurePF_GS('M', m))
					                case 2 % Measure.UNILAYER
					                    m.set('PFM', MeasurePF_GU('M', m))
					                case 3 % Measure.BILAYER
					                    m.set('PFM', MeasurePF_GB('M', m))
					            end
					        case 2 % Measure.NODAL
					            switch m.get('SCOPE')
					                case 1 % Measure.SUPERGLOBAL
					                    m.set('PFM', MeasurePF_NS('M', m))
					                case 2 % Measure.UNILAYER
					                    m.set('PFM', MeasurePF_NU('M', m))
					                case 3 % Measure.BILAYER
					                    m.set('PFM', MeasurePF_NB('M', m))
					            end
					        case 3 % Measure.BINODAL
					            switch m.get('SCOPE')
					                case 1 % Measure.SUPERGLOBAL
					                    m.set('PFM', MeasurePF_BS('M', m))
					                case 2 % Measure.UNILAYER
					                    m.set('PFM', MeasurePF_BU('M', m))
					                case 3 % Measure.BILAYER
					                    m.set('PFM', MeasurePF_BB('M', m))
					            end
					    end
					end
					
				otherwise
					if prop <= 8
						postprocessing@ConcreteElement(m, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop, varargin)
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
				case 14 % Measure.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					value = {};
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(m, prop, varargin)
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
				case 14 % Measure.M
					g = m.get('G');
					
					pr = PanelPropCell('EL', m, 'PROP', 14, varargin{:});
					
					if m.get('SHAPE') == 1 % Measure.GLOBAL
					    pr.set( ...
					        'TABLE_HEIGHT', 48, ...
					        'ROWNAME', {}, ...
					        'COLUMNNAME', {} ...
					        )
					elseif m.get('SHAPE') == 2 % Measure.NODAL
					    pr.set( ...
					        'TABLE_HEIGHT', 480, ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', {} ...
					        )
					elseif m.get('SHAPE') == 3 % Measure.BINODAL
					    pr.set( ...
					        'TABLE_HEIGHT', 480, ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', g.getCallback('ANODELABELS') ...
					        )
					end
					
					if g.get('LAYERNUMBER') == 1
					    pr.set( ...
					        'XSLIDERSHOW', false, ...
					        'YSLIDERSHOW', false ...
					        )
					else % multigraph, multiplex, multilayer
					    if m.get('SCOPE') == 1 % Measure.SUPERGLOBAL
					        if isempty(g.get('APARTITIONLABELS'))
					            pr.set( ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', false ...
					                )
					        else
					            pr.set( ...
					                'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), 12 * length(g.get('APARTITIONLABELS'))), ...
					                'XSLIDERSHOW', false, ...
					                'YSLIDERSHOW', true, ...
					                'YSLIDERLABELS', g.getCallback('APARTITIONLABELS'), ...
					                'YSLIDERWIDTH', 60 ...
					                )
					        end
					    elseif m.get('SCOPE') == 2 % Measure.UNILAYER
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), 12 * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', 60 ...
					            )
					    elseif m.get('SCOPE') == 3 % Measure.BILAYER
					        pr.set( ...
					            'TABLE_HEIGHT', max(36 + pr.get('TABLE_HEIGHT'), 36 + 12 * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', true, ...
					            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'XSLIDERHEIGHT', 36, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', 60 ...
					            )
					    end
					end
					
				case 15 % Measure.PFM
					pr = PanelPropItem('EL', m, 'PROP', 15, ...
					    'GUICLASS', 'GUIFig', ...
						'BUTTON_TEXT', ['Plot ' m.get('LABEL')], ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(m, prop, varargin{:});
					
			end
		end
	end
end
