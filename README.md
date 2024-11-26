![BRAPH 2](braph2banner.png)

# BRAPH 2 — Multimodal and AI-Powered Brain Connectivity Analysis

[![BRAPH 2](https://img.shields.io/twitter/url?label=BRAPH%202&style=social&url=https%3A%2F%2Ftwitter.com%2Fbraph2software)](https://twitter.com/braph2software)
[![Website](https://img.shields.io/website?up_message=braph.org&url=http%3A%2F%2Fbraph.org%2F)](http://braph.org/)
[![DOI](https://img.shields.io/badge/DOI-10.1371%2Fjournal.pone.0178798-blue)](https://doi.org/10.1371/journal.pone.0178798)

<br />

BRAPH 2 is an open-source MATLAB-based software that provides advanced capabilities for brain connectivity analysis. It offers a comprehensive range of features, including conventional graph theory, multilayer graphs, and deep learning techniques. With its user-friendly interface and extensive analysis pipelines, researchers can explore the complex organization of the human brain using multimodal neuroimaging data, going beyond the limitations of traditional approaches.

![Advances in brain connectivity analysis](braph2overview.png)
> 
> **Advances in brain connectivity analysis.** Brain connectivity analysis is rapidly evolving thanks to the widespread availability of increasing computational power and large-scale, high-resolution, multimodal neuroimaging datasets. BRAPH 2 provides a complete set of tools to analyze these data with conventional graph theory (single-layer graphs), multiplex and multilayer graphs, and deep learning (from dense neural networks to graph convolutional neural networks), as well as a flexible, easily expandable software architecture. BRAPH 2 uses parallel computing to allow users to run scripts on servers or clusters with both central processing units (CPUs) and graphical processing units (GPUs).

## Welcome to BRAPH 2

BRAPH 2 is designed to facilitate the analysis of brain connectivity using various neuroimaging modalities and cutting-edge techniques. It enables researchers to assess brain organization with multimodal data and advanced tools such as deep learning. BRAPH 2 provides an extensive set of analysis pipelines accessible through a graphical user interface (GUI) and through sample scripts, allowing users to perform ready-to-use analyses or develop customized pipelines for their specific needs.

### Installation

To install BRAPH 2, follow these steps:

1. Ensure that you have **MATLAB R2022a or a later version** installed on your system. BRAPH 2 is compatible with the versions of MATLAB for Microsoft Windows, MacOS, and Linux operating systems.

2. Make sure you have the following toolboxes installed in MATLAB:
    * **Statistics and Machine Learning Toolbox** (required for most pipelines)
    * **Parallel Computing Toolbox** (optional)
    * **Deep Learning Toolbox** (optional, for deep learning analysis)

3. Download the latest stable version of BRAPH 2 from [BRAPH 2 Releases](../../releases).

4. Unzip the downloaded file into the desired directory on your system.

5. Launch MATLAB.
   
7. Navigate to the `braph2` folder located in the directory where you unzipped BRAPH 2. 

9. Run the script `braph2`. This will launch the graphical user interface (GUI) from which you can choose an analysis pipeline.

10. Explore the [BRAPH 2 Tutorials](tutorials).

### Compatibility with MatLab Releases and Operative Systems
A &check; indicates that we have unit-tested the current release BRAPH 2 on the indicated Matlab release and operative system.

| Matlab Version        | Mac     | Win    | Linux   |
| :-------------------: | :-----: | :-----:| :-----: |
| R2022a                | ?       | ?      | ?       |
| R2022b                | ?       | ?      | ?       |
| R2023a                | ?       | [&check;](https://github.com/braph-software/BRAPH-2/issues/1753#issuecomment-2500148139)      | ?       |
| R2023b                | ?       | ?      | ?       |
| R2024a                | ?       | ?      | ?       |
| R2024b                | ?       | ?      | [&check;](https://github.com/braph-software/BRAPH-2/issues/1753#issuecomment-2500148139](https://github.com/braph-software/BRAPH-2/issues/1753#issuecomment-2465324224))       |

### Use Cases & Analysis Pipelines

BRAPH 2 provides a wide range of analysis pipelines that can be used for various use cases in brain connectivity analysis. For detailed information about these analysis pipelines, including their functionalities and step-by-step instructions, refer to the [BRAPH 2 Pipeline Tutorials](tutorials/pipelines). Here are some possible use cases of BRAPH 2:

1. **Conventional Single-Layer Analyses**: BRAPH 2 offers pipelines to analyze single-layer graphs derived from different kinds of neuroimaging data. These pipelines involve loading the brain atlas, loading the subject data, constructing the graph, calculating graph measures of interest, and comparing groups. Single-layer analyses can be performed on connectivity data, functional data, and structural data.

2. **Multilayer Analyses**: BRAPH 2 supports the analysis of multilayer graphs, which capture the connectivity patterns across multiple layers or modalities. The multilayer analysis pipelines involve similar steps as single-layer analyses but operate on multilayer graphs. This allows researchers to explore the relationships between different layers or modalities of brain connectivity.

3. **Deep Learning Analyses**: BRAPH 2 enables the analysis of brain connectivity data using deep learning techniques. The deep learning pipelines involve loading the brain atlas, loading the subject data, constructing the input for deep learning models, splitting the dataset, training the models, and evaluating the model performance. Deep learning analyses can be applied to connectivity data, functional data, and structural data and graphs.

### For Developers

BRAPH 2 is designed to be an open community-driven project, and the code is freely available on this GitHub repository at [BRAPH 2 Releases](../../releases). Developers can contribute to BRAPH 2 at various levels of complexity, ranging from editing existing pipelines and adapting example scripts to implementing entirely new features. For the details on how to do this, refer to the [BRAPH 2 Developer Tutorials](tutorials/developers).

## Contribute to BRAPH 2

BRAPH 2 is an open-source project, and contributions from the community are highly encouraged. Whether you want to report a bug, suggest a new feature, or contribute code improvements, your involvement is valuable and will help make BRAPH 2 even better.

### Bug Reports and Feature Requests

If you encounter any issues or have ideas for new features, please submit detailed information for bug reports using the [Bug Report](../../issues/new?template=bug_report.md) template and clear descriptions for feature requests using the [Feature Request](../../issues/new?template=feature_request.md) template.

### Code Contributions

If you're interested in contributing with code, follow these steps:

1. Fork the BRAPH 2 repository on GitHub.

2. Create a new branch for your changes.

3. Make your modifications and commit them.

4. Push your branch to your forked repository.

5. Open a pull request against the `develop` branch of the main repository.

The core team of BRAPH 2 developers will then revise this proposal and possibly merge it or come back to you with questions and comments.

### Documentation Contributions

Improvements to the documentation are welcome. Submit a pull request as indicated above with your proposed changes for errors, outdated information, or suggestions for improvement.

### Community Support

Join discussions on the [BRAPH 2 Discussion Forum](https://github.com/braph-software/BRAPH-2/discussions) to provide support, answer questions, and share your expertise.

## Cite BRAPH 2

If you use BRAPH 2 in your research work, please cite the following publication:

```
Mite Mijalkov, Ehsan Kakaei, Joana B Pereira, Eric Westman & Giovanni Volpe (2017).
BRAPH: A graph theory software for the analysis of brain connectivity.
PLOS ONE 12, e0178798.
https://doi.org/10.1371/journal.pone.0178798
```
