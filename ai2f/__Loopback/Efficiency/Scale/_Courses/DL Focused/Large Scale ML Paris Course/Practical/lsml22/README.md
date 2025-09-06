# lsml22
Notebooks for the [2022 course on Large Scale Machine Learning at Mines ParisTech](http://cazencott.info/index.php/pages/LSML-22-Large-Scale-Machine-Learning).

## Day 1: Introduction to large scale ML
* If you are familiar with `scikit-learn` (for example, Mines students who had Data Science in their first year or took "Apprentissage artificiel" previously), work on notebook `1_sklearn_at_scale.ipynb`.
* If you are not familiar with `scikit-learn`, you can start with [this notebook](https://github.com/chagaz/ml-notebooks/tree/master/intro-ml-genetics) to get a hang of things. 

## Day 2: Deep learning
* If you have never trained convolutional neural networks on `keras`, start with [this notebook](https://colab.research.google.com/drive/1IZPUwaNeE5HpI-xn2PqOwnLLp-U3e9FL?usp=sharing) to train a LeNet Deep Convolutional Network on MNIST. 
* Practice transfer-learning using a standard ConvNet pre-trained on ImageNet with [this notebook](https://colab.research.google.com/drive/1SadnM3Hnklj5vQQX9N4gIWNmt_0ITHwo?usp=sharing)
* Practice unsupervised deep learning with auto-encoders and GAN with [this notebook](https://github.com/JosephGesnouin/Unsup_gener_nets/blob/main/TP_modeles_g%C3%A9n%C3%A9ratifs.ipynb)
Beginners should work on TP1 (LeNet on MNIST), and then at least begin TP3 (Deep Generative Models)
Students who have already practised with Deep ConvNets should work essentially on TP3. TP2 may be useful only for those who have never practised Transfer Learning.

## Day 3: Stochastic gradient descent
Work on notebook `3_stochastic_gradient_descent.ipynb`.

## Day 4: Deep reinforcement learing
Instructions inside `4_deep_reinforcement_learning.pdf`. The notebook is [here](https://githubtocolab.com/telejesus2/tprl-lsml-2022/blob/main/tprl_lsml_2022.ipynb).

## Setup
To run the notebooks, you will need Python, [Jupyter](https://jupyter.org/) (either JupyterLab or Jupyter Notebook), and number of Python librairies. The easiest way to install of this is to use [conda](https://docs.conda.io/en/latest/) and set up an environment specific to this course using the file `package_list.yml`. To this end, you can either:
* if you prefer graphical user interfaces: (1) [install Anaconda](https://docs.anaconda.com/anaconda/install/index.html) and (2) follow the instructions under "Importing an environment" [of the tutorial](https://docs.anaconda.com/anaconda/navigator/tutorials/manage-environments/) to import the environment in `package_list.yml`;
* if you prefer the command line: (1) [install conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html) and (2) use the following instructions in the command line:
```bash
   conda env create -f package_list.yml -n lsml
   conda activate lsml
```

## Course materials
You can find course materials here: https://cloud.mines-paristech.fr/index.php/s/eV67rL3ySnN4JIn 
