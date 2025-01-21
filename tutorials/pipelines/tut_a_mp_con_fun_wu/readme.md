# Pipeline for Comparison of Connectivity-Functional Multiplex Data using Weighted Undirected Graphs

[![Tutorial Pipeline for Comparison of Connectivity-Functional Multiplex Data using Weighted Undirected Graphs](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](tut_a_mp_con_fun_wu.pdf)

This tutorial shows how to perform a network analysis using *connectivity-functional multiplex data* (see tutorial [Group of Subjects with Connectivity-Functional Multiplex Data](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials/data/tut_gr_con_fun_mp)), where both connectivity and functional data are available per subject, as in diffusion weighted imaging and activation signals for each brain region derived from functional MRI, MEG, or EEG. Step by step, this pipeline guides you to compare the data from two groups of subjects.  With this tutorial, you will be able to extract and plot differences between two groups. You will also be able to generate publication-quality figures.




<img src="fig01.png" alt="Figure examples" height="400px">

> **Figure 1. Figure examples**
> Examples of displays of "Multiplex Core-Periphery" with connectivity-functional multiplex data obtained using BRAPH 2.

## Table of Contents
> [Generate Example Data](#Generate-Example-Data)
>
> [Open the GUI](#Open-the-GUI)
>
> [Step 1: Load the Brain Atlas](#Step-1-Load-the-Brain-Atlas)
>
> [Steps 2-4: Load the Groups Data](#Steps-24-Load-the-Groups-Data)
>
> [Step 5: Analyzing the Data of Group 1](#Step-5-Analyzing-the-Data-of-Group-1)
>
>> [Setting Analysis Parameters](#Setting-Analysis-Parameters)
>>
>> [Setting Graph Parameters](#Setting-Graph-Parameters)
>>
>> [Setting Measure Parameters](#Setting-Measure-Parameters)
>>
>> [Calculate Measures](#Calculate-Measures)
>>
> [Step 6: Analyzing the Data of Group 2](#Step-6-Analyzing-the-Data-of-Group-2)
>
> [Step 7: Comparing Groups](#Step-7-Comparing-Groups)
>


<a id="Generate-Example-Data"></a>
## Generate Example Data  [⬆](#Table-of-Contents)

You can generate the example data by typing in the command line the instruction in Code 1.


> **Code 1.** **Command to generate example data.**
> 		Command to generate the example data for connectivity and functional multiplex analyses. They will be placed in the folder "./braph2/pipelines/connectivity-functional multiplex/Example data CON_FUN_MP XLS", and include the brain atlas "atlas.xlsx", two folders (one for the connectivity data and the other for the functional data) with two folders with the subject files ("CON_Group1_XLS" and "CON_Group2_XLS" for the connectivity data, and "FUN_Group1_XLS" and "FUN_Group2_XLS" for the functional data), and the associated covariates files ("CON_Group1_XLS.vois.xlsx" and "CON_Group2_XLS.vois.xlsx" at the connectivity data, and "FUN_Group1_XLS.vois.xlsx" and "FUN_Group2_XLS.vois.xlsx" at the functional data). The details about the format of these files can be found in the tutorials [Brain Atlas](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials/data/tut_ba) and [Group of Subjects with Connectivity-Functional Multiplex Data](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials/data/tut_gr_con_fun_mp).
> ````matlab
> create_data_CON_FUN_MP_XLS()
> ````
> 

<a id="Open-the-GUI"></a>
## Open the GUI  [⬆](#Table-of-Contents)

The general GUI of BRAPH 2 can be opened by typing `braph2` in MatLab's terminal. This GUI allows you to select a pipeline, in this case, *Pipeline Connectivity-Functional Multiplex Comparison WU*, as shown in Figure 2.



<img src="fig02.jpg" alt="BRAPH 2 main GUI">

> **Figure 2. BRAPH 2 main GUI**
> BRAPH 2 main GUI with the pipeline *Pipeline Connectivity-Functional Multiplex Comparison WU* selected.




> **Pipeline launch from command line**
> To open the GUI and upload the connectivity-functional multiplex comparison pipeline, you can also use the command line by typing the commands in Code 2.
> 
> 
> > **Code 2.** **Code to launch the GUI to upload a pipeline file to compare two groups of subjects.**
> > 		This code can be used in the MatLab command line to launch the GUI to upload a pipeline file.
> > ````matlab
> > im = ImporterPipelineBRAPH2( ...
> >     'FILE', which('pipeline_connectivity_functional_multiplex_comparison_wu.braph2') ...
> >     );
> > pip = im.get('PIP');
> > 
> > gui = GUIElement('PE', pip, 'WAITBAR', true)
> > gui.get('DRAW')
> > gui.get('SHOW')
> > ````
> >

Once the pipeline is uploaded, you can see a GUI that contains different steps to: upload a brain atlas, upload the connectivity and functional multiplex data of two groups, analyze them, and finally, compare the groups (Figure 3).

<img src="fig03.jpg" alt="Pipeline steps" height="400px">

> **Figure 3. Pipeline steps**
> These are the steps of the pipeline. Only the first step is active when the pipeline is first opened. Subsequent steps will become active sequentially.



<a id="Step-1-Load-the-Brain-Atlas"></a>
## Step 1: Load the Brain Atlas  [⬆](#Table-of-Contents)

Figure 4 shows how to upload and plot the brain atlas that you used to extract the data for your analysis. For more information on where to find different atlases or how to change plotting settings on the brain surface, check the tutorial [Brain Atlas](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials/data/tut_ba).


 
 <img src="fig04.jpg" alt="Uploading the Brain Atlas">

> **Figure 4. Uploading the Brain Atlas**
> Steps to upload the brain atlas:
> 	**a** Click on "Load Atlas" from the pipeline GUI.
> 	**b** Navigate to the BRAPH 2 folder "pipelines_connectivity-functional multiplex_Example data CON_FUN_MP XLS", and select the atlas file, in this example the "atlas.xlsx".  
> 	**c** You can visualize the brain atlas by pressing "Plot Brain Atlas".



<a id="Steps-24-Load-the-Groups-Data"></a>
## Steps 2-4: Load the Groups Data  [⬆](#Table-of-Contents)

After you have loaded the brain atlas, you can upload the *connectivity data* for each group and later the *functional data* for each group, as shown in Figure 5. A new interface will be shown containing the data for the group you just selected. You can open each subject’s data by selecting the subject, right click, and select “Open selection” (for more information check the tutorial [Group of Subjects with Connectivity-Functional Multiplex Data](https://github.com/braph-software/BRAPH-2/tree/develop/tutorials/data/tut_gr_con_fun_mp)).



 <img src="fig05.jpg" alt="Loading and visualizing the group data">

> **Figure 5. Loading and visualizing the group data**
> **a** From the pipeline GUI, click on "Load Group CON 1 from XLS" and "Load Group CON 2 from XLS" to load the connectivity data of both groups.
>    	**b** Navigate to the BRAPH 2 folder "pipelines", "connectivity-functional multiplex", "Example data CON_FUN_MP XLS", "connectivity", and select the group folder that you want to upload. 
>         **c** Once the connectivity data is uploaded, click on "Load Group FUN 1 from XLS" and "Load Group FUN 2 from XLS" to load the functional data of both groups.
>    	**d** Navigate to the BRAPH 2 folder "pipelines", "connectivity-functional multiplex", "Example data CON_FUN_MP XLS", "functional", and select the group folder that you want to upload. 
>    	**e** After uploading the data for both modalities, click on "Combine Groups 1" and "Combine Groups 2" to create groups with connectivity-functional multiplex subjects, and it will open a window for group 1 **f** from which we can open a subject’s connectivity-functional
> multiplex data and metadata **g**.
 


<a id="Step-5-Analyzing-the-Data-of-Group-1"></a>
## Step 5: Analyzing the Data of Group 1  [⬆](#Table-of-Contents)

Once you have loaded the data for both groups, you can begin analyzing the data for the first group by clicking on "Analyze Group 1" (Figure 6a). 
This will open a new interface called "Analyze Ensemble", which allows you to calculate and visualize graph measures for the first group. 
Before these network measures are calculated, it is important to ensure the following things: 


- The analysis parameters are set correctly (e.g., the thresholds).

- The graph parameters are set correctly.

- The measures are configured with the parameters you desire (note that not all measures have parameters).



Importantly, the parameters you select at the beginning will remain fixed for the rest of the pipeline to ensure consistency (including the analysis of the second group and the comparison between groups). We will now guide you through the process of preparing these parameters for both measures and graphs. It is important to keep in mind that the default parameters should work well for most cases.

<a id="Setting-Analysis-Parameters"></a>
### Setting Analysis Parameters  [⬆](#Table-of-Contents)

In the "Analyze Ensemble" interface, you can configure the analysis parameters (Figure 6b).
In the `REPETITION TIME [s]` section, you can include the repetition time with which your images were acquired, for example, to analyze the data only within a fraction of the repetition time.
In the `MIN FREQUENCY [Hz]` and `MAX FREQUENCY [Hz]`, you can edit the values to analyze your data within a certain frequency band such as in the case of EEG or MEG data.
In the `CORRELATION RULE`, you can select the type of correlation you want to run using the brain activation signals between brain areas. 
Finally, in the `NEGATIVE WEIGHTS RULE`, you should decide if you want to set the negative weights to zero, their absolute values or exclude them from the analysis since graph theory measures are not defined for negative weights.



 <img src="fig06.jpg" alt="Configuring analysis parameters">

> **Figure 6. Configuring analysis parameters**
> **a** To initiate the analysis of data for group 1, click on "Analyze Group 1".
>  	**b** In this section you can configure the analysis parameters.
>  	**c** By clicking on the section `GRAPH & MEASURE PARAMETERS`, you open **d** a new interface that permits you to configure the graph parameters.
 
<a id="Setting-Graph-Parameters"></a>
### Setting Graph Parameters  [⬆](#Table-of-Contents)

To configure the graph parameters, you click on the section `GRAPH & MEASURE PARAMETERS` (Figure 6c). This will open a new interface for graph template settings. 
In brain connectivity analysis, threshold values dictate the required connection strength between different brain regions for them to be considered “connected” in a binary undirected graph. 
Adjusting these thresholds allows you to explore varying levels of brain connectivity, providing insights into how regions communicate at different threshold settings.

The available parameters are:


- `SYMMETRIZATION RULE` determines how to symmetrize the matrix.

- `NEGATIVE EDGE RULE` determines how to remove the negative edges.

- `NORMALIZATION RULE` determines how to normalize the weights between 0 and 1.

- `THRESHOLDS` determines the thresholds. *This cannot be set here. It is set in the previous step.*

- `RANDOMIZE ON/OFF` determines whether to randomize the graph. *Typically not used*

- `RANDOM SEED` is the randomization seed. *Typically not used*

- `RANDOMIZATION ATTEMPTS PER EDGE` is the attempts to rewire each edge. *Typically not used*



<a id="Setting-Measure-Parameters"></a>
### Setting Measure Parameters  [⬆](#Table-of-Contents)

Now, after pressing `GRAPH TEMPLATE` (Figure 7a), if you scroll down to find the `Graph MEASURES` section and click on the `C` button, all compatible measures will be displayed in a table. 
For example, you can select the `Multiplex Core-Periphery` measure and then right-click at the top of the table (Figure 7b). In the right-click menu, choose `Data Selected Measures`. 
This will open the measure window, allowing you to specify the rules or parameters (Figure 7c). In this example, the rule consists of a number of coefficients that determine the importance or contribution of each layer (Figure 7d). If we leave the "0" unchanged, the measure will retain the default coefficients (1/total number of layers), distributing equal weight to each layer.


 
<img src="fig07.jpg" alt="Configuring Measure Parameters">

> **Figure 7. Configuring Measure Parameters**
> **a** Press `GRAPH TEMPLATE` and
> 	**b** expand the `Graph MEASURES` panel, and click on the `C` button which will reveal a table displaying all compatible measures. 
> 	Select the `Multiplex Core-Periphery` measure and then right-click at the top of the table. In the right-click menu, choose `Data Selected Measures`.
> 	**c** The measure window that opens allows you to define the parameters for the `Multiplex Core-Periphery` measure. We leave it with default values.
>     **d** Description of the `Multiplex Core-Periphery` measure's rule.
 


<a id="Calculate-Measures"></a>
### Calculate Measures  [⬆](#Table-of-Contents)
 
After configuring the parameters, you can proceed to calculate specific graph measures (Figure 8). To do this, return to the "Analyze Ensemble" interface (Figure 8a-b) and scroll down to locate the "Group-averaged MEASURES" panel. By clicking the 'C' button, you will see a table displaying all measures.



 <img src="fig08.jpg" alt="Analyzing the Group Data">

> **Figure 8. Analyzing the Group Data**
> **a** Locate the `Group-averaged MEASURES` panel and click the `C` button to see all available measures. Choose the `Multiplex Core-Periphery` measure, right-click it, and select `Calculate Selected Measures` to perform the calculation.
> 	**b** To visualize the results, right-click on the top of the table and choose `Plot Selected Measures on Brain` in the Analyze Ensemble interface. This action opens a brain surface with the `Multiplex Core-Periphery` plotted.
> 	**c** Adjust visualization settings by clicking on the `Settings Panel Figure` button in the same toolbar to open the settings interface **d**.
> 	**e** Customize and save plot visualizations within the settings menu. Here, we changed the brain color face to 0.3.
>  	**f** Explore different views such as the `Axial dorsal` button in the brain surface toolbar.
 
As an example, let us select the `Multiplex Core-Periphery` measure. Right-click at the top of the table and choose `Calculate Selected Measures` (Figure 8a). Once the calculation is complete, you will notice a `C` appearing in front of the `Multiplex Core-Periphery` row, indicating that this measure has been calculated.

If you wish to visualize the results, right-click on the top of the table and select `Plot Selected Measures on Brain` within the Analyze Ensemble interface (Figure 8b). This will open a brain surface with the "Multiplex Core-Periphery" plotted on it.

Within the toolbar of the brain surface interface, by clicking on the `Settings Panel Figure` button (Figure 8c) you can adjust different visualization settings.
For instance, within the settings menu (Figure 8d), you can change the brain color face to be more transparent (Figure 8e). Within the settings menu, you can customize the visualization of the plots and save them for reference.
Additionally, in the toolbar of the brain surface interface, you can change the view by clicking on the `Axial dorsal` button (Figure 8f). 

Finally, when you right-click in the `Group-averaged MEASURES` panel, you will find other options to explore, such as `Plot Selected Measures` (which generates a line plot for the selected measure at different thresholds and/or different nodes) and `Data Selected Measure` (providing the calculated values of the selected measures). These options can also be saved for further analyses outside BRAPH 2.

<a id="Step-6-Analyzing-the-Data-of-Group-2"></a>
## Step 6: Analyzing the Data of Group 2  [⬆](#Table-of-Contents)

After completing the analysis of the first group, you can analyze the second group by simply clicking on `Analyze Group 2` (Figure 9a). You will notice that in the new GUI (Figure 9b-e), the parameters you previously selected for the first group are already preselected and fixed for this analysis. 



 <img src="fig09.jpg" alt="Parameters blocked in the Analysis of Group 2">

> **Figure 9. Parameters blocked in the Analysis of Group 2**
> **a** Click on "Analysis 2" in the pipeline's GUI. 
> 	**b** In this new window, you can see that the analysis parameters are blocked.
> 	**c** In "GRAPH TEMPLATE" window, you can see that the graph parameters and the rule for measures **d-e** such as the "Multiplex Core-Periphery" are blocked, since they should be the same as the ones set in the analysis of group 1. Finally, you can reset the analysis parameters for Group 1 by clicking on the checkbox marked with a 'C' next to the settings of Group 1 **a**.
 	
If you want to change some of the parameters you previously selected, you can reset the analysis parameters by clicking on the cancel button marked with a `D` (Figure 9a) near the analysis of the first group.
 


<a id="Step-7-Comparing-Groups"></a>
## Step 7: Comparing Groups  [⬆](#Table-of-Contents)

After exploring the network measures for each group, you can proceed to their statistical comparison by clicking on `Compare Groups` (Figure 10a).



 <img src="fig10.jpg" alt="Compare the groups">

> **Figure 10. Compare the groups**
> **a** Click on `Compare Groups` in the pipeline's GUI.
> 	**b** In this new window, you can select to turn ON/OFF the wait bar and verbose functions, you can change the number of permutations, and whether to perform a longitudinal group comparison. We set the number of permutations to 10 for this tutorial **c**. Finally, you can calculate the comparisons of some graph measures between groups and show their results by clicking on `Data Selected Comparisons` **d**.
 
In the new window, you have several options to configure the analysis. First, you can choose whether to enable a progress bar and verbose functions while the analysis is running, which can help you monitor the progress of the analysis. You can also specify how many permutations you want to use to assess differences between groups (Figure 10b).

If your groups are not independent and represent the same subjects assessed in different points in time, you can select the longitudinal comparison option. This option will permute the values within each subject, considering their temporal relationship (Figure 10b).

For computational efficiency, in this tutorial, we have set the number of permutations to 10. However, for your research analysis, we recommend using a higher number, such as 1000 or 10000 permutations, to ensure the results are robust.

Next, you can select the specific graph measures you wish to compare between the groups. To do this, click on `C` in the `COMPARISONS` section (Figure 10c). Once you have chosen all the measures of interest, right-click and select `Calculate Selected Comparisons`.

If you have enabled the progress bar and verbose functions, two additional windows will appear to display the progress of the comparison calculations. Finally, there is an option in this GUI to save intermediate results during the permutations, which can be helpful for further analysis.
 
To obtain the results from the comparisons, select the measures in the `COMPARISONS` panel and press `Data Selected Comparisons` ({Figure 10c}), and a new window will open where we can check the value of the difference between groups, the p-values (1-tailed and 2-tailed), as well as the confidence intervals ({Figure 10d}).

 

 <img src="fig11.jpg" alt="Visualize the group comparison results on a brain surface">

> **Figure 11. Visualize the group comparison results on a brain surface**
> **a** Click on "Brain Graph Selected Comparison" in the Comparisons panel.
> 	**b** In this new window, you will see the comparison results, with positive values in red and negative values in blue on the brain surface. Press on the settings toolbar button to show the settings menu.
> **c** You can customize this visualization using the settings menu.
 
If you wish to visualize the results, right-click at the top of the table and select `Brain Graph Selected Comparison` within the Compare Ensemble interface (Figure 11a). This action will open a brain surface displaying the difference between these two groups in terms of the "Overlapping Strength" data or any other nodal measure you have calculated.

Within the brain surface interface's toolbar, you have various options to explore. For example, by clicking on the “Settings Panel Figure” button (Figure 11b) you can fine-tune different visualization settings.

For further customization, within the settings menu (Figure 11c), you can activate the `FDR CORRECTION` feature to control for multiple comparisons and reduce the chance of false positive results when assessing the significance of connectivity measures across multiple brain regions. You can also use the settings menu to personalize the visualization of your plots and save them.
