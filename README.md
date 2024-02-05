The ML-Constructive Heuristic
=========
The general idea
----------
ML-Constructive (ML-C) is the first constructive heuristics 
that scales efficiently using information extracted from historical TSP optimal tours.
ML-C exploits machine learning (ML) to learn common patterns from known optimal 
solutions provided by a perfect Oracle (the Concorde optimal TSP solver).
Then, such learnt ability is employed by the ML-C heuristic 
to construct TSP tours in two phases.

The first phase uses ML to select the most promising edges to insert in an initial fragmented 
solution (Figure 1).
The ML choose edges from the selection of promising edges.
Such selection is distinguished by the simple fact of collecting edges that are connection 
between vertices that are at most second closest to each other.


<p align="center">
	<img src="figures\firstphase.png" alt="example plot"/>
    <em>Figure 1</em>
</p>

Such partial solution enables reducing the construction time for solving, 
meanwhile smartly selecting the most promising edges.
The ML system chooses which edges to include in the solution and which not by employing 
image processing.
Three channels are utilized to represent a local view of the problem.
The first one shows the vertices in the local view,
the second one shows the new edge to be inserted, 
while the third channel shows the existing edges available in the current partial solution.
For more details we refer to Mele *et al.* [1]. 

<p align="center">
	<img src="figures\channels.png" alt="example plot"/>
    <em>Figure 2</em>
</p>


The second (and last) phase of ML-C uses the Clarke-Wright heuristic 
to complete the TSP tour (Figure 2). 
Several approaches are possible for completing the tour.
In Vitali *et al.* [2], for example,
a third phase employing local search techniques on the edges inserted 
during the second phase is suggested.

<p align="center">
	<img src="figures\secondphase.png" alt="example plot"/>
    <em>Figure 3</em>
</p>

The approach shows good result on TSPLIB testing instances up to 1748 vertices.
ML-C is effectively able to combine classical heuristic methods with machine learning 
by learning from small instances and scaling the knowledge to real case scenario.

For the curious readers, we suggest to look through our survey on ML approaches for the TSP [3], 
and an unusual example on how to combine combinatorial optimization concepts 
with the reward function of reinforcement learning setups for the TSP [4]. 


## Running with Conda

To run this application using Conda, follow these steps:

1. **CUDA Toolkit**: The CUDA Toolkit provides a development environment for creating high performance GPU-accelerated applications. It includes GPU-accelerated libraries, debugging and optimization tools, a C/C++ compiler, and a runtime library to deploy your application. If you're using Conda to manage PyTorch and other GPU-accelerated libraries, Conda will install the appropriate version of `cudatoolkit` for you. However, to leverage GPU capabilities fully, ensure that your system's NVIDIA drivers are compatible with the installed CUDA version. For detailed instructions on installing CUDA and matching it with your NVIDIA drivers, visit the [NVIDIA CUDA Toolkit documentation](https://developer.nvidia.com/cuda-downloads).


2. **Install Miniconda or Anaconda**: If not already installed, download and install [Miniconda](https://docs.conda.io/en/latest/miniconda.html) or [Anaconda](https://www.anaconda.com/products/distribution) on your machine.

3. **Create and Activate a New Conda Environment**:
    ```shell
    conda create --name ml_constructive python=3.8
    conda activate ml_constructive
    ```

4. **Install Required Libraries**:
    - Install PyTorch with CUDA support for GPU acceleration. Ensure the CUDA toolkit version matches your system's NVIDIA drivers.
        ```shell
        conda install pytorch torchvision torchaudio cudatoolkit=12.3 -c pytorch
        ```
    - The `libgl1-mesa-glx` package is a library that provides support for OpenGL, which is required by some computer vision libraries like OpenCV, especially when dealing with GUI windows or off-screen rendering. While Conda manages most package dependencies within its environment, system-level dependencies like OpenGL libraries might need to be installed separately on your host system. For Conda environments, OpenCV can be installed without explicitly installing `libgl1-mesa-glx` as Conda packages handle these dependencies internally:
        ```shell
        conda install -c conda-forge opencv
        ```
    - For packages that require a specific installation method or are not available in Conda repositories, use pip within the Conda environment. An example is `pyconcorde`, which is installed via pip:
        ```shell
        pip install 'pyconcorde @ git+https://github.com/jvkersch/pyconcorde'
        ```
    - To install other dependencies from `requirements.txt` and ensure compatibility within the Conda environment, it's recommended to first attempt installation with Conda, falling back to pip if necessary:
        ```shell
        while read requirement; do conda install --yes $requirement || pip install $requirement; done < requirements.txt
        ```

After setting up your Conda environment and installing the necessary libraries, you can proceed with the project-specific commands such as dataset creation, model training, and evaluation within the activated Conda environment.

## Running with Docker

To run this application with Docker, follow these steps:

1. Install Docker on your machine.
2. Pull the Docker image from Docker Hub:
3. Run the Docker container:
   

### Pulling the Docker Image

To pull the `umbertojr/ml-constructive:latest` image from Docker Hub, run the following command in your terminal:

```shell
docker pull umbertojr/ml-constructive:latest
```

Further information on the image can be found in repository on the [Docker Hub](https://hub.docker.com/r/umbertojr/ml-constructive)

### Running the Image as Bash

After pulling the image, you can run it as a Bash terminal to execute Python commands. Use the following command to start the container with an interactive Bash shell, mounting a local directory to save the data:

```shell
docker run -it -v /path/to/local/version1.1/:/app/ umbertojr/ml-constructive:latest bash
```
Replace /path/to/local/version1.1/ with the path to the ML-Constructive/version1.1/ directory on your host machine where you want to save the data generated by the experiments. By aligning this local directory with the project's GitHub structure, you ensure that the dataset and results are organized in a manner consistent with the project's original setup. This command mounts the specified directory to /app/data inside the container, guaranteeing that any data written to this directory in the container is preserved on your host and maintains the expected file hierarchy for straightforward navigation and analysis.

## Replicating Data for Experiments
### Dataset Creation

To create the dataset, which takes about 3 days. The following command generates folders and files containing the data for training and evaluation. Test instances are already located in the "version1/data/test" folder.

```shell
python cli.py --operation create_instances
```
### Saving Data to Local Host

Data generated by the above commands will be automatically saved to the mounted directory (/path/to/local/data) on your host machine. This setup allows you to preserve the data outside of the Docker container, facilitating easy access and analysis.


Statistical test
----
To reproduce the statistical results 
shown in Mele *et al.* [1], the following command is employed.
```shell
python cli.py --operation statistical_study
```

Train on random instances
-----
```shell
python cli.py --operation train
```

Test on TSPLIB instances
----
```shell
python cli.py --operation solve_TSPLIB
```

References
-----
<a id="1">[1]</a>
Mele, U. J., Gambardella, L. M., and Montemanni, R. (2021).
A New Constructive Heuristic driven by Machine Learning for the traveling Salesman Problem.
*Algorithms* **2021**, 14, 267. DOI:https://doi.org/10.3390/a14090267

<a id="1">[2]</a>
Vitali, T., Mele, U. J., Gambardella, L. M., and Montemanni, R. (2021).
Machine Learning Constructives and Local Searches for the Travelling Salesman Problem. 
ArXiv preprint. ArXiv:https://arxiv.org/abs/2108.00938

<a id="1">[3]</a>
Mele, U. J., Gambardella, L. M., and Montemanni, R. (2021).
Machine learning approaches for the traveling salesman problem: A survey.
 In 2021 The 8th International Conference on Industrial Engineering and Applications(Europe)
(ICIEA 2021-Europe). Association for Computing Machinery, 
New York, NY, USA, 182–186. DOI:https://doi.org/10.1145/3463858.3463869

<a id="1">[4]</a>
Mele, U. J., Chou, X., Gambardella, L. M., and Montemanni, R. (2021).
Reinforcement Learning and additional rewards for the traveling salesman problem.
 In 2021 The 8th International Conference on Industrial Engineering and Applications(Europe) 
(ICIEA 2021-Europe). Association for Computing Machinery, 
New York, NY, USA, 198–204. DOI:https://doi.org/10.1145/3463858.3463885


Cite
----
```buildoutcfg
@Article{a14090267,
AUTHOR = {Mele, Umberto Junior and Gambardella, Luca Maria and Montemanni, Roberto},
TITLE = {A New Constructive Heuristic Driven by Machine Learning for the Traveling Salesman Problem},
JOURNAL = {Algorithms},
VOLUME = {14},
YEAR = {2021},
NUMBER = {9},
ARTICLE-NUMBER = {267},
URL = {https://www.mdpi.com/1999-4893/14/9/267},
ISSN = {1999-4893},
DOI = {10.3390/a14090267}
}
```

## Running the Docker Image with PyTorch CUDA Support

This project's Docker image is built with PyTorch support for CUDA-enabled GPUs. This setup is designed to leverage NVIDIA GPUs for accelerated computing, significantly enhancing performance for deep learning tasks. However, compatibility and functionality are maintained for systems without NVIDIA GPUs as well.

### For Users with NVIDIA GPUs

- **Prerequisites**: Make sure you have the latest NVIDIA drivers and Docker's NVIDIA Container Toolkit (nvidia-docker) installed.
- **Running the Container**: Utilize the `--gpus all` flag with `docker run` to enable GPU support within the container.

### For Users Without NVIDIA GPUs

- The Docker image will **automatically fall back** to using the CPU if no NVIDIA GPU is detected.
- PyTorch is designed to seamlessly operate on CPUs when GPU resources are not available. No additional configuration is needed.
- Performance on CPUs will be adequate for many tasks but expect slower execution compared to GPU environments.


Our goal is to make our project accessible to a broad audience, ensuring functionality across various hardware setups. Should you encounter any issues or have questions about running the Docker container, please feel free to open an issue in this GitHub repository.


## Acknowledgements

This project makes use of the [PyConcorde](https://github.com/jvkersch/pyconcorde) library, an efficient Python wrapper for the Concorde TSP solver, which is the fastest available exact solver for the Traveling Salesman Problem (TSP). We express our sincere gratitude to the developers of PyConcorde for their efforts in creating and maintaining this valuable tool.