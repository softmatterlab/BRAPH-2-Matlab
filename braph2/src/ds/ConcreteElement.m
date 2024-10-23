classdef ConcreteElement < Element
	%ConcreteElement is the base class for all concrete elements.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% A Concrete Element (ConcreteElement) provides the infrastructure necessary 
	%  for all concrete elements. In particular, it has the constant properties 
	%  ELCLASS (string), NAME (string) and DESCRIPTION (string), the property 
	%  TEMPLATE (item), the indexing properties ID (string), LABEL (string), 
	%  and NOTES (string), and the query prop TOSTRING (string).
	% Even though it is possible to create instances of ConcreteElement, 
	%  typically one uses its subclasses.
	%
	% The list of ConcreteElement properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%
	% ConcreteElement methods (constructor):
	%  ConcreteElement - constructor
	%
	% ConcreteElement methods:
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
	% ConcreteElement methods (display):
	%  tostring - string with information about the concrete element
	%  disp - displays information about the concrete element
	%  tree - displays the tree of the concrete element
	%
	% ConcreteElement methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two concrete element are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the concrete element
	%
	% ConcreteElement methods (save/load, Static):
	%  save - saves BRAPH2 concrete element as b2 file
	%  load - loads a BRAPH2 concrete element from a b2 file
	%
	% ConcreteElement method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the concrete element
	%
	% ConcreteElement method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the concrete element
	%
	% ConcreteElement methods (inspection, Static):
	%  getClass - returns the class of the concrete element
	%  getSubclasses - returns all subclasses of ConcreteElement
	%  getProps - returns the property list of the concrete element
	%  getPropNumber - returns the property number of the concrete element
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
	% ConcreteElement methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ConcreteElement methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ConcreteElement methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ConcreteElement methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ConcreteElement; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ConcreteElement constants</a>.
	%
	%
	% See also NoValue, Callback.
	%
	% BUILD BRAPH2 6 class_name 1
	
	properties (Constant) % properties
		ELCLASS = 1; %CET: Computational Efficiency Trick
		ELCLASS_TAG = 'ELCLASS';
		ELCLASS_CATEGORY = 1;
		ELCLASS_FORMAT = 2;
		
		NAME = 2; %CET: Computational Efficiency Trick
		NAME_TAG = 'NAME';
		NAME_CATEGORY = 1;
		NAME_FORMAT = 2;
		
		DESCRIPTION = 3; %CET: Computational Efficiency Trick
		DESCRIPTION_TAG = 'DESCRIPTION';
		DESCRIPTION_CATEGORY = 1;
		DESCRIPTION_FORMAT = 2;
		
		TEMPLATE = 4; %CET: Computational Efficiency Trick
		TEMPLATE_TAG = 'TEMPLATE';
		TEMPLATE_CATEGORY = 3;
		TEMPLATE_FORMAT = 8;
		
		ID = 5; %CET: Computational Efficiency Trick
		ID_TAG = 'ID';
		ID_CATEGORY = 4;
		ID_FORMAT = 2;
		
		LABEL = 6; %CET: Computational Efficiency Trick
		LABEL_TAG = 'LABEL';
		LABEL_CATEGORY = 2;
		LABEL_FORMAT = 2;
		
		NOTES = 7; %CET: Computational Efficiency Trick
		NOTES_TAG = 'NOTES';
		NOTES_CATEGORY = 2;
		NOTES_FORMAT = 2;
		
		TOSTRING = 8; %CET: Computational Efficiency Trick
		TOSTRING_TAG = 'TOSTRING';
		TOSTRING_CATEGORY = 6;
		TOSTRING_FORMAT = 2;
	end
	methods % constructor
		function el = ConcreteElement(varargin)
			%ConcreteElement() creates a concrete element.
			%
			% ConcreteElement(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ConcreteElement(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ConcreteElement properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%
			% See also Category, Format.
			
			el = el@Element(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the concrete element.
			%
			% BUILD = ConcreteElement.GETBUILD() returns the build of 'ConcreteElement'.
			%
			% Alternative forms to call this method are:
			%  BUILD = EL.GETBUILD() returns the build of the concrete element EL.
			%  BUILD = Element.GETBUILD(EL) returns the build of 'EL'.
			%  BUILD = Element.GETBUILD('ConcreteElement') returns the build of 'ConcreteElement'.
			%
			% Note that the Element.GETBUILD(EL) and Element.GETBUILD('ConcreteElement')
			%  are less computationally efficient.
			
			build = 1;
		end
		function el_class = getClass()
			%GETCLASS returns the class of the concrete element.
			%
			% CLASS = ConcreteElement.GETCLASS() returns the class 'ConcreteElement'.
			%
			% Alternative forms to call this method are:
			%  CLASS = EL.GETCLASS() returns the class of the concrete element EL.
			%  CLASS = Element.GETCLASS(EL) returns the class of 'EL'.
			%  CLASS = Element.GETCLASS('ConcreteElement') returns 'ConcreteElement'.
			%
			% Note that the Element.GETCLASS(EL) and Element.GETCLASS('ConcreteElement')
			%  are less computationally efficient.
			
			el_class = 'ConcreteElement';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the concrete element.
			%
			% LIST = ConcreteElement.GETSUBCLASSES() returns all subclasses of 'ConcreteElement'.
			%
			% Alternative forms to call this method are:
			%  LIST = EL.GETSUBCLASSES() returns all subclasses of the concrete element EL.
			%  LIST = Element.GETSUBCLASSES(EL) returns all subclasses of 'EL'.
			%  LIST = Element.GETSUBCLASSES('ConcreteElement') returns all subclasses of 'ConcreteElement'.
			%
			% Note that the Element.GETSUBCLASSES(EL) and Element.GETSUBCLASSES('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ConcreteElement'  'GraphBD'  'GraphBU'  'GraphWD'  'GraphWU'  'MultigraphBUD'  'MultigraphBUT'  'MultilayerBD'  'MultilayerBU'  'MultilayerBUD'  'MultilayerBUT'  'MultilayerWD'  'MultilayerWU'  'MultiplexBD'  'MultiplexBU'  'MultiplexBUD'  'MultiplexBUT'  'MultiplexWD'  'MultiplexWU'  'OrdMlBD'  'OrdMlBU'  'OrdMlBUD'  'OrdMlBUT'  'OrdMlWD'  'OrdMlWU'  'OrdMxBD'  'OrdMxBU'  'OrdMxBUD'  'OrdMxBUT'  'OrdMxWD'  'OrdMxWU'  'AssortInIn'  'AssortInOut'  'AssortOutIn'  'AssortOutOut'  'Assortativity'  'BetweennessCentrality'  'Clustering'  'ClusteringAv'  'CommunityStructure'  'CorePeriphery'  'Degree'  'DegreeAv'  'DegreeIn'  'DegreeInAv'  'DegreeOut'  'DegreeOutAv'  'DegreeOverlap'  'DegreeOverlapAv'  'Diameter'  'Distance'  'Eccentricity'  'EccentricityAv'  'EccentricityIn'  'EccentricityInAv'  'EccentricityOut'  'EccentricityOutAv'  'EdgeBetwCentr'  'EdgeNumDist'  'EdgeOverlap'  'EigenVectorCentrality'  'Flexibility'  'FlexibilityAv'  'GlobalEfficiency'  'GlobalEfficiencyAv'  'GlobalEfficiencyIn'  'GlobalEfficiencyInAv'  'GlobalEfficiencyOut'  'GlobalEfficiencyOutAv'  'KCore'  'KCorenessCentrality'  'LocalEfficiency'  'LocalEfficiencyAv'  'Modularity'  'MultiRC'  'MultilayerCommunity'  'MultilayerM'  'MultiplexCP'  'MultiplexCl'  'MultiplexClAv'  'MultiplexKCor'  'MultiplexKCorC'  'MultiplexP'  'MultiplexPAv'  'MultiplexPIn'  'MultiplexPOut'  'MultiplexRCDeg'  'MultiplexRCS'  'MultiplexT'  'OverlappingDeg'  'OverlappingDegAv'  'OverlappingDegIn'  'OverlappingDegInAv'  'OverlappingDegOut'  'OverlappingDegOutAv'  'OverlappingS'  'OverlappingSAv'  'OverlappingSIn'  'OverlappingSInAv'  'OverlappingSOut'  'OverlappingSOutAv'  'Participation'  'PathLength'  'PathLengthAv'  'PathLengthIn'  'PathLengthInAv'  'PathLengthOut'  'PathLengthOutAv'  'Persistence'  'RCDeg'  'RCS'  'Radius'  'RichClub'  'Richness'  'SCore'  'SmallWorldness'  'Strength'  'StrengthAv'  'StrengthIn'  'StrengthInAv'  'StrengthOut'  'StrengthOutAv'  'Transitivity'  'Triangles'  'WeightedEdgeOvlp'  'WeightedMxP'  'WeightedMxPAv'  'WeightedMxPIn'  'WeightedMxPOut'  'WeightedRC'  'NNClassifierMLP'  'NNClassifierMLP_CrossValidation'  'NNClassifierMLP_CrossValidationPF_ROC'  'NNClassifierMLP_Evaluator'  'NNClassifierMLP_EvaluatorPF_ROC'  'NNDataPointMLP_Shuffled'  'NNDataPoint_Graph_CLA'  'NNDataPoint_Graph_REG'  'NNDataPoint_Measure_CLA'  'NNDataPoint_Measure_REG'  'NNRegressorMLP'  'NNRegressorMLP_CrossValidation'  'NNRegressorMLP_CrossValidationPF_Scatter'  'NNRegressorMLP_Evaluator'  'NNRegressorMLP_EvaluatorPF_Scatter'  'NNxMLP_FeatureImportance'  'NNxMLP_FeatureImportanceAcrossMeasures'  'NNxMLP_FeatureImportanceAcrossMeasures_CV'  'NNxMLP_FeatureImportanceBSPF_xSPP_Layer'  'NNxMLP_FeatureImportanceBSPF_xUPP_Layer'  'NNxMLP_FeatureImportanceBrainSurface'  'NNxMLP_FeatureImportanceBrainSurfacePF'  'NNxMLP_FeatureImportanceBrainSurfacePF_BB'  'NNxMLP_FeatureImportanceBrainSurfacePF_BS'  'NNxMLP_FeatureImportanceBrainSurfacePF_BU'  'NNxMLP_FeatureImportanceBrainSurfacePF_GB'  'NNxMLP_FeatureImportanceBrainSurfacePF_GS'  'NNxMLP_FeatureImportanceBrainSurfacePF_GU'  'NNxMLP_FeatureImportanceBrainSurfacePF_NB'  'NNxMLP_FeatureImportanceBrainSurfacePF_NS'  'NNxMLP_FeatureImportanceBrainSurfacePF_NU'  'NNxMLP_FeatureImportanceBrainSurfacePP_Data'  'NNxMLP_FeatureImportanceBrainSurfacePP_Graph'  'NNxMLP_FeatureImportanceBrainSurfacePP_Measure'  'NNxMLP_FeatureImportanceBrainSurface_CV'  'NNxMLP_FeatureImportance_CV'  'AnalyzeEnsemble_CON_BUD'  'AnalyzeEnsemble_CON_BUT'  'AnalyzeEnsemble_CON_WU'  'ExporterGroupSubjectCON_TXT'  'ExporterGroupSubjectCON_XLS'  'ImporterGroupSubjectCON_TXT'  'ImporterGroupSubjectCON_XLS'  'SubjectCON'  'NNDataPoint_CON_CLA'  'NNDataPoint_CON_REG'  'AnalyzeEnsemble_CON_WD'  'AnalyzeGroup_CON_GA_WU'  'AnalyzeEnsemble_CON_MP_BUD'  'AnalyzeEnsemble_CON_MP_BUT'  'AnalyzeEnsemble_CON_MP_WU'  'ExporterGroupSubjectCON_MP_TXT'  'ExporterGroupSubjectCON_MP_XLS'  'ImporterGroupSubjectCON_MP_TXT'  'ImporterGroupSubjectCON_MP_XLS'  'SubjectCON_MP'  'AnalyzeGroup_CON_MP_GA_WU'  'AnalyzeEnsemble_CON_OMP_WU'  'AnalyzeGroup_CON_OMP_GA_WU'  'AnalyzeEnsemble_CON_FUN_MP_BUD'  'AnalyzeEnsemble_CON_FUN_MP_BUT'  'AnalyzeEnsemble_CON_FUN_MP_WU'  'CombineGroups_CON_FUN_MP'  'SeparateGroups_CON_FUN_MP'  'SubjectCON_FUN_MP'  'NNDataPoint_CON_FUN_MP_CLA'  'NNDataPoint_CON_FUN_MP_REG'  'AnalyzeGroup_CON_FUN_MP_GA_BUD'  'AnalyzeGroup_CON_FUN_MP_GA_WU'  'AnalyzeEnsemble_FUN_BUD'  'AnalyzeEnsemble_FUN_BUT'  'AnalyzeEnsemble_FUN_WU'  'ExporterGroupSubjectFUN_TXT'  'ExporterGroupSubjectFUN_XLS'  'ImporterGroupSubjectFUN_TXT'  'ImporterGroupSubjectFUN_XLS'  'SubjectFUN'  'NNDataPoint_FUN_CLA'  'NNDataPoint_FUN_REG'  'AnalyzeGroup_FUN_GA_WU'  'AnalyzeEnsemble_FUN_MP_BUD'  'AnalyzeEnsemble_FUN_MP_BUT'  'AnalyzeEnsemble_FUN_MP_WU'  'ExporterGroupSubjectFUN_MP_TXT'  'ExporterGroupSubjectFUN_MP_XLS'  'ImporterGroupSubjectFUN_MP_TXT'  'ImporterGroupSubjectFUN_MP_XLS'  'SubjectFUN_MP'  'AnalyzeGroup_FUN_MP_GA_WU'  'AnalyzeEnsemble_FUN_OMP_WU'  'AnalyzeGroup_FUN_OMP_GA_WU'  'AnalyzeGroup_ST_BUD'  'AnalyzeGroup_ST_BUT'  'AnalyzeGroup_ST_WU'  'ExporterGroupSubjectST_TXT'  'ExporterGroupSubjectST_XLS'  'ImporterGroupSubjectST_TXT'  'ImporterGroupSubjectST_XLS'  'SubjectST'  'NNDataPoint_ST_CLA'  'NNDataPoint_ST_REG'  'NNDataPoint_ST_MM_CLA'  'NNDataPoint_ST_MM_REG'  'AnalyzeGroup_ST_MP_BUD'  'AnalyzeGroup_ST_MP_BUT'  'AnalyzeGroup_ST_MP_WU'  'ExporterGroupSubjectST_MP_TXT'  'ExporterGroupSubjectST_MP_XLS'  'ImporterGroupSubjectST_MP_TXT'  'ImporterGroupSubjectST_MP_XLS'  'SubjectST_MP'  'AnalyzeEnsemble'  'AnalyzeEnsemblePP_GDict'  'AnalyzeEnsemblePP_MeDict'  'AnalyzeGroup'  'AnalyzeGroupPP_G'  'CompareEnsemble'  'CompareEnsemblePP_CpDict'  'CompareGroup'  'CompareGroupPP_CpDict'  'ComparisonEnsemble'  'ComparisonEnsembleBrainPF'  'ComparisonEnsembleBrainPF_BB'  'ComparisonEnsembleBrainPF_BS'  'ComparisonEnsembleBrainPF_BU'  'ComparisonEnsembleBrainPF_GB'  'ComparisonEnsembleBrainPF_GS'  'ComparisonEnsembleBrainPF_GU'  'ComparisonEnsembleBrainPF_NB'  'ComparisonEnsembleBrainPF_NS'  'ComparisonEnsembleBrainPF_NU'  'ComparisonEnsembleBrainPF_xSPP_Layer'  'ComparisonEnsembleBrainPF_xUPP_Layer'  'ComparisonEnsemblePF'  'ComparisonEnsemblePF_BB'  'ComparisonEnsemblePF_BS'  'ComparisonEnsemblePF_BU'  'ComparisonEnsemblePF_BxPP_Nodes'  'ComparisonEnsemblePF_GB'  'ComparisonEnsemblePF_GS'  'ComparisonEnsemblePF_GU'  'ComparisonEnsemblePF_NB'  'ComparisonEnsemblePF_NS'  'ComparisonEnsemblePF_NU'  'ComparisonEnsemblePF_NxPP_Node'  'ComparisonEnsemblePF_xUPP_Layer'  'ComparisonGroup'  'ComparisonGroupBrainPF'  'ComparisonGroupBrainPF_BB'  'ComparisonGroupBrainPF_BS'  'ComparisonGroupBrainPF_BU'  'ComparisonGroupBrainPF_GB'  'ComparisonGroupBrainPF_GS'  'ComparisonGroupBrainPF_GU'  'ComparisonGroupBrainPF_NB'  'ComparisonGroupBrainPF_NS'  'ComparisonGroupBrainPF_NU'  'ComparisonGroupBrainPF_xSPP_Layer'  'ComparisonGroupBrainPF_xUPP_Layer'  'ComparisonGroupPF'  'ComparisonGroupPF_BB'  'ComparisonGroupPF_BS'  'ComparisonGroupPF_BU'  'ComparisonGroupPF_BxPP_Nodes'  'ComparisonGroupPF_GB'  'ComparisonGroupPF_GS'  'ComparisonGroupPF_GU'  'ComparisonGroupPF_NB'  'ComparisonGroupPF_NS'  'ComparisonGroupPF_NU'  'ComparisonGroupPF_NxPP_Node'  'ComparisonGroupPF_xUPP_Layer'  'MeasureEnsemble'  'MeasureEnsembleBrainPF'  'MeasureEnsembleBrainPF_BB'  'MeasureEnsembleBrainPF_BS'  'MeasureEnsembleBrainPF_BU'  'MeasureEnsembleBrainPF_GB'  'MeasureEnsembleBrainPF_GS'  'MeasureEnsembleBrainPF_GU'  'MeasureEnsembleBrainPF_NB'  'MeasureEnsembleBrainPF_NS'  'MeasureEnsembleBrainPF_NU'  'MeasureEnsembleBrainPF_xSPP_Layer'  'MeasureEnsembleBrainPF_xUPP_Layer'  'MeasureEnsemblePF'  'MeasureEnsemblePF_BB'  'MeasureEnsemblePF_BS'  'MeasureEnsemblePF_BU'  'MeasureEnsemblePF_BxPP_Nodes'  'MeasureEnsemblePF_GB'  'MeasureEnsemblePF_GS'  'MeasureEnsemblePF_GU'  'MeasureEnsemblePF_NB'  'MeasureEnsemblePF_NS'  'MeasureEnsemblePF_NU'  'MeasureEnsemblePF_NxPP_Node'  'MeasureEnsemblePF_xUPP_Layer'  'MeasureGroupBrainPF'  'MeasureGroupBrainPF_BB'  'MeasureGroupBrainPF_BS'  'MeasureGroupBrainPF_BU'  'MeasureGroupBrainPF_GB'  'MeasureGroupBrainPF_GS'  'MeasureGroupBrainPF_GU'  'MeasureGroupBrainPF_NB'  'MeasureGroupBrainPF_NS'  'MeasureGroupBrainPF_NU'  'MeasureGroupBrainPF_xSPP_Layer'  'MeasureGroupBrainPF_xUPP_Layer'  'PanelPropCellFDR'  'BrainAtlas'  'BrainAtlasPF'  'BrainRegion'  'BrainSurface'  'BrainSurfacePF'  'ExporterBrainAtlasTXT'  'ExporterBrainAtlasXLS'  'ImporterBrainAtlasTXT'  'ImporterBrainAtlasXLS'  'ImporterBrainSurfaceNV'  'Group'  'Subject'  'SubjectPP_VOIDict'  'VOI'  'VOICategoric'  'VOINumeric'  'IndexedDictionary'  'Graph'  'GraphAdjPF'  'GraphHistPF'  'GraphPP_MDict'  'LayersPP'  'Measure'  'MeasurePF'  'MeasurePF_BB'  'MeasurePF_BS'  'MeasurePF_BU'  'MeasurePF_BxPP_Nodes'  'MeasurePF_GB'  'MeasurePF_GS'  'MeasurePF_GU'  'MeasurePF_NB'  'MeasurePF_NS'  'MeasurePF_NU'  'MeasurePF_NxPP_Node'  'MeasurePF_xUPP_Layer'  'ExporterPipelineBRAPH2'  'GUI'  'GUIElement'  'GUIFig'  'GUILayout'  'ImporterPipelineBRAPH2'  'Panel'  'PanelElement'  'PanelFig'  'PanelProp'  'PanelPropAlpha'  'PanelPropCell'  'PanelPropClass'  'PanelPropClassList'  'PanelPropColor'  'PanelPropIDict'  'PanelPropIDictTable'  'PanelPropItem'  'PanelPropItemList'  'PanelPropLine'  'PanelPropLogical'  'PanelPropMarker'  'PanelPropMatrix'  'PanelPropNet'  'PanelPropOption'  'PanelPropRVectorSmart'  'PanelPropRVectorView'  'PanelPropScalar'  'PanelPropSize'  'PanelPropString'  'PanelPropStringList'  'PanelPropStringTextArea'  'Pipeline'  'PipelineCode'  'PipelinePP_Notes'  'PipelinePP_PSDict'  'PipelineSection'  'Settings'  'SettingsAmbient'  'SettingsAmbientPP'  'SettingsArea'  'SettingsAreaPP'  'SettingsAxis'  'SettingsAxisPP'  'SettingsLine'  'SettingsLinePP'  'SettingsPP'  'SettingsPosition'  'SettingsPositionPP'  'SettingsSphere'  'SettingsSurface'  'SettingsSurfacePP'  'SettingsSymbol'  'SettingsText'  'SettingsTextPP'  'NNBase'  'NNCrossValidation'  'NNDataPoint'  'NNDataset'  'NNDatasetCombine'  'NNDatasetSplit'  'NNEvaluator'  'Exporter'  'Importer' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of concrete element.
			%
			% PROPS = ConcreteElement.GETPROPS() returns the property list of concrete element
			%  as a row vector.
			%
			% PROPS = ConcreteElement.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = EL.GETPROPS([CATEGORY]) returns the property list of the concrete element EL.
			%  PROPS = Element.GETPROPS(EL[, CATEGORY]) returns the property list of 'EL'.
			%  PROPS = Element.GETPROPS('ConcreteElement'[, CATEGORY]) returns the property list of 'ConcreteElement'.
			%
			% Note that the Element.GETPROPS(EL) and Element.GETPROPS('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8];
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
					prop_list = 5;
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of concrete element.
			%
			% N = ConcreteElement.GETPROPNUMBER() returns the property number of concrete element.
			%
			% N = ConcreteElement.GETPROPNUMBER(CATEGORY) returns the property number of concrete element
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = EL.GETPROPNUMBER([CATEGORY]) returns the property number of the concrete element EL.
			%  N = Element.GETPROPNUMBER(EL) returns the property number of 'EL'.
			%  N = Element.GETPROPNUMBER('ConcreteElement') returns the property number of 'ConcreteElement'.
			%
			% Note that the Element.GETPROPNUMBER(EL) and Element.GETPROPNUMBER('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 8;
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
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in concrete element/error.
			%
			% CHECK = ConcreteElement.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EL.EXISTSPROP(PROP) checks whether PROP exists for EL.
			%  CHECK = Element.EXISTSPROP(EL, PROP) checks whether PROP exists for EL.
			%  CHECK = Element.EXISTSPROP(ConcreteElement, PROP) checks whether PROP exists for ConcreteElement.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ConcreteElement:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EL.EXISTSPROP(PROP) throws error if PROP does NOT exist for EL.
			%   Error id: [BRAPH2:ConcreteElement:WrongInput]
			%  Element.EXISTSPROP(EL, PROP) throws error if PROP does NOT exist for EL.
			%   Error id: [BRAPH2:ConcreteElement:WrongInput]
			%  Element.EXISTSPROP(ConcreteElement, PROP) throws error if PROP does NOT exist for ConcreteElement.
			%   Error id: [BRAPH2:ConcreteElement:WrongInput]
			%
			% Note that the Element.EXISTSPROP(EL) and Element.EXISTSPROP('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 8 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ConcreteElement:' 'WrongInput'], ...
					['BRAPH2' ':ConcreteElement:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ConcreteElement.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in concrete element/error.
			%
			% CHECK = ConcreteElement.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EL.EXISTSTAG(TAG) checks whether TAG exists for EL.
			%  CHECK = Element.EXISTSTAG(EL, TAG) checks whether TAG exists for EL.
			%  CHECK = Element.EXISTSTAG(ConcreteElement, TAG) checks whether TAG exists for ConcreteElement.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ConcreteElement:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EL.EXISTSTAG(TAG) throws error if TAG does NOT exist for EL.
			%   Error id: [BRAPH2:ConcreteElement:WrongInput]
			%  Element.EXISTSTAG(EL, TAG) throws error if TAG does NOT exist for EL.
			%   Error id: [BRAPH2:ConcreteElement:WrongInput]
			%  Element.EXISTSTAG(ConcreteElement, TAG) throws error if TAG does NOT exist for ConcreteElement.
			%   Error id: [BRAPH2:ConcreteElement:WrongInput]
			%
			% Note that the Element.EXISTSTAG(EL) and Element.EXISTSTAG('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ConcreteElement:' 'WrongInput'], ...
					['BRAPH2' ':ConcreteElement:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ConcreteElement.'] ...
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
			%  PROPERTY = EL.GETPROPPROP(POINTER) returns property number of POINTER of EL.
			%  PROPERTY = Element.GETPROPPROP(ConcreteElement, POINTER) returns property number of POINTER of ConcreteElement.
			%  PROPERTY = EL.GETPROPPROP(ConcreteElement, POINTER) returns property number of POINTER of ConcreteElement.
			%
			% Note that the Element.GETPROPPROP(EL) and Element.GETPROPPROP('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = EL.GETPROPTAG(POINTER) returns tag of POINTER of EL.
			%  TAG = Element.GETPROPTAG(ConcreteElement, POINTER) returns tag of POINTER of ConcreteElement.
			%  TAG = EL.GETPROPTAG(ConcreteElement, POINTER) returns tag of POINTER of ConcreteElement.
			%
			% Note that the Element.GETPROPTAG(EL) and Element.GETPROPTAG('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				concreteelement_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING' };
				tag = concreteelement_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = EL.GETPROPCATEGORY(POINTER) returns category of POINTER of EL.
			%  CATEGORY = Element.GETPROPCATEGORY(ConcreteElement, POINTER) returns category of POINTER of ConcreteElement.
			%  CATEGORY = EL.GETPROPCATEGORY(ConcreteElement, POINTER) returns category of POINTER of ConcreteElement.
			%
			% Note that the Element.GETPROPCATEGORY(EL) and Element.GETPROPCATEGORY('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ConcreteElement.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			concreteelement_category_list = { 1  1  1  3  4  2  2  6 };
			prop_category = concreteelement_category_list{prop};
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
			%  FORMAT = EL.GETPROPFORMAT(POINTER) returns format of POINTER of EL.
			%  FORMAT = Element.GETPROPFORMAT(ConcreteElement, POINTER) returns format of POINTER of ConcreteElement.
			%  FORMAT = EL.GETPROPFORMAT(ConcreteElement, POINTER) returns format of POINTER of ConcreteElement.
			%
			% Note that the Element.GETPROPFORMAT(EL) and Element.GETPROPFORMAT('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ConcreteElement.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			concreteelement_format_list = { 2  2  2  8  2  2  2  2 };
			prop_format = concreteelement_format_list{prop};
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
			%  DESCRIPTION = EL.GETPROPDESCRIPTION(POINTER) returns description of POINTER of EL.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ConcreteElement, POINTER) returns description of POINTER of ConcreteElement.
			%  DESCRIPTION = EL.GETPROPDESCRIPTION(ConcreteElement, POINTER) returns description of POINTER of ConcreteElement.
			%
			% Note that the Element.GETPROPDESCRIPTION(EL) and Element.GETPROPDESCRIPTION('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ConcreteElement.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			concreteelement_description_list = { 'ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).'  'NAME (constant, string) is the name of the concrete element.'  'DESCRIPTION (constant, string) is the description of the concrete element.'  'TEMPLATE (parameter, item) is the template of the concrete element.'  'ID (data, string) is a few-letter code for the concrete element.'  'LABEL (metadata, string) is an extended label of the concrete element.'  'NOTES (metadata, string) are some specific notes about the concrete element.'  'TOSTRING (query, string) returns a string that represents the concrete element.' };
			prop_description = concreteelement_description_list{prop};
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
			%  SETTINGS = EL.GETPROPSETTINGS(POINTER) returns settings of POINTER of EL.
			%  SETTINGS = Element.GETPROPSETTINGS(ConcreteElement, POINTER) returns settings of POINTER of ConcreteElement.
			%  SETTINGS = EL.GETPROPSETTINGS(ConcreteElement, POINTER) returns settings of POINTER of ConcreteElement.
			%
			% Note that the Element.GETPROPSETTINGS(EL) and Element.GETPROPSETTINGS('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ConcreteElement.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % ConcreteElement.ELCLASS
					prop_settings = Format.getFormatSettings(2);
				case 2 % ConcreteElement.NAME
					prop_settings = Format.getFormatSettings(2);
				case 3 % ConcreteElement.DESCRIPTION
					prop_settings = Format.getFormatSettings(2);
				case 4 % ConcreteElement.TEMPLATE
					prop_settings = 'ConcreteElement';
				case 5 % ConcreteElement.ID
					prop_settings = Format.getFormatSettings(2);
				case 6 % ConcreteElement.LABEL
					prop_settings = Format.getFormatSettings(2);
				case 7 % ConcreteElement.NOTES
					prop_settings = Format.getFormatSettings(2);
				case 8 % ConcreteElement.TOSTRING
					prop_settings = Format.getFormatSettings(2);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ConcreteElement.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ConcreteElement.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EL.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EL.
			%  DEFAULT = Element.GETPROPDEFAULT(ConcreteElement, POINTER) returns the default value of POINTER of ConcreteElement.
			%  DEFAULT = EL.GETPROPDEFAULT(ConcreteElement, POINTER) returns the default value of POINTER of ConcreteElement.
			%
			% Note that the Element.GETPROPDEFAULT(EL) and Element.GETPROPDEFAULT('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ConcreteElement.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % ConcreteElement.ELCLASS
					prop_default = 'ConcreteElement';
				case 2 % ConcreteElement.NAME
					prop_default = 'Concrete Element';
				case 3 % ConcreteElement.DESCRIPTION
					prop_default = 'A Concrete Element (ConcreteElement) provides the infrastructure necessary for all concrete elements. In particular, it has the constant properties NAME (string) and DESCRIPTION (string), the property TEMPLATE (item), and the indexing properties ID (string), LABEL (string), and NOTES (string). Even though it is possible to create instances of ConcreteElement, typically one uses its subclasses.';
				case 4 % ConcreteElement.TEMPLATE
					prop_default = Format.getFormatDefault(8, ConcreteElement.getPropSettings(prop));
				case 5 % ConcreteElement.ID
					prop_default = 'ConcreteElement ID';
				case 6 % ConcreteElement.LABEL
					prop_default = 'ConcreteElement label';
				case 7 % ConcreteElement.NOTES
					prop_default = 'ConcreteElement notes';
				case 8 % ConcreteElement.TOSTRING
					prop_default = Format.getFormatDefault(2, ConcreteElement.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ConcreteElement.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ConcreteElement.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EL.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EL.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ConcreteElement, POINTER) returns the conditioned default value of POINTER of ConcreteElement.
			%  DEFAULT = EL.GETPROPDEFAULTCONDITIONED(ConcreteElement, POINTER) returns the conditioned default value of POINTER of ConcreteElement.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(EL) and Element.GETPROPDEFAULTCONDITIONED('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ConcreteElement.getPropProp(pointer);
			
			prop_default = ConcreteElement.conditioning(prop, ConcreteElement.getPropDefault(prop));
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(~, value)
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
			
		end
	end
	methods (Access=protected) % preset
		function value = preset(el, prop, value)
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
				case 4 % ConcreteElement.TEMPLATE
					if ~isa(el, class(value))
					    error( ...
					        ['BRAPH2' ':' class(el) ':' 'WrongInput'], ...
					        ['BRAPH2' ':' class(el) ':' 'WrongInput' '\n' ...
					        'The element (' class(el) ') must be a template (' class(value) ').'] ...
					        )
					end
					
			end
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = EL.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = EL.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of EL.
			%  CHECK = Element.CHECKPROP(ConcreteElement, PROP, VALUE) checks VALUE format for PROP of ConcreteElement.
			%  CHECK = EL.CHECKPROP(ConcreteElement, PROP, VALUE) checks VALUE format for PROP of ConcreteElement.
			% 
			% EL.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ConcreteElement:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  EL.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EL.
			%   Error id: BRAPH2:ConcreteElement:WrongInput
			%  Element.CHECKPROP(ConcreteElement, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConcreteElement.
			%   Error id: BRAPH2:ConcreteElement:WrongInput
			%  EL.CHECKPROP(ConcreteElement, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ConcreteElement.
			%   Error id: BRAPH2:ConcreteElement:WrongInput]
			% 
			% Note that the Element.CHECKPROP(EL) and Element.CHECKPROP('ConcreteElement')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ConcreteElement.getPropProp(pointer);
			
			switch prop
				case 1 % ConcreteElement.ELCLASS
					check = Format.checkFormat(2, value, ConcreteElement.getPropSettings(prop));
				case 2 % ConcreteElement.NAME
					check = Format.checkFormat(2, value, ConcreteElement.getPropSettings(prop));
				case 3 % ConcreteElement.DESCRIPTION
					check = Format.checkFormat(2, value, ConcreteElement.getPropSettings(prop));
				case 4 % ConcreteElement.TEMPLATE
					check = Format.checkFormat(8, value, ConcreteElement.getPropSettings(prop));
				case 5 % ConcreteElement.ID
					check = Format.checkFormat(2, value, ConcreteElement.getPropSettings(prop));
				case 6 % ConcreteElement.LABEL
					check = Format.checkFormat(2, value, ConcreteElement.getPropSettings(prop));
				case 7 % ConcreteElement.NOTES
					check = Format.checkFormat(2, value, ConcreteElement.getPropSettings(prop));
				case 8 % ConcreteElement.TOSTRING
					check = Format.checkFormat(2, value, ConcreteElement.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ConcreteElement:' 'WrongInput'], ...
					['BRAPH2' ':ConcreteElement:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ConcreteElement.getPropTag(prop) ' (' ConcreteElement.getFormatTag(ConcreteElement.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(el, prop)
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
				case 4 % ConcreteElement.TEMPLATE
					template = el.get('TEMPLATE');
					
					parameter_props = template.getProps(3);
					parameter_props = parameter_props(parameter_props ~= template.TEMPLATE);
					
					varargin = cell(1, 2 * length(parameter_props));
					for i = 1:1:length(parameter_props)
					    parameter_prop = parameter_props(i);
					    varargin{2 * i - 1} = parameter_prop;
					    varargin{2 * i} = template.getCallback(parameter_prop);    
					end
					
					warning_backup = warning('off', ['BRAPH2' ':' class(el)]);
					el.set(varargin{:});
					warning(warning_backup)
					
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(el, prop, varargin)
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
				case 8 % ConcreteElement.TOSTRING
					value = el.tostring();
					
				otherwise
					if prop <= Element.getPropNumber()
						value = calculateValue@Element(el, prop, varargin{:});
					else
						value = calculateValue@Element(el, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(el, prop, varargin)
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
				case 7 % ConcreteElement.NOTES
					pr = PanelPropStringTextArea('EL', el, 'PROP', 7, varargin{:});
					
				otherwise
					pr = getPanelProp@Element(el, prop, varargin{:});
					
			end
		end
	end
end
