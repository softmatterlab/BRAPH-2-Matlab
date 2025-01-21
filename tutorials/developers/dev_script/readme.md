# Adapt an Example Script

[![Tutorial Adapt an Example Script](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](dev_script.pdf)

This is the developer tutorial for adapting a script to calculate different graph measures. In this tutorial, you will learn how to edit an example script to calculate different graph measures. Here, you will use the scrip in file "example_ST_MP_WU.m" as an example to learn how to edit this script to calculate different graph measures for structural data using a multiplex weighted undirected graph.


## Table of Contents
> [Header](#Header)
>
> [Atlas Loading](#Atlas-Loading)
>
> [Data Loading](#Data-Loading)
>
> [Group Analysis](#Group-Analysis)
>
> [Measure Calculation](#Measure-Calculation)
>
> [Group Comparison](#Group-Comparison)
>



<a id="Header"></a>
## Header  [⬆](#Table-of-Contents)

The header section of the script in "example_ST_MP_WU.m" is shown in Code 1.


> **Code 1.** **Script header.**
> 		The header section of the pipeline names and describes the script.
> ````matlab
> % EXAMPLE_ST_MP_WU  ①
> % Script example pipeline ST MP WU  ②
> 
> clear variables %#ok<*NASGU>  ③
> ````
> 
> ① defines the name of the script.
> 
> ② provides a brief description of the script.
> 
> ③ clears the workspace.
> 

<a id="Atlas-Loading"></a>
## Atlas Loading  [⬆](#Table-of-Contents)

The script starts by importing the brain atlas. For this, it uses the element `ImporterBrainAtlasXLS` to import the atlas from an "*.xlsx" file, as shown in Code 2.
 

> **Code 2.** **Load brain atlas.**
> 		This section defines the importer to load the brain atlas.
> ````matlab
> %% Load BrainAtlas
> im_ba = ImporterBrainAtlasXLS( ...
>     'FILE', [fileparts(which('example_ST_MP_WU')) filesep 'Example data ST_MP XLS' filesep 'atlas.xlsx'], ...  ①
>     'WAITBAR', true ...  ②
>     );
> 
> ba = im_ba.get('BA');
> ````
> 
> ① loads the brain atlas from the file "atlas.xlsx".
> 
> ② shows a waitbar during the loading process.
> 

<a id="Data-Loading"></a>
## Data Loading  [⬆](#Table-of-Contents)

The next step is to load the data of the two groups from the folders where the relative "*.xlsx" files are stored. It uses the element `ImporterGroupSubjectST_MP_XLS` to load the `SubjectST_MP` subjects, as shown in Code 3.


> **Code 3.** **Load groups of subjects.**
> 		The group data importer section provides the code for loading the data corresponding to the groups of subjects.
> ````matlab
> %% Load Groups of SubjectST_MP
> im_gr1 = ImporterGroupSubjectST_MP_XLS( ...
>     'DIRECTORY', [fileparts(which('SubjectST_MP')) filesep 'Example data ST_MP XLS' filesep 'ST_MP_Group_1_XLS'], ...  ①
>     'BA', ba, ...  ②
>     'WAITBAR', true ...  ③
>     );
> 
> gr1 = im_gr1.get('GR');
> 
> im_gr2 = ImporterGroupSubjectST_MP_XLS( ...
>     'DIRECTORY', [fileparts(which('SubjectST_MP')) filesep 'Example data ST_MP XLS' filesep 'ST_MP_Group_2_XLS'], ...  ④
>     'BA', ba, ...
>     'WAITBAR', true ...
>     );
> 
> gr2 = im_gr2.get('GR');
> ````
> 
> ① imports the first group of subjects with structural data and their (optional) covariates from the files contained in the folder.
> 
> ② uses the previously loaded brain atlas.
> 
> ③ shows a waitbar during the loading process.
> 
> ④ imports the first group of subjects.
> 

<a id="Group-Analysis"></a>
## Group Analysis  [⬆](#Table-of-Contents)

The next step is to perform the group data analysis using the element ``, as shown in Code 4.


> **Code 4.** **Analysis.**
> 		The group data analysis sections provides code to perform the analyses for the two groups.
> ````matlab
> %% Analysis ST MP WU
> a_WU1 = AnalyzeGroup_ST_MP_WU( ...
>     'GR', gr1, ...  ①
>     'CORRELATION_RULE', Correlation.PEARSON ...  ②
>     );
> 
> a_WU2 = AnalyzeGroup_ST_MP_WU( ...
>     'TEMPLATE', a_WU1, ...  ③
>     'GR', gr2 ...  ④
>     );
> ````
> 
> ① uses the previously defined group `gr1` for the first analysis.
> 
> ② defines the correlation rule to be used.
> 
> ③ uses the same parameters as in the analysis `a_WU1`.
> 
> ④ uses the previously defined group `gr2` for the second analysis.
> 

<a id="Measure-Calculation"></a>
## Measure Calculation  [⬆](#Table-of-Contents)

You can now calculate graph measures with the analyses defined in the previous step, as shown in Code 5.


> **Code 5.** **Within-group measure calculation.**
> 		The measure calculation section calculates the measures for each group independently.
> ````matlab
> % measure calculation
> g_WU1 = a_WU1.memorize('G');  ①
> ovstrength_WU2 = g_WU2.get('MEASURE', 'OverlappingS').get('M');  ②
> ovstrength_av_WU2 = g_WU2.get('MEASURE', 'OverlappingSAv').get('M');  ③
> 
> g_WU2 = a_WU2.get('G');  ④
> ovstrength_WU2 = g_WU2.get('MEASURE', 'OverlappingS').get('M');
> ovstrength_av_WU2 = g_WU2.get('MEASURE', 'OverlappingSAv').get('M');
> ````
> 
> ① memorizes the graphs to ensure consistency if there are measures with non-default rules.
> 
> ② calculates the *overlapping strength* measure for the analysis `a_WU1`.
> 
> ③ calculates the *overlapping strength average* measure for the analysis `a_WU1`.
> 
> ④ calculates the same measures for the analysis `a_WU2`.
> 

<a id="Group-Comparison"></a>
## Group Comparison  [⬆](#Table-of-Contents)

The last step is to perform the group comparison. This uses the element `CompareGroup` as shown in Code 6.

Specifically, it contains the one-tailed and two-tailed p-values and the 95\% confidence interval.


> **Code 6.** **Between-group measure comparison.**
> 		The comparison section performs the comparison of the measures between the two groups.
> ````matlab
> % comparison
> c_WU = CompareGroup( ...
>     'P', 1000, ...  ①
>     'A1', a_WU1, ...  ②
>     'A2', a_WU2, ...  ③
>     'WAITBAR', true, ...  ④
>     'VERBOSE', false, ...  ⑤
>     'MEMORIZE', true ...  ⑥
>     );
> 
> ovstrength_WU_diff = c_WU.get('COMPARISON', 'OverlappingS').get('DIFF');  ⑦
> ovstrength_WU_p1 = c_WU.get('COMPARISON', 'OverlappingS').get('P1');  ⑧
> ovstrength_WU_p2 = c_WU.get('COMPARISON', 'OverlappingS').get('P2');  ⑨
> ovstrength_WU_cil = c_WU.get('COMPARISON', 'OverlappingS').get('CIL');  ⑩
> ovstrength_WU_ciu = c_WU.get('COMPARISON', 'OverlappingS').get('CIU');  ⑪
> ````
> 
> ① uses 1000 permutations in the false-discovery-rate (FDR) test.
> 
> ② and ③ define the two analyses to be compared.
> 
> ④ shows a waitbar during the comparison.
> 
> ⑤ does not print updates during the comparison.
> 
> ⑥ memorizes the intermediate results of the comparison. This speeds up the comparison at the cost of estra memory requirements.
> 
> ⑦-⑪ calculate the difference of group comparison (`'DIFF'`), the one-tailed p-value (`'P1'`), the two-tailed p-value (`'P2'`), the lower value of the 95\% confidence interval (`'CIL'`), and the upper value of the 95\% confidence interval (`'CIU'`) for the overlapping strength measure (`'OverlappingS'`).
>
