# Pipeline for Comparison of Binarized Structural Data between Groups of Subjects at Fixed Densities

[![Tutorial Pipeline for Comparison of Binarized Structural Data between Groups of Subjects at Fixed Densities](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](tut_a_st_bud.pdf)

In this tutorial, you will upload a file containing the pipeline with the different steps to compare two groups of subjects using *structural data* (check tutorial [Group of Subjects with Structural Data](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials/data/tut_gr_st)) and binarized undirected graphs. This tutorial explains how to perform group analyses and comparisons with this kind of data at fixed densities.


<img src="fig01.png" alt="Figure examples" height="400px">

> **Figure 1. Figure examples**
> Examples of displays of the clustering measure with binarized structural data at fixed densities obtained using BRAPH 2.

## Table of Contents
> [Generate Example Data](#Generate-Example-Data)
>
> [Open the GUI](#Open-the-GUI)
>
> [Step 1: Load the Brain Atlas](#Step-1-Load-the-Brain-Atlas)
>
> [Step 2: Load the Structural Group Data](#Step-2-Load-the-Structural-Group-Data)
>
> [Step 3: Analyzing the Data of Group 1](#Step-3-Analyzing-the-Data-of-Group-1)
>
>> [Setting Analysis Parameters](#Setting-Analysis-Parameters)
>>
>> [Setting Measure Parameters](#Setting-Measure-Parameters)
>>
>> [Calculate Measures](#Calculate-Measures)
>>
> [Step 4: Analyzing the Data of Group 2](#Step-4-Analyzing-the-Data-of-Group-2)
>
> [Step 5: Comparing Groups](#Step-5-Comparing-Groups)
>



<a id="Generate-Example-Data"></a>
## Generate Example Data  [⬆](#Table-of-Contents)

You can generate the example data by typing in the command line the instruction in Code 1.


> **Code 1.** **Command to generate example data.**
> 		Command to generate the example data for structural analyses. They will be placed in the folder "./braph2/pipelines/structural/Example data ST XLS", and include the brain atlas "atlas.xlsx", two folders with the subject files "ST_Group_1_XLS" and "ST_Group_2_XLS", and the associated covariates files "ST_Group_1_XLS.vois.xlsx" and "ST_Group_2_XLS.vois.xlsx". The details about the format of these files can be found in the tutorials [Brain Atlas](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials/data/tut_ba) and [Group of Subjects with Structural Data](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials/data/tut_gr_st).
> ````matlab
> create_data_ST_XLS()
> ````
> 


<a id="Open-the-GUI"></a>
## Open the GUI  [⬆](#Table-of-Contents)

The general GUI of BRAPH 2.0 can be opened by typing `braph2` in MatLab's terminal. This GUI allows you to select a pipeline, in this case, *Pipeline Structural Comparison BUD*, as shown in Figure 3.



<img src="fig02.jpg" alt="BRAPH 2 main GUI">

> **Figure 2. BRAPH 2 main GUI**
> BRAPH 2 main GUI with the pipeline *Pipeline Structural Comparison BUD* selected.


> **Pipeline launch from command line**
> To open the GUI and upload the structural comparison pipeline, you can also use the command line by typing the commands in Code 2.
> 
> 
> > **Code 2.** **Code to launch the GUI to upload a pipeline file to compare two groups of subjects.**
> > 		This code can be used in the MatLab command line to launch the GUI to upload a pipeline file
> > ````matlab
> > im = ImporterPipelineBRAPH2( ...
> >     'FILE', which('pipeline_structural_comparison_bud.braph2') ...
> >     );
> > pip = im.get('PIP');
> >     
> > gui = GUIElement('PE', pip, 'WAITBAR', true)
> > gui.get('DRAW')
> > gui.get('SHOW')
> > ````
> >


Once the pipeline is uploaded, you can see a GUI that contains different steps: to upload a brain atlas, to upload the structural data of two groups, analyze them, and finally, to compare the groups (Figure 3). 



<img src="fig03.jpg" alt="Pipeline steps" height="400px">

> **Figure 3. Pipeline steps**
> These are the steps of the pipeline. Only the first step is active when the pipeline is first opened. Subsequent steps will become active sequentially.



<a id="Step-1-Load-the-Brain-Atlas"></a>
## Step 1: Load the Brain Atlas  [⬆](#Table-of-Contents)

Figure 4 shows how to upload and plot the brain atlas that you used to extract the *structural data* for your analysis. For more information on where to find different atlases or how to change plotting settings on the brain surface, check the [Brain Atlas](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials/data/tut_gr_st) tutorial.



<img src="fig04.jpg" alt="Uploading the Brain Atlas">

> **Figure 4. Uploading the Brain Atlas**
> Steps to upload the brain atlas:
> 	**a** Click on "Load Atlas" from the pipeline GUI.
> 	**b** Navigate to the "./braph2/pipelines/structural/Example data ST XLS" and select the atlas file "atlas.xlsx" that would be used in this example. You can also plot the brain atlas by pressing "Plot Brain Atlas".
 
<a id="Step-2-Load-the-Structural-Group-Data"></a>
## Step 2: Load the Structural Group Data  [⬆](#Table-of-Contents)

After you loaded the brain atlas, you can upload the *structural data* for each group as shown in Figure 5. A new interface will be shown containing the data for the group you just selected. You can open each subject’s structural values by selecting
the subject, right click, and select “Open selection” (for more information check tutorial [Group of Subjects with Structural Data](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials/data/tut_gr_st)).
	


<img src="fig05.jpg" alt="Loading the Groups Data">

> **Figure 5. Loading the Groups Data**
> **a** From the pipeline GUI, click on "Load Group ST 1 XLS" to load the data of group 1, and "Load Group ST 2 XLS" to load the data of group 2.
> 	**b** Data for group 1 is uploaded. **c** Data for group 2 is uploaded.

<a id="Step-3-Analyzing-the-Data-of-Group-1"></a>
## Step 3: Analyzing the Data of Group 1  [⬆](#Table-of-Contents)

Once you have loaded the data for both groups, you can begin analyzing the data for the first group by clicking on "Analyze Group 1" (Figure 6a-b). 
This will open a new interface called "Analyze Ensemble", which allows you to calculate and visualize graph measures for the first group. 
Before these network measures are calculated, it is important to ensure the following things: 


- The analysis parameters are set correctly.

- The graph parameters are set correctly.

- The measures are configured with the parameters you desire (note that not all measures have parameters).



Importantly, the parameters you select at the beginning will remain fixed for the rest of pipeline to ensure consistency (including the analysis of the second group and the comparison between groups). We will now guide you through the process of preparing these parameters for both measures and graphs. It is important to keep in mind that the default parameters should work well for most cases.

<a id="Setting-Analysis-Parameters"></a>
### Setting Analysis Parameters  [⬆](#Table-of-Contents)


First of all, you can specify the parameters for constructing the graph from the structural group data (Figure 6c).In the `CORRELATION RULE` section, you can select the statistical test to calculate correlations in structural values between pairs of brain regions (Figure 6d).
In the `NEGATIVE WEIGHTS RULE` you can decide how you want to analyze the negative weights from the correlation (Figure 6e). 
In the `DENSITIES` you can decide how many percent of connections to retain (Figure 6F). Especially, in the densities section, you can specify the densities by filling “[10 20 30 40 50]” or “10:10:50”.



<img src="fig06.jpg" alt="Analyze the Group Data">

> **Figure 6. Analyze the Group Data**
> **a** Click on "Analyze Group 1" in the pipeline's GUI.
>         **b** After clicking on "Analyze Group 1" in the pipeline's GUI, a new window will appear where first you can select the parameters for the graph construction **c**. In this pipeline, you can select the statistical test to be used for the correlations **d**, what you want to do with the negative correlation weights **e**, and decide how many percent of connections to retain **f**.
 
<a id="Setting-Measure-Parameters"></a>
### Setting Measure Parameters  [⬆](#Table-of-Contents)

 After setting these parameters, you can calculate some graph measures (Figure 7). First of all, you need to ensure the measure is using the rule or parameter that you wish (not all measures have rules or parameters). As an example, we can select the measure "Clustering" and right-click on the top of the table (Figure 7a), in the `GRAPH & MEASURES` panel, and press “Data Selected Measures”. 
 Next, the measure window will appear, allowing you to choose the rules or parameters (Figure 7b). 
 
 The available parameters are:
 
 
 - `Triangle rule for directed graphs` the rule applies to the calculation of triangles in directed graphs. However, since we're working with an undirected graph, we will keep the default option (Figure 7b).
 
 
 

 
 <img src="fig07.jpg" alt="Check and set the rules and/or parameters of a measure before its calculation">

> **Figure 7. Check and set the rules and/or parameters of a measure before its calculation**
> **a** Click on "Data Selected Measures" after selecting the measure.
>  	**b** This new window shows the array of values for the measure, in this case "Clustering".
>  	**c** This new window shows the array of values for the measure, in this case "Clustering".
>  	**d** After the calculation of the measure, a new table appears with the measure results for each density, and the rule is blocked (in blue).
 
<a id="Calculate-Measures"></a>
### Calculate Measures  [⬆](#Table-of-Contents)

After the rule is set, you can calculate the measure by pressing the `C` (Figure 7c) and the results will appear in a new table within the same panel (Figure 7d). Also notice that after the measure is calculated, the rule is blocked. The measurement results correspond to the different densities defined earlier(Figure 7d).
 
 If you want to visualize the results, select the measure and press "Plot Selected Measures on Brain" in the analysis' GUI (Figure 8a). In settings (Figure 8b-c), you can change the visualization of the plots and save them. 
 


<img src="fig08.jpg" alt="Visualize the measure's results in a brain plot">

> **Figure 8. Visualize the measure's results in a brain plot**
> **a** Click on "Plot Selected Measures on Brain" in the analysis' GUI and a brain surface with the results from the calculated measures will appear. The size of the spheres and the color are proportional to the measure's value.   
>     **b** In the new window, press the button settings to obtain further visualization options of the results. 
>     **c** In the options window, you can change the number 
>     of "Graph LAYER" to plot measures for different densities.
 
 Finally, when you do right click, in the "GRAPH & MEASURES" panel, there are other options you can explore such as "Plot Graph Plot" (connectivity adjacency matrix) as well as Data Graph (labels of brain regions, values of the adjacency matrix, options to plot matrix and histogram), all of which can also be saved.
  
<a id="Step-4-Analyzing-the-Data-of-Group-2"></a>
## Step 4: Analyzing the Data of Group 2  [⬆](#Table-of-Contents)

After the analysis of Group 1, you can proceed with the analysis of the second group by clicking on "Analyze Group 2" (Figure 9a). You will notice that, in the new window that is shown (Figure 9b-d), the parameters you selected for group 1 are already selected and fixed for this analysis (both graph and measure parameters). If you realize that some of the options you previously selected are not the ones you would like, you can reset the analysis parameters of Group 1 by clicking on the `D` button next to it.



<img src="fig09.jpg" alt="Parameters blocked in Analysis of Group 2">

> **Figure 9. Parameters blocked in Analysis of Group 2**
> **a** Click on "Analysis 2" in the pipeline's GUI.
> 	**b** In this new window, you can see that the graph properties such as "Correlation rule" and "Negative weights rule" are blocked since they are the same as the ones set in the analysis of group 1. If you select a measure, in this case "Clustering", and press "Data Selected Measures" **c**, you can observe that the measure's rules and parameters are also set in case you calculated the measures in analysis 1, and if not, you can set the rule by pressing at the `@` **d**.

<a id="Step-5-Comparing-Groups"></a>
## Step 5: Comparing Groups  [⬆](#Table-of-Contents)

Once you have explored the network measures for each group, you can proceed with their statistical comparison. To do this, you should click on "Compare Groups" (Figure 10a) and in the new window select if you want a waiting bar and verbose functions ON while you wait for the analysis to finish, as well as how many permutations you want to use to assess differences between groups (Figure 10b), and if the groups are not independent but represent the same subjects in two different points in time, you can select the longitudinal comparison option, which will permute the values within each subject (Figure 10b). We set the permutations to 100 for computational time purposes (Figure 10c), but for your research analysis we recommend using 1000 or 10000 permutations. Finally, you can select the graph measures you want to compare between groups and once you have selected all the measures you are interested in, you should right click and select "Calculate all selected comparisons" (Figure 10d). If you turn ON the wait bar and verbose functions, two window bars will open that show you at which point in time the comparison calculation is. There is one last option on this GUI that you can select to save intermediate results during the permutations.


 
 <img src="fig10.jpg" alt="Compare the Group Data">

> **Figure 10. Compare the Group Data**
> **a** Click on "Compare Groups" in the pipeline's GUI.
> 	**b** In this new window, you can select what to turn ON/OFF the wait bar and verbose functions, you can change the number of permutations, and whether to perform a longitudinal group comparison. **c** We set the number of permutations to 100 for this tutorial. **d** Finally, you can calculate the comparison of some graph measures between groups.
 
To obtain the results from the measure/s comparison, select the measures in the `GRAPH & MEASURES` panel and press `Data Selected Comparisons`(Figure 11a), and a new window will open (Figure 11b) where we can check the difference value between groups, the p-values (1-tailed and 2-tailed), as well as the confidence intervals.

 
 
 <img src="fig11.jpg" alt="Visualize the comparison results in a table">

> **Figure 11. Visualize the comparison results in a table**
> **a** Click on "Data Selected Comparisons" in the Comparisons panel.
> 	**b** In this new window, you can see the results from the comparison: the difference values between groups, the p-values (1-tailed and 2-tailed), as well as the confidence intervals.
 
 
 
Finally, we can visualize the comparison results on a brain surface by selecting the measure comparisons we want and right click and press "Plot Selected Comparisons on Brain" (Figure 12a). A new window with comparison results on a brain surface will appear, where blue color indicates group 1 > group 2 and red color group 2 > group 1, and the size of the spheres is proportional to the absolute difference value between groups. If you press the Settings button (Figure 12b), then you will have available more options, for example to apply FDR correction to your plot (Figure 12c), which by default is set to off. Additionally, you can adjust the number in the "Graph LAYER" to display comparison results across different densities.



<img src="fig12.jpg" alt="Visualize the comparison results on a brain surface">

> **Figure 12. Visualize the comparison results on a brain surface**
> **a** Click on "Plot Selected Comparisons on Brain" in the comparison's GUI and a brain surface with the results from the calculated measures comparison will appear. The size of the spheres is proportional to the measure value difference between groups and the colors indicate if it is a positive or negative difference.   
>         **b** In the new window, press the button settings to obtain further visualization options of the results. 
>         **c** In the settings, you can activate the FDR correction by setting the desired q value and changing from off to on the button. Additionally, you can adjust the number in the "Graph LAYER" to display comparison results across different densities.
