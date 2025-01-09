# Adapt a Pipeline Script

[![Tutorial Adapt a Pipeline Script](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](dev_pipeline.pdf)

This is the developer tutorial for adapting a pipeline script. 
In this tutorial, you will learn how to edit a "*.braph2" file to change the steps of a pipeline. Here, you will use as an example the pipeline `Pipeline Structural Multiplex Comparison BUD` in the file "pipeline_structural_multiplex_comparison_bud.braph2" (the pipeline for comparing two groups of subjects using structural multiplex data and binary undirected graphs at fixed densities) and adapt it in order to add a third group for structural multiplex.


## Table of Contents
> [Adaption of the pipeline](#Adaption-of-the-pipeline)
>



<a id="Adaption-of-the-pipeline"></a>
## Adaption of the pipeline  [⬆](#Table-of-Contents)

You will adapt in `Pipeline Structural Multiplex Comparison BUD` in the file "pipeline_structural_multiplex_comparison_bud.braph2" as shown in Code 1. The changes are highlighted in the comments.


> **Code 1.** Adapted pipeline to compare three groups of subjects using structural multiplex data and binary undirected graphs at fixed densities.
> ````matlab
> %% Pipeline Structural Multiplex Comparison BUD  ①
> 
> % This is the pipeline script to compare two groups of subjects using structural multiplex data and binary undirected graphs at fixed densities.  ②
> % 1. It loads a brain atlas from an XLS file (e.g., desikan_atlas.xlsx).
> % 2. It loads the data of two groups of subjects from two directories (e.g., ST_MP_group_1_XLS and ST_MP_group_2_XLS).
> % 3. It analyzes the first group using structural multiplex analyses (ST_MP) based on binary unidrected graphs at fixed densities (BUD).
> % 4. It analyzes the second group using the same parameters selected for the first group.
> % 5. It compares the results of the two analyses.
> 
> % PDF: /tutorials/pipelines/tut_a_mp_st_bud/tut_a_mp_st_bud.pdf
> % README: /tutorials/pipelines/tut_a_mp_st_bud/readme.md
> 
> %% Brain Atlas
> ba = ImporterBrainAtlasXLS('WAITBAR', true).get('GET_FILE').get('BA');  ③
> 
> %% Groups
> gr1 = ImporterGroupSubjectST_MP_XLS('BA', ba, 'WAITBAR', true).get('GET_DIR').get('GR');  ④
> gr2 = ImporterGroupSubjectST_MP_XLS('BA', ba, 'WAITBAR', true).get('GET_DIR').get('GR');  ⑤
> gr3 = ImporterGroupSubjectST_MP_XLS('BA', ba, 'WAITBAR', true).get('GET_DIR').get('GR');  ⑥
> 
> %% Analysis 1
> a_BUD1 = AnalyzeGroup_ST_MP_BUD('GR', gr1, 'DENSITIES', [10 20 30 40 50]);  ⑦
> 
> %% Analysis 2
> a_BUD2 = AnalyzeGroup_ST_MP_BUD('GR', gr2, 'TEMPLATE', a_BUD1);  ⑧
> 
> %% Analysis 3
> a_BUD3 = AnalyzeGroup_ST_MP_BUD('GR', gr3, 'TEMPLATE', a_BUD1);  ⑨
> 
> %% Comparison
> c_BUD1 = CompareGroup('P', 1000, 'A1', a_BUD1, 'A2', a_BUD2, 'MEMORIZE', true);  ⑩
> c_BUD2 = CompareGroup('P', 1000, 'A1', a_BUD1, 'A3', a_BUD3, 'MEMORIZE', true);  ⑪
> c_BUD3 = CompareGroup('P', 1000, 'A2', a_BUD2, 'A3', a_BUD3, 'MEMORIZE', true);  ⑫
> ````
> 
> ① specifies the name of the pipeline. **The name is changed to avoid conflicts.**
> 
> ② provides descriptions for the overall pipeline as well as for each step. **This is updated to reflect the updated pipeline.**
> 
> ③ loads the brain atlas.
> 
> ④ loads group 1 from XLS.
> 
> ⑤ loads group 2 from XLS.
> 
> ⑥ loads group 3 from XLS. **This is added.**
> 
> ⑦ performs the graph analysis for group 1. The default value of `'DENSITIES'` is set to `[10 20 30 40 50]`.
> 
> ⑧ performs the graph analysis for group 2 with the same analysis template as with group 1.
> 
> ⑨ performs the graph analysis for group 3 with the same analysis template as with group 1. **This is added.**
> 
> ⑩ compares graph measures between groups 1 group 2. The default value of the number of permutations is `'P'` set to `1000`.
> 
> ⑪ compares graph measures between groups 1 and 3. **This is added.**
> 
> ⑫ compares graph measures between groups 2 and 3. **This is added.**
>
