# Implement a New Neural Network Data Point

[![Tutorial Implement a New Neural Network Data Point](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](dev_nn_datapoint.pdf)

This is the developer tutorial for implementing a new neural network data point. 
In this Tutorial, you will learn how to create the generator file "*.gen.m" for a new neural network data point, which can then be compiled by `braph2genesis`. All kinds of neural network data point are (direct or indirect) extensions of the base element `NNDataPoint`. Here, you will use as examples the neural network data point `NNDataPoint_CON_REG` (connectivity data for regression), `NNDataPoint_CON_CLA` (connectivity data for classification), `NNDataPoint_Graph_REG` (adjacency matrix for regression), `NNDataPoint_Graph_CLA` (adjacency matrix for classification), `NNDataPoint_Measure_REG` (graph measure for regression), and `NNDataPoint_Measure_CLA` (graph measure for classification).


## Table of Contents
> [Implementation of a data point with connectivity data](#Implementation-of-a-data-point-with-connectivity-data)
>
>> [Connectivity data point for regression (`NNDataPoint_CON_REG`)](#Connectivity-data-point-for-regression-NNDataPointCONREG)
>>
>> [Connectivity data point for classification (`NNDataPoint_CON_CLA`)](#Connectivity-data-point-for-classification-NNDataPointCONCLA)
>>
> [Implementation of a data point with a graph](#Implementation-of-a-data-point-with-a-graph)
>
>> [Graph data point for regression (`NNDataPoint_Graph_REG`)](#Graph-data-point-for-regression-NNDataPointGraphREG)
>>
>> [Graph data point for classification (`NNDataPoint_Graph_CLA`)](#Graph-data-point-for-classification-NNDataPointGraphCLA)
>>
> [Implementation of a data point with graph measures](#Implementation-of-a-data-point-with-graph-measures)
>
>> [Graph measure data point for regression (`NNDataPoint_Measure_REG`)](#Graph-measure-data-point-for-regression-NNDataPointMeasureREG)
>>
>> [Graph measure data point for classification (`NNDataPoint_Measure_CLA`)](#Graph-measure-data-point-for-classification-NNDataPointMeasureCLA)
>>



<a id="Implementation-of-a-data-point-with-connectivity-data"></a>
## Implementation of a data point with connectivity data  [⬆](#Table-of-Contents)

<a id="Connectivity-data-point-for-regression-NNDataPointCONREG"></a>
### Connectivity data point for regression (`NNDataPoint_CON_REG`)  [⬆](#Table-of-Contents)

You will start by implementing in detail `NNDataPoint_CON_REG`, which is a direct extension of `NNDataPoint`.
A `NNDataPoint_CON_REG` contains the input and target for neural network analysis with a subject with connectivity data (`SubjectCON`), where the input is the subject's connectivity data and the target are the subject's variables of interest.


> **Code 1.** **NNDataPoint_CON_REG element header.**
> 		The `header` section of the generator code in "_NNDataPoint_CON_REG.gen.m" provides the general information about the `NNDataPoint_CON_REG` element.
> ````matlab
> %% ¡header!
> NNDataPoint_CON_REG < NNDataPoint (dp, connectivity regression data point) is a data point for regression with connectivity data.
>   ①
> 
> %%% ¡description!
> A data point for regression with connectivity data (NNDataPoint_CON_REG) 
> contains the input and target for neural network analysis with a subject with connectivity data (SubjectCON).
> The input is the connectivity data of the subject.
> The target is obtained from the variables of interest of the subject.
> 
> %%% ¡build!
> 1
> ````
> 
> ① defines `NNDataPoint_CON_REG` as a subclass of `NNDataPoint`. The moniker will be `dp`.
> 


> **Code 2.** **NNDataPoint_CON_REG element props update.**
> 		The `props_update` section of the generator code in "_NNDataPoint_CON_REG.gen.m" updates the properties of the `NNDataPoint` element. This defines the core properties of the data point.
> ````matlab
> %% ¡props_update!
> 
> %%% ¡prop!
> NAME (constant, string) is the name of a data point for regression with connectivity data.
> %%%% ¡default!
> 'NNDataPoint_CON_REG'
> 
> %%% ¡prop!
> DESCRIPTION (constant, string) is the description of a data point for regression with connectivity data.
> %%%% ¡default!
> 'A data point for regression with connectivity data (NNDataPoint_CON_REG) contains the input and target for neural network analysis with a subject with connectivity data (SubjectCON). The input is the connectivity data of the subject. The target is obtained from the variables of interest of the subject.'
> 
> %%% ¡prop!
> TEMPLATE (parameter, item) is the template of a data point for regression with connectivity data.
> %%%% ¡settings!
> 'NNDataPoint_CON_REG'
> 
> %%% ¡prop!
> ID (data, string) is a few-letter code for a data point for regression with connectivity data.
> %%%% ¡default!
> 'NNDataPoint_CON_REG ID'
> 
> %%% ¡prop!
> LABEL (metadata, string) is an extended label of a data point for regression with connectivity data.
> %%%% ¡default!
> 'NNDataPoint_CON_REG label'
> 
> %%% ¡prop!
> NOTES (metadata, string) are some specific notes about a data point for regression with connectivity data.
> %%%% ¡default!
> 'NNDataPoint_CON_REG notes'
> 
> %%% ¡prop!   ①
> INPUT (result, cell) is the input value for this data point.
> %%%% ¡calculate!
> value = {dp.get('SUB').get('CON')};  ②
>     
> %%% ¡prop!  ③
> TARGET (result, cell) is the target value for this data point.
> %%%% ¡calculate!
> value = cellfun(@(x) dp.get('SUB').get('VOI_DICT').get('IT', x).get('V'), dp.get('TARGET_IDS'), 'UniformOutput', false);  ④
> ````
> 
> ① The property `INPUT` is the input value for this data point, which is obtained directly from the connectivity data of `Subject_CON` ②.
> 
> ③ The property `TARGET` is the target value for this data point, which is obtained directly from the variables of interest ④.
> 


> **Code 3.** **NNDataPoint_CON_REG element props.**
> 		The `props` section of generator code in "_NNDataPoint_CON_REG.gen.m" defines the properties to be used in "NNDataPoint_CON_REG".
> ````matlab
> %% ¡props!
> 
> %%% ¡prop!  ①
> SUB (data, item) is a subject with connectivity data.
> %%%% ¡settings!
> 'SubjectCON'
> 
> %%% ¡prop!  ②
> TARGET_IDS (parameter, stringlist) is a list of variable-of-interest IDs to be used as regression targets.
> ````
> 
> ① The property `SUB` is a subject with connectivity data (`Subject_CON`), which is used to calculated the properties `INPUT` and `TARGET`.
> 
> ② The property `TARGET_IDS` defines the IDs of target, where the target IDs should be from the subject's variable-of-interest IDs.
> 




> **Code 4.** **NNDataPoint_CON_REG element tests.**
> 		The `tests` section from the element generator "_NNDataPoint_CON_REG.gen.m".
> 		A test for creating example files should be prepared to test the properties of the data point. Furthermore, additional test should be prepared for validating the value of input and target for the data point.
> ````matlab
> %% ¡tests!
> 
> %%% ¡excluded_props!   ①
> [NNDataPoint_CON_REG.SUB]
> 
> %%% ¡test!
> %%%% ¡name!
> Example   ②
> %%%% ¡code!
> create_data_NN_REG_CON_TXT() % only creates files if the example folder doesn't already exist
> create_data_NN_REG_CON_XLS() % only creates files if the example folder doesn't already exist
> 
> %%% ¡test! 
> %%%% ¡name!  ③
> Create a NNDataset containg NNDataPoint_CON_REG with simulated data
> %%%% ¡code!
> % Load BrainAtlas
> im_ba = ImporterBrainAtlasXLS( ...
>     'FILE', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'], ...
>     'WAITBAR', true ...
>     );
> 
> ba = im_ba.get('BA');
> 
> % Load Group of SubjectCON
> im_gr = ImporterGroupSubjectCON_XLS( ...
>     'DIRECTORY', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'CON_Group_XLS'], ...
>     'BA', ba, ...
>     'WAITBAR', true ...
>     );
> 
> gr = im_gr.get('GR');
> 
> % create an item list of NNDataPoint_CON_REG  ④
> it_list = cellfun(@(x) NNDataPoint_CON_REG( ...
>     'ID', x.get('ID'), ...
>     'SUB', x, ...
>     'TARGET_IDS', x.get('VOI_DICT').get('KEYS')), ...
>     gr.get('SUB_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> % create a NNDataPoint_CON_REG DICT  ⑤
> dp_list = IndexedDictionary(...
>         'IT_CLASS', 'NNDataPoint_CON_REG', ...
>         'IT_LIST', it_list ...
>         );
> 
> % create a NNDataset containing the NNDataPoint_CON_REG DICT  ⑥
> d = NNDataset( ...
>     'DP_CLASS', 'NNDataPoint_CON_REG', ...
>     'DP_DICT', dp_list ...
>     );
> 
> % Check whether the number of inputs matches  ⑦
> assert(length(d.get('INPUTS')) == gr.get('SUB_DICT').get('LENGTH'), ...
>         [BRAPH2.STR ':NNDataPoint_CON_REG:' BRAPH2.FAIL_TEST], ...
>         'NNDataPoint_CON_REG does not construct the dataset correctly. The number of the inputs should be the same as the number of imported subjects.' ...
>         )
> 
> % Check whether the number of targets matches  ⑧
> assert(length(d.get('TARGETS')) == gr.get('SUB_DICT').get('LENGTH'), ...
>         [BRAPH2.STR ':NNDataPoint_CON_REG:' BRAPH2.FAIL_TEST], ...
>         'NNDataPoint_CON_REG does not construct the dataset correctly. The number of the targets should be the same as the number of imported subjects.' ...
>         )
> 
> % Check whether the content of input for a single data point matches  ⑨
> for index = 1:1:gr.get('SUB_DICT').get('LENGTH')
>     individual_input = d.get('DP_DICT').get('IT', index).get('INPUT');
>     known_input = {gr.get('SUB_DICT').get('IT', index).get('CON')};
> 
>     assert(isequal(individual_input, known_input), ...
>         [BRAPH2.STR ':NNDataPoint_CON_REG:' BRAPH2.FAIL_TEST], ...
>         'NNDataPoint_CON_REG does not construct the dataset correctly. The input value is not derived correctly.' ...
>         )
> end
> 
> %%% ¡test! 
> %%%% ¡name!   ⑩
> Example training-test regression
> %%%% ¡code!
> % ensure the example data is generated
> if ~isfile([fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_REG_CON_XLS() % create example files
> end
> 
> example_NN_CON_REG
> ````
> 
> ① List of properties that are excluded from testing.
> 
> ② creates the example connectivity data files for regression analysis.
> 
> ③ validates the data point by using assertions to confirm that the input and target calculated values match the connectivity data and the variables of interest in the example files.
> 
> ④-⑥ create an item list for the data points, subsequently generates the data point dictionary using the list, and then constructs the neural network dataset containing these data points.
> 
> ⑦ tests the number of inputs from the dataset matches the number of subjects in the group.
> 
> ⑧ tests the number of targets from the dataset matches the number of subjects in the group.
> 
> ⑨ tests the value of each input from the data point matches the subject's connectivity data.
> 
> ⑩ executes the corresponding example scripts to ensure the functionalities.
> 



<a id="Connectivity-data-point-for-classification-NNDataPointCONCLA"></a>
### Connectivity data point for classification (`NNDataPoint_CON_CLA`)  [⬆](#Table-of-Contents)

You can now use `NNDataPoint_CON_REG` as the basis to implement the `NNDataPoint_CON_CLA`, which can be used for classification tasks.
> **Code 5.** **NNDataPoint_CON_CLA element header.**
> 		The `header` section of the generator code in "_NNDataPoint_CON_CLA.gen.m" provides the general information about the `NNDataPoint_CON_CLA` element. This code modifies Code 1.
> ````matlab
> %% ¡header!
> NNDataPoint_CON_CLA < NNDataPoint (dp, connectivity classification data point) is a data point for classification with connectivity data. . . . .%%% ¡description!
> A data point for classification with connectivity data (NNDataPoint_CON_CLA) 
> contains the input and target for neural network analysis with a subject with connectivity data (SubjectCON).
> The input is the connectivity data of the subject.
> The target is obtained from the variables of interest of the subject.
> 
> %%% ¡build!
> 1
> ````
> 


> **Code 6.** **NNDataPoint_CON_CLA element props update.**
> 		The `props_update` section of the generator code in "_NNDataPoint_CON_CLA.gen.m" updates the properties of the `NNDataPoint_CON_CLA` element. This defines the core properties of the data point. This code modifies Code {cd:m:NNDataPoint_CON_REG:prop_update}.
> ````matlab
> %% ¡props_update!
> 
> %%% ¡prop!
> NAME (constant, string) is the name of a data point for classification with connectivity data.
> %%%% ¡default!
> 'NNDataPoint_CON_CLA'
> 
> %%% ¡prop!
> DESCRIPTION (constant, string) is the description of a data point for classification with connectivity data.
> %%%% ¡default!
> 'A data point for classification with connectivity data (NNDataPoint_CON_CLA) contains the input and target for neural network analysis with a subject with connectivity data (SubjectCON). The input is the connectivity data of the subject. The target is obtained from the variables of interest of the subject.'
> 
> %%% ¡prop!
> TEMPLATE (parameter, item) is the template of a data point for classification with connectivity data.
> %%%% ¡settings!
> 'NNDataPoint_CON_CLA'
> 
> %%% ¡prop!
> ID (data, string) is a few-letter code for a data point for classification with connectivity data.
> %%%% ¡default!
> 'NNDataPoint_CON_CLA ID'
> 
> %%% ¡prop!
> LABEL (metadata, string) is an extended label of a data point for classification with connectivity data.
> %%%% ¡default!
> 'NNDataPoint_CON_CLA label'
> 
> %%% ¡prop!
> NOTES (metadata, string) are some specific notes about a data point for classification with connectivity data.
> %%%% ¡default!
> 'NNDataPoint_CON_CLA notes'
> 
> %%% ¡prop!
> INPUT (result, cell) is the input value for this data point.
> %%%% ¡calculate!
> value = {dp.get('SUB').get('CON')};
>     
> %%% ¡prop!  ①
> TARGET (result, cell) is the target values for this data point.
> %%%% ¡calculate!
> value = cellfun(@(c) sum(double(c)), dp.get('TARGET_CLASS'), 'UniformOutput', false);
> ````
> 
> ① defines the target value using the data point's label in the form of a string, e.g., `'Group1'`, contained in a cell array and representing the class of the data point.
> 


> **Code 7.** **NNDataPoint_CON_CLA element props.**
> 		The `props` section of generator code in "_NNDataPoint_CON_CLA.gen.m" defines the properties to be used in "NNDataPoint_CON_CLA".
> ````matlab
> %% ¡props!
> 
> %%% ¡prop!
> SUB (data, item) is a subject with connectivity data.
> %%%% ¡settings!
> 'SubjectCON'
> 
> %%% ¡prop!
> TARGET_CLASS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.
> ````
> 


> **Code 8.** **NNDataPoint_CON_CLA element tests.**
> 		The `tests` section from the element generator "_NNDataPoint_CON_CLA.gen.m".
> 		A test for creating example files should be prepared to test the properties of the data point. Furthermore, additional test should be prepared for validating the value of input and target for the data point.
> ````matlab
> %% ¡tests!
> 
> %%% ¡excluded_props!
> [NNDataPoint_CON_CLA.SUB]
> 
> %%% ¡test!
> %%%% ¡name!
> Example
> %%%% ¡code!
> create_data_NN_CLA_CON_XLS() % only creates files if the example folder doesn't already exist
> create_data_NN_CLA_CON_TXT() % only creates files if the example folder doesn't already exist
> 
> 
> %%% ¡test! 
> %%%% ¡name!
> Create a NNDataset containg NNDataPoint_CON_CLA with simulated data
> %%%% ¡code!
> % Load BrainAtlas
> im_ba = ImporterBrainAtlasXLS( ...
>     'FILE', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'], ...
>     'WAITBAR', true ...
>     );
> 
> ba = im_ba.get('BA');
> 
> % Load Groups of SubjectCON   ⑥
> im_gr1 = ImporterGroupSubjectCON_XLS( ...
>     'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'CON_Group_1_XLS'], ...
>     'BA', ba, ...
>     'WAITBAR', true ...
>     );
> 
> gr1 = im_gr1.get('GR');
> 
> im_gr2 = ImporterGroupSubjectCON_XLS( ...
>     'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'CON_Group_2_XLS'], ...
>     'BA', ba, ...
>     'WAITBAR', true ...
>     );
> 
> gr2 = im_gr2.get('GR');
> 
> % create item lists of NNDataPoint_CON_CLA   ⑦
> [~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
> it_list1 = cellfun(@(x) NNDataPoint_CON_CLA( ...
>     'ID', x.get('ID'), ...
>     'SUB', x, ...
>     'TARGET_CLASS', {group_folder_name}), ...
>     gr1.get('SUB_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> [~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
> it_list2 = cellfun(@(x) NNDataPoint_CON_CLA( ...
>     'ID', x.get('ID'), ...
>     'SUB', x, ...
>     'TARGET_CLASS', {group_folder_name}), ...
>     gr2.get('SUB_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> % create NNDataPoint_CON_CLA DICT items
> dp_list1 = IndexedDictionary(...
>         'IT_CLASS', 'NNDataPoint_CON_CLA', ...
>         'IT_LIST', it_list1 ...
>         );
> 
> dp_list2 = IndexedDictionary(...
>         'IT_CLASS', 'NNDataPoint_CON_CLA', ...
>         'IT_LIST', it_list2 ...
>         );
> 
> % create a NNDataset containing the NNDataPoint_CON_CLA DICT
> d1 = NNDataset( ...
>     'DP_CLASS', 'NNDataPoint_CON_CLA', ...
>     'DP_DICT', dp_list1 ...
>     );
> 
> d2 = NNDataset( ...
>     'DP_CLASS', 'NNDataPoint_CON_CLA', ...
>     'DP_DICT', dp_list2 ...
>     );
> 
> % Check whether the number of inputs matches  ⑧
> assert(length(d1.get('INPUTS')) == gr1.get('SUB_DICT').get('LENGTH'), ...
>         [BRAPH2.STR ':NNDataPoint_CON_CLA:' BRAPH2.FAIL_TEST], ...
>         'NNDataPoint_CON_CLA does not construct the dataset correctly. The number of the inputs should be the same as the number of imported subjects of group 1.' ...
>         )
> 
> assert(length(d2.get('INPUTS')) == gr2.get('SUB_DICT').get('LENGTH'), ...
>         [BRAPH2.STR ':NNDataPoint_CON_CLA:' BRAPH2.FAIL_TEST], ...
>         'NNDataPoint_CON_CLA does not construct the dataset correctly. The number of the inputs should be the same as the number of imported subjects of group 2.' ...
>         )
> 
> % Check whether the number of targets matches  ⑨
> assert(length(d1.get('TARGETS')) == gr1.get('SUB_DICT').get('LENGTH'), ...
>         [BRAPH2.STR ':NNDataPoint_CON_CLA:' BRAPH2.FAIL_TEST], ...
>         'NNDataPoint_CON_CLA does not construct the dataset correctly. The number of the targets should be the same as the number of imported subjects of group 1.' ...
>         )
> 
> assert(length(d2.get('TARGETS')) == gr2.get('SUB_DICT').get('LENGTH'), ...
>         [BRAPH2.STR ':NNDataPoint_CON_CLA:' BRAPH2.FAIL_TEST], ...
>         'NNDataPoint_CON_CLA does not construct the dataset correctly. The number of the targets should be the same as the number of imported subjects of group 2.' ...
>         )
> 
> % Check whether the content of input for a single data point matches  ⑩
> for index = 1:1:gr1.get('SUB_DICT').get('LENGTH')
>     individual_input = d1.get('DP_DICT').get('IT', index).get('INPUT');
>     known_input = {gr1.get('SUB_DICT').get('IT', index).get('CON')};
> 
>     assert(isequal(individual_input, known_input), ...
>         [BRAPH2.STR ':NNDataPoint_CON_CLA:' BRAPH2.FAIL_TEST], ...
>         'NNDataPoint_CON_CLA does not construct the dataset correctly. The input value is not derived correctly.' ...
>         )
> end
> 
> for index = 1:1:gr2.get('SUB_DICT').get('LENGTH')
>     individual_input = d2.get('DP_DICT').get('IT', index).get('INPUT');
>     known_input = {gr2.get('SUB_DICT').get('IT', index).get('CON')};
> 
>     assert(isequal(individual_input, known_input), ...
>         [BRAPH2.STR ':NNDataPoint_CON_CLA:' BRAPH2.FAIL_TEST], ...
>         'NNDataPoint_CON_CLA does not construct the dataset correctly. The input value is not derived correctly.' ...
>         )
> end
> 
> %%% ¡test! 
> %%%% ¡name!
> Example training-test classification  ⑪
> %%%% ¡code!
> % ensure the example data is generated
> if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_CLA_CON_XLS() % create example files
> . . . . .
> 
> example_NN_CON_CLA
> ````
> 
> ⑥ imports two groups of simulated data.
> 
> ⑦ creates two datasets for the two groups.
> 
> ⑧ tests the number of inputs from the dataset matches the number of subjects in the group.
> 
> ⑨ tests the number of targets from the dataset matches the number of subjects in the group.
> 
> ⑩ tests the value of each input from the data point matches the subject's connectivity data.
> 
> ⑪ executes the corresponding example scripts to ensure the functionalities.
> 



<a id="Implementation-of-a-data-point-with-a-graph"></a>
## Implementation of a data point with a graph  [⬆](#Table-of-Contents)

<a id="Graph-data-point-for-regression-NNDataPointGraphREG"></a>
### Graph data point for regression (`NNDataPoint_Graph_REG`)  [⬆](#Table-of-Contents)

Now you will implement `NNDataPoint_Graph_REG` based on previous codes `NNDataPoint_CON_REG`.
This neural network data point with graphs utilizes the adjacency matrix extracted from the derived graph of the subject. 
The modified parts of the code are highlighted.


> **Code 9.** **NNDataPoint_Graph_REG element header.**
> 		The `header` section of the generator code in "_NNDataPoint_Graph_REG.gen.m" provides the general information about the `NNDataPoint_Graph_REG` element.
> ````matlab
> %% ¡header!
> NNDataPoint_Graph_REG < NNDataPoint (dp, measure regressioni data point) is a data point for regression with a graph.
> 
> %%% ¡description!
> A data point for regression with a graph (NNDataPoint_Graph_REG) 
>  contains both input and target for neural network analysis.
> The input is the value of the adjacency matrix extracted from the derived graph of the subject.
> The target is obtained from the variables of interest of the subject.
> 
> %%% ¡build!
> 1
> ````
> 


> **Code 10.** **NNDataPoint_Graph_REG element props update.**
> 		The `props_update` section of the generator code in "_NNDataPoint_Graph_REG.gen.m" updates the properties of the `NNDataPoint_Graph_REG` element. This defines the core properties of the data point.
> ````matlab
> %% ¡props_update!
> 
> %%% ¡prop!
> NAME (constant, string) is the name of a data point for regression with a graph.
> %%%% ¡default!
> 'NNDataPoint_Graph_REG'
> 
> %%% ¡prop!
> DESCRIPTION (constant, string) is the description of a data point for regression with a graph.
> %%%% ¡default!
> 'A data point for regression with a graph (NNDataPoint_Graph_REG) contains both input and target for neural network analysis. The input is the value of the adjacency matrix extracted from the derived graph of the subject. The target is obtained from the variables of interest of the subject.'
> 
> %%% ¡prop!
> TEMPLATE (parameter, item) is the template of a data point for regression with a graph.
> %%%% ¡settings!
> 'NNDataPoint_Graph_REG'
> 
> %%% ¡prop!
> ID (data, string) is a few-letter code for a data point for regression with a graph.
> %%%% ¡default!
> 'NNDataPoint_Graph_REG ID'
> 
> %%% ¡prop!
> LABEL (metadata, string) is an extended label of a data point for regression with a graph.
> %%%% ¡default!
> 'NNDataPoint_Graph_REG label'
> 
> %%% ¡prop!
> NOTES (metadata, string) are some specific notes about a data point for regression with a graph.
> %%%% ¡default!
> 'NNDataPoint_Graph_REG notes'
> 
> %%% ¡prop!
> INPUT (result, cell) is the input value for this data point.
> %%%% ¡calculate!
> value = dp.get('G').get('A');   ①
>     
> %%% ¡prop!
> TARGET (result, cell) is the target value for this data point.
> %%%% ¡calculate!
> value = cellfun(@(x) dp.get('SUB').get('VOI_DICT').get('IT', x).get('V'), dp.get('TARGET_IDS'), 'UniformOutput', false);
> ````
> 
> ① extracts the adjacency matrix from a `Graph` element as the input for this data point. Note that a `Graph` can be any kind of `Graph`, including `GraphWU`, `MultigraphBUD`, and `MultiplexBUT`, among others.
> 


> **Code 11.** **NNDataPoint_Graph_REG element props.**
> 		The `props` section of generator code in "_NNDataPoint_Graph_REG.gen.m" defines the properties to be used in "NNDataPoint_Graph_REG".
> ````matlab
> %% ¡props!
> 
> %%% ¡prop!   ①
> G (data, item) is a graph.
> %%%% ¡settings!
> 'Graph'
> 
> %%% ¡prop!
> SUB (data, item) is a subject.
> %%%% ¡settings!
> 'Subject'
> 
> %%% ¡prop!
> TARGET_IDS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.
> ````
> 
> ① defines the `Graph` element which contains its corresponding adjacency matrix.
> 




> **Code 12.** **NNDataPoint_Graph_REG element tests.**
> 		The `tests` section from the element generator "_NNDataPoint_Graph_REG.gen.m".
> 		A test for creating example files should be prepared to test the properties of the data point. Furthermore, additional test should be prepared for validating the value of input and target for the data point.
> ````matlab
> %% ¡tests!
> 
> %%% ¡excluded_props!
> [NNDataPoint_Graph_REG.G NNDataPoint_Graph_REG.SUB]
> 
> %%% ¡test!
> %%%% ¡name! ①
> Construct the data point with the adjacency matrix derived from its weighted undirected graph (GraphWU) 
> %%%% ¡code!
> % ensure the example data is generated
> if ~isfile([fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_REG_CON_XLS() % create example files
> end
> 
> % Load BrainAtlas
> 
> ...
> 
> % Analysis CON WU  ②
> a_WU = AnalyzeEnsemble_CON_WU( ...
>     'GR', gr ...
>     );
> 
> a_WU.memorize('G_DICT');  ③
> 
> % create item lists of NNDataPoint_Graph_REG ¥\circlednote{4}{ and \circled{5} creates the `NNDataPoint_Graph_REG` element and use the `Graph` from `G_DICT`.}¥
> it_list = cellfun(@(g, sub)   ④NNDataPoint_Graph_REG( ...
>     'ID', sub.get('ID'), ...
>     'G', g, ...
>     'SUB', sub, ...
>     'TARGET_IDS', sub.get('VOI_DICT').get('KEYS')), ...
>      ⑤a_WU.get('G_DICT').get('IT_LIST'), gr.get('SUB_DICT').get('IT_LIST'),...
>     'UniformOutput', false);
> 
> % create NNDataPoint_Graph_REG DICT items
> dp_list = IndexedDictionary(...
>         'IT_CLASS', 'NNDataPoint_Graph_REG', ...
>         'IT_LIST', it_list ...
>         );
> 
> % create a NNDataset containing the NNDataPoint_Graph_REG DICT
> d = NNDataset( ...
>     'DP_CLASS', 'NNDataPoint_Graph_REG', ...
>     'DP_DICT', dp_list ...
>     );
> 
> % Check whether the content of input for a single data point matches  ⑥
> for index = 1:1:gr.get('SUB_DICT').get('LENGTH')
>     individual_input = d.get('DP_DICT').get('IT', index).get('INPUT');
>     known_input = a_WU.get('G_DICT').get('IT', index).get('A');
> 
>     assert(isequal(individual_input, known_input), ...
>         [BRAPH2.STR ':NNDataPoint_Graph_REG:' BRAPH2.FAIL_TEST], ...
>         'NNDataPoint_Graph_REG does not construct the dataset correctly. The input value is not derived correctly.' ...
>         )
> end
> 
> %%% ¡test!
> %%%% ¡name! ⑦
> Construct the data point with the adjacency matrix derived from its binary undirected multigraph with fixed densities (MultigraphBUD)
> %%%% ¡code!
> % ensure the example data is generated
> if ~isfile([fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_REG_CON_XLS() % create example files
> end
> 
> % Load BrainAtlas
> 
> ...
> 
> % Analysis CON WU
> densities = 0:25:100;
> 
> a_BUD =  ⑧AnalyzeEnsemble_CON_BUD( ...
>     'DENSITIES', densities, ...
>     'GR', gr ...
>     );
> 
> a_BUD.memorize('G_DICT');
> 
> % create item lists of NNDataPoint_Graph_REG¥\circlednote{8}{-\circled{10} create the `NNDataPoint_Graph_REG` element and use the `Graph` from `AnalyzeEnsemble_CON_BUD`.}¥
> it_list = cellfun(@(g, sub)  ⑨ NNDataPoint_Graph_REG( ...
>     'ID', sub.get('ID'), ...
>     'G', g, ...
>     'SUB', sub, ...
>     'TARGET_IDS', sub.get('VOI_DICT').get('KEYS')), ...
>      ⑩a_BUD.get('G_DICT').get('IT_LIST'), gr.get('SUB_DICT').get('IT_LIST'),...
>     'UniformOutput', false);
> 
> % create NNDataPoint_Graph_REG DICT items
> dp_list = IndexedDictionary(...
>         'IT_CLASS', 'NNDataPoint_Graph_REG', ...
>         'IT_LIST', it_list ...
>         );
> 
> ...
> 
> %%% ¡test!
> %%%% ¡name!  ⑪
> Construct the data point with the adjacency matrix derived from its multiplex weighted undirected graph (MultiplexWU)
> %%%% ¡code!
> % ensure the example data is generated
> if ~isfile([fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP XLS' filesep 'atlas.xlsx'])
>     create_data_NN_REG_CON_FUN_MP_XLS() % create example files
> end
> 
> % Load BrainAtlas
> 
> ...
> 
> % Analysis CON FUN MP WU
> a_WU =  ⑫AnalyzeEnsemble_CON_FUN_MP_WU( ...
>     'GR', gr ...
>     );
> 
> a_WU.memorize('G_DICT');
> 
> % create item lists of NNDataPoint_Graph_REG¥\circlednote{12}{-\circled{14} creates the `NNDataPoint_Graph_REG` element and use the `Graph` from `AnalyzeEnsemble_CON_BUD`.}¥
> it_list = cellfun(@(g, sub)  ⑬NNDataPoint_Graph_REG( ...
>     'ID', sub.get('ID'), ...
>     'G', g, ...
>     'SUB', sub, ...
>     'TARGET_IDS', sub.get('VOI_DICT').get('KEYS')), ...
>      ⑭a_WU.get('G_DICT').get('IT_LIST'), gr.get('SUB_DICT').get('IT_LIST'),...
>     'UniformOutput', false);
> 
> % create NNDataPoint_Graph_REG DICT items
> dp_list = IndexedDictionary(...
>         'IT_CLASS', 'NNDataPoint_Graph_REG', ...
>         'IT_LIST', it_list ...
>         );
> 
> ...
> 
> %%% ¡test!
> %%%% ¡name!   ⑮
> Example script for binary undirected graph (MultigraphBUT) using connectivity data
> %%%% ¡code!
> if ~isfile([fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_REG_CON_XLS() % create example files
> end
> example_NNCV_CON_BUT_REG
> 
> %%% ¡test!
> %%%% ¡name!  ⑯
> Example script for binary undirected multiplex at fixed densities (MultiplexBUD) using connectivity data and functional data
> %%%% ¡code!
> if ~isfile([fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP XLS' filesep 'atlas.xlsx'])
>     create_data_NN_REG_CON_FUN_MP_XLS() % create example files
> end
> example_NNCV_CON_FUN_MP_BUD_REG
> 
> %%% ¡test!
> %%%% ¡name!  ⑰
> Example script for binary undirected multiplex at fixed thresholds (MultiplexBUT) using connectivity data and functional data
> %%%% ¡code!
> if ~isfile([fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP XLS' filesep 'atlas.xlsx'])
>     create_data_NN_REG_CON_FUN_MP_XLS % create example files
> end
> example_NNCV_CON_FUN_MP_BUT_REG
> ````
> 
> ① tests with the `GraphWU` element which contains weighted undirected adjacency matrix.
> 
> ② and ③ create the `AnalyzeEnsemble_CON_WU` element and then memorize its graph dictionary `G_DICT`.
> 
> ⑥ tests whether the value of each input from the data point matches the graph's adjacency matrix.
> 
> ⑦ tests with the `MultigraphBUD` element which contains the adjacency matrix of binary undirected graph at fixed densities.
> 
> ⑪ tests with the `MultiplexWU` element which contains the adjacency matrix of weighted undirected multipex.
> 
> ⑮ tests with the `MultigraphBUT` element with the simulated connectivity data.
> 
> ⑯ tests with the `MultiplexBUD` element with the simulated connectivity and functional data.
> 
> ⑰ tests with the `MultiplexBUT` element with the simulated connectivity and functional data.
> 



<a id="Graph-data-point-for-classification-NNDataPointGraphCLA"></a>
### Graph data point for classification (`NNDataPoint_Graph_CLA`)  [⬆](#Table-of-Contents)

Now we implement `NNDataPoint_Graph_CLA` based on previous codes `NNDataPoint_CON_CLA`.
This neural network data point with graphs utilizes the adjacency matrix extracted from the derived graph of the subject. 
The modified parts of the code are highlighted.


> **Code 13.** **NNDataPoint_Graph_CLA element header.**
> 		The `header` section of the generator code in "_NNDataPoint_Graph_CLA.gen.m" provides the general information about the `NNDataPoint_Graph_CLA` element.
> ````matlab
> %% ¡header!
> NNDataPoint_Graph_CLA < NNDataPoint (dp, graph classification data point) is a data point for classification with a graph.
> 
> %%% ¡description!
> A data point for classification with a graph (NNDataPoint_Graph_CLA) 
>  contains both input and target for neural network analysis.
> The input is the value of the adjacency matrix extracted from the derived graph of the subject.
> The target is obtained from the variables of interest of the subject.
> ````
> 



> **Code 14.** **NNDataPoint_Graph_CLA element props update.**
> 		The `props_update` section of the generator code in "_NNDataPoint_Graph_CLA.gen.m" updates the properties of the `NNDataPoint_Graph_CLA` element. This defines the core properties of the data point.
> ````matlab
> %% ¡props_update!
> 
> %%% ¡prop!
> NAME (constant, string) is the name of a data point for classification with a graph.
> %%%% ¡default!
> 'NNDataPoint_Graph_CLA'
> 
> %%% ¡prop!
> DESCRIPTION (constant, string) is the description of a data point for classification with a graph.
> %%%% ¡default!
> 'A data point for classification with a graph (NNDataPoint_Graph_CLA) contains both input and target for neural network analysis. The input is the value of the adjacency matrix extracted from the derived graph of the subject. The target is obtained from the variables of interest of the subject.'
> 
> %%% ¡prop!
> TEMPLATE (parameter, item) is the template of a data point for classification with a graph.
> %%%% ¡settings!
> 'NNDataPoint_Graph_CLA'
> 
> %%% ¡prop!
> ID (data, string) is a few-letter code for a data point for classification with a graph.
> %%%% ¡default!
> 'NNDataPoint_Graph_CLA ID'
> 
> %%% ¡prop!
> LABEL (metadata, string) is an extended label of a data point for classification with a graph.
> %%%% ¡default!
> 'NNDataPoint_Graph_CLA label'
> 
> %%% ¡prop!
> NOTES (metadata, string) are some specific notes about a data point for classification with a graph.
> %%%% ¡default!
> 'NNDataPoint_Graph_CLA notes'
> 
> %%% ¡prop!
> INPUT (result, cell) is the input value for this data point.
> %%%% ¡calculate!
> value = dp.get('G').get('A');   ①
>     
> %%% ¡prop!
> TARGET (result, cell) is the target value for this data point.
> %%%% ¡calculate!
> value = cellfun(@(c) sum(double(c)), dp.get('TARGET_CLASS'), 'UniformOutput', false);
> ````
> 
> ① extracts the adjacency matrix from a `Graph` element as the input for this data point. Note that a `Graph` can be any kind of `Graph`, including `GraphWU`, `MultigraphBUD`, and `MultiplexBUT`, among others.
> 


> **Code 15.** **NNDataPoint_Graph_CLA element props.**
> 		The `props` section of generator code in "_NNDataPoint_Graph_CLA.gen.m" defines the properties to be used in "NNDataPoint_Graph_CLA".
> ````matlab
> %% ¡props!
> 
> %%% ¡prop!   ①
> G (data, item) is a graph.
> %%%% ¡settings!
> 'Graph'
> 
> %%% ¡prop!
> TARGET_CLASS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.
> ````
> 
> ① defines the `Graph` element which contains its corresponding adjacency matrix.
> 




> **Code 16.** **NNDataPoint_Graph_CLA element tests.**
> 		The `tests` section from the element generator "_NNDataPoint_Graph_CLA.gen.m".
> 		A test for creating example files should be prepared to test the properties of the data point. Furthermore, additional test should be prepared for validating the value of input and target for the data point.
> ````matlab
> %% ¡tests!
> 
> %%% ¡excluded_props!
> [NNDataPoint_Graph_CLA.G]
> 
> %%% ¡test!
> %%%% ¡name!  ①
> Construct the data point with the adjacency matrix derived from its weighted undirected graph (GraphWU) 
> %%%% ¡code!
> % ensure the example data is generated
> if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_CLA_CON_XLS() % create example files
> end
> 
> % Load BrainAtlas
> 
> ...
> 
> % Analysis CON WU
> a_WU1 =  ②AnalyzeEnsemble_CON_WU( ...
>     'GR', gr1 ...
>     );
> 
> a_WU2 = AnalyzeEnsemble_CON_WU( ...
>     'TEMPLATE', a_WU1, ...
>     'GR', gr2 ...
>     );
> 
> a_WU1.memorize('G_DICT');
> a_WU2.memorize('G_DICT');
> 
> % create item lists of NNDataPoint_Graph_CLA ¥\circlednote{2}{-\circled{4} create `Analyzensemble_CON_WU` and use its `G_DICT` to initialize `NNDataPoint_Graph_CLA`.}¥
> [~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
> it_list1 = cellfun(@(x)  ③NNDataPoint_Graph_CLA( ...
>     'ID', x.get('ID'), ...
>     'G', x, ...
>     'TARGET_CLASS', {group_folder_name}), ...
>      ④a_WU1.get('G_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> [~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
> it_list2 = cellfun(@(x) NNDataPoint_Graph_CLA( ...
>     'ID', x.get('ID'), ...
>     'G', x, ...
>     'TARGET_CLASS', {group_folder_name}), ...
>     a_WU2.get('G_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> % create NNDataPoint_Graph_CLA DICT items
> 
> ...
> 
> %%% ¡test!
> %%%% ¡name!  ⑤
> Construct the data point with the adjacency matrix derived from its binary undirected multigraph with fixed densities (MultigraphBUD)
> %%%% ¡code!
> % ensure the example data is generated
> if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_CLA_CON_XLS() % create example files
> end
> 
> % Load BrainAtlas
> 
> ...
> 
> % Analysis CON WU
> densities = 0:25:100;
> 
> a_BUD1 =   ⑥AnalyzeEnsemble_CON_BUD( ...
>     'DENSITIES', densities, ...
>     'GR', gr1 ...
>     );
> 
> a_BUD2 = AnalyzeEnsemble_CON_BUD( ...
>     'TEMPLATE', a_BUD1, ...
>     'GR', gr2 ...
>     );
> 
> a_BUD1.memorize('G_DICT');
> a_BUD2.memorize('G_DICT');
> 
> % create item lists of NNDataPoint_Graph_CLA¥\circlednote{6}{-\circled{8} create `Analyzensemble_CON_BUD` and use its `G_DICT` to initialize `NNDataPoint_Graph_CLA`.}¥
> [~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
> it_list1 = cellfun(@(x)  ⑦NNDataPoint_Graph_CLA( ...
>     'ID', x.get('ID'), ...
>     'G', x, ...
>     'TARGET_CLASS', {group_folder_name}), ...
>      ⑧a_BUD1.get('G_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> [~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
> it_list2 = cellfun(@(x) NNDataPoint_Graph_CLA( ...
>     'ID', x.get('ID'), ...
>     'G', x, ...
>     'TARGET_CLASS', {group_folder_name}), ...
>     a_BUD2.get('G_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> % create NNDataPoint_Graph_CLA DICT items
> dp_list1 = IndexedDictionary(...
>         'IT_CLASS', 'NNDataPoint_Graph_CLA', ...
>         'IT_LIST', it_list1 ...
>         );
> 
> dp_list2 = IndexedDictionary(...
>         'IT_CLASS', 'NNDataPoint_Graph_CLA', ...
>         'IT_LIST', it_list2 ...
>         );
> 
> % create a NNDataset containing the NNDataPoint_Graph_CLA DICT
> 
> ...
> 
> %%% ¡test!
> %%%% ¡name!  ⑨
> Construct the data point with the adjacency matrix derived from its multiplex weighted undirected graph (MultiplexWU) 
> %%%% ¡code!
> % ensure the example data is generated
> if ~isfile([fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP XLS' filesep 'atlas.xlsx'])
>     create_data_NN_CLA_CON_FUN_MP_XLS() % create example files
> end
> 
> % Load BrainAtlas
> 
> ...
> 
> % Analysis CON FUN MP WU
> a_WU1 =  ⑩AnalyzeEnsemble_CON_FUN_MP_WU( ...
>     'GR', gr1 ...
>     );
> 
> a_WU2 = AnalyzeEnsemble_CON_FUN_MP_WU( ...
>     'TEMPLATE', a_WU1, ...
>     'GR', gr2 ...
>     );
> 
> a_WU1.memorize('G_DICT');
> a_WU2.memorize('G_DICT');
> 
> % create item lists of NNDataPoint_Graph_CLA ¥\circlednote{10}{-\circled{12} create `Analyzensemble_CON_FUN_MP_WU` and use its `G_DICT` to initialize `NNDataPoint_Graph_CLA`.}¥
> [~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
> it_list1 = cellfun(@(x)  ⑪NNDataPoint_Graph_CLA( ...
>     'ID', x.get('ID'), ...
>     'G', x, ...
>     'TARGET_CLASS', {group_folder_name}), ...
>      ⑫a_WU1.get('G_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> [~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
> it_list2 = cellfun(@(x) NNDataPoint_Graph_CLA( ...
>     'ID', x.get('ID'), ...
>     'G', x, ...
>     'TARGET_CLASS', {group_folder_name}), ...
>     a_WU2.get('G_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> % create NNDataPoint_Graph_CLA DICT items
> 
> ...
> 
> %%% ¡test!
> %%%% ¡name!  ⑬
> Example script for weighted undirected graph (GraphWU) using connectivity data
> %%%% ¡code!
> if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_CLA_CON_XLS() % create example files
> end
> example_NNCV_CON_WU_CLA
> 
> %%% ¡test!
> %%%% ¡name!  ⑭
> Example script for binary undirected graph at fixed densities (MultigraphBUD) using connectivity data
> %%%% ¡code!
> if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_CLA_CON_XLS() % create example files
> end
> example_NNCV_CON_BUD_CLA
> 
> %%% ¡test!
> %%%% ¡name!  ⑮
> Example script for weighted undirected multiplex (MultiplexWU) using connectivity data and functional data
> %%%% ¡code!
> if ~isfile([fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'atlas.xlsx'])
>     create_data_NN_CLA_CON_FUN_MP_XLS() % create example files
> end
> example_NNCV_CON_FUN_MP_WU_CLA
> ````
> 
> ① tests with the `GraphWU` element which contains weighted undirected adjacency matrix.
> 
> ⑤ tests with the `MultigraphBUD` element which contains binary undirected adjacency matrix at fixed densities.
> 
> ⑨ tests with the `MultiplexWU` element which contains weighted undirected adjacency matrix from multiplex graph.
> 
> ⑬ tests with the `GraphWU` element with simulated data.
> 
> ⑭ tests with the `MultigraphBUD` element with simulated data.
> 
> ⑮ tests with the `MultiplexWU` element with simulated data.
> 



<a id="Implementation-of-a-data-point-with-graph-measures"></a>
## Implementation of a data point with graph measures  [⬆](#Table-of-Contents)

<a id="Graph-measure-data-point-for-regression-NNDataPointMeasureREG"></a>
### Graph measure data point for regression (`NNDataPoint_Measure_REG`)  [⬆](#Table-of-Contents)

Now we implement `NNDataPoint_Measure_REG` based on previous codes `NNDataPoint_Graph_REG`.
This neural network data point utilizes graph measures obtrained from the adjacency matrix from the derived graph of the subject. 
The modified parts of the code are highlighted.


> **Code 17.** **NNDataPoint_Measure_REG element header.**
> 		The `header` section of the generator code in "_NNDataPoint_Measure_REG.gen.m" provides the general information about the `NNDataPoint_Measure_REG` element.
> ````matlab
> %% ¡header!
> NNDataPoint_Measure_REG < NNDataPoint (dp, measure regression data point) is a data point for regression with graph measures.
> 
> %%% ¡description!
> A data point for regression with graph measures (NNDataPoint_Measure_REG) 
>  contains both input and target for neural network analysis.
> The input is the value of the graph measures (e.g. Degree, DegreeAv, and Distance), 
>  calculated from the derived graph of the subject.
> The target is obtained from the variables of interest of the subject.
> ````
> 



> **Code 18.** **NNDataPoint_Measure_REG element props update.**
> 		The `props_update` section of the generator code in "_NNDataPoint_Measure_REG.gen.m" updates the properties of the `NNDataPoint_Measure_REG` element. This defines the core properties of the data point.
> ````matlab
> %% ¡props_update!
> 
> %%% ¡prop!
> NAME (constant, string) is the name of a data point for regression with graph measures.
> %%%% ¡default!
> 'NNDataPoint_Measure_REG'
> 
> %%% ¡prop!
> DESCRIPTION (constant, string) is the description of a data point for regression with graph measures.
> %%%% ¡default!
> 'A data point for regression with graph measures (NNDataPoint_Measure_REG) contains both input and target for neural network analysis. The input is the value of the graph measures (e.g. Degree, DegreeAv, and Distance), calculated from the derived graph of the subject. The target is obtained from the variables of interest of the subject.'
> 
> %%% ¡prop!
> TEMPLATE (parameter, item) is the template of a data point for regression with graph measures.
> %%%% ¡settings!
> 'NNDataPoint_Measure_REG'
> 
> %%% ¡prop!
> ID (data, string) is a few-letter code for a data point for regression with graph measures.
> %%%% ¡default!
> 'NNDataPoint_Measure_REG ID'
> 
> %%% ¡prop!
> LABEL (metadata, string) is an extended label of a data point for regression with graph measures.
> %%%% ¡default!
> 'NNDataPoint_Measure_REG label'
> 
> %%% ¡prop!
> NOTES (metadata, string) are some specific notes about a data point for regression with graph measures.
> %%%% ¡default!
> 'NNDataPoint_Measure_REG notes'
> 
> %%% ¡prop!
> INPUT (result, cell) is the input value for this data point.
> %%%% ¡calculate! 
> value = cellfun(@(m_class) dp.get('G').get('MEASURE', m_class).get('M'), dp.get('M_LIST'), 'UniformOutput', false);   ①
>     
> %%% ¡prop!
> TARGET (result, cell) is the target value for this data point.
> %%%% ¡calculate!
> value = cellfun(@(x) dp.get('SUB').get('VOI_DICT').get('IT', x).get('V'), dp.get('TARGET_IDS'), 'UniformOutput', false);
> ````
> 
> ① calculates the graph measures, specified with `M_LIST`, from a `Graph` element for this data point. Note that a `Graph` can be any kind of `Graph`, including `GraphWU`, `MultigraphBUD`, and `MultiplexBUT`, among others.
> 


> **Code 19.** **NNDataPoint_Measure_REG element props.**
> 		The `props` section of generator code in "_NNDataPoint_Measure_REG.gen.m" defines the properties to be used in "NNDataPoint_Measure_REG".
> ````matlab
> %% ¡props!
> 
> %%% ¡prop!  
> G (data, item) is a graph.
> %%%% ¡settings!
> 'Graph'
> 
> %%% ¡prop!  ①
> M_LIST (parameter, classlist) is a list of graph measure to be used as the input
> 
> %%% ¡prop!
> SUB (data, item) is a subject.
> %%%% ¡settings!
> 'Subject'
> 
> %%% ¡prop!
> TARGET_IDS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.
> ````
> 
> ① defines the graph measure list which will be obtained as `INPUT` for this data point.
> 




> **Code 20.** **NNDataPoint_Measure_REG element tests.**
> 		The `tests` section from the element generator "_NNDataPoint_Measure_REG.gen.m".
> 		A test for creating example files should be prepared to test the properties of the data point. Furthermore, additional test should be prepared for validating the value of input and target for the data point.
> ````matlab
> %% ¡tests!
> 
> %%% ¡excluded_props!
> [NNDataPoint_Measure_REG.G NNDataPoint_Measure_REG.SUB]
> 
> %%% ¡test!
> %%%% ¡name! 
> Construct the data point with the adjacency matrix derived from its weighted undirected graph (GraphWU) 
> %%%% ¡code!
> % ensure the example data is generated
> if ~isfile([fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_REG_CON_XLS() % create example files
> end
> 
> % Load BrainAtlas
> 
> ...
> 
> % Analysis CON WU
> a_WU =  ①AnalyzeEnsemble_CON_WU( ...
>     'GR', gr ...
>     );
> 
> a_WU.get('MEASUREENSEMBLE', 'Degree').get('M');   ②
> a_WU.get('MEASUREENSEMBLE', 'DegreeAv').get('M');  ③
> a_WU.get('MEASUREENSEMBLE', 'Distance').get('M');  ④
> ¥\circlednote{1}{-\circled{4} create a `AnalyzeEnsemble_CON_WU` and add various kinds of graph measure with the `GraphWU` element which contains weighted undirected adjacency matrix.}¥
> % create item lists of NNDataPoint_Measure_REG
> it_list = cellfun(@(g, sub)   ⑤NNDataPoint_Measure_REG( ...
>     'ID', sub.get('ID'), ...
>     'G', g, ...
>     'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
>     'SUB', sub, ...
>     'TARGET_IDS', sub.get('VOI_DICT').get('KEYS')), ...
>       ⑥a_WU.get('G_DICT').get('IT_LIST'), gr.get('SUB_DICT').get('IT_LIST'),...
>     'UniformOutput', false);
> ¥\circlednote{5}{ and \circled{6} use `AnalyzeEnsemble_CON_WU`'s `G_DICT` to set up a `NNDataPoint_Measure_REG`.}¥
> % create NNDataPoint_Measure_REG DICT items
> dp_list = IndexedDictionary(...
>         'IT_CLASS', 'NNDataPoint_Measure_REG', ...
>         'IT_LIST', it_list ...
>         );
> 
> ...
> 
> %%% ¡test!
> %%%% ¡name!  ⑦
> Construct the data point with the adjacency matrix derived from its binary undirected multigraph with fixed densities (MultigraphBUD)
> %%%% ¡code!
> % ensure the example data is generated
> if ~isfile([fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_REG_CON_XLS() % create example files
> end
> 
> % Load BrainAtlas
> 
> ...
> 
> % Analysis CON WU
> densities = 0:25:100;
> 
> a_BUD =  ⑧AnalyzeEnsemble_CON_BUD( ...
>     'DENSITIES', densities, ...
>     'GR', gr ...
>     );
> 
> a_BUD.get('MEASUREENSEMBLE', 'Degree').get('M');
> a_BUD.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
> a_BUD.get('MEASUREENSEMBLE', 'Distance').get('M');
> 
> % create item lists of NNDataPoint_Measure_REG
> it_list = cellfun(@(g, sub)  ⑨NNDataPoint_Measure_REG( ...
>     'ID', sub.get('ID'), ...
>     'G', g, ...
>     'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
>     'SUB', sub, ...
>     'TARGET_IDS', sub.get('VOI_DICT').get('KEYS')), ...
>      ⑩a_BUD.get('G_DICT').get('IT_LIST'), gr.get('SUB_DICT').get('IT_LIST'),...
>     'UniformOutput', false);
> 
> % create NNDataPoint_CON_CLA DICT items
> dp_list = IndexedDictionary(...
>         'IT_CLASS', 'NNDataPoint_Measure_REG', ...
>         'IT_LIST', it_list ...
>         );
> 
> ...
> 
> %%% ¡test!
> %%%% ¡name!  ⑪
> Construct the data point with the adjacency matrix derived from its multiplex weighted undirected graph (MultiplexWU) 
> %%%% ¡code!
> % ensure the example data is generated
> if ~isfile([fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP XLS' filesep 'atlas.xlsx'])
>     create_data_NN_REG_CON_FUN_MP_XLS() % create example files
> end
> 
> % Load BrainAtlas
> 
> ...
> 
> % Analysis CON FUN MP WU
> a_WU =  ⑫AnalyzeEnsemble_CON_FUN_MP_WU( ...
>     'GR', gr ...
>     );
> 
> % To be added the multiplex measures
> a_WU.get('MEASUREENSEMBLE', 'Degree').get('M');
> a_WU.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
> a_WU.get('MEASUREENSEMBLE', 'Distance').get('M');
> 
> % create item lists of NNDataPoint_Measure_REG
> it_list = cellfun(@(g, sub)  ⑬NNDataPoint_Measure_REG( ...
>     'ID', sub.get('ID'), ...
>     'G', g, ...
>     'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
>     'SUB', sub, ...
>     'TARGET_IDS', sub.get('VOI_DICT').get('KEYS')), ...
>      ⑭a_WU.get('G_DICT').get('IT_LIST'), gr.get('SUB_DICT').get('IT_LIST'),...
>     'UniformOutput', false);
> 
> % create NNDataPoint_Measure_REG DICT items
> 
> ...
> 
> %%% ¡test!
> %%%% ¡name!  ⑮
> Example script for weighted undirected graph (GraphWU) using connectivity data
> %%%% ¡code!
> if ~isfile([fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_REG_CON_XLS() % create example files
> end
> example_NNCV_CON_WU_M_REG
> 
> %%% ¡test!
> %%%% ¡name!  ⑯
> Example script for weighted undirected multiplex (MultiplexWU) using connectivity data and functional data
> %%%% ¡code!
> if ~isfile([fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP XLS' filesep 'atlas.xlsx'])
>     create_data_NN_REG_CON_FUN_MP_XLS() % create example files
> end
> example_NNCV_CON_FUN_MP_WU_M_REG
> ````
> 
> ⑦-⑩ tests various kinds of graph measure with the `MultigraphBUD`.
> 
> ⑪-⑭ tests various kinds of graph measure with the `MultiplexWU`.
> 
> ⑮ tests various kinds of graph measure with the `GraphWU` using example data.
> 
> ⑯ tests various kinds of graph measure with the `MultiplexWU` using example data.
> 



<a id="Graph-measure-data-point-for-classification-NNDataPointMeasureCLA"></a>
### Graph measure data point for classification (`NNDataPoint_Measure_CLA`)  [⬆](#Table-of-Contents)

Now we implement `NNDataPoint_Measure_CLA` based on previous codes `NNDataPoint_Graph_CLA`.
This neural network data point utilizes graph measures obtrained from the adjacency matrix from the derived graph of the subject. 
The modified parts of the code are highlighted.


> **Code 21.** **NNDataPoint_Measure_CLA element header.**
> 		The `header` section of the generator code in "_NNDataPoint_Measure_CLA.gen.m" provides the general information about the `NNDataPoint_Measure_CLA` element.
> ````matlab
> %% ¡header!
> NNDataPoint_Measure_CLA < NNDataPoint (dp, measure classification data point) is a data point for classification with graph measures.
> 
> %%% ¡description!
> A data point for classification with graph measures (NNDataPoint_Measure_CLA) 
>  contains both input and target for neural network analysis.
> The input is the value of the graph measures (e.g. Degree, DegreeAv, and Distance), 
>  calculated from the derived graph of the subject.
> The target is obtained from the variables of interest of the subject.
> ````
> 


> **Code 22.** **NNDataPoint_Measure_CLA element props update.**
> 		The `props_update` section of the generator code in "_NNDataPoint_Measure_CLA.gen.m" updates the properties of the `NNDataPoint_Measure_CLA` element. This defines the core properties of the data point.
> ````matlab
> %% ¡props_update!
> 
> %%% ¡prop!
> NAME (constant, string) is the name of a data point for classification with graph measures.
> %%%% ¡default!
> 'NNDataPoint_Measure_CLA'
> 
> %%% ¡prop!
> DESCRIPTION (constant, string) is the description of a data point for classification with graph measures.
> %%%% ¡default!
> 'A data point for classification with graph measures (NNDataPoint_Measure_CLA) contains both input and target for neural network analysis. The input is the value of the graph measures (e.g. Degree, DegreeAv, and Distance), calculated from the derived graph of the subject. The target is obtained from the variables of interest of the subject.'
> 
> %%% ¡prop!
> TEMPLATE (parameter, item) is the template of a data point for classification with graph measures.
> %%%% ¡settings!
> 'NNDataPoint_Measure_CLA'
> 
> %%% ¡prop!
> ID (data, string) is a few-letter code for a data point for classification with graph measures.
> %%%% ¡default!
> 'NNDataPoint_Measure_CLA ID'
> 
> %%% ¡prop!
> LABEL (metadata, string) is an extended label of a data point for classification with graph measures.
> %%%% ¡default!
> 'NNDataPoint_Measure_CLA label'
> 
> %%% ¡prop!
> NOTES (metadata, string) are some specific notes about a data point for classification with graph measures.
> %%%% ¡default!
> 'NNDataPoint_Measure_CLA notes'
> 
> %%% ¡prop!
> INPUT (result, cell) is the input value for this data point.
> %%%% ¡calculate! 
> value = cellfun(@(m_class) dp.get('G').get('MEASURE', m_class).get('M'), dp.get('M_LIST'), 'UniformOutput', false);   ①
>     
> %%% ¡prop!
> TARGET (result, cell) is the target value for this data point.
> %%%% ¡calculate!
> value = cellfun(@(c) sum(double(c)), dp.get('TARGET_CLASS'), 'UniformOutput', false);
> ````
> 
> ① calculates or extract the graph measures, which are specified with `M_LIST` from a `Graph` element for this data point. Note that a `Graph` can be any kind of `Graph`, including `GraphWU`, `MultigraphBUD`, and `MultiplexBUT`, among others.
> 


> **Code 23.** **NNDataPoint_Measure_CLA element props.**
> 		The `props` section of generator code in "_NNDataPoint_Measure_CLA.gen.m" defines the properties to be used in "NNDataPoint_Measure_CLA".
> ````matlab
> %% ¡props!
> 
> %%% ¡prop!  
> G (data, item) is a graph.
> %%%% ¡settings!
> 'Graph'
> 
> %%% ¡prop!  ①
> M_LIST (parameter, classlist) is a list of graph measure to be used as the input
> 
> %%% ¡prop!
> TARGET_CLASS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.
> ````
> 
> ① defines the graph measure list which will be obtained as `INPUT` for this data point.
> 




> **Code 24.** **NNDataPoint_Measure_CLA element tests.**
> 		The `tests` section from the element generator "_NNDataPoint_Measure_CLA.gen.m".
> 		A test for creating example files should be prepared to test the properties of the data point. Furthermore, additional test should be prepared for validating the value of input and target for the data point.
> ````matlab
> %% ¡tests!
> 
> %%% ¡excluded_props!
> [NNDataPoint_Measure_CLA.G]
> 
> %%% ¡test!
> %%%% ¡name! 
> Construct the data point with the graph measures derived from its weighted undirected graph (GraphWU) 
> %%%% ¡code!
> % ensure the example data is generated
> if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_CLA_CON_XLS() % create example files
> end
> 
> % Load BrainAtlas
> 
> ...
> 
> % Analysis CON WU
> a_WU1 =  ①AnalyzeEnsemble_CON_WU( ...
>     'GR', gr1 ...
>     );
> 
> a_WU2 = AnalyzeEnsemble_CON_WU( ...
>     'TEMPLATE', a_WU1, ...
>     'GR', gr2 ...
>     );
> 
> a_WU1.get('MEASUREENSEMBLE', 'Degree').get('M');   ②
> a_WU1.get('MEASUREENSEMBLE', 'DegreeAv').get('M');  ③ 
> a_WU1.get('MEASUREENSEMBLE', 'Distance').get('M');  ④
> ¥\circlednote{1}{-\circled{4} create a `AnalyzeEnsemble_CON_WU` and add various kinds of graph measure with the `GraphWU` element which contains weighted undirected adjacency matrix.}¥
> a_WU2.get('MEASUREENSEMBLE', 'Degree').get('M');
> a_WU2.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
> a_WU2.get('MEASUREENSEMBLE', 'Distance').get('M');
> ¥\circlednote{5}{ and \circled{6} use `AnalyzeEnsemble_CON_WU`'s `G_DICT` to set up a `NNDataPoint_Measure_CLA`.}¥
> % create item lists of NNDataPoint_Measure_CLA
> [~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
> it_list1 = cellfun(@(x)  ⑤NNDataPoint_Measure_CLA( ...
>     'ID', x.get('ID'), ...
>     'G', x, ...
>     'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
>     'TARGET_CLASS', {group_folder_name}), ...
>      ⑥a_WU1.get('G_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> % create NNDataPoint_Measure_CLA DICT items
> 
> ...
> 
> %%% ¡test!
> %%%% ¡name!   ⑦
> Construct the data point with the graph measures derived from its binary undirected multigraph with fixed densities (MultigraphBUD)
> %%%% ¡code!
> % ensure the example data is generated
> if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_CLA_CON_XLS() % create example files
> end
> 
> % Load BrainAtlas
> 
> ...
> 
> % Analysis CON WU
> densities = 0:25:100;
> 
> a_BUD1 =  ⑧AnalyzeEnsemble_CON_BUD( ...
>     'DENSITIES', densities, ...
>     'GR', gr1 ...
>     );
> 
> a_BUD2 = AnalyzeEnsemble_CON_BUD( ...
>     'TEMPLATE', a_BUD1, ...
>     'GR', gr2 ...
>     );
> 
> a_BUD1.get('MEASUREENSEMBLE', 'Degree').get('M');  ⑨
> a_BUD1.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
> a_BUD1.get('MEASUREENSEMBLE', 'Distance').get('M');
> 
> a_BUD2.get('MEASUREENSEMBLE', 'Degree').get('M');
> a_BUD2.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
> a_BUD2.get('MEASUREENSEMBLE', 'Distance').get('M');
> 
> % create item lists of NNDataPoint_Measure_CLA
> [~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
> it_list1 = cellfun(@(x)  ⑩NNDataPoint_Measure_CLA( ...
>     'ID', x.get('ID'), ...
>     'G', x, ...
>     'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
>     'TARGET_CLASS', {group_folder_name}), ...
>     a_BUD1.get('G_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> [~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
> it_list2 = cellfun(@(x) NNDataPoint_Measure_CLA( ...
>     'ID', x.get('ID'), ...
>     'G', x, ...
>     'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
>     'TARGET_CLASS', {group_folder_name}), ...
>     a_BUD2.get('G_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> % create NNDataPoint_Measure_CLA items
> dp_list1 = IndexedDictionary(...
>         'IT_CLASS', 'NNDataPoint_Measure_CLA', ...
>         'IT_LIST', it_list1 ...
>         );
> 
> ...
> 
> %%% ¡test!
> %%%% ¡name!   ⑪
> Construct the data point with the graph measures derived from its multiplex weighted undirected graph (MultiplexWU) 
> %%%% ¡code!
> % ensure the example data is generated
> if ~isfile([fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP XLS' filesep 'atlas.xlsx'])
>     create_data_NN_CLA_CON_FUN_MP_XLS() % create example files
> end
> 
> % Load BrainAtlas
> 
> ...
> 
> % Analysis CON FUN MP WU
> a_WU1 =   ⑫AnalyzeEnsemble_CON_FUN_MP_WU( ...
>     'GR', gr1 ...
>     );
> 
> a_WU2 = AnalyzeEnsemble_CON_FUN_MP_WU( ...
>     'TEMPLATE', a_WU1, ...
>     'GR', gr2 ...
>     );
> 
> % To be added the multiplex measures
> a_WU1.get('MEASUREENSEMBLE', 'Degree').get('M');  ⑬
> a_WU1.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
> a_WU1.get('MEASUREENSEMBLE', 'Distance').get('M');
> 
> a_WU2.get('MEASUREENSEMBLE', 'Degree').get('M');
> a_WU2.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
> a_WU2.get('MEASUREENSEMBLE', 'Distance').get('M');
> 
> % create item lists of NNDataPoint_Graph_CLA
> [~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
> it_list1 = cellfun(@(x)  ⑭NNDataPoint_Measure_CLA( ...
>     'ID', x.get('ID'), ...
>     'G', x, ...
>     'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
>     'TARGET_CLASS', {group_folder_name}), ...
>     a_WU1.get('G_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> [~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
> it_list2 = cellfun(@(x) NNDataPoint_Measure_CLA( ...
>     'ID', x.get('ID'), ...
>     'G', x, ...
>     'M_LIST', {'Degree' 'DegreeAv' 'Distance'}, ...
>     'TARGET_CLASS', {group_folder_name}), ...
>     a_WU2.get('G_DICT').get('IT_LIST'), ...
>     'UniformOutput', false);
> 
> % create NNDataPoint_Measure_CLA DICT items
> dp_list1 = IndexedDictionary(...
>         'IT_CLASS', 'NNDataPoint_Measure_CLA', ...
>         'IT_LIST', it_list1 ...
>         );
> 
> ...
> 
> %%% ¡test!
> %%%% ¡name!  ⑮
> Example script for binary undirected graph at fixed densities (GraphBUD) using connectivity data
> %%%% ¡code!
> if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_CLA_CON_XLS() % create example files
> end
> example_NNCV_CON_BUD_M_CLA
> 
> %%% ¡test!
> %%%% ¡name!  ⑯
> Example script for binary undirected graph at fixed thresholds (MultigraphBUT) using connectivity data
> %%%% ¡code!
> if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_CLA_CON_XLS() % create example files
> end
> example_NNCV_CON_BUT_M_CLA
> 
> %%% ¡test!
> %%%% ¡name!  ⑰
> Example script for binary undirected graph at fixed densities (MultigraphBUD) using connectivity data
> %%%% ¡code!
> if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
>     create_data_NN_CLA_CON_XLS() % create example files
> end
> example_NNCV_CON_BUD_M_CLA
> 
> %%% ¡test!
> %%%% ¡name!  ⑱
> Example script for binary undirected multiplex at fixed densities (MultiplexBUD) using connectivity data and functional data
> %%%% ¡code!
> if ~isfile([fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'atlas.xlsx'])
>     create_data_NN_CLA_CON_FUN_MP_XLS() % create example files
> end
> example_NNCV_CON_FUN_MP_BUD_M_CLA
> 
> %%% ¡test!
> %%%% ¡name!  ⑲
> Example script for binary undirected multiplex at fixed thresholds (MultiplexBUT) using connectivity data and functional data
> %%%% ¡code!
> if ~isfile([fileparts(which('NNDataPoint_CON_FUN_MP_CLA')) filesep 'Example data NN CLA CON_FUN_MP XLS' filesep 'atlas.xlsx'])
>     create_data_NN_CLA_CON_FUN_MP_XLS % create example files
> end
> example_NNCV_CON_FUN_MP_BUT_M_CLA
> ````
> 
> ⑦-⑩ tests various kinds of graph measure with the `MultigraphBUD`.
> 
> ⑪-⑭ tests various kinds of graph measure with the `MultigraphBUD`.
> 
> ⑮ tests various kinds of graph measure with the `MultigraphBUD` using example connectivity data.
> 
> ⑯ tests various kinds of graph measure with the `MultigraphBUT` using example data.
> 
> ⑰ tests various kinds of graph measure with the `MultigraphBUD` using example connectivity data.
> 
> ⑱ tests various kinds of graph measure with the `MultiplexBUD` using example functional data.
> 
> ⑲ tests various kinds of graph measure with the `MultiplexBUT` using example functional data.
>
