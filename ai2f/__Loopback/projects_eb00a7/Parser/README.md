
<h1 align="center">
Parser for G Code
</h1>

<p align="center">
    This project is part of the Embarked Systems Course from the department of Mechatronics of the University of São Paulo (USP).
    It is a G code parser built with ANTLR in Python. The main goals of the project were to learn to build a language parser and test it.
</p>

## Features
[//]: # (Add the features of your project here:)

- **ANTLR** — is a powerful parser generator for reading, processing, executing, or translating structured text or binary files
- **unittest** — unit testing framework

## Requirements

- **Java 1.7** or higher;
- ANTLR installed and set up.

To install and setup (and get a better understanding of ANTLR if you want) ANTLR refer to [this guide](https://tomassetti.me/antlr-mega-tutorial/#chapter17), which is a complete guide on ANTLR.

## Getting started

1. To parse the "testeG.txt" file into "output.txt" file:
```bash
python main.py testeG.txt
```
2. To test the parser:
```bash
python -m unittest testcode2Parser.py
```

