# `supFunSim`


This repository contains code associated with the paper [MV-PURE Spatial Filters Applicable to EEG/MEG Source Reconstruction]() by Tomasz Piotrowski ([@metalipa](https://github.com/metalipa)), Jan Nikadon ([@nikadon](https://github.com/nikadon)), and David Gutierrez, refactored by Krzysztof Rykaczewski ([@krykaczewski](https://github.com/krykaczewski)) from Neurocognitive Laboratory at Nicolaus Copernicus University, Torun, Poland. In the paper, there is a new method for reconstruction of sources of brain activity and reconstruction of EEG signal.

However, neuroscience frameworks like **FieldTrip** or **Brainstorm** does not support most reconstruction filters available in the scientific literature. Lack of a cohesive environment for tests and sophisticated assumptions about the generated time series that none of existed libraries meet motivated us to write our own framework for this purpose.

The library was written in **Matlab**, since still it is a language popular among neuroscientists.

While writing, we focused on readability and consistency. In addition, we wanted each module to be independent. To ensure it all as an environment for writing the library, we chose **Jupyter** notebooks.
Notebooks give you the opportunity to work in interactive and collaborative environment.
They typically run environments for languages like Python, R... but there exist extensions for other languages as well. In our project, we used the kernel for **Matlab**.
This environment allows for the application of [metaprogramming](https://en.wikipedia.org/wiki/Metaprogramming) (or more precisely [generative programming](https://en.wikipedia.org/wiki/Automatic_programming#Generative_programming)), which briefly means that **Jupyter** notebooks generate all necessary **Matlab** programs, which are used in the solution to considered problem. However, toolbox is based on original [Org-mode](https://en.wikipedia.org/wiki/Org-mode) file `supFunSim.org`.


# Prerequisites

  * **Matlab** (version 2017R)
  * **FieldTrip** toolbox (version 20150227)
  * **MVARICA** toolbox (version 20080323)
  * **ARfit** toolbox (version 20060713)


# How to install framework


In the basic form, just unpack the file `notebooks/supFunSim.zip`. It is convenient to do this to the directory with all toolboxes, because then you can easily load them to **Matlab**.


# How to run code?

First of all you need to load `supFunSim` toolbox:

```matlab
addpath(genpath('/path/to/supFunSim/']));
```

Afterwards parameters for simulations need to be set

```matlab
parameters = EEGParameters().generate();
```

Choose filters (from the closed list of filters) that will be used for reconstruction

```matlab
filters = [ "LCMV", "MMSE", "ZF", "RANDN", "ZEROS", "EIG-LCMV", ...
            "sMVP_MSE", "sMVP_R", "sMVP_N", "sMVP_NL_MSE", ...
            "sMVP_NL_R", "sMVP_NL_N", "NL" ];
```


We perform the reconstruction process after all selected setups (parameters):
```matlab
reconstruction = EEGReconstruction();
reconstruction = reconstruction.init();
for np = 1:length(parameters)
    parameter = parameters(np);
    reconstruction = reconstruction.setparameters(parameter);
    reconstruction = reconstruction.setsignals();
    reconstruction = reconstruction.setleadfields();
    reconstruction = reconstruction.setpreparations();
    reconstruction = reconstruction.setfilters(filters);
    reconstruction.save();
end
reconstruction = reconstruction.printaverageresults();
```
Please note that `init` is executed only once. Thanks to this, meshes are loaded once and does not burden the memory. In addition, the reconstruction results are saved to a file.

After the reconstruction, we can plot results in the form of a series of drawings, e.g.
```matlab
eegplot = EEGPlotting(reconstruction)
eegplot.plotgausswave()
eegplot.plotMVARzeroingmatrix()
eegplot.plotMVARmodelcoefficientmatrix2()
eegplot.plotPDC2()
```

See toolbox code for detailed function descriptions.


# Opening notebooks

  1. In order to open notebooks please download and install [**Jupyter** notebook](http://jupyter.org) with [Matlab kernel](https://github.com/Calysto/matlab_kernel) (of course you have to have **Matlab** installed on your computer). The easiest way to do it is by executing the following instructions in the command line

```sh
sudo pip install jupyter
sudo pip install matlab_kernel
```

  Alternatively, in order to build whole environment run

```sh
sudo pip install -r requirements.txt
```

  If you are using [Anaconda](https://anaconda.org), please consult [Installing Jupyter](https://test-jupyter.readthedocs.io/en/rtd-theme/install.html#installing-jupyter-experienced-python-developers) with `conda`.

  2. Install [MATLAB Engine API for Python](https://nl.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html). See [system requirements for MATLAB Engine](http://nl.mathworks.com/help/matlab/matlab_external/system-requirements-for-matlab-engine-for-python.html).

  3. In the directory with notebooks (e.g. `/path/to/supFunSim/notebooks/`) run command

```sh
jupyter-notebook
```

  After last command a browser will start with styled file manager. Generally, the above procedure may vary from system to system.


# Installation from notebooks

  * If you want to generate specific `EEG*` class please open it by **Jupyter** and select from the main menu: `Cell > Run All`. It will generate about eighty **Matlab** files/scripts (presumably 82). No further action regarding creating programming environment is needed.
  * Optionally, you can just run `make`. This automation tool has a lot of parameters (so called targets):
    - `everything` (this is default if none target is specified): creates all classes, converts them to `Org-mode`, makes tangled version of library (which is necessary for unit test).
    - `all`: creates all `EEG*` classes.
    - `orgmode`: converts **Jupyter** notebook file into `Org-mode`.
    - `tangle`: generates all **Matlab** scripts from file `supFunSim.org` (tangled version of library).
    - `zip`: creates `zip` archive with all **Matlab** scripts.
    - `single_run`: generates all classes needed for single simulation.
    - `test`: makes test with original implementation.
    - `clean`: cleaning notebooks.
    - `rm`: removing all unnecessary files.
  * Afterwards you can run notebook `RunAll.ipynb` with few examples of usage of written EEG library. You can also see `RunAll.m`.


## Files and directories in this repository

See the directories in this folder: [https://github.com/nikadon/supFunSim/](https://github.com/nikadon/supFunSim/).

- `notebooks/` - **Jupyter** notebooks with code arranged in classes:
    - `supFunSim.zip` - whole framework zipped. You do not need to generate scripts by yourself.
    - `EEGParameters.ipynb` - Generates parameters for simulations. It can be overwritten in order to obtain desired parameters for a sequence of simulations. For that go to file `configurationparameters.m`.
    - `EEGSignalGenerator.ipynb` - Class used to generate signal for forward modelling of sources. In general, it can be overwritten to generate a signal with given properties.
    - `EEGForwardModel.ipynb` - Class with forward model.
    - `EEGReconstruction.ipynb` - Class with methods used in reconstruction. All spatial filters are here. The code also contains a reference to mathematical formulas which can be found in the publication.
    - `EEGPlotting.ipynb` - Class with all plots.
    - `EEGTest.ipynb` - Class for unit tests and validation of code.
    - `RunAll.ipynb` - notebook with example usage of the toolbox.
    - `cc-jupyter2org.sh` - script converting **Jupyter** notebooks to `Org-mode` file.
- `aux_supFunSim.zip` file contains auxiliary functions which should be put in toolbox directory.


## Data sources

Directory `mat/` contains data with brain atlas and head model which were taken from **FieldTrip** and **Brainstorm** toolboxes.


# About EEG Library

  * Library contains several **Jupyter** notebooks implementing solutions to EEG reconstruction problems (each notebook is with one **Matlab** class and auxiliary scripts).
  * The strength of the library is that everything is closed in six classes that are self-contained and all necessary and/or dependent files are created automatically.
  * We have a procedural version written in `Org-mode`, which can be used as a reference for changes in the object oriented version.

# Known issues

  * The above description and trial was made using [Fedora](https://getfedora.org) release 27 under which you can do any of the following to get **Jupyter**:

```sh
sudo dnf install python3
sudo dnf install python3-pip
sudo dnf install notebook
sudo dnf install jupyter-notebook
sudo dnf install python3-notebook
sudo dnf install python3-jupyter-notebook
sudo dnf install matlab_kernel
```

  Under other Linux distribution (and Windows, through the [Ubuntu shell](https://docs.microsoft.com/en-us/windows/wsl/install-legacy)) names of packages can be different and the installation, e.g., may look like:

```sh
sudo apt update
sudo apt install python3.6
sudo apt install python3-pip
sudo apt install jupyter-core
sudo apt install jupyter-notebook
sudo apt install jupyter-nbconvert
sudo pip install matlab-kernel
sudo pip install matlab
jupyter notebook
```

  * The preferred version of **Python** is **3**, since otherwise you could come across the following:

```sh
Error: no module named matlabengineforpython2_7
```

  or

```sh
ImportError: No module named matlab.engine
```


# License

This plugin is licensed under the GPLv3 (or later).

