# Robust Estimation for Center Parameter via f-GANs.
This repository provides a PyTorch implementation of **[Chao Gao, Jiyi Liu, Yuan Yao and Weizhi Zhu, "
Robust Estimation and Generative Adversarial Nets"](https://arxiv.org/abs/1810.02030).**

## Environment
* Python 3.6
* [PyTorch 0.4.1](http://pytorch.org/)

## Files
This repository includes the following files,
* `fgan.py`: This is the main class for data generating process of Huber's contamination model and training process via f-GANs.
* `network.py`: This is the network structure of Generator, GenenatorXi and Discriminator, where GeneratorXi is used for the family of elliptical distribution.
* `data_loader.py`: Dataset preparation.
* `Demo.ipynb`: This is a notebook demo illustrating the usage of the code. It includes two core examples that **known** Gaussian type distribution and **unknown** elliptical type distribution (Cauchy in this demo). 