# Implement a new Group Analysis

[![Tutorial Implement a new Group Analysis](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](dev_analysis_group.pdf)

This is the developer tutorial for implementing a new group analysis. 
In this tutorial, you will learn how to create a "*.gen.m" for a new group analysis, which can then be compiled by `braph2genesis`.
Here, you will use as examples the group analysis `AnalyzeGroup_ST_BUD`, an group-based graph analysis (AnalyzeGroup) analyzing structure data (ST) using binary undirected multigraphs at fixed densities (BUD).


## Table of Contents
> [Implementation of the group analysis](#Implementation-of-the-group-analysis)
>
>> [Basic properties](#Basic-properties)
>>
>> [Functionality-focused properties](#Functionalityfocused-properties)
>>
>> [Verification through testing](#Verification-through-testing)
>>



<a id="Implementation-of-the-group-analysis"></a>
## Implementation of the group analysis  [⬆](#Table-of-Contents)

You will implement in detail `AnalyzeGroup_ST_BUD`, a direct extension of `AnalyzeGroup`.
An `AnalyzeGroup_ST_BUD` processes structural data to construct binary undirected graphs at fixed densities.

<a id="Basic-properties"></a>
### Basic properties  [⬆](#Table-of-Contents)
This section focuses on implementing the basic properties required to define `AnalyzeGroup_ST_BUD`, including its class, name, and associated metadata.


> **Code 1.** **AnalyzeGroup_ST_BUD element header.**
> 		The `header` section of the generator code in "_AnalyzeGroup_ST_BUD.gen.m" provides the general information about the `AnalyzeGroup_ST_BUD` element.
> ````matlab
> %% ¡header!  ①
> AnalyzeGroup_ST_BUD < AnalyzeGroup (a, graph analysis with structural data at fixed density) is a graph analysis using structural data at fixed density.
> 
> %%% ¡description!  ②
> AnalyzeGroup_ST_BUD uses structural data at fixed density and analyzes them using binary undirected graphs.
> 
> %%% ¡seealso!
> SubjectST, MultigraphBUD
> 
> %%% ¡build!  ③
> 1
> ````
> 
> ① defines `AnalyzeGroup_ST_BUD` as a subclass of `AnalyzeGroup`. The moniker is `a`.
> 
> ② provides a description of this group analysis.
> 
> ③ defines the build number of the group analysis element.
> 


> **Code 2.** **Basic properties of AnalyzeGroup_ST_BUD.**
> 		This section of the generator code in "_AnalyzeGroup_ST_BUD.gen.m" updates the basic properties required to describe the `AnalyzeGroup_ST_BUD` element, including its class, name, description, and other metadata.
> ````matlab
> %% ¡props_update!
> 
> %%% ¡prop!
> ELCLASS (constant, string) is the class of the group-based graph analysis with structural data at fixed density.
> %%%% ¡default!
> 'AnalyzeGroup_ST_BUD'
> 
> %%% ¡prop!
> NAME (constant, string) is the name of the group-based graph analysis with structural data at fixed density.
> %%%% ¡default!
> 'Structural Binary Undirected at fixed Densities Analyze Group'
> 
> %%% ¡prop!
> DESCRIPTION (constant, string) is the description of the group-based graph analysis with structural data at fixed density.
> %%%% ¡default!
> 'AnalyzeGroup_ST_BUD uses structural data at fixed density and analyzes them using binary undirected graphs.'
> ````
> 

<a id="Functionalityfocused-properties"></a>
### Functionality-focused properties  [⬆](#Table-of-Contents)

This section details the implementation of functionality-focused properties that enable `AnalyzeGroup_ST_BUD` to perform graph analysis directly.


> **Code 3.** **Implementation properties of AnalyzeGroup_ST_BUD.**
> 		This section of the generator code in "_AnalyzeGroup_ST_BUD.gen.m" updates the properties to be used, including `TEMPLATE` for specifying its `G` with graph type and parameters as a graph template, `GR` for defining subjects' data, , and `G` for managing the graph instance obtained using the subjects' data.
> ````matlab
> %%% ¡prop!  ①
> TEMPLATE (parameter, item) is the template of the group-based graph analysis with structural data at fixed density.
> %%%% ¡settings!
> 'AnalyzeGroup_ST_BUD'
> 
> %%% ¡prop!
> ID (data, string) is a few-letter code for the group-based graph analysis with structural data at fixed density.
> %%%% ¡default!
> 'AnalyzeGroup_ST_BUD ID'
> 
> %%% ¡prop!
> LABEL (metadata, string) is an extended label of the group-based graph analysis with structural data at fixed density.
> %%%% ¡default!
> 'AnalyzeGroup_ST_BUD label'
> 
> %%% ¡prop!
> NOTES (metadata, string) are some specific notes about the group-based graph analysis with structural data at fixed density.
> %%%% ¡default!
> 'AnalyzeGroup_ST_BUD notes'
> 
> %%% ¡prop!  ②
> GR (data, item) is the subject group, which also defines the subject class SubjectST.
> %%%% ¡default!
> Group('SUB_CLASS', 'SubjectST')
> 
> %%% ¡prop!  ③
> G (result, item) is the graph obtained from this analysis.
> %%%% ¡settings!
> 'MultigraphBUD'
> %%%% ¡calculate!
> gr = a.get('GR');
> data_list = cellfun(@(x) x.get('ST'), gr.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false);  ④
> data = cat(2, data_list{:})'; % correlation is a column based operation
> 
> if any(strcmp(a.get('CORRELATION_RULE'), {Correlation.PEARSON_CV, Correlation.SPEARMAN_CV}))
>     A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'), gr.get('COVARIATES')); ⑤
> else
>     A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE')); ⑥
> end
> 
> densities = a.get('DENSITIES'); % this is a vector  ⑦
> 
> g = MultigraphBUD( ... ⑧
>     'ID', ['Graph ' gr.get('ID')], ...
>     'B', A, ...
>     'DENSITIES', densities, ... 
>     'LAYERLABELS', cellfun(@(x) [num2str(x) '%'], num2cell(densities), 'UniformOutput', false) ...
>     );
> 
> if ~isa(a.getr('TEMPLATE'), 'NoValue') % the analysis has a template
>     g.set('TEMPLATE', a.get('TEMPLATE').memorize('G')) % the template is memorized - overwrite densities  ⑨
> end
> 
> if a.get('GR').get('SUB_DICT').get('LENGTH')
>     g.set('NODELABELS', a.get('GR').get('SUB_DICT').get('IT', 1).get('BA').get('BR_DICT').get('KEYS'))
> end
> 
> value = g;
> ````
> 
> ① S
> specifies the `TEMPLATE` property, in which `G`, serving as a graph template, defines parameters such as `DENSITIES`, `SEMIPOSITIVIZE_RULE`, and `STANDARDIZE_RULE`. These settings are applied to the graph in ⑧.
> 
> ② defines the `GR` property, which stores the subjects using the `SubjectST` element. This property contains the subjects’ data to be analyzed.
> 
> ③ creates the `G` property, a graph that uses `MultigraphBUD`.
> 
> ④ retrieves the subjects’ structural data from ②, which is used to construct the `MultigraphBUD` instance for analysis.
> 
> ⑤ or ⑥ calculates the adjacency matrix based on whether group covariates (e.g., age and sex) are considered. Covariates are included for partial correlation if the `CORRELATION_RULE` property, introduced in ① of Code 4, is set to `PEARSON_CV` (Pearson with covariates) or `SPEARMAN_CV` (Spearman with covariates).
> 
> ⑦ retrieves the densities defined in the new property in ② of Code 4. These densities configure the `MultigraphBUD` instance for analysis.
> 
> ⑧ defines the graph by constructing an instance of `MultigraphBUD` for the calculated adjacency matrix and applying the specified `DENSITIES` parameter.
> 
> ⑨ ensures the `MultigraphBUD` instance is updated with pre-defined parameters (e.g., `DENSITIES`, `SEMIPOSITIVIZE_RULE`, and `STANDARDIZE_RULE`) from the graph template specified in ①. If explicitly set by the user during initialization of `AnalyzeGroup_ST_BUD`, the densities will be overwritten with those in the graph template.
> 


> **Code 4.** **AnalyzeGroup_ST_BUD element props.**
> 	The `props` section of the generator code in "_AnalyzeGroup_ST_BUD.gen.m" defines the properties to be used in `AnalyzeGroup_ST_BUD`.
> ````matlab
> %% ¡props!
> 
> %%% ¡prop!  ①
> CORRELATION_RULE (parameter, option) is the correlation type.
> %%%% ¡settings!
> Correlation.CORRELATION_RULE_LIST
> %%%% ¡default!
> Correlation.PEARSON
> 
> %%% ¡prop!  ②
> NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
> %%%% ¡settings!
> Correlation.NEGATIVE_WEIGHT_RULE_LIST
> %%%% ¡default!
> Correlation.ZERO
> 
> %%% ¡prop!  ③
> DENSITIES (parameter, rvector) is the vector of densities.
> %%%% ¡default!
> [1:1:10]
> %%%% ¡gui!  ④
> pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeGroup_ST_BUD.DENSITIES, ...
>     'MIN', 0, 'MAX', 100, ...
>     'DEFAULT', AnalyzeGroup_ST_BUD.getPropDefault('DENSITIES'), ...
>     varargin{:});
> ````
> 
> ① defines the `CORRELATION_RULE` as one of the options in the list (PEARSON, SPEARMAN, KENDALL, PEARSON_CV, SPEARMAN_CV), used in ⑤ of Code 3.
> 
> ② defines the `NEGATIVE_WEIGHT_RULE` as one of the options in the list (ZERO, ABS, NONE), used in ⑤ of Code 3.
> 
> ③ defines the densities for binarizing the connectivity matrix in a binary undirected multigraph, used in ⑦ of Code 3.
> 
> ④ `PanelPropRVectorSmart` renders a GUI row vector panel for defining densities, supporting MATLAB expressions and limiting values between MIN and MAX.
> 

<a id="Verification-through-testing"></a>
### Verification through testing  [⬆](#Table-of-Contents)
This section validates `AnalyzeGroup_ST_BUD` by implementing tests to confirm its functionality via example scripts and ensure GUI integration.


> **Code 5.** **AnalyzeGroup_ST_BUD element tests.**
> 		The `tests` section in the element generator "_AnalyzeGroup_ST_BUD.gen.m" includes logic tests, which verify correct functionality using example scripts and simulated datasets, and integration tests, which ensure the instance operation of the direct GUI and associated GUIs.
> ````matlab
> %% ¡tests!
> 
> %%% ¡test! ①
> %%%% ¡name!
> Example
> %%%% ¡probability! ②
> .01
> %%%% ¡code! 
> create_data_ST_XLS() % only creates files if the example folder doesn't already exist
> 
> example_ST_BUD
> 
> %%% ¡test!  ③
> %%%% ¡name!
> GUI - Analysis
> %%%% ¡probability!
> .01
> %%%% ¡code!
> im_ba = ImporterBrainAtlasXLS('FILE', 'destrieux_atlas.xlsx');
> ba = im_ba.get('BA'); ④
> 
> gr = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));  ⑤
> for i = 1:1:50
>     sub = SubjectST( ...
>         'ID', ['SUB ST ' int2str(i)], ...
>         'LABEL', ['Subejct ST ' int2str(i)], ...
>         'NOTES', ['Notes on subject ST ' int2str(i)], ...
>         'BA', ba, ...
>         'ST', rand(ba.get('BR_DICT').get('LENGTH'), 1) ...
>         );
>     sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
>     sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
>     gr.get('SUB_DICT').get('ADD', sub)
> end
> 
> a = AnalyzeGroup_ST_BUD('GR', gr, 'DENSITIES', 5:10:35);  ⑥
> 
> gui = GUIElement('PE', a, 'CLOSEREQ', false); ⑦
> gui.get('DRAW') ⑧
> gui.get('SHOW') ⑨
> 
> gui.get('CLOSE') ⑩
> 
> %%% ¡test! ⑪
> %%%% ¡name!
> GUI - Comparison
> %%%% ¡probability!
> .01
> %%%% ¡code!
> im_ba = ImporterBrainAtlasXLS('FILE', 'destrieux_atlas.xlsx');
> ba = im_ba.get('BA');
> 
> gr1 = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
> for i = 1:1:50
>     sub = SubjectST( ...
>         'ID', ['SUB ST ' int2str(i)], ...
>         'LABEL', ['Subejct ST ' int2str(i)], ...
>         'NOTES', ['Notes on subject ST ' int2str(i)], ...
>         'BA', ba, ...
>         'ST', rand(ba.get('BR_DICT').get('LENGTH'), 1) ...
>         );
>     sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
>     sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
>     gr1.get('SUB_DICT').get('ADD', sub)
> end
> 
> gr2 = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
> for i = 1:1:50
>     sub = SubjectST( ...
>         'ID', ['SUB ST ' int2str(i)], ...
>         'LABEL', ['Subejct ST ' int2str(i)], ...
>         'NOTES', ['Notes on subject ST ' int2str(i)], ...
>         'BA', ba, ...
>         'ST', rand(ba.get('BR_DICT').get('LENGTH'), 1) ...
>         );
>     sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
>     sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
>     gr2.get('SUB_DICT').get('ADD', sub)
> end
> 
> a1 = AnalyzeGroup_ST_BUD('GR', gr1, 'DENSITIES', 5:10:35); ⑫
> a2 = AnalyzeGroup_ST_BUD('GR', gr2, 'TEMPLATE', a1);  ⑬
> 
> c = CompareGroup( ... ⑭
>     'P', 10, ...
>     'A1', a1, ...
>     'A2', a2, ...
>     'WAITBAR', true, ...
>     'VERBOSE', false, ...
>     'MEMORIZE', true ...
>     );
> 
> gui = GUIElement('PE', c, 'CLOSEREQ', false); ⑮
> gui.get('DRAW') ⑯
> gui.get('SHOW') ⑰
> 
> gui.get('CLOSE') ⑱
> ````
> 
> ① Tests the functionality of `AnalyzeGroup_ST_BUD` using an example script.
> 
> ② assigns a low test execution probability.
> 
> ③ Tests the direct GUI functionality of `AnalyzeGroup_ST_BUD`.
> 
> ④ and ⑤ define the necessary objects required to initialize an instance of `AnalyzeGroup_ST_BUD`.
> 
> ⑥ initializes an `AnalyzeGroup_ST_BUD` instance using the specified `gr` (group) and `densities`.
> 
> ⑦, ⑧, and ⑨ test the process of creating a GUI for `AnalyzeGroup_ST_BUD`, drawing it, and showing it on the screen.
> 
> ⑩ tests the process of closing the shown GUI.
> 
> ⑪ tests the associated GUI functionality of `AnalyzeGroup_ST_BUD`.
> 
> ⑫ Similar to the previous test, this initializes the first `AnalyzeGroup_ST_BUD` with the specified `gr` and densities.
> 
> ⑬ initializes the second `AnalyzeGroup_ST_BUD` using the first `AnalyzeGroup_ST_BUD` instance as a template. This setup allows the second instance to have its own `gr` data while applying the same parameters, specifically the densities.
> 
> ⑭ creates a `CompareGroup` instance with the defined `AnalyzeGroup_ST_BUD` instances.
> 
> ⑮, ⑯, ⑰, and ⑱ test creating, drawing, showing, and closing the GUI of the `CompareGroup`, which is an associated GUI of `AnalyzeGroup_ST_BUD`
>
