# Getting Started with CS4618 and CS4619

## Introduction

In these instructions, you need to work in a terminal.

For Linux/macOS, I assume you know how to open a terminal.

In Windows, type "command prompt" into the search box next to your Start menu.

I will show the prompt as a $.

## Git

The module resources are in a repository on github. One option is to visit [https://github.com/derekgbridge/artificial_intelligence](https://github.com/derekgbridge/artificial_intelligence); click on the green button; choose "Download ZIP". However, I will be incrementally adding new resources or modifying existing resources each week, so you would need to download and unzip each week.

Better is to install git: [https://git-scm.com/](https://git-scm.com/)

Then, as a one-off, you clone my github repository:
```
$ git clone https://github.com/derekgbridge/artificial_intelligence.git
```
This gives you a copy of my repository in a folder called artificial_intelligence.

Then, whenever I add new resources to the repository or change the existing resources, all you need to do is issue a pull request:
```
$ cd artificial_intelligence
$ git pull
```

## Installation of Python packages

1. Install Python3 if you don't already have it. You also need pip and venv but these are part of the latest installations of Python.

2. Go into your folder:
```
$ cd artificial_intelligence
```

3. If you have an M1 Mac, then you need to follow different instructions in order to install tensorflow. Try these: [https://betterdatascience.com/install-tensorflow-2-7-on-macbook-pro-m1-pro/](https://betterdatascience.com/install-tensorflow-2-7-on-macbook-pro-m1-pro/). You will still need to install jupyter, matplotlib, numpy, pandas, scipy, sklearn, seaborn. I later got a numpy import error and needed a complete re-install: [https://nkaushik.com/python/numpy-importerror-c-extensions-failed/](https://nkaushik.com/python/numpy-importerror-c-extensions-failed/)

Otherwise, create a Python virtual environment. E.g. at the command prompt, type:
```
$ python3 -m venv venv # on Linux/macOS
$ python -m venv venv # on Windows
```
This is going to mean that additional Python packages that we install are only applied to this environment.  Installing additional packages into an environment is good practice. It enables you to have lots of different projects with their own environments, without them conflicting with each other.

4. Activate the virtual environment by typing:
```
$ source venv/bin/activate # on Linux/macOS
$ .\venv\Scripts\activate # on Windows
```
If activation is successful, you'll see the name of the environment before the prompt:
```
(venv) $
```

5. Install the packages we need by typing:
```
(venv) $ python3 -m pip install -U jupyter matplotlib numpy pandas scipy scikit-learn seaborn tensorflow # on Linux/macOS
(venv) $ python -m pip install -U jupyter matplotlib numpy pandas scipy scikit-learn seaborn tensorflow # on Windows
```

6. Check they are installed by typing:
```
(venv) $ python3 -c "import jupyter, matplotlib, numpy, pandas, scipy, sklearn, seaborn, tensorflow" # on Linux/macOS
(venv) $ python -c "import jupyter, matplotlib, numpy, pandas, scipy, sklearn, seaborn, tensorflow" # on Windows
```
Make sure there are no error messages.

7. Deactivate the virtual environment either by closing the terminal or by typing:
```
(venv) $ deactivate # on Linux/macOS
(venv) $ .\venv\Scripts\deactivate # on Windows
```
If you are successful, the environment name disappears from the prompt:
```
$
```

If you have problems with the above, then note that you can use Google Colab for this module instead.

## Launching Jupyter Notebooks

1. Go into your folder:
```
$ cd artificial_intelligence
```

2. Activate the virtual environment, as you did in (4) above. A classic error is to forget to do this. (M1 Mac people: you installed conda, and so you activate using the "conda activate" command.)

3. Run Jupyter notebooks by typing:
```
(venv) $ jupyter notebook # on Linux/macOS
(venv) $ jupyter-notebook # on Windows
```

4. When you have finished using the Jupyter notebook, deactivate the virtual environment. See (9) above.

## Working with Jupyter Notebooks

When you launch Jupyter Notebooks, you are, in fact, starting a local server, i.e. on your machine. 

You will also find that a web page opens in your web browser. As you interact with this web page, your requests are in fact being sent to the local server and its responses are sent back to the browser and used to update the page.

The URL of this page will be (something like) http://localhost:8889/tree. It lists the contents of your artificial_intelligence folder. Click until you get to the folder where you want to do your work. 

If you have any existing Jupyter notebooks, you will see them with file extension .ipynb. Clicking on them opens them in a new tab. 

Alternatively, you can create a new Jupyter notebook. To do this, choose New > Python 3. Again it opens in a new tab. One thing you will want to do at some point is choose File > Rename to change the name of your new notebook from Untitled.ipynb to something more memorable.

Jupyter notebooks mix text and code and are stored in a JSON format. They are structured around the idea of cells. A new notebook comprises one cell. You can see the cell type, e.g. code or markdown, and change it using the dropdown menu on the toolbar. 

By default, new cells are always code cells. In a code cell, you can type Python expressions and statements and run them. To actually execute the Python expression and statements in a cell, the cell must have focus, and then press Shift+Enter. 

When typing Python expressions and statements, pressing the tab key gives you autocompletion suggestions and pressing Shift+tab shows you the docstring for the function or method that you are typing. Typing ? at the end of a Python function name opens a panel that contains the documentation for that function. Typing ?? shows you its source code!

If you use the dropdown to change the cell type to Markdown then you can type text. You can include HTML or markdown to format the text nicely, e.g. to do headings, to do lists, to include images, etc. (I also type LaTeX maths into these cells, which is cool. But this is a skill that you as a student do not need in these modules.) Press Shift+Enter to render the cell after you have finished typing in it.

You will get accustomed to using the menu and toolbar to move cells around, insert new cells above or below the current cell, to delete cells, and to run more than one cell at a time. For example, if you choose Cell > Run All, Jupyter will run all the cells in your notebook from first to last (or from first as far as your first error!). 

If execution takes some time, you will know that Jupyter is busy because the little circle on the right will be filled-in.

You can save your notebook using the toolbar. But, in fact, Jupyter automatically saves your notebook periodically. And, if you try to close the page before everything is saved, it will prompt you to save.

As mentioned, the page that opens when you launch Jupyter notebooks has a URL (something like) http://localhost:8889/tree. If you change this to http://localhost:8889/lab, it opens a simplistic IDE, called Jupyter Labs, which some people prefer.

Finally, when you're done and you close this tab in your browser, it's a good idea to also kill the server. In the terminal, enter Ctrl+C.

## Google Colab

You can run in the cloud instead. Got to Google colab. You can create or upload Jupyter notebooks.
 
You can choose a runtime, where you can ask for a GPU.

If you have your own datasets, copy them to your Google Drive.

Then in your Jupyter notebook, include a cell that contains the following:
```python
from google.colab import drive
drive.mount('/content/drive')
```
When you execute this cell, Colab will show you a URL. Go to that URL (it may prompt you to log in) and it will give an authorization code which you paste back into the notebook. This then allows the rest of the notebook to read files in the usual Python way but from Google Drive using pathnames that start with "/content/drive/My Drive/".

One problem with Colab is that it disconnects you if you don't interact with it for 90 minutes (even if something is running) and after 12 hours, even if you are interacting with it.

Some possible solution are here: [https://stackoverflow.com/questions/57113226/how-to-prevent-google-colab-from-disconnecting](https://stackoverflow.com/questions/57113226/how-to-prevent-google-colab-from-disconnecting) But Google keep changing things: solutions that used to work can stop working. If you find one that works, share it with the class!


